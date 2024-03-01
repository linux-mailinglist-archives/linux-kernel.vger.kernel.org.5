Return-Path: <linux-kernel+bounces-88453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D729C86E1D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3891F21F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36AA71B5E;
	Fri,  1 Mar 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ij4YOhgf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E570CAE;
	Fri,  1 Mar 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298965; cv=none; b=QGn7xv4F8tQSa4kVgY12Cj3qyVQWaJdA2ygHrNxYWgBe0RimmEEM/RQyDVLp8sbeUkuKf7j7w7jjdEEtI8hybFLlPOvMmvD9NL26/8JR/98JKCb7sR9Jgf+P8shrJWNRi848VpkQ34WaaDQGoH8dxvPXERD4Apu7SzNTLra/9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298965; c=relaxed/simple;
	bh=TXukW+fxZ2+dp+YPRd3eN50wKAVEEeH8eTH88vBK6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqLjY0UUi2W4FVQ0+YUF3J7h+4R68xIK3ONHzQYWZj1gf4EGvcqWpXM5yNnJuD+l9v2ZeO06X3tTpzpkZ8x2RTBPtd6kLro6c3kkVqwf0IAFj6B5zPOrcvIRF7hjD6XX+XaohP+9DOmWXxKyix3x6LGD6ibT1g6gIKHlFs5+xKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ij4YOhgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97645C433C7;
	Fri,  1 Mar 2024 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298964;
	bh=TXukW+fxZ2+dp+YPRd3eN50wKAVEEeH8eTH88vBK6pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ij4YOhgf/TNulLTxfX6fHxnDdmIH9wFdYLcG/CU3Z5DnSALs7AtzSB91OfFjnLrO6
	 2ukOG6rjdsxwuiQgOpD7vCVjk+R3I/W0enxlababFnv6j2EWWL8Mvl81VFTONAluOy
	 y0EqJX8cf5rxIyegu17G6EjB3QlALqMaY/JLM3og=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.150
Date: Fri,  1 Mar 2024 14:15:52 +0100
Message-ID: <2024030152-wispy-untoasted-98d0@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030152-unwatched-mug-892a@gregkh>
References: <2024030152-unwatched-mug-892a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 04885738cf15..0f8f0772d6f3 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -57,3 +57,12 @@ Description:
 			* 0 - default,
 			* 1 - overboost,
 			* 2 - silent
+
+What:		/sys/devices/platform/<platform>/dgpu_disable
+Date:		Aug 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Disable discrete GPU:
+			* 0 - Enable dGPU,
+			* 1 - Disable dGPU
diff --git a/Makefile b/Makefile
index e0f0677c1bbb..9f13ca515fd2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 149
+SUBLEVEL = 150
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 00e688b45d98..5901160919dc 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -26,7 +26,6 @@ leds {
 		wlan {
 			label = "bcm53xx:blue:wlan";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		system {
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 78c80a5d3f4f..8e7483272d47 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -26,7 +26,6 @@ leds {
 		5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		system {
@@ -42,7 +41,6 @@ pcie0_leds {
 		2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 933b6a380c36..eed1a6147f0b 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -159,8 +159,6 @@ ehci_port2: port@2 {
 			};
 
 			ohci: usb@d000 {
-				#usb-cells = <0>;
-
 				compatible = "generic-ohci";
 				reg = <0xd000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -183,6 +181,24 @@ ohci_port2: port@2 {
 
 		gmac0: ethernet@5000 {
 			reg = <0x5000 0x1000>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switch: switch@1e {
+					compatible = "brcm,bcm53125";
+					reg = <0x1e>;
+
+					status = "disabled";
+
+					/* ports are defined in board DTS */
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+			};
 		};
 
 		gmac1: ethernet@b000 {
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 4659132a0509..38722aec802a 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -337,6 +337,7 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 5200d0bbd9e9..b2dae28a9850 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -585,6 +585,7 @@ spi0: spi@ff1d0000 {
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac 12>, <&dmac 13>;
 		dma-names = "tx", "rx";
+		num-cs = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_csn &spi0_miso &spi0_mosi>;
 		#address-cells = <1>;
@@ -600,6 +601,7 @@ spi1: spi@ff1d8000 {
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac 14>, <&dmac 15>;
 		dma-names = "tx", "rx";
+		num-cs = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_csn0 &spi1_csn1 &spi1_miso &spi1_mosi>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 8b70e831aff2..382bb0734cb7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -36,6 +36,29 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	sound {
+		compatible = "audio-graph-card";
+		label = "Analog";
+		dais = <&i2s0_p0>;
+	};
+
+	sound-dit {
+		compatible = "audio-graph-card";
+		label = "SPDIF";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
+
 	vcc12v_dcin: dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -98,24 +121,25 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vbus_typec: vbus-typec-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_typec_en>;
-		regulator-name = "vcc5v0_typec";
+		regulator-name = "vbus_typec";
 		regulator-always-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc_lan: vcc3v3-phy-regulator {
+	vcc3v3_lan: vcc3v3-lan-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_lan";
+		regulator-name = "vcc3v3_lan";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
 	};
 
 	vdd_log: vdd-log {
@@ -162,7 +186,7 @@ &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
 	clock_in_out = "input";
-	phy-supply = <&vcc_lan>;
+	phy-supply = <&vcc3v3_lan>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -267,8 +291,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc1v8_codec: LDO_REG1 {
-				regulator-name = "vcc1v8_codec";
+			vcca1v8_codec: LDO_REG1 {
+				regulator-name = "vcca1v8_codec";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -278,8 +302,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc1v8_hdmi: LDO_REG2 {
-				regulator-name = "vcc1v8_hdmi";
+			vcca1v8_hdmi: LDO_REG2 {
+				regulator-name = "vcca1v8_hdmi";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -336,8 +360,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc0v9_hdmi: LDO_REG7 {
-				regulator-name = "vcc0v9_hdmi";
+			vcca0v9_hdmi: LDO_REG7 {
+				regulator-name = "vcca0v9_hdmi";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
@@ -422,6 +446,20 @@ &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
+
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_p0_0>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -441,6 +479,14 @@ &i2s0 {
 	rockchip,capture-channels = <2>;
 	rockchip,playback-channels = <2>;
 	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
 };
 
 &i2s1 {
@@ -456,7 +502,7 @@ &io_domains {
 	status = "okay";
 
 	bt656-supply = <&vcc_3v0>;
-	audio-supply = <&vcc1v8_codec>;
+	audio-supply = <&vcca1v8_codec>;
 	sdmmc-supply = <&vcc_sdio>;
 	gpio1830-supply = <&vcc_3v0>;
 };
@@ -602,6 +648,15 @@ &sdhci {
 	status = "okay";
 };
 
+&spdif {
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
+};
+
 &tcphy0 {
 	status = "okay";
 };
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 515ebe24fd44..fe4aa233a90e 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -8,16 +8,11 @@
 #define __ASM_EXCEPTION_H
 
 #include <asm/esr.h>
-#include <asm/kprobes.h>
 #include <asm/ptrace.h>
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry	__kprobes
-#endif
 
 static inline unsigned long disr_to_esr(u64 disr)
 {
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 8e3a27fa2ffb..02ab6ab6ba91 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -462,6 +462,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
@@ -1374,6 +1377,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6680689242df..fc86e7465df4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -435,7 +435,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
@@ -462,7 +462,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 				phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not updating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index baa949a744cb..ef7e07829607 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -102,7 +102,6 @@ struct vpe_control {
 	struct list_head tc_list;       /* Thread contexts */
 };
 
-extern unsigned long physical_memsize;
 extern struct vpe_control vpecontrol;
 extern const struct file_operations vpe_fops;
 
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bcd6a944b839..f2df0cae1b4d 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -424,9 +424,11 @@ static void cps_shutdown_this_cpu(enum cpu_death death)
 			wmb();
 		}
 	} else {
-		pr_debug("Gating power to core %d\n", core);
-		/* Power down the core */
-		cps_pm_enter_state(CPS_PM_POWER_GATED);
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			pr_debug("Gating power to core %d\n", core);
+			/* Power down the core */
+			cps_pm_enter_state(CPS_PM_POWER_GATED);
+		}
 	}
 }
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index afb2c955d99e..5c01a21a216b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2001,7 +2001,13 @@ unsigned long vi_handlers[64];
 
 void reserve_exception_space(phys_addr_t addr, unsigned long size)
 {
-	memblock_reserve(addr, size);
+	/*
+	 * reserve exception space on CPUs other than CPU0
+	 * is too late, since memblock is unavailable when APs
+	 * up
+	 */
+	if (smp_processor_id() == 0)
+		memblock_reserve(addr, size);
 }
 
 void __init *set_except_vector(int n, void *addr)
diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 84a82b551ec3..223d6274f2e5 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -92,12 +92,11 @@ int vpe_run(struct vpe *v)
 	write_tc_c0_tchalt(read_tc_c0_tchalt() & ~TCHALT_H);
 
 	/*
-	 * The sde-kit passes 'memsize' to __start in $a3, so set something
-	 * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
-	 * DFLT_HEAP_SIZE when you compile your program
+	 * We don't pass the memsize here, so VPE programs need to be
+	 * compiled with DFLT_STACK_SIZE and DFLT_HEAP_SIZE defined.
 	 */
+	mttgpr(7, 0);
 	mttgpr(6, v->ntcs);
-	mttgpr(7, physical_memsize);
 
 	/* set up VPE1 */
 	/*
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index bc9f58fcbdf9..86c743747e79 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -22,12 +22,6 @@
 DEFINE_SPINLOCK(ebu_lock);
 EXPORT_SYMBOL_GPL(ebu_lock);
 
-/*
- * This is needed by the VPE loader code, just set it to 0 and assume
- * that the firmware hardcodes this value to something useful.
- */
-unsigned long physical_memsize = 0L;
-
 /*
  * this struct is filled by the soc specific detection code and holds
  * information about the specific soc type, revision and name
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3eff6a4888e7..665d847ef9b5 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -1054,45 +1054,46 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		}
 
 		pr_info("EEH: Recovery successful.\n");
-	} else  {
-		/*
-		 * About 90% of all real-life EEH failures in the field
-		 * are due to poorly seated PCI cards. Only 10% or so are
-		 * due to actual, failed cards.
-		 */
-		pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
-		       "Please try reseating or replacing it\n",
-			pe->phb->global_number, pe->addr);
+		goto out;
+	}
 
-		eeh_slot_error_detail(pe, EEH_LOG_PERM);
+	/*
+	 * About 90% of all real-life EEH failures in the field
+	 * are due to poorly seated PCI cards. Only 10% or so are
+	 * due to actual, failed cards.
+	 */
+	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
+		"Please try reseating or replacing it\n",
+		pe->phb->global_number, pe->addr);
 
-		/* Notify all devices that they're about to go down. */
-		eeh_set_channel_state(pe, pci_channel_io_perm_failure);
-		eeh_set_irq_state(pe, false);
-		eeh_pe_report("error_detected(permanent failure)", pe,
-			      eeh_report_failure, NULL);
+	eeh_slot_error_detail(pe, EEH_LOG_PERM);
 
-		/* Mark the PE to be removed permanently */
-		eeh_pe_state_mark(pe, EEH_PE_REMOVED);
+	/* Notify all devices that they're about to go down. */
+	eeh_set_irq_state(pe, false);
+	eeh_pe_report("error_detected(permanent failure)", pe,
+		      eeh_report_failure, NULL);
+	eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 
-		/*
-		 * Shut down the device drivers for good. We mark
-		 * all removed devices correctly to avoid access
-		 * the their PCI config any more.
-		 */
-		if (pe->type & EEH_PE_VF) {
-			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
-			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
-		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
-			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+	/* Mark the PE to be removed permanently */
+	eeh_pe_state_mark(pe, EEH_PE_REMOVED);
 
-			pci_lock_rescan_remove();
-			pci_hp_remove_devices(bus);
-			pci_unlock_rescan_remove();
-			/* The passed PE should no longer be used */
-			return;
-		}
+	/*
+	 * Shut down the device drivers for good. We mark
+	 * all removed devices correctly to avoid access
+	 * the their PCI config any more.
+	 */
+	if (pe->type & EEH_PE_VF) {
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
+		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+	} else {
+		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
+		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+
+		pci_lock_rescan_remove();
+		pci_hp_remove_devices(bus);
+		pci_unlock_rescan_remove();
+		/* The passed PE should no longer be used */
+		return;
 	}
 
 out:
@@ -1188,10 +1189,10 @@ void eeh_handle_special_event(void)
 
 			/* Notify all devices to be down */
 			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
-			eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 			eeh_pe_report(
 				"error_detected(permanent failure)", pe,
 				eeh_report_failure, NULL);
+			eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 
 			pci_lock_rescan_remove();
 			list_for_each_entry(hose, &hose_list, list_node) {
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index a4cd2484dbca..d01a0ad57e38 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -68,10 +68,10 @@ struct rtas_t rtas = {
 EXPORT_SYMBOL(rtas);
 
 DEFINE_SPINLOCK(rtas_data_buf_lock);
-EXPORT_SYMBOL(rtas_data_buf_lock);
+EXPORT_SYMBOL_GPL(rtas_data_buf_lock);
 
-char rtas_data_buf[RTAS_DATA_BUF_SIZE] __cacheline_aligned;
-EXPORT_SYMBOL(rtas_data_buf);
+char rtas_data_buf[RTAS_DATA_BUF_SIZE] __aligned(SZ_4K);
+EXPORT_SYMBOL_GPL(rtas_data_buf);
 
 unsigned long rtas_rmo_buf;
 
@@ -80,7 +80,7 @@ unsigned long rtas_rmo_buf;
  * This is done like this so rtas_flash can be a module.
  */
 void (*rtas_flash_term_hook)(int);
-EXPORT_SYMBOL(rtas_flash_term_hook);
+EXPORT_SYMBOL_GPL(rtas_flash_term_hook);
 
 /* RTAS use home made raw locking instead of spin_lock_irqsave
  * because those can be called from within really nasty contexts
@@ -328,7 +328,7 @@ void rtas_progress(char *s, unsigned short hex)
  
 	spin_unlock(&progress_lock);
 }
-EXPORT_SYMBOL(rtas_progress);		/* needed by rtas_flash module */
+EXPORT_SYMBOL_GPL(rtas_progress);		/* needed by rtas_flash module */
 
 int rtas_token(const char *service)
 {
@@ -338,7 +338,7 @@ int rtas_token(const char *service)
 	tokp = of_get_property(rtas.dev, service, NULL);
 	return tokp ? be32_to_cpu(*tokp) : RTAS_UNKNOWN_SERVICE;
 }
-EXPORT_SYMBOL(rtas_token);
+EXPORT_SYMBOL_GPL(rtas_token);
 
 int rtas_service_present(const char *service)
 {
@@ -498,7 +498,7 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	}
 	return ret;
 }
-EXPORT_SYMBOL(rtas_call);
+EXPORT_SYMBOL_GPL(rtas_call);
 
 /* For RTAS_BUSY (-2), delay for 1 millisecond.  For an extended busy status
  * code of 990n, perform the hinted delay of 10^n (last digit) milliseconds.
@@ -533,7 +533,7 @@ unsigned int rtas_busy_delay(int status)
 
 	return ms;
 }
-EXPORT_SYMBOL(rtas_busy_delay);
+EXPORT_SYMBOL_GPL(rtas_busy_delay);
 
 static int rtas_error_rc(int rtas_rc)
 {
@@ -579,7 +579,7 @@ int rtas_get_power_level(int powerdomain, int *level)
 		return rtas_error_rc(rc);
 	return rc;
 }
-EXPORT_SYMBOL(rtas_get_power_level);
+EXPORT_SYMBOL_GPL(rtas_get_power_level);
 
 int rtas_set_power_level(int powerdomain, int level, int *setlevel)
 {
@@ -597,7 +597,7 @@ int rtas_set_power_level(int powerdomain, int level, int *setlevel)
 		return rtas_error_rc(rc);
 	return rc;
 }
-EXPORT_SYMBOL(rtas_set_power_level);
+EXPORT_SYMBOL_GPL(rtas_set_power_level);
 
 int rtas_get_sensor(int sensor, int index, int *state)
 {
@@ -615,7 +615,7 @@ int rtas_get_sensor(int sensor, int index, int *state)
 		return rtas_error_rc(rc);
 	return rc;
 }
-EXPORT_SYMBOL(rtas_get_sensor);
+EXPORT_SYMBOL_GPL(rtas_get_sensor);
 
 int rtas_get_sensor_fast(int sensor, int index, int *state)
 {
@@ -676,7 +676,7 @@ int rtas_set_indicator(int indicator, int index, int new_value)
 		return rtas_error_rc(rc);
 	return rc;
 }
-EXPORT_SYMBOL(rtas_set_indicator);
+EXPORT_SYMBOL_GPL(rtas_set_indicator);
 
 /*
  * Ignoring RTAS extended delay
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 284ccc90fb11..f68fa53f4b1a 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -79,9 +79,8 @@ static u32 phys_coresperchip; /* Physical cores per chip */
  */
 void read_24x7_sys_info(void)
 {
-	int call_status, len, ntypes;
-
-	spin_lock(&rtas_data_buf_lock);
+	const s32 token = rtas_token("ibm,get-system-parameter");
+	int call_status;
 
 	/*
 	 * Making system parameter: chips and sockets and cores per chip
@@ -91,32 +90,27 @@ void read_24x7_sys_info(void)
 	phys_chipspersocket = 1;
 	phys_coresperchip = 1;
 
-	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
-				NULL,
-				PROCESSOR_MODULE_INFO,
-				__pa(rtas_data_buf),
-				RTAS_DATA_BUF_SIZE);
+	do {
+		spin_lock(&rtas_data_buf_lock);
+		call_status = rtas_call(token, 3, 1, NULL, PROCESSOR_MODULE_INFO,
+					__pa(rtas_data_buf), RTAS_DATA_BUF_SIZE);
+		if (call_status == 0) {
+			int ntypes = be16_to_cpup((__be16 *)&rtas_data_buf[2]);
+			int len = be16_to_cpup((__be16 *)&rtas_data_buf[0]);
+
+			if (len >= 8 && ntypes != 0) {
+				phys_sockets = be16_to_cpup((__be16 *)&rtas_data_buf[4]);
+				phys_chipspersocket = be16_to_cpup((__be16 *)&rtas_data_buf[6]);
+				phys_coresperchip = be16_to_cpup((__be16 *)&rtas_data_buf[8]);
+			}
+		}
+		spin_unlock(&rtas_data_buf_lock);
+	} while (rtas_busy_delay(call_status));
 
 	if (call_status != 0) {
 		pr_err("Error calling get-system-parameter %d\n",
 		       call_status);
-	} else {
-		len = be16_to_cpup((__be16 *)&rtas_data_buf[0]);
-		if (len < 8)
-			goto out;
-
-		ntypes = be16_to_cpup((__be16 *)&rtas_data_buf[2]);
-
-		if (!ntypes)
-			goto out;
-
-		phys_sockets = be16_to_cpup((__be16 *)&rtas_data_buf[4]);
-		phys_chipspersocket = be16_to_cpup((__be16 *)&rtas_data_buf[6]);
-		phys_coresperchip = be16_to_cpup((__be16 *)&rtas_data_buf[8]);
 	}
-
-out:
-	spin_unlock(&rtas_data_buf_lock);
 }
 
 /* Domains for which more than one result element are returned for each event. */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 624822a81019..8cf9e9f29763 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2334,7 +2334,8 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 	int index;
 	int64_t rc;
 
-	if (!res || !res->flags || res->start > res->end)
+	if (!res || !res->flags || res->start > res->end ||
+	    res->flags & IORESOURCE_UNSET)
 		return;
 
 	if (res->flags & IORESOURCE_IO) {
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index fce0237b0715..6c196b941355 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1434,22 +1434,22 @@ static inline void __init check_lp_set_hblkrm(unsigned int lp,
 
 void __init pseries_lpar_read_hblkrm_characteristics(void)
 {
+	const s32 token = rtas_token("ibm,get-system-parameter");
 	unsigned char local_buffer[SPLPAR_TLB_BIC_MAXLENGTH];
 	int call_status, len, idx, bpsize;
 
 	if (!firmware_has_feature(FW_FEATURE_BLOCK_REMOVE))
 		return;
 
-	spin_lock(&rtas_data_buf_lock);
-	memset(rtas_data_buf, 0, RTAS_DATA_BUF_SIZE);
-	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
-				NULL,
-				SPLPAR_TLB_BIC_TOKEN,
-				__pa(rtas_data_buf),
-				RTAS_DATA_BUF_SIZE);
-	memcpy(local_buffer, rtas_data_buf, SPLPAR_TLB_BIC_MAXLENGTH);
-	local_buffer[SPLPAR_TLB_BIC_MAXLENGTH - 1] = '\0';
-	spin_unlock(&rtas_data_buf_lock);
+	do {
+		spin_lock(&rtas_data_buf_lock);
+		memset(rtas_data_buf, 0, RTAS_DATA_BUF_SIZE);
+		call_status = rtas_call(token, 3, 1, NULL, SPLPAR_TLB_BIC_TOKEN,
+					__pa(rtas_data_buf), RTAS_DATA_BUF_SIZE);
+		memcpy(local_buffer, rtas_data_buf, SPLPAR_TLB_BIC_MAXLENGTH);
+		local_buffer[SPLPAR_TLB_BIC_MAXLENGTH - 1] = '\0';
+		spin_unlock(&rtas_data_buf_lock);
+	} while (rtas_busy_delay(call_status));
 
 	if (call_status != 0) {
 		pr_warn("%s %s Error calling get-system-parameter (0x%x)\n",
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 19503a879782..a291b5a94d4d 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -322,6 +322,7 @@ static void parse_mpp_x_data(struct seq_file *m)
  */
 static void parse_system_parameter_string(struct seq_file *m)
 {
+	const s32 token = rtas_token("ibm,get-system-parameter");
 	int call_status;
 
 	unsigned char *local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
@@ -331,16 +332,15 @@ static void parse_system_parameter_string(struct seq_file *m)
 		return;
 	}
 
-	spin_lock(&rtas_data_buf_lock);
-	memset(rtas_data_buf, 0, SPLPAR_MAXLENGTH);
-	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
-				NULL,
-				SPLPAR_CHARACTERISTICS_TOKEN,
-				__pa(rtas_data_buf),
-				RTAS_DATA_BUF_SIZE);
-	memcpy(local_buffer, rtas_data_buf, SPLPAR_MAXLENGTH);
-	local_buffer[SPLPAR_MAXLENGTH - 1] = '\0';
-	spin_unlock(&rtas_data_buf_lock);
+	do {
+		spin_lock(&rtas_data_buf_lock);
+		memset(rtas_data_buf, 0, SPLPAR_MAXLENGTH);
+		call_status = rtas_call(token, 3, 1, NULL, SPLPAR_CHARACTERISTICS_TOKEN,
+					__pa(rtas_data_buf), RTAS_DATA_BUF_SIZE);
+		memcpy(local_buffer, rtas_data_buf, SPLPAR_MAXLENGTH);
+		local_buffer[SPLPAR_MAXLENGTH - 1] = '\0';
+		spin_unlock(&rtas_data_buf_lock);
+	} while (rtas_busy_delay(call_status));
 
 	if (call_status != 0) {
 		printk(KERN_INFO
diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
index 3cd00332d70f..ad254da85e61 100644
--- a/arch/riscv/include/asm/parse_asm.h
+++ b/arch/riscv/include/asm/parse_asm.h
@@ -128,7 +128,7 @@
 #define FUNCT3_C_J		0xa000
 #define FUNCT3_C_JAL		0x2000
 #define FUNCT4_C_JR		0x8000
-#define FUNCT4_C_JALR		0xf000
+#define FUNCT4_C_JALR		0x9000
 
 #define FUNCT12_SRET		0x10200000
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 56c4cecdbbf9..8764f0ae6d34 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -228,7 +228,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 /* combine single writes by using store-block insn */
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
-       zpci_memcpy_toio(to, from, count);
+	zpci_memcpy_toio(to, from, count * 8);
 }
 
 static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 940c15ee5650..f3f6c28e5818 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -207,6 +207,8 @@ extern void srso_alias_untrain_ret(void);
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
+extern void (*x86_return_thunk)(void);
+
 #ifdef CONFIG_RETPOLINE
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index b7421780e4e9..c6015b407461 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -96,24 +96,40 @@ union text_poke_insn {
 };
 
 static __always_inline
-void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+void __text_gen_insn(void *buf, u8 opcode, const void *addr, const void *dest, int size)
 {
-	static union text_poke_insn insn; /* per instance */
-	int size = text_opcode_size(opcode);
+	union text_poke_insn *insn = buf;
+
+	BUG_ON(size < text_opcode_size(opcode));
+
+	/*
+	 * Hide the addresses to avoid the compiler folding in constants when
+	 * referencing code, these can mess up annotations like
+	 * ANNOTATE_NOENDBR.
+	 */
+	OPTIMIZER_HIDE_VAR(insn);
+	OPTIMIZER_HIDE_VAR(addr);
+	OPTIMIZER_HIDE_VAR(dest);
 
-	insn.opcode = opcode;
+	insn->opcode = opcode;
 
 	if (size > 1) {
-		insn.disp = (long)dest - (long)(addr + size);
+		insn->disp = (long)dest - (long)(addr + size);
 		if (size == 2) {
 			/*
-			 * Ensure that for JMP9 the displacement
+			 * Ensure that for JMP8 the displacement
 			 * actually fits the signed byte.
 			 */
-			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+			BUG_ON((insn->disp >> 31) != (insn->disp >> 7));
 		}
 	}
+}
 
+static __always_inline
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* per instance */
+	__text_gen_insn(&insn, opcode, addr, dest, text_opcode_size(opcode));
 	return &insn.text;
 }
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index aea88d0d8352..e5536edbae57 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -521,6 +521,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 }
 
 #ifdef CONFIG_RETHUNK
+
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
@@ -536,14 +537,18 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 {
 	int i = 0;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		return -1;
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+		if (x86_return_thunk == __x86_return_thunk)
+			return -1;
 
-	bytes[i++] = RET_INSN_OPCODE;
+		i = JMP32_INSN_SIZE;
+		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
+	} else {
+		bytes[i++] = RET_INSN_OPCODE;
+	}
 
 	for (; i < insn->length;)
 		bytes[i++] = INT3_INSN_OPCODE;
-
 	return i;
 }
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7f76cb099e66..f766735d8e22 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -246,12 +246,13 @@ static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				    bool fx_only, unsigned int size)
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
 
+	/* Restore enabled features only. */
+	xrestore &= xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 retry:
 	fpregs_lock();
 	pagefault_disable();
@@ -278,7 +279,7 @@ static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
 		if (ret != -EFAULT)
 			return -EINVAL;
 
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
@@ -303,7 +304,6 @@ static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			     bool ia32_fxstate)
 {
-	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
@@ -319,7 +319,6 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			return ret;
 
 		fx_only = !fx_sw_user.magic1;
-		state_size = fx_sw_user.xstate_size;
 		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures = XFEATURE_MASK_FPSSE;
@@ -332,8 +331,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 	}
 
 	/*
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4017da3a4c70..85c09843df1b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -367,10 +367,8 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		goto fail;
 
 	ip = trampoline + size;
-
-	/* The trampoline ends with ret(q) */
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		memcpy(ip, text_gen_insn(JMP32_INSN_OPCODE, ip, &__x86_return_thunk), JMP32_INSN_SIZE);
+		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index f1cdb8891ad4..33d1a61035c0 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -58,29 +58,12 @@ static void paravirt_BUG(void)
 	BUG();
 }
 
-struct branch {
-	unsigned char opcode;
-	u32 delta;
-} __attribute__((packed));
-
 static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 				    unsigned long addr, unsigned len)
 {
-	const int call_len = 5;
-	struct branch *b = insn_buff;
-	unsigned long delta = (unsigned long)target - (addr+call_len);
-
-	if (len < call_len) {
-		pr_warn("paravirt: Failed to patch indirect CALL at %ps\n", (void *)addr);
-		/* Kernel might not be viable if patching fails, bail out: */
-		BUG_ON(1);
-	}
-
-	b->opcode = 0xe8; /* call */
-	b->delta = delta;
-	BUILD_BUG_ON(sizeof(*b) != call_len);
-
-	return call_len;
+	__text_gen_insn(insn_buff, CALL_INSN_OPCODE,
+			(void *)addr, target, CALL_INSN_SIZE);
+	return CALL_INSN_SIZE;
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index b48b659ccf6f..e25050c7ff1e 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -52,7 +52,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 
 	case RET:
 		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, &__x86_return_thunk);
+			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
 		break;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ee6e3cda1738..f7a0e9708418 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -411,7 +411,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 	u8 *prog = *pprog;
 
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		emit_jump(&prog, &__x86_return_thunk, ip);
+		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_SLS))
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1f9b9a4c38c7..d8b148114138 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -77,6 +77,15 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
+	{
+		/* Nextbook Ares 8A tablet, _LID device always reports lid closed */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+	},
 	{
 		/*
 		 * Lenovo Yoga 9 14ITL5, initial notification of the LID device
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 488915328646..9ab7f7184343 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -639,6 +639,7 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
  * @index: Index of the reference to return
  * @num_args: Maximum number of arguments after each reference
  * @args: Location to store the returned reference with optional arguments
+ *	  (may be NULL)
  *
  * Find property with @name, verifify that it is a package containing at least
  * one object reference and if so, store the ACPI device object pointer to the
@@ -697,6 +698,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		if (ret)
 			return ret == -ENODEV ? -EINVAL : ret;
 
+		if (!args)
+			return 0;
+
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
 		return 0;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 91628fb41ef8..a364cb07c557 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -421,6 +421,41 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
 		},
 	},
+	{
+		.ident = "Asus Vivobook S5402ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
+		},
+	},
+	{
+		.ident = "Asus Vivobook S5602ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
+		},
+	},
+	{
+		.ident = "Asus ExpertBook B1502CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
+		},
+	},
+	{
+		.ident = "Asus ExpertBook B2402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
+		},
+	},
+	{
+		.ident = "Asus ExpertBook B2502",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 5afc42d52e49..a5cb9e1d48bc 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -341,6 +341,40 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo ThinkPad X131e (3371 AMD version) */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "3371"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple iMac11,3 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
+		},
+	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,1 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
+		},
+	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3147b2e6cd8c..b0a8aac008ba 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -49,6 +49,7 @@ enum {
 enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
+	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_low_power,
 	board_ahci_no_debounce_delay,
@@ -129,6 +130,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_43bit_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_ign_iferr] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
@@ -598,11 +606,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
-	/* Asmedia */
+	/* ASMedia */
 	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
 
@@ -658,6 +666,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
+		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+		hpriv->saved_port_map = 0x3f;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->force_port_map = 1;
@@ -950,11 +963,20 @@ static int ahci_pci_device_resume(struct device *dev)
 
 #endif /* CONFIG_PM */
 
-static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
+static int ahci_configure_dma_masks(struct pci_dev *pdev,
+				    struct ahci_host_priv *hpriv)
 {
-	const int dma_bits = using_dac ? 64 : 32;
+	int dma_bits;
 	int rc;
 
+	if (hpriv->cap & HOST_CAP_64) {
+		dma_bits = 64;
+		if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
+			dma_bits = 43;
+	} else {
+		dma_bits = 32;
+	}
+
 	/*
 	 * If the device fixup already set the dma_mask to some non-standard
 	 * value, don't extend it here. This happens on STA2X11, for example.
@@ -1932,7 +1954,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_gtf_filter_workaround(host);
 
 	/* initialize adapter */
-	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
+	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index dcc2d92cf6b6..b4c59fe2db60 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -39,7 +39,6 @@
 
 enum {
 	AHCI_MAX_PORTS		= 32,
-	AHCI_MAX_CLKS		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_MAX_CMDS		= 32,
@@ -244,6 +243,7 @@ enum {
 	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
 						      from phy_power_on() */
 	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
+	AHCI_HFLAG_43BIT_ONLY		= BIT(29), /* 43bit DMA addr limit */
 
 	/* ap->flags bits */
 
@@ -342,7 +342,9 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	u32			remapped_nvme;	/* NVMe remapped device count */
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
-	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	unsigned int		n_clks;
+	struct clk_bulk_data	*clks;		/* Optional */
+	unsigned int		f_rsts;
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 50b56cd0039d..3a3271082004 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -88,7 +88,6 @@ struct ceva_ahci_priv {
 	u32 axicc;
 	bool is_cci_enabled;
 	int flags;
-	struct reset_control *rst;
 };
 
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
@@ -189,6 +188,60 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
 
+static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
+{
+	int rc, i;
+
+	rc = ahci_platform_enable_regulators(hpriv);
+	if (rc)
+		return rc;
+
+	rc = ahci_platform_enable_clks(hpriv);
+	if (rc)
+		goto disable_regulator;
+
+	/* Assert the controller reset */
+	rc = ahci_platform_assert_rsts(hpriv);
+	if (rc)
+		goto disable_clks;
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_init(hpriv->phys[i]);
+		if (rc)
+			goto disable_rsts;
+	}
+
+	/* De-assert the controller reset */
+	ahci_platform_deassert_rsts(hpriv);
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_power_on(hpriv->phys[i]);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+	}
+
+	return 0;
+
+disable_rsts:
+	ahci_platform_deassert_rsts(hpriv);
+
+disable_phys:
+	while (--i >= 0) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+
+disable_clks:
+	ahci_platform_disable_clks(hpriv);
+
+disable_regulator:
+	ahci_platform_disable_regulators(hpriv);
+
+	return rc;
+}
+
 static int ceva_ahci_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -203,47 +256,19 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	cevapriv->ahci_pdev = pdev;
-
-	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								  NULL);
-	if (IS_ERR(cevapriv->rst))
-		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
-			      "failed to get reset\n");
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	if (!cevapriv->rst) {
-		rc = ahci_platform_enable_resources(hpriv);
-		if (rc)
-			return rc;
-	} else {
-		int i;
+	hpriv->rsts = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								NULL);
+	if (IS_ERR(hpriv->rsts))
+		return dev_err_probe(&pdev->dev, PTR_ERR(hpriv->rsts),
+				     "failed to get reset\n");
 
-		rc = ahci_platform_enable_clks(hpriv);
-		if (rc)
-			return rc;
-		/* Assert the controller reset */
-		reset_control_assert(cevapriv->rst);
-
-		for (i = 0; i < hpriv->nports; i++) {
-			rc = phy_init(hpriv->phys[i]);
-			if (rc)
-				return rc;
-		}
-
-		/* De-assert the controller reset */
-		reset_control_deassert(cevapriv->rst);
-
-		for (i = 0; i < hpriv->nports; i++) {
-			rc = phy_power_on(hpriv->phys[i]);
-			if (rc) {
-				phy_exit(hpriv->phys[i]);
-				return rc;
-			}
-		}
-	}
+	rc = ceva_ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
 
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
@@ -252,52 +277,60 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
 					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
 					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read OOB timing value for COMWAKE from device-tree*/
 	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
 					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
 					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read phy BURST timing value from device-tree */
 	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
 					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
 					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read phy RETRY interval timing value from device-tree */
 	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
 					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
 		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
 					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
 		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/*
@@ -335,7 +368,7 @@ static int __maybe_unused ceva_ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
-	rc = ahci_platform_enable_resources(hpriv);
+	rc = ceva_ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 0e8276600712..389268c1ef45 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -163,7 +163,6 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	void __iomem *pwrdn_reg;
 	struct resource *res;
-	struct clk *clk;
 	u32 mpy;
 	int rc;
 
@@ -172,36 +171,28 @@ static int ahci_da850_probe(struct platform_device *pdev)
 		return PTR_ERR(hpriv);
 
 	/*
-	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
-	 * when trying to obtain the functional clock. This SATA controller
-	 * uses two clocks for which we specify two connection ids. If we don't
-	 * have the functional clock at this point - call clk_get() again with
-	 * con_id = "fck".
+	 * Internally ahci_platform_get_resources() calls the bulk clocks
+	 * get method or falls back to using a single clk_get_optional().
+	 * This AHCI SATA controller uses two clocks: functional clock
+	 * with "fck" connection id and external reference clock with
+	 * "refclk" id. If we haven't got all of them re-try the clocks
+	 * getting procedure with the explicitly specified ids.
 	 */
-	if (!hpriv->clks[0]) {
-		clk = clk_get(dev, "fck");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-
-		hpriv->clks[0] = clk;
-	}
-
-	/*
-	 * The second clock used by ahci-da850 is the external REFCLK. If we
-	 * didn't get it from ahci_platform_get_resources(), let's try to
-	 * specify the con_id in clk_get().
-	 */
-	if (!hpriv->clks[1]) {
-		clk = clk_get(dev, "refclk");
-		if (IS_ERR(clk)) {
-			dev_err(dev, "unable to obtain the reference clock");
-			return -ENODEV;
-		}
-
-		hpriv->clks[1] = clk;
+	if (hpriv->n_clks < 2) {
+		hpriv->clks = devm_kcalloc(dev, 2, sizeof(*hpriv->clks), GFP_KERNEL);
+		if (!hpriv->clks)
+			return -ENOMEM;
+
+		hpriv->clks[0].id = "fck";
+		hpriv->clks[1].id = "refclk";
+		hpriv->n_clks = 2;
+
+		rc = devm_clk_bulk_get(dev, hpriv->n_clks, hpriv->clks);
+		if (rc)
+			return rc;
 	}
 
-	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
+	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1].clk));
 	if (mpy == 0) {
 		dev_err(dev, "invalid REFCLK multiplier value: 0x%x", mpy);
 		return -EINVAL;
diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
index 8bec41041671..ec83ba885806 100644
--- a/drivers/ata/ahci_dm816.c
+++ b/drivers/ata/ahci_dm816.c
@@ -69,12 +69,12 @@ static int ahci_dm816_phy_init(struct ahci_host_priv *hpriv, struct device *dev)
 	 * keep-alive clock and the external reference clock. We need the
 	 * rate of the latter to calculate the correct value of MPY bits.
 	 */
-	if (!hpriv->clks[1]) {
+	if (hpriv->n_clks < 2) {
 		dev_err(dev, "reference clock not supplied\n");
 		return -EINVAL;
 	}
 
-	refclk_rate = clk_get_rate(hpriv->clks[1]);
+	refclk_rate = clk_get_rate(hpriv->clks[1].clk);
 	if ((refclk_rate % 100) != 0) {
 		dev_err(dev, "reference clock rate must be divisible by 100\n");
 		return -EINVAL;
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 64d6da0a5303..43380d1a410e 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -97,28 +97,14 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
  * ahci_platform_enable_clks - Enable platform clocks
  * @hpriv: host private area to store config values
  *
- * This function enables all the clks found in hpriv->clks, starting at
- * index 0. If any clk fails to enable it disables all the clks already
- * enabled in reverse order, and then returns an error.
+ * This function enables all the clks found for the AHCI device.
  *
  * RETURNS:
  * 0 on success otherwise a negative error code
  */
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
 {
-	int c, rc;
-
-	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
-		rc = clk_prepare_enable(hpriv->clks[c]);
-		if (rc)
-			goto disable_unprepare_clk;
-	}
-	return 0;
-
-disable_unprepare_clk:
-	while (--c >= 0)
-		clk_disable_unprepare(hpriv->clks[c]);
-	return rc;
+	return clk_bulk_prepare_enable(hpriv->n_clks, hpriv->clks);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
 
@@ -126,19 +112,54 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
  * ahci_platform_disable_clks - Disable platform clocks
  * @hpriv: host private area to store config values
  *
- * This function disables all the clks found in hpriv->clks, in reverse
- * order of ahci_platform_enable_clks (starting at the end of the array).
+ * This function disables all the clocks enabled before
+ * (bulk-clocks-disable function is supposed to do that in reverse
+ * from the enabling procedure order).
  */
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
 {
-	int c;
-
-	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
-		if (hpriv->clks[c])
-			clk_disable_unprepare(hpriv->clks[c]);
+	clk_bulk_disable_unprepare(hpriv->n_clks, hpriv->clks);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
 
+/**
+ * ahci_platform_deassert_rsts - Deassert/trigger platform resets
+ * @hpriv: host private area to store config values
+ *
+ * This function deasserts or triggers all the reset lines found for
+ * the AHCI device.
+ *
+ * RETURNS:
+ * 0 on success otherwise a negative error code
+ */
+int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv)
+{
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
+		return reset_control_reset(hpriv->rsts);
+
+	return reset_control_deassert(hpriv->rsts);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_deassert_rsts);
+
+/**
+ * ahci_platform_assert_rsts - Assert/rearm platform resets
+ * @hpriv: host private area to store config values
+ *
+ * This function asserts or rearms (for self-deasserting resets) all
+ * the reset controls found for the AHCI device.
+ *
+ * RETURNS:
+ * 0 on success otherwise a negative error code
+ */
+int ahci_platform_assert_rsts(struct ahci_host_priv *hpriv)
+{
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
+		return reset_control_rearm(hpriv->rsts);
+
+	return reset_control_assert(hpriv->rsts);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_assert_rsts);
+
 /**
  * ahci_platform_enable_regulators - Enable regulators
  * @hpriv: host private area to store config values
@@ -236,18 +257,18 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
-	rc = reset_control_deassert(hpriv->rsts);
+	rc = ahci_platform_deassert_rsts(hpriv);
 	if (rc)
 		goto disable_clks;
 
 	rc = ahci_platform_enable_phys(hpriv);
 	if (rc)
-		goto disable_resets;
+		goto disable_rsts;
 
 	return 0;
 
-disable_resets:
-	reset_control_assert(hpriv->rsts);
+disable_rsts:
+	ahci_platform_assert_rsts(hpriv);
 
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
@@ -274,7 +295,7 @@ void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
 	ahci_platform_disable_phys(hpriv);
 
-	reset_control_assert(hpriv->rsts);
+	ahci_platform_assert_rsts(hpriv);
 
 	ahci_platform_disable_clks(hpriv);
 
@@ -292,8 +313,6 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 		pm_runtime_disable(dev);
 	}
 
-	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
-		clk_put(hpriv->clks[c]);
 	/*
 	 * The regulators are tied to child node device and not to the
 	 * SATA device itself. So we can't use devm for automatically
@@ -374,8 +393,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
  * 2) regulator for controlling the targets power (optional)
  *    regulator for controlling the AHCI controller (optional)
- * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
- *    or for non devicetree enabled platforms a single clock
+ * 3) all clocks specified in the devicetree node, or a single
+ *    clock for non-OF platforms (optional)
  * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
  * 5) phys (optional)
  *
@@ -385,11 +404,10 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 						   unsigned int flags)
 {
+	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct clk *clk;
 	struct device_node *child;
-	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -409,25 +427,38 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		goto err_out;
 	}
 
-	for (i = 0; i < AHCI_MAX_CLKS; i++) {
+	/*
+	 * Bulk clocks getting procedure can fail to find any clock due to
+	 * running on a non-OF platform or due to the clocks being defined in
+	 * bypass of the DT firmware (like da850, spear13xx). In that case we
+	 * fallback to getting a single clock source right from the dev clocks
+	 * list.
+	 */
+	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
+	if (rc < 0)
+		goto err_out;
+
+	if (rc > 0) {
+		/* Got clocks in bulk */
+		hpriv->n_clks = rc;
+	} else {
 		/*
-		 * For now we must use clk_get(dev, NULL) for the first clock,
-		 * because some platforms (da850, spear13xx) are not yet
-		 * converted to use devicetree for clocks.  For new platforms
-		 * this is equivalent to of_clk_get(dev->of_node, 0).
+		 * No clock bulk found: fallback to manually getting
+		 * the optional clock.
 		 */
-		if (i == 0)
-			clk = clk_get(dev, NULL);
-		else
-			clk = of_clk_get(dev->of_node, i);
-
-		if (IS_ERR(clk)) {
-			rc = PTR_ERR(clk);
-			if (rc == -EPROBE_DEFER)
-				goto err_out;
-			break;
+		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
+		if (!hpriv->clks) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
+		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
+		if (IS_ERR(hpriv->clks->clk)) {
+			rc = PTR_ERR(hpriv->clks->clk);
+			goto err_out;
+		} else if (hpriv->clks->clk) {
+			hpriv->clks->id = "ahci";
+			hpriv->n_clks = 1;
 		}
-		hpriv->clks[i] = clk;
 	}
 
 	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
@@ -449,6 +480,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			rc = PTR_ERR(hpriv->rsts);
 			goto err_out;
 		}
+
+		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;
 	}
 
 	/*
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e563aa407e88..d379a047d427 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1715,7 +1715,8 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index affeca0dbc7e..7f73e7447ecb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -989,14 +989,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_freeze_queue(vblk->disk->queue);
+
 	/* Ensure we don't receive any more interrupts */
 	vdev->config->reset(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
@@ -1014,7 +1015,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b37af6b27e9c..bf9057a8fbf0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -251,6 +251,17 @@ static bool clk_core_is_enabled(struct clk_core *core)
 		}
 	}
 
+	/*
+	 * This could be called with the enable lock held, or from atomic
+	 * context. If the parent isn't enabled already, we can't do
+	 * anything here. We can also assume this clock isn't enabled.
+	 */
+	if ((core->flags & CLK_OPS_PARENT_ENABLE) && core->parent)
+		if (!clk_core_is_enabled(core->parent)) {
+			ret = false;
+			goto done;
+		}
+
 	ret = core->ops->is_enabled(core->hw);
 done:
 	if (core->rpm_enabled)
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 2f898c0bc867..cdeacdc143b5 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -17,6 +17,7 @@
 
 static u32 share_count_nand;
 static u32 share_count_media;
+static u32 share_count_usb;
 
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
@@ -354,7 +355,7 @@ static const char * const imx8mp_media_mipi_phy1_ref_sels[] = {"osc_24m", "sys_p
 							       "clk_ext2", "audio_pll2_out",
 							       "video_pll1_out", };
 
-static const char * const imx8mp_media_disp1_pix_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
+static const char * const imx8mp_media_disp_pix_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
 							   "audio_pll1_out", "sys_pll1_800m",
 							   "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
 
@@ -395,6 +396,11 @@ static const char * const imx8mp_sai7_sels[] = {"osc_24m", "audio_pll1_out", "au
 
 static const char * const imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
+static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+						  "dummy", "dummy", "gpu_pll_out", "vpu_pll_out",
+						  "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
+						  "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
+
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
 
@@ -513,6 +519,15 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
 	hws[IMX8MP_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
 
+	hws[IMX8MP_CLK_CLKOUT1_SEL] = imx_clk_hw_mux2("clkout1_sel", anatop_base + 0x128, 4, 4,
+						      imx8mp_clkout_sels, ARRAY_SIZE(imx8mp_clkout_sels));
+	hws[IMX8MP_CLK_CLKOUT1_DIV] = imx_clk_hw_divider("clkout1_div", "clkout1_sel", anatop_base + 0x128, 0, 4);
+	hws[IMX8MP_CLK_CLKOUT1] = imx_clk_hw_gate("clkout1", "clkout1_div", anatop_base + 0x128, 8);
+	hws[IMX8MP_CLK_CLKOUT2_SEL] = imx_clk_hw_mux2("clkout2_sel", anatop_base + 0x128, 20, 4,
+						      imx8mp_clkout_sels, ARRAY_SIZE(imx8mp_clkout_sels));
+	hws[IMX8MP_CLK_CLKOUT2_DIV] = imx_clk_hw_divider("clkout2_div", "clkout2_sel", anatop_base + 0x128, 16, 4);
+	hws[IMX8MP_CLK_CLKOUT2] = imx_clk_hw_gate("clkout2", "clkout2_div", anatop_base + 0x128, 24);
+
 	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
 	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
 	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
@@ -547,6 +562,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
 	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
 	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
+	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
@@ -608,7 +624,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, ccm_base + 0xbc80);
 	hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, ccm_base + 0xbd00);
 	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, ccm_base + 0xbd80);
-	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite("media_disp1_pix", imx8mp_media_disp1_pix_sels, ccm_base + 0xbe00);
+	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite("media_disp1_pix", imx8mp_media_disp_pix_sels, ccm_base + 0xbe00);
 	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
 	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
 	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
@@ -667,7 +683,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
 	hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", ccm_base + 0x44b0, 0);
 	hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", ccm_base + 0x44c0, 0);
-	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate4("usb_root_clk", "hsio_axi", ccm_base + 0x44d0, 0);
+	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate2_shared2("usb_root_clk", "hsio_axi", ccm_base + 0x44d0, 0, &share_count_usb);
+	hws[IMX8MP_CLK_USB_SUSP] = imx_clk_hw_gate2_shared2("usb_suspend_clk", "osc_32k", ccm_base + 0x44d0, 0, &share_count_usb);
 	hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", ccm_base + 0x44f0, 0);
 	hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", ccm_base + 0x4510, 0);
 	hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", ccm_base + 0x4520, 0);
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 7cc669934253..d4cf0c7045ab 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -201,9 +201,10 @@ static int __init imx_clk_disable_uart(void)
 			clk_disable_unprepare(imx_uart_clocks[i]);
 			clk_put(imx_uart_clocks[i]);
 		}
-		kfree(imx_uart_clocks);
 	}
 
+	kfree(imx_uart_clocks);
+
 	return 0;
 }
 late_initcall_sync(imx_clk_disable_uart);
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 46d314d69250..a7a9884799cd 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -25,11 +25,9 @@ enum {
 	P_CORE_BI_PLL_TEST_SE,
 	P_DSI0_PHY_PLL_OUT_BYTECLK,
 	P_DSI0_PHY_PLL_OUT_DSICLK,
-	P_GPLL0_OUT_AUX,
 	P_GPLL0_OUT_MAIN,
 	P_GPLL1_OUT_MAIN,
 	P_GPLL3_OUT_MAIN,
-	P_GPLL4_OUT_AUX,
 	P_GPLL4_OUT_MAIN,
 	P_GPLL6_OUT_AUX,
 	P_HDMI_PHY_PLL_CLK,
@@ -109,28 +107,24 @@ static const char * const gcc_parent_names_4[] = {
 static const struct parent_map gcc_parent_map_5[] = {
 	{ P_XO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 1 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_5[] = {
 	"cxo",
-	"dsi0pll_byteclk_src",
-	"gpll0_out_aux",
+	"dsi0pllbyte",
 	"core_bi_pll_test_se",
 };
 
 static const struct parent_map gcc_parent_map_6[] = {
 	{ P_XO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
-	{ P_GPLL0_OUT_AUX, 3 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_6[] = {
 	"cxo",
-	"dsi0_phy_pll_out_byteclk",
-	"gpll0_out_aux",
+	"dsi0pllbyte",
 	"core_bi_pll_test_se",
 };
 
@@ -139,7 +133,6 @@ static const struct parent_map gcc_parent_map_7[] = {
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL3_OUT_MAIN, 2 },
 	{ P_GPLL6_OUT_AUX, 3 },
-	{ P_GPLL4_OUT_AUX, 4 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
@@ -148,7 +141,6 @@ static const char * const gcc_parent_names_7[] = {
 	"gpll0_out_main",
 	"gpll3_out_main",
 	"gpll6_out_aux",
-	"gpll4_out_aux",
 	"core_bi_pll_test_se",
 };
 
@@ -175,7 +167,7 @@ static const struct parent_map gcc_parent_map_9[] = {
 static const char * const gcc_parent_names_9[] = {
 	"cxo",
 	"gpll0_out_main",
-	"dsi0_phy_pll_out_dsiclk",
+	"dsi0pll",
 	"gpll6_out_aux",
 	"core_bi_pll_test_se",
 };
@@ -207,14 +199,12 @@ static const char * const gcc_parent_names_11[] = {
 static const struct parent_map gcc_parent_map_12[] = {
 	{ P_XO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_12[] = {
 	"cxo",
-	"dsi0pll_pclk_src",
-	"gpll0_out_aux",
+	"dsi0pll",
 	"core_bi_pll_test_se",
 };
 
@@ -237,40 +227,34 @@ static const char * const gcc_parent_names_13[] = {
 static const struct parent_map gcc_parent_map_14[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL4_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_14[] = {
 	"cxo",
 	"gpll0_out_main",
-	"gpll4_out_aux",
 	"core_bi_pll_test_se",
 };
 
 static const struct parent_map gcc_parent_map_15[] = {
 	{ P_XO, 0 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_15[] = {
 	"cxo",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
 static const struct parent_map gcc_parent_map_16[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_16[] = {
 	"cxo",
 	"gpll0_out_main",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index d738251cba17..6839b4b71a2f 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -21,8 +21,6 @@
 #define CX_GMU_CBCR_SLEEP_SHIFT		4
 #define CX_GMU_CBCR_WAKE_MASK		0xF
 #define CX_GMU_CBCR_WAKE_SHIFT		8
-#define CLK_DIS_WAIT_SHIFT		12
-#define CLK_DIS_WAIT_MASK		(0xf << CLK_DIS_WAIT_SHIFT)
 
 enum {
 	P_BI_TCXO,
@@ -160,6 +158,7 @@ static struct clk_branch gpu_cc_cxo_clk = {
 static struct gdsc cx_gdsc = {
 	.gdscr = 0x106c,
 	.gds_hw_ctrl = 0x1540,
+	.clk_dis_wait_val = 8,
 	.pd = {
 		.name = "cx_gdsc",
 	},
@@ -242,10 +241,6 @@ static int gpu_cc_sc7180_probe(struct platform_device *pdev)
 	value = 0xF << CX_GMU_CBCR_WAKE_SHIFT | 0xF << CX_GMU_CBCR_SLEEP_SHIFT;
 	regmap_update_bits(regmap, 0x1098, mask, value);
 
-	/* Configure clk_dis_wait for gpu_cx_gdsc */
-	regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
-						8 << CLK_DIS_WAIT_SHIFT);
-
 	return qcom_cc_really_probe(pdev, &gpu_cc_sc7180_desc, regmap);
 }
 
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index 110b54401bc6..970d7414bdf0 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -22,8 +22,6 @@
 #define CX_GMU_CBCR_SLEEP_SHIFT		4
 #define CX_GMU_CBCR_WAKE_MASK		0xf
 #define CX_GMU_CBCR_WAKE_SHIFT		8
-#define CLK_DIS_WAIT_SHIFT		12
-#define CLK_DIS_WAIT_MASK		(0xf << CLK_DIS_WAIT_SHIFT)
 
 enum {
 	P_BI_TCXO,
@@ -121,6 +119,7 @@ static struct clk_branch gpu_cc_cxo_clk = {
 static struct gdsc gpu_cx_gdsc = {
 	.gdscr = 0x106c,
 	.gds_hw_ctrl = 0x1540,
+	.clk_dis_wait_val = 0x8,
 	.pd = {
 		.name = "gpu_cx_gdsc",
 	},
@@ -193,10 +192,6 @@ static int gpu_cc_sdm845_probe(struct platform_device *pdev)
 	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
 	regmap_update_bits(regmap, 0x1098, mask, value);
 
-	/* Configure clk_dis_wait for gpu_cx_gdsc */
-	regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
-						8 << CLK_DIS_WAIT_SHIFT);
-
 	return qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
 }
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 21f762aa2131..54c5d35fe2ae 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -911,9 +911,8 @@ static int cpg_mssr_resume_noirq(struct device *dev)
 		}
 
 		if (!i)
-			dev_warn(dev, "Failed to enable %s%u[0x%x]\n",
-				 priv->reg_layout == CLK_REG_LAYOUT_RZ_A ?
-				 "STB" : "SMSTP", reg, oldval & mask);
+			dev_warn(dev, "Failed to enable SMSTP%u[0x%x]\n", reg,
+				 oldval & mask);
 	}
 
 	return 0;
@@ -957,7 +956,6 @@ static int __init cpg_mssr_common_init(struct device *dev,
 		goto out_err;
 	}
 
-	cpg_mssr_priv = priv;
 	priv->num_core_clks = info->num_total_core_clks;
 	priv->num_mod_clks = info->num_hw_mod_clks;
 	priv->last_dt_core_clk = info->last_dt_core_clk;
@@ -987,6 +985,8 @@ static int __init cpg_mssr_common_init(struct device *dev,
 	if (error)
 		goto out_err;
 
+	cpg_mssr_priv = priv;
+
 	return 0;
 
 out_err:
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 69385f32e275..f383f219ed00 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -805,7 +805,7 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	int i;
 	int cpu;
 	int ret;
-	char irq_name[20];
+	char irq_name[32];
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 9c121a4b33ad..f97d80343aea 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -25,7 +25,7 @@ struct sh_dmae_chan {
 	const struct sh_dmae_slave_config *config; /* Slave DMA configuration */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	void __iomem *base;
-	char dev_id[16];		/* unique name per DMAC of channel */
+	char dev_id[32];		/* unique name per DMAC of channel */
 	int pm_error;
 	dma_addr_t slave_addr;
 };
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index a1adc8d91fd8..69292d4a0c44 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2462,6 +2462,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
@@ -2478,6 +2483,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index f3b3953cac83..be195ba83463 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -429,7 +429,23 @@ static void bm_work(struct work_struct *work)
 	 */
 	card->bm_generation = generation;
 
-	if (root_device == NULL) {
+	if (card->gap_count == 0) {
+		/*
+		 * If self IDs have inconsistent gap counts, do a
+		 * bus reset ASAP. The config rom read might never
+		 * complete, so don't wait for it. However, still
+		 * send a PHY configuration packet prior to the
+		 * bus reset. The PHY configuration packet might
+		 * fail, but 1394-2008 8.4.5.2 explicitly permits
+		 * it in this case, so it should be safe to try.
+		 */
+		new_root_id = local_id;
+		/*
+		 * We must always send a bus reset if the gap count
+		 * is inconsistent, so bypass the 5-reset limit.
+		 */
+		card->bm_retries = 0;
+	} else if (root_device == NULL) {
 		/*
 		 * Either link_on is false, or we failed to read the
 		 * config rom.  In either case, pick another root.
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 3359ae2adf24..9054c2852580 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b2c829e95bd1..4639ac6e4f9a 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -141,15 +141,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
 	case EFI_PERSISTENT_MEMORY:
-		/*
-		 * Special purpose memory is 'soft reserved', which means it
-		 * is set aside initially, but can be hotplugged back in or
-		 * be assigned to the dax driver after boot.
-		 */
-		if (efi_soft_reserve_enabled() &&
-		    (md->attribute & EFI_MEMORY_SP))
-			return false;
-
 		/*
 		 * According to the spec, these regions are no longer reserved
 		 * after calling ExitBootServices(). However, we can only use
@@ -194,6 +185,16 @@ static __init void reserve_regions(void)
 		size = npages << PAGE_SHIFT;
 
 		if (is_memory(md)) {
+			/*
+			 * Special purpose memory is 'soft reserved', which
+			 * means it is set aside initially. Don't add a memblock
+			 * for it now so that it can be hotplugged back in or
+			 * be assigned to the dax driver after boot.
+			 */
+			if (efi_soft_reserve_enabled() &&
+			    (md->attribute & EFI_MEMORY_SP))
+				continue;
+
 			early_init_dt_add_memory_arch(paddr, size);
 
 			if (!is_usable_memory(md))
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index d28e715d2bcc..6711e64eb0b1 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f1e7966beb5..dbef22f56482 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1045,6 +1045,8 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	/* indicate amdgpu suspension status */
+	bool				suspend_complete;
 
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5f6c32ec674d..222a1d9ecf16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2487,10 +2487,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -2529,6 +2525,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index deae92fde3b8..57943e900871 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2252,6 +2252,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else
@@ -2264,6 +2265,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index de1fab165041..fb37c0d4b35b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3268,6 +3268,14 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	gfx_v9_0_cp_gfx_enable(adev, true);
 
+	/* Now only limit the quirk on the APU gfx9 series and already
+	 * confirmed that the APU gfx10/gfx11 needn't such update.
+	 */
+	if (adev->flags & AMD_IS_APU &&
+			adev->in_s3 && !adev->suspend_complete) {
+		DRM_INFO(" Will skip the CSB packet resubmit\n");
+		return 0;
+	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e8c0e77e1b01..6a3486f52d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1490,10 +1490,32 @@ static int soc15_common_suspend(void *handle)
 	return soc15_common_hw_fini(adev);
 }
 
+static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend abort and TOS already launched.
+	 */
+	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
+			!adev->suspend_complete &&
+			sol_reg)
+		return true;
+
+	return false;
+}
+
 static int soc15_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc15_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend abort case, let's reset ASIC.\n");
+		soc15_asic_reset(adev);
+	}
 	return soc15_common_hw_init(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f5b257cb32cb..7385efe699f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2088,6 +2088,7 @@ static int dm_sw_fini(void *handle)
 
 	if (adev->dm.dmub_srv) {
 		dmub_srv_destroy(adev->dm.dmub_srv);
+		kfree(adev->dm.dmub_srv);
 		adev->dm.dmub_srv = NULL;
 	}
 
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c26f91699635..2de679ffd88d 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1021,7 +1021,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	uint64_t *points;
 	uint32_t signaled_count, i;
 
-	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
+	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
 		lockdep_assert_none_held_once();
 
 	points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
@@ -1090,7 +1091,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	 * fallthough and try a 0 timeout wait!
 	 */
 
-	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
 		for (i = 0; i < count; ++i)
 			drm_syncobj_fence_add_wait(syncobjs[i], &entries[i]);
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index b136a0fc0963..6b3e2e053f45 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -571,8 +571,8 @@ static int i915_dmc_info(struct seq_file *m, void *unused)
 		 * reg for DC3CO debugging and validation,
 		 * but TGL DMC f/w is using DMC_DEBUG3 reg for DC3CO counter.
 		 */
-		seq_printf(m, "DC3CO count: %d\n",
-			   intel_de_read(dev_priv, DMC_DEBUG3));
+		seq_printf(m, "DC3CO count: %d\n", intel_de_read(dev_priv, IS_DGFX(dev_priv) ?
+					DG1_DMC_DEBUG3 : TGL_DMC_DEBUG3));
 	} else {
 		dc5_reg = IS_BROXTON(dev_priv) ? BXT_DMC_DC3_DC5_COUNT :
 						 SKL_DMC_DC3_DC5_COUNT;
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 3c70aa5229e5..906982d6370d 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7841,7 +7841,8 @@ enum {
 #define TGL_DMC_DEBUG_DC6_COUNT	_MMIO(0x101088)
 #define DG1_DMC_DEBUG_DC5_COUNT	_MMIO(0x134154)
 
-#define DMC_DEBUG3		_MMIO(0x101090)
+#define TGL_DMC_DEBUG3		_MMIO(0x101090)
+#define DG1_DMC_DEBUG3		_MMIO(0x13415c)
 
 /* Display Internal Timeout Register */
 #define RM_TIMEOUT		_MMIO(0x42060)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
index 4b571cc6bc70..6597def18627 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
@@ -154,11 +154,17 @@ shadow_fw_init(struct nvkm_bios *bios, const char *name)
 	return (void *)fw;
 }
 
+static void
+shadow_fw_release(void *fw)
+{
+	release_firmware(fw);
+}
+
 static const struct nvbios_source
 shadow_fw = {
 	.name = "firmware",
 	.init = shadow_fw_init,
-	.fini = (void(*)(void *))release_firmware,
+	.fini = shadow_fw_release,
 	.read = shadow_fw_read,
 	.rw = false,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index 96aca0edfa3c..c51bac76174c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -313,7 +313,7 @@ nv50_instobj_dtor(struct nvkm_memory *memory)
 	struct nv50_instobj *iobj = nv50_instobj(memory);
 	struct nvkm_instmem *imem = &iobj->imem->base;
 	struct nvkm_vma *bar;
-	void *map = map;
+	void *map;
 
 	mutex_lock(&imem->mutex);
 	if (likely(iobj->lru.next))
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index aa3512af051a..346db24719f9 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -384,7 +384,7 @@ static void ttm_pool_free_range(struct ttm_pool *pool, struct ttm_tt *tt,
 				enum ttm_caching caching,
 				pgoff_t start_page, pgoff_t end_page)
 {
-	struct page **pages = tt->pages;
+	struct page **pages = &tt->pages[start_page];
 	unsigned int order;
 	pgoff_t i, nr;
 
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index d67d972d18aa..cbe2f874b5e2 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -40,7 +40,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 5e8853d3f8da..fae674969628 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -51,6 +53,8 @@
 /* This will be the driver name the kernel reports */
 #define DRIVER_NAME "imx-i2c"
 
+#define I2C_IMX_CHECK_DELAY 30000 /* Time to check for bus idle, in NS */
+
 /*
  * Enable DMA if transfer byte size is bigger than this threshold.
  * As the hardware request, it must bigger than 4 bytes.\
@@ -210,6 +214,10 @@ struct imx_i2c_struct {
 	struct imx_i2c_dma	*dma;
 	struct i2c_client	*slave;
 	enum i2c_slave_event last_slave_event;
+
+	/* For checking slave events. */
+	spinlock_t     slave_lock;
+	struct hrtimer slave_timer;
 };
 
 static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
@@ -680,7 +688,7 @@ static void i2c_imx_slave_event(struct imx_i2c_struct *i2c_imx,
 
 static void i2c_imx_slave_finish_op(struct imx_i2c_struct *i2c_imx)
 {
-	u8 val;
+	u8 val = 0;
 
 	while (i2c_imx->last_slave_event != I2C_SLAVE_STOP) {
 		switch (i2c_imx->last_slave_event) {
@@ -701,10 +709,11 @@ static void i2c_imx_slave_finish_op(struct imx_i2c_struct *i2c_imx)
 	}
 }
 
-static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
-				     unsigned int status, unsigned int ctl)
+/* Returns true if the timer should be restarted, false if not. */
+static irqreturn_t i2c_imx_slave_handle(struct imx_i2c_struct *i2c_imx,
+					unsigned int status, unsigned int ctl)
 {
-	u8 value;
+	u8 value = 0;
 
 	if (status & I2SR_IAL) { /* Arbitration lost */
 		i2c_imx_clear_irq(i2c_imx, I2SR_IAL);
@@ -712,6 +721,16 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
 			return IRQ_HANDLED;
 	}
 
+	if (!(status & I2SR_IBB)) {
+		/* No master on the bus, that could mean a stop condition. */
+		i2c_imx_slave_finish_op(i2c_imx);
+		return IRQ_HANDLED;
+	}
+
+	if (!(status & I2SR_ICF))
+		/* Data transfer still in progress, ignore this. */
+		goto out;
+
 	if (status & I2SR_IAAS) { /* Addressed as a slave */
 		i2c_imx_slave_finish_op(i2c_imx);
 		if (status & I2SR_SRW) { /* Master wants to read from us*/
@@ -737,16 +756,9 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
 			imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
 		}
 	} else if (!(ctl & I2CR_MTX)) { /* Receive mode */
-		if (status & I2SR_IBB) { /* No STOP signal detected */
-			value = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
-			i2c_imx_slave_event(i2c_imx,
-					    I2C_SLAVE_WRITE_RECEIVED, &value);
-		} else { /* STOP signal is detected */
-			dev_dbg(&i2c_imx->adapter.dev,
-				"STOP signal detected");
-			i2c_imx_slave_event(i2c_imx,
-					    I2C_SLAVE_STOP, &value);
-		}
+		value = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+		i2c_imx_slave_event(i2c_imx,
+				    I2C_SLAVE_WRITE_RECEIVED, &value);
 	} else if (!(status & I2SR_RXAK)) { /* Transmit mode received ACK */
 		ctl |= I2CR_MTX;
 		imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
@@ -755,15 +767,48 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
 				    I2C_SLAVE_READ_PROCESSED, &value);
 
 		imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
-	} else { /* Transmit mode received NAK */
+	} else { /* Transmit mode received NAK, operation is done */
 		ctl &= ~I2CR_MTX;
 		imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
 		imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+
+		/* flag the last byte as processed */
+		i2c_imx_slave_event(i2c_imx,
+				    I2C_SLAVE_READ_PROCESSED, &value);
+
+		i2c_imx_slave_finish_op(i2c_imx);
+		return IRQ_HANDLED;
 	}
 
+out:
+	/*
+	 * No need to check the return value here.  If it returns 0 or
+	 * 1, then everything is fine.  If it returns -1, then the
+	 * timer is running in the handler.  This will still work,
+	 * though it may be redone (or already have been done) by the
+	 * timer function.
+	 */
+	hrtimer_try_to_cancel(&i2c_imx->slave_timer);
+	hrtimer_forward_now(&i2c_imx->slave_timer, I2C_IMX_CHECK_DELAY);
+	hrtimer_restart(&i2c_imx->slave_timer);
 	return IRQ_HANDLED;
 }
 
+static enum hrtimer_restart i2c_imx_slave_timeout(struct hrtimer *t)
+{
+	struct imx_i2c_struct *i2c_imx = container_of(t, struct imx_i2c_struct,
+						      slave_timer);
+	unsigned int ctl, status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_imx->slave_lock, flags);
+	status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+	ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+	i2c_imx_slave_handle(i2c_imx, status, ctl);
+	spin_unlock_irqrestore(&i2c_imx->slave_lock, flags);
+	return HRTIMER_NORESTART;
+}
+
 static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
 {
 	int temp;
@@ -843,7 +888,9 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 {
 	struct imx_i2c_struct *i2c_imx = dev_id;
 	unsigned int ctl, status;
+	unsigned long flags;
 
+	spin_lock_irqsave(&i2c_imx->slave_lock, flags);
 	status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
 	ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 
@@ -851,14 +898,20 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 		i2c_imx_clear_irq(i2c_imx, I2SR_IIF);
 		if (i2c_imx->slave) {
 			if (!(ctl & I2CR_MSTA)) {
-				return i2c_imx_slave_isr(i2c_imx, status, ctl);
-			} else if (i2c_imx->last_slave_event !=
-				   I2C_SLAVE_STOP) {
-				i2c_imx_slave_finish_op(i2c_imx);
+				irqreturn_t ret;
+
+				ret = i2c_imx_slave_handle(i2c_imx,
+							   status, ctl);
+				spin_unlock_irqrestore(&i2c_imx->slave_lock,
+						       flags);
+				return ret;
 			}
+			i2c_imx_slave_finish_op(i2c_imx);
 		}
+		spin_unlock_irqrestore(&i2c_imx->slave_lock, flags);
 		return i2c_imx_master_isr(i2c_imx, status);
 	}
+	spin_unlock_irqrestore(&i2c_imx->slave_lock, flags);
 
 	return IRQ_NONE;
 }
@@ -1380,6 +1433,10 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	if (!i2c_imx)
 		return -ENOMEM;
 
+	spin_lock_init(&i2c_imx->slave_lock);
+	hrtimer_init(&i2c_imx->slave_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	i2c_imx->slave_timer.function = i2c_imx_slave_timeout;
+
 	match = device_get_match_data(&pdev->dev);
 	if (match)
 		i2c_imx->hwdata = match;
@@ -1491,6 +1548,8 @@ static int i2c_imx_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 
+	hrtimer_cancel(&i2c_imx->slave_timer);
+
 	/* remove adapter */
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
 	i2c_del_adapter(&i2c_imx->adapter);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 87ee616e6938..91b71fa3c121 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1705,7 +1705,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
 		/* SRQ resize is not supported */
-		break;
+		return -EINVAL;
 	case IB_SRQ_LIMIT:
 		/* Change the SRQ threshold */
 		if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)
@@ -1720,13 +1720,12 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
-		break;
+		return 0;
 	default:
 		ibdev_err(&rdev->ibdev,
 			  "Unsupported srq_attr_mask 0x%x", srq_attr_mask);
 		return -EINVAL;
 	}
-	return 0;
 }
 
 int bnxt_re_query_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr)
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 51ae58c02b15..802b0e5801a7 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -2089,7 +2089,7 @@ int init_credit_return(struct hfi1_devdata *dd)
 				   "Unable to allocate credit return DMA range for NUMA %d\n",
 				   i);
 			ret = -ENOMEM;
-			goto done;
+			goto free_cr_base;
 		}
 	}
 	set_dev_node(&dd->pcidev->dev, dd->node);
@@ -2097,6 +2097,10 @@ int init_credit_return(struct hfi1_devdata *dd)
 	ret = 0;
 done:
 	return ret;
+
+free_cr_base:
+	free_credit_return(dd);
+	goto done;
 }
 
 void free_credit_return(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 26c62162759b..969c5c3ab859 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3158,7 +3158,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index afd16a93ac69..504449fc36c2 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -345,6 +345,7 @@ enum irdma_cqp_op_type {
 #define IRDMA_AE_LLP_TOO_MANY_KEEPALIVE_RETRIES				0x050b
 #define IRDMA_AE_LLP_DOUBT_REACHABILITY					0x050c
 #define IRDMA_AE_LLP_CONNECTION_ESTABLISHED				0x050e
+#define IRDMA_AE_LLP_TOO_MANY_RNRS					0x050f
 #define IRDMA_AE_RESOURCE_EXHAUSTION					0x0520
 #define IRDMA_AE_RESET_SENT						0x0601
 #define IRDMA_AE_TERMINATE_SENT						0x0602
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 0359f415280c..8781638d7427 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -379,6 +379,7 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		case IRDMA_AE_LLP_TOO_MANY_RETRIES:
 		case IRDMA_AE_LCE_QP_CATASTROPHIC:
 		case IRDMA_AE_LCE_FUNCTION_CATASTROPHIC:
+		case IRDMA_AE_LLP_TOO_MANY_RNRS:
 		case IRDMA_AE_LCE_CQ_CATASTROPHIC:
 		case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
 		default:
@@ -562,6 +563,13 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
 	dev->irq_ops->irdma_dis_irq(dev, msix_vec->idx);
 	irq_set_affinity_hint(msix_vec->irq, NULL);
 	free_irq(msix_vec->irq, dev_id);
+	if (rf == dev_id) {
+		tasklet_kill(&rf->dpc_tasklet);
+	} else {
+		struct irdma_ceq *iwceq = (struct irdma_ceq *)dev_id;
+
+		tasklet_kill(&iwceq->dpc_tasklet);
+	}
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8981bf834a58..d43833e141a0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -749,7 +749,9 @@ static int irdma_validate_qp_attrs(struct ib_qp_init_attr *init_attr,
 
 	if (init_attr->cap.max_inline_data > uk_attrs->max_hw_inline ||
 	    init_attr->cap.max_send_sge > uk_attrs->max_hw_wq_frags ||
-	    init_attr->cap.max_recv_sge > uk_attrs->max_hw_wq_frags)
+	    init_attr->cap.max_recv_sge > uk_attrs->max_hw_wq_frags ||
+	    init_attr->cap.max_send_wr > uk_attrs->max_hw_wq_quanta ||
+	    init_attr->cap.max_recv_wr > uk_attrs->max_hw_rq_quanta)
 		return -EINVAL;
 
 	if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
@@ -2074,9 +2076,8 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		info.cq_base_pa = iwcq->kmem.pa;
 	}
 
-	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
-		info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
-						 (u32)IRDMA_MAX_CQ_READ_THRESH);
+	info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
+					 (u32)IRDMA_MAX_CQ_READ_THRESH);
 
 	if (irdma_sc_cq_init(cq, &info)) {
 		ibdev_dbg(&iwdev->ibdev, "VERBS: init cq fail\n");
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index bb0c2b93a34d..c0993e3bad12 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1888,8 +1888,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 		/* RQ - read access only (0) */
 		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
 					  ureq.rq_len, true, 0, alloc_and_init);
-		if (rc)
+		if (rc) {
+			ib_umem_release(qp->usq.umem);
+			qp->usq.umem = NULL;
+			if (rdma_protocol_roce(&dev->ibdev, 1)) {
+				qedr_free_pbl(dev, &qp->usq.pbl_info,
+					      qp->usq.pbl_tbl);
+			} else {
+				kfree(qp->usq.pbl_tbl);
+			}
 			return rc;
+		}
 	}
 
 	memset(&in_params, 0, sizeof(in_params));
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index ecd19a740867..116f1c38384b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1504,7 +1504,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 9c7fbda9e068..124242e387a5 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1492,7 +1492,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 
 	if (pbl->max_buf < num_sle) {
 		siw_dbg_mem(mem, "too many SGE's: %d > %d\n",
-			    mem->pbl->max_buf, num_sle);
+			    num_sle, pbl->max_buf);
 		return -ENOMEM;
 	}
 	for_each_sg(sl, slp, num_sle, i) {
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 38494943bd74..60f9c612eb3c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -79,12 +79,16 @@ module_param(srpt_srq_size, int, 0444);
 MODULE_PARM_DESC(srpt_srq_size,
 		 "Shared receive queue (SRQ) size.");
 
+static int srpt_set_u64_x(const char *buffer, const struct kernel_param *kp)
+{
+	return kstrtou64(buffer, 16, (u64 *)kp->arg);
+}
 static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
 {
 	return sprintf(buffer, "0x%016llx\n", *(u64 *)kp->arg);
 }
-module_param_call(srpt_service_guid, NULL, srpt_get_u64_x, &srpt_service_guid,
-		  0444);
+module_param_call(srpt_service_guid, srpt_set_u64_x, srpt_get_u64_x,
+		  &srpt_service_guid, 0444);
 MODULE_PARM_DESC(srpt_service_guid,
 		 "Using this value for ioc_guid, id_ext, and cm_listen_id instead of using the node_guid of the first HCA.");
 
@@ -210,10 +214,12 @@ static const char *get_ch_state_name(enum rdma_ch_state s)
 /**
  * srpt_qp_event - QP event callback function
  * @event: Description of the event that occurred.
- * @ch: SRPT RDMA channel.
+ * @ptr: SRPT RDMA channel.
  */
-static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
+static void srpt_qp_event(struct ib_event *event, void *ptr)
 {
+	struct srpt_rdma_ch *ch = ptr;
+
 	pr_debug("QP event %d on ch=%p sess_name=%s-%d state=%s\n",
 		 event->event, ch, ch->sess_name, ch->qp->qp_num,
 		 get_ch_state_name(ch->state));
@@ -1807,8 +1813,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	ch->cq_size = ch->rq_size + sq_size;
 
 	qp_init->qp_context = (void *)ch;
-	qp_init->event_handler
-		= (void(*)(struct ib_event *, void*))srpt_qp_event;
+	qp_init->event_handler = srpt_qp_event;
 	qp_init->send_cq = ch->cq;
 	qp_init->recv_cq = ch->cq;
 	qp_init->sq_sig_type = IB_SIGNAL_REQ_WR;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1ff0d4e24fe6..f0b1dac93822 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -276,6 +276,7 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
@@ -464,6 +465,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA Controllers */
diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index a348247d3d38..f4c3aff3895b 100644
--- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -9,6 +9,7 @@
  * axial sliders presented by the device.
  */
 
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -96,8 +97,6 @@
 #define IQS269_MISC_B_TRACKING_UI_ENABLE	BIT(4)
 #define IQS269_MISC_B_FILT_STR_SLIDER		GENMASK(1, 0)
 
-#define IQS269_CHx_SETTINGS			0x8C
-
 #define IQS269_CHx_ENG_A_MEAS_CAP_SIZE		BIT(15)
 #define IQS269_CHx_ENG_A_RX_GND_INACTIVE	BIT(13)
 #define IQS269_CHx_ENG_A_LOCAL_CAP_SIZE		BIT(12)
@@ -146,14 +145,7 @@
 #define IQS269_NUM_CH				8
 #define IQS269_NUM_SL				2
 
-#define IQS269_ATI_POLL_SLEEP_US		(iqs269->delay_mult * 10000)
-#define IQS269_ATI_POLL_TIMEOUT_US		(iqs269->delay_mult * 500000)
-#define IQS269_ATI_STABLE_DELAY_MS		(iqs269->delay_mult * 150)
-
-#define IQS269_PWR_MODE_POLL_SLEEP_US		IQS269_ATI_POLL_SLEEP_US
-#define IQS269_PWR_MODE_POLL_TIMEOUT_US		IQS269_ATI_POLL_TIMEOUT_US
-
-#define iqs269_irq_wait()			usleep_range(100, 150)
+#define iqs269_irq_wait()			usleep_range(200, 250)
 
 enum iqs269_local_cap_size {
 	IQS269_LOCAL_CAP_SIZE_0,
@@ -245,6 +237,18 @@ struct iqs269_ver_info {
 	u8 padding;
 } __packed;
 
+struct iqs269_ch_reg {
+	u8 rx_enable;
+	u8 tx_enable;
+	__be16 engine_a;
+	__be16 engine_b;
+	__be16 ati_comp;
+	u8 thresh[3];
+	u8 hyst;
+	u8 assoc_select;
+	u8 assoc_weight;
+} __packed;
+
 struct iqs269_sys_reg {
 	__be16 general;
 	u8 active;
@@ -266,18 +270,7 @@ struct iqs269_sys_reg {
 	u8 timeout_swipe;
 	u8 thresh_swipe;
 	u8 redo_ati;
-} __packed;
-
-struct iqs269_ch_reg {
-	u8 rx_enable;
-	u8 tx_enable;
-	__be16 engine_a;
-	__be16 engine_b;
-	__be16 ati_comp;
-	u8 thresh[3];
-	u8 hyst;
-	u8 assoc_select;
-	u8 assoc_weight;
+	struct iqs269_ch_reg ch_reg[IQS269_NUM_CH];
 } __packed;
 
 struct iqs269_flags {
@@ -292,13 +285,11 @@ struct iqs269_private {
 	struct regmap *regmap;
 	struct mutex lock;
 	struct iqs269_switch_desc switches[ARRAY_SIZE(iqs269_events)];
-	struct iqs269_ch_reg ch_reg[IQS269_NUM_CH];
 	struct iqs269_sys_reg sys_reg;
+	struct completion ati_done;
 	struct input_dev *keypad;
 	struct input_dev *slider[IQS269_NUM_SL];
 	unsigned int keycode[ARRAY_SIZE(iqs269_events) * IQS269_NUM_CH];
-	unsigned int suspend_mode;
-	unsigned int delay_mult;
 	unsigned int ch_num;
 	bool hall_enable;
 	bool ati_current;
@@ -307,6 +298,7 @@ struct iqs269_private {
 static int iqs269_ati_mode_set(struct iqs269_private *iqs269,
 			       unsigned int ch_num, unsigned int mode)
 {
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	u16 engine_a;
 
 	if (ch_num >= IQS269_NUM_CH)
@@ -317,12 +309,12 @@ static int iqs269_ati_mode_set(struct iqs269_private *iqs269,
 
 	mutex_lock(&iqs269->lock);
 
-	engine_a = be16_to_cpu(iqs269->ch_reg[ch_num].engine_a);
+	engine_a = be16_to_cpu(ch_reg[ch_num].engine_a);
 
 	engine_a &= ~IQS269_CHx_ENG_A_ATI_MODE_MASK;
 	engine_a |= (mode << IQS269_CHx_ENG_A_ATI_MODE_SHIFT);
 
-	iqs269->ch_reg[ch_num].engine_a = cpu_to_be16(engine_a);
+	ch_reg[ch_num].engine_a = cpu_to_be16(engine_a);
 	iqs269->ati_current = false;
 
 	mutex_unlock(&iqs269->lock);
@@ -333,13 +325,14 @@ static int iqs269_ati_mode_set(struct iqs269_private *iqs269,
 static int iqs269_ati_mode_get(struct iqs269_private *iqs269,
 			       unsigned int ch_num, unsigned int *mode)
 {
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	u16 engine_a;
 
 	if (ch_num >= IQS269_NUM_CH)
 		return -EINVAL;
 
 	mutex_lock(&iqs269->lock);
-	engine_a = be16_to_cpu(iqs269->ch_reg[ch_num].engine_a);
+	engine_a = be16_to_cpu(ch_reg[ch_num].engine_a);
 	mutex_unlock(&iqs269->lock);
 
 	engine_a &= IQS269_CHx_ENG_A_ATI_MODE_MASK;
@@ -351,6 +344,7 @@ static int iqs269_ati_mode_get(struct iqs269_private *iqs269,
 static int iqs269_ati_base_set(struct iqs269_private *iqs269,
 			       unsigned int ch_num, unsigned int base)
 {
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	u16 engine_b;
 
 	if (ch_num >= IQS269_NUM_CH)
@@ -379,12 +373,12 @@ static int iqs269_ati_base_set(struct iqs269_private *iqs269,
 
 	mutex_lock(&iqs269->lock);
 
-	engine_b = be16_to_cpu(iqs269->ch_reg[ch_num].engine_b);
+	engine_b = be16_to_cpu(ch_reg[ch_num].engine_b);
 
 	engine_b &= ~IQS269_CHx_ENG_B_ATI_BASE_MASK;
 	engine_b |= base;
 
-	iqs269->ch_reg[ch_num].engine_b = cpu_to_be16(engine_b);
+	ch_reg[ch_num].engine_b = cpu_to_be16(engine_b);
 	iqs269->ati_current = false;
 
 	mutex_unlock(&iqs269->lock);
@@ -395,13 +389,14 @@ static int iqs269_ati_base_set(struct iqs269_private *iqs269,
 static int iqs269_ati_base_get(struct iqs269_private *iqs269,
 			       unsigned int ch_num, unsigned int *base)
 {
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	u16 engine_b;
 
 	if (ch_num >= IQS269_NUM_CH)
 		return -EINVAL;
 
 	mutex_lock(&iqs269->lock);
-	engine_b = be16_to_cpu(iqs269->ch_reg[ch_num].engine_b);
+	engine_b = be16_to_cpu(ch_reg[ch_num].engine_b);
 	mutex_unlock(&iqs269->lock);
 
 	switch (engine_b & IQS269_CHx_ENG_B_ATI_BASE_MASK) {
@@ -429,6 +424,7 @@ static int iqs269_ati_base_get(struct iqs269_private *iqs269,
 static int iqs269_ati_target_set(struct iqs269_private *iqs269,
 				 unsigned int ch_num, unsigned int target)
 {
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	u16 engine_b;
 
 	if (ch_num >= IQS269_NUM_CH)
@@ -439,12 +435,12 @@ static int iqs269_ati_target_set(struct iqs269_private *iqs269,
 
 	mutex_lock(&iqs269->lock);
 
-	engine_b = be16_to_cpu(iqs269->ch_reg[ch_num].engine_b);
+	engine_b = be16_to_cpu(ch_reg[ch_num].engine_b);
 
 	engine_b &= ~IQS269_CHx_ENG_B_ATI_TARGET_MASK;
 	engine_b |= target / 32;
 
-	iqs269->ch_reg[ch_num].engine_b = cpu_to_be16(engine_b);
+	ch_reg[ch_num].engine_b = cpu_to_be16(engine_b);
 	iqs269->ati_current = false;
 
 	mutex_unlock(&iqs269->lock);
@@ -455,13 +451,14 @@ static int iqs269_ati_target_set(struct iqs269_private *iqs269,
 static int iqs269_ati_target_get(struct iqs269_private *iqs269,
 				 unsigned int ch_num, unsigned int *target)
 {
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	u16 engine_b;
 
 	if (ch_num >= IQS269_NUM_CH)
 		return -EINVAL;
 
 	mutex_lock(&iqs269->lock);
-	engine_b = be16_to_cpu(iqs269->ch_reg[ch_num].engine_b);
+	engine_b = be16_to_cpu(ch_reg[ch_num].engine_b);
 	mutex_unlock(&iqs269->lock);
 
 	*target = (engine_b & IQS269_CHx_ENG_B_ATI_TARGET_MASK) * 32;
@@ -531,13 +528,7 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 	if (fwnode_property_present(ch_node, "azoteq,slider1-select"))
 		iqs269->sys_reg.slider_select[1] |= BIT(reg);
 
-	ch_reg = &iqs269->ch_reg[reg];
-
-	error = regmap_raw_read(iqs269->regmap,
-				IQS269_CHx_SETTINGS + reg * sizeof(*ch_reg) / 2,
-				ch_reg, sizeof(*ch_reg));
-	if (error)
-		return error;
+	ch_reg = &iqs269->sys_reg.ch_reg[reg];
 
 	error = iqs269_parse_mask(ch_node, "azoteq,rx-enable",
 				  &ch_reg->rx_enable);
@@ -694,6 +685,7 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 				dev_err(&client->dev,
 					"Invalid channel %u threshold: %u\n",
 					reg, val);
+				fwnode_handle_put(ev_node);
 				return -EINVAL;
 			}
 
@@ -707,6 +699,7 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 				dev_err(&client->dev,
 					"Invalid channel %u hysteresis: %u\n",
 					reg, val);
+				fwnode_handle_put(ev_node);
 				return -EINVAL;
 			}
 
@@ -721,8 +714,16 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 			}
 		}
 
-		if (fwnode_property_read_u32(ev_node, "linux,code", &val))
+		error = fwnode_property_read_u32(ev_node, "linux,code", &val);
+		fwnode_handle_put(ev_node);
+		if (error == -EINVAL) {
 			continue;
+		} else if (error) {
+			dev_err(&client->dev,
+				"Failed to read channel %u code: %d\n", reg,
+				error);
+			return error;
+		}
 
 		switch (reg) {
 		case IQS269_CHx_HALL_ACTIVE:
@@ -759,17 +760,6 @@ static int iqs269_parse_prop(struct iqs269_private *iqs269)
 	iqs269->hall_enable = device_property_present(&client->dev,
 						      "azoteq,hall-enable");
 
-	if (!device_property_read_u32(&client->dev, "azoteq,suspend-mode",
-				      &val)) {
-		if (val > IQS269_SYS_SETTINGS_PWR_MODE_MAX) {
-			dev_err(&client->dev, "Invalid suspend mode: %u\n",
-				val);
-			return -EINVAL;
-		}
-
-		iqs269->suspend_mode = val;
-	}
-
 	error = regmap_raw_read(iqs269->regmap, IQS269_SYS_SETTINGS, sys_reg,
 				sizeof(*sys_reg));
 	if (error)
@@ -980,13 +970,8 @@ static int iqs269_parse_prop(struct iqs269_private *iqs269)
 
 	general = be16_to_cpu(sys_reg->general);
 
-	if (device_property_present(&client->dev, "azoteq,clk-div")) {
+	if (device_property_present(&client->dev, "azoteq,clk-div"))
 		general |= IQS269_SYS_SETTINGS_CLK_DIV;
-		iqs269->delay_mult = 4;
-	} else {
-		general &= ~IQS269_SYS_SETTINGS_CLK_DIV;
-		iqs269->delay_mult = 1;
-	}
 
 	/*
 	 * Configure the device to automatically switch between normal and low-
@@ -997,6 +982,17 @@ static int iqs269_parse_prop(struct iqs269_private *iqs269)
 	general &= ~IQS269_SYS_SETTINGS_DIS_AUTO;
 	general &= ~IQS269_SYS_SETTINGS_PWR_MODE_MASK;
 
+	if (!device_property_read_u32(&client->dev, "azoteq,suspend-mode",
+				      &val)) {
+		if (val > IQS269_SYS_SETTINGS_PWR_MODE_MAX) {
+			dev_err(&client->dev, "Invalid suspend mode: %u\n",
+				val);
+			return -EINVAL;
+		}
+
+		general |= (val << IQS269_SYS_SETTINGS_PWR_MODE_SHIFT);
+	}
+
 	if (!device_property_read_u32(&client->dev, "azoteq,ulp-update",
 				      &val)) {
 		if (val > IQS269_SYS_SETTINGS_ULP_UPDATE_MAX) {
@@ -1032,10 +1028,7 @@ static int iqs269_parse_prop(struct iqs269_private *iqs269)
 
 static int iqs269_dev_init(struct iqs269_private *iqs269)
 {
-	struct iqs269_sys_reg *sys_reg = &iqs269->sys_reg;
-	struct iqs269_ch_reg *ch_reg;
-	unsigned int val;
-	int error, i;
+	int error;
 
 	mutex_lock(&iqs269->lock);
 
@@ -1045,38 +1038,17 @@ static int iqs269_dev_init(struct iqs269_private *iqs269)
 	if (error)
 		goto err_mutex;
 
-	for (i = 0; i < IQS269_NUM_CH; i++) {
-		if (!(sys_reg->active & BIT(i)))
-			continue;
-
-		ch_reg = &iqs269->ch_reg[i];
-
-		error = regmap_raw_write(iqs269->regmap,
-					 IQS269_CHx_SETTINGS + i *
-					 sizeof(*ch_reg) / 2, ch_reg,
-					 sizeof(*ch_reg));
-		if (error)
-			goto err_mutex;
-	}
-
-	/*
-	 * The REDO-ATI and ATI channel selection fields must be written in the
-	 * same block write, so every field between registers 0x80 through 0x8B
-	 * (inclusive) must be written as well.
-	 */
-	error = regmap_raw_write(iqs269->regmap, IQS269_SYS_SETTINGS, sys_reg,
-				 sizeof(*sys_reg));
+	error = regmap_raw_write(iqs269->regmap, IQS269_SYS_SETTINGS,
+				 &iqs269->sys_reg, sizeof(iqs269->sys_reg));
 	if (error)
 		goto err_mutex;
 
-	error = regmap_read_poll_timeout(iqs269->regmap, IQS269_SYS_FLAGS, val,
-					!(val & IQS269_SYS_FLAGS_IN_ATI),
-					 IQS269_ATI_POLL_SLEEP_US,
-					 IQS269_ATI_POLL_TIMEOUT_US);
-	if (error)
-		goto err_mutex;
+	/*
+	 * The following delay gives the device time to deassert its RDY output
+	 * so as to prevent an interrupt from being serviced prematurely.
+	 */
+	usleep_range(2000, 2100);
 
-	msleep(IQS269_ATI_STABLE_DELAY_MS);
 	iqs269->ati_current = true;
 
 err_mutex:
@@ -1088,10 +1060,8 @@ static int iqs269_dev_init(struct iqs269_private *iqs269)
 static int iqs269_input_init(struct iqs269_private *iqs269)
 {
 	struct i2c_client *client = iqs269->client;
-	struct iqs269_flags flags;
 	unsigned int sw_code, keycode;
 	int error, i, j;
-	u8 dir_mask, state;
 
 	iqs269->keypad = devm_input_allocate_device(&client->dev);
 	if (!iqs269->keypad)
@@ -1104,23 +1074,7 @@ static int iqs269_input_init(struct iqs269_private *iqs269)
 	iqs269->keypad->name = "iqs269a_keypad";
 	iqs269->keypad->id.bustype = BUS_I2C;
 
-	if (iqs269->hall_enable) {
-		error = regmap_raw_read(iqs269->regmap, IQS269_SYS_FLAGS,
-					&flags, sizeof(flags));
-		if (error) {
-			dev_err(&client->dev,
-				"Failed to read initial status: %d\n", error);
-			return error;
-		}
-	}
-
 	for (i = 0; i < ARRAY_SIZE(iqs269_events); i++) {
-		dir_mask = flags.states[IQS269_ST_OFFS_DIR];
-		if (!iqs269_events[i].dir_up)
-			dir_mask = ~dir_mask;
-
-		state = flags.states[iqs269_events[i].st_offs] & dir_mask;
-
 		sw_code = iqs269->switches[i].code;
 
 		for (j = 0; j < IQS269_NUM_CH; j++) {
@@ -1133,13 +1087,9 @@ static int iqs269_input_init(struct iqs269_private *iqs269)
 			switch (j) {
 			case IQS269_CHx_HALL_ACTIVE:
 				if (iqs269->hall_enable &&
-				    iqs269->switches[i].enabled) {
+				    iqs269->switches[i].enabled)
 					input_set_capability(iqs269->keypad,
 							     EV_SW, sw_code);
-					input_report_switch(iqs269->keypad,
-							    sw_code,
-							    state & BIT(j));
-				}
 				fallthrough;
 
 			case IQS269_CHx_HALL_INACTIVE:
@@ -1155,14 +1105,6 @@ static int iqs269_input_init(struct iqs269_private *iqs269)
 		}
 	}
 
-	input_sync(iqs269->keypad);
-
-	error = input_register_device(iqs269->keypad);
-	if (error) {
-		dev_err(&client->dev, "Failed to register keypad: %d\n", error);
-		return error;
-	}
-
 	for (i = 0; i < IQS269_NUM_SL; i++) {
 		if (!iqs269->sys_reg.slider_select[i])
 			continue;
@@ -1222,6 +1164,9 @@ static int iqs269_report(struct iqs269_private *iqs269)
 		return error;
 	}
 
+	if (be16_to_cpu(flags.system) & IQS269_SYS_FLAGS_IN_ATI)
+		return 0;
+
 	error = regmap_raw_read(iqs269->regmap, IQS269_SLIDER_X, slider_x,
 				sizeof(slider_x));
 	if (error) {
@@ -1284,6 +1229,12 @@ static int iqs269_report(struct iqs269_private *iqs269)
 
 	input_sync(iqs269->keypad);
 
+	/*
+	 * The following completion signals that ATI has finished, any initial
+	 * switch states have been reported and the keypad can be registered.
+	 */
+	complete_all(&iqs269->ati_done);
+
 	return 0;
 }
 
@@ -1315,6 +1266,9 @@ static ssize_t counts_show(struct device *dev,
 	if (!iqs269->ati_current || iqs269->hall_enable)
 		return -EPERM;
 
+	if (!completion_done(&iqs269->ati_done))
+		return -EBUSY;
+
 	/*
 	 * Unsolicited I2C communication prompts the device to assert its RDY
 	 * pin, so disable the interrupt line until the operation is finished
@@ -1339,6 +1293,7 @@ static ssize_t hall_bin_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	struct i2c_client *client = iqs269->client;
 	unsigned int val;
 	int error;
@@ -1353,8 +1308,8 @@ static ssize_t hall_bin_show(struct device *dev,
 	if (error)
 		return error;
 
-	switch (iqs269->ch_reg[IQS269_CHx_HALL_ACTIVE].rx_enable &
-		iqs269->ch_reg[IQS269_CHx_HALL_INACTIVE].rx_enable) {
+	switch (ch_reg[IQS269_CHx_HALL_ACTIVE].rx_enable &
+		ch_reg[IQS269_CHx_HALL_INACTIVE].rx_enable) {
 	case IQS269_HALL_PAD_R:
 		val &= IQS269_CAL_DATA_A_HALL_BIN_R_MASK;
 		val >>= IQS269_CAL_DATA_A_HALL_BIN_R_SHIFT;
@@ -1434,9 +1389,10 @@ static ssize_t rx_enable_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 
 	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 iqs269->ch_reg[iqs269->ch_num].rx_enable);
+			 ch_reg[iqs269->ch_num].rx_enable);
 }
 
 static ssize_t rx_enable_store(struct device *dev,
@@ -1444,6 +1400,7 @@ static ssize_t rx_enable_store(struct device *dev,
 			       size_t count)
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
+	struct iqs269_ch_reg *ch_reg = iqs269->sys_reg.ch_reg;
 	unsigned int val;
 	int error;
 
@@ -1456,7 +1413,7 @@ static ssize_t rx_enable_store(struct device *dev,
 
 	mutex_lock(&iqs269->lock);
 
-	iqs269->ch_reg[iqs269->ch_num].rx_enable = val;
+	ch_reg[iqs269->ch_num].rx_enable = val;
 	iqs269->ati_current = false;
 
 	mutex_unlock(&iqs269->lock);
@@ -1568,7 +1525,9 @@ static ssize_t ati_trigger_show(struct device *dev,
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->ati_current);
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 iqs269->ati_current &&
+			 completion_done(&iqs269->ati_done));
 }
 
 static ssize_t ati_trigger_store(struct device *dev,
@@ -1588,6 +1547,7 @@ static ssize_t ati_trigger_store(struct device *dev,
 		return count;
 
 	disable_irq(client->irq);
+	reinit_completion(&iqs269->ati_done);
 
 	error = iqs269_dev_init(iqs269);
 
@@ -1597,6 +1557,10 @@ static ssize_t ati_trigger_store(struct device *dev,
 	if (error)
 		return error;
 
+	if (!wait_for_completion_timeout(&iqs269->ati_done,
+					 msecs_to_jiffies(2000)))
+		return -ETIMEDOUT;
+
 	return count;
 }
 
@@ -1655,6 +1619,7 @@ static int iqs269_probe(struct i2c_client *client)
 	}
 
 	mutex_init(&iqs269->lock);
+	init_completion(&iqs269->ati_done);
 
 	error = regmap_raw_read(iqs269->regmap, IQS269_VER_INFO, &ver_info,
 				sizeof(ver_info));
@@ -1690,6 +1655,22 @@ static int iqs269_probe(struct i2c_client *client)
 		return error;
 	}
 
+	if (!wait_for_completion_timeout(&iqs269->ati_done,
+					 msecs_to_jiffies(2000))) {
+		dev_err(&client->dev, "Failed to complete ATI\n");
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * The keypad may include one or more switches and is not registered
+	 * until ATI is complete and the initial switch states are read.
+	 */
+	error = input_register_device(iqs269->keypad);
+	if (error) {
+		dev_err(&client->dev, "Failed to register keypad: %d\n", error);
+		return error;
+	}
+
 	error = devm_device_add_group(&client->dev, &iqs269_attr_group);
 	if (error)
 		dev_err(&client->dev, "Failed to add attributes: %d\n", error);
@@ -1697,113 +1678,61 @@ static int iqs269_probe(struct i2c_client *client)
 	return error;
 }
 
-static int __maybe_unused iqs269_suspend(struct device *dev)
+static u16 iqs269_general_get(struct iqs269_private *iqs269)
+{
+	u16 general = be16_to_cpu(iqs269->sys_reg.general);
+
+	general &= ~IQS269_SYS_SETTINGS_REDO_ATI;
+	general &= ~IQS269_SYS_SETTINGS_ACK_RESET;
+
+	return general | IQS269_SYS_SETTINGS_DIS_AUTO;
+}
+
+static int iqs269_suspend(struct device *dev)
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
 	struct i2c_client *client = iqs269->client;
-	unsigned int val;
 	int error;
+	u16 general = iqs269_general_get(iqs269);
 
-	if (!iqs269->suspend_mode)
+	if (!(general & IQS269_SYS_SETTINGS_PWR_MODE_MASK))
 		return 0;
 
 	disable_irq(client->irq);
 
-	/*
-	 * Automatic power mode switching must be disabled before the device is
-	 * forced into any particular power mode. In this case, the device will
-	 * transition into normal-power mode.
-	 */
-	error = regmap_update_bits(iqs269->regmap, IQS269_SYS_SETTINGS,
-				   IQS269_SYS_SETTINGS_DIS_AUTO, ~0);
-	if (error)
-		goto err_irq;
-
-	/*
-	 * The following check ensures the device has completed its transition
-	 * into normal-power mode before a manual mode switch is performed.
-	 */
-	error = regmap_read_poll_timeout(iqs269->regmap, IQS269_SYS_FLAGS, val,
-					!(val & IQS269_SYS_FLAGS_PWR_MODE_MASK),
-					 IQS269_PWR_MODE_POLL_SLEEP_US,
-					 IQS269_PWR_MODE_POLL_TIMEOUT_US);
-	if (error)
-		goto err_irq;
-
-	error = regmap_update_bits(iqs269->regmap, IQS269_SYS_SETTINGS,
-				   IQS269_SYS_SETTINGS_PWR_MODE_MASK,
-				   iqs269->suspend_mode <<
-				   IQS269_SYS_SETTINGS_PWR_MODE_SHIFT);
-	if (error)
-		goto err_irq;
+	error = regmap_write(iqs269->regmap, IQS269_SYS_SETTINGS, general);
 
-	/*
-	 * This last check ensures the device has completed its transition into
-	 * the desired power mode to prevent any spurious interrupts from being
-	 * triggered after iqs269_suspend has already returned.
-	 */
-	error = regmap_read_poll_timeout(iqs269->regmap, IQS269_SYS_FLAGS, val,
-					 (val & IQS269_SYS_FLAGS_PWR_MODE_MASK)
-					 == (iqs269->suspend_mode <<
-					     IQS269_SYS_FLAGS_PWR_MODE_SHIFT),
-					 IQS269_PWR_MODE_POLL_SLEEP_US,
-					 IQS269_PWR_MODE_POLL_TIMEOUT_US);
-
-err_irq:
 	iqs269_irq_wait();
 	enable_irq(client->irq);
 
 	return error;
 }
 
-static int __maybe_unused iqs269_resume(struct device *dev)
+static int iqs269_resume(struct device *dev)
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);
 	struct i2c_client *client = iqs269->client;
-	unsigned int val;
 	int error;
+	u16 general = iqs269_general_get(iqs269);
 
-	if (!iqs269->suspend_mode)
+	if (!(general & IQS269_SYS_SETTINGS_PWR_MODE_MASK))
 		return 0;
 
 	disable_irq(client->irq);
 
-	error = regmap_update_bits(iqs269->regmap, IQS269_SYS_SETTINGS,
-				   IQS269_SYS_SETTINGS_PWR_MODE_MASK, 0);
-	if (error)
-		goto err_irq;
-
-	/*
-	 * This check ensures the device has returned to normal-power mode
-	 * before automatic power mode switching is re-enabled.
-	 */
-	error = regmap_read_poll_timeout(iqs269->regmap, IQS269_SYS_FLAGS, val,
-					!(val & IQS269_SYS_FLAGS_PWR_MODE_MASK),
-					 IQS269_PWR_MODE_POLL_SLEEP_US,
-					 IQS269_PWR_MODE_POLL_TIMEOUT_US);
-	if (error)
-		goto err_irq;
-
-	error = regmap_update_bits(iqs269->regmap, IQS269_SYS_SETTINGS,
-				   IQS269_SYS_SETTINGS_DIS_AUTO, 0);
-	if (error)
-		goto err_irq;
-
-	/*
-	 * This step reports any events that may have been "swallowed" as a
-	 * result of polling PWR_MODE (which automatically acknowledges any
-	 * pending interrupts).
-	 */
-	error = iqs269_report(iqs269);
+	error = regmap_write(iqs269->regmap, IQS269_SYS_SETTINGS,
+			     general & ~IQS269_SYS_SETTINGS_PWR_MODE_MASK);
+	if (!error)
+		error = regmap_write(iqs269->regmap, IQS269_SYS_SETTINGS,
+				     general & ~IQS269_SYS_SETTINGS_DIS_AUTO);
 
-err_irq:
 	iqs269_irq_wait();
 	enable_irq(client->irq);
 
 	return error;
 }
 
-static SIMPLE_DEV_PM_OPS(iqs269_pm, iqs269_suspend, iqs269_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(iqs269_pm, iqs269_suspend, iqs269_resume);
 
 static const struct of_device_id iqs269_of_match[] = {
 	{ .compatible = "azoteq,iqs269a" },
@@ -1815,7 +1744,7 @@ static struct i2c_driver iqs269_i2c_driver = {
 	.driver = {
 		.name = "iqs269a",
 		.of_match_table = iqs269_of_match,
-		.pm = &iqs269_pm,
+		.pm = pm_sleep_ptr(&iqs269_pm),
 	},
 	.probe_new = iqs269_probe,
 };
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 359d1a287a78..d4792950bcff 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -625,6 +625,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
 	},
+	{
+		/* Fujitsu Lifebook U728 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U728"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f113a27aeb1e..1db61185f7be 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -851,14 +851,8 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (ts->model == 7843) {
+	if (ts->model == 7843 || ts->model == 7845) {
 		Rt = ts->pressure_max / 2;
-	} else if (ts->model == 7845) {
-		if (get_pendown_state(ts))
-			Rt = ts->pressure_max / 2;
-		else
-			Rt = 0;
-		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
 	} else if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
@@ -1074,6 +1068,9 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
 		unsigned int max_count;
 
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
 		if (ads7846_cmd_need_settle(cmd_idx))
 			max_count = packet->count + packet->count_skip;
 		else
@@ -1110,7 +1107,12 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 
 	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
-		u8 cmd = ads7846_get_cmd(cmd_idx, vref);
+		u8 cmd;
+
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
+		cmd = ads7846_get_cmd(cmd_idx, vref);
 
 		for (b = 0; b < l->count; b++)
 			packet->tx[l->offset + b].cmd = cmd;
@@ -1323,8 +1325,9 @@ static int ads7846_probe(struct spi_device *spi)
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+	if (ts->model != 7845)
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				pdata->pressure_min, pdata->pressure_max, 0, 0);
 
 	/*
 	 * Parse common framework properties. Must be done here to ensure the
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a428770102a3..5904af05f605 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2065,6 +2065,12 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	io->ctx.bio_out = clone;
 	io->ctx.iter_out = clone->bi_iter;
 
+	if (crypt_integrity_aead(cc)) {
+		bio_copy_data(clone, io->base_bio);
+		io->ctx.bio_in = clone;
+		io->ctx.iter_in = clone->bi_iter;
+	}
+
 	sector += bio_sectors(clone);
 
 	crypt_inc_pending(io);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ff65e5eddfa1..a17f2f725822 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4919,11 +4919,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			return -EINVAL;
 		err = mddev_lock(mddev);
 		if (!err) {
-			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 				err =  -EBUSY;
-			else {
+			} else if (mddev->reshape_position == MaxSector ||
+				   mddev->pers->check_reshape == NULL ||
+				   mddev->pers->check_reshape(mddev)) {
 				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 				err = mddev->pers->start_reshape(mddev);
+			} else {
+				/*
+				 * If reshape is still in progress, and
+				 * md_check_recovery() can continue to reshape,
+				 * don't restart reshape because data can be
+				 * corrupted for raid456.
+				 */
+				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			}
 			mddev_unlock(mddev);
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 910e7db7d573..ae84aaa1645c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -903,6 +903,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			else
 				submit_bio_noacct(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1116,6 +1117,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		else
 			submit_bio_noacct(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 8586447d4b4f..2254db44fb02 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1133,18 +1133,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
+static int jz4740_mmc_suspend(struct device *dev)
 {
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused jz4740_mmc_resume(struct device *dev)
+static int jz4740_mmc_resume(struct device *dev)
 {
 	return pinctrl_select_default_state(dev);
 }
 
-static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
-	jz4740_mmc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
+				jz4740_mmc_resume);
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
@@ -1153,7 +1153,7 @@ static struct platform_driver jz4740_mmc_driver = {
 		.name = "jz4740-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(jz4740_mmc_of_match),
-		.pm = pm_ptr(&jz4740_mmc_pm_ops),
+		.pm = pm_sleep_ptr(&jz4740_mmc_pm_ops),
 	},
 };
 
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 97227ad71715..2e39b2cb1caf 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1185,7 +1185,6 @@ static int mxcmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mxcmci_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
@@ -1212,9 +1211,8 @@ static int mxcmci_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
@@ -1222,7 +1220,7 @@ static struct platform_driver mxcmci_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &mxcmci_pm_ops,
+		.pm	= pm_sleep_ptr(&mxcmci_pm_ops),
 		.of_match_table	= mxcmci_of_match,
 	}
 };
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index ea953e31933e..e03dcdd8bd58 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1609,7 +1609,7 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section < ecc->steps)
 		oobregion->length = 4;
 	else
-		oobregion->offset = mtd->oobsize - oobregion->offset;
+		oobregion->length = mtd->oobsize - oobregion->offset;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c01114cabbb0..7c42a99be506 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9451,6 +9451,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (state == pci_channel_io_normal) {
+		dev_warn(&pdev->dev, "Non-correctable non-fatal error reported.\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
 	netif_device_detach(netdev);
 
 	if (state == pci_channel_io_perm_failure)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 70b4f2a3b02f..604aaa9b960e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -436,6 +436,10 @@ static void npc_fixup_vf_rule(struct rvu *rvu, struct npc_mcam *mcam,
 			return;
 	}
 
+	/* AF modifies given action iff PF/VF has requested for it */
+	if ((entry->action & 0xFULL) != NIX_RX_ACTION_DEFAULT)
+		return;
+
 	/* copy VF default entry action to the VF mcam entry */
 	rx_action = npc_get_default_entry_action(rvu, mcam, blkaddr,
 						 target_func);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 16888e3f0929..b8ac07be6157 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4897,8 +4897,6 @@ static void rtl8169_net_suspend(struct rtl8169_private *tp)
 		rtl8169_down(tp);
 }
 
-#ifdef CONFIG_PM
-
 static int rtl8169_runtime_resume(struct device *dev)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(dev);
@@ -4914,7 +4912,7 @@ static int rtl8169_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rtl8169_suspend(struct device *device)
+static int rtl8169_suspend(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
@@ -4927,7 +4925,7 @@ static int __maybe_unused rtl8169_suspend(struct device *device)
 	return 0;
 }
 
-static int __maybe_unused rtl8169_resume(struct device *device)
+static int rtl8169_resume(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
@@ -4969,13 +4967,11 @@ static int rtl8169_runtime_idle(struct device *device)
 }
 
 static const struct dev_pm_ops rtl8169_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(rtl8169_suspend, rtl8169_resume)
-	SET_RUNTIME_PM_OPS(rtl8169_runtime_suspend, rtl8169_runtime_resume,
-			   rtl8169_runtime_idle)
+	SYSTEM_SLEEP_PM_OPS(rtl8169_suspend, rtl8169_resume)
+	RUNTIME_PM_OPS(rtl8169_runtime_suspend, rtl8169_runtime_resume,
+		       rtl8169_runtime_idle)
 };
 
-#endif /* CONFIG_PM */
-
 static void rtl_wol_shutdown_quirk(struct rtl8169_private *tp)
 {
 	/* WoL fails with 8168b when the receiver is disabled. */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ab3ded6e0e6a..a1c1e353ca07 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5737,11 +5737,6 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -5757,11 +5752,6 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -5781,11 +5771,6 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 
 	priv = container_of(tx_q, struct stmmac_priv, tx_queue[chan]);
 
-	if (unlikely(!data)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -5824,11 +5809,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 
 	priv = container_of(rx_q, struct stmmac_priv, rx_queue[chan]);
 
-	if (unlikely(!data)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 1fa6f0dacd2d..f94d6d322df4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1856,13 +1856,14 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		if (ret < 0) {
 			dev_err(dev, "%pOF error reading port_id %d\n",
 				port_np, ret);
-			return ret;
+			goto of_node_put;
 		}
 
 		if (!port_id || port_id > common->port_num) {
 			dev_err(dev, "%pOF has invalid port_id %u %s\n",
 				port_np, port_id, port_np->name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto of_node_put;
 		}
 
 		port = am65_common_get_port(common, port_id);
@@ -1878,8 +1879,10 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 				(AM65_CPSW_NU_FRAM_PORT_OFFSET * (port_id - 1));
 
 		port->slave.mac_sl = cpsw_sl_get("am65", dev, port->port_base);
-		if (IS_ERR(port->slave.mac_sl))
-			return PTR_ERR(port->slave.mac_sl);
+		if (IS_ERR(port->slave.mac_sl)) {
+			ret = PTR_ERR(port->slave.mac_sl);
+			goto of_node_put;
+		}
 
 		port->disabled = !of_device_is_available(port_np);
 		if (port->disabled) {
@@ -1892,7 +1895,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 			ret = PTR_ERR(port->slave.ifphy);
 			dev_err(dev, "%pOF error retrieving port phy: %d\n",
 				port_np, ret);
-			return ret;
+			goto of_node_put;
 		}
 
 		port->slave.mac_only =
@@ -1901,10 +1904,12 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		/* get phy/link info */
 		if (of_phy_is_fixed_link(port_np)) {
 			ret = of_phy_register_fixed_link(port_np);
-			if (ret)
-				return dev_err_probe(dev, ret,
+			if (ret) {
+				ret = dev_err_probe(dev, ret,
 						     "failed to register fixed-link phy %pOF\n",
 						     port_np);
+				goto of_node_put;
+			}
 			port->slave.phy_node = of_node_get(port_np);
 		} else {
 			port->slave.phy_node =
@@ -1914,14 +1919,15 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		if (!port->slave.phy_node) {
 			dev_err(dev,
 				"slave[%d] no phy found\n", port_id);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto of_node_put;
 		}
 
 		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
 		if (ret) {
 			dev_err(dev, "%pOF read phy-mode err %d\n",
 				port_np, ret);
-			return ret;
+			goto of_node_put;
 		}
 
 		ret = of_get_mac_address(port_np, port->slave.mac_addr);
@@ -1944,6 +1950,11 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 	}
 
 	return 0;
+
+of_node_put:
+	of_node_put(port_np);
+	of_node_put(node);
+	return ret;
 }
 
 static void am65_cpsw_pcpu_stats_free(void *data)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 69bbc868b947..b656fbb5ba54 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1426,20 +1426,20 @@ static int __init gtp_init(void)
 	if (err < 0)
 		goto error_out;
 
-	err = genl_register_family(&gtp_genl_family);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto unreg_rtnl_link;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_genl_family;
+		goto unreg_pernet_subsys;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_genl_family:
-	genl_unregister_family(&gtp_genl_family);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
 error_out:
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ae6e14fe03c7..c58fd836d4ad 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6312,7 +6312,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH11K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH11K_MIN_6G_FREQ) {
 			channels = kmemdup(ath11k_6ghz_channels,
 					   sizeof(ath11k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 45dfee3ad8c6..2d1755598b47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2544,7 +2544,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..8dfd317509aa 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -220,11 +220,6 @@ static LIST_HEAD(nvme_fc_lport_list);
 static DEFINE_IDA(nvme_fc_local_port_cnt);
 static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
-static struct workqueue_struct *nvme_fc_wq;
-
-static bool nvme_fc_waiting_to_unload;
-static DECLARE_COMPLETION(nvme_fc_unload_proceed);
-
 /*
  * These items are short-term. They will eventually be moved into
  * a generic FC class. See comments in module init.
@@ -254,8 +249,6 @@ nvme_fc_free_lport(struct kref *ref)
 	/* remove from transport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_del(&lport->port_list);
-	if (nvme_fc_waiting_to_unload && list_empty(&nvme_fc_lport_list))
-		complete(&nvme_fc_unload_proceed);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	ida_simple_remove(&nvme_fc_local_port_cnt, lport->localport.port_num);
@@ -3904,10 +3897,6 @@ static int __init nvme_fc_init_module(void)
 {
 	int ret;
 
-	nvme_fc_wq = alloc_workqueue("nvme_fc_wq", WQ_MEM_RECLAIM, 0);
-	if (!nvme_fc_wq)
-		return -ENOMEM;
-
 	/*
 	 * NOTE:
 	 * It is expected that in the future the kernel will combine
@@ -3925,7 +3914,7 @@ static int __init nvme_fc_init_module(void)
 	ret = class_register(&fc_class);
 	if (ret) {
 		pr_err("couldn't register class fc\n");
-		goto out_destroy_wq;
+		return ret;
 	}
 
 	/*
@@ -3949,8 +3938,6 @@ static int __init nvme_fc_init_module(void)
 	device_destroy(&fc_class, MKDEV(0, 0));
 out_destroy_class:
 	class_unregister(&fc_class);
-out_destroy_wq:
-	destroy_workqueue(nvme_fc_wq);
 
 	return ret;
 }
@@ -3970,45 +3957,23 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 	spin_unlock(&rport->lock);
 }
 
-static void
-nvme_fc_cleanup_for_unload(void)
+static void __exit nvme_fc_exit_module(void)
 {
 	struct nvme_fc_lport *lport;
 	struct nvme_fc_rport *rport;
-
-	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
-		list_for_each_entry(rport, &lport->endp_list, endp_list) {
-			nvme_fc_delete_controllers(rport);
-		}
-	}
-}
-
-static void __exit nvme_fc_exit_module(void)
-{
 	unsigned long flags;
-	bool need_cleanup = false;
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
-	nvme_fc_waiting_to_unload = true;
-	if (!list_empty(&nvme_fc_lport_list)) {
-		need_cleanup = true;
-		nvme_fc_cleanup_for_unload();
-	}
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list)
+		list_for_each_entry(rport, &lport->endp_list, endp_list)
+			nvme_fc_delete_controllers(rport);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
-	if (need_cleanup) {
-		pr_info("%s: waiting for ctlr deletes\n", __func__);
-		wait_for_completion(&nvme_fc_unload_proceed);
-		pr_info("%s: ctrl deletes complete\n", __func__);
-	}
+	flush_workqueue(nvme_delete_wq);
 
 	nvmf_unregister_transport(&nvme_fc_transport);
 
-	ida_destroy(&nvme_fc_local_port_cnt);
-	ida_destroy(&nvme_fc_ctrl_cnt);
-
 	device_destroy(&fc_class, MKDEV(0, 0));
 	class_unregister(&fc_class);
-	destroy_workqueue(nvme_fc_wq);
 }
 
 module_init(nvme_fc_init_module);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 00a2a591f5c1..d3ca59ae4c7a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
+
+	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -165,7 +167,7 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_hostport	*hostport;
 	struct nvmet_fc_ls_iod		*rcv_disconn;
 	struct list_head		a_list;
-	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
+	struct nvmet_fc_tgt_queue 	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
 	struct rcu_head			rcu;
@@ -248,6 +250,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
@@ -359,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_putwork;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -372,7 +381,8 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-	nvmet_fc_tgtport_put(tgtport);
+out_putwork:
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -801,14 +811,11 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!queue)
 		return NULL;
 
-	if (!nvmet_fc_tgt_a_get(assoc))
-		goto out_free_queue;
-
 	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
 				assoc->tgtport->fc_target_port.port_num,
 				assoc->a_id, qid);
 	if (!queue->work_q)
-		goto out_a_put;
+		goto out_free_queue;
 
 	queue->qid = qid;
 	queue->sqsize = sqsize;
@@ -830,15 +837,13 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 		goto out_fail_iodlist;
 
 	WARN_ON(assoc->queues[qid]);
-	rcu_assign_pointer(assoc->queues[qid], queue);
+	assoc->queues[qid] = queue;
 
 	return queue;
 
 out_fail_iodlist:
 	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
 	destroy_workqueue(queue->work_q);
-out_a_put:
-	nvmet_fc_tgt_a_put(assoc);
 out_free_queue:
 	kfree(queue);
 	return NULL;
@@ -851,12 +856,8 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 	struct nvmet_fc_tgt_queue *queue =
 		container_of(ref, struct nvmet_fc_tgt_queue, ref);
 
-	rcu_assign_pointer(queue->assoc->queues[queue->qid], NULL);
-
 	nvmet_fc_destroy_fcp_iodlist(queue->assoc->tgtport, queue);
 
-	nvmet_fc_tgt_a_put(queue->assoc);
-
 	destroy_workqueue(queue->work_q);
 
 	kfree_rcu(queue, rcu);
@@ -968,7 +969,7 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 	rcu_read_lock();
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
-			queue = rcu_dereference(assoc->queues[qid]);
+			queue = assoc->queues[qid];
 			if (queue &&
 			    (!atomic_read(&queue->connected) ||
 			     !nvmet_fc_tgt_q_get(queue)))
@@ -1077,8 +1078,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
@@ -1093,13 +1092,28 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 }
 
 static void
-nvmet_fc_delete_assoc(struct work_struct *work)
+nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
+}
+
+static void
+nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
 	struct nvmet_fc_tgt_assoc *assoc =
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
+	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
+	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_tgtport_put(tgtport);
+}
+
+static void
+nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	nvmet_fc_tgtport_get(assoc->tgtport);
+	queue_work(nvmet_wq, &assoc->del_work);
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1111,6 +1125,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -1130,7 +1147,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
-	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
+	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
 	atomic_set(&assoc->terminating, 0);
 
 	while (needrandom) {
@@ -1171,13 +1188,18 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	struct nvmet_fc_ls_iod	*oldls;
 	unsigned long flags;
+	int i;
+
+	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
+		if (assoc->queues[i])
+			nvmet_fc_delete_target_queue(assoc->queues[i]);
+	}
 
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
 	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_del_rcu(&assoc->a_list);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	/* if pending Rcv Disconnect Association LS, send rsp now */
@@ -1207,7 +1229,7 @@ static void
 nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
-	struct nvmet_fc_tgt_queue *queue;
+	unsigned long flags;
 	int i, terminating;
 
 	terminating = atomic_xchg(&assoc->terminating, 1);
@@ -1216,29 +1238,21 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	if (terminating)
 		return;
 
+	spin_lock_irqsave(&tgtport->lock, flags);
+	list_del_rcu(&assoc->a_list);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
-		rcu_read_lock();
-		queue = rcu_dereference(assoc->queues[i]);
-		if (!queue) {
-			rcu_read_unlock();
-			continue;
-		}
+	synchronize_rcu();
 
-		if (!nvmet_fc_tgt_q_get(queue)) {
-			rcu_read_unlock();
-			continue;
-		}
-		rcu_read_unlock();
-		nvmet_fc_delete_target_queue(queue);
-		nvmet_fc_tgt_q_put(queue);
+	/* ensure all in-flight I/Os have been processed */
+	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
+		if (assoc->queues[i])
+			flush_workqueue(assoc->queues[i]->work_q);
 	}
 
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-
-	nvmet_fc_tgt_a_put(assoc);
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1414,6 +1428,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
@@ -1491,9 +1506,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		if (!queue_work(nvmet_wq, &assoc->del_work))
-			/* already deleting - release local reference */
-			nvmet_fc_tgt_a_put(assoc);
+		nvmet_fc_schedule_delete_assoc(assoc);
+		nvmet_fc_tgt_a_put(assoc);
 	}
 	rcu_read_unlock();
 }
@@ -1546,9 +1560,8 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		if (!queue_work(nvmet_wq, &assoc->del_work))
-			/* already deleting - release local reference */
-			nvmet_fc_tgt_a_put(assoc);
+		nvmet_fc_schedule_delete_assoc(assoc);
+		nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
@@ -1580,7 +1593,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
-			queue = rcu_dereference(assoc->queues[0]);
+			queue = assoc->queues[0];
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
 				if (nvmet_fc_tgt_a_get(assoc))
 					found_ctrl = true;
@@ -1592,9 +1605,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			if (!queue_work(nvmet_wq, &assoc->del_work))
-				/* already deleting - release local reference */
-				nvmet_fc_tgt_a_put(assoc);
+			nvmet_fc_schedule_delete_assoc(assoc);
+			nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
 
@@ -1624,6 +1636,8 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 	/* terminate any outstanding associations */
 	__nvmet_fc_free_assocs(tgtport);
 
+	flush_workqueue(nvmet_wq);
+
 	/*
 	 * should terminate LS's as well. However, LS's will be generated
 	 * at the tail end of association termination, so they likely don't
@@ -1869,9 +1883,6 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
 			FCNVME_LS_DISCONNECT_ASSOC);
 
-	/* release get taken in nvmet_fc_find_target_assoc */
-	nvmet_fc_tgt_a_put(assoc);
-
 	/*
 	 * The rules for LS response says the response cannot
 	 * go back until ABTS's have been sent for all outstanding
@@ -1886,8 +1897,6 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	assoc->rcv_disconn = iod;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	nvmet_fc_delete_target_assoc(assoc);
-
 	if (oldls) {
 		dev_info(tgtport->dev,
 			"{%d:%d} Multiple Disconnect Association LS's "
@@ -1903,6 +1912,9 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	}
 
+	nvmet_fc_schedule_delete_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
+
 	return false;
 }
 
@@ -2539,8 +2551,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
@@ -2901,6 +2914,9 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 
 	nvmet_fc_portentry_unbind(pe);
 
+	/* terminate any outstanding associations */
+	__nvmet_fc_free_assocs(pe->tgtport);
+
 	kfree(pe);
 }
 
@@ -2932,6 +2948,9 @@ static int __init nvmet_fc_init_module(void)
 
 static void __exit nvmet_fc_exit_module(void)
 {
+	/* ensure any shutdown operation, e.g. delete ctrls have finished */
+	flush_workqueue(nvmet_wq);
+
 	/* sanity check - all lports should be removed */
 	if (!list_empty(&nvmet_fc_target_list))
 		pr_warn("%s: targetport list not empty\n", __func__);
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c780af36c1d4..f5b8442b653d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4f2164a3f466..8468a41322f2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1884,6 +1884,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 61a0f33c59cf..fcb1fdb22ffb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/align.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
@@ -589,7 +590,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr &= ~aligned_offset;
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index cc4c2b8a5efd..d2bca04171a7 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1311,7 +1311,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index f5e020840d94..6fb3e597c57a 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -200,9 +200,6 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	autorelease = val && (!ke_rel || ke_rel->type == KE_IGNORE);
 
 	sparse_keymap_report_event(input_dev, event, val, autorelease);
-
-	/* Some devices need this to report further events */
-	acpi_evaluate_object(handle, "VBDL", NULL, NULL);
 }
 
 /*
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f129e29b295d..08a9b802be71 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -50,7 +50,7 @@ static const struct property_entry chuwi_hi8_air_props[] = {
 };
 
 static const struct ts_dmi_data chuwi_hi8_air_data = {
-	.acpi_name	= "MSSL1680:00",
+	.acpi_name	= "MSSL1680",
 	.properties	= chuwi_hi8_air_props,
 };
 
@@ -916,6 +916,32 @@ static const struct ts_dmi_data teclast_tbook11_data = {
 	.properties	= teclast_tbook11_props,
 };
 
+static const struct property_entry teclast_x16_plus_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 8),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 14),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1916),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1264),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-teclast-x16-plus.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data teclast_x16_plus_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3692-teclast-x16-plus.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 43560,
+		.sha256	= { 0x9d, 0xb0, 0x3d, 0xf1, 0x00, 0x3c, 0xb5, 0x25,
+			    0x62, 0x8a, 0xa0, 0x93, 0x4b, 0xe0, 0x4e, 0x75,
+			    0xd1, 0x27, 0xb1, 0x65, 0x3c, 0xba, 0xa5, 0x0f,
+			    0xcd, 0xb4, 0xbe, 0x00, 0xbb, 0xf6, 0x43, 0x29 },
+	},
+	.acpi_name	= "MSSL1680:00",
+	.properties	= teclast_x16_plus_props,
+};
+
 static const struct property_entry teclast_x3_plus_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -1552,6 +1578,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_SKU, "E5A6_A1"),
 		},
 	},
+	{
+		/* Teclast X16 Plus */
+		.driver_data = (void *)&teclast_x16_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "D3A5_A1"),
+		},
+	},
 	{
 		/* Teclast X3 Plus */
 		.driver_data = (void *)&teclast_x3_plus_data,
@@ -1710,7 +1745,7 @@ static void ts_dmi_add_props(struct i2c_client *client)
 	int error;
 
 	if (has_acpi_companion(dev) &&
-	    !strncmp(ts_data->acpi_name, client->name, I2C_NAME_SIZE)) {
+	    strstarts(client->name, ts_data->acpi_name)) {
 		error = device_create_managed_software_node(dev, ts_data->properties, NULL);
 		if (error)
 			dev_err(dev, "failed to add properties: %d\n", error);
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7629476d94ae..f4d9d9455dea 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -158,6 +158,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index eea574e89b87..43e6f86e08c3 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1296,7 +1296,7 @@ source "drivers/scsi/arm/Kconfig"
 
 config JAZZ_ESP
 	bool "MIPS JAZZ FAS216 SCSI support"
-	depends on MACH_JAZZ && SCSI
+	depends on MACH_JAZZ && SCSI=y
 	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the onboard SCSI host adapter of MIPS Magnum
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 4813adec0301..6d1a3cbd6b3c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1983,7 +1983,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datasegcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -1991,8 +1991,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	struct scatterlist *sgde = NULL; /* s/g data entry */
 	struct sli4_sge_diseed *diseed = NULL;
 	dma_addr_t physaddr;
-	int i = 0, num_sge = 0, status;
-	uint32_t reftag;
+	int i = 0, status;
+	uint32_t reftag, num_sge = 0;
 	uint8_t txop, rxop;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint32_t rc;
@@ -2164,7 +2164,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datacnt, int protcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -2188,8 +2188,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	uint32_t rc;
 #endif
 	uint32_t checking = 1;
-	uint32_t dma_offset = 0;
-	int num_sge = 0, j = 2;
+	uint32_t dma_offset = 0, num_sge = 0;
+	int j = 2;
 	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	sgpe = scsi_prot_sglist(sc);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 52ecde8e446c..9e649b7077c6 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -493,6 +493,11 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 			goto err_put_node;
 		}
 
+		/* recursive call to add all subdomains */
+		ret = scpsys_add_subdomain(scpsys, child);
+		if (ret)
+			goto err_put_node;
+
 		ret = pm_genpd_add_subdomain(parent_pd, child_pd);
 		if (ret) {
 			dev_err(scpsys->dev, "failed to add %s subdomain to parent %s\n",
@@ -502,11 +507,6 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 			dev_dbg(scpsys->dev, "%s add subdomain: %s\n", parent_pd->name,
 				child_pd->name);
 		}
-
-		/* recursive call to add all subdomains */
-		ret = scpsys_add_subdomain(scpsys, child);
-		if (ret)
-			goto err_put_node;
 	}
 
 	return 0;
@@ -520,9 +520,6 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 {
 	int ret;
 
-	if (scpsys_domain_is_on(pd))
-		scpsys_power_off(&pd->genpd);
-
 	/*
 	 * We're in the error cleanup already, so we only complain,
 	 * but won't emit another error on top of the original one.
@@ -532,6 +529,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 		dev_err(pd->scpsys->dev,
 			"failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
+	if (scpsys_domain_is_on(pd))
+		scpsys_power_off(&pd->genpd);
 
 	clk_bulk_put(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/soc/renesas/r8a77980-sysc.c
index 39ca84a67daa..621e411fc999 100644
--- a/drivers/soc/renesas/r8a77980-sysc.c
+++ b/drivers/soc/renesas/r8a77980-sysc.c
@@ -25,7 +25,8 @@ static const struct rcar_sysc_area r8a77980_areas[] __initconst = {
 	  PD_CPU_NOCR },
 	{ "ca53-cpu3",	0x200, 3, R8A77980_PD_CA53_CPU3, R8A77980_PD_CA53_SCU,
 	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON },
+	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON,
+	  PD_CPU_NOCR },
 	{ "a3ir",	0x180, 0, R8A77980_PD_A3IR,	R8A77980_PD_ALWAYS_ON },
 	{ "a2ir0",	0x400, 0, R8A77980_PD_A2IR0,	R8A77980_PD_A3IR },
 	{ "a2ir1",	0x400, 1, R8A77980_PD_A2IR1,	R8A77980_PD_A3IR },
diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index d3a23b1c2a4c..61bf00dfe9c3 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -377,6 +377,11 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 static irqreturn_t hisi_sfc_v3xx_isr(int irq, void *data)
 {
 	struct hisi_sfc_v3xx_host *host = data;
+	u32 reg;
+
+	reg = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
+	if (!reg)
+		return IRQ_NONE;
 
 	hisi_sfc_v3xx_disable_int(host);
 
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index eb2c64e0a5f7..b7b3ec76e2cb 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -137,14 +137,14 @@ struct sh_msiof_spi_priv {
 
 /* SIFCTR */
 #define SIFCTR_TFWM_MASK	GENMASK(31, 29)	/* Transmit FIFO Watermark */
-#define SIFCTR_TFWM_64		(0 << 29)	/*  Transfer Request when 64 empty stages */
-#define SIFCTR_TFWM_32		(1 << 29)	/*  Transfer Request when 32 empty stages */
-#define SIFCTR_TFWM_24		(2 << 29)	/*  Transfer Request when 24 empty stages */
-#define SIFCTR_TFWM_16		(3 << 29)	/*  Transfer Request when 16 empty stages */
-#define SIFCTR_TFWM_12		(4 << 29)	/*  Transfer Request when 12 empty stages */
-#define SIFCTR_TFWM_8		(5 << 29)	/*  Transfer Request when 8 empty stages */
-#define SIFCTR_TFWM_4		(6 << 29)	/*  Transfer Request when 4 empty stages */
-#define SIFCTR_TFWM_1		(7 << 29)	/*  Transfer Request when 1 empty stage */
+#define SIFCTR_TFWM_64		(0UL << 29)	/*  Transfer Request when 64 empty stages */
+#define SIFCTR_TFWM_32		(1UL << 29)	/*  Transfer Request when 32 empty stages */
+#define SIFCTR_TFWM_24		(2UL << 29)	/*  Transfer Request when 24 empty stages */
+#define SIFCTR_TFWM_16		(3UL << 29)	/*  Transfer Request when 16 empty stages */
+#define SIFCTR_TFWM_12		(4UL << 29)	/*  Transfer Request when 12 empty stages */
+#define SIFCTR_TFWM_8		(5UL << 29)	/*  Transfer Request when 8 empty stages */
+#define SIFCTR_TFWM_4		(6UL << 29)	/*  Transfer Request when 4 empty stages */
+#define SIFCTR_TFWM_1		(7UL << 29)	/*  Transfer Request when 1 empty stage */
 #define SIFCTR_TFUA_MASK	GENMASK(26, 20) /* Transmit FIFO Usable Area */
 #define SIFCTR_TFUA_SHIFT	20
 #define SIFCTR_TFUA(i)		((i) << SIFCTR_TFUA_SHIFT)
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 813de805f815..d4185c1bed8a 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -147,7 +147,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, se_cmd->orig_fe_lun);
@@ -178,10 +177,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	se_cmd->se_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 	se_tmr->tmr_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 
-	spin_lock_irqsave(&se_tmr->tmr_dev->se_tmr_lock, flags);
-	list_add_tail(&se_tmr->tmr_list, &se_tmr->tmr_dev->dev_tmr_list);
-	spin_unlock_irqrestore(&se_tmr->tmr_dev->se_tmr_lock, flags);
-
 	return 0;
 }
 EXPORT_SYMBOL(transport_lookup_tmr_lun);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 72edf5bd75ee..ac2d0e7d58ab 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3568,6 +3568,10 @@ int transport_generic_handle_tmr(
 	unsigned long flags;
 	bool aborted = false;
 
+	spin_lock_irqsave(&cmd->se_dev->se_tmr_lock, flags);
+	list_add_tail(&cmd->se_tmr_req->tmr_list, &cmd->se_dev->dev_tmr_list);
+	spin_unlock_irqrestore(&cmd->se_dev->se_tmr_lock, flags);
+
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	if (cmd->transport_state & CMD_T_ABORTED) {
 		aborted = true;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 45a8f76f562e..4fce318bc83c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -670,13 +670,6 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
 		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
 	}
 
-	/* clamp the delays to [0, 100ms] */
-	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
-	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
-
-	memset(rs485->padding, 0, sizeof(rs485->padding));
-	port->rs485 = *rs485;
-
 	gpiod_set_value(port->rs485_term_gpio,
 			rs485->flags & SER_RS485_TERMINATE_BUS);
 
@@ -684,15 +677,8 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
 	 * Both serial8250_em485_init() and serial8250_em485_destroy()
 	 * are idempotent.
 	 */
-	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
-
-		if (ret) {
-			rs485->flags &= ~SER_RS485_ENABLED;
-			port->rs485.flags &= ~SER_RS485_ENABLED;
-		}
-		return ret;
-	}
+	if (rs485->flags & SER_RS485_ENABLED)
+		return serial8250_em485_init(up);
 
 	serial8250_em485_destroy(up);
 	return 0;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 39c711afe4cd..a5eb5dc275cc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1350,11 +1350,41 @@ static void pl011_start_tx_pio(struct uart_amba_port *uap)
 	}
 }
 
+static void pl011_rs485_tx_start(struct uart_amba_port *uap)
+{
+	struct uart_port *port = &uap->port;
+	u32 cr;
+
+	/* Enable transmitter */
+	cr = pl011_read(uap, REG_CR);
+	cr |= UART011_CR_TXE;
+
+	/* Disable receiver if half-duplex */
+	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		cr &= ~UART011_CR_RXE;
+
+	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+		cr &= ~UART011_CR_RTS;
+	else
+		cr |= UART011_CR_RTS;
+
+	pl011_write(cr, uap, REG_CR);
+
+	if (port->rs485.delay_rts_before_send)
+		mdelay(port->rs485.delay_rts_before_send);
+
+	uap->rs485_tx_started = true;
+}
+
 static void pl011_start_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
+	    !uap->rs485_tx_started)
+		pl011_rs485_tx_start(uap);
+
 	if (!pl011_dma_tx_start(uap))
 		pl011_start_tx_pio(uap);
 }
@@ -1436,42 +1466,12 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
 	return true;
 }
 
-static void pl011_rs485_tx_start(struct uart_amba_port *uap)
-{
-	struct uart_port *port = &uap->port;
-	u32 cr;
-
-	/* Enable transmitter */
-	cr = pl011_read(uap, REG_CR);
-	cr |= UART011_CR_TXE;
-
-	/* Disable receiver if half-duplex */
-	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-		cr &= ~UART011_CR_RXE;
-
-	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
-		cr &= ~UART011_CR_RTS;
-	else
-		cr |= UART011_CR_RTS;
-
-	pl011_write(cr, uap, REG_CR);
-
-	if (port->rs485.delay_rts_before_send)
-		mdelay(port->rs485.delay_rts_before_send);
-
-	uap->rs485_tx_started = true;
-}
-
 /* Returns true if tx interrupts have to be (kept) enabled  */
 static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 {
 	struct circ_buf *xmit = &uap->port.state->xmit;
 	int count = uap->fifosize >> 1;
 
-	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
-	    !uap->rs485_tx_started)
-		pl011_rs485_tx_start(uap);
-
 	if (uap->port.x_char) {
 		if (!pl011_tx_char(uap, uap->port.x_char, from_irq))
 			return true;
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index ccdd525bd7c8..2b8f98f0707e 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -826,7 +826,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 			return;
 	}
 
-	if (request->complete) {
+	/*
+	 * zlp request is appended by driver, needn't call usb_gadget_giveback_request() to notify
+	 * gadget composite driver.
+	 */
+	if (request->complete && request->buf != priv_dev->zlp_buf) {
 		spin_unlock(&priv_dev->lock);
 		usb_gadget_giveback_request(&priv_ep->endpoint,
 					    request);
@@ -2537,11 +2541,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		list_del_init(&priv_req->list);
 
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 	}
 
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 7b20d2d5c262..7242591b346b 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -394,7 +394,6 @@ static int cdns_role_set(struct usb_role_switch *sw, enum usb_role role)
 	return ret;
 }
 
-
 /**
  * cdns_wakeup_irq - interrupt handler for wakeup events
  * @irq: irq number for cdns3/cdnsp core device
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index d00ff98dffab..33ba30f79b33 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -156,7 +156,8 @@ bool cdns_is_device(struct cdns *cdns)
  */
 static void cdns_otg_disable_irq(struct cdns *cdns)
 {
-	writel(0, &cdns->otg_irq_regs->ien);
+	if (cdns->version)
+		writel(0, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -418,15 +419,20 @@ int cdns_drd_init(struct cdns *cdns)
 
 		cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
 
-		if (readl(&cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
+		state = readl(&cdns->otg_cdnsp_regs->did);
+
+		if (OTG_CDNSP_CHECK_DID(state)) {
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_cdnsp_regs->ien;
 			cdns->version  = CDNSP_CONTROLLER_V2;
-		} else {
+		} else if (OTG_CDNS3_CHECK_DID(state)) {
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
 			cdns->version  = CDNS3_CONTROLLER_V1;
+		} else {
+			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
+			return -EINVAL;
 		}
 
 		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
@@ -479,7 +485,6 @@ int cdns_drd_exit(struct cdns *cdns)
 	return 0;
 }
 
-
 /* Indicate the cdns3 core was power lost before */
 bool cdns_power_is_lost(struct cdns *cdns)
 {
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index cbdf94f73ed9..d72370c321d3 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -79,7 +79,11 @@ struct cdnsp_otg_regs {
 	__le32 susp_timing_ctrl;
 };
 
-#define OTG_CDNSP_DID	0x0004034E
+/* CDNSP driver supports 0x000403xx Cadence USB controller family. */
+#define OTG_CDNSP_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040300)
+
+/* CDNS3 driver supports 0x000402xx Cadence USB controller family. */
+#define OTG_CDNS3_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040200)
 
 /*
  * Common registers interface for both CDNS3 and CDNSP version of DRD.
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 3e85b5d3cf7a..a27ba6d6adb9 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -17,6 +17,11 @@
 #include "../host/xhci.h"
 #include "../host/xhci-plat.h"
 
+/*
+ * The XECP_PORT_CAP_REG and XECP_AUX_CTRL_REG1 exist only
+ * in Cadence USB3 dual-role controller, so it can't be used
+ * with Cadence CDNSP dual-role controller.
+ */
 #define XECP_PORT_CAP_REG	0x8000
 #define XECP_AUX_CTRL_REG1	0x8120
 
@@ -56,6 +61,8 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
 	.resume_quirk = xhci_cdns3_resume_quirk,
 };
 
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+
 static int __cdns_host_init(struct cdns *cdns)
 {
 	struct platform_device *xhci;
@@ -80,8 +87,13 @@ static int __cdns_host_init(struct cdns *cdns)
 		goto err1;
 	}
 
-	cdns->xhci_plat_data = kmemdup(&xhci_plat_cdns3_xhci,
-			sizeof(struct xhci_plat_priv), GFP_KERNEL);
+	if (cdns->version < CDNSP_CONTROLLER_V2)
+		cdns->xhci_plat_data = kmemdup(&xhci_plat_cdns3_xhci,
+				sizeof(struct xhci_plat_priv), GFP_KERNEL);
+	else
+		cdns->xhci_plat_data = kmemdup(&xhci_plat_cdnsp_xhci,
+				sizeof(struct xhci_plat_priv), GFP_KERNEL);
+
 	if (!cdns->xhci_plat_data) {
 		ret = -ENOMEM;
 		goto err1;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8e51db62a6f5..86cf3b2b66e9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2501,6 +2501,11 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	int ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->pullups_connected) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return 0;
+	}
+
 	dwc->connected = false;
 
 	/*
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index bd095ae569ed..537f7a729f0e 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1344,7 +1344,15 @@ static int ncm_unwrap_ntb(struct gether *port,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+
+	/*
+	 * Windows NCM driver avoids USB ZLPs by adding a 1-byte
+	 * zero pad as needed.
+	 */
+	if (to_process == 1 &&
+	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
+		to_process--;
+	} else if (to_process > 0) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index b9754784161d..723201394eaa 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -905,7 +905,7 @@ static void xhci_del_comp_mod_timer(struct xhci_hcd *xhci, u32 status,
 }
 
 static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
-					     u32 *status, u32 portsc,
+					     u32 portsc,
 					     unsigned long *flags)
 {
 	struct xhci_bus_state *bus_state;
@@ -920,11 +920,10 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 	wIndex = port->hcd_portnum;
 
 	if ((portsc & PORT_RESET) || !(portsc & PORT_PE)) {
-		*status = 0xffffffff;
 		return -EINVAL;
 	}
 	/* did port event handler already start resume timing? */
-	if (!bus_state->resume_done[wIndex]) {
+	if (!port->resume_timestamp) {
 		/* If not, maybe we are in a host initated resume? */
 		if (test_bit(wIndex, &bus_state->resuming_ports)) {
 			/* Host initated resume doesn't time the resume
@@ -941,28 +940,29 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 				msecs_to_jiffies(USB_RESUME_TIMEOUT);
 
 			set_bit(wIndex, &bus_state->resuming_ports);
-			bus_state->resume_done[wIndex] = timeout;
+			port->resume_timestamp = timeout;
 			mod_timer(&hcd->rh_timer, timeout);
 			usb_hcd_start_port_resume(&hcd->self, wIndex);
 		}
 	/* Has resume been signalled for USB_RESUME_TIME yet? */
-	} else if (time_after_eq(jiffies, bus_state->resume_done[wIndex])) {
+	} else if (time_after_eq(jiffies, port->resume_timestamp)) {
 		int time_left;
 
 		xhci_dbg(xhci, "resume USB2 port %d-%d\n",
 			 hcd->self.busnum, wIndex + 1);
 
-		bus_state->resume_done[wIndex] = 0;
+		port->resume_timestamp = 0;
 		clear_bit(wIndex, &bus_state->resuming_ports);
 
-		set_bit(wIndex, &bus_state->rexit_ports);
+		reinit_completion(&port->rexit_done);
+		port->rexit_active = true;
 
 		xhci_test_and_clear_bit(xhci, port, PORT_PLC);
 		xhci_set_link_state(xhci, port, XDEV_U0);
 
 		spin_unlock_irqrestore(&xhci->lock, *flags);
 		time_left = wait_for_completion_timeout(
-			&bus_state->rexit_done[wIndex],
+			&port->rexit_done,
 			msecs_to_jiffies(XHCI_MAX_REXIT_TIMEOUT_MS));
 		spin_lock_irqsave(&xhci->lock, *flags);
 
@@ -971,7 +971,6 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 							    wIndex + 1);
 			if (!slot_id) {
 				xhci_dbg(xhci, "slot_id is zero\n");
-				*status = 0xffffffff;
 				return -ENODEV;
 			}
 			xhci_ring_device(xhci, slot_id);
@@ -980,22 +979,19 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 
 			xhci_warn(xhci, "Port resume timed out, port %d-%d: 0x%x\n",
 				  hcd->self.busnum, wIndex + 1, port_status);
-			*status |= USB_PORT_STAT_SUSPEND;
-			clear_bit(wIndex, &bus_state->rexit_ports);
+			/*
+			 * keep rexit_active set if U0 transition failed so we
+			 * know to report PORT_STAT_SUSPEND status back to
+			 * usbcore. It will be cleared later once the port is
+			 * out of RESUME/U3 state
+			 */
 		}
 
 		usb_hcd_end_port_resume(&hcd->self, wIndex);
 		bus_state->port_c_suspend |= 1 << wIndex;
 		bus_state->suspended_ports &= ~(1 << wIndex);
-	} else {
-		/*
-		 * The resume has been signaling for less than
-		 * USB_RESUME_TIME. Report the port status as SUSPEND,
-		 * let the usbcore check port status again and clear
-		 * resume signaling later.
-		 */
-		*status |= USB_PORT_STAT_SUSPEND;
 	}
+
 	return 0;
 }
 
@@ -1047,19 +1043,19 @@ static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
 		*status |= USB_PORT_STAT_C_CONFIG_ERROR << 16;
 
 	/* USB3 specific wPortStatus bits */
-	if (portsc & PORT_POWER) {
+	if (portsc & PORT_POWER)
 		*status |= USB_SS_PORT_STAT_POWER;
-		/* link state handling */
-		if (link_state == XDEV_U0)
-			bus_state->suspended_ports &= ~(1 << portnum);
-	}
 
-	/* remote wake resume signaling complete */
-	if (bus_state->port_remote_wakeup & (1 << portnum) &&
+	/* no longer suspended or resuming */
+	if (link_state != XDEV_U3 &&
 	    link_state != XDEV_RESUME &&
 	    link_state != XDEV_RECOVERY) {
-		bus_state->port_remote_wakeup &= ~(1 << portnum);
-		usb_hcd_end_port_resume(&hcd->self, portnum);
+		/* remote wake resume signaling complete */
+		if (bus_state->port_remote_wakeup & (1 << portnum)) {
+			bus_state->port_remote_wakeup &= ~(1 << portnum);
+			usb_hcd_end_port_resume(&hcd->self, portnum);
+		}
+		bus_state->suspended_ports &= ~(1 << portnum);
 	}
 
 	xhci_hub_report_usb3_link_state(xhci, status, portsc);
@@ -1072,7 +1068,7 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 	struct xhci_bus_state *bus_state;
 	u32 link_state;
 	u32 portnum;
-	int ret;
+	int err;
 
 	bus_state = &port->rhub->bus_state;
 	link_state = portsc & PORT_PLS_MASK;
@@ -1088,22 +1084,35 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 		if (link_state == XDEV_U2)
 			*status |= USB_PORT_STAT_L1;
 		if (link_state == XDEV_U0) {
-			if (bus_state->resume_done[portnum])
-				usb_hcd_end_port_resume(&port->rhub->hcd->self,
-							portnum);
-			bus_state->resume_done[portnum] = 0;
-			clear_bit(portnum, &bus_state->resuming_ports);
 			if (bus_state->suspended_ports & (1 << portnum)) {
 				bus_state->suspended_ports &= ~(1 << portnum);
 				bus_state->port_c_suspend |= 1 << portnum;
 			}
 		}
 		if (link_state == XDEV_RESUME) {
-			ret = xhci_handle_usb2_port_link_resume(port, status,
-								portsc, flags);
-			if (ret)
-				return;
+			err = xhci_handle_usb2_port_link_resume(port, portsc,
+								flags);
+			if (err < 0)
+				*status = 0xffffffff;
+			else if (port->resume_timestamp || port->rexit_active)
+				*status |= USB_PORT_STAT_SUSPEND;
+		}
+	}
+
+	/*
+	 * Clear usb2 resume signalling variables if port is no longer suspended
+	 * or resuming. Port either resumed to U0/U1/U2, disconnected, or in a
+	 * error state. Resume related variables should be cleared in all those cases.
+	 */
+	if (link_state != XDEV_U3 && link_state != XDEV_RESUME) {
+		if (port->resume_timestamp ||
+		    test_bit(portnum, &bus_state->resuming_ports)) {
+			port->resume_timestamp = 0;
+			clear_bit(portnum, &bus_state->resuming_ports);
+			usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
 		}
+		port->rexit_active = 0;
+		bus_state->suspended_ports &= ~(1 << portnum);
 	}
 }
 
@@ -1159,18 +1168,6 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 	else
 		xhci_get_usb2_port_status(port, &status, raw_port_status,
 					  flags);
-	/*
-	 * Clear stale usb2 resume signalling variables in case port changed
-	 * state during resume signalling. For example on error
-	 */
-	if ((bus_state->resume_done[wIndex] ||
-	     test_bit(wIndex, &bus_state->resuming_ports)) &&
-	    (raw_port_status & PORT_PLS_MASK) != XDEV_U3 &&
-	    (raw_port_status & PORT_PLS_MASK) != XDEV_RESUME) {
-		bus_state->resume_done[wIndex] = 0;
-		clear_bit(wIndex, &bus_state->resuming_ports);
-		usb_hcd_end_port_resume(&hcd->self, wIndex);
-	}
 
 	if (bus_state->port_c_suspend & (1 << wIndex))
 		status |= USB_PORT_STAT_C_SUSPEND << 16;
@@ -1194,11 +1191,14 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	u16 test_mode = 0;
 	struct xhci_hub *rhub;
 	struct xhci_port **ports;
+	struct xhci_port *port;
+	int portnum1;
 
 	rhub = xhci_get_rhub(hcd);
 	ports = rhub->ports;
 	max_ports = rhub->num_ports;
 	bus_state = &rhub->bus_state;
+	portnum1 = wIndex & 0xff;
 
 	spin_lock_irqsave(&xhci->lock, flags);
 	switch (typeReq) {
@@ -1232,10 +1232,12 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		spin_unlock_irqrestore(&xhci->lock, flags);
 		return retval;
 	case GetPortStatus:
-		if (!wIndex || wIndex > max_ports)
+		if (!portnum1 || portnum1 > max_ports)
 			goto error;
+
 		wIndex--;
-		temp = readl(ports[wIndex]->addr);
+		port = ports[portnum1 - 1];
+		temp = readl(port->addr);
 		if (temp == ~(u32)0) {
 			xhci_hc_died(xhci);
 			retval = -ENODEV;
@@ -1248,7 +1250,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 
 		xhci_dbg(xhci, "Get port status %d-%d read: 0x%x, return 0x%x",
-			 hcd->self.busnum, wIndex + 1, temp, status);
+			 hcd->self.busnum, portnum1, temp, status);
 
 		put_unaligned(cpu_to_le32(status), (__le32 *) buf);
 		/* if USB 3.1 extended port status return additional 4 bytes */
@@ -1260,7 +1262,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				retval = -EINVAL;
 				break;
 			}
-			port_li = readl(ports[wIndex]->addr + PORTLI);
+			port_li = readl(port->addr + PORTLI);
 			status = xhci_get_ext_port_status(temp, port_li);
 			put_unaligned_le32(status, &buf[4]);
 		}
@@ -1274,11 +1276,14 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			test_mode = (wIndex & 0xff00) >> 8;
 		/* The MSB of wIndex is the U1/U2 timeout */
 		timeout = (wIndex & 0xff00) >> 8;
+
 		wIndex &= 0xff;
-		if (!wIndex || wIndex > max_ports)
+		if (!portnum1 || portnum1 > max_ports)
 			goto error;
+
+		port = ports[portnum1 - 1];
 		wIndex--;
-		temp = readl(ports[wIndex]->addr);
+		temp = readl(port->addr);
 		if (temp == ~(u32)0) {
 			xhci_hc_died(xhci);
 			retval = -ENODEV;
@@ -1288,11 +1293,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		/* FIXME: What new port features do we need to support? */
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			if ((temp & PORT_PLS_MASK) != XDEV_U0) {
 				/* Resume the port to U0 first */
-				xhci_set_link_state(xhci, ports[wIndex],
-							XDEV_U0);
+				xhci_set_link_state(xhci, port, XDEV_U0);
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				msleep(10);
 				spin_lock_irqsave(&xhci->lock, flags);
@@ -1301,16 +1305,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			 * a port unless the port reports that it is in the
 			 * enabled (PED = ‘1’,PLS < ‘3’) state.
 			 */
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			if ((temp & PORT_PE) == 0 || (temp & PORT_RESET)
 				|| (temp & PORT_PLS_MASK) >= XDEV_U3) {
 				xhci_warn(xhci, "USB core suspending port %d-%d not in U0/U1/U2\n",
-					  hcd->self.busnum, wIndex + 1);
+					  hcd->self.busnum, portnum1);
 				goto error;
 			}
 
 			slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-					wIndex + 1);
+							    portnum1);
 			if (!slot_id) {
 				xhci_warn(xhci, "slot_id is zero\n");
 				goto error;
@@ -1320,21 +1324,21 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			xhci_stop_device(xhci, slot_id, 1);
 			spin_lock_irqsave(&xhci->lock, flags);
 
-			xhci_set_link_state(xhci, ports[wIndex], XDEV_U3);
+			xhci_set_link_state(xhci, port, XDEV_U3);
 
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			msleep(10); /* wait device to enter */
 			spin_lock_irqsave(&xhci->lock, flags);
 
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			bus_state->suspended_ports |= 1 << wIndex;
 			break;
 		case USB_PORT_FEAT_LINK_STATE:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			/* Disable port */
 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
 				xhci_dbg(xhci, "Disable port %d-%d\n",
-					 hcd->self.busnum, wIndex + 1);
+					 hcd->self.busnum, portnum1);
 				temp = xhci_port_state_to_neutral(temp);
 				/*
 				 * Clear all change bits, so that we get a new
@@ -1343,18 +1347,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				temp |= PORT_CSC | PORT_PEC | PORT_WRC |
 					PORT_OCC | PORT_RC | PORT_PLC |
 					PORT_CEC;
-				writel(temp | PORT_PE, ports[wIndex]->addr);
-				temp = readl(ports[wIndex]->addr);
+				writel(temp | PORT_PE, port->addr);
+				temp = readl(port->addr);
 				break;
 			}
 
 			/* Put link in RxDetect (enable port) */
 			if (link_state == USB_SS_PORT_LS_RX_DETECT) {
 				xhci_dbg(xhci, "Enable port %d-%d\n",
-					 hcd->self.busnum, wIndex + 1);
-				xhci_set_link_state(xhci, ports[wIndex],
-							link_state);
-				temp = readl(ports[wIndex]->addr);
+					 hcd->self.busnum, portnum1);
+				xhci_set_link_state(xhci, port,	link_state);
+				temp = readl(port->addr);
 				break;
 			}
 
@@ -1384,11 +1387,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				}
 
 				xhci_dbg(xhci, "Enable compliance mode transition for port %d-%d\n",
-					 hcd->self.busnum, wIndex + 1);
-				xhci_set_link_state(xhci, ports[wIndex],
-						link_state);
+					 hcd->self.busnum, portnum1);
+				xhci_set_link_state(xhci, port, link_state);
 
-				temp = readl(ports[wIndex]->addr);
+				temp = readl(port->addr);
 				break;
 			}
 			/* Port must be enabled */
@@ -1399,8 +1401,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			/* Can't set port link state above '3' (U3) */
 			if (link_state > USB_SS_PORT_LS_U3) {
 				xhci_warn(xhci, "Cannot set port %d-%d link state %d\n",
-					  hcd->self.busnum, wIndex + 1,
-					  link_state);
+					  hcd->self.busnum, portnum1, link_state);
 				goto error;
 			}
 
@@ -1422,30 +1423,29 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				    pls == XDEV_RESUME ||
 				    pls == XDEV_RECOVERY) {
 					wait_u0 = true;
-					reinit_completion(&bus_state->u3exit_done[wIndex]);
+					reinit_completion(&port->u3exit_done);
 				}
 				if (pls <= XDEV_U3) /* U1, U2, U3 */
-					xhci_set_link_state(xhci, ports[wIndex],
-							    USB_SS_PORT_LS_U0);
+					xhci_set_link_state(xhci, port, USB_SS_PORT_LS_U0);
 				if (!wait_u0) {
 					if (pls > XDEV_U3)
 						goto error;
 					break;
 				}
 				spin_unlock_irqrestore(&xhci->lock, flags);
-				if (!wait_for_completion_timeout(&bus_state->u3exit_done[wIndex],
+				if (!wait_for_completion_timeout(&port->u3exit_done,
 								 msecs_to_jiffies(500)))
 					xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n",
-						 hcd->self.busnum, wIndex + 1);
+						 hcd->self.busnum, portnum1);
 				spin_lock_irqsave(&xhci->lock, flags);
-				temp = readl(ports[wIndex]->addr);
+				temp = readl(port->addr);
 				break;
 			}
 
 			if (link_state == USB_SS_PORT_LS_U3) {
 				int retries = 16;
 				slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-						wIndex + 1);
+								    portnum1);
 				if (slot_id) {
 					/* unlock to execute stop endpoint
 					 * commands */
@@ -1454,16 +1454,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					xhci_stop_device(xhci, slot_id, 1);
 					spin_lock_irqsave(&xhci->lock, flags);
 				}
-				xhci_set_link_state(xhci, ports[wIndex], USB_SS_PORT_LS_U3);
+				xhci_set_link_state(xhci, port, USB_SS_PORT_LS_U3);
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				while (retries--) {
 					usleep_range(4000, 8000);
-					temp = readl(ports[wIndex]->addr);
+					temp = readl(port->addr);
 					if ((temp & PORT_PLS_MASK) == XDEV_U3)
 						break;
 				}
 				spin_lock_irqsave(&xhci->lock, flags);
-				temp = readl(ports[wIndex]->addr);
+				temp = readl(port->addr);
 				bus_state->suspended_ports |= 1 << wIndex;
 			}
 			break;
@@ -1478,39 +1478,38 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			break;
 		case USB_PORT_FEAT_RESET:
 			temp = (temp | PORT_RESET);
-			writel(temp, ports[wIndex]->addr);
+			writel(temp, port->addr);
 
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "set port reset, actual port %d-%d status  = 0x%x\n",
-				 hcd->self.busnum, wIndex + 1, temp);
+				 hcd->self.busnum, portnum1, temp);
 			break;
 		case USB_PORT_FEAT_REMOTE_WAKE_MASK:
-			xhci_set_remote_wake_mask(xhci, ports[wIndex],
-						  wake_mask);
-			temp = readl(ports[wIndex]->addr);
+			xhci_set_remote_wake_mask(xhci, port, wake_mask);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "set port remote wake mask, actual port %d-%d status  = 0x%x\n",
-				 hcd->self.busnum, wIndex + 1, temp);
+				 hcd->self.busnum, portnum1, temp);
 			break;
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			temp |= PORT_WR;
-			writel(temp, ports[wIndex]->addr);
-			temp = readl(ports[wIndex]->addr);
+			writel(temp, port->addr);
+			temp = readl(port->addr);
 			break;
 		case USB_PORT_FEAT_U1_TIMEOUT:
 			if (hcd->speed < HCD_USB3)
 				goto error;
-			temp = readl(ports[wIndex]->addr + PORTPMSC);
+			temp = readl(port->addr + PORTPMSC);
 			temp &= ~PORT_U1_TIMEOUT_MASK;
 			temp |= PORT_U1_TIMEOUT(timeout);
-			writel(temp, ports[wIndex]->addr + PORTPMSC);
+			writel(temp, port->addr + PORTPMSC);
 			break;
 		case USB_PORT_FEAT_U2_TIMEOUT:
 			if (hcd->speed < HCD_USB3)
 				goto error;
-			temp = readl(ports[wIndex]->addr + PORTPMSC);
+			temp = readl(port->addr + PORTPMSC);
 			temp &= ~PORT_U2_TIMEOUT_MASK;
 			temp |= PORT_U2_TIMEOUT(timeout);
-			writel(temp, ports[wIndex]->addr + PORTPMSC);
+			writel(temp, port->addr + PORTPMSC);
 			break;
 		case USB_PORT_FEAT_TEST:
 			/* 4.19.6 Port Test Modes (USB2 Test Mode) */
@@ -1526,13 +1525,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 		}
 		/* unblock any posted writes */
-		temp = readl(ports[wIndex]->addr);
+		temp = readl(port->addr);
 		break;
 	case ClearPortFeature:
-		if (!wIndex || wIndex > max_ports)
+		if (!portnum1 || portnum1 > max_ports)
 			goto error;
+
+		port = ports[portnum1 - 1];
+
 		wIndex--;
-		temp = readl(ports[wIndex]->addr);
+		temp = readl(port->addr);
 		if (temp == ~(u32)0) {
 			xhci_hc_died(xhci);
 			retval = -ENODEV;
@@ -1542,7 +1544,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = xhci_port_state_to_neutral(temp);
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "clear USB_PORT_FEAT_SUSPEND\n");
 			xhci_dbg(xhci, "PORTSC %04x\n", temp);
 			if (temp & PORT_RESET)
@@ -1553,20 +1555,18 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 				set_bit(wIndex, &bus_state->resuming_ports);
 				usb_hcd_start_port_resume(&hcd->self, wIndex);
-				xhci_set_link_state(xhci, ports[wIndex],
-						    XDEV_RESUME);
+				xhci_set_link_state(xhci, port, XDEV_RESUME);
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				msleep(USB_RESUME_TIMEOUT);
 				spin_lock_irqsave(&xhci->lock, flags);
-				xhci_set_link_state(xhci, ports[wIndex],
-							XDEV_U0);
+				xhci_set_link_state(xhci, port, XDEV_U0);
 				clear_bit(wIndex, &bus_state->resuming_ports);
 				usb_hcd_end_port_resume(&hcd->self, wIndex);
 			}
 			bus_state->port_c_suspend |= 1 << wIndex;
 
 			slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-					wIndex + 1);
+					portnum1);
 			if (!slot_id) {
 				xhci_dbg(xhci, "slot_id is zero\n");
 				goto error;
@@ -1584,11 +1584,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_C_PORT_LINK_STATE:
 		case USB_PORT_FEAT_C_PORT_CONFIG_ERROR:
 			xhci_clear_port_change_bit(xhci, wValue, wIndex,
-					ports[wIndex]->addr, temp);
+					port->addr, temp);
 			break;
 		case USB_PORT_FEAT_ENABLE:
 			xhci_disable_port(hcd, xhci, wIndex,
-					ports[wIndex]->addr, temp);
+					port->addr, temp);
 			break;
 		case USB_PORT_FEAT_POWER:
 			xhci_set_port_power(xhci, hcd, wIndex, false, &flags);
@@ -1672,8 +1672,8 @@ int xhci_hub_status_data(struct usb_hcd *hcd, char *buf)
 
 		if ((temp & mask) != 0 ||
 			(bus_state->port_c_suspend & 1 << i) ||
-			(bus_state->resume_done[i] && time_after_eq(
-			    jiffies, bus_state->resume_done[i]))) {
+			(ports[i]->resume_timestamp && time_after_eq(
+			    jiffies, ports[i]->resume_timestamp))) {
 			buf[(i + 1) / 8] |= 1 << (i + 1) % 8;
 			status = 1;
 		}
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 6444aef33cf0..f9e3aed40984 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2318,6 +2318,9 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 		xhci->hw_ports[i].addr = &xhci->op_regs->port_status_base +
 			NUM_PORT_REGS * i;
 		xhci->hw_ports[i].hw_portnum = i;
+
+		init_completion(&xhci->hw_ports[i].rexit_done);
+		init_completion(&xhci->hw_ports[i].u3exit_done);
 	}
 
 	xhci->rh_bw = kcalloc_node(num_ports, sizeof(*xhci->rh_bw), flags,
@@ -2587,13 +2590,6 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 */
 	for (i = 0; i < MAX_HC_SLOTS; i++)
 		xhci->devs[i] = NULL;
-	for (i = 0; i < USB_MAXCHILDREN; i++) {
-		xhci->usb2_rhub.bus_state.resume_done[i] = 0;
-		xhci->usb3_rhub.bus_state.resume_done[i] = 0;
-		/* Only the USB 2.0 completions will ever be used. */
-		init_completion(&xhci->usb2_rhub.bus_state.rexit_done[i]);
-		init_completion(&xhci->usb3_rhub.bus_state.u3exit_done[i]);
-	}
 
 	if (scratchpad_alloc(xhci, flags))
 		goto fail;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 945ed5f3e858..aa12da0796d2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1987,7 +1987,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 			goto cleanup;
 		} else if (!test_bit(hcd_portnum, &bus_state->resuming_ports)) {
 			xhci_dbg(xhci, "resume HS port %d\n", port_id);
-			bus_state->resume_done[hcd_portnum] = jiffies +
+			port->resume_timestamp = jiffies +
 				msecs_to_jiffies(USB_RESUME_TIMEOUT);
 			set_bit(hcd_portnum, &bus_state->resuming_ports);
 			/* Do the rest in GetPortStatus after resume time delay.
@@ -1996,7 +1996,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 			 */
 			set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 			mod_timer(&hcd->rh_timer,
-				  bus_state->resume_done[hcd_portnum]);
+				  port->resume_timestamp);
 			usb_hcd_start_port_resume(&hcd->self, hcd_portnum);
 			bogus_port_status = true;
 		}
@@ -2008,7 +2008,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
 	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
 		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
-		complete(&bus_state->u3exit_done[hcd_portnum]);
+		complete(&port->u3exit_done);
 		/* We've just brought the device into U0/1/2 through either the
 		 * Resume state after a device remote wakeup, or through the
 		 * U3Exit state after a host-initiated resume.  If it's a device
@@ -2033,10 +2033,9 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	 * RExit to a disconnect state).  If so, let the the driver know it's
 	 * out of the RExit state.
 	 */
-	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
-			test_and_clear_bit(hcd_portnum,
-				&bus_state->rexit_ports)) {
-		complete(&bus_state->rexit_done[hcd_portnum]);
+	if (hcd->speed < HCD_USB3 && port->rexit_active) {
+		complete(&port->rexit_done);
+		port->rexit_active = false;
 		bogus_port_status = true;
 		goto cleanup;
 	}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 64278cd77f98..8ae33db1e4bc 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1708,13 +1708,8 @@ struct xhci_bus_state {
 	u32			port_c_suspend;
 	u32			suspended_ports;
 	u32			port_remote_wakeup;
-	unsigned long		resume_done[USB_MAXCHILDREN];
 	/* which ports have started to resume */
 	unsigned long		resuming_ports;
-	/* Which ports are waiting on RExit to U0 transition. */
-	unsigned long		rexit_ports;
-	struct completion	rexit_done[USB_MAXCHILDREN];
-	struct completion	u3exit_done[USB_MAXCHILDREN];
 };
 
 
@@ -1738,6 +1733,10 @@ struct xhci_port {
 	struct xhci_hub		*rhub;
 	struct xhci_port_cap	*port_cap;
 	unsigned int		lpm_incapable:1;
+	unsigned long		resume_timestamp;
+	bool			rexit_active;
+	struct completion	rexit_done;
+	struct completion	u3exit_done;
 };
 
 struct xhci_hub {
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 32e6d19f7011..a327f8bc5704 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -19,7 +19,9 @@ static struct class *role_class;
 struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
+	struct module *module; /* the module this device depends on */
 	enum usb_role role;
+	bool registered;
 
 	/* From descriptor */
 	struct device *usb2_port;
@@ -46,6 +48,9 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
+	if (!sw->registered)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw, role);
@@ -71,7 +76,7 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 {
 	enum usb_role role;
 
-	if (IS_ERR_OR_NULL(sw))
+	if (IS_ERR_OR_NULL(sw) || !sw->registered)
 		return USB_ROLE_NONE;
 
 	mutex_lock(&sw->lock);
@@ -133,7 +138,7 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
 						  usb_role_switch_match);
 
 	if (!IS_ERR_OR_NULL(sw))
-		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+		WARN_ON(!try_module_get(sw->module));
 
 	return sw;
 }
@@ -155,7 +160,7 @@ struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
 		sw = fwnode_connection_find_match(fwnode, "usb-role-switch",
 						  NULL, usb_role_switch_match);
 	if (!IS_ERR_OR_NULL(sw))
-		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+		WARN_ON(!try_module_get(sw->module));
 
 	return sw;
 }
@@ -170,7 +175,7 @@ EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
 void usb_role_switch_put(struct usb_role_switch *sw)
 {
 	if (!IS_ERR_OR_NULL(sw)) {
-		module_put(sw->dev.parent->driver->owner);
+		module_put(sw->module);
 		put_device(&sw->dev);
 	}
 }
@@ -187,15 +192,18 @@ struct usb_role_switch *
 usb_role_switch_find_by_fwnode(const struct fwnode_handle *fwnode)
 {
 	struct device *dev;
+	struct usb_role_switch *sw = NULL;
 
 	if (!fwnode)
 		return NULL;
 
 	dev = class_find_device_by_fwnode(role_class, fwnode);
-	if (dev)
-		WARN_ON(!try_module_get(dev->parent->driver->owner));
+	if (dev) {
+		sw = to_role_switch(dev);
+		WARN_ON(!try_module_get(sw->module));
+	}
 
-	return dev ? to_role_switch(dev) : NULL;
+	return sw;
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_find_by_fwnode);
 
@@ -337,6 +345,7 @@ usb_role_switch_register(struct device *parent,
 	sw->set = desc->set;
 	sw->get = desc->get;
 
+	sw->module = parent->driver->owner;
 	sw->dev.parent = parent;
 	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = role_class;
@@ -351,6 +360,8 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	sw->registered = true;
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -365,8 +376,10 @@ EXPORT_SYMBOL_GPL(usb_role_switch_register);
  */
 void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
-	if (!IS_ERR_OR_NULL(sw))
+	if (!IS_ERR_OR_NULL(sw)) {
+		sw->registered = false;
 		device_unregister(&sw->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
 
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index ff010c6d0cd3..bdc7595fcb0e 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -505,7 +505,6 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 	else
 		destroy_dma_mr(mvdev, mr);
 
-	memset(mr, 0, sizeof(*mr));
 	mr->initialized = false;
 out:
 	mutex_unlock(&mr->mkey_mtx);
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 0ac750cc5ea1..94ebd8af50cf 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -868,6 +868,9 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 
 	DBG("savagefb_check_var");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 266a5582f94d..c6e21ba00895 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1474,6 +1474,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 137a970c19fb..3d39ce5a23f2 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -327,7 +327,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[24];
 	int ret, idsz;
 
 	_enter("");
@@ -335,7 +335,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz = sprintf(idbuf, "%llu", volume->vid);
+	idsz = snprintf(idbuf, sizeof(idbuf), "%llu", volume->vid);
 
 	vldb = afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {
diff --git a/fs/aio.c b/fs/aio.c
index e88fd9b58f3f..e24eb82b2b58 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -568,6 +568,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1453,7 +1460,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9ae7c12668cd..c1dfde886b1e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2338,6 +2338,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		if (!strstr(crypto_shash_driver_name(csum_shash), "generic"))
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a521c705b0d7..a3e4811b7871 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -59,7 +59,7 @@ extern bool disable_legacy_dialects;
 #define TLINK_IDLE_EXPIRE	(600 * HZ)
 
 /* Drop the connection to not overload the server */
-#define NUM_STATUS_IO_TIMEOUT   5
+#define MAX_STATUS_IO_TIMEOUT   5
 
 struct mount_ctx {
 	struct cifs_sb_info *cifs_sb;
@@ -965,6 +965,7 @@ cifs_demultiplex_thread(void *p)
 	struct mid_q_entry *mids[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
 	unsigned int noreclaim_flag, num_io_timeout = 0;
+	bool pending_reconnect = false;
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
@@ -1004,6 +1005,8 @@ cifs_demultiplex_thread(void *p)
 		cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
 		if (!is_smb_response(server, buf[0]))
 			continue;
+
+		pending_reconnect = false;
 next_pdu:
 		server->pdu_size = pdu_length;
 
@@ -1063,10 +1066,13 @@ cifs_demultiplex_thread(void *p)
 		if (server->ops->is_status_io_timeout &&
 		    server->ops->is_status_io_timeout(buf)) {
 			num_io_timeout++;
-			if (num_io_timeout > NUM_STATUS_IO_TIMEOUT) {
-				cifs_reconnect(server);
+			if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
+				cifs_server_dbg(VFS,
+						"Number of request timeouts exceeded %d. Reconnecting",
+						MAX_STATUS_IO_TIMEOUT);
+
+				pending_reconnect = true;
 				num_io_timeout = 0;
-				continue;
 			}
 		}
 
@@ -1113,6 +1119,11 @@ cifs_demultiplex_thread(void *p)
 			buf = server->smallbuf;
 			goto next_pdu;
 		}
+
+		/* do this reconnect at the very end after processing all MIDs */
+		if (pending_reconnect)
+			cifs_reconnect(server);
+
 	} /* end while !EXITING */
 
 	/* buffer usually freed in free_mid - need to free it here on exit */
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index f5dcc4940b6d..9dfd2dd612c2 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -61,7 +61,6 @@ smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 		nr_ioctl_req.Reserved = 0;
 		rc = SMB2_ioctl(xid, oparms->tcon, fid->persistent_fid,
 			fid->volatile_fid, FSCTL_LMR_REQUEST_RESILIENCY,
-			true /* is_fsctl */,
 			(char *)&nr_ioctl_req, sizeof(nr_ioctl_req),
 			CIFSMaxBufSize, NULL, NULL /* no return info */);
 		if (rc == -EOPNOTSUPP) {
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index f8847546d6ac..b725bd3144fb 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -85,6 +85,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		pr_warn_once("server overflowed SMB3 credits\n");
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
@@ -647,7 +648,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
 	struct cifs_ses *ses = tcon->ses;
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
-			FSCTL_QUERY_NETWORK_INTERFACE_INFO, true /* is_fsctl */,
+			FSCTL_QUERY_NETWORK_INTERFACE_INFO,
 			NULL /* no data input */, 0 /* no data input */,
 			CIFSMaxBufSize, (char **)&out_buf, &ret_data_len);
 	if (rc == -EOPNOTSUPP) {
@@ -908,10 +909,12 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		 */
 		kref_get(&tcon->crfid.refcount);
 		tcon->crfid.has_lease = true;
-		smb2_parse_contexts(server, o_rsp,
+		rc = smb2_parse_contexts(server, rsp_iov,
 				&oparms.fid->epoch,
 				    oparms.fid->lease_key, &oplock,
 				    NULL, NULL);
+		if (rc)
+			goto oshr_exit;
 	} else
 		goto oshr_exit;
 
@@ -1580,9 +1583,8 @@ SMB2_request_res_key(const unsigned int xid, struct cifs_tcon *tcon,
 	struct resume_key_req *res_key;
 
 	rc = SMB2_ioctl(xid, tcon, persistent_fid, volatile_fid,
-			FSCTL_SRV_REQUEST_RESUME_KEY, true /* is_fsctl */,
-			NULL, 0 /* no input */, CIFSMaxBufSize,
-			(char **)&res_key, &ret_data_len);
+			FSCTL_SRV_REQUEST_RESUME_KEY, NULL, 0 /* no input */,
+			CIFSMaxBufSize, (char **)&res_key, &ret_data_len);
 
 	if (rc == -EOPNOTSUPP) {
 		pr_warn_once("Server share %s does not support copy range\n", tcon->treeName);
@@ -1724,7 +1726,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 		rqst[1].rq_nvec = SMB2_IOCTL_IOV_SIZE;
 
 		rc = SMB2_ioctl_init(tcon, server, &rqst[1], COMPOUND_FID, COMPOUND_FID,
-				     qi.info_type, true, buffer, qi.output_buffer_length,
+				     qi.info_type, buffer, qi.output_buffer_length,
 				     CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
 				     MAX_SMB2_CLOSE_RESPONSE_SIZE);
 		free_req1_func = SMB2_ioctl_free;
@@ -1900,9 +1902,8 @@ smb2_copychunk_range(const unsigned int xid,
 		retbuf = NULL;
 		rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
 			trgtfile->fid.volatile_fid, FSCTL_SRV_COPYCHUNK_WRITE,
-			true /* is_fsctl */, (char *)pcchunk,
-			sizeof(struct copychunk_ioctl),	CIFSMaxBufSize,
-			(char **)&retbuf, &ret_data_len);
+			(char *)pcchunk, sizeof(struct copychunk_ioctl),
+			CIFSMaxBufSize, (char **)&retbuf, &ret_data_len);
 		if (rc == 0) {
 			if (ret_data_len !=
 					sizeof(struct copychunk_ioctl_rsp)) {
@@ -2062,7 +2063,6 @@ static bool smb2_set_sparse(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid, FSCTL_SET_SPARSE,
-			true /* is_fctl */,
 			&setsparse, 1, CIFSMaxBufSize, NULL, NULL);
 	if (rc) {
 		tcon->broken_sparse_sup = true;
@@ -2145,7 +2145,6 @@ smb2_duplicate_extents(const unsigned int xid,
 	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
 			trgtfile->fid.volatile_fid,
 			FSCTL_DUPLICATE_EXTENTS_TO_FILE,
-			true /* is_fsctl */,
 			(char *)&dup_ext_buf,
 			sizeof(struct duplicate_extents_to_file),
 			CIFSMaxBufSize, NULL,
@@ -2180,7 +2179,6 @@ smb3_set_integrity(const unsigned int xid, struct cifs_tcon *tcon,
 	return SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid,
 			FSCTL_SET_INTEGRITY_INFORMATION,
-			true /* is_fsctl */,
 			(char *)&integr_info,
 			sizeof(struct fsctl_set_integrity_information_req),
 			CIFSMaxBufSize, NULL,
@@ -2233,7 +2231,6 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid,
 			FSCTL_SRV_ENUMERATE_SNAPSHOTS,
-			true /* is_fsctl */,
 			NULL, 0 /* no input data */, max_response_size,
 			(char **)&retbuf,
 			&ret_data_len);
@@ -2918,7 +2915,6 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 	do {
 		rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 				FSCTL_DFS_GET_REFERRALS,
-				true /* is_fsctl */,
 				(char *)dfs_req, dfs_req_size, CIFSMaxBufSize,
 				(char **)&dfs_rsp, &dfs_rsp_size);
 		if (!is_retryable_error(rc))
@@ -3127,8 +3123,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = SMB2_ioctl_init(tcon, server,
 			     &rqst[1], fid.persistent_fid,
-			     fid.volatile_fid, FSCTL_GET_REPARSE_POINT,
-			     true /* is_fctl */, NULL, 0,
+			     fid.volatile_fid, FSCTL_GET_REPARSE_POINT, NULL, 0,
 			     CIFSMaxBufSize -
 			     MAX_SMB2_CREATE_RESPONSE_SIZE -
 			     MAX_SMB2_CLOSE_RESPONSE_SIZE);
@@ -3308,8 +3303,7 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = SMB2_ioctl_init(tcon, server,
 			     &rqst[1], COMPOUND_FID,
-			     COMPOUND_FID, FSCTL_GET_REPARSE_POINT,
-			     true /* is_fctl */, NULL, 0,
+			     COMPOUND_FID, FSCTL_GET_REPARSE_POINT, NULL, 0,
 			     CIFSMaxBufSize -
 			     MAX_SMB2_CREATE_RESPONSE_SIZE -
 			     MAX_SMB2_CLOSE_RESPONSE_SIZE);
@@ -3585,7 +3579,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	fsctl_buf.BeyondFinalZero = cpu_to_le64(offset + len);
 
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
-			cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA, true,
+			cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA,
 			(char *)&fsctl_buf,
 			sizeof(struct file_zero_data_information),
 			0, NULL, NULL);
@@ -3646,7 +3640,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA,
-			true /* is_fctl */, (char *)&fsctl_buf,
+			(char *)&fsctl_buf,
 			sizeof(struct file_zero_data_information),
 			CIFSMaxBufSize, NULL, NULL);
 	filemap_invalidate_unlock(inode->i_mapping);
@@ -3708,7 +3702,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	in_data.length = cpu_to_le64(len);
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid,
-			FSCTL_QUERY_ALLOCATED_RANGES, true,
+			FSCTL_QUERY_ALLOCATED_RANGES,
 			(char *)&in_data, sizeof(in_data),
 			1024 * sizeof(struct file_allocated_range_buffer),
 			(char **)&out_data, &out_data_len);
@@ -4020,7 +4014,7 @@ static loff_t smb3_llseek(struct file *file, struct cifs_tcon *tcon, loff_t offs
 
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid,
-			FSCTL_QUERY_ALLOCATED_RANGES, true,
+			FSCTL_QUERY_ALLOCATED_RANGES,
 			(char *)&in_data, sizeof(in_data),
 			sizeof(struct file_allocated_range_buffer),
 			(char **)&out_data, &out_data_len);
@@ -4080,7 +4074,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
 			cfile->fid.volatile_fid,
-			FSCTL_QUERY_ALLOCATED_RANGES, true,
+			FSCTL_QUERY_ALLOCATED_RANGES,
 			(char *)&in_data, sizeof(in_data),
 			1024 * sizeof(struct file_allocated_range_buffer),
 			(char **)&out_data, &out_data_len);
@@ -5153,6 +5147,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	struct smb2_sync_hdr *shdr;
 	unsigned int pdu_length = server->pdu_size;
 	unsigned int buf_size;
+	unsigned int next_cmd;
 	struct mid_q_entry *mid_entry;
 	int next_is_large;
 	char *next_buffer = NULL;
@@ -5181,14 +5176,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	next_is_large = server->large_buf;
 one_more:
 	shdr = (struct smb2_sync_hdr *)buf;
-	if (shdr->NextCommand) {
+	next_cmd = le32_to_cpu(shdr->NextCommand);
+	if (next_cmd) {
+		if (WARN_ON_ONCE(next_cmd > pdu_length))
+			return -1;
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
 			next_buffer = (char *)cifs_small_buf_get();
-		memcpy(next_buffer,
-		       buf + le32_to_cpu(shdr->NextCommand),
-		       pdu_length - le32_to_cpu(shdr->NextCommand));
+		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 
 	mid_entry = smb2_find_mid(server, buf);
@@ -5212,8 +5208,8 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	else
 		ret = cifs_handle_standard(server, mid_entry);
 
-	if (ret == 0 && shdr->NextCommand) {
-		pdu_length -= le32_to_cpu(shdr->NextCommand);
+	if (ret == 0 && next_cmd) {
+		pdu_length -= next_cmd;
 		server->large_buf = next_is_large;
 		if (next_is_large)
 			server->bigbuf = buf = next_buffer;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index a21eeb23f8e1..61b18f802048 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1152,7 +1152,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	}
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
-		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
+		FSCTL_VALIDATE_NEGOTIATE_INFO,
 		(char *)pneg_inbuf, inbuflen, CIFSMaxBufSize,
 		(char **)&pneg_rsp, &rsplen);
 	if (rc == -EOPNOTSUPP) {
@@ -2055,17 +2055,18 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 posix->nlink, posix->mode, posix->reparse_tag);
 }
 
-void
-smb2_parse_contexts(struct TCP_Server_Info *server,
-		    struct smb2_create_rsp *rsp,
-		    unsigned int *epoch, char *lease_key, __u8 *oplock,
-		    struct smb2_file_all_info *buf,
-		    struct create_posix_rsp *posix)
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf,
+			struct create_posix_rsp *posix)
 {
-	char *data_offset;
+	struct smb2_create_rsp *rsp = rsp_iov->iov_base;
 	struct create_context *cc;
-	unsigned int next;
-	unsigned int remaining;
+	size_t rem, off, len;
+	size_t doff, dlen;
+	size_t noff, nlen;
 	char *name;
 	static const char smb3_create_tag_posix[] = {
 		0x93, 0xAD, 0x25, 0x50, 0x9C,
@@ -2074,45 +2075,63 @@ smb2_parse_contexts(struct TCP_Server_Info *server,
 	};
 
 	*oplock = 0;
-	data_offset = (char *)rsp + le32_to_cpu(rsp->CreateContextsOffset);
-	remaining = le32_to_cpu(rsp->CreateContextsLength);
-	cc = (struct create_context *)data_offset;
+
+	off = le32_to_cpu(rsp->CreateContextsOffset);
+	rem = le32_to_cpu(rsp->CreateContextsLength);
+	if (check_add_overflow(off, rem, &len) || len > rsp_iov->iov_len)
+		return -EINVAL;
+	cc = (struct create_context *)((u8 *)rsp + off);
 
 	/* Initialize inode number to 0 in case no valid data in qfid context */
 	if (buf)
 		buf->IndexNumber = 0;
 
-	while (remaining >= sizeof(struct create_context)) {
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) == 4 &&
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4) == 0)
-			*oplock = server->ops->parse_lease_buf(cc, epoch,
-							   lease_key);
-		else if (buf && (le16_to_cpu(cc->NameLength) == 4) &&
-		    strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4) == 0)
-			parse_query_id_ctxt(cc, buf);
-		else if ((le16_to_cpu(cc->NameLength) == 16)) {
-			if (posix &&
-			    memcmp(name, smb3_create_tag_posix, 16) == 0)
+	while (rem >= sizeof(*cc)) {
+		doff = le16_to_cpu(cc->DataOffset);
+		dlen = le32_to_cpu(cc->DataLength);
+		if (check_add_overflow(doff, dlen, &len) || len > rem)
+			return -EINVAL;
+
+		noff = le16_to_cpu(cc->NameOffset);
+		nlen = le16_to_cpu(cc->NameLength);
+		if (noff + nlen > doff)
+			return -EINVAL;
+
+		name = (char *)cc + noff;
+		switch (nlen) {
+		case 4:
+			if (!strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+				*oplock = server->ops->parse_lease_buf(cc, epoch,
+								       lease_key);
+			} else if (buf &&
+				   !strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4)) {
+				parse_query_id_ctxt(cc, buf);
+			}
+			break;
+		case 16:
+			if (posix && !memcmp(name, smb3_create_tag_posix, 16))
 				parse_posix_ctxt(cc, buf, posix);
+			break;
+		default:
+			cifs_dbg(FYI, "%s: unhandled context (nlen=%zu dlen=%zu)\n",
+				 __func__, nlen, dlen);
+			if (IS_ENABLED(CONFIG_CIFS_DEBUG2))
+				cifs_dump_mem("context data: ", cc, dlen);
+			break;
 		}
-		/* else {
-			cifs_dbg(FYI, "Context not matched with len %d\n",
-				le16_to_cpu(cc->NameLength));
-			cifs_dump_mem("Cctxt name: ", name, 4);
-		} */
-
-		next = le32_to_cpu(cc->Next);
-		if (!next)
+
+		off = le32_to_cpu(cc->Next);
+		if (!off)
 			break;
-		remaining -= next;
-		cc = (struct create_context *)((char *)cc + next);
+		if (check_sub_overflow(rem, off, &rem))
+			return -EINVAL;
+		cc = (struct create_context *)((u8 *)cc + off);
 	}
 
 	if (rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE)
 		*oplock = rsp->OplockLevel;
 
-	return;
+	return 0;
 }
 
 static int
@@ -2982,8 +3001,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	}
 
 
-	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf, posix);
+	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
+				 oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
@@ -2994,7 +3013,7 @@ int
 SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		struct smb_rqst *rqst,
 		u64 persistent_fid, u64 volatile_fid, u32 opcode,
-		bool is_fsctl, char *in_data, u32 indatalen,
+		char *in_data, u32 indatalen,
 		__u32 max_response_size)
 {
 	struct smb2_ioctl_req *req;
@@ -3069,10 +3088,8 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	req->sync_hdr.CreditCharge =
 		cpu_to_le16(DIV_ROUND_UP(max(indatalen, max_response_size),
 					 SMB2_MAX_BUFFER_SIZE));
-	if (is_fsctl)
-		req->Flags = cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL);
-	else
-		req->Flags = 0;
+	/* always an FSCTL (for now) */
+	req->Flags = cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL);
 
 	/* validate negotiate request must be signed - see MS-SMB2 3.2.5.5 */
 	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
@@ -3099,9 +3116,9 @@ SMB2_ioctl_free(struct smb_rqst *rqst)
  */
 int
 SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
-	   u64 volatile_fid, u32 opcode, bool is_fsctl,
-	   char *in_data, u32 indatalen, u32 max_out_data_len,
-	   char **out_data, u32 *plen /* returned data len */)
+	   u64 volatile_fid, u32 opcode, char *in_data, u32 indatalen,
+	   u32 max_out_data_len, char **out_data,
+	   u32 *plen /* returned data len */)
 {
 	struct smb_rqst rqst;
 	struct smb2_ioctl_rsp *rsp = NULL;
@@ -3143,7 +3160,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 
 	rc = SMB2_ioctl_init(tcon, server,
 			     &rqst, persistent_fid, volatile_fid, opcode,
-			     is_fsctl, in_data, indatalen, max_out_data_len);
+			     in_data, indatalen, max_out_data_len);
 	if (rc)
 		goto ioctl_exit;
 
@@ -3225,7 +3242,7 @@ SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 			cpu_to_le16(COMPRESSION_FORMAT_DEFAULT);
 
 	rc = SMB2_ioctl(xid, tcon, persistent_fid, volatile_fid,
-			FSCTL_SET_COMPRESSION, true /* is_fsctl */,
+			FSCTL_SET_COMPRESSION,
 			(char *)&fsctl_input /* data input */,
 			2 /* in data len */, CIFSMaxBufSize /* max out data */,
 			&ret_data /* out data */, NULL);
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 547945443fa7..ada1d7338f34 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -144,13 +144,13 @@ extern int SMB2_open_init(struct cifs_tcon *tcon,
 extern void SMB2_open_free(struct smb_rqst *rqst);
 extern int SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon,
 		     u64 persistent_fid, u64 volatile_fid, u32 opcode,
-		     bool is_fsctl, char *in_data, u32 indatalen, u32 maxoutlen,
+		     char *in_data, u32 indatalen, u32 maxoutlen,
 		     char **out_data, u32 *plen /* returned data len */);
 extern int SMB2_ioctl_init(struct cifs_tcon *tcon,
 			   struct TCP_Server_Info *server,
 			   struct smb_rqst *rqst,
 			   u64 persistent_fid, u64 volatile_fid, u32 opcode,
-			   bool is_fsctl, char *in_data, u32 indatalen,
+			   char *in_data, u32 indatalen,
 			   __u32 max_response_size);
 extern void SMB2_ioctl_free(struct smb_rqst *rqst);
 extern int SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
@@ -259,11 +259,13 @@ extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
 
 extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
-extern void smb2_parse_contexts(struct TCP_Server_Info *server,
-				struct smb2_create_rsp *rsp,
-				unsigned int *epoch, char *lease_key,
-				__u8 *oplock, struct smb2_file_all_info *buf,
-				struct create_posix_rsp *posix);
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf,
+			struct create_posix_rsp *posix);
+
 extern int smb3_encryption_required(const struct cifs_tcon *tcon);
 extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 			     struct kvec *iov, unsigned int min_buf_size);
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 8193c14bb111..b4be6c524815 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -124,11 +124,11 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 }
 
 static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
-			void *inpage, unsigned int *inputmargin, int *maptype,
-			bool support_0padding)
+		void *inpage, void *out, unsigned int *inputmargin, int *maptype,
+		bool support_0padding)
 {
 	unsigned int nrpages_in, nrpages_out;
-	unsigned int ofull, oend, inputsize, total, i, j;
+	unsigned int ofull, oend, inputsize, total, i;
 	struct page **in;
 	void *src, *tmp;
 
@@ -143,12 +143,13 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
 			goto docopy;
 
-		for (i = 0; i < nrpages_in; ++i) {
-			DBG_BUGON(rq->in[i] == NULL);
-			for (j = 0; j < nrpages_out - nrpages_in + i; ++j)
-				if (rq->out[j] == rq->in[i])
-					goto docopy;
-		}
+		for (i = 0; i < nrpages_in; ++i)
+			if (rq->out[nrpages_out - nrpages_in + i] !=
+			    rq->in[i])
+				goto docopy;
+		kunmap_atomic(inpage);
+		*maptype = 3;
+		return out + ((nrpages_out - nrpages_in) << PAGE_SHIFT);
 	}
 
 	if (nrpages_in <= 1) {
@@ -156,7 +157,6 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 		return inpage;
 	}
 	kunmap_atomic(inpage);
-	might_sleep();
 	src = erofs_vm_map_ram(rq->in, nrpages_in);
 	if (!src)
 		return ERR_PTR(-ENOMEM);
@@ -193,10 +193,10 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	return src;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *dst)
 {
 	unsigned int inputmargin;
-	u8 *headpage, *src;
+	u8 *out, *headpage, *src;
 	bool support_0padding;
 	int ret, maptype;
 
@@ -220,11 +220,12 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	}
 
 	rq->inputsize -= inputmargin;
-	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
-					support_0padding);
+	src = z_erofs_handle_inplace_io(rq, headpage, dst, &inputmargin,
+					&maptype, support_0padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
+	out = dst + rq->pageofs_out;
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
@@ -253,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
 	} else if (maptype == 2) {
 		erofs_put_pcpubuf(src);
-	} else {
+	} else if (maptype != 3) {
 		DBG_BUGON(1);
 		return -EFAULT;
 	}
@@ -354,8 +355,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
-
+	ret = alg->decompress(rq, dst);
 	if (!dst_maptype)
 		kunmap_atomic(dst);
 	else if (dst_maptype == 2)
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index f6dd4fc8eaf4..be7570d01ae1 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -618,6 +618,10 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 			bforget(es->bh[i]);
 		else
 			brelse(es->bh[i]);
+
+	if (IS_DYNAMIC_ES(es))
+		kfree(es->bh);
+
 	kfree(es);
 	return err;
 }
@@ -853,6 +857,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	/* byte offset in sector */
 	off = EXFAT_BLK_OFFSET(byte_offset, sb);
 	es->start_off = off;
+	es->bh = es->__bh;
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -872,6 +877,16 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	es->num_entries = num_entries;
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	if (num_bh > ARRAY_SIZE(es->__bh)) {
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		if (!es->bh) {
+			brelse(bh);
+			kfree(es);
+			return NULL;
+		}
+		es->bh[0] = bh;
+	}
+
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index db538709dafa..58816ee3162c 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -170,10 +170,13 @@ struct exfat_entry_set_cache {
 	bool modified;
 	unsigned int start_off;
 	int num_bh;
-	struct buffer_head *bh[DIR_CACHE_SIZE];
+	struct buffer_head *__bh[DIR_CACHE_SIZE];
+	struct buffer_head **bh;
 	unsigned int num_entries;
 };
 
+#define IS_DYNAMIC_ES(es)	((es)->__bh != (es)->bh)
+
 struct exfat_dir_entry {
 	struct exfat_chain dir;
 	int entry;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 592be39e3d51..cece004b32d5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2227,7 +2227,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 
 /*
- * ext4_ext_determine_hole - determine hole around given block
+ * ext4_ext_find_hole - find hole around given block according to the given path
  * @inode:	inode we lookup in
  * @path:	path in extent tree to @lblk
  * @lblk:	pointer to logical block around which we want to determine hole
@@ -2239,9 +2239,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
  * The function returns the length of a hole starting at @lblk. We update @lblk
  * to the beginning of the hole if we managed to find it.
  */
-static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
-					   struct ext4_ext_path *path,
-					   ext4_lblk_t *lblk)
+static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
+				      struct ext4_ext_path *path,
+				      ext4_lblk_t *lblk)
 {
 	int depth = ext_depth(inode);
 	struct ext4_extent *ex;
@@ -2268,30 +2268,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
 	return len;
 }
 
-/*
- * ext4_ext_put_gap_in_cache:
- * calculate boundaries of the gap that the requested block fits into
- * and cache this gap
- */
-static void
-ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
-			  ext4_lblk_t hole_len)
-{
-	struct extent_status es;
-
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
-				  hole_start + hole_len - 1, &es);
-	if (es.es_len) {
-		/* There's delayed extent containing lblock? */
-		if (es.es_lblk <= hole_start)
-			return;
-		hole_len = min(es.es_lblk - hole_start, hole_len);
-	}
-	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
-	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
-			      EXTENT_STATUS_HOLE);
-}
-
 /*
  * ext4_ext_rm_idx:
  * removes index from the index block.
@@ -4064,6 +4040,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Determine hole length around the given logical block, first try to
+ * locate and expand the hole from the given @path, and then adjust it
+ * if it's partially or completely converted to delayed extents, insert
+ * it into the extent cache tree if it's indeed a hole, finally return
+ * the length of the determined extent.
+ */
+static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t lblk)
+{
+	ext4_lblk_t hole_start, len;
+	struct extent_status es;
+
+	hole_start = lblk;
+	len = ext4_ext_find_hole(inode, path, &hole_start);
+again:
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
+				  hole_start + len - 1, &es);
+	if (!es.es_len)
+		goto insert_hole;
+
+	/*
+	 * There's a delalloc extent in the hole, handle it if the delalloc
+	 * extent is in front of, behind and straddle the queried range.
+	 */
+	if (lblk >= es.es_lblk + es.es_len) {
+		/*
+		 * The delalloc extent is in front of the queried range,
+		 * find again from the queried start block.
+		 */
+		len -= lblk - hole_start;
+		hole_start = lblk;
+		goto again;
+	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
+		/*
+		 * The delalloc extent containing lblk, it must have been
+		 * added after ext4_map_blocks() checked the extent status
+		 * tree, adjust the length to the delalloc extent's after
+		 * lblk.
+		 */
+		len = es.es_lblk + es.es_len - lblk;
+		return len;
+	} else {
+		/*
+		 * The delalloc extent is partially or completely behind
+		 * the queried range, update hole length until the
+		 * beginning of the delalloc extent.
+		 */
+		len = min(es.es_lblk - hole_start, len);
+	}
+
+insert_hole:
+	/* Put just found gap into cache to speed up subsequent requests */
+	ext_debug(inode, " -> %u:%u\n", hole_start, len);
+	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
+
+	/* Update hole_len to reflect hole size after lblk */
+	if (hole_start != lblk)
+		len -= lblk - hole_start;
+
+	return len;
+}
 
 /*
  * Block allocation/map/preallocation routine for extents based files
@@ -4181,22 +4220,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * we couldn't try to create block if create flag is zero
 	 */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
-		ext4_lblk_t hole_start, hole_len;
+		ext4_lblk_t len;
 
-		hole_start = map->m_lblk;
-		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
-		/*
-		 * put just found gap into cache to speed up
-		 * subsequent requests
-		 */
-		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
+		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
 
-		/* Update hole_len to reflect hole size after map->m_lblk */
-		if (hole_start != map->m_lblk)
-			hole_len -= map->m_lblk - hole_start;
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, hole_len);
-
+		map->m_len = min_t(unsigned int, map->m_len, len);
 		goto out;
 	}
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 762c2f8b5b2a..a254c2ba0357 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -853,7 +853,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
 		return;
 
 	write_lock(&sbi->s_mb_rb_lock);
@@ -1168,6 +1168,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	mb_update_avg_fragment_size(sb, grp);
 }
 
+static void mb_regenerate_buddy(struct ext4_buddy *e4b)
+{
+	int count;
+	int order = 1;
+	void *buddy;
+
+	while ((buddy = mb_find_buddy(e4b, order++, &count)))
+		ext4_set_bits(buddy, 0, count);
+
+	e4b->bd_info->bb_fragments = 0;
+	memset(e4b->bd_info->bb_counters, 0,
+		sizeof(*e4b->bd_info->bb_counters) *
+		(e4b->bd_sb->s_blocksize_bits + 2));
+
+	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
+		e4b->bd_bitmap, e4b->bd_group, e4b->bd_info);
+}
+
 /* The buddy information is attached the buddy cache inode
  * for convenience. The information regarding each group
  * is loaded via ext4_mb_load_buddy. The information involve
@@ -1817,11 +1835,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	mb_check_buddy(e4b);
 	mb_free_blocks_double(inode, e4b, first, count);
 
-	this_cpu_inc(discard_pa_seq);
-	e4b->bd_info->bb_free += count;
-	if (first < e4b->bd_info->bb_first_free)
-		e4b->bd_info->bb_first_free = first;
-
 	/* access memory sequentially: check left neighbour,
 	 * clear range and then check right neighbour
 	 */
@@ -1835,21 +1848,31 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 		struct ext4_sb_info *sbi = EXT4_SB(sb);
 		ext4_fsblk_t blocknr;
 
+		/*
+		 * Fastcommit replay can free already freed blocks which
+		 * corrupts allocation info. Regenerate it.
+		 */
+		if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+			mb_regenerate_buddy(e4b);
+			goto check;
+		}
+
 		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
 		blocknr += EXT4_C2B(sbi, block);
-		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
-			ext4_grp_locked_error(sb, e4b->bd_group,
-					      inode ? inode->i_ino : 0,
-					      blocknr,
-					      "freeing already freed block (bit %u); block bitmap corrupt.",
-					      block);
-			ext4_mark_group_bitmap_corrupted(
-				sb, e4b->bd_group,
+		ext4_grp_locked_error(sb, e4b->bd_group,
+				      inode ? inode->i_ino : 0, blocknr,
+				      "freeing already freed block (bit %u); block bitmap corrupt.",
+				      block);
+		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
-		}
-		goto done;
+		return;
 	}
 
+	this_cpu_inc(discard_pa_seq);
+	e4b->bd_info->bb_free += count;
+	if (first < e4b->bd_info->bb_first_free)
+		e4b->bd_info->bb_first_free = first;
+
 	/* let's maintain fragments counter */
 	if (left_is_free && right_is_free)
 		e4b->bd_info->bb_fragments--;
@@ -1874,9 +1897,9 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	if (first <= last)
 		mb_buddy_mark_free(e4b, first >> 1, last >> 1);
 
-done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
 	mb_update_avg_fragment_size(sb, e4b->bd_info);
+check:
 	mb_check_buddy(e4b);
 }
 
@@ -2197,6 +2220,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -2204,6 +2230,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
@@ -2232,12 +2259,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (err)
 		return err;
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) {
-		ext4_mb_unload_buddy(e4b);
-		return 0;
-	}
-
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ac->ac_g_ex.fe_start,
 			     ac->ac_g_ex.fe_len, &ex);
 	ex.fe_logical = 0xDEADFA11; /* debug value */
@@ -2270,6 +2295,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7010440cb64c..2c13f308c74e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1199,7 +1199,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 	if (f2fs_is_pinned_file(inode)) {
-		f2fs_pin_file_control(inode, true);
+		if (gc_type == FG_GC)
+			f2fs_pin_file_control(inode, true);
 		err = -EAGAIN;
 		goto out;
 	}
@@ -1781,23 +1782,31 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (sync)
 		goto stop;
 
-	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
-		if (skipped_round <= MAX_SKIP_GC_COUNT ||
-					skipped_round * 2 < round) {
-			segno = NULL_SEGNO;
-			goto gc_more;
-		}
+	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
+		goto stop;
 
-		if (first_skipped < last_skipped &&
-				(last_skipped - first_skipped) >
-						sbi->skipped_gc_rwsem) {
-			f2fs_drop_inmem_pages_all(sbi, true);
-			segno = NULL_SEGNO;
-			goto gc_more;
-		}
-		if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
+
+		/* Write checkpoint to reclaim prefree segments */
+		if (free_sections(sbi) < NR_CURSEG_PERSIST_TYPE &&
+				prefree_segments(sbi) &&
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 			ret = f2fs_write_checkpoint(sbi, &cpc);
-	}
+			if (ret)
+				goto stop;
+		}
+		segno = NULL_SEGNO;
+		goto gc_more;
+	}
+	if (first_skipped < last_skipped &&
+			(last_skipped - first_skipped) >
+					sbi->skipped_gc_rwsem) {
+		f2fs_drop_inmem_pages_all(sbi, true);
+		segno = NULL_SEGNO;
+		goto gc_more;
+	}
+	if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+		ret = f2fs_write_checkpoint(sbi, &cpc);
 stop:
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7e8f1c89124f..0613b8d14409 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6175,8 +6175,10 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 					     offsetof(struct smb2_read_rsp, Buffer),
 					     aux_payload_buf, nbytes);
-		if (err)
+		if (err) {
+			kvfree(aux_payload_buf);
 			goto out;
+		}
 		kvfree(rpc_resp);
 	} else {
 		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
@@ -6386,8 +6388,10 @@ int smb2_read(struct ksmbd_work *work)
 	err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 				     offsetof(struct smb2_read_rsp, Buffer),
 				     aux_payload_buf, nbytes);
-	if (err)
+	if (err) {
+		kvfree(aux_payload_buf);
 		goto out;
+	}
 	ksmbd_fd_put(work, fp);
 	return 0;
 
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 1d5ac2164d94..64a6d255c468 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1583,8 +1583,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b)
-				return -ENOENT;
+			if (!attr_b) {
+				err = -ENOENT;
+				goto out;
+			}
 
 			attr = attr_b;
 			le = le_b;
@@ -1665,13 +1667,15 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 ok:
 	run_truncate_around(run, vcn);
 out:
-	if (new_valid > data_size)
-		new_valid = data_size;
+	if (attr_b) {
+		if (new_valid > data_size)
+			new_valid = data_size;
 
-	valid_size = le64_to_cpu(attr_b->nres.valid_size);
-	if (new_valid != valid_size) {
-		attr_b->nres.valid_size = cpu_to_le64(valid_size);
-		mi_b->dirty = true;
+		valid_size = le64_to_cpu(attr_b->nres.valid_size);
+		if (new_valid != valid_size) {
+			attr_b->nres.valid_size = cpu_to_le64(valid_size);
+			mi_b->dirty = true;
+		}
 	}
 
 	return err;
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 0c6a68e71e7d..723e49ec83ce 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -127,12 +127,13 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 {
 	size_t off;
 	u16 sz;
+	const unsigned le_min_size = le_size(0);
 
 	if (!le) {
 		le = ni->attr_list.le;
 	} else {
 		sz = le16_to_cpu(le->size);
-		if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
+		if (sz < le_min_size) {
 			/* Impossible 'cause we should not return such le. */
 			return NULL;
 		}
@@ -141,7 +142,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 
 	/* Check boundary. */
 	off = PtrOffset(ni->attr_list.le, le);
-	if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
+	if (off + le_min_size > ni->attr_list.size) {
 		/* The regular end of list. */
 		return NULL;
 	}
@@ -149,8 +150,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 	sz = le16_to_cpu(le->size);
 
 	/* Check le for errors. */
-	if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
-	    off + sz > ni->attr_list.size ||
+	if (sz < le_min_size || off + sz > ni->attr_list.size ||
 	    sz < le->name_off + le->name_len * sizeof(short)) {
 		return NULL;
 	}
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index d4d9f4ffb6d9..72cdfa8727d3 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -309,11 +309,31 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		return 0;
 	}
 
-	/* NTFS: symlinks are "dir + reparse" or "file + reparse" */
-	if (fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT)
-		dt_type = DT_LNK;
-	else
-		dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+	/*
+	 * NTFS: symlinks are "dir + reparse" or "file + reparse"
+	 * Unfortunately reparse attribute is used for many purposes (several dozens).
+	 * It is not possible here to know is this name symlink or not.
+	 * To get exactly the type of name we should to open inode (read mft).
+	 * getattr for opened file (fstat) correctly returns symlink.
+	 */
+	dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+
+	/*
+	 * It is not reliable to detect the type of name using duplicated information
+	 * stored in parent directory.
+	 * The only correct way to get the type of name - read MFT record and find ATTR_STD.
+	 * The code below is not good idea.
+	 * It does additional locks/reads just to get the type of name.
+	 * Should we use additional mount option to enable branch below?
+	 */
+	if ((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) &&
+	    ino != ni->mi.rno) {
+		struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
+		if (!IS_ERR_OR_NULL(inode)) {
+			dt_type = fs_umode_to_dtype(inode->i_mode);
+			iput(inode);
+		}
+	}
 
 	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
@@ -495,11 +515,9 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 	struct INDEX_HDR *hdr;
 	const struct ATTR_FILE_NAME *fname;
 	u32 e_size, off, end;
-	u64 vbo = 0;
 	size_t drs = 0, fles = 0, bit = 0;
-	loff_t i_size = ni->vfs_inode.i_size;
 	struct indx_node *node = NULL;
-	u8 index_bits = ni->dir.index_bits;
+	size_t max_indx = ni->vfs_inode.i_size >> ni->dir.index_bits;
 
 	if (is_empty)
 		*is_empty = true;
@@ -543,7 +561,7 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 				fles += 1;
 		}
 
-		if (vbo >= i_size)
+		if (bit >= max_indx)
 			goto out;
 
 		err = indx_used_bit(&ni->dir, ni, &bit);
@@ -553,8 +571,7 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 		if (bit == MINUS_ONE_T)
 			goto out;
 
-		vbo = (u64)bit << index_bits;
-		if (vbo >= i_size)
+		if (bit >= max_indx)
 			goto out;
 
 		err = indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
@@ -564,7 +581,6 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 
 		hdr = &node->index->ihdr;
 		bit += 1;
-		vbo = (u64)bit << ni->dir.idx2vbn_bits;
 	}
 
 out:
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c526e0427f2b..6d4f3431bc75 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1090,6 +1090,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	iocb->ki_pos += written;
 	if (iocb->ki_pos > ni->i_valid)
 		ni->i_valid = iocb->ki_pos;
+	if (iocb->ki_pos > i_size)
+		i_size_write(inode, iocb->ki_pos);
 
 	return written;
 }
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 8b95c06e5a4c..6ba1357f3ed4 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -465,7 +465,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 {
 	const struct RESTART_AREA *ra;
 	u16 cl, fl, ul;
-	u32 off, l_size, file_dat_bits, file_size_round;
+	u32 off, l_size, seq_bits;
 	u16 ro = le16_to_cpu(rhdr->ra_off);
 	u32 sys_page = le32_to_cpu(rhdr->sys_page_size);
 
@@ -511,13 +511,15 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 	/* Make sure the sequence number bits match the log file size. */
 	l_size = le64_to_cpu(ra->l_size);
 
-	file_dat_bits = sizeof(u64) * 8 - le32_to_cpu(ra->seq_num_bits);
-	file_size_round = 1u << (file_dat_bits + 3);
-	if (file_size_round != l_size &&
-	    (file_size_round < l_size || (file_size_round / 2) > l_size)) {
-		return false;
+	seq_bits = sizeof(u64) * 8 + 3;
+	while (l_size) {
+		l_size >>= 1;
+		seq_bits -= 1;
 	}
 
+	if (seq_bits != ra->seq_num_bits)
+		return false;
+
 	/* The log page data offset and record header length must be quad-aligned. */
 	if (!IS_ALIGNED(le16_to_cpu(ra->data_off), 8) ||
 	    !IS_ALIGNED(le16_to_cpu(ra->rec_hdr_len), 8))
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 110690edbf62..1b082b7a67ee 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -981,6 +981,30 @@ static inline __le32 security_hash(const void *sd, size_t bytes)
 	return cpu_to_le32(hash);
 }
 
+/*
+ * simple wrapper for sb_bread_unmovable.
+ */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
+{
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct buffer_head *bh;
+
+	if (unlikely(block >= sbi->volume.blocks)) {
+		/* prevent generic message "attempt to access beyond end of device" */
+		ntfs_err(sb, "try to read out of volume at offset 0x%llx",
+			 (u64)block << sb->s_blocksize_bits);
+		return NULL;
+	}
+
+	bh = sb_bread_unmovable(sb, block);
+	if (bh)
+		return bh;
+
+	ntfs_err(sb, "failed to read volume at offset 0x%llx",
+		 (u64)block << sb->s_blocksize_bits);
+	return NULL;
+}
+
 int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 {
 	struct block_device *bdev = sb->s_bdev;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 176b04a5d1ad..0ff673bb4b2b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -402,7 +402,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 
 	if (!is_match && name) {
-		/* Reuse rec as buffer for ascii name. */
 		err = -ENOENT;
 		goto out;
 	}
@@ -417,6 +416,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	if (names != le16_to_cpu(rec->hard_links)) {
 		/* Correct minor error on the fly. Do not mark inode as dirty. */
+		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
 		rec->hard_links = cpu_to_le16(names);
 		ni->mi.dirty = true;
 	}
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 0f38d558169a..ba26a465b309 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -517,12 +517,10 @@ struct ATTR_LIST_ENTRY {
 	__le64 vcn;		// 0x08: Starting VCN of this attribute.
 	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
 	__le16 id;		// 0x18: struct ATTRIB ID.
-	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset.
+	__le16 name[];		// 0x1A: Just to align. To get real name can use name_off.
 
 }; // sizeof(0x20)
 
-static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
-
 static inline u32 le_size(u8 name_len)
 {
 	return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 981276500043..12a3b41d351c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -581,6 +581,7 @@ bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block);
 bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
 int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 		       bool simple);
@@ -1011,19 +1012,6 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
 	return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
 }
 
-static inline struct buffer_head *ntfs_bread(struct super_block *sb,
-					     sector_t block)
-{
-	struct buffer_head *bh = sb_bread(sb, block);
-
-	if (bh)
-		return bh;
-
-	ntfs_err(sb, "failed to read volume at offset 0x%llx",
-		 (u64)block << sb->s_blocksize_bits);
-	return NULL;
-}
-
 static inline struct ntfs_inode *ntfs_i(struct inode *inode)
 {
 	return container_of(inode, struct ntfs_inode, vfs_inode);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 938fc286963f..ac43e4a6d57d 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -509,8 +509,20 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		return false;
 
 	if (ni && is_attr_indexed(attr)) {
-		le16_add_cpu(&ni->mi.mrec->hard_links, -1);
-		ni->mi.dirty = true;
+		u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
+		struct ATTR_FILE_NAME *fname =
+			attr->type != ATTR_NAME ?
+				NULL :
+				resident_data_ex(attr,
+						 SIZEOF_ATTRIBUTE_FILENAME);
+		if (fname && fname->type == FILE_NAME_DOS) {
+			/* Do not decrease links count deleting DOS name. */
+		} else if (!links) {
+			/* minor error. Not critical. */
+		} else {
+			ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
+			ni->mi.dirty = true;
+		}
 	}
 
 	used -= asize;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 8e739023e305..d0b75d7f58a7 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -217,6 +217,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
+		if (ea->name_len > ea_size)
+			break;
+
 		if (buffer) {
 			/* Check if we can use field ea->name */
 			if (off + ea_size > size)
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 9619a68df163..788f10a21ce0 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -327,16 +327,18 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
 	}
 }
 
-struct zonefs_ioerr_data {
-	struct inode	*inode;
-	bool		write;
-};
-
 static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
-	struct zonefs_ioerr_data *err = data;
-	struct inode *inode = err->inode;
+	struct blk_zone *z = data;
+
+	*z = *zone;
+	return 0;
+}
+
+static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
+				   bool write)
+{
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
@@ -352,8 +354,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	isize = i_size_read(inode);
 	if (zone->cond != BLK_ZONE_COND_OFFLINE &&
 	    zone->cond != BLK_ZONE_COND_READONLY &&
-	    !err->write && isize == data_size)
-		return 0;
+	    !write && isize == data_size)
+		return;
 
 	/*
 	 * At this point, we detected either a bad zone or an inconsistency
@@ -374,8 +376,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	 * In all cases, warn about inode size inconsistency and handle the
 	 * IO error according to the zone condition and to the mount options.
 	 */
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && isize != data_size)
-		zonefs_warn(sb, "inode %lu: invalid size %lld (should be %lld)\n",
+	if (isize != data_size)
+		zonefs_warn(sb,
+			    "inode %lu: invalid size %lld (should be %lld)\n",
 			    inode->i_ino, isize, data_size);
 
 	/*
@@ -435,8 +438,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset = data_size;
-
-	return 0;
 }
 
 /*
@@ -450,23 +451,25 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
-	unsigned int nr_zones = 1;
-	struct zonefs_ioerr_data err = {
-		.inode = inode,
-		.write = write,
-	};
+	struct blk_zone zone;
 	int ret;
 
 	/*
-	 * The only files that have more than one zone are conventional zone
-	 * files with aggregated conventional zones, for which the inode zone
-	 * size is always larger than the device zone size.
+	 * Conventional zone have no write pointer and cannot become read-only
+	 * or offline. So simply fake a report for a single or aggregated zone
+	 * and let zonefs_handle_io_error() correct the zone inode information
+	 * according to the mount options.
 	 */
-	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
-		nr_zones = zi->i_zone_size >>
-			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+	if (zi->i_ztype != ZONEFS_ZTYPE_SEQ) {
+		zone.start = zi->i_zsector;
+		zone.len = zi->i_max_size >> SECTOR_SHIFT;
+		zone.wp = zone.start + zone.len;
+		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zone.cond = BLK_ZONE_COND_NOT_WP;
+		zone.capacity = zone.len;
+		goto handle_io_error;
+	}
 
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
@@ -477,12 +480,19 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 	 * the GFP_NOIO context avoids both problems.
 	 */
 	noio_flag = memalloc_noio_save();
-	ret = blkdev_report_zones(sb->s_bdev, zi->i_zsector, nr_zones,
-				  zonefs_io_error_cb, &err);
-	if (ret != nr_zones)
+	ret = blkdev_report_zones(sb->s_bdev, zi->i_zsector, 1,
+				  zonefs_io_error_cb, &zone);
+	memalloc_noio_restore(noio_flag);
+	if (ret != 1) {
 		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
 			   inode->i_ino, ret);
-	memalloc_noio_restore(noio_flag);
+		zonefs_warn(sb, "remounting filesystem read-only\n");
+		sb->s_flags |= SB_RDONLY;
+		return;
+	}
+
+handle_io_error:
+	zonefs_handle_io_error(inode, &zone, write);
 }
 
 static void zonefs_io_error(struct inode *inode, bool write)
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 43927a1b9e94..5e872b01d5ab 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -318,8 +318,16 @@
 #define IMX8MP_CLK_AUDIO_AXI			310
 #define IMX8MP_CLK_HSIO_AXI			311
 #define IMX8MP_CLK_MEDIA_ISP			312
+#define IMX8MP_CLK_MEDIA_DISP2_PIX		313
+#define IMX8MP_CLK_CLKOUT1_SEL			314
+#define IMX8MP_CLK_CLKOUT1_DIV			315
+#define IMX8MP_CLK_CLKOUT1			316
+#define IMX8MP_CLK_CLKOUT2_SEL			317
+#define IMX8MP_CLK_CLKOUT2_DIV			318
+#define IMX8MP_CLK_CLKOUT2			319
+#define IMX8MP_CLK_USB_SUSP			320
 
-#define IMX8MP_CLK_END				313
+#define IMX8MP_CLK_END				321
 
 #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 49e5383d4222..6d7dd472d370 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -23,6 +23,8 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
+int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);
+int ahci_platform_assert_rsts(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
@@ -41,6 +43,7 @@ int ahci_platform_resume_host(struct device *dev);
 int ahci_platform_suspend(struct device *dev);
 int ahci_platform_resume(struct device *dev);
 
-#define AHCI_PLATFORM_GET_RESETS	0x01
+#define AHCI_PLATFORM_GET_RESETS	BIT(0)
+#define AHCI_PLATFORM_RST_TRIGGER	BIT(1)
 
 #endif /* _AHCI_PLATFORM_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 48f3cc3bafea..97d94bcba131 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2290,8 +2290,18 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
+#define MAX_BPRINTF_VARARGS		12
+#define MAX_BPRINTF_BUF			1024
+
+struct bpf_bprintf_data {
+	u32 *bin_args;
+	char *buf;
+	bool get_bin_args;
+	bool get_buf;
+};
+
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_buf, u32 num_args);
-void bpf_bprintf_cleanup(void);
+			u32 num_args, struct bpf_bprintf_data *data);
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 6cace09ba63d..7d5ca15ac66b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -61,7 +61,7 @@ struct clk_rate_request {
 };
 
 /**
- * struct clk_duty - Struture encoding the duty cycle ratio of a clock
+ * struct clk_duty - Structure encoding the duty cycle ratio of a clock
  *
  * @num:	Numerator of the duty cycle ratio
  * @den:	Denominator of the duty cycle ratio
@@ -116,7 +116,7 @@ struct clk_duty {
  * @restore_context: Restore the context of the clock after a restoration
  *		of power.
  *
- * @recalc_rate	Recalculate the rate of this clock, by querying hardware. The
+ * @recalc_rate: Recalculate the rate of this clock, by querying hardware. The
  *		parent rate is an input parameter.  It is up to the caller to
  *		ensure that the prepare_mutex is held across this call.
  *		Returns the calculated rate.  Optional, but recommended - if
@@ -442,7 +442,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
  * clock with the clock framework
  * @dev: device that is registering this clock
  * @name: name of this clock
- * @parent_name: name of clock's parent
+ * @parent_data: name of clock's parent
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  * @fixed_accuracy: non-adjustable clock accuracy
@@ -457,7 +457,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
  * the clock framework
  * @dev: device that is registering this clock
  * @name: name of this clock
- * @parent_name: name of clock's parent
+ * @parent_data: name of clock's parent
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  */
@@ -593,7 +593,7 @@ struct clk_div_table {
  * Clock with an adjustable divider affecting its output frequency.  Implements
  * .recalc_rate, .set_rate and .round_rate
  *
- * Flags:
+ * @flags:
  * CLK_DIVIDER_ONE_BASED - by default the divisor is the value read from the
  *	register plus one.  If CLK_DIVIDER_ONE_BASED is set then the divider is
  *	the raw value read from the register, with the value of zero considered
@@ -1023,11 +1023,12 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
  * @mwidth:	width of the numerator bit field
  * @nshift:	shift to the denominator bit field
  * @nwidth:	width of the denominator bit field
+ * @approximation: clk driver's callback for calculating the divider clock
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency.
  *
- * Flags:
+ * @flags:
  * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
  *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
  *	is set then the numerator and denominator are both the value read
@@ -1086,7 +1087,7 @@ void clk_hw_unregister_fractional_divider(struct clk_hw *hw);
  * Clock with an adjustable multiplier affecting its output frequency.
  * Implements .recalc_rate, .set_rate and .round_rate
  *
- * Flags:
+ * @flags:
  * CLK_MULTIPLIER_ZERO_BYPASS - By default, the multiplier is the value read
  *	from the register, with 0 being a valid value effectively
  *	zeroing the output clock rate. If CLK_MULTIPLIER_ZERO_BYPASS is
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6f287fac0ece..f32723d937fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -322,6 +322,8 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1d8209c09686..d1c19f5b1380 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -300,47 +300,59 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
 
+#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend = pm_sleep_ptr(suspend_fn), \
+	.resume = pm_sleep_ptr(resume_fn), \
+	.freeze = pm_sleep_ptr(suspend_fn), \
+	.thaw = pm_sleep_ptr(resume_fn), \
+	.poweroff = pm_sleep_ptr(suspend_fn), \
+	.restore = pm_sleep_ptr(resume_fn),
+
+#define LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_late = pm_sleep_ptr(suspend_fn), \
+	.resume_early = pm_sleep_ptr(resume_fn), \
+	.freeze_late = pm_sleep_ptr(suspend_fn), \
+	.thaw_early = pm_sleep_ptr(resume_fn), \
+	.poweroff_late = pm_sleep_ptr(suspend_fn), \
+	.restore_early = pm_sleep_ptr(resume_fn),
+
+#define NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_noirq = pm_sleep_ptr(suspend_fn), \
+	.resume_noirq = pm_sleep_ptr(resume_fn), \
+	.freeze_noirq = pm_sleep_ptr(suspend_fn), \
+	.thaw_noirq = pm_sleep_ptr(resume_fn), \
+	.poweroff_noirq = pm_sleep_ptr(suspend_fn), \
+	.restore_noirq = pm_sleep_ptr(resume_fn),
+
+#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+
 #ifdef CONFIG_PM_SLEEP
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn,
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #else
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_late = suspend_fn, \
-	.resume_early = resume_fn, \
-	.freeze_late = suspend_fn, \
-	.thaw_early = resume_fn, \
-	.poweroff_late = suspend_fn, \
-	.restore_early = resume_fn,
+	LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #else
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_noirq = suspend_fn, \
-	.resume_noirq = resume_fn, \
-	.freeze_noirq = suspend_fn, \
-	.thaw_noirq = resume_fn, \
-	.poweroff_noirq = suspend_fn, \
-	.restore_noirq = resume_fn,
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #else
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
 #ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-	.runtime_suspend = suspend_fn, \
-	.runtime_resume = resume_fn, \
-	.runtime_idle = idle_fn,
+	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #else
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #endif
@@ -349,9 +361,9 @@ struct dev_pm_ops {
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
  */
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops __maybe_unused name = { \
-	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+#define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
 /*
@@ -367,17 +379,27 @@ const struct dev_pm_ops __maybe_unused name = { \
  * .resume_early(), to the same routines as .runtime_suspend() and
  * .runtime_resume(), respectively (and analogously for hibernation).
  */
+#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
+static const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+}
+
+/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops __maybe_unused name = { \
+	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+}
+
+/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
-#ifdef CONFIG_PM
-#define pm_ptr(_ptr) (_ptr)
-#else
-#define pm_ptr(_ptr) NULL
-#endif
+#define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
+#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
 
 /*
  * PM_EVENT_ messages
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7bfc2b45cd99..9b3cfe685cb4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -608,10 +608,6 @@ struct sched_dl_entity {
 	 * task has to wait for a replenishment to be performed at the
 	 * next firing of dl_timer.
 	 *
-	 * @dl_boosted tells if we are boosted due to DI. If so we are
-	 * outside bandwidth enforcement mechanism (but only until we
-	 * exit the critical section);
-	 *
 	 * @dl_yielded tells if task gave up the CPU before consuming
 	 * all its available runtime during the last job.
 	 *
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 5f0e8403e8ce..9743f7d173a0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -125,7 +125,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 041d6032a348..4c5ce8124f8e 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -31,7 +31,10 @@ typedef __kernel_sa_family_t	sa_family_t;
 
 struct sockaddr {
 	sa_family_t	sa_family;	/* address family, AF_xxx	*/
-	char		sa_data[14];	/* 14 bytes of protocol address	*/
+	union {
+		char sa_data_min[14];		/* Minimum 14 bytes of protocol address	*/
+		DECLARE_FLEX_ARRAY(char, sa_data);
+	};
 };
 
 struct linger {
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index aaa518e777e9..dabd84fa3fd3 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -257,8 +257,8 @@ nf_flow_table_offload_del_cb(struct nf_flowtable *flow_table,
 	up_write(&flow_table->flow_block_lock);
 }
 
-int flow_offload_route_init(struct flow_offload *flow,
-			    const struct nf_flow_route *route);
+void flow_offload_route_init(struct flow_offload *flow,
+			     struct nf_flow_route *route);
 
 int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow);
 void flow_offload_refresh(struct nf_flowtable *flow_table,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index fe9fc568b288..08923ed4278f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2233,7 +2233,7 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index d99e89f113c4..3dabdd137d10 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -41,7 +41,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
-	return node->ref;
+	return READ_ONCE(node->ref);
+}
+
+static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
+{
+	WRITE_ONCE(node->ref, 0);
 }
 
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
@@ -89,7 +94,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -110,7 +115,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -353,7 +358,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -419,7 +424,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -522,7 +527,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -568,7 +573,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -594,7 +599,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 6b12f06ee18c..9c12ee453c61 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -63,11 +63,8 @@ struct bpf_lru {
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 {
-	/* ref is an approximation on access frequency.  It does not
-	 * have to be very accurate.  Hence, no protection is used.
-	 */
-	if (!node->ref)
-		node->ref = 1;
+	if (!READ_ONCE(node->ref))
+		WRITE_ONCE(node->ref, 1);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 11e406ad16ae..870127c895c4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -710,19 +710,20 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 /* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
  * arguments representation.
  */
-#define MAX_BPRINTF_BUF_LEN	512
+#define MAX_BPRINTF_BIN_ARGS	512
 
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
 struct bpf_bprintf_buffers {
-	char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
 };
-static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
+
+static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_fmt_tmp_buf(char **tmp_buf)
+static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
-	struct bpf_bprintf_buffers *bufs;
 	int nest_level;
 
 	preempt_disable();
@@ -732,18 +733,19 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 		preempt_enable();
 		return -EBUSY;
 	}
-	bufs = this_cpu_ptr(&bpf_bprintf_bufs);
-	*tmp_buf = bufs->tmp_bufs[nest_level - 1];
+	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
 
 	return 0;
 }
 
-void bpf_bprintf_cleanup(void)
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 {
-	if (this_cpu_read(bpf_bprintf_nest_level)) {
-		this_cpu_dec(bpf_bprintf_nest_level);
-		preempt_enable();
-	}
+	if (!data->bin_args && !data->buf)
+		return;
+	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
+		return;
+	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 /*
@@ -752,18 +754,20 @@ void bpf_bprintf_cleanup(void)
  * Returns a negative value if fmt is an invalid format string or 0 otherwise.
  *
  * This can be used in two ways:
- * - Format string verification only: when bin_args is NULL
+ * - Format string verification only: when data->get_bin_args is false
  * - Arguments preparation: in addition to the above verification, it writes in
- *   bin_args a binary representation of arguments usable by bstr_printf where
- *   pointers from BPF have been sanitized.
+ *   data->bin_args a binary representation of arguments usable by bstr_printf
+ *   where pointers from BPF have been sanitized.
  *
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_args, u32 num_args)
+			u32 num_args, struct bpf_bprintf_data *data)
 {
+	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
+	struct bpf_bprintf_buffers *buffers = NULL;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec = 0;
 	u64 cur_arg;
@@ -774,14 +778,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (bin_args) {
-		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
-			return -EBUSY;
+	if (get_buffers && try_get_buffers(&buffers))
+		return -EBUSY;
 
-		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
-		*bin_args = (u32 *)tmp_buf;
+	if (data->get_bin_args) {
+		if (num_args)
+			tmp_buf = buffers->bin_args;
+		tmp_buf_end = tmp_buf + MAX_BPRINTF_BIN_ARGS;
+		data->bin_args = (u32 *)tmp_buf;
 	}
 
+	if (data->get_buf)
+		data->buf = buffers->buf;
+
 	for (i = 0; i < fmt_size; i++) {
 		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
 			err = -EINVAL;
@@ -975,33 +984,33 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	err = 0;
 out:
 	if (err)
-		bpf_bprintf_cleanup();
+		bpf_bprintf_cleanup(data);
 	return err;
 }
 
-#define MAX_SNPRINTF_VARARGS		12
-
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
-	   const void *, data, u32, data_len)
+	   const void *, args, u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	int err, num_args;
-	u32 *bin_args;
 
-	if (data_len % 8 || data_len > MAX_SNPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	if (data_len % 8 || data_len > MAX_BPRINTF_VARARGS * 8 ||
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
 	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
 	 * can safely give an unbounded size.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, args, num_args, &data);
 	if (err < 0)
 		return err;
 
-	err = bstr_printf(str, str_size, fmt, bin_args);
+	err = bstr_printf(str, str_size, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return err + 1;
 }
@@ -1039,6 +1048,7 @@ struct bpf_hrtimer {
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
+	struct rcu_head rcu;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1260,6 +1270,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
+	rcu_read_lock();
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
 	if (!t) {
@@ -1281,6 +1292,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -1335,7 +1347,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 */
 	if (this_cpu_read(hrtimer_running) != t)
 		hrtimer_cancel(&t->timer);
-	kfree(t);
+	kfree_rcu(t, rcu);
 }
 
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88a468cc0510..f099c5481b66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6407,6 +6407,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
 	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
 	struct bpf_map *fmt_map = fmt_reg->map_ptr;
+	struct bpf_bprintf_data data = {};
 	int err, fmt_map_off, num_args;
 	u64 fmt_addr;
 	char *fmt;
@@ -6431,7 +6432,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
 	 * can focus on validating the format specifiers.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, NULL, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, num_args, &data);
 	if (err < 0)
 		verbose(env, "Invalid format string\n");
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fd8b5656641b..b55d51b4105c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10177,7 +10177,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
-		.dst_grpmask    = sched_group_span(sd->groups),
+		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= sched_nr_migrate_break,
 		.cpus		= cpus,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7045595aacac..5fc99dce5145 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
@@ -2806,9 +2806,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2839,7 +2836,7 @@ int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
@@ -2883,6 +2880,9 @@ int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 928798f89ca1..4554e80c4272 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1821,6 +1821,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -1828,6 +1830,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_deadline_period_max_us",
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ed3c4a954398..2d6cf93ca370 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -140,25 +140,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	int first_free_id = sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret = -ENOENT;
+	unsigned int cnt, id;
 
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt = 0; cnt <= INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id = sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+
+		head = &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret = sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id = 0;
-		if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
-			/* Loop over all possible ids completed */
-			ret = -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret == -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 85a36b19c2b8..a1dc0ff1962e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -360,8 +360,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static DEFINE_RAW_SPINLOCK(trace_printk_lock);
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -369,23 +367,22 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
-	u32 *bin_args;
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+		.get_buf	= true,
+	};
 	int ret;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
-				  MAX_TRACE_PRINTK_VARARGS);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args,
+				  MAX_TRACE_PRINTK_VARARGS, &data);
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
 
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+	trace_bpf_trace_printk(data.buf);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return ret;
 }
@@ -414,26 +411,26 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 	return &bpf_trace_printk_proto;
 }
 
-#define MAX_SEQ_PRINTF_VARARGS		12
-
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
-	   const void *, data, u32, data_len)
+	   const void *, args, u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	int err, num_args;
-	u32 *bin_args;
 
-	if (data_len & 7 || data_len > MAX_SEQ_PRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	err = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
 	if (err < 0)
 		return err;
 
-	seq_bprintf(m, fmt, bin_args);
+	seq_bprintf(m, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 09fddc0ea6d3..3972e2123e55 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -501,6 +501,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index caa13abe0c56..98a9d0ef2d91 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -289,6 +289,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      atomic_t *mmap_changing,
 					      enum mcopy_atomic_mode mode)
 {
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -405,6 +406,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && atomic_read(mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -440,6 +450,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      atomic_t *mmap_changing,
 				      enum mcopy_atomic_mode mode);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -561,7 +572,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, mcopy_mode);
+					       src_start, len, mmap_changing,
+					       mcopy_mode);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 8501645ff67d..af77dc77eb9c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9090,7 +9090,7 @@ EXPORT_SYMBOL(dev_set_mac_address_user);
 
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
-	size_t size = sizeof(sa->sa_data);
+	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
 	int ret = 0;
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 0e87237fd871..6ddfd7bfc512 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -339,7 +339,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
 			return -EINVAL;
 		memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-		       min(sizeof(ifr->ifr_hwaddr.sa_data),
+		       min(sizeof(ifr->ifr_hwaddr.sa_data_min),
 			   (size_t)dev->addr_len));
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 		return 0;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index db76c55e1a6d..7113ae79f522 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -9055,7 +9055,10 @@ EXPORT_SYMBOL_GPL(devlink_free);
 
 static void devlink_port_type_warn(struct work_struct *work)
 {
-	WARN(true, "Type was not set for devlink port.");
+	struct devlink_port *port = container_of(to_delayed_work(work),
+						 struct devlink_port,
+						 type_warn_dw);
+	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 83a47998c4b1..8ae9bd6f91c1 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1104,7 +1104,8 @@ static int arp_req_get(struct arpreq *r, struct net_device *dev)
 	if (neigh) {
 		if (!(neigh->nud_state & NUD_NOARP)) {
 			read_lock_bh(&neigh->lock);
-			memcpy(r->arp_ha.sa_data, neigh->ha, dev->addr_len);
+			memcpy(r->arp_ha.sa_data, neigh->ha,
+			       min(dev->addr_len, (unsigned char)sizeof(r->arp_ha.sa_data_min)));
 			r->arp_flags = arp_state_to_flags(neigh);
 			read_unlock_bh(&neigh->lock);
 			r->arp_ha.sa_family = dev->type;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c511751c2f41..425dfa8e4fd0 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1797,6 +1797,21 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
 	return err;
 }
 
+/* Combine dev_addr_genid and dev_base_seq to detect changes.
+ */
+static u32 inet_base_seq(const struct net *net)
+{
+	u32 res = atomic_read(&net->ipv4.dev_addr_genid) +
+		  net->dev_base_seq;
+
+	/* Must not return 0 (see nl_dump_check_consistent()).
+	 * Chose a value far away from 0.
+	 */
+	if (!res)
+		res = 0x80000000;
+	return res;
+}
+
 static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
@@ -1848,8 +1863,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&tgt_net->ipv4.dev_addr_genid) ^
-			  tgt_net->dev_base_seq;
+		cb->seq = inet_base_seq(tgt_net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -2250,8 +2264,7 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv4.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 1e4eedf7f212..c52317184e3e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -707,6 +707,22 @@ static int inet6_netconf_get_devconf(struct sk_buff *in_skb,
 	return err;
 }
 
+/* Combine dev_addr_genid and dev_base_seq to detect changes.
+ */
+static u32 inet6_base_seq(const struct net *net)
+{
+	u32 res = atomic_read(&net->ipv6.dev_addr_genid) +
+		  net->dev_base_seq;
+
+	/* Must not return 0 (see nl_dump_check_consistent()).
+	 * Chose a value far away from 0.
+	 */
+	if (!res)
+		res = 0x80000000;
+	return res;
+}
+
+
 static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 				      struct netlink_callback *cb)
 {
@@ -740,8 +756,7 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv6.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet6_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -5316,7 +5331,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	}
 
 	rcu_read_lock();
-	cb->seq = atomic_read(&tgt_net->ipv6.dev_addr_genid) ^ tgt_net->dev_base_seq;
+	cb->seq = inet6_base_seq(tgt_net);
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 0c7c6fc16c3c..dc434e4ee6d6 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -507,22 +507,24 @@ int __init seg6_init(void)
 {
 	int err;
 
-	err = genl_register_family(&seg6_genl_family);
+	err = register_pernet_subsys(&ip6_segments_ops);
 	if (err)
 		goto out;
 
-	err = register_pernet_subsys(&ip6_segments_ops);
+	err = genl_register_family(&seg6_genl_family);
 	if (err)
-		goto out_unregister_genl;
+		goto out_unregister_pernet;
 
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	err = seg6_iptunnel_init();
 	if (err)
-		goto out_unregister_pernet;
+		goto out_unregister_genl;
 
 	err = seg6_local_init();
-	if (err)
-		goto out_unregister_pernet;
+	if (err) {
+		seg6_iptunnel_exit();
+		goto out_unregister_genl;
+	}
 #endif
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
@@ -543,11 +545,11 @@ int __init seg6_init(void)
 #endif
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
-out_unregister_pernet:
-	unregister_pernet_subsys(&ip6_segments_ops);
-#endif
 out_unregister_genl:
 	genl_unregister_family(&seg6_genl_family);
+#endif
+out_unregister_pernet:
+	unregister_pernet_subsys(&ip6_segments_ops);
 	goto out;
 }
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 9746c624a550..eb3d81bcce6d 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -628,7 +628,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
-	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
+	ulen = len + (skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0);
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cc6d38a2e6d5..5da0c2a2e293 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5923,6 +5923,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e10bcfa20526..f4deee1926e5 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -696,6 +696,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 481b6b34797d..c4e6fbe4343e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2965,7 +2965,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index a536586742f2..e57c5f47f035 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -13,17 +13,19 @@
 #include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
-static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
 	u32 flags = 0;
+	bool slow;
 	int err;
 
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
 
+	slow = lock_sock_fast(sk);
 	rcu_read_lock();
 	sf = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
 	if (!sf) {
@@ -69,11 +71,13 @@ static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
 	}
 
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_end(skb, start);
 	return 0;
 
 nla_failure:
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_cancel(skb, start);
 	return err;
 }
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index c94a9971d790..7ffd698497f2 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -299,7 +299,7 @@ sctp_new(struct nf_conn *ct, const struct sk_buff *skb,
 			pr_debug("Setting vtag %x for secondary conntrack\n",
 				 sh->vtag);
 			ct->proto.sctp.vtag[IP_CT_DIR_ORIGINAL] = sh->vtag;
-		} else {
+		} else if (sch->type == SCTP_CID_SHUTDOWN_ACK) {
 		/* If it is a shutdown ack OOTB packet, we expect a return
 		   shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8) */
 			pr_debug("Setting vtag %x for new conn OOTB\n",
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 4f61eb128283..e78cdd73ef62 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -86,12 +86,22 @@ static u32 flow_offload_dst_cookie(struct flow_offload_tuple *flow_tuple)
 	return 0;
 }
 
+static struct dst_entry *nft_route_dst_fetch(struct nf_flow_route *route,
+					     enum flow_offload_tuple_dir dir)
+{
+	struct dst_entry *dst = route->tuple[dir].dst;
+
+	route->tuple[dir].dst = NULL;
+
+	return dst;
+}
+
 static int flow_offload_fill_route(struct flow_offload *flow,
-				   const struct nf_flow_route *route,
+				   struct nf_flow_route *route,
 				   enum flow_offload_tuple_dir dir)
 {
 	struct flow_offload_tuple *flow_tuple = &flow->tuplehash[dir].tuple;
-	struct dst_entry *dst = route->tuple[dir].dst;
+	struct dst_entry *dst = nft_route_dst_fetch(route, dir);
 	int i, j = 0;
 
 	switch (flow_tuple->l3proto) {
@@ -121,12 +131,10 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
 		flow_tuple->out.hw_ifidx = route->tuple[dir].out.hw_ifindex;
+		dst_release(dst);
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-		if (!dst_hold_safe(route->tuple[dir].dst))
-			return -1;
-
 		flow_tuple->dst_cache = dst;
 		flow_tuple->dst_cookie = flow_offload_dst_cookie(flow_tuple);
 		break;
@@ -147,27 +155,12 @@ static void nft_flow_dst_release(struct flow_offload *flow,
 		dst_release(flow->tuplehash[dir].tuple.dst_cache);
 }
 
-int flow_offload_route_init(struct flow_offload *flow,
-			    const struct nf_flow_route *route)
+void flow_offload_route_init(struct flow_offload *flow,
+			     struct nf_flow_route *route)
 {
-	int err;
-
-	err = flow_offload_fill_route(flow, route, FLOW_OFFLOAD_DIR_ORIGINAL);
-	if (err < 0)
-		return err;
-
-	err = flow_offload_fill_route(flow, route, FLOW_OFFLOAD_DIR_REPLY);
-	if (err < 0)
-		goto err_route_reply;
-
+	flow_offload_fill_route(flow, route, FLOW_OFFLOAD_DIR_ORIGINAL);
+	flow_offload_fill_route(flow, route, FLOW_OFFLOAD_DIR_REPLY);
 	flow->type = NF_FLOW_OFFLOAD_ROUTE;
-
-	return 0;
-
-err_route_reply:
-	nft_flow_dst_release(flow, FLOW_OFFLOAD_DIR_ORIGINAL);
-
-	return err;
 }
 EXPORT_SYMBOL_GPL(flow_offload_route_init);
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3ad2b22886ff..40a831150cd8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1193,6 +1193,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	return 0;
 
 err_register_hooks:
+	ctx->table->flags |= NFT_TABLE_F_DORMANT;
 	nft_trans_destroy(trans);
 	return ret;
 }
@@ -3465,6 +3466,8 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 		err = nft_chain_validate(&ctx, chain);
 		if (err < 0)
 			return err;
+
+		cond_resched();
 	}
 
 	return 0;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index f8346497c9b4..fbb9f3a6c844 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -240,9 +240,14 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		break;
 	}
 
+	if (!dst_hold_safe(this_dst))
+		return -ENOENT;
+
 	nf_route(nft_net(pkt), &other_dst, &fl, false, nft_pf(pkt));
-	if (!other_dst)
+	if (!other_dst) {
+		dst_release(this_dst);
 		return -ENOENT;
+	}
 
 	nft_default_forward_path(route, this_dst, dir);
 	nft_default_forward_path(route, other_dst, !dir);
@@ -326,8 +331,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (!flow)
 		goto err_flow_alloc;
 
-	if (flow_offload_route_init(flow, &route) < 0)
-		goto err_flow_add;
+	flow_offload_route_init(flow, &route);
 
 	if (tcph) {
 		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
@@ -338,12 +342,12 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (ret < 0)
 		goto err_flow_add;
 
-	dst_release(route.tuple[!dir].dst);
 	return;
 
 err_flow_add:
 	flow_offload_free(flow);
 err_flow_alloc:
+	dst_release(route.tuple[dir].dst);
 	dst_release(route.tuple[!dir].dst);
 err_flow_route:
 	clear_bit(IPS_OFFLOAD_BIT, &ct->status);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e7b54f721411..75fb80717e48 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1874,7 +1874,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 	 */
 
 	spkt->spkt_family = dev->type;
-	strlcpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
+	strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
 	spkt->spkt_protocol = skb->protocol;
 
 	/*
@@ -3252,7 +3252,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 			    int addr_len)
 {
 	struct sock *sk = sock->sk;
-	char name[sizeof(uaddr->sa_data) + 1];
+	char name[sizeof(uaddr->sa_data_min) + 1];
 
 	/*
 	 *	Check legality
@@ -3263,8 +3263,8 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 	/* uaddr->sa_data comes from the userspace, it's not guaranteed to be
 	 * zero-terminated.
 	 */
-	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data));
-	name[sizeof(uaddr->sa_data)] = 0;
+	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data_min));
+	name[sizeof(uaddr->sa_data_min)] = 0;
 
 	return packet_do_bind(sk, name, 0, 0);
 }
@@ -3536,11 +3536,11 @@ static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
 		return -EOPNOTSUPP;
 
 	uaddr->sa_family = AF_PACKET;
-	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
+	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data_min));
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
 	if (dev)
-		strlcpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
+		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data_min));
 	rcu_read_unlock();
 
 	return sizeof(*uaddr);
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 24cf0bf7c80e..9c4a80fce794 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -45,23 +45,6 @@ if NET_SCHED
 
 comment "Queueing/Scheduling"
 
-config NET_SCH_CBQ
-	tristate "Class Based Queueing (CBQ)"
-	help
-	  Say Y here if you want to use the Class-Based Queueing (CBQ) packet
-	  scheduling algorithm. This algorithm classifies the waiting packets
-	  into a tree-like hierarchy of classes; the leaves of this tree are
-	  in turn scheduled by separate algorithms.
-
-	  See the top of <file:net/sched/sch_cbq.c> for more details.
-
-	  CBQ is a commonly used scheduler, so if you're unsure, you should
-	  say Y here. Then say Y to all the queueing algorithms below that you
-	  want to use as leaf disciplines.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_cbq.
-
 config NET_SCH_HTB
 	tristate "Hierarchical Token Bucket (HTB)"
 	help
@@ -85,20 +68,6 @@ config NET_SCH_HFSC
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_hfsc.
 
-config NET_SCH_ATM
-	tristate "ATM Virtual Circuits (ATM)"
-	depends on ATM
-	help
-	  Say Y here if you want to use the ATM pseudo-scheduler.  This
-	  provides a framework for invoking classifiers, which in turn
-	  select classes of this queuing discipline.  Each class maps
-	  the flow(s) it is handling to a given virtual circuit.
-
-	  See the top of <file:net/sched/sch_atm.c> for more details.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_atm.
-
 config NET_SCH_PRIO
 	tristate "Multi Band Priority Queueing (PRIO)"
 	help
@@ -217,17 +186,6 @@ config NET_SCH_GRED
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_gred.
 
-config NET_SCH_DSMARK
-	tristate "Differentiated Services marker (DSMARK)"
-	help
-	  Say Y if you want to schedule packets according to the
-	  Differentiated Services architecture proposed in RFC 2475.
-	  Technical information on this method, with pointers to associated
-	  RFCs, is available at <http://www.gta.ufrj.br/diffserv/>.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_dsmark.
-
 config NET_SCH_NETEM
 	tristate "Network emulator (NETEM)"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 8a33a35fc50d..a66ac1e7b79b 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -33,20 +33,17 @@ obj-$(CONFIG_NET_ACT_TUNNEL_KEY)+= act_tunnel_key.o
 obj-$(CONFIG_NET_ACT_CT)	+= act_ct.o
 obj-$(CONFIG_NET_ACT_GATE)	+= act_gate.o
 obj-$(CONFIG_NET_SCH_FIFO)	+= sch_fifo.o
-obj-$(CONFIG_NET_SCH_CBQ)	+= sch_cbq.o
 obj-$(CONFIG_NET_SCH_HTB)	+= sch_htb.o
 obj-$(CONFIG_NET_SCH_HFSC)	+= sch_hfsc.o
 obj-$(CONFIG_NET_SCH_RED)	+= sch_red.o
 obj-$(CONFIG_NET_SCH_GRED)	+= sch_gred.o
 obj-$(CONFIG_NET_SCH_INGRESS)	+= sch_ingress.o
-obj-$(CONFIG_NET_SCH_DSMARK)	+= sch_dsmark.o
 obj-$(CONFIG_NET_SCH_SFB)	+= sch_sfb.o
 obj-$(CONFIG_NET_SCH_SFQ)	+= sch_sfq.o
 obj-$(CONFIG_NET_SCH_TBF)	+= sch_tbf.o
 obj-$(CONFIG_NET_SCH_TEQL)	+= sch_teql.o
 obj-$(CONFIG_NET_SCH_PRIO)	+= sch_prio.o
 obj-$(CONFIG_NET_SCH_MULTIQ)	+= sch_multiq.o
-obj-$(CONFIG_NET_SCH_ATM)	+= sch_atm.o
 obj-$(CONFIG_NET_SCH_NETEM)	+= sch_netem.o
 obj-$(CONFIG_NET_SCH_DRR)	+= sch_drr.o
 obj-$(CONFIG_NET_SCH_PLUG)	+= sch_plug.o
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index fa79dbd3601f..7fdc2c1f8756 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1044,12 +1044,12 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 	if (parent == NULL) {
 		unsigned int i, num_q, ingress;
+		struct netdev_queue *dev_queue;
 
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
 		    (new && new->flags & TCQ_F_INGRESS)) {
-			num_q = 1;
 			ingress = 1;
 			if (!dev_ingress_queue(dev)) {
 				NL_SET_ERR_MSG(extack, "Device does not have an ingress queue");
@@ -1065,18 +1065,18 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		if (new && new->ops->attach && !ingress)
 			goto skip;
 
-		for (i = 0; i < num_q; i++) {
-			struct netdev_queue *dev_queue = dev_ingress_queue(dev);
-
-			if (!ingress)
+		if (!ingress) {
+			for (i = 0; i < num_q; i++) {
 				dev_queue = netdev_get_tx_queue(dev, i);
+				old = dev_graft_qdisc(dev_queue, new);
 
-			old = dev_graft_qdisc(dev_queue, new);
-			if (new && i > 0)
-				qdisc_refcount_inc(new);
-
-			if (!ingress)
+				if (new && i > 0)
+					qdisc_refcount_inc(new);
 				qdisc_put(old);
+			}
+		} else {
+			dev_queue = dev_ingress_queue(dev);
+			old = dev_graft_qdisc(dev_queue, new);
 		}
 
 skip:
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
deleted file mode 100644
index 33737169cc2d..000000000000
--- a/net/sched/sch_atm.c
+++ /dev/null
@@ -1,710 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* net/sched/sch_atm.c - ATM VC selection "queueing discipline" */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/atmdev.h>
-#include <linux/atmclip.h>
-#include <linux/rtnetlink.h>
-#include <linux/file.h>		/* for fput */
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-/*
- * The ATM queuing discipline provides a framework for invoking classifiers
- * (aka "filters"), which in turn select classes of this queuing discipline.
- * Each class maps the flow(s) it is handling to a given VC. Multiple classes
- * may share the same VC.
- *
- * When creating a class, VCs are specified by passing the number of the open
- * socket descriptor by which the calling process references the VC. The kernel
- * keeps the VC open at least until all classes using it are removed.
- *
- * In this file, most functions are named atm_tc_* to avoid confusion with all
- * the atm_* in net/atm. This naming convention differs from what's used in the
- * rest of net/sched.
- *
- * Known bugs:
- *  - sometimes messes up the IP stack
- *  - any manipulations besides the few operations described in the README, are
- *    untested and likely to crash the system
- *  - should lock the flow while there is data in the queue (?)
- */
-
-#define VCC2FLOW(vcc) ((struct atm_flow_data *) ((vcc)->user_back))
-
-struct atm_flow_data {
-	struct Qdisc_class_common common;
-	struct Qdisc		*q;	/* FIFO, TBF, etc. */
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct atm_vcc		*vcc;	/* VCC; NULL if VCC is closed */
-	void			(*old_pop)(struct atm_vcc *vcc,
-					   struct sk_buff *skb); /* chaining */
-	struct atm_qdisc_data	*parent;	/* parent qdisc */
-	struct socket		*sock;		/* for closing */
-	int			ref;		/* reference count */
-	struct gnet_stats_basic_packed	bstats;
-	struct gnet_stats_queue	qstats;
-	struct list_head	list;
-	struct atm_flow_data	*excess;	/* flow for excess traffic;
-						   NULL to set CLP instead */
-	int			hdr_len;
-	unsigned char		hdr[];		/* header data; MUST BE LAST */
-};
-
-struct atm_qdisc_data {
-	struct atm_flow_data	link;		/* unclassified skbs go here */
-	struct list_head	flows;		/* NB: "link" is also on this
-						   list */
-	struct tasklet_struct	task;		/* dequeue tasklet */
-};
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static inline struct atm_flow_data *lookup_flow(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow->common.classid == classid)
-			return flow;
-	}
-	return NULL;
-}
-
-static int atm_tc_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_graft(sch %p,[qdisc %p],flow %p,new %p,old %p)\n",
-		sch, p, flow, new, old);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (!new)
-		new = &noop_qdisc;
-	*old = flow->q;
-	flow->q = new;
-	if (*old)
-		qdisc_reset(*old);
-	return 0;
-}
-
-static struct Qdisc *atm_tc_leaf(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_leaf(sch %p,flow %p)\n", sch, flow);
-	return flow ? flow->q : NULL;
-}
-
-static unsigned long atm_tc_find(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-static unsigned long atm_tc_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	if (flow)
-		flow->ref++;
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-/*
- * atm_tc_put handles all destructions, including the ones that are explicitly
- * requested (atm_tc_destroy, etc.). The assumption here is that we never drop
- * anything that still seems to be in use.
- */
-static void atm_tc_put(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_put(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (--flow->ref)
-		return;
-	pr_debug("atm_tc_put: destroying\n");
-	list_del_init(&flow->list);
-	pr_debug("atm_tc_put: qdisc %p\n", flow->q);
-	qdisc_put(flow->q);
-	tcf_block_put(flow->block);
-	if (flow->sock) {
-		pr_debug("atm_tc_put: f_count %ld\n",
-			file_count(flow->sock->file));
-		flow->vcc->pop = flow->old_pop;
-		sockfd_put(flow->sock);
-	}
-	if (flow->excess)
-		atm_tc_put(sch, (unsigned long)flow->excess);
-	if (flow != &p->link)
-		kfree(flow);
-	/*
-	 * If flow == &p->link, the qdisc no longer works at this point and
-	 * needs to be removed. (By the caller of atm_tc_put.)
-	 */
-}
-
-static void sch_atm_pop(struct atm_vcc *vcc, struct sk_buff *skb)
-{
-	struct atm_qdisc_data *p = VCC2FLOW(vcc)->parent;
-
-	pr_debug("sch_atm_pop(vcc %p,skb %p,[qdisc %p])\n", vcc, skb, p);
-	VCC2FLOW(vcc)->old_pop(vcc, skb);
-	tasklet_schedule(&p->task);
-}
-
-static const u8 llc_oui_ip[] = {
-	0xaa,			/* DSAP: non-ISO */
-	0xaa,			/* SSAP: non-ISO */
-	0x03,			/* Ctrl: Unnumbered Information Command PDU */
-	0x00,			/* OUI: EtherType */
-	0x00, 0x00,
-	0x08, 0x00
-};				/* Ethertype IP (0800) */
-
-static const struct nla_policy atm_policy[TCA_ATM_MAX + 1] = {
-	[TCA_ATM_FD]		= { .type = NLA_U32 },
-	[TCA_ATM_EXCESS]	= { .type = NLA_U32 },
-};
-
-static int atm_tc_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)*arg;
-	struct atm_flow_data *excess = NULL;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_ATM_MAX + 1];
-	struct socket *sock;
-	int fd, error, hdr_len;
-	void *hdr;
-
-	pr_debug("atm_tc_change(sch %p,[qdisc %p],classid %x,parent %x,"
-		"flow %p,opt %p)\n", sch, p, classid, parent, flow, opt);
-	/*
-	 * The concept of parents doesn't apply for this qdisc.
-	 */
-	if (parent && parent != TC_H_ROOT && parent != sch->handle)
-		return -EINVAL;
-	/*
-	 * ATM classes cannot be changed. In order to change properties of the
-	 * ATM connection, that socket needs to be modified directly (via the
-	 * native ATM API. In order to send a flow to a different VC, the old
-	 * class needs to be removed and a new one added. (This may be changed
-	 * later.)
-	 */
-	if (flow)
-		return -EBUSY;
-	if (opt == NULL)
-		return -EINVAL;
-
-	error = nla_parse_nested_deprecated(tb, TCA_ATM_MAX, opt, atm_policy,
-					    NULL);
-	if (error < 0)
-		return error;
-
-	if (!tb[TCA_ATM_FD])
-		return -EINVAL;
-	fd = nla_get_u32(tb[TCA_ATM_FD]);
-	pr_debug("atm_tc_change: fd %d\n", fd);
-	if (tb[TCA_ATM_HDR]) {
-		hdr_len = nla_len(tb[TCA_ATM_HDR]);
-		hdr = nla_data(tb[TCA_ATM_HDR]);
-	} else {
-		hdr_len = RFC1483LLC_LEN;
-		hdr = NULL;	/* default LLC/SNAP for IP */
-	}
-	if (!tb[TCA_ATM_EXCESS])
-		excess = NULL;
-	else {
-		excess = (struct atm_flow_data *)
-			atm_tc_find(sch, nla_get_u32(tb[TCA_ATM_EXCESS]));
-		if (!excess)
-			return -ENOENT;
-	}
-	pr_debug("atm_tc_change: type %d, payload %d, hdr_len %d\n",
-		 opt->nla_type, nla_len(opt), hdr_len);
-	sock = sockfd_lookup(fd, &error);
-	if (!sock)
-		return error;	/* f_count++ */
-	pr_debug("atm_tc_change: f_count %ld\n", file_count(sock->file));
-	if (sock->ops->family != PF_ATMSVC && sock->ops->family != PF_ATMPVC) {
-		error = -EPROTOTYPE;
-		goto err_out;
-	}
-	/* @@@ should check if the socket is really operational or we'll crash
-	   on vcc->send */
-	if (classid) {
-		if (TC_H_MAJ(classid ^ sch->handle)) {
-			pr_debug("atm_tc_change: classid mismatch\n");
-			error = -EINVAL;
-			goto err_out;
-		}
-	} else {
-		int i;
-		unsigned long cl;
-
-		for (i = 1; i < 0x8000; i++) {
-			classid = TC_H_MAKE(sch->handle, 0x8000 | i);
-			cl = atm_tc_find(sch, classid);
-			if (!cl)
-				break;
-		}
-	}
-	pr_debug("atm_tc_change: new id %x\n", classid);
-	flow = kzalloc(sizeof(struct atm_flow_data) + hdr_len, GFP_KERNEL);
-	pr_debug("atm_tc_change: flow %p\n", flow);
-	if (!flow) {
-		error = -ENOBUFS;
-		goto err_out;
-	}
-
-	error = tcf_block_get(&flow->block, &flow->filter_list, sch,
-			      extack);
-	if (error) {
-		kfree(flow);
-		goto err_out;
-	}
-
-	flow->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				    extack);
-	if (!flow->q)
-		flow->q = &noop_qdisc;
-	pr_debug("atm_tc_change: qdisc %p\n", flow->q);
-	flow->sock = sock;
-	flow->vcc = ATM_SD(sock);	/* speedup */
-	flow->vcc->user_back = flow;
-	pr_debug("atm_tc_change: vcc %p\n", flow->vcc);
-	flow->old_pop = flow->vcc->pop;
-	flow->parent = p;
-	flow->vcc->pop = sch_atm_pop;
-	flow->common.classid = classid;
-	flow->ref = 1;
-	flow->excess = excess;
-	list_add(&flow->list, &p->link.list);
-	flow->hdr_len = hdr_len;
-	if (hdr)
-		memcpy(flow->hdr, hdr, hdr_len);
-	else
-		memcpy(flow->hdr, llc_oui_ip, sizeof(llc_oui_ip));
-	*arg = (unsigned long)flow;
-	return 0;
-err_out:
-	sockfd_put(sock);
-	return error;
-}
-
-static int atm_tc_delete(struct Qdisc *sch, unsigned long arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_delete(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (rcu_access_pointer(flow->filter_list) || flow == &p->link)
-		return -EBUSY;
-	/*
-	 * Reference count must be 2: one for "keepalive" (set at class
-	 * creation), and one for the reference held when calling delete.
-	 */
-	if (flow->ref < 2) {
-		pr_err("atm_tc_delete: flow->ref == %d\n", flow->ref);
-		return -EINVAL;
-	}
-	if (flow->ref > 2)
-		return -EBUSY;	/* catch references via excess, etc. */
-	atm_tc_put(sch, arg);
-	return 0;
-}
-
-static void atm_tc_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_walk(sch %p,[qdisc %p],walker %p)\n", sch, p, walker);
-	if (walker->stop)
-		return;
-	list_for_each_entry(flow, &p->flows, list) {
-		if (walker->count >= walker->skip &&
-		    walker->fn(sch, (unsigned long)flow, walker) < 0) {
-			walker->stop = 1;
-			break;
-		}
-		walker->count++;
-	}
-}
-
-static struct tcf_block *atm_tc_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_find_tcf(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	return flow ? flow->block : p->link.block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int atm_tc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-	struct tcf_result res;
-	int result;
-	int ret = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-
-	pr_debug("atm_tc_enqueue(skb %p,sch %p,[qdisc %p])\n", skb, sch, p);
-	result = TC_ACT_OK;	/* be nice to gcc */
-	flow = NULL;
-	if (TC_H_MAJ(skb->priority) != sch->handle ||
-	    !(flow = (struct atm_flow_data *)atm_tc_find(sch, skb->priority))) {
-		struct tcf_proto *fl;
-
-		list_for_each_entry(flow, &p->flows, list) {
-			fl = rcu_dereference_bh(flow->filter_list);
-			if (fl) {
-				result = tcf_classify(skb, NULL, fl, &res, true);
-				if (result < 0)
-					continue;
-				if (result == TC_ACT_SHOT)
-					goto done;
-
-				flow = (struct atm_flow_data *)res.class;
-				if (!flow)
-					flow = lookup_flow(sch, res.classid);
-				goto drop;
-			}
-		}
-		flow = NULL;
-done:
-		;
-	}
-	if (!flow) {
-		flow = &p->link;
-	} else {
-		if (flow->vcc)
-			ATM_SKB(skb)->atm_options = flow->vcc->atm_options;
-		/*@@@ looks good ... but it's not supposed to work :-) */
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-		case TC_ACT_SHOT:
-			__qdisc_drop(skb, to_free);
-			goto drop;
-		case TC_ACT_RECLASSIFY:
-			if (flow->excess)
-				flow = flow->excess;
-			else
-				ATM_SKB(skb)->atm_options |= ATM_ATMOPT_CLP;
-			break;
-		}
-#endif
-	}
-
-	ret = qdisc_enqueue(skb, flow->q, to_free);
-	if (ret != NET_XMIT_SUCCESS) {
-drop: __maybe_unused
-		if (net_xmit_drop_count(ret)) {
-			qdisc_qstats_drop(sch);
-			if (flow)
-				flow->qstats.drops++;
-		}
-		return ret;
-	}
-	/*
-	 * Okay, this may seem weird. We pretend we've dropped the packet if
-	 * it goes via ATM. The reason for this is that the outer qdisc
-	 * expects to be able to q->dequeue the packet later on if we return
-	 * success at this place. Also, sch->q.qdisc needs to reflect whether
-	 * there is a packet egligible for dequeuing or not. Note that the
-	 * statistics of the outer qdisc are necessarily wrong because of all
-	 * this. There's currently no correct solution for this.
-	 */
-	if (flow == &p->link) {
-		sch->q.qlen++;
-		return NET_XMIT_SUCCESS;
-	}
-	tasklet_schedule(&p->task);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-/*
- * Dequeue packets and send them over ATM. Note that we quite deliberately
- * avoid checking net_device's flow control here, simply because sch_atm
- * uses its own channels, which have nothing to do with any CLIP/LANE/or
- * non-ATM interfaces.
- */
-
-static void sch_atm_dequeue(struct tasklet_struct *t)
-{
-	struct atm_qdisc_data *p = from_tasklet(p, t, task);
-	struct Qdisc *sch = qdisc_from_priv(p);
-	struct atm_flow_data *flow;
-	struct sk_buff *skb;
-
-	pr_debug("sch_atm_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow == &p->link)
-			continue;
-		/*
-		 * If traffic is properly shaped, this won't generate nasty
-		 * little bursts. Otherwise, it may ... (but that's okay)
-		 */
-		while ((skb = flow->q->ops->peek(flow->q))) {
-			if (!atm_may_send(flow->vcc, skb->truesize))
-				break;
-
-			skb = qdisc_dequeue_peeked(flow->q);
-			if (unlikely(!skb))
-				break;
-
-			qdisc_bstats_update(sch, skb);
-			bstats_update(&flow->bstats, skb);
-			pr_debug("atm_tc_dequeue: sending on class %p\n", flow);
-			/* remove any LL header somebody else has attached */
-			skb_pull(skb, skb_network_offset(skb));
-			if (skb_headroom(skb) < flow->hdr_len) {
-				struct sk_buff *new;
-
-				new = skb_realloc_headroom(skb, flow->hdr_len);
-				dev_kfree_skb(skb);
-				if (!new)
-					continue;
-				skb = new;
-			}
-			pr_debug("sch_atm_dequeue: ip %p, data %p\n",
-				 skb_network_header(skb), skb->data);
-			ATM_SKB(skb)->vcc = flow->vcc;
-			memcpy(skb_push(skb, flow->hdr_len), flow->hdr,
-			       flow->hdr_len);
-			refcount_add(skb->truesize,
-				   &sk_atm(flow->vcc)->sk_wmem_alloc);
-			/* atm.atm_options are already set by atm_tc_enqueue */
-			flow->vcc->send(flow->vcc, skb);
-		}
-	}
-}
-
-static struct sk_buff *atm_tc_dequeue(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-
-	pr_debug("atm_tc_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	tasklet_schedule(&p->task);
-	skb = qdisc_dequeue_peeked(p->link.q);
-	if (skb)
-		sch->q.qlen--;
-	return skb;
-}
-
-static struct sk_buff *atm_tc_peek(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("atm_tc_peek(sch %p,[qdisc %p])\n", sch, p);
-
-	return p->link.q->ops->peek(p->link.q);
-}
-
-static int atm_tc_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("atm_tc_init(sch %p,[qdisc %p],opt %p)\n", sch, p, opt);
-	INIT_LIST_HEAD(&p->flows);
-	INIT_LIST_HEAD(&p->link.list);
-	list_add(&p->link.list, &p->flows);
-	p->link.q = qdisc_create_dflt(sch->dev_queue,
-				      &pfifo_qdisc_ops, sch->handle, extack);
-	if (!p->link.q)
-		p->link.q = &noop_qdisc;
-	pr_debug("atm_tc_init: link (%p) qdisc %p\n", &p->link, p->link.q);
-	p->link.vcc = NULL;
-	p->link.sock = NULL;
-	p->link.common.classid = sch->handle;
-	p->link.ref = 1;
-
-	err = tcf_block_get(&p->link.block, &p->link.filter_list, sch,
-			    extack);
-	if (err)
-		return err;
-
-	tasklet_setup(&p->task, sch_atm_dequeue);
-	return 0;
-}
-
-static void atm_tc_reset(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_reset(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list)
-		qdisc_reset(flow->q);
-}
-
-static void atm_tc_destroy(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow, *tmp;
-
-	pr_debug("atm_tc_destroy(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		tcf_block_put(flow->block);
-		flow->block = NULL;
-	}
-
-	list_for_each_entry_safe(flow, tmp, &p->flows, list) {
-		if (flow->ref > 1)
-			pr_err("atm_destroy: %p->ref = %d\n", flow, flow->ref);
-		atm_tc_put(sch, (unsigned long)flow);
-	}
-	tasklet_kill(&p->task);
-}
-
-static int atm_tc_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-	struct nlattr *nest;
-
-	pr_debug("atm_tc_dump_class(sch %p,[qdisc %p],flow %p,skb %p,tcm %p)\n",
-		sch, p, flow, skb, tcm);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	tcm->tcm_handle = flow->common.classid;
-	tcm->tcm_info = flow->q->handle;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-
-	if (nla_put(skb, TCA_ATM_HDR, flow->hdr_len, flow->hdr))
-		goto nla_put_failure;
-	if (flow->vcc) {
-		struct sockaddr_atmpvc pvc;
-		int state;
-
-		memset(&pvc, 0, sizeof(pvc));
-		pvc.sap_family = AF_ATMPVC;
-		pvc.sap_addr.itf = flow->vcc->dev ? flow->vcc->dev->number : -1;
-		pvc.sap_addr.vpi = flow->vcc->vpi;
-		pvc.sap_addr.vci = flow->vcc->vci;
-		if (nla_put(skb, TCA_ATM_ADDR, sizeof(pvc), &pvc))
-			goto nla_put_failure;
-		state = ATM_VF2VS(flow->vcc->flags);
-		if (nla_put_u32(skb, TCA_ATM_STATE, state))
-			goto nla_put_failure;
-	}
-	if (flow->excess) {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, flow->common.classid))
-			goto nla_put_failure;
-	} else {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, 0))
-			goto nla_put_failure;
-	}
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-static int
-atm_tc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-			struct gnet_dump *d)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &flow->bstats) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &flow->qstats, flow->q->q.qlen) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int atm_tc_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static const struct Qdisc_class_ops atm_class_ops = {
-	.graft		= atm_tc_graft,
-	.leaf		= atm_tc_leaf,
-	.find		= atm_tc_find,
-	.change		= atm_tc_change,
-	.delete		= atm_tc_delete,
-	.walk		= atm_tc_walk,
-	.tcf_block	= atm_tc_tcf_block,
-	.bind_tcf	= atm_tc_bind_filter,
-	.unbind_tcf	= atm_tc_put,
-	.dump		= atm_tc_dump_class,
-	.dump_stats	= atm_tc_dump_class_stats,
-};
-
-static struct Qdisc_ops atm_qdisc_ops __read_mostly = {
-	.cl_ops		= &atm_class_ops,
-	.id		= "atm",
-	.priv_size	= sizeof(struct atm_qdisc_data),
-	.enqueue	= atm_tc_enqueue,
-	.dequeue	= atm_tc_dequeue,
-	.peek		= atm_tc_peek,
-	.init		= atm_tc_init,
-	.reset		= atm_tc_reset,
-	.destroy	= atm_tc_destroy,
-	.dump		= atm_tc_dump,
-	.owner		= THIS_MODULE,
-};
-
-static int __init atm_init(void)
-{
-	return register_qdisc(&atm_qdisc_ops);
-}
-
-static void __exit atm_exit(void)
-{
-	unregister_qdisc(&atm_qdisc_ops);
-}
-
-module_init(atm_init)
-module_exit(atm_exit)
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
deleted file mode 100644
index 46b3dd71777d..000000000000
--- a/net/sched/sch_cbq.c
+++ /dev/null
@@ -1,1817 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * net/sched/sch_cbq.c	Class-Based Queueing discipline.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-
-/*	Class-Based Queueing (CBQ) algorithm.
-	=======================================
-
-	Sources: [1] Sally Floyd and Van Jacobson, "Link-sharing and Resource
-		 Management Models for Packet Networks",
-		 IEEE/ACM Transactions on Networking, Vol.3, No.4, 1995
-
-		 [2] Sally Floyd, "Notes on CBQ and Guaranteed Service", 1995
-
-		 [3] Sally Floyd, "Notes on Class-Based Queueing: Setting
-		 Parameters", 1996
-
-		 [4] Sally Floyd and Michael Speer, "Experimental Results
-		 for Class-Based Queueing", 1998, not published.
-
-	-----------------------------------------------------------------------
-
-	Algorithm skeleton was taken from NS simulator cbq.cc.
-	If someone wants to check this code against the LBL version,
-	he should take into account that ONLY the skeleton was borrowed,
-	the implementation is different. Particularly:
-
-	--- The WRR algorithm is different. Our version looks more
-	reasonable (I hope) and works when quanta are allowed to be
-	less than MTU, which is always the case when real time classes
-	have small rates. Note, that the statement of [3] is
-	incomplete, delay may actually be estimated even if class
-	per-round allotment is less than MTU. Namely, if per-round
-	allotment is W*r_i, and r_1+...+r_k = r < 1
-
-	delay_i <= ([MTU/(W*r_i)]*W*r + W*r + k*MTU)/B
-
-	In the worst case we have IntServ estimate with D = W*r+k*MTU
-	and C = MTU*r. The proof (if correct at all) is trivial.
-
-
-	--- It seems that cbq-2.0 is not very accurate. At least, I cannot
-	interpret some places, which look like wrong translations
-	from NS. Anyone is advised to find these differences
-	and explain to me, why I am wrong 8).
-
-	--- Linux has no EOI event, so that we cannot estimate true class
-	idle time. Workaround is to consider the next dequeue event
-	as sign that previous packet is finished. This is wrong because of
-	internal device queueing, but on a permanently loaded link it is true.
-	Moreover, combined with clock integrator, this scheme looks
-	very close to an ideal solution.  */
-
-struct cbq_sched_data;
-
-
-struct cbq_class {
-	struct Qdisc_class_common common;
-	struct cbq_class	*next_alive;	/* next class with backlog in this priority band */
-
-/* Parameters */
-	unsigned char		priority;	/* class priority */
-	unsigned char		priority2;	/* priority to be used after overlimit */
-	unsigned char		ewma_log;	/* time constant for idle time calculation */
-
-	u32			defmap;
-
-	/* Link-sharing scheduler parameters */
-	long			maxidle;	/* Class parameters: see below. */
-	long			offtime;
-	long			minidle;
-	u32			avpkt;
-	struct qdisc_rate_table	*R_tab;
-
-	/* General scheduler (WRR) parameters */
-	long			allot;
-	long			quantum;	/* Allotment per WRR round */
-	long			weight;		/* Relative allotment: see below */
-
-	struct Qdisc		*qdisc;		/* Ptr to CBQ discipline */
-	struct cbq_class	*split;		/* Ptr to split node */
-	struct cbq_class	*share;		/* Ptr to LS parent in the class tree */
-	struct cbq_class	*tparent;	/* Ptr to tree parent in the class tree */
-	struct cbq_class	*borrow;	/* NULL if class is bandwidth limited;
-						   parent otherwise */
-	struct cbq_class	*sibling;	/* Sibling chain */
-	struct cbq_class	*children;	/* Pointer to children chain */
-
-	struct Qdisc		*q;		/* Elementary queueing discipline */
-
-
-/* Variables */
-	unsigned char		cpriority;	/* Effective priority */
-	unsigned char		delayed;
-	unsigned char		level;		/* level of the class in hierarchy:
-						   0 for leaf classes, and maximal
-						   level of children + 1 for nodes.
-						 */
-
-	psched_time_t		last;		/* Last end of service */
-	psched_time_t		undertime;
-	long			avgidle;
-	long			deficit;	/* Saved deficit for WRR */
-	psched_time_t		penalized;
-	struct gnet_stats_basic_packed bstats;
-	struct gnet_stats_queue qstats;
-	struct net_rate_estimator __rcu *rate_est;
-	struct tc_cbq_xstats	xstats;
-
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-
-	int			filters;
-
-	struct cbq_class	*defaults[TC_PRIO_MAX + 1];
-};
-
-struct cbq_sched_data {
-	struct Qdisc_class_hash	clhash;			/* Hash table of all classes */
-	int			nclasses[TC_CBQ_MAXPRIO + 1];
-	unsigned int		quanta[TC_CBQ_MAXPRIO + 1];
-
-	struct cbq_class	link;
-
-	unsigned int		activemask;
-	struct cbq_class	*active[TC_CBQ_MAXPRIO + 1];	/* List of all classes
-								   with backlog */
-
-#ifdef CONFIG_NET_CLS_ACT
-	struct cbq_class	*rx_class;
-#endif
-	struct cbq_class	*tx_class;
-	struct cbq_class	*tx_borrowed;
-	int			tx_len;
-	psched_time_t		now;		/* Cached timestamp */
-	unsigned int		pmask;
-
-	struct hrtimer		delay_timer;
-	struct qdisc_watchdog	watchdog;	/* Watchdog timer,
-						   started when CBQ has
-						   backlog, but cannot
-						   transmit just now */
-	psched_tdiff_t		wd_expires;
-	int			toplevel;
-	u32			hgenerator;
-};
-
-
-#define L2T(cl, len)	qdisc_l2t((cl)->R_tab, len)
-
-static inline struct cbq_class *
-cbq_class_lookup(struct cbq_sched_data *q, u32 classid)
-{
-	struct Qdisc_class_common *clc;
-
-	clc = qdisc_class_find(&q->clhash, classid);
-	if (clc == NULL)
-		return NULL;
-	return container_of(clc, struct cbq_class, common);
-}
-
-#ifdef CONFIG_NET_CLS_ACT
-
-static struct cbq_class *
-cbq_reclassify(struct sk_buff *skb, struct cbq_class *this)
-{
-	struct cbq_class *cl;
-
-	for (cl = this->tparent; cl; cl = cl->tparent) {
-		struct cbq_class *new = cl->defaults[TC_PRIO_BESTEFFORT];
-
-		if (new != NULL && new != this)
-			return new;
-	}
-	return NULL;
-}
-
-#endif
-
-/* Classify packet. The procedure is pretty complicated, but
- * it allows us to combine link sharing and priority scheduling
- * transparently.
- *
- * Namely, you can put link sharing rules (f.e. route based) at root of CBQ,
- * so that it resolves to split nodes. Then packets are classified
- * by logical priority, or a more specific classifier may be attached
- * to the split node.
- */
-
-static struct cbq_class *
-cbq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *head = &q->link;
-	struct cbq_class **defmap;
-	struct cbq_class *cl = NULL;
-	u32 prio = skb->priority;
-	struct tcf_proto *fl;
-	struct tcf_result res;
-
-	/*
-	 *  Step 1. If skb->priority points to one of our classes, use it.
-	 */
-	if (TC_H_MAJ(prio ^ sch->handle) == 0 &&
-	    (cl = cbq_class_lookup(q, prio)) != NULL)
-		return cl;
-
-	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	for (;;) {
-		int result = 0;
-		defmap = head->defaults;
-
-		fl = rcu_dereference_bh(head->filter_list);
-		/*
-		 * Step 2+n. Apply classifier.
-		 */
-		result = tcf_classify(skb, NULL, fl, &res, true);
-		if (!fl || result < 0)
-			goto fallback;
-		if (result == TC_ACT_SHOT)
-			return NULL;
-
-		cl = (void *)res.class;
-		if (!cl) {
-			if (TC_H_MAJ(res.classid))
-				cl = cbq_class_lookup(q, res.classid);
-			else if ((cl = defmap[res.classid & TC_PRIO_MAX]) == NULL)
-				cl = defmap[TC_PRIO_BESTEFFORT];
-
-			if (cl == NULL)
-				goto fallback;
-		}
-		if (cl->level >= head->level)
-			goto fallback;
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_RECLASSIFY:
-			return cbq_reclassify(skb, cl);
-		}
-#endif
-		if (cl->level == 0)
-			return cl;
-
-		/*
-		 * Step 3+n. If classifier selected a link sharing class,
-		 *	   apply agency specific classifier.
-		 *	   Repeat this procedure until we hit a leaf node.
-		 */
-		head = cl;
-	}
-
-fallback:
-	cl = head;
-
-	/*
-	 * Step 4. No success...
-	 */
-	if (TC_H_MAJ(prio) == 0 &&
-	    !(cl = head->defaults[prio & TC_PRIO_MAX]) &&
-	    !(cl = head->defaults[TC_PRIO_BESTEFFORT]))
-		return head;
-
-	return cl;
-}
-
-/*
- * A packet has just been enqueued on the empty class.
- * cbq_activate_class adds it to the tail of active class list
- * of its priority band.
- */
-
-static inline void cbq_activate_class(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	int prio = cl->cpriority;
-	struct cbq_class *cl_tail;
-
-	cl_tail = q->active[prio];
-	q->active[prio] = cl;
-
-	if (cl_tail != NULL) {
-		cl->next_alive = cl_tail->next_alive;
-		cl_tail->next_alive = cl;
-	} else {
-		cl->next_alive = cl;
-		q->activemask |= (1<<prio);
-	}
-}
-
-/*
- * Unlink class from active chain.
- * Note that this same procedure is done directly in cbq_dequeue*
- * during round-robin procedure.
- */
-
-static void cbq_deactivate_class(struct cbq_class *this)
-{
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-	int prio = this->cpriority;
-	struct cbq_class *cl;
-	struct cbq_class *cl_prev = q->active[prio];
-
-	do {
-		cl = cl_prev->next_alive;
-		if (cl == this) {
-			cl_prev->next_alive = cl->next_alive;
-			cl->next_alive = NULL;
-
-			if (cl == q->active[prio]) {
-				q->active[prio] = cl_prev;
-				if (cl == q->active[prio]) {
-					q->active[prio] = NULL;
-					q->activemask &= ~(1<<prio);
-					return;
-				}
-			}
-			return;
-		}
-	} while ((cl_prev = cl) != q->active[prio]);
-}
-
-static void
-cbq_mark_toplevel(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	int toplevel = q->toplevel;
-
-	if (toplevel > cl->level) {
-		psched_time_t now = psched_get_time();
-
-		do {
-			if (cl->undertime < now) {
-				q->toplevel = cl->level;
-				return;
-			}
-		} while ((cl = cl->borrow) != NULL && toplevel > cl->level);
-	}
-}
-
-static int
-cbq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-	    struct sk_buff **to_free)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	int ret;
-	struct cbq_class *cl = cbq_classify(skb, sch, &ret);
-
-#ifdef CONFIG_NET_CLS_ACT
-	q->rx_class = cl;
-#endif
-	if (cl == NULL) {
-		if (ret & __NET_XMIT_BYPASS)
-			qdisc_qstats_drop(sch);
-		__qdisc_drop(skb, to_free);
-		return ret;
-	}
-
-	ret = qdisc_enqueue(skb, cl->q, to_free);
-	if (ret == NET_XMIT_SUCCESS) {
-		sch->q.qlen++;
-		cbq_mark_toplevel(q, cl);
-		if (!cl->next_alive)
-			cbq_activate_class(cl);
-		return ret;
-	}
-
-	if (net_xmit_drop_count(ret)) {
-		qdisc_qstats_drop(sch);
-		cbq_mark_toplevel(q, cl);
-		cl->qstats.drops++;
-	}
-	return ret;
-}
-
-/* Overlimit action: penalize leaf class by adding offtime */
-static void cbq_overlimit(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	psched_tdiff_t delay = cl->undertime - q->now;
-
-	if (!cl->delayed) {
-		delay += cl->offtime;
-
-		/*
-		 * Class goes to sleep, so that it will have no
-		 * chance to work avgidle. Let's forgive it 8)
-		 *
-		 * BTW cbq-2.0 has a crap in this
-		 * place, apparently they forgot to shift it by cl->ewma_log.
-		 */
-		if (cl->avgidle < 0)
-			delay -= (-cl->avgidle) - ((-cl->avgidle) >> cl->ewma_log);
-		if (cl->avgidle < cl->minidle)
-			cl->avgidle = cl->minidle;
-		if (delay <= 0)
-			delay = 1;
-		cl->undertime = q->now + delay;
-
-		cl->xstats.overactions++;
-		cl->delayed = 1;
-	}
-	if (q->wd_expires == 0 || q->wd_expires > delay)
-		q->wd_expires = delay;
-
-	/* Dirty work! We must schedule wakeups based on
-	 * real available rate, rather than leaf rate,
-	 * which may be tiny (even zero).
-	 */
-	if (q->toplevel == TC_CBQ_MAXLEVEL) {
-		struct cbq_class *b;
-		psched_tdiff_t base_delay = q->wd_expires;
-
-		for (b = cl->borrow; b; b = b->borrow) {
-			delay = b->undertime - q->now;
-			if (delay < base_delay) {
-				if (delay <= 0)
-					delay = 1;
-				base_delay = delay;
-			}
-		}
-
-		q->wd_expires = base_delay;
-	}
-}
-
-static psched_tdiff_t cbq_undelay_prio(struct cbq_sched_data *q, int prio,
-				       psched_time_t now)
-{
-	struct cbq_class *cl;
-	struct cbq_class *cl_prev = q->active[prio];
-	psched_time_t sched = now;
-
-	if (cl_prev == NULL)
-		return 0;
-
-	do {
-		cl = cl_prev->next_alive;
-		if (now - cl->penalized > 0) {
-			cl_prev->next_alive = cl->next_alive;
-			cl->next_alive = NULL;
-			cl->cpriority = cl->priority;
-			cl->delayed = 0;
-			cbq_activate_class(cl);
-
-			if (cl == q->active[prio]) {
-				q->active[prio] = cl_prev;
-				if (cl == q->active[prio]) {
-					q->active[prio] = NULL;
-					return 0;
-				}
-			}
-
-			cl = cl_prev->next_alive;
-		} else if (sched - cl->penalized > 0)
-			sched = cl->penalized;
-	} while ((cl_prev = cl) != q->active[prio]);
-
-	return sched - now;
-}
-
-static enum hrtimer_restart cbq_undelay(struct hrtimer *timer)
-{
-	struct cbq_sched_data *q = container_of(timer, struct cbq_sched_data,
-						delay_timer);
-	struct Qdisc *sch = q->watchdog.qdisc;
-	psched_time_t now;
-	psched_tdiff_t delay = 0;
-	unsigned int pmask;
-
-	now = psched_get_time();
-
-	pmask = q->pmask;
-	q->pmask = 0;
-
-	while (pmask) {
-		int prio = ffz(~pmask);
-		psched_tdiff_t tmp;
-
-		pmask &= ~(1<<prio);
-
-		tmp = cbq_undelay_prio(q, prio, now);
-		if (tmp > 0) {
-			q->pmask |= 1<<prio;
-			if (tmp < delay || delay == 0)
-				delay = tmp;
-		}
-	}
-
-	if (delay) {
-		ktime_t time;
-
-		time = 0;
-		time = ktime_add_ns(time, PSCHED_TICKS2NS(now + delay));
-		hrtimer_start(&q->delay_timer, time, HRTIMER_MODE_ABS_PINNED);
-	}
-
-	__netif_schedule(qdisc_root(sch));
-	return HRTIMER_NORESTART;
-}
-
-/*
- * It is mission critical procedure.
- *
- * We "regenerate" toplevel cutoff, if transmitting class
- * has backlog and it is not regulated. It is not part of
- * original CBQ description, but looks more reasonable.
- * Probably, it is wrong. This question needs further investigation.
- */
-
-static inline void
-cbq_update_toplevel(struct cbq_sched_data *q, struct cbq_class *cl,
-		    struct cbq_class *borrowed)
-{
-	if (cl && q->toplevel >= borrowed->level) {
-		if (cl->q->q.qlen > 1) {
-			do {
-				if (borrowed->undertime == PSCHED_PASTPERFECT) {
-					q->toplevel = borrowed->level;
-					return;
-				}
-			} while ((borrowed = borrowed->borrow) != NULL);
-		}
-#if 0
-	/* It is not necessary now. Uncommenting it
-	   will save CPU cycles, but decrease fairness.
-	 */
-		q->toplevel = TC_CBQ_MAXLEVEL;
-#endif
-	}
-}
-
-static void
-cbq_update(struct cbq_sched_data *q)
-{
-	struct cbq_class *this = q->tx_class;
-	struct cbq_class *cl = this;
-	int len = q->tx_len;
-	psched_time_t now;
-
-	q->tx_class = NULL;
-	/* Time integrator. We calculate EOS time
-	 * by adding expected packet transmission time.
-	 */
-	now = q->now + L2T(&q->link, len);
-
-	for ( ; cl; cl = cl->share) {
-		long avgidle = cl->avgidle;
-		long idle;
-
-		cl->bstats.packets++;
-		cl->bstats.bytes += len;
-
-		/*
-		 * (now - last) is total time between packet right edges.
-		 * (last_pktlen/rate) is "virtual" busy time, so that
-		 *
-		 *	idle = (now - last) - last_pktlen/rate
-		 */
-
-		idle = now - cl->last;
-		if ((unsigned long)idle > 128*1024*1024) {
-			avgidle = cl->maxidle;
-		} else {
-			idle -= L2T(cl, len);
-
-		/* true_avgidle := (1-W)*true_avgidle + W*idle,
-		 * where W=2^{-ewma_log}. But cl->avgidle is scaled:
-		 * cl->avgidle == true_avgidle/W,
-		 * hence:
-		 */
-			avgidle += idle - (avgidle>>cl->ewma_log);
-		}
-
-		if (avgidle <= 0) {
-			/* Overlimit or at-limit */
-
-			if (avgidle < cl->minidle)
-				avgidle = cl->minidle;
-
-			cl->avgidle = avgidle;
-
-			/* Calculate expected time, when this class
-			 * will be allowed to send.
-			 * It will occur, when:
-			 * (1-W)*true_avgidle + W*delay = 0, i.e.
-			 * idle = (1/W - 1)*(-true_avgidle)
-			 * or
-			 * idle = (1 - W)*(-cl->avgidle);
-			 */
-			idle = (-avgidle) - ((-avgidle) >> cl->ewma_log);
-
-			/*
-			 * That is not all.
-			 * To maintain the rate allocated to the class,
-			 * we add to undertime virtual clock,
-			 * necessary to complete transmitted packet.
-			 * (len/phys_bandwidth has been already passed
-			 * to the moment of cbq_update)
-			 */
-
-			idle -= L2T(&q->link, len);
-			idle += L2T(cl, len);
-
-			cl->undertime = now + idle;
-		} else {
-			/* Underlimit */
-
-			cl->undertime = PSCHED_PASTPERFECT;
-			if (avgidle > cl->maxidle)
-				cl->avgidle = cl->maxidle;
-			else
-				cl->avgidle = avgidle;
-		}
-		if ((s64)(now - cl->last) > 0)
-			cl->last = now;
-	}
-
-	cbq_update_toplevel(q, this, q->tx_borrowed);
-}
-
-static inline struct cbq_class *
-cbq_under_limit(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	struct cbq_class *this_cl = cl;
-
-	if (cl->tparent == NULL)
-		return cl;
-
-	if (cl->undertime == PSCHED_PASTPERFECT || q->now >= cl->undertime) {
-		cl->delayed = 0;
-		return cl;
-	}
-
-	do {
-		/* It is very suspicious place. Now overlimit
-		 * action is generated for not bounded classes
-		 * only if link is completely congested.
-		 * Though it is in agree with ancestor-only paradigm,
-		 * it looks very stupid. Particularly,
-		 * it means that this chunk of code will either
-		 * never be called or result in strong amplification
-		 * of burstiness. Dangerous, silly, and, however,
-		 * no another solution exists.
-		 */
-		cl = cl->borrow;
-		if (!cl) {
-			this_cl->qstats.overlimits++;
-			cbq_overlimit(this_cl);
-			return NULL;
-		}
-		if (cl->level > q->toplevel)
-			return NULL;
-	} while (cl->undertime != PSCHED_PASTPERFECT && q->now < cl->undertime);
-
-	cl->delayed = 0;
-	return cl;
-}
-
-static inline struct sk_buff *
-cbq_dequeue_prio(struct Qdisc *sch, int prio)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl_tail, *cl_prev, *cl;
-	struct sk_buff *skb;
-	int deficit;
-
-	cl_tail = cl_prev = q->active[prio];
-	cl = cl_prev->next_alive;
-
-	do {
-		deficit = 0;
-
-		/* Start round */
-		do {
-			struct cbq_class *borrow = cl;
-
-			if (cl->q->q.qlen &&
-			    (borrow = cbq_under_limit(cl)) == NULL)
-				goto skip_class;
-
-			if (cl->deficit <= 0) {
-				/* Class exhausted its allotment per
-				 * this round. Switch to the next one.
-				 */
-				deficit = 1;
-				cl->deficit += cl->quantum;
-				goto next_class;
-			}
-
-			skb = cl->q->dequeue(cl->q);
-
-			/* Class did not give us any skb :-(
-			 * It could occur even if cl->q->q.qlen != 0
-			 * f.e. if cl->q == "tbf"
-			 */
-			if (skb == NULL)
-				goto skip_class;
-
-			cl->deficit -= qdisc_pkt_len(skb);
-			q->tx_class = cl;
-			q->tx_borrowed = borrow;
-			if (borrow != cl) {
-#ifndef CBQ_XSTATS_BORROWS_BYTES
-				borrow->xstats.borrows++;
-				cl->xstats.borrows++;
-#else
-				borrow->xstats.borrows += qdisc_pkt_len(skb);
-				cl->xstats.borrows += qdisc_pkt_len(skb);
-#endif
-			}
-			q->tx_len = qdisc_pkt_len(skb);
-
-			if (cl->deficit <= 0) {
-				q->active[prio] = cl;
-				cl = cl->next_alive;
-				cl->deficit += cl->quantum;
-			}
-			return skb;
-
-skip_class:
-			if (cl->q->q.qlen == 0 || prio != cl->cpriority) {
-				/* Class is empty or penalized.
-				 * Unlink it from active chain.
-				 */
-				cl_prev->next_alive = cl->next_alive;
-				cl->next_alive = NULL;
-
-				/* Did cl_tail point to it? */
-				if (cl == cl_tail) {
-					/* Repair it! */
-					cl_tail = cl_prev;
-
-					/* Was it the last class in this band? */
-					if (cl == cl_tail) {
-						/* Kill the band! */
-						q->active[prio] = NULL;
-						q->activemask &= ~(1<<prio);
-						if (cl->q->q.qlen)
-							cbq_activate_class(cl);
-						return NULL;
-					}
-
-					q->active[prio] = cl_tail;
-				}
-				if (cl->q->q.qlen)
-					cbq_activate_class(cl);
-
-				cl = cl_prev;
-			}
-
-next_class:
-			cl_prev = cl;
-			cl = cl->next_alive;
-		} while (cl_prev != cl_tail);
-	} while (deficit);
-
-	q->active[prio] = cl_prev;
-
-	return NULL;
-}
-
-static inline struct sk_buff *
-cbq_dequeue_1(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *skb;
-	unsigned int activemask;
-
-	activemask = q->activemask & 0xFF;
-	while (activemask) {
-		int prio = ffz(~activemask);
-		activemask &= ~(1<<prio);
-		skb = cbq_dequeue_prio(sch, prio);
-		if (skb)
-			return skb;
-	}
-	return NULL;
-}
-
-static struct sk_buff *
-cbq_dequeue(struct Qdisc *sch)
-{
-	struct sk_buff *skb;
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	psched_time_t now;
-
-	now = psched_get_time();
-
-	if (q->tx_class)
-		cbq_update(q);
-
-	q->now = now;
-
-	for (;;) {
-		q->wd_expires = 0;
-
-		skb = cbq_dequeue_1(sch);
-		if (skb) {
-			qdisc_bstats_update(sch, skb);
-			sch->q.qlen--;
-			return skb;
-		}
-
-		/* All the classes are overlimit.
-		 *
-		 * It is possible, if:
-		 *
-		 * 1. Scheduler is empty.
-		 * 2. Toplevel cutoff inhibited borrowing.
-		 * 3. Root class is overlimit.
-		 *
-		 * Reset 2d and 3d conditions and retry.
-		 *
-		 * Note, that NS and cbq-2.0 are buggy, peeking
-		 * an arbitrary class is appropriate for ancestor-only
-		 * sharing, but not for toplevel algorithm.
-		 *
-		 * Our version is better, but slower, because it requires
-		 * two passes, but it is unavoidable with top-level sharing.
-		 */
-
-		if (q->toplevel == TC_CBQ_MAXLEVEL &&
-		    q->link.undertime == PSCHED_PASTPERFECT)
-			break;
-
-		q->toplevel = TC_CBQ_MAXLEVEL;
-		q->link.undertime = PSCHED_PASTPERFECT;
-	}
-
-	/* No packets in scheduler or nobody wants to give them to us :-(
-	 * Sigh... start watchdog timer in the last case.
-	 */
-
-	if (sch->q.qlen) {
-		qdisc_qstats_overlimit(sch);
-		if (q->wd_expires)
-			qdisc_watchdog_schedule(&q->watchdog,
-						now + q->wd_expires);
-	}
-	return NULL;
-}
-
-/* CBQ class maintenance routines */
-
-static void cbq_adjust_levels(struct cbq_class *this)
-{
-	if (this == NULL)
-		return;
-
-	do {
-		int level = 0;
-		struct cbq_class *cl;
-
-		cl = this->children;
-		if (cl) {
-			do {
-				if (cl->level > level)
-					level = cl->level;
-			} while ((cl = cl->sibling) != this->children);
-		}
-		this->level = level + 1;
-	} while ((this = this->tparent) != NULL);
-}
-
-static void cbq_normalize_quanta(struct cbq_sched_data *q, int prio)
-{
-	struct cbq_class *cl;
-	unsigned int h;
-
-	if (q->quanta[prio] == 0)
-		return;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			/* BUGGGG... Beware! This expression suffer of
-			 * arithmetic overflows!
-			 */
-			if (cl->priority == prio) {
-				cl->quantum = (cl->weight*cl->allot*q->nclasses[prio])/
-					q->quanta[prio];
-			}
-			if (cl->quantum <= 0 ||
-			    cl->quantum > 32*qdisc_dev(cl->qdisc)->mtu) {
-				pr_warn("CBQ: class %08x has bad quantum==%ld, repaired.\n",
-					cl->common.classid, cl->quantum);
-				cl->quantum = qdisc_dev(cl->qdisc)->mtu/2 + 1;
-			}
-		}
-	}
-}
-
-static void cbq_sync_defmap(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	struct cbq_class *split = cl->split;
-	unsigned int h;
-	int i;
-
-	if (split == NULL)
-		return;
-
-	for (i = 0; i <= TC_PRIO_MAX; i++) {
-		if (split->defaults[i] == cl && !(cl->defmap & (1<<i)))
-			split->defaults[i] = NULL;
-	}
-
-	for (i = 0; i <= TC_PRIO_MAX; i++) {
-		int level = split->level;
-
-		if (split->defaults[i])
-			continue;
-
-		for (h = 0; h < q->clhash.hashsize; h++) {
-			struct cbq_class *c;
-
-			hlist_for_each_entry(c, &q->clhash.hash[h],
-					     common.hnode) {
-				if (c->split == split && c->level < level &&
-				    c->defmap & (1<<i)) {
-					split->defaults[i] = c;
-					level = c->level;
-				}
-			}
-		}
-	}
-}
-
-static void cbq_change_defmap(struct cbq_class *cl, u32 splitid, u32 def, u32 mask)
-{
-	struct cbq_class *split = NULL;
-
-	if (splitid == 0) {
-		split = cl->split;
-		if (!split)
-			return;
-		splitid = split->common.classid;
-	}
-
-	if (split == NULL || split->common.classid != splitid) {
-		for (split = cl->tparent; split; split = split->tparent)
-			if (split->common.classid == splitid)
-				break;
-	}
-
-	if (split == NULL)
-		return;
-
-	if (cl->split != split) {
-		cl->defmap = 0;
-		cbq_sync_defmap(cl);
-		cl->split = split;
-		cl->defmap = def & mask;
-	} else
-		cl->defmap = (cl->defmap & ~mask) | (def & mask);
-
-	cbq_sync_defmap(cl);
-}
-
-static void cbq_unlink_class(struct cbq_class *this)
-{
-	struct cbq_class *cl, **clp;
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-
-	qdisc_class_hash_remove(&q->clhash, &this->common);
-
-	if (this->tparent) {
-		clp = &this->sibling;
-		cl = *clp;
-		do {
-			if (cl == this) {
-				*clp = cl->sibling;
-				break;
-			}
-			clp = &cl->sibling;
-		} while ((cl = *clp) != this->sibling);
-
-		if (this->tparent->children == this) {
-			this->tparent->children = this->sibling;
-			if (this->sibling == this)
-				this->tparent->children = NULL;
-		}
-	} else {
-		WARN_ON(this->sibling != this);
-	}
-}
-
-static void cbq_link_class(struct cbq_class *this)
-{
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-	struct cbq_class *parent = this->tparent;
-
-	this->sibling = this;
-	qdisc_class_hash_insert(&q->clhash, &this->common);
-
-	if (parent == NULL)
-		return;
-
-	if (parent->children == NULL) {
-		parent->children = this;
-	} else {
-		this->sibling = parent->children->sibling;
-		parent->children->sibling = this;
-	}
-}
-
-static void
-cbq_reset(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl;
-	int prio;
-	unsigned int h;
-
-	q->activemask = 0;
-	q->pmask = 0;
-	q->tx_class = NULL;
-	q->tx_borrowed = NULL;
-	qdisc_watchdog_cancel(&q->watchdog);
-	hrtimer_cancel(&q->delay_timer);
-	q->toplevel = TC_CBQ_MAXLEVEL;
-	q->now = psched_get_time();
-
-	for (prio = 0; prio <= TC_CBQ_MAXPRIO; prio++)
-		q->active[prio] = NULL;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			qdisc_reset(cl->q);
-
-			cl->next_alive = NULL;
-			cl->undertime = PSCHED_PASTPERFECT;
-			cl->avgidle = cl->maxidle;
-			cl->deficit = cl->quantum;
-			cl->cpriority = cl->priority;
-		}
-	}
-}
-
-
-static int cbq_set_lss(struct cbq_class *cl, struct tc_cbq_lssopt *lss)
-{
-	if (lss->change & TCF_CBQ_LSS_FLAGS) {
-		cl->share = (lss->flags & TCF_CBQ_LSS_ISOLATED) ? NULL : cl->tparent;
-		cl->borrow = (lss->flags & TCF_CBQ_LSS_BOUNDED) ? NULL : cl->tparent;
-	}
-	if (lss->change & TCF_CBQ_LSS_EWMA)
-		cl->ewma_log = lss->ewma_log;
-	if (lss->change & TCF_CBQ_LSS_AVPKT)
-		cl->avpkt = lss->avpkt;
-	if (lss->change & TCF_CBQ_LSS_MINIDLE)
-		cl->minidle = -(long)lss->minidle;
-	if (lss->change & TCF_CBQ_LSS_MAXIDLE) {
-		cl->maxidle = lss->maxidle;
-		cl->avgidle = lss->maxidle;
-	}
-	if (lss->change & TCF_CBQ_LSS_OFFTIME)
-		cl->offtime = lss->offtime;
-	return 0;
-}
-
-static void cbq_rmprio(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	q->nclasses[cl->priority]--;
-	q->quanta[cl->priority] -= cl->weight;
-	cbq_normalize_quanta(q, cl->priority);
-}
-
-static void cbq_addprio(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	q->nclasses[cl->priority]++;
-	q->quanta[cl->priority] += cl->weight;
-	cbq_normalize_quanta(q, cl->priority);
-}
-
-static int cbq_set_wrr(struct cbq_class *cl, struct tc_cbq_wrropt *wrr)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-
-	if (wrr->allot)
-		cl->allot = wrr->allot;
-	if (wrr->weight)
-		cl->weight = wrr->weight;
-	if (wrr->priority) {
-		cl->priority = wrr->priority - 1;
-		cl->cpriority = cl->priority;
-		if (cl->priority >= cl->priority2)
-			cl->priority2 = TC_CBQ_MAXPRIO - 1;
-	}
-
-	cbq_addprio(q, cl);
-	return 0;
-}
-
-static int cbq_set_fopt(struct cbq_class *cl, struct tc_cbq_fopt *fopt)
-{
-	cbq_change_defmap(cl, fopt->split, fopt->defmap, fopt->defchange);
-	return 0;
-}
-
-static const struct nla_policy cbq_policy[TCA_CBQ_MAX + 1] = {
-	[TCA_CBQ_LSSOPT]	= { .len = sizeof(struct tc_cbq_lssopt) },
-	[TCA_CBQ_WRROPT]	= { .len = sizeof(struct tc_cbq_wrropt) },
-	[TCA_CBQ_FOPT]		= { .len = sizeof(struct tc_cbq_fopt) },
-	[TCA_CBQ_OVL_STRATEGY]	= { .len = sizeof(struct tc_cbq_ovl) },
-	[TCA_CBQ_RATE]		= { .len = sizeof(struct tc_ratespec) },
-	[TCA_CBQ_RTAB]		= { .type = NLA_BINARY, .len = TC_RTAB_SIZE },
-	[TCA_CBQ_POLICE]	= { .len = sizeof(struct tc_cbq_police) },
-};
-
-static int cbq_opt_parse(struct nlattr *tb[TCA_CBQ_MAX + 1],
-			 struct nlattr *opt,
-			 struct netlink_ext_ack *extack)
-{
-	int err;
-
-	if (!opt) {
-		NL_SET_ERR_MSG(extack, "CBQ options are required for this operation");
-		return -EINVAL;
-	}
-
-	err = nla_parse_nested_deprecated(tb, TCA_CBQ_MAX, opt,
-					  cbq_policy, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_CBQ_WRROPT]) {
-		const struct tc_cbq_wrropt *wrr = nla_data(tb[TCA_CBQ_WRROPT]);
-
-		if (wrr->priority > TC_CBQ_MAXPRIO) {
-			NL_SET_ERR_MSG(extack, "priority is bigger than TC_CBQ_MAXPRIO");
-			err = -EINVAL;
-		}
-	}
-	return err;
-}
-
-static int cbq_init(struct Qdisc *sch, struct nlattr *opt,
-		    struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct nlattr *tb[TCA_CBQ_MAX + 1];
-	struct tc_ratespec *r;
-	int err;
-
-	qdisc_watchdog_init(&q->watchdog, sch);
-	hrtimer_init(&q->delay_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
-	q->delay_timer.function = cbq_undelay;
-
-	err = cbq_opt_parse(tb, opt, extack);
-	if (err < 0)
-		return err;
-
-	if (!tb[TCA_CBQ_RTAB] || !tb[TCA_CBQ_RATE]) {
-		NL_SET_ERR_MSG(extack, "Rate specification missing or incomplete");
-		return -EINVAL;
-	}
-
-	r = nla_data(tb[TCA_CBQ_RATE]);
-
-	q->link.R_tab = qdisc_get_rtab(r, tb[TCA_CBQ_RTAB], extack);
-	if (!q->link.R_tab)
-		return -EINVAL;
-
-	err = tcf_block_get(&q->link.block, &q->link.filter_list, sch, extack);
-	if (err)
-		goto put_rtab;
-
-	err = qdisc_class_hash_init(&q->clhash);
-	if (err < 0)
-		goto put_block;
-
-	q->link.sibling = &q->link;
-	q->link.common.classid = sch->handle;
-	q->link.qdisc = sch;
-	q->link.q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-				      sch->handle, NULL);
-	if (!q->link.q)
-		q->link.q = &noop_qdisc;
-	else
-		qdisc_hash_add(q->link.q, true);
-
-	q->link.priority = TC_CBQ_MAXPRIO - 1;
-	q->link.priority2 = TC_CBQ_MAXPRIO - 1;
-	q->link.cpriority = TC_CBQ_MAXPRIO - 1;
-	q->link.allot = psched_mtu(qdisc_dev(sch));
-	q->link.quantum = q->link.allot;
-	q->link.weight = q->link.R_tab->rate.rate;
-
-	q->link.ewma_log = TC_CBQ_DEF_EWMA;
-	q->link.avpkt = q->link.allot/2;
-	q->link.minidle = -0x7FFFFFFF;
-
-	q->toplevel = TC_CBQ_MAXLEVEL;
-	q->now = psched_get_time();
-
-	cbq_link_class(&q->link);
-
-	if (tb[TCA_CBQ_LSSOPT])
-		cbq_set_lss(&q->link, nla_data(tb[TCA_CBQ_LSSOPT]));
-
-	cbq_addprio(q, &q->link);
-	return 0;
-
-put_block:
-	tcf_block_put(q->link.block);
-
-put_rtab:
-	qdisc_put_rtab(q->link.R_tab);
-	return err;
-}
-
-static int cbq_dump_rate(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-
-	if (nla_put(skb, TCA_CBQ_RATE, sizeof(cl->R_tab->rate), &cl->R_tab->rate))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_lss(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_lssopt opt;
-
-	opt.flags = 0;
-	if (cl->borrow == NULL)
-		opt.flags |= TCF_CBQ_LSS_BOUNDED;
-	if (cl->share == NULL)
-		opt.flags |= TCF_CBQ_LSS_ISOLATED;
-	opt.ewma_log = cl->ewma_log;
-	opt.level = cl->level;
-	opt.avpkt = cl->avpkt;
-	opt.maxidle = cl->maxidle;
-	opt.minidle = (u32)(-cl->minidle);
-	opt.offtime = cl->offtime;
-	opt.change = ~0;
-	if (nla_put(skb, TCA_CBQ_LSSOPT, sizeof(opt), &opt))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_wrr(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_wrropt opt;
-
-	memset(&opt, 0, sizeof(opt));
-	opt.flags = 0;
-	opt.allot = cl->allot;
-	opt.priority = cl->priority + 1;
-	opt.cpriority = cl->cpriority + 1;
-	opt.weight = cl->weight;
-	if (nla_put(skb, TCA_CBQ_WRROPT, sizeof(opt), &opt))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_fopt(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_fopt opt;
-
-	if (cl->split || cl->defmap) {
-		opt.split = cl->split ? cl->split->common.classid : 0;
-		opt.defmap = cl->defmap;
-		opt.defchange = ~0;
-		if (nla_put(skb, TCA_CBQ_FOPT, sizeof(opt), &opt))
-			goto nla_put_failure;
-	}
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_attr(struct sk_buff *skb, struct cbq_class *cl)
-{
-	if (cbq_dump_lss(skb, cl) < 0 ||
-	    cbq_dump_rate(skb, cl) < 0 ||
-	    cbq_dump_wrr(skb, cl) < 0 ||
-	    cbq_dump_fopt(skb, cl) < 0)
-		return -1;
-	return 0;
-}
-
-static int cbq_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct nlattr *nest;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	if (cbq_dump_attr(skb, &q->link) < 0)
-		goto nla_put_failure;
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static int
-cbq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	q->link.xstats.avgidle = q->link.avgidle;
-	return gnet_stats_copy_app(d, &q->link.xstats, sizeof(q->link.xstats));
-}
-
-static int
-cbq_dump_class(struct Qdisc *sch, unsigned long arg,
-	       struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-	struct nlattr *nest;
-
-	if (cl->tparent)
-		tcm->tcm_parent = cl->tparent->common.classid;
-	else
-		tcm->tcm_parent = TC_H_ROOT;
-	tcm->tcm_handle = cl->common.classid;
-	tcm->tcm_info = cl->q->handle;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	if (cbq_dump_attr(skb, cl) < 0)
-		goto nla_put_failure;
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static int
-cbq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-	struct gnet_dump *d)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-	__u32 qlen;
-
-	cl->xstats.avgidle = cl->avgidle;
-	cl->xstats.undertime = 0;
-	qdisc_qstats_qlen_backlog(cl->q, &qlen, &cl->qstats.backlog);
-
-	if (cl->undertime != PSCHED_PASTPERFECT)
-		cl->xstats.undertime = cl->undertime - q->now;
-
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
-	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &cl->qstats, qlen) < 0)
-		return -1;
-
-	return gnet_stats_copy_app(d, &cl->xstats, sizeof(cl->xstats));
-}
-
-static int cbq_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
-		     struct Qdisc **old, struct netlink_ext_ack *extack)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					cl->common.classid, extack);
-		if (new == NULL)
-			return -ENOBUFS;
-	}
-
-	*old = qdisc_replace(sch, new, &cl->q);
-	return 0;
-}
-
-static struct Qdisc *cbq_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	return cl->q;
-}
-
-static void cbq_qlen_notify(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cbq_deactivate_class(cl);
-}
-
-static unsigned long cbq_find(struct Qdisc *sch, u32 classid)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	return (unsigned long)cbq_class_lookup(q, classid);
-}
-
-static void cbq_destroy_class(struct Qdisc *sch, struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	WARN_ON(cl->filters);
-
-	tcf_block_put(cl->block);
-	qdisc_put(cl->q);
-	qdisc_put_rtab(cl->R_tab);
-	gen_kill_estimator(&cl->rate_est);
-	if (cl != &q->link)
-		kfree(cl);
-}
-
-static void cbq_destroy(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct hlist_node *next;
-	struct cbq_class *cl;
-	unsigned int h;
-
-#ifdef CONFIG_NET_CLS_ACT
-	q->rx_class = NULL;
-#endif
-	/*
-	 * Filters must be destroyed first because we don't destroy the
-	 * classes from root to leafs which means that filters can still
-	 * be bound to classes which have been destroyed already. --TGR '04
-	 */
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			tcf_block_put(cl->block);
-			cl->block = NULL;
-		}
-	}
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[h],
-					  common.hnode)
-			cbq_destroy_class(sch, cl);
-	}
-	qdisc_class_hash_destroy(&q->clhash);
-}
-
-static int
-cbq_change_class(struct Qdisc *sch, u32 classid, u32 parentid, struct nlattr **tca,
-		 unsigned long *arg, struct netlink_ext_ack *extack)
-{
-	int err;
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)*arg;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_CBQ_MAX + 1];
-	struct cbq_class *parent;
-	struct qdisc_rate_table *rtab = NULL;
-
-	err = cbq_opt_parse(tb, opt, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_CBQ_OVL_STRATEGY] || tb[TCA_CBQ_POLICE]) {
-		NL_SET_ERR_MSG(extack, "Neither overlimit strategy nor policing attributes can be used for changing class params");
-		return -EOPNOTSUPP;
-	}
-
-	if (cl) {
-		/* Check parent */
-		if (parentid) {
-			if (cl->tparent &&
-			    cl->tparent->common.classid != parentid) {
-				NL_SET_ERR_MSG(extack, "Invalid parent id");
-				return -EINVAL;
-			}
-			if (!cl->tparent && parentid != TC_H_ROOT) {
-				NL_SET_ERR_MSG(extack, "Parent must be root");
-				return -EINVAL;
-			}
-		}
-
-		if (tb[TCA_CBQ_RATE]) {
-			rtab = qdisc_get_rtab(nla_data(tb[TCA_CBQ_RATE]),
-					      tb[TCA_CBQ_RTAB], extack);
-			if (rtab == NULL)
-				return -EINVAL;
-		}
-
-		if (tca[TCA_RATE]) {
-			err = gen_replace_estimator(&cl->bstats, NULL,
-						    &cl->rate_est,
-						    NULL,
-						    qdisc_root_sleeping_running(sch),
-						    tca[TCA_RATE]);
-			if (err) {
-				NL_SET_ERR_MSG(extack, "Failed to replace specified rate estimator");
-				qdisc_put_rtab(rtab);
-				return err;
-			}
-		}
-
-		/* Change class parameters */
-		sch_tree_lock(sch);
-
-		if (cl->next_alive != NULL)
-			cbq_deactivate_class(cl);
-
-		if (rtab) {
-			qdisc_put_rtab(cl->R_tab);
-			cl->R_tab = rtab;
-		}
-
-		if (tb[TCA_CBQ_LSSOPT])
-			cbq_set_lss(cl, nla_data(tb[TCA_CBQ_LSSOPT]));
-
-		if (tb[TCA_CBQ_WRROPT]) {
-			cbq_rmprio(q, cl);
-			cbq_set_wrr(cl, nla_data(tb[TCA_CBQ_WRROPT]));
-		}
-
-		if (tb[TCA_CBQ_FOPT])
-			cbq_set_fopt(cl, nla_data(tb[TCA_CBQ_FOPT]));
-
-		if (cl->q->q.qlen)
-			cbq_activate_class(cl);
-
-		sch_tree_unlock(sch);
-
-		return 0;
-	}
-
-	if (parentid == TC_H_ROOT)
-		return -EINVAL;
-
-	if (!tb[TCA_CBQ_WRROPT] || !tb[TCA_CBQ_RATE] || !tb[TCA_CBQ_LSSOPT]) {
-		NL_SET_ERR_MSG(extack, "One of the following attributes MUST be specified: WRR, rate or link sharing");
-		return -EINVAL;
-	}
-
-	rtab = qdisc_get_rtab(nla_data(tb[TCA_CBQ_RATE]), tb[TCA_CBQ_RTAB],
-			      extack);
-	if (rtab == NULL)
-		return -EINVAL;
-
-	if (classid) {
-		err = -EINVAL;
-		if (TC_H_MAJ(classid ^ sch->handle) ||
-		    cbq_class_lookup(q, classid)) {
-			NL_SET_ERR_MSG(extack, "Specified class not found");
-			goto failure;
-		}
-	} else {
-		int i;
-		classid = TC_H_MAKE(sch->handle, 0x8000);
-
-		for (i = 0; i < 0x8000; i++) {
-			if (++q->hgenerator >= 0x8000)
-				q->hgenerator = 1;
-			if (cbq_class_lookup(q, classid|q->hgenerator) == NULL)
-				break;
-		}
-		err = -ENOSR;
-		if (i >= 0x8000) {
-			NL_SET_ERR_MSG(extack, "Unable to generate classid");
-			goto failure;
-		}
-		classid = classid|q->hgenerator;
-	}
-
-	parent = &q->link;
-	if (parentid) {
-		parent = cbq_class_lookup(q, parentid);
-		err = -EINVAL;
-		if (!parent) {
-			NL_SET_ERR_MSG(extack, "Failed to find parentid");
-			goto failure;
-		}
-	}
-
-	err = -ENOBUFS;
-	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
-	if (cl == NULL)
-		goto failure;
-
-	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
-	if (err) {
-		kfree(cl);
-		goto failure;
-	}
-
-	if (tca[TCA_RATE]) {
-		err = gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
-		if (err) {
-			NL_SET_ERR_MSG(extack, "Couldn't create new estimator");
-			tcf_block_put(cl->block);
-			kfree(cl);
-			goto failure;
-		}
-	}
-
-	cl->R_tab = rtab;
-	rtab = NULL;
-	cl->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				  NULL);
-	if (!cl->q)
-		cl->q = &noop_qdisc;
-	else
-		qdisc_hash_add(cl->q, true);
-
-	cl->common.classid = classid;
-	cl->tparent = parent;
-	cl->qdisc = sch;
-	cl->allot = parent->allot;
-	cl->quantum = cl->allot;
-	cl->weight = cl->R_tab->rate.rate;
-
-	sch_tree_lock(sch);
-	cbq_link_class(cl);
-	cl->borrow = cl->tparent;
-	if (cl->tparent != &q->link)
-		cl->share = cl->tparent;
-	cbq_adjust_levels(parent);
-	cl->minidle = -0x7FFFFFFF;
-	cbq_set_lss(cl, nla_data(tb[TCA_CBQ_LSSOPT]));
-	cbq_set_wrr(cl, nla_data(tb[TCA_CBQ_WRROPT]));
-	if (cl->ewma_log == 0)
-		cl->ewma_log = q->link.ewma_log;
-	if (cl->maxidle == 0)
-		cl->maxidle = q->link.maxidle;
-	if (cl->avpkt == 0)
-		cl->avpkt = q->link.avpkt;
-	if (tb[TCA_CBQ_FOPT])
-		cbq_set_fopt(cl, nla_data(tb[TCA_CBQ_FOPT]));
-	sch_tree_unlock(sch);
-
-	qdisc_class_hash_grow(sch, &q->clhash);
-
-	*arg = (unsigned long)cl;
-	return 0;
-
-failure:
-	qdisc_put_rtab(rtab);
-	return err;
-}
-
-static int cbq_delete(struct Qdisc *sch, unsigned long arg,
-		      struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (cl->filters || cl->children || cl == &q->link)
-		return -EBUSY;
-
-	sch_tree_lock(sch);
-
-	qdisc_purge_queue(cl->q);
-
-	if (cl->next_alive)
-		cbq_deactivate_class(cl);
-
-	if (q->tx_borrowed == cl)
-		q->tx_borrowed = q->tx_class;
-	if (q->tx_class == cl) {
-		q->tx_class = NULL;
-		q->tx_borrowed = NULL;
-	}
-#ifdef CONFIG_NET_CLS_ACT
-	if (q->rx_class == cl)
-		q->rx_class = NULL;
-#endif
-
-	cbq_unlink_class(cl);
-	cbq_adjust_levels(cl->tparent);
-	cl->defmap = 0;
-	cbq_sync_defmap(cl);
-
-	cbq_rmprio(q, cl);
-	sch_tree_unlock(sch);
-
-	cbq_destroy_class(sch, cl);
-	return 0;
-}
-
-static struct tcf_block *cbq_tcf_block(struct Qdisc *sch, unsigned long arg,
-				       struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (cl == NULL)
-		cl = &q->link;
-
-	return cl->block;
-}
-
-static unsigned long cbq_bind_filter(struct Qdisc *sch, unsigned long parent,
-				     u32 classid)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *p = (struct cbq_class *)parent;
-	struct cbq_class *cl = cbq_class_lookup(q, classid);
-
-	if (cl) {
-		if (p && p->level <= cl->level)
-			return 0;
-		cl->filters++;
-		return (unsigned long)cl;
-	}
-	return 0;
-}
-
-static void cbq_unbind_filter(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cl->filters--;
-}
-
-static void cbq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl;
-	unsigned int h;
-
-	if (arg->stop)
-		return;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			if (arg->count < arg->skip) {
-				arg->count++;
-				continue;
-			}
-			if (arg->fn(sch, (unsigned long)cl, arg) < 0) {
-				arg->stop = 1;
-				return;
-			}
-			arg->count++;
-		}
-	}
-}
-
-static const struct Qdisc_class_ops cbq_class_ops = {
-	.graft		=	cbq_graft,
-	.leaf		=	cbq_leaf,
-	.qlen_notify	=	cbq_qlen_notify,
-	.find		=	cbq_find,
-	.change		=	cbq_change_class,
-	.delete		=	cbq_delete,
-	.walk		=	cbq_walk,
-	.tcf_block	=	cbq_tcf_block,
-	.bind_tcf	=	cbq_bind_filter,
-	.unbind_tcf	=	cbq_unbind_filter,
-	.dump		=	cbq_dump_class,
-	.dump_stats	=	cbq_dump_class_stats,
-};
-
-static struct Qdisc_ops cbq_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&cbq_class_ops,
-	.id		=	"cbq",
-	.priv_size	=	sizeof(struct cbq_sched_data),
-	.enqueue	=	cbq_enqueue,
-	.dequeue	=	cbq_dequeue,
-	.peek		=	qdisc_peek_dequeued,
-	.init		=	cbq_init,
-	.reset		=	cbq_reset,
-	.destroy	=	cbq_destroy,
-	.change		=	NULL,
-	.dump		=	cbq_dump,
-	.dump_stats	=	cbq_dump_stats,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init cbq_module_init(void)
-{
-	return register_qdisc(&cbq_qdisc_ops);
-}
-static void __exit cbq_module_exit(void)
-{
-	unregister_qdisc(&cbq_qdisc_ops);
-}
-module_init(cbq_module_init)
-module_exit(cbq_module_exit)
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_dsmark.c b/net/sched/sch_dsmark.c
deleted file mode 100644
index 7da6dc38a382..000000000000
--- a/net/sched/sch_dsmark.c
+++ /dev/null
@@ -1,522 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* net/sched/sch_dsmark.c - Differentiated Services field marker */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/rtnetlink.h>
-#include <linux/bitops.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-#include <net/dsfield.h>
-#include <net/inet_ecn.h>
-#include <asm/byteorder.h>
-
-/*
- * classid	class		marking
- * -------	-----		-------
- *   n/a	  0		n/a
- *   x:0	  1		use entry [0]
- *   ...	 ...		...
- *   x:y y>0	 y+1		use entry [y]
- *   ...	 ...		...
- * x:indices-1	indices		use entry [indices-1]
- *   ...	 ...		...
- *   x:y	 y+1		use entry [y & (indices-1)]
- *   ...	 ...		...
- * 0xffff	0x10000		use entry [indices-1]
- */
-
-
-#define NO_DEFAULT_INDEX	(1 << 16)
-
-struct mask_value {
-	u8			mask;
-	u8			value;
-};
-
-struct dsmark_qdisc_data {
-	struct Qdisc		*q;
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct mask_value	*mv;
-	u16			indices;
-	u8			set_tc_index;
-	u32			default_index;	/* index range is 0...0xffff */
-#define DSMARK_EMBEDDED_SZ	16
-	struct mask_value	embedded[DSMARK_EMBEDDED_SZ];
-};
-
-static inline int dsmark_valid_index(struct dsmark_qdisc_data *p, u16 index)
-{
-	return index <= p->indices && index > 0;
-}
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static int dsmark_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p],new %p,old %p)\n",
-		 __func__, sch, p, new, old);
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					sch->handle, NULL);
-		if (new == NULL)
-			new = &noop_qdisc;
-	}
-
-	*old = qdisc_replace(sch, new, &p->q);
-	return 0;
-}
-
-static struct Qdisc *dsmark_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	return p->q;
-}
-
-static unsigned long dsmark_find(struct Qdisc *sch, u32 classid)
-{
-	return TC_H_MIN(classid) + 1;
-}
-
-static unsigned long dsmark_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n",
-		 __func__, sch, qdisc_priv(sch), classid);
-
-	return dsmark_find(sch, classid);
-}
-
-static void dsmark_unbind_filter(struct Qdisc *sch, unsigned long cl)
-{
-}
-
-static const struct nla_policy dsmark_policy[TCA_DSMARK_MAX + 1] = {
-	[TCA_DSMARK_INDICES]		= { .type = NLA_U16 },
-	[TCA_DSMARK_DEFAULT_INDEX]	= { .type = NLA_U16 },
-	[TCA_DSMARK_SET_TC_INDEX]	= { .type = NLA_FLAG },
-	[TCA_DSMARK_MASK]		= { .type = NLA_U8 },
-	[TCA_DSMARK_VALUE]		= { .type = NLA_U8 },
-};
-
-static int dsmark_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x,parent %x), arg 0x%lx\n",
-		 __func__, sch, p, classid, parent, *arg);
-
-	if (!dsmark_valid_index(p, *arg)) {
-		err = -ENOENT;
-		goto errout;
-	}
-
-	if (!opt)
-		goto errout;
-
-	err = nla_parse_nested_deprecated(tb, TCA_DSMARK_MAX, opt,
-					  dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	if (tb[TCA_DSMARK_VALUE])
-		p->mv[*arg - 1].value = nla_get_u8(tb[TCA_DSMARK_VALUE]);
-
-	if (tb[TCA_DSMARK_MASK])
-		p->mv[*arg - 1].mask = nla_get_u8(tb[TCA_DSMARK_MASK]);
-
-	err = 0;
-
-errout:
-	return err;
-}
-
-static int dsmark_delete(struct Qdisc *sch, unsigned long arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	if (!dsmark_valid_index(p, arg))
-		return -EINVAL;
-
-	p->mv[arg - 1].mask = 0xff;
-	p->mv[arg - 1].value = 0;
-
-	return 0;
-}
-
-static void dsmark_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],walker %p)\n",
-		 __func__, sch, p, walker);
-
-	if (walker->stop)
-		return;
-
-	for (i = 0; i < p->indices; i++) {
-		if (p->mv[i].mask == 0xff && !p->mv[i].value)
-			goto ignore;
-		if (walker->count >= walker->skip) {
-			if (walker->fn(sch, i + 1, walker) < 0) {
-				walker->stop = 1;
-				break;
-			}
-		}
-ignore:
-		walker->count++;
-	}
-}
-
-static struct tcf_block *dsmark_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	return p->block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int dsmark_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	unsigned int len = qdisc_pkt_len(skb);
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("%s(skb %p,sch %p,[qdisc %p])\n", __func__, skb, sch, p);
-
-	if (p->set_tc_index) {
-		int wlen = skb_network_offset(skb);
-
-		switch (skb_protocol(skb, true)) {
-		case htons(ETH_P_IP):
-			wlen += sizeof(struct iphdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv4_get_dsfield(ip_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-
-		case htons(ETH_P_IPV6):
-			wlen += sizeof(struct ipv6hdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv6_get_dsfield(ipv6_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-		default:
-			skb->tc_index = 0;
-			break;
-		}
-	}
-
-	if (TC_H_MAJ(skb->priority) == sch->handle)
-		skb->tc_index = TC_H_MIN(skb->priority);
-	else {
-		struct tcf_result res;
-		struct tcf_proto *fl = rcu_dereference_bh(p->filter_list);
-		int result = tcf_classify(skb, NULL, fl, &res, false);
-
-		pr_debug("result %d class 0x%04x\n", result, res.classid);
-
-		switch (result) {
-#ifdef CONFIG_NET_CLS_ACT
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-
-		case TC_ACT_SHOT:
-			goto drop;
-#endif
-		case TC_ACT_OK:
-			skb->tc_index = TC_H_MIN(res.classid);
-			break;
-
-		default:
-			if (p->default_index != NO_DEFAULT_INDEX)
-				skb->tc_index = p->default_index;
-			break;
-		}
-	}
-
-	err = qdisc_enqueue(skb, p->q, to_free);
-	if (err != NET_XMIT_SUCCESS) {
-		if (net_xmit_drop_count(err))
-			qdisc_qstats_drop(sch);
-		return err;
-	}
-
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
-	return NET_XMIT_SUCCESS;
-
-drop:
-	qdisc_drop(skb, sch, to_free);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-static struct sk_buff *dsmark_dequeue(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-	u32 index;
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	skb = qdisc_dequeue_peeked(p->q);
-	if (skb == NULL)
-		return NULL;
-
-	qdisc_bstats_update(sch, skb);
-	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
-
-	index = skb->tc_index & (p->indices - 1);
-	pr_debug("index %d->%d\n", skb->tc_index, index);
-
-	switch (skb_protocol(skb, true)) {
-	case htons(ETH_P_IP):
-		ipv4_change_dsfield(ip_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	case htons(ETH_P_IPV6):
-		ipv6_change_dsfield(ipv6_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	default:
-		/*
-		 * Only complain if a change was actually attempted.
-		 * This way, we can send non-IP traffic through dsmark
-		 * and don't need yet another qdisc as a bypass.
-		 */
-		if (p->mv[index].mask != 0xff || p->mv[index].value)
-			pr_warn("%s: unsupported protocol %d\n",
-				__func__, ntohs(skb_protocol(skb, true)));
-		break;
-	}
-
-	return skb;
-}
-
-static struct sk_buff *dsmark_peek(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	return p->q->ops->peek(p->q);
-}
-
-static int dsmark_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-	u32 default_index = NO_DEFAULT_INDEX;
-	u16 indices;
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],opt %p)\n", __func__, sch, p, opt);
-
-	if (!opt)
-		goto errout;
-
-	err = tcf_block_get(&p->block, &p->filter_list, sch, extack);
-	if (err)
-		return err;
-
-	err = nla_parse_nested_deprecated(tb, TCA_DSMARK_MAX, opt,
-					  dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	err = -EINVAL;
-	if (!tb[TCA_DSMARK_INDICES])
-		goto errout;
-	indices = nla_get_u16(tb[TCA_DSMARK_INDICES]);
-
-	if (hweight32(indices) != 1)
-		goto errout;
-
-	if (tb[TCA_DSMARK_DEFAULT_INDEX])
-		default_index = nla_get_u16(tb[TCA_DSMARK_DEFAULT_INDEX]);
-
-	if (indices <= DSMARK_EMBEDDED_SZ)
-		p->mv = p->embedded;
-	else
-		p->mv = kmalloc_array(indices, sizeof(*p->mv), GFP_KERNEL);
-	if (!p->mv) {
-		err = -ENOMEM;
-		goto errout;
-	}
-	for (i = 0; i < indices; i++) {
-		p->mv[i].mask = 0xff;
-		p->mv[i].value = 0;
-	}
-	p->indices = indices;
-	p->default_index = default_index;
-	p->set_tc_index = nla_get_flag(tb[TCA_DSMARK_SET_TC_INDEX]);
-
-	p->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, sch->handle,
-				 NULL);
-	if (p->q == NULL)
-		p->q = &noop_qdisc;
-	else
-		qdisc_hash_add(p->q, true);
-
-	pr_debug("%s: qdisc %p\n", __func__, p->q);
-
-	err = 0;
-errout:
-	return err;
-}
-
-static void dsmark_reset(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-	if (p->q)
-		qdisc_reset(p->q);
-}
-
-static void dsmark_destroy(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	tcf_block_put(p->block);
-	qdisc_put(p->q);
-	if (p->mv != p->embedded)
-		kfree(p->mv);
-}
-
-static int dsmark_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	pr_debug("%s(sch %p,[qdisc %p],class %ld\n", __func__, sch, p, cl);
-
-	if (!dsmark_valid_index(p, cl))
-		return -EINVAL;
-
-	tcm->tcm_handle = TC_H_MAKE(TC_H_MAJ(sch->handle), cl - 1);
-	tcm->tcm_info = p->q->handle;
-
-	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u8(skb, TCA_DSMARK_MASK, p->mv[cl - 1].mask) ||
-	    nla_put_u8(skb, TCA_DSMARK_VALUE, p->mv[cl - 1].value))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static int dsmark_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u16(skb, TCA_DSMARK_INDICES, p->indices))
-		goto nla_put_failure;
-
-	if (p->default_index != NO_DEFAULT_INDEX &&
-	    nla_put_u16(skb, TCA_DSMARK_DEFAULT_INDEX, p->default_index))
-		goto nla_put_failure;
-
-	if (p->set_tc_index &&
-	    nla_put_flag(skb, TCA_DSMARK_SET_TC_INDEX))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static const struct Qdisc_class_ops dsmark_class_ops = {
-	.graft		=	dsmark_graft,
-	.leaf		=	dsmark_leaf,
-	.find		=	dsmark_find,
-	.change		=	dsmark_change,
-	.delete		=	dsmark_delete,
-	.walk		=	dsmark_walk,
-	.tcf_block	=	dsmark_tcf_block,
-	.bind_tcf	=	dsmark_bind_filter,
-	.unbind_tcf	=	dsmark_unbind_filter,
-	.dump		=	dsmark_dump_class,
-};
-
-static struct Qdisc_ops dsmark_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&dsmark_class_ops,
-	.id		=	"dsmark",
-	.priv_size	=	sizeof(struct dsmark_qdisc_data),
-	.enqueue	=	dsmark_enqueue,
-	.dequeue	=	dsmark_dequeue,
-	.peek		=	dsmark_peek,
-	.init		=	dsmark_init,
-	.reset		=	dsmark_reset,
-	.destroy	=	dsmark_destroy,
-	.change		=	NULL,
-	.dump		=	dsmark_dump,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init dsmark_module_init(void)
-{
-	return register_qdisc(&dsmark_qdisc_ops);
-}
-
-static void __exit dsmark_module_exit(void)
-{
-	unregister_qdisc(&dsmark_qdisc_ops);
-}
-
-module_init(dsmark_module_init)
-module_exit(dsmark_module_exit)
-
-MODULE_LICENSE("GPL");
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 20b8ba4d1dfc..79ea1ab34570 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -805,7 +805,7 @@ static void tls_update(struct sock *sk, struct proto *p,
 	}
 }
 
-static int tls_get_info(const struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9ff3e4df2d6c..e6f700f67c01 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1755,6 +1755,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct sk_psock *psock;
+	int num_async, pending;
 	unsigned char control = 0;
 	ssize_t decrypted = 0;
 	struct strp_msg *rxm;
@@ -1767,8 +1768,6 @@ int tls_sw_recvmsg(struct sock *sk,
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool is_peek = flags & MSG_PEEK;
 	bool bpf_strp_enabled;
-	int num_async = 0;
-	int pending;
 
 	flags |= nonblock;
 
@@ -1785,17 +1784,18 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0) {
 		tls_err_abort(sk, err);
 		goto end;
-	} else {
-		copied = err;
 	}
 
-	if (len <= copied)
-		goto recv_end;
+	copied = err;
+	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA))
+		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	len = len - copied;
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
+	decrypted = 0;
+	num_async = 0;
 	while (len && (decrypted + copied < target || ctx->recv_pkt)) {
 		bool retain_skb = false;
 		bool zc = false;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 82b93380afec..4a8b701440eb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3737,6 +3737,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index fe8765c4075d..8a4b85f96a13 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -799,6 +799,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
 		}
 	}
 
+	/* Sanity-check to ensure we never end up _allocating_ zero
+	 * bytes of data for extra.
+	 */
+	if (extra_size <= 0)
+		return -EFAULT;
+
 	/* kzalloc() ensures NULL-termination for essid_compat. */
 	extra = kzalloc(extra_size, GFP_KERNEL);
 	if (!extra)
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 00ac7b79cddb..7772c6424089 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -369,7 +369,7 @@ eBPF programs can have an associated license, passed along with the bytecode
 instructions to the kernel when the programs are loaded. The format for that
 string is identical to the one in use for kernel modules (Dual licenses, such
 as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
-programs that are compatible with the GNU Privacy License (GPL).
+programs that are compatible with the GNU General Public License (GNU GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
 license string passed (via **attr**) to the **bpf**\ () system call, and this
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index a10949bf0ca1..dd8d13f3fd12 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -464,6 +464,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun50i-h6-spdif",
 		.data = &sun50i_h6_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-spdif",
+		/* Essentially the same as the H6, but without RX */
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index ccca9efa7d33..970e14ff54d1 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -328,8 +328,16 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			if (chip->quirk_flags & QUIRK_FLAG_SKIP_CLOCK_SELECTOR)
 				return ret;
 			err = uac_clock_selector_set_val(chip, entity_id, cur);
-			if (err < 0)
+			if (err < 0) {
+				if (pins == 1) {
+					usb_audio_dbg(chip,
+						      "%s(): selector returned an error, "
+						      "assuming a firmware bug, id %d, ret %d\n",
+						      __func__, clock_id, err);
+					return ret;
+				}
 				return err;
+			}
 		}
 
 		if (!validate || ret > 0 || !chip->autoclock)
diff --git a/sound/usb/format.c b/sound/usb/format.c
index ab5fed9f55b6..3b45d0ee7693 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -470,9 +470,11 @@ static int validate_sample_rate_table_v2v3(struct snd_usb_audio *chip,
 					   int clock)
 {
 	struct usb_device *dev = chip->dev;
+	struct usb_host_interface *alts;
 	unsigned int *table;
 	unsigned int nr_rates;
 	int i, err;
+	u32 bmControls;
 
 	/* performing the rate verification may lead to unexpected USB bus
 	 * behavior afterwards by some unknown reason.  Do this only for the
@@ -481,6 +483,24 @@ static int validate_sample_rate_table_v2v3(struct snd_usb_audio *chip,
 	if (!(chip->quirk_flags & QUIRK_FLAG_VALIDATE_RATES))
 		return 0; /* don't perform the validation as default */
 
+	alts = snd_usb_get_host_interface(chip, fp->iface, fp->altsetting);
+	if (!alts)
+		return 0;
+
+	if (fp->protocol == UAC_VERSION_3) {
+		struct uac3_as_header_descriptor *as = snd_usb_find_csint_desc(
+				alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
+		bmControls = le32_to_cpu(as->bmControls);
+	} else {
+		struct uac2_as_header_descriptor *as = snd_usb_find_csint_desc(
+				alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
+		bmControls = as->bmControls;
+	}
+
+	if (!uac_v2v3_control_is_readable(bmControls,
+				UAC2_AS_VAL_ALT_SETTINGS))
+		return 0;
+
 	table = kcalloc(fp->nr_rates, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 9f4428be3e36..a756b29afcc2 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -27,7 +27,8 @@
 #define FSCRYPT_MODE_AES_128_CBC		5
 #define FSCRYPT_MODE_AES_128_CTS		6
 #define FSCRYPT_MODE_ADIANTUM			9
-/* If adding a mode number > 9, update FSCRYPT_MODE_MAX in fscrypt_private.h */
+#define FSCRYPT_MODE_AES_256_HCTR2		10
+/* If adding a mode number > 10, update FSCRYPT_MODE_MAX in fscrypt_private.h */
 
 /*
  * Legacy policy version; ad-hoc KDF and no key verification.
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 041d6032a348..8ef26d89ef49 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -364,6 +364,8 @@ struct ucred {
 #define SOL_KCM		281
 #define SOL_TLS		282
 #define SOL_XDP		283
+#define SOL_MPTCP	284
+#define SOL_MCTP	285
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/tools/testing/selftests/net/vrf-xfrm-tests.sh b/tools/testing/selftests/net/vrf-xfrm-tests.sh
index 184da81f554f..452638ae8aed 100755
--- a/tools/testing/selftests/net/vrf-xfrm-tests.sh
+++ b/tools/testing/selftests/net/vrf-xfrm-tests.sh
@@ -264,60 +264,60 @@ setup_xfrm()
 	ip -netns host1 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4} ${devarg}
 
 	ip -netns host2 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4}
 
 
 	ip -netns host1 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4} ${devarg}
 
 	ip -netns host2 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4}
 
 
 	ip -6 -netns host1 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6} ${devarg}
 
 	ip -6 -netns host2 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6}
 
 
 	ip -6 -netns host1 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6} ${devarg}
 
 	ip -6 -netns host2 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6}
 }
 
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index a4beb719d217..8b877167933d 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -30,7 +30,6 @@
 #define READ                    0
 #define WRITE                   1
 
-typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
 typedef unsigned int __wsum;
@@ -137,6 +136,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #endif
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
+#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
index 9348957be56e..e11c6aece734 100644
--- a/tools/virtio/linux/vringh.h
+++ b/tools/virtio/linux/vringh.h
@@ -1 +1,2 @@
+#include <limits.h>
 #include "../../../include/linux/vringh.h"

