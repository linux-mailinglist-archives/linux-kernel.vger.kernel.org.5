Return-Path: <linux-kernel+bounces-81985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFF867D67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C53B30E69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BEB1386DB;
	Mon, 26 Feb 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVn534Lo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5F12EBC7;
	Mon, 26 Feb 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966472; cv=none; b=MNKIarIx4wm72zMfM50+YfwYH8dEPGoBHLR/vMP3tBZaNFFXG4gYJIV+HvamDq3rtbANtxxJwmA2uEIzYQGVTuKtE39Gf0cS4mpTJaMPhLw8nfIknmpEKndAJGroP8pAsirbutJxsOR1Z3sPzYFBSjCkLuUah2TxogeNITy5YEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966472; c=relaxed/simple;
	bh=qYqxJURYXZUqzQwk9pRqWA9tac7WSFwM5rjwchAlnrI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kG3x0zn/RciEwILQ/nGWIkmsrW3uzxbSD+sVHEpWrgnuNLKJxN+fi12rxA5/5h5m5/XY9+IJleKPx9Zd1x509FeforlAbLU2072cNrLXGfJedQlhYizL7vNj055BNSOUNQP7momy2w34F8UKUOaqBq7APH4zpJJDnnOEnPsvo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVn534Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C4FC433B1;
	Mon, 26 Feb 2024 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966470;
	bh=qYqxJURYXZUqzQwk9pRqWA9tac7WSFwM5rjwchAlnrI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lVn534LoNsdWWgrLc+1zqXNuvTP7fnCXZBfuPm1LMS1oz3CDrv/EE/eM7UAXa2xKG
	 ADMaTNfhQ9+lu5AFwMyskKvNzeHohuRooYjncolZj6R+FuK60e9w/GIRXplMoivrXe
	 AkVfqiQP0koDUOkfzB9UBOj/HabkdNxcIHWiIyGBtess2b6MWiERvpK/FZuxQeLVw0
	 JAsCoPAnD9YgmzNeM59DDQuykSgwDSM90txX8F7ljQ9MU0SXAc7M51POAKdpqLVgDp
	 xkFCHRE0eGNjYmD6+8gg+jb/S+1Bx2E2mfBK0DPBujhcrQ6KkGR6giH8cxsumI7PUY
	 0Hku4fe+zkrMg==
Date: Mon, 26 Feb 2024 10:54:29 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: gregory.clement@bootlin.com, andrew@lunn.ch, lee@kernel.org, 
 devicetree@vger.kernel.org, andy.shevchenko@gmail.com, 
 sebastian.hesselbarth@gmail.com, conor+dt@kernel.org, geert@linux-m68k.org, 
 linux-leds@vger.kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, pavel@ucw.cz, ojeda@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
Message-Id: <170896502255.859020.4639120006267962858.robh@kernel.org>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display


