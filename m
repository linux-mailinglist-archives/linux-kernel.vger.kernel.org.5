Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504087B9994
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbjJEB1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjJEB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:26:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C994D8;
        Wed,  4 Oct 2023 18:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KieloMr7msAi/kRXM10L0MakpZ3NJS4olFuwNCV+oY47f8cEmZLMIuEzam9AsNUM+k+eVbAh4RYNm/tzioCQ+j2riwRQGEupP2T3OOAnEVubHEjF7hov5KXxQ4AkTcu/9bjDfM4zVGLpks7hezo/RsdUOgCV+bxEgyqlO7FHJjlK2en3+R//lmS5mAnXAq7oFjCXsE12C7ANiap+O2xBfIIwsb6Fuscz5pSuoVmEel+3RyH/xszl0mkS8D8qzdZ/SqhTK5czXKBkwLsJ6ykr4Y0p7Ev8tB/4wvMXiz46pV5y6orsU9590kfIgxcVogtOEL4ln/4XdGG5UmB/dMfvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noo/fEzBt1fE2C1J8OnDvTdtPkofJlbXwvy1xaBOZic=;
 b=kELIoEHfKYiLpyfiUHiuB0YmuTirVm9tF1LEIsAyJueBSbZc1wZSKbdL2c0cfiUmuSFMPHEeQv15JnNuZ+JfSI94k7+QW680GIGdZr8AWkq216jPFCLTfvCVQHxOWVtcxFtuhMxAxCN309b8cVHq76U+7MulRxJOEEw2ZAYop9kF9z+g4wIx6e5r4an0K+09IbJq3B9Y6KndbHJI1uCh5rzi+FtEY4L/xqDvGcynyVU6K2bM8YxpUtOGuFOx3wDJXR2wmgnzDDew1f8//aNZSbU7Os6EHqgNGQ6FqisBTeE9OGxBO2ES+kkb+jmTqB2nMEGJe94dEVTscK7x3cRMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noo/fEzBt1fE2C1J8OnDvTdtPkofJlbXwvy1xaBOZic=;
 b=bQzuYddDZedRVxiouZy+LdPJpbhjtor8CmxuwR71r6qkonygoSbky/m2wb81++EtNaTzwnYjp9LmJbaxwLcOz0E8hBOQxuCPCBoqoQ83IMMeTGwzp81UW9bTuIH5QxIGJ+NPaqls1DdGiWLpgfLySr7PZUovYo0aT2VFQ52bIilnTRnNg0bKVk/XynS8DOea8FRTNEtGmS7bcwE0sqr0KZyDCJ5gYkqkjMmx/lwHfc1OlG10/GPdXZyFgEavxs/YXNShOZSR/QkpvPEMNurMGa6ipJeILx2/cvtzzPfbjpjWAZ8op0+wwPCnUcwPLrFWneZUcVXOocHUqbN5nJJ3vQ==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEYPR06MB5648.apcprd06.prod.outlook.com (2603:1096:101:c0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Thu, 5 Oct 2023 01:26:46 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 01:26:46 +0000
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
Subject: Re: [PATCH v9 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Topic: [PATCH v9 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Index: AQHZ6fsiTLYVIVnDjUKnszXE1xHHwrA2ti6AgAPFqCE=
Date:   Thu, 5 Oct 2023 01:26:45 +0000
Message-ID: <SG2PR06MB33650A58039DF915E4E868E68BCAA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230918064111.2221594-1-billy_tsai@aspeedtech.com>
 <20230918064111.2221594-3-billy_tsai@aspeedtech.com>
 <20231002152819.GB1747496-robh@kernel.org>
In-Reply-To: <20231002152819.GB1747496-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEYPR06MB5648:EE_
x-ms-office365-filtering-correlation-id: fd25256c-f524-46dd-0e0f-08dbc54223aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FD25v1BddKoQXWF4XhVSoYWiaftdubRg3vIAQCC3GpJZgxAlw6oiInMz1VxFDyPzk04f3xqmu3crsnL4ShJn1hlujo1DRLEltsOULngJwiuGj++AJnGuMyv7imEA6pitzDLdNbiuA+uW9N7++6ULH0/ZbQeKRn52LPZJFAdku8SlI2VQIexhObj4C0KZ6EUJVpnJFTZOApuLp1uvIYH8/DHC/YKC04ycpFbNQ+etdybFSZgdAXKPhTwWC4pCryxpDYBQAfUmE7dTGXyFhLMkeRnpzgKuWLGHZO/piPDu0oa/D5c8tgWS75vH2Ci3WPmDaOo4M5iwlPhhPZ3g3exs3B/TQoAfGHgp11zU/EmaALllrC5Loq6HNieIsBK2Qnf9X967XI6+XhyA9XZRb/ogmdcosmiN3ILWuoesGMCllbl9u57EL3CNojS0MBTbuRDzNa3r7YBUmM4+wqzdESENCn9mhVCvw/dP0CxiubeNyZTC20q8sX4+rOfT/NdX77Lqwk4hBJ/Z4SeUelVIDYES0ZmXS01Wosuua9olyi3+x/ZMkQnTH3sd1zc9UVVHcGgxXxP8QHh/r4PdWcet96uNRaoT2X0SdhZJX5ukcvENFYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39850400004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(9686003)(55016003)(6506007)(478600001)(966005)(7696005)(71200400001)(86362001)(122000001)(38070700005)(38100700002)(2906002)(7416002)(91956017)(41300700001)(6916009)(316002)(83380400001)(26005)(54906003)(66946007)(66476007)(76116006)(66556008)(52536014)(33656002)(8936002)(8676002)(5660300002)(4326008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0gqIfTS5scHL7t1hTYG3Y4L2aCvp27cZrdnOyXg4lxjP5RBL+5qh3/AWb+?=
 =?iso-8859-1?Q?iavrfKPgRKapcyXgYMNzjcFy33IWij1gpmftcrHzS7ZIR4ejK+La/5ZWi6?=
 =?iso-8859-1?Q?67j1eShZw8lx6Mcmqgj/75xKOcmatzDUsQWMrs1WMdiTPTI7B8rFCf8+LD?=
 =?iso-8859-1?Q?+UBrLM7HGgY8KJBmQyKjVG4ZMtL4OOs6/H1gqp88IvzhXOunAAyfeOMpaO?=
 =?iso-8859-1?Q?vrRgj93UKUZ22U5VILhAc0mr1jlcURGmo+NU3NsuaoKs9V93LMNlmDY+/d?=
 =?iso-8859-1?Q?0RNOZmTK3tpHf/YtgobDh0CVOoCElY/Xum8uc74DVFAEtQQPtmRXCyIxXg?=
 =?iso-8859-1?Q?onzMRHRYz/ZTpIDaogM9VaWeNuTJjKtnGPHHUCIUY9MMFmRT46nEIIuypp?=
 =?iso-8859-1?Q?o2X5OkmLUiFw68K6L5skXBib48XxzWUKCFWsQJRu2YQ/PxJ73eSgd3nvX4?=
 =?iso-8859-1?Q?EM8HFIzXAQA47ur+HcUorcpwdc49aZLC+tSuhF9LwDs8Pzs4BzcD4EbDiY?=
 =?iso-8859-1?Q?+VNph5FLBhbgAtR7LBGCY5TXFmnnDCLX1Ly8e2kX8y+HCFGClF8Fj22zwJ?=
 =?iso-8859-1?Q?fOAetJay7bOj+tKBynMTrVx47SHkq1hYwThcq7oZruxxq4oHV6YztnBeVk?=
 =?iso-8859-1?Q?Ku2eliS4Bu6P3KgWFRKazz7SFdwsh52GtRCISfRU01pDZim+x508C+p48z?=
 =?iso-8859-1?Q?pnfcbA0PWHBtBuHo/bUnjWgxCrV717gHQ2Edrw2YnZuvdNz9dynfWVGlrt?=
 =?iso-8859-1?Q?TrRQxELSAUFRV9kv4C4kDuG+VPeE9q9AOT9gpxDIRmwRQW0FJ5bD5elXJc?=
 =?iso-8859-1?Q?umAsq4jYx89r3kWnkwtYLpPYC4vl0pM4P3uU/Mzj0I2fyVOFdIdyfn+yrc?=
 =?iso-8859-1?Q?Ph8hEomKmAL1yrNWC2hv1Zlul271BzWT9qtPq6204vS3JhtRJ577OH/at7?=
 =?iso-8859-1?Q?07GVXRMlPiBzgY75cQZ4VHrEdCzgAyLBU2Gw3wGgLh9sYzStYqDofyOsKx?=
 =?iso-8859-1?Q?bOdcYC40E949Y67HNPt7MgSWtZJKztnkwq6mHCUo2bEIOVYxJtRh2r5y59?=
 =?iso-8859-1?Q?A1UpkcuLSBXkKDdLCp1C25FaVsn8pn7A7KO2ePwUxDjcXT7l45r8uVueUG?=
 =?iso-8859-1?Q?jUeDrDJzJnT1HNp8JmG67rf1n4qICTgBjGjzqYdjrS5RPqtutis/lXEL5K?=
 =?iso-8859-1?Q?IRZkb8+uYPyzhCtkC2WMUoS/dA/yal7/PWFbSp9H1ZmCe3JTexTGhZsO3u?=
 =?iso-8859-1?Q?B95YqXz+ITuwunnTpf5zU5kc5znd19ofgbpIPYtTdSROPB4gAjqzl90apx?=
 =?iso-8859-1?Q?6eVcjFhudE4/IODXjaOC9WJg9KQdZJUndz8BoIWArjGxMtyrA93aRvmP6o?=
 =?iso-8859-1?Q?JkpYfvc8zNh2D7DRi/FYUzcE+3PfsaXjX5FUmrynIrPLvVsmlzgCOcDldF?=
 =?iso-8859-1?Q?BHNn97z+OdLsl+/fbJ1DSMI888aPC9K9RpcNkpWJUO9OPcDJIWaJ9Ka6ND?=
 =?iso-8859-1?Q?dFhFjBcoXZZcyuBOqhLT9F9lgkt9YfY/io2tKMULb5GMWmBwbcCHUwY7FA?=
 =?iso-8859-1?Q?7Q42DB0uhnmItQ3CiohobOFLlCGajFCc4U5pHQRiNATQk7K6jDFCxO2fAD?=
 =?iso-8859-1?Q?TXIfJJu7+zg7+xu1g+yU0VxRhEBCXGcknM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd25256c-f524-46dd-0e0f-08dbc54223aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 01:26:45.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iy8IpYEJzb+RPXwDTe2T5MorytOpwspc8bezfasxT4J0mk+GX1QkAehqQTXRCdhMF14Bsfk/cvDpIiwlLHWMTZ8lc6TqgexCBNUVOKDvstY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5648
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Document the compatible for aspeed,ast2600-pwm-tach device, which can=0A=
>> support up to 16 PWM outputs and 16 fan tach input.=0A=
>>=0A=
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> ---=0A=
>>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++=
=0A=
>>  1 file changed, 69 insertions(+)=0A=
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pw=
m-tach.yaml=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.=
yaml b/Documentation/devicetree/>bindings/hwmon/aspeed,g6-pwm-tach.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..5a679f4ad2fa=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=0A=
>> @@ -0,0 +1,69 @@=0A=
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
>> +# Copyright (C) 2023 Aspeed, Inc.=0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#=0A=
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
>> +=0A=
>> +title: ASPEED G6 PWM and Fan Tach controller device driver=0A=
=0A=
> This is binding for the h/w, not a 'device driver'.=0A=
=0A=
Okay, I will remove the 'device driver'.=0A=
=0A=
>> +=0A=
>> +maintainers:=0A=
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> +=0A=
>> +description: |=0A=
>> +  The ASPEED PWM controller can support up to 16 PWM outputs.=0A=
>> +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.=
=0A=
>> +  They are independent hardware blocks, which are different from the=0A=
>> +  previous version of the ASPEED chip.=0A=
>> +=0A=
>> +properties:=0A=
>> +  compatible:=0A=
>> +    enum:=0A=
>> +      - aspeed,ast2600-pwm-tach=0A=
>> +=0A=
>> +  reg:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  clocks:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  resets:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  "#pwm-cells":=0A=
>> +    const: 3=0A=
>> +=0A=
>> +patternProperties:=0A=
>> +  "^fan-[0-9a-f]+$":=0A=
=0A=
> foo-<index> naming is decimal, not hex. (unit-addresses are hex)=0A=
=0A=
Okay, I will change it to the decimal.=0A=
=0A=
> But if 0 and 1 correspond to something in the h/w, then you should=0A=
> probably be using 'reg' instead (which means a unit-address too).=0A=
=0A=
The number doesn't unrelate to the hardware.=0A=
=0A=
>> +    $ref: fan-common.yaml#=0A=
>> +    unevaluatedProperties: false=0A=
>> +    required:=0A=
>> +      - tach-ch=0A=
>> +=0A=
>> +required:=0A=
>> +  - reg=0A=
>> +  - clocks=0A=
>> +  - resets=0A=
>> +  - "#pwm-cells"=0A=
>> +  - compatible=0A=
>> +=0A=
>> +additionalProperties: false=0A=
>> +=0A=
>> +examples:=0A=
>> +  - |=0A=
>> +    #include <dt-bindings/clock/aspeed-clock.h>=0A=
>> +    pwm_tach: pwm-tach-controller@1e610000 {=0A=
>> +      compatible =3D "aspeed,ast2600-pwm-tach";=0A=
>> +      reg =3D <0x1e610000 0x100>;=0A=
>> +      clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
>> +      resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
>> +      #pwm-cells =3D <3>;=0A=
>> +=0A=
>> +      fan-0 {=0A=
>> +        tach-ch =3D /bits/ 8 <0x0>;=0A=
=0A=
> What about the PWM connection?=0A=
=0A=
I only want to create the fan monitor without fan control.=0A=
So, the PWM connection is unnecessary.=0A=
=0A=
Thanks=0A=
=0A=
>> +      };=0A=
>> +=0A=
>> +      fan-1 {=0A=
>> +        tach-ch =3D /bits/ 8 <0x1 0x2>;=0A=
>> +      };=0A=
>> +    };=0A=
>> --=0A=
>> 2.25.1=0A=
>>=0A=
