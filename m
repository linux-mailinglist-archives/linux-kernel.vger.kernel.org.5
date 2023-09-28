Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F377B1803
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjI1KD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjI1KDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:03:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D9122;
        Thu, 28 Sep 2023 03:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFcE/9CVypPqIYa1c2jcWzZxdz8k0C2g1WWN+K3JLWixrDTTDZLelJQ9gXbCoGla92qdGgESEJD4VND9nq+sNzZMGExKDJH25FmclohjxaPU5uqhC9KLBo8Kw58gfsqJpHgzwKcsm9VjGnTpZu561kv4tjXvKAgyB5GLCDIaqOkkLpk0cbTzPJFdppMgKErXnQ6UobMu4rhtFPg2g2MDgr+4xHe1P0H8PfUtItg6XBuhm3TMXyHE9rgsMkLaLwHxLJUhxJiJaZTMoHbZBbvzE/bfidXrU8NWfZmlnwwYn85BKG/jfUJr8Pd6FfbH4uxx4fLWOZ1ZLJdcqfgTpaYhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZjfZ/a9cqFS3LLi5VK+FhLGsscnJHxKITZKV8Lkk88=;
 b=Ixg0QQUoEzaPGe1QDoBlhiyfYLg/aG4ZA6Q+6jG3ytZ99iPio2eHKOxO6ecQSdnCxKOh6xCYj3pXY+2E7JG3M7s2I+9y3kDMh8om9PYPrDVX30difprkh5RIQFNYAAo/F3R5GAsQGJne7VtqTisgwR/ebgfC5J/Jf0peoL7s8gv/Z6CDYuUzex5OKjwhrX7zfukl6dgOBGKS4xx0p6PDAHB8itj3sMFC0ENAg5zebgwI2pZrs9VBxr7VVWEbZLWFnw+emRlaQCHKjWgd4+CKwoZaDU3SZIncO6cqRsFtE8pWnzuLX2cvIOQDKdM8tT5cW3K07pwYglopsj5kMMjXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZjfZ/a9cqFS3LLi5VK+FhLGsscnJHxKITZKV8Lkk88=;
 b=WJWFppg38m79/vkcEfhBAj1s1FAv7UiY7wjXzzyUBXvF6edlDzhV7pyQu6QnuJ1gsHfwtr9eeyULfl3ERsFTaYhmYOLE4aOhTN2umgjrAwcN1AKtRLrzVKWGMAChoSbexcvcTR0J4ZyFGNA4dvqD9kyM3ayHyFgwpeBEL5mshzE=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 10:03:19 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 10:03:19 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAtGSWAgADFGZCAAHUzAIAAE0xAgAFQggCAAErnYA==
Date:   Thu, 28 Sep 2023 10:03:19 +0000
Message-ID: <AM6PR04MB6341532C5DAC970C862EEE6DE7C1A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <20230926-slackness-target-b74e33ab1031@spud>
 <AM6PR04MB6341B0D9EC8146149CF8ADB0E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <54c87219-de9f-4c5b-9c70-11de22c7c612@linaro.org>
 <AM6PR04MB6341B76B30FBF12A58B77AE1E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <9fbe078e-615c-473a-b0ae-f4a53336432a@linaro.org>
