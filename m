Return-Path: <linux-kernel+bounces-6603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D5E819ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B434B259E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DE31DA50;
	Wed, 20 Dec 2023 08:48:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7491DA34
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-10-pIjzM-T2PeCd5figLgR3AA-1; Wed, 20 Dec 2023 08:48:16 +0000
X-MC-Unique: pIjzM-T2PeCd5figLgR3AA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Dec
 2023 08:48:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Dec 2023 08:48:02 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Steven Rostedt' <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
	<tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, "Kent
 Overstreet" <kent.overstreet@gmail.com>
Subject: RE: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Thread-Topic: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Thread-Index: AQHaMqz+dUnedT4aZk+oEbt0Pk2DGrCx3FFA
Date: Wed, 20 Dec 2023 08:48:02 +0000
Message-ID: <84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com>
References: <20231219185414.474197117@goodmis.org>
 <20231219185628.009147038@goodmis.org>
In-Reply-To: <20231219185628.009147038@goodmis.org>
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

RnJvbTogU3RldmVuIFJvc3RlZHQNCj4gU2VudDogMTkgRGVjZW1iZXIgMjAyMyAxODo1NA0KPiBG
cm9tOiAiVHp2ZXRvbWlyIFN0b3lhbm92IChWTXdhcmUpIiA8dHouc3RveWFub3ZAZ21haWwuY29t
Pg0KPiANCj4gQ3VycmVudGx5IHRoZSBzaXplIG9mIG9uZSBzdWIgYnVmZmVyIHBhZ2UgaXMgZ2xv
YmFsIGZvciBhbGwgYnVmZmVycyBhbmQNCj4gaXQgaXMgaGFyZCBjb2RlZCB0byBvbmUgc3lzdGVt
IHBhZ2UuIEluIG9yZGVyIHRvIGludHJvZHVjZSBjb25maWd1cmFibGUNCj4gcmluZyBidWZmZXIg
c3ViIHBhZ2Ugc2l6ZSwgdGhlIGludGVybmFsIGxvZ2ljIHNob3VsZCBiZSByZWZhY3RvcmVkIHRv
DQo+IHdvcmsgd2l0aCBzdWIgcGFnZSBzaXplIHBlciByaW5nIGJ1ZmZlci4NCj4gDQouLi4NCj4g
LQlucl9wYWdlcyA9IERJVl9ST1VORF9VUChzaXplLCBCVUZfUEFHRV9TSVpFKTsNCj4gKwkvKiBE
ZWZhdWx0IGJ1ZmZlciBwYWdlIHNpemUgLSBvbmUgc3lzdGVtIHBhZ2UgKi8NCj4gKwlidWZmZXIt
PnN1YmJ1Zl9zaXplID0gUEFHRV9TSVpFIC0gQlVGX1BBR0VfSERSX1NJWkU7DQo+ICsNCj4gKwkv
KiBNYXggcGF5bG9hZCBpcyBidWZmZXIgcGFnZSBzaXplIC0gaGVhZGVyICg4Ynl0ZXMpICovDQo+
ICsJYnVmZmVyLT5tYXhfZGF0YV9zaXplID0gYnVmZmVyLT5zdWJidWZfc2l6ZSAtIChzaXplb2Yo
dTMyKSAqIDIpOw0KPiArDQo+ICsJbnJfcGFnZXMgPSBESVZfUk9VTkRfVVAoc2l6ZSwgYnVmZmVy
LT5zdWJidWZfc2l6ZSk7DQoNCldoaWxlIG5vdCBuZXcsIGRvZXMgdGhpcyByZWFsbHkgbWFrZSBh
bnkgc2Vuc2UgZm9yIHN5c3RlbXMgd2l0aCA2NGsgcGFnZXM/DQpXb3VsZG4ndCBpdCBiZSBiZXR0
ZXIgdG8gaGF2ZSB1bml0cyBvZiA0az8NCg0KLi4uDQo+IEBAIC01MTAyLDE0ICs1MTEwLDE0IEBA
IHVuc2lnbmVkIGxvbmcgcmluZ19idWZmZXJfc2l6ZShzdHJ1Y3QgdHJhY2VfYnVmZmVyICpidWZm
ZXIsIGludCBjcHUpDQo+ICB7DQo+ICAJLyoNCj4gIAkgKiBFYXJsaWVyLCB0aGlzIG1ldGhvZCBy
ZXR1cm5lZA0KPiAtCSAqCUJVRl9QQUdFX1NJWkUgKiBidWZmZXItPm5yX3BhZ2VzDQo+ICsJICoJ
YnVmZmVyLT5zdWJidWZfc2l6ZSAqIGJ1ZmZlci0+bnJfcGFnZXMNCj4gIAkgKiBTaW5jZSB0aGUg
bnJfcGFnZXMgZmllbGQgaXMgbm93IHJlbW92ZWQsIHdlIGhhdmUgY29udmVydGVkIHRoaXMgdG8N
Cj4gIAkgKiByZXR1cm4gdGhlIHBlciBjcHUgYnVmZmVyIHZhbHVlLg0KDQpPdmVyZW50aHVzaWFz
dGljIGdsb2JhbCByZXBsYWNlLi4uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


