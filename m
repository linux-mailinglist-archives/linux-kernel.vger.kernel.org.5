Return-Path: <linux-kernel+bounces-15682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A4982303B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2A1B23465
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF611A72E;
	Wed,  3 Jan 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TLRuqsbi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82551B263;
	Wed,  3 Jan 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403FASPW025082;
	Wed, 3 Jan 2024 09:10:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704294628;
	bh=Vt9QrGHEnTOVih0V0nSpTMHVPAN4yrOKFzPkWDhGEA8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=TLRuqsbi7U83X12j0yjnflN+fV9IbvImgCjmTUsN3792zK4ysrO+18iFcHL88/Bjd
	 IMRvAdLRjaFgpB3CeCIWEdLiyZZwOT8QfDj1Eyo49mDs/4r/0YSPZLOBWdtCg7QPXS
	 XFvW5zci2aXtY1U0EFmSZcVbx5uz4+FLfwRDzCSU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403FASYI046611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jan 2024 09:10:28 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 09:10:27 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 3 Jan 2024 09:10:27 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "Lu,
 Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund"
	<navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/4] ASoC: dt-bindings: move tas2563
 from tas2562.yaml to tas2781.yaml
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/4] ASoC: dt-bindings: move tas2563
 from tas2562.yaml to tas2781.yaml
Thread-Index: AQHaOaLNhXkp3XvRtEGPJulwx8+ksbDIIOQAgAAWRpA=
Date: Wed, 3 Jan 2024 15:10:27 +0000
Message-ID: <6ae4809eca654fa49929fc81720a0687@ti.com>
References: <20231228153024.1659-1-shenghao-ding@ti.com>
 <9315a1ea-5ebe-47b7-a108-4a72b647bb4f@linaro.org>
