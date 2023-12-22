Return-Path: <linux-kernel+bounces-9760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B781CAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC4285B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8891A598;
	Fri, 22 Dec 2023 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXSjk9IH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450719465;
	Fri, 22 Dec 2023 13:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECF13C433C7;
	Fri, 22 Dec 2023 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703252426;
	bh=INxsEsFUIS+7RnBttf3jqXYcWy7AvzrgXmm/aIhnR5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PXSjk9IHtlnDMqWarbuOe8smj8WoAY8j3ZgxM+tY/CWaKSGK1OhF2kCqHivU6ceP+
	 zNaSDvCi4NlBvJzg5mW72PieuNmPMpQXDEk4dqX08gTa0fYT+mMmjqsrrFGipq8o2y
	 5EQ3mmDcs7tkLRVosIAGYHcOOj82jZySYAU+iQ8vl1DI69tk/quCLdhw+T25UrwwS8
	 hVs0JsSSdLGlfX9riSPbWNyeZakpp5PvddVyiZ+Fa+d3q9yaImMxDEYjZoaB51BgFV
	 rdfhHtlOH3tggXLIaNKejBXq4fugNfLQLY/ckTCkh+yhhNLUziYw4M/Ed+sFlQ8McT
	 bBcf2oWgRjiIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2FEAC41620;
	Fri, 22 Dec 2023 13:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Fix a double free issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170325242586.1466.6500484977108617189.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 13:40:25 +0000
References: <20231218180258.303468-1-sumang@marvell.com>
In-Reply-To: <20231218180258.303468-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Dec 2023 23:32:58 +0530 you wrote:
> There was a memory leak during error handling in function
> npc_mcam_rsrcs_init().
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Fix a double free issue
    https://git.kernel.org/netdev/net-next/c/27c346a22f81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



