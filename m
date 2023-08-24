Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424C0786D21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjHXKte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbjHXKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:49:30 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5419A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:49:27 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c11d53221cso4235370fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692874167; x=1693478967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD+pu8IOW7o+CDEb1byeOWICAn+D8bo/rO0zOdyMsEM=;
        b=HMyKAkZ/y6CV62R3gyiHRrskpDBOhQ7hGP3aRWW9BRe79JwcqpCIgdG8lSYCnC3RsA
         co4nFg7mz+YjNoxdo22qKhGijMhCl65usOJXRIon7FnHcNbTOZ/lU/KPofzUyGPtnzow
         sSb9S2Rd08T4jeDxMw6JbELgurAn3yXFyNcQQZRo4tj/LCfaqkuVBFxDDmiAEa7j6Gdy
         f8M0HeeayOsiINtIKjkx0jGp7Ux8ap2+Gf4hkLCh2v3ISyyLztNmGizS8Hvf5sj/CJf/
         yWt40hoYKJPv+8p/ZZ8dacbDXOX4Tc+AFtQQjOhDltrgN041YWoszwjxcAOzl+IaFkLj
         F50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874167; x=1693478967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wD+pu8IOW7o+CDEb1byeOWICAn+D8bo/rO0zOdyMsEM=;
        b=lPyM3dFecXKp6KhLrceJVLU0sk7Z3cIRJ3Lz8Vrm6it0zvUWEgEfIK9JRNHheBwIek
         B1ge3q1MUPuQGx1T/ZfyGINQ86LYOw1maAHObEHNhkq//LmEnbt1dZS6hP7RxVt9K2aE
         l8DwZkYA/C/QgXpFmwILovrsTD8m+8ZR8FE4NLiC8R/SzqYe4++CoIqTqP+zmY5clHgb
         qefiraPh/KslkYr3RN4JVc/yAK5TbR8DFbYxGRe3+ucrz0pxGjyagZYmv/mWdecjvchI
         XrI1y7NCyWtk8v9QoMyb0hYpHNIkqoMMog8Vgoy50aUo3wWDgvpS3yOLal+cMjB6F4t2
         e6Jg==
X-Gm-Message-State: AOJu0Yzl1+lBf2ZmhMup+S3Jo3RrGey5YEjGDvf2M0BVjVNY9VbQlYkO
        Ea9ylHQLyYyF3v0LnKvUfO89n7gDWE+XkQ8FAXUAwFDDvurykE7rcGDwAg==
X-Google-Smtp-Source: AGHT+IHoGyYHl4qkTmgcMUzIPzHxZHc+da4EsIr7XJ5IHW3V6mDxGIO0Z3ouW4JkHo8wIf6FaMXsnAJU+rsd0e+mEz8=
X-Received: by 2002:a05:6870:659f:b0:1b0:408a:1d14 with SMTP id
 fp31-20020a056870659f00b001b0408a1d14mr17730105oab.44.1692874166902; Thu, 24
 Aug 2023 03:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230823212309.1463769-1-Naresh.Solanki@9elements.com> <CALNFmy0H2pg_hJvvNPrq7XkqUS2rDbMnpfFMEC4jOG-Ghhj3zQ@mail.gmail.com>
In-Reply-To: <CALNFmy0H2pg_hJvvNPrq7XkqUS2rDbMnpfFMEC4jOG-Ghhj3zQ@mail.gmail.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 24 Aug 2023 16:19:17 +0530
Message-ID: <CABqG17hh2h=1ASBohyzrw2PWfkGDcSRcCWEcRWsBNigL6SHpiw@mail.gmail.com>
Subject: Re: [PATCH] leds: max5970: Add support for max5970
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi

On Thu, 24 Aug 2023 at 15:29, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Wed, Aug 23, 2023 at 11:23=E2=80=AFPM Naresh Solanki
> <naresh.solanki@9elements.com> wrote:
> >
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The MAX5970 is hot swap controller and has 4 indication LED.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >  drivers/leds/Kconfig        |  11 +++
> >  drivers/leds/Makefile       |   1 +
> >  drivers/leds/leds-max5970.c | 129 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 141 insertions(+)
> >  create mode 100644 drivers/leds/leds-max5970.c
> >
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index b92208eccdea..03ef527cc545 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> >           To compile this driver as a module, choose M here: the module=
 will
> >           be called leds-adp5520.
> >
> > +config LEDS_MAX5970
> > +       tristate "LED Support for Maxim 5970"
> > +       depends on LEDS_CLASS
> > +       depends on MFD_MAX5970
> > +       help
> > +         This option enables support for the Maxim MAX5970 & MAX5978 s=
mart
> > +         switch indication LEDs via the I2C bus.
> > +
> > +         To compile this driver as a module, choose M here: the module=
 will
