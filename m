Return-Path: <linux-kernel+bounces-136554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC489D57E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C52B23579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B88080BE7;
	Tue,  9 Apr 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gK7X1L3J"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2123.outbound.protection.outlook.com [40.107.8.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61380039;
	Tue,  9 Apr 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654718; cv=fail; b=KW6IZIzmddNCXXtNUHl1o2xYLZb3jrh6/7KKgdm8pdRuNyMtg1qf7wQqoSilt0iA6zYqmgFpVIaIdlTLSyncklqYPWVkO3z8AT4hw2PpB7FujzznfDUCkHHdxxpIE0Ag/9GWg3hfhkWYGJEsx8uwwFG0tFKVLNbJhptS+HpKnso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654718; c=relaxed/simple;
	bh=0+aS7aIVWnN4kJ6OOv3aBbBjurK56tB/nphiCpezCB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vq00tqkCiYW0bbID/og6o/e4NJyQWMe+XWI4VaascTqvw9laQbMxCM4uHI6qrWQ5GjOMwa7nn1EUhuqiA1P9VXQwTuaCwn+v46/ZrdW8V+fvARmlUS1XYqSdJJ9NPT//gwPvP2Sl/jIFypYTCjBwgRAdYaQ5kAZAVI4ruUggiW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gK7X1L3J; arc=fail smtp.client-ip=40.107.8.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irS4esr2aqU+8RFXAyMBMUHgOJ+db32YT2XkkWhFWoGPCxIxrz/OoSAd5hjinf8BSpx8dGXup4w9eMU/4tzhnPwIq1J9W4H1SHeYx4+f4g/EZiEM3eiGAXIS/jVxjTNY24HBddkpsm8Coo9aZuTSL51W+NSJ+mrUoRH8L58FuvIwm7lNV6xrJclIoMk06THfb7sqDmTlLm0o+JmB4DQDXEpNjVnxnR2Gi+6lNiwxmqOnBK01tO9AfOxf0NqZFkygTtSXE86ttj7R55ZeeoippjPg6dcYODAfCEAYO6ClRzpnuPzVddWhsT5jxJ0WNG5cmHpABZBdD+8o7H6g8cXbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+aS7aIVWnN4kJ6OOv3aBbBjurK56tB/nphiCpezCB8=;
 b=AgXoDtZz+GtHWubzwihXBg4PsssP9Cj/TjFR2dLCx1S+FR+2dPWOvZMcX4rMIOvVPj6fNCPVcc4+mcWkoBuVIsQWK2o8cn0AFAhiueDw2Kj+oQR3wFfIK50iAJWKH8W3he2bRoUNJfqYg9laLPvPOiHVC8uHFcP6hmHQO0Z2wCrJMyPVP7tx2ag+XL5qJ/ELkHAReS+AqWjXFM8rqG6kV45F3dCMLU/dgrPhHEezR/b4YFnEQ9Bkc/9BenAwfQsK/sZdYgFtHlE6dtJz7Duam38ZLXGn0juIHF1SztTHgOIkaAr8RGOfGLFUu5JxB8/Ac31htPsFHtUXfn3PR/ML1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+aS7aIVWnN4kJ6OOv3aBbBjurK56tB/nphiCpezCB8=;
 b=gK7X1L3J3BkB77KDdT4VrTVE1M4yeAFrxl638kq2R8BJ6XFzvO5AhDGkqEwZ8B5l1RME58bTft3AEzPXdxsIZYYwvgufnMt8U4EATY4VudCXtqC3D6gYmghG9BeKYZlggEVR4eZRTajgjuS0UFrPrUsCw2yXsiAXuKfpsS/FFhk=
Received: from AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Tue, 9 Apr
 2024 09:25:11 +0000
