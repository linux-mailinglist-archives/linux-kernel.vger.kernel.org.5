Return-Path: <linux-kernel+bounces-125364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A689249E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA6DB23F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83813BC02;
	Fri, 29 Mar 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX09Zwcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81A13B5B9;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741830; cv=none; b=dX7kFCCBNWbwrzBs0fj+QdKBTzCcU4HJIH5on3lPlOzxQ6XsDSWCImPLK/R4zZyUVnAfYWHUmGHa7SM5KMHhbxX8hdh1w1dD1oVL/cq6GYHcbSf1UKV/F1Vi4gBeXYKxCGiotQEZ9NkGmiIe/wjeV9dg9qLDdeUk5Cgc/dWtj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741830; c=relaxed/simple;
	bh=dJKmBP0RTzq/mGTGVkwydr9iJed+8Qhc2y6yKdYJ5VI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KP4VMWpq2O93R/JPwS+55gqGSsrSSnhjU6fT163AoPFwMMgJkiH2WdROG8mcWsTrAjwWCJgWkS94BCCi3wyFglVM8J4i7IMRwRaZF9gCgf/yXuuNcVS16XMRGEKMDEmmvhMfQl1Sn5k5TPXdF7gptUqKJKn7MJZ32k0Z4qxPAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX09Zwcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A427AC43390;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741829;
	bh=dJKmBP0RTzq/mGTGVkwydr9iJed+8Qhc2y6yKdYJ5VI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lX09ZwcnDVgab6/SRvvbdE2NZAt7Zw5SrT7W6J32tdSd9EvboEYTnK1l+gGNEmsNV
	 3rAVSdBo447Hbd2+ZV3Nj7lw5sccbMLKQ18YAh+pSfLgoilaDX7BCWVAh9Y5VmZRcC
	 ol17zM7A6fv9mnvDhsK3vAkDFpFMyCURiGfnG2Zfjwifvkmr3jQ1c5Uy4+eV0KUj1M
	 0/MZ3gYyzfZ0AG6B4VfR+srpq2iR3bvo+I20xRarYbkXcEEIJTty8s7CqhY5UiBls6
	 rAVN+1zqh37j7D2WCpFLhXzR1Tv97GTXwc74V7JQEbV9/gAH0A/Ld71mGlCXkRYVOT
	 d+KCNhgMoFUgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AB80D84BAF;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] octeontx2-pf: remove unused variables req_hdr and
 rsp_hdr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174182963.31276.10050708844346806505.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:50:29 +0000
References: <20240328020723.4071539-1-suhui@nfschina.com>
In-Reply-To: <20240328020723.4071539-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 dan.carpenter@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 10:07:24 +0800 you wrote:
> Clang static checker(scan-buid):
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:503:2: warning:
> Value stored to 'rsp_hdr' is never read [deadcode.DeadStores]
> 
> Remove these unused variables to save some space.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] octeontx2-pf: remove unused variables req_hdr and rsp_hdr
    https://git.kernel.org/netdev/net-next/c/1ab6fe64d220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



