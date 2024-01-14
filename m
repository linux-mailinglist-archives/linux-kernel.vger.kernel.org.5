Return-Path: <linux-kernel+bounces-25490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4F282D113
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B11F216C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC12570;
	Sun, 14 Jan 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyuhyuk.kr header.i=@kyuhyuk.kr header.b="a9hHG5F2"
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E523C2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyuhyuk.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyuhyuk.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyuhyuk.kr; s=sig1;
	t=1705245063; bh=qvAtBKFzunlr+pj2jJnMPpjsQvkroxkCD0slVQnw7hI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=a9hHG5F2QyjCjX4X124oYHXNftAb2AaXES9xpJxX0i5XSFDZE+yPa77+f6Dqn1zTr
	 qma0QhkluKMY87/nTuhSWR99ef/T1wQP7fKp7tKY4j9EXRoGnSTvx0A7nb88Duyb2A
	 t427PZq64fDAOmSS/EmN436GdHsWRSaVB2gXxV5CAoJRGEea6S/aVXdpswlyAyycLd
	 jLdOztn3JHwJigH8fAcuE+L2sxi2QS6nIQ4vG1NiKirudUKCvmY2jiDiTFCOwS57uD
	 kbmQfStSRWvKoKt/g2kx+8nvE1S2tdbmeBy4Jkih8lkJHvzTa64OwJER4Rutfmzaka
	 lxNQD5csTV3qA==
