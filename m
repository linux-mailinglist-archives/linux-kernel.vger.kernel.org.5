Return-Path: <linux-kernel+bounces-18898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361338264CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462701C20643
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0913ACF;
	Sun,  7 Jan 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQjCu3/D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE5134C9;
	Sun,  7 Jan 2024 15:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A8DCC433C9;
	Sun,  7 Jan 2024 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704642023;
	bh=tGn/7dhPk5c9YtVIKGXoYB26prxXPiY1VNsjLYaBRE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BQjCu3/DEsf8YjwDknLvudJ66vUpzVr7VH/qMZriGPIoURm6HCcKV/n6TrA6vghYr
	 IengT6F3Lb6nLCrUQ1bWTJ1NAuT3iqrE2H2Ezliv07D3VnNgra5nSkyIcz/rP1asY5
	 pa01kNICfzYfnxb7alV6rl/Y756faSYaZvG1upByepu1wyAMqr+FqRmimhNpDAUR0S
	 +ElQxZTJzdvF9JdWi30oMZIT8ZT+4NSKcGI4hrX/v6o/nKkLhx3ygDc0agfLqjYzDY
	 J00pkyAZQBe/k2rG5CV/uHl7tY1HwLCfFwGVsmM0AB6xyUjQAyptgSmz8EEOOKjEWj
	 3umdidZ0ddjBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31777C4167F;
	Sun,  7 Jan 2024 15:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix ethtool per-queue  statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464202319.22284.15974320807514546693.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:40:23 +0000
References: <20240105201642.30904-1-petr@tesarici.cz>
In-Reply-To: <20240105201642.30904-1-petr@tesarici.cz>
To: Petr Tesarik <petr@tesarici.cz>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jszhang@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jan 2024 21:16:42 +0100 you wrote:
> Fix per-queue statistics for devices with more than one queue.
> 
> The output data pointer is currently reset in each loop iteration,
> effectively summing all queue statistics in the first four u64 values.
> 
> The summary values are not even labeled correctly. For example, if eth0 has
> 2 queues, ethtool -S eth0 shows:
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix ethtool per-queue statistics
    https://git.kernel.org/netdev/net/c/61921bdaa132

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



