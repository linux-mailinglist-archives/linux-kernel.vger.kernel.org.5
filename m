Return-Path: <linux-kernel+bounces-119984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3088CFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E951F82C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BED13D628;
	Tue, 26 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRScKgcT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9D12AAF3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487429; cv=none; b=nEAwdT8sPgK15kU63DbH3dhGu2hWTZNipqRpDJQ2KN052LHWML1p7a0xSH90k13fmCXSPI6gmQbjhHW6IUjoFwlGwstOFo6fUoVzj4y0/gZ/Oqtu8snF+6uFnbLs/hn1aoM/VmAZO7P0sSGjMj5vJmGsyTWawz5hmZ/Ipoa34Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487429; c=relaxed/simple;
	bh=SboH/0hyVW3B3ksnsDhHW9j/7t4aFvMtUDl7w8vJNLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tNVc2ICs4xUv6BS6Iik+uHlndkq8Jlis2lamHks4PGY64pIRaDuqtb350e+roEzXAPCXIav4pTva3loD8BI6yDG7NHNVVsOChmily3wDi+KRAzJyItxPa0M8jx83ofb+mQ4JBysTNYs8g+V/xsFUOjVDcx0/XfXf2rpSMQJIgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRScKgcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF0BC43399;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487429;
	bh=SboH/0hyVW3B3ksnsDhHW9j/7t4aFvMtUDl7w8vJNLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NRScKgcTknA+A3TXBJHEmBkorPQ7Am9bUTOF0MfmYbKYjUy/j00JAypltFGB1Gf08
	 9gPMk+PyGlynA19kHDVdvpsDdwTVY4kTdRYpUumezsrkpm+GzK+vYqdL40OH9IoUw5
	 muxR1DyU6isBhVQM6KM8kI7bquofImO8heLVkixaCOEAV7Tpg4N7nv14MVSx15y4XM
	 zRx6RrNb5KXbnc+V8WS2Xklzyev2oHQ/MTpcTsgqbP+JdUo+n4JkkLTWRp3ZHCJ4+W
	 aYJSKmNjWv94HS2kqjbbep6Xi3G7xhRDbT7NVXQZDjMfpl+LyjPLqt6VjYqYACYu6X
	 mUTlt55qEJn3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D929D95062;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: mm: Fix prototype to avoid discarding const
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171148742944.11448.2500869883007069793.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 21:10:29 +0000
References: <20240301201837.2826172-1-samuel.holland@sifive.com>
In-Reply-To: <20240301201837.2826172-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
 alexghiti@rivosinc.com, ajones@ventanamicro.com, apatel@ventanamicro.com,
 dylan@andestech.com, jszhang@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, sergey.matyukevich@syntacore.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  1 Mar 2024 12:18:32 -0800 you wrote:
> __flush_tlb_range() does not modify the provided cpumask, so its cmask
> parameter can be pointer-to-const. This avoids the unsafe cast of
> cpu_online_mask.
> 
> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - riscv: mm: Fix prototype to avoid discarding const
    https://git.kernel.org/riscv/c/674bc0168e6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



