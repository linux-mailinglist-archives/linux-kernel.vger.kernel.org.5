Return-Path: <linux-kernel+bounces-94850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9EB8745E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4721F25BC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED976112;
	Thu,  7 Mar 2024 02:07:01 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAE4C98;
	Thu,  7 Mar 2024 02:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777221; cv=fail; b=qsaq3FYdDKfs/b0VFgAyCH1c3MzDr9TYcvUdtKCFcrmVI7DFegud3u2Pp2jZWR8rGx2Wb0R4zHQiprLgT7oamfHf8O73ZMil6gFy6hd0+zWp/Q5e8cWpq8HZhjHot76yftThCGzfTotzAFBdDIytfv24Hj/DxomwhH4pDuxMIWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777221; c=relaxed/simple;
	bh=bwMkcnHep40Ot8OQSaKz/O/k3Rt+41OmBhzuB37FArw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQVcpY9XmFwh6WY659NkdM0Fr1HGVIn5cvbTdKmsvSFQbNkTNBQHqUppMnMnXhijR462eKFjDg20TM4C4RdDEVoe7+JFZUHPwbKlQUeSRhkjwKar89x/56QhamJl8krlRub06gH/KdjJGQJB84pfKEQE7auTqQkrsLGVglrp3jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHmUdBsdPGpO/3Eh0ImInEv7of7/zgF73y4DhGs36yWfpGFI0Nurw/N6zEr3mFHDljNzYSVxdh6b7wUY+x3kKmUd2fFZxRL4lhYtXJrA5E5b5nJGxrhsvwvVKHu1QasqZAGKtBywkUzmLdZcIUn/3vDfEYmrb5G1s+z1D0HtEKlvA0bcD5Eg2T+vQG659WpcZeGbfAQoO1khRrcN16wIKoP7BxWPf4sGd6pIYq0Fvvc75oxmRXBU3VrvJvNtVPmg3hzSxnd6nz8Zcsm86qPQHsXq7DHCIf18zHrZnTrmA6ZoIncDh770j4ulO0GEwz1PoUx3+6X2Bm44p50OTuvwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwMkcnHep40Ot8OQSaKz/O/k3Rt+41OmBhzuB37FArw=;
 b=DaKcREvOb8z0gYVfgre42jNDqcLujiC/1CaEbA++1fVOF9obLjKSnkPVqR2h9df0/ijoSbkJenJ5VCTl+b6bzvFfyVRiuZKrEuY3djKY/kNYqYenDxhXYMcag5bwDlhX02riNOl8IvPQVlx4Wrkw+u3NZ2lhs0uigAbZifHuL1/gwVy0U3/JkYDRDZu7hbNc+8zvxOBMlt8btVCEc/5yhZjgYkSH3J/Dn7Ld70Ndqv7hE7EqWC25c3MWYITPQapIMCQaSPlKMZzJBUc9wEAoZILhVrwbLUSkii37/WMYCpT6Li9T3hgAgVxbM8gXEytD6Lw8/KaZQnKyuHWfosg7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0799.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Thu, 7 Mar
 2024 02:06:54 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 7 Mar 2024 02:06:54 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxIDIvN10gc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZl?=
 =?gb2312?Q?:_Add_raw_pad_for_ISP?=
Thread-Topic: [PATCH v1 2/7] staging: media: starfive: Add raw pad for ISP
Thread-Index: AQHab6liNM8G+dS+v0e9QtwEQzWL2rEqxGsAgADCv2A=
Date: Thu, 7 Mar 2024 02:06:54 +0000
Message-ID:
 <SHXPR01MB0671B1E1146F4262749ED88BF220A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-3-changhuang.liang@starfivetech.com>
 <4d54e516-448a-47ce-abcd-e705896935a7@moroto.mountain>
