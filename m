Return-Path: <linux-kernel+bounces-94842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045308745D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ED01F25BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A9B5C82;
	Thu,  7 Mar 2024 01:58:57 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8136139;
	Thu,  7 Mar 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776736; cv=fail; b=uaQSayS+W7cPqfAcFa3ZKxXgE4pgMMwbwouKVb5wU54YSIS4HEKDQXeclVQMuvnDji+/a/t3vKNwodW7acgxbPoOoiGEWbf2g/eKN1LA2Vk2uezeHI50p2rSybGdtWymsYJeefq08XtTsxnIsvEIAOOcJ/EEuBSLM8nV6TRPHB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776736; c=relaxed/simple;
	bh=ndvShWH0t82nxD8Gjx5lqLTEGm3QGCLKNvlfbMyg7ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlHGRBseRM/ANuJ52J8653oMCZPUz+UlrYrHRFqv2HxfNcamMXytec8cRRpLrHh4IP99ej9dEPuXqJufEaaz42MoitbCCREtYfR17MAw8DxK51dlcjxjoFEVf81AhrLd9tE/HPaXpieexQkTENE2u6GPqS3ycLIDKrA7fjftsQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTTfzg3+nMXAG9q4mzJkkdqclRWJ+JoZsV7r2mm8vYtO1u3HhB8BhxrG+Lq5N9B2aQ40j3/lkS0wHS2IULhifR+Y5T7bSNh034pln72bseblp3WFSXqGHouSPzSQHlAcGyS+vWQnviRjhlY7tjCglRH6Ep6ImavcKnTpmqeOKVu29kGp4+oDXuGFZCu966OGdYP6q0FQ9ZRHcTlf1N1MFxF6FvsNolPt8nXspFnx7WSGz/77kLvFfwZC5WKF8hoQL0anc/5g5JZQG806nvgfNkguET33MMLZaaJVcCTFPkLpEleF7Au5CHdrfdZVMdFBSU3YLt054Sodv106JpOvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndvShWH0t82nxD8Gjx5lqLTEGm3QGCLKNvlfbMyg7ps=;
 b=YHqwjL+ylEkmKg8IiRx9+T1WEaIH1sKJ8QHdvGmPbEBJGPKyJaJQSa7USZ+GpKfSYg8+U5YbWYCtSdLHA6zYQb+9tZeCSMvIxSu8W1uSIP0aMF2JRsHxw0ZvXnmlJI409rBF7sdkadZjSi0meg7V9obgn+Bealc92M7yyso5fgFLCeMfDsyA/ppX0x+QFZzyPpCsKlGZhI26s3gm4dAO2N1x5JfSIZuL+QUWbhGhD43smRpJLLo1fTal75qtaJVsNgRscgpO2YtMCLaRK/KQWfWygUuAcDKkvRSNAHDnVmyNGmhkkmJzXNUeM3pKiEMCC9X0Hfo885cgsIBFyumGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0639.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Thu, 7 Mar
 2024 01:58:50 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 7 Mar 2024 01:58:49 +0000
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
 =?gb2312?B?u9i4tDogW1BBVENIIHYxIDEvN10gc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZl?=
 =?gb2312?B?OiBSZXBsYWNlZCBjdXJyZW50X2ZtdCB3aXRoIGdldCBmcm9tIHNkX3N0YXRl?=
Thread-Topic: [PATCH v1 1/7] staging: media: starfive: Replaced current_fmt
 with get from sd_state
Thread-Index: AQHab6lh+h+3gieBvE+NYK6US9XDs7EqxEcAgADBSAA=
Date: Thu, 7 Mar 2024 01:58:49 +0000
Message-ID:
 <SHXPR01MB0671F91D3D83EAB515B94CB0F220A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-2-changhuang.liang@starfivetech.com>
 <8a0cf244-1cb7-48a5-a900-1f82877d1e2f@moroto.mountain>
