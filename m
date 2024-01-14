Return-Path: <linux-kernel+bounces-25514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89582D17B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FD91C20C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D0525B;
	Sun, 14 Jan 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDqC6zAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F795231;
	Sun, 14 Jan 2024 16:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E975C43390;
	Sun, 14 Jan 2024 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705251024;
	bh=aajpuL0N1FoVPG1DOrmuwPFeTeocdCnnlU8c+Mc11tk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDqC6zAins4V9gxo86MlHsipGU6CoRoDy1yYSlZ4/rFYisLKf4/vww8JN3UOvNdk8
	 HLOoq+WZCKm1lpmA27gvmPqJVS5C6Rx73ydDaP2kKaYZRf7xm5H+HoRNp3Iug4zpiT
	 obQLLLW2YoPukwPQDSsAa80utgQmTSPE3oSMjpQzra2615D0WXCZ0evFprL6oMRTDO
	 P34rBZDxJCRN/HZnKjWyTGXXpL/pc9Y7A9a/3wxAO6nJdEBDI6BIc1TIZG2pTdn0TJ
	 xPc0MyXgeQTHahr6CiMjLeqXAZLe02Dy/C1WSpoJHz7sdiP40BhKiDHFXmPA9VucxR
	 3SZXJFxIWyCwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1571ED8C96D;
	Sun, 14 Jan 2024 16:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ravb: Fix dma_addr_t truncation in error case
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170525102408.11320.1615500877884972571.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jan 2024 16:50:24 +0000
References: <20240113042221.480650-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20240113042221.480650-1-nikita.yoush@cogentembedded.com>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 s.shtylyov@omp.ru, claudiu.beznea.uj@bp.renesas.com,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
 u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 13 Jan 2024 10:22:21 +0600 you wrote:
> In ravb_start_xmit(), ravb driver uses u32 variable to store result of
> dma_map_single() call. Since ravb hardware has 32-bit address fields in
> descriptors, this works properly when mapping is successful - it is
> platform's job to provide mapping addresses that fit into hardware
> limitations.
> 
> However, in failure case dma_map_single() returns DMA_MAPPING_ERROR
> constant that is 64-bit when dma_addr_t is 64-bit. Storing this constant
> in u32 leads to truncation, and further call to dma_mapping_error()
> fails to notice the error.
> 
> [...]

Here is the summary with links:
  - net: ravb: Fix dma_addr_t truncation in error case
    https://git.kernel.org/netdev/net/c/e327b2372bc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



