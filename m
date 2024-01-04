Return-Path: <linux-kernel+bounces-16515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA70823F92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFEB2873BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69820DE8;
	Thu,  4 Jan 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDgha6Pp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578220DCE;
	Thu,  4 Jan 2024 10:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E481AC433C9;
	Thu,  4 Jan 2024 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704364825;
	bh=9lEo0svTc6y0qj85RnAyugiZBqNz40DLbwNc+Igp8QM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aDgha6PppseWM7vdQA1FIhpsPelQy3uwBf9z9BM/use8YtdGCLVWonXZFZ7ymtLDw
	 x7wtAfYsF6v27waVND+1DTHvSuxQiAhUmB5u8aICDCW0enKQS0CRb3xXYP01413uhh
	 VkCkKLw2ErsTlp7S5PZomgPzWF3VbrmPKH4+9D71E//hScqL/jq2t3/q/21z9pvgxi
	 9ePHRpPn+GbbFa8oFM5XUsX7VkxwFunEc5p6CJOumw3f+0at5WBMmmvI7mw52Oa+Jz
	 o/615BG+QU0KNen3Cot0arkffK3XMdhnADdcxXe7Cw0EYWErI6bKsj/nVyYvNrCmd9
	 05oXY6SyRZeSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB8E6C43168;
	Thu,  4 Jan 2024 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Re-enable MAC TX in otx2_stop processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436482482.2302.13087234357277390960.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 10:40:24 +0000
References: <20240102141400.9146-1-naveenm@marvell.com>
In-Reply-To: <20240102141400.9146-1-naveenm@marvell.com>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 2 Jan 2024 19:44:00 +0530 you wrote:
> During QoS scheduling testing with multiple strict priority flows, the
> netdev tx watchdog timeout routine is invoked when a low priority QoS
> queue doesn't get a chance to transmit the packets because other high
> priority flows are completely subscribing the transmit link. The netdev
> tx watchdog timeout routine will stop MAC RX and TX functionality in
> otx2_stop() routine before cleanup of HW TX queues which results in SMQ
> flush errors because the packets belonging to low priority queues will
> never gets flushed since MAC TX is disabled. This patch fixes the issue
> by re-enabling MAC TX to ensure the packets in HW pipeline gets flushed
> properly.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Re-enable MAC TX in otx2_stop processing
    https://git.kernel.org/netdev/net/c/818ed8933bd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



