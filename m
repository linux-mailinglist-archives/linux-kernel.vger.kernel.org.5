Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F387AA224
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjIUVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjIUVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8EA9F6;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B298EC32796;
        Thu, 21 Sep 2023 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695292320;
        bh=OLrFUB5wiXsqIStG7DXtPfN52moqtzYBsJLLAwsWXrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r70wz/HAzz20k6nRyeZwyRgQCIcBb4ApB/rTFJoGoE1SiNqWL2DCq6Ep8ZxkUIVtY
         FhpZ5OvZGtj5oUljHyNZwb9A7wdLFv+xA0wapr4l95PkwfQ+7IdV/gwfyKMw+kMJA9
         JZnCq0OcSj0fPEP3WDywLG1O4yodu+oDW/S8StUePF+n2dqnj1MchoYk2RamzE5vd1
         yiuQjkiNmdU8S4Zm0sTuu9D64t5+na9Eeam8Dpn5/2wPFKZ1JGqsMT+2/UjzF+lW96
         HhUtodx6snAMLBWjlIm2fi0i7rWzWnsMjQ3XdVZoGy55BFs/J9J3atIV3HG9mk4lmH
         Vz6+nW6f6tFJA==
Date:   Thu, 21 Sep 2023 11:31:56 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
Message-ID: <20230921103156.GB3449785@google.com>
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com>
 <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Naresh Solanki wrote:

> Hi
> 
> 
> On Wed, 20 Sept 2023 at 18:35, Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 14 Sep 2023, Naresh Solanki wrote:
> >
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > >
> > > The MAX5970 is hot swap controller and has 4 indication LED.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > > Changes in V3:
> > > - Drop array for ddata variable.
> > > Changes in V2:
> > > - Add of_node_put before return.
> > > - Code cleanup
> > > - Refactor code & remove max5970_setup_led function.
> > > ---
> > >  drivers/leds/Kconfig        |  11 ++++
> > >  drivers/leds/Makefile       |   1 +
> > >  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 122 insertions(+)
> > >  create mode 100644 drivers/leds/leds-max5970.c
> >
> > Couple of nits and you're good to go.
> >
> > Once fixed please resubmit with my:
> >
> >   Reviewed-by: Lee Jones <lee@kernel.org>
> >
> > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > index b92208eccdea..03ef527cc545 100644
> > > --- a/drivers/leds/Kconfig
> > > +++ b/drivers/leds/Kconfig
> > > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> > >         To compile this driver as a module, choose M here: the module will
> > >         be called leds-adp5520.
> > >
> > > +config LEDS_MAX5970
> > > +     tristate "LED Support for Maxim 5970"
> > > +     depends on LEDS_CLASS
> > > +     depends on MFD_MAX5970
> > > +     help
> > > +       This option enables support for the Maxim MAX5970 & MAX5978 smart
> > > +       switch indication LEDs via the I2C bus.
> > > +
> > > +       To compile this driver as a module, choose M here: the module will
> > > +       be called leds-max5970.
> > > +
> > >  config LEDS_MC13783
> > >       tristate "LED Support for MC13XXX PMIC"
> > >       depends on LEDS_CLASS
> > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > index d7348e8bc019..6eaee0a753c6 100644
> > > --- a/drivers/leds/Makefile
> > > +++ b/drivers/leds/Makefile
> > > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           += leds-lp8501.o
> > >  obj-$(CONFIG_LEDS_LP8788)            += leds-lp8788.o
> > >  obj-$(CONFIG_LEDS_LP8860)            += leds-lp8860.o
> > >  obj-$(CONFIG_LEDS_LT3593)            += leds-lt3593.o
> > > +obj-$(CONFIG_LEDS_MAX5970)           += leds-max5970.o
> > >  obj-$(CONFIG_LEDS_MAX77650)          += leds-max77650.o
> > >  obj-$(CONFIG_LEDS_MAX8997)           += leds-max8997.o
> > >  obj-$(CONFIG_LEDS_MC13783)           += leds-mc13783.o
> > > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> > > new file mode 100644
> > > index 000000000000..c9685990e26e
> > > --- /dev/null
> > > +++ b/drivers/leds/leds-max5970.c
> > > @@ -0,0 +1,110 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Device driver for leds in MAX5970 and MAX5978 IC
> > > + *
> > > + * Copyright (c) 2022 9elements GmbH
> > > + *
> > > + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > + */
> > > +
> > > +#include <linux/leds.h>
> > > +#include <linux/mfd/max5970.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev)
> > > +
> > > +struct max5970_led {
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct led_classdev cdev;
> > > +     unsigned int index;
> > > +};
> > > +
> > > +static int max5970_led_set_brightness(struct led_classdev *cdev,
> > > +                                   enum led_brightness brightness)
> > > +{
> > > +     struct max5970_led *ddata = ldev_to_maxled(cdev);
> > > +     int ret, val;
> > > +
> > > +     /* Set/clear corresponding bit for given led index */
> > > +     val = !brightness ? BIT(ddata->index) : 0;
> > > +
> > > +     ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
> > > +     if (ret < 0)
> > > +             dev_err(cdev->dev, "failed to set brightness %d", ret);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int max5970_led_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct device_node *np = dev_of_node(dev->parent);
> > > +     struct regmap *regmap;
> > > +     struct device_node *led_node;
> > > +     struct device_node *child;
> >
> > Nit: You can place these on the same line.
> Ack
> >
> > > +     struct max5970_led *ddata;
> > > +     int ret = -ENODEV, num_leds = 0;
> > > +
> > > +     regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > +     if (!regmap)
> > > +             return -EPROBE_DEFER;
> >
> > Why are you deferring here?
> This is a Leaf driver. Making sure the parent driver has initialized regmap.

How can this driver initialise before the parent driver?

-- 
Lee Jones [李琼斯]
