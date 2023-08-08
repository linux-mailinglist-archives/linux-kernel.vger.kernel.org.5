Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B343774517
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHHSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjHHSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:36:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73DB15C90;
        Tue,  8 Aug 2023 09:41:43 -0700 (PDT)
Received: from i53875a28.versanet.de ([83.135.90.40] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qTKzY-0007r7-Mx; Tue, 08 Aug 2023 13:35:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas McKahan <tmckahan@singleboardsolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add NanoPC T6
Date:   Tue, 08 Aug 2023 13:35:11 +0200
Message-ID: <1770215.VLH7GnMWUR@diego>
In-Reply-To: <20230808002751.00001385@singleboardsolutions.com>
References: <20230802051441.3106-1-tmckahan@singleboardsolutions.com>
 <f49a803f-9ff4-794e-265b-a98e3711cca8@linaro.org>
 <20230808002751.00001385@singleboardsolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 8. August 2023, 06:32:45 CEST schrieb Thomas McKahan:
> On Mon, 7 Aug 2023 08:44:40 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 02/08/2023 07:14, Thomas McKahan wrote:
> > > Add the NanoPC T6, a single board computer from FriendlyElec based on
> > > the RK3588.
> > > 
> > > Initial device tree supports debug UART, SD, eMMC, PCIe 3, PMIC,
> > > and 40 pin GPIO assignments.
> > > 
> > > Signed-off-by: Thomas McKahan <tmckahan@singleboardsolutions.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > >  .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 845 ++++++++++++++++++
> > >  2 files changed, 846 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > index 1ebbb3e9c2f9..e7728007fd1b 100644
> > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > @@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
> > > new file mode 100644
> > > index 000000000000..2362da2c53d9
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
> > > @@ -0,0 +1,845 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> > > + * Copyright (c) 2023 Thomas McKahan
> > > + *
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/pinctrl/rockchip.h>
> > > +#include <dt-bindings/usb/pd.h>
> > > +#include "rk3588.dtsi"
> > > +
> > > +/ {
> > > +	model = "FriendlyElec NanoPC-T6";
> > > +	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
> > > +
> 
> ...
> 
> > > +&spi2 {
> > > +	status = "okay";
> > > +	assigned-clocks = <&cru CLK_SPI2>;
> > > +	assigned-clock-rates = <200000000>;
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> > > +	num-cs = <1>;
> > > +
> > > +	pmic@0 {
> > > +		compatible = "rockchip,rk806";
> > > +		spi-max-frequency = <1000000>;
> > > +		reg = <0x0>;
> > > +
> > > +		interrupt-parent = <&gpio0>;
> > > +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> > > +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> > > +
> > > +		vcc1-supply = <&vcc4v0_sys>;
> > > +		vcc2-supply = <&vcc4v0_sys>;
> > > +		vcc3-supply = <&vcc4v0_sys>;
> > > +		vcc4-supply = <&vcc4v0_sys>;
> > > +		vcc5-supply = <&vcc4v0_sys>;
> > > +		vcc6-supply = <&vcc4v0_sys>;
> > > +		vcc7-supply = <&vcc4v0_sys>;
> > > +		vcc8-supply = <&vcc4v0_sys>;
> > > +		vcc9-supply = <&vcc4v0_sys>;
> > > +		vcc10-supply = <&vcc4v0_sys>;
> > > +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> > > +		vcc12-supply = <&vcc4v0_sys>;
> > > +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> > > +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> > > +		vcca-supply = <&vcc4v0_sys>;
> > > +
> > > +		gpio-controller;
> > > +		#gpio-cells = <2>;
> > > +
> > > +		rk806_dvs1_null: dvs1-null-pins {
> > > +			pins = "gpio_pwrctrl2";
> > > +			function = "pin_fun0";
> > > +		};
> > > +
> > > +		rk806_dvs2_null: dvs2-null-pins {
> > > +			pins = "gpio_pwrctrl2";
> > > +			function = "pin_fun0";
> > > +		};
> > > +
> > > +		rk806_dvs3_null: dvs3-null-pins {
> > > +			pins = "gpio_pwrctrl3";
> > > +			function = "pin_fun0";
> > > +		};
> > > +
> > > +		regulators {
> > > +			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> > > +				regulator-boot-on;  
> > 
> > Boolean properties are not first, but last. regulator-name is the first
> > one. This odd style...
> > 
> 
> I agree, however it seems the norm in Rockchip devices. This will
> become an outlier in Rockchip but fall in line with the general case.
> I'll put it in V2 with the other mentioned fixes unless a conflicting 
> opinion is expressed. 

I definitly do prefer regulator-name to be the first regulator-* (same as
compatible for regular nodes) and I think generally I do catch outliers
in this .

But for the rest of the propeties I guess it's different. While true I
followed a scheme of booleans at the bottom in the past, going with
"name at the top, rest alphabetically" is way easier to explain to people.

[normal nodes should do: {compatible, regs, interrupts, ..alphabetical..,
  status} of course ]

And of course regulator nodes are generally in board-files not in central
soc dtsis and if needed I'll also just move things around when applying ;-).


Heiko


> 
> > > +				regulator-min-microvolt = <550000>;
> > > +				regulator-max-microvolt = <950000>;
> > > +				regulator-ramp-delay = <12500>;
> > > +				regulator-name = "vdd_gpu_s0";
> > > +				regulator-enable-ramp-delay = <400>;
> > > +
> > > +				regulator-state-mem {
> > > +					regulator-off-in-suspend;
> > > +				};
> > > +			};  
> > 
> > 
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Best Regards,
> Thomas
> 




