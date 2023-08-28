Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5758E78A546
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjH1Fdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjH1Fdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:33:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137F4115;
        Sun, 27 Aug 2023 22:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8u0tVTHS8Sg6Ir3LCHvCp0woPNzmAOco+G2jevmZuEIkj+pAKKjnqwPMKIEXL5TTbBCOKh/o6qBkw6DxyaZuc5DTCI1LxkomNO61gHSADE4EDInJ/RBdDeTMLfRGGwGFaZG7U2E0dRggaJAK4ppsYsZiJNzgfL/Am/VsTJdHHiMoUVwG+w2C4fAEzs2KF/x0wIyeB9Dt/sVMEoH4CBtF6sm8L+mS39Fi3n9a6P3VUKu7DTBjPK7EDt3SZ0ZETDfJwv0XVXoT2S0W+ffcRpMjHhpgu8BQxgknWrnlncNhjCCW7zPtc/sJcq4IsX+0DM4AaKw8PynHF8I1O+vABCJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIiEIx6mefa99Ddaj4IxPE1tNcHMQfxv7brb0b3zOMk=;
 b=gAlACgCKv+ZI5SAQ1LDnbaD1Nbe0+8YUrMvhpCcj3FGgla9u4Rts/NJQB0sM29CqxX0W+N8aV3rCRJycEbdvtraA2vbte7NeUVd0qviJy47B/zKwwJxQJkLyMIsJI0ba6rowRRr+F20v9g071014cO7fF657qkRne949ZmGwM2TC4tz6+Vk4WX0bqMEICOTSngtqjGNNBB1hq4PJnpFtn10qctknLi5peTDdBPNpDWYsdy7BcZvu9BQlIEQX+nVeL4OrPqyoGl4Z06siwbf4GXvzdkhSVk+xwxfehrPKrNtvapQlvavJNklb41gZaaJVXu56sWeXaWKL3vG/4JJAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIiEIx6mefa99Ddaj4IxPE1tNcHMQfxv7brb0b3zOMk=;
 b=SyXE0rV+KqiddfVIf6x27k4naX/VvUFiC1YSWtOXX63rWlAitEibZ0dzZUetkeaatpZQtHxlNtRZHVnRyNCks/fkKvf7kQdB0NxTLAE3gWlgO7Jwl8QKXZvf+pFoSsbqtuo3w69pKIz/F+At/VHHlbZy62JghGHg2ullLz5JcgFybnBubMloNTr65R2AkExrtHVlfYgxRxNYXDWjpeGxKMMc+LI4n/P2IwenZzjn6l3wO5y6oWSnj3gAdzlfwSm6JpKU2igxZ9cJKcUwSBb3E3pzXu/Uq+X3DR0KbVZlqa2MJLftPmlcZ9vDu7LgsHPoMktXBe5V4tmkmPCNzRRMsw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 JH0PR06MB6449.apcprd06.prod.outlook.com (2603:1096:990:33::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Mon, 28 Aug 2023 05:33:19 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205%5]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 05:33:19 +0000
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
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Luke Chen <luke_chen@aspeedtech.com>,
        "naresh.solanki@9elements.com" <naresh.solanki@9elements.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Topic: [PATCH v7 1/2] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Index: AQHZ0QJvt1FcsY++RkyqB+vsZBe3qa/35TgAgAdZWAA=
Date:   Mon, 28 Aug 2023 05:33:18 +0000
Message-ID: <SG2PR06MB3365BA3D9C5C50398D8449A98BE0A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230817120029.221484-1-billy_tsai@aspeedtech.com>
 <20230817120029.221484-2-billy_tsai@aspeedtech.com>
 <20230823131334.GA2059582-robh@kernel.org>
