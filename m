Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E547C7AFFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjI0JTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjI0JT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:19:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5A392;
        Wed, 27 Sep 2023 02:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBEK5B/1R2tQvssmQQPzQJHg5w/coist7SulaL4Q4kVCFyTdYsQqHkkwy6G2SN88pnRNafxDVYWWjKscasmkBhvmyLvCglmYgmGkDhIIviEMjRGmw/Gf6jT4MER7tJxjMCCxnfXVwMxgrfzgWbHf9RdO36ZEjNS1ERGiGjG9UgJ7IVS2MvNm3E/sHDiA1NESWpRkyLEiZxxnof0PYQOhMnp1UvjlOgynXCYfgRdOt4za3tJN9Q5jgzxjINWOtQJt9uITljLzLSOUYJJ1oM1axJC0iQ4Cp9Uvtv+vedAgpmGg4KoJ+29xKcwWrvhnIEoLr/NARp3kI1dfWvWrHCha7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWIy+mrvNckgGEAmTCY60qXsg2zvCbEk77l/2diBBJ8=;
 b=H5vySJ87ZINFkZ+yDrr7GUwzGnlcCdstUFKOCf15hbKi5BOxfCZiHJwFIacNJ2T91GhQf9Vy8Ip5/b9o8p0T1walBmju4Lh1cILtaY30MkfDfuAHijS/6x1mENftHzr5Ln1OV2ERfhZi3K613gefmuLvznN1Uyo/lqak1p+9RNcuUF+3VVxzk8E/UuhdjWdnW5ZnDrs+Zlvxz9LktM5iyDzoUD7E5kO/0LcEF4aRa/sY9ZPYvJCUH3GUxKKlR/fhLaAZx0q3D02cAsVYiv6vmtXbR3XhS070fovO3u4VmdyS9hM0UO34JX5XIdgBVuFIvZAaO6NBK/UscL48lrgLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWIy+mrvNckgGEAmTCY60qXsg2zvCbEk77l/2diBBJ8=;
 b=SO4tAZeL58G4reAkgaBcjHZTQgdmVOXCWEUmE/OTJOaKKal3kwxb2DKO9eCmL0qikMIBvZpzm62aU8m43c19TGYGNsV1YIxvzII+9rIVpHFAYZE/KNWdvHF+rcfPEUxOiri2hDoMAZUVlnF77qekzdZOMm3IX7Zxtey5sWOsqqA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 09:19:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 09:19:25 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
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
Subject: RE: [EXT] Re: [PATCH v4 1/2] arm64: dts: imx8-ss-img: Assign slot for
 imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 1/2] arm64: dts: imx8-ss-img: Assign slot
 for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGov7h7KqfCpUS2rDO4Xr8Tt7AuU2wAgAARFzA=
