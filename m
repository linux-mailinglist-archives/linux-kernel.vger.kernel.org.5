Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085C786D82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjHXLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbjHXLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:13:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC681711
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:13:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so579518a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692875631; x=1693480431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL/OJZ7bFPkMx7832SWkO9NqAygqNUZeT8FiHC4CYOE=;
        b=SbmCVWBNTVFBievObE4GuBsBm73Ze97x0nkp788sY8H0Q8qUAEGdEovifrYcGVzrYb
         nAf5bvnlA1HE4xRelR0iFSI9JWLyNIWuvHwlbvFRIaU6InGCL7QZjoDxpFALSCi4m5TQ
         Yt6uRYyntEP8HpcF5AiRPXcRn8JNLfl554pGL+x4HbvzmeQnKZJatm/Mz79gLdxjj6DY
         s3sk5+4As9NuXvOFXYb98BSCs4tjp651cfugi1kUEUEHwWVm8aLk2hjSmtCaxbAK4mdR
         O+2WWGWR5NYnuBjKpnjgjGd2hhzgpE1J2KmMi8mxmLakgeq3CEHB8gHKfdOqAgDkY7+w
         qv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875631; x=1693480431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL/OJZ7bFPkMx7832SWkO9NqAygqNUZeT8FiHC4CYOE=;
        b=WYaSPvoN8ls7bEkQZSYSCO3maNHcxLPqNc0mW7MQ48wpUOONqv8Hf75Keo4uA+JsPe
         Xu1AfA6uyXJx1yN7BpzpogypoiVhjSE1aWQ3Qqx5uQFeVrfcSogscODeKhYJIeU0CqtJ
         tSwh3AZPrG8ezH8cvRkeXhGK94e43QflZ+M8OToeOvJWFLM5B+ig/ROZLsubki+G/O+r
         4q7+hAR0BHLjQGKH+rLGamLRVSGUvhukVsGqBn9/6VtimgOyL2londPSEpdNHZuqSXZv
         iM8B9hDJIhzdMJ96uWet0DBg67R+MA5ahy546RyFrvvWPcWLnlAqkAySt/uCBBy/tB85
         g4gA==
X-Gm-Message-State: AOJu0YzwOAd6Ty7oIZwf3Htr6hbxjS5Lc7RNElfX6P+UmgMY/8MsOEKL
        VeEFfnjzYS7fVe6ZZo870C3POyT7Lci/36+IERZEvg==
X-Google-Smtp-Source: AGHT+IFyfV4RjFSVmeLvI+XQbuK7YVVeY8AKlFpuFx3Sq2BqIJ2gHJexE4Gy3432EYx891MWXrh/H50ehkG+m7QU+DA=
X-Received: by 2002:a17:90a:c08e:b0:26d:49a0:2071 with SMTP id
 o14-20020a17090ac08e00b0026d49a02071mr23137391pjs.13.1692875631400; Thu, 24
 Aug 2023 04:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230824104909.2451625-1-Naresh.Solanki@9elements.com> <CALNFmy0TxrrH1G-QZmZDLumP22kZr5PE-fE4JDU6yRo96p89xw@mail.gmail.com>
In-Reply-To: <CALNFmy0TxrrH1G-QZmZDLumP22kZr5PE-fE4JDU6yRo96p89xw@mail.gmail.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 24 Aug 2023 16:43:41 +0530
Message-ID: <CABqG17jEgdTbROCbS2PMM0zNXLPGkexC_X=M5HiJw3772=WSgQ@mail.gmail.com>
Subject: Re: [PATCH v2] leds: max5970: Add support for max5970
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Aug 2023 at 16:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Thu, Aug 24, 2023 at 12:49=E2=80=AFPM Naresh Solanki
> <naresh.solanki@9elements.com> wrote:
> >
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The MAX5970 is hot swap controller and has 4 indication LED.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
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
> > index 000000000000..79277d47e1bc
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
> > +                       of_node_put(child);
> > +                       return -ENOMEM;
> > +               }
> This overflows if more than MAX5970_NUM_LEDS child nodes are present
> in the node.
> Better drop the array as you don't use it any more.
Ack. Will update in V3.
>
> > +
> > +               ddata[num_leds]->index =3D reg;
> > +               ddata[num_leds]->regmap =3D regmap;
> > +               ddata[num_leds]->dev =3D dev;
> > +
> > +               if (of_property_read_string(child, "label", &ddata[num_=
leds]->cdev.name))
> > +                       ddata[num_leds]->cdev.name =3D child->name;
> > +
> > +               ddata[num_leds]->cdev.max_brightness =3D 1;
> > +               ddata[num_leds]->cdev.brightness_set_blocking =3D max59=
70_led_set_brightness;
> > +               ddata[num_leds]->cdev.default_trigger =3D "none";
> > +
> > +               ret =3D devm_led_classdev_register(ddata[num_leds]->dev=
, &ddata[num_leds]->cdev);
> > +               if (ret < 0) {
> > +                       of_node_put(child);
> > +                       dev_err(dev, "Failed to initialize LED %u\n", r=
eg);
> > +                       return ret;
> > +               }
> > +               num_leds++;
> > +       }
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
> > +MODULE_AUTHOR("Naresh Solanki <Naresh.Solanki@9elements.com>");
> > +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
> > --
> > 2.41.0
> >
