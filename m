Return-Path: <linux-kernel+bounces-4962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221281846B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696B71F25A31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF313AD1;
	Tue, 19 Dec 2023 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R7s5dWsv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB41426E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7cbebe9ca1dso477108241.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702978219; x=1703583019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbUElj0SWtSMweHxBFZEsmAYJvGhuIudOzih0gHu80c=;
        b=R7s5dWsvHf0k+qxL9uC62ZsyVWDpH+NCJoRiIeVOgJ5LSRcrRZ1mYWIcV8NoD+ZV2p
         VjkAXYrjEhz20eC8QY04K0ep6nN/P/AjHYokefg2ESz9i9OC0AI2pzqH/EqfTpPIHctt
         EXkAeXcl9d2yQXsN30gR5I/3E9Ce63TJCeO8fCjXv2qZP0/8ibWWTxnJAmR22+AGSAVH
         nl8PiQMIUuABrk2v+yje2m3uBcO3WpYaTu+o2HLP3+kTPFM/yoRK3dNG7wawOuLS1GM+
         bVltW0Ur0AQJ0m0R8moiiTw7/nO21Mh6IWPYhVD3INthaLAcdkqAnpm5PufcV2p2RGwt
         VgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978219; x=1703583019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbUElj0SWtSMweHxBFZEsmAYJvGhuIudOzih0gHu80c=;
        b=f5855RxVRfPzQGBDRGisz4LCIYNpH7fmvlOe5SUIcDFNuruPmcCVKUiNXbkHe/P3Tm
         xA3g+B/YEnLrebIKM6Y9LCdk3xGwCdr5mtEE1IAOKE/GnBmejqx3K7LvRd4kZ8JEv9b8
         1N1aXCDifICxXHr+13KPVMyTzX8gxSHvx5kWuFtFqE1yjkMwDmKwAtS05lDGNWiYMUAL
         ewyxs6DAWnGIFtQFFF0445eaE5dd/KrLbHYLP8VUKfar0UEc3tHSvBYuaR2pwi+C+rDa
         3XOdeRf9Kml7xlt78NuAjEN6CcLseCEEsQW9tVy5dA9k0Er7hhh+f+jDGQgPzlByu1lR
         8TjQ==
X-Gm-Message-State: AOJu0YwOU/lYB0lrVSoA8JXHIgLGNHoVYX8TSKxxe3O4/dI7K1V0hB5n
	rpUfxi0TmX6KdZUPhRHVPJQbYtK4Vn/1d8qtRWWVww==
X-Google-Smtp-Source: AGHT+IGRNZ0zs5keVxOKLSWC9s7Izs7eTe4t85MYFGomSp8xU2c9LFehLXTW2s7v66HTyZqZRKv9KPtRAyeh4Nrk/8Q=
X-Received: by 2002:a05:6102:3f06:b0:466:1932:23b4 with SMTP id
 k6-20020a0561023f0600b00466193223b4mr11493565vsv.66.1702978218717; Tue, 19
 Dec 2023 01:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219004158.12405-1-warthog618@gmail.com> <20231219004158.12405-4-warthog618@gmail.com>
