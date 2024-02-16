Return-Path: <linux-kernel+bounces-68436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA91857A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DC61C23806
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADA24A08;
	Fri, 16 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvvV+oPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4F2377F;
	Fri, 16 Feb 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078826; cv=none; b=bSDpg9esidO/g4e1sEsXc8LjjvFqd7C77AT6V/ovaMj0EhyUmYvxjy7Y90zqqZbCNumzOSmUmWdZB1dtcxVXz9Ifaq3Y/v4jkdRbCeR/mZnSIPs89VMP6KSWXzWU/6IA/6M9ry/DEb7XuRoLsiK/gaPrsqAEsU9+r4brKiDAijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078826; c=relaxed/simple;
	bh=pZsYna/et6p2/duoVCMi3/XrHQ+0U2MOIh5owo7Tw0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RjOxw1x2tKjkHtImoH5EmA+KcyskE9ynw7mMOhykKApwUkHqxeSDcym4CY+NMJQ88r/bTzwobyV6cQ+oVlxaaq1RmD+PcpDvPAEIaO2v0UXlGzaxwL9Z/PhPOdtGUNf9hQROSaXg+vsofSQA8QqPWhVBZXj1yAfEhjsua4Bm4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvvV+oPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4145EC433B2;
	Fri, 16 Feb 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708078826;
	bh=pZsYna/et6p2/duoVCMi3/XrHQ+0U2MOIh5owo7Tw0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvvV+oPiL7QxQtHP+CNstFlmM1I3NW/nXjBqhpT3MMXTLvJXGPnb5tTvp8w3o7gni
	 WPu6KV7rgFqO8x8CNtn8vG+mfZSZdyHDCqynPqXsl8RH9UxPKSwB2t45jNbWL8U06u
	 mMDzNkrOYI/OqT5e6irJ2lVBrVY+TO2HmRJ5wvT2FLlWUH3QpsaAlh22VPg5vJ3deb
	 XemMWIh3w5LHZ+AYn8IFpq9L3EHQEXNoCnPzxjfBbTdo2CJ8RyYlITKCIy2xabeQxR
	 skY3lS34th8BTiVxhE0VSblwt79MzHUfET1g5dqpvqKtgsea+Idq53g3VlPdpJ0FkU
	 VuaFqrmMh6eXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B974D8C966;
	Fri, 16 Feb 2024 10:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND2 net-next] tcp: Spelling s/curcuit/circuit/
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807882617.14678.5225852820514541606.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 10:20:26 +0000
References: <edf02e55949ac00329a6df72940cc2f5e8bec55e.1708002686.git.geert+renesas@glider.be>
In-Reply-To: <edf02e55949ac00329a6df72940cc2f5e8bec55e.1708002686.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 14:12:21 +0100 you wrote:
> Fix a misspelling of "circuit".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [RESEND2,net-next] tcp: Spelling s/curcuit/circuit/
    https://git.kernel.org/netdev/net-next/c/21bd52ea38a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



