Return-Path: <linux-kernel+bounces-94866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6CB87461E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9181C219E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679516AA7;
	Thu,  7 Mar 2024 02:34:29 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5019634;
	Thu,  7 Mar 2024 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778868; cv=fail; b=JZas4rZgeBgNU6ysOQkMFWejqbey2eysYBYPQlT9g2YTnH0rBjcOx7X+7SkH31x5N2tl/naK/4RCS7LHZmdE/zMa7Qi0aNPJxKlrBv6X14PdAu79f5/boyhiIQm24mCtLfFhGb+CKR3vGqHJfbHAGbOVfBItR0AKPdMiqA169aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778868; c=relaxed/simple;
	bh=dbgoSZPaurA3+Qd7tmqaiLAQg8jvh4l2+mirmKI2oqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDtr71Nyhvm1c3MDgVjXm7uqsDmQLndN/lPfO5mj2qlhfs1UMfdtCIBjNRY2UviSfyZHiZHy5snN/gA/XLp2gaQaQ434nkF9sqSQlLo1pxfW4ag2OMDFM7GFvZ6e6CXm/HoP9rr7dURKt98UmQbiLz0rgBis9oPbP/384d8zUC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lup/3YTil2Mt8gpGh/1YeJOWCKU8MnlYtMtoL4J8pqRrHy5lFmVgwRXgb96o0GfuAtmRoI1lf/iU1Bl016kxUMjXFW0p8XBElcTFjEIvjXgk0HSQgmVyhJuJsauAgrY6WYSMtXRzcAoDgGcHpxlziJ8V2vEZQC5UAmxlgCdQhZT6HhoCRJwRvGAXW8aa3FgkAspEUyvmQe/47+q3W9YEnmyAvBirlBReE2sig6JkLEtnibW32Y/DO9VY3BilkXB1tYOFSt7aIYNSWIptWuaaM2EO4vxcbKahCZIKPQ17UBnzdaedElDjUls33P6yQcEMtidE07iiNySm7hXvKbwX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbgoSZPaurA3+Qd7tmqaiLAQg8jvh4l2+mirmKI2oqw=;
 b=Sdk1fBkop/+iBPQOCupW6/lndRKuZR47sqEHkWuMXhalKN7bDtP0c/ZMUC2loEgMmZSOOzmhef1sc1jY37Ptxbg7YZI+XkoRkKiTegZr7VeClrjlKNnB57P5XnsfECJoeJ+T7WZW6Tca85nkYtOCGxEBfz9h0YXYANnGBQVGbFgB8IYL8+Qo+V4Yzh1CvuQLCUVfRpGUiLQolepoOKcdIstBC2O6GQCAmSqZeHx/WKsnY0zVRN7uXAuwGQLaVIOQNEzhfYHV1yrEcK/uO7IS5m3n95uR9qsRa/WtTFpSw00UjpjI42bmUoWd1vSGSeHh3o6AQwVLDhkDC4+EE1yWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0830.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Thu, 7 Mar
 2024 02:34:22 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 7 Mar 2024 02:34:22 +0000
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
 =?gb2312?B?u9i4tDogW1BBVENIIHYxIDYvN10gc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZl?=
 =?gb2312?Q?:_Add_raw_output_stride_configure?=
Thread-Topic: [PATCH v1 6/7] staging: media: starfive: Add raw output stride
 configure
Thread-Index: AQHab6lkXpps/NWpKkmPBb2aSQFk77EqxTSAgADKoGA=
Date: Thu, 7 Mar 2024 02:34:22 +0000
Message-ID:
 <SHXPR01MB0671B5F66CAD90EC6C991593F220A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-7-changhuang.liang@starfivetech.com>
 <9f346733-320d-4a7c-95d8-1eb2e5cec22e@moroto.mountain>
