Return-Path: <linux-kernel+bounces-6254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338E819669
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F4F1C20F68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D18BF9;
	Wed, 20 Dec 2023 01:35:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8C7488;
	Wed, 20 Dec 2023 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 1408124DBFD;
	Wed, 20 Dec 2023 09:35:16 +0800 (CST)
Received: from EXMBX063.cuchost.com (172.16.7.63) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:35:15 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX063.cuchost.com
 (172.16.7.63) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:35:15 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 20 Dec 2023 09:35:15 +0800
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
Thread-Index: AQHaKDp8qa+gHWDJHkGDh0MGWRuwVrCfD58AgAXCtdCAAc4FgIAJXVZwgABwgACAAQqwwA==
Date: Wed, 20 Dec 2023 01:35:15 +0000
Message-ID: <88f5651b913d4b2f9e9c76ecf8429aac@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
 <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
 <9ae86c6786bc4ac7b93c971ba00084a6@EXMBX066.cuchost.com>
 <CAJM55Z9GVFGuwqe=zLXQvBwDfVSz4eA2EXDd4sqWVCKJF2J+fg@mail.gmail.com>
 <d35d3cf480064c69b1125ba07d615446@EXMBX066.cuchost.com>
 <CAJM55Z_XZVBKr05X4QeCeDO_iMZh-FbKsikcNsDPK7iKuVEodw@mail.gmail.com>
