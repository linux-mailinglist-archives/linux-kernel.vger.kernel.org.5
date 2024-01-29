Return-Path: <linux-kernel+bounces-42617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8EC8403DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1FD1C22D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B15C8E4;
	Mon, 29 Jan 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfHAfH7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F75B5D5;
	Mon, 29 Jan 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527827; cv=none; b=qnNbHaPY62ZleBZUM7RmtWlukZX1PZ1LBMQkbH/F2uymJYrs9+pJ5g/y7DN4CMcYqUhKsPygrpIm5hPen3Uw+xBjGKRY93cjp/FSemcr8+wMJ7M4M+2Csnj7cfdjjbtl3nqibwOXlIPMtqDrr8aODeLvesTj6jqvmGeSIR9U4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527827; c=relaxed/simple;
	bh=g00WJ7QnN+wgpuglo6tzkpl11BU0YKAjQwZCVlMUDdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jj2LpA4xinQiHP/WAwz7cDOCz6vpoqOnhYQI+ypd08GIn5d+mQxCYF7aN5jLSJA48aMo28UQnsr5/79psf6Jrq+eY03X/XQFqc7tV/+E7HmVMt+kxhDDWzh69ny7FlbS+EaGNo2hOmcZ09kWIDjVzCsSDp2w03hbcvnK1+tHi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfHAfH7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E2F3C43601;
	Mon, 29 Jan 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706527827;
	bh=g00WJ7QnN+wgpuglo6tzkpl11BU0YKAjQwZCVlMUDdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lfHAfH7UXPazleRkpwTH+QPHYciI0XxoemEOcxy45ibArBQvN/IUbQ1aP4RFMHMCp
	 Y09EqBXKAsBh/B6YSRu2sWDs3kGIv+yQy1uT4inXnfc8IPTtYNHFBPX4kzZ07L+VGj
	 blw6P5GUPpPeUxbXCIptrBYq5Lhq6uhonGZIGijWdftEyz6AQlic2kpdHDTZcwypa9
	 B6UM/p0ck0oNlDE9jDHWlNlnjsHAs33PwWjOkxIYQW7kqSIRNgXdOfNMjp3T+Nu4/6
	 9QvspDe9vVPh4mPBp17aKfLngv7H1Eud1idpxSeMVumgbOdCZKtj4vl/Dpoipd+/4/
	 WqMcCy+OJa5wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 007DCC561EE;
	Mon, 29 Jan 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: remove WARN_ONCE() in
 send_hsr_supervision_frame()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170652782699.19974.1569305900184151152.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 11:30:26 +0000
References: <20240124102147.14081-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240124102147.14081-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, r-gunasekaran@ti.com, horms@kernel.org,
 wojciech.drewek@intel.com, m-karicheri2@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+3ae0a3f42c84074b7c8e@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Jan 2024 02:21:47 -0800 you wrote:
> Syzkaller reported [1] hitting a warning after failing to allocate
> resources for skb in hsr_init_skb(). Since a WARN_ONCE() call will
> not help much in this case, it might be prudent to switch to
> netdev_warn_once(). At the very least it will suppress syzkaller
> reports such as [1].
> 
> Just in case, use netdev_warn_once() in send_prp_supervision_frame()
> for similar reasons.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()
    https://git.kernel.org/netdev/net/c/37e8c97e5390

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



