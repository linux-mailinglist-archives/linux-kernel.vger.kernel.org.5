Return-Path: <linux-kernel+bounces-85002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE386AEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7FEB22BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C863BBE0;
	Wed, 28 Feb 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy2gh12M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8973511;
	Wed, 28 Feb 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122832; cv=none; b=TmBT4tc44vDK7zWCEvQwId+1EencQYs+1Wo16ecQiUAvPjCHvqgKiAe6YFD/Hra1JhbV0laLCYDA3r0zCZSWaWN+6Zx0XLWZO1wp9VPjVTJJUV7RI5IV1/RYdB3qH/TKuBFpelgP8eF9mHA3Plwjz8ezHsFfqgwMQroK0bm/wE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122832; c=relaxed/simple;
	bh=HJCBNKeuAAuw0Rwm5UYnlvoamIJt/suPGdB5W963k3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GTSvR2CePaP+Q0Evb6oix2O8rG+yjIKwkrm5sc4p0jYnAZsqGk7vIozQjN1VmjaNT60ah8rKWrchr8f4QgqF4csBT6LCj7T9S8MpUz506SeLcCshS9vlKzYzj5PokOO0Iz9ZQwW13LbVO7RkvsEdIQV9RLNF4mTymVg4KK6mnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy2gh12M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5051CC433C7;
	Wed, 28 Feb 2024 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709122832;
	bh=HJCBNKeuAAuw0Rwm5UYnlvoamIJt/suPGdB5W963k3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jy2gh12MpRAsyipw1H7jdt6xXzYPug/pMt7K+4lTUoldoWR76uDFtoj5GE598zSHT
	 pyUGWeNaUkYeJ9stmhHh4mlRh2OKJb+4+dhTJlN4sMZXMN2ROE9jeyBEg7KO4+GGHL
	 EewqdjtK3MIbD/OXixIm9OaFDO6nV2Ts/Nzw0FWnqHE8YD52Dytf/U0LU8T+RqX9kZ
	 2P1DgoWHr92iXRbKfpBT3figX0zODB9/kqGCL8DZdOVwo9gFjOWnYRY489+O7MGW+F
	 qJegLR6ymtfgGdlpc9mwgU0dOf4U31J0ZPjs37wCwNDrGd07WZ/M6Qm4BJprj+xQQz
	 UmzEu/HfQX5ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3735CD88FAF;
	Wed, 28 Feb 2024 12:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] drivers: net: Convert EEE handling to use
 linkmode bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170912283221.5780.10584545658329943642.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 12:20:32 +0000
References: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
In-Reply-To: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, aelior@marvell.com, manishc@marvell.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 horms@kernel.org, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 19:29:06 -0600 you wrote:
> EEE has until recently been limited to lower speeds due to the use of
> the legacy u32 for link speeds. This restriction has been lifted, with
> the use of linkmode bitmaps, added in the following patches:
> 
> 1f069de63602 ethtool: add linkmode bitmap support to struct ethtool_keee
> 1d756ff13da6 ethtool: add suffix _u32 to legacy bitmap members of struct ethtool_keee
> 285cc15cc555 ethtool: adjust struct ethtool_keee to kernel needs
> 0b3100bc8fa7 ethtool: switch back from ethtool_keee to ethtool_eee for ioctl
> d80a52335374 ethtool: replace struct ethtool_eee with a new struct ethtool_keee on kernel side
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] net: usb: r8152: Use linkmode helpers for EEE
    https://git.kernel.org/netdev/net-next/c/17206c116d75
  - [net-next,v5,2/9] net: usb: ax88179_178a: Use linkmode helpers for EEE
    https://git.kernel.org/netdev/net-next/c/93e6da6cce4a
  - [net-next,v5,3/9] net: qlogic: qede: Use linkmode helpers for EEE
    https://git.kernel.org/netdev/net-next/c/9f8b8adca800
  - [net-next,v5,4/9] net: ethernet: ixgbe: Convert EEE to use linkmodes
    https://git.kernel.org/netdev/net-next/c/9356b6db9d05
  - [net-next,v5,5/9] net: intel: i40e/igc: Remove setting Autoneg in EEE capabilities
    https://git.kernel.org/netdev/net-next/c/01cf893bf0f4
  - [net-next,v5,6/9] net: intel: e1000e: Use linkmode helpers for EEE
    https://git.kernel.org/netdev/net-next/c/02de1741eaf1
  - [net-next,v5,7/9] net: intel: igb: Use linkmode helpers for EEE
    https://git.kernel.org/netdev/net-next/c/41b9797de4d6
  - [net-next,v5,8/9] net: intel: igc: Use linkmode helpers for EEE
    https://git.kernel.org/netdev/net-next/c/1e45b5f28a57
  - [net-next,v5,9/9] net: ethtool: eee: Remove legacy _u32 from keee
    https://git.kernel.org/netdev/net-next/c/292fac464b01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



