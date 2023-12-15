Return-Path: <linux-kernel+bounces-752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9481458C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2099B1C23028
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A724A0F;
	Fri, 15 Dec 2023 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlDKy0Qx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59DB208A0;
	Fri, 15 Dec 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D8FC433C9;
	Fri, 15 Dec 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702636224;
	bh=03F3Xbn+qBzY9EYDhrw3WRnqK6/tNhnCJJHn+Zgaprs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dlDKy0QxHrho1xQ73unyksu7JhKeAw4a4UnvfP4afjyeiiGAoT4H6sItvm1s/ULOc
	 Gj2m9tqPAITy+h8jpjWDLaHPqBEKye1hzJ2TrWsSZ85sp1UKtR2ocMpx+aTlyajYuF
	 /r/j43TKyzT/sERM5t1/Q0KjN+OEynI0GKxvSP5sE3MjggE2GHpfN9xHhrZVFd5QEV
	 fo2DxkG4PSiRWXguxyFBxcDTF3H9bwceaA6hKCjkrySAjHiznwAvHWzvdw8ZAkx0/H
	 o62OigqNs+h1Hp/8ZrOVkr3bJOLX2YjgDta9mlvkIIN8lzOx4Rxm4hJf73eD+rjE2g
	 6FSGQ2Xq2jElQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35901DD4EF5;
	Fri, 15 Dec 2023 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Fix graceful exit during PFC configuration
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263622421.29656.18263550245322394466.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:30:24 +0000
References: <20231213181044.103943-1-sumang@marvell.com>
In-Reply-To: <20231213181044.103943-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Dec 2023 23:40:44 +0530 you wrote:
> During PFC configuration failure the code was not handling a graceful
> exit. This patch fixes the same and add proper code for a graceful exit.
> 
> Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net] octeontx2-pf: Fix graceful exit during PFC configuration failure
    https://git.kernel.org/netdev/net/c/8c97ab5448f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



