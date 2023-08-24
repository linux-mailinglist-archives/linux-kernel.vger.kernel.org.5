Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963EB786C43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbjHXJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbjHXJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:47:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C310FE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:47:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf3a2f4528so49052535ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692870457; x=1693475257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWxfMCKx24v0hKeuB+9RdqssKYQxCmlIP9NgrmQlQa0=;
        b=YmBewga+Xz4uJ9Uroj4l07O2zQSRCpY36347lN0zgzULCDhgA1/ABwndj1LbCnb2Yw
         xt9Z/d3Ga49H5vhnCBXx4bknEmeR2GrnrV1Rm5ucjALvHqCPLu+MRxLxUpziwDMKAGFL
         rLhxaxITOS7QtNs6FQcJQLQcCOlGx6gJ6AaIYIjDJOlWbZ9kd4VbLlFofJJJmaM8TKeX
         KAzE2/rHxlX34rZ6UBVf6/bX/AE6JOBylcbnNPOCwr4CRJO9CpmzaAvdhYOWImA5in7p
         fb6dAIuqBcGbqsnC5JCuqLqAoZt9ZyFIGxkYAG9MD/Q1ElSqOdfUwWpHJwBcgkhfGifC
         MxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692870457; x=1693475257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWxfMCKx24v0hKeuB+9RdqssKYQxCmlIP9NgrmQlQa0=;
        b=SvAjsm85LcUS41aepWsPXX4UuuZG82wfpe9gEEM/P3eifZgO/CFZvrjdf+hblGK2RX
         IACDePYKVT+YXtLix0DR0QTW768kdFlNo/h4Pfq2J8F19b6Md3tgjPz7XbEjAglBF8qE
         H5Lv4n8jMZxaosQajw8VwFh72Va2pC7KysF2Cv6+kyrwT/fXS0+dE0zesf2/MPDoAAjH
         1L3aqLHbWwftbv4DOgtceg1VYBmwE2eFQNZTGCvcWRf5mEO99sW7eKkMJa0dKa6msxjI
         /eTpRxnkqLocrAPU++e74vfEKWwz3ZgAeYo2IbhRRls4imG/SofU1/6i8CszN6zUtFEy
         QQxg==
X-Gm-Message-State: AOJu0YytAdPbt0sVlV74pNoFQFIsfogDUvh96/maD+4qTO6B8tMmmrRC
        PlTtMZl/cYwkc68O58EkqS9gzyVCVB2fT1cdvs5aWA==
X-Google-Smtp-Source: AGHT+IGSjWhL/d8marnC3BliK5rf/wwX+DZMmPX0g/a8KRIyCFotZFUeoWlx1QgR2BuM9LigYw8ZYs/00xl9YagB7UU=
X-Received: by 2002:a17:90a:bb95:b0:26d:2655:8a5f with SMTP id
 v21-20020a17090abb9500b0026d26558a5fmr11763599pjr.48.1692870456891; Thu, 24
 Aug 2023 02:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230823212309.1463769-1-Naresh.Solanki@9elements.com> <c0dc90d4-8ae1-8acd-8d4d-aca9515cebef@wanadoo.fr>
In-Reply-To: <c0dc90d4-8ae1-8acd-8d4d-aca9515cebef@wanadoo.fr>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 24 Aug 2023 15:17:27 +0530
Message-ID: <CABqG17hYoeVtdZNKeo6GXy558XF3M1G2H_A4jdFKC1QUNEigYw@mail.gmail.com>
Subject: Re: [PATCH] leds: max5970: Add support for max5970
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
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

Hi,


