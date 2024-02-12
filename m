Return-Path: <linux-kernel+bounces-61539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C6851374
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBE1B21563
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15239FCD;
	Mon, 12 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSfu6QtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C239AE6;
	Mon, 12 Feb 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740425; cv=none; b=lx9+1/mHaf1+K15W2ppo0YSFsJDPAK8IJrQHw2KHK9qPVjJtBRNFIuePu0x0FGWJOcdAiGnpqvVWjpqGQq0ig8oa2vIGFSFX/bJougL80OmCXeJbj8mFUFpUWL7DEctQ9gf7TM7S8r5QiTsal3Z4dq3ouSYiL4hxD0dg0JTsxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740425; c=relaxed/simple;
	bh=gB/R+1MMFxLFMzOB0/4CJor6d9ImZvMLWYMjs/5IUPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pnTZM2SL55WbALm52jYoqhB4UXUxSF4g1JFFlVyoSVyvOBrMlMkC/iZvz2ozublSQEPxOOSEPtBSVT3N9HcC4O5QBSgZblhqEYoM/Y0eWtABifPUC0mHo1gJbHmoek3+/9RqtJhiqsrPQJSvRLt87c4fDA8u6fLaFwkqEmdqu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSfu6QtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BECDCC43390;
	Mon, 12 Feb 2024 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707740424;
	bh=gB/R+1MMFxLFMzOB0/4CJor6d9ImZvMLWYMjs/5IUPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZSfu6QtX7L4rqdj1DU9a3qUWr6X10lacULcW5XO6i0plno7uYNkvPtzUiDqbirZhQ
	 6y2uEThuBlHnYcPBdqo0IhjZ2auDQgt7woqeedf0Kx98Q8qZobMoo0Xr/eQrkRQxNd
	 sl0tl6lRIjIoXgM/rq7/FNh0XJcLD6lBs8YbIwVoYDP5JVV1dNYIe9B29tYeOrNmUj
	 6KA+mCx+P/0/zrOWGDhcyVKYjVbuJyeRzzQuvCi0CckEkuEZiu3CTqE1kBV9qR64PQ
	 YmrLgZsPGdfmXO8nlM8TYUIEG9j3qyTXrgZb03vwMDSIrTEcK93ZTYbBlXj4LrP7jJ
	 ihlQQt9J5t/mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96006D84BC6;
	Mon, 12 Feb 2024 12:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sysfs: Fix /sys/class/net/<iface> path for
 statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170774042459.14948.6985239132809616975.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 12:20:24 +0000
References: <20240209095520.252555-1-leitao@debian.org>
In-Reply-To: <20240209095520.252555-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Feb 2024 01:55:18 -0800 you wrote:
> The Documentation/ABI/testing/sysfs-class-net-statistics documentation
> is pointing to the wrong path for the interface.  Documentation is
> pointing to /sys/class/<iface>, instead of /sys/class/net/<iface>.
> 
> Fix it by adding the `net/` directory before the interface.
> 
> Fixes: 6044f9700645 ("net: sysfs: document /sys/class/net/statistics/*")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net] net: sysfs: Fix /sys/class/net/<iface> path for statistics
    https://git.kernel.org/netdev/net/c/5b3fbd61b9d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



