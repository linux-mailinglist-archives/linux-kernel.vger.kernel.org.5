Return-Path: <linux-kernel+bounces-129512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC56896BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8356B2DF32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9C713C3DE;
	Wed,  3 Apr 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYpQMVyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7613B587;
	Wed,  3 Apr 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139029; cv=none; b=Kn2JEzvpnj7G9UlaEqxXXcFsja79KMUprPrz6C56V0T3OBs5sxdnIka/nLkY9oAaDbBxgzDBWnInKjXo2E7BKkvSJBtg47PyepZ2GY0qnkilXpr037cprPFp+EgsLr9cZDUOoG2CxpCKZv4cUD6uyd7aotm5YPVG25SdPu020Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139029; c=relaxed/simple;
	bh=8X0qRYwm8y4DjExx4iOfuaA9BKNaLtM2/LhmpI9xN7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gsv+LOWFesD+pLn1jNWrdAK0Ec2sMrpOx5hSFy3hS1i71yUAFQqpa9HHCbhmyGVR328TqrS0sXmS5v8NtsQZSHynoswAghBnGtp8FDmVA6Nyfv+EfvvKAs5awLXheUntxaTzn/HP/tWxqLcm+UYRvjUKrxAa8+8jG5HqZ7jOOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYpQMVyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B9AAC433F1;
	Wed,  3 Apr 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139029;
	bh=8X0qRYwm8y4DjExx4iOfuaA9BKNaLtM2/LhmpI9xN7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYpQMVylRafHU5iGeUi5QjZwoOMcXupbL2hmzXVo/i5bfy4NMUPpLsrBTHog+RQfX
	 Rv1JdP9DcW+UaY6TQXI2pvmnpTsqErCGWrpkhsf1jeOkIMW01ZCUegQC+0qGPzjadI
	 QlZX7nqikA4vsvSqXn32av6VivssSThdnxcp7YKLgtqdoY5mjjyZWmeDb44hdzUIEN
	 2e6s8HZWqqghRSNl0OZgSityOZF4jVwdnfoLHqoR7zlLCe8ID8VvVEeVgXPNoeMqyd
	 Kbucl7RmYUApwqvuwr6yDcZQDy7wx8AYR/05m8w8zeExZsFjfwbmzlSiLC/xGO2qs5
	 3fF5zJCYoVKkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60275D9A158;
	Wed,  3 Apr 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171213902938.4996.5946401642859225175.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 10:10:29 +0000
References: <ZgXmscAd6Y2iQQ6O@neat>
In-Reply-To: <ZgXmscAd6Y2iQQ6O@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 28 Mar 2024 15:52:49 -0600 you wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
> that contain a couple of flexible structures:
> 
> struct smc_clc_msg_proposal_area {
> 	...
> 	struct smc_clc_v2_extension             pclc_v2_ext;
> 	...
> 	struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
> 	...
> };
> 
> [...]

Here is the summary with links:
  - [v4,next] net/smc: Avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/9748dbc9f265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



