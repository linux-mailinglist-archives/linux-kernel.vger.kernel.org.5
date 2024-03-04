Return-Path: <linux-kernel+bounces-90968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C18707C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15422828E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4A5F578;
	Mon,  4 Mar 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+h3DOW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E92A20;
	Mon,  4 Mar 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571397; cv=none; b=uw1fLOFs5DeZqyt4qLBpkPULvLxn9NqWFa6XQE3QE8fqDusvYr+4NVE2+ZeaT8mP0OuMsLRhQVnUGPpf2hzEjraLKWd9L00Z2sQXm2jEeAvWNG3uDHetJz82kX1c5Xx7VGaVxHgLuMqVrsCstGY7o8VbMK2rJOJ3QhYFu99Euv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571397; c=relaxed/simple;
	bh=xVMa7i8oPGdLj8iX76oU3OuSEEgYdE3cXj3g2JVHqYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK6ZTCqd8vTUuYMnuhdz1e4rK/2ljC9WqvUz2QCE3qq29CdnwnEG7vscsLav6qXDXuUvQSr0LCYroR9d7csFOyFTfNNazepoft210c5lsTJEEaLw/1AiNLD4diUqyZB1B6TU2KKVYVwVNfSVOEHzbx0+XNxNMNPqmFjdE5dkaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+h3DOW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43584C433F1;
	Mon,  4 Mar 2024 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709571397;
	bh=xVMa7i8oPGdLj8iX76oU3OuSEEgYdE3cXj3g2JVHqYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+h3DOW9ORlN/9HF9TaxmR/fYvUag0uSF8Hc9e/12dJNoz+71goZo2H8TackF4ndY
	 NfVYqGj/6OFDRiDCsry5FDGozEtGEBurPUvzd9yu6rOK0cbMv8vDpUXzA1HT0Z0/sA
	 qujKdTO7/OeWMSBL96U+8G+buwL9ScaI1Mid9Lcybrym8Th/7y5NAPq1JqK70JXxKQ
	 WvLrG00pt/H1qdoz+81PJJ5YiS22nvmqncYZfgaMLdXthBsu3rxy5UE35nXH9gpq8q
	 KeiaEoMNsjjEdzpngrMHC/ZI1eja3L9D7ZMCGBt+YMsACvSIS2ioHguEOpdgDRyZDa
	 YZKTSWcYAv91A==
Date: Mon, 4 Mar 2024 10:56:35 -0600
From: Rob Herring <robh@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	andi.shyti@kernel.org, conor+dt@kernel.org,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	willmcvicker@google.com, kernel-team@android.com
Subject: Re: [PATCH] spi: dt-bindings: samsung: make dma properties not
 required
Message-ID: <20240304165635.GA739022-robh@kernel.org>
References: <20240301115546.2266676-1-tudor.ambarus@linaro.org>
 <CAPLW+4=6oYcs0NPXo4ffLiCvtNQ-tY1s_isaxTX8dcPkV56xMw@mail.gmail.com>
 <cb426fb0-2f27-4c9b-89f5-7139354ea425@sirena.org.uk>
 <f06328e4-b283-4302-b9c1-6473aa3cfa25@linaro.org>
 <CAPLW+4kjXK=EWx__h0bX0rJMrL33E=t4YDzSOfObmvtG9aS+jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPLW+4kjXK=EWx__h0bX0rJMrL33E=t4YDzSOfObmvtG9aS+jg@mail.gmail.com>

On Sat, Mar 02, 2024 at 10:23:16AM -0600, Sam Protsenko wrote:
> On Sat, Mar 2, 2024 at 3:36 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >
> >
> >
> > On 01.03.2024 22:42, Mark Brown wrote:
> > > On Fri, Mar 01, 2024 at 01:28:35PM -0600, Sam Protsenko wrote:
> > >> On Fri, Mar 1, 2024 at 5:55 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> > >
> > >>> Since the addition of the driver in 2009, the driver selects between DMA
> > >>> and polling mode depending on the transfer length - DMA mode for
> > >>> transfers bigger than the FIFO depth, polling mode otherwise. All
> > >>> versions of the IP support polling mode, make the dma properties not
> > >>> required.
> > >
> > >> AFAIU, the device tree has nothing to do with drivers, it's about
> > >> hardware description. Does making DMA properties not required here
> >
> > correct
> >
> > >> mean that there are some HW out there which doesn't integrate DMA in
> >
> > no, to me it means that the IP can work without DMA, only in PIO mode,
> > regardless if DMA is integrated or not. Not required means that the
> > property is not mandatory, which is what I'm trying to achieve here.
> >
> > >> SPI blocks? Even if this change is ok (I'm not sure), the
> > >> argumentation doesn't look sound to me.
> >
> > switching to PIO mode in the driver for sizes smaller than FIFO depths
> > in the driver guarantees that all existing compatibles support PIO mode.
> >
> > Are you saying that if there is a physical line between an IP and DMA
> > controller, then the DMA properties must always be specified in dt? I
> > thought they can be marked as optional in this case, and that's what I
> > did with this patch.
> >
> 
> No, I would wait for maintainers to clarify on that bit. Change itself
> can be ok. But the commit message shouldn't mention the driver,
> because the driver uses (depends on) device tree, not vice versa. The
> device tree can be used in other projects as well (like U-Boot and
> OP-TEE), so it should be designed to be universal and not depend on
> kernel drivers. The commit message should be based on particular HW
> layout features and how the patch makes the bindings describe that HW
> better. It shouldn't rely on driver implementations.

If the controller is DMA capable then it should have dma properties. The 
compatible should be enough to tell if it is a case of 'can only work 
with DMA'. Otherwise, it is going to be up to a specific user. Even 
within Linux, you may have a serial port that doesn't use DMA for the 
console, but uses it for the tty or serdev.

Of course, if a new device is added without DMA properties and they 
are added later on, then they are going to be optional even though the 
DMA support is always there. I can't fully understand everyone's h/w. 

Rob

