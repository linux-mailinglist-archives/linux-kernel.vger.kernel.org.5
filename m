Return-Path: <linux-kernel+bounces-103242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611A87BCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AE32846C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434D535B8;
	Thu, 14 Mar 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG+C/r13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA857861;
	Thu, 14 Mar 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419432; cv=none; b=hzeup4Oatr/M7KkX8iUSS6a+Wj82iIugUObXVqekX2eA6AGuoS4Hi9fymxvXZvhvSGA0x9DgX5WS6m+Mlx9xLX3c/CEJP3ptc0igBxuFjA9M200MZ4U1MDyVkCqX/WhM5o5Yq3pEmPaOxLdZ+QBKaWCAcrtBLHYRDaCReXIwC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419432; c=relaxed/simple;
	bh=CrTSWvnI80HBCf2z8Oy2nHbmglsJV2g15ydY/Fnd+/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uSw+Cs0yJAhDIn893ELZie3+hlaLWxDh/+BNYnv/fYpUU5Id9FZ5kcOz3ZcZE/n1uhTE+IbwljOpG38tFJKq6RS80qWQKbqcJBDWLzWPmmspkQVyStWXG7h3Y2WkcCmo6cb/keChZ/b6FrcvxWgut2nQMnc9xyRUtSIsncSYF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG+C/r13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0781EC433A6;
	Thu, 14 Mar 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710419432;
	bh=CrTSWvnI80HBCf2z8Oy2nHbmglsJV2g15ydY/Fnd+/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oG+C/r13TmKdzhAlJcO0u+vL0vp9yOVmJ0g/oiKWmipU+n6rJquFJCWqrNOQSQ2k4
	 ccIcGlpXIeboz94YUQO3bvjZFHoQJ6QV7wUhmBeJTFg5AWNmPZJYvIZIrJsFwFY2of
	 OIDxH2h1iJBf+ExBpnRAcKnFNtoX8rVXNSVgbDEoVlaoUHKsiFD1FrD6Tj7O9vsH/i
	 bk0FxwUKy6ccBHLapb0AVzUUOBDcALyYpl6oV9SH4llTH7PkbUQmxG8XfVK3qfK+BC
	 mJ2zLPRrgeNtsRC/QnH5pih+YJGWb/AwwBnL8wrVtonOOJpKYURuS/S2mY0VJCAJFt
	 54/cvGAWu8vMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E921DD95055;
	Thu, 14 Mar 2024 12:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 00/10] Support Andes PMU extension
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171041943194.26728.3807889559884607630.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 12:30:31 +0000
References: <20240222083946.3977135-1-peterlin@andestech.com>
In-Reply-To: <20240222083946.3977135-1-peterlin@andestech.com>
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, adrian.hunter@intel.com,
 ajones@ventanamicro.com, alexander.shishkin@linux.intel.com,
 andre.przywara@arm.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 atishp@atishpatra.org, conor+dt@kernel.org, conor.dooley@microchip.com,
 conor@kernel.org, devicetree@vger.kernel.org, evan@rivosinc.com,
 geert+renesas@glider.be, guoren@kernel.org, heiko@sntech.de,
 irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org,
 jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com,
 mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com,
 namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
 sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com,
 uwu@icenowy.me, wens@csie.org, will@kernel.org, inochiama@outlook.com,
 unicorn_wang@outlook.com, wefu@redhat.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 22 Feb 2024 16:39:36 +0800 you wrote:
> Hi All,
> 
> This patch series introduces the Andes PMU extension, which serves the
> same purpose as Sscofpmf and Smcntrpmf. Its non-standard local interrupt
> is assigned to bit 18 in the custom S-mode local interrupt enable and
> pending registers (slie/slip), while the interrupt cause is (256 + 18).
> 
> [...]

Here is the summary with links:
  - [v9,01/10] riscv: errata: Rename defines for Andes
    https://git.kernel.org/riscv/c/be5e8872b3fb
  - [v9,02/10] irqchip/riscv-intc: Allow large non-standard interrupt number
    https://git.kernel.org/riscv/c/96303bcb401c
  - [v9,03/10] irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
    https://git.kernel.org/riscv/c/f4cc33e78ba8
  - [v9,04/10] dt-bindings: riscv: Add Andes interrupt controller compatible string
    https://git.kernel.org/riscv/c/b88727d554f0
  - [v9,05/10] riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes INTC
    https://git.kernel.org/riscv/c/95113bb70515
  - [v9,06/10] perf: RISC-V: Eliminate redundant interrupt enable/disable operations
    https://git.kernel.org/riscv/c/ea0e0178e101
  - [v9,07/10] perf: RISC-V: Introduce Andes PMU to support perf event sampling
    https://git.kernel.org/riscv/c/bc969d6cc96a
  - [v9,08/10] dt-bindings: riscv: Add Andes PMU extension description
    https://git.kernel.org/riscv/c/61609bf2b29d
  - [v9,09/10] riscv: dts: renesas: Add Andes PMU extension for r9a07g043f
    https://git.kernel.org/riscv/c/270fc77e7b0e
  - [v9,10/10] riscv: andes: Support specifying symbolic firmware and hardware raw events
    https://git.kernel.org/riscv/c/f5102e31c209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



