Return-Path: <linux-kernel+bounces-100371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172087966B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B81282CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC057B3E7;
	Tue, 12 Mar 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhRLtYZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08F1E876;
	Tue, 12 Mar 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253988; cv=none; b=GlYgtTkdcXHUPR6ySUceMmc79B27t4uXce0dTheVdkqnhOmVueSqTQM/pWwqHKpzDZ3LOO3FbgRokY0il8vVa2cF10Tr1EaMiTb7hX4fqZT20erlYMBbc9tN+KeBVp19ZYN11yDbQGFGw1ceqCmk2HQCe6XSP0ZZiSovrWwLPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253988; c=relaxed/simple;
	bh=IBsQDM1LzXQ9bzAmJnrj1r1z5DtBA8DHkjcXLUs7F4M=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XUiHit/dlttglZOf07W2smYlnkUIDQqTGO4ZMo3b0TvgwDDn3YzWq1wNpPfs6Mq4n65hsGPDhc3apfoqy1zSzKCK89lFVHOq6d3QfSPYyRs47Y1u1Bjd3+REVevNEaSrt7f1RpVSXdhqVQTN7X0kQNCPqJPZXUPRnpLLcBKITQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhRLtYZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6553EC433F1;
	Tue, 12 Mar 2024 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253987;
	bh=IBsQDM1LzXQ9bzAmJnrj1r1z5DtBA8DHkjcXLUs7F4M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NhRLtYZw7uONAHRfiWK/fnOjBeXaB4mdecnEUKZVHd2XltjPSFGFCS4ChxhEHpfEb
	 rl32RngKRmhFD3dTfbFoqYcq9/u85OfLSkBOaRCegcD6SqyhkrKAFCQ4bBuPZVSKD6
	 p+48NhhWs0NPEV29tBfYNvJTuPTa8Q9kh75Mp1DxJu4GW4g4UOoyx8aq22sAiFE1uS
	 0nACuvMGddDi3V8PZg7TeK59bEgaZAQn5Ggz91gZojL9zh3DEhpsZHDFI6tfPOb719
	 gmHwXUCGyZD8tK8LldFlcExHRfg7r8tKiFC6pfqZ60DyDo0XFessgBNs5dK46qqpq6
	 YyQnYUzJHD5hQ==
Date: Tue, 12 Mar 2024 08:33:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patrick@stwcx.xyz, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Message-Id: <171025376449.2190602.9706298044805249290.robh@kernel.org>
Subject: Re: [PATCH v6 00/22] Add i2c-mux and eeprom devices for Meta
 Yosemite 4


