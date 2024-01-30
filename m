Return-Path: <linux-kernel+bounces-44498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518308422D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D38D28990F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CE67A00;
	Tue, 30 Jan 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phV+ecMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1B6772C;
	Tue, 30 Jan 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613626; cv=none; b=I9jXKGmG4f3K0vbLIkJ83hx0UiNQG/NwkvrdaJlbaGPw4yi0rqgzRkszQFX9y740Byxf8jiDP9yWt2S/TxM6ci4HobEd0OpKfqCFU7dvaM1HLPzNjF9UKQqomo9lYcp43lDqgPTF6kg9fzkU45evHVIspexVWk49yT65BY2pAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613626; c=relaxed/simple;
	bh=4WgsHwRacn2qpJFE/ea6xcPHbCY586oacAAWQwCer34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SpbD+Q7sa66fwpuf76Ky7ZwK1wmAyWwc9x1xWdDAZtHKbiNCZF03sy9vt+pOG/n1W36O7pMertF2uqTSeyvd8ho8YybXZwOnxd2HrJR0mToyLSJar0LmfYWsadptrRYQM9KVhcpQFE/U6kv8jq/zT2VXdsCVrXN1df3ueo7Fn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phV+ecMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79848C43390;
	Tue, 30 Jan 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706613625;
	bh=4WgsHwRacn2qpJFE/ea6xcPHbCY586oacAAWQwCer34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=phV+ecMClYA83sfpcAh1ZtpJ3NAmc6D4IAdKe18PBDsEjWc4eMoo1O2RdlZmNudos
	 ZRR0C8qI8PQoX87v6hmv/EJZtqoRUJNXtksypOXw3NWB49uZL1rVHm+kFADeqEtTjm
	 CwPIeCCakD4gz4mStIctGko/eZclVA/eyNCZvoLc9Wpl278TeTSwlRAaofyc2qWREb
	 fyUl6O0De56d57AwQxmFJ4Fw5Gg5dnOcyECW52rxMB0o6HxtH5e4hRtIBrOxEwV16j
	 F17NZJde0UXfT54wq2ozGqvHBU+UYKGBVwVY9aNZqtmlJpj8rBj9rvyZEW9m2eZT4P
	 Zq3Qa2tQQ9Bew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F9B7C395F3;
	Tue, 30 Jan 2024 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: micrel: Fix set/get PHC time for lan8814
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661362538.28487.10813020145691135794.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 11:20:25 +0000
References: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
 maxime.chevallier@bootlin.com, divya.koppera@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Jan 2024 08:30:42 +0100 you wrote:
> When setting or getting PHC time, the higher bits of the second time (>32
> bits) they were ignored. Meaning that setting some time in the future like
> year 2150, it was failing to set this.
> 
> The issue can be reproduced like this:
> 
>  # phc_ctl /dev/ptp1 set 10000000000
>  phc_ctl[12.290]: set clock time to 10000000000.000000000 or Sat Nov 20 17:46:40 2286
> 
> [...]

Here is the summary with links:
  - [net-next] net: micrel: Fix set/get PHC time for lan8814
    https://git.kernel.org/netdev/net-next/c/8e41d6644f9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



