Return-Path: <linux-kernel+bounces-65318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED828854B19
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B23BB216B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17754FA5;
	Wed, 14 Feb 2024 14:08:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A1524CA;
	Wed, 14 Feb 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919710; cv=none; b=aK7uUpaA3UGlbFd00wBhi9RQndr/D6CCJCQibQastEH8M7cbLJCHBXlZM2oT1BHxdJa80BcyEm+CIQ97wVEORCUiMAGrdi/NwXjIAILkexSNVLN1BM4yShwyH4a3TIKeShnoFDPAbdMheFfQwT8M9/fbH0cvxbE9U9m25EYicyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919710; c=relaxed/simple;
	bh=u6cTJPccubHfju2PHUjWSOqMXj5n3i6pmGWvm1M0i2E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpsryq1CYYctSiFmpfGp51r+MqtpnCRGkQEbiiaDTP5HzSL44JF6lIUZSFp5CAJ/xvAMJcWr5GtnVXwekZNQGukzrBum0qSYOQ0yxgJmNWNS3B5cPno4fYOl4ChhaGn+TcAZtAdBnZ/IX7CSHZ9IdSneUHLItj3fHiu0dj5q3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZg1l4sW8z67L8m;
	Wed, 14 Feb 2024 22:04:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ED012140D1A;
	Wed, 14 Feb 2024 22:08:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 14:08:25 +0000
Date: Wed, 14 Feb 2024 14:08:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Liam
 Beguin" <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "Maksim
 Kiselev" <bigunclemax@gmail.com>, Marcus Folkesson
	<marcus.folkesson@gmail.com>, Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>, "Niklas Schnelle" <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240214140824.00004460@Huawei.com>
In-Reply-To: <44d0a115-1a8b-496e-bfa9-89caccbee5bc@topic.nl>
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
	<20240206065818.2016910-2-mike.looijmans@topic.nl>
	<ZcIsuiuisQjTIxJv@smile.fi.intel.com>
	<4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
	<ZcI5PoWojKRrdpVl@smile.fi.intel.com>
	<67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
	<40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
	<ZcJLnOiFoaABami1@smile.fi.intel.com>
	<e04ca010-289c-4216-95ea-2f2418613378@topic.nl>
	<ZcJfOgDMmLBpEho2@smile.fi.intel.com>
	<11613ba7-fc14-46bd-84ba-a0b5d966cbfc@topic.nl>
	<20240210162704.5126478c@jic23-huawei>
	<44d0a115-1a8b-496e-bfa9-89caccbee5bc@topic.nl>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 07:48:40 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 10-02-2024 17:27, Jonathan Cameron wrote:
> > On Tue, 6 Feb 2024 18:38:29 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >   
> >> On 06-02-2024 17:32, Andy Shevchenko wrote:  
> >>> On Tue, Feb 06, 2024 at 04:44:03PM +0100, Mike Looijmans wrote:  
> >>>> On 06-02-2024 16:09, Andy Shevchenko wrote:  
> >>>>> On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:  
> >>> ...
> >>>     
> >>>>> But it's up to you what to do with that.
> >>>>> Maybe Jonathan can advice something different.
> >>>>>     
> >>>> The spinlock also protects the call to spi_async().  
> >>> I don't get this. Locks usually protect the data and not the code.
> >>> Can you elaborate?
> >>>     
> >> Either the DRDY or SPI completion handler will call spi_async(), the
> >> lock assures that it's only called by one.  
> > 
> > Arguably it's protecting the destination buffer of the spi_async()
> > call.  We don't really care if we issue two reads (it's a waste
> > of time and we would store two sets of readings but meh), but we do
> > care about being sure that don't issue a second read into a buffer
> > that we are potentially simultaneously getting data back from.  
> 
> Indeed, that.
> 
> > 
> > There are comments where the release is to describe when it can
> > be safely unlocked.
> > 
> > I'm not super keen on this whole structure but I don't really have a better
> > idea.  Who builds a device where you have no latched way of seeing
> > if there is new data? (some) Hardware folk love to assume they have a RTOS only
> > talking to their device and that no pulse signals will ever be missed.
> > 
> > We get to educate them when ever the opportunity arises :)  
> 
> Even on RTOS this chip was a pain - to get it to work reliably I had to set up 
> a DMA controller to run the SPI transactions, which took some smart 
> daisy-chaining (I recall having the DMA controller write to its own control 
> registers to avoid involving the CPU).

Always fun when that sort of mess is needed!

> 
> It's probably possible to trick audio hardware (I2S controller) into grabbing 
> the data (my chip doesn't have that) without involving the CPU.

Yeah, sometimes it feels like these ADCs have been designed with that sort
of bus in mind.

> 
> As the code is now, I can grab data and display it with the IIO oscilloscope 
> over network at 4kHz without losing samples on an A9 at 600Mhz.

Nice.
> 


