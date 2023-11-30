Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5F7FEA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjK3IBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjK3IBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:01:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A410CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:01:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b8a4d64b5so554976a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701331301; x=1701936101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gk2JbtMlo6WQoDmF8ccbRSSYTd1fSytcQhz6DQC0L9M=;
        b=Ytu8YzIUxJDm8gZxYeXVVTFCNLG2aV+fdkPX9Vm3O66sY95hAPA+pqYqtJOUOYTzRO
         mntCHF3xruedwG70iXSkSH6tgVw6lHJQQvH1hdyCdH9kZx/iq6FqK8RuXnqNMs8XNrlk
         IljCnriia0wV9vEjptlpByAC5yUhguxA/+BWsui9YXHbAtoc/KmnPv3Odv3kvOzCbqfC
         Qt01FYRa3Gp3UpVtMxjld4flsZAbHRJZNJp6ncH0q5LbIWlkdIwB3Li0etS5pOCr+z4X
         2BkVpo9X7/o/Ww2mjqoqB+5YfBOvFqNhMAXP+N63DmzKgoX6+5gUab1VZXZIy+LCNGee
         qSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331301; x=1701936101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk2JbtMlo6WQoDmF8ccbRSSYTd1fSytcQhz6DQC0L9M=;
        b=XRmR5Pittxyp5ESXVvw+MkWun6Gckie2YyLmkE7R+24y0MdBJGP420BMDiQM06MZdA
         hekZyd0cYPqgpi00122vfhcc8Pnnwt9jRQnFOXOooh7iEFXHD4MvcyOdayyme27mpFsc
         WB8DWNaMKnl5JpFjFHmjqWqgV9n6s30tElLSNezYeKS2Ki0USVtmg6rt2G0fTf0ZCq4Y
         UGE8KKCqrMrHYLrVuxoQ4Y8DHh3tTNx98STKHcqSQbcY4P9w62oUKllUu42R3B8osKg7
         jG6Cc6es22N33o08+7CHljUnHDXLM6gFAjOWkRHQxfvMr5c8ZfUxkTkdqwEW/miqowzl
         tvYA==
X-Gm-Message-State: AOJu0YwInnNWygH97ETM5Z4zd2dd+mma9raunFQXtfUw1zynOPSA/nwO
        OXD/iGJgYrEJ3F7mbStZNG/lsiliZTK7MSae9Jk=
X-Google-Smtp-Source: AGHT+IHNM7VsJ8U2JIjdtjCguhq6a0MblOnIQOqCBIDRxqJp1d4EDgJ10iue6LDC42RswFndilTUKQ==
X-Received: by 2002:aa7:db8d:0:b0:54b:dc3c:7c9e with SMTP id u13-20020aa7db8d000000b0054bdc3c7c9emr2540356edt.31.1701331301566;
        Thu, 30 Nov 2023 00:01:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7df96000000b0054b3a6243b1sm291363edy.71.2023.11.30.00.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:01:41 -0800 (PST)
Message-ID: <15a46a91-d539-4580-b676-1177fc0530a5@linaro.org>
Date:   Thu, 30 Nov 2023 09:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: sophgo: Add SG2042 clock generator driver
Content-Language: en-US
To:     Chen Wang <unicorn_wang@outlook.com>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701044106.git.unicorn_wang@outlook.com>
 <c06130afb4bdc1890b4e8d29388fa6feef1f1826.1701044106.git.unicorn_wang@outlook.com>
 <81d421c8-bfd6-42b5-9da1-f067792f8f48@linaro.org>
 <MA0P287MB03329CFBA3BB6A4E4F322F99FEBDA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <2a268c8c-ce55-4321-b390-092b8df61407@linaro.org>
 <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 07:37, Chen Wang wrote:
> 
> On 2023/11/27 17:16, Krzysztof Kozlowski wrote:
>> On 27/11/2023 09:07, Chen Wang wrote:
>>> On 2023/11/27 15:12, Krzysztof Kozlowski wrote:
>>>> On 27/11/2023 02:15, Chen Wang wrote:
>>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>>
>>>>> Add a driver for the SOPHGO SG2042 clock generator.
>>>>>
>>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> ...
>>>>
>>>> +}
>>>> +
>>>> +CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init);
>>>> No, this should be platform device. It's a child of another device, so
>>>> you cannot use other way of init ordering.
>>> hi, Krzysztof,
>>>
>>> Thanks for your review.
>>>
>>> I don't quite understand your opinion. Do you mean CLK_OF_DECLARE is
>>> only used for platform device so it can not be use here? But I think
>> No, I meant you mix init ordering: you depend now on syscon earlier
>> initcall than CLK_OF_DECLARE. Do you remember which one is first? If
>> anything changes here, your driver is broken. There is no dependency, no
>> probe deferral.
> 
> hi, Krzysztof,
> 
> I found that the initcall method cannot be used for the clock controller 
> of sg2042. We need to initialize the clock earlier because there are two 
> dw-apb-timers in sg2042 (Sorry, I have not added them in the current DTS 
> of sg2042, will be submitted later). The initialization of these timers 
> (timer_probe()) depends on the initialization of the clock controller. 
> If we use the initcall mechanism, it will be too late for the timer. So 
> it seems better to use CLK_OF_DECLARE provided by CCF.

Sure, that's fine, but don't use syscon in such case.

> 
> I have a question here that I would like to discuss. The design of 
> sg2042 is like this, according to the design of memorymap in its TRM:
> 
> 070:3001:0000 ~ 070:3001:0FFF SYS_CTRL 4K
> 070:3001:1000 ~ 070:3001:1FFF PINMUX 4K
> 070:3001:2000 ~ 070:3001:2FFF CLOCK 4K
> 070:3001:3000 ~ 070:3001:3FFF RESET 4K
> 
> But also as per hw design (I don't know why and I don't like it also :( 
> ), some of the PLL/GATE CLOCK control registers are defined in the scope 
> of SYS_CTRL, and others are defined in the scope of CLOCK. That's why in 
> the current code, I define the syscon node corresponding to SYS_CTRL. 
> The purpose is just to get the regmap of syscon for the clock controller 
> through the device tree (through device_node_to_regmap()), so that the 
> syscon defined in SYS_CTRL can be accessed through the regmap from 
> clock. The clock controller driver itself does not rely on other 
> operations of syscon.
> 
> So based on the above analysis, is it still necessary for us to define 
> the clock controller as a child node of syscon? In the version v1 of 
> this patch, I actually did not define the clock controller as a child 
> node of syscon, but only accessed syscon through the phandle method. [1]

I have impression you ask me if your solution is ok, but I already
pointed the problem. Address the problem - how do you enforce ordering
of syscon and CLK_OF_DECLARE? What initcalls are both?

> 
> After more read of the TRM, I believe this situation only exists for 
> clock. That is to say, there will be only one child node of clook under 
> syscon. From a hardware design perspective, CLOCK and SYS_CTRL are two 
> different blocks. So I think it is better to restore the original 
> method, that is, restore clock and syscon to nodes of the same level, 
> and let clock use phandle to access syscon.
> 
> What do you think or do you have any good suggestions?


Best regards,
Krzysztof

