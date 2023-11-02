Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B027DEE77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbjKBIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbjKBIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F218E;
        Thu,  2 Nov 2023 01:54:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D4DC433C7;
        Thu,  2 Nov 2023 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698915271;
        bh=SjWNYir4m8hAGSOp9mmwrQ3O5eufL5raCmckYXwkrz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/ni7+CJXFEst5k4QtfoXIbxi0kRBDwUtZ7sqOiOzqPokVGu4K+mCaW9GgCZW36P7
         MU4EdhhGNwi6eyKePmL/PmuCFruL7zkXNPfl9ATe943j2LeRXppU+HPcZskGRf/nCX
         9sSPCGS0MeEyJFJKTLxQTU/F0kuiQDelLPe4CKrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.5.10
Date:   Thu,  2 Nov 2023 09:54:19 +0100
Message-ID: <2023110219-nature-nickname-4556@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023110219-dayroom-slacked-ee81@gregkh>
References: <2023110219-dayroom-slacked-ee81@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index fc83c079c471..ab9f291c1d3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 5
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index b63bd4ad3143..88a4b0d6d928 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -64,7 +64,8 @@ timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		arm,cpu-registers-not-fw-configured;
 		clock-frequency = <24000000>;
 	};
@@ -233,7 +234,7 @@ timer0: timer@20044000 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER0>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -241,7 +242,7 @@ timer1: timer@20044020 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044020 0x20>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER1>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -249,7 +250,7 @@ timer2: timer@20044040 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044040 0x20>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER2>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -257,7 +258,7 @@ timer3: timer@20044060 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044060 0x20>;
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER3>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -265,7 +266,7 @@ timer4: timer@20044080 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044080 0x20>;
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER4>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -273,7 +274,7 @@ timer5: timer@200440a0 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x200440a0 0x20>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER5>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -426,7 +427,7 @@ saradc: saradc@2006c000 {
 
 	i2c0: i2c@20072000 {
 		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <20072000 0x1000>;
+		reg = <0x20072000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clock-names = "i2c";
 		clocks = <&cru PCLK_I2C0>;
@@ -458,6 +459,7 @@ pdma: dma-controller@20078000 {
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		arm,pl330-broken-no-flushp;
+		arm,pl330-periph-burst;
 		clocks = <&cru ACLK_DMAC>;
 		clock-names = "apb_pclk";
 		#dma-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi
index 7ae8b620515c..59f546a278f8 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi
@@ -109,6 +109,8 @@ mcbsp1: mcbsp@0 {
 				reg = <0x0 0xff>, /* MPU private access */
 				      <0x49022000 0xff>; /* L3 Interconnect */
 				reg-names = "mpu", "dma";
+				clocks = <&abe_clkctrl OMAP4_MCBSP1_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
@@ -142,6 +144,8 @@ mcbsp2: mcbsp@0 {
 				reg = <0x0 0xff>, /* MPU private access */
 				      <0x49024000 0xff>; /* L3 Interconnect */
 				reg-names = "mpu", "dma";
+				clocks = <&abe_clkctrl OMAP4_MCBSP2_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
@@ -175,6 +179,8 @@ mcbsp3: mcbsp@0 {
 				reg = <0x0 0xff>, /* MPU private access */
 				      <0x49026000 0xff>; /* L3 Interconnect */
 				reg-names = "mpu", "dma";
+				clocks = <&abe_clkctrl OMAP4_MCBSP3_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 46b8f9efd413..3fcef3080eae 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -2043,6 +2043,8 @@ mcbsp4: mcbsp@0 {
 				compatible = "ti,omap4-mcbsp";
 				reg = <0x0 0xff>; /* L4 Interconnect */
 				reg-names = "mpu";
+				clocks = <&l4_per_clkctrl OMAP4_MCBSP4_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
diff --git a/arch/arm/boot/dts/ti/omap/omap5-l4-abe.dtsi b/arch/arm/boot/dts/ti/omap/omap5-l4-abe.dtsi
index a03bca5a3584..97b0c3b5f573 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-l4-abe.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5-l4-abe.dtsi
@@ -109,6 +109,8 @@ mcbsp1: mcbsp@0 {
 				reg = <0x0 0xff>, /* MPU private access */
 				      <0x49022000 0xff>; /* L3 Interconnect */
 				reg-names = "mpu", "dma";
+				clocks = <&abe_clkctrl OMAP5_MCBSP1_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
@@ -142,6 +144,8 @@ mcbsp2: mcbsp@0 {
 				reg = <0x0 0xff>, /* MPU private access */
 				      <0x49024000 0xff>; /* L3 Interconnect */
 				reg-names = "mpu", "dma";
+				clocks = <&abe_clkctrl OMAP5_MCBSP2_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
@@ -175,6 +179,8 @@ mcbsp3: mcbsp@0 {
 				reg = <0x0 0xff>, /* MPU private access */
 				      <0x49026000 0xff>; /* L3 Interconnect */
 				reg-names = "mpu", "dma";
+				clocks = <&abe_clkctrl OMAP5_MCBSP3_CLKCTRL 24>;
+				clock-names = "fck";
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "common";
 				ti,buffer-size = <128>;
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 9808cd27e2cf..67de96c7717d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -550,6 +550,7 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 	&cx20442_codec_device,
+	&modem_nreset_device,
 };
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
@@ -782,26 +783,28 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{ },
 };
 
+static int ams_delta_modem_pm_activate(struct device *dev)
+{
+	modem_priv.regulator = regulator_get(dev, "RESET#");
+	if (IS_ERR(modem_priv.regulator))
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
+static struct dev_pm_domain ams_delta_modem_pm_domain = {
+	.activate	= ams_delta_modem_pm_activate,
+};
+
 static struct platform_device ams_delta_modem_device = {
 	.name	= "serial8250",
 	.id	= PLAT8250_DEV_PLATFORM1,
 	.dev		= {
 		.platform_data = ams_delta_modem_ports,
+		.pm_domain = &ams_delta_modem_pm_domain,
 	},
 };
 
-static int __init modem_nreset_init(void)
-{
-	int err;
-
-	err = platform_device_register(&modem_nreset_device);
-	if (err)
-		pr_err("Couldn't register the modem regulator device\n");
-
-	return err;
-}
-
-
 /*
  * This function expects MODEM IRQ number already assigned to the port.
  * The MODEM device requires its RESET# pin kept high during probe.
@@ -833,37 +836,6 @@ static int __init ams_delta_modem_init(void)
 }
 arch_initcall_sync(ams_delta_modem_init);
 
-static int __init late_init(void)
-{
-	int err;
-
-	err = modem_nreset_init();
-	if (err)
-		return err;
-
-	/*
-	 * Once the modem device is registered, the modem_nreset
-	 * regulator can be requested on behalf of that device.
-	 */
-	modem_priv.regulator = regulator_get(&ams_delta_modem_device.dev,
-			"RESET#");
-	if (IS_ERR(modem_priv.regulator)) {
-		err = PTR_ERR(modem_priv.regulator);
-		goto unregister;
-	}
-	return 0;
-
-unregister:
-	platform_device_unregister(&ams_delta_modem_device);
-	return err;
-}
-
-static void __init ams_delta_init_late(void)
-{
-	omap1_init_late();
-	late_init();
-}
-
 static void __init ams_delta_map_io(void)
 {
 	omap1_map_io();
@@ -877,7 +849,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
-	.init_late	= ams_delta_init_late,
+	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 410d17d1d443..f618a6df2938 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -176,17 +176,18 @@ static u64 notrace omap_32k_read_sched_clock(void)
 	return sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
 }
 
+static struct timespec64 persistent_ts;
+static cycles_t cycles;
+static unsigned int persistent_mult, persistent_shift;
+
 /**
  * omap_read_persistent_clock64 -  Return time from a persistent clock.
+ * @ts: &struct timespec64 for the returned time
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
  * nsecs and adds to a monotonically increasing timespec64.
  */
-static struct timespec64 persistent_ts;
-static cycles_t cycles;
-static unsigned int persistent_mult, persistent_shift;
-
 static void omap_read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned long long nsecs;
@@ -206,10 +207,9 @@ static void omap_read_persistent_clock64(struct timespec64 *ts)
 /**
  * omap_init_clocksource_32k - setup and register counter 32k as a
  * kernel clocksource
- * @pbase: base addr of counter_32k module
- * @size: size of counter_32k to map
+ * @vbase: base addr of counter_32k module
  *
- * Returns 0 upon success or negative error code upon failure.
+ * Returns: %0 upon success or negative error code upon failure.
  *
  */
 static int __init omap_init_clocksource_32k(void __iomem *vbase)
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index b599909c4463..8b5a2c738137 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -62,25 +62,23 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	clocks {
-		divclk4: divclk4 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk4";
+	div1_mclk: divclk1 {
+		compatible = "gpio-gate-clock";
+		pinctrl-0 = <&audio_mclk>;
+		pinctrl-names = "default";
+		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+		#clock-cells = <0>;
+		enable-gpios = <&pm8994_gpios 15 0>;
+	};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk4_pin_a>;
-		};
+	divclk4: divclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk4";
 
-		div1_mclk: divclk1 {
-			compatible = "gpio-gate-clock";
-			pinctrl-0 = <&audio_mclk>;
-			pinctrl-names = "default";
-			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-			#clock-cells = <0>;
-			enable-gpios = <&pm8994_gpios 15 0>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk4_pin_a>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 47f55c7311e9..3c5719640fab 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -11,26 +11,24 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
-	clocks {
-		divclk1_cdc: divclk1 {
-			compatible = "gpio-gate-clock";
-			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-			#clock-cells = <0>;
-			enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
+	divclk1_cdc: divclk1 {
+		compatible = "gpio-gate-clock";
+		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+		#clock-cells = <0>;
+		enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk1_default>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk1_default>;
+	};
 
-		divclk4: divclk4 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk4";
+	divclk4: divclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk4";
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk4_pin_a>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk4_pin_a>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index d1066edaea47..f8e9d90afab0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -20,16 +20,14 @@ / {
 	qcom,pmic-id = <0x20009 0x2000a 0x00 0x00>;
 	qcom,board-id = <31 0>;
 
-	clocks {
-		divclk2_haptics: divclk2 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk2";
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk2_pin_a>;
-		};
+	divclk2_haptics: divclk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk2";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk2_pin_a>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 3c3b6287cd27..eaa43f022a65 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -173,7 +173,7 @@ pmm8654au_1_gpios: gpio@8800 {
 			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
-			gpio-ranges = <&pmm8654au_2_gpios 0 0 12>;
+			gpio-ranges = <&pmm8654au_1_gpios 0 0 12>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 08a3ad3e7ae9..de0a1f2af983 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -68,15 +68,17 @@ i2s0-sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,name = "Haikou,I2S-codec";
 		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&sgtl5000_codec>;
+		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
 
-		simple-audio-card,codec {
-			clocks = <&sgtl5000_clk>;
+		sgtl5000_codec: simple-audio-card,codec {
 			sound-dai = <&sgtl5000>;
+			// Prevent the dai subsystem from overwriting the clock
+			// frequency. We are using a fixed-frequency oscillator.
+			system-clock-fixed;
 		};
 
 		simple-audio-card,cpu {
-			bitclock-master;
-			frame-master;
 			sound-dai = <&i2s0_8ch>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 980c4534313a..c0f430f045a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -493,6 +493,7 @@ &i2c4 {
 
 &i2s0 {
 	pinctrl-0 = <&i2s0_2ch_bus>;
+	pinctrl-1 = <&i2s0_2ch_bus_bclk_off>;
 	rockchip,capture-channels = <2>;
 	rockchip,playback-channels = <2>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 928948e7c7bb..bf1251cc7195 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2430,6 +2430,16 @@ i2s0_2ch_bus: i2s0-2ch-bus {
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
 
+			i2s0_2ch_bus_bclk_off: i2s0-2ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<3 RK_PD1 1 &pcfg_pull_none>,
+					<3 RK_PD2 1 &pcfg_pull_none>,
+					<3 RK_PD3 1 &pcfg_pull_none>,
+					<3 RK_PD7 1 &pcfg_pull_none>,
+					<4 RK_PA0 1 &pcfg_pull_none>;
+			};
+
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
 					<3 RK_PD0 1 &pcfg_pull_none>,
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 781e39b3c009..481e94e1f685 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
  * we only bother with faults on loads... */
 
 cc_fault:
-	ret
+	retl
 	 clr	%o0
diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 637fa1df3512..c715097e92fd 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b3af2d45bbbb..5190cc3db771 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_H	- premium mobile parts
  *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
@@ -125,6 +126,7 @@
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
+#define INTEL_FAM6_ARROWLAKE_H		0xC5
 #define INTEL_FAM6_ARROWLAKE		0xC6
 
 /* "Small Core" Processors (Atom/E-Core) */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 53369c57751e..9cc9f12679f1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	/* ACPI 6.3 and newer support the online capable bit. */
 	if (acpi_gbl_FADT.header.revision > 6 ||
 	    (acpi_gbl_FADT.header.revision == 6 &&
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 4d8aff05a509..17385d74465e 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -301,15 +302,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
+	/*
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -431,5 +449,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index bbc440c93e08..1123ef3ccf90 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -15,6 +15,7 @@
  * ( The serial nature of the boot logic and the CPU hotplug lock
  *   protects against more than 2 CPUs entering this code. )
  */
+#include <linux/workqueue.h>
 #include <linux/topology.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
@@ -342,6 +343,13 @@ static inline unsigned int loop_timeout(int cpu)
 	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
 }
 
+static void tsc_sync_mark_tsc_unstable(struct work_struct *work)
+{
+	mark_tsc_unstable("check_tsc_sync_source failed");
+}
+
+static DECLARE_WORK(tsc_sync_work, tsc_sync_mark_tsc_unstable);
+
 /*
  * The freshly booted CPU initiates this via an async SMP function call.
  */
@@ -395,7 +403,7 @@ static void check_tsc_sync_source(void *__cpu)
 			"turning off TSC clock.\n", max_warp);
 		if (random_warps)
 			pr_warn("TSC warped randomly between CPUs\n");
-		mark_tsc_unstable("check_tsc_sync_source failed");
+		schedule_work(&tsc_sync_work);
 	}
 
 	/*
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e78bc3b65ec8..dcf95e4e0cd9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -723,6 +723,12 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
 
 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+	/*
+	 * Can result be wider than 64 bits?
+	 * We check against 62, not 64, due to ilog2 truncation.
+	 */
+	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+		return U64_MAX;
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 09dee5be2070..2e236df4039d 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -343,14 +343,19 @@ int ivpu_boot(struct ivpu_device *vdev)
 	return 0;
 }
 
-int ivpu_shutdown(struct ivpu_device *vdev)
+void ivpu_prepare_for_reset(struct ivpu_device *vdev)
 {
-	int ret;
-
 	ivpu_hw_irq_disable(vdev);
 	disable_irq(vdev->irq);
 	ivpu_ipc_disable(vdev);
 	ivpu_mmu_disable(vdev);
+}
+
+int ivpu_shutdown(struct ivpu_device *vdev)
+{
+	int ret;
+
+	ivpu_prepare_for_reset(vdev);
 
 	ret = ivpu_hw_power_down(vdev);
 	if (ret)
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 399dc5dcefd7..343b15e56799 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -144,6 +144,7 @@ void ivpu_file_priv_put(struct ivpu_file_priv **link);
 
 int ivpu_boot(struct ivpu_device *vdev);
 int ivpu_shutdown(struct ivpu_device *vdev);
+void ivpu_prepare_for_reset(struct ivpu_device *vdev);
 
 static inline bool ivpu_is_mtl(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index 50a9304ab09c..dac59f1c1e05 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -13,6 +13,7 @@ struct ivpu_hw_ops {
 	int (*power_up)(struct ivpu_device *vdev);
 	int (*boot_fw)(struct ivpu_device *vdev);
 	int (*power_down)(struct ivpu_device *vdev);
+	int (*reset)(struct ivpu_device *vdev);
 	bool (*is_idle)(struct ivpu_device *vdev);
 	void (*wdt_disable)(struct ivpu_device *vdev);
 	void (*diagnose_failure)(struct ivpu_device *vdev);
@@ -90,6 +91,13 @@ static inline int ivpu_hw_power_down(struct ivpu_device *vdev)
 	return vdev->hw->ops->power_down(vdev);
 };
 
+static inline int ivpu_hw_reset(struct ivpu_device *vdev)
+{
+	ivpu_dbg(vdev, PM, "HW reset\n");
+
+	return vdev->hw->ops->reset(vdev);
+};
+
 static inline void ivpu_hw_wdt_disable(struct ivpu_device *vdev)
 {
 	vdev->hw->ops->wdt_disable(vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw_mtl.c b/drivers/accel/ivpu/ivpu_hw_mtl.c
index 2a5dd3a5dc46..52a9d60a44f5 100644
--- a/drivers/accel/ivpu/ivpu_hw_mtl.c
+++ b/drivers/accel/ivpu/ivpu_hw_mtl.c
@@ -953,9 +953,6 @@ static u32 ivpu_hw_mtl_irqb_handler(struct ivpu_device *vdev, int irq)
 	if (status == 0)
 		return 0;
 
-	/* Disable global interrupt before handling local buttress interrupts */
-	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x1);
-
 	if (REG_TEST_FLD(MTL_BUTTRESS_INTERRUPT_STAT, FREQ_CHANGE, status))
 		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x", REGB_RD32(MTL_BUTTRESS_CURRENT_PLL));
 
@@ -986,9 +983,6 @@ static u32 ivpu_hw_mtl_irqb_handler(struct ivpu_device *vdev, int irq)
 	else
 		REGB_WR32(MTL_BUTTRESS_INTERRUPT_STAT, status);
 
-	/* Re-enable global interrupt */
-	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x0);
-
 	if (schedule_recovery)
 		ivpu_pm_schedule_recovery(vdev);
 
@@ -1000,9 +994,14 @@ static irqreturn_t ivpu_hw_mtl_irq_handler(int irq, void *ptr)
 	struct ivpu_device *vdev = ptr;
 	u32 ret_irqv, ret_irqb;
 
+	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x1);
+
 	ret_irqv = ivpu_hw_mtl_irqv_handler(vdev, irq);
 	ret_irqb = ivpu_hw_mtl_irqb_handler(vdev, irq);
 
+	/* Re-enable global interrupts to re-trigger MSI for pending interrupts */
+	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x0);
+
 	return IRQ_RETVAL(ret_irqb | ret_irqv);
 }
 
@@ -1041,6 +1040,7 @@ const struct ivpu_hw_ops ivpu_hw_mtl_ops = {
 	.power_up = ivpu_hw_mtl_power_up,
 	.is_idle = ivpu_hw_mtl_is_idle,
 	.power_down = ivpu_hw_mtl_power_down,
+	.reset = ivpu_hw_mtl_reset,
 	.boot_fw = ivpu_hw_mtl_boot_fw,
 	.wdt_disable = ivpu_hw_mtl_wdt_disable,
 	.diagnose_failure = ivpu_hw_mtl_diagnose_failure,
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index aa4d56dc52b3..86ec828dd1df 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -260,7 +260,8 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 
 	ivpu_dbg(vdev, PM, "Pre-reset..\n");
 	atomic_set(&vdev->pm->in_reset, 1);
-	ivpu_shutdown(vdev);
+	ivpu_prepare_for_reset(vdev);
+	ivpu_hw_reset(vdev);
 	ivpu_pm_prepare_cold_boot(vdev);
 	ivpu_jobs_abort_all(vdev);
 	ivpu_dbg(vdev, PM, "Pre-reset done.\n");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cdbc382e949b..d1fd47d6704a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1103,10 +1103,11 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 
 		/*
 		 * Ask the sd driver to issue START STOP UNIT on runtime suspend
-		 * and resume only. For system level suspend/resume, devices
-		 * power state is handled directly by libata EH.
+		 * and resume and shutdown only. For system level suspend/resume,
+		 * devices power state is handled directly by libata EH.
 		 */
 		sdev->manage_runtime_start_stop = true;
+		sdev->manage_shutdown = true;
 	}
 
 	/*
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..473563bc7496 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name = NULL;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3430,18 +3431,20 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 	 * registered (yet).
 	 */
 	parent = clk_core_get_parent_by_index(core, i);
-	if (parent)
+	if (parent) {
 		seq_puts(s, parent->name);
-	else if (core->parents[i].name)
+	} else if (core->parents[i].name) {
 		seq_puts(s, core->parents[i].name);
-	else if (core->parents[i].fw_name)
+	} else if (core->parents[i].fw_name) {
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
-	else if (core->parents[i].index >= 0)
-		seq_puts(s,
-			 of_clk_get_parent_name(core->of_node,
-						core->parents[i].index));
-	else
-		seq_puts(s, "(missing)");
+	} else {
+		if (core->parents[i].index >= 0)
+			name = of_clk_get_parent_name(core->of_node, core->parents[i].index);
+		if (!name)
+			name = "(missing)";
+
+		seq_puts(s, name);
+	}
 
 	seq_putc(s, terminator);
 }
diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 8dd601bd8538..0a5a95e0267f 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -87,10 +87,8 @@ static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
 	return 0;
 }
 
-static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
-	unsigned long parent_rate)
+static u32 socfpga_clk_get_div(struct socfpga_gate_clk *socfpgaclk)
 {
-	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
 	u32 div = 1, val;
 
 	if (socfpgaclk->fixed_div)
@@ -105,12 +103,33 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 			div = (1 << val);
 	}
 
+	return div;
+}
+
+static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
+					     unsigned long parent_rate)
+{
+	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
+	u32 div = socfpga_clk_get_div(socfpgaclk);
+
 	return parent_rate / div;
 }
 
+
+static int socfpga_clk_determine_rate(struct clk_hw *hwclk,
+				      struct clk_rate_request *req)
+{
+	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
+	u32 div = socfpga_clk_get_div(socfpgaclk);
+
+	req->rate = req->best_parent_rate / div;
+
+	return 0;
+}
+
 static struct clk_ops gateclk_ops = {
 	.recalc_rate = socfpga_clk_recalc_rate,
-	.determine_rate = clk_hw_determine_rate_no_reparent,
+	.determine_rate = socfpga_clk_determine_rate,
 	.get_parent = socfpga_clk_get_parent,
 	.set_parent = socfpga_clk_set_parent,
 };
diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index d5aa09e9fce4..067b918a8894 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -431,7 +431,7 @@ static int clk_stm32_composite_determine_rate(struct clk_hw *hw,
 {
 	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
 	const struct stm32_div_cfg *divider;
-	unsigned long rate;
+	long rate;
 
 	if (composite->div_id == NO_STM32_DIV)
 		return 0;
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 868bc7af21b0..9b2824ed785b 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -749,9 +749,14 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "mcbsp1_sync_mux_ck", "abe-clkctrl:0028:26"),
 	DT_CLK(NULL, "mcbsp2_sync_mux_ck", "abe-clkctrl:0030:26"),
 	DT_CLK(NULL, "mcbsp3_sync_mux_ck", "abe-clkctrl:0038:26"),
+	DT_CLK("40122000.mcbsp", "prcm_fck", "abe-clkctrl:0028:26"),
+	DT_CLK("40124000.mcbsp", "prcm_fck", "abe-clkctrl:0030:26"),
+	DT_CLK("40126000.mcbsp", "prcm_fck", "abe-clkctrl:0038:26"),
 	DT_CLK(NULL, "mcbsp4_sync_mux_ck", "l4-per-clkctrl:00c0:26"),
+	DT_CLK("48096000.mcbsp", "prcm_fck", "l4-per-clkctrl:00c0:26"),
 	DT_CLK(NULL, "ocp2scp_usb_phy_phy_48m", "l3-init-clkctrl:00c0:8"),
 	DT_CLK(NULL, "otg_60m_gfclk", "l3-init-clkctrl:0040:24"),
+	DT_CLK(NULL, "pad_fck", "pad_clks_ck"),
 	DT_CLK(NULL, "per_mcbsp4_gfclk", "l4-per-clkctrl:00c0:24"),
 	DT_CLK(NULL, "pmd_stm_clock_mux_ck", "emu-sys-clkctrl:0000:20"),
 	DT_CLK(NULL, "pmd_trace_clk_mux_ck", "emu-sys-clkctrl:0000:22"),
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index b4aff76eb373..74dfd5823f83 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -565,15 +565,19 @@ static struct ti_dt_clk omap54xx_clks[] = {
 	DT_CLK(NULL, "gpio8_dbclk", "l4per-clkctrl:00f8:8"),
 	DT_CLK(NULL, "mcbsp1_gfclk", "abe-clkctrl:0028:24"),
 	DT_CLK(NULL, "mcbsp1_sync_mux_ck", "abe-clkctrl:0028:26"),
+	DT_CLK("40122000.mcbsp", "prcm_fck", "abe-clkctrl:0028:26"),
 	DT_CLK(NULL, "mcbsp2_gfclk", "abe-clkctrl:0030:24"),
 	DT_CLK(NULL, "mcbsp2_sync_mux_ck", "abe-clkctrl:0030:26"),
+	DT_CLK("40124000.mcbsp", "prcm_fck", "abe-clkctrl:0030:26"),
 	DT_CLK(NULL, "mcbsp3_gfclk", "abe-clkctrl:0038:24"),
 	DT_CLK(NULL, "mcbsp3_sync_mux_ck", "abe-clkctrl:0038:26"),
+	DT_CLK("40126000.mcbsp", "prcm_fck", "abe-clkctrl:0038:26"),
 	DT_CLK(NULL, "mmc1_32khz_clk", "l3init-clkctrl:0008:8"),
 	DT_CLK(NULL, "mmc1_fclk", "l3init-clkctrl:0008:25"),
 	DT_CLK(NULL, "mmc1_fclk_mux", "l3init-clkctrl:0008:24"),
 	DT_CLK(NULL, "mmc2_fclk", "l3init-clkctrl:0010:25"),
 	DT_CLK(NULL, "mmc2_fclk_mux", "l3init-clkctrl:0010:24"),
+	DT_CLK(NULL, "pad_fck", "pad_clks_ck"),
 	DT_CLK(NULL, "sata_ref_clk", "l3init-clkctrl:0068:8"),
 	DT_CLK(NULL, "timer10_gfclk_mux", "l4per-clkctrl:0008:24"),
 	DT_CLK(NULL, "timer11_gfclk_mux", "l4per-clkctrl:0010:24"),
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 59a4c0259456..154590e1f764 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -35,6 +35,9 @@ struct virtio_crypto {
 	struct virtqueue *ctrl_vq;
 	struct data_queue *data_vq;
 
+	/* Work struct for config space updates */
+	struct work_struct config_work;
+
 	/* To protect the vq operations for the controlq */
 	spinlock_t ctrl_lock;
 
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 94849fa3bd74..43a0838d31ff 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -335,6 +335,14 @@ static void virtcrypto_del_vqs(struct virtio_crypto *vcrypto)
 	virtcrypto_free_queues(vcrypto);
 }
 
+static void vcrypto_config_changed_work(struct work_struct *work)
+{
+	struct virtio_crypto *vcrypto =
+		container_of(work, struct virtio_crypto, config_work);
+
+	virtcrypto_update_status(vcrypto);
+}
+
 static int virtcrypto_probe(struct virtio_device *vdev)
 {
 	int err = -EFAULT;
@@ -454,6 +462,8 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	if (err)
 		goto free_engines;
 
+	INIT_WORK(&vcrypto->config_work, vcrypto_config_changed_work);
+
 	return 0;
 
 free_engines:
@@ -490,6 +500,7 @@ static void virtcrypto_remove(struct virtio_device *vdev)
 
 	dev_info(&vdev->dev, "Start virtcrypto_remove.\n");
 
+	flush_work(&vcrypto->config_work);
 	if (virtcrypto_dev_started(vcrypto))
 		virtcrypto_dev_stop(vcrypto);
 	virtio_reset_device(vdev);
@@ -504,7 +515,7 @@ static void virtcrypto_config_changed(struct virtio_device *vdev)
 {
 	struct virtio_crypto *vcrypto = vdev->priv;
 
-	virtcrypto_update_status(vcrypto);
+	schedule_work(&vcrypto->config_work);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -512,6 +523,7 @@ static int virtcrypto_freeze(struct virtio_device *vdev)
 {
 	struct virtio_crypto *vcrypto = vdev->priv;
 
+	flush_work(&vcrypto->config_work);
 	virtio_reset_device(vdev);
 	virtcrypto_free_unused_reqs(vcrypto);
 	if (virtcrypto_dev_started(vcrypto))
diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 749868b9e80d..7edf2c95282f 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1521,6 +1521,7 @@ static int sbp2_scsi_slave_configure(struct scsi_device *sdev)
 	if (sbp2_param_exclusive_login) {
 		sdev->manage_system_start_stop = true;
 		sdev->manage_runtime_start_stop = true;
+		sdev->manage_shutdown = true;
 	}
 
 	if (sdev->type == TYPE_ROM)
diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 1f410809d3ee..0f656e4191d5 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -115,11 +115,11 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		dsp_chan->idx = i % 2;
 		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(dsp_chan->ch)) {
-			kfree(dsp_chan->name);
 			ret = PTR_ERR(dsp_chan->ch);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
 					chan_name, ret);
+			kfree(dsp_chan->name);
 			goto out;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6a8494f98d3e..fe8ba9e9837b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index ed96cfcfa304..8c929ef72c72 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2574,14 +2574,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 	struct drm_dp_mst_branch *found_mstb;
 	struct drm_dp_mst_port *port;
 
+	if (!mstb)
+		return NULL;
+
 	if (memcmp(mstb->guid, guid, 16) == 0)
 		return mstb;
 
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		if (!port->mstb)
-			continue;
-
 		found_mstb = get_mst_branch_device_by_guid_helper(port->mstb, guid);
 
 		if (found_mstb)
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_mcr.c b/drivers/gpu/drm/i915/gt/intel_gt_mcr.c
index 0b414eae1683..2c0f1f3e28ff 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_mcr.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_mcr.c
@@ -376,9 +376,26 @@ void intel_gt_mcr_lock(struct intel_gt *gt, unsigned long *flags)
 	 * driver threads, but also with hardware/firmware agents.  A dedicated
 	 * locking register is used.
 	 */
-	if (GRAPHICS_VER_FULL(gt->i915) >= IP_VER(12, 70))
+	if (GRAPHICS_VER_FULL(gt->i915) >= IP_VER(12, 70)) {
+		/*
+		 * The steering control and semaphore registers are inside an
+		 * "always on" power domain with respect to RC6.  However there
+		 * are some issues if higher-level platform sleep states are
+		 * entering/exiting at the same time these registers are
+		 * accessed.  Grabbing GT forcewake and holding it over the
+		 * entire lock/steer/unlock cycle ensures that those sleep
+		 * states have been fully exited before we access these
+		 * registers.  This wakeref will be released in the unlock
+		 * routine.
+		 *
+		 * This is expected to become a formally documented/numbered
+		 * workaround soon.
+		 */
+		intel_uncore_forcewake_get(gt->uncore, FORCEWAKE_GT);
+
 		err = wait_for(intel_uncore_read_fw(gt->uncore,
 						    MTL_STEER_SEMAPHORE) == 0x1, 100);
+	}
 
 	/*
 	 * Even on platforms with a hardware lock, we'll continue to grab
@@ -415,8 +432,11 @@ void intel_gt_mcr_unlock(struct intel_gt *gt, unsigned long flags)
 {
 	spin_unlock_irqrestore(&gt->mcr_lock, flags);
 
-	if (GRAPHICS_VER_FULL(gt->i915) >= IP_VER(12, 70))
+	if (GRAPHICS_VER_FULL(gt->i915) >= IP_VER(12, 70)) {
 		intel_uncore_write_fw(gt->uncore, MTL_STEER_SEMAPHORE, 0x1);
+
+		intel_uncore_forcewake_put(gt->uncore, FORCEWAKE_GT);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 49c6f1ff1128..331685e1b7b7 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -482,8 +482,7 @@ static void oa_report_id_clear(struct i915_perf_stream *stream, u32 *report)
 static bool oa_report_ctx_invalid(struct i915_perf_stream *stream, void *report)
 {
 	return !(oa_report_id(stream, report) &
-	       stream->perf->gen8_valid_ctx_bit) &&
-	       GRAPHICS_VER(stream->perf->i915) <= 11;
+	       stream->perf->gen8_valid_ctx_bit);
 }
 
 static u64 oa_timestamp(struct i915_perf_stream *stream, void *report)
@@ -5106,6 +5105,7 @@ static void i915_perf_init_info(struct drm_i915_private *i915)
 		perf->gen8_valid_ctx_bit = BIT(16);
 		break;
 	case 12:
+		perf->gen8_valid_ctx_bit = BIT(16);
 		/*
 		 * Calculate offset at runtime in oa_pin_context for gen12 and
 		 * cache the value in perf->ctx_oactxctrl_offset.
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index d35973b41186..7b1076b5e748 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -832,9 +832,18 @@ static void i915_pmu_event_start(struct perf_event *event, int flags)
 
 static void i915_pmu_event_stop(struct perf_event *event, int flags)
 {
+	struct drm_i915_private *i915 =
+		container_of(event->pmu, typeof(*i915), pmu.base);
+	struct i915_pmu *pmu = &i915->pmu;
+
+	if (pmu->closed)
+		goto out;
+
 	if (flags & PERF_EF_UPDATE)
 		i915_pmu_event_read(event);
 	i915_pmu_disable(event);
+
+out:
 	event->hw.state = PERF_HES_STOPPED;
 }
 
diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
index fa7a88368809..1df22a852a23 100644
--- a/drivers/gpu/drm/logicvc/Kconfig
+++ b/drivers/gpu/drm/logicvc/Kconfig
@@ -5,5 +5,7 @@ config DRM_LOGICVC
 	select DRM_KMS_HELPER
 	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER
+	select REGMAP
+	select REGMAP_MMIO
 	help
 	  DRM display driver for the logiCVC programmable logic block from Xylon
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 5a416b39b818..28e2a5fc4528 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -749,6 +749,8 @@ static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
 	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
 	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
 	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
 static int aspeed_i2c_reg_slave(struct i2c_client *client)
@@ -765,7 +767,6 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 	__aspeed_i2c_reg_slave(bus, client->addr);
 
 	bus->slave = client;
-	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 	spin_unlock_irqrestore(&bus->lock, flags);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index e897d9101434..9ee37c59025e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1059,9 +1059,10 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	/* Configure PEC */
 	if ((flags & I2C_CLIENT_PEC) && f7_msg->size != I2C_SMBUS_QUICK) {
 		cr1 |= STM32F7_I2C_CR1_PECEN;
-		cr2 |= STM32F7_I2C_CR2_PECBYTE;
-		if (!f7_msg->read_write)
+		if (!f7_msg->read_write) {
+			cr2 |= STM32F7_I2C_CR2_PECBYTE;
 			f7_msg->count++;
+		}
 	} else {
 		cr1 &= ~STM32F7_I2C_CR1_PECEN;
 		cr2 &= ~STM32F7_I2C_CR2_PECBYTE;
@@ -1149,8 +1150,10 @@ static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
 	f7_msg->stop = true;
 
 	/* Add one byte for PEC if needed */
-	if (cr1 & STM32F7_I2C_CR1_PECEN)
+	if (cr1 & STM32F7_I2C_CR1_PECEN) {
+		cr2 |= STM32F7_I2C_CR2_PECBYTE;
 		f7_msg->count++;
+	}
 
 	/* Set number of bytes to be transferred */
 	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK);
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 22f2280eab7f..9f2e4aa28159 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -61,7 +61,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	if (ret)
 		goto err;
 
-	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
+	adap = of_get_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
 	if (!adap) {
 		ret = -ENODEV;
 		goto err_with_revert;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 0405af0e1510..cd11de8b4505 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -52,7 +52,7 @@ static struct i2c_adapter *mux_parent_adapter(struct device *dev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 18236b9fa14a..6ebca7bfd8a2 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -62,7 +62,7 @@ static struct i2c_adapter *i2c_mux_pinctrl_parent_adapter(struct device *dev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index cff1ba57fb16..43c8af41b4a9 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -826,16 +826,26 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* leave out any TS related code if unreachable */
+	if (IS_REACHABLE(CONFIG_INPUT)) {
+		has_ts = of_property_read_bool(pdev->dev.of_node,
+					       "has-touchscreen") || pdata;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq == -EPROBE_DEFER)
-		return irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
 
-	info->tsirq = irq;
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -900,12 +910,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	if (pdata)
 		info->delay = pdata->delay;
 	else
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index dba73300f894..564c0cad0fc7 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -456,6 +456,9 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const unsigned int xadc_axi_reg_offsets[] = {
@@ -566,6 +569,9 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const struct xadc_ops xadc_us_axi_ops = {
@@ -577,6 +583,12 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
+	/**
+	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
+	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
+	 */
+	.temp_scale = 509314,
+	.temp_offset = 280231,
 };
 
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
@@ -945,8 +957,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
-			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-			*val = 503975;
+			*val = xadc->ops->temp_scale;
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
@@ -954,7 +965,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has an offset */
-		*val = -((273150 << bits) / 503975);
+		*val = -((xadc->ops->temp_offset << bits) / xadc->ops->temp_scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_samplerate(xadc);
@@ -1423,28 +1434,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Disable all alarms */
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
-				  XADC_CONF1_ALARM_MASK);
-	if (ret)
-		return ret;
-
-	/* Set thresholds to min/max */
-	for (i = 0; i < 16; i++) {
-		/*
-		 * Set max voltage threshold and both temperature thresholds to
-		 * 0xffff, min voltage threshold to 0.
-		 */
-		if (i % 8 < 4 || i == 7)
-			xadc->threshold[i] = 0xffff;
-		else
-			xadc->threshold[i] = 0;
-		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			xadc->threshold[i]);
-		if (ret)
-			return ret;
-	}
-
 	/* Go to non-buffered mode */
 	xadc_postdisable(indio_dev);
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 7d78ce698967..3036f4d613ff 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -85,6 +85,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	int temp_scale;
+	int temp_offset;
 };
 
 static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 1f280c360701..56e5913ab82d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -214,8 +214,18 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 				return ret < 0 ? ret : -EOPNOTSUPP;
 		}
 
-		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
-		return rescale_process_offset(rescale, ret, scale, scale2,
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_SCALE)) {
+			ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+			return rescale_process_offset(rescale, ret, scale, scale2,
+						      schan_off, val, val2);
+		}
+
+		/*
+		 * If we get here we have no scale so scale 1:1 but apply
+		 * rescaler and offset, if any.
+		 */
+		return rescale_process_offset(rescale, IIO_VAL_FRACTIONAL, 1, 1,
 					      schan_off, val, val2);
 	default:
 		return -EINVAL;
@@ -280,8 +290,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->type = rescale->cfg->type;
 
 	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
-	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_info(dev, "using raw+scale source channel\n");
+	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
+	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
+		dev_info(dev, "using raw+scale/offset source channel\n");
 	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
 		dev_info(dev, "using processed channel\n");
 		rescale->chan_processed = true;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 42c4f603ec81..fde2e170fed3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -957,6 +957,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	if (err)
 		return err;
 
+	memset(ctx->buf->virt, 0, pkt_size);
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
@@ -1089,6 +1090,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 		}
 	}
 
+	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
@@ -1155,11 +1157,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	if (ctx->nscalars) {
-		err = fastrpc_get_args(kernel, ctx);
-		if (err)
-			goto bail;
-	}
+	err = fastrpc_get_args(kernel, ctx);
+	if (err)
+		goto bail;
 
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
@@ -1175,6 +1175,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		err = wait_for_completion_interruptible(&ctx->work);
 	}
 
+	if (err)
+		goto bail;
+
+	/* make sure that all memory writes by DSP are seen by CPU */
+	dma_rmb();
+	/* populate all the output buffers with results */
+	err = fastrpc_put_args(ctx, kernel);
 	if (err)
 		goto bail;
 
@@ -1183,15 +1190,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	if (ctx->nscalars) {
-		/* make sure that all memory writes by DSP are seen by CPU */
-		dma_rmb();
-		/* populate all the output buffers with results */
-		err = fastrpc_put_args(ctx, kernel);
-		if (err)
-			goto bail;
-	}
-
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
 		/* We are done with this compute context */
@@ -1982,11 +1980,13 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
 				      &args[0]);
-	fastrpc_map_put(map);
-	if (err)
+	if (err) {
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+		return err;
+	}
+	fastrpc_map_put(map);
 
-	return err;
+	return 0;
 }
 
 static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index ca66b747b7c5..d7c274af6d4d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -294,7 +294,7 @@ static int adin1110_read_fifo(struct adin1110_port_priv *port_priv)
 {
 	struct adin1110_priv *priv = port_priv->priv;
 	u32 header_len = ADIN1110_RD_HEADER_LEN;
-	struct spi_transfer t;
+	struct spi_transfer t = {0};
 	u32 frame_size_no_fcs;
 	struct sk_buff *rxb;
 	u32 frame_size;
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 6e310a539467..55bb0b5310d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -580,7 +580,6 @@ struct i40e_pf {
 #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
 #define I40E_FLAG_RS_FEC			BIT(25)
 #define I40E_FLAG_BASE_R_FEC			BIT(26)
-#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
 /* TOTAL_PORT_SHUTDOWN
  * Allows to physically disable the link on the NIC's port.
  * If enabled, (after link down request from the OS)
@@ -603,6 +602,7 @@ struct i40e_pf {
  *   in abilities field of i40e_aq_set_phy_config structure
  */
 #define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(27)
+#define I40E_FLAG_VF_VLAN_PRUNING		BIT(28)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8b8bf4880faa..b59fef9d7c4a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2544,7 +2544,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			rx_buffer = i40e_rx_bi(rx_ring, ntp);
 			i40e_inc_ntp(rx_ring);
 			i40e_reuse_rx_page(rx_ring, rx_buffer);
-			cleaned_count++;
+			/* Update ntc and bump cleaned count if not in the
+			 * middle of mb packet.
+			 */
+			if (rx_ring->next_to_clean == ntp) {
+				rx_ring->next_to_clean =
+					rx_ring->next_to_process;
+				cleaned_count++;
+			}
 			continue;
 		}
 
@@ -2847,7 +2854,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8ea5c0825c3c..13bfc9333a8c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1437,9 +1437,9 @@ void iavf_down(struct iavf_adapter *adapter)
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		if (!list_empty(&adapter->adv_rss_list_head))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
-		adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	}
 
+	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 }
 
@@ -4982,8 +4982,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->finish_config, iavf_finish_config);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
-	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
@@ -4994,6 +4992,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
+	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
+	/* Initialization goes on in the work. Do not add more of it below. */
 	return 0;
 
 err_ioremap:
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 319ed601eaa1..4ee849985e2b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2978,11 +2978,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if (err)
 		goto err_out_w_lock;
 
-	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	err = igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	if (err)
+		goto err_out_input_filter;
 
 	spin_unlock(&adapter->nfc_lock);
 	return 0;
 
+err_out_input_filter:
+	igb_erase_filter(adapter, input);
 err_out_w_lock:
 	spin_unlock(&adapter->nfc_lock);
 err_out:
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 7ab6dd58e400..dd8a9d27a167 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1817,7 +1817,7 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
-	u32 advertising;
+	u16 advertised = 0;
 
 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -1842,18 +1842,33 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
-	/* Converting to legacy u32 drops ETHTOOL_LINK_MODE_2500baseT_Full_BIT.
-	 * We have to check this and convert it to ADVERTISE_2500_FULL
-	 * (aka ETHTOOL_LINK_MODE_2500baseX_Full_BIT) explicitly.
-	 */
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising, 2500baseT_Full))
-		advertising |= ADVERTISE_2500_FULL;
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  2500baseT_Full))
+		advertised |= ADVERTISE_2500_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  1000baseT_Full))
+		advertised |= ADVERTISE_1000_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Full))
+		advertised |= ADVERTISE_100_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Half))
+		advertised |= ADVERTISE_100_HALF;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Full))
+		advertised |= ADVERTISE_10_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Half))
+		advertised |= ADVERTISE_10_HALF;
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		hw->mac.autoneg = 1;
-		hw->phy.autoneg_advertised = advertising;
+		hw->phy.autoneg_advertised = advertised;
 		if (adapter->fc_autoneg)
 			hw->fc.requested_mode = igc_fc_default;
 	} else {
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc13bc..361b90007148 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4364,7 +4364,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		unsigned int entry = dirty_tx % NUM_TX_DESC;
 		u32 status;
 
-		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
+		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
 		if (status & DescOwn)
 			break;
 
@@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		 * If skb is NULL then we come here again once a tx irq is
 		 * triggered after the last fragment is marked transmitted.
 		 */
-		if (tp->cur_tx != dirty_tx && skb)
+		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
 			rtl8169_doorbell(tp);
 	}
 }
