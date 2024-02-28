Return-Path: <linux-kernel+bounces-85242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E6E86B2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AEE1F286E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31615B96D;
	Wed, 28 Feb 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq9+Wk21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E92D022
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133030; cv=none; b=XXmjhY/9XM9RDWAaeY3ALQOFIp2nqeY2/T2njYxxkYMdvH6C3IYLHW9OdkcHB1ixyT6VfT9pWgcHYnq0CV/Of93Plf4fvvVwp41JpZ4F5LsJFmuJs9bRQ9bzAH2RBY2hkyX6toGfkdpxf37IjbOC/DmkYkbwGcWOwvt9FSJw3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133030; c=relaxed/simple;
	bh=Hl4aguKOTd8JlLqCsXIN7K+U/MvNiYnC1LzWdx7ZBq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqECxOq4LbqXnqxe8i48BooI25zdoc+FxYJGLcpYZlNogHWxz9DiVOMDk1XqgiKb5aW9qirH+Hu7UwHVPOdoV+Cw9q3fNy7UM9uWC4hx9+LlkLzj5PYSaCs3Ome1oVBK1qAOYL0G22dgGNGZEzdxU4mMsf9MXEPo+W9joY70bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq9+Wk21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD5D9C433F1;
	Wed, 28 Feb 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133029;
	bh=Hl4aguKOTd8JlLqCsXIN7K+U/MvNiYnC1LzWdx7ZBq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oq9+Wk21fB3vdeq1PxsrpEc6OYKE8ugwMPUiHXnzSzt0I1QhRZBqNX1jBK2QB0zfy
	 yPlEtVWMmXrxLN34z+5fBmQ46+f3zD66tkOhozaVrDUVpS9sr+VghyVXor3YpDzq2U
	 cj1p6vYpSvWJK2rJ+T/HGJjUAl4KOjA3AY3VXxyUnDN0YuE6W0U20Ux+UCHWpdjd9M
	 lTlh8f+Dh0klWreWUZ3+yoq+wNqrDeCuqGM42PvXPan/xBnaf38uGHO8zhzVIAkSVK
	 680qGQ5knv1t4Y9escBw9XxPK7B2qi1C590U9MFEgyj2xu2gnIlIXzKRKdGpSVemRY
	 oVUIHSu8k7TWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2121C595D2;
	Wed, 28 Feb 2024 15:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] drivers: perf: ctr_get_width function for legacy is not
 defined
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170913302972.9913.1220229545519276494.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 15:10:29 +0000
References: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: linux-riscv@lists.infradead.org, atishp@atishpatra.org,
 anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alexghiti@rivosinc.com, ajones@ventanamicro.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 5 Dec 2023 12:25:54 +0300 you wrote:
> With parameters CONFIG_RISCV_PMU_LEGACY=y and CONFIG_RISCV_PMU_SBI=n
> linux kernel crashes when you try perf record:
> 
> $ perf record ls
> [   46.749286] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [   46.750199] Oops [#1]
> [   46.750342] Modules linked in:
> [   46.750608] CPU: 0 PID: 107 Comm: perf-exec Not tainted 6.6.0 #2
> [   46.750906] Hardware name: riscv-virtio,qemu (DT)
> [   46.751184] epc : 0x0
> [   46.751430]  ra : arch_perf_update_userpage+0x54/0x13e
> [   46.751680] epc : 0000000000000000 ra : ffffffff8072ee52 sp : ff2000000022b8f0
> [   46.751958]  gp : ffffffff81505988 tp : ff6000000290d400 t0 : ff2000000022b9c0
> [   46.752229]  t1 : 0000000000000001 t2 : 0000000000000003 s0 : ff2000000022b930
> [   46.752451]  s1 : ff600000028fb000 a0 : 0000000000000000 a1 : ff600000028fb000
> [   46.752673]  a2 : 0000000ae2751268 a3 : 00000000004fb708 a4 : 0000000000000004
> [   46.752895]  a5 : 0000000000000000 a6 : 000000000017ffe3 a7 : 00000000000000d2
> [   46.753117]  s2 : ff600000028fb000 s3 : 0000000ae2751268 s4 : 0000000000000000
> [   46.753338]  s5 : ffffffff8153e290 s6 : ff600000863b9000 s7 : ff60000002961078
> [   46.753562]  s8 : ff60000002961048 s9 : ff60000002961058 s10: 0000000000000001
> [   46.753783]  s11: 0000000000000018 t3 : ffffffffffffffff t4 : ffffffffffffffff
> [   46.754005]  t5 : ff6000000292270c t6 : ff2000000022bb30
> [   46.754179] status: 0000000200000100 badaddr: 0000000000000000 cause: 000000000000000c
> [   46.754653] Code: Unable to access instruction at 0xffffffffffffffec.
> [   46.754939] ---[ end trace 0000000000000000 ]---
> [   46.755131] note: perf-exec[107] exited with irqs disabled
> [   46.755546] note: perf-exec[107] exited with preempt_count 4
> 
> [...]

Here is the summary with links:
  - [1/2] drivers: perf: ctr_get_width function for legacy is not defined
    https://git.kernel.org/riscv/c/682dc133f83e
  - [2/2] drivers: perf: added capabilities for legacy PMU
    https://git.kernel.org/riscv/c/65730fe8f4fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



