Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91B7F0FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjKTKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjKTKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:10:36 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC548F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:10:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b709048f32so3474027b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1700475031; x=1701079831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Seu1o2Xo+pRaMVFnMM1O4+VApdaL6kVUnHZgi0pkjmM=;
        b=QSUljVk3co3mVC/VrQxSh/8AOT6ORaDzJcMs1yq5Alf+o3Eo6XfVhFGV0eMSDH9Deo
         TK4qBKEFz3Z/NZGq/tuV1+5w3A0YH9qdUca+La+QifSmxscyu8KtWAKehHtcM1TeDG+o
         Hf6WRl+gWzs6UmptY2Wrj7+f7+SnvwYOThkdf3Tn4+YV7D+7qC7EXZUGY1JGDgEoBo4i
         6stVn8AsmWUDadnR+Gm39MVYW9NjutXCo0Ru+pxUcdHvBMPnj8uVlOCMUizWTe81agSM
         mjj+9rJ/58AaK5UHDt13sR95YGr8LnpXUs0ulRkWfhfiON5ge0lFopftQO/O43I1RxkY
         pxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475031; x=1701079831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Seu1o2Xo+pRaMVFnMM1O4+VApdaL6kVUnHZgi0pkjmM=;
        b=WxT/YfqlcyYWQ+JlyhEO2UAyWsagvxHCtJ5WtdRSzeiCh/faPwDHlbP4LbaRBDn5DS
         7oIdrscuhaC+KSy85pFywwtrR+U7jEnlga5gb2ZJ/jElz0VddJZ3JrXuYXRXOq0ER06p
         /882pCuR59Ov6IzyYSODtH4l7hK38Z6efrwaPCnwKvuG0S3/cKd99jZz4Aew9GiPdO/i
         ISw4TjWmIT0qijW4btg2lkEou9RvCZQIRZ3cZcglbT9sLmky8KlD85DWa+weJMBPvo/Z
         XdIOevDLj9e+En56x4HJxpLWFb/nhU7wgZLKui9l7NqiorirsH92an+X6yALtML0RmmX
         A8vQ==
X-Gm-Message-State: AOJu0Yx9SD7X6oUFpZF+dt89QusA7sHPi9wsM8C0i1r9EcXI/Pt4VKPj
        NaOS8qacgsGP4Mue9B47Fmsb1bEPpfnCmhjvtQPGNezq7/eX8jCL
X-Google-Smtp-Source: AGHT+IFaCvGw8mMI/q6u6KhIJxP5I/mp6P2D26YqW1ZCaoSgMmtEbSyC7A/1t+zZGMOZ460uT0/GMy15zKu9LdCXRQM=
X-Received: by 2002:a05:6a20:e107:b0:18a:181b:1439 with SMTP id
 kr7-20020a056a20e10700b0018a181b1439mr3416463pzb.6.1700475031578; Mon, 20 Nov
 2023 02:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com> <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com> <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
 <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com> <20231117121531.GC137434@google.com>
In-Reply-To: <20231117121531.GC137434@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Mon, 20 Nov 2023 15:40:21 +0530
Message-ID: <CABqG17hPnx465dRKdMdSd2s38_T6DQFn5hsx1SL0RtA+r4JFZQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 17 Nov 2023 at 17:45, Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 09 Nov 2023, Naresh Solanki wrote:
>
> > Hey Lee,
> >
> > Is there anything specific you'd suggest changing in the current
> > patchset, or are we good to proceed?
>
> What do you mean by proceed?
>
> You are good to make changes and submit a subsequent version.
>
> Not entirely sure what you're asking.

As a follow up on previous discussion regarding use of DEFER on probe
if regmap isn't initialized, the implementation was based on other similar
drivers & hence it was retained although its not needed due to dependencies=
.

I'm not entirely sure to keep the regmap check or make another
patch revision with regmap check removed ?


