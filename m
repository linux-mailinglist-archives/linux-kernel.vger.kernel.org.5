Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE377D3B84
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjJWPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjJWPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:53:14 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65FE9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:53:12 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57ad95c555eso2186713eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698076391; x=1698681191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pESWV7UJ55d7qINlkbCLhWv7/gJJfRWuDRI1OH0PCg=;
        b=jVHTEq2V620PIvt6JjG9gqIiVjoXZ1nNLg6WWVO1qLBcr9tn8JFgEKJRLwmwCOML9Q
         hg72b8JTDNXquKe1E3OdV4epUyk26mNk0Sb7Q5zjp25VxkVrMaLGxk4OCFasrxzxSimX
         s7NdMJUiRfolK3+KKQF/0i+IrkiFgx+mIhHiHwDTfOJef6hFZ9hCBpwzEwNYDEqq0HiI
         P+5WANSnCtC9EjAJyFpbJ/d3XqBu1xnhDPpPXha0rtNEz3ytuTP0EkrCgeqsa7pYvAJP
         Jy5lw1yvCc1NCyBVCzOmTx7jSymwYMqwLoqHhII0xXx95vZoJUuC6nWYOxvd1sZEu+Nk
         2u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698076391; x=1698681191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pESWV7UJ55d7qINlkbCLhWv7/gJJfRWuDRI1OH0PCg=;
        b=Uumvm4QVE3PHtoqL4nlVntMgoA4LpbRMKqEHW58yACEB6ZB0H+emE4ULHzLkca9RBI
         lybaKhh6bEmqUZDJULdT4QGOrYfWDdxTtvvzIL2/P+VNpdDAF+PazwX2QVBm3QiPOVRG
         8vHGZ/Cd04BtBnP5rZnsMINBzqXGG4dkbCj/h9nG+nhjbRXYGuWAmMwcW78j5yjQpHnm
         p8QUYmWFiu69H10AGmJBoLew456hYzRqeNKY+NjoFX3nW7SYJASOoPbGCUHD6eMnkv9b
         rTb5UGinMAmJP7OfsoJXLQ/G9of6u5v8j55jGUp7FVs03+qjPvxpe9hN9EtnHmLHgAYC
         KJ8g==
X-Gm-Message-State: AOJu0Yw5iX0OdGkM8/O6vNuxbp/1SrLLFA2siEXKzTQkVDEC+JeA827T
        +8b9ot4+xILcN4u90Zhg2gpKPQ==
X-Google-Smtp-Source: AGHT+IErwb2zGwqwo8mngOGoEHja3MbBSskOnAf8uFSdGqj3xWXSUxOxdB5X5QXTg1fIKty78pKpUw==
X-Received: by 2002:a4a:e64f:0:b0:581:e86d:3e87 with SMTP id q15-20020a4ae64f000000b00581e86d3e87mr8864366oot.4.1698076391243;
        Mon, 23 Oct 2023 08:53:11 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id r134-20020a4a378c000000b00582014b0138sm1627506oor.39.2023.10.23.08.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 08:53:10 -0700 (PDT)
Message-ID: <eb759f41-db11-4f2e-b3a0-e9e92dea3196@linaro.org>
Date:   Mon, 23 Oct 2023 09:53:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104817.691299567@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same problems on Arm 32-bits as with 5.10 and 5.15:

-----8<-----
/builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: use of undeclared identifier 'IRQCHIP_IMMUTABLE'
   249 |         .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
       |                  ^
/builds/linux/drivers/gpio/gpio-vf610.c:250:6: error: use of undeclared identifier 'IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND'
   250 |                         | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
       |                           ^
/builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: use of undeclared identifier 'GPIOCHIP_IRQ_RESOURCE_HELPERS'
   251 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
       |         ^
/builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of function 'gpio_irq_chip_set_chip' [-Werror,-Wimplicit-function-declaration]
   340 |         gpio_irq_chip_set_chip(girq, &vf610_irqchip);
       |         ^
4 errors generated.
make[3]: *** [/builds/linux/scripts/Makefile.build:262: drivers/gpio/gpio-vf610.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:497: drivers/gpio] Error 2
/builds/linux/drivers/gpu/drm/drm_lock.c:363:6: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
   363 |          */     mutex_lock(&dev->struct_mutex);
       |                 ^
/builds/linux/drivers/gpu/drm/drm_lock.c:357:2: note: previous statement is here
   357 |         if (!drm_core_check_feature(dev, DRIVER_LEGACY))
       |         ^
1 warning generated.
----->8-----

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Affected builds:
* clang-17-defconfig                  arm
* clang-17-imx_v6_v7_defconfig        arm
* clang-17-lkftconfig                 arm
* clang-17-lkftconfig-no-kselftest-frag arm
* clang-nightly-defconfig             arm
* clang-nightly-imx_v6_v7_defconfig   arm
* clang-nightly-lkftconfig            arm
* clang-nightly-lkftconfig-kselftest  arm
* gcc-8-defconfig                     arm
* gcc-8-imx_v6_v7_defconfig           arm
* gcc-10-lkftconfig                   arm
* gcc-10-lkftconfig-debug             arm
* gcc-10-lkftconfig-debug-kmemleak    arm
* gcc-10-lkftconfig-kselftest-kernel  arm
* gcc-10-lkftconfig-libgpiod          arm
* gcc-10-lkftconfig-perf-kernel       arm
* gcc-10-lkftconfig-rcutorture        arm
* gcc-12-defconfig                    arm
* gcc-12-imx_v6_v7_defconfig          arm
* gcc-12-lkftconfig                   arm
* gcc-12-lkftconfig-debug             arm
* gcc-12-lkftconfig-debug-kmemleak    arm
* gcc-12-lkftconfig-kasan             arm
* gcc-12-lkftconfig-kselftest         arm
* gcc-12-lkftconfig-kunit             arm
* gcc-12-lkftconfig-libgpiod          arm
* gcc-12-lkftconfig-no-kselftest-frag arm
* gcc-12-lkftconfig-perf              arm
* gcc-12-lkftconfig-rcutorture        arm

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

