Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABA47649A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjG0H6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjG0H6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:58:06 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED944B1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:55:21 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4864be3606dso250691e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690444520; x=1691049320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wTiU1QS3gn92Yh5xPIntx1hOHsqD3iU5S77nWUG3kY=;
        b=WqxAswDZe0hTtx1sTNc2UdE6IWvEEUTrw3Sc0NLTXmy9AaAxnZ5DZPIhovPW6/PXyl
         WxUOeKXJv1eyc5MPUypFi9jiVkWYeIrUYGFaTMUBR8CxU2XH/SiY1M7iUHHqCOh/fyg5
         y++iJgNR6/3/uD+iGQ8f98XSPjuaIIZ38+K06rANnsHlxL0rC5dFKwWqLRZ+zYa6ohC/
         hYpjNKWoO7VUYGp1oTjY60V7D74DHMYbq75stMxPozPIH7leAEDmawyPXRoUkQ2/yi0N
         6zWqgw8ADU0IAUchAY35VPC4FM5N9Hm2R9avXExo3z5+WuWhcOI7mOI8qyiiueNYZq3I
         1N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444520; x=1691049320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wTiU1QS3gn92Yh5xPIntx1hOHsqD3iU5S77nWUG3kY=;
        b=IW2ezhfJF+Ad2ACR4fkmdxVQ6sYe7Q5akBBrFS2GSgYeR9GzQuzrhGsnYMSfmyb9RG
         wMDnQa8fYesMQ//5S/bhDjP0m0lWC0ucnJbNCS9engT5cqHPwQqqturUqyCUL8Yojloo
         yn0fMkpo0oPtXsnp4QmlMEj6mQq4wzxhcoqFe6jrdzqr9sYx8XRKIeja47tSM0uoD/O8
         kJ0w0V1qJAbm6ToDSfSrKA6nvyaulHDP8Qc1VkGQfVJm3W/w+VcfqIawFvCi3yWvej4W
         u7cSIJVKflKQEJP/UktyF8AZK4kViJexYzykoXhe1knTkDH2Aw9FAtgJ9v+zbO9MDUYJ
         AK3A==
X-Gm-Message-State: ABy/qLZIfIiFrOrOprNBidzCQcvO0DfTsbgVCTGxwchjZFa2VsB41bfM
        XYwejgDXL/IVmmjDFwHwPjy/j0i/fvbCwj2nnvgWaw==
X-Google-Smtp-Source: APBJJlFycQxS0qmSyJIf8rk3jC6nMZNyUdagNpc2N4FOR2b3DHnCdQTEpIAyaaVVB2RmwY9Yftt0S8T6ACfyCGX5ndw=
X-Received: by 2002:a1f:5502:0:b0:486:6861:a3b3 with SMTP id
 j2-20020a1f5502000000b004866861a3b3mr248647vkb.8.1690444520413; Thu, 27 Jul
 2023 00:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230724063414.102805-1-okan.sahin@analog.com> <20230724063414.102805-3-okan.sahin@analog.com>
In-Reply-To: <20230724063414.102805-3-okan.sahin@analog.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 27 Jul 2023 09:55:09 +0200
Message-ID: <CAMRc=Md4pTq5UyDUf44NuByobpYtGGOo0twQnBq9NW+Zt48NdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: ds4520: Add ADI DS4520 GPIO Expander Support
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 8:34=E2=80=AFAM Okan Sahin <okan.sahin@analog.com> =
wrote:
>
> The DS4520 is a 9-bit nonvolatile (NV) I/O expander.
> It offers users a digitally programmable alternative
> to hardware jumpers and mechanical switches that are
> being used to control digital logic node.
>
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---

This is such a sweet little driver, I love all these abstraction
layers we now have.

Some nits below.

