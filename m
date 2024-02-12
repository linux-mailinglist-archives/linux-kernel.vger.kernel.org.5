Return-Path: <linux-kernel+bounces-62262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF22851DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC301C21931
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232E046522;
	Mon, 12 Feb 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/LzKzah"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4333D561;
	Mon, 12 Feb 2024 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765197; cv=none; b=IrkAl7rd9fBtMhPxVIXOukMpu85smL4AuTlCKECIvM3kYIRMQt6G7p24Aq10grRwwO9OdjeQaj1xi1Yc127NUJP7UzlDdfSALtx24EqY8xq7Ip8rs9MH1A9KPzz6UNlFHGS632qPEuhvWxUEv74Pe3AFkfuS2aYccdM1nFJR6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765197; c=relaxed/simple;
	bh=sjKyP/Ui/aZeeBiNNFm9sGugbeL29/KNiXApbSxpSls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwkWxoyrDAxnDX0LJCnZOrGVIWFIh8ZOst7YN5P5pDTL/z19P6jwUXKhpNfffC7oW90As88bJrhGJ1FPkDTf3kwTGhvz9BJwzeMn2qcilgnDxDk/KwVDdLyY6hTicxXLc8taETokSO/aoy7qWE7z/PKBZRJ8DfBV0xiO9B8IbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/LzKzah; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60495209415so34006847b3.3;
        Mon, 12 Feb 2024 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707765195; x=1708369995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZe21kBcPy6KSx7IZa4AcUw4sbKfAv+h51Ru4ZWOH8U=;
        b=m/LzKzahzNPtvsskOUnw6Q6WE9WcjNpVp+drbk272zpjwnpz7d34oaYiTWSp6LI/wm
         BFEQ5cP8GmRXedsxbXiKwBOYFdUvXBSMrDKWL5x/j7dADIItjkGJzT4rrFZ/o9EIdkup
         vZmVFkR+kDMxvqotMueH/gkSVkbvjN+Zk7Ub6K5roe7bSnaCFk9DshrYn3Qa80HxxVkW
         OUobN9mJ5/5qFLwZURDid5Oco6WoHOeuINM5SH5Q6OqEV8m9S71EYeN9/K+ZPDVMFTMp
         3QO8xkAdwAY3hdfM2fhbtlS9FrSPy5V8Us3IpUsTAaj0sDVJVw4g493FDHzgOZcBKCtT
         WEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765195; x=1708369995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZe21kBcPy6KSx7IZa4AcUw4sbKfAv+h51Ru4ZWOH8U=;
        b=PIxmUAUo/nubOLfSOqhTh5Zn4xSBHRIxRrG5jqxvxDcY1O1PZDqTJJBuc6Z6b6BJkg
         6GTP1kW6cT9yv4KjEuhTHYoWWUrFhXPuQzEUaQH/zh7voG8BZI/VFegMZu4HypwfEbrR
         EdSfVnb8eGMPYddhFSShojBEywVFzNXdJJdT64JAVrfydpSGvnxt4u8g/JNfNMhyeMaJ
         Dtx8BA3WEmpo/hEzJnV4VS8J6l/RJkFKJ07YZ7z29HsaoSp0jM9cxZV0ejycTVVz0qlV
         RLWMf761+T7un8koV/Qw3sotNK1bLtInS7U25zopzEAdU99QkxGRVqDyooN2kTbBmC/c
         XCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtq5XjL8eQiTsUAlIQb4Yto+31XP2hwrv+321tS75cScvVlj6iRbpMikinWSiRh9QbwrauzZkyPW9y7e+KikOmYXOiaPWq4R9sWdytQyBQPnOOVkV0J5n31i6VGK9l7+6KoKj9
X-Gm-Message-State: AOJu0YyDLYd+tCQRkreI7FizKgBBV4CjFkFBIbrmrlP/bZRmnDb1ftLb
	KYWcxg4B7lzTETZUJA1gmY0gl9Ro0baGcxxaiEvSlxOsC82LDSu+
