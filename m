Return-Path: <linux-kernel+bounces-4618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83662818000
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7C01F24252
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CF4426;
	Tue, 19 Dec 2023 03:02:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C53468A;
	Tue, 19 Dec 2023 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5C71081DC;
	Tue, 19 Dec 2023 11:02:23 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 11:02:23 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 11:02:22 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 19 Dec 2023 11:02:22 +0800
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"kernel@esmil.dk" <kernel@esmil.dk>, "conor@kernel.org" <conor@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "Hal
 Feng" <hal.feng@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator
 driver
Thread-Topic: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock
 generator driver
Thread-Index: AQHaKDp8qa+gHWDJHkGDh0MGWRuwVrCfD58AgAXCtdCAAc4FgIAJXVZw
Date: Tue, 19 Dec 2023 03:02:22 +0000
Message-ID: <d35d3cf480064c69b1125ba07d615446@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
 <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
 <9ae86c6786bc4ac7b93c971ba00084a6@EXMBX066.cuchost.com>
 <CAJM55Z9GVFGuwqe=zLXQvBwDfVSz4eA2EXDd4sqWVCKJF2J+fg@mail.gmail.com>
In-Reply-To: <CAJM55Z9GVFGuwqe=zLXQvBwDfVSz4eA2EXDd4sqWVCKJF2J+fg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW1pbCBSZW5uZXIgQmVy
dGhpbmcgPGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgRGVjZW1iZXIgMTMsIDIwMjMgNzo1NyBQTQ0KPiBUbzogSmVlSGVuZyBTaWEgPGplZWhl
bmcuc2lhQHN0YXJmaXZldGVjaC5jb20+OyBFbWlsIFJlbm5lciBCZXJ0aGluZyA8ZW1pbC5yZW5u
ZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbT47IGtlcm5lbEBlc21pbC5kazsNCj4gY29ub3JAa2Vy
bmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFy
by5vcmc7IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiBh
b3VAZWVjcy5iZXJrZWxleS5lZHU7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJu
ZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3Rh
cmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+
IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2Vy
bmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+
IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEgMDYvMTZdIGNsazogc3RhcmZpdmU6IEFkZCBKSDgxMDAg
U3lzdGVtIGNsb2NrIGdlbmVyYXRvciBkcml2ZXINCj4gDQo+IEplZUhlbmcgU2lhIHdyb3RlOg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEVtaWwgUmVubmVy
IEJlcnRoaW5nIDxlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tPg0KPiA+ID4gU2Vu
dDogU2F0dXJkYXksIERlY2VtYmVyIDksIDIwMjMgMTI6MjUgQU0NCj4gPiA+IFRvOiBKZWVIZW5n
IFNpYSA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29u
b3JAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+ID4ga3J6eXN6dG9mLmtvemxv
d3NraStkdEBsaW5hcm8ub3JnOyBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJi
ZWx0LmNvbTsgYW91QGVlY3MuYmVya2VsZXkuZWR1Ow0KPiA+ID4gbXR1cnF1ZXR0ZUBiYXlsaWJy
ZS5jb207IHNib3lkQGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGVtaWwucmVu
bmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb207IEhhbCBGZW5nDQo+ID4gPiA8aGFsLmZlbmdAc3Rh
cmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+
ID4gPiBDYzogbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmc7IExleWZvb24NCj4gVGFuDQo+ID4gPiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0
ZWNoLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDYvMTZdIGNsazogc3RhcmZp
dmU6IEFkZCBKSDgxMDAgU3lzdGVtIGNsb2NrIGdlbmVyYXRvciBkcml2ZXINCj4gPiA+DQo+ID4g
PiBTaWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4gPiA+IEFkZCBzdXBwb3J0IGZvciBKSDgxMDAgU3lz
dGVtIGNsb2NrIGdlbmVyYXRvci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2lh
IEplZSBIZW5nIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gPiBSZXZpZXdl
ZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgOCArDQo+ID4gPiA+ICBkcml2ZXJzL2Nsay9zdGFyZml2ZS9LY29uZmlnICAgICAg
ICAgICAgICAgICAgfCAgIDkgKw0KPiA+ID4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvTWFrZWZp
bGUgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ID4gIGRyaXZlcnMvY2xrL3N0YXJmaXZl
L2Nsay1zdGFyZml2ZS1jb21tb24uaCAgICB8ICAgOSArLQ0KPiA+ID4gPiAgZHJpdmVycy9jbGsv
c3RhcmZpdmUvamg4MTAwL01ha2VmaWxlICAgICAgICAgIHwgICAzICsNCj4gPiA+ID4gIC4uLi9j
bGsvc3RhcmZpdmUvamg4MTAwL2Nsay1zdGFyZml2ZS1qaDgxMDAuaCB8ICAxMSArDQo+ID4gPiA+
ICBkcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDAvY2xrLXN5cy5jICAgICAgICAgfCA0NTUgKysr
KysrKysrKysrKysrKysrDQo+ID4gPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDQ5NSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9j
bGsvc3RhcmZpdmUvamg4MTAwL01ha2VmaWxlDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9jbGsvc3RhcmZpdmUvamg4MTAwL2Nsay1zdGFyZml2ZS1qaDgxMDAuaA0KPiA+ID4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9jbGstc3lz
LmMNCj4gLi4uDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9NYWtl
ZmlsZSBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL01ha2VmaWxlDQo+ID4gPiA+IGluZGV4IDAxMmY3
ZWU4M2Y4ZS4uNmNiM2NlODIzMzMwIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9z
dGFyZml2ZS9NYWtlZmlsZQ0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9zdGFyZml2ZS9NYWtl
ZmlsZQ0KPiA+ID4gPiBAQCAtMTAsMyArMTAsNCBAQCBvYmotJChDT05GSUdfQ0xLX1NUQVJGSVZF
X0pINzExMF9BT04pCSs9IGNsay1zdGFyZml2ZS1qaDcxMTAtYW9uLm8NCj4gPiA+ID4gIG9iai0k
KENPTkZJR19DTEtfU1RBUkZJVkVfSkg3MTEwX1NURykJKz0gY2xrLXN0YXJmaXZlLWpoNzExMC1z
dGcubw0KPiA+ID4gPiAgb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDcxMTBfSVNQKQkrPSBj
bGstc3RhcmZpdmUtamg3MTEwLWlzcC5vDQo+ID4gPiA+ICBvYmotJChDT05GSUdfQ0xLX1NUQVJG
SVZFX0pINzExMF9WT1VUKQkrPSBjbGstc3RhcmZpdmUtamg3MTEwLXZvdXQubw0KPiA+ID4gPiAr
b2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDgxMDBfU1lTKQkrPSBqaDgxMDAvDQo+ID4gPg0K
PiA+ID4gSSBkb24ndCByZWFsbHkgc2VlIHdoeSBkbyB5b3UgbmVlZCBhIHNwZWNpYWwgc3ViZGly
ZWN0b3J5IGZvciB0aGUgSkg4MTAwPyBUaGUNCj4gPiA+IEpINzExMCBkcml2ZXJzIGRvIGZpbmUg
d2l0aG91dCBpdC4NCj4gPiBFYWNoIHN1YmZvbGRlciBjYW4gcmVwcmVzZW50IGEgZGlmZmVyZW50
IHBsYXRmb3JtLCBtYWtpbmcgaXQgZWFzaWVyIHRvDQo+ID4gbG9jYXRlIGFuZCBtYWludGFpbiBw
bGF0Zm9ybS1zcGVjaWZpYyBjb2RlLiBTaW5jZSB0aGUgY29kZSBpcyBleHBlY3RlZA0KPiA+IHRv
IGdyb3cgaW4gdGhlIGZ1dHVyZSwgbGV0J3Mgc3RhcnQgb3JnYW5pemluZyBpdCBpbiBhIGZvbGRl
ci1iYXNlZCBzdHJ1Y3R1cmUNCj4gPiBmb3IgZWFzaWVyIG1haW50ZW5hbmNlIGF0IGEgbGF0ZXIg
c3RhZ2UuDQo+IA0KPiBZZXMsIGJ1dCB0aGF0J3Mgbm90IHdoYXQgeW91J3JlIGRvaW5nIGhlcmUu
IFlvdSdyZSBtYWtpbmcganVzdCBvbmUgb2YgdGhlIDMNCj4gYWxtb3N0IGlkZW50aWNhbCBkcml2
ZXJzIGJlIGRpZmZlcmVudCBmb3Igbm8gZ29vZCByZWFzb24uDQpJIHdpbGwgcmVzdHJ1Y3R1cmUg
aXQgZm9yIHRoZSBvdGhlciAyIHBsYXRmb3Jtcy4NCj4gDQpbLi4uXQ0K

