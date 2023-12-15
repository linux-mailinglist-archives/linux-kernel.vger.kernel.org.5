Return-Path: <linux-kernel+bounces-586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BF81434A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF951C22590
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12311CBE;
	Fri, 15 Dec 2023 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Wmme0D5q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA311196
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7c47dd348f2so117581241.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702627679; x=1703232479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uiOQSE45YrsMt2KVUIc8OGdSe9niHAgFRBdIZwdjhM=;
        b=Wmme0D5q1nC+/bgUmFXO/37vEf+t0F2vY7vSr0B/aiTk86UdaI0aX2mCbgGIvePv9J
         3ppCAT0qOx1XYtKdYjnqr3+ClyMvWeQy46kK08YO3uddLjX2MmJCMlU0Zjz/Z0I2aJYS
         eUONRcGpic+Q+iIs4jBzn+Vvl8/QeKEMv7Hwpj3FIAeAFxdvEUJzQolBZRSSBPw2CZQS
         wlUdlJ27oGwMUxdM75P3HhZPfYlx0Q7PrHW8c7+T3qZ0buHhLpgzyjP6wjJlVrgNuWu3
         dwWy/l9mm+t1IBMjlg8jRmQPCEbpqiwexrtAEQRwxtSP47kikOWyuHFbFz2qTjTXFl0e
         iBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627679; x=1703232479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uiOQSE45YrsMt2KVUIc8OGdSe9niHAgFRBdIZwdjhM=;
        b=pp5Pkoz9JqcP1TuRlQPn4X0ygogOisNTAxarkoWN8HF6jPde75ASK95MHKNsAGq5dB
         Vay2gOobVDLLFcdMwvj3e9TjksHEHskDWDqzUC8zPZy2+EZnJXvLWbk4b1nP3yLp8lor
         09bL9Po7zeRSvGzekagg47DQEuJF2lgVb84zxww4CYW/mFRL8YUBQsWM3+K8xuRYenCk
         kSvf6i7gVXjVpXnGjRVRR+/hkZhpr+g55f54Cthgi4kglKdrDQQ9tBOKb45CVLJKb1HT
         7ZYGCaRTMaxkOgmfhwHHWct98Gq8apJ9qQ8UvBJ38GvcXqKqvWVEQxEqGRy8PP9+w93v
         Ahkw==
X-Gm-Message-State: AOJu0YwM2jxv/lbzAd6/55XqNuX7GP+YxoWcSE7g4uX5sVMC/R2fWRPf
	XG0nxuqE1HILHMRZaNikwa94L9S5iAgX6sgAoRzV1FEWyDfCwKXTWGE=
X-Google-Smtp-Source: AGHT+IEIqDaidt6c6oUTWeM1ZB0w5dbsENV6n6ufHVg8DOM+TS6CWMDUE4h/tcqcmJeb5zSXvj1OUPtNDY4oQr0i8lo=
X-Received: by 2002:a05:6102:509e:b0:462:8a7b:8d28 with SMTP id
 bl30-20020a056102509e00b004628a7b8d28mr7856589vsb.1.1702627678978; Fri, 15
 Dec 2023 00:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214095814.132400-1-warthog618@gmail.com> <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com> <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
 <ZXsp8QjxsUMPlZIR@rigel> <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
 <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com> <ZXumIX39JRpbYrbw@rigel>
In-Reply-To: <ZXumIX39JRpbYrbw@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 15 Dec 2023 09:07:48 +0100
Message-ID: <CAMRc=MfRs79kkXLV5KiH7ehDYq4BRR=eTNh+WNcCvsu8mg_J+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To: Kent Gibson <warthog618@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 2:04=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Dec 14, 2023 at 10:06:14PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 14, 2023 at 5:41=E2=80=AFPM Andy Shevchenko <andy@kernel.or=
g> wrote:
> > >
> > > On Fri, Dec 15, 2023 at 12:14:41AM +0800, Kent Gibson wrote:
> > > > On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:
> > >
> > > ...
> > >
> > > > > > > +static void supinfo_init(void)
> > > > > > > +{
> > > > > > > +       supinfo.tree =3D RB_ROOT;
> > > > > > > +       spin_lock_init(&supinfo.lock);
> > > > > > > +}
> > > > > >
> > > > > > Can it be done statically?
> > > > > >
> > > > > > supinfo =3D {
> > > > > >   .tree =3D RB_ROOT,
> > > > > >   .lock =3D __SPIN_LOCK_UNLOCKED(supinfo.lock),
> >
> > Double underscore typically means it's private and shouldn't be used.
> >
>
> You mean like __assign_bit(), __set_bit(), __clear_bit() and __free() -
> all used in gpiolib.c?
>

Touch=C3=A9. But this is just lack of strict naming conventions. :( Another
common use of leading underscores are "unlocked" (or in this case:
non-atomic) variants of functions.

> > > > >
> > > > > I even checked the current tree, we have 32 users of this pattern=
 in drivers/.
> > > >

As opposed to ~1200 uses of DEFINE_SPINLOCK if you really want to go there.=
 :)

> > > > Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
> > > > another hangover from when I was trying to create the supinfo per c=
hip,
> > > > but now it is a global a static initialiser makes sense.
> > >
> > > Yep, the DEFINE_MUTEX() / DEFINE_SPINLOCK() / etc looks better natura=
lly
> > > than above.
> >
> > Yeah, so maybe we should use non-struct, global variables after all.
> >
>
> Despite the 32 cases cited that already use that pattern?
> 9 of which use __SPIN_LOCK_UNLOCKED().
> Sounds like a pretty convincing argument to use the struct ;-).
>
> But lets keep it as kosher as possible and split out the struct :-(.
>

I'll leave it for you to decide, I don't have a strong opinion and the
entire file is your code so you should pick.

Bart

> Cheers,
> Kent.
>

