Return-Path: <linux-kernel+bounces-93300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9770872DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0645E1C21A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CA156C2;
	Wed,  6 Mar 2024 03:53:29 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF289134B2;
	Wed,  6 Mar 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697209; cv=fail; b=lI9vulse78/PVEnd+CbBRzYY5oFYJFpaf9n4n+4BDYwmb8QdYrJfw1PjYpagtYcoycsQhyD2cdYyJAXW2LQN9jKiHFtgT1CDEMe2sgfkN4RZe3JhG7AFFZNYG6JCiTDdUaMty7XIY/uTQATZiZlnnMgnJt05VgmWovaNefWxcMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697209; c=relaxed/simple;
	bh=eO5UpaMNMp42zkn/aV6k+QYvQdgv6b9fS8lhapV9Vl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UkNY73cUSJE4Ut22HhAxCOVkkJ3vv0aRKG8PWZLoJ+z6NeSyKkW+Xd5J+J0MCbDkS07Gx+5c7rNGEOHbE6d7PnbvHWR4yr1DBF2STvzrqlfCMMNbZz2rXorHKonxfLT8OXimBvgkNqay7EBOv+qDmKF61M+qIaV0jd9E6ENd0PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2V7mopVlBg1tFlJCiVeR8ce12+SggzPztBFjcdOTYfX883VvZZ5nid2jG4BjDwxA2cSbLKwmUrtiV4EdLgLnFcBHhfxw5zz0EfCVdrG+x4LerhC2vMw9rhGAyDWwaRvcXtFL9j+TBTewgfDGa5YslMtKM1fSpppoAnJLEY3RJM9yrCgDzWwaFoFnFrMGFf1QIB94TPVzDayVNuA0bXsfVlzpRsd4EA/SqXTIcc5Yw5cUnQ6fhP3MyA1YgfmMccyfUwP/Owff4P7+/GhOSr8hmw0pxFTR73Q250S1auOWDBMJtX56o1N/qd4zKcfXaFG7XLkwbDYixOVfQPynKJ+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO5UpaMNMp42zkn/aV6k+QYvQdgv6b9fS8lhapV9Vl0=;
 b=Cd2RW3YEdCL3DHfBa9PuyeImjwjBkmvwbFgc65ckfrfo1v9B7ryoMQZIzfeezPjHFPqGXvFdVN4PehPEr4pekXCvjvjL+7S9vGgkUun+C7Wr6MBDBGjfa9qc+rhu+ZxSPLi5fDq9hfVMOfevpd2/YxFc/zWRHecAlWKR11wkNSpZdgRo8+Mu9MkVj87ggQPhht/JaiBniRKKHkIpsqYcPauSoFfbuO9aKyi5twtvKvDegpah4056nP99l1Wb9NaELG9AWa77DTMO0s9GJa7HoPr5dlKIUQTPegR+FtCr4QboFsM06Q5qV4EbNnhoyJaVBNKMlN26ZjWWlalx8pexnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0768.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 02:19:49 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 02:19:49 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Hans
 Verkuil <hverkuil-cisco@xs4all.nl>, Ming Qian <ming.qian@nxp.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne
	<nicolas.dufresne@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Tomi Valkeinen
	<tomi.valkeinen+renesas@ideasonboard.com>, Mingjia Zhang
	<mingjia.zhang@mediatek.com>
CC: Jack Zhu <jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYzIDAwLzEzXSBBZGQgSVNQIDNBIGZvciBTdGFyRml2?=
 =?gb2312?Q?e?=
Thread-Topic: [PATCH v3 00/13] Add ISP 3A for StarFive
Thread-Index: AQHaWBJVG1ff5kRXW0SpS9Y4ee+DwbEqJ8mw
Date: Wed, 6 Mar 2024 02:19:49 +0000
Message-ID:
 <SHXPR01MB0671C020C9923943E1A6B008F221A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0768:EE_
