Return-Path: <linux-kernel+bounces-25286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FD82CCBA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38131F22A5F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101E21342;
	Sat, 13 Jan 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBShBegL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7717BD3;
	Sat, 13 Jan 2024 12:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BACB9C43390;
	Sat, 13 Jan 2024 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705150224;
	bh=yY2rSlGkjZflGrirYZMdUgFNa1m+E+eJl0XsX5awu5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZBShBegLwtLPNOhPak1h3TWRx4ILNmarEXhzGj9vxyIaHFHIbTCdZm8naNEKCFG2y
	 FWqMxqPNIVID1gOcaHEpjn3hCBME0kDxn6jb3chMBoPD26l+p9/rt65efjy0Rxscsa
	 QSkFNpAaIBs2fSOd02lGlNxfEUPBB+yIJFfuE7p0kTstJ+wcT4B2R+3ZvkdAfIxB0A
	 cIK0DjDBu5buLBzNccT1JP6cNq8JX0refs41OPWQsV0IP7aEb+O6XcJVaXxcD23Vyi
	 8D2UX0ta/oafo4Q71SJq/mKSmt9JbHPm3f4qFf2I28hqnQx+NvGxvb33y7+qdwg9Ck
	 K60u/vPSvtJow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A12E4D8C972;
	Sat, 13 Jan 2024 12:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: Fix ethool link settings ops for
 integrated PCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170515022465.6254.17374650237895775131.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 12:50:24 +0000
References: <20240109144729.26102-1-quic_snehshah@quicinc.com>
In-Reply-To: <20240109144729.26102-1-quic_snehshah@quicinc.com>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: vkoul@kernel.org, bhupesh.sharma@linaro.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, ahalaney@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 Jan 2024 20:17:29 +0530 you wrote:
> Currently get/set_link_ksettings ethtool ops are dependent on PCS.
> When PCS is integrated, it will not have separate link config.
> Bypass configuring and checking PCS for integrated PCS.
> 
> Fixes: aa571b6275fb ("net: stmmac: add new switch to struct plat_stmmacenet_data")
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: Fix ethool link settings ops for integrated PCS
    https://git.kernel.org/netdev/net/c/08300adac3b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



