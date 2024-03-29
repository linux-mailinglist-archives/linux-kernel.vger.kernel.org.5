Return-Path: <linux-kernel+bounces-125310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A918923DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B081C22140
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EE013958D;
	Fri, 29 Mar 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIRTQ2bA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2313280B;
	Fri, 29 Mar 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739430; cv=none; b=fT5ef7pVjxA/n2yN5nTjtsjlflr2mQN045rkSiDHr5FZj+tZPNc5YtAOR6+VJQEzxjS2LI6VU5MHCl8KzlBYrpyyOtfg54avkWUZhcg+JdtDIMQQFLfbBLWBZvXc4NJASb5UJwwtH4Ty9VBQL15UgACOssZYTK9sPZSEsohGcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739430; c=relaxed/simple;
	bh=L9zWUTqD7rQIOv7MARtUdRVPPLRxucdz38zbiQL5wMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bBfGpezrjCXX8S5QIZwHLDskVtC+rtVSxI0IRqH265KJM8AChALcc96VH0inLbMuz3X8eAukvv30UyxaJy53TDg5sq0Td+V08KApZlDexTmcGwoWsl0cft1WC/z4dCiY7/gXNYlb1e5KzrOR1lWI9PNdMSefllnvcZWX1Qg1d9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIRTQ2bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF5B9C43394;
	Fri, 29 Mar 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711739430;
	bh=L9zWUTqD7rQIOv7MARtUdRVPPLRxucdz38zbiQL5wMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hIRTQ2bAo+ohJH15n2Ah4oCrZvCpTY/0C08YlWCX6rn0ZOswh7XnucCJuNsAgbtIk
	 QHY5BjtWiucVvpjiT7bcDjnXFbit9MUyXHJX8NV5WrjSjKp8n26SRvoQz0qnPmmsLl
	 YN93xpegJxCLSrbmao2DRY9ejonvzpPSDD/WtbX7qpWH9CfYv2A1YpbEODNhBfYBdv
	 iDdeW03b0E3Hdv41QpMnjty1VHzbUtKhptDDO7o83whvuAKhXDABn6DdKRbD7ETGDV
	 FJOztG2/+5QOCD5CfGNcMbhd7JNyz0ZOaytJIb3oXYFhIDHH+wDRy0PuMREldgC7wG
	 TPRzjryI7ZoPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDD43D84BAF;
	Fri, 29 Mar 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171173942990.5976.15448141381612932240.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:10:29 +0000
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lukma@denx.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com, michael.krummsdorf@tq-group.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 13:36:54 +0100 you wrote:
> From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> 
> The switch has 4 ports with 2 internal PHYs, but ports are numbered up
> to 6, with ports 0, 1, 5 and 6 being usable.
> 
> Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for MV88E6020 switch")
> Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> 
> [...]

Here is the summary with links:
  - net: dsa: mv88e6xxx: fix usable ports on 88e6020
    https://git.kernel.org/netdev/net/c/625aefac340f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



