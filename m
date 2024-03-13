Return-Path: <linux-kernel+bounces-101212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0887A412
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C817B21992
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29C1B27A;
	Wed, 13 Mar 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIwnd13/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AC18EAD;
	Wed, 13 Mar 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318029; cv=none; b=metS2POgNe9e/xJ4P+KN6Xvm/j8OmSkfXpFvWXMZgt3KrgginoWlsTH8fWAgh30sG25hH1sB9ohOg2RZnetMOkVXJW+tm1oDa4Eq9DpPq7UCRgb1WiZ27kcf8h9mDG0UFJSyGltlMO9JsvOaWISfzcETrRCa/GdEDe45z03pvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318029; c=relaxed/simple;
	bh=oUsOL6hxMKKQ73cx4GRRn7cptHqRBCUzVvGVhHwPBhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H8T0WLWVZY47HueCFrFHBQuK1Bk1IeqbN7mouYdIDfGgCopUB1xUgDJRWfKzBhQ75lmpOy+aZxMy/j3guWsiBILa+542c0Vru+cLrc71f6vi8n/0xHR1fhhW6iwUrD2nvJM+vQ66I5mCqoEAobNaOcVqELnuAufK8uoKtPUC+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIwnd13/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D9C3C43394;
	Wed, 13 Mar 2024 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710318029;
	bh=oUsOL6hxMKKQ73cx4GRRn7cptHqRBCUzVvGVhHwPBhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fIwnd13/YmSHEt7lU1Dn9wEomsuhuBGK+sCUhUOHlCM7WB4NAkQrzT+gSudkKVyjg
	 1lYOW0QC16NeMglK8WjPrXeCFovQbAam+tPQb2JKTta8iLkAe8PivPsa5bWQoZebCC
	 qq8szawNSmwjXRguzmfXZo/JEnLYHrzlH1WzURIMT5AFByprkc1kz+mOeh/TjJbmJE
	 YDSCJeHMZbV8Y+BFcpESmekhIrcFXG6uXwtkRfyeEtWwSbA4UIgdaar9Eh/sksW8i/
	 DqDaoWoxXEw3V62JCofs28Ej3w0lFXgbgOiAmuta+yUdF5DRKhzEdZP6LHJehP0fep
	 6ixf/bA/65mdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56593D95054;
	Wed, 13 Mar 2024 08:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Use matching wake_up API variant in CGX
 command interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171031802935.29357.8241782552356760374.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 08:20:29 +0000
References: <20240312070622.844546-1-lcherian@marvell.com>
In-Reply-To: <20240312070622.844546-1-lcherian@marvell.com>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gakula@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Mar 2024 12:36:22 +0530 you wrote:
> Use wake_up API instead of wake_up_interruptible, since
> wait_event_timeout API is used for waiting on command completion.
> 
> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Use matching wake_up API variant in CGX command interface
    https://git.kernel.org/netdev/net/c/e642921dfeed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



