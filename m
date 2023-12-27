Return-Path: <linux-kernel+bounces-11876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416DB81ECCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29F72835FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87153AE;
	Wed, 27 Dec 2023 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O6kjzZze"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34563525A;
	Wed, 27 Dec 2023 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BR77Zl1103688;
	Wed, 27 Dec 2023 01:07:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703660855;
	bh=S8XANqzEUlFVt+FoGdRq/iDyZYaLkc11PVXDzSciE74=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=O6kjzZzefMyJ0pDHvDhejjTFGAz5FYN6gqdropRbMAqt+mt8+T8HXjwamxXZPfloQ
	 4ByE3LEkpTzI9grkrGE1O2hg4XCRm7q1fXaJXccjzbBDf7ahJKoMuuD2xayEDQSV/D
	 lLvfeOZiWpxv0TZK7gYTZSLHAKP/wcVu7yC7CsR8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BR77Zjq120426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Dec 2023 01:07:35 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 01:07:35 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 27 Dec 2023 01:07:35 -0600
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
Thread-Index: AQHaM/ZoVp/s6ZS3j0yS0WAx9ZwYwbC0Y5uAgAhaZbA=
Date: Wed, 27 Dec 2023 07:07:35 +0000
Message-ID: <8285d102645b43f6b46b15c99321105a@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <7362295b-4a01-4574-8d96-d10f405eaea0@linaro.org>
In-Reply-To: <7362295b-4a01-4574-8d96-d10f405eaea0@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIERl
Y2VtYmVyIDIyLCAyMDIzIDE6MzEgQU0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1k
aW5nQHRpLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZw0K
PiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b207IEx1LCBLZXZpbg0KPiA8a2V2aW4tbHVAdGkuY29tPjsgWHUsIEJhb2p1biA8YmFvanVuLnh1
QHRpLmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwu
Y29tOyBwZXJleEBwZXJleC5jejsgcGllcnJlLQ0KPiBsb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVs
LmNvbTsgMTM5MTYyNzUyMDZAMTM5LmNvbTsgbGludXgtDQo+IHNvdW5kQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlhbS5yLmdpcmR3b29kQGludGVs
LmNvbTsgc295ZXJAaXJsLmh1OyB0aXdhaUBzdXNlLmRlOyBHdXB0YSwgUGVleXVzaA0KPiA8cGVl
eXVzaEB0aS5jb20+OyBOYXZhZGEgS2FueWFuYSwgTXVrdW5kIDxuYXZhZGFAdGkuY29tPg0KPiBT
dWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgMS81XSBBU29DOiBkdC1iaW5kaW5nczog
cmVtb3ZlIHRhczI1NjMNCj4gZnJvbSB5YW1sDQo+IA0KPiBPbiAyMS8xMi8yMDIzIDExOjEzLCBT
aGVuZ2hhbyBEaW5nIHdyb3RlOg0KPiA+IFJlbW92ZSB0YXMyNTYzIGZyb20gdGFzMjU2MiwgaXQg
d2lsbCBiZSBzdXBwb3J0ZWQgaW4gdGFzMjc4MSB0byBiZXR0ZXINCj4gPiBzdXBwb3J0IGRzcCBt
b2RlLg0KPiANCj4gUGxlYXNlIHByb3ZpZGUgcmF0aW9uYWxlIGluIHRlcm1zIG9mIGJpbmRpbmdz
IGFuZCBoYXJkd2FyZSwgbm90IGluIHRlcm1zIG9mDQo+IGRyaXZlci4gT3IgYXQgbGVhc3Qgbm90
IG9ubHkuIEZvciBleGFtcGxlICJzdXBwb3J0ZWQgaW4gdGFzMjc4MSIgZG9lcyBub3QgZml0DQo+
IGhhcmR3YXJlIHBhcnQsIHNvIHlvdSBzdXJlIG11c3QgYmUgdGFsa2luZyBhYm91dCBkcml2ZXJz
IHRodXMgd2h5IGRyaXZlcg0KPiBjaGFuZ2Ugd291bGQgYWZmZWN0IGJpbmRpbmdzPw0KVGhpcyBw
YXRjaCBtYWlubHkgY2hhbmdlIHRoZSBiaW5kaW5nLCBub3QgdGhlIGRyaXZlciBjb2RlLiBUYXMy
NTYzIGlzIHVuYm91bmQgDQp0byB0YXMyNTYyIGRyaXZlciwgYW5kIGJvdW5kIHRvIHRhczI3ODEg
ZHJpdmVyLg0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

