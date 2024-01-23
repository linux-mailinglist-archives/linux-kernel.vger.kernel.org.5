Return-Path: <linux-kernel+bounces-35521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9EF839266
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED701F2658A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3BF5FDBC;
	Tue, 23 Jan 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qdTwOjKC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCD5FBA0;
	Tue, 23 Jan 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022967; cv=fail; b=BU7Ur8WJtBvjQE0qp6lFPBZT5J6PWWgUH/V8vlhBl0mThIkHi3+9APX/X2BZZeDkrPcccRoFxJ1ttkTTV6V/zG5FCmZa/V5zvmgAqFjOiBJmFKEGxONa/Mqwbm5030+VcxMGU41Oy8ABwvfA8LpwU8zuRr3B+3vSu/9CSGZrJ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022967; c=relaxed/simple;
	bh=e8TSTsjOw49b2QB5mVcjBmgcTwPa6ihAC01Ft0ixTwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdFo7ETKnFLh4Mnl/nyUaimD+kHZEZB9CRQn5V4Yt0FdZZUK59Y4Kj5ssdyMwUUFuRVvGDNyFKNTSLO6vpCy0Y/CyamzJrlv42ywQ0yYA5glpaamzuCReGUqZws6Czwpeor7WoPODr+NFPdc8F2I+uBBA9pf7l9ccG+r+yS5rVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qdTwOjKC; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fskwpMHURpRnpSveKanJC5shU2WFwsyKlIHiJHZONc6fletX4NpOit0A6KeaOb1pvAiBTSQXSwCVLMViAbMBTrVExoepaTBusDlhCV/mB1k6pKRddhUpCj9r89t7TrcUUFv8sXWa1e1JO5jALVACBQuKfaQWEgYpcoB3xIcNfEY5vge7UKNHWVNIR/cg0vqd7NXy0qcoFoBHKDkF7zhtWfAkvcXWTUA/xu2UMnGcFlHFx/XAtgRlwBM7WzOAixhaGHRKvN6HU6tS00Qmi4Lw87yKGY/1c3K82Clj0g6eOYNIkR9yY1c4ZKhl9LFkIQCxnO1Mag1Ja7kI9FVDFAz7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8TSTsjOw49b2QB5mVcjBmgcTwPa6ihAC01Ft0ixTwg=;
 b=XSTT6vcbLUUNX2j2jJzUTxs1QiuKUNWz4YzEewjYVTbGSNgWnGfLRM+7pR6CrWMJHKcy3R6FyiGoVYFWCRLvOnkLYjAui3pU+VftMPASBwENBchgjBdxcz7+WiFlPn1EHB/PK47rUwi9AaKPqiisZofCMIziM2dt5xeKaXWFNiq5bsTNLQIHA8Y1DlSMBTTpeiFDA12zH3oqiad6viRsTaGRyQkeTP9nO36uEhsJkxWKXJzfU9BSB92Y2+h9PBOK+DUZ9DvDrPEzRSGn+Ar0tcXzsl7KMjESRznw58fw79OH3aC8ijnGG57hY0wwKRBLVJPqIA/AebUWMexhQo+iQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8TSTsjOw49b2QB5mVcjBmgcTwPa6ihAC01Ft0ixTwg=;
 b=qdTwOjKCtNthm9ttUQzeHRE07JrmTcFgsOWKf/LXB+22DATB0+/BD3ZNtXGLwdhr/gXLDOLUV6wRFybtgU7kFMsTXTRmuczvmmOVnGFuR9JWB99JMZV1wDa4mH73NAUZImsvLqgfsEG+6ccUd+5XUGQEtHAM/d/l/P0P5BCLPJI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 15:16:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 15:16:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Thread-Topic: [PATCH v3 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Thread-Index: AQHaTglFCegNQe0KfEaElDd21RQDo7Dnf3EAgAACLXA=
Date: Tue, 23 Jan 2024 15:16:02 +0000
Message-ID:
 <DU0PR04MB9417C970935FCB14F92F1E3588742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
 <20240123-imx-mailbox-v3-1-ed932945e0bf@nxp.com>
 <96190db7-96c9-4d5b-b327-b75d09a3013a@linaro.org>
In-Reply-To: <96190db7-96c9-4d5b-b327-b75d09a3013a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB8018:EE_
x-ms-office365-filtering-correlation-id: b69d620a-662c-4e7f-dbda-08dc1c263652
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7V2R6wKE+XTdYTa7Wp2e2L6Mqo+1/66XPn8awcYDn5Whp4NNzJnUerEfV2Di0v5IIoDuRqocK9UE/Z76kk7Ym4ZO/zQNlTBJ/ZlGLcb0nrrMgaz5XHW2YFqOZTdjguUtEF9XcZak+t9ONWTz6/ARKx3dFKhRSheNU3v+I6BxoIU9DVugvqxWrQ4ITIImuB+TSCuqpF0zsKK3ePJx4F24EMJ/JpwSjWQWmaeVitdXVUXQppOqWEWYcpzegYFANI9Lv20tNoLQu+QVl74WXbeQc6ryUeCkLfeGMNf2pFGIlp+8XlwJ8Bjs17AHNiNatXDldnxxkmW4UhNHpSKMpw6bJW9cl/+/AHkwzcf/qBrq0gV3KeEq3n5iXZQ3Do9hHUy9O2OrPhyizz+WOjOnfUnLNMCPLagJHZBK9xnJDuJpCmX8bQ+uvaH2AKhG9ZczVTpLdUkOSaNRiIxBNThDJ7SsQYLlaVv5vtY1ijtKDlZgew88H0b274AfFQFGqB1xDpru38Jx8sQNn/9EVbUDspzhxPNp1rAZ7NkGfJEUHQvdHLIzzVNs9rp2r6D7gfdFvZSzJNnrmYpiFF+iBsne8pcRJIYfF5GsEqft46TRisOkcgCCfWM2zqB2uSgUpyY3n47K8ENY6LPAshp2LAWa7xq0rmNsKwCcItYAh+swuvfK89Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(6636002)(5660300002)(66946007)(66476007)(64756008)(76116006)(66446008)(54906003)(66556008)(110136005)(316002)(26005)(7696005)(6506007)(9686003)(53546011)(71200400001)(478600001)(52536014)(83380400001)(4326008)(44832011)(38070700009)(2906002)(86362001)(38100700002)(122000001)(41300700001)(15650500001)(8936002)(8676002)(33656002)(921011)(7416002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mlp6M00zZitBc1ErZ0RVOXNzTW05aTJYMUlaY2EzclNDN3FSaGY0T2hUQWdN?=
 =?utf-8?B?aFpyM29ia2VVVjcrRnhhcU5yYW1wYmZHVTJWSUIrbDdaTVRFQUpUazFLUVhI?=
 =?utf-8?B?cUZVWU5HaDBuclV0bFRoejcrWTF0V2tLWkJZaC9UNXNMSkVWdklKdzNHbWMw?=
 =?utf-8?B?SmhOV1NYWUREZFcrekIzVjYxRVBvclgxMnphb3BwZEp1aEtSUkhjcmZ2YlFL?=
 =?utf-8?B?aGswMGswekw2Tk42L0NVNVhjaWVDK1luNkFwdkV2WndBMzA3SW4zbUtWTUgx?=
 =?utf-8?B?QktIT1ducVM0akREVTZ1emtVWjJiSk9jdEZ0Zk9zTjdIR0NUOTd0c0wxQmh5?=
 =?utf-8?B?bVZKc0REVmF1LzdlUUVueUxkWkM5cmNZSm9YVU42dmR0QXo4VTU5ZUpTUXBv?=
 =?utf-8?B?QktTeHA2T2tGMHlneDg3RGg5RkhwanJBOXBiTjdpNjZzQXllTHNFVXZBOHF0?=
 =?utf-8?B?RDh2UCtwbzUrY3o2d2toSzVJMnBhWTJGSlE3OGljOGl3dEFEU2FSOVJuN1dO?=
 =?utf-8?B?VWtsVkdNK1h3bThuajRZeVEwTE5tSnVkb3FrVStNWVI3clJuN0xNVWJJRVBn?=
 =?utf-8?B?d2d2M0JNelNZNy9lTTFhVWJVdm5OWE5zeEhkdUZyZnp4YW45dnNpQUkxcWdS?=
 =?utf-8?B?c0VXUVZuR2paUkVKS294V0d1MW5hVm5BOUNYOWdLdlU1MW9SL1UyUXlBU0Ur?=
 =?utf-8?B?MDhhajhmYVB5NTV2Q25lYndvWTNPYm16cHBHYTZIWldlbzBxbzc4S3k2V1FQ?=
 =?utf-8?B?aURzZGZQVFRPaTY4ckhNZjdSZ29UYkgvek1sbnlVSHdURURxTXMxWmsybnRQ?=
 =?utf-8?B?eGpBM2N3NTBXdHhwRm15TWNTdjJ2VUZvQVF3cVBueWpvc3hreVpRRWRxUXY3?=
 =?utf-8?B?ZU93TS9KdCt3VzEybVVieTYxclBrNW5pVXFUUE96dFdzdEFadG1tQmhPYUhw?=
 =?utf-8?B?N0ZnTDlzaHBaMW8vLzFVeXZSTWhtMmpDTFhvaUlqY0w4REM0YkJUalRzUmFD?=
 =?utf-8?B?T0tKZXJjRXpWN2UxaW9velhhZlVSTUNGbHc0VHkzQUlOMFpDaWEwSlY0VjRa?=
 =?utf-8?B?NGNUeTRHYmsrSnZScFRSdUFTNHFSWjdjblczekFBaVF3TWdMLy9kTXNBYzly?=
 =?utf-8?B?N3ZoZDhqZEFyUHRJalNQRnZ1R2hRN0RhSCt2NmhheWtHT1d2Q2puelNXK3Rh?=
 =?utf-8?B?SjZPemRIamg0dnhmdVQvdFY4YnZOZVd3aW9NTUU2dE83V0NCTlRoZFVwWDB3?=
 =?utf-8?B?Q2lXbDE0QUxMNzFnMERuc043SWsyQ2thY2xaaExCQ05lVCs2bFFKUWVPS1hU?=
 =?utf-8?B?VmtzV0J6MWhXc0FKWjE2OVBLRWYrRXBsa0FwV2ZJNTZ4VzJ3MmhTWi9RVmRn?=
 =?utf-8?B?NUNHa0VHT09aQ1BhUzYwdW1RVGJDOWhHV3F1K1lXZDE4a0FwY0FZa1FJU1Z5?=
 =?utf-8?B?RmpkbkgrbjhDck9iR3dVd3pnY2F4Z3hUdERrcFRZVWIzNDhOSjhWRG42cUh4?=
 =?utf-8?B?eEY2SWtXYktwMWMzc2J2aERnQU85RGU5dEtRK1pBSEl3NlpMTzVXanVENE9N?=
 =?utf-8?B?bStuZ0VnYnY5anNhNFFLdlIrZDRsaWhMcDFldzdpaVUzSUFOSmp0bHFzdi91?=
 =?utf-8?B?RWd5UkEzYURrYUZQM0dvL2c5a3B2NGFwTEVFZ0wwUmxSQXFYTEtyZzFIQ3Q5?=
 =?utf-8?B?Y3F0MThmd2NiQUczK2lqc2pUWFR0akNlL3dnUVcySnhYRXByemNsUU5wb2dh?=
 =?utf-8?B?M2FpVkdGQy9mdWkxSy8zR1orY0V6cCtDWXBLV3Vydng3UC9aa0pUUGNMdHcz?=
 =?utf-8?B?RWVFRXdGOGtTdEhMZTQxeUQ5M05oZVo3ci84bC9SUWlvOUZuUUpzOFJpRUZ5?=
 =?utf-8?B?eURBUTl1ZFpYd2tOVTA3WG04MVM1cktmYTQrWnZ2MmlEUStiMDBFL3ozL09n?=
 =?utf-8?B?c0hab1M1ampUQ2Z4bFVIWFlEKzBBYUxjWUt1UVMzSXdJODlzcHJqREd2VHRV?=
 =?utf-8?B?eDkrcUYzQ2huSmRYczk3dXdZZktkZW8vbDZZNlBQV05haXdHOWRGeDZKeXhD?=
 =?utf-8?B?eUJVOFl2TlFMSVR1WDdaZVllL3F3eHk1MGt1RCsvMHoxWXROSTRsOVhWeC9U?=
 =?utf-8?Q?h+MQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b69d620a-662c-4e7f-dbda-08dc1c263652
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 15:16:02.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zp8WqmCVSB4OMqJ7dy6SMV0y9XDkEWxFz168iiFTuGE8Eg56b2MAJuXpcfD0+B6/yBtQ19DEHEXSdP0k8ydoQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0gZHQtYmluZGluZ3M6IG1haWxib3g6IGZzbCxt
dTogYWRkIGkuTVg5NQ0KPiBHZW5lcmljL0VMRS9WMlggTVUgY29tcGF0aWJsZQ0KPiANCj4gT24g
MjMvMDEvMjAyNCAxNTozOCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgaS5NWDk1IEdlbmVyaWMsIFNlY3Vy
ZSBFbmNsYXZlIGFuZCBWMlggTWVzc2FnZSBVbml0IGNvbXBhdGlibGUNCj4gc3RyaW5nLg0KPiA+
IEFuZCBzb21lIE1VcyBoYXMgaW50ZXJuYWwgUkFNcyBmb3IgU0NNSSBzaGFyZWQgYnVmZmVyIHVz
YWdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvZnNsLG11Lnlh
bWwgICAgICAgIHwgNTANCj4gKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9mc2wsbXUueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvZnNsLG11
LnlhbWwNCj4gPiBpbmRleCAxMmU3YTdkNTM2YTMuLjU2OWZhYmM1Mjg1YyAxMDA2NDQNCj4gPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9mc2wsbXUueWFt
bA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2Zz
bCxtdS55YW1sDQo+ID4gQEAgLTI5LDEwICsyOSwxNCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAg
ICAtIGNvbnN0OiBmc2wsaW14OHVscC1tdQ0KPiA+ICAgICAgICAtIGNvbnN0OiBmc2wsaW14OC1t
dS1zY3UNCj4gPiAgICAgICAgLSBjb25zdDogZnNsLGlteDgtbXUtc2Vjbw0KPiA+IC0gICAgICAt
IGNvbnN0OiBmc2wsaW14OTMtbXUtczQNCj4gPiAgICAgICAgLSBjb25zdDogZnNsLGlteDh1bHAt
bXUtczQNCj4gPiArICAgICAgLSBjb25zdDogZnNsLGlteDkzLW11LXM0DQo+ID4gKyAgICAgIC0g
Y29uc3Q6IGZzbCxpbXg5NS1tdS1lbGUNCj4gPiArICAgICAgLSBjb25zdDogZnNsLGlteDk1LW11
LXYyeA0KPiA+ICAgICAgICAtIGl0ZW1zOg0KPiA+IC0gICAgICAgICAgLSBjb25zdDogZnNsLGlt
eDkzLW11DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBmc2ws
aW14OTMtbXUNCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg5NS1tdQ0KPiA+ICAgICAgICAg
ICAgLSBjb25zdDogZnNsLGlteDh1bHAtbXUNCj4gPiAgICAgICAgLSBpdGVtczoNCj4gPiAgICAg
ICAgICAgIC0gZW51bToNCj4gPiBAQCAtOTUsNiArOTksMTcgQEAgcHJvcGVydGllczoNCj4gPiAg
ICBwb3dlci1kb21haW5zOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICsgIHJhbmdl
czogdHJ1ZQ0KPiA+ICsNCj4gPiArICAiI2FkZHJlc3MtY2VsbHMiOiB0cnVlDQo+ID4gKw0KPiA+
ICsgICIjc2l6ZS1jZWxscyI6IHRydWUNCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0K
PiA+ICsgICJec3JhbUBbYS16MC05XSsiOg0KPiANCj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWlu
ZGVyIGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MuDQo+IA0KDQpPaCwgc29ycnksIEkgb3Zlcmxv
b2tlZCB0aGlzLiBXaWxsIHNlbmQgb3V0IHY0IGxhdGVyLCB3YWl0aW5nDQp0byBzZWUgd2hldGhl
ciBTYXNjaGEgaGFzIGNvbW1lbnRzIG9uIHRoZSBkcml2ZXIgcGFydC4NCg0KVGhhbmtzLA0KUGVu
Zy4NCg0KPiBJdCBzZWVtcyBteSBvciBvdFNoZXIgcmV2aWV3ZXIncyBwcmV2aW91cyBjb21tZW50
cyB3ZXJlIG5vdCBmdWxseSBhZGRyZXNzZWQuDQo+IE1heWJlIHRoZSBmZWVkYmFjayBnb3QgbG9z
dCBiZXR3ZWVuIHRoZSBxdW90ZXMsIG1heWJlIHlvdSBqdXN0IGZvcmdvdCB0bw0KPiBhcHBseSBp
dC4gUGxlYXNlIGdvIGJhY2sgdG8gdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gYW5kIGVpdGhlciBp
bXBsZW1lbnQgYWxsDQo+IHJlcXVlc3RlZCBjaGFuZ2VzIG9yIGtlZXAgZGlzY3Vzc2luZyB0aGVt
Lg0KPiANCj4gVGhhbmsgeW91Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

