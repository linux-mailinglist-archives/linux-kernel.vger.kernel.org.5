Return-Path: <linux-kernel+bounces-54977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B884B5C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F881F2598B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE812F39D;
	Tue,  6 Feb 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AcJZiakA"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F39131726
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224273; cv=none; b=IvRmkvs3+SWKchT0EOhpwWhpGRsyFut55k6isUA9LxyOieMcn2JG0RIVCv480FFZsDGC0H3JuEWcACCNoXhDlHXeBGS5eQDvYgEsNOXiLrVZy8Mu8Ia3QoJKoTPNYOtvsuvJAKvX9TtiREPHDAB/MTVGsW8qb4XUge+s2JTAnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224273; c=relaxed/simple;
	bh=Dz1C2FKSg8Ps4eODqw7tR2caClrdu7B1RUvCeAVqjBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+IsDlWv+pmOLTRSQKKlVIm61vjhnjhyBwlYW04FMj2aaPkFcVtbd57hPOXK3Q4jDO5+DRDkO3KEhj39pO/CupFMmW5LZSOybD4SFPfstelbRBR95Zmasf9ejVOKS+sqSx1l5DonPt9w8a0JrADN3jCEyGorrDZKTwlxXAflF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AcJZiakA; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46d2dff740dso539469137.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707224271; x=1707829071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5svFZeRKd0+hhVkOuAoktHKWb/1F+wemdTZj5yfOkxQ=;
        b=AcJZiakAIMGitYUVtizRbKWMLVyMovVIwK42RoKLwAxdMMZYS2FVrOsm+crHf+ikcx
         hkmTLC7bJ97wvwY6sSdMehfU0aOtws3tBcULs/ehF3JmlW183eubio+k3JluXFtDQ+xJ
         EClVKIdfWuTqwAuvKUGeSWyPieFSflkAh8HDYNt9OkKJgrvKCWwMjshXFJ9VQTQD/esI
         2R66GXDF5z/A9DEol3vX1tZVpcCWnp5w4/k0rGwNoEweXbFK0vwo5skviqF0k6dIMKxK
         kcqcZSYDO2TcLp2yZnVAPQz2zO8w0YSlOoyyD24hq4pQ8c+OnF7RB41zrDC6nvjLWSQI
         Bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224271; x=1707829071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5svFZeRKd0+hhVkOuAoktHKWb/1F+wemdTZj5yfOkxQ=;
        b=E/1r3sGilEz4Dy7uY+eTZ23ShEM27IUcJYeaJIUTlzzoXea9tqr/A2b7hWX/1oXKX3
         RYlhs2BuBKK+UVg8NVeb3eRJXJUlx+dRiYsTPgHhBuYLX67FdAJHF+Z1HQ1xyvaH6Bbn
         jSOkRLeMWIlenGICV72kZ2+Cgcx76VXA+YnUIGOCYrWg4P5frEdlhoDVBfUpLMQZPwPz
         kooOeXU9bGSfTWy3ASoooUdxIH5K0/NEHHRbWa8vZPXSu4cqcLLnfWjOWPVXMuWx1o//
         Y02AhsUP47W4GzU9lgmr3BdtB/Rb+SvYuYPunY9D66dxiaGvRY5obInpEVkiNB4OOAsG
         vEYA==
X-Gm-Message-State: AOJu0YxPBNJpk/6ns+VALO1URcYiMB94cS0hhK9gVxRbYMA+lkFMUhiX
	jXJF2UXV/ywP7YgVganvwlV50jgfwOCpAwHtp69yZ9462NRubLr8QjmIrgV3ClWs282m4lPRCqR
	0TSg8Mu86su2uH3JxB71yU4GQ+s1+voad4Y3yohnSAHNKrpEH
X-Google-Smtp-Source: AGHT+IF+L9PTVB8MHEOyy6i7TDS75uBaW3oPuf5e3FKReFyrBN7EJgUy6W+7Mnsv7GMNrDg/cJzljJUDjbjNmfoXCSU=
X-Received: by 2002:a05:6102:1174:b0:46d:1a03:2a34 with SMTP id
 k20-20020a056102117400b0046d1a032a34mr1342624vsg.28.1707224271156; Tue, 06
 Feb 2024 04:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com> <CAMRc=MdoGQZKM37kk=j6NpdkUUjDvs3-8YeiZVQO2EpPHRZ7Uw@mail.gmail.com>
 <ZcIlEEgHn5AaTEyz@smile.fi.intel.com>
In-Reply-To: <ZcIlEEgHn5AaTEyz@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 6 Feb 2024 13:57:39 +0100
Message-ID: <CAMRc=Mcq2UgS4EcVAOghQzFq_jXA83rGMse+pxa5ieK8MXZm-w@mail.gmail.com>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 08:36:39PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 5, 2024 at 1:31=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > >
> > > >  int gpiod_get_direction(struct gpio_desc *desc)
> > > >  {
> > > > -     struct gpio_chip *gc;
> > > >       unsigned long flags;
> > > >       unsigned int offset;
> > > >       int ret;
> > > >
> > > > -     gc =3D gpiod_to_chip(desc);
> > > > +     if (!desc)
> > > > +             /* Sane default is INPUT. */
> > > > +             return 1;
> > >
> > > Hmm... I can't imagine how this value may anyhow be used / useful.
> >
> > What else would you return for an optional (NULL) GPIO?
>
> An error. If somebody asks for direction of the non-existing GPIO, there =
is no
> (valid) answer for that.
>

All other functions return 0 for desc =3D=3D NULL to accommodate
gpiod_get_optional(). I think we should stay consistent here.

Bart