X-Google-Smtp-Source: AGHT+IFl6LJsfG6jRVqYDLExIYsaAihqzqU6vk5Hqvlokz2+AkO7Jtfo5penBfmuwtQEibPQUzwGHw==
X-Received: by 2002:a81:c24d:0:b0:604:cd5c:a2f9 with SMTP id t13-20020a81c24d000000b00604cd5ca2f9mr5823219ywg.30.1707765194731;
        Mon, 12 Feb 2024 11:13:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1ASV0QDP7aeAOV6u2nseazEB/qvenVbrU9hUHMbQ9Qqunpn7PAMBP/3/ftCW7daPRa72DOTHC3OcdaNfQxEOQe/wHYvmmFicrxtfHW/G7nY+bxYpp8WBFszjlI/Ql0F+acf+jKtlXEVOPcUiKc9g3Xa0JKA1A4B8cQxGj0dCXL3lOSPRFq8kthiwn3DUxAa67S16uGWggx8BnE+sAqBMpInVM9xAQahdaaXfYc0UOBw9IcIeGpuUnhpUoNBNl+u1IvAPfRryOyZc+pzg1Js2pyon0cXL9MfxyNM33FZbY1rT+FlII54J2d5XOzIJq3uTNYktlARuzWfNvOG5ZNTHLTFrn57o7xpvpmWACOnrkYcqeCbB+TVV5Qgig4VK1q6fxROrcX6HDefkykpAMNsUokffnWEDckH+WfaerJHFE9VEcGQDCPg7kViWm4lDDUxNuA9bDLz3xro9emsTI7XNLodcPnsQ=
Received: from localhost ([2601:344:8301:57f0:85b5:dd54:cd99:b])
        by smtp.gmail.com with ESMTPSA id y5-20020a818805000000b006040f198d3esm1279723ywf.142.2024.02.12.11.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:13:14 -0800 (PST)
Date: Mon, 12 Feb 2024 11:13:13 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <Zcptyd/AWrDD3EAL@yury-ThinkPad>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-4-herve.codina@bootlin.com>
 <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
 <20240212143753.620ddd6e@bootlin.com>
 <ZcokwpMb6SFWhLBB@smile.fi.intel.com>
 <20240212152022.75b10268@bootlin.com>
 <Zcos9F3ZCX5c936p@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcos9F3ZCX5c936p@smile.fi.intel.com>

On Mon, Feb 12, 2024 at 04:36:36PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 03:20:22PM +0100, Herve Codina wrote:
> > On Mon, 12 Feb 2024 16:01:38 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
> > Agree, the bitmap_onto() code is simpler to understand than its help.
> > 
> > I introduced bitmap_off() to be the "reverse" bitmap_onto() operations
> > and I preferred to avoid duplicating function that do the same things.
> > 
> > On my side, I initially didn't use the bitmap_*() functions and did the the
> > bits manipulation by hand.
> > During the review, it was suggested to use the bitmap_*() family and I followed
> > this suggestion.
> 
> I also would go this way, the problems I see with the current implementation are:

Sure, opencoding and duplicating the functionality is always a bad
idea.

> - being related to NUMA (and as Rasmus once pointed out better to be there);

It's 'related to NUMA' for the only reason - it's used by NUMA only.
Nothing NUMA-specific in the function itself.

Now that we've got a non-NUMA user, the bitmap_onto() is not related
to NUMA anymore.

> - unclear naming, esp. proposed bitmap_off();

That's I agree. Scatter/gather from your last approach sound better.
Do you plan to send a v2?

> - the quite hard to understand help text

Yes, we need a picture that would illustrate what actually happens

> - atomicity when it's not needed (AFAICT).

Agree. A series of atomic ops is not atomic. For example

        if (test_bit(n, map))
                set_bit(m, map);

is not atomic as a whole. And this is what we do in bitmap_onto/off()
in a loop. This must be fixed by using underscoded version.

> > I did tests to be sure that bitmap_onto() and bitmap_off() did
> > exactly the same things as my previous code did.
> 
> Yuri, what do you think about all this?

I think your scatter/gather is better then this onto/off by naming and
implementation. If you'll send a v2, and it would work for Herve, I'd
prefer scatter/gather. But we can live with onto/off as well.

Thanks,
Yury

