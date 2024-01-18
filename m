Return-Path: <linux-kernel+bounces-30451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0883B831EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B723028B975
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF02D629;
	Thu, 18 Jan 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGbHw6mE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72C2D058;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600828; cv=none; b=kSNQ/rIo/BN6sSM5WtTuDLKZ3CyHkLkhvZpzDkDCwbKyFkp44/0X97Rra61n4e4b5oXfSfi/oKaedxMKM7qtphO3YETVmHPKVWKO6kCo5c7VsFRWnau9pvr3KcqDqFR1ErXtr9AJ5Jw6TxNT6MS4Z2scUY+I2kKYbWnLA5rymaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600828; c=relaxed/simple;
	bh=9sn1wXNYVCWmv9eDQHfqDMCLE21PxoR96YDrPpEcw7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tPOEHkTUj/7liCu/zxJRvOC43LU/5hTrGxHCBa2zsUdKSnDZ7PiIpTdyyzRlcTgz/q/+dP+4j78wdRiImI+AoVyc5Q4IELwO3YVmofGq0fV7aFW4JDaaGYlHJo9IkxM3EkLqIi9DDe+kuwTKGT0WMgu6TmTou2I8GTlyMzRE6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGbHw6mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D1EC433C7;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705600828;
	bh=9sn1wXNYVCWmv9eDQHfqDMCLE21PxoR96YDrPpEcw7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hGbHw6mEaCWc49iMVRN48hRdH8IRvr+sVuk3/7j+A6+MVMKnsYtd2Zd+Wn2ndufZq
	 VWvCyVO9huPZ9Kt5ceaq9N817V3VMnyIkolHoBDxzNUB79waPymZIP1hrQWWMz0q07
	 Iz74RTFWNBuHoUBLOJj/AkH2z/swwCj7BEEmLppDFqC4g8J0rHNAdCZDUInobwhjp1
	 vz/Uw82ZJlqIDbuBp5EIppgMkJFkDbKfKRX4+qE+OHGSju0fjdNrYy6oAf1YrScfef
	 FIOuKC8ZsUZgALUzcatmEE93y+2QWbAOZiNE6hsCFIN2rNle8YYhOoZcRcM/rGFRfT
	 lgwVh/uJHZJAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FE1AD8C97F;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170560082806.5819.6461479890543171742.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 18:00:28 +0000
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ap420073@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jan 2024 09:21:02 -0800 you wrote:
> idev->mc_ifc_count can be written over without proper locking.
> 
> Originally found by syzbot [1], fix this issue by encapsulating calls
> to mld_ifc_stop_work() (and mld_gq_stop_work() for good measure) with
> mutex_lock() and mutex_unlock() accordingly as these functions
> should only be called with mc_lock per their declarations.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work
    https://git.kernel.org/netdev/net/c/2e7ef287f07c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



