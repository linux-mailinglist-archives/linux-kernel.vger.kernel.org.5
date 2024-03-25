Return-Path: <linux-kernel+bounces-117463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C3C88AE17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9327B297E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4701369AC;
	Mon, 25 Mar 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vaZS80wM"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF412AAF6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383860; cv=none; b=tDdT57vswvSb6s098VCE8kuM8Q2DnZk6u4Y5uxJM63XNqJ3iz72d4BWw+BD1IQnEsnmNx8GZz18LBODzFZx3CIJUWOjtynYDYMIlJLacZfvVTXSSBBiT437Z6oziMcp/3Vwa4mIlY/gJ0wa4pLLtJVsqR8w6vIamTUDGvmtkTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383860; c=relaxed/simple;
	bh=DwTc1xPkUlLQODfXUI0kq22hkYbJUlklcvCHbGuFgHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8lglJ+jVboYU8CjzLqItfP+mV3WXSm7dwbXKKxNNEMNOikiJPPDbDmnWJSRdiGEVwRD1gGB/27CGyNyrKKxXKWqvn5n5frlAEtYnkrDXB5/MLpcbuTxZoN2Ukb0HmL09vOsoUI6QiXcp52WxbjXeOaVCdtRigaf3uozhk5a5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vaZS80wM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so55094911fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711383857; x=1711988657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwTc1xPkUlLQODfXUI0kq22hkYbJUlklcvCHbGuFgHM=;
        b=vaZS80wMZuW20l3qcuIi3OFA8WBlXceRqWxmjp8UvlakvcDs4jFrR6YY2FbL5O2v3c
         sQe3p0YImDHrcmwQ/k1c05PvIwgNb0wtyKnZ2HDHyrKF4Z5g1Z5kXWeR5ezamnH5rI6+
         zPX5lcW2B1WYNFF67Y+c8TJbEApdhTpUOmza/HQa8jc68NB9iokGjEmUfVPIpjXpb90g
         XurA6YXG6OynTAu7IWHU929EzG00GmINqdx1456BQmneHFh1SZmyZtHR9j+VEPgbEQSj
         xLhvTqgCO5Q7f8G7gmGuR0r9ga8sOMSwREzv2OEdHacN3GbVWLfhLDnI22kHNMihhQoO
         g/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383857; x=1711988657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwTc1xPkUlLQODfXUI0kq22hkYbJUlklcvCHbGuFgHM=;
        b=fbkU7XUGkW7zZs+TTEpISQeVyHS5OkeMthvJ8x5FbGXZyxx/hz2qZApqxY8SnoP/bP
         gMTVp8kb+I3gPWFI8tlC2jlbsYZqZAJVOtTtdOTcDfOznNWsVVQlrolK6nHbyJ274mt2
         iDblWz4E2/Btf/S6h6Co+xqwggJ7vYRaA34eSA6L54AhEf2jprkSMQSegX1OcACNK4Uc
         Pz6B5/bBul0GXeT7Nr2McyBaH7B6BUPHKFvkWHVteiYuOzlwUvvBY745xZ+0vTb1zq65
         oV9DljxJZj4Sv1AmjZ8lyEePIv9h5sfCgmYbrT+ppkrglx7f4Xp47A8zs9/xFF4koE0Q
         /iDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/FfAfDw/df6ISoPGKAZ2A1jtdWjGx45U2kbQPSlNW0XTci8PdbmG75mjw/xZGbPIFzuSFNl7bImVKZJGY7I99DjRDqSZIeYU9lPq
X-Gm-Message-State: AOJu0Yx/hgziTx1wb+8GTl+WxqPvyq2QgzhH3H5oi6KsKnWCB55BW1pd
	l6sTaSGFpXPU//49h5vRLs6EBWzn3Pk0ajVTBF7A320mULXxIgfuPJVEahMY6jQ2MzPcVEohMRB
	Y+3nGX0/AaJqXa4uM+sFZwfSQRqbaxbF2GXBeeA==
X-Google-Smtp-Source: AGHT+IGvMPhJ9VX5BDdfND0XNXaUEUfFNbgZPn8axUAEB40Cl1GyTMUXFIaLprhQ2wgHQno8/1S3AhKHXM4PVbzVGgE=
X-Received: by 2002:a05:651c:199f:b0:2d6:cd05:1891 with SMTP id
 bx31-20020a05651c199f00b002d6cd051891mr4080497ljb.15.1711383857094; Mon, 25
 Mar 2024 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322073725.3338266-1-peng.fan@oss.nxp.com>
 <CAHp75Vds1dmjbaDa0D+Xxoyt_9CgHhoS2j0cR3EQdMp3sbwg5g@mail.gmail.com>
 <CAMRc=McYbsd8t1_6PDypGBme2OSyvy8erdjR51cUzVhM-qQXZg@mail.gmail.com> <ZgGfgY2hITq_MDvl@smile.fi.intel.com>
In-Reply-To: <ZgGfgY2hITq_MDvl@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 17:24:06 +0100
Message-ID: <CAMRc=Mec5DSegEJHf5khj5ksCE3+SjQoq6vwRPEdnS7arawz4A@mail.gmail.com>
Subject: Re: [PATCH V3] gpiolib: use dev_err() when gpiod_configure_flags failed
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linus.walleij@linaro.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:00=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 25, 2024 at 04:48:27PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Mar 22, 2024 at 4:59=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Mar 22, 2024 at 9:29=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.=
nxp.com> wrote:
>
> ...
>
> > > Bart, are you aware that this will add yet another possibility of
> > > scary '(null)' in the error level, which is much likely visible to th=
e
> > > end users?
> > >
> > > I propose to apply my fix first to avoid this happening.
> > > 20240320165930.1182653-1-andriy.shevchenko@linux.intel.com
> >
> > I think you meant the v2[1]?
>
> Yes!
>
> > And sure, I will pick it up shortly.
>
> Thank you!
>
> > [1] https://lore.kernel.org/lkml/20240320165930.1182653-1-andriy.shevch=
enko@linux.intel.com/T/
>
> I can update this patch (rebase it on top) if needed to make less burden =
on
> the author's shoulders. Just tell me.
>

Sure, if you can resend both yours and this one then even better.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

