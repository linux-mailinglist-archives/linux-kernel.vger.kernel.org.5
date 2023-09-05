Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B4792A97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbjIEQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354511AbjIEMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:09:30 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642471AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:09:27 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5733aa10291so1670082eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693915766; x=1694520566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpl8PdcHUyXhdg581Pr7P2ixRHMIHFGIKvQFb4jyDKo=;
        b=sJ/fTBdet8LkFz2uB8x6RUvblR09cBZA3GXHn7Vr/xJNiUsSgJSWPs6tONhMlwFOfZ
         whYwQcgxT6553kXSKvtehKAWJkWSkViR9sOCP9R/iD7OO6GdJODrqRmqNcLCMIkMYeF+
         T/Z6b2F4rhDsyINdmiCXlfbCPUxZY51O4kodIgKlVzSavKOxHKUNHCrifNh2mcN24eHU
         4ICU6w1FdDbe/SZWuuC/xkERkB7NKTsEXvh8XRmsNY97Up4uO1Mi6uMo097Qp6LKQZB+
         Gmpd2wrShbDmMq1f3PG3SOEStWPxwbhYsYwnQWDluUC3z8x5CWJcQtZJKiJXSnob80vN
         dxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693915766; x=1694520566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpl8PdcHUyXhdg581Pr7P2ixRHMIHFGIKvQFb4jyDKo=;
        b=QN1OMlPjgiKR8WpgDWfVip3zFXUaAyhFPBCLW6fvtdekWGWUn4WmeGajBcAyLRCNCz
         wQtOd6Zv0avciucfvU0fVfncGBfFEhDjy7yy+nc4UH/OVv6O+LbAUQxOa8Ri77xv/0Fa
         Ns6HZqI/2am6PtZM7BsmtKq9aJq5bqpD2Z+BYvChUvKEBuAgdCjjogU71NPY35jjDWqI
         bI/WnQOQ6wAwN+T+UtFg7tK5rBIbfe3Zwvba0DIo7lnYTryEXuuh9neOYOZS41V3n/Ey
         pVyOXDCeCIzSMXfLB68gcj0+t6INndgcATuwGiD5ZUBBBeV7ZGvhVGMtQ3uzwEQXsXU8
         sNmQ==
X-Gm-Message-State: AOJu0Yx7+dfYD06CbfJ8dlh2qKYQ0nv83C6ICv/oLQOwRl8AoER9bMR8
        iwd5N8/dqIyzfJyQvYCxLNjLEBdi+xB3YQmMlXkNyg==
X-Google-Smtp-Source: AGHT+IF9zcrS8LKzm6uHHdeppxKv0cPOMhqbqlgFXgvwTMW24s0LoHG8DAK9cA2YZKwCujua/+5uMRHi0yoPnbrd/uk=
X-Received: by 2002:a05:6358:e485:b0:139:f5e9:4463 with SMTP id
 by5-20020a056358e48500b00139f5e94463mr13912752rwb.2.1693915766671; Tue, 05
 Sep 2023 05:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230905082413.21954-1-brgl@bgdev.pl> <ZPcZfd5UtzMmIUvm@smile.fi.intel.com>
In-Reply-To: <ZPcZfd5UtzMmIUvm@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Sep 2023 14:09:15 +0200
Message-ID: <CAMRc=Mc1K-xMzbtLSvZcSuXpLPmGkHekonjx5m_519OuxOxuxA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sim: don't fiddle with GPIOLIB private members
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 2:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 05, 2023 at 10:24:13AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We access internals of struct gpio_device and struct gpio_desc because
> > it's easier but it can actually be avoided and we're working towards a
> > better encapsulation of GPIO data structures across the kernel so let's
> > start at home.
> >
> > Instead of checking gpio_desc flags, let's just track the requests of
> > GPIOs in the driver. We also already store the information about
> > direction of simulated lines.
> >
> > For kobjects needed by sysfs callbacks: we can iterate over the childre=
n
> > devices of the top-level platform device and compare their fwnodes
> > against the one passed to the init function from probe.
> >
> > While at it: fix one line break and remove the untrue part about
> > configfs callbacks using dev_get_drvdata() from a comment.
>
> ...
>
> > v2 -> v3:
> > - don't use fwnode internal fields, instead: iterate over the platform
> >   device's children and locate the GPIO device
>
> Thank you!
>
> ...
>
> > @@ -181,7 +178,7 @@ static int gpio_sim_get_direction(struct gpio_chip =
*gc, unsigned int offset)
>
> >  static int gpio_sim_set_config(struct gpio_chip *gc,
> > -                               unsigned int offset, unsigned long conf=
ig)
> > +                            unsigned int offset, unsigned long config)
>
> Looking at other prototypes, it can be
>
> static int gpio_sim_set_config(struct gpio_chip *gc, unsigned int offset,
>                                unsigned long config)
>
> ...
>
> > +static int gpio_sim_chip_set_device(struct device *dev, void *data)
> > +{
> > +     struct gpio_sim_chip *chip =3D data;
>
> > +     if (chip->swnode =3D=3D dev->fwnode) {
>
> Please do not dereference fwnode from the struct device, we have an API!
> device_match_fwnode()
>
> > +             chip->dev =3D dev;
> > +             return 1;
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +     chip->swnode =3D swnode;
> > +     ret =3D device_for_each_child(dev, chip, gpio_sim_chip_set_device=
);
> > +     if (!ret)
> > +             return -ENODEV;
>
> Can bus_find_device_by_fwnode() be used here?
>

I can but then we're iterating over all platform devices and not just
children of this GPIO simulator. If you think it's better for even
less fwnode juggling then I can go with it.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
