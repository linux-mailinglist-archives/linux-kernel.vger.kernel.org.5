Return-Path: <linux-kernel+bounces-56583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCC84CC03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA041F2624B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21125A118;
	Wed,  7 Feb 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkkpQCo4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26877F08;
	Wed,  7 Feb 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313827; cv=none; b=djOx16CrCfls6WakaxA0BnwqVzCjCHCSYUjDcNTZBv4ulxBTI+ugvppQg2CDmNoKDrPu04gBvT2/S+sstkc0qLW16u3N5GbkiDVozo2My54RnQUahKrSofjO2FlsjW4kT64+2qwI5600tV2U1h9pSHMHnT53hIwPyd1t3S503sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313827; c=relaxed/simple;
	bh=dmuXJA4ZT1tUJMeDuSw5EWD8YBIigWfeJDIEJHdcVsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qg4nXwsVGqYZZpCpke1qplTKL6dSEUbEsMBnWd3mW/VpHGANVR41zv33aX2YPzcQ/WhLibI0i04ZGDp4yIx51jaMo0D49tnlCX2uLLwdKn41EXV5Q6YpH0Aw8JwhjCug3Zeba6TBMLDr2bcTPJth1P0nxIfK728qRV2Fba+gHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkkpQCo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D4EAC433C7;
	Wed,  7 Feb 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707313826;
	bh=dmuXJA4ZT1tUJMeDuSw5EWD8YBIigWfeJDIEJHdcVsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkkpQCo4ewCRimVC1n0DNRR7iY9L8Wz5JMGwJSQalOsF9e9llvX0Tqm73h6umGVsf
	 +wuB8vWCbtr0JjvsrpBjp67jr2MOcRGGxn1OLFwRCSC/5VzzVpTq13mwtXI89d4XCF
	 9sE8ZyOnHrMD8KiPx/PHbcV4gPWTHrSTfptLnXCOow/KK8H24yc3JqR8QsiguWc/NW
	 ZnmZu2tt+fBJL0S11XDoIExMh6E9B85y9sWToxofeA+MuyAZlA4JIMm30uP7X+S58U
	 hh7bZ8gIFJjkHpbRYSQPjCaFmLXdH8bpO2WLZtlazMaVIfHIyE/L4QFXqa/ea/3Cui
	 qPbBiiGw7QlcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77BB0E2F2F1;
	Wed,  7 Feb 2024 13:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdevsim: make nsim_bus const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170731382648.23380.5700800203117881885.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 13:50:26 +0000
References: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>
In-Reply-To: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 04 Feb 2024 17:16:34 -0300 you wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nsim_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> [...]

Here is the summary with links:
  - netdevsim: make nsim_bus const
    https://git.kernel.org/netdev/net-next/c/56b93cd358b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



