Return-Path: <linux-kernel+bounces-51759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB8848EFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8BD1C21DA6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2523749;
	Sun,  4 Feb 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHbEcKzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4522626;
	Sun,  4 Feb 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061827; cv=none; b=Fi6H1km5zV2GBshSOIjDlRqdLRjyTH15pCX/F4Np3bnc+5yPtSqeQ28fTUiaq6iB0jTmn9lYgI3q0xjlI6M0jUZlalJTAod47uCwp0MMfnhUZReIY1Kz8yrHSb7VG30i+rh33P20XyVlzHIZQXrQtOiTUayuKyy8ItuFzwQvV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061827; c=relaxed/simple;
	bh=pds5WW1Wmw18G9/IgRAxGrdb/+m8DHHVDjPGuyb/ZhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qZSXB9e6AUX7m7+YGoFrGHE5uBgfAZRM3U+1gafZC2R1GW9eb7SDJ+Z+7m0LH6Sk5NycncDEebEWQ9RArud0F6kCTlOk5IXuGUlqOk4bG1LHTve6J+eQI7upUs7v7I6vc6v0ma0t08mOYNJbIwTHgoDe9BrnBOuHNJOktw3avUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHbEcKzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E23AC43390;
	Sun,  4 Feb 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707061826;
	bh=pds5WW1Wmw18G9/IgRAxGrdb/+m8DHHVDjPGuyb/ZhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bHbEcKzxnXYuELKIquX9dkjSTFBd48JJxq+A33kZw/l9nJYwHqlFxqEjLuNteBGTX
	 4uDo0N3NQmvs+HoAKLlem61P5W0uU2/SGT0hqORO1jOZhM2hYDEk5H39tnikuFXiby
	 H5oZY5vtC80dk4/WxkHMFU8w5oBAYw6ONnxEKZW7S84WZfqgpsHX7ZNMyETLT8PzTs
	 IdupDVUa26G9atJrkBTn+n6bUORZeUWK7WbYSPw44ksta0ugXHdAL5HZP2CYWP6X+8
	 bVqKb46W46sAWAroCjp5VTwHpA47uRMthu3hARxipTsT4kwJjgFFuYsNwtxLp1w2lt
	 XtQSuCklxbeUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 432C8E2F2F2;
	Sun,  4 Feb 2024 15:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tun: Implement ethtool's get_channels() callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170706182627.14059.3748675872418347734.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 15:50:26 +0000
References: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
 davem@davemloft.net, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xudingke@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 2 Feb 2024 15:53:20 +0800 you wrote:
> Implement the tun .get_channels functionality. This feature is necessary
> for some tools, such as libxdp, which need to retrieve the queue count.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>   v2: add conditional on IFF_MULTI_QUEUE
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tun: Implement ethtool's get_channels() callback
    https://git.kernel.org/netdev/net-next/c/45a96c407eb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



