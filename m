Return-Path: <linux-kernel+bounces-51667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5556848E15
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DC82842D0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53E224FA;
	Sun,  4 Feb 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS2hPjmB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E0224DF;
	Sun,  4 Feb 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053585; cv=none; b=GUiG6xyRUQijxrUOuECVsbx/oR7JnlDkkbPasPkLANtaOoJeTLX++ntkxlKzkp2zT5Lq3mY4wYQywAk1Axo6987SWeatOuPmNs30W2S2GZextRZ1EgT3OWm9t6UpM++43nQ8kCfDNc9pbjFCG7XTd9C8QPSxdomniM98ktQCwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053585; c=relaxed/simple;
	bh=GAyOVmT3o8s5Xn39yHx3dVRzIPatpJVg80X3kvg4h6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwxkJ7wnLprRHdt4CeMgFyjUH0EMwucZGUx0TY1bfW4FchPaITO/Bx0dF8GyULsUF3P6eJ1vLUGdyzMB+lVLiTijwDF+pJk1n7h0D+zNZK0VdOEWrnQ3nI1283yCrYacFAZ9SZe4ftzr9Ow1OggeYktuoVkxxEB3aavzJ+7YGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS2hPjmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35699C433F1;
	Sun,  4 Feb 2024 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707053584;
	bh=GAyOVmT3o8s5Xn39yHx3dVRzIPatpJVg80X3kvg4h6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QS2hPjmBScI+6OqWyU3IBHRaEgLSQDXl4jvA/fJSOd7Sp02h19bmaD3lDsDwPNqoJ
	 sOXh1PA29f9XNkmbyxO1PXPrWmVy8joBCdtM46N94hyhVcwsG9gyfS7yR2SD+5vvAz
	 zsW/6hobr3iccFWNUAZL/v/96oCpAGkHOg3ZwSQxWQJJVAipHGqG2QYRkoefqxNCFA
	 Mi5NI/pXM6PuJf8yN3xPo6iqOpouA09j7sUWag+uo7Tlu9izALSQgoMOY6axpuLvEE
	 diXCcqWOK+67TdB5ITDS1J+oMJe1UDBB4QmDuJ91NHjG+iYkqmr3Rl23Y++S0T6Jew
	 GJAW4NDhEXRiA==
Date: Sun, 4 Feb 2024 13:32:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Haibo
 Chen <haibo.chen@nxp.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Liam Beguin
 <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, Mark Brown
 <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, Okan Sahin
 <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240204133249.48cb0a10@jic23-huawei>
In-Reply-To: <48f3d8cf-3a56-481e-9eab-4fc1573cfe02@topic.nl>
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
	<20231213094722.31547-2-mike.looijmans@topic.nl>
	<20231214110618.00007783@Huawei.com>
	<48f3d8cf-3a56-481e-9eab-4fc1573cfe02@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 17:24:18 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 14-12-2023 12:06, Jonathan Cameron wrote:
> > On Wed, 13 Dec 2023 10:47:22 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >  
> >> Skeleton driver for the TI ADS1298 medical ADC. This device is
> >> typically used for ECG and similar measurements. Supports data
> >> acquisition at configurable scale and sampling frequency.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >>  
> > Hi Mike,
> >
> > Various small things inline - some of which probably overlap with Andy's
> > comments.  
> 
> 
> Working on it - Assume "yes to all" as my response on all suggestions, 
> except for the IRQ handling...
> 
> >
> > The larger one is I don't follow why this does manual protection against
> > concurrent handling of the result of an IRQ.  Much easier to just use
> > an IRQ threaded handler and IRQF_ONESHOT to mask the irq entirely until
> > after the initial handling is done.  If that doesn't work for some reason
> > then more comments needed to explain why!  
> 
> Yeah, definitely needs comments, and a bit of code too...
> 
> This chip doesn't have a buffer, but it does "latch" the sample data 
> when it receives a RDATA command (hence I use that in favor of RDATAC, 
> which does not latch and might return corrupted data).
> 
> To keep the latency as low as possible, I want to immediately start the 
> SPI transfer when the DRDY interrupt arrives. My experiments have shown 
> a big difference there, when using a ONESHOT trigger, it failed to meet 
> the deadline at even the lowest frequencies.

That's interesting to hear.  I wonder why - the overhead should be small.

Potentially it kicks the interrupt thread which then might kick an spi
controller thread rather than kicking the spi controller directly.
I think that depends on the SPI controller driver implementation choices
assuming things aren't contended - the defaults in the spi core
will take a fast path in current context if no contention - so it'll
happen in the interrupt thread.  So in general case there should be
very little difference in the timing needed to kick off the actual
SPI transfer starting via the two paths. The bit you mention below
on overlapping is a gain.  One trick we do to try and grab that back
if it's occasional is to poll the device in the trigger reenable
callback (only works if there is a register to say there is new data).

Maybe something odd going on in the interrupt controller driver...
It might not be useable for the higher frequencies, but should work
at reasonably low ones.



> 
> The next SPI transfer can start immediately after the data has been 
> copied into the intermediate buffer for IIO, the handler need not wait 
> for IIO to process the data.

I'd be surprised if the processing time was significant (compared to the SPI
transfer times) - so this 'feels' like a bit of over the top micro
optimization.

> 
> When the DRDY interrupt arrives, and there's an SPI transfer still in 
> progress, it's not too late yet, the "latch" may save us still. Once the 
> SPI transfer completes and the data is in the intermediate buffer, we 
> should immediately start a new SPI transaction to latch and fetch the 
> next set. (This code is still missing in the current version)
> 
> Only when DRDY arrives a second time during an SPI transaction we missed 
> the deadline and sample data was lost.

If you are running anywhere near speeds where this happens, things aren't
going to be reliable anyway. Whether that is a problem depends on your usecase.

So in conclusion, I'm surprised you are seeing such a difference in the
rates you can capture at.  Might be worth trying to grab some debug info
to understand this a bit more given you are proposing an unusual structure
with maintenance costs etc.

> 
> No further comments below from me, just kept the history for reference
Don't bother :)  Better to crop as much as possible. We have archives for
history.

Jonathan
> 