@@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(desc->opts1);
+		status = le32_to_cpu(READ_ONCE(desc->opts1));
 		if (status & DescOwn)
 			break;
 
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index dc14a66583ff..44488c153ea2 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1217,7 +1217,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
 		key_index = wl->current_key;
 
 	if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
-		/* reques to change default key index */
+		/* request to change default key index */
 		pr_debug("%s: request to change default key to %d\n",
 			 __func__, key_index);
 		wl->current_key = key_index;
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index acb20ad4e37e..477b4d4f860b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -871,8 +871,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
-	    mtu < ntohs(iph->tot_len)) {
+	if (iph->frag_off & htons(IP_DF) &&
+	    ((!skb_is_gso(skb) && skb->len > mtu) ||
+	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			      htonl(mtu));
diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index a03490ba2e5b..cc7ddc40020f 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 
 static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
-	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
+	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
 
-	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
+	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
+		 "adf7242-%s", dev_name(&lp->spi->dev));
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
 
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index e88bedca8f32..14497e5558bf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1212,7 +1212,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1235,7 +1235,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -9512,7 +9512,8 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
@@ -9801,6 +9802,10 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	cancel_delayed_work_sync(&tp->hw_phy_work);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
+	rtl8152_release_firmware(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 17da42fe605c..a530f20ee257 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -95,7 +95,9 @@ static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (ret < 0) {
+	if (ret < 4) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		if (ret != -ENODEV)
 			netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 				    index, ret);
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ab556c011f3e..2e6ed170ef7c 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -499,7 +499,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
@@ -513,14 +513,14 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
diff --git a/drivers/platform/x86/amd/pmc-quirks.c b/drivers/platform/x86/amd/pmc-quirks.c
index ad702463a65d..6bbffb081053 100644
--- a/drivers/platform/x86/amd/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc-quirks.c
@@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
+	{
+		.ident = "V14 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
+		}
+	},
+	{
+		.ident = "V14 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
+		}
+	},
+	{
+		.ident = "V15 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
+		}
+	},
+	{
+		.ident = "V15 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 14AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 15AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 15AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 14AMN8",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 15AMN8",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
+		}
+	},
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
 	{
 		.ident = "HP Laptop 15s-eq2xxx",
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d6535cbb4e05..c4babb16dac7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -221,7 +221,8 @@ manage_start_stop_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n",
 			  sdp->manage_system_start_stop &&
-			  sdp->manage_runtime_start_stop);
+			  sdp->manage_runtime_start_stop &&
+			  sdp->manage_shutdown);
 }
 static DEVICE_ATTR_RO(manage_start_stop);
 
