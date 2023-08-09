Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63748775428
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjHIHas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjHIHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:30:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED42722
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:29:28 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-584243f84eeso74174547b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691566165; x=1692170965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF0E6kelvstAlRFQ0vx9A2QeB/j089mo1MhMvgo0Ads=;
        b=iFMIwlh74ckHTEvU1PmweClfZqe+2VOWxg41DZJDgzMXImMBGqsPbeIuCdmKqyKG8T
         1B/qLoYOzkYvo1+toBuJqLVntdapykF2iYJh7F9ZVIRCxTuKrl3jtVwtNt5QAYpQreLN
         LtudQc0LGTisG3nigRg4h+WH+AGyZbRMmai6HUqk6mSTiFYxxLnTJ1Mt8mWO1pxos9C7
         B1RnGcXWaPOEnlyE0khB02KZjI7qFD0GlOeAOCemuvu2vhHpMizKJ5iuvlc84y9W+6C+
         IloJ1vnRO0d7ihxHVs9QU1WMGcK+XcHj2veb1TR+DiYJnI9GR8CQXY4pt1E1cUDmoS4r
         eSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566165; x=1692170965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF0E6kelvstAlRFQ0vx9A2QeB/j089mo1MhMvgo0Ads=;
        b=VZKgcpZmLMfnErLyzLChg4MT+sMGA6anj63kzg6zwapgg0CaNtBtD1mTcvsgch/QUu
         RXvEU5xtdgLgOfskRcXw0qcAUysVOu02GDvyV+C+GC2iSjqL2Lgiu31ogUvG6tZm22Lw
         /peUbC5als4IW+aqYUVcCB+L57irlvtKBoilssqjvLM8B3E1iSYzhKBNJB3WoX+bPwN9
         5k1h9ZiMnsC6ReWShG3TPlmIih6o+c9BvX5i5DtGFt1YManjcsWJEJXzYOgM5XxovjmH
         OTJu2L8ekPaDPlkX9UCjI/lxg7JXpSIAZRCA/gPlYlTwLhbUfHrFUpnYumPpjQmsO1vh
         mt7w==
X-Gm-Message-State: AOJu0Ywd6P77yfFDWNVL4Usm4NOj+ZkC3AGPEOmJGmCZ3v0YclWZYOIB
        Jg2JFaqRygICJDCqIusdeYA1Iy4CMggIeHBUZsEvbg==
X-Google-Smtp-Source: AGHT+IEcgNVmCrDg7WhZ5Y7Sdpfe+CEimwGKyuQgZ73mFnaAH4BYmRmXY5kpYENq+M3TX4yW7BThnqeD5zZ13e2cOqo=
X-Received: by 2002:a0d:e612:0:b0:583:4e2e:9da0 with SMTP id
 p18-20020a0de612000000b005834e2e9da0mr2102581ywe.1.1691566165427; Wed, 09 Aug
 2023 00:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230808145605.16908-1-brgl@bgdev.pl> <ZNJ6HCOV0bzlaoXX@smile.fi.intel.com>
In-Reply-To: <ZNJ6HCOV0bzlaoXX@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 9 Aug 2023 09:29:14 +0200
Message-ID: <CAMRc=Mf_BmhZLN1J2m4SnpmPJzZtYPcfdR54EfG9gR5Px_Ss-Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: consumer: new virtual driver
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 8:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 08, 2023 at 04:56:05PM +0200, Bartosz Golaszewski wrote:
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
> I'll read documentation later. Some code comments below.
>
> ...
>
> > +static void gpio_consumer_on_timer(struct timer_list *timer)
> > +{
> > +     struct gpio_consumer_timer_data *timer_data =3D to_timer_data(tim=
er);
>
> > +     timer_data->val =3D timer_data->val =3D=3D 0 ? 1 : 0;
>
> Can be
>
>         timer_data->val =3D timer_data->val ? 0 : 1;
>

This is still find, though it doesn't really save us even a single line of =
code.

> But again, why not
>
>         timer_data->val ^=3D 1;
>

This is not ok in my book. If I need to think for more than a second
about what it does, then it's worse. I put clarity over brevity.

> ?
>
> > +     gpiod_set_value_cansleep(timer_data->desc, timer_data->val);
> > +     mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(1000));
> > +}
>
> ...
>
> > +     key =3D kstrndup(page, count, GFP_KERNEL);
> > +     if (!key)
> > +             return -ENOMEM;
>
> > +     stripped =3D strstrip(key);
> > +     memmove(key, stripped, strlen(stripped) + 1);
>
> This can be avoided by
>
>         key =3D kstrndup(skip_spaces(page), count, GFP_KERNEL);
>
> no?
>

No, because we also want to remove the trailing spaces and newlines.
But if you have a different suggestion with existing helpers, let me
know. I didn't find any.

> ...
>
> > +     ret =3D kstrtoint(page, 0, &offset);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Use -1 to indicate lookup by name. */
>
> This comment is unclear as offset can be -1 given by the user.
> What does above mean in that context?
>

I added this to the documentation. Negative number means: lookup by
line name, positive or zero - lookup offset in chip.

> > +     if (offset > (U16_MAX - 1))
>
> And how does it related to this -1 if related at all?
>

GPIOLIB interprets U16_MAX as "lookup by line name". So we can allow
max (U16_MAX - 1). I will add a comment.

> > +             return -EINVAL;
>
> ...
>
> > +static struct config_group *
> > +gpio_consumer_config_make_device_group(struct config_group *group,
> > +                                    const char *name)
> > +{
> > +     struct gpio_consumer_device *dev;
> > +
> > +     dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> > +     if (!dev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     dev->id =3D ida_alloc(&gpio_consumer_ida, GFP_KERNEL);
> > +     if (dev->id < 0) {
> > +             kfree(dev);
>
> Wondering if you can utilize cleanup.h.
>

Whooaah! In february this year I suggested basic C RAII during my talk
at fosdem and here we are? I missed this one. Yeah, I will use it!
Even better, I will abuse the cr*p out of it in gpio-sim as well!
Thanks for bringing this to my attention. This may be the best thing
that happened to kernel C code in years if people widely adopt it.
(This paragraph was written by a fan of GLib's autopointer paradigm.
:) )

Bartosz

> > +             return ERR_PTR(dev->id);
> > +     }
> > +
> > +     config_group_init_type_name(&dev->group, name,
> > +                                 &gpio_consumer_device_config_group_ty=
pe);
> > +     mutex_init(&dev->lock);
> > +     INIT_LIST_HEAD(&dev->lookup_list);
> > +     dev->bus_notifier.notifier_call =3D gpio_consumer_bus_notifier_ca=
ll;
> > +     dev->function =3D GPIO_CONSUMER_FUNCTION_ACTIVE;
> > +     init_completion(&dev->probe_completion);
> > +
> > +     return &dev->group;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
