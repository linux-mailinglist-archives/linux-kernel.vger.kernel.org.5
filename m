Return-Path: <linux-kernel+bounces-134040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADF89AC73
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7EB217A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0445959;
	Sat,  6 Apr 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq/4KaNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439D3A8F9;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712424629; cv=none; b=L3gEyJnUx0C43ebec0OVg/FEmA4085JipyICgVH4mvkQwt+kusnqKkxwS4UM6hL1YSdZoaAVbcW3bBMwOKtprTkTF6xzKfAxBP4TdTMs1Vetd9DrDFGDbd6lsLT2vHqHfZPBymyucmP0uahEdQE910tNpih7lmvbAnVhSaAM2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712424629; c=relaxed/simple;
	bh=OH9KHxGszVemhHYPpLuSdvMAeb+Xyw3DNtED6GDXdSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rwt0e6x4ziQFuA+lA/YXqudfIw8W6s85B7yqeKgvWDba+HnhFEVmS4JKBcuxpIAQmtL1Po/eGvOyOvOI1gcXcWajmCk6sDKjCTwMp0W5wiKPb0Nq7S5doijS5h8zwh40K4qcJMJlmOeqDzW7WR9t7kteD+/qT8oJke0yJiAxTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq/4KaNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DE0BC43390;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712424629;
	bh=OH9KHxGszVemhHYPpLuSdvMAeb+Xyw3DNtED6GDXdSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eq/4KaNOFAQV7+ZLJu65m4yKdvLmeeFLj89g6orUKh6dkE1571a7cDJypoQTwm8di
	 9QaWKPGTNk89IheUZknQ5OfzW8oxksVtREgG/ZJGCFqrqeYZlKwiYlXzVG7/B2Mm3w
	 ztPjYG95l4iVmcP9NntxLsKHt0YneOo3VkFtbqvlOuRTeiYzWbFdjo+TrQkv3XhRjt
	 p9CYOZ9jVInYt5BFpoAbql2eRuJmd2nSI1VpuR4KNqlI7hXAXlumV8WhoUoU39FjYJ
	 RhytPLEJVwExQ6Bnre/lz5Ibsxx5YOecm7MuzqUz+t7UC2B+6dQsHmEblBTdJRHFDX
	 Hl9A/WLWuJkmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A770D8A101;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 00/13] Introduce PHY listing and link_topology
 tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171242462917.4000.9759453824684907063.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 17:30:29 +0000
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, corbet@lwn.net, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de, nicveronese@gmail.com,
 horms@kernel.org, mwojtas@chromium.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 11:29:50 +0200 you wrote:
> Hello everyone,
> 
> This is V11 for the link topology addition, allowing to track all PHYs
> that are linked to netdevices.
> 
> This V11 addresses the various netlink-related issues that were raised
> by Jakub, and fixes some typos in the documentation.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/13] net: phy: Introduce ethernet link topology representation
    https://git.kernel.org/netdev/net-next/c/6916e461e793
  - [net-next,v11,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
    https://git.kernel.org/netdev/net-next/c/0ec5ed6c130e
  - [net-next,v11,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
    https://git.kernel.org/netdev/net-next/c/e75e4e074c44
  - [net-next,v11,04/13] net: sfp: Add helper to return the SFP bus name
    https://git.kernel.org/netdev/net-next/c/fdd353965b52
  - [net-next,v11,05/13] net: ethtool: Allow passing a phy index for some commands
    https://git.kernel.org/netdev/net-next/c/841942bc6212
  - [net-next,v11,06/13] netlink: specs: add phy-index as a header parameter
    (no matching commit)
  - [net-next,v11,07/13] net: ethtool: Introduce a command to list PHYs on an interface
    (no matching commit)
  - [net-next,v11,08/13] netlink: specs: add ethnl PHY_GET command set
    (no matching commit)
  - [net-next,v11,09/13] net: ethtool: plca: Target the command to the requested PHY
    (no matching commit)
  - [net-next,v11,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
    (no matching commit)
  - [net-next,v11,11/13] net: ethtool: cable-test: Target the command to the requested PHY
    (no matching commit)
  - [net-next,v11,12/13] net: ethtool: strset: Allow querying phy stats by index
    (no matching commit)
  - [net-next,v11,13/13] Documentation: networking: document phy_link_topology
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



