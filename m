Return-Path: <linux-kernel+bounces-10683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB0981D8AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7539928222F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0820F5;
	Sun, 24 Dec 2023 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="DMyfAzFh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CB20F8;
	Sun, 24 Dec 2023 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703412689;
	bh=OXQ4ZJxgDAB/RrJMWy4ykGxBqvaHXcoG155uXiLRLJQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DMyfAzFhc8tWIWlGDX2MJl1yjY3xSiww5icOzG6e3srbBlMb/00yu5DVEw72FlgX4
	 +GZRowvqGAeLx20Uwxc0KO2eQ+eKgkj0aqtJ3IuwkU3ZF2NEie5+OmuGbbVqiXo/uv
	 xt27QwgZSj25uTMhYXr5kXPRyYZcqWkxotDYLIDJ0nZv32FIJhlv0XrMRWHrymT8jP
	 M+alEQyg18Ndh5eaLeGwebbPfRVs4kOYfax8fp2/ycd3PWU8Tf2u4WT18PVA7j0nYm
	 S+sEHWPJU+fcbr+zUcGY7FLGOl83BRnpGum2iYRtGFIdMp677qxHILxcE/cwjkUVIy
	 JoV3ETqW/bJOg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Lukas Wunner <lukas@wunner.de>
CC: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
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
Thread-Index: AQHaH/jBESSZN4JU2UOxi81YCMKNnLCN1MYggA6QRICABHVPgIADOxKAgASJVgCAABWukIALRm2AgAAjTdCAAtxzAIABYp/A
Date: Sun, 24 Dec 2023 10:11:17 +0000
Message-ID: <766f5d0d08c14666a3291073e1a43b23@dh-electronics.com>
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
 <f41f5ddcb52140b6a579043a5abce751@dh-electronics.com>
 <0ec4c423-3d18-4a29-b78e-938366ece117@gmx.de>
