Return-Path: <linux-kernel+bounces-6253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0086819664
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DA61C255ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262BF6FCE;
	Wed, 20 Dec 2023 01:34:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825E6133;
	Wed, 20 Dec 2023 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6FD5A807B;
	Wed, 20 Dec 2023 09:34:14 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:34:14 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:34:13 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 20 Dec 2023 09:34:13 +0800
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
Thread-Index: AQHaKDp8qa+gHWDJHkGDh0MGWRuwVrCfD58AgAd/fYCAABOZAIAK001w
Date: Wed, 20 Dec 2023 01:34:13 +0000
Message-ID: <0329cbf021a54ac7b426240fa5e22520@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
 <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
 <a554a163793e4513b25766c21ddc3f02@EXMBX066.cuchost.com>
 <CAJM55Z_3Mty2LftPVkQC1wbwtGeznMMAk9mAjH_GoNuL7CKtaQ@mail.gmail.com>
In-Reply-To: <CAJM55Z_3Mty2LftPVkQC1wbwtGeznMMAk9mAjH_GoNuL7CKtaQ@mail.gmail.com>
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
c2RheSwgRGVjZW1iZXIgMTMsIDIwMjMgODowNSBQTQ0KPiBUbzogSmVlSGVuZyBTaWEgPGplZWhl
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
Cj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciA5LCAyMDIzIDEyOjI1IEFNDQo+ID4gPiBU
bzogSmVlSGVuZyBTaWEgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+OyBrZXJuZWxAZXNt
aWwuZGs7IGNvbm9yQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPiA+IGtyenlz
enRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBw
YWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gPiA+IG10dXJxdWV0
dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRl
OyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tOyBIYWwgRmVuZw0KPiA+ID4gPGhh
bC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBYaW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRl
Y2guY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1jbGtAdmdlci5rZXJuZWwub3JnOyBMZXlmb29uDQo+IFRhbg0KPiA+ID4gPGxleWZvb24udGFu
QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA2LzE2XSBj
bGs6IHN0YXJmaXZlOiBBZGQgSkg4MTAwIFN5c3RlbSBjbG9jayBnZW5lcmF0b3IgZHJpdmVyDQo+
ID4gPg0KPiA+ID4gU2lhIEplZSBIZW5nIHdyb3RlOg0KPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3Ig
Skg4MTAwIFN5c3RlbSBjbG9jayBnZW5lcmF0b3IuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+
ID4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDggKw0KPiA+ID4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gPiA+ID4gIGRyaXZlcnMvY2xrL3N0YXJm
aXZlL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gPiA+ICBkcml2ZXJzL2Ns
ay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtY29tbW9uLmggICAgfCAgIDkgKy0NCj4gPiA+ID4gIGRy
aXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9NYWtlZmlsZSAgICAgICAgICB8ICAgMyArDQo+ID4g
PiA+ICAuLi4vY2xrL3N0YXJmaXZlL2poODEwMC9jbGstc3RhcmZpdmUtamg4MTAwLmggfCAgMTEg
Kw0KPiA+ID4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvamg4MTAwL2Nsay1zeXMuYyAgICAgICAg
IHwgNDU1ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgNyBmaWxlcyBjaGFuZ2VkLCA0OTUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9NYWtlZmlsZQ0KPiA+ID4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9jbGstc3RhcmZpdmUtamg4MTAw
LmgNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgx
MDAvY2xrLXN5cy5jDQo+ID4gPiA+DQo+IFsuLi5dDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDAvTWFrZWZpbGUgYi9kcml2ZXJzL2Nsay9zdGFyZml2ZS9q
aDgxMDAvTWFrZWZpbGUNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5hZjZhMDllMjIwZDMNCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ID4gPiArKysgYi9kcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDAvTWFrZWZpbGUNCj4gPiA+ID4g
QEAgLTAsMCArMSwzIEBADQo+ID4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQo+ID4gPiA+ICsjIFN0YXJGaXZlIEpIODEwMCBDbG9jaw0KPiA+ID4gPiArb2JqLSQoQ09O
RklHX0NMS19TVEFSRklWRV9KSDgxMDBfU1lTKQkJKz0gY2xrLXN5cy5vDQo+ID4gPg0KPiA+ID4g
VGhpcyB3aWxsIG5hbWUgdGhlIG1vZHVsZSBjbGstc3lzLCB3aGljaCBpcyB3YXkgdG9vIGdlbmVy
aWMuIFBsZWFzZSBuYW1lIHRoaXMNCj4gPiA+IGNsay1zdGFyZml2ZS1qaDgxMDAtc3lzIHNpbWls
YXIgdG8gdGhlIEpINzExMCBkcml2ZXJzLg0KPiA+IEp1c3QgcmVhbGl6ZWQgdGhhdCBJIGhhdmVu
J3QgcmVwbHkgdG8gdGhpcyBjb21tZW50Lg0KPiA+IEkgY2FuJ3QgZ2l2ZSBpdCBhIGxvbmdlciBu
YW1lIG90aGVyd2lzZSBjb21waWxlciB3aWxsIHRocm93IHdhcm5pbmcuDQo+ID4gVGhhdOKAmXMg
d2h5IGVuZHMgdXAgdG8gdXNlIGEgc2hvcnRlciBuYW1lIGFuZCBrZWVwIGl0IHVuZGVyIGpoODEw
MCBmb2xkZXIuDQo+IA0KPiBJJ20gc29ycnksIGhvdyBkb2VzIHRoYXQgbWFrZSBhbnkgc2Vuc2U/
IElmIHRoZSBjb21waWxlciBjYW4gY29tcGlsZQ0KPiANCj4gICBkcml2ZXJzL2Nsay9zdGFyZml2
ZS9jbGstc3RhcmZpdmUtamg3MTEwLXN5cy5jDQo+IA0KPiBqdXN0IGZpbmUsIHRoZW4gd2h5IHdv
dWxkIGl0IGhhdmUgdHJvdWJsZSB3aXRoDQo+IA0KPiAgIGRyaXZlcnMvY2xrL3N0YXJmaXZlL2Ns
ay1zdGFyZml2ZS1qaDgxMDAtc3lzLmMNCkJhc2VkIG9uIHRoZSBleHBlcmltZW50IGNvbmR1Y3Rl
ZCBhdCB0aGUgZWFybHkgc3RhZ2UsIHRoZSB3YXJuaW5nIG1lc3NhZ2UgaXMgY29taW5nDQpmcm9t
IHRoZSBuYW1lIG9mIHRoZSBhdXhpbGlhcnkgZGV2aWNlIChyZXNldCBpbiB0aGlzIGNhc2UpLiBX
ZSB0cnkgdG8gbWFwIHRoZSBuYW1lIG9mDQp0aGUgcmVzZXQgZGV2aWNlIHdpdGggdGhlIGZpbGUn
cyBuYW1lLCBhbmQgYXQgdGhhdCBtb21lbnQsIHRoZSBmaWxlIG5hbWUgaXMgbG9uZ2VyIHRoYW4N
CjMyIGNoYXJhY3RlcnMgaW4gbGVuZ3RoLiBJbiB5b3VyIGdpdmVuIGV4YW1wbGUsICdjbGstc3Rh
cmZpdmUtamg4MTAwLXN5cycgaXMgd2l0aGluIHRoZQ0KMzItY2hhcmFjdGVyIGxpbWl0LCBzbyBp
dCBzaG91bGQgYmUgb2theS4gR2l2ZW4gdGhhdCB0aGUgdHJlbmQgaXMgbm90IHRvIHVzZSBzdWJm
b2xkZXJzIHRvDQpkaWZmZXJlbnRpYXRlIHRoZSBwbGF0Zm9ybSBjbG9jayBkcml2ZXIsIEkgYW0g
b2theSB3aXRoIHJlbW92aW5nIHRoZSBzdWJmb2xkZXIgYW5kDQpmb2xsb3dpbmcgdGhlIG5hbWlu
ZyBjb252ZW50aW9uIGZyb20gdGhlIEpINzF4eCdzIGZpbGUgbmFtZS4NCj4gDQo+IC9FbWlsDQo=

