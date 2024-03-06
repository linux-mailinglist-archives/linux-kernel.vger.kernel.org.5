Return-Path: <linux-kernel+bounces-93289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC3872D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33611C2318F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094D1803E;
	Wed,  6 Mar 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwWl3Lfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A76179B2;
	Wed,  6 Mar 2024 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695830; cv=none; b=Zhsh46DKrX+Xx9m9QA5HRfoFPMlQP1KWdT6KVck2O3CWsbqiQjZZnKLwk9Tk6DyQUUzBWJFcJig1aZ5rXr7++FkhqBEZ34GFREmEQVzSraJh7WxThZAeGRvV/C1B1k8FvJBpAhlenXfYU7/Nv5cZ3r5kjfJoK7gI15L0BjeuJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695830; c=relaxed/simple;
	bh=JarrlcOZ158Bpp5ZmGHdV9Omkh9SzTkEZsrBbSTVpms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=raTRhHkwvGN/LAmM4H4zyMY0bsrgeOJKLZhlSHhGzr8hYbhapL3hFYC+rw6CAeCJVbM0kvavvlmHHxjBH6T9B20y5ERPry2s4mtNut019S50u0Hv+Myejx5NoAvmX5xH7DOeRWnNvh3QbzLQVmGGjUoINjXdiR64gMv5wOz8BqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwWl3Lfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 427EBC43390;
	Wed,  6 Mar 2024 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709695830;
	bh=JarrlcOZ158Bpp5ZmGHdV9Omkh9SzTkEZsrBbSTVpms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kwWl3LfeA2mUEG+COLw3+f/soTsSjqNUSN3dfhD9ZVNP9EBKkGzh7TMIvn0wThr43
	 Isag6xDYxsvmwIpSaQEKoZ0WTguhPiw7yciA9ANtww7Aok91IodsWyad5xupPdrhHW
	 uM9jqDAL9a5ri4wofgBBg5tkVY876n1q/VDzyIU0Wuktran31e1YeuaJQ3+IGia1cR
	 m7MbJzdmF+rARUdfFr3vG+Xn5vancm+vvjlhM3nKDqPp0bgwYKJw49apSNIESLpORW
	 BorzcAAIsPEVimh+qrDjpVtj78y37Yhh5QZwpRk6flMAYwF//2bky+lkt+xWcxgk5r
	 qOf7uIo8+FnZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24CD5D9A4B9;
	Wed,  6 Mar 2024 03:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/7] net: ethernet: Rework EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170969583014.3052.10867383001845356911.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 03:30:30 +0000
References: <20240302195306.3207716-1-o.rempel@pengutronix.de>
In-Reply-To: <20240302195306.3207716-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: wei.fang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Mar 2024 20:52:59 +0100 you wrote:
> Hello all,
> 
> with Andrew's permission I'll continue mainlining this patches:
> 
> ==============================================================
> 
> Most MAC drivers get EEE wrong. The API to the PHY is not very
> obvious, which is probably why. Rework the API, pushing most of the
> EEE handling into phylib core, leaving the MAC drivers to just
> enable/disable support for EEE in there change_link call back.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/7] net: add helpers for EEE configuration
    https://git.kernel.org/netdev/net-next/c/6f2fc8584a46
  - [net-next,v9,2/7] net: phy: Add phydev->enable_tx_lpi to simplify adjust link callbacks
    https://git.kernel.org/netdev/net-next/c/e3b6876ab850
  - [net-next,v9,3/7] net: phy: Keep track of EEE configuration
    https://git.kernel.org/netdev/net-next/c/fe0d4fd9285e
  - [net-next,v9,4/7] net: phy: Immediately call adjust_link if only tx_lpi_enabled changes
    https://git.kernel.org/netdev/net-next/c/3e43b903da04
  - [net-next,v9,5/7] net: phy: Add phy_support_eee() indicating MAC support EEE
    https://git.kernel.org/netdev/net-next/c/49168d1980e2
  - [net-next,v9,6/7] net: fec: Move fec_enet_eee_mode_set() and helper earlier
    https://git.kernel.org/netdev/net-next/c/aff1b8c84b44
  - [net-next,v9,7/7] net: fec: Fixup EEE
    https://git.kernel.org/netdev/net-next/c/6a2495adc0c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



