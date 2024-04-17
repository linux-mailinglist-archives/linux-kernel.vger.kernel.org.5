Return-Path: <linux-kernel+bounces-149061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180358A8B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708E0B24A41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F24718026;
	Wed, 17 Apr 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="umcjkzaV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B978F4A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379207; cv=none; b=dEtO8VTxewvQLQUmC5U37AyDJsWa99IXtUYtvVZEK792nPMyRwPgpvxVwcTVkwNs5yD4wlijwu8N+3q7XB53QwqYZ38jF3FIURbl2JbtDOOpTDXElUzn0WzMhvp9jtAdBtFuShGKZFXdetyFUqAO11yhv53AukliCHFj68h2W5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379207; c=relaxed/simple;
	bh=OhXYRkHlutJXyjU0T9+kwMcG8LQ8HZDcv6iWC6fQg0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjoI8Pbtb+rT9DiVpfFmK9ZMIkyQLhhHZa4e9e7AZZh8EFJ+RASHojxbeVeBN+4vg4C9eOHS9tKbVX0IhdFPjN5ypR4dQLrCIgMbiStzrZZWaAN8udEpYqKPkga/TrhYAmfNpT59rRZqYoFm28qhMcMr+I1bGGfWq6Hg42H5xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=umcjkzaV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a56cdc03so5535394e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713379204; x=1713984004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R07SR/oel+G1qKlnViSta7s+zv+5bXS+VJuTgJczuYo=;
        b=umcjkzaVTNG+gtVI1EI484dB5LeE0bVaErV9j4wL7Ey9sG5qfRvnU0zPg980T5+q+T
         jgOC2Sr3rbjdSLS470TiYqKxkxw7IjbEhzCtuuI/6rvJ9bLVE+tYM7eCQJ1xXt2y35Q4
         U5qWq5javu4ogbMJXxWPrqmanUnJp5IrOSmGLadjLS+sUvquB3G/OftgVThInu+DHxxc
         Cg+qZGlsKyFx9rz7sytfY2C7hMDTAoQM1uVAPm2WEgquj1FmM271rwO/qNEnm8XgIq81
         bW2IGTOxONVs1nf3EBF6fDPRVR+eYj/MpN8zlVfPIr6TIvyIPPMVqn83LT6N9zlwm1eg
         V3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379204; x=1713984004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R07SR/oel+G1qKlnViSta7s+zv+5bXS+VJuTgJczuYo=;
        b=A/M99TMeZRDNLnwH+GhG6FRP2eoz6dWzkXtNqjby8ujrYw0Wl8jo6X96ZidA1aIbts
         5+Gk7gIdnaTnnqzXzQc20Hc9HPaFxmYeR5pqp765EHGVGnziuApU7jMFSEhhQ2bziqUz
         Nlds24ihqq6DmVQimmJP6D4UnfZ982UXwOtsLCpTtJ7swxUBMUdFbK+UYjjfA3PJEUyo
         hn7yr01IBeSNLDQ9lDI2zGeUEwtgCfnzniXWLQxi9jVrhuYvydqSqAcLDFCwRH+RMnfx
         NSe5u178dxBWhhPfRjdBRVKRzY8WBmbJ2SpOUexEd8QhNFuolZJN65h3XPdStpiNix7+
         71OA==
X-Forwarded-Encrypted: i=1; AJvYcCUPSImjGaPewGF9ZyeOLKJxnxumSWd5o93cnUz7L2QWqnbwDKakrXeXAeDnIL+Pg37SrzK27ob4G0WQFty7egwd7KsFQBfhox0eelge
X-Gm-Message-State: AOJu0YyYlQXgUnnjk4R4ymqKZ7FN3X2k1Q1S8zi1FJsN4mUlQRS1Td7t
	4yijk91QSZC31AEvfz8jHhTlwqW56mK8IdF22Aeapu80K3KuaCQBZHNIbZeTUxgQqdFetgk6KBs
	BRlntCwWtvf3O+hAtJEbccqFTqoWYn3/xzw4ETg==
X-Google-Smtp-Source: AGHT+IEcpfs5dpdJJqkCkXSkIR3lyitrJXuKfTPscTjfOwhlfTaeK+LO1vx1F850KkaaLSUV5ElUSJ1vut4ebqszoJs=
X-Received: by 2002:a19:740a:0:b0:513:5fb0:c5ad with SMTP id
 v10-20020a19740a000000b005135fb0c5admr89280lfe.17.1713379203946; Wed, 17 Apr
 2024 11:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com> <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
 <Zh6FkejXcwBTAqIR@smile.fi.intel.com> <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
 <Zh-MMAjf6hhNOCpL@smile.fi.intel.com>
In-Reply-To: <Zh-MMAjf6hhNOCpL@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Apr 2024 20:39:52 +0200
Message-ID: <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:45=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 16, 2024 at 11:07:58PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 16, 2024 at 4:05=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 02:22:09PM +0200, Linus Walleij wrote:
> > > > On Fri, Apr 12, 2024 at 9:44=E2=80=AFPM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> > > >
> > > > > IIUC include/dt-bindings/ headers should only be used by DT sourc=
es
> > > > > and code that parses the OF properties.
> > > >
> > > > That's what I have come to understand as well.
> > > >
> > > > I wonder if there is something that can be done to enforce it?
> > > >
> > > > Ideally the code that parses OF properties should have to
> > > > opt in to get access to the <dt-bindings/*> namespace.
> > >
> > > Whatever you, guys, come up with as a solution, can it be fixed soone=
r than later?
> > > I mean, I would appreciate if somebody got it done for v6.9-rcX/v6.10=
-rc1 so we don't
> > > need to look into this again.
> >
> > I'm not sure you got what I was saying. I don't think this can be
> > fixed quickly. This is just another bunch of technical debt that will
> > have to be addressed carefully on a case-by-case basis and run through
> > autobuilders in all possible configurations.
> >
> > This type of include-related issues is always brittle and will lead to
> > build failures if we don't consider our moves.
>
> I proposed a quick fix which was rejected. I think this is still doable i=
n a
> few steps:
>

You having proposed a quick fix is not a reason for me to either apply
it immediately OR equally promptly provide a proper solution myself.

> - align constant values in DT and enum
> - drop usage of DT in the kernel code (That's what you want IIUC, however
>   I disagree with this from technical perspective as DT constants can be =
used
>   in the code as long as they are mapped 1:1 to what code does. That's cu=
rrent
>   state of affairs. OTOH semantically this may be an issue.)

It's against the convention of only using dt-bindings headers as I
described before. I disagree with your proposition and it seems to me
Linus backed me up on this.

> - restore enum usage treewide (?)
>
> Again, the problem now is only in open source / open drain configurations
> and there are only a few users of these flags _in kernel_. I do not see
> why it can not be done in one or two evenings time range.
>

So you know what needs doing. I'm at a conference now, I'll be off for
a week in April and I also have another conference scheduled for May.
If you believe this needs addressing urgently, then I suggest you do
it right. Otherwise, I'll get to it when I have the time.
Unfortunately my TODO list runneth over. :(

But I have to say, I suspect it won't be as easy as you present it
because we have so many build configs that may fail.

> P.S>
> Most of the time I spent when prepared the proposed fix is digging the hi=
story
> and trying to understand how comes that we have desynchronisation of the =
values
> over the time. The output of that is the list of Fixes tags.
>

Thank you, this history is useful and should make its way into git
history when we fix this issue.

Bart

