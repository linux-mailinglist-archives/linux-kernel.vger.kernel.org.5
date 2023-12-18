Return-Path: <linux-kernel+bounces-3925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D49817531
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6573B20C92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2B3A1C8;
	Mon, 18 Dec 2023 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UgXwgnhH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CFF37892
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7cbae9f2ec2so455135241.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702913178; x=1703517978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xaDeK/PoBnrxIIjdxxTFCG3wOaxUdKwJy1bkIygpH0=;
        b=UgXwgnhHjQ1KLHs/whbkk0jmEBJAdt6E/hiHrjyhm2w+rDXNf2UPijMYN9zjJNbpvo
         4syME3s/0J01EJPBGJYRTKmSp2FGKlNEGaDbqVWy2cypbAPjnCW7wpEpAFLAhya+a6Gm
         mIS4FYJKgogcjgxW07/kTLeLyN2A3pY/EPZkfF+Kg6eY2yEgJkzb+z+cN3ECiaRr21nW
         c7hkDiFr1IFuXjv/Sv68VFeG7xw2qIf11jmt70CRji0hyhtHQMhxpAH4mDi7u/x1MV2l
         vOtRmbOPxb6gTI0MygRXr0H+7ZDgCKtmHGmx2xy1I+dxlXy1NzE/GqVA4q0MkLqrLy1V
         1T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913178; x=1703517978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xaDeK/PoBnrxIIjdxxTFCG3wOaxUdKwJy1bkIygpH0=;
        b=tovdVGGfGNU0ioOvChl6luvzymhIegBnhBmX19/67+220rih4MU5jAXxTIxjr4t67R
         kfkwChvx7mvsurrmALfODMuIXm66lVZn0TGdp1Vbl3pPYaa7v8Vdno654+Os5nhOc/Ie
         6hJCBpJT1IKkC2CudVW9E42gqcTyafHXDD8thT1CZTC0yaNso789vm+FcdYoC7Ltk//R
         RvHLvN1mup6WNRf3nuRk4x99bBwSMyLALDmYHixhlOt10aSWrGW29wV/drcyFqJYVlQl
         RDbgUDVMavwW57W5dCaTcV/qlZzR7b/I58Q1d/uHU6NinYTSY0HtIA88VkWMfdsK9Nkv
         j5kw==
X-Gm-Message-State: AOJu0YwdZFJlZEAxRgIyyBUsuDDoi7Kokt4Ra2PwQHEIZICH4MmVXoZw
	MU8q17pWgQq68cLYiMh3p/wsaNyk+TqpZHFrQZQcpw==
X-Google-Smtp-Source: AGHT+IH/dqoCrsaMQS1f5C49AdG1IJDWk8Oe/y+606m58VvjjQEUrubdVCWAY1TqxuAo3RCGiqL+veDeLR0ELFPrGfw=
X-Received: by 2002:a05:6122:2507:b0:4b3:207c:178f with SMTP id
 cl7-20020a056122250700b004b3207c178fmr12161598vkb.28.1702913178154; Mon, 18
 Dec 2023 07:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216001652.56276-1-warthog618@gmail.com>
In-Reply-To: <20231216001652.56276-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 16:26:07 +0100
Message-ID: <CAMRc=MdwRc8Ff5kL5rpLO9ZJHuqYcJ77LgtRab3f-M7HSC+QiQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] gpiolib: cdev: relocate debounce_period_us
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 1:17=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> This series contains minor improvements to gpiolib-cdev.
>
> The banner change is relocating the debounce_period_us from gpiolib's
> struct gpio_desc to cdev's struct line.  Patch 1 stores the field
> locally in cdev.  Patch 2 removes the now unused field from gpiolib.
>
> Patch 3 is somewhat related and removes a FIXME from
> gpio_desc_to_lineinfo().  The FIXME relates to a race condition in
> the calculation of the used flag, but I would assert that from
> the userspace perspective the read operation itself is inherently racy.
> The line being reported as unused in the info provides no guarantee -
> it just an indicator that requesting the line is likely to succeed -
> assuming the line is not otherwise requested in the meantime.
> Given the overall operation is racy, trying to stamp out an unlikely
> race within the operation is pointless. Accept it as a possibility
> that has negligible side-effects and reduce the number of locks held
> simultaneously and the duration that the gpio_lock is held.
>
> Patches 1 and 3 introduce usage of guard() and scoped_guard() to cdev.
> Patch 4 replaces any remaining discrete lock/unlock calls around
> critical sections with guard() or scoped_guard().
>
> Patch 5 is unrelated to debounce or info, but addresses Andy's
> recent lamentation that the linereq get/set values functions are
> confusing and under documented.
> Figured I may as well add that while I was in there.
>
> Changes v3 -> v4:
>  (changes other than using --histogram are to patch 1)
>  - use --histogram to generate patches.
>  - include cleanup.h.
>  - make supinfo_lock static.
>  - immediately return from supinfo_to_lineinfo() if line not found.
>
> Changes v2 -> v3:
>  - reorder patches to move full adoption of guard()/scoped_guard() to
>    patch 4.
>  - use guard() rather than scoped_guard() where the scope extends to the
>    end of the function.
>  - split supinfo into supinfo_tree and supinfo_lock (patch 1).
>  - rename flags to dflags in gpio_desc_to_lineinfo() (patch 3).
>
> Changes v1 -> v2:
>  (changes are to patch 2 unless otherwise noted)
>  - adopt scoped_guard() for critical sections, inserting patch 1 and
>    updating patch 2 and 4.
>  - move rb_node field to beginning of struct line.
>  - merge struct supinfo into supinfo var declaration.
>  - move rb_tree field to beginning of struct supinfo.
>  - replace pr_warn() with WARN().
>  - drop explicit int to bool conversion in line_is_supplemental().
>  - use continue to bypass cleanup in linereq_free().
>  - fix typo in commit message (patch 4)
>
> Kent Gibson (5):
>   gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
>   gpiolib: remove debounce_period_us from struct gpio_desc
>   gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
>   gpiolib: cdev: fully adopt guard() and scoped_guard()
>   gpiolib: cdev: improve documentation of get/set values
>
>  drivers/gpio/gpiolib-cdev.c | 391 +++++++++++++++++++++++-------------
>  drivers/gpio/gpiolib.c      |   3 -
>  drivers/gpio/gpiolib.h      |   5 -
>  3 files changed, 246 insertions(+), 153 deletions(-)
>
> --
> 2.39.2
>

I just have two minor nits for patch 1/5, other than that it's ready to go.

Bart

