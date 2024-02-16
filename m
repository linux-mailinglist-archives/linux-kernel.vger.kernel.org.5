Return-Path: <linux-kernel+bounces-69113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A748584C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF01284254
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99180134CFE;
	Fri, 16 Feb 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv7mNiWr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F91339B1;
	Fri, 16 Feb 2024 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106623; cv=none; b=apKYCRSDKUl3j8pFw6MctWWjf5q3tfiGWbQxS6+7VSeNGelppo3GXf2XfEfa18/lYWf0IpukdihQ/IY5C8zm/x6MLkBS/HQAQ6z+acyXYHkSP/q9fnk6xeOfvJjWXpaSa4EujWgcsDXrGull/wCEmzhh6ADanItXEupfs939P0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106623; c=relaxed/simple;
	bh=k4JUf4tEgF+ZTNcSICdK73ztE/zkp6cdsdcD3cdcRXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCYKsln1HPCfEdJjhq9RVKjib4v7KjWvFn7gFiy03SyDT97QWGGDEM4xirwy5RUlNsyXZxE8faBzf5GpCkxj3zGfm67S9BZNpIjq7g/rnThioSCIffKnHmGfjGz7sB3y2Ow79r0xuPiIgiok1cfRzvyzaUPwnFmf/OTdA+iDIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv7mNiWr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5128d914604so2009210e87.3;
        Fri, 16 Feb 2024 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106620; x=1708711420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jrmz6zDR44TvQ+brUsRRWaHMMl1NQ48wtumgFrZ6enM=;
        b=iv7mNiWrl3jQ8JeslfOSK5FGJBcixm6ddRK3x7Nb0JvjrkOmqVW+Cv21RLJfHEJMPg
         kdJinQ9IElkinkFbYrFE9snoRFoYTmuvlQU22CMwWsm7LRmY4hciIaIgp8ySYJ1Oh2d4
         omotI6hmw/6SbTQUSZ2cq94herdWYaH8sp9/ojGy2WBKSGNI7ScBbw1GHoXZybcCMrTB
         xehraXJUudsqEUEMT+EwQPaC0cdG02+r+effPUKmlL/qSFLNcpU7XDm59IJQFcdnWJKJ
         mN5hbHnTjjpzjuzwcYqhJNSczuLk6ZRlVotlfW67937Z79/nymo81erDztIrIuPHyM36
         VCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106620; x=1708711420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jrmz6zDR44TvQ+brUsRRWaHMMl1NQ48wtumgFrZ6enM=;
        b=icUjZoyqW8abKlRvn4K/ZtvRTXzJJ9rYOPL8kzvPnL8lFFSh2J+jvMKrnS/IzPIi4L
         8tnjzSsq0gik6Q4Z2prOjr26iAD0MN5i/gPQGDFuNiC1HxkNjB3eXoTg7Xc0G7Kcbr+H
         tzBaj1FC9aLraLwXKl7xk/U2gjeB0tnCrYHgH306p8rpRLnyLre6POaPAf2TgzaiKX/3
         xCNgEJFV0uD4AFaF/w6BZMFgklNP5PGM3/oL9+2Ci6q5NO1csGv6zkHzcndaCtcXxzpA
         LzkC31qKE0r/YYIJ9DOK8sBv4fyTJBjJ11sznbHY3m+NyQz/5RjDKDZPdo4cF7VvKwPo
         7BMg==
X-Forwarded-Encrypted: i=1; AJvYcCW/JqDJr6y6ob0CLhhFNwjIg0Ey7O0rjttIimCx9EDLRASuv9c35pbsSbSwZl69X7W8tvVydL84WWNuL68xvvzzbRf+PAVFaMRiPaKQmUJ6cC3bDYCrB/DFx/WePtAygRnI0+1C8gHY
X-Gm-Message-State: AOJu0YyAvJ5bfWI+er5D4ZRiD9UA2uyYW/KL/WhKR32YTvAKT7ycB/TA
	5ablxrA5flL9g3U7nHq25NvevAW+kRR5bAt1IsZVOGDfEE6hZ8ayP1TTHjCB
