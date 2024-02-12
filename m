Return-Path: <linux-kernel+bounces-61266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF885101F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A65B23911
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66417BC7;
	Mon, 12 Feb 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxzFoaJ5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D617BBF;
	Mon, 12 Feb 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731775; cv=none; b=AHjBrEMCKPmw+PnirpPABFePFSuIs/rjAtwW0xZbZcYylI1TPA57eAMc5tt1bDjtnVEYaL2R/76xaks1a5ZRl6ryQnUWLBndn+DK/MdZg2lpa423Y0bzhiqVoHZOTbE/l0cw+PHqzNSP4RQXOK+cU0aCz36ZjfeJqfY6NeItHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731775; c=relaxed/simple;
	bh=4URAa8tDZu7P3ReVqHurG8lKELL2zN0zp5fd9VP/koM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/u1aCvHpJwy3xOgTZIK7RP/FBn2ggOjRZo+VSCBWVtg0aGOzY0SpbShXfahoW7F4+Nzjs5sMc4HZPMd4oZwMwZE2Uhqc9z6QfU4HzdeljixEXmqFBPn+uEdbe9VHYKSTKceL2jVeQCjPIXwp0Nj3+zda3ynRvWzUw1A7i2ewkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxzFoaJ5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso1652786b3a.1;
        Mon, 12 Feb 2024 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731773; x=1708336573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W+BiwsPbDFRSmYf6/6OJCieBnG9Z8IZz/ZyHdMzvHIs=;
        b=HxzFoaJ50LOubUzJfGDla/kjH8/HrMx8y45ciRGy1NaCm6nAkbOo0gQMD3/srtWyH5
         EDDb5+3rY7TlPzCyjtzQ7t/+LuIYVud+g84mtFsSEhbNBbTgymQTP1H1FSRoR1Xhj9YK
         iCQZ/Ql73V1xL41cBQ6ejSJ5myHHGKSGlv6dacrwN6z9+i5XSjDl4n3EiHvKpFNUukUn
         ANaWfCpB1E1DzfJTUtGYhkqy8ZkEDGerIuGJUJG01YErelVck0BWqzOalj2O6Mmmc95r
         DyM6jNuU6TLTJwq7wsFQdWmZRGUFsxjoS3Qz4G94MxSUNVvMmKqvSiMZaT+b37uMgHtb
         acSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731773; x=1708336573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+BiwsPbDFRSmYf6/6OJCieBnG9Z8IZz/ZyHdMzvHIs=;
        b=gUklk5w1GQvTL9ZTSFfq2GWBZs2/HGh/A9jLhhrsM1D+dRm465E2v+oSMWc0eVK4+M
         sriSe20V1Im+TSPq56bGTKaHDPeV4S+knrnAkDul7od0sH0iL5HkQ7l2xkgHH1sBv9+/
         sNNVzHAiIJSZOFhSgYlm6Ec0D0QX0PYMZzbNSTUnB6oQnqxeAbmbivuitscX6xTTh5Tp
         3RFvZUOmENoTgad/lsI5JxNBhAliediqb2CXbv5BhYl2cIWHI7l5UdBvpV/sX4jGIIRB
         G6x5k91W/ooZdhp/LsfKWnd6SeDFVpLcfbCW+pggP391wK3HdanklBm3zTjKdWvEKIHF
         yi+g==
X-Forwarded-Encrypted: i=1; AJvYcCXCANxSTrbEa5gKfmF/J/x4nYmwFIx9/rnkrlhk4dlSHNgpRZhjJpGvt6eGaYN2IBOT+aJR4XiEOnzO2drTEBuTkSdLTSLHoNpfLA==
X-Gm-Message-State: AOJu0YwgD/CFfNsBOtThtj4UwD8vuGaoguNJCAnWmg5pzbBtTLynm8sS
	LGuL4LRbsCh91xmi/CO4WL6Q6Dk+m45juXT2MG/LE4BtalI7nFaVy2BE4yRf
