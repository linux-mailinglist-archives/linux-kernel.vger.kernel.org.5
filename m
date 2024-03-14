Return-Path: <linux-kernel+bounces-103737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25887C3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A001C226E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CC75813;
	Thu, 14 Mar 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmcn/a8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C4757FE;
	Thu, 14 Mar 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445405; cv=none; b=K9yg2acuA0QJ6FnN/cR8fEXi44o9JpAuF//3nK8rCJU7hELPyDy/R0KTUyuYlxH0IMWmLWBVHvbKVgISVEMnSjvK7bhBZuuvuJ2ZhYB1JO10Xh51MVQCRi5MvNs4oXGI3dD8M1LrWxjNgvDPamOzuv0XY/slmadSxd/7Q+byHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445405; c=relaxed/simple;
	bh=Umkpnt+DkmwthY8wMa0dorfxN5HtEH7Vqm4yjYb24/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqaaRUBVWmHCEXSM8Mxzb/meqyN0ErmPPyBLuOOZ4OURHFx+LbFENNvlMbCM6GADpIDojhN6DyRqiVC0J5Da5LeHGAM5gFQCvMKRqtv3O+fHi4oiMk+8iMTghWnj3e01wTt5FVEWrQkMYl+n7uv8aGbN63154qIgWBE6B97iqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tmcn/a8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20F7C433C7;
	Thu, 14 Mar 2024 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710445405;
	bh=Umkpnt+DkmwthY8wMa0dorfxN5HtEH7Vqm4yjYb24/8=;
	h=From:To:Cc:Subject:Date:From;
	b=Tmcn/a8AuYA35Ms4/4QlV3KU/BDDDHDwyZvbAj5Y/erkMsZd0Q5bOQqcMv8pSg+lK
	 i2Kn0L5iUbq7ssw5xQWzCedBE4fnQ+AoI3xFC3XoRelc5APFBLsX0bHAzGH6UgCf5t
	 8vjA812KrwLdI9nr+pDaEAG8kNHShr/DoNXTJR+PWPM7wXDhnb+7+iMyUfihPCFJym
	 S+QqMrAcH7niN1FlRMGTo/GXQ7sb12vy7Pu4zZO8Bw4idadAnH3gYLTz/iwfuqoV2k
	 ce26N6WoFI9sAgQGC1CatN9Qobp1G/dFhXL4W+jO31JUzpSN8hDqTBf+3qHTVjCnKw
	 tPu9/0sZnwk3w==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Thu, 14 Mar 2024 12:43:22 -0700
