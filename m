Return-Path: <linux-kernel+bounces-86665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A69B86C8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B1D28D719
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8454E7CF1B;
	Thu, 29 Feb 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivv9Shvq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84687B3F1;
	Thu, 29 Feb 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208028; cv=none; b=rBb2txMHOT3lB7vV70TNh7UjsOcQgt0uLZGRbKSXEt6XRggcY/KOT3IImLGEGy4+RhpKziT/iWkHUblXXKfD3YYekyCVnzXbskpksAoEbufg3BwAO9YSjIXsZxYTGW1879cg/+BOmq2aLjiht0XuPvTzOyy+8hPBB7tzO8vlTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208028; c=relaxed/simple;
	bh=q49JbN4TAIqIV4Qx0uP5Ypy+NDIElGE//CuKZtTRS6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ERim1Fg4msUVyzqHsO0c9MyH7tYblYRLy61rqUDb4vkuj0WdFki21jOsF8/LHRSNlOzhVcOvcAYIOiCCvr1ZIChIIugnbCnYo4YCooHp+1qst9ujL2M/99K/93CptEZe+REs0pwNjqZ8W0oT7pi/NwctMfX/EU1FZ9i7AIaxuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivv9Shvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83221C433C7;
	Thu, 29 Feb 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709208028;
	bh=q49JbN4TAIqIV4Qx0uP5Ypy+NDIElGE//CuKZtTRS6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ivv9ShvqCyG/ZfMwenMSPA27IcHoWSVzulBB3qMqhKoYxdIh5qNhc/TjCnwvb8nFp
	 Ij5IveBnHh5n423ECOG+8/eYuJQ+xQ0xiNHJ3wYqyW3n0DXNzJxqxSmkK3+Xq2ekos
	 TEaWN/ARDWjWK5W2D875AZfP1qOc/GRnzAGE4x0uPc72bSGh7KkoowQgy0xnlnsIsN
	 ZL3Z189e84kNAGweyo2XPwaPBoZf36AHfO34R4bI2omRXV6GfR2OPCx4rLmXXVm2x4
	 zceonPj7bh2otgwD39RNTHB60dW/14SW+IY5fo6x3xlQ1HlBHxzJRNonRzzARUK3kh
	 rXenToAnssT7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69E59C595D2;
	Thu, 29 Feb 2024 12:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: collect tstats automatically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170920802843.21514.7752530376223154452.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 12:00:28 +0000
References: <20240228113125.3473685-1-leitao@debian.org>
In-Reply-To: <20240228113125.3473685-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Feb 2024 03:31:20 -0800 you wrote:
> The commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf") added a field in struct_netdevice, which tells what
> type of statistics the driver supports.
> 
> That field is used primarily to allocate stats structures automatically,
> but, it also could leveraged to simplify the drivers even further, such
> as, if the driver relies in the default stats collection, then it
> doesn't need to assign to .ndo_get_stats64. That means that drivers only
> assign functions to .ndo_get_stats64 if they are using something
> special.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: get stats64 if device if driver is configured
    https://git.kernel.org/netdev/net-next/c/3e2f544dd8a3
  - [net-next,2/2] net: sit: Do not set .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/fa0cd9021369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



