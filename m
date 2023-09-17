Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9957A359E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjIQMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjIQMvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:51:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239DB10A;
        Sun, 17 Sep 2023 05:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSIWY0VoI/+lMnvX3ap0JQcb8rzBMSQQ13JGa6vwhTgE15oyfoUYuEGpjKkRe7t6bs029bM/ZqTANxWY8r7HOq2M3LJhGKv09rUVPLLLW5bEUyRKrleifA972mDVXRZbEXA/jv119fPydcG7v8OZNUChDxNwKotoPYfxZpiRLMBGmTXGLMyAcd/z/eVeeqcQ+zOtp7So3r3thaH7+OMh7Skk7O8LPwrjQc1CBRZmpLw9fzL8K7iZwsSaduV24UiXQTs5p4NsonzYNWuqfwY+KfPNvhUvoYraXSArsScNJobNaKZ5kZEQonx89f0k3KZPYS6Ev9CJJrQSP20YSUL+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxx4nIjVhwf1SHJZgL+FCgm6cFvUj7oLJcZqU49l2Jw=;
 b=dKHIuHI4ektpB9/+DKn/535S7I783ASXGvZEMu9h8ZCPDfQOBEf9S3uFGT8RXwRa3kTxkrV9PU5mWM8/sLDtOxkpDdd1CiMynzLC29kshSm7x0K5ENjGg3GIJ1hnI/IRDaDtCf7J7Ag9r7L2jb9q+ugo3DwdiWemMrQbUU3WqTIqPppVa7QcSEwY6xqr0K2UESYHMxukw/0H+zBGu+548iLHv8cMKF1VSiIunTvWtrdMP+Rfgq1c6IfXa8RK6WHARQ3F1RbLz8vFwdxhHLllhlEsLbWaw/FbYxJjIVW83x4wfI09k3mpewhU9WheBMwPzn04M/TzpsMvt6mxdvjLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxx4nIjVhwf1SHJZgL+FCgm6cFvUj7oLJcZqU49l2Jw=;
 b=bsSy2izHdHNIZW12vjY0ypZXqUsxIGoGpv5lOtC0V6pqHquXg7bAvHiDazRFLgIv+xlYNndZtHOtgoK68T1dsqfLcJ9fUpdPowzxU55mtZfQ+NK0H6VACmWFXGClQG3BbSgTYQbBie7NBrAO5ofMCqfhDf0570H/MXZYQumjHq4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 12:51:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 12:51:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 5/6] arm64: dts: imx8ulp: update gpio node
Thread-Topic: [PATCH v2 5/6] arm64: dts: imx8ulp: update gpio node
Thread-Index: AQHZ6EF8TVhbByJ46EGYoMNzVt+xk7AepieAgABTz/A=
Date:   Sun, 17 Sep 2023 12:51:15 +0000
Message-ID: <DU0PR04MB94170DBAD83CC752BA3B2B9188F4A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
 <20230916-vf610-gpio-v2-5-40823da788d7@nxp.com>
 <4ff26ffd-2574-af16-d950-7f1b544528ef@linaro.org>
