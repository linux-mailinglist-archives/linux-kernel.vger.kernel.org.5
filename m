Return-Path: <linux-kernel+bounces-12998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9681FE37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C02B1F21728
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11B749E;
	Fri, 29 Dec 2023 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8pciKes"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAD3210;
	Fri, 29 Dec 2023 08:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44BCFC433C9;
	Fri, 29 Dec 2023 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703839224;
	bh=IjpVg6hD33ym8R6MyYwMOCGULI57jUQt3uBN/v5NCCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h8pciKest1dn6THeiPPg53E6vzeOg9BbQI8vSwL29LT9IbuL116T4h9HOVHxeD05I
	 nS1pI4AIxzSoZhz8XTzFK4wk8STtnwmy8JDwvqfdzEqqs1MlzvAg2oJwUS+qge+WeC
	 1Nptt7bvt45YFGnZSjXy7R3Okkn5DQ4so6Mt116YAcZZlDTcAOwY72M1fwEr7uik53
	 LJDU+3nh/NC4Llb+cHME94qTwTta9MfwyRwW94Gs+RFgcBrc7THYAsxPO6nrlz7tUw
	 eFxneZVLYHtLXNzEwU0myqFUQpncDtHxyu2L+Utqn1UiaiqqeOozW7RIFGns5B26TY
	 YM3SLGEIeLFLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28956E333D8;
	Fri, 29 Dec 2023 08:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] ptp: ocp: fix bug in unregistering the DPLL subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170383922416.26195.6819591096123893310.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 08:40:24 +0000
References: <20231220081914.16779-1-maimon.sagi@gmail.com>
In-Reply-To: <20231220081914.16779-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
 jiri@resnulli.us, arkadiusz.kubalewski@intel.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Dec 2023 10:19:14 +0200 you wrote:
> When unregistering the DPLL subsystem the priv pointer is different then
> the one used for registration which cause failure in unregistering.
> 
> Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
> ---
>  drivers/ptp/ptp_ocp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] ptp: ocp: fix bug in unregistering the DPLL subsystem
    https://git.kernel.org/netdev/net/c/97417cd79ce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



