Return-Path: <linux-kernel+bounces-125365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7189249F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E66284054
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547813BC18;
	Fri, 29 Mar 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwDnc+tG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3A13B7B2;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741830; cv=none; b=gomgTfXsyaM5pG8eCCKkUEf7qGBE4YPIltFEoJSH1ZX7rTz7AXGehyveRlbPnezFg5zh6p9qeslRvGdEEr+xkraVJUMY7hDZvy0qpeAR/MBAByY7ljljC7E8Hl+yDqwVld2vXe9U5dvuSBw1xetY8fz2u2kKmrTAMaEvDmvnHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741830; c=relaxed/simple;
	bh=5RFEE635tCZOhUy480Jg2Pz41y6VeKLDLHqSay92G/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNvwi7o0h/0Kzg4Bl/ipLk4Pk+1HaxY6BpkDiItOknzdAnrBL4rmlFnFXmHOnDIQf3RdhC9h5MyktHp3shLpO5sbJ//X///farOEZsnZkcoXuunDWSW5Hzsn9hwTjLICwR7vk6fF/TfAGEJb4/PPmRahx61TUiCau9oONrsR6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwDnc+tG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D2AC433B1;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741829;
	bh=5RFEE635tCZOhUy480Jg2Pz41y6VeKLDLHqSay92G/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GwDnc+tGeA21e2mTpu/mZV+524jTDJ1Zv/7vys29FH46q6KM3BHbLVzgX2/9uRSY+
	 OhY11nft96ss2njr7JFiT2RDUUCbHMaVHGVFgBQO6OEs0UlCeZ6OatZav/M6MUwC06
	 i+Ag8xDIpPuMgI41foyfuuxGQ9+kwBu61I1Auros2hrWASjAvbUbCPeYGwRa9yHt/w
	 CT3WAt0L6cXNKl4dq/pO5qhBLfu8r5JAHlQza1RO7VAXPIW41bw7kmBOONGqWkCMyj
	 bq02nbnCos79yGERKPEqBEzLOELNL81H+OkZ0AK6wfKT9a0frvy47TZZhPRNvFWtsW
	 h/nSbrVi31bAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A47DFD2D0EE;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: axienet: Fix kernel doc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174182967.31276.5464021814313935553.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:50:29 +0000
References: <20240328110713.12885-1-suraj.gupta2@amd.com>
In-Reply-To: <20240328110713.12885-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 16:37:13 +0530 you wrote:
> Add description of mdio enable, mdio disable and mdio wait functions.
> Add description of skb pointer in axidma_bd data structure.
> Remove 'phy_node' description in axienet local data structure since
> it is not a valid struct member.
> Correct description of struct axienet_option.
> 
> Fix below kernel-doc warnings in drivers/net/ethernet/xilinx/:
> 1) xilinx_axienet_mdio.c:1: warning: no structured comments found
> 2) xilinx_axienet.h:379: warning: Function parameter or struct member
> 'skb' not described in 'axidma_bd'
> 3) xilinx_axienet.h:538: warning: Excess struct member 'phy_node'
> description in 'axienet_local'
> 4) xilinx_axienet.h:1002: warning: expecting prototype for struct
> axiethernet_option. Prototype was for struct axienet_option instead
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: axienet: Fix kernel doc warnings
    https://git.kernel.org/netdev/net-next/c/06c2a5cd48fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



