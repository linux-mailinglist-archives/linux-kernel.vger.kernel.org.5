Return-Path: <linux-kernel+bounces-60129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CB850038
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B1CB24E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A32E3E4;
	Fri,  9 Feb 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="k5ZHtjuG"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB434CD5;
	Fri,  9 Feb 2024 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518582; cv=none; b=sKjyuyMG71AnilOE99N7ApEuUK8xSSuObTxYmPXhdvQ5v64dVQ20UsvWWq/lOQOPj9xchQ2bqzIwZqU3MdT05i31Y+6XMWj/fnDP5b4e7xbZRyZHfOzkOxv11nbzuDanu7V+tkIyn9ftLcu5BKqM37wH5ZzCaARjw3+G9LnMY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518582; c=relaxed/simple;
	bh=0VrvZ7V1JHCIdSHJkSJPYRxvDvx/5ayihD+OUxA6lZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urF/Ot09p7hrkjOw3WFl1InUjdTubQSHPCRUHYcmyUmQp4HH0qDcSQiEFYos8u7K/HQltHJSirPXuED/sxbCq2GEHTGO3Ljc++ARQwOUGKhIPqBfnuv3Xj2ne6WRgz48L0uOGZz1NKKd895SCI300yWQvHtv4CGfgHpyZC1Vxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=k5ZHtjuG; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4TWpZp6CMszBR;
	Fri,  9 Feb 2024 23:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1707518115; bh=0VrvZ7V1JHCIdSHJkSJPYRxvDvx/5ayihD+OUxA6lZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5ZHtjuGdfiiMlGsBNgkQ+/cwOlBC1f/ZWvTDtSrGXq/un7xNh+cAWHGNkVYuStKd
	 TKiU/Mt+RotJYBpK4wllp2Kb2MovQ0drodGCL5N7mSwQY29HR1fMbwg9gR6xX5bIIS
	 Y9ozhVXrANTyWa5QLXXa+aN9RJRfLJIb0G+9sbPV8gP55LJ3iE3sMB9/bDYbOlTSnN
	 PC3tTZ9bqRVFlz3wReNzKsJjnkPxEuo8XEcaj66iYYVYYAPcHzcjUSIA9e1pRhC1Sm
	 CzfnFiJbDSXRnD8V3f7iohL6VFyag5ZHp/HoHfHRdaOVX8ETvduc+Voj3pbdeGQ46H
	 P95Z5Q0jCvYvA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date: Fri, 9 Feb 2024 23:35:13 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
Message-ID: <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com>

On Thu, Jan 25, 2024 at 10:47:26AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 25, 2024, at 09:50, Linus Walleij wrote:
> > The MMC core sets BLK_BOUNCE_HIGH for devices where dma_mask
> > is unassigned.
> >
> > For the majority of MMC hosts this path is never taken: the
> > OF core will unconditionally assign a 32-bit mask to any
> > OF device, and most MMC hosts are probed from device tree,
> > see drivers/of/platform.c:
> >
> > of_platform_device_create_pdata()
> >         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> >         if (!dev->dev.dma_mask)
> >                 dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> >
> > of_amba_device_create()
> >         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> >         dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> >
> > MMC devices that are probed from ACPI or PCI will likewise
> > have a proper dma_mask assigned.
> >
> > The only remaining devices that could have a blank dma_mask
> > are platform devices instantiated from board files.
> >
> > These are mostly used on systems without CONFIG_HIGHMEM
> > enabled which means the block layer will not bounce, and in
> > the few cases where it is enabled it is not used anyway:
> > for example some OMAP2 systems such as Nokia n800/n810 will
> > create a platform_device and not assign a dma_mask, however
> > they do not have any highmem, so no bouncing will happen
> > anyway: the block core checks if max_low_pfn >= max_pfn
> > and this will always be false.
> >
> > Should it turn out there is a platform_device with blank
> > DMA mask actually using CONFIG_HIGHMEM somewhere out there
> > we should set dma_mask for it, not do this trickery.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I think it's worth mentioning the cb710 example here, which
> uses a platform device as a child of a PCI device and
> does not assign a DMA mask nor use DMA.
> 
> This one will see a change in behavior, meaning that the
> blockdev buffers are no longer bounced. As far as I can
> tell, this is fine because the driver appears to correctly
> use the sg_iter infrastructure for mapping data pages,
> but it would be good to have this confirmed by
> Micha³ Miros³aw because this code path has probably never
> been tested without BLK_BOUNCE_HIGH.

Hi, this driver doesn't do DMA at all, so having DMA mask set or not
it should be good as long as the CPU can read/write the buffers.

Best Regards
Micha³ Miros³aw

