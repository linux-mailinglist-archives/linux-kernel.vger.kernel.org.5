Return-Path: <linux-kernel+bounces-10413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3458281D41D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7A11F227CE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475FD302;
	Sat, 23 Dec 2023 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="ber4JF9p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B09D29E;
	Sat, 23 Dec 2023 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703335752;
	bh=2AL9EkMODIBVJGJbx3Gh0BfWjwQ/b5wCzhm/T5+d5/8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ber4JF9pWUjwwgv27824vvfyqJ/0PG/uu6DXJdEMji/c//YHrZiUzOgVQxxaUNJtj
	 dZj3myBmHm4JmPbujggslzrP/oIgXELnBM/ccKqBtmlKreuq0abI06MECT0mA7YXPi
	 kbIqey0IvR38Zgv8zXl9zBu8BU62Pks2wtKmmcm+0lfiCBLUBK0FJ/0a6EYzBiADJ9
	 dMZeT9VuZLMD5XlfMH4nFKTSwapXPIpAdZFKQGDCFpu7lvwIePheLgRoHjD/AzB53I
	 hWDm1p+d7AT8kcd8piWA4yHE9ltsEGTxGaO9jCngCOwY4JGq9LYVHBCc+f4oxgB6TT
	 LSCwDE/3663Pw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Lukas Wunner <lukas@wunner.de>
CC: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
	"brenda.streiff@ni.com" <brenda.streiff@ni.com>, Tomas Paukrt
	<tomaspaukrt@email.cz>
Subject: RE: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Topic: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Index: AQHaH/jBESSZN4JU2UOxi81YCMKNnLCN1MYggA6QRICABHVPgIADOxKAgASJVgCAABWukIALRm2AgAAjTdA=
Date: Sat, 23 Dec 2023 12:49:01 +0000
Message-ID: <f41f5ddcb52140b6a579043a5abce751@dh-electronics.com>
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
 <20231221155305.GA13673@wunner.de>
In-Reply-To: <20231221155305.GA13673@wunner.de>
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

