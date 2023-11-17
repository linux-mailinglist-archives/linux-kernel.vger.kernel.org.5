Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004917EF272
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345921AbjKQMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:15:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96014196
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:15:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F63C433C8;
        Fri, 17 Nov 2023 12:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700223336;
        bh=gus7ga/hslqFc90wOge8RCSDecxTYpVkhWQk6MjClOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGz6trMKWPqu5saBtofRgNGtLC6NRcKmuuEr9LV/K064zWRQmHi9RqbD1WgdZxrtw
         VN75+bY+DS3/N/kdzxGRyhgscaTY0+HdWn8dkJsp/Hy/0vMHGAkze2MxXfnZYv7yyz
         sbsXiZMtT42LgQnqC/0aDuLgrNcI6ttN6Vk0h4vULd777XyMMp/4XZP0u2bnq7NPES
         RNVTbiXambLxkiPDQiuyKENApFT9oDbOouUTgW7keYLBeIagU/kRktU9XKS+XJV3NM
         e9y7XFjnNi8i5/tRtt82HkNh2MFohkS8baYgpY050UuleOonHmrZOKdoxXyuE76SVo
         m0/Q+uT+rF/Sg==
Date:   Fri, 17 Nov 2023 12:15:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
Message-ID: <20231117121531.GC137434@google.com>
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com>
 <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com>
 <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
 <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023, Naresh Solanki wrote:

> Hey Lee,
> 
> Is there anything specific you'd suggest changing in the current
> patchset, or are we good to proceed?

What do you mean by proceed?

You are good to make changes and submit a subsequent version.

Not entirely sure what you're asking.

