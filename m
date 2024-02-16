Return-Path: <linux-kernel+bounces-68470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B140857AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC9E1F24B51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614825381B;
	Fri, 16 Feb 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vo0mxgEz"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6F15491
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080641; cv=none; b=ahZe1pt3TcyHVTE3U9Z+UPhrDpT1WTXLHA8naGIp0BTX+9B9XTwyKx6ETNp7yk5e+r6zXj7ZjK02dLWBG9SjrXyV5t8qNLfvg0Aepq8JqtJcKp9A7+JAC2z5tJ6a3HThWZXocriyCNcRAwiCvhpQCeF8KnuyJrnfuMdDCRQ6IDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080641; c=relaxed/simple;
	bh=iuium0xatJZLq1wGFl7Ka8XoxKFyhPbxq36vCpwU22U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxPX7HLNN3EloHd/U+h2uOIQbpZlZYaACLt/tx52jNtfi91/5RbF3iYeS9rgjbk5A1eF2Pl5eg4C9hQWW84WO9APqb3ZaiAchFsahCgl7gPmF/J9QTanYJ7ewcaQ2w/IrVnTefrhD9PQlmS3I3fxRkpcGSzJbLgpm9gQ1s/lr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vo0mxgEz; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2a78c49d1so952906241.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708080639; x=1708685439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR8N/L+JFBz8997qhtwpSbHWqZ61GB+2vmJxDW19Bro=;
        b=Vo0mxgEzq0EV/uLu4bKhABYUb6egwFbGoBuMqKUa2wyznc8Kt1AGHovxPlHeSFGTCw
         or4sE2sl68k7faU0AkC2E7//zAIcak6dMRuRdYOt6s7pHDMPui22/mCaYiNgCfUyfLO4
         Jb/leYnqso8QZVPlhuGwFtvNmuoan34Tde9hhWcNrgDsIDLVjCK8loSDY1Dd5y46kjJx
         Rk2aWd6HEYP+4qUgT04Ooz3fJrVqdKqX0JBIEq3glikMBeU+BQ4PgSTEHovzmJ1pQpS8
         oX9bT/WDrbWKfFxLrIZyZA0wEojuPyzftoXoMwmmPbSZunhUO1tkvTvKBSHUbOh882Ro
         RiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080639; x=1708685439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR8N/L+JFBz8997qhtwpSbHWqZ61GB+2vmJxDW19Bro=;
        b=E3rA1NJgm6HG6DL04Ly4U7IinFIKM3HOC8Jyi0FdjDB3w/NCZ9Mngd8XB/VXzeU1xw
         YGjTjg3C4KhTOwdk4rTSBEO6CjQcriQt6qVoXOr0HDDxz4lEZzrtNpStEeN+uGBtnYYr
         I7JzHw4uSlFoRoiwp7VzMavYevHwoDqgMrvSgf1kDSA/uyLcwty+5N1M4cG6RxjE/eFl
         qNra1QHlPmKtC8mMJTmcN31au4Y06r7xg9aGQPC+mbFJ+/gyk9uzN2QxTpE/qGXK4raC
         Y4SAcRwD6oUopvb9nFoCoTdyeG4kHGPdi1IkQqbYFNfJh3nfeIlpCastPkraudeergeo
         jwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRy5gKb4UaaQQCJt0pW6+o2DBwsNJbYQkB1KooO4kYPWtHXc7IGL1Ul1+rxcKvHkdTvAadFLmzifog4Uiwbd4AoQV+cURiJoMKZ1Q2
X-Gm-Message-State: AOJu0YwhSjCNN8BBPY15wzKhbd9U/txcfaCheZo6OZNBcxNy/5Q3mdlH
	8T0QSRnF85LXAQunP5gmy27wiibCkX0HTJnXAuCAxlBzmBSvna/T9utvlCS1EAJB53AAjeFsm8Y
	klLOaKAEiLAcqF4nDr1GxGC56wPFg1a8PomFONA==
