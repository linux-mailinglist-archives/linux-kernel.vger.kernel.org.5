Return-Path: <linux-kernel+bounces-96516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2E875D63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD1283B76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F25364AB;
	Fri,  8 Mar 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ4UHALW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5F2E62E;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874037; cv=none; b=GMyftP6HchxK3hHxkugUkEg2PyftzPKZWk3imo8dXAITpXRCwLBvXA9dbAVpNEKZyP47CvLV8Y4BfinNw6lAEoZ8xUl5wT2/vBA2aNT0CsVLvzaPPQPmsMxi08TKGCZSbpdTaVqFswlJf52JlIL8XCgNtiNcCTECVph+XcRHL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874037; c=relaxed/simple;
	bh=WA0EbcjTQ2kZ9bSX3gzTKKJ6hu/IcpExjVbEu2Ldmj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LTj6KDtGts3EWwHTsB84Rb3cNis+tenBuoNjTaZn6jn6iLemrMYNpcDxqlcRebflrdpGT/esNn/oUBFlD2rqcNe0ELDyra3CHdZYbohPCEVHU6G78NP5HHr4Qhrhk5twp9nIeAugMxSxhuGDdCJnAUBFE7PUFbMy2DZJbiu3+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ4UHALW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D601C43330;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=WA0EbcjTQ2kZ9bSX3gzTKKJ6hu/IcpExjVbEu2Ldmj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LQ4UHALWKMjrBhP3brHe5JoAEMdg/0aGbgHgTWfhchv+leR8oMCwX9ng6GaxUDItx
	 ffxcbmxzKE1TaqdB9RSUEj2XlF2Y0cJKI5PcXhVJZ/DRJm7xM+NVeTRbwxS2bEv20o
	 SURMKNRYNwOoQpHQ2u74NGRad8OG13PeuZpQ4/rXwEQlyc7kZ1Yl2nhisBj2HyjxtQ
	 YM6wK+KFliIfV4gw2CaWcE+5tO6CJmq/c4YYqq3XYMvZbiCSlxKzQI8OB/EQckTHOo
	 rLkjA4jh0f6gdDNisQllFvTBPHMH5hyXN7j7UFYffXqNe9kpFTJ/2D7rDLbECqcAOq
	 XQkT8ZEOr7CaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6ACC2D84BDB;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: usbnet: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403743.8362.3592086830203514705.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306142643.2429409-1-leitao@debian.org>
In-Reply-To: <20240306142643.2429409-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: oneukum@suse.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org,
 linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 06:26:41 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: usbnet: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/352f5b328262
  - [net-next,2/2] net: usbnet: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/9cb3d523c153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



