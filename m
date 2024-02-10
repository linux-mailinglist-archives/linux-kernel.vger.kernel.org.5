Return-Path: <linux-kernel+bounces-60445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11C850509
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067C81F2207F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4A5BAD8;
	Sat, 10 Feb 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqvRzvIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB875BAFA;
	Sat, 10 Feb 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581344; cv=none; b=ruE8Mofaf+KnMzyGWajeJW6yjRTVevxsFz5hGR9eYdFKsUGmDyNJnHm4t9y+hitwwqf+BfZXvHOUI+hRBzfJuPkMNlbxcYEYD9JzEeUciOjmY+PncgI8OsNqJekpFOBsOpouW/3wcxpMhhPYx/Co9LZEqlzEgibJXsHzqsnvGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581344; c=relaxed/simple;
	bh=MzlWsgTMilMmEj3lEfAH8phdvW+GhcAh2UuWorwFEcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD3RxFBKI3epZX2zFR4/J/nUO+CILYbio0DwtDZD8wY2rIp5CpmeeFLA1qyhXfXFiNOeboE9d58E8/1RE/waVz39izETRZcMuORsZqm4Df/gl/hdsnMMZSSbx964RJ0Vs6fMX6rkgfskoGPCHjjL5YWcx8HQRA/11Qi8nXXQzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqvRzvIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08313C433C7;
	Sat, 10 Feb 2024 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707581344;
	bh=MzlWsgTMilMmEj3lEfAH8phdvW+GhcAh2UuWorwFEcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqvRzvItFtIPVzzkrI9R49WWlcjQGs+qIdS0RQohOn9eqMA/cGFYsjFArx5Rh+j1t
	 7ogijSn+YOv3Dc3FLjzF8yJzn3ozPX+ppxNYt706SYw7IYlbHogw1WUovzOSBbkYLu
	 MwE6vOAUK3fDWIgV0xWjoFphcTBadXSflU2mmtTpImXpVqjV7xT1Vp7ha5WyFiKzmQ
	 Y32VyobI0/1grhrXO6yzocHGpkR/zzvKT9DdNRt2yuYKCrZw/es3YmcSfP7/3F0pEQ
	 S1w5CRCCwk6HxvK9dogmRrcnJ9o9KsYoloKOUn4tr8GEgegnlrxyrL9dFTtwViyq2l
	 WLOZajpDQWT2w==
Date: Sat, 10 Feb 2024 16:08:50 +0000
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
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240210160850.7495b410@jic23-huawei>
In-Reply-To: <7d7ea4e4-fcae-4966-b194-e1d328751b6b@topic.nl>
References: <ZcDo6QvoE_e5s_f1@smile.fi.intel.com>
	<7d7ea4e4-fcae-4966-b194-e1d328751b6b@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> >  
> >>> +	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
> >>> +	int rdata_xfer_busy;
> >>> +
> >>> +	/* Temporary storage for demuxing data after SPI transfer */
> >>> +	u32 bounce_buffer[ADS1298_MAX_CHANNELS];
> >>> +
> >>> +	/* For synchronous SPI exchanges (read/write registers) */
> >>> +	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
> >>> +
> >>> +	/* Buffer used for incoming SPI data */
> >>> +	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE];  
> > Cacheline aligned?
> > I see the cmd_buffer, but shouldn't this be also aligned?  
> 
> I understood from Jonathan that that wasn't needed... "My" SPI 
> controller is rather dumb and doesn't even have DMA.
> 
> Will take a closer look though.
It should be fine.  The aim here is to ensure that nothing access data in
the same cacheline from the CPU side whilst DMA is ongoing (and unwanted
write backs of stale data can occur). As long at the handling isn't
very complex, a single marking of the first buffer used for DMA (and
being sure there is nothing other than other DMA buffers after it
the same cacheline (potentially multiple lines) is enough.

So the __aligend(IIO_DMA_MINALIGN) on cmd_buffer should work for allt hese
buffers.

