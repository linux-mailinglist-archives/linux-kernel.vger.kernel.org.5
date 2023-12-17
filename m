Return-Path: <linux-kernel+bounces-2794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20B8161F9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE9D282E4B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CA481CC;
	Sun, 17 Dec 2023 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMp9IkJe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE3481AF;
	Sun, 17 Dec 2023 20:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C7ACC433CA;
	Sun, 17 Dec 2023 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702843998;
	bh=7z75hvbTI6J39jyXvqtmugGqUuAx5ru4avwg0NE7/Yk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZMp9IkJeAtFPXmyrh985ZHNUGiC6hwzcn+TMhtdf4sTCZeHocILmMFQeq5aYSIu8z
	 HDz6Hg0HjHN0nMFFleLmXQJWRptO5qJdScoyt8pLFZOMQnyMHmFkFGRU3ageoRf2eG
	 K36joc3RmX2C3TemMpkaoVlupbgDcJ+4u7QXQrG/h8emKCCHhoEoggKEbYyu8x8+iT
	 F5rWzmAmcXq79XmiUQl+ATtIa9EFiUSwtNYx6tFsMpgpn56LlLec7wM0GTkh9lA0pm
	 WjH5TuBS5ca4fXCyyAAZ+AzVmJbtZVh/GMYNPrToxf6/exoj34DkU3/v+OINhVvGU3
	 +miWWKlWA2eVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 024F1DD4EF9;
	Sun, 17 Dec 2023 20:13:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v8 0/4] net: phy: add PHY package base addr + mmd
 APIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170284399800.30184.7405712360421531650.git-patchwork-notify@kernel.org>
Date: Sun, 17 Dec 2023 20:13:18 +0000
References: <20231215131534.7188-1-ansuelsmth@gmail.com>
In-Reply-To: <20231215131534.7188-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.epping@missinglinkelectronics.com, olteanv@gmail.com,
 harini.katakam@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 14:15:30 +0100 you wrote:
> This small series is required for the upcoming qca807x PHY that
> will make use of PHY package mmd API and the new implementation
> with read/write based on base addr.
> 
> The MMD PHY package patch currently has no use but it will be
> used in the upcoming patch and it does complete what a PHY package
> may require in addition to basic read/write to setup global PHY address.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] net: phy: make addr type u8 in phy_package_shared struct
    https://git.kernel.org/netdev/net-next/c/ebb30ccbbdbd
  - [net-next,v8,2/4] net: phy: extend PHY package API to support multiple global address
    https://git.kernel.org/netdev/net-next/c/9eea577eb115
  - [net-next,v8,3/4] net: phy: restructure __phy_write/read_mmd to helper and phydev user
    https://git.kernel.org/netdev/net-next/c/028672bd1d73
  - [net-next,v8,4/4] net: phy: add support for PHY package MMD read/write
    https://git.kernel.org/netdev/net-next/c/d63710fc0f1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



