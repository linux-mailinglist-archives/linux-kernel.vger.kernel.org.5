Return-Path: <linux-kernel+bounces-30117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F6831978
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021051C22184
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2725615;
	Thu, 18 Jan 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGEyRHDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839B24B5D;
	Thu, 18 Jan 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582227; cv=none; b=DyzkPZcAoNxVLRK+uzn+E5DLUj/hIdhcUWeELlF9J34EXmb9JlPjvM1Gx65zaqFQ7l6CdnEEq/45BxJwEhOQdnCmia3fVtlkSMY3Oyy8dwtj+373sZDksGSjbPz2xWkA1T7P8nggkMy+NXbIAW4NjXad0aKXDUfys1fA2hz/edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582227; c=relaxed/simple;
	bh=qb1dZ4K0a29IpN70tcPu2Vue3jv8YqOaCjybCRHAIGE=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTS9FpPw+GCVYES9pYi+PafXSkSaL7zEnF3WO7KfAro+vB35mB0LaZAo4XvDAhaORGG2l7u3DlpydJNutN03tx3zn7YqzdFSRY74bS1MTsMhCmrm0wEFqd7jecosHhwSZd/lGR8E9MSdaO6qtn9n+AYw1LP/J4ZH8+LGrzFfYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGEyRHDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 040A3C433F1;
	Thu, 18 Jan 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705582227;
	bh=qb1dZ4K0a29IpN70tcPu2Vue3jv8YqOaCjybCRHAIGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RGEyRHDRZk1K7xTakgXzrmNrdwLI8QeS3bNIxCwgsKSnimEb/nIN9z8IOR+nE0Xmq
	 TTf3Pi/nfVK6L24On5b9Uxq49SP57vFQ+uPBp/5ufUJIAFR/KkXpMv5JlvWktNJmbI
	 5ZlWjQYs6CMwZGvL53B927dJc8yDeqYn7bJGZn6bOAX7jGQ82OaWee560c8xJ3X5W/
	 lNSFS98Cp0mq6TVX9dgRt+UAnvF4jn0jawF6Kw/AQkAiq3sq5qc+/9Vj7cpdh0nMN7
	 pCxOufaDwFdVVKD9cDeLewu3aNaN+2Ey7FxBiUr1B2kpUCxnxj16rkluAvXshxsmWu
	 jyuPDn37ZV4OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE9CAD8C970;
	Thu, 18 Jan 2024 12:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ethtool: netlink: Add missing
 ethnl_ops_begin/complete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170558222690.25241.16310115715533533049.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 12:50:26 +0000
References: <20240117-etht2-v2-1-1a96b6e8c650@axis.com>
In-Reply-To: <20240117-etht2-v2-1-1a96b6e8c650@axis.com>
To: =?utf-8?q?Ludvig_P=C3=A4rsson_=3Cludvig=2Eparsson=40axis=2Ecom=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@axis.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Jan 2024 13:03:14 +0100 you wrote:
> Accessing an ethernet device that is powered off or clock gated might
> cause the CPU to hang. Add ethnl_ops_begin/complete in
> ethnl_set_features() to protect against this.
> 
> Fixes: 0980bfcd6954 ("ethtool: set netdev features with FEATURES_SET request")
> Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] ethtool: netlink: Add missing ethnl_ops_begin/complete
    https://git.kernel.org/netdev/net/c/f1172f3ee3a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