Message-ID: <20240314194324.2487618-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c81798cf9dd2f324934585b2b52a0398caefb88e:

  dt-bindings: clock: rk3588: add missing PCLK_VO1GRF (2024-02-27 17:04:58 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 3066c521be9db14964d78c6c431c97a424468ded:

  Merge branches 'clk-samsung', 'clk-imx', 'clk-rockchip', 'clk-clkdev' and 'clk-rate-exclusive' into clk-next (2024-03-13 12:36:21 -0700)

----------------------------------------------------------------
Not a ton of stuff happening in the clk framework in this pull request. We got
some more devm helpers and we seem to be going in the direction of "just turn
this stuff on already and leave me alone!" with the addition of a
devm_clk_bulk_get_all_enable() API. I'm hoping that we can make that into a
genpd that drivers attach instead, but this API should help drivers simplify in
the meantime.

Outside of the devm wrappers, we've got the usual clk driver updates that are
dominated by the major phone SoC vendors (Samsung and Qualcomm) and the
non-critical driver fixes for things like incorrect topology descriptions and
wrong registers or bit fields. More details are below, but I'd say that it
looks pretty ordinary. The only thing that really jumps out at me is the
Renesas clk driver that's ignoring clks that are assigned to remote processors
in DeviceTree. That's a new feature that they're using to avoid marking clks as
CLK_IGNORE_UNUSED based on the configuration of the system.

Core:
 - Increase dev_id len for clkdev lookups
 - Add a devm_clk_bulk_get_all_enable() API to get and enable all clks
   for a device
 - Add a devm variant of clk_rate_exclusive_get()

New Drivers:
 - Display, TCSR, GPU, and Camera clock controllers for Qualcomm's X1 Elite SoC
 - Google GS101 PERIC0 and PERIC1 clock controllers
 - Exynos850 PDMA clocks
 - Exynos850 CPU cluster 0 and 1 (CMU_CPUCLK0/CMU_CPUCLK1) clock controllers

Removed Drivers:
 - Remove the unused Qualcomm sc7180 modem clk driver

Updates:
 - Fix some static checker errors in the Hisilicon clk driver
 - Polarfire MSSPLL hardware has 4 output clocks (the driver supported
   previously only one output); each of these 4 outputs feed dividers and the
   output of each divider feed individual hardware blocks (e.g. CAN, Crypto,
   eMMC); individual hardware block drivers need to control their clocks thus
   clock driver support was added for all MSSPLL output clocks
 - Typo fixes in the Qualcomm IPQ5018 GCC driver
 - Add "qdss_at" clk on Qualcomm IPQ6018, needed for WiFi
 - Properly terminate frequency tables in different Qualcomm clk drivers
 - Add MDSS, crypto, and SDCC resets on Qualcomm MSM8953
 - Add missing UFS CLKREF clks on Qualcomm SC8180X
 - Avoid significant delays during boot by adding a softdep on rpmhpd to
   Qualcomm SDM845 gcc driver
 - Add QUPv3 RCGS w/ DFS and video resets to Qualcomm SM8150 GCC driver
 - Fix the custom GPU GX "do-nothing" method in the Qualcomm GDSC driver
 - Add an external regulator to GX GDSC on Qualcomm SC8280XP GPU clk driver
 - Switch display, GPU, video, and camera Qualcomm clk drivers to
   module_platform_driver()
 - Set a longer delay for Venus resets on many Qualcomm SoCs
 - Correct the GDSC wait times in the Qualcomm SDM845 display clk driver
 - Fix clock listing Oops on Amlogic axg
 - New pll-rate for Rockchip rk3568
 - i2s rate improvements for Rockchip rk3399
 - Rockchip rk3588 syscon clock fixes and removal of overall clock-number from
   the rk3588 binding header
 - A prerequisite for later improvements to the Rockchip rk3588 linked clocks
 - Minor clean-ups and error handling improvements in both composite-8m and SCU
   i.MX clock drivers
 - Fix for SAI_MCLK_SEL definition for i.MX8MP
 - Register the Samsung CMU MISC clock controller earlier, so the Multi Core
   Timer clocksource can use it on Google GS101
 - Propagate Exynos850 SPI IPCLK rate change to parents, so the SPI will get
   proper clock rates
 - Refactor the generic Samsung CPU clock controllers code, preparing it for
   supporting Exynos850 CPU clocks
 - Fix some clk kerneldoc warnings
 - Add Ethernet, SDHI, DMA, and HyperFLASH/QSPI (RPC-IF) clocks on Renesas
   R-Car V4M
 - Ignore all clocks which are assigned to a non-Linux system in the Renesas
   clk driver
 - Add watchdog clock on Renesas RZ/G3S
 - Add camera (CRU) clock and reset on Renesas RZ/G2UL
 - Add support for the Renesas R-Car V4M (R8A779H0) SoC
 - Convert some clk bindings to YAML so they can be validated

----------------------------------------------------------------
Abel Vesa (1):
      clk: qcom: Add TCSR clock driver for x1e80100

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

André Draszik (3):
      clk: samsung: gs101: gpio_peric0_pclk needs to be kept on
      clk: samsung: gs101: drop extra empty line
      clk: samsung: gs101: add support for cmu_peric1

Andy Shevchenko (2):
      clk: fractional-divider: Move mask calculations out of lock
      clk: fractional-divider: Use bit operations consistently

Biju Das (1):
      clk: renesas: r9a07g043: Add clock and reset entries for CRU

Bjorn Andersson (6):
      dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
      clk: qcom: gdsc: Enable supply reglator in GPU GX handler
      clk: qcom: gpucc-sc8280xp: Add external supply for GX gdsc
      Merge branch '20240202-x1e80100-clock-controllers-v4-5-7fb08c861c7c@linaro.org' into clk-for-6.9
      Merge branch '20240125-msm8953-mdss-reset-v2-1-fd7824559426@z3ntu.xyz' into clk-for-6.9
      Merge branch '20240131-ufs-phy-clock-v3-3-58a49d2f4605@linaro.org' into clk-for-6.9

Bryan O'Donoghue (2):
      clk: qcom: camcc-x1e80100: Fix missing DT_IFACE enum in x1e80100 camcc
      clk: Fix clk_core_get NULL dereference

Chen-Yu Tsai (1):
      clk: mediatek: mt8183: Correct parent of CLK_INFRA_SSPM_32K_SELF

Chris Morgan (1):
      clk: rockchip: rk3568: Add PLL rate for 128MHz

Christophe JAILLET (4):
      clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
      clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
      clk: mediatek: mt8135: Fix an error handling path in clk_mt8135_apmixed_probe()
      clk: mediatek: mt7622-apmixedsys: Fix an error handling path in clk_mt8135_apmixed_probe()

Claudiu Beznea (3):
      clk: renesas: r9a08g045: Add clock and reset support for watchdog
      clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for SD1 mux
      clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable

Colin Ian King (2):
      clk: cdce925: Remove redundant assignment to variable 'rate'
      clk: clocking-wizard: Remove redundant initialization of pointer div_addr

Cong Dang (8):
      clk: renesas: cpg-mssr: Add support for R-Car V4M
      clk: renesas: r8a779h0: Add PFC/GPIO clocks
      clk: renesas: r8a779h0: Add watchdog clock
      clk: renesas: r8a779h0: Add I2C clocks
      clk: renesas: r8a779h0: Add EtherAVB clocks
      clk: renesas: r8a779h0: Add SDHI clock
      clk: renesas: r8a779h0: Add SYS-DMAC clocks
      clk: renesas: r8a779h0: Add RPC-IF clock

Conor Dooley (6):
      dt-bindings: clock: mpfs: add more MSSPLL output definitions
      dt-bindings: can: mpfs: add missing required clock
      clk: microchip: mpfs: split MSSPLL in two
      clk: microchip: mpfs: setup for using other mss pll outputs
      clk: microchip: mpfs: add missing MSSPLL outputs
      clk: microchip: mpfs: convert MSSPLL outputs to clk_divider

Daniel Golle (1):
      clk: mediatek: mt7981-topckgen: flag SGM_REG_SEL as critical

Dmitry Baryshkov (6):
      clk: qcom: camcc-*: switch to module_platform_driver
      clk: qcom: dispcc-*: switch to module_platform_driver
      clk: qcom: gpucc-*: switch to module_platform_driver
      clk: qcom: videocc-*: switch to module_platform_driver
      clk: qcom: drop the SC7180 Modem subsystem clock driver
      dt-bindings: clk: qcom: drop the SC7180 Modem subsystem clock controller

Duoming Zhou (1):
      clk: zynq: Prevent null pointer dereference caused by kmalloc failure

Eddie James (2):
      dt-bindings: clock: ast2600: Add FSI clock
      clk: ast2600: Add FSI parent clock with correct rate

Erick Archer (1):
      clk: hisilicon: Use devm_kcalloc() instead of devm_kzalloc()

Frank Wunderlich (2):
      dt-bindings: reset: mediatek: add MT7988 infracfg reset IDs
      clk: mediatek: add infracfg reset controller for mt7988

Gabor Juhos (10):
      clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq9574: fix terminating of frequency table arrays
      clk: qcom: camcc-sc8280xp: fix terminating of frequency table arrays
      clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
      clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
      clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of 'gcc_pcie1_pipe_clk'
      clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES reset

Geert Uytterhoeven (6):
      clk: renesas: mstp: Remove obsolete clkdev registration
      Merge tag 'renesas-r8a779h0-dt-binding-defs-tag' into renesas-clk-for-v6.9
      clk: renesas: rcar-gen4: Add support for FRQCRC1
      clk: renesas: r8a779g0: Fix PCIe clock name
      clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
      clk: renesas: r8a779f0: Correct PFC/GPIO parent clock

Heiko Stuebner (1):
      Merge branch 'v6.9-shared/clkids' into v6.9-clk/next

Igor Prusov (1):
      clk: meson: Add missing clocks to axg_clk_regmaps

Jeffrey Hugo (1):
      dt-bindings: clock: qcom: Fix @codeaurora email in Q6SSTOP

Konrad Dybcio (21):
      clk: qcom: reset: Increase max reset delay
      clk: qcom: reset: Commonize the de/assert functions
      clk: qcom: reset: Ensure write completion on reset de/assertion
      clk: qcom: gcc-sa8775p: Set delay for Venus CLK resets
      clk: qcom: gcc-sc8180x: Set delay for Venus CLK resets
      clk: qcom: gcc-sc8280xp: Set delay for Venus CLK resets
      clk: qcom: gcc-sm4450: Set delay for Venus CLK resets
      clk: qcom: gcc-sm7150: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8250: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8350: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8450: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8550: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8650: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8150: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8250: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8350: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8450: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8550: Set delay for Venus CLK resets
      clk: qcom: branch: Add a helper for setting the enable bit
      clk: qcom: Use qcom_branch_set_clk_en()
      clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times

Krzysztof Kozlowski (2):
      Merge tag 'samsung-dt-bindings-clk-6.9-2' into next/clk
      Merge tag 'samsung-dt-bindings-clk-6.9-3' into next/clk

Kuninori Morimoto (4):
      of: Add __of_device_is_status() and makes more generic status check
      of: Add of_get_next_status_child() and makes more generic of_get_next
      of: Add for_each_reserved_child_of_node()
      clk: renesas: cpg-mssr: Ignore all clocks assigned to non-Linux system

Manivannan Sadhasivam (1):
      clk: qcom: gcc-sc8180x: Add missing UFS QREF clocks

Mantas Pucka (1):
      clk: qcom: gcc-ipq6018: add qdss_at clock needed for wifi operation

Markus Elfring (4):
      clk: imx: composite-8m: Less function calls in __imx8m_clk_hw_composite() after error detection
      clk: imx: composite-8m: Delete two unnecessary initialisations in __imx8m_clk_hw_composite()
      clk: imx: scu: Use common error handling code in imx_clk_scu_alloc_dev()
      clk: mediatek: clk-mt8173-apmixedsys: Use common error handling code in clk_mt8173_apmixed_probe()

Michael J. Ruhl (1):
      clkdev: Update clkdev id usage to allow for longer names

Ondrej Jirman (1):
      clk: rockchip: rk3399: Allow to set rate of clk_i2s0_frac's parent

Peter Griffin (1):
      clk: samsung: gs101: register cmu_misc clocks early

Rafał Miłecki (3):
      dt-bindings: clock: mediatek: convert hifsys to the json-schema clock
      dt-bindings: clock: mediatek: convert PCIESYS to the json-schema clock
      dt-bindings: clock: mediatek: convert SSUSBSYS to the json-schema clock

Rajendra Nayak (4):
      clk: qcom: clk-alpha-pll: Add support for zonda ole pll configure
      clk: qcom: Add dispcc clock driver for x1e80100
      clk: qcom: Add GPU clock driver for x1e80100
      clk: qcom: Add camcc clock driver for x1e80100

Randy Dunlap (5):
      clk: sunxi: a20-gmac: fix kernel-doc warnings
      clk: sunxi: sun9i-cpus: fix kernel-doc warnings
      clk: sunxi: usb: fix kernel-doc warnings
      clk: keystone: sci-clk: match func name comment to actual
      clk: ti: dpll3xxx: use correct function names in kernel-doc

Sam Protsenko (14):
      clk: samsung: exynos850: Add PDMA clocks
      clk: samsung: exynos850: Propagate SPI IPCLK rate change
      dt-bindings: clock: exynos850: Add CMU_CPUCLK0 and CMU_CPUCL1
      clk: samsung: Improve clk-cpu.c style
      clk: samsung: Pull struct exynos_cpuclk into clk-cpu.c
      clk: samsung: Reduce params count in exynos_register_cpu_clock()
      clk: samsung: Use single CPU clock notifier callback for all chips
      clk: samsung: Group CPU clock functions by chip
      clk: samsung: Pass actual CPU clock registers base to CPU_CLK()
      clk: samsung: Pass register layout type explicitly to CLK_CPU()
      clk: samsung: Keep CPU clock chip specific data in a dedicated struct
      clk: samsung: Keep register offsets in chip specific structure
      clk: samsung: Pass mask to wait_until_mux_stable()
      clk: samsung: Add CPU clock support for Exynos850

Satya Priya Kakitapalli (4):
      clk: qcom: gcc-sm8150: Register QUPv3 RCGs for DFS on SM8150
      dt-bindings: clock: qcom,gcc-sm8150: Add gcc video resets for sm8150
      clk: qcom: gcc-sm8150: Add gcc video resets for sm8150
      clk: qcom: dispcc-sm8250: Make clk_init_data and pll_vco const

Sebastian Reichel (3):
      clk: rockchip: rk3588: fix pclk_vo0grf and pclk_vo1grf
      clk: rockchip: rk3588: fix indent
      clk: rockchip: rk3588: use linked clock ID for GATE_LINK

Sekhar Nori (1):
      MAINTAINERS: drop Sekhar Nori

Shengjiu Wang (1):
      clk: imx: imx8mp: Fix SAI_MCLK_SEL definition

Shradha Todi (1):
      clk: Provide managed helper to get and enable bulk clocks

Stephen Boyd (13):
      Merge tag 'renesas-clk-for-v6.9-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'renesas-clk-for-v6.9-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-6.9-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'samsung-clk-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'clk-imx-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'v6.9-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-meson-v6.9-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'qcom-clk-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'clk-microchip-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge branches 'clk-renesas', 'clk-cleanup', 'clk-hisilicon', 'clk-mediatek' and 'clk-bulk' into clk-next
      Merge branches 'clk-aspeed', 'clk-keystone', 'clk-mobileye' and 'clk-allwinner' into clk-next
      Merge branches 'clk-remove', 'clk-amlogic', 'clk-qcom', 'clk-parent' and 'clk-microchip' into clk-next
      Merge branches 'clk-samsung', 'clk-imx', 'clk-rockchip', 'clk-clkdev' and 'clk-rate-exclusive' into clk-next

Théo Lebrun (4):
      clk: fixed-factor: add optional accuracy support
      clk: fixed-factor: add fwname-based constructor functions
      dt-bindings: clock: mobileye,eyeq5-clk: add bindings
      dt-bindings: reset: mobileye,eyeq5-reset: add bindings

Tudor Ambarus (1):
      clk: samsung: gs101: add support for cmu_peric0

Udit Kumar (1):
      clk: keystone: sci-clk: Adding support for non contiguous clocks

Uwe Kleine-König (4):
      clk: Add a devm variant of clk_rate_exclusive_get()
      clk: imx: imx8-acm: Convert to platform remove callback returning void
      clk: starfive: jh7110-isp: Convert to platform remove callback returning void
      clk: starfive: jh7110-vout: Convert to platform remove callback returning void

Varada Pavani (1):
      dt-bindings: clock: tesla,fsd: Fix spelling mistake

Vladimir Lypak (1):
      clk: qcom: gcc-msm8953: add more resets

 CREDITS                                            |    5 +
 .../bindings/arm/mediatek/mediatek,hifsys.txt      |   26 -
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |   25 -
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |   25 -
 .../bindings/clock/google,gs101-clock.yaml         |   32 +-
 .../bindings/clock/mediatek,mt2701-hifsys.yaml     |   50 +
 .../bindings/clock/mediatek,mt7622-pciesys.yaml    |   45 +
 .../bindings/clock/mediatek,mt7622-ssusbsys.yaml   |   45 +
 .../bindings/clock/mobileye,eyeq5-clk.yaml         |   51 +
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    9 +
 .../devicetree/bindings/clock/qcom,q6sstopcc.yaml  |    2 +-
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |   61 -
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    2 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    7 +-
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 .../bindings/clock/qcom,sm8650-dispcc.yaml         |  106 -
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 .../bindings/clock/samsung,exynos850-clock.yaml    |   42 +
 .../devicetree/bindings/clock/tesla,fsd-clock.yaml |    2 +-
 .../bindings/net/can/microchip,mpfs-can.yaml       |    6 +-
 .../bindings/power/renesas,rcar-sysc.yaml          |    1 +
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |   43 +
 MAINTAINERS                                        |    1 -
 drivers/clk/clk-ast2600.c                          |    7 +-
 drivers/clk/clk-cdce925.c                          |    1 -
 drivers/clk/clk-devres.c                           |   40 +
 drivers/clk/clk-fixed-factor.c                     |  103 +-
 drivers/clk/clk-fractional-divider.c               |   14 +-
 drivers/clk/clk.c                                  |   22 +
 drivers/clk/clkdev.c                               |    2 +-
 drivers/clk/hisilicon/clk-hi3519.c                 |    2 +-
 drivers/clk/hisilicon/clk-hi3559a.c                |    4 +-
 drivers/clk/imx/clk-composite-8m.c                 |   16 +-
 drivers/clk/imx/clk-imx8-acm.c                     |    6 +-
 drivers/clk/imx/clk-imx8mp-audiomix.c              |   11 +-
 drivers/clk/imx/clk-scu.c                          |   22 +-
 drivers/clk/keystone/sci-clk.c                     |   12 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c       |    1 -
 drivers/clk/mediatek/clk-mt7981-topckgen.c         |    5 +-
 drivers/clk/mediatek/clk-mt7988-infracfg.c         |   23 +
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c       |    4 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c       |    5 +-
 drivers/clk/mediatek/clk-mt8183.c                  |    2 +-
 drivers/clk/meson/axg.c                            |    2 +
 drivers/clk/microchip/clk-mpfs.c                   |  154 +-
 drivers/clk/qcom/Kconfig                           |   45 +-
 drivers/clk/qcom/Makefile                          |    5 +-
 drivers/clk/qcom/camcc-sc7180.c                    |   12 +-
 drivers/clk/qcom/camcc-sc7280.c                    |   12 +-
 drivers/clk/qcom/camcc-sc8280xp.c                  |   27 +-
 drivers/clk/qcom/camcc-sdm845.c                    |   12 +-
 drivers/clk/qcom/camcc-sm6350.c                    |   12 +-
 drivers/clk/qcom/camcc-sm8550.c                    |   10 +-
 drivers/clk/qcom/camcc-x1e80100.c                  | 2487 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |   16 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    4 +
 drivers/clk/qcom/clk-branch.h                      |    6 +
 drivers/clk/qcom/dispcc-qcm2290.c                  |   16 +-
 drivers/clk/qcom/dispcc-sc7180.c                   |   12 +-
 drivers/clk/qcom/dispcc-sc7280.c                   |   19 +-
 drivers/clk/qcom/dispcc-sc8280xp.c                 |   16 +-
 drivers/clk/qcom/dispcc-sdm845.c                   |   14 +-
 drivers/clk/qcom/dispcc-sm6115.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm6125.c                   |   12 +-
 drivers/clk/qcom/dispcc-sm6350.c                   |   12 +-
 drivers/clk/qcom/dispcc-sm6375.c                   |   12 +-
 drivers/clk/qcom/dispcc-sm8250.c                   |  134 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |   19 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |   19 +-
 drivers/clk/qcom/dispcc-sm8650.c                   |   16 +-
 drivers/clk/qcom/dispcc-x1e80100.c                 | 1718 ++++++++++++++
 drivers/clk/qcom/gcc-ipq5018.c                     |    9 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |   19 +
 drivers/clk/qcom/gcc-ipq8074.c                     |    2 +
 drivers/clk/qcom/gcc-ipq9574.c                     |    1 +
 drivers/clk/qcom/gcc-msm8953.c                     |    4 +
 drivers/clk/qcom/gcc-sa8775p.c                     |   29 +-
 drivers/clk/qcom/gcc-sc7180.c                      |   22 +-
 drivers/clk/qcom/gcc-sc7280.c                      |   20 +-
 drivers/clk/qcom/gcc-sc8180x.c                     |   62 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |   29 +-
 drivers/clk/qcom/gcc-sdm845.c                      |    1 +
 drivers/clk/qcom/gcc-sdx55.c                       |   12 +-
 drivers/clk/qcom/gcc-sdx65.c                       |   13 +-
 drivers/clk/qcom/gcc-sdx75.c                       |   10 +-
 drivers/clk/qcom/gcc-sm4450.c                      |   32 +-
 drivers/clk/qcom/gcc-sm6375.c                      |   11 +-
 drivers/clk/qcom/gcc-sm7150.c                      |   25 +-
 drivers/clk/qcom/gcc-sm8150.c                      |  352 +--
 drivers/clk/qcom/gcc-sm8250.c                      |   23 +-
 drivers/clk/qcom/gcc-sm8350.c                      |   24 +-
 drivers/clk/qcom/gcc-sm8450.c                      |   25 +-
 drivers/clk/qcom/gcc-sm8550.c                      |   25 +-
 drivers/clk/qcom/gcc-sm8650.c                      |   20 +-
 drivers/clk/qcom/gcc-x1e80100.c                    |   16 +-
 drivers/clk/qcom/gdsc.c                            |   12 +-
 drivers/clk/qcom/gpucc-sa8775p.c                   |   12 +-
 drivers/clk/qcom/gpucc-sc7180.c                    |   12 +-
 drivers/clk/qcom/gpucc-sc7280.c                    |   21 +-
 drivers/clk/qcom/gpucc-sc8280xp.c                  |   10 +-
 drivers/clk/qcom/gpucc-sdm845.c                    |   12 +-
 drivers/clk/qcom/gpucc-sm8150.c                    |   12 +-
 drivers/clk/qcom/gpucc-sm8250.c                    |   12 +-
 drivers/clk/qcom/gpucc-sm8350.c                    |   12 +-
 drivers/clk/qcom/gpucc-sm8550.c                    |   22 +-
 drivers/clk/qcom/gpucc-x1e80100.c                  |  656 ++++++
 drivers/clk/qcom/lpasscorecc-sc7180.c              |    7 +-
 drivers/clk/qcom/mmcc-apq8084.c                    |    2 +
 drivers/clk/qcom/mmcc-msm8974.c                    |    2 +
 drivers/clk/qcom/mss-sc7180.c                      |  140 --
 drivers/clk/qcom/reset.c                           |   27 +-
 drivers/clk/qcom/reset.h                           |    2 +-
 drivers/clk/qcom/tcsrcc-x1e80100.c                 |  285 +++
 drivers/clk/qcom/videocc-sc7180.c                  |   12 +-
 drivers/clk/qcom/videocc-sc7280.c                  |   12 +-
 drivers/clk/qcom/videocc-sdm845.c                  |   12 +-
 drivers/clk/qcom/videocc-sm8150.c                  |   14 +-
 drivers/clk/qcom/videocc-sm8250.c                  |   22 +-
 drivers/clk/qcom/videocc-sm8350.c                  |   14 +-
 drivers/clk/qcom/videocc-sm8450.c                  |   29 +-
 drivers/clk/qcom/videocc-sm8550.c                  |   29 +-
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/clk-mstp.c                     |   16 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   13 +-
 drivers/clk/renesas/r8a779h0-cpg-mssr.c            |  256 ++
 drivers/clk/renesas/r9a07g043-cpg.c                |   37 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |    6 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |    3 +
 drivers/clk/renesas/rcar-gen4-cpg.c                |   10 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |  117 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/clk/rockchip/clk-rk3399.c                  |    6 +-
 drivers/clk/rockchip/clk-rk3568.c                  |    1 +
 drivers/clk/rockchip/clk-rk3588.c                  |   50 +-
 drivers/clk/samsung/clk-cpu.c                      |  564 +++--
 drivers/clk/samsung/clk-cpu.h                      |   53 +-
 drivers/clk/samsung/clk-exynos3250.c               |    2 +-
 drivers/clk/samsung/clk-exynos4.c                  |    9 +-
 drivers/clk/samsung/clk-exynos5250.c               |    5 +-
 drivers/clk/samsung/clk-exynos5420.c               |   16 +-
 drivers/clk/samsung/clk-exynos5433.c               |   10 +-
 drivers/clk/samsung/clk-exynos850.c                |   43 +-
 drivers/clk/samsung/clk-gs101.c                    |  942 +++++++-
 drivers/clk/samsung/clk.h                          |    5 +-
 drivers/clk/starfive/clk-starfive-jh7110-isp.c     |    6 +-
 drivers/clk/starfive/clk-starfive-jh7110-vout.c    |    6 +-
 drivers/clk/sunxi/clk-a20-gmac.c                   |   21 +-
 drivers/clk/sunxi/clk-sun9i-cpus.c                 |    7 +-
 drivers/clk/sunxi/clk-usb.c                        |    9 +-
 drivers/clk/ti/dpll3xxx.c                          |    4 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |    2 +-
 drivers/clk/zynq/clkc.c                            |    8 +-
 drivers/of/base.c                                  |  123 +-
 include/dt-bindings/clock/ast2600-clock.h          |    1 +
 include/dt-bindings/clock/exynos850.h              |   56 +
 include/dt-bindings/clock/google,gs101.h           |  129 +
 include/dt-bindings/clock/microchip,mpfs-clock.h   |    5 +
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |   22 +
 include/dt-bindings/clock/qcom,gcc-msm8953.h       |    4 +
 include/dt-bindings/clock/qcom,gcc-sc8180x.h       |    2 +
 include/dt-bindings/clock/qcom,gcc-sm8150.h        |    3 +
 include/dt-bindings/clock/qcom,x1e80100-camcc.h    |  135 ++
 include/dt-bindings/clock/qcom,x1e80100-dispcc.h   |   98 +
 include/dt-bindings/clock/qcom,x1e80100-gpucc.h    |   41 +
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     |   23 +
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h      |    1 +
 .../dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h  |   96 +
 include/dt-bindings/power/renesas,r8a779h0-sysc.h  |   49 +
 include/dt-bindings/reset/mediatek,mt7988-resets.h |    6 +
 include/dt-bindings/reset/qcom,x1e80100-gpucc.h    |   19 +
 include/linux/clk-provider.h                       |   26 +-
 include/linux/clk.h                                |   34 +
 include/linux/of.h                                 |   11 +
 176 files changed, 9239 insertions(+), 1788 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 create mode 100644 drivers/clk/qcom/camcc-x1e80100.c
 create mode 100644 drivers/clk/qcom/dispcc-x1e80100.c
 create mode 100644 drivers/clk/qcom/gpucc-x1e80100.c
 delete mode 100644 drivers/clk/qcom/mss-sc7180.c
 create mode 100644 drivers/clk/qcom/tcsrcc-x1e80100.c
 create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c
 create mode 100644 include/dt-bindings/clock/mobileye,eyeq5-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-tcsr.h
 create mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h
 create mode 100644 include/dt-bindings/reset/qcom,x1e80100-gpucc.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

