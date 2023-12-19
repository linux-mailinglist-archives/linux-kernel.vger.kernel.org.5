Return-Path: <linux-kernel+bounces-4970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC16818480
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D131C23E72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018613ADE;
	Tue, 19 Dec 2023 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1nvUaizl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670A14F77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4648dec9800so877201137.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702978373; x=1703583173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkq0SDyBM5lizOUSB78gmtdwqPXagFKt4mg0KQVX4eQ=;
        b=1nvUaizlkFH9CYTgtTRorlqjv95ulpOXznrnewlvQhH9vc2CCKxK2ZAotD0/izTqQq
         pzxHlW0lqvIV8Od64WQVna83fSV3ohkWrZM6MCJKD+u/mbqx1D3QHQN3l7VymveE867G
         G0l5H900db6FhlEKY9ojaGtkX9sNnJHXbsq+OwqTE+3W+oQUKu1zaZlwWWjJqizShrp2
         +JXpaAA+2aOdgSpfkU0LL4G8+9zPG50pIaYvbvoi2ez+oaFeo6KxE8F4OLLAnEfA4x+5
         rYZFkolHKAYY50HcA0PpqNuINQWe+WahPMs9+IRw7mTINjwIk/PQ9Nb9a0seuJNCy+5Q
         O67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978373; x=1703583173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xkq0SDyBM5lizOUSB78gmtdwqPXagFKt4mg0KQVX4eQ=;
        b=TCWYXC8oY0svIuBGSxAPjCGoC1Tq2mXTX1WG3aBVKFIFuQE354AZj547VeD7IUoqfi
         znxKKmeOAX9kXoYn6cEQYkTH6fGkPI0XGaSOOQPTygWPLseITyozee0JE58wWIT6gNrJ
         jS4TCcUm76w+GSxAUm3ezsp4JDrvWi9Zni28AkINmPLxIQFit2qh/KdT2dFKnGpopopA
         uu3bPzP6qRWJEU9qNuNU/mWd3LSvHYypvrkwiaeLL0vvj5u141tajpYkMHAL1AHtAPxt
         IT5dZFHg3IrSEJAM4Wj0tYObF81YonREiiEqFb2l4GY3jxltliDsIp0ahG9D8srFv7pf
         +Etw==
X-Gm-Message-State: AOJu0Yx1B7V321HcCA0Tmry1ThRjXsNb73ptYPaU8hY6lTdlXRgI8u+k
	ss97mxEsbTy8U7LGYraYvz5XDrnhcxf+9uuoX7I9Ww==
X-Google-Smtp-Source: AGHT+IErNM386cNukBQeeIR7tghhw7iSyETZ0c5uwniY0v7UZTLsxSx6wmwXT4WzV+G+s/r7fB7KOgl/WN1/q8QSSzk=
X-Received: by 2002:a05:6102:e12:b0:466:9d70:6f0b with SMTP id
 o18-20020a0561020e1200b004669d706f0bmr1834848vst.49.1702978373626; Tue, 19
 Dec 2023 01:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219004158.12405-1-warthog618@gmail.com> <20231219004158.12405-4-warthog618@gmail.com>
 <CAMRc=McPQnLzPCJz6AKV44=qp6z=V9sCAcYkDTQA6FVjWj6E3A@mail.gmail.com>
