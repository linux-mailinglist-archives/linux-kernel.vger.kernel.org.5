Return-Path: <linux-kernel+bounces-83054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CED868DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D0F1F24065
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C951386C4;
	Tue, 27 Feb 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqZcNk9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A22F9D6;
	Tue, 27 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030430; cv=none; b=l2ejvHTF1JXW6H40S6reIsCSqJJ7T+WPDnXIbB2Dj5twhgrCYDiakd1qimInH1UbXcYsxPQBqyOCvj3EFzTp7fnmlqvwKYtCmdYBiqqxNprYVZydg/MlmSvP+/eIQ6Kphhq2Is2J4egqOVrxQjkp8PfWdKQitgO00g1wg8ej/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030430; c=relaxed/simple;
	bh=jCSGc1Wib+G5BqkjiukbrPIc/tZkzpz0rP/lb8B64Ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tJiKdqoSpSGUvmKeJQZexCaWeuSwRhMjI4zw0Jf4a+N0HXQprshdiUEN2n10vwPvDowXL2j6rjRAtuZ6Shpkojth/1TTAuYesH2aiD6OCeGDvomkx8z+LYpiPwTK45HE5PMluz72WwyL00wCPzWpO3EvO4JFkAx1xoWkhDjz/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqZcNk9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64678C43390;
	Tue, 27 Feb 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709030430;
	bh=jCSGc1Wib+G5BqkjiukbrPIc/tZkzpz0rP/lb8B64Ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IqZcNk9xaVQyMQkXnNXLlzHQsWmGSeg1jmPg/r9y6jGSgS5zgmD0XQhREPoHB7+1C
	 O5R5l/b3djIv60CwEUxSY1+dtyTOK1furInFF77jHRXv84PITy0I7vmTwu2UqemR8S
	 wFV0rYnAersXW/7N3D4pgmFNQrsh7UgvDbWDKZBWKxpKf6tNn0moz3NpzR3UOP/AKF
	 pMAjdNexgMRX30wKYSK7Kx7srG3Xh7AVLYsDm4vUQ1V3HFWJomlO1smLZEfcIRitGJ
	 3ITT6spLychPyo/nme9oQprhRn3HupfRFwsNUsJVxrGNvMBwg7nUFNHvd1i7wYkgMh
	 Yg1G/eTXuCqyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4648AD88FB0;
	Tue, 27 Feb 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: stmmac: mmc_core: Drop interrupt
 registers from stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170903043028.17630.12024992708013538596.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 10:40:30 +0000
References: <20240223-stmmac_stats-v3-1-5d483c2a071a@axis.com>
In-Reply-To: <20240223-stmmac_stats-v3-1-5d483c2a071a@axis.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@axis.com, fancer.lancer@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Feb 2024 21:37:01 +0100 you wrote:
> The MMC IPC interrupt status and interrupt mask registers are
> of little use as Ethernet statistics, but incrementing counters
> based on the current interrupt and interrupt mask registers
> makes them actively misleading.
> 
> For example, if the interrupt mask is set to 0x08420842,
> the current code will increment by that amount each iteration,
> leading to the following sequence of nonsense:
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: stmmac: mmc_core: Drop interrupt registers from stats
    https://git.kernel.org/netdev/net-next/c/d0dc1e42109d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



