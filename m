Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C67BF960
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjJJLMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJJLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:12:19 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8FAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:12:17 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4526b9078b2so1597090137.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696936336; x=1697541136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba3EK1pllte35KUINcDLT2ZW9CZJNr8KmgudzwFPcZ8=;
        b=MGH8NtQAOZCydsPIZ0R4NPRQw790cSo59zmxDR++Fr2JF5LGH+74XmyEnnk/W0H3WC
         iSNJ+c9BqLwGbwOtGIhmaW0qMx1OkDzR6b3+DBJHvNeS8164YN07nB8XkwQzm422rvny
         BrLQIHzpizHZRHYg44UsQR9YduIl77u/IjcvTGHC4kp+r3pz2bu5hVXvUW8thGM8vlWG
         oRywumtRZklSqi7F/t3mcQoOD/Kn2uQK2cpBHH4WBMVTuls1UyHVP2oxzFpOqmt+q66N
         1gcCG/OzaMjZlrHWjI7uT8XuTryb3w2lp6ajWeHdv1rR4YAH3FaZS8y6mMzhRzjhayv5
         Uzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936336; x=1697541136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba3EK1pllte35KUINcDLT2ZW9CZJNr8KmgudzwFPcZ8=;
        b=bZP02jhTcqggZJGdDC7qjo2Zfhd/jhT8wrVnKF0tIoXwZBMRs4V+w52Fg+kd6Yc7C7
         nDLgm2Yrmij12asVfyuZvAXTGNaVgCF6pvDcO6/lTjrroXYHGXdGyB+IlKYgAP7JrANh
         FLwoDQeIywDOKlb4ykBm0yDtFT/XcGk1p0Uw5lBff5pI+1BTEWKzfOIzPM3y5XbjUnlG
         XB+hMGP9SkYuVfjjxaIGaohV6c7iLIPIBpa8RsIZSm1Eho/PCS4PGeVEfe9KzBai48n8
         nmx3REJOO7WlWQHO2VA203ohd/FU1Wg6xYg3XX3EwuvQ9+62dgk17d0x5jU+nLnW2ill
         TprQ==
X-Gm-Message-State: AOJu0YxVIAnMXSV671ulGsKA5TJw+NcgWihfMgcyC7F1hZyTpR7dzP/5
        r+CxyXK1eArh1mXdy0V+FvghOvqaokcz8z/XYlXtYQ==
X-Google-Smtp-Source: AGHT+IF4kAhVyOug7FYK3pkInw+ECV2FjriFAdEqcve9PYj+5PcUF379eb0ofLqlTLmIl6a+1ZJt5EJtpxzSOcFbrFY=
X-Received: by 2002:a67:e941:0:b0:452:7601:e80b with SMTP id
 p1-20020a67e941000000b004527601e80bmr10391296vso.35.1696936336150; Tue, 10
 Oct 2023 04:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr> <20231009-pxa-gpio-v7-2-c8f5f403e856@skole.hr>
In-Reply-To: <20231009-pxa-gpio-v7-2-c8f5f403e856@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Oct 2023 13:12:05 +0200
Message-ID: <CAMRc=Mc7=E9bMQgiUM8qqk7UD4+exhJZqw2DucTcsnqHcttR3Q@mail.gmail.com>
Subject: Re: [PATCH RFT v7 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
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

On Mon, Oct 9, 2023 at 8:34=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm/mach-pxa/spitz.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 535e2b2e997b..29907abc4513 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -452,16 +452,25 @@ static inline void spitz_keys_init(void) {}
>   * LEDs
>   ***********************************************************************=
*******/
>  #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> +static struct gpiod_lookup_table spitz_led_gpio_table =3D {
> +       .dev_id =3D "leds-gpio",
> +       .table =3D {
> +               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, =
0,
> +                               GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, 1=
,
> +                               GPIO_ACTIVE_HIGH),
> +               { }
> +       }
> +};
> +
>  static struct gpio_led spitz_gpio_leds[] =3D {
>         {
>                 .name                   =3D "spitz:amber:charge",
>                 .default_trigger        =3D "sharpsl-charge",
> -               .gpio                   =3D SPITZ_GPIO_LED_ORANGE,
>         },
>         {
>                 .name                   =3D "spitz:green:hddactivity",
>                 .default_trigger        =3D "disk-activity",
> -               .gpio                   =3D SPITZ_GPIO_LED_GREEN,
>         },
>  };
>
> @@ -478,9 +487,16 @@ static struct platform_device spitz_led_device =3D {
>         },
>  };
>
> +static struct gpio_descs *leds;
> +
>  static void __init spitz_leds_init(void)
>  {
> +       gpiod_add_lookup_table(&spitz_led_gpio_table);
>         platform_device_register(&spitz_led_device);
> +       leds =3D gpiod_get_array_optional(&spitz_led_device.dev,
> +                       NULL, GPIOD_ASIS);
> +       spitz_gpio_leds[0].gpiod =3D leds->desc[0];
> +       spitz_gpio_leds[1].gpiod =3D leds->desc[1];
>  }
>  #else
>  static inline void spitz_leds_init(void) {}
>
> --
> 2.42.0
>
>

Gah! I should have noticed this earlier but this is a perfect
candidate for using hogs. Can you use gpiod_add_hogs() from
linux/gpio/machine.h instead? That would save you having the lookup
and the static leds descriptor array.

Bart
