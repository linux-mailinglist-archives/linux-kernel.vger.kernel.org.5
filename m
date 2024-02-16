Return-Path: <linux-kernel+bounces-68642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703F857DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5974B21109
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EE129A71;
	Fri, 16 Feb 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h13ONrh7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4567869C;
	Fri, 16 Feb 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090180; cv=none; b=WosezjPvp4WCXwz1qktQTsSi6ucoacGSPLPjCmT1QEdX17+/bdN5YUGTUck94qQWzN3OcAtAEzxVZc0JcZw05TZeUXNajjK6F5dIry7kHVnBQWBdQctRSV9JVxQtmRbKKnt99VmR9kM7GKDl3BL6HQoJ7holFxAh9mTZkEZDRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090180; c=relaxed/simple;
	bh=XNC+6/Otnw0WK31kMnwvs8qS0JEBOeN5lP09U8iWhcE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McyKherk4yiS+oHVW02BMZWyY4D0Mv3VSC//lhXnqMdbKdYGQArhYuVsFkbv2OAYGgXL87IUZ3KO2iXtP5pU1XmR95OCHpERyyv4PvPsfyfV5tw3HuQWFHwAdXR98qvzACAv1LpRgOepRpL16vUwwBrsiEb4WLwYan3+Vf2d0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h13ONrh7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563e330351dso895722a12.0;
        Fri, 16 Feb 2024 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708090177; x=1708694977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZruYQtkO+3BS3qcvdN/BJMk2n98rBP4bnPkKxou/uo=;
        b=h13ONrh7K/oif1N0lf3/zQ63fw8J6KgGvyoL8Kw7hwRFnOmUi8Isdl+AhuRiBiuCsc
         njLKApAtM2KxnYmpy9DBj9G7OX9qWoCtJO0tZHelHcWtCypMgMnWuX1HE+RLJrihv8VV
         4xDNYrcRoYvBVr/2qL/qwBJEptok3BJZ92OqSPVTj1v/lr/JTazRtU+z4J2z01D/HITR
         7zKC54aWdzTWVTCgBO/xHRMMUUYgJpvDTPOIpA/sFUys4KyKZUWtycQocnmO1NAdJKJs
         BXlcJNDz/5BszBqBtEubcJcj9rBnSFmIBhqXO89rCFAWVwyxfjMOcCOgJW2vd9IqMxeA
         9t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708090177; x=1708694977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZruYQtkO+3BS3qcvdN/BJMk2n98rBP4bnPkKxou/uo=;
        b=v8AFmv73KVXkzDSKsmwqqL0c22YhQHcI21COb29NkDBaaJgPlC5shsz89gJ02QJXVT
         WpXcZCMJ9puy5ZTt+whsjnAG1HioUtzQdvF6SWI8mQh+t4BBDunhtuVoKCr1/jtxYsAb
         9w14QTyzdhvvYLGII6tYrGxcjH6hlAV4y2tSNJ2NxBTEUM9YdNcbzggcf4J0EwrVEM7V
         Dot4c5stvsJECQyshBBl/oysENi3BuVYwp+aZU3beZ3UcGtHWtWOOddq2HQ47Sb+v+VM
         zLaqaUApQFb1AEAerXQjI3xn80VqZUfONUpdIFief7+iBxDZUtHow7IplCkQncXe7KCV
         MIOg==
X-Forwarded-Encrypted: i=1; AJvYcCUfDNgtAJFlLTsPZlACnNV0RA/NbZvsgisuyL+495bUswD4QvpTMwNtKwbgbMvQBwOzH88Xd0Y6kZ1gSliSvcVw8vDj6ezpR6c1uHR4F1mZlW9hG6L0/0NGpZkH3QRnGyQEjLbkG3wq
X-Gm-Message-State: AOJu0YwMyQPiS2FvPtOJqL81xCYIhsJQZRDiK16Wysol9hOfQvtnMLga
	bb0qj+STnSKmdehtckb3n7ZwFleaCUzlhXLzybHxDBJGeIUuBD87
X-Google-Smtp-Source: AGHT+IG5EWpFRlQvxlO2MTT+wcIsZkecz8kpjq4nrVGUe0hsv3jXsHsR4CWx3hfCA32VYY7OARf4rw==
X-Received: by 2002:a17:906:b0d9:b0:a36:5079:d6cb with SMTP id bk25-20020a170906b0d900b00a365079d6cbmr3512112ejb.56.1708090176555;
        Fri, 16 Feb 2024 05:29:36 -0800 (PST)
Received: from vamoiridPC ([2001:1458:204:1::102:961a])
        by smtp.gmail.com with ESMTPSA id rs3-20020a170907036300b00a3ca56e9bcfsm1540457ejb.187.2024.02.16.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:29:36 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Fri, 16 Feb 2024 14:29:34 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <20240216132934.GB4236@vamoiridPC>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
 <Zc5D35_4FdERZXe4@smile.fi.intel.com>
 <20240216110543.5d6289f6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216110543.5d6289f6@jic23-huawei>

On Fri, Feb 16, 2024 at 11:05:43AM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 19:03:27 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Feb 15, 2024 at 05:43:32PM +0100, Vasileios Amoiridis wrote:
> > > According to the datasheet of BMP38x and BMP390 devices, in SPI
> > > operation, the first byte that returns after a read operation is
> > > garbage and it needs to be dropped and return the rest of the
> > > bytes.  
> > 
> > Thank you for the patch, my comments below.
> > 
> > ...
> > 
> > > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > > +				  size_t reg_size, void *val, size_t val_size)
> > > +{
> > > +	struct spi_device *spi = to_spi_device(context);
> > > +	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];
> > > +	ssize_t status;
> > > +	u8 buf;  
> > 
> > AFAIU this buffer is not DMA-capable.
> 
> Doesn't matter in this case as spi_write_then_read() bounces anyway so you don't need
> to provide it with a dma safe buffer. It's in the docs, so we can rely
> on this not changing.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L4391
> 

Since the read_flag_mask can be used in the struct regmap_bus, there is no need for an 
extra u8 buffer to manipulate the bits. Instead, the reg value from the function inputs 
can be used as in any other case.

