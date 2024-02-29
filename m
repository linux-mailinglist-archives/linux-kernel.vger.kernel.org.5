Return-Path: <linux-kernel+bounces-87645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904186D6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADA01C21D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF420326;
	Thu, 29 Feb 2024 22:34:15 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1825200CD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246055; cv=none; b=MKU44TBP6isQY+wkX4qbN7S7sD+hU+f7ye5iOpc4D48UofPny0kQ4wbrBeFxWfcIyDHYX+BHqgoCCnJE1qXNdsmA4+xnCU6+Q57Wb48T9nLxPn5PEWXdhlFGR41kuRB7u86vB/zyoDvKjoyIWT/es1XqCed3bXp2RrQArl28dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246055; c=relaxed/simple;
	bh=7EALCz77xII392vmdVOlbHTt8w5XLaXfm92K2aKepEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ElyyfbQOLVON3XquJLr0xTGYOYeAZ7C9LNNMgEvBHuRvS1hSB2FIvgPz6sJF4n9XpjQ8ymTMhlo+dl5P2yr49KuL4LlT0qYcuZa2q3j3CrHLYvClrkLvOQ4vrq/Ak5PaWRuJRHyJidmseoAX9W2lWc26VTGsUIwbWcMXdICujSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-q6YXCiPdNqa3VZ3VvtiocQ-1; Thu, 29 Feb 2024 22:34:04 +0000
X-MC-Unique: q6YXCiPdNqa3VZ3VvtiocQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Feb
 2024 22:34:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Feb 2024 22:34:03 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Guenter Roeck <linux@roeck-us.net>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: stackinit unit test failures on m68k
Thread-Topic: stackinit unit test failures on m68k
Thread-Index: AQHaacsEcesp84Z6QEmwBDAFOS1vdLEh6rvg
Date: Thu, 29 Feb 2024 22:34:03 +0000
Message-ID: <c74d249e503d490d9aea4666eb984521@AcuMS.aculab.com>
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
 <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
 <202402271401.CB43AB2E8@keescook>
In-Reply-To: <202402271401.CB43AB2E8@keescook>
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

