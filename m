Return-Path: <linux-kernel+bounces-99643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B2878B59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65151C216A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC215A104;
	Mon, 11 Mar 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp3bUp6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C058AC4;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198033; cv=none; b=nzxEq4/dsKlDYWvdQOaOTEdY1ze9SlsjyZoSbbn4un9KjTcbXaB80H5qgpY28PTo4TTzXX2HoiOVpwwZXc9Sk+jQoN9NJ61kR6uHXxywKQBuwyjChEj2Y9k8i24IXGZSHqHEvByyTCL0w+roMikOPI8pSqe+j3PFem0xRwrFI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198033; c=relaxed/simple;
	bh=MJhjs1uYIvjVQPZgooTTazwf3Y8z1r7kEX6jxxCMOSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LSLB6ZMZvuPQRE6epuaUoToDGUruA2Dg0ImWgoLb3gp9cy2IOe0VM5Gx3ey+VwVS1zEHC2M4GT/mm6DRyp1sBeRueUIqdnk7UtzCjR4RxDJClNtN4MoN4XQkkU0SOOQ+8NZabpql7qVXdOuoMgQRPzwAg0zaThLnKk2sx9RwFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp3bUp6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F44EC43609;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198033;
	bh=MJhjs1uYIvjVQPZgooTTazwf3Y8z1r7kEX6jxxCMOSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pp3bUp6RFMXtCQ8d/77/R6jNgBasmrVQ9UI4SLyQJMzFErnS+21WJPQAkxGwL2duc
	 nR+LdYguDl+bc9APg1J9UVHv0ad515zv74zByDKlqTn4hX5ns7vRPpi/tN9B0Ey42K
	 5suA/QJJ96PcP7bmL7sUyRksKekhoKZl+IBig7uXRtRFaBCJDaoOYRDOwYBOZczR/p
	 NMQy1CnwGeER6fLjcpEFrZnuS0J7NMhtGteWkIUrQc0Zw4EeubufJuEo2ruqaFy0ID
	 XHdFKWDG8OwhuAfV1fADuK+XRf/O1YVvUby3UEyMc++24ZtdhGxAwj7JJfZfi0ZYyB
	 nnu3gfobPlJIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07F9BC395F1;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/netlink: Add getsockopt support for
 NETLINK_LISTEN_ALL_NSID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019803301.14238.2701981454364061727.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:00:33 +0000
References: <AM6PR03MB58482322B7B335308DA56FE599272@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58482322B7B335308DA56FE599272@AM6PR03MB5848.eurprd03.prod.outlook.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Liam.Howlett@oracle.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 11:33:04 +0000 you wrote:
> Currently getsockopt does not support NETLINK_LISTEN_ALL_NSID,
> and we are unable to get the value of NETLINK_LISTEN_ALL_NSID
> socket option through getsockopt.
> 
> This patch adds getsockopt support for NETLINK_LISTEN_ALL_NSID.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/netlink: Add getsockopt support for NETLINK_LISTEN_ALL_NSID
    https://git.kernel.org/netdev/net-next/c/8b6d307f4391

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



