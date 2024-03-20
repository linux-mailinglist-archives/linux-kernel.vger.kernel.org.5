Return-Path: <linux-kernel+bounces-109408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB08818C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC1CB22830
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D886122;
	Wed, 20 Mar 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaUNpUnF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893A33062;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=DYR3IikW2AepnHoK6kf3Dke1IoA8qofa/JqHSS9zy8v6W3snRRVSE918pkDMt/bHCz9IeYGY5dN4C6X4/XnYYP7jkILNjsIJRQKnTRGkndYdhiKX9WP8htlATp1S6phkU4iJvnfyk8FARG35ZIPfOUhsBifEVap0D3HGqZ+uv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=+PifagGk+gURTA9vY7TNHlo06xkwkczqhge93C7brus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=clFz2G9XVEy1Kv7l1J//c80gakmKYW0cHt1O6FwAHofgpIbbXcPFMExEWYv4bU8FOJA0zi3qfQIGeUGSSq1dGurFMhD6gMB3z4RmnrPKhpXFaIWJAU1lK6DqzCpPWjgB/QTrTmTGvgruv5ZRwmqBxrAS5JzL95byCJTjfL3Fhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaUNpUnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43F56C433A6;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=+PifagGk+gURTA9vY7TNHlo06xkwkczqhge93C7brus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RaUNpUnFQt9VpK/coGA3iciZ+/yHKVYvwi2+1siV7cdtSYp7NIa0QzYszfRlMGj85
	 ylwm/+3+VQcacNO3DQ9ST89McinYvkSYW5L+QFzbaJRO/exncukegYe89JYmnWi8Gx
	 v6xnM4ebhoB+F6UzxWBTmbQ+k5bMNzl6LtAkWJuFt0h2PGFtuhy0IvRrE7O1ElL1dj
	 mGvxj3njoHwuTqX9ChaFupTJMGZQrmoiEvIRDHpuc4Llk21rKw0iKjxVqSS/6hqnTO
	 1MrvVE81ve9GAA4c1zyrATV3LE9FNoCUkcS41kCesYeUcJnguivuaxPjyubCihLRkF
	 65HAx8WEs9E6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 366D6D98302;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783922.6804.3192320298991985852.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 aou@eecs.berkeley.edu, rafael@kernel.org, anup@brainfault.org,
 daniel.lezcano@linaro.org, atishp@rivosinc.com, conor.dooley@microchip.com,
 palmer@dabbelt.com, pavel@ucw.cz, paul.walmsley@sifive.com,
 ajones@ventanamicro.com, lenb@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 18 Jan 2024 11:59:27 +0530 you wrote:
> This series adds support for Low Power Idle (LPI) on ACPI based
> platforms.
> 
> LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this is available at [2].
> 
> [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#lpi-low-power-idle-states
> [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v/riscv-ffh.pdf
> 
> [...]

Here is the summary with links:
  - [v3,-next,1/3] cpuidle: RISC-V: Move few functions to arch/riscv
    https://git.kernel.org/riscv/c/6649182a383c
  - [v3,-next,2/3] ACPI: RISC-V: Add LPI driver
    https://git.kernel.org/riscv/c/4877fc92142f
  - [v3,-next,3/3] ACPI: Enable ACPI_PROCESSOR for RISC-V
    https://git.kernel.org/riscv/c/359df7c5be4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



