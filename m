Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C8782947
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjHUMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHUMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:39:03 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2914CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:39:00 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-447b64b0555so710028137.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692621540; x=1693226340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmV/mQgttZiD5+/KFAqCw9SpurlcxE+hr5x79h/UGWo=;
        b=2d6HlQ8r9gDTXZYNEv6VOKM7VLs9c0n4xcHA6waXKVvYfZgpbiE7FrNN0jSjN1bSQ6
         iX6ga1s0vGN83Jyb5Af5uCaCPjqlI9rqiM/nMZjozsY6AZd1oPL3V6ujltQwtUNdj3DR
         0UhvhOy4i/mXU/cB0Ap3mRuj4Pz0LSk8QWNvBI26RAKEpNK1+BIKUjRkDRtzvOKDhfjz
         MyioRWK3pFtdRT0dvvt83qNu+nUbYPDeSgPJbx8HUR+qqP+1GT+La9E8RmpELO28Hx/m
         4dEJWjCO76G7ynlYo/G332zDwOparZUEKvOf38lZk3oySDO7aLjSjiYiZqHDw9HJMS7/
         M0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621540; x=1693226340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmV/mQgttZiD5+/KFAqCw9SpurlcxE+hr5x79h/UGWo=;
        b=h2j5DLjQdIR7Y/yBpToUkBHHzGtamnKzDx/gom/nm3jaoQocEZJGF6n/ef9bKqQMLS
         9HZ9JVk5qS6Gz4UVa5Ojm7Rf2fFhxiFazAD3ycVrlPk3io7mSUovY32HZ+on1Wo2JN7+
         BaTZK3sUz7W6TWyC6Hoi8COyx2StkrTD1W2HO+YRwRTiWPKxSvT/I+GKgnqgJTIV5Vvb
         d+YsvH73gvlyHaqUghdTpxYdvQSIK6ALdwc0G6LyFtGPgvnxJ4hDQQNtFwDJa646lOdL
         fMZ/nUA9T1uelkREI/3q2Usc4O4hz8h+Ew/geiTgbL25Egx9Ni8rJ92s5v1hthtcbbo4
         dzig==
X-Gm-Message-State: AOJu0YxWtk3bQ1QTyIwte5tkb0lAZju78CDLkRH3ydas61crF9Ca9Dn/
        oJsYHg+3raa8ry31caZi6DqwGl1CaTSTYlG++BJcZw==
X-Google-Smtp-Source: AGHT+IFZU8UDDCuwx63KXvqAvjirNOb8YmlXDwnhi5j+FeTjihTGtpCOuyoxPMcc1i/2joq/uPvC0L1FTPgsgxdFMIM=
X-Received: by 2002:a67:e25a:0:b0:447:ba75:9c81 with SMTP id
 w26-20020a67e25a000000b00447ba759c81mr2582523vse.28.1692621539741; Mon, 21
 Aug 2023 05:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230818164314.8505-1-asmaa@nvidia.com> <20230818164314.8505-3-asmaa@nvidia.com>
In-Reply-To: <20230818164314.8505-3-asmaa@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 14:38:49 +0200
Message-ID: <CAMRc=Mccsc=RY5Evw4-k8LYDrfuxFoWsn6wajybY4SY_89fjNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 6:43=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> Support add_pin_ranges() so that pinctrl_gpio_request() can be called.
> The GPIO value is not modified when the user runs the "gpioset" tool.
> This is because when gpiochip_generic_request is invoked by the gpio-mlxb=
f3
> driver, "pin_ranges" is empty so it skips "pinctrl_gpio_request()".
> pinctrl_gpio_request() is essential in the code flow because it changes t=
he
> mux value so that software has control over modifying the GPIO value.
> Adding add_pin_ranges() creates a dependency on the pinctrl-mlxbf3.c driv=
er.
>
> Fixes: cd33f216d24 ("gpio: mlxbf3: Add gpio driver support")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v4->v5:
> - Add "Reviewed-By" Tag
> v3->v4:
> - Drop the common define for MLXBF3_GPIO_MAX_PINS_BLOCK0
> v2->v3:
> - Replace boolean logic by clear switch statement logic in
>   mlxbf3_gpio_add_pin_ranges()
> v1->v2:
> - Cleanup mlxbf3_gpio_add_pin_ranges()
>
>  drivers/gpio/gpio-mlxbf3.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
> index e30cee108986..0a5f241a8352 100644
> --- a/drivers/gpio/gpio-mlxbf3.c
> +++ b/drivers/gpio/gpio-mlxbf3.c
> @@ -19,6 +19,8 @@
>   * gpio[1]: HOST_GPIO32->HOST_GPIO55
>   */
>  #define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
> +#define MLXBF3_GPIO_MAX_PINS_BLOCK0    32
> +#define MLXBF3_GPIO_MAX_PINS_BLOCK1    24
>
>  /*
>   * fw_gpio[x] block registers and their offset
> @@ -158,6 +160,26 @@ static const struct irq_chip gpio_mlxbf3_irqchip =3D=
 {
>         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>
> +static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
> +{
> +       unsigned int id;
> +
> +       switch(chip->ngpio) {
> +       case MLXBF3_GPIO_MAX_PINS_BLOCK0:
> +               id =3D 0;
> +               break;
> +       case MLXBF3_GPIO_MAX_PINS_BLOCK1:
> +               id =3D 1;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return gpiochip_add_pin_range(chip, "MLNXBF34:00",
> +                       chip->base, id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
> +                       chip->ngpio);
> +}
> +
>  static int mlxbf3_gpio_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -197,6 +219,7 @@ static int mlxbf3_gpio_probe(struct platform_device *=
pdev)
>         gc->request =3D gpiochip_generic_request;
>         gc->free =3D gpiochip_generic_free;
>         gc->owner =3D THIS_MODULE;
> +       gc->add_pin_ranges =3D mlxbf3_gpio_add_pin_ranges;
>
>         irq =3D platform_get_irq(pdev, 0);
>         if (irq >=3D 0) {
> @@ -243,6 +266,7 @@ static struct platform_driver mlxbf3_gpio_driver =3D =
{
>  };
>  module_platform_driver(mlxbf3_gpio_driver);
>
> +MODULE_SOFTDEP("pre: pinctrl-mlxbf3");
>  MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
>  MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.30.1
>

It's not clear to me whether this depends on patch 1? If only at
run-time then I guess Linus and I can take the two patches through
ours respective trees?

Bart