@@ -287,6 +288,35 @@ manage_runtime_start_stop_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(manage_runtime_start_stop);
 
+static ssize_t manage_shutdown_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+
+	return sysfs_emit(buf, "%u\n", sdp->manage_shutdown);
+}
+
+static ssize_t manage_shutdown_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+	bool v;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (kstrtobool(buf, &v))
+		return -EINVAL;
+
+	sdp->manage_shutdown = v;
+
+	return count;
+}
+static DEVICE_ATTR_RW(manage_shutdown);
+
 static ssize_t
 allow_restart_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -619,6 +649,7 @@ static struct attribute *sd_disk_attrs[] = {
 	&dev_attr_manage_start_stop.attr,
 	&dev_attr_manage_system_start_stop.attr,
 	&dev_attr_manage_runtime_start_stop.attr,
+	&dev_attr_manage_shutdown.attr,
 	&dev_attr_protection_type.attr,
 	&dev_attr_protection_mode.attr,
 	&dev_attr_app_tag_own.attr,
@@ -3858,8 +3889,10 @@ static void sd_shutdown(struct device *dev)
 		sd_sync_cache(sdkp, NULL);
 	}
 
-	if (system_state != SYSTEM_RESTART &&
-	    sdkp->device->manage_system_start_stop) {
+	if ((system_state != SYSTEM_RESTART &&
+	     sdkp->device->manage_system_start_stop) ||
+	    (system_state == SYSTEM_POWER_OFF &&
+	     sdkp->device->manage_shutdown)) {
 		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
 		sd_start_stop_device(sdkp, 0);
 	}
diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
index 60d6ac68cdc4..9c85162c19fc 100644
--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -146,7 +146,8 @@ void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
 		ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
 }
 
