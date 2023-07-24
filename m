Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0775EBF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGXGvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGXGvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:51:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF4E71;
        Sun, 23 Jul 2023 23:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnnBeQwTRTW295MAvwOww9gsQU+cWOCcFOgUvx8ARVMu6tDtjg0juw/V2pfA0uQ1dGzXmwXWu2ryQLrRYQ/vQZe3GnnEpcYZlxxfvu3hrw82cO3lGo/S4S+W0SFBhSRVfckGBUUOvBEQnKTY/Pid8m6eb2+GTDs492Dnv9P0cp0Os3Ea8Wnq9WjBFRjbeu8XBHt2Og31b4PnJG82ZXv+ZEpUK/S/Hp3Tq2Rnc7Lw6ruAMTKQ3ozmVb8//pwqClyGwFomrjt5iw/z/VrfoNhvZTsG+odxeR0jmi54RwcCeB5zD9amZeilrNFmw72rXuVjuLORNN9zeYxscw7bYH9n8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACEg1d08OWkfeedH1hb5tbCNXrqQflo0C8KfqnbAIZs=;
 b=BfOZJwjub92Nw+fBe/gMzBdUnnoMKpZoBd+8hqEEHXDPTT9Aov2DWnjn8dLkUPi4AkTblzuCCQkSldqwOYIdavPxlUUsrbUPurbmG5buzZfNyVMgG7DwLjs64kwBT9dAi6IJdXPI8hdSDz15s/u1CXxqibL6+wSeXjjP/U2UoOT/d5rD0Met0PhhoIaEevywwPs6Uv60eeuV4L4NNS6+Jvx4pHMHXRQecGH47utNky/innK++6bMVb8AWi0Lyw34s/NibCoRiw4iueFILKLu2kdo8g+c/8jP8MpTl8G8lBbeQ2qmurKP7Q1mlT2Yph9rTTJDvDZb7bHAhikre/8mGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACEg1d08OWkfeedH1hb5tbCNXrqQflo0C8KfqnbAIZs=;
 b=QI/FlxhLz/0OvRJzWdn987aJiNnjz3woozefuM25L8HR1sQJQstYm/gmcbLr3TyP/NbUK1DHd+xWQPVi/jtfG/Fye+vsVK8q7jN5/uSwcqF0LyVEP+FXoXS+jlmH7oWW2zoKA4tTj0skNkyW3Uca91xmw5Y+fV7uJ7Adxf0nVR0=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:51:17 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::eed7:c7b3:28b0:451a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::eed7:c7b3:28b0:451a%2]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 06:51:17 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl
 setting for eMMC
