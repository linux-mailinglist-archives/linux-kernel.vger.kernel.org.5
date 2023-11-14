Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB37EA8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjKNDLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:11:44 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7EC6;
        Mon, 13 Nov 2023 19:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laKES9lCiY0FAgIW2lHQM+FbaAGmTrCo4w4ygOYiY53Am/OJWO6vsXLKcAMHSZ/26qCj+whdJlb4ij3QiOxaMN1FTUEjpBh/8Zd0hp/FPRBZsT6ChocrBbWawGgWDj6/aR+aDa2UZRmh8PUegsIHCYuJOZrjxOQJUXcD5Ta6ZRpxwktHbxJjq/uaWWfSOgzGruA+1mc6IAMytgxt0rejLKQOH26dDlApdwFkw3YIrcLVbRZ7YODQs5dbI/QEpfzVuL83g7hsscV5/I57wGzZ3hwOG9f80vr2Dx9/GgXgogkIB5MpgJRxr9Ux1zmoVMyGKNONCwg11l3o0WalsFj2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzdalqJNtxjQvaO258dry07v1vv78cXwSN1HKIAeUAQ=;
 b=nPo6MLBkcu53DfMzaF4eJUQnc8M2mkHCTvpIbg+yeOnXH0AcbHCospRjvFTld9LYBnpkSDlpWXxkTTGFAXkLQ+o4rfmMKMxvczrbheBnPiiCjKyEeqWvTa01KFfKdPzHRgeKw/u3AgRzXcmGsRAOsmuOvbkRNokRZAMiTzy9fXsbbU0i7j4fcXASC+3BaGjoH1/FwcpnbMLMLwFDGucWy639IDrsP01v6EX7+ZlpHbLUOGBFDEq/1rH4IWS3UtTnAslCiM6BGcBtF9lWx0U4/7dSgRvvfPzFEmi81YQYkX5GfAIuqShzaZhK7W885Nr0kS0+1u+vmJEbwOR8cUwiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzdalqJNtxjQvaO258dry07v1vv78cXwSN1HKIAeUAQ=;
 b=REGGdo6fITtQVxqCCvZdr8Jk+dr5mG07k5J/Ds9dnKzqqOHRJgMSY3BtzNbfXaH83TmZy/AnP/gyGY+K5NOH/lDpjQ8t9qpcBRJOMiMiCp+Kf1LDrWR3SlRg39iVxRbtenWcE2Hn4ugvcRpyZQIa5/w5MAXlQOR8BC/NRTEwKsUEs1kFkJOZhaE2lSvjTjnT+fdb2EZjz4lYTrymO9Woe3SyQJotpGwwP+yvowm/g7AHCVDZAYXwx3UQVBcqIpdUR0MFOY97rBswUYEGO0bm/5y82d3KdJo0jIk0PtCfbSh5SOPUWSNtTHBXfW9SN9gWOgxV2YSA2PDKQ4sx84bFaw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 14 Nov 2023 03:11:34 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::de7a:8c69:a408:f461]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::de7a:8c69:a408:f461%2]) with mapi id 15.20.6954.037; Tue, 14 Nov 2023
 03:11:34 +0000
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
Thread-Index: AQHaEWg/mi95vh4kakyU/BlPzwqmf7Bwvf+AgAhoGLs=
Date:   Tue, 14 Nov 2023 03:11:32 +0000
Message-ID: <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-3-billy_tsai@aspeedtech.com>
 <20231108182135.GA2698015-robh@kernel.org>
