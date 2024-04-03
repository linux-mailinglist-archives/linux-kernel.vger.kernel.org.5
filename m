Return-Path: <linux-kernel+bounces-128982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845918962AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEF8B24C58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E101B977;
	Wed,  3 Apr 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km00qrxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002931FA4;
	Wed,  3 Apr 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112628; cv=none; b=kz2UEFQclwoJtxPlYD2meF9Z7YIJU/Hv63aFQKcpEXA9+2N7RBbwmK90v4W+8LSke5chQ1CBIsa7O3PzbLrtYL7YA/4OYYx3B2YQMilaASBfWx6HywtqWq+RhM7U+ic8gkAlOGimRLPgwFZtrFQAscKgXd6AESc4OYEyQYvD+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112628; c=relaxed/simple;
	bh=f05nhyVxom4c3oNnPKPHNMMwzP3QW+cG+v9T/sJ3TSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gh9Vl1/R97MxuaAYgzhbEK1ZR6Cis766pfqeZ9+iciiBBIwK9rFAxsiZc6yGBcOZQQlpJabyhLemvF+OIlUzL9xzkYNKuhmcc9PaEQRfxSSzCSGCG4vkUIB7y0enCqKKZW3JHILF1XXCSWZKj5vlq3M5w3gVbWma2Xj1Y4rbfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km00qrxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66D33C43390;
	Wed,  3 Apr 2024 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712112627;
	bh=f05nhyVxom4c3oNnPKPHNMMwzP3QW+cG+v9T/sJ3TSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=km00qrxyklvrfhhZOX3puhKkkgNpADn48fXI40SXsMnR3bSo6e+azXJvbsbGY4L9Y
	 DCjcsyCmlTZTwjzgnyz1hO6vlBgwoy75rGTwAnW6ha2ZPj4ABKyYyJBDoDXn7ji8md
	 JJiOuQ7/68o3CIRbfczvUtCtezNFu4AiUogj+xCYOERHw44kmYU2Ai+n9IJe85AT60
	 Jk6PHdQKHnmXt3Wu59DfFLDvmBztl/MoU3yozYpwGb1343n4glwxSVsMl5yvQg3qkX
	 Mbpd3JntfK0o9c8MJy2uaDC3RPqqShANZsbL4x8KpdRLq+F5X1NOfQSF+J5wSNkWMR
	 hd81W9aI9mi6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 563E2C4314C;
	Wed,  3 Apr 2024 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf,arm64: Add support for BPF Arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171211262734.19782.16657379775457927480.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 02:50:27 +0000
References: <20240325150716.4387-1-puranjay12@gmail.com>
In-Reply-To: <20240325150716.4387-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 zlim.lnx@gmail.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 25 Mar 2024 15:07:14 +0000 you wrote:
> Changes in V4
> V3: https://lore.kernel.org/bpf/20240323103057.26499-1-puranjay12@gmail.com/
> - Use more descriptive variable names.
> - Use insn_is_cast_user() helper.
> 
> Changes in V3
> V2: https://lore.kernel.org/bpf/20240321153102.103832-1-puranjay12@gmail.com/
> - Optimize bpf_addr_space_cast as suggested by Xu Kuohai
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
    https://git.kernel.org/bpf/bpf-next/c/339af577ec05
  - [bpf-next,v4,2/2] bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
    https://git.kernel.org/bpf/bpf-next/c/4dd31243e308

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



