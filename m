Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C14782953
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjHUMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHUMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:42:06 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A949C2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:42:05 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-447b64b0555so711346137.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692621724; x=1693226524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/XUKnH0ODMsj7aJ2rH2loczLALoUCOwlJiRi5R0GRw=;
        b=2VMC4Et+gZb2nhck9gfQ7jcfJTDmTXeFwR/gYdD2xbhlQwucu9eJan7yiURvjfugI/
         qVzMVR7nIeVAPQS+yBsCC8DuvVnlylgTruS7lJjvxsk8yy2ib4a/VcKZfAJQVIORbsSc
         4Ak/QiOY4oIZEPmrccPMUDuX8TwXncyKQttcVJOOqzqKJtxt1LKjiAikqV/pbpumM4aJ
         UtivtOTrWlwjONxWOS3r9u2rf3M+tR1YBO2L7ApjAI0nbApFh66wspIpfifYKLM10kfe
         kffhNopBdaUtoCeQKmmPNiFdzdQB78+l6mXKGB8GjrSf4mQ29HrOJV0bxeqQoELx4ovl
         2NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621724; x=1693226524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/XUKnH0ODMsj7aJ2rH2loczLALoUCOwlJiRi5R0GRw=;
        b=eyjxLWYD7FGb3SY/x9ArnVbakdLdEZF0GW0qF/n2ifqAy4scNYYJ/m2lHzBvWr0vJ+
         JVV2XWs5O/kM7BlOmrShbRE/9PNsKEwJ5LGDQn9oaPLmPEm/gSlnM+c7c8qvVwH1TLaT
         hLdk63LQX9+RiP5KDpR5+kXd5jTJTn65KvLUJNgk5x88AU+qjhmpPpmiTgB96OclNNLN
         lBqxxaCA7rt/kNSY9h6YPZCcy8D108x/IGr1T0UMowoZwJaVvJMgSTh8yTnyDgOLFBT/
         b6RZ13FhZCAx+TmcPy06z3UMgT9J2gObDL86agA7XQfvOYpVjxAreyluZyX4L/6HAz3Y
         JqRg==
X-Gm-Message-State: AOJu0Yy29UmUUPxmO7VYrwQMXGbfnma/tBqt9Gb3u9qaxT//mTL0bEXJ
        Dcl7Op7iDWdAhYKDyc9J2saxPfIIKZTjHqzN6lh/zg==
X-Google-Smtp-Source: AGHT+IFeTlzQ49lQSO4nLHVwpJ1/aco2mrW93aFGnKhTYAhfDwMRdC3G43F6dClNQP1Fxsl2q3tlFyRTAgiMKtoDGu4=
X-Received: by 2002:a67:f74c:0:b0:445:228e:62db with SMTP id
 w12-20020a67f74c000000b00445228e62dbmr2724787vso.8.1692621724150; Mon, 21 Aug
 2023 05:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184356.25020-1-brgl@bgdev.pl> <ZN826UBEktlq42bE@smile.fi.intel.com>
In-Reply-To: <ZN826UBEktlq42bE@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 14:41:53 +0200
Message-ID: <CAMRc=Me-82Dv+t+Y0RF29nL-WvmAjiHFWE9pYKiqZ8sjgRth4w@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: consumer: new virtual driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:16=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 17, 2023 at 08:43:56PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The GPIO subsystem has a serious problem with undefined behavior and
> > use-after-free bugs on hot-unplug of GPIO chips. This can be considered=
 a
