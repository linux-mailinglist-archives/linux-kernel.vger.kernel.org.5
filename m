Return-Path: <linux-kernel+bounces-14317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73D821B44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C416B20EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6DEAF5;
	Tue,  2 Jan 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a788ZYE1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA3EAD9;
	Tue,  2 Jan 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eeKppkhwEPcnfGdqVxZAbh5Q3M2m8dKLX0VvnuSyMmk=; b=a788ZYE1O9RrCtktaWCekXqQJV
	9xl1vLCqmREErnQUWr7GXojR0YkEur/u+DnbVtPgKu5AYJgmmD7jkpFPZadn9uC0j6TQLXGXQVemz
	8yDISUSXlFJq1yyDG5puGa4FSS3s77ztKs69WkTSJ4Bn+b1P/Z33AHtaiBmZWQZPl/u6B2WYEqbFs
	bbcfgzIGPfdO77WJ221MOJiFSdP5/MsBo1JTXEtykHb4M23h5RSk+G6lzx+5bobCw1ISbJg1DlT9a
	PnUekrOKYwEAEf1gbGVw1YygwiVW+5cyQ5qc0kSEkRyhTx7LDwWJSAvdu4SYKgt8Kgv++Y4+zFCLI
	9PS2CNjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53214)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKdOP-0006VF-1T;
	Tue, 02 Jan 2024 11:57:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKdOP-0005GT-Rl; Tue, 02 Jan 2024 11:57:09 +0000
Date: Tue, 2 Jan 2024 11:57:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
	herve.codina@bootlin.com, f.fainelli@gmail.com,
	hkallweit1@gmail.com, vladimir.oltean@nxp.com,
	kory.maincent@bootlin.com, jesse.brandeburg@intel.com,
	corbet@lwn.net, kabel@kernel.org, piergiorgio.beruto@gmail.com,
	o.rempel@pengutronix.de, nicveronese@gmail.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
 <170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

... and I haven't reviewed this yet. I guess it's now pointless to
review.

On Mon, Jan 01, 2024 at 06:40:27PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Thu, 21 Dec 2023 19:00:33 +0100 you wrote:
> > Hello everyone,
> > 
> > Here's a V5 of the multi-PHY support series.
> > 
> > At a glance, besides some minor fixes and R'd-by from Andrew, one of the
> > thing this series does is remove the ASSERT_RTNL() from the
> > topo_add_phy/del_phy operations.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,v5,01/13] net: phy: Introduce ethernet link topology representation
>     https://git.kernel.org/netdev/net-next/c/02018c544ef1
>   - [net-next,v5,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
>     https://git.kernel.org/netdev/net-next/c/9c5625f559ad
>   - [net-next,v5,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
>     https://git.kernel.org/netdev/net-next/c/034fcc210349
>   - [net-next,v5,04/13] net: sfp: Add helper to return the SFP bus name
>     https://git.kernel.org/netdev/net-next/c/dedd702a3579
>   - [net-next,v5,05/13] net: ethtool: Allow passing a phy index for some commands
>     https://git.kernel.org/netdev/net-next/c/2ab0edb505fa
>   - [net-next,v5,06/13] netlink: specs: add phy-index as a header parameter
>     https://git.kernel.org/netdev/net-next/c/c29451aefcb4
>   - [net-next,v5,07/13] net: ethtool: Introduce a command to list PHYs on an interface
>     https://git.kernel.org/netdev/net-next/c/63d5eaf35ac3
>   - [net-next,v5,08/13] netlink: specs: add ethnl PHY_GET command set
>     https://git.kernel.org/netdev/net-next/c/95132a018f00
>   - [net-next,v5,09/13] net: ethtool: plca: Target the command to the requested PHY
>     https://git.kernel.org/netdev/net-next/c/7db69ec9cfb8
>   - [net-next,v5,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
>     https://git.kernel.org/netdev/net-next/c/345237dbc1bd
>   - [net-next,v5,11/13] net: ethtool: cable-test: Target the command to the requested PHY
>     https://git.kernel.org/netdev/net-next/c/fcc4b105caa4
>   - [net-next,v5,12/13] net: ethtool: strset: Allow querying phy stats by index
>     https://git.kernel.org/netdev/net-next/c/d078d480639a
>   - [net-next,v5,13/13] Documentation: networking: document phy_link_topology
>     https://git.kernel.org/netdev/net-next/c/32bb4515e344
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

