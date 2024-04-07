Return-Path: <linux-kernel+bounces-134671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717189B4B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C975282A43
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B144C6A;
	Sun,  7 Apr 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KtYvs6GW"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2114.outbound.protection.outlook.com [40.107.14.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373C47F48;
	Sun,  7 Apr 2024 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533813; cv=fail; b=pSmXPOiZAbKqWNllQEMe11MOJig4wzy95SPjA+BTjTnCVUQQyRspgCFaZnqjKARDUUBkLRpMPUlYb/73wGAZg3UVpoqRWKVQ+zgvpmPiy3v/CD3c5VxN2lHZY9fUD5QPP3+Y3uhrma5ToE+L8MCwC+gR3CAPAAUD0lW3W1Kkd70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533813; c=relaxed/simple;
	bh=yxAOetKzzp+PLiYUpb0nT1hxF1n4SJIvC7vQcFryPeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTP7pdumAmTbmKzvDEsOfJ/CRV+JmJNc9HhKtBfaCae1gtMAiK/1jdKcnmhujqGTkh8OmJinkSVU2pimEWyZ5ET8NPLOLnMMPF8O9aEa/JFRKe3bMG1rPQtx14gsS1tjlfonGmjKqzad0IriZ5DO9VqbreHI78+aRFEiYDWgAII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KtYvs6GW; arc=fail smtp.client-ip=40.107.14.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF0arnJSCsv8GYnz5MkulDMc/zUYtbmf0pFdHbz6jzlbr4jRY4uaDgZPb5GwsqyJPWaZ9a3RLCBzLnp1NIW2eHqJyBxgtlQ6p1wUWTmClYtDph2InkFXWE36hh3hz/PR8t67yN1Ti+c5+Uqyscncmp4e/7o15Av+EpEnQn1ThPgC+KTkb+PO7rC3M8iJQNPYgmE9Okr4USfO86GEFleu/Emm4FjcMIJTBiudrPnDnv0FAi6d9Z2emLmhkllobzDlUr6058ycv2SiXcipAJiNhJeItOu0h8eyxJFhrCVGOUTr2HmGNPR/nj0Ryk4IkLqL1unnJRG2M/8GnbXc4JjgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxAOetKzzp+PLiYUpb0nT1hxF1n4SJIvC7vQcFryPeE=;
 b=kNjdd2o9QQV6hMqKPaJbu7607BJMHrQwCgpjlu2VtRjtr/9WqdbaO8GMiQ+0V1/F4Fo3MTds9uZr9WIV1gQVRz7ogQtPlulotX9m+VmgRfUeLwJfMXObI4u36UmGc5+LrxDxbabli0P7w7VctyoWMdYDwTybtCwFVmB1/EtIv1UX4KQCzUVmm0KB4/q8o+sTyBXYqH7GhBOglfVLRHdpdWVrDFQNmd1ABgepXOHGQ+/JVawfOgaMQV7OesvYFp3SqsisW660RFxiLJBpzv6tvOizlWc+1LArFF0iVISaeNtYDmymaceCzAejn3NFqKvTjtvAM9w62jfs9x+8Z9y2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxAOetKzzp+PLiYUpb0nT1hxF1n4SJIvC7vQcFryPeE=;
 b=KtYvs6GWrD4jBNjzXurHvTsPcST42ZxXNxi8ttC5GoYpVog5IuJFkXFCHU/KioLiTitVJgOQVihVfjNAOJcX8AWlBCw3CD+ZZDVa/737YdDMX0/6dnJ+OIDfCJixkW30BTdqyDaOOaQosapnx0OYnESXXLNRf9kOiomYuqaxRY0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 23:50:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 23:50:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Topic: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Index:
 AQHah1U2hf+AkPhDj02wsn9yNtLUjbFbE9+AgADkvNCAAItFAIAAEwgggABoGYCAAH0iQA==
Date: Sun, 7 Apr 2024 23:50:07 +0000
Message-ID:
 <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
 <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org>
In-Reply-To: <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9693:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yq7o5u1dwgzVZoDdAW2x3WlWTAdSJpcEzqPpXF4ikGHogHH/c9WEG22m9WMNvUXU8k06NQd8aQnYXwWzRJYFqGNOgE4R97iMODMQZyiav+EFo1+V0DG/+UbBYIJVbxD+Al1pLl1o7hPfqOcEiiAFLuCyzTU10Q5bgqtyGA6/XFHCweCQr7vJKvM63vdxrkcakRJaoGp6IKqoSJT/3y2YscHinKsgqbLmp7HSRoEhjjgseDU9u52/lcM4zXYv9PTCylEcc9pRVnD5aji1jO7Eigt0miuFesZDJM017xhOOfGbabr3Uc1w/wfTRzjpFoXKX08n6sV92nQTwbafx5zXFrmgM90bh1lSga4ZaeESOLODOk4PnyVdPKP9sdNyquIHHuXqWADN3j5ts1AiihCoeBLd5SQjjYWTBP0QaabwGRqDrdRTl2zO+h5KIXOATKK17yduSLbJ1mzNMu+egQNegmxJfFAOkKvv5By4EjnFCZkrc9ZeaMOza6kINN4xgXnbeAz1l/TsAXC8XHNGAHi6F6pj00QxV8zDEQz/7g9WG510kpWFGrMwCDrbYX1AujAQEQtzMPj7C3kslTqZLoUw/IvJx0k4QqsQw1boVfIupa0LVHHveQn5yxCEp8yPcwqVF7EDMalLoL1b/ofjhqIYJP7HWj9YLp9kVY5vP5dF+Gjjdhl78cjYN22RFbge5J2PeWnYL2jYJfI0qGC+u5mbjw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVhicGhsbk9hdnRZRjhmWStnckF6dzBVY0tzWkk3cElBOW9UQk14d2N2ck5x?=
 =?utf-8?B?M3dicFZpaFdoSld4YXZDcE55ZTBTNmh3RHNGSUt2S2o5Wml4SVZyMHFndXBI?=
 =?utf-8?B?Q3JBNS9KeWpsclVOYy9rSkNnVFpTUSt0VGh3K2ZZaVcrU0FleVQ1MkZKRnFn?=
 =?utf-8?B?OSsxSTBQcjZIN2VJSDVhdFBPRnJONDkydnhoUmdGWGFqcWkrWURZZDR4MXVJ?=
 =?utf-8?B?ZGpMU1BnVDJkem9PNk9ITU5JeVRuMmlCM0RZTDlZbmduZVBiKzhHYkFJYU5X?=
 =?utf-8?B?UzcrN3NSVWpNc1hDNWNBWFplRWxrdys3SlM3VUs3OUlxWXh0TGcyUitmdVhp?=
 =?utf-8?B?UWpMZkVCYUczR3VGZXhqSW92ejZ2ZEdmN2x4S2hxWTJqSXVYaFJXRmlXNUhq?=
 =?utf-8?B?N1YvMjVJV052YzlwVkFyMCtsM2FCTGNpeUpiMVhSOTlnbFpsYXpIblNieDJh?=
 =?utf-8?B?Z0RkS2hvWGFOUkhHWXRHTzZmTDdMMHpnRmxZWitrVWZTV2VQQkZ6aVVNMzBj?=
 =?utf-8?B?aCtqd3VFbHcyMktjd2RESG15UFZwTW1wZFlLY2tOS2FkOGxwVGRPak9Fck1N?=
 =?utf-8?B?VXg1eWJHRkFpRG1OUmdMekxwWmwvM3JHODhPL2NGUE9LK1R2YnpNdDduQUhq?=
 =?utf-8?B?Q1g5d0F4bDR5ZHJqcW1wd3NIZjVlSHFHVGZPd2l1SlJ1Yk1ZZzJlSjJ4Tm5Z?=
 =?utf-8?B?TmRxOGFucmVCSFFmdUdXUFY1NTlOQVo4N0xxd2hEd1haMlRlOGtEc3N3bklw?=
 =?utf-8?B?VE4xMnoyck9tQkVkVmMwazFNSjA2Z3ROMnhIVjNrMnpXa1NVVi9aQ3ZscE9m?=
 =?utf-8?B?czNLUi83RTVldWpySURwY2NNQVpmbkkxT0RDdlVoZ2FIZjZNL1c0Mis0ZFJS?=
 =?utf-8?B?VGM0OFBWRDB5QnZTeldmUDN1ZSsxeHNlaVY0NndlV1NKRGtYbnNQQUV4Y2I5?=
 =?utf-8?B?Qlo2VUJpM0p2Umo1ZmtneVVMcXJlYUkxM0JHK0FkQ1BtZ0pudi81TFNZTC9z?=
 =?utf-8?B?Y3dWWE1Ec011TzV5VFp4SVYwUGVFeDVQU29IeTFKSTRVakwyaE5jUjRuUkhF?=
 =?utf-8?B?ZEcvUjJIUm0weGhaMlZ1YW5oWWVNbkwraGg4eXlqdTVVUUQ0bVVVSUwxTnNX?=
 =?utf-8?B?a0hsTXllZlgxSk0yUnNzU2dUbE8vMDZLR3pJbWZqak5GVGFDazdvRnBqUDY2?=
 =?utf-8?B?NFlsNkN2czNyVENzNjM1STFVeDNtOTY0blBpNE9kQ2Ribmh6aWNrZXZSOVY2?=
 =?utf-8?B?bTVoOEtLUzhVbXBUNU9BSFl1cVJzZmR6TTlUblZ6TU9xQ1NMQTVFWXQ0WlRV?=
 =?utf-8?B?S3dvN1FXL3BSelRnbnRwdm03V1BaSGFUdnNOMlNRZE9IbEJQbXNiK0xMYWpl?=
 =?utf-8?B?ZW03TmdwUXpPUUE5L0piZVNoZC9CS28wQWd3L3ltNWxNSmVrQXFrUWxidHpL?=
 =?utf-8?B?TEVyQ2JjK2dBdE03a09LMTZkUmYxYzJqVlI3blZxcHNnYU1hTkN1VXVPOGhm?=
 =?utf-8?B?VVBpUlRoYTFFRW9IUVh1TTZPbDhUdmFKSXRPYVN2WVZ0WURxVHVmYnAyR0ho?=
 =?utf-8?B?M1VEb1F6QkNEYmhjWkpXSDlSZXlEUWo3MkJtM1B1anBHdGZzZ04zS0MzWVZO?=
 =?utf-8?B?WnZqRkIra0Q5aEZJZXlSV0JVTC9vaXd5REt4R2ZJZU5qd0RJQWtzZGpqdklq?=
 =?utf-8?B?Sm8xajgxYVNKQ04wSnAvYlZHS2tIVERUQU5yQmZPM09kZkdnVTBJSVk1cm1W?=
 =?utf-8?B?aHZucUI2UjRVSFhWa2F6MFROdzJaWXA2aDc3ajhvZ3RFOW9wdUNzZ3BMb05p?=
 =?utf-8?B?RGx0SjRFYmJaZE1od3FtVURNM2p2WmovNmZzUDhJdUhWN3FHQWJVc251SGlU?=
 =?utf-8?B?bU5Sd2JWMTV0SmlkZDNMTE9ucTRHb0NiVU5SZCtwNEVWMU52bnVZSGJyRTZu?=
 =?utf-8?B?M1I2eVUvR00vMnQzVkdsbWJQdzVJYmNNdWY0cGRpclUzVCsxcW9uaHFQaThW?=
 =?utf-8?B?VUFQRGhIbnA4N2c3SDZJR3hCelpFSGJGUldnZUZpMmFHVlh4Lzg0Z2szVjhh?=
 =?utf-8?B?VjlrdWNQdXRyZ3FiOXBFc2ZpK0FaaE4wckdyZ0F6UlRCekFYcUtMb24wSC9j?=
 =?utf-8?Q?P5vw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f49810-1574-4f89-8a57-08dc575d742e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 23:50:07.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u48vsRw+3VaaXDWZzs+xSoKgp/SsBVONVSgrjatFB3LmM1pT/+qmwXrUmQTmMbd88A0UE71iAbU7x9XiSGiipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0s