>  drivers/gpio/Kconfig       | 11 +++++
>  drivers/gpio/Makefile      |  1 +
>  drivers/gpio/gpio-ds4520.c | 89 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 drivers/gpio/gpio-ds4520.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..5f89e46d6411 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1000,6 +1000,17 @@ config GPIO_ADNP
>           enough to represent all pins, but the driver will assume a
>           register layout for 64 pins (8 registers).
>
> +config GPIO_DS4520
> +       tristate "DS4520 I2C GPIO expander"
> +       select REGMAP_I2C
> +       select GPIO_REGMAP
> +       help
> +         GPIO driver for ADI DS4520 I2C-based GPIO expander.
> +         Say yes here to enable the GPIO driver for the ADI DS4520 chip.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called gpio-ds4520.
> +
>  config GPIO_GW_PLD
>         tristate "Gateworks PLD GPIO Expander"
>         depends on OF_GPIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c048ba003367..6f8656d5d617 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_GPIO_DA9052)             +=3D gpio-da9052.=
o
>  obj-$(CONFIG_GPIO_DA9055)              +=3D gpio-da9055.o
>  obj-$(CONFIG_GPIO_DAVINCI)             +=3D gpio-davinci.o
>  obj-$(CONFIG_GPIO_DLN2)                        +=3D gpio-dln2.o
> +obj-$(CONFIG_GPIO_DS4520)              +=3D gpio-ds4520.o
>  obj-$(CONFIG_GPIO_DWAPB)               +=3D gpio-dwapb.o
>  obj-$(CONFIG_GPIO_EIC_SPRD)            +=3D gpio-eic-sprd.o
>  obj-$(CONFIG_GPIO_EM)                  +=3D gpio-em.o
> diff --git a/drivers/gpio/gpio-ds4520.c b/drivers/gpio/gpio-ds4520.c
> new file mode 100644
> index 000000000000..577ffb4b8c50
> --- /dev/null
> +++ b/drivers/gpio/gpio-ds4520.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Analog Devices, Inc.
> + * Driver for the DS4520 I/O Expander
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#define DS4520_PULLUP0         0xF0
> +#define DS4520_IO_CONTROL0     0xF2
> +#define DS4520_IO_STATUS0      0xF8
> +
> +static const struct regmap_config ds4520_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +};
> +
> +static int ds4520_gpio_probe(struct i2c_client *client)
> +{
> +       struct gpio_regmap_config config =3D { };
> +       struct device *dev =3D &client->dev;
> +       struct regmap *regmap;
> +       u32 ngpio;
> +       u32 base;
> +       int ret;
> +
> +       ret =3D device_property_read_u32(dev, "reg", &base);
> +       if (ret) {
> +               dev_err_probe(dev, ret,
> +                         "Missing 'reg' property.\n");
> +               return -EINVAL;
> +       }

Please add a newline here.

> +       ret =3D device_property_read_u32(dev, "ngpios", &ngpio);
> +       if (ret) {
> +               dev_err_probe(dev, ret,
> +                         "Missing 'ngpios' property.\n");
> +               return -EINVAL;
> +       }

And here.

> +       regmap =3D devm_regmap_init_i2c(client, &ds4520_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               ret =3D PTR_ERR(regmap);
> +               dev_err_probe(dev, ret,
> +                             "Failed to allocate register map\n");
> +               return ret;
> +       }
> +
> +       config.regmap =3D regmap;
> +       config.parent =3D dev;
> +       config.ngpio =3D ngpio;
> +
> +       config.reg_dat_base =3D base + DS4520_IO_STATUS0;
> +       config.reg_set_base =3D base + DS4520_PULLUP0;
> +       config.reg_dir_out_base =3D base + DS4520_IO_CONTROL0;
> +
> +       return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &config));
> +}
> +
> +static const struct of_device_id ds4520_gpio_of_match_table[] =3D {
> +       {
> +               .compatible =3D "adi,ds4520-gpio"

Keep this on a single line.

> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ds4520_gpio_of_match_table);
> +
> +static const struct i2c_device_id ds4520_gpio_id_table[] =3D {
> +       { "ds4520-gpio" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ds4520_gpio_id_table);
> +
> +static struct i2c_driver ds4520_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "ds4520-gpio",
> +               .of_match_table =3D ds4520_gpio_of_match_table,
> +       },
> +       .probe_new =3D ds4520_gpio_probe,
> +       .id_table =3D ds4520_gpio_id_table,
> +};
> +module_i2c_driver(ds4520_gpio_driver);
> +
> +MODULE_DESCRIPTION("DS4520 I/O Expander");
> +MODULE_AUTHOR("Okan Sahin <okan.sahin@analog.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.30.2
>

Bart