In-Reply-To: <9f346733-320d-4a7c-95d8-1eb2e5cec22e@moroto.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0830:EE_
x-ms-office365-filtering-correlation-id: 7f2885fd-1bd4-49b0-f509-08dc3e4f1926
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LtrqniFFXh64Qvy6l9AIom0xZBpLDwEh3b33ulIEI6tmNLfSGTEQtgdTmoN4C5kPrSVcYG8Ickg8xyePfDy0dkduWjQ5dv1DuIOr9K3OOzcVCJokqx6p6s1flkbITdO+hHB98lhWJqVAupMuT36iSYi4pWadY8yB6cHBXxd+rUE1pS2kdZhudN3aHaTaf8Oq5nGv/PXJMJYrRo0h/zDb+/uiBrx0xsJGxW7ceUII+Y63Zb/8nxY+IrpDkGKHSYbo49uI3Mk9pj23Sr7giX7exEkVskPl298qcfkSKO0E4q/6ofXlS/+XjhFtCK3+CcFBv6KXS3U3mKfaYSTtx7Dc76HNrWTtJbT3GnX/mh3SrInw6lo4i6gdMj3I0sMqrdOz27d57EjANJ6nd2eYwHdgq/3H3o6+n9Vk6qZNzEtm0ail2BhbZZeAESvZpmkvqFQ6fBiKORLBPLh88RBls6hOrxPdpVhOt54uMFn0CTL7gfap2rkXLBlqQ49cfWEin+GMNmJqWxY6B5w79ZeZMmZjHMkPxhoaZNpCMayahcvBsePw5QAH3QxcWAp6isGPQ6IauM9kfeyKlN0gsNPLTikO2TiXDxdPir+tCJWcFyA1JrBju7ZlHDdJq/9RPJE+umK9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RjNCUGk0MjZSMEQ5RWZ3cGdWVG11b1JYUHJYMm00c1ZDRzVnMjZtUU4rM3k2?=
 =?gb2312?B?b3IxUnU4ZG9uT0lSYnZsMVFyTXkxNWdjNFhzTVdWamtPM2c2endwbEEzUmpu?=
 =?gb2312?B?cTlkT1owcGZLRDE3dEpRb2NERlB4KzRGM1UyT0s4cndNblUyZTBnVU1KKzQ4?=
 =?gb2312?B?NXpnNzE1d2c1b1pzN2pVTzV1MWFSdXFGd3pOZm9vc29VTmFHZXdHeWZZMmhE?=
 =?gb2312?B?bXVxWWZLN2FESDk5Z25UbFVhWWNKYTZrY1dDUC9XSWtqQU11U1ZnT1hJd1Ja?=
 =?gb2312?B?ak82VEVqRWkrekY1U0gyUDZRbDQ2ZVJ0UDFsd3FFVUhvckJ3TmVTbEdTRE11?=
 =?gb2312?B?M1V2RklNTGV4L1ZhYWM0dlVWVlF1VUtTTy9qUXIzT0QxY2xEY1A2aG9MRHUz?=
 =?gb2312?B?UC9hQWpBcmRkcEIyRy9Xc1UzbGNvYlgwSlZWZnhxdnNFYi93Tm91S3MyajZz?=
 =?gb2312?B?Uzg3ekVrSnJ4MmZVcmwvRmMwMGFQdjRlTVJvZmlpWGxtRUJ2WGRXZG44cjl0?=
 =?gb2312?B?akVDeVA3VHBudEEwVG8rckNIMWVBVGlKN1R2Vm1DbTNKQmVrUGxITWg1V1BJ?=
 =?gb2312?B?T3B2Q1Z2SThxVzlFSXRWaElMTnlGQUdoWThoSEJiZHNSREJrcVJQVFVDYU01?=
 =?gb2312?B?YlROdHptZDJsWEQzaVJRa2tWV2lOUzRtajFJSy8vTERYTjJzRW0yUUErUEMz?=
 =?gb2312?B?R213eUFpU3crMkVLdW1iRzRSWFhUOUl1cG5qZGpUUmJ0YVByVjlqNHJvazYw?=
 =?gb2312?B?cFJUYzRZMGh5UGpxV2FnejZiZUxHTERHWTNENVo1RFdxNXJyZ1E3RjN3MHBt?=
 =?gb2312?B?MXRySkR0N0RRb1gwcEt5Y1AxMnJJaldnUHMvWHZpaS9ydGFYYmVObWh0MUI1?=
 =?gb2312?B?aytOeklpb2ZmZnhOeXk0TjBTekptdzg5R2pLazFHb2x1R0pNQlRpNXZ3R0h0?=
 =?gb2312?B?c3kyQzNkMTJobHd2SWpqWkxnOS9JelJ0NklrVGtaMit4MGNTKzY0TVdLVHJa?=
 =?gb2312?B?MnM1bFJjL0RyZFptazJuempmK1kydWhzWkdpaHBWYnphbDlQR1pubGIxaUdp?=
 =?gb2312?B?V1ZMeEs5L3N3OGMyL0lLTnhDSHBQVWhCRnlDbFVTMzdya3RtRFdpTllGOVIz?=
 =?gb2312?B?TVN4VXlvbk1zbGNrSkNMcG5NRFA5OWE2anN5Rm12czJQVi8ydmsvTDFPeDM5?=
 =?gb2312?B?Mkd5UjBKOXdORlppYjhUeHZSTE1ybHVyL0MxVGpjRVRncmRzV0FiK0JDRkQv?=
 =?gb2312?B?OW10di9NM3VPeVd0eVVmZWdIS0kwemZwbmZHRStaRG5uY3ZOdXZiMmY0Z3Jz?=
 =?gb2312?B?allIZHgyNno3bGZvY0pEMEQvelVjZWJ3Q0NmZm81cTBMdzZiMjZhY2pGZktp?=
 =?gb2312?B?bG9DL0NlL3Q5R0d5OXljOUZTbi9HaHdwTEVYeGQrWCtLWk81dG1FSGZxTWgv?=
 =?gb2312?B?bDcwR2RCelRIVDc1ZzV4czl1WEEzU002akJaNXNneFV4ZUFrWnVZd29jUjZl?=
 =?gb2312?B?WUJMNDluYmhqQVljWjdWTTJzVjhyc2dFMDVNaW1kTXF5WXYrSDMrd1VJNVI3?=
 =?gb2312?B?MXE1VEZTdXY2YlZpM3NGcjRBenJYdWR1TTV1ZDNQSjRLRXZldzdxd0x6T25X?=
 =?gb2312?B?Tlg5NElXNVlYSkQ2UjVETUwxMlhaUXFnVWN5QmxSalRBTWxKWlhUUFVKVitD?=
 =?gb2312?B?SmlpY3RoVkc2dkhCdUZ2WU9WdGtyUWJVYjF0VUZ4Nm1vcjFhZ3lKV2RMTmN3?=
 =?gb2312?B?bUU4amlYM2N1ZXg2ZzUycjdLaW1uWVljSjJKSTJPLzVhM2dwcFR0WTJhUnhw?=
 =?gb2312?B?dS9Zank2bnFyS1RhbXRZNGZJT1pzK3VtTkFZdG8zRGFLY28rOVZibGpYTkxT?=
 =?gb2312?B?aFRKTXVHbTVqRFg5Z0t4UmhhT1E5MlJmY1JoM0FqVUlwcGdWMHdyVEswUTlo?=
 =?gb2312?B?Y1p3U2dXRVp2aFRMRkRxaWk0L2RQd1NSUXlNc0V4bjkvamh3bGI0UUg3ZlA2?=
 =?gb2312?B?UXgraXh5WFg5VGVLNGY5aDgwMVBmcE4vSEQ5U1pOclNWN3VyajdQenhzTDhH?=
 =?gb2312?B?a1FsVGZBUmxBb2tuTjhvUkxWaTE5Q0pucUxQMVA2WDBtWHJoSUdwUjNFVlBV?=
 =?gb2312?B?SjE1WFlLNWdHYkU0VGRzVTgySHA1TWsrOFhKSHFZYXVickhBalQrUGZwNldU?=
 =?gb2312?B?akE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2885fd-1bd4-49b0-f509-08dc3e4f1926
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:34:22.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ohm1UFZKnP9i+mnDXI5lligzK3MPbnInDNyIfO2mlFV/T8DQipAeJWmFBkZpwLbnI+E0esgsBitHaHvWFqJ6bI2NiYpSi1DI8ShKtqNiOho77pMBYtd+apzTluFM1h4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0830

