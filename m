Return-Path: <linux-kernel+bounces-56537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0D84CB64
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF6628D985
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D787C092;
	Wed,  7 Feb 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGHJf4h8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4D7A713;
	Wed,  7 Feb 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312025; cv=none; b=nuLlNGUOpF0JlOFMtpQYUnsH3KqLM4dn+sqZ8zE2mxt0GawzbI4HNmzfcBI3I0RCLsnyPeaPEB2xERTiUrfJ98EBEPJ0/d8khwP+73V8YjYk9zx0IB0A/tUDEmzU7anAude7eRWGqSEpsX00PtJyTpCGhVvsEGTIYhfkW0HypUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312025; c=relaxed/simple;
	bh=RDY142cyaHC6LzDMxKAS7mXsz+T9CjprFQaWtOsEUaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7QMlLZk7coZ5yYL2R+pOuqMvDKnYW1v8JvD/1bUavbhZeKbjuPwj1VlSEmTHSOQLzgUSkdk5FSYpBIIGiZ6PLdMS7dnoriLs97mWAFRFlbwduOc3j/ijJ6Or53f6TQmd4hTpVTZpL+wp6eEIf20qvxs/sh6CZS9WjpAhQYPJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGHJf4h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA4D6C433C7;
	Wed,  7 Feb 2024 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707312025;
	bh=RDY142cyaHC6LzDMxKAS7mXsz+T9CjprFQaWtOsEUaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CGHJf4h8JUMxGhV5el0R0lPSeFYf2H8KT9FNJg9sLdnBq54N0urGmIyan5Y1YG4e/
	 DK52gtMTlHJ/XjF8YymMjXbibkBXl12MYGx6ppflh2xTJQQ0UNsO9wJT4U0vaBP8r9
	 qUokZ/xhflRuuffckpPuCMR7LrwBHiGWj39/SyVfKXKQA0b0vGOQY75HErfZP2m0Zf
	 GO4K4HJoC9vYM7dOdsVk8y+UzJTCNDTtiMvKQAXZWjUnYJWoxwjjF0x4kn2aAbJ7cu
	 zCBQqqhjPYOk2N+bVPDEMHOMVL+uhTVGzuuoo/kend74rRHufbaaN7nfS2rFEAoiQ7
	 y12J8CcJKRi7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF845D8C96E;
	Wed,  7 Feb 2024 13:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: tipc: remove redundant 'bool' from
 CONFIG_TIPC_{MEDIA_UDP,CRYPTO}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170731202484.6388.2120371301294318464.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 13:20:24 +0000
References: <20240204131226.57865-1-masahiroy@kernel.org>
In-Reply-To: <20240204131226.57865-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, jmaloy@redhat.com,
 ying.xue@windriver.com, linux-kernel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  4 Feb 2024 22:12:26 +0900 you wrote:
> The 'bool' is already specified for these options.
> 
> The second 'bool' under the help message is redundant.
> 
> While I am here, I moved 'default y' above, as it is common to place
> the help text last.
> 
> [...]

Here is the summary with links:
  - net: tipc: remove redundant 'bool' from CONFIG_TIPC_{MEDIA_UDP,CRYPTO}
    https://git.kernel.org/netdev/net-next/c/59d6bccebe5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