x-ms-office365-filtering-correlation-id: 2d4537b5-d9bd-41d4-df37-08dc3d83e672
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IW9xCOjwQwwGdTGGXyEos7H5MYchiam2v8PQrDAIZi86f6/+POWYjppKtXT3MXKHTG5DtdXc3oBYsGjtRHRQSZ0kIznD9XjQKZWrqQY7AUeXEyliMPVzfoQbwnIPvSbfHjTNNckBLbT5EgKCUD57Uj8tH1pXMe1q7XCQZI4lL8NZwyz4I4/hZFOGqYPWxl5EK3yM9Hw82GfchGMKHIZV576rBJeh9CypgrKC2DOo0IGuEGvYjWFKkpvCUeIKgSqM0X5aUxkFoUuxJx/b1NX3zuhjbv+zial//PdoCy2OBCx85nHKH0Fzc/VoHcOi1um56aO3NNHLmg8FU0Y0Ez3QrqHibgn3JUgEfvaFPR/xyXWVKywpbP3drSDCEMniVD5I60YOQGX4Tp/JoQaIF1BEZVXLMmmbzdUypT83e1VBlkX4jMrB/NmIHtUtUNHnFLjGCh9d7N4Gxea6Z5bCEzB2Bp1z9zk1+Ang1GprO387vxJgOQYtQNst7uQvekYlFjta9Ja/nEi8lbA1YRjCsCwmLIwCbposWiObGUeDK2QSGYC33ivCdXneiNlBWdfI0h0FguEeCLiW7CtlSJIe66Llags2yxYDFQpiTgE9DmJqA5E1teBfS0NAV7dI7C0OKMGtwOZGMsnVwKYZyQNdiHmJ1w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M1c2L1BaZnhKR0l1eFRYWXhNbkZhdG5mU0dFZmRpRVo4bTJSVm9hakZtb1RZ?=
 =?gb2312?B?RVJoL2szNlFOZ3lRb0JCM1ZBaHFra1RIKy9HQ3ZpR3lMM2tuZURrbHRzeFFZ?=
 =?gb2312?B?OWNyYW0rQWpXNVQ1SWpHNUUydzNJWW80SlVSaXNDY3RIU1UvMUVUTWlCL2xn?=
 =?gb2312?B?MkFOclBIWHZnMVRNbCtYcGNiODRLbi9DZ3JlQThTeXA3dTdYUTZ1VGl2REgz?=
 =?gb2312?B?c3JTYTR5UWkxUmxOSmpZVzhuV0kzVTIvdnFzb0Vnc3l1enlGSWg1M3AvZHRw?=
 =?gb2312?B?NmdJVHVpMk9RUlUreCtZK3pxNG5uWXR2R0Vka2VLSXVkcFdyL011aVl4WGhI?=
 =?gb2312?B?OTFYbndGUTlYVGlzTUg0ODFpd1dRR040OHBXMDR1ZFVKNkpIMTlpR0F0a1dT?=
 =?gb2312?B?aWFhY1dMd3R6NXB1aVNiYyttd2RKdWdxaE8zNUNBRmdFQjdGL1E2bTQ5N2cw?=
 =?gb2312?B?KytRc3ozV1BTakVMZGNzZGEvR2RzelFXNU9PaWpHaWRXTHRBS1NCU0RKNXpW?=
 =?gb2312?B?K3ZGYjEyNlVCdVhzcUlqS3RzQWQvLy81T3A1V2JyWUxJZlVxR2tRSWU5Q3Ri?=
 =?gb2312?B?cVdFdGNMcXAyalluMFZWZHl4Vmx5Sis5MXJkR1J0VzMvaCtmN21IRHAreUN1?=
 =?gb2312?B?TkVTT3l1OUFQU2ZwcnczNDJHNnZtMGtkR0l1byt2amdSdCsrZ1JNbW5JWTA5?=
 =?gb2312?B?K1FWNUdkZDV0ejIwbXJINkZtcmVMN3djdndMQVhLejhYSVprVjVicEtieXc4?=
 =?gb2312?B?dUtqVW9UeWZOQnhwdWdKU0lRSTBwbEwzRkdnMHNoeUxReWd4WEhUNncyeDFx?=
 =?gb2312?B?VXl5YktlWXdUcTdXS2NmVWZhdTRqUEVlY3VjZWpuUDlQVHA4SWpvZlduOE1w?=
 =?gb2312?B?UXZ0L0F4VTdaZGhyZ09zUnhrUmdvVFFxSHE2UVdMeVNIMWJCUHdtU2c2N2dX?=
 =?gb2312?B?VllaK0hIUUpvUFFmMGVHRW9POUJKNU1xbWROWlhheFFBZlZCMTJ1N2h3SDVy?=
 =?gb2312?B?UTZKYkU4ajlCNFdRQkppUHRGL212OTNDSC90T3VwRFUvRFVPUklPYmVhYmx0?=
 =?gb2312?B?azRGSk1LNWx5TkkzaWdSMjVucEZzZTNxT2lTQjRYQ2IrQlo1aVRPU0RaREZZ?=
 =?gb2312?B?a0FwdTFHZDV3end3Y2tlMEh2N3JOaDZnSUJOK0RNYkFqTTVXOHJjdE03NUVH?=
 =?gb2312?B?Skoxa3d2bDJnVi9TbU9sS2FFY0ZHTHBhQU9KV05BM3ZrZUd6Qi8wK1VmNmpj?=
 =?gb2312?B?MFhzOTJFSTQvNUp6QVIrU1o0MExlVHBOL0dWM20rcHFFeFFmNGthQnF4Umxk?=
 =?gb2312?B?c2R1ZEMwaWlNWFNIeitrblVISU5rVXpadTh5d2MwMnRUVUhuQnBXSEpEc3Ju?=
 =?gb2312?B?QUgyTGRNVGkyM29VbzlYYjc0ZSs2T1FWR0hRTUFWajBsZGxRakpTMmxDMWtN?=
 =?gb2312?B?Um56dW1FRGtYK0dhck1XeVpSTm5NVGlKTTBWNHkxbXJVM1o4RVZneDdqODhp?=
 =?gb2312?B?UXZCSWdWMWRRVUVUeVRjQTd1Z001aFhEamp3MTY0eSsrWjdubGJmR1hpaWZ0?=
 =?gb2312?B?VVNMSEZsL25vcmx3SlFEMUJZaTVwT2o5dHhYakN1Rlg3TlZzUXJvdzE0dGdw?=
 =?gb2312?B?eXZHSFNwOE5TSDByOGgwUGMzVDFyeWVlS2swYk1Hc1MyMzk0OHBVOTlZZm9o?=
 =?gb2312?B?MEUwK0FqVGFZNEM5MjFpTFBTOWphK0dVRi9kR1l1RTFSclE2NGpCQm9aNTht?=
 =?gb2312?B?cVR4bUtveEM0eXdTVkdLKysvMW1wWVdTUFRuOWxRZjl3WktJNzRRNkpRUjJl?=
 =?gb2312?B?dXlSN20xMFBRNGd2Y3RNVk1xUjgwVTNNUG8rSjlmblNmUHRBQlZsTEhqMEo1?=
 =?gb2312?B?dEc3WEVJRzJKclR4YXVZMkRYdnlLQVFtUC9NVUdXdzNreUR4NVNRVHAzaktv?=
 =?gb2312?B?THoySmxtSmVTVVI5eFZnTmthUmNqZ3FxUGJESmdYdXNUQkRYWCtsZ0R5bTAr?=
 =?gb2312?B?c1VqWG5KRXFZRDBTQzVDbjYxbGFZTTVGRCsyVTdldDczV3hlWHJJU0hzZWJD?=
 =?gb2312?B?ZnlzZjdYbWUxL2M4YnN6MFBlZFVpczJISVNwZU9nenRJRCtDWUNua0JBaGVC?=
 =?gb2312?B?RVVJYVEwQkRUcXVUTEVTR3JBcTBxa0FyM0ZPVStnK3FoRVlnbUt1K3Z3K2J0?=
 =?gb2312?B?WEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4537b5-d9bd-41d4-df37-08dc3d83e672
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 02:19:49.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaCqQwRlvIL324Pj3BosUEkO793VAC1DuCJM5KBtZU7thofQ0bjCFBvFpG2avYIEVONcnFrkEu8piLMg3MqXcCNpGImlKJ3i0Zs+H7MHfrZ2hLj7A9nt63u76XcbDdsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0768