Li4uDQo+IEl0IGlzIGJhc2ljYWxseSBkb2luZyB0aGlzOg0KPiANCj4gc3RhdGljIHZvaWQgKmZp
bGxfc3RhcnQsICp0YXJnZXRfc3RhcnQ7DQo+IHN0YXRpYyBzaXplX3QgZmlsbF9zaXplLCB0YXJn
ZXRfc2l6ZTsNCj4gDQo+IHN0YXRpYyBub2lubGluZSBpbnQgbGVhZl9jaGFyX2FycmF5X25vbmUo
dW5zaWduZWQgbG9uZyBzcCwgYm9vbCBmaWxsLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgY2hhciAqYXJnKQ0KPiB7DQo+ICAgICAgICAgY2hhciBidWZbMzJd
Ow0KPiAgICAgICAgIHVuc2lnbmVkIGNoYXIgdmFyWzE2XTsNCj4gDQo+ICAgICAgICAgdGFyZ2V0
X3N0YXJ0ID0gJnZhcjsNCj4gICAgICAgICB0YXJnZXRfc2l6ZSA9IHNpemVvZih2YXIpOw0KPiAg
ICAgICAgIC8qDQo+ICAgICAgICAgICogS2VlcCB0aGlzIGJ1ZmZlciBhcm91bmQgdG8gbWFrZSBz
dXJlIHdlJ3ZlIGdvdCBhDQo+ICAgICAgICAgICogc3RhY2sgZnJhbWUgb2YgU09NRSBraW5kLi4u
DQo+ICAgICAgICAgICovDQo+ICAgICAgICAgbWVtc2V0KGJ1ZiwgKGNoYXIpKHNwICYgMHhmZiks
IHNpemVvZihidWYpKTsNCj4gICAgICAgICAvKiBGaWxsIHZhcmlhYmxlIHdpdGggMHhGRi4gKi8N
Cj4gICAgICAgICBpZiAoZmlsbCkgew0KPiAgICAgICAgICAgICAgICAgZmlsbF9zdGFydCA9ICZ2
YXI7DQo+ICAgICAgICAgICAgICAgICBmaWxsX3NpemUgPSBzaXplb2YodmFyKTsNCj4gICAgICAg
ICAgICAgICAgIG1lbXNldChmaWxsX3N0YXJ0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgIChj
aGFyKSgoc3AgJiAweGZmKSB8IGZvcmNlZF9tYXNrKSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICBmaWxsX3NpemUpOw0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgLyogU2lsZW5jZSAibmV2
ZXIgaW5pdGlhbGl6ZWQiIHdhcm5pbmdzLiAqLw0KPiAJZG9fbm90aGluZ19jaGFyX2FycmF5KHZh
cik7DQo+IA0KPiAgICAgICAgIC8qIEV4ZmlsdHJhdGUgInZhciIuICovDQo+ICAgICAgICAgbWVt
Y3B5KGNoZWNrX2J1ZiwgdGFyZ2V0X3N0YXJ0LCB0YXJnZXRfc2l6ZSk7DQo+IA0KPiAgICAgICAg
IHJldHVybiAoaW50KWJ1ZlswXSB8IChpbnQpYnVmW3NpemVvZihidWYpIC0gMV07DQo+IH0NCj4g
DQo+IGFuZCBpdCdzIGNhbGxlZCBhczoNCj4gDQo+IA0KPiAgICAgICAgIGlnbm9yZWQgPSBsZWFm
X2NoYXJfYXJyYXlfbm9uZSgodW5zaWduZWQgbG9uZykmaWdub3JlZCwgMSwgemVybyk7DQo+IAku
Li4NCj4gICAgICAgICBpZ25vcmVkID0gbGVhZl9jaGFyX2FycmF5X25vbmUoKHVuc2lnbmVkIGxv
bmcpJmlnbm9yZWQsIDAsIHplcm8pOw0KPiANCj4gVGhlIGZpcnN0IGNhbGwgcmVtZW1iZXJzIHdo
ZXJlICJ2YXIiIGlzIGluIHRoZSBzdGFjayBmcmFtZSB2aWEgdGhlDQo+IGZpbGxfc3RhcnQgYXNz
aWdubWVudCwgYW5kIHRoZSBzZWNvbmQgY2FsbCByZWNvcmRzIHdoZXJlICJ2YXIiIGlzIHZpYQ0K
PiB0aGUgdGFyZ2V0X3N0YXJ0IGFzc2lnbm1lbnQuDQo+IA0KPiBUaGUgY29tcGxhaW50IGlzIHRo
YXQgaXQgX2NoYW5nZXNfIGJldHdlZW4gdGhlIHR3byBjYWxscy4gLi4uIE9oLCBJDQo+IHRoaW5r
IEkgc2VlIHdoYXQncyBoYXBwZW5lZC4gQmV0d2VlbiB0aGUgdHdvIGNhbGxzLCB0aGUgc3RhY2sg
Z3Jvd3MgKGFuZA0KPiBpcyBmb3Igc29tZSByZWFzb24gbm90IHJlY2xhaW1lZCkgZHVlIHRvIHRo
ZSBLVU5JVCBjaGVja3MgYmV0d2VlbiB0aGUgdHdvDQo+IGxlYWYgY2FsbHMuIFllcywgbW92aW5n
IHRoYXQgZml4ZXMgaXQuDQoNCklzIHRoZSBub2lubGluZSBlbm91Z2ggdG8gc3RvcCBnY2MgZ2Vu
ZXJhdGluZyB0d28gY29waWVzIG9mIHRoZQ0KZnVuY3Rpb24gZm9yIHRoZSBkaWZmZXJlbnQgdmFs
dWVzIG9mICdmaWxsJz8NCg0KWW91IG1pZ2h0IG5lZWQgdG8gY2FsbCB0aHJvdWdoIGEgdm9sYXRp
bGUgZ2xvYmFsIGZ1bmN0aW9uIHBvaW50ZXINCnZhcmlhYmxlPw0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


