//
//  ViewController.swift
//  MapViewApp
//
//  Created by Sabrina Wilbert on 1/5/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var manager = CLLocationManager()
    var latitude = 47.620513
    var longitude = -122.349329
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let span = MKCoordinateSpanMake(0.04, 0.04)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let objectAnn = MKPointAnnotation()
        objectAnn.coordinate = pinLocation
        objectAnn.title = "Space Needle"
        objectAnn.subtitle = "400 Broad st."
        self.mapView.addAnnotation(objectAnn)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func mapType(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
        
            mapView.mapType = MKMapType.standard
        
        }
        
        if segmentControl.selectedSegmentIndex == 1 {
        
            mapView.mapType = MKMapType.satellite
        
        }
        
        if segmentControl.selectedSegmentIndex == 2 {
        
            mapView.mapType = MKMapType.hybrid
        
        }
    }
    
    
    @IBAction func locateMe(_ sender: Any) {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userlocation: CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
   

    @IBAction func directions(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(latitude),\(longitude)")!)
        
        
    }

}

