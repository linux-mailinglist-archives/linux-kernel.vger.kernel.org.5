Return-Path: <linux-kernel+bounces-66372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF143855BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9759B27A21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C35DF71;
	Thu, 15 Feb 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NULNKYuk"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3BDF60
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983006; cv=none; b=YVpc3EOqo7elgb/j3lY0IvGOhE2fbkhmElBaiOzXAq1YZsjBRcWNx1lRC2Xf6NnVdCBgEMoAHMFytbFdWnjzACNqvD8m+ZO87/S4yk2KinYnqKMA0p6iJ4h7LHrpiaSgz+r52pckT1nsgQntuV0siswbcQRnfKP2fogtIHJTDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983006; c=relaxed/simple;
	bh=1GC9VqIWhiSRxtUcWVADNEdH2G76UGuZGDCpIDa4tcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvqWsAeliEvbcxnHD4efOQbXpVw6rWz3pwMf/saX+tBkniM7kE4P2LmGOqGMGherAldhmP3QPv88zy1SYdyS5sjDmDXfuEoPRUBXIeluJY/xWXCMp8k2h1zP147JkdxmQVjoBmdr5x2LOmY5qKpMeYfJxrbDPGQvsKqXG16LXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NULNKYuk; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c02af5c0b6so165616e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707983004; x=1708587804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMzjwIO6yG2evoOg4dltVs3/JJncrUwa/CfXUItLCKs=;
        b=NULNKYukre9M8E3MmFZ1KqHAv2iw79LyPmUzhkzQ8DJnsNgaYbXtwyFBDf6YCMBeMm
         CD2+mCfFIveu75aquXTsCSY1/tB+eJuNIOeBO/HKr0QAHd8oF44fo4zonrSQQhGFN8CE
         RK+GMZ3mhFUtTmW8xDKsPssawecWnDdfUgBPGPuBgUMpKhW2gMJ9lldHsonxFQUcrlxW
         WtubDWFhK0ZgerQCIbeuBWg1hYoXCkP2TTgT/oj7nwcg1ezEgrxxu/RSOEfw5A62QRt+
         JvMQ5Kca/hx9YKIl9S/o+/KB39B41OEit5zxQ1ozZz/jYK/BK3NnrC4GkZGlr1OFb+0R
         Pelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707983004; x=1708587804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMzjwIO6yG2evoOg4dltVs3/JJncrUwa/CfXUItLCKs=;
        b=N97cCWgTxjjOEOd5xBR6QVKeLrKhMhfFsHnm8e6hORpjBm4Te92ehmaM+3RO7Xy6ec
         QyCABqv4bzyR/NV9OwydRIQEATm0u6MsR7dBZVJEc115Uq87JcJmhszIzPdLBE7sPOoa
         D1iUkxs/srqLJWXkPpcotBFzG+cQHhXjhCfQGKR14YI4GiO5DivvLRkds1zx339lWuc5
         EdjtQhvORiTWucOLYHrBisx570bqU/9a7vMiJXVOvzy8kAWUljH/siwZ5CqWTWHgp73y
         sVs1g86rG370SzuWfAgTt1ydBhQtSofpBQlCVDZ/GcljvvDPAX3vyNNdwsaGBI6D8hsE
         DIFw==
X-Forwarded-Encrypted: i=1; AJvYcCV04qQ/d8ZGdCl6gpY2UJBGe9pwdtpV4OptTicIT8u3cF6M++2VxdBOc2Vvd0xSqr5wIkqc3FH7tbMSaIS7FB+uIBq+P73YnbhymmkE
X-Gm-Message-State: AOJu0YznxXl/6ZlZQOEpR08fuvLa0TIc6d1eAiWxbngezhwFBo4jugCr
	zEmqjyKI057Sf9Mom1r41/ShwlzGfu8lqf7Kj5fO5tCNvdATSkQVDJHkuWmva+tkWyFHTpFGv5L
	Kw+293/n3BUnG65BTbbWDqBPhzRg84ALnhk3prw==
X-Google-Smtp-Source: AGHT+IG0H1Tagebz+SK8qM5qdu5e0CshYF9JMzD7Xda9FigfxB+aBABQyZg4L3nmpjZvrdJHid2ZlQeosmbnF1rZyuY=
X-Received: by 2002:a1f:ccc4:0:b0:4c0:23bd:1f0d with SMTP id
 c187-20020a1fccc4000000b004c023bd1f0dmr666750vkg.15.1707983004377; Wed, 14
 Feb 2024 23:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084419.6194-1-brgl@bgdev.pl>
In-Reply-To: <20240214084419.6194-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 15 Feb 2024 08:43:13 +0100
Message-ID: <CAMRc=McYPmic91NtRpbS5fn2UC4SG9Pw1JUANZ0ffNCYLOww+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
To: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:44=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Here are four fixes to some bugs in recent SRCU changes. The first one fi=
xes
> an actual race condition. The other three just make lockdep happy.
>
> v1 -> v2:
> - use srcu_dereference() instead of rcu_dereference_protected() as
>   advised by Paul
> - add a patch using rcu_dereference_check(..., 1) in deprecated
>   interfaces that return the address of the RCU-protected chip structure
>   to external users (who shouldn't use it anyway but well...)
> - pick up review tags for patches 1/4 and 2/4
>
> Bartosz Golaszewski (4):
>   gpio: take the SRCU read lock in gpiod_hog()
>   gpio: cdev: use correct pointer accessors with SRCU
>   gpio: use srcu_dereference() with SRCU-protected pointers
>   gpio: don't let lockdep complain about inherently dangerous RCU usage
>
>  drivers/gpio/gpiolib-cdev.c  | 25 ++++++++++++-------------
>  drivers/gpio/gpiolib-sysfs.c |  5 +++--
>  drivers/gpio/gpiolib.c       | 32 ++++++++++++++++++--------------
>  drivers/gpio/gpiolib.h       |  3 ++-
>  4 files changed, 35 insertions(+), 30 deletions(-)
>
> --
> 2.40.1
>

Series queued.

Bart