-void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
+void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev)
 {
-	debugfs_remove_recursive(dbg);
+	debugfs_remove_recursive(ndev->debugfs);
+	ndev->debugfs = NULL;
 }
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 37be945a0230..0ab19a258ebb 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -625,30 +625,70 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
 	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
 }
 
+static int read_umem_params(struct mlx5_vdpa_net *ndev)
+{
+	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
+	u16 opmod = (MLX5_CAP_VDPA_EMULATION << 1) | (HCA_CAP_OPMOD_GET_CUR & 0x01);
+	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
+	int out_size;
+	void *caps;
+	void *out;
+	int err;
+
+	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	out = kzalloc(out_size, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
+	err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev,
+			"Failed reading vdpa umem capabilities with err %d\n", err);
+		goto out;
+	}
+
+	caps =  MLX5_ADDR_OF(query_hca_cap_out, out, capability);
+
+	ndev->umem_1_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_a);
+	ndev->umem_1_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_b);
+
+	ndev->umem_2_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_a);
+	ndev->umem_2_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_b);
+
+	ndev->umem_3_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_a);
+	ndev->umem_3_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_b);
+
+out:
+	kfree(out);
+	return 0;
+}
+
 static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
 			  struct mlx5_vdpa_umem **umemp)
 {
-	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
-	int p_a;
-	int p_b;
+	u32 p_a;
+	u32 p_b;
 
 	switch (num) {
 	case 1:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_b);
+		p_a = ndev->umem_1_buffer_param_a;
+		p_b = ndev->umem_1_buffer_param_b;
 		*umemp = &mvq->umem1;
 		break;
 	case 2:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_b);
+		p_a = ndev->umem_2_buffer_param_a;
+		p_b = ndev->umem_2_buffer_param_b;
 		*umemp = &mvq->umem2;
 		break;
 	case 3:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_b);
+		p_a = ndev->umem_3_buffer_param_a;
+		p_b = ndev->umem_3_buffer_param_b;
 		*umemp = &mvq->umem3;
 		break;
 	}
+
 	(*umemp)->size = p_a * mvq->num_ent + p_b;
 }
 
@@ -2679,6 +2719,11 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto out;
 	}
 	mlx5_vdpa_add_debugfs(ndev);
+
+	err = read_umem_params(ndev);
+	if (err)
+		goto err_setup;
+
 	err = setup_virtqueues(mvdev);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
@@ -2713,7 +2758,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 err_rqt:
 	teardown_virtqueues(ndev);
 err_setup:
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
+	mlx5_vdpa_remove_debugfs(ndev);
 out:
 	return err;
 }
@@ -2727,8 +2772,7 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
 	if (!ndev->setup)
 		return;
 
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
-	ndev->debugfs = NULL;
+	mlx5_vdpa_remove_debugfs(ndev);
 	teardown_steering(ndev);
 	destroy_tir(ndev);
 	destroy_rqt(ndev);
@@ -3489,8 +3533,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct workqueue_struct *wq;
 
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
-	ndev->debugfs = NULL;
 	unregister_link_notifier(ndev);
 	_vdpa_unregister_device(dev);
 	wq = mvdev->wq;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 36c44d9fdd16..90b556a57971 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -65,6 +65,15 @@ struct mlx5_vdpa_net {
 	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
 	struct mlx5_vdpa_irq_pool irqp;
 	struct dentry *debugfs;
+
+	u32 umem_1_buffer_param_a;
+	u32 umem_1_buffer_param_b;
+
+	u32 umem_2_buffer_param_a;
+	u32 umem_2_buffer_param_b;
+
+	u32 umem_3_buffer_param_a;
+	u32 umem_3_buffer_param_b;
 };
 
 struct mlx5_vdpa_counter {
@@ -88,7 +97,7 @@ struct macvlan_node {
 };
 
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
-void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
+void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 00d7d72713be..b3a3cb165795 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -499,12 +499,13 @@ static int __init vdpasim_blk_init(void)
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-			goto parent_err;
+			goto mgmt_dev_err;
 		}
 	}
 
 	return 0;
-
+mgmt_dev_err:
+	vdpa_mgmtdev_unregister(&mgmt_dev);
 parent_err:
 	device_unregister(&vdpasim_blk_mgmtdev);
 	return ret;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c71d573f1c94..e0c181ad17e3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		goto done;
 	}
 
-	if ((msg.type == VHOST_IOTLB_UPDATE ||
-	     msg.type == VHOST_IOTLB_INVALIDATE) &&
-	     msg.size == 0) {
+	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
 		ret = -EINVAL;
 		goto done;
 	}
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b15936a5214..2d5d252ef419 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -395,7 +395,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
 			&num_pages);
 
-	target = num_pages;
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
 	return target - vb->num_pages;
 }
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97760f611295..59892a31cf76 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -631,14 +631,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(vm_dev->base))
-		return PTR_ERR(vm_dev->base);
+	if (IS_ERR(vm_dev->base)) {
+		rc = PTR_ERR(vm_dev->base);
+		goto free_vm_dev;
+	}
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 
 	/* Check device version */
@@ -646,7 +649,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto free_vm_dev;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -655,7 +659,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -685,6 +690,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		put_device(&vm_dev->vdev.dev);
 
 	return rc;
+
+free_vm_dev:
+	kfree(vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index aad7d9296e77..9cb601e16688 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -291,7 +291,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_common_cfg),
+				      0, sizeof(struct virtio_pci_modern_common_cfg),
 				      NULL, NULL);
 	if (!mdev->common)
 		goto err_map_common;
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 79336fa853db..a4a809efc92f 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3196,12 +3196,14 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
  * We still need to do a tree search to find out the parents. This is for
  * TREE_BLOCK_REF backref (keyed or inlined).
  *
+ * @trans:	Transaction handle.
  * @ref_key:	The same as @ref_key in  handle_direct_tree_backref()
  * @tree_key:	The first key of this tree block.
  * @path:	A clean (released) path, to avoid allocating path every time
  *		the function get called.
  */
-static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
+static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
+					struct btrfs_backref_cache *cache,
 					struct btrfs_path *path,
 					struct btrfs_key *ref_key,
 					struct btrfs_key *tree_key,
@@ -3315,7 +3317,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 			 * If we know the block isn't shared we can avoid
 			 * checking its backrefs.
 			 */
-			if (btrfs_block_can_be_shared(root, eb))
+			if (btrfs_block_can_be_shared(trans, root, eb))
 				upper->checked = 0;
 			else
 				upper->checked = 1;
@@ -3363,17 +3365,18 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
  *	 links aren't yet bi-directional. Needs to finish such links.
  *	 Use btrfs_backref_finish_upper_links() to finish such linkage.
  *
+ * @trans:	Transaction handle.
  * @path:	Released path for indirect tree backref lookup
  * @iter:	Released backref iter for extent tree search
  * @node_key:	The first key of the tree block
  */
-int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
+int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
+				struct btrfs_backref_cache *cache,
 				struct btrfs_path *path,
 				struct btrfs_backref_iter *iter,
 				struct btrfs_key *node_key,
 				struct btrfs_backref_node *cur)
 {
-	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_backref_edge *edge;
 	struct btrfs_backref_node *exist;
 	int ret;
@@ -3462,25 +3465,21 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 			ret = handle_direct_tree_backref(cache, &key, cur);
 			if (ret < 0)
 				goto out;
-			continue;
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, ret, NULL);
-			goto out;
-		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
-			continue;
+		} else if (key.type == BTRFS_TREE_BLOCK_REF_KEY) {
+			/*
+			 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref
+			 * offset means the root objectid. We need to search
+			 * the tree to get its parent bytenr.
+			 */
+			ret = handle_indirect_tree_backref(trans, cache, path,
+							   &key, node_key, cur);
+			if (ret < 0)
+				goto out;
 		}
-
 		/*
-		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
-		 * means the root objectid. We need to search the tree to get
-		 * its parent bytenr.
+		 * Unrecognized tree backref items (if it can pass tree-checker)
+		 * would be ignored.
 		 */
-		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
-						   cur);
-		if (ret < 0)
-			goto out;
 	}
 	ret = 0;
 	cur->checked = 1;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 1616e3e3f1e4..71d535e03dca 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -540,7 +540,8 @@ static inline void btrfs_backref_panic(struct btrfs_fs_info *fs_info,
 		    bytenr);
 }
 
