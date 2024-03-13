Return-Path: <linux-kernel+bounces-102456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B387B25D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D653B283EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D99E4CB38;
	Wed, 13 Mar 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiWcLg9w"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03849482D4;
	Wed, 13 Mar 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359765; cv=none; b=XoQo+LMWVFPxcDXv1NyjmXGYxoahaEgFFkoDCze/X6NxlJb6TTC3/490UuzdRpR8BpLJjfPNCEr+ly46uDQ/Bi6Wxb4apVncT0n+yPe1xfciXpmr3CTjC7KWODyIlIKBPCphTsP7hY5I0k6DDYQAJHMOWUsqyr+VRK8EwYIx7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359765; c=relaxed/simple;
	bh=GopJVs09YC8B31IStPnxUVp3Zcqx8IaRJ1z0E3WCq0k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPOhY6LpwYz6NbcvuNGsqeWgQDHFCC01nnW+yJ7xAfGSPL+jAw9iToH45Ztp/pSdA8pZld8fJQvzFxc/P50paxaSm0fWd7ajNPRwqnrQ36qMWYQEl5en7lYdYrD1Xlisre9Lj30SUWvekJyHFUn9HSDTSz62afhBiI0WgQ7xDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiWcLg9w; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so332142a12.0;
        Wed, 13 Mar 2024 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710359762; x=1710964562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UlZ0qXaHrxjPwMvupsh66nrXfN2ATU7nRdRC9at3BQ=;
        b=UiWcLg9w0yPFsN9FFfMndmgcVmT08WTiN5Ux6HNTSED+9wMtxPyhp7v9pYR+IStVOy
         u04w10L6kEh9Mj2s8D9JwKVT5D736fLOKKHFf/xMXdQooIZKcL6XL+AvoSGOFbEYHqTC
         PrGduPtSMg+9kIUMpLWyQsKmrZPCtW9e3ltacKaZR+LdIXru3gtfdqfWQGfikEn/v3KZ
         e0rxeCOo8Ldj/rbQFA5qYd+3t9M2gQgkwUxo6HE4cTaEUrUIiY2gZCoqApSuufz8KJ/1
         txZ9UqBnugyowESgcDuIxmm+CcgZrbjdKMGD/spT6wpT/hhJnMY+8OzYV7aHdatRgVA/
         2ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359762; x=1710964562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UlZ0qXaHrxjPwMvupsh66nrXfN2ATU7nRdRC9at3BQ=;
        b=mF446DIGkIW/XS+4RcdAtQAkK9YcU4OrDfml8dOagUoAepctjjRRCXhi6A9SAjWCDV
         8tYVr7nt4myn0LT/CisawcjY9dtkkL0w0US8rfkz3Lk5WMA7eEZMd4gqlxmuXiIgT1iB
         4Ju3mIv0WFkGyFZ4zqJEpfjpL6rIFR7nvWPMZKyEpWDFeLDtBmxvU+9UErg3fOZm/hAb
         QzqpHt0lFYHHzBlW8lMG90f5EBrSJZWYPi/WAFaQcI91o2plPnQuncsOePdF/oTvRPzp
         ltKAquMm76VRNDLnMGWuDsRwn7Bhd6DzOup3FLcAcnOIEEpP9vXTjAuvbgZ8ZAHcSHBu
         meZA==
X-Forwarded-Encrypted: i=1; AJvYcCURIwHcZCUQLaQvR9A97ejHhD4subIJROETZ4aydeu3d3lNE4+MJF9UNTNggsIqXiuXXWjI0VUMM3DrxSqCZuKuddmJEGWJi5R4CW+DnWcLm3qpq5mzM7dMlbD1go+HiEjfdITPfD0w
X-Gm-Message-State: AOJu0YyffH7ZIVwz2OVCDONX3XtViIT1zhTUFC36xqRgXMGlMNN8JsX9
	kiCqc8fug0YmtIP/H5YmDMetX9CLqVCPmOwi/FfOJm1GifUjQ3Y2
X-Google-Smtp-Source: AGHT+IH8cNdgWX+LUUV7wY6S2o3bUPbzsboy+KMW8TCu6oCxNEmi/ELSH1RwS2TTqnG4UygXYJ6MKw==
X-Received: by 2002:a50:9b5d:0:b0:566:fbf5:a279 with SMTP id a29-20020a509b5d000000b00566fbf5a279mr2995432edj.20.1710359762056;
        Wed, 13 Mar 2024 12:56:02 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402004800b00568550a0762sm3716486edu.6.2024.03.13.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:56:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 13 Mar 2024 20:55:59 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <20240313195559.GC1938985@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-6-vassilisamir@gmail.com>
 <ZfH2dxmSzcw1_3vt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfH2dxmSzcw1_3vt@smile.fi.intel.com>

On Wed, Mar 13, 2024 at 08:54:47PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 06:40:06PM +0100, Vasileios Amoiridis wrote:
> > The scan mask for the BME280 supports humidity measurement needs
> > to be distinguished from the rest in order for the timestamp to
> > be able to work. Scan masks are added for different combinations
> > of measurements. The temperature measurement is always needed for
> > pressure and humidity measurements.
> 
> (Just to make sure if you used --histogram diff algo when preparing the series)
> 
> ...
> 
> >  	{
> > -		.type = IIO_HUMIDITYRELATIVE,
> > +		.type = IIO_PRESSURE,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >  				      BIT(IIO_CHAN_INFO_RAW) |
> >  				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> 
> Stray change
> 
I didn't notice that, and the checkpatch.pl didn't actually say something,
thanks for pointing out.
> >  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> > +		.scan_index = 1,
> > +		.scan_type = {
> > +			.sign = 'u',
> > +			.realbits = 32,
> > +			.storagebits = 32,
> > +			.endianness = IIO_CPU,
> > +		},
> >  	},
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Vasilis Amoiridis

