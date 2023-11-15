Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7D7E547F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbjKHKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbjKHKtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:49:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF226AB;
        Wed,  8 Nov 2023 02:46:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652AEC433C9;
        Wed,  8 Nov 2023 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699440385;
        bh=eUAUuByxMk3wplm+uX83r2rlnwZEBxMJ2S4EP66LWOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOQ5tyxQr8SwNXxxRNCe8p2jbRtMLn1hDFgzlL/MDYm25EpqAlSPvoVsousbqZmMm
         veU47wabi/G7HEUfzMbNR1Iq2Qs4PlryMPJJlePxH4nroR5TPnJrHT79Z/3TmtHC3J
         5lYlWTTeC9qoyRVpa/r78qTFOhQreQiNaRSDjuws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.260
Date:   Wed,  8 Nov 2023 11:46:09 +0100
Message-ID: <2023110809-blaming-scaling-c6ef@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023110808-grandly-hertz-6680@gregkh>
References: <2023110808-grandly-hertz-6680@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index b30442d90389..24dc30cd2472 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 259
+SUBLEVEL = 260
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index ee84155844ad..ed235f263e29 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -381,7 +381,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
+	ti,non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
index dd932220a8bf..91f93bc89716 100644
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -22,7 +22,6 @@
 	pinctrl-0 = <&emmc_pins>;
 	bus-width = <8>;
 	status = "okay";
-	non-removable;
 };
 
 &am33xx_pinmux {
diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index e07dd7979586..3124d94c0b3c 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -75,6 +75,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 30b62de86b5b..2f6652ef9a15 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -389,6 +389,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 609c8db687ec..4092cd193b8a 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -75,6 +75,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index af25b42e85f4..a00145705c9b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -782,7 +782,8 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wlan_pins>;
-	non-removable;
+	ti,non-removable;
+	ti,needs-special-hs-handling;
 	cap-power-off-card;
 	keep-power-in-suspend;
 
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 7805b0618a4f..e28a5b82fdf3 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -700,7 +700,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
+	ti,non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
 	keep-power-in-suspend;
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index c3bfd8ed5f88..a8005e975ea2 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -361,7 +361,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 7749122dad71..671d4a5da9c4 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -176,7 +176,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	pinctrl-0 = <&mmc1_pins_default>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index 66a5c09ff388..783d411f2cef 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -473,7 +473,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	pinctrl-0 = <&mmc2_pins_default>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 03852eff2b3c..e7764ecdf65f 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -341,7 +341,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&ldo3_reg>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -351,7 +351,7 @@
 	pinctrl-0 = <&wireless_pins>;
 	vmmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
-	non-removable;
+	ti,non-removable;
 	dmas = <&edma_xbar 12 0 1
 		&edma_xbar 13 0 2>;
 	dma-names = "tx", "rx";
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 7e46b4c02709..3d0672b53d77 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -69,7 +69,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmc_reg>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index cacd564b4d28..8ec6c4500fd5 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1333,8 +1333,10 @@
 			ranges = <0x0 0x60000 0x1000>;
 
 			mmc1: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
+				ti,dual-volt;
 				ti,needs-special-reset;
+				ti,needs-special-hs-handling;
 				dmas = <&edma 24 0>, <&edma 25 0>;
 				dma-names = "tx", "rx";
 				interrupts = <64>;
@@ -1824,7 +1826,7 @@
 			ranges = <0x0 0xd8000 0x1000>;
 
 			mmc2: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				dmas = <&edma 2 0
 					&edma 3 0>;
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index efe36f395bdd..77fa7c0f2104 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -259,11 +259,10 @@
 			ranges = <0x0 0x47810000 0x1000>;
 
 			mmc3: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				interrupts = <29>;
 				reg = <0x0 0x1000>;
-				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c5b67993743d..14bbc438055f 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -250,11 +250,10 @@
 			ranges = <0x0 0x47810000 0x1000>;
 
 			mmc3: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x0 0x1000>;
-				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index a6b4fca8626a..063113a5da2d 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -291,7 +291,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmc_3v3>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &spi0 {
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 448853701d3d..126965a34841 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -872,7 +872,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&emmc_pins_default>;
 	pinctrl-1 = <&emmc_pins_sleep>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -889,7 +889,7 @@
 	pinctrl-1 = <&mmc3_pins_sleep>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	non-removable;
+	ti,non-removable;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index 8c9e7e723fc9..64fdd5079d49 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -1104,8 +1104,9 @@
 			ranges = <0x0 0x60000 0x1000>;
 
 			mmc1: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				reg = <0x0 0x1000>;
+				ti,dual-volt;
 				ti,needs-special-reset;
 				dmas = <&edma 24 0>,
 					<&edma 25 0>;
@@ -1640,7 +1641,7 @@
 			ranges = <0x0 0xd8000 0x1000>;
 
 			mmc2: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				reg = <0x0 0x1000>;
 				ti,needs-special-reset;
 				dmas = <&edma 2 0>,
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 292153c6cb5d..74eaa6a3b258 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -694,7 +694,7 @@
 	pinctrl-1 = <&mmc3_pins_sleep>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	non-removable;
+	ti,non-removable;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index fbf66e0973aa..12b545f7fb32 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -208,10 +208,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 				  loff_t *ppos)
 {
 	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
+	struct insn_emulation *insn;
+	enum insn_emulation_mode prev_mode;
 
 	mutex_lock(&insn_emulation_mutex);
+	insn = container_of(table->data, struct insn_emulation, current_mode);
+	prev_mode = insn->current_mode;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write || prev_mode == insn->current_mode)
diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 89789e8c80f6..e16574c16e93 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -67,6 +67,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ed8ec011a9fd..e832082b2761 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -94,27 +94,16 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within
- * the file, and somewhat descriptive.  The size is in bytes.  Must be
- * used at file scope.
+ * Reserve space in the .brk section, which is a block of memory from which the
+ * caller is allowed to allocate very early (before even memblock is available)
+ * by calling extend_brk().  All allocated memory will be eventually converted
+ * to memblock.  Any leftover unallocated memory will be freed.
  *
- * (This uses a temp function to wrap the asm so we can pass it the
- * size parameter; otherwise we wouldn't be able to.  We can't use a
- * "section" attribute on a normal variable because it always ends up
- * being @progbits, which ends up allocating space in the vmlinux
- * executable.)
+ * The size is in bytes.
  */
-#define RESERVE_BRK(name,sz)						\
-	static void __section(.discard.text) __used notrace		\
-	__brk_reservation_fn_##name##__(void) {				\
-		asm volatile (						\
-			".pushsection .brk_reservation,\"aw\",@nobits;" \
-			".brk." #name ":"				\
-			" 1:.skip %c0;"					\
-			" .size .brk." #name ", . - 1b;"		\
-			" .popsection"					\
-			: : "i" (sz));					\
-	}
+#define RESERVE_BRK(name, size)					\
+	__section(.bss..brk) __aligned(1) __used	\
+	static char __brk_##name[size]
 
 /* Helper for reserving space for arrays of things */
 #define RESERVE_BRK_ARRAY(type, name, entries)		\
