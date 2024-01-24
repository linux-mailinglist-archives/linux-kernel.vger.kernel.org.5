Return-Path: <linux-kernel+bounces-36212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D8839D98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BE71F28189
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C7EA9;
	Wed, 24 Jan 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFnBGaXx"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F524620;
	Wed, 24 Jan 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055534; cv=none; b=YVLssh9o0tCGaoKByf6PDRNLWeJjuOGhvACRb+LxhaZlqsXIHv6jKOUawVxXhjmDB58vKkycFKaMA0rpClvYSvMwKIziczYr13QTMPKcc6CXAe8ooF6tXlBEP3ucBxdBx8w7/U37nB5Yrl9J2JYqq1Zqf/odyNgRcglEFPHbUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055534; c=relaxed/simple;
	bh=wkjbYBnZAVGO6KJw1u24lT10qLDDTdAcPI1R+p6epdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwFWi+wgV7T2s4czldQiSVX3c/So2epS6iI/wG6HUwBKEHZv761f5q/77SxCmk5+v5OvX1y1W/k+HLxcv/n93BLUPiZtWDHwY93E/LWII+ZqT3M5tcebLnYsXouXbUJBNzdNZDkwSSJD6mdTPU8MFcqCqtSWMv9E8MsSH46XUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFnBGaXx; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddf1e88e51so3708931a34.0;
        Tue, 23 Jan 2024 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706055531; x=1706660331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2odH5pLJYN3YATGCXEp5FH96z/xY+LW/aIByzzRMUEA=;
        b=aFnBGaXxDmyzJNjjnr3mR3sMKU3/BXbtrjcxQBlT5I2ulvsZmswRAiPBVl6PjmtBVj
         TS0/bK+yCTpnGKSqpJiNerE3kQT0Lfs4GC6+bOygt+swN7NNltxnKClCu0pvrrwQYHU7
         LTnjjTT5ayhoqWWvNZTfO27jkazEnbhjHycsxcnDMwQR9BtejJw8ldLqShfQMNk5vX1k
         WfsD4I+c1zZ1p2qmfoqxOZCyJdbcSmBY/R/9Ac9ph1OWKcZtGet5qLzNYQBzNdCmEDuv
         vI2rqO0fonVIcyqxiF8b6WP+hCxMyEEUGxl6LF2KDmOCEBEZU5s4llY6Fvy9rn20JUds
         93PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055531; x=1706660331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2odH5pLJYN3YATGCXEp5FH96z/xY+LW/aIByzzRMUEA=;
        b=DU1Zw2Ce7ffyIqoVTdmBLTIoFwR96TMt5N48OGPp6Vg46wcYnZzkwMfr5x5gySGrBN
         5Tu2cc+yxt862MKEdY1NVphSoAdp07opbIf/qiNu6CkbLvESbCxLwifi4luqGXSfUHHi
         x82bnCQwFGKLLNyR3BL2WnMJwYj2QFuL/FJPdcwE3o9EXT4cm0x0N/4cS1NWDbGzPJMC
         SR6QlXlhLPKS3vY+ngw+Gx7rsXUp7Xk0VnJQE5zDRyK/glg3hu87GU/6X9FhKUyqRd5y
         Rp1OuBoSf2KpH7u4ugME+vQ9SiwtTyG33j3CPxIwpVLgxCe+wiUNtZ9Hk7/uD54H2ZLg
         AHhw==
X-Gm-Message-State: AOJu0YzOTkFmDpexsO/orm3P/7qwZQurpYcUObpsRc/38jfVgIHZobNV
	agIbvvZjHrU4JbbBJkSG6fCEmjzy4/JEU0SiG+XMskZnlON7yIse
X-Google-Smtp-Source: AGHT+IEyNHX43xDPAsYsJ4lkRre9gkAYQutyj6do9zeXlnpbSp2srE0pxVivxAxebptDJWoap1RNlw==
X-Received: by 2002:a05:6830:1d66:b0:6da:46fb:76c with SMTP id l6-20020a0568301d6600b006da46fb076cmr787128oti.8.1706055531647;
        Tue, 23 Jan 2024 16:18:51 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id h20-20020a62b414000000b006d9a9727a8esm12652661pfn.178.2024.01.23.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:18:51 -0800 (PST)
Date: Wed, 24 Jan 2024 08:18:45 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH] Documentation: gpio: describe uAPI behaviour when
 hardware doesn't support requested config
Message-ID: <20240124001845.GA4578@rigel>
References: <20240123133828.141222-1-warthog618@gmail.com>
 <CAHp75Vd1dipGkCgQBENN3rLeUO+eQfOz9uKzz86eK755smqGag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd1dipGkCgQBENN3rLeUO+eQfOz9uKzz86eK755smqGag@mail.gmail.com>

On Tue, Jan 23, 2024 at 05:44:52PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 23, 2024 at 3:39 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > The existing uAPI documentation does not adequately describe how the kernel
> > handles the case where the underlying hardware or driver does not support
> > the requested configuration.
> >
> > Add a Configuration Support section describing that behaviour to both the
> > v1 and v2 documentation, and better document the errors returned where the
> > requested configuration cannot be supported.
>
> ...
>
> > +Bias             best effort
>

This documents the behaviour of the uAPI as it stands, so is your
problem with the documentation or the uAPI?

> So, best effort means that in some cases it won't fail. It reminds me
> of the baud rate setting in serial (TermIOS). The question here is how
> does user space know that it fell in one of such cases? (In termios
> the IOCTL updates the respective fields and then user space can get
> settings to see what has actually been applied.)
>

Best effort means it will try, but if it fails it will continue
regardless.  So the configuration is advisory, not strictly required.

As stated in the docs, userspace cannot currently tell, at least not via
the uAPI.

> Floating line is not good in some cases and user space really wants to
> know that and treat it as an error (if needed). Hence the above Q. I
> believe this needs to be explained in the documentation.
>

Indeed, and I think it is explained in the documentation - worst case it
will float.  And you wont know.  That is the way it is.

This originally came about as setting bias is entangled with
setting direction in gpiod_direction_input(), and it is best effort
there.  The reasoning stated in the doc is what I recall from
conversations at the time.

Adding bias support was the first bit of kernel code I wrote so I wasn't
about to go refactoring the guts of gpiolib - though if I were to do it
now I probably would.

If you consider the current behaviour to be a bug then we can change
that behaviour, e.g. clearing the bias setting in the line info (bascially
the desc flags) if setting fails.
But if it is baked into the ABI then we need to extend the uAPI,
e.g. with a flag requesting that the bias config be mandatory.

Cheers,
Kent.

