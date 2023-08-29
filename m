Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75D78CF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjH2We0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbjH2WeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5F1BE;
        Tue, 29 Aug 2023 15:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B7062930;
        Tue, 29 Aug 2023 22:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E965C433C8;
        Tue, 29 Aug 2023 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693348452;
        bh=CDuJtE+Wm/gJXidLeF/NxJ59ghRpxPOXv9QCW+949AA=;
        h=Date:From:To:Cc:Subject:From;
        b=PICatCnPHxIwlYe8e5A2420kXuALm606917jLYrQY1zT23XNqtjW4f3UCm6Esci7k
         GF8ja14F2+y0cEADIyGDpEkrDNzktF7q+adiYHivABOUdrag7k3u29ZxRLtPYsIU+A
         BR8Awov6VAKLwTjS0r1aOizBVDGbJIjQGl2LwmR9WOZZKe1WXhUY+b9Xe2o79ps+9P
         me5sndW1NeGObSdDFXC/v29Lx5Z/UBc9wVnxs8iVMzAFBupLOQIxnMe4sY4wmnh6vo
         OwPpI5ZuFPDt9I+T8RZyvoxVjq7dFKE5n/nWN6js8mOJ+Sq7rI9LwvEYkxe3EZ3zEN
         xxvXEdMPjBjJg==
Received: (nullmailer pid 2808121 invoked by uid 1000);
        Tue, 29 Aug 2023 22:34:10 -0000
Date:   Tue, 29 Aug 2023 17:34:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.6
Message-ID: <20230829223410.GA2804587-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for 6.6. There's one conflict with net-next tree. 
Linux-next has the correct fix which is just drop the change from the 
deleted file.

Rob