Thread-Topic: [PATCH 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl
 setting for eMMC
Thread-Index: AQHZp2HuhtCiIO94gEONo69ZQ/26Aq+/Ai6AgAmk/vA=
Date:   Mon, 24 Jul 2023 06:51:17 +0000
Message-ID: <DB7PR04MB4010E151615277AB6BD3E4CD9002A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
 <20230625124238.4071717-10-peng.fan@oss.nxp.com>
 <20230718033227.GE9559@dragon>
In-Reply-To: <20230718033227.GE9559@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PA4PR04MB9343:EE_
x-ms-office365-filtering-correlation-id: 0731303e-eb94-4ae6-17f7-08db8c12617e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91bwugCO+Hn50cCeC3C0jKPMyusjNYSzOVVqeEmoeDkIOMz9Sfv9rDTjW02eX6D4gE1xQllDesjCqfPtvyKDEcn+Nho2woKLbSEKyI8s8lxJ7MtjRop6VcCmTvEWNGrKlsnMzZzpKVvOXGNSTR5HkLTmGLdKUINr4NDKQ3NAS9DEJgjvJPK58vV2qDfiM0724OFmSZBjG57MUrPDRNd9UwxFi00qJEyYjQ3g52FAujF2pIdxdLGQrZwityYkP6Yd4TJnUHWy/cA/eceab8Z/SniGeff/ULjYdkN5Vn9tlxB3FHwdDhZa5MNO0KHnyELYtdZNXW9teKoTnPIsEoBk/jCF+kDJ16+YQU4p2eBfvLZdI1i3c0nE700gC3z7mStPx1YKvdlh2QScAMsedoq5DQuNeKUwAHQwvD+Zvlt9yqPLWqYA1KYG+ulgIDRaicwKmwSejMueBWb10qsC9rVeI059I616dpUWEIYiOPTZC8Z0GfG/BJ4ddpDg6tJ80iMj7hpxDUW+EhQn3hNjgTzJt8+ZP1KSAm1XijlNYELJCpW/Nb7a8QudOyOOas/t/17bwoHT9V8Y5uGsVoCustWUSJNSFJ842ZJh20/KKdPH151zrtO7xtuiOogDbgEluoln6WyL9AIuOh+JTu7rW9h78g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(7696005)(9686003)(71200400001)(478600001)(110136005)(54906003)(186003)(53546011)(6506007)(26005)(2906002)(76116006)(41300700001)(64756008)(66446008)(4326008)(66556008)(52536014)(316002)(5660300002)(8676002)(8936002)(66476007)(66946007)(38100700002)(122000001)(33656002)(38070700005)(86362001)(83380400001)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TExTTGJ6TjVPMWN6NXIzdmZ6OTRxNFhhbE1aVG55OFV5MFk4QUZXNVEwWUxY?=
 =?gb2312?B?eitHZVJSNVRqS1kwYXZYOWU0OE9rSW9zR2xZSkR6aXkxR0g1bEU4TnlONHJE?=
 =?gb2312?B?MWxLd1Iva3I3NnhoUnRHQ1B2WDQxSjAxUWpSSm5LY013ZkE0d3BVTElUMG43?=
 =?gb2312?B?YUFFeUsvK2wzWlVFMHFrVXc2OU42NXpGTDg3ZnovMWpLQVphRDVleHhaRmdl?=
 =?gb2312?B?UWpXRFZVTnRxY0Q5K3pRNk5hd1dRTlBnVkt3T2RLSmo0cTBhaXZwYW5RL21o?=
 =?gb2312?B?Qmp0L3BjbTFtS0sxOEJGa3ovbkVDSXdCMHd3UnVGOTN0K2ZIaWM4MjE2cWVk?=
 =?gb2312?B?QjZYeFcrVk8wT1FVSFRGcTJoa0RLOFVRTkxKUEZ0eHIvTGFsbE5vRU9MZFdV?=
 =?gb2312?B?VWUxNWRNUXFHVnVSeGRybkJPb1JhUXJXRmdUWXlHQVFXa3JQMEVKdHB1UjFG?=
 =?gb2312?B?YjdsTXFvZzVtVjRxMUZVV2UyREkzMzZCdkVzNDRCUS9MVUkvbVVCeVNpWm9Q?=
 =?gb2312?B?NWMwWURNY2dXcWpyOS9JRnRWeml6dXRmSHpTVmh0VWsrSVh3TWk0NUowUjNa?=
 =?gb2312?B?aFNJcytmcTdtS1QyQWdISFgvL21WYkxGUkV4VytFRzZKc3dlK1A4ZE5Cc3Bw?=
 =?gb2312?B?enVtRjFndnZhWWUyK05FNWNJRmNSWldYbHRPUFlJOW1pTXJoMUxiTXduanFH?=
 =?gb2312?B?bDhvcWJMd3ppbUd4bjVNTjdtVFd3cU1MQXFpeEV5OGVoOU5nYndXOTVQMjda?=
 =?gb2312?B?Mkd3M2hSZlY4bGIzcWVBODgvNldwb3B1aGVKWW4rbEovK29KT1NDZmRBUkxD?=
 =?gb2312?B?aXVSajBnOXh3d1hXNWhSd3VMWllXZzV6emZheWZXeXY5NFlmdURHMG0zSTYw?=
 =?gb2312?B?V2VNdk5rbzhWUnNhYTZDeVlVYVduRVFzbmR4dm5NdnFWSmxEenRmcGRVSlUr?=
 =?gb2312?B?VFpYSGdTK2VuMUdYZzhGZnRiNyt5djhxTmNxcFRLNy81UUJYbDVjNVh2R0NK?=
 =?gb2312?B?U2JOaW1OdzdsdjNQcHpSSFNMRjQzM1haOXE5VUI0cWRlOTJicEVaaHp3T0Mx?=
 =?gb2312?B?UXlWWXIvc3EzSXlOTUJSTnhJSE9PZEFiVUlVS2hjaGpqTHI2UXY5ZzZrbU9L?=
 =?gb2312?B?YWh2alRPTzl6cUJUekNGc1liN2thcnV6Qk14MXVZM09vc2VmYkZ3WmFZVERH?=
 =?gb2312?B?Rld1VnBTNVFOZyszZ1dUd1lOM0hteDdmUGdQdXNKOWU2T05XMnBIYVhrWmNq?=
 =?gb2312?B?WWd0cnBhOXdQdGE5aWxkSHJ2Tzhsa0Job2ZIVHBJK3U5TlgwWXVHMU5laUdN?=
 =?gb2312?B?UGtpN291eUdxTDcrRGRQQlUybXBMYndaUHBHKy9XdSsxQUFtQXFuTS9qUEhJ?=
 =?gb2312?B?cE5LWVlZQk9SSHVLZWFabW5EZkZWMVZiTVV3MGJNdUo3bHlaRTR5YkRSbFFK?=
 =?gb2312?B?OHczNlV0b1dOQ0JML0RzK0tXcWg2emdEQUoxcWovMkVqdjV2WEtYeWNkNk5J?=
 =?gb2312?B?TGpYN0FiTVI1UE85ZXQvZzFwOGZhbG4xUGpFNEhOWE9MZ2xvTGVhVnEvKzNq?=
 =?gb2312?B?QVJCdmNSQ1dRNGlYd3JSYjd1eFF2emJjSk54aDdMQU84ZFJCd0NnbGxGWDYr?=
 =?gb2312?B?WnR5Y0tlVEpqUjFqQTVFZkNCQUVrdGVOYURKNU00amtlbVk2Zm11ak94ZFor?=
 =?gb2312?B?OW85K1VqcWVkbU8zTlE0dEx0cEZsV0diUmI5MWZTcW04VGhzK0o4eFoyMnE3?=
 =?gb2312?B?VUx5cjJLdkp2YlJwaExqdUQ1NzhCdEp4WHdCYnVBc0ZVYTZRNFpjRWJ2TzJh?=
 =?gb2312?B?Vmg5aW5ZOUJIVkhaWkZnZ3BiUzl3TzdYamg0QW83U0hkWkM5R0g4aVd1Wmho?=
 =?gb2312?B?a1NMTmtSdENyeCt4Tkwrd0dKZ2E1N3N6c0VLTmo3ZlphNUlvakdjQ0FsQ1E3?=
 =?gb2312?B?U0FlVUxFN1ExR0JPaFdFbG1uWkJ5aG8rNjNGR0xjYjg3dVFmeWNUTEhHUFlz?=
 =?gb2312?B?RUMydHFWeS80MWZjdVVGOWtDN0wxZFNxMG1ra2FOSms5L0xoSW9jaUxWbndo?=
 =?gb2312?B?UEZXQXE2Snk2OFhMbTJQNUE2aSt2UG9xOHB4eDd5bWVLREwweDJhaXhRT25a?=
 =?gb2312?Q?QjWk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0731303e-eb94-4ae6-17f7-08db8c12617e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:51:17.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwVGTxFSKxUgAr3BBtNUrkDaQ5J6uZ0QDgdzJV6sDtYGlRxvPDotW2H/kpQXKPJjVEgc9oftRX/Z/ODtdr2wQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjPE6jfUwjE4yNUgMTE6MzINCj4gVG86IFBlbmcgRmFu
IChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IEJvdWdoDQo+IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IFNoZXJyeSBT
dW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDA5LzEwXSBhcm02NDogZHRzOiBpbXg4dWxwLWV2azogYWRk
IDEwME1Iei8yMDBNSHoNCj4gcGluY3RybCBzZXR0aW5nIGZvciBlTU1DDQo+IA0KPiBPbiBTdW4s
IEp1biAyNSwgMjAyMyBhdCAwODo0MjozN1BNICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToN
Cj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBBZGQg
MTAwTUh6IGFuZCAyMDBNSHogcGluY3RybCBzZXR0aW5nIGZvciBlTU1DLCBhbmQgZW5hYmxlIDgg
Yml0IGJ1cw0KPiA+IG1vZGUgdG8gY29uZmlnIHRoZSBlTU1DIHdvcmsgYXQgSFM0MDBFUyBtb2Rl
Lg0KPiA+DQo+ID4gQWxzbyB1cGRhdGUgdG8gdXNlIFN0YW5kYXJkIERyaXZlIFN0cmVuZ3RoIGZv
ciBVU0RIQyBwYWQgdG8gZ2V0IGENCj4gPiBiZXR0ZXIgc2lnbmFsIHF1YWxpdHkgcGVyIEhhcmR3
YXJlIHRlYW0gc3VnZ2VzdHMuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogU2hlcnJ5IFN1biA8c2hl
cnJ5LnN1bkBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHVscC1l
dmsuZHRzIHwgMjYNCj4gPiArKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4dWxwLWV2ay5kdHMNCj4gPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAtZXZrLmR0cw0KPiA+IGluZGV4IGU0
NTlkYzM1ZTQ2OS4uYWI3YWY3MDViYmNhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDh1bHAtZXZrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDh1bHAtZXZrLmR0cw0KPiA+IEBAIC0xMjEsOSArMTIxLDExIEBA
ICZscHVhcnQ1IHsNCj4gPiAgfTsNCj4gPg0KPiA+ICAmdXNkaGMwIHsNCj4gPiAtCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiLCAic3RhdGVfMTAwbWh6IiwgInN0YXRlXzIwMG1oeiIsICJzbGVlcCI7DQo+ID4gIAlwaW5j
dHJsLTAgPSA8JnBpbmN0cmxfdXNkaGMwPjsNCj4gPiAgCXBpbmN0cmwtMSA9IDwmcGluY3RybF91
c2RoYzA+Ow0KPiA+ICsJcGluY3RybC0yID0gPCZwaW5jdHJsX3VzZGhjMD47DQo+ID4gKwlwaW5j
dHJsLTMgPSA8JnBpbmN0cmxfdXNkaGMwPjsNCj4gDQo+IEFsbCB0aHJlZSBzcGVlZCBtb2RlcyB1
c2UgdGhlIHNhbWUgcGluY3RybD8NCg0KWWVzLCB0aGUgSU9NVVggb24gaW14OHVscCBkbyBub3Qg
c3VwcG9ydCBjb25maWcgZGlmZmVyZW50IGRyaXZlIHN0cmVuZ3RoLiBTbyBoZXJlIHVzZSB0aGUg
c2FtZSBwaW5jdHJsLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IFNoYXduDQo+
IA0KPiA+ICAJbm9uLXJlbW92YWJsZTsNCj4gPiAgCWJ1cy13aWR0aCA9IDw4PjsNCj4gPiAgCXN0
YXR1cyA9ICJva2F5IjsNCj4gPiBAQCAtMjAyLDE3ICsyMDQsMTcgQEAgTVg4VUxQX1BBRF9QVEYx
NV9fTFBVQVJUNV9SWAkweDMNCj4gPg0KPiA+ICAJcGluY3RybF91c2RoYzA6IHVzZGhjMGdycCB7
DQo+ID4gIAkJZnNsLHBpbnMgPSA8DQo+ID4gLQkJCU1YOFVMUF9QQURfUFREMV9fU0RIQzBfQ01E
CTB4NDMNCj4gPiAtCQkJTVg4VUxQX1BBRF9QVEQyX19TREhDMF9DTEsJMHgxMDA0Mg0KPiA+IC0J
CQlNWDhVTFBfUEFEX1BURDEwX19TREhDMF9EMAkweDQzDQo+ID4gLQkJCU1YOFVMUF9QQURfUFRE
OV9fU0RIQzBfRDEJMHg0Mw0KPiA+IC0JCQlNWDhVTFBfUEFEX1BURDhfX1NESEMwX0QyCTB4NDMN
Cj4gPiAtCQkJTVg4VUxQX1BBRF9QVEQ3X19TREhDMF9EMwkweDQzDQo+ID4gLQkJCU1YOFVMUF9Q
QURfUFRENl9fU0RIQzBfRDQJMHg0Mw0KPiA+IC0JCQlNWDhVTFBfUEFEX1BURDVfX1NESEMwX0Q1
CTB4NDMNCj4gPiAtCQkJTVg4VUxQX1BBRF9QVEQ0X19TREhDMF9ENgkweDQzDQo+ID4gLQkJCU1Y
OFVMUF9QQURfUFREM19fU0RIQzBfRDcJMHg0Mw0KPiA+IC0JCQlNWDhVTFBfUEFEX1BURDExX19T
REhDMF9EUVMJMHgxMDA0Mg0KPiA+ICsJCQlNWDhVTFBfUEFEX1BURDFfX1NESEMwX0NNRAkweDMN
Cj4gPiArCQkJTVg4VUxQX1BBRF9QVEQyX19TREhDMF9DTEsJMHgxMDAwMg0KPiA+ICsJCQlNWDhV
TFBfUEFEX1BURDEwX19TREhDMF9EMAkweDMNCj4gPiArCQkJTVg4VUxQX1BBRF9QVEQ5X19TREhD
MF9EMQkweDMNCj4gPiArCQkJTVg4VUxQX1BBRF9QVEQ4X19TREhDMF9EMgkweDMNCj4gPiArCQkJ
TVg4VUxQX1BBRF9QVEQ3X19TREhDMF9EMwkweDMNCj4gPiArCQkJTVg4VUxQX1BBRF9QVEQ2X19T
REhDMF9ENAkweDMNCj4gPiArCQkJTVg4VUxQX1BBRF9QVEQ1X19TREhDMF9ENQkweDMNCj4gPiAr
CQkJTVg4VUxQX1BBRF9QVEQ0X19TREhDMF9ENgkweDMNCj4gPiArCQkJTVg4VUxQX1BBRF9QVEQz
X19TREhDMF9ENwkweDMNCj4gPiArCQkJTVg4VUxQX1BBRF9QVEQxMV9fU0RIQzBfRFFTCTB4MTAw
MDINCj4gPiAgCQk+Ow0KPiA+ICAJfTsNCj4gPiAgfTsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+
DQo=
