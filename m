Return-Path: <linux-kernel+bounces-18887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0B8264A8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7871F218F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E4134DE;
	Sun,  7 Jan 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP4fwjtG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78631134AE;
	Sun,  7 Jan 2024 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5552C433C9;
	Sun,  7 Jan 2024 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704640822;
	bh=UPMVEb64skjeUyHTn9TCQZW9IZRq3RvDVB/yqJfBkO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SP4fwjtGEouAgElcfOGY+DuI1KXe75cc4fL5EzEf8qjVnlfFLOkqHYFmFpnAZMAFJ
	 BC9+C/9BuJJFb8NXmwdlQwM/NtA+nwZuyt3AmguMt1XMT8AD5CAMTPn26emtnZxCwR
	 gr+irB83wLUyaGiSj0fkj2mDrhExQzlr9ypQYTGKhvg7V7xSly167DkZhTde47B+Ys
	 1ykOiFkEJvGKsu8CMJws+Qhk+voKeMY718dAKdAIkIB3NsGBOMhT6BEmRVgxAXUvyB
	 7sJz8b0jBMH5OKiCbHqbsKRhVFvHUzWYdAzCn1qZ6uLv0ljm3fx4bT0B5cBUIdjf+m
	 B2rwia2n6WtKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD02AC4167D;
	Sun,  7 Jan 2024 15:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] mlxbf_gige: Fix intermittent no ip issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464082183.11926.8134099660170040578.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:20:21 +0000
References: <20240105155946.23121-1-asmaa@nvidia.com>
In-Reply-To: <20240105155946.23121-1-asmaa@nvidia.com>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: davem@davemloft.net, f.fainelli@gmail.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tbogendoerfer@suse.de, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davthompson@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 5 Jan 2024 10:59:46 -0500 you wrote:
> Although the link is up, there is no ip assigned on setups with high background
> traffic. Nothing is transmitted nor received. The RX error count keeps on
> increasing. After several minutes, the RX error count stagnates and the
> GigE interface finally gets an ip.
> 
> The issue is that mlxbf_gige_rx_init() is called before phy_start().
> As soon as the RX DMA is enabled in mlxbf_gige_rx_init(), the RX CI reaches the max
> of 128, and becomes equal to RX PI. RX CI doesn't decrease since the code hasn't
> ran phy_start yet.
> Bring the PHY up before starting the RX.
> 
> [...]

Here is the summary with links:
  - [net,v4] mlxbf_gige: Fix intermittent no ip issue
    https://git.kernel.org/netdev/net/c/ef210ef85d5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



