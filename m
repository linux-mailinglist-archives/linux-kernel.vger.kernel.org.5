Return-Path: <linux-kernel+bounces-70021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8A8591DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF3E2819F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DE7E11B;
	Sat, 17 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUcVBUDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8241E498;
	Sat, 17 Feb 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195826; cv=none; b=ZFqowSjlb8AOYpMVNxYOyPfWp0sIdQgjLW9M8k1EQY5znYZKECfFTpzAFZax/J4HJ6hHmT4U8NJzVEbWlZrud78/f2Yd/1yUIgWc0fi4IEkAmd1MZJ0j8IOpNF1piTunAGr4BMzRMFml7sc5mKeEv3fqNQZwDW5n6xdQa4e4F98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195826; c=relaxed/simple;
	bh=tDHoBtrkxZ/0jzu6S3iKZ2VIA9W0xR3UxtvM71RgyeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPrUpynPYWcwCNKkHg04fNyHEMfi4UZabVjjUUcOsElJtNFHoroPQTMJedCLVK45VA5y4dappYxSwSsM24vZh+Uaqu7P1bkkjsnpe+GBiSfaqUg8/gT5RKyAWWKLzfFDkMsGwDfS8rLIHfRTAmVL4TN7Mzj835PbNkW7y1lKj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUcVBUDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C59E3C43390;
	Sat, 17 Feb 2024 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708195825;
	bh=tDHoBtrkxZ/0jzu6S3iKZ2VIA9W0xR3UxtvM71RgyeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUcVBUDUh/5Qu6NcsXej5qk2ggMnUtyzEFashF4WpcCPX9ABF2o6VQkc/gokvfcRk
	 Lq07Ojgiy2ippKfN+pgDxJbpF0w861xfTYr80XgImvSESf7CXpzdk/g9B+UrNtf7MX
	 5PO2EqNj+0X9AqmGDItvvGHZb9l2Q/TWMNImwHmwrVgIDYqo36AEZ6azuR7x4UlQZa
	 uhcDpUVRbkEmsmJgROzGJGWs+Sgil+JonBoKxUrpP0Cl5pCmEeUgF1vvGoWTx/fyFx
	 p9CkdaG6Lpx7vkKWBqMrbTRfRCg6Uz/kt6F7g/THmw0hZeMuiNhPil78Dso/36mRG3
	 lbzoMRS9bvBGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADF62C04E24;
	Sat, 17 Feb 2024 18:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: Fix incorrect dereference in interrupt
 handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170819582570.11703.17257609518253001084.git-patchwork-notify@kernel.org>
Date: Sat, 17 Feb 2024 18:50:25 +0000
References: <20240214092718.331891-1-p.sakharov@ispras.ru>
In-Reply-To: <20240214092718.331891-1-p.sakharov@ispras.ru>
To: Pavel Sakharov <p.sakharov@ispras.ru>
Cc: horms@kernel.org, alexandre.torgue@foss.st.com, fancer.lancer@gmail.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, khoroshilov@ispras.ru

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 12:27:17 +0300 you wrote:
> If 'dev' or 'data' is NULL, the 'priv' variable has an incorrect address
> when dereferencing calling netdev_err().
> 
> Since we get as 'dev_id' or 'data' what was passed as the 'dev' argument
> to request_irq() during interrupt initialization (that is, the net_device
> and rx/tx queue pointers initialized at the time of the call) and since
> there are usually no checks for the 'dev_id' argument in such handlers
> in other drivers, remove these checks from the handlers in stmmac driver.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: Fix incorrect dereference in interrupt handlers
    https://git.kernel.org/netdev/net/c/97dde8402633

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



