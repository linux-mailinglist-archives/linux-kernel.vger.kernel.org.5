Return-Path: <linux-kernel+bounces-77710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C6860951
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969AF1C230E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11786111A4;
	Fri, 23 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkTK6xpy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EBF10A10;
	Fri, 23 Feb 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658430; cv=none; b=Iv88CI7yCg/jzeToxKwsSQ9O3j6063MCbLSAv9l1js24bOcYr1RMurYqZ7G5MNaJbYpZeEag6MBsGYi2gU05/UjGveNO1EuiyV5SIZPdSI69YbRVETmnreeGs81VoS8h08t/wcqTbq+YIz6aJERohFrOw8Zx7niibhUVHeDrpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658430; c=relaxed/simple;
	bh=DA/Qri4FRnR82K28V8ne3NOgfpa2H6l2LDbTqoIcsW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UgntLharD/6VbccpqujGEcIEl9ZtCsYBQLCny3fsaPlgdJS27tyZnDbPCAr934Vqkmuz3SkcNyOzjcNctja8m32UX0ygPthLA4mHvQHlmThFMKc2Pj4rN/Ha5cX7CyxyrPZtQMXf3kNUIzhu24Eo5VgBWzWEdXk3tjjgYwdTGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkTK6xpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0845FC43390;
	Fri, 23 Feb 2024 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708658430;
	bh=DA/Qri4FRnR82K28V8ne3NOgfpa2H6l2LDbTqoIcsW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HkTK6xpyvf6axWJHdW0nri31MtNqaEqP4mzRWDXZxesYhCouSbuKjeyGDHVTFQlQe
	 vAgWzw0m1PmOFzyfeH3/GKMW6bg/XZmUsvlfyxpXNTfeePpy7ZyfM1or1j6knLvFo6
	 5X9RQpxjt67Wj+NL7kcHlvyoKWTMJqF9bk24s7KITFd01zQgAd72dLtwjU95iZYuFh
	 0hrk+XQUA8GRPR3diA2DAgONwVg6z72Gnx4PyqUTO8ZJNzP/SIwWr+vhDpy7smcOgb
	 qE++jldPp3DKEGEYN6byhdjZlNX8kTdSZtXX7rLdzMlpH9IHTO3r6LTCCKwgFVGa10
	 FNSYyUITE0BQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9C62C395F1;
	Fri, 23 Feb 2024 03:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] bonding: rate-limit bonding driver inspect
 messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865842995.21611.9707338053394073057.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:20:29 +0000
References: <20240221082752.4660-1-praveen.kannoju@oracle.com>
In-Reply-To: <20240221082752.4660-1-praveen.kannoju@oracle.com>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Feb 2024 13:57:52 +0530 you wrote:
> Through the routine bond_mii_monitor(), bonding driver inspects and commits
> the slave state changes. During the times when slave state change and
> failure in aqcuiring rtnl lock happen at the same time, the routine
> bond_mii_monitor() reschedules itself to come around after 1 msec to commit
> the new state.
> 
> During this, it executes the routine bond_miimon_inspect() to re-inspect
> the state chane and prints the corresponding slave state on to the console.
> Hence we do see a message at every 1 msec till the rtnl lock is acquired
> and state chage is committed.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] bonding: rate-limit bonding driver inspect messages
    https://git.kernel.org/netdev/net-next/c/a4634aa71fee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



