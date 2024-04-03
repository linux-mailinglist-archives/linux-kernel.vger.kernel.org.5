Return-Path: <linux-kernel+bounces-129928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248E897223
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8433A1F2AFB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E41494CD;
	Wed,  3 Apr 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVMeXyim"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019551494A4;
	Wed,  3 Apr 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153751; cv=none; b=I4kHHHfziLAvObBw50tS0+rq6zAJ0CzirFk5/AgZqDwLaC3q4/U76xuluXADyiVhuLpyWAMVhJaDYSCYDiz7dFoIOfgJMJVBYHbhJBiMybqXNAc9u48vj62ie5fQJsizbWNUAvwyoNv+7Hnfq00OHe/vtVARj5ZKbQUx+4SLddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153751; c=relaxed/simple;
	bh=fhWJwSS6WUV/rQ1vsqKn3NpS8O4ZJ7RWPCIyi0ILAjg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=s7R1aBASuwesollcxBaLp5qXgl68t/YXfpx7zdm4ElVw+dt9KNNe33s0+EDl4kSXJNXmyO0DKuWaB/ZMLZBva2We9+zZzp6aZceATZ7dOuXb7JgN0C1sPTYgw7gL/f0vzIsr9TrdTDzaCrj8aBJCh7t6g9Pqd6HogNzzo98SOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVMeXyim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB8EC433A6;
	Wed,  3 Apr 2024 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153750;
	bh=fhWJwSS6WUV/rQ1vsqKn3NpS8O4ZJ7RWPCIyi0ILAjg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qVMeXyimG4WyeARwYMaux29uT2VipP+ejvreMeuSgGiscGgrKQEvS5oHXOig66ADg
	 jhlHyt69Ezu3ZeCqEBieUe+3deKg6DBvCcoPThTcpMqm+c2GHHEFyCr0Ur40UaBn88
	 l/zzbjq1jO16rDFUJ7O2vhbaVhwa1//BJZ55CV0Ih9ywWGWaU9oKNDlaMxBsPhKEBP
	 pMxQV75XCMu1Z+4Z5+VAqeximZ9da+yMgzXuoFU9drDuMqlAIBPgVV+wowpJF7oAJv
	 bEErCovXIf6jU++9VxTrUoTKVbhFmPtD9n7P+PcwXA5s2c3/rLd1680Sses3eywqQx
	 S4t5Ge6o9HPcQ==
Date: Wed, 03 Apr 2024 09:15:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: phone-devel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-kernel@vger.kernel.org, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>, 
 Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Lubomir Rintel <lkundrak@v3.sk>, Will Deacon <will@kernel.org>, 
 Karel Balej <balejk@matfyz.cz>, linux-clk@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, Tony Lindgren <tony@atomide.com>, 
 David Wronek <david@mainlining.org>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, Tony Luck <tony.luck@intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
Message-Id: <171215356225.3499035.10345778780745596314.robh@kernel.org>
Subject: Re: [PATCH v9 0/9] Initial Marvell PXA1908 support


