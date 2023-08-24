Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1336378756D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbjHXQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbjHXQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:32:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FAF1BE;
        Thu, 24 Aug 2023 09:32:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31963263938so5923980f8f.2;
        Thu, 24 Aug 2023 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692894739; x=1693499539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H1Mxjg5UfEr5egVnkOQOIzhgqJiFZzJQ5v7B4mwhI0=;
        b=B80qaCHsmA0gk0/JE2VEJnZqSZI0FcvzTF0GMji/fUfw1/t0BwVb1V5uZY5Z5bm55w
         wDsgEOlD/FJoV7EJ4Yn9e4CFdZGbA74kbk+0ls2vwpurLxYq8XW3YwX2baAdck9mA7kw
         wHgqAZuLkduHeOXgiPv0H59Ztmg94miTjWDZaQBg2OokJErieCZOSKLVQdzcTShn4rZM
         9S5ZeahrTcClEsZpy+ScuyBM/wG3P6nSVxSxIvC/ZJgIpFwr3c3cBo6CLxWA1HxbN8ak
         hy9xg7KA7kqIF6PtbyYCTNwQPD/8J/B/qqVd20mWSwfhxFaD/hCqOkKdZGQvvHXfMGNc
         VHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894739; x=1693499539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2H1Mxjg5UfEr5egVnkOQOIzhgqJiFZzJQ5v7B4mwhI0=;
        b=hyhq3xDHOgTVVY+OkVDoVJ6O+CdAumJuYNyP5tmBBT+ntW1iHhmkkyce8h/eMfbC69
         FdC6utJsSSQVMc5McCaPZSnwHQJTYJRilOMZ83SIlbt/Tz/sv7VODMMyRztJFqBPbmz+
         MXgdRiRjHvfVNmoZisGTy3FnINvTNN9rdXe92INMLY/NmrDZ50C+5YM1KSVx4WFM6Lih
         QqypRwEfsj0gHa+7nGB79MvX+QmfWaGcom94zHZoggOK8WEntI1lPTHdG0ede/feD1Yf
         lEmLtTJJfiyOve+7sKHlnUoPD701V7Eo/f0gIAqN9quQCTMWhYVH/7BOtnNKT4spFhdj
         3gBA==
X-Gm-Message-State: AOJu0YxvvAvW4keCNmfD8TaIyZ3ek+3BVa70HWWKAJfGZgYCzYHYp+if
        PxQFfBnTH3xzcAD6sSUFnCrLL9UMPTM=
X-Google-Smtp-Source: AGHT+IGua9aI6/tZ6+r2DiBVeH1YS7a0+u51HjDaHfj0eh3UsfSA+GHwvk+Wj2aF/cHGmA2dpAafXg==
X-Received: by 2002:adf:f3cd:0:b0:317:3f64:4901 with SMTP id g13-20020adff3cd000000b003173f644901mr11006929wrp.41.1692894738629;
        Thu, 24 Aug 2023 09:32:18 -0700 (PDT)
Received: from [192.168.247.38] ([88.182.105.48])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4d88000000b0031c6cc74882sm5428242wru.107.2023.08.24.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:32:17 -0700 (PDT)
Message-ID: <530e8caf-a7ad-4c82-ab1b-58b728770703@gmail.com>
Date:   Thu, 24 Aug 2023 18:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: irqchip: convert st,stih407-irq-syscfg to
 DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230823224453.126963-1-rgallaispou@gmail.com>
 <20230824134828.GA683810-robh@kernel.org>
Content-Language: en-US, fr
From:   =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20230824134828.GA683810-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

