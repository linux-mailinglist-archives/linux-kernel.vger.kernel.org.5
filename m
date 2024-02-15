Return-Path: <linux-kernel+bounces-66890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB46F856334
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D081C2328B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200C12D752;
	Thu, 15 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLUX6j8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DBB677;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000229; cv=none; b=JIlcYrrpE4AhrFp2wbOIVpTjmbKWsaN0cHU2FOHtRMkdMe81sAYcg3TXwosAu0+vyudOv7UUQ5ctvdMg/ogW+o3M7hT5ukCIULBX2NxE1TH1VPnPydyOB9hqBSfQQaF7DPUgg0zFYw+crFOLIxhFkY03omoq1mRX333srvLXs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000229; c=relaxed/simple;
	bh=PBX+WQHp+/iULpXauu1HGRtdZ9hPDD1gMJhwZQ3aIVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BdBxeQEp/zeCyott1XDNOE6F4gxDfgxpQOI9oE/lsXhleuhMQrL0gZIELNd9qNNTNco3EgkJYjU5mUsAKlqHV7E1dbxiCLKdfONQrH8Xcwnot41vSivKkobLkRhY1j7wRyD4sGPaPSP0oeviwIaL15wCLzC59bjoWb3i8aIYqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLUX6j8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9724AC43394;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000228;
	bh=PBX+WQHp+/iULpXauu1HGRtdZ9hPDD1gMJhwZQ3aIVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLUX6j8O4Rlhu6yhQhkSJTVNNMAZbrQqb+ib+bw9kit2AiA7G1h6biCp7E9w5AR7L
	 HifIBfbwB2RTcsj6lyrWoHrZv8Db62JMlPgcECViQE/CWiEC3mYToFERHwbhj2hd4a
	 Xum6VZLA+O01e9MkBGCwH4OGzkf+g4FfGgNLj3GbcMGpEYZxxD+D1zbpblRnISV1K5
	 faXXNRzhx+2P5pWoy7SzS5uhIYE1TjrM6T2KX7RwyX50klkRKTkSSPycjWpbFR6ZsM
	 JqV+7Sxh34z9iIZXPMtkX+8eaHW2SXm5RNGjT0hVstRPAKoe4oLbnUUjY37p4dj3eT
	 9AdX64XU798Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D5CCDC9A04;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: Cleanup tipc_nl_bearer_add() error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170800022850.10978.851178546042569087.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:30:28 +0000
References: <20240213134058.386123-1-syoshida@redhat.com>
In-Reply-To: <20240213134058.386123-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 22:40:58 +0900 you wrote:
> Consolidate the error paths of tipc_nl_bearer_add() under the common label
> if the function holds rtnl_lock.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/tipc/bearer.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] tipc: Cleanup tipc_nl_bearer_add() error paths
    https://git.kernel.org/netdev/net-next/c/984328c7657d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



