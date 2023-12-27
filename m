Return-Path: <linux-kernel+bounces-11873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9481ECC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB0F1F22D98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B04539C;
	Wed, 27 Dec 2023 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Id6ZTeqW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578A810;
	Wed, 27 Dec 2023 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BR74JMR072362;
	Wed, 27 Dec 2023 01:04:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703660659;
	bh=hnnfHqgz179kATbvfTGpxdrhknJ7jGa8G+KMwn7NUKw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=Id6ZTeqWCdeS9WsKUiki9Qdm+lndjkqjCKsC7Vaww9BGtxKUpmQcuHhMlnSo7mf7a
	 v9zd8gxdAmSGb1YhyfV+awDXT5c1waI+TNFo4RIK+1yr7wfoUgxwvyRTClucf7ypVu
	 C+kPISGfN96+Pq60olMZnZfJZ8jWLKQhebH8cdZo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BR74Jdd035271
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Dec 2023 01:04:19 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 01:04:18 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 27 Dec 2023 01:04:18 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Lu, Kevin"
	<kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
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
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Thread-Index: AQHaM/ZoVp/s6ZS3j0yS0WAx9ZwYwbC0R4MAgAAcOACACFkVgA==
Date: Wed, 27 Dec 2023 07:04:18 +0000
Message-ID: <d6e28ecdb1e3458f9e8626a77483c6ab@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <ZYReyHQxMAe-DKq4@smile.fi.intel.com>
 <2eeb19a0-5851-4684-836c-36ec53db6900@linaro.org>
In-Reply-To: <2eeb19a0-5851-4684-836c-36ec53db6900@linaro.org>
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
Y2VtYmVyIDIyLCAyMDIzIDE6MzIgQU0NCj4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPjsgRGluZywgU2hlbmdoYW8NCj4gPHNoZW5naGFvLWRp
bmdAdGkuY29tPg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3Jn
OyByb2JoK2R0QGtlcm5lbC5vcmc7IEx1LA0KPiBLZXZpbiA8a2V2aW4tbHVAdGkuY29tPjsgWHUs
IEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsZ2lyZHdvb2RAZ21haWwuY29tOyBwZXJleEBwZXJleC5jejsgcGllcnJlLQ0KPiBsb3Vpcy5i
b3NzYXJ0QGxpbnV4LmludGVsLmNvbTsgMTM5MTYyNzUyMDZAMTM5LmNvbTsgbGludXgtDQo+IHNv
dW5kQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlh
bS5yLmdpcmR3b29kQGludGVsLmNvbTsgc295ZXJAaXJsLmh1OyB0aXdhaUBzdXNlLmRlOyBHdXB0
YSwgUGVleXVzaA0KPiA8cGVleXVzaEB0aS5jb20+OyBOYXZhZGEgS2FueWFuYSwgTXVrdW5kIDxu
YXZhZGFAdGkuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgMS81XSBB
U29DOiBkdC1iaW5kaW5nczogcmVtb3ZlIHRhczI1NjMNCj4gZnJvbSB5YW1sDQo+IA0KPiBPbiAy
MS8xMi8yMDIzIDE2OjUwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gT24gVGh1LCBEZWMg
MjEsIDIwMjMgYXQgMDY6MTM6NDFQTSArMDgwMCwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPj4g
UmVtb3ZlIHRhczI1NjMgZnJvbSB0YXMyNTYyLCBpdCB3aWxsIGJlIHN1cHBvcnRlZCBpbiB0YXMy
NzgxIHRvDQo+ID4+IGJldHRlciBzdXBwb3J0IGRzcCBtb2RlLg0KPiA+DQo+ID4gRFNQDQo+ID4N
Cj4gPiBTaG91bGRuJ3QgdGhpcyBwYXRjaCBnbyBhZnRlciB0aGUgYWN0dWFsIGNoYW5nZSBoYXBw
ZW4/DQo+IA0KPiBJIHdvdWxkIHNxdWFzaCBib3RoLCBzbyBkZXZpY2UgZG9jdW1lbnRhdGlvbiBk
b2VzIG5vdCBkaXNhcHBlYXIuDQpJIGRvIG5vdCBmdWxseSB1bmRlcnN0YW5kICJzcXVhc2ggYm90
aCIsIGRvIHlvdSBtZWFuIHN0aWxsIHRvIGtlZXAgdGksdGFzMjU2MyBpbiB0YXMyNTYyLnlhbWw/
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

