Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091477B787A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjJDHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbjJDHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:14:04 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD4FBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:14:01 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so758485e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696403640; x=1697008440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QVaru3aSoKJ46q6kHIF95rs3QTWK4J1La37jYhgEOI=;
        b=21Tb+hhMS3iE+lpSaXLkVoKG3LE3S0pkW8aZhjvrGum2VNZEfUwzA1uvnLo1zz2OjY
         BlyopNkfUdWmUqYQxm+i50Ic6XFPJ9Ia3tr2gaT5s0pH+7i4XI3CYTzgOuOMNscEZPMA
         Kk8FJ9Zwklubw4Yicr3cVv/05MVbVfOO7VYhszE75Qp0JrYEP7d9FiT6uSLUm0fr/U+q
         AYq1GaWXu2sbVf34y2rVUanww9k28fZjVM6+M4drCuoAwBfKckyv5jAEIX6K3W3hJ3v5
         cjQ3oiU6KfE12W07Ea+ZhZEPLT2V9iwYZQVjiU0jdrlnZJTz33vHKqkOyKV/TNbQRasQ
         v29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696403640; x=1697008440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QVaru3aSoKJ46q6kHIF95rs3QTWK4J1La37jYhgEOI=;
        b=hKppqQRFEhk+ucPAqOLTcN/Aag0zLRafJ0Ip7ouFK8jLWHZv3Qv5mS06CQ3r7xNku2
         WdHCPT+TmaRCGH9n4nQQ+uUP3Mj0AI622V4W3ZzDH3RbCs1LklHw+v2TRvcRua7ibe1K
         FeNmIAUStjK01CpAdF2xmyXASyS+4AToXhtB8+ZoIcGK9KC6/7/bO6zOwfMmRT4jcr4t
         UX+kyS5+gaQplDYbcBxsuXn4mVK5NbUxrrnz0Dkxo75ggiLZTusUikRSFdCRpq+gFm3F
         yd7Qye1H1SqithF/v4kkgxe5M/FB2FWArgwqVY2z+5ka84Bo6s1r4xhlg+Sn9hwq79/u
         3iew==
X-Gm-Message-State: AOJu0YyiECOUCmI5dz95l9GDs1v/Ui+Yw4U+cJjaNrD6rlTYe5iewI9X
        RL/ibUXYE5boatodSTqylkiakXwZU46ODGlnIsVd1w==
X-Google-Smtp-Source: AGHT+IEAheGN4u/b6R2oY17tnd628GPgVY2HjXw6hyOOK1exO4/ZvyYR21mjv4Q+Rpof2QDHqpNJOZVIfu16JQ9fiNA=
X-Received: by 2002:a1f:4905:0:b0:49d:d91:8b13 with SMTP id
 w5-20020a1f4905000000b0049d0d918b13mr1055911vka.8.1696403640393; Wed, 04 Oct
 2023 00:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-9-brgl@bgdev.pl>
 <6608b6ea673454672fb5930b57e9e7a5570d96d5.camel@codeconstruct.com.au>
In-Reply-To: <6608b6ea673454672fb5930b57e9e7a5570d96d5.camel@codeconstruct.com.au>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 4 Oct 2023 09:13:49 +0200
Message-ID: <CAMRc=MfrJHWppvWv=Gh0cQRjFG69UoqLyguu-zE2NB6Yga-3xA@mail.gmail.com>
Subject: Re: [PATCH 08/36] gpio: aspeed: use new pinctrl GPIO helpers
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
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

On Wed, Oct 4, 2023 at 1:30=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Tue, 2023-10-03 at 16:50 +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Replace the pinctrl helpers taking the global GPIO number as argument
> > with the improved variants that instead take a pointer to the GPIO chip
> > and the controller-relative offset.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index da33bbbdacb9..d3aa1cfd4ace 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -750,12 +750,12 @@ static int aspeed_gpio_request(struct gpio_chip *=
chip, unsigned int offset)
> >       if (!have_gpio(gpiochip_get_data(chip), offset))
> >               return -ENODEV;
> >
> > -     return pinctrl_gpio_request(chip->base + offset);
> > +     return pinctrl_gpio_request_new(chip, offset);
> >  }
> >
> >  static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offs=
et)
> >  {
> > -     pinctrl_gpio_free(chip->base + offset);
> > +     pinctrl_gpio_free_new(chip, offset);
> >  }
> >
> >  static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long use=
cs,
> > @@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip =
*chip, unsigned int offset,
> >       else if (param =3D=3D PIN_CONFIG_BIAS_DISABLE ||
> >                       param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN ||
> >                       param =3D=3D PIN_CONFIG_DRIVE_STRENGTH)
> > -             return pinctrl_gpio_set_config(offset, config);
> > +             return pinctrl_gpio_set_config_new(chip, offset, config);
>
> Ah, this looks like it removes a bug too. Nice.
>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>
> >       else if (param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ||
> >                       param =3D=3D PIN_CONFIG_DRIVE_OPEN_SOURCE)
> >               /* Return -ENOTSUPP to trigger emulation, as per datashee=
t */
>

I sent a separate patch that fixes this issue for backporting, once
the other one is in next, we can update this series.

Bart
