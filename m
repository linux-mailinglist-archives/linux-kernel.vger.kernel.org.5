Return-Path: <linux-kernel+bounces-132333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A6899340
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C644B240FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53125182B5;
	Fri,  5 Apr 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN8Gt42S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE912B82;
	Fri,  5 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284830; cv=none; b=PoutEDg0AvCV7JLjHhd78aBZrqWcCGrii9Rd7IPBvxSdf9zJWHuzjmtKqo23QDxvO3KMWoQTqKSPA27Me6ZcZYQsJyTVqwytaieQ07SXQlD/FnmRgRshqatTz2/mPtmRVkiO/K7MLtJxNNqrhbaJOhrxdfS7HYXB2TYrlcPXBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284830; c=relaxed/simple;
	bh=r8ZTkM09cSWLFtghokToeBai9Q+R9Dq9nyVQm0kxUEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AutORP/wr3hqngtqyhxSeDBFu7BQ+61PFQWcxiXwwokpUQGPCnDEqmfmg12x7FAvaJuatjVAshEa9HXJR9/zEJAo7LYzzzyKI2tajMkwas8rK2pUFFEDORy0bY7c9WUjc98+feA2qMI74118tezlzvGdPF0It3aFAD7MWDhzlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN8Gt42S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22022C433C7;
	Fri,  5 Apr 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712284830;
	bh=r8ZTkM09cSWLFtghokToeBai9Q+R9Dq9nyVQm0kxUEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LN8Gt42SlfX3/7298hMD8WFRCI5/kRgokSvGHTSv6vmTzDT/CVlczNcW46d8UW9LI
	 X9QEC4SEmI46s8Iw+fz77oABC6Rws1b7Pp61Zwm27oi/2KyWQH86c0xvrqK988Qzyd
	 eOlDMJkn3iSEIhED4EmDNl02zYoofYHX3819x9pzL/QU/3P/60Cls7mQy0S4K60cVb
	 XOM3XqMi1ULkYl1s4qmXC3HafXtJuRTMqot27u1RNNjT1keIWzUtHJYhJnbnKqQi56
	 +gN+0NIjNQ0dRZQB9D/MCrUTLPvZBsWHoMPtdiLXl3ms2yA+TzeUokPyVnyE4BqSHy
	 tVLOkTGvOjwFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F3FFC395F6;
	Fri,  5 Apr 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: dsa: microchip: ksz8: refactor FDB dump
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171228483005.11871.10405239717596151463.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 02:40:30 +0000
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
In-Reply-To: <20240403125039.3414824-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, san@skov.dk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 14:50:31 +0200 you wrote:
> Refactor FDB dump code path for Microchip KSZ8xxx series. This series
> mostly makes some cosmetic reworks and allows to forward errors detected
> by the regmap.
> 
> Change logs are part of patch commit messages.
> 
> Oleksij Rempel (8):
>   net: dsa: microchip: Remove unused FDB timestamp support in
>     ksz8_r_dyn_mac_table()
>   net: dsa: microchip: Make ksz8_r_dyn_mac_table() static
>   net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
>   net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for
>     readability
>   net: dsa: microchip: ksz8: Unify variable naming in
>     ksz8_r_dyn_mac_table()
>   net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN
>     on timeout
>   net: dsa: microchip: ksz8_r_dyn_mac_table(): return read/write error
>     if we got any
>   net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to
>     signal 0 entries
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: dsa: microchip: Remove unused FDB timestamp support in ksz8_r_dyn_mac_table()
    https://git.kernel.org/netdev/net-next/c/a4a0306fbe1c
  - [net-next,v2,2/8] net: dsa: microchip: Make ksz8_r_dyn_mac_table() static
    https://git.kernel.org/netdev/net-next/c/860cf29eabf1
  - [net-next,v2,3/8] net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
    https://git.kernel.org/netdev/net-next/c/0499bb09f412
  - [net-next,v2,4/8] net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for readability
    https://git.kernel.org/netdev/net-next/c/5f1b7f838f5f
  - [net-next,v2,5/8] net: dsa: microchip: ksz8: Unify variable naming in ksz8_r_dyn_mac_table()
    https://git.kernel.org/netdev/net-next/c/08736e083e4b
  - [net-next,v2,6/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
    https://git.kernel.org/netdev/net-next/c/081e84f267ad
  - [net-next,v2,7/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): return read/write error if we got any
    https://git.kernel.org/netdev/net-next/c/7caed786b374
  - [net-next,v2,8/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
    https://git.kernel.org/netdev/net-next/c/8d5758120dd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