X-Google-Smtp-Source: AGHT+IH5O61DmcDR/98uJMYb9gs4Y8BvkvPWclgfLBn+ehxQch5lEBhEBe+YwJrFNRNoPKe1BJboNg==
X-Received: by 2002:a05:6a00:92a2:b0:6e0:50cb:5f0a with SMTP id jw34-20020a056a0092a200b006e050cb5f0amr11465909pfb.12.1707731773028;
        Mon, 12 Feb 2024 01:56:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQlIXlL2mBR9r0KtkHfX+mjJeuF8G+k6S1FmCtkYri+u4cKy0Yt+s2fCgVgH/l81rH0oo0kCL465POvvFQkVbroWpTyHM2cv0lHExVC+zoiwPAHT8UaV2k7FUFUkNUZ0h9aV0kFyICW2XF+F5RDVMIsqpUtbEOl4yW2zsjSg+vmTJSK5c=
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e0938f7c57sm5378682pfb.121.2024.02.12.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:56:12 -0800 (PST)
Date: Mon, 12 Feb 2024 17:56:07 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
Message-ID: <20240212095607.GA388487@rigel>
References: <20240211101421.166779-1-warthog618@gmail.com>
 <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
 <20240211231321.GA4748@rigel>
 <CAHp75VddjcLaRqugKuk+eejYx_0AHVL4SjYcdh7zUKDj8SpcQw@mail.gmail.com>
 <CAHp75VcjsVasfaZe25fWzzV-5vv7m7O0-v4j=pcvtWQGKtY5BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcjsVasfaZe25fWzzV-5vv7m7O0-v4j=pcvtWQGKtY5BQ@mail.gmail.com>

On Mon, Feb 12, 2024 at 11:44:02AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 11:28 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 1:13 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > On Sun, Feb 11, 2024 at 06:58:14PM +0200, Andy Shevchenko wrote:
> > > > On Sun, Feb 11, 2024 at 12:14 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > > >
> > > > > The documentation for default_values mentions high/low which can be
> > > > > confusing, particularly when the ACTIVE_LOW flag is set.
> > > > >
> > > > > Replace high/low with active/inactive to clarify that the values are
> > > > > logical not physical.
> > > > >
> > > > > Similarly, clarify the interpretation of values in struct gpiohandle_data.
> > > >
> > > > I'm not against this particular change, but I want the entire GPIO
> > > > documentation to be aligned in the terminology aspect. Is this the
> > > > case after this patch? I.o.w. have we replaced all leftovers?
> > >
> > > Agreed. Those are the last remnants of the low/high terminolgy that I am
> > > aware of, certainly the last in gpio.h.
> > >
> > > Having a closer look to double check...
> > >
> > > Ah - it is still used in Documentation/userspace-api/gpio/sysfs.rst -
> > > not somewhere I go very often.
> > > Would you like that updated in a separate patch?
> >
> > Yes, please. For this one
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Also
> "The values are boolean, zero for low, nonzero for high."
> https://docs.kernel.org/driver-api/gpio/consumer.html
>
> And there as well
> "With this, all the gpiod_set_(array)_value_xxx() functions interpret
> the parameter "value" as "asserted" ("1") or "de-asserted" ("0")."
> So, should we use asserted-deasserted?
>
>
> On https://docs.kernel.org/driver-api/gpio/
> "get
> returns value for signal "offset", 0=low, 1=high, or negative error
>
> ...
>
> reg_set
> output set register (out=high) for generic GPIO
>
> reg_clr
> output clear register (out=low) for generic GPIO"
> (Not sure about the last two, though)
>
> https://docs.kernel.org/driver-api/gpio/intro.html
> "Output values are writable (high=1, low=0)."
>
>
> A-ha, here is the section about this:
> https://docs.kernel.org/driver-api/gpio/intro.html#active-high-and-active-low.
>
>
> On https://docs.kernel.org/driver-api/gpio/drivers-on-gpio.html
> "ledtrig-gpio: drivers/leds/trigger/ledtrig-gpio.c will provide a LED
> trigger, i.e. a LED will turn on/off in response to a GPIO line going
> high or low (and that LED may in turn use the leds-gpio as per
> above)."
>
> So, can you re-read all of it for high/low asserted/deasserted,
> active/inactive and amend accordingly?
>

Well that got out of control quickly - I was only considering userspace
documentation, not internals nor code comments.

So, no, not today.  Looks like you've got the internals covered though.

Cheers,
Kent.