c2NtaTogc2V0DQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gDQo+IE9uIDA3LzA0
LzIwMjQgMTI6MDQsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0sc2NtaTogc2V0DQo+ID4+IGFkZGl0aW9u
YWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPj4NCj4gPj4gT24gMDcvMDQvMjAyNCAwMjozNywgUGVu
ZyBGYW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRp
bmdzOiBmaXJtd2FyZTogYXJtLHNjbWk6IHNldA0KPiA+Pj4+IGFkZGl0aW9uYWxQcm9wZXJ0aWVz
IHRvIHRydWUNCj4gPj4+Pg0KPiA+Pj4+IE9uIDA1LzA0LzIwMjQgMTQ6MzksIFBlbmcgRmFuIChP
U1MpIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gV2hlbiBhZGRpbmcgdmVuZG9yIGV4dGVuc2lvbiBwcm90b2NvbHMsIHRo
ZXJlIGlzIGR0LXNjaGVtYSB3YXJuaW5nOg0KPiA+Pj4+PiAiDQo+ID4+Pj4+IGlteCxzY21pLmV4
YW1wbGUuZHRiOiBzY21pOiAncHJvdG9jb2xAODEnLCAncHJvdG9jb2xAODQnIGRvIG5vdA0KPiA+
Pj4+PiBtYXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVswLTldKycNCj4gPj4+Pj4g
Ig0KPiA+Pj4+Pg0KPiA+Pj4+PiBTZXQgYWRkaXRpb25hbFByb3BlcnRpZXMgdG8gdHJ1ZSB0byBh
ZGRyZXNzIHRoZSBpc3N1ZS4NCj4gPj4+Pg0KPiA+Pj4+IEkgZG8gbm90IHNlZSBhbnl0aGluZyBh
ZGRyZXNzZWQgaGVyZSwgZXhjZXB0IG1ha2luZyB0aGUgYmluZGluZw0KPiA+Pj4+IGFjY2VwdGlu
ZyBhbnl0aGluZyBhbnl3aGVyZS4uLg0KPiA+Pj4NCj4gPj4+IEkgbm90IHdhbm5hIGFkZCB2ZW5k
b3IgcHJvdG9jb2xzIGluIGFybSxzY21pLnlhbWwsIHNvIHdpbGwgaW50cm9kdWNlDQo+ID4+PiBh
IG5ldyB5YW1sIGlteC5zY21pLnlhbWwgd2hpY2ggYWRkIGkuTVggU0NNSSBwcm90b2NvbCBleHRl
bnNpb24uDQo+ID4+Pg0KPiA+Pj4gV2l0aCBhZGRpdGlvbmFsUHJvcGVydGllcyBzZXQgdG8gZmFs
c2UsIEkgbm90IGtub3cgaG93LCBwbGVhc2Ugc3VnZ2VzdC4NCj4gPj4NCj4gPj4gRmlyc3Qgb2Yg
YWxsLCB5b3UgY2Fubm90IGFmZmVjdCBuZWdhdGl2ZWx5IGV4aXN0aW5nIGRldmljZXMgKHRoZWly
DQo+ID4+IGJpbmRpbmdzKSBhbmQgeW91ciBwYXRjaCBkb2VzIGV4YWN0bHkgdGhhdC4gVGhpcyBz
aG91bGQgbWFrZSB5b3UNCj4gPj4gdGhpbmcgd2hhdCBpcyB0aGUgY29ycmVjdCBhcHByb2FjaC4u
Lg0KPiA+Pg0KPiA+PiBSb2IgZ2F2ZSB5b3UgdGhlIGNvbW1lbnQgYWJvdXQgbWlzc2luZyBjb21w
YXRpYmxlIC0geW91IHN0aWxsIGRpZCBub3QNCj4gPj4gYWRkcmVzcyB0aGF0Lg0KPiA+DQo+ID4g
SSBhZGRlZCB0aGUgY29tcGF0aWJsZSBpbiBwYXRjaCAyLzYgaW4gdGhlIGV4YW1wbGVzICJjb21w
YXRpYmxlID0NCj4gImFybSxzY21pIjsiDQo+IA0KPiBTbyB5b3UgY2xhaW0gdGhhdCB5b3VyIHZl
bmRvciBleHRlbnNpb25zIGFyZSB0aGUgc2FtZSBvciBmdWxseSBjb21wYXRpYmxlDQo+IHdpdGgg
YXJtLHNjbWkgYW5kIHlvdSBhZGQgbm90aGluZy4uLiBBcmUgeW91ciBleHRlbnNpb25zL3Byb3Rv
Y29sIHZhbGlkIGZvcg0KPiBhcm0sc2NtaT8NCg0KWWVzLiBUaGV5IGFyZSB2YWxpZCBmb3IgYXJt
LHNjbWkuDQoNCiBJZiB5ZXMsIHdoeSBpcyB0aGlzIGluIHNlcGFyYXRlIGJpbmRpbmcuIElmIG5v
LCB3aHkgeW91IHVzZSBzb21lb25lDQo+IGVsc2UncyBjb21wYXRpYmxlPw0KDQpQZXIgU0NNSSBT
cGVjDQoweDgwLTB4RkY6IFJlc2VydmVkIGZvciB2ZW5kb3Igb3IgcGxhdGZvcm0tc3BlY2lmaWMg
ZXh0ZW5zaW9ucyB0bw0KdGhpcyBpbnRlcmZhY2UNCg0KaS5NWCB1c2UgMHg4MSBmb3IgQkJNLCAw
eDg0IGZvciBNSVNDLiBCdXQgb3RoZXIgdmVuZG9ycyB3aWxsIHVzZQ0KdGhlIGlkIGZvciB0aGVp
ciBvd24gcHJvdG9jb2wuDQoNCkkgdXNlIGEgc2VwYXJhdGUgYmluZGluZyBoZXJlIGlzIHRvIGF2
b2lkIGFkZCBtb3JlIHZlbmRvciBzdHVmZg0KaW4gYXJtLHNjbWkueWFtbC4gT3RoZXJ3aXNlIHdl
IHdpbGwgaGF2ZSB0byBhZGQgYSBsaXN0IGFzOg0KaWYgbnhwDQp4eHgNCmVsc2UgaWYgcWNvbQ0K
eHh4DQplbHNlIGlmIHh4DQp5eXkuDQoNCkkgY291bGQgYWRkIGJhY2sgaS5teCBleHRlbnNpb24g
dG8gYXJtLHNjbWkueWFtbCBpZiBwZW9wbGUNCmFncmVlLg0KDQpUaGFua3MNClBlbmcuDQoNCj4g
DQo+IE1heWJlIHlvdXIgYmluZGluZyBpcyBjb3JyZWN0LCBmZWVsIGZyZWUgdG8gY29udmluY2Ug
bWUgKGFuZCByZWFkIGZpcnN0IHdyaXRpbmcNCj4gYmluZGluZ3MpLg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0K

