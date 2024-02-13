Return-Path: <linux-kernel+bounces-63345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BF852DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04834286576
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D940250FE;
	Tue, 13 Feb 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSCgiqdt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A122636;
	Tue, 13 Feb 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820228; cv=none; b=tQGad0fX26CofGdxtmGmJREgTZKjPg99Fjtyv0VVnWR2ChtX0jTJjq8JkRoLVZlS8m/XCMk4f8eijrlKj2pqALvEoZ+/lnBBVkbBTJyMGRCYQ28pKgCz6x11W+eL5wiLx9iovGlsTPuogfTj3IcnwfaCtFIStCXWlGmxbHkTbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820228; c=relaxed/simple;
	bh=M5U1KMIL9Jv1+DU/N5KhWiyTc3+bJBScS9SOjc0CcsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LrLW7HdNMG8FEwJ12Q4IZhdDARIBeZv5gmYEXTAMx9B9PpxPmZr240ibNX+mV+BBwdYHymA+ErBbXt9NXIiyCEudBdR0Lpj0B9DHLhALlPS4V1IgE2of0CI7UJdAsbj6GwTFldkVbeQpwb7iGs9EXwl/eRSWGiYuKVexcq7iVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSCgiqdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05641C433A6;
	Tue, 13 Feb 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707820228;
	bh=M5U1KMIL9Jv1+DU/N5KhWiyTc3+bJBScS9SOjc0CcsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tSCgiqdta1KuGALHlzdd1kcMj2uLy9nFwGBrJadQS0j89WwBZ9MZrwi11LCsPJ0HI
	 o5AGARkGkCyclwCFqZuhBXv929DRD7N4+wH3joV0eCC/rACuNwfPGdb0oI5N+8WBZI
	 cPylMxPs8Nx0SRt9Jvm0zCLYkOJbPlige/xM9c5t/tCu1rg/yGXg2GAdwSteAwhou0
	 cB/w+WebeFfk/X6lINm1bMWc1G2S3sjvwJqS/FN/km8neWvIIHiwYi5KuB1OKYy6A2
	 a0+OUTg4G+tG1W0yxRg132kpatEG/0/1OPoDgL6+sPQq5qf31CEJXCuW74uLip3vz+
	 lhPWQsC5UsS1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2B08DC99FC;
	Tue, 13 Feb 2024 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: Remove NET_ACT_IPT from Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170782022792.31378.16185265091913495301.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 10:30:27 +0000
References: <20240209180656.867546-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240209180656.867546-1-harshit.m.mogalapalli@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Feb 2024 10:06:56 -0800 you wrote:
> After this commit ba24ea129126 ("net/sched: Retire ipt action")
> NET_ACT_IPT is not needed anymore as the action is retired and the code
> is removed.
> 
> Clean the Kconfig part as well.
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> [...]

Here is the summary with links:
  - net: sched: Remove NET_ACT_IPT from Kconfig
    https://git.kernel.org/netdev/net-next/c/86fe596b588f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



