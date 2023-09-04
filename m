Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB78A791274
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjIDHnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjIDHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:43:16 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F2EDF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:43:12 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44e8f9f3cceso549713137.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693813392; x=1694418192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPYq4o9FDjKvryJ0yiJ0/iSuZorp8tc9qM62A50rFPE=;
        b=kTOT8/PyF8XUz+SCplYAbidVUQPXPFWlZVdFhSt7iPbD3J9DYJqvWrJjZWdcnJyNqz
         3ukZlL4nvXrYs5fmzqstKyfr96+apqIsNBwwOFpDpHG0MtD1ZYnEJOULvLJ/a8wHuxJg
         IRSdB3FuDDATapxtE+WkV+HOa3Xy7axozo0WKJX9DjHyIyitbkVYWQo7ZOZRMLC38u4e
         9jCv/K+lHGAnsN3k5SQZgBWx5BxkHz8VIgiF7qYGxHdeR4CIKHOteKXbhJe86+rGYh6s
         AB9zTta5E0yEprVq8T57o1r3LVdH7hFMT6AJVsuzRfE+72ld99uwwXLUyxDnGAqlhbBb
         1ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813392; x=1694418192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPYq4o9FDjKvryJ0yiJ0/iSuZorp8tc9qM62A50rFPE=;
        b=Z83hnJ8EVTViU+hXM5f/QaOVvJlOdTto02QaHlY974sUknYMwwctAl4kE2UdjaCDlm
         FLBXtSErPv17gB56935nZ2S3ZWgutgB5WZI/rNAntdE2mVT90ihcX4+L5jNlCyXcMKxW
         bEwEskmL+nWtvxtoBedSwFbKVkwFJZYpGzkfekm3PpEiqvR7FJkOUGADTlokGAAwP8Q4
         r9f1OKVW8B3gCGke+QWhdt+CyBWxGR2LnJrfnNZVGmn6KBotKOPDgHx3nTv+w1U8cZm+
         FCUUCWscaILwSfFIzs8XslW40InxuwuUScOh5rrxZRnJeTJwetrCMvrqZvx36lZSk2IN
         5YCg==
X-Gm-Message-State: AOJu0YxHMaj6DBhvhaMuI1IJcBEOf0eLooG1Bs0R09RMr34UOWJO94Qv
        fsfNqzE0OKTOKm0aMldgq16xvOhiH6zztetck3TWFQ==
X-Google-Smtp-Source: AGHT+IEaqFvGxcYv1tqY8pEARjSlqD4qAVtaCSzfVHpOoe1IaGWe7qQBevdtLOn2W/sJn6zn9HGHq2VATpUIo7Q8UA8=
X-Received: by 2002:a67:e3c9:0:b0:44d:5c61:e475 with SMTP id
 k9-20020a67e3c9000000b0044d5c61e475mr7412252vsm.32.1693813391978; Mon, 04 Sep
 2023 00:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Sep 2023 09:43:01 +0200
Message-ID: <CAMRc=Metu3dB0iF1C-5nwTr2Vj1rk0AJAwzn8Dkgto8t-jn_LA@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] gpio: pca953x: Drop unused fields in struct pca953x_platform_data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
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