Received: from AS1PR04MB9431.eurprd04.prod.outlook.com
 ([fe80::95f1:f32e:75b4:1ecd]) by AS1PR04MB9431.eurprd04.prod.outlook.com
 ([fe80::95f1:f32e:75b4:1ecd%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 09:25:11 +0000
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
 AQHah1U2hf+AkPhDj02wsn9yNtLUjbFbE9+AgADkvNCAAItFAIAAEwgggABoGYCAAH0iQIAAaICAgAAAQWCAABZPAIAAAHjwgAG0zOA=
Date: Tue, 9 Apr 2024 09:25:10 +0000
Message-ID:
 <AS1PR04MB9431BE4B2BFE05507A2D93F288072@AS1PR04MB9431.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
 <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org>
 <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ba4c9f20-0391-4ac2-a236-d6930285cd7e@kernel.org>
 <DU0PR04MB94176D02B90528913842B76A88002@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <e6333665-8051-43b1-9e98-f76262ddbc35@kernel.org>
 <DU0PR04MB9417C8C5013C72AB1F61F1C588002@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB9417C8C5013C72AB1F61F1C588002@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9431:EE_|AS8PR04MB8296:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xlMQW1meOuiUG1xZiznzlwPRVfQIGmWLPiQ0q5M+SUBtVdQksiSzWe4fiqNNYPp19I1w1LT1Y8kmADqnVCnvXIwAOtRfg3y4cPb06zZ4i+WHIRGIwEle7WJsaNqamEFHGujpgAaDqaUdFA6UezN6z6QL5qeA5pCrmVlEEh24FoEDhTkUvwy8drcnG5jK/JMt3bTfSQWC1EWD3oea8oawJHs3Yactj1PEWVDnDHSpdXY62g2255ldh/+K/AQ68828KJXdxIpvAwlQHihEF48l4Xmxv4uvNMy0jvvrV4tTN2qVfnvg5+UnTT/ZQ0YpxPCUbvZDSrzjcIGlkF8QlgBgVY77rbleVFUGTrcnkWytoNHh/zzuuF45/0BliAjmkx8K8+n9wrtzfs8kerNcWnQHnm9l6GUYVSX70XWHSO/hZ7hl7tNADBKo0a+tWGbHj0Tbjj4UxDiMdOU6hMYMK2IrwNn9qb9xS9P/C7vjCaOIf5UTK2tl7e2NT+eGPBlD80kFBhSneDbzwIawPyqdQvxHqFqCPfMNxQNV6aVDaQZCmKo+RLlGBsxDM+qdhThm2z2Pw0jKFQzjF+vTSTwZwy/XhQLq1Ndm7zdejLHNs9y7zbvbKXBdWkaolCsA1KmOpgpncrADO0vpn30HjdNGlbsL9q6TOFDhYiEcO28+jffapw10550SJoUdwC1FYPEQ8cMKrm4mCkEGUBum3m5QQvsWBg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9431.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1hpS3ovYjVXY2kyNVNlY2JZUHY2Yk5yMStoRUlpVWRRdXBucy9MMGNXOHAz?=
 =?utf-8?B?cGR2NUoxa1BwNVZzSXhXbUdVaUZTRk1VOXROVkQ3TFFkWUVua2lGd2I5MnBk?=
 =?utf-8?B?cUkrbDFkdmNETFlJNmMzUHBremRzb2lmRUpkU20xRk5kSG51TVJYS09KYkRR?=
 =?utf-8?B?clAwc05UNXJodG12R3c4R21uWnJUdSt5eVUxazc4d0ZSSnVaUk43N3NlMGFS?=
 =?utf-8?B?S3lCMXU5UlZxYWkrV3VLOXFYSTR3eUhEak1EMjJvcm9hNGE2VTJJam9NZXFI?=
 =?utf-8?B?ZUNUYlZ3ZVRnOTFrNmJ1R2xaUTR1S25zbFk3VnE3Nld2ZGZubjFyUXpmUXNC?=
 =?utf-8?B?Z0Rud0xwZHhpSUF4U3hzc3FuOEYrNU1Qb0FEeXJoWHY4ekNXSlQ0ZFhFcm5Y?=
 =?utf-8?B?UldvQXBZWHZtM2tWZHVySTFCU0JVV0h2MVpPK1p0S0FoQUVvSDZHZ0E5Y2Vx?=
 =?utf-8?B?TkdlMVRMeHNOUkQzSk0rSkdQUFFDSXpSdURPOGJweVg1YkhoSGtiSC9XRE9I?=
 =?utf-8?B?Vkd1L3laTVVNRDVTWUJlRDFlanB2aVBUTTFaSkp4NGFEWWpXQjlBdjBieTAr?=
 =?utf-8?B?Nk9pTXN1MFdpblNtcnVNR0VXc01iMURlc3VmVURTYitaUUUyaU93TE4rQ29S?=
 =?utf-8?B?ZUdhVDRwa2JYN1FONzZTZ3VZVmFvVk9uckY1M1dhSmp4bWV1MmE5WWdlbFZQ?=
 =?utf-8?B?eGUyZDcybW53djJadWE4TlFRSDBsY3NaMTBMOTNIb0ErTjYxSllXY3JVZzFS?=
 =?utf-8?B?UFZSVFdKRXlvNGRJdkgrbjJTTlNLMHhjUFd5SzFsYWNnY2lrajlETnhrd21Z?=
 =?utf-8?B?Y1czQ2JDanBIM2JPWVFXQUlCNkF1QnFIVmp2Z3U0aTdSdHB1NzZiUkdnZUhC?=
 =?utf-8?B?ZElnNzdaZTYvRWJmYnBDY3lvc29wUG4wWmFRamY0TGh5TE1EY2p5Y0IrTDdM?=
 =?utf-8?B?OUN4NktSQ1kzN1B2M3VINlVROUhLb2xtQzdTZWpyeTVDeGVZL1MzT0NEZFo2?=
 =?utf-8?B?ZGZFRVA5bzFVQ3VPaXVMNWdsZU83N2Q3YlJmNVlkTEZ5ZzZtUDVHSlpTYTFK?=
 =?utf-8?B?UXdjWXpZQkpUZUVJbVhVNE5CM1pRWE1HdXBJMkVDOUUxK0FVMVhhQ1R1bnhq?=
 =?utf-8?B?UEdaWlBIdWQrVFdhUHdEOFdwYm0vRmFsY0pKNHUwU1lKL08xSWxuZHBaNW85?=
 =?utf-8?B?NFI3RVNLajhnLzRYSE9MbUVIVFJTUWIrUlE4OXVDSkF5YVVZYlNsV254OFFB?=
 =?utf-8?B?NFd4ellXcklXY2hlQ2p2NkRSdzArZmlrM3BQWXMyckdnMW90WUlhdDAxcEJh?=
 =?utf-8?B?WFAxY1ViNTltTW1uaGxYWHFxSFdaekZyRkNVMEJ1RXZFS2dtNjl6K1RTY0Ux?=
 =?utf-8?B?c2RFREorN0g1cS9WSHZyTmNQdkw2allvZkhZWEFtNWF6ajV4UVN4ZDI0cXVy?=
 =?utf-8?B?aDJQTjB1cHRnZTVGcnhMNEJZVU5kMURwd2FhSU5WQ1hjeExDUnpSbVdNSCt6?=
 =?utf-8?B?TkdUNHJyenExazROZVUyTVVWWWpBcGh4T3FqalJ1MlVSYmFWaFgySFBLSE83?=
 =?utf-8?B?VTNvbEc1U2ZjVy82TjBQZ1NkNmVubjNSMEQ0bFlsdkhzeFZGVkhqajM3OElx?=
 =?utf-8?B?ektPd1ZKSWhsWnZudEFQVjhvMHdhazdGeGdzZWUyM01hbmtjQWc5bHZ4VldK?=
 =?utf-8?B?d1d0L3NwbkQ5THR0MG1hakEza20rRXlnMldhbzNDNGVheStyUTVjVGM4UW5z?=
 =?utf-8?B?MXFkaGJhT1JVRWlZbnhBQzkwMHMwV0QreUxKN0xvUHl1QjVRM2lwNXRLSkRW?=
 =?utf-8?B?ZFo4dVRGK3pyWk4zenVsdHBvb1U4ZmJOUVowOHF6eFNLRmdBNWxaOGpNSXVk?=
 =?utf-8?B?L0c4eVhNTDJWVzNoWWJReUVPSXJ6Q2UrWWtGT2I2alpkaTk3RnMrZVcrdTJ1?=
 =?utf-8?B?cnhzTFRTR2Rmbm1oNlkva1N2VlpFK01Ca1hGQ3pZSnA2TDdDZWN6Zlp2TFhP?=
 =?utf-8?B?QzdKMDgxMm5ySDAzTlp0Q2c2Z1pvenpHbFNyeUpJa2pqTmpKM1plK1R4Slo3?=
 =?utf-8?B?SFVCYm9KalkrWi8rMlM2WlY3a0RQUDE5UnVURXEvZ1FDbUhKWkNlTUtQQUlN?=
 =?utf-8?Q?xl9I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9431.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25232b61-6a55-4777-1039-08dc5876f476
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 09:25:10.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Izw278ozda5oQaW9i6yLXO8hROr4ryA8MIEhPYg5T2ckROXRi2eMbN6csxZdyPdZBGatcgaP/BonglT1FScSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296

SGkgS3J6eXN6dG9mLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMS82XSBkdC1iaW5kaW5n
czogZmlybXdhcmU6IGFybSxzY21pOiBzZXQNCj4gYWRkaXRpb25hbFByb3BlcnRpZXMgdG8gdHJ1
ZQ0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13
YXJlOiBhcm0sc2NtaTogc2V0DQo+ID4gYWRkaXRpb25hbFByb3BlcnRpZXMgdG8gdHJ1ZQ0KPiA+
DQo+ID4gT24gMDgvMDQvMjAyNCAwODowOCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRpbmdzOiBmaXJtd2FyZTogYXJtLHNjbWk6IHNl
dA0KPiA+ID4+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPiA+Pg0KPiA+ID4+IE9u
IDA4LzA0LzIwMjQgMDE6NTAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4+Pj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRpbmdzOiBmaXJtd2FyZTogYXJtLHNjbWk6IHNldA0KPiA+
ID4+Pj4gYWRkaXRpb25hbFByb3BlcnRpZXMgdG8gdHJ1ZQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+IE9u
IDA3LzA0LzIwMjQgMTI6MDQsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4+Pj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0sc2NtaToNCj4gPiA+
Pj4+Pj4gc2V0IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPiA+Pj4+Pj4NCj4gPiA+
Pj4+Pj4gT24gMDcvMDQvMjAyNCAwMjozNywgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPj4+Pj4+Pj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRpbmdzOiBmaXJtd2FyZTogYXJtLHNj
bWk6DQo+ID4gPj4+Pj4+Pj4gc2V0IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPiA+
Pj4+Pj4+Pg0KPiA+ID4+Pj4+Pj4+IE9uIDA1LzA0LzIwMjQgMTQ6MzksIFBlbmcgRmFuIChPU1Mp
IHdyb3RlOg0KPiA+ID4+Pj4+Pj4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPiA+Pj4+Pj4+Pj4NCj4gPiA+Pj4+Pj4+Pj4gV2hlbiBhZGRpbmcgdmVuZG9yIGV4dGVuc2lv
biBwcm90b2NvbHMsIHRoZXJlIGlzIGR0LXNjaGVtYQ0KPiA+ID4+IHdhcm5pbmc6DQo+ID4gPj4+
Pj4+Pj4+ICINCj4gPiA+Pj4+Pj4+Pj4gaW14LHNjbWkuZXhhbXBsZS5kdGI6IHNjbWk6ICdwcm90
b2NvbEA4MScsICdwcm90b2NvbEA4NCcgZG8NCj4gPiA+Pj4+Pj4+Pj4gbm90IG1hdGNoIGFueSBv
ZiB0aGUgcmVnZXhlczogJ3BpbmN0cmwtWzAtOV0rJw0KPiA+ID4+Pj4+Pj4+PiAiDQo+ID4gPj4+
Pj4+Pj4+DQo+ID4gPj4+Pj4+Pj4+IFNldCBhZGRpdGlvbmFsUHJvcGVydGllcyB0byB0cnVlIHRv
IGFkZHJlc3MgdGhlIGlzc3VlLg0KPiA+ID4+Pj4+Pj4+DQo+ID4gPj4+Pj4+Pj4gSSBkbyBub3Qg
c2VlIGFueXRoaW5nIGFkZHJlc3NlZCBoZXJlLCBleGNlcHQgbWFraW5nIHRoZQ0KPiA+ID4+Pj4+
Pj4+IGJpbmRpbmcgYWNjZXB0aW5nIGFueXRoaW5nIGFueXdoZXJlLi4uDQo+ID4gPj4+Pj4+Pg0K
PiA+ID4+Pj4+Pj4gSSBub3Qgd2FubmEgYWRkIHZlbmRvciBwcm90b2NvbHMgaW4gYXJtLHNjbWku
eWFtbCwgc28gd2lsbA0KPiA+ID4+Pj4+Pj4gaW50cm9kdWNlIGEgbmV3IHlhbWwgaW14LnNjbWku
eWFtbCB3aGljaCBhZGQgaS5NWCBTQ01JDQo+ID4gPj4+Pj4+PiBwcm90b2NvbA0KPiA+ID4+IGV4
dGVuc2lvbi4NCj4gPiA+Pj4+Pj4+DQo+ID4gPj4+Pj4+PiBXaXRoIGFkZGl0aW9uYWxQcm9wZXJ0
aWVzIHNldCB0byBmYWxzZSwgSSBub3Qga25vdyBob3csIHBsZWFzZQ0KPiA+IHN1Z2dlc3QuDQo+
ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+IEZpcnN0IG9mIGFsbCwgeW91IGNhbm5vdCBhZmZlY3QgbmVn
YXRpdmVseSBleGlzdGluZyBkZXZpY2VzDQo+ID4gPj4+Pj4+ICh0aGVpcg0KPiA+ID4+Pj4+PiBi
aW5kaW5ncykgYW5kIHlvdXIgcGF0Y2ggZG9lcyBleGFjdGx5IHRoYXQuIFRoaXMgc2hvdWxkIG1h
a2UNCj4gPiA+Pj4+Pj4geW91IHRoaW5nIHdoYXQgaXMgdGhlIGNvcnJlY3QgYXBwcm9hY2guLi4N
Cj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gUm9iIGdhdmUgeW91IHRoZSBjb21tZW50IGFib3V0IG1p
c3NpbmcgY29tcGF0aWJsZSAtIHlvdSBzdGlsbA0KPiA+ID4+Pj4+PiBkaWQgbm90IGFkZHJlc3Mg
dGhhdC4NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IEkgYWRkZWQgdGhlIGNvbXBhdGlibGUgaW4gcGF0
Y2ggMi82IGluIHRoZSBleGFtcGxlcyAiY29tcGF0aWJsZQ0KPiA+ID4+Pj4+ID0NCj4gPiA+Pj4+
ICJhcm0sc2NtaSI7Ig0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFNvIHlvdSBjbGFpbSB0aGF0IHlvdXIg
dmVuZG9yIGV4dGVuc2lvbnMgYXJlIHRoZSBzYW1lIG9yIGZ1bGx5DQo+ID4gPj4+PiBjb21wYXRp
YmxlIHdpdGggYXJtLHNjbWkgYW5kIHlvdSBhZGQgbm90aGluZy4uLiBBcmUgeW91cg0KPiA+ID4+
Pj4gZXh0ZW5zaW9ucy9wcm90b2NvbCB2YWxpZCBmb3IgYXJtLHNjbWk/DQo+ID4gPj4+DQo+ID4g
Pj4+IFllcy4gVGhleSBhcmUgdmFsaWQgZm9yIGFybSxzY21pLg0KPiA+ID4+Pg0KPiA+ID4+PiAg
SWYgeWVzLCB3aHkgaXMgdGhpcyBpbiBzZXBhcmF0ZSBiaW5kaW5nLiBJZiBubywgd2h5IHlvdSB1
c2UNCj4gPiA+Pj4gc29tZW9uZQ0KPiA+ID4+Pj4gZWxzZSdzIGNvbXBhdGlibGU/DQo+ID4gPj4+
DQo+ID4gPj4+IFBlciBTQ01JIFNwZWMNCj4gPiA+Pj4gMHg4MC0weEZGOiBSZXNlcnZlZCBmb3Ig
dmVuZG9yIG9yIHBsYXRmb3JtLXNwZWNpZmljIGV4dGVuc2lvbnMgdG8NCj4gPiA+Pj4gdGhpcyBp
bnRlcmZhY2UNCj4gPiA+Pj4NCj4gPiA+Pj4gaS5NWCB1c2UgMHg4MSBmb3IgQkJNLCAweDg0IGZv
ciBNSVNDLiBCdXQgb3RoZXIgdmVuZG9ycyB3aWxsIHVzZQ0KPiA+ID4+PiB0aGUgaWQgZm9yIHRo
ZWlyIG93biBwcm90b2NvbC4NCj4gPiA+Pg0KPiA+ID4+IFNvIGhvdyBhcmUgdGhleSB2YWxpZCBm
b3IgYXJtLHNjbWk/IEkgZG9uJ3QgdW5kZXJzdGFuZC4NCj4gPiA+DQo+ID4gPiBhcm0sc2NtaSBp
cyBhIGZpcm13YXJlIGNvbXBhdGlibGUgc3RyaW5nLiBUaGUgcHJvdG9jb2wgbm9kZSBpcyBhIHN1
Yi1ub2RlLg0KPiA+ID4gSSB0aGluayB0aGUgYXJtLHNjbWkgaXMgdGhhdCBzYXlpbmcgdGhlIGZp
cm13YXJlIGZvbGxvd2luZyBTQ01JIHNwZWMNCj4gPiA+IHRvIGltcGxlbWVudCB0aGUgcHJvdG9j
b2xzLg0KPiA+ID4NCj4gPiA+IEZvciB2ZW5kb3IgcmVzZXJ2ZWQgSUQsIGZpcm13YXJlIGFsc28g
Zm9sbG93IHRoZSBTQ01JIHNwZWMgdG8NCj4gPiA+IGltcGxlbWVudCB0aGVpciBvd24gdXNhZ2Us
IHNvIGZyb20gZmlybXdhcmUgbGV2ZWwsIGl0IGlzIEFSTSBTQ01JDQo+ID4gPiBzcGVjDQo+ID4g
Y29tcGF0aWJsZS4NCj4gPg0KPiA+IFRoYXQncyBub3QgdGhlIHBvaW50LiBJdCBpcyBvYnZpb3Vz
IHRoYXQgeW91ciBmaXJtd2FyZSBpcyBjb21wYXRpYmxlDQo+ID4gd2l0aCBhcm0sc2NtaSwgYnV0
IHdoYXQgeW91IHRyeSB0byBzYXkgaW4gdGhpcyBhbmQgcmV2aXNlZCBwYXRjaCBpcw0KPiA+IHRo
YXQgZXZlcnkgYXJtLHNjbWkgaXMgY29tcGF0aWJsZSB3aXRoIHlvdXIgaW1wbGVtZW50YXRpb24u
IFdoYXQgeW91DQo+ID4gYXJlIHNheWluZyBpcyB0aGF0IDB4ODQgaXMgTUlTQyBwcm90b2NvbCBm
b3IgZXZlcnkgZmlybXdhcmUsIFF1YWxjb21tLA0KPiA+IE5YUCwgU2Ftc3VuZywgVEksIE1lZGlh
dGVrIGV0Yy4NCj4gPg0KPiA+IEkgY2xhaW0gaXQgaXMgbm90IHRydWUuIDB4ODQgaXMgbm90IE1J
U0MgZm9yIFF1YWxjb21tLCBmb3IgZXhhbXBsZS4NCj4gDQo+IFlvdSBhcmUgcmlnaHQuIEkgYW0g
bG9zdCBub3cgb24gaG93IHRvIGFkZCB2ZW5kb3IgSUQgc3VwcG9ydCwgdXNpbmcNCj4gYXJtLHNj
bWkueWFtbCBvciBhZGRpbmcgYSBuZXcgaW14LHNjbWkueWFtbCBvciBlbHNlLg0KDQpEbyB5b3Ug
aGF2ZSBhbnkgc3VnZ2VzdGlvbnMgb24gaG93IHRvIGFkZCB2ZW5kb3IgcHJvdG9jb2wgaW4NCmR0
LXNjaGVtYT8gSSBhbSBub3Qgc3VyZSB3aGF0IHRvIGRvIG5leHQsIHN0aWxsIGtlZXAgaW14LHNj
bWkueWFtbA0Kb3IgYWRkIHZlbmRvciBzdHVmZiBpbiBhcm0sc2NtaS55YW1sPw0KDQpUaGFua3Ms
DQpQZW5nLg0KDQo+IA0KPiBQbGVhc2Ugc3VnZ2VzdC4NCj4gDQo+IFRoYW5rcywNCj4gUGVuZw0K
PiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlzenRvZg0KDQo=

