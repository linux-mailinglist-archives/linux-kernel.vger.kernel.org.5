Return-Path: <linux-kernel+bounces-66852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB13856264
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592D21F29769
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5B12BF12;
	Thu, 15 Feb 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPfJK27N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396D12B159;
	Thu, 15 Feb 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998430; cv=none; b=GCTmfi2Od0VsR2I7pMt7d4bdyDBXF2rTxoMm2zf788WHW2AtfD4Est9BPlwT1XG1R/8UF4RNrU9t5VjDUMqpqTCasIij4HwXabDONVG5sRKV/ErxNSOPxB+E+7izNSB76X85o1ReW9DGsHLxOLxoP2nwGe7B7U4Wm4XKgIWQUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998430; c=relaxed/simple;
	bh=n7XWVlJ30ROtgD2ce2nB0n1n7+WuFhGySXrc2eCuDwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bQ3jplqn0bilf1Z9pkgxd64FDH9RtN1bpk1Zm8BLV+3t7OWROsA3p6tdeqvF6lhHTwNwlnx2gf1ZBIbKRDN9l/Z4OgNxfPTInu3Rdgodr79BT0OjJ9IEM7FTY0nImU+ZnXrOJBPKiWHrGks/8gpJed/xGRX0SnYAQSS6nu7vNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPfJK27N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 095AFC433F1;
	Thu, 15 Feb 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707998430;
	bh=n7XWVlJ30ROtgD2ce2nB0n1n7+WuFhGySXrc2eCuDwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aPfJK27N7/LuJtcxSb1IGzZkX85PiArJBWeiXgksYHoWNAhDcn+r39mV34kknw6B5
	 XeoKMtlwueLoOMq4RWXGuoSX+Mf+WX81c80vZPPaAiMYSTHw3KMz7SbmckxrZ9zBBJ
	 8iQ8G44ytveEa5g4bNL6N92M4TmnsAqfo0PsM3P8j2IrjTNQMxB1CQldYoaE6C2MAN
	 KZpdngqRuJpRAs/Su8EGuro9HX6iLV+2VGUVwOOlKLVHkD7LayocUizUw12wruXqcR
	 X3pn7nYqpaqVC9bdTYjQhWHDzLrb+CT+daFFrr9N7wZ7pQ36fS6MwWVi22DiYpDyJu
	 Oj5f3uZU795MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0C6DD8C978;
	Thu, 15 Feb 2024 12:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netfilter: nf_tables: fix bidirectional offload
 regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170799842991.25035.16009895415680000513.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:00:29 +0000
References: <20240214144235.70341-1-nbd@nbd.name>
In-Reply-To: <20240214144235.70341-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, daniel@makrotopia.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed, 14 Feb 2024 15:42:35 +0100 you wrote:
> Commit 8f84780b84d6 ("netfilter: flowtable: allow unidirectional rules")
> made unidirectional flow offload possible, while completely ignoring (and
> breaking) bidirectional flow offload for nftables.
> Add the missing flag that was left out as an exercise for the reader :)
> 
> Cc: Vlad Buslov <vladbu@nvidia.com>
> Fixes: 8f84780b84d6 ("netfilter: flowtable: allow unidirectional rules")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]

Here is the summary with links:
  - [net] netfilter: nf_tables: fix bidirectional offload regression
    https://git.kernel.org/netdev/net/c/84443741faab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



