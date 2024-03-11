Return-Path: <linux-kernel+bounces-98666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B8877D96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F71F222B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A6241E7;
	Mon, 11 Mar 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MQ20D/Gq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260D2C698;
	Mon, 11 Mar 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151459; cv=fail; b=F2yznN/gGEZyDLoJ1OGQUTRTcj7ELCz7INaWaRlyAqnsfyCOTVOe8f+kZTVnTBxXKF2w8+UlHBrNFXsyZBC1oqxTNhXUKQmycU0Fj8HlMf1t/MFEiM9ZvGDVKt8NJJv0Nd22beNgqikALzAHXiT//IobNTYCTAgGQXJcvYLE5EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151459; c=relaxed/simple;
	bh=YXSm3yWS4oaF9LnXhQWt4lTWecceYzjbiRUNDgZRIHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbV7qZrQ2KiIKybGJaEL2TIZYaS8VPF/bScosVPUIpGRHAt1o8VhpLAska4NLYTrO+ZeZrSjXjGsJDuMEX0PedIjI9k7I9pbAHLqAIFKAQXIjNsP2zQXJG7pbjvbJsw0pw65K3RswrDx1E6DRc8BqO1yJUdp9GXJFqHG31ufD4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MQ20D/Gq; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4l2dM/lW44X25Ru/TUd87wcFNa3Tm5MR0IyUdjH+kw/+lEjx4RLaTwiFMHBayns88N18D+E8xo6B5TMtZwV05ubac3hbeYsZnam/UY+OplpVBw2ztd2J3TArx6mkSucjpAdgDRawuYExHcb6ED1IvEPnShI59GljHcq4q6Gkm24vH4S5cgyHxtyCrFzhoMgQLSGvwBKQa/8zd23LGtEaku1BuMDhIZepMsFlS1l+dcP2Vrm3FyWE/PMuy5LrQL/YlvBPxVga2g/jnjZmIwO/+ux7dUtYJPGyrtjuP8ub8M1vwYUgZvD9hy/J5K/PCFeCVXCxDeGU8UXHq4Rng333A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXSm3yWS4oaF9LnXhQWt4lTWecceYzjbiRUNDgZRIHo=;
 b=eqtdHubqSEJkmFzIRUVMqPFla2qdw/4zMjKtJVNsxoCXLy7G1Ryrq6gad92LG41tgArqrypQ8sR09HAro/yK22bWrTt8npyiiVjyxF0K3UBu44bZ1Pbb7LreQxSoHgE12PjHgVCBve0I8IxcESZSD5mZiTaiZYLqG8w7brm0+4ZDx8ZzjvUkpmGK2QIZcAe95+howiBUilMv+R1WAUB1LugN21yLz2HIqADgkQX4gVjOSs9iN2xfC4bCPva2UrZmHcinIOu/bYRkw0dbG0dIa/i7ByzqfMY5b4D9BqDkJ3jwRgkTmwycyLQv6IA/8gwTjqHDuvieYgUUMabktw+wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXSm3yWS4oaF9LnXhQWt4lTWecceYzjbiRUNDgZRIHo=;
 b=MQ20D/GqzVdglVkkf2u8qHpzM/fiMC8EG0QD3JVzUa2TYiWFGXRW+7p87+irzOtV1Dk9TkXazQqaZG9IBV2EW3K7RzCc5P/P/ogFeSaAxUdd7glQ+D39WAs7S7y5uKcUy5bqcb95q2JxGjNP7T1cfKhjzXfHFugGV1n5wRKfmVk=
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 10:04:12 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 10:04:12 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jacky Bai
	<ping.bai@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v2 1/3] regulator: dt-bindings: pca9450: add
 pca9451a support
Thread-Topic: [EXT] Re: [PATCH v2 1/3] regulator: dt-bindings: pca9450: add
 pca9451a support
Thread-Index: AQHac4+4o8Q/DrvdkEahiiYL1rp/QbEyTreAgAAAieA=
Date: Mon, 11 Mar 2024 10:04:11 +0000
Message-ID:
 <DB9PR04MB9377B0CAA24E749AE6B1A7A6E1242@DB9PR04MB9377.eurprd04.prod.outlook.com>
