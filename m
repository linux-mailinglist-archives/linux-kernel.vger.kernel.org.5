Return-Path: <linux-kernel+bounces-46434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B717D843F98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E1E1F27991
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E779DA6;
	Wed, 31 Jan 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FgMX/PEu"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C279DB8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705119; cv=none; b=EUglfaZeIHbjgpau2iAyJgQ5WcrhXlO/vp7oIT09QIgiojSXCoF1YGQuJN2aqq1D2GnklF3AO8YHo/C/7HivEhD+G76sWd2GNWXZfxzONiWjiSo+ynFbWPOWyqXqIgOcpkNzwAAaa9gGWUr4SLOucxGE4Nu3sBG9JttD7op8pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705119; c=relaxed/simple;
	bh=JvT2NdKQLE8kMFn2um/s/5WgbQE44fj55jbDbzRrnJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F40DnH599JP8N6FsfgGKhDkfMtGe1of0CeuJs0T/8+plIiVq9ZN+Cu2KVD/qH/o44V9ISu7iSg2sBkzDuv/PVjp3gxbOEnJPs7a5Mrj+egNCSmFXk9yIDe06ivPfP76uiANbSgX20X30/kLfrMUJq/QsNjEv/TLVKyDYD7d2L1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FgMX/PEu; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4bdb534410dso1511378e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706705115; x=1707309915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu6tOfa/GVf6jT5tQI9SLjYoktX1wEq4XKI7Jrqqb3s=;
        b=FgMX/PEu07lpABw9/AAyBfxPzaMHAK5Ph0QBYj/2Nz7UcegJq/pA68tacnM+VkIsv5
         T3XgIuzF0psXlK9hrohnOnL4W5VyZkOO2Gt3Lx/6raZJKhzhdX5HsrZkq4W4KuxuBMj6
         x2dgK9VRSL0dWUgGt57UUecoIO++MnaZeuFpqgfM1l7j0wWGQhgqwaBLsy4RlJsgusef
         XLRUoILRFjNKhYlTtHEBxhb1zs5s0Uu33i9GQgzPANXjpdyAOdDpSmA1n8ZyMVHNfuEn
         m0Uhgs0Fcp0c5CwYkNAgH3IzKUC9l4Rpf9F0n8450taHkjOP/Dc4IgRTOYR6OB7UBMxL
         rRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705115; x=1707309915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hu6tOfa/GVf6jT5tQI9SLjYoktX1wEq4XKI7Jrqqb3s=;
        b=H8mmt/QkHPg6LAWQsDPDgGNCJE5bfFmbY9DlDv9gpKCE9phdp/9jFBYV87avLxjFtz
         /UrXKtaR8XjLqTgjO4AhrHn+HE1sAgNOBrt1YC+NiCAFmcqrWhyR2BCVHx/Vg8YXPjCG
         qtRHH9ldqKPCD12z9/Idj5jaT4zD0GyYPBAPAuuTy2q+pKWhJwQtCEOjzMRLUWtZ/wvE
         hMHaLeze2+jLsj1JOw+B1LAn7dI/SUjcxASwxxcRIe3l6ESNFQFjKCOozhRs3ZmN3lUV
         6lxOeiuX6RAJA2YrNOIvOBDMcO+exEqM2oiUMDOjzzDu+0xR3d5llKSR7r3Z74H7Du1n
         8qCg==
X-Gm-Message-State: AOJu0YwtFaepSZhYgIxOko3ELRQxFnajoQ7jq820X4xGixPfyMFzs8WD
	t8l2dcDdqSKvQoY6BEWfQ1ugGoplvu8bjNsqmaXnQNLpv//01wunKBYBxd9xjtPxdjwHVa2oOkr
	tlZ/uctdyBvR9Mak1OMWuwmHapyzvzglZgguXDw==
X-Google-Smtp-Source: AGHT+IG6H2GDneLVN9Y4F4b4s26bWJxMKpqJGxfvgsRm8MGQL/kxHxGknZicmEbhAgTs4bg8lICcpqp5d+BTm/L3R6A=
X-Received: by 2002:a05:6122:448b:b0:4b6:cc19:42dc with SMTP id
 cz11-20020a056122448b00b004b6cc1942dcmr1342614vkb.11.1706705115490; Wed, 31
 Jan 2024 04:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-2-brgl@bgdev.pl> <202401311746.be3dlVTg-lkp@intel.com>
