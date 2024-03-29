Return-Path: <linux-kernel+bounces-125346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647C892465
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67193B2212D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3E13A890;
	Fri, 29 Mar 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qURCjjJ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FE65E20;
	Fri, 29 Mar 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741230; cv=none; b=G/ENYjdnicG5X1P0YmJ013zLLDXdOo9juM0lkbAdOTrlq75upV8BMqusa+whACObgzllU1/ypEQPR2HNDx2LWOWEEMmehKv5Y6cXCXnxzhsg2lcR/vreUsG8CVxHzTcGxaIHLpLdxtWaCCLWwbqLUkiRCAWRbvbhuD6oyfpSHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741230; c=relaxed/simple;
	bh=kVie0lIYq87b4K2yStjHn2aHzRqOEQgLJws4/Qm9roo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tDIJG/XN0DsFHpIwJqnFBdLmC5AwtQS19XUlvpovUC2N+6xvFZwZHp0QSL3eJi3kZ0hiJXG0AISZTIkq3IjN96TomYKdD4n0jqBMcMk7SO9eIOEx7qYuKqQTFlZzKYEnKeiCF9DrCSpRcjBkhwY3tGtw1ZXF+EBYpmD/xtdtkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qURCjjJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEE8BC433F1;
	Fri, 29 Mar 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741230;
	bh=kVie0lIYq87b4K2yStjHn2aHzRqOEQgLJws4/Qm9roo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qURCjjJ8CyoClRIHgW1xlrilNI9+EtbfuJnkn3yDcfXqwXkfrj1L2nTFOiwbABj2C
	 Jdg4Pe+Key3N7s4lQkKW8j9CUQegZ0QrHyUTj+azqJpk6YnUKQD/Jfjqca5Zt0MhoL
	 aSZhZsKVi4UxtchPo5TFzqoua38eeiqOyNCb/6KgGnATKl0ETmSpdfpqiY8rKpqTF4
	 o7+5n010YAl3f3cZSHM7j7kl92SN1/zefX/iN9IcNDpKLmKuMzGDpSStDu5I3UBMdo
	 UIHa12gaoxl8MEpWRm9uVi0l+hfGN109MfTQcwP/Wg/q1i7kg6bEAkt43DMrjj3cpR
	 DsyQEwrZjVfuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9FB3D84BAF;
	Fri, 29 Mar 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeontx2-pf: check negative error code in otx2_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174122982.26003.5767221799361986450.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:40:29 +0000
References: <20240328020620.4054692-1-suhui@nfschina.com>
In-Reply-To: <20240328020620.4054692-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dan.carpenter@linaro.org,
 saikrishnag@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 horms@kernel.org, kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 10:06:21 +0800 you wrote:
> otx2_rxtx_enable() return negative error code such as -EIO,
> check -EIO rather than EIO to fix this problem.
> 
> Fixes: c926252205c4 ("octeontx2-pf: Disable packet I/O for graceful exit")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: check negative error code in otx2_open()
    https://git.kernel.org/netdev/net/c/e709acbd84fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



