Return-Path: <linux-kernel+bounces-60454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AEA850526
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92DF2830C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830245C5F3;
	Sat, 10 Feb 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/rN2fyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24D20B29;
	Sat, 10 Feb 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582438; cv=none; b=h1HJ5Rz+uInJ0opYOe4oO3tJUURUnVvNDAj6ij3TK+64e5rWnuLvsjKxv3c+qXgJEG9D/t5OOCUQj84X2GuD+369+FXKABGiRAzLVDKPsfQP9JStFBCd/KKeHSud+cerf8bh06lv9cRr5DMqYAdpWP4kgM9bX+zzaBfCVQ9UZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582438; c=relaxed/simple;
	bh=xotlrdExwR7OpAxvjEFBl3sZucXG39CERAthiIFDFcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPf+3VRLFpm90q2JP+p2t8J7XDas/rBnCilsbZG6OPqJNTwSEEyaEiQtaE3Am6JWA9XoGUXZQq+hGJh8ojUtRLNTeMsfskNkZzq4mlkH6UP/gGhNBC35yKWIc0fAUcDep20l3TGmQqLd4YqkZLuBrYmzj17xG37Fw0GjAzJLi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/rN2fyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C72C433C7;
	Sat, 10 Feb 2024 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707582438;
	bh=xotlrdExwR7OpAxvjEFBl3sZucXG39CERAthiIFDFcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S/rN2fyLwU5QpDNprUT+IDybmAKToxm1A/CNVp/XCDATcu/o0xpaXspSFEHkgd1dY
	 hwuOJj6wnMbSD70niQYUCUPuPqRs90aa/vGC+FKBjsQrQunNWBhnZqKQyf7nmloStS
	 /w/szrodzfhA9o9a67xMYiLOMrVOybGa0d3JPFB64buZnSIdEB/63OPaggTRNmMIcT
	 uaKQgFrj5ANA0OrlPyRXtbHIJQFxGWZJocUE76U3t2gnEESbBcC/Ws5mOZ9WUDhpkF
	 lpIKXufTWkUr25Pa9V6qqSUrIDeLnSqdA3cYSd85Ofy2FYCv8l/QTAcnrUHMv/NBEO
	 YhZTfHnoa92tw==
Date: Sat, 10 Feb 2024 16:27:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Beguin <liambeguin@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Mark Brown <broonie@kernel.org>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Okan Sahin <okan.sahin@analog.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240210162704.5126478c@jic23-huawei>
In-Reply-To: <11613ba7-fc14-46bd-84ba-a0b5d966cbfc@topic.nl>
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
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 18:38:29 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 06-02-2024 17:32, Andy Shevchenko wrote:
> > On Tue, Feb 06, 2024 at 04:44:03PM +0100, Mike Looijmans wrote:  
> >> On 06-02-2024 16:09, Andy Shevchenko wrote:  
> >>> On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:  
> > ...
> >  
> >>> But it's up to you what to do with that.
> >>> Maybe Jonathan can advice something different.
> >>>  
> >> The spinlock also protects the call to spi_async().  
> > I don't get this. Locks usually protect the data and not the code.
> > Can you elaborate?
> >  
> Either the DRDY or SPI completion handler will call spi_async(), the 
> lock assures that it's only called by one.

Arguably it's protecting the destination buffer of the spi_async()
call.  We don't really care if we issue two reads (it's a waste
of time and we would store two sets of readings but meh), but we do
care about being sure that don't issue a second read into a buffer
that we are potentially simultaneously getting data back from.

There are comments where the release is to describe when it can 
be safely unlocked.

I'm not super keen on this whole structure but I don't really have a better
idea.  Who builds a device where you have no latched way of seeing
if there is new data? (some) Hardware folk love to assume they have a RTOS only
talking to their device and that no pulse signals will ever be missed.

We get to educate them when ever the opportunity arises :)

Jonathan

> 
> Usually the DRDY handler will call spi_async(). If the next DRDY arrives 
> before the spi_async transfer finishes, the SPI completion handler must 
> call spi_async() a.s.a.p. to also read the newly arrived sample. There's 
> no way to ask the chip whether there's data to read, so all the driver 
> can do is use the ISR to remember that DRDY did trigger.
> 
> The lock protects that the "busy" counter matches the actual pending 
> calls to spi_async, and also protects that only one handler will call 
> spi_async (and update the counter).
> 
> Maybe this picture helps:
> 
> DRDY ---+-----+-----+-----+-
> 
> SPI ------+------------+-+--
> 
> busy 00001100011111112211101
> 
> 


