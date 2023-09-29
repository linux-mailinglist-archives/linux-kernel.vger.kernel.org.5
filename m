Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68017B3B95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjI2UsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjI2UsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:48:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0C1AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:48:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a1d0fee86aso107385647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696020495; x=1696625295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PB3in7uQxQJMooXEXWpiBaHwk+ekocGtELm1zz7ac4=;
        b=U+3jJ0gKkYUho3gGmo88xldu9TJkA1CeWbLN6HTCIqW5mV1hQqFWK0XqN3lvN+ZMed
         /03R+MVkn/T25onIUeUtupXjNBoRNrZad4lqXb8xl5FdLo6ryTLVF9sCvD2SVPqZO5MN
         DvtFj4+5tFKF6OXQp6jzMKSOEV47nVCVnGqyFVjbOIbFksJQeyciKt+uKG53N6FZ0/iM
         GDGifjx7/jNpVpPguiJqoN7a+dkqrlYPuf7EQIYEfi0TgRtbg2QkFTOyMOb2/OsTw5+M
         DUhtfzEqqOyDKFmrVCw9W9Cjzea+6qYXomi4zNsvmCUXpnUAhozJ7r3qkw5bRhz06pty
         l21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696020495; x=1696625295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PB3in7uQxQJMooXEXWpiBaHwk+ekocGtELm1zz7ac4=;
        b=N9dBcca+xvLq4S4yhNwxUAoTbWY6RaYgyT87GTQa7wx3YYbF7+tGdRI1Lyka5gKrgt
         7EFF1BzQFpqK6mu5TxzVBS+zrph57tpU1Yb9CtVpI3ch5+l1c2TJMmpkmUS1cs7g32au
         wwnATsOqvfM/e9qmZLHm3EtLd4dJeWeOfShVTPzS7/Ejq2SdN9FaEnOwisBcSxEBLl9b
         uLxdnOClbHzU5Qssb2Efvs9nWyFaM5f41H6L9f1H1hdg4+Izaanhg3sLJre9eXai9uis
         Zdecyx7heUC0IqSOUDlIpGhHVoMdr5kmksZrKJuVPA9F4ei3F1U0GeuAWvhOa8aO7yhu
         QAhw==
X-Gm-Message-State: AOJu0Yz/czTpzpIcIcELU8miO9hA8FvuDn01pPZz4sXyHhfIBp4ZBWH6
        96SY+yxn+7lBdKBSbYNXbEnPfQGLRvsBO8JY0E3ylQ==
X-Google-Smtp-Source: AGHT+IGhNuagYdzoQaqD/8H7vq+7TA/IEUrISt5AV9Vh1CFU389coOm1p2xo8o1X5Amvawa/yVVBQqfrtYEIKvx1fl4=
X-Received: by 2002:a05:690c:f8e:b0:5a2:4fd3:d05 with SMTP id
 df14-20020a05690c0f8e00b005a24fd30d05mr2158753ywb.31.1696020495343; Fri, 29
 Sep 2023 13:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr> <20230929-pxa-gpio-v3-2-af8d5e5d1f34@skole.hr>
In-Reply-To: <20230929-pxa-gpio-v3-2-af8d5e5d1f34@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Sep 2023 22:48:04 +0200
Message-ID: <CACRpkdbDVLZBku4VYK98VNDB5qdd-O5XtZsynT+d4MRf96ExXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duje,

thanks for your patch!

On Fri, Sep 29, 2023 at 3:15=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
(...)
> +       .table =3D {
> +               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, =
0,
> +                               GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, 1=
,
> +                               GPIO_ACTIVE_HIGH),

This looks right!

> +       gpiod_add_lookup_table(&spitz_led_gpio_table);
> +       spitz_gpio_leds[0].gpiod =3D gpiod_get_index(&spitz_led_device.de=
v,
> +                       NULL, 0, GPIOD_ASIS);
> +       spitz_gpio_leds[1].gpiod =3D gpiod_get_index(&spitz_led_device.de=
v,
> +                       NULL, 1, GPIOD_ASIS);
>         platform_device_register(&spitz_led_device);

I missed this before, sorry.

This will probably not work. You need to register the spitz_led_device
first, then
you can get the gpiod:s.

The lookup will use the device name to locate the device, and if the device
isn't there it can't be found.

Yours,
Linus Walleij