References: <20240311084758.377889-1-joy.zou@nxp.com>
 <20240311084758.377889-2-joy.zou@nxp.com>
 <5bfd84f8-42fb-4ada-92e6-5765a6d4ba9b@linaro.org>
In-Reply-To: <5bfd84f8-42fb-4ada-92e6-5765a6d4ba9b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9377:EE_|PA4PR04MB8048:EE_
x-ms-office365-filtering-correlation-id: 79f51e98-f0b8-4fc5-6fc5-08dc41b299d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2MS7mueJ28VCvfs0AkkypUYElF2IiyusL+jSDTuVdYxli6wQO+GVedhNn0GEjPlYJ48rKdELdfOC+8m9wMnaYDLxWpviwyaIFXfFjgdppRGbxJcrmpq21Rws29rlHMobBjZcIS4U5O4Jiefr0RiIr77dzgHjH6444iFTXbS+OOEG0Omt9+20RnIoPS4hl4O//czyN3cLLGDQemBMUiXwZx7q/wyugtMcAI846iadFWA4DXVQ3ynMzdseTQ8T2DvHnt9xB+DNxnlJhJFJH4MH0SoPe5KfqRRLEItDi6rXQ1/g8/1f6+eLZkdgGxHrPhMIXsszZ537xFOhrm2mGkxJXowzU83I4QWJg3v/szLlba65mMIvo+lRf4AEwA0xGppLN+51Hq6MuIZTnNYo3LooOGXQWkuy/jSUaXYJ1Fxk/uiHZhhT2UlkyKpHFowTU3PpkvhpZcEcK6VdAyGPKXKd1bqwd1dXyts6WBf0nVrNZYT7q+w+vny3Lj+eoN+0ff7EvHUKqvtYrSg1RNLf5uRxeUUuLw02hvzj7nJzc22WGauDT8AeZJ3nx0h9rwtObdcW7hRxy4cn/D0sLEFipqq2U6Nft3RLKPeRG3gn7YbPQeZGMVSWbcNIoTxA8aj/HvUZoG/u+CLjGj/cG1a4/Vucb0qjiEmtp9isNk2703BPlQ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Z3Zqd1orQzlubEtQbnlwUnhmc0ZEQk8wMU1kNERWaC94R0VIZ2srdkx6M1hi?=
 =?gb2312?B?SUtYS3Z3ZGJ0VjdmYlgzaEhIOEl0SERwNUNLUDNLMVVlT3IxN3JaM1pjeVhH?=
 =?gb2312?B?WmZKbU1iTTdmY2pDampzL0tKTVVITEUwQVhYc1BmSU9meVVHeWhzSktNQklU?=
 =?gb2312?B?ZU5zak1QYVBRRERuTm9FZ0IrK2V4amlxZHQ3amJKVzVqbW85WjN4cGtOYnJ4?=
 =?gb2312?B?WENpMkhJaXA3MWFRdFpqVXl2OGhZN3lUT2NrRndsVHlMeHpDb3VGRzRhQUhC?=
 =?gb2312?B?dVc0Z2FmSERvcXl3RDh6TnNiOTNycnNCQVpiZlV2R2RoclAraHZSa3VrSDRh?=
 =?gb2312?B?dXVXdkc3S3RhTlJ3NTkvSEJ0Y3dLZkZwc3hPWkpyUC8wZ1ZyK3FUSmR0ZGNB?=
 =?gb2312?B?bWxjSmJlSWhWVmxJZ2JocGxSVzlQZW5sYVZjKzNsMEZMSXpoYVNMckZXLzRN?=
 =?gb2312?B?VXAzOS9pcXozempLVGR3emErbnptcWhtdTFIYmkyRjVacnFPOXg4YXZCZmZ5?=
 =?gb2312?B?Y2pCaUdmSmRibFdWNHFkMzZpY3lsWDNacFRIcVRUTzdIV2tTb0pzM3BVLytP?=
 =?gb2312?B?UkxKNFB3ZVBEY1Jkd00xUlpSamhaRThDV2FySEtNVmxMVFNFV3pEY1ZYbHdo?=
 =?gb2312?B?aGUwUDRvRWJsRVpac2srWmYxOWh1Zk1EMDZTd1FuQVZYNy9pbnVDOVJBcm80?=
 =?gb2312?B?anhOWmptNzhOTmNIb3pnY3ZGYUd1bVpvbER1SnZsN2FJUWNnRUZ5SFFWR0Fu?=
 =?gb2312?B?ZHdLTldDem5FMWhNMzJtMmFUM3dtbm44WTdCV0h0ZjR4Z0VXcHR1SXpOSnRs?=
 =?gb2312?B?TkRmS1BqZWlMYkc4TDliejcrY2VFeEpyQXNJLy9BNzFRdnBpUDFRMVlMWWp4?=
 =?gb2312?B?QUFPdEJqbEF0MDM5NWdwbHdTcW1PM3ZYVzRSTXVMUU9xYUpRcnhlU2tjeFNZ?=
 =?gb2312?B?aWJvMkpWN1lNUGdkc2lSMGh3WVdLVEUyTFhDOU1JUzNHQ3NtalI2SnB1bitT?=
 =?gb2312?B?Skx3aVN3cEVxNGQvZXJrNHJuUGFwRUJBMXN2Q21abmxWb2pDMkJhdEZEZlNY?=
 =?gb2312?B?ZUVvKzhScWoxeTNISWdTVE9xTkxxcEI2UFNVbjUvNEVUTlI4a21KNTM0Wnl4?=
 =?gb2312?B?UE8yL000VHNlSFpyQVRKU1ZXVFM1Ukd1ekFDdUJydGFqbXN5bkFncTNDcUNY?=
 =?gb2312?B?TUJKSERqc0tLb1N0ajlSZDNnSjByczlyT1FoY1NxTVRjaUxqOHRCYkducjhO?=
 =?gb2312?B?V1EzVVFDczQ4UlljUjVMSkYxYmhJMFZZYVR3citoYkQxVi9yVEhLdmpNa0x1?=
 =?gb2312?B?Y0RCZ3JWWHJFZjY2bTEvNStSUnNpWWo0VHdoaEFXdlpTV1VRZWI5SVI1ZTk5?=
 =?gb2312?B?eHo5Q2MrYXcxWENHbkdqVUlFUUtYUkRFRXFEREZ0VDdzNWNjaEcrbnVjQnI1?=
 =?gb2312?B?am9pUGRBMFBhNkltMEVYTFg3VUVPM3dYZnVOeGlQWjN1TllVcHlQVzVINTFK?=
 =?gb2312?B?dUkzN2Q4RlEvOGpRUG4xNFYrVjJSZERZMTNIRFFHZU9XNVlFcGVoeTUvbU1P?=
 =?gb2312?B?a1hhbUxXOTJGRmczeUU2SzNRWEZKWGlFdFlFVkdvNmdTZWdad3VBQlJUdzdi?=
 =?gb2312?B?MlJZSXFJcllldnVja0dqRUtNakhIUlhDZWpVVVlUU1RmdGVBK0xPMkVCRUg3?=
 =?gb2312?B?QitGMktMZmt3eVlma1ZIbm1TVlhjcXlCamJFTHJvSjNMQmtLMFVBYy82SDZZ?=
 =?gb2312?B?djJMaElmS1NCTkM3d01OZ29HY0V4OFlyQ1N1MlppWDlSaVBSTEcvRDA4ODl5?=
 =?gb2312?B?ZnBsOXJ2QlE5S1BiMVZmOHJaekJZTWxWbVZUaXhVY0xwRlI2bGF6Yld3M2ZT?=
 =?gb2312?B?bm9XbEdaaHBOTGhwOUlPS1VRaWJqb2ZBNlhOTFBYVGt1MU92ZS9pWW83WGx6?=
 =?gb2312?B?QnRzUEMwYndGK090MmJ2Zm9CVGh6eEVhWjJ0MFVPQTcvaDg3QllvbGtYbkVi?=
 =?gb2312?B?dDRLZVNmcU93Z2haWjRWVlJUVTBQT25FaURyZ0hrUE5xKzR2Tm5hRHlHbWsv?=
 =?gb2312?B?V3VabzRPODFhWnhCaFc5UzNkNnd0c2ExQm93T01KalZWclpwVDFxblNxb0w5?=
 =?gb2312?Q?9WYc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f51e98-f0b8-4fc5-6fc5-08dc41b299d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 10:04:12.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /odk+9TdqumkSvzCgZdcHeFNEuM9qtcbX8p6QpftyVEM3W3wdzWALv7Prtnz6KWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyNMTqM9TCMTHI
