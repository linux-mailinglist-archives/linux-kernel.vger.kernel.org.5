Return-Path: <linux-kernel+bounces-158804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345D8B2520
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF338B24FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E914BFA3;
	Thu, 25 Apr 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZkw8+EZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443514AD2F;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059034; cv=none; b=cqLq/OXvcLif+Ew2V0hkKvKAnvRwkcRSWPyZNVUaaicb6DXTJKHzqCuSCEHyYUeIQO54bxr+q6OYvZwL5B7ZE3s94aR7lnDLezznkPdmNiI12X0OqY5u07hKxwa358rbdnpnUSeJtxvU2EhektG00CK19gzSB0L8ozB1k178kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059034; c=relaxed/simple;
	bh=gUSLbzxAFjoTHvhf/UGxNryWbTZm3Kr57AkiJjhbJSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CqMA19p++iq8yHgF9yQkyPz3xXK8f2ZSGhhwGfqV2LKGp2+RnK8akAHXpDSqgYECAS/cAwyyToKxpX04BFiGWTHcGOuTjmHU3a0w6OmoSZEQhMzbhmy2KWHVXH2CPIvgo58gyGXYEFA+DycHw88SHZNaE2U87MrOQmJoIkXpDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZkw8+EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E7A4C113CE;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059034;
	bh=gUSLbzxAFjoTHvhf/UGxNryWbTZm3Kr57AkiJjhbJSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZkw8+EZoMU7PoHKxuEmTbaq+kiMkDD3op0/mrQDsnXFkSHAJhMucNjzxssHKJ8Wg
	 cqyarp90+aSaWtlxV6rJ1LqWgoEkp8eErMSsc7EVL+uYasvswzWnSIt34MQj4a5Qn4
	 kjBgoiAy9XBtYKZvGPweZXbueImUSnRcs0ZZP4FYB6aX0PRKm2M8Q41kgaj5/2oE5o
	 pKvRexppZtx/Dc/PUBWlc3x8BLjsL2iLj9qy6xmOxVYGfzotTlkcIucwJAAihlfTOg
	 QknvVUHD26M2f2lmKO+eETZeCVyb5hMrj/IkRCbIy9DrJgJGAY7ZM51mIA+IsxuHuG
	 sQnL3U1WZR5lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29F3EC595CE;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message type
 on TX packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405903416.5824.618925777912040630.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:30:34 +0000
References: <20240424071626.32558-1-r-gunasekaran@ti.com>
In-Reply-To: <20240424071626.32558-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: s-vadapalli@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jreeder@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com, ed.trexel@hp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 12:46:26 +0530 you wrote:
> From: Jason Reeder <jreeder@ti.com>
> 
> The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
> field from the second nibble of the PTP header which is defined in the
> PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
> the first two bytes of the PTP header are defined as the versionType
> which is always 0x0001. This means that any PTPv1 packets that are
> tagged for TX timestamping by the CPTS will have their messageType set
> to 0x0 which corresponds to a Sync message type. This causes issues
> when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
> timestamp that never appears.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets
    https://git.kernel.org/netdev/net/c/1b9e743e923b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