-int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
+int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
+				struct btrfs_backref_cache *cache,
 				struct btrfs_path *path,
 				struct btrfs_backref_iter *iter,
 				struct btrfs_key *node_key,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index da519c1b6ad0..617d4827eec2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -367,7 +367,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 /*
  * check if the tree block can be shared by multiple trees
  */
-int btrfs_block_can_be_shared(struct btrfs_root *root,
+int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root,
 			      struct extent_buffer *buf)
 {
 	/*
@@ -376,11 +377,21 @@ int btrfs_block_can_be_shared(struct btrfs_root *root,
 	 * not allocated by tree relocation, we know the block is not shared.
 	 */
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-	    buf != root->node && buf != root->commit_root &&
+	    buf != root->node &&
 	    (btrfs_header_generation(buf) <=
 	     btrfs_root_last_snapshot(&root->root_item) ||
-	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)))
-		return 1;
+	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))) {
+		if (buf != root->commit_root)
+			return 1;
+		/*
+		 * An extent buffer that used to be the commit root may still be
+		 * shared because the tree height may have increased and it
+		 * became a child of a higher level root. This can happen when
+		 * snapshotting a subvolume created in the current transaction.
+		 */
+		if (btrfs_header_generation(buf) == trans->transid)
+			return 1;
+	}
 
 	return 0;
 }
@@ -415,7 +426,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	 * are only allowed for blocks use full backrefs.
 	 */
 
-	if (btrfs_block_can_be_shared(root, buf)) {
+	if (btrfs_block_can_be_shared(trans, root, buf)) {
 		ret = btrfs_lookup_extent_info(trans, fs_info, buf->start,
 					       btrfs_header_level(buf), 1,
 					       &refs, &flags);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9419f4e37a58..ff40acd63a37 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -540,7 +540,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_block_can_be_shared(struct btrfs_root *root,
+int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root,
 			      struct extent_buffer *buf);
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2cf8d646085c..14ea6b587e97 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -187,8 +187,10 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			num_refs = btrfs_extent_refs(leaf, ei);
 			extent_flags = btrfs_extent_flags(leaf, ei);
 		} else {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			"unexpected extent item size, has %u expect >= %zu",
+				  item_size, sizeof(*ei));
 			if (trans)
 				btrfs_abort_transaction(trans, ret);
 			else
@@ -624,12 +626,12 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 		ref2 = btrfs_item_ptr(leaf, path->slots[0],
 				      struct btrfs_shared_data_ref);
 		num_refs = btrfs_shared_data_ref_count(leaf, ref2);
-	} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-		btrfs_print_v0_err(trans->fs_info);
-		btrfs_abort_transaction(trans, -EINVAL);
-		return -EINVAL;
 	} else {
-		BUG();
+		btrfs_err(trans->fs_info,
+			  "unrecognized backref key (%llu %u %llu)",
+			  key.objectid, key.type, key.offset);
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		return -EUCLEAN;
 	}
 
 	BUG_ON(num_refs < refs_to_drop);
