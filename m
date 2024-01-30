Return-Path: <linux-kernel+bounces-43839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E097D84196A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AE928769F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24B36AF8;
	Tue, 30 Jan 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv7v+6vH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76253364DB;
	Tue, 30 Jan 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582424; cv=none; b=CWkIXWJ6ZdGq0dJW6EmV7HyWxc+Mae0ssOB1InvY+TdN7or1wbAXroOnP/+3WLjs3YC727ZcQU0/3/4rqOXuRofprEI/fmWqRluJaQGh1s+FeXyZxPyNiVaF4cSm/34c2BMixSAi0B9BedGGYS3LYHpT/4fdFsMG+YjB+x4b9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582424; c=relaxed/simple;
	bh=l7iNsmx66/1U9HxfyV71kF0ouS2w3G1prRYjdiYH400=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxaNNtsZ62xcXzgkORBGbbSdbSh7iiAvAJaE8i5bnC4bF2wGv2ukdISbM8EGHS/7dtNyqD9oQ8JNg1w78UQqqcugLugFimMiQUFR191jc8d1ohK/4YYQl0jztCwvHFle+xOXLmiI0QQzxMW3wkGvZz3tGlfyF/tKYVWdB0sXMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv7v+6vH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E108DC43390;
	Tue, 30 Jan 2024 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582424;
	bh=l7iNsmx66/1U9HxfyV71kF0ouS2w3G1prRYjdiYH400=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dv7v+6vHX7w2nWdv48sCcWYELRt2RoCzt/qpZHXF070TN+XywaUZpAmTWgwvy3q7H
	 yo2cZlOyL17Q5VwvpnZYMgiCilBmDyM/PF3kIf8NyUj2ubSomhRc8sjHXtl5mDP3C1
	 nJiQ/Lri9CklZD71VlGHFuMrQ3usJZqR/owPBxvBrPPMncLgN861fh7V8fWJR1RpeE
	 +OLqtSVSXMjapWKItQMpKf6ow90Z7dUn3YZsdM1XvtEdfz7M4x3+e4tpqXaFfCMdYn
	 PUJCqZRqE9S8wwda1svYllQd5Q/zCBV7fjjNX8uWiPUWWDQ0JqrPvH/5l4aGtmAQCO
	 sI9RvLe5IX8/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C668CC561EE;
	Tue, 30 Jan 2024 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: qca8k: fix illegal usage of GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170658242380.31723.8345340437270157023.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 02:40:23 +0000
References: <1706266175-3408-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1706266175-3408-1-git-send-email-michal.vokac@ysoft.com>
To: =?utf-8?b?TWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2thY0B5c29mdC5jb20+?=@codeaurora.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk, kabel@kernel.org,
 chunkeey@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 petr.benes@ysoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jan 2024 11:49:35 +0100 you wrote:
> When working with GPIO, its direction must be set either when the GPIO is
> requested by gpiod_get*() or later on by one of the gpiod_direction_*()
> functions. Neither of this is done here which results in undefined
> behavior on some systems.
> 
> As the reset GPIO is used right after it is requested here, it makes sense
> to configure it as GPIOD_OUT_HIGH right away. With that, the following
> gpiod_set_value_cansleep(1) becomes redundant and can be safely
> removed.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: qca8k: fix illegal usage of GPIO
    https://git.kernel.org/netdev/net/c/c44fc98f0a8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



