Return-Path: <linux-kernel+bounces-12486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECF81F57E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A251C21BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D524411;
	Thu, 28 Dec 2023 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R6qifvzd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4263A8;
	Thu, 28 Dec 2023 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BS7T6GX096132;
	Thu, 28 Dec 2023 01:29:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703748546;
	bh=1Uahl43zbK1id3/87lEalQn37aSnZ4WpUUa39zZb3Is=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=R6qifvzdgPmB0YLKuoj+5GPMJagxsTt3Ho3J7ZH3/ll4WFoBsI8j5jBtXonPk9GL/
	 KxiS5GVmH1Hz3aDvU+4i7xOQmSwKuuQV2md+G5RJmdkQt+c33DuPz+k3xR9qjysO+j
	 1FfQZtaS5t61c/ZLePpEylHcZI5T1KGC+UBz2Reg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BS7T6QV111122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 01:29:06 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 01:29:05 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 28 Dec 2023 01:29:05 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Gergo Koteles <soyer@irl.hu>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada
 Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for
 different laptops
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for
 different laptops
Thread-Index: AQHaNaoeYIgT67EOakulK8pd+rbBkbC9bFGAgADmKdA=
Date: Thu, 28 Dec 2023 07:29:05 +0000
Message-ID: <4c924d6a31b54bdba36ce8f71f143fb5@ti.com>
References: <20231223141242.676-1-shenghao-ding@ti.com>
 <313b19531261e5b94870043be7bdd4666176f562.camel@irl.hu>
In-Reply-To: <313b19531261e5b94870043be7bdd4666176f562.camel@irl.hu>
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
c295ZXJAaXJsLmh1Pg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDI3LCAyMDIzIDc6NDEg
UE0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1kaW5nQHRpLmNvbT47IGxpbnV4LWZp
cm13YXJlQGtlcm5lbC5vcmcNCj4gQ2M6IEx1LCBLZXZpbiA8a2V2aW4tbHVAdGkuY29tPjsgWHUs
IEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47DQo+IDEzOTE2Mjc1MjA2QDEzOS5jb207IGxpbnV4
LXNvdW5kQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEd1cHRhLCBQZWV5dXNoIDxwZWV5dXNoQHRpLmNvbT47IE5hdmFkYQ0KPiBLYW55YW5hLCBNdWt1
bmQgPG5hdmFkYUB0aS5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MV0g
QVNvQzogdGFzMjc4MTogQWRkIGRzcCBmaXJtd2FyZSBmb3INCj4gZGlmZmVyZW50IGxhcHRvcHMN
Cj4gDQo+IEhpIFNoZW5naGFvLA0KPiANCj4gT24gU2F0LCAyMDIzLTEyLTIzIGF0IDIyOjEyICsw
ODAwLCBTaGVuZ2hhbyBEaW5nIHdyb3RlOg0KPiA+DQo+ID4gK0xpY2VuY2U6IEFsbGVnZWRseSBH
UEx2MissIGJ1dCBubyBzb3VyY2UgdmlzaWJsZS4gTWFya2VkOg0KPiA+ICsJIENvcHlyaWdodCAo
QykgMjAyMyBUZXhhcyBJbnN0cnVtZW50cw0KPiA+ICsNCj4gPiArRm91bmQgaW4gaGV4IGZvcm0g
aW4ga2VybmVsIHNvdXJjZS4NCj4gDQo+IElzIHRoaXMgdHJ1ZT8gSXNuJ3QgdGhpcyBhIG5ldyBk
cml2ZXI/DQpNYXliZSBmb2xsb3dpbmcgZXhwcmVzc2lvbiB3aWxsIGJlIG1vcmUgY2xlYXINCkZp
cm13YXJlIHdpbGwgYmUgZm91bmQgaW4gaGV4IGZvcm0gaW4gdGhlIHN5c3RlbS4NCj4gDQo+ID4g
XCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQo+ID4gZGlmZiAtLWdpdCBhL3RpL3RhczI3ODEv
VEFTMlhYWDM4N0QuYmluIGIvdGkvdGFzMjc4MS9UQVMyWFhYMzg3RC5iaW4NCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+DQo+IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAuLjNjZTQwYWU5ZDcxNTcyNzA5MmJmZg0KPiBlMWUxOGE2DQo+ID4gYTdlNTBl
YTQxZWVkDQo+ID4gR0lUIGJpbmFyeSBwYXRjaA0KPiA+IGxpdGVyYWwgNjQ1MDQNCj4gDQo+IFJl
Z2FyZHMsDQo+IEdlcmdvDQoNCg==

