Return-Path: <linux-kernel+bounces-128093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F678895648
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1DBB312FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999985C5E;
	Tue,  2 Apr 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LrN3xgN3"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2092.outbound.protection.outlook.com [40.107.6.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B52285651;
	Tue,  2 Apr 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066496; cv=fail; b=mUrsKGHbU3jPkaalzjnH4/M59NGK8WzYB1jNUqxGDrADLATsSnlDSYD03l2Cda8JDtMqCbAWWP70jU6WqIBL928CZAxuakdRToCbgthfgQYikHXu4ahkq6TAxKyzFe/YGk8Jhz7hIL2Ly8Cu0X1xwZtz37k9Gl7k+7h/cLowKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066496; c=relaxed/simple;
	bh=rJzq72yMLoorhROrFAjV0O345A/PB0XRL3ebo01xLk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPz7BoxCxzkdNA68QFMIt7MAVnxc2bXOzFxkGi6FrrTmuPj/aG3sRyNp+7DwQ6ORJhtu39ZmIHVTEdNjdnXKVXzcJsDhPyrNQjFNnSTreUOCobhh3khfCj32OY2UWTQoZTDRqljQ6aViosiqPkOIkFFxmhva1kZcbOP2Tu5vX9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LrN3xgN3; arc=fail smtp.client-ip=40.107.6.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih+MSDiGYsr749bQNIOj4Q1LqXQVAd2F1J3ZhS4PhbDwJEJ5upuVjzTkN+QX8IAN1Us55tVlsigvfpC9JOcMQl9VKRpLnIVXScdXlDQDQmjT96mR+5vi3JjtyI6uLZGC4gMtuoViHUGAdNd0v4yooVLMNPgWyiqQURh/zcky+3SWDascy7M7/zui3MwGLvbMD9WrWhjwHxTZ83KRCLxMh8zS18GTNXBdoTTHvDIRxeEN2A2fJLefyx8TZhGwhLSFfsDfLJdJmGqEgpPDKRLyHO/dKnmtkEydp+c5+lTUfNiT9ZMm5AUukvIAjVP/JHeJVZZTMuddvSiZr7LVHUTVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJzq72yMLoorhROrFAjV0O345A/PB0XRL3ebo01xLk0=;
 b=cRLRt7ax1dmBgAiVjgsnCdQONA51uP+YfGzir8VwE6x5e+XhKKWYvGEjEYdZCs3fLpbAkgTSRJ1LsJA+4W/wAmQ7zrEeH+43WDrES9sbp1O1j8hdylC727eKKmM+QchEw7mEFND8g4dPT0GfkIgxVsyXWwR7d5C03p5V0R5hYODVntXFrSdlltcwHWjp0WoJ4boZmIFe5h37f2KRCO9zMeD5NgBvPHCPgh+oaTu4pxs4v9uFHsMbSSS4FHecQTkcxWi9L+7a2HOXak3fS9eSJpsCFHwg73LRV20hfEgYW6Os2GzIdWtkvX6Dc0PjideinlbctbAEU4iLAKVuuT/iKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJzq72yMLoorhROrFAjV0O345A/PB0XRL3ebo01xLk0=;
 b=LrN3xgN3obu0N4xgdNN8EJTl+wT/p33QmeLiv54LoRjVgC821M5VobMI6KisGRVl9Yx5GX4KKtbjB8URzcvYLQ8Z5G05v1czpyg2/BsyrKzMQXRPab/rOh26gF/EZvlNo9M2ng3QP2DcQOvPiXvDwOeuvPG35UN8Uld9Pr7YW1U=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Tue, 2 Apr
 2024 14:01:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 14:01:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHafRqyofu9Mu9OLUiaociI+9q/i7FPHJwAgALIoZCAAsTtAIAAWKsAgAAO4RA=
Date: Tue, 2 Apr 2024 14:01:30 +0000
Message-ID:
 <DU0PR04MB94172B29B33AC0002CF6991B883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zgu4Tok43W5t8KM0@pluto>
 <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
