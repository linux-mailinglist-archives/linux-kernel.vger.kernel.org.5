Return-Path: <linux-kernel+bounces-137769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1B89E6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AC8B21309
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143464C6B;
	Wed, 10 Apr 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un/xu+Iq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50322621;
	Wed, 10 Apr 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709031; cv=none; b=WOHDHXAPUj51ByNTGoWR6lAU6g23eAiNCY9py+XRinU+TCfyA4A75vOdzgXQ6gqdbd8apgUQolKKVQDG3eoYjjGT/KPfZBE+3Y2bjABC+qpehRYWdOfzPFIHX34syuYgSs0jhBxPF25Gwhbc8HiZNZZJRvP7ERL5g5BS/wk/A/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709031; c=relaxed/simple;
	bh=u9fXKsfwHHfGu5BH9mr5vTAjne0rgpXqWjDue8Dj4n0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kRPE+lbCZQJPP+jqBQ2rzu/7CsyAz7Q7SiDhZnvjPKaBE+zwtFGNrLzW4+Ws/uoa7zt4pdAfIwyJem/BnA/nZO/UBg0lorPdiqsJd+objj8zlZaYYFwBh6RZqXX5KCyJkHDbIKtMkztrS6dZLFBDg2G4/Rr+qs72JS20wkW/NWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un/xu+Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F35F2C43601;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709031;
	bh=u9fXKsfwHHfGu5BH9mr5vTAjne0rgpXqWjDue8Dj4n0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=un/xu+IqXoSyAAU1Qy6uCCTLhABZCFKlwZI4D2o4FIGc/XQ0pCk+nLg+3MECpXZgo
	 qi5TStqPpaMOohKsZYeGQrzoN+7nllN2xSsNmiwrUJIFLUMDy0dBWNpmbNPM1qvZA/
	 o7+3pCTGvFOnCLwRQUziHcZFqfTnFHwSF2+q/NQjWJefpJGEdZugtpkEoadkuZLD4q
	 Ji1Mf5nwOo0Q9Hrp5QWoLmZmWBcmFEVmexVvkK18LV4WHb/Q9MGKMf3ctjhChGu/r4
	 fK7+4N8dFhzkCNXFLdWnRNZkOhOQVsPBwnX5LKs4mB9t48Nk60vse5IS4hcUA12DWI
	 8rxZ8izfkQfqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7968C395F6;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] cxgb4: flower: use NL_SET_ERR_MSG_MOD for validation
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171270903094.7096.8804874877660329103.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:30:30 +0000
References: <20240408165506.94483-1-ast@fiberby.net>
In-Reply-To: <20240408165506.94483-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 16:55:04 +0000 you wrote:
> Replace netdev_{warn,err} with NL_SET_ERR_MSG_{FMT_,}MOD
> to better inform the user about the problem.
> 
> Only compile-tested, no access to HW.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> 
> [...]

Here is the summary with links:
  - [net-next] cxgb4: flower: use NL_SET_ERR_MSG_MOD for validation errors
    https://git.kernel.org/netdev/net-next/c/545d95e5f1ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