In-Reply-To: <CAJM55Z_XZVBKr05X4QeCeDO_iMZh-FbKsikcNsDPK7iKuVEodw@mail.gmail.com>
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
c2RheSwgRGVjZW1iZXIgMjAsIDIwMjMgMTo0MCBBTQ0KPiBUbzogSmVlSGVuZyBTaWEgPGplZWhl
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
PiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBF
bWlsIFJlbm5lciBCZXJ0aGluZyA8ZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbT4N
Cj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTMsIDIwMjMgNzo1NyBQTQ0KPiA+ID4g
VG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgRW1pbCBSZW5u
ZXIgQmVydGhpbmcgPGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20+OyBrZXJuZWxA
ZXNtaWwuZGs7DQo+ID4gPiBjb25vckBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29t
OyBwYWxtZXJAZGFiYmVsdC5jb207DQo+ID4gPiBhb3VAZWVjcy5iZXJrZWxleS5lZHU7IG10dXJx
dWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4
LmRlOyBIYWwgRmVuZw0KPiA+ID4gPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBYaW5neXUg
V3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXJpc2N2QGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBMZXlmb29uDQo+
IFRhbg0KPiA+ID4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBSRTogW1BBVENIIHYxIDA2LzE2XSBjbGs6IHN0YXJmaXZlOiBBZGQgSkg4MTAwIFN5c3RlbSBj
bG9jayBnZW5lcmF0b3IgZHJpdmVyDQo+ID4gPg0KPiA+ID4gSmVlSGVuZyBTaWEgd3JvdGU6DQo+
ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBFbWls
IFJlbm5lciBCZXJ0aGluZyA8ZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbT4NCj4g
PiA+ID4gPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgOSwgMjAyMyAxMjoyNSBBTQ0KPiA+ID4g
PiA+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5l
bEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+ID4g
PiA+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgcGF1bC53YWxtc2xleUBzaWZp
dmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gPiA+
ID4gPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcC56YWJlbEBw
ZW5ndXRyb25peC5kZTsgZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbTsgSGFsIEZl
bmcNCj4gPiA+ID4gPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiA+ID4gQ2M6IGxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBMZXlmb29uDQo+
ID4gPiBUYW4NCj4gPiA+ID4gPiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA2LzE2XSBjbGs6IHN0YXJmaXZlOiBBZGQgSkg4
MTAwIFN5c3RlbSBjbG9jayBnZW5lcmF0b3IgZHJpdmVyDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBT
aWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3IgSkg4MTAwIFN5
c3RlbSBjbG9jayBnZW5lcmF0b3IuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogU2lhIEplZSBIZW5nIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4g
PiA+ID4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNo
LmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9j
bGsvc3RhcmZpdmUvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gPiA+ID4gPiA+
ICBkcml2ZXJzL2Nsay9zdGFyZml2ZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0K
PiA+ID4gPiA+ID4gIGRyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1jb21tb24uaCAg
ICB8ICAgOSArLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9NYWtl
ZmlsZSAgICAgICAgICB8ICAgMyArDQo+ID4gPiA+ID4gPiAgLi4uL2Nsay9zdGFyZml2ZS9qaDgx
MDAvY2xrLXN0YXJmaXZlLWpoODEwMC5oIHwgIDExICsNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2Ns
ay9zdGFyZml2ZS9qaDgxMDAvY2xrLXN5cy5jICAgICAgICAgfCA0NTUgKysrKysrKysrKysrKysr
KysrDQo+ID4gPiA+ID4gPiAgNyBmaWxlcyBjaGFuZ2VkLCA0OTUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9z
dGFyZml2ZS9qaDgxMDAvTWFrZWZpbGUNCj4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9jbGsvc3RhcmZpdmUvamg4MTAwL2Nsay1zdGFyZml2ZS1qaDgxMDAuaA0KPiA+ID4g
PiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDAvY2xr
LXN5cy5jDQo+ID4gPiAuLi4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9z
dGFyZml2ZS9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL01ha2VmaWxlDQo+ID4gPiA+
ID4gPiBpbmRleCAwMTJmN2VlODNmOGUuLjZjYjNjZTgyMzMzMCAxMDA2NDQNCj4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvY2xrL3N0YXJmaXZlL01ha2VmaWxlDQo+ID4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL2Nsay9zdGFyZml2ZS9NYWtlZmlsZQ0KPiA+ID4gPiA+ID4gQEAgLTEwLDMgKzEwLDQg
QEAgb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDcxMTBfQU9OKQkrPSBjbGstc3RhcmZpdmUt
amg3MTEwLWFvbi5vDQo+ID4gPiA+ID4gPiAgb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDcx
MTBfU1RHKQkrPSBjbGstc3RhcmZpdmUtamg3MTEwLXN0Zy5vDQo+ID4gPiA+ID4gPiAgb2JqLSQo
Q09ORklHX0NMS19TVEFSRklWRV9KSDcxMTBfSVNQKQkrPSBjbGstc3RhcmZpdmUtamg3MTEwLWlz
cC5vDQo+ID4gPiA+ID4gPiAgb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDcxMTBfVk9VVCkJ
Kz0gY2xrLXN0YXJmaXZlLWpoNzExMC12b3V0Lm8NCj4gPiA+ID4gPiA+ICtvYmotJChDT05GSUdf
Q0xLX1NUQVJGSVZFX0pIODEwMF9TWVMpCSs9IGpoODEwMC8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IEkgZG9uJ3QgcmVhbGx5IHNlZSB3aHkgZG8geW91IG5lZWQgYSBzcGVjaWFsIHN1YmRpcmVjdG9y
eSBmb3IgdGhlIEpIODEwMD8gVGhlDQo+ID4gPiA+ID4gSkg3MTEwIGRyaXZlcnMgZG8gZmluZSB3
aXRob3V0IGl0Lg0KPiA+ID4gPiBFYWNoIHN1YmZvbGRlciBjYW4gcmVwcmVzZW50IGEgZGlmZmVy
ZW50IHBsYXRmb3JtLCBtYWtpbmcgaXQgZWFzaWVyIHRvDQo+ID4gPiA+IGxvY2F0ZSBhbmQgbWFp
bnRhaW4gcGxhdGZvcm0tc3BlY2lmaWMgY29kZS4gU2luY2UgdGhlIGNvZGUgaXMgZXhwZWN0ZWQN
Cj4gPiA+ID4gdG8gZ3JvdyBpbiB0aGUgZnV0dXJlLCBsZXQncyBzdGFydCBvcmdhbml6aW5nIGl0
IGluIGEgZm9sZGVyLWJhc2VkIHN0cnVjdHVyZQ0KPiA+ID4gPiBmb3IgZWFzaWVyIG1haW50ZW5h
bmNlIGF0IGEgbGF0ZXIgc3RhZ2UuDQo+ID4gPg0KPiA+ID4gWWVzLCBidXQgdGhhdCdzIG5vdCB3
aGF0IHlvdSdyZSBkb2luZyBoZXJlLiBZb3UncmUgbWFraW5nIGp1c3Qgb25lIG9mIHRoZSAzDQo+
ID4gPiBhbG1vc3QgaWRlbnRpY2FsIGRyaXZlcnMgYmUgZGlmZmVyZW50IGZvciBubyBnb29kIHJl
YXNvbi4NCj4gPiBJIHdpbGwgcmVzdHJ1Y3R1cmUgaXQgZm9yIHRoZSBvdGhlciAyIHBsYXRmb3Jt
cy4NCj4gDQo+IFRoYXQgd291bGQgYmUgbGVzcyBiYWQsIGJ1dCB5b3Ugc3RpbGwgaGF2ZW4ndCBl
eHBsYWluZWQgd2h5IHlvdSBuZWVkIHRvIG1vdmUNCj4gZXZlcnl0aGluZyBhcm91bmQgbGlrZSB0
aGF0Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9DQUpNNTVaXzNNdHky
TGZ0UFZrUUMxd2J3dEdlem5NTUFrOW1BakhfR29OdUw3Q0t0YVFAbWFpbC5nbWFpbC5jb20vDQo+
IA0KPiBJIGRvbid0IHRoaW5rIGp1c3QgInRvbyBtYW55IGZpbGVzIiBpcyBhIHZlcnkgZ29vZCBh
cmd1bWVudCBoZXJlLiBKdXN0IGxvb2sgYXQNCj4gZHJpdmVycy9jbGsvc3VueGkNClRoYW5rcy4g
R2l2ZW4gdGhhdCB0aGUgdHJlbmQgaXMgbm90IHRvIHVzZSBzdWJmb2xkZXJzIHRvIGRpZmZlcmVu
dGlhdGUgdGhlIHBsYXRmb3JtDQpjbG9jayBkcml2ZXIsIEkgYW0gb2theSB3aXRoIHJlbW92aW5n
IHRoZSBzdWJmb2xkZXIgYW5kIGZvbGxvd2luZyB0aGUgbmFtaW5nDQpjb252ZW50aW9uIGZyb20g
dGhlIEpINzF4eCdzIGZpbGUgbmFtZS4NCj4gDQo+IC9FbWlsDQo=

