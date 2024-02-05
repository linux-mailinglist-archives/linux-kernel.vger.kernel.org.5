Return-Path: <linux-kernel+bounces-52717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84065849BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93101F2366F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF21EB56;
	Mon,  5 Feb 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qy1YKQr0"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7A1CD03
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139865; cv=none; b=Jv6VKhs+sMkMRNrVUM8Sgp3KIx3ZWtYBCMumYKVwk+K4e00/F9l8cDlipeAf6iv57pXUivTMO8GZzTq1Al06lwgEh3IFff5CzGCc27Ql61s9Ubszfa0m3zVsQZDpBpPA5lwHNZ91anDrKTNP4vr5YTa+evzTOhGkVX+kdN7AFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139865; c=relaxed/simple;
	bh=wLfJ/0IB9dyey55EtuoOE0q19b7O21vS/HQ/794U4qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqL8CTCoEV+C0Aj7LstER1e+xBjxBZ3OgeTFGVaEPuUGGGEjqCjWChpLsfQR0M/yQds/kntlAUMNjJstO0ffl8Kxcj8CMclRFj9ZSB4Yk7RI0yGeQyXJSaJQcEDGYzhsBzACtBmo6CWvSbgNiTc4Hw2B2QClkibwdYMX/JBtW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qy1YKQr0; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c021a73febso385624e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707139862; x=1707744662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQUvAug16xfX74Z5VwN9maZWjvAKHtJEUjTVvTKUeSo=;
        b=Qy1YKQr0tvPWTjvN03GhOrOUP7QDhb0TJMPwtpPU2olNaLzmPfjx93H2u/xaqFfS0G
         /sk71JOLqkP9rwY9h8lj6UO6Wo0ImZX7Wfm4rVX0WM8SMUZYS2l6jWva5GObOKeq8idX
         q+Yr0ShpmxSVw2bOa85M7Zi3QIgP8WNeEKeg874ltLIIAayv116CTvp/VtbhNbkcLAvD
         1V73BAbGQh/X8EgAuEuL9K/Xpn2Bze5jgZzz4tZs8t4dPTQU9MNW9LI3dlPxDhZ4o1nP
         P7kRslzuOufzeYWogSj0vLp1MlweHK/VmmMJ8hdkK+Dp4zsOF4CpKqN97yI346Ege2xe
         Zxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707139862; x=1707744662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQUvAug16xfX74Z5VwN9maZWjvAKHtJEUjTVvTKUeSo=;
        b=PZwTIyJutKYcP+BEru6STaNvEsDKh0y31WOsqSUXe59ostEUyExRePlc6CfIrzn+YA
         cf5R9ktPq0AI+cO38DTUEEVk0YoEIdjL4lt6uQ4rrHXN2eh/OOXMwFImr5Nz35BLBgyX
         p7J3on3lUSyuTtnRx43bMUtkwM+LWAowY3i8fSCA23sjy3chjNaslb+VWiRtiqRysdqR
         tFgmawsR7+EWigiXALWNT1UPxCI+Gpip6SiBfyNz+yC3/Rmok4SuQYp8uALMbB3DiI22
         D/kEb/rGBNeHlg4bugGIEtXEnvmAsNN8IMWfMmI/O3+1Mcesy2CN0IemwzbNNR8NQz4v
         64Vg==
X-Gm-Message-State: AOJu0Yzc33txFpiVV0c+5liwap/hQcANfExr7rUDN9KbEWFt5rtHjQED
	ltB77umgSjJypuSJq7eTUjnadDZNxUarWcDfjZPVnlu/l5BFGrUiUPs27qdUN4AmQ02aAfWSpK0
	rJybtpzsL1rtpJu281UEIbHIF4kg2rRG5whK/lw==
X-Google-Smtp-Source: AGHT+IHWB+ykGzwtJWJXUnkr+vzutCptbpx+5WpJWSVsqSYhnQrDqll0qqZbsYUZBm2ibJxH+pCHQ54HARHIasWJk+U=
X-Received: by 2002:ac5:cfed:0:b0:4c0:1f44:6707 with SMTP id
 m45-20020ac5cfed000000b004c01f446707mr1961890vkf.11.1707139862440; Mon, 05
 Feb 2024 05:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
