Return-Path: <linux-kernel+bounces-102533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291DF87B374
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34EB2829D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08953E2B;
	Wed, 13 Mar 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcLw5MmA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFF51C33;
	Wed, 13 Mar 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365298; cv=none; b=IhVKNTEY31PNKVDzx6TzWe1ho0nAh+wVPUrMM3922ndEBYQGnB/08GLk9n0oDmHHIcprnXJZdl/z6/mD4iAg1zb7Zmn3unhfwtgxzGFqd0J3OJWnHEMUa1CsFIXjdst+xEwr5fIoCz49DgrhcwhEAsdbafP8IfG+QgDvunaWwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365298; c=relaxed/simple;
	bh=BCSQ3+Avo31GBuSK1eBVxjpyATy24CW2Pg0XWqSmcNo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnqvwz4JeLOijmfKpI52JC9sx7Y3XiW7lGf1OWV8LyK13rQVw4KwYRLD9qDIgsuVzoJTh6exRdVcM9TdIl+eSo6FRroEDpmL2BVcg0T57z4TB/Mz19mXqKAqDFcXoi1Dn90+NkZvmMgloCxnTa+j/Ja+itZMRtP9V1yiGW2h18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcLw5MmA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512bde3d197so354667e87.0;
        Wed, 13 Mar 2024 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710365295; x=1710970095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wUCdfTlBp/YfXMcGHoinplBi1n5Hc9gQtnu97VJ3AM=;
        b=BcLw5MmAh81z2EwWlbUNZQlm+uSlh3dlD9IUnRv25j4WsbiQOmd5C0BVa6MqdM7SF5
         b1W6Bats8zJp+oxt/Ome21l5TSW0UOpq9jvesYutTJEBvoeuWkZe4HptphuPkhPUtlw8
         NsNuGLq3Eg7p8mBbrUoKHrLveSsxvGmON+jAhGdk55DRhqnwSP+lwta4q808kmoRXTsW
         vqPMQ9azSJyhWls7UINXRgz7d6o97PhwfLLY83Lp3XfuDieF1Fy8uKY8+LlWbSqLF+bR
         it8cfQ1q5ORlk1BRh1GS1fevkfPQYJ2GlLT5WnFMUn0pc72juGNS0N7MfSBMmB3M+hMH
         3Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710365295; x=1710970095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wUCdfTlBp/YfXMcGHoinplBi1n5Hc9gQtnu97VJ3AM=;
        b=cO9q6+I1EnqVfP1PgHHEOkIi/TJvDELxnCIArIdkYRdWddz5q7AF/c6WS/jWvTWCZM
         D+jh2s2SPZR0TUqB53fzAzEpIPpEwt6NN+aDkJBXwVqffoApzsbzODX4WFiEB2RMZxHk
         ftuFvbyRUC8uVmr6unRF0TVfiT3+AtuK/dGuyJQ7AJ0mPjr6PxDtzMKmCFsWxsRWhTJl
         gC3jh0oE7o23OPdbAv3JjcGt8FCO8f9laxj6/avvsDGguQLKVWMdMdUchmvmdK83k2W3
         11d9fcLv6qWrBf6OutXudkwQuj7vN/wwW9Dl19WgDkb/x9PXYf8YMgTnBXg05hI5dLj+
         mtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrR33uOGiB3sZpSSvF3D6m5LLw/sJw7DAbDjPgaOf5z0iA/SEx3Uq+mT/8cuDkaQ/AdHpgOSi61/H4dEa7Ud9qe353Bce32tFuhQysJerzQ/yzUYnCbZZFkkLnFv4IdJQBTZa5uI3/
X-Gm-Message-State: AOJu0YwpQCtNCKBlxhipcN9pdGlKUDXTTEKNSSmSEiqcyOdxP+3Khlky
	tORE0MvFGOMwexmhOm21k6eahq+jL6IG34gdpNt9InoizvXO9UKRxyCHoSey1xRTMMA1
X-Google-Smtp-Source: AGHT+IEVCmrFmrgjqtlbrDET6wNonKrGfPLfqUhPKf4RxeIDdMLFV3rnnGXXDn/UOS0Nj4hV9P9HVQ==
X-Received: by 2002:ac2:58e5:0:b0:513:9e44:c68c with SMTP id v5-20020ac258e5000000b005139e44c68cmr7559056lfo.6.1710365294951;
        Wed, 13 Mar 2024 14:28:14 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709062dcb00b00a4662df0319sm31379eji.65.2024.03.13.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:28:14 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 13 Mar 2024 22:28:12 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <20240313212812.GE1938985@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-4-vassilisamir@gmail.com>
 <ZfH4bET-HX0e3PO_@smile.fi.intel.com>
 <20240313195110.GB1938985@vamoiridPC>
 <ZfIGtUPZpyDBnWwz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfIGtUPZpyDBnWwz@smile.fi.intel.com>

On Wed, Mar 13, 2024 at 10:04:05PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 08:51:10PM +0100, Vasileios Amoiridis wrote:
> > On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:
> > > > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > > > able to calculate the processed value with standard userspace IIO
> > > > tools. Can be used for triggered buffers as well.
> 
> ...
> 
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		switch (chan->type) {
> > > > +		case IIO_HUMIDITYRELATIVE:
> > > > +			*val = data->chip_info->read_humid(data);
> > > > +			ret = IIO_VAL_INT;
> > > > +			break;
> > > > +		case IIO_PRESSURE:
> > > > +			*val = data->chip_info->read_press(data);
> > > > +			ret = IIO_VAL_INT;
> > > > +			break;
> > > > +		case IIO_TEMP:
> > > > +			*val = data->chip_info->read_temp(data);
> > > > +			ret = IIO_VAL_INT;
> > > > +			break;
> > > > +		default:
> > > > +			ret = -EINVAL;
> > > > +			break;
> > > 
> > > Is it mutex that prevents us from returning here?
> > > If so, perhaps switching to use cleanup.h first?
> > 
> > I haven't seen cleanup.h used in any file and now that I searched,
> > only 5-6 are including it.
> 
> Hmm... Which repository you are checking with?
> 
> $ git grep -lw cleanup.h -- drivers/ | wc -l
> 47
> 
> (Today's Linux Next)
>

I am checking the drivers/iio of 6.8 (on sunday) and I can only find 7
drivers that use it.

> > I am currently thinking if the mutex
> > that already exists is really needed since most of the drivers
> > don't have it + I feel like this is something that should be done
> > by IIO, thus maybe it's not even needed here.
> 
> > > > +		}
> > > > +		break;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

