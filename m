Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7385F7B4C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjJBHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjJBHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:36:31 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BDA7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:36:28 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so6259897241.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696232187; x=1696836987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kzGcKH51BMhzvkfijbkvJZcq6BeliJjCgiKuHtTrZI=;
        b=XUBlhCQCluEKPTIeKdQAyXsvycYs0HPKyzJwsKaAlprAGDhvJkWBqmXREA4B4AeVgt
         g/1+uIOwYGamevIHZEQVWRY6ClzqwSx53B93NdDsKCefWtfGJ37005JkrvVSeshgefaq
         fhaBnJXTQgMS4XXJVVP1Pa7G5wrj59r3EopY+dGf1+r9epR7KQII32teS/JiSG8QqSlx
         2bk6UUpeuuBpLLRETmvP2lkfyAOt/zrmPsWgghVeTyTuSwJ2842z70SefXGyG6fpVQ+h
         dgoEbiySSPXuhZCQgIcYSQzI+AoNtkj0QsfB8x4ZFMfgmzPtsELWzDFWiC+e2PpX8KLo
         GS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232187; x=1696836987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kzGcKH51BMhzvkfijbkvJZcq6BeliJjCgiKuHtTrZI=;
        b=tn1inf7OXWUv/VXKd+gMyTIU7yxyvwLLqnLqY6mmi7pHUWEMHoyFtBURrBUDOR+g47
         lg/tPGmb71E+7SNGAwoW+/k5DIRgUJ7JA+p8tJgT3ugPrU0fl91mG2IvSQocr5GVRgcu
         muYMYHY21W5RRNc8rWVLZEvXEkAAs6LXSfAdt7W4+xr5phGc4QJ4kD0DUeQHbZwClxfa
         Zp6aux6MXQwdaDBcLDWL5RSGRa3oQyAsevafxLsKebQKhwrTR2gs3EqRfxcIZDXbayiy
         8pie5+QPgFEt0JqdNBJY88gSTkA904eSWGgs9BKBnGci/AkgkdsFlhSWFXkhbgmMLE/o
         ug2Q==
X-Gm-Message-State: AOJu0Yy9/Ip8hPS7WSSiiWcK9/sqfRVheM7hia7F0+af+x4Y/qxk4AVP
        OP94MBLf4thyr36Lbey5vtHEvfRxVb+yKAp3UmMuKA==
X-Google-Smtp-Source: AGHT+IHIgV9UAM4yA8MoechR8q4GLUBkoPowZHLEFw1ZULiGDp+VXiAj3o0rKyl0yWYlk/4LeZK5AfIRMZZY2/x23tg=
X-Received: by 2002:a67:fe0b:0:b0:452:560e:31a9 with SMTP id
 l11-20020a67fe0b000000b00452560e31a9mr8909087vsr.1.1696232186976; Mon, 02 Oct
 2023 00:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-2-0f3b975e6ed5@skole.hr>
 <CAHp75VeYduD=uXpNKcxhwqFTkahUbz_Ockqi7KVO88cpeVHbQQ@mail.gmail.com>
In-Reply-To: <CAHp75VeYduD=uXpNKcxhwqFTkahUbz_Ockqi7KVO88cpeVHbQQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Oct 2023 09:36:16 +0200
Message-ID: <CAMRc=McgNoz-umhkJKZ-juWukgToEhPh3iex7G-QikmSTgDdnw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Daniel Mack <daniel@zonque.org>,
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

On Sun, Oct 1, 2023 at 4:35=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 1, 2023 at 5:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovi=
c@skole.hr> wrote:
> >
> > Sharp's Spitz board still uses the legacy GPIO interface for configurin=
g
> > its two onboard LEDs.
> >
> > Convert them to use the GPIO descriptor interface.
>
> ...
>
> >  static void __init spitz_leds_init(void)
> >  {
> > +       gpiod_add_lookup_table(&spitz_led_gpio_table);
> >         platform_device_register(&spitz_led_device);
> > +       spitz_gpio_leds[0].gpiod =3D gpiod_get_index(&spitz_led_device.=
dev,
> > +                       NULL, 0, GPIOD_ASIS);
> > +       spitz_gpio_leds[1].gpiod =3D gpiod_get_index(&spitz_led_device.=
dev,
> > +                       NULL, 1, GPIOD_ASIS);
> >  }
>
> What's the point of keeping a lookup table after we got descriptors out o=
f it?
>

Normally the descriptors would be retrieved in drivers and so lookup
tables should stay in memory forever as static resources (just like
device-tree). We have recently added some "temporary" lookup tables to
address even worse hacks. The tables would be removed immediately
after the descriptor is retrieved simply because we used that hack in
drivers which may be unbound and re-bound resulting in adding
repeating lookup entries.

Here we're dealing with a board-file so a more classic approach of
having static lookup tables added once and never removed is in order.
So I'd leave it like this.

Bart
