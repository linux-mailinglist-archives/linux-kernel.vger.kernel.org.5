Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64EB7C9BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJOVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJOVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:41:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4648EC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 14:41:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40666aa674fso38865015e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697406060; x=1698010860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vasgdJcIR8t4kKbY/unC9gW0uC/S/ezuHWy3+bZQjrE=;
        b=FTn7DlZa4RXp2rqjMNhB6QgLs6bXl1cunH4Bvhrfhaa59+0nkQFABxhWR8h6SnowNi
         l7A0roK3EMypwo073Zs6EKkdRQrDgPlXhv7fUiROyqGnSj64EGeu0MjqfMENgSeSEsq2
         8hKZBTjlJbBQnSzALtp4Fj/mQFRen3DNiT+ENownZ0E1N5gCthWZ2vIpHmifkNrLJOuX
         UbfHo2ZWugQ0YyCY/VCDnbVcy1LLXOfbyzgImLmdlO1n9FZzdNTO3r+kqjsEKmm4rPsX
         ClQfOzTcQMI9/y3M2GcXvnvahsM+/g5/e1sfSV3f8nbVGBHCu97GAXtJsUD+BLLkwgG3
         96vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697406060; x=1698010860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vasgdJcIR8t4kKbY/unC9gW0uC/S/ezuHWy3+bZQjrE=;
        b=EiKzoJv6FuH6rsIo9UBAcPE7MbZfDWLRSqLbo3+A/olOYxDzQUXJj0apCUsmyq5qlm
         DQleGoHZWpiqy5G5oLnVrhIXcirc/zNx6MWKYwshLXV+WNait1xW/jiXrFZc1lCps+Rb
         ye8ENinyvdAXkqwdwyxbMEfqpgJtM7fkpUsmlflKuCAUz1GpZ6gCgnl7AXe8cGqO1SoC
         jMuZvOaydpYCDnC6TYUTi6SmjUaIEwrfKSsC9PckpL3y0HIuDHLwskGroMKUKI5AX4W9
         gLhZTKOQuYJ3LbqArtuWOfTGurtNT+t9gwAXLwiWcjSpXjqJJIuDJZbSe8dOeTn1AYDL
         fFGQ==
X-Gm-Message-State: AOJu0Yyq9DP9dPQb218mLQeHfLcvNxo7vi0hRkF4fhUFiFzkzTo4Vqc+
        XZPK4fJhji2XVW4I8npa5psf3g==
X-Google-Smtp-Source: AGHT+IEZ2DhcSdelheUvQddLLepTYDUO8jZOt1NxihLNBJDSD67r4wySBoAxeinTNSBTwyp0PkwpCw==
X-Received: by 2002:a7b:c393:0:b0:401:bd2e:49fc with SMTP id s19-20020a7bc393000000b00401bd2e49fcmr28961958wmj.24.1697406059719;
        Sun, 15 Oct 2023 14:40:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id m4-20020a5d4a04000000b0031980783d78sm4174069wrq.54.2023.10.15.14.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 14:40:59 -0700 (PDT)
Message-ID: <c4aa8229-de78-4a84-a3a7-5f896866dd54@linaro.org>
Date:   Sun, 15 Oct 2023 23:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/42] clocksource: ep93xx: Add driver for Cirrus Logic
 EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Rewrite EP93xx timer driver located in arch/arm/mach-ep93xx/timer-ep93xx.c
> trying to do everything the device tree way:
> 
> - Make every IO-access relative to a base address and dynamic
>    so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

