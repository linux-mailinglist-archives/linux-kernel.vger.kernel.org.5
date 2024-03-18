Return-Path: <linux-kernel+bounces-106703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF5A87F22A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EA31C20E18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519B59B73;
	Mon, 18 Mar 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ6UiNf0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2958233;
	Mon, 18 Mar 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797428; cv=none; b=nHEviqa6ptqRQ0zGd1gwXoeNTfB84VsE0HUPWU+ejt80kkVCA0c0u0uTZ8r2D/QDcAJr0CDYjnw3eYdaGLKsbjYbCO7vPXVpP+o2b9nKFIt/7ADPEWnhN43NhA6NugMzzOdiBdiFCWW+X8BHD7BuMU3FydtBh7nPKVqSmxeN03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797428; c=relaxed/simple;
	bh=IQfDhlfXgR0M/YJ+genNdqvBkoyI4XQyUz4tYdGuLbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qJ8+Xf64DWcnuehXQelc2/84hHW9sWQHWEroJDU404qkTshHqfJ8WGpmJgI5keBui6wmUuzLokbdsLOOCYuBmKxMZGzo5x/Clbm0ykUJuK1v5O0NW+mwcCfrJLF+6d7/m5I5xGwVtAzFJLJ6xSobN3uoCA8Aa0QtnSCMF2NHDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ6UiNf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D717C433C7;
	Mon, 18 Mar 2024 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710797428;
	bh=IQfDhlfXgR0M/YJ+genNdqvBkoyI4XQyUz4tYdGuLbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HZ6UiNf06eWxfyjbW/dbD0mCoYbrtc8CEQdqotsIZg1rPamGZEWJSgiUY8iDg8Ipc
	 iOQp9jsSIvSKfHN3aSLZVfayfXkcXrVqDucLu1dkf5yeCs1eCnW+yexKCgNJQNrDdf
	 I/v5CgFITSDH4k87C/+tTf4T7jzXbk+NNGwV1ZqttnRRwxvlRo49/sA8HIfIO/TKA7
	 uUm72egu10qBnR6w5pehRMfQDYMAkMclvM7u89pSqVCjxS+SArR38rQ4dQKMxpVWEZ
	 5l+68AAuJSHscbhVFoGW86pz8UV+QxWK1nHDKD22Y/2STmvpTFTPor97i7NESPSTnS
	 g5PUKrRqniR6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 189021466CEB;
	Mon, 18 Mar 2024 21:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Remove arch_unprotect_bpf_trampoline()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171079742809.5361.11333101875277498978.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 21:30:28 +0000
References: <42c635bb54d3af91db0f9b85d724c7c290069f67.1710574353.git.christophe.leroy@csgroup.eu>
In-Reply-To: <42c635bb54d3af91db0f9b85d724c7c290069f67.1710574353.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, zlim.lnx@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 thinker.li@gmail.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 16 Mar 2024 08:35:40 +0100 you wrote:
> Last user of arch_unprotect_bpf_trampoline() was removed by
> commit 187e2af05abe ("bpf: struct_ops supports more than one page for
> trampolines.")
> 
> Remove arch_unprotect_bpf_trampoline()
> 
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: 187e2af05abe ("bpf: struct_ops supports more than one page for trampolines.")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Remove arch_unprotect_bpf_trampoline()
    https://git.kernel.org/bpf/bpf-next/c/e3362acd7967
  - [bpf-next,v4,2/2] bpf: Check return from set_memory_rox()
    https://git.kernel.org/bpf/bpf-next/c/c733239f8f53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



