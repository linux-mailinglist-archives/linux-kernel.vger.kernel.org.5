Return-Path: <linux-kernel+bounces-47543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7327844F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673DEB2384E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144A3A8C2;
	Thu,  1 Feb 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOeRE3mL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A03A1A7;
	Thu,  1 Feb 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754627; cv=none; b=D5pH5PGlCl02QtJrWdBVx2whsHfB8f0Or7VNszz+9/7NFK+yHfhqoSsloQU0EMIYpJG10ebxm0UM/QkVxmgJLCADevVDmKSVAHhl5kWls/83y56RNY87aWDe1Ev/r8I3YHnl/qv3j8vqOPPCnRUiowrTDTnbaOdZwzCERTOu7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754627; c=relaxed/simple;
	bh=S+jr708Pod0UIEq/0dWHTcTmcKIzfbnKpRJabkfwEmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkkqQ2xJG7LUZsR6V1tgqFgTiCqmweKM5si0wvU4so8/FrCgz7SnnEWoHGii6leqooaBueSOwlyCNKJ1gJ7v26w4duCyxX7fwpK/KRtOW4YpqxrW7yVBUKtlr/qYUu+aBsQPbCr1TNCCZbC4dTsUlPh+Np0XJUzpvx5M8KJUmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOeRE3mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD34C43390;
	Thu,  1 Feb 2024 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706754626;
	bh=S+jr708Pod0UIEq/0dWHTcTmcKIzfbnKpRJabkfwEmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gOeRE3mLH8/r0twSrCu2IKPVl+uSNnbRMCurmCAjpsQHxlJmM9Pj9gWjYG/NZfVYc
	 b/OkU7T8t+LbW8aqWhQIrCNuusK9p4925mbrbSFBcEzteKrU5Ei7n1r5hTcdzcIVNI
	 QIoJJ6D0MbiQxUYZhlJCiHjrsmDgyHsWEV72u/RkzuicVAVE/5LF9JAaEaDLeD9nBR
	 JEJi5IJab56LwblGT1uiwlu7SR01YTOw4wokWEnb3SWYj3dXZXO/oCvU/ssjMDkI5H
	 0liULWYDmxvA40nkCS6SE53HHeLfKRVuDmclfFiUyjQI91awegSwDjGGuXxlzaPr2A
	 4Wxz0vYhxt6tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8286EC4166F;
	Thu,  1 Feb 2024 02:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] pds_core: Various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170675462653.12000.4039462358825460921.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 02:30:26 +0000
References: <20240129234035.69802-1-brett.creeley@amd.com>
In-Reply-To: <20240129234035.69802-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 15:40:29 -0800 you wrote:
> This series includes the following changes:
> 
> There can be many users of the pds_core's adminq. This includes
> pds_core's uses and any clients that depend on it. When the pds_core
> device goes through a reset for any reason the adminq is freed
> and reconfigured. There are some gaps in the current implementation
> that will cause crashes during reset if any of the previously mentioned
> users of the adminq attempt to use it after it's been freed.
> 
> [...]

Here is the summary with links:
  - [net,1/6] pds_core: Prevent health thread from running during reset/remove
    https://git.kernel.org/netdev/net/c/d9407ff11809
  - [net,2/6] pds_core: Cancel AQ work on teardown
    https://git.kernel.org/netdev/net/c/d321067e2cfa
  - [net,3/6] pds_core: Use struct pdsc for the pdsc_adminq_isr private data
    https://git.kernel.org/netdev/net/c/951705151e50
  - [net,4/6] pds_core: Prevent race issues involving the adminq
    https://git.kernel.org/netdev/net/c/7e82a8745b95
  - [net,5/6] pds_core: Clear BARs on reset
    https://git.kernel.org/netdev/net/c/e96094c1d11c
  - [net,6/6] pds_core: Rework teardown/setup flow to be more common
    https://git.kernel.org/netdev/net/c/bc90fbe0c318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