@@ -132,12 +121,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .bss..brk, "aw"
+SYM_DATA_START(__brk_\name)
+	.skip \size
+SYM_DATA_END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7b75658b7e9a..a5e41e66fcbd 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -140,6 +140,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 		       madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	default_acpi_madt_oem_check(madt->header.oem_id,
 				    madt->header.oem_table_id);
 
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 8821d0ab0a08..82753622f489 100644
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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7e0e21082c93..09506e492f1d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -383,7 +383,7 @@ SECTIONS
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit = .;
 	}
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0d7631580150..36dac58b5c41 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -24,6 +24,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bits.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -54,12 +55,12 @@ enum {
 	AHCI_PORT_PRIV_FBS_DMA_SZ	= AHCI_CMD_SLOT_SZ +
 					  AHCI_CMD_TBL_AR_SZ +
 					  (AHCI_RX_FIS_SZ * 16),
-	AHCI_IRQ_ON_SG		= (1 << 31),
-	AHCI_CMD_ATAPI		= (1 << 5),
-	AHCI_CMD_WRITE		= (1 << 6),
-	AHCI_CMD_PREFETCH	= (1 << 7),
-	AHCI_CMD_RESET		= (1 << 8),
-	AHCI_CMD_CLR_BUSY	= (1 << 10),
+	AHCI_IRQ_ON_SG		= BIT(31),
+	AHCI_CMD_ATAPI		= BIT(5),
+	AHCI_CMD_WRITE		= BIT(6),
+	AHCI_CMD_PREFETCH	= BIT(7),
+	AHCI_CMD_RESET		= BIT(8),
+	AHCI_CMD_CLR_BUSY	= BIT(10),
 
 	RX_FIS_PIO_SETUP	= 0x20,	/* offset of PIO Setup FIS data */
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
@@ -77,37 +78,37 @@ enum {
 	HOST_CAP2		= 0x24, /* host capabilities, extended */
 
 	/* HOST_CTL bits */
-	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
-	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
-	HOST_MRSM		= (1 << 2),  /* MSI Revert to Single Message */
-	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+	HOST_RESET		= BIT(0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= BIT(1),  /* global IRQ enable */
+	HOST_MRSM		= BIT(2),  /* MSI Revert to Single Message */
+	HOST_AHCI_EN		= BIT(31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
-	HOST_CAP_SXS		= (1 << 5),  /* Supports External SATA */
-	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
-	HOST_CAP_CCC		= (1 << 7),  /* Command Completion Coalescing */
-	HOST_CAP_PART		= (1 << 13), /* Partial state capable */
-	HOST_CAP_SSC		= (1 << 14), /* Slumber state capable */
-	HOST_CAP_PIO_MULTI	= (1 << 15), /* PIO multiple DRQ support */
-	HOST_CAP_FBS		= (1 << 16), /* FIS-based switching support */
-	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
-	HOST_CAP_ONLY		= (1 << 18), /* Supports AHCI mode only */
-	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
-	HOST_CAP_LED		= (1 << 25), /* Supports activity LED */
-	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
-	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
-	HOST_CAP_MPS		= (1 << 28), /* Mechanical presence switch */
-	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
-	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
-	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_SXS		= BIT(5),  /* Supports External SATA */
+	HOST_CAP_EMS		= BIT(6),  /* Enclosure Management support */
+	HOST_CAP_CCC		= BIT(7),  /* Command Completion Coalescing */
+	HOST_CAP_PART		= BIT(13), /* Partial state capable */
+	HOST_CAP_SSC		= BIT(14), /* Slumber state capable */
+	HOST_CAP_PIO_MULTI	= BIT(15), /* PIO multiple DRQ support */
+	HOST_CAP_FBS		= BIT(16), /* FIS-based switching support */
+	HOST_CAP_PMP		= BIT(17), /* Port Multiplier support */
+	HOST_CAP_ONLY		= BIT(18), /* Supports AHCI mode only */
+	HOST_CAP_CLO		= BIT(24), /* Command List Override support */
+	HOST_CAP_LED		= BIT(25), /* Supports activity LED */
+	HOST_CAP_ALPM		= BIT(26), /* Aggressive Link PM support */
+	HOST_CAP_SSS		= BIT(27), /* Staggered Spin-up */
+	HOST_CAP_MPS		= BIT(28), /* Mechanical presence switch */
+	HOST_CAP_SNTF		= BIT(29), /* SNotification register */
+	HOST_CAP_NCQ		= BIT(30), /* Native Command Queueing */
+	HOST_CAP_64		= BIT(31), /* PCI DAC (64-bit DMA) support */
 
 	/* HOST_CAP2 bits */
-	HOST_CAP2_BOH		= (1 << 0),  /* BIOS/OS handoff supported */
-	HOST_CAP2_NVMHCI	= (1 << 1),  /* NVMHCI supported */
-	HOST_CAP2_APST		= (1 << 2),  /* Automatic partial to slumber */
-	HOST_CAP2_SDS		= (1 << 3),  /* Support device sleep */
-	HOST_CAP2_SADM		= (1 << 4),  /* Support aggressive DevSlp */
-	HOST_CAP2_DESO		= (1 << 5),  /* DevSlp from slumber only */
+	HOST_CAP2_BOH		= BIT(0),  /* BIOS/OS handoff supported */
+	HOST_CAP2_NVMHCI	= BIT(1),  /* NVMHCI supported */
+	HOST_CAP2_APST		= BIT(2),  /* Automatic partial to slumber */
+	HOST_CAP2_SDS		= BIT(3),  /* Support device sleep */
+	HOST_CAP2_SADM		= BIT(4),  /* Support aggressive DevSlp */
+	HOST_CAP2_DESO		= BIT(5),  /* DevSlp from slumber only */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -129,24 +130,24 @@ enum {
 	PORT_DEVSLP		= 0x44, /* device sleep */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
-	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
-	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
-	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
-	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
-	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
-	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
-	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
-	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
-
-	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
-	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
-	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
-	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
-	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
-	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
-	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
-	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+	PORT_IRQ_COLD_PRES	= BIT(31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= BIT(30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= BIT(29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= BIT(28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= BIT(27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= BIT(26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= BIT(24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= BIT(23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= BIT(22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= BIT(7),  /* device interlock */
+	PORT_IRQ_CONNECT	= BIT(6),  /* port connect change status */
+	PORT_IRQ_SG_DONE	= BIT(5),  /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= BIT(4),  /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= BIT(3),  /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= BIT(2),  /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= BIT(1),  /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= BIT(0),  /* D2H Register FIS rx'd */
 
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
@@ -162,34 +163,34 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
-	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
-	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
-	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
-	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
-	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
-	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
-	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
-	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
-	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
-	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
-	PORT_CMD_CLO		= (1 << 3), /* Command list override */
-	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
-	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
-	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
-
-	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
-	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
-	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
-	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ASP		= BIT(27), /* Aggressive Slumber/Partial */
+	PORT_CMD_ALPE		= BIT(26), /* Aggressive Link PM enable */
+	PORT_CMD_ATAPI		= BIT(24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= BIT(22), /* FBS Capable Port */
+	PORT_CMD_ESP		= BIT(21), /* External Sata Port */
+	PORT_CMD_HPCP		= BIT(18), /* HotPlug Capable Port */
+	PORT_CMD_PMP		= BIT(17), /* PMP attached */
+	PORT_CMD_LIST_ON	= BIT(15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= BIT(14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= BIT(4),  /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= BIT(3),  /* Command list override */
+	PORT_CMD_POWER_ON	= BIT(2),  /* Power up device */
+	PORT_CMD_SPIN_UP	= BIT(1),  /* Spin up device */
+	PORT_CMD_START		= BIT(0),  /* Enable port DMA engine */
+
+	PORT_CMD_ICC_MASK	= (0xfu << 28), /* i/f ICC state mask */
+	PORT_CMD_ICC_ACTIVE	= (0x1u << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2u << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6u << 28), /* Put i/f in slumber state */
 
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
 	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
-	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
-	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
-	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
+	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
+	PORT_FBS_EN		= BIT(0), /* Enable FBS */
 
 	/* PORT_DEVSLP bits */
 	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
@@ -197,52 +198,52 @@ enum {
 	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
 	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
 	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
-	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
-	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
+	PORT_DEVSLP_DSP		= BIT(1),         /* DevSlp present */
+	PORT_DEVSLP_ADSE	= BIT(0),         /* Aggressive DevSlp enable */
 
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
 
-	AHCI_HFLAG_NO_NCQ		= (1 << 0),
-	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
-	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
-	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
-	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
-	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
-	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
-	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
-	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
-	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
-	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= (1 << 11), /* treat SRST timeout as
-							link offline */
-	AHCI_HFLAG_NO_SNTF		= (1 << 12), /* no sntf */
-	AHCI_HFLAG_NO_FPDMA_AA		= (1 << 13), /* no FPDMA AA */
-	AHCI_HFLAG_YES_FBS		= (1 << 14), /* force FBS cap on */
-	AHCI_HFLAG_DELAY_ENGINE		= (1 << 15), /* do not start engine on
-						        port start (wait until
-						        error-handling stage) */
-	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
-	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
+	AHCI_HFLAG_NO_NCQ		= BIT(0),
+	AHCI_HFLAG_IGN_IRQ_IF_ERR	= BIT(1), /* ignore IRQ_IF_ERR */
+	AHCI_HFLAG_IGN_SERR_INTERNAL	= BIT(2), /* ignore SERR_INTERNAL */
+	AHCI_HFLAG_32BIT_ONLY		= BIT(3), /* force 32bit */
+	AHCI_HFLAG_MV_PATA		= BIT(4), /* PATA port */
+	AHCI_HFLAG_NO_MSI		= BIT(5), /* no PCI MSI */
+	AHCI_HFLAG_NO_PMP		= BIT(6), /* no PMP */
+	AHCI_HFLAG_SECT255		= BIT(8), /* max 255 sectors */
+	AHCI_HFLAG_YES_NCQ		= BIT(9), /* force NCQ cap on */
+	AHCI_HFLAG_NO_SUSPEND		= BIT(10), /* don't suspend */
+	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= BIT(11), /* treat SRST timeout as
+						      link offline */
+	AHCI_HFLAG_NO_SNTF		= BIT(12), /* no sntf */
+	AHCI_HFLAG_NO_FPDMA_AA		= BIT(13), /* no FPDMA AA */
+	AHCI_HFLAG_YES_FBS		= BIT(14), /* force FBS cap on */
+	AHCI_HFLAG_DELAY_ENGINE		= BIT(15), /* do not start engine on
+						      port start (wait until
+						      error-handling stage) */
+	AHCI_HFLAG_NO_DEVSLP		= BIT(17), /* no device sleep */
+	AHCI_HFLAG_NO_FBS		= BIT(18), /* no FBS */
 
 #ifdef CONFIG_PCI_MSI
-	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* per-port MSI(-X) */
+	AHCI_HFLAG_MULTI_MSI		= BIT(20), /* per-port MSI(-X) */
 #else
 	/* compile out MSI infrastructure */
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
-	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
-	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
-	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
-							only registers */
-	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
-							SATA_MOBILE_LPM_POLICY
-							as default lpm_policy */
-	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
-							suspend/resume */
-	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
-							from phy_power_on() */
-	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= BIT(22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= BIT(23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= BIT(24), /* don't write to read
+						      only registers */
+	AHCI_HFLAG_IS_MOBILE            = BIT(25), /* mobile chipset, use
+						      SATA_MOBILE_LPM_POLICY
+						      as default lpm_policy */
+	AHCI_HFLAG_SUSPEND_PHYS		= BIT(26), /* handle PHYs during
+						      suspend/resume */
+	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
+						      from phy_power_on() */
+	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
 
 	/* ap->flags bits */
 
@@ -258,22 +259,22 @@ enum {
 	EM_MAX_RETRY			= 5,
 
 	/* em_ctl bits */
-	EM_CTL_RST		= (1 << 9), /* Reset */
-	EM_CTL_TM		= (1 << 8), /* Transmit Message */
-	EM_CTL_MR		= (1 << 0), /* Message Received */
-	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
-	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
-	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
-	EM_CTL_SGPIO		= (1 << 19), /* SGPIO messages supported */
-	EM_CTL_SES		= (1 << 18), /* SES-2 messages supported */
-	EM_CTL_SAFTE		= (1 << 17), /* SAF-TE messages supported */
-	EM_CTL_LED		= (1 << 16), /* LED messages supported */
+	EM_CTL_RST		= BIT(9), /* Reset */
+	EM_CTL_TM		= BIT(8), /* Transmit Message */
+	EM_CTL_MR		= BIT(0), /* Message Received */
+	EM_CTL_ALHD		= BIT(26), /* Activity LED */
+	EM_CTL_XMT		= BIT(25), /* Transmit Only */
+	EM_CTL_SMB		= BIT(24), /* Single Message Buffer */
+	EM_CTL_SGPIO		= BIT(19), /* SGPIO messages supported */
+	EM_CTL_SES		= BIT(18), /* SES-2 messages supported */
+	EM_CTL_SAFTE		= BIT(17), /* SAF-TE messages supported */
+	EM_CTL_LED		= BIT(16), /* LED messages supported */
 
 	/* em message type */
-	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
-	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
-	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
-	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */
+	EM_MSG_TYPE_LED		= BIT(0), /* LED */
+	EM_MSG_TYPE_SAFTE	= BIT(1), /* SAF-TE */
+	EM_MSG_TYPE_SES2	= BIT(2), /* SES-2 */
+	EM_MSG_TYPE_SGPIO	= BIT(3), /* SGPIO */
 };
 
 struct ahci_cmd_hdr {
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 4e5ca632f35e..ef14566a4971 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -29,6 +29,75 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+/**
+ * driver_set_override() - Helper to set or clear driver override.
+ * @dev: Device to change
+ * @override: Address of string to change (e.g. &device->driver_override);
+ *            The contents will be freed and hold newly allocated override.
+ * @s: NUL-terminated string, new driver name to force a match, pass empty
+ *     string to clear it ("" or "\n", where the latter is only for sysfs
+ *     interface).
+ * @len: length of @s
+ *
+ * Helper to set or clear driver override in a device, intended for the cases
+ * when the driver_override field is allocated by driver/bus code.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len)
+{
+	const char *new, *old;
+	char *cp;
+
+	if (!override || !s)
+		return -EINVAL;
+
+	/*
+	 * The stored value will be used in sysfs show callback (sysfs_emit()),
+	 * which has a length limit of PAGE_SIZE and adds a trailing newline.
+	 * Thus we can store one character less to avoid truncation during sysfs
+	 * show.
+	 */
+	if (len >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (!len) {
+		/* Empty string passed - clear override */
+		device_lock(dev);
+		old = *override;
+		*override = NULL;
+		device_unlock(dev);
+		kfree(old);
+
+		return 0;
+	}
+
+	cp = strnchr(s, len, '\n');
+	if (cp)
+		len = cp - s;
+
+	new = kstrndup(s, len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	device_lock(dev);
+	old = *override;
+	if (cp != s) {
+		*override = new;
+	} else {
+		/* "\n" passed - clear override */
+		kfree(new);
+		*override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(driver_set_override);
+
 /**
  * driver_for_each_device - Iterator for devices bound to a driver.
  * @drv: Driver we're iterating.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 75623b914b8c..0ed43d185a90 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -973,31 +973,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 8a08cbb958d1..c867211f5ed7 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -299,15 +299,6 @@ config BLK_DEV_SKD
 
 	Use device /dev/skd$N amd /dev/skd$Np$M.
 
-config BLK_DEV_SX8
-	tristate "Promise SATA SX8 support"
-	depends on PCI
-	---help---
-	  Saying Y or M here will enable support for the 
-	  Promise SATA SX8 controllers.
-
-	  Use devices /dev/sx8/$N and /dev/sx8/$Np$M.
-
 config BLK_DEV_RAM
 	tristate "RAM block device support"
 	---help---
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a53cc1e3a2d3..d8f2f72c3b62 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -26,8 +26,6 @@ obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
-obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
-
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
 obj-$(CONFIG_XEN_BLKDEV_BACKEND)	+= xen-blkback/
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd/
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
deleted file mode 100644
index 4478eb7efee0..000000000000
--- a/drivers/block/sx8.c
+++ /dev/null
@@ -1,1586 +0,0 @@
-/*
- *  sx8.c: Driver for Promise SATA SX8 looks-like-I2O hardware
- *
- *  Copyright 2004-2005 Red Hat, Inc.
- *
- *  Author/maintainer:  Jeff Garzik <jgarzik@pobox.com>
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file "COPYING" in the main directory of this archive
- *  for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/blk-mq.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/ktime.h>
-#include <linux/hdreg.h>
-#include <linux/dma-mapping.h>
-#include <linux/completion.h>
-#include <linux/scatterlist.h>
-#include <asm/io.h>
-#include <linux/uaccess.h>
-
-#if 0
-#define CARM_DEBUG
-#define CARM_VERBOSE_DEBUG
-#else
-#undef CARM_DEBUG
-#undef CARM_VERBOSE_DEBUG
-#endif
-#undef CARM_NDEBUG
-
-#define DRV_NAME "sx8"
-#define DRV_VERSION "1.0"
-#define PFX DRV_NAME ": "
-
-MODULE_AUTHOR("Jeff Garzik");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Promise SATA SX8 block driver");
-MODULE_VERSION(DRV_VERSION);
-
-/*
- * SX8 hardware has a single message queue for all ATA ports.
- * When this driver was written, the hardware (firmware?) would
- * corrupt data eventually, if more than one request was outstanding.
- * As one can imagine, having 8 ports bottlenecking on a single
- * command hurts performance.
- *
- * Based on user reports, later versions of the hardware (firmware?)
- * seem to be able to survive with more than one command queued.
- *
- * Therefore, we default to the safe option -- 1 command -- but
- * allow the user to increase this.
- *
- * SX8 should be able to support up to ~60 queued commands (CARM_MAX_REQ),
- * but problems seem to occur when you exceed ~30, even on newer hardware.
- */
-static int max_queue = 1;
-module_param(max_queue, int, 0444);
-MODULE_PARM_DESC(max_queue, "Maximum number of queued commands. (min==1, max==30, safe==1)");
-
-
-#define NEXT_RESP(idx)	((idx + 1) % RMSG_Q_LEN)
-
-/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
-#define TAG_ENCODE(tag)	(((tag) << 16) | 0xf)
-#define TAG_DECODE(tag)	(((tag) >> 16) & 0x1f)
-#define TAG_VALID(tag)	((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32))
-
-/* note: prints function name for you */
-#ifdef CARM_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#ifdef CARM_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_VERBOSE_DEBUG */
-#else
-#define DPRINTK(fmt, args...)
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_DEBUG */
-
-#ifdef CARM_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(unlikely(!(expr))) {                                   \
-        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
-	#expr, __FILE__, __func__, __LINE__);          \
-        }
-#endif
-
-/* defines only for the constants which don't work well as enums */
-struct carm_host;
-
-enum {
-	/* adapter-wide limits */
-	CARM_MAX_PORTS		= 8,
-	CARM_SHM_SIZE		= (4096 << 7),
-	CARM_MINORS_PER_MAJOR	= 256 / CARM_MAX_PORTS,
-	CARM_MAX_WAIT_Q		= CARM_MAX_PORTS + 1,
-
-	/* command message queue limits */
-	CARM_MAX_REQ		= 64,	       /* max command msgs per host */
-	CARM_MSG_LOW_WATER	= (CARM_MAX_REQ / 4),	     /* refill mark */
-
-	/* S/G limits, host-wide and per-request */
-	CARM_MAX_REQ_SG		= 32,	     /* max s/g entries per request */
-	CARM_MAX_HOST_SG	= 600,		/* max s/g entries per host */
-	CARM_SG_LOW_WATER	= (CARM_MAX_HOST_SG / 4),   /* re-fill mark */
-
-	/* hardware registers */
-	CARM_IHQP		= 0x1c,
-	CARM_INT_STAT		= 0x10, /* interrupt status */
-	CARM_INT_MASK		= 0x14, /* interrupt mask */
-	CARM_HMUC		= 0x18, /* host message unit control */
-	RBUF_ADDR_LO		= 0x20, /* response msg DMA buf low 32 bits */
-	RBUF_ADDR_HI		= 0x24, /* response msg DMA buf high 32 bits */
-	RBUF_BYTE_SZ		= 0x28,
-	CARM_RESP_IDX		= 0x2c,
-	CARM_CMS0		= 0x30, /* command message size reg 0 */
-	CARM_LMUC		= 0x48,
-	CARM_HMPHA		= 0x6c,
-	CARM_INITC		= 0xb5,
-
-	/* bits in CARM_INT_{STAT,MASK} */
-	INT_RESERVED		= 0xfffffff0,
-	INT_WATCHDOG		= (1 << 3),	/* watchdog timer */
-	INT_Q_OVERFLOW		= (1 << 2),	/* cmd msg q overflow */
-	INT_Q_AVAILABLE		= (1 << 1),	/* cmd msg q has free space */
-	INT_RESPONSE		= (1 << 0),	/* response msg available */
-	INT_ACK_MASK		= INT_WATCHDOG | INT_Q_OVERFLOW,
-	INT_DEF_MASK		= INT_RESERVED | INT_Q_OVERFLOW |
-				  INT_RESPONSE,
-
-	/* command messages, and related register bits */
-	CARM_HAVE_RESP		= 0x01,
-	CARM_MSG_READ		= 1,
-	CARM_MSG_WRITE		= 2,
-	CARM_MSG_VERIFY		= 3,
-	CARM_MSG_GET_CAPACITY	= 4,
-	CARM_MSG_FLUSH		= 5,
-	CARM_MSG_IOCTL		= 6,
-	CARM_MSG_ARRAY		= 8,
-	CARM_MSG_MISC		= 9,
-	CARM_CME		= (1 << 2),
-	CARM_RME		= (1 << 1),
-	CARM_WZBC		= (1 << 0),
-	CARM_RMI		= (1 << 0),
-	CARM_Q_FULL		= (1 << 3),
-	CARM_MSG_SIZE		= 288,
-	CARM_Q_LEN		= 48,
-
-	/* CARM_MSG_IOCTL messages */
-	CARM_IOC_SCAN_CHAN	= 5,	/* scan channels for devices */
-	CARM_IOC_GET_TCQ	= 13,	/* get tcq/ncq depth */
-	CARM_IOC_SET_TCQ	= 14,	/* set tcq/ncq depth */
-
-	IOC_SCAN_CHAN_NODEV	= 0x1f,
-	IOC_SCAN_CHAN_OFFSET	= 0x40,
-
-	/* CARM_MSG_ARRAY messages */
-	CARM_ARRAY_INFO		= 0,
-
-	ARRAY_NO_EXIST		= (1 << 31),
-
-	/* response messages */
-	RMSG_SZ			= 8,	/* sizeof(struct carm_response) */
-	RMSG_Q_LEN		= 48,	/* resp. msg list length */
-	RMSG_OK			= 1,	/* bit indicating msg was successful */
-					/* length of entire resp. msg buffer */
-	RBUF_LEN		= RMSG_SZ * RMSG_Q_LEN,
-
-	PDC_SHM_SIZE		= (4096 << 7), /* length of entire h/w buffer */
-
-	/* CARM_MSG_MISC messages */
-	MISC_GET_FW_VER		= 2,
-	MISC_ALLOC_MEM		= 3,
-	MISC_SET_TIME		= 5,
-
-	/* MISC_GET_FW_VER feature bits */
-	FW_VER_4PORT		= (1 << 2), /* 1=4 ports, 0=8 ports */
-	FW_VER_NON_RAID		= (1 << 1), /* 1=non-RAID firmware, 0=RAID */
-	FW_VER_ZCR		= (1 << 0), /* zero channel RAID (whatever that is) */
-
-	/* carm_host flags */
-	FL_NON_RAID		= FW_VER_NON_RAID,
-	FL_4PORT		= FW_VER_4PORT,
-	FL_FW_VER_MASK		= (FW_VER_NON_RAID | FW_VER_4PORT),
-	FL_DYN_MAJOR		= (1 << 17),
-};
-
-enum {
-	CARM_SG_BOUNDARY	= 0xffffUL,	    /* s/g segment boundary */
-};
-
-enum scatter_gather_types {
-	SGT_32BIT		= 0,
-	SGT_64BIT		= 1,
-};
-
-enum host_states {
-	HST_INVALID,		/* invalid state; never used */
-	HST_ALLOC_BUF,		/* setting up master SHM area */
-	HST_ERROR,		/* we never leave here */
-	HST_PORT_SCAN,		/* start dev scan */
-	HST_DEV_SCAN_START,	/* start per-device probe */
-	HST_DEV_SCAN,		/* continue per-device probe */
-	HST_DEV_ACTIVATE,	/* activate devices we found */
-	HST_PROBE_FINISHED,	/* probe is complete */
-	HST_PROBE_START,	/* initiate probe */
-	HST_SYNC_TIME,		/* tell firmware what time it is */
-	HST_GET_FW_VER,		/* get firmware version, adapter port cnt */
-};
-
-#ifdef CARM_DEBUG
-static const char *state_name[] = {
-	"HST_INVALID",
-	"HST_ALLOC_BUF",
-	"HST_ERROR",
-	"HST_PORT_SCAN",
-	"HST_DEV_SCAN_START",
-	"HST_DEV_SCAN",
-	"HST_DEV_ACTIVATE",
-	"HST_PROBE_FINISHED",
-	"HST_PROBE_START",
-	"HST_SYNC_TIME",
-	"HST_GET_FW_VER",
-};
-#endif
-
-struct carm_port {
-	unsigned int			port_no;
-	struct gendisk			*disk;
-	struct carm_host		*host;
-
-	/* attached device characteristics */
-	u64				capacity;
-	char				name[41];
-	u16				dev_geom_head;
-	u16				dev_geom_sect;
-	u16				dev_geom_cyl;
-};
-
-struct carm_request {
-	int				n_elem;
-	unsigned int			msg_type;
-	unsigned int			msg_subtype;
-	unsigned int			msg_bucket;
-	struct scatterlist		sg[CARM_MAX_REQ_SG];
-};
-
-struct carm_host {
-	unsigned long			flags;
-	void				__iomem *mmio;
-	void				*shm;
-	dma_addr_t			shm_dma;
-
-	int				major;
-	int				id;
-	char				name[32];
-
-	spinlock_t			lock;
-	struct pci_dev			*pdev;
-	unsigned int			state;
-	u32				fw_ver;
-
-	struct blk_mq_tag_set		tag_set;
-	struct request_queue		*oob_q;
-	unsigned int			n_oob;
-
-	unsigned int			hw_sg_used;
-
-	unsigned int			resp_idx;
-
-	unsigned int			wait_q_prod;
-	unsigned int			wait_q_cons;
-	struct request_queue		*wait_q[CARM_MAX_WAIT_Q];
-
-	void				*msg_base;
-	dma_addr_t			msg_dma;
-
-	int				cur_scan_dev;
-	unsigned long			dev_active;
-	unsigned long			dev_present;
-	struct carm_port		port[CARM_MAX_PORTS];
-
-	struct work_struct		fsm_task;
-
-	struct completion		probe_comp;
-};
-
-struct carm_response {
-	__le32 ret_handle;
-	__le32 status;
-}  __attribute__((packed));
-
-struct carm_msg_sg {
-	__le32 start;
-	__le32 len;
-}  __attribute__((packed));
-
-struct carm_msg_rw {
-	u8 type;
-	u8 id;
-	u8 sg_count;
-	u8 sg_type;
-	__le32 handle;
-	__le32 lba;
-	__le16 lba_count;
-	__le16 lba_high;
-	struct carm_msg_sg sg[32];
-}  __attribute__((packed));
-
-struct carm_msg_allocbuf {
-	u8 type;
-	u8 subtype;
-	u8 n_sg;
-	u8 sg_type;
-	__le32 handle;
-	__le32 addr;
-	__le32 len;
-	__le32 evt_pool;
-	__le32 n_evt;
-	__le32 rbuf_pool;
-	__le32 n_rbuf;
-	__le32 msg_pool;
-	__le32 n_msg;
-	struct carm_msg_sg sg[8];
-}  __attribute__((packed));
-
-struct carm_msg_ioctl {
-	u8 type;
-	u8 subtype;
-	u8 array_id;
-	u8 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_msg_sync_time {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	u32 reserved2;
-	__le32 timestamp;
-}  __attribute__((packed));
-
-struct carm_msg_get_fw_ver {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_fw_ver {
-	__le32 version;
-	u8 features;
-	u8 reserved1;
-	u16 reserved2;
-}  __attribute__((packed));
-
-struct carm_array_info {
-	__le32 size;
-
-	__le16 size_hi;
-	__le16 stripe_size;
-
-	__le32 mode;
-
-	__le16 stripe_blk_sz;
-	__le16 reserved1;
-
-	__le16 cyl;
-	__le16 head;
-
-	__le16 sect;
-	u8 array_id;
-	u8 reserved2;
-
-	char name[40];
-
-	__le32 array_status;
-
-	/* device list continues beyond this point? */
-}  __attribute__((packed));
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void carm_remove_one (struct pci_dev *pdev);
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo);
-
-static const struct pci_device_id carm_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x8000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ }	/* terminate list */
-};
-MODULE_DEVICE_TABLE(pci, carm_pci_tbl);
-
-static struct pci_driver carm_driver = {
-	.name		= DRV_NAME,
-	.id_table	= carm_pci_tbl,
-	.probe		= carm_init_one,
-	.remove		= carm_remove_one,
-};
-
-static const struct block_device_operations carm_bd_ops = {
-	.owner		= THIS_MODULE,
-	.getgeo		= carm_bdev_getgeo,
-};
-
-static unsigned int carm_host_id;
-static unsigned long carm_major_alloc;
-
-
-
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-{
-	struct carm_port *port = bdev->bd_disk->private_data;
-
-	geo->heads = (u8) port->dev_geom_head;
-	geo->sectors = (u8) port->dev_geom_sect;
-	geo->cylinders = port->dev_geom_cyl;
-	return 0;
-}
-
-static const u32 msg_sizes[] = { 32, 64, 128, CARM_MSG_SIZE };
-
-static inline int carm_lookup_bucket(u32 msg_size)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		if (msg_size <= msg_sizes[i])
-			return i;
-
-	return -ENOENT;
-}
-
-static void carm_init_buckets(void __iomem *mmio)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		writel(msg_sizes[i], mmio + CARM_CMS0 + (4 * i));
-}
-
-static inline void *carm_ref_msg(struct carm_host *host,
-				 unsigned int msg_idx)
-{
-	return host->msg_base + (msg_idx * CARM_MSG_SIZE);
-}
-
-static inline dma_addr_t carm_ref_msg_dma(struct carm_host *host,
-					  unsigned int msg_idx)
-{
-	return host->msg_dma + (msg_idx * CARM_MSG_SIZE);
-}
-
-static int carm_send_msg(struct carm_host *host,
-			 struct carm_request *crq, unsigned tag)
-{
-	void __iomem *mmio = host->mmio;
-	u32 msg = (u32) carm_ref_msg_dma(host, tag);
-	u32 cm_bucket = crq->msg_bucket;
-	u32 tmp;
-	int rc = 0;
-
-	VPRINTK("ENTER\n");
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_Q_FULL) {
-#if 0
-		tmp = readl(mmio + CARM_INT_MASK);
-		tmp |= INT_Q_AVAILABLE;
-		writel(tmp, mmio + CARM_INT_MASK);
-		readl(mmio + CARM_INT_MASK);	/* flush */
-#endif
-		DPRINTK("host msg queue full\n");
-		rc = -EBUSY;
-	} else {
-		writel(msg | (cm_bucket << 1), mmio + CARM_IHQP);
-		readl(mmio + CARM_IHQP);	/* flush */
-	}
-
-	return rc;
-}
-
-static int carm_array_info (struct carm_host *host, unsigned int array_idx)
-{
-	struct carm_msg_ioctl *ioc;
-	u32 msg_data;
-	dma_addr_t msg_dma;
-	struct carm_request *crq;
-	struct request *rq;
-	int rc;
-
-	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq)) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-	crq = blk_mq_rq_to_pdu(rq);
-
-	ioc = carm_ref_msg(host, rq->tag);
-	msg_dma = carm_ref_msg_dma(host, rq->tag);
-	msg_data = (u32) (msg_dma + sizeof(struct carm_array_info));
-
-	crq->msg_type = CARM_MSG_ARRAY;
-	crq->msg_subtype = CARM_ARRAY_INFO;
-	rc = carm_lookup_bucket(sizeof(struct carm_msg_ioctl) +
-				sizeof(struct carm_array_info));
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_ARRAY;
-	ioc->subtype	= CARM_ARRAY_INFO;
-	ioc->array_id	= (u8) array_idx;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_DEV_SCAN_START ||
-	       host->state == HST_DEV_SCAN);
-	spin_unlock_irq(&host->lock);
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
-
-	return 0;
-
-err_out:
-	spin_lock_irq(&host->lock);
-	host->state = HST_ERROR;
-	spin_unlock_irq(&host->lock);
-	return rc;
-}
-
-typedef unsigned int (*carm_sspc_t)(struct carm_host *, unsigned int, void *);
-
-static int carm_send_special (struct carm_host *host, carm_sspc_t func)
-{
-	struct request *rq;
-	struct carm_request *crq;
-	struct carm_msg_ioctl *ioc;
-	void *mem;
-	unsigned int msg_size;
-	int rc;
-
-	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq))
-		return -ENOMEM;
-	crq = blk_mq_rq_to_pdu(rq);
-
-	mem = carm_ref_msg(host, rq->tag);
-
-	msg_size = func(host, rq->tag, mem);
-
-	ioc = mem;
-	crq->msg_type = ioc->type;
-	crq->msg_subtype = ioc->subtype;
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
-
-	return 0;
-}
-
-static unsigned int carm_fill_sync_time(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_sync_time *st = mem;
-
-	time64_t tv = ktime_get_real_seconds();
-
-	memset(st, 0, sizeof(*st));
-	st->type	= CARM_MSG_MISC;
-	st->subtype	= MISC_SET_TIME;
-	st->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	st->timestamp	= cpu_to_le32(tv);
-
-	return sizeof(struct carm_msg_sync_time);
-}
-
-static unsigned int carm_fill_alloc_buf(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_allocbuf *ab = mem;
-
-	memset(ab, 0, sizeof(*ab));
-	ab->type	= CARM_MSG_MISC;
-	ab->subtype	= MISC_ALLOC_MEM;
-	ab->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ab->n_sg	= 1;
-	ab->sg_type	= SGT_32BIT;
-	ab->addr	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->len		= cpu_to_le32(PDC_SHM_SIZE >> 1);
-	ab->evt_pool	= cpu_to_le32(host->shm_dma + (16 * 1024));
-	ab->n_evt	= cpu_to_le32(1024);
-	ab->rbuf_pool	= cpu_to_le32(host->shm_dma);
-	ab->n_rbuf	= cpu_to_le32(RMSG_Q_LEN);
-	ab->msg_pool	= cpu_to_le32(host->shm_dma + RBUF_LEN);
-	ab->n_msg	= cpu_to_le32(CARM_Q_LEN);
-	ab->sg[0].start	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->sg[0].len	= cpu_to_le32(65536);
-
-	return sizeof(struct carm_msg_allocbuf);
-}
-
-static unsigned int carm_fill_scan_channels(struct carm_host *host,
-					    unsigned int idx, void *mem)
-{
-	struct carm_msg_ioctl *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) +
-			      IOC_SCAN_CHAN_OFFSET);
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_IOCTL;
-	ioc->subtype	= CARM_IOC_SCAN_CHAN;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	/* fill output data area with "no device" default values */
-	mem += IOC_SCAN_CHAN_OFFSET;
-	memset(mem, IOC_SCAN_CHAN_NODEV, CARM_MAX_PORTS);
-
-	return IOC_SCAN_CHAN_OFFSET + CARM_MAX_PORTS;
-}
-
-static unsigned int carm_fill_get_fw_ver(struct carm_host *host,
-					 unsigned int idx, void *mem)
-{
-	struct carm_msg_get_fw_ver *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) + sizeof(*ioc));
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_MISC;
-	ioc->subtype	= MISC_GET_FW_VER;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	return sizeof(struct carm_msg_get_fw_ver) +
-	       sizeof(struct carm_fw_ver);
-}
-
-static inline void carm_push_q (struct carm_host *host, struct request_queue *q)
-{
-	unsigned int idx = host->wait_q_prod % CARM_MAX_WAIT_Q;
-
-	blk_mq_stop_hw_queues(q);
-	VPRINTK("STOPPED QUEUE %p\n", q);
-
-	host->wait_q[idx] = q;
-	host->wait_q_prod++;
-	BUG_ON(host->wait_q_prod == host->wait_q_cons); /* overrun */
-}
-
-static inline struct request_queue *carm_pop_q(struct carm_host *host)
-{
-	unsigned int idx;
-
-	if (host->wait_q_prod == host->wait_q_cons)
-		return NULL;
-
-	idx = host->wait_q_cons % CARM_MAX_WAIT_Q;
-	host->wait_q_cons++;
-
-	return host->wait_q[idx];
-}
-
-static inline void carm_round_robin(struct carm_host *host)
-{
-	struct request_queue *q = carm_pop_q(host);
-	if (q) {
-		blk_mq_start_hw_queues(q);
-		VPRINTK("STARTED QUEUE %p\n", q);
-	}
-}
-
-static inline enum dma_data_direction carm_rq_dir(struct request *rq)
-{
-	return op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
-}
-
-static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
-				  const struct blk_mq_queue_data *bd)
-{
-	struct request_queue *q = hctx->queue;
-	struct request *rq = bd->rq;
-	struct carm_port *port = q->queuedata;
-	struct carm_host *host = port->host;
-	struct carm_request *crq = blk_mq_rq_to_pdu(rq);
-	struct carm_msg_rw *msg;
-	struct scatterlist *sg;
-	int i, n_elem = 0, rc;
-	unsigned int msg_size;
-	u32 tmp;
-
-	crq->n_elem = 0;
-	sg_init_table(crq->sg, CARM_MAX_REQ_SG);
-
-	blk_mq_start_request(rq);
-
-	spin_lock_irq(&host->lock);
-	if (req_op(rq) == REQ_OP_DRV_OUT)
-		goto send_msg;
-
-	/* get scatterlist from block layer */
-	sg = &crq->sg[0];
-	n_elem = blk_rq_map_sg(q, rq, sg);
-	if (n_elem <= 0)
-		goto out_ioerr;
-
-	/* map scatterlist to PCI bus addresses */
-	n_elem = dma_map_sg(&host->pdev->dev, sg, n_elem, carm_rq_dir(rq));
-	if (n_elem <= 0)
-		goto out_ioerr;
-
-	/* obey global hardware limit on S/G entries */
-	if (host->hw_sg_used >= CARM_MAX_HOST_SG - n_elem)
-		goto out_resource;
-
-	crq->n_elem = n_elem;
-	host->hw_sg_used += n_elem;
-
-	/*
-	 * build read/write message
-	 */
-
-	VPRINTK("build msg\n");
-	msg = (struct carm_msg_rw *) carm_ref_msg(host, rq->tag);
-
-	if (rq_data_dir(rq) == WRITE) {
-		msg->type = CARM_MSG_WRITE;
-		crq->msg_type = CARM_MSG_WRITE;
-	} else {
-		msg->type = CARM_MSG_READ;
-		crq->msg_type = CARM_MSG_READ;
-	}
-
-	msg->id		= port->port_no;
-	msg->sg_count	= n_elem;
-	msg->sg_type	= SGT_32BIT;
-	msg->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
-	msg->lba	= cpu_to_le32(blk_rq_pos(rq) & 0xffffffff);
-	tmp		= (blk_rq_pos(rq) >> 16) >> 16;
-	msg->lba_high	= cpu_to_le16( (u16) tmp );
-	msg->lba_count	= cpu_to_le16(blk_rq_sectors(rq));
-
-	msg_size = sizeof(struct carm_msg_rw) - sizeof(msg->sg);
-	for (i = 0; i < n_elem; i++) {
-		struct carm_msg_sg *carm_sg = &msg->sg[i];
-		carm_sg->start = cpu_to_le32(sg_dma_address(&crq->sg[i]));
-		carm_sg->len = cpu_to_le32(sg_dma_len(&crq->sg[i]));
-		msg_size += sizeof(struct carm_msg_sg);
-	}
-
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-send_msg:
-	/*
-	 * queue read/write message to hardware
-	 */
-	VPRINTK("send msg, tag == %u\n", rq->tag);
-	rc = carm_send_msg(host, crq, rq->tag);
-	if (rc) {
-		host->hw_sg_used -= n_elem;
-		goto out_resource;
-	}
-
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_OK;
-out_resource:
-	dma_unmap_sg(&host->pdev->dev, &crq->sg[0], n_elem, carm_rq_dir(rq));
-	carm_push_q(host, q);
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_DEV_RESOURCE;
-out_ioerr:
-	carm_round_robin(host);
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_IOERR;
-}
-
-static void carm_handle_array_info(struct carm_host *host,
-				   struct carm_request *crq, u8 *mem,
-				   blk_status_t error)
-{
-	struct carm_port *port;
-	u8 *msg_data = mem + sizeof(struct carm_array_info);
-	struct carm_array_info *desc = (struct carm_array_info *) msg_data;
-	u64 lo, hi;
-	int cur_port;
-	size_t slen;
-
-	DPRINTK("ENTER\n");
-
-	if (error)
-		goto out;
-	if (le32_to_cpu(desc->array_status) & ARRAY_NO_EXIST)
-		goto out;
-
-	cur_port = host->cur_scan_dev;
-
-	/* should never occur */
-	if ((cur_port < 0) || (cur_port >= CARM_MAX_PORTS)) {
-		printk(KERN_ERR PFX "BUG: cur_scan_dev==%d, array_id==%d\n",
-		       cur_port, (int) desc->array_id);
-		goto out;
-	}
-
-	port = &host->port[cur_port];
-
-	lo = (u64) le32_to_cpu(desc->size);
-	hi = (u64) le16_to_cpu(desc->size_hi);
-
-	port->capacity = lo | (hi << 32);
-	port->dev_geom_head = le16_to_cpu(desc->head);
-	port->dev_geom_sect = le16_to_cpu(desc->sect);
-	port->dev_geom_cyl = le16_to_cpu(desc->cyl);
-
-	host->dev_active |= (1 << cur_port);
-
-	strncpy(port->name, desc->name, sizeof(port->name));
-	port->name[sizeof(port->name) - 1] = 0;
-	slen = strlen(port->name);
-	while (slen && (port->name[slen - 1] == ' ')) {
-		port->name[slen - 1] = 0;
-		slen--;
-	}
-
-	printk(KERN_INFO DRV_NAME "(%s): port %u device %Lu sectors\n",
-	       pci_name(host->pdev), port->port_no,
-	       (unsigned long long) port->capacity);
-	printk(KERN_INFO DRV_NAME "(%s): port %u device \"%s\"\n",
-	       pci_name(host->pdev), port->port_no, port->name);
-
-out:
-	assert(host->state == HST_DEV_SCAN);
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_scan_chan(struct carm_host *host,
-				  struct carm_request *crq, u8 *mem,
-				  blk_status_t error)
-{
-	u8 *msg_data = mem + IOC_SCAN_CHAN_OFFSET;
-	unsigned int i, dev_count = 0;
-	int new_state = HST_DEV_SCAN_START;
-
-	DPRINTK("ENTER\n");
-
-	if (error) {
-		new_state = HST_ERROR;
-		goto out;
-	}
-
-	/* TODO: scan and support non-disk devices */
-	for (i = 0; i < 8; i++)
-		if (msg_data[i] == 0) { /* direct-access device (disk) */
-			host->dev_present |= (1 << i);
-			dev_count++;
-		}
-
-	printk(KERN_INFO DRV_NAME "(%s): found %u interesting devices\n",
-	       pci_name(host->pdev), dev_count);
-
-out:
-	assert(host->state == HST_PORT_SCAN);
-	host->state = new_state;
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_generic(struct carm_host *host,
-				struct carm_request *crq, blk_status_t error,
-				int cur_state, int next_state)
-{
-	DPRINTK("ENTER\n");
-
-	assert(host->state == cur_state);
-	if (error)
-		host->state = HST_ERROR;
-	else
-		host->state = next_state;
-	schedule_work(&host->fsm_task);
-}
-
-static inline void carm_handle_resp(struct carm_host *host,
-				    __le32 ret_handle_le, u32 status)
-{
-	u32 handle = le32_to_cpu(ret_handle_le);
-	unsigned int msg_idx;
-	struct request *rq;
-	struct carm_request *crq;
-	blk_status_t error = (status == RMSG_OK) ? 0 : BLK_STS_IOERR;
-	u8 *mem;
-
-	VPRINTK("ENTER, handle == 0x%x\n", handle);
-
-	if (unlikely(!TAG_VALID(handle))) {
-		printk(KERN_ERR DRV_NAME "(%s): BUG: invalid tag 0x%x\n",
-		       pci_name(host->pdev), handle);
-		return;
-	}
-
-	msg_idx = TAG_DECODE(handle);
-	VPRINTK("tag == %u\n", msg_idx);
-
-	rq = blk_mq_tag_to_rq(host->tag_set.tags[0], msg_idx);
-	crq = blk_mq_rq_to_pdu(rq);
-
-	/* fast path */
-	if (likely(crq->msg_type == CARM_MSG_READ ||
-		   crq->msg_type == CARM_MSG_WRITE)) {
-		dma_unmap_sg(&host->pdev->dev, &crq->sg[0], crq->n_elem,
-			     carm_rq_dir(rq));
-		goto done;
-	}
-
-	mem = carm_ref_msg(host, msg_idx);
-
-	switch (crq->msg_type) {
-	case CARM_MSG_IOCTL: {
-		switch (crq->msg_subtype) {
-		case CARM_IOC_SCAN_CHAN:
-			carm_handle_scan_chan(host, crq, mem, error);
-			goto done;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_MISC: {
-		switch (crq->msg_subtype) {
-		case MISC_ALLOC_MEM:
-			carm_handle_generic(host, crq, error,
-					    HST_ALLOC_BUF, HST_SYNC_TIME);
-			goto done;
-		case MISC_SET_TIME:
-			carm_handle_generic(host, crq, error,
-					    HST_SYNC_TIME, HST_GET_FW_VER);
-			goto done;
-		case MISC_GET_FW_VER: {
-			struct carm_fw_ver *ver = (struct carm_fw_ver *)
-				(mem + sizeof(struct carm_msg_get_fw_ver));
-			if (!error) {
-				host->fw_ver = le32_to_cpu(ver->version);
-				host->flags |= (ver->features & FL_FW_VER_MASK);
-			}
-			carm_handle_generic(host, crq, error,
-					    HST_GET_FW_VER, HST_PORT_SCAN);
-			goto done;
-		}
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_ARRAY: {
-		switch (crq->msg_subtype) {
-		case CARM_ARRAY_INFO:
-			carm_handle_array_info(host, crq, mem, error);
-			break;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	default:
-		/* unknown / invalid response */
-		goto err_out;
-	}
-
-	return;
-
-err_out:
-	printk(KERN_WARNING DRV_NAME "(%s): BUG: unhandled message type %d/%d\n",
-	       pci_name(host->pdev), crq->msg_type, crq->msg_subtype);
-	error = BLK_STS_IOERR;
-done:
-	host->hw_sg_used -= crq->n_elem;
-	blk_mq_end_request(blk_mq_rq_from_pdu(crq), error);
-
-	if (host->hw_sg_used <= CARM_SG_LOW_WATER)
-		carm_round_robin(host);
-}
-
-static inline void carm_handle_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-	unsigned int work = 0;
-	unsigned int idx = host->resp_idx % RMSG_Q_LEN;
-
-	while (1) {
-		u32 status = le32_to_cpu(resp[idx].status);
-
-		if (status == 0xffffffff) {
-			VPRINTK("ending response on index %u\n", idx);
-			writel(idx << 3, mmio + CARM_RESP_IDX);
-			break;
-		}
-
-		/* response to a message we sent */
-		else if ((status & (1 << 31)) == 0) {
-			VPRINTK("handling msg response on index %u\n", idx);
-			carm_handle_resp(host, resp[idx].ret_handle, status);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		/* asynchronous events the hardware throws our way */
-		else if ((status & 0xff000000) == (1 << 31)) {
-			u8 *evt_type_ptr = (u8 *) &resp[idx];
-			u8 evt_type = *evt_type_ptr;
-			printk(KERN_WARNING DRV_NAME "(%s): unhandled event type %d\n",
-			       pci_name(host->pdev), (int) evt_type);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		idx = NEXT_RESP(idx);
-		work++;
-	}
-
-	VPRINTK("EXIT, work==%u\n", work);
-	host->resp_idx += work;
-}
-
-static irqreturn_t carm_interrupt(int irq, void *__host)
-{
-	struct carm_host *host = __host;
-	void __iomem *mmio;
-	u32 mask;
-	int handled = 0;
-	unsigned long flags;
-
-	if (!host) {
-		VPRINTK("no host\n");
-		return IRQ_NONE;
-	}
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	mmio = host->mmio;
-
-	/* reading should also clear interrupts */
-	mask = readl(mmio + CARM_INT_STAT);
-
-	if (mask == 0 || mask == 0xffffffff) {
-		VPRINTK("no work, mask == 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & INT_ACK_MASK)
-		writel(mask, mmio + CARM_INT_STAT);
-
-	if (unlikely(host->state == HST_INVALID)) {
-		VPRINTK("not initialized yet, mask = 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & CARM_HAVE_RESP) {
-		handled = 1;
-		carm_handle_responses(host);
-	}
-
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
-	VPRINTK("EXIT\n");
-	return IRQ_RETVAL(handled);
-}
-
-static void carm_fsm_task (struct work_struct *work)
-{
-	struct carm_host *host =
-		container_of(work, struct carm_host, fsm_task);
-	unsigned long flags;
-	unsigned int state;
-	int rc, i, next_dev;
-	int reschedule = 0;
-	int new_state = HST_INVALID;
-
-	spin_lock_irqsave(&host->lock, flags);
-	state = host->state;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	DPRINTK("ENTER, state == %s\n", state_name[state]);
-
-	switch (state) {
-	case HST_PROBE_START:
-		new_state = HST_ALLOC_BUF;
-		reschedule = 1;
-		break;
-
-	case HST_ALLOC_BUF:
-		rc = carm_send_special(host, carm_fill_alloc_buf);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_SYNC_TIME:
-		rc = carm_send_special(host, carm_fill_sync_time);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_GET_FW_VER:
-		rc = carm_send_special(host, carm_fill_get_fw_ver);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_PORT_SCAN:
-		rc = carm_send_special(host, carm_fill_scan_channels);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_SCAN_START:
-		host->cur_scan_dev = -1;
-		new_state = HST_DEV_SCAN;
-		reschedule = 1;
-		break;
-
-	case HST_DEV_SCAN:
-		next_dev = -1;
-		for (i = host->cur_scan_dev + 1; i < CARM_MAX_PORTS; i++)
-			if (host->dev_present & (1 << i)) {
-				next_dev = i;
-				break;
-			}
-
-		if (next_dev >= 0) {
-			host->cur_scan_dev = next_dev;
-			rc = carm_array_info(host, next_dev);
-			if (rc) {
-				new_state = HST_ERROR;
-				reschedule = 1;
-			}
-		} else {
-			new_state = HST_DEV_ACTIVATE;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_ACTIVATE: {
-		int activated = 0;
-		for (i = 0; i < CARM_MAX_PORTS; i++)
-			if (host->dev_active & (1 << i)) {
-				struct carm_port *port = &host->port[i];
-				struct gendisk *disk = port->disk;
-
-				set_capacity(disk, port->capacity);
-				add_disk(disk);
-				activated++;
-			}
-
-		printk(KERN_INFO DRV_NAME "(%s): %d ports activated\n",
-		       pci_name(host->pdev), activated);
-
-		new_state = HST_PROBE_FINISHED;
-		reschedule = 1;
-		break;
-	}
-
-	case HST_PROBE_FINISHED:
-		complete(&host->probe_comp);
-		break;
-
-	case HST_ERROR:
-		/* FIXME: TODO */
-		break;
-
-	default:
-		/* should never occur */
-		printk(KERN_ERR PFX "BUG: unknown state %d\n", state);
-		assert(0);
-		break;
-	}
-
-	if (new_state != HST_INVALID) {
-		spin_lock_irqsave(&host->lock, flags);
-		host->state = new_state;
-		spin_unlock_irqrestore(&host->lock, flags);
-	}
-	if (reschedule)
-		schedule_work(&host->fsm_task);
-}
-
-static int carm_init_wait(void __iomem *mmio, u32 bits, unsigned int test_bit)
-{
-	unsigned int i;
-
-	for (i = 0; i < 50000; i++) {
-		u32 tmp = readl(mmio + CARM_LMUC);
-		udelay(100);
-
-		if (test_bit) {
-			if ((tmp & bits) == bits)
-				return 0;
-		} else {
-			if ((tmp & bits) == 0)
-				return 0;
-		}
-
-		cond_resched();
-	}
-
-	printk(KERN_ERR PFX "carm_init_wait timeout, bits == 0x%x, test_bit == %s\n",
-	       bits, test_bit ? "yes" : "no");
-	return -EBUSY;
-}
-
-static void carm_init_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	unsigned int i;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-
-	for (i = 0; i < RMSG_Q_LEN; i++)
-		resp[i].status = cpu_to_le32(0xffffffff);
-
-	writel(0, mmio + CARM_RESP_IDX);
-}
-
-static int carm_init_host(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	u32 tmp;
-	u8 tmp8;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	writel(0, mmio + CARM_INT_MASK);
-
-	tmp8 = readb(mmio + CARM_INITC);
-	if (tmp8 & 0x01) {
-		tmp8 &= ~0x01;
-		writeb(tmp8, mmio + CARM_INITC);
-		readb(mmio + CARM_INITC);	/* flush */
-
-		DPRINTK("snooze...\n");
-		msleep(5000);
-	}
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_CME) {
-		DPRINTK("CME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_CME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 1 failed\n");
-			return rc;
-		}
-	}
-	if (tmp & CARM_RME) {
-		DPRINTK("RME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_RME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 2 failed\n");
-			return rc;
-		}
-	}
-
-	tmp &= ~(CARM_RME | CARM_CME);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 0);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 3 failed\n");
-		return rc;
-	}
-
-	carm_init_buckets(mmio);
-
-	writel(host->shm_dma & 0xffffffff, mmio + RBUF_ADDR_LO);
-	writel((host->shm_dma >> 16) >> 16, mmio + RBUF_ADDR_HI);
-	writel(RBUF_LEN, mmio + RBUF_BYTE_SZ);
-
-	tmp = readl(mmio + CARM_HMUC);
-	tmp |= (CARM_RME | CARM_CME | CARM_WZBC);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 1);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 4 failed\n");
-		return rc;
-	}
-
-	writel(0, mmio + CARM_HMPHA);
-	writel(INT_DEF_MASK, mmio + CARM_INT_MASK);
-
-	carm_init_responses(host);
-
-	/* start initialization, probing state machine */
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_INVALID);
-	host->state = HST_PROBE_START;
-	spin_unlock_irq(&host->lock);
-	schedule_work(&host->fsm_task);
-
-	DPRINTK("EXIT\n");
-	return 0;
-}
-
-static const struct blk_mq_ops carm_mq_ops = {
-	.queue_rq	= carm_queue_rq,
-};
-
-static int carm_init_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk;
-	struct request_queue *q;
-
-	port->host = host;
-	port->port_no = port_no;
-
-	disk = alloc_disk(CARM_MINORS_PER_MAJOR);
-	if (!disk)
-		return -ENOMEM;
-
-	port->disk = disk;
-	sprintf(disk->disk_name, DRV_NAME "/%u",
-		(unsigned int)host->id * CARM_MAX_PORTS + port_no);
-	disk->major = host->major;
-	disk->first_minor = port_no * CARM_MINORS_PER_MAJOR;
-	disk->fops = &carm_bd_ops;
-	disk->private_data = port;
-
-	q = blk_mq_init_queue(&host->tag_set);
-	if (IS_ERR(q))
-		return PTR_ERR(q);
-
-	blk_queue_max_segments(q, CARM_MAX_REQ_SG);
-	blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
-
-	q->queuedata = port;
-	disk->queue = q;
-	return 0;
-}
-
-static void carm_free_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk = port->disk;
-
-	if (!disk)
-		return;
-
-	if (disk->flags & GENHD_FL_UP)
-		del_gendisk(disk);
-	if (disk->queue)
-		blk_cleanup_queue(disk->queue);
-	put_disk(disk);
-}
-
-static int carm_init_shm(struct carm_host *host)
-{
-	host->shm = dma_alloc_coherent(&host->pdev->dev, CARM_SHM_SIZE,
-				       &host->shm_dma, GFP_KERNEL);
-	if (!host->shm)
-		return -ENOMEM;
-
-	host->msg_base = host->shm + RBUF_LEN;
-	host->msg_dma = host->shm_dma + RBUF_LEN;
-
-	memset(host->shm, 0xff, RBUF_LEN);
-	memset(host->msg_base, 0, PDC_SHM_SIZE - RBUF_LEN);
-
-	return 0;
-}
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	struct carm_host *host;
-	int rc;
-	struct request_queue *q;
-	unsigned int i;
-
-	printk_once(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
-
-	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
-
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		goto err_out;
-
-	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
-			pci_name(pdev));
-		goto err_out_regions;
-	}
-
-	host = kzalloc(sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		printk(KERN_ERR DRV_NAME "(%s): memory alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
-	host->pdev = pdev;
-	spin_lock_init(&host->lock);
-	INIT_WORK(&host->fsm_task, carm_fsm_task);
-	init_completion(&host->probe_comp);
-
-	host->mmio = ioremap(pci_resource_start(pdev, 0),
-			     pci_resource_len(pdev, 0));
-	if (!host->mmio) {
-		printk(KERN_ERR DRV_NAME "(%s): MMIO alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
-
-	rc = carm_init_shm(host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA SHM alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_iounmap;
-	}
-
-	memset(&host->tag_set, 0, sizeof(host->tag_set));
-	host->tag_set.ops = &carm_mq_ops;
-	host->tag_set.cmd_size = sizeof(struct carm_request);
-	host->tag_set.nr_hw_queues = 1;
-	host->tag_set.nr_maps = 1;
-	host->tag_set.queue_depth = max_queue;
-	host->tag_set.numa_node = NUMA_NO_NODE;
-	host->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-
-	rc = blk_mq_alloc_tag_set(&host->tag_set);
-	if (rc)
-		goto err_out_dma_free;
-
-	q = blk_mq_init_queue(&host->tag_set);
-	if (IS_ERR(q)) {
-		rc = PTR_ERR(q);
-		blk_mq_free_tag_set(&host->tag_set);
-		goto err_out_dma_free;
-	}
-
-	host->oob_q = q;
-	q->queuedata = host;
-
-	/*
-	 * Figure out which major to use: 160, 161, or dynamic
-	 */
-	if (!test_and_set_bit(0, &carm_major_alloc))
-		host->major = 160;
-	else if (!test_and_set_bit(1, &carm_major_alloc))
-		host->major = 161;
-	else
-		host->flags |= FL_DYN_MAJOR;
-
-	host->id = carm_host_id;
-	sprintf(host->name, DRV_NAME "%d", carm_host_id);
-
-	rc = register_blkdev(host->major, host->name);
-	if (rc < 0)
-		goto err_out_free_majors;
-	if (host->flags & FL_DYN_MAJOR)
-		host->major = rc;
-
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		rc = carm_init_disk(host, i);
-		if (rc)
-			goto err_out_blkdev_disks;
-	}
-
-	pci_set_master(pdev);
-
-	rc = request_irq(pdev->irq, carm_interrupt, IRQF_SHARED, DRV_NAME, host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): irq alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_blkdev_disks;
-	}
-
-	rc = carm_init_host(host);
-	if (rc)
-		goto err_out_free_irq;
-
-	DPRINTK("waiting for probe_comp\n");
-	wait_for_completion(&host->probe_comp);
-
-	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
-	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-	       (unsigned long long)pci_resource_start(pdev, 0),
-		   pdev->irq, host->major);
-
-	carm_host_id++;
-	pci_set_drvdata(pdev, host);
-	return 0;
-
-err_out_free_irq:
-	free_irq(pdev->irq, host);
-err_out_blkdev_disks:
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
-err_out_free_majors:
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	blk_mq_free_tag_set(&host->tag_set);
-err_out_dma_free:
-	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-err_out_iounmap:
-	iounmap(host->mmio);
-err_out_kfree:
-	kfree(host);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	pci_disable_device(pdev);
-	return rc;
-}
-
-static void carm_remove_one (struct pci_dev *pdev)
-{
-	struct carm_host *host = pci_get_drvdata(pdev);
-	unsigned int i;
-
-	if (!host) {
-		printk(KERN_ERR PFX "BUG: no host data for PCI(%s)\n",
-		       pci_name(pdev));
-		return;
-	}
-
-	free_irq(pdev->irq, host);
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	blk_mq_free_tag_set(&host->tag_set);
-	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-	iounmap(host->mmio);
-	kfree(host);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-}
-
-module_pci_driver(carm_driver);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1c73668b4375..661d456fb0ad 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3080,6 +3080,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name = NULL;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3094,18 +3095,20 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
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
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 96a808b487cb..fa0ad8581edc 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3700,6 +3700,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 1ff13af13324..7b396b7277ee 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1806,14 +1806,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
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
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 8e04db09d787..ff08bcb09a68 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -740,6 +740,8 @@ static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
 	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
 	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
 	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
 static int aspeed_i2c_reg_slave(struct i2c_client *client)
@@ -756,7 +758,6 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 	__aspeed_i2c_reg_slave(bus, client->addr);
 
 	bus->slave = client;
-	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 	spin_unlock_irqrestore(&bus->lock, flags);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 0f0c41174ddd..74dd2c15e34c 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -974,9 +974,10 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
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
@@ -1064,8 +1065,10 @@ static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
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
index 8e8688e8de0f..45a3f7e7b3f6 100644
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
index 480ec74e6134..fed7d17e0190 100644
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
index f1bb00a11ad6..fc991cf002af 100644
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
index 42a3ced11fbd..234f9c37aa10 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -804,16 +804,26 @@ static int exynos_adc_probe(struct platform_device *pdev)
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
 
@@ -880,12 +890,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
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
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f2383c91113c..9cfd2c1d4e3a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1747,6 +1747,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
 	const struct rmi_device_platform_data pdata = {
+		.reset_delay_ms = 30,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 2407ea43de59..f38bf9a5f599 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -235,12 +235,29 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
-	int retval;
+	struct i2c_client *client = rmi_smb->client;
+	int smbus_version;
+
+	/*
+	 * psmouse driver resets the controller, we only need to wait
+	 * to give the firmware chance to fully reinitialize.
+	 */
+	if (rmi_smb->xport.pdata.reset_delay_ms)
+		msleep(rmi_smb->xport.pdata.reset_delay_ms);
 
 	/* we need to get the smbus version to activate the touchpad */
-	retval = rmi_smb_get_version(rmi_smb);
-	if (retval < 0)
-		return retval;
+	smbus_version = rmi_smb_get_version(rmi_smb);
+	if (smbus_version < 0)
+		return smbus_version;
+
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+		smbus_version);
+
+	if (smbus_version != 2 && smbus_version != 3) {
+		dev_err(&client->dev, "Unrecognized SMB version %d\n",
+				smbus_version);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -253,11 +270,10 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 	rmi_smb_clear_state(rmi_smb);
 
 	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
+	 * We do not call the actual reset command, it has to be handled in
+	 * PS/2 or there will be races between PS/2 and SMBus. PS/2 should
+	 * ensure that a psmouse_reset is called before initializing the
+	 * device and after it has been removed to be in a known state.
 	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
@@ -273,7 +289,6 @@ static int rmi_smb_probe(struct i2c_client *client,
 {
 	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb;
-	int smbus_version;
 	int error;
 
 	if (!pdata) {
@@ -312,18 +327,9 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
-	smbus_version = rmi_smb_get_version(rmi_smb);
-	if (smbus_version < 0)
-		return smbus_version;
-
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
-		smbus_version);
-
-	if (smbus_version != 2 && smbus_version != 3) {
-		dev_err(&client->dev, "Unrecognized SMB version %d\n",
-				smbus_version);
-		return -ENODEV;
-	}
+	error = rmi_smb_enable_smbus_mode(rmi_smb);
+	if (error)
+		return error;
 
 	i2c_set_clientdata(client, rmi_smb);
 
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 700655741bf2..5df6eef18228 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -609,6 +609,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook E5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E5411"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index a8322a4e18d3..df18465a0985 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -414,6 +414,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 8f1bde437a7e..92915d2c2d46 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -23,7 +23,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret = 0;
+	int ret = 0, table_size;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -58,16 +58,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 
 	ret = chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
 	return 0;
 
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
 
 static int mcb_lpc_remove(struct platform_device *pdev)
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index c111025f23c5..a88862ff8507 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -128,7 +128,7 @@ static void chameleon_parse_bar(void __iomem *base,
 	}
 }
 
-static int chameleon_get_bar(char __iomem **base, phys_addr_t mapbase,
+static int chameleon_get_bar(void __iomem **base, phys_addr_t mapbase,
 			     struct chameleon_bar **cb)
 {
 	struct chameleon_bar *c;
@@ -177,12 +177,13 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 {
 	struct chameleon_fpga_header *header;
 	struct chameleon_bar *cb;
-	char __iomem *p = base;
+	void __iomem *p = base;
 	int num_cells = 0;
 	uint32_t dtype;
 	int bar_count;
 	int ret;
 	u32 hsize;
+	u32 table_size;
 
 	hsize = sizeof(struct chameleon_fpga_header);
 
@@ -237,12 +238,16 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 		num_cells++;
 	}
 
-	if (num_cells == 0)
-		num_cells = -EINVAL;
+	if (num_cells == 0) {
+		ret = -EINVAL;
+		goto free_bar;
+	}
 
+	table_size = p - base;
+	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_cells, table_size);
 	kfree(cb);
 	kfree(header);
-	return num_cells;
+	return table_size;
 
 free_bar:
 	kfree(cb);
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index c49a3e105b42..9a119688c0a6 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1109,6 +1109,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
 	};
 	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
+	u8 status;
 	int ret;
 
 	/* NFCv2 needs more information about the operation being executed */
@@ -1142,7 +1143,18 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 
 	ret = marvell_nfc_wait_op(chip,
 				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
-	return ret;
+	if (ret)
+		return ret;
+
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
 }
 
 static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct nand_chip *chip,
@@ -1570,6 +1582,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	int data_len = lt->data_bytes;
 	int spare_len = lt->spare_bytes;
 	int chunk, ret;
+	u8 status;
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
 
@@ -1607,6 +1620,14 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	if (ret)
 		return ret;
 
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 42374859b9d3..cb3f515559c2 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3850,6 +3850,8 @@ int t4_load_phy_fw(struct adapter *adap,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_DOWNLOAD));
 	ret = t4_set_params_timeout(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val, 30000);
+	if (ret)
+		return ret;
 
 	/* If we have version number support, then check to see that the new
 	 * firmware got loaded properly.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 06987913837a..6067c8866834 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2669,7 +2669,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 50f61b18ae1e..de2c39436fe0 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2997,11 +2997,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
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
index 0a4e7f5f292a..a307b737dd0c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1768,7 +1768,7 @@ static int igc_set_link_ksettings(struct net_device *netdev,
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct igc_hw *hw = &adapter->hw;
-	u32 advertising;
+	u16 advertised = 0;
 
 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -1794,18 +1794,33 @@ static int igc_set_link_ksettings(struct net_device *netdev,
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
index 8d2b184ff575..fca2dbdd37af 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6031,7 +6031,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		struct ring_info *tx_skb = tp->tx_skb + entry;
 		u32 status;
 
-		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
+		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
 		if (status & DescOwn)
 			break;
 
@@ -6114,7 +6114,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, u32 budget
 		struct RxDesc *desc = tp->RxDescArray + entry;
 		u32 status;
 
-		status = le32_to_cpu(desc->opts1);
+		status = le32_to_cpu(READ_ONCE(desc->opts1));
 		if (status & DescOwn)
 			break;
 
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index 2db546b27ee0..411b2a6091c9 100644
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
index 0409afe9a53d..c2e649a4f1bf 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -544,8 +544,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	rt->dst.ops->update_pmtu(&rt->dst, NULL, skb, mtu, false);
 
-	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
-	    mtu < ntohs(iph->tot_len)) {
+	if (iph->frag_off & htons(IP_DF) &&
+	    ((!skb_is_gso(skb) && skb->len > mtu) ||
+	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			      htonl(mtu));
diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cb29da961e12..179e3e42b5f0 100644
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
index a19f0431e6f9..472b02bcfcbf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -850,7 +850,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, usb_rcvctrlpipe(tp->udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -873,7 +873,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, usb_sndctrlpipe(tp->udev, 0),
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -5584,7 +5584,8 @@ static u8 rtl_get_version(struct usb_interface *intf)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
@@ -5778,6 +5779,9 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	cancel_delayed_work_sync(&tp->hw_phy_work);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index df7a911d303f..e8c7135c4c11 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -321,6 +321,15 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 }
 
+static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
+{
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
+	if (status == -EPIPE || status == -ECONNRESET)
+		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+	else
+		nvmet_tcp_fatal_error(queue);
+}
+
 static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
@@ -714,11 +723,15 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
-		if (ret <= 0)
+		if (unlikely(ret < 0)) {
+			nvmet_tcp_socket_error(queue, ret);
+			goto done;
+		} else if (ret == 0) {
 			break;
+		}
 		(*sends)++;
 	}
-
+done:
 	return ret;
 }
 
@@ -816,15 +829,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0)
-		goto free_crypto;
+		return ret; /* queue removal will cleanup */
 
 	queue->state = NVMET_TCP_Q_LIVE;
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
-free_crypto:
-	if (queue->hdr_digest || queue->data_digest)
-		nvmet_tcp_free_crypto(queue);
-	return ret;
 }
 
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
@@ -1167,11 +1176,15 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
-		if (ret <= 0)
+		if (unlikely(ret < 0)) {
+			nvmet_tcp_socket_error(queue, ret);
+			goto done;
+		} else if (ret == 0) {
 			break;
+		}
 		(*recvs)++;
 	}
-
+done:
 	return ret;
 }
 
@@ -1196,27 +1209,16 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		pending = false;
 
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
-		if (ret > 0) {
+		if (ret > 0)
 			pending = true;
-		} else if (ret < 0) {
-			if (ret == -EPIPE || ret == -ECONNRESET)
-				kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-			else
-				nvmet_tcp_fatal_error(queue);
+		else if (ret < 0)
 			return;
-		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
-		if (ret > 0) {
-			/* transmitted message/data */
+		if (ret > 0)
 			pending = true;
-		} else if (ret < 0) {
-			if (ret == -EPIPE || ret == -ECONNRESET)
-				kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-			else
-				nvmet_tcp_fatal_error(queue);
+		else if (ret < 0)
 			return;
-		}
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index fc40555ca4cd..3297ced943ea 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -433,7 +433,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
@@ -445,13 +445,13 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 73260bd21727..780223694c00 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -597,7 +597,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -605,7 +605,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -615,7 +615,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Synopsys USB 3.x host HAPS platform has a class code of
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 194f3205e559..767f4406e55f 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -588,24 +588,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       sizeof(u64));
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       sizeof(u64));
+		} else {
+			memcpy(&data, addr + vring->cur_len,
+			       sizeof(u64));
 		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       len - vring->cur_len);
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       len - vring->cur_len);
+		} else {
+			data = 0;
+			memcpy(&data, addr + vring->cur_len,
+			       len - vring->cur_len);
 		}
 		vring->cur_len = len;
 	}
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 4f31b68642a0..6faf213f687a 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,7 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
-#define ASUS_WMI_BRN_DOWN	0x20
+#define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
 struct module;
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f65db95e78aa..2dea1e7487bb 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1379,6 +1379,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index c1d4990beab0..865d977668cc 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -332,7 +332,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
@@ -525,24 +526,52 @@ static struct bus_type rpmsg_bus = {
 	.remove		= rpmsg_dev_remove,
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev)
+/*
+ * A helper for registering rpmsg device with driver override and name.
+ * Drivers should not be using it, but instead rpmsg_register_device().
+ */
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override)
 {
 	struct device *dev = &rpdev->dev;
 	int ret;
 
+	if (driver_override)
+		strcpy(rpdev->id.name, driver_override);
+
 	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
 
 	rpdev->dev.bus = &rpmsg_bus;
 
-	ret = device_register(&rpdev->dev);
+	device_initialize(dev);
+	if (driver_override) {
+		ret = driver_set_override(dev, &rpdev->driver_override,
+					  driver_override,
+					  strlen(driver_override));
+		if (ret) {
+			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
+			return ret;
+		}
+	}
+
+	ret = device_add(dev);
 	if (ret) {
-		dev_err(dev, "device_register failed: %d\n", ret);
+		dev_err(dev, "device_add failed: %d\n", ret);
+		kfree(rpdev->driver_override);
+		rpdev->driver_override = NULL;
 		put_device(&rpdev->dev);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(rpmsg_register_device_override);
+
+int rpmsg_register_device(struct rpmsg_device *rpdev)
+{
+	return rpmsg_register_device_override(rpdev, NULL);
+}
 EXPORT_SYMBOL(rpmsg_register_device);
 
 /*
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd50e98..f305279e2e24 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -84,10 +84,7 @@ struct device *rpmsg_find_device(struct device *parent,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
-	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
-
-	return rpmsg_register_device(rpdev);
+	return rpmsg_register_device_override(rpdev, "rpmsg_ctrl");
 }
 
 #endif
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 044a00edb545..4731e464dfb9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11138,8 +11138,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 1e770d673905..cc4e29cd86da 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -334,8 +334,9 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 		uma_cfg |= ilog2(op->cmd.buswidth);
 		uma_cfg |= ilog2(op->addr.buswidth)
 			<< NPCM_FIU_UMA_CFG_ADBPCK_SHIFT;
-		uma_cfg |= ilog2(op->dummy.buswidth)
-			<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
+		if (op->dummy.nbytes)
+			uma_cfg |= ilog2(op->dummy.buswidth)
+				<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
 		uma_cfg |= ilog2(op->data.buswidth)
 			<< NPCM_FIU_UMA_CFG_RDBPCK_SHIFT;
 		uma_cfg |= op->dummy.nbytes << NPCM_FIU_UMA_CFG_DBSIZ_SHIFT;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 5c7a2145b945..1ff5920e5278 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5104,6 +5104,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b1_bt_1_115200 },
 
+	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
 	/*
 	 * IntaShield IS-200
 	 */
@@ -5131,10 +5137,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
+	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -5149,6 +5159,66 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UP-189
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-869
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C03,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-880
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-268
 	 */
@@ -5170,6 +5240,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
@@ -5180,6 +5258,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-313
 	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5194,6 +5280,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-346
 	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5205,6 +5295,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5217,12 +5311,34 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-607
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-836
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Perle PCI-RAS cards
 	 */
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index fb99e526cd48..7f7534098d53 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -19,7 +19,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x9999,
 		"Cypress ISD-300LP",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
 
-UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
+UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
 		"Super Top",
 		"USB 2.0  SATA BRIDGE",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 6dda5d885a03..bb9ecf12e763 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3410,11 +3410,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 7d3af1d19ad3..115653ba761c 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1933,10 +1933,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1e444826a66e..4c44bbe1ae7c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -365,7 +365,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
 		num_pages = le32_to_cpu((__force __le32)num_pages);
 
-	target = num_pages;
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
 	return target - vb->num_pages;
 }
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index aee8b5ce8b63..db1015db07b5 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -567,14 +567,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
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
@@ -582,7 +585,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto free_vm_dev;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -591,7 +595,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -621,6 +626,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		put_device(&vm_dev->vdev.dev);
 
 	return rc;
+
+free_vm_dev:
+	kfree(vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 2f2a1d980cdf..0842a1af0b98 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -607,8 +607,13 @@ static struct rdma_cm_id *smbd_create_id(
 		log_rdma_event(ERR, "rdma_resolve_addr() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc = wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0) {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc = info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_addr() completed %i\n", rc);
@@ -621,8 +626,13 @@ static struct rdma_cm_id *smbd_create_id(
 		log_rdma_event(ERR, "rdma_resolve_route() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc = wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0)  {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc = info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_route() completed %i\n", rc);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9099e112fda5..a0ec645bd7ed 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3094,8 +3094,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
-	ext4_lblk_t end;
-	loff_t size, start_off;
+	loff_t size, start_off, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
@@ -3124,7 +3123,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	size = size << bsbits;
 	if (size < i_size_read(ac->ac_inode))
 		size = i_size_read(ac->ac_inode);
@@ -3203,7 +3202,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	/* check we don't cross already preallocated blocks */
 	rcu_read_lock();
 	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
-		ext4_lblk_t pa_end;
+		loff_t pa_end;
 
 		if (pa->pa_deleted)
 			continue;
@@ -3213,8 +3212,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 			continue;
 		}
 
-		pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
-						  pa->pa_len);
+		pa_end = pa_logical_end(EXT4_SB(ac->ac_sb), pa);
 
 		/* PA must not overlap original request */
 		BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
@@ -3243,12 +3241,11 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	/* XXX: extra loop to check we really don't overlap preallocations */
 	rcu_read_lock();
 	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
-		ext4_lblk_t pa_end;
+		loff_t pa_end;
 
 		spin_lock(&pa->pa_lock);
 		if (pa->pa_deleted == 0) {
-			pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
-							  pa->pa_len);
+			pa_end = pa_logical_end(EXT4_SB(ac->ac_sb), pa);
 			BUG_ON(!(start >= pa_end || end <= pa->pa_lstart));
 		}
 		spin_unlock(&pa->pa_lock);
@@ -3462,8 +3459,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
 		if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
-		    ac->ac_o_ex.fe_logical >= (pa->pa_lstart +
-					       EXT4_C2B(sbi, pa->pa_len)))
+		    ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, pa))
 			continue;
 
 		/* non-extent files can't have physical blocks past 2^32 */
