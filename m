Return-Path: <linux-kernel+bounces-108806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7D881043
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1801C2217A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3FC3A1B7;
	Wed, 20 Mar 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0DN0sPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3129CEB;
	Wed, 20 Mar 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931829; cv=none; b=mYdYday9QIx9bxukESpFycLFHgCmr5iDzhAzxx0uc7HOvY39yN3bQ5r/wY15BUrQOVp2gCGYTNfOK03FstmTudgoM+0c5/MmNJ/VCy1k1XQy5XcOs73IIEHNX9Ly6ifXb8pIYypKT9zlz2+W7eo8SCRlGhOHb3B62/oVmmpGbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931829; c=relaxed/simple;
	bh=33eYdkLv+vFOfzW7fW+bW6YTvn0TxW/yQv61af3+pCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SdlUv5HWw5OpE73JoLwlGBXQ0dq5lXZwnCXQpSwbmUcTvfUzXgoNSbCnj72ow4X3YaLOLJBlpcxVpn6Ei6IGCIU2ttK7JGiH2MBY6K9XMQ4JSksO0dE7mMDBp45QgWDqktrPMdpD98af8qM+/lud6i8Qo/j7jSpI3jYaFG1IRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0DN0sPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56951C433C7;
	Wed, 20 Mar 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710931829;
	bh=33eYdkLv+vFOfzW7fW+bW6YTvn0TxW/yQv61af3+pCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G0DN0sPidV9DZaSKasMn2t9y3aA7tTejW/wV3BwaYb9BrHSudtxiWh94qn4zC/0oy
	 QwCF5y7d0t+j8mxolVgaBrtn2z2yrvOvR4LNRmnyjFOJdlqZ6cQHVNnSRoViVO12wg
	 xbgKQ2mEl+BT/Z+KaxgpkRuLCTGmfIfegZgcQipyl1jZ7o/OadfScNl/OL7b7N3gsZ
	 Gb8QrZ3afXE0yjcmphzsy+ZjeqvRjysEHEq2LmbFRCB5WfXXn2saOzm/xA4eqaIOB0
	 kcKDoKhRkXAZWnDogvSmwHV9K0pTZMW32nTq20E20xIq71vYmDP5inTBbiKFAwB2Xx
	 Lt0rYsO6esHkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45E89D95060;
	Wed, 20 Mar 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2 net PATCH 0/5] octeontx2-pf: RVU Mailbox fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171093182928.6411.11540341489392829464.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 10:50:29 +0000
References: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, naveenm@marvell.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Mar 2024 14:59:53 +0530 you wrote:
> This patchset fixes the problems related to RVU mailbox.
> During long run tests some times VF commands like setting
> MTU or toggling interface fails because VF mailbox is timedout
> waiting for response from PF.
> 
> Below are the fixes
> Patch 1: There are two types of messages in RVU mailbox namely up and down
> messages. Down messages are synchronous messages where a PF/VF sends
> a message to AF and AF replies back with response. UP messages are
> notifications and are asynchronous like AF sending link events to
> PF. When VF sends a down message to PF, PF forwards to AF and sends
> the response from AF back to VF. PF has to forward VF messages since
> there is no path in hardware for VF to send directly to AF.
> There is one mailbox interrupt from AF to PF when raised could mean
> two scenarios one is where AF sending reply to PF for a down message
> sent by PF and another one is AF sending up message asynchronously
> when link changed for that PF. Receiving the up message interrupt while
> PF is in middle of forwarding down message causes mailbox errors.
> Fix this by receiver detecting the type of message from the mbox data register
> set by sender.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/5] octeontx2: Detect the mbox up or down message via register
    https://git.kernel.org/netdev/net/c/a88e0f936ba9
  - [v2,net,2/5] octeontx2-pf: Wait till detach_resources msg is complete
    https://git.kernel.org/netdev/net/c/cbf2f24939a5
  - [v2,net,3/5] octeontx2-pf: Use default max_active works instead of one
    https://git.kernel.org/netdev/net/c/7558ce0d974c
  - [v2,net,4/5] octeontx2-pf: Send UP messages to VF only when VF is up.
    https://git.kernel.org/netdev/net/c/dfcf6355f53b
  - [v2,net,5/5] octeontx2-af: Use separate handlers for interrupts
    https://git.kernel.org/netdev/net/c/50e60de381c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



