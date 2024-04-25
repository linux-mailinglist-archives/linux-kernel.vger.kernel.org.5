Return-Path: <linux-kernel+bounces-158743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6ED8B245F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F128C28260D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A014A604;
	Thu, 25 Apr 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mctKP4oF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BFB14A0A0;
	Thu, 25 Apr 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056683; cv=none; b=bwdtpjNxonCAnigTOdQSaFo3+Rzf8fai6tip6VICKEZiPYplysNDeoFeopFWs7OpF5qzL9eh7Ria6uwzu+H2RcY4ywA3+sPfzHi9C/Rw8M43ukvZw1c4SEOpnTCJ6JWQQskpLhVsrS7fWMqFdfK7SBSPYbp7dgVGCy/h+1Qz0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056683; c=relaxed/simple;
	bh=o8Pwp1MZGLbsmzWgTZQD2ayx4dF5M3ZVcoIncXTsEvk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=hTZTFhooG0Q6HZPTRURfbKB/SKZ6xct9DIgxUCV+zZMhZ4K1AZ33SBzgMOToXdmqiEFEA5BhukX19nwjekAHgWuhAxgUQqVEd3X6FTpbK1zKtb3iCHeYk6VU0RSOTgw2qB5BjfnM5Ua47p1s2Sn4ZZrdsThl2E8NJgqytKIXP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mctKP4oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B66C113CC;
	Thu, 25 Apr 2024 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714056682;
	bh=o8Pwp1MZGLbsmzWgTZQD2ayx4dF5M3ZVcoIncXTsEvk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mctKP4oFCAgStrgwKriN2CadcZcMD3lKZVHIQp2VbFiYUUuPl7AKRDoeeCQK06xIy
	 +sucQB6AkeQRQUYT24oHkB6VZpgPEPVmz3GVb8qLiOtkOaVaJMFMj9X4GJDnwtwXKn
	 WKX81BsMia3nl5QssVLSDmm1FpcG9XmxE4b7p1obdENy1QKly+hYxhEc1Zd1Zyvyly
	 dyh0vEJmhahVcNhYySeAIKeyJHfADQMyHDd+24h3ztSDprb9vja6c0qzQV+0uLe96M
	 I/pz4JnBlkyriA2CHw3eQV7Ecj1pMbOYq3u0MkSrlfqKbeRHGjsC8stQxneXEfaHmJ
	 GSln53+WHO6lQ==
Date: Thu, 25 Apr 2024 09:51:21 -0500
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
Cc: Will Deacon <will@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, Kees Cook <keescook@chromium.org>, 
 linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
 Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org, 
 Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, 
 Lubomir Rintel <lkundrak@v3.sk>, linux-clk@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 phone-devel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Stephen Boyd <sboyd@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 David Wronek <david@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
References: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
Message-Id: <171405653276.2527711.56458295308032188.robh@kernel.org>
Subject: Re: [PATCH v10 00/12] Initial Marvell PXA1908 support


On Wed, 24 Apr 2024 20:42:27 +0200, Duje Mihanović wrote:
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
> Changes in v10:
> - Update trailers
> - Rebase on v6.9-rc5
> - Clock driver changes:
>   - Add a couple of forgotten clocks in APBC
>     - The clocks are thermal_clk, ipc_clk, ssp0_clk, ssp2_clk and swjtag
>     - The IDs and register offsets were already present, but I forgot to
>       actually register them
>   - Split each controller block into own file
>   - Drop unneeded -of in clock driver filenames
>   - Simplify struct pxa1908_clk_unit
>   - Convert to platform driver
>   - Add module metadata
> - DTS changes:
>   - Properly name pinctrl nodes
>   - Drop pinctrl #size-cells, #address-cells, ranges and #gpio-size-cells
>   - Fix pinctrl input-schmitt configuration
> - Link to v9: https://lore.kernel.org/20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr
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
> Duje Mihanović (11):
>       dt-bindings: pinctrl: pinctrl-single: add marvell,pxa1908-padconf compatible
>       pinctrl: single: add marvell,pxa1908-padconf compatible
>       dt-bindings: clock: Add Marvell PXA1908 clock bindings
>       clk: mmp: Add Marvell PXA1908 APBC driver
>       clk: mmp: Add Marvell PXA1908 APBCP driver
>       clk: mmp: Add Marvell PXA1908 APMU driver
>       clk: mmp: Add Marvell PXA1908 MPMU driver
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
>  .../dts/marvell/pxa1908-samsung-coreprimevelte.dts | 328 +++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/pxa1908.dtsi           | 300 +++++++++++++++++++
>  drivers/clk/mmp/Makefile                           |   2 +-
>  drivers/clk/mmp/clk-frac.c                         |  57 ++--
>  drivers/clk/mmp/clk-of-mmp2.c                      |  26 +-
>  drivers/clk/mmp/clk-of-pxa168.c                    |   4 +-
>  drivers/clk/mmp/clk-of-pxa1928.c                   |   6 +-
>  drivers/clk/mmp/clk-of-pxa910.c                    |   4 +-
>  drivers/clk/mmp/clk-pxa1908-apbc.c                 | 131 ++++++++
>  drivers/clk/mmp/clk-pxa1908-apbcp.c                |  84 ++++++
>  drivers/clk/mmp/clk-pxa1908-apmu.c                 | 123 ++++++++
>  drivers/clk/mmp/clk-pxa1908-mpmu.c                 | 112 +++++++
>  drivers/clk/mmp/clk.h                              |  10 +-
>  drivers/pinctrl/pinctrl-single.c                   |   1 +
>  include/dt-bindings/clock/marvell,pxa1908.h        |  88 ++++++
>  21 files changed, 1296 insertions(+), 57 deletions(-)
> ---
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
> change-id: 20230803-pxa1908-lkml-6830e8da45c7
> 
> Best regards,
> --
> Duje Mihanović <duje.mihanovic@skole.hr>
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


New warnings running 'make CHECK_DTBS=y marvell/pxa1908-samsung-coreprimevelte.dtb' for 20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr:

arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: /: memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 0, 0, 0]]}
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: pinmux@1e000: pinctrl-single,gpio-range: [[8, 55, 55, 0], [8, 110, 32, 0], [8, 52, 1, 0]] is too long
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: mmc@80000: pinctrl-names: ['default'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dtb: mmc@80000: Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#