> > corner-case by some as most GPIO controllers are enabled early in the
> > boot process and live until the system goes down but most GPIO drivers
> > do allow unbind over sysfs, many are loadable modules that can be (forc=
e)
> > unloaded and there are also GPIO devices that can be dynamically detach=
ed,
> > for instance CP2112 which is a USB GPIO expender.
> >
> > Bugs can be triggered both from user-space as well as by in-kernel user=
s.
> > We have the means of testing it from user-space via the character devic=
e
> > but the issues manifest themselves differently in the kernel.
> >
> > This is a proposition of adding a new virtual driver - a configurable
> > GPIO consumer that can be configured over configfs (similarly to
> > gpio-sim).
> >
> > The configfs interface allows users to create dynamic GPIO lookup table=
s
> > that are registered with the GPIO subsystem. Every config group
> > represents a consumer device. Every sub-group represents a single GPIO
> > lookup. The device can work in three modes: just keeping the line
> > active, toggling it every second or requesting its interrupt and
> > reporting edges. Every lookup allows to specify the key, offset and
> > flags as per the lookup struct defined in linux/gpio/machine.h.
> >
> > The module together with gpio-sim allows to easily trigger kernel
> > hot-unplug errors. A simple use-case is to create a simulated chip,
> > setup the consumer to lookup one of its lines in 'monitor' mode, unbind
> > the simulator, unbind the consumer and observe the fireworks in dmesg.
> >
> > This driver is aimed as a helper in tackling the hot-unplug problem in
> > GPIO as well as basis for future regression testing once the fixes are
> > upstream.
>
> ...
>
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_GPIO_BT8XX)            +=3D gpio-bt8xx.o
> >  obj-$(CONFIG_GPIO_CADENCE)           +=3D gpio-cadence.o
> >  obj-$(CONFIG_GPIO_CLPS711X)          +=3D gpio-clps711x.o
> >  obj-$(CONFIG_GPIO_SNPS_CREG)         +=3D gpio-creg-snps.o
> > +obj-$(CONFIG_GPIO_CONSUMER)          +=3D gpio-consumer.o
>
> Order?
>
> >  obj-$(CONFIG_GPIO_CRYSTAL_COVE)              +=3D gpio-crystalcove.o
> >  obj-$(CONFIG_GPIO_CS5535)            +=3D gpio-cs5535.o
> >  obj-$(CONFIG_GPIO_DA9052)            +=3D gpio-da9052.o
>
> ...
>
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to read GPIO line names\n");
>
> With one line it takes 83 characters (and note, that long before checkpat=
ch
> went for 100, the string literals at the end of a long line were accepted=
)...
>
> ...
>
> > +                             return dev_err_probe(dev, ret,
> > +                                             "Failed to request GPIO l=
ine interrupt\n");
>
> And here with broken indentation you got 91.
> Can you be consistent?
>
> (I prefer as you know less LoCs)
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_lookup_config_drive_store(struct config_item *item,
> > +                                     const char *page, size_t count)
> > +{
> > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_lookup(i=
tem);
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > +
> > +     guard(mutex)(&dev->lock);
> > +
> > +     if (gpio_consumer_device_is_live_unlocked(dev))
> > +             return -EBUSY;
> > +
> > +     if (sysfs_streq(page, "push-pull")) {
> > +             lookup->flags &=3D ~(GPIO_OPEN_DRAIN | GPIO_OPEN_SOURCE);
> > +     } else if (sysfs_streq(page, "open-drain")) {
> > +             lookup->flags &=3D ~GPIO_OPEN_SOURCE;
> > +             lookup->flags |=3D GPIO_OPEN_DRAIN;
> > +     } else if (sysfs_streq(page, "open-source")) {
> > +             lookup->flags &=3D ~GPIO_OPEN_DRAIN;
> > +             lookup->flags |=3D GPIO_OPEN_SOURCE;
> > +     } else {
>
> > +             count =3D -EINVAL;
>
> Strictly speaking this is incorrect.
> You need
>
>         ssize_t ret;
>         ...
>         ret =3D count;
>         if (...)
>                 ret =3D -EINVAL;
>
> > +     }
> > +
> > +     return count;
> > +}
>
> > +static ssize_t
> > +gpio_consumer_lookup_config_pull_store(struct config_item *item,
> > +                                    const char *page, size_t count)
> > +{
>
> As per above.
>
> > +}
>
> ...
>
> > +             curr->chip_hwnum =3D lookup->offset < 0 ?
> > +                                     U16_MAX : lookup->offset;
>
> I found this way better
>
>                 curr->chip_hwnum =3D
>                         lookup->offset < 0 ? U16_MAX : lookup->offset;
>
>
> ...
>
> > +     return ret ?: count;
>
> Also possible way in the above mentioned cases.
>
> ...
>
>
> I'm not going to bikeshed, I believe you can fix above accordingly,
> either way
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

Actually when experimenting more, I started thinking we could improve
the driver even more. Expose a sysfs interface that would allow to
control the GPIOs from the kernel on user-space's behalf. For
instance: change value, change direction, toggle active-low watch for
interrupts (and log them to a sysfs buffer) etc.

I won't be queueing it for v6.6, I want to spend some more time on it.

Thanks for the reviews.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