@@ -3684,8 +3680,11 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		return -ENOMEM;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
-		int new_bex_start;
-		int new_bex_end;
+		struct ext4_free_extent ex = {
+			.fe_logical = ac->ac_g_ex.fe_logical,
+			.fe_len = ac->ac_g_ex.fe_len,
+		};
+		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -3704,29 +3703,23 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 *    still cover original start
 		 * 3. Else, keep the best ex at start of original request.
 		 */
-		new_bex_end = ac->ac_g_ex.fe_logical +
-			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
-		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (ac->ac_o_ex.fe_logical >= new_bex_start)
-			goto adjust_bex;
+		ex.fe_len = ac->ac_b_ex.fe_len;
 
-		new_bex_start = ac->ac_g_ex.fe_logical;
-		new_bex_end =
-			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (ac->ac_o_ex.fe_logical < new_bex_end)
+		ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
+		if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
 			goto adjust_bex;
 
-		new_bex_start = ac->ac_o_ex.fe_logical;
-		new_bex_end =
-			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		ex.fe_logical = ac->ac_g_ex.fe_logical;
+		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+			goto adjust_bex;
 
+		ex.fe_logical = ac->ac_o_ex.fe_logical;
 adjust_bex:
-		ac->ac_b_ex.fe_logical = new_bex_start;
+		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
-		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
-				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
+		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
 	/* preallocation can change ac_b_ex, thus we store actually
@@ -4234,7 +4227,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		return;
 
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..4e442bad6d73 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -199,6 +199,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
 		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
 }
 
+static inline loff_t extent_logical_end(struct ext4_sb_info *sbi,
+					struct ext4_free_extent *fex)
+{
+	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
+	return (loff_t)fex->fe_logical + EXT4_C2B(sbi, fex->fe_len);
+}
+
+static inline loff_t pa_logical_end(struct ext4_sb_info *sbi,
+				    struct ext4_prealloc_space *pa)
+{
+	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
+	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
+}
+
 typedef int (*ext4_mballoc_query_range_fn)(
 	struct super_block		*sb,
 	ext4_group_t			agno,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 939be9df0207..d26b3fe38bd9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1069,7 +1069,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode) ||
+					special_file(inode->i_mode))
 				continue;
 
 			if (!down_write_trylock(
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b6f4b552c9af..6aa968bee0ce 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1689,6 +1689,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -1723,12 +1729,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if (nfsd_has_cached_files(ndentry)) {
 		has_cached = true;
 		goto out_dput_old;
diff --git a/include/linux/device.h b/include/linux/device.h
index c7be3a8073ec..af4ecbf88910 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -422,6 +422,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
 extern void driver_remove_file(struct device_driver *driver,
 			       const struct driver_attribute *attr);
 
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len);
 extern int __must_check driver_for_each_device(struct device_driver *drv,
 					       struct device *start,
 					       void *data,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d35000669db5..fcacf2334704 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -554,6 +554,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 569f446502be..c7bd8a1a6097 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -29,7 +29,11 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index a68972b097b7..267533fecbdd 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,7 +41,9 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -50,7 +52,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
@@ -113,6 +115,8 @@ struct rpmsg_driver {
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int register_rpmsg_device(struct rpmsg_device *dev);
 void unregister_rpmsg_device(struct rpmsg_device *dev);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
@@ -137,6 +141,12 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 #else
 
+static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+						 const char *driver_override)
+{
+	return -ENXIO;
+}
+
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
 {
 	return -ENXIO;
diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index c7d66755d212..78bd62014efd 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -30,6 +30,6 @@ enum gtp_attrs {
 	GTPA_PAD,
 	__GTPA_MAX,
 };
-#define GTPA_MAX (__GTPA_MAX + 1)
+#define GTPA_MAX (__GTPA_MAX - 1)
 
 #endif /* _UAPI_LINUX_GTP_H_ */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 884cb4aaf342..cd32c7e55568 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12015,7 +12015,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/lib/kobject.c b/lib/kobject.c
