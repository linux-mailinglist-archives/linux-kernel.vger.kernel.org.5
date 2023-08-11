Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D319779192
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHKOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjHKOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:16:07 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F36E65
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:16:05 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4475ae93951so838041137.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691763364; x=1692368164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEWZbJBI0PiM/xImtQ0lBH7RImd/D0JXfjwVWnvRqXQ=;
        b=3LiGl71mQuGUSO7nUSvjjP1GrodJbvNL6/yjKxq+m+A9ZKQ4/QMtd+0/kFSpEw7Ntl
         5d8y+39MNkZxNa08ImQ92UsIgmhktR2ohzt9G6YRy2ChImxM+5A7VqZhiwuV1JqGpf5X
         1s1MgTVlnKmrO7brt7KC3hucMDX1oTBYii0sXFMdplXxzGGhx4u2ywJ7WoYPmyLTrtg7
         aAryOEvJFGNyDMccYNKXGUP9XauI19cZp8mcxZxHeG8KneVpUfJhQvPcyVC+g3peo6me
         DVy29yCzgaRNfxFZaL6Mrs+6/xj5TAvbUtAbvdzSK5tnR9CQWir6wMv3zUjftQ+ywC4E
         gQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763364; x=1692368164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEWZbJBI0PiM/xImtQ0lBH7RImd/D0JXfjwVWnvRqXQ=;
        b=fr2TDW1DNzuAbpoy/CGYB7+YQKdhq/qXukj/saJ5yZ5qabtHgEdlEtLN6DlO+Cnhe2
         /+aDGDJ5RRTlTvtjllQQrTQax8KDxF/xaToSqVTgtBqZH/MHtO/KLBxKrQ9asQwAskwl
         ho4HHL8JBBInu8uJLXmo7W8APDiJ/bf9fN0zGLpTWcvl2i6l8S5uOwKc6eArZWQIDD+P
         Z/H26zpmCCA7RI4WmmEPoSTce3/DQIUCyNwu0gH/aPJA+QQ1SkxDA/nKKs6Vj214AcW6
         1t/ofVSsqmRnsqT7uVsolK8BDM0YTh9L5UkFpbkY4ZQUYAdVvTL3SLtyBaOs0p8rSGjT
         a4+A==
X-Gm-Message-State: AOJu0YyAjOeByFMAoCHbLkE+8Fy6FcV01QeboE+K/WJthc5CkQcRd4Yf
        WR3l9uuhlYl1mg8AnRQbIY/jQMFYa0Cw/5jwKxSY1A==
X-Google-Smtp-Source: AGHT+IEvvnkPGV38zUhCEMKcYaFeRYl/AcXe0pjIIlxtp2dOvBlNLQPzJoaTWLSSM9+TizFZvRc7IDnqy31xKzJCMTs=
X-Received: by 2002:a05:6102:a93:b0:444:db0a:51b with SMTP id
 n19-20020a0561020a9300b00444db0a051bmr1495097vsg.15.1691763364670; Fri, 11
 Aug 2023 07:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230809142709.28042-1-brgl@bgdev.pl> <ZNT8T1n0IeJ1uzl6@smile.fi.intel.com>
In-Reply-To: <ZNT8T1n0IeJ1uzl6@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 16:15:53 +0200
Message-ID: <CAMRc=MdptDso9H+7WugO0pQ508ijVUkxAmi5TFcGr6a4TsOLog@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: consumer: new virtual driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Aug 10, 2023 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Aug 09, 2023 at 04:27:09PM +0200, Bartosz Golaszewski wrote:
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
> > +static void gpio_consumer_on_timer(struct timer_list *timer)
> > +{
> > +     struct gpio_consumer_timer_data *timer_data =3D to_timer_data(tim=
er);
> > +
> > +     timer_data->val =3D timer_data->val ? 1 : 0;
>
> I guess it should be 0 : 1.
>

Eek!

> > +     gpiod_set_value_cansleep(timer_data->desc, timer_data->val);
> > +     mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(1000));
> > +}
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_lookup_config_key_show(struct config_item *item, char *p=
age)
> > +{
> > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_lookup(i=
tem);
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
>
> > +     int ret;
>
> Why is it needed now? Seems you were too fast to send v3, look at my comm=
ents
> in v2 thread.
>
> > +     scoped_guard(mutex, &dev->lock)
> > +             ret =3D sprintf(page, "%s\n", lookup->key);
> > +
> > +     return ret;
> > +}
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_lookup_config_key_store(struct config_item *item,
> > +                                   const char *page, size_t count)
> > +{
> > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_lookup(i=
tem);
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > +     char *key __free(kfree) =3D NULL;
> > +     char *stripped;
> > +
> > +     key =3D kstrndup(page, count, GFP_KERNEL);
>
> skip_spaces() will allow you to get rid of memmove().
>
> > +     if (!key)
> > +             return -ENOMEM;
> > +
> > +     stripped =3D strstrip(key);
> > +     memmove(key, stripped, strlen(stripped) + 1);
>
> And this become something like
>
>         /* Get rid of trailing newline and spaces */
>         strim(key);
>

I did it this way for v3.

> > +     guard(mutex)(&dev->lock);
> > +
> > +     if (gpio_consumer_device_is_live_unlocked(dev))
> > +             return -EBUSY;
> > +
> > +     kfree(lookup->key);
> > +     lookup->key =3D no_free_ptr(key);
> > +
> > +     return count;
> > +}
>
> ...
>
> > +static enum gpio_lookup_flags
> > +gpio_consumer_lookup_get_flags(struct config_item *item)
> > +{
> > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_lookup(i=
tem);
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > +     enum gpio_lookup_flags flags;
> > +
> > +     scoped_guard(mutex, &dev->lock)
>
> > +             flags =3D lookup->flags;
> > +
> > +     return flags;
>
>         guard()
>         return lookup->flags;
>
> ?
>
> > +}
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_device_config_live_store(struct config_item *item,
> > +                                    const char *page, size_t count)
> > +{
> > +     struct gpio_consumer_device *dev =3D to_gpio_consumer_device(item=
);
> > +     bool live;
> > +     int ret;
> > +
> > +     ret =3D kstrtobool(page, &live);
> > +     if (ret)
> > +             return ret;
> > +
> > +     guard(mutex)(&dev->lock);
> > +
> > +     if (live =3D=3D gpio_consumer_device_is_live_unlocked(dev))
> > +             ret =3D -EPERM;
>
>                 return ... ?
>
> > +     else if (live)
>
>         if () ?
>
> > +             ret =3D gpio_consumer_device_activate_unlocked(dev);
>
> > +     else
>
> drop it ?

We need to return count, not ret so this version is clearer.

Bart

>
> > +             gpio_consumer_device_deactivate_unlocked(dev);
> > +
> > +     return ret ?: count;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
