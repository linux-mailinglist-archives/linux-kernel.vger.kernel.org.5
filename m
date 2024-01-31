Return-Path: <linux-kernel+bounces-46198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6A843C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC31C26543
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09856996E;
	Wed, 31 Jan 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CDSxs8Pm"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705867E90
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696255; cv=none; b=ses1MhQdXtqShNs4Qwi7riIh745TfiDqZIxf3lQsbcnrKneNvCvkTaHzWNVWin1DwDgAlqZjhUfPIS5+wWydv3+NiNQ+Go9gBJ8tQwY9f/HX2fGU3MA7G7gVQaFzkBRSjPPdpJVln/hEWtDxzJpX42/YHcOmPKVIBOEdf1oyf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696255; c=relaxed/simple;
	bh=VgGzRevp8IhhklBtyUF8ignQStZHL0ycmC9MorDjQ48=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plikFy4l3/nTNnWgGXQWxa68mF+m8ALOBmRAPlCIHQx9VvaDMBsLEIvM45SYk2iS0JwZR7LpLYKcpBesTF/U/0N5K+UAvSNb0AsSsB+9i6ytEF6rcW+zuPQC9stm3h7OewM4m0l9Rvg2qsUA3YqaiIQztpU6ZjmdUuVpB/dD/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CDSxs8Pm; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4bd80b41cbdso963138e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706696251; x=1707301051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D32TZC3lUkaAD5YyuqcFW+U9jWCIfQVLeGJUQig1qfg=;
        b=CDSxs8Pmf5x5NyjxzFN12n/NIAH4QnPx9al/Vl712WNBgoo90OHNq5R3JZjEPLLJyG
         FFPd4L+qxFoVpxrMSulgONIFAle0JVSTnZGD1BWcZF8Oh5BM0s6NP3L8h6lSSjfO0uGO
         63gGxdLo81pLkwfimnu6AKqnTD98b1c88zQ+S32XRErWNObUGvtx2+SeqWgcfNr/Bib7
         PzKkLs0wsRwA1dpOeGWqddafZ7fn9CfYUz4RxzGEAwxjkaiXF961KVzzU6n7FnBUURk5
         u1XWc8c+CHCWRBqKWj2RejQY0Ypnjq2aHWWe0LtCAgEcE+SVu+ChVno4nvyNMRdgcyRB
         8VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696251; x=1707301051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D32TZC3lUkaAD5YyuqcFW+U9jWCIfQVLeGJUQig1qfg=;
        b=oGeViqSptcSUV0EwCUCOeLWr536WDs6xt0Gj64jJoCiadCsDIH9jIeKtQI2cTjCQ1U
         FmUdvK1Z9+gDSmOMspIJX4eKVnn7LS5dy9ixKAdAXgKgURqq0YVKuCmqUBEX+PiK2LNL
         PG6/dSEYhnRAlG7Thy5Qk12ZwMmGtqSxGRQa38Nd6s+6VjzBqHa89ri4Z3HyxX5f5PRu
         35CzelKJK9O00mHqCU7ecj3th5vL/2JPZ+lQO9ZH9m87E6+T/pTYw7zq6L5gPkZH9sp3
         oNadRAIBSnmARmeI0//wJBtLqbFiIgYBoDe/z16E/0xyXUDyuwJfPd5RtbHH/+Z01yH/
         woPQ==
X-Gm-Message-State: AOJu0Yy0mmW9K4lGzvreX7/Z4hjsG57rUJJ8HywKTAn/RciAzJdE6KBW
	wrjLNX9HA8Oex42Ba5cLlYNj9twrnOvj/FpHpM+2593o4k2+8rzBiW35D2Eh3Ib8Yoo46AameTQ
	uvpD0KFueoMLRtyPe6YXo6dYnHPFyI6muHziT3Q==
X-Google-Smtp-Source: AGHT+IG5IHeBikOQE+iHNZvtv8PheKYGxnuGC7yeh30wlUSe5Bk2xPhqgSxVgv1RRotZp4uo7cKkzFrx7QrXvdNj0PU=
X-Received: by 2002:a05:6122:4495:b0:4b6:f254:b21a with SMTP id
 cz21-20020a056122449500b004b6f254b21amr1074412vkb.4.1706696250839; Wed, 31
 Jan 2024 02:17:30 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 31 Jan 2024 02:17:30 -0800