SGksIExhdXJlbnQNCg0KPiBbUEFUQ0ggdjMgMDAvMTNdIEFkZCBJU1AgM0EgZm9yIFN0YXJGaXZl
DQo+IA0KPiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzIHRoZSBJU1AgM0EgZnVuY3Rpb24gdG8gdGhl
IENhbWVyYSBTdWJzeXN0ZW0gb24NCj4gU3RhckZpdmUNCj4gSkg3MTEwIFNvQy4gVGhlIHNlcmll
cyBoYXMgYmVlbiB0ZXN0ZWQgb24gdGhlIFZpc2lvbkZpdmUgMiBib2FyZC4NCj4gDQo+IFRoaXMg
c2VyaWVzIGlzIGJhc2VkIG9uIHRvcCBvZiB0aGUgbWFzdGVyIGJyYW5jaCBvZiBtZWRpYV9zdGFn
ZSByZXBvc2l0b3J5LA0KPiB3aGljaCBpcyB0ZXN0ZWQgd2l0aCBhIHY0bDItY29tcGxpYW5jZSBj
b21waWxlZCBmcm9tIHRoZSBnaXQgcmVwbw0KPiAoZ2l0Oi8vbGludXh0di5vcmcvdjRsLXV0aWxz
LmdpdCkuDQo+IA0KDQpBcmUgdGhlcmUgYW55IHVwZGF0ZXMgdG8gdGhpcyBzZXJpZXMsIEkgYW0g
bG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVzcG9uc2UuDQoNClJlZ2FyZHMsDQpDaGFuZ2h1YW5n
DQo=