The following changes since commit 7882541ca06d51a6c12d687827176c16d5e05f65:

  of/platform: increase refcount of fwnode (2023-08-21 16:12:28 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.6

for you to fetch changes up to 75cc186739805a5e8abe133be04692b36e7a5257:

  dt-bindings: usb: Add V3s compatible string for OHCI (2023-08-28 16:36:52 -0500)

----------------------------------------------------------------
Devicetree updates for v6.6:

DT core:
- Add support for generating DT nodes for PCI devices. This is the
  groundwork for applying overlays to PCI devices containing
  non-discoverable downstream devices.

- DT unittest additions to check reverted changesets, to test for
  refcount issues, and to test unresolved symbols. Also, various
  clean-ups of the unittest along the way.

- Refactor node and property manipulation functions to better share code
  with old API and changeset API

- Refactor changeset print functions to a common implementation

- Move some platform_device specific functions into of_platform.c

Bindings:
- Treewide fixing of typos

- Treewide clean-up of SPDX tags to use 'OR' consistently

- Last chunk of dropping unnecessary quotes. With that, the check
  for unnecessary quotes is enabled in yamllint.

- Convert ftgmac100, zynqmp-genpd, pps-gpio, syna,rmi4, and qcom,ssbi
  bindings to DT schema format

- Add Allwinner V3s xHCI USB, Saef SF-TC154B display, QCom SM8450 Inline
  Crypto Engine, QCom SM6115 UFS, QCom SDM670 PDC interrupt controller,
  Arm 2022 Cortex cores, and QCom IPQ9574 Crypto bindings

- Fixes for Rockchip DWC PCI binding

- Ensure all properties are evaluated on USB connector schema

- Fix dt-check-compatible script to find of_device_id instances with
  compiler annotations

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: trivial-devices: Remove national,lm75

Anusha Rao (1):
      dt-bindings: crypto: qcom-qce: add SoC compatible string for ipq9574

Bjorn Helgaas (1):
      dt-bindings: Fix typos

Chris Morgan (4):
      dt-bindings: vendor-prefixes: document Saef Technology
      dt-bindings: display: panel: mipi-dbi-spi: add Saef SF-TC154B
      dt-bindings: usb: Add V3s compatible string for EHCI
      dt-bindings: usb: Add V3s compatible string for OHCI

David Heidelberg (1):
      dt-bindings: thermal: lmh: update maintainer address

Dinh Nguyen (1):
      dt-bindings: reset: altr,modrst-offset is not required for arm64 SoCFPGA

Dmitry Baryshkov (1):
      dt-bindings: bus: convert qcom,ssbi schema to YAML format

Fabio Estevam (2):
      dt-bindings: pps: pps-gpio: Convert to yaml
      MAINTAINERS: pps: Update pps-gpio bindings location

Geert Uytterhoeven (13):
      of: unittest: Run overlay apply/revert sequence three times
      of: overlay: Call of_changeset_init() early
      of: unittest: Fix overlay type in apply/revert check
      of: unittest: Restore indentation in overlay_bad_add_dup_prop test
      of: unittest: Improve messages and comments in apply/revert checks
      of: unittest: Merge of_unittest_apply{,_revert}_overlay_check()
      of: unittest: Cleanup partially-applied overlays
      of: unittest: Add separators to of_unittest_overlay_high_level()
      of: overlay: unittest: Add test for unresolved symbol
      of: unittest-data: Convert remaining overlay DTS files to sugar syntax
      of: unittest-data: Fix whitespace - blank lines
      of: unittest-data: Fix whitespace - indentation
      of: unittest-data: Fix whitespace - angular brackets

Guru Das Srinagesh (1):
      dt-bindings: Update Guru Das Srinagesh's email address

Iskren Chernev (1):
      dt-bindings: ufs: qcom: Add sm6115 binding

Ivan Mikhaylov (1):
      dt-bindings: net: ftgmac100: convert to yaml version from txt

Konrad Dybcio (1):
      dt-bindings: interrupt-controller: qcom,pdc: Add SDM670

Krzysztof Kozlowski (6):
      dt-bindings: usb: samsung-hsotg: remove bindings already part of dwc2
      dt-bindings: usb: connector: disallow additional properties
      dt-bindings: display: msm/dp: restrict opp-table to objects
      dt-bindings: input: convert syna,rmi4 to DT schema
      dt-bindings: display: advantech,idk-2121wr: reference common panel
      dt-bindings: use capital "OR" for multiple licenses in SPDX

Lizhi Hou (5):
      of: dynamic: Add interfaces for creating device node dynamically
      PCI: Create device tree node for bridge
      PCI: Add quirks to generate device tree node for Xilinx Alveo U50
      of: overlay: Extend of_overlay_fdt_apply() to specify the target node
      of: unittest: Add pci_dt_testdrv pci driver

Luca Weiss (3):
      dt-bindings: ufs: qcom: Add reg-names property for ICE
      dt-bindings: ufs: qcom: Add ICE to sm8450 example
      dt-bindings: crypto: ice: Document sm8450 inline crypto engine

Naman Trivedi Manojbhai (1):
      dt-bindings: power: xilinx: merge zynqmp-genpd.txt with firmware binding

Rob Herring (13):
      dt-bindings: arm: cpus: Add Cortex A520, A720, and X4
      of: Move of_platform_register_reconfig_notifier() into DT core
      of: Move of_device_{add,register,unregister} to platform.c
      dt: dt-check-compatible: Find struct of_device_id instances with compiler annotations
      Merge branch 'dt/linus' into dt/next
      of: dynamic: Refactor changeset action printing to common helpers
      of: dynamic: Fix race in getting old property when updating property
      of: dynamic: Move dead property list check into property add/update functions
      of: Refactor node and property manipulation function locking
      of: unittest: Check tree matches original after reverting a changeset
      dt-bindings: Drop remaining unneeded quotes
      dt-bindings: yamllint: Enable quoted string check
      of: unittest: Fix of_unittest_pci_node() kconfig dependencies

Ruan Jinjie (2):
      of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()
      of: unittest: Remove redundant of_match_ptr()

Sebastian Reichel (4):
      dt-bindings: PCI: dwc: improve msi handling
      dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
      dt-bindings: PCI: dwc: rockchip: Use generic binding
      dt-bindings: PCI: dwc: rockchip: Add missing legacy-interrupt-controller

Stephen Rothwell (1):
      of: fix htmldocs build warnings

Viresh Kumar (1):
      of: Move of_skipped_node_table within #ifdef CONFIG_OF_ADDRESS

 Documentation/devicetree/bindings/.yamllint        |   5 +
 .../devicetree/bindings/arm/arm,coresight-cti.yaml |   2 +-
 .../bindings/arm/arm,coresight-dummy-sink.yaml     |   2 +-
 .../bindings/arm/arm,coresight-dummy-source.yaml   |   2 +-
 .../bindings/arm/arm,embedded-trace-extension.yaml |   6 +-
 .../bindings/arm/arm,trace-buffer-extension.yaml   |   9 +-
 .../bindings/arm/arm,versatile-sysreg.yaml         |   2 +-
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |   2 +-
 .../devicetree/bindings/arm/aspeed/aspeed,sbc.yaml |   4 +-
 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   2 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   3 +
 .../arm/firmware/tlm,trusted-foundations.yaml      |   4 +-
 Documentation/devicetree/bindings/arm/fsl.yaml     |   4 +-
 .../bindings/arm/keystone/ti,k3-sci-common.yaml    |   2 +-
 .../devicetree/bindings/arm/keystone/ti,sci.yaml   |   2 +-
 .../arm/marvell/cp110-system-controller.txt        |   8 +-
 .../bindings/arm/mediatek/mediatek,mipi0a.txt      |   2 +-
 .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |   2 +-
 Documentation/devicetree/bindings/arm/msm/ssbi.txt |  18 -
 .../bindings/arm/mstar/mstar,l3bridge.yaml         |   4 +-
 .../bindings/arm/mstar/mstar,smpctrl.yaml          |   4 +-
 .../bindings/arm/qcom,coresight-tpda.yaml          |   2 +-
 .../bindings/arm/qcom,coresight-tpdm.yaml          |   2 +-
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |   4 +-
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   4 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   4 +-
 .../devicetree/bindings/ata/pata-common.yaml       |   2 +-
 .../devicetree/bindings/bus/brcm,gisb-arb.yaml     |   2 +-
 .../bindings/bus/nvidia,tegra210-aconnect.yaml     |   4 +-
 .../devicetree/bindings/bus/qcom,ssbi.yaml         |  63 +++
 .../bindings/chrome/google,cros-ec-typec.yaml      |   6 +-
 .../clock/allwinner,sun4i-a10-osc-clk.yaml         |   2 +-
 .../devicetree/bindings/clock/alphascale,acc.txt   |   4 +-
 .../devicetree/bindings/clock/keystone-pll.txt     |   2 +-
 .../devicetree/bindings/clock/lpc1850-ccu.txt      |   2 +-
 .../devicetree/bindings/clock/lpc1850-creg-clk.txt |   4 +-
 .../devicetree/bindings/clock/maxim,max9485.txt    |   2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8450.yaml |   2 +-
 .../bindings/clock/qcom,kpss-acc-v1.yaml           |   2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml           |   2 +-
 .../devicetree/bindings/clock/ti,cdce925.yaml      |   2 +-
 .../devicetree/bindings/clock/ti,sci-clk.yaml      |   2 +-
 Documentation/devicetree/bindings/clock/ti/mux.txt |   2 +-
 .../devicetree/bindings/clock/vf610-clock.txt      |   2 +-
 .../bindings/connector/usb-connector.yaml          |  11 +-
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |   1 +
 .../devicetree/bindings/crypto/qcom-qce.yaml       |   1 +
 .../devicetree/bindings/crypto/ti,sa2ul.yaml       |   2 +-
 .../devfreq/event/samsung,exynos-ppmu.yaml         |   2 +-
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |   2 +-
 .../bindings/display/bridge/snps,dw-mipi-dsi.yaml  |   2 +-
 .../bindings/display/cirrus,clps711x-fb.txt        |   2 +-
 .../bindings/display/msm/dp-controller.yaml        |   3 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +-
 .../bindings/display/msm/dsi-phy-10nm.yaml         |   2 +-
 .../bindings/display/msm/dsi-phy-14nm.yaml         |   2 +-
 .../bindings/display/msm/dsi-phy-20nm.yaml         |   2 +-
 .../bindings/display/msm/dsi-phy-28nm.yaml         |   2 +-
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   2 +-
 .../bindings/display/msm/dsi-phy-common.yaml       |   2 +-
 .../bindings/display/msm/mdss-common.yaml          |   2 +-
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |   2 +-
 .../devicetree/bindings/display/msm/qcom,mdss.yaml |   4 +-
 .../bindings/display/msm/qcom,msm8998-dpu.yaml     |   2 +-
 .../bindings/display/msm/qcom,msm8998-mdss.yaml    |   2 +-
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |   2 +-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    |   2 +-
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sc7180-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sc7280-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sc8280xp-dpu.yaml    |   2 +-
 .../bindings/display/msm/qcom,sc8280xp-mdss.yaml   |   2 +-
 .../bindings/display/msm/qcom,sdm845-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sdm845-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm6115-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm6115-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm6350-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm6375-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm8150-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm8250-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm8250-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm8350-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm8350-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm8450-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm8450-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm8550-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm8550-mdss.yaml     |   2 +-
 .../display/panel/advantech,idk-2121wr.yaml        |   3 +
 .../bindings/display/panel/himax,hx8394.yaml       |   2 +-
 .../display/panel/mantix,mlaf057we51-x.yaml        |   2 +-
 .../display/panel/olimex,lcd-olinuxino.yaml        |   2 +-
 .../bindings/display/panel/orisetech,otm8009a.yaml |   2 +-
 .../bindings/display/panel/panel-common.yaml       |   2 +-
 .../bindings/display/panel/panel-dsi-cm.yaml       |   2 +-
 .../bindings/display/panel/panel-mipi-dbi-spi.yaml |   3 +-
 .../bindings/display/panel/panel-simple-dsi.yaml   |   2 +-
 .../bindings/display/panel/raydium,rm68200.yaml    |   2 +-
 .../display/panel/rocktech,jh057n00900.yaml        |   2 +-
 .../bindings/display/panel/visionox,rm69299.yaml   |   2 +-
 .../bindings/display/panel/visionox,vtdr6130.yaml  |   2 +-
 .../bindings/display/rockchip/rockchip-vop2.yaml   |   2 +-
 .../display/tegra/nvidia,tegra124-sor.yaml         |   2 +-
 .../devicetree/bindings/dma/ingenic,dma.yaml       |   2 +-
 .../bindings/dma/nvidia,tegra20-apbdma.txt         |   2 +-
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |   2 +-
 .../devicetree/bindings/dma/stericsson,dma40.yaml  |   2 +-
 Documentation/devicetree/bindings/eeprom/at24.yaml |   4 +-
 Documentation/devicetree/bindings/eeprom/at25.yaml |   4 +-
 .../bindings/extcon/qcom,pm8941-misc.yaml          |   2 +-
 .../intel,ixp4xx-network-processing-engine.yaml    |   4 +-
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml      |  14 +
 .../devicetree/bindings/fpga/fpga-region.txt       |   4 +-
 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |   2 +-
 .../devicetree/bindings/gpio/snps,dw-apb-gpio.yaml |   2 +-
 .../devicetree/bindings/gpio/ti,omap-gpio.yaml     |   4 +-
 .../bindings/gpio/x-powers,axp209-gpio.yaml        |   4 +-
 .../bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml    |   4 +-
 .../bindings/gpio/xylon,logicvc-gpio.yaml          |   4 +-
 .../hwlock/allwinner,sun6i-a31-hwspinlock.yaml     |   2 +-
 .../bindings/hwlock/ti,omap-hwspinlock.yaml        |   2 +-
 .../devicetree/bindings/hwmon/adi,adm1177.yaml     |   2 +-
 .../bindings/hwmon/adi,axi-fan-control.yaml        |   2 +-
 .../devicetree/bindings/hwmon/adi,ltc2992.yaml     |   2 +-
 .../devicetree/bindings/hwmon/aspeed-pwm-tacho.txt |   2 +-
 .../devicetree/bindings/hwmon/iio-hwmon.yaml       |   4 +-
 .../devicetree/bindings/hwmon/jedec,jc42.yaml      |   2 +-
 .../devicetree/bindings/hwmon/lltc,ltc4151.yaml    |   2 +-
 Documentation/devicetree/bindings/hwmon/lm75.yaml  |   2 +-
 Documentation/devicetree/bindings/hwmon/lm87.txt   |   2 +-
 .../devicetree/bindings/hwmon/ltq-cputemp.txt      |   2 +-
 .../bindings/hwmon/microchip,mcp3021.yaml          |   2 +-
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |   2 +-
 .../devicetree/bindings/hwmon/national,lm90.yaml   |   2 +-
 .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  |   2 +-
 .../devicetree/bindings/hwmon/nxp,mc34vr500.yaml   |   2 +-
 .../devicetree/bindings/hwmon/sensirion,sht15.yaml |   2 +-
 .../devicetree/bindings/hwmon/sensirion,shtc1.yaml |   2 +-
 .../bindings/hwmon/starfive,jh71x0-temp.yaml       |   8 +-
 .../devicetree/bindings/hwmon/ti,tmp102.yaml       |   2 +-
 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |   2 +-
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |   2 +-
 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-sprd.txt |   2 +-
 .../devicetree/bindings/i3c/mipi-i3c-hci.yaml      |   4 +-
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml |   4 +-
 .../bindings/iio/adc/atmel,sama9260-adc.yaml       |   4 +-
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |   2 +-
 .../devicetree/bindings/iio/cdc/adi,ad7150.yaml    |   2 +-
 Documentation/devicetree/bindings/iio/common.yaml  |   2 +-
 .../bindings/iio/frequency/adi,admv1014.yaml       |   2 +-
 .../bindings/iio/humidity/ti,hdc2010.yaml          |   2 +-
 .../iio/pressure/honeywell,mprls0025pa.yaml        |   2 +-
 .../bindings/iio/proximity/ams,as3935.yaml         |   2 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |   2 +-
 .../devicetree/bindings/input/elan,ekth3000.yaml   |   2 +-
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  56 ---
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |  39 --
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  61 ---
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |  56 ---
 .../devicetree/bindings/input/syna,rmi4.yaml       | 271 ++++++++++++
 .../bindings/input/touchscreen/tsc2007.txt         |   2 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   2 +-
 .../brcm,bcm2835-armctrl-ic.txt                    |   2 +-
 .../interrupt-controller/brcm,bcm7120-l2-intc.yaml |   2 +-
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../interrupt-controller/ti,pruss-intc.yaml        |   2 +-
 .../devicetree/bindings/iommu/xen,grant-dma.yaml   |   2 +-
 .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml      |   8 +-
 .../devicetree/bindings/ipmi/ipmi-ipmb.yaml        |   2 +-
 .../devicetree/bindings/ipmi/ipmi-smic.yaml        |   2 +-
 .../leds/backlight/mediatek,mt6370-backlight.yaml  |   2 +-
 .../devicetree/bindings/leds/leds-lp55xx.yaml      |   4 +-
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   2 +-
 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    |   2 +-
 .../bindings/mailbox/ti,omap-mailbox.yaml          |   4 +-
 .../bindings/media/i2c/toshiba,tc358746.yaml       |   2 +-
 .../devicetree/bindings/media/i2c/tvp5150.txt      |   2 +-
 .../media/mediatek,vcodec-subdev-decoder.yaml      |   2 +-
 .../bindings/media/qcom,msm8916-venus.yaml         |   4 +-
 .../memory-controllers/mediatek,smi-larb.yaml      |   2 +-
 .../memory-controllers/rockchip,rk3399-dmc.yaml    |   4 +-
 .../memory-controllers/xlnx,zynq-ddrc-a05.yaml     |   2 +-
 .../devicetree/bindings/mfd/aspeed-lpc.yaml        |   2 +-
 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |   2 +-
 .../devicetree/bindings/mfd/rohm,bd9576-pmic.yaml  |   4 +-
 .../devicetree/bindings/mfd/stericsson,ab8500.yaml |  16 +-
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |   2 +-
 .../bindings/mips/loongson/ls2k-reset.yaml         |   4 +-
 .../bindings/mips/loongson/rs780e-acpi.yaml        |   4 +-
 .../misc/intel,ixp4xx-ahb-queue-manager.yaml       |   4 +-
 .../bindings/mmc/marvell,xenon-sdhci.yaml          |   4 +-
 Documentation/devicetree/bindings/mmc/pxa-mmc.txt  |   2 +-
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   2 +-
 .../bindings/mtd/microchip,mchp48l640.yaml         |   4 +-
 .../bindings/net/brcm,bcm7445-switch-v4.0.txt      |   2 +-
 .../devicetree/bindings/net/can/cc770.txt          |   2 +-
 .../devicetree/bindings/net/dsa/brcm,sf2.yaml      |   2 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   2 +-
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 102 +++++
 .../devicetree/bindings/net/ftgmac100.txt          |  67 ---
 .../devicetree/bindings/net/mediatek-dwmac.yaml    |   2 +-
 .../devicetree/bindings/net/microchip,lan95xx.yaml |   2 +-
 .../devicetree/bindings/net/nfc/marvell,nci.yaml   |   4 +-
 .../devicetree/bindings/net/samsung-sxgbe.txt      |   4 +-
 .../bindings/net/snps,dwc-qos-ethernet.txt         |   2 +-
 .../devicetree/bindings/net/sti-dwmac.txt          |   2 +-
 .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  |   2 +-
 Documentation/devicetree/bindings/nios2/nios2.txt  |   2 +-
 .../bindings/nvmem/layouts/onie,tlv-layout.yaml    |   2 +-
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  70 ++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |  18 +-
 .../bindings/phy/mediatek,mt7621-pci-phy.yaml      |   2 +-
 .../bindings/phy/nvidia,tegra210-xusb-padctl.yaml  |   2 +-
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |   2 +-
 .../devicetree/bindings/phy/pistachio-usb-phy.txt  |   2 +-
 .../devicetree/bindings/phy/pxa1928-usb-phy.txt    |   2 +-
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       |   2 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   2 +-
 Documentation/devicetree/bindings/phy/ti-phy.txt   |   2 +-
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |   2 +-
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |   2 +-
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt6795-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt7981-pinctrl.yaml  |   4 +-
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  |   4 +-
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/pinctrl-max77620.txt          |   2 +-
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  |   2 +-
 .../devicetree/bindings/pinctrl/sprd,pinctrl.txt   |   2 +-
 .../devicetree/bindings/pmem/pmem-region.txt       |   4 +-
 .../bindings/power/renesas,sysc-rmobile.yaml       |   2 +-
 .../bindings/power/reset/gpio-poweroff.yaml        |   2 +-
 .../bindings/power/reset/gpio-restart.yaml         |   2 +-
 .../bindings/power/reset/restart-handler.yaml      |   2 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |   2 +-
 .../bindings/power/supply/sbs,sbs-manager.yaml     |   2 +-
 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 --
 .../devicetree/bindings/powerpc/fsl/cpus.txt       |   2 +-
 .../devicetree/bindings/powerpc/fsl/dcsr.txt       |   4 +-
 .../devicetree/bindings/powerpc/fsl/raideng.txt    |   2 +-
 .../bindings/powerpc/nintendo/gamecube.txt         |   2 +-
 .../devicetree/bindings/powerpc/nintendo/wii.txt   |   2 +-
 Documentation/devicetree/bindings/pps/pps-gpio.txt |  30 --
 .../devicetree/bindings/pps/pps-gpio.yaml          |  49 +++
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml      |   2 +-
 .../bindings/regulator/regulator-max77620.txt      |   2 +-
 .../devicetree/bindings/regulator/regulator.yaml   |   8 +-
 .../regulator/richtek,rt5190a-regulator.yaml       |   2 +-
 .../devicetree/bindings/regulator/vctrl.txt        |   2 +-
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       |   2 +-
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml       |   4 +-
 .../bindings/remoteproc/ti,omap-remoteproc.yaml    |   2 +-
 .../bindings/remoteproc/ti,pru-consumer.yaml       |   2 +-
 .../bindings/remoteproc/ti,pru-rproc.yaml          |   2 +-
 .../bindings/remoteproc/xlnx,zynqmp-r5fss.yaml     |   2 +-
 .../devicetree/bindings/reset/altr,rst-mgr.yaml    |  12 +-
 .../devicetree/bindings/reset/ti,sci-reset.yaml    |   2 +-
 .../bindings/reset/ti,tps380x-reset.yaml           |   2 +-
 .../devicetree/bindings/reset/ti-syscon-reset.txt  |   2 +-
 .../devicetree/bindings/rng/omap_rng.yaml          |   4 +-
 Documentation/devicetree/bindings/rtc/rtc-cmos.txt |   2 +-
 .../devicetree/bindings/serial/st-asc.txt          |   2 +-
 .../bindings/soc/aspeed/uart-routing.yaml          |   4 +-
 .../bindings/soc/intel/intel,hps-copy-engine.yaml  |   4 +-
 .../bindings/soc/litex/litex,soc-controller.yaml   |   4 +-
 .../soc/mediatek/mediatek,mt7986-wo-ccif.yaml      |   2 +-
 .../microchip/microchip,mpfs-sys-controller.yaml   |   2 +-
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   2 +-
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   6 -
 .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml   |   4 +-
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     |   4 +-
 .../devicetree/bindings/soc/ti/sci-pm-domain.yaml  |   2 +-
 .../bindings/sound/axentia,tse850-pcm5142.txt      |   2 +-
 .../devicetree/bindings/sound/cs35l35.txt          |   2 +-
 .../devicetree/bindings/sound/cs35l36.txt          |   2 +-
 .../devicetree/bindings/sound/cs53l30.txt          |   2 +-
 .../devicetree/bindings/sound/dialog,da7219.yaml   |   4 +-
 .../devicetree/bindings/sound/fsl,esai.txt         |   2 +-
 .../bindings/sound/mediatek,mt8188-afe.yaml        |   2 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |   2 +-
 .../devicetree/bindings/sound/mt8195-afe-pcm.yaml  |   4 +-
 .../sound/nvidia,tegra-audio-max9808x.yaml         |  12 +-
 .../bindings/sound/nvidia,tegra-audio-rt5631.yaml  |   8 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   2 +-
 .../bindings/sound/rockchip,rk3288-hdmi-analog.txt |   2 +-
 Documentation/devicetree/bindings/sound/rt5663.txt |   2 +-
 .../devicetree/bindings/sound/serial-midi.yaml     |   2 +-
 .../devicetree/bindings/sound/sprd-pcm.txt         |   2 +-
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   2 +-
 .../bindings/sound/ti,j721e-cpb-ivi-audio.yaml     |   2 +-
 .../devicetree/bindings/sound/ti,tas2781.yaml      |   2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |   2 +-
 .../bindings/soundwire/qcom,soundwire.yaml         |   4 +-
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   4 +-
 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml |   4 +-
 .../devicetree/bindings/spi/omap-spi.yaml          |   2 +-
 .../devicetree/bindings/thermal/qcom-lmh.yaml      |   2 +-
 .../devicetree/bindings/timer/snps,arc-timer.txt   |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |  10 +-
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  44 ++
 .../devicetree/bindings/ufs/ufs-common.yaml        |   2 +-
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |   2 +-
 .../devicetree/bindings/usb/cypress,cypd4226.yaml  |   6 +-
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   |   2 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |   1 +
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |   2 +-
 .../devicetree/bindings/usb/msm-hsusb.txt          |   2 +-
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |   2 +-
 .../devicetree/bindings/usb/richtek,rt1719.yaml    |   2 +-
 .../devicetree/bindings/usb/samsung-hsotg.txt      |  38 --
 .../devicetree/bindings/usb/ti,usb8041.yaml        |   2 +-
 .../devicetree/bindings/usb/vialab,vl817.yaml      |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../bindings/watchdog/toshiba,visconti-wdt.yaml    |   4 +-
 MAINTAINERS                                        |   2 +-
 drivers/base/platform.c                            |   2 +-
 drivers/of/base.c                                  |  90 ++--
 drivers/of/device.c                                |  32 --
 drivers/of/dynamic.c                               | 292 ++++++++-----
 drivers/of/of_private.h                            |   6 +
 drivers/of/overlay.c                               |  45 +-
 drivers/of/platform.c                              |  44 +-
 drivers/of/unittest-data/Makefile                  |   4 +-
 drivers/of/unittest-data/overlay.dtso              |  32 +-
 drivers/of/unittest-data/overlay_0.dtso            |  11 +-
 drivers/of/unittest-data/overlay_1.dtso            |  11 +-
 drivers/of/unittest-data/overlay_11.dtso           |   1 -
 drivers/of/unittest-data/overlay_12.dtso           |  11 +-
 drivers/of/unittest-data/overlay_13.dtso           |  11 +-
 drivers/of/unittest-data/overlay_15.dtso           |   1 +
 drivers/of/unittest-data/overlay_4.dtso            |   1 -
 .../of/unittest-data/overlay_bad_add_dup_node.dtso |   9 +-
 .../of/unittest-data/overlay_bad_add_dup_prop.dtso |   9 +-
 drivers/of/unittest-data/overlay_bad_phandle.dtso  |   5 +-
 drivers/of/unittest-data/overlay_bad_symbol.dtso   |   5 +-
 .../of/unittest-data/overlay_bad_unresolved.dtso   |   7 +
 drivers/of/unittest-data/overlay_common.dtsi       |  36 +-
 drivers/of/unittest-data/overlay_gpio_01.dtso      |   1 +
 drivers/of/unittest-data/overlay_gpio_02a.dtso     |   1 +
 drivers/of/unittest-data/overlay_gpio_02b.dtso     |   1 +
 drivers/of/unittest-data/overlay_gpio_03.dtso      |   1 +
 drivers/of/unittest-data/overlay_gpio_04a.dtso     |   1 +
 drivers/of/unittest-data/overlay_gpio_04b.dtso     |   1 +
 drivers/of/unittest-data/overlay_pci_node.dtso     |  22 +
 drivers/of/unittest-data/testcases_common.dtsi     |   1 +
 drivers/of/unittest-data/tests-interrupts.dtsi     |   1 +
 drivers/of/unittest-data/tests-overlay.dtsi        |   1 -
 drivers/of/unittest-data/tests-phandle.dtsi        |   2 +
 drivers/of/unittest.c                              | 460 +++++++++++++++++----
 drivers/pci/Kconfig                                |  12 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/bus.c                                  |   2 +
 drivers/pci/of.c                                   |  79 ++++
 drivers/pci/of_property.c                          | 355 ++++++++++++++++
 drivers/pci/pci.h                                  |  12 +
 drivers/pci/quirks.c                               |  12 +
 drivers/pci/remove.c                               |   1 +
 include/dt-bindings/ata/ahci.h                     |   2 +-
 include/dt-bindings/clock/hi3559av100-clock.h      |   2 +-
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h      |   2 +-
 include/dt-bindings/clock/rockchip,rk3588-cru.h    |   2 +-
 include/dt-bindings/clock/stm32mp1-clks.h          |   2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h          |   2 +-
 include/dt-bindings/clock/sun20i-d1-r-ccu.h        |   2 +-
 include/dt-bindings/clock/sun50i-a100-ccu.h        |   2 +-
 include/dt-bindings/clock/sun50i-h6-ccu.h          |   2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h        |   2 +-
 include/dt-bindings/clock/sun6i-rtc.h              |   2 +-
 include/dt-bindings/display/sdtv-standards.h       |   2 +-
 include/dt-bindings/gpio/meson-g12a-gpio.h         |   2 +-
 include/dt-bindings/power/meson-a1-power.h         |   2 +-
 include/dt-bindings/power/meson-axg-power.h        |   2 +-
 include/dt-bindings/power/meson-g12a-power.h       |   2 +-
 include/dt-bindings/power/meson-gxbb-power.h       |   2 +-
 include/dt-bindings/power/meson-s4-power.h         |   2 +-
 include/dt-bindings/power/meson-sm1-power.h        |   2 +-
 include/dt-bindings/power/meson8-power.h           |   2 +-
 include/dt-bindings/power/r8a779f0-sysc.h          |   2 +-
 include/dt-bindings/power/rk3588-power.h           |   2 +-
 include/dt-bindings/power/summit,smb347-charger.h  |   2 +-
 include/dt-bindings/reset/rockchip,rk3588-cru.h    |   2 +-
 include/dt-bindings/reset/stm32mp1-resets.h        |   2 +-
 include/dt-bindings/reset/sun20i-d1-ccu.h          |   2 +-
 include/dt-bindings/reset/sun20i-d1-r-ccu.h        |   2 +-
 include/dt-bindings/reset/sun50i-a100-ccu.h        |   2 +-
 include/dt-bindings/reset/sun50i-a100-r-ccu.h      |   2 +-
 include/dt-bindings/reset/sun50i-h6-ccu.h          |   2 +-
 include/dt-bindings/reset/sun50i-h6-r-ccu.h        |   2 +-
 include/dt-bindings/reset/sun50i-h616-ccu.h        |   2 +-
 include/linux/of.h                                 |  32 +-
 include/linux/of_platform.h                        |   6 -
 scripts/dtc/dt-extract-compatibles                 |   4 +-
 396 files changed, 2371 insertions(+), 1213 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/ssbi.txt
 create mode 100644 Documentation/devicetree/bindings/bus/qcom,ssbi.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
 create mode 100644 Documentation/devicetree/bindings/input/syna,rmi4.yaml
 create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
 delete mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 delete mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/samsung-hsotg.txt
 create mode 100644 drivers/of/unittest-data/overlay_bad_unresolved.dtso
 create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
 create mode 100644 drivers/pci/of_property.c
