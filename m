Return-Path: <linux-kernel+bounces-92402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800C871FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2738E1F228FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20828592D;
	Tue,  5 Mar 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0XBjqkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48FC85646;
	Tue,  5 Mar 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643629; cv=none; b=mKETdcAfTKHL5Ychoy9bVF0lpoTAppGXTrofd75ZgL1b1l0arudWJIgHbuQ5/cN3vFkRX24mjUOcVHCFgDW6iRWElubJ5m1LCpIfJvYymGTv9aCsXRblFv8kE2mdQ+KylsFSAoNGbADo7YJzcMPyyHZhavhHOcTNEnaOKAYgQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643629; c=relaxed/simple;
	bh=bW8VA1hPTbT+2UWxQ6dly2B57VPJtolxx4N9o7OJbEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMTW09jhQ0OvQdER8UpNz2YtZS3NNfw2N38sisc3p7jhS7Z+yvYXxnptQJZuvd32K2VxVsGD7C+7dE6J9pEzgKjHpmzLYxYXJBtDabHgOv+w4drDsOLz73q45jPvlR7HyoASOTTd+2B3QHrW6P2hQ2GzfXkXIZj0nqYzbRw8WKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0XBjqkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A6CBC43390;
	Tue,  5 Mar 2024 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709643628;
	bh=bW8VA1hPTbT+2UWxQ6dly2B57VPJtolxx4N9o7OJbEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T0XBjqkjJGOQR2eY3U5mPXny+NfDMoq1hgRfoYPrDncj3YJv7d2EOJjItCFvc+tV6
	 Hcz8qbzbSXVOlBgfSimKqxZMZUUdzSoR5AANdSmre5X4JaCFdxc2v89kE+HQlbu79K
	 QHexIVXE6l8dF5525ZVoj0A4ObNtHQxPnJN2TCfA/BOD7tVjaPZl2SlgFaWcIv+XdQ
	 oSe3bSMVxulElnfy3LIQ1gkKY3UxRSm21o59N6fD4p1xJ/qWBvcejym0KjwaapUc2g
	 fH0M1Qgnpmlt/xhkYKUlZ7s1WJ15LwDQy4tHQqAh4zS8S50/W10OSjOP9taBSRY0p0
	 x2Semx9WdTJoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B39AD88F80;
	Tue,  5 Mar 2024 13:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit for
 userspace tstamp packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170964362829.14881.16498394122765030954.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 13:00:28 +0000
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
In-Reply-To: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ahalaney@redhat.com, willemdebruijn.kernel@gmail.com, martin.lau@kernel.org,
 martin.lau@linux.dev, kernel@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Mar 2024 12:13:48 -0800 you wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Setting the same bit (mono_delivery_time) to avoid dropping of
> userspace tstamp packets in the forwarding path.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: Re-use and set mono_delivery_time bit for userspace tstamp packets
    https://git.kernel.org/netdev/net-next/c/885c36e59f46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



