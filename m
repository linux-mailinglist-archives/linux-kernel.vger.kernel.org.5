Return-Path: <linux-kernel+bounces-61283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3B851051
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A4F1F21006
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C4017BD9;
	Mon, 12 Feb 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LDQgL30y"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47803101D0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732467; cv=none; b=JYSVYLjYTR4QAVqdbjWilbepT4YtHyEqD+tzusnz3m4vbtKotmYl03S2jkiInKstj4gTRm/iSNJiPKeMaIDajhTVtWNmR3OYAU38eYmLSlW+cr4kEzCgS1xUloNUBw5tow0RknJVvCL6WoQd3TTWuJaXx/oME1N+r293ozJzYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732467; c=relaxed/simple;
	bh=Q8Lxu9tV9aXFcm1oLI9+PjiVqInZMOqP7l6kK+X6RWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmel486eolt9PHPjyutSLaThqICw+WHE+D1o9VoN+32YE6iGsUVV6gtX2UyEipErjMFys7+XSuTt1Y+fPSBFnTkkLFeBg8MzzQ3D+ySHvKuKklmCAzxDzMkLRVECB0HJAuJ1wpwp9cb/6gNs68PDR10CSBq6qEFMA6kq6OgRzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LDQgL30y; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso1613780241.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707732465; x=1708337265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S4vGIv810yvXWj2059W7h60ZZAKMmVJlo0rZHlIBx8=;
        b=LDQgL30yeZHfTA6FW2p61pgTVsGXluTbCtePEiqBdDMHOx4i12tr22xyhvo/SduMU3
         0X9iQH524n38r6aZRIto7+gq8L0QPVy6PQpzhgbzwjEBmONJdIRG/jIer7Iej2ZyPKu5
         P4ScVXcNopQo9TqFCg+M+K/V1com8hTYx6YqvkgFLigSXPLf75iW4hotWkZ9oMdkHhSJ
         ncJC36ZMac8tpCreDzC3AwVnXp3/34OkKT84ejXGypJuxNmap3u+G2PePazai+R1Ba70
         kMt0NMQK7Vj4bQmFzlPRMdSbJeMX4Chtx/zIGTXaLPFf5Q6e0e08+85+AZI1C9p/CW7x
         kQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732465; x=1708337265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7S4vGIv810yvXWj2059W7h60ZZAKMmVJlo0rZHlIBx8=;
        b=O0Il1aoOcHAkJSDs2dtnjXu4QzwFk2dh9SZJ0u5EQ28IHBMyEn6vQTJbZa1ul38Bwn
         jFgndNeqvLhecZESnkJbKqbsT/9dJMjOYpFTsD/VJs6ECuCC8bmPdkdaUyzemThbBqU1
         K8NolYLd7/n3PsGw/mEUen+uEhRA3gs4HyLrjiTD2RERYmTuA+nqVr4hfIKaL2LtGOwc
         XtpHFoKuzCmysORiV1G7Z7ozoo3KYTdcq19Pr0/i9MlL9ldC74/K322laKPd9DmOpPlx
         FEp2wynfjQaNqB9XI8bmNLF56vtDQ8fcSuHyvrV0rmS/bjkz2QrUp3ahz6LaGd3xb/Np
         9YLg==
X-Gm-Message-State: AOJu0Yy3Qn9OPx17Ku5K96oEAcJ4Mj9XL0/FgPXNBbGUA/2AoW6lg7K+
	ave1mHsKmmAFX+aj1tJSuqtsy2OrFJ+jy2EWynKV70mD/tQhOKVUP3T6stggyIfBr352CIWkkcS
	ybeIduTl1fvE8gRofJ+z3syGQ1tjGqZyROy3vdw==
