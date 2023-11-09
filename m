Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5F7E671C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjKIJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKIJun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:50:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729852D49
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:50:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so571255a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1699523441; x=1700128241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOVetaQKamOc5YiV+kDh/Gfy/FprSlSW2sob1kkaLyE=;
        b=A4FfurahnRW3fw3/zC7NH9hL6PbIGWcb49XwM7QstmiCFJgVL2NJoPuTzHmXnI2dmx
         hUHB3xXdU2yImniWyfrQc6RHcHJ54IStcb+9ssRCZaBK4XoCDIBgC281ZP6/EHtn6GgI
         6FI4DBpEbY+8jfoFz4i/P7Ai+ODBD+4c+hqh0KXy7CokUydXwiVZkdgFo8GBxC6arnzh
         cfvgj8H8S2sN1aECBeK2fL0ewh/OfuAst6D7lPm7UQ0PS3wIvHJb5Z/wSkfEpcx0PAxT
         JlgLpBrK6JFgk2rS9+z6KcX4xu/8lyNKhF7xV6iDerLic9/fHqj9T9Z1z/sZ8Hb+xD9r
         +hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699523441; x=1700128241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOVetaQKamOc5YiV+kDh/Gfy/FprSlSW2sob1kkaLyE=;
        b=NZANSESK5lkMOsjOeOEgrlhcjxZ9tRhko6B0B1qJ7Bsrc3lQwPX2RYGmnKcQGAh5bC
         MtWJQrFwOa/QU2pMruoRed77SAI4Cm9sX2XerfDzm1Rb4MdUmgt//LU2n9YKvn39Yx7I
         6TsJh9B1Jq4Fh1EPk+Tm5MlyTUDfkLKwpTnzIiDTKtoTDJBqHNp67nkVy84zXdpNZ9o7
         2Wu2d2RBR1Y1eiFO5ryWBAjPr3ZqrByyrkaBE3vL0nmd6bvTIFiUPB4+wn1sVMh2iNKJ
         v27OQeBT1N3/Zn7yksQjf/91bAUOw4BauP4Eq/hQwO72DwszORG5meQkDYgg7r4gQ0sM
         Hu1g==
X-Gm-Message-State: AOJu0YyV8ldE0RAoKHdtswwxyZKYWBxCcL9PjuPLqdj0S8Jc9gR9yhtI
        OVIYu4x3Ue+ULt83DMW3cPRJo9g2iT7Y/E8JR5/c+w==
X-Google-Smtp-Source: AGHT+IFyIqsTZ6z28Zr+jIjT+jv08XPl2Lyls6kYJxYL7+NJuDzi3vH6dv5Mu4O85+wE0yd4+9twA+gX0u1r2+nOMuA=
X-Received: by 2002:a05:6a21:4847:b0:180:def9:20e1 with SMTP id
 au7-20020a056a21484700b00180def920e1mr5054946pzc.22.1699523440819; Thu, 09
 Nov 2023 01:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com> <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com> <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
In-Reply-To: <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 9 Nov 2023 15:20:29 +0530
Message-ID: <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lee,

Is there anything specific you'd suggest changing in the current
patchset, or are we good to proceed?

Thanks,
Naresh Solanki

