Return-Path: <linux-kernel+bounces-18838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB88263CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C56282615
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1212E48;
	Sun,  7 Jan 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Y9eHzJz0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39312B8D;
	Sun,  7 Jan 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX9nW3/3GTOnF3NdJXTC9sGiEpWqW6OwAS+vmkXzrxV0nFnH3ZYgsY7CnFXQlT6GZCBks0EjwDz7fFE2CmhtRolQ7WT0HoTiy2s0b5baxsmAV+bZNZmWJPag4lkYLo427Eg5RuxXdjrch5eagMnRzvF8WF7FReyLvGoNSAB5vd+Pjc04hOSHJV7xM+2u4h3JwmI/oCKc+J+RHAKtzMBJ9fHrTXIeVqNfGkJoLqXCAxtOmGrwqIbHqztD64cTxRc6R4KONgXcvu9WmCYHRx7ejhjzQ1p2i02xe7IsUeHt8g3+Sb5rML00gWhORiprEKmBvFxUUVxFmSEpSCupcLDkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4WRM9KvMaIHtCKqilOMnnMSm5ZmDKgy4a4u0Da492A=;
 b=QsTdS4G+qr8OnK9IRKA4St3/B4amW6PYg5wR4yjuQJkcts2CAelIlpJHBcMty/GvX2kIwDPASsWmtnAQsklxrN/UxNsuuJKiYYH7LxwBbCXQ3M3GPvUCJsJhvqGzP7XyNToUIpj0pFMKCJtuIwIj3RKFuSxywcg8Tf3mo1AfGfUjIN/wwUFT1jJLh8YNOc9dGfkvRMlJwPJaFaMLr0mDfcH/1UXpyVTEEqZ6o7uLX1mE0Uc4/VBt+/xfvmMNVc1mySjU5fdqwviJmPLscvMvs+fyiIoPxBQjyTL8/M/D/uEaHzJGmdjkzxpKLZlctLNeAO1X+nbEiMNaExy12RRljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4WRM9KvMaIHtCKqilOMnnMSm5ZmDKgy4a4u0Da492A=;
 b=Y9eHzJz0Sn5iHN5Yrk5LS5JlmZRVvFHcbQDoAG0SVGztRVy+gD4vt6+/22+zp/zHOgedfzN5leWt4EvOvDzb+ttDwmIKjMXSl30CDJ83SAsl3i0tuHjXx6Iicyu9eVaqF4viXfFpvIk58m5x8z/oXcJlQFrUIW7PtN5sDL8Zkpc=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by TY3PR01MB10501.jpnprd01.prod.outlook.com
 (2603:1096:400:312::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.13; Sun, 7 Jan
 2024 10:46:09 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::e220:cbfc:69ef:6702]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::e220:cbfc:69ef:6702%5]) with mapi id 15.20.7181.013; Sun, 7 Jan 2024
 10:46:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson
	<sean.anderson@seco.com>
Subject: RE: [PATCH v2 1/4] reset: gpio: Add GPIO-based reset controller
Thread-Topic: [PATCH v2 1/4] reset: gpio: Add GPIO-based reset controller
Thread-Index: AQHaP/BMp3VkzdSHW0qQi1Uk8IEbbrDLaurwgAF/RgCAAUI5cA==
Date: Sun, 7 Jan 2024 10:46:07 +0000
Message-ID:
 <TYVPR01MB1127920B611C25FD57DFBF75486642@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
 <20240105155918.279657-2-krzysztof.kozlowski@linaro.org>
 <TYCPR01MB11269ABEDCD115064D449267486662@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <40b4d29e-fa5c-43d5-8ccb-4a5a41150546@linaro.org>
