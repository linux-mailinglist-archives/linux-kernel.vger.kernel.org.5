Return-Path: <linux-kernel+bounces-13931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0D821500
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA431F217DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E584D52B;
	Mon,  1 Jan 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPJf6LEU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA57D512;
	Mon,  1 Jan 2024 18:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE1BAC433C9;
	Mon,  1 Jan 2024 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704134428;
	bh=n1grVBOugGLgW0Nwjbv1plL2Z6PNPY9un0tRAe6UpoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pPJf6LEUB3HCoVu3s9MwGE08XRtn7iqgX96OEHhqoJe9+0LIXec6240SwjKchyOfq
	 mkC5ykf0fpy/Uuc51IiU9ZNPnrqVDErnblxTJDCBxFC6evizcr9taIlkbDui/eZYjd
	 YYN4exSJq0dalP1Ay1Jq4F7qDQ4xdlHG2fT7nnim94Zy6S/WPOCvEYIaz/rgyz4ueS
	 AyBVGIZKDg4JQ9qWUIzCdCPf65u14wYM+zxFTxePTHf0+d7IaWiI8lf7OMS5Au/J4c
	 abGapLCoBaxrr4qCdxDozQgPcCUU6PlwKgBofxc0E+KDJp6Djsw2Vo12oBdo+Szwbw
	 fl7EcAr5jef5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2271DCB6CE;
	Mon,  1 Jan 2024 18:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and link_topology
 tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 18:40:27 +0000
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, corbet@lwn.net, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de, nicveronese@gmail.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 19:00:33 +0100 you wrote:
> Hello everyone,
> 
> Here's a V5 of the multi-PHY support series.
> 
> At a glance, besides some minor fixes and R'd-by from Andrew, one of the
> thing this series does is remove the ASSERT_RTNL() from the
> topo_add_phy/del_phy operations.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/13] net: phy: Introduce ethernet link topology representation
    https://git.kernel.org/netdev/net-next/c/02018c544ef1
  - [net-next,v5,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
    https://git.kernel.org/netdev/net-next/c/9c5625f559ad
  - [net-next,v5,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
    https://git.kernel.org/netdev/net-next/c/034fcc210349
  - [net-next,v5,04/13] net: sfp: Add helper to return the SFP bus name
    https://git.kernel.org/netdev/net-next/c/dedd702a3579
  - [net-next,v5,05/13] net: ethtool: Allow passing a phy index for some commands
    https://git.kernel.org/netdev/net-next/c/2ab0edb505fa
  - [net-next,v5,06/13] netlink: specs: add phy-index as a header parameter
    https://git.kernel.org/netdev/net-next/c/c29451aefcb4
  - [net-next,v5,07/13] net: ethtool: Introduce a command to list PHYs on an interface
    https://git.kernel.org/netdev/net-next/c/63d5eaf35ac3
  - [net-next,v5,08/13] netlink: specs: add ethnl PHY_GET command set
    https://git.kernel.org/netdev/net-next/c/95132a018f00
  - [net-next,v5,09/13] net: ethtool: plca: Target the command to the requested PHY
    https://git.kernel.org/netdev/net-next/c/7db69ec9cfb8
  - [net-next,v5,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
    https://git.kernel.org/netdev/net-next/c/345237dbc1bd
  - [net-next,v5,11/13] net: ethtool: cable-test: Target the command to the requested PHY
    https://git.kernel.org/netdev/net-next/c/fcc4b105caa4
  - [net-next,v5,12/13] net: ethtool: strset: Allow querying phy stats by index
    https://git.kernel.org/netdev/net-next/c/d078d480639a
  - [net-next,v5,13/13] Documentation: networking: document phy_link_topology
    https://git.kernel.org/netdev/net-next/c/32bb4515e344

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



