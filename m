Return-Path: <linux-kernel+bounces-165916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1E8B935B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79271C21B93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121B1B966;
	Thu,  2 May 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5dHo+Tw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428919470;
	Thu,  2 May 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616432; cv=none; b=IaXjgIlgSPoIn3BZgfd7bFEnu4WtGuzv73ZvzIodfa+aLK8Y7bf9vNzSqXweaFlQRXHEa1OaE5/UU22P5HpRQkNY9Oz2cxjjBIc/gWD8tC1HiXvj7C5DSKMqmYehio7Y9yzfkWXIvcgg7vxUEEFPBs7fNTZXfLwazQbcjzvqlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616432; c=relaxed/simple;
	bh=Tpqy/To3eyNk6Zv/KuSecwywYBWSoGoV2InmXgvO8aQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSiESpSeqUz41C+hBuC9J3UwyBWtKCP/0zq7s8IBuxVo+3Eh99FCpIo5Ue8dkfSyX2YfoWuetRU/vvL9th0r7MQhvkI6/e7WH+3ne/2x7FMUvKAUKagPi9CUiQ23jeU/ffYgJ8vqKBwrReweZ9Vt1qpFZHvhmOCs676zsfNodVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5dHo+Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 907C1C4AF51;
	Thu,  2 May 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714616431;
	bh=Tpqy/To3eyNk6Zv/KuSecwywYBWSoGoV2InmXgvO8aQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5dHo+TwXp0UdhsBiqx32LvZNAn6PZlhF/edgBIwUHtEy7Oxb7Ye0SkDX+Lho1XQq
	 /AN13G8s2ZzjMEDaBZIu/H0OSlQ4xuUBqZOghSIU1EAGoR0ffTa1OUS7YcG7npmpao
	 GP87msYPrfLFJbSarfHoyhMPWw11EBoVgR5vdl8qIxH2t5Wi/hQRUk9rIuJ3SIT7f1
	 lG3k7A0wiEcz8yz1osYbhPdiFw+cfOZpmtOiIZZg8CYMj/LHlt3BzvAqq6WEyiKjyO
	 clEHVwDm/H+FDNu2bAMikrdAsydUrU+0BUwPJv7qIIGilpY81FTaC63eMDA6D1rA0D
	 RT3xx5/m1NHLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84793C43444;
	Thu,  2 May 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: dsa: adjust_link removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171461643153.4262.10712563951125097802.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 02:20:31 +0000
References: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 09:48:14 -0700 you wrote:
> Now that the last in-tree driver (b53) has been converted to PHYLINK, we
> can get rid of all of code that catered to working with drivers
> implementing only PHYLIB's adjust_link callback.
> 
> Changes in v3:
> 
> - removed additional code in dsa_port_phylink_mac_link_down pertaining
>   to the phy_device reference
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: dsa: Remove fixed_link_update member
    https://git.kernel.org/netdev/net-next/c/ad3e1287c6f3
  - [net-next,v3,2/2] net: dsa: Remove adjust_link paths
    https://git.kernel.org/netdev/net-next/c/8a021a863a7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



