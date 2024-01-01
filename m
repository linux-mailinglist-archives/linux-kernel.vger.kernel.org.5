Return-Path: <linux-kernel+bounces-13935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB682150E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2427DB20D96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3FD53E;
	Mon,  1 Jan 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP80M3Gc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99516D518;
	Mon,  1 Jan 2024 18:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CA95C433C9;
	Mon,  1 Jan 2024 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704135025;
	bh=tNAOyRlPyWYfL2woErnEVinNMnSj3M5MzgVb841uGuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RP80M3GcYoEwL3Ug/6yYK22c8/hROKFTlIXFvVnNGfYBwwdM/DiA4yvB2keuyZQXv
	 2ZG8hZ2dCwut+O4CU7+NXAk6fE9DBU4Xi9i0FZsa2G1sTJFDk+kMHvyTdCS5sMosYJ
	 CP18XcyjnOj8jJL38zdEYa86ALF6lDfTmfqGMO4JZpXIwzMTHyQ7zfOcCbDMAWPTP7
	 vD/vnoiVK4pSWFI325rayywIORkjgAeXH09uEAZ6zshlr+7oPi3Jy3F0cNjHnEpZdh
	 vKSXdnKQ8b8/II7X5FA7CkvFq+itgOzBal4ox1t93b6Ie8lykChTScDiNbLMUha3Od
	 8Uh8s8p/HTTiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD1E1DCB6CE;
	Mon,  1 Jan 2024 18:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V1] net: qrtr: ns: Return 0 if server port is not present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170413502489.3024.3003051103450855800.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 18:50:24 +0000
References: <1703153211-3717-2-git-send-email-quic_sarannya@quicinc.com>
In-Reply-To: <1703153211-3717-2-git-send-email-quic_sarannya@quicinc.com>
To: Sarannya S <quic_sarannya@quicinc.com>
Cc: quic_bjorande@quicinc.com, bjorn.andersson@kernel.org,
 andersson@kernel.org, quic_clew@quicinc.com, mathieu.poirier@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, mani@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 15:36:51 +0530 you wrote:
> When a 'DEL_CLIENT' message is received from the remote, the corresponding
> server port gets deleted. A DEL_SERVER message is then announced for this
> server. As part of handling the subsequent DEL_SERVER message, the name-
> server attempts to delete the server port which results in a '-ENOENT' error.
> The return value from server_del() is then propagated back to qrtr_ns_worker,
> causing excessive error prints.
> To address this, return 0 from control_cmd_del_server() without checking the
> return value of server_del(), since the above scenario is not an error case
> and hence server_del() doesn't have any other error return value.
> 
> [...]

Here is the summary with links:
  - [V1] net: qrtr: ns: Return 0 if server port is not present
    https://git.kernel.org/netdev/net/c/9bf2e9165f90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



