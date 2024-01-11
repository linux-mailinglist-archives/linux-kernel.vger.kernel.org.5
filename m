Return-Path: <linux-kernel+bounces-23733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B0082B0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FF41F21470
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE24EB20;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8FJEJ5z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D629495CA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5CB9C43399;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=58hPWif0bJT32T7OOV+cmALx5lR57XsGkAKosD2LuBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8FJEJ5zF7veCXE4XnBK1whwUqZP5C/IZiSSrnK655xRtahkst6w7nYiYAsaJyB+H
	 WLTEv1H/dIsWhK/2aJs8DyZcEvzRrENAgBm41md9knLwCrb9Af9wNtwE3SBLEzP37t
	 oVHcfx7Ksk1VRReYHuCtccZ4zKzzmLidZkkuX1KppeGbV9G7rrYJbqTyOUtDiRHMFD
	 3IhI6y90LVFQrWgLvmqamlEgmS8CrdHblulG3yXkNNGddH787+S0U5EkxX+Jy+UKLd
	 +hCadxTPUCCSWr0SG/2T0jNG6OgnRt9iNmuH3HseVHnNdL93+Qgnu6SxlbcvajV/ZJ
	 hruxMK2YXrwAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0F63D8C974;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v4 0/2] riscv: errata: thead: use
 riscv_nonstd_cache_ops for CMO
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463765.20080.13600497512635410658.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231114143338.2406-1-jszhang@kernel.org>
In-Reply-To: <20231114143338.2406-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 14 Nov 2023 22:33:36 +0800 you wrote:
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
> 
> [...]

Here is the summary with links:
  - [RESEND,v4,1/2] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
    https://git.kernel.org/riscv/c/a4ff64edf9ed
  - [RESEND,v4,2/2] riscv: errata: thead: use pa based instructions for CMO
    https://git.kernel.org/riscv/c/3690492612ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



