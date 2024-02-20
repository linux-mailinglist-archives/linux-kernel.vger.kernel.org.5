Return-Path: <linux-kernel+bounces-72584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE585B58F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420731C22615
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661855D488;
	Tue, 20 Feb 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZorPSc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818A5D462;
	Tue, 20 Feb 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418428; cv=none; b=gS5EHutCzGOr++CRWIZ6Xnhl0t0H5RREdUHmHgAslz/R26OTHgazboFHd7coCEDa3w2R8VeEaFHrSrUH2gfdKuzVs48CJcu2YDImbVAfjKVzbgHIu/qxFyuhJt20L0uZvlByRgqs3x+v95+hZKv8O8liBmnO61sj6XK49uenlsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418428; c=relaxed/simple;
	bh=HLOlmpHG1kZkcB4qdxThMT87TdWuTnbWHGjkYOlMYAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6VhJKQQn1mJE0R2FNLNZxCtLIsegdabg3XxL7Ow2wmBeEGQM7jOl2uwclzKSO2gbWUCyVLv2443GvOgTpD+5IIti93n2Mco9xcMOFRJRlVQERkeqbVXMh3+YYMfM9A3GI7NMKVfWoe6d5LdFsJj6Zg043+rIRfT30UjNmmY8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZorPSc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 292AEC43390;
	Tue, 20 Feb 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418428;
	bh=HLOlmpHG1kZkcB4qdxThMT87TdWuTnbWHGjkYOlMYAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kZorPSc3doIkz9twbLj8iD5DqotbpJrRJ4CImKdbZN1Km1bH39bb2ZeX0eDOg+K4H
	 8ISLG/j0JuCWLz/gblaZ3HnEXFu5crFpM6TdwRJNA2P9qP34HNMD4e1ykgArQaAlmt
	 4cxkimRZgW/kwx9JHGy01OJiykETEQiUqOVo9JvEgPA5bqyTEM/4IgD1nAz7uDDGcG
	 XtvfZJK5BgGaFqjo7a+J+qiqFcVSKKG/YbhaedcTx/pdUq60MzuxW/AcWt2d+OJ2Jg
	 rb3KJQ5U32bd71E252ALN7wWZCMMIQC2oB42QnNA5+DnpMZ/FqCrgHCEgaGzCQ3+cn
	 8kLPhU3+L109Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 111CAC04E32;
	Tue, 20 Feb 2024 08:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/2] Abstract page from net stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170841842806.28167.12571319635937974620.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 08:40:28 +0000
References: <20240214223405.1972973-1-almasrymina@google.com>
In-Reply-To: <20240214223405.1972973-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jgg@nvidia.com,
 christian.koenig@amd.com, shakeelb@google.com, linyunsheng@huawei.com,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Feb 2024 14:34:01 -0800 you wrote:
> Changes in v8:
> - Moved back skb_add_rx_frag_netmem to .c file (Paolo).
> - Applied Paolo's Acked-by.
> 
> -----------
> 
> Changes in v7;
> - Addressed comments from Paolo.
>   - Moved skb_add_rx_frag* to header file.
>   - Moved kcmsock.c check.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/2] net: introduce abstraction for network memory
    https://git.kernel.org/netdev/net-next/c/18ddbf5cf0e7
  - [net-next,v8,2/2] net: add netmem to skb_frag_t
    https://git.kernel.org/netdev/net-next/c/21d2e6737c97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



