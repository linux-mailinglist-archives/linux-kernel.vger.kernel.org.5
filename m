Return-Path: <linux-kernel+bounces-37796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5183B588
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3861285043
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5713667A;
	Wed, 24 Jan 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJtdk+MB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363D136656;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138428; cv=none; b=WkXev9tR7QYJb+PpUVpqPVgAgQOuAyr0Jk8qqhDcYkoVG+GGslyCppkFsKiVY0gLzfvMVcz2XsOec9gY4wCmf/CojU7sCF4e185KUWrW2RcrsG02YKN24XfSwa6B/eGIf/Ugas9ChzpF7Q8YmndYWGaR5bjUdcny7uQ4WSCkGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138428; c=relaxed/simple;
	bh=7GTQG8sFoJ4iYeZM7dgnESy6/9cSufsoQj9M/N6s+Wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LgXflqpJ4/gCbSjEOVpui9XeX4AibchfSMDTEoc1H+F9xLb86d6kTxhjc7pJfnu4PSBXwCqyjVwCtymJKb0gH14InrH0cJ0ZvRIq0B5DXKfmfxNtK7VIJmyTTwIMRrQCh/yqHQ8dzWbE5B5M6XRkad7z3PJi3OWBzOlsE7iEcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJtdk+MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F4C2C433F1;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706138427;
	bh=7GTQG8sFoJ4iYeZM7dgnESy6/9cSufsoQj9M/N6s+Wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rJtdk+MBGaaN+9nrJ1RHyMSKdGvhusnXbLDYy5cRETFREbKQ8GOPaBI+0/gtcPkqK
	 VIFoFo79l6uMpgGK2OmdXczTLqmuM4N+AlROxft5/Mo756IX7/XcViiINy+G/1mXhj
	 bUiMpiRF4Gs+OZ03+tn+WOuwq8+RdRV+DRdM/8hzEQMt5Voy2Q0qvwqKZ2Rt5brPzh
	 Gt9EYpUBR8weTsckxKlySa5H5uSf16/yPE5X33zfe8bFiN4ohCpolMzJjKI/8uaLrD
	 kD37m3XWzlKCBTeJfggWyTCbmxQJkf0o4o5FTh7OzyHxy3Ht4EWjeSq4vBjCDLRd1O
	 dvwRtYV92IXZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 771F2D8C966;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/10] Fix MODULE_DESCRIPTION() for net (p2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170613842748.28029.10890542758483405613.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 23:20:27 +0000
References: <20240123190332.677489-1-leitao@debian.org>
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, weiwan@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jan 2024 11:03:21 -0800 you wrote:
> There are hundreds of network modules that misses MODULE_DESCRIPTION(),
> causing a warnning when compiling with W=1. Example:
> 
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o
> 
> [...]

Here is the summary with links:
  - [net,v2,01/10] net: fill in MODULE_DESCRIPTION()s for 8390
    https://git.kernel.org/netdev/net/c/f5e414167be7
  - [net,v2,02/10] net: fill in MODULE_DESCRIPTION()s for Broadcom bgmac
    https://git.kernel.org/netdev/net/c/39535d7ff6c1
  - [net,v2,03/10] net: fill in MODULE_DESCRIPTION()s for liquidio
    https://git.kernel.org/netdev/net/c/bb567fbbbbb4
  - [net,v2,04/10] net: fill in MODULE_DESCRIPTION()s for ep93xxx_eth
    https://git.kernel.org/netdev/net/c/53c83e2d3648
  - [net,v2,05/10] net: fill in MODULE_DESCRIPTION()s for nps_enet
    https://git.kernel.org/netdev/net/c/27881ca8c8e1
  - [net,v2,06/10] net: fill in MODULE_DESCRIPTION()s for enetc
    https://git.kernel.org/netdev/net/c/07c42d237567
  - [net,v2,07/10] net: fill in MODULE_DESCRIPTION()s for fec
    https://git.kernel.org/netdev/net/c/2e8757648855
  - [net,v2,08/10] net: fill in MODULE_DESCRIPTION()s for fsl_pq_mdio
    https://git.kernel.org/netdev/net/c/8183c470c176
  - [net,v2,09/10] net: fill in MODULE_DESCRIPTION()s for litex
    https://git.kernel.org/netdev/net/c/07d1e0ce8743
  - [net,v2,10/10] net: fill in MODULE_DESCRIPTION()s for rvu_mbox
    https://git.kernel.org/netdev/net/c/bdc6734115d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



