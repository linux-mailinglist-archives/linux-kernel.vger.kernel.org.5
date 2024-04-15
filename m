Return-Path: <linux-kernel+bounces-145732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA268A5A24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C57B20CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3F1E877;
	Mon, 15 Apr 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj7JSlbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03A1553A7;
	Mon, 15 Apr 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206846; cv=none; b=ZXrNgiY/kqu8VZTpmbovZlzxkvSlCi75c0vEYU71cQfmYDT5oP6XUaSVzQhpUFVLjqxA41i0AEvN4IgtCeUs5qcnuwrtW3LdOy7LuMRqnEOKLsVvDRqXcTz+igZ3rQr9USN/fSqlwy0A+fYslslVdqI2pmshYSectx2WPfto7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206846; c=relaxed/simple;
	bh=1cDDTFqVO9nquehVWNTpewzhN63ezqll9brEgIANQ+o=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PhxHaq6S3BtH8LMwt1t0YkK+qNftn3PZG2AtgwZioSpAikB7OgbNDkH6dpFFBjJSS6gIQ9QU671etxUWQpWeuBlkjhwcLejzwaLj8FHgCWKnpI5c7B22C3/4nBmDz/lpC2PJQo9NFW5KBYQK7GZepycJIxsvXbzP7LZ8yuBcJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj7JSlbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B021C2BD11;
	Mon, 15 Apr 2024 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206845;
	bh=1cDDTFqVO9nquehVWNTpewzhN63ezqll9brEgIANQ+o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Lj7JSlbq8tQUEvCLNO5MvPN6OrymXUFXiFF6MNMBBs31Pu16ElNBQM/B9r/NUkYNQ
	 XjvmzO1MlWBSrdT4JYHxqQWmdsmVbSz2ci/K29zM+RNZd0/6Ym4muO3eBBqmX3PVcK
	 XKTY8xIclw2Ll7yx1YF++ET395PrQBGJTMA8aQcc6ES4EKNHD0tG8t7lgOOd0yzIqR
	 AzbsCZLTFZG/scPQh8voF3DSCoLsPkbGttBJDRqP98mQylnvFzE+2WPFRlL9OYlpXK
	 n86TwiTWle97HTlt7PYRswp8WM595u5W41+5GdDDQ85KWwUqsyepQTBUwlF+ZP18xh
	 MeeVghXr+TuJg==
Date: Mon, 15 Apr 2024 13:47:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>
In-Reply-To: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
Message-Id: <171320634978.5004.9481512846141703607.robh@kernel.org>
Subject: Re: [PATCH v3 0/4] arm64: dts: add description for solidrun cn9130
 som and clearfog boards


