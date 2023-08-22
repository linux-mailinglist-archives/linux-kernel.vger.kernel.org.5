Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE20783BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjHVIag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjHVIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:30:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B231ACC8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:30:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so1812815a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692693028; x=1693297828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zF1W6IemxyseNQOVFfz2hKitd9z3KJA1ABE9EGrH8HU=;
        b=sUPTrbWHxU1WfhlSz7xL0c68bFiAeB0K4spEl70a2YYCguRIa/nbrHhub8bKU0dRGU
         j3MxXpWuvIBoSyqdNXSIYqCQYCtFF6llN8/M1GIRWEpuW4oZGWjtt4LxZqVI5uq0YKXB
         e/3buqKErrbK+QA72ygBum+LgpenY20L855TJJOg+xt79377RegDtXy1hU328C2+0+X0
         ElDUWWIrZA2vhsMTAvly5pHDgKVQsj/iSLTsICmh6ZvGFSzefLhagAbqKO1SSZDE1svj
         065dsDxkVdmNcysVe4upyhefgIcEsVMq9pEBVdDQSQMyuB1A2KClP6e0uF8Tk9xuv0S8
         9FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693028; x=1693297828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zF1W6IemxyseNQOVFfz2hKitd9z3KJA1ABE9EGrH8HU=;
        b=Jw4VWEV90sdhgLyfR82p9W2Xkyqx4TnLTOeYCdxIqIuGObujEE9c+fDaDZjrDwTCCN
         bmsHi20bx2FPZOOIPyCjKMj/FBoQLRx6xZmavsRRo7brKHDg1lBwm3yvC1jkC5GXXKQ1
         syZOYaeT6beOMgs6HFWophLpG1GxbzV7TlYcHchAp7oiWunv/dmRmMQcNDWT12N8YEKQ
         CmHVTGxsyWDCUnAHHwo9bdniD4l9bYo7oIx9bSgeUaUHvGJcL650yKnmvtVFfinVrUQh
         BxRlXnlgXDD2DS65i/D7nyYShBYPmEVHslb6+nlevxpBWQH8MWmAYyn89PQzCo4nz/wq
         GOEA==
X-Gm-Message-State: AOJu0YxHCD2QwvJqP8dbRC9fT8v/dfSK4IqXtL4Yo38qyp5j3F8HONkt
        p1/Mxmu6VUDGxbp4B9LMfJ0RBQ==
X-Google-Smtp-Source: AGHT+IEvJC1Dy+V70x9+fuyn/YRociRpwer/WTdPJLk+CxAxv6w2WAYFQ12KnSJkfO+LULY2TDr79w==
X-Received: by 2002:aa7:c98c:0:b0:523:3754:a4e1 with SMTP id c12-20020aa7c98c000000b005233754a4e1mr6399049edt.22.1692693028136;
        Tue, 22 Aug 2023 01:30:28 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id d16-20020a50fb10000000b005224d15d3dfsm7246103edq.87.2023.08.22.01.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:30:27 -0700 (PDT)
Message-ID: <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
Date:   Tue, 22 Aug 2023 10:30:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
Content-Language: en-US
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
 <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 10:13, Binbin Zhou wrote:
> Hi Krzysztof:
> 
> Thanks for your detailed reply.
> 
> On Tue, Aug 22, 2023 at 1:44 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/08/2023 08:13, Binbin Zhou wrote:
>>> Since commit f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add
>>> Loongson-2K1000 LIOINTC"), the loongson liointc supports configuring
>>> routes for 64-bit interrupt sources.
>>>
>>> For liointc-2.0, we need to define two liointc nodes in dts, one for
>>> "0-31" interrupt sources and the other for "32-63" interrupt sources.
>>> This applies to mips Loongson-2K1000.
>>>
>>> Unfortunately, there are some warnings about "loongson,liointc-2.0":
>>> 1. "interrupt-names" should be "required", the driver gets the parent
>>> interrupts through it.
>>
>> No, why? Parent? This does not make sense.
> 
> This was noted in the v1 patch discussion. The liointc driver now gets
> the parent interrupt via of_irq_get_byname(), so I think the
> "interrupt-names" should be "required".

of_irq_get_byname() does not give you parent interrupt, but the
interrupt. Why do you need parent interrupt and what is it?

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-loongson-liointc.c?h=v6.5-rc6#n345
> 
> static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
> 
>         for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
>                 parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
>                 if (parent_irq[i] > 0)
>                         have_parent = TRUE;
>         }
>         if (!have_parent)
>                 return -ENODEV;

How requiring parents interrupt is related to other changes in this
file? One logical change, one patch.

Anyway why did you do it and take it by names? Names here are basically
useless if they match indices, so just get interrupt by indices.

