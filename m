Return-Path: <linux-kernel+bounces-68368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1285795A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D3C28125B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF53208A9;
	Fri, 16 Feb 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW8i9EJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA56200C3;
	Fri, 16 Feb 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077025; cv=none; b=HxqR5ryzLkO88co9WBBaZqYh3h1ZsiUlPb6aKEiYgOiOMjMHwe6W57Qr9bn7ayqxdormW6ZnRjisE4aIoGazGNcTN7DjKx7P56rYs1EgQSiiqhffzVAVOUUsKQJnhhjM2pOtCO8TZjDSoBIwFBQ4ulDcVIs7UJQT88BR8FvcL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077025; c=relaxed/simple;
	bh=3fUqkoR5VIgWpzZjyR5yo8/i8AhhynJaZljV/ufzDns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CU3R3Fa2S2xg9B5UySecL7eTfbqWdmZ2/fOoMgCEoQAWafPn9VXKZGDC8NCumXGbmqGLjlfJ0i0gVst/nTeXJab+K4RpjQYq6qLggi1KMlwFMt5/V2clI2CKIOFKITLiolrYZwLDRrLEJi5L0nVVCaM3x+QitGpX66DmBgJMdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW8i9EJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBD0EC43399;
	Fri, 16 Feb 2024 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077024;
	bh=3fUqkoR5VIgWpzZjyR5yo8/i8AhhynJaZljV/ufzDns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rW8i9EJSvLy+JqlaTwWjwAIZ3xXCguZMAY7Ga1v4eDZumEsN4gGeQJVDSXVg4Wt6x
	 UMezsAtWPHMRyQL6H+AgZnR6dQqCYCLxbwDFLhvXtoj4gqUwnoCadb63FxWpvL0z9N
	 pdIn3/So56Hee63ajr5g9epfRaekiXJW8U29kWiJNgrHpSGv4fFLFB0/6uqiZepPwg
	 4sDg35yArTjUkqeK+U/X0C5HrvEgN2fV1xfs6jZWmUOmvfnlAGE/KAk5A/ijr7RFSA
	 lpaPsEGuVL83L5RgBQKs1LeqiPsZNPrXr4O7R1eLUi/TKfFyyLKSRSEa0YgpAOthg1
	 7DjZbzN1QCFlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE3DFDC99EC;
	Fri, 16 Feb 2024 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: adi: requires PHYLIB support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807702470.29322.7670195818484778024.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 09:50:24 +0000
References: <20240215070050.2389-1-rdunlap@infradead.org>
In-Reply-To: <20240215070050.2389-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, lkp@intel.com, lennart@lfdomain.com,
 alexandru.tachici@analog.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 23:00:50 -0800 you wrote:
> This driver uses functions that are supplied by the Kconfig symbol
> PHYLIB, so select it to ensure that they are built as needed.
> 
> When CONFIG_ADIN1110=y and CONFIG_PHYLIB=m, there are multiple build
> (linker) errors that are resolved by this Kconfig change:
> 
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_open':
>    drivers/net/ethernet/adi/adin1110.c:933: undefined reference to `phy_start'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_probe_netdevs':
>    drivers/net/ethernet/adi/adin1110.c:1603: undefined reference to `get_phy_device'
>    ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined reference to `phy_connect'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
>    drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `devm_mdiobus_alloc':
>    include/linux/phy.h:455: undefined reference to `devm_mdiobus_alloc_size'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_register_mdiobus':
>    drivers/net/ethernet/adi/adin1110.c:529: undefined reference to `__devm_mdiobus_register'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_stop':
>    drivers/net/ethernet/adi/adin1110.c:958: undefined reference to `phy_stop'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
>    drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_adjust_link':
>    drivers/net/ethernet/adi/adin1110.c:1077: undefined reference to `phy_print_status'
>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_ioctl':
>    drivers/net/ethernet/adi/adin1110.c:790: undefined reference to `phy_do_ioctl'
>    ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf60): undefined reference to `phy_ethtool_get_link_ksettings'
>    ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf68): undefined reference to `phy_ethtool_set_link_ksettings'
> 
> [...]

Here is the summary with links:
  - net: ethernet: adi: requires PHYLIB support
    https://git.kernel.org/netdev/net/c/a9f80df4f514

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



