Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D1792AE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjIEQoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354056AbjIEJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:32:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A711A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:31:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-245-ommP8AmzMiq0pu9qgEv8Hw-1; Tue, 05 Sep 2023 10:31:51 +0100
X-MC-Unique: ommP8AmzMiq0pu9qgEv8Hw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Sep
 2023 10:31:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Sep 2023 10:31:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
Subject: RE: [PATCH v2] The value may overflow
Thread-Topic: [PATCH v2] The value may overflow
Thread-Index: AQHZ3xnFNLjoHgiM306HccvtrgnILrAL+Rdg
Date:   Tue, 5 Sep 2023 09:31:48 +0000
Message-ID: <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
In-Reply-To: <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMNCj4gU2VudDogMDQgU2VwdGVtYmVyIDIwMjMgMTE6MjQN
Cj4gDQo+IE9uIDkvNC8yMyAwNTo0MiwgRGVuaXMgQXJlZmV2IHdyb3RlOg0KPiA+IFRoZSB2YWx1
ZSBvZiBhbiBhcml0aG1ldGljIGV4cHJlc3Npb24gMSA8PCAoY3B1IC0gc2RwLT5teW5vZGUtPmdy
cGxvKQ0KPiA+IGlzIHN1YmplY3QgdG8gb3ZlcmZsb3cgZHVlIHRvIGEgZmFpbHVyZSB0byBjYXN0
IG9wZXJhbmRzIHRvIGEgbGFyZ2VyDQo+ID4gZGF0YSB0eXBlIGJlZm9yZSBwZXJmb3JtaW5nIGFy
aXRobWV0aWMNCj4gDQo+IFRoZSBwYXRjaCB0aXRsZSBzaG91bGQgaWRlbnRpZnkgbW9yZSBwcmVj
aXNlbHkgaXRzIGNvbnRleHQsIGUuZy46DQo+IA0KPiAic3JjdTogRml4IHNyY3Vfc3RydWN0IG5v
ZGUgZ3JwbWFzayBvdmVyZmxvdyBvbiA2NC1iaXQgc3lzdGVtcyINCj4gDQo+IEFsc28sIGFzIEkg
c3RhdGVkIGluIG15IHJlcGx5IHRvIHRoZSBwcmV2aW91cyB2ZXJzaW9uLCB0aGUgcGF0Y2ggY29t
bWl0DQo+IG1lc3NhZ2Ugc2hvdWxkIGRlc2NyaWJlIHRoZSBpbXBhY3Qgb2YgdGhlIGJ1ZyBpdCBm
aXhlcy4NCg0KQW5kIGlzIHRoZSBhbmFseXNpcyBjb21wbGV0ZT8NCklzIDFVTCByaWdodCBmb3Ig
MzJiaXQgYXJjaHM/Pw0KSXMgNjQgYml0cyBldmVuIGVub3VnaD8/DQoNCglEYXZpZA0KDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiBNYXRoaWV1DQo+IA0KPiANCj4gPg0KPiA+IEZvdW5kIGJ5IExpbnV4
IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBBcmVmZXYgPGFyZWZldkBzd2VtZWwucnU+DQo+ID4g
LS0tDQo+ID4gdjI6IEFkZGVkIGZpeGVzIHRvIHRoZSBzcmN1X3NjaGVkdWxlX2Nic19zbnAgZnVu
Y3Rpb24gYXMgc3VnZ2VzdGVkIGJ5DQo+ID4gTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT4NCj4gPiAgIGtlcm5lbC9yY3Uvc3JjdXRyZWUuYyB8IDQgKyst
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3NyY3V0cmVlLmMgYi9rZXJuZWwvcmN1
L3NyY3V0cmVlLmMNCj4gPiBpbmRleCAyMGQ3YTIzOGQ2NzUuLjZjMThlNjAwNWFlMSAxMDA2NDQN
Cj4gPiAtLS0gYS9rZXJuZWwvcmN1L3NyY3V0cmVlLmMNCj4gPiArKysgYi9rZXJuZWwvcmN1L3Ny
Y3V0cmVlLmMNCj4gPiBAQCAtMjIzLDcgKzIyMyw3IEBAIHN0YXRpYyBib29sIGluaXRfc3JjdV9z
dHJ1Y3Rfbm9kZXMoc3RydWN0IHNyY3Vfc3RydWN0ICpzc3AsIGdmcF90IGdmcF9mbGFncykNCj4g
PiAgIAkJCQlzbnAtPmdycGxvID0gY3B1Ow0KPiA+ICAgCQkJc25wLT5ncnBoaSA9IGNwdTsNCj4g
PiAgIAkJfQ0KPiA+IC0JCXNkcC0+Z3JwbWFzayA9IDEgPDwgKGNwdSAtIHNkcC0+bXlub2RlLT5n
cnBsbyk7DQo+ID4gKwkJc2RwLT5ncnBtYXNrID0gMVVMIDw8IChjcHUgLSBzZHAtPm15bm9kZS0+
Z3JwbG8pOw0KPiA+ICAgCX0NCj4gPiAgIAlzbXBfc3RvcmVfcmVsZWFzZSgmc3NwLT5zcmN1X3N1
cC0+c3JjdV9zaXplX3N0YXRlLCBTUkNVX1NJWkVfV0FJVF9CQVJSSUVSKTsNCj4gPiAgIAlyZXR1
cm4gdHJ1ZTsNCj4gPiBAQCAtODMzLDcgKzgzMyw3IEBAIHN0YXRpYyB2b2lkIHNyY3Vfc2NoZWR1
bGVfY2JzX3NucChzdHJ1Y3Qgc3JjdV9zdHJ1Y3QgKnNzcCwgc3RydWN0IHNyY3Vfbm9kZSAqc25w
DQo+ID4gICAJaW50IGNwdTsNCj4gPg0KPiA+ICAgCWZvciAoY3B1ID0gc25wLT5ncnBsbzsgY3B1
IDw9IHNucC0+Z3JwaGk7IGNwdSsrKSB7DQo+ID4gLQkJaWYgKCEobWFzayAmICgxIDw8IChjcHUg
LSBzbnAtPmdycGxvKSkpKQ0KPiA+ICsJCWlmICghKG1hc2sgJiAoMVVMIDw8IChjcHUgLSBzbnAt
PmdycGxvKSkpKQ0KPiA+ICAgCQkJY29udGludWU7DQo+ID4gICAJCXNyY3Vfc2NoZWR1bGVfY2Jz
X3NkcChwZXJfY3B1X3B0cihzc3AtPnNkYSwgY3B1KSwgZGVsYXkpOw0KPiA+ICAgCX0NCj4gDQo+
IC0tDQo+IE1hdGhpZXUgRGVzbm95ZXJzDQo+IEVmZmljaU9TIEluYy4NCj4gaHR0cHM6Ly93d3cu
ZWZmaWNpb3MuY29tDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

