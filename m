Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485A17FB095
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjK1Cpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjK1Cpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:45:33 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB62D56;
        Mon, 27 Nov 2023 18:45:34 -0800 (PST)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B8BACCF7;
        Mon, 27 Nov 2023 18:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1701139533;
        bh=+QF4LKMlUrGkXYlxbIDT2tyvAxlPf26m6XiL9dEwUgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fU+6pcAodw09LYeyW+GknQCc30II9Gz5ZAs/E2jhnJLHTh1AKHKpYAMhIS5F+T8M8
         4dGjwvIAkAa2ulTr2wkU7YNSHmuVYMVR+nlMDx1rVGcX01yFFAEeaseYS1fOow+j8B
         x1smP/5FEUh0VgNh+pN4gmF1H1XEbm346AHO0Yko=
Date:   Mon, 27 Nov 2023 18:45:31 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Renze Nicolai <renze@rnplus.nl>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
Message-ID: <5e74d971-b70a-4e17-be06-dec89110e2e6@hatter.bewilderbeest.net>
References: <20231128013136.2699317-1-renze@rnplus.nl>
 <20231128013136.2699317-3-renze@rnplus.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231128013136.2699317-3-renze@rnplus.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Renze,

Happy to see this moving forward again!  A few comments below, mostly 
pretty minor stuff.

