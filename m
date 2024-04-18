Return-Path: <linux-kernel+bounces-150532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D853A8AA0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8CB23392
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE4174EF8;
	Thu, 18 Apr 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia4JPwSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983916F8F3;
	Thu, 18 Apr 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459627; cv=none; b=gV8P+uzlPwuMvjb5XVudrkY3BYGN5Y8Wm+qxGhLVcEc64Rokv8cUEx+ZzDJUoVBsD21VtDId/xFZdODxlv4usU/l3vu3YTrjwXr/yOOWl8aWmkgMz/51hZGQ8Z0bvLG47FrQqEk8cvEgO527F0jo6izML59ssgG7lJTfOsZDJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459627; c=relaxed/simple;
	bh=mH0Q97/Y97fOQxrSnxwyK1qS3x1JxJFKt+pHylwoJ0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iRmqpiAf5sbr9Bccb2Gur3rAstC1oV+wWhx5wuGgjS9SVfsHlpK0/Yv1d8X+PKy8jIZ6xvKc7URaZ68SUwmjWU+proqOYsaIdxVfXc7QHsH8q01ZquqAf5WfaqyfrRqEA9gwtvEo49H6f1Cn0jeJfqwYROvHfyd4wM7IR9MCZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia4JPwSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A7CBC116B1;
	Thu, 18 Apr 2024 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459627;
	bh=mH0Q97/Y97fOQxrSnxwyK1qS3x1JxJFKt+pHylwoJ0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ia4JPwSBElBNx6oISvmJN01lEMh7fdBinYV3GDirI7WsBczp0ytgO14+cAOsZ1yXT
	 xiLTCB6QmIM5GLi8A1ae5wLSBxlEp8BgLxOznlhaB1GFoFdZpcEMdOx0cu8Yrttl0G
	 dBlSfPlVHme3jrUt2aF8A7pEq3n8SPQzTlg5U2OFYI2Rv9hU6ftuYjH9zfTIRPKOn9
	 zZ5gUb/Mf7wKMNtCpPn63zSSCaaCDMu6AhQwwtjo0L3nLkzdjzsF3dc7qRmMwAIvr3
	 uQB1hBCZxq74TJ1mVMN0iYmGy8WZ6To3jpI8Vxa4vgOr/23TtoHGaXzjgh+oL0xnXw
	 6zM61MhadvVuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67273C395C5;
	Thu, 18 Apr 2024 17:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels
 before using them
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171345962741.29083.17254723554623596143.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 17:00:27 +0000
References: <20240417095425.2253876-1-s-vadapalli@ti.com>
In-Reply-To: <20240417095425.2253876-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rogerq@kernel.org, dan.carpenter@linaro.org,
 robh@kernel.org, jpanis@baylibre.com, u.kleine-koenig@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, spatton@ti.com, srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 15:24:25 +0530 you wrote:
> The TX and RX DMA Channels used by the driver to exchange data with CPSW
> are not guaranteed to be in a clean state during driver initialization.
> The Bootloader could have used the same DMA Channels without cleaning them
> up in the event of failure. Thus, reset and disable the DMA Channels to
> ensure that they are in a clean state before using them.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Reported-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them
    https://git.kernel.org/netdev/net/c/c24cd679b075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



