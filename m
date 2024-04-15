Return-Path: <linux-kernel+bounces-145735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F48A5A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253C0B2123A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88A15666F;
	Mon, 15 Apr 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVVe6C0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E91553A7;
	Mon, 15 Apr 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206858; cv=none; b=PD2XWsCIxRdYxqSx3VhKhshp0ls0L8O3v0kjumXfwRbrZiiuNmAF13lBNAJrL0FumAQlvFipKqZSrWGaQVL0ULkvDBB9/TFTIrvybdx/IHRjzQXafZi7G1v73cuStxUf8ZIaktDCMYTP1DaUDvd94VLQGBM1OVDu2GMnmNbskW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206858; c=relaxed/simple;
	bh=2OGJ9ttvYvJtrtHTPN9UHZlm1FINmbiG6UwTRsEKCwY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=h903Ug9tXns8gjQMCOzro51k2VSjQZ0hUBCRjYxrmdT6G40YQnWrz2Lp4s+uh/6LE5FLxlDbEpgpgLksbcYLr4ztq3M8f4VBwsXzPCWAAdJMpXu8zEQNEi351XVD9Tr2qNiQptYpGyE4eauBdPou3t1Pc85kuSrll1R7RvSyQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVVe6C0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACC0C113CC;
	Mon, 15 Apr 2024 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206858;
	bh=2OGJ9ttvYvJtrtHTPN9UHZlm1FINmbiG6UwTRsEKCwY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TVVe6C0TZfGjrqFc49A5vdHYU/TB9a3PMk2qLa/pdg6RHdkCNSEIPe7T3BWSBFJsZ
	 3PUalLE6BXc9YrCjjSs6mXAl9NdLpSuXme1Xil5s14EpxBWTRdnRQhMsIXPD24J3oD
	 RmCH7xlbZKRaKdIe4GTUkbnybbFuTjZbbFPPAEuXnOEO0BYStsasSAcUW6DgP6Ve5s
	 RJhySHpfXnjObY/CBZ1wZNlOD79jeFQ0pCpNHS57DhNjpOljzSf/AHTPiJ3itTQ8id
	 SvXnVh47+iEmslJ+a/t6LBKFcSHi1gInQF5+JPR51EtXWmqBhSAaYgtTwKfZkImDpI
	 5JO45vJj4wBkg==
Date: Mon, 15 Apr 2024 13:47:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
 Phil Elwell <phil@raspberrypi.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Jonathan Bell <jonathan@raspberrypi.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1713036964.git.andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
Message-Id: <171320635602.5208.10027482544965026256.robh@kernel.org>
Subject: Re: [PATCH 0/6] Add support for BCM2712 SD card controller


On Sun, 14 Apr 2024 00:14:22 +0200, Andrea della Porta wrote:
> Hi,
> 
> This patchset adds support for the SDHCI controller on Broadcom BCM2712
> SoC in order to make it possible to boot (particularly) Raspberry Pi 5
> from SD card. This work is heavily based on downstream contributions.
> 
> Patch #1 and 2: introduce the dt binding definitions for, respectively,
> the new pin cfg/mux controller and the SD host controller as a preparatory
> step for the upcoming dts.
> 
> Patch #3: add a somewhat reasonable (*almost* bare-minimum) dts to be used
> to boot Rpi5 boards. Since till now there was no support at all for any
> 2712 based chipset, both the SoC and board dts plus definitions for the
> new Pin and SD host controller have been added.
> 
> Patch #4: the driver supporting the pin controller. Based on [1] and
> successive fix commits.
> 
> Patch #5: add SDHCI support. Based on [2] and the next 2 fix commits.
> Drop the SD Express implementation for now, that will be added by patch
> #6.
> 
> Patch #6: this patch offers SD Express support and can be considered totally
> optional. The callback plumbing is slightly different w.r.t. the downstream
> approach (see [3]), as explained in the patch comment. Not sure what is the best,
> any comment is highly appreciated.
> 
> Tested succesfully on Raspberry Pi 5 using an SDxC card as the boot device.
> 
> Still untested:
> - SD Express due to the lack of an Express capable card.
>   Also, it will need PCIe support first.
> - card detection pin, since the sd was the booting and root fs device.
> 
> Many thanks,
> Andrea
> 
> Links:
> [1] - https://github.com/raspberrypi/linux/commit/d9b655314a826724538867bf9b6c229d04c25d84
> [2] - https://github.com/raspberrypi/linux/commit/e3aa070496e840e72a4dc384718690ea4125fa6a
> [3] - https://github.com/raspberrypi/linux/commit/eb1df34db2a9a5b752eba40ee298c4ae87e26e87
> 
> Andrea della Porta (6):
>   dt-bindings: pinctrl: Add support for BCM2712 pin controller
>   dt-bindings: mmc: Add support for BCM2712 SD host controller
>   arm64: dts: broadcom: Add support for BCM2712
>   pinctrl: bcm: Add pinconf/pinmux controller driver for BCM2712
>   mmc: sdhci-brcmstb: Add BCM2712 support
>   mmc: sdhci-brcmstb: Add BCM2712 SD Express support
> 
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   51 +-
>  .../pinctrl/brcm,bcm2712-pinctrl.yaml         |   99 ++
>  arch/arm64/boot/dts/broadcom/Makefile         |    1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  313 +++++
>  arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |   81 ++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  841 +++++++++++
>  drivers/mmc/host/Kconfig                      |    1 +
>  drivers/mmc/host/sdhci-brcmstb.c              |  275 ++++
>  drivers/pinctrl/bcm/Kconfig                   |    9 +
>  drivers/pinctrl/bcm/Makefile                  |    1 +
>  drivers/pinctrl/bcm/pinctrl-bcm2712.c         | 1247 +++++++++++++++++
>  11 files changed, 2918 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
>  create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c
> 
> --
> 2.35.3
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for cover.1713036964.git.andrea.porta@suse.com:

