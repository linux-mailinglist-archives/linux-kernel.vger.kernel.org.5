Return-Path: <linux-kernel+bounces-18922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FFC826525
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76B1B214EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22913AEF;
	Sun,  7 Jan 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHbt0KpC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747012B60;
	Sun,  7 Jan 2024 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B727BC433C9;
	Sun,  7 Jan 2024 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704645623;
	bh=xJqTpdHlsLkBAuHocAoxuNoxLY3qzEXuQy/c9JHk+s0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IHbt0KpCwhjDyH/rAE8sir2BMYQ33KvASkvfBX40YxDm4klh+qK8Dhv2ovn9SbnPk
	 /Vgj1bKs4H42Uav6qUXPT7Kit1VolhcH4kKGgz23+AoGf/NrE/BNG84NYdWZ7af9GQ
	 jU69Ka6YW/psTlafj5ivo2+IWXITiIGh/RKtKi+WfcyYG2wq+pw1fjW1YI/4sh/n8r
	 iaN2XwNKmCVLuPprWw8jcQoJlF7PHsjY8M5/KY+MLcejZzDOUk3x3nCxZNJ7K7gQna
	 gQhS4IzyWYSPdhK5jNtIC5uVrYtsMrle5dQmYQld45tWuCY0WXYj32S3U36ZHsDkqC
	 lEwU9n9CSk52Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C3ADC4167E;
	Sun,  7 Jan 2024 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: stmmac: Enable Per DMA Channel interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464562363.18664.8264531122295136817.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 16:40:23 +0000
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
In-Reply-To: <20240105070925.2948871-1-leong.ching.swee@intel.com>
To: Leong Ching Swee <leong.ching.swee@intel.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jan 2024 15:09:21 +0800 you wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Hi,
> Add Per DMA Channel interrupt feature for DWXGMAC IP.
> 
> Patchset (link below) contains per DMA channel interrupt, But it was
> achieved.
> https://lore.kernel.org/lkml/20230821203328.GA2197059-
> robh@kernel.org/t/#m849b529a642e1bff89c05a07efc25d6a94c8bfb4
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] dt-bindings: net: snps,dwmac: per channel irq
    https://git.kernel.org/netdev/net-next/c/67d47c8ada0f
  - [net-next,v2,2/4] net: stmmac: Make MSI interrupt routine generic
    https://git.kernel.org/netdev/net-next/c/477bd4beb93b
  - [net-next,v2,3/4] net: stmmac: Add support for TX/RX channel interrupt
    https://git.kernel.org/netdev/net-next/c/9072e03d3208
  - [net-next,v2,4/4] net: stmmac: Use interrupt mode INTM=1 for per channel irq
    https://git.kernel.org/netdev/net-next/c/36af9f25ddfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



