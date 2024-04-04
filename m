Return-Path: <linux-kernel+bounces-131134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9641898377
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CAB28F792
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178C71B5C;
	Thu,  4 Apr 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSAqf5bI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390D13ADA;
	Thu,  4 Apr 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220630; cv=none; b=K0u4fU71NgIhj5H4v0xp2f7CQlotCGsewistdnXHqn/RQSOrcojTgSqfCkNUtH3KPAcbCsudLcOcWXNJZfU/FeCy3nS0B32OPt7QO7yg3Z4d1Ld7H9QSsZEbYIK8fvVm7ng9Rp8qbq6Y1hcetuhBooWF968+kSN/oX5HSGZu3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220630; c=relaxed/simple;
	bh=xJzer2jAJHZxUf61y3SHUbHar0p36yviK55x6YXvG70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h8cMthdzOPba17B6lMjdpnox8CEQj89/ZsJ2CJqqIBrISaViqm8oHASKZCsb3ymH89bBjtwAongHXDTRD9MkgD/s0/WNgX24UbmErtSgA/DLNJlfeHvJaAIobzIFV6JJ2fx5tQ26g30pvtbAbS+kg12THBr+fDD9ss1zYElWaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSAqf5bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C56DC43390;
	Thu,  4 Apr 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712220629;
	bh=xJzer2jAJHZxUf61y3SHUbHar0p36yviK55x6YXvG70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XSAqf5bIaFa4Uyn66gjoJ8h9ozXQzgaIuWo/9uqMiLWBPPgjCGpNQN4PBGESI3Qvw
	 omDgX0BSXGRGltusC/KbvwLI0ZQBsRU7UmpGMhtwjX8tZwzyewiGZmsLGkCgP9Igpk
	 qVYd1FYF4maKGSuTAhCDGqwbUVg0GA+9xa8ZZDAen82H77oQCV2cyo9xLj8l+8StYk
	 NN6/qXwG80QFgkm1o3BXmCywWd+3GnXdTL0KpikYP/5fDffR9vXKKAD67jJ++sTy4f
	 QfgwWUse2+d9Kn2BMTOODZeKsNGmmEI61wOfVrOgALLgLl2PjJE6lhs0KIj3Kgd/e3
	 mLy6gG1d/svgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B1F7D9A150;
	Thu,  4 Apr 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tg3: Remove residual error handling in
 tg3_suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171222062943.6705.9843920756752610864.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 08:50:29 +0000
References: <20240401191418.361747-1-kiryushin@ancud.ru>
In-Reply-To: <20240401191418.361747-1-kiryushin@ancud.ru>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: mchan@broadcom.com, pavan.chebbi@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, rjw@rjwysocki.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  1 Apr 2024 22:14:18 +0300 you wrote:
> As of now, tg3_power_down_prepare always ends with success, but
> the error handling code from former tg3_set_power_state call is still here.
> 
> This code became unreachable in commit c866b7eac073 ("tg3: Do not use
> legacy PCI power management").
> 
> Remove (now unreachable) error handling code for simplification and change
> tg3_power_down_prepare to a void function as its result is no more checked.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tg3: Remove residual error handling in tg3_suspend
    https://git.kernel.org/netdev/net/c/9ab4ad295622

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



