Return-Path: <linux-kernel+bounces-7709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF24781ABDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FD22872F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0E10F5;
	Thu, 21 Dec 2023 00:45:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420920EA;
	Thu, 21 Dec 2023 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1B8027FDC;
	Thu, 21 Dec 2023 08:45:41 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 08:45:41 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 08:45:40 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Thu, 21 Dec 2023 08:45:40 +0800
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
Thread-Index: AQHaKDp8qa+gHWDJHkGDh0MGWRuwVrCfD58AgAXCtdCAAc4FgIAK2SJwgAA69gCAAUjdgA==
Date: Thu, 21 Dec 2023 00:45:40 +0000
Message-ID: <442fd023a8bf43dfbb4991ac3eafbc05@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
 <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
 <9ae86c6786bc4ac7b93c971ba00084a6@EXMBX066.cuchost.com>
 <CAJM55Z9GVFGuwqe=zLXQvBwDfVSz4eA2EXDd4sqWVCKJF2J+fg@mail.gmail.com>
 <07a8ac42184f440fae1b0d13db4e43cc@EXMBX066.cuchost.com>
 <CAJM55Z9w3PdZMFNhTviBvu-2HE7CXdTVpLvgyecArvs=qa_J=A@mail.gmail.com>
In-Reply-To: <CAJM55Z9w3PdZMFNhTviBvu-2HE7CXdTVpLvgyecArvs=qa_J=A@mail.gmail.com>
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
c2RheSwgRGVjZW1iZXIgMjAsIDIwMjMgOTowOCBQTQ0KPiBUbzogSmVlSGVuZyBTaWEgPGplZWhl
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
Wy4uLl0NCj4gPiA+DQo+ID4gPiBJZiB5b3UncmUganVzdCB1c2luZyB0aGlzIGZvciB0ZXN0aW5n
IG9uIEZQR0FzIHlvdSBjYW4gY3JlYXRlIGR1bW15IGZpeGVkDQo+ID4gPiBjbG9ja3MgaW4gdGhl
IGRldmljZSB0cmVlIGZvciB0aGUgUExMcyB0aGF0IHRoaXMgZHJpdmVyIGNhbiBjb25zdW1lLiAg
VGhlbg0KPiA+ID4gbGF0ZXIgd2hlbiB5b3UgaGF2ZSBhIFBMTCBkcml2ZXIgeW91IGNhbiByZXBs
YWNlIHRob3NlIGZpeGVkIGNsb2NrcyB3aXRoIHRoZQ0KPiA+ID4gb3V0cHV0IG9mIHRoYXQgZHJp
dmVyLg0KPiA+IFRoZSBQTEwgZml4ZWQgY2xvY2tzIHdlcmUgY3JlYXRlZCBpbiB0aGUgQyBjb2Rl
LiBJIGludGVycHJldCB0aGlzIG1lc3NhZ2UNCj4gPiBhcyBhIHN1Z2dlc3Rpb24gdG8gY3JlYXRl
IGEgUExMIGZpeGVkIGNsb2NrIGluIHRoZSBEVD8NCj4gDQo+IFllcywgdGhlbiB5b3UgZG9uJ3Qg
bmVlZCB0byBjaGFuZ2UgdGhlIGNsb2NrIGRyaXZlciBhbmQgaXRzIGJpbmRpbmdzIGJ1dCBqdXN0
DQo+IG5lZWQgdG8gdXBkYXRlIHRoZSBjbG9jayByZWZlcmVuY2VzIHRvIHRoZSBQTEwgZHJpdmVy
IG9uY2UgeW91IGhhdmUgdGhhdC4NCk9rLg0KPiANCj4gL0VtaWwNCg==

