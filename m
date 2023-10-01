Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8C7B4815
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjJAOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJAOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:35:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C08E;
        Sun,  1 Oct 2023 07:35:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4cbab83aaso8141252a34.1;
        Sun, 01 Oct 2023 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696170908; x=1696775708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rl/LNRNIKB0OOICjXESoCeW2EfNvQVfmDGrdMKDqh8=;
        b=QqhacPemhcVhnVPFg6b+vyAVpptSD/K3oYKhiT/nEtxQe5U708S4FXbN23WgRWNmlx
         uMzpm5U9Ra/qwaZDp2huocZFU1L5jX5tDsSA+fIHLN3n64roE/oQn3zxAJoAZEEjO5lf
         YNUay2Unu0hlArcqXcQamQSO23Cjhvq3vOD0HzUijNO1OFPP6OiVOuai2cSQXHHk5j7D
         HGByDj9WNnzDma0W6gC4eCyi4VG2uLtQl4usDcBkiz0P3ftErBEEsiPlc2hP8hxKuTE3
         GOCi9zGdjvHTlHqs858NBfZHAcckyOAUm9YSShm7GJVqNTPAxf4G12/OhDyIoPwAvmMS
         KUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696170908; x=1696775708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rl/LNRNIKB0OOICjXESoCeW2EfNvQVfmDGrdMKDqh8=;
        b=Ru5eXlRCCusvESWrsBcMBwenZK7ad4Wy3Y7z5rvaKjDwEUxc5qKEfyYpMIUvi33H6k
         0FmIRg9k05w1Ayk9+tr91q7o0QvJHr3KmhcHSgWCoawt8B7RNsOFfSFizhmW79Fb8vf8
         jYnelLps3fVOVWg8QefeHCTKudu8oTYqJRArE4FAgy3cRAMCfIiXr33ergPVyPqhXvDn
         icIoxLYIPwLX4Hdu2Id2A4n2KkFviev+mJNn7pOZluZCXv+7Ne4ZDgwicGKPdwWk0qjW
         ftzP3V02ycbeNmspJwNYxIDfp8t8ZFZRXJ8ErOam3p34K9xR3S/1w1kHbgIoQgv4wA9j
         l4fw==
X-Gm-Message-State: AOJu0YzGj1BY4W+SGNTbiwLZb6xrTCM6y2pekmF6m8AEj093GOFXeJkX
        Mi+rJs8MBxuuJMlhn0UReyTQWozg1UE0Jtri7uw=
X-Google-Smtp-Source: AGHT+IGDhfqCTKLJbATyTBjpw2qqCvb+0+WEpEvdBoj3zdv35M1kM70mwiWUv//opiEWQo3Nei/hNLZVwZMiLNi2ZaI=
X-Received: by 2002:a05:6830:3449:b0:6bd:c74e:f222 with SMTP id
 b9-20020a056830344900b006bdc74ef222mr10249317otu.34.1696170908178; Sun, 01
 Oct 2023 07:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-2-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-2-0f3b975e6ed5@skole.hr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Oct 2023 17:34:32 +0300
Message-ID: <CAHp75VeYduD=uXpNKcxhwqFTkahUbz_Ockqi7KVO88cpeVHbQQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 5:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.

...

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
>  }

What's the point of keeping a lookup table after we got descriptors out of =
it?

--=20
With Best Regards,
Andy Shevchenko