@@ -660,7 +662,6 @@ static noinline u32 extent_data_ref_count(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
-	BUG_ON(key.type == BTRFS_EXTENT_REF_V0_KEY);
 	if (iref) {
 		/*
 		 * If type is invalid, we should have bailed out earlier than
@@ -881,8 +882,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EINVAL;
-		btrfs_print_v0_err(fs_info);
+		err = -EUCLEAN;
+		btrfs_err(fs_info,
+			  "unexpected extent item size, has %llu expect >= %zu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, err);
 		goto out;
 	}
@@ -1683,8 +1686,10 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EINVAL;
-		btrfs_print_v0_err(fs_info);
+		err = -EUCLEAN;
+		btrfs_err(fs_info,
+			  "unexpected extent item size, has %u expect >= %zu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, err);
 		goto out;
 	}
@@ -3113,8 +3118,10 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, extent_slot);
 	if (unlikely(item_size < sizeof(*ei))) {
-		ret = -EINVAL;
-		btrfs_print_v0_err(info);
+		ret = -EUCLEAN;
+		btrfs_err(trans->fs_info,
+			  "unexpected extent item size, has %u expect >= %zu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 23fc11af498a..21f2d101f681 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -252,12 +252,6 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 }
 #endif
 
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
-
 #if BITS_PER_LONG == 32
 void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index deedc1a168e2..1ae6f8e23e07 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -181,8 +181,6 @@ do {								\
 #define ASSERT(expr)	(void)(expr)
 #endif
 
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
-
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index aa06d9ca911d..0c93439e929f 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -95,8 +95,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 	int ref_index = 0;
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		btrfs_print_v0_err(eb->fs_info);
-		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
+		btrfs_err(eb->fs_info,
+			  "unexpected extent item size, has %u expect >= %zu",
+			  item_size, sizeof(*ei));
+		btrfs_handle_fs_error(eb->fs_info, -EUCLEAN, NULL);
 	}
 
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
@@ -291,10 +293,6 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			       btrfs_file_extent_num_bytes(l, fi),
 			       btrfs_file_extent_ram_bytes(l, fi));
 			break;
-		case BTRFS_EXTENT_REF_V0_KEY:
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, -EINVAL, NULL);
-			break;
 		case BTRFS_BLOCK_GROUP_ITEM_KEY:
 			bi = btrfs_item_ptr(l, i,
 					    struct btrfs_block_group_item);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5f4ff7d5b5c1..62ed57551824 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -466,6 +466,7 @@ static bool handle_useless_nodes(struct reloc_control *rc,
  * cached.
  */
 static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
+			struct btrfs_trans_handle *trans,
 			struct reloc_control *rc, struct btrfs_key *node_key,
 			int level, u64 bytenr)
 {
@@ -499,8 +500,8 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 
 	/* Breadth-first search to build backref cache */
 	do {
-		ret = btrfs_backref_add_tree_node(cache, path, iter, node_key,
-						  cur);
+		ret = btrfs_backref_add_tree_node(trans, cache, path, iter,
+						  node_key, cur);
 		if (ret < 0) {
 			err = ret;
 			goto out;
@@ -2803,7 +2804,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 
 	/* Do tree relocation */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
-		node = build_backref_tree(rc, &block->key,
+		node = build_backref_tree(trans, rc, &block->key,
 					  block->level, block->bytenr);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
@@ -3256,12 +3257,13 @@ static int add_tree_block(struct reloc_control *rc,
 			if (type == BTRFS_TREE_BLOCK_REF_KEY)
 				owner = btrfs_extent_inline_ref_offset(eb, iref);
 		}
-	} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-		btrfs_print_v0_err(eb->fs_info);
-		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
-		return -EINVAL;
 	} else {
-		BUG();
+		btrfs_print_leaf(eb);
+		btrfs_err(rc->block_group->fs_info,
+			  "unrecognized tree backref at tree block %llu slot %u",
+			  eb->start, path->slots[0]);
+		btrfs_release_path(path);
+		return -EUCLEAN;
 	}
 
 	btrfs_release_path(path);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2c9074ab2315..c7fdc19b0d5f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1781,6 +1781,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
@@ -1812,12 +1818,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 2d5e9a9d5b8b..fe1bf5b6e0cb 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -15,10 +15,12 @@
 static struct cached_fid *init_cached_dir(const char *path);
 static void free_cached_dir(struct cached_fid *cfid);
 static void smb2_close_cached_fid(struct kref *ref);
+static void cfids_laundromat_worker(struct work_struct *work);
 
 static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 						    const char *path,
-						    bool lookup_only)
+						    bool lookup_only,
+						    __u32 max_cached_dirs)
 {
 	struct cached_fid *cfid;
 
@@ -43,7 +45,7 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
-	if (cfids->num_entries >= MAX_CACHED_FIDS) {
+	if (cfids->num_entries >= max_cached_dirs) {
 		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
@@ -145,7 +147,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	const char *npath;
 
 	if (tcon == NULL || tcon->cfids == NULL || tcon->nohandlecache ||
-	    is_smb1_server(tcon->ses->server))
+	    is_smb1_server(tcon->ses->server) || (dir_cache_timeout == 0))
 		return -EOPNOTSUPP;
 
 	ses = tcon->ses;
@@ -162,21 +164,24 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	if (!utf16_path)
 		return -ENOMEM;
 
-	cfid = find_or_create_cached_dir(cfids, path, lookup_only);
+	cfid = find_or_create_cached_dir(cfids, path, lookup_only, tcon->max_cached_dirs);
 	if (cfid == NULL) {
 		kfree(utf16_path);
 		return -ENOENT;
 	}
 	/*
-	 * At this point we either have a lease already and we can just
-	 * return it. If not we are guaranteed to be the only thread accessing
-	 * this cfid.
+	 * Return cached fid if it has a lease.  Otherwise, it is either a new
+	 * entry or laundromat worker removed it from @cfids->entries.  Caller
+	 * will put last reference if the latter.
 	 */
+	spin_lock(&cfids->cfid_list_lock);
 	if (cfid->has_lease) {
+		spin_unlock(&cfids->cfid_list_lock);
 		*ret_cfid = cfid;
 		kfree(utf16_path);
 		return 0;
 	}
+	spin_unlock(&cfids->cfid_list_lock);
 
 	/*
 	 * Skip any prefix paths in @path as lookup_positive_unlocked() ends up
@@ -293,9 +298,11 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			goto oshr_free;
 		}
 	}
+	spin_lock(&cfids->cfid_list_lock);
 	cfid->dentry = dentry;
 	cfid->time = jiffies;
 	cfid->has_lease = true;
+	spin_unlock(&cfids->cfid_list_lock);
 
 oshr_free:
 	kfree(utf16_path);
@@ -304,24 +311,28 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
 	spin_lock(&cfids->cfid_list_lock);
-	if (rc && !cfid->has_lease) {
-		if (cfid->on_list) {
-			list_del(&cfid->entry);
-			cfid->on_list = false;
-			cfids->num_entries--;
+	if (!cfid->has_lease) {
+		if (rc) {
+			if (cfid->on_list) {
+				list_del(&cfid->entry);
+				cfid->on_list = false;
+				cfids->num_entries--;
+			}
+			rc = -ENOENT;
+		} else {
+			/*
+			 * We are guaranteed to have two references at this
+			 * point. One for the caller and one for a potential
+			 * lease. Release the Lease-ref so that the directory
+			 * will be closed when the caller closes the cached
+			 * handle.
+			 */
+			spin_unlock(&cfids->cfid_list_lock);
+			kref_put(&cfid->refcount, smb2_close_cached_fid);
+			goto out;
 		}
-		rc = -ENOENT;
 	}
 	spin_unlock(&cfids->cfid_list_lock);
-	if (!rc && !cfid->has_lease) {
-		/*
-		 * We are guaranteed to have two references at this point.
-		 * One for the caller and one for a potential lease.
-		 * Release the Lease-ref so that the directory will be closed
-		 * when the caller closes the cached handle.
-		 */
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
-	}
 	if (rc) {
 		if (cfid->is_open)
 			SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
@@ -329,7 +340,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		free_cached_dir(cfid);
 		cfid = NULL;
 	}
-
+out:
 	if (rc == 0) {
 		*ret_cfid = cfid;
 		atomic_inc(&tcon->num_remote_opens);
@@ -451,6 +462,9 @@ void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 	struct cached_fid *cfid, *q;
 	LIST_HEAD(entry);
 
+	if (cfids == NULL)
+		return;
+
 	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
 		list_move(&cfid->entry, &entry);
@@ -568,53 +582,51 @@ static void free_cached_dir(struct cached_fid *cfid)
 	kfree(cfid);
 }
 
-static int
-cifs_cfids_laundromat_thread(void *p)
+static void cfids_laundromat_worker(struct work_struct *work)
 {
-	struct cached_fids *cfids = p;
+	struct cached_fids *cfids;
 	struct cached_fid *cfid, *q;
-	struct list_head entry;
+	LIST_HEAD(entry);
 
-	while (!kthread_should_stop()) {
-		ssleep(1);
-		INIT_LIST_HEAD(&entry);
-		if (kthread_should_stop())
-			return 0;
-		spin_lock(&cfids->cfid_list_lock);
-		list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
-			if (time_after(jiffies, cfid->time + HZ * 30)) {
-				list_del(&cfid->entry);
-				list_add(&cfid->entry, &entry);
-				cfids->num_entries--;
-			}
-		}
-		spin_unlock(&cfids->cfid_list_lock);
+	cfids = container_of(work, struct cached_fids, laundromat_work.work);
 
-		list_for_each_entry_safe(cfid, q, &entry, entry) {
+	spin_lock(&cfids->cfid_list_lock);
+	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
+		if (cfid->time &&
+		    time_after(jiffies, cfid->time + HZ * dir_cache_timeout)) {
 			cfid->on_list = false;
-			list_del(&cfid->entry);
+			list_move(&cfid->entry, &entry);
+			cfids->num_entries--;
+			/* To prevent race with smb2_cached_lease_break() */
+			kref_get(&cfid->refcount);
+		}
+	}
+	spin_unlock(&cfids->cfid_list_lock);
+
+	list_for_each_entry_safe(cfid, q, &entry, entry) {
+		list_del(&cfid->entry);
+		/*
+		 * Cancel and wait for the work to finish in case we are racing
+		 * with it.
+		 */
+		cancel_work_sync(&cfid->lease_break);
+		if (cfid->has_lease) {
 			/*
-			 * Cancel, and wait for the work to finish in
-			 * case we are racing with it.
+			 * Our lease has not yet been cancelled from the server
+			 * so we need to drop the reference.
 			 */
-			cancel_work_sync(&cfid->lease_break);
-			if (cfid->has_lease) {
-				/*
-				 * We lease has not yet been cancelled from
-				 * the server so we need to drop the reference.
-				 */
-				spin_lock(&cfids->cfid_list_lock);
-				cfid->has_lease = false;
-				spin_unlock(&cfids->cfid_list_lock);
-				kref_put(&cfid->refcount, smb2_close_cached_fid);
-			}
+			spin_lock(&cfids->cfid_list_lock);
+			cfid->has_lease = false;
+			spin_unlock(&cfids->cfid_list_lock);
+			kref_put(&cfid->refcount, smb2_close_cached_fid);
 		}
+		/* Drop the extra reference opened above */
+		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
-
-	return 0;
+	queue_delayed_work(cifsiod_wq, &cfids->laundromat_work,
+			   dir_cache_timeout * HZ);
 }
 
-
 struct cached_fids *init_cached_dirs(void)
 {
 	struct cached_fids *cfids;
@@ -625,19 +637,10 @@ struct cached_fids *init_cached_dirs(void)
 	spin_lock_init(&cfids->cfid_list_lock);
 	INIT_LIST_HEAD(&cfids->entries);
 
-	/*
-	 * since we're in a cifs function already, we know that
-	 * this will succeed. No need for try_module_get().
-	 */
-	__module_get(THIS_MODULE);
-	cfids->laundromat = kthread_run(cifs_cfids_laundromat_thread,
-				  cfids, "cifsd-cfid-laundromat");
-	if (IS_ERR(cfids->laundromat)) {
-		cifs_dbg(VFS, "Failed to start cfids laundromat thread.\n");
-		kfree(cfids);
-		module_put(THIS_MODULE);
-		return NULL;
-	}
+	INIT_DELAYED_WORK(&cfids->laundromat_work, cfids_laundromat_worker);
+	queue_delayed_work(cifsiod_wq, &cfids->laundromat_work,
+			   dir_cache_timeout * HZ);
+
 	return cfids;
 }
 
@@ -650,11 +653,10 @@ void free_cached_dirs(struct cached_fids *cfids)
 	struct cached_fid *cfid, *q;
 	LIST_HEAD(entry);
 
-	if (cfids->laundromat) {
-		kthread_stop(cfids->laundromat);
-		cfids->laundromat = NULL;
-		module_put(THIS_MODULE);
-	}
+	if (cfids == NULL)
+		return;
+
+	cancel_delayed_work_sync(&cfids->laundromat_work);
 
 	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index facc9b154d00..81ba0fd5cc16 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -49,7 +49,7 @@ struct cached_fid {
 	struct cached_dirents dirents;
 };
 
-#define MAX_CACHED_FIDS 16
+/* default MAX_CACHED_FIDS is 16 */
 struct cached_fids {
 	/* Must be held when:
 	 * - accessing the cfids->entries list
@@ -57,7 +57,7 @@ struct cached_fids {
 	spinlock_t cfid_list_lock;
 	int num_entries;
 	struct list_head entries;
-	struct task_struct *laundromat;
+	struct delayed_work laundromat_work;
 };
 
 extern struct cached_fids *init_cached_dirs(void);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a4d8b0ea1c8c..e19df244ea7e 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -117,6 +117,10 @@ module_param(cifs_max_pending, uint, 0444);
 MODULE_PARM_DESC(cifs_max_pending, "Simultaneous requests to server for "
 				   "CIFS/SMB1 dialect (N/A for SMB3) "
 				   "Default: 32767 Range: 2 to 32767.");
+unsigned int dir_cache_timeout = 30;
+module_param(dir_cache_timeout, uint, 0644);
+MODULE_PARM_DESC(dir_cache_timeout, "Number of seconds to cache directory contents for which we have a lease. Default: 30 "
+				 "Range: 1 to 65000 seconds, 0 to disable caching dir contents");
 #ifdef CONFIG_CIFS_STATS2
 unsigned int slow_rsp_threshold = 1;
 module_param(slow_rsp_threshold, uint, 0644);
@@ -695,6 +699,8 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
 		seq_printf(s, ",snapshot=%llu", tcon->snapshot_time);
 	if (tcon->handle_timeout)
 		seq_printf(s, ",handletimeout=%u", tcon->handle_timeout);
+	if (tcon->max_cached_dirs != MAX_CACHED_FIDS)
+		seq_printf(s, ",max_cached_dirs=%u", tcon->max_cached_dirs);
 
 	/*
 	 * Display file and directory attribute timeout in seconds.
@@ -1679,6 +1685,12 @@ init_cifs(void)
 			 CIFS_MAX_REQ);
 	}
 
+	/* Limit max to about 18 hours, and setting to zero disables directory entry caching */
+	if (dir_cache_timeout > 65000) {
+		dir_cache_timeout = 65000;
+		cifs_dbg(VFS, "dir_cache_timeout set to max of 65000 seconds\n");
+	}
+
 	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
 	if (!cifsiod_wq) {
 		rc = -ENOMEM;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 35782a6bede0..ac68fed5ad28 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1192,6 +1192,7 @@ struct cifs_tcon {
 	__u32 max_chunks;
 	__u32 max_bytes_chunk;
 	__u32 max_bytes_copy;
+	__u32 max_cached_dirs;
 #ifdef CONFIG_CIFS_FSCACHE
 	u64 resource_id;		/* server resource id */
 	struct fscache_volume *fscache;	/* cookie for share */
@@ -1913,7 +1914,7 @@ require use of the stronger protocol */
  * cifsInodeInfo->lock_sem	cifsInodeInfo->llist		cifs_init_once
  *				->can_cache_brlcks
  * cifsInodeInfo->deferred_lock	cifsInodeInfo->deferred_closes	cifsInodeInfo_alloc
- * cached_fid->fid_mutex		cifs_tcon->crfid		tconInfoAlloc
+ * cached_fid->fid_mutex		cifs_tcon->crfid		tcon_info_alloc
  * cifsFileInfo->fh_mutex		cifsFileInfo			cifs_new_fileinfo
  * cifsFileInfo->file_info_lock	cifsFileInfo->count		cifs_new_fileinfo
  *				->invalidHandle			initiate_cifs_search
@@ -1987,6 +1988,7 @@ extern unsigned int CIFSMaxBufSize;  /* max size not including hdr */
 extern unsigned int cifs_min_rcv;    /* min size of big ntwrk buf pool */
 extern unsigned int cifs_min_small;  /* min size of small buf pool */
 extern unsigned int cifs_max_pending; /* MAX requests at once to server*/
+extern unsigned int dir_cache_timeout; /* max time for directory lease caching of dir */
 extern bool disable_legacy_dialects;  /* forbid vers=1.0 and vers=2.0 mounts */
 extern atomic_t mid_count;
 
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 1d71d658e167..bd0a1505719a 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -513,7 +513,7 @@ extern int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
 
 extern struct cifs_ses *sesInfoAlloc(void);
 extern void sesInfoFree(struct cifs_ses *);
-extern struct cifs_tcon *tconInfoAlloc(void);
+extern struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled);
 extern void tconInfoFree(struct cifs_tcon *);
 
 extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 352e251c4113..bd33661dcb57 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1882,7 +1882,8 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		}
 	}
 
-	tcon = tconInfoAlloc();
+	/* no need to setup directory caching on IPC share, so pass in false */
+	tcon = tcon_info_alloc(false);
 	if (tcon == NULL)
 		return -ENOMEM;
 
@@ -2473,8 +2474,9 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 static struct cifs_tcon *
 cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
-	int rc, xid;
 	struct cifs_tcon *tcon;
+	bool nohandlecache;
+	int rc, xid;
 
 	tcon = cifs_find_tcon(ses, ctx);
 	if (tcon) {
@@ -2492,11 +2494,17 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		goto out_fail;
 	}
 
-	tcon = tconInfoAlloc();
+	if (ses->server->dialect >= SMB20_PROT_ID &&
+	    (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING))
+		nohandlecache = ctx->nohandlecache;
+	else
+		nohandlecache = true;
+	tcon = tcon_info_alloc(!nohandlecache);
 	if (tcon == NULL) {
 		rc = -ENOMEM;
 		goto out_fail;
 	}
+	tcon->nohandlecache = nohandlecache;
 
 	if (ctx->snapshot_time) {
 		if (ses->server->vals->protocol_id == 0) {
@@ -2657,10 +2665,7 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->retry = ctx->retry;
 	tcon->nocase = ctx->nocase;
 	tcon->broken_sparse_sup = ctx->no_sparse;
-	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
-		tcon->nohandlecache = ctx->nohandlecache;
-	else
-		tcon->nohandlecache = true;
+	tcon->max_cached_dirs = ctx->max_cached_dirs;
 	tcon->nodelete = ctx->nodelete;
 	tcon->local_lease = ctx->local_lease;
 	INIT_LIST_HEAD(&tcon->pending_opens);
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index f12203c49b80..a3493da12ad1 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -150,6 +150,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_u32("closetimeo", Opt_closetimeo),
 	fsparam_u32("echo_interval", Opt_echo_interval),
 	fsparam_u32("max_credits", Opt_max_credits),
+	fsparam_u32("max_cached_dirs", Opt_max_cached_dirs),
 	fsparam_u32("handletimeout", Opt_handletimeout),
 	fsparam_u64("snapshot", Opt_snapshot),
 	fsparam_u32("max_channels", Opt_max_channels),
@@ -1165,6 +1166,14 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		if (result.uint_32 > 1)
 			ctx->multichannel = true;
 		break;
+	case Opt_max_cached_dirs:
+		if (result.uint_32 < 1) {
+			cifs_errorf(fc, "%s: Invalid max_cached_dirs, needs to be 1 or more\n",
+				    __func__);
+			goto cifs_parse_mount_err;
+		}
+		ctx->max_cached_dirs = result.uint_32;
+		break;
 	case Opt_handletimeout:
 		ctx->handle_timeout = result.uint_32;
 		if (ctx->handle_timeout > SMB3_MAX_HANDLE_TIMEOUT) {
@@ -1593,7 +1602,7 @@ int smb3_init_fs_context(struct fs_context *fc)
 	ctx->acregmax = CIFS_DEF_ACTIMEO;
 	ctx->acdirmax = CIFS_DEF_ACTIMEO;
 	ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
-
+	ctx->max_cached_dirs = MAX_CACHED_FIDS;
 	/* Most clients set timeout to 0, allows server to use its default */
 	ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
 
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index f4eaf8558902..9d8d34af0211 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -128,6 +128,7 @@ enum cifs_param {
 	Opt_closetimeo,
 	Opt_echo_interval,
 	Opt_max_credits,
+	Opt_max_cached_dirs,
 	Opt_snapshot,
 	Opt_max_channels,
 	Opt_handletimeout,
@@ -261,6 +262,7 @@ struct smb3_fs_context {
 	__u32 handle_timeout; /* persistent and durable handle timeout in ms */
 	unsigned int max_credits; /* smb3 max_credits 10 < credits < 60000 */
 	unsigned int max_channels;
+	unsigned int max_cached_dirs;
 	__u16 compression; /* compression algorithm 0xFFFF default 0=disabled */
 	bool rootfs:1; /* if it's a SMB root file system */
 	bool witness:1; /* use witness protocol */
@@ -287,7 +289,7 @@ extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
  */
 #define SMB3_MAX_DCLOSETIMEO (1 << 30)
 #define SMB3_DEF_DCLOSETIMEO (1 * HZ) /* even 1 sec enough to help eg open/write/close/open/read */
-
+#define MAX_CACHED_FIDS 16
 extern char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
 
 #endif
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index d7e85d9a2655..249fac8be5a5 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -113,18 +113,22 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 }
 
 struct cifs_tcon *
-tconInfoAlloc(void)
+tcon_info_alloc(bool dir_leases_enabled)
 {
 	struct cifs_tcon *ret_buf;
 
 	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (!ret_buf)
 		return NULL;
-	ret_buf->cfids = init_cached_dirs();
-	if (!ret_buf->cfids) {
-		kfree(ret_buf);
-		return NULL;
+
+	if (dir_leases_enabled == true) {
+		ret_buf->cfids = init_cached_dirs();
+		if (!ret_buf->cfids) {
+			kfree(ret_buf);
+			return NULL;
+		}
 	}
+	/* else ret_buf->cfids is already set to NULL above */
 
 	atomic_inc(&tconInfoAllocCount);
 	ret_buf->status = TID_NEW;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9c7e46b7e7c7..c22cc7222381 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3871,7 +3871,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		goto done;
 
 	/* allocate a dummy tcon struct used for reconnect */
-	tcon = tconInfoAlloc();
+	tcon = tcon_info_alloc(false);
 	if (!tcon) {
 		resched = true;
 		list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ca3c8e10f24a..2bb22c8ceb59 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -58,6 +58,7 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+	struct rw_semaphore rw_sema;
 #ifdef CONFIG_CGROUP_HUGETLB
 	/*
 	 * On private mappings, the counter to uncharge reservations is stored
@@ -1245,6 +1246,11 @@ static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
 }
 
+static inline bool __vma_private_lock(struct vm_area_struct *vma)
+{
+	return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data;
+}
+
 /*
  * Safe version of huge_pte_offset() to check the locks.  See comments
  * above huge_pte_offset().
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 4b998090898e..1d7aea634217 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4236,6 +4236,35 @@ static inline bool ieee80211_is_public_action(struct ieee80211_hdr *hdr,
 	return mgmt->u.action.category == WLAN_CATEGORY_PUBLIC;
 }
 
+/**
+ * ieee80211_is_protected_dual_of_public_action - check if skb contains a
+ * protected dual of public action management frame
+ * @skb: the skb containing the frame, length will be checked
+ *
+ * Return: true if the skb contains a protected dual of public action
+ * management frame, false otherwise.
+ */
+static inline bool
+ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
+{
+	u8 action;
+
+	if (!ieee80211_is_public_action((void *)skb->data, skb->len) ||
+	    skb->len < IEEE80211_MIN_ACTION_SIZE + 1)
+		return false;
+
+	action = *(u8 *)(skb->data + IEEE80211_MIN_ACTION_SIZE);
+
+	return action != WLAN_PUB_ACTION_20_40_BSS_COEX &&
+		action != WLAN_PUB_ACTION_DSE_REG_LOC_ANN &&
+		action != WLAN_PUB_ACTION_MSMT_PILOT &&
+		action != WLAN_PUB_ACTION_TDLS_DISCOVER_RES &&
+		action != WLAN_PUB_ACTION_LOC_TRACK_NOTI &&
+		action != WLAN_PUB_ACTION_FTM_REQUEST &&
+		action != WLAN_PUB_ACTION_FTM_RESPONSE &&
+		action != WLAN_PUB_ACTION_FILS_DISCOVERY;
+}
+
 /**
  * _ieee80211_is_group_privacy_action - check if frame is a group addressed
  * privacy action frame
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 819b6bc8ac08..045d7913a0f4 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -464,10 +464,10 @@ static inline void kasan_free_module_shadow(const struct vm_struct *vm) {}
 
 #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
-#ifdef CONFIG_KASAN_INLINE
+#ifdef CONFIG_KASAN
 void kasan_non_canonical_hook(unsigned long addr);
-#else /* CONFIG_KASAN_INLINE */
+#else /* CONFIG_KASAN */
 static inline void kasan_non_canonical_hook(unsigned long addr) { }
-#endif /* CONFIG_KASAN_INLINE */
+#endif /* CONFIG_KASAN */
 
 #endif /* LINUX_KASAN_H */
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d466e1a3b0b1..fe1507c1db82 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -53,6 +53,7 @@ struct nf_flowtable_type {
 	struct list_head		list;
 	int				family;
 	int				(*init)(struct nf_flowtable *ft);
+	bool				(*gc)(const struct flow_offload *flow);
 	int				(*setup)(struct nf_flowtable *ft,
 						 struct net_device *dev,
 						 enum flow_block_command cmd);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index fd41fdac0a8e..65e49fae8da7 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -162,8 +162,24 @@ struct scsi_device {
 				 * core. */
 	unsigned int eh_timeout; /* Error handling timeout */
 
-	bool manage_system_start_stop; /* Let HLD (sd) manage system start/stop */
-	bool manage_runtime_start_stop; /* Let HLD (sd) manage runtime start/stop */
+	/*
+	 * If true, let the high-level device driver (sd) manage the device
+	 * power state for system suspend/resume (suspend to RAM and
+	 * hibernation) operations.
+	 */
+	bool manage_system_start_stop;
+
+	/*
+	 * If true, let the high-level device driver (sd) manage the device
+	 * power state for runtime device suspand and resume operations.
+	 */
+	bool manage_runtime_start_stop;
+
+	/*
+	 * If true, let the high-level device driver (sd) manage the device
+	 * power state for system shutdown (power off) operations.
+	 */
+	bool manage_shutdown;
 
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index a8206f5332e9..da0734b182f2 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -38,7 +38,6 @@ struct find_free_extent_ctl;
 	__print_symbolic(type,						\
 		{ BTRFS_TREE_BLOCK_REF_KEY, 	"TREE_BLOCK_REF" },	\
 		{ BTRFS_EXTENT_DATA_REF_KEY, 	"EXTENT_DATA_REF" },	\
-		{ BTRFS_EXTENT_REF_V0_KEY, 	"EXTENT_REF_V0" },	\
 		{ BTRFS_SHARED_BLOCK_REF_KEY, 	"SHARED_BLOCK_REF" },	\
 		{ BTRFS_SHARED_DATA_REF_KEY, 	"SHARED_DATA_REF" })
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ab38d0f411fa..fc3c32186d7e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -220,7 +220,11 @@
 
 #define BTRFS_EXTENT_DATA_REF_KEY	178
 
-#define BTRFS_EXTENT_REF_V0_KEY		180
+/*
+ * Obsolete key. Defintion removed in 6.6, value may be reused in the future.
+ *
+ * #define BTRFS_EXTENT_REF_V0_KEY	180
+ */
 
 #define BTRFS_SHARED_BLOCK_REF_KEY	182
 
diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index 2f61298a7b77..3dcdb9e33cba 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -33,6 +33,6 @@ enum gtp_attrs {
 	GTPA_PAD,
 	__GTPA_MAX,
 };
-#define GTPA_MAX (__GTPA_MAX + 1)
+#define GTPA_MAX (__GTPA_MAX - 1)
 
 #endif /* _UAPI_LINUX_GTP_H_ */
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 76c279b13aee..b603a06f7103 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -49,7 +49,6 @@ static __cold int io_uring_show_cred(struct seq_file *m, unsigned int id,
 static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 					  struct seq_file *m)
 {
-	struct io_sq_data *sq = NULL;
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
@@ -60,6 +59,7 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 	unsigned int cq_shift = 0;
 	unsigned int sq_shift = 0;
 	unsigned int sq_entries, cq_entries;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	unsigned int i;
 
@@ -137,13 +137,19 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 	has_lock = mutex_trylock(&ctx->uring_lock);
 
 	if (has_lock && (ctx->flags & IORING_SETUP_SQPOLL)) {
-		sq = ctx->sq_data;
-		if (!sq->thread)
-			sq = NULL;
+		struct io_sq_data *sq = ctx->sq_data;
+
+		if (mutex_trylock(&sq->lock)) {
+			if (sq->thread) {
+				sq_pid = task_pid_nr(sq->thread);
+				sq_cpu = task_cpu(sq->thread);
+			}
+			mutex_unlock(&sq->lock);
+		}
 	}
 
-	seq_printf(m, "SqThread:\t%d\n", sq ? task_pid_nr(sq->thread) : -1);
-	seq_printf(m, "SqThreadCpu:\t%d\n", sq ? task_cpu(sq->thread) : -1);
+	seq_printf(m, "SqThread:\t%d\n", sq_pid);
+	seq_printf(m, "SqThreadCpu:\t%d\n", sq_cpu);
 	seq_printf(m, "UserFiles:\t%u\n", ctx->nr_user_files);
 	for (i = 0; has_lock && i < ctx->nr_user_files; i++) {
 		struct file *f = io_file_from_index(&ctx->file_table, i);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b3d800738fc5..f2f4d2b3beee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13383,7 +13383,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 92dbb21c6961..c63e25cb9406 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
 	return 0;
 }
 
+struct sym_count_ctx {
+	unsigned int count;
+	const char *name;
+};
+
+static int count_mod_symbols(void *data, const char *name, unsigned long unused)
+{
+	struct sym_count_ctx *ctx = data;
+
+	if (strcmp(name, ctx->name) == 0)
+		ctx->count++;
+
+	return 0;
+}
+
 static unsigned int number_of_same_symbols(char *func_name)
 {
-	unsigned int count;
+	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
+
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
-	count = 0;
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
 
-	return count;
+	return ctx.count;
 }
 
 static int __trace_kprobe_create(int argc, const char *argv[])
@@ -1006,7 +1022,7 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
  * @kretprobe: Is this a return probe?
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
@@ -1079,7 +1095,7 @@ EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
 /**
  * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_add_fields() wrapper, which
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b2f1c90c18fa..20923e03aa35 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5729,7 +5729,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Internal nodes */
 	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
 	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count(mas, nr_nodes + 3);
+	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
 
 	/* Detect if allocations run out */
 	mas->mas_flags |= MA_STATE_PREALLOC;
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 4e7fd364f0f1..e310e1c7a540 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -9,6 +9,7 @@
 
 #include <linux/maple_tree.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
 #define CONFIG_MAPLE_SEARCH
@@ -1714,17 +1715,21 @@ static noinline void __init check_forking(struct maple_tree *mt)
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, mt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
 				  xa_mk_value(i), GFP_KERNEL);
 
 	mt_set_non_kernel(99999);
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&newmt, &newmt_lock);
 	newmas.tree = &newmt;
 	mas_reset(&newmas);
 	mas_reset(&mas);
-	mas_lock(&newmas);
+	down_write(&newmt_lock);
 	mas.index = 0;
 	mas.last = 0;
 	if (mas_expected_entries(&newmas, nr_entries)) {
@@ -1739,10 +1744,10 @@ static noinline void __init check_forking(struct maple_tree *mt)
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
-	mas_unlock(&newmas);
 	mt_validate(&newmt);
 	mt_set_non_kernel(0);
-	mtree_destroy(&newmt);
+	__mt_destroy(&newmt);
+	up_write(&newmt_lock);
 }
 
 static noinline void __init check_iteration(struct maple_tree *mt)
@@ -1853,6 +1858,10 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, mt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
+	mt_set_external_lock(&newmt, &newmt_lock);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
@@ -1867,7 +1876,7 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 		mas.index = 0;
 		mas.last = 0;
 		rcu_read_lock();
-		mas_lock(&newmas);
+		down_write(&newmt_lock);
 		if (mas_expected_entries(&newmas, nr_entries)) {
 			printk("OOM!");
 			BUG_ON(1);
@@ -1878,11 +1887,11 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 			mas_store(&newmas, val);
 		}
 		mas_destroy(&newmas);
-		mas_unlock(&newmas);
 		rcu_read_unlock();
 		mt_validate(&newmt);
 		mt_set_non_kernel(0);
-		mtree_destroy(&newmt);
+		__mt_destroy(&newmt);
+		up_write(&newmt_lock);
 	}
 }
 #endif
@@ -2489,6 +2498,10 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 	void *tmp;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, &newmt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
+	mt_set_external_lock(&newmt, &newmt_lock);
 
 	if (!zero_start)
 		i = 1;
@@ -2498,9 +2511,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 		mtree_store_range(mt, i*10, (i+1)*10 - gap,
 				  xa_mk_value(i), GFP_KERNEL);
 
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
 	mt_set_non_kernel(99999);
-	mas_lock(&newmas);
+	down_write(&newmt_lock);
 	ret = mas_expected_entries(&newmas, nr_entries);
 	mt_set_non_kernel(0);
 	MT_BUG_ON(mt, ret != 0);
@@ -2513,9 +2526,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
-	mas_unlock(&newmas);
 
-	mtree_destroy(&newmt);
+	__mt_destroy(&newmt);
+	up_write(&newmt_lock);
 }
 
 /* Duplicate many sizes of trees.  Mainly to test expected entry values */
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 33e1d5c9cb54..df165820c605 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1202,6 +1202,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1209,10 +1211,12 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 
 	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
 	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (kdamond && damon_sysfs_cmd_request.cmd ==
+	if (kdamond && (damon_sysfs_cmd_request.cmd ==
 			DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS &&
+			damon_sysfs_schemes_regions_updating) &&
 			ctx == kdamond->damon_ctx) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
+		damon_sysfs_schemes_regions_updating = false;
 		mutex_unlock(&damon_sysfs_lock);
 	}
 
@@ -1331,7 +1335,6 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6da626bfb52e..097b81c37597 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -96,6 +96,7 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
+static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -266,6 +267,10 @@ void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		down_read(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		down_read(&resv_map->rw_sema);
 	}
 }
 
@@ -275,6 +280,10 @@ void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		up_read(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		up_read(&resv_map->rw_sema);
 	}
 }
 
@@ -284,6 +293,10 @@ void hugetlb_vma_lock_write(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		down_write(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		down_write(&resv_map->rw_sema);
 	}
 }
 
@@ -293,17 +306,27 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		up_write(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		up_write(&resv_map->rw_sema);
 	}
 }
 
 int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
 {
-	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-	if (!__vma_shareable_lock(vma))
-		return 1;
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-	return down_write_trylock(&vma_lock->rw_sema);
+		return down_write_trylock(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		return down_write_trylock(&resv_map->rw_sema);
+	}
+
+	return 1;
 }
 
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
@@ -312,6 +335,10 @@ void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		lockdep_assert_held(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		lockdep_assert_held(&resv_map->rw_sema);
 	}
 }
 
@@ -344,6 +371,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		__hugetlb_vma_unlock_write_put(vma_lock);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		/* no free for anon vmas, but still need to unlock */
+		up_write(&resv_map->rw_sema);
 	}
 }
 
@@ -1062,6 +1094,7 @@ struct resv_map *resv_map_alloc(void)
 	kref_init(&resv_map->refs);
 	spin_lock_init(&resv_map->lock);
 	INIT_LIST_HEAD(&resv_map->regions);
+	init_rwsem(&resv_map->rw_sema);
 
 	resv_map->adds_in_progress = 0;
 	/*
@@ -1132,8 +1165,7 @@ static void set_vma_resv_map(struct vm_area_struct *vma, struct resv_map *map)
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
 
-	set_vma_private_data(vma, (get_vma_private_data(vma) &
-				HPAGE_RESV_MASK) | (unsigned long)map);
+	set_vma_private_data(vma, (unsigned long)map);
 }
 
 static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
@@ -7015,8 +7047,10 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
+		set_vma_resv_map(vma, NULL);
+	}
 	return false;
 }
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ca4b6ff080a6..3974e4549c3e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -621,9 +621,8 @@ void kasan_report_async(void)
 }
 #endif /* CONFIG_KASAN_HW_TAGS */
 
-#ifdef CONFIG_KASAN_INLINE
 /*
- * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
+ * With CONFIG_KASAN, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
  * before the actual access. For addresses in the low canonical half of the
  * address space, as well as most non-canonical addresses, that out-of-bounds
@@ -659,4 +658,3 @@ void kasan_non_canonical_hook(unsigned long addr)
 	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
 		 orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
 }
-#endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 071edec3dca2..7d82355ad0b3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1543,8 +1543,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		 * the home node for vmas we already updated before.
 		 */
 		old = vma_policy(vma);
-		if (!old)
+		if (!old) {
+			prev = vma;
 			continue;
+		}
 		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
 			err = -EOPNOTSUPP;
 			break;
diff --git a/mm/migrate.c b/mm/migrate.c
index 24baad2571e3..0e5cce8e8bb4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2160,6 +2160,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			 const int __user *nodes,
 			 int __user *status, int flags)
 {
+	compat_uptr_t __user *compat_pages = (void __user *)pages;
 	int current_node = NUMA_NO_NODE;
 	LIST_HEAD(pagelist);
 	int start, i;
@@ -2172,8 +2173,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		int node;
 
 		err = -EFAULT;
-		if (get_user(p, pages + i))
-			goto out_flush;
+		if (in_compat_syscall()) {
+			compat_uptr_t cp;
+
+			if (get_user(cp, compat_pages + i))
+				goto out_flush;
+
+			p = compat_ptr(cp);
+		} else {
+			if (get_user(p, pages + i))
+				goto out_flush;
+		}
 		if (get_user(node, nodes + i))
 			goto out_flush;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 3937479d0e07..6d25c619911f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3136,13 +3136,13 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (!len)
 		return 0;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) != 0)
 		return -EINVAL;
 
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
 	ret = check_brk_limits(addr, len);
 	if (ret)
 		goto limits_failed;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d322bfae8f69..f9a6a42f7801 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6528,6 +6528,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			next_page = page;
 			current_buddy = page + size;
 		}
