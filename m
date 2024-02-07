Return-Path: <linux-kernel+bounces-56715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5AB84CDF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD671F263F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D87F7F6;
	Wed,  7 Feb 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G+342H5H"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E97E77F;
	Wed,  7 Feb 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319523; cv=none; b=Lb+oFLi5KzsP4tHVn5NUxD8RzyCrJcjKlB4vVT5/BD1BpFcQiIhigInLho8brItckQDuFq5pc/+MT08qUM68W9ZiNNV5YXHotvmzzGWKR9avXf8ixdJLbygkfFgScdWwDx+50otd1JL39kYpi5Fu/kHFdwQB4JRPlZQNhu7e1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319523; c=relaxed/simple;
	bh=gvOfXE9aaZLHOFWOgCvg5gMabwKGaaz75Fdk91nAsnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2pgMHw3SMdZuj8VzOR5I4abJpSDlm5WhlgVXL3wOjYGn7L+mVLvv2lB69dwIRiTTz66omZOfz5ni6rbXjyl8M+RxluersuRaVHSPt2u4yD9xjuEHNkmYeojp93tzo83qL6mrObuH+gd+5NP59gkJEBnBBwKe+NkYQJLv32mBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G+342H5H; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 907A0240003;
	Wed,  7 Feb 2024 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707319517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUAowT6c9Ft0erxtEzBcSe8W7O3ZQNJQ531F8SYqzSk=;
	b=G+342H5HasI3pcR6rpDIUFgLvdwOgaKZCweEotOSNYzqM8RHYXBtOsFc0nYmdOqmZCwWZo
	g1juMp/ddCZazQAt3h0qyS2a2XNCwlt58akchmfSLuvQP59QvS8mjVq1VurjsxLzSFrvsZ
	J9knnqKx7wr/aWr9ZR/NRl504A9yMwXxzE0TyajdNEVgF2Orm/oNe4Nz45ZujafpyWY7EX
	dUrZt8ppJPvf9zxeynpC0AKu+6oNfA2x7oGkkzWLCZ+LHxXviOL0IwnYB/QbEq8UOjzb+n
	a9p3+lwyadSaNgYl5dOdFgWNHgtblSp4lo1Vdge31aYnCxOssgMVT+6tY2wQ0w==
Date: Wed, 7 Feb 2024 16:25:16 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <ZcOg3JR9YW9JNxPp@localhost.localdomain>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com
References: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
 <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>
 <ZcIQVKibMmGegw+j@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcIQVKibMmGegw+j@finisterre.sirena.org.uk>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 06/02/24 - 10:56, Mark Brown a écrit :
> On Tue, Feb 06, 2024 at 11:00:50AM +0100, Louis Chauvet wrote:
> 
> > Introduce support for MULTI-mode in the OMAP2 MCSPI driver. Currently, the
> > driver always uses SINGLE mode to handle the chip select (CS). With this
> > enhancement, MULTI-mode is enabled for specific messages, allowing for a
> > shorter delay between CS enable and the message (some FPGA devices are
> > sensitive to this delay).
> 
> I have no idea based on this commit message what either of these modes
> is or how this shorter delay would be achieved, these terms are specific
> to the OMAP hardware AFAICT.  Please clarify this, it's hard to follow
> what the change does.  It looks like this is just a CS per word thing?

Indeed, you're right, the wording is probably very OMAP specific, I
didn't realize that earlier. I'll try to explain better. What about
this addition following the above paragraph, would it be clearer?

  [...] this delay).

  The OMAP2 MCSPI device can use two different mode to send messages:
  SINGLE and MULTI:
  In SINGLE mode, the controller only leverages one single FIFO, and the 
  host system has to manually select the CS it wants to enable.
  In MULTI mode, each CS is bound to a FIFO, the host system then writes 
  the data to the relevant FIFO, as the hardware will take care of the CS

  The drawback [...]
 
> Note that you may not have to tell the hardware the same word length as
> the transfer specifies, so long as the wire result is the same it
> doesn't matter.

If I understand correclty what you want is: given a message, containing 2
transfers of 4 bits, with cs_change disabled, use the multi mode and send 
only one 8 bits transfer instead of two 4 bits transfer?

This seems very complex to implement, and will only benefit in very 
niche cases.
If I have to add this, I have to:
- detect the very particular pattern "message of multiple transfer and 
those transfer can be packed in bigger transfer"
- reimplement the transfer_one_message method to merge multiple transfer 
into one;
- manage the rx buffer to "unmerge" the answer;
- take care of timings if requested;
- probably other issues I don't see

I agree this kind of optimisation can be nice, and may benefit for this
spi controller, but I don't have the time to work on it. If someone 
want to do it, it could be a nice improvement.

I just see that I miss my rebase, I will push a v2. This v2 will also 
change the commit name for patch 1/2.

Have a nice day,
Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

