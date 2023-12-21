Return-Path: <linux-kernel+bounces-8953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E981BE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D028374F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370164AAD;
	Thu, 21 Dec 2023 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ouzU/g0P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C065191
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4668c57cec8so128200137.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703184627; x=1703789427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOmKqIn6W7z+rgmBQ78sMx0aZEwQC8hdhsv42OVTCrs=;
        b=ouzU/g0PxDkJObI+xeDj58zkEPfto/ASbdxyXGldGSCuKwhSwJSbwHRZxalWbDgsDs
         LaV3SGtZSIPducWBbu0ujdGbkO9sX12Egxx+Q3ivEorOuGvj5QWD2tuMn8ZyimgHCnRJ
         MXqaTCGoDnu0l3XyuBwIbsymCr99GXHXrx3PBfy45WzSBE7K0OM80tn7UbqWcdcwg0jY
         /FskD8FoOTRaSGPoRJqTguorTSMx4vC9IR/zUYbtOwSSawRouyly6VaeWJGH9iSRzdzG
         +ICPRzL1cc9127QqGp16tGmbNKd7Nu+FkvmRmh6Mvk4KI9OgNSBZaFzovZ4NnuDxnpnu
         A7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184627; x=1703789427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOmKqIn6W7z+rgmBQ78sMx0aZEwQC8hdhsv42OVTCrs=;
        b=Lh/sZZ+7qS/9Cuwic72hMMlP/H3Ulg5FoT222mFSkIxxN4Q0e83QB9CewZnqpI3Jt4
         E+YB6bsNidSpZz2iq5eq5o6gcgSag/rxbv09wRKY7FA2iSjMggKRd0gGdZtYD5+f9R7B
         v5CBKWkKSsfL1nJIIhI+TfEsDf2m3THHqfEuO1qYU6gBbMDdng+iFDwzPQY9hmFAR2Tz
         Q+ZceHV4GLvRlKuEkc6X8Nc/6Tv/AvGFSue8zek6ncD3aFh2He8h1yewkVpp/DNcLhoH
         MRzZXInFE+sgk3iDklj7OQRy7eBjvFLkUlMiH+W9V3gjIHkqPkxcKsGyjI/FhQgDu6va
         xXyg==
X-Gm-Message-State: AOJu0YwzS/Cmc5S+Sz6TUgQLeoP/OFi4CfH3Eldy8Nd5hwo2dtYFs/QM
	bZ4H+p1KOQICo3cNTakvZj2Uv7/pDby8czFeP2YE/7POG7lbsw==
X-Google-Smtp-Source: AGHT+IGB9eH7AqDU9cHm9AMj/Tnxr1XNb7gPtn0K/98iDGAeQAx28mz/pD0u9r/6+qM8Ad3mQZA1iaPVZnKh8XVHcWM=
X-Received: by 2002:a1f:72cd:0:b0:4b6:c299:4a8f with SMTP id
 n196-20020a1f72cd000000b004b6c2994a8fmr75309vkc.5.1703184627299; Thu, 21 Dec
 2023 10:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl> <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
 <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
 <CAMRc=MfLXxfzhKDc9e3jRF9mdVo=9UnC9O+i9s-uGm2pEa7vMg@mail.gmail.com>
 <ZYQ09RIq1R8xmn_k@smile.fi.intel.com> <CAMRc=MfYG09UUfqfuE89Or4HsP8QWUBJXCvuPPhe+vx0JiZF4w@mail.gmail.com>
 <ZYRkLfYnU3WZEWPa@smile.fi.intel.com>
In-Reply-To: <ZYRkLfYnU3WZEWPa@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 21 Dec 2023 19:50:16 +0100
Message-ID: <CAMRc=MfFRZJUT_Cq=x73gj71x2PFFrV1x9GL+PiEOX_KxQZkiQ@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 5:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 21, 2023 at 02:00:39PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 21, 2023 at 1:52=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Dec 21, 2023 at 10:26:03AM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Dec 20, 2023 at 4:28=E2=80=AFPM Linus Walleij <linus.wallei=
j@linaro.org> wrote:
>
> ...
>
> > > > Defining DEBUG makes sense to
> > > > enable dev_dbg() messages.
> > >
> > > Exactly!
> > >
> > > > CONFIG_DEBUG_GPIO is used by one driver
> > >
> > > By all drivers which are using pr_debug() / dev_dbg().
> > > I am using it a lot in my development process (actually I have it ena=
bled
> > > in all my kernel configurations).
> >
> > I'm not saying we should remove it. It'll stay defined in the Makefile
> > and remain seamless for debug messages. I just want to get rid of that
> > ugly extra_checks variable which has very little impact.
>
> I agree that extra_checks is unusual (or as Linus put it "non-standard")
> thingy. And I agree that removal is for good.
>
> My question here solely about that WARN_ON(). Do we need it always be ena=
bled
> or not?
>

I think it makes sense. If you're freeing a non-requested descriptor
then you clearly are doing something wrong and the system should yell.

Bart

> > > > to enable code that can lead to undefined behavior (should it maybe=
 be
> > > > #if 0?).
> > >
> > > I don't know what you are talking about here.
> >
> > I'm talking about drivers/gpio/gpio-tps65219.c and its usage of
> > CONFIG_DEBUG_GPIO.
>
> Oh, that one should probably be
>
> #if 0
>         ...
> #endif
>
> or
>
>         if (0) {
>                 ...
>         }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

