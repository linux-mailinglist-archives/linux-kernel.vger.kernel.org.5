Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB237D3F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjJWSug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjJWSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:50:32 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23534103;
        Mon, 23 Oct 2023 11:50:30 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7be88e9ccso37743037b3.2;
        Mon, 23 Oct 2023 11:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087029; x=1698691829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYFfnW1lq/N35y1JdU1JiP7JMVnAqfYQ6cbBfI8EdMk=;
        b=iDRyYtJGlgmGuinvgUGhtl4hS3OSx2Dz8e2ZAMvhL/uyt0eFAZ5IJmqulslXlrKGtQ
         pPkvukBLP4QzeLEEWVUW5V1TTtje/oNoqAY/0QGs68+ktCnJdDCj71no860vR0cDFDGM
         /y7puNG+O5V5std27Dttby7q5gqjzgw5TgxWo0hcnuf9993M9K3p5xzLW7Z7dHjnLciQ
         Q9hlCqEQTv62qjQqQNOxo/QabmlcwKfIb+f1jJu4EGXAxztOMaaOemxxw1ZFm/fFMncz
         Dy7cLKSC9HGauiXI07ZCYZDOLuab6FrinVKYknjSEHDyDlbf9UNK6QZ+kzmpirz66qrX
         v5GQ==
X-Gm-Message-State: AOJu0Yx+9LLq9fo7p2fwQ3nljbtryAHt7g1wnpEHd8elvDZ26tfQO9KD
        DEC1hiOFO2DvgNr7UmUrgzgI/n5swz7RpA==
X-Google-Smtp-Source: AGHT+IFg7fNQKrqNUbH44eK2OIc/ZbftU9Izgsx250DkdKUNSpq916ML5svNWe+UtdrTbJN6+CobJQ==
X-Received: by 2002:a05:690c:86:b0:5a7:d9e6:8fc6 with SMTP id be6-20020a05690c008600b005a7d9e68fc6mr11578983ywb.39.1698087029053;
        Mon, 23 Oct 2023 11:50:29 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id s13-20020a81bf4d000000b005a7fbac4ff0sm3349358ywk.110.2023.10.23.11.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:50:28 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7afd45199so38092337b3.0;
        Mon, 23 Oct 2023 11:50:28 -0700 (PDT)
X-Received: by 2002:a81:a090:0:b0:5a7:baac:7b34 with SMTP id
 x138-20020a81a090000000b005a7baac7b34mr10436542ywg.28.1698087027858; Mon, 23
 Oct 2023 11:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104820.849461819@linuxfoundation.org> <724521b8-9c63-4645-b3e0-30d9635573a7@linaro.org>
 <CAEUSe7-zbuRsgsr2EYq+OeW9iEJyZHmo8u9K3pDCAFRKnCEv0A@mail.gmail.com>
In-Reply-To: <CAEUSe7-zbuRsgsr2EYq+OeW9iEJyZHmo8u9K3pDCAFRKnCEv0A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Oct 2023 20:50:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYB6QAE15RYs7eg9sVofesqNN1+vmPHkosqC_8A-JTSg@mail.gmail.com>
Message-ID: <CAMuHMdXYB6QAE15RYs7eg9sVofesqNN1+vmPHkosqC_8A-JTSg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC maz

On Mon, Oct 23, 2023 at 7:17 PM Daniel Díaz <daniel.diaz@linaro.org> wrote:
> On Mon, 23 Oct 2023 at 09:11, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.137 release.
> > > There are 137 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> > > or in the git tree and branch at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > We see lots of errors on Arm 32-bits:
> >
> > -----8<-----
> > /builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
> >    .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
> >             ^~~~~~~~~~~~~~~~~
> >             IS_IMMUTABLE
> > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
> >    GPIOCHIP_IRQ_RESOURCE_HELPERS,
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct initializer
> > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: note: (near initialization for 'vf610_irqchip')
> > /builds/linux/drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
> > /builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of function 'gpio_irq_chip_set_chip'; did you mean 'gpiochip_get_data'? [-Werror=implicit-function-declaration]
> >    gpio_irq_chip_set_chip(girq, &vf610_irqchip);
> >    ^~~~~~~~~~~~~~~~~~~~~~
> >    gpiochip_get_data
> > cc1: some warnings being treated as errors
> > ----->8-----
>
> Bisection points to "gpio: vf610: make irq_chip immutable" (upstream
> commit e6ef4f8ede09f4af7cde000717b349b50bc62576).

IRQCHIP_IMMUTABLE was introduced in commit 6c846d026d490b23 ("gpio:
Don't fiddle with irqchips marked as immutable") in v5.19.
Backporting (part of) that is probably not safe.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
