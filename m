Return-Path: <linux-kernel+bounces-60095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11A84FFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B861C2084A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623538DE4;
	Fri,  9 Feb 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLNTGQUC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0F28DDE;
	Fri,  9 Feb 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517229; cv=none; b=E/abT1B7iD7CLoI7KLvUEyHMUrJg18u+m5XcaR1hJgymwD85s7cZD7IOJrldJE1ejSqeAVgBS3x07v8G+rF2jNDaW8ZCvQqqYnIPuZV4SvqAoqh6gw1uEf1S4XPu0q9Xs7k9U5MUnly6ddea0K7U+GF0l9qQqYSyzb7qHzTQxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517229; c=relaxed/simple;
	bh=zmD09Cf5Gxel7PFPTF/XTQTKu02LpKzT3/K6xp9h1qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nhRyfzlNB/kKz0/lKYl8M+TnlZMGDf/l0GWSi5x2wLKz/L4UhJTVkZ8c2OwiJVwe/9d5A8cuNbYoHl4JT0GekUF74LKB7+gyYHzfUEDcIIRwsje63GMovLmB319idgE42BirpZN2Ug1kaYPq4BdRBU8ZpDiICzjLFMZVjHD2VZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLNTGQUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF14DC43390;
	Fri,  9 Feb 2024 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517228;
	bh=zmD09Cf5Gxel7PFPTF/XTQTKu02LpKzT3/K6xp9h1qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WLNTGQUC8epHIrd8rB1EWFjpleFM5hcoEKMOGR9092xvOF2/MnWqrjZQx6a6qkXb4
	 nrRKa6VpSWPFyR4JvzFfeZECzi7Smp/1aqcZ34xGIaqdAm4UtDERqAsurCe2J83XlD
	 012GEDwrPvh34jf9slAIyrf/6Aj9wM1m+5X5JgFV7ufeLUeVCs089wXtZsraJzDMET
	 Qw3Mo2wRzDwXwsfoj6gw28sHXc0qW4A+Co8p3IrufoVOfeoTpToi6spj5YYi7rv2bF
	 9Kb2/LKZW9lfj0Y06AJYDZ9kxqNHHSY8x3UX76Or6OO4tHmWfXdFyiIzUis+UOVk+n
	 /u3Ha0oOsePxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5A53C395F1;
	Fri,  9 Feb 2024 22:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/9] net: Fix MODULE_DESCRIPTION() for net (p5)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751722867.20266.7249381801250857706.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 22:20:28 +0000
References: <20240208164244.3818498-1-leitao@debian.org>
In-Reply-To: <20240208164244.3818498-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com, jhs@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Feb 2024 08:42:35 -0800 you wrote:
> There are hundreds of network modules that misses MODULE_DESCRIPTION(),
> causing a warning when compiling with W=1. Example:
> 
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_cmp.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_nbyte.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_u32.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_meta.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_text.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_canid.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_tunnel.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ipip.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_tunnel.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ah4.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_algo.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ah6.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/esp6.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/xfrm6_tunnel.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/tunnel6.o
> 
> [...]

Here is the summary with links:
  - [net,v3,1/9] net: fill in MODULE_DESCRIPTION()s for xfrm
    https://git.kernel.org/netdev/net/c/2599bb5e0c74
  - [net,v3,2/9] net: fill in MODULE_DESCRIPTION()s for mpoa
    https://git.kernel.org/netdev/net/c/f73f55b0fcff
  - [net,v3,3/9] net: fill in MODULE_DESCRIPTION()s for af_key
    https://git.kernel.org/netdev/net/c/6e2cf0eb6926
  - [net,v3,4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
    https://git.kernel.org/netdev/net/c/2898f3075e6a
  - [net,v3,5/9] net: fill in MODULE_DESCRIPTION()s for ipv6 modules
    https://git.kernel.org/netdev/net/c/92ab08eb63bb
  - [net,v3,6/9] net: fill in MODULE_DESCRIPTION()s for ipv4 modules
    https://git.kernel.org/netdev/net/c/b058a5d25d92
  - [net,v3,7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
    https://git.kernel.org/netdev/net/c/a46c31bf2744
  - [net,v3,8/9] net: fill in MODULE_DESCRIPTION()s for ipvtap
    https://git.kernel.org/netdev/net/c/830bd88cc151
  - [net,v3,9/9] net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo
    https://git.kernel.org/netdev/net/c/6034e059f5d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



