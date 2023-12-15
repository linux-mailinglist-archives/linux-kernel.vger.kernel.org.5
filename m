Return-Path: <linux-kernel+bounces-694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91218144C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B2A1C22836
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C918B1C;
	Fri, 15 Dec 2023 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxKiSKZ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047C18AEE;
	Fri, 15 Dec 2023 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 916ACC433C8;
	Fri, 15 Dec 2023 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702633224;
	bh=4WLPzR0ImxTYD0Q0FMSX4ET9eASvLOs7mKeotYiEWMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rxKiSKZ9Xsrq8fs6VVI827bmCS4bJU9EH9VujlT8U99F6OS9Ps06rZGVCLfVEYfAJ
	 7eKt4dUbcYanYZDLa9x38maqJ4t2DlOULtYObj99b7G4YEioN/UoKgKcWHDUAJ0Z0U
	 1M54qNioUGzM/ZhFEIz6S7BO1CtxjaNWsVcO4E8L06pRp+S/8cuxGHRlmvnvXjHyGy
	 JXAxuiXN+bwxRDSIripmR1yGR5qeDGgBnb5dcDxUCALOFbJ8cgg3e9nbNmiYO/NuGM
	 Gz8xECij3oAYLpHXFPsDBsvFHw3PUWKBN27StNebhZ7/zXUPt62vgu/J4D4dKOUezI
	 b+ARurfUxO4lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 779C0DD4EF5;
	Fri, 15 Dec 2023 09:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: stmmac: don't create a MDIO bus if
 unnecessary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263322448.1975.8565502940787597440.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 09:40:24 +0000
References: <20231212-stmmac-no-mdio-node-v4-1-c121068ccd17@redhat.com>
In-Reply-To: <20231212-stmmac-no-mdio-node-v4-1-c121068ccd17@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: fancer.lancer@gmail.com, andrew@lunn.ch, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Dec 2023 16:07:36 -0600 you wrote:
> Currently a MDIO bus is created if the devicetree description is either:
> 
>     1. Not fixed-link
>     2. fixed-link but contains a MDIO bus as well
> 
> The "1" case above isn't always accurate. If there's a phy-handle,
> it could be referencing a phy on another MDIO controller's bus[1]. In
> this case, where the MDIO bus is not described at all, currently
> stmmac will make a MDIO bus and scan its address space to discover
> phys (of which there are none). This process takes time scanning a bus
> that is known to be empty, delaying time to complete probe.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: stmmac: don't create a MDIO bus if unnecessary
    https://git.kernel.org/netdev/net-next/c/f3c2caacee82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



