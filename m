Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997827D3ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjJWP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:29:47 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C525DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:29:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2cc39d12so2346538a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698074984; x=1698679784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Df/ckkvis1oPgnFdWOtaqrVu8o7llaO/MzOzfRXPKFU=;
        b=BmqZo6ZavpzdTyDLBMzNvIjjEspZGMU369Y9Jpvf8i5mek79ovppR9G5dDIz775VIV
         vjNFHjC+oCI5arC2gOkZCIgKY2OT3zGQm3aGkiDrY8DD0lZLpdYU1aMRIN9co2CqLeKd
         Sl4paCRDYaKjK2KY2hZpMGtfIISuY3tlPqkloJg0L2MQgw/7LxotcQ5Bjz64GgY1abcr
         bVBCzhY2UxTb7VcON3pLpoLLB2TvWfVTWYzAnpFZyRyXWTe9BYLGbx+T3RYWlNwmAUpr
         PRBT9BiVNVUgMgYJECw3DEoNtYQ1o+fphxyfjr/db8DwJ5iQZ6I/e7Brmss4Om7slrmm
         7qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698074984; x=1698679784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Df/ckkvis1oPgnFdWOtaqrVu8o7llaO/MzOzfRXPKFU=;
        b=VBYFgEYN5m2JARsddSEawpV3fkq3AH1sdteCBZdaLFfC3qM+FVhFVCi9m/R3o/OBQn
         EHMeecjzCdj8mSJhOSBlEfutgUuz5KACRRRmumx61lBkbS9kFf+2lSvEDLo1j2yoNsiH
         Bcl+1V4qAnqa1oNfWQqER32UqaO1z49fUhXReB99L1tcdOIc0SzdpHsI55nW4e1wm5kw
         a6AQ7Y2q5vIL3iAq7vRyIur0ZBJLuZv1wBpb23jy9+rYqOjIdszB3U64NanKtUdhWFda
         A7Uyp/mSRglY4XL2h02C6oRYlfch3WuMpAaC24RQXryBJvgSSNA13s3ZV2Fcd1/MP/m8
         kZSw==
X-Gm-Message-State: AOJu0Yx7+UHtg8gFRJeH88+fmjvp+5InH1Jx3XWInCkoB3OC6lq4K4K8
        zscpinH/xcxqQQ/XMbDgZ2vVgw==
X-Google-Smtp-Source: AGHT+IEk4HpqvNSfG2HdlBYVLxnNeHubY0avFEbC0GSyv12pCkrQrwoxI20w2FoA/tz5QOi2vOWS+w==
X-Received: by 2002:a05:6830:4d3:b0:6ce:2733:f71b with SMTP id s19-20020a05683004d300b006ce2733f71bmr9783746otd.26.1698074984668;
        Mon, 23 Oct 2023 08:29:44 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id l11-20020a9d6a8b000000b006cd2c236b8csm1449655otq.3.2023.10.23.08.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 08:29:44 -0700 (PDT)
Message-ID: <f403e53d-69f9-4254-b9db-bdb1912e4cfa@linaro.org>
Date:   Mon, 23 Oct 2023 09:29:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/202] 5.10.199-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104826.569169691@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
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

Hello!

On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same problem as 5.15 with GPIO and Arm 32-bits:

-----8<-----
/builds/linux/drivers/gpio/gpio-vf610.c:249:18: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
   249 |         .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
       |                  ^~~~~~~~~~~~~~~~~
       |                  IS_IMMUTABLE
/builds/linux/drivers/gpio/gpio-vf610.c:251:9: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
   251 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/builds/linux/drivers/gpio/gpio-vf610.c:251:9: warning: excess elements in struct initializer
/builds/linux/drivers/gpio/gpio-vf610.c:251:9: note: (near initialization for 'vf610_irqchip')
/builds/linux/drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
/builds/linux/drivers/gpio/gpio-vf610.c:340:9: error: implicit declaration of function 'gpio_irq_chip_set_chip' [-Werror=implicit-function-declaration]
   340 |         gpio_irq_chip_set_chip(girq, &vf610_irqchip);
       |         ^~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [/builds/linux/scripts/Makefile.build:286: drivers/gpio/gpio-vf610.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:503: drivers/gpio] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1832: drivers] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:192: __sub-make] Error 2
----->8-----

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Affected builds:
* clang-17-defconfig                  arm
* clang-17-lkftconfig                 arm
* clang-17-lkftconfig-no-kselftest-frag arm
* clang-nightly-lkftconfig-kselftest  arm
* gcc-8-defconfig                     arm
* gcc-8-imx_v6_v7_defconfig           arm
* gcc-12-defconfig                    arm
* gcc-12-imx_v6_v7_defconfig          arm
* gcc-12-lkftconfig                   arm
* gcc-12-lkftconfig-debug             arm
* gcc-12-lkftconfig-debug-kmemleak    arm
* gcc-12-lkftconfig-kasan             arm
* gcc-12-lkftconfig-kselftest         arm
* gcc-12-lkftconfig-kselftest-kernel  arm
* gcc-12-lkftconfig-kunit             arm
* gcc-12-lkftconfig-libgpiod          arm
* gcc-12-lkftconfig-no-kselftest-frag arm
* gcc-12-lkftconfig-perf              arm
* gcc-12-lkftconfig-perf-kernel       arm
* gcc-12-lkftconfig-rcutorture        arm

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