RnJvbTogTHVrYXMgV3VubmVyIFttYWlsdG86bHVrYXNAd3VubmVyLmRlXQ0KU2VudDogVGh1cnNk
YXksIERlY2VtYmVyIDIxLCAyMDIzIDQ6NTMgUE0NCj4gDQo+IE9uIFRodSwgRGVjIDE0LCAyMDIz
IGF0IDAxOjQxOjQ3UE0gKzAwMDAsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IEkg
d2lsbCBzdW1tYXJpemUgdGhlIGN1cnJlbnQgc2l0dWF0aW9uIGZyb20gbXkgcG9pbnQgb2Ygdmll
dywgbWF5YmUgaXQgaGVscHM6DQo+Pg0KPj4gUlMtMjMyOg0KPj4gICAtIEZ1bGwgRHVwbGV4IFBv
aW50LXRvLVBvaW50IGNvbm5lY3Rpb24NCj4+ICAgLSBObyB0cmFuc2NlaXZlciBjb250cm9sIHdp
dGggUlRTDQo+PiAgIC0gTm8gdGVybWluYXRpb24NCj4+ICAgLSBObyBleHRyYSBzdHJ1Y3QgaW4g
dXNlDQo+Pg0KPj4gUlMtNDIyOg0KPj4gICAtIEZ1bGwgRHVwbGV4IFBvaW50LXRvLVBvaW50IGNv
bm5lY3Rpb24NCj4+ICAgLSBObyB0cmFuc2NlaXZlciBjb250cm9sIHdpdGggUlRTIG5lZWRlZA0K
Pj4gICAtIFRlcm1pbmF0aW9uIHBvc3NpYmxlDQo+PiAgIC0gRXh0cmEgc3RydWN0IHNlcmlhbF9y
czQ4NSBuZWVkZWQgaWYgdGVybWluYXRpb24gaXMgdXNlZA0KPj4gID0+IFJTLTQyMiBjYW4gYmUg
dXNlZCBpbiBSUy0yMzIgb3BlcmF0aW9uLCBidXQgaWYgYSB0ZXJtaW5hdGlvbiBzaG91bGQgYmUN
Cj4+ICAgICBzd2l0Y2hhYmxlIHRoZSBSUzQ4NSBmbGFnIGhhcyB0byBiZSBlbmFibGVkLiBCdXQg
dGhlbiBhbHNvIHRyYW5zY2VpdmVyDQo+PiAgICAgY29udHJvbCB3aWxsIGJlIGVuYWJsZWQuIE5v
dCBhIHZlcnkgc2F0aXNmeWluZyBzaXR1YXRpb24uDQo+IA0KPiBXZWxsIHdoeSBkb24ndCB3ZSBq
dXN0IGFsbG93IGVuYWJsaW5nIG9yIGRpc2FibGluZyBSUy00ODUgdGVybWluYXRpb24NCj4gaW5k
ZXBlbmRlbnRseSBmcm9tIHRoZSBTRVJfUlM0ODVfRU5BQkxFRCBiaXQgaW4gc3RydWN0IHNlcmlh
bF9yczQ4NT8NCj4gDQo+IEp1c3QgbGV0IHRoZSB1c2VyIGlzc3VlIGEgVElPQ1NSUzQ4NSBpb2N0
bCB0byB0b2dnbGUgdGVybWluYXRpb24gZXZlbg0KPiBpZiBpbiBSUy0yMzIgbW9kZSBhbmQgdXNl
IHRoYXQgbW9kZSBmb3IgUlMtNDIyLg0KPiANCj4gTG9va3MgbGlrZSB0aGUgc2ltcGxlc3Qgc29s
dXRpb24gdG8gbWUuDQoNClNvdW5kcyBub3QgYmFkLiBUaGUgdGVybWluYXRpb24gc2hvdWxkIG9u
bHkgZGVwZW5kIG9uIHdoZXRoZXIgdGhlIEdQSU8gaXMNCmdpdmVuIG9yIG5vdC4gDQoNCklycmVz
cGVjdGl2ZSBvZiB0aGlzLCBJIHRoaW5rIHRoZSBMaW5vcyBpZGVhIG9mIGFuIFJTLTQyMiBtb2Rl
IGlzIG5vdCBiYWQuDQpUaGlzIGFsbG93cyB5b3UgdG8gdGFrZSBjYXJlIG9mIHNwZWNpYWwgZmVh
dHVyZXMgdGhhdCB3ZXJlIHByZXZpb3VzbHkNCm92ZXJsb29rZWQuIEZvciBleGFtcGxlLCBoYXJk
d2FyZSBmbG93IGNvbnRyb2wgY2FuIGJlIHN3aXRjaGVkIG9mZiBzbyB0aGF0DQp0aGlzIGRvZXMg
bm90IGNhdXNlIGFueSBwcm9ibGVtcy4NCg0KPj4gUlMtNDg1ICgyLXdpcmUpIHZlcnkgY29tbW9u
Og0KPj4gICAtIEhhbGYgRHVwbGV4IFJTLTQ4NSBidXMNCj4+ICAgLSBUcmFuc2NlaXZlciBjb250
cm9sIHdpdGggUlRTIGlzIG5lZWRlZA0KPj4gICAtIFRlcm1pbmF0aW9uIHBvc3NpYmxlDQo+PiAg
IC0gRXh0cmEgc3RydWN0IHNlcmlhbF9yczQ4NSBpcyBuZWVkZWQNCj4+ICA9PiBSUy00ODUgaGFz
IHRvIGJlIGVuYWJsZWQgYW5kIGNvbmZpZ3VyZWQ6DQo+PiAgICAgLSBTZXQgU0VSX1JTNDg1X0VO
QUJMRUQNCj4+ICAgICAtIFNldCBTRVJfUlM0ODVfUlRTX09OX1NFTkQgb3IgU0VSX1JTNDg1X1JU
U19BRlRFUl9TRU5EDQo+PiAgICAgLSBTZXQvY2xlYXIgU0VSX1JTNDg1X1JYX0RVUklOR19UWCBk
ZXBlbmRpbmcgb24gd2hldGhlcg0KPj4gICAgICAgdGhlIHJlY2VpdmVyIHBhdGggc2hvdWxkIGJl
IG9uIG9yIG9mZiBkdXJpbmcgc2VuZGluZy4NCj4+ICAgICAgIElmIGl0J3Mgc2V0IGl0IGFsbG93
cyB0byBtb25pdG9yIHRoZSBzZW5kaW5nIG9uIHRoZSBidXMNCj4+ICAgICAgIGFuZCBkZXRlY3Qg
d2hldGhlciBhbm90aGVyIGJ1cyBkZXZpY2UgaXMgdHJhbnNtaXR0aW5nDQo+PiAgICAgICBhdCB0
aGUgc2FtZSB0aW1lLg0KPj4gICAgIC0gU2V0L2NsZWFyIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVT
IGZvciBidXMgdGVybWluYXRpb24uDQo+Pg0KPj4gUlMtNDg1ICg0LXdpcmUpIGxpdHRsZSB1c2Vk
Og0KPj4gICAtIEZ1bGwgRHVwbGV4IFJTLTQ4NSBidXMNCj4+ICAgLSBUcmFuc2NlaXZlciBjb250
cm9sIHdpdGggUlRTIGlzIG5lZWRlZA0KPj4gICAtIFRlcm1pbmF0aW9uIHBvc3NpYmxlDQo+PiAg
IC0gRXh0cmEgc3RydWN0IHNlcmlhbF9yczQ4NSBpcyBuZWVkZWQNCj4+ICA9PiBSUy00ODUgaGFz
IHRvIGJlIGVuYWJsZWQgYW5kIGNvbmZpZ3VyZWQ6DQo+PiAgICAgLSBTZXQgU0VSX1JTNDg1X0VO
QUJMRUQNCj4+ICAgICAtIFNldCBTRVJfUlM0ODVfUlRTX09OX1NFTkQgb3IgU0VSX1JTNDg1X1JU
U19BRlRFUl9TRU5EDQo+PiAgICAgLSBTZXQgU0VSX1JTNDg1X1JYX0RVUklOR19UWCwgYXMgdGhl
IHJlY2VpdmVyIHNob3VsZCBhbHdheXMNCj4+ICAgICAgIGJlIGVuYWJsZWQgaW5kZXBlbmRlbnRs
eSBvZiBUWCwgYmVjYXVzZSBUWCBhbmQgUlggYXJlDQo+PiAgICAgICBzZXBhcmF0ZWQgZnJvbSBl
YWNoIG90aGVyIGJ5IHRoZWlyIG93biB3aXJlcy4NCj4+ICAgICAtIFNldC9jbGVhciBTRVJfUlM0
ODVfVEVSTUlOQVRFX0JVUyBmb3IgYnVzIHRlcm1pbmF0aW9uLg0KPiANCj4gVGhhbmtzIGZvciB0
aGF0IG92ZXJ2aWV3LCBJIGZvdW5kIGl0IHZlcnkgaGVscGZ1bC4NCj4gDQo+IE9uZSBzbWFsbCBh
ZGRlbmR1bTogIEhhcmR3YXJlIGZsb3cgY29udHJvbC4gIE9ubHkgcG9zc2libGUgd2l0aA0KPiBS
Uy0yMzIuICBEb2Vzbid0IHdvcmsgaW4gYW55IG9mIHRoZSBvdGhlciBtb2RlcywgcmlnaHQ/DQoN
CllvdSBhcmUgcmlnaHQgSSBmb3Jnb3QgdG8gbWVudGlvbiBpdC4NCg0KUmVnYXJkcyBhbmQgTWVy
cnkgQ2hyaXN0bWFzDQpDaHJpc3RvcGgNCg==

