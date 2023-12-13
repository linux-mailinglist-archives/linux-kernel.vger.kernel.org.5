Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C75810E70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjLMK22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLMK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:28:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B3CA7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:28:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2308faedso69029515e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463310; x=1703068110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+ilbxGQf2dBN4ZGznpFNFTwrzoJIiGBNXBpzfNjyCk=;
        b=gVCn5E0M8S2JIE/11MZFU/V4gIcRBX9ODiA8uBLVS+BPq6o4L6u/0Lcl2YG+RmHjFp
         7p9MtZAFGVBIKCmbzya2ZWD6WFDN1auCnYABODVh0wpEGAJX1dj2o7sgUvdjZjHhCN7R
         buiDZg4BP8+XznX2JXJFe1SGwGHrMAXi4C7SqQvX1c7UivuqnnDyKbxLwTMmM5X4/m0M
         JlEXjFvNOKzoKk791w/LovumC7+v+3v8bDgTgtPLUaopO64oDGPHQCibqhPe7f9+8KHR
         uzDRSb5aoRT0r0PzrEk31z2LXLb5lRuZqYs5mDG3o3qaCu5F6e+QGGb8MiVY6D6W0YBx
         zKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463310; x=1703068110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+ilbxGQf2dBN4ZGznpFNFTwrzoJIiGBNXBpzfNjyCk=;
        b=dcTVz9zIJW9uatC+9bZes81XEpVeWP8Dcdof37y8EBWU9lqxgBcZq0h9pOfCqKLIrB
         gaP3dlzINun9aoWMS2J/OwUD5Xhz9zZuwmyXwiNacY4UxI4aEdQtA4EAIlWBviNEHD+u
         OnYLlgOwIzPJVMx4o7RpZHVf//m6yvFCLihGSjXAropndT+GG4WVeoj47NOhlktfZLxA
         WgaWMkjYep5wqmkIaajHi9kUS4vZQkzRw0rNMnqw1Pf8HTkcS/xWccTrSKtm58/ajKy5
         KoGQsXscKpPyaptzsNharR+uv9JjeIj4m4diztDAb7mGxQu9BqtGYpDkCAesh3cbEO4E
         ekMg==
X-Gm-Message-State: AOJu0YygS3HzWcym4yco47sHgKIwzsECrrX/ENOXiYSlw64KrlSIW1VE
        z/MzVSoyWrChla0N9g8S/iFXPYssjNf2lqHyG1s=
X-Google-Smtp-Source: AGHT+IEa9a8cLwijGRXneislZTPwwqhw/3JUZ/VIIgp1t/z+jLOUYDVDm0uFuZTwPxJzvDhvn+0DBg==
X-Received: by 2002:a05:600c:4f11:b0:40c:33f2:dc9c with SMTP id l17-20020a05600c4f1100b0040c33f2dc9cmr3762192wmq.71.1702463310331;
        Wed, 13 Dec 2023 02:28:30 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id az27-20020a05600c601b00b0040c34e763ecsm18952078wmb.44.2023.12.13.02.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:28:29 -0800 (PST)
Message-ID: <6e40d76c-b4e7-4ed9-9d37-f0f7850f07a1@linaro.org>
Date:   Wed, 13 Dec 2023 11:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: ep93xx: fix error handling during probe
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20231212214616.193098-1-arnd@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231212214616.193098-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 22:46, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the interrupt property fails to be parsed, ep93xx_timer_of_init()
> return code ends up uninitialized:
> 
> drivers/clocksource/timer-ep93xx.c:160:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>          if (irq < 0) {
>              ^~~~~~~
> drivers/clocksource/timer-ep93xx.c:188:9: note: uninitialized use occurs here
>          return ret;
>                 ^~~
> drivers/clocksource/timer-ep93xx.c:160:2: note: remove the 'if' if its condition is always false
>          if (irq < 0) {
>          ^~~~~~~~~~~~~~
> 
> Simplify this portion to use the normal construct of just checking
> whether a valid interrupt was returned. Note that irq_of_parse_and_map()
> never returns a negative value and no other callers check for that either.
> 
> Fixes: c28ca80ba3b5 ("clocksource: ep93xx: Add driver for Cirrus Logic EP93xx")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

