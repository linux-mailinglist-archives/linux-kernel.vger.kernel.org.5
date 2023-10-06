Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD07BB1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjJFHHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjJFHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:07:35 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC8ED
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:07:34 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4525dd7f9d0so714001137.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696576053; x=1697180853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3mh1m76o0jxvdd1cNjwNEbLhdaRWelrX6qtRv+BOf0=;
        b=QOMknG8lVd6IeEBIrAt2LZIjoR14UIOUieW4OvASl9pYEgbxkGIEmUN96uYSUXMbdc
         MJlBuVxvLVBv48YTqo9WYoOyzV31plxvACvrn8LdNiyZYIs4XG4FfXtCRc8MPd0h396x
         yosdJ2N0ci9qLy8HuFNugZG6yzdUK/mfIbFy8fIGxT3iKlZgdnMxKCDZu/u1HZGpr+zE
         Tjz4aP1ssuM1snD3udVivBgsJ26MaBDFDVHZv3J2syklcayEtdztqGcyo7rturV1CyHb
         XVhWg+kuNOjfi+PJKDikhN9r49xP0P6klODneZb/6NYyB5bm7X1i0NPV9RRqjImEF/Mt
         QPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576053; x=1697180853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3mh1m76o0jxvdd1cNjwNEbLhdaRWelrX6qtRv+BOf0=;
        b=c3MAg3mGpBywBmIy6roWkQQp0oE+90FvJL1BZaZ1Czt5phCwx4iGvRSNrZjurIfcGf
         vj0lihdVb14djkP7YL5JdbKQLxzBMXjV4wWHB8pKUL7qIzj98ag3+92Zj4c+7p4nJC+L
         gtvZx+LMiHlgNt5ngxDZ7GC3UBbAQTHdYskNLtqtOMETFIcX6RP1eLyhRIF2nL6Gnhlo
         +zV0iThhsGmtK8npKOZTfdWF7d1NR5qoiHWynW/sgjXBUVoYhsmU+anMIkYxorxgRvgc
         azQbyAZLIahJ+qFqmXF+vn37AzYmV1DzOOgkJ1IdG29dUPDZY6/u3BPoNhcMarU3b60r
         6Ddg==
X-Gm-Message-State: AOJu0Yy81BdMy38NjaOIS4tYnLSKqW0qaUqcT9GtpYdyYOAsDaV5mqM6
        u4ZQHBrkhOO0AXbg4NCfXXuEVg0JOYXjOoqaLi9B5g==
X-Google-Smtp-Source: AGHT+IFl+c9LzCGElLpLq/HwxVVkvurQIXqs+Ze9puu/rF8cYLylpN/sMv3aI0Wmo9C8w/PQ0ihqIMl5uErVFp+2yFk=
X-Received: by 2002:a67:b606:0:b0:452:58f8:71de with SMTP id
 d6-20020a67b606000000b0045258f871demr6214378vsm.8.1696576053117; Fri, 06 Oct
 2023 00:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr> <20231004-pxa-gpio-v5-4-d99ae6fceea8@skole.hr>
In-Reply-To: <20231004-pxa-gpio-v5-4-d99ae6fceea8@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Oct 2023 09:07:22 +0200
Message-ID: <CAMRc=MewJk3=ms9ggnjMqOdAevW4dOb12savYdJg2tfcuUGEUw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 4/6] ARM: pxa: Convert reset driver to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
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

