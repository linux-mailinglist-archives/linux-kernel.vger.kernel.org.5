Return-Path: <linux-kernel+bounces-134600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE6789B36A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106F91C2108E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514603D55D;
	Sun,  7 Apr 2024 17:51:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853113C485
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512261; cv=none; b=U3j8NEGkHQcRf0npTCGfowK1Qo9iGV1vWgzi8nvjDqTkHXe9uaWQQln2fn4StxZJYMDIFRLRESfIu3rRxV8YIeKcEXJJVSdk1Z27goOqCXZJ3qcCZYItaqLaE3CVgH1AgIxEGan8uGCXSAjTDMd+XsgtOVnVB/NDcWcquIlnLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512261; c=relaxed/simple;
	bh=bhDnlacz4nSSm581AJuntvWCopjzPjgTLZRRM7V4Jkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxZzaIDewfb4pf6TH7WZrivmFxX0CwziRCHdQiv8VLRyXvgJ8rWKyQ8PEny6pkpVg6oOUenUMqD2m+9pkf58uy0TVxKLClBaepUQ4hkyMuLmce3E0vGm0OehL+TKxUFtdZ9F0I4AVv8onmwq/g5S/thqolvz790E1oZy5katE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rtWf6-0004bZ-Ke; Sun, 07 Apr 2024 19:50:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rtWf3-00Axl5-EU; Sun, 07 Apr 2024 19:50:33 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rtWf3-001GrB-18;
	Sun, 07 Apr 2024 19:50:33 +0200
Date: Sun, 7 Apr 2024 19:50:33 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: usb: lan78xx: Fixup EEE
Message-ID: <ZhLc6W2TS9_vWOeq@pengutronix.de>
References: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
 <20240406-lan78xx-eee-v1-1-2993b14b849c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406-lan78xx-eee-v1-1-2993b14b849c@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Apr 06, 2024 at 03:15:59PM -0500, Andrew Lunn wrote:
....
> ---
> -	if (edata->eee_enabled) {
> -		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
> -		buf |= MAC_CR_EEE_EN_;
> -		ret = lan78xx_write_reg(dev, MAC_CR, buf);
> -
> -		phy_ethtool_set_eee(net->phydev, edata);
> -
> -		buf = (u32)edata->tx_lpi_timer;
> -		ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, buf);
> -	} else {
> -		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
> -		buf &= ~MAC_CR_EEE_EN_;
> -		ret = lan78xx_write_reg(dev, MAC_CR, buf);
> -	}
> +	ret = phy_ethtool_set_eee(net->phydev, edata);
> +	if (ret < 0)
> +		goto out;
>  
> +	buf = (u32)edata->tx_lpi_timer;
> +	ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, buf);

According to the documentation:
"Host software should only change this field when Energy Efficient
Ethernet Enable (EEEEN) is cleared."

Even more: "A value of zero may adversely affect the ability of the TX
data path to support Gigabit operation. A reasonable value when the part
is operating at Gigabit speeds is 50 us."

Previous code seems to not care about it too. So, it would be not a
regression if something is broken.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

I'll get some time to work on this driver in some months, in this case
I'll take a closer look on EEE too.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

