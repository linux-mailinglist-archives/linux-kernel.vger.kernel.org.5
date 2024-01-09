Return-Path: <linux-kernel+bounces-21483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C68829008
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE9BB22764
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DB3E462;
	Tue,  9 Jan 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYF/NLoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED93C48F;
	Tue,  9 Jan 2024 22:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836BDC433F1;
	Tue,  9 Jan 2024 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704839969;
	bh=3Il5zpGsHtvODbdCmMwkvT7qR4ew1CGGPYWuKfZXQys=;
	h=From:To:Cc:Subject:Date:From;
	b=MYF/NLoQKo7bVI6yaFCBcSz03vuNsA/R1U5DQEh/47i4+V+NKTmBE6UhB+J7h+NuC
	 GUo19OyiOVJbH2HJ0CUQcT5Y2y/0Oop3O9GxyX4STXb5LdpKqy1sXvUXJZbqGpH1iE
	 p9/oPuRv7TmbKfzXxYd1+/V85mit+pqplL53U+lZZp8eJuVytBP4aQeMPgK7tYcE5D
	 9S7mYIg8FoZDr+0KApcg3jBoqAFjsVOZhB67O7GY2QzFCRWNYB7VVyZuH9LgyY6Gf/
	 ExbuC/H6hGMfgdpo6t0S5eCkfWK7C9v7iqVIyq9u6c29DcoAw4cOjrOf3CjvvpjUQU
	 GBus47nC/6KKg==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Tue,  9 Jan 2024 14:39:24 -0800
Message-ID: <20240109223928.2113621-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 4f964cfef39d48a8e6748847df9a1ed310b96c4e:

  Merge branch 'clk-rs9' into clk-next (2024-01-09 11:55:47 -0800)

----------------------------------------------------------------
Only a couple new SoCs have support added this time, primarily for Qualcomm
SM8650 based on the diffstat. Otherwise this is a collection of non-critical
fixes and cleanups to various clk drivers and their DT bindings. Nothing is
changed in the core clk framework this time, although there's a patch to fix a
basic clk type initialization function. In general, this pile looks to be on
the smaller side.

New Drivers:
 - Global, display, gpu, tcsr, and rpmh clocks on Qualcomm SM8650
 - Mediatek MT7988 SoC clocks

Updates:
 - Update Zynqmp driver for Versal NET platforms
 - Add clk driver for Versal clocking wizard IP
 - Support for stm32mp25 clks
 - Add glitch free PLL setting support to si5351 clk driver
 - Add DSI clocks on Amlogic g12/sm1
 - Add CSI and ISP clocks on Amlogic g12/sm1
 - Document bindings for i.MX93 ANATOP clock driver
 - Free clk_node in i.MX SCU driver for resource with different owner
 - Update the LVDS clocks to be compatible with i.MX SCU firmware 1.15
 - Fix the name of the fvco in i.MX pll14xx by renaming it to fout
 - Add EtherNet TSN and PCIe clocks on the Renesas R-Car V4H SoC
 - Add interrupt controller and Ethernet clocks and resets on Renesas RZ/G3S
 - Check reset monitor registers on Renesas RZ/G2L-alike SoCs
 - Reuse reset functionality in the Renesas RZ/G2L clock driver
 - Global and RPMh clock support for the Qualcomm X1E80100 SoC
 - Support for the Stromer APCS PLL found in Qualcomm IPQ5018
 - Add a new type of branch clock, with support for controlling separate
   memory control bits, to the Qualcomm clk driver
 - Use above new branch type in Qualcomm ECPRI clk driver for QDU1000 and
   QRU1000
 - Add a number of missing clocks related to CSI2 on Qualcomm MSM8939
 - Add support for the camera clock controller on Qualcomm SC8280XP
 - Correct PLL configuration in GPU and video clock controllers for
   Qualcomm SM8150
 - Add runtime PM support and a few missing resets to Qualcomm SM8150
   video clock controller
 - Fix configuration of various GCC GDSCs on Qualcomm SM8550
 - Mark shared RCGs appropriately in the Qualcomm SM8550 GCC driver
 - Fix up GPU and display clock controllers PLL configuration settings
   on Qualcomm SM8550
 - Cleanup variable init in Allwinner nkm module
 - Convert various DT bindings to YAML
 - A few kernel-doc fixes for Samsung SoC clock controllers

