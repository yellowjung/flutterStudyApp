import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main/favoritePage.dart';
import 'main/mapPage.dart';
import 'main/settingPage.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin{
  TabController? controller;
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://modu-95c5e-default-rtdb.firebaseio.com/';
  String? id;

  @override
  void initState(){
    super.initState();
    controller = TabController(length: 3, vsync: this);
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference();
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          MapPage(
            databaseReference: reference,
            id: id,
          ),
          FavoritePage(),
          SettingPage()
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.map),
          ),
          Tab(
            icon: Icon(Icons.stars),
          ),
          Tab(
            icon: Icon(Icons.settings)
          )
        ],
        labelColor: Colors.amber,
        indicatorColor: Colors.deepOrangeAccent,
        controller: controller,
      ),
    );
  }
}