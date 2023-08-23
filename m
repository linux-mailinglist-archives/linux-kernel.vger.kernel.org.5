Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0E785718
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjHWLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHWLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:49:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DEE0CF;
        Wed, 23 Aug 2023 04:49:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6885F1042;
        Wed, 23 Aug 2023 04:50:11 -0700 (PDT)
Received: from [10.57.34.103] (unknown [10.57.34.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2403F64C;
        Wed, 23 Aug 2023 04:49:26 -0700 (PDT)
Message-ID: <0fdf4f0b-64e4-9831-36b8-a00d4cbd131a@arm.com>
Date:   Wed, 23 Aug 2023 12:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
To:     =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= 
        <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
References: <20230814133238.741950-1-privatesub2@gmail.com>
 <20230814133238.741950-2-privatesub2@gmail.com>
 <20230822104854.1fa5f1aa@donnerap.manchester.arm.com>
 <CAF4idNneb1=40mQC=593Tmy8_OUAGiL4ROjK2XyL2BA35vM_WA@mail.gmail.com>
Content-Language: en-US
From:   Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAF4idNneb1=40mQC=593Tmy8_OUAGiL4ROjK2XyL2BA35vM_WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/08/2023 07:57, Александр Шубин wrote:
> Hi Andre,
> 
> вт, 22 авг. 2023 г. в 12:49, Andre Przywara <andre.przywara@arm.com>:
>>
>> On Mon, 14 Aug 2023 16:32:16 +0300
>> Aleksandr Shubin <privatesub2@gmail.com> wrote:
>>
>> Hi Aleksandr,
>>
>>> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
>>> controller witch is different from the previous pwm-sun4i.
>>>
>>> The D1 and T113 are identical in terms of peripherals,
>>> they differ only in the architecture of the CPU core, and
>>> even share the majority of their DT. Because of that,
>>> using the same compatible makes sense.
>>> The R329 is a different SoC though, and should have
>>> a different compatible string added, especially as there
>>> is a difference in the number of channels.
>>>
>>> D1 and T113s SoCs have one PWM controller with 8 channels.
>>> R329 SoC has two PWM controllers in both power domains, one of
>>> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
>>>
>>> Add a device tree binding for them.
>>>
>>> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
>>> ---
>>>   .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 85 +++++++++++++++++++
>>>   1 file changed, 85 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>>> new file mode 100644
>>> index 000000000000..9512d4bed322
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>>> @@ -0,0 +1,85 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Allwinner D1, T113-S3 and R329 PWM
>>> +
>>> +maintainers:
>>> +  - Aleksandr Shubin <privatesub2@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: allwinner,sun20i-d1-pwm
>>> +      - items:
>>> +          - const: allwinner,sun20i-r329-pwm
>>> +          - const: allwinner,sun20i-d1-pwm
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#pwm-cells":
>>> +    const: 3
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: 24 MHz oscillator
>>> +      - description: Bus Clock
>>
>> The manual tells me that the new PWMs can also use APB0 as the
>> input clock, which (finally!) allows PWM frequencies above 24 MHz.
>> So we should have an explicit reference to that clock - even if the bus
>> clock happens to be gated version of APB0.
> 
> Should I change it to something like this:
>      pwm: pwm@2000c00 {
>        compatible = "allwinner,sun20i-d1-pwm";
>        reg = <0x02000c00 0x400>;
>        clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
>        clock-names = "bus", "hosc", "apb0";
>        resets = <&ccu RST_BUS_PWM>;
>        #pwm-cells = <0x3>;
>      };

Yes, that is what I had in mind!
It shouldn't be too hard to add support for this in the driver as well.

Thanks!
Andre

> 
>>
>> Cheers,
>> Andre
>>
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: hosc
>>> +      - const: bus
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  allwinner,pwm-channels:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The number of PWM channels configured for this instance
>>> +    enum: [6, 9]
>>> +
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: allwinner,sun20i-r329-pwm
>>> +
>>> +    then:
>>> +      required:
>>> +        - allwinner,pwm-channels
>>> +
>>> +    else:
>>> +      properties:
>>> +        allwinner,pwm-channels: false
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - "#pwm-cells"
>>> +  - clocks
>>> +  - clock-names
>>> +  - resets
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
>>> +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
>>> +
>>> +    pwm: pwm@2000c00 {
>>> +      compatible = "allwinner,sun20i-d1-pwm";
>>> +      reg = <0x02000c00 0x400>;
>>> +      clocks = <&dcxo>, <&ccu CLK_BUS_PWM>;
>>> +      clock-names = "hosc", "bus";
>>> +      resets = <&ccu RST_BUS_PWM>;
>>> +      #pwm-cells = <0x3>;
>>> +    };
>>> +
>>> +...
>>
> 
> Cheers,
> Aleksandr
> 
