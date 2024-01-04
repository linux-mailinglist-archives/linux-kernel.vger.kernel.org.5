Return-Path: <linux-kernel+bounces-16197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD3823A88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FB3B21A1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C35240;
	Thu,  4 Jan 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSyFXI9I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5246B4;
	Thu,  4 Jan 2024 02:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3E9DC433CD;
	Thu,  4 Jan 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704334230;
	bh=vEh0ppwXk6DImNjbRFSM5XNCTJbC2PA2Ng/B68r4uX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oSyFXI9IL6J8PLj8akvI6nWxYvGeowKIFeGlBmqaeoyXIbZVlTR1/XuG+yqI+BNT0
	 dmzyb0SSzUKzZqgJBRVYoyl8CoNjRUyeW729pGPBqINwNO5MxXzkDf6TaoOGDix7aR
	 Dzq39ceuFJyTo5wzJQj/WW6MMmS/xXxvDKth+CAZ+zsLDPzI1taJ7LBzxWK5nzMeJm
	 zp03QorJx3udRU/ePF4nr7Mx6VQWgi6s1CNBPQeBZ9Sg1gelPwahijJF8GxatsUyDl
	 +aTAG64cxJauyJZioFQ88AI1jqwtGVVYxE2lyeT3Xec1jixq020cXzdGhOuvhXxqL2
	 bKcNLlP0RhriA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBE01DCB6D8;
	Thu,  4 Jan 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix max NPC MCAM entry check while
 validating ref_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433422983.9915.10959654154373976341.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 02:10:29 +0000
References: <20240101145042.419697-1-sumang@marvell.com>
In-Reply-To: <20240101145042.419697-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Jan 2024 20:20:42 +0530 you wrote:
> As of today, the last MCAM entry was not getting allocated because of
> a <= check with the max_bmap count. This patch modifies that and if the
> requested entry is greater than the available entries then set it to the
> max value.
> 
> Fixes: f92749586176 ("octeontx2-af: NPC MCAM entry alloc/free support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry
    https://git.kernel.org/netdev/net-next/c/4ebb1f95e0c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



