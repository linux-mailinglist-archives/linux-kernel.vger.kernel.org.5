Return-Path: <linux-kernel+bounces-84871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2586ACDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FAE1C24572
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6F812FB06;
	Wed, 28 Feb 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaQZ/EGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7812EBF0;
	Wed, 28 Feb 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119233; cv=none; b=u54ash75axTbFM0RL6buKHFKKLl4RJuIjFEZxmOazLUmc9wnHYiacYBaLBOITcjd8Xp2XPvg0lnkoUTyYWxAMUQwPswmhaCtQgW8nxDoBHD8PB3fOKLvC6hV5RtDudM2m5t+lk+00lUVKYPRpye7yIkh1H84XCtoNlK1LvtRbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119233; c=relaxed/simple;
	bh=rplIUsIT3bUGki4YvCcSljKVrFbhmRWRP7eVylEd16Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HiTqmFxYeJYFjfxAQtTENvKrCR03s7nYaCWZhPfyQRcmtfq/RaVBIESpUHPad70Hm6AZcIdYbpk7JPouqZwM13avKcI2AZ18HepC6REgoEKDS+pwRyPqqObgdafq1gguKwN3B7qAVGW6cl9ie5A1L71rOUPngbE9ybd4BmnZNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaQZ/EGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF232C43394;
	Wed, 28 Feb 2024 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119232;
	bh=rplIUsIT3bUGki4YvCcSljKVrFbhmRWRP7eVylEd16Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DaQZ/EGTcioC77azl1WOQWaLnPH/0UdgRs0rIZSaMrj+6OhqoXSdF++O91O7AS/c6
	 MzeA/eI1f7YiaSpey14oqLo8iFcow6G6QkUl5e8JZuaGd23KkCCBp5W8D+C6+Geqvx
	 5bsB0j/yEinI2bBZcO19z0AoMmwtF5+M0+NeEfiB2sQr/2uRb0kO76z9C6qDGEh1Wi
	 0lh/pU3ZNH8Byuczoc6tfrW8+6Uvm8bKd+6RbO3BMMkeowMgzu8LJVjFyYlCR9qY8D
	 9L1mmSK6vHdFEE8EG6aDZeVkIpHr5IhP7IbP4j+qK+vitqTJmmP3i95wLS8nijuj3Z
	 IYGruZJvL1H3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A97FFD84BC5;
	Wed, 28 Feb 2024 11:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethernet: adi: Move select PHYLIB from NET_VENDOR_ADI to
 ADIN1110
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911923269.32073.6670138540455160229.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:20:32 +0000
References: <99d4d711acfc020c8987e96145f2f1f323cbaa3b.1708947112.git.geert@linux-m68k.org>
In-Reply-To: <99d4d711acfc020c8987e96145f2f1f323cbaa3b.1708947112.git.geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rdunlap@infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 12:34:02 +0100 you wrote:
> The NET_VENDOR_* Kconfig options are used as gatekeepers.  Merely
> enabling such an option must not enable any other extra code.
> 
> Fixes: a9f80df4f5144030 ("net: ethernet: adi: requires PHYLIB support")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/net/ethernet/adi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] ethernet: adi: Move select PHYLIB from NET_VENDOR_ADI to ADIN1110
    https://git.kernel.org/netdev/net/c/943d4bd67950

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