X-Google-Smtp-Source: AGHT+IE+spxlqHoj7KaTR0bQ6pFqc8Ygq6HcrnDGJ5st4jPvcMkE0nfK4WOkmZDMuGs4q42SUxRhLA==
X-Received: by 2002:a05:6512:201a:b0:511:ae2c:8991 with SMTP id a26-20020a056512201a00b00511ae2c8991mr3343020lfb.40.1708106619661;
        Fri, 16 Feb 2024 10:03:39 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d6-20020ac24c86000000b005128cf5b323sm30941lfl.251.2024.02.16.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:03:39 -0800 (PST)
Date: Fri, 16 Feb 2024 21:03:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: dw: Drop default number of CS setting
Message-ID: <eestmqctjaqdrugnjy23pybblzvncrbez77tc6l7fdqmfkf6rz@q44jazumavjq>
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
 <20240215180102.13887-4-fancer.lancer@gmail.com>
 <Zc5mxyTjq6X_QRsQ@smile.fi.intel.com>
 <4sbbhf4ltdwrmj7rrr6f7lnjbdxrwfjoutmcgsh2c44jy5fxzj@xgqdscqdnkkv>
 <CAHp75VeK0kb40Ma9WjMAGQE9Y5O1OdeuNhQwDvYCaLHbvj+60Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeK0kb40Ma9WjMAGQE9Y5O1OdeuNhQwDvYCaLHbvj+60Q@mail.gmail.com>

On Fri, Feb 16, 2024 at 07:00:28PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 16, 2024 at 5:36 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Thu, Feb 15, 2024 at 09:32:23PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 15, 2024 at 09:00:48PM +0300, Serge Semin wrote:
> > > > DW APB/AHB SSI core now supports the procedure which automatically
> > > > determines the number of native CS. Thus there is no longer point in
> > > > defaulting to four CS if platform doesn't specify the real number.
> 
> the platform

Ok. Thanks.

> 
> 
> ...
> 
> > > > -   num_cs = 4;
> > >
> > > Simply update the default here?
> > >
> > > > -   device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
> >
> > Do you suggest to simply:
> >
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -364,8 +364,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >                                      &dws->reg_io_width))
> >                 dws->reg_io_width = 4;
> >
> > -       num_cs = 4;
> > +       num_cs = 0;
> >
> >         device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
> >
> > ?
> 
> Either this or do
> 
> num_cs = dw_spi_get_num_cs_from_hw(...);

This is supposed to be generically done in
dw_spi_add_host()->dw_spi_hw_init() together with some other
auto-detections.

> 
> What would work better WRT hardware?

I'd stick with defaulting the dws->num_cs to zero here.

> 
> ...
> 
> > My idea was to make the statement looking closer to what is
> > implemented for "reg-io-width" property. An alternative to what you
> > suggest and to my patch can be converting the dw_spi::num_cs type to
> > u32 and pass it to the device_property_read_u32() method directly:
> 
> ...patch...
> 
> > What do you think? Would that be better?
> 

> I like the change, but again, are you sure it won't break any setups?

Well, I thought about this for quite some time. Here are the possible
options:
1. If "num-cs" property is specified, then nothing is changed. The
actual number of native chip-selects will be read from there.
2. If "num-cs" property isn't specified, then the auto-detection
procedure will be attempted. Here are some considerations in this
regard:
   2.1 defaulting to "4" hasn't been correct in the first place
       because by default the IP-core is synthesized with a single
       native CS line. So auto-detection would be more portable than
       guessing with a constant value.
   2.2 If some IP-cores have all SER bits writable then we'll just
       get to detect more than there are actual chip-selects. No
       regression in this case.
   2.3 If some IP-cores don't support the SER bits being
       simultaneously set then it violates what is described in the
       HW manuals - broadcasting is supposed to be supported by all DW
       SSI devices (currently I've got DW APB SSI v3.10a, v3.22a,
       v3.22b, v4.02a, v4.03a and DW AHB SSI 1.01a databooks
       confirming that).
   2.4 In case of 2.3 at least one chip-select shall be auto-detected
       unless the SER register doesn't permit an invalid value being
       written, which is also an undocumented case.
   2.5. In case of 2.3 and 2.4 either "num-cs" property or a
        platform-specific compatible string is supposed to be
        specified since the device isn't generic DW APB/AHB SSI.
        But if such device is discovered we'll see what could be done
        then.

So AFAICS the probability to break some setup shall be rather small.

> If yes, go for this!

Ok. Thanks.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko

