Return-Path: <linux-kernel+bounces-15483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22B822C95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C227E1C2314A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733B199A7;
	Wed,  3 Jan 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao6Z6y1r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D219458;
	Wed,  3 Jan 2024 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A9DBC433C8;
	Wed,  3 Jan 2024 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704283224;
	bh=WPHbYr0OySUAical7UhRi7PEZSyrOoxFYTW714Fb9Jk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ao6Z6y1rSYB3mMyBe/6QOQW2Iwl6tftMTeATJfK8FBc2j2afTusSxQvrQFfi9N5Ri
	 YqBKwXlARnF6fYRe2PpKSmUZ2luY+BDWE1sZfe6P2qZL7s0TU5LevZrLqOXqI5Dpv8
	 mBPj5YPvnid2pC9/1BGf5KXD9caSpnXr9nenj7ttGScNLtAWZJeVMR24BA+UO8B0+3
	 9hib9NhDCbiXzM3L2lw7/HOR0YWHlQsXKKjvEVYIA4hrsicWihpl5KFxU4B7JsuPfj
	 uUaZfibWS6LAYOsuLJVKK6PjmJJVr2psw/cuACPThicVl8RRQQg6lqdDc0iXdflL1X
	 qzZWXiEIRRT6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68355C00446;
	Wed,  3 Jan 2024 12:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: cls_api: complement
 tcf_tfilter_dump_policy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170428322442.1788.8455879320567617653.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 12:00:24 +0000
References: <20231228064358.3042747-1-linma@zju.edu.cn>
In-Reply-To: <20231228064358.3042747-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 28 Dec 2023 14:43:58 +0800 you wrote:
> In function `tc_dump_tfilter`, the attributes array is parsed via
> tcf_tfilter_dump_policy which only describes TCA_DUMP_FLAGS. However,
> the NLA TCA_CHAIN is also accessed with `nla_get_u32`.
> 
> The access to TCA_CHAIN is introduced in commit 5bc1701881e3 ("net:
> sched: introduce multichain support for filters") and no nla_policy is
> provided for parsing at that point. Later on, tcf_tfilter_dump_policy is
> introduced in commit f8ab1807a9c9 ("net: sched: introduce terse dump
> flag") while still ignoring the fact that TCA_CHAIN needs a check. This
> patch does that by complementing the policy to allow the access
> discussed here can be safe as other cases just choose rtm_tca_policy as
> the parsing policy.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: cls_api: complement tcf_tfilter_dump_policy
    https://git.kernel.org/netdev/net-next/c/2ab1efad60ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



