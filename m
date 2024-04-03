Return-Path: <linux-kernel+bounces-128944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A899389621F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3931C236F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606AE1C6A6;
	Wed,  3 Apr 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOR7MI6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1517C73;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=VvpdsYOgTKkdmTA6W2zf9tmLHQ+ONOolE6ubVVoY+mwxoe5ydo8MCFp7qf952LhxDfXcwkiJy6z8SVW/SNLmVzgUVkRZZqHtzNfLqzmS3K7qL8kgFq/C42JHCl5jEiA0qJA7vzZpYsND3BEpbV23jU6EMHHN7u0B0UTZddGTvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=wL+IEdYJmWYvqL6YGhSRDv/heRLZOmxsQKYK5ok7dr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bR2+HGVBVPSa3SlBeDqZ7DVolYCCDuXxp32Eiq49+rcsn+jvwrBaInbCq0X5tWhbLpxViHIWLooYIAAXEpLioo/gfSjyhJY9ZSkxS0neSs/WyTG//mAalLw6UoxuRR9PQ46NpgjkEODtcM5JW/LqoP2WF9wRq69YV96A7L0eiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOR7MI6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EAAFC4166D;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108435;
	bh=wL+IEdYJmWYvqL6YGhSRDv/heRLZOmxsQKYK5ok7dr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DOR7MI6q6PIcKUBhuhtawBBerbNddKo0xwIoDlrD+TeuyTnUgXUuZaO5PIOSUhBbS
	 az4HerxczU43OFgv+JT52k/lIa3/n8xcoH1Uzp9Nvx31Vvn3b5sj7IvGPlfYbfMnyB
	 wp0j43mx8NtDjZRDiQk0JAS9Jqh/39evR+c8DutMMa4FDNGB7xP4xrhTfRg2sqcIk1
	 mwAGpI+qHyCUT1eqTXaxa6nmEfPLVY8QamWsk32f636PyWMvIwZ5ZTEJtetM+SYEwk
	 mBzjhI90MUy9k+Kt+W0nDkMTg50N6uDb1MZh9FCimDLlmRngTSI6qFO6WjrRGOXYz4
	 bLxMLsoTpB1sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03407D9A155;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rhashtable: Improve grammar
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843500.14193.13263939591032682700.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:35 +0000
References: <20240329-misc-rhashtable-v1-1-5862383ff798@gmx.net>
In-Reply-To: <20240329-misc-rhashtable-v1-1-5862383ff798@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay_=3Cdevnull+j=2Eneuschaefer?=@codeaurora.org,
	=?utf-8?q?=2Egmx=2Enet=40kernel=2Eorg=3E?=@codeaurora.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, j.neuschaefer@gmx.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 17:26:27 +0100 you wrote:
> From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> Change "a" to "an" according to the usual rules, fix an "if" that was
> mistyped as "in", improve grammar in "considerable slow" ->
> "considerably slower".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> [...]

Here is the summary with links:
  - rhashtable: Improve grammar
    https://git.kernel.org/netdev/net-next/c/8db2509faa33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



