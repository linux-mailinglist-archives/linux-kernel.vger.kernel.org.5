Return-Path: <linux-kernel+bounces-116908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61B88A500
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B302E12AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45817BB0E;
	Mon, 25 Mar 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1ULB8lf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3001BA68B;
	Mon, 25 Mar 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365029; cv=none; b=I5yUBbyF5k/Rt5FzfOlJqDtXk0qTo8ggStUMa3FKBFfG3T3eS9TuJ2ToH+bwVB4w7HcOqGxGDltrwjv8tW+Am8kocpBa9g8mwu4vEUwzAfBzLBpFNmZfdcdeYAJOdoHEIuaQJEXZ9E5ixGLsFJRfkeJuTgjod8Wgp0MwJQeai3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365029; c=relaxed/simple;
	bh=NgOnL1mRyt3iDu7+ZEL6Xng2LeHcYmj6Fkapt5D4cmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mL2q2GJlXBt2FMOtr9Qs5kGPKL9VlGjOwm02yNyzPojXT8uYO/meTnijPgKBYbiBMpacHHnuHG1tumjyHEIOGVJZ+LRCyCFUePEHLwSEQMWAYum/9BkWbUIVGfLzNdHZgX6d7GhlgHFIpYocG89dRZAibVi951O0yKq02LRjxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1ULB8lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33212C433F1;
	Mon, 25 Mar 2024 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365028;
	bh=NgOnL1mRyt3iDu7+ZEL6Xng2LeHcYmj6Fkapt5D4cmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c1ULB8lfM8A6XDYAUs2TOqysJkA4Gv+JnScDhP4Ig2LWopwsvnY2XZxXoCQ1cpM++
	 R7QE3vD3DxURSAPNobA4g+8tan87sJvXZRJ4jQRAbCJmjrz23xbCrD9n+YqfJGhSe4
	 /mdJ3j64inUahKMCOyZzwNpm4yrwfGY5WaZN4o+uds4Lc+iY/pAmfXdr7rllhtyyi3
	 5SMSPKMjNCwCVzoMM2IHnUHa/Hv5fAUzOaATu0N0KeB5DPubXiPBSBH3VFPP4ha91V
	 12EgahOI5jFQ7FnRmeZXBakjpi6sqbZpcuxyIq6nxs1JwizhF+gFzCrNCmzaUybvyJ
	 NZNyAFbMXFDig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2282FD2D0EE;
	Mon, 25 Mar 2024 11:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] mlxbf_gige: stop PHY during open() error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171136502813.18794.12152488546311342790.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 11:10:28 +0000
References: <20240320193117.3232-1-davthompson@nvidia.com>
In-Reply-To: <20240320193117.3232-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
 asmaa@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Mar 2024 15:31:17 -0400 you wrote:
> The mlxbf_gige_open() routine starts the PHY as part of normal
> initialization.  The mlxbf_gige_open() routine must stop the
> PHY during its error paths.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,v1] mlxbf_gige: stop PHY during open() error paths
    https://git.kernel.org/netdev/net/c/d6c30c5a168f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



