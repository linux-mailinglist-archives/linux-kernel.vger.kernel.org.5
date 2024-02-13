Return-Path: <linux-kernel+bounces-63349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2B852DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C61C21129
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82AA23754;
	Tue, 13 Feb 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVivYR3z"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87A224D4;
	Tue, 13 Feb 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820480; cv=none; b=oN8PX0VCIzBCcReLYUrvx3/FF7R+yknL0wmVTAqcSK9dXxgc/5k94H6KLR0FtTCW7L0kNi3v+5wPtiFqMWXrm/uPD6xshqsKH7u1UN9eZUZQMNtzpD/pEQwqp3WEyUa+lhN9sftrvmWEf5z53WCArDGnDXxfibqd9xTzpqofZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820480; c=relaxed/simple;
	bh=n+mIwM5bfg0kfua6+c13QqD9H2W99vr9IltUa71S+Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRmKTJQ7X79sPqXDz608RZgyCI45BpzThGx8Z3A5W2JUwMG+jSch/muIKQLI4wwkEu9akVp0TznaHB4ii2z8FYlSuqEsn0DOqobRSZXm7480Nfsp7HYlNnFP3h7gP9iWN+AmI1DJ5tIChTisFaBJ3szwjqhE2wHMpkx+6/P/Ibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVivYR3z; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd72353d9fso3088700b6e.3;
        Tue, 13 Feb 2024 02:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707820478; x=1708425278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+mIwM5bfg0kfua6+c13QqD9H2W99vr9IltUa71S+Jo=;
        b=SVivYR3zfKVFft3grLE/s17s3r7zr1oIVxw/uQVsfe5VjU0whmEuZWamPF0jDEhGg2
         5EiakX2ODgH9GtdL+2qOm2EUSIHrUfdwrXlWqErDk3ZC8FxVnCpzRj5MkUSUjTwTEd54
         Cx8JdXsDMTy4g3Fo3clyx/ELb3dYuaAnvwnbFqMSRrVjRiMnTOiUbibC5rzAeJjCRgCG
         w17NizM6zInB3MjLBaijDEO+TalVkrPfqkxJI2tZgvQm8H30R6laK5Qld2cjZiohn3F5
         +94Xaf1fdXvbK89DMu3T5u6EIv6qAHqzraa7QjfobTzQ9/49ttFzF7YHL6NzNb9msIza
         3Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707820478; x=1708425278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+mIwM5bfg0kfua6+c13QqD9H2W99vr9IltUa71S+Jo=;
        b=YHXz+g7sFQODL1Qa26EY80NXyPsX0wERB1mG6laungxQnKcS0fDMWom8SBayucM55S
         2mNcuuNz5snYu4v3bEzIn92DTPoXJUcRvpumjdudUm0hPAHCnpSsBm809j2Bd/O55DZI
         FmBh28xUwo72LTlKYNuYopPhTaAUNPOca6dDuiZPMMYru49h0EyYY+nLkVs3uR7G5nRp
         gD0KWIRkQgTPM21RioE8Lo2h5ob12TQRrT8w0CdB6QNQorN4hw2x5uNFIqErNmIvfAF1
         J5JLbPGC+IEFsTAp9Ab2SMEQTlBtlXtnWRU5QayZ3lLkZ+UtsrAnlG8rkyhZHGAQoAZK
         6YTA==
X-Forwarded-Encrypted: i=1; AJvYcCVEZjH1LPo3lNHwPwgpt37AaeIhKRu7B7/fvMzNr1M/P3BI+b2MbzUK8OHOGDZCo+lud2+IY3VvhwD5P/kF5jx7FlQU7iHHoyVaEQ==
X-Gm-Message-State: AOJu0Ywy+7S3UfOF4km2YHPQ+smoUePl0NG8JwtD6IOHOBuFYZub4BOB
	G4QBCb78nNfgYqD/8KNKPSfjBmkWPGyVwcsQwzNcvdN6kOIKSF0V