On Mon, 26 Feb 2024 10:34:20 +1300, Chris Packham wrote:
> This series adds a driver for a 7 segment LED display.
> 
> I'd like to get some feedback on how this could be extended to support >1
> character. The driver as presented is sufficient for my hardware which only has
> a single character display but I can see that for this to be generically useful
> supporting more characters would be desireable.
> 
> Earlier I posted an idea that the characters could be represended by
> sub-nodes[1] but there doesn't seem to be a way of having that and keeping the
> convenience of using devm_gpiod_get_array() (unless I've missed something).
> 
> [1] - https://lore.kernel.org/lkml/2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz/
> 
> Chris Packham (3):
>   auxdisplay: Add 7 segment LED display driver
>   dt-bindings: auxdisplay: Add bindings for generic 7 segment LED
>   ARM: dts: marvell: Add 7 segment LED display on x530
> 
>  .../auxdisplay/generic,gpio-7seg.yaml         |  40 +++++
>  .../boot/dts/marvell/armada-385-atl-x530.dts  |  13 +-
>  drivers/auxdisplay/Kconfig                    |   7 +
>  drivers/auxdisplay/Makefile                   |   1 +
>  drivers/auxdisplay/seg-led.c                  | 152 ++++++++++++++++++
>  5 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic,gpio-7seg.yaml
>  create mode 100644 drivers/auxdisplay/seg-led.c
> 
> --
> 2.43.2
> 
> 
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y marvell/armada-385-atl-x530.dtb' for 20240225213423.690561-1-chris.packham@alliedtelesis.co.nz:

arch/arm/boot/dts/marvell/armada-385-atl-x530.dtb: soc: internal-regs: {'compatible': ['simple-bus'], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 4026597376, 0, 1048576]], 'sdramc@1400': {'compatible': ['marvell,armada-xp-sdram-controller'], 'reg': [[5120, 1280]]}, 'cache-controller@8000': {'compatible': ['arm,pl310-cache'], 'reg': [[32768, 4096]], 'cache-unified': True, 'cache-level': [[2]], 'arm,double-linefill-incr': [[0]], 'arm,double-linefill-wrap': [[0]], 'arm,double-linefill': [[0]], 'prefetch-data': [[1]]}, 'scu@c000': {'compatible': ['arm,cortex-a9-scu'], 'reg': [[49152, 88]]}, 'timer@c200': {'compatible': ['arm,cortex-a9-global-timer'], 'reg': [[49664, 32]], 'interrupts': [[1, 11, 769]], 'clocks': [[4, 2]]}, 'timer@c600': {'compatible': ['arm,cortex-a9-twd-timer'], 'reg': [[50688, 32]], 'interrupts': [[1, 13, 769]], 'clocks': [[4, 2]]}, 'interrupt-controller@d000': {'compatible': ['arm,cortex-a9-gic'], '#interrupt-cells': [[3]], '#size-cells': [[0]], 'inte
 rrupt-controller': True, 'reg': [[53248, 4096], [49408, 256]], 'phandle': [[3]]}, 'i2c@11000': {'compatible': ['marvell,mv78230-a0-i2c', 'marvell,mv64xxx-i2c'], 'reg': [[69632, 32]], '#address-cells': [[1]], '#size-cells': [[0]], 'interrupts': [[0, 2, 4]], 'clocks': [[4, 0]], 'status': ['okay'], 'pinctrl-names': ['default', 'gpio'], 'pinctrl-0': [[5]], 'clock-frequency': [[100000]], 'pinctrl-1': [[6]], 'scl-gpio': [[7, 2, 6]], 'sda-gpio': [[7, 3, 6]], 'mux@71': {'#address-cells': [[1]], '#size-cells': [[0]], 'compatible': ['nxp,pca9544'], 'reg': [[113]], 'i2c-mux-idle-disconnect': True, 'i2c@0': {'#address-cells': [[1]], '#size-cells': [[0]], 'reg': [[0]]}, 'i2c@1': {'#address-cells': [[1]], '#size-cells': [[0]], 'reg': [[1]], 'hwmon@2e': {'compatible': ['adi,adt7476'], 'reg': [[46]]}, 'hwmon@2d': {'compatible': ['adi,adt7476'], 'reg': [[45]]}}, 'i2c@2': {'#address-cells': [[1]], '#size-cells': [[0]], 'reg': [[2]], 'rtc@68': {'compatible': ['dallas,ds1340'], 'reg': [[104]]}}, 'i2c@3
 ': {'#address-cells': [[1]], '#size-cells': [[0]], 'reg': [[3]], 'gpio@20': {'compatible': ['nxp,pca9554'], 'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[32]], 'phandle': [[23]]}}}}, 'i2c@11100': {'compatible': ['marvell,mv78230-a0-i2c', 'marvell,mv64xxx-i2c'], 'reg': [[69888, 32]], '#address-cells': [[1]], '#size-cells': [[0]], 'interrupts': [[0, 3, 4]], 'clocks': [[4, 0]], 'status': ['disabled']}, 'serial@12000': {'compatible': ['marvell,armada-38x-uart', 'ns16550a'], 'reg': [[73728, 256]], 'reg-shift': [[2]], 'interrupts': [[0, 12, 4]], 'reg-io-width': [[1]], 'clocks': [[4, 0]], 'status': ['okay'], 'pinctrl-names': ['default'], 'pinctrl-0': [[8]]}, 'serial@12100': {'compatible': ['marvell,armada-38x-uart', 'ns16550a'], 'reg': [[73984, 256]], 'reg-shift': [[2]], 'interrupts': [[0, 13, 4]], 'reg-io-width': [[1]], 'clocks': [[4, 0]], 'status': ['disabled']}, 'pinctrl@18000': {'reg': [[98304, 32]], 'compatible': ['marvell,mv88f6820-pinctrl'], 'phandle': [[9]], 'ge-rgmii-pin
 s-0': {'marvell,pins': ['mpp6', 'mpp7', 'mpp8', 'mpp9', 'mpp10', 'mpp11', 'mpp12', 'mpp13', 'mpp14', 'mpp15', 'mpp16', 'mpp17'], 'marvell,function': ['ge0']}, 'ge-rgmii-pins-1': {'marvell,pins': ['mpp21', 'mpp27', 'mpp28', 'mpp29', 'mpp30', 'mpp31', 'mpp32', 'mpp37', 'mpp38', 'mpp39', 'mpp40', 'mpp41'], 'marvell,function': ['ge1']}, 'i2c-pins-0': {'marvell,pins': ['mpp2', 'mpp3'], 'marvell,function': ['i2c0'], 'phandle': [[5]]}, 'mdio-pins': {'marvell,pins': ['mpp4', 'mpp5'], 'marvell,function': ['ge']}, 'ref-clk-pins-0': {'marvell,pins': ['mpp45'], 'marvell,function': ['ref']}, 'ref-clk-pins-1': {'marvell,pins': ['mpp46'], 'marvell,function': ['ref']}, 'spi-pins-0': {'marvell,pins': ['mpp22', 'mpp23', 'mpp24', 'mpp25'], 'marvell,function': ['spi0']}, 'spi-pins-1': {'marvell,pins': ['mpp56', 'mpp57', 'mpp58', 'mpp59'], 'marvell,function': ['spi1'], 'phandle': [[17]]}, 'nand-pins': {'marvell,pins': ['mpp22', 'mpp34', 'mpp23', 'mpp33', 'mpp38', 'mpp28', 'mpp40', 'mpp42', 'mpp35', 'mpp
 36', 'mpp25', 'mpp30', 'mpp32'], 'marvell,function': ['dev']}, 'nand-rb': {'marvell,pins': ['mpp41'], 'marvell,function': ['nand']}, 'uart-pins-0': {'marvell,pins': ['mpp0', 'mpp1'], 'marvell,function': ['ua0'], 'phandle': [[8]]}, 'uart-pins-1': {'marvell,pins': ['mpp19', 'mpp20'], 'marvell,function': ['ua1']}, 'sdhci-pins': {'marvell,pins': ['mpp48', 'mpp49', 'mpp50', 'mpp52', 'mpp53', 'mpp54', 'mpp55', 'mpp57', 'mpp58', 'mpp59'], 'marvell,function': ['sd0']}, 'sata-pins-0': {'marvell,pins': ['mpp20'], 'marvell,function': ['sata0']}, 'sata-pins-1': {'marvell,pins': ['mpp19'], 'marvell,function': ['sata1']}, 'sata-pins-2': {'marvell,pins': ['mpp47'], 'marvell,function': ['sata2']}, 'sata-pins-3': {'marvell,pins': ['mpp44'], 'marvell,function': ['sata3']}, 'i2s-pins': {'marvell,pins': ['mpp48', 'mpp49', 'mpp50', 'mpp51', 'mpp52', 'mpp53'], 'marvell,function': ['audio']}, 'spdif-pins': {'marvell,pins': ['mpp51'], 'marvell,function': ['audio']}, 'i2c-gpio-pins-0': {'marvell,pins': ['mp
 p2', 'mpp3'], 'marvell,function': ['gpio'], 'phandle': [[6]]}}, 'gpio@18100': {'compatible': ['marvell,armada-370-gpio', 'marvell,orion-gpio'], 'reg': [[98560, 64], [98752, 8]], 'reg-names': ['gpio', 'pwm'], 'ngpios': [[32]], 'gpio-controller': True, 'gpio-ranges': [[9, 0, 0, 32]], '#gpio-cells': [[2]], '#pwm-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'interrupts': [[0, 53, 4], [0, 54, 4], [0, 55, 4], [0, 56, 4]], 'clocks': [[4, 0]], 'phandle': [[7]]}, 'gpio@18140': {'compatible': ['marvell,armada-370-gpio', 'marvell,orion-gpio'], 'reg': [[98624, 64], [98760, 8]], 'reg-names': ['gpio', 'pwm'], 'ngpios': [[28]], 'gpio-controller': True, 'gpio-ranges': [[9, 0, 32, 28]], '#gpio-cells': [[2]], '#pwm-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'interrupts': [[0, 58, 4], [0, 59, 4], [0, 60, 4], [0, 61, 4]], 'clocks': [[4, 0]], 'phandle': [[19]]}, 'system-controller@18200': {'compatible': ['marvell,armada-380-system-controller', 'mar
 vell,armada-370-xp-system-controller'], 'reg': [[98816, 256]]}, 'clock-gating-control@18220': {'compatible': ['marvell,armada-380-gating-clock'], 'reg': [[98848, 4]], 'clocks': [[4, 0]], '#clock-cells': [[1]], 'phandle': [[11]]}, 'phy@18300': {'compatible': ['marvell,armada-380-comphy'], 'reg-names': ['comphy', 'conf'], 'reg': [[99072, 256], [99424, 4]], '#address-cells': [[1]], '#size-cells': [[0]], 'phy@0': {'reg': [[0]], '#phy-cells': [[1]]}, 'phy@1': {'reg': [[1]], '#phy-cells': [[1]]}, 'phy@2': {'reg': [[2]], '#phy-cells': [[1]]}, 'phy@3': {'reg': [[3]], '#phy-cells': [[1]]}, 'phy@4': {'reg': [[4]], '#phy-cells': [[1]]}, 'phy@5': {'reg': [[5]], '#phy-cells': [[1]]}}, 'mvebu-sar@18600': {'compatible': ['marvell,armada-380-core-clock'], 'reg': [[99840, 4]], '#clock-cells': [[1]], 'phandle': [[4]]}, 'mbus-controller@20000': {'compatible': ['marvell,mbus-controller'], 'reg': [[131072, 256], [131456, 32], [131664, 8]], 'phandle': [[2]]}, 'interrupt-controller@20a00': {'compatible': 
 ['marvell,mpic'], 'reg': [[133632, 720], [135280, 88]], '#interrupt-cells': [[1]], '#size-cells': [[1]], 'interrupt-controller': True, 'msi-controller': True, 'interrupts': [[1, 15, 4]], 'phandle': [[1]]}, 'timer@20300': {'compatible': ['marvell,armada-380-timer', 'marvell,armada-xp-timer'], 'reg': [[131840, 48], [135232, 48]], 'interrupts-extended': [[3, 0, 8, 4], [3, 0, 9, 4], [3, 0, 10, 4], [3, 0, 11, 4], [1, 5], [1, 6]], 'clocks': [[4, 2], [10]], 'clock-names': ['nbclk', 'fixed']}, 'watchdog@20300': {'compatible': ['marvell,armada-380-wdt'], 'reg': [[131840, 52], [132868, 4], [98912, 4]], 'clocks': [[4, 2], [10]], 'clock-names': ['nbclk', 'fixed'], 'interrupts-extended': [[3, 0, 64, 4], [3, 0, 9, 4]]}, 'cpurst@20800': {'compatible': ['marvell,armada-370-cpu-reset'], 'reg': [[133120, 16]]}, 'mpcore-soc-ctrl@20d20': {'compatible': ['marvell,armada-380-mpcore-soc-ctrl'], 'reg': [[134432, 108]]}, 'coherency-fabric@21010': {'compatible': ['marvell,armada-380-coherency-fabric'], 'reg'
 : [[135184, 28]]}, 'pmsu@22000': {'compatible': ['marvell,armada-380-pmsu'], 'reg': [[139264, 4096]]}, 'ethernet@70000': {'compatible': ['marvell,armada-370-neta'], 'reg': [[458752, 16384]], 'interrupts-extended': [[1, 8]], 'clocks': [[11, 4]], 'tx-csum-limit': [[9800]], 'status': ['disabled']}, 'ethernet@30000': {'compatible': ['marvell,armada-370-neta'], 'reg': [[196608, 16384]], 'interrupts-extended': [[1, 10]], 'clocks': [[11, 3]], 'status': ['disabled']}, 'ethernet@34000': {'compatible': ['marvell,armada-370-neta'], 'reg': [[212992, 16384]], 'interrupts-extended': [[1, 12]], 'clocks': [[11, 2]], 'status': ['disabled']}, 'usb@58000': {'compatible': ['marvell,orion-ehci'], 'reg': [[360448, 1280]], 'interrupts': [[0, 18, 4]], 'clocks': [[11, 18]], 'status': ['okay']}, 'xor@60800': {'compatible': ['marvell,armada-380-xor', 'marvell,orion-xor'], 'reg': [[395264, 256], [395776, 256]], 'clocks': [[11, 22]], 'status': ['okay'], 'xor00': {'interrupts': [[0, 22, 4]], 'dmacap,memcpy': Tru
 e, 'dmacap,xor': True}, 'xor01': {'interrupts': [[0, 23, 4]], 'dmacap,memcpy': True, 'dmacap,xor': True, 'dmacap,memset': True}}, 'xor@60900': {'compatible': ['marvell,armada-380-xor', 'marvell,orion-xor'], 'reg': [[395520, 256], [396032, 256]], 'clocks': [[11, 28]], 'status': ['okay'], 'xor10': {'interrupts': [[0, 65, 4]], 'dmacap,memcpy': True, 'dmacap,xor': True}, 'xor11': {'interrupts': [[0, 66, 4]], 'dmacap,memcpy': True, 'dmacap,xor': True, 'dmacap,memset': True}}, 'mdio@72004': {'#address-cells': [[1]], '#size-cells': [[0]], 'compatible': ['marvell,orion-mdio'], 'reg': [[466948, 4]], 'clocks': [[11, 4]]}, 'crypto@90000': {'compatible': ['marvell,armada-38x-crypto'], 'reg': [[589824, 65536]], 'reg-names': ['regs'], 'interrupts': [[0, 19, 4], [0, 20, 4]], 'clocks': [[11, 23], [11, 21], [11, 14], [11, 16]], 'clock-names': ['cesa0', 'cesa1', 'cesaz0', 'cesaz1'], 'marvell,crypto-srams': [[12, 13]], 'marvell,crypto-sram-size': [[2048]]}, 'rtc@a3800': {'compatible': ['marvell,armada
 -380-rtc'], 'reg': [[669696, 32], [99488, 12]], 'reg-names': ['rtc', 'rtc-soc'], 'interrupts': [[0, 21, 4]]}, 'sata@a8000': {'compatible': ['marvell,armada-380-ahci'], 'reg': [[688128, 8192]], 'interrupts': [[0, 26, 4]], 'clocks': [[11, 15]], 'status': ['disabled']}, 'bm@c8000': {'compatible': ['marvell,armada-380-neta-bm'], 'reg': [[819200, 172]], 'clocks': [[11, 13]], 'internal-mem': [[14]], 'status': ['disabled']}, 'sata@e0000': {'compatible': ['marvell,armada-380-ahci'], 'reg': [[917504, 8192]], 'interrupts': [[0, 28, 4]], 'clocks': [[11, 30]], 'status': ['disabled']}, 'clock@e4250': {'compatible': ['marvell,armada-380-corediv-clock'], 'reg': [[934480, 12]], '#clock-cells': [[1]], 'clocks': [[15]], 'clock-output-names': ['nand'], 'phandle': [[16]]}, 'thermal@e8078': {'compatible': ['marvell,armada380-thermal'], 'reg': [[934008, 4], [934000, 8]], 'status': ['okay']}, 'nand-controller@d0000': {'compatible': ['marvell,armada370-nand-controller'], 'reg': [[851968, 84]], '#address-ce
 lls': [[1]], '#size-cells': [[0]], 'interrupts': [[0, 84, 4]], 'clocks': [[16, 0]], 'status': ['okay'], 'nand@0': {'reg': [[0]], 'label': ['pxa3xx_nand-0'], 'nand-rb': [[0]], 'nand-on-flash-bbt': True, 'nand-ecc-strength': [[4]], 'nand-ecc-step-size': [[512]], 'marvell,nand-enable-arbiter': True, 'partitions': {'compatible': ['fixed-partitions'], '#address-cells': [[1]], '#size-cells': [[1]], 'partition@0': {'reg': [[0, 251658240]], 'label': ['user']}, 'partition@f000000': {'reg': [[251658240, 8388608]], 'label': ['errlog']}, 'partition@f800000': {'reg': [[260046848, 8388608]], 'label': ['nand-bbt']}}}}, 'sdhci@d8000': {'compatible': ['marvell,armada-380-sdhci'], 'reg-names': ['sdhci', 'mbus', 'conf-sdio3'], 'reg': [[884736, 4096], [901120, 256], [99412, 4]], 'interrupts': [[0, 25, 4]], 'clocks': [[11, 17]], 'mrvl,clk-delay-cycles': [[31]], 'status': ['disabled']}, 'audio-controller@e8000': {'#sound-dai-cells': [[1]], 'compatible': ['marvell,armada-380-audio'], 'reg': [[950272, 1638
 4], [99344, 12], [98820, 4]], 'reg-names': ['i2s_regs', 'pll_regs', 'soc_ctrl'], 'interrupts': [[0, 75, 4]], 'clocks': [[11, 0]], 'clock-names': ['internal'], 'status': ['disabled']}, 'usb3@f0000': {'compatible': ['marvell,armada-380-xhci'], 'reg': [[983040, 16384], [999424, 16384]], 'interrupts': [[0, 16, 4]], 'clocks': [[11, 9]], 'status': ['disabled']}, 'usb3@f8000': {'compatible': ['marvell,armada-380-xhci'], 'reg': [[1015808, 16384], [1032192, 16384]], 'interrupts': [[0, 17, 4]], 'clocks': [[11, 10]], 'status': ['disabled']}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#






