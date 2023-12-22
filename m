Return-Path: <linux-kernel+bounces-10114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DD81D067
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0276D1C22604
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E136093;
	Fri, 22 Dec 2023 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwGFVbJw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2435EFB;
	Fri, 22 Dec 2023 23:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31E3BC433C8;
	Fri, 22 Dec 2023 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703287231;
	bh=Rv7TpBQ+VZpCOyGSd0PF8/eC1dZcwVwBZzF4+pry1nU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JwGFVbJw0uO5BPM0Lrhm5f7hWwGYl72rHB2KjKBjCku71JIeP5s+57b9EL8RNZt3+
	 9I3avLrHihHdPRCMvuGBjUtkmn+t54FL1w0urRyW8TNKOc1nItsVqvBapOhGj7dHF6
	 l/anItAEekIrEwaOZz3IX8jjusj/w1xFCp2lGrOWvObWi7NVf770ZZNmg7KjkO6mOF
	 epfWovjQIaBSGJH8et756HRQJUbtToo2hh5bRkSmitNzuP3tmMZIELs85ti8hW3sIa
	 OitRX5j9v7W2VHfW7t4iTdv/BStgzbb5QafGFt2SnbcNhsRz2u0opvohbhW6Uh/kOA
	 H0ri1i1W9urLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E037C41620;
	Fri, 22 Dec 2023 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tipc: Remove some excess struct member documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170328723111.4715.923122968057383969.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 23:20:31 +0000
References: <878r5rjasi.fsf@meer.lwn.net>
In-Reply-To: <878r5rjasi.fsf@meer.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Dec 2023 17:28:13 -0700 you wrote:
> Remove documentation for nonexistent struct members, addressing these
> warnings:
> 
>   ./net/tipc/link.c:228: warning: Excess struct member 'media_addr' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'timer' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'refcnt' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'proto_msg' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'pmsg' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'backlog_limit' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'exp_msg_count' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'reset_rcv_checkpt' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'transmitq' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'snt_nxt' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'deferred_queue' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'unacked_window' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'next_out' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'long_msg_seq_no' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'bc_rcvr' description in 'tipc_link'
> 
> [...]

Here is the summary with links:
  - tipc: Remove some excess struct member documentation
    https://git.kernel.org/netdev/net-next/c/45248f290229

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