On Wed, Oct 4, 2023 at 4:56=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> The PXA reset driver still uses the legacy GPIO interface for
> configuring and asserting the reset pin.
>
> Convert it to use the GPIO descriptor interface.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm/mach-pxa/reset.c | 39 +++++++++++++--------------------------
>  arch/arm/mach-pxa/reset.h |  3 +--
>  arch/arm/mach-pxa/spitz.c |  6 +++++-
>  3 files changed, 19 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
> index 27293549f8ad..08bc104b9411 100644
> --- a/arch/arm/mach-pxa/reset.c
> +++ b/arch/arm/mach-pxa/reset.c
> @@ -2,7 +2,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <asm/proc-fns.h>
>  #include <asm/system_misc.h>
> @@ -14,33 +14,20 @@
>
>  static void do_hw_reset(void);
>
> -static int reset_gpio =3D -1;
> +static struct gpio_desc *reset_gpio;
>
> -int init_gpio_reset(int gpio, int output, int level)
> +int init_gpio_reset(int output, int level)
>  {
> -       int rc;
> -
> -       rc =3D gpio_request(gpio, "reset generator");
> -       if (rc) {
> -               printk(KERN_ERR "Can't request reset_gpio\n");
> -               goto out;
> +       reset_gpio =3D gpiod_get(NULL, "reset", GPIOD_ASIS);
> +       if (IS_ERR(reset_gpio)) {
> +               pr_err("Can't request reset_gpio: %pe\n", reset_gpio);
> +               return PTR_ERR(reset_gpio);
>         }
>
>         if (output)
> -               rc =3D gpio_direction_output(gpio, level);
> +               return gpiod_direction_output(reset_gpio, level);
>         else
> -               rc =3D gpio_direction_input(gpio);
> -       if (rc) {
> -               printk(KERN_ERR "Can't configure reset_gpio\n");
> -               gpio_free(gpio);
> -               goto out;
> -       }
> -
> -out:
> -       if (!rc)
> -               reset_gpio =3D gpio;
> -
> -       return rc;
> +               return gpiod_direction_input(reset_gpio);
>  }
>
>  /*
> @@ -50,16 +37,16 @@ int init_gpio_reset(int gpio, int output, int level)
>   */
>  static void do_gpio_reset(void)
>  {
> -       BUG_ON(reset_gpio =3D=3D -1);
> +       BUG_ON(IS_ERR(reset_gpio));

Crashing the kernel on a GPIO error? I guess it just keeps the old
behavior but still...

>
>         /* drive it low */
> -       gpio_direction_output(reset_gpio, 0);
> +       gpiod_direction_output(reset_gpio, 0);
>         mdelay(2);
>         /* rising edge or drive high */
> -       gpio_set_value(reset_gpio, 1);
> +       gpiod_set_value(reset_gpio, 1);
>         mdelay(2);
>         /* falling edge */
> -       gpio_set_value(reset_gpio, 0);
> +       gpiod_set_value(reset_gpio, 0);
>
>         /* give it some time */
>         mdelay(10);
> diff --git a/arch/arm/mach-pxa/reset.h b/arch/arm/mach-pxa/reset.h
> index 963dd190bc13..5864f61a0e94 100644
> --- a/arch/arm/mach-pxa/reset.h
> +++ b/arch/arm/mach-pxa/reset.h
> @@ -13,10 +13,9 @@ extern void pxa_register_wdt(unsigned int reset_status=
);
>
>  /**
>   * init_gpio_reset() - register GPIO as reset generator
> - * @gpio: gpio nr
>   * @output: set gpio as output instead of input during normal work
>   * @level: output level
>   */
> -extern int init_gpio_reset(int gpio, int output, int level);
> +extern int init_gpio_reset(int output, int level);
>
>  #endif /* __ASM_ARCH_RESET_H */
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 965354e64c68..26ec29c9cd1b 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -1024,9 +1024,13 @@ static void spitz_restart(enum reboot_mode mode, c=
onst char *cmd)
>         spitz_poweroff();
>  }
>
> +GPIO_LOOKUP_SINGLE(spitz_reset_gpio_table, NULL, "pxa-gpio",
> +               SPITZ_GPIO_ON_RESET, "reset", GPIO_ACTIVE_HIGH);
> +
>  static void __init spitz_init(void)
>  {
> -       init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
> +       gpiod_add_lookup_table(&spitz_reset_gpio_table);
> +       init_gpio_reset(1, 0);
>         pm_power_off =3D spitz_poweroff;
>
>         PMCR =3D 0x00;
>
> --
> 2.42.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