In-Reply-To: <20230823131334.GA2059582-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|JH0PR06MB6449:EE_
x-ms-office365-filtering-correlation-id: 4131de20-9597-4102-a1bb-08dba788494e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOmVSnk7hYksQJEwZyYywSi+ub+P48BGyrN66izHWNYI9tNd03C33PGA9+tbf8a1wtIIarVAVvpYq6QW19Hn8Rss90Crcc3y/fvSwb5SDtZL7P3vANl6GYmfmdAzz7QI+/5mYt5BG4aaNRyjTUrCRE+VCI6t06mEOEiE4cQ5gedwoZit1uos0jCFKnOuXn7Pr/YsKg+s1FtZz8D1vIlm9sYoXtFyeTsOmvhjGDZdusCZVt8v44GP7ci1qg3istDy1U0xCbssLCvqJRzdKA2OIPDHVMjKld4sUyV8LBF/mXlT/gT53T+HC6rrtRcRQFXsHmB4bssk5pHkvb7MWH9O/AAeIHEHlj4grffHMXfdyuTzhqAJo5JeZdzucSnqyijDfUTwYulmy5dVe+DkrQ9LkDWee9G1Qka63QY3i4186qGHJlea9hp3Omz1TQf7p+Hu388cJ321Ch1PTije7BGYrCgeP6GN75R5L79XqLrS8T/sQ0nnFvRdfgvTKpUSBNueCrmOAWUE1H5P9eS600OEiqROSMPmGC5MOjJb6uWo0Z4iLq6AbboHZXL+K4fd/jS7XmVueeKMJ78iE3Ai+DGpOnVIW84RByc+71oy0P9KCW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39840400004)(186009)(1800799009)(451199024)(41300700001)(7416002)(26005)(122000001)(38100700002)(38070700005)(86362001)(966005)(478600001)(83380400001)(71200400001)(9686003)(55236004)(7696005)(6506007)(55016003)(76116006)(316002)(66446008)(54906003)(91956017)(2906002)(6916009)(33656002)(66946007)(66556008)(64756008)(66476007)(5660300002)(8676002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/emyySDIoP03UYIoqBsq7mIde4u1Qwa4eV6yLrxInwoS23iW+jtVbdY0Yp?=
 =?iso-8859-1?Q?nJ8qMOZd1hT6uziERasF4e0JQkR8vXpny8Up07asn8npDjuxXPBq2U4VM+?=
 =?iso-8859-1?Q?ZYGMSHHtImRD88ISbqJ98j2BrCjbnOSKhbqyIl+qEQJ+5+Rdw9y2un1Tqn?=
 =?iso-8859-1?Q?i+fgUXxHfUy6YynwI2Gttzi3mfPfH6WyltNvXCjXSwHK9V5mlSJ2veDDR5?=
 =?iso-8859-1?Q?yMI4oxlxWSDlXpz9J5O6rL3CN2cx3TSLJ+UX9LxPea7sx7SMjZHz70htLJ?=
 =?iso-8859-1?Q?nW/3ATO7DNCPQpjdrTHaqrWpH4w6TBl0XUsTi3CyiDUgWEcM/NkvZUKpnb?=
 =?iso-8859-1?Q?jXmhDD8P9kjlCeIG60N/Tl3iYvc/af46Z8HbnXasq7why1zknISl7Ce/Mv?=
 =?iso-8859-1?Q?MqkqS9+wMSNAvGtT7NS+X3emFDAOTsUnehms/H8H1ITIiPzyLYx8AEK14T?=
 =?iso-8859-1?Q?mZ1AK0gQdfF+nkiNhHC21Qkvk22507jFdgn2ikMl71+9Lic2c4UkMsmuP9?=
 =?iso-8859-1?Q?Q74UCzjNdeY8lUixGGe/j4B6llST4JkQtoia5ifFZG5UkqNq7k//rg8cSO?=
 =?iso-8859-1?Q?MVvOkvI+GFUklllnel+DEmMgppDG04gXMAEVsPJJGqiRlKKkLOlRsMrS2L?=
 =?iso-8859-1?Q?IPEbdYuAaECg6Z0++sQte4ONIqsVzU1AqRiUj/vm7zb0tOVSZSu34cXjyY?=
 =?iso-8859-1?Q?m0mo93cwVPr43wD3VrNXSxjCA92Brmy776IXtu/n9WafCa4xPszpTP8oMR?=
 =?iso-8859-1?Q?0xctrwSVUaAbSKLXMEbk+060q/FEA6bOWpnCjPVbTQhNAUH119aAZcjbnY?=
 =?iso-8859-1?Q?1sJBRR5miQgCEwDKyF3kOeBRTAInCmE7WJ51cELT2f+UWlUsskEy4wFxUI?=
 =?iso-8859-1?Q?rNAZJfGMVi6UbFQ7Gdn8dcyLEaNeFSWO2j+36tU7VE3AZ8iaI+4oZ9zN7o?=
 =?iso-8859-1?Q?D+ri9fF5jhAbGZjAmRhzRyX2r+jorWZMcAYKUDRiVrkAj0xV3N6HsHA1Ee?=
 =?iso-8859-1?Q?m3m9pNj13ZZSOkhCy+Bvq4V3Q3CZaKkgxDxz8SkHbiHBIpuxH0dZvdIOT8?=
 =?iso-8859-1?Q?jOmMoaB2h3OY0XLAYLCNRNMgXORVN7J4olG3IdePZqkvu8D9dP7DOGEHJl?=
 =?iso-8859-1?Q?jPaQR2qX4OUor5ASTjUswOFyjRMLHaJ1ugir6/Yf5q+xt7clTDBh1Q0GyH?=
 =?iso-8859-1?Q?y59W/CYOVpvuWQeei5+kzx8XgJmeB0NKAToNGfhD/qZXri1psKzLA5uc/4?=
 =?iso-8859-1?Q?2KNa+g1pr5muCrquFpB55YhSTgo2WgTUFR9+UosRNonG+dhgUUqcfWDCOG?=
 =?iso-8859-1?Q?lSkWagmpXNvktzY0BYS57r0s/MnGpTIGiwcg7GpAY97yUwkXHmser8DzRJ?=
 =?iso-8859-1?Q?LH+6KSTzcF/ct7kJ28XHqP0rWVF+G6wlWcIr2zGH68lNgCr1ld2LmKKAYG?=
 =?iso-8859-1?Q?sxOwd/qgXHaBqw7yboMPZC0fna2cZJtiuB0hXsHOosOPASL2+KiWC7XnNc?=
 =?iso-8859-1?Q?3040+2VcIUWE/05VsVPPPZuO/V34LLQgrgJY9HfF0LCZuqpJcMN6aXf92B?=
 =?iso-8859-1?Q?1vIWvErlIcRIGOlOQj4BOFODtwtPFpNa89y5TAP7AFyqpK9FrexqIzGNCm?=
 =?iso-8859-1?Q?5ZsBCsKBHWGiFvBwSX798+IpgKDJa7rRUp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4131de20-9597-4102-a1bb-08dba788494e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 05:33:18.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjiSZV0r8lmXwcw8a5jctSPa4VR59xa70J92ZiQQ2Q5X+F+veFZZmBRX0zpNUXcTcs7txWeSoIUSLv/QE8BSfz70ka/guj+XqpxKj7f3pBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:00:28PM +0800, Billy Tsai wrote:=0A=
>> Document the compatible for aspeed,ast2600-pwm-tach device, which can=0A=
>> support upto 16 PWM outputs and 16 fan tach input.=0A=
>>=0A=
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> ---=0A=
>>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 57 +++++++++++++++++++=
=0A=
>>  1 file changed, 57 insertions(+)=0A=
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pw=
m-tach.yaml=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.=
yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..1666304d0b0f=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=0A=
>> @@ -0,0 +1,57 @@=0A=
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
>> +# Copyright (C) 2021 Aspeed, Inc.=0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#=0A=
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
>> +=0A=
>> +title: ASPEED G6 PWM and Fan Tach controller device driver=0A=
>> +=0A=
>> +maintainers:=0A=
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> +=0A=
>> +description: |=0A=
>> +  The ASPEED PWM controller can support upto 16 PWM outputs.=0A=
>> +  The ASPEED Fan Tacho controller can support upto 16 fan tach input.=
=0A=
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
>> +  aspeed,fan-tach-ch:=0A=
>> +    description: Specify the Fan tach input channels.=0A=
>> +    $ref: "/schemas/types.yaml#/definitions/uint8-array"=0A=
 =0A=
>This property is already defined in aspeed-pwm-tacho.txt as a single u8=0A=
>that goes in a fan node. You can't redefine its type and location here.=0A=
 =0A=
Hi Rob,=0A=
 =0A=
I didn't redefine the type of property. The type of the aspeed,fan-tach-ch =
is unit8-array=0A=
in aspeed-pwm-tacho.txt.=0A=
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/hwmon/aspeed-pwm-tacho.txt#L48=0A=
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/hwmon/aspeed-pwm-tacho.txt#L71=0A=
 =0A=
>To repeat what I've said in previous versions, work with others to=0A=
>define a common fan and fan controller binding. Otherwise, anything new=0A=
>with fan related properties is simply going to be rejected.=0A=
 =0A=
Okay I will try to work with Naresh for defining a common fan binding.=0A=
 =0A=
Thanks for your suggestion.=0A=
 =0A=
Hi Naresh,=0A=
 =0A=
As Rob mentioned, it would be advisable for my dt-bindings to reference the=
 common fan bindings instead of introducing specific properties.=0A=
I noticed that you have already submitted a related patch to the community,=
 which seems to be pending for around 10 months.=0A=
https://lore.kernel.org/lkml/20221116213615.1256297-2-Naresh.Solanki@9eleme=
nts.com/=0A=
Do you have plans to send the next version of the patch? Alternatively, can=
 I proceed to cherry-pick this version of the patch and continue with=0A=
the upstreaming process in my patch serial?=0A=
 =0A=
Thanks=0A=
Best Regards,=0A=
Billy Tsai=