----------------------------------------------------------------
Alexander Stein (1):
      clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks

Alvin Šipraga (3):
      dt-bindings: clock: si5351: convert to yaml
      dt-bindings: clock: si5351: add PLL reset mode property
      clk: si5351: allow PLLs to be adjusted without reset

AngeloGioacchino Del Regno (3):
      clk: mediatek: clk-mux: Support custom parent indices for muxes
      clk: mediatek: mt8195-topckgen: Refactor parents for top_dp/edp muxes
      clk: mediatek: mt8188-topckgen: Refactor parents for top_dp/edp muxes

Biju Das (5):
      clk: versaclock3: Update vc3_get_div() to avoid divide by zero
      clk: versaclock3: Avoid unnecessary padding
      clk: versaclock3: Use u8 return type for get_parent() callback
      clk: versaclock3: Add missing space between ')' and '{'
      clk: versaclock3: Drop ret variable

Bjorn Andersson (5):
      Merge branch '20231026105345.3376-3-bryan.odonoghue@linaro.org' into clk-for-6.8
      Merge branch '20231106-topic-sm8650-upstream-clocks-v3-5-761a6fadb4c0@linaro.org' into clk-for-6.8
      Merge branch '20231123064735.2979802-2-quic_imrashai@quicinc.com' into clk-for-6.8
      Merge branch '20231205061002.30759-4-quic_sibis@quicinc.com' into clk-for-6.8
      Merge branch '20231201-videocc-8150-v3-1-56bec3a5e443@quicinc.com' into clk-for-6.8

Bryan O'Donoghue (3):
      dt-bindings: clock: Use gcc.yaml for common clock properties
      dt-bindings: clock: Add SC8280XP CAMCC
      clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC

Chris Morgan (3):
      clk: rockchip: rk3568: Add PLL rate for 115.2MHz
      clk: rockchip: rk3568: Add PLL rate for 126.4MHz
      clk: rockchip: rk3568: Mark pclk_usb as critical

Claudiu Beznea (4):
      clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
      clk: renesas: r9a08g045: Add IA55 pclk and its reset
      clk: renesas: rzg2l: Check reset monitor registers
      clk: renesas: r9a08g045: Add clock and reset support for ETH0 and ETH1

Colin Ian King (1):
      clk: sunxi-ng: nkm: remove redundant initialization of tmp_parent

Conor Dooley (1):
      clk: microchip: mpfs-ccc: replace include of asm-generic/errno-base.h

Dan Carpenter (1):
      clk: qcom: camcc-sc8280xp: Prevent error pointer dereference

Daniel Golle (2):
      dt-bindings: reset: mediatek: add MT7988 ethwarp reset IDs
      dt-bindings: clock: mediatek: add clock controllers of MT7988

Emil Renner Berthing (2):
      clk: starfive: Add flags argument to JH71X0__MUX macro
      clk: starfive: jh7100: Add CLK_SET_RATE_PARENT to gmac_tx

Gabriel Fernandez (3):
      clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
      clk: stm32mp1: use stm32mp13 reset driver
      dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform

Gokul Sriram Palanisamy (2):
      dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
      clk: qcom: apss-ipq-pll: add support for IPQ5018

Imran Shaik (2):
      dt-bindings: clock: qcom: Add ECPRICC clocks for QDU1000 and QRU1000
      clk: qcom: Add ECPRICC driver support for QDU1000 and QRU1000