In-Reply-To: <4ff26ffd-2574-af16-d950-7f1b544528ef@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9444:EE_
x-ms-office365-filtering-correlation-id: 1049cb6b-6854-4903-193f-08dbb77cc7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGoTm6/o9ITtVaeN3J4xH5e/GyAUCPgJy5whPiw9kzTYRWC39NywqZQdjE7eTgvtXf5jsKf4qOZm1tR2rGVc/OHi1dufYxBrrhoJfvWQDd5Om4BiTsQS1ZUmUG7t9sJBqlYWAX67e2UZ8FzCKILgV4putYw9s4OJBi7MDW7kY6/IsGdzgfA84mlBLfNjwkV/sdb2LZhPDvyd18JuGhlp9CsylV8jfzE/DCBDOpb1NtSFdM793SZzprBEfnc9OT4DXSVXeQsALXAn8xGr2BNjBD5/KewALGlNSOR99Iz5GfeIeVvDLyrdkofObF1kwH2Qn6uRPf6P4rR2Ea8fg6Oo3KcnWK041qtIkbCSxuC9DA3OyGtfMNhka4S0b9woXd1j46VMOcehkre1AA1YXDXCfds/e8nF8/Gxu2OyJWwOTrtTwf/FoJql/0YyWkSwmI+bEkPopY4vnjO4DX4cG2g+ElTyvyDwB7F9ybwZ2tqk6GmGoya8aSE41KKtT/2LQQPN4BEq+i4dk6XMKBW79DYYk3I2k3cWxfdItwHn+l5ZHNXQ9MnbzbqgT2NTeOcb/uUs+ZVbFqYI6wGSqdeakU6DcOXKW9UFzygrnAibQnwEmi4lnXkrbdCBnoSlXWBpLnsB3j+m09k8BZYHWiGbsvFxCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(451199024)(921005)(26005)(52536014)(8936002)(8676002)(4326008)(122000001)(15650500001)(7416002)(83380400001)(33656002)(2906002)(4744005)(55016003)(5660300002)(44832011)(86362001)(53546011)(7696005)(6506007)(966005)(478600001)(71200400001)(6636002)(316002)(54906003)(9686003)(76116006)(110136005)(66946007)(66446008)(64756008)(66476007)(38070700005)(41300700001)(66556008)(38100700002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2R0NXluN1NxZkcybjdieFZkUksvVyszcGdWTk9TRk9DcFRjYzVXbEpqSlo3?=
 =?utf-8?B?MVFZclNJN3ArZHZ3UWpZMUxNRmdVSXQreHI0Y3R5UEIxY1dac3lNY1M5U1BW?=
 =?utf-8?B?N2c1aHBGRDdqU2YxUHd3cGU0bmxwc3RpeFg1QU1vSXp2TE11VHAzblQ5ZFdQ?=
 =?utf-8?B?LzBCVTM1ZG1XSDVvUGF3RnBHWm5Zb08zWUVUM1BQbFpUdG1lQ3JCWFlwN3BM?=
 =?utf-8?B?MXdtWFBBWXo1MGF0MjdpNGhvUUI4aHozdzRGSStCdFhEOEFsQ2M0MzBrc21V?=
 =?utf-8?B?SG04TWZRTUNrQ3c2ejBlcXpkQTMyK1JzTFk0N3pCUmlHcEorNy85ck9KUE0y?=
 =?utf-8?B?aGNQSXBqaTQrYlZkdHltZldGR0FqSXdQRGdZOU4yRnZDakhhUWp2bEZBVitT?=
 =?utf-8?B?UVRZL3gzbkpyTWN3YWoycWNYZTdwNGNKcENaZm93N0VvNkxweG1Qbk00MEhu?=
 =?utf-8?B?Ylo0UXlNUUlaY0FTMEVmdzBZRk8ycXNmelE1dVZZbUx0TEErNHBOc2p3TVk5?=
 =?utf-8?B?M0ZuU1BUbGhkZTlpQzV5OHFldXVDOTVQb1duOTdGK2tHQndUY1MxR2FTbzFy?=
 =?utf-8?B?M0VNblRiMEtlVlRMSC9kZWU4dHRHcS9jZmozWjBYWmh1WXVYSEx3M285UG9x?=
 =?utf-8?B?RWYza1ZsQXhLUVdob2tSLzY2bkJDQnFGVTVvNnpaaGNGUjVwU1lFMUhxZCtw?=
 =?utf-8?B?NzlPZ1p2VWZXbExhUVpyaVdKVkNiWU9Rd3lRVnpUTjNWSFhIdjdkZHF6eGJW?=
 =?utf-8?B?aXFZRzFoVjJ6TE91SnNVWTlUTjc4d2VWeDRFalZTR3B1eTRTYmNsbmJwcDFz?=
 =?utf-8?B?dXFYcCtZWEhPb3RSY1hrWUhSRkE2amcvY2RsOG5tNXYva1lVbS80dTFiYkZC?=
 =?utf-8?B?T29MZjVUdzJjZFZoRG01bTR2YUpUUGFJUTcvRDludFFLTHFyUFNnL0NBaG5J?=
 =?utf-8?B?VWt3MTc0azJQVkFidFB6SW5Bd2NyckxnT1pwVmZTakxmUmYrKzM4NUFONGdi?=
 =?utf-8?B?Y3VrYk81cVNtZTBhT0ZhbGRRbnhyZ0dmY0ZhUWNsc1FZc0FWWlVWTG1MMlFq?=
 =?utf-8?B?NFFsR0hPb0VYYUZYd2tRYnhjclpmcllGSVkvbFErQXUrM1h0NW1va0MwV1pK?=
 =?utf-8?B?NkhPKzJLb3BJYkZDMGhpUTJ4bGM1MXJrSGdYK2p6Ykk0a3ZWUHZ5cjdmMTB3?=
 =?utf-8?B?d2FjYjlPaGVPOE84SXlWNERJbC8wa0MvTk9vU3VCRlhNbGZKdVdjMmdjT29a?=
 =?utf-8?B?NFhMMWFNNUI2KzB3SzNxRUgzS1FGNVRESkx2NzRFNzZ0d3JCeHNtdTY5eWRu?=
 =?utf-8?B?YWJ0cExIbFFDTFMyRHYzV1c5bUd6T3NvYkxMY1ZLNlpGeUVLaGk3REh5UEZG?=
 =?utf-8?B?c1dETzhlTG1aWnR3OWczNjVXSUIyWFBKc0VFVEVFZFNaQURmUVpBWXFxYm9O?=
 =?utf-8?B?OXJJMVJBcXNRRnc2dXhVcFFhak0wM1czY3NUc0dlUnhScy9QT29ObEcyd1Er?=
 =?utf-8?B?ZVR0ZDYrMkdiWW0xaU0rdXl2TGJnUTZ4UDl3QkhRR3Z2Z040bVA5WFAxdzVl?=
 =?utf-8?B?TGZ2MThhM01SdjdzZFdUc2MwR1huNlhBc2RjTmRnYWtHR0VBbWR4RGt4THRx?=
 =?utf-8?B?VkZDTERNaUN2eUU4MnJzNTZBZFJ3eGE4R0YzT0hqcUxPNG9XYWM1Z1Nva3hy?=
 =?utf-8?B?dkYyUXlHbE90K2NMV05kODhIN2oxRmRqSmxpYUpzSE11NWlQdWYzOTdDSVk4?=
 =?utf-8?B?QjRFRjNTcXgrY2NtMFB4U0xCWlk3eWhQbVZXSWlFZ0lrTmFvS1MwNEhlTkV1?=
 =?utf-8?B?aUJrZDZ3YkgwdjNrWDl0VGxLeHFTWnJ5MFZseklhdGY1Z1ZDTTJzdHlJaFVq?=
 =?utf-8?B?SVpBaTMzSHNVQ1pWOCtVUjUxVXd6aHZFaVkwd0pBVlJsaFNETys0NEdvNzFj?=
 =?utf-8?B?aU9sV3RDeURGUTZ6TXVKR2t2N2RoOWxSR2hnVnRMMjBKUEhRK0ZVdTg0R2RI?=
 =?utf-8?B?NnFNM016NDF3MWFwSW9JYjZkY09qWUlYNDJtTFhBT0lwOVJSNTVYSm14SVRn?=
 =?utf-8?B?VWNKRzFvTDBQSXU2VFJka0IvQVhjOG1ZMFJEL3QrU0pBWVRUdFBVWjFtQnFu?=
 =?utf-8?Q?KJRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1049cb6b-6854-4903-193f-08dbb77cc7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 12:51:15.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5u/kXGL8ejLI7GSnX2xMvayDebCYNGPBKGu3Z7mCa92r0eKnbF0E1s6qvfTpcmHHaI87zWi+WfqQv+gBpEYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvNl0gYXJtNjQ6IGR0czogaW14OHVscDogdXBkYXRl
IGdwaW8gbm9kZQ0KPiANCj4gT24gMTYvMDkvMjAyMyAwNDowNCwgUGVuZyBGYW4gKE9TUykgd3Jv
dGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBUaGUg
aS5NWDhVTFAgR1BJTyBzdXBwb3J0cyB0d28gaW50ZXJydXB0cyBhbmQgb25lIHJlZ2lzdGVyIGJh
c2UsIGFuZA0KPiA+IG5vdCBjb21wYXRpYmxlIHdpdGggaS5NWDdVTFAuIFVwZGF0ZSB0aGUgbm9k
ZSBmb2xsb3dpbmcgZHQtYmluZGluZyBkb2MuDQo+ID4NCj4gSSB0aGluayBsYXN0IGVtYWlsIHRo
cmVhZCBjb25jbHVkZWQgdGhleSBhcmUgY29tcGF0aWJsZS4gT3RoZXJ3aXNlLCBob3cgZGlkIGl0
DQo+IHdvcmsgc28gZmFyPyBZb3UgYnJlYWsgdXNlcnMsIHdoaWNoIG1pZ2h0IGJlIG9rLCBidXQg
Y29tbWl0IGRvZXMgbm8gc2F5DQo+IHRoYXQgYW55dGhpbmcgd2FzIGJyb2tlbiBoZXJlLg0KUGVy
LA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzAyZTI1ZTQ0LTExNDYtYmI1OS01OGRlLTgw
MGIxMWQzMGU3YkBsaW5hcm8ub3JnLw0KSSB0aG91Z2h0IHdlIGFncmVlIHRoZXkgYXJlIG5vdCBI
VyBjb21wYXRpYmxlLCBpdCBpcyBTVyB0cmljayB0byBtYWtlDQpMaW51eCBkcml2ZXIgY291bGQg
d29yayB3aXRoIGJvdGggd2l0aCBpLk1YN1VMUCBjb21wYXRpYmxlLg0KDQpJIHdpbGwgYWRkIG1v
cmUgaW5mb3JtYXRpb24gaW4gY29tbWl0IHRvIGRlc2NyaWJlIGJyZWFraW5nIHVzZXJzLg0KQlRX
OiBpbiBsaW51eCBkcml2ZXIgaW4gdGhpcyBwYXRjaHNldCwgSSBoYXZlIGFkZGVkIGNvZGUgdG8g
c3VwcG9ydA0KbGVnYWN5IGJpbmRpbmdzLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
