Return-Path: <linux-kernel+bounces-150916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD438AA6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F67A1F22011
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A75664;
	Fri, 19 Apr 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNA5ASjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623610F9;
	Fri, 19 Apr 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491430; cv=none; b=NxGkspXTwgB4jmintODjm7ytYJPxIjRrfLUndQlGwgsTug4Ru+0QA4sPQJejhvH0Hwdeq678+LQVxIcpeTqX90+esHJgWYSW7GksASy/gDzsgzzo5w+XPxpnGfvPSW2GXw5HMbNwT2wiB+mDZgRah47q154R9M1gnnJF4Uu2Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491430; c=relaxed/simple;
	bh=8US40FU+8ErHCWlxLWXY/MDdXspdSrhsuMRmA/GFbTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BepgEj4+Y6tZvpwP3uy1ggI43DahQjEcSdKnFp7EJzvUkzKl4xU3ghGY0990ZcDECpgnYd80y4vqButEdi+J+D1ht9SgRJovQfwTMouNnU5zPyirSzbgosBJegU4clWJoOowO1vD/mciBRs8L+WyTiGFuK+gTGIZoweIsh9dspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNA5ASjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB338C3277B;
	Fri, 19 Apr 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491430;
	bh=8US40FU+8ErHCWlxLWXY/MDdXspdSrhsuMRmA/GFbTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNA5ASjLi6k8o2pwe0Zguld5TokTeERFqmSBSQ2dF9GjPpgZkXGdNR2SvcoUE3J9o
	 ORpI2dsoOMOmBzwuYVX0TZTXCPNPWcNYWusL0udbsdpSf1BaJlqoP0odD7CH8eTDmu
	 H6XU9OYWCjPxst/7h08r/k3kfLQnAcC2DXMkclpGjRJdNqS7p2Y5tuT/xd9n29ei3X
	 eaolEkZxEvFg1vJOmg40u2tx8GzKkV+nwVcJnk76qcq6o3WRGhAlIBbTnmGnaIEC9N
	 eNFnqUzs52QctYDAYTeqWD6/adTP7m+pI7lNJH1SePa3WmC2uGeCQQJn2t/ijEIdLE
	 LMkwrGWoJRU1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9623C395C5;
	Fri, 19 Apr 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 01/14] ethtool: Expand Ethernet Power Equipment
 with c33 (PoE) alongside PoDL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171349142988.11062.4384284372209376821.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 01:50:29 +0000
References: <20240417-feature_poe-v9-1-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-1-242293fd1900@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, mcgrof@kernel.org, russ.weight@linux.dev,
 gregkh@linuxfoundation.org, rafael@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, broonie@kernel.org, frowand.list@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, dentproject@linuxfoundation.org,
 kernel@pengutronix.de, maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 16:39:49 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> In the current PSE interface for Ethernet Power Equipment, support is
> limited to PoDL. This patch extends the interface to accommodate the
> objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> Equipment (PSE).
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/14] ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
    https://git.kernel.org/netdev/net-next/c/b58be8db6327
  - [net-next,v9,02/14] net: pse-pd: Introduce PSE types enumeration
    https://git.kernel.org/netdev/net-next/c/47e0dd53c5eb
  - [net-next,v9,03/14] net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
    https://git.kernel.org/netdev/net-next/c/4d18e3ddf427
  - [net-next,v9,04/14] netlink: specs: Modify pse attribute prefix
    https://git.kernel.org/netdev/net-next/c/57b30d2a5475
  - [net-next,v9,05/14] netlink: specs: Expand the pse netlink command with PoE interface
    https://git.kernel.org/netdev/net-next/c/f8586411e40e
  - [net-next,v9,06/14] MAINTAINERS: Add myself to pse networking maintainer
    https://git.kernel.org/netdev/net-next/c/edd79f084ad4
  - [net-next,v9,07/14] net: pse-pd: Add support for PSE PIs
    https://git.kernel.org/netdev/net-next/c/9be9567a7c59
  - [net-next,v9,08/14] dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
    https://git.kernel.org/netdev/net-next/c/b17181a88fb9
  - [net-next,v9,09/14] net: pse-pd: Add support for setup_pi_matrix callback
    https://git.kernel.org/netdev/net-next/c/29e28d1d7a16
  - [net-next,v9,10/14] net: pse-pd: Use regulator framework within PSE framework
    https://git.kernel.org/netdev/net-next/c/d83e13761d5b
  - [net-next,v9,11/14] dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
    https://git.kernel.org/netdev/net-next/c/9c1de033afad
  - [net-next,v9,12/14] net: pse-pd: Add PD692x0 PSE controller driver
    https://git.kernel.org/netdev/net-next/c/9a9938451890
  - [net-next,v9,13/14] dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
    https://git.kernel.org/netdev/net-next/c/f562202fedad
  - [net-next,v9,14/14] net: pse-pd: Add TI TPS23881 PSE controller driver
    https://git.kernel.org/netdev/net-next/c/20e6d190ffe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