On Tue, 12 Mar 2024 14:15:32 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v6
>     - Revise i2c duty-cycle for meeting 400khz spec
>   - v5
>     - Support medusa board adc sensors
>     - support NIC eeprom
>   - v4
>     - Re-format gpio linename
>     - Revise i2c device node names
>     - Split patches by logic changes
>   - v3
>     - Correct patch for revising gpio name
>   - v2
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
>   - v1
>     - Add gpio and eeprom behind i2c-mux
>     - Remove redundant idle-state setting for i2c-mux
>     - Enable adc 15, wdt2,spi gpio for yosemite4 use
>     - Revise quad mode to dual mode to avoid WP pin influnece the SPI
>     - Revise power sensor adm1281 for yosemite4 schematic change
>     - Add gpio pca9506 I/O expander for yosemite4 use
>     - remove space for adm1272 compatible
>     - enable interrupt setting for pca9555
>     - add eeprom for yosemite4 medusa board/BSM use
>     - remove temperature sensor for yosemite4 schematic change
>     - add power sensor for power module reading
>     - Revise adc128d818 adc mode for yosemite4 schematic change
>     - Revise ina233 for yosemite4 schematic change
>     - Remove idle state setting for yosemite4 NIC connection
>     - Initialize bmc gpio state
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
> 
> Delphine CC Chiu (22):
>   ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
>   ARM: dts: aspeed: yosemite4: Enable adc15
>   ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
>   ARM: dts: aspeed: yosemite4: Enable watchdog2
>   ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
>   ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
>     change
>   ARM: dts: aspeed: yosemite4: Add gpio pca9506
>   ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
>   ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
>   ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
>   ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
>   ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4
>     schematic change
>   ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4
>     schematic change
>   ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4
>     schematic change
>   ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4
>     NIC connection
>   ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
>   ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
>   ARM: dts: aspeed: yosemite4: add mctp config for NIC
>   ARM: dts: aspeed: yosemite4: support mux to cpld
>   ARM: dts: aspeed: yosemite4: support medusa board adc sensors
>   ARM: dts: aspeed: yosemite4: support NIC eeprom
>   ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
> 
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1258 +++++++++++++++--
>  1 file changed, 1151 insertions(+), 107 deletions(-)
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:550.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:576.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:601.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:626.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:661.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:686.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:711.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:736.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:773.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@580/i2c-mux@74/i2c@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:821.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@580/i2c-mux@74/i2c@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:980.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1006.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1012.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1018.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1324.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1345.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1366.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1387.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:547.17-571.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:547.17-571.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:573.17-596.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:573.17-596.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:598.17-621.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:598.17-621.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:623.17-646.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:623.17-646.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@480/i2c-mux@70/i2c@3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:658.17-681.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:658.17-681.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:683.17-706.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:683.17-706.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:708.17-731.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:708.17-731.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:733.17-757.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:733.17-757.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@500/i2c-mux@71/i2c@3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:770.17-816.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@580/i2c-mux@74/i2c@0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:770.17-816.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@580/i2c-mux@74/i2c@0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:818.17-822.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@580/i2c-mux@74/i2c@1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:818.17-822.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@580/i2c-mux@74/i2c@1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:977.17-1001.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:977.17-1001.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1003.17-1007.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1003.17-1007.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1009.17-1013.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1009.17-1013.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1015.17-1019.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1015.17-1019.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@680/i2c-mux@70/i2c@3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1321.17-1340.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1321.17-1340.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1342.17-1361.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1342.17-1361.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1363.17-1382.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1363.17-1382.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1384.17-1403.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1384.17-1403.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c-bus@800/i2c-mux@72/i2c@3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1553.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_b4:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1552.14-1555.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_b4: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/usb2bd_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1557.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_b5:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1556.14-1559.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_b5: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/interrupt-controller@560 or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1561.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f0:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1560.14-1563.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f0: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/txd1_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1565.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f1:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1564.14-1567.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f1: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/rxd1_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1569.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f2:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1568.14-1571.5: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f2: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/wdtrst1_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1573.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f3:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1572.14-1575.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f3: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/wdtrst2_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1577.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f4:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1576.14-1579.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f4: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/emmc_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1581.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f5:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1580.14-1583.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f5: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/txd2_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1585.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f6:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1584.14-1587.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f6: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/rxd2_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1589.3-29: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f7:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1588.14-1591.4: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_f7: Missing property '#gpio-cells' in node /ahb/apb/syscon@1e6e2000/pinctrl/txd3_default or bad phandle (referred from gpios[0])
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1593.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_l6:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1593.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_l6:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1597.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_l7:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1597.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_l7:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1601.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_s0:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1601.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_s0:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1605.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_s1:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1605.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_s1:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1609.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v0:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1609.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v0:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1613.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v1:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1613.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v1:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1617.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v2:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1617.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v2:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1621.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v3:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1621.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_v3:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1625.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w0:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1625.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w0:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1629.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w1:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1629.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w1:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1633.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w2:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1633.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w2:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1637.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w3:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1637.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w3:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1641.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w4:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1641.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w4:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1645.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w5:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1645.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w5:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1649.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w6:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1649.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w6:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1653.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w7:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1653.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_w7:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1657.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_z3:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1657.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_z3:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1661.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_z4:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1661.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_z4:gpios: Could not get phandle node for (cell 0)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1665.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_z5:gpios: cell 0 is not a phandle reference
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1665.3-30: Warning (gpios_property): /ahb/apb/gpio@1e780000/pin_gpio_z5:gpios: Could not get phandle node for (cell 0)
Traceback (most recent call last):
  File "/home/rob/.local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/home/rob/proj/dt-schema/dtschema/dtb_validate.py", line 144, in main
    sg.check_dtb(filename)
  File "/home/rob/proj/dt-schema/dtschema/dtb_validate.py", line 87, in check_dtb
    dt = self.validator.decode_dtb(f.read())
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/rob/proj/dt-schema/dtschema/validator.py", line 518, in decode_dtb
    return [dtschema.dtb.fdt_unflatten(self, dtb)]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/rob/proj/dt-schema/dtschema/dtb.py", line 492, in fdt_unflatten
    fixup_gpios(dt)
  File "/home/rob/proj/dt-schema/dtschema/dtb.py", line 381, in fixup_gpios
    fixup_gpios(v)
  File "/home/rob/proj/dt-schema/dtschema/dtb.py", line 381, in fixup_gpios
    fixup_gpios(v)
  File "/home/rob/proj/dt-schema/dtschema/dtb.py", line 381, in fixup_gpios
    fixup_gpios(v)
  [Previous line repeated 1 more time]
  File "/home/rob/proj/dt-schema/dtschema/dtb.py", line 402, in fixup_gpios
    node = phandles[phandle]
           ~~~~~~~~^^^^^^^^^
KeyError: 94






