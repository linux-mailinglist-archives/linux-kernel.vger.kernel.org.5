Return-Path: <linux-kernel+bounces-130847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B8897DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF561C2199F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC42135A;
	Thu,  4 Apr 2024 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="babYapBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EB1CABD;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199043; cv=none; b=pdoFUBb1pnrgxBgALe+ge9Kiwk64xpXXAhBaCv+4VKjk12gwDLoVM7HPC3mX3qYy4uztPieBsxhIXoOLCGij/ekLjdoj2cqjqVnGJ5sZsuRngrPfugUQVWCHG1dyFLpsPyNOGB0EPPuH8szManPCNPbAX+sdlMnasFk+Q49/uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199043; c=relaxed/simple;
	bh=Z0NqPyA1Ag7ywDCAREb3aLXtL9z+FPZPJKBvHQO0qu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dwPWzU7ZssKI7S63B28N167hpvm0xQmdKKZ+9oN1xzUqwyygnmEMEM+jm2UPXYaZdaEX5d5aMXdOi+qh/elKdVSBVZss0KfFuOpAWdHfUuLqK0YgFNNPKXuo2/zBXsdS43IDNp5zGoOUh6Bbo3mvJcLTvSxIMwkuDdfsjXn2qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=babYapBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A4CFC43399;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712199043;
	bh=Z0NqPyA1Ag7ywDCAREb3aLXtL9z+FPZPJKBvHQO0qu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=babYapBxC3JxNFI8z01+x6T2wNnl/TdGYD+Sjp7dxvjVzz5WJTPhZScrrb35OMtaf
	 Bc49gAlrOdrms5bjXdHn6puun1kncoLIWUHIyzouZ1mm8arI780jlur1uoZAz3uuQG
	 dD6IUiTYJrldynPR/IaH1xD+YC9vku7XqoOTmPjJVnSGxXbvS6aHqBDhkbeScg9SNL
	 v1nx9FS10qWDq/wFwOMzyyl+ynkUUM8QI25cUCFTmIHAxk3dmsutJTI8sWaEKTUEoy
	 iaV6BFEtf5lFaTA0M+FhCeyhRtGbEqz0CP3MXqjMCJwG6ZbskzEYt6ezPMPOQELKQz
	 I4vPi06ntdHzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34EA8D84BB4;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fman: Remove some unused fields in some
 structure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219904321.5496.4241068677460405258.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:50:43 +0000
References: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 20:55:50 +0200 you wrote:
> In "struct muram_info", the 'size' field is unused.
> In "struct memac_cfg", the 'fixed_link' field is unused.
> 
> Remove them.
> 
> Found with cppcheck, unusedStructMember.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fman: Remove some unused fields in some structure
    https://git.kernel.org/netdev/net-next/c/04af1d643701

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



