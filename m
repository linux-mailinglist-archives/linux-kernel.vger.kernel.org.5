Return-Path: <linux-kernel+bounces-109652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517B881BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0149283509
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F9374D9;
	Thu, 21 Mar 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+zbZA2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E046FBF;
	Thu, 21 Mar 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996028; cv=none; b=Rnu8GrJcvaS8M+KuapW45OW3yHwIlvvydVFnbQsXad60/84DnLFFLdZ1b3K+IrVnV23no39+EiwGHJmWdPH12l+qzKcoRfW4ZTdfRhaI/kwhA9PbF3ipZNJA7QnPBLXc3UhdfB4Jw5dxDZCRFdmMIpkUSFsOIEv2Z9eTsGks7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996028; c=relaxed/simple;
	bh=Stz/LtxZ0oNUWGPAkL2Gm2OiNn6QXW8wUeEfkZyKsoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZPFDJnWVY65/wDXyFkQTCQmIEw2jlxOCflq2EiRewrclWCkNls8fBgpmsB0mcr1qDPCNXyID4+HQQBZ47Mwi82wTPAiJwb8vY/sIUh8J2gja5FPEsZhN3SJstJHKolAom8lIU51k3CxNkq2plVeBllDdZ1OTejjWGUH7anp7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+zbZA2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 032DBC433F1;
	Thu, 21 Mar 2024 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710996028;
	bh=Stz/LtxZ0oNUWGPAkL2Gm2OiNn6QXW8wUeEfkZyKsoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O+zbZA2pqkmYFD/+/+lpoOlvB35mFNlw9t+ZWFMewtPpQMLzIXXtiMjV77SIowIQJ
	 52zBlYz3bQbRL2I0vYZbVkDofZ477Pzs/ymzi2XUB/UKMrXA+dxoM+DINL/ZefSwSF
	 sIT4pHnAIV6csAHBZEYfWIhpXhBTGe1SpFMuD1uoSWheIxSK/oKUxtYAduNylxNiDK
	 VNWH6cUQfZCMTF2lZrxO5goILCMy14m4Q4DFy4D22LCQdzpjerGYwSTg5bHff8SzfY
	 HZWbPCDmZWrfV49pEn06fnBOaPcdTCPozuSbw6tXeQtMJB7jio9FmRTFYPuYY+0TUM
	 poAoYMWUGqFMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5818D982E3;
	Thu, 21 Mar 2024 04:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 0/3] Report RCU QS for busy network kthreads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171099602793.26207.3374009714899466289.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 04:40:27 +0000
References: <cover.1710877680.git.yan@cloudflare.com>
In-Reply-To: <cover.1710877680.git.yan@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org,
 daniel@iogearbox.net, lorenzo@kernel.org, lixiaoyan@google.com,
 weiwan@google.com, alexanderduyck@fb.com, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com,
 joel@joelfernandes.org, paulmck@kernel.org, toke@redhat.com,
 alexei.starovoitov@gmail.com, rostedt@goodmis.org, mark.rutland@arm.com,
 hawk@kernel.org, bigeasy@linutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Mar 2024 13:44:30 -0700 you wrote:
> This changeset fixes a common problem for busy networking kthreads.
> These threads, e.g. NAPI threads, typically will do:
> 
> * polling a batch of packets
> * if there are more work, call cond_resched() to allow scheduling
> * continue to poll more packets when rx queue is not empty
> 
> [...]

Here is the summary with links:
  - [v5,net,1/3] rcu: add a helper to report consolidated flavor QS
    https://git.kernel.org/netdev/net/c/1a77557d48cf
  - [v5,net,2/3] net: report RCU QS on threaded NAPI repolling
    https://git.kernel.org/netdev/net/c/d6dbbb11247c
  - [v5,net,3/3] bpf: report RCU QS in cpumap kthread
    https://git.kernel.org/netdev/net/c/00bf63122459

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



