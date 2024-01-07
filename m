Return-Path: <linux-kernel+bounces-18894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0978264BC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05B31F22B87
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0213AE0;
	Sun,  7 Jan 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktAQ79le"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB6134C6;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45017C433C8;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641424;
	bh=jkyJQWYGUp32JFxVMXWDRmLGafHoZX1LN1CePYraOyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ktAQ79lega1dwahq+Zg8Wqm6wZQdi8g6+1tNkuBdWTMne1u7GLuKzT+/B8NAqpmzU
	 BivAxfkOLApzLLpNBkrXkqRI4FNew6+6NY3qQvtSzULM5orSoiLYV52CcERgKWl9nV
	 BYVBFdZWIB6Ao5v6dzhROmruT8OaVXDeGv2NVvrGOj+fUJwPJ/yncraV+cpNVogcRt
	 nS/szy3PxHaYd6f6tPiHQz2sEszeX3QMfQjEtqdxbhbBkWtobbiLm65zB5QKu5pxKW
	 G8Xp6IKlgFdRTS6b+ccOFFPuOkx+DC0w3t5SZxUGo9VhHqCDw0RB19+wbvkVkttCFw
	 hke2dt6ZS/2rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27C4CC41606;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rxrpc: Fix skbuff cleanup of call's recvmsg_queue and
 rx_oos_queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464142415.16555.4432906949740717296.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:30:24 +0000
References: <1366725.1704474341@warthog.procyon.org.uk>
In-Reply-To: <1366725.1704474341@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 05 Jan 2024 17:05:41 +0000 you wrote:
> Fix rxrpc_cleanup_ring() to use rxrpc_purge_queue() rather than
> skb_queue_purge() so that the count of outstanding skbuffs is correctly
> updated when a failed call is cleaned up.
> 
> Without this rmmod may hang waiting for rxrpc_n_rx_skbs to become zero.
> 
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - rxrpc: Fix skbuff cleanup of call's recvmsg_queue and rx_oos_queue
    https://git.kernel.org/netdev/net/c/4fc68c4c1a11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



