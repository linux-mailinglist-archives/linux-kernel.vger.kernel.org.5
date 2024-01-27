Return-Path: <linux-kernel+bounces-41061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7983EB0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1821F24851
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B313AE2;
	Sat, 27 Jan 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAbgo4Jo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52957125A1;
	Sat, 27 Jan 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706330427; cv=none; b=FlLNeYSKaLLkgEep933zmfHS/MYrkTU+ObCod8NGkkbiuRkWkCcj3vLZaSovKy4jBYQz8DAHV4nW/W0TTl5JVE+qQHKn8Bl6K5hIGwZl0cUxHLKjsW8spmboahkwNoi+FZrQ3m2knxE+Ke0id9EwSPkwcMit2uQhrfA1hh+uCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706330427; c=relaxed/simple;
	bh=Fa54+stwdOC7SyjNCmWKpZ6BNsnqZ7X6lOOGTr9GTOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AVv0SFaqVmLl/rzGpMaojTNSMbSsAHHNpGdDVVQRPJMGFSxEKut7Y8PuPcU6RYicXWmhWqtvc83aJy22ZTp4+CdCrxO/mhrmR0ibq7BmJUiQ63z1gaD5Uj7M85sB9Z9/cVQxPjqXtXyV9ElNEckveVOFE/5ptZ2TQU7NKEP4isM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAbgo4Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE59EC433F1;
	Sat, 27 Jan 2024 04:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706330426;
	bh=Fa54+stwdOC7SyjNCmWKpZ6BNsnqZ7X6lOOGTr9GTOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XAbgo4JoVubLqSfkxGeZEBZv/j8kHykk6Jle3TD4/XhK90SxqMQZcbhDd3PBcoGqn
	 IEumJBPwYwFbJaPa7pEs0YJn6EwoiCdDaT6QDKXQtwE8BdOLb91nvIy9mUl/5RPjNs
	 JarAmakm0gn5iA3l3qLkHBGqVoKFLj1xiDGdZFJLkJk9yEjyXDm/PxoadL+UEf7POf
	 84QtfozdGiSIQNtP4LEwEqG8wt35J8gANMnAekANRz0r8DDNwJChQgRvICXliwHVJX
	 rzFIqVuov+ws0BgJZi+1dD5H5Ja6KcvhIvP0aiB1Z73JwrzWqVHnpCYWi+A97aGqER
	 UJAUdNM3Gs1yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A27E5D8C962;
	Sat, 27 Jan 2024 04:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mt7530: select MEDIATEK_GE_PHY for
 NET_DSA_MT7530_MDIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633042666.8750.8620962707423438801.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 04:40:26 +0000
References: <20240122053451.8004-1-arinc.unal@arinc9.com>
In-Reply-To: <20240122053451.8004-1-arinc.unal@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCA8YXJpbmMudW5hbEBhcmluYzkuY29tPg==?=@codeaurora.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 08:34:51 +0300 you wrote:
> Quoting from commit 4223f8651287 ("net: dsa: mt7530: make NET_DSA_MT7530
> select MEDIATEK_GE_PHY"):
> 
> Make MediaTek MT753x DSA driver enable MediaTek Gigabit PHYs driver to
> properly control MT7530 and MT7531 switch PHYs.
> 
> A noticeable change is that the behaviour of switchport interfaces going
> up-down-up-down is no longer there.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mt7530: select MEDIATEK_GE_PHY for NET_DSA_MT7530_MDIO
    https://git.kernel.org/netdev/net-next/c/fb4bb62aaac7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



