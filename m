Return-Path: <linux-kernel+bounces-47405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5285844D97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A4B26D71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6B2C1A4;
	Thu,  1 Feb 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK4Cj8Dq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8128FA;
	Thu,  1 Feb 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745630; cv=none; b=pGro8wNlS1Wht4luJsp5QxufAGJh+1fUSx2PitIUC0+VysxLfXrdfJWBFaLAAy9iFF3nNUVTfkt1zNFccMQSzII+ynLyXClrHCA/mCujmYe7d426hXuWMWYbQ/8+xhcD3IEkyP3iW54TDMf5b9Kz2qQiOmnc+v9/saNJsEEAv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745630; c=relaxed/simple;
	bh=zREvaHdfm6Af6CZ/mjkHydTi1oz70Sam0xHkCUDkCfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EW2mZ95DYg8w2nAzCaSupbYr9Gnn5JBsa/DenBWKTyD7lFGVEhJcjqDTxWPssYw8HDighzvfB/k3qq0Amj/kzxcmcZ1CY+QyGr18ULlYOKLt9LKExlKi5Z9+lXZFzprckIeEC4t33m2GKJTr89jVaKQQafR6YrKWnUQfSAiy3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK4Cj8Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E342C433F1;
	Thu,  1 Feb 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706745629;
	bh=zREvaHdfm6Af6CZ/mjkHydTi1oz70Sam0xHkCUDkCfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oK4Cj8Dqw6Mshr7jru5Tt6t+tgJDqFFEKMaNCdLLeLBBBT/V2E1TKQb9EP4aurbGl
	 Qj6aWb903Kfv75zsQkMAsS5ylx+Ve/oQ7PP+RqaBetPDmMqgXay+8vzuzVLs3+JKHD
	 omYDqYnqlIOHytvTRyMZUrK0EATocVC3OYcZEQPB1BWHC2wlCDzQpPs+RHsCjYPn3U
	 mEQ4Hwz/vuGfqf8L9wEsabVLYUNpM0o2mg4fjWGPWb0f2YHaMq/Jypi3QXcplmQ8ln
	 Mn4AGboJe8Rq+xpMLVBfP8RtOjan6O8BxsB+Ml8ETQ50m+qBYdWFxSLGujk/NrXtEh
	 RNVAkSlLxGoEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51D1CE3237F;
	Thu,  1 Feb 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] net: ipv4: fix a memleak in ip_setup_cork
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674562932.31899.696796459152019489.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:00:29 +0000
References: <20240129091017.2938835-1-alexious@zju.edu.cn>
In-Reply-To: <20240129091017.2938835-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 17:10:17 +0800 you wrote:
> When inetdev_valid_mtu fails, cork->opt should be freed if it is
> allocated in ip_setup_cork. Otherwise there could be a memleak.
> 
> Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
> 
> [...]

Here is the summary with links:
  - [v2] net: ipv4: fix a memleak in ip_setup_cork
    https://git.kernel.org/netdev/net/c/5dee6d692345

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



