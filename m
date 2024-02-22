Return-Path: <linux-kernel+bounces-76191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36B85F406
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6F286E25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E0374C5;
	Thu, 22 Feb 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUfCR60g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7228374;
	Thu, 22 Feb 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593026; cv=none; b=i5tb44B1zDunTh7e7c5I6w1Kf0xtN6DrEXirMeVgpvvttr+E2OIk92PdqA66HyB+934VpGzjOBYaDM+NuY/k0znTeqDvw6HeBTewSSoYYUhYwZhgog5S2N8cakYalv1X8nj2EVPBcSiAjkS1iOgCwaW0zC5zzPj7mgV6nxpKfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593026; c=relaxed/simple;
	bh=XqjirAAqRkGAyHgjU9BU+2mKaUfO1pvSnNkUGIRCfXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZnCq/JJCbAvo4o8QoEzVGNcXJ5C2yzGi3CMqK64fzeGaB45AgJhnWid1NeMWZy8ngeT9w1Kq61laQYFg1Gtbe6VYr3GDGIkuZMWMy1Ji8SPcyUBEJcHFRGkJXzQnqGxcPk9wucvyX5rP5+zYHO+gWtchbBRdneWF1xrH5kOFrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUfCR60g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E49C433F1;
	Thu, 22 Feb 2024 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708593026;
	bh=XqjirAAqRkGAyHgjU9BU+2mKaUfO1pvSnNkUGIRCfXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUfCR60g1fjFodjDb/iHz9rCYICuAvhxFnjYkdljtYroUdK4de69yR2YcDAy5xQDB
	 CGhFMJaSJZD/w7UuoHlAXvjYMdZR0p/wSVm0m+ywjXsJLp3aFzt9qd/xXOSdIeD2eK
	 tFuSYydta/GtWJvfRF5YEF7XGDtXiu7Q2gzG+Yw6/fqnIIF6k6NZvYRtjvZ+r883jO
	 wItkoPOXltwM+uajoquFIJJ6U4jO0eBHX0nIgoUHvOlfaHD6fu8NPzh9Jqv7tq+NOY
	 NbFipN0ilcBl6Dwb982/bHX4hc4Hb7iQSZNqokZs8S9vXkKaeOzaRrWU76ULjIIxg2
	 6fO7I4S+Gy6aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00094D84BBB;
	Thu, 22 Feb 2024 09:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: realtek: Fix rtl8211f_config_init() for
 RTL8211F(D)(I)-VD-CG PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170859302599.11577.10322371469324921304.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 09:10:25 +0000
References: <20240220070007.968762-1-s-vadapalli@ti.com>
In-Reply-To: <20240220070007.968762-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xiaoning.wang@nxp.com, wei.fang@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Feb 2024 12:30:07 +0530 you wrote:
> Commit bb726b753f75 ("net: phy: realtek: add support for
> RTL8211F(D)(I)-VD-CG") extended support of the driver from the existing
> support for RTL8211F(D)(I)-CG PHY to the newer RTL8211F(D)(I)-VD-CG PHY.
> 
> While that commit indicated that the RTL8211F_PHYCR2 register is not
> supported by the "VD-CG" PHY model and therefore updated the corresponding
> section in rtl8211f_config_init() to be invoked conditionally, the call to
> "genphy_soft_reset()" was left as-is, when it should have also been invoked
> conditionally. This is because the call to "genphy_soft_reset()" was first
> introduced by the commit 0a4355c2b7f8 ("net: phy: realtek: add dt property
> to disable CLKOUT clock") since the RTL8211F guide indicates that a PHY
> reset should be issued after setting bits in the PHYCR2 register.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY
    https://git.kernel.org/netdev/net/c/3489182b11d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