From: brgl@bgdev.pl
In-Reply-To: <26942a3c-efc9-4344-9fac-c5feea06639c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-21-brgl@bgdev.pl> <202401311050.YNdm98Hv-lkp@intel.com>
 <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com>
 <fa273f23-320a-465d-a403-523424d98e3d@paulmck-laptop> <CAMRc=MdoG1Ku-hbBWt7Jc+d4=ANfshPWwW3C_G-e2GdyggqG1w@mail.gmail.com>
 <26942a3c-efc9-4344-9fac-c5feea06639c@paulmck-laptop>
Date: Wed, 31 Jan 2024 02:17:30 -0800
Message-ID: <CAMRc=MdYbGH8Q0Wk_40RV=_HN86oYg146bz-TeYp1KKwSoEhGw@mail.gmail.com>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: paulmck@kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, oe-kbuild-all@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 10:42:20 +0100, "Paul E. McKenney"
<paulmck@kernel.org> said:
> On Wed, Jan 31, 2024 at 10:28:19AM +0100, Bartosz Golaszewski wrote:
>> On Wed, Jan 31, 2024 at 10:24=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
>> >
>> > On Wed, Jan 31, 2024 at 10:02:40AM +0100, Bartosz Golaszewski wrote:
>> > > On Wed, Jan 31, 2024 at 3:21=E2=80=AFAM kernel test robot <lkp@intel=
com> wrote:
>> > > >
>> > > > Hi Bartosz,
>> > > >
>> > > > kernel test robot noticed the following build warnings:
>> > > >
>> > > > [auto build test WARNING on brgl/gpio/for-next]
>> > > > [also build test WARNING on linus/master v6.8-rc2 next-20240130]
>> > > > [If your patch is applied to the wrong git tree, kindly drop us a =
note.
>> > > > And when submitting patch, we suggest to use '--base' as documente=
d in
>> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
>> > > >
>> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Gol=
aszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
>> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux=
git gpio/for-next
>> > > > patch link:    https://lore.kernel.org/r/20240130124828.14678-21-b=
rgl%40bgdev.pl
>> > > > patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chi=
p in gpio_device with SRCU
>> > > > config: x86_64-randconfig-122-20240131 (https://download.01.org/0d=
ay-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
>> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-c=
i/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)
>> > > >
>> > > > If you fix the issue in a separate patch/commit (i.e. not just a n=
ew version of
>> > > > the same patch/commit), kindly add following tags
>> > > > | Reported-by: kernel test robot <lkp@intel.com>
>> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.YNdm9=
8Hv-lkp@intel.com/
>> > > >
>> > > > sparse warnings: (new ones prefixed by >>)
>> > > > >> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible typ=
es in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip [nod=
eref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible typ=
es in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip [nod=
eref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatible ty=
pes in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip [no=
deref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatible ty=
pes in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip [no=
deref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatible ty=
pes in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip [no=
deref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatible ty=
pes in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip [no=
deref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatible ty=
pes in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip [no=
deref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatible ty=
pes in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip [no=
deref] __rcu *
>> > > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip *
>> > > >    drivers/gpio/gpiolib.c: note: in included file:
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible type=
s in comparison expression (different address spaces):
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [node=
ref] __rcu *
>> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> > > >
>> > > > vim +444 drivers/gpio/gpiolib.c
>> > > >
>> > > >    422
>> > > >    423  /*
>> > > >    424   * Convert a GPIO name to its descriptor
>> > > >    425   * Note that there is no guarantee that GPIO names are glo=
bally unique!
>> > > >    426   * Hence this function will return, if it exists, a refere=
nce to the first GPIO
>> > > >    427   * line found that matches the given name.
>> > > >    428   */
>> > > >    429  static struct gpio_desc *gpio_name_to_desc(const char * co=
nst name)
>> > > >    430  {
>> > > >    431          struct gpio_device *gdev;
>> > > >    432          struct gpio_desc *desc;
>> > > >    433          struct gpio_chip *gc;
>> > > >    434
>> > > >    435          if (!name)
>> > > >    436                  return NULL;
>> > > >    437
>> > > >    438          guard(srcu)(&gpio_devices_srcu);
>> > > >    439
>> > > >    440          list_for_each_entry_srcu(gdev, &gpio_devices, list=
,
>> > > >    441                                   srcu_read_lock_held(&gpio=
_devices_srcu)) {
>> > > >    442                  guard(srcu)(&gdev->srcu);
>> > > >    443
>> > > >  > 444                  gc =3D rcu_dereference(gdev->chip);
>> > > >    445                  if (!gc)
>> > > >    446                          continue;
>> > > >    447
>> > > >    448                  for_each_gpio_desc(gc, desc) {
>> > > >    449                          if (desc->name && !strcmp(desc->na=
me, name))
>> > > >    450                                  return desc;
>> > > >    451                  }
>> > > >    452          }
>> > > >    453
>> > > >    454          return NULL;
>> > > >    455  }
>> > > >    456
>> > > >
>> > > > --
>> > > > 0-DAY CI Kernel Test Service
>> > > > https://github.com/intel/lkp-tests/wiki
>> > >
>> > > Paul,
>> > >
>> > > Should I care about these warnings? They seem to be emitted for a lo=
t
>> > > of RCU code already upstream. I'm not even sure how I'd go about
>> > > addressing them honestly.
>> >
>> > This is maintainer's choice.
>> >
>> > The fix would be to apply __rcu to the definition of ->chip.  The bene=
fit
>> > is that it finds bugs where rcu-protected pointers are used without RC=
U
>> > primitives and vice versa.
>>
>> Ah, good point. I marked the other RCU-protected fields like
>> descriptor label but forgot this one.
>>
>> It also seems like I need to use __rcu for all function arguments
>> taking an RCU-protected pointer as argument?
>
> Not if that argument gets its value from rcu_dereference(), which is
> the usual pattern.
>
> And if you are passing an RCU-protected pointer to a function *before*
> passing it through rcu_dereference(), I would have some questions for you=
.
>
> Or are you instead passing a pointer to an RCU-protected pointer as an
> argument to your functions?
>
>                                                         Thanx, Paul
>

No, I'm not. Thanks for making it clear. With the following changes to the
series, the warnings are now gone:

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 6a421309319e..15349f92d0ec 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -762,7 +762,7 @@ EXPORT_SYMBOL_GPL(gpiod_unexport);

 int gpiochip_sysfs_register(struct gpio_device *gdev)
 {
-	struct gpio_chip *chip =3D gdev->chip;
+	struct gpio_chip *chip;
 	struct device *parent;
 	struct device *dev;

@@ -775,6 +775,12 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	if (!class_is_registered(&gpio_class))
 		return 0;

+	guard(srcu)(&gdev->srcu);
+
+	chip =3D rcu_dereference(gdev->chip);
+	if (!chip)
+		return -ENODEV;
+
 	/*
 	 * For sysfs backward compatibility we need to preserve this
 	 * preferred parenting to the gpio_chip parent field, if set.
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7ecdd8cc39c5..ea0675514891 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -221,7 +221,7 @@ struct gpio_chip *gpiod_to_chip(const struct
gpio_desc *desc)
 {
 	if (!desc)
 		return NULL;
-	return desc->gdev->chip;
+	return rcu_dereference(desc->gdev->chip);
 }
 EXPORT_SYMBOL_GPL(gpiod_to_chip);

@@ -291,7 +291,7 @@ EXPORT_SYMBOL(gpio_device_get_label);
  */
 struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
 {
-	return gdev->chip;
+	return rcu_dereference(gdev->chip);
 }
 EXPORT_SYMBOL_GPL(gpio_device_get_chip);

@@ -742,7 +742,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 		goto err_remove_device;

 	dev_dbg(&gdev->dev, "registered GPIOs %d to %d on %s\n", gdev->base,
-		gdev->base + gdev->ngpio - 1, gdev->chip->label ? : "generic");
+		gdev->base + gdev->ngpio - 1, gdev->label);

 	return 0;

@@ -866,7 +866,7 @@ int gpiochip_add_data_with_key(struct gpio_chip
*gc, void *data,
 		return -ENOMEM;
 	gdev->dev.bus =3D &gpio_bus_type;
 	gdev->dev.parent =3D gc->parent;
-	WRITE_ONCE(gdev->chip, gc);
+	rcu_assign_pointer(gdev->chip, gc);

 	gc->gpiodev =3D gdev;
 	gpiochip_set_data(gc, data);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index c76acb8f95c6..07443d26cbca 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -59,7 +59,7 @@ struct gpio_device {
 	int			id;
 	struct device		*mockdev;
 	struct module		*owner;
-	struct gpio_chip	*chip;
+	struct gpio_chip __rcu	*chip;
 	struct gpio_desc	*descs;
 	int			base;
 	u16			ngpio;

Bartosz

