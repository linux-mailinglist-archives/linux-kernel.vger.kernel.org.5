Return-Path: <linux-kernel+bounces-144659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3338A48E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EA6284A74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B352C684;
	Mon, 15 Apr 2024 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VxUY9VAl"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABD1C68F;
	Mon, 15 Apr 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165738; cv=none; b=gipNeX4zOCaUC4tJmKvOjcZwV2I1b+5ntw8z3FIIIbyXI9s2UBhW0orPEkw+YLu3m243g7EQrvmnq9MatoOxZutJcJZJy5yRIfQbjhhFdh3Zfdj2adqd0bek3ASwQmxRhpRIUT0CsEKOMsiEbI+5WLbFoJoE4tyrvq6QI6ZZBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165738; c=relaxed/simple;
	bh=ZPHIx/CMsaqs/OmbpRIO6ySRG+gJEVkm9A0Ue0IhD8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaiyetv98pDFPz/u4QBwFaMOigZIhqu4Y1i9qfXG313lrhYNNbCagfgFLV2KcKp8kmJlhyizVYo5jNGmL3j4qaALwH9GdXIo+kCNaXHC/yyqAjHF/4DrQlcvmLsyk3GksSfsuMTdhlEvce3oqsaAzJT16AD+OTVl/w+r+zzAgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VxUY9VAl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tjaIGXIp0A+Is4lMG2IigT7poxG6UTkBbr9TFucPmT8=; b=VxUY9VAlIHaQe0EbNU9gIHm+2k
	qJGBTEnZelJMlEjtpn6S50Vk3sWRSV5uDBM3dMm/jrWegRUecesoRWQR/EhoUgaBDRrRe1QByPWWT
	3vetMWoWTapKiny15oqQSTcKzDHXU0Il/CRWbU7ex8XtVZHfvqzfC8QZV1hQCVs2WehJkijaJnKG1
	fK3AO9RL6Y73iZ2JlKkvysBwngxVu4BnEjcGcimiqQK5Apu3TjZppCWPywoyD3wY8p6SeQKabgG1z
	I1GkmUwRL9X3wsrxT/AoIPgkxJlzY454XzRpBr37sI+ezPLL09ck+hoTa3/zelGhJtBOaAHRLGQOx
	LEG63s5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44466)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwGfD-0005dv-09;
	Mon, 15 Apr 2024 08:22:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwGfC-000215-F7; Mon, 15 Apr 2024 08:22:02 +0100
Date: Mon, 15 Apr 2024 08:22:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Richard Clark <richard.xnu.clark@gmail.com>, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
Message-ID: <ZhzVmmndefd5zDFh@shell.armlinux.org.uk>
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
 <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 10:18:39AM +0300, Adrian Hunter wrote:
> On 15/04/24 10:06, Richard Clark wrote:
> > The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...), which means
> > the card is not present. Actually, the card detection pin is active low by default
> > according to the SDHCI psec, thus the card detection result is not correct, more
> 
> SDHCI spec covers the SDHCI lines.  GPIO is separate.

.. and the key bit of information that should be mentioned is in the
case of a GPIO, the GPIO library can be told if a GPIO is active-high
or active-low in either firmware or via the GPIO lookup data, and this
should be used instead of drivers inventing their own "quirking".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

