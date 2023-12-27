Return-Path: <linux-kernel+bounces-12039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21481EF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A22C1F21C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45645019;
	Wed, 27 Dec 2023 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QvvjZhiU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9D44C87;
	Wed, 27 Dec 2023 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRDj5YI026292;
	Wed, 27 Dec 2023 07:45:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703684705;
	bh=uQnVFQgOxFICd14iOj+b6LrPl6NWvE/dXUyz36ElLNM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=QvvjZhiUAUjEDbOnHw/j+3zQ9kDfhv9z/UBSbQl3aGbl6jWzObfmwIdqZ3xh4tdmh
	 7G76TLxrxPVvNLwwyLyCi1QPpvln12Q36hqG64pTKH7qW02PD7s2Jy2QKsAeB1oN8a
	 cw/74KDP7ea9zHiklDfB0AVf4MYrU27XhiC7vA00=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRDj4JM057289
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Dec 2023 07:45:05 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 07:45:04 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 27 Dec 2023 07:45:03 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
	<navada@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Thread-Index: AQHaM/ZoVp/s6ZS3j0yS0WAx9ZwYwbC0Y5uAgAhaZbCAAKVTgP//xSNw
Date: Wed, 27 Dec 2023 13:45:03 +0000
Message-ID: <f102855dd1904036b14b9c80ccc469c0@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <7362295b-4a01-4574-8d96-d10f405eaea0@linaro.org>
 <8285d102645b43f6b46b15c99321105a@ti.com>
 <ffc11f9c-6643-4e46-8bb2-8918e1179f72@linaro.org>
In-Reply-To: <ffc11f9c-6643-4e46-8bb2-8918e1179f72@linaro.org>
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
IERlY2VtYmVyIDI3LCAyMDIzIDY6NTYgUE0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hh
by1kaW5nQHRpLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgYW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tOyBMdSwgS2V2aW4NCj4gPGtldmluLWx1QHRpLmNvbT47IFh1LCBC
YW9qdW4gPGJhb2p1bi54dUB0aS5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGdpcmR3b29kQGdtYWlsLmNvbTsgcGVyZXhAcGVyZXguY3o7IHBpZXJyZS0NCj4gbG91aXMuYm9z
c2FydEBsaW51eC5pbnRlbC5jb207IDEzOTE2Mjc1MjA2QDEzOS5jb207IGxpbnV4LQ0KPiBzb3Vu
ZEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpYW0u
ci5naXJkd29vZEBpbnRlbC5jb207IHNveWVyQGlybC5odTsgdGl3YWlAc3VzZS5kZTsgR3VwdGEs
IFBlZXl1c2gNCj4gPHBlZXl1c2hAdGkuY29tPjsgTmF2YWRhIEthbnlhbmEsIE11a3VuZCA8bmF2
YWRhQHRpLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIIHYyIDEvNV0gQVNvQzogZHQtYmlu
ZGluZ3M6IHJlbW92ZQ0KPiB0YXMyNTYzIGZyb20geWFtbA0KPiANCj4gT24gMjcvMTIvMjAyMyAw
ODowNywgRGluZywgU2hlbmdoYW8gd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMjIsIDIw
MjMgMTozMSBBTQ0KPiA+PiBUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRpbmdAdGkuY29t
PjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiA+PiBjb25vcitkdEBrZXJuZWwub3JnDQo+ID4+IENj
OiByb2JoK2R0QGtlcm5lbC5vcmc7IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsg
THUsIEtldmluDQo+ID4+IDxrZXZpbi1sdUB0aS5jb20+OyBYdSwgQmFvanVuIDxiYW9qdW4ueHVA
dGkuY29tPjsNCj4gPj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxnaXJkd29vZEBnbWFp
bC5jb207IHBlcmV4QHBlcmV4LmN6Ow0KPiA+PiBwaWVycmUtIGxvdWlzLmJvc3NhcnRAbGludXgu
aW50ZWwuY29tOyAxMzkxNjI3NTIwNkAxMzkuY29tOyBsaW51eC0NCj4gPj4gc291bmRAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaWFtLnIuZ2ly
ZHdvb2RAaW50ZWwuY29tOyBzb3llckBpcmwuaHU7IHRpd2FpQHN1c2UuZGU7IEd1cHRhLA0KPiA+
PiBQZWV5dXNoIDxwZWV5dXNoQHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFk
YUB0aS5jb20+DQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MiAxLzVdIEFT
b0M6IGR0LWJpbmRpbmdzOiByZW1vdmUNCj4gPj4gdGFzMjU2MyBmcm9tIHlhbWwNCj4gPj4NCj4g
Pj4gT24gMjEvMTIvMjAyMyAxMToxMywgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPj4+IFJlbW92
ZSB0YXMyNTYzIGZyb20gdGFzMjU2MiwgaXQgd2lsbCBiZSBzdXBwb3J0ZWQgaW4gdGFzMjc4MSB0
bw0KPiA+Pj4gYmV0dGVyIHN1cHBvcnQgZHNwIG1vZGUuDQo+ID4+DQo+ID4+IFBsZWFzZSBwcm92
aWRlIHJhdGlvbmFsZSBpbiB0ZXJtcyBvZiBiaW5kaW5ncyBhbmQgaGFyZHdhcmUsIG5vdCBpbg0K
PiA+PiB0ZXJtcyBvZiBkcml2ZXIuIE9yIGF0IGxlYXN0IG5vdCBvbmx5LiBGb3IgZXhhbXBsZSAi
c3VwcG9ydGVkIGluDQo+ID4+IHRhczI3ODEiIGRvZXMgbm90IGZpdCBoYXJkd2FyZSBwYXJ0LCBz
byB5b3Ugc3VyZSBtdXN0IGJlIHRhbGtpbmcNCj4gPj4gYWJvdXQgZHJpdmVycyB0aHVzIHdoeSBk
cml2ZXIgY2hhbmdlIHdvdWxkIGFmZmVjdCBiaW5kaW5ncz8NCj4gPiBUaGlzIHBhdGNoIG1haW5s
eSBjaGFuZ2UgdGhlIGJpbmRpbmcsIG5vdCB0aGUgZHJpdmVyIGNvZGUuIFRhczI1NjMgaXMNCj4g
PiB1bmJvdW5kIHRvIHRhczI1NjIgZHJpdmVyLCBhbmQgYm91bmQgdG8gdGFzMjc4MSBkcml2ZXIu
DQo+IA0KPiBUaGVuIHdoeSBkbyB5b3UgcmVmZXJlbmNlIGRyaXZlciAidGFzMjc4MSIgaGVyZT8N
CkJvdGggdGFzMjU2MyBhbmQgdGFzMjc4MSBhcmUgZHNwLWluc2lkZSBhdWRpbyBhbXBsaWZpZXIs
IA0KdGFzMjc4MSBkcml2ZXIgaXMgZGVzaWduZWQgZm9yIGRzcC1pbnNpZGUgc2VyaWVzIGNoaXBz
LCANCm5vdCBvbmx5IGZvciB0YXMyNzgxLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCg0K

