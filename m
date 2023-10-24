Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FF7D4B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjJXIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjJXIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:55:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD918D7E;
        Tue, 24 Oct 2023 01:55:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40806e4106dso24168385e9.1;
        Tue, 24 Oct 2023 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137699; x=1698742499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1736lalVb+Wj8lvqQcjrdbk9CZDipYLCDP3xDqokVo=;
        b=lF/gJrVLSRhigxesn5oEnSylKrsOOEW9ibC0le9MVmXtuPj/o/MGPxhTZkzWbYZzdz
         jBY77rrdBxaASKAVe1DJFsVrBR3Ea8dT1pBAMvdxcuHQxtCC0Mk7Yj8Cmd4A6Nsr2vpd
         Og3YuD6L3NLWOT3p6ltCetN8/Li5M8ykIDXisvGl6CJJnC9rFokh+1orVN4Q9vCZaXKS
         84nN0msVp/3Dt+ShWBdtAjgd35AgPp4+N2lXVpJpSQCZ+G/Fv91D4bvXmY/1278YovIV
         TmwY2WZmCMWg12CdS8wrq1eLWyEkbKWgu30llnV9ZvM6KfNedM2EMVTTDIf4dX1gDvpt
         1neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137699; x=1698742499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1736lalVb+Wj8lvqQcjrdbk9CZDipYLCDP3xDqokVo=;
        b=JpsqvY4n6kbzVkVQITvQp7A/eTfmB3cHkVFNuGJxShxP1BpjsmOW/0OX3vQL3mCIan
         ITHa/Xo+4rmoA3Lcv+vXITQwWTNkIIh98kOBWGa+ZfsD/PvUZACjZM3toI9HAGX8qYyJ
         9GhtyhWxQaegPlWnv9EjdtrTWfrImub85XO4C7fRadqJ/YQEG6oGQTydZThoek9ncC+F
         Rtoj5lUfZJTvR8KFrUgDZbkp8N/LDARX9BjvjKyI3ZoskG26f0KiCGq0dUIaKx4ubXBR
         VY93oV5Ei8lVbtNNB5PQhDaa9US5xwYruF/nlHUWN0Ip5o/ROOz035WgJd+jRiDyT8aE
         4kdw==
X-Gm-Message-State: AOJu0YwT+Q0mYbqUYaLBXjYb5I83tKlcnPi+pvKjYnzsJE9AxfRL9U3e
        Lrvi4MacOzHMNutIAs/814o=
X-Google-Smtp-Source: AGHT+IF1ZEUhjIgBV17M+3sRkKelTrhlCGO1k5suPfx36p65ojRME0h8aK2m+4F5BWyzTgyj0urmIg==
X-Received: by 2002:a05:600c:2b10:b0:407:73fc:6818 with SMTP id y16-20020a05600c2b1000b0040773fc6818mr14477492wme.2.1698137698854;
        Tue, 24 Oct 2023 01:54:58 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c00d900b004068495910csm16006675wmm.23.2023.10.24.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:54:58 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:54:56 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
Message-ID: <ZTeGYAH1WezbIKWK@debian>
References: <20231023104820.849461819@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 23, 2023 at 12:55:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.2.1 20230511):
mips: 62 configs -> no failure
arm: 99 configs -> failed
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:
arm builds are failing with the error:
drivers/gpio/gpio-vf610.c:251:9: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
  251 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpio/gpio-vf610.c:251:9: warning: excess elements in struct initializer
drivers/gpio/gpio-vf610.c:251:9: note: (near initialization for 'vf610_irqchip')
drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
drivers/gpio/gpio-vf610.c:340:9: error: implicit declaration of function 'gpio_irq_chip_set_chip' [-Werror=implicit-function-declaration]
  340 |         gpio_irq_chip_set_chip(girq, &vf610_irqchip);


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/5359
[2]. https://openqa.qa.codethink.co.uk/tests/5360
[3]. https://openqa.qa.codethink.co.uk/tests/5373

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