On Mon, 30 Oct 2023 at 14:22, Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> Hi,
>
> On Thu, 21 Sept 2023 at 16:02, Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 21 Sep 2023, Naresh Solanki wrote:
> >
> > > Hi
> > >
> > >
> > > On Wed, 20 Sept 2023 at 18:35, Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Thu, 14 Sep 2023, Naresh Solanki wrote:
> > > >
> > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > >
> > > > > The MAX5970 is hot swap controller and has 4 indication LED.
> > > > >
> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > ---
> > > > > Changes in V3:
> > > > > - Drop array for ddata variable.
> > > > > Changes in V2:
> > > > > - Add of_node_put before return.
> > > > > - Code cleanup
> > > > > - Refactor code & remove max5970_setup_led function.
> > > > > ---
> > > > >  drivers/leds/Kconfig        |  11 ++++
> > > > >  drivers/leds/Makefile       |   1 +
> > > > >  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++=
++++++
> > > > >  3 files changed, 122 insertions(+)
> > > > >  create mode 100644 drivers/leds/leds-max5970.c
> > > >
> > > > Couple of nits and you're good to go.
> > > >
> > > > Once fixed please resubmit with my:
> > > >
> > > >   Reviewed-by: Lee Jones <lee@kernel.org>
> > > >
> > > > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > > > index b92208eccdea..03ef527cc545 100644
> > > > > --- a/drivers/leds/Kconfig
> > > > > +++ b/drivers/leds/Kconfig
> > > > > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> > > > >         To compile this driver as a module, choose M here: the mo=
dule will
> > > > >         be called leds-adp5520.
> > > > >
> > > > > +config LEDS_MAX5970
> > > > > +     tristate "LED Support for Maxim 5970"
> > > > > +     depends on LEDS_CLASS
> > > > > +     depends on MFD_MAX5970
> > > > > +     help
> > > > > +       This option enables support for the Maxim MAX5970 & MAX59=
78 smart
> > > > > +       switch indication LEDs via the I2C bus.
> > > > > +
> > > > > +       To compile this driver as a module, choose M here: the mo=
dule will
> > > > > +       be called leds-max5970.
> > > > > +
> > > > >  config LEDS_MC13783
> > > > >       tristate "LED Support for MC13XXX PMIC"
> > > > >       depends on LEDS_CLASS
> > > > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > > > index d7348e8bc019..6eaee0a753c6 100644
> > > > > --- a/drivers/leds/Makefile
> > > > > +++ b/drivers/leds/Makefile
> > > > > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           +=3D leds-l=
p8501.o
> > > > >  obj-$(CONFIG_LEDS_LP8788)            +=3D leds-lp8788.o
> > > > >  obj-$(CONFIG_LEDS_LP8860)            +=3D leds-lp8860.o
> > > > >  obj-$(CONFIG_LEDS_LT3593)            +=3D leds-lt3593.o
> > > > > +obj-$(CONFIG_LEDS_MAX5970)           +=3D leds-max5970.o
> > > > >  obj-$(CONFIG_LEDS_MAX77650)          +=3D leds-max77650.o
> > > > >  obj-$(CONFIG_LEDS_MAX8997)           +=3D leds-max8997.o
> > > > >  obj-$(CONFIG_LEDS_MC13783)           +=3D leds-mc13783.o
> > > > > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5=
970.c
> > > > > new file mode 100644
> > > > > index 000000000000..c9685990e26e
> > > > > --- /dev/null
> > > > > +++ b/drivers/leds/leds-max5970.c
> > > > > @@ -0,0 +1,110 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Device driver for leds in MAX5970 and MAX5978 IC
> > > > > + *
> > > > > + * Copyright (c) 2022 9elements GmbH
> > > > > + *
> > > > > + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/leds.h>
> > > > > +#include <linux/mfd/max5970.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +
> > > > > +#define ldev_to_maxled(c)       container_of(c, struct max5970_l=
ed, cdev)
> > > > > +
> > > > > +struct max5970_led {
> > > > > +     struct device *dev;
> > > > > +     struct regmap *regmap;
> > > > > +     struct led_classdev cdev;
> > > > > +     unsigned int index;
> > > > > +};
> > > > > +
> > > > > +static int max5970_led_set_brightness(struct led_classdev *cdev,
> > > > > +                                   enum led_brightness brightnes=
s)
> > > > > +{
> > > > > +     struct max5970_led *ddata =3D ldev_to_maxled(cdev);
> > > > > +     int ret, val;
> > > > > +
> > > > > +     /* Set/clear corresponding bit for given led index */
> > > > > +     val =3D !brightness ? BIT(ddata->index) : 0;
> > > > > +
> > > > > +     ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_LED_F=
LASH, BIT(ddata->index), val);
> > > > > +     if (ret < 0)
> > > > > +             dev_err(cdev->dev, "failed to set brightness %d", r=
et);
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static int max5970_led_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct device *dev =3D &pdev->dev;
> > > > > +     struct device_node *np =3D dev_of_node(dev->parent);
> > > > > +     struct regmap *regmap;
> > > > > +     struct device_node *led_node;
> > > > > +     struct device_node *child;
> > > >
> > > > Nit: You can place these on the same line.
> > > Ack
> > > >
> > > > > +     struct max5970_led *ddata;
> > > > > +     int ret =3D -ENODEV, num_leds =3D 0;
> > > > > +
> > > > > +     regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > > > +     if (!regmap)
> > > > > +             return -EPROBE_DEFER;
> > > >
> > > > Why are you deferring here?
> > > This is a Leaf driver. Making sure the parent driver has initialized =
regmap.
> >
> > How can this driver initialise before the parent driver?
> The parent driver in this case is simple_i2c_mfd.
> Based on reference from other similar implementations, the regmap
> check was adapted.
> As you mentioned, your right that leaf driver will not start before paren=
t
> driver is loaded successfully so probably the DEFER might not be needed
> here.
>
> Thanks,
> Naresh
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
