Return-Path: <linux-kernel+bounces-81231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19AE867254
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE022880E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057A1DA21;
	Mon, 26 Feb 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="QYGtsqgK"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210831CD2F;
	Mon, 26 Feb 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944991; cv=none; b=gLPIqTqvwSSjGh+VZW2og5BcuswEpFlHeVnYp0zJLvlp6rbwpGbHlG+TuyQFON0lIu7kSA/XR/OT2XXUCGIOhueoRU/XsvP2hsEKIa9oBcD3tW5W2BxPgVcnkREXKBwcIwbbRsteGBGiy2mx2hF/JLcXgERrsD6ricgqgTnutYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944991; c=relaxed/simple;
	bh=GcGiwtr0GSF06FQDzFeQxJaRyyIH33UB0tfMn73yOMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/ev/mv/FAwd9qiz163VCdv0L70GxMEvs1OP7IJApqQ6v08VNllzo9/dUSPbHdNaaG12JAc0oflUWGvTIUy1/E/oTGb6Fl5JqRIH4guvkrAzWmbJKZdQnSr46tUwRklrBPIoaz3TViynTVCVAgfeGk54kL9X4pHhnUHqfdBUDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=QYGtsqgK; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9AF0E60462;
	Mon, 26 Feb 2024 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708944989;
	bh=GcGiwtr0GSF06FQDzFeQxJaRyyIH33UB0tfMn73yOMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYGtsqgKiRkxo42HswAK3mXvf6M5+pNzVWZNOfBWCpkQUsJDdU2lyfICCUIh8ktUJ
	 1ugev5MxOfatg+xL2VLf6VxpwBqPm77PmYL0zlNKmBQCKGcOnF34DXDpujEZKaR4SV
	 w3WXYsR5JZaGpukQorgj4nlG19lXAd3TGVqSY12pJ4Xmir4PdxjeFaJj/hwN7ZlzuT
	 0oReSkZkD6W3ZSn/2BjeVnyctSK9I0rMQSdgJP0Wa/x8SeTsQcvS5ICzLQr8wyRVe+
	 tP3TwfrJGoWuMTh0BWaLjyUqPKdz9Vn3Autgt6Ch6ZdfUisCs3DzUMTGRjiDoBLXxV
	 wYg6Yf9C7ru/g==
Date: Mon, 26 Feb 2024 12:56:16 +0200
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix MMC/GPIO regression on Nokia N8x0
Message-ID: <20240226105616.GV52537@atomide.com>
References: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
 <CACRpkdaA9WfXJ9KGC+7RNO4iyH-6=qauYHv+uKsjLCYKmnh1OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaA9WfXJ9KGC+7RNO4iyH-6=qauYHv+uKsjLCYKmnh1OQ@mail.gmail.com>

* Linus Walleij <linus.walleij@linaro.org> [240223 20:47]:
> On Fri, Feb 23, 2024 at 7:15 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> 
> > Nokia N8x0 MMC has been pretty much broken starting from v6.3. These
> > patches restore the functionality. Tested on N810 with eMMC and external
> > miniSD card, and on N800 with SD card in the inner slot.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> 100% my fault, I'm sorry I couldn't dry-code any better :(
> 
> If it's any consolation, there are now no GPIOs left for me to break
> on the Nokia N8xx:s.

That's the two-step conversion by introducing bugs first :)

Maybe Ulf can ack the mmc patches and I'll apply these all into a
fixes branch.

Regards,

Tony

