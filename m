Return-Path: <linux-kernel+bounces-120286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4088D55C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C51B21E65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE02561D;
	Wed, 27 Mar 2024 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyocSwZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A322F1C;
	Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512575; cv=none; b=R4jw8pDUHoar3vJDAN+FVGHOnq+i/k89A1VVlo97IcDxj6xbynTfd9IkfUfrKKwWjKD7lp2/dkCInCZ+jpq9fAVIIAplQICLyEWPBz7RjhLyOQINN5nJMOjSge0TONn508+8Biqq0v0Ef/0xjgQgjPZfdEsiQS7N3q5OOSuq/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512575; c=relaxed/simple;
	bh=5Z/+u3yQJXkig12YLCHeYknu32FDLCzB+SMwQmNvuys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZNtM4kP8KE/IepHH7yinDD0wcfoaYPTk0GDLZawgWdsxHXouQuvwT8H+luxE9TiwbErh3yGG65i5RiIO8JEnCfBWlRacm+vdV/ryjUzRX4A8y3CV9RVBmnsHL8WD2dqPGyY/cMnZtHRWwYWCb5HERkN6+ix7O84pCvBVJjsQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyocSwZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA6B7C43390;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711512574;
	bh=5Z/+u3yQJXkig12YLCHeYknu32FDLCzB+SMwQmNvuys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZyocSwZ6yOcuATiAPM+/A5CFmqB2UPBwEjkLAAuNeI901EDW1reiCE7324pehC0Xs
	 03MqE2TVyhVq5bzgvDOmXTt6JW68EGlfaxK4Ymc82qHoap0gRqW0fxuNoDnBi4zLGv
	 SmkWxCasvCFVLtskeUsriCmjHS2t4tCqwFlUXqPXA+CN6s/3JPTWCN14jQAH/XObSZ
	 Q90aBNgJnYTXY/FTPpyHC+cRo3zZWyiF6UhkBV07gLAcSftmMqb74+AkMXdfylmimr
	 iBSFGoKFx9MVWqqIJcHpNVfteHwO4D1CEMQ76qZBiGTVLIKnNDpE1Bi9pvhTtUJnCD
	 rKcnne1DFsVBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C91A1D95065;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: amd8111e: Drop unused copy of pm_cap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171151257482.29046.17101565198691559001.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:09:34 +0000
References: <20240325220633.1453180-1-helgaas@kernel.org>
In-Reply-To: <20240325220633.1453180-1-helgaas@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 17:06:33 -0500 you wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The copy of pdev->pm_cap in struct amd8111e_priv is never used.  Drop it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/amd/amd8111e.c | 1 -
>  drivers/net/ethernet/amd/amd8111e.h | 1 -
>  2 files changed, 2 deletions(-)

Here is the summary with links:
  - net: amd8111e: Drop unused copy of pm_cap
    https://git.kernel.org/netdev/net-next/c/ee36b1e93b11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



