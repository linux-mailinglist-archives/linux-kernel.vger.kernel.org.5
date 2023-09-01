Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED90578F7D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjIAFKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjIAFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:10:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D61E7F;
        Thu, 31 Aug 2023 22:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/erDMKIe0619Y8pGLeK80XcNy9yFbxd9PvwyQdixyMhb4/ZeBUStI6095XjWZC9SbjWb8KxRUXkC16WZM52zsHzHLGGN2hiGJ4FXtBx5Swf9qHvSt6FwBs44U75TOWOAZ+Gczfwq1vE1kXSGQOOxJeJalHlpTrK7MCaCHIVGT8lAflMf2NOI8iNtpjXUVtqpP/JZnKHB2bxDWO3DBZcyZFu9lRUIV+qQ0HkVTKPiYpnrbljMDZ3IHn4N4BqHmaGvh1BhGY3zyD8IscmYLOYh2T1sjpXW+c82xkqpvcARLecQhRV0LNSu4adkulkaqP0Bpva2ERfxyx4vfPR7+8QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cfl9oB2+6vtLScSg5hdcWc6Wq3UBKIjtdV86sdmo2s=;
 b=T/cVKaSX3YcEixYRzhP3B0P0U2+RRpYsauAT4r/uVAB0zDTnDxEhkAtDx8IqewJ0qNhPqMjUp1hnT4XsX4ufg8ft9x5B1iQakeAFtdEbTyutPl55JOqDmkIFVjj3OPsksbFrY80XDIRcKJfGCz31ivEGILsFVgkjTFW2e0m+k3XUqoyjay94AwDoPWcL/TlxmRKYBnnYjjZvMQ9ioIeF4fKmBYHyUQxxeytlweGztWS6uRf2vyxdSvupFbEnZe0pLC0soNDs5ZBYFlHzBYPLfl8Lzpn6PcZFxBVCfNgUU7CU0EVTeBjxtGdu1n0qpo0lxDhlGqcrniM+XtBlYLPkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cfl9oB2+6vtLScSg5hdcWc6Wq3UBKIjtdV86sdmo2s=;
 b=ebK/5R63+shiRTQQ8hGaQHeLOM/+7OBlGdo8K+UK30A/HgzRcFHdnuPvSUON8qtmxNYVH7XE+aCgKOrvEt8JKKjbGzTrytpNgZDx1k7JaletArb/JsboWYML2EjXTQlqJWdtlw9p508JhEEJ3lwT7kt1iKBXeb6unu/tvdfqYNOUL1nRobRym7FRPGOvemz5KSv26KfV9uFD0ZS5HV2WvWBIGnxx+x59ZIMkHR+30kmeQSLkcxnUkvn42HzxccfnfBMzzJ0LmLItcy3D+lWE7dMMqrm7tcWlyi3jeDgo+Ft05hJ07XefIv70UFCbmTDp3snG+ZBmTc58LIA7P7Myfw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 PSAPR06MB4456.apcprd06.prod.outlook.com (2603:1096:301:8e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.23; Fri, 1 Sep 2023 05:10:20 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205%5]) with mapi id 15.20.6699.034; Fri, 1 Sep 2023
 05:10:19 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Potin Lai <potin.lai.pt@gmail.com>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v8 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Thread-Topic: [PATCH v8 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Thread-Index: AQHZ2z4DZH/d3xLyZk2OcsZGe60xdrAFalCAgAAEPKE=
Date:   Fri, 1 Sep 2023 05:10:19 +0000
Message-ID: <SG2PR06MB336524E341C2B621D09C7BA98BE4A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-4-billy_tsai@aspeedtech.com>
 <99ffd1fb-14ae-1c83-bc32-2d0aead4d696@gmail.com>
In-Reply-To: <99ffd1fb-14ae-1c83-bc32-2d0aead4d696@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|PSAPR06MB4456:EE_
x-ms-office365-filtering-correlation-id: cbbe7e38-7b1d-4d21-a29b-08dbaaa9bcc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBCpPjCsnd8eqWuA5Mp9gmKO8iDLO4Bg7sZEwu2NG1XJMAgMp87x6JIEkEm7VLWpsttqiuetjeTj2S0yTHjKND0LKuuDcHQXclaM/XmO+GUYe8bzBqIW/CskTThNtSgB6dfFxq5XwO7K36X9jJOyot/4pB1Hcg0Ig7b/A/RlA0xRhJOyAD8KhEerV/DnFtjcawzSmI6XWLp0dib3Owchgiu6CGV/lHR3e/OTaTzNo39eWfal6ctguQ68KSgCOXqpGD6L1PI8rZtIh60dV6RH58LCIC03iIelCF5dsAblr6Vf6La/LNosr/QOSay+DK8oLjBb5d3mtzrajp1MlreRyW4Ld1LlK9jpZsrQtuoqoLGM16apTCPkvssXvPXNsHXNZz6Lsa1jzsilkbaN63N2IlDJlrHDrcMeqitG1Vl1kbhnUVJfi9vJFGrNT66NwZiTEgQUPYlauKAEoo4IiY1ZgFJSNLUd0WheqSU/l+YCdsIDqIH9X+/R9orymsii0ARuFmn/5g/9flY7GyeVK3hCoKLUU4vRi63/4i5cKnh/flmxdaXTbUsWCt7GXrOgcEyj143U9d2OIUE0BLZdrw+KSYNU7YHUI1TBwVIRlXU3QCvlPVnVEuyBoDPjbSJoZcpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(366004)(376002)(346002)(136003)(1800799009)(186009)(451199024)(7416002)(55016003)(2906002)(6916009)(316002)(41300700001)(5660300002)(8676002)(4326008)(52536014)(33656002)(8936002)(86362001)(71200400001)(122000001)(478600001)(83380400001)(26005)(55236004)(53546011)(7696005)(6506007)(9686003)(76116006)(66946007)(38070700005)(38100700002)(66556008)(91956017)(66446008)(64756008)(54906003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sjVUJwQOXaeE/jII/asmBkSzu5eG8hFZTy8e1Ehfi2vYbQw+OPvV+0QAN/?=
 =?iso-8859-1?Q?qfVgq16/Vks8r49MIE0I1tsbypUh1AcfqbUyWu3EELeSIzGT3x+M+EYkwb?=
 =?iso-8859-1?Q?TCWsADDZLLND3ASkKfgQ419IlHmnDyAxepCYy0U0QGAwKmcUJlOEw61LSn?=
 =?iso-8859-1?Q?DFA06WeVm5yDS9bJ+qif0Bu11y7spcZtVoDQkpBGKAyLCQBDSF64uNG5sl?=
 =?iso-8859-1?Q?t0vlgBz3TQ1HfrztEYnOwaHmU/c9rSoqsL3Lkk3Sz5oM3EG489hVT3iqXT?=
 =?iso-8859-1?Q?1yce3Cz5FVIC47ckl2Of3IypzaxQ6PLUGMqOKv8UR37wCuK328xj7UJjsp?=
 =?iso-8859-1?Q?MUN0RPQrHWzEqmKZ2GH20mxg07TUUktrrYbuOXCfXJcN4f/h362YyfXUaN?=
 =?iso-8859-1?Q?bZgjAFebw4f1E43yciud4GS9/6caukxlV04+yEhxvski1dGyKFUl1GD5O5?=
 =?iso-8859-1?Q?ju/SJ3aiNXo9uV2W6CHWbWDxl7U98Xc3h9rKixfxeiWKaaVcEHPxb0i+iL?=
 =?iso-8859-1?Q?o5t120Ga/+6o5oHtVZVKgwpEV7oE3ph86lvWZT+VQzMdeNZmFajE3dJwte?=
 =?iso-8859-1?Q?AMlWzXZp6j8Ifm/2CuY0Ze7KE7m7fhig62t4UiwRr8Y5Gmpt6BrOr7f0c4?=
 =?iso-8859-1?Q?48hcEFFPujzIjCsjkwUSP+b2EdwI9+iwhjwihI2MPrqfkWTD5RCUzJ9evI?=
 =?iso-8859-1?Q?lPop+HpUw7LymL8asvfOW9npxkp37/dW3Zq1LlwJg84lO53A9ot8k1et0/?=
 =?iso-8859-1?Q?GTbu8ZUj0o7R4aftLLLOuSWGMnsPBJ4nCSlvZDBUnFAaOZPfjMSn325nDm?=
 =?iso-8859-1?Q?qqNczy9VCdh9uHiFoI30GcjrTKO7abuV429+r0oGJ5H9EAu0fk4LHIbKJR?=
 =?iso-8859-1?Q?IqqGR7IgVLoal49ip42rPDT+Ol9C6qtW8vAS4Ftshny3TWRaRnFUGW9JV2?=
 =?iso-8859-1?Q?s3eaSrmc67/OzHdxc1LSwTYBxQ0JYVatvr/xzSy974Syhz5uSe/wQnw0tV?=
 =?iso-8859-1?Q?l+Dh0dyjE8MGaCdrw/KzAxK2wcZ1oikORtCI50Ldx90c/t4C8LB5XwBauH?=
 =?iso-8859-1?Q?g/oGmlDCSeCOTTVtt5OK4jRcFmbrWcSCc+k6dXRnju/vpWqTdTqjlq6jrJ?=
 =?iso-8859-1?Q?WBsRRtm2ZRk4fFuYfFwsI5QCg9y9JWHtoSpb2i/wZZAvHdla0a6Me3gmnb?=
 =?iso-8859-1?Q?GMVOWwmkJs39e+D7bbulczFkPz/H5Y+kml7arsaKNwZUy+Uqa2wzRyxHPV?=
 =?iso-8859-1?Q?CJPJLB2XZquykkpPhMMieWE8QQteoYnTVrebGaRCZipI4zC+/uPcHYCzMt?=
 =?iso-8859-1?Q?NrEe0Fkk13Mt/JftPox59mdXo3Ns31r2W3roBF0nn5j5RAjLiys0Ks1fH9?=
 =?iso-8859-1?Q?Qre1gg/FvM9wOb0aso2w+9GOP/A09QtxmMT9y5KOnbCGtu5Ka5le3SJyvr?=
 =?iso-8859-1?Q?+KbW9m7jcmSpQcBDo7jMMeBad9dOL0/Lu6iEprdz4FYcNnbTgSUDiZCieA?=
 =?iso-8859-1?Q?c+x++qBfolwZ/LZY2P1X2dvXiBtS2buM7IITGMe+L8YAFtRw1vHGjji9Xm?=
 =?iso-8859-1?Q?tTqz1Am1emHTgn43PRAz/Ya2sHpKyb/WNJO4iHEkzypBhvBcu3jtX8Hjpq?=
 =?iso-8859-1?Q?wtbW1Nf/LroxHE47fAUu6M3v3dmtHMZOdB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbe7e38-7b1d-4d21-a29b-08dbaaa9bcc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 05:10:19.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hI4L987ucs+StLYAD7Djl8Vlqsd2jeSzaECneS6Wkb3eMamDsejF408k8IcDsmQbY3/uMNGXfCeagHzeolRNeurzNyEwZBq5uY2QZqocWE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 20:32, Billy Tsai wrote:=0A=
>> +static int aspeed_tach_hwmon_write(struct device *dev,=0A=
>> +                                enum hwmon_sensor_types type, u32 attr,=
=0A=
>> +                                int channel, long val)=0A=
>> +{=0A=
>> +     struct aspeed_pwm_tach_data *priv =3D dev_get_drvdata(dev);=0A=
>> +     u32 reg_val;=0A=
>> +=0A=
>> +     switch (attr) {=0A=
>> +     case hwmon_fan_div:=0A=
>> +             if (!is_power_of_2(val) || (ilog2(val) % 2) ||=0A=
>> +                 DIV_TO_REG(val) > 0xb)=0A=
>> +                     return -EINVAL;=0A=
>> +             priv->tach_divisor =3D val;=0A=
>> +             reg_val =3D readl(priv->base + TACH_ASPEED_CTRL(channel));=
=0A=
>> +             reg_val &=3D ~TACH_ASPEED_CLK_DIV_T_MASK;=0A=
>> +             reg_val |=3D FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK,=0A=
>> +                                  DIV_TO_REG(priv->tach_divisor));=0A=
=0A=
> Hi Billy,=0A=
> I notice the fanX_div is always shows 1 after I set 1024.=0A=
> I think FIELD_GET() needs to replaced with FIELD_PREP().=0A=
=0A=
>> +             writel(reg_val, priv->base + TACH_ASPEED_CTRL(channel));=
=0A=
>> +             break;=0A=
>> +     default:=0A=
>> +             return -EOPNOTSUPP;=0A=
>> +     }=0A=
>> +=0A=
>> +     return 0;=0A=
>> +}=0A=
=0A=
=0A=
>> +static void aspeed_present_fan_tach(struct aspeed_pwm_tach_data *priv, =
u32 tach_ch)=0A=
>> +{=0A=
>> +     u32 val;=0A=
>> +=0A=
>> +     priv->tach_present[tach_ch] =3D true;=0A=
>> +     priv->tach_divisor =3D DEFAULT_TACH_DIV;=0A=
>> +=0A=
>> +     val =3D readl(priv->base + TACH_ASPEED_CTRL(tach_ch));=0A=
>> +     val &=3D ~(TACH_ASPEED_INVERS_LIMIT | TACH_ASPEED_DEBOUNCE_MASK |=
=0A=
>> +              TACH_ASPEED_IO_EDGE_MASK | TACH_ASPEED_CLK_DIV_T_MASK |=
=0A=
>> +              TACH_ASPEED_THRESHOLD_MASK);=0A=
>> +     val |=3D (DEBOUNCE_3_CLK << TACH_ASPEED_DEBOUNCE_BIT) | F2F_EDGES =
|=0A=
>> +            FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK,=0A=
>> +                      DIV_TO_REG(priv->tach_divisor));=0A=
=0A=
> And here as well.=0A=
=0A=
>> +     writel(val, priv->base + TACH_ASPEED_CTRL(tach_ch));=0A=
>> +=0A=
>> +     aspeed_tach_ch_enable(priv, tach_ch, true);=0A=
>> +}=0A=
>> +=0A=
>>=0A=
=0A=
Hi Potin,=0A=
=0A=
I will fix it in next verison of the patch.=0A=
=0A=
Thanks for reviewing.=
