Return-Path: <linux-kernel+bounces-84469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77B86A726
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6642841B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB520B00;
	Wed, 28 Feb 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpN/lxUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB91EA99;
	Wed, 28 Feb 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090432; cv=none; b=jjDzFHNd47RqVXmppOMoZVHGIC5XQ2oVcY+Us1zbVStCMO8T5jrIQzidLayONG7wtgS+jhQG6mZAiiDe5efWkaTBUTea+TMrX2QINy8cV4y93+77GffL4dIVKXqOmT9rriofCvABgdiOjUXVgvVOwyUxwCqpmLchs5Mzg1UXqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090432; c=relaxed/simple;
	bh=3wWQoczVGccRSiNjZC5wgLQEM5RjKSL0bCWgYbtxbqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URDq4ax35AK21oIOK+hmw6oWXirnIBLHk0AIYTmLkQcF3R6N/z08VOjlb5OgfPOgXE5Suln1IBm5HzUwQ6sRi06C+dl8tu0QMSTcfgN6IINMl+MJ2Do3yDSNoQ9jh432AKKnu79Ak2s5p/kW0QPOb2+44yLtFpV5StW5Pe6yqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpN/lxUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 068D3C4166A;
	Wed, 28 Feb 2024 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090432;
	bh=3wWQoczVGccRSiNjZC5wgLQEM5RjKSL0bCWgYbtxbqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LpN/lxUQV98ZRCZwIyt3vZg99dqfLfGJd3ihE4j25pmfZQdSO4fK9AAgl3yGPMuI5
	 uyr9FDvWjEdqTi0XpGn4gjr4gQo4eyarVzcXQKBuwCaNqfQ/Ll9ms8GFzUyhxDFl+l
	 /TA1IEKRUyBR68G4vYzbMprHLNooI6nasDekocB1HNuMWSpGowS5PJg3bvwf/rXr8q
	 QI8FUEDAOaD9/j4lNdUtTFcG3dFWKalqO7MUzu/QBfyCCkpg3oQ7U8XeEy+PGM2gRA
	 yG5vsiV5SnmA/SgINZADH716/dP/wxV6zQyQd5Gy1MCmFQ/dR9LgfC3fi/KTepc6+U
	 SEXVBBenT6+JQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E79FBD88FB4;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170909043194.27277.15249396079487332184.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 03:20:31 +0000
References: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
In-Reply-To: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
To: =?utf-8?b?Sm9uZXMgU3l1ZSDolpvmh7flrpcgPGpvbmVzc3l1ZUBxbmFwLmNvbT4=?=@codeaurora.org
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, jiri@resnulli.us, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 02:24:52 +0000 you wrote:
> Replace macro MAC_ADDRESS_EQUAL() for null_mac_addr checking with inline
> function__agg_has_partner(). When MAC_ADDRESS_EQUAL() is verifiying
> aggregator's partner mac addr with null_mac_addr, means that seeing if
> aggregator has a valid partner or not. Using __agg_has_partner() makes it
> more clear to understand.
> 
> In ad_port_selection_logic(), since aggregator->partner_system and
> port->partner_oper.system has been compared first as a prerequisite, it is
> safe to replace the upcoming MAC_ADDRESS_EQUAL() for null_mac_addr checking
> with __agg_has_partner().
> 
> [...]

Here is the summary with links:
  - [net-next,v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with __agg_has_partner
    https://git.kernel.org/netdev/net-next/c/4440873f3655

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



