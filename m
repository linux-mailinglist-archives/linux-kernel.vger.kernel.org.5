Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFB7D3A68
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjJWPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:11:42 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD15190
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:11:40 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b3f6f330d4so1851399b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698073900; x=1698678700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3pUWaYV0MHOvPseFbWxT/RBFgiDxlKuLFygzevJvjk=;
        b=dl1JE0YsBAkUOFDYm2zcWpwEePuF8vKNc6TKs0MAmQPz9CpU30nqoQte9+PBDm8AY/
         3c57193hK5hYlqGceF6jjwACbI4/N9BsD7Cy7yf0TwDz+OS+HNfkIt46QDArXp7uxfIw
         7/sbCDzAnbywWK8BCLAeUv+xbIdkHtsT8S/+95O0DMrRjm2Rz5T6DoUtQsSaC3u3bave
         VZ4qkJdvD1PDZkCRKufL+8H0RTLum4wW8YBSJcBHAihWHCbOgURlOmo07koRrjk5yJc4
         sXzPPbc+xuNBRjTyKJzENGTBNtX0lzkl17O1jlsbOHa45MQUi8UgeFxJW67KwML5y7vM
         A42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073900; x=1698678700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pUWaYV0MHOvPseFbWxT/RBFgiDxlKuLFygzevJvjk=;
        b=ORF+h17REK1d3FZCdklzYF5+bnBCgPZT7DQUvFygISZkWG0YVGgRr/rhrKip2l8/Xl
         RwGqHuyKNMrOnUm9H6hvywTLU1reFBjiM9jSlZARWGWGbkSaQGcCUJsGEYIFk8UEkTuQ
         +EjXHldyYcbxQ4HezU0uU3PLkwbPu4cGJFCOk/kA0TC1nczLFvbbi6WCo3r9onGNIahH
         8fZ+S9iBNMae4CTE9gIM8DKSzBtCyl0ZR0u0uiPj7B00fKLAZFedA363RSo2+9D+Tu5R
         0asr/moncRmSdU3mQJC+z+EO7eNoV5KZJb5GU4x1zq1w8RxhJxBEk+TgT2jif3ap77BI
         R0MQ==
X-Gm-Message-State: AOJu0YzXSBjFY1/Bf4slCuaISUYcsXLEMV+WR2qKq+Mug8acXYu6J14L
        kolRzL0N+7LeYztiP04VymmmRg==
X-Google-Smtp-Source: AGHT+IGcKp4/eFPOWrpY5TtmEIBGpd+oYq18I+HIjdd/mGHJ37Djqu2HS8GusX9DKnUfaoEQWTwTrw==
X-Received: by 2002:a05:6808:188:b0:3a7:4876:6044 with SMTP id w8-20020a056808018800b003a748766044mr10467355oic.52.1698073900151;
        Mon, 23 Oct 2023 08:11:40 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id 4-20020aca1004000000b003af642cf646sm1513574oiq.37.2023.10.23.08.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 08:11:39 -0700 (PDT)
Message-ID: <724521b8-9c63-4645-b3e0-30d9635573a7@linaro.org>
Date:   Mon, 23 Oct 2023 09:11:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231023104820.849461819@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see lots of errors on Arm 32-bits:

-----8<-----
/builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
   .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
            ^~~~~~~~~~~~~~~~~
            IS_IMMUTABLE
/builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
   GPIOCHIP_IRQ_RESOURCE_HELPERS,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/builds/linux/drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct initializer
/builds/linux/drivers/gpio/gpio-vf610.c:251:2: note: (near initialization for 'vf610_irqchip')
/builds/linux/drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
/builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of function 'gpio_irq_chip_set_chip'; did you mean 'gpiochip_get_data'? [-Werror=implicit-function-declaration]
   gpio_irq_chip_set_chip(girq, &vf610_irqchip);
   ^~~~~~~~~~~~~~~~~~~~~~
   gpiochip_get_data
cc1: some warnings being treated as errors
----->8-----

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Affected builds:
* clang-17-defconfig                  arm
* clang-17-imx_v6_v7_defconfig        arm
* clang-17-lkftconfig                 arm
* clang-17-lkftconfig-no-kselftest-frag arm
* clang-nightly-lkftconfig-kselftest  arm
* gcc-8-defconfig                     arm
* gcc-8-imx_v6_v7_defconfig           arm
* gcc-12-defconfig                    arm
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

