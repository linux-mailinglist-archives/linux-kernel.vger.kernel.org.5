Return-Path: <linux-kernel+bounces-4012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D58176A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8291C25655
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD94239E;
	Mon, 18 Dec 2023 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U94XMpT0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D13D56F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7c45acb3662so299915241.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702915303; x=1703520103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGsftRUwsP12LQ30FBWYDs/WH5EY9TUOi7H6csPAxGw=;
        b=U94XMpT0QLBlxq8bYxp3/sS8NKhOnDJNMoe95l8Kz6Jw2spo+XtO0leVWb4rHyjmzg
         qm13lwpczUpYXcJxdYiy8Wjd9BwBVhTb3nireB6o1cy4c4oVvnv+Zn2UCA0rFNS7bC6X
         Xu2UxEva3ThSP95xCHzymDKyA7yiqxdTGMNnk4jEYv4O5bcvR7nAjk3SLuaUx8u/gBya
         7m6HuZ9b3fpu8LtmCL6DlK223mq5WWKkxYfyjd68zbOaUKXUCrVb2eoaZbcyWX5lGiBg
         qAahpqlPzE4/QkxUU5rab3zT/oXGuvfclkvG2TPqs++68qEVf1ZMxAClva155JhoftGG
         f7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915303; x=1703520103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGsftRUwsP12LQ30FBWYDs/WH5EY9TUOi7H6csPAxGw=;
        b=Mcx9vijVDxfmwULMRqsgXjaFhvf83VU2QzR4t1iKT+4xvt5MXYTsqeS6zAlhhbtP87
         Oucvv1jYIATx9vp1KBdokg0sxcVAlOwQPFJuxxBXJHn/QdU5+rk/XFSrX5aiP5WGDu0I
         nuCwkl2G+9TjmPIbY36xLWiCqx+Mh4QL4qi/TCYwRHf0B/AIZJqYbWcBOLeSFVJbz5Mr
         YVPWD9kyEzWSrVwFJaTo6k0FtYMuzPgNC98Ee30clFPZ1Zz/tY/ODjvj0yfol0NfyHQp
         nB7OmNQ0ib1zVz8/aR9XPSMrtP0p45PYR4m+0eT+mZ/QUlIe5HYYv/adH8yJApYNxAEB
         nBPg==
X-Gm-Message-State: AOJu0Ywi88RtOHLkvlaGQb5PyzEq8q37riQndlbHKFv6I8SUKiEu7Yzz
	Um2xLK3mUqCqVVCgP3OdmmMd1zvzXGKRKZuxd3B5Mw==
X-Google-Smtp-Source: AGHT+IHc27efHm1oPrfnUlMRPn8IUs/f3CkxX/C5qBu8BNaZdCSCbdm+IytJJb9k8TJC1cMswI99IhwBc39aQg71/Z0=
X-Received: by 2002:a05:6122:180a:b0:4b6:d379:7f5 with SMTP id
 ay10-20020a056122180a00b004b6d37907f5mr510520vkb.1.1702915303687; Mon, 18 Dec
 2023 08:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216001652.56276-1-warthog618@gmail.com> <20231216001652.56276-2-warthog618@gmail.com>
 <CAMRc=McBVeQ=yRpGRsnPEULfPx15PBO3kiGscdS4s6-d0URc3w@mail.gmail.com> <ZYBoA25z76uutBBI@rigel>
In-Reply-To: <ZYBoA25z76uutBBI@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 17:01:32 +0100
Message-ID: <CAMRc=MdKfs1ok2KgkO0C64cA9k8bOupxsjReBMQSdZbP+MQMCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:40=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Mon, Dec 18, 2023 at 04:24:50PM +0100, Bartosz Golaszewski wrote:
> > On Sat, Dec 16, 2023 at 1:17=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > Store the debounce period for a requested line locally, rather than i=
n
> > > the debounce_period_us field in the gpiolib struct gpio_desc.
> > >
> > > Add a global tree of lines containing supplemental line information
> > > to make the debounce period available to be reported by the
> > > GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
> > >
> > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > > ---
> > >  drivers/gpio/gpiolib-cdev.c | 154 ++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 132 insertions(+), 22 deletions(-)
> > >
> > > +static inline bool line_is_supplemental(struct line *line)
> >
> > Under v2 I suggested naming this line_has_suppinfo(). Any reason not
> > to do it? I think it's more logical than saying "line is
> > supplemental". The latter makes it seem as if certain line objects
> > would "supplement" some third party with something. What this really
> > checks is: does this line contain additional information.
> >
>
>
> My bad - responded to your first comment and then missed the rest.
>
> Agreed - the naming could be better. Will fix for v5.
>
> > > +{
> > > +       return READ_ONCE(line->debounce_period_us);
> > > +}
> > > +
> > > +static void line_set_debounce_period(struct line *line,
> > > +                                    unsigned int debounce_period_us)
> > > +{
> > > +       bool was_suppl =3D line_is_supplemental(line);
> > > +
> > > +       WRITE_ONCE(line->debounce_period_us, debounce_period_us);
> > > +
> > > +       if (line_is_supplemental(line) =3D=3D was_suppl)
> > > +               return;
> > > +
> > > +       if (was_suppl)
> > > +               supinfo_erase(line);
> > > +       else
> > > +               supinfo_insert(line);
> >
> > Could you add a comment here saying it's called with the config mutex
> > taken as at first glance it looks racy but actually isn't?
> >
>
> Sure.  Though it is also covered by the gdev->sem you added, right?
> So the config_mutex is now redundant?
> Should I document it is covered by both?
> Or drop the config_mutex entirely?
>

No! The semaphore is a read-write semaphore and we can have multiple
readers at once. This semaphore only protects us from the chip being
set to NULL during a system call. It will also go away once I get the
descriptor access serialized (or not - I'm figuring out a lockless
approach) and finally use SRCU to protect gdev->chip.

> And you wanted some comments to explain the logic?
> I thought this is a common "has it changed" pattern, and so didn't
> require additional explanation, but I guess not as common as I thought.
>

If line_set_debounce_period() could be called concurrently for the
same line, this approach would be racy. It cannot but I want a comment
here as I fear that if in the future we add some more attributes that
constitute "supplemental info" and which may be changed outside of the
config lock then this would in fact become racy.

Bart

> Cheers,
> Kent.

