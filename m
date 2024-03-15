Return-Path: <linux-kernel+bounces-104390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68B87CD29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DC328394A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E81C695;
	Fri, 15 Mar 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAIN5NIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9881C280;
	Fri, 15 Mar 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505229; cv=none; b=nqunSb0wAD+ZH/qHJU9klu9ziKxW7gN4g6k69pwWrUVzVvR19NgB4Q2gjZ4mFEe4OWAdsajir2sH+yKY9fYQeHAu4NmDM2Aku2SB0hOvt+pJ3r9tb27BS246RTPyDD7PrruF78+oA3M6HaQtZUFQN57OiwQYnI8JAVfbth7znjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505229; c=relaxed/simple;
	bh=71GAZqdw0qD1crd2WpK4nj51QmylewCnjCcyToSY0Ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iu6BIcjrBYo3SZwWSGEVIvsEc4aW3Yyk/0lgpRjUmYDjCnYk8cJ0TUT8Q9awlSFejSJgPYPjp0h2wzYE0UeMKc9r/i7fqgByUzDvfqO5UGpng2UrSIsbzI9j/N0wK3DOT8Qf03/AYpbpWJtOn2mSGeG25fYhiliFt0WKcM1Nd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAIN5NIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B45DBC43390;
	Fri, 15 Mar 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710505228;
	bh=71GAZqdw0qD1crd2WpK4nj51QmylewCnjCcyToSY0Ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IAIN5NIf86XFDLNo295h/mV58FKRf+bzng+hR6J/7BV2gHu+nqFgIvGAVlgqSwXSf
	 Nlakhs4eJCGXmWFX5DlZxJVtK7b+KPhLYNEIty0eEPaNQSxrwZrHlw8gDKyLwG4FQl
	 Yds3zfdb3DRLDWZ2SBryMjfBUl4gw3emYbAJIz5x5mV8oCBkzjHHZg6pmIJGEd1uZs
	 O8cp6PiyZtAPxmpyDfd2wIyu6qKEJBWi7pKcAQM76tetUtY9SQIkyOJsk44kmwajgy
	 xeLNezYbkiuhnBV1eOhGOrCyftsT5ahcbSmF6jGpgoj7o3sNR449SmrQdqHMFArTpt
	 0KB26vRbWJjAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2FF6D84BA8;
	Fri, 15 Mar 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-rk: Remove unused of_gpio.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171050522866.5558.8897544477408916350.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 12:20:28 +0000
References: <20240313140057.2088667-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240313140057.2088667-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: sebastian.reichel@collabora.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Mar 2024 16:00:57 +0200 you wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [v1,1/1] net: stmmac: dwmac-rk: Remove unused of_gpio.h
    https://git.kernel.org/netdev/net-next/c/19c5c04d3178

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