On Mon, Nov 27, 2023 at 05:30:17PM PST, Renze Nicolai wrote:
>This is a relatively low-cost AST2500-based Amd Ryzen 5000 Series
>micro-ATX board that we hope can provide a decent platform for OpenBMC
>development.
>
>This initial device-tree provides the necessary configuration for
>basic BMC functionality such as serial console, KVM support
>and POST code snooping.
>
>Signed-off-by: Renze Nicolai <renze@rnplus.nl>
>---
> arch/arm/boot/dts/aspeed/Makefile             |   1 +
> .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 344 ++++++++++++++++++
> 2 files changed, 345 insertions(+)
> create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
>
>diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>index d3ac20e316d0..2205bd079d0c 100644
>--- a/arch/arm/boot/dts/aspeed/Makefile
>+++ b/arch/arm/boot/dts/aspeed/Makefile
>@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
> 	aspeed-bmc-asrock-e3c246d4i.dtb \
> 	aspeed-bmc-asrock-romed8hm3.dtb \
>+	aspeed-bmc-asrock-x570d4u.dtb \
> 	aspeed-bmc-bytedance-g220a.dtb \
> 	aspeed-bmc-delta-ahe50dc.dtb \
> 	aspeed-bmc-facebook-bletchley.dtb \
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
>new file mode 100644
>index 000000000000..9fb1d76abacb
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
>@@ -0,0 +1,344 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/dts-v1/;
>+#include "aspeed-g5.dtsi"
>+#include <dt-bindings/gpio/aspeed-gpio.h>
>+
>+/ {
>+	model = "Asrock Rack X570D4U BMC";
>+	compatible = "asrock,x570d4u-bmc";

This should probably be:

   compatible = "asrock,x570d4u-bmc", "aspeed,ast2500";

>+
>+	chosen {
>+			stdout-path = &uart5;
>+			bootargs = "console=ttyS4,115200 earlycon";
>+	};
>+
>+	memory@80000000 {
>+			reg = <0x80000000 0x20000000>;
>+	};
>+
>+	reserved-memory {
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+			ranges;
>+
>+			pci_memory: region@9A000000 {
>+				no-map;
>+				reg = <0x9A000000 0x00010000>; /* 64K */

Minor style nit: while it's not completely universal, most device-trees 
(and kernel code in general) generally prefers lower-case letters in hex 
literals.

>+			};
>+
>+			video_engine_memory: jpegbuffer {
>+				size = <0x02800000>;	/* 40M */
>+				alignment = <0x01000000>;
>+				compatible = "shared-dma-pool";
>+				reusable;
>+			};
>+
>+			gfx_memory: framebuffer {
>+				size = <0x01000000>;
>+				alignment = <0x01000000>;
>+				compatible = "shared-dma-pool";
>+				reusable;
>+			};
>+	};

The three blocks above (chosen, memory, reserved-memory) all have their 
bodies indented by an extra tab, which would be good to trim off.

>+
>+	leds {
>+		compatible = "gpio-leds";
>+
>+		heartbeat {
>+			/* led-heartbeat-n */
>+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
>+			linux,default-trigger = "timer";
>+		};
>+
>+		system-fault {
>+			/* led-fault-n */
>+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
>+			panic-indicator;
>+		};

For completeness these should have 'function' and 'color' attributes 
added as well (you'll need to #include <dt-bindings/leds/common.h> for 
the LED_FUNCTION_* and LED_COLOR_ID_* macros to use for that).  Also, 
the preferred names for the nodes would now be led-0 and led-1 (the 
kernel will assign them more recognizable names in /sys/class/leds based 
on the color and function attributes).

>+	};
>+
>+	iio-hwmon {
>+		compatible = "iio-hwmon";
>+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
>+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
>+			<&adc 10>, <&adc 11>, <&adc 12>;
>+	};
>+};
>+
>+&gpio {
>+	status = "okay";
>+	gpio-line-names =
>+	/*A0-A3*/       "status-locatorled-n",                    "",                      "button-nmi-n",          "",
>+	/*A4-A7*/       "",                                       "",                      "",                      "",
>+	/*B0-B3*/       "input-bios-post-cmplt-n",                "",                      "",                      "",
>+	/*B4-B7*/       "",                                       "",                      "",                      "",
>+	/*C0-C3*/       "",                                       "",                      "",                      "",
>+	/*C4-C7*/       "",                                       "",                      "control-locatorbutton", "",
>+	/*D0-D3*/       "button-power",                           "control-power",         "button-reset",          "control-reset",
>+	/*D4-D7*/       "",                                       "",                      "",                      "",
>+	/*E0-E3*/       "",                                       "",                      "",                      "",
>+	/*E4-E7*/       "",                                       "",                      "",                      "",
>+	/*F0-F3*/       "",                                       "",                      "",                      "",
>+	/*F4-F7*/       "",                                       "",                      "",                      "",
>+	/*G0-G3*/       "output-rtc-battery-voltage-read-enable", "input-id0",             "input-id1",             "input-id2",
>+	/*G4-G7*/       "input-alert1-n",                         "input-alert2-n",        "input-alert3-n",        "",
>+	/*H0-H3*/       "",                                       "",                      "",                      "",
>+	/*H4-H7*/       "input-mfg",                              "",                      "led-heartbeat-n",       "input-caseopen",
>+	/*I0-I3*/       "",                                       "",                      "",                      "",
>+	/*I4-I7*/       "",                                       "",                      "",                      "",
>+	/*J0-J3*/       "output-bmc-ready",                       "",                      "",                      "",
>+	/*J4-J7*/       "",                                       "",                      "",                      "",
>+	/*K0-K3*/       "",                                       "",                      "",                      "",
>+	/*K4-K7*/       "",                                       "",                      "",                      "",
>+	/*L0-L3*/       "",                                       "",                      "",                      "",
>+	/*L4-L7*/       "",                                       "",                      "",                      "",
>+	/*M0-M3*/       "",                                       "",                      "",                      "",
>+	/*M4-M7*/       "",                                       "",                      "",                      "",
>+	/*N0-N3*/       "",                                       "",                      "",                      "",
>+	/*N4-N7*/       "",                                       "",                      "",                      "",
>+	/*O0-O3*/       "",                                       "",                      "",                      "",
>+	/*O4-O7*/       "",                                       "",                      "",                      "",
>+	/*P0-P3*/       "",                                       "",                      "",                      "",
>+	/*P4-P7*/       "",                                       "",                      "",                      "",
>+	/*Q0-Q3*/       "",                                       "",                      "",                      "",
>+	/*Q4-Q7*/       "",                                       "",                      "",                      "",
>+	/*R0-R3*/       "",                                       "",                      "",                      "",
>+	/*R4-R7*/       "",                                       "",                      "",                      "",
>+	/*S0-S3*/       "input-bmc-pchhot-n",                     "",                      "",                      "",
>+	/*S4-S7*/       "",                                       "",                      "",                      "",
>+	/*T0-T3*/       "",                                       "",                      "",                      "",
>+	/*T4-T7*/       "",                                       "",                      "",                      "",
>+	/*U0-U3*/       "",                                       "",                      "",                      "",
>+	/*U4-U7*/       "",                                       "",                      "",                      "",
>+	/*V0-V3*/       "",                                       "",                      "",                      "",
>+	/*V4-V7*/       "",                                       "",                      "",                      "",
>+	/*W0-W3*/       "",                                       "",                      "",                      "",
>+	/*W4-W7*/       "",                                       "",                      "",                      "",
>+	/*X0-X3*/       "",                                       "",                      "",                      "",
>+	/*X4-X7*/       "",                                       "",                      "",                      "",
>+	/*Y0-Y3*/       "",                                       "",                      "",                      "",
>+	/*Y4-Y7*/       "",                                       "",                      "",                      "",
>+	/*Z0-Z3*/       "",                                       "",                      "led-fault-n",           "output-bmc-throttle-n",
>+	/*Z4-Z7*/       "",                                       "",                      "",                      "",
>+	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",                      "input-cpu1-prochot-n",  "",
>+	/*AA4-AC7*/     "",                                       "",                      "",                      "",
>+	/*AB0-AB3*/     "",                                       "",                      "",                      "",
>+	/*AB4-AC7*/     "",                                       "",                      "",                      "",
>+	/*AC0-AC3*/     "",                                       "",                      "",                      "",
>+	/*AC4-AC7*/     "",                                       "",                      "",                      "";
>+
>+
>+	/* Assert output-bmc-ready to allow the BIOS to continue booting */
>+	bmc-ready {
>+		gpio-hog;
>+		/* output-bmc-ready */
>+		gpios = <ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
>+		output-high;
>+	};

I did this on the e3c246d4i and I'm not sure it was entirely the right 
choice -- it does solve the problem of avoiding the host's boot sequence
sitting there waiting for a timeout to expire before proceeding, but it 
does so by essentially lying and asserting readiness at all times (when 
the host is probably expecting that to mean that the BMC is actually 
prepared to respond to IPMI commands on the KCS interface and such).  In 
practice the only time I think it might cause any noticeable problems is 
if the host happens to reboot at just the wrong time relative to a BMC 
reboot, but ideally we'd have some more honest userspace logic to assert 
it at an appropriate time when it actually means something (though 
exactly what might be up for some discussion).  Under the circumstances 
this may be the pragmatic approach for now, but if OpenBMC does ever 
arrive at something to solve that particular problem this would need to 
be backed out to make room for it.

>+};
>+
>+&fmc {
>+	status = "okay";
>+	flash@0 {
>+			status = "okay";
>+			label = "bmc";
>+			m25p,fast-read;
>+			spi-max-frequency = <10000000>;

Over-indented block body again here.

>+#include "openbmc-flash-layout-64.dtsi"
>+	};
>+};
>+
>+&uart5 {
>+	status = "okay";
>+};
>+
>+&vuart {
>+	status = "okay";
>+};
>+
>+&mac0 {
>+	status = "okay";
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
>+};
>+
>+&mac1 {
>+	status = "okay";
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_rmii2_default &pinctrl_mdio2_default>;
>+	use-ncsi;
>+};

