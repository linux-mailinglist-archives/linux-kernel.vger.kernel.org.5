Return-Path: <linux-kernel+bounces-51117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48238486BA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E010E1C21865
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EB5DF11;
	Sat,  3 Feb 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YX0TMOJ7"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F780B;
	Sat,  3 Feb 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971210; cv=none; b=RNd1vlhAzHiLVDuLPrGkcw/SgIPQ2LslFaG5KCChYwLe/lkuR4XfRvKyEomrUWUCdPrecpJRunLPwtofX7e3hE+II0zQL5pE4GTVOL8sPv0SpK462LVaAInsZ504w3Fakeu6/cb86jtutvNt3SoMqXApY7ZceoWgId7Mm4H0Gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971210; c=relaxed/simple;
	bh=1CpdW3eKi5icNSSpnuCCuvb553v/YQ6Vj4yXI49Xk6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s37fuB2tOPZVYDLaPvSEED86lzhiqxwWHcWiQ4sA0EjF6egXwncH7zKkUVs2w4tnEs67Zl/IF/5gP2kvVIyTU0YR326W0bnjbPbpaXwTnO7FkUz/30NVsoDRwJk9F0Ylf7iMxueigIXY+JpcMsJIq0hKoNOnm9jRaQtlW6AO6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YX0TMOJ7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uDSh4X6M2mDVJsAXwHpTh/0TbjeOVYkJP3YQfqggCtY=; b=YX0TMOJ79dk8mk8oDVBVBcJuGi
	pk2P6fsGu0ygUkUoJ2qIWKFQUCGiwdQSzQGXtiXBUcf4f1BcxNXfKpOJW26tnOnpdpM7jfKa/XHXa
	UCSTg8OpVqjZ8rh35pxJaSbCbuky2WJ169uG3ZscDTLc4rr6pM5FG07UJnlSHhxO2gn/6faL8BUoI
	iXwby8Q++JRnCF2iQ224fSRtqoI5ZwnJ8/AcoJoFNrF3LhPJSK5/nYEL/GKNpqkTh66KvsnvZp+WP
	IUpC08rcG4NFzevgSL7DdqxsXDaaZhIatJ63ZhecLCAfb2SYEyt5I7OroZJa7z+nwif1MizF0QVbZ
	n3rcc4jA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWHBS-00079m-0u;
	Sat, 03 Feb 2024 14:39:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWHBO-0000uG-Jn; Sat, 03 Feb 2024 14:39:50 +0000
Date: Sat, 3 Feb 2024 14:39:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tim Pambor <tp@osasysteme.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83822: Fix RGMII TX delay configuration
Message-ID: <Zb5QNkcDvM6CtALf@shell.armlinux.org.uk>
References: <20240203131152.61958-1-tp@osasysteme.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203131152.61958-1-tp@osasysteme.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 03, 2024 at 02:11:51PM +0100, Tim Pambor wrote:
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index b7cb71817780..b061036f654a 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -398,16 +398,15 @@ static int dp83822_config_init(struct phy_device *phydev)
>  		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
>  						      false);
>  		if (tx_int_delay <= 0)
> -			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
> -		else
>  			rgmii_delay |= DP83822_TX_CLK_SHIFT;
> +		else
> +			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;

Further cleanup is possible here:

                rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
                                                      true);

                if (rx_int_delay <= 0)
                        rgmii_delay = 0;
                else
                        rgmii_delay = DP83822_RX_CLK_SHIFT;

At this point, rgmii_delay can only contain one of two possible values.
Zero, and bit 12 set.

The the code above modifies this value by either setting bit 11, or
clearing the already guaranteed to be clear bit 11. So, the only thing
that has any effect is setting bit 12, so we can omit the code path that
clears bit 11. Therefore, this can become:

		// TX_CLK_SHIFT disables the delay
                if (tx_int_delay <= 0)
                        rgmii_delay |= DP83822_TX_CLK_SHIFT;

I would also add a comment that RX_CLK_SHIFT enables the delay.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

