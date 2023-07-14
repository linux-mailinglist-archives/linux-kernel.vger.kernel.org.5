Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD137531EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjGNG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjGNG1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:27:47 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C110FA;
        Thu, 13 Jul 2023 23:27:44 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1A84324E2E3;
        Fri, 14 Jul 2023 14:27:42 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 14:27:42 +0800
Received: from [192.168.125.128] (183.27.98.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 14:27:40 +0800
Message-ID: <1b55f255-a9b2-1f0a-9b8b-11c787e76a75@starfivetech.com>
Date:   Fri, 14 Jul 2023 14:24:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v6 1/7] dt-bindings: clock: Add StarFive JH7110 PLL
 clock generator
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
 <20230704064610.292603-2-xingyu.wu@starfivetech.com>
 <CAJM55Z8vj6KvpKZxRVh0+G_LCXrpnXzOR+oBad-igkHVTD_J=Q@mail.gmail.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z8vj6KvpKZxRVh0+G_LCXrpnXzOR+oBad-igkHVTD_J=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.46]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 20:26, Emil Renner Berthing wrote:
> On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>
>> Add bindings for the PLL clock generator on the JH7110 RISC-V SoC.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../bindings/clock/starfive,jh7110-pll.yaml   | 46 +++++++++++++++++++
>>  .../dt-bindings/clock/starfive,jh7110-crg.h   |  6 +++
>>  2 files changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
>> new file mode 100644
>> index 000000000000..beb78add5a8d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 PLL Clock Generator
>> +
>> +description:
>> +  These PLLs are high speed, low jitter frequency synthesizers in JH7110.
> 
> ..synthesizers in the JH7110.

Will fix.

> 
>> +  Each PLL works in integer mode or fraction mode, with configuration
>> +  registers in the sys syscon. So the PLLs node should be a child of
>> +  SYS-SYSCON node.
>> +  The formula for calculating frequency is
>> +  Fvco = Fref * (NI + NF) / M / Q1
>> +
>> +maintainers:
>> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-pll
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: Main Oscillator (24 MHz)
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller {
>> +      compatible = "starfive,jh7110-pll";
>> +      clocks = <&osc>;
>> +      #clock-cells = <1>;
>> +    };
>> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> index 06257bfd9ac1..086a6ddcf380 100644
>> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> @@ -6,6 +6,12 @@
>>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>>  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>>
>> +/* PLL clocks */
>> +#define JH7110_CLK_PLL0_OUT                    0
>> +#define JH7110_CLK_PLL1_OUT                    1
>> +#define JH7110_CLK_PLL2_OUT                    2
>> +#define JH7110_PLLCLK_END                      3
> 
> It would be nice if these names followed the same pattern as the
> clocks below. Eg. something like JH7110_PLLCLK_PLL?_OUT and
> JH7110_PLLCLK_END.
> 
> But maybe these defines are not even needed, since you just do <&pll
> 0>, <&pll 1> and it's obvious what that means.

I prefer to keep these names because they are used in the PLL driver
and are more easy to understand than numbers.
I will use the JH7110_PLLCLK_PLL?_OUT to follow the same pattern
in next version.

Best regards,
Xingyu Wu

> 
>>  /* SYSCRG clocks */
>>  #define JH7110_SYSCLK_CPU_ROOT                 0
>>  #define JH7110_SYSCLK_CPU_CORE                 1
>> --
>> 2.25.1
>>