Le 24/08/2023 à 15:48, Rob Herring a écrit :
> On Thu, Aug 24, 2023 at 12:44:53AM +0200, Raphael Gallais-Pou wrote:
>> Convert deprecated format to DT schema format.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> Changes in v2:
>> 	- Added Conor's r-by
>> 	- Removed quotes surrounding $refs
>> 	- Hardcoded 'st,invert-ext' possible values
>>
>> Changes in v3:
>> 	- Fixed enum syntax warnings
>> 	- Removed reference to driver in favor of device
>> ---
>>   .../st,sti-irq-syscfg.txt                     | 30 ---------
>>   .../st,stih407-irq-syscfg.yaml                | 64 +++++++++++++++++++
>>   2 files changed, 64 insertions(+), 30 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
>> deleted file mode 100644
>> index 977d7ed3670e..000000000000
>> --- a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -STMicroelectronics STi System Configuration Controlled IRQs
>> ------------------------------------------------------------
>> -
>> -On STi based systems; External, CTI (Core Sight), PMU (Performance Management),
>> -and PL310 L2 Cache IRQs are controlled using System Configuration registers.
>> -This driver is used to unmask them prior to use.
>> -
>> -Required properties:
>> -- compatible	: Should be "st,stih407-irq-syscfg"
>> -- st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
>> -- st,irq-device	: Array of IRQs to enable - should be 2 in length
>> -- st,fiq-device	: Array of FIQs to enable - should be 2 in length
>> -
>> -Optional properties:
>> -- st,invert-ext	: External IRQs can be inverted at will.  This property inverts
>> -		  these IRQs using bitwise logic.  A number of defines have been
>> -		  provided for convenience:
>> -			ST_IRQ_SYSCFG_EXT_1_INV
>> -			ST_IRQ_SYSCFG_EXT_2_INV
>> -			ST_IRQ_SYSCFG_EXT_3_INV
>> -Example:
>> -
>> -irq-syscfg {
>> -	compatible    = "st,stih407-irq-syscfg";
>> -	st,syscfg     = <&syscfg_cpu>;
>> -	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
>> -			<ST_IRQ_SYSCFG_PMU_1>;
>> -	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
>> -			<ST_IRQ_SYSCFG_DISABLED>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
>> new file mode 100644
>> index 000000000000..985fa281f027
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/st,stih407-irq-syscfg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STi System Configuration Controlled IRQs
>> +
>> +maintainers:
>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>> +
>> +description:
>> +  On STi based systems; External, CTI (Core Sight), PMU (Performance
>> +  Management), and PL310 L2 Cache IRQs are controlled using System
>> +  Configuration registers.  This device is used to unmask them prior to use.
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stih407-irq-syscfg
>> +
>> +  st,syscfg:
>> +    description: Phandle to Cortex-A9 IRQ system config registers
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  st,irq-device:
>> +    description: Array of IRQs to enable.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      - description: Enable the IRQ of the channel one.
>> +      - description: Enable the IRQ of the channel two.
>> +
>> +  st,fiq-device:
>> +    description: Array of FIQs to enable.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      - description: Enable the IRQ of the channel one.
>> +      - description: Enable the IRQ of the channel two.
>> +
>> +  st,invert-ext:
>> +    description: External IRQs can be inverted at will. This property inverts
>> +      these IRQs using bitwise logic.
> 
> So this is a mask?

Of course, I did not had clarity given the hour I sent this, but it is 
indeed a bitmask.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [ 1, 2, 4]
> 
> If so, then this is wrong if you want to set more than 1 bit.
So knowing this is a mask, it can take any integer between 1 and 4 in 
our case.

> 
>> +
>> +required:
>> +  - compatible
>> +  - st,syscfg
>> +  - st,irq-device
>> +  - st,fiq-device
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq-st.h>
>> +    irq-syscfg {
>> +        compatible    = "st,stih407-irq-syscfg";
>> +        st,syscfg     = <&syscfg_cpu>;
>> +        st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
>> +                        <ST_IRQ_SYSCFG_PMU_1>;
>> +        st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
>> +                        <ST_IRQ_SYSCFG_DISABLED>;
>> +    };
>> +...
>> -- 
>> 2.41.0
>>
