Return-Path: <linux-kernel+bounces-73466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6CA85C2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EB21C227D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAA77630;
	Tue, 20 Feb 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0g9RImb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5176C68;
	Tue, 20 Feb 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451191; cv=none; b=LMTM25KlsL0kWovbudwt2lGkeGmDlUsEM/CuVlyvCdCboo+S8Sw4JXgnlKHYuJMY4UtA5+AH+0pN687cwVz5J/A1nok62tQrtrP8s1YkNXCFaizuAf1xnTXNwURF4PbZKX1WTbj58kzAf0jACmmVcgkgUbKznWxn9zDLvLMWn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451191; c=relaxed/simple;
	bh=2EKy2CqkvTdIu5qpvui14Qtn0lAG3OX3+lJhFGyRlYk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8k3RYkn9JY34HKvxw5Zrx+9omM6B1Ucm3JhrCpBP0ZCv4vtrH/hLwHqPop/9s1ln1lWDNlBmgiS0bMw38h/8leEy+bt/0aMQM+RNtVg98M7ML4O+FzBIbI9lnvbTqjWkndFM0pKY396h7egG/gtWugMKUi4BffLANoAUaeicgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0g9RImb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f1bf03722so60014266b.1;
        Tue, 20 Feb 2024 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708451188; x=1709055988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNcMunO4PHwBceEqX1qMTz4P8ZldxmFCw2RMePfNlt4=;
        b=c0g9RImbblHOU22GdW/rw4NpfxxIdsWqWOVyQmYh61SgsnO8iSZfZhSVp2JjwqIFI9
         2Af1RPQQyudLmMuoORNczC8qBrrmR0fW8dndtc1hxx2PqRE0ZpLY0rQAzIqN3zrn7+a5
         1e8DAEcroystljLCGMGB62HDHijxJeYcT+FcrQUR39EseQynU/Ivp/DAt3zEv06H8TDA
         DwjfyrbLsyMzXcuJ+4EwOtIXxFSBOCl0EpPEwjI+iT9tjINxfau5RVhNfAdEOMtFdbL4
         40gkQLvk+UOYShfniwgRc0tuyH9oogRuu4qi2v31GxhzjFaFdy4P+cvpgPWkaQ6AbRnz
         x9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708451188; x=1709055988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNcMunO4PHwBceEqX1qMTz4P8ZldxmFCw2RMePfNlt4=;
        b=pGORlYn6HjH+NI99Atk9pKhtLhJ7okzSdryyUYHmVIbht7LhTZe026QKaNFaU+zL3+
         Aq+QPqUs2G8Dx92cAaUF4EU1EWQ6Bw9H6Sr1Zyi9cbF5dWWg9HEzkGoUkBPOvvnX4ft6
         M0KvPyKXbtwQqEvX572F5EiCnoVE3z5Wy6WWju92AjO0bg4Hy24HY9iC8BbTzZFbujs3
         LTaqZdOM/CAGmVJlBsDZIbio73dMKJ4o8nCVyNiYz6PbuHm6/04tfMbuFkXF6izWINM7
         ApVAguAmYxiqsvBWMpBa9ftHf56VjkNZi66Z5ZANvjdmHW7Y6FNdiBz96kX4ExT2ZmP8
         kfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhJrGYgnxCEA2w024oOTYtfbVLEcsOqx/xRBrUzWIEqGcqy6nwigMsX/bMdnU+G7SZxlh67lBOg2kD2K7BOFdgd0TPwpDKURshqyT/Txd1D53/3Ii5t9QZSFptp4okvgzegDCH/KbA
X-Gm-Message-State: AOJu0YyoHIsFh2rG7KoRGHtvZ7zmAJCfQ71iDRSK06fMfBLW28cv7nmO
	MjU5Z1aS0gIEwPyiS5zeh4qkgbgJcxPUXcAr21Kh3m5xVcT1Rdu7
X-Google-Smtp-Source: AGHT+IGDE30sFZ4VyfhurGzD4w8eTpZDKH/lBRf0pLRlnYpNYbeu22+ilQvETfoDNQWvybhZ/eaJLQ==
X-Received: by 2002:a17:906:b354:b0:a3e:d450:d3e0 with SMTP id cd20-20020a170906b35400b00a3ed450d3e0mr3244509ejb.43.1708451187732;
        Tue, 20 Feb 2024 09:46:27 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:3f11:8c45:6350:e419])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a3f04112c0csm687868ejb.221.2024.02.20.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:46:27 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 20 Feb 2024 18:46:24 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240220174624.GA27576@vamoiridPC>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
 <ZdSyljwOyxIY7Gvb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdSyljwOyxIY7Gvb@smile.fi.intel.com>

On Tue, Feb 20, 2024 at 04:09:26PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 19, 2024 at 08:13:59PM +0100, Vasileios Amoiridis wrote:
> > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > read operation the first byte that is returned needs to be dropped,
> > and the rest of the bytes are the actual data returned from the
> > sensor.
> 
> ...
> 
> >  #include <linux/spi/spi.h>
> >  #include <linux/err.h>
> >  #include <linux/regmap.h>
> > +#include <linux/bits.h>
> 
> I see that it's unsorted, but try to squeeze a new header to the better place
> where more will be kept sorted. With given context, it should go before all
> others, but it might be even better location.
> 
> ...
> 

So you would suggest a re-ordering of the headers with a reverse
christmas-tree? I don't see it used in the other drivers of the IIO
subsystem but I can do it as well

> > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > +				  size_t reg_size, void *val, size_t val_size)
> > +{
> > +	struct spi_device *spi = to_spi_device(context);
> > +	u8 rx_buf[4];
> > +	ssize_t status;
> > +
> > +	/*
> > +	 * Maximum number of consecutive bytes read for a temperature or
> > +	 * pressure measurement is 3.
> > +	 */
> > +	if (val_size > 3)
> > +		return -EINVAL;
> > +	/*
> > +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> > +	 * the first byte needs to be dropped and the rest are the requested
> > +	 * data.
> > +	 */
> > +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> > +	if (status)
> > +		return status;
> 
> > +	memcpy(val, rx_buf + 1, val_size);
> 
> Okay, endianess is defined in the regmap_bus below...
> 
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

