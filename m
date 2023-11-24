Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47137F8311
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbjKXTNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKXTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:13:32 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401C2701
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:13:38 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2e330033fso1340605b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700853218; x=1701458018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2IO8yizkwbvbCYaFuIwyJ6cSJQCDEdd8cDV+Lv5n8E=;
        b=JKKMe4bE6W9BSAmHdyq/FTnUX7O06Xb2c9HvVg5moUF1ntnWvLQBHSKmDX6v2i3I1D
         YH31clLVDtjEwXDolN2424hRocwHAZDE2/R9LrQf45bovMC5z9KhiC1H0ak8e9DMh+i+
         6oiGJIvHRSjuf1VUDItsSE2qIZWeAOc24iYTM4qjNI1rPPgESaDha9km4pEKWYQ3mzOm
         oyrbI04JsrMJLnckcgkqC/Vn6skCUU/pGF+hR+pMX/W7c3oYEcKjZ21BPitKzpPG0dJc
         rT2IOz6QbzIrFbjDFZqoeHTb37s4sY6kYY2nWkqt3qM8k5b5ay+8XihCJexZQ+H5kZqC
         519Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853218; x=1701458018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2IO8yizkwbvbCYaFuIwyJ6cSJQCDEdd8cDV+Lv5n8E=;
        b=UdhvJ+d+j6lm5Q4KSMYBbh4xurI9J8fC6xWmHgtvzhQroEWa0hJTGtsq38p6WtpV4G
         E6CCvcNZNAX2ub3IujTtNtEljfl1r00XgLS/695mlXX3++TAxiwsabtadUFpH/f85Yux
         mFGeZcQud+MXewUcIDqRLVQwjSFT9CNM1L5L8D0u3KBBOqF7y/v+8+f82A8je/H1xkKJ
         niPtZ0oxh0Df6FQtybCydF/msnmnhuyr8w2GEnL/062qA+S4Ovs41S26b3EsPfwsNz7+
         NOzgQCoSFd5yk1AK/e/XzG47iwqZcRK63KsIO0swOxPNAnnja+FCCEDZuG21B4CwVw+e
         exsw==
X-Gm-Message-State: AOJu0Yz3gFEhRb5J3PhTYs19jGHfYWXDktqCvGj6VmWuRgzBdZJKM7AO
        fNjlkmkf5eRmfRkhoKYbjbT7Kg==
X-Google-Smtp-Source: AGHT+IH/0sXZh5zqfrmOwBVpS6YXkNjXU+rhXoICsM0imj/RkzJhHK8GyS3CVsMYOcx8rQNu/MGYPw==
X-Received: by 2002:a05:6870:b10:b0:1ef:62fc:d51c with SMTP id lh16-20020a0568700b1000b001ef62fcd51cmr4609887oab.51.1700853218070;
        Fri, 24 Nov 2023 11:13:38 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id lc28-20020a056871419c00b001f9ef405fd7sm467750oab.24.2023.11.24.11.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:13:37 -0800 (PST)
Message-ID: <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
Date:   Fri, 24 Nov 2023 13:13:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231124171934.122298957@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231124171934.122298957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24/11/23 11:49 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.300 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see this failure on Arm32:
-----8<-----
   /builds/linux/drivers/tty/serial/meson_uart.c: In function 'meson_uart_probe':
   /builds/linux/drivers/tty/serial/meson_uart.c:728:13: error: 'struct uart_port' has no member named 'has_sysrq'
     728 |         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
         |             ^~
   make[4]: *** [/builds/linux/scripts/Makefile.build:303: drivers/tty/serial/meson_uart.o] Error 1
----->8-----

And this one on Arm64:
-----8<-----
   /builds/linux/kernel/profile.c: In function 'profile_dead_cpu':
   /builds/linux/kernel/profile.c:346:27: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
     346 |         if (prof_cpu_mask != NULL)
         |                           ^~
   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
      49 | static cpumask_var_t prof_cpu_mask;
         |                      ^~~~~~~~~~~~~
   /builds/linux/kernel/profile.c: In function 'profile_online_cpu':
   /builds/linux/kernel/profile.c:383:27: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
     383 |         if (prof_cpu_mask != NULL)
         |                           ^~
   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
      49 | static cpumask_var_t prof_cpu_mask;
         |                      ^~~~~~~~~~~~~
   /builds/linux/kernel/profile.c: In function 'profile_tick':
   /builds/linux/kernel/profile.c:413:47: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
     413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
         |                                               ^~
   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
      49 | static cpumask_var_t prof_cpu_mask;
         |                      ^~~~~~~~~~~~~
----->8-----

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

