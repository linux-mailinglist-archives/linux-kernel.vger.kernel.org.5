Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8377D4B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjJXI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJXI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:56:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97D198D;
        Tue, 24 Oct 2023 01:56:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084095722aso34226865e9.1;
        Tue, 24 Oct 2023 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137785; x=1698742585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miTVCU04yyCrzOSAI9EkRMIhzdyP2FapJh++0rrQ6Wg=;
        b=AYgbKKURw+ZKtLiYOW1Qg6LZq8iU/oRvhHnaURUPPk0sZM57TDn1z1fOiebtMgMGRq
         Lp/yZSEecW7T+FViTgoh6RdF/NXowpgzKh6nPwVjylU2qn5KSaOQ7iREQJOrD2cPACA3
         YriXTizbEaZRiapZgM9fJcEW7IGHppR4r3LXfjc/wrKJv5g3MwzJW7R//RKdDIDLUlBm
         LZBfUEF3khtksTBaYe6AClFSpDUzFIEmFskKe92IZO8bGyGfee65Rg9T1jtDwCcQCHGe
         jFf0FftJJaDjhUYQlDyEsiDPz//NSC28rdpTFHv4ZHs1cMz7R+CQFrNq/NOf71ljac+g
         26Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137785; x=1698742585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miTVCU04yyCrzOSAI9EkRMIhzdyP2FapJh++0rrQ6Wg=;
        b=exAUAwK2dFiMXCnCyIAaCsnc5FOXvhG7WNj4ZYw3rU+tLoCEfB6Y49wofnIvoHGjYr
         q/LptBDkY/EhzhLqTj3TBb2khTc4KMbJM2lOVQ9dRXcnBjKjeTzw1N8mJ5WFxYkagAxc
         4PBMntg9uDTDTRfg8t+tDGUbGWob9oxQo1H9+QfvV11IB+QlG0+hflqfxv1yd9taJvyp
         7zF2GzhbXSrbj+6mNdAdit7q/rQzvAIU2t8MThkjHvUiMguBu2fbHK6TSHUBEyyarANS
         JYo9N5fu/pY5EgHak5Yx7RGDFUoUB3nb32gCsrQpFbORnX/2ShBYVsUdWKjVOJP4f77Z
         00Xg==
X-Gm-Message-State: AOJu0YwkUnp0SylvyhSdcEmlr7gWu4ZxFqeT+h243B20M5zC4CbMdhG1
        F220pd9UTqtKXDZ1Y2UP9fw=
X-Google-Smtp-Source: AGHT+IGetQYjoPclj/kmbwPywiuFWtEc2VzhJ8b2Vn9XlycBsIp3g0AHLZEG3uwg270sYu4L4jCDRw==
X-Received: by 2002:a05:600c:1c97:b0:401:d803:6243 with SMTP id k23-20020a05600c1c9700b00401d8036243mr8983012wms.32.1698137785245;
        Tue, 24 Oct 2023 01:56:25 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b004067e905f44sm11655034wms.9.2023.10.24.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:56:25 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:56:23 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
Message-ID: <ZTeGtz7cTimKctug@debian>
References: <20231023104817.691299567@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 23, 2023 at 12:55:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.3.1 20230511):
mips: 65 configs -> no failure
arm: 106 configs -> failed
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
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
      |         ^~~~~~~~~~~~~~~~~~~~~~

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/5353


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

--
Regards
Sudip
