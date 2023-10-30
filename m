Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D97DB57E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjJ3Iwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjJ3Iwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:52:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930094
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:52:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ce2988d62eso2901787a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698655966; x=1699260766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gGEIDhDBnU4aFsLJZ/wB4B4cvrIyCziYnLzBrIhyCw=;
        b=gXSErqR56A9c04DfaXIff9X5zWSeLtJKh9GuhiQ8TGt4is8ZI06IExJ3TvlP0oLDaP
         IJx4Kozqefw4Q445EUqVCillLqRs+n4gFcvQ0DGZtQeVlDKo8zl0yQi6BcWjkfpRMNWJ
         LLylGhyzutTGacK2VcRC+f5f8jwYOxibKp/RlVLdQ4KWo+iblWpy3ZPoasOAfVBd6J+a
         QzSUmgLgwL9peoDVXytGC55u9C9XULeXMRoU5MuB2/qBjZC4HkCiCyCvAkpldfLYmrZ0
         4NBl20n5u1L5+ZHYJm+fP9F+ntNotYWJCKoTo4IVv9BjxECQPL8yK357lMArJvsIw4q/
         dOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698655966; x=1699260766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gGEIDhDBnU4aFsLJZ/wB4B4cvrIyCziYnLzBrIhyCw=;
        b=c+s9GYXZo/RcWwhwpO/hCtIc66yk+eBN76nd9W7HPZOC1+zXmEhEBWeKIJlRn7qCY+
         ZyW1RTIZDi15OK0R1iYqOX1IBK3Pa78fxXq7aGjN2HNe0i/nc/x9avJTJ4xgbU4zNp0L
         g+LifTZVdcdvoItQEvu9Sn4ddgMtcodR9kF2IrZol0yFN2IiHaiWlW2HrKC4yceCqz17
         C7p8O/jC2Kt38eGn3xdzVTUFc77dtL79U4QuEbBcT2JAMEbwYw/KxrDSa6xbyajn0DyY
         f8kB2+83ic82Swqo0UlpgoFMi64/+BTvXlwQ/gsi/gZFeGEKhNQ44P+u/Lze+EONj50q
         JCvQ==
X-Gm-Message-State: AOJu0YzYjVrdA/CsmHljJ/u31M3UFCKAATTd4n33RgDsxj2YeQ415zdL
        Sc0VYceOj56zJzkzVt0vGX2D98Hzqf30OSpsYC0pNQ==
X-Google-Smtp-Source: AGHT+IHkR2THCj1FlipypbHdlgpkGFKhoiGmQpUIe9vWSJhv+2mHRfkz1ZHtE/ji28hfpcYLDEBXn8gv7HQRPYtb3Xg=
X-Received: by 2002:a05:6808:1907:b0:3ad:c5f2:2792 with SMTP id
 bf7-20020a056808190700b003adc5f22792mr15368637oib.46.1698655966526; Mon, 30
 Oct 2023 01:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com> <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com>
In-Reply-To: <20230921103156.GB3449785@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Mon, 30 Oct 2023 14:22:35 +0530
Message-ID: <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
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

Hi,

On Thu, 21 Sept 2023 at 16:02, Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 21 Sep 2023, Naresh Solanki wrote:
>
> > Hi
> >
> >
> > On Wed, 20 Sept 2023 at 18:35, Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Thu, 14 Sep 2023, Naresh Solanki wrote:
> > >
> > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > >
> > > > The MAX5970 is hot swap controller and has 4 indication LED.
> > > >
> > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > ---
> > > > Changes in V3:
> > > > - Drop array for ddata variable.
> > > > Changes in V2:
> > > > - Add of_node_put before return.
> > > > - Code cleanup
> > > > - Refactor code & remove max5970_setup_led function.
> > > > ---
> > > >  drivers/leds/Kconfig        |  11 ++++
> > > >  drivers/leds/Makefile       |   1 +
> > > >  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 122 insertions(+)
> > > >  create mode 100644 drivers/leds/leds-max5970.c
> > >
> > > Couple of nits and you're good to go.
> > >
> > > Once fixed please resubmit with my:
> > >
> > >   Reviewed-by: Lee Jones <lee@kernel.org>
> > >
> > > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > > index b92208eccdea..03ef527cc545 100644
> > > > --- a/drivers/leds/Kconfig
> > > > +++ b/drivers/leds/Kconfig
> > > > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> > > >         To compile this driver as a module, choose M here: the modu=
le will
> > > >         be called leds-adp5520.
> > > >
> > > > +config LEDS_MAX5970
> > > > +     tristate "LED Support for Maxim 5970"
> > > > +     depends on LEDS_CLASS
> > > > +     depends on MFD_MAX5970
> > > > +     help
> > > > +       This option enables support for the Maxim MAX5970 & MAX5978=
 smart
