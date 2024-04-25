Return-Path: <linux-kernel+bounces-158512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450E8B2189
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF3EB235F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EA12BF38;
	Thu, 25 Apr 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmSj4y3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711612AAC5;
	Thu, 25 Apr 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047629; cv=none; b=ImRdus8Efex8fx5luMbz8HRie3DzHcwErJUjQZgkeFbmnAFZQU1vfclXqx4LCG7XjqozXsFo2RqOJKR4tU02/T0nSkjjCyKfZyq3r80XCW4gIandnFXJX7Hno0A5j+olcGoOvpJb9MNCRny2K88S5XkDupwkG6oar22q7jOygxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047629; c=relaxed/simple;
	bh=l1sxznDkPi1u8WbFQi2cdXM6MGe1jOyjijxGtYed49M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uUlSE/MuNnJLeWchgCWDwbEKgckvhhqlQ1Ps31onlvPAoXEy0lsnG9KXtHLJufMpj8cZbtWD10faSER3H/zUW99k7tASu2sxVTHG31jYilBHrehj3FDqrMNIt5lxTIxbeK0Bvcrdylpl23RGYm8IW6qAIL4DbIYzatcuBkOoiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmSj4y3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B2CFC113CE;
	Thu, 25 Apr 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714047628;
	bh=l1sxznDkPi1u8WbFQi2cdXM6MGe1jOyjijxGtYed49M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OmSj4y3prXyf1ODlC+95tfDwt/d55zci2cyz92vZpvIdqSEfwPqT9Kgs8nPajSYxI
	 XsoyMxdqz4AAKedUoR3ZqWQKJAb02srM3Y7QNKNQghQ93xDLqxS1UWK8lqM5q5sfhP
	 r/yjg0VfJPYJW/44uJwVOAfbc7WCB1p0vrD0DU7WFFV+i3Y3/ceRh8pRi8iP7ngk3o
	 /tPdwAtIvEdvz0ROM4USi8T5tVL9qbWQ81/izzha8v1Vx7cNM4GvNtmkq74ynCRYrE
	 TyGa0gWh51dPy8/VsYVDOECPc6lya0kdCzkA1Rfe/buAyOG3l2db1DtJlH3d60fOB2
	 5wdc+k3cXooFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F47BC43614;
	Thu, 25 Apr 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171404762858.28186.14186712070509213799.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 12:20:28 +0000
References: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
In-Reply-To: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Apr 2024 18:53:26 +0800 you wrote:
> In br_fill_forward_path(), f->dst is checked not to be NULL, then
> immediately read using READ_ONCE and checked again. The first check is
> useless, so this patch aims to remove the redundant check of f->dst.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  net/bridge/br_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: bridge: remove redundant check of f->dst
    https://git.kernel.org/netdev/net-next/c/e7d96e750f2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



