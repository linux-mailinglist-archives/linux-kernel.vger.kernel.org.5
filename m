Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960807F98E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjK0Fpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0Fpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:45:49 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95970124;
        Sun, 26 Nov 2023 21:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzkADlpYwBdxIQZkKvGEsXNleWvVYZdrWMn+2LtgbS5D5q3vtzGbq63LLzjToOTHvKZmXF+dPSvE6E5qHDMtxPQOZBuUQWlyMWWKOjzPTIob+KTIhJdirUgeyFCfKRx52tSqSiCnE0io0wkVRfF8O4KxsZFyvkADDmpZmeav/nb2/d20cOLHpC+/AUjFZ+q51NuDdWjPVFYVx6sdxdaFiQ+5VYgAlJr+Tp4owimGn3RoML9Z04Vd18Mag6gr4vcJPdWfmP19vV3EwvQs4KQ1rumezZIbLGHQICOMLEmsJ/N2a65tR7o8ugJ676HjdRnMZpx02qegTOCxHGEhlKbPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1He1AIe8gVwfcHdPJ1xuf6rTQn/3S/Q7MBx3NAb/4ok=;
 b=SopVUE0l6FcvkefrotdsGF0AmfcZInhkadcNFdOBlWFbkH2eWtqgtt/s82Gq1dgd4p9MbzKgvS9Hx3ZcVkWpTC6PP9jb0svorAualSzLa09guyRllxkSnHNUv/t5dSTGo4NMuq6cUm895kesyQG2jW3XLZlOXyljzzRZxtZImNZi018Zqv+TiSZYROD9zDFL8dG2rYynD69LF5GRbVS81V5msyJb2QYEYNMMq++YMO2UtSqR3NVzVSU/GZXsT06VvHN6k62iBBl9149u9H6uy4ry4uIzgSquKYH5cuoMU8CEc4aW/IAIcDBdKcqBgGg09WhB+DEpxp/uEnhpGQr2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1He1AIe8gVwfcHdPJ1xuf6rTQn/3S/Q7MBx3NAb/4ok=;
 b=BIF2DD/uBI6NIJ78yYI5bUu4EQT02WlR+0qlBm90HemvEmX26IN/F4ne5BMWJCLGmiS4DUl4F8LZ88WXwHtfHWfPMSg1P/zHij/Gs3O7qIs/3UGwaRSNtPoJ1G4brmp1i7P1Q7x2/Lj9feg4V57nm4xNC4cbcTQUsySSnCmNfaLTx+iou/OuENqxTh0ECveygOUjE5AbOEibmbAdrqCnw1mrqBOvVyLTfhGkWEuUdLbABw4ByMZXXA6AYSDzmPgoNyiZ7lLkjM2x6mWlV/XHx8h8QiI5cdxRHkfUo5hV1zEb3VKb/84IgFfx/fnYMr2HEqRI74cbM7oU9f7iFmkI5g==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEYPR06MB6062.apcprd06.prod.outlook.com (2603:1096:101:d4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Mon, 27 Nov 2023 05:45:49 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::55c4:990b:3f5c:b5a1]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::55c4:990b:3f5c:b5a1%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 05:45:49 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>
