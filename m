Return-Path: <linux-kernel+bounces-1946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9E81562F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B37B1C213C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A723185A;
	Sat, 16 Dec 2023 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1KwxCJO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351515AF;
	Sat, 16 Dec 2023 02:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9A6AC433C9;
	Sat, 16 Dec 2023 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692023;
	bh=4Hz0Df7ZRVIyM+yoY/dqnLclCsCXanDYk/SXDfuOQGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l1KwxCJOFoE8GEJjIsbKtb50cv7F6YQILvyPdejQNzva79rrScmkI8JUJcrlbOle5
	 dGCFbzUwd2jBBv+uRzbfSzraR/tKiFVNQeOrBLDXu1XgvLm6IBBEEHuaI5g+qsk8Hh
	 gFeG7tUKcGJyAjG7VxVo5t2OmdICnCJq+nWDsTLXvutHfXvjT6oTz3GH7dym1xZTkZ
	 JUx0lSu/QorwXmr1kSZFbIYhTKlpk5I7gxqoCTjDTajAWUpb9ahN7Z9sYpcze5FOTW
	 VsxmN4K/wnA5zJkTkzeAVzXJb4D8vTkILMx1aOfsMp/cu+1Y9ecg9wHMu+6jiLoofR
	 PJNIdAd7jvrjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CDDEDD4EF1;
	Sat, 16 Dec 2023 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170269202363.25497.13353904321584984908.git-patchwork-notify@kernel.org>
Date: Sat, 16 Dec 2023 02:00:23 +0000
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
In-Reply-To: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 00:05:35 +0000 you wrote:
> Calling led_trigger_register() when attaching a PHY located on an SFP
> module potentially (and practically) leads into a deadlock.
> Fix this by not calling led_trigger_register() for PHYs localted on SFP
> modules as such modules actually never got any LEDs.
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.7.0-rc4-next-20231208+ #0 Tainted: G           O
> 
> [...]

Here is the summary with links:
  - [net] net: phy: skip LED triggers on PHYs on SFP modules
    https://git.kernel.org/netdev/net/c/b1dfc0f76231

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



