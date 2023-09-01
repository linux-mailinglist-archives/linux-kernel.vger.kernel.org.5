Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1878FA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348167AbjIAJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjIAJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:11:14 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A010D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:11:10 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44d4d997dcfso784345137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693559470; x=1694164270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9rKBMswQzz0G5a9PjRthbbnFOV1fulh2gaLeF06Hns=;
        b=DuZzgk3byLcJ8s6cdxiJUHfKObGlFQV3dxfb3xTrBa1qGbBJ3PLzN9TmuZj3ItVbj5
         o/ZZYzVHv4TcRIU1fTPGCgq4xqA4gGMpXH4ptlSnhTb3tLizLwJ0r16HBAezDJMrZ4xU
         6VBChQqDn3VUA1gRKTBZTJL1zmU6jwYalvsBr7BzeS5G0aP7+kVA7ApLOuGIUZ4Je2h8
         2m2jYIvB0JcKGG5CV4ZjEBj4na6G3FFXgXJRUAHhreLRGBeW4jwZiKWqSxpE54qECPZv
         IAVvpokZF8qYk5ZnCWk4FmOArz47jqC0hIhvj78lnTnP1Bs1WgrCmgH1SWE3wmsxWdft
         KPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693559470; x=1694164270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9rKBMswQzz0G5a9PjRthbbnFOV1fulh2gaLeF06Hns=;
        b=TraVhAB2CdslaP0/kcdh4vTYCIjuZ/v6lDgS5CPzLJY8Oqx/Of0bR2JW3n9sI9ovRp
         QtDEXvPa4HYmc3Q7frFkVXJUZU6TuOwS+w/nGh5LcyVOwxGX+XiGST0Tfjub9nHk9vxc
         gC7SbGBrILgaERROHLsjArF5b6qsiL1uPzrs8+8ByCEzOA535gXt9LRCBH7xSCmopjoI
         NHxjKrPAe+9uKw2CNhSBq2gl/2OOfg/DhYo6sIzKj80vyRF3J81Tb6X/aEUXSMnhHfhd
         hg5oe7g+xel7rEa6RWABvkLTLe6hvX+btjR2MPi8Ij+uxOBriqngyf9Qku6u7NqM5yK1
         KZ8A==
X-Gm-Message-State: AOJu0YyxwApc3P9PSmkuf2Xw+EToKXzSek7gOAfSZni0CVqyOfOanyrV
        1vOOFZ6SUKLDNqLDZ9s6PfpqbWhg+kvw1BOeTyPRgA==
X-Google-Smtp-Source: AGHT+IEKr5RdYRfaffLSGE3W9HNWoR6YhpztFAQFhe2/IObk5hfyiGPyxEFZvYD4yyF+fPlxtNBJ+LokjcVhTLp0190=
X-Received: by 2002:a67:be1a:0:b0:44d:4b8d:31e5 with SMTP id
 x26-20020a67be1a000000b0044d4b8d31e5mr1728632vsq.35.1693559470027; Fri, 01
 Sep 2023 02:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230529025011.2806-1-xingtong_wu@163.com> <20230529025011.2806-2-xingtong_wu@163.com>
 <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com> <d3780074-a5af-92ef-9aa3-1b321a14233c@163.com>
In-Reply-To: <d3780074-a5af-92ef-9aa3-1b321a14233c@163.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Sep 2023 11:10:59 +0200
Message-ID: <CAMRc=MdsFpOC0mDRvFjeDa_FuhV=7Z-7Y5rHaERgqu305_u6VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
To:     "xingtong.wu" <xingtong_wu@163.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        xingtong.wu@siemens.com, andy.shevchenko@gmail.com,
        simon.guinot@sequanux.org,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 9:28=E2=80=AFAM xingtong.wu <xingtong_wu@163.com> w=
rote:
>
> On 2023/5/29 21:02, Linus Walleij wrote:
> > On Mon, May 29, 2023 at 4:55=E2=80=AFAM <xingtong_wu@163.com> wrote:
> >
> >> From: "xingtong.wu" <xingtong.wu@siemens.com>
> >>
> >> switch pin base from static to automatic allocation to
> >> avoid conflicts and align with other gpio chip drivers
> >>
> >> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > If this platform does not have a ton of userspace using the obsolete
> > sysfs this should be fine to apply. I say let's apply and see what happ=
ens.
> >
> > Yours,
> > Linus Walleij
>
> Hi
>
> Seems the issue happened again, the module "gpio-f7188x" register
> gpio_chip failed because of the base value conflict. I hope the patch
> can be merged soon, I'm afraid that you forgot it...
>
> The log is below:
> [    6.872049] gpio-f7188x: Unsupported Fintek device 0x0303
> [    6.872137] gpio-f7188x: Found nct6126d at 0x4e
> [    6.899965] gpiochip_find_base: cannot find free range
> [    6.899967] gpiochip_add_data_with_key: GPIOs 0..7 (gpio-f7188x-6) fai=
led to register, -28
> [    6.899970] gpio-f7188x gpio-f7188x: Failed to register gpiochip 6: -2=
8
> [    6.903329] simatic_ipc_batt simatic_ipc_batt: cannot find GPIO chip g=
pio-f7188x-6, deferring
>
> There is a gpio_chip created by "pinctrl-tigerlake":
> /sys/class/gpio/gpiochip49# ls -l
> total 0
> -r--r--r--. 1 root root 4096 Aug 31 06:40 base
> lrwxrwxrwx. 1 root root    0 Aug 31 06:40 device -> ../../../INT34C6:00
> -r--r--r--. 1 root root 4096 Aug 31 06:40 label
> -r--r--r--. 1 root root 4096 Aug 31 06:40 ngpio
> drwxr-xr-x. 2 root root    0 Aug 31 06:40 power
> lrwxrwxrwx. 1 root root    0 Aug 31 06:38 subsystem -> ../../../../../cla=
ss/gpio
> -rw-r--r--. 1 root root 4096 Aug 31 06:38 uevent
>
> The base value is 49, label =3D INT34C6:00, ngpio =3D 463
>
> The issue arose by chance, because the driver "pinctrl-tigerlake" apply g=
pio_chip->base
> randomly, this time it apply the base value 49, so it have conflict to he=
re:
> https://github.com/torvalds/linux/blob/master/drivers/gpio/gpio-f7188x.c#=
L283
>
> But sometime it apply other base values, so the issue do not happen.
>
> BRs,
> Xing Tong Wu
>

Ah, it fell through the cracks. I will queue it right after the merge windo=
w.

Bart
