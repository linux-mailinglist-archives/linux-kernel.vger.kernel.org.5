Return-Path: <linux-kernel+bounces-61230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCA0850F62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6351C21407
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23212101EC;
	Mon, 12 Feb 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HarlmHtL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC12FBF2;
	Mon, 12 Feb 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729028; cv=none; b=okfVlMnAYxEChBSZE4Ia6ocEAMWdyAXOdcfv3jcF0eZQkhLR6njp1tqyGMHCaTgBN3GErmXM3eTH1l7jFg0y0Dtt9+7kH1U7AHcotVj8rGlB7ORwgaZ8Wl7qN8tH3Z75D5lBxqJsM88im0/hymniJ+rAQvSR3iBT3dtjmxqGv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729028; c=relaxed/simple;
	bh=KfhIfI/6BlUL8MZo9WhQL2Av61+PXGBuJ5lGrQfs7Ms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OvUM0kLmN9O5RtPWB1I6Qkto4ydbaJUxE7nm/HWdy6UwmSgtrLJYnJ0UB2NeEBeQRLnIxSl88xR9m6lOOPH5Do6H63ACvXAFmD2aCPOtZOxPm71oAixaI0d7BhjQIOUHi1MFK4WM3hLV6rvRJCQTeotWTKKO45Tr70LwM48Nm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HarlmHtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E033AC43390;
	Mon, 12 Feb 2024 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707729027;
	bh=KfhIfI/6BlUL8MZo9WhQL2Av61+PXGBuJ5lGrQfs7Ms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HarlmHtLb8R+xRnv0SHksXb7K1QekZ4D/K7UJFItN7YFi0R9V1a8jF48xf15E1ukz
	 afMgWkgdZhRqTKk1MAXOpRU0bjE5xfVR8IooTt2+Cv0TOlzDt4I1zEkvneM2uNLtuk
	 bQ9CkfjU9dAObO8fzqlPlM95Y2HytYhS9Rl8XHoxzQsBL+ZUEzUdJ5SgKSJPc/D78t
	 VRsj8xiUyvNPW/lTSlQ1ZO+qWXMrCmGGVw2+PlAbjaunSBvrWSHtyiuJAcaNuiV6Lw
	 gLf+44s/oNCrQQwLT1bg+31I3zaV9aG3vJMuaYcs1MgT+MCk/hA0SElDiYZvM6waQb
	 tZ7yxX4vdh3cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B79A0D84BD0;
	Mon, 12 Feb 2024 09:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/8] add octeon_ep_vf driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170772902774.3287.11858895594477147419.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 09:10:27 +0000
References: <20240208101841.3108103-1-srasheed@marvell.com>
In-Reply-To: <20240208101841.3108103-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, hgani@marvell.com, vimleshk@marvell.com,
 sedara@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, wizhao@redhat.com,
 kheib@redhat.com, konguyen@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 8 Feb 2024 02:18:32 -0800 you wrote:
> This driver implements networking functionality of Marvell's Octeon
> PCI Endpoint NIC VF.
> 
> This driver support following devices:
>  * Network controller: Cavium, Inc. Device b203
>  * Network controller: Cavium, Inc. Device b403
>  * Network controller: Cavium, Inc. Device b103
>  * Network controller: Cavium, Inc. Device b903
>  * Network controller: Cavium, Inc. Device ba03
>  * Network controller: Cavium, Inc. Device bc03
>  * Network controller: Cavium, Inc. Device bd03
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/8] octeon_ep_vf: Add driver framework and device initialization
    https://git.kernel.org/netdev/net-next/c/cb7dd712189f
  - [net-next,v7,2/8] octeon_ep_vf: add hardware configuration APIs
    https://git.kernel.org/netdev/net-next/c/2c0c32c72be2
  - [net-next,v7,3/8] octeon_ep_vf: add VF-PF mailbox communication.
    https://git.kernel.org/netdev/net-next/c/c5cb944ded94
  - [net-next,v7,4/8] octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
    https://git.kernel.org/netdev/net-next/c/ca6ecb0d3c3a
  - [net-next,v7,5/8] octeon_ep_vf: add support for ndo ops
    https://git.kernel.org/netdev/net-next/c/c3fad23cdc06
  - [net-next,v7,6/8] octeon_ep_vf: add Tx/Rx processing and interrupt support
    https://git.kernel.org/netdev/net-next/c/1cd3b407977c
  - [net-next,v7,7/8] octeon_ep_vf: add ethtool support
    https://git.kernel.org/netdev/net-next/c/c92881599efb
  - [net-next,v7,8/8] octeon_ep_vf: update MAINTAINERS
    https://git.kernel.org/netdev/net-next/c/90cabae2a234

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



