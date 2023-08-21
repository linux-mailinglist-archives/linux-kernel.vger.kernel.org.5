Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01583782318
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjHUFTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjHUFTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:19:33 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2072.outbound.protection.outlook.com [40.107.12.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3EA3;
        Sun, 20 Aug 2023 22:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpV7SYVyUDkBLWcuEhC2u86xMUAOfu+S566aWyx2rblpvALRT3wwK7oXWdLXn9NlBgwFd9sRjZDd/KrnEdHL+bAVPXEp6P6LbP0hix7cgW09Q4X3wQBJiPu309UiaS4QTyuvb/iHFDzh+NRtcr3Ag1azvsJGoSaxae2hwg/b4W8gggXHDq4BHnyw01Awh1OQxfG8/knmFfSH8GFmVTivKO5GcWfepKxTIaLg1JYFEyu1iPilzF7Iom54fAtFcTXLk5nV4h2KifdAItWq6AYHT9bJNZM5ZLRgqKg7HsBNnPSUD3oEyJM6pXLD5E4QmRa0e2L+0LwewUuQ33ks35n5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2rjiqVoJeOW9kWFOtcmqOznab/jL3JMHd/QlKm9FX4=;
 b=nqKeCg1Njqq89UZTmihqXqJrg4Q+cEfgdKaQH4hgGX8LkE5QQRj3tsQHNixwcNLxDSnmqc7yKgJRcOE9eSzt82M4+dSyqFfdTgqnDQdrY6w6+1uiwSPpxgCjQHcjiMjsRxnkmeJTZdHBTl+EHY8sQQcn9vBA/dQnWmrPrF9k+T+COmSohPmTMYj7kYuD7rj9qz1OxQup1H3fSvoGNUtCaPK0wOS8ju+m54SPBeo0IKmRN7UUyZvzpf63fCXAKzasOVff1yIHuoh52G742hqedm1XBfRuv+EwpEm5bn5jiV0N0KcKhpe/j5MChfZOrjkY5JeGV5DLYIvpnwdYEvyDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2rjiqVoJeOW9kWFOtcmqOznab/jL3JMHd/QlKm9FX4=;
 b=NNlee1Qs61zESdhzVnmLaNmrX3XOVPkeq8evB4WZTUUaaSE12w01rvXXNpdsIk1rF1TGbb32STvc8jgLHPDCMn+ThyeUBohXB0E7f+1PzvlnLzuHbRycv0I9tokqMy/Vp04VOwVQFpVj82ZhZEoiRg0naG0xQKwnkucdaUFWtstKeiv/+V5neNJqVkqdu5SKkM1DFsZcVASCUap3DR+rpffvPLchwkXotoLM6ICfX4ma1njQiJAHltY1bePnZ1ay02tPaRisiyKnNqtTM8NbomEZoT3EOUByDkL10dE+Tk6wkiZ9PXYj0gBy21E+14+eetKJxul3VtGDA6AmQp678A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1557.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 05:19:23 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 05:19:22 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
Thread-Topic: [PATCH v4 21/28] net: wan: Add framer framework support
Thread-Index: AQHZ0fKy4fvSABwX7kiI/s138OSH1a/zsGsAgACJxQA=
Date:   Mon, 21 Aug 2023 05:19:22 +0000
Message-ID: <fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
 <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
 <CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com>
In-Reply-To: <CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1557:EE_
x-ms-office365-filtering-correlation-id: 0b7aebb6-dddb-4ec9-32dd-08dba2062e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mC3E6PYQnh6ecZDVrAVxGGllVA+e4lpEJ80yatf6zp55yrANVGau9fsnZvX/rrysxDEv6OniLRfau+9WroiMDb6KsSMhOpsP3cdgx0hE/C2MDkrb86xEs+I47MsEfTZklKlSkA6rqH7pVazNMEQdw11V3yFjFN+6q99N3o99Nlv4ftyQJVgcvrw5BqSmm4vXkkdyGniv+5t/1Mzw+MI4QejYTt2VD8O7aw6oqgK+0LaMKI1LsXOP+5qZk3rL8hnxwIGW1HrF5Pbin3G6ZJ5IMeAaBD0qq9gkwbXBbI+62iJ6AV3HuSe+3/Rkxdj0AphL96t0QhYXL4I3XoPQhqYR9bgCfKTUEONYWgOykAnu0XvfO4FqL9lsIhHkV5hAhOdHlr54BtoJbvI9k2QUrTpyuM8SJkPqTxRXe7NkN8oW7jwN0ppcmwuDpgXGY432FQZrh6yQfONtHg2mSzysUk96e5OChgz6Qgx6Cq22Njch1xwWbfqSphnscz7JGn9kzNEROGmPpzMDO5wzCozRCbftHJ4Jn7rEl0QAQa+/0W2HqNySZE1WzQ11QAAqnDSqkwIWw4rjX7UDnL3vZuUBFhGixN8JR/LjiNmI0NWa55hJzT299x9ogW3UXTSojvE+7WXHs2lOSr3Ye8qk5I+0nBYYCED4+BVz0oq0VJS70f1R9c0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(396003)(136003)(376002)(451199024)(1800799009)(186009)(122000001)(316002)(91956017)(26005)(71200400001)(6506007)(6486002)(53546011)(6512007)(44832011)(4326008)(2616005)(83380400001)(5660300002)(66574015)(8936002)(8676002)(2906002)(7406005)(7416002)(966005)(41300700001)(76116006)(64756008)(66476007)(66556008)(66946007)(66446008)(54906003)(478600001)(6916009)(38070700005)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmZqdUpvSFBUcHpyOS8vejFKRFMwcWU2cnVzdG9rZmE1K21WZzNQMzh2U3ND?=
 =?utf-8?B?cG9vTjRtckVVdHV0ZnVYNTNWdUhBbVBoZmtGNW9rb29sRGpDa0owMXpucEdy?=
 =?utf-8?B?MWFSc3R4a3FaMUM2Uloxdlh5SXRBUmk4UTJYbjZyd1lEcHJDRkJ1UFVkaUJ5?=
 =?utf-8?B?QXZSdXJ5NmlkWm1OandrdkxZMDhMSkwySUx2cHdoQlBCL1BmeDdVSkY2YWtv?=
 =?utf-8?B?TzdIQlRXV1NKSFFKQUdRM1JOQXBJNHNxL0tJWEdZTVVhNkRscnB2NHJHMWly?=
 =?utf-8?B?ZEZIQXlJMHFrZGU3bmZSbk1tcGxEWU9uNU03YXVYbkI4aEhaTWlrRVBiTzJW?=
 =?utf-8?B?UVZwenhyU3k1K0xuNmk5N0djdEUrU3RpVm1rOWIrU2ZYZFRxSTVqalNiRCtK?=
 =?utf-8?B?ZXEyajgyK1JPTXdVbHNlWEhkTWhBSFRCMzdQaUFWZWIxL3FiS0Q4YW4rMVIy?=
 =?utf-8?B?VnV4SDB5alhDWWRVT2hMbTNETEVlUlU1MjcvYnlTVXFxYjhqUXRWaWFpcTNZ?=
 =?utf-8?B?dlBZeXZmNXZWQUZ4T2lwWndNNFJpY2xEOFNSU0hSdzlTd2JJZjZ1VFVwK2JN?=
 =?utf-8?B?NWFuNGw2ZGcrMzFqeXJvaWFVZ3BsVXdYRXNjY05hNG9xa0FzakU1dXVUTDBr?=
 =?utf-8?B?NUdIQURGclJWR1dUMkk1ZHovRk1hY3BrZGhNMDBKZDlnQUR0aWw1WnR1dk8v?=
 =?utf-8?B?R0VPd2hwTXRxWFJka21WVlBIcG5FUTYzVXNPSTljaXFOMVN4eU1oTXJITkk2?=
 =?utf-8?B?SGh3dXlnS1RzYUJPc0FqR1hhYlhaM0sxUnA1eG5CczkzK2V5c2dRZitadkVJ?=
 =?utf-8?B?ajY4Y0JBNmY1VjJMdXdyU01qQU9QUDlaSjk2bmovWkI2dVZ1cEU1WldVZkdZ?=
 =?utf-8?B?WGczK1R6eXBiMklod0xtOFRnalhNekxPUWFLQzBxdWRhQnhRcDZHbHF5Y2M1?=
 =?utf-8?B?RFRzM0UxL3BKMDh5NnJuSjRXdTJ1U0I3Y1hvZnlLZXRKLzZhVUQ2YlBORHg5?=
 =?utf-8?B?U1N2V2d5N1hJblg1bjVnUGlKQ1lvb0Vac3RNN0x5SG9DRTN5bFZjUmNuYlhp?=
 =?utf-8?B?WGlBTmcxckY4K2xFTXlHZFZmNk9LLyszUFJUUndrbHNhSXdaS3oxbzBXWFh3?=
 =?utf-8?B?VlBuaWRGVUFxV1NlUGt0b1ZwT2xiVkU3ZFJ6TDVFU3lXcmZGMzRST1VRTVhZ?=
 =?utf-8?B?N3FWbjRWNnJKYWM4V1RHY0VqVzBaSkRsUExLMHhiRWVheHhEc1FicXFDSFo4?=
 =?utf-8?B?aE93Q295UFZpVWpSTE5paXR1OGJUTlljbkRXbjIzaU9XVUQ2c1VGQTVmRWJo?=
 =?utf-8?B?VHNHWUJRZnJjWmpBdlVQaTc5ODVoSG00VUltYnZJYm13SjNSREh3Wk5Kd2F6?=
 =?utf-8?B?UktVNWN4MFBabGpyUlBvdGozejZmQjVoMExZcDBEUTM4Nk1mNHVJTnQvYXpM?=
 =?utf-8?B?UDV6WEcwYWtJY2hZMWRKU2tRR2tCdVl5cjRMdEcxM04xRzJwOW5Lb1MyakJw?=
 =?utf-8?B?TWtzZEllOFdFZEtMekpBSFdYM1hOT1MyY3NxNHJ3SHVRSDNUYnU0UERsOXRD?=
 =?utf-8?B?Y3IzUzhrN1oyNmpLd0JNNWthNW5VOWFucXgreVd6SEl3aURMS1I3YmNOQXBZ?=
 =?utf-8?B?NVljd1ZWczJhMlRVR2o2V3BlT3orWXdaOEtBWHBXNG1vUkRoUUsremtVWVk3?=
 =?utf-8?B?Z1I3T3dNdmwzbitMZTllVk5tNFNSMCtXM3B3a1pYZk5oa3ZMRXIzSmZRMTc2?=
 =?utf-8?B?NHA3d2Z6Znp3UFh5RGdyb0VscWhpd1pwWXZlYVYxUkJuZXdYL3FkQzFDZmFl?=
 =?utf-8?B?bTFJeGYyd1ljd3NrbU9RZjB1RmxEOEpwaXdNS0VmbVRnQWJNSGVSN0trM2Vy?=
 =?utf-8?B?QlFndG85dm1IdTlabFEwUHV3WWluaFVnQWU0SzVLN0VZSnZ2UUJFQWN1VGtS?=
 =?utf-8?B?WkVpa2pSaGpncXJOcEpPWWRNNUlSZFBhUmVzbnJ1SU1kU0tyVVV6UlYxeG9L?=
 =?utf-8?B?RC9vcjNrWElxQ0xJUmNwUGRRdW92TUJ6cjlLUkFFNFY1bHhOdWtzWmxJdFN6?=
 =?utf-8?B?NFg3OXpvT1dvM0N6WXZRZTdiMjdjS3ZReDhuMUpNYzQ5VVEvSEMzMmpQeHRx?=
 =?utf-8?Q?aaZ4zz1UGjI8kY5lE8eH/sE7C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA1AFA249A4EC4ABE1886A8280BAC6E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7aebb6-dddb-4ec9-32dd-08dba2062e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 05:19:22.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuWmuMrLstTr4MizdvNpNuTgaZIkeLYVfE+E5mGRYZ2Cn56mRtS8HSQO2mI44mSRSXzT5Bi276ycDFVk/VS337NnU1NmzVuPkJrhN62p3S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1557
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkxlIDIwLzA4LzIwMjMgw6AgMjM6MDYsIExpbnVzIFdhbGxlaWogYSDDqWNy
aXTCoDoNCj4gT24gRnJpLCBBdWcgMTgsIDIwMjMgYXQgNjo0MeKAr1BNIENocmlzdG9waGUgTGVy
b3kNCj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6DQo+IA0KPj4gRnJvbTog
SGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+Pg0KPj4gQSBmcmFtZXIg
aXMgYSBjb21wb25lbnQgaW4gY2hhcmdlIG9mIGFuIEUxL1QxIGxpbmUgaW50ZXJmYWNlLg0KPj4g
Q29ubmVjdGVkIHVzdWFsbHkgdG8gYSBURE0gYnVzLCBpdCBjb252ZXJ0cyBURE0gZnJhbWVzIHRv
L2Zyb20gRTEvVDENCj4+IGZyYW1lcy4gSXQgYWxzbyBwcm92aWRlcyBpbmZvcm1hdGlvbiByZWxh
dGVkIHRvIHRoZSBFMS9UMSBsaW5lLg0KPj4NCj4+IFRoZSBmcmFtZXIgZnJhbWV3b3JrIHByb3Zp
ZGVzIGEgc2V0IG9mIEFQSXMgZm9yIHRoZSBmcmFtZXIgZHJpdmVycw0KPj4gKGZyYW1lciBwcm92
aWRlcikgdG8gY3JlYXRlL2Rlc3Ryb3kgYSBmcmFtZXIgYW5kIEFQSXMgZm9yIHRoZSBmcmFtZXIN
Cj4+IHVzZXJzIChmcmFtZXIgY29uc3VtZXIpIHRvIG9idGFpbiBhIHJlZmVyZW5jZSB0byB0aGUg
ZnJhbWVyLCBhbmQNCj4+IHVzZSB0aGUgZnJhbWVyLg0KPj4NCj4+IFRoaXMgYmFzaWMgaW1wbGVt
ZW50YXRpb24gcHJvdmlkZXMgYSBmcmFtZXIgYWJzdHJhY3Rpb24gZm9yOg0KPj4gICAtIHBvd2Vy
IG9uL29mZiB0aGUgZnJhbWVyDQo+PiAgIC0gZ2V0IHRoZSBmcmFtZXIgc3RhdHVzIChsaW5lIHN0
YXRlKQ0KPj4gICAtIGJlIG5vdGlmaWVkIG9uIGZyYW1lciBzdGF0dXMgY2hhbmdlcw0KPj4gICAt
IGdldC9zZXQgdGhlIGZyYW1lciBjb25maWd1cmF0aW9uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
SGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+PiBSZXZpZXdlZC1ieTog
Q2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0K
PiANCj4gSSBoYWQgdGhlc2UgcmV2aWV3IGNvbW1lbnRzLCB5b3UgbXVzdCBoYXZlIG1pc3NlZCB0
aGVtPw0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvQ0FDUnBrZFpROV9mNis5Q3Nl
VjFMX3dHcGhIdWpGUEFZWE1qSmZqVXJ6U1pSYWtPQnpnQG1haWwuZ21haWwuY29tLw0KPiANCg0K
QXMgSSBzYWlkIGluIHRoZSBjb3ZlciBsZXR0ZXIsIHRoaXMgc2VyaWVzIG9ubHkgZml4ZXMgY3Jp
dGljYWwgYnVpbGQgDQpmYWlsdXJlcyB0aGF0IGhhcHBlbmVkIHdoZW4gQ09ORklHX01PRFVMRVMg
aXMgc2V0LiBUaGUgcHVycG9zZSB3YXMgdG8gDQphbGxvdyByb2JvdHMgdG8gcGVyZm9ybSB0aGVp
ciBqb2IgdXAgdG8gdGhlIGVuZC4gT3RoZXIgZmVlZGJhY2sgYW5kIA0KY29tbWVudHMgd2lsbCBi
ZSB0YWtlbiBpbnRvIGFjY291bnQgYnkgSGVydsOpIHdoZW4gaGUgaXMgYmFjayBmcm9tIGhvbGlk
YXlzLg0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==
