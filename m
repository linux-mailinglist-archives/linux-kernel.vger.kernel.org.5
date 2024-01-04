Return-Path: <linux-kernel+bounces-16166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0D823A03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08671F24B08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F344C8E;
	Thu,  4 Jan 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8xuCopu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838292103;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1521AC433B6;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330035;
	bh=dLPo4DMtLf+Mc+SXT44xTlOO43MfxyAbxaSAlmDx238=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8xuCopuY0JrWLanvKFWo5jwYmf247l/1pMYxFwp4Dl/0pAgxhsJYFtBGiTMegfS5
	 py3kMvacrCntnVyY1LI/gpZI/GQfRTRrNCNy0nQwvPGoHYvQYeGf6Kw6Vlr4T2Huya
	 Dv0m5rT+1wAfZFypVx19weYjZGxzQrN/8bkKKX6XEmO5lJzixClU630pT9YRa7r5SW
	 29OlLBu6GFZQ7I1BltFlJihpfTaxDDKjuNqCjXS6QkP15Ske9CyIpfkCwrqt1PnKb3
	 UXX1NrGR9zA0leCXdQAbGCrD/7XRO4UnNYQQtNqeh37GOhJooT2HUDNxsaRSc2iJ8S
	 HHbbfGYU+qkjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1D2DC00446;
	Thu,  4 Jan 2024 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003498.5757.16525798721106023032.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:34 +0000
References: <20231227070227.10527-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20231227070227.10527-1-dinghao.liu@zju.edu.cn>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ron.mercer@qlogic.com, jeff@garzik.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Dec 2023 15:02:27 +0800 you wrote:
> When dma_alloc_coherent() fails, we should free qdev->lrg_buf
> to prevent potential memleak.
> 
> Fixes: 1357bfcf7106 ("qla3xxx: Dynamically size the rx buffer queue based on the MTU.")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/net/ethernet/qlogic/qla3xxx.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues
    https://git.kernel.org/netdev/net/c/89f45c30172c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