In-Reply-To: <4d54e516-448a-47ce-abcd-e705896935a7@moroto.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0799:EE_
x-ms-office365-filtering-correlation-id: a7225a5d-5583-43fe-946d-08dc3e4b42f2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H33t2YR3YtiEe0AqKWuLmkkgrtGW6zr9V7C70HhqIVrjCMRYIhLERo3BNm1SmlTbijiSgs8oCDESbFrQUko7Bg5b9I0tLdNw6wIlQ4+TFpENNl4hRIHXM1zfVkYUThAtwBCLr7xi0OGEAa006r/6EHhfFmkWIYVOTid8sQ/TcAQDobGvfe/dFbaTN+rt1/RLK8+ARrJp9ep+L3XI8kagznvGPBnjrjJOOYDm563DTf5QR6U/NCmOGaKfjyFaRMrXSiV7mVlHgqzNpgraOEh0whBql6bL4yZVAAAB1cIsw2zqWo0V9SDIhcr0tmqUljfTlbicX2FxLoDwxVccMiswzkMBam1Wcj8Biw5Pb1/SPIlMu3Kmi+fakcn0i2lVw4rmZKT9qtTZVpBe5qUyFrnQIzMO23LYcfkiSuQ8AVLVQHh8qRwtxYVV6pFHx3LTp5+Aty7qAwFBcc/C1AGzRcjDqamSPNVX7FXm7o/sT6RpE4W72qfjT4DcFk2Dyw2poyAH1XAtMqAK/Th/iFNNUtO1xfvQz7GrEmQqmmJeb3o9+5RtA5crh1rREAZHiLk3TDlFYczvLhj2gqsyTeEaj8y0hARnt9IgD0U1Hw3VTEaCCa3DmkqnZEBInU0hvl9mijOO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T05oSEtBbTBxQ0IwWDk4aXIxa1pHL3NPSlpMQ2JLd3QrMUcvQTdOTk9kdm9u?=
 =?gb2312?B?QldBbzhUNDJaaitzajBiN3B4VERadDZObU16eFpKOUc1ak1ZM2NKa1dOSmwx?=
 =?gb2312?B?WlpJNVg2ME1KREdGWHVqb2UyZCtuMW96UlRWcEFlMk85TXhZcnRPY0ZhdlBO?=
 =?gb2312?B?aFJhQzMyMmtZUkdRYTN6VmZNWEpCUXYvR1BML0lHRmI5MVk2NHU5YWVUQU8y?=
 =?gb2312?B?QlR6azZ4SFByVElFYzFxbjNnZXNhOUt3SHFBQ1lVK2lTQXhxTkt6U3Buc0ty?=
 =?gb2312?B?dVFzeWtZUzZWb0FkcG1MSE84Q0pKeDhaQjdxbHZUMnFIVndxVDZZOEtWRnJB?=
 =?gb2312?B?K3FQajVPQ1VQdlY4ckovaVRtT0U5d2V3ekNSaFF1NVBiaXZwMDV3Wmc3YjFQ?=
 =?gb2312?B?WlhNaWhRR2Mwb2N0UXpibzA2SFVLQnFsTUtydDQ0dDB3SE1SQmZEVE9XOVhX?=
 =?gb2312?B?akErM0d1S1lJNnFFQmdOMlJBZndUcVRkZG12VGQvMnZUa0cxaFJ4Y3ZEVFFR?=
 =?gb2312?B?S1R2SHlQQTVsTnNsQXdtYSs5blZyS2F3emlWUW1adHlXemhtYnVodmhETDA1?=
 =?gb2312?B?ZWxDV0piNklIZFRjRWFPNWRjUi9Ndmg1VzZ6QlUwR0VHVnRSYjd6SGQrNW1p?=
 =?gb2312?B?VzN5Z3RDcXNGZXVnczNFUEdMbStWU0Mwc0VUdFFiV1Axa1FJRGZMbmFVVGNQ?=
 =?gb2312?B?ZlRGY1Z3R0JwMENiYjNzODVFOUNiM3F2MHNOOWRJeXNOZ0tlVXE3Q2lHb05M?=
 =?gb2312?B?ejllQVZwMzUxbGtxUUZpSG9jUXIwZ0xac0tmZ1NDMlB5MkJET3BmQVgyMDEr?=
 =?gb2312?B?UXp4M0dwMEsyQldUdm1uNlZtaTQ4NGw2ODhQeVZUZ25QdVJKZjkxbVQ5SzZF?=
 =?gb2312?B?ZkhzQ3hwK3h2YkNHc1FySDIydTJXOWhjaEl5czhHMXc2UGRPNThyUElWWUVh?=
 =?gb2312?B?R3V1M2pxcVhtR3laNGVFcmNHc0pENzRpTFJsN0U0SVpuQ3J2QmVGdXJ2Ykp0?=
 =?gb2312?B?SFBPV05udUxmdFpWODNMYWg0d2IzWVNubWs0aWRjZTFuQmZhM3RSa2FHbWYy?=
 =?gb2312?B?d3k0U05TQ0pIY0VOWXBVOVVkd3BuT1U0QXJhUElrVytpdmdwK2FZZEs0bE1S?=
 =?gb2312?B?Z3BVMzE2UFBKTXVzYU9JeWFQYlI2RFR0eWtaRXp5UW5wRndMb0UwdVdHSEhR?=
 =?gb2312?B?VnNZY3hrYkdpVklNWjQ2MmhGVG9YWFNKYWhwRm1iY2pKU1Y3bnlZZ1dPNjNz?=
 =?gb2312?B?eE54VmdkcjZSSWRma0VTRVYra2pFSmpNVGliakcvb2ZCd0Fxa2RGdFF0bHd1?=
 =?gb2312?B?a3RXa1NSSzQ3V25ST01FT2ZXbVNadTZoamRSTE9YN1MrRlBCekFCcDBUekpw?=
 =?gb2312?B?dmhBUm1wa3BiR0lhajc0ZVlGS0FLd2xEVGFTbXlFS2hkS0wxcFF1RXhSZUZQ?=
 =?gb2312?B?cjkyMUc3bDdyN1VHZGtNb1M3a1hIeTgxbjRXd3NyR3lVdFI3Q05BMTV1YldZ?=
 =?gb2312?B?Y1RLZGJzbHo4Z0xGaVQrSHdsc0FKc1FGVE1TRGhEczdFUEl0aEhHZ0VsZnMv?=
 =?gb2312?B?Uk5hbnhzeWV3TkVaSnpIZ3JjMzdsQWc5NlI1dXBXTENvR3U2Mkp1elhUb3Nz?=
 =?gb2312?B?QlpMSnNaOUFtVkdmdUFJaDlRUGlFR0dURm9qZlF5eG9IMWtSYm5XM3A4V283?=
 =?gb2312?B?NDFTdzg1OC80dnI0My93V1JuS1pxN21Sdm96ZjlkbXRuTzRGcEtkYlZ6TGtk?=
 =?gb2312?B?clB3dHZrY3Y3dGxXZlVtOVZVVE5SZXBRNk0rbkJ6dmZzb3hTY1RjOGgvb2la?=
 =?gb2312?B?R1dubjhpNDZsMDBTTWlKQzkyU0picWlIdFdoeTltNlpKYUcvQlBJbC9VZHNh?=
 =?gb2312?B?OFFEaUdSdHY1N21FU1orNXZheHNZTDU5MzFTUnpEdXEvMW96Y3FoMmpaT2VC?=
 =?gb2312?B?OEtYdlloM0FuNFh0VEs5dnlzeG1aRTl3ZXZmQ2cvdFkwOEVNbGI2L0NhdkJV?=
 =?gb2312?B?TmYzY0FQZ0EyV0Z0Y1M2c2ZReHZUUDRmQS9iY1lkQXdYYWErajJrNTA2V3dS?=
 =?gb2312?B?YldXM2d1b3pkTElYSGxRa0FPWTlKWG93K3R3MzZBNjYrSWpWOFNBbDBaQTU2?=
 =?gb2312?B?MHliank4Q3VGblM3UzRvUklWY3FoWHltbXVEM2ZONk1ZSjRYVmZxT0kvMUxj?=
 =?gb2312?B?Tmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a7225a5d-5583-43fe-946d-08dc3e4b42f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:06:54.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJboYlcB2hRLoVajUbVj8T6Qa8SnxSP1OlgdQsaSOt+aeZoNujRXGsM2R1eIGBdyV8DGL2LUnFEMtImbpEGspZMSYI7RUX07XDIEmjV95hmRl49FoWyiexLoM6liNnjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0799