> > +         be called leds-max5970.
> > +
> >  config LEDS_MC13783
> >         tristate "LED Support for MC13XXX PMIC"
> >         depends on LEDS_CLASS
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index d7348e8bc019..6eaee0a753c6 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)             +=3D leds-lp850=
1.o
> >  obj-$(CONFIG_LEDS_LP8788)              +=3D leds-lp8788.o
> >  obj-$(CONFIG_LEDS_LP8860)              +=3D leds-lp8860.o
> >  obj-$(CONFIG_LEDS_LT3593)              +=3D leds-lt3593.o
> > +obj-$(CONFIG_LEDS_MAX5970)             +=3D leds-max5970.o
> >  obj-$(CONFIG_LEDS_MAX77650)            +=3D leds-max77650.o
> >  obj-$(CONFIG_LEDS_MAX8997)             +=3D leds-max8997.o
> >  obj-$(CONFIG_LEDS_MC13783)             +=3D leds-mc13783.o
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
> > +       struct device *dev;
> > +       struct regmap *regmap;
> > +       struct led_classdev cdev;
> > +       unsigned int index;
> > +};
> > +
> > +static int max5970_led_set_brightness(struct led_classdev *cdev,
> > +                                     enum led_brightness brightness)
> > +{
> > +       struct max5970_led *ddata =3D ldev_to_maxled(cdev);
> > +       int ret, val;
> > +
> > +       if (!ddata->regmap)
> > +               return -ENODEV;
> Can this ever happen? Looks like this conditions is always false.
Yes. Will be removed in the next revision.
>
> > +
> > +       /* Set/clear corresponding bit for given led index */
> > +       val =3D !brightness ? BIT(ddata->index) : 0;
> > +
> > +       ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH=
, BIT(ddata->index), val);
> > +       if (ret < 0)
> > +               dev_err(cdev->dev, "failed to set brightness %d", ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static int max5970_setup_led(struct max5970_led *ddata, struct regmap =
*regmap,
> > +                            struct device_node *nc, u32 reg)
> > +{
> regmap and reg is not used within this function.
> I don't see the need for this function, just add those 8 lines in the
> loop below.
Ack.
>
> > +       int ret;
> > +
> > +       if (of_property_read_string(nc, "label", &ddata->cdev.name))
> > +               ddata->cdev.name =3D nc->name;
> > +
> > +       ddata->cdev.max_brightness =3D 1;
> > +       ddata->cdev.brightness_set_blocking =3D max5970_led_set_brightn=
ess;
> > +       ddata->cdev.default_trigger =3D "none";
> > +
> > +       ret =3D devm_led_classdev_register(ddata->dev, &ddata->cdev);
> > +       if (ret)
> > +               dev_err(ddata->dev, "Error initializing LED %s", ddata-=
>cdev.name);
> > +
> > +       return ret;
> > +}
> > +
> > +static int max5970_led_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct device_node *np =3D dev_of_node(dev->parent);
> > +       struct regmap *regmap;
> > +       struct device_node *led_node;
> > +       struct device_node *child;
> > +       struct max5970_led *ddata[MAX5970_NUM_LEDS];
> > +       int ret =3D -ENODEV, num_leds =3D 0;
> > +
> > +       regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +       if (!regmap)
> > +               return -EPROBE_DEFER;
> > +
> > +       led_node =3D of_get_child_by_name(np, "leds");
> > +       if (!led_node)
> > +               return -ENODEV;
> > +
> > +       for_each_available_child_of_node(led_node, child) {
> > +               u32 reg;
> > +
> > +               if (of_property_read_u32(child, "reg", &reg))
> > +                       continue;
> > +
> > +               if (reg >=3D MAX5970_NUM_LEDS) {
> > +                       dev_err(dev, "invalid LED (%u >=3D %d)\n", reg,=
 MAX5970_NUM_LEDS);
> > +                       continue;
> > +               }
> > +
> > +               ddata[num_leds] =3D devm_kzalloc(dev, sizeof(struct max=
5970_led), GFP_KERNEL);
> > +               if (!ddata[num_leds]) {
> > +                       ret =3D -ENOMEM;
> > +                       goto exit;
> > +               }
> > +
> > +               ddata[num_leds]->index =3D reg;
> > +               ddata[num_leds]->regmap =3D regmap;
> > +               ddata[num_leds]->dev =3D dev;
> > +
> > +               ret =3D max5970_setup_led(ddata[num_leds], regmap, chil=
d, reg);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "Failed to initialize LED %u\n", r=
eg);
> > +                       goto exit;
> > +               }
> > +               num_leds++;
> > +       }
> > +
> > +       return ret;
> > +
> > +exit:
> > +       for (int j =3D 0; j < num_leds; j++)
> > +               devm_led_classdev_unregister(dev, &ddata[j]->cdev);
> > +
> > +       return ret;
> > +}
> > +
> > +static struct platform_driver max5970_led_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "max5970-led",
> > +       },
> > +       .probe =3D max5970_led_probe,
> > +};
> > +
> > +module_platform_driver(max5970_led_driver);
> > +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>
> You might want to put your name here, as you've rewritten the complete
> driver code.
ok.

Regards,
Naresh

>
> > +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
> > --
> > 2.41.0
> >