Inochi Amaoto (1):
      dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC

Jay Buddhabhatti (2):
      drivers: clk: zynqmp: calculate closest mux rate
      drivers: clk: zynqmp: update divider round rate logic

Jerome Brunet (1):
      Merge branch 'v6.8/dt-bindings' into v6.8/drivers

Konrad Dybcio (9):
      clk: qcom: gcc-sm8550: Add the missing RETAIN_FF_ENABLE GDSC flag
      clk: qcom: gcc-sm8550: Mark the PCIe GDSCs votable
      clk: qcom: gcc-sm8550: use collapse-voting for PCIe GDSCs
      clk: qcom: gcc-sm8550: Mark RCGs shared where applicable
      clk: qcom: gpucc-sm8550: Update GPU PLL settings
      clk: qcom: dispcc-sm8550: Update disp PLL settings
      clk: qcom: dispcc-sm8550: Use the correct PLL configuration function
      clk: qcom: gpucc-sm8650: Add test_ctl parameters to PLL config
      clk: qcom: dispcc-sm8650: Add test_ctl parameters to PLL config

Kuan-Wei Chiu (3):
      clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
      clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
      clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()

Marek Vasut (5):
      clk: rs9: Fix DIF OEn bit placement on 9FGV0241
      dt-bindings: clk: rs9: Add 9FGV0841
      clk: rs9: Limit check to vendor ID in VID register
      clk: rs9: Replace model check with bitshift from chip data
      clk: rs9: Add support for 9FGV0841

Neil Armstrong (16):
      dt-bindings: clk: g12a-clkc: add CTS_ENCL clock ids
      clk: meson: g12a: add CTS_ENCL & CTS_ENCL_SEL clocks
      dt-bindings: clock: g12a-clkc: add MIPI ISP & CSI PHY clock ids
      clk: meson: g12a: add MIPI ISP clocks
      clk: meson: g12a: add CSI & ISP gates clocks
      dt-bindings: clock: qcom: document the SM8650 TCSR Clock Controller
      dt-bindings: clock: qcom: document the SM8650 General Clock Controller
      dt-bindings: clock: qcom: document the SM8650 Display Clock Controller
      dt-bindings: clock: qcom: document the SM8650 GPU Clock Controller
      dt-bindings: clock: qcom: Document the SM8650 RPMH Clock Controller
      clk: qcom: add the SM8650 Global Clock Controller driver, part 1
      clk: qcom: add the SM8650 Global Clock Controller driver, part 2
      clk: qcom: add the SM8650 TCSR Clock Controller driver
      clk: qcom: add the SM8650 Display Clock Controller driver
      clk: qcom: add the SM8650 GPU Clock Controller driver
      clk: qcom: rpmh: add clocks for SM8650

Niklas Söderlund (1):
      clk: renesas: r8a779g0: Add EtherTSN clock

Peng Fan (1):
      dt-bindings: clock: support i.MX93 ANATOP clock module

Rafał Miłecki (1):
      dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema

Rajendra Nayak (4):
      dt-bindings: clock: qcom: Add X1E80100 GCC clocks
      dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for X1E80100
      clk: qcom: Add Global Clock controller (GCC) driver for X1E80100
      clk: qcom: rpmh: Add support for X1E80100 rpmh clocks

Robert Marko (1):
      dt-bindings: clock: qcom,gcc-ipq6018: split to separate schema

Sam Protsenko (2):
      clk: samsung: Fix kernel-doc comments
      clk: samsung: Improve kernel-doc comments

Sam Shih (3):
      dt-bindings: clock: mediatek: add MT7988 clock IDs
      clk: mediatek: add pcw_chg_bit control for PLLs of MT7988
      clk: mediatek: add drivers for MT7988 SoC