In-Reply-To:
 <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9416:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OgpB14oHrgvywD4+25m+tGx9e/gGxggN8vZhwuYOqrQty+G6PrTINAGlebPMbVeRJgz1wid0fwkwfpeqhIu2M/9hpXJS+1dortUbTakil93ZESNpxcI+DKcsCB9pIssVwYKma6TL1N8thX8kGjUzBCJpy7tSTiK88UzjNhd5iHflNbfLDsqAVOK/GaxmJyqKwaIwXIM0mNt8AR5VLTmHB2k4eScAAJy+ES+P6l4tYZcMoe/TFSSGpspxqYx3q64qWJ64A8dPyPSO/cbAsxbXgFg4AnyAjaKmSPR9B7kUm+mTlutIp4AQ1MgvWDk3/Cq/4VQ2/BxggOiNkfztwG/V8pkWxq04h/WngIEnwXNtuy0J2Bkjl2UgGke1olB3mD+oeWZdN+rxFAM1NqE1/QNq6Z9/SeF9bJffwCGJe6E+YXd7foRgqZgk7JiCgZX2lZve8W+ImzZNLTQk+AJwRTm40UxuGSnDlBJQ0HfcoQmhr5LLdNfBSHffzcOar+41arViFOTSfevxLIqfcXsEd/95KatZwxSALG7HydbDTITmx6CaXq6Nj2TKS247Bs1VXcdKnMCNTDFjMMPFjfF7VYNA3EPfBuReDYkOvPCyfe5hr9SgBGYLYPZHa+3fvslKw/kCiOkquhBnsv7PqZ7ih3eazpOx2q6EGgPN6PgXD/l8K7w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzlITFJNY0toUHFpUUhOdjFEVFRrdk42VU9uR3IyYXZNb0pJU2J6SDJtS0V6?=
 =?utf-8?B?V1NkYTkyV2orSVo1SW40MGtCUjJHZTNWTkt1eEJHY3VOMDFTNFE2djBtbWFD?=
 =?utf-8?B?WUhsaWRBMDZTZFVvb0lCMW9jRTI2WVlHYnVrL1RUcFBkWFhMNGhBUmQrTWFI?=
 =?utf-8?B?V0JyV2NJa01DRmgxdjc5OGpaNHpIYmJQT1BQaDkvaS9HSHhNMnAvNTUxQ2s0?=
 =?utf-8?B?eU5oeEZOSjZXdG5QZlFVSmJYNHFSNThVTkJ0SnltNXZuTWdZOVovZkJxUE0y?=
 =?utf-8?B?RjFXc1dRNStCaC84ajhQd3VYakgrbnBuVE51RU9jTXJ4NnBudlNNdDR5ckor?=
 =?utf-8?B?QlJETDNjei9SQk94blJQOGlOUXJ0blJHZDRGVXRWS1R0SHltTVBmWFU5aFpL?=
 =?utf-8?B?RktRaENIOWwvdDBFOHZWd1VLazdlVnpQQ1AvUyttM05HVERkbjhOcjFYcHBt?=
 =?utf-8?B?cWdlRzhIWk0rODNsVTM2cklmUHlWWnZFZm94SU9LTCtMNndUY0U3WGo3eU1D?=
 =?utf-8?B?bmUxVC8rNXhreTZsYVJwL2FKMExTUVZ0aWhJajczV0pWKzE1NUtjS0pEcS8y?=
 =?utf-8?B?bzNjR3RWYS93QnkxRVd3SmkyT2hSY2d6R2FHU3p1L3pRc2ZZakNqWUI5MDcv?=
 =?utf-8?B?MjBxaHVQWCtrY2RmTzIxOHBLcm0rb01QbnJ5WEMzV2tNNitZWExuTkdFUWRB?=
 =?utf-8?B?Y0dOUFQ3eW1VdXBsVmg1LysxemxIaFNEUkd1eWJNaS8rTlk1UGdCdUwybUlT?=
 =?utf-8?B?M1hUbU1vQ3BuOVhFeWhJWEJIRE5aZCtVWjlCbkxvSFFIM1B6NDJrZTRQbkda?=
 =?utf-8?B?N3A2RGtORENJcFJLdzlkUG5OU2RiTFZCdTlVNnp1aW9Kb1AzamNQSWFRUHlJ?=
 =?utf-8?B?di9lRDZLdFB0aTFwVTN0eGVSV0pHQWtSbFNBS1J5YjRFRjVGNU8zbTBpSlc5?=
 =?utf-8?B?Qy9TOU10Q04xWjBSOStaLytqVlZCWjFvOFhERTJ3THlybEc2enZQeGtUdUhq?=
 =?utf-8?B?RUdJZHdhaDZVWTkraExoazF5UWdma3NqeE5pcHc5RUpUMmZJR0sxRCtqSDFv?=
 =?utf-8?B?K2hpOTZpMzlkdVkwck01VzJrclhINVJWcWtzNVFOeHNaNEwxQ2VpN1psS0Yz?=
 =?utf-8?B?SjA5MnNCamZvUWdXUUs1Zm42alJwV2pLYjJWL0dBOVQ1YnkyVW1wM2p4SHZW?=
 =?utf-8?B?T05YMnNxZEpKMW45c01yWFFnc3l3MDQzRDlqQjhPR2JFam9iMVlnclBnSWpZ?=
 =?utf-8?B?bG4vS2FXWWR6NEpjVURQVm5pOURSNW1IZFRiZHBLSzVIbUNhTm1PaDh1VkNs?=
 =?utf-8?B?bllKVDBFdmpiNlI3TWJvazNLR3V3dDRXRGwwVDRlZ3NMWUxOTXpSMHhZdjF4?=
 =?utf-8?B?ZkxJaXM2R1NLQzBtbGNOV1dtbDVaZmZqVllXeVVVMzZ6OXVWYW8xVnpxWVVi?=
 =?utf-8?B?S2dvQ0c3N1VuTC9jY2Y4bnBtQ3Z0MVhwMCt3NTRnclAwWVM0L0NVWHdEcXpk?=
 =?utf-8?B?NnR6bk55VkVDQVhGZHpOTVBQSG1UTk9qREJ2bUphZ0ZUakx6eVdOZEc5MTZn?=
 =?utf-8?B?djQ4Y082eDBOckhPZEdqT0Q1dVhodDFCR0dJOUxJd0dnN3NwRDdvQUxMdlBu?=
 =?utf-8?B?aExrUk5FTGZWcU5yZjN0SVhDVmRFZXRSQmVqMzYvREtxZGNyS3g3T1hiNllK?=
 =?utf-8?B?T3VQV2oxaTV5N0E2TGQxY212OGpodVNRbnAxQTJWVkV6RDIxcEZhLzJWM0lw?=
 =?utf-8?B?RkJuYzhlTnNtUDllRm8xRzhlOXpEelY5bytDbktEZ0ZIZUZNSCtBajlLYVZY?=
 =?utf-8?B?UDhXendQOGw3OHExMGt4WDdic0ZhOUhEdXI0S1dzYm1SNzBCNU1yMlJlZnc2?=
 =?utf-8?B?dTE5dmh2S0JuQzlkTksyS0RxRzNMTTgxUFVsbk9QYnNpVStEclAxLzEzWTNQ?=
 =?utf-8?B?di9XZzcyMXpyQUMvd2FRZVIyRWEvOEF5OXZ4T2Y3c3dUWkJtT1dVUDdNd0J0?=
 =?utf-8?B?VDFXaGtrTklBTjZyRUlaNzluQ1ZpcTQ2b1ZuWVg4bkE4Q3NSMGtCRENydlhC?=
 =?utf-8?B?TnhlS1MvMjJVTUovVkdvNW1ybjh4NmQ5ak15Z0xnK2d1SGNTR3h2MzFzck1H?=
 =?utf-8?Q?tSKo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dfdd6d-621a-4903-369f-08dc531d65ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 14:01:30.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qzna5pr5zxWG8/quqZ55oJTZLi8N/8DwL1Qs6l2XWy9XYUmOwDApHuLyqpvyd7/X7yAVyPG1XUCXc/LggMo96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9416

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDMvNF0gZmlybXdhcmU6IGFybV9zY21pOiBBZGQgU0NN
SSB2My4yIHBpbmNvbnRyb2wNCj4gcHJvdG9jb2wgYmFzaWMgc3VwcG9ydA0KPiANCj4gT24gVHVl
LCBBcHIgMiwgMjAyNCBhdCAxMDo0OOKAr0FNIENyaXN0aWFuIE1hcnVzc2kNCj4gPGNyaXN0aWFu
Lm1hcnVzc2lAYXJtLmNvbT4gd3JvdGU6DQo+ID4gT24gU3VuLCBNYXIgMzEsIDIwMjQgYXQgMDE6
NDQ6MjhQTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPiA+IFNhdCwgTWFyIDIzLCAyMDI0
IGF0IDA4OjE1OjE2UE0gKzA4MDAsIFBlbmcgRmFuIChPU1MpIGtpcmpvaXR0aToNCj4gDQo+IC4u
Lg0KPiANCj4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gPiA+ICsj
aW5jbHVkZSA8bGludXgvc2NtaV9wcm90b2NvbC5oPiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlzIHNlbWktcmFuZG9tIGxpc3Qgb2YgaGVhZGVycy4gUGxl
YXNlLCBmb2xsb3cgSVdZVSBwcmluY2lwbGUNCj4gPiA+ID4gKGluY2x1ZGUgd2hhdCB5b3UgdXNl
KS4gVGhlcmUgYXJlIGEgbG90IG9mIGluY2x1c2lvbnMgSSBzZWUNCj4gPiA+ID4gbWlzc2luZyAo
anVzdCBpbiB0aGUgY29udGV4dCBvZiB0aGlzIHBhZ2UgSSBzZWUgYml0cy5oLCB0eXBlcy5oLCBh
bmQNCj4gYXNtL2J5dGVvcmRlci5oKS4NCj4gPiA+DQo+ID4gPiBJcyB0aGVyZSBhbnkgZG9jdW1l
bnRhdGlvbiBhYm91dCB0aGlzIHJlcXVpcmVtZW50Pw0KPiA+ID4gU29tZSBoZWFkZXJzIGFyZSBh
bHJlYWR5IGluY2x1ZGVkIGJ5IG90aGVycy4NCj4gDQo+IFRoZSBkb2N1bWVudGF0aW9uIGhlcmUg
aXMgY2FsbGVkICJhIGNvbW1vbiBzZW5zZSIuDQo+IFRoZSBDIGxhbmd1YWdlIGlzIGJ1aWx0IGxp
a2UgdGhpcyBhbmQgd2UgZXhwZWN0IHRoYXQgbm9ib2R5IHdpbGwgaW52ZXN0IGludG8gdGhlDQo+
IGRlcGVuZGVuY3kgaGVsbCB0aGF0IHdlIGhhdmUgYWxyZWFkeSwgdGhhdCdzIHdoeSBJV1lVIHBy
aW5jaXBsZSwgcGxlYXNlDQo+IGZvbGxvdyBpdC4NCj4gDQo+ID4gQW5keSBtYWRlIChtb3N0bHkp
IHRoZSBzYW1lIHJlbWFya3Mgb24gdGhpcyBzYW1lIHBhdGNoIH4xLXllYXIgYWdvIG9uDQo+ID4g
dGhpcyBzYW1lIHBhdGNoIHdoaWxlIGl0IHdhcyBwb3N0ZWQgYnkgT2xla3NpaS4NCj4gPg0KPiA+
IEFuZCBJIHRvbGQgdGhhdCB0aW1lIHRoYXQgbW9zdCBvZiB0aGUgcmVtYXJrcyBhcm91bmQgZGV2
bV8gdXNhZ2Ugd2VyZQ0KPiA+IHdyb25nIGR1ZSB0byBob3cgdGhlIFNDTUkgY29yZSBoYW5kbGVz
IHByb3RvY29sIGluaXRpYWxpemF0aW9uICh1c2luZw0KPiA+IGEgZGV2cmVzIGdyb3VwIHRyYW5z
cGFyZW50bHkpLg0KPiA+DQo+ID4gVGhpcyBpcyB3aGF0IEkgYW5zd2VyZWQgdGhhdCB0aW1lLg0K
PiA+DQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbG9yZQ0KPiA+IC5rZXJuZWwub3JnJTJGbGludXgtYXJtLWtlcm5l
bCUyRlpKNzhoQmNqQWhpVSUyQlpCTyU0MGUxMjA5MzctDQo+IGxpbiUyRiUyDQo+ID4NCj4gM3Qm
ZGF0YT0wNSU3QzAyJTdDcGVuZy5mYW4lNDBueHAuY29tJTdDM2Y4YzEyMDYyZGIwNDg2MDhlMmEw
OGQNCj4gYzUzMTViZWQNCj4gPg0KPiAwJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMCU3QzYzODQ3NjYwMDA1ODMNCj4gNDA0MzAlN0NVbg0KPiA+DQo+IGtub3duJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
DQo+IGsxaGFXDQo+ID4NCj4gd2lMQ0pYVkNJNk1uMCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9V2hu
M2VoWmpYeSUyQmNLRzRpcmxXalE2DQo+IEszSEYlMkZvZkQNCj4gPiBZdTdqMExybThkTjVrJTNE
JnJlc2VydmVkPTANCj4gPg0KPiA+IEkgd29udCByZXBlYXQgbXlzZWxmLCBidXQsIGluIGEgbnV0
c2hlbGwgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIGxpa2UgaXQNCj4gPiBpcyBub3cgaXMgZmluZTog
YSBiaXQgaGFwcGVucyB2aWEgZGV2bV8gYXQgcHJvdG9jb2wgaW5pdGlhbGl6YXRpb24sDQo+ID4g
dGhlIG90aGVyIGlzIGRvZSB2aWEgZXhwbGljaXQga21hbGxvYyBhdCBydW50aW1lIGFuZCBmcmVl
ZCB2aWEga2ZyZWUNCj4gPiBhdCByZW1vdmUgdGltZSAoaWYgbmVlZGVkLi4uaS5lLiBjaGVja2lu
ZyB0aGUgcHJlc2VudCBmbGFnIG9mIHNvbWUNCj4gPiBzdHJ1Y3RzKQ0KPiANCj4gVGhpcyBzb3Vu
ZHMgbGlrZSBhIG1lc3MuIGRldm1fIGlzIGV4cGVjdGVkIHRvIGJlIHVzZWQgb25seSBmb3IgdGhl
DQo+IC0+cHJvYmUoKSBzdGFnZSwgb3RoZXJ3aXNlIHlvdSBtYXkgY29uc2lkZXIgY2xlYW51cC5o
IChfX2ZyZWUoKSBtYWNybykNCj4gdG8gaGF2ZSBhdXRvbWF0aWMgZnJlZSBhdCB0aGUgcGF0aHMg
d2hlcmUgbWVtb3J5IGlzIG5vdCBuZWVkZWQuDQo+IA0KPiBBbmQgdGhlIGZ1bmN0aW9uIG5hbWlu
ZyBkb2Vzbid0IHN1Z2dlc3QgdGhhdCB5b3UgaGF2ZSBhIHByb2JlLXJlbW92ZSBwYWlyLg0KPiBN
b3Jlb3ZlciwgaWYgdGhlIGluaXQtZGVpbml0IHBhcnQgaXMgY2FsbGVkIGluIHRoZSBwcm9iZS1y
ZW1vdmUsIHRoZSBkZXZtXw0KPiBtdXN0IG5vdCBiZSBtaXhlZCB3aXRoIG5vbi1kZXZtIG9uZXMs
IGFzIGl0IGJyZWFrcyB0aGUgb3JkZXIgYW5kIGxlYWRzIHRvDQo+IHN1YnRsZSBtaXN0YWtlcy4N
Cg0KSSBhbSBuZXcgdG8gX19mcmVlKCkgaG9uZXN0bHkuIEknbGwgbGV0IENyaXN0aWFuIGFuZCBT
dWRlZXAgdG8gY29tbWVudCBvbg0Kd2hhdCBzaG91bGQgSSBkbyBmb3IgdjguDQoNClRoYW5rcywN
ClBlbmcuDQoNCj4gDQo+ID4gSSdsbCBtYWRlIGZ1cnRoZXIgcmVtYXJrcyBvbiB2NyB0aGF0IHlv
dSBqdXN0IHBvc3RlZC4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCg==

