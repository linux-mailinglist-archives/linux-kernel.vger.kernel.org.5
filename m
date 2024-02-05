Return-Path: <linux-kernel+bounces-53826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945B84A706
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7FF1F29DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E15FDC0;
	Mon,  5 Feb 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y0rsuLrJ"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788C5FDA6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161813; cv=none; b=jeXYqm8lI4yynh4uJjUP5BIHXMy0c+Jdb36kozwHhA1tfngyDrLfexfy8m3ge9j2xFl0XSl63uKblr6OqGj1ZbtN4uh4TQfZ2iMtGRlSG20MRr7OxC8yXoqj/Ul9i3v2lCODlzg3KpmFLF0QfXhNgv64m94iYtgQaY6EQzrx6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161813; c=relaxed/simple;
	bh=lEYzIFkIDNr0lwbywYaxUK0ssxdRDtBBP4dTcXZR/BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjPUEOuQ6TZ5qU27EKlBV6Yt/PkugHyKLhkjIUxst2q6hFaa/OX7b12/N+Rm2kxBdleFUwO6krP681AkImLlN38nh+aT3YXiSOL4C7XEh8Tln/1kno98KATu3fDzypCTt/Av+KCkUVeJRA3KtQSp0ZbId/IugbWEaGclsLpTQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y0rsuLrJ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so2311305241.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707161810; x=1707766610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+7OHrqpOuqpOOjbY3YZJI7fSE7iDbYYXlnto6M+hlo=;
        b=Y0rsuLrJO++N7dfDx5WlwV7cmdOxWNd2ZGGOFbS49fTjjxYmIKyZpuLljdyULM9idN
         MI8TE1Alfr8vhtbIfYYk/qANX06nmsJQYNGaY5na8LOc0ZFarOjmKv2E9L2ySkpHM8Me
         CYqpNt/oA5LdrCnzWfUvw9ilnx2GQPxW14qjtng7rPkz/SDax/3/PfNo+KaSyUEaeWup
         KL4ebzQmXfvWVFIFPizXa2aYcqEFmlVY30o0Zu/1j2mL8rzdaDBHqsUcmhdPAdT/8pCj
         eFAirBzHJL3S/6Vgp9zzwvMZZ2A+J5guXLQ5fUsNmnV9kA2gEqdjYe/Vc1tc2d8jHOV7
         HmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161810; x=1707766610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+7OHrqpOuqpOOjbY3YZJI7fSE7iDbYYXlnto6M+hlo=;
        b=ZFJuteY7tJ1zn3KhJWkSvW+oJpVAxB+yoLGuuA0V0pEi1tm62kuDPeJbpARm8U8stF
         vQpI5Fi9dNVbWjbSxSRrLYHoih67pCPh/kQQxGTgXkIuuAenIxCRTvtMTe7v+bCiMvhK
         Qg0y6266hevTYG9ZT7bJ55kwieHGhvXXJYR2DUFzPCQmJfWiz3V+reBggJTefIc/Xq6b
         ZO08QYnyOuxM4PXdRx+lx9wHnLHnZ/fNqvd2wLKLpOewPDzI6oL6tTb+SOcVyKmGANbF
         mzSrce451ZhvFGO636JAKjQnDxSwIbWIeazswEBk6LASavpKH3p1LFGZdVG5VaJqSLD9
         EdUA==
X-Gm-Message-State: AOJu0YzOjI5IXRfQw35DUVQcClAYHVJ6sbnNbhxiLwp1XVUSdnK6+i5r
	lgTxDOzkPBsb94tEHoibOcvm3XBf43DZz3Iz2q5zCg27R++AJqPe+a/wWTe1/8r+QLmFqDzJc07
	uv58QAJz9lABdAe98CaYvZV2K2CFksXmph5XlWg==
X-Google-Smtp-Source: AGHT+IGUXREYpSgvCcKR/2mLnLuyI5E5iYeu+pMj2i/scxMB6h54ahwKYqv1iYu6B2EFV4b89k8TsRtogRuJuHKzZFw=
X-Received: by 2002:a05:6102:117c:b0:46d:1b1a:a375 with SMTP id
 k28-20020a056102117c00b0046d1b1aa375mr811567vsg.32.1707161810384; Mon, 05 Feb
 2024 11:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
In-Reply-To: <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 20:36:39 +0100
Message-ID: <CAMRc=MdoGQZKM37kk=j6NpdkUUjDvs3-8YeiZVQO2EpPHRZ7Uw@mail.gmail.com>
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

On Mon, Feb 5, 2024 at 1:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

>
> >  int gpiod_get_direction(struct gpio_desc *desc)
> >  {
> > -     struct gpio_chip *gc;
> >       unsigned long flags;
> >       unsigned int offset;
> >       int ret;
> >
> > -     gc =3D gpiod_to_chip(desc);
> > +     if (!desc)
> > +             /* Sane default is INPUT. */
> > +             return 1;
>
> Hmm... I can't imagine how this value may anyhow be used / useful.
>

What else would you return for an optional (NULL) GPIO?

Bart

[snip]

