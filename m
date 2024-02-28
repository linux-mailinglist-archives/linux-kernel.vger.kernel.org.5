Return-Path: <linux-kernel+bounces-84870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9687E86ACDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B496288686
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151D12FF69;
	Wed, 28 Feb 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgpwjk76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170912CD87;
	Wed, 28 Feb 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119233; cv=none; b=szsQ3wVMg+3kT1NvnRz5RrIbyo9OYRc+YAyITM8pw0d+QqDAuAAkntneBnFjsblP7A2EHeHzO5oumHo6kqH+NrnmecO5B2Nt6VWTwbEdOkXsx/p8dZuxEfmFlRKmb3PPzaAb1a3DT4j3M3Njq/3fWK4ILnw+SEAe/434evQhmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119233; c=relaxed/simple;
	bh=iNxO1LX+za5ZhwCxlOgkoZAAvvqe0lo3nS39mg7IxBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q36n+u2Hk7uAwKIxAFrEXc2QWc+Tw7wINgdJ6DhkUeO4L+ZWgmeLpmBNJIhRVmfvW1dvoqQQIycWFUZ9yt7VFLSlDvvXfq8AB2SZHdBndC9lujKhgFrsJHo5Ol1+GnPAv3Moi6m03ZjnzgLidVIMVNtGH02G/lXUFMgXbZXARwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgpwjk76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8E57C433C7;
	Wed, 28 Feb 2024 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119232;
	bh=iNxO1LX+za5ZhwCxlOgkoZAAvvqe0lo3nS39mg7IxBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgpwjk76SF4YM3Dy1LXFn4zgedxYR708qCNjuNO8I4Cp+J9Q6RKZxXVlTZTYgU4c9
	 T2eKyEP6EaANzKm+BBOl8+//OHU6tcOXV1GwNAwTyMq1BPbrcYHBLqgzuQO+HUVFuj
	 yDhp5GKtyXBNL/qiF6eJ9TUkQgCsRcmcZar1regozg7Bm4Lf5qUHxQwaypRrEaHRhs
	 JdQnPdDdwyx3BQCvmEQQ565Zzea/0jc5XJbbPoa6J8qrAH6pQU1FRYsmqTxADgbsOK
	 p2v088Oc4aGBEQYj9ndyN54mtceBxpoHTxuMd2IxmTUL6Lszfd7k35QlshT4+G58VK
	 F1KLgMf8Uv+yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DC0DD88FAF;
	Wed, 28 Feb 2024 11:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: adi: move PHYLIB from vendor to driver symbol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911923263.32073.4563274730273922622.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:20:32 +0000
References: <20240226074820.29250-1-rdunlap@infradead.org>
In-Reply-To: <20240226074820.29250-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, mkubecek@suse.cz, lennart@lfdomain.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, nuno.sa@analog.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 25 Feb 2024 23:48:20 -0800 you wrote:
> In a previous patch I added "select PHYLIB" at the wrong place for the
> ADIN1110 driver symbol, so move it to its correct place under the
> ADIN1110 kconfig symbol.
> 
> Fixes: a9f80df4f514 ("net: ethernet: adi: requires PHYLIB support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Closes: https://lore.kernel.org/lkml/77012b38-4b49-47f4-9a88-d773d52909ad@infradead.org/T/#m8ba397484738711edc0ad607b2c63ca02244e3c3
> Cc: Lennart Franzen <lennart@lfdomain.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: Nuno Sa <nuno.sa@analog.com>
> 
> [...]

Here is the summary with links:
  - net: ethernet: adi: move PHYLIB from vendor to driver symbol
    https://git.kernel.org/netdev/net/c/943d4bd67950

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