In-Reply-To: <202401311746.be3dlVTg-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jan 2024 13:45:04 +0100
Message-ID: <CAMRc=MdRJ_mNM-NteVnBCB=xMwrkSQb+b7SZOWVx0yp7dMqqiw@mail.gmail.com>
Subject: Re: [PATCH 01/22] gpio: protect the list of GPIO devices with SRCU
To: kernel test robot <lkp@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, oe-kbuild-all@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:37=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on brgl/gpio/for-next]
> [also build test WARNING on linus/master v6.8-rc2 next-20240131]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gp=
io/for-next
> patch link:    https://lore.kernel.org/r/20240130124828.14678-2-brgl%40bg=
dev.pl
> patch subject: [PATCH 01/22] gpio: protect the list of GPIO devices with =
SRCU
> config: i386-randconfig-141-20240131 (https://download.01.org/0day-ci/arc=
hive/20240131/202401311746.be3dlVTg-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009=
708b4367171ccdbf4b5905cb6a803753fe18)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401311746.be3dlVTg-lkp=
@intel.com/
>
> New smatch warnings:
> drivers/gpio/gpiolib.c:4167 gpiod_find_and_request() error: uninitialized=
 symbol 'ret'.
> drivers/gpio/gpiolib.c:4181 gpiod_find_and_request() error: uninitialized=
 symbol 'desc'.
>
> Old smatch warnings:
> drivers/gpio/gpiolib.c:4184 gpiod_find_and_request() error: uninitialized=
 symbol 'desc'.
>
> vim +/ret +4167 drivers/gpio/gpiolib.c
>
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4128
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4129  static struct gpio_=
desc *gpiod_find_and_request(struct device *consumer,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4130                     =
                       struct fwnode_handle *fwnode,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4131                     =
                       const char *con_id,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4132                     =
                       unsigned int idx,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4133                     =
                       enum gpiod_flags flags,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4134                     =
                       const char *label,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4135                     =
                       bool platform_lookup_allowed)
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4136  {
> ba2dc1cb5491712 Hans de Goede       2022-12-29  4137    unsigned long loo=
kupflags =3D GPIO_LOOKUP_FLAGS_DEFAULT;
> c122f461ccac0e7 Andy Shevchenko     2023-03-09  4138    struct gpio_desc =
*desc;
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4139    int ret;
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4140
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4141    scoped_guard(srcu=
, &gpio_devices_srcu) {
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4142            desc =3D =
gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4143                     =
                   &flags, &lookupflags);
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4144            if (gpiod=
_not_found(desc) && platform_lookup_allowed) {
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4145                    /=
*
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4146                     =
* Either we are not using DT or ACPI, or their lookup
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4147                     =
* did not return a result. In that case, use platform
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4148                     =
* lookup as a fallback.
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4149                     =
*/
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4150                    d=
ev_dbg(consumer,
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4151                     =
       "using lookup tables for GPIO lookup\n");
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4152                    d=
esc =3D gpiod_find(consumer, con_id, idx, &lookupflags);
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4153            }
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4154
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4155            if (IS_ER=
R(desc)) {
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4156                    d=
ev_dbg(consumer, "No GPIO consumer %s found\n",
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4157                     =
       con_id);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4158                    r=
eturn desc;
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4159            }
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4160
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4161            /*
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4162             * If a c=
onnection label was passed use that, else attempt to use
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4163             * the de=
vice name as label
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4164             */
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4165            ret =3D g=
piod_request(desc, label);
> 1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4166    }
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11 @4167    if (ret) {
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4168            if (!(ret=
 =3D=3D -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4169                    r=
eturn ERR_PTR(ret);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4170
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4171            /*
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4172             * This h=
appens when there are several consumers for
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4173             * the sa=
me GPIO line: we just return here without
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4174             * furthe=
r initialization. It is a bit of a hack.
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4175             * This i=
s necessary to support fixed regulators.
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4176             *
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4177             * FIXME:=
 Make this more sane and safe.
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4178             */
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4179            dev_info(=
consumer,
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4180                     =
"nonexclusive access to GPIO for %s\n", con_id);
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11 @4181            return de=
sc;
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4182    }
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4183
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4184    ret =3D gpiod_con=
figure_flags(desc, con_id, lookupflags, flags);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4185    if (ret < 0) {
> 8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4186            dev_dbg(c=
onsumer, "setup of GPIO %s failed\n", con_id);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4187            gpiod_put=
(desc);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4188            return ER=
R_PTR(ret);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4189    }
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4190
> 9ce4ed5b4db1363 Bartosz Golaszewski 2023-08-21  4191    gpiod_line_state_=
notify(desc, GPIOLINE_CHANGED_REQUESTED);
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4192
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4193    return desc;
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4194  }
> 0eadd36d9123745 Dmitry Torokhov     2022-09-03  4195
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

This is a false-positive coming from the fact the scoped_guard() is
implemented as a for loop. I will initialize the variables anyway to
make smatch happy.

Bart

