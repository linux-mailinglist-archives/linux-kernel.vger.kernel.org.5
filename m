Return-Path: <linux-kernel+bounces-74726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD685D848
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F61C219F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADF69D26;
	Wed, 21 Feb 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7AizsU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B969962;
	Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519828; cv=none; b=VPTW729ypJyVcclZtn14OI0pbTwp6p+OYWPSs31MfG0Cu69ya3ujZQdTRnlfpoDFh8HE8zpl+QKlOnDFhLsYYUAHLXwuySPVFMyrz5KTp4V2Ero6B4/HCSnBZ28k2f0m+nqfyAjxJgoI2KUVsWFeMhLQ0XWD6Xu17XNHTX7TwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519828; c=relaxed/simple;
	bh=lneanaRetTbUaTbA8++ZJ4eDAzcd2jVVU7VARp/KLiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iXjbYDm6ShCGnO79vjCgIWJFoAF0rbLWIYPodgFMqdmi0lkBHopvnohpU9htd061Aw2DPdb9LC2YtyKJBd6s5QZm/zeTL4uZ9qV67tHZq2TXK7zIcHWtXd6waBZuu8RUt5/K86HM1WaHxgrb+IAQtK1t6zPSDATXWvMH3SHflt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7AizsU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66718C433C7;
	Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519828;
	bh=lneanaRetTbUaTbA8++ZJ4eDAzcd2jVVU7VARp/KLiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p7AizsU3m0/ttH4fdkRVVd6AK6OjGF2qD7+hn3ev9qGanGp9zOcljDj7i2hbzT52i
	 C8reG/21e3XccBL1rFpQQHDJUzltG6fwnt7foKlvMUO4DemBGImBm6Np3whEzKUk0s
	 rfBHURcUXbJpW+Gld/8YfORl/ur+HsFPDyUHyL+NoMYECGc/EovWhk9Kc65VGBVmM4
	 w19OqhyVv8OXLkwuuWQ7Ztu9BfHlbZ+4t9OZlg6+/yjihd6vpiPJL4TK+ad7kzb5XD
	 ybVpWgAv6J3MSwbn/PC+sAi7Fso5s+9ruTuykIKU+haeUTlhqidOEleqj2BMZ3BtL4
	 TMFlUuMMcs9Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53E20C00446;
	Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Rework GENET MDIO controller clocking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851982833.28838.11670954342538332576.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 12:50:28 +0000
References: <20240219204053.471825-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240219204053.471825-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 justin.chen@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 12:40:50 -0800 you wrote:
> This patch series reworks the way that we manage the GENET MDIO
> controller clocks around I/O accesses. During testing with a fully
> modular build where bcmgenet, mdio-bcm-unimac, and the Broadcom PHY
> driver (broadcom) are all loaded as modules, with no particular care
> being taken to order them to mimize deferred probing the following bus
> error was obtained:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses
    https://git.kernel.org/netdev/net-next/c/ee975351cf0c
  - [net-next,v2,2/3] net: bcmgenet: Pass "main" clock down to the MDIO driver
    https://git.kernel.org/netdev/net-next/c/ee2b4cf8b281
  - [net-next,v2,3/3] Revert "net: bcmgenet: Ensure MDIO unregistration has clocks enabled"
    https://git.kernel.org/netdev/net-next/c/ba0b78371c46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