> 
>>
>>>
>>> 2. Since not all CPUs are multicore, e.g. Loongson-2K0500 is a
>>> single-core CPU, there is no core1-related registers. So "reg" and
>>> "reg-names" should be set to "minItems 2".
>>>
>>> 3. Routing interrupts from "int0" is a common solution in practice, but
>>> theoretically there is no such requirement, as long as conflicts are
>>> avoided. So "interrupt-names" should be defined by "pattern".
>>
>> Why? What the pattern has to do with anything in routing or not routing
>> something?
> 
> First of all, interrupt routing is configurable and each intx handles
> up to 32 interrupt sources. int0-int3 you can choose a single one or a
> combination of multiple ones, as long as the intx chosen matches the
> parent interrupt and is not duplicated:
> Parent interrupt --> intx
> 2-->int0
> 3-->int1
> 4-->int2
> 5-->int3
> 
> As:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/loongson/loongson64g-package.dtsi?h=v6.5-rc6#n24
> 
> In addition, if there are 64 interrupt sources, such as the mips
> Loongson-2K1000, and we need two dts nodes to describe the interrupt
> routing, then there is bound to be a node without "int0".
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi?h=v6.5-rc6#n60

All of them start from 0, so why do you want to allow here starting from 3?

> 
> According to the current dt-binding rule, if the node does not have
> "int0", there will be a dts_check warning, which is not in line with
> our original intention.

Why DT node would not have int0? Provide proper upstreamed Linux kernel
source proving this, not some imaginary code.

> 
>>
>>>
>>> This fixes dtbs_check warning:
>>>
>>> DTC_CHK arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb
>>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-controller@1fe11440: interrupt-names:0: 'int0' was expected
>>>       From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-controller@1fe11440: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
>>>       From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>>>
>>> Fixes: f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add Loongson-2K1000 LIOINTC")
>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>> ---
>>> V2:
>>> 1. Update commit message;
>>> 2. "interruprt-names" should be "required", the driver gets the parent
>>> interrupts through it;
>>> 3. Add more descriptions to explain the rationale for multiple nodes;
>>> 4. Rewrite if-else statements.
>>>
>>> Link to V1:
>>> https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.cn/
>>>
>>>  .../loongson,liointc.yaml                     | 74 +++++++++----------
>>>  1 file changed, 37 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>>> index 00b570c82903..f695d3a75ddf 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>>> @@ -11,11 +11,11 @@ maintainers:
>>>
>>>  description: |
>>>    This interrupt controller is found in the Loongson-3 family of chips and
>>> -  Loongson-2K1000 chip, as the primary package interrupt controller which
>>> +  Loongson-2K series chips, as the primary package interrupt controller which
>>>    can route local I/O interrupt to interrupt lines of cores.
>>> -
>>> -allOf:
>>> -  - $ref: /schemas/interrupt-controller.yaml#
>>> +  In particular, the Loongson-2K1000/2K0500 has 64 interrupt sources that we
>>> +  need to describe with two dts nodes. One for interrupt sources "0-31" and
>>> +  the other for interrupt sources "32-63".
>>>
>>>  properties:
>>>    compatible:
>>> @@ -24,15 +24,9 @@ properties:
>>>        - loongson,liointc-1.0a
>>>        - loongson,liointc-2.0
>>>
>>> -  reg:
>>> -    minItems: 1
>>> -    minItems: 3
>>> +  reg: true
>>
>> No. Constraints must be here.
> 
> May I ask a question:
> Since different compatibles require different minItems/minItems for

You don't have this case here. I don't see any device asking for 4 regs.

> the attribute, this writeup of defining the attribute to be true first
> and then defining the specific value in an if-else statement is not
> recommended?

The top-level defines widest constraints and if:else: narrows them per
each variant.

...

>>> +        reg-names:
>>> +          minItems: 2
>>> +          items:
>>> +            - const: main
>>> +            - const: isr0
>>> +            - const: isr1
>>
>> Srsly, why this is moved here from the top? It does not make sense.
> 
> In liointc-2.0, we need to deal with two dts nodes, and the setting
> and routing registers are not contiguous, so the driver needs
> "reg-names" to get the corresponding register mapping. So I put all
> this in the liointc-2.0 section.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-loongson-liointc.c?h=v6.5-rc6#n225

This is driver. You need to show the DTS, not driver.

> 
>         if (revision > 1) {
>                 for (i = 0; i < LIOINTC_NUM_CORES; i++) {
>                         int index = of_property_match_string(node,
>                                         "reg-names", core_reg_names[i]);
> 
>                         if (index < 0)
>                                 continue;
> 
>                         priv->core_isr[i] = of_iomap(node, index);
>                 }
> 
>                 if (!priv->core_isr[0])
>                         goto out_iounmap;
>         }
> 
> 
> I referenced other dt-binding writeups and thought this would be clearer.
> 
> Is this if-else style not recommended? Should I keep the v1 patch writeup?
> https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.cn/

if:else: is recommended, we do not discuss it. Your v1 was making
everything totally loose, so incorrect. Explain - why the reg-names are
not correct for the other variant? We expect just to have maxItems for
the other variant... unless reg-names are not correct, then they can be
made false - which you didn't.


Best regards,
Krzysztof

