Return-Path: <linux-kernel+bounces-125145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710468920DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22851C26D64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F944F887;
	Fri, 29 Mar 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUBvihu/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3863D966;
	Fri, 29 Mar 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727429; cv=none; b=UtJ1F91lPoqON0C0A7ESrdemOw1Fj/+2PYV2EiJYTPl/Z+Nm1YQyvg59ON7lEV+a7XUml5L+SnBQ8Wg/xrOsZ/2SvGVio+89Tig+ovhPOSSjwt0NxzlJNsySSmYOIXHP44GTHbfaWXPLe1Ywdx9k/gYUL0S19gEN6nZXHA3FFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727429; c=relaxed/simple;
	bh=1Gb9js9o92vHoW2ztLDWmNequldYaphj6neZme3mpUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJ9FMLfn8V3iiQaFwjav3J9CaF9K5JI3O6blgG5PMLPMa7JQtObcv2tNgH8tldgS3Zpd8PGPmLjeu69wqX2zbSUqW4eB/4c6yznAQa+PTkpfxF/Dwfwv2k6fTccxAu2/NRdL3bC/FWntPmT/W7vUmKTQS9ipmklMqalFXrRMpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUBvihu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5429CC43390;
	Fri, 29 Mar 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711727429;
	bh=1Gb9js9o92vHoW2ztLDWmNequldYaphj6neZme3mpUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RUBvihu/ul2t4K55eznxMPDb5Iq17zPcOlLL+gU1QLSR8T8uhh0i9PIrawRpRafg1
	 Szrqtp37PCF4Gkf3RUbqVrm07rlPkmOYYKyGpKF6XReUQNmpiLQ71lJn6THihy3aTh
	 AV1sKL22lRKO2/aKrLQTdQ3qTM2W3akzqzorkDh0cCZYdJPGtJenOCRS4cU7AqW472
	 dzblLuwtWvImC2Df7zbH3jVUeYGFmAJGiNub79LaxpL1QsbX7WyYJ+MC06WTL2WYG1
	 yeAu5Sn4UVl01g116UOeI2MTJ7VzXlNALxZw+cOiioj2YmcPKcZQeEX4LeT5Pl2o9K
	 vhZQrlvigejrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40B34D84BAF;
	Fri, 29 Mar 2024 15:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] mlxbf_gige: stop interface during shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171172742926.17508.15910798895938463118.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 15:50:29 +0000
References: <20240325210929.25362-1-davthompson@nvidia.com>
In-Reply-To: <20240325210929.25362-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 17:09:29 -0400 you wrote:
> The mlxbf_gige driver intermittantly encounters a NULL pointer
> exception while the system is shutting down via "reboot" command.
> The mlxbf_driver will experience an exception right after executing
> its shutdown() method.  One example of this exception is:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000011d373000
> [0000000000000070] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 96000004 [#1] SMP
> CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G S         OE     5.15.0-bf.6.gef6992a #1
> Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.0.2.12669 Apr 21 2023
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
> lr : mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
> sp : ffff8000080d3c10
> x29: ffff8000080d3c10 x28: ffffcce72cbb7000 x27: ffff8000080d3d58
> x26: ffff0000814e7340 x25: ffff331cd1a05000 x24: ffffcce72c4ea008
> x23: ffff0000814e4b40 x22: ffff0000814e4d10 x21: ffff0000814e4128
> x20: 0000000000000000 x19: ffff0000814e4a80 x18: ffffffffffffffff
> x17: 000000000000001c x16: ffffcce72b4553f4 x15: ffff80008805b8a7
> x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
> x11: 7f7f7f7f7f7f7f7f x10: c2ac898b17576267 x9 : ffffcce720fa5404
> x8 : ffff000080812138 x7 : 0000000000002e9a x6 : 0000000000000080
> x5 : ffff00008de3b000 x4 : 0000000000000000 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
>  mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
>  __napi_poll+0x40/0x1c8
>  net_rx_action+0x314/0x3a0
>  __do_softirq+0x128/0x334
>  run_ksoftirqd+0x54/0x6c
>  smpboot_thread_fn+0x14c/0x190
>  kthread+0x10c/0x110
>  ret_from_fork+0x10/0x20
> Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
> 
> [...]

Here is the summary with links:
  - [net,v1] mlxbf_gige: stop interface during shutdown
    https://git.kernel.org/netdev/net/c/09ba28e1cd3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



