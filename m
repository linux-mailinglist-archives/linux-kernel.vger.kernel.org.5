Return-Path: <linux-kernel+bounces-120612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900BE88DA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29202B23315
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D2381C7;
	Wed, 27 Mar 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k0d/mjjO"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587D524A;
	Wed, 27 Mar 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531628; cv=none; b=dZVGxCsOlH+PkExhm6G9iyuDUQuGFJgvyCX2edvPjPqG+pmtMpAUkH0tF5V2HPS7bqyH/5kuBWcZ/yw5lzXlXjh8ZQJIqIB9Ft9bggzvqFQMm3nR0KUB6HikXUYtZuAl0Db48ibRLfSk9C5gqz231PFCjF3j8MjuLxuK+IHjCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531628; c=relaxed/simple;
	bh=j37voNZzccelPBdTNf/Vqpsl2iNeg+OarLn6oh5pO5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/0TeVFZ2mDEwtzpjUgS8Kb9cNoHdHKT/sE5qSTg3t3dLKCefRd0LW4b6Tx9dgnJy3BDaJcJMelWgsSst7WEr4Gzjfp+OFcC8OAlv+pTV9FwNiBzFxJifv1NkrYQOk1KwPEyZRcDRi2AdcpwwSHge8KQ9JCjAiurz6yfC9eIOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k0d/mjjO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C621FF808;
	Wed, 27 Mar 2024 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711531624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBZ95QSP2wsKLmcn+oVbHDmh05vYkTHYdEqXpltlLSE=;
	b=k0d/mjjOMO9kNMNbmnu76h7tBCsoIjm1rY2r0VNndhg9+ghy5tBUMuxotdb4Co8D7kaWOj
	hFgxZ7FhT5Io5QGjSN0+FVnJAXAgu/cPo8WS4GqrLru9HjO/TiteGOTBkgqMfcLD6rMn0t
	S86MkyJbKsLERwNsxMHgKJ7xnFrA5u1/GXKq3Z5riAsHwmfyPuXxA93+vhVmArtYgl8uR8
	N39jDu8IUNOvRwTu7FPtmWXEWJXT/YRjWwvBJLbBDtQJxPaGXBTakBelJK0uj/TPx0iuez
	c1/LX6WbmV4jsHEwSu8IO0+G0E7KLpb0B0O+o/3XdRbh3qcHPtzv5ORv3EjeHg==
Date: Wed, 27 Mar 2024 10:27:02 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com, jeremie.dautheribes@bootlin.com
Subject: Re: [PATCH v2 2/3] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <ZgPmZh6l9uAeZWw5@localhost.localdomain>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com, jeremie.dautheribes@bootlin.com
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
 <20240223-spi-omap2-mcspi-multi-mode-v2-2-afe94476b9c3@bootlin.com>
 <8e5f3551-75c5-4211-84f6-18bbaf061dfb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e5f3551-75c5-4211-84f6-18bbaf061dfb@sirena.org.uk>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 25/03/24 - 14:05, Mark Brown a écrit :
> On Fri, Feb 23, 2024 at 10:32:12AM +0100, Louis Chauvet wrote:
> > Introduce support for MULTI-mode in the OMAP2 MCSPI driver. Currently, the
> > driver always uses SINGLE mode to handle the chip select (CS). With this
> > enhancement, MULTI-mode is enabled for specific messages, allowing for a
> > shorter delay between CS enable and the message (some FPGA devices are
> > sensitive to this delay).
> 
> This breaks an allmodconfig build:
> 
> /build/stage/linux/drivers/spi/spi-omap2-mcspi.c: In function ‘omap2_mcspi_prepare_message’:
> /build/stage/linux/drivers/spi/spi-omap2-mcspi.c:1280:17: error: "/*" within comment [-Werror=comment]
>  1280 |                 /*
>       |                  
> /build/stage/linux/drivers/spi/spi-omap2-mcspi.c:1265:14: error: unused variable ‘word_delay_is_zero’ [-Werror=unused-variable]
>  1265 |         bool word_delay_is_zero;
>       |              ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Hi Mark,

I missed this, sorry.

I've just sent a v3 [1] without those errors.

Thanks,
Louis Chauvet

[1]: https://lore.kernel.org/all/20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com/

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

