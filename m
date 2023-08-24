Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF33786C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjHXKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbjHXJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:59:57 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4144A19AC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:59:54 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44d3666c6cfso2251761137.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692871193; x=1693475993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7niQIdqSj3magIfw0G01bTXlocxuig+rGg0t1RLnPI=;
        b=C5BvWEElzmVaLi3cV54p5/i8FW778qAxWD9nFjCP0HiuGe14kHcl6rc0AU8J1bSel0
         49EVN2tnPl8yfcb55s0jTqCC8R40L03kpYQIh+WT0P2cLz72Ftzqpr6NGiBmo56mhHu3
         ePOSegiMCGy84M8G42wxfg6F4zd0+gg3+jSW7YQzVnACDL9ohE358uK5H2hxHMAueQsy
         RZu8/ZLa5uH4q/GLnhmB0RZlzfIEl3cVjrWoD1n0SpCjMdZ2kY62v2OGr+w70gXdNRQC
         Ki2dxSpcILTlsXaRwZWJFxUZ6nxXTFJDxcAe5XeGBjvo2hO3DPgPsiagvd/aO1uYbTGW
         HXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871193; x=1693475993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7niQIdqSj3magIfw0G01bTXlocxuig+rGg0t1RLnPI=;
        b=bh13bDSsuJHuCwX4Yav5HN2M+gnLU404aoMxHQdYdo1QURdQ+ITBz/qcEOGnwugrIr
         ealeuecWZf+P4VWvr1fbpFOYmtzIxQFKntqylqZfQpFeJnnakEjjb2k9JdG7TLaKcOtK
         VtkR3N4p2NiWq5anCHhi6ggptIRT+LED60OzEekM4KHpETwvKe9ggWGLFP9C0XzYYhbl
         Lgq4cnIWMIoPY71D8pPWviu0qupM5ENILbgiF3Tzvz3qPpPrXJTLeAxPePap/vYoHcUS
         DJH5Qj0LQQ3SbiZ23kh3JfM2UZ5J5lVqF6LeEAXxt8421S4INsKVmuvRAjrFfHGGPB/a
         xw5g==
X-Gm-Message-State: AOJu0YyqX9s6jsxGd+xPTMwYwqc3VtD7Cshdb/N4l9TZgmPNLcJs26CS
        8MLs3AibNCLkAKwYQ6xyhf9AhWLsgQ7cPo2BLWYi1w==
X-Google-Smtp-Source: AGHT+IFlFmaKIQY3uhB1FHb6+wPlSD4qLwrBUIOYv06tzHYykeBLUaHHx05TmdlJzO4TB8afpemqIKGVEeiaiJ3ipIY=
X-Received: by 2002:a05:6102:c4:b0:44d:5c61:e475 with SMTP id
 u4-20020a05610200c400b0044d5c61e475mr7500689vsp.32.1692871193345; Thu, 24 Aug
 2023 02:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230823212309.1463769-1-Naresh.Solanki@9elements.com>