Received: from kyuhyuk.kr (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 106E4C80146;
	Sun, 14 Jan 2024 15:10:57 +0000 (UTC)
Date: Mon, 15 Jan 2024 00:10:45 +0900
From: KyuHyuk Lee <lee@kyuhyuk.kr>
To: Tim Lunn <tim@feathertop.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Tianling Shen <cnsztl@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, Ondrej Jirman <megi@xff.cz>,
	Andy Yan <andyshrk@163.com>, Jagan Teki <jagan@edgeble.ai>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Heidelberg <david@ixit.cz>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1S board
Message-ID: <ZaP5de5wchr/b9WM@kyuhyuk.kr>
References: <20240112135004.28907-1-lee@kyuhyuk.kr>
 <5774eb3f-dfdc-4e4d-985e-3ec4b69ad206@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5774eb3f-dfdc-4e4d-985e-3ec4b69ad206@feathertop.org>
X-Proofpoint-GUID: X9K8esLsFtU9kyWzM7X5UUUF9oIpxu5u
X-Proofpoint-ORIG-GUID: X9K8esLsFtU9kyWzM7X5UUUF9oIpxu5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-14_08,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1030
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401140118

On Sun, Jan 14, 2024 at 11:01:32PM +1100, Tim Lunn wrote:
> Hi Lee,
> 
> On 1/13/24 00:50, KyuHyuk Lee wrote:
> > This patch is to add a device tree for new board Hardkernel ODROID-M1S
> > based on Rockchip RK3566, includes basic peripherals uart/eMMC/uSD/i2c
> > 
> > Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> > ---
> >   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >   .../boot/dts/rockchip/rk3566-odroid-m1s.dts   | 388 ++++++++++++++++++
> >   2 files changed, 389 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index a7b30e11beaf..0cc7360a6120 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353ps.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353v.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353vs.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg503.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-odroid-m1s.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-powkiddy-rgb30.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts b/arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts
> > new file mode 100644
> > index 000000000000..c6c4f573535f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts
> > @@ -0,0 +1,388 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2024 KyuHyuk Lee <lee@kyuhyuk.kr>
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include "rk3566.dtsi"
> > +
> > +/ {
> > +	model = "Hardkernel ODROID-M1S";
> > +	compatible = "rockchip,rk3566-odroid-m1s", "rockchip,rk3566";
> > +
> > +	aliases {
> > +		i2c0 = &i2c3;
> > +		i2c3 = &i2c0;
> > +		spi0 = &spi1;
> > +		spi1 = &spi0;
> > +		mmc0 = &sdmmc0;
> > +		mmc1 = &sdhci;
> > +		serial0 = &uart6;
> > +		serial1 = &uart0;
> > +		serial6 = &uart1;
> > +	};
> I suppose these mismatched aliases are here to keep compatibility with the
> Odroid M1? However thats going to be super confusing to anyone following the
> actual Odroid M1S connector pinout (even the pin card that came with my
> Odroid M1S doesnt show these mappings, but the actual real ports)?
> > +
> > +	chosen {
> > +		stdout-path = "serial2:1500000n8";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		led_power: led-0 {
> > +			gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> > +			function = LED_FUNCTION_POWER;
> > +			color = <LED_COLOR_ID_RED>;
> > +			linux,default-trigger = "default-on";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&led_power_pin>;
> > +		};
> > +		led_work: led-1 {
> > +			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> > +			function = LED_FUNCTION_HEARTBEAT;
> > +			color = <LED_COLOR_ID_BLUE>;
> > +			linux,default-trigger = "heartbeat";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&led_work_pin>;
> > +		};
> > +	};
> > +
> > +	vcc_sys: vcc-sys-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +	};
> > +
> > +	vcc3v3_sys: vcc3v3-sys-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc3v3_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc5v0_sys>;
> > +	};
> > +
> > +	vcc5v0_sys: vcc5v0-sys-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc5v0_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		vin-supply = <&vcc_sys>;
> > +	};
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu1 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu2 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu3 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&i2c0 {
> > +	status = "okay";
> > +
> > +	vdd_cpu: regulator@1c {
> > +		compatible = "tcs,tcs452x";
> This compatible seems to be from the Rockchip kernel, for mainline it should
> be  "tcs,tcs4525"?
> > +		reg = <0x1c>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		regulator-name = "vdd_cpu";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <712500>;
> > +		regulator-max-microvolt = <1390000>;
> > +		regulator-init-microvolt = <900000>;
> > +		regulator-ramp-delay = <2300>;
> > +		vin-supply = <&vcc5v0_sys>;
> I had checked schematics for this and they seem to show that this is
> vin-supply = <&vcc3v3_sys>?
> > +
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +	rk809: pmic@20 {
> > +		compatible = "rockchip,rk809";
> > +		reg = <0x20>;
> > +		interrupt-parent = <&gpio0>;
> > +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > +		#clock-cells = <1>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pmic_int_l>;
> > +		rockchip,system-power-controller;
> > +		vcc1-supply = <&vcc3v3_sys>;
> > +		vcc2-supply = <&vcc3v3_sys>;
> > +		vcc3-supply = <&vcc3v3_sys>;
> > +		vcc4-supply = <&vcc3v3_sys>;
> > +		vcc5-supply = <&vcc3v3_sys>;
> > +		vcc6-supply = <&vcc3v3_sys>;
> > +		vcc7-supply = <&vcc3v3_sys>;
> > +		vcc8-supply = <&vcc3v3_sys>;
> > +		vcc9-supply = <&vcc3v3_sys>;
> > +		wakeup-source;
> > +
> > +		regulators {
> > +			vdd_logic: DCDC_REG1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <500000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-init-microvolt = <900000>;
> > +				regulator-ramp-delay = <6001>;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vdd_logic";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_gpu: DCDC_REG2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <500000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-init-microvolt = <900000>;
> > +				regulator-ramp-delay = <6001>;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vdd_gpu";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_ddr: DCDC_REG3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vcc_ddr";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_npu: DCDC_REG4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <500000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-init-microvolt = <900000>;
> > +				regulator-ramp-delay = <6001>;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vdd_npu";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda0v9_image: LDO_REG1 {
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-name = "vdda0v9_image";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda_0v9: LDO_REG2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-name = "vdda_0v9";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda0v9_pmu: LDO_REG3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-name = "vdda0v9_pmu";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <900000>;
> > +				};
> > +			};
> > +
> > +			vccio_acodec: LDO_REG4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3000000>;
> > +				regulator-max-microvolt = <3000000>;
> > +				regulator-name = "vccio_acodec";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vccio_sd: LDO_REG5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vccio_sd";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc3v3_pmu: LDO_REG6 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcc3v3_pmu";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3300000>;
> > +				};
> > +			};
> > +
> > +			vcca_1v8: LDO_REG7 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcca_1v8";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcca1v8_ddr: LDO_REG8 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcca1v8_pmu";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1800000>;
> > +				};
> > +			};
> > +
> > +			vcca1v8_image: LDO_REG9 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcca1v8_image";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_1v8: DCDC_REG5 {
> Maybe its just me, but seems odd that DCDC_REG5 is out of order with the
> other DCDC regulators above.
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcc_1v8";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_3v3: SWITCH_REG1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-name = "vcc_3v3";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc3v3_sd: SWITCH_REG2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-name = "vcc3v3_sd";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&pinctrl {
> > +	leds {
> > +		led_power_pin: led-power-pin {
> > +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +		led_work_pin: led-work-pin {
> > +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> > +
> > +	pmic {
> > +		pmic_int_l: pmic-int-l {
> > +			rockchip,pins =
> > +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> > +		};
> > +	};
> > +};
> > +
> > +&pmu_io_domains {
> > +	pmuio2-supply = <&vcc3v3_pmu>;
> > +	vccio1-supply = <&vccio_acodec>;
> > +	vccio3-supply = <&vccio_sd>;
> > +	vccio4-supply = <&vcc_3v3>;
> > +	vccio5-supply = <&vcc_3v3>;
> > +	vccio6-supply = <&vcc_3v3>;
> > +	vccio7-supply = <&vcc_3v3>;
> > +	status = "okay";
> > +};
> Did you miss pmuio1 and vccio2 here? the latter of which is the eMMC domain.
> 
> Are you planning to add additional patches for usb, gmac etc? I had been
> working through cleaning up these device tree files with a view to
> submitting them soon also.
> 
> Regards
>    Tim

Hello Tim. Thank you for your reviewing.

I'll check you said above.

Yes, I am planning additional patches like usb, gmac as you said.
May I understand that you cleaned up my patch?
I look forward to your reply.

Thank you,
KyuHyuk Lee.

