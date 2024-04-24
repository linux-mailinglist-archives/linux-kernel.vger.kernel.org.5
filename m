Return-Path: <linux-kernel+bounces-156840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A4B8B08F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DC71F25DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD915B0FE;
	Wed, 24 Apr 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm0QEuqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A315A4B0;
	Wed, 24 Apr 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960629; cv=none; b=WDqL5rGoPE/qureZLH62VpWXakSd7u1Ne8nQA6AM6ci8N9jKPFWJUzWJpp4Y9nQ7F21Z7tkW7+QKWk4L+7jeR9hEupgEcvvMqkuYcCueMMISWRq4N4LRSvGbLcJTaDqjbrT0I7PI63ZLYRkzd2r97/0VOVUq0zQ+xTys2jMMd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960629; c=relaxed/simple;
	bh=IYnFKlSQxxlXJlUb+5zmEqOWpIL7MWGKB/E73+VHyu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwNydpVSPOTwmb3W03VdBK4mu+Y4H4y11h46opHnU0YUBj1TRnmYM39dwNSHQlVNfELPJ9Np60jY8a4JMTTv9GqYnuUZJl6s5Rp3oxwJOPzTsrYWDGopm2ZSAw57P9NEcYkLJSQ3DRJKDiMEpOa4qj3v8w/XLxBmWpKxbiH1xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm0QEuqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49AB0C32781;
	Wed, 24 Apr 2024 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713960629;
	bh=IYnFKlSQxxlXJlUb+5zmEqOWpIL7MWGKB/E73+VHyu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mm0QEuqN3CYlFoJokv78CgUB3WvlpqRwaNuIcgvYixHNbPMS1CckUcy2evaEhc76O
	 k862F8+r3Kp+8nXcUdifPgZNHJVuLPmEezpqjvMuitATUxNxZEhyqyYRFJi72vGcGA
	 S/j2PurXCPi+W1EusWgR2vQgpcwsBXpyF5TEqWwcXf+dW2izCw59MXxxaXKOuRuU3C
	 uQUvByUrIPvtKtfPEdFaW4U55QD3RhZmLpiQTeJRoGYU55GQA+pmtMKyK6VBzbERyL
	 3Vvrs3dwu7ejXkV2BlKgEPxFUYLyJYac1vHxidrIAjZ1y9E3I6kFChZQg3MyGDOadk
	 1y521uams7YrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31359DEC7E3;
	Wed, 24 Apr 2024 12:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: sparx5: add support for port
 mirroring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171396062919.12224.8860329852076042768.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 12:10:29 +0000
References: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
In-Reply-To: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 horatiu.vultur@microchip.com, rmk+kernel@armlinux.org.uk,
 u.kleine-koenig@pengutronix.de, vladimir.oltean@nxp.com,
 yuehaibing@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 20 Apr 2024 21:29:09 +0200 you wrote:
> This series adds support for port mirroring, and port mirroring stats,
> through tc matchall action FLOW_ACTION_MIRRED.
> 
> The hardware has three independent mirroring probes. Each probe can be
> configured with a separate set of filtering conditions that must be
> fulfilled before traffic is mirrored.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: sparx5: add new register definitions
    https://git.kernel.org/netdev/net-next/c/8c82bfdd8499
  - [net-next,v3,2/5] net: sparx5: add bookkeeping code for matchall rules
    https://git.kernel.org/netdev/net-next/c/1ede4acf045c
  - [net-next,v3,3/5] net: sparx5: add port mirroring implementation
    https://git.kernel.org/netdev/net-next/c/4e50d72b3b95
  - [net-next,v3,4/5] net: sparx5: add the tc glue to support port mirroring
    https://git.kernel.org/netdev/net-next/c/2ac99ed9c3ef
  - [net-next,v3,5/5] net: sparx5: add support for matchall mirror stats
    https://git.kernel.org/netdev/net-next/c/5af946f4bb42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



