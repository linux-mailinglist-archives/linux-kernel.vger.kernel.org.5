Return-Path: <linux-kernel+bounces-92276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F5871DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915311C236D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04C5B666;
	Tue,  5 Mar 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilYCxJ2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A359153;
	Tue,  5 Mar 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638229; cv=none; b=A3eFDRVhzn83BixyqDS75Pf0cub+3PqhvwUjjrIUsce8B7ZGB5Six6PSwk+SjsftZS1snnHq876FuuIi/sDil3eJMI4s6FA3B/1pqyIxrgdaddxkYC/TonuaA90lO9LIiM6Omc3LTjW4GeLRwk3He+2QVPzo4u/hwJYymLJIB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638229; c=relaxed/simple;
	bh=EpD9Di9FVmc5SbLTT9/ApRiFR+/80ke9uLaAp5KtFRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHp036H/Q3g/r/CLeluyQ+Cm4xjVfZWOJbiA9eojPWWM66LHkzhaZHB+A0uiJ4BvlHLPZ4IPNRpIBDRGHTwQ3sHV0CguGu7PWuvJH0wbmbfIs94r7N1Gsowzd+E8tvHYJrzUQWiWBmi8Ov+uECDBCGF7r+jURGJDwfUznJf/mK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilYCxJ2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E37DC43390;
	Tue,  5 Mar 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709638229;
	bh=EpD9Di9FVmc5SbLTT9/ApRiFR+/80ke9uLaAp5KtFRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ilYCxJ2A1C1M+7cJ95lI6fiGam9N7P2kHMcDlcJgmFgXs5tgq3hufzZTOINWuJpfV
	 KR/7erFe1ku/Dw2j8Hbnwzjgc3qaT1KxrY9mZsZwzZ+M2moPpc0dJ271hRhh0CKY5F
	 t3QFszw6cGtEJz5jeHVAgRvc3lfJYWme9NWLXubifgFh0k+Qtac775GGEK+mSwpKTw
	 6lBX29dE6bFb8zAkU7Ws+xNmmdTBIcRzz6xpjewq6y3iGPnOIc9mg8TjyPHqoYzlOC
	 VhDCNDR1cs85GNNLN7ObyEm8r/SHb8x0vOQ33Ofe1ZXUjVKatdf2vayz2NCZNTfW5X
	 R0XfTXI/3o3yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0044BC3274B;
	Tue,  5 Mar 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] remove page frag implementation in vhost_net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170963822899.25227.16966361429378501531.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 11:30:28 +0000
References: <20240228093013.8263-1-linyunsheng@huawei.com>
In-Reply-To: <20240228093013.8263-1-linyunsheng@huawei.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Feb 2024 17:30:07 +0800 you wrote:
> Currently there are three implementations for page frag:
> 
> 1. mm/page_alloc.c: net stack seems to be using it in the
>    rx part with 'struct page_frag_cache' and the main API
>    being page_frag_alloc_align().
> 2. net/core/sock.c: net stack seems to be using it in the
>    tx part with 'struct page_frag' and the main API being
>    skb_page_frag_refill().
> 3. drivers/vhost/net.c: vhost seems to be using it to build
>    xdp frame, and it's implementation seems to be a mix of
>    the above two.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] mm/page_alloc: modify page_frag_alloc_align() to accept align as an argument
    https://git.kernel.org/netdev/net-next/c/411c5f36805c
  - [net-next,v6,2/5] page_frag: unify gfp bits for order 3 page allocation
    https://git.kernel.org/netdev/net-next/c/4bc0d63a2395
  - [net-next,v6,3/5] net: introduce page_frag_cache_drain()
    https://git.kernel.org/netdev/net-next/c/a0727489ac22
  - [net-next,v6,4/5] vhost/net: remove vhost_net_page_frag_refill()
    https://git.kernel.org/netdev/net-next/c/4051bd8129ac
  - [net-next,v6,5/5] tools: virtio: introduce vhost_net_test
    https://git.kernel.org/netdev/net-next/c/c5d3705cfd93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