In-Reply-To: <CAMRc=McPQnLzPCJz6AKV44=qp6z=V9sCAcYkDTQA6FVjWj6E3A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 19 Dec 2023 10:32:42 +0100
Message-ID: <CAMRc=McirXisM34GTDQbbs7pEzAsLMNHZRQy_vS34HfEFxdu+w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:30=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Tue, Dec 19, 2023 at 1:42=E2=80=AFAM Kent Gibson <warthog618@gmail.com=
> wrote:
> >
> > Reduce the time holding the gpio_lock by snapshotting the desc flags,
> > rather than testing them individually while holding the lock.
> >
> > Accept that the calculation of the used field is inherently racy, and
> > only check the availability of the line from pinctrl if other checks
> > pass, so avoiding the check for lines that are otherwise in use.
> >
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 74 ++++++++++++++++++-------------------
> >  1 file changed, 36 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index aecc4241b6c8..9f5104d7532f 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -2399,74 +2399,72 @@ static void gpio_desc_to_lineinfo(struct gpio_d=
esc *desc,
> >                                   struct gpio_v2_line_info *info)
> >  {
> >         struct gpio_chip *gc =3D desc->gdev->chip;
> > -       bool ok_for_pinctrl;
> > -       unsigned long flags;
> > +       unsigned long dflags;
> >
> >         memset(info, 0, sizeof(*info));
> >         info->offset =3D gpio_chip_hwgpio(desc);
> >
> > -       /*
> > -        * This function takes a mutex so we must check this before tak=
ing
> > -        * the spinlock.
> > -        *
> > -        * FIXME: find a non-racy way to retrieve this information. May=
be a
> > -        * lock common to both frameworks?
> > -        */
> > -       ok_for_pinctrl =3D pinctrl_gpio_can_use_line(gc, info->offset);
> > +       scoped_guard(spinlock_irqsave, &gpio_lock) {
> > +               if (desc->name)
> > +                       strscpy(info->name, desc->name, sizeof(info->na=
me));
> >
> > -       spin_lock_irqsave(&gpio_lock, flags);
> > +               if (desc->label)
> > +                       strscpy(info->consumer, desc->label,
> > +                               sizeof(info->consumer));
> >
> > -       if (desc->name)
> > -               strscpy(info->name, desc->name, sizeof(info->name));
> > -
> > -       if (desc->label)
> > -               strscpy(info->consumer, desc->label, sizeof(info->consu=
mer));
> > +               dflags =3D READ_ONCE(desc->flags);
> > +       }
> >
> >         /*
> > -        * Userspace only need to know that the kernel is using this GP=
IO so
> > -        * it can't use it.
> > +        * Userspace only need know that the kernel is using this GPIO =
so it
> > +        * can't use it.
> > +        * The calculation of the used flag is slightly racy, as it may=
 read
> > +        * desc, gc and pinctrl state without a lock covering all three=
 at
> > +        * once.  Worst case if the line is in transition and the calcu=
lation
> > +        * is inconsistent then it looks to the user like they performe=
d the
> > +        * read on the other side of the transition - but that can alwa=
ys
> > +        * happen.
> > +        * The definitive test that a line is available to userspace is=
 to
> > +        * request it.
> >          */
> > -       info->flags =3D 0;
> > -       if (test_bit(FLAG_REQUESTED, &desc->flags) ||
> > -           test_bit(FLAG_IS_HOGGED, &desc->flags) ||
> > -           test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
> > -           test_bit(FLAG_EXPORT, &desc->flags) ||
> > -           test_bit(FLAG_SYSFS, &desc->flags) ||
> > +       if (test_bit(FLAG_REQUESTED, &dflags) ||
> > +           test_bit(FLAG_IS_HOGGED, &dflags) ||
> > +           test_bit(FLAG_USED_AS_IRQ, &dflags) ||
> > +           test_bit(FLAG_EXPORT, &dflags) ||
> > +           test_bit(FLAG_SYSFS, &dflags) ||
> >             !gpiochip_line_is_valid(gc, info->offset) ||
> > -           !ok_for_pinctrl)
> > +           !pinctrl_gpio_can_use_line(gc, info->offset))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_USED;
> >
> > -       if (test_bit(FLAG_IS_OUT, &desc->flags))
> > +       if (test_bit(FLAG_IS_OUT, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_OUTPUT;
> >         else
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_INPUT;
> >
> > -       if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
> > +       if (test_bit(FLAG_ACTIVE_LOW, &dflags))
>
> One more nit: you no longer have to use atomic bitops here, you can
> switch to the ones without guarantees for better performance.

-ENEVERMIND, there's no non-atomic test_bit(). I'll go ahead and apply
this one too.

Bart

>
> Bart
>
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_ACTIVE_LOW;
> >
> > -       if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
> > +       if (test_bit(FLAG_OPEN_DRAIN, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_OPEN_DRAIN;
> > -       if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
> > +       if (test_bit(FLAG_OPEN_SOURCE, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_OPEN_SOURCE;
> >
> > -       if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
> > +       if (test_bit(FLAG_BIAS_DISABLE, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_BIAS_DISABLED;
> > -       if (test_bit(FLAG_PULL_DOWN, &desc->flags))
> > +       if (test_bit(FLAG_PULL_DOWN, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN;
> > -       if (test_bit(FLAG_PULL_UP, &desc->flags))
> > +       if (test_bit(FLAG_PULL_UP, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_BIAS_PULL_UP;
> >
> > -       if (test_bit(FLAG_EDGE_RISING, &desc->flags))
> > +       if (test_bit(FLAG_EDGE_RISING, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_EDGE_RISING;
> > -       if (test_bit(FLAG_EDGE_FALLING, &desc->flags))
> > +       if (test_bit(FLAG_EDGE_FALLING, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_EDGE_FALLING;
> >
> > -       if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
> > +       if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME=
;
> > -       else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
> > +       else if (test_bit(FLAG_EVENT_CLOCK_HTE, &dflags))
> >                 info->flags |=3D GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
> > -
> > -       spin_unlock_irqrestore(&gpio_lock, flags);
> >  }
> >
> >  struct gpio_chardev_data {
> > --
> > 2.39.2
> >