In-Reply-To: <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 14:30:51 +0100
Message-ID: <CAMRc=Me-c3Twn+5FbBkqxc6wLSXg-ej4-sajPe9+F5cPU=gm6g@mail.gmail.com>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 10:34:16AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Ensure we cannot crash if the GPIO device gets unregistered (and the
> > chip pointer set to NULL) during any of the API calls.
> >
> > To that end: wait for all users of gdev->chip to exit their read-only
> > SRCU critical sections in gpiochip_remove().
>
> > For brevity: add a guard class which can be instantiated at the top of
> > every function requiring read-only access to the chip pointer and use i=
t
> > in all API calls taking a GPIO descriptor as argument. In places where
> > we only deal with the GPIO device - use regular guard() helpers and
> > rcu_dereference() for chip access. Do the same in API calls taking a
> > const pointer to gpio_desc.
>
> ...
>
> >  static ssize_t base_show(struct device *dev,
> >                              struct device_attribute *attr, char *buf)
> >  {
> > -     const struct gpio_device *gdev =3D dev_get_drvdata(dev);
> > +     struct gpio_device *gdev =3D dev_get_drvdata(dev);
> > +     struct gpio_chip *gc;
> >
> > -     return sysfs_emit(buf, "%d\n", gdev->chip->base);
> > +     guard(srcu)(&gdev->srcu);
> > +
> > +     gc =3D rcu_dereference(gdev->chip);
> > +     if (!gc)
> > +             return -ENODEV;
> > +
> > +     return sysfs_emit(buf, "%d\n", gc->base);
>
> Similar Q as below.
>
> >  }
>
> ...
>
> >  static ssize_t label_show(struct device *dev,
> >                              struct device_attribute *attr, char *buf)
> >  {
> > -     const struct gpio_device *gdev =3D dev_get_drvdata(dev);
> > +     struct gpio_device *gdev =3D dev_get_drvdata(dev);
> > +     struct gpio_chip *gc;
> >
> > -     return sysfs_emit(buf, "%s\n", gdev->chip->label ?: "");
> > +     guard(srcu)(&gdev->srcu);
> > +
> > +     gc =3D rcu_dereference(gdev->chip);
> > +     if (!gc)
> > +             return -ENODEV;
> > +
> > +     return sysfs_emit(buf, "%s\n", gc->label ?: "");
>
> Why do you need gc label here and not gdev? In other code you switched ov=
er (in
> a patch before this in the series).
>

Yeah, good point.

> >  }
>
> >  static ssize_t ngpio_show(struct device *dev,
> >                              struct device_attribute *attr, char *buf)
> >  {
> > -     const struct gpio_device *gdev =3D dev_get_drvdata(dev);
> > +     struct gpio_device *gdev =3D dev_get_drvdata(dev);
> > +     struct gpio_chip *gc;
> >
> > -     return sysfs_emit(buf, "%u\n", gdev->chip->ngpio);
> > +     guard(srcu)(&gdev->srcu);
> > +
> > +     gc =3D rcu_dereference(gdev->chip);
> > +     if (!gc)
> > +             return -ENODEV;
> > +
> > +     return sysfs_emit(buf, "%u\n", gc->ngpio);
>
> Ditto.
>
> >  }
>
> ...
>
> >  int gpiod_get_direction(struct gpio_desc *desc)
> >  {
> > -     struct gpio_chip *gc;
> >       unsigned long flags;
> >       unsigned int offset;
> >       int ret;
> >
> > -     gc =3D gpiod_to_chip(desc);
> > +     if (!desc)
> > +             /* Sane default is INPUT. */
> > +             return 1;
>
> Hmm... I can't imagine how this value may anyhow be used / useful.
>
> > +     if (IS_ERR(desc))
> > +             return -EINVAL;
>
> With above said, can't we use one of VALIDATE_DESC*() macro here?
>

Possibly.

> ...
>
> >       list_for_each_entry_srcu(gdev, &gpio_devices, list,
> >                                srcu_read_lock_held(&gpio_devices_srcu))=
 {
>
> > +     list_for_each_entry_srcu(gdev, &gpio_devices, list,
> > +                              srcu_read_lock_held(&gpio_devices_srcu))=
 {
>
> Seems like a candidate for
>
> #define gpio_for_each_device(...) ...
>
> ...
>
> >       VALIDATE_DESC(desc);
> >
> > -     gc =3D desc->gdev->chip;
> > -     if (!gc->en_hw_timestamp) {
> > +     CLASS(gpio_chip_guard, guard)(desc);
> > +     if (!guard.gc)
> > +             return -ENODEV;
>
>
> Not sure if it would be good to have a respective VALIDATE_DESC_GUARDED()
> or so. At least it may deduplicate a few cases.
>

We could of course do it like this:

VALIDATE_DESC_GUARDED(desc, guard) where `guard` would be the name of
the guard variable but I generally dislike macros with flow-control
statements and I think this would just go too far. In fact: I'd gladly
get rid of VALIDATE_DESC() and co. altogether.

Bart

> ...
>
> > +     /* FIXME Cannot use gpio_chip_guard due to const desc. */
>
> gpio_chip_guard()
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

