Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD627BB1C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjJFGvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjJFGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:51:02 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D5E9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:51:00 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49ab6c1869dso1945946e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696575059; x=1697179859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ4Goyu7ScewZS3ePtJeqq+qlPtIo29EJK50i7ykfyg=;
        b=NugpWs80YfpQm0gX9QQSl/jTzjsEeeDoDC7atBGiyaRRlaq7KMT+M1NJd8MR4LnIsb
         7USq7TovPY32db0GqP1dqHXoKLi/oD/WOGdh/ZS6fhAjmUu/HRpbntwYtDCgLO3fWw9H
         m7bqHkjHHb2puvhbsmywd8wlIWktX3+VizwgF6KZ9olTcOl+mn7HRlk7TOvkBXXfr0lR
         /S1qRNG7YdAERyKzp+3IJOEjPdRVN3kX/glSTifaw1Ql/TUOH/EEMhlQ6+dVo/63mhRw
         I6I26yr28j+Q5yA9LyIsCrx2sT7M0xzHX0d+H6G85SDv474xBMz5CoTgLapu+/Or2EGu
         ftHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696575059; x=1697179859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ4Goyu7ScewZS3ePtJeqq+qlPtIo29EJK50i7ykfyg=;
        b=oUPhDZIqRvH56I/UL5RhIVIHw/fszVybyoVuiuYdMQJ2qfA/KyCPsqwNtSvGOoUA2K
         040ZOUv6CPxGUgV2p93quRY8ibVRdj0gAqfqLQhXxP+iQojCSvyIjRjy9aHsVdwwCOd8
         vVNyP1as/NgtKiBWmpFXBY3UYVnU7KxRQO/IsSUJda4M0M9CiaKEM+WZSMX9DtmaGdgK
         uhoXSFAED1S2/Q938A6sUm/xvbHG7AMx77MeFsYSrU6MBWTdlElsqSlq4wf7cnTiWUW0
         Wcmt8/x/22ZJnB3rBqpPsUd4QQMd/XTv2ck3Et3oyL6GnwTmhdRFRsKUZmd1JkfrUKE9
         lf+A==
X-Gm-Message-State: AOJu0YzirWlwsSti4jdvPXLbg+G20IeYvDmZA1H3YVVMEq5DKLtUX7g3
        4gcXw8+VzxROUZ6YEqWuAIXQX0oBZPXtvkK17yzpAw==
X-Google-Smtp-Source: AGHT+IHpGkFbSMZRIWCm82duszP87XhU90G/l918j+LqyVxw/UR9sNKWyys180NpHwrfHj6hXa1rjT5Gk+Z9W159ixU=
X-Received: by 2002:a1f:9889:0:b0:49d:2a13:58fc with SMTP id
 a131-20020a1f9889000000b0049d2a1358fcmr1796623vke.2.1696575059288; Thu, 05
 Oct 2023 23:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr> <20231004-pxa-gpio-v5-2-d99ae6fceea8@skole.hr>
In-Reply-To: <20231004-pxa-gpio-v5-2-d99ae6fceea8@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Oct 2023 08:50:47 +0200
Message-ID: <CAMRc=Mf9x-Rui32ZYqcxhV5vA=r3mCLxqySs2pwNC6uaVmL=0w@mail.gmail.com>
Subject: Re: [PATCH RFC v5 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
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

On Wed, Oct 4, 2023 at 4:56=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
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
>  arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 535e2b2e997b..b6a4085e9fb0 100644
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
> @@ -480,7 +489,12 @@ static struct platform_device spitz_led_device =3D {
>
>  static void __init spitz_leds_init(void)
>  {
> +       gpiod_add_lookup_table(&spitz_led_gpio_table);
>         platform_device_register(&spitz_led_device);
> +       spitz_gpio_leds[0].gpiod =3D gpiod_get_index(&spitz_led_device.de=
v,
> +                       NULL, 0, GPIOD_ASIS);
> +       spitz_gpio_leds[1].gpiod =3D gpiod_get_index(&spitz_led_device.de=
v,
> +                       NULL, 1, GPIOD_ASIS);

You're not using the con_id you specified in the lookup table. How
about using gpiod_get_array()?

Bart

>  }
>  #else
>  static inline void spitz_leds_init(void) {}
>
> --
> 2.42.0
>
>
