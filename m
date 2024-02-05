Return-Path: <linux-kernel+bounces-52625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9FC849A98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C166E1F213C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962C1CAB5;
	Mon,  5 Feb 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB5Ni1/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89861C6A3;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136830; cv=none; b=EbHfNJkbdzeiN1Ig5RWTahUMlO++2NfzdS9g8bPOx9xMEjZ4n8bcFe3LdLhQz+iQ1/8sU7T8dFag9qfI3R2WMBKdDJSXeMYoD3l1hu6UD+Ima3USUR6eFvNKO8rFbG03BKvdQBoTCxtd4CREBmhYW+WiaYNFnrUuFA2mtvE7fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136830; c=relaxed/simple;
	bh=m3WsINejG9mt+LaZg7YOLBgHE6sg4vO0JusBqaY9D7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6uP33zsFenvNxDMORyBbXfUD7DmiNQUOJ4Wiu6OTXf2lTsLAbkbkj+iwYo6/mOiE6lGtmfxDnD+FoaItvDSeHtP8L8joXDLgK7qTZ2Q0VGk1QL3SufjMzlzyReikABjfyCSF4bPTEH6Vn7fxRqzEr7RmSR4WxBOsfg3zcdna9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB5Ni1/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EFE1C4167D;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136830;
	bh=m3WsINejG9mt+LaZg7YOLBgHE6sg4vO0JusBqaY9D7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QB5Ni1/wbp3UgkVl/QlQLf7I/LpZQ51K7Xj1qer0msACsSkHQnWZ5uwWPsyrJCVK1
	 FqAETj3tfMTQzp7iqxSyYMWA4OilhQm98Pyb9kfXURI4wXlMSgHOCyL7c/Sh2YkHkV
	 IHJ/77vDslndlwUsLEZbjGPDFapBXqgRSUQWbIbwbE7V8k8uotTdHnZvY0ohdoQPjS
	 ybWsCA5cD2pjpB5pta3TWi2Q/JTAD4IJYsMdEtLe37bKDpgXpYGD/iif0yNVWiYFVN
	 wwsy1wb+P2PucZ9ktcJuwULQ7y/fX5vxNM9RRIYovtpFGod0wgx6+G4mkd20eGUacC
	 zUGun28Cn791Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D531E2F2F2;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ocelot: update the MODULE_DESCRIPTION()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713683024.8022.2267399224887898520.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 12:40:30 +0000
References: <20240202160538.2139629-1-leitao@debian.org>
In-Reply-To: <20240202160538.2139629-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 08:05:37 -0800 you wrote:
> commit 1c870c63d7d2 ("net: fill in MODULE_DESCRIPTION()s for ocelot")
> got a suggestion from Vladimir Oltean after it had landed in net-next.
> 
> Rewrite the module description according to Vladimir's suggestion.
> 
> Fixes: 1c870c63d7d2 ("net: fill in MODULE_DESCRIPTION()s for ocelot")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ocelot: update the MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net-next/c/1c7bbea992c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