In-Reply-To: <9fbe078e-615c-473a-b0ae-f4a53336432a@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AS8PR04MB7511:EE_
x-ms-office365-filtering-correlation-id: 03bba45a-8dee-453a-f3fe-08dbc00a2446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sfa84hjjZgHt+LO9/AY8yh7JGkeHLMsMI42AgcZ3BYrSYpmk0ZPMt3MvfUdma64dTwwmY7pG4BYy8G6S849v8WoSLDyiTLqKkOYYQSpT4af15hGrzvWVVMt7upiBKpZOvclVQUIzrvEqhU8RYvrrrC/ty0yp2DzaEcqrO1FtaxF62AYaZ0Qad7loBFc4QOhJq1ri3Zv53J8/G3NKgndeRFYOsb/tXN29U9fHFP+7Ykrh3kOPgmBlVziAa6qBihAP5sgnIR3cTGYNUoCd3OFiMLupI8J8+8cYDh2PE7qpH5/fmyBJK+NLIXJ0ZWMxdayXDiadXdlWkAzAa2z9gXkplyLnbH+CzrT7ijo2p0wi1WoQWZVPr8YeLRbcQAGkCTCBeQ5w5eLJ54KOWLJt9zAvaqJoANF7/8hXw/7CdmPOwnpDBoAAKAApt9d3UR2R4sDjS4z7vSsOIFgK5aAHsGe4b7lqiXrh9F/DoDdfDAejNKnymkkWFaBDwZpycgv9HSj5GG5bSp9roorGOblgXbxDn0C0qcqVJ95ArACsoC37dDiuwUC3ycZ4jSIS7o80hKgOK4cyKmKhK6scmROE3Yij7gbhulvXPRWk/vYZhlQhKRkAKlJiiZor/AHndTC1pOGU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(478600001)(110136005)(76116006)(45080400002)(66556008)(66946007)(122000001)(2906002)(64756008)(83380400001)(66476007)(66446008)(38070700005)(38100700002)(7416002)(54906003)(52536014)(316002)(6506007)(41300700001)(71200400001)(55016003)(5660300002)(8676002)(8936002)(33656002)(86362001)(7696005)(9686003)(44832011)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWQ1QUExWFlQZlRXdGVCNi9qSFhCdmtqdE4xa3NzcUF4LzhyRld6U2N6czRV?=
 =?utf-8?B?clF6eFFYL2xML2hTTnlXKy9xVHNnVUZYR3dpTDhTYnUveWdOQzh3NlRBdXNW?=
 =?utf-8?B?TVIySzFHMjVqY3BNbWhmaDQrZFV1dk9UT3k2QXVxcXhmdEkvcUNoVW1ONkdO?=
 =?utf-8?B?WmIrMkVZSGozZ2VuT05kSnZhWElZcEJWUnBaNkZYc3p3OHkyaWxkbTVQcWhh?=
 =?utf-8?B?b1cwQjNFS1NCcDBKNlAvaTloekFoZ0ZVTWlYYzczeXB0UzAydW1oeUYyRkh6?=
 =?utf-8?B?bmN5Uko1QjY2SUFQUytadFhSOUM4UDNTSkFFUnA2eHhDVXduVWZyNE0yRDRO?=
 =?utf-8?B?VXl5US9JRUg3MmFzZ2NKdnliMnk5NGp2SlpHWlRXU1JOMGRDVkhZYWhyOXkw?=
 =?utf-8?B?cmhjbllEWktsOVI3VTVGS2NOaEx3STV4Z2Jvd1J1MlJKdmtSWlVqdkRZMXdw?=
 =?utf-8?B?L1hvb21EbHhBbVo3bW0zZ1lvbTB4UEcxWXdHWi9JeHAxNXpQKzI0N2pFNjNY?=
 =?utf-8?B?R3ZhL1B3MGlDZU1IS0lSRjJhSVowWTFXa1RndmFzRFN0TG4zYWlIMzlDem1C?=
 =?utf-8?B?QnNkR05TZXdpeXRuVEZzSUdWVWVweVdxSWszWXlQc3RLQUZJZjhMNjFXcFZB?=
 =?utf-8?B?RnlRVTZiRGIrUUlqSFFqcnlqQk9IV0hFclhpd0tCL2txVGdUVTllR1pWcUZU?=
 =?utf-8?B?MXpuY1JyTHM0YlBjdjBUVi9raDNSdjhIVmthTUY1SmtLNW15eVU3UERHZVFy?=
 =?utf-8?B?VVIzNXExMDBaKytkeXg0aWhSYy9oU09weG1Ma3NBZEFQY1lzV2dHTlRObU9F?=
 =?utf-8?B?ekdVS0hXd0hONXljVFYxaTF0bUVQNW1sb3Z6YnUyVzNhSHg5cVRxMmt4eCtZ?=
 =?utf-8?B?ZS9zak5ZZ01hZUVMTEh3WVdlUkErSzMydjFxTThZRVhZeDJVRThYL3Jaa1VF?=
 =?utf-8?B?Y3N5T29YTXhIeUNGOTE0NTIvWkxrYnNtZkFrcmhtcG5zc1MrdWY1ZnRqV3lY?=
 =?utf-8?B?ZytmeWRQaWNQdlU2SEtrbW1JZWFOenNHcHhHemVmZHlKWmdVQ2ZXb09FRWR4?=
 =?utf-8?B?M1ZWR2lRdVVjR1Z3V2dKanFyakEveWx2SytxQzRlaFI3NXVlc3N3SS82bTNy?=
 =?utf-8?B?d0FTTEV6U09wYTZVTDRHVUpISjlXUlBlbW5sQXRvSUxpcTJ0WFJDWmtRc0dZ?=
 =?utf-8?B?TUdhSmtMSHZQMXJrZS9yMFlRRW9RREpiRmJKeWRDZDdWZGt1aUcxZU5kSWRP?=
 =?utf-8?B?VjNubGJvVFZOakFWY3BzRjlScys4cVpaQ0lJdktUNWVrVkRQN1paYUtoWnVk?=
 =?utf-8?B?V1VaSXN6M2lrT2hsczloeGt4a3QvY1MxbS9sWTJFb0IwMFBTRmZZcSsrRnl6?=
 =?utf-8?B?Yk44ZFhMYzNENkJZRExoRE5tZ0xaeVNLT2l6cTQ0ZkZ2QnowbFAvZmF2eFBp?=
 =?utf-8?B?YXNMRHRMRTJhNll6LzRzK0FLTjBSSDIrdFdGNzJ5MWZQZVVFLzFHa0JJc0d6?=
 =?utf-8?B?VGZDb2VUUitZTWIyTG9FVVp6akR4MXVvclg1L1UydFJuUEI4bXl3VjZSOGt2?=
 =?utf-8?B?SU51ZTliNjE5NzQ5WVlzU0dtYnNxK2FyN2xqYjZtMzk0NnB3NmhIOVVzdFln?=
 =?utf-8?B?M2J3SysyMUtBWnF6VEI4N3laMTRFb1Ntb2VzOGRuNHNPZGxVbmczQ0p4ZGVt?=
 =?utf-8?B?aGlVZitjS2dDcmM5dDNTV3pIdTZ6THhubG5ReFJPcWYvYitDN0pHRU1vWTNR?=
 =?utf-8?B?V0VaUGtvTzFlRUJoY3doVnVUa2RZS3lsTXh3NzdjWVRmbDZXT0ROcVZsSG53?=
 =?utf-8?B?c0Fzb2RzSTRTTW1qZlhQOXRGdEpnRngvT3Bpc0dvTkgzbS8yVkVOckYwTjhn?=
 =?utf-8?B?eWppbW5EMmI3ZDZsQThMckNjRWdaYUhnczVzUjFtNFBJcGh1OXlEL28wRTBp?=
 =?utf-8?B?eEtMMll3elV1aTdKR1JtM2VQclBRT2lxU1hhUzltQ21wZGZVMVluS3lkMEdB?=
 =?utf-8?B?bGJ3Z1pnY3ZTbThJUk9uczF4YUcyamtIZXZrWU1QUXpFNHV0NG1wT0REZzdK?=
 =?utf-8?B?VmFDdE1uREVrZWZqbW9qdzY4NVdPbzJhWGxCNFprdytvZnArYWZ5YXBEeXNE?=
 =?utf-8?Q?491s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bba45a-8dee-453a-f3fe-08dbc00a2446
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 10:03:19.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJVnTBr6L8j04kuMrY/iOHu6DnGeXuVzM6lWcVV9INgesmCWX1BHIgByMIrkrV2K2q5eDTefon15gH4hEYl6JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI45pelIDEzOjI0DQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+Q2M6IE1pcmVs
YSBSYWJ1bGVhIChPU1MpIDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47DQo+cm9iaCtkdEBr
ZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPmtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IGh2
ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj5rZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgWC5ILiBCYW8NCj48eGlhaG9uZy5i
YW9AbnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpob3VAbnhwLmNvbT47IFRhbyBKaWFuZw0K
Pjx0YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMi8yXSBk
dC1iaW5kaW5nczogbWVkaWE6IGlteC1qcGVnOiBBc3NpZ24gc2xvdA0KPmZvciBpbXgganBlZyBl
bmNvZGVyL2RlY29kZXINCj4NCj5DYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQ
bGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj5vcGVuaW5nIGF0dGFjaG1l
bnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQN
Cj50aGlzIGVtYWlsJyBidXR0b24NCj4NCj4NCj5PbiAyNy8wOS8yMDIzIDExOjI1LCBNaW5nIFFp
YW4gd3JvdGU6DQo+Pj4gRm9ybWF0IHlvdXIgZW1haWxzIHByb3Blcmx5LiBJdCdzIGRpZmZpY3Vs
dCB0byByZWFkIGl0Lg0KPj4+DQo+Pj4gSSBhbHJlYWR5IE5BS2VkIGl0LCBJIHdpbGwgYmUgTkFL
aW5nIHN0aWxsLiBEb24ndCBlbWJlZCBPUyBzcGVjaWZpYw0KPj4+IGludG8gdGhlIGJpbmRpbmdz
IG5vciBpbnRvIHRoZSBEVFMuDQo+Pj4NCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+PiBLcnp5
c3p0b2YNCj4+DQo+PiBIaSBLcnp5c3p0b2YsDQo+PiAgICAgRG8geW91IG1lYW4gdGhlIGxpbmsg
aXMgaW5hcHByb3ByaWF0ZSBvciBzb21ldGhpbmcgZWxzZT8gSSB3aWxsIGF2b2lkIGxpbmtzDQo+
aW4gbXkgZW1haWxzIGluIHRoZSBmdXR1cmUuIEknbSBzb3JyeSB0byBib3RoZXIgeW91Lg0KPg0K
PllvdXIgZW1haWxzIGFyZSBub3Qgd3JhcHBlZCBhY2NvcmRpbmcgdG8gZW1haWwgZ3VpZGVsaW5l
cy4gWW91IGhhdmUgc2ltcGx5DQo+bWlzY29uZmlndXJlZCBlbWFpbCBhcHAuDQo+DQo+QmVzdCBy
ZWdhcmRzLA0KPktyenlzenRvZg0KDQpIaSBLcnp5c3p0b2YsDQoNCkkgaGF2ZSBtYWRlIG15IG91
dGxvb2sgY29udGVudC10eXBlIHRleHQvcGxhaW4sIGFuZCBJIGNoZWNrZWQgRG9jdW1lbnRhdGlv
bi9wcm9jZXNzL2VtYWlsLWNsaWVudHMucnN0LCBpdCBqdXN0IHNheSBUaHVuZGVyYmlyZCBpcyBh
biBPdXRsb29rIGNsb25lIHRoYXQgbGlrZXMgdG8gbWFuZ2xlIHRleHQsIHRoZW4gZ2l2ZSBzb21l
IHRodW5kZXJiaXJkIGV4dGVuc2lvbnMgdG8gdXNlIG9mIGFuIGV4dGVybmFsIGVkaXRvci4gTm8g
bW9yZSBhZHZpY2Ugb24gb3V0bG9vaywgbWF5YmUgb3V0bG9vayBpcyB1bnN1aXRlZC4gQnV0IEkg
b25seSBoYXZlIG91dGxvb2sgZW1haWwuIFNvIEkgd2lsbCBvbmx5IHVzZSBwbGFpbiB0ZXh0IGFu
ZCBhdm9pZCB0aGluZ3MgbGlrZSBsaW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KTWluZw0KDQo=
