Return-Path: <linux-kernel+bounces-39536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B683D27C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D9E1C2470D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5708A8C18;
	Fri, 26 Jan 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VexiKbuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7927475;
	Fri, 26 Jan 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235624; cv=none; b=bKzMli3pvd+FWmswJ1i+T8L7BTUlLJAGOHQ4q/hO1Srg2P0Xnw5HE/6oAEmLYnOJYq0PkbXXBOwwl2kUxsyANTn6h8qtwwcZ48/UF0CgG0GPDU4SLnixZQRPRd40aMY2m/0EOGChTgPSP588voonj0PROs6o7/vqT/wk4Sx0jAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235624; c=relaxed/simple;
	bh=XydMzCkZqpTSrk2ptn7qOu5OKTaNmw3EnRJU88OcBbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oKnRIB7xVAQhUK2k5mciPG/NXqUC1r6OyVSPaJcy8dRtj58JFP4JLwjUIL37TkhGdm9K2V1uJ+2FJYaXuu0zQsqAiwznTtgxivA9+ETidIS+WYuSYTK74Svvjc5q7ToqmHRhSoW39h4LkOzcoN5u30QBAjcbmlZ7yQdytRKBQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VexiKbuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DE65C43390;
	Fri, 26 Jan 2024 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706235624;
	bh=XydMzCkZqpTSrk2ptn7qOu5OKTaNmw3EnRJU88OcBbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VexiKbuh70fuOyNI3mszktMmJESVD9zUPTEjBgzUiBCtSFQ+XTs6+rx27uAfLJx7J
	 gVQg+WDfvETqIlZR92KWLUkcZCiFXFZUM3alPeQ3LyFc63hKgbSy+PEe3w5Y0M8DRn
	 crNaRswG1FV3X29jUynaEYvdGAF3MVRYfqH8Pr/yU3daeLBdzKd2pKpEJbPAwnKfIo
	 s6WdLyL/SEgpxlyJd+AGxDxrq9HCT+56iidx/3GuLp6PnQYGRsHCFD5J37EkUhg4qC
	 uprI5WdHRxFYMfkqb1S9RQ0JAYMAlq4BER547AR2YYP94AILLMq6MOb5rXFooWi22A
	 zHJ23XmM44deA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33BF9DFF765;
	Fri, 26 Jan 2024 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mediatek-ge-soc: sync driver with MediaTek SDK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623562420.30678.3476943936130627365.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 02:20:24 +0000
References: <f2195279c234c0f618946424b8236026126bc595.1706071311.git.daniel@makrotopia.org>
In-Reply-To: <f2195279c234c0f618946424b8236026126bc595.1706071311.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: dqfext@gmail.com, SkyLake.Huang@mediatek.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 john@phrozen.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 05:18:23 +0000 you wrote:
> Sync initialization and calibration routines with MediaTek's reference
> driver. Improves compliance and resolves link stability issues with
> CH340 IoT devices connected to MT798x built-in PHYs.
> 
> Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mediatek-ge-soc: sync driver with MediaTek SDK
    https://git.kernel.org/netdev/net/c/ff63cc2e9506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



