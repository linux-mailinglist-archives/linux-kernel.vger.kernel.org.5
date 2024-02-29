Return-Path: <linux-kernel+bounces-87571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F586D603
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA3FB221D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140F16FF50;
	Thu, 29 Feb 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z5Pa4drf"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB516FF3B;
	Thu, 29 Feb 2024 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241598; cv=none; b=csp3hhZc1/qllOBI2thYYcCODNvni4jSiRiVdcxDMQti72NgyAU1xDl1DVvHZPZkGG6LLQD/Fn/5o/J8N+PCE2cs1IQh4tChuXa42s96QhE/SYs79ikA1aRVFyG3GH+5ceLAnv32RokI5+YeY6y6hV7JDJ9uAlTvRmBArK13snE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241598; c=relaxed/simple;
	bh=u3ijsbwwWVJZZGFrjEW1ukuiYsJN0bV+9R2jacwvjH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC4qCwNo78l8rZQxnEOkKgT5j4YDzj+hEdM6iRu7lVuNrQ8eI0PupilDUtztbbgcKS0QQVYQo4WowYclD1ImrEwIFkRXeRr+klaOht5vcWYYNdIdTEZXqP2EREsnC4fKvRV49h5RBjXvzSk4kTiQWei2cSXcuEoPJ5mxOqpUoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z5Pa4drf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kpe+BD9QqvU8mxo+1QWrY9BtJ/AXIEAAzW2g70pFWD0=; b=z5Pa4drfS/hdkyfz1vhMyqJeRh
	1ohaIJ0HH4hAhkci2wtEEIAJCYZfCEKUgi/467nAcM6EGzBUkBwLbL79iuiS90dpP9jJG7Ow8w13e
	NERyPTxRxyt02vi4+ymA2TKvuQIc7weuwEIfFmOR2vrdJzFT59KKNnQPjEpEl9rxxOwEiWZCAi81k
	iQR4CSCjNOmU3lmeljn4X1fjLtYQfLG6aB7xsYtnx0gZYuwAYAW2BqO64wWPWOxG2HUjmXyPBMXpO
	yPvwPC4wAHJ/AIW4w4spaaY6AyzmxFADdVbn9h3MeC59/NupDAccPDAsZq2MNW7ba17y6YYhkGb9n
	gWxX5RaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35576)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rfnoY-0000pd-2p;
	Thu, 29 Feb 2024 21:19:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rfnoU-000189-Nk; Thu, 29 Feb 2024 21:19:34 +0000
Date: Thu, 29 Feb 2024 21:19:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v7 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <ZeD05pY1RdKNtrDZ@shell.armlinux.org.uk>
References: <20240229140800.3420180-1-o.rempel@pengutronix.de>
 <20240229140800.3420180-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229140800.3420180-6-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 29, 2024 at 03:07:57PM +0100, Oleksij Rempel wrote:
> +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> +				      struct ethtool_keee *data)
> +{
> +	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
> +	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
> +		eee_to_eeecfg(data, &phydev->eee_cfg);
> +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> +		if (phydev->link) {
> +			phy_link_down(phydev);
> +			phy_link_up(phydev);

Unfortunately, this isn't sufficient in all cases. Phylink will be fine
with this though.

If we take a look at fec_enet_adjust_link(), then we can see it tests
phydev->link directly (which it has to, because there's nothing else
to determine whether the link is up or down. FEC will cope with its
fec_enet_adjust_link() being called with no changes however.

In order to properly resolve this, I think we need:

		if (phydev->link) {
			phydev->link = false;
			phy_link_down(phydev);
			phydev->link = true;
			phy_link_up(phydev);

to properly avoid the issue I've referred to.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

