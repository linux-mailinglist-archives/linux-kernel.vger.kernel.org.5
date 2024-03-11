Return-Path: <linux-kernel+bounces-99549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9D8789DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948CE2815D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5CF5731A;
	Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9yRy3JV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EDF56B62;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191432; cv=none; b=H1P/k7zAy1UXsWKfsUsSlcUlDllh8ikxA08hTrVY99ch5tD/c3OQSb/TWADTVNYI5ErYvebTJng3X/zdeJ9zYU2D62M28zwFlccAtrnEVzU6KnxsqFC9DyYxeAWYNBC7w6aSXk1OSLoswMsLNw0simpS7fl/ADMXiHpULcIlURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191432; c=relaxed/simple;
	bh=Amobz8hL1y1+pwNdbYRA6/Ay9RRsBNun/Pet/xmErV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lgce4UmcOxDyfz9/2oy/PlZmRFPpr9bInagy211g08jJ5Jxsdx3NshFiV+bnqG/qdTDfQZ7SNM9E/MjEYahyYeYt8Nyi6mkwoYorBVi2W9G/uIkrXkN8UQ7z1POXygCuP/RHfexHF/c8G07N1tbeq/C593quz5AVxlh7NPbUupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9yRy3JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEB61C433F1;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191431;
	bh=Amobz8hL1y1+pwNdbYRA6/Ay9RRsBNun/Pet/xmErV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g9yRy3JVOLIJg6MbyIJu+f9YDuHiQIOJ37+gHbSILvcbZfraAa8VhD8srzQwRjqZP
	 b06swS8gBywEfB17TpFM7A71DZvuA/vqsEpCeJBqm4vrP0n7baqq6BQznKfBetKrOb
	 TmZsHt3Tykh3yJKJyy/wVzSG4w0mN5gwNTfih/ebJOBbxbPmX+r6uiGQOttO8r1JfP
	 WiPRnkbrgZwM+gnTcnjVwYCAcJCf3n25yOCQyZS2i1wWNWf6KvOmCWyXNkYu5lES1h
	 qGsn//VK+Cg5zrEJYDzPIEZkzr/nNVhyjgiRJVJPy3lwWarYE5lcKKrBDAdItfeV2u
	 I8U36j1iMRcMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A75F0D95056;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: phy: marvell-88x2222: Remove unused
 of_gpio.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019143168.14853.16706473250952626200.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 21:10:31 +0000
References: <20240307122346.3677534-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307122346.3677534-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 14:23:45 +0200 you wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/phy/marvell-88x2222.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: phy: marvell-88x2222: Remove unused of_gpio.h
    https://git.kernel.org/netdev/net-next/c/22ca20fd12f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



