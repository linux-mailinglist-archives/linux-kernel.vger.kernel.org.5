Return-Path: <linux-kernel+bounces-157948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B416A8B191F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C461C21AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30020315;
	Thu, 25 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA7Fgm0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63472171D8;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014029; cv=none; b=LB5ijXPFzolPS9PinmdRCh2osUg6lRs4ryp0QNMkKwLow6SqKP4eMiyrl0W/xfPKqpeaWAc3+s068X+qwE2v/SVODpldIrIsjzKugJPsKbkXeToVp8TKTt+gmAXoQ0PUrn7SFlLTADMh82hPJufngzZMZeuEIymDkk8kD6hU4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014029; c=relaxed/simple;
	bh=XIj766zs+rl6mguLe/jbcxd7JNX849LKBP+lOQPxhKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4+uKeQTlAWUZb5z0Lk39pcAavgTgx6xjTtIBuCCVH+zPQm8/y+Kg09CpVilKQUHaDKuU+RPcO2z14rNjVrT9+mKbgnmCYnTIm4CjRAQ5/Fagsrbw0eqzP4OIIr1k2sxOCMMqAoOIdO/hh3mula3FYb1wdJqiZdFgF/t20THR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA7Fgm0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C301C2BBFC;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014029;
	bh=XIj766zs+rl6mguLe/jbcxd7JNX849LKBP+lOQPxhKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NA7Fgm0oJ5a1WTE2akyBVpznNvxNjbWFIN8vXrx8za6EH0X5BrVUl3Yko7BzOHvYJ
	 5RULg9WTkEQKZcNwoJZ894U6CNV+4H9x1vKohpWKuxaJXIKxXhcxtqmuMb7lcKZdWx
	 AsPEAnKmKdjI4Z6Bkc5QEfaUG3Ml1fZqF19YYNtBilSJLuGDVhXlcCU89ToM7CBwLj
	 ET4NEgEDm3F88iQNT2eNpEmXFNwYtSZXgSwtJCuCf1VoFm00qcSZpDtyFmYPz6ntOb
	 lGhpf6Pi2o2dwE0PbPDj1/Et5rsY6rZjmQjkI8rDCYMkiLW5PlC4GkfYPeNGYkGKOv
	 0EkQCSo3FosQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 007C7C00448;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ethernet: ti: am65-cpsw-nuss: Enable SGMII
 mode for J784S4 CPSW9G
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401402899.32160.14525166802984508052.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:00:28 +0000
References: <20240422124515.887511-1-c-vankar@ti.com>
In-Reply-To: <20240422124515.887511-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: u.kleine-koenig@pengutronix.de, ronald.wahl@raritan.com,
 dan.carpenter@linaro.org, rogerq@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 s-vadapalli@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 18:15:15 +0530 you wrote:
> TI's J784S4 SoC supports SGMII mode with CPSW9G instance of the CPSW
> Ethernet Switch. Thus, enable it by adding SGMII mode to the
> extra_modes member of the "j784s4_cpswxg_pdata" SoC data.
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethernet: ti: am65-cpsw-nuss: Enable SGMII mode for J784S4 CPSW9G
    https://git.kernel.org/netdev/net-next/c/5bd8ebe4693c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