In-Reply-To: <9315a1ea-5ebe-47b7-a108-4a72b647bb4f@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMywgMjAyNCAzOjM4IFBNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8t
ZGluZ0B0aS5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmcN
Cj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tOyBMdSwgS2V2aW4NCj4gPGtldmluLWx1QHRpLmNvbT47IFh1LCBCYW9qdW4gPGJhb2p1bi54
dUB0aS5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGdpcmR3b29kQGdtYWls
LmNvbTsgcGVyZXhAcGVyZXguY3o7IHBpZXJyZS0NCj4gbG91aXMuYm9zc2FydEBsaW51eC5pbnRl
bC5jb207IDEzOTE2Mjc1MjA2QDEzOS5jb207IGxpbnV4LQ0KPiBzb3VuZEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpYW0uci5naXJkd29vZEBpbnRl
bC5jb207IHNveWVyQGlybC5odTsgdGl3YWlAc3VzZS5kZTsgR3VwdGEsIFBlZXl1c2gNCj4gPHBl
ZXl1c2hAdGkuY29tPjsgTmF2YWRhIEthbnlhbmEsIE11a3VuZCA8bmF2YWRhQHRpLmNvbT4NCj4g
U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHY0IDEvNF0gQVNvQzogZHQtYmluZGluZ3M6
IG1vdmUgdGFzMjU2Mw0KPiBmcm9tIHRhczI1NjIueWFtbCB0byB0YXMyNzgxLnlhbWwNCj4gDQo+
IE9uIDI4LzEyLzIwMjMgMTY6MzAsIFNoZW5naGFvIERpbmcgd3JvdGU6DQo+ID4gTW92ZSB0YXMy
NTYzIGZyb20gdGFzMjU2Mi55YW1sIHRvIHRhczI3ODEueWFtbCB0byB1bmJpbmQgdGFzMjU2MyBm
cm9tDQo+ID4gdGFzMjU2MiBkcml2ZXIgY29kZSBhbmQgYmluZCBpdCB0byB0YXMyNzgxIGRyaXZl
ciBjb2RlLCBiZWNhdXNlDQo+ID4gdGFzMjU2MyBvbmx5IHdvcmsgaW4gYnlwYXNzLURTUCBtb2Rl
IHdpdGggdGFzMjU2MiBkcml2ZXIuIEluIG9yZGVyIHRvDQo+ID4gZW5hYmxlIERTUCBtb2RlIGZv
ciB0YXMyNTYzLCBpdCBoYXMgYmVlbiBtb3ZlZCB0byB0YXMyNzgxIGRyaXZlci4gQXMNCj4gPiB0
byB0aGUgaGFyZHdhcmUgcGFydCwgc3VjaCBhcyByZWdpc3RlciBzZXR0aW5nIGFuZCBEU1AgZmly
bXdhcmUsIGFsbA0KPiA+IHRoZXNlIGFyZSBzdG9yZWQgaW4gdGhlIGJpbmFyeSBmaXJtd2FyZS4g
V2hhdCB0YXMyNzgxIGRyaXZkZXIgZG9vZXMgaXMNCj4gPiB0byBwYXJzZSB0aGUgZmlybXdhcmUg
YW5kIGRvd25sb2FkIGl0IHRvIHRoZSBjaGlwLCB0aGVuIHBvd2VyIG9uIHRoZQ0KPiA+IGNoaXAu
IFNvLCB0YXMyNzgxIGRyaXZlciBjYW4gYmUgcmVzdWVkIGFzIHRhczI1NjMgZHJpdmVyLiBPbmx5
DQo+ID4gYXR0ZW50aW9uIHdpbGwgYmUgcGFpZCB0byBkb3dubG9hZGluZyBjb3JyZXNwb25kaW5n
IGZpcm13YXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmdoYW8gRGluZyA8c2hlbmdo
YW8tZGluZ0B0aS5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiBDaGFuZ2UgaW4gdjQ6DQo+ID4gIC0g
cmVtb3ZlIHRhczI1NjMsIHdoaWNoIHdpbGwgYmUgbW92ZSB0byB0YXMyNzgxIGRyaXZlci4NCj4g
PiAgLSBBZGQgbW9yZSBjb21tZW50cyBvbiB3aHkgdG8gbW92ZSB0YXMyNTYzIHRvIHRhczI3ODEg
ZHJpdmVyLg0KPiA+ICAtIFByb3ZpZGUgcmF0aW9uYWxlIGluIHRlcm1zIG9mIGJpbmRpbmdzIGFu
ZCBoYXJkd2FyZSwgbm90IGluIHRlcm1zIG9mDQo+IGRyaXZlci4NCj4gPiAgICBPciBhdCBsZWFz
dCBub3Qgb25seS4NCj4gPiAgLSBSZW9yZGVyIGNoaXAsIHRhczI1NjMgaXMgZmlyc3QsIHRhczI3
ODEgaXMgc2Vjb25kLg0KPiA+ICAtIEFkZCBkYXRhc2hlZXQgbGlua2luZ3MuDQo+ID4gIC0gc3F1
YXNoIGJvdGggdGFzMjU2MiBhbmQgdGFzMjc4MSBiaW5kaW5nIHBhdGNoZXMuDQo+ID4gIC0gUHV0
IGFsbE9mOiB0byB0aGUgZW5kIG9mIHRoZSBmaWxlLCBhZnRlciByZXF1aXJlZDogYmxvY2suDQo+
ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RhczI1NjIueWFtbCAg
ICB8ICAyIC0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvdGksdGFzMjc4MS55
YW1sIHwgODUNCj4gPiArKysrKysrKysrKysrKy0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NjQgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RhczI1NjIueWFtbA0KPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RhczI1NjIueWFtbA0K
PiA+IGluZGV4IGYwMWMwZGRlMGNmNy4uZDI4YzEwMmMwY2U3IDEwMDY0NA0KPiA+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC90YXMyNTYyLnlhbWwNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvdGFzMjU2Mi55YW1s
DQo+ID4gQEAgLTE4LDcgKzE4LDYgQEAgZGVzY3JpcHRpb246IHwNCj4gPg0KPiA+ICAgIFNwZWNp
ZmljYXRpb25zIGFib3V0IHRoZSBhdWRpbyBhbXBsaWZpZXIgY2FuIGJlIGZvdW5kIGF0Og0KPiA+
ICAgICAgaHR0cHM6Ly93d3cudGkuY29tL2xpdC9ncG4vdGFzMjU2Mg0KPiA+IC0gICAgaHR0cHM6
Ly93d3cudGkuY29tL2xpdC9ncG4vdGFzMjU2Mw0KPiA+ICAgICAgaHR0cHM6Ly93d3cudGkuY29t
L2xpdC9ncG4vdGFzMjU2NA0KPiA+ICAgICAgaHR0cHM6Ly93d3cudGkuY29tL2xpdC9ncG4vdGFz
MjExMA0KPiA+DQo+ID4gQEAgLTI5LDcgKzI4LDYgQEAgcHJvcGVydGllczoNCj4gPiAgICBjb21w
YXRpYmxlOg0KPiA+ICAgICAgZW51bToNCj4gPiAgICAgICAgLSB0aSx0YXMyNTYyDQo+ID4gLSAg
ICAgIC0gdGksdGFzMjU2Mw0KPiA+ICAgICAgICAtIHRpLHRhczI1NjQNCj4gPiAgICAgICAgLSB0
aSx0YXMyMTEwDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL3RpLHRhczI3ODEueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RpLHRhczI3ODEueWFtbA0KPiA+IGluZGV4IGE2OWU2YzIy
MzMwOC4uNzhkODkwMDhjMzZmIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC90aSx0YXMyNzgxLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvdGksdGFzMjc4MS55YW1sDQo+ID4gQEAgLTUs
MzYgKzUsNDEgQEANCj4gPiAgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3Vu
ZC90aSx0YXMyNzgxLnlhbWwjDQo+ID4gICRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+DQo+ID4gLXRpdGxlOiBUZXhhcyBJbnN0cnVtZW50
cyBUQVMyNzgxIFNtYXJ0QU1QDQo+ID4gK3RpdGxlOiBUZXhhcyBJbnN0cnVtZW50cyBUQVMyNTYz
L1RBUzI3ODEgU21hcnRBTVANCj4gPg0KPiA+ICBtYWludGFpbmVyczoNCj4gPiAgICAtIFNoZW5n
aGFvIERpbmcgPHNoZW5naGFvLWRpbmdAdGkuY29tPg0KPiA+DQo+ID4gLWRlc2NyaXB0aW9uOg0K
PiA+IC0gIFRoZSBUQVMyNzgxIGlzIGEgbW9ubywgZGlnaXRhbCBpbnB1dCBDbGFzcy1EIGF1ZGlv
IGFtcGxpZmllcg0KPiA+IC0gIG9wdGltaXplZCBmb3IgZWZmaWNpZW50bHkgZHJpdmluZyBoaWdo
IHBlYWsgcG93ZXIgaW50byBzbWFsbA0KPiA+IC0gIGxvdWRzcGVha2Vycy4gQW4gaW50ZWdyYXRl
ZCBvbi1jaGlwIERTUCBzdXBwb3J0cyBUZXhhcyBJbnN0cnVtZW50cw0KPiA+IC0gIFNtYXJ0IEFt
cCBzcGVha2VyIHByb3RlY3Rpb24gYWxnb3JpdGhtLiBUaGUgaW50ZWdyYXRlZCBzcGVha2VyDQo+
ID4gLSAgdm9sdGFnZSBhbmQgY3VycmVudCBzZW5zZSBwcm92aWRlcyBmb3IgcmVhbCB0aW1lDQo+
ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhlIFRBUzI1NjMvVEFTMjc4MSBpcyBhIG1vbm8s
IGRpZ2l0YWwgaW5wdXQgQ2xhc3MtRCBhdWRpbw0KPiA+ICsgIGFtcGxpZmllciBvcHRpbWl6ZWQg
Zm9yIGVmZmljaWVudGx5IGRyaXZpbmcgaGlnaCBwZWFrIHBvd2VyIGludG8NCj4gPiArICBzbWFs
bCBsb3Vkc3BlYWtlcnMuIEFuIGludGVncmF0ZWQgb24tY2hpcCBEU1Agc3VwcG9ydHMgVGV4YXMN
Cj4gPiArICBJbnN0cnVtZW50cyBTbWFydCBBbXAgc3BlYWtlciBwcm90ZWN0aW9uIGFsZ29yaXRo
bS4gVGhlDQo+ID4gKyAgaW50ZWdyYXRlZCBzcGVha2VyIHZvbHRhZ2UgYW5kIGN1cnJlbnQgc2Vu
c2UgcHJvdmlkZXMgZm9yIHJlYWwgdGltZQ0KPiA+ICAgIG1vbml0b3Jpbmcgb2YgbG91ZHNwZWFr
ZXIgYmVoYXZpb3IuDQo+ID4NCj4gPiAtYWxsT2Y6DQo+ID4gLSAgLSAkcmVmOiBkYWktY29tbW9u
LnlhbWwjDQo+ID4gKyAgU3BlY2lmaWNhdGlvbnMgYWJvdXQgdGhlIGF1ZGlvIGFtcGxpZmllciBj
YW4gYmUgZm91bmQgYXQ6DQo+ID4gKyAgICBodHRwczovL3d3dy50aS5jb20vbGl0L2dwbi90YXMy
NTYzDQo+ID4gKyAgICBodHRwczovL3d3dy50aS5jb20vbGl0L2dwbi90YXMyNzgxDQo+ID4NCj4g
PiAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+IC0gICAgZW51bToNCj4gPiAt
ICAgICAgLSB0aSx0YXMyNzgxDQo+ID4gLQ0KPiA+IC0gIHJlZzoNCj4gPiAtICAgIGRlc2NyaXB0
aW9uOg0KPiA+IC0gICAgICBJMkMgYWRkcmVzcywgaW4gbXVsdGlwbGUgdGFzMjc4MXMgY2FzZSwg
YWxsIHRoZSBpMmMgYWRkcmVzcw0KPiA+IC0gICAgICBhZ2dyZWdhdGUgYXMgb25lIEF1ZGlvIERl
dmljZSB0byBzdXBwb3J0IG11bHRpcGxlIGF1ZGlvIHNsb3RzLg0KPiA+IC0gICAgbWF4SXRlbXM6
IDgNCj4gPiAtICAgIG1pbkl0ZW1zOiAxDQo+ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgbWlu
aW11bTogMHgzOA0KPiA+IC0gICAgICBtYXhpbXVtOiAweDNmDQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogfA0KPiA+ICsgICAgICB0aSx0YXMyNTYzOiA2LjEtVyBCb29zdGVkIENsYXNzLUQgQXVkaW8g
QW1wbGlmaWVyIFdpdGggSW50ZWdyYXRlZA0KPiA+ICsgICAgICBEU1AgYW5kIElWIFNlbnNlLCAx
Ni8yMC8yNC8zMmJpdCBzdGVyZW8gSTJTIG9yIG11bHRpY2hhbm5lbCBURE0uDQo+ID4gKw0KPiA+
ICsgICAgICB0aSx0YXMyNzgxOiAyNC1WIENsYXNzLUQgQW1wbGlmaWVyIHdpdGggUmVhbCBUaW1l
IEludGVncmF0ZWQgU3BlYWtlcg0KPiA+ICsgICAgICBQcm90ZWN0aW9uIGFuZCBBdWRpbyBQcm9j
ZXNzaW5nLCAxNi8yMC8yNC8zMmJpdCBzdGVyZW8gSTJTIG9yDQo+ID4gKyAgICAgIG11bHRpY2hh
bm5lbCBURE0uDQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAg
ICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHRpLHRhczI1NjMNCj4gPiArICAg
ICAgICAgIC0gY29uc3Q6IHRpLHRhczI3ODENCj4gPiArICAgICAgLSBlbnVtOg0KPiA+ICsgICAg
ICAgICAgLSB0aSx0YXMyNzgxDQo+ID4gKw0KPiA+ICsgIHJlZzogdHJ1ZQ0KPiANCj4gbWluL21h
eEl0ZW1zIG11c3Qgc3RheSBoZXJlDQo+IA0KPiBJIGFscmVhZHkgcmVtaW5kZWQgdGhpcyBpbiB2
My4NCkhvdyB0byBleHByZXNzIG1heEl0ZW1zIGlzIDQgZm9yIHRhczI1NjMgb24gdGhlIHNhbWUg
aTJjIGJ1cyhvbmx5IDQgZGlmZmVyZW50IGkyYyBhZGRyZXNzZXMpIA0KYW5kIG1heEl0ZW1zIGlz
IDggZm9yIHRhczI3ODEgb24gdGhlIHNhbWUgaTJjIGJ1cyAoOCBkaWZmZXJlbnQgaTJjIGFkZHJl
c3NlcykgaGVyZS4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