In-Reply-To: <8a0cf244-1cb7-48a5-a900-1f82877d1e2f@moroto.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0639:EE_
x-ms-office365-filtering-correlation-id: e211fe1c-3624-4abb-cf9e-08dc3e4a21f5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZzWOxBY0RqDW2q6Q6pE+lur62Q4SvjTj9LtTzMAZSpd/+rAxlGhSK8/E5amQDK8ZUSlQVN5AY2kEKqYiWPWN5cRGwTtB7cUKwqSMNZCja4wwakG4xeUByaJvvPni0J8syQg5pDLUwuCfueYxImiNfQedinRiR7WkLCNh9OF77MAPxqm2GnyBy937asnQd/J6Yfjy5NzQ0OoQpGDFWw4v51bgVwrivdVlN0GXCObmaAzLTPNDtLIDCDIhROqYRzVPzdDc29ffz2NqyjX1Ei9Fe0VeL8JIu1anIYifR68tQN8ZYfD9sqZQRushST1CcqbGdg82/Y+34+ISq5GeoW6tq0g0SBebof3VeWg5sk3JE0u2rQf9gNm8wJqBfS61tLW4HdUtOOF3j5RV79XNAwsyAOkX9bgKxAXbBItq0YnnwyuTJ33r4hd46NvatMlMHzdrPScY8qWvvBeD+dMFHNeH3mZ/IKOqY5cDADU8Dt0seIz90qMlqhZeKyfLeRB286b+R88DmlVE/tLXUcV6w/8GW6iXFpNIRmMgN94FWAn2InBJv08UnIs72gxZ+ZqdMT6oP7z6pnF0DgNg+livaLuyPpPrzM4lxCXx9oHFgWsowML4mKTWDHL5EQQrqhKO7YZU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NlhzaGVJSjZTY0Y5eFl4dEtjNTk3MVFCN1MxNlNzTzU1aHh1Ti9vRFVsSDJ6?=
 =?gb2312?B?WDRNSDduanNRR3VGbW92Q2FvQUw3d2ZTVEowZUhvS2ljeTgvZ25qT3Z5VkR0?=
 =?gb2312?B?VG5Gcm9VYjljRytxRzhvUWt4cjJTTVF6WFliMzYwR1pIaGx2dTZEdWUyYnYr?=
 =?gb2312?B?aVd4UkJPVHZIU0F0V0pjRkIzMmsxT1hndVhCZlNRUTlpTTd4TzQ5MnhIbzBG?=
 =?gb2312?B?R2hvckliRGc3RXk5aHZraFdRaXJveWNjL0RHRE9YZldUOGdoRlpQeVY1cVpu?=
 =?gb2312?B?MENXNnZhZnJIdmVmNkVkcjBkTVdNcUZ1Skk4STc2VzA1QStFWG1VU1FkTXNz?=
 =?gb2312?B?RHYvOGY4M0xaNzJoK3dHdndEZ0NDSmVRaHRSRy83TGJtR3lhR3NkYkZyTFlX?=
 =?gb2312?B?YW9WY1RiM2tvNHo0SUNwWjNXRVdoR0ZpSVpHK0h5VFRWbEZYR3hIbFdtY2s3?=
 =?gb2312?B?eG12SXBUU2FBTitRSFUwQU9sOWlWUXJlSEpzdWFyNVUvNWtFMDE0OG41Mmgr?=
 =?gb2312?B?ajY4UzJraTYySGFLNGFuYUNyUFBsSGtPTVcrd2VGODkxcnNIc2FmQTJjSjl6?=
 =?gb2312?B?a2JLcEJxNzhUSHVxSmF5eDE2eFRoWXREV2tkd1cxV3VkSzE2ZWZ6dEI2SVpF?=
 =?gb2312?B?Uk9uakY4RUo1dkorV2xpRlFJSStyY2d5alVNMGwvTlc0bWdUOEo3VHU3MEY5?=
 =?gb2312?B?dURibjY5enRyVkExaG5SNFJEMXFJckluNVJHUWpEOFhGOUhzVnVNY1hhdWNF?=
 =?gb2312?B?ajhSdzIzNjdoSnBuMTdHdGdwMGp3NGJIVUZiNEY2RThwZkhieFptdzgrcU5h?=
 =?gb2312?B?ais4NTFpcEoyUXFheXVyN3NHWjZkZEdkZktkekdSamsxY01hUnhlYVBlVEhS?=
 =?gb2312?B?SXNqT29oQmVRcnhlOTkyVERjSTJkSGRCeWRnL0QwdlhOMmNFYjhXZUJ5ck8r?=
 =?gb2312?B?VExoMEJkUFN3R1lsamNlejd4UHVMWGpQWEVoUXJZcTlpMFFMOVJxeGdWYUpp?=
 =?gb2312?B?cVRGNEZ1N3UrME1FckRsbUN1bTM1WHhFM0VwOXZjYVN2TUk5M2NhVGlRWUR0?=
 =?gb2312?B?ajl5MjNFRHJObFE2OW8xSXJrVjNDYzdTYXE2aWtxN1FVU3JmY2ZNVk1QZ1Z0?=
 =?gb2312?B?aEhlVTkyNXFLcDlLWnZaeHBISVJjNmdPZFFVRlMvYWM1TWVmSnkwSmFZY3dT?=
 =?gb2312?B?RVpscVJUY3pkdXVCQ2N5OWZKOVRvRkhQdlF3RVNQR2QwREhGVkMzc2xwaTNH?=
 =?gb2312?B?MmV2bUx0VHhkNFRhOCs4THMydmhCVTQwRXF5UDBHWVcvWGExM2JJaGI1a3FC?=
 =?gb2312?B?ODR0S2VBeXR0UFFLcWFMeUlWdUFwWmNUVzhpcUJwSUdUTVhiN01VWjkybUdL?=
 =?gb2312?B?OWtBTitYdDVXY3BiYWZqOTloOVN2cE9vUXhHelRWK1J1aEpXeE5sSFB3Z3oy?=
 =?gb2312?B?VkQ3Z0dqejRINGs3elAzeFV6S2ZaVU4wVUQyU0FxSk13elRQVlRtSFdQV0ts?=
 =?gb2312?B?NW16THVyNm5JM0lPMVAzaDlLTHQ3QTJCMUp3blVocVRiQWluQXVTMG5GT0VH?=
 =?gb2312?B?Nk1HcHdNa3FuVW9DRTNTN0g1VlNpUnBybmJWdmowVHAvbUtmU054dmxMODBl?=
 =?gb2312?B?WURlUk1yVlpaL1hvd3JLbmdBODFISXl0WHRkQ0M3bFhpZ2N5V29uemZRdzF4?=
 =?gb2312?B?WTFGbk5PdVA1ZnptZmRHWHErQ0tuOCtWYUNjZkdpdElXL0NRYUVzWnpVU0hv?=
 =?gb2312?B?YnBzS1ZYWnVlcE5oSEdGTnRkbnJBNXc1RSs3SnJGZVZ6UkZUWW52SEN0TXNq?=
 =?gb2312?B?K0R2dy91NnoxV1lHZzFmRzJCeEZSVDdWRmc4NVZ0TWxVNFFidTcrOVM2a2tk?=
 =?gb2312?B?OXhabEtQY2lvSHlZam5CQVI5ZnJORGk4MGRRQXpSOHVEcU5NRzFHTUx1SGZZ?=
 =?gb2312?B?ckpQL0ltQ285Rk9OaUVjaW1ubTV6T09yQlh5N1lpdVBQN0pBNW5FWk1GZ1hu?=
 =?gb2312?B?bVYxZG9aOS9QaXdjK3VBVTNPWnB1U2MwWThDSzFYSG5IRC82OXVQb1dYbkdQ?=
 =?gb2312?B?emVITm02OExxTHdLSUVKVzlUQ094MUJGVkhNV3o4cGp2bU5JZXBQTWMxYms5?=
 =?gb2312?B?SVUxR0FpNkl3S3pjWVBTaXVBSU9wcGlxcVhLUFV4ZlRMQWhaWW9yaE1zT2Qr?=
 =?gb2312?B?blE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e211fe1c-3624-4abb-cf9e-08dc3e4a21f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 01:58:49.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtYQAWYEGpBNVDakIoU6u7AHQ63MoGgaaxql8dv+E/QBCUAtvdchD2uvIPYHEkfMJwJ2XzFKo0RtvQ6NoGr34Nn7ZacyDfWQ9rdZHxjT3qajYc5TEflbbmicpZsrCcib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0639

