Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6F7B4CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjJBHnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJBHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:43:07 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AEAB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:43:04 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so6262784241.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696232583; x=1696837383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+VAUc4E+Y21AdLpQo4ZI38h7A9OH7Ux8a8Ek8zfCE8=;
        b=qplXjsWHxVZXvDUoPJc+ruqcd/LRX1kKkgII1SKDn4FvThkhEGf2Lf+QfX+2O8ktTz
         1MCoMyNWO3JAqO5k8gXrR2Z8fxyNdIypQmpF8NIAq77zRyi9mCnp2XJlzQbXXfKbYdyK
         fmNqkOT630jLVqHNOphKHctCSwPvlSMuaqV4ygHW7tGsLgYJZF+Johncih+QN79x0Dcz
         ztW90zVVfTG3md3HZ7jCWnhjwpjs/3lCqEV2PG+hwIm6IA6xnINdPFMssFMLDQH/lJzr
         /gdfzQrV57+EgAP0Tl/KlCUWQ6aXStJsA4IdA4bYCPbj9hrMkniMByf4dGRQaC/JQkVN
         oPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232583; x=1696837383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+VAUc4E+Y21AdLpQo4ZI38h7A9OH7Ux8a8Ek8zfCE8=;
        b=tLuDaBvazDMV76Mwe1vZeMMWT9IWUA8DUMiWNXPSAH5V0dMYruQenlsMDyiV4wcCeC
         qjoibobfwnxPOns0pNqUsdL3vzxqKOECTNkp95Z0yhBe3BAtAAwI+kR0kgf8X5SSdm1y
         MP/UYLWkSqdZqAQiXgz05HAQCagiHMruNsGmgqC/jwjUdUe5AlghpAL/rKdhlOZ0hbb2
         3rB02tgS2aoHEYRlsMIjjh4vLKKOk37LPDqtsLTye4YEi8nxTV2Ixy1dMFBIlqZ3ZgAS
         taPtvpH3EkdUu3pDEjQaw7a3PaFKQYAsSTj+VBLKdRlEUImwBvStoOF5/TBMDzAXsDOb
         zHug==
X-Gm-Message-State: AOJu0YzCuYmSWNmEKLwf2rBaoLKadG+9u5EaO3h6++qdK+DUDZEF9HcY
        pTbnau82wE8edHltKClDJmx0O8otU76Vp+jf1JVjTw==
X-Google-Smtp-Source: AGHT+IFmS8Y8o10/iX1hxTsbAjkfklmWIjUvA2ZCS4Kabcn+Zm8qj4rKrioQbkwgn36XGL+DicPyDjqH3RTB3brkDMI=
X-Received: by 2002:a67:cfc6:0:b0:452:7795:7c93 with SMTP id
 h6-20020a67cfc6000000b0045277957c93mr9731589vsm.29.1696232583363; Mon, 02 Oct
 2023 00:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-5-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-5-0f3b975e6ed5@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Oct 2023 09:42:52 +0200
Message-ID: <CAMRc=MdHv0YxSowMnqJ8xG1_w8dwTWVJV1K0b1jgectPTbOheQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 5/6] ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 4:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Gumstix still uses the legacy GPIO interface for resetting the Bluetooth
> device.
>
> Convert it to use the GPIO descriptor interface.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm/mach-pxa/gumstix.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
> index c9f0f62187bd..14e1b9274d7a 100644
> --- a/arch/arm/mach-pxa/gumstix.c
> +++ b/arch/arm/mach-pxa/gumstix.c
> @@ -20,8 +20,8 @@
>  #include <linux/delay.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/machine.h>
> -#include <linux/gpio.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
>
> @@ -129,6 +129,9 @@ static void gumstix_udc_init(void)
>  #endif
>
>  #ifdef CONFIG_BT
> +GPIO_LOOKUP_SINGLE(gumstix_bt_gpio_table, "pxa2xx-uart.1", "pxa-gpio",
> +               GPIO_GUMSTIX_BTRESET, "BTRST", GPIO_ACTIVE_LOW);
> +
>  /* Normally, the bootloader would have enabled this 32kHz clock but many
>  ** boards still have u-boot 1.1.4 so we check if it has been turned on a=
nd
>  ** if not, we turn it on with a warning message. */
> @@ -153,24 +156,23 @@ static void gumstix_setup_bt_clock(void)
>
>  static void __init gumstix_bluetooth_init(void)
>  {
> -       int err;
> +       struct gpio_desc *desc;
> +
> +       gpiod_add_lookup_table(&gumstix_bt_gpio_table);
>
>         gumstix_setup_bt_clock();
>
> -       err =3D gpio_request(GPIO_GUMSTIX_BTRESET, "BTRST");
> -       if (err) {
> +       desc =3D gpiod_get(&pxa_device_btuart.dev, "BTRST", GPIOD_OUT_HIG=
H);
> +       if (IS_ERR(desc)) {
>                 pr_err("gumstix: failed request gpio for bluetooth reset\=
n");
>                 return;
>         }
>
> -       err =3D gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
> -       if (err) {
> -               pr_err("gumstix: can't reset bluetooth\n");
> -               return;
> -       }
> -       gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
> +       gpiod_set_value(desc, 0);
>         udelay(100);
> -       gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
> +       gpiod_set_value(desc, 1);
> +
> +       gpiod_put(desc);

This changes the way this code works. You release the descriptor here,
it returns to the driver and can be re-requested by someone else. Its
value is also not guaranteed to remain as "active". Is this what you
want?

Bart

>  }
>  #else
>  static void gumstix_bluetooth_init(void)
>
> --
> 2.42.0
>
>
