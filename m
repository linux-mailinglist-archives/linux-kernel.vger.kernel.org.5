Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09575FC35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGXQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjGXQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:32:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6F1BFB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:31:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9923833737eso669011366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690216296; x=1690821096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAaRP/7HZ3d+JfrDjeTlMFqmk216YDOdKu9YOmxZLp4=;
        b=gj+0NAcYqfuTAmgQO+T6jIKLT8Ct7yUE4lWVfKSChT8+368v/blv/mBhpbxsHnIoWB
         u5GZHhuVMW5cikmh6y0+vKtbfpHtLa2jUktHC5sb+1jLALwf1r03oQLx6lTPR7dByrgx
         Nf94H6vE0b/5PUZMJfLVztiF11M41pWSWVWonxJvejclljgfwumdNranCLtQACJsbt61
         Rt68FU3cOdLLaH9YXZCYU/OKJLy0HsA4JxY98FPy5HPAXmNw9dPsQD56qoLpixAUnVaN
         7lQhUL8yQe4LnH8n0S5sqdHdrjdGZKICTbR7GrAB3Iu1FnLd2qEGe9SKmcCuIugh/Gc8
         TQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216296; x=1690821096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAaRP/7HZ3d+JfrDjeTlMFqmk216YDOdKu9YOmxZLp4=;
        b=i/xZ86eWtt+lJ/utvA9TC5lGRD3CQBKfveEk2pglfVFpGbx743WD1TocFSp4YSnjKF
         8jHvwgtiovXbLDGiH6oapFPaIJ19mFTL13d01YmBiy831V9Z2+aGjAUGT4Nj4l3cuIIO
         vTeIMWdgalIHV158JIqwT728BPQnAMCJu2wusYQHeP9Yts9syWULhK2POhlXSUtrNJYP
         SHKTDvUrfs2x1BtXVJrSVyXq10x3RzjBRRTZyF/jXnJUkJe1DhxC6VIkfQ7VclgmjSt2
         kNH3b2bq1wn14mWI8x7j4j4zI7es7F2jutxKUGU7+n1gbl+6ve2Fx9Jw5R+qBuJN8zjS
         y88g==
X-Gm-Message-State: ABy/qLYI9/VFYG9hG93Kj8mTr2eSMRHWb73kyNog2QqM1bD6LCZmX7l6
        dhNU70ewRXR3VNcc1Pdyeg8C3g==
X-Google-Smtp-Source: APBJJlHr1rMjS5i9JLRVOJjOvm0Kd2jE6bO0zrxl0X8m3yYCOsUwONwLc8MaD0LcYx+QGTC0YCf3Xg==
X-Received: by 2002:a17:907:2bcb:b0:98e:f13:e908 with SMTP id gv11-20020a1709072bcb00b0098e0f13e908mr9774146ejc.60.1690216295715;
        Mon, 24 Jul 2023 09:31:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906165a00b00992b2c5598csm6898669ejd.128.2023.07.24.09.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:31:35 -0700 (PDT)
Message-ID: <886e29ec-a290-993a-d99a-d5fd90662e99@linaro.org>
Date:   Mon, 24 Jul 2023 18:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
 <0ec81b89-4d4c-4e13-5ea0-697f5c0af835@linaro.org>
 <4073daf401a820c0f64e6fa813b5253bd0427bcd.camel@maquefel.me>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4073daf401a820c0f64e6fa813b5253bd0427bcd.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 17:02, Nikita Shubin wrote:
>>> +static DEFINE_SPINLOCK(ep93xx_swlock);
>>> +
>>> +/* EP93xx System Controller software locked register write */
>>> +void ep93xx_syscon_swlocked_write(struct regmap *map, unsigned int
>>> reg, unsigned int val)
>>> +{
>>> +       unsigned long flags;
>>> +
>>> +       spin_lock_irqsave(&ep93xx_swlock, flags);
>>> +
>>> +       regmap_write(map, EP93XX_SYSCON_SWLOCK,
>>> EP93XX_SWLOCK_MAGICK);
>>> +       regmap_write(map, reg, val);
>>> +
>>> +       spin_unlock_irqrestore(&ep93xx_swlock, flags);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(ep93xx_syscon_swlocked_write, EP93XX_SOC);
>>
>> I doubt that your code compiles. Didn't you add a user of this in
>> some
>> earlier patch?
>>
>> Anyway, no, drop it, don't export some weird calls from core initcall
>> to
>> drivers. You violate layering and driver encapsulation. There is no
>> dependency/probe ordering.
>>
>> There is no even need for this, because this code does not use it!
> 
> It's a little emotional, so i can hardly understand the exact reason of
> dissatisfaction.
> 
> Are you against usage of EXPORT_SYMBOL_NS_GPL ? - then indeed my fault
> it's not needed as both PINCTRL and CLK (the only users of this code)
> can't be built as modules.

I am against any exported symbols and most of functions visible outside
of this driver.

...

>>> +
>>> +       pr_info("EP93xx SoC revision %s\n", attrs->revision);
>>> +
>>> +       return 0;
>>> +}
>>> +core_initcall(ep93xx_soc_init);
>>
>> That's not the way to add soc driver. You need a proper driver for it
> 
> What is a proper driver for these ? 

Usually platform_driver, e.g. exynos-chipid.

> 
> Even the latest additions in drivers/soc/* go with *_initcall.

Which one? Ones which call platform_driver_register()? That's quite
different story, isn't it? I don't see other recent cases, except
regulator couplers. They might be, some people send and accept poor
code, so what do you expect from us? Crappy code got in once, so more of
it can go?

> 
> The only i can see is:
>  ./versatile/soc-
> realview.c:132:builtin_platform_driver(realview_soc_driver);
> 
> By Linus =).

20 years ago module parameters were quite popular. Try to add one now, I
know what comment you will get. Just because something was added by
someone some time ago, is not a reason to do the same. Things change,
Linux changed.

Best regards,
Krzysztof

