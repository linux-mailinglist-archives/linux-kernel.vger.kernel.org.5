Return-Path: <linux-kernel+bounces-14176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A28218C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FFA1F22222
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4ECCA78;
	Tue,  2 Jan 2024 09:14:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73534CA6F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-KxmtTKFzMXWzLQ9SE7vhdg-1; Tue, 02 Jan 2024 09:14:30 +0000
X-MC-Unique: KxmtTKFzMXWzLQ9SE7vhdg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 2 Jan
 2024 09:14:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 2 Jan 2024 09:14:15 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guoxin Pu' <pugokushin@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] block: fix length of strscpy()
Thread-Topic: [PATCH] block: fix length of strscpy()
Thread-Index: AQHaPNtiMZZ0F2vqTUGoSDgTJCHi3bDFesXAgABTFoCAAG/DAA==
Date: Tue, 2 Jan 2024 09:14:15 +0000
Message-ID: <25655037ca3e404e9111341ea423f5ce@AcuMS.aculab.com>
References: <20240101175051.38479-2-pugokushin@gmail.com>
 <ed0b9dd45fca4f6e910a9e1ffa756180@AcuMS.aculab.com>
 <c7e29d85-277d-46ae-87ae-bb77dd423652@gmail.com>
In-Reply-To: <c7e29d85-277d-46ae-87ae-bb77dd423652@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogR3VveGluIFB1IA0KPiBTZW50OiAwMiBKYW51YXJ5IDIwMjQgMDI6MzENCj4gDQo+IFRo
YW5rIHlvdSBmb3IgdGhlIHJldmlldy4gU29ycnkgaWYgdGhpcyBpcyB0aGUgZHVwbGljYXRlZCBy
ZXBseSwgYXMgSQ0KPiBkaWRuJ3QgY29uZmlndXJlIG15IG1haWwgY2xpZW50IHRvIHNlbmQgdGV4
dC1vbmx5IG1lc3NhZ2UgYW5kIHRoZQ0KPiBwcmV2aW91cyBtYWlsIHdhcyByZWplY3RlZCBieSB0
aGUgbGlzdC4NCj4gDQo+IE9uIDAyLzAxLzIwMjQgMDU6NDcsIERhdmlkIExhaWdodCB3cm90ZToN
Cj4gPj4gQEAgLTc5LDggKzc5LDggQEAgc3RhdGljIGludCBwYXJzZV9zdWJwYXJ0KHN0cnVjdCBj
bWRsaW5lX3N1YnBhcnQgKipzdWJwYXJ0LCBjaGFyICpwYXJ0ZGVmKQ0KPiA+PiAgIAkJCWdvdG8g
ZmFpbDsNCj4gPj4gICAJCX0NCj4gPj4NCj4gPj4gLQkJbGVuZ3RoID0gbWluX3QoaW50LCBuZXh0
IC0gcGFydGRlZiwNCj4gPj4gLQkJCSAgICAgICBzaXplb2YobmV3X3N1YnBhcnQtPm5hbWUpIC0g
MSk7DQo+ID4+ICsJCWxlbmd0aCA9IG1pbl90KGludCwgbmV4dCAtIHBhcnRkZWYgKyAxLA0KPiA+
PiArCQkJICAgICAgIHNpemVvZihuZXdfc3VicGFydC0+bmFtZSkpOw0KPiA+PiAgIAkJc3Ryc2Nw
eShuZXdfc3VicGFydC0+bmFtZSwgcGFydGRlZiwgbGVuZ3RoKTsNCj4gPiBTaG91bGRuJ3QgdGhh
dCBiZSBhIG1lbWNweSgpIHdpdGggdGhlIG9yaWdpbmFsIGxlbmd0aD8NCj4gPiBTaW5jZSBpdCBs
b29rcyBhcyB0aG91Z2ggdGhlcmUgaXMgc29tZXRoaW5nIGVxdWl2YWxlbnQgdG86DQo+ID4gCQlu
ZXh0ID0gc3RyY2hyKHBhcnRkZWYsICcsJyk7DQo+ID4ganVzdCBhYm92ZT8NCj4gPiBNYXliZSB3
aXRoOg0KPiA+IAkJbmV3X3N1YnBhcnQtPm5hbWVbbGVuZ3RoXSA9ICdcMCc7DQo+ID4gaWYgdGhl
IHRhcmdldCBpc24ndCB6ZXJvIGZpbGxlZCAod2hpY2ggdGhlIHN0cm5jcHkoKSBwcm9iYWJseQ0K
PiA+IHJlbGllZCBvbi4pDQo+IA0KPiBZZXMgdGhhdCB3b3VsZCBiZSBiZXR0ZXIuIEJ1dCBzaW5j
ZSBJJ20gZml4aW5nIHRoZSBpc3N1ZSBjYXVzZWQgYnkgdGhlDQo+IG1lbnRpb25lZCBjb21taXQs
IHdoaWNoIHdhcyBhbiBhY2NlcHRlZCBjaGFuZ2UgdG8gdXNlIHN0cnNjcHkgaW5zdGVhZCBvZg0K
PiBzdHJuY3B5IGFuZCBzZWVtcyBhIHBhcnQgb2YgYSBzZXJpZXMgb2YgY2hhbmdlcyB0byBkbyB0
aGF0LCBJIHRoaW5rDQo+IHRoZXJlIG1pZ2h0IGJlIGEgcmVhc29uIHRoZSBtYWludGFpbmVycyBw
cmVmZXJyZWQgc3Ryc2NweSBvdmVyIHN0cm5jcHkNCj4gb3ZlciBtZW1jcHk/IE90aGVyd2lzZSB3
ZSBjb3VsZCBqdXN0IHJldmVydCB0aGF0IGNvbW1pdCBhbmQga2VlcCB1c2luZw0KPiB0aGUgb3Jp
Z2luYWwgc3RybmNweSArIHNldHRpbmcgTlVMTCBtZXRob2QsIGFuZCB0aGVuIHBvdGVudGlhbGx5
IHN3YXANCj4gc3RybmNweSB3aXRoIG1lbWNweS4NCg0KSSBzdXNwZWN0IHRoZXkgYWNjZXB0ZWQg
dGhlIGNoYW5nZSB3aXRob3V0IHJlYWxpc2luZyBqdXN0IGhvdw0KY3JlYXRpdmUgc29tZSBvZiB0
aGUgc3RybmNweSgpIGNhbGxzIGFyZS4NCldoaWxlIHN0cnNjcHkoKSBpcyBhIGJldHRlciBmdW5j
dGlvbiB0aGFuIHN0cm5jcHkoKSAob3Igc3RybGNweSgpKQ0KZXh0cmVtZSBjYXJlIGhhcyB0byBi
ZSB0YWtlbiB0byBhdm9pZCBhZGRpbmcgYnVncyB0byBjb2RlIHRoYXQNCndhcyBhY3R1YWxseSBm
aW5lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K


