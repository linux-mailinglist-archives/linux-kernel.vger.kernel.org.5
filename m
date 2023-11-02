Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432BF7DF50D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjKBOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjKBOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:30:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB8D7E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:29:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso274124f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698935379; x=1699540179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zTIXrfkswX74UPgsg79qK4Ca7pyfesNXn6v+dgCKc8=;
        b=Ajkelu3tJZ6qlpnLxibTPuXpJ7zDqzkHgethk5yy4oph04AhBlv27oDqcBSdRApLdn
         vIEx9prhaU8GL45jFczNjkZ2m0L1RTT/AxG1dEDLYaWlfHhlQbfI2WkAHeMErte9Lsf9
         euQvlB8bzv8fhQCVB1fON5f3awjTlbhLijH5yu/pVXjOQEtn0lEiaXqsLumGkiOhBo+l
         OiUDr4o4XQRSO5CM22DmGWh32FZvPsGjq1b9ry1BZy0grFITUZHhz75mqHJTKtHN6FVV
         apywaWaORAuag/ltC4cRoBRr97XJ0jtednvdaMVuovX0TEuWP45n3qU8neP/4WZ50pfl
         XXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935379; x=1699540179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zTIXrfkswX74UPgsg79qK4Ca7pyfesNXn6v+dgCKc8=;
        b=LM3UNk9lmNBSO503GoVfRfAFYb3EnV08aaXA2Rnz80vCIOzgS/pBNFdAxgPV45bEh9
         krHFPO+RPhIdeAYcvHYH/ms25AJTHD47HhpIyNxmyj7IhuZY/VBeorRvIwXygBBla4il
         chw4qsEqU0ndlHbHYjBeUDk+UdXhkzTgdOJFpwzA059mQSIyRwVGZFjOeuCjmqrF1IqW
         t1mM1euTxstaGZ5M5J9+Cbf+zhkTHgFjQUDWViFIOY55BHGl1jbH2b2bvZdwoxnJx442
         ElKPXN7aCLNQS//jyaYkIQXkw07wIOSEskfNurPWWOYYV0su6VO6rkjNjZWxblGCkJOp
         TKkA==
X-Gm-Message-State: AOJu0YzLx0KH0gHd5WgQuOkfw7z+rbduAdXycK1Su4J11q2yj2EODlQM
        6a1Wz+8G9qAPVRvwK/MYfVuGdQ==
X-Google-Smtp-Source: AGHT+IGgX2MJYo2ApjloC6Zm/yknBo7VGdemxbW/96ZkWLnzIPO1lx+Et0ljnlBeTIuHOQiRVzEAWA==
X-Received: by 2002:a5d:4a0c:0:b0:32f:922a:fc49 with SMTP id m12-20020a5d4a0c000000b0032f922afc49mr7100033wrq.21.1698935378579;
        Thu, 02 Nov 2023 07:29:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bd6b:8105:85a4:1102? ([2a05:6e02:1041:c10:bd6b:8105:85a4:1102])
        by smtp.googlemail.com with ESMTPSA id w11-20020adfcd0b000000b00326f0ca3566sm2594397wrm.50.2023.11.02.07.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:29:38 -0700 (PDT)
Message-ID: <a8f0011c-5689-4071-b5e0-90bd6b7c66bc@linaro.org>
Date:   Thu, 2 Nov 2023 15:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Walker Chen <walker.chen@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20231019053501.46899-1-xingyu.wu@starfivetech.com>
 <20231019053501.46899-3-xingyu.wu@starfivetech.com>
 <3f76f965-7c7b-109e-2ee0-3033e332e84b@linaro.org>
 <bb819333-52d3-49fc-9bb9-1a227bd5ca8f@starfivetech.com>
 <d0e70434-e273-4799-c5ec-bbee1b3f5cc7@linaro.org>
 <540136d4-6f8f-49a6-80ff-cc621f2f462b@starfivetech.com>
 <65c38717-3e0c-46d3-a124-29cae48f1a2e@linaro.org>
 <72ad5029-42b2-481a-887f-8f6079d8859b@starfivetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <72ad5029-42b2-481a-887f-8f6079d8859b@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Xingyu,

On 02/11/2023 14:15, Xingyu Wu wrote:

[ ... ]

>>>>>>> +struct jh7110_clkevt { +    struct clock_event_device
>>>>>>> evt; + struct clocksource cs; +    bool cs_is_valid; +
>>>>>>> struct clk *clk; +    struct reset_control *rst; +    u32
>>>>>>> rate; +    u32 reload_val; +    void __iomem *base; +
>>>>>>> char name[sizeof("jh7110-timer.chX")]; +}; + +struct 
>>>>>>> jh7110_timer_priv { +    struct clk *pclk; +    struct 
>>>>>>> reset_control *prst; +    struct jh7110_clkevt 
>>>>>>> clkevt[JH7110_TIMER_CH_MAX];
>>>>>> 
>>>>>> Why do you need several clock events and clock sources ?
>>>>> 
>>>>> This timer has four counters (channels) which run
>>>>> independently. So each counter can have its own clock event
>>>>> and clock source to configure different settings.
>>>> 
>>>> The kernel only needs one clocksource. Usually multiple
>>>> clockevents are per-cpu based system.
>>>> 
>>>> The driver does not seem to have a per cpu timer but just 
>>>> initializing multiple clockevents which will end up unused,
>>>> wasting energy.
>>>> 
>>>> 
>>> 
>>> The board of the StarFive JH7110 SoC has two types of timer : 
>>> riscv-timer and jh7110-timer. It boots by
>>> riscv-timer(clocksource) and the jh7110-timer is optional and
>>> additional. I think I should initialize the four channels of
>>> jh7110-timer as clockevents not clocksource pre-cpu.
>> 
>> If no clocksource is needed on this SoC because riscv timers are
>> used, then it is not useful to register a clocksource for this
>> timer and the corresponding code can go away.
>> 
>> If the clockevent is optional why do you need this driver at all?
>> 
>> 
>> 
> 
> Hi Daniel,
> 
> Sorry, maybe I didn't express it clearly enough. I use this
> jh7110-timer as a global timer on the SoC and riscv-timer as cpu
> local timer. So these are something different.
> 
> These four counters in this jh7110-timer are exactly the same and
> independent of each other. If this timer is used as a global timer,
> do I use only one or all of the counters to register clocksource and
> clockevent?

Yes.

The global timer is only there when the CPU is powered down at idle 
time, so the time framework will switch to the broadcast timer and there 
can be only one instance.

If you register all the counters, only one will be used by the kernel, 
so it pointless to add them all.

On the clocksource side, you may want to question if it is really 
useful. The riscv has a clocksource with a higher rate and flagged as 
continuous [1]. So if the JH7110 clocksource is registered, it won't be 
used too.

Hope that helps

   -- Daniel

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/clocksource/timer-riscv.c#n68

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

