Return-Path: <linux-kernel+bounces-63482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF9853036
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94711F26A38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A539FDA;
	Tue, 13 Feb 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VLdxOGll"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A836AFD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826131; cv=none; b=OLixJpyxvIcojvVnBGIdaks85q/tpYXeNjG+a88Y/NC5dH9veZkl9j2Ejiogmz3fF6l+PgFAqnEXeA7SfyLbKuuLHRl9gDjVzR3FO8vw3CXwZjyONrUkTLSDNwn7FBmxuLpTGk4VdCscXpiEPxlWZ7wWGZmv1pagLHV1b0AP4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826131; c=relaxed/simple;
	bh=RD2gOE43WjYVxdi1ngCyfW/4evEA9UOVCJgWZA9RArA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkdop5+/uKpYoefUIk9DKJKcKsZlrNqHxhuQa1JqqOvGf8vWL0BILcL5gUOYATV2PwD8O+IQ4YOQk4SBE3eewZSqbOO2slYupnLBwEdFR7eKvyFueXlFFa+JW1DELM6XfAyNR+NNACVSPJz/Z4b+sP5SZtABnYzMRxSv7cMbR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VLdxOGll; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c02bdc2892so2180938e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707826128; x=1708430928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD2gOE43WjYVxdi1ngCyfW/4evEA9UOVCJgWZA9RArA=;
        b=VLdxOGll2aXINr6xr0F90BKX8l56IcVS7Rtxl0Lk91kxpM8gccBgLH0vx3s4NNtszF
         lsdTX28Iqmcv+HsCQ1aEJQzbS2uByIHP3v5rf6di84+BqrEbjSZzGhtKS3kuzYMNxUv7
         iHm6NQ0clQzjH7xvNV7mLv8002zC4fRdAXXWJwb0dKkQBMzNRHv1Z5zOiL/B7e6HPHPl
         vbYNUnYxBOOvzrp1f4pNMd29GmH2Ri7k1hB3jpYnezJdoAKPpTz1Yv3ixeatKLlvJG68
         ATDatEpUmRq8uSwZ/oMW+uqKjz4DkCcUn0f9I/BhNXsKZ/+YrTITOASh+hVwfMth/hCn
         Tusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826128; x=1708430928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD2gOE43WjYVxdi1ngCyfW/4evEA9UOVCJgWZA9RArA=;
        b=sabI+u9h/lEnmjFMtN19mTGj3/YRLCfz1V58qxr41M2BhD//pzWU0thiMjgs9X7sQt
         CWPScdt+jcYhXgfmn1doyQbTxlsAnrdCwuNKQ4nsyanhFC+AG2gdI/UcaWgb3r/QKyGW
         PYdVz3u6mAFMHxtxl3GMX4xRsBdfA1GhD2GMJeKlzVDjAw2ptpzELUoeLqFzuX/IMQ8w
         2Kc0pRZ1Vkt4f4dD6RzM2f/0n1Sfo0Etx2InZ2lMZFRqxgCx7uVUaIwfqqCoPJWJaumy
         UM4S1A5EFKrnVo087g+2Lb2Z+fY0/RrZF8A7sca85M012bIHnwFVYn6bvNV/i7X/aeRc
         +P9g==
X-Gm-Message-State: AOJu0YzrwgNWJlamByh4N6+KVArFMI7ej5XfrQTV9jq7h0I03Iy+elPn
	MlBM8b2f43mj+i8H3zKRJZbbGdbLS97WMP/mGAKL6NVHXTxvwJe1MwtstM8Bf+A3dMW0inQOm8E
	Gzt/H0QyUQK2U4+J7VeP9hWtjRmvA6pbY0ZgBfg==
X-Google-Smtp-Source: AGHT+IGlnW4jJFYXgcuBWKQX+kpeByQrzmcNz+1+GaJF6Zm0adomc/SghGDfF//5mW2qfRM2I1XGer2HTXyrIynQ7ck=
X-Received: by 2002:a1f:6281:0:b0:4bd:54d0:e6df with SMTP id
 w123-20020a1f6281000000b004bd54d0e6dfmr1945875vkb.1.1707826128494; Tue, 13
 Feb 2024 04:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240213120518eucas1p2d514aac6e6d1e29bbae05f32db6724db@eucas1p2.samsung.com>
 <20240208095920.8035-1-brgl@bgdev.pl> <a8dddd27-f361-4e0d-be6f-7d6684007acd@samsung.com>
