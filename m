Return-Path: <linux-kernel+bounces-143512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528F8A3A61
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE59283BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957421BC41;
	Sat, 13 Apr 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV/9BEkf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABE1865C;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974231; cv=none; b=jR3GujpO6DZlGpBWXwp3Q1P8tQkfs8qyW8HZG6veBOgJ3rmfvQe/iZsZNjO/8eTTg0nAcbI4N2hHLNPnAskDFpXvQ3v+sc9Ik8xOl/5jUCNGVM+z82ICy6IUKtaY7Jj+wIz6V90rrQrSHxEYgK0HYWFwIGjiByXaMjv/ncYw0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974231; c=relaxed/simple;
	bh=aTzNc/ys01SKda28a/V7y+hIHa06tWV7oiAN7DcmzbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bY0U+n6ZfBdYrZI4HJXhPpbN2XxMfhnCDsqEQ8CbYG+xeQdJTH2W2TCh0AJBsaiOWCx8wgI/I0nXRwBF87NAmns8ZWEYSLC9NTrfF1Ex4PmkEIbVAYIU/lidke1rSm2WS8gtOKhLj6KycXIiGHjnv3ogSh8IzR1v025W5SkM/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV/9BEkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97ED7C4AF0A;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974231;
	bh=aTzNc/ys01SKda28a/V7y+hIHa06tWV7oiAN7DcmzbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RV/9BEkfuMIpO/UgLlVAQYBOpSqq1aw7yueapmq6BdFgMRxsDwx4NwdtFleGcutsk
	 JQghqwzRTqvGIWENJsvRPnJtpJEPJ9LMlVccjm9seS4tKbWFdkga6pGOIDwZZGPc/a
	 DKzWbhw5d+rSh/yAEKpfUz4QD2YJCRJhPdYxw2m3lE1bk2ggk1uEVUVxoT9aGEQ/2q
	 eQAdLMYXow3JDBy33Xf3adJsdfazYdRsUB6SFtPXk7xJ928q3v+epDfRzT/ctOodf3
	 MnYvpXuwmxkpXC1cLED8Wg8gbSTff0bS/mZp7bweaX0pTYFbKIxLIQwz7+Okw7ogqr
	 pOqSn4iSh1Ang==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DC25DF7859;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] tipc: remove redundant assignment to ret, simplify code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297423157.31124.15059984816555021633.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:10:31 +0000
References: <20240411091704.306752-1-colin.i.king@gmail.com>
In-Reply-To: <20240411091704.306752-1-colin.i.king@gmail.com>
To: Colin King (gmail) <colin.i.king@gmail.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 10:17:04 +0100 you wrote:
> Variable err is being assigned a zero value and it is never read
> afterwards in either the break path or continue path, the assignment
> is redundant and can be removed. With it removed, the if statement
> can also be simplified.
> 
> Cleans up clang scan warning:
> net/tipc/socket.c:3570:5: warning: Value stored to 'err' is never
> read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [next] tipc: remove redundant assignment to ret, simplify code
    https://git.kernel.org/netdev/net-next/c/195b7fc53c6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



