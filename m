Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3640E7887F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbjHYM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbjHYM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:56:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB097269E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:56:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-525bd0b2b48so1297952a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692968195; x=1693572995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtEwEDc31XpRCbx957LHvDY3j7bJ3BCy8rsVcSY1Qg8=;
        b=GFh2+yCXCJh68NAtuL+uu5tWmKdZw7rv7dK6cCbZOI6ARhUoZ6ygw+PqpSPTBjObeX
         1mxosyQ701oM2XhS3eUerDU7SrLOkpfbtBbdaceaION1Ga5PPw5EpiY20WZWZ+9wE+ys
         1f9po1qi85maLTDjHNCvru5HxFLgn3S9H1hyiQl3n0RDie0zeIMOcGuQwGJk7r5NNDPn
         m2E/Aqnudgx+kI1fhgc/g7T6X0elbI0fabdn7zgLr5Fa875WgW2EldDyfXhUqEdm/IO3
         7eYt7ZgI02w25jNeXkwfyv6xKT3vxzPP/q0wruTaO2VhARQ/RZlg33f36oQ8pz6IZPX/
         jp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968195; x=1693572995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtEwEDc31XpRCbx957LHvDY3j7bJ3BCy8rsVcSY1Qg8=;
        b=D6r1xGzKFQz4Aning3Rcq2zkAVhE1Ezm7vDScfN6phQPxZimlnot2VXzScI3Bn5oZv
         9fV11moPR5AhH2W+SZoMQfMdZjSoGtO4m71/PDnx+PLdyHvDkvNLxn9AH2watgP5/JA2
         7jO/yOkhuhYBdOq7zDxjrNFJ9Wgfmp7lLMQ2mutI7jPZPe315LW9WDQvlCJnqxvkziGj
         /RBVc3qsA2CgiONZWR97/yt7nK+TgqfQr/4/xA4FI7++q6LPtVb2QlviliHIiL4Gky8H
         +XMAJDMUkA1h6B+8IrQDLgswsq2y2Mi1B/Pwx7w/o1V3xYypnNhk6m/4Gmh1npJ/Puij
         5QQw==
X-Gm-Message-State: AOJu0Yx8CmmSjM0BLO4KtbA20NmTm7rkDkllsJRFncg3WPh/W+8VAab6
        zBPvUL7KedmxS/8X9jmVhqSYHQ==
X-Google-Smtp-Source: AGHT+IHWEo2JrvOndiaBEw6DoshlyovZ2Hv+lEN7ah9G3oYuyveDThMSkPasCswGZt9qnVYhy7wNfg==
X-Received: by 2002:a17:906:5dd9:b0:99d:ec81:df58 with SMTP id p25-20020a1709065dd900b0099dec81df58mr13705838ejv.19.1692968195305;
        Fri, 25 Aug 2023 05:56:35 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00999bb1e01dfsm923359eja.52.2023.08.25.05.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 05:56:34 -0700 (PDT)
Message-ID: <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org>
Date:   Fri, 25 Aug 2023 14:56:33 +0200
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
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
 <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 13:32, Binbin Zhou wrote:
> Hi Krzysztof:
> 
> Thanks for your detailed reply.
> 
> On Tue, Aug 22, 2023 at 4:30 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/08/2023 10:13, Binbin Zhou wrote:
>>> Hi Krzysztof:
>>>
>>> Thanks for your detailed reply.
>>>
>>> On Tue, Aug 22, 2023 at 1:44 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 21/08/2023 08:13, Binbin Zhou wrote:
>>>>> Since commit f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add
>>>>> Loongson-2K1000 LIOINTC"), the loongson liointc supports configuring
>>>>> routes for 64-bit interrupt sources.
>>>>>
>>>>> For liointc-2.0, we need to define two liointc nodes in dts, one for
>>>>> "0-31" interrupt sources and the other for "32-63" interrupt sources.
>>>>> This applies to mips Loongson-2K1000.
>>>>>
>>>>> Unfortunately, there are some warnings about "loongson,liointc-2.0":
>>>>> 1. "interrupt-names" should be "required", the driver gets the parent
>>>>> interrupts through it.
>>>>
>>>> No, why? Parent? This does not make sense.
>>>
>>> This was noted in the v1 patch discussion. The liointc driver now gets
>>> the parent interrupt via of_irq_get_byname(), so I think the
>>> "interrupt-names" should be "required".
>>
>> of_irq_get_byname() does not give you parent interrupt, but the
>> interrupt. Why do you need parent interrupt and what is it?
>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-loongson-liointc.c?h=v6.5-rc6#n345
>>>
>>> static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
>>>
>>>         for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
>>>                 parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
>>>                 if (parent_irq[i] > 0)
>>>                         have_parent = TRUE;
>>>         }
>>>         if (!have_parent)
>>>                 return -ENODEV;
>>
>> How requiring parents interrupt is related to other changes in this
>> file? One logical change, one patch.
> 
> Yes, that was my mistake, whether or not the interrupt-names need to
> be "required" is another issue. It does not cause a check warning.
> I'll think about it some more.
>>
>> Anyway why did you do it and take it by names? Names here are basically
>> useless if they match indices, so just get interrupt by indices.
> 
> There is a match between interrupts, interrupt names and interrupt maps:
> 
> interrupt->interrupt name->interrupt map
> 2->int0->int_map[0]
> 3->int1->int_map[1]
> 4->int2->int_map[2]
> 5->int3->int_map[3]
> 
> As part of the 2k1000 liointc1 node:
> 
>                 liointc1: interrupt-controller@1fe11440 {
> ....
>                         interrupt-parent = <&cpuintc>;
>                         interrupts = <3>;
>                         interrupt-names = "int1";
> 
>                         loongson,parent_int_map = <0x00000000>, /* int0 */


How did you sneak this property? The version - v2 - which was reviewed
by Rob:
https://lore.kernel.org/all/20190905144316.12527-7-jiaxun.yang@flygoat.com/
did not have it.

Now v3 suddenly appears with Rob's review and this property:
https://lore.kernel.org/all/20200112081416.722218-4-jiaxun.yang@flygoat.com/

Please help me understand this property appeared there and how did you
get it reviewed?

>                                                 <0xffffffff>, /* int1 */
>                                                 <0x00000000>, /* int2 */
>                                                 <0x00000000>; /* int3 */

So now you will keep bringing more hacks for a hacky property. No, this
cannot go on.

Best regards,
Krzysztof

