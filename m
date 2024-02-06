Return-Path: <linux-kernel+bounces-54995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C084B603
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E18DB25936
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F25C130AE8;
	Tue,  6 Feb 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3cETau6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208612FF9E;
	Tue,  6 Feb 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225027; cv=none; b=X23X/Z6AuzMklaQm32P57G5sbKfvJ/w22nOAuu8pIlcQ5qbj4lu8wtlUgKxnisKfdqOPWyizWBFk7yzcTlBZZirKnEScH9e94yt1K134Z9c8tqT2TN6XemGPVFNmFYQu4xALwAICBv78Vq3qYmyBkuv1fqTX2BFPPeOPfzhC8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225027; c=relaxed/simple;
	bh=63hxr8dgFRyLoazPW+F1Tfs3tLtAneTXVrW3w14F/Wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yju4EnvqAOXw5nIaE+yaNT0KyeSK1mHwPzPgXS2axi2gWfuAJoG6T3/qE1hz7UeuSJvnai3CaDLghwhtjrkZ59Oe5Foym3mVzF1GvaOhJZbkOQ4IA8fsLYmRNyr4/wALQFa7XEShmq61MsMMbS+ewl+A+0e/yyShf+BJ1Fe9Fus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3cETau6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D8D0C433C7;
	Tue,  6 Feb 2024 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707225027;
	bh=63hxr8dgFRyLoazPW+F1Tfs3tLtAneTXVrW3w14F/Wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l3cETau6FE+wzLBwJXO72pNw0/ONbR1F/Um/35GkCkyZR9IHQC9gyddzl7ppajivm
	 1i0JR2HREINMm/tz3/oC/kCxrulIj9j68B2gOA25ASG6tYP+DcGsv5Yew5wQcgBQYU
	 Go4QLoiaaLT1RDV/1tMEk51auFGz7CoASK8widU2YqiSf8xxuNg+5SJJtVoq3Ryl2o
	 fHJEEaHHuA38eSG//yFVr1Xl8v3kBfaeDUPYO8ggRMdb+3QQL+Ledc3B0szlrmLk0O
	 bZY0DDHY9CN0G4MmsCpIOCBEtC0fURShqHvNh0JqmHMeomfyegVc7etczCYtHspNLe
	 sUhj4qvmSMrOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 021BDE2F31F;
	Tue,  6 Feb 2024 13:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: xgmac: fix a typo of register name in DPP
 safety handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170722502700.6009.7954883492875206061.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 13:10:27 +0000
References: <20240203053133.1129236-1-0x1207@gmail.com>
In-Reply-To: <20240203053133.1129236-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jpinto@synopsys.com, horms@kernel.org,
 fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  3 Feb 2024 13:31:33 +0800 you wrote:
> DDPP is copied from Synopsys Data book:
> 
> DDPP: Disable Data path Parity Protection.
>     When it is 0x0, Data path Parity Protection is enabled.
>     When it is 0x1, Data path Parity Protection is disabled.
> 
> The macro name should be XGMAC_DPP_DISABLE.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: xgmac: fix a typo of register name in DPP safety handling
    https://git.kernel.org/netdev/net/c/1ce2654d87e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



