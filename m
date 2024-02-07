Return-Path: <linux-kernel+bounces-56536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F584CB63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D190628D95D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CDA7A73C;
	Wed,  7 Feb 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjxBGp3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED807A727;
	Wed,  7 Feb 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312025; cv=none; b=Lnk32xtK19M2E+T3LCOGMyEP1LJ+6eS35R9qdTvqKzW0Kp6rcSXy5h9ZHI6Th1+rq4K6wMfhn5AmbX630yUsIhhW4H3OouOgIE6XoStpgP+oJDMG4Qv+lWheIC1ccKooI8Gq91aQ5X2O5HzheotXLMfnvAFYtfhqPYNCNaSQUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312025; c=relaxed/simple;
	bh=RkkxMURcQYHsuNBBv0gRNjhPUDzysCp4D4GRibrNdV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwKRt2wGDqQ9N/gIh3hikvSZwB4XEDOHzX961RM9D6Nlj6COpetndk5X0FfEythDoEi6BCj1DA7lQ/PVvWf1cwpKKgWLWE0lwN36FMjUQqx/8jyc7pXB4HqDLmHPQk6r6g0gvFJgUo++5xvpNATgCAayHtlzIfd5k2xz62TxSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjxBGp3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED29CC43399;
	Wed,  7 Feb 2024 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707312025;
	bh=RkkxMURcQYHsuNBBv0gRNjhPUDzysCp4D4GRibrNdV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XjxBGp3U1a6Kin12cOUX8u7jSOuNNp21BdKBPrinArH229yoyQhOHThW5rEBomZha
	 z5uZuUovBaxu1BgjFEffBuof5nKs6WI07gSepsvoLAAI5tj8JNUIcecKtV5kGpyDvN
	 CahjPC/WZHsTgyIIk6oJyvTLd9QJEr0bChHFjHU6dm9mtQ7euurmV/ZG6vQ66jVpK3
	 cbrALTreOXc2RV1zYNCNygUoXWxS0tE7R0ONZO+SM8pLTq9iAUeEISLfwNkmvjY484
	 m9mtfvJVtCX8GncjHqB68TCEDNcPXTuMoTbsDJkmsGS3WWcZj9ZDgRXlOTUL+wcYcV
	 yIYNFSliZaQvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8C1BD8C97D;
	Wed,  7 Feb 2024 13:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: remove duplicated CONFIG_SUNGEM_PHY entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170731202488.6388.17398610577992355384.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 13:20:24 +0000
References: <20240204123151.55005-1-masahiroy@kernel.org>
In-Reply-To: <20240204123151.55005-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  4 Feb 2024 21:31:51 +0900 you wrote:
> Both drivers/net/Kconfig and drivers/net/ethernet/Kconfig contain the
> same config entry:
> 
>   config SUNGEM_PHY
>           tristate
> 
> Commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup") moved
> SUNGEM_PHY from drivers/net/Kconfig to drivers/net/ethernet/Kconfig.
> 
> [...]

Here is the summary with links:
  - net: ethernet: remove duplicated CONFIG_SUNGEM_PHY entry
    https://git.kernel.org/netdev/net-next/c/81f61c108838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



