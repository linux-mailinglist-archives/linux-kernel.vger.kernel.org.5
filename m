Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F16786D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbjHXK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjHXKzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:55:35 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3C5E51
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:55:33 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fb8963617so54133037b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692874532; x=1693479332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+uYauH0l6Sva+By8wg5HG0jXcoGi64pGJ2HXiMwecQ=;
        b=JSf/kK8T/XgHBx6uqT9+2JuDkSlFk2EzGHalycCVkfYNAcy+8BvskZHXKCNb4gq7xa
         pAgcrYPOHu1sfMm+IxXnjL/QZUb1AwmlPjI6C24asHeTumSMk/Wi1p+IrvXoiTuec2NY
         YTPVU0ZhlWrJDUuRLpVVldlBWtvOjIL+SaEsYslCR4vOtEPqv++VQUYo5LX4pnEcjjEF
         br06LqmQ5FhKbUgAtNkTwZvcE1ahJe5mViYv/N2WlKcBCw8A59UJtil8rULmQNQg/iES
         nh0e3G1a6g+o9v5UIVbNWOAD6XFA/GjydcbCtPcUjI7mm2x8qFYbecHu8Ol8o2wk73+o
         AqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874532; x=1693479332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+uYauH0l6Sva+By8wg5HG0jXcoGi64pGJ2HXiMwecQ=;
        b=X5kCh3+rfPQEeiNMMi6/eD6Rcsx/7o0hj7DmaV86U3AG1LGMkNd7lPPHWXipcwEJbD
         kV/1VwO+E8kykZCwxFEGJhr2wbMgV4HhZxLvMxwRyQuSJmbvS1HqOU9j1EuBNL6sn2O9
         6WX83Kaic23AILYMgpuexfFmMszmgi44JRyUEHHB6X3+lLL86cpXf1qeC63+8qwBZjYD
         57TYC+Hw6fMXD6TGKwfZyZ1VREgBK686IFuQSqlLHvbBbEs5bAoQOXIbEV4Ivcqm8O+v
         Zdpfx4sr5FRB7twjvEHveVstgyhrDT5uwUIb462SEpVQJHDN1CZKWAVmkLLHPiPlKtoW
         Kylw==
X-Gm-Message-State: AOJu0YwIs50Wo3I7dAhHWMpQpL8wnhy3P+CyAqukP8WOE9o8INvynYia
        B5wQRnb1cdiQWsQlCnl2Hj/YyxIZsg6BOkaniCDR1cmxWVU/0QJX2FtHug==
X-Google-Smtp-Source: AGHT+IH/JIlVXF8Y+aNZjkH2Z/a/whN6evvbYm7Cwe5/RzkpMFO8WWnIUnIzPAft7muDklPjDAilJ6q7C3COJTKxzzs=
X-Received: by 2002:a81:6546:0:b0:583:d0c3:9ae1 with SMTP id
 z67-20020a816546000000b00583d0c39ae1mr14179276ywb.51.1692874532497; Thu, 24
 Aug 2023 03:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230824104909.2451625-1-Naresh.Solanki@9elements.com>
In-Reply-To: <20230824104909.2451625-1-Naresh.Solanki@9elements.com>
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Thu, 24 Aug 2023 12:55:21 +0200
Message-ID: <CALNFmy0TxrrH1G-QZmZDLumP22kZr5PE-fE4JDU6yRo96p89xw@mail.gmail.com>
Subject: Re: [PATCH v2] leds: max5970: Add support for max5970
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
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

On Thu, Aug 24, 2023 at 12:49=E2=80=AFPM Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> The MAX5970 is hot swap controller and has 4 indication LED.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
> Changes in V2:
> - Add of_node_put before return.
> - Code cleanup
> - Refactor code & remove max5970_setup_led function.
> ---
>  drivers/leds/Kconfig        |  11 ++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
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
> index 000000000000..79277d47e1bc
> --- /dev/null
> +++ b/drivers/leds/leds-max5970.c
> @@ -0,0 +1,110 @@
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
> +                       of_node_put(child);
> +                       return -ENOMEM;
> +               }
This overflows if more than MAX5970_NUM_LEDS child nodes are present
in the node.
Better drop the array as you don't use it any more.

> +
> +               ddata[num_leds]->index =3D reg;
> +               ddata[num_leds]->regmap =3D regmap;
> +               ddata[num_leds]->dev =3D dev;
> +
> +               if (of_property_read_string(child, "label", &ddata[num_le=
ds]->cdev.name))
> +                       ddata[num_leds]->cdev.name =3D child->name;
> +
> +               ddata[num_leds]->cdev.max_brightness =3D 1;
> +               ddata[num_leds]->cdev.brightness_set_blocking =3D max5970=
_led_set_brightness;
> +               ddata[num_leds]->cdev.default_trigger =3D "none";
> +
> +               ret =3D devm_led_classdev_register(ddata[num_leds]->dev, =
&ddata[num_leds]->cdev);
> +               if (ret < 0) {
> +                       of_node_put(child);
> +                       dev_err(dev, "Failed to initialize LED %u\n", reg=
);
> +                       return ret;
> +               }
> +               num_leds++;
> +       }
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
> +MODULE_AUTHOR("Naresh Solanki <Naresh.Solanki@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> +MODULE_LICENSE("GPL");
>
> base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
> --
> 2.41.0
>
