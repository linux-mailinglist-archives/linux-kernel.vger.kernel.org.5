Return-Path: <linux-kernel+bounces-129511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D14896BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12848B27EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAC13C3DD;
	Wed,  3 Apr 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOVvyirC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC613B588;
	Wed,  3 Apr 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139029; cv=none; b=BwQNQ9c8lu6Y/k+eYTAvvev4iQyZE/N0WPKHdcOa3lfKyt+LitFuWfv5YxDnDmlwpQ1DObGuKiCKVXAW2aXIugMkuO7YsRFzb6YEWVAJ2xSOjVI4NFI0h0ZcpCE56OFF4H/jLNMm4WHkExpF77wFBlgIRzCZBu7vKFMT75RDxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139029; c=relaxed/simple;
	bh=/YRQUcWLxuJflSMLVytP/4K6BlJdo/9N6LMmYenJgV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jIoJZAsbUodr+0F9RCl9ZoiaK9IVr1BiJ4b1qo5ghxEZyc4VPv0OhGwsOG8kISLUeleX4MPzbvYYbSJTtL19HP04AeXeNxujpLmCf5AgAESs15RsuGdP5utd59uUA6PKm8rTX5fTal7M4MqsgWGpD8BR1QYg4T3+hv4UW5nUQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOVvyirC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AD3EC43609;
	Wed,  3 Apr 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139029;
	bh=/YRQUcWLxuJflSMLVytP/4K6BlJdo/9N6LMmYenJgV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FOVvyirCMmZUiGMDPqTyGtPhxUIlYeUgKttRBz1OlppI8/BHR+KU2wVOBjNvB6yfE
	 2OP7Ip/UtE68U735iGG7+WVEW35esOEwjkdczrHZmkoz2E+CcKRpVRkEr2tAN6mgOj
	 WOVnfP3MRKkIe0l65igShNcntzDYbsXn9yAkufzaTCE5Lu6mPxzPMlHMksWOIWS5dn
	 bR6Vdcy1/L6dqDetmg0duLUy/38j5bV61mS6QuXldZfpCyFb63ctkWUFGGmCV/9gGW
	 5Xxq2bJwflvv77bVx4sE9Vlal0zJeDtl+49lNxbhfM98Hv44KSzp533IHpXUDcExOY
	 g2CiZUJx84RdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B225D9A155;
	Wed,  3 Apr 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4] octeontx2-pf: Reset MAC stats during probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171213902943.4996.6563501395536225095.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 10:10:29 +0000
References: <20240331124819.425930-1-saikrishnag@marvell.com>
In-Reply-To: <20240331124819.425930-1-saikrishnag@marvell.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 31 Mar 2024 18:18:19 +0530 you wrote:
> Reset CGX/RPM MAC HW statistics at the time of driver probe()
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
> v4:
>     - Addresses review comments given by Jakub Kicinski
>         1. Moved MAC stats reset before netdev/devlink register.
> v3:
>     - Addressed review comments given by Jakub Kicinski
>         1. Removed un-necessary EXPORT_SYMBOL
> v2:
>     - Addressed review comments given by Jakub Kicinski
> 	1. Removed devlink option to reset MAC stats,
>            will implement stats reset with debugfs in later patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeontx2-pf: Reset MAC stats during probe
    https://git.kernel.org/netdev/net-next/c/4c6ce450a8bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



