Return-Path: <linux-kernel+bounces-12715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD281F93B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A231F2415D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3FCA7A;
	Thu, 28 Dec 2023 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZA9LonpL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C2C8DE;
	Thu, 28 Dec 2023 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BSEnTLV018351;
	Thu, 28 Dec 2023 08:49:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703774969;
	bh=2ynkJUQzrsIVlqWt9eFINeUZ70DoltB63aWdoOvAE18=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=ZA9LonpLfLsolcGftxWR+YTjgxmRzEmLssvWRxdeQ22UOq3J10h5uADuLIgoJnYYE
	 r27Wm1q8Y8Gx99TAEtils/mx2jtDmsE6EBp2J5MYw45/FJFYJW4EhxpkSqmp4PkxPp
	 siREqLRq3ICcVYRo+IejJfOURcmHITIfjFaL7Vgg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BSEnTEo026930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 08:49:29 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 08:49:29 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 28 Dec 2023 08:49:29 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Gergo Koteles <soyer@irl.hu>
CC: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada
 Kanyana, Mukund" <navada@ti.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for
 different laptops
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for
 different laptops
Thread-Index: AQHaNaoeYIgT67EOakulK8pd+rbBkbC9bFGAgADmKdCAANGNAP//ql0A
Date: Thu, 28 Dec 2023 14:49:29 +0000
Message-ID: <23e85f35969447ab9161068f2c159845@ti.com>
References: <20231223141242.676-1-shenghao-ding@ti.com>
	 <313b19531261e5b94870043be7bdd4666176f562.camel@irl.hu>
	 <4c924d6a31b54bdba36ce8f71f143fb5@ti.com>
 <95023a6158e1359c18797d7ed10a6914cf781f84.camel@irl.hu>
In-Reply-To: <95023a6158e1359c18797d7ed10a6914cf781f84.camel@irl.hu>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VyZ28gS290ZWxlcyA8
c295ZXJAaXJsLmh1Pg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjgsIDIwMjMgOTo1NSBQ
TQ0KPiBUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRpbmdAdGkuY29tPjsgbGludXgtZmly
bXdhcmVAa2VybmVsLm9yZw0KPiBDYzogTHUsIEtldmluIDxrZXZpbi1sdUB0aS5jb20+OyBYdSwg
QmFvanVuIDxiYW9qdW4ueHVAdGkuY29tPjsNCj4gMTM5MTYyNzUyMDZAMTM5LmNvbTsgbGludXgt
c291bmRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
R3VwdGEsIFBlZXl1c2ggPHBlZXl1c2hAdGkuY29tPjsgTmF2YWRhDQo+IEthbnlhbmEsIE11a3Vu
ZCA8bmF2YWRhQHRpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2
MV0gQVNvQzogdGFzMjc4MTogQWRkIGRzcCBmaXJtd2FyZSBmb3INCj4gZGlmZmVyZW50IGxhcHRv
cHMNCj4gDQo+IEhpIFNoZW5naGFvLA0KPiANCj4gT24gVGh1LCAyMDIzLTEyLTI4IGF0IDA3OjI5
ICswMDAwLCBEaW5nLCBTaGVuZ2hhbyB3cm90ZToNCj4gPiA+IE9uIFNhdCwgMjAyMy0xMi0yMyBh
dCAyMjoxMiArMDgwMCwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gK0xp
Y2VuY2U6IEFsbGVnZWRseSBHUEx2MissIGJ1dCBubyBzb3VyY2UgdmlzaWJsZS4gTWFya2VkOg0K
PiA+ID4gPiArCSBDb3B5cmlnaHQgKEMpIDIwMjMgVGV4YXMgSW5zdHJ1bWVudHMNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArRm91bmQgaW4gaGV4IGZvcm0gaW4ga2VybmVsIHNvdXJjZS4NCj4gPiA+DQo+
ID4gPiBJcyB0aGlzIHRydWU/IElzbid0IHRoaXMgYSBuZXcgZHJpdmVyPw0KPiA+IE1heWJlIGZv
bGxvd2luZyBleHByZXNzaW9uIHdpbGwgYmUgbW9yZSBjbGVhciBGaXJtd2FyZSB3aWxsIGJlIGZv
dW5kDQo+ID4gaW4gaGV4IGZvcm0gaW4gdGhlIHN5c3RlbS4NCj4gDQo+IEFuZCB3aGF0IGFib3V0
IHRoZSBMaWNlbmNlPw0KPiANCj4gSSB3b3VsZCBsaWtlIHRvIGFkZCBUQVMyWFhYMzg3MC5iaW4g
dGhhdCBJIGZvdW5kIGluIG15IGNvbXB1dGVyJ3Mgd2luZG93cw0KPiBzb3VuZCBkcml2ZXIgYXMg
U291cmNlL1RoaXJkUGFydHkvVEkvVEFTMjU2M0Zpcm13YXJlLmJpbiAuDQo+IA0KPiBDb3VsZCB5
b3UgcGxlYXNlIGFkZCBpdCwgb3Igd2lsbCBUSSBnaXZlIHBlcm1pc3Npb24gdG8gcmVkaXN0cmli
dXRlIHRoZXNlIGZpbGVzPw0KPiANCj4gVGhlIHdpbmRvd3MgZHJpdmVyIChpbm5vZXh0cmFjdCBj
b21wYXRpYmxlKToNCj4gaHR0cHM6Ly9kb3dubG9hZC5sZW5vdm8uY29tL2NvbnN1bWVyL21vYmls
ZXMvaDV5ZDAzN2ZiZnl5N2tkMC5leGUNCj4gVGhlIFJDQSBmaWxlIEkgY3JlYXRlZDoNCj4gaHR0
cHM6Ly9naXRodWIuY29tL3NveWVyc295ZXIvdGFzMjU2M3JjYS9yYXcvbWFpbi9JTlQ4ODY2UkNB
Mi5iaW4NCj4gDQpPSywgSSdsbCBhZGQgaW4gb25lIG9yIHR3byBkYXlzLg0KPiANCj4gPiA+DQo+
ID4gPiA+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
dGkvdGFzMjc4MS9UQVMyWFhYMzg3RC5iaW4NCj4gPiA+ID4gYi90aS90YXMyNzgxL1RBUzJYWFgz
ODdELmJpbiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+ID4gPg0KPiANCj4gUmVnYXJk
cywNCj4gR2VyZ28NCg0K

