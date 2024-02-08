Return-Path: <linux-kernel+bounces-58628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2684E901
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7789296D71
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CB3839C;
	Thu,  8 Feb 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TmrFHOol"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF9383A1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420909; cv=none; b=OPsumbom4+gl7XU2SPFdmxqHzTBWj3+HMbjHtSRLsD1azgfCd9BcwrR5xCobUuv4GnaydOXxTwh2betgbkVG8CARMMY0glqA1XlBi3+h+6Cv8AEiruUAfGRPZW2kRtAx3S4NVgaOt2o++tuHcoXBNDVicXWla6CooAYiV5bUUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420909; c=relaxed/simple;
	bh=49ZmMXs52sNHDqMkM1lTtLl7A2faEk+okVH4w0xg/Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDA2XdlYazcW0XlXN5+TtrUECPwHikmdGsbcDKn8MiyloZ7AZdr1NkT5Ytd1oBGVRASWByemHMx4J8AQ2ceQ986tFWYtwVtCx2prpx3bIU0XhT0souNEVlDdktBNe8fSWom/WcIeKY8YkJAhBKxoUZ5bEcSD/L3TYlWYEw+hgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TmrFHOol; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d6a772e08dso42684241.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707420907; x=1708025707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmA2415mqll/My0qNi8647dwajjmJqUb2r+iKelLxdQ=;
        b=TmrFHOolcKpOuTjNn9YG7SOckAcl/yyMU4MZcmbrM0628/LK1h/oYb7SCWd+Vd+YT/
         Wiot9hv7XOXX6FMuyjxB2da4cmDXey6fuIwrehTLbp87629kF4jHx9U5bN9y8xf8Gl3v
         aKdfJ/Aygfz5y1N9YSyYOolSnqlrgFtxCd/Hj80zdFRe1kXJYbaHVaRXtI+QRL9k/eY5
         DM86Xihb6ur/VG0l4q2oikPxLMp85o3do50SiqFTrwlX/eEIAO2dNLMgB+dQJQCr1tmQ
         v4UYPbbXAUVYTLY7nN1XeuLcEcZqJ30tvQnP21wGKeS4RqBjf9fMTY8diKXzI06Alaoh
         mMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420907; x=1708025707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmA2415mqll/My0qNi8647dwajjmJqUb2r+iKelLxdQ=;
        b=AKV/1Qng7lCB5hqYMNnhYffRiP3zNgO2hwvyyGwcoE4NVVOE39Ak5bTV9k9BKzzsU6
         S6mmhQflqRfw3JBqKapID7rjNbQ/Szr50eZ9+PyAJb70wFJVXgXjrOUoOSx63+XNYbXJ
         qj+kWJx1RogGQbXrGgOX/mcPe4Kv4Y+16B9km/Uo1MDLlrnGdvNbXwNUPVHPH4NQXmEX
         xQASgKKQaRLosLAsTYHovLl+EBnYXoxACQviE0vjnC4QqkZ6Hwps9lj0GGHEk74J35cZ
         4xEotiOSNT9uH7CKeUpMvxmiCUZJ6KNl9x486DuTD/PAi0a8PosUzTLQBAlamVpAfxsO
         esfg==
X-Forwarded-Encrypted: i=1; AJvYcCXs7b+lL4zM9YH7HUGKlGDDnMnTKZ/FMSfrDqyBGSWglRViaWgKs3JeB3nVKNiqfeutnzaZqdhlmvWF/qUEGCaLTCV8EXsHye8fzZ64
X-Gm-Message-State: AOJu0Yw3G1C19DeD9coRF8kzg2rJatGFFjf9lBu3hJ/2QgOojaUEanoP
	DqKfoU9IT4/ZIKoXAWVxuipW0A8vlUXOb62i88m3fJ9rMiMDAfTtVMVKEmRq3XuJPtr88kEjHaa
	O0Ka/oM6h36vef7cZz2fJ9ht0eT5EDx+WOtEApw==
X-Google-Smtp-Source: AGHT+IGMJWFdJBtDJw2nuq+Tc10l8gxwOAqqBaCaLXfg49jg7duuQITeryaa1iMz1zlg9PJAshT/cXnHy6978emBRSI=
X-Received: by 2002:a1f:da44:0:b0:4bd:3606:c7aa with SMTP id
 r65-20020a1fda44000000b004bd3606c7aamr597594vkg.5.1707420906766; Thu, 08 Feb
 2024 11:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-20-brgl@bgdev.pl>
 <ZcURtLZoEftBDpsy@smile.fi.intel.com> <CAMRc=MdaxrjKVoBe92ci+4U-VbxyuxMVu30-m2E3My0k7KN65A@mail.gmail.com>
 <ZcUqWy34Z_QGutNn@smile.fi.intel.com>
In-Reply-To: <ZcUqWy34Z_QGutNn@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Feb 2024 20:34:56 +0100
Message-ID: <CAMRc=Me75F3KmTJbiNZKXNpwU0a_fSd3UffWORwXzDLKAMcXag@mail.gmail.com>
Subject: Re: [PATCH v3 19/24] gpio: remove unnecessary checks from gpiod_to_chip()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 08:17:14PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 8, 2024 at 6:39=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Feb 08, 2024 at 10:59:15AM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > > -     if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip=
)
> > > > +     if (!desc || IS_ERR(desc))
> > >
> > > IS_ERR_OR_NULL()
> >
> > Ah, good point. It's a small nit though so I'll fix it when applying
> > barring some major objections for the rest.
> >
> > > >               return -EINVAL;
>
> thinking more about it, shouldn't we return an actual error to the caller=
 which
> is in desc?
>
>      if (!desc)
>                return -EINVAL;
>      if (IS_ERR(desc))
>         return PTR_ERR(desc);
>
> ?

Hmm... maybe but that's out of the scope of this series.

Bart

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