X-Google-Smtp-Source: AGHT+IFcfpIE+7JzP+78iqSZvH30GzKxIbq838Nj/PNZsslW4chhizgbrAcICwMf7wnTHkGLjPAy8D7PbCeIkgxUdck=
X-Received: by 2002:a05:6102:2a51:b0:46d:546d:91a6 with SMTP id
 gt17-20020a0561022a5100b0046d546d91a6mr4210525vsb.17.1707732465082; Mon, 12
 Feb 2024 02:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl>
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 11:07:34 +0100
Message-ID: <CAMRc=MdtwLRHG67khVgLeH3JXjqqSr8Pgg74oZPPwZhnYp=yXA@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] gpio: rework locking and object life-time control
To: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This is a big rework of locking in GPIOLIB. The current serialization is
> pretty much useless. There is one big spinlock (gpio_lock) that "protects=
"
> both the GPIO device list, GPIO descriptor access and who knows what else=
.
>
> I'm putting "protects" in quotes as in several places the lock is
> taken, released whenever a sleeping function is called and re-taken
> without regards for the "protected" state that may have changed.
>
> First a little background on what we're dealing with in GPIOLIB. We have
> consumer API functions that can be called from any context explicitly
> (get/set value, set direction) as well as many others which will get
> called in atomic context implicitly (e.g. set config called in certain
> situations from gpiod_direction_output()).
>
> On the other side: we have GPIO provider drivers whose callbacks may or
> may not sleep depending on the underlying protocol.
>
> This makes any attempts at serialization quite complex. We typically
> cannot use sleeping locks - we may be called from atomic - but we also
> often cannot use spinlocks - provider callbacks may sleep. Moreover: we
> have close ties with the interrupt and pinctrl subsystems, often either
> calling into them or getting called from them. They use their own locking
> schemes which are at odds with ours (pinctrl uses mutexes, the interrupt
> subsystem can call GPIO helpers with spinlock taken).
>
> There is also another significant issue: the GPIO device object contains
> a pointer to gpio_chip which is the implementation of the GPIO provider.
> This object can be removed at any point - as GPIOLIB officially supports
> hotplugging with all the dynamic expanders that we provide drivers for -
> and leave the GPIO API callbacks with a suddenly NULL pointer. This is
> a problem that allowed user-space processes to easily crash the kernel
> until we patched it with a read-write semaphore in the user-space facing
> code (but the problem still exists for in-kernel users). This was
> recognized before as evidenced by the implementation of validate_desc()
> but without proper serialization, simple checking for a NULL pointer is
> pointless and we do need a generic solution for that issue as well.
>
> If we want to get it right - the more lockless we go, the better. This is
> why SRCU seems to be the right candidate for the mechanism to use. In fac=
t
> it's the only mechanism we can use our read-only critical sections to be
> called from atomic and protecc contexts as well as call driver callbacks
> that may sleep (for the latter case).
>
> We're going to use it in three places: to protect the global list of GPIO
> devices, to ensure consistency when dereferencing the chip pointer in GPI=
O
> device struct and finally to ensure that users can access GPIO descriptor=
s
> and always see a consistent state.
>
> We do NOT serialize all API callbacks. This means that provider callbacks
> may be called simultaneously and GPIO drivers need to provide their own
> locking if needed. This is on purpose. First: we only support exclusive
> GPIO usage* so there's no risk of two drivers getting in each other's way
> over the same GPIO. Second: with this series, we ensure enough consistenc=
y
> to limit the chance of drivers or user-space users crashing the kernel.
> With additional improvements in handling the flags field in GPIO
> descriptors there's very little to gain, while bitbanging drivers may car=
e
> about the increased performance of going lockless.
>
> This series brings in one somewhat significant functional change for
> in-kernel users, namely: GPIO API calls, for which the underlying GPIO
> chip is gone, will no longer return 0 and emit a log message but instead
> will return -ENODEV.
>
> I know this is a lot of code to go through but the more eyes we get on it
> the better.
>
> Thanks,
> Bartosz
>
> * - This is not technically true. We do provide the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag. However this is just another piece of
> technical debt. This is a hack provided for a single use-case in the
> regulator framework which got out of control and is now used in many
> places that should have never touched it. It's utterly broken and doesn't
> even provide any contract as to what a "shared GPIO" is. I would argue
> that it's the next thing we should address by providing "reference counte=
d
> GPIO enable", not just a flag allowing to request the same GPIO twice
> and then allow two drivers to fight over who toggles it as is the case
> now. For now, let's just treat users of GPIOD_FLAGS_BIT_NONEXCLUSIVE like
> they're consciously and deliberately choosing to risk undefined behavior.
>
> v2 -> v3:
> - fix SRCU cleanup in error path
> - add a comment explaining the use of gpio_device_find() in sysfs code
> - don't needlessly dereference gdev->chip in sysfs code
> - don't return 1 (INPUT) for NULL descriptors from gpiod_get_direction(),
>   rather: return -EINVAL
> - fix debugfs code: take the SRCU read lock in .start() and release it in
>   .stop() callbacks for seq file instead of taking it locally which
>   doesn't protect the entire seq printout
> - move the removal of the GPIO device from the list before setting the
>   chip pointer to NULL
>
> v1 -> v2:
> - fix jumping over variable initialization in sysfs code
> - fix RCU-related sparse warnings
> - fix a smatch complaint about uninitialized variables (even though it's
>   a false positive coming from the fact that scoped_guard() is implemente=
d
>   as a for loop
> - fix a potential NULL-pointer dereference in debugfs callbacks
> - improve commit messages
>
> Bartosz Golaszewski (24):
>   gpio: protect the list of GPIO devices with SRCU
>   gpio: of: assign and read the hog pointer atomically
>   gpio: remove unused logging helpers
>   gpio: provide and use gpiod_get_label()
>   gpio: don't set label from irq helpers
>   gpio: add SRCU infrastructure to struct gpio_desc
>   gpio: protect the descriptor label with SRCU
>   gpio: sysfs: use gpio_device_find() to iterate over existing devices
>   gpio: remove gpio_lock
>   gpio: reinforce desc->flags handling
>   gpio: remove unneeded code from gpio_device_get_desc()
>   gpio: sysfs: extend the critical section for unregistering sysfs
>     devices
>   gpio: sysfs: pass the GPIO device - not chip - to sysfs callbacks
>   gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
>   gpio: cdev: don't access gdev->chip if it's not needed
>   gpio: sysfs: don't access gdev->chip if it's not needed
>   gpio: don't dereference gdev->chip in gpiochip_setup_dev()
>   gpio: reduce the functionality of validate_desc()
>   gpio: remove unnecessary checks from gpiod_to_chip()
>   gpio: add the can_sleep flag to struct gpio_device
>   gpio: add SRCU infrastructure to struct gpio_device
>   gpio: protect the pointer to gpio_chip in gpio_device with SRCU
>   gpio: remove the RW semaphore from the GPIO device
>   gpio: mark unsafe gpio_chip manipulators as deprecated
>
>  drivers/gpio/gpiolib-cdev.c  |  92 ++--
>  drivers/gpio/gpiolib-of.c    |   4 +-
>  drivers/gpio/gpiolib-sysfs.c | 151 ++++---
>  drivers/gpio/gpiolib.c       | 791 +++++++++++++++++++----------------
>  drivers/gpio/gpiolib.h       |  86 ++--
>  5 files changed, 635 insertions(+), 489 deletions(-)
>
> --
> 2.40.1
>

Applied the series. I'll let it spend some time in next and let's fix
any remaining issues in tree.

Bart

