Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE875925D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGSKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:08:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304EE69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:08:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso1350585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689761333; x=1692353333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7ivvi8zxCBoju6yZhIUiXa7EGmLcFQWTliPmIJZcZg=;
        b=UjP/xIw+VmXYqgxj0+DTvlLd5bVYuku7z/P9xxhkg8LfahyzqPBqM5DrH+gg5GNkVw
         toc7YWqg+3N0YymIhv5c/43c7bYfpECcLs9ZaFIJXRpKLX7HouPRmfD1/4uOJ/16oLTZ
         gm0oCBYJdn3S0QNndmZgoP1ZFfXxJhY6kdLhgegRZjv8Vmh4FP7U2lEgOcO6SL/34qZx
         o9n6LqnU5DXFXgCHSv8B0O+x2RjNIYXVx2gzmjCjvyLMszC9XR+6dYP/Ifz3DRjymjf4
         GoeYgKS/t7qhbukJOPwRhCfUrR6kTm0d4urnA0efXLUkz57rmz4O4bqKpsl70AJWZB9X
         p9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761333; x=1692353333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7ivvi8zxCBoju6yZhIUiXa7EGmLcFQWTliPmIJZcZg=;
        b=S4waX+dR+Md8y8aYA8OoiPFzEikNH3IY9lW/rFK2iAeI0itj8SwV2ARsfPIOWv+TLW
         5qPM8z8xyfVwgJmU2WVTloZZV9mKWWMGY+f3nwce/VgKZ1spwMCSPrLpuqVgZyZSwt72
         0JRQAswas1RWsC6y6THLETG3XS/xh8t/ARoz4d3FuRPzrAOguuDskwYPMWNwhwgcf07G
         yAToQmhj62v0FnTKhCHIWKFDDRgP71EwSv6uvRQ1Uhs9cSDbXL2m9gKSAlLFYWJwRaQW
         mXBaPkzIB3t+JNhS76aJB+RlerYBP/OSaNxuGKXTuyJOceiQbtdymlxgF0ZvwUMXXWsk
         Cd3A==
X-Gm-Message-State: ABy/qLZahUFyfMBz5hkMg0067n39+hADZ3YOsfCiZCL0WPlPNA8eMYla
        Y8q/sTQi0yoK6qBdTy2n8qCI5NKq81Y9PtKR2S+xzq1J
X-Google-Smtp-Source: APBJJlF7QFvr+ioaHeoqRQ6KCQW387Cgz7tGluQK7cCoSenZaql6Cbm2NC44bu6yHUeqUJz7IPjLJw==
X-Received: by 2002:a05:600c:8615:b0:3fa:9996:8e03 with SMTP id ha21-20020a05600c861500b003fa99968e03mr1420631wmb.10.1689761333432;
        Wed, 19 Jul 2023 03:08:53 -0700 (PDT)
Received: from [192.168.1.70] ([86.71.62.179])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c22da00b003fc07e1908csm1290453wmg.43.2023.07.19.03.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:08:53 -0700 (PDT)
Message-ID: <4db1d958-7b11-40d9-3f68-3e9390539cbe@baylibre.com>
Date:   Wed, 19 Jul 2023 12:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable OMAP watchdog support
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, afd@ti.com
References: <20230718-enable-omap-wd-v2-1-921f829bc0a5@baylibre.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20230718-enable-omap-wd-v2-1-921f829bc0a5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 16:58, Julien Panis wrote:
> Increase build and test coverage by enabling support for OMAP watchdog,
> as used on TI OMAP based boards.
>
> The watchdog timer is an upward counter capable of generating a pulse on
> the reset pin and an interrupt to the device system modules following an
> overflow condition.
>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Maybe this patch should not be applied actually. I have 2 questions:

[Q1] Using the following cmd sequence leads to a modified 'multi_v7_defconfig' file:
       'make multi_v7_defconfig'
       'make savedefconfig'
       'mv defconfig arch/arm/configs/multi_v7_defconfig'
...even without modifying CONFIG_OMAP_WATCHDOG flag.
I guess it's due to modifications in various Kconfig files (dependencies for instance).
And perhaps it's also due to previous modifications of 'multi_v7_defconfig' file that
were not done by using 'make savedefconfig' (?)
How should I handle that for this patch ? This v2 has been created by modifying
'multi_v7_defconfig' file manually. Using 'make savedefconfig' would be cleaner,
but as a result many flags would be re-organized whereas the commit intends to
enable 1 flag only.

[Q2] I would like to add another flag in order to enable CONFIG_RTC_DRV_OMAP.
Is it better grouping CONFIG_OMAP_WATCHDOG and CONFIG_RTC_DRV_OMAP in
a single commit ? What's recommended ?

Julien Panis

