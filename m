Return-Path: <linux-kernel+bounces-131648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C10898A64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA5C1F26F03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EC1C2A1;
	Thu,  4 Apr 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPMJDeX9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6311718;
	Thu,  4 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242228; cv=none; b=auFQDGeGSmGRZ+plQ2SHx0rdHo4M8j+VuzsMKD53tffTD8Mb5pfEr6LbqI8SZ6mR4kTcvzzrtMuS6mXbDEr9IVjieCe9KWy46iYq49XKEoT+w7wov81t8tQDtQ9ii2REPvZukDd06iyb8zPmMpGgbJQJ4yJmkGGeMimcwLTkcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242228; c=relaxed/simple;
	bh=ku2YBuJik1s7SEiP8w3doooX/ZXddO29iUvYxp6Frm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FowwbCL7I6ri7ff/whX/ojaXhjmCaZ/TNSKLsQJRsciafL5ULWjelmyBY8AeZAf7xanL5ZhmBDWy1Vbzcxoes8zGGL58RI/CuQa+qPhpiMoYcIYx1v36psHDgCD/IdqcoK+phEPbErToZ3ZMy7O4Of6AfUlBWU6a2NyEYnWIxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPMJDeX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C071C43390;
	Thu,  4 Apr 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242228;
	bh=ku2YBuJik1s7SEiP8w3doooX/ZXddO29iUvYxp6Frm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPMJDeX9sGvtjPadXq7idWRrp18Bxa/O9lJLCNfNttFl6kNJ/Rxel6WpRI+UUOLGR
	 3BNc1+GEIhmovtwQXIP9jT+yuLPhBP2LDA5ZT6pq3z+cPxWiFqKYou01YVY9JrFkjK
	 jv+NuohscEc4Y0rggb7V3rAZNW2pQyZJlxS/xQ6Z6qeRDV3xLfnVWxgXDoxUS3L0mG
	 D5X33u0lPsTldX2FTmciZbxtRAf6dRs+pF0QhnizeY7gJ3Hoqvi7Ka74j0Lb5ib78D
	 6kQyBH4pka0gDPdFBmN9/cPnEkSWbhpaWPr92+PhNULdHKFwps1Fp0yy2fJXk+L3Mr
	 YO8a+BLw0bQ9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0622AD9A150;
	Thu,  4 Apr 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf,riscv: Add support for BPF Arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171224222802.6630.17532386539061151793.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 14:50:28 +0000
References: <20240404114203.105970-1-puranjay12@gmail.com>
In-Reply-To: <20240404114203.105970-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 luke.r.nels@gmail.com, xi.wang@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 pulehui@huaweicloud.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Apr 2024 11:42:01 +0000 you wrote:
> Changes in V4:
> V3: https://lore.kernel.org/all/20240326224943.86912-1-puranjay12@gmail.com/
> - Fix some style issues.
> - Add Tested-by: and Reviewed-by: tags by Pu Lehui and Björn
> 
> Changes in V3
> V2: https://lore.kernel.org/bpf/20240325155434.65589-1-puranjay12@gmail.com/
> - Use REG_DONT_CLEAR_MARKER in place of DONT_CLEAR as the name.
> - Use RV_REG_ZERO for the above as it is guaranteed to be never used in as
>   dst/src register in BPF LDX/STX/ST instructions.
> - Use #define RV_REG_ARENA for RV_REG_S7
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf,riscv: Implement PROBE_MEM32 pseudo instructions
    https://git.kernel.org/bpf/bpf-next/c/633a6e01d1a2
  - [bpf-next,v4,2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
    https://git.kernel.org/bpf/bpf-next/c/21ab0b6d0cfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



