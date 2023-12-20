Return-Path: <linux-kernel+bounces-6895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C800819F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DF5287214
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD90D24B21;
	Wed, 20 Dec 2023 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qqcydmI4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2324B25
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-466afcc2e5dso365514137.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703075468; x=1703680268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smv/oTS6xzj2r1xVgNmv4h0iEnVC3n6WF5A+ikrNt/U=;
        b=qqcydmI4AeK9JjTT59wwwUv467Aph67TCM/HqMnUKZ2Jd3NZcElq/bi6nke5N+jObw
         9M1OhE2JE1eQgXM1dbUIrfcfPTh0ftsJJWw/0aUkb/wwB4SkD8T+uTgpA0COB7Ux02Do
         Eeld/tFTPSeBqUAgHEaFRE13DsT7SXW1IQFOtCAMzPP0UbkvsnRAIE9tEMSM9CDrW2Ux
         tifFLgL+qQu1caQoQ6gdm1gdyPxcKlanyAfHMbVKGK2HqnRhuaX2MvUmp/Pxp172VkDz
         cxJgRu87bb9DpFZ9Kl4B9YXXh5K++U4VZ8Hy+QZewReSuZyfyy7noLuuNhr2u9D3c5Np
         hTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703075468; x=1703680268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Smv/oTS6xzj2r1xVgNmv4h0iEnVC3n6WF5A+ikrNt/U=;
        b=mw9vplYZM1RqKeLGI68/kotU01RdQ6lk9S1EHx6ZDOPR6c5P8bSYemxTqUiKSLiHZs
         vCH9yZfucDjBo8tRjgZra5WGsMLL2Zeuu+Ls5x5In10dJJL5q+LsfUMAAZmZrAZLlYb8
         NJOY5fz9hftK5/HxVWGHwUzDrCiE+PRQsqj+V/mtB5IIjxGHTB0fMXxYobmNbUI5jX2q
         zi6tdbvI6y1krFx4gfph/BKdCkSViuKBm2Mq3K+2aBEutZdBz/mpguJnFOL1kdwd/KKA
         oEKp7jghJ+umYR/tV9DA2oaOIUxZrHBop6V4FRZU8latSx0JzOizdDIe7jlc5x/B3Iti
         t8/Q==
X-Gm-Message-State: AOJu0Yw2OI4hH86Rvl8b+Pt8j9F7t5Lb+vkg1H5DGZcS+Mp3SRc1UQ+1
	+e64KVQEQdnVCTwUUC+bg8/Hyet57otki0/Rfrb+AQ==
X-Google-Smtp-Source: AGHT+IH2DZCGTlQXI5cZ4QPy8WihDWRKCqB7n5/TtStgkQgUvn/KoP2I/HQCJExUS8Hn1x0yzv7IgjuEs7AoVmXQEVI=
X-Received: by 2002:a05:6102:559e:b0:466:a1a2:55a4 with SMTP id
 dc30-20020a056102559e00b00466a1a255a4mr3179934vsb.9.1703075468746; Wed, 20
 Dec 2023 04:31:08 -0800 (PST)
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
 <ZYLczeiVDjd2cWQF@rigel>
In-Reply-To: <ZYLczeiVDjd2cWQF@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Dec 2023 13:30:57 +0100
Message-ID: <CAMRc=MeXa5g6iQNYF4W+vGL+kgRTyVjFB-yXE_UBpuTnn2ZKng@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:23=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Dec 20, 2023 at 01:16:00PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 20, 2023 at 1:13=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 01:05:35PM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Dec 20, 2023 at 12:56=E2=80=AFPM Linus Walleij <linus.walle=
ij@linaro.org> wrote:
> > > > >
> > > > > (+PeterZ)
> > > > >
> > > > > On Wed, Dec 20, 2023 at 2:52=E2=80=AFAM Kent Gibson <warthog618@g=
mail.com> wrote:
> > > > >
> > > > > > Replace the wrapping functions that inhibit removal of the gpio=
_device
> > > > > > with equivalent guard macros.
> > > > > >
> > > > > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > > > (...)
> > > > > > +DEFINE_CLASS(_read_sem_guard,
> > > > > > +            struct rw_semaphore *,
> > > > > > +            up_read(_T),
> > > > > > +            ({
> > > > > > +               down_read(sem);
> > > > > > +               sem;
> > > > > > +            }),
> > > > > > +            struct rw_semaphore *sem);
> > > > >
> > > > > Isn't this so generic that it should be in <linux/cleanup.h>?
> > > > >
> > > > > Otherwise all the patches look good to me.
> > > > >
> > > >
> > > > We already have this:
> > > >
> > > > DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_r=
ead(_T))
> > > > DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up=
_write(_T))
> > > >
> > > > DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
> > > > DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
> > > >
> > >
> > > Ah - in rwsem.h - I missed that.
> > >
> > > > This can surely be used here, right?
> > > >
> > >
> > > Don't see why not.
> > >
> > > I would still like to move the gpio_device specific macros to gpiolib=
.h,
> > > as they apply to the struct gpio_device defined there.
> >
> > Which ones? Because I'd rather use guard(rwsem_read)(&gdev->sem); than
> > some custom wrapper as this one's purpose is clearer.
> >
>
> It would be read and write guards for the gpio_device.
> cdev would only be using the read flavour.
> And possibly named something other than read/write as the purpose is to
> prevent (read) or allow (write) object removal.
>
> I though that would be clearer than having to reference gpiolib.h to see
> what gdev->sem covers, and allow you to change the locking
> mechanism later and not have to update cdev.
>

I still prefer open-coded guards here for clarity. I hope that with
SRCU in gpiolib.c, we'll get rid of locking in cdev entirely anyway.

Bart

> Cheers,
> Kent.
>

