Return-Path: <linux-kernel+bounces-109412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245EF8818C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B8B22B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D9086131;
	Wed, 20 Mar 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPvhtzof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3854BFD;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=TE4mJ887sxFAbE9SkAlbIW1+xoPYK2WaW/xC0ptnMNgdFOLczDxjGZh3BnaOXS30PrthvWmnu+UpXaof831dvwSibSnMmstiKYyHcywIk2jTDI6UNwkdBsxfIQYMRWmIvgHD15WCwRVWf0NLQElc4R/Ap1OU0VRWP2Dne3rH7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=unp53PjekzZMC/5vEoDX88dY1TMRGKCJLqvM+e32nrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jn0gDWMtX7nveseblN/+T4qA3ZKeoI6I37OE/Prg+VKmRfQIghCaH0ntmMvl0D6v4xFCO4uabJ28+fiMTb3o1y5kT1Gm797REDSBlJIkaHPe8+ylTXyKNO2zgeGUzi5Ap8HW0e1jHHXE9IGGlT/Mfyw5C9HjF72rhQLvApTEdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPvhtzof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17321C433F1;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=unp53PjekzZMC/5vEoDX88dY1TMRGKCJLqvM+e32nrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KPvhtzoff/CyBMTlGfR9NwYwpWRBtm25NWFcHyo0ahqdA2nGfogYpX/FBXrLuVU7v
	 iULJfq45x31mUbF3xLfSuN+vSeW/vOk6hnXwzgDTxFkXGZRWiHlZ/P2+4VenOKSyV4
	 o4lvpUgtuiuIyBI3/Y1C6T88zfPvDY+TEZjI+ZQqt/6HJv2kZLOAQQdgA/Qp6CpzLw
	 X6qu0bnnh0cxMJ7VCgAvNdePQV1OT3ufPqPoECYObsC9YkV/Qztr0S6NgoWY4vfCiD
	 JiudvBXgXe453vGFfQgD02RktoTGZdFIpB+VKROw0zv7rsWwiprSC1i2lz80i/HUGK
	 2B0+7GS0HtuhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A23BD84BB0;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783903.6804.2033008831254517156.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, apatel@ventanamicro.com, aou@eecs.berkeley.edu,
 rafael@kernel.org, viresh.kumar@linaro.org, atishp@rivosinc.com,
 conor.dooley@microchip.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 ajones@ventanamicro.com, lenb@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  8 Feb 2024 09:14:11 +0530 you wrote:
> This series enables the support for "Collaborative Processor Performance
> Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> encoding of CPPC registers as defined in RISC-V FFH spec [2].
> 
> CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this, is available at [2].
> 
> [...]

Here is the summary with links:
  - [v1,-next,1/3] ACPI: RISC-V: Add CPPC driver
    https://git.kernel.org/riscv/c/30f3ffbee86b
  - [v1,-next,2/3] cpufreq: Move CPPC configs to common Kconfig and add RISC-V
    https://git.kernel.org/riscv/c/7ee1378736f0
  - [v1,-next,3/3] RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
    https://git.kernel.org/riscv/c/282b9df4e960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



