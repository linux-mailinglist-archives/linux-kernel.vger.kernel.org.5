Return-Path: <linux-kernel+bounces-6949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B6819FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EBF1C21EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD62D61A;
	Wed, 20 Dec 2023 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F7tvtQqt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879A2CCB4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7bb4b7eb808so1757182241.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703078388; x=1703683188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLKg3nDYNDhgDa/lRgqaq6E+lqNB893L7oACvFRmhmE=;
        b=F7tvtQqtxq51xVFqY8PLXj334RueJYYx+d0Gxgxrg7E4u1c0/kq+3+HAQO5fq/sl7R
         evu+r5/2zJx6gUhq24Rm3APBaLB70TFr7aDflSt2r0Vlm+IrldZQ9ynY4VzETkpPTBKy
         1fdY+i4XnCYZeT1kBswwGtkawAUJytY6pDl/c0D8Rlduo7VCsFlYAyHAuHCW4YTp8sRg
         bTzHG62/QeShlKQiJF0V0hya5dvNfoZPOn2cNscS/kcY153y3TVfgT0TUtQYpDhl+hDs
         6Fbo8HIek4BKQLGhQMxEnFZr9DxJgXPAnMw1wertlTO81vVQukb9DyluCpf035upZWi6
         Jjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078388; x=1703683188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLKg3nDYNDhgDa/lRgqaq6E+lqNB893L7oACvFRmhmE=;
        b=E3EgMQ6jfVG9UyM1eQR8dr4q3eeZCVRIXJ6ccc271iz2C4Dbztzu7xX/O3XjK5Jklr
         xW2MGbe8X7DkPq+uYWiqRBwXQ9+JMdkdbMP35ooXJBjOi1n6vrzGP8IKmGsSy7yt2re9
         dykjg1hBacn0liTEkMYxXCfwPSkxij7+YEdl57n1qKcyKB41jPERSaGQpGt2EDIOscJQ
         MsqvLqDTQpafOXHRe/QeXkX4MooefpYVOO6Yi4rgGxaH4lOHlZ6QFZrQ4T70Fb4iRTL7
         kcZZBdiNrqCAlauqSFTnpTnH0xTePuNsnm+RwtCzdBCaVa523iqDGDLUvtgtLuUsbWJu
         3qFg==
X-Gm-Message-State: AOJu0YxTNklQ4tGW482UXroOcZonxOqIvW8tvFhwbljL9hGmdwdGRQJ9
	/Ub3OGZbHHeqZUzQ1enV57NXxDMAyWOk07+EykFTqA==
X-Google-Smtp-Source: AGHT+IGIB5aI0uYoJYDLFagrGqmf+3e1V03MmYT/bfRuAPMdXSWoESouyLV2hwI87r8PBgK0O/K9tpIIi+IdQm4c8Fc=
X-Received: by 2002:ac5:cdce:0:b0:4b6:daba:e9c4 with SMTP id
 u14-20020ac5cdce000000b004b6dabae9c4mr2270749vkn.18.1703078388192; Wed, 20
 Dec 2023 05:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220015106.16732-1-warthog618@gmail.com> <20231220015106.16732-5-warthog618@gmail.com>
 <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
 <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
 <ZYLaayENrvL1Nh6H@rigel> <CAMRc=MfyCBpZ07SYfxMtug6FVYiKA0MRgvjMTOAzKiVLGdPM+w@mail.gmail.com>
 <ZYLczeiVDjd2cWQF@rigel> <CAMRc=MeXa5g6iQNYF4W+vGL+kgRTyVjFB-yXE_UBpuTnn2ZKng@mail.gmail.com>
 <ZYLjuqxXylKPYeYP@rigel>
In-Reply-To: <ZYLjuqxXylKPYeYP@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Dec 2023 14:19:37 +0100
Message-ID: <CAMRc=McNMLmiUsGj8HmCqiwv-9K6EbMrmHpHMaMeFHx9BFX8gQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:53=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Dec 20, 2023 at 01:30:57PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 20, 2023 at 1:23=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > >
> > >
> > > It would be read and write guards for the gpio_device.
> > > cdev would only be using the read flavour.
> > > And possibly named something other than read/write as the purpose is =
to
> > > prevent (read) or allow (write) object removal.
> > >
> > > I though that would be clearer than having to reference gpiolib.h to =
see
> > > what gdev->sem covers, and allow you to change the locking
> > > mechanism later and not have to update cdev.
> > >
> >
> > I still prefer open-coded guards here for clarity. I hope that with
> > SRCU in gpiolib.c, we'll get rid of locking in cdev entirely anyway.
> >
>
> Ok, it is your object so I should use it the way you want it used.
>
> Btw, before I go pushing out a v2, do you have an answer on whether
> gpio_ioctl() requires a guard, as mentioned in the cover letter?
> Is the fact there is an active ioctl on the chardev sufficient in
> itself to keep the gpio_device alive?
>

AFAICT: no. I think it's a bug (good catch!). Can you extend your
series with a backportable bugfix that would come first?

Bartosz

> Cheers,
> Kent.

