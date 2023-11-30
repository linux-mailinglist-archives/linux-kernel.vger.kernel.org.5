Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12407FE9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbjK3HeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbjK3HeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:34:04 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A97510E5;
        Wed, 29 Nov 2023 23:34:07 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9B58424E25C;
        Thu, 30 Nov 2023 15:33:59 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 15:33:59 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 15:33:58 +0800
Message-ID: <ac934dc1-0239-47c6-b28d-d4cd690f54c1@starfivetech.com>
Date:   Thu, 30 Nov 2023 15:33:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] dt-bindings: pwm: Add bindings for OpenCores PWM
 Controller
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231129092732.43387-1-william.qiu@starfivetech.com>
 <20231129092732.43387-2-william.qiu@starfivetech.com>
 <20231129-chaplain-unseeing-e433ec830946@spud>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20231129-chaplain-unseeing-e433ec830946@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/29 22:33, Conor Dooley wrote:
> On Wed, Nov 29, 2023 at 05:27:29PM +0800, William Qiu wrote:
>> Add bindings for OpenCores PWM Controller.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../bindings/pwm/opencores,pwm.yaml           | 56 +++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
>> new file mode 100644
>> index 000000000000..133f2cd417f0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/opencores,pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: OpenCores PWM controller
>> +
>> +maintainers:
>> +  - William Qiu <william.qiu@starfivetech.com>
>> +
>> +description:
>> +  OpenCores PTC ip core contains a PWM controller. When operating in PWM mode,
> 
> nit: "The OpenCores PTC IP core"
> 
Will update.
>> +  the PTC core generates binary signal with user-programmable low and high
>> +  periods. All PTC counters and registers are 32-bit.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - starfive,jh7100-pwm
>> +              - starfive,jh7110-pwm
>> +          - const: opencores,pwm-v1
> 
> properties:
>   compatible:
>     items:
>       - enum:
>           - starfive,jh7100-pwm
>           - starfive,jh7110-pwm
>       - const: opencores,pwm-v1
> 
> Please use this form here instead.
> 
> Otherwise, this looks good to me now.
> 
I see. I'll update it.

Thanks for spending time to review this patchset.

Best Regards,
William
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 3
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pwm@12490000 {
>> +        compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
>> +        reg = <0x12490000 0x10000>;
>> +        clocks = <&clkgen 181>;
>> +        resets = <&rstgen 109>;
>> +        #pwm-cells = <3>;
>> +    };
>> -- 
>> 2.34.1
>> 
>> 