SGkgRGFuDQoNCj4gUmU6IFtQQVRDSCB2MSAyLzddIHN0YWdpbmc6IG1lZGlhOiBzdGFyZml2ZTog
QWRkIHJhdyBwYWQgZm9yIElTUA0KPiANCj4gT24gV2VkLCBNYXIgMDYsIDIwMjQgYXQgMDE6MzM6
MjlBTSAtMDgwMCwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBBZGQgcmF3IHBhZCBmb3Ig
SVNQLCBpdCBzdXBwb3J0ZWQgdGhlIGNvbnZlcnNpb24gb2YgUkFXMTAgaW50byBSQVcxMi4NCj4g
Pg0KPiANCj4gVG8gYmUgaG9uZXN0LCBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCAiaXQgc3VwcG9y
dGVkIHRoZSBjb252ZXJzaW9uIG9mDQo+IFJBVzEwIGludG8gUkFXMTIiIG1lYW5zLiAgSSBkb24n
dCB0aGluayB0aGF0IHRoaXMgcGF0Y2ggaGFzIGFueSBpbXBhY3Qgb24NCj4gdXNlciBzcGFjZSBi
dXQgSSdtIG5vdCAxMDAlIHN1cmUuDQo+IA0KDQpGb3IgU3RhckZpdmUgSVNQLCB0aGUgaW5wdXQg
Zm9ybWF0IGlzIFJBVyAxMCwgd2hpY2ggaXMgY29udmVydGVkIHRvIFJBVyAxMiBhZnRlciBJU1Ag
UkFXIHBhZCBvdXRwdXQuDQoNCj4gQSBsb3Qgb2YgdGhpcyBwYXRjaCBpcyBqdXN0IHJlZm9ybWF0
aW5nIHN0dWZmIGFuZCBpdCB3b3VsZCBiZSBlYXNpZXIgdG8gcmV2aWV3IGlmDQo+IHRoZSByZWZv
cm1hdGluZyB3ZXJlIHNlcGFyYXRlZCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2guDQo+IA0KPiBwYXRj
aCAyOiBDbGVhbiBwYWQgc2VsZWN0aW9uIGluIGlzcF90cnlfZm9ybWF0KCkNCj4gDQo+IFRoZSBj
b2RlIHRvIHNlbGVjdCBpc3BfZGV2LT5mb3JtYXRzW10gaXMgb3Zlcmx5IGNvbXBsaWNhdGVkLiAg
V2UgY2FuIGp1c3QgdXNlDQo+IHRoZSAicGFkIiBhcyB0aGUgaW5kZXguICBUaGlzIHdpbGwgbWFr
aW5nIGFkZGluZyBuZXcgcGFkcyBlYXNpZXIgaW4gZnV0dXJlDQo+IHBhdGNoZXMuICBObyBmdW5j
dGlvbmFsIGNoYW5nZS4NCj4gDQo+IHBhdGNoIDM6IEFkZCByYXcgcGFkIGZvciBJU1ANCj4gDQoN
ClllcywgdGhpcyBwYXRjaCBjYW4gYWxzbyBiZSBzcGxpdCBpbnRvIHR3byBwYXRjaGVzDQoNCnJl
Z2FyZHMsDQpDaGFuZ2h1YW5nDQo=

