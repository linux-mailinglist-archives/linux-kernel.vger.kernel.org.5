Return-Path: <linux-kernel+bounces-46136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8917843B19
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE31C1C27BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76176994F;
	Wed, 31 Jan 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i8WjLTk7"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9164CE1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693313; cv=none; b=nCSX0pUabMK3cH8HmGJRYBkdOyc/b1+qiFfC8jWb6dmahFKaNSaMH7CGiZldLgHOC5+wrZinUbu8whqkcfZIVGU7MDjtmN1Q8T7l8x9xGIeENAwghmFPZqdtjoGKt0ZOEXyfwAzWKLERN5cDVIiEKp2skXjLXsENKdWQcOylYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693313; c=relaxed/simple;
	bh=FC5xdhnJGoAdXnu0/oBoMG6Hf+djGxGJPffV4ZFCblw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze30qBzfxE6d+hv9Z0KKPrk9Yr3gvrZ2yVbI9KHjwAfToaN12mckHNIsObxksJF4o5QWrYThBsGK7ECjMMNct5Bdm3H4AGPNjMFg8pLa9FMy/Nq5IplVXM8ZUH1CIuZrnEiFBq3xzCJXsifSiiXihav+U/uFPmuqsj/3YPe+qwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i8WjLTk7; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4bdc8cdd6a2so1163526e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706693310; x=1707298110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g0UEGb1j6kRPGl0np2JmoiDWle2L3UrNOVKmxqKYTI=;
        b=i8WjLTk7AzsjOyitqSD6TqinV/NehfHk6YHM2rkaPIvhTcvjdfxaSlQR7Su4ERbPzw
         2dkWOQm8DvwlYvh08DYPFYs81skd5LQzs/MHmACh3c6RI79EQ2KtVR5uXJCp7/26kEDy
         6XxdgioGtcTdQnVuGL1MSrTd/3enjo3nf6wClbULDPWHrO3MLgrgn7JbFXvdhn6SHvO9
         BxeYEMtZyRAedvMHobFFML1CuqgL87TYqBlW1VZSZNqZD1Vbwe3Hdkk+bh89uqq2uLoJ
         nkT61lSwfr3hL82UBo/ubKIRjOuolt23Vkb215Q9+csDp+ZKnY5bhlG0j32uFrJFbJ0Q
         03fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693310; x=1707298110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g0UEGb1j6kRPGl0np2JmoiDWle2L3UrNOVKmxqKYTI=;
        b=SarpkJm+fosBP6PDr81c9Xxtx1gFrf7Ycrz95E0EjleO6B8IGEh/unQMrrzLvIAfC1
         WZOXSN673+Kwsu0nm9fTQUUm55M7Pol4X+raAuj8ywB7uiTIvwN3F4onWO+yAagI50Ea
         hg5nMJa01it6lu08H5iSsfeAyY027kgukYoJ8s5X9oZg10MqXPbuFxwYjp+iV+JPCzHW
         JqvEAzeSBDcuyNq/XeknyGO4lh2aVQV43nJmTjeif1nL1ZP4DUTM1fSgI56W97Pck0ZE
         ucyunfwUhGepzYcYbpWhoi+izgUTy+6BZdjuhbJaMj9Sq84oR89xo0nuOhcE0IILgM7G
         CaDA==
X-Gm-Message-State: AOJu0YwiCZaswurgRxkGKmgCQdE1ly08ZBXJAJBHTm22tQwH5yMnRF7J
	qDtvCZQJ8Vtjn3l6IuDaU/dF67wsxmQfQeujzTGURX5BUOXrqsGeYkAjgqBuwmuh4qes/V15ymi
	RvxfNk/H4dSSgU/gaAUDvc8Ay4G316X5IijeGXw==
X-Google-Smtp-Source: AGHT+IFRpRsC/pRT6oO9/2sSABkMtS8g0uPaPDBYtrCJDor0MaEQW0Ve502S0lhbp9xE5TTyi5+SnRxPS7BehE4Qn/I=
X-Received: by 2002:ac5:c84e:0:b0:4bd:7e5e:380 with SMTP id
 g14-20020ac5c84e000000b004bd7e5e0380mr613527vkm.15.1706693310476; Wed, 31 Jan
 2024 01:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-21-brgl@bgdev.pl> <202401311050.YNdm98Hv-lkp@intel.com>
 <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com> <fa273f23-320a-465d-a403-523424d98e3d@paulmck-laptop>
