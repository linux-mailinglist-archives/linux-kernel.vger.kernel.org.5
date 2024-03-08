Return-Path: <linux-kernel+bounces-96980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918D87640D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D96B22EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDB57886;
	Fri,  8 Mar 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HExJL939"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8257880;
	Fri,  8 Mar 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899834; cv=none; b=eCXCvMq0uyWK+53Q1byfWU3XT31AkcaMXDTuBaER3eStiveZbWs5HDEkAFm5n1WbbRYU1ttIS6exsRrOuLa8Y6YbI63Ah9nMBooFq+vXp0OEk6AAeKBzkKhM3zGSqJCv+trVHUr4yDRFKgMs6OGsWtukHdFgGTuPpRww2HLHWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899834; c=relaxed/simple;
	bh=Rh7ep53yssknr1kNn8KtS8YyEUbCMnHW87CArF64XNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alKnzTsVrgOEzbrzXnxe59VX7KGDKeezpAUU2ylwRpifHECYa+PAKuOGq8696B5KNWjvIwxb9jfHym1WiPQyMSBl3X/4gd0gQfA2UGeZrQChFVjIHX8AfrH6hP6UMvV1PXVgeXbiJ51mDk6MQt74kV4yjfRT2AznjKIwX7750GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HExJL939; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBDF5C43390;
	Fri,  8 Mar 2024 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709899833;
	bh=Rh7ep53yssknr1kNn8KtS8YyEUbCMnHW87CArF64XNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HExJL939LX1FYbdAjxDjX/pI8bvsOO6gFtVcJf9DBrp9EChmO44e6DUBB5LfVciIa
	 f9+ErKl8Old/Lue3CnOrepEOc0WaMz8nXDNndWM6BTIgw+5iqN52LSc9iTWUCVpTgo
	 7xTzNWo4EruBhJ3F5vkGdZjlf6OKMjvkwXZgOSogTbMVeoB6XyxgyZJzpqXp8w0C2r
	 TG+unwqY/C+cKNxpOOw+QwYblp7q/nA2OfOSEto5bvxQo9mG+kCcFrYoH4IOQIQXy5
	 QjiI/Lkt2/iBW8/l0OVCjFoaN3ckR6u72XmkLJ9ndPIiQwKhRPGvR8nVxdDUh+0WJe
	 fYNr/7TqXx5/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B270DC59A4C;
	Fri,  8 Mar 2024 12:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989983372.7796.11570830400912357021.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 12:10:33 +0000
References: <20240307010115.3054770-1-shaojijie@huawei.com>
In-Reply-To: <20240307010115.3054770-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Mar 2024 09:01:07 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Hao Lan (2):
>   net: hns3: add new 200G link modes for hisilicon device
>   net: hns3: Disable SerDes serial loopback for HiLink H60
> 
> Jian Shen (1):
>   net: hns3: add checking for vf id of mailbox
> 
> [...]

Here is the summary with links:
  - [net,1/8] net: hns3: fix wrong judgment condition issue
    https://git.kernel.org/netdev/net-next/c/07a1d6dc90ba
  - [net,2/8] net: hns3: add new 200G link modes for hisilicon device
    https://git.kernel.org/netdev/net-next/c/dd1f65f0db27
  - [net,3/8] net: hns3: Disable SerDes serial loopback for HiLink H60
    https://git.kernel.org/netdev/net-next/c/0448825b8992
  - [net,4/8] net: hns3: fix kernel crash when 1588 is received on HIP08 devices
    https://git.kernel.org/netdev/net-next/c/0fbcf2366ba9
  - [net,5/8] net: hns3: fix delete tc fail issue
    https://git.kernel.org/netdev/net-next/c/03f92287b251
  - [net,6/8] net: hns3: fix reset timeout under full functions and queues
    https://git.kernel.org/netdev/net-next/c/216bc415d663
  - [net,7/8] net: hns3: fix port duplex configure error in IMP reset
    https://git.kernel.org/netdev/net-next/c/11d80f79dd9f
  - [net,8/8] net: hns3: add checking for vf id of mailbox
    https://git.kernel.org/netdev/net-next/c/4e2969a0d6a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



