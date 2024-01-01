Return-Path: <linux-kernel+bounces-13869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21D8213D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC56828270A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7D4A3C;
	Mon,  1 Jan 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGqNKWiT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A728F9;
	Mon,  1 Jan 2024 13:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77E6AC433D9;
	Mon,  1 Jan 2024 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704114624;
	bh=44aD366+hddIreDiU/oxnNmGWYpZf/5UmQRAJOD8AkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGqNKWiTM3aK4uvnffsG7zFqXdZnkqX/4rjZPZuAqmufMbidjz8x4RPnW2FVI1Uhg
	 7AFuOV3o3x2aFNM35/zXk1nFxlmLNArvc7pDO0HgnVcTxWXhzXke/n7LUZSmdEJe9Z
	 ADWEYP+gFGCh1xjOchAYEi0FSAmFpoFyJvr1ataCvGHTDCAXsc53ACa0u10FLe4kGg
	 xiVfytHlAtpUQpw0fBSUSzErV5jrTnLHCkHjhHXn9zXqX4tMl1PUdjQnTX7TFbWBrK
	 sX4mm45sG9Bqa09g76c86M/goyKLdrDXZauBPsU3Nd/EtV92mF3WopKB+kpn8NrX3Z
	 12GWXdr2ZrfOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67242DCB6CD;
	Mon,  1 Jan 2024 13:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: get/put device node during
 (un)registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170411462441.15417.16905783990213974323.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 13:10:24 +0000
References: <20231220045228.27079-2-luizluca@gmail.com>
In-Reply-To: <20231220045228.27079-2-luizluca@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Dec 2023 01:52:29 -0300 you wrote:
> The __of_mdiobus_register() function was storing the device node in
> dev.of_node without increasing its reference count. It implicitly relied
> on the caller to maintain the allocated node until the mdiobus was
> unregistered.
> 
> Now, __of_mdiobus_register() will acquire the node before assigning it,
> and of_mdiobus_unregister_callback() will be called at the end of
> mdio_unregister().
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio: get/put device node during (un)registration
    https://git.kernel.org/netdev/net-next/c/cff9c565e65f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