In-Reply-To: <fa273f23-320a-465d-a403-523424d98e3d@paulmck-laptop>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jan 2024 10:28:19 +0100
Message-ID: <CAMRc=MdoG1Ku-hbBWt7Jc+d4=ANfshPWwW3C_G-e2GdyggqG1w@mail.gmail.com>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: paulmck@kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, oe-kbuild-all@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:24=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Jan 31, 2024 at 10:02:40AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Jan 31, 2024 at 3:21=E2=80=AFAM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Bartosz,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on brgl/gpio/for-next]
> > > [also build test WARNING on linus/master v6.8-rc2 next-20240130]
> > > [If your patch is applied to the wrong git tree, kindly drop us a not=
e.
> > > And when submitting patch, we suggest to use '--base' as documented i=
n
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golasz=
ewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.gi=
t gpio/for-next
> > > patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl=
%40bgdev.pl
> > > patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip i=
n gpio_device with SRCU
> > > config: x86_64-randconfig-122-20240131 (https://download.01.org/0day-=
ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.YNdm98Hv=
-lkp@intel.com/
> > >
> > > sparse warnings: (new ones prefixed by >>)
> > > >> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible types =
in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip [nodere=
f] __rcu *
> > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible types =
in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip [nodere=
f] __rcu *
> > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatible types=
 in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip [noder=
ef] __rcu *
> > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatible types=
 in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip [noder=
ef] __rcu *
> > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatible types=
 in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip [noder=
ef] __rcu *
> > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatible types=
 in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip [noder=
ef] __rcu *
> > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatible types=
 in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip [noder=
ef] __rcu *
> > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatible types=
 in comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip [noder=
ef] __rcu *
> > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip *
> > >    drivers/gpio/gpiolib.c: note: in included file:
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types i=
n comparison expression (different address spaces):
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef=
] __rcu *
> > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >
> > > vim +444 drivers/gpio/gpiolib.c
> > >
> > >    422
> > >    423  /*
> > >    424   * Convert a GPIO name to its descriptor
> > >    425   * Note that there is no guarantee that GPIO names are global=
ly unique!
> > >    426   * Hence this function will return, if it exists, a reference=
 to the first GPIO
> > >    427   * line found that matches the given name.
> > >    428   */
> > >    429  static struct gpio_desc *gpio_name_to_desc(const char * const=
 name)
> > >    430  {
> > >    431          struct gpio_device *gdev;
> > >    432          struct gpio_desc *desc;
> > >    433          struct gpio_chip *gc;
> > >    434
> > >    435          if (!name)
> > >    436                  return NULL;
> > >    437
> > >    438          guard(srcu)(&gpio_devices_srcu);
> > >    439
> > >    440          list_for_each_entry_srcu(gdev, &gpio_devices, list,
> > >    441                                   srcu_read_lock_held(&gpio_de=
vices_srcu)) {
> > >    442                  guard(srcu)(&gdev->srcu);
> > >    443
> > >  > 444                  gc =3D rcu_dereference(gdev->chip);
> > >    445                  if (!gc)
> > >    446                          continue;
> > >    447
> > >    448                  for_each_gpio_desc(gc, desc) {
> > >    449                          if (desc->name && !strcmp(desc->name,=
 name))
> > >    450                                  return desc;
> > >    451                  }
> > >    452          }
> > >    453
> > >    454          return NULL;
> > >    455  }
> > >    456
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> >
> > Paul,
> >
> > Should I care about these warnings? They seem to be emitted for a lot
> > of RCU code already upstream. I'm not even sure how I'd go about
> > addressing them honestly.
>
> This is maintainer's choice.
>
> The fix would be to apply __rcu to the definition of ->chip.  The benefit
> is that it finds bugs where rcu-protected pointers are used without RCU
> primitives and vice versa.
>
>                                                         Thanx, Paul

Ah, good point. I marked the other RCU-protected fields like
descriptor label but forgot this one.

It also seems like I need to use __rcu for all function arguments
taking an RCU-protected pointer as argument?

Bart

