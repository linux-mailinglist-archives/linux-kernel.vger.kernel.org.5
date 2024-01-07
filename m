Return-Path: <linux-kernel+bounces-18893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9AB8264BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637101F22A6C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3BC13ADE;
	Sun,  7 Jan 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh74H1Sm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3F134B5;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 510F0C433CA;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641424;
	bh=NHzXzRcCX47VNxqlzwG+0OQMD8LeyhKX7n7wbBoheL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lh74H1SmU7ptyvi1L7eft3F3qflI6bxWOKUX3VoR4TcpkjB52FuWjQ45D76OcP/Nf
	 CrK7mmXJOIB33qmjleb/RyzME2H0we39F1jCQ0G0kO40xxWQYL4zSqQ1Pii6qBVmNH
	 gVYxleOx0F2RoJQ/yTcRYlmwv34z6O960SNxau9DNmmv3Zy2+GDw3IIWwL1ErOQccG
	 zYNM/gc4xkjg2MXXA357nAS/8tu+JJ+6snIsobtUzFAfzziG1fIeSa7Fa5nfIRSzLC
	 4TqRA7rL2zWYkvAZtvDScL9yH4yql7AWxiC+9kAb8mu+Axgh7mHc/twwzy0M/0XkYU
	 u/mdFqVeBqH/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34978C4167F;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] mlxbf_gige: Enable the GigE port in mlxbf_gige_open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464142421.16555.13169210527122295576.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:30:24 +0000
References: <20240105160014.23353-1-asmaa@nvidia.com>
In-Reply-To: <20240105160014.23353-1-asmaa@nvidia.com>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: davem@davemloft.net, f.fainelli@gmail.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tbogendoerfer@suse.de, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davthompson@nvidia.com,
 florian.fainelli@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 5 Jan 2024 11:00:14 -0500 you wrote:
> At the moment, the GigE port is enabled in the mlxbf_gige_probe
> function. If the mlxbf_gige_open is not executed, this could cause
> pause frames to increase in the case where there is high backgroud
> traffic. This results in clogging the port.
> So move enabling the OOB port to mlxbf_gige_open.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] mlxbf_gige: Enable the GigE port in mlxbf_gige_open
    https://git.kernel.org/netdev/net/c/a460f4a68451

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



