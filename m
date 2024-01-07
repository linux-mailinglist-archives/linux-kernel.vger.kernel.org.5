Return-Path: <linux-kernel+bounces-18918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2982651C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE71C1C2153C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C613AFD;
	Sun,  7 Jan 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g95m5o4d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA413AE6;
	Sun,  7 Jan 2024 16:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9953C433C9;
	Sun,  7 Jan 2024 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704645023;
	bh=eO6iIqGTyaZtpjjGK2t1Bq0svOz8KGKw3irzAkGS1S8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g95m5o4d1Z7MfoYaZwzctByrNrC73NWKozMjW9YdvdmqaScVUvAIUNZdBDoHsdU7q
	 wqC0VxwOezHD5pIRUrkgQTWOZyUVoxRo/zRcIwS0dF5+dprfeFiJPDmnhUlAEH1pF+
	 pEotpYpR7R35QOjZkwLhNUwBXSf9gJgFR98ThwN+eVnyXD/B2UicJTwv6tLVuI54xL
	 ahN1HluxWYvNQdRpvI9Ln9BT8/yv+sAeWNKBqkhzCdT0kHjokxgaIVTIlJOWKzpp0V
	 0qj2STEiJedg16aFclfZLeMiCM5JXkZ8ywPGh4runKryxECqhnzXHrSxzqwGNJZ3In
	 tDmw/LQeweg9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90D6AC4167F;
	Sun,  7 Jan 2024 16:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4 0/4] net: phy: at803x: even more generalization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464502358.13016.743477267420699601.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 16:30:23 +0000
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
In-Reply-To: <20240104213044.4653-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Jan 2024 22:30:37 +0100 you wrote:
> This is part 3 of at803x required patches to split the PHY driver
> in more specific PHY Family driver.
> 
> While adding support for a new PHY Family qca807x it was notice lots
> of similarities with the qca808x cdt function. Hence this series
> is done to make things easier in the future when qca807x PHY will be
> submitted.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: phy: at803x: generalize cdt fault length function
    https://git.kernel.org/netdev/net-next/c/22eb276098da
  - [net-next,v4,2/4] net: phy: at803x: refactor qca808x cable test get status function
    https://git.kernel.org/netdev/net-next/c/e0e9ada1df61
  - [net-next,v4,3/4] net: phy: at803x: add support for cdt cross short test for qca808x
    https://git.kernel.org/netdev/net-next/c/ea73e5ea442e
  - [net-next,v4,4/4] net: phy: at803x: make read_status more generic
    https://git.kernel.org/netdev/net-next/c/c34d9452d4e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



