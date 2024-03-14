Return-Path: <linux-kernel+bounces-103420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3487BF29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A903B23636
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0771720;
	Thu, 14 Mar 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWwSh91C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203170CD1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427312; cv=none; b=VyvCzbHRc41CDGGgZu2OOhLfX6lfuazcSPfXr+ctCpqdvbvyHkwVsBP+du4JX3STj19S84R352pvWIjJugPpsaX8KgM2pDWZGszRc5wGog/2KPHB0dNp/c2OtkULWK1sfcC+PES1Uj4KeziKWE+uqrPxaRG8uxu/FCbmuptwhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427312; c=relaxed/simple;
	bh=LJuMt8qHu1hM8DyAvWPDPUOAwQQpfiBOjmyfHnB/m5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7OSB/nEXw1W0brdR047DufUespqAahdMifqT+kuXhiHMC9EZ55k6Imo+X4/MhgULcU2IyLUPyJ5t4NXwMEAMk2RKZzPqH6B0Rq9sYPe0djVnoX2iI6//J5iCl64P6CDYRf4+ABCfLoW+pznNoC+2gQDrtJ1uDps4qtFJm8ojCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWwSh91C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801AEC433C7;
	Thu, 14 Mar 2024 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427312;
	bh=LJuMt8qHu1hM8DyAvWPDPUOAwQQpfiBOjmyfHnB/m5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWwSh91CQulzm9LY9L/kyoq4qCiHGfSvqARVoILMJFfaxwpW+mDaylE6ksQQVHvXB
	 0X5ZbllPU9cB8mjmnuvfB0gyu/phPKCG5/AcVYhsiqMOLBsB+XJdW/iQOy5JwDLTG8
	 ow3XiLQQieXmf++wsK5owkp6mFTC8WN/gaYBLVdYgD8HHAkdl3yeB5MPkJeQQipnMQ
	 E6fN58h0FpRrJ9S2CoZNTDYaAVwT3UGenZ8Rw38Q2j436G4IDslobjEWfXWZ9vf02+
	 uPvvXqUH7biSKJoxJKX/alLzgAr3mUvxJn5r1H+mLRqOxpPMzszQRO5j3qEcvfCvIh
	 E5dCl+Sc4fXaQ==
Date: Thu, 14 Mar 2024 14:41:48 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] MFD for v6.9
Message-ID: <20240314144148.GO1522089@google.com>
References: <20240314143847.GN1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314143847.GN1522089@google.com>

echo ${SUBJECT} | sed 's/Backlight/MFD/'

