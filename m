Return-Path: <linux-kernel+bounces-99551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248A8789DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EE51C20F18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268395787A;
	Mon, 11 Mar 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk2zFwEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24256B7A;
	Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191432; cv=none; b=VzERU7E1DCewuPHmgVzIwIQNqIItt8KFjzdzHK8JnWGyBToExlHyDqhcbml7y+tNGZoDXnrcpIXfgEhXS3C22hzbi9cOUirdINh8O4bKOiD6IIYUJwWvuR5LBYAjUpeYcBqixn5YBHJZerC/t7IzprhxzHSHy/tLMqxGi6ZHGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191432; c=relaxed/simple;
	bh=1ulrTx8AoxjxfOW0BLwJHz0vuazP+X6KMFMxH95+55U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UgJxgBayv+Sj1/MhCsrIlJXFazvffBfaC3trZ6ZPsu0lTWxw4MFBvKRu1CaId3aVTBnITbKtvlW4XZMvU8N2pGtd7vlbewtEiQHN7HeTzDw1KFwHQUatBtZDSCOY+kktmHFFzDpNTFtOOYXhuEhvfCoELBR6NI9JlR5c+93lL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk2zFwEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2908C43141;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191431;
	bh=1ulrTx8AoxjxfOW0BLwJHz0vuazP+X6KMFMxH95+55U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dk2zFwEpgDw+KCrKtN5um461olspF/q0xKZ//JoF7R2W4w/PZkEN0Oe/XwINFbwe6
	 Ema8DJXg824946OSjwBFgkqJyDtm2hsxsc6mFBDlDFNWxjUxs5g+XExhAJYssh9QfK
	 SBQcHB1KLv1SPrpC1zBDNTLdMJp544hvZmz8pz+N0pBkTWHNYntiayUnubiiBBmIzT
	 b+uDPjVWapmr12aw+YbtM5RF+Z1UD1Z/rbHpT0tYv2MFqJtuYeIH5wPS8XlVEZCrra
	 2lFNYIM48KYkni2AX2hQllAJZPV4P5HH4ggahQVgplIZIR6euc6oNb5byA8ej39ART
	 1ob+nlrzzDpAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB0E4D95055;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: mdio_bus: Remove unused of_gpio.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019143182.14853.4303336142923556303.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 21:10:31 +0000
References: <20240307122231.3677241-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307122231.3677241-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 14:22:31 +0200 you wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/phy/mdio_bus.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: mdio_bus: Remove unused of_gpio.h
    https://git.kernel.org/netdev/net-next/c/86a7abbb2210

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