SGksIERhbg0KDQo+IE9uIFdlZCwgTWFyIDA2LCAyMDI0IGF0IDAxOjMzOjMzQU0gLTA4MDAsIENo
YW5naHVhbmcgTGlhbmcgd3JvdGU6DQo+ID4gQWRkIHJhdyBvdXRwdXQgc3RyaWRlIHRvIGVuYWJs
ZSBzZW50IHRoZSBhbGlnbmVkIHJhdyBkYXRhIHRvIG1lbW9yeS4NCj4gPg0KPiANCj4gU3ViamVj
dDogc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZlOiBGaXggcmF3IG91dHB1dCBzdHJpZGUgY29uZmln
dXJhdGlvbg0KPiANCj4gSSB0aGluayB0aGlzIGlzIGJ1Z2ZpeD8gIFdoYXQgaXMgdGhlIGltcGFj
dCBvZiB0aGlzIGNoYW5nZSB0byB0aGUgdXNlcj8NCj4gDQo+IEJ1dCBJIGNhbid0IHJlYWxseSB1
bmRlcnN0YW5kIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgaXQncyBoYXJkIHRvIHJldmlldyB0aGUN
Cj4gY29kZSB3aXRob3V0IGJlaW5nIGFibGUgdG8gYXBwbHkgaXQuICBJJ20gYWxzbyBuZXcgdG8g
dGhpcyBzdWJzeXN0ZW0gc28NCj4gbWF5YmUgc29tZW9uZSBlbHNlIHdvdWxkIGhhdmUgYmVlbiBh
YmxlIHRvIHVuZGVyc3RhbmQgaXQgYmV0dGVyLi4uDQo+IFNvcnJ5Li4uDQo+IA0KDQpZb3UgY2Fu
IHRyeSB0byBhcHBseSBpdCBvbiB0YWcgdjYuOC1yYzcuDQoNCjEuIA0KQXBwbHlpbmc6IHN0YWdp
bmc6IG1lZGlhOiBzdGFyZml2ZTogUmVuYW1lZCBjYXB0dXJlX3JhdyB0byBjYXB0dXJlX2R1bXAN
Cg0KMi4gDQpBcHBseWluZzogc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZlOiBSZXBsYWNlZCBjdXJy
ZW50X2ZtdCB3aXRoIGdldCBmcm9tIHNkX3N0YXRlDQpBcHBseWluZzogc3RhZ2luZzogbWVkaWE6
IHN0YXJmaXZlOiBBZGQgcmF3IHBhZCBmb3IgSVNQDQpBcHBseWluZzogc3RhZ2luZzogbWVkaWE6
IHN0YXJmaXZlOiBTaW5rIHJlY3RhbmdsZSBzZXQgdG8gSVNQIHNvdXJjZSBwYWQNCkFwcGx5aW5n
OiBzdGFnaW5nOiBtZWRpYTogc3RhcmZpdmU6IEFkZCBtdWx0aSBzdHJlYW1zIGZvciBJU1ANCkFw
cGx5aW5nOiBzdGFnaW5nOiBtZWRpYTogc3RhcmZpdmU6IEFkZCBJU1AgcmF3IHZpZGVvIGRldmlj
ZQ0KQXBwbHlpbmc6IHN0YWdpbmc6IG1lZGlhOiBzdGFyZml2ZTogQWRkIHJhdyBvdXRwdXQgc3Ry
aWRlIGNvbmZpZ3VyZQ0KQXBwbHlpbmc6IGFkbWluLWd1aWRlOiBtZWRpYTogVXBkYXRlIGRvY3Vt
ZW50cyBmb3IgU3RhckZpdmUgQ2FtZXJhIFN1YnN5c3RlbQ0KDQpSZWdhcmRzLA0KQ2hhbmdodWFu
Zw0K