Subject: Re: [PATCH RESEND v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM
 TACH Control
Thread-Topic: [PATCH RESEND v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM
 TACH Control
Thread-Index: AQHaEWg/mi95vh4kakyU/BlPzwqmf7Bwvf+AgAhoGLuADcExAIAAWWVx
Date:   Mon, 27 Nov 2023 05:45:48 +0000
Message-ID: <SG2PR06MB3365CAEE9CE3F691DA1CA1E28BB9A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-3-billy_tsai@aspeedtech.com>
 <20231108182135.GA2698015-robh@kernel.org>
 <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <CAL_JsqL=2-dD5yFWWDDHu1svcCF-EMZqcYz92Pr7L5ntppNQVA@mail.gmail.com>
In-Reply-To: <CAL_JsqL=2-dD5yFWWDDHu1svcCF-EMZqcYz92Pr7L5ntppNQVA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEYPR06MB6062:EE_
x-ms-office365-filtering-correlation-id: 75a7f0a6-49ab-4a71-4a74-08dbef0c1bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2yuYAnquRS+OsUBKEGhxrBpuHtyptqnvSZ5jV1B2OveHC5ub984Oec5vNhyHhRQ7nV3DAiNV4NXQcc9ZUORX4xu3+YAYA0wlX6KVl3Ka/1W31DYOSMrGnT1uFf/5UHUfccei8IVhI9Kz/+Y+hnmXMRPnwYbVPEehuUHjLvahq8bBZH1erm9QWjyO0dRLCt2cvSvUCqrQqSnSIMOfbeJLvO6fzfeV87JE3wNNyfv45/S6BaKNvon9nHKrjsKKqY0Z9iiLDSKRGYMDo0X6TMN7w2ClrSwiFygARKcEUaFfMtuxJ7KenHgokKaHNHQGm28NiKeUS91x1gXqfdIJbRTlwg0tO+V9QYFIUN2L0cKK1KarPMpZS2vZPCIKWSCGhX3/NeZtjjvP83S+c14nDMvqoUI7HQZQV3TM19VQYJPyT4QFcYCYy4P76Ds697DUI7fUFysr76zEmdvBEc3LPtnE7RyohbFud8K+ox+JlDDndN5WvwMADHuf5ac2PBuHnLZvVki9y8zt3ydj+gbUNK1Wn9IMBqGcSd3uAKzbEjs1g9ygf5P9Slby6sr+o5lpH5shbiK7DMcoenVgOZmAUsgtSU9ed75e0GkC+7JpELZTa48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(38100700002)(122000001)(38070700009)(33656002)(478600001)(966005)(66556008)(66476007)(66446008)(6916009)(316002)(54906003)(64756008)(76116006)(66946007)(91956017)(26005)(55016003)(7696005)(6506007)(71200400001)(55236004)(9686003)(5660300002)(2906002)(7416002)(4326008)(41300700001)(8936002)(8676002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?plNvgKRUVn92ViCKiO6Ig4/GvkqKZVX6J9I802BehG7GfEV/ClKORlx+7u?=
 =?iso-8859-1?Q?1r6yuH+RKylhsO7EvKCSP06rqdNNIjd5W8+sJR1wgsNhACp97SSxH/Qqzb?=
 =?iso-8859-1?Q?ZSTqYo7akUjLCu3z0yBc+a9KQyMxNW9WOBjkZ6Mednflx2cVNDvhMF2w+S?=
 =?iso-8859-1?Q?oVjpe6nNbR4qejMO+okXIaDsEIUIPyJKaLykzhpKB92V44VQMjdwi63c4P?=
 =?iso-8859-1?Q?8fWUNrX88GBiLpPw+I6mZGcKR9vDY9rIKD2ZMUJTMq/yvgQSrZJgyCmsMV?=
 =?iso-8859-1?Q?jl/UhvpR0A8Sd7r2SY/XzY+55hlAcqP1fXu2WcsMkFAeUjsw0zlQzKAMTH?=
 =?iso-8859-1?Q?GMr9r32nuFmsqGn7eaXTicpaI0H/5i+rEBpUuAY7M5ZyrdidM2s28pDBdJ?=
 =?iso-8859-1?Q?gTWU2/tpe6RsXvbfmCMG0/srb0TTebN18+zIuAbeEE/JVsta2qfty2Ejzm?=
 =?iso-8859-1?Q?7EFyTkC5qxr4CuY1JTmv1+3ATWB0gG+GkGafpcYZng0kecKd/hAxj+zrxQ?=
 =?iso-8859-1?Q?mwYDKCYCGiQ5uyVUUpoXtIk5D9rygVq2xZ6Qj14s8JBjgj1nPpBqYXaBum?=
 =?iso-8859-1?Q?+z/JadAMdVK0smyFqgDL90D6objuVMZ08tg+etGoqoaqtp44oPwF7gD9cC?=
 =?iso-8859-1?Q?l2HBPmohJNwbujfqzwOG+vMxlhPACseAGOOlbSy4E+g6pmlfCLykmf4xBi?=
 =?iso-8859-1?Q?5+AZfo9PfwDoWYsNyCLXpK9uuXKrmGbI0oMGiS6yCLdaJjtvpW1SsF9ofE?=
 =?iso-8859-1?Q?floZeQpwFCykAABBcb4gQC4D1ctdA58xqXoNO0sDiH2+BK+FTzYyRblnAU?=
 =?iso-8859-1?Q?e5BBY+a9ZT/KqgbMITyKIlmWcwHGSGZphJ4MO96cIKfn/LAe4qr4VStezi?=
 =?iso-8859-1?Q?l71BTuwjE0eT1ZzNl1WKO2QrmT6eoR6kVUU28F/LqtwQ+xHjZ21sfTUnpk?=
 =?iso-8859-1?Q?IwpblTWYbIpiRAPjNRzFE0Kj9/6iPWG36naDjlefh9J5xEWTG7Fogr93R9?=
 =?iso-8859-1?Q?xJntXIS8CLsJAGjpPU9KkdoUyEtDWFCuImcEqJeJ1rxAlsqZC12RvxU04R?=
 =?iso-8859-1?Q?Ez3LYUCdFbO4rOvxvzE5nP0my0aj2P3hC2Ny2AHiGVqAPVpzs98ADfts9o?=
 =?iso-8859-1?Q?wbFkfT7UfMcy7nJfofo8HTbfu9JqpdRzs8Y7HOzRQsg3FppqJgaGqUoXwW?=
 =?iso-8859-1?Q?J9qjDLLw1opfESolxfRcFwTzXNWx0yh2CYKggL+hxhuwYc/kepNaIaJ/8w?=
 =?iso-8859-1?Q?bL9XBVsOkFJUGpSb5xCAlumRhqc9ig51XmCMFu2/mGpfLfGlVZyztTrD7U?=
 =?iso-8859-1?Q?aq0aKD1rUfSO/Un4GadsK1VIW61n9HdUeO75X8nB8WpfjSuV00mRQtCakJ?=
 =?iso-8859-1?Q?E5vMgC+fNrKWBcLI0NjHpmIugfbbYeynnK6U4khN2X+8fb1E5r7/HiMPqv?=
 =?iso-8859-1?Q?07xXqQsoMHJlte8zb/iy+9h97edxddcRtdu7hEozdSATQtiARd/dBSXMou?=
 =?iso-8859-1?Q?iWdCzxkAgf7/QoZU5aw561nSzhyL8oe4rIsc4d/WIHLRrvoUzPGaad6o5S?=
 =?iso-8859-1?Q?hcW9ajTSj/R7BcYJrAoDb8+JWpz6My5V+Pt0FZ3hC/xsvE6qaqHSJTdyui?=
 =?iso-8859-1?Q?Z5n3dKVV6MoBLpr9CGwtoRWvQ93bBwkqvi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a7f0a6-49ab-4a71-4a74-08dbef0c1bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 05:45:48.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzdsqUIkQu2XfkFtPswWaxUG3WB0yIm4vu4aV3q9cfqw0C68ekyE2C30nUhZnehrLQO+XCBwtEQuuKl7FpcmcST6y6TlsrZjS4bqFlnDcI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6062
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Document the compatible for aspeed,ast2600-pwm-tach device, which c=
an=0A=
> > > > support up to 16 PWM outputs and 16 fan tach input.=0A=
> > > >=0A=
> > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > > > ---=0A=
> > > >  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++=
++++=0A=
> > > >  1 file changed, 69 insertions(+)=0A=
> > > >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,=
g6-pwm-tach.yaml=0A=
> > > >=0A=
> > > > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-=
tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=
=0A=
> > > > new file mode 100644=0A=
> > > > index 000000000000..c615fb10705c=0A=
> > > > --- /dev/null=0A=
> > > > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.ya=
ml=0A=
> > > > @@ -0,0 +1,69 @@=0A=
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
> > > > +# Copyright (C) 2023 Aspeed, Inc.=0A=
> > > > +%YAML 1.2=0A=
> > > > +---=0A=
> > > > +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#=
=0A=
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
> > > > +=0A=
> > > > +title: ASPEED G6 PWM and Fan Tach controller=0A=
> > > > +=0A=
> > > > +maintainers:=0A=
> > > > +  - Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > > > +=0A=
> > > > +description: |=0A=
> > > > +  The ASPEED PWM controller can support up to 16 PWM outputs.=0A=
> > > > +  The ASPEED Fan Tacho controller can support up to 16 fan tach in=
put.=0A=
> > > > +  They are independent hardware blocks, which are different from t=
he=0A=
> > > > +  previous version of the ASPEED chip.=0A=
> > > > +=0A=
> > > > +properties:=0A=
> > > > +  compatible:=0A=
> > > > +    enum:=0A=
> > > > +      - aspeed,ast2600-pwm-tach=0A=
> > > > +=0A=
> > > > +  reg:=0A=
> > > > +    maxItems: 1=0A=
> > > > +=0A=
> > > > +  clocks:=0A=
> > > > +    maxItems: 1=0A=
> > > > +=0A=
> > > > +  resets:=0A=
> > > > +    maxItems: 1=0A=
> > > > +=0A=
> > > > +  "#pwm-cells":=0A=
> > > > +    const: 3=0A=
> > > > +=0A=
> > > > +patternProperties:=0A=
> > > > +  "^fan-[0-9]+$":=0A=
> > > > +    $ref: fan-common.yaml#=0A=
> > > > +    unevaluatedProperties: false=0A=
> > > > +    required:=0A=
> > > > +      - tach-ch=0A=
> > > > +=0A=
> > > > +required:=0A=
> > > > +  - reg=0A=
> > > > +  - clocks=0A=
> > > > +  - resets=0A=
> > > > +  - "#pwm-cells"=0A=
> > > > +  - compatible=0A=
> > > > +=0A=
> > > > +additionalProperties: false=0A=
> > > > +=0A=
> > > > +examples:=0A=
> > > > +  - |=0A=
> > > > +    #include <dt-bindings/clock/aspeed-clock.h>=0A=
> > > > +    pwm_tach: pwm-tach-controller@1e610000 {=0A=
> > > > +      compatible =3D "aspeed,ast2600-pwm-tach";=0A=
> > > > +      reg =3D <0x1e610000 0x100>;=0A=
> > > > +      clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
> > > > +      resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
> > > > +      #pwm-cells =3D <3>;=0A=
> > > > +=0A=
> > > > +      fan-0 {=0A=
> >=0A=
> > > I assume there's a PWM connection here? How do you know which PWM? Yo=
u=0A=
> > > said the tach channel is independent, so it is not that.=0A=
> >=0A=
> > > It should not be 0 from 'fan-0' because that's just a meaningless ind=
ex.=0A=
> >=0A=
> > > You either need 'pwms' here or you can use 'reg' and the reg value is=
=0A=
> > > the PWM channel.=0A=
> >=0A=
> > Hi Rob, this binding is used to export the PWM provider and the Fan mon=
itor (i.e., Tach).=0A=
> > If the user wants to add the PWM connection for the fan, it can be done=
 as follows:=0A=
> >=0A=
> > fan0: pwm-fan0 {=0A=
> >         compatible =3D "pwm-fan";=0A=
> >         pwms =3D <&pwm_tach 0 40000 0>;=0A=
> >         cooling-min-state =3D <0>;=0A=
> >         cooling-max-state =3D <3>;=0A=
> >         #cooling-cells =3D <2>;=0A=
> >         cooling-levels =3D <0 15 128 255>;=0A=
> > };=0A=
> >=0A=
> > This will reuse the existing PWM fan driver (e.g., pwm-fan.c).=0A=
=0A=
> I'm confused now. So what are the child nodes you have? You are=0A=
> defining the fan in 2 places? The "pwm-fan" driver supports a tach via=0A=
> an interrupt, so how would this work in your case?=0A=
=0A=
Hi Rob,=0A=
=0A=
The tach interrupt for the pwm-fan is option. In our case, the dts just reu=
se the pwm control function=0A=
of the pwm-fan, and the part of the tach monitor will be created by our fan=
 child nodes.=0A=
So the dts will like followings:=0A=
=0A=
// Use to declare the tach monitor for fan.=0A=
&pwm_tach {=0A=
        fan-0 {=0A=
		tach-ch =3D /bits/ 8 <0x0>;=0A=
	};=0A=
	fan-1 {=0A=
		tach-ch =3D /bits/ 8 <0x1>;=0A=
	};=0A=
        ...=0A=
}=0A=
=0A=
// Reuse the pwm-fan.c to control the behavior of the PWM for fan.=0A=
fan0: pwm-fan0 {=0A=
        compatible =3D "pwm-fan";=0A=
        pwms =3D <&pwm_tach 0 40000 0>;   /* Target freq:25 kHz */=0A=
        cooling-min-state =3D <0>;=0A=
        cooling-max-state =3D <3>;=0A=
        #cooling-cells =3D <2>;=0A=
        cooling-levels =3D <0 15 128 255>;=0A=
};=0A=
=0A=
fan1: pwm-fan1 {=0A=
        compatible =3D "pwm-fan";=0A=
        pwms =3D <&pwm_tach 1 40000 0>;   /* Target freq:25 kHz */=0A=
        cooling-min-state =3D <0>;=0A=
        cooling-max-state =3D <3>;=0A=
        #cooling-cells =3D <2>;=0A=
        cooling-levels =3D <0 15 128 255>;=0A=
};=0A=
=0A=
Thanks=