X-Google-Smtp-Source: AGHT+IFCZwgKrh0/FpPp+LNk8Fihikr8X/13T4IV1SXzwRmQAgU3WySrwdbv+9xrEOLIVOhYUH6cjg==
X-Received: by 2002:a05:6358:895:b0:17a:d4c0:d59f with SMTP id m21-20020a056358089500b0017ad4c0d59fmr8590441rwj.4.1707820478348;
        Tue, 13 Feb 2024 02:34:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVr1VRSr3Abkn6yFoVxdeXnex6UspkJ4XFti7+v03ZZUFwQa7mbH+5An9fWSNmrIg1FHoCGS8tdcNAcC/x+Z3xj5G55SnVIHG9VAaP24Br6LvV5z8n/YOlZSPjGABL2YXREesEp6IwBf9n+QTBb/5CVrd5SApUHZfMefHnwx4eazjE1JM=
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id oj10-20020a17090b4d8a00b00296e04442b8sm2110081pjb.41.2024.02.13.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:34:37 -0800 (PST)
Date: Tue, 13 Feb 2024 18:34:33 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
Message-ID: <20240213103433.GA191617@rigel>
References: <20240211101421.166779-1-warthog618@gmail.com>
 <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
 <20240211231321.GA4748@rigel>
 <CAHp75VddjcLaRqugKuk+eejYx_0AHVL4SjYcdh7zUKDj8SpcQw@mail.gmail.com>
 <CAHp75VcjsVasfaZe25fWzzV-5vv7m7O0-v4j=pcvtWQGKtY5BQ@mail.gmail.com>
 <20240212095607.GA388487@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212095607.GA388487@rigel>

On Mon, Feb 12, 2024 at 05:56:07PM +0800, Kent Gibson wrote:
> On Mon, Feb 12, 2024 at 11:44:02AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 11:28 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 1:13 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > On Sun, Feb 11, 2024 at 06:58:14PM +0200, Andy Shevchenko wrote:
> > > > > On Sun, Feb 11, 2024 at 12:14 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > >
> > > > > > The documentation for default_values mentions high/low which can be
> > > > > > confusing, particularly when the ACTIVE_LOW flag is set.
> > > > > >
> > > > > > Replace high/low with active/inactive to clarify that the values are
> > > > > > logical not physical.
> > > > > >
> > > > > > Similarly, clarify the interpretation of values in struct gpiohandle_data.
> > > > >
> > > > > I'm not against this particular change, but I want the entire GPIO
> > > > > documentation to be aligned in the terminology aspect. Is this the
> > > > > case after this patch? I.o.w. have we replaced all leftovers?
> > > >
> > > > Agreed. Those are the last remnants of the low/high terminolgy that I am
> > > > aware of, certainly the last in gpio.h.
> > > >
> > > > Having a closer look to double check...
> > > >
> > > > Ah - it is still used in Documentation/userspace-api/gpio/sysfs.rst -
> > > > not somewhere I go very often.
> > > > Would you like that updated in a separate patch?
> > >
> > > Yes, please. For this one
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >

In response after re-reading these docs:

> > Also
> > "The values are boolean, zero for low, nonzero for high."
> > https://docs.kernel.org/driver-api/gpio/consumer.html
> >

That one is logical and should be changed.

> > And there as well
> > "With this, all the gpiod_set_(array)_value_xxx() functions interpret
> > the parameter "value" as "asserted" ("1") or "de-asserted" ("0")."
> > So, should we use asserted-deasserted?
> >

We should use active/inactive rather than asserted/de-asserted. This is
the only place that terminology is used - which is ironic as it is this
section (_active_low_semantics) that explicitly describes the
physical/logical mapping.

> >
> > On https://docs.kernel.org/driver-api/gpio/
> > "get
> > returns value for signal "offset", 0=low, 1=high, or negative error
> >
> > ...

The struct gpio_chip interface is physical, not logical - the active low
conversion is handled in gpiolib, so this (driver.h) is correct as is.

> >
> > reg_set
> > output set register (out=high) for generic GPIO
> >
> > reg_clr
> > output clear register (out=low) for generic GPIO"
> > (Not sure about the last two, though)
> >
> > https://docs.kernel.org/driver-api/gpio/intro.html
> > "Output values are writable (high=1, low=0)."
> >

I read that to be physical values, so good as is.

> >
> > A-ha, here is the section about this:
> > https://docs.kernel.org/driver-api/gpio/intro.html#active-high-and-active-low.
> >
> >
> > On https://docs.kernel.org/driver-api/gpio/drivers-on-gpio.html
> > "ledtrig-gpio: drivers/leds/trigger/ledtrig-gpio.c will provide a LED
> > trigger, i.e. a LED will turn on/off in response to a GPIO line going
> > high or low (and that LED may in turn use the leds-gpio as per
> > above)."
> >

Ditto - physical values.

> > So, can you re-read all of it for high/low asserted/deasserted,
> > active/inactive and amend accordingly?
> >
>

So, from these, consumer.rst is the only file requiring any change.
I'll submit a patch for that shortly.

Cheers,
Kent.

