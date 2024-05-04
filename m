Return-Path: <linux-kernel+bounces-168453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0D8BB8CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122031F23884
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477B1EB5B;
	Sat,  4 May 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiAZ+JyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2322612;
	Sat,  4 May 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782630; cv=none; b=Z+DpmYCq3+IqLfL5UzCeYWlTEaJ/Vk1/LNXQoThcUeRox9dUi6Y4zfCR+ZSo//rDOHIqU2UxPTe3XMKMe4wn/uuNwE7zWlrfeWG+w6nNr7r311BdQDKf03u/DxwdZ7qUokW31JU7w4FZfo02Eu0ZHYlbi4whWEi7HQrn2rvdyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782630; c=relaxed/simple;
	bh=pZ6zcEY25nwGF9/B+NzjHkiKdVzmaaBaPXGGoBI9U4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWUDJUjJdik59XVWtwOKjQuEC4m+fugdfnryxbIcpDPpfFZmd6uKhwR9qPKE8TV1BZAl3k5KHwR8mdbKGcOIBl4UQwNKvdKETtNQC16XF+yQuoG40s5li9WYMPux5SrbzY7+OKaNUuoBDUEGm1irNoTJyXnuUaCfDZs2r5vzcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiAZ+JyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5CCEC4AF1D;
	Sat,  4 May 2024 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782629;
	bh=pZ6zcEY25nwGF9/B+NzjHkiKdVzmaaBaPXGGoBI9U4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BiAZ+JyPb88j3zTLxWy7gKEpPwO6S25+SMDHwavBOWtr0pkF0MMYdo5N+O8q34bNa
	 1SbgGLeCbxLbF8aplHso7bLLhehVEMKwYKes0YMuzae7Ee2GjmuwwJFg42d6gyGIez
	 2sg4PBb/8D5hEmd4emr4CrX3KDnb7uPK3Oo3EL32Mj2uJR5pffkjOAg/zbD4SNafHT
	 yIsnW89wtiZ1mbWkM9+SoWVwHBLfwy1z3gr0rTq8jmcyRzNk+ULIlSTcEj80Tu2RcF
	 6KR9lRKWqY1Y9I6em1f3mnT8efUfr/BY3zr/NEgEA48QL2H/AHUq7a1TKKh5MGbgvW
	 PthIc4LnOGGSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4D29C43336;
	Sat,  4 May 2024 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] Revert "net: mirror skb frag ref/unref helpers"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171478262986.21471.5306831974379816981.git-patchwork-notify@kernel.org>
Date: Sat, 04 May 2024 00:30:29 +0000
References: <20240502175423.2456544-1-almasrymina@google.com>
In-Reply-To: <20240502175423.2456544-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ayush.sawal@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 john.fastabend@gmail.com, dtatulea@nvidia.com, jianbol@nvidia.com,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 10:54:22 -0700 you wrote:
> This reverts commit a580ea994fd37f4105028f5a85c38ff6508a2b25.
> 
> This revert is to resolve Dragos's report of page_pool leak here:
> https://lore.kernel.org/lkml/20240424165646.1625690-2-dtatulea@nvidia.com/
> 
> The reverted patch interacts very badly with commit 2cc3aeb5eccc ("skbuff:
> Fix a potential race while recycling page_pool packets"). The reverted
> commit hopes that the pp_recycle + is_pp_page variables do not change
> between the skb_frag_ref and skb_frag_unref operation. If such a change
> occurs, the skb_frag_ref/unref will not operate on the same reference type.
> In the case of Dragos's report, the grabbed ref was a pp ref, but the unref
> was a page ref, because the pp_recycle setting on the skb was changed.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] Revert "net: mirror skb frag ref/unref helpers"
    https://git.kernel.org/netdev/net-next/c/173e7622ccb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



