Return-Path: <linux-kernel+bounces-78368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A386128C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56589285F14
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A18061D;
	Fri, 23 Feb 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u2D2k5NK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695E7EF0E;
	Fri, 23 Feb 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694281; cv=none; b=h9sG7U+5cVTAy1LBQhZVHnbfWi39Xm79HcL+nqCFk5juyyCGH3vRPncpPKV7mOwK1zOeabnQtGXEziGnlCe5sx15X9ZG1UmfPJEHe5h/4A45yn8iwr3nNpANpIv9rRZP9un1ZTGpuZlS9FqDqCfFMIcLjRkr6OgO/U4gmrDKcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694281; c=relaxed/simple;
	bh=CJwV3AkbNYPmxUtNmWgmvsfyzdT6QZj/mLQfhzuCHbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwP5uOn9d/ytb/8GCmyHkY0zQZ72FXgG54Bnp0T9nKZsvTLOG+JC81ZknlHd4GPdaLLdGDBDCHn0T8lXjbomvDJFt3SMguRWkF5BWvoN/GPWu2vAad+pXVPR8ZaohHv9nEKCAb4gJIEcjzd9QP/fPnJRy/1j8FoM8TzlQDyTdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u2D2k5NK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3tX/zOPdfg9oNGtHW1EObwb4Rk2/rjHkYa5cJrgte9Y=; b=u2D2k5NKU+S/KbwkFfxUYlFwN/
	j3v1IlFcMP3UrgK0pvVk/iTGY6eSlEVv74H1iPHksgNX9i8NhkFK/DCbft9HnBoy4p5iP6/606lAa
	cMJxgO1KQbuN5LQB8d9roKaKLJTXftU9Prtm4fwGFl8ZXUkL8CSYKX/Jh5nKU2rBHTns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdVR9-008XUK-2k; Fri, 23 Feb 2024 14:17:59 +0100
Date: Fri, 23 Feb 2024 14:17:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>

On Fri, Feb 23, 2024 at 10:38:20AM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
> > +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> > +				      struct ethtool_keee *data)
> > +{
> > +	if (phydev->eee_cfg.tx_lpi_enabled !=
> > +	    data->tx_lpi_enabled) {
> > +		eee_to_eeecfg(data, &phydev->eee_cfg);
> > +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> > +		if (phydev->link)
> > +			phy_link_up(phydev);
> 
> I'm not convinced this is a good idea. Hasn't phylib previously had
> the guarantee that the link will go down between two link-up events?
> So calling phy_link_up() may result in either the MAC driver ignoring
> it, or modifying registers that are only supposed to be modified while
> the MAC side is down.

When auto-neg is used, we expect the link to go down and come back up
again.

Here we are dealing with the case that autoneg is not used. The MAC
needs informing somehow. If we want to preserve the down/up, we could
call phy_link_down() and then phy_link_up() back to back.

     Andrew