SGksIERhbg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQoNCj4gLS0tLS3Tyrz+1K28/i0t
LS0tDQo+ILeivP7IyzogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0K
PiC3osvNyrG85DogMjAyNMTqM9TCNsjVIDIyOjIzDQo+IMrVvP7IyzogQ2hhbmdodWFuZyBMaWFu
ZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiCzrcvNOiBNYXVybyBDYXJ2
YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2Nv
QHhzNGFsbC5ubD47DQo+IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNv
bmJvYXJkLmNvbT47IEphY2sgWmh1DQo+IDxqYWNrLnpodUBzdGFyZml2ZXRlY2guY29tPjsgbGlu
dXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1zdGFnaW5nQGxpc3RzLmxpbnV4LmRldg0KPiDW98ziOiBSZTogW1BBVENIIHYxIDEv
N10gc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZlOiBSZXBsYWNlZCBjdXJyZW50X2ZtdCB3aXRoDQo+
IGdldCBmcm9tIHNkX3N0YXRlDQo+IA0KPiBPbiBXZWQsIE1hciAwNiwgMjAyNCBhdCAwMTozMzoy
OEFNIC0wODAwLCBDaGFuZ2h1YW5nIExpYW5nIHdyb3RlOg0KPiA+IGN1cnJlbnRfZm10IG9ubHkg
Y2FuIHN0b3JlIG9uZSBwYWQgZm9ybWF0LCB3aGVuIHNldHRpbmcgb3RoZXIgcGFkIGl0DQo+ID4g
d2lsbCBiZSBvdmVyd3JvdGUuIFJlcGxhY2VkIGl0IHdpdGggZ2V0IGZyb20gc2Rfc3RhdGUgZGly
ZWN0bHkuDQo+ID4NCj4gDQo+IFRoZXNlIGNvbW1pdCBkZXNjcmlwdGlvbnMgYXJlIGtpbmQgb2Yg
aGFyZCB0byB1bmRlcnN0YW5kIHNvIEkgaGF2ZSBwcm9wb3NlZA0KPiBuZXcgY29tbWl0IG1lc3Nh
Z2VzLg0KPiANCj4gU3ViamVjdDogc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZlOiBHZXQgcmlkIG9m
IGN1cnJlbnRfZm10DQo+IA0KPiBXZSB3YW50IHRvIHN1cHBvcnQgbXV0aXBsZSBmb3JtYXRzIHNv
IHNhdmluZyBvbmUgImN1cnJlbnRfZm10IiBkb2Vzbid0DQo+IHdvcmsuICBUaGlzIHdhcyBvbmx5
IHVzZWQgdG8gc2V0IHRoZSBJU1BfUkVHX1NUUklERSBzbyB1c2UgdGhlIHNkX3N0YXRlDQo+IGRp
cmVjdGx5IGZvciB0aGF0IGFuZCBkZWxldGUgdGhlIC0+Y3VycmVudF9mbXQgcG9pbnRlci4gIE5v
IGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCg0KSSB3aWxsIHJlLWNoYW5nZSB0aGUgcGF0Y2ggZGVz
Y3JpcHRpb24gYW5kIGFkZCBtb3JlIGRldGFpbHMgdG8gYWxsIHRoZSBwYXRjaGVzLg0KDQpUaGFu
a3MNCg0KDQoNCg==

