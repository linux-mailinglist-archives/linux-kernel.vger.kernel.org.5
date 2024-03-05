Return-Path: <linux-kernel+bounces-92880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA816872770
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA591C22CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E205675D;
	Tue,  5 Mar 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAGitdBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450928DDB;
	Tue,  5 Mar 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666431; cv=none; b=H6qWi+x//cbrVZk0XkKGjUz2nuPHgv+SKyanyix9mghk+BKesDT9fvYubwb4p6iliFMY1EIsf1AFYhxbg2gg+IyxNKtl8TV6psK77ISCMEpU8Vh5S9zHvEBglfk16iR7+9b7hVczJ0/DpVa59L4wOYaiLgi5bNsdR4TEglnGOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666431; c=relaxed/simple;
	bh=xzqF0FmjD3O9/gjXQ6sdofXmsm0nYugCVSlht7smMBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JsoRV5pl0XM/6so4TN/5UrW0k+1fz7DWPCRi8h6r1PhbaK8f5Bizbhf1anN/oymu5h8S4GHGX3mSM7FGFadsaHyTwB6dapmKNRfTW6yy02ew3+C9/741nKwwQQhCZb9x4oRBq/N+YZ5rP4KSnb1AJuussZ/GjdC8rGv47vJTpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAGitdBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5970AC43394;
	Tue,  5 Mar 2024 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709666431;
	bh=xzqF0FmjD3O9/gjXQ6sdofXmsm0nYugCVSlht7smMBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAGitdBkYFqBHEbXxNmJOc1vu45bzua63ej6k8ZUzUsOVPP2I/FDw+Fu2RkSo9bWV
	 U0QI5HF6EefmGGub/5z1S6mlLuhwe7uG/HyYBPA7pTpvLSreZidiKjvwxtpWf6a7Zj
	 Yyn7GPGkZGMjdP6IatVYFhFYmfoOoNf2SMDqnCo9cDLb793kvk0ThUKjxTIiEOQ3gf
	 eiN6Ff8LrZPHcn5MfEfC4BQ8trWvv348OfRzkKP8c3ONj3L+DvMRKOPGGzzEK/c7QC
	 I4rppZtg3UW7BH4jHoXC0Ot1psSZ4EHce6fUyGSDWP+U/dqLIqcngfEewou2qPGJ6K
	 L1tX71Gu2CIDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44F22D9A4BB;
	Tue,  5 Mar 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: phy: micrel: lan8814 erratas
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170966643127.28029.9572611359773459427.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 19:20:31 +0000
References: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, arun.ramadoss@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Mar 2024 10:15:46 +0100 you wrote:
> Add two erratas for lan8814. First one fix the led which might
> stay on even that there is no link. The second one improves increases
> length of the cable that can be used when used in 1000Base-T.
> 
> v2->v3:
> - drop trailing underscore from register definitions
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: phy: micrel: lan8814 led errata
    https://git.kernel.org/netdev/net-next/c/e9097f8e1e76
  - [net-next,v3,2/2] net: phy: micrel: lan8814 cable improvement errata
    https://git.kernel.org/netdev/net-next/c/ad080db4483b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