On Tue, 02 Apr 2024 22:55:36 +0200, Duje Mihanović wrote:
> Hello,
> 
> This series adds initial support for the Marvell PXA1908 SoC and
> "samsung,coreprimevelte", a smartphone using the SoC.
> 
> USB works and the phone can boot a rootfs from an SD card, but there are
> some warnings in the dmesg:
> 
> During SMP initialization:
> [    0.006519] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
> [    0.006542] CPU features: Unsupported CPU feature variation detected.
> [    0.006589] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
> [    0.010710] Detected VIPT I-cache on CPU2
> [    0.010716] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
> [    0.010758] CPU2: Booted secondary processor 0x0000000002 [0x410fd032]
> [    0.014849] Detected VIPT I-cache on CPU3
> [    0.014855] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
> [    0.014895] CPU3: Booted secondary processor 0x0000000003 [0x410fd032]
> 
> SMMU probing fails:
> [    0.101798] arm-smmu c0010000.iommu: probing hardware configuration...
> [    0.101809] arm-smmu c0010000.iommu: SMMUv1 with:
> [    0.101816] arm-smmu c0010000.iommu:         no translation support!
> 
> A 3.14 based Marvell tree is available on GitHub
> acorn-marvell/brillo_pxa_kernel, and a Samsung one on GitHub
> CoderCharmander/g361f-kernel.
> 
> Andreas Färber attempted to upstream support for this SoC in 2017:
> https://lore.kernel.org/lkml/20170222022929.10540-1-afaerber@suse.de/
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> 
> Changes in v9:
> - Update trailers and rebase on v6.9-rc2, no changes
> - Link to v8: https://lore.kernel.org/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr
> 
> Changes in v8:
> - Drop SSPA patch
> - Drop broken-cd from eMMC node
> - Specify S-Boot hardcoded initramfs location in device tree
> - Add ARM PMU node
> - Correct inverted modem memory base and size
> - Update trailers
> - Rebase on next-20240110
> - Link to v7: https://lore.kernel.org/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr
>   and https://lore.kernel.org/20231102152033.5511-1-duje.mihanovic@skole.hr
> 
> Changes in v7:
> - Suppress SND_MMP_SOC_SSPA on ARM64
> - Update trailers
> - Rebase on v6.6-rc7
> - Link to v6: https://lore.kernel.org/r/20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr
> 
> Changes in v6:
> - Address maintainer comments:
>   - Add "marvell,pxa1908-padconf" binding to pinctrl-single driver
> - Drop GPIO patch as it's been pulled
> - Update trailers
> - Rebase on v6.6-rc5
> - Link to v5: https://lore.kernel.org/r/20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr
> 
> Changes in v5:
> - Address maintainer comments:
>   - Move *_NR_CLKS to clock driver from dt binding file
> - Allocate correct number of clocks for each block instead of blindly
>   allocating 50 for each
> - Link to v4: https://lore.kernel.org/r/20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr
> 
> Changes in v4:
> - Address maintainer comments:
>   - Relicense clock binding file to BSD-2
> - Add pinctrl-names to SD card node
> - Add vgic registers to GIC node
> - Rebase on v6.5-rc5
> - Link to v3: https://lore.kernel.org/r/20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr
> 
> Changes in v3:
> - Address maintainer comments:
>   - Drop GPIO dynamic allocation patch
>   - Move clock register offsets into driver (instead of bindings file)
>   - Add missing Tested-by trailer to u32_fract patch
>   - Move SoC binding to arm/mrvl/mrvl.yaml
> - Add serial0 alias and stdout-path to board dts to enable UART
>   debugging
> - Rebase on v6.5-rc4
> - Link to v2: https://lore.kernel.org/r/20230727162909.6031-1-duje.mihanovic@skole.hr
> 
> Changes in v2:
> - Remove earlycon patch as it's been merged into tty-next
> - Address maintainer comments:
>   - Clarify GPIO regressions on older PXA platforms
>   - Add Fixes tag to commit disabling GPIO pinctrl calls for this SoC
>   - Add missing includes to clock driver
>   - Clock driver uses HZ_PER_MHZ, u32_fract and GENMASK
>   - Dual license clock bindings
>   - Change clock IDs to decimal
>   - Fix underscores in dt node names
>   - Move chosen node to top of board dts
>   - Clean up documentation
>   - Reorder commits
>   - Drop pxa,rev-id
> - Rename muic-i2c to i2c-muic
> - Reword some commits
> - Move framebuffer node to chosen
> - Add aliases for mmc nodes
> - Rebase on v6.5-rc3
> - Link to v1: https://lore.kernel.org/r/20230721210042.21535-1-duje.mihanovic@skole.hr
> 
> ---
> Andy Shevchenko (1):
>       clk: mmp: Switch to use struct u32_fract instead of custom one
> 
> Duje Mihanović (8):
>       dt-bindings: pinctrl: pinctrl-single: add marvell,pxa1908-padconf compatible
>       pinctrl: single: add marvell,pxa1908-padconf compatible
>       dt-bindings: clock: Add Marvell PXA1908 clock bindings
>       clk: mmp: Add Marvell PXA1908 clock driver
>       dt-bindings: marvell: Document PXA1908 SoC
>       arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
>       arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
>       MAINTAINERS: add myself as Marvell PXA1908 maintainer
> 
>  .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +
>  .../devicetree/bindings/clock/marvell,pxa1908.yaml |  48 +++
>  .../bindings/pinctrl/pinctrl-single.yaml           |   4 +
>  MAINTAINERS                                        |   9 +
>  arch/arm64/Kconfig.platforms                       |   8 +
>  arch/arm64/boot/dts/marvell/Makefile               |   3 +
>  .../dts/marvell/pxa1908-samsung-coreprimevelte.dts | 336 +++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/pxa1908.dtsi           | 304 +++++++++++++++++++
>  drivers/clk/mmp/Makefile                           |   2 +-
>  drivers/clk/mmp/clk-frac.c                         |  57 ++--
>  drivers/clk/mmp/clk-of-mmp2.c                      |  26 +-
>  drivers/clk/mmp/clk-of-pxa168.c                    |   4 +-
>  drivers/clk/mmp/clk-of-pxa1908.c                   | 328 ++++++++++++++++++++
>  drivers/clk/mmp/clk-of-pxa1928.c                   |   6 +-
>  drivers/clk/mmp/clk-of-pxa910.c                    |   4 +-
>  drivers/clk/mmp/clk.h                              |  10 +-
>  drivers/pinctrl/pinctrl-single.c                   |   1 +
>  include/dt-bindings/clock/marvell,pxa1908.h        |  88 ++++++
>  18 files changed, 1186 insertions(+), 57 deletions(-)
> ---
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> change-id: 20230803-pxa1908-lkml-6830e8da45c7
> 
> Best regards,
> --
> Duje Mihanović <duje.mihanovic@skole.hr>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y marvell/pxa1908-samsung-coreprimevelte.dtb' for 20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr:

arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: /: memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 0, 0, 0]]}
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: pinmux@1e000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: pinmux@1e000: pinctrl-single,gpio-range: [[8, 55, 55, 0], [8, 110, 32, 0], [8, 52, 1, 0]] is too long
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: pinmux@1e000: 'pinmux-board-1', 'pinmux-board-2', 'pinmux-board-3', 'pinmux-gpio-keys', 'pinmux-i2c-muic', 'pinmux-sdh0-1', 'pinmux-sdh0-2', 'pinmux-sdh0-3', 'pinmux-uart0', 'ranges' do not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: mmc@80000: pinctrl-names: ['default'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: mmc@80000: Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#






