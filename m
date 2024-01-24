Return-Path: <linux-kernel+bounces-36276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A7839E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A02C1C28925
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022B46BF;
	Wed, 24 Jan 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLYn0IaI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2831FDC;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059831; cv=none; b=MOGZxCXGhCh+vt2yDk/bW7453Qg7Yzj8B5t4bHt0NOC9Bcrlt+cMEFfJjatXnOs+k/TvXjhq3L4I9/SfgRcRL+tiCK/lLOh2BUuayxJRSkVm4VV7pAdObw2T1RhLg5aS85IvBuf3pwn+3X29WU4itnLAI1hBLSjEApMLLmMFuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059831; c=relaxed/simple;
	bh=/YTiKICEiif5J5MnubFuC5MERjQmTOqozRhQB9s5e6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qMG07M21+Gw6zW9phY34zE2o6CpfZJDi0mFiSetyuQPeeuvhkSQkmfAl9oaN16jSE+Zk0O8Rza4a0ilwTLVvutY+CgAkF8ks0n3CpBAUEZd9ctjKDl1xUFZDVlpybf9NNWzR9+fuNsClz63/OaQw0TLJwryY8wYscJ89Z1dhwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLYn0IaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44FB6C433C7;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706059831;
	bh=/YTiKICEiif5J5MnubFuC5MERjQmTOqozRhQB9s5e6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLYn0IaIqgGJrDufCZ4KDOrSC3iDPwbD9ScobxhctSiX8ej49rZxvrtR4q27BO13x
	 3IQi9Gl+Ush5fcL1g+csmJX0vtcpYhdrRikPSYDA7T+EXC6uIKZFdLtJEDHt05xnx5
	 oeQCRLWJ4NMCOvyt2pKu82AllVVnMHALghBfTXT8hkRzMDkwoi3G3rLaUGHnxduR+D
	 vB0AFkTH5Zecg8V2VLJHiHaZBeABHlO6f8S8zZRopZzePDRAVhvG4b7LXFqnYdwEb9
	 bC+FNdP3u3FtGVzEKIfwo6CdyCDu5JfuX5F1AEiN9T6zf6r2pQMBKWtXY7TxEh51O1
	 eeAAwDj7YuRTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 333CADFF767;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next 1/2] net/ipv6: Remove unnecessary pr_debug()
 logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605983120.14933.12714749424058391282.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 01:30:31 +0000
References: <20240122181955.2391676-1-leitao@debian.org>
In-Reply-To: <20240122181955.2391676-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: dsahern@kernel.org, weiwan@google.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, leit@meta.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 10:19:54 -0800 you wrote:
> In the ipv6 system, we have some logs basically dumping the name of the
> function that is being called. This is not ideal, since ftrace give us
> "for free". Moreover, checkpatch is not happy when touching that code:
> 
> 	WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Remove debug functions that only print the current function name.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,1/2] net/ipv6: Remove unnecessary pr_debug() logs
    https://git.kernel.org/netdev/net-next/c/a6348a7104e0
  - [RESEND,net-next,2/2] net/ipv6: resolve warning in ip6_fib.c
    https://git.kernel.org/netdev/net-next/c/20df28fb5bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



