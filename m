Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5D7AA080
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjIUUjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjIUUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:38:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8877B959
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so1440559a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1695317820; x=1695922620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLJu2NuL/eaYk+hMPPZj4T+5L9DWoVkSU2kBf2uk7qU=;
        b=D/97+bPWJfY6dnGWxl40r6BF4ujyLG4IDmn3U41zLdyYEbWdjT8ffMwxBCySGHJsdx
         Q1h8WbUKSrXEOfIqOY3ZEKCTiYB5FRLIFNgiAkZF++YhJ7DGibttmNVdBv9uz+qJDSm8
         mwyE9u6OzN6+oDBcwXwqj/wQ6Ngl1YurhhZJpTn5V/VYlera2rCg2GLaBS9skFVDI3ZG
         bkLyO1SiUp6HE3co+vYXram3wtL9uuhDF9op62VSgvbTbB3LLH7u/SE3Ms4lmQKOZ6kZ
         fZPvUe96Q3nAS34g6N5FjlbfsOMes3w9ynE76PsLU+7WWJ39p1vXboKqfElbfHZGsOPA
         QGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317820; x=1695922620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLJu2NuL/eaYk+hMPPZj4T+5L9DWoVkSU2kBf2uk7qU=;
        b=Ur4zyc6FVft7KAz1QQ6EZ/qW9JMjhXZQUj83APS7Sh/k7VlRdARxr0UhOZdPa59hq9
         3s1MmxjlGUCXPDOmuCg2efbXvWdqVuBOvPiHLW7bF+fyyOkzhspR5lNzOX4J1Y067FKq
         HRkb/6G+CDltFSPTFZ+z022FODdAvKDWg5k9K7RS9pM3i4pxjMcXKof0pWrbyH+aRzkP
         maGJEdawEre8wnD+AoKQiQCBs0A+yaWbmNJZaGO7n//7JaIuuq+aUIlgkjPXw/lxEgRu
         pHGa8AISIXA9XtWq8EPPdz/Q/jjRFLkgZu+9p3QEd/DQI7/NJEs3dI5lfaDnmEJv2JT1
         cxQw==
X-Gm-Message-State: AOJu0YzhiCY3ovkx4Uo995b9W7fUugJp6Yq6uRIGH7Q1orl7K2qz7wBZ
        Qd/bpfUwGpfaJYhxQ/wD+d0BWIwI4VS8RJPro2d3XyYDmfKBX5Lw7vQ=
X-Google-Smtp-Source: AGHT+IHn8khyM1ejvz4ymQV/cmqrSuL/8tsXUJKI7yZFNLjWJz9CQu/NTkdgAOAhY3aN7FTDltIHvL0KXgGxiCcoAwQ=
X-Received: by 2002:a2e:9b42:0:b0:2bf:fa62:5d0e with SMTP id
 o2-20020a2e9b42000000b002bffa625d0emr4623999ljj.2.1695287241790; Thu, 21 Sep
 2023 02:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230914114521.1491390-1-naresh.solanki@9elements.com> <20230920130528.GG13143@google.com>
