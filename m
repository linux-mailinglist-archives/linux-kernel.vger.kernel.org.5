Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB35C7B481D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjJAOlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:41:13 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074CED8;
        Sun,  1 Oct 2023 07:41:11 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b9cb05fa3so1228489eaf.1;
        Sun, 01 Oct 2023 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696171270; x=1696776070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7NM/u8C5++r3Xu6S7NuTAOJjvs6pM7LKKNv5w0BhLA=;
        b=Y/yo2sR2TTsiH8vXxFqL17sXQup7mYjUjNxCQ9zxi+e0tKj9VHfs1GPIFG9cXZToxW
         NAnQJN4K9CXRET1g7z7ji9QhacETcf2tLwWWxvXAkKOCn/xzwy3PeaUbC4rhS/KD5jOA
         XzsiMsIoNSYQI72peAwX09iLoVzn8MOVds8/dicTduUV/02UD2bpVWPU0TAlEI1tgkrw
         cyokCekMP296cd5yXAAGKO2895d34yfrB4SbPtLQ4/KaENQyvo7A7dBS3+7KW+qHqkTG
         UU6KKsbjd/bIquiCRrGJZaEsLz2GtDtXGPLWvoB4YKlLNlI4Py59KWNWlpVmnARVFdl5
         EZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171270; x=1696776070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7NM/u8C5++r3Xu6S7NuTAOJjvs6pM7LKKNv5w0BhLA=;
        b=mvjEeNJ0tU7e+HezWyECfHj6/0IiIq5pwUS3yZeJrn9ljNZcpPOJzJlzXQ0gxudwBI
         90UgzxN23gE0M7tVANaAH3gPpNEJ6XbgNNzs+x3ZMb+Fm3fh/jniwE/cx/rplusXWRW8
         1jpPXJg9CEB+0K/MZk3ciWMDIAbbUuml+ErPtCJNaxhux2ziGu+gLtfeyg4d83O4MDhl
         74PhAgeQlzJvadu4d4P3nLzu4f6wxL+/Kke3KBZp5vss2VQqfVLk5bdB6UbLUPEg38RE
         h0HpVz7yv+u9Ur7ieEu+X1fmCjoEQyj37c/aacEf1k6h3VBX06T+W5kRlEOFWdquvyql
         HQPg==
X-Gm-Message-State: AOJu0YzbSuzNya5TITePg0IAkMy9/khhy12D/TaptlwJQr6diYP4DXX0
        hwdFmFsgcZLX7H3/M9T9UnqofCSMNZxdhPdvteFRr1DaM+o3Bg==
X-Google-Smtp-Source: AGHT+IEedQ7ArMjxTl0Iu9IA1xF0adbmoyGALbJAbsgy+A565Hvf5GKHZtriwF2UQ+mKr7piHvi435JHAYmMEzqMJ+A=
X-Received: by 2002:a05:6820:127:b0:57e:ac1:6442 with SMTP id
 i7-20020a056820012700b0057e0ac16442mr5462481ood.4.1696171270179; Sun, 01 Oct
 2023 07:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-4-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-4-0f3b975e6ed5@skole.hr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Oct 2023 17:40:34 +0300
Message-ID: <CAHp75VcgajYz4XScSLTxYSKy6mbTjJ9mD7zF3j90d5+6V8NyZg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 4/6] ARM: pxa: Convert reset driver to GPIO descriptors
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
> The PXA reset driver still uses the legacy GPIO interface for
> configuring and asserting the reset pin.
>
> Convert it to use the GPIO descriptor interface.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I dunno how.

...

> +       reset_gpio =3D gpiod_get(NULL, "reset generator", GPIOD_ASIS);
> +       if (IS_ERR(reset_gpio)) {
> +               pr_err("Can't request reset_gpio: %pe\n", reset_gpio);
> +               return PTR_ERR(reset_gpio);
>         }

Here you asked for the GPIO named as "reset generator-gpio(s)" (The
"(s)" part is for new bindings), but you must not use spaces in the
GPIO names. Moreover the string literal there is for labeling, and not
for matching.

...

> +GPIO_LOOKUP_SINGLE(spitz_reset_gpio_table, NULL, "pxa-gpio",

And here should be gpios. That's what you have to request, but because
of the global (device-less) nature of this, you have to be very
careful to avoid any clashes.

> +               SPITZ_GPIO_ON_RESET, "reset generator", GPIO_ACTIVE_HIGH)=
;

...

TBH, I don't know how it is supposed to work with your current code
and if Linus really was okay with this.

--=20
With Best Regards,
Andy Shevchenko
