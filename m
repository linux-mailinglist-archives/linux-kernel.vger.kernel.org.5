Return-Path: <linux-kernel+bounces-146889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716028A6C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD5DB22C19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108201311B7;
	Tue, 16 Apr 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq6lFaCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDA131195;
	Tue, 16 Apr 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274228; cv=none; b=uCk7+Msov10ntrrEzNLtK4drRk9bHr57VKvlARzx4D8OzAmdHuShdhxTPfDuZsVrebPQIDpZ7AbD3Q8oK/f8yBhdZ4qt1cPQ9MtC5eh7W+pJEEsffB4lcWoWKH/kO8Esh9yzSoh3Ju7W4d8MPoWRBWywMmEm2vAbIJUDWAVi+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274228; c=relaxed/simple;
	bh=aA4uqCpBb9JBwERSpmyHDsEJPn5nBkFkNMN/fMAMKSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwGUSY5T+yP3lIDrmQTiFdoY5DRgTNHKf+GBB9mdrc6wIJ3QDRAPY5curPEIaQ6ozcDI+bsTw+u8v/YE+ZY0WkuXomWaD6I0K+UuZIBhpvn9imyzqSjLL1Oy6x+2bRiF1uqRIGSRuQ9J/W9AB0HkNa+w1ICoI2xOarIt+bYqcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq6lFaCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2DE4C4AF09;
	Tue, 16 Apr 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713274227;
	bh=aA4uqCpBb9JBwERSpmyHDsEJPn5nBkFkNMN/fMAMKSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aq6lFaCsdoy09SvzO0BEVTli2RWUVJv9xnmMPMmwT1BhfXe5tXfFoitvOkBM+gEAP
	 pwCjJdM/6gMWzQAxWLS6kGx2sprkXwaTV2KbaQvw6pQH0Opa6iSnbfHBYG2ZQP1Lmr
	 ba8gKFRacuNJFejnZz06+yCDKRrz+hKV4AlTkKrsE0qxxPEw1Ui8kJyAZgc9nl6YP4
	 JvsMAmPMNiNXgr4cnVXA1a8DE0tsLhNHdWYB0772xoBY/wTVlfwh5Fzs3DtbWCMHio
	 K0YIm9lYbdLNFlEXMyt+9T3rfygZs5NFFe1yywftFSkLU60ozktour23MM8XVZBGEa
	 ABeYiQLpkLVKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A18A8D4F15D;
	Tue, 16 Apr 2024 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: stmmac: Fix MAC-capabilities procedure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171327422765.18122.15477722399634396283.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 13:30:27 +0000
References: <20240412180340.7965-1-fancer.lancer@gmail.com>
In-Reply-To: <20240412180340.7965-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, siyanteng@loongson.cn, mcoquelin.stm32@gmail.com,
 horms@kernel.org, chenhuacai@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 21:03:13 +0300 you wrote:
> The series got born as a result of the discussions around the recent
> Yanteng' series adding the Loongson LS7A1000, LS2K1000, LS7A2000, LS2K2000
> MACs support:
> Link: https://lore.kernel.org/netdev/fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p
> 
> In particular the Yanteng' patchset needed to implement the Loongson
> MAC-specific constraints applied to the link speed and link duplex mode.
> As a result of the discussion with Russel the next preliminary patch was
> born:
> Link: https://lore.kernel.org/netdev/df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only
    https://git.kernel.org/netdev/net/c/0ebd96f5da44
  - [net,2/4] net: stmmac: Fix max-speed being ignored on queue re-init
    https://git.kernel.org/netdev/net/c/59c3d6ca6cbd
  - [net,3/4] net: stmmac: Fix IP-cores specific MAC capabilities
    https://git.kernel.org/netdev/net/c/9cb54af214a7
  - [net-next,4/4] net: stmmac: Move MAC caps init to phylink MAC caps getter
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



