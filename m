Return-Path: <linux-kernel+bounces-76612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5AD85FA02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9C11F21EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D635134CCC;
	Thu, 22 Feb 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dh2PNbIT"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E212FF73
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609181; cv=none; b=GAwCL5+wYMWFgabCktzyAdnjxT+YHPbcrGTdcK7wra4kbt6XrUc5vXWCWlm1TwwNsbwoASuzMKZYPMSqbgSJ7RUO3I2G1AILtGRLNPNjrqwW6wHFpxI+U0gickUSSNL0wecuubFQgwUsJa/YuGgydOmLgu6CMGSQUG3ds/fyvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609181; c=relaxed/simple;
	bh=oaWLKIrohEVVRK2LX/y7Gl/HoUox13AjUtmbGu+WWps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sflX0puuBrFitAlBrzaRCXbM4C5aUma43XE24lwtIhRK6BMBS16zgh8nTCBWc5NSNop7/ByoviNPFJOrwWroz3GP7rD652Qu2aQ6z3MRpVJQnJq37cCDW+T2gmVaNIXmUqJVOwyIZo4axObA3no/q1DnmYZMym9VSeDbdXIRsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dh2PNbIT; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2a67daa25so4783101241.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708609179; x=1709213979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot075bt4dL2yU2q8AQheh13hrjTH3TbPeTjQMwROOT0=;
        b=dh2PNbITvOlCh9aX19lIYLO9JAk/axqVeyXFXO++DyiUUG5ulm6vNcfJGJ1PNIbm9p
         uaKM0Ey9ix0u0D5zYzawaOBbIPhuhMFrYlb1wx2j9uPUuAgii9W4bVK4NmaUGQv9F8Wz
         b2khnGKllKl54ti2b5vIRPgP0it6+TsBOucMvtLhZLHprCaEhP8+xWkpvzcI7fRL/3+g
         0+ZrIbyY/iw1jwh5q9Dmmc1VWIafZwGP6tSk9Xk2b+m7egI3iUhuZeAvgZ9SDXt3afnY
         05rtubUVOetijS8auoxAv/fOwROh4zhQNLAuknufdeffqkSa3ZaAzpC3TqJBPY5xGJBa
         rrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609179; x=1709213979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot075bt4dL2yU2q8AQheh13hrjTH3TbPeTjQMwROOT0=;
        b=fldW/pGmQsAUzIqrvZVXrW/lJBImEXTkyL4r26zEMXEfTycm9849hZC9zt3fr8C1TY
         l5SNN6ywWkViXakJZEUiuIT3iQfw5eM2fVbPzh3ifrVhI17YJreiBovDGdBdXpi22y8R
         gcbg7dVxDn6/DjWysSJZxy7mXzDW4S1kacxQpTwZv84awoP97Akc3YybMG0UfpSo6om5
         3KMIY4eTLu3Q5fBe3oFQG1AVjAh9ZXw4EQ5QyTuixxy8+ZB0ttKhBwyfX/2Bg7dkyqP5
         OBrz0zvix8RaOO/IHTTbFXHH5efULHmX99XrjAQRaG3yvTgTazpaI029SJbF1N3TbSiZ
         5fSw==
X-Forwarded-Encrypted: i=1; AJvYcCVP5EV4J7VJNilHS+jmttDTcd4RVchO8EARFL4/W75ujmOv5swsWco2ZWIqO7B13D5oqQ4wLIqbYEw//wjdI5Cm3yEHx6ftligAubhO
X-Gm-Message-State: AOJu0Yx4cfc4s6538TKgsXOzOFQNstX/IXb3QFg8kmPVoFwFxGm1ikqM
	nVw/kx+z/LySbx8CnpQu7I+6X/Vs1F4Ytz3A1aobzJelyA1/oFPrMdg0X2odIE/RYOG8FQKuYaD
	zRuLZjTYKLgYuHWhGn2z+SX2BTjBGTDUlNRbstA==
X-Google-Smtp-Source: AGHT+IFZtozQgLnZSq/aH8P23J7/6o8CVysT8RBQdne/QMOV9qfinq79EPXNSg0bnQRk8ybAJeKCRCfKp2wiRCw5cxc=
X-Received: by 2002:a05:6102:1989:b0:470:5648:7070 with SMTP id
 jm9-20020a056102198900b0047056487070mr10593189vsb.21.1708609179138; Thu, 22
 Feb 2024 05:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
 <ZddLRAqxFr7v3Zqs@smile.fi.intel.com> <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
 <ZddOKTP73ja6ejTc@smile.fi.intel.com>
In-Reply-To: <ZddOKTP73ja6ejTc@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 14:39:28 +0100
Message-ID: <CAMRc=Mf_w_E4B7c_Uj1WV3zv9DbmJ22oFvJJwtd-+3oUDVcvXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 22, 2024 at 05:33:59AM -0800, Bartosz Golaszewski wrote:
> > On Thu, 22 Feb 2024 14:25:24 +0100, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Thu, Feb 22, 2024 at 10:37:06AM +0100, Bartosz Golaszewski wrote:
> > >> On Wed, Feb 21, 2024 at 8:28=E2=80=AFPM Andy Shevchenko
> > >> <andriy.shevchenko@linux.intel.com> wrote:
> > >> >
> > >> > After shuffling the code, error path wasn't updated correctly.
> > >> > Fix it here.
> > >> >         gpiochip_irqchip_free_valid_mask(gc);
> > >> >  err_remove_acpi_chip:
> > >> >         acpi_gpiochip_remove(gc);
> > >> > +       gpiochip_remove_pin_ranges(gc);
> > >> >  err_remove_of_chip:
> > >> >         gpiochip_free_hogs(gc);
> > >> >         of_gpiochip_remove(gc);
> > >>
> > >> This undoes machine_gpiochip_add() and I think it also needs to be
> > >> moved before acpi_gpiochip_remove().
> > >
> > > You mean it should be like
> > >
> > >        gpiochip_irqchip_free_valid_mask(gc);
>
> > >        gpiochip_free_hogs(gc);
>
> But should it be here...
>
> > > err_remove_acpi_chip:
>
> ...or here?
>
> I'm sorry I really need more (morning) coffee, maybe you can simply updat=
e
> yourself or submit a correct fix?

Ok, I'll apply this and send a fix on top of it.

Bart

