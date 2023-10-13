Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DE7C8CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:02:53 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A0183
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:02:51 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rMUhqaaBzkfHLrMUhqcUIu; Fri, 13 Oct 2023 20:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697220168;
        bh=NVMlKi0Ro6tacSy1oqTleeHU5gL+W4vRlQ2xPUmqato=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VWVBjoSg+j9tX7rfu1EGummEofoSRP3jveJzFsExGbpmufaeDT2jPJA6GpY2hiB5o
         j0lcFAYA0YMk1he1pZIT2JvwcbFoxf/fyBLexbLJ4nTsVQVDBimbRYsX20rOTvYk0A
         cpmfSzhJUpgk8C8NHw/M6W1u2u3t8W49bhbfIfU3yoNjMK3FIbKwQsRo76416XEbtO
         e9M+7iiQQSJbVIb+3leHCf1JFuIacb4l51oHKY0Dk4NXUqTWW/lVlgKPzQLniL23BL
         m18HkmVxt/piiqnPyXnAWx+3RO6rLRVd9c+F5xO35z7i9H3yn9zwsK83Xyg/Q/u1LO
         w7xS1oKfiAqAA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 13 Oct 2023 20:02:48 +0200
X-ME-IP: 86.243.2.178
Message-ID: <276ed249-9ee8-4dc9-871f-9c449eb00bcf@wanadoo.fr>
Date:   Fri, 13 Oct 2023 20:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] clocksource: Add JH7110 timer driver
To:     xingyu.wu@starfivetech.com
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, p.zabel@pengutronix.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        samin.guo@starfivetech.com, tglx@linutronix.de,
        walker.chen@starfivetech.com
References: <20231012081015.33121-1-xingyu.wu@starfivetech.com>
 <20231012081015.33121-3-xingyu.wu@starfivetech.com>
 <338544e7-0be8-47c1-a7d7-89990da305d3@wanadoo.fr>
 <926ee8c7-fab9-49d5-831e-48c886c4bc44@starfivetech.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <926ee8c7-fab9-49d5-831e-48c886c4bc44@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/10/2023 à 11:34, Xingyu Wu a écrit :
> On 2023/10/13 1:53, Christophe JAILLET wrote:
>> Le 12/10/2023 à 10:10, Xingyu Wu a écrit :
>>> Add timer driver for the StarFive JH7110 SoC.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg-XMD5yJDbdMStu3cLTcvVIw@public.gmane.orge.org>
>>
>> ...
> 
> It looks normal in my email and the web. Is this due to some settings?

Hi,

I use gmane.org and a news reader (Thunderbird).
Gmane sometimes (not always!) obfuscate e-mail addresses.

Do not pay attantion to these strange rewritten addresses.

> 
>>
>>> +static int jh7110_timer_probe(struct platform_device *pdev)
>>> +{
>>> +    struct jh7110_clkevt *clkevt[JH7110_TIMER_CH_MAX];
>>> +    char name[4];
>>> +    struct clk *pclk;
>>> +    struct reset_control *rst;
>>> +    int ch;
>>> +    int ret;
>>> +    void __iomem *base;
>>> +
>>> +    base = devm_platform_ioremap_resource(pdev, 0);
>>> +    if (IS_ERR(base))
>>> +        return dev_err_probe(&pdev->dev, PTR_ERR(base),
>>> +                     "failed to map registers\n");
>>> +
>>> +    rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
>>> +    if (IS_ERR(rst))
>>> +        return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
>>> +
>>> +    pclk = devm_clk_get_enabled(&pdev->dev, "apb");
>>> +    if (IS_ERR(pclk))
>>> +        return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
>>> +                     "failed to get & enable apb clock\n");
>>> +
>>> +    ret = reset_control_deassert(rst);
>>> +    if (ret)
>>> +        return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n");
>>
>> Hi,
>>
>> I'm not very familiar with the reset_control_[de]assert() functions, but shouldn't this be undone by a reset_control_assert() call if an error occurs later?
> 
> In this case, the reset controller is set from 'assert' state to 'deassert' state. If it is failed and still 'assert' state, I don't think it need to call reset_control_assert().

Emil already explained what I meaned (sorry for not being clear enough).
I do agree with his proposed approach.

> 
>>
>>> +
>>> +    for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
>>> +        clkevt[ch] = devm_kzalloc(&pdev->dev, sizeof(*clkevt[ch]), GFP_KERNEL);
>>> +        if (!clkevt[ch])
>>> +            return -ENOMEM;
>>> +
>>> +        snprintf(name, sizeof(name), "ch%d", ch);
>>> +
>>> +        clkevt[ch]->base = base + JH7110_TIMER_CH_BASE(ch);
>>> +        /* Ensure timer is disabled */
>>> +        jh7110_timer_disable(clkevt[ch]);
>>> +
>>> +        rst = devm_reset_control_get_exclusive(&pdev->dev, name);
>>> +        if (IS_ERR(rst))
>>> +            return PTR_ERR(rst);
>>> +
>>> +        clkevt[ch]->clk = devm_clk_get_enabled(&pdev->dev, name);
>>> +        if (IS_ERR(clkevt[ch]->clk))
>>> +            return PTR_ERR(clkevt[ch]->clk);
>>> +
>>> +        ret = reset_control_deassert(rst);
>>> +        if (ret)
>>> +            return ret;
>>
>> Same here.
>>
>>> +
>>> +        clkevt[ch]->evt.irq = platform_get_irq(pdev, ch);
>>> +        if (clkevt[ch]->evt.irq < 0)
>>> +            return clkevt[ch]->evt.irq;
>>> +
>>> +        snprintf(clkevt[ch]->name, sizeof(clkevt[ch]->name), "%s.ch%d", pdev->name, ch);
>>> +        jh7110_clockevents_register(clkevt[ch]);
>>> +
>>> +        ret = devm_request_irq(&pdev->dev, clkevt[ch]->evt.irq, jh7110_timer_interrupt,
>>> +                       IRQF_TIMER | IRQF_IRQPOLL,
>>> +                       clkevt[ch]->name, &clkevt[ch]->evt);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        ret = jh7110_clocksource_init(clkevt[ch]);
>>
>> Does something should be done if this fails?
>>
>> CJ
> 
> Yes, it should be call reset_control_assert() here and I will add it in next version.

My point was for the above reset_control_assert() but also for the 
resources allocated within this for loop.

I have not checked all paths, but in case of error in the probe:
   - There is another reset_control_deassert()

   - jh7110_clocksource_init() --> jh7110_timer_int_init_enable() --> 
jh7110_timer_enable()
     Should jh7110_timer_disable() be called?

   - jh7110_clocksource_init() --> clocksource_register_hz().
     Should clocksource_unregister() be called?

If I'm correct and depending on how you update the code, a .remove 
function may be needed as well.

CJ

> 
>>
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id jh7110_timer_match[] = {
>>> +    { .compatible = "starfive,jh7110-timer", },
>>> +    { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
>>> +
>>> +static struct platform_driver jh7110_timer_driver = {
>>> +    .probe = jh7110_timer_probe,
>>> +    .driver = {
>>> +        .name = "jh7110-timer",
>>> +        .of_match_table = jh7110_timer_match,
>>> +    },
>>> +};
>>> +module_platform_driver(jh7110_timer_driver);
>>> +
>>> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu-bONrM45KWFOXmMXjJBpWqg-XMD5yJDbdMRS5n6/RkiaJA@public.gmane.orgne.org>");
>>> +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
>>> +MODULE_LICENSE("GPL");
>>
> 
> Thanks,
> Xingyu Wu
> 
> 
> 

