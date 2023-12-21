Return-Path: <linux-kernel+bounces-8606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51081BA11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED6B1F24F63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F3360AE;
	Thu, 21 Dec 2023 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMogsgic"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DC360B3;
	Thu, 21 Dec 2023 15:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F123C433C9;
	Thu, 21 Dec 2023 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703170823;
	bh=LlxzwAz224mEmMmzADaUuuXsPSYbvxu5dH/x5r8TGGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NMogsgicP4eXyI7tIUnQgXMBxLFduI5rf47nM40ScSC2vq9yTksWAs7OZIZQnehZ6
	 PS/UzgmWyBbApyvNZn6Gxc9522CJqfs5bDILAiu/iP6OxI3EhU8AQ5/XEitWCn5rkL
	 4XF+JDYECHA1oFa7Xg4Bmb62VkAB0WBC5L3QQcm1ZgW+nm0Wd6UCmCqU5nPXnb+hk4
	 A/GXx+TlIbcEOPIGqVahEaIhozOBBdk+zAsM2B8RdAr9Lvb0LRgaZiO7MKzyBcnI1R
	 pCaWBuoQvVcEJB0h4MM6L3sZbU0rVdAgtj7YsgpMJ2Dgu2LWGT81me5bHZc5EzZLG0
	 eRXaHmb1Bq9nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5488EDD4EEA;
	Thu, 21 Dec 2023 15:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phy: at803x: replace msleep(1) with
 usleep_range
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170317082334.5769.10549760261707030430.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 15:00:23 +0000
References: <20231217232508.26470-1-ansuelsmth@gmail.com>
In-Reply-To: <20231217232508.26470-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Dec 2023 00:25:08 +0100 you wrote:
> Replace msleep(1) with usleep_range as suggested by timers-howto guide.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: at803x: replace msleep(1) with usleep_range
    https://git.kernel.org/netdev/net-next/c/3ab5720881a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