In-Reply-To: <a8dddd27-f361-4e0d-be6f-7d6684007acd@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 Feb 2024 13:08:37 +0100
Message-ID: <CAMRc=MeNiTGWh2f4iivvR75F4TpmuNa-xExc4G7HssWS5Tch1w@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] gpio: rework locking and object life-time control
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:05=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 08.02.2024 10:58, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This is a big rework of locking in GPIOLIB. The current serialization i=
s
> > pretty much useless. There is one big spinlock (gpio_lock) that "protec=
ts"
> > both the GPIO device list, GPIO descriptor access and who knows what el=
se.
> >
> > I'm putting "protects" in quotes as in several places the lock is
> > taken, released whenever a sleeping function is called and re-taken
> > without regards for the "protected" state that may have changed.
> >
> > First a little background on what we're dealing with in GPIOLIB. We hav=
e
> > consumer API functions that can be called from any context explicitly
> > (get/set value, set direction) as well as many others which will get
> > called in atomic context implicitly (e.g. set config called in certain
> > situations from gpiod_direction_output()).
> >
> > On the other side: we have GPIO provider drivers whose callbacks may or
> > may not sleep depending on the underlying protocol.
> >
> > This makes any attempts at serialization quite complex. We typically
> > cannot use sleeping locks - we may be called from atomic - but we also
> > often cannot use spinlocks - provider callbacks may sleep. Moreover: we
> > have close ties with the interrupt and pinctrl subsystems, often either
> > calling into them or getting called from them. They use their own locki=
ng
> > schemes which are at odds with ours (pinctrl uses mutexes, the interrup=
t
> > subsystem can call GPIO helpers with spinlock taken).
> >
> > There is also another significant issue: the GPIO device object contain=
s
> > a pointer to gpio_chip which is the implementation of the GPIO provider=
.
> > This object can be removed at any point - as GPIOLIB officially support=
s
> > hotplugging with all the dynamic expanders that we provide drivers for =
-
> > and leave the GPIO API callbacks with a suddenly NULL pointer. This is
> > a problem that allowed user-space processes to easily crash the kernel
> > until we patched it with a read-write semaphore in the user-space facin=
g
> > code (but the problem still exists for in-kernel users). This was
> > recognized before as evidenced by the implementation of validate_desc()
> > but without proper serialization, simple checking for a NULL pointer is
> > pointless and we do need a generic solution for that issue as well.
> >
> > If we want to get it right - the more lockless we go, the better. This =
is
> > why SRCU seems to be the right candidate for the mechanism to use. In f=
act
> > it's the only mechanism we can use our read-only critical sections to b=
e
> > called from atomic and protecc contexts as well as call driver callback=
s
> > that may sleep (for the latter case).
> >
> > We're going to use it in three places: to protect the global list of GP=
IO
> > devices, to ensure consistency when dereferencing the chip pointer in G=
PIO
> > device struct and finally to ensure that users can access GPIO descript=
ors
> > and always see a consistent state.
> >
> > We do NOT serialize all API callbacks. This means that provider callbac=
ks
> > may be called simultaneously and GPIO drivers need to provide their own
> > locking if needed. This is on purpose. First: we only support exclusive
> > GPIO usage* so there's no risk of two drivers getting in each other's w=
ay
> > over the same GPIO. Second: with this series, we ensure enough consiste=
ncy
> > to limit the chance of drivers or user-space users crashing the kernel.
> > With additional improvements in handling the flags field in GPIO
> > descriptors there's very little to gain, while bitbanging drivers may c=
are
> > about the increased performance of going lockless.
> >
> > This series brings in one somewhat significant functional change for
> > in-kernel users, namely: GPIO API calls, for which the underlying GPIO
> > chip is gone, will no longer return 0 and emit a log message but instea=
d
> > will return -ENODEV.
> >
> > I know this is a lot of code to go through but the more eyes we get on =
it
> > the better.
>
> I've noticed that this patchset landed in today's linux-next. It causes
> a lots of warning during boot on my test boards when LOCKDEP is enabled
> in kernel configs. Do you want me to report all of them? Some can be
> easily reproduced even with QEMU's virt ARM and ARM64 machines.
>

Marek,

Thanks for the report. I've already sent out patches that fix these
problems. Sorry for this.

Bartosz

[snip]