Satya Priya Kakitapalli (5):
      clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
      dt-bindings: clock: Update the videocc resets for sm8150
      clk: qcom: videocc-sm8150: Update the videocc resets
      clk: qcom: videocc-sm8150: Add missing PLL config property
      clk: qcom: videocc-sm8150: Add runtime PM support

Shengjiu Wang (1):
      clk: imx: pll14xx: change naming of fvco to fout

Shubhrajyoti Datta (3):
      dt-bindings: Remove alt_ref from versal
      dt-bindings: clock: xilinx: add versal compatible
      clocking-wizard: Add support for versal clocking wizard

Stanislav Jakubek (1):
      dt-bindings: clock: brcm,kona-ccu: convert to YAML

Stephen Boyd (13):
      Merge tag 'renesas-clk-for-v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'v6.8-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'sunxi-clk-for-6.8-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'renesas-clk-for-v6.8-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'samsung-clk-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'qcom-clk-for-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'clk-imx-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-meson-v6.8-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge branches 'clk-renesas', 'clk-rockchip', 'clk-allwinner' and 'clk-cleanup' into clk-next
      Merge branches 'clk-versa', 'clk-silabs', 'clk-samsung', 'clk-starfive' and 'clk-sophgo' into clk-next
      Merge branches 'clk-imx', 'clk-qcom', 'clk-amlogic' and 'clk-mediatek' into clk-next
      Merge branches 'clk-zynq', 'clk-xilinx' and 'clk-stm' into clk-next
      Merge branch 'clk-rs9' into clk-next

Su Hui (1):
      clk: si5341: fix an error code problem in si5341_output_clk_set_rate

Taniya Das (1):
      clk: qcom: branch: Add mem ops support for branch2 clocks

Théo Lebrun (1):
      clk: fixed-rate: fix clk_hw_register_fixed_rate_with_accuracy_parent_hw

Vincent Knecht (2):
      dt-bindings: clock: qcom,gcc-msm8939: Add CSI2 related clocks
      clk: qcom: gcc-msm8939: Add missing CSI2 related clocks

Yang Yingliang (1):
      clk: sp7021: fix return value check in sp7021_clk_probe()