> On Mon, 30 Oct 2023 at 14:22, Naresh Solanki
> <naresh.solanki@9elements.com> wrote:
> >
> > Hi,
> >
> > On Thu, 21 Sept 2023 at 16:02, Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Thu, 21 Sep 2023, Naresh Solanki wrote:
> > >
> > > > Hi
> > > >
> > > >
> > > > On Wed, 20 Sept 2023 at 18:35, Lee Jones <lee@kernel.org> wrote:
> > > > >
> > > > > On Thu, 14 Sep 2023, Naresh Solanki wrote:
> > > > >
> > > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > >
> > > > > > The MAX5970 is hot swap controller and has 4 indication LED.
> > > > > >
> > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > > ---
> > > > > > Changes in V3:
> > > > > > - Drop array for ddata variable.
> > > > > > Changes in V2:
> > > > > > - Add of_node_put before return.
> > > > > > - Code cleanup
> > > > > > - Refactor code & remove max5970_setup_led function.
> > > > > > ---
> > > > > >  drivers/leds/Kconfig        |  11 ++++
> > > > > >  drivers/leds/Makefile       |   1 +
> > > > > >  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 122 insertions(+)
> > > > > >  create mode 100644 drivers/leds/leds-max5970.c
> > > > >
> > > > > Couple of nits and you're good to go.
> > > > >
> > > > > Once fixed please resubmit with my:
> > > > >
> > > > >   Reviewed-by: Lee Jones <lee@kernel.org>
> > > > >
> > > > > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > > > > index b92208eccdea..03ef527cc545 100644
> > > > > > --- a/drivers/leds/Kconfig
> > > > > > +++ b/drivers/leds/Kconfig
> > > > > > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> > > > > >         To compile this driver as a module, choose M here: the module will
> > > > > >         be called leds-adp5520.
> > > > > >
> > > > > > +config LEDS_MAX5970
> > > > > > +     tristate "LED Support for Maxim 5970"
> > > > > > +     depends on LEDS_CLASS
> > > > > > +     depends on MFD_MAX5970
> > > > > > +     help
> > > > > > +       This option enables support for the Maxim MAX5970 & MAX5978 smart
> > > > > > +       switch indication LEDs via the I2C bus.
> > > > > > +
> > > > > > +       To compile this driver as a module, choose M here: the module will
> > > > > > +       be called leds-max5970.
> > > > > > +
> > > > > >  config LEDS_MC13783
> > > > > >       tristate "LED Support for MC13XXX PMIC"
> > > > > >       depends on LEDS_CLASS
> > > > > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > > > > index d7348e8bc019..6eaee0a753c6 100644
> > > > > > --- a/drivers/leds/Makefile
> > > > > > +++ b/drivers/leds/Makefile
> > > > > > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           += leds-lp8501.o
> > > > > >  obj-$(CONFIG_LEDS_LP8788)            += leds-lp8788.o
> > > > > >  obj-$(CONFIG_LEDS_LP8860)            += leds-lp8860.o
> > > > > >  obj-$(CONFIG_LEDS_LT3593)            += leds-lt3593.o
> > > > > > +obj-$(CONFIG_LEDS_MAX5970)           += leds-max5970.o
> > > > > >  obj-$(CONFIG_LEDS_MAX77650)          += leds-max77650.o
> > > > > >  obj-$(CONFIG_LEDS_MAX8997)           += leds-max8997.o
> > > > > >  obj-$(CONFIG_LEDS_MC13783)           += leds-mc13783.o
> > > > > > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..c9685990e26e
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/leds/leds-max5970.c
> > > > > > @@ -0,0 +1,110 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Device driver for leds in MAX5970 and MAX5978 IC
> > > > > > + *
> > > > > > + * Copyright (c) 2022 9elements GmbH
> > > > > > + *
> > > > > > + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/leds.h>
> > > > > > +#include <linux/mfd/max5970.h>
> > > > > > +#include <linux/of.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/regmap.h>
> > > > > > +
> > > > > > +#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev)
> > > > > > +
> > > > > > +struct max5970_led {
> > > > > > +     struct device *dev;
> > > > > > +     struct regmap *regmap;
> > > > > > +     struct led_classdev cdev;
> > > > > > +     unsigned int index;
> > > > > > +};
> > > > > > +
> > > > > > +static int max5970_led_set_brightness(struct led_classdev *cdev,
> > > > > > +                                   enum led_brightness brightness)
> > > > > > +{
> > > > > > +     struct max5970_led *ddata = ldev_to_maxled(cdev);
> > > > > > +     int ret, val;
> > > > > > +
> > > > > > +     /* Set/clear corresponding bit for given led index */
> > > > > > +     val = !brightness ? BIT(ddata->index) : 0;
> > > > > > +
> > > > > > +     ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
> > > > > > +     if (ret < 0)
> > > > > > +             dev_err(cdev->dev, "failed to set brightness %d", ret);
> > > > > > +
> > > > > > +     return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static int max5970_led_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +     struct device *dev = &pdev->dev;
> > > > > > +     struct device_node *np = dev_of_node(dev->parent);
> > > > > > +     struct regmap *regmap;
> > > > > > +     struct device_node *led_node;
> > > > > > +     struct device_node *child;
> > > > >
> > > > > Nit: You can place these on the same line.
> > > > Ack
> > > > >
> > > > > > +     struct max5970_led *ddata;
> > > > > > +     int ret = -ENODEV, num_leds = 0;
> > > > > > +
> > > > > > +     regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > > > > +     if (!regmap)
> > > > > > +             return -EPROBE_DEFER;
> > > > >
> > > > > Why are you deferring here?
> > > > This is a Leaf driver. Making sure the parent driver has initialized regmap.
> > >
> > > How can this driver initialise before the parent driver?
> > The parent driver in this case is simple_i2c_mfd.
> > Based on reference from other similar implementations, the regmap
> > check was adapted.
> > As you mentioned, your right that leaf driver will not start before parent
> > driver is loaded successfully so probably the DEFER might not be needed
> > here.
> >
> > Thanks,
> > Naresh
> > >
> > > --
> > > Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]
