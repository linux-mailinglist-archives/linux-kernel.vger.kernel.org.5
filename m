Return-Path: <linux-kernel+bounces-24178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CE82B89A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF8B24E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB43117EB;
	Fri, 12 Jan 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJzGZWmp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833AEC5;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F028C43394;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705019430;
	bh=c+vU2dt7/uHjhfifB+I3qS5haVtHbaE12aG1kUdgD9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FJzGZWmp4+cTLyj65KrtgwhvudKg6SwLGLVaI1ko7XID2WLFyRLB++YIAtcHvmcrf
	 YrmbYMmQCijcSVJou9I6DmkFFHRLmoQDqKUMt/agLo4FUdVsewJ4+B2mFjako1HMrf
	 +ia3Z00GNssv/rdvWO6nHu8sDCKbafNshCVxwqcnk6pOs4IqLjV6Xk2KVijeABgenY
	 0ctZsO3ipFJXbPoTeEwIiHS8HYlhnGWPAf+gmuHqRRzmyoipptGlBhqB0jsu+Otqwu
	 e10eMnRMqsU8g+zIOFAtls2QhphMJ73inIIThfu8wA9gTjIU6mGLCabepKEAe9YEVi
	 1ZgvFfZDzRGUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 854E8DFC698;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next v2] wangxunx: select CONFIG_PHYLINK where needed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170501943054.11195.9618372378165993793.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:30:30 +0000
References: <20240111162828.68564-1-arnd@kernel.org>
In-Reply-To: <20240111162828.68564-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, linux@armlinux.org.uk, andrew@lunn.ch,
 maciej.fijalkowski@intel.com, andriy.shevchenko@linux.intel.com,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jan 2024 17:27:53 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ngbe driver needs phylink:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
> wx_ethtool.c:(.text+0x458): undefined reference to `phylink_ethtool_nway_reset'
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_remove':
> ngbe_main.c:(.text+0x7c): undefined reference to `phylink_destroy'
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_open':
> ngbe_main.c:(.text+0xf90): undefined reference to `phylink_connect_phy'
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.o: in function `ngbe_mdio_init':
> ngbe_mdio.c:(.text+0x314): undefined reference to `phylink_create'
> 
> [...]

Here is the summary with links:
  - [net-next,v2] wangxunx: select CONFIG_PHYLINK where needed
    https://git.kernel.org/netdev/net/c/b3739fb3a9e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