Yoshihiro Shimoda (1):
      clk: renesas: r8a779g0: Add PCIe clocks

 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   29 -
 .../bindings/arm/mediatek/mediatek,infracfg.yaml   |    1 +
 .../devicetree/bindings/clock/brcm,kona-ccu.txt    |  138 -
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  181 +
 .../bindings/clock/fsl,imx93-anatop.yaml           |   42 +
 .../bindings/clock/mediatek,apmixedsys.yaml        |    1 +
 .../devicetree/bindings/clock/mediatek,ethsys.yaml |   55 +
 .../bindings/clock/mediatek,mt7988-ethwarp.yaml    |   52 +
 .../bindings/clock/mediatek,mt7988-xfi-pll.yaml    |   48 +
 .../bindings/clock/mediatek,topckgen.yaml          |    2 +
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |    1 +
 .../bindings/clock/qcom,camcc-sm8250.yaml          |   18 +-
 .../bindings/clock/qcom,gcc-ipq6018.yaml           |   57 +
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |    3 -
 .../bindings/clock/qcom,qdu1000-ecpricc.yaml       |   68 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    2 +
 .../bindings/clock/qcom,sc7180-camcc.yaml          |   18 +-
 .../bindings/clock/qcom,sc7280-camcc.yaml          |   18 +-
 .../bindings/clock/qcom,sdm845-camcc.yaml          |   18 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml          |   20 +-
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    8 +-
 .../bindings/clock/qcom,sm8650-dispcc.yaml         |  106 +
 .../devicetree/bindings/clock/qcom,sm8650-gcc.yaml |   65 +
 .../bindings/clock/qcom,x1e80100-gcc.yaml          |   72 +
 .../devicetree/bindings/clock/renesas,9series.yaml |   10 +
 .../devicetree/bindings/clock/silabs,si5351.txt    |  126 -
 .../devicetree/bindings/clock/silabs,si5351.yaml   |  265 +
 .../bindings/clock/sophgo,cv1800-clk.yaml          |   46 +
 .../bindings/clock/st,stm32mp25-rcc.yaml           |   76 +
 .../bindings/clock/xlnx,clocking-wizard.yaml       |    1 +
 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   31 +-
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml      |    4 +-
 .../bindings/net/pcs/mediatek,sgmiisys.yaml        |   65 +-
 drivers/clk/Kconfig                                |   11 +-
 drivers/clk/Makefile                               |    1 -
 drivers/clk/clk-renesas-pcie.c                     |   37 +-
 drivers/clk/clk-si5341.c                           |    4 +-
 drivers/clk/clk-si5351.c                           |   47 +-
 drivers/clk/clk-sp7021.c                           |   12 +-
 drivers/clk/clk-versaclock3.c                      |   88 +-
 drivers/clk/hisilicon/clk-hi3620.c                 |    4 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   24 +-
 drivers/clk/imx/clk-pll14xx.c                      |   23 +-
 drivers/clk/imx/clk-scu.c                          |    4 +-
 drivers/clk/mediatek/Kconfig                       |    9 +
 drivers/clk/mediatek/Makefile                      |    5 +
 drivers/clk/mediatek/clk-mt7988-apmixed.c          |  114 +
 drivers/clk/mediatek/clk-mt7988-eth.c              |  150 +
 drivers/clk/mediatek/clk-mt7988-infracfg.c         |  275 +
 drivers/clk/mediatek/clk-mt7988-topckgen.c         |  325 +
 drivers/clk/mediatek/clk-mt7988-xfipll.c           |   82 +
 drivers/clk/mediatek/clk-mt8188-topckgen.c         |   27 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |   27 +-
 drivers/clk/mediatek/clk-mux.c                     |   14 +
 drivers/clk/mediatek/clk-mux.h                     |   43 +-
 drivers/clk/mediatek/clk-pll.c                     |    5 +-
 drivers/clk/mediatek/clk-pll.h                     |    1 +
 drivers/clk/meson/g12a.c                           |  115 +
 drivers/clk/meson/g12a.h                           |    1 +
 drivers/clk/microchip/clk-mpfs-ccc.c               |    2 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |    3 +
 drivers/clk/qcom/Kconfig                           |   63 +
 drivers/clk/qcom/Makefile                          |    7 +
 drivers/clk/qcom/apss-ipq-pll.c                    |   21 +
 drivers/clk/qcom/camcc-sc8280xp.c                  | 3045 +++++++++
 drivers/clk/qcom/clk-branch.c                      |   38 +
 drivers/clk/qcom/clk-branch.h                      |   21 +
 drivers/clk/qcom/clk-rpmh.c                        |   58 +
 drivers/clk/qcom/dispcc-sm8550.c                   |   12 +-
 drivers/clk/qcom/dispcc-sm8650.c                   | 1818 ++++++
 drivers/clk/qcom/ecpricc-qdu1000.c                 | 2456 +++++++
 drivers/clk/qcom/gcc-msm8939.c                     |  110 +-
 drivers/clk/qcom/gcc-sm8550.c                      |  110 +-
 drivers/clk/qcom/gcc-sm8650.c                      | 3849 +++++++++++
 drivers/clk/qcom/gcc-x1e80100.c                    | 6807 ++++++++++++++++++++
 drivers/clk/qcom/gpucc-sm8150.c                    |    4 +-
 drivers/clk/qcom/gpucc-sm8550.c                    |    6 +-
 drivers/clk/qcom/gpucc-sm8650.c                    |  663 ++
 drivers/clk/qcom/tcsrcc-sm8650.c                   |  182 +
 drivers/clk/qcom/videocc-sm8150.c                  |   25 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |    3 +
 drivers/clk/renesas/r9a08g045-cpg.c                |   13 +
 drivers/clk/renesas/rzg2l-cpg.c                    |   91 +-
 drivers/clk/rockchip/clk-rk3568.c                  |    3 +
 drivers/clk/samsung/clk-cpu.h                      |   30 +-
 drivers/clk/samsung/clk.h                          |  157 +-
 drivers/clk/starfive/clk-starfive-jh7100-audio.c   |    2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c         |   32 +-
 drivers/clk/starfive/clk-starfive-jh7110-aon.c     |    6 +-
 drivers/clk/starfive/clk-starfive-jh7110-isp.c     |    2 +-
 drivers/clk/starfive/clk-starfive-jh7110-sys.c     |   26 +-
 drivers/clk/starfive/clk-starfive-jh71x0.h         |    4 +-
 drivers/clk/stm32/Kconfig                          |   29 +
 drivers/clk/stm32/Makefile                         |    1 +
 drivers/clk/stm32/clk-stm32-core.c                 |    5 +-
 drivers/clk/stm32/clk-stm32-core.h                 |    5 +-
 drivers/clk/{ => stm32}/clk-stm32mp1.c             |  127 +-
 drivers/clk/stm32/clk-stm32mp13.c                  |    9 +-
 drivers/clk/stm32/reset-stm32.c                    |   14 +-
 drivers/clk/stm32/reset-stm32.h                    |    8 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |    5 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |  632 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |    2 +-
 drivers/clk/zynqmp/divider.c                       |   66 +-
 include/dt-bindings/clock/g12a-clkc.h              |    8 +
 include/dt-bindings/clock/mediatek,mt7988-clk.h    |  280 +
 include/dt-bindings/clock/qcom,gcc-msm8939.h       |    6 +
 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h   |  147 +
 include/dt-bindings/clock/qcom,sc8280xp-camcc.h    |  179 +
 include/dt-bindings/clock/qcom,sm8650-dispcc.h     |  102 +
 include/dt-bindings/clock/qcom,sm8650-gcc.h        |  254 +
 include/dt-bindings/clock/qcom,sm8650-gpucc.h      |   43 +
 include/dt-bindings/clock/qcom,sm8650-tcsr.h       |   18 +
 include/dt-bindings/clock/qcom,videocc-sm8150.h    |    4 +
 include/dt-bindings/clock/qcom,x1e80100-gcc.h      |  485 ++
 include/dt-bindings/clock/sophgo,cv1800.h          |  176 +
 include/dt-bindings/clock/st,stm32mp25-rcc.h       |  492 ++
 include/dt-bindings/reset/mediatek,mt7988-resets.h |   13 +
 include/dt-bindings/reset/qcom,sm8650-gpucc.h      |   20 +
 include/dt-bindings/reset/st,stm32mp25-rcc.h       |  167 +
 include/linux/clk-provider.h                       |    4 +-
 include/linux/platform_data/si5351.h               |    2 +
 123 files changed, 25043 insertions(+), 1026 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt7988-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7988-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7988-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7988-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt7988-xfipll.c
 create mode 100644 drivers/clk/qcom/camcc-sc8280xp.c
 create mode 100644 drivers/clk/qcom/dispcc-sm8650.c
 create mode 100644 drivers/clk/qcom/ecpricc-qdu1000.c
 create mode 100644 drivers/clk/qcom/gcc-sm8650.c
 create mode 100644 drivers/clk/qcom/gcc-x1e80100.c
 create mode 100644 drivers/clk/qcom/gpucc-sm8650.c
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8650.c
 create mode 100644 drivers/clk/stm32/Kconfig
 rename drivers/clk/{ => stm32}/clk-stm32mp1.c (95%)
 create mode 100644 include/dt-bindings/clock/mediatek,mt7988-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-tcsr.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-gcc.h
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
 create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt7988-resets.h
 create mode 100644 include/dt-bindings/reset/qcom,sm8650-gpucc.h
 create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

