Return-Path: <linux-kernel+bounces-76599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A185F9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0022851D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A831339A2;
	Thu, 22 Feb 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OgK2Bcdk"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4812FB02
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608616; cv=none; b=FujtBoRj1zvQWvDoVRQsrjgCMrZf1m3kwu6pizVxEGHXvfcs7YUjpSF5ut9GT+BTxUyEnRxOq69JRrK9//NZUkPC4LfoBMNejvgXmzPjnZWBotnxYfq+IrcdmQ/d3Inxl9iQBFdcoJWQJl9Way+UjcxFqNdc2FL8tmFdindg6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608616; c=relaxed/simple;
	bh=CCCDVfjOdXJUfj4abfYUhg1XpYqlkNzhg8HjSIrRepQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShpN+4ocJ/l8fLt8MViW8Nj9hvd2+amZmcH2oKgXr2ROvGDbDWXJEzamrhufOQb4sPXvJeUp83tthDbGuvUWSLmCtNgy4T6cmfZwyMw03TnM+J+wpWSGb/IKxPVUbQR62mH+N5Z8dZoXywQ8+THgmIn6eEoNoDDcTBdeyLjX6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OgK2Bcdk; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d6a772e08dso2847803241.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708608614; x=1709213414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZS1HiPVKUfAHyltRnTHESSwTY1uCLLaR3nEKiiJ6YE=;
        b=OgK2BcdkrufgiUFsd9LZftjYuFaQHRmFuQZJc43Ymm+cukXYZooRRqf2ft9yBO9+D6
         07vxz+DR+o8N82O0UxuQJH9fnlQPGzBot+bFuGISFJmMudljmbcSSFC+PEK5G/n8DSPS
         lWMkKa5t3pdpq/5D7DF/vHPb8aBjBwkuGv6j88W8OiVMkfaSlcwULSCdYXQFmfAeAPeM
         cX5Nh4W5gkuSeZXOBbJ/ccc7VFAwQMIogOp25p8zA3Bod00I/u6kh3bJGvTJ/MlMKEzf
         Y3NX/58A4988aXB4UsapMCff5d5cTuofZMbQ8Z73dmaweyYP8mj7Dfu9ePnOOha3I+EN
         oKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608614; x=1709213414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZS1HiPVKUfAHyltRnTHESSwTY1uCLLaR3nEKiiJ6YE=;
        b=Fhj+R9ceKSxW+bkxP1O/nWI6eTay9v3SOyWNn5XClKk5Ok+NW84M9kNosu3W/rbExu
         IqTCKxJ2NXvrk/GVGjpdEuReXIn7LphAPs59hDfp7z92Ri4fs2j7457n+9DPGssilJ6e
         ej/kMcjXVu3jgQ7ZuIaQjKHztEpikIc4YPVMBg0Dy58DS2eu9vpLrRmReWQsMhiyBWqy
         9ozznNUaPJdmVQHcbbIo7q8B3dStKayol9U5O58UMcQBzQuTeUw2cpxVNhCBQa1kjIA9
         EdcKOKUUN5JznoAvmTs/Xq9TV2PfxOZffQ1CD8R7GcUZMkbTY6FWrtoUG25pAoKQho9S
         EFEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZGJbHY8ptHk8bL3nxU+meO+u6nrTtRVHqOw0epAcWlT4/VgGK0Mh+yQ1taXAotHt4tXCrxwrtX5/9DBLxJ4ciMGS+tuRQg6+klzV8
X-Gm-Message-State: AOJu0YyZfDwHnZ/Acq6zu0rkpLqtoV3oB0rJ/TUEzuoILvGk49r5q6Gy
	Nit1+jw+kY+AF70Q2qF4NLNqpKooT45YEkd/K4+NhagN2BT7KSi5L73JB9L6gq2pHsyu0dxdqNQ
	RzM1FzfffDAB5V7b5Cmva7dr+imDJKN/lrLO5Ig==
X-Google-Smtp-Source: AGHT+IGTU97g9Jf/2v5+mWOkYTyqn/V5nIeZiiSxBuquPKjPl5Vuf6KJd3ahpcqNQG6gAH6OfM2TM3ziLHElX2nKI/U=
X-Received: by 2002:a05:6102:cd:b0:46d:7523:1fe with SMTP id
 u13-20020a05610200cd00b0046d752301femr10082224vsp.30.1708608614014; Thu, 22
 Feb 2024 05:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com> <ZddL7L24RXoqR7sN@smile.fi.intel.com>
In-Reply-To: <ZddL7L24RXoqR7sN@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 14:30:03 +0100
Message-ID: <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Feb 21, 2024 at 8:36=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > There is no need to repeat for-loop twice in the error path in
> > > gpiochip_add_data_with_key(). Deduplicate it. While at it,
> > > rename loop variable to be more specific and avoid ambguity.
> > >
> > > It also properly unwinds the SRCU, i.e. in reversed order of allocati=
ng.
>
> ...
>
> > This doesn't apply on top of gpio/for-next, I think it depends on one
> > of your earlier patches?
>
> Yes, on the fix with error path.
>
> ...
>
> > > +       while (desc_index--)
> >
> > What about gdev->descs[0]?
>
> What about it? :-)
>
> for (i =3D i - 1; i >=3D 0; i--)
> while (--i >=3D 0)
> while (i--)
>
> are all equivalents.
>
> The difference is what the value will i get _after_ the loop.

Ugh of course. But the first one is more readable given I got tricked
by variant #3 at a quick glance but the for loop says out loud what it
does.

Bart

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