arch/arm64/boot/dts/broadcom/bcm2712.dtsi:554.26-565.5: Warning (interrupt_provider): /soc/gpio@7d517c00: '#interrupt-cells' found, but node is not an interrupt provider
  also defined at arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts:201.10-206.3
  also defined at arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts:259.10-288.3
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /: failed to match any schema with compatible: ['raspberrypi,5-model-b', 'brcm,bcm2712']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /: failed to match any schema with compatible: ['raspberrypi,5-model-b', 'brcm,bcm2712']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: thermal-zones: cpu-thermal:trips:phandle: [[43]] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: soc: firmware: {'compatible': ['raspberrypi,bcm2835-firmware', 'simple-mfd'], '#address-cells': [[1]], '#size-cells': [[1]], 'mboxes': [[15]], 'dma-ranges': True, 'phandle': [[16]], 'clocks': {'compatible': ['raspberrypi,firmware-clocks'], '#clock-cells': [[1]], 'phandle': [[95]]}, 'reset': {'compatible': ['raspberrypi,firmware-reset'], '#reset-cells': [[1]], 'phandle': [[96]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: soc: power: {'compatible': ['raspberrypi,bcm2835-power'], 'firmware': [[16]], '#power-domain-cells': [[1]], 'phandle': [[97]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: soc: fixedregulator_3v3: {'compatible': ['regulator-fixed'], 'regulator-always-on': True, 'regulator-max-microvolt': [[3300000]], 'regulator-min-microvolt': [[3300000]], 'regulator-name': ['3v3'], 'phandle': [[98]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: soc: fixedregulator_5v0: {'compatible': ['regulator-fixed'], 'regulator-always-on': True, 'regulator-max-microvolt': [[5000000]], 'regulator-min-microvolt': [[5000000]], 'regulator-name': ['5v0'], 'phandle': [[99]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/timer@7c003000: failed to match any schema with compatible: ['brcm,bcm2835-system-timer']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/local_intc@7cd00000: failed to match any schema with compatible: ['brcm,bcm2836-l1-intc']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/i2s@7d003000: failed to match any schema with compatible: ['brcm,bcm2835-i2s']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/spi@7d004000: failed to match any schema with compatible: ['brcm,bcm2835-spi']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/spi@7d004000/spidev@0: failed to match any schema with compatible: ['spidev']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/spi@7d004600: failed to match any schema with compatible: ['brcm,bcm2835-spi']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/spi@7d004800: failed to match any schema with compatible: ['brcm,bcm2835-spi']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/spi@7d004a00: failed to match any schema with compatible: ['brcm,bcm2835-spi']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/spi@7d004c00: failed to match any schema with compatible: ['brcm,bcm2835-spi']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pwm@7d00c000: 'assigned-clocks' is a dependency of 'assigned-clock-rates'
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pwm@7d00c800: 'assigned-clocks' is a dependency of 'assigned-clock-rates'
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/cprman@7d202000: failed to match any schema with compatible: ['brcm,bcm2711-cprman']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: intc@7d503000: $nodename:0: 'intc@7d503000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: intc@7d508380: $nodename:0: 'intc@7d508380' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: intc@7d508400: $nodename:0: 'intc@7d508400' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: gpio@7d508500: compatible:0: 'brcm,brcmstb-gpio' is not one of ['brcm,bcm7445-gpio']
	from schema $id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: gpio@7d508500: compatible: ['brcm,brcmstb-gpio'] is too short
	from schema $id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: gpio@7d508500: 'brcm,gpio-direct', 'gpio-line-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: intc@7d517000: $nodename:0: 'intc@7d517000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pwm@7d517a80: #pwm-cells:0:0: 2 was expected
	from schema $id: http://devicetree.org/schemas/pwm/brcm,bcm7038-pwm.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: intc@7d517ac0: $nodename:0: 'intc@7d517ac0' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: intc@7d517b00: $nodename:0: 'intc@7d517b00' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: gpio@7d517c00: compatible:0: 'brcm,brcmstb-gpio' is not one of ['brcm,bcm7445-gpio']
	from schema $id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: gpio@7d517c00: compatible: ['brcm,brcmstb-gpio'] is too short
	from schema $id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: gpio@7d517c00: 'brcm,gpio-direct', 'gpio-line-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/avs-monitor@7d542000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: firmware: '#address-cells', '#size-cells', 'dma-ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835-firmware.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc/power: failed to match any schema with compatible: ['raspberrypi,bcm2835-power']
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: l3-cache: 'cache-unified' is a dependency of 'cache-size'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: l3-cache: 'cache-unified' is a dependency of 'cache-sets'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: l3-cache: 'cache-unified' is a dependency of 'cache-line-size'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: l3-cache: 'cache-unified' is a required property
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: l3-cache: Unevaluated properties are not allowed ('cache-level', 'cache-line-size', 'cache-sets', 'cache-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pwr_button: 'pwr' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#