Regards,
Naresh
>
> > On Mon, 30 Oct 2023 at 14:22, Naresh Solanki
> > <naresh.solanki@9elements.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, 21 Sept 2023 at 16:02, Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Thu, 21 Sep 2023, Naresh Solanki wrote:
> > > >
> > > > > Hi
> > > > >
> > > > >
> > > > > On Wed, 20 Sept 2023 at 18:35, Lee Jones <lee@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 14 Sep 2023, Naresh Solanki wrote:
> > > > > >
> > > > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > >
> > > > > > > The MAX5970 is hot swap controller and has 4 indication LED.
> > > > > > >
> > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com=
>
> > > > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > > > ---
> > > > > > > Changes in V3:
> > > > > > > - Drop array for ddata variable.
> > > > > > > Changes in V2:
> > > > > > > - Add of_node_put before return.
> > > > > > > - Code cleanup
> > > > > > > - Refactor code & remove max5970_setup_led function.
> > > > > > > ---
> > > > > > >  drivers/leds/Kconfig        |  11 ++++
> > > > > > >  drivers/leds/Makefile       |   1 +
> > > > > > >  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++=
++++++++++
> > > > > > >  3 files changed, 122 insertions(+)
> > > > > > >  create mode 100644 drivers/leds/leds-max5970.c
> > > > > >
> > > > > > Couple of nits and you're good to go.
> > > > > >
> > > > > > Once fixed please resubmit with my:
> > > > > >
> > > > > >   Reviewed-by: Lee Jones <lee@kernel.org>
> > > > > >
> > > > > > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > > > > > index b92208eccdea..03ef527cc545 100644
> > > > > > > --- a/drivers/leds/Kconfig
> > > > > > > +++ b/drivers/leds/Kconfig
> > > > > > > @@ -637,6 +637,17 @@ config LEDS_ADP5520
> > > > > > >         To compile this driver as a module, choose M here: th=
e module will
> > > > > > >         be called leds-adp5520.
> > > > > > >
> > > > > > > +config LEDS_MAX5970
> > > > > > > +     tristate "LED Support for Maxim 5970"
> > > > > > > +     depends on LEDS_CLASS
> > > > > > > +     depends on MFD_MAX5970
> > > > > > > +     help
> > > > > > > +       This option enables support for the Maxim MAX5970 & M=
AX5978 smart
> > > > > > > +       switch indication LEDs via the I2C bus.
> > > > > > > +
> > > > > > > +       To compile this driver as a module, choose M here: th=
e module will
> > > > > > > +       be called leds-max5970.
> > > > > > > +
> > > > > > >  config LEDS_MC13783
> > > > > > >       tristate "LED Support for MC13XXX PMIC"
> > > > > > >       depends on LEDS_CLASS
> > > > > > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > > > > > index d7348e8bc019..6eaee0a753c6 100644
> > > > > > > --- a/drivers/leds/Makefile
> > > > > > > +++ b/drivers/leds/Makefile
> > > > > > > @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)           +=3D le=
ds-lp8501.o
> > > > > > >  obj-$(CONFIG_LEDS_LP8788)            +=3D leds-lp8788.o
> > > > > > >  obj-$(CONFIG_LEDS_LP8860)            +=3D leds-lp8860.o
> > > > > > >  obj-$(CONFIG_LEDS_LT3593)            +=3D leds-lt3593.o
> > > > > > > +obj-$(CONFIG_LEDS_MAX5970)           +=3D leds-max5970.o
> > > > > > >  obj-$(CONFIG_LEDS_MAX77650)          +=3D leds-max77650.o
> > > > > > >  obj-$(CONFIG_LEDS_MAX8997)           +=3D leds-max8997.o
> > > > > > >  obj-$(CONFIG_LEDS_MC13783)           +=3D leds-mc13783.o
> > > > > > > diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-=
max5970.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..c9685990e26e
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/leds/leds-max5970.c
> > > > > > > @@ -0,0 +1,110 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > +/*
> > > > > > > + * Device driver for leds in MAX5970 and MAX5978 IC
> > > > > > > + *
> > > > > > > + * Copyright (c) 2022 9elements GmbH
> > > > > > > + *
> > > > > > > + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/leds.h>
> > > > > > > +#include <linux/mfd/max5970.h>
> > > > > > > +#include <linux/of.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +#include <linux/regmap.h>
> > > > > > > +
> > > > > > > +#define ldev_to_maxled(c)       container_of(c, struct max59=
70_led, cdev)
> > > > > > > +
> > > > > > > +struct max5970_led {
> > > > > > > +     struct device *dev;
> > > > > > > +     struct regmap *regmap;
> > > > > > > +     struct led_classdev cdev;
> > > > > > > +     unsigned int index;
> > > > > > > +};
> > > > > > > +
> > > > > > > +static int max5970_led_set_brightness(struct led_classdev *c=
dev,
> > > > > > > +                                   enum led_brightness brigh=
tness)
> > > > > > > +{
> > > > > > > +     struct max5970_led *ddata =3D ldev_to_maxled(cdev);
> > > > > > > +     int ret, val;
> > > > > > > +
> > > > > > > +     /* Set/clear corresponding bit for given led index */
> > > > > > > +     val =3D !brightness ? BIT(ddata->index) : 0;
> > > > > > > +
> > > > > > > +     ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_L=
ED_FLASH, BIT(ddata->index), val);
> > > > > > > +     if (ret < 0)
> > > > > > > +             dev_err(cdev->dev, "failed to set brightness %d=
", ret);
> > > > > > > +
> > > > > > > +     return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int max5970_led_probe(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +     struct device *dev =3D &pdev->dev;
> > > > > > > +     struct device_node *np =3D dev_of_node(dev->parent);
> > > > > > > +     struct regmap *regmap;
> > > > > > > +     struct device_node *led_node;
> > > > > > > +     struct device_node *child;
> > > > > >
> > > > > > Nit: You can place these on the same line.
> > > > > Ack
> > > > > >
> > > > > > > +     struct max5970_led *ddata;
> > > > > > > +     int ret =3D -ENODEV, num_leds =3D 0;
> > > > > > > +
> > > > > > > +     regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > > > > > +     if (!regmap)
> > > > > > > +             return -EPROBE_DEFER;
> > > > > >
> > > > > > Why are you deferring here?
> > > > > This is a Leaf driver. Making sure the parent driver has initiali=
zed regmap.
> > > >
> > > > How can this driver initialise before the parent driver?
> > > The parent driver in this case is simple_i2c_mfd.
> > > Based on reference from other similar implementations, the regmap
> > > check was adapted.
> > > As you mentioned, your right that leaf driver will not start before p=
arent
> > > driver is loaded successfully so probably the DEFER might not be need=
ed
> > > here.
> > >
> > > Thanks,
> > > Naresh
> > > >
> > > > --
> > > > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