> Good afternoon Linus,
> 
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-next-6.9
> 
> for you to fetch changes up to 78334c343bef528b911da83a6b041d15a1a72efb:
> 
>   mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults (2024-03-05 10:40:30 +0000)
> 
> ----------------------------------------------------------------
>  - New Device Support
>    - Add support for Watchdog to ChromeOS Embedded Controller
>    - Add support for GPIOs to ChromeOS Embedded Controller
>    - Add supprt for Sound to MediaTek MT6357 CODEC
> 
>  - New Functionality
>    - Add power-off functionality to Texas Instruments TWL series CODECs
> 
>  - Fix-ups
>    - Device Tree binding adaptions/conversions/creation
>    - Use/convert to new/better APIs/helpers/MACROs instead of hand-rolling implementations
>    - Trivial; spelling, whitespace, clean-ups, etc
>    - Remove superfluous code and simplify overall
>    - Fix include lists; alphabetise, remove unused, explicitly add used
>    - Use dev_err_probe() to clean-up error paths
>    - Convert used cache type over to the Maple Tree in many instances
>    - Constify a bunch of static structs
>    - Refrain from over-riding resources provided via the firmware
> 
>  - Bug Fixes
>    - Fix a clock related firmware bug on Dell XPS 9530 et al.
>    - Repair incorrect IRQ designations
>    - Increase buffer sizes to omit various snprintf compiler errors
>    - Ensure errors are handled properly
>    - Balance references and prevent resource leaks
>    - Rectify Power Key interrupt processing
>    - Fix Kconfig related build errors
>    - Correct a bunch of register start-up default values
> 
> ----------------------------------------------------------------
> Aleksandrs Vinarskis (2):
>       mfd: intel-lpss: Switch to generalized quirk table
>       mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
> 
> Alexander Sverdlin (1):
>       mfd: twl: Select MFD_CORE
> 
> Andreas Kemnade (3):
>       dt-bindings: mfd: ti,twl: Document system-power-controller
>       mfd: twl-core: Add power off implementation for twl603x
>       mfd: twl4030-power: Accept standard property for power controller
> 
> Andrew Davis (1):
>       dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl compatible
> 
> Balakrishnan Sambath (1):
>       dt-bindings: mfd: Convert atmel-flexcom to json-schema
> 
> Biju Das (6):
>       dt-bindings: mfd: da9062: Update watchdog description
>       dt-bindings: mfd: dlg,da9063: Update watchdog child node
>       dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
>       dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
>       dt-bindings: mfd: dlg,da9063: Sort child devices
>       dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
> 
> Bo Liu (18):
>       mfd: ac100: Convert to use maple tree register cache
>       mfd: as3711: Convert to use maple tree register cache
>       mfd: as3722: Convert to use maple tree register cache
>       mfd: axp20x: Convert to use maple tree register cache
>       mfd: bcm590xx: Convert to use maple tree register cache
>       mfd: bd9571mwv: Convert to use maple tree register cache
>       mfd: dialog: Convert to use maple tree register cache
>       mfd: khadas-mcu: Convert to use maple tree register cache
>       mfd: lochnagar-i2c: Convert to use maple tree register cache
>       mfd: wolfson: Convert to use maple tree register cache
>       mfd: rohm: Convert to use maple tree register cache
>       mfd: rk8xx: Convert to use maple tree register cache
>       mfd: rn5t618: Convert to use maple tree register cache
>       mfd: rsmu_i2c: Convert to use maple tree register cache
>       mfd: si476x: Convert to use maple tree register cache
>       mfd: stmfx: Convert to use maple tree register cache
>       mfd: stpmic1: Convert to use maple tree register cache
>       mfd: rc5t583: Convert to use maple tree register cache
> 
> Charles Keepax (6):
>       mfd: cs42l43: Tidy up header includes
>       mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
>       mfd: cs42l43: Add time postfixes on defines
>       mfd: cs42l43: Add some missing dev_err_probe()s
>       mfd: cs42l43: Handle error from devm_pm_runtime_enable()
>       spi: cs42l43: Tidy up header includes
> 
> Dharma Balasubiramani (1):
>       dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> 
> Dmitry Baryshkov (1):
>       dt-bindings: mfd: qcom,tcsr: Add compatibles for QCM2290 and SM6115
> 
> Fabien Parent (1):
>       mfd: mt6397-core: Register mt6357 sound codec
> 
> Fuyao Kashizuku (1):
>       mfd: sun4i-gpadc: Correct specified GPADC interrupt numbers
> 
> Geert Uytterhoeven (2):
>       mfd: mc13xxx: Use bitfield helpers
>       dt-bindings: mfd: dlg,da9063: Make #interrupt-cells required
> 
> Ilpo Järvinen (1):
>       mfd: lpc_ich: Use ALIGN_DOWN() to obtain the start of the SPI base range
> 
> Krzysztof Kozlowski (1):
>       dt-bindings: mfd: iqs62x: Do not override firmware-name $ref
> 
> Lee Jones (2):
>       Merge branches 'ib-mfd-cros-watchdog-6.9' and 'ib-mfd-input-thermal-6.9' into ibs-for-mfd-merged
>       mfd: omap-usb-host: Increase size of buffer to include all possible values
> 
> Lukasz Majczak (3):
>       platform/chrome: Update binary interface for EC-based watchdog
>       watchdog: Add ChromeOS EC-based watchdog driver
>       mfd: cros_ec: Register EC-based watchdog subdevice
> 
> Maciej Strozek (3):
>       mfd: wm831x: Remove redundant forever while loop
>       mfd: cs42l43: Fix wrong register defaults
>       mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults
> 
> Michael Brunner (1):
>       mfd: kempld-core: Don't replace resources provided by ACPI
> 
> Ondrej Jirman (1):
>       mfd: rk8xx-core: Fix interrupt processing order for power key button
> 
> Peter Griffin (3):
>       mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
>       mfd: syscon: Remove extern from function prototypes
>       mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
> 
> Ricardo B. Marliere (2):
>       mfd: mcp-core: Make mcp_bus_type const
>       mfd: core: Constify the struct device_type usage
> 
> Roger Quadros (1):
>       dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
> 
> Siddharth Vadapalli (1):
>       dt-bindings: mfd: syscon: Add ti,j784s4-pcie-ctrl compatible
> 
> Simon Horman (1):
>       mfd: rave-sp: Avoid unnecessary use of comma operator
> 
> Stephen Boyd (2):
>       dt-bindings: mfd: cros-ec: Add properties for GPIO controller
>       mfd: cros_ec_dev: Add GPIO device if feature present on EC
> 
>  .../devicetree/bindings/input/da9062-onkey.txt     |  47 ----
>  .../bindings/input/dlg,da9062-onkey.yaml           |  38 ++++
>  .../devicetree/bindings/mfd/atmel,hlcdc.yaml       |  99 ++++++++
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml        |  99 ++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      |  64 ------
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  56 -----
>  Documentation/devicetree/bindings/mfd/da9062.txt   | 124 ----------
>  .../devicetree/bindings/mfd/dlg,da9063.yaml        | 251 ++++++++++++++++++---
>  .../devicetree/bindings/mfd/google,cros-ec.yaml    |   7 +
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml  |   2 +-
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   2 +
>  Documentation/devicetree/bindings/mfd/syscon.yaml  |   3 +
>  Documentation/devicetree/bindings/mfd/ti,twl.yaml  |   2 +
>  .../devicetree/bindings/thermal/da9062-thermal.txt |  36 ---
>  .../bindings/thermal/dlg,da9062-thermal.yaml       |  35 +++
>  MAINTAINERS                                        |  12 +-
>  drivers/mfd/Kconfig                                |   1 +
>  drivers/mfd/ac100.c                                |   2 +-
>  drivers/mfd/altera-sysmgr.c                        |   4 +-
>  drivers/mfd/as3711.c                               |   2 +-
>  drivers/mfd/as3722.c                               |   2 +-
>  drivers/mfd/axp20x.c                               |   4 +-
>  drivers/mfd/bcm590xx.c                             |   4 +-
>  drivers/mfd/bd9571mwv.c                            |   4 +-
>  drivers/mfd/cros_ec_dev.c                          |  18 ++
>  drivers/mfd/cs42l43-i2c.c                          |  15 +-
>  drivers/mfd/cs42l43-sdw.c                          |  15 +-
>  drivers/mfd/cs42l43.c                              | 124 +++++-----
>  drivers/mfd/cs42l43.h                              |  10 +-
>  drivers/mfd/da9052-core.c                          |   2 +-
>  drivers/mfd/da9055-core.c                          |   2 +-
>  drivers/mfd/da9062-core.c                          |   4 +-
>  drivers/mfd/da9063-i2c.c                           |   2 +-
>  drivers/mfd/da9150-core.c                          |   2 +-
>  drivers/mfd/intel-lpss-pci.c                       |  28 ++-
>  drivers/mfd/intel-lpss.c                           |   9 +-
>  drivers/mfd/intel-lpss.h                           |  14 +-
>  drivers/mfd/kempld-core.c                          |  37 ---
>  drivers/mfd/khadas-mcu.c                           |   2 +-
>  drivers/mfd/lochnagar-i2c.c                        |   4 +-
>  drivers/mfd/lpc_ich.c                              |   3 +-
>  drivers/mfd/mc13xxx-core.c                         |  22 +-
>  drivers/mfd/mcp-core.c                             |   2 +-
>  drivers/mfd/mfd-core.c                             |   2 +-
>  drivers/mfd/mt6397-core.c                          |   3 +
>  drivers/mfd/omap-usb-host.c                        |   2 +-
>  drivers/mfd/rave-sp.c                              |   2 +-
>  drivers/mfd/rc5t583.c                              |   2 +-
>  drivers/mfd/rk8xx-core.c                           |   2 +-
>  drivers/mfd/rk8xx-spi.c                            |   2 +-
>  drivers/mfd/rn5t618.c                              |   2 +-
>  drivers/mfd/rohm-bd71828.c                         |   4 +-
>  drivers/mfd/rohm-bd718x7.c                         |   2 +-
>  drivers/mfd/rohm-bd9576.c                          |   2 +-
>  drivers/mfd/rsmu_i2c.c                             |   2 +-
>  drivers/mfd/si476x-prop.c                          |   2 +-
>  drivers/mfd/stmfx.c                                |   2 +-
>  drivers/mfd/stpmic1.c                              |   2 +-
>  drivers/mfd/syscon.c                               |   4 +-
>  drivers/mfd/twl-core.c                             |  28 +++
>  drivers/mfd/twl4030-power.c                        |   3 +
>  drivers/mfd/wm5102-tables.c                        |   2 +-
>  drivers/mfd/wm5110-tables.c                        |   2 +-
>  drivers/mfd/wm831x-auxadc.c                        |  43 ++--
>  drivers/mfd/wm8350-regmap.c                        |   2 +-
>  drivers/mfd/wm8400-core.c                          |   2 +-
>  drivers/mfd/wm97xx-core.c                          |   6 +-
>  drivers/spi/spi-cs42l43.c                          |   2 +
>  drivers/watchdog/Kconfig                           |  11 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/cros_ec_wdt.c                     | 204 +++++++++++++++++
>  include/linux/mfd/cs42l43.h                        |  13 +-
>  include/linux/mfd/sun4i-gpadc.h                    |   4 +-
>  include/linux/mfd/syscon.h                         |  25 +-
>  include/linux/mfd/twl.h                            |   1 +
>  include/linux/platform_data/cros_ec_commands.h     |  78 +++----
>  76 files changed, 1045 insertions(+), 634 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
>  delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
>  create mode 100644 drivers/watchdog/cros_ec_wdt.c
> 
> -- 
> Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]

