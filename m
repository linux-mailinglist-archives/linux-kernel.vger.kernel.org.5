Return-Path: <linux-kernel+bounces-8418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA5E81B6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE441F2172C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85676DC3;
	Thu, 21 Dec 2023 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vG5uM4kD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9173198
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4b6c387d7ffso130369e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703163650; x=1703768450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiJR7zOQcvwlFGaNEo47xsUGjO0IgSM5buQ6dPTuemc=;
        b=vG5uM4kDk0c6hJl7SUui41i0IXZ6ZJSZrgDOrKmVcSwFp1Abrs0ByVOIb3S0UE8xd9
         rf9GLcxMiNWbxwOiZf8dsALbLX4hLsG47NO96HEi8ZPrGOv8qV8Gb6WLtX/pIDgG0Ofo
         guK1i/ClfjXaeNcZuxY0NYxOC9wxviU0+Mmuoi4nrBDJBUot7VlNdqdmRUIId66+qbBB
         HMWToRMSbrvNTofOBCPvP2L3jvi+ljuV30L+L6axHszUmX5p1lhIaQt8D2osYiM8srwk
         I8AGVk/j5ml2Vgzn4kthjKRJwUYwCo2XTUUV+0O4Shp/ONd1M6J8gEIDwGKSyBxYztjm
         Ez2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163650; x=1703768450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiJR7zOQcvwlFGaNEo47xsUGjO0IgSM5buQ6dPTuemc=;
        b=bFS61zotLhVwSaIjgPKjN9bU7RT6XfqTDEEejYN6OT3z/sn9pZ2kvTwZVdca5SR270
         m/muCcZe/6DrWqU+yrTJusFhodTXGtqM+gYdbDKmjAV+VjG+pHG4K1WWBGMnRbtV5EW7
         +bfc9VhdmQd+rBK2X9LgGID7snFyzE2bxNx1nyx0qVbdbVEd/EMG9+sImchGbILLgK6E
         Kz2xb6EV6KOpOhConmex1DUlbmLEL39JTY7RyFEkxlye5h29D6qgaOAEcd6lv0zVDYML
         oaNhCzM/PlLi3Etjq/M+p7D6Mk3abzaxv0zP+iKNM2OyA63VNkTLSxikFZqL5nluLfZU
         g0rg==
X-Gm-Message-State: AOJu0Yxgu0mgLJ8+tiinrwLzTgcEGqUJgRO14WrKSM3F0GfzyTuD/ADJ
	KLOk2dfEfUNgnz5/bLOLdZZFrBOtzBGB7alY6Vvf6w==
X-Google-Smtp-Source: AGHT+IHIKwY+mK24UkXqPW8H6wr0chvCH0KvStEfVlMCfAR+7X3LmCCQhY2B64NQrE6lJ6PXmBCZCIZiE0gSiOOfJNI=
X-Received: by 2002:a05:6122:459d:b0:4b6:c771:47e8 with SMTP id
 de29-20020a056122459d00b004b6c77147e8mr476742vkb.20.1703163649751; Thu, 21
 Dec 2023 05:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl> <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
 <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
 <CAMRc=MfLXxfzhKDc9e3jRF9mdVo=9UnC9O+i9s-uGm2pEa7vMg@mail.gmail.com> <ZYQ09RIq1R8xmn_k@smile.fi.intel.com>
In-Reply-To: <ZYQ09RIq1R8xmn_k@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 21 Dec 2023 14:00:39 +0100
Message-ID: <CAMRc=MfYG09UUfqfuE89Or4HsP8QWUBJXCvuPPhe+vx0JiZF4w@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 21, 2023 at 10:26:03AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 20, 2023 at 4:28=E2=80=AFPM Linus Walleij <linus.walleij@li=
naro.org> wrote:
> > > On Wed, Dec 20, 2023 at 3:03=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote=
:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > extra_checks is only used in a few places. It also depends on
> > > >
> > > > > a non-standard DEBUG define one needs to add to the source file.
> > > >
> > > > Huh?!
> > > >
> > > > What then CONFIG_DEBUG_GPIO is about?
> > >
> > > Yeah that is some helper DBrownell added because like me he could
> > > never figure out how to pass -DDEBUG to a single file on the command
> > > line and besides gpiolib is several files. I added the same to pinctr=
l
> > > to get core debug messages.
> > >
> > > I guess Bartosz means extra_checks is =3D=3D a non-standard DEBUG
> > > define.
>
> I agree on this statement.
>
> > Defining DEBUG makes sense to
> > enable dev_dbg() messages.
>
> Exactly!
>
> > CONFIG_DEBUG_GPIO is used by one driver
>
> By all drivers which are using pr_debug() / dev_dbg().
> I am using it a lot in my development process (actually I have it enabled
> in all my kernel configurations).
>

I'm not saying we should remove it. It'll stay defined in the Makefile
and remain seamless for debug messages. I just want to get rid of that
ugly extra_checks variable which has very little impact.

> > to enable code that can lead to undefined behavior (should it maybe be
> > #if 0?).
>
> I don't know what you are talking about here.
>

I'm talking about drivers/gpio/gpio-tps65219.c and its usage of
CONFIG_DEBUG_GPIO.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

