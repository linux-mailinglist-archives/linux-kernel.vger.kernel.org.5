Return-Path: <linux-kernel+bounces-135191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C289BC81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE38283484
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF752F63;
	Mon,  8 Apr 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGHnJOYm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F04C634;
	Mon,  8 Apr 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570458; cv=none; b=HwKr8NVT/apsZkEjEDsZ2GWBlC3Vyftf6u6PjgDntYSE9rCf7H2wB5F120EEiWV/UwoAUI58WxheFNVIHRoWGZruk7McUm9wdI/w/tqdreeg1H+jWNtE6hqjv0w7D0n1cOCXSJfw0U33k6Dfu7RKjpRdp2VjwXgY/c92mwzIl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570458; c=relaxed/simple;
	bh=TLOEjCRjMbgRwjbjZYTWxpaCO+QnNcZSzSNzdLcXctE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKI7Ou1wn7Q5zce8nVa4ym9spvIyqhXrs8HWrx4eo5XFRJeCQTwCPqzDMc4/1i5ihd8iRPfMwySen7oVxzKdp6uDZbC7eYlQNT7lzpMO/B8m3OPZTaNt+Cp/4NPy1N10qXLgTspD645Pl0BYkgyX5iZqVMFZHBr7F0szDJWAvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGHnJOYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C5EDC433C7;
	Mon,  8 Apr 2024 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712570457;
	bh=TLOEjCRjMbgRwjbjZYTWxpaCO+QnNcZSzSNzdLcXctE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DGHnJOYmbRNcx1NwWFQc8srKOO7B59ZL1/SsV25Iby2guexofnXrCmy+axg6fasr1
	 APBFV/fe5s1m9r8TwsMXWLvBNvvuZLElDrb3ftgqsNVqTxHgow8mPjtvabvdOdoGE9
	 xZqXWbGC7ASeRjol8Dno0ySPr+GWBdAhpJ9W3GrYrpJdLqTiSCCOg5mDP8MY/H1UR/
	 GhqX+asTPAjl+hBLWwYX3Wn9CuR841MRzAji3ruOmYRw0AUzPCG0f41xcNLBJ3ssw9
	 /fPZT8eRBQJTbGAYLYxcYbGVSYJVQcwBXVAAMVFgX3IfuhTUA6sVmm7M2piTPOM1+a
	 5bNkhjBj+NkRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 625A6C54BD3;
	Mon,  8 Apr 2024 10:00:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] ip6_vti: Do not use custom stat allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257045739.21896.1092684472500492510.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:00:57 +0000
References: <20240404125254.2978650-1-leitao@debian.org>
In-Reply-To: <20240404125254.2978650-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 05:52:51 -0700 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ip6_vti: Do not use custom stat allocator
    https://git.kernel.org/netdev/net-next/c/a9b2d55a8f1e
  - [net-next,2/2] ip6_vti: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/b2c919c108ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