index c4025a880d75..6666c48f125c 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -144,7 +144,7 @@ static int get_kobj_path_length(struct kobject *kobj)
 	return length;
 }
 
-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static int fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject *parent;
 
@@ -153,12 +153,16 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
+		if (length <= 0)
+			return -EINVAL;
 		memcpy(path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
 
 	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
 		 kobj, __func__, path);
+
+	return 0;
 }
 
 /**
@@ -173,13 +177,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
 	char *path;
 	int len;
 
+retry:
 	len = get_kobj_path_length(kobj);
 	if (len == 0)
 		return NULL;
 	path = kzalloc(len, gfp_mask);
 	if (!path)
 		return NULL;
-	fill_kobj_path(kobj, path, len);
+	if (fill_kobj_path(kobj, path, len)) {
+		kfree(path);
+		goto retry;
+	}
 
 	return path;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c0489d8812c0..9d631b7adb7b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -224,7 +224,8 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
-	int max_clean = atomic_read(&tbl->gc_entries) - tbl->gc_thresh2;
+	int max_clean = atomic_read(&tbl->gc_entries) -
+			READ_ONCE(tbl->gc_thresh2);
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
@@ -253,7 +254,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 		}
 	}
 
-	tbl->last_flush = jiffies;
+	WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
@@ -409,17 +410,17 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl,
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
@@ -902,13 +903,14 @@ static void neigh_periodic_work(struct work_struct *work)
 
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
@@ -2050,15 +2052,16 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
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
@@ -2066,7 +2069,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_entries		= atomic_read(&tbl->entries),
 			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
 			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
-			.ndtc_proxy_qlen	= tbl->proxy_queue.qlen,
+			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
 		};
 
 		rcu_read_lock_bh();
@@ -2089,17 +2092,17 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
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
@@ -2323,16 +2326,16 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ec3c23adbab4..c3f227c4c356 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2057,16 +2057,17 @@ void tcp_enter_loss(struct sock *sk)
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
@@ -2840,7 +2841,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		tp->prior_ssthresh = 0;
 
 	/* B. In all the states check for reneging SACKs. */
-	if (tcp_check_sack_reneging(sk, flag))
+	if (tcp_check_sack_reneging(sk, ack_flag))
 		return;
 
 	/* C. Check consistency of the current state. */
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index f087baa95b07..80c09070ea9f 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -683,8 +683,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen = 0;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a66e93a3af74..9fda0e5548dc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3241,6 +3241,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
