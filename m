Return-Path: <linux-kernel+bounces-20670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F72982834C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2103289723
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384433CF4;
	Tue,  9 Jan 2024 09:35:48 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F668BA45
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-qvEmLji-Moqj8aLO8yMykw-1; Tue, 09 Jan 2024 09:35:37 +0000
X-MC-Unique: qvEmLji-Moqj8aLO8yMykw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 9 Jan
 2024 09:35:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 9 Jan 2024 09:35:21 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Jiri Slaby
	<jirislaby@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdhYVzf6gAB/b1RA=
Date: Tue, 9 Jan 2024 09:35:21 +0000
Message-ID: <53d06c12ebcf4a87b241ae31b81c3ea6@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
In-Reply-To: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggSmFudWFyeSAyMDI0IDE4OjE5DQo+IA0K
PiBPbiBNb24sIDggSmFuIDIwMjQgYXQgMDM6NDYsIEppcmkgU2xhYnkgPGppcmlzbGFieUBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gICAgQ1BQIFtNXSBkcml2ZXJzL21lZGlhL3BjaS9zb2xv
NngxMC9zb2xvNngxMC1wMm0uaQ0KPiA+IHJlYWwgICAgMG00NSwwMDJzDQo+ID4NCj4gPiAkIGdp
dCByZXZlcnQgODY3MDQ2Y2M3MDI3NzAzZjYwYTQ2MzM5ZmZkZTkxYTE5NzBmMjkwMQ0KPiA+ICAg
IENQUCBbTV0gZHJpdmVycy9tZWRpYS9wY2kvc29sbzZ4MTAvc29sbzZ4MTAtcDJtLmkNCj4gPiBy
ZWFsICAgIDBtMTEsMTMycw0KPiA+DQo+ID4gJCBnaXQgcmV2ZXJ0IDRlYWQ1MzRmYmE0MmZjNGZk
NDExNjMyOTc1MjhkMmFhNzMxY2QxMjENCj4gPiAgICBDUFAgW01dIGRyaXZlcnMvbWVkaWEvcGNp
L3NvbG82eDEwL3NvbG82eDEwLXAybS5pDQo+ID4gcmVhbCAgICAwbTMsNzExcw0KPiANCj4gT3Vj
aC4gWWVhaCwgdGhhdCdzIHVuZm9ydHVuYXRlLiBUaGVyZSdzIGEgbG90IG9mIG5lc3RlZCBuYXN0
eSBtYWNybw0KPiBleHBhbnNpb24gdGhlcmUsIGJ1dCB0aGF0IHRpbWluZyBpcyBleGNlc3NpdmUu
DQo+IA0KPiBTcGFyc2UgYWN0dWFsbHkgY29tcGxhaW5zIGFib3V0IHRoYXQgZmlsZToNCj4gDQo+
ICAgZHJpdmVycy9tZWRpYS9wY2kvc29sbzZ4MTAvc29sbzZ4MTAtcDJtLmM6MzA5OjEzOiBlcnJv
cjogdG9vIGxvbmcNCj4gdG9rZW4gZXhwYW5zaW9uDQo+ICAgZHJpdmVycy9tZWRpYS9wY2kvc29s
bzZ4MTAvc29sbzZ4MTAtcDJtLmM6MzEwOjE3OiBlcnJvcjogdG9vIGxvbmcNCj4gdG9rZW4gZXhw
YW5zaW9uDQo+IA0KPiBhbmQgd2hpbGUgdGhhdCBpcyBhIHNwYXJzZSBsaW1pdGF0aW9uLCBpdCdz
IHN0aWxsIGludGVyZXN0aW5nLiBIYXZpbmcNCj4gdGhhdCBmaWxlIGV4cGFuZCB0byAxMjJNIGlz
IG5vdCBvay4NCj4gDQo+IEluIHRoaXMgY2FzZSwgSSBzdXNwZWN0IHRoZSByaWdodCB0aGluZyB0
byBkbyBpcyB0byBzaW1wbHkgbm90IHVzZQ0KPiBtaW4oKS9tYXgoKSBpbiB0aGF0IGhlYWRlciBh
dCBhbGwsIGJ1dCBkbyBzb21ldGhpbmcgbGlrZQ0KDQpSZXBsYWNpbmcgdGhlIG1heChhLCBtaW4o
YiwgYykpIHdpdGggY2xhbXAoYiwgYSwgYykNCihJIHRoaW5rIHRoYXQgaXMgdGhlIHJpZ2h0IG9y
ZGVyIG9mIHRoZSBhcmdzKQ0Kd291bGQgcHJvYmFibHkgc3RvcCB0aGUgY29tcGxldGUgZXhwbG9z
aW9uLg0KDQpUaGVuIEknbSBwcmV0dHkgc3VyZSBpdCBzaG91bGRuJ3QgYWN0dWFsbHkgYmUgbmVz
dGluZyB0aGUgdHdvDQpkZWZpbmVzLg0KVGhlIGNvZGUgcmVhbGx5IGRvZXNuJ3Qgd2hhdCB0byBl
eHBhbmQgbW9zdCBvZiB0aG9zZSB2ZXJ5IG9mdGVuLg0KSW4gZmFjdCBkb2luZyBzbyBvbmNlIGR1
cmluZyBpbml0IGlzIHByb2JhYmx5IHRoZSByaWdodCB0aGluZyB0byBkby4NCg0KVGhhdCBpcyB0
cnVlIHJlZ2FyZGxlc3Mgb2YgdGhlIGltcGxlbWVudGF0aW9uIG9mIG1pbigpIGFuZCBtYXgoKS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==