On Sun, 14 Apr 2024 14:58:31 +0200, Josua Mayer wrote:
> SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
> SoM used in Clearfog and Clearfog Pro boards.
> 
> 1. Add new binding for compatible strings closely matching the original.
> 
> 2. Add device-tree includes for SoM and carrier shared design.
> 
> 3. Add device-tree for both Clearfog Base and Pro.
> 
> While dtbs_check is happy with LED descriptions behind dsa switch,
> functionally they require supporting code by Andrew Lunn:
> https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch
> 
> NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
> CN9130 SoM has a different footprint from Armada 388 SoM.
> Components on the carrier board below the SoM may collide causing
> damage, such as on Clearfog Base.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - picked up acked-by for dt-bindings
> - skipped acked-by for dts because additional changes were made:
>   - moved legacy netdev aliases to carrier dts
>   - fix status property style errors
>   - add pinctrl for secondary spi chip-select on mikrobus header (& som)
>   - specify spi bus frequency limits for som
> - Added CN9131 SolidWAN board
> - Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com
> 
> Changes in v2:
> - rewrote dt bindings dropping unnecessary compatibles
>   (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
> - added bindings for two additional boards (cn9131/9132)
>   support planned for the coming weeks, mostly serves
>   illustrational purposes, to understand cn913x variants
> - cf-pro: add description for LEDs behind DSA switch
> - cf-base: add description for LEDs behind PHYs
>   (Reported-By: Andrew Lunn <andrew@lunn.ch>)
> - Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com
> 
> ---
> Josua Mayer (4):
>       dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
>       dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
>       arm64: dts: add description for solidrun cn9130 som and clearfog boards
>       arm64: dts: add description for solidrun cn9131 solidwan board
> 
>  .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
>  arch/arm64/boot/dts/marvell/Makefile               |   3 +
>  arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
>  arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 377 ++++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 +++++++
>  arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
>  arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 653 +++++++++++++++++++++
>  7 files changed, 1586 insertions(+)
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240318-cn9130-som-848e86acb0ac
> 
> Sincerely,
> --
> Josua Mayer <josua@solid-run.com>
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


New warnings running 'make CHECK_DTBS=y marvell/cn9130-cf-base.dtb marvell/cn9130-cf-pro.dtb marvell/cn9131-cf-solidwan.dtb' for 20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com:

arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: ap807: $nodename:0: 'ap807' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: config-space@f0000000: $nodename:0: 'config-space@f0000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: config-space@f0000000: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 13, 3848], [1, 14, 3848], [1, 11, 3848], [1, 10, 3848]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: config-space@f0000000: pmu: {'compatible': ['arm,cortex-a72-pmu'], 'interrupt-parent': [[2]], 'interrupts': [[17]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/odmi@300000: failed to match any schema with compatible: ['marvell,odmi-controller']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/gicp@3f0040: failed to match any schema with compatible: ['marvell,ap806-gicp']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/interrupt-controller@3f0100: failed to match any schema with compatible: ['marvell,armada-8k-pic']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/interrupt-controller@3f0200: failed to match any schema with compatible: ['marvell,ap806-sei']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@400000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@400000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@420000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@420000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@440000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@440000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@460000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/xor@460000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/spi@510600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: mmc@6e0000: clocks: [[4, 4]] is too short
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: mmc@6e0000: clock-names: ['core'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: mmc@6e0000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: system-controller@6f4000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/system-controller@6f4000/pinctrl: failed to match any schema with compatible: ['marvell,ap806-pinctrl']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: gpio@1040: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/system-controller@6f4000/clock: failed to match any schema with compatible: ['marvell,ap807-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: system-controller@6f8000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: ap807: $nodename:0: 'ap807' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: config-space@f0000000: $nodename:0: 'config-space@f0000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: config-space@f0000000: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 13, 3848], [1, 14, 3848], [1, 11, 3848], [1, 10, 3848]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: config-space@f0000000: pmu: {'compatible': ['arm,cortex-a72-pmu'], 'interrupt-parent': [[2]], 'interrupts': [[17]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/system-controller@6f8000/thermal-sensor@80: failed to match any schema with compatible: ['marvell,armada-ap807-thermal']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /ap807/config-space@f0000000/system-controller@6f8000/clock-cpu: failed to match any schema with compatible: ['marvell,ap807-cpu-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/odmi@300000: failed to match any schema with compatible: ['marvell,odmi-controller']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/gicp@3f0040: failed to match any schema with compatible: ['marvell,ap806-gicp']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/interrupt-controller@3f0100: failed to match any schema with compatible: ['marvell,armada-8k-pic']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/interrupt-controller@3f0200: failed to match any schema with compatible: ['marvell,ap806-sei']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@400000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@400000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@420000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@420000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@440000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@440000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@460000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/xor@460000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/spi@510600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: mmc@6e0000: clocks: [[4, 4]] is too short
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: mmc@6e0000: clock-names: ['core'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: mmc@6e0000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: system-controller@6f4000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/system-controller@6f4000/pinctrl: failed to match any schema with compatible: ['marvell,ap806-pinctrl']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: gpio@1040: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/system-controller@6f4000/clock: failed to match any schema with compatible: ['marvell,ap807-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: system-controller@6f8000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/system-controller@6f8000/thermal-sensor@80: failed to match any schema with compatible: ['marvell,armada-ap807-thermal']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: cp0: $nodename:0: 'cp0' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /ap807/config-space@f0000000/system-controller@6f8000/clock-cpu: failed to match any schema with compatible: ['marvell,ap807-cpu-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: config-space@f2000000: $nodename:0: 'config-space@f2000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/phy@120000: failed to match any schema with compatible: ['marvell,comphy-cp110']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: ap807: $nodename:0: 'ap807' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: config-space@f0000000: $nodename:0: 'config-space@f0000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: config-space@f0000000: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 13, 3848], [1, 14, 3848], [1, 11, 3848], [1, 10, 3848]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: config-space@f0000000: pmu: {'compatible': ['arm,cortex-a72-pmu'], 'interrupt-parent': [[2]], 'interrupts': [[17]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000: failed to match any schema with compatible: ['marvell,cp110-icu']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000/interrupt-controller@10: failed to match any schema with compatible: ['marvell,cp110-icu-nsr']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000/interrupt-controller@50: failed to match any schema with compatible: ['marvell,cp110-icu-sei']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: system-controller@440000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/system-controller@440000/clock: failed to match any schema with compatible: ['marvell,cp110-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: gpio@100: Unevaluated properties are not allowed ('gpio-ranges', 'sim-select-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: gpio@140: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: cp0: $nodename:0: 'cp0' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: config-space@f2000000: $nodename:0: 'config-space@f2000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/system-controller@440000/pinctrl: failed to match any schema with compatible: ['marvell,cp115-standalone-pinctrl']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: system-controller@400000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/phy@120000: failed to match any schema with compatible: ['marvell,comphy-cp110']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/system-controller@400000/thermal-sensor@70: failed to match any schema with compatible: ['marvell,armada-cp110-thermal']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: usb@500000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode', 'vbus-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: usb@510000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: sata@540000: sata-port@1: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/odmi@300000: failed to match any schema with compatible: ['marvell,odmi-controller']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/spi@700600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/gicp@3f0040: failed to match any schema with compatible: ['marvell,ap806-gicp']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/interrupt-controller@3f0100: failed to match any schema with compatible: ['marvell,armada-8k-pic']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/interrupt-controller@3f0200: failed to match any schema with compatible: ['marvell,ap806-sei']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@400000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@400000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@420000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@420000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/trng@760000: failed to match any schema with compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: mmc@780000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: crypto@800000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@440000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000: failed to match any schema with compatible: ['marvell,cp110-icu']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@440000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000/interrupt-controller@10: failed to match any schema with compatible: ['marvell,cp110-icu-nsr']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/pcie@f2600000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000/interrupt-controller@50: failed to match any schema with compatible: ['marvell,cp110-icu-sei']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: system-controller@440000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@460000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/pcie@f2620000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/xor@460000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/system-controller@440000/clock: failed to match any schema with compatible: ['marvell,cp110-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: gpio@100: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/pcie@f2640000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: gpio@140: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/spi@510600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/system-controller@440000/pinctrl: failed to match any schema with compatible: ['marvell,cp115-standalone-pinctrl']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: system-controller@400000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/system-controller@400000/thermal-sensor@70: failed to match any schema with compatible: ['marvell,armada-cp110-thermal']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: mmc@6e0000: clocks: [[4, 4]] is too short
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: mmc@6e0000: clock-names: ['core'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: mmc@6e0000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: usb@500000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode', 'vbus-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: usb@510000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: sata@540000: sata-port@1: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: system-controller@6f4000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/spi@700600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/system-controller@6f4000/pinctrl: failed to match any schema with compatible: ['marvell,ap806-pinctrl']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@1040: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/system-controller@6f4000/clock: failed to match any schema with compatible: ['marvell,ap807-clock']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: system-controller@6f8000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/system-controller@6f8000/thermal-sensor@80: failed to match any schema with compatible: ['marvell,armada-ap807-thermal']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /ap807/config-space@f0000000/system-controller@6f8000/clock-cpu: failed to match any schema with compatible: ['marvell,ap807-cpu-clock']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/trng@760000: failed to match any schema with compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: mmc@780000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: crypto@800000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/pcie@f2600000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/pcie@f2620000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/pcie@f2640000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: cp0: $nodename:0: 'cp0' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: config-space@f2000000: $nodename:0: 'config-space@f2000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/phy@120000: failed to match any schema with compatible: ['marvell,comphy-cp110']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000: failed to match any schema with compatible: ['marvell,cp110-icu']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000/interrupt-controller@10: failed to match any schema with compatible: ['marvell,cp110-icu-nsr']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/interrupt-controller@1e0000/interrupt-controller@50: failed to match any schema with compatible: ['marvell,cp110-icu-sei']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: system-controller@440000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/system-controller@440000/clock: failed to match any schema with compatible: ['marvell,cp110-clock']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@100: Unevaluated properties are not allowed ('gpio-ranges', 'm2-full-card-power-off-hog', 'pcie0-0-w-disable-hog' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@140: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/system-controller@440000/pinctrl: failed to match any schema with compatible: ['marvell,cp115-standalone-pinctrl']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: system-controller@400000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/system-controller@400000/thermal-sensor@70: failed to match any schema with compatible: ['marvell,armada-cp110-thermal']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: usb@500000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: usb@510000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/spi@700600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@41: 'gpio-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@41: '#gpio-cells' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: rtc@68: Unevaluated properties are not allowed ('reset-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/rtc/st,m41t80.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/trng@760000: failed to match any schema with compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: mmc@780000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: crypto@800000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/pcie@f2600000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/pcie@f2620000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/pcie@f2640000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: cp1: $nodename:0: 'cp1' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: config-space@f4000000: $nodename:0: 'config-space@f4000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/phy@120000: failed to match any schema with compatible: ['marvell,comphy-cp110']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/interrupt-controller@1e0000: failed to match any schema with compatible: ['marvell,cp110-icu']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/interrupt-controller@1e0000/interrupt-controller@10: failed to match any schema with compatible: ['marvell,cp110-icu-nsr']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/interrupt-controller@1e0000/interrupt-controller@50: failed to match any schema with compatible: ['marvell,cp110-icu-sei']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: system-controller@440000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/system-controller@440000/clock: failed to match any schema with compatible: ['marvell,cp110-clock']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@100: Unevaluated properties are not allowed ('gpio-ranges', 'm2-full-card-power-off-hog-0', 'm2-full-card-power-off-hog-1' were unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: gpio@140: Unevaluated properties are not allowed ('gpio-ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/system-controller@440000/pinctrl: failed to match any schema with compatible: ['marvell,cp115-standalone-pinctrl']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: system-controller@400000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/system-controller@400000/thermal-sensor@70: failed to match any schema with compatible: ['marvell,armada-cp110-thermal']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: usb@500000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: usb@510000: Unevaluated properties are not allowed ('dma-coherent', 'dr_mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: sata@540000: sata-port@0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/spi@700600: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/trng@760000: failed to match any schema with compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: crypto@800000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/pcie@f4600000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/pcie@f4620000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/pcie@f4640000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: sfp-0: 'los-gpio', 'mod-def0-gpio', 'tx-disable-gpio', 'tx-fault-gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/sff,sfp.yaml#
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: sfp-1: 'los-gpio', 'mod-def0-gpio', 'tx-disable-gpio', 'tx-fault-gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/sff,sfp.yaml#