On Thu, 24 Aug 2023 at 03:22, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 23/08/2023 =C3=A0 23:23, Naresh Solanki a =C3=A9crit :
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The MAX5970 is hot swap controller and has 4 indication LED.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >   drivers/leds/Kconfig        |  11 +++
> >   drivers/leds/Makefile       |   1 +
> >   drivers/leds/leds-max5970.c | 129 +++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 141 insertions(+)
> >   create mode 100644 drivers/leds/leds-max5970.c
> >
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
> >   config LEDS_MC13783
> >       tristate "LED Support for MC13XXX PMIC"
> >       depends on LEDS_CLASS
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index d7348e8bc019..6eaee0a753c6 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           +=3D leds-lp8501.=
o
> >   obj-$(CONFIG_LEDS_LP8788)           +=3D leds-lp8788.o
> >   obj-$(CONFIG_LEDS_LP8860)           +=3D leds-lp8860.o
> >   obj-$(CONFIG_LEDS_LT3593)           +=3D leds-lt3593.o
> > +obj-$(CONFIG_LEDS_MAX5970)           +=3D leds-max5970.o
> >   obj-$(CONFIG_LEDS_MAX77650)         +=3D leds-max77650.o
> >   obj-$(CONFIG_LEDS_MAX8997)          +=3D leds-max8997.o
> >   obj-$(CONFIG_LEDS_MC13783)          +=3D leds-mc13783.o
> > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> > new file mode 100644
> > index 000000000000..5be1b927f39e
> > --- /dev/null
> > +++ b/drivers/leds/leds-max5970.c
> > @@ -0,0 +1,129 @@
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
> > +     if (!ddata->regmap)
> > +             return -ENODEV;
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
> > +static int max5970_setup_led(struct max5970_led *ddata, struct regmap =
*regmap,
> > +                          struct device_node *nc, u32 reg)
> > +{
> > +     int ret;
> > +
> > +     if (of_property_read_string(nc, "label", &ddata->cdev.name))
> > +             ddata->cdev.name =3D nc->name;
> > +
> > +     ddata->cdev.max_brightness =3D 1;
> > +     ddata->cdev.brightness_set_blocking =3D max5970_led_set_brightnes=
s;
> > +     ddata->cdev.default_trigger =3D "none";
> > +
> > +     ret =3D devm_led_classdev_register(ddata->dev, &ddata->cdev);
> > +     if (ret)
> > +             dev_err(ddata->dev, "Error initializing LED %s", ddata->c=
dev.name);
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
> > +     struct max5970_led *ddata[MAX5970_NUM_LEDS];
> > +     int ret =3D -ENODEV, num_leds =3D 0;
> > +
> > +     regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!regmap)
> > +             return -EPROBE_DEFER;
> > +
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
> > +             ddata[num_leds] =3D devm_kzalloc(dev, sizeof(struct max59=
70_led), GFP_KERNEL);
> > +             if (!ddata[num_leds]) {
> > +                     ret =3D -ENOMEM;
>
> Hi,
>
> Should we have a "of_node_put(child);" here?
Ack. Will add in next revision.
>
> > +                     goto exit;
> > +             }
> > +
> > +             ddata[num_leds]->index =3D reg;
> > +             ddata[num_leds]->regmap =3D regmap;
> > +             ddata[num_leds]->dev =3D dev;
> > +
> > +             ret =3D max5970_setup_led(ddata[num_leds], regmap, child,=
 reg);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "Failed to initialize LED %u\n", reg=
);
>
> Should we have a "of_node_put(child);" here?
Ack.
>
> > +                     goto exit;
> > +             }
> > +             num_leds++;
> > +     }
> > +
> > +     return ret;
> > +
> > +exit:
> > +     for (int j =3D 0; j < num_leds; j++)
> > +             devm_led_classdev_unregister(dev, &ddata[j]->cdev);
>
> Is it really needed?
> There is no equivalent call in a .remove function and
> devm_led_classdev_register() is used.
>
> Shouldn't the unregister step be done automatically by the framework?
Ack. Will be removed in the next revision.
Instead of using goto exit, will return with the error code.

Regards,
Naresh
>
> CJ
>
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
> > +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
>