> > > > +       switch indication LEDs via the I2C bus.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the modu=
le will
> > > > +       be called leds-max5970.
> > > > +
> > > >  config LEDS_MC13783
> > > >       tristate "LED Support for MC13XXX PMIC"
> > > >       depends on LEDS_CLASS
> > > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > > index d7348e8bc019..6eaee0a753c6 100644
> > > > --- a/drivers/leds/Makefile
> > > > +++ b/drivers/leds/Makefile
> > > > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           +=3D leds-lp8=
501.o
> > > >  obj-$(CONFIG_LEDS_LP8788)            +=3D leds-lp8788.o
> > > >  obj-$(CONFIG_LEDS_LP8860)            +=3D leds-lp8860.o
> > > >  obj-$(CONFIG_LEDS_LT3593)            +=3D leds-lt3593.o
> > > > +obj-$(CONFIG_LEDS_MAX5970)           +=3D leds-max5970.o
> > > >  obj-$(CONFIG_LEDS_MAX77650)          +=3D leds-max77650.o
> > > >  obj-$(CONFIG_LEDS_MAX8997)           +=3D leds-max8997.o
> > > >  obj-$(CONFIG_LEDS_MC13783)           +=3D leds-mc13783.o
> > > > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max597=
0.c
> > > > new file mode 100644
> > > > index 000000000000..c9685990e26e
> > > > --- /dev/null
> > > > +++ b/drivers/leds/leds-max5970.c
> > > > @@ -0,0 +1,110 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Device driver for leds in MAX5970 and MAX5978 IC
> > > > + *
> > > > + * Copyright (c) 2022 9elements GmbH
> > > > + *
> > > > + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > + */
> > > > +
> > > > +#include <linux/leds.h>
> > > > +#include <linux/mfd/max5970.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#define ldev_to_maxled(c)       container_of(c, struct max5970_led=
, cdev)
> > > > +
> > > > +struct max5970_led {
> > > > +     struct device *dev;
> > > > +     struct regmap *regmap;
> > > > +     struct led_classdev cdev;
> > > > +     unsigned int index;
> > > > +};
> > > > +
> > > > +static int max5970_led_set_brightness(struct led_classdev *cdev,
> > > > +                                   enum led_brightness brightness)
> > > > +{
> > > > +     struct max5970_led *ddata =3D ldev_to_maxled(cdev);
> > > > +     int ret, val;
> > > > +
> > > > +     /* Set/clear corresponding bit for given led index */
> > > > +     val =3D !brightness ? BIT(ddata->index) : 0;
> > > > +
> > > > +     ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLA=
SH, BIT(ddata->index), val);
> > > > +     if (ret < 0)
> > > > +             dev_err(cdev->dev, "failed to set brightness %d", ret=
);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int max5970_led_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     struct device_node *np =3D dev_of_node(dev->parent);
> > > > +     struct regmap *regmap;
> > > > +     struct device_node *led_node;
> > > > +     struct device_node *child;
> > >
> > > Nit: You can place these on the same line.
> > Ack
> > >
> > > > +     struct max5970_led *ddata;
> > > > +     int ret =3D -ENODEV, num_leds =3D 0;
> > > > +
> > > > +     regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > > +     if (!regmap)
> > > > +             return -EPROBE_DEFER;
> > >
> > > Why are you deferring here?
> > This is a Leaf driver. Making sure the parent driver has initialized re=
gmap.
>
> How can this driver initialise before the parent driver?
The parent driver in this case is simple_i2c_mfd.
Based on reference from other similar implementations, the regmap
check was adapted.
As you mentioned, your right that leaf driver will not start before parent
driver is loaded successfully so probably the DEFER might not be needed
here.

Thanks,
Naresh
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
