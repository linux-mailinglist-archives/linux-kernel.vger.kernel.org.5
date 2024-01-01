Return-Path: <linux-kernel+bounces-13879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDE82141F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E09328189A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D5263C3;
	Mon,  1 Jan 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRU4HqS/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B67610B;
	Mon,  1 Jan 2024 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39470C433C9;
	Mon,  1 Jan 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704120624;
	bh=84zVv7Gqf5j87UUvjryQ5sM5uo0HSoFjURrt5TZBUPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KRU4HqS/leMTRc1TNTj8zOUSMEil6RRky/UPJ+vB/Zea6PKc1nD+OfCtaPwurLCC2
	 5kWnZq859eZ+5Lq1uWdyBm0vxD2Jufc4eV5bOsgDkzxdrg/cxxp/0ZBafkdmqZZKTM
	 uuRFNxJYWbIu8eD0O4AfuF1MvlY3ZmDv+mum+1soP9iXf2uxZbsCnreyvTDfZuEvVB
	 iPkrMi6M5TZMOl8+/oWzP4EtfMwDV78tCbE3BKcIxnCkQ6pP+GwF7OxH3vMfkqgoc4
	 5TpYdSqAIQ8Xt0cCGwDVlDk5vvfijbcnEO3sLpnWVZL6b6fmy5S5coJJZrjTx6E3I1
	 Wpiq55BW907hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 204E1DCB6CE;
	Mon,  1 Jan 2024 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tcp_sigpool: Use kref_get_unless_zero()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170412062412.26004.3396143166150821142.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 14:50:24 +0000
References: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>
In-Reply-To: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, 0x7f454c46@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 01:13:59 +0000 you wrote:
> The freeing and re-allocation of algorithm are protected by cpool_mutex,
> so it doesn't fix an actual use-after-free, but avoids a deserved
> refcount_warn_saturate() warning.
> 
> A trivial fix for the racy behavior.
> 
> Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> [...]

Here is the summary with links:
  - net/tcp_sigpool: Use kref_get_unless_zero()
    https://git.kernel.org/netdev/net/c/b901a4e27694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



