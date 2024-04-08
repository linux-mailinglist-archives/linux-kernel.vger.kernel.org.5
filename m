Return-Path: <linux-kernel+bounces-135518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B371789C714
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB0EB21D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E2131BC7;
	Mon,  8 Apr 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8LB4WOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74C130AED;
	Mon,  8 Apr 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586627; cv=none; b=XbuD+REPW6Ku9rTVquAf2BXfS0JtVUtV1gtRsDNovWqlV01nrYelqw2qNyTrAoct8y+LyFRDD9U3HJhTfLjlq9I1VJVX2653gde2V9aDo2AfGMD/wKgD2gA4TqzZ0NW22yi7JyltTAyzHsIg3tm8CerATqzqELnhaG+S8B7cxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586627; c=relaxed/simple;
	bh=Alfp2ELwhITazKMEegUqvVbJyfZKJCbUEoIYjFPYgmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bmTgg2tKgf0tuqkOiLlM99Y8x78iIOXearPG1MVSMaiCue6fAxdl/uMxqc75cm6/0FptviqEvLsMXwH+OinQ/hDx+Lfgxy9A7aj2FVUHWAiqyfgEQL1smgmVOyjR/rOaCJfc9NCniwVrU0r4A6Mrz50OwPMDSTVyMIyhJEgT1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8LB4WOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 146D7C43390;
	Mon,  8 Apr 2024 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712586627;
	bh=Alfp2ELwhITazKMEegUqvVbJyfZKJCbUEoIYjFPYgmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y8LB4WOq8S/HKOQhBSfEl++bTKhnOqa+MVCjoT3nZKwZIP+iCIyBu+ibN53oksdkz
	 y4amJknhZgJvaj7/9fNShGylwWb8GQZfjxbYK3Q27HvzCazJwQHtAxCTfShZpRXjCk
	 0/3KJBS+Vg5YHmXGd7GVY6cLO7hvDPszraeG+YM5ZI6rR18LIrImi0/uwIHF6p4vaU
	 b+NRCtF1c0s1fzeF5/9Pv6jWhwXTGVli4suxGVtF5OUOIGYR4dnwaABLIlqwGwWQDl
	 CSme3uKEL0Q5bp+XGwwes4hqqZCDS7OKcaTD1FGqP9IahaOUZEke8KSAijKc1Ivpiy
	 Q6rEm2aozqkRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 067A5D72A03;
	Mon,  8 Apr 2024 14:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Add missing mmc statistics in DW GMAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258662702.25921.3073865414312265648.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 14:30:27 +0000
References: <20240408012943.66508-1-minda.chen@starfivetech.com>
In-Reply-To: <20240408012943.66508-1-minda.chen@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  8 Apr 2024 09:29:41 +0800 you wrote:
> Add miss MMC statistic in DW GMAC
> 
> base on 6.9-rc1
> 
> changed
> v2:
>    patch2 : remove mmc_rx_control_g due to it is gotten in
> ethtool_ops::get_eth_ctrl_stats.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: stmmac: mmc_core: Add GMAC LPI statistics
    https://git.kernel.org/netdev/net/c/dfe073f8714d
  - [v2,2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics
    https://git.kernel.org/netdev/net/c/ff20393bdc45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