In-Reply-To: <20230920130528.GG13143@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 21 Sep 2023 14:37:09 +0530
Message-ID: <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On Wed, 20 Sept 2023 at 18:35, Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 14 Sep 2023, Naresh Solanki wrote:
>
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The MAX5970 is hot swap controller and has 4 indication LED.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> > Changes in V3:
> > - Drop array for ddata variable.
> > Changes in V2:
> > - Add of_node_put before return.
> > - Code cleanup
> > - Refactor code & remove max5970_setup_led function.
> > ---
> >  drivers/leds/Kconfig        |  11 ++++
> >  drivers/leds/Makefile       |   1 +
> >  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 122 insertions(+)
> >  create mode 100644 drivers/leds/leds-max5970.c
>
> Couple of nits and you're good to go.
>
> Once fixed please resubmit with my:
>
>   Reviewed-by: Lee Jones <lee@kernel.org>
>
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index b92208eccdea..03ef527cc545 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> >         To compile this driver as a module, choose M here: the module w=
ill
> >         be called leds-adp5520.
> >
> > +config LEDS_MAX5970
> > +     tristate "LED Support for Maxim 5970"
> > +     depends on LEDS_CLASS
> > +     depends on MFD_MAX5970
> > +     help
> > +       This option enables support for the Maxim MAX5970 & MAX5978 sma=
rt
> > +       switch indication LEDs via the I2C bus.
> > +
> > +       To compile this driver as a module, choose M here: the module w=
ill
> > +       be called leds-max5970.
> > +
> >  config LEDS_MC13783
> >       tristate "LED Support for MC13XXX PMIC"
> >       depends on LEDS_CLASS
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index d7348e8bc019..6eaee0a753c6 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           +=3D leds-lp8501.=
o
> >  obj-$(CONFIG_LEDS_LP8788)            +=3D leds-lp8788.o
> >  obj-$(CONFIG_LEDS_LP8860)            +=3D leds-lp8860.o
> >  obj-$(CONFIG_LEDS_LT3593)            +=3D leds-lt3593.o
> > +obj-$(CONFIG_LEDS_MAX5970)           +=3D leds-max5970.o
> >  obj-$(CONFIG_LEDS_MAX77650)          +=3D leds-max77650.o
> >  obj-$(CONFIG_LEDS_MAX8997)           +=3D leds-max8997.o
> >  obj-$(CONFIG_LEDS_MC13783)           +=3D leds-mc13783.o
> > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> > new file mode 100644
> > index 000000000000..c9685990e26e
> > --- /dev/null
> > +++ b/drivers/leds/leds-max5970.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device driver for leds in MAX5970 and MAX5978 IC
> > + *
> > + * Copyright (c) 2022 9elements GmbH
> > + *
> > + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> > + */
> > +
> > +#include <linux/leds.h>
> > +#include <linux/mfd/max5970.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cd=
ev)
> > +
> > +struct max5970_led {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     struct led_classdev cdev;
> > +     unsigned int index;
> > +};
> > +
> > +static int max5970_led_set_brightness(struct led_classdev *cdev,
> > +                                   enum led_brightness brightness)
> > +{
> > +     struct max5970_led *ddata =3D ldev_to_maxled(cdev);
> > +     int ret, val;
> > +
> > +     /* Set/clear corresponding bit for given led index */
> > +     val =3D !brightness ? BIT(ddata->index) : 0;
> > +
> > +     ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, =
BIT(ddata->index), val);
> > +     if (ret < 0)
> > +             dev_err(cdev->dev, "failed to set brightness %d", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int max5970_led_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *np =3D dev_of_node(dev->parent);
> > +     struct regmap *regmap;
> > +     struct device_node *led_node;
> > +     struct device_node *child;
>
> Nit: You can place these on the same line.
Ack
>
> > +     struct max5970_led *ddata;
> > +     int ret =3D -ENODEV, num_leds =3D 0;
> > +
> > +     regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!regmap)
> > +             return -EPROBE_DEFER;
>
> Why are you deferring here?
This is a Leaf driver. Making sure the parent driver has initialized regmap=
.
>
> > +     led_node =3D of_get_child_by_name(np, "leds");
> > +     if (!led_node)
> > +             return -ENODEV;
> > +
> > +     for_each_available_child_of_node(led_node, child) {
> > +             u32 reg;
> > +
> > +             if (of_property_read_u32(child, "reg", &reg))
> > +                     continue;
> > +
> > +             if (reg >=3D MAX5970_NUM_LEDS) {
> > +                     dev_err(dev, "invalid LED (%u >=3D %d)\n", reg, M=
AX5970_NUM_LEDS);
> > +                     continue;
> > +             }
> > +
> > +             ddata =3D devm_kzalloc(dev, sizeof(struct max5970_led), G=
FP_KERNEL);
>
> Nit: sizeof(*ddata)
Ack
>
> > +             if (!ddata) {
> > +                     of_node_put(child);
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             ddata->index =3D reg;
> > +             ddata->regmap =3D regmap;
> > +             ddata->dev =3D dev;
> > +
> > +             if (of_property_read_string(child, "label", &ddata->cdev.=
name))
> > +                     ddata->cdev.name =3D child->name;
> > +
> > +             ddata->cdev.max_brightness =3D 1;
> > +             ddata->cdev.brightness_set_blocking =3D max5970_led_set_b=
rightness;
> > +             ddata->cdev.default_trigger =3D "none";
> > +
> > +             ret =3D devm_led_classdev_register(ddata->dev, &ddata->cd=
ev);
>
> Nit: Use the shorter 'dev' version whilst it's available.
Ack
>
> > +             if (ret < 0) {
> > +                     of_node_put(child);
> > +                     dev_err(dev, "Failed to initialize LED %u\n", reg=
);
> > +                     return ret;
> > +             }
> > +             num_leds++;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static struct platform_driver max5970_led_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "max5970-led",
> > +     },
> > +     .probe =3D max5970_led_probe,
> > +};
> > +
> > +module_platform_driver(max5970_led_driver);
> > +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> > +MODULE_AUTHOR("Naresh Solanki <Naresh.Solanki@9elements.com>");
> > +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
> > --
> > 2.41.0
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
