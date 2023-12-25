Return-Path: <linux-kernel+bounces-10879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4DA81DDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0051F214F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D8ED3;
	Mon, 25 Dec 2023 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="epAMNV5b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A7806;
	Mon, 25 Dec 2023 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzeeFpq5bTmVrtZV9KAvhzQzfD+ZF9rd+9NpNUcsfS8QixBjvSnMgw2R6U47y+ickXCNp1+0kzqEftvF0Ux0QMKWkRc9utr79gqVQLVWEH2p8W82hxBKOPSWvadUme/hCUs/L1wkw1EjHdoqtPaifAEjxqLnUU/9QTHZuzo4AT654YxEqYJrIE6zcDftsAXQN/JyuDv6kUjj79NGX0GXI7Htf/2Ww2xWJJ6zR4pQ7APMGdzYdWDHY2lJvpg19xfnO3Qh7eERyrJrEU6Lj18hxGl8+gobhF6zstuqc/r4BkmcaNTKY9i3tzV/0lnGoopMIegbiP59j02kXJb6/QmN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAYiLoS3yhsdU2ysDjxMtqHhU2Wef2hx2TnF/ofM1Q8=;
 b=JL+dxkXybCIERVn5w1kVEogNKaeLzMXRDUhrPPqz2pdFy/4vwHUmZPHnz90dKVsGMiBrvKa83aIQXtgR44YVYzSMCmpst7Hwd7s+iqzYnfaLJqkFNloWfvM3S3xulqJeOHRFvDcL1swRrlhlqunJPPhpjDIw7jszSNglmyjgTHvL2/iT5HoKhELbB0btVgF/FNZq53oAtXD62OS9lsD4U8cppMH/6R6f3hXlg4FNToFljeae+1egLs8KsJ3nSWf9YUTDY3pFrmZxmlwFu7mFWA2tiPqxPNM+DCV1Wh+iiS17LPS1RuVk5ZZsEhfSL0wQ/XBp84MBAD+c9KCQV7CXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAYiLoS3yhsdU2ysDjxMtqHhU2Wef2hx2TnF/ofM1Q8=;
 b=epAMNV5bt/5kMR7l1LUeImt3yyunU326AwFnUQIXhD5JyqILOzfa68YKcfWOTHPck0QTdJ02xV9MGzuW8JPsDVrv9j3ep07KD0HfSh/O3MOrKB4HI4yc0dsgVXxOeA2Gxi6Zx1cAbQgdT4SSv7FvZeGMYXUenyVVk+VbLT6aGeI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7208.eurprd04.prod.outlook.com (2603:10a6:10:1a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 03:17:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 03:17:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>, Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Michael Turquette
	<mturquette@baylibre.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
	<shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [PATCH 1/2] clk: imx: composite-8m: Less function calls in
 __imx8m_clk_hw_composite() after error detection
Thread-Topic: [PATCH 1/2] clk: imx: composite-8m: Less function calls in
 __imx8m_clk_hw_composite() after error detection
Thread-Index: AQHaNPTyfQAKUjgu9kuUiIRTgeUbsLC5V7lg
Date: Mon, 25 Dec 2023 03:17:27 +0000
Message-ID:
 <DU0PR04MB941778B838752475D39E562F8899A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
 <147ca1e6-69f3-4586-b5b3-b69f9574a862@web.de>
In-Reply-To: <147ca1e6-69f3-4586-b5b3-b69f9574a862@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7208:EE_
x-ms-office365-filtering-correlation-id: 9bebf8ec-1ba2-4df7-4bb7-08dc04f805d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yWJv7fvxc8FbBudEuIlstcYTZt3HvnBNHUgWxEfoAPLqJFnKCwhkHoFplyu2OpgGx+oVn/AX29SlmLLfb3mz8ySE4fDgjCWQ2Mx5fhTgqzIKRZWQ3exZFjAI+QzvC1k8bayQlUqWAlBPREvox/XbyB5u2fwOJ51eVb1wHC8CHgSQ4hYdKksyvYfNK8jF9rsVvlmfZHUD7+bnhTxnw/mUWD1EpeN9zxBeNciPB41d6QbTYM44oxmzwc+m6kRQLIDqcBckp34HjLFOWDqFWuusNAKsaiveWKX+l5MdeEhK7Sq9Yu+Q9wEyWnMONr3JH8NDfRm0LFhfnIvXNw1+JNtXfpEteezZJTdgUtOSVKuqVUwcLgynrHLRaqu9PGS24Qs0HMMKGyr3tnu6WE0Qmk0Zdlhe11njKNiApQexoJHxM3CK9XffX8RC5UXWJD0XqulfiJp+0XD/jBXgzdOwq9wSiYTCpkbdDEfbsJomC1UPBlKp0BLOmM1oXXk6NXlHAp7dtmsL1A5kX4zrQK73n+Pvsc46cdVSSnVM4nT6B3uBlM4EXsDtSbizt7yBti5ACTq+ab40e4NmmtRJycPfmSbCJymrXQ9he9AlkKVPvKdZ461dwEzoMBZ8vv1D4XJSDetsKSqQl0s+H3cqsINRXm+RCQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(71200400001)(4744005)(478600001)(2906002)(8676002)(8936002)(122000001)(5660300002)(44832011)(7416002)(7696005)(6506007)(9686003)(66446008)(64756008)(66476007)(66556008)(66946007)(55016003)(921011)(38070700009)(110136005)(4326008)(54906003)(316002)(76116006)(52536014)(33656002)(83380400001)(86362001)(26005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEd5ZW1TVXQ5RHdjS2taTkRkbHBuZHlkSThJRUFTZ3VUSWU5NWhvOW9RRFJM?=
 =?utf-8?B?U25laWNtWWZGbWxVMmdzV29WVVNEdHdqNnlHVXh5ak1RMjRCbXYzdytXOUd1?=
 =?utf-8?B?NGRuZWpPVzI4NjlIQUVuU2RSWkN1QkIwVWxtT0E3Mk1Ib0Q5Y0VrLzJscVZz?=
 =?utf-8?B?R1VvbGRBeUpGNjFFeVpIMDREVzdFOTlQMkJJcDBIY090djUxNDkydjdSWEJR?=
 =?utf-8?B?SXZlTkwxNk04OE5mZGhUWWE3ZGNJbHlNVnBId1BHb3ROYlZ4elpOQU1vNFdn?=
 =?utf-8?B?Wm1FcDFjMkFuaTVQeDhaY0pieldsbUdQc21naEUrUUtuQzVPUDN6WTBBVjRI?=
 =?utf-8?B?ZGJ2NGRYUFBCZEJ5N2RoRnRrVkVrcDFVN1ZvL0xpa1krWFZsNmxhTUIwa254?=
 =?utf-8?B?SVpOQlZtTDdMRlh4aUZnYVQyaVFQc0o5dFhIaXVmT3pqK2lERDVPOXdIYlB0?=
 =?utf-8?B?NjUwMFZGYitZRHBIVTEvQ1QrQW81RFJLb1hsMG1zb2lBQTNxNTVnOTdiYmk1?=
 =?utf-8?B?ekdzbUNramsweFZJSFFpcFdJSEFsc3hpbXhkdW9qdGQ0enZaNFo0QTZHVUVi?=
 =?utf-8?B?c3dvTGtYc1RVcndnUStiK2VCNFpLa1Eyc0FYVWVmMHphdmM3bGp5Qm1yeU9p?=
 =?utf-8?B?Qkh1YlNFY1JtVzVhRDlqVExNUUdmU1VneVBVYzVyVWd3VkFoN0VmNjExT01B?=
 =?utf-8?B?S0VJMmJ0eFUxU0tvZnkvNElueUhrNFhJcG5sdEJyUEpQdGk3MXExZUIzTyt6?=
 =?utf-8?B?Sy9MZ3RrYmdCT296bmtJTnRhNGdyaHV0Yk9YejFUNTRHOFRWMUpGSVN6MDR5?=
 =?utf-8?B?MFlZSzNIdzlSOEN5TXFHeXFXZGt2Zno2ZFFhU3RTWmtxcSt5empVMFdrQUJL?=
 =?utf-8?B?bHk0RTJKVUUzYnkyWnppSWg5N0xyczlxeHJGZC8yeHppT1JETVhNaW1pMU5o?=
 =?utf-8?B?YUpTZ0x6aWRhYU9GdEt5OFpmMzI4T3IvcUpXR3J3QzRHQVZ5SkczT1NzTTgy?=
 =?utf-8?B?WkdsNDJSdWo5Q3VyYmJmd3ZyM0pSbStBWG9qWVUwdXNrekhmWDlpTXg4Mjhy?=
 =?utf-8?B?NHluYnpLUFFnSUFheG1Pak1CVy91S0pMRWxsczRzTzdCSlcwY09HTW0rVnc5?=
 =?utf-8?B?blAxYUxtUFpOZ3NmWmg0V3BLSFBBUENLOTkrcmR2ZXcyd2NKNzVQQXNQWHA2?=
 =?utf-8?B?Z0xlTEI2a2hweXprTjBJQVlmRExpUklTR2p3UFJqRmZPVTNpelJNQnpmVlBR?=
 =?utf-8?B?OVQ0ZGtWUWFiNzBFc1F2NHMranRUNk8xSlJDOFBZYS90QVo3Z3B5dS9naTNW?=
 =?utf-8?B?KzVXR1U1TW9GUkdjS29YdUFNNXVTUU0wSzFFUUp6dWZMczBhaTRRNDd2R1ZQ?=
 =?utf-8?B?bGREMEQ4S3o5dkFCVlErMENYWkk1SUxaT3dLMGtQRDF4ejhud2tnaEo4b0lS?=
 =?utf-8?B?S1pjMWpNYlFnb1lQeDNEWVVQWDFqUVhCVERxL2RwcVU1RnBJeEVOVnJlM0k4?=
 =?utf-8?B?azhZV1pSTUh6cTVNKzJYNlUzVzZ0NHk0TUtWbmpIRVBudzNaem81b0QvbkZ0?=
 =?utf-8?B?K1pRbFNYRmg5WmZqTWxKK0lEYWJKL0VOTktUd0hSMVVLU1dVR0I1NUJrWWFx?=
 =?utf-8?B?M3RXcXF6ZytQYk8rZ25sTEg4T0ZJWVZySzlLWFRYR0dyTU1rckV0WXpNOHZo?=
 =?utf-8?B?QytNTVNibzM5aVR0R0RydHE5MTR6a2t5UnAwc29kU2FnRjhoYXNRQ1psZCtp?=
 =?utf-8?B?c1gxS1B6WFhBWCtqM3ZuQ3RxSlZGRFQwWGRNckRtRkUzdFA5cGhlWDQzZGhS?=
 =?utf-8?B?UW5ZTittazNvSzBxM1J2Qk9CY0FjYTBxcy92c0ljRUtKM21pYVMxNm52WVhp?=
 =?utf-8?B?ZmlRMFhxMWlua0VFMVA5dExsQWZydmh2TXZLSnRuK1RwaXFlb1BvVjNLSzh6?=
 =?utf-8?B?TnArQm1YdFVBUVdMc1hvcTREVXZkbjA2Y2h3Ti82NUdxZ1pOK3ZHcHU2czFF?=
 =?utf-8?B?RVA1bUpxR1JHWTArOEdWajhXenpZbzUrNTNISkRHN1NLNWZKZ1FtVnArbHFM?=
 =?utf-8?B?RHB1RUFlaFJLaitKcEx1U21WeGUzMEVTVllCZDBiVkM4UGN6OWhReWExWUQ2?=
 =?utf-8?Q?TxDc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bebf8ec-1ba2-4df7-4bb7-08dc04f805d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 03:17:27.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGKXEh9u3EVEAGOWY6Sdtyuq1KT0EU1ycSJK8fPXePirxCyTSewli85dyYAv2Q4lSZ3GYcNnZe/VN8rnEd6qRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7208

PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBjbGs6IGlteDogY29tcG9zaXRlLThtOiBMZXNzIGZ1bmN0
aW9uIGNhbGxzIGluDQo+IF9faW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgpIGFmdGVyIGVycm9yIGRl
dGVjdGlvbg0KPiANCj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNl
Zm9yZ2UubmV0Pg0KPiBEYXRlOiBGcmksIDIyIERlYyAyMDIzIDE2OjQ4OjI0ICswMTAwDQo+IA0K
PiBUaGUgZnVuY3Rpb24g4oCca2ZyZWXigJ0gd2FzIGNhbGxlZCBpbiB1cCB0byB0aHJlZSBjYXNl
cyBieSB0aGUgZnVuY3Rpb24NCj4g4oCcX19pbXg4bV9jbGtfaHdfY29tcG9zaXRl4oCdIGR1cmlu
ZyBlcnJvciBoYW5kbGluZyBldmVuIGlmIHRoZSBwYXNzZWQNCj4gdmFyaWFibGVzIGNvbnRhaW5l
ZCBhIG51bGwgcG9pbnRlci4NCj4gDQo+IEFkanVzdCBqdW1wIHRhcmdldHMgYWNjb3JkaW5nIHRv
IHRoZSBMaW51eCBjb2Rpbmcgc3R5bGUgY29udmVudGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCg0KUmV2aWV3
ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K

