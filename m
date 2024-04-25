Return-Path: <linux-kernel+bounces-157953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D718B1931
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C892858A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F41CD2B;
	Thu, 25 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rviqC5P3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1615171D8;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014628; cv=none; b=pu4XY53aJDoOvfKMtgcwq8Zl++LnM6D5yy/MDJCOUkStMIEVAI6xhvkICT2tup9FC5eexc551GEhsP/sV2UHtEz8MyyJiC2MI/gaFCKnwHcJ95H1Aq2Xsaolb4DOoHyStLf8wk1Fi0/FwxJGpuFChADH0zSzOaReLlYNH8Oq2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014628; c=relaxed/simple;
	bh=Lu1xBA1G8xHmrMZZSZmagZcpjaY77LLqubJDvQ0U58o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gXwwOck4aEulL8cRbceTG8B7RRI9iAzBd+AiR7mWyAdp2PwslRpt8WwbDV4pGyCwjLTyBIH9IfC5wMt9IOXbleQbNoh+hXhTGZ0nwznUhE9pPliPt0yy4yxcJNCjDfnNZzY1rOnge1XMDGC+cKkb/dy7m9FaGMImAu7vyk935fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rviqC5P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 676B7C113CE;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014628;
	bh=Lu1xBA1G8xHmrMZZSZmagZcpjaY77LLqubJDvQ0U58o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rviqC5P3wt18P0cTP+f6r2f5yWucpnMN3141vleviH75q1Py4ZphaWdnfKS2Ugxxf
	 PB9drjGcGdbNIb0lFbFfscFjmIn4FQiI7ePK4XkSb/Ot05OCmV/tAXiIMnyJB9Qw4u
	 hqGdICfQkLrNdOKR62m1lbT9SF0tSWqLzu3Dh2g7A9bRHtWR4LNU9qye5/b76V3dfA
	 IVR9Vk4mZVGnsxXxkkuZPTtAWwQzo8rR4QuXVm6fY7B7NRkQ6pDjPziCce+HNG+eYV
	 bOURsm1oQXI7jB01wb6zGufMpHLMB2cIyELakLspo5UBbnBEeFEbcMv9cROK3CvlV+
	 tEyPnTgoQdLoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58683C43614;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns3: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401462835.4490.10939442126477883384.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:10:28 +0000
References: <20240422152717.175659-1-ast@fiberby.net>
In-Reply-To: <20240422152717.175659-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 15:27:16 +0000 you wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next] net: hns3: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/e199a5b29f19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



