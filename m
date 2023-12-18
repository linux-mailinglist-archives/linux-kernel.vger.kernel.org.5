Return-Path: <linux-kernel+bounces-3237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086D88169AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88A7282518
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A211C92;
	Mon, 18 Dec 2023 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="frV8VxJ3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D73125AD;
	Mon, 18 Dec 2023 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1702890503;
	bh=m7qO1p3j1oxEbL5lO2X431Gjyt9cwIdJN9kwQp3mg1M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=frV8VxJ3ZGHZfPeSxqzTK6U5fS94u1Gt57rDs2HonTcK1VPv+E6TjbldwLXqtLQU5
	 fZJF4lu2owDrhMvf9ypSdOXVQY9IhTawVhSnRt1VKTSktLnqIrs7hzOadcaQXNsphA
	 BxRGuGWagC5GpAHArbiOXBhxvI5hs88kj2G7j4Onobt5TQfAhiXQh+gzTjcxAFkClW
	 CBH7OcAjWou2vrnC8/UoWkS8DZRKU332WviF6K4iDxCzPb8R9+JOuKVC/bt95jeWPA
	 YRjY/rLJrIxq9jOcqftj0nwliUhYKscXUrZF4m0hg7SuXVsnzz8K2ZhluItnWIVxp4
	 3LfHdoJRQyUqA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Crescent CY Hsieh
	<crescentcy.hsieh@moxa.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, "brenda.streiff@ni.com"
	<brenda.streiff@ni.com>, Tomas Paukrt <tomaspaukrt@email.cz>
Subject: RE: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Topic: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Index: AQHaH/jBESSZN4JU2UOxi81YCMKNnLCN1MYggA6QRICABHVPgIADOxKAgASJVgCAABWukIAAJ8AAgAASapCAAgidgIAD4XiA
Date: Mon, 18 Dec 2023 09:08:15 +0000
Message-ID: <ca3374724da24e38b611c24fb4fd57d1@dh-electronics.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
 <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
 <ed087928-43ac-42bc-8e4d-d1632db451b9@gmx.de>
 <cc59c5bb16574073ba8b2bf9bc59bc7c@dh-electronics.com>
 <1b0af20c-8a2c-46ba-ab2e-d598b65fd0c1@gmx.de>
In-Reply-To: <1b0af20c-8a2c-46ba-ab2e-d598b65fd0c1@gmx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogTGlubyBTYW5maWxpcHBvIFttYWlsdG86TGlub1NhbmZpbGlwcG9AZ214LmRlXQ0KU2Vu
dDogRnJpZGF5LCBEZWNlbWJlciAxNSwgMjAyMyAxMToxNCBQTQ0KPiANCj4gSGkgQ2hyaXN0b3Bo
LA0KPiANCg0KSGkgTGlubywNCg0KPiBPbiAxNC4xMi4yMyAxNTo1MCwgQ2hyaXN0b3BoIE5pZWRl
cm1haWVyIHdyb3RlOg0KPiANCj4+DQo+PiBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gZGlzdGlu
Z3Vpc2gsIGJlY2F1c2UgZm9yIGEgZnVsbCBkdXBsZXggUlMtNDg1DQo+PiB0cmFuc2NlaXZlciBh
bHNvIG5lZWRzIFJUUyBjb250cm9sLiBGb3IgZXhhbXBsZSBsb29rIGF0IHRoZSBmdWxsIGR1cGxl
eA0KPj4gUlMtNDg1IHRyYW5zY2VpdmVyIEFETTM0OTFFIFsxXS4gSXQncyBhIGZ1bGwgZHVwbGV4
IHRyYW5zY2VpdmVyIChBL0IgYW5kIFovWSkNCj4+IHRoYXQgaGFzIERFIChEcml2ZXIgZW5hYmxl
KSBhbmQgREkgKERyaXZlciBJbnB1dCkgcGlucyBmb3IgY29udHJvbGxpbmcgVFguIEkNCj4+IHRo
aW5rIHRoZSBSUy00ODUgbWFzdGVyIGRvZXNuJ3QgbmVlZCBpdC4gVGhlIERFIHBpbiBjb3VsZCBh
bHNvIGJlIHNldA0KPj4gcGVybWFuZW50bHkgaGlnaC4gQnV0IGlmIHdlIGhhdmUgbW9yZSB0aGFu
IG9uZSBSUy00ODUgc2xhdmVzIGl0J3MgbmVlZGVkIHRvDQo+PiBhdm9pZCBibG9ja2luZyBvZiBl
YWNoIG90aGVyIG9uIHRoZSByZWNlaXZpbmcgd2lyZXMgb2YgdGhlIFJTLTQ4NSBtYXN0ZXIuDQo+
Pg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIFNvIHdoaWxlIHN0aWxsIG5lZWRl
ZCBmb3IgdGhlIHNsYXZlcywgaW4gY2FzZSBvZiB0aGUNCj4gUlM0ODUgbWFzdGVyIHRoZSBSVFMg
Y29udHJvbCBpcyBub3QgbmVlZGVkLCByaWdodD8NCg0KWWVzLCBmb3IgdGhlIFJTLTQ4NSAoNC13
aXJlKSBtYXN0ZXIgaXQgaXNuJ3QgbmVlZGVkLCBidXQgSSB0aGluayBvbiB0aGUgZHJpdmVyDQps
ZXZlbCBpdCBpcyBiZXR0ZXIgbm90IHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gbWFzdGVyIGFuZCBz
YWx2ZS4gU28gdXNlIGFsc28gUlRTDQpjb250cm9sIGZvciBlbmFibGluZyBzZW5kaW5nIG9uIGEg
UlMtNDg1ICg0LXdpcmUpIG1hc3RlciBkZXZpY2UuDQoNCj4gSXMgdGhpcyBzb21ldGhpbmcgdGhh
dCB1c2Vyc3BhY2Ugc2hvdWxkIGJlIGFibGUgdG8gY29uZmlndXJlPyBJdCBjb3VsZCBiZSBzZXQN
Cj4gYnkgY2xlYXJpbmcgYm90aCB0aGUgUlRTX09OX1NFTkQgYW5kIFJUU19BRlRFUl9TRU5EIGZs
YWcgKG9ubHkgaWYgdGhlIGRyaXZlcg0KPiBzdXBwb3J0cyB0aGlzIHNwZWNpYWwgUlM0ODUgbW9k
ZSwgb2YgY291cnNlKS4NCg0KTm8sIEkgdGhpbmsgaXQgc2hvdWxkbid0IGNvbmZpZ3VyZSBpbiB1
c2Vyc3BhY2UuIFRyZWF0aW5nIGEgUlMtNDg1ICg0LXdpcmUpIG1hc3Rlcg0KZGV2aWNlIGluIHRo
ZSBkcml2ZXIgYXMgYSBzbGF2ZSAod2l0aCBSVFMgY29udHJvbCkgaGFzIHRoZSBmb2xsb3dpbmcg
YWR2YW50YWdlczoNCi0gTGVzcyBjb25mdXNpb24gaW4gdXNlciBzcGFjZSAobm8gYWRkaXRpb25h
bCBzZXR0aW5nIGF2YWlsYWJsZSkuDQotIE9ubHkgYnVzIHRvcG9sb2d5IGRldGVybWluZXMgd2hv
IGlzIG1hc3RlciBhbmQgc2FsdmUuDQotIFNhdmUgZW5lcmd5LCBiZWNhdXNlIERFIGlzIG9ubHkg
ZHJpdmVuIGR1cmluZyBzZW5kaW5nLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K

