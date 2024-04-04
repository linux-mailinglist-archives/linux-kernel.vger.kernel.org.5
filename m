Return-Path: <linux-kernel+bounces-130846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE70897DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DF728583C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8C208D7;
	Thu,  4 Apr 2024 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh8kzrXs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888EA1C6B8;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199043; cv=none; b=I+LMqYDZSAOX9pmRFx9mQ1bpyitDtN+0ZDRi6Z5OhoAYuQ+fvL0OHr9P2NdOvd/Fwwjxx/bDuvUyqPYDp8yVB49/MBO/iU7LDUBfoHbZ8qJH7jUM1PWYxAzASrlCT8mOwv7GGo1T9uVvi1BsvRavvUzcC6wb5oo89k16cq0rqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199043; c=relaxed/simple;
	bh=odvhE1YlEOMzaSAUPNwLV6z7n9kpK3oSbXjCUb0ZqyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DxXiwlO7pnNqLvZdoviQpNZIkMlDGOMVAkilqFfyuw5+7PqvwZAcUNIVK98lWlw2Pk6JLyN/z4SrNOqUmehSp8C5PMZAUx2AwAwYYCHEPdmGj17bic7Jx33NBvNiH9VwANus2p9nOyU2Myyt7xd3K87+PL+Yj1dyqpK0aGhNf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh8kzrXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A554C43390;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712199043;
	bh=odvhE1YlEOMzaSAUPNwLV6z7n9kpK3oSbXjCUb0ZqyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vh8kzrXs6qPrr4LT8Hm+obM86SQow+aJoHY3h0tJLszfGgpwnD4c/IbypLDlhvusG
	 PFqHLBo5kIbA620KEFLiXjItL0kuDEUlo6kTuxoKYVoehW5w0Xcd+zctOrJ2/iQv2W
	 RHwNyRUkNvFmCfZ7Eiq/zjR+bR1/1pb3oTMBY4C0rgAQAmn26bb7rmBiy54jR1a90k
	 3r0ieObDDhE3MyMdRPaJ9pCGijCwqqY8/NKGjjxvJgeK+u+B0B0bp/Q0/shVgSgcj7
	 ICRU060engP03o0DHhfLptQYBWlgUscwfFs7qzKze4U86YGh7fSuXnk2JE2ISLjrch
	 06CIvTsYFZNeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19DAAD2D0E1;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/3] net: phy: marvell: add basic support of
 88E308X/88E609X family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219904310.5496.12968366093160890269.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:50:43 +0000
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
In-Reply-To: <20240402201123.2961909-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, eichest@gmail.com, dima.fedrau@gmail.com,
 kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 ahmed.zaki@intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 22:11:18 +0200 you wrote:
> This patch implements only basic support.
> 
> It covers PHY used in multiple IC:
> PHY: 88E3082, 88E3083
> Switch: 88E6096, 88E6097
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: phy: marvell: add basic support of 88E308X/88E609X family
    https://git.kernel.org/netdev/net-next/c/ada9841e3e66
  - [net-next,v3,2/3] net: ethtool: Add impedance mismatch result code to cable test
    https://git.kernel.org/netdev/net-next/c/9cc8a6e62624
  - [net-next,v3,3/3] net: phy: marvell: implement cable-test for 88E308X/88E609X family
    https://git.kernel.org/netdev/net-next/c/a9e4230d0b22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



