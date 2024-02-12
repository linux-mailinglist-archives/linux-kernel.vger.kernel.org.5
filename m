Return-Path: <linux-kernel+bounces-61376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF533851187
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA131F20F94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2823A8E7;
	Mon, 12 Feb 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKaE+hrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5D3A8D5;
	Mon, 12 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735027; cv=none; b=EsAfhuphK/3ZaoyJVH9gJ/vK8L1vYYCqkZ8kWzywHm2sUqGA5tB6EVDyyQWSgszzkjhWu0YeGUqkTHjmPggrGgXywFGocx3p8HfhXRGpDIedeEN86Bf4cvw+rMZlV6nCezGGljlg2qWlWIVtzQPKO+OnK9lEreRsik87rgoGRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735027; c=relaxed/simple;
	bh=ZxwqukV6j0JIIdbdD+zsuFOVtzBQbkKWs8AywHX/k3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tbsITD1iNVyTxfxwCfkxgg8z6ebocKsHRXPNHLUTfBP6KII4eSrUEbe465wEkXDg8Z4+Iaq8G1sr2CRk6s/rVxZYdVlzBZn3NXHQgCLjZ0ZHzSyOvm2Wo3rwqbn66U9e5RZegOneFKg4YVI9AZ55CtxIkBPx5wLeXn2G5W9auvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKaE+hrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04657C43394;
	Mon, 12 Feb 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707735027;
	bh=ZxwqukV6j0JIIdbdD+zsuFOVtzBQbkKWs8AywHX/k3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qKaE+hrdqby0H2OtjR0Sk5BIY1IJKTfDLJW6X+yVf1wXvEthRdaaHCmRtWZU5/YhC
	 cS5NVVeSxGDdlYtKXkrgk/hoIflew1A0uxU7mQC/DT71Bk7w/Kl0vXvq/24zADo8BP
	 A0SFHxHvv8S7FXT79NyuqZ+w5PZ+/CuGRQzkhMbivSUqTtboT6EIDW8lopnctj7lYm
	 OWXQrlzGkhZV7x8xzQDG9m6d9vMKp3ZZ0Ng3ePFpMZqFNGoPJMaEBwueG52XTEtBzh
	 hAuwQjmvB99DKa2+T+bUdGm/q/9JNFGySAe8jtbyV3yNQaKb8Qn+rAOX76D11h4DQ9
	 2hCYDG7BWjKIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD4CED84BC3;
	Mon, 12 Feb 2024 10:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773502690.28134.16915655104997076968.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 10:50:26 +0000
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 florian.fainelli@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 09 Feb 2024 02:03:36 -0300 you wrote:
> The current driver consists of two interface modules (SMI and MDIO) and
> two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
> modules serve as the platform and MDIO drivers, respectively, calling
> functions from the variant modules. In this setup, one interface module
> can be loaded independently of the other, but both variants must be
> loaded (if not disabled at build time) for any type of interface. This
> approach doesn't scale well, especially with the addition of more switch
> variants (e.g., RTL8366B), leading to loaded but unused modules.
> Additionally, this also seems upside down, as the specific driver code
> normally depends on the more generic functions and not the other way
> around.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/11] net: dsa: realtek: drop cleanup from realtek_ops
    https://git.kernel.org/netdev/net-next/c/33f4336cbd32
  - [net-next,v6,02/11] net: dsa: realtek: introduce REALTEK_DSA namespace
    https://git.kernel.org/netdev/net-next/c/ded3813b44fe
  - [net-next,v6,03/11] net: dsa: realtek: convert variants into real drivers
    https://git.kernel.org/netdev/net-next/c/bce254b839ab
  - [net-next,v6,04/11] net: dsa: realtek: keep variant reference in realtek_priv
    https://git.kernel.org/netdev/net-next/c/4667a1db2f55
  - [net-next,v6,05/11] net: dsa: realtek: common rtl83xx module
    https://git.kernel.org/netdev/net-next/c/8be040ecd94c
  - [net-next,v6,06/11] net: dsa: realtek: merge rtl83xx and interface modules into realtek_dsa
    https://git.kernel.org/netdev/net-next/c/98b75c1c149c
  - [net-next,v6,07/11] net: dsa: realtek: get internal MDIO node by name
    https://git.kernel.org/netdev/net-next/c/8685c98d45c5
  - [net-next,v6,08/11] net: dsa: realtek: clean user_mii_bus setup
    https://git.kernel.org/netdev/net-next/c/68c66d8d8a19
  - [net-next,v6,09/11] net: dsa: realtek: migrate user_mii_bus setup to realtek_dsa
    https://git.kernel.org/netdev/net-next/c/b4bd77971f3c
  - [net-next,v6,10/11] net: dsa: realtek: use the same mii bus driver for both interfaces
    https://git.kernel.org/netdev/net-next/c/bba140a566ed
  - [net-next,v6,11/11] net: dsa: realtek: embed dsa_switch into realtek_priv
    https://git.kernel.org/netdev/net-next/c/9fc469b2943d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