Date:   Wed, 27 Sep 2023 09:19:24 +0000
Message-ID: <AM6PR04MB6341F15D9A932C3567103BF4E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <1144f7f3-ffdc-47ff-b90f-2d2dd86c8f15@linaro.org>
In-Reply-To: <1144f7f3-ffdc-47ff-b90f-2d2dd86c8f15@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DBBPR04MB8042:EE_
x-ms-office365-filtering-correlation-id: e8b41102-5c81-40c6-7527-08dbbf3ad7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7RRjizT2v2h6P8U0ND5SH/2Hx8Ylx3r8ktFxOOl+ivitu9xbL/T+n2jhlvGnNRTGkpT9sNl7a0TR2559C87GJ/iqvfstBRV/uWiXCFFfk67LtDgrROaZDMYTarXQyApPEoDyM06fLEKnuK9EkzWSa9H2e+wSwYSc+SwZBLdjiW+Vz33TnsfxSSiZwQ2r+dPWubLiHHDNKCViv95XQ7xu4iLYkPMOc/hBv4fQ85Id+hlMSZaNXG692ngRmg4UVVumVOjzt7qGYIVnOTtWNZ608iZpVc0oXw8mCMO/8vUEFUt23DXJ+tGKatevSKQz7X8H+wX9mBtIBndQutUDp8tad1EBHgjXemVDZsu7d990HQ8VtIa6YAwBlGjTx9HkUdJHZZYdoKzWu6YUe+7xmZ/DswR8EWsgCIZvijgDni3r7oZ7RCi0Uz6ih8kHd6e0axq/7GgT3cZ8ikOSEg5ndB9hvkaFamyCnHZRfs6CjVV/hZI8HjvgVbWCyepevtWF8FPE44EOZeLQOjHzBSjsvrlcQtOQX6jUgGNlSbVUb98djPbcEOukHLAQ8lUm97xkT/q1ozC+6PuUa6GVxFNycjKYf//onZNhJgBw9nGJOJyxnQR3ykiBLpVEHyVqpyT9M8p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(66946007)(33656002)(83380400001)(4326008)(8936002)(41300700001)(26005)(8676002)(478600001)(7696005)(6506007)(76116006)(66556008)(66446008)(66476007)(9686003)(54906003)(38070700005)(71200400001)(64756008)(316002)(110136005)(7416002)(122000001)(2906002)(5660300002)(86362001)(38100700002)(52536014)(55016003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEF4Q3BzejljcmI5dDNvM004L3JzOVN5MkRnY3VpTmJaOWU5ekpzQXdNSWVl?=
 =?utf-8?B?dS9EVlJxRit4MDdWZjUwcFF2VldUL3ZCdXVkaHJiT0dScUIzQzBBbEI5UDBH?=
 =?utf-8?B?Vk4yeUNtNXBYaGlEQXhjd2dvZU1xTGpYUExTcEp5UWtpcjA0S29HTzAxd3Rw?=
 =?utf-8?B?ZytITXQ4dVkxQ0dpdVdxTUZaRk01UUxvWG5UWnlLaCs2cU0xd1JvZkpuMllh?=
 =?utf-8?B?ODBGTE41Rkl6bFFpeGoxMVVPRVNhYWhOVWJNRFdTL1BzS0pxbXJOU1BXcktT?=
 =?utf-8?B?bzRMeVArdElZNXk4cFBiZCt4YzlnWFkzenRBRUxCdFVra2NWZnZtZkJYakhY?=
 =?utf-8?B?bVVXbzRUWHZLdy9TcjZiY2lhQjVIWjJXOTlVYnJGaGtocHVFTHhXNHk3S0Fn?=
 =?utf-8?B?RitPVWJaMzRxMDJFM2FHUTZnTndzU0p3L1QxUnJLUER3YUg1OTRGTDFFaDNY?=
 =?utf-8?B?N2lrcHlGTWw4TDBva3o5bUR2ejhIREMvN1JzYVlmd2xKT1B0bkgxRG1qcml4?=
 =?utf-8?B?TWZYTzhaaXJrTG45T1lKSVhlOFZ3bXUvZFUyUzFOaTlZaDZjdFhhZHVHOW1X?=
 =?utf-8?B?ZGtZbVUyNFBqNnY2alNEYjhxa2M1aWVJWW50SWpVQnpqSXpySFE0R2owZ2tV?=
 =?utf-8?B?MURoanBpOUZFeVVVbDhTTFJPUkMwK2tZeG1tcFdtRXBpR2djbFpLS01SR1VY?=
 =?utf-8?B?N1dGUEZ6Rk5YVnBKMDNyNnBZcmhITWFhdVcxK0gvSjR4bFNZZGZ5czJlVFdT?=
 =?utf-8?B?SDN0eUxnVm5BelNIRjZJSVpCQXVxYnQza1hqdzMrVFNWZUZuaHMyei92eVA5?=
 =?utf-8?B?WnpSTG85RStTODVhWHNYNU5uUnEzTldqT2I2bzM5TjZhQmlvTmJIMTRqdW5h?=
 =?utf-8?B?eGR5T3lobnE2SkRFZTlCTDljNGZBeDZCaTZTOUc0bzRMbVNlc1QwdDNhYWJm?=
 =?utf-8?B?T2N6cDZXWERkbnBnV0JyWWJRNUw2b20wengwdFV4SElZTk1iYzJ1ZVFNOTcr?=
 =?utf-8?B?dGhtYXlQaWVVeEtyM2JjcTF5cjJReWRwU0ZjOFJSakdZWm5HaVcvbEJ5UFpo?=
 =?utf-8?B?UjluRGhPU3h2V3ZyRHlId1lNWXhZRnpWNGZEN3grODdUTXVCcTNjNWp5RC9J?=
 =?utf-8?B?NDIwV01VMDV6amZEeC9nNmhMSXJsTGxCeGdRTXRlV1dGaDE4NXNWR2FnOGZ0?=
 =?utf-8?B?L1NEelRnZGlhVms3WFc3Q1hiM0NjSVpoR3E5Y0tuRzVyZ2dHWXd5L0tVK05z?=
 =?utf-8?B?YlFpbG5RcDlyMFEza3lHeGNNYUJrUHNQaGlhUGdsaVdYWjBUYkNDMXloZkpy?=
 =?utf-8?B?U1JzQlg2Q3dvd3dkYlVObitoc0Noa1M2N0NqRzNORS9ld0pzbTRMRkh3Vjgw?=
 =?utf-8?B?dkVHTkxENW1qNDNKa0hyNzFtYSs1SGF2dzhEcURGcHo3Y0VQYnl3MXVDM1Zk?=
 =?utf-8?B?L09JenlGbG1tRjhKWktvNS9YV2szOWFHZlVteU4yZUx4cjBkYU12ZDUxcVM4?=
 =?utf-8?B?ZzJ2cGtXWERVRmVLdTJuS09BQ2hHbW4yU002azJiSTRuUGdrMTZqTERSenY5?=
 =?utf-8?B?Qi9ZaC9RblNkcGVwUVM3WEFYZXovRUVqMmtQeUFSQXRuRmdoTjNsc0I5dUIy?=
 =?utf-8?B?VGFQUFh0elpUeER1K3c3OWVNMWk4b05VdWZtaDV0ZjZSa3l1WTlGYUVQdSs5?=
 =?utf-8?B?akNsZzN0QlRuaWFKWnpQY3htKy9OQjlCU3lZalFTT2FwYzNra2d3NTBJbnFH?=
 =?utf-8?B?cEZhTGE4dHVDMmxMRVZVVUtUZllQRDNhLytnS09Vb1lZZmdOUHVsN3NBci9k?=
 =?utf-8?B?RGFKdmVMcWpnd0RvZEtJRTNCWUI1a3MvaDF3YkNldGh4NEs3Z0xDK3BhalE5?=
 =?utf-8?B?SGVxd0R1MUJqdkRibmtpZk50NGNURWpORnROMzNSNUNvMFQ3TWJQSEkxYTJU?=
 =?utf-8?B?MWw5aVlwbm5YcXFXMXhwMmdRREtiMm5ENU1iTGRCSGwzZmNwMWkvNjFFbENJ?=
 =?utf-8?B?UmsxMDlFSDEzcVRJdUN0Vy83TlcrQWJoVWtRNWNqQ1MvVktHL2x0Sktsc0Qy?=
 =?utf-8?B?UkEwRGJLd3VDY2lZVnZLVFJDemNhby9VVW1RZVdybmJWSlFvZldMZlR4UnEx?=
 =?utf-8?Q?aJQA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b41102-5c81-40c6-7527-08dbbf3ad7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:19:24.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZHkfdRSlWbQ5iFUSuWt8KG8LS4Ddubpk7n4HdyTCOywnf1WmPNpK89OFJb6jHg77S8V1+bIUS88sSnCbnEk1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042
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
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI35pelIDE2OjExDQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3Mu
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IFguSC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91
QG54cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjQgMS8yXSBhcm02NDogZHRzOiBpbXg4LXNzLWltZzogQXNzaWduIHNsb3QgZm9y
IGlteA0KPmpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+DQo+Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRl
cm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+b3Bl
bmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5n
IHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+T24gMjYvMDkvMjAyMyAx
MjowOSwgTWluZyBRaWFuIHdyb3RlOg0KPj4gVGhlcmUgYXJlIHRvdGFsIDQgc2xvdHMgYXZhaWxh
YmxlIGluIHRoZSBJUCwgYW5kIHdlIG9ubHkgbmVlZCB0byB1c2UNCj4+IG9uZSBzbG90IGluIG9u
ZSBvcywgYXNzaWduIGEgc2luZ2xlIHNsb3QgZm9yIGlteCBqcGVnIGRldmljZSBub2RlLA0KPj4g
Y29uZmlndXJlIGludGVycnVwdCBhbmQgcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90
IGZvciB0aGUgYWxsIDQgc2xvdHMuDQo+DQo+RFRTIGlzIGluZGVwZW5kZW50IG9mIE9TLCBzbyBz
YW1lIERUUyB3aWxsIGJlIHVzZWQgYnkgdHdvIE9TZXMuIFRoaXMgcGF0Y2ggaXMNCj5ub3QgY29y
cmVjdCBpbiB0aGF0IG1hdHRlci4gRXhwbGFuYXRpb24gaXMgbm90IHByb3BlciBqdXN0aWZpY2F0
aW9uLg0KPg0KDQpIaSBLcnp5c3p0b2YsDQoNCkkgYWdyZWUgdGhhdCBEVFMgaXMgaW5kZXBlbmRl
bnQgb2YgT1MsIG90aGVyd2lzZSB3ZSBuZWVkIHRvIGNob29zZSB0aGUgc2xvdCBpbmRleCBieSBo
YXJkIGNvZGUgaW4gZHJpdmVyLg0KSSB0aGluayBpdCdzIGp1c3QgdGhlIHJlYXNvbiB3aHkgd2Ug
bmVlZCB0aGlzIHBhdGNoLg0KV2UgaGF2ZSBkaWZmZXJlbnQgcGxhdGZvcm1zIHRoYXQgdXNlIHRo
aXMgSVAsIHdlIG5lZWQgdG8gY29uZmlndXJlIHRoZSBzbG90IGluIGR0cy4NCg0KV291bGQgeW91
IHBsZWFzZSBnaXZlIHNvbWUgZ3VpZGUgYWJvdXQgcHJvcGVyIGp1c3RpZmljYXRpb24/DQoNClRo
YW5rcw0KTWluZyBRaWFuDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcu
cWlhbkBueHAuY29tPg0KPj4gLS0tDQo+PiB2NA0KPj4gLSBpbXByb3ZlIHRoZSBjb21taXQgbWVz
c2FnZQ0KPj4gdjMNCj4+IC0gYWRkIHZlbmRlciBwcmVmaXgsIGNoYW5nZSBwcm9wZXJ0eSBzbG90
IHRvIG54cCxzbG90DQo+DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KDQo=
