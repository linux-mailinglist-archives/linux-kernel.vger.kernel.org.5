Return-Path: <linux-kernel+bounces-143513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA3A8A3A62
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A92CB219B9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A871BF38;
	Sat, 13 Apr 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blavqWR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCC18C38;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974232; cv=none; b=G66RFWY2DLrH+WUcxJ6USDuTaLAiz4K6TkQCy1JCHI+tnWWI7nunvAChikShsuQG1XJQbN6W7/r9EC89IGaXqjKMR+urAdeaNrGpPfPLo+1+xaY0sE7LkWfOACk7QIiyMN6lkoOCqu8fqHgcSkz5ThS/fpsQEJ+5t2owQsafW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974232; c=relaxed/simple;
	bh=z0QTLasYOw60Do7zT+tf3ZpzHBZYI1f8M3gAENScRBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GMjMA73mcdvdDfq+2+HGRwoXe6SH/BqtYhsOUXCOtP8IunoYmq9JatuFoLUP4oYBUCm9af0QqO6dx6ZLzpSEvRDI8Bsoa5N8JIcaPDpbaVpEucYqm+an/UW50HyZZ7goSyVI+Q5gZwmyaZ21wSkPDRA+0XNOCUlBy6d3ZWa0l9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blavqWR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91EE7C4AF07;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974231;
	bh=z0QTLasYOw60Do7zT+tf3ZpzHBZYI1f8M3gAENScRBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=blavqWR4JJxg2RTs+Edgd4i9BNqgZIrVMhgGSQRinnWEP/VnlaTR3zLOydfKRjSSs
	 L+1iaJ4Kp6FxCYaI4YiG8RUoIUSm4FnIXi3zVJ02ynxIFUuJSFYX7mbxkhpqNxLgnJ
	 h4h2FR5BTKEnXluwtVkFymv2VuPrs/BHvV4MU1oKF/z5APXEk3ntNorYYTAMJBeKD9
	 kieWLgDLPoNiPYIdK5kxp9Ebpq4KRE5h1rcPmNAtUui/GPioLfZeLGjkakF93zMp1+
	 BP2/0gRDgHhbW1ZA9oxMMf+PZl25b6Jgvu6C0muwuCy8/UDuXMvBzlehjnTMHIo47Y
	 VYjyzHo2Lg6mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84DDAC32750;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V7 net-next 0/4] Support some features for the HNS3 ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297423154.31124.11662297381851174991.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:10:31 +0000
References: <20240410125354.2177067-1-shaojijie@huawei.com>
In-Reply-To: <20240410125354.2177067-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 horms@kernel.org, rkannoth@marvell.com, shenjian15@huawei.com,
 wangjie125@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 20:53:50 +0800 you wrote:
> Currently, the hns3 driver does not have the trace
> of the command queue. As a result, it is difficult to
> locate the communication between the driver and firmware.
> Therefore, the trace function of the command queue is
> added in this patch set to facilitate the locating of
> communication problems between the driver and firmware.
> 
> [...]

Here is the summary with links:
  - [V7,net-next,1/4] net: hns3: add command queue trace for hns3
    https://git.kernel.org/netdev/net-next/c/2a1a1a7b5fd7
  - [V7,net-next,2/4] net: hns3: move constants from hclge_debugfs.h to hclge_debugfs.c
    https://git.kernel.org/netdev/net-next/c/b20250afcfb4
  - [V7,net-next,3/4] net: hns3: dump more reg info based on ras mod
    https://git.kernel.org/netdev/net-next/c/8a4bda8cb9e4
  - [V7,net-next,4/4] net: hns3: add support to query scc version by devlink info
    https://git.kernel.org/netdev/net-next/c/a1e5de0d07a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



