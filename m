Return-Path: <linux-kernel+bounces-32763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E72835FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1761F213CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D853A1AA;
	Mon, 22 Jan 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3wnb0vG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A537144
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919736; cv=none; b=cMt2McwmcG8NA8ECN/nG1xBCyug6knwW+MEvqbAcS7qOdkUbrfUgLMb2ez2j6V60n0RPgShu21f6en0eF9vxq3LbjWUcQpOpSDvboxvRSszShbp39fzlx0FphT0YjkNsH0QjfO8LSp+lEPDo0dnVmRfrqCEfEEaHUKnLt0xt2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919736; c=relaxed/simple;
	bh=CVrOVb5fEQr4xXoM/Cgcdqs7CVKudPEtXaZEfzR+ieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGjcoPFlVuJ0d8VdT2HaCs2a4xS1/4wnGUQj/PxXFDYA1OpAiYM9Gf2gO6kV94YAF1dETOipMA8QDTmxFvtZChenBxTxnuNeQnCXE+EFRfngCug+OC7yIaUlR+MdLaCeDrb9X8PkYm5SgiaPGzzeUDBsRiMzET52ySwJZ8QLZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3wnb0vG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso10517465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705919733; x=1706524533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUhedLANF6aIr3k765vrW+w3JqNpXJgjjbnL4/TWAKI=;
        b=x3wnb0vGkPl4WNKAvDK2tLCWm18S42VH7u/UG49bofI+XN+6o5vZl35gugNMLFgIZw
         r33Nn0GreUv/y3a5lKm6k3HMJyw8Twacv5/IkRY/2N/zfnedDxf5FY9Xm7fbjXi5koyM
         YvfxIAulM2msMkiXLBN4VIdR0F7Ha6SGJwlesmqGgmk9TvcWsuMuxn8OHwaFCJGv8b0c
         TVvJnWflOJB6Yb4j3ncE3vICot0jjdguAz2n6SkUIIvUF5lMUtFrCi02fnVDseiO8k2O
         MLtv+I/ehTgU14rVoCqiQTn7qMzbFcncb481OCRJ9eJhUOxhIDzZFDi10SQq462hi5ee
         QleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705919733; x=1706524533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUhedLANF6aIr3k765vrW+w3JqNpXJgjjbnL4/TWAKI=;
        b=K6YRmbRgcYWzrJI6uvW8AQDw1qc/6hT/MAFpA2QuSIxB71FRgu+sX9YHeP1fbjAYGx
         6ywVzMrtwSLQf8HV6DR1ARpW0zWjZztBXtfXGNtr7gzz9zoURhsxeiJs+dnPwdQ1WIZi
         dKLlVt8yC8S/oCvBZqxS1pm0/wCXcyxg2yBEQX8Spc3UpDOfReh1/dVjtjPefVFWjVBD
         bSyBpTf1O4YuAhAi6ynTi38CJ4jbcbpvKbfwAChKxSMi3stlEFoBLDJ9rEQD21Zk0Pad
         T0WljLf6FSrJlva4zlLsYpLKRDI6CbdQgi0+7f3LcCqyktCFnNVtTComOh9YVp7cJJ2+
         3P/g==
X-Gm-Message-State: AOJu0Yyh7ySsAvSje9/gMCyD+yaL/tBi1vysXtPx1MCiaSDlHpK1mGET
	R6DkG3fGhRpyITbqxAe2S46/QuKqOl8mZ8oYemMxRxkr9zAD5lVk3zk9xQloJtI=
X-Google-Smtp-Source: AGHT+IFo4uYcYhEMgaOqtoirV3HNE4KGl6mvkTyKH6pc8vp05HpIszygaGV8C/JBWJqaJ8OjRn6KTQ==
X-Received: by 2002:a05:600c:2182:b0:40e:6b84:ee71 with SMTP id e2-20020a05600c218200b0040e6b84ee71mr1168765wme.336.1705919732646;
        Mon, 22 Jan 2024 02:35:32 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b0040d87100733sm38828236wmg.39.2024.01.22.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:35:32 -0800 (PST)
Date: Mon, 22 Jan 2024 10:35:30 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/4] backlight: hx8357: Make use of device properties
Message-ID: <20240122103530.GC8596@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>
 <87bk9novmp.fsf@minerva.mail-host-address-is-not-set>
 <Za0glbPfzeTjdZjn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za0glbPfzeTjdZjn@smile.fi.intel.com>

On Sun, Jan 21, 2024 at 03:48:05PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 15, 2024 at 09:20:46AM +0100, Javier Martinez Canillas wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> ...
>
> > > +typedef int (*hx8357_init)(struct lcd_device *);
> >
> > This kind of typedef usage is frowned upon in the Linux coding style [0]
> > (per my understanding at least) and indeed in my opinion it makes harder
> > to grep.
> >
> > [0] https://www.kernel.org/doc/Documentation/process/coding-style.rst
>
> Thanks for pointing this out. However, this piece does _not_ clarify typedef:s
> for function pointers which I personally find a good to have.
>
> ...
>
> > > -	ret = ((int (*)(struct lcd_device *))match->data)(lcdev);
> >
> > This is what I mean, before it was clear what was stored in match->data.
> > But after you changes, what is returned by the device_get_match_data()
> > function is opaque and you need to look at the typedef hx8357_init to
> > figure that out.
>
> The above is so ugly in my opinion, that justifies using typedef:s even
> if you are quite skeptical about them.

FWIW I was pretty skeptical about it to. Largely because the three
touchs (typedef, variable initialization, use) spread things
around a bit too much.

Can we at least name the type to make it obvious that it is a function
pointer? Something like hx8357_init_fn .


Daniel.