In-Reply-To: <20230823212309.1463769-1-Naresh.Solanki@9elements.com>
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Thu, 24 Aug 2023 11:59:42 +0200
Message-ID: <CALNFmy0H2pg_hJvvNPrq7XkqUS2rDbMnpfFMEC4jOG-Ghhj3zQ@mail.gmail.com>
Subject: Re: [PATCH] leds: max5970: Add support for max5970
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:23=E2=80=AFPM Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> The MAX5970 is hot swap controller and has 4 indication LED.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/leds/Kconfig        |  11 +++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max5970.c | 129 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 drivers/leds/leds-max5970.c
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b92208eccdea..03ef527cc545 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -637,6 +637,17 @@ config LEDS_ADP5520
>           To compile this driver as a module, choose M here: the module w=
ill
>           be called leds-adp5520.
>
> +config LEDS_MAX5970
> +       tristate "LED Support for Maxim 5970"
> +       depends on LEDS_CLASS
> +       depends on MFD_MAX5970
> +       help
> +         This option enables support for the Maxim MAX5970 & MAX5978 sma=
rt
> +         switch indication LEDs via the I2C bus.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called leds-max5970.
> +
>  config LEDS_MC13783
>         tristate "LED Support for MC13XXX PMIC"
>         depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d7348e8bc019..6eaee0a753c6 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)             +=3D leds-lp8501.=
o
>  obj-$(CONFIG_LEDS_LP8788)              +=3D leds-lp8788.o
>  obj-$(CONFIG_LEDS_LP8860)              +=3D leds-lp8860.o
>  obj-$(CONFIG_LEDS_LT3593)              +=3D leds-lt3593.o
> +obj-$(CONFIG_LEDS_MAX5970)             +=3D leds-max5970.o
>  obj-$(CONFIG_LEDS_MAX77650)            +=3D leds-max77650.o
>  obj-$(CONFIG_LEDS_MAX8997)             +=3D leds-max8997.o
>  obj-$(CONFIG_LEDS_MC13783)             +=3D leds-mc13783.o
> diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> new file mode 100644
> index 000000000000..5be1b927f39e
> --- /dev/null
> +++ b/drivers/leds/leds-max5970.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for leds in MAX5970 and MAX5978 IC
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/leds.h>
> +#include <linux/mfd/max5970.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev=
)
> +
> +struct max5970_led {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct led_classdev cdev;
> +       unsigned int index;
> +};
> +
> +static int max5970_led_set_brightness(struct led_classdev *cdev,
> +                                     enum led_brightness brightness)
> +{
> +       struct max5970_led *ddata =3D ldev_to_maxled(cdev);
> +       int ret, val;
> +
> +       if (!ddata->regmap)
> +               return -ENODEV;
Can this ever happen? Looks like this conditions is always false.

> +
> +       /* Set/clear corresponding bit for given led index */
> +       val =3D !brightness ? BIT(ddata->index) : 0;
> +
> +       ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, =
BIT(ddata->index), val);
> +       if (ret < 0)
> +               dev_err(cdev->dev, "failed to set brightness %d", ret);
> +
> +       return ret;
> +}
> +
> +static int max5970_setup_led(struct max5970_led *ddata, struct regmap *r=
egmap,
> +                            struct device_node *nc, u32 reg)
> +{
regmap and reg is not used within this function.
I don't see the need for this function, just add those 8 lines in the
loop below.

> +       int ret;
> +
> +       if (of_property_read_string(nc, "label", &ddata->cdev.name))
> +               ddata->cdev.name =3D nc->name;
> +
> +       ddata->cdev.max_brightness =3D 1;
> +       ddata->cdev.brightness_set_blocking =3D max5970_led_set_brightnes=
s;
> +       ddata->cdev.default_trigger =3D "none";
> +
> +       ret =3D devm_led_classdev_register(ddata->dev, &ddata->cdev);
> +       if (ret)
> +               dev_err(ddata->dev, "Error initializing LED %s", ddata->c=
dev.name);
> +
> +       return ret;
> +}
> +
> +static int max5970_led_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev_of_node(dev->parent);
> +       struct regmap *regmap;
> +       struct device_node *led_node;
> +       struct device_node *child;
> +       struct max5970_led *ddata[MAX5970_NUM_LEDS];
> +       int ret =3D -ENODEV, num_leds =3D 0;
> +
> +       regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!regmap)
> +               return -EPROBE_DEFER;
> +
> +       led_node =3D of_get_child_by_name(np, "leds");
> +       if (!led_node)
> +               return -ENODEV;
> +
> +       for_each_available_child_of_node(led_node, child) {
> +               u32 reg;
> +
> +               if (of_property_read_u32(child, "reg", &reg))
> +                       continue;
> +
> +               if (reg >=3D MAX5970_NUM_LEDS) {
> +                       dev_err(dev, "invalid LED (%u >=3D %d)\n", reg, M=
AX5970_NUM_LEDS);
> +                       continue;
> +               }
> +
> +               ddata[num_leds] =3D devm_kzalloc(dev, sizeof(struct max59=
70_led), GFP_KERNEL);
> +               if (!ddata[num_leds]) {
> +                       ret =3D -ENOMEM;
> +                       goto exit;
> +               }
> +
> +               ddata[num_leds]->index =3D reg;
> +               ddata[num_leds]->regmap =3D regmap;
> +               ddata[num_leds]->dev =3D dev;
> +
> +               ret =3D max5970_setup_led(ddata[num_leds], regmap, child,=
 reg);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to initialize LED %u\n", reg=
);
> +                       goto exit;
> +               }
> +               num_leds++;
> +       }
> +
> +       return ret;
> +
> +exit:
> +       for (int j =3D 0; j < num_leds; j++)
> +               devm_led_classdev_unregister(dev, &ddata[j]->cdev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver max5970_led_driver =3D {
> +       .driver =3D {
> +               .name =3D "max5970-led",
> +       },
> +       .probe =3D max5970_led_probe,
> +};
> +
> +module_platform_driver(max5970_led_driver);
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");

You might want to put your name here, as you've rewritten the complete
driver code.

> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> +MODULE_LICENSE("GPL");
>
> base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
> --
> 2.41.0
>
