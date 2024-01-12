Return-Path: <linux-kernel+bounces-24195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9EB82B8D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347361C23729
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291C23D3;
	Fri, 12 Jan 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7WBKOj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D881C;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4197AC43609;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021228;
	bh=Qd5SZE3JmWtAa69rh7hF5wfsze9bGw+rfiAn0kYe9z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E7WBKOj28I30lCmRC3K/4VXF2cLINGpUlciAuWHrJx5yjFBIU4VGFy5fUZTRPVTel
	 lC2NdHwTnRJZbi+lLC4vBF9gKFnnsrlY4SXBkmX6/bq3SCPqyF+gXQtxFhMEItkfy+
	 cnRn9MhTEZjqUmkg7VQ9oxzRNPuFBaH0Z+LbWU4OGG4P4ixIh9dVY5iKdJi3t69TJf
	 zkDhnvajHoJbszFQRlfxxPvtq9lNr1Z57Qj1NuJISQYm0SI6FnItUA4+yd0kw4Zi+t
	 Wy/e0gBmGKSEXtSJnIysp62AoZsOK0f7emtsszdR2VjfsbyHV+AYrqiX187trk4rd3
	 v16L2tC3Krf3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C64BD8C96C;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] net: ethernet: ti: am65-cpsw: Allow for MTU values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502122817.27071.16313545781021735290.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 01:00:28 +0000
References: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
In-Reply-To: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
To: =?utf-8?q?Sanju=C3=A1n_Garc=C3=ADa=2C_Jorge_=3CJorge=2ESanjuanGarcia=40duago?=@codeaurora.org,
	=?utf-8?q?n=2Ecom=3E?=@codeaurora.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, grygorii.strashko@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Jan 2024 08:55:39 +0000 you wrote:
> The am65-cpsw-nuss driver has a fixed definition for the maximum ethernet
> frame length of 1522 bytes (AM65_CPSW_MAX_PACKET_SIZE). This limits the switch
> ports to only operate at a maximum MTU of 1500 bytes. When combining this CPSW
> switch with a DSA switch connected to one of its ports this limitation shows up.
> The extra 8 bytes the DSA subsystem adds internally to the ethernet frame
> create resulting frames bigger than 1522 bytes (1518 for non VLAN + 8 for DSA
> stuff) so they get dropped by the switch.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames
    https://git.kernel.org/netdev/net/c/64e47d8afb5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