X-Google-Smtp-Source: AGHT+IH0CMRnKInCHVDfBbtVQkt3Hq6Z7d0SdbEWn0kM/VW3EJFIp/Wyu9U+w+t0et4c2Lp9jHwWdNniXv34cWqsdpQ=
X-Received: by 2002:a05:6102:a4c:b0:46d:263a:31ae with SMTP id
 i12-20020a0561020a4c00b0046d263a31aemr4432834vss.1.1708080638794; Fri, 16 Feb
 2024 02:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084419.6194-1-brgl@bgdev.pl> <CGME20240216103104eucas1p1fac9b939d4af1648d222963fbef59645@eucas1p1.samsung.com>
 <20240214084419.6194-3-brgl@bgdev.pl> <179caa10-5f86-4707-8bb0-fe1b316326d6@samsung.com>
In-Reply-To: <179caa10-5f86-4707-8bb0-fe1b316326d6@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Feb 2024 11:50:27 +0100
Message-ID: <CAMRc=McQkywJOM23SpLp1-c_zwV1HiOL_JLoQWPi96FqWKqoxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: cdev: use correct pointer accessors with SRCU
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:31=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>

[snip]

>
> Here 'gc' is left uninitialized and nukes if GPIO DEBUGs are enabled.
> Here is an example (captured on today's linux-next):
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000 when read
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240216 #8096
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at gpiolib_cdev_register+0xd4/0x170
> LR is at chainhash_table+0x784/0x20000
> pc : [<c05dbe54>]    lr : [<c18bb74c>]    psr: 20000013
> ...
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000404a  DAC: 00000051
> Register r0 information: non-slab/vmalloc memory
> Register r1 information: NULL pointer
> Register r2 information: non-paged memory
> Register r3 information: non-paged memory
> Register r4 information: slab kmalloc-1k start c1e5f800 pointer offset 0
> size 1024
> Register r5 information: NULL pointer
> Register r6 information: non-paged memory
> Register r7 information: slab kmalloc-1k start c1e5f800 pointer offset
> 952 size 1024
> Register r8 information: NULL pointer
> Register r9 information: slab kmalloc-1k start c1e5f800 pointer offset
> 960 size 1024
> Register r10 information: non-paged memory
> Register r11 information: non-slab/vmalloc memory
> Register r12 information: NULL pointer
> Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
> Stack: (0xf082db90 to 0xf082e000)
> ...
>   gpiolib_cdev_register from gpiochip_setup_dev+0x44/0xb0
>   gpiochip_setup_dev from gpiochip_add_data_with_key+0x9ac/0xaac
>   gpiochip_add_data_with_key from devm_gpiochip_add_data_with_key+0x20/0x=
5c
>   devm_gpiochip_add_data_with_key from samsung_pinctrl_probe+0x938/0xb18
>   samsung_pinctrl_probe from platform_probe+0x5c/0xb8
>   platform_probe from really_probe+0xe0/0x400
>   really_probe from __driver_probe_device+0x9c/0x1f4
>   __driver_probe_device from driver_probe_device+0x30/0xc0
>   driver_probe_device from __device_attach_driver+0xa8/0x120
>   __device_attach_driver from bus_for_each_drv+0x80/0xcc
>   bus_for_each_drv from __device_attach+0xac/0x1fc
>   __device_attach from bus_probe_device+0x8c/0x90
>   bus_probe_device from device_add+0x5d4/0x7fc
>   device_add from of_platform_device_create_pdata+0x94/0xc4
>   of_platform_device_create_pdata from of_platform_bus_create+0x1f8/0x4c0
>   of_platform_bus_create from of_platform_bus_create+0x268/0x4c0
>   of_platform_bus_create from of_platform_populate+0x80/0x110
>   of_platform_populate from of_platform_default_populate_init+0xd4/0xec
>   of_platform_default_populate_init from do_one_initcall+0x64/0x2fc
>   do_one_initcall from kernel_init_freeable+0x1c4/0x228
>   kernel_init_freeable from kernel_init+0x1c/0x12c
>   kernel_init from ret_from_fork+0x14/0x28
> Exception stack(0xf082dfb0 to 0xf082dff8)
> ...
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
> ---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b ]---
>
>
> Probably the easiest way to fix this issue is to replace chip_dbg with
> the following dev_dbg() call:
>
> dev_dbg(&gdev->dev, "(%s): added GPIO chardev (%d:%d)\n", gdev->label,
> MAJOR(devt), gdev->id);
>

Thanks for the report. Surprisingly there are no warnings about that
with GCC. The best way is to use srcu_dereference() here and keep the
same log message. Patch is on the way.

Bart

