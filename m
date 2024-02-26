Return-Path: <linux-kernel+bounces-81919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E943867C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804601C252BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5830B12C548;
	Mon, 26 Feb 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="skJ8NSQi"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB6433C4;
	Mon, 26 Feb 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965490; cv=none; b=lno9dkWKvlOYU71qoq1dbQv94yqVQQIp4IJ7XODFC+ncIck/CYtrDEs4hWi7AUfPJwCNmXOt+wpRI7pksZsQlX5ZG6XjzjnIbbhlrKe2Kbdqbj1EoxRS3h4mf0bqNZ70rPiXCkt3qi6dXQrS32mBGeGW6OLG7DtW8gVUL7q6Vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965490; c=relaxed/simple;
	bh=qtI1GWks/xC6VmEOnbJ7BknkMKj/aRcqiRxqQdtVliU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nq1bTQ2bu1C7eVBoH2bpwhDmi0ZMZyn1uhurB+Ir6WSWCQdKtg3K2nwM4ce4M9NlAoN9/yT6/u1/GZbD41XPT4hRSEFQXVRxtkzBokfsSOOn3K+evUByUln9fiAXEHXaSKz8WXHRUBT6Wjcz6Jllr9X2irRLHEHmLnc4iMNy8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=skJ8NSQi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pzNkiLLdvEQaY40Mc3HCstVtMva5WbfAzir5v5y3tmg=; b=skJ8NSQiLGJgFXB9vdmAyueDWU
	GTAqj8bwdyrLW05lMJsPBxXn7BfeQafwxRgFcT2EvKjxmjvWTJmY7moVEMIwqsgfGXlPVlq5yEhDD
	9P2RM78orAlQYtbeMyRCFqyluTgKsjYHEUYnliRfYsYUgm8kwkd287J2ntbU4FTo/5Ha++bRNIv0R
	z8pbVMWYCfF68ijugHnS1a3+xT4hMX9S8PCOwMcoyK98swlCAW8Qn16X4SXvBVqZhkKY0HBnQJyEr
	TWXCv1MH2Y/XHKOtohnVME7K/SKTEpP3ZjQ6jydK2SsUgV0stO7dhx4OaqeSJMu0W5HJreQGDJYI0
	ql4cHRGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54010)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1redzL-0004F6-15;
	Mon, 26 Feb 2024 16:38:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1redzI-0006Zi-4A; Mon, 26 Feb 2024 16:37:56 +0000
Date: Mon, 26 Feb 2024 16:37:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH net-next v2] net: phy: dp83826: disable WOL at init
Message-ID: <Zdy+Y8Mqs22yRrre@shell.armlinux.org.uk>
References: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 05:23:39PM +0100, Catalin Popescu wrote:
> Commit d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> introduced a regression in that WOL is not disabled by default for DP83826.
> WOL should normally be enabled through ethtool.
> 
> Fixes: d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

It seems rather interesting that WoL is disabled in the config_init()
method - because this will be called when the PHY is attached to its
network driver (reasonable I guess) but also at resume time - which
means one can't just set the WoL mode once and that status will be
preserved.

Maybe Andrew can clarify, but I thought once WoL was configured, that
configuration should remain until the system is rebooted.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