In-Reply-To: <0ec4c423-3d18-4a29-b78e-938366ece117@gmx.de>
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
dDogU2F0dXJkYXksIERlY2VtYmVyIDIzLCAyMDIzIDI6NDEgUE0NCj4gT24gMjMuMTIuMjMgMTM6
NDksIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IEZyb206IEx1a2FzIFd1bm5lciBb
bWFpbHRvOmx1a2FzQHd1bm5lci5kZV0NCj4+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyMSwg
MjAyMyA0OjUzIFBNDQo+Pj4NCj4+PiBPbiBUaHUsIERlYyAxNCwgMjAyMyBhdCAwMTo0MTo0N1BN
ICswMDAwLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+Pj4+IEkgd2lsbCBzdW1tYXJp
emUgdGhlIGN1cnJlbnQgc2l0dWF0aW9uIGZyb20gbXkgcG9pbnQgb2YgdmlldywgbWF5YmUgaXQg
aGVscHM6DQo+Pj4+DQo+Pj4+IFJTLTIzMjoNCj4+Pj4gICAtIEZ1bGwgRHVwbGV4IFBvaW50LXRv
LVBvaW50IGNvbm5lY3Rpb24NCj4+Pj4gICAtIE5vIHRyYW5zY2VpdmVyIGNvbnRyb2wgd2l0aCBS
VFMNCj4+Pj4gICAtIE5vIHRlcm1pbmF0aW9uDQo+Pj4+ICAgLSBObyBleHRyYSBzdHJ1Y3QgaW4g
dXNlDQo+Pj4+DQo+Pj4+IFJTLTQyMjoNCj4+Pj4gICAtIEZ1bGwgRHVwbGV4IFBvaW50LXRvLVBv
aW50IGNvbm5lY3Rpb24NCj4+Pj4gICAtIE5vIHRyYW5zY2VpdmVyIGNvbnRyb2wgd2l0aCBSVFMg
bmVlZGVkDQo+Pj4+ICAgLSBUZXJtaW5hdGlvbiBwb3NzaWJsZQ0KPj4+PiAgIC0gRXh0cmEgc3Ry
dWN0IHNlcmlhbF9yczQ4NSBuZWVkZWQgaWYgdGVybWluYXRpb24gaXMgdXNlZA0KPj4+PiAgPT4g
UlMtNDIyIGNhbiBiZSB1c2VkIGluIFJTLTIzMiBvcGVyYXRpb24sIGJ1dCBpZiBhIHRlcm1pbmF0
aW9uIHNob3VsZCBiZQ0KPj4+PiAgICAgc3dpdGNoYWJsZSB0aGUgUlM0ODUgZmxhZyBoYXMgdG8g
YmUgZW5hYmxlZC4gQnV0IHRoZW4gYWxzbyB0cmFuc2NlaXZlcg0KPj4+PiAgICAgY29udHJvbCB3
aWxsIGJlIGVuYWJsZWQuIE5vdCBhIHZlcnkgc2F0aXNmeWluZyBzaXR1YXRpb24uDQo+Pj4NCj4+
PiBXZWxsIHdoeSBkb24ndCB3ZSBqdXN0IGFsbG93IGVuYWJsaW5nIG9yIGRpc2FibGluZyBSUy00
ODUgdGVybWluYXRpb24NCj4+PiBpbmRlcGVuZGVudGx5IGZyb20gdGhlIFNFUl9SUzQ4NV9FTkFC
TEVEIGJpdCBpbiBzdHJ1Y3Qgc2VyaWFsX3JzNDg1Pw0KPj4+DQo+Pj4gSnVzdCBsZXQgdGhlIHVz
ZXIgaXNzdWUgYSBUSU9DU1JTNDg1IGlvY3RsIHRvIHRvZ2dsZSB0ZXJtaW5hdGlvbiBldmVuDQo+
Pj4gaWYgaW4gUlMtMjMyIG1vZGUgYW5kIHVzZSB0aGF0IG1vZGUgZm9yIFJTLTQyMi4NCj4+Pg0K
Pj4+IExvb2tzIGxpa2UgdGhlIHNpbXBsZXN0IHNvbHV0aW9uIHRvIG1lLg0KPj4NCj4+IFNvdW5k
cyBub3QgYmFkLiBUaGUgdGVybWluYXRpb24gc2hvdWxkIG9ubHkgZGVwZW5kIG9uIHdoZXRoZXIg
dGhlIEdQSU8gaXMNCj4+IGdpdmVuIG9yIG5vdC4NCj4+DQo+PiBJcnJlc3BlY3RpdmUgb2YgdGhp
cywgSSB0aGluayB0aGUgTGlub3MgaWRlYSBvZiBhbiBSUy00MjIgbW9kZSBpcyBub3QgYmFkLg0K
Pj4gVGhpcyBhbGxvd3MgeW91IHRvIHRha2UgY2FyZSBvZiBzcGVjaWFsIGZlYXR1cmVzIHRoYXQg
d2VyZSBwcmV2aW91c2x5DQo+PiBvdmVybG9va2VkLiBGb3IgZXhhbXBsZSwgaGFyZHdhcmUgZmxv
dyBjb250cm9sIGNhbiBiZSBzd2l0Y2hlZCBvZmYgc28gdGhhdA0KPj4gdGhpcyBkb2VzIG5vdCBj
YXVzZSBhbnkgcHJvYmxlbXMuDQo+Pg0KPiANCj4gQWxzbyBub3RlLCB0aGF0IFJTMjMyIGFuZCBS
UzQyMiBtYXkgTk9UIGFsd2F5cyBiZSB0aGUgc2FtZSBmcm9tIGRyaXZlciBwZXJzcGVjdGl2ZS4N
Cj4gVGFrZSBhIGxvb2sgYXQgODI1MF9leGNhci5jIGZvciBleGFtcGxlLiBUaGF0IGRyaXZlciBo
YXMgdG8gY29uZmlndXJlIHRoZSBoYXJkd2FyZQ0KPiBhY2NvcmRpbmdseSB3aGVuIHN3aXRjaGlu
ZyBmcm9tIFJTMjMyIHRvIFJTNDIyIChzZWUgaW90MjA0MF9yczQ4NV9jb25maWcoKSkuDQo+IA0K
PiBXaGlsZSBhIFNFUl9SUzQ4NV9NT0RFX1JTNDIyIGZsYWcgc2V0IGJ5IHVzZXJzcGFjZSBjb3Vs
ZCB3b3JrIHRvIHN3aXRjaCB0byBSUzQyMiwgSQ0KPiBzdGlsbCB0aGluayB0aGF0IHRoZSBjbGVh
bmVzdCBzb2x1dGlvbiB3b3VsZCBiZSBhbm90aGVyIGlvY3RsIFRJT0NTUlM0MjIgd2l0aCBhDQo+
IHBhcmFtZXRlciBsaWtlDQo+IA0KPiBzdHJ1Y3Qgc2VyaWFsX3JzNDIyIHsNCj4gICAgICAgIF9f
dTMyICAgZmxhZ3M7DQo+ICNkZWZpbmUgU0VSX1JTNDIyX0VOQUJMRUQgICAgICAgICAgICAgICgx
IDw8IDApDQo+ICNkZWZpbmUgU0VSX1JTNDIyX1RFUk1JTkFURV9CVVMgICAgICAgICgxIDw8IDEp
DQo+ICAgICAgICAgX191MzIgICBwYWRkaW5nWzddDQo+IH07DQo+IA0KPiBUaGUgU0VSX1JTNDg1
X01PREVfUlM0MjIgZmxhZyBjb3VsZCBzdGlsbCBiZSB1c2VkIGludGVybmFsbHkgYXMgYSBoaW50
IHRvIHRoZSBkcml2ZXIuDQo+IFRoYXQgc29sdXRpb24gd291bGQgYWxzbyBiZSBleHBhbmRhYmxl
IGlmIG5lZWRlZC4gSSBwbGFubmVkIHRvIHNlbmQgYSBwYXRjaCB0aGF0DQo+IGltcGxlbWVudHMg
dGhpcw0KPiBhcyBhIFJGQyB0byB0aGUgbWFpbGluZyBsaXN0IChtYXliZSBpbiB0aGUgbmV4dCBm
ZXcgZGF5cykuDQoNCkhhdmluZyB5b3VyIG93biBpb2N0bCBpcyBhIG5pY2UgZGlzdGluY3Rpb24s
IGJ1dCB3aGVuIEkgdGhpbmsgYWJvdXQgaXQgZm9yIGEgbW9tZW50LA0KcXVlc3Rpb25zIGNvbWUg
dG8gbWluZDoNCg0KRnJvbSB1c2Vyc3BhY2UgcGVyc3BlY3RpdmUgdGhlbiB0aGVyZSBhcmUgdHdv
IHRlcm1pbmF0aW9uIGZsYWdzDQpTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUyBhbmQgU0VSX1JTNDIy
X1RFUk1JTkFURV9CVVM/DQpIb3cgd2lsbCB0aGV5IGludGVyYWN0IGludGVybmFsbHk/DQoNCldo
YXQgYWJvdXQgdGhlIGRldmljZXRyZWUgcHJvcGVydHk/DQpXaWxsIHRoZXJlIGJlIHJzNDIyLXRl
cm0tZ3Bpb3MgYXMgd2VsbD8NCg0KQ291bGQgdGhlIHVzZXIgZW5hYmxlIFJTNDIyIGFuZCBSUzQ4
NSBhdCB0aGUgc2FtZSB0aW1lPw0KDQoNClJlZ2FyZHMgYW5kIE1lcnJ5IENocmlzdG1hcw0KQ2hy
aXN0b3BoDQo=

