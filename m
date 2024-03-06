Return-Path: <linux-kernel+bounces-93909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A88736BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30D81F24649
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A612F5B3;
	Wed,  6 Mar 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bworAEkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282486633;
	Wed,  6 Mar 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728829; cv=none; b=E8XNL9i7se+RYm+XdcODISXu9Bg6oUWsJ7MWqpDYmWYsUgxCRUHlF2NOIPlBrtsCi5bUIDpkmHemJB1I9cJRnNcAZvBYPorLPRKJ5KZNwHcUELkIVzJ2PDiE/vHo3hirzu4AM8XUalFflobYANW2E1U1FuTWp0XCtMohKH9SVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728829; c=relaxed/simple;
	bh=g3BKsu3A8I4zQ5AK6i9ooRpsNeTmkxra2SuLOmdl+UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stazsSYxBI9Kt/SEDlkSUEtjEafYcKHqyr7PxKV4u1A4UeARGzWUCV+j1xeUGd5al3udEvzdsrpyGRxi70MtNcrbQiyJ0H4L59uRURwLQpVwzrG41ywpZltM3Gmm2Anq6u7TN0/nxDSLwK5ehp8zD4uqhErFzZ1yDue1+snwM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bworAEkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4F48C43390;
	Wed,  6 Mar 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709728828;
	bh=g3BKsu3A8I4zQ5AK6i9ooRpsNeTmkxra2SuLOmdl+UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bworAEkhUCWGgacAY8RBxwT6Rlql0b78VMcHsF27UAtCwEHxYUQMEuPs6kTIepqfJ
	 IkMAoBESsmii7HHl8L8OqFg1EGfV5+YTVCi6bHkLoqms+e0YOFkuSPhG9bGxoMOulT
	 1hOQyYtBm9lTbPgDpZlTcPUd5J1wRphrLOmtLeuXPXwLDdRyHPlcpCxSRjQvEftB85
	 //jeqgU/MOyOAL8o8Ggj879Mf0a9vJRwQFB6/z29SlwvvzSHvd0uoXUKRS6YArbdhH
	 EImKl5fAgLtlyWZ0fUem9Y1gd40LNiamBDI6XwOGUtHZ4bFzwse/+1O2/Ft8u/ApKI
	 +txoIOjdkh2lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87455D9A4B6;
	Wed,  6 Mar 2024 12:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] inet: Add getsockopt support for IP_ROUTER_ALERT and
 IPV6_ROUTER_ALERT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972882854.29343.17973496217213713170.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 12:40:28 +0000
References: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  4 Mar 2024 11:32:08 +0000 you wrote:
> Currently getsockopt does not support IP_ROUTER_ALERT and
> IPV6_ROUTER_ALERT, and we are unable to get the values of these two
> socket options through getsockopt.
> 
> This patch adds getsockopt support for IP_ROUTER_ALERT and
> IPV6_ROUTER_ALERT.
> 
> [...]

Here is the summary with links:
  - inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
    https://git.kernel.org/netdev/net-next/c/eeb78df4063c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



