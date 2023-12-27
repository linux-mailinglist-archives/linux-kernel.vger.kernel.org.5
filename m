Return-Path: <linux-kernel+bounces-11970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9629681EE56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5FF1C217B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7844437D;
	Wed, 27 Dec 2023 10:52:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32444369;
	Wed, 27 Dec 2023 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 12D8524E278;
	Wed, 27 Dec 2023 18:51:39 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Dec
 2023 18:51:39 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Dec
 2023 18:51:38 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 27 Dec 2023 18:51:38 +0800
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, "kernel@esmil.dk" <kernel@esmil.dk>,
	"conor@kernel.org" <conor@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: RE: [RFC 07/16] dt-bindings: clock: Add StarFive JH8100 North-West
 clock and reset generator
Thread-Topic: [RFC 07/16] dt-bindings: clock: Add StarFive JH8100 North-West
 clock and reset generator
Thread-Index: AQHaN73wOhvDbHN7t0mtNi9lKoc0XLC7VyWAgAGek3A=
Date: Wed, 27 Dec 2023 10:51:38 +0000
Message-ID: <45cba9bf1af74128b4d77bea3e11ce69@EXMBX066.cuchost.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
 <20231226053848.25089-8-jeeheng.sia@starfivetech.com>
 <74649469-2b47-486e-b8d1-c89b705fe8c1@sifive.com>
In-Reply-To: <74649469-2b47-486e-b8d1-c89b705fe8c1@sifive.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FtdWVsIEhvbGxhbmQg
PHNhbXVlbC5ob2xsYW5kQHNpZml2ZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIg
MjcsIDIwMjMgMjowNyBBTQ0KPiBUbzogSmVlSGVuZyBTaWEgPGplZWhlbmcuc2lhQHN0YXJmaXZl
dGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZvb24udGFuQHN0YXJmaXZl
dGVjaC5jb20+OyBrZXJuZWxAZXNtaWwuZGs7IGNvbm9yQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2Vy
bmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBwYXVsLndhbG1z
bGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsgYW91QGVlY3MuYmVya2VsZXkuZWR1
OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsNCj4gcC56YWJlbEBw
ZW5ndXRyb25peC5kZTsgZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbTsgSGFsIEZl
bmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBYaW5neXUgV3UNCj4gPHhpbmd5dS53dUBz
dGFyZml2ZXRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyAwNy8xNl0gZHQtYmluZGluZ3M6
IGNsb2NrOiBBZGQgU3RhckZpdmUgSkg4MTAwIE5vcnRoLVdlc3QgY2xvY2sgYW5kIHJlc2V0IGdl
bmVyYXRvcg0KPiANCj4gT24gMjAyMy0xMi0yNSAxMTozOCBQTSwgU2lhIEplZSBIZW5nIHdyb3Rl
Og0KPiA+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIE5vcnRoLVdlc3QgY2xvY2sgYW5kIHJlc2V0IGdl
bmVyYXRvciAoTldDUkcpIG9uDQo+ID4gSkg4MTAwIFNvQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvY2xvY2svc3RhcmZpdmUsamg4MTAwLW53Y3JnLnlhbWwg
fCAxMTkgKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kdC1iaW5kaW5ncy9jbG9jay9zdGFy
Zml2ZSxqaDgxMDAtY3JnLmggICB8ICA0MyArKysrKysrDQo+ID4gIC4uLi9kdC1iaW5kaW5ncy9y
ZXNldC9zdGFyZml2ZSxqaDgxMDAtY3JnLmggICB8ICAxNCArKysNCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxNzYgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1ud2NyZy55YW1s
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1ud2NyZy55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1ud2NyZy55YW1sDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmJlMGY5NGU2NGU2YQ0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvY2xvY2svc3RhcmZpdmUsamg4MTAwLW53Y3JnLnlhbWwNCj4gPiBAQCAtMCwwICsxLDEx
OSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNE
LTItQ2xhdXNlDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9jbG9jay9zdGFyZml2ZSxqaDgxMDAtbndjcmcueWFtbCMNCj4g
PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQo+ID4gKw0KPiA+ICt0aXRsZTogU3RhckZpdmUgSkg4MTAwIE5vcnRoLVdlc3QgQ2xvY2sgYW5k
IFJlc2V0IEdlbmVyYXRvcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBTaWEg
SmVlIEhlbmcgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gKw0KPiA+ICtwcm9w
ZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogc3RhcmZpdmUsamg4
MTAwLW53Y3JnDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
Kw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBNYWluIE9zY2lsbGF0b3IgKDI0IE1IeikNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
QVBCX0JVUyBjbG9jayBmcm9tIFNZU0NSRw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBBUEJf
QlVTX1BFUjQgY2xvY2sgZnJvbSBTWVNDUkcNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogU1BJ
X0NPUkVfMTAwIGNsb2NrIGZyb20gU1lTQ1JHDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IElT
UF8yWCBjbG9jayBmcm9tIFNZU0NSRw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBJU1BfQVhJ
IGNsb2NrIGZyb20gU1lTQ1JHDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFZPVVRfUk9PVDAg
Y2xvY2sgZnJvbSBTWVNDUkcNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogVk9VVF9ST09UMSBj
bG9jayBmcm9tIFNZU0NSRw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBWT1VUX1NDQU5fQVRT
IGNsb2NrIGZyb20gU1lTQ1JHDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFZPVVRfRENfQ09S
RSBjbG9jayBmcm9tIFNZU0NSRw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBWT1VUX0FYSSBj
bG9jayBmcm9tIFNZU0NSRw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBBWElfNDAwIGNsb2Nr
IGZyb20gU1lTQ1JHDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFIQjAgY2xvY2sgZnJvbSBT
WVNDUkcNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogUEVSSF9ST09UX1BSRU9TQyBmcm9tIFNZ
U0NSRw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBFeHRlcm5hbCBEVlAgY2xvY2sNCj4gPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogRXh0ZXJuYWwgSVNQIERQSFkgVEFQIFRDSyBjbG9jaw0KPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBFeHRlcm5hbCBnb2xiYWwgY2xvY2sNCj4gDQo+IFR5cG86
IGdsb2JhbA0KT29wcy4gV2lsbCBmaXggaXQuIFRoYW5rcy4NCj4gDQo+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IEV4dGVybmFsIFZPVVQgTUlQSSBEUEhZIFRBUCBUQ0sNCj4gPiArICAgICAgLSBk
ZXNjcmlwdGlvbjogRXh0ZXJuYWwgVk9VVCBlRFAgVEFQIFRDSw0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBFeHRlcm5hbCBTUEkgSW4yIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246
IFBMTDUNCj4gPiBbLi4uXQ0KDQo=