In-Reply-To: <20231219004158.12405-4-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 19 Dec 2023 10:30:07 +0100
Message-ID: <CAMRc=McPQnLzPCJz6AKV44=qp6z=V9sCAcYkDTQA6FVjWj6E3A@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:42=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> Reduce the time holding the gpio_lock by snapshotting the desc flags,
> rather than testing them individually while holding the lock.
>
> Accept that the calculation of the used field is inherently racy, and
> only check the availability of the line from pinctrl if other checks
> pass, so avoiding the check for lines that are otherwise in use.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 74 ++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index aecc4241b6c8..9f5104d7532f 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2399,74 +2399,72 @@ static void gpio_desc_to_lineinfo(struct gpio_des=
c *desc,
>                                   struct gpio_v2_line_info *info)
>  {
>         struct gpio_chip *gc =3D desc->gdev->chip;
> -       bool ok_for_pinctrl;
> -       unsigned long flags;
> +       unsigned long dflags;
>
>         memset(info, 0, sizeof(*info));
>         info->offset =3D gpio_chip_hwgpio(desc);
>
> -       /*
> -        * This function takes a mutex so we must check this before takin=
g
> -        * the spinlock.
> -        *
> -        * FIXME: find a non-racy way to retrieve this information. Maybe=
 a
> -        * lock common to both frameworks?
> -        */
> -       ok_for_pinctrl =3D pinctrl_gpio_can_use_line(gc, info->offset);
> +       scoped_guard(spinlock_irqsave, &gpio_lock) {
> +               if (desc->name)
> +                       strscpy(info->name, desc->name, sizeof(info->name=
));
>
> -       spin_lock_irqsave(&gpio_lock, flags);
> +               if (desc->label)
> +                       strscpy(info->consumer, desc->label,
> +                               sizeof(info->consumer));
>
> -       if (desc->name)
> -               strscpy(info->name, desc->name, sizeof(info->name));
> -
> -       if (desc->label)
> -               strscpy(info->consumer, desc->label, sizeof(info->consume=
r));
> +               dflags =3D READ_ONCE(desc->flags);
> +       }
>
>         /*
> -        * Userspace only need to know that the kernel is using this GPIO=
 so
> -        * it can't use it.
> +        * Userspace only need know that the kernel is using this GPIO so=
 it
> +        * can't use it.
> +        * The calculation of the used flag is slightly racy, as it may r=
ead
> +        * desc, gc and pinctrl state without a lock covering all three a=
t
> +        * once.  Worst case if the line is in transition and the calcula=
tion
> +        * is inconsistent then it looks to the user like they performed =
the
> +        * read on the other side of the transition - but that can always
> +        * happen.
> +        * The definitive test that a line is available to userspace is t=
o
> +        * request it.
>          */
> -       info->flags =3D 0;
> -       if (test_bit(FLAG_REQUESTED, &desc->flags) ||
> -           test_bit(FLAG_IS_HOGGED, &desc->flags) ||
> -           test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
> -           test_bit(FLAG_EXPORT, &desc->flags) ||
> -           test_bit(FLAG_SYSFS, &desc->flags) ||
> +       if (test_bit(FLAG_REQUESTED, &dflags) ||
> +           test_bit(FLAG_IS_HOGGED, &dflags) ||
> +           test_bit(FLAG_USED_AS_IRQ, &dflags) ||
> +           test_bit(FLAG_EXPORT, &dflags) ||
> +           test_bit(FLAG_SYSFS, &dflags) ||
>             !gpiochip_line_is_valid(gc, info->offset) ||
> -           !ok_for_pinctrl)
> +           !pinctrl_gpio_can_use_line(gc, info->offset))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_USED;
>
> -       if (test_bit(FLAG_IS_OUT, &desc->flags))
> +       if (test_bit(FLAG_IS_OUT, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_OUTPUT;
>         else
>                 info->flags |=3D GPIO_V2_LINE_FLAG_INPUT;
>
> -       if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
> +       if (test_bit(FLAG_ACTIVE_LOW, &dflags))

One more nit: you no longer have to use atomic bitops here, you can
switch to the ones without guarantees for better performance.

Bart

>                 info->flags |=3D GPIO_V2_LINE_FLAG_ACTIVE_LOW;
>
> -       if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
> +       if (test_bit(FLAG_OPEN_DRAIN, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_OPEN_DRAIN;
> -       if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
> +       if (test_bit(FLAG_OPEN_SOURCE, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_OPEN_SOURCE;
>
> -       if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
> +       if (test_bit(FLAG_BIAS_DISABLE, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_BIAS_DISABLED;
> -       if (test_bit(FLAG_PULL_DOWN, &desc->flags))
> +       if (test_bit(FLAG_PULL_DOWN, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN;
> -       if (test_bit(FLAG_PULL_UP, &desc->flags))
> +       if (test_bit(FLAG_PULL_UP, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_BIAS_PULL_UP;
>
> -       if (test_bit(FLAG_EDGE_RISING, &desc->flags))
> +       if (test_bit(FLAG_EDGE_RISING, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_EDGE_RISING;
> -       if (test_bit(FLAG_EDGE_FALLING, &desc->flags))
> +       if (test_bit(FLAG_EDGE_FALLING, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_EDGE_FALLING;
>
> -       if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
> +       if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
> -       else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
> +       else if (test_bit(FLAG_EVENT_CLOCK_HTE, &dflags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
> -
> -       spin_unlock_irqrestore(&gpio_lock, flags);
>  }
>
>  struct gpio_chardev_data {
> --
> 2.39.2
>

