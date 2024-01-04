Return-Path: <linux-kernel+bounces-17311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46981824B42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE58CB24149
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7572D02F;
	Thu,  4 Jan 2024 22:57:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8292D02B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-52-8HlQ54MTNZ20SPJ_9fcAIg-1; Thu, 04 Jan 2024 22:57:24 +0000
X-MC-Unique: 8HlQ54MTNZ20SPJ_9fcAIg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Jan
 2024 22:57:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 4 Jan 2024 22:57:10 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Zack Rusin' <zack.rusin@broadcom.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann
	<arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, Raul Rangel
	<rrangel@chromium.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] input/vmmouse: Fix device name copies
Thread-Topic: [PATCH v2] input/vmmouse: Fix device name copies
Thread-Index: AQHaPsvFRvb2B19ESUahla1XzNFio7DKQqgg
Date: Thu, 4 Jan 2024 22:57:10 +0000
Message-ID: <645d8e19494d4a27b2ae775fee56e252@AcuMS.aculab.com>
References: <20231127204206.3593559-1-zack@kde.org>
 <20240104050605.1773158-1-zack.rusin@broadcom.com>
In-Reply-To: <20240104050605.1773158-1-zack.rusin@broadcom.com>
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

RnJvbTogWmFjayBSdXNpbg0KPiBTZW50OiAwNCBKYW51YXJ5IDIwMjQgMDU6MDYNCj4gDQo+IE1h
a2Ugc3VyZSB2bW1vdXNlX2RhdGE6OnBoeXMgY2FuIGhvbGQgc2VyaW86OnBoeXMgKHdoaWNoIGlz
IDMyIGJ5dGVzKQ0KPiBwbHVzIGFuIGV4dHJhIHN0cmluZywgZXh0ZW5kIGl0IHRvIDY0Lg0KPiAN
Cj4gRml4ZXMgZ2NjMTMgd2FybmluZ3M6DQo+IGRyaXZlcnMvaW5wdXQvbW91c2Uvdm1tb3VzZS5j
OiBJbiBmdW5jdGlvbiDigJh2bW1vdXNlX2luaXTigJk6DQo+IGRyaXZlcnMvaW5wdXQvbW91c2Uv
dm1tb3VzZS5jOjQ1NTo1Mzogd2FybmluZzog4oCYL2lucHV0MeKAmSBkaXJlY3RpdmUgb3V0cHV0
IG1heSBiZSB0cnVuY2F0ZWQgd3JpdGluZyA3DQo+IGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6
ZSBiZXR3ZWVuIDEgYW5kIDMyIFstV2Zvcm1hdC10cnVuY2F0aW9uPV0NCj4gICA0NTUgfCAgICAg
ICAgIHNucHJpbnRmKHByaXYtPnBoeXMsIHNpemVvZihwcml2LT5waHlzKSwgIiVzL2lucHV0MSIs
DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn4NCj4gZHJpdmVycy9pbnB1dC9tb3VzZS92bW1vdXNlLmM6NDU1Ojk6IG5v
dGU6IOKAmHNucHJpbnRm4oCZIG91dHB1dCBiZXR3ZWVuIDggYW5kIDM5IGJ5dGVzIGludG8gYSBk
ZXN0aW5hdGlvbg0KPiBvZiBzaXplIDMyDQo+ICAgNDU1IHwgICAgICAgICBzbnByaW50Zihwcml2
LT5waHlzLCBzaXplb2YocHJpdi0+cGh5cyksICIlcy9pbnB1dDEiLA0KPiAgICAgICB8ICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gICA0NTYgfCAgICAgICAgICAgICAgICAgIHBzbW91c2UtPnBzMmRldi5zZXJpby0+cGh5cyk7
DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+IA0KPiB2MjogVXNlIHRoZSBleGFjdCBzaXplIGZvciB0aGUgdm1tb3VzZV9kYXRhOjpwaHlz
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaYWNrIFJ1c2luIDx6YWNrLnJ1c2luQGJyb2FkY29tLmNv
bT4NCj4gRml4ZXM6IDhiOGJlNTFiNGZkMyAoIklucHV0OiBhZGQgdm1tb3VzZSBkcml2ZXIiKQ0K
PiBDYzogRG1pdHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPg0KPiBDYzog
QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gQ2M6IFJvYmVydCBKYXJ6bWlrIDxyb2Jl
cnQuamFyem1pa0BmcmVlLmZyPg0KPiBDYzogUmF1bCBSYW5nZWwgPHJyYW5nZWxAY2hyb21pdW0u
b3JnPg0KPiBDYzogbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+IENjOiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4gIyB2NC4xKw0KPiAtLS0NCj4gIGRyaXZlcnMvaW5wdXQvbW91c2Uvdm1t
b3VzZS5jIHwgOCArKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L21vdXNlL3Zt
bW91c2UuYyBiL2RyaXZlcnMvaW5wdXQvbW91c2Uvdm1tb3VzZS5jDQo+IGluZGV4IGVhOWVmZjdj
ODA5OS4uNzQxMzE2NzNlMmYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lucHV0L21vdXNlL3Zt
bW91c2UuYw0KPiArKysgYi9kcml2ZXJzL2lucHV0L21vdXNlL3ZtbW91c2UuYw0KPiBAQCAtNjMs
NiArNjMsOCBAQA0KPiAgI2RlZmluZSBWTU1PVVNFX1ZFTkRPUiAiVk13YXJlIg0KPiAgI2RlZmlu
ZSBWTU1PVVNFX05BTUUgICAiVk1Nb3VzZSINCj4gDQo+ICsjZGVmaW5lIFZNTU9VU0VfUEhZU19O
QU1FX1BPU1RGSVhfU1RSICIvaW5wdXQxIg0KPiArDQo+ICAvKioNCj4gICAqIHN0cnVjdCB2bW1v
dXNlX2RhdGEgLSBwcml2YXRlIGRhdGEgc3RydWN0dXJlIGZvciB0aGUgdm1tb3VzZSBkcml2ZXIN
Cj4gICAqDQo+IEBAIC03Miw3ICs3NCw4IEBADQo+ICAgKi8NCj4gIHN0cnVjdCB2bW1vdXNlX2Rh
dGEgew0KPiAgCXN0cnVjdCBpbnB1dF9kZXYgKmFic19kZXY7DQo+IC0JY2hhciBwaHlzWzMyXTsN
Cj4gKwljaGFyIHBoeXNbc2l6ZW9mX2ZpZWxkKHN0cnVjdCBzZXJpbywgcGh5cykgKw0KPiArCQkg
IHN0cmxlbihWTU1PVVNFX1BIWVNfTkFNRV9QT1NURklYX1NUUildOw0KPiAgCWNoYXIgZGV2X25h
bWVbMTI4XTsNCj4gIH07DQo+IA0KPiBAQCAtNDUyLDcgKzQ1NSw4IEBAIGludCB2bW1vdXNlX2lu
aXQoc3RydWN0IHBzbW91c2UgKnBzbW91c2UpDQo+ICAJcHNtb3VzZS0+cHJpdmF0ZSA9IHByaXY7
DQo+IA0KPiAgCS8qIFNldCB1cCBhbmQgcmVnaXN0ZXIgYWJzb2x1dGUgZGV2aWNlICovDQo+IC0J
c25wcmludGYocHJpdi0+cGh5cywgc2l6ZW9mKHByaXYtPnBoeXMpLCAiJXMvaW5wdXQxIiwNCj4g
KwlzbnByaW50Zihwcml2LT5waHlzLCBzaXplb2YocHJpdi0+cGh5cyksDQo+ICsJCSAiJXMiIFZN
TU9VU0VfUEhZU19OQU1FX1BPU1RGSVhfU1RSLA0KPiAgCQkgcHNtb3VzZS0+cHMyZGV2LnNlcmlv
LT5waHlzKTsNCg0KTm90d2l0aHN0YW5kaW5nIGFueSBlcnJvciAoZml4ZWQpIG9yIG5vdCBmcm9t
IHRoZSBnY2MvYnVpbGQgcm9iZXJ0DQpvciBzcGFyc2UgdGhhdCAnZml4JyBpcyBlbnRpcmVseSBo
b3JyaWJsZS4NCg0KUmVsYXRlZCBJJ20gZ3Vlc3NpbmcgdGhhdCBkZXZfbmFtZVsxMjhdIGlzIGVp
dGhlciBsaWtlbHkgdG8NCmJlIHRydW5jYXRlZCBvciBtYXNzaXZlbHkgZmFyIHRvbyBsb25nPw0K
DQpUaGVyZSBhcmUgYSBmZXcgd2F5IHRvIGdldCBnY2MgdG8gU1RGVSA6LSkNCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==


