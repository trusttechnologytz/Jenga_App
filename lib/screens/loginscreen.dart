import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jenga_app/screens/dashboard.dart';

import '../services/service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Validation functions
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with login
      String username = _usernameController.text;
      String password = _passwordController.text;

      Services services = Services();
      bool loginSuccessful = await services.signin(username, password);

      if (loginSuccessful) {
        // Navigate to the dashboard if login is successful
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Handle login failure, show an error message or do something else
        print('Login failed. Please check your credentials.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0, left: 10, right: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
                  .withOpacity(0.7), // Adjust the opacity to your liking
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 3,
                    sigmaY: 3), // Adjust the blur intensity to your liking
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 38.0, bottom: 20),
                          child: Text(
                            'Jenga App',
                            style: TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            controller: _usernameController,
                            validator: _validateUsername,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(221, 255, 255, 255),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              hintText: 'Enter Username',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: _validatePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(221, 255, 255, 255))),
                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 38.0),
                          child: SizedBox(
                            width: 150,
                            height: 45.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: MaterialButton(
                                minWidth: 300,
                                color: const Color.fromARGB(221, 255, 255, 255),
                                onPressed:
                                    _handleLogin, // Use the new function for login handling
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(221, 236, 51, 51),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