In-Reply-To: <40b4d29e-fa5c-43d5-8ccb-4a5a41150546@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|TY3PR01MB10501:EE_
x-ms-office365-filtering-correlation-id: a19516b3-864d-4dcd-8026-08dc0f6ddae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0402B3q65FvYSwtAlI4zh9RcquI3VqGIpP4cG2a546dvOcMwUwX2yBP4Kclw3qi/f3588Tve2g58T2AqBmtDvxTWItWQBfFyCu2Mca4+6Uy0i0VfYictmpBNb6ZaaVrI66+xPU59rPV+vMovnP1AK72Kv4iFpefpttiC6qJl1U3WaY4NIW56f8nuWTHSGvk82Ca4F+kEbVAlaw/BU3gvbjOtSb3vr/XaLRIZyktQmqAN79G3cjbDYGEaDpGu33li1+Lu+9keYPzHlFUhgSVF2anQkRZ1V6wa3/iLOnr3g5WEjjaBPL/oWy2Fca9Rtivuieu5MfFRt0+k0nYAp6OZQn4D+aF5hYg2tWwr9+JYSXv4iVxG6iC4x0Xzn+2N14PtJYRWWBJJ2PfaukBnFPr9nYMHDnGO6203mY5RXFhiYInQviV0eqr26PP5TdAu8KYGxAb0Bz+mJoKLcC8+Byz9U3kCP5ZTh4jWQDFKZDiSjCToMunpj7RvBgM+FZqnHQRLg7UINpHb4m0bTMFcnS/TrZVZPg/vZPTjF/Ol5+7yQ2NDVwILpSXKLRMYC9WDAmTZVMQPBimieijS0GYpSQnjXGjWryK1/nWOzyNg2hzSZ9txtjmFgoYpPY81Z07qB3Z0UjKLMJp6ChKjirKWX8aVtg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8936002)(26005)(8676002)(316002)(110136005)(53546011)(9686003)(6506007)(54906003)(83380400001)(66476007)(66556008)(76116006)(66946007)(41300700001)(38070700009)(86362001)(921011)(7696005)(478600001)(66446008)(64756008)(71200400001)(122000001)(5660300002)(38100700002)(7416002)(55016003)(2906002)(52536014)(4326008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3dlRTRENlQza0pJNFVpWkp1QklBRGk3U21wb1Q3WUQ1bjkxRXpFS1dNNjYw?=
 =?utf-8?B?SzJFUXc0OTNqeWp0SGtwZVdBZ2FNSFQxVTlnMCtDQ28rUkJrdGQzOEY1ME84?=
 =?utf-8?B?VjZaMndpRlN4RGhJTW1QSUZaMG9RRU9ySmNFRzZ2ZGVyUlA3c2RyRmNGVHIz?=
 =?utf-8?B?T2VPUUd3Uy96dUgwTjk0T3d2b1JTZmhxMGdXQTd1QVhJQWxsM2FRYmdsYU1D?=
 =?utf-8?B?bVNCeXVMVkV4Nkd5VmZRc25idXhNUENodTk0THJvSU1tU2YrbnpyU3J0RjJR?=
 =?utf-8?B?VC9nZCtFR1VhajAwcEp1RmxyT2R5VFQ4V2d3dkhjem9RaVQ4MmRxbWFFY0ZJ?=
 =?utf-8?B?STg1RTk5VWZySDFzUDVBbFFtaXB0RDFib3hEN284MEp3Qy8xMmk5Q0Nnd2Ux?=
 =?utf-8?B?TDVkNCswUFR3MmU0UDdwZTdOUk5tL2lzK1pzdnhHd3MzWnBCM2txOW44MXBj?=
 =?utf-8?B?bG0vc0N6RWgzRVdRY2ZWOWNzNm1SUWZrMis2RDI5ZG1PSzNFNExMVGpVUVJn?=
 =?utf-8?B?dmtYUHFwcG1Vb2kxZVFTTkNmUkR5SHVUSjJmVnZOSGRYMHlBeFJ4S3lmYWVL?=
 =?utf-8?B?S0sxS1NMcTV0UWUrOHBMUnI2UnhNR25iZ3VLajhOY3Y4M2JnaExESzNOc2J1?=
 =?utf-8?B?MTA1MElqUTlEeHJYdUtzVGZDZUxxM3NxcVRZUlRacTJIVER6UlpGN053SWg2?=
 =?utf-8?B?VnV4NVJ4V2ZGSHk1Nkxoci9sdzBSRnNIL2IyOXN4Rmk3N2hvSWdodytmUWYy?=
 =?utf-8?B?OE5adW5ZVGxkK1lrMWpSdVNVTnkvalRVY3E5azJ5b2dyTGo1Rk9BbENLaWEx?=
 =?utf-8?B?ei9ObTlZUllDdlJPemEwR0RYSGdLdy9NRlV0UTFxQ2lDN2NBM0k3NUp5KzJD?=
 =?utf-8?B?ZmM2c2VvTVoxaVR0L0NNc3VvdHltU0Y5NEVoeTFPZ2FiQ0Y1bkQ5Zm94N3NG?=
 =?utf-8?B?RzRhN0lSQUJ6REJkQTRZbXRwbEI3RDNzdDNFbWJ5V254cDJwZ1NHZURXNTc3?=
 =?utf-8?B?T2lESmhIVVZYUGhuNDJhb1ZObjBTL0ZjNFVmVVpHVllBYit0b0lkaktKYmpx?=
 =?utf-8?B?cmROOUJITXB2MWVXNVYwb0dmZndZazJLcm85dWZiUnNZWUNNd0JPSG1EcDcv?=
 =?utf-8?B?Nk5sb3R0dTRWTWRxV21WWlNwM2xMNnUyRnVaOHFKQUUyLzNUcElXS2lLczkx?=
 =?utf-8?B?K3cyU2lNa202RkVtd2E0OTZ2cnF0RzVQVTlYaGJIR3A5UWZDNERTdnBLTVpT?=
 =?utf-8?B?OS9HRDRYVWJUbzY4bzkrY2czbnd3aGw5Z0M2c2FxUkt2cElHV0ZvVTdQTU5i?=
 =?utf-8?B?K3ZUTlBBWDR0b2xTMmpOZ0g2T0lGMnRWNlYyQ1NpZmtnWHU2c3FvS0ZpMDl1?=
 =?utf-8?B?cmhHTldRREc2Q2tPRFViSHVIY0tBNGc4dDQyVlRubE5BRW90QWd1MVZBU29o?=
 =?utf-8?B?QmJUVDN5TGJWSXdUNzdFUjZUYjNZY3ZvemNlbDdpV3cvOVB3YWlxRmwxaWxz?=
 =?utf-8?B?M2ZYR2J5eUlJSHJGMTVzbXFWeHByWWs5Vk9MQWZsZ1I4YnlNU21zVTFxcDBD?=
 =?utf-8?B?ZTF4N2t0K1BXbDU5UUFaandkU1ZDeHJVMFJIZnoyUjBVOHZOQmkwNE0xQ0pP?=
 =?utf-8?B?RmZYbjcwTGtGUHVVU2czenhyNnFieUljTzg3bUFLWlk0cTUrSTQvSDVsdTEz?=
 =?utf-8?B?YnlkaDUyelE3UzZIQklLRHVzNnV4QU9JY3VySTY4VVVFOE1mT2lCalVGbHJz?=
 =?utf-8?B?dVRMdmlTY1Q0emZUUzJZUGR1NVlJNit4ZXE2VHlxUWFoZWVHS2p6NHEvR2VY?=
 =?utf-8?B?QUNrVXQzWFk5QVZCMWgzeS9TaTNHcU5lQ3lOZGR4WlptdFJwNGFzUkNiaTlY?=
 =?utf-8?B?dDVHR1FMSmo4ZmhReEVLeHNQb05vRllSMXJrQXJMeW95WjJJem5BdldaVVFO?=
 =?utf-8?B?VE1vRkhVczdjUnJENU8vbzJXZldzdzllMTZmcTlRaS9mc29Gamd0Z3hyYjk1?=
 =?utf-8?B?eG9wenErYWtYQ1NIVDYxZ3ZVM0k1RmpUNjcxRUl4U0ZvSEpObWJheXh1dkJH?=
 =?utf-8?B?NDlpZTdIYitkbkswVUx5Yi8zYmdQMFhrQkQwUDFibFF6MjBVd1puR3dIYmtu?=
 =?utf-8?B?bGZWODFsdzBXZklBSFBLaUF2TUhYdGZ3Y3pGSms4QjFKQ2wrZHhvTzdvZXpJ?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19516b3-864d-4dcd-8026-08dc0f6ddae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2024 10:46:07.7259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0GBpoFRQDXEjBwIWmvJ7Lb69gCkUt2XnYZp9wQ0xrU3wNAxmNoJyswcT/VO6y1ENQxb98FfqAl6x5pwd/Crq3vQFqpvITep6TpyrJoNttI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10501

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDYsIDIwMjQgMzoyOSBQTQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDEvNF0gcmVzZXQ6IGdwaW86IEFkZCBHUElPLWJhc2VkIHJlc2V0IGNv
bnRyb2xsZXINCj4gDQo+IE9uIDA1LzAxLzIwMjQgMTc6MzksIEJpanUgRGFzIHdyb3RlOg0KPiA+
IEhpIEtyenlzenRvZiBLb3psb3dza2ksDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4N
Cj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgSmFudWFyeSA1LCAyMDI0IDM6NTkgUE0NCj4gPj4gU3ViamVjdDogW1BBVENIIHYy
IDEvNF0gcmVzZXQ6IGdwaW86IEFkZCBHUElPLWJhc2VkIHJlc2V0IGNvbnRyb2xsZXINCj4gPj4N
Cj4gPj4gQWRkIGEgc2ltcGxlIGRyaXZlciB0byBjb250cm9sIEdQSU8tYmFzZWQgcmVzZXRzIHVz
aW5nIHRoZSByZXNldA0KPiA+PiBjb250cm9sbGVyIEFQSSBmb3IgdGhlIGNhc2VzIHdoZW4gdGhl
IEdQSU9zIGFyZSBzaGFyZWQgYW5kIHJlc2V0DQo+ID4+IHNob3VsZCBiZSBjb29yZGluYXRlZC4g
IFRoZSBkcml2ZXIgaXMgZXhwZWN0ZWQgdG8gYmUgdXNlZCBieSByZXNldA0KPiA+PiBjb3JlIGZy
YW1ld29yayBmb3IgYWQtaG9jIHJlc2V0IGNvbnRyb2xsZXJzLg0KPiA+Pg0KPiA+PiBDYzogQmFy
dG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4NCj4gPj4gQ2M6IFNlYW4gQW5kZXJzb24g
PHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gLS0tDQo+ID4+
ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICB8ICAgNSArKw0KPiA+PiAgZHJpdmVycy9yZXNl
dC9LY29uZmlnICAgICAgfCAgIDkgKysrDQo+ID4+ICBkcml2ZXJzL3Jlc2V0L01ha2VmaWxlICAg
ICB8ICAgMSArDQo+ID4+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWdwaW8uYyB8IDEyMQ0KPiA+PiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICA0IGZpbGVzIGNoYW5n
ZWQsIDEzNiBpbnNlcnRpb25zKCspDQo+ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9y
ZXNldC9yZXNldC1ncGlvLmMNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMgaW5kZXgNCj4gPj4gN2ZlMjdjZDYwZTFiLi5hMGZiZDQ4MTRiYzcgMTAwNjQ0
DQo+ID4+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4+IEBA
IC04ODY2LDYgKzg4NjYsMTEgQEAgRjoJRG9jdW1lbnRhdGlvbi9pMmMvbXV4ZXMvaTJjLW11eC1n
cGlvLnJzdA0KPiA+PiAgRjoJZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1ncGlvLmMNCj4gPj4g
IEY6CWluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9pMmMtbXV4LWdwaW8uaA0KPiA+Pg0KPiA+
PiArR0VORVJJQyBHUElPIFJFU0VUIERSSVZFUg0KPiA+PiArTToJS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiArUzoJTWFpbnRhaW5lZA0K
PiA+PiArRjoJZHJpdmVycy9yZXNldC9yZXNldC1ncGlvLmMNCj4gPj4gKw0KPiA+PiAgR0VORVJJ
QyBIRExDIChXQU4pIERSSVZFUlMNCj4gPj4gIE06CUtyenlzenRvZiBIYWxhc2EgPGtoY0BwbS53
YXcucGw+DQo+ID4+ICBTOglNYWludGFpbmVkDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jl
c2V0L0tjb25maWcgYi9kcml2ZXJzL3Jlc2V0L0tjb25maWcgaW5kZXgNCj4gPj4gY2NkNTlkZGQ3
NjEwLi5iYjFiNWEzMjZlYjcgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcmVzZXQvS2NvbmZp
Zw0KPiA+PiArKysgYi9kcml2ZXJzL3Jlc2V0L0tjb25maWcNCj4gPj4gQEAgLTY2LDYgKzY2LDE1
IEBAIGNvbmZpZyBSRVNFVF9CUkNNU1RCX1JFU0NBTA0KPiA+PiAgCSAgVGhpcyBlbmFibGVzIHRo
ZSBSRVNDQUwgcmVzZXQgY29udHJvbGxlciBmb3IgU0FUQSwgUENJZTAsIG9yDQo+ID4+IFBDSWUx
IG9uDQo+ID4+ICAJICBCQ003MjE2Lg0KPiA+Pg0KPiA+PiArY29uZmlnIFJFU0VUX0dQSU8NCj4g
Pj4gKwl0cmlzdGF0ZSAiR1BJTyByZXNldCBjb250cm9sbGVyIg0KPiA+PiArCWhlbHANCj4gPj4g
KwkgIFRoaXMgZW5hYmxlcyBhIGdlbmVyaWMgcmVzZXQgY29udHJvbGxlciBmb3IgcmVzZXRzIGF0
dGFjaGVkIHZpYQ0KPiA+PiArCSAgR1BJT3MuICBUeXBpY2FsbHkgZm9yIE9GIHBsYXRmb3JtcyB0
aGlzIGRyaXZlciBleHBlY3RzICJyZXNldC0NCj4gPj4gZ3Bpb3MiDQo+ID4+ICsJICBwcm9wZXJ0
eS4NCj4gPj4gKw0KPiA+PiArCSAgSWYgY29tcGlsZWQgYXMgbW9kdWxlLCBpdCB3aWxsIGJlIGNh
bGxlZCByZXNldC1ncGlvLg0KPiA+PiArDQo+ID4+ICBjb25maWcgUkVTRVRfSFNESw0KPiA+PiAg
CWJvb2wgIlN5bm9wc3lzIEhTREsgUmVzZXQgRHJpdmVyIg0KPiA+PiAgCWRlcGVuZHMgb24gSEFT
X0lPTUVNDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L01ha2VmaWxlIGIvZHJpdmVy
cy9yZXNldC9NYWtlZmlsZSBpbmRleA0KPiA+PiA4MjcwZGE4YTRiYWEuLmZkOGI0OWZhNDZmYyAx
MDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9yZXNldC9NYWtlZmlsZQ0KPiA+PiArKysgYi9kcml2
ZXJzL3Jlc2V0L01ha2VmaWxlDQo+ID4+IEBAIC0xMSw2ICsxMSw3IEBAIG9iai0kKENPTkZJR19S
RVNFVF9CQ002MzQ1KSArPSByZXNldC1iY202MzQ1Lm8NCj4gPj4gIG9iai0kKENPTkZJR19SRVNF
VF9CRVJMSU4pICs9IHJlc2V0LWJlcmxpbi5vDQo+ID4+ICBvYmotJChDT05GSUdfUkVTRVRfQlJD
TVNUQikgKz0gcmVzZXQtYnJjbXN0Yi5vDQo+ID4+ICBvYmotJChDT05GSUdfUkVTRVRfQlJDTVNU
Ql9SRVNDQUwpICs9IHJlc2V0LWJyY21zdGItcmVzY2FsLm8NCj4gPj4gK29iai0kKENPTkZJR19S
RVNFVF9HUElPKSArPSByZXNldC1ncGlvLm8NCj4gPj4gIG9iai0kKENPTkZJR19SRVNFVF9IU0RL
KSArPSByZXNldC1oc2RrLm8NCj4gPj4gIG9iai0kKENPTkZJR19SRVNFVF9JTVg3KSArPSByZXNl
dC1pbXg3Lm8NCj4gPj4gIG9iai0kKENPTkZJR19SRVNFVF9JTlRFTF9HVykgKz0gcmVzZXQtaW50
ZWwtZ3cubyBkaWZmIC0tZ2l0DQo+ID4+IGEvZHJpdmVycy9yZXNldC9yZXNldC1ncGlvLmMgYi9k
cml2ZXJzL3Jlc2V0L3Jlc2V0LWdwaW8uYyBuZXcgZmlsZQ0KPiA+PiBtb2RlDQo+ID4+IDEwMDY0
NCBpbmRleCAwMDAwMDAwMDAwMDAuLmNmMGE4NjdjYmM1Zg0KPiA+PiAtLS0gL2Rldi9udWxsDQo+
ID4+ICsrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtZ3Bpby5jDQo+ID4+IEBAIC0wLDAgKzEsMTIx
IEBADQo+ID4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+PiArDQo+
ID4+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiA+PiArI2luY2x1ZGUgPGxp
bnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
PiA+PiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQtY29udHJvbGxlci5oPg0K
PiA+PiArDQo+ID4+ICtzdHJ1Y3QgcmVzZXRfZ3Bpb19wcml2IHsNCj4gPj4gKwlzdHJ1Y3QgcmVz
ZXRfY29udHJvbGxlcl9kZXYgcmM7DQo+ID4+ICsJc3RydWN0IGdwaW9fZGVzYyAqcmVzZXQ7DQo+
ID4+ICt9Ow0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCByZXNldF9ncGlvX3By
aXYgKnJjX3RvX3Jlc2V0X2dwaW8oc3RydWN0DQo+ID4+ICtyZXNldF9jb250cm9sbGVyX2RldiAq
cmMpIHsNCj4gPj4gKwlyZXR1cm4gY29udGFpbmVyX29mKHJjLCBzdHJ1Y3QgcmVzZXRfZ3Bpb19w
cml2LCByYyk7IH0NCj4gPj4gKw0KPiA+PiArc3RhdGljIGludCByZXNldF9ncGlvX2Fzc2VydChz
dHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjLA0KPiA+PiArdW5zaWduZWQgbG9uZyBpZCkg
ew0KPiA+PiArCXN0cnVjdCByZXNldF9ncGlvX3ByaXYgKnByaXYgPSByY190b19yZXNldF9ncGlv
KHJjKTsNCj4gPj4gKw0KPiA+PiArCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwcml2LT5yZXNl
dCwgMSk7DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gMDsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAr
c3RhdGljIGludCByZXNldF9ncGlvX2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2Rl
diAqcmMsDQo+ID4+ICsJCQkgICAgICAgdW5zaWduZWQgbG9uZyBpZCkNCj4gPj4gK3sNCj4gPj4g
KwlzdHJ1Y3QgcmVzZXRfZ3Bpb19wcml2ICpwcml2ID0gcmNfdG9fcmVzZXRfZ3BpbyhyYyk7DQo+
ID4+ICsNCj4gPj4gKwlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocHJpdi0+cmVzZXQsIDApOw0K
PiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBp
bnQgcmVzZXRfZ3Bpb19zdGF0dXMoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyYywNCj4g
Pj4gK3Vuc2lnbmVkIGxvbmcgaWQpIHsNCj4gPj4gKwlzdHJ1Y3QgcmVzZXRfZ3Bpb19wcml2ICpw
cml2ID0gcmNfdG9fcmVzZXRfZ3BpbyhyYyk7DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gZ3Bpb2Rf
Z2V0X3ZhbHVlX2NhbnNsZWVwKHByaXYtPnJlc2V0KTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAr
c3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyByZXNldF9ncGlvX29wcyA9IHsN
Cj4gPj4gKwkuYXNzZXJ0ID0gcmVzZXRfZ3Bpb19hc3NlcnQsDQo+ID4+ICsJLmRlYXNzZXJ0ID0g
cmVzZXRfZ3Bpb19kZWFzc2VydCwNCj4gPj4gKwkuc3RhdHVzID0gcmVzZXRfZ3Bpb19zdGF0dXMs
DQo+ID4+ICt9Ow0KPiA+PiArDQo+ID4+ICtzdGF0aWMgdm9pZCByZXNldF9ncGlvX29mX2FyZ3Nf
cHV0KHZvaWQgKmRhdGEpIHsNCj4gPj4gKwlvZl9ub2RlX3B1dChkYXRhKTsNCj4gPj4gK30NCj4g
Pj4gKw0KPiA+PiArc3RhdGljIGludCByZXNldF9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpIHsNCj4gPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiA+PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqKnBsYXRkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShk
ZXYpOw0KPiA+PiArCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgZ3Bpb19hcmdzOw0KPiA+PiArCXN0
cnVjdCByZXNldF9ncGlvX3ByaXYgKnByaXY7DQo+ID4+ICsJaW50IHJldDsNCj4gPj4gKw0KPiA+
PiArCWlmICghcGxhdGRhdGEgfHwgISpwbGF0ZGF0YSkNCj4gPg0KPiA+IE1heWJlLCBpZiAoIShw
bGF0ZGF0YSAmJiAqcGxhdGRhdGEpKSB3aGljaCByZWR1Y2VzIDEgaW52ZXJzaW9uDQo+IG9wZXJh
dGlvbi4NCj4gDQo+IEkgd291bGQgbm90IGNhbGwgaXQgZWFzaWVyIHRvIHVuZGVyc3RhbmQuLi4g
VG8gbWUgIUEgYW5kICEqQSBhcmUgcXVpdGUNCj4gb2J2aW91cyBhbmQgZWFzeSB0byByZWFkIGlu
c3RhbnRseSBiZWNhdXNlICFBIGlzIG9idmlvdXM6IGNoZWNrIGlmIGl0IGlzDQo+IG5vdCBOVUxM
LiBUaGVyZWZvcmUgb3JpZ2luYWwgY2hlY2sgaXMgb2J2aW91czogaXMgTlVMTCBvciBwb2ludHMg
dG8gTlVMTD8NCj4gVGhlbiBleGl0Lg0KPiANCj4gTm93IHlvdXIgY2hlY2sgaXMgYSBiaXQgbW9y
ZSBjb21wbGljYXRlZC4gSXQgaXMgbm90IGV2ZW4gZnJlcXVlbnQgY29kZQ0KPiBwYXR0ZXJuIHdo
aWNoIG15IGJyYWluIHVzZWQgdG8gc2VlLiBZb3Ugd2FudCB0byBjaGVjayBpZiBib3RoIGFyZSBu
b3QgTlVMTA0KPiBhbmQgdGhlbiBuZWdhdGUgaXQsIHdhaXQsIG5vLCBvcHBvc2l0ZSwgY2hlY2sg
aWYgdGhleSBhcmUgc29tZXRoaW5nIGFuZA0KPiB0aGVuIG5lZ2F0ZT8gVG8gbWUgaXQgaXMgcmVh
bGx5IG9wcG9zaXRlIG9mIHJlYWRhYmxlIGNvZGUuDQoNCkkgYWdyZWUgbWF5YmUgaXQgaXMgbm90
IHJlYWRhYmxlLCBldmVuIHRob3VnaCBpdCByZWR1Y2VzIDEgZXh0cmEgb3BlcmF0aW9uLg0KDQoh
KFZhbGlkIHBvaW50ZXIgQU5EIHBvaW50cyB0byBhIG5vbiBOVUxMIHZhbHVlKQ0KVGhlbiBleGl0
Lg0KDQpDaGVlcnMsDQpCaWp1DQo=