+		page = next_page;
 
 		if (set_page_guard(zone, current_buddy, high, migratetype))
 			continue;
@@ -6535,7 +6536,6 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 		if (current_buddy != target) {
 			add_to_free_list(current_buddy, zone, high, migratetype);
 			set_buddy_order(current_buddy, high);
-			page = next_page;
 		}
 	}
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f16ec0e8a034..4a1d669b46f9 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -251,7 +251,8 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
-	int max_clean = atomic_read(&tbl->gc_entries) - tbl->gc_thresh2;
+	int max_clean = atomic_read(&tbl->gc_entries) -
+			READ_ONCE(tbl->gc_thresh2);
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
@@ -280,7 +281,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 		}
 	}
 
-	tbl->last_flush = jiffies;
+	WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
@@ -464,17 +465,17 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl,
 {
 	struct neighbour *n = NULL;
 	unsigned long now = jiffies;
-	int entries;
+	int entries, gc_thresh3;
 
 	if (exempt_from_gc)
 		goto do_alloc;
 
 	entries = atomic_inc_return(&tbl->gc_entries) - 1;
-	if (entries >= tbl->gc_thresh3 ||
-	    (entries >= tbl->gc_thresh2 &&
-	     time_after(now, tbl->last_flush + 5 * HZ))) {
-		if (!neigh_forced_gc(tbl) &&
-		    entries >= tbl->gc_thresh3) {
+	gc_thresh3 = READ_ONCE(tbl->gc_thresh3);
+	if (entries >= gc_thresh3 ||
+	    (entries >= READ_ONCE(tbl->gc_thresh2) &&
+	     time_after(now, READ_ONCE(tbl->last_flush) + 5 * HZ))) {
+		if (!neigh_forced_gc(tbl) && entries >= gc_thresh3) {
 			net_info_ratelimited("%s: neighbor table overflow!\n",
 					     tbl->id);
 			NEIGH_CACHE_STAT_INC(tbl, table_fulls);
@@ -955,13 +956,14 @@ static void neigh_periodic_work(struct work_struct *work)
 
 	if (time_after(jiffies, tbl->last_rand + 300 * HZ)) {
 		struct neigh_parms *p;
-		tbl->last_rand = jiffies;
+
+		WRITE_ONCE(tbl->last_rand, jiffies);
 		list_for_each_entry(p, &tbl->parms_list, list)
 			p->reachable_time =
 				neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
 	}
 
-	if (atomic_read(&tbl->entries) < tbl->gc_thresh1)
+	if (atomic_read(&tbl->entries) < READ_ONCE(tbl->gc_thresh1))
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
@@ -2167,15 +2169,16 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 	ndtmsg->ndtm_pad2   = 0;
 
 	if (nla_put_string(skb, NDTA_NAME, tbl->id) ||
-	    nla_put_msecs(skb, NDTA_GC_INTERVAL, tbl->gc_interval, NDTA_PAD) ||
-	    nla_put_u32(skb, NDTA_THRESH1, tbl->gc_thresh1) ||
-	    nla_put_u32(skb, NDTA_THRESH2, tbl->gc_thresh2) ||
-	    nla_put_u32(skb, NDTA_THRESH3, tbl->gc_thresh3))
+	    nla_put_msecs(skb, NDTA_GC_INTERVAL, READ_ONCE(tbl->gc_interval),
+			  NDTA_PAD) ||
+	    nla_put_u32(skb, NDTA_THRESH1, READ_ONCE(tbl->gc_thresh1)) ||
+	    nla_put_u32(skb, NDTA_THRESH2, READ_ONCE(tbl->gc_thresh2)) ||
+	    nla_put_u32(skb, NDTA_THRESH3, READ_ONCE(tbl->gc_thresh3)))
 		goto nla_put_failure;
 	{
 		unsigned long now = jiffies;
-		long flush_delta = now - tbl->last_flush;
-		long rand_delta = now - tbl->last_rand;
+		long flush_delta = now - READ_ONCE(tbl->last_flush);
+		long rand_delta = now - READ_ONCE(tbl->last_rand);
 		struct neigh_hash_table *nht;
 		struct ndt_config ndc = {
 			.ndtc_key_len		= tbl->key_len,
@@ -2183,7 +2186,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_entries		= atomic_read(&tbl->entries),
 			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
 			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
-			.ndtc_proxy_qlen	= tbl->proxy_queue.qlen,
+			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
 		};
 
 		rcu_read_lock();
@@ -2206,17 +2209,17 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			struct neigh_statistics	*st;
 
 			st = per_cpu_ptr(tbl->stats, cpu);
-			ndst.ndts_allocs		+= st->allocs;
-			ndst.ndts_destroys		+= st->destroys;
-			ndst.ndts_hash_grows		+= st->hash_grows;
-			ndst.ndts_res_failed		+= st->res_failed;
-			ndst.ndts_lookups		+= st->lookups;
-			ndst.ndts_hits			+= st->hits;
-			ndst.ndts_rcv_probes_mcast	+= st->rcv_probes_mcast;
-			ndst.ndts_rcv_probes_ucast	+= st->rcv_probes_ucast;
-			ndst.ndts_periodic_gc_runs	+= st->periodic_gc_runs;
-			ndst.ndts_forced_gc_runs	+= st->forced_gc_runs;
-			ndst.ndts_table_fulls		+= st->table_fulls;
+			ndst.ndts_allocs		+= READ_ONCE(st->allocs);
+			ndst.ndts_destroys		+= READ_ONCE(st->destroys);
+			ndst.ndts_hash_grows		+= READ_ONCE(st->hash_grows);
+			ndst.ndts_res_failed		+= READ_ONCE(st->res_failed);
+			ndst.ndts_lookups		+= READ_ONCE(st->lookups);
+			ndst.ndts_hits			+= READ_ONCE(st->hits);
+			ndst.ndts_rcv_probes_mcast	+= READ_ONCE(st->rcv_probes_mcast);
+			ndst.ndts_rcv_probes_ucast	+= READ_ONCE(st->rcv_probes_ucast);
+			ndst.ndts_periodic_gc_runs	+= READ_ONCE(st->periodic_gc_runs);
+			ndst.ndts_forced_gc_runs	+= READ_ONCE(st->forced_gc_runs);
+			ndst.ndts_table_fulls		+= READ_ONCE(st->table_fulls);
 		}
 
 		if (nla_put_64bit(skb, NDTA_STATS, sizeof(ndst), &ndst,
@@ -2445,16 +2448,16 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout_tbl_lock;
 
 	if (tb[NDTA_THRESH1])
-		tbl->gc_thresh1 = nla_get_u32(tb[NDTA_THRESH1]);
+		WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
 
 	if (tb[NDTA_THRESH2])
-		tbl->gc_thresh2 = nla_get_u32(tb[NDTA_THRESH2]);
+		WRITE_ONCE(tbl->gc_thresh2, nla_get_u32(tb[NDTA_THRESH2]));
 
 	if (tb[NDTA_THRESH3])
-		tbl->gc_thresh3 = nla_get_u32(tb[NDTA_THRESH3]);
+		WRITE_ONCE(tbl->gc_thresh3, nla_get_u32(tb[NDTA_THRESH3]));
 
 	if (tb[NDTA_GC_INTERVAL])
-		tbl->gc_interval = nla_get_msecs(tb[NDTA_GC_INTERVAL]);
+		WRITE_ONCE(tbl->gc_interval, nla_get_msecs(tb[NDTA_GC_INTERVAL]));
 
 	err = 0;
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index d0bc1dd8e65a..80c7302692c7 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -87,29 +87,6 @@ struct nlmsghdr *handshake_genl_put(struct sk_buff *msg,
 }
 EXPORT_SYMBOL(handshake_genl_put);
 
-/*
- * dup() a kernel socket for use as a user space file descriptor
- * in the current process. The kernel socket must have an
- * instatiated struct file.
- *
- * Implicit argument: "current()"
- */
-static int handshake_dup(struct socket *sock)
-{
-	struct file *file;
-	int newfd;
-
-	file = get_file(sock->file);
-	newfd = get_unused_fd_flags(O_CLOEXEC);
-	if (newfd < 0) {
-		fput(file);
-		return newfd;
-	}
-
-	fd_install(newfd, file);
-	return newfd;
-}
-
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = sock_net(skb->sk);
@@ -133,17 +110,20 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_status;
 
 	sock = req->hr_sk->sk_socket;
-	fd = handshake_dup(sock);
+	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		err = fd;
 		goto out_complete;
 	}
+
 	err = req->hr_proto->hp_accept(req, info, fd);
 	if (err) {
-		fput(sock->file);
+		put_unused_fd(fd);
 		goto out_complete;
 	}
 
+	fd_install(fd, get_file(sock->file));
+
 	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
 	return 0;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9bdc1b2eaf73..a0a87446f827 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -925,10 +925,11 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 	return mss_now;
 }
 
-/* In some cases, both sendmsg() could have added an skb to the write queue,
- * but failed adding payload on it.  We need to remove it to consume less
+/* In some cases, sendmsg() could have added an skb to the write queue,
+ * but failed adding payload on it. We need to remove it to consume less
  * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
- * epoll() users.
+ * epoll() users. Another reason is that tcp_write_xmit() does not like
+ * finding an empty skb in the write queue.
  */
 void tcp_remove_empty_skb(struct sock *sk)
 {
@@ -1286,6 +1287,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 wait_for_space:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		tcp_remove_empty_skb(sk);
 		if (copied)
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a5781f86ac37..7d544f965b26 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2202,16 +2202,17 @@ void tcp_enter_loss(struct sock *sk)
  * restore sanity to the SACK scoreboard. If the apparent reneging
  * persists until this RTO then we'll clear the SACK scoreboard.
  */
-static bool tcp_check_sack_reneging(struct sock *sk, int flag)
+static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 {
-	if (flag & FLAG_SACK_RENEGING &&
-	    flag & FLAG_SND_UNA_ADVANCED) {
+	if (*ack_flag & FLAG_SACK_RENEGING &&
+	    *ack_flag & FLAG_SND_UNA_ADVANCED) {
 		struct tcp_sock *tp = tcp_sk(sk);
 		unsigned long delay = max(usecs_to_jiffies(tp->srtt_us >> 4),
 					  msecs_to_jiffies(10));
 
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 					  delay, TCP_RTO_MAX);
+		*ack_flag &= ~FLAG_SET_XMIT_TIMER;
 		return true;
 	}
 	return false;
@@ -2981,7 +2982,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		tp->prior_ssthresh = 0;
 
 	/* B. In all the states check for reneging SACKs. */
-	if (tcp_check_sack_reneging(sk, flag))
+	if (tcp_check_sack_reneging(sk, ack_flag))
 		return;
 
 	/* C. Check consistency of the current state. */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e751cda5eef6..8f6b6f56b65b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2468,8 +2468,7 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 
 		/* drop unicast public action frames when using MPF */
 		if (is_unicast_ether_addr(mgmt->da) &&
-		    ieee80211_is_public_action((void *)rx->skb->data,
-					       rx->skb->len))
+		    ieee80211_is_protected_dual_of_public_action(rx->skb))
 			return -EACCES;
 	}
 
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 1d34d700bd09..920a5a29ae1d 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -316,12 +316,6 @@ void flow_offload_refresh(struct nf_flowtable *flow_table,
 }
 EXPORT_SYMBOL_GPL(flow_offload_refresh);
 
-static bool nf_flow_is_outdated(const struct flow_offload *flow)
-{
-	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
-		!test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
-}
-
 static inline bool nf_flow_has_expired(const struct flow_offload *flow)
 {
 	return nf_flow_timeout_delta(flow->timeout) <= 0;
@@ -407,12 +401,18 @@ nf_flow_table_iterate(struct nf_flowtable *flow_table,
 	return err;
 }
 
+static bool nf_flow_custom_gc(struct nf_flowtable *flow_table,
+			      const struct flow_offload *flow)
+{
+	return flow_table->type->gc && flow_table->type->gc(flow);
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
-	    nf_flow_is_outdated(flow))
+	    nf_flow_custom_gc(flow_table, flow))
 		flow_offload_teardown(flow);
 
 	if (test_bit(NF_FLOW_TEARDOWN, &flow->flags)) {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index abc71a06d634..ad7c95545378 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -278,7 +278,16 @@ static int tcf_ct_flow_table_fill_actions(struct net *net,
 	return err;
 }
 
+static bool tcf_ct_flow_is_outdated(const struct flow_offload *flow)
+{
+	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
+	       test_bit(IPS_HW_OFFLOAD_BIT, &flow->ct->status) &&
+	       !test_bit(NF_FLOW_HW_PENDING, &flow->flags) &&
+	       !test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
+}
+
 static struct nf_flowtable_type flowtable_ct = {
+	.gc		= tcf_ct_flow_is_outdated,
 	.action		= tcf_ct_flow_table_fill_actions,
 	.owner		= THIS_MODULE,
 };
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index e95df847176b..b80bf681327b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -555,6 +555,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 
 	virtio_device_ready(vdev);
 
+	return 0;
+}
+
+static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
+{
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
@@ -569,7 +574,16 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
-	return 0;
+	/* virtio_transport_send_pkt() can queue packets once
+	 * the_virtio_vsock is set, but they won't be processed until
+	 * vsock->tx_run is set to true. We queue vsock->send_pkt_work
+	 * when initialization finishes to send those packets queued
+	 * earlier.
+	 * We don't need to queue the other workers (rx, event) because
+	 * as long as we don't fill the queues with empty buffers, the
+	 * host can't send us any notification.
+	 */
+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
 }
 
 static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
@@ -664,6 +678,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 		goto out;
 
 	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
 
@@ -736,6 +751,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
 		goto out;
 
 	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
 
 out:
 	mutex_unlock(&the_virtio_vsock_mutex);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3e2c398abddc..55a1d3633853 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -43,10 +43,11 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 
 	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
 		cr.links[link_id].status = data->links[link_id].status;
+		cr.links[link_id].bss = data->links[link_id].bss;
+
 		WARN_ON_ONCE(cr.links[link_id].status != WLAN_STATUS_SUCCESS &&
 			     (!cr.ap_mld_addr || !cr.links[link_id].bss));
 
-		cr.links[link_id].bss = data->links[link_id].bss;
 		if (!cr.links[link_id].bss)
 			continue;
 		cr.links[link_id].bssid = data->links[link_id].bss->bssid;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 939deecf0bbe..8210a6090ac1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2125,7 +2125,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	if (!res)
 		goto drop;
 
-	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
+	rdev_inform_bss(rdev, &res->pub, ies, drv_data->drv_data);
 
 	if (data->bss_source == BSS_SOURCE_MBSSID) {
 		/* this is a nontransmitting bss, we need to add it to
diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
new file mode 100644
index 000000000000..83971b3cbfce
--- /dev/null
+++ b/tools/include/linux/rwsem.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _TOOLS__RWSEM_H
+#define _TOOLS__RWSEM_H
+
+#include <pthread.h>
+
+struct rw_semaphore {
+	pthread_rwlock_t lock;
+};
+
+static inline int init_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_init(&sem->lock, NULL);
+}
+
+static inline int exit_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_destroy(&sem->lock);
+}
+
+static inline int down_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_rdlock(&sem->lock);
+}
+
+static inline int up_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+
+static inline int down_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_wrlock(&sem->lock);
+}
+
+static inline int up_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+#endif /* _TOOLS_RWSEM_H */
diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index ca2359835e75..a06e73ec8568 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -7,6 +7,7 @@
  */
 #define _GNU_SOURCE
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
