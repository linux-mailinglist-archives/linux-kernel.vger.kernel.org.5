Return-Path: <linux-kernel+bounces-130837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E3897DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9B1F2832B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C992A1CFB5;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9He5KxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FA63C7;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197830; cv=none; b=M0BRirQMmFDL7+suNJpei0ByGIY5tfv5HYR7UnBeFLKqoIXysiJGnkhXobdhVjUJ7pYEsKHB1lv56Qc5vWibH4CaekGKISlCOeGfYPrGtOSXAIr4RoeZK1PPlZHUwQlPX9xz7XE7rtMpu1lT0wub5lMq/JG64TMOOVPdoWGr2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197830; c=relaxed/simple;
	bh=82VwNk/rrznjnf7YWCQAPlxhqBMk7TXJZ39OyfdKQRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZzlJOfcAaMuNswSXRCM4ILg5t29Z87bOdejb9y9eWjlcEthQS7s17a24YIY5CCW+bgLeIo5IXLA7zHGcoQ0BjZb1MBNtbdiVAKFogl2FzBTKOA2CnSK2+iiEn2GJE6cQCkH6JeKi/c4GqTLejTtUcV0qgTfNcRA+ygKrOQkYYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9He5KxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B72BCC43399;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197829;
	bh=82VwNk/rrznjnf7YWCQAPlxhqBMk7TXJZ39OyfdKQRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K9He5KxAokwR/yXd3xMOcIDaBuBg+DKjjVtW4jMnzYsYJwaHovM+p5zzXRyq5UYAj
	 4rGtgumU7F8VpwIFHH0357o5AcVcDTN1H+2tLFdjv6ugPRgPgykUc2lJHEzCw+kOmi
	 pm5P1X97YhDVv0rtAIiccYzPIfKtQWd5weHLIzor/PqF8l5v3EgN12vL0XhPH2/ot6
	 RmhIajl0+kzeYnl5YfhDtTwkvvGWAagg7AyIyf72N1tswIScEyRGSOr//3IQqp23z2
	 Qygkw/mDPR34YiCWsrsbt+enYfqfIoS0Bge6M8QS6EfLUJbUi5AN9MYGeVgHCHo9vg
	 1WUOozsMWsWHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2BE3D2D0E1;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/1] net: fec: Fix to suspend / resume with
 mac_managed_pm
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219782966.25056.2083186308558278938.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:29 +0000
References: <20240328155909.59613-1-john.ernberg@actia.se>
In-Reply-To: <20240328155909.59613-1-john.ernberg@actia.se>
To: John Ernberg <john.ernberg@actia.se>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, f.fainelli@gmail.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 15:59:29 +0000 you wrote:
> Since the introduction of mac_managed_pm in the FEC driver there were some
> discrepancies regarding power management of the PHY.
> 
> This failed on our board that has a permanently powered Microchip LAN8700R
> attached to the FEC. Although the root cause of the failure can be traced
> back to f166f890c8f0 ("net: ethernet: fec: Replace interrupt driven MDIO
> with polled IO") and probably even before that, we only started noticing
> the problem going from 5.10 to 6.1.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] net: fec: Set mac_managed_pm during probe
    https://git.kernel.org/netdev/net/c/cbc17e7802f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