mac0 & mac1 could make use of the recently-added support for retrieving 
MAC addresses from a location specified by an nvmem-cells property; see 
https://lore.kernel.org/openbmc/20231120121901.19817-6-zev@bewilderbeest.net/T/#u 
for an example (already mentioned off-list, just including here for the 
sake of completeness).

>+
>+&i2c0 {
>+	status = "okay";
>+};
>+
>+&i2c1 {
>+	status = "okay";
>+
>+	w83773g@4c {
>+		compatible = "nuvoton,w83773g";
>+		reg = <0x4c>;
>+	};
>+};
>+
>+&i2c2 {
>+	status = "okay";
>+};
>+
>+&i2c3 {
>+	status = "okay";
>+};
>+
>+&i2c4 {
>+	status = "okay";
>+
>+	i2c-switch@70 {

I'm guessing this mux is for the PCIe slots?  (A brief comment 
indicating that might be nice if so, and maybe which channels are mapped 
to which specific slots if you happen to have worked that out.)

It'd probably also be good to add some aliases for the sub-busses of the 
mux so they get assigned consistent, predictable numbers.

>+		compatible = "nxp,pca9545";
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+		reg = <0x70>;
>+
>+		interrupt-parent = <&i2c_ic>;
>+		interrupts = <4>;
>+		interrupt-controller;
>+		#interrupt-cells = <2>;
>+
>+		i2c@0 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <0>;
>+		};
>+
>+		i2c@1 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <1>;
>+		};
>+
>+		i2c@2 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <2>;
>+		};
>+
>+		i2c@3 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <3>;
>+		};
>+	};
>+};
>+
>+&i2c5 {
>+	status = "okay";
>+};
>+
>+&i2c7 {
>+	status = "okay";
>+
>+	eeprom@57 {
>+		compatible = "st,24c128", "atmel,24c128";
>+		reg = <0x57>;
>+		pagesize = <16>;
>+	};

I assume this is the motherboard's FRU eeprom; if so and this is 
anything like the other ASRR boards I've dealt with, the BMC MAC 
addresses should be at offsets 0x3f80 (dedicated) and 0x3f88 (NCSI) 
within it.

>+};
>+
>+&gfx {
>+	status = "okay";
>+};
>+
>+&pinctrl {
>+	aspeed,external-nodes = <&gfx &lhc>;
>+};
>+
>+&vhub {
>+	status = "okay";
>+};
>+
>+&ehci1 {
>+	status = "okay";
>+};
>+&uhci {
>+	status = "okay";
>+};
>+
>+&kcs3 {
>+	aspeed,lpc-io-reg = <0xca2>;
>+	status = "okay";
>+};
>+
>+&lpc_ctrl {
>+	status = "okay";
>+};
>+
>+&lpc_snoop {
>+	status = "okay";
>+	snoop-ports = <0x80>;
>+};
>+
>+&p2a {
>+	status = "okay";
>+	memory-region = <&pci_memory>;
>+};
>+
>+&video {
>+	status = "okay";
>+	memory-region = <&video_engine_memory>;
>+};
>+
>+&pwm_tacho {
>+	status = "okay";
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_pwm0_default
>+				&pinctrl_pwm1_default
>+				&pinctrl_pwm2_default
>+				&pinctrl_pwm3_default
>+				&pinctrl_pwm4_default
>+				&pinctrl_pwm5_default>;
>+	fan@0 {
>+		reg = <0x00>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x01>;
>+	};
>+	fan@1 {
>+		reg = <0x01>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x03>;
>+	};
>+	fan@2 {
>+		reg = <0x02>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x05>;
>+	};
>+	fan@3 {
>+		reg = <0x03>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x07>;
>+	};
>+	fan@4 {
>+		reg = <0x04>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x08 0x09>;
>+	};
>+	fan@5 {
>+		reg = <0x05>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x0a 0x0b>;
>+	};

Minor style nit: it's common (and nice IMO) to include a blank line 
between sibling nodes.

>+};
>+
>+&adc {
>+	status = "okay";
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_adc0_default
>+				&pinctrl_adc1_default
>+				&pinctrl_adc2_default
>+				&pinctrl_adc3_default
>+				&pinctrl_adc4_default
>+				&pinctrl_adc5_default
>+				&pinctrl_adc6_default
>+				&pinctrl_adc7_default
>+				&pinctrl_adc8_default
>+				&pinctrl_adc9_default
>+				&pinctrl_adc10_default
>+				&pinctrl_adc11_default
>+				&pinctrl_adc12_default
>+				&pinctrl_adc13_default
>+				&pinctrl_adc14_default
>+				&pinctrl_adc15_default>;
>+};
>-- 
>2.43.0
>
>