In-Reply-To: <20231108182135.GA2698015-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEYPR06MB6524:EE_
x-ms-office365-filtering-correlation-id: 6b4ccdae-c3ee-422c-ee90-08dbe4bf677e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1bclLkQQf2B1QhnVJdV3xD+jABMRU3+xVWWBd2JzRsEmhQWG8vokOyyKq9/KW3CU936bZm2sWxh1EtHqmXiBGuukYswyB76fdBC4zFh7TMe3Vx9RyPzlo8MOdQeUyGrrUQiCnGHkS2ft2NP9VqoVMcB+u57aMU5LbgyWcFjRkDd34YNEefpAIaYq3lr96WHsZYRga03LDBvgnuw4VXZnjwzTO4qeoS3xYnQXhTXy9vNTEbtva8Uu0yTFaS6p91912xAXy+oT+QtGLYVo0UBBrlljv8FEADhc/bVQzzyN59pd3Q6sF1U3JwymvDz2mwrf7jdLiyapWosvi7ysGrQvAemWZR0xL+U+RKWsz2d44afikbSr0tUIouTKomqJTHi+RukzMx9aXtJhkjVLIHpFeoI7SD/oKxPrfB3cCTNRY22pfOBpRe85jS47Tshn7L8WiEP0wSzlvcg/8zqOLwRejvGKswVtkjjshRvzy6iYjxOJfeoRUYBt09UiN2gya9WJdzguNz7NtgKMJKTZTqAdXufnPdOJZd3lFUZcPr1FNR6lK81Oh4RSnceGkpIAiCplS4Ls8K5Dq2jlacXgrAfp3e64Z183VWc5dcFJ3BgXhgZC7FTatW1qWJmHfUSvwL/MWXWLQ1zh/cc2oG8gen5xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39850400004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(76116006)(83380400001)(9686003)(55236004)(6506007)(71200400001)(26005)(122000001)(66476007)(66946007)(316002)(8936002)(64756008)(86362001)(33656002)(4326008)(6916009)(66446008)(7416002)(41300700001)(8676002)(66556008)(54906003)(7696005)(52536014)(2906002)(478600001)(91956017)(55016003)(38070700009)(38100700002)(966005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/CRFV17FynRYarZ7ryCEk2iUQirrdF9PeX4kfmoERGEMvnavgMquyCLle9?=
 =?iso-8859-1?Q?p2fsNLJi9aMCgmb4lwdd3HvyOmQdS7ZWJlAwEU7BpPaFNT4F+WbMlgXBnv?=
 =?iso-8859-1?Q?Mc1YwsdPnjLilDsBk6ybbZBGpTKIt00koo0lX2Zi8zKD+eMbwMKmUWmPCC?=
 =?iso-8859-1?Q?SRW6mr6Qfu+yGgLjy2fx0f+k8xNalSKBhSauZw6VwCZ7kVvbWWj7+Pa3YS?=
 =?iso-8859-1?Q?1exvPLD6Cxx5lcryg2WLV/tsqHyOjF7WPuWLBqyS5xvX/oPYBdn1nMGSua?=
 =?iso-8859-1?Q?wZYNZcA+LBcWxzN7tnDSdz2yrW37g78VRYhkzYfleFwVvluDvwAybhAIag?=
 =?iso-8859-1?Q?ujS/VTYZc1lIzx2kKZvcQBZHW+9+bX2to0GzJEHYmycS17DcgGJF+oLEku?=
 =?iso-8859-1?Q?dXlHz71nN0TYoLxhVJjm/o8R/4uN6K2xtoztzugXy5F63GOdsbDCxQrfdJ?=
 =?iso-8859-1?Q?cAnkAROWYiRlf2aS6M1BhLXocHML1lOrlHXvWpEjVWMHIHS7PtD4gqXJCm?=
 =?iso-8859-1?Q?LabY+vfOgem+RBJ/NpMU2eF5HUfnKNN03To5nEVkKOjUZ1u8R04Jg+mCkf?=
 =?iso-8859-1?Q?WjKvNLyYcFi/EY2KnPhaFy3gtmYi/Dv/O0CkWNuHRpSlEk0QBLLE5J2wfN?=
 =?iso-8859-1?Q?M/yH2bAfbksw9uNCQyfeAMPy5sjrs/2z/njhZFAorU0kPxdN8r7dn+CIOe?=
 =?iso-8859-1?Q?OepInThyZUHjEGR2oAtM3Pz4cxBc7IE02+9RekGoMazMg05kBOXcIL035b?=
 =?iso-8859-1?Q?c6qKGvsnYBGBznaT1jVnlDsM5zkSHs7ootfLSHPtB8LRgofctE84abzXeB?=
 =?iso-8859-1?Q?92McoBOgwrZ5i4gHdSXd33qI2KnYMX7t7SAs6FUqN3U75YcCNfxoTPqQvs?=
 =?iso-8859-1?Q?nfkvJNpJhjPopJ8Nu8ldONPiXNH0Zyc114dnSeIto5+XQvXrF8qopAp2GP?=
 =?iso-8859-1?Q?QgYVGEbYTjO4sa9wF1JLbMH9TvlMccSCjE2qbqhowpFMJvmgHGfPdSUNDn?=
 =?iso-8859-1?Q?oHiOo09ErWxRmjf1xzf2ItlBnH/mQVOldDEf36vwEgCVBsNMw2gI3JigG2?=
 =?iso-8859-1?Q?y/c1t3NSx5dCJlAbB02ljvlzVGH0tsfzAECrkhrqXcpogANQSoXlOqzPj8?=
 =?iso-8859-1?Q?7brxgm3t7GfqlKb7b5vNclRDazoQwYDH05pc5JOQPRT8dh+TmM5lqijXfS?=
 =?iso-8859-1?Q?zPWBfBdrZbzVOMt7EnOxz0/ZXRw5RPDAa3lawKtiaYYZqFkC6xBeanD5Gz?=
 =?iso-8859-1?Q?kyxOmDiBayA8hrEMfWefw1bo1Bz6qdxtIcq22ftIM7YzSBgRwpZnU6S2qX?=
 =?iso-8859-1?Q?Jax0IJH4ebxskUvRjN37pQsVxwuS1qw11heTDD78UfNFmNGSIzWI9lJau0?=
 =?iso-8859-1?Q?9eJHok9t+Hccqa0CCfKESPp4EGZRuLrIWhdd+w/zisLrkojwMgP8ry7Tov?=
 =?iso-8859-1?Q?NJdhpCHYe7OmOUvszdKie7u0+TkvQ8abGEJ1TIZLIRdGXq5wFOO9cYeWu+?=
 =?iso-8859-1?Q?dnK+ceWQEVhxSq+3+4WLkwZ297XNb0pHsA5jzmRCZKhr65/54o4KigfgKS?=
 =?iso-8859-1?Q?e3rebqbFGPyq2uFvP6btpCmb2kTZkKtJETM2Lwfi3fJhAW37b8W8auB2W3?=
 =?iso-8859-1?Q?gtsQMIN+YZeUl2o8AekO3JMuyq2jJEEx/7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4ccdae-c3ee-422c-ee90-08dbe4bf677e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:11:32.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbXee4Z44Fcx5uRv8QjNuoBVklpE9hF434vl7iv6dGZESWq9N5YALDjdUUhmrW96q2N6rbXjNGfYgK5CqiAxR7cCPLS1Cbs+/0A1jwQXdc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Document the compatible for aspeed,ast2600-pwm-tach device, which can=
=0A=
> > support up to 16 PWM outputs and 16 fan tach input.=0A=
> >=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > ---=0A=
> >  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++=
=0A=
> >  1 file changed, 69 insertions(+)=0A=
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-p=
wm-tach.yaml=0A=
> >=0A=
> > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach=
.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=0A=
> > new file mode 100644=0A=
> > index 000000000000..c615fb10705c=0A=
> > --- /dev/null=0A=
> > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=
=0A=
> > @@ -0,0 +1,69 @@=0A=
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
> > +# Copyright (C) 2023 Aspeed, Inc.=0A=
> > +%YAML 1.2=0A=
> > +---=0A=
> > +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#=0A=
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
> > +=0A=
> > +title: ASPEED G6 PWM and Fan Tach controller=0A=
> > +=0A=
> > +maintainers:=0A=
> > +  - Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > +=0A=
> > +description: |=0A=
> > +  The ASPEED PWM controller can support up to 16 PWM outputs.=0A=
> > +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.=
=0A=
> > +  They are independent hardware blocks, which are different from the=
=0A=
> > +  previous version of the ASPEED chip.=0A=
> > +=0A=
> > +properties:=0A=
> > +  compatible:=0A=
> > +    enum:=0A=
> > +      - aspeed,ast2600-pwm-tach=0A=
> > +=0A=
> > +  reg:=0A=
> > +    maxItems: 1=0A=
> > +=0A=
> > +  clocks:=0A=
> > +    maxItems: 1=0A=
> > +=0A=
> > +  resets:=0A=
> > +    maxItems: 1=0A=
> > +=0A=
> > +  "#pwm-cells":=0A=
> > +    const: 3=0A=
> > +=0A=
> > +patternProperties:=0A=
> > +  "^fan-[0-9]+$":=0A=
> > +    $ref: fan-common.yaml#=0A=
> > +    unevaluatedProperties: false=0A=
> > +    required:=0A=
> > +      - tach-ch=0A=
> > +=0A=
> > +required:=0A=
> > +  - reg=0A=
> > +  - clocks=0A=
> > +  - resets=0A=
> > +  - "#pwm-cells"=0A=
> > +  - compatible=0A=
> > +=0A=
> > +additionalProperties: false=0A=
> > +=0A=
> > +examples:=0A=
> > +  - |=0A=
> > +    #include <dt-bindings/clock/aspeed-clock.h>=0A=
> > +    pwm_tach: pwm-tach-controller@1e610000 {=0A=
> > +      compatible =3D "aspeed,ast2600-pwm-tach";=0A=
> > +      reg =3D <0x1e610000 0x100>;=0A=
> > +      clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
> > +      resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
> > +      #pwm-cells =3D <3>;=0A=
> > +=0A=
> > +      fan-0 {=0A=
=0A=
> I assume there's a PWM connection here? How do you know which PWM? You=0A=
> said the tach channel is independent, so it is not that.=0A=
=0A=
> It should not be 0 from 'fan-0' because that's just a meaningless index.=
=0A=
=0A=
> You either need 'pwms' here or you can use 'reg' and the reg value is=0A=
> the PWM channel.=0A=
=0A=
Hi Rob, this binding is used to export the PWM provider and the Fan monitor=
 (i.e., Tach).=0A=
If the user wants to add the PWM connection for the fan, it can be done as =
follows:=0A=
=0A=
fan0: pwm-fan0 {=0A=
        compatible =3D "pwm-fan";=0A=
        pwms =3D <&pwm_tach 0 40000 0>; =0A=
        cooling-min-state =3D <0>;=0A=
        cooling-max-state =3D <3>;=0A=
        #cooling-cells =3D <2>;=0A=
        cooling-levels =3D <0 15 128 255>;=0A=
};=0A=
=0A=
This will reuse the existing PWM fan driver (e.g., pwm-fan.c).=0A=
=0A=
Thanks=0A=
=0A=
Billy=0A=
=0A=
> > +        tach-ch =3D /bits/ 8 <0x0>;=0A=
> > +      };=0A=
> > +=0A=
> > +      fan-1 {=0A=
> > +        tach-ch =3D /bits/ 8 <0x1 0x2>;=0A=
> > +      };=0A=
> > +    };=0A=
> > --=0A=
> > 2.25.1=0A=
> >=0A=
