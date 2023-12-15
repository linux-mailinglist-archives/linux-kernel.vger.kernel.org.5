Return-Path: <linux-kernel+bounces-793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA697814623
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CD8285789
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD524B53;
	Fri, 15 Dec 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BimTdDC/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D795724A0F;
	Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D2D0C433CD;
	Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638023;
	bh=OlSfeJcVeNSMeoBz+YhS9wkUlwyc3tmGntZF180CBoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BimTdDC/0cLHwgK+lxsDs6A4xzSfWs8RKlJWcARb2dC1TyPqvFdaAESqYMWsD97Dx
	 5xNlOKeYag2Y2c/XCn4vT52wJ3XAylpobvT2ErXQGYpXLE2m89M772b828e0Ugn/0m
	 i/IcfBT9UICUACDOLP95+rsecCfGiXFJ7p7YSHzwkBrIwvA/KohO1hX1Kt/e+j09aq
	 s7ezXsPH3fHmReLqpZskj9ZUz9tQjfwZBUf8LPZoR7kkRIBQrjfP3CVLTmCZsk6hNL
	 hsMLfviBaJcidGHqXJlxManJrGmVo+QHezm3va835671hOunMHoP8/6h3POGcxGYCT
	 kMrJ8G3aEKO4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51BEEDD4EF5;
	Fri, 15 Dec 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263802333.14267.5281972789359567842.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 11:00:23 +0000
References: <20231214130407.3481513-1-alexious@zju.edu.cn>
In-Reply-To: <20231214130407.3481513-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: sumang@marvell.com, chris.snook@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ruc_gongyuanjun@163.com, jgarzik@redhat.com, jie.yang@atheros.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 21:04:04 +0800 you wrote:
> In the error handling of 'offset > adapter->ring_size', the
> tx_ring->tx_buffer allocated by kzalloc should be freed,
> instead of 'goto failed' instantly.
> 
> Fixes: a6a5325239c2 ("atl1e: Atheros L1E Gigabit Ethernet driver")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> Reviewed-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v3] ethernet: atheros: fix a memleak in atl1e_setup_ring_resources
    https://git.kernel.org/netdev/net/c/309fdb1c33fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



