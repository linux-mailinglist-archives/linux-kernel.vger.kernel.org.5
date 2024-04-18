Return-Path: <linux-kernel+bounces-149428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE08A9104
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533931C212CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629694F1E2;
	Thu, 18 Apr 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhwIp13G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E939FD4;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406228; cv=none; b=pXTJObYF2TnwIMs4xuIa9dHDBm7jJJ3YfSFa05ObJWeANFUM9mgSy/70TFmyiPuiqfr18A2R7GvLbAyykr1y4WpoKuA12Idk2d5BM3v43AjcGoqVIZmiIqMFB/5wW9hLyyxYGtAanoCbxg2XX5Bm26xn0zSd0jIqlLlp3zkw7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406228; c=relaxed/simple;
	bh=JvPOQX1m6VS2TnDTVCWVo4cYrpLbtbm0fzT/89T9mV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oRCNUl/Bq201bYdChJsrM62N6ePs38wp0Fyf4ItUusZd6C1k/BwSK3LTGdYh8Do91m4GTyL0GFP6N6EXYmk7tNim7hefdyOySd/trOCGCj0WnwCgtOHiZHzfovW2npZUekHsGZI+B02/l4iITc9vd/i+RSVdXb+A6FSbmhlcIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhwIp13G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C11FC32782;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713406228;
	bh=JvPOQX1m6VS2TnDTVCWVo4cYrpLbtbm0fzT/89T9mV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XhwIp13GS9iJfeIX3StUHnCkvbM709wrE7EVVPGakGd1/Nyu0XXIxBRu6dN6h0JGB
	 nhCE25VSANdmOIfd1BADV0o6UTgN+l7OaJymeatq4XLiKJMXcDNPat0ZeOAdP/xmGj
	 Zs9nFlBIa+oXMp/7HKMf+Ut55ezomdSXyytdU351np0YDJZmU/PZ0mCwW0gXAieHjz
	 sgUPPrXhKkmXvY/T9D2/39OabVc08mnMi31Uik7hUpuWBv2Cvu75bPkhbWUtrc6pa7
	 sUeZ4Sv3vAxmvDWKaW4nFadNCNXBGqFicqDLmPKfSFWHgGVSEuphx3FtbBWu4ql4Ji
	 SeyQk731JEexQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 396DAC43619;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix WED + wifi reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340622823.10413.6361491426499037138.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 02:10:28 +0000
References: <20240416082330.82564-1-nbd@nbd.name>
In-Reply-To: <20240416082330.82564-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sujuan.chen@mediatek.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 10:23:29 +0200 you wrote:
> The WLAN + WED reset sequence relies on being able to receive interrupts from
> the card, in order to synchronize individual steps with the firmware.
> When WED is stopped, leave interrupts running and rely on the driver turning
> off unwanted ones.
> WED DMA also needs to be disabled before resetting.
> 
> Fixes: f78cd9c783e0 ("net: ethernet: mtk_wed: update mtk_wed_stop")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix WED + wifi reset
    https://git.kernel.org/netdev/net/c/94667949ec3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



