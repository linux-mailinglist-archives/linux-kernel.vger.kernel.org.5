Return-Path: <linux-kernel+bounces-119195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39788C568
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8902E3F18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946B13C668;
	Tue, 26 Mar 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbRjqzqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11213C3F1;
	Tue, 26 Mar 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464037; cv=none; b=TQTd9NqCrIZY/qaEgjNy9XItHhfgtt7Ol+RIpHfcISfNe95LHshx1Kr1LPD8tCgB29mXCuir+Lkb2Sih4hesp2qi4Q/fH5wOyidFsPVru5048w7Vm8QyyQisgSb87XwsbNpfLJ5eO5ZW1WurdZN09lQK9Gtqfa8AqMwUmkg1Hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464037; c=relaxed/simple;
	bh=H3Vfc7IMz0S/uRAz/UhNJRFdP6WlSiBzFmtkDw2fob8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aFko7lA+30nwjpXxONVoXisT1S2v8NEpLgJCBJEfDsRnFUpkXfjgwl+a4uTrY3VnEwyrLlLlGrZVhDs9iJGDNGy1xsQrcMB9lc5Hokn0xm6XOyGy3os/5SYZ3M32TTWOeoOpgTEigcxAKdESJngprY3RivWySaY46ndmY6xfuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbRjqzqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D398C43399;
	Tue, 26 Mar 2024 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464037;
	bh=H3Vfc7IMz0S/uRAz/UhNJRFdP6WlSiBzFmtkDw2fob8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nbRjqzqksR49W5K4twnw7ijD7LIau0i6ZMkkTmra7R/6fbLgl8oZyxJ9Ko+f+zV4P
	 ZPlas8PV63XBHZMVEoKJKZSRZV4Fs6LVwIae15Hu87lLT77h8R6VyEfufOBQSHbQRB
	 2wOzPvqsSVom1hoZ1XTRgTmXJa+O56v/fG+kbnlSVbycZiAkYmV9NqRClz+ecwxQT0
	 lTs2lR3J88fNCDfEP9nu9hXbmXnnXPeWA27sQZZ0rUeQNND4r7s7QF7iTOZGBXp5bE
	 Sw/Oo87fOrCeuex9h7JgifYQ1o6sB92ntd3TqjeC0clc3ajGL1WORhvw5TkOF7E7Xm
	 b7tlz7lguuJhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA423D2D0EE;
	Tue, 26 Mar 2024 14:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4 net 0/3] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171146403695.8434.9400117665532807499.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 14:40:36 +0000
References: <20240325124311.1866197-1-shaojijie@huawei.com>
In-Reply-To: <20240325124311.1866197-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.kubiak@intel.com, rkannoth@marvell.com, jiri@resnulli.us,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 20:43:08 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> changeLog:
> v3 -> v4:
>   - Fixed an unclear sentence in commit log, suggested by Michal Kubiak
>   - Used devl_lock to disallow reload to race with initialization, suggested by Jiri Pirko
>   v3: https://lore.kernel.org/all/20240318132948.3624333-1-shaojijie@huawei.com/
> v2 -> v3:
>   - Fixed a syntax error in commit log, suggested by Ratheesh Kannoth
>   v2: https://lore.kernel.org/all/20240316111057.277591-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Fixed some syntax errors in commit log and comments, suggested by Michal Kubiak
>   - Optimized the code by using a flag, suggested by Michal Kubiak
>   v1: https://lore.kernel.org/all/20240315100748.2913882-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V4,net,1/3] net: hns3: fix index limit to support all queue stats
    https://git.kernel.org/netdev/net/c/47e39d213e09
  - [V4,net,2/3] net: hns3: fix kernel crash when devlink reload during pf initialization
    https://git.kernel.org/netdev/net/c/93305b77ffcb
  - [V4,net,3/3] net: hns3: mark unexcuted loopback test result as UNEXECUTED
    https://git.kernel.org/netdev/net/c/5bd088d6c21a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



