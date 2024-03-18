Return-Path: <linux-kernel+bounces-106113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A987E954
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD7AB2248E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05B381C1;
	Mon, 18 Mar 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGJycxgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E2179B1;
	Mon, 18 Mar 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765030; cv=none; b=pBVuXA3QBbHRJ0ZcYboOjta4y9VH4Nw/Q2FfTnBYAD0yk7qBXuYOxiscwixrGkuNuk6vdJIHRmfJ+uHUt8Qfe7+BFmCTYdoLuQeciDoiZv2l2sguGkHgJkh5c3B7hBwvd98J84qwffZI5MYWGrs9sEGi93Q21dYfheulrsXqYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765030; c=relaxed/simple;
	bh=Pf3JZGSV0vq0+Ep32XwBVnIFfn/v8WNnsG3rb8t8ghQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TylQmn9GiJSRK2vRC4Ajv+1ooDd/sqSDWsvTbv8r524M03P+c58TfahOVrjSn9hfCMMHNu7rEmMgLdBr9X3Gc0WilwFKuQRMfzQkicKPdxn7emrOzEc4hHXNMtH+CMzLkVifxmLwnoJMdDfpPbUDpSegbUtc9pDfczG4S2a14sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGJycxgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEDA4C433F1;
	Mon, 18 Mar 2024 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710765029;
	bh=Pf3JZGSV0vq0+Ep32XwBVnIFfn/v8WNnsG3rb8t8ghQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGJycxgLs+3XFpLWAHW0vsUe3BzzPE5xJRp/m8qxdtLJo8qln3kUI6WU7PK+Ubfc9
	 UlefgKwutWEfXIyGaGscl1BC7/xIk7fdHv+KamIY3d8ETQWJadkRN45hCdsRnQwaex
	 mxH83Du4dl8hcu9Y0GGNBJxEbpymxSSZe/86/cEkV024L+ubVMlZile6HVZYu4YRnZ
	 TZ/KrUBiHwukN63HlT8GACqLib8vtqFNQTkD6wgDvkE1oz7AGrAClgFQOvLJSOwr9A
	 Tbcb2c7IHU/Ci4eTfR6NaURF0GsAllXGBZnwzqUQoR+54c7NDympnR6mpPJUm1Z9ye
	 pg+dscuOIwzFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A00E7D95053;
	Mon, 18 Mar 2024 12:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mt7530: prevent possible incorrect XTAL
 frequency selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171076502965.32045.18266951934755323293.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 12:30:29 +0000
References: <20240314-for-netnext-mt7530-better-fix-xtal-frequency-v2-1-fe30795593df@arinc9.com>
In-Reply-To: <20240314-for-netnext-mt7530-better-fix-xtal-frequency-v2-1-fe30795593df@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 p.zabel@pengutronix.de, Landen.Chao@mediatek.com,
 bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, justin.swartz@risingedge.co.za,
 arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Mar 2024 12:28:35 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> On MT7530, the HT_XTAL_FSEL field of the HWTRAP register stores a 2-bit
> value that represents the frequency of the crystal oscillator connected to
> the switch IC. The field is populated by the state of the ESW_P4_LED_0 and
> ESW_P4_LED_0 pins, which is done right after reset is deasserted.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mt7530: prevent possible incorrect XTAL frequency selection
    https://git.kernel.org/netdev/net/c/f490c492e946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