On Fri, Sep 1, 2023 at 3:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> New code should solely use firmware nodes for the specifics and
> not any callbacks.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-pca953x.c           | 37 ++++++---------------------
>  include/linux/platform_data/pca953x.h | 13 ----------
>  2 files changed, 8 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index bdd50a78e414..02695abd0eb1 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -211,7 +211,6 @@ struct pca953x_chip {
>
>         struct i2c_client *client;
>         struct gpio_chip gpio_chip;
> -       const char *const *names;
>         unsigned long driver_data;
>         struct regulator *regulator;
>
> @@ -712,7 +711,6 @@ static void pca953x_setup_gpio(struct pca953x_chip *c=
hip, int gpios)
>         gc->label =3D dev_name(&chip->client->dev);
>         gc->parent =3D &chip->client->dev;
>         gc->owner =3D THIS_MODULE;
> -       gc->names =3D chip->names;
>  }
>
>  #ifdef CONFIG_GPIO_PCA953X_IRQ
> @@ -998,7 +996,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chi=
p,
>  }
>  #endif
>
> -static int device_pca95xx_init(struct pca953x_chip *chip, u32 invert)
> +static int device_pca95xx_init(struct pca953x_chip *chip)
>  {
>         DECLARE_BITMAP(val, MAX_LINE);
>         u8 regaddr;
> @@ -1016,24 +1014,21 @@ static int device_pca95xx_init(struct pca953x_chi=
p *chip, u32 invert)
>         if (ret)
>                 goto out;
>
> -       /* set platform specific polarity inversion */
> -       if (invert)
> -               bitmap_fill(val, MAX_LINE);
> -       else
> -               bitmap_zero(val, MAX_LINE);
> +       /* clear polarity inversion */
> +       bitmap_zero(val, MAX_LINE);
>
>         ret =3D pca953x_write_regs(chip, chip->regs->invert, val);
>  out:
>         return ret;
>  }
>
> -static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
> +static int device_pca957x_init(struct pca953x_chip *chip)
>  {
>         DECLARE_BITMAP(val, MAX_LINE);
>         unsigned int i;
>         int ret;
>
> -       ret =3D device_pca95xx_init(chip, invert);
> +       ret =3D device_pca95xx_init(chip);
>         if (ret)
>                 goto out;
>
> @@ -1054,9 +1049,8 @@ static int pca953x_probe(struct i2c_client *client)
>  {
>         struct pca953x_platform_data *pdata;
>         struct pca953x_chip *chip;
> -       int irq_base =3D 0;
> +       int irq_base;
>         int ret;
> -       u32 invert =3D 0;
>         struct regulator *reg;
>         const struct regmap_config *regmap_config;
>
> @@ -1068,8 +1062,6 @@ static int pca953x_probe(struct i2c_client *client)
>         if (pdata) {
>                 irq_base =3D pdata->irq_base;
>                 chip->gpio_start =3D pdata->gpio_base;
> -               invert =3D pdata->invert;
> -               chip->names =3D pdata->names;
>         } else {
>                 struct gpio_desc *reset_gpio;
>
> @@ -1158,10 +1150,10 @@ static int pca953x_probe(struct i2c_client *clien=
t)
>          */
>         if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA957X_TYPE) {
>                 chip->regs =3D &pca957x_regs;
> -               ret =3D device_pca957x_init(chip, invert);
> +               ret =3D device_pca957x_init(chip);
>         } else {
>                 chip->regs =3D &pca953x_regs;
> -               ret =3D device_pca95xx_init(chip, invert);
> +               ret =3D device_pca95xx_init(chip);
>         }
>         if (ret)
>                 goto err_exit;
> @@ -1174,13 +1166,6 @@ static int pca953x_probe(struct i2c_client *client=
)
>         if (ret)
>                 goto err_exit;
>
> -       if (pdata && pdata->setup) {
> -               ret =3D pdata->setup(client, chip->gpio_chip.base,
> -                                  chip->gpio_chip.ngpio, pdata->context)=
;
> -               if (ret < 0)
> -                       dev_warn(&client->dev, "setup failed, %d\n", ret)=
;
> -       }
> -
>         return 0;
>
>  err_exit:
> @@ -1190,14 +1175,8 @@ static int pca953x_probe(struct i2c_client *client=
)
>
>  static void pca953x_remove(struct i2c_client *client)
>  {
> -       struct pca953x_platform_data *pdata =3D dev_get_platdata(&client-=
>dev);
>         struct pca953x_chip *chip =3D i2c_get_clientdata(client);
>
> -       if (pdata && pdata->teardown) {
> -               pdata->teardown(client, chip->gpio_chip.base,
> -                               chip->gpio_chip.ngpio, pdata->context);
> -       }
> -
>         regulator_disable(chip->regulator);
>  }
>
> diff --git a/include/linux/platform_data/pca953x.h b/include/linux/platfo=
rm_data/pca953x.h
> index 96c1a14ab365..3c3787c4d96c 100644
> --- a/include/linux/platform_data/pca953x.h
> +++ b/include/linux/platform_data/pca953x.h
> @@ -11,21 +11,8 @@ struct pca953x_platform_data {
>         /* number of the first GPIO */
>         unsigned        gpio_base;
>
> -       /* initial polarity inversion setting */
> -       u32             invert;
> -
>         /* interrupt base */
>         int             irq_base;
> -
> -       void            *context;       /* param to setup/teardown */
> -
> -       int             (*setup)(struct i2c_client *client,
> -                               unsigned gpio, unsigned ngpio,
> -                               void *context);
> -       void            (*teardown)(struct i2c_client *client,
> -                               unsigned gpio, unsigned ngpio,
> -                               void *context);
> -       const char      *const *names;
>  };
>
>  #endif /* _LINUX_PCA953X_H */
> --
> 2.40.0.1.gaa8946217a0b
>

Ah, we're so close to getting rid of platform data entirely...

Series looks good to me, I'll pick it up next week after the merge
window closes.

Bart
