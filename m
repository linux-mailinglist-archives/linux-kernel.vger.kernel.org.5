Return-Path: <linux-kernel+bounces-73475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F585C314
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E646D1C21926
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB477648;
	Tue, 20 Feb 2024 17:55:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796476C9C;
	Tue, 20 Feb 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451743; cv=none; b=jy0GiVNmpWyrehBUeN23h2eqDhYre84a2ym76yBwwSAsvqZXf6SSq7R5Eh85JXXjZnEU8ucpmkdRXpslWc3zDDqCIXO/w/Fqn6CgmNfJjLfUHo4MPdbLXF4Mbrbz7SW0EmEy27fxfZbSxvvl0zJHBEpOowb1OqAyfZ432582rZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451743; c=relaxed/simple;
	bh=eWe42IzIU0TbHcPAOIe8fZ4Mf+FjSEsF6XZBFrPhIn0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YixL2Z6c9MWvxE4Im4pQ84fxHGCj6m5LIo05Kxy7/1j92B9H7HONfpbjR7n003iqmN2Rtzd5PACvvSE6HaUpn91T8W1OH1G4nqmO1CsfCnGSQQX061lTP2i1eZ/fzTKahOyc+M4Dq/bN2MTk3he6K7zGlzriZ58S/yHgn5XdUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfRmy43Zqz6K8qw;
	Wed, 21 Feb 2024 01:52:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FA0F140A70;
	Wed, 21 Feb 2024 01:55:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 17:55:37 +0000
Date: Tue, 20 Feb 2024 17:55:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <ang.iglesiasg@gmail.com>, <linus.walleij@linaro.org>,
	<semen.protsenko@linaro.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240220175536.00007440@Huawei.com>
In-Reply-To: <20240220174624.GA27576@vamoiridPC>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
	<ZdSyljwOyxIY7Gvb@smile.fi.intel.com>
	<20240220174624.GA27576@vamoiridPC>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 18:46:24 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Tue, Feb 20, 2024 at 04:09:26PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 19, 2024 at 08:13:59PM +0100, Vasileios Amoiridis wrote:  
> > > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > > read operation the first byte that is returned needs to be dropped,
> > > and the rest of the bytes are the actual data returned from the
> > > sensor.  
> > 
> > ...
> >   
> > >  #include <linux/spi/spi.h>
> > >  #include <linux/err.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/bits.h>  
> > 
> > I see that it's unsorted, but try to squeeze a new header to the better place
> > where more will be kept sorted. With given context, it should go before all
> > others, but it might be even better location.
> > 
> > ...
> >   
> 
> So you would suggest a re-ordering of the headers with a reverse
> christmas-tree? I don't see it used in the other drivers of the IIO
> subsystem but I can do it as well
Separate patch + alphabetical but in blocks.

linux/*
then
linux/iio/*
then
asm/*

First 2 can be combined though if you prefer that. Any asm definitely separate.

> 
> > > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > > +				  size_t reg_size, void *val, size_t val_size)
> > > +{
> > > +	struct spi_device *spi = to_spi_device(context);
> > > +	u8 rx_buf[4];
> > > +	ssize_t status;
> > > +
> > > +	/*
> > > +	 * Maximum number of consecutive bytes read for a temperature or
> > > +	 * pressure measurement is 3.
> > > +	 */
> > > +	if (val_size > 3)
> > > +		return -EINVAL;
> > > +	/*
> > > +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> > > +	 * the first byte needs to be dropped and the rest are the requested
> > > +	 * data.
> > > +	 */
> > > +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> > > +	if (status)
> > > +		return status;  
> >   
> > > +	memcpy(val, rx_buf + 1, val_size);  
> > 
> > Okay, endianess is defined in the regmap_bus below...
> >   
> > > +	return 0;
> > > +}  
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 