1SAxODowMA0KPiBUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgSmFja3kgQmFpIDxwaW5n
LmJhaUBueHAuY29tPjsNCj4gbGdpcmR3b29kQGdtYWlsLmNvbTsgYnJvb25pZUBrZXJuZWwub3Jn
OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFp
bC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1
YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjIgMS8zXSByZWd1bGF0b3I6IGR0LWJpbmRpbmdzOiBw
Y2E5NDUwOiBhZGQNCj4gcGNhOTQ1MWEgc3VwcG9ydA0KPg0KPiBDYXV0aW9uOiBUaGlzIGlzIGFu
IGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3IN
Cj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdl
IHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBPbiAxMS8w
My8yMDI0IDA5OjQ3LCBKb3kgWm91IHdyb3RlOg0KPiA+IFVwZGF0ZSBwY2E5NDUwIGJpbmRpbmdz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+
IC0tLQ0KPg0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5kZXIgZHVyaW5nIHRoZSByZXZpZXcg
cHJvY2Vzcy4NCj4NCj4gSXQgbG9va3MgbGlrZSB5b3UgcmVjZWl2ZWQgYSB0YWcgYW5kIGZvcmdv
dCB0byBhZGQgaXQuDQpZZXMhIFRoYW5rcyB5b3VyIHJlbWluZGVyLiBXaWxsIGFkZCB0YWcgcmVj
ZWl2ZWQgaW4gbmV4dCBwYXRjaCB2ZXJzaW9uLg0KQlINCkpveSBab3UNCj4NCj4gSWYgeW91IGRv
IG5vdCBrbm93IHRoZSBwcm9jZXNzLCBoZXJlIGlzIGEgc2hvcnQgZXhwbGFuYXRpb246DQo+IFBs
ZWFzZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkvVGVzdGVkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5n
IG5ldyB2ZXJzaW9ucywNCj4gdW5kZXIgb3IgYWJvdmUgeW91ciBTaWduZWQtb2ZmLWJ5IHRhZy4g
VGFnIGlzICJyZWNlaXZlZCIsIHdoZW4gcHJvdmlkZWQgaW4gYQ0KPiBtZXNzYWdlIHJlcGxpZWQg
dG8geW91IG9uIHRoZSBtYWlsaW5nIGxpc3QuIFRvb2xzIGxpa2UgYjQgY2FuIGhlbHAgaGVyZS4N
Cj4gSG93ZXZlciwgdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBh
ZGQgdGhlIHRhZ3MuIFRoZQ0KPiB1cHN0cmVhbSBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3Ig
dGFncyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPg0KPiBodHRwczovL2Vs
aXhpci5iLw0KPiBvb3RsaW4uY29tJTJGbGludXglMkZ2Ni41LXJjMyUyRnNvdXJjZSUyRkRvY3Vt
ZW50YXRpb24lMkZwcm9jZXNzJQ0KPiAyRnN1Ym1pdHRpbmctcGF0Y2hlcy5yc3QlMjNMNTc3JmRh
dGE9MDUlN0MwMiU3Q2pveS56b3UlNDBueHAuY29tJQ0KPiA3QzY2NTZmMzlkNDFiYjQ2ZmJiZWIz
MDhkYzQxYjIwZjdjJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMNCj4gMzAxNjM1JTdDMCU3
QzAlN0M2Mzg0NTc0ODAyMTUyMzMzNDglN0NVbmtub3duJTdDVFdGcGJHWnNiDQo+IDNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
DQo+IDAlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPXAyRlFSbmVraDRzNDFVdUo0TXprSEFVTzJKcDBL
TjUlMkYNCj4gc3lQN1ElMkJBd01GcyUzRCZyZXNlcnZlZD0wDQo+DQo+IElmIGEgdGFnIHdhcyBu
b3QgYWRkZWQgb24gcHVycG9zZSwgcGxlYXNlIHN0YXRlIHdoeSBhbmQgd2hhdCBjaGFuZ2VkLg0K
Pg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

