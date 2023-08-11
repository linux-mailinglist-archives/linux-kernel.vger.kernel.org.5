Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538A2778BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjHKKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjHKKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A93C35;
        Fri, 11 Aug 2023 03:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9489566EE2;
        Fri, 11 Aug 2023 10:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4817C433C8;
        Fri, 11 Aug 2023 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691749068;
        bh=4SA4i6cBxuHd5ytdXvYnt6ghQgJByvIAb2YgVS02pgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7vvBUZzvU4T3EFw1S3UJPCwfxpf3NlsOBLR/nySPb9WtJeMM/u6zqZIALpygBZit
         vbiTr/OjSOP2J9yuLKN0MiYf9JzES3y9SsoU6imblCVtTuBMQGYVoQ2E7koHTm2aiH
         6RariguqXLAXNCan7jBjMyq6VGXlDY4dpnCRIxfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.190
Date:   Fri, 11 Aug 2023 12:17:35 +0200
Message-ID: <2023081135-mom-domelike-aad2@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081135-stinging-brick-608f@gregkh>
References: <2023081135-stinging-brick-608f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index c32eb786201c..d6d93e96128e 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -63,31 +63,28 @@ information submitted to the security list and any followup discussions
 of the report are treated confidentially even after the embargo has been
 lifted, in perpetuity.
 
-Coordination
-------------
-
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+Coordination with other groups
+------------------------------
+
+The kernel security team strongly recommends that reporters of potential
+security issues NEVER contact the "linux-distros" mailing list until
+AFTER discussing it with the kernel security team.  Do not Cc: both
+lists at once.  You may contact the linux-distros mailing list after a
+fix has been agreed on and you fully understand the requirements that
+doing so will impose on you and the kernel community.
+
+The different lists have different goals and the linux-distros rules do
+not contribute to actually fixing any potential security problems.
 
 CVE assignment
 --------------
 
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+The security team does not assign CVEs, nor do we require them for
+reports or fixes, as this can needlessly complicate the process and may
+delay the bug handling.  If a reporter wishes to have a CVE identifier
+assigned, they should find one by themselves, for example by contacting
+MITRE directly.  However under no circumstances will a patch inclusion
+be delayed to wait for a CVE identifier to arrive.
 
 Non-disclosure agreements
 -------------------------
diff --git a/Makefile b/Makefile
index 36047436fae3..bd2f45770363 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 189
+SUBLEVEL = 190
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 7858ae5d39df..7d81992dfafc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -45,6 +45,10 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg;
+		usb1 = &usbh1;
+		usb2 = &usbh2;
+		usb3 = &usbh3;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c184a6d5bc42..5b4dfc62030e 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -39,6 +39,9 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index bf5b262b91f9..3659fd5ecfa6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -36,6 +36,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi3 = &ecspi3;
 		spi4 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
@@ -49,20 +51,18 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
-			operating-points = <
+			operating-points =
 				/* kHz    uV */
-				996000  1275000
-				792000  1175000
-				396000  1075000
-				198000	975000
-			>;
-			fsl,soc-operating-points = <
+				<996000  1275000>,
+				<792000  1175000>,
+				<396000  1075000>,
+				<198000	  975000>;
+			fsl,soc-operating-points =
 				/* ARM kHz      SOC-PU uV */
-				996000          1175000
-				792000          1175000
-				396000          1175000
-				198000		1175000
-			>;
+				<996000         1175000>,
+				<792000         1175000>,
+				<396000         1175000>,
+				<198000		1175000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			#cooling-cells = <2>;
 			clocks = <&clks IMX6SLL_CLK_ARM>,
@@ -552,7 +552,7 @@ usbphy2: usb-phy@20ca000 {
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
-				phy-reg_3p0-supply = <&reg_3p0>;
+				phy-3p0-supply = <&reg_3p0>;
 				fsl,anatop = <&anatop>;
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index c399919943c3..629c6a7432d9 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -49,6 +49,9 @@ aliases {
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
 		spi4 = &ecspi5;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c40684ad11b8..b40dd0c19802 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -47,6 +47,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index cff875b80b60..b0bcfa9094a3 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -7,6 +7,12 @@
 #include <dt-bindings/reset/imx7-reset.h>
 
 / {
+	aliases {
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			clock-frequency = <996000000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 43b39ad9ddce..334e781663cc 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -47,6 +47,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbh;
 	};
 
 	cpus {
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 46e558ab7729..f0e8af12442a 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -129,7 +129,7 @@ &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index f9b4a39683cf..92ac3c86ebd5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -162,7 +162,7 @@ &i2c2 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index 24f9e8fd0c8b..9c6c21cc6c6c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -351,7 +351,7 @@ MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
 			MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
 			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
 			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x159
 		>;
 	};
 
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index f3f4710d4ff5..99129b0cd8b8 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -34,7 +34,7 @@ static inline long find_zero(unsigned long mask)
 	return leading_zero_bits >> 3;
 }
 
-static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+static inline unsigned long has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
 {
 	unsigned long rhs = val | c->low_bits;
 	*data = rhs;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b76cd49d521b..db040f34c004 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -313,8 +313,7 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 	start = ALIGN_DOWN(start, page_size);
 	if (altmap) {
 		alt_start = altmap->base_pfn;
-		alt_end = altmap->base_pfn + altmap->reserve +
-			  altmap->free + altmap->alloc + altmap->align;
+		alt_end = altmap->base_pfn + altmap->reserve + altmap->free;
 	}
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 888cc2f166db..ce6084e28d90 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -460,9 +460,9 @@ static int sthyi_update_cache(u64 *rc)
  *
  * Fills the destination with system information returned by the STHYI
  * instruction. The data is generated by emulation or execution of STHYI,
- * if available. The return value is the condition code that would be
- * returned, the rc parameter is the return code which is passed in
- * register R2 + 1.
+ * if available. The return value is either a negative error value or
+ * the condition code that would be returned, the rc parameter is the
+ * return code which is passed in register R2 + 1.
  */
 int sthyi_fill(void *dst, u64 *rc)
 {
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 5be68190901f..8bf72a323e4f 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -387,8 +387,8 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
  */
 int handle_sthyi(struct kvm_vcpu *vcpu)
 {
-	int reg1, reg2, r = 0;
-	u64 code, addr, cc = 0, rc = 0;
+	int reg1, reg2, cc = 0, r = 0;
+	u64 code, addr, rc = 0;
 	struct sthyi_sctns *sctns = NULL;
 
 	if (!test_kvm_facility(vcpu->kvm, 74))
@@ -419,7 +419,10 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	cc = sthyi_fill(sctns, &rc);
-
+	if (cc < 0) {
+		free_page((unsigned long)sctns);
+		return cc;
+	}
 out:
 	if (!cc) {
 		if (kvm_s390_pv_cpu_is_protected(vcpu)) {
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 03e561608eed..b5a60fbb9664 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2786,6 +2786,7 @@ int s390_replace_asce(struct gmap *gmap)
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
+	page->index = 0;
 	table = page_to_virt(page);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2c0c495b9cb6..5a54c3685a06 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -451,4 +451,5 @@
 
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
+#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 991a7ad540c7..bd7f5886a789 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -58,14 +58,29 @@ struct arch_specific_insn {
 	/* copy of the original instruction */
 	kprobe_opcode_t *insn;
 	/*
-	 * boostable = false: This instruction type is not boostable.
-	 * boostable = true: This instruction has been boosted: we have
+	 * boostable = 0: This instruction type is not boostable.
+	 * boostable = 1: This instruction has been boosted: we have
 	 * added a relative jump after the instruction copy in insn,
 	 * so no single-step and fixup are needed (unless there's
 	 * a post_handler).
 	 */
-	bool boostable;
-	bool if_modifier;
+	unsigned boostable:1;
+	unsigned char size;	/* The size of insn */
+	union {
+		unsigned char opcode;
+		struct {
+			unsigned char type;
+		} jcc;
+		struct {
+			unsigned char type;
+			unsigned char asize;
+		} loop;
+		struct {
+			unsigned char reg;
+		} indirect;
+	};
+	s32 rel32;	/* relative offset must be s32, s16, or s8 */
+	void (*emulate_op)(struct kprobe *p, struct pt_regs *regs);
 	/* Number of bytes of text poked */
 	int tp_len;
 };
@@ -104,7 +119,6 @@ extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 extern int kprobe_int3_handler(struct pt_regs *regs);
-extern int kprobe_debug_handler(struct pt_regs *regs);
 
 #else
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6a9de5b1fe45..2dd9b661a5fd 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -809,10 +809,12 @@ DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 extern u16 amd_get_nb_id(int cpu);
 extern u32 amd_get_nodes_per_socket(void);
 extern bool cpu_has_ibpb_brtype_microcode(void);
+extern void amd_clear_divider(void);
 #else
 static inline u16 amd_get_nb_id(int cpu)		{ return 0; }
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
+static inline void amd_clear_divider(void)		{ }
 #endif
 
 static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ffecf4e9444e..da38765aa74c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -76,6 +76,10 @@ static const int amd_zenbleed[] =
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
+static const int amd_div0[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1168,6 +1172,11 @@ static void init_amd(struct cpuinfo_x86 *c)
 	check_null_seg_clears_base(c);
 
 	zenbleed_check(c);
+
+	if (cpu_has_amd_erratum(c, amd_div0)) {
+		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
+		setup_force_cpu_bug(X86_BUG_DIV0);
+	}
 }
 
 #ifdef CONFIG_X86_32
@@ -1312,3 +1321,13 @@ void amd_check_microcode(void)
 {
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
+
+/*
+ * Issue a DIV 0/1 insn to clear any division data from previous DIV
+ * operations.
+ */
+void noinstr amd_clear_divider(void)
+{
+	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
+		     :: "a" (0), "d" (0), "r" (1));
+}
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 5de757099186..c78b4946385e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -133,26 +133,6 @@ void synthesize_relcall(void *dest, void *from, void *to)
 }
 NOKPROBE_SYMBOL(synthesize_relcall);
 
-/*
- * Skip the prefixes of the instruction.
- */
-static kprobe_opcode_t *skip_prefixes(kprobe_opcode_t *insn)
-{
-	insn_attr_t attr;
-
-	attr = inat_get_opcode_attribute((insn_byte_t)*insn);
-	while (inat_is_legacy_prefix(attr)) {
-		insn++;
-		attr = inat_get_opcode_attribute((insn_byte_t)*insn);
-	}
-#ifdef CONFIG_X86_64
-	if (inat_is_rex_prefix(attr))
-		insn++;
-#endif
-	return insn;
-}
-NOKPROBE_SYMBOL(skip_prefixes);
-
 /*
  * Returns non-zero if INSN is boostable.
  * RIP relative instructions are adjusted at copying time in 64 bits mode
@@ -185,29 +165,28 @@ int can_boost(struct insn *insn, void *addr)
 
 	opcode = insn->opcode.bytes[0];
 
-	switch (opcode & 0xf0) {
-	case 0x60:
-		/* can't boost "bound" */
-		return (opcode != 0x62);
-	case 0x70:
-		return 0; /* can't boost conditional jump */
-	case 0x90:
-		return opcode != 0x9a;	/* can't boost call far */
-	case 0xc0:
-		/* can't boost software-interruptions */
-		return (0xc1 < opcode && opcode < 0xcc) || opcode == 0xcf;
-	case 0xd0:
-		/* can boost AA* and XLAT */
-		return (opcode == 0xd4 || opcode == 0xd5 || opcode == 0xd7);
-	case 0xe0:
-		/* can boost in/out and absolute jmps */
-		return ((opcode & 0x04) || opcode == 0xea);
-	case 0xf0:
-		/* clear and set flags are boostable */
-		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
+	switch (opcode) {
+	case 0x62:		/* bound */
+	case 0x70 ... 0x7f:	/* Conditional jumps */
+	case 0x9a:		/* Call far */
+	case 0xc0 ... 0xc1:	/* Grp2 */
+	case 0xcc ... 0xce:	/* software exceptions */
+	case 0xd0 ... 0xd3:	/* Grp2 */
+	case 0xd6:		/* (UD) */
+	case 0xd8 ... 0xdf:	/* ESC */
+	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
+	case 0xe8 ... 0xe9:	/* near Call, JMP */
+	case 0xeb:		/* Short JMP */
+	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
+	case 0xf6 ... 0xf7:	/* Grp3 */
+	case 0xfe:		/* Grp4 */
+		/* ... are not boostable */
+		return 0;
+	case 0xff:		/* Grp5 */
+		/* Only indirect jmp is boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
-		/* call is not boostable */
-		return opcode != 0x9a;
+		return 1;
 	}
 }
 
@@ -326,25 +305,6 @@ static int can_probe(unsigned long paddr)
 	return (addr == paddr);
 }
 
-/*
- * Returns non-zero if opcode modifies the interrupt flag.
- */
-static int is_IF_modifier(kprobe_opcode_t *insn)
-{
-	/* Skip prefixes */
-	insn = skip_prefixes(insn);
-
-	switch (*insn) {
-	case 0xfa:		/* cli */
-	case 0xfb:		/* sti */
-	case 0xcf:		/* iret/iretd */
-	case 0x9d:		/* popf/popfd */
-		return 1;
-	}
-
-	return 0;
-}
-
 /*
  * Copy an instruction with recovering modified instruction by kprobes
  * and adjust the displacement if the instruction uses the %rip-relative
@@ -412,13 +372,14 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	return insn->length;
 }
 
-/* Prepare reljump right after instruction to boost */
-static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
-			  struct insn *insn)
+/* Prepare reljump or int3 right after instruction */
+static int prepare_singlestep(kprobe_opcode_t *buf, struct kprobe *p,
+			      struct insn *insn)
 {
 	int len = insn->length;
 
-	if (can_boost(insn, p->addr) &&
+	if (!IS_ENABLED(CONFIG_PREEMPTION) &&
+	    !p->post_handler && can_boost(insn, p->addr) &&
 	    MAX_INSN_SIZE - len >= JMP32_INSN_SIZE) {
 		/*
 		 * These instructions can be executed directly if it
@@ -427,9 +388,14 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 		synthesize_reljump(buf + len, p->ainsn.insn + len,
 				   p->addr + insn->length);
 		len += JMP32_INSN_SIZE;
-		p->ainsn.boostable = true;
+		p->ainsn.boostable = 1;
 	} else {
-		p->ainsn.boostable = false;
+		/* Otherwise, put an int3 for trapping singlestep */
+		if (MAX_INSN_SIZE - len < INT3_INSN_SIZE)
+			return -ENOSPC;
+
+		buf[len] = INT3_INSN_OPCODE;
+		len += INT3_INSN_SIZE;
 	}
 
 	return len;
@@ -466,25 +432,290 @@ void free_insn_page(void *page)
 	module_memfree(page);
 }
 
+/* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
+
+static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
+{
+	switch (p->ainsn.opcode) {
+	case 0xfa:	/* cli */
+		regs->flags &= ~(X86_EFLAGS_IF);
+		break;
+	case 0xfb:	/* sti */
+		regs->flags |= X86_EFLAGS_IF;
+		break;
+	case 0x9c:	/* pushf */
+		int3_emulate_push(regs, regs->flags);
+		break;
+	case 0x9d:	/* popf */
+		regs->flags = int3_emulate_pop(regs);
+		break;
+	}
+	regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+}
+NOKPROBE_SYMBOL(kprobe_emulate_ifmodifiers);
+
+static void kprobe_emulate_ret(struct kprobe *p, struct pt_regs *regs)
+{
+	int3_emulate_ret(regs);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_ret);
+
+static void kprobe_emulate_call(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long func = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+
+	func += p->ainsn.rel32;
+	int3_emulate_call(regs, func);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_call);
+
+static nokprobe_inline
+void __kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
+{
+	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+
+	if (cond)
+		ip += p->ainsn.rel32;
+	int3_emulate_jmp(regs, ip);
+}
+
+static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
+{
+	__kprobe_emulate_jmp(p, regs, true);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jmp);
+
+static const unsigned long jcc_mask[6] = {
+	[0] = X86_EFLAGS_OF,
+	[1] = X86_EFLAGS_CF,
+	[2] = X86_EFLAGS_ZF,
+	[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
+	[4] = X86_EFLAGS_SF,
+	[5] = X86_EFLAGS_PF,
+};
+
+static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
+{
+	bool invert = p->ainsn.jcc.type & 1;
+	bool match;
+
+	if (p->ainsn.jcc.type < 0xc) {
+		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
+	} else {
+		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		if (p->ainsn.jcc.type >= 0xe)
+			match = match || (regs->flags & X86_EFLAGS_ZF);
+	}
+	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jcc);
+
+static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
+{
+	bool match;
+
+	if (p->ainsn.loop.type != 3) {	/* LOOP* */
+		if (p->ainsn.loop.asize == 32)
+			match = ((*(u32 *)&regs->cx)--) != 0;
+#ifdef CONFIG_X86_64
+		else if (p->ainsn.loop.asize == 64)
+			match = ((*(u64 *)&regs->cx)--) != 0;
+#endif
+		else
+			match = ((*(u16 *)&regs->cx)--) != 0;
+	} else {			/* JCXZ */
+		if (p->ainsn.loop.asize == 32)
+			match = *(u32 *)(&regs->cx) == 0;
+#ifdef CONFIG_X86_64
+		else if (p->ainsn.loop.asize == 64)
+			match = *(u64 *)(&regs->cx) == 0;
+#endif
+		else
+			match = *(u16 *)(&regs->cx) == 0;
+	}
+
+	if (p->ainsn.loop.type == 0)	/* LOOPNE */
+		match = match && !(regs->flags & X86_EFLAGS_ZF);
+	else if (p->ainsn.loop.type == 1)	/* LOOPE */
+		match = match && (regs->flags & X86_EFLAGS_ZF);
+
+	__kprobe_emulate_jmp(p, regs, match);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_loop);
+
+static const int addrmode_regoffs[] = {
+	offsetof(struct pt_regs, ax),
+	offsetof(struct pt_regs, cx),
+	offsetof(struct pt_regs, dx),
+	offsetof(struct pt_regs, bx),
+	offsetof(struct pt_regs, sp),
+	offsetof(struct pt_regs, bp),
+	offsetof(struct pt_regs, si),
+	offsetof(struct pt_regs, di),
+#ifdef CONFIG_X86_64
+	offsetof(struct pt_regs, r8),
+	offsetof(struct pt_regs, r9),
+	offsetof(struct pt_regs, r10),
+	offsetof(struct pt_regs, r11),
+	offsetof(struct pt_regs, r12),
+	offsetof(struct pt_regs, r13),
+	offsetof(struct pt_regs, r14),
+	offsetof(struct pt_regs, r15),
+#endif
+};
+
+static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
+
+	int3_emulate_call(regs, regs_get_register(regs, offs));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
+
+static void kprobe_emulate_jmp_indirect(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
+
+	int3_emulate_jmp(regs, regs_get_register(regs, offs));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jmp_indirect);
+
+static int prepare_emulation(struct kprobe *p, struct insn *insn)
+{
+	insn_byte_t opcode = insn->opcode.bytes[0];
+
+	switch (opcode) {
+	case 0xfa:		/* cli */
+	case 0xfb:		/* sti */
+	case 0x9c:		/* pushfl */
+	case 0x9d:		/* popf/popfd */
+		/*
+		 * IF modifiers must be emulated since it will enable interrupt while
+		 * int3 single stepping.
+		 */
+		p->ainsn.emulate_op = kprobe_emulate_ifmodifiers;
+		p->ainsn.opcode = opcode;
+		break;
+	case 0xc2:	/* ret/lret */
+	case 0xc3:
+	case 0xca:
+	case 0xcb:
+		p->ainsn.emulate_op = kprobe_emulate_ret;
+		break;
+	case 0x9a:	/* far call absolute -- segment is not supported */
+	case 0xea:	/* far jmp absolute -- segment is not supported */
+	case 0xcc:	/* int3 */
+	case 0xcf:	/* iret -- in-kernel IRET is not supported */
+		return -EOPNOTSUPP;
+		break;
+	case 0xe8:	/* near call relative */
+		p->ainsn.emulate_op = kprobe_emulate_call;
+		if (insn->immediate.nbytes == 2)
+			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+		else
+			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		break;
+	case 0xeb:	/* short jump relative */
+	case 0xe9:	/* near jump relative */
+		p->ainsn.emulate_op = kprobe_emulate_jmp;
+		if (insn->immediate.nbytes == 1)
+			p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+		else if (insn->immediate.nbytes == 2)
+			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+		else
+			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		break;
+	case 0x70 ... 0x7f:
+		/* 1 byte conditional jump */
+		p->ainsn.emulate_op = kprobe_emulate_jcc;
+		p->ainsn.jcc.type = opcode & 0xf;
+		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		break;
+	case 0x0f:
+		opcode = insn->opcode.bytes[1];
+		if ((opcode & 0xf0) == 0x80) {
+			/* 2 bytes Conditional Jump */
+			p->ainsn.emulate_op = kprobe_emulate_jcc;
+			p->ainsn.jcc.type = opcode & 0xf;
+			if (insn->immediate.nbytes == 2)
+				p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+			else
+				p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		} else if (opcode == 0x01 &&
+			   X86_MODRM_REG(insn->modrm.bytes[0]) == 0 &&
+			   X86_MODRM_MOD(insn->modrm.bytes[0]) == 3) {
+			/* VM extensions - not supported */
+			return -EOPNOTSUPP;
+		}
+		break;
+	case 0xe0:	/* Loop NZ */
+	case 0xe1:	/* Loop */
+	case 0xe2:	/* Loop */
+	case 0xe3:	/* J*CXZ */
+		p->ainsn.emulate_op = kprobe_emulate_loop;
+		p->ainsn.loop.type = opcode & 0x3;
+		p->ainsn.loop.asize = insn->addr_bytes * 8;
+		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+		break;
+	case 0xff:
+		/*
+		 * Since the 0xff is an extended group opcode, the instruction
+		 * is determined by the MOD/RM byte.
+		 */
+		opcode = insn->modrm.bytes[0];
+		if ((opcode & 0x30) == 0x10) {
+			if ((opcode & 0x8) == 0x8)
+				return -EOPNOTSUPP;	/* far call */
+			/* call absolute, indirect */
+			p->ainsn.emulate_op = kprobe_emulate_call_indirect;
+		} else if ((opcode & 0x30) == 0x20) {
+			if ((opcode & 0x8) == 0x8)
+				return -EOPNOTSUPP;	/* far jmp */
+			/* jmp near absolute indirect */
+			p->ainsn.emulate_op = kprobe_emulate_jmp_indirect;
+		} else
+			break;
+
+		if (insn->addr_bytes != sizeof(unsigned long))
+			return -EOPNOTSUPP;	/* Don't support differnt size */
+		if (X86_MODRM_MOD(opcode) != 3)
+			return -EOPNOTSUPP;	/* TODO: support memory addressing */
+
+		p->ainsn.indirect.reg = X86_MODRM_RM(opcode);
+#ifdef CONFIG_X86_64
+		if (X86_REX_B(insn->rex_prefix.value))
+			p->ainsn.indirect.reg += 8;
+#endif
+		break;
+	default:
+		break;
+	}
+	p->ainsn.size = insn->length;
+
+	return 0;
+}
+
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	int len;
+	int ret, len;
 
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	len = __copy_instruction(buf, p->addr, p->ainsn.insn, &insn);
 	if (!len)
 		return -EINVAL;
 
-	/*
-	 * __copy_instruction can modify the displacement of the instruction,
-	 * but it doesn't affect boostable check.
-	 */
-	len = prepare_boost(buf, p, &insn);
+	/* Analyze the opcode and setup emulate functions */
+	ret = prepare_emulation(p, &insn);
+	if (ret < 0)
+		return ret;
 
-	/* Check whether the instruction modifies Interrupt Flag or not */
-	p->ainsn.if_modifier = is_IF_modifier(buf);
+	/* Add int3 for single-step or booster jmp */
+	len = prepare_singlestep(buf, p, &insn);
+	if (len < 0)
+		return len;
 
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
@@ -507,6 +738,9 @@ int arch_prepare_kprobe(struct kprobe *p)
 
 	if (!can_probe((unsigned long)p->addr))
 		return -EILSEQ;
+
+	memset(&p->ainsn, 0, sizeof(p->ainsn));
+
 	/* insn: must be on special executable page on x86. */
 	p->ainsn.insn = get_insn_slot();
 	if (!p->ainsn.insn)
@@ -574,29 +808,7 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 {
 	__this_cpu_write(current_kprobe, p);
 	kcb->kprobe_saved_flags = kcb->kprobe_old_flags
-		= (regs->flags & (X86_EFLAGS_TF | X86_EFLAGS_IF));
-	if (p->ainsn.if_modifier)
-		kcb->kprobe_saved_flags &= ~X86_EFLAGS_IF;
-}
-
-static nokprobe_inline void clear_btf(void)
-{
-	if (test_thread_flag(TIF_BLOCKSTEP)) {
-		unsigned long debugctl = get_debugctlmsr();
-
-		debugctl &= ~DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
-	}
-}
-
-static nokprobe_inline void restore_btf(void)
-{
-	if (test_thread_flag(TIF_BLOCKSTEP)) {
-		unsigned long debugctl = get_debugctlmsr();
-
-		debugctl |= DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
-	}
+		= (regs->flags & X86_EFLAGS_IF);
 }
 
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
@@ -611,6 +823,26 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
+static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
+			       struct kprobe_ctlblk *kcb)
+{
+	/* Restore back the original saved kprobes variables and continue. */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		/* This will restore both kcb and current_kprobe */
+		restore_previous_kprobe(kcb);
+	} else {
+		/*
+		 * Always update the kcb status because
+		 * reset_curent_kprobe() doesn't update kcb.
+		 */
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		if (cur->post_handler)
+			cur->post_handler(cur, regs, 0);
+		reset_current_kprobe();
+	}
+}
+NOKPROBE_SYMBOL(kprobe_post_process);
+
 static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 			     struct kprobe_ctlblk *kcb, int reenter)
 {
@@ -618,7 +850,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		return;
 
 #if !defined(CONFIG_PREEMPTION)
-	if (p->ainsn.boostable && !p->post_handler) {
+	if (p->ainsn.boostable) {
 		/* Boost up -- we can execute copied instructions directly */
 		if (!reenter)
 			reset_current_kprobe();
@@ -637,18 +869,50 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		kcb->kprobe_status = KPROBE_REENTER;
 	} else
 		kcb->kprobe_status = KPROBE_HIT_SS;
-	/* Prepare real single stepping */
-	clear_btf();
-	regs->flags |= X86_EFLAGS_TF;
+
+	if (p->ainsn.emulate_op) {
+		p->ainsn.emulate_op(p, regs);
+		kprobe_post_process(p, regs, kcb);
+		return;
+	}
+
+	/* Disable interrupt, and set ip register on trampoline */
 	regs->flags &= ~X86_EFLAGS_IF;
-	/* single step inline if the instruction is an int3 */
-	if (p->opcode == INT3_INSN_OPCODE)
-		regs->ip = (unsigned long)p->addr;
-	else
-		regs->ip = (unsigned long)p->ainsn.insn;
+	regs->ip = (unsigned long)p->ainsn.insn;
 }
 NOKPROBE_SYMBOL(setup_singlestep);
 
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "int3"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn. We also doesn't use trap, but "int3" again
+ * right after the copied instruction.
+ * Different from the trap single-step, "int3" single-step can not
+ * handle the instruction which changes the ip register, e.g. jmp,
+ * call, conditional jmp, and the instructions which changes the IF
+ * flags because interrupt must be disabled around the single-stepping.
+ * Such instructions are software emulated, but others are single-stepped
+ * using "int3".
+ *
+ * When the 2nd "int3" handled, the regs->ip and regs->flags needs to
+ * be adjusted, so that we can resume execution on correct code.
+ */
+static void resume_singlestep(struct kprobe *p, struct pt_regs *regs,
+			      struct kprobe_ctlblk *kcb)
+{
+	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
+	unsigned long orig_ip = (unsigned long)p->addr;
+
+	/* Restore saved interrupt flag and ip register */
+	regs->flags |= kcb->kprobe_saved_flags;
+	/* Note that regs->ip is executed int3 so must be a step back */
+	regs->ip += (orig_ip - copy_ip) - INT3_INSN_SIZE;
+}
+NOKPROBE_SYMBOL(resume_singlestep);
+
 /*
  * We have reentered the kprobe_handler(), since another probe was hit while
  * within the handler. We save the original kprobes variables and just single
@@ -684,6 +948,12 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(reenter_kprobe);
 
+static nokprobe_inline int kprobe_is_ss(struct kprobe_ctlblk *kcb)
+{
+	return (kcb->kprobe_status == KPROBE_HIT_SS ||
+		kcb->kprobe_status == KPROBE_REENTER);
+}
+
 /*
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled throughout this function.
@@ -728,7 +998,18 @@ int kprobe_int3_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			return 1;
 		}
-	} else if (*addr != INT3_INSN_OPCODE) {
+	} else if (kprobe_is_ss(kcb)) {
+		p = kprobe_running();
+		if ((unsigned long)p->ainsn.insn < regs->ip &&
+		    (unsigned long)p->ainsn.insn + MAX_INSN_SIZE > regs->ip) {
+			/* Most provably this is the second int3 for singlestep */
+			resume_singlestep(p, regs, kcb);
+			kprobe_post_process(p, regs, kcb);
+			return 1;
+		}
+	}
+
+	if (*addr != INT3_INSN_OPCODE) {
 		/*
 		 * The breakpoint instruction was removed right
 		 * after we hit it.  Another cpu has removed
@@ -801,135 +1082,6 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 
-/*
- * Called after single-stepping.  p->addr is the address of the
- * instruction whose first byte has been replaced by the "int 3"
- * instruction.  To avoid the SMP problems that can occur when we
- * temporarily put back the original opcode to single-step, we
- * single-stepped a copy of the instruction.  The address of this
- * copy is p->ainsn.insn.
- *
- * This function prepares to return from the post-single-step
- * interrupt.  We have to fix up the stack as follows:
- *
- * 0) Except in the case of absolute or indirect jump or call instructions,
- * the new ip is relative to the copied instruction.  We need to make
- * it relative to the original instruction.
- *
- * 1) If the single-stepped instruction was pushfl, then the TF and IF
- * flags are set in the just-pushed flags, and may need to be cleared.
- *
- * 2) If the single-stepped instruction was a call, the return address
- * that is atop the stack is the address following the copied instruction.
- * We need to make it the address following the original instruction.
- *
- * If this is the first time we've single-stepped the instruction at
- * this probepoint, and the instruction is boostable, boost it: add a
- * jump instruction after the copied instruction, that jumps to the next
- * instruction after the probepoint.
- */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs,
-			     struct kprobe_ctlblk *kcb)
-{
-	unsigned long *tos = stack_addr(regs);
-	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
-	unsigned long orig_ip = (unsigned long)p->addr;
-	kprobe_opcode_t *insn = p->ainsn.insn;
-
-	/* Skip prefixes */
-	insn = skip_prefixes(insn);
-
-	regs->flags &= ~X86_EFLAGS_TF;
-	switch (*insn) {
-	case 0x9c:	/* pushfl */
-		*tos &= ~(X86_EFLAGS_TF | X86_EFLAGS_IF);
-		*tos |= kcb->kprobe_old_flags;
-		break;
-	case 0xc2:	/* iret/ret/lret */
-	case 0xc3:
-	case 0xca:
-	case 0xcb:
-	case 0xcf:
-	case 0xea:	/* jmp absolute -- ip is correct */
-		/* ip is already adjusted, no more changes required */
-		p->ainsn.boostable = true;
-		goto no_change;
-	case 0xe8:	/* call relative - Fix return addr */
-		*tos = orig_ip + (*tos - copy_ip);
-		break;
-#ifdef CONFIG_X86_32
-	case 0x9a:	/* call absolute -- same as call absolute, indirect */
-		*tos = orig_ip + (*tos - copy_ip);
-		goto no_change;
-#endif
-	case 0xff:
-		if ((insn[1] & 0x30) == 0x10) {
-			/*
-			 * call absolute, indirect
-			 * Fix return addr; ip is correct.
-			 * But this is not boostable
-			 */
-			*tos = orig_ip + (*tos - copy_ip);
-			goto no_change;
-		} else if (((insn[1] & 0x31) == 0x20) ||
-			   ((insn[1] & 0x31) == 0x21)) {
-			/*
-			 * jmp near and far, absolute indirect
-			 * ip is correct. And this is boostable
-			 */
-			p->ainsn.boostable = true;
-			goto no_change;
-		}
-	default:
-		break;
-	}
-
-	regs->ip += orig_ip - copy_ip;
-
-no_change:
-	restore_btf();
-}
-NOKPROBE_SYMBOL(resume_execution);
-
-/*
- * Interrupts are disabled on entry as trap1 is an interrupt gate and they
- * remain disabled throughout this function.
- */
-int kprobe_debug_handler(struct pt_regs *regs)
-{
-	struct kprobe *cur = kprobe_running();
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (!cur)
-		return 0;
-
-	resume_execution(cur, regs, kcb);
-	regs->flags |= kcb->kprobe_saved_flags;
-
-	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		cur->post_handler(cur, regs, 0);
-	}
-
-	/* Restore back the original saved kprobes variables and continue. */
-	if (kcb->kprobe_status == KPROBE_REENTER) {
-		restore_previous_kprobe(kcb);
-		goto out;
-	}
-	reset_current_kprobe();
-out:
-	/*
-	 * if somebody else is singlestepping across a probe point, flags
-	 * will have TF set, in which case, continue the remaining processing
-	 * of do_debug, as if this is not a probe hit.
-	 */
-	if (regs->flags & X86_EFLAGS_TF)
-		return 0;
-
-	return 1;
-}
-NOKPROBE_SYMBOL(kprobe_debug_handler);
-
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
@@ -947,20 +1099,9 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * normal page fault.
 		 */
 		regs->ip = (unsigned long)cur->addr;
-		/*
-		 * Trap flag (TF) has been set here because this fault
-		 * happened where the single stepping will be done.
-		 * So clear it by resetting the current kprobe:
-		 */
-		regs->flags &= ~X86_EFLAGS_TF;
-		/*
-		 * Since the single step (trap) has been cancelled,
-		 * we need to restore BTF here.
-		 */
-		restore_btf();
 
 		/*
-		 * If the TF flag was set before the kprobe hit,
+		 * If the IF flag was set before the kprobe hit,
 		 * don't touch it:
 		 */
 		regs->flags |= kcb->kprobe_old_flags;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3780c728345c..28f5cc0a9dec 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -198,6 +198,8 @@ DEFINE_IDTENTRY(exc_divide_error)
 {
 	do_error_trap(regs, 0, "divide error", X86_TRAP_DE, SIGFPE,
 		      FPE_INTDIV, error_get_trap_addr(regs));
+
+	amd_clear_divider();
 }
 
 DEFINE_IDTENTRY(exc_overflow)
@@ -917,9 +919,6 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
-	if (kprobe_debug_handler(regs))
-		goto out;
-
 	/*
 	 * The kernel doesn't use INT1
 	 */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9aedc7b06da7..2445c6103895 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -135,8 +135,7 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
 #define KVM_VM_CR0_ALWAYS_ON				\
-	(KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST | 	\
-	 X86_CR0_WP | X86_CR0_PG | X86_CR0_PE)
+	(KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST | X86_CR0_PG | X86_CR0_PE)
 
 #define KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR4_VMXE
 #define KVM_PMODE_VM_CR4_ALWAYS_ON (X86_CR4_PAE | X86_CR4_VMXE)
@@ -1520,6 +1519,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long old_rflags;
 
+	/*
+	 * Unlike CR0 and CR4, RFLAGS handling requires checking if the vCPU
+	 * is an unrestricted guest in order to mark L2 as needing emulation
+	 * if L1 runs L2 as a restricted guest.
+	 */
 	if (is_unrestricted_guest(vcpu)) {
 		kvm_register_mark_available(vcpu, VCPU_EXREG_RFLAGS);
 		vmx->rflags = rflags;
@@ -3064,42 +3068,22 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
 }
 
-static void ept_update_paging_mode_cr0(unsigned long *hw_cr0,
-					unsigned long cr0,
-					struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-		vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
-	if (!(cr0 & X86_CR0_PG)) {
-		/* From paging/starting to nonpaging */
-		exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-					  CPU_BASED_CR3_STORE_EXITING);
-		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-	} else if (!is_paging(vcpu)) {
-		/* From nonpaging to paging */
-		exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-					    CPU_BASED_CR3_STORE_EXITING);
-		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-	}
-
-	if (!(cr0 & X86_CR0_WP))
-		*hw_cr0 &= ~X86_CR0_WP;
-}
+#define CR3_EXITING_BITS (CPU_BASED_CR3_LOAD_EXITING | \
+			  CPU_BASED_CR3_STORE_EXITING)
 
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long hw_cr0;
+	u32 tmp;
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
+		if (!enable_ept)
+			hw_cr0 |= X86_CR0_WP;
 
 		if (vmx->rmode.vm86_active && (cr0 & X86_CR0_PE))
 			enter_pmode(vcpu);
@@ -3117,8 +3101,47 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu))
-		ept_update_paging_mode_cr0(&hw_cr0, cr0, vcpu);
+	if (enable_ept && !enable_unrestricted_guest) {
+		/*
+		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
+		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
+		 * (correctly) stop reading vmcs.GUEST_CR3 because it thinks
+		 * KVM's CR3 is installed.
+		 */
+		if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
+			vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
+
+		/*
+		 * When running with EPT but not unrestricted guest, KVM must
+		 * intercept CR3 accesses when paging is _disabled_.  This is
+		 * necessary because restricted guests can't actually run with
+		 * paging disabled, and so KVM stuffs its own CR3 in order to
+		 * run the guest when identity mapped page tables.
+		 *
+		 * Do _NOT_ check the old CR0.PG, e.g. to optimize away the
+		 * update, it may be stale with respect to CR3 interception,
+		 * e.g. after nested VM-Enter.
+		 *
+		 * Lastly, honor L1's desires, i.e. intercept CR3 loads and/or
+		 * stores to forward them to L1, even if KVM does not need to
+		 * intercept them to preserve its identity mapped page tables.
+		 */
+		if (!(cr0 & X86_CR0_PG)) {
+			exec_controls_setbit(vmx, CR3_EXITING_BITS);
+		} else if (!is_guest_mode(vcpu)) {
+			exec_controls_clearbit(vmx, CR3_EXITING_BITS);
+		} else {
+			tmp = exec_controls_get(vmx);
+			tmp &= ~CR3_EXITING_BITS;
+			tmp |= get_vmcs12(vcpu)->cpu_based_vm_exec_control & CR3_EXITING_BITS;
+			exec_controls_set(vmx, tmp);
+		}
+
+		if (!is_paging(vcpu) != !(cr0 & X86_CR0_PG)) {
+			vcpu->arch.cr0 = cr0;
+			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		}
+	}
 
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
@@ -3213,7 +3236,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	unsigned long hw_cr4;
 
 	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr4 |= KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else if (vmx->rmode.vm86_active)
 		hw_cr4 |= KVM_RMODE_VM_CR4_ALWAYS_ON;
@@ -3233,7 +3256,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	vcpu->arch.cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
-	if (!is_unrestricted_guest(vcpu)) {
+	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
 			if (!is_paging(vcpu)) {
 				hw_cr4 &= ~X86_CR4_PAE;
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index b04a68950ff1..fc42d649c7e4 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -56,6 +56,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
+	s32 qos_value;
+	int index;
 	int ret;
 
 	if (!pr)
@@ -75,17 +77,30 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		return -ENODEV;
 	}
 
+	index = ppc;
+
+	if (pr->performance_platform_limit == index ||
+	    ppc >= pr->performance->state_count)
+		return 0;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
-		       (int)ppc, ppc ? "" : "not");
+		 index, index ? "is" : "is not");
 
-	pr->performance_platform_limit = (int)ppc;
+	pr->performance_platform_limit = index;
 
-	if (ppc >= pr->performance->state_count ||
-	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
+	if (unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = freq_qos_update_request(&pr->perflib_req,
-			pr->performance->states[ppc].core_frequency * 1000);
+	/*
+	 * If _PPC returns 0, it means that all of the available states can be
+	 * used ("no limit").
+	 */
+	if (index == 0)
+		qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		qos_value = pr->performance->states[index].core_frequency * 1000;
+
+	ret = freq_qos_update_request(&pr->perflib_req, qos_value);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
 			pr->id, ret);
@@ -168,9 +183,16 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 		if (!pr)
 			continue;
 
+		/*
+		 * Reset performance_platform_limit in case there is a stale
+		 * value in it, so as to make it match the "no limit" QoS value
+		 * below.
+		 */
+		pr->performance_platform_limit = 0;
+
 		ret = freq_qos_add_request(&policy->constraints,
-					   &pr->perflib_req,
-					   FREQ_QOS_MAX, INT_MAX);
+					   &pr->perflib_req, FREQ_QOS_MAX,
+					   FREQ_QOS_MAX_DEFAULT_VALUE);
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 1532b2e3c672..921738577440 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808..922ed457db19 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -25,8 +25,11 @@ extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
 #define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
+#define WAKE_IRQ_DEDICATED_REVERSE	BIT(2)
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
-					 WAKE_IRQ_DEDICATED_MANAGED)
+					 WAKE_IRQ_DEDICATED_MANAGED | \
+					 WAKE_IRQ_DEDICATED_REVERSE)
+#define WAKE_IRQ_DEDICATED_ENABLED	BIT(3)
 
 struct wake_irq {
 	struct device *dev;
@@ -39,7 +42,8 @@ extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_enable_wake_irq_check(struct device *dev,
 					 bool can_change_status);
-extern void dev_pm_disable_wake_irq_check(struct device *dev);
+extern void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable);
+extern void dev_pm_enable_wake_irq_complete(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 360094692d29..fbbc3ed143f2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -675,6 +675,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	if (retval)
 		goto fail;
 
+	dev_pm_enable_wake_irq_complete(dev);
+
  no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
@@ -720,7 +722,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, true);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -903,7 +905,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, false);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8e021082dba8..aea690c64e39 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -145,24 +145,7 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	return IRQ_HANDLED;
 }
 
-/**
- * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
- * @dev: Device entry
- * @irq: Device wake-up interrupt
- *
- * Unless your hardware has separate wake-up interrupts in addition
- * to the device IO interrupts, you don't need this.
- *
- * Sets up a threaded interrupt handler for a device that has
- * a dedicated wake-up interrupt in addition to the device IO
- * interrupt.
- *
- * The interrupt starts disabled, and needs to be managed for
- * the device by the bus code or the device driver using
- * dev_pm_enable_wake_irq() and dev_pm_disable_wake_irq()
- * functions.
- */
-int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
 {
 	struct wake_irq *wirq;
 	int err;
@@ -200,7 +183,7 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	if (err)
 		goto err_free_irq;
 
-	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED;
+	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED | flag;
 
 	return err;
 
@@ -213,8 +196,57 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
 	return err;
 }
+
+
+/**
+ * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has
+ * a dedicated wake-up interrupt in addition to the device IO
+ * interrupt.
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+{
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
+}
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
+/**
+ * dev_pm_set_dedicated_wake_irq_reverse - Request a dedicated wake-up interrupt
+ *                                         with reverse enable ordering
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has a dedicated
+ * wake-up interrupt in addition to the device IO interrupt. It sets
+ * the status of WAKE_IRQ_DEDICATED_REVERSE to tell rpm_suspend()
+ * to enable dedicated wake-up interrupt after running the runtime suspend
+ * callback for @dev.
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
+
 /**
  * dev_pm_enable_wake_irq - Enable device wake-up interrupt
  * @dev: Device
@@ -285,25 +317,56 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	enable_irq(wirq->irq);
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE)) {
+		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
  * dev_pm_disable_wake_irq_check - Checks and disables wake-up interrupt
  * @dev: Device
+ * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
  *
  * Disables wake-up interrupt conditionally based on status.
  * Should be only called from rpm_suspend() and rpm_resume() path.
  */
-void dev_pm_disable_wake_irq_check(struct device *dev)
+void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
 	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
 		return;
 
-	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+		return;
+
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED) {
+		wirq->status &= ~WAKE_IRQ_DEDICATED_ENABLED;
 		disable_irq_nosync(wirq->irq);
+	}
+}
+
+/**
+ * dev_pm_enable_wake_irq_complete - enable wake IRQ not enabled before
+ * @dev: Device using the wake IRQ
+ *
+ * Enable wake IRQ conditionally based on status, mainly used if want to
+ * enable wake IRQ after running ->runtime_suspend() which depends on
+ * WAKE_IRQ_DEDICATED_REVERSE.
+ *
+ * Should be only called from rpm_suspend() path.
+ */
+void dev_pm_enable_wake_irq_complete(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
+		return;
+
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+		enable_irq(wirq->irq);
 }
 
 /**
@@ -320,7 +383,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 
 	if (device_may_wakeup(wirq->dev)) {
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -343,7 +406,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d86fbea54652..7444cc2a6c86 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2109,7 +2109,8 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
+		BLK_MQ_F_NO_SCHED;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 365761055df3..d7c440ac465f 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -314,6 +314,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0;
 	int status;
 	u32 expected;
+	int rc;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -333,8 +334,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
+	rc = recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE);
+	if (rc < 0) {
+		size = rc;
+		goto out;
+	}
+	size += rc;
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4b06b81d8bb0..4359ed1d3b7e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -443,20 +443,6 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 			 (u32) cpu->acpi_perf_data.states[i].control);
 	}
 
-	/*
-	 * The _PSS table doesn't contain whole turbo frequency range.
-	 * This just contains +1 MHZ above the max non turbo frequency,
-	 * with control value corresponding to max turbo ratio. But
-	 * when cpufreq set policy is called, it will call with this
-	 * max frequency, which will cause a reduced performance as
-	 * this driver uses real max turbo frequency as the max
-	 * frequency. So correct this frequency in _PSS table to
-	 * correct max turbo frequency based on the turbo state.
-	 * Also need to convert to MHz as _PSS freq is in MHz.
-	 */
-	if (!global.turbo_disabled)
-		cpu->acpi_perf_data.states[0].core_frequency =
-					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
 	pr_debug("_PPC limits will be enforced\n");
 
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
index f7f5f770e0fb..e19eb7c982a1 100644
--- a/drivers/gpio/gpio-tps68470.c
+++ b/drivers/gpio/gpio-tps68470.c
@@ -91,13 +91,13 @@ static int tps68470_gpio_output(struct gpio_chip *gc, unsigned int offset,
 	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
 	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
 
+	/* Set the initial value */
+	tps68470_gpio_set(gc, offset, value);
+
 	/* rest are always outputs */
 	if (offset >= TPS68470_N_REGULAR_GPIO)
 		return 0;
 
-	/* Set the initial value */
-	tps68470_gpio_set(gc, offset, value);
-
 	return regmap_update_bits(regmap, TPS68470_GPIO_CTL_REG_A(offset),
 				 TPS68470_GPIO_MODE_MASK,
 				 TPS68470_GPIO_MODE_OUT_CMOS);
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 0fcba2bc26b8..9ae0e60ecac3 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -81,7 +81,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 			 * since we've already mapped it once in
 			 * submit_reloc()
 			 */
-			if (WARN_ON(!ptr))
+			if (WARN_ON(IS_ERR_OR_NULL(ptr)))
 				return;
 
 			for (i = 0; i < dwords; i++) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 2fb58b7098e4..3bd2065a9d30 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -200,7 +200,7 @@ static const struct a6xx_shader_block {
 	SHADER(A6XX_SP_LB_3_DATA, 0x800),
 	SHADER(A6XX_SP_LB_4_DATA, 0x800),
 	SHADER(A6XX_SP_LB_5_DATA, 0x200),
-	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
+	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
 	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
 	SHADER(A6XX_SP_UAV_DATA, 0x80),
 	SHADER(A6XX_SP_INST_TAG, 0x80),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
index cf4b9b5964c6..cd6c3518ba02 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
@@ -14,19 +14,6 @@
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
-/**
- * enum dpu_core_perf_data_bus_id - data bus identifier
- * @DPU_CORE_PERF_DATA_BUS_ID_MNOC: DPU/MNOC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_LLCC: MNOC/LLCC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_EBI: LLCC/EBI data bus
- */
-enum dpu_core_perf_data_bus_id {
-	DPU_CORE_PERF_DATA_BUS_ID_MNOC,
-	DPU_CORE_PERF_DATA_BUS_ID_LLCC,
-	DPU_CORE_PERF_DATA_BUS_ID_EBI,
-	DPU_CORE_PERF_DATA_BUS_ID_MAX,
-};
-
 /**
  * struct dpu_core_perf_params - definition of performance parameters
  * @max_per_pipe_ib: maximum instantaneous bandwidth request
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f673292eec9d..8fe3be20af62 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -115,7 +115,7 @@ static void ttm_bo_add_mem_to_lru(struct ttm_buffer_object *bo,
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_resource_manager *man;
 
-	if (!list_empty(&bo->lru))
+	if (!list_empty(&bo->lru) || bo->pin_count)
 		return;
 
 	if (mem->placement & TTM_PL_FLAG_NO_EVICT)
@@ -165,7 +165,8 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 	ttm_bo_del_from_lru(bo);
 	ttm_bo_add_mem_to_lru(bo, &bo->mem);
 
-	if (bulk && !(bo->mem.placement & TTM_PL_FLAG_NO_EVICT)) {
+	if (bulk && !(bo->mem.placement & TTM_PL_FLAG_NO_EVICT) &&
+	    !bo->pin_count) {
 		switch (bo->mem.mem_type) {
 		case TTM_PL_TT:
 			ttm_bo_bulk_move_set_pos(&bulk->tt[bo->priority], bo);
@@ -544,8 +545,9 @@ static void ttm_bo_release(struct kref *kref)
 		 * shrinkers, now that they are queued for
 		 * destruction.
 		 */
-		if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT) {
+		if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT || bo->pin_count) {
 			bo->mem.placement &= ~TTM_PL_FLAG_NO_EVICT;
+			bo->pin_count = 0;
 			ttm_bo_del_from_lru(bo);
 			ttm_bo_add_mem_to_lru(bo, &bo->mem);
 		}
@@ -670,6 +672,13 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 {
 	bool ret = false;
 
+	if (bo->pin_count) {
+		*locked = false;
+		if (busy)
+			*busy = false;
+		return false;
+	}
+
 	if (bo->base.resv == ctx->resv) {
 		dma_resv_assert_held(bo->base.resv);
 		if (ctx->flags & TTM_OPT_FLAG_ALLOW_RES_EVICT)
@@ -1174,6 +1183,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	bo->moving = NULL;
 	bo->mem.placement = TTM_PL_FLAG_CACHED;
 	bo->acc_size = acc_size;
+	bo->pin_count = 0;
 	bo->sg = sg;
 	if (resv) {
 		bo->base.resv = resv;
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fb2a25f8408f..1968df9743fc 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -352,7 +352,6 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 		return -ENOMEM;
 
 	fbo->base = *bo;
-	fbo->base.mem.placement |= TTM_PL_FLAG_NO_EVICT;
 
 	ttm_bo_get(bo);
 	fbo->bo = bo;
@@ -372,6 +371,7 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	kref_init(&fbo->base.kref);
 	fbo->base.destroy = &ttm_transfered_destroy;
 	fbo->base.acc_size = 0;
+	fbo->base.pin_count = 1;
 	if (bo->type != ttm_bo_type_sg)
 		fbo->base.base.resv = &fbo->base.base._resv;
 
diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 604af2f6103a..88eddb8d61d3 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -708,7 +708,7 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 46 && !(reg & 0x02))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 9f71daf6db64..c073f5b8833a 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -694,10 +694,8 @@ static int iic_probe(struct platform_device *ofdev)
 	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&ofdev->dev, "failed to allocate device data\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(ofdev, dev);
 
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a3363b20f168..a06c4b76894a 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -970,12 +970,10 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&adev->dev, "cannot allocate memory\n");
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
 	dev->vendor = vendor;
 	dev->adev = adev;
 	nmk_i2c_of_probe(np, dev);
@@ -996,30 +994,21 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
 				resource_size(&adev->res));
-	if (!dev->virtbase) {
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	if (!dev->virtbase)
+		return -ENOMEM;
 
 	dev->irq = adev->irq[0];
 	ret = devm_request_irq(&adev->dev, dev->irq, i2c_irq_handler, 0,
 				DRIVER_NAME, dev);
 	if (ret) {
 		dev_err(&adev->dev, "cannot claim the irq %d\n", dev->irq);
-		goto err_no_mem;
+		return ret;
 	}
 
-	dev->clk = devm_clk_get(&adev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&adev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
-		dev_err(&adev->dev, "could not get i2c clock\n");
-		ret = PTR_ERR(dev->clk);
-		goto err_no_mem;
-	}
-
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		dev_err(&adev->dev, "can't prepare_enable clock\n");
-		goto err_no_mem;
+		dev_err(&adev->dev, "could enable i2c clock\n");
+		return PTR_ERR(dev->clk);
 	}
 
 	init_hw(dev);
@@ -1042,22 +1031,15 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	ret = i2c_add_adapter(adap);
 	if (ret)
-		goto err_no_adap;
+		return ret;
 
 	pm_runtime_put(&adev->dev);
 
 	return 0;
-
- err_no_adap:
-	clk_disable_unprepare(dev->clk);
- err_no_mem:
-
-	return ret;
 }
 
 static void nmk_i2c_remove(struct amba_device *adev)
 {
-	struct resource *res = &adev->res;
 	struct nmk_i2c_dev *dev = amba_get_drvdata(adev);
 
 	i2c_del_adapter(&dev->adap);
@@ -1066,8 +1048,6 @@ static void nmk_i2c_remove(struct amba_device *adev)
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	clk_disable_unprepare(dev->clk);
-	release_mem_region(res->start, resource_size(res));
 }
 
 static struct i2c_vendor_data vendor_stn8815 = {
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 319d1fa617c8..051b904cb35f 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -443,9 +443,8 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 		goto out0;
 	}
 
-	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
-		dev_err(&pdev->dev, "no mem for private data\n");
 		ret = -ENOMEM;
 		goto out0;
 	}
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 7279ca0eaa2d..d1fa9ff5aeab 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -226,10 +226,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!dev)
 		goto error;
-	}
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 255194029e2d..50b355e34445 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -530,15 +530,15 @@ static int set_qp_rss(struct mlx4_ib_dev *dev, struct mlx4_ib_rss *rss_ctx,
 		return (-EOPNOTSUPP);
 	}
 
-	if (ucmd->rx_hash_fields_mask & ~(MLX4_IB_RX_HASH_SRC_IPV4	|
-					  MLX4_IB_RX_HASH_DST_IPV4	|
-					  MLX4_IB_RX_HASH_SRC_IPV6	|
-					  MLX4_IB_RX_HASH_DST_IPV6	|
-					  MLX4_IB_RX_HASH_SRC_PORT_TCP	|
-					  MLX4_IB_RX_HASH_DST_PORT_TCP	|
-					  MLX4_IB_RX_HASH_SRC_PORT_UDP	|
-					  MLX4_IB_RX_HASH_DST_PORT_UDP  |
-					  MLX4_IB_RX_HASH_INNER)) {
+	if (ucmd->rx_hash_fields_mask & ~(u64)(MLX4_IB_RX_HASH_SRC_IPV4	|
+					       MLX4_IB_RX_HASH_DST_IPV4	|
+					       MLX4_IB_RX_HASH_SRC_IPV6	|
+					       MLX4_IB_RX_HASH_DST_IPV6	|
+					       MLX4_IB_RX_HASH_SRC_PORT_TCP |
+					       MLX4_IB_RX_HASH_DST_PORT_TCP |
+					       MLX4_IB_RX_HASH_SRC_PORT_UDP |
+					       MLX4_IB_RX_HASH_DST_PORT_UDP |
+					       MLX4_IB_RX_HASH_INNER)) {
 		pr_debug("RX Hash fields_mask has unsupported mask (0x%llx)\n",
 			 ucmd->rx_hash_fields_mask);
 		return (-EOPNOTSUPP);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 08a2a7afafd3..3f57f7dfb822 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1390,7 +1390,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 1bd0621c4ce2..4827a1183247 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -82,6 +82,7 @@ struct bcm6345_l1_chip {
 };
 
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -115,17 +116,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l1_chip *intc,
 
 static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 {
-	struct bcm6345_l1_chip *intc = irq_desc_get_handler_data(desc);
-	struct bcm6345_l1_cpu *cpu;
+	struct bcm6345_l1_cpu *cpu = irq_desc_get_handler_data(desc);
+	struct bcm6345_l1_chip *intc = cpu->intc;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
-#ifdef CONFIG_SMP
-	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
-#else
-	cpu = intc->cpus[0];
-#endif
-
 	chained_irq_enter(chip, desc);
 
 	for (idx = 0; idx < intc->n_words; idx++) {
@@ -257,6 +252,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu)
 		return -ENOMEM;
 
+	cpu->intc = intc;
 	cpu->map_base = ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -272,7 +268,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ec091c64d47..f1fa98e5ea13 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -267,13 +267,23 @@ static void vpe_to_cpuid_unlock(struct its_vpe *vpe, unsigned long flags)
 	raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
 }
 
+static struct irq_chip its_vpe_irq_chip;
+
 static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
 	int cpu;
 
-	if (map) {
-		cpu = vpe_to_cpuid_lock(map->vpe, flags);
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
+
+	if (vpe) {
+		cpu = vpe_to_cpuid_lock(vpe, flags);
 	} else {
 		/* Physical LPIs are already locked via the irq_desc lock */
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -287,10 +297,18 @@ static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 
 static void irq_to_cpuid_unlock(struct irq_data *d, unsigned long flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
+
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
 
-	if (map)
-		vpe_to_cpuid_unlock(map->vpe, flags);
+	if (vpe)
+		vpe_to_cpuid_unlock(vpe, flags);
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -1422,14 +1440,29 @@ static void wait_for_syncr(void __iomem *rdbase)
 		cpu_relax();
 }
 
-static void direct_lpi_inv(struct irq_data *d)
+static void __direct_lpi_inv(struct irq_data *d, u64 val)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
 	unsigned long flags;
-	u64 val;
 	int cpu;
 
+	/* Target the redistributor this LPI is currently routed to */
+	cpu = irq_to_cpuid_lock(d, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
+	wait_for_syncr(rdbase);
+
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	irq_to_cpuid_unlock(d, flags);
+}
+
+static void direct_lpi_inv(struct irq_data *d)
+{
+	struct its_vlpi_map *map = get_vlpi_map(d);
+	u64 val;
+
 	if (map) {
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
@@ -1442,15 +1475,7 @@ static void direct_lpi_inv(struct irq_data *d)
 		val = d->hwirq;
 	}
 
-	/* Target the redistributor this LPI is currently routed to */
-	cpu = irq_to_cpuid_lock(d, &flags);
-	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
-	gic_write_lpir(val, rdbase + GICR_INVLPIR);
-
-	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	irq_to_cpuid_unlock(d, flags);
+	__direct_lpi_inv(d, val);
 }
 
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
@@ -3916,18 +3941,10 @@ static void its_vpe_send_inv(struct irq_data *d)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 
-	if (gic_rdists->has_direct_lpi) {
-		void __iomem *rdbase;
-
-		/* Target the redistributor this VPE is currently known on */
-		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
-		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
-		wait_for_syncr(rdbase);
-		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-	} else {
+	if (gic_rdists->has_direct_lpi)
+		__direct_lpi_inv(d, d->parent_data->hwirq);
+	else
 		its_vpe_send_cmd(vpe, its_send_inv);
-	}
 }
 
 static void its_vpe_mask_irq(struct irq_data *d)
diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index eba58b99cd29..d6cf01c32a33 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -839,7 +839,7 @@ hfcpci_fill_fifo(struct bchannel *bch)
 		*z1t = cpu_to_le16(new_z1);	/* now send data */
 		if (bch->tx_idx < bch->tx_skb->len)
 			return;
-		dev_kfree_skb(bch->tx_skb);
+		dev_kfree_skb_any(bch->tx_skb);
 		if (get_next_bframe(bch))
 			goto next_t_frame;
 		return;
@@ -895,7 +895,7 @@ hfcpci_fill_fifo(struct bchannel *bch)
 	}
 	bz->za[new_f1].z1 = cpu_to_le16(new_z1);	/* for next buffer */
 	bz->f1 = new_f1;	/* next frame */
-	dev_kfree_skb(bch->tx_skb);
+	dev_kfree_skb_any(bch->tx_skb);
 	get_next_bframe(bch);
 }
 
@@ -1119,7 +1119,7 @@ tx_birq(struct bchannel *bch)
 	if (bch->tx_skb && bch->tx_idx < bch->tx_skb->len)
 		hfcpci_fill_fifo(bch);
 	else {
-		dev_kfree_skb(bch->tx_skb);
+		dev_kfree_skb_any(bch->tx_skb);
 		if (get_next_bframe(bch))
 			hfcpci_fill_fifo(bch);
 	}
@@ -2277,7 +2277,7 @@ _hfcpci_softirq(struct device *dev, void *unused)
 		return 0;
 
 	if (hc->hw.int_m2 & HFCPCI_IRQ_ENABLE) {
-		spin_lock(&hc->lock);
+		spin_lock_irq(&hc->lock);
 		bch = Sel_BCS(hc, hc->hw.bswapped ? 2 : 1);
 		if (bch && bch->state == ISDN_P_B_RAW) { /* B1 rx&tx */
 			main_rec_hfcpci(bch);
@@ -2288,7 +2288,7 @@ _hfcpci_softirq(struct device *dev, void *unused)
 			main_rec_hfcpci(bch);
 			tx_birq(bch);
 		}
-		spin_unlock(&hc->lock);
+		spin_unlock_irq(&hc->lock);
 	}
 	return 0;
 }
diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index b61aac00ff40..859073193f5b 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -854,7 +854,13 @@ struct smq_policy {
 
 	struct background_tracker *bg_work;
 
-	bool migrations_allowed;
+	bool migrations_allowed:1;
+
+	/*
+	 * If this is set the policy will try and clean the whole cache
+	 * even if the device is not idle.
+	 */
+	bool cleaner:1;
 };
 
 /*----------------------------------------------------------------*/
@@ -1133,7 +1139,7 @@ static bool clean_target_met(struct smq_policy *mq, bool idle)
 	 * Cache entries may not be populated.  So we cannot rely on the
 	 * size of the clean queue.
 	 */
-	if (idle) {
+	if (idle || mq->cleaner) {
 		/*
 		 * We'd like to clean everything.
 		 */
@@ -1716,11 +1722,9 @@ static void calc_hotspot_params(sector_t origin_size,
 		*hotspot_block_size /= 2u;
 }
 
-static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
-					    sector_t origin_size,
-					    sector_t cache_block_size,
-					    bool mimic_mq,
-					    bool migrations_allowed)
+static struct dm_cache_policy *
+__smq_create(dm_cblock_t cache_size, sector_t origin_size, sector_t cache_block_size,
+	     bool mimic_mq, bool migrations_allowed, bool cleaner)
 {
 	unsigned i;
 	unsigned nr_sentinels_per_queue = 2u * NR_CACHE_LEVELS;
@@ -1807,6 +1811,7 @@ static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
 		goto bad_btracker;
 
 	mq->migrations_allowed = migrations_allowed;
+	mq->cleaner = cleaner;
 
 	return &mq->policy;
 
@@ -1830,21 +1835,24 @@ static struct dm_cache_policy *smq_create(dm_cblock_t cache_size,
 					  sector_t origin_size,
 					  sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, true, false);
 }
 
 static struct dm_cache_policy *mq_create(dm_cblock_t cache_size,
 					 sector_t origin_size,
 					 sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, true, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    true, true, false);
 }
 
 static struct dm_cache_policy *cleaner_create(dm_cblock_t cache_size,
 					      sector_t origin_size,
 					      sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, false);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, false, true);
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index a2d09c9c6e9f..140bdf2a6ee1 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3258,8 +3258,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	r = md_start(&rs->md);
 	if (r) {
 		ti->error = "Failed to start raid array";
-		mddev_unlock(&rs->md);
-		goto bad_md_start;
+		goto bad_unlock;
 	}
 
 	/* If raid4/5/6 journal mode explicitly requested (only possible with journal dev) -> set it */
@@ -3267,8 +3266,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		r = r5c_journal_mode_set(&rs->md, rs->journal_dev.mode);
 		if (r) {
 			ti->error = "Failed to set raid4/5/6 journal mode";
-			mddev_unlock(&rs->md);
-			goto bad_journal_mode_set;
+			goto bad_unlock;
 		}
 	}
 
@@ -3279,14 +3277,14 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
 		if (r)
-			goto bad_stripe_cache;
+			goto bad_unlock;
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
 		if (r)
-			goto bad_check_reshape;
+			goto bad_unlock;
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3295,7 +3293,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
-				goto bad_check_reshape;
+				goto bad_unlock;
 			}
 		}
 	}
@@ -3306,11 +3304,9 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	mddev_unlock(&rs->md);
 	return 0;
 
-bad_md_start:
-bad_journal_mode_set:
-bad_stripe_cache:
-bad_check_reshape:
+bad_unlock:
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 bad:
 	raid_set_free(rs);
 
@@ -3321,7 +3317,9 @@ static void raid_dtr(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
+	mddev_lock_nointr(&rs->md);
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 	raid_set_free(rs);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ae0a857d6076..6efe49f7bdf5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6316,6 +6316,8 @@ static void __md_stop(struct mddev *mddev)
 
 void md_stop(struct mddev *mddev)
 {
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index d5813b9abc8e..9f934466dd97 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -136,7 +136,7 @@ static int fun_exec_op(struct nand_chip *chip, const struct nand_operation *op,
 	unsigned int i;
 	int ret;
 
-	if (op->cs > NAND_MAX_CHIPS)
+	if (op->cs >= NAND_MAX_CHIPS)
 		return -EINVAL;
 
 	if (check_only)
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ee3976b7e197..6bb0fca4a91d 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1180,7 +1180,6 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	struct meson_nfc *nfc = nand_get_controller_data(nand);
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
-	int nsectors = mtd->writesize / 1024;
 	int ret;
 
 	if (!mtd->name) {
@@ -1198,7 +1197,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	nand->options |= NAND_NO_SUBPAGE_WRITE;
 
 	ret = nand_ecc_choose_conf(nand, nfc->data->ecc_caps,
-				   mtd->oobsize - 2 * nsectors);
+				   mtd->oobsize - 2);
 	if (ret) {
 		dev_err(nfc->dev, "failed to ECC init\n");
 		return -EINVAL;
diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 4b799521a427..dad17fa0b514 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -174,17 +174,17 @@ static void elm_load_syndrome(struct elm_info *info,
 			switch (info->bch_type) {
 			case BCH8_ECC:
 				/* syndrome fragment 0 = ecc[9-12B] */
-				val = cpu_to_be32(*(u32 *) &ecc[9]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[9]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 1 = ecc[5-8B] */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[5]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[5]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 2 = ecc[1-4B] */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[1]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[1]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 3 = ecc[0B] */
@@ -194,35 +194,35 @@ static void elm_load_syndrome(struct elm_info *info,
 				break;
 			case BCH4_ECC:
 				/* syndrome fragment 0 = ecc[20-52b] bits */
-				val = (cpu_to_be32(*(u32 *) &ecc[3]) >> 4) |
+				val = ((__force u32)cpu_to_be32(*(u32 *)&ecc[3]) >> 4) |
 					((ecc[2] & 0xf) << 28);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 1 = ecc[0-20b] bits */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[0]) >> 12;
 				elm_write_reg(info, offset, val);
 				break;
 			case BCH16_ECC:
-				val = cpu_to_be32(*(u32 *) &ecc[22]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[22]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[18]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[18]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[14]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[14]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[10]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[10]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[6]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[6]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[2]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[2]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 16;
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[0]) >> 16;
 				elm_write_reg(info, offset, val);
 				break;
 			default:
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 6fe7bd2a94d2..daa49c060368 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -73,7 +73,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -92,7 +92,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		if (spi_mem_exec_op(spinand->spimem, &op))
 			return nanddev_get_ecc_requirements(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
 		if (WARN_ON(mbf > nanddev_get_ecc_requirements(nand)->strength || !mbf))
 			return nanddev_get_ecc_requirements(nand)->strength;
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 72e18d505d1a..64430440c580 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
-obj-$(CONFIG_VXLAN) += vxlan.o
+obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
 obj-$(CONFIG_GTP) += gtp.o
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 381e6cdd603a..a260740269e9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1442,6 +1442,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a879200eaab0..1f81293f137c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -732,6 +732,8 @@ static int gs_can_close(struct net_device *netdev)
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(dev);
 	if (rc < 0)
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c6563d212476..f2f890e559f3 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1301,7 +1301,9 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	priv->clk_mdiv = devm_clk_get_optional(&pdev->dev, "sw_switch_mdiv");
 	if (IS_ERR(priv->clk_mdiv)) {
@@ -1309,7 +1311,9 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 		goto out_clk;
 	}
 
-	clk_prepare_enable(priv->clk_mdiv);
+	ret = clk_prepare_enable(priv->clk_mdiv);
+	if (ret)
+		goto out_clk;
 
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index ff9f96de74b8..696ce3c5a8ba 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1642,8 +1642,11 @@ static int atl1e_tso_csum(struct atl1e_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 81be560a2643..52b399aa3213 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1139,7 +1139,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto tx_drop;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 5bab885744fc..d60b8dfe3872 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -53,7 +53,10 @@ static void hclge_tm_info_to_ieee_ets(struct hclge_dev *hdev,
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		ets->prio_tc[i] = hdev->tm_info.prio_tc[i];
-		ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		if (i < hdev->tm_info.num_tc)
+			ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		else
+			ets->tc_tx_bw[i] = 0;
 
 		if (hdev->tm_info.tc_info[i].tc_sch_mode ==
 		    HCLGE_SCH_MODE_SP)
@@ -105,26 +108,31 @@ static int hclge_dcb_common_validate(struct hclge_dev *hdev, u8 num_tc,
 	return 0;
 }
 
-static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
-			      u8 *tc, bool *changed)
+static u8 hclge_ets_tc_changed(struct hclge_dev *hdev, struct ieee_ets *ets,
+			       bool *changed)
 {
-	bool has_ets_tc = false;
-	u32 total_ets_bw = 0;
-	u8 max_tc = 0;
-	int ret;
+	u8 max_tc_id = 0;
 	u8 i;
 
 	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
 		if (ets->prio_tc[i] != hdev->tm_info.prio_tc[i])
 			*changed = true;
 
-		if (ets->prio_tc[i] > max_tc)
-			max_tc = ets->prio_tc[i];
+		if (ets->prio_tc[i] > max_tc_id)
+			max_tc_id = ets->prio_tc[i];
 	}
 
-	ret = hclge_dcb_common_validate(hdev, max_tc + 1, ets->prio_tc);
-	if (ret)
-		return ret;
+	/* return max tc number, max tc id need to plus 1 */
+	return max_tc_id + 1;
+}
+
+static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
+				       struct ieee_ets *ets, bool *changed,
+				       u8 tc_num)
+{
+	bool has_ets_tc = false;
+	u32 total_ets_bw = 0;
+	u8 i;
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		switch (ets->tc_tsa[i]) {
@@ -134,6 +142,13 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 				*changed = true;
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
+			if (i >= tc_num) {
+				dev_err(&hdev->pdev->dev,
+					"tc%u is disabled, cannot set ets bw\n",
+					i);
+				return -EINVAL;
+			}
+
 			/* The hardware will switch to sp mode if bandwidth is
 			 * 0, so limit ets bandwidth must be greater than 0.
 			 */
@@ -158,7 +173,26 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	if (has_ets_tc && total_ets_bw != BW_PERCENT)
 		return -EINVAL;
 
-	*tc = max_tc + 1;
+	return 0;
+}
+
+static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
+			      u8 *tc, bool *changed)
+{
+	u8 tc_num;
+	int ret;
+
+	tc_num = hclge_ets_tc_changed(hdev, ets, changed);
+
+	ret = hclge_dcb_common_validate(hdev, tc_num, ets->prio_tc);
+	if (ret)
+		return ret;
+
+	ret = hclge_ets_sch_mode_validate(hdev, ets, changed, tc_num);
+	if (ret)
+		return ret;
+
+	*tc = tc_num;
 	if (*tc != hdev->tm_info.num_tc)
 		*changed = true;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index b3ceaaaeacae..8c5c5562c0a7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -651,6 +651,7 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
 static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 {
 #define BW_PERCENT	100
+#define DEFAULT_BW_WEIGHT	1
 
 	u8 i;
 
@@ -672,7 +673,7 @@ static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 		for (k = 0; k < hdev->tm_info.num_tc; k++)
 			hdev->tm_info.pg_info[i].tc_dwrr[k] = BW_PERCENT;
 		for (; k < HNAE3_MAX_TC; k++)
-			hdev->tm_info.pg_info[i].tc_dwrr[k] = 0;
+			hdev->tm_info.pg_info[i].tc_dwrr[k] = DEFAULT_BW_WEIGHT;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 989d5c7263d7..8bcf5902babf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1839,7 +1839,7 @@ void i40e_dbg_pf_exit(struct i40e_pf *pf)
 void i40e_dbg_init(void)
 {
 	i40e_dbg_root = debugfs_create_dir(i40e_driver_name, NULL);
-	if (!i40e_dbg_root)
+	if (IS_ERR(i40e_dbg_root))
 		pr_info("init of debugfs failed\n");
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 192729546bbf..a122a267ede5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1135,16 +1135,21 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 				     ICE_FLOW_FLD_OFF_INVAL);
 	}
 
-	/* add filter for outer headers */
 	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+
+	assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);
+
+	/* add filter for outer headers */
 	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
 					ICE_FD_HW_SEG_NON_TUN);
-	if (ret == -EEXIST)
-		/* Rule already exists, free memory and continue */
-		devm_kfree(dev, seg);
-	else if (ret)
+	if (ret == -EEXIST) {
+		/* Rule already exists, free memory and count as success */
+		ret = 0;
+		goto err_exit;
+	} else if (ret) {
 		/* could not write filter, free memory */
 		goto err_exit;
+	}
 
 	/* make tunneled filter HW entries if possible */
 	memcpy(&tun_seg[1], seg, sizeof(*seg));
@@ -1159,18 +1164,13 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		devm_kfree(dev, tun_seg);
 	}
 
-	if (perfect_filter)
-		set_bit(fltr_idx, hw->fdir_perfect_fltr);
-	else
-		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
-
 	return ret;
 
 err_exit:
 	devm_kfree(dev, tun_seg);
 	devm_kfree(dev, seg);
 
-	return -EOPNOTSUPP;
+	return ret;
 }
 
 /**
@@ -1680,7 +1680,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	}
 
 	/* input struct is added to the HW filter list */
-	ice_fdir_update_list_entry(pf, input, fsp->location);
+	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
+	if (ret)
+		goto release_lock;
 
 	ret = ice_fdir_write_all_fltr(pf, input, true);
 	if (ret)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5c542f5d2b20..2b100b7b325a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8409,7 +8409,7 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 		struct ixgbe_adapter *adapter = q_vector->adapter;
 
 		if (unlikely(skb_tail_pointer(skb) < hdr.network +
-			     VXLAN_HEADROOM))
+			     vxlan_headroom(0)))
 			return;
 
 		/* verify the port is recognized as VXLAN */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index a9b45606dbdb..76ef8a009d6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -121,7 +121,9 @@ static int mlx5e_ipsec_remove_trailer(struct sk_buff *skb, struct xfrm_state *x)
 
 	trailer_len = alen + plen + 2;
 
-	pskb_trim(skb, skb->len - trailer_len);
+	ret = pskb_trim(skb, skb->len - trailer_len);
+	if (unlikely(ret))
+		return ret;
 	if (skb->protocol == htons(ETH_P_IP)) {
 		ipv4hdr->tot_len = htons(ntohs(ipv4hdr->tot_len) - trailer_len);
 		ip_send_check(ipv4hdr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 4bdcceffe9d3..4e8e3797aed0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -802,7 +802,7 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	struct fs_node *iter = list_entry(start, struct fs_node, list);
 	struct mlx5_flow_table *ft = NULL;
 
-	if (!root || root->type == FS_TYPE_PRIO_CHAINS)
+	if (!root)
 		return NULL;
 
 	list_for_each_advance_continue(iter, &root->children, reverse) {
@@ -818,20 +818,42 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	return ft;
 }
 
-/* If reverse is false then return the first flow table in next priority of
- * prio in the tree, else return the last flow table in the previous priority
- * of prio in the tree.
+static struct fs_node *find_prio_chains_parent(struct fs_node *parent,
+					       struct fs_node **child)
+{
+	struct fs_node *node = NULL;
+
+	while (parent && parent->type != FS_TYPE_PRIO_CHAINS) {
+		node = parent;
+		parent = parent->parent;
+	}
+
+	if (child)
+		*child = node;
+
+	return parent;
+}
+
+/* If reverse is false then return the first flow table next to the passed node
+ * in the tree, else return the last flow table before the node in the tree.
+ * If skip is true, skip the flow tables in the same prio_chains prio.
  */
-static struct mlx5_flow_table *find_closest_ft(struct fs_prio *prio, bool reverse)
+static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool reverse,
+					       bool skip)
 {
+	struct fs_node *prio_chains_parent = NULL;
 	struct mlx5_flow_table *ft = NULL;
 	struct fs_node *curr_node;
 	struct fs_node *parent;
 
-	parent = prio->node.parent;
-	curr_node = &prio->node;
+	if (skip)
+		prio_chains_parent = find_prio_chains_parent(node, NULL);
+	parent = node->parent;
+	curr_node = node;
 	while (!ft && parent) {
-		ft = find_closest_ft_recursive(parent, &curr_node->list, reverse);
+		if (parent != prio_chains_parent)
+			ft = find_closest_ft_recursive(parent, &curr_node->list,
+						       reverse);
 		curr_node = parent;
 		parent = curr_node->parent;
 	}
@@ -839,15 +861,15 @@ static struct mlx5_flow_table *find_closest_ft(struct fs_prio *prio, bool revers
 }
 
 /* Assuming all the tree is locked by mutex chain lock */
-static struct mlx5_flow_table *find_next_chained_ft(struct fs_prio *prio)
+static struct mlx5_flow_table *find_next_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(prio, false);
+	return find_closest_ft(node, false, true);
 }
 
 /* Assuming all the tree is locked by mutex chain lock */
-static struct mlx5_flow_table *find_prev_chained_ft(struct fs_prio *prio)
+static struct mlx5_flow_table *find_prev_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(prio, true);
+	return find_closest_ft(node, true, true);
 }
 
 static struct mlx5_flow_table *find_next_fwd_ft(struct mlx5_flow_table *ft,
@@ -859,7 +881,7 @@ static struct mlx5_flow_table *find_next_fwd_ft(struct mlx5_flow_table *ft,
 	next_ns = flow_act->action & MLX5_FLOW_CONTEXT_ACTION_FWD_NEXT_NS;
 	fs_get_obj(prio, next_ns ? ft->ns->node.parent : ft->node.parent);
 
-	return find_next_chained_ft(prio);
+	return find_next_chained_ft(&prio->node);
 }
 
 static int connect_fts_in_prio(struct mlx5_core_dev *dev,
@@ -883,21 +905,55 @@ static int connect_fts_in_prio(struct mlx5_core_dev *dev,
 	return 0;
 }
 
+static struct mlx5_flow_table *find_closet_ft_prio_chains(struct fs_node *node,
+							  struct fs_node *parent,
+							  struct fs_node **child,
+							  bool reverse)
+{
+	struct mlx5_flow_table *ft;
+
+	ft = find_closest_ft(node, reverse, false);
+
+	if (ft && parent == find_prio_chains_parent(&ft->node, child))
+		return ft;
+
+	return NULL;
+}
+
 /* Connect flow tables from previous priority of prio to ft */
 static int connect_prev_fts(struct mlx5_core_dev *dev,
 			    struct mlx5_flow_table *ft,
 			    struct fs_prio *prio)
 {
+	struct fs_node *prio_parent, *parent = NULL, *child, *node;
 	struct mlx5_flow_table *prev_ft;
+	int err = 0;
+
+	prio_parent = find_prio_chains_parent(&prio->node, &child);
+
+	/* return directly if not under the first sub ns of prio_chains prio */
+	if (prio_parent && !list_is_first(&child->list, &prio_parent->children))
+		return 0;
 
-	prev_ft = find_prev_chained_ft(prio);
-	if (prev_ft) {
+	prev_ft = find_prev_chained_ft(&prio->node);
+	while (prev_ft) {
 		struct fs_prio *prev_prio;
 
 		fs_get_obj(prev_prio, prev_ft->node.parent);
-		return connect_fts_in_prio(dev, prev_prio, ft);
+		err = connect_fts_in_prio(dev, prev_prio, ft);
+		if (err)
+			break;
+
+		if (!parent) {
+			parent = find_prio_chains_parent(&prev_prio->node, &child);
+			if (!parent)
+				break;
+		}
+
+		node = child;
+		prev_ft = find_closet_ft_prio_chains(node, parent, &child, true);
 	}
-	return 0;
+	return err;
 }
 
 static int update_root_ft_create(struct mlx5_flow_table *ft, struct fs_prio
@@ -1036,7 +1092,7 @@ static int connect_flow_table(struct mlx5_core_dev *dev, struct mlx5_flow_table
 		if (err)
 			return err;
 
-		next_ft = first_ft ? first_ft : find_next_chained_ft(prio);
+		next_ft = first_ft ? first_ft : find_next_chained_ft(&prio->node);
 		err = connect_fwd_rules(dev, ft, next_ft);
 		if (err)
 			return err;
@@ -1114,7 +1170,7 @@ static struct mlx5_flow_table *__mlx5_create_flow_table(struct mlx5_flow_namespa
 	tree_init_node(&ft->node, del_hw_flow_table, del_sw_flow_table);
 	log_table_sz = ft->max_fte ? ilog2(ft->max_fte) : 0;
 	next_ft = unmanaged ? ft_attr->next_ft :
-			      find_next_chained_ft(fs_prio);
+			      find_next_chained_ft(&fs_prio->node);
 	ft->def_miss_action = ns->def_miss_action;
 	ft->ns = ns;
 	err = root->cmds->create_flow_table(root, ft, log_table_sz, next_ft);
@@ -2073,13 +2129,20 @@ EXPORT_SYMBOL(mlx5_del_flow_rules);
 /* Assuming prio->node.children(flow tables) is sorted by level */
 static struct mlx5_flow_table *find_next_ft(struct mlx5_flow_table *ft)
 {
+	struct fs_node *prio_parent, *child;
 	struct fs_prio *prio;
 
 	fs_get_obj(prio, ft->node.parent);
 
 	if (!list_is_last(&ft->node.list, &prio->node.children))
 		return list_next_entry(ft, node.list);
-	return find_next_chained_ft(prio);
+
+	prio_parent = find_prio_chains_parent(&prio->node, &child);
+
+	if (prio_parent && list_is_first(&child->list, &prio_parent->children))
+		return find_closest_ft(&prio->node, false, false);
+
+	return find_next_chained_ft(&prio->node);
 }
 
 static int update_root_ft_destroy(struct mlx5_flow_table *ft)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index fd56cae0d54f..4549840fb91a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -425,11 +425,12 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
 
 	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
 	if (err)
-		return err;
+		goto err_free_in;
 
 	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
-	kvfree(in);
 
+err_free_in:
+	kvfree(in);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index b9acee214bb6..bb8631558181 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1845,6 +1845,17 @@ static int netsec_of_probe(struct platform_device *pdev,
 		return err;
 	}
 
+	/*
+	 * SynQuacer is physically configured with TX and RX delays
+	 * but the standard firmware claimed otherwise for a long
+	 * time, ignore it.
+	 */
+	if (of_machine_is_compatible("socionext,developer-box") &&
+	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
+		dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
+		priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+	}
+
 	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 	if (!priv->phy_np) {
 		dev_err(&pdev->dev, "missing required property 'phy-handle'\n");
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 130f4b707bdc..da136abba152 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1550,15 +1550,15 @@ static int temac_probe(struct platform_device *pdev)
 	}
 
 	/* Error handle returned DMA RX and TX interrupts */
-	if (lp->rx_irq < 0) {
-		if (lp->rx_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "could not get DMA RX irq\n");
-		return lp->rx_irq;
+	if (lp->rx_irq <= 0) {
+		rc = lp->rx_irq ?: -EINVAL;
+		return dev_err_probe(&pdev->dev, rc,
+				     "could not get DMA RX irq\n");
 	}
-	if (lp->tx_irq < 0) {
-		if (lp->tx_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "could not get DMA TX irq\n");
-		return lp->tx_irq;
+	if (lp->tx_irq <= 0) {
+		rc = lp->tx_irq ?: -EINVAL;
+		return dev_err_probe(&pdev->dev, rc,
+				     "could not get DMA TX irq\n");
 	}
 
 	if (temac_np) {
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 2b64318efdba..42b48d0d0c4e 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -263,6 +263,13 @@ static int mv3310_power_up(struct phy_device *phydev)
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
 				 MV_V2_PORT_CTRL_PWRDOWN);
 
+	/* Sometimes, the power down bit doesn't clear immediately, and
+	 * a read of this register causes the bit not to clear. Delay
+	 * 100us to allow the PHY to come out of power down mode before
+	 * the next access.
+	 */
+	udelay(100);
+
 	if (phydev->drv->phy_id != MARVELL_PHY_ID_88X3310 ||
 	    priv->firmware_ver < 0x00030000)
 		return ret;
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index f9b3eb2d8d8b..41ee56015a45 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -523,7 +523,7 @@ static int tap_open(struct inode *inode, struct file *file)
 	q->sock.state = SS_CONNECTED;
 	q->sock.file = file;
 	q->sock.ops = &tap_socket_ops;
-	sock_init_data_uid(&q->sock, &q->sk, inode->i_uid);
+	sock_init_data_uid(&q->sock, &q->sk, current_fsuid());
 	q->sk.sk_write_space = tap_sock_write_space;
 	q->sk.sk_destruct = tap_sock_destruct;
 	q->flags = IFF_VNET_HDR | IFF_NO_PI | IFF_TAP;
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 8a1619695421..36c7eae776d4 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2130,6 +2130,15 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
+		    (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |= (IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f1d46aea8a2b..0e70877c932c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3457,7 +3457,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	tfile->socket.file = file;
 	tfile->socket.ops = &tun_socket_ops;
 
-	sock_init_data_uid(&tfile->socket, &tfile->sk, inode->i_uid);
+	sock_init_data_uid(&tfile->socket, &tfile->sk, current_fsuid());
 
 	tfile->sk.sk_write_space = tun_sock_write_space;
 	tfile->sk.sk_sndbuf = INT_MAX;
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 935cd296887f..9f3446d6dde7 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -604,9 +604,23 @@ static const struct usb_device_id	products[] = {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,   /* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,   /* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
@@ -614,6 +628,13 @@ static const struct usb_device_id	products[] = {
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,   /* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 43d70348343b..481a41d879b5 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1738,6 +1738,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints (dev, udev);
 	else {
+		u8 ep_addrs[3] = {
+			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0
+		};
+
 		dev->in = usb_rcvbulkpipe (xdev, info->in);
 		dev->out = usb_sndbulkpipe (xdev, info->out);
 		if (!(info->flags & FLAG_NO_SETINT))
@@ -1747,6 +1751,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		else
 			status = 0;
 
+		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
+			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
 		status = init_status (dev, udev);
diff --git a/drivers/net/usb/zaurus.c b/drivers/net/usb/zaurus.c
index 7984f2157d22..df3617c4c44e 100644
--- a/drivers/net/usb/zaurus.c
+++ b/drivers/net/usb/zaurus.c
@@ -289,9 +289,23 @@ static const struct usb_device_id	products [] = {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,	/* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,	/* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 	          | USB_DEVICE_ID_MATCH_DEVICE,
@@ -299,6 +313,13 @@ static const struct usb_device_id	products [] = {
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,	/* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 119a32f34b53..165149bcf0b1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3220,6 +3220,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3240,8 +3242,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
deleted file mode 100644
index 72d670667f64..000000000000
--- a/drivers/net/vxlan.c
+++ /dev/null
@@ -1,4829 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * VXLAN: Virtual eXtensible Local Area Network
- *
- * Copyright (c) 2012-2013 Vyatta Inc.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/udp.h>
-#include <linux/igmp.h>
-#include <linux/if_ether.h>
-#include <linux/ethtool.h>
-#include <net/arp.h>
-#include <net/ndisc.h>
-#include <net/ipv6_stubs.h>
-#include <net/ip.h>
-#include <net/icmp.h>
-#include <net/rtnetlink.h>
-#include <net/inet_ecn.h>
-#include <net/net_namespace.h>
-#include <net/netns/generic.h>
-#include <net/tun_proto.h>
-#include <net/vxlan.h>
-#include <net/nexthop.h>
-
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/ip6_tunnel.h>
-#include <net/ip6_checksum.h>
-#endif
-
-#define VXLAN_VERSION	"0.1"
-
-#define PORT_HASH_BITS	8
-#define PORT_HASH_SIZE  (1<<PORT_HASH_BITS)
-#define FDB_AGE_DEFAULT 300 /* 5 min */
-#define FDB_AGE_INTERVAL (10 * HZ)	/* rescan interval */
-
-/* UDP port for VXLAN traffic.
- * The IANA assigned port is 4789, but the Linux default is 8472
- * for compatibility with early adopters.
- */
-static unsigned short vxlan_port __read_mostly = 8472;
-module_param_named(udp_port, vxlan_port, ushort, 0444);
-MODULE_PARM_DESC(udp_port, "Destination UDP port");
-
-static bool log_ecn_error = true;
-module_param(log_ecn_error, bool, 0644);
-MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
-
-static unsigned int vxlan_net_id;
-static struct rtnl_link_ops vxlan_link_ops;
-
-static const u8 all_zeros_mac[ETH_ALEN + 2];
-
-static int vxlan_sock_add(struct vxlan_dev *vxlan);
-
-static void vxlan_vs_del_dev(struct vxlan_dev *vxlan);
-
-/* per-network namespace private data for this module */
-struct vxlan_net {
-	struct list_head  vxlan_list;
-	struct hlist_head sock_list[PORT_HASH_SIZE];
-	spinlock_t	  sock_lock;
-};
-
-/* Forwarding table entry */
-struct vxlan_fdb {
-	struct hlist_node hlist;	/* linked list of entries */
-	struct rcu_head	  rcu;
-	unsigned long	  updated;	/* jiffies */
-	unsigned long	  used;
-	struct list_head  remotes;
-	u8		  eth_addr[ETH_ALEN];
-	u16		  state;	/* see ndm_state */
-	__be32		  vni;
-	u16		  flags;	/* see ndm_flags and below */
-	struct list_head  nh_list;
-	struct nexthop __rcu *nh;
-	struct vxlan_dev  __rcu *vdev;
-};
-
-#define NTF_VXLAN_ADDED_BY_USER 0x100
-
-/* salt for hash table */
-static u32 vxlan_salt __read_mostly;
-
-static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
-{
-	return vs->flags & VXLAN_F_COLLECT_METADATA ||
-	       ip_tunnel_collect_metadata();
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static inline
-bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
-{
-	if (a->sa.sa_family != b->sa.sa_family)
-		return false;
-	if (a->sa.sa_family == AF_INET6)
-		return ipv6_addr_equal(&a->sin6.sin6_addr, &b->sin6.sin6_addr);
-	else
-		return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
-}
-
-static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
-{
-	if (nla_len(nla) >= sizeof(struct in6_addr)) {
-		ip->sin6.sin6_addr = nla_get_in6_addr(nla);
-		ip->sa.sa_family = AF_INET6;
-		return 0;
-	} else if (nla_len(nla) >= sizeof(__be32)) {
-		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
-		ip->sa.sa_family = AF_INET;
-		return 0;
-	} else {
-		return -EAFNOSUPPORT;
-	}
-}
-
-static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
-			      const union vxlan_addr *ip)
-{
-	if (ip->sa.sa_family == AF_INET6)
-		return nla_put_in6_addr(skb, attr, &ip->sin6.sin6_addr);
-	else
-		return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
-}
-
-#else /* !CONFIG_IPV6 */
-
-static inline
-bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
-{
-	return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
-}
-
-static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
-{
-	if (nla_len(nla) >= sizeof(struct in6_addr)) {
-		return -EAFNOSUPPORT;
-	} else if (nla_len(nla) >= sizeof(__be32)) {
-		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
-		ip->sa.sa_family = AF_INET;
-		return 0;
-	} else {
-		return -EAFNOSUPPORT;
-	}
-}
-
-static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
-			      const union vxlan_addr *ip)
-{
-	return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
-}
-#endif
-
-/* Virtual Network hash table head */
-static inline struct hlist_head *vni_head(struct vxlan_sock *vs, __be32 vni)
-{
-	return &vs->vni_list[hash_32((__force u32)vni, VNI_HASH_BITS)];
-}
-
-/* Socket hash table head */
-static inline struct hlist_head *vs_head(struct net *net, __be16 port)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-
-	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
-}
-
-/* First remote destination for a forwarding entry.
- * Guaranteed to be non-NULL because remotes are never deleted.
- */
-static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
-{
-	if (rcu_access_pointer(fdb->nh))
-		return NULL;
-	return list_entry_rcu(fdb->remotes.next, struct vxlan_rdst, list);
-}
-
-static inline struct vxlan_rdst *first_remote_rtnl(struct vxlan_fdb *fdb)
-{
-	if (rcu_access_pointer(fdb->nh))
-		return NULL;
-	return list_first_entry(&fdb->remotes, struct vxlan_rdst, list);
-}
-
-/* Find VXLAN socket based on network namespace, address family, UDP port,
- * enabled unshareable flags and socket device binding (see l3mdev with
- * non-default VRF).
- */
-static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
-					  __be16 port, u32 flags, int ifindex)
-{
-	struct vxlan_sock *vs;
-
-	flags &= VXLAN_F_RCV_FLAGS;
-
-	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
-		if (inet_sk(vs->sock->sk)->inet_sport == port &&
-		    vxlan_get_sk_family(vs) == family &&
-		    vs->flags == flags &&
-		    vs->sock->sk->sk_bound_dev_if == ifindex)
-			return vs;
-	}
-	return NULL;
-}
-
-static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs, int ifindex,
-					   __be32 vni)
-{
-	struct vxlan_dev_node *node;
-
-	/* For flow based devices, map all packets to VNI 0 */
-	if (vs->flags & VXLAN_F_COLLECT_METADATA)
-		vni = 0;
-
-	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
-		if (node->vxlan->default_dst.remote_vni != vni)
-			continue;
-
-		if (IS_ENABLED(CONFIG_IPV6)) {
-			const struct vxlan_config *cfg = &node->vxlan->cfg;
-
-			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
-			    cfg->remote_ifindex != ifindex)
-				continue;
-		}
-
-		return node->vxlan;
-	}
-
-	return NULL;
-}
-
-/* Look up VNI in a per net namespace table */
-static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
-					__be32 vni, sa_family_t family,
-					__be16 port, u32 flags)
-{
-	struct vxlan_sock *vs;
-
-	vs = vxlan_find_sock(net, family, port, flags, ifindex);
-	if (!vs)
-		return NULL;
-
-	return vxlan_vs_find_vni(vs, ifindex, vni);
-}
-
-/* Fill in neighbour message in skbuff. */
-static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
-			  const struct vxlan_fdb *fdb,
-			  u32 portid, u32 seq, int type, unsigned int flags,
-			  const struct vxlan_rdst *rdst)
-{
-	unsigned long now = jiffies;
-	struct nda_cacheinfo ci;
-	bool send_ip, send_eth;
-	struct nlmsghdr *nlh;
-	struct nexthop *nh;
-	struct ndmsg *ndm;
-	int nh_family;
-	u32 nh_id;
-
-	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
-	if (nlh == NULL)
-		return -EMSGSIZE;
-
-	ndm = nlmsg_data(nlh);
-	memset(ndm, 0, sizeof(*ndm));
-
-	send_eth = send_ip = true;
-
-	rcu_read_lock();
-	nh = rcu_dereference(fdb->nh);
-	if (nh) {
-		nh_family = nexthop_get_family(nh);
-		nh_id = nh->id;
-	}
-	rcu_read_unlock();
-
-	if (type == RTM_GETNEIGH) {
-		if (rdst) {
-			send_ip = !vxlan_addr_any(&rdst->remote_ip);
-			ndm->ndm_family = send_ip ? rdst->remote_ip.sa.sa_family : AF_INET;
-		} else if (nh) {
-			ndm->ndm_family = nh_family;
-		}
-		send_eth = !is_zero_ether_addr(fdb->eth_addr);
-	} else
-		ndm->ndm_family	= AF_BRIDGE;
-	ndm->ndm_state = fdb->state;
-	ndm->ndm_ifindex = vxlan->dev->ifindex;
-	ndm->ndm_flags = fdb->flags;
-	if (rdst && rdst->offloaded)
-		ndm->ndm_flags |= NTF_OFFLOADED;
-	ndm->ndm_type = RTN_UNICAST;
-
-	if (!net_eq(dev_net(vxlan->dev), vxlan->net) &&
-	    nla_put_s32(skb, NDA_LINK_NETNSID,
-			peernet2id(dev_net(vxlan->dev), vxlan->net)))
-		goto nla_put_failure;
-
-	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->eth_addr))
-		goto nla_put_failure;
-	if (nh) {
-		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
-			goto nla_put_failure;
-	} else if (rdst) {
-		if (send_ip && vxlan_nla_put_addr(skb, NDA_DST,
-						  &rdst->remote_ip))
-			goto nla_put_failure;
-
-		if (rdst->remote_port &&
-		    rdst->remote_port != vxlan->cfg.dst_port &&
-		    nla_put_be16(skb, NDA_PORT, rdst->remote_port))
-			goto nla_put_failure;
-		if (rdst->remote_vni != vxlan->default_dst.remote_vni &&
-		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
-			goto nla_put_failure;
-		if (rdst->remote_ifindex &&
-		    nla_put_u32(skb, NDA_IFINDEX, rdst->remote_ifindex))
-			goto nla_put_failure;
-	}
-
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->vni &&
-	    nla_put_u32(skb, NDA_SRC_VNI,
-			be32_to_cpu(fdb->vni)))
-		goto nla_put_failure;
-
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
-	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
-	ci.ndm_refcnt	 = 0;
-
-	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
-		goto nla_put_failure;
-
-	nlmsg_end(skb, nlh);
-	return 0;
-
-nla_put_failure:
-	nlmsg_cancel(skb, nlh);
-	return -EMSGSIZE;
-}
-
-static inline size_t vxlan_nlmsg_size(void)
-{
-	return NLMSG_ALIGN(sizeof(struct ndmsg))
-		+ nla_total_size(ETH_ALEN) /* NDA_LLADDR */
-		+ nla_total_size(sizeof(struct in6_addr)) /* NDA_DST */
-		+ nla_total_size(sizeof(__be16)) /* NDA_PORT */
-		+ nla_total_size(sizeof(__be32)) /* NDA_VNI */
-		+ nla_total_size(sizeof(__u32)) /* NDA_IFINDEX */
-		+ nla_total_size(sizeof(__s32)) /* NDA_LINK_NETNSID */
-		+ nla_total_size(sizeof(struct nda_cacheinfo));
-}
-
-static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			       struct vxlan_rdst *rd, int type)
-{
-	struct net *net = dev_net(vxlan->dev);
-	struct sk_buff *skb;
-	int err = -ENOBUFS;
-
-	skb = nlmsg_new(vxlan_nlmsg_size(), GFP_ATOMIC);
-	if (skb == NULL)
-		goto errout;
-
-	err = vxlan_fdb_info(skb, vxlan, fdb, 0, 0, type, 0, rd);
-	if (err < 0) {
-		/* -EMSGSIZE implies BUG in vxlan_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
-	return;
-errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
-}
-
-static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
-			    const struct vxlan_fdb *fdb,
-			    const struct vxlan_rdst *rd,
-			    struct netlink_ext_ack *extack,
-			    struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	fdb_info->info.dev = vxlan->dev;
-	fdb_info->info.extack = extack;
-	fdb_info->remote_ip = rd->remote_ip;
-	fdb_info->remote_port = rd->remote_port;
-	fdb_info->remote_vni = rd->remote_vni;
-	fdb_info->remote_ifindex = rd->remote_ifindex;
-	memcpy(fdb_info->eth_addr, fdb->eth_addr, ETH_ALEN);
-	fdb_info->vni = fdb->vni;
-	fdb_info->offloaded = rd->offloaded;
-	fdb_info->added_by_user = fdb->flags & NTF_VXLAN_ADDED_BY_USER;
-}
-
-static int vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
-					      struct vxlan_fdb *fdb,
-					      struct vxlan_rdst *rd,
-					      bool adding,
-					      struct netlink_ext_ack *extack)
-{
-	struct switchdev_notifier_vxlan_fdb_info info;
-	enum switchdev_notifier_type notifier_type;
-	int ret;
-
-	if (WARN_ON(!rd))
-		return 0;
-
-	notifier_type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE
-			       : SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE;
-	vxlan_fdb_switchdev_notifier_info(vxlan, fdb, rd, NULL, &info);
-	ret = call_switchdev_notifiers(notifier_type, vxlan->dev,
-				       &info.info, extack);
-	return notifier_to_errno(ret);
-}
-
-static int vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			    struct vxlan_rdst *rd, int type, bool swdev_notify,
-			    struct netlink_ext_ack *extack)
-{
-	int err;
-
-	if (swdev_notify && rd) {
-		switch (type) {
-		case RTM_NEWNEIGH:
-			err = vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
-								 true, extack);
-			if (err)
-				return err;
-			break;
-		case RTM_DELNEIGH:
-			vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
-							   false, extack);
-			break;
-		}
-	}
-
-	__vxlan_fdb_notify(vxlan, fdb, rd, type);
-	return 0;
-}
-
-static void vxlan_ip_miss(struct net_device *dev, union vxlan_addr *ipa)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb f = {
-		.state = NUD_STALE,
-	};
-	struct vxlan_rdst remote = {
-		.remote_ip = *ipa, /* goes to NDA_DST */
-		.remote_vni = cpu_to_be32(VXLAN_N_VID),
-	};
-
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
-}
-
-static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
-{
-	struct vxlan_fdb f = {
-		.state = NUD_STALE,
-	};
-	struct vxlan_rdst remote = { };
-
-	memcpy(f.eth_addr, eth_addr, ETH_ALEN);
-
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
-}
-
-/* Hash Ethernet address */
-static u32 eth_hash(const unsigned char *addr)
-{
-	u64 value = get_unaligned((u64 *)addr);
-
-	/* only want 6 bytes */
-#ifdef __BIG_ENDIAN
-	value >>= 16;
-#else
-	value <<= 16;
-#endif
-	return hash_64(value, FDB_HASH_BITS);
-}
-
-static u32 eth_vni_hash(const unsigned char *addr, __be32 vni)
-{
-	/* use 1 byte of OUI and 3 bytes of NIC */
-	u32 key = get_unaligned((u32 *)(addr + 2));
-
-	return jhash_2words(key, vni, vxlan_salt) & (FDB_HASH_SIZE - 1);
-}
-
-static u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni)
-{
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)
-		return eth_vni_hash(mac, vni);
-	else
-		return eth_hash(mac);
-}
-
-/* Hash chain to use given mac address */
-static inline struct hlist_head *vxlan_fdb_head(struct vxlan_dev *vxlan,
-						const u8 *mac, __be32 vni)
-{
-	return &vxlan->fdb_head[fdb_head_index(vxlan, mac, vni)];
-}
-
-/* Look up Ethernet address in forwarding table */
-static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
-					  const u8 *mac, __be32 vni)
-{
-	struct hlist_head *head = vxlan_fdb_head(vxlan, mac, vni);
-	struct vxlan_fdb *f;
-
-	hlist_for_each_entry_rcu(f, head, hlist) {
-		if (ether_addr_equal(mac, f->eth_addr)) {
-			if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
-				if (vni == f->vni)
-					return f;
-			} else {
-				return f;
-			}
-		}
-	}
-
-	return NULL;
-}
-
-static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
-					const u8 *mac, __be32 vni)
-{
-	struct vxlan_fdb *f;
-
-	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
-
-	return f;
-}
-
-/* caller should hold vxlan->hash_lock */
-static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
-					      union vxlan_addr *ip, __be16 port,
-					      __be32 vni, __u32 ifindex)
-{
-	struct vxlan_rdst *rd;
-
-	list_for_each_entry(rd, &f->remotes, list) {
-		if (vxlan_addr_equal(&rd->remote_ip, ip) &&
-		    rd->remote_port == port &&
-		    rd->remote_vni == vni &&
-		    rd->remote_ifindex == ifindex)
-			return rd;
-	}
-
-	return NULL;
-}
-
-int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
-		      struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	u8 eth_addr[ETH_ALEN + 2] = { 0 };
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	int rc = 0;
-
-	if (is_multicast_ether_addr(mac) ||
-	    is_zero_ether_addr(mac))
-		return -EINVAL;
-
-	ether_addr_copy(eth_addr, mac);
-
-	rcu_read_lock();
-
-	f = __vxlan_find_mac(vxlan, eth_addr, vni);
-	if (!f) {
-		rc = -ENOENT;
-		goto out;
-	}
-
-	rdst = first_remote_rcu(f);
-	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
-
-out:
-	rcu_read_unlock();
-	return rc;
-}
-EXPORT_SYMBOL_GPL(vxlan_fdb_find_uc);
-
-static int vxlan_fdb_notify_one(struct notifier_block *nb,
-				const struct vxlan_dev *vxlan,
-				const struct vxlan_fdb *f,
-				const struct vxlan_rdst *rdst,
-				struct netlink_ext_ack *extack)
-{
-	struct switchdev_notifier_vxlan_fdb_info fdb_info;
-	int rc;
-
-	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, extack, &fdb_info);
-	rc = nb->notifier_call(nb, SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
-			       &fdb_info);
-	return notifier_to_errno(rc);
-}
-
-int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
-		     struct notifier_block *nb,
-		     struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	unsigned int h;
-	int rc = 0;
-
-	if (!netif_is_vxlan(dev))
-		return -EINVAL;
-	vxlan = netdev_priv(dev);
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_bh(&vxlan->hash_lock[h]);
-		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
-			if (f->vni == vni) {
-				list_for_each_entry(rdst, &f->remotes, list) {
-					rc = vxlan_fdb_notify_one(nb, vxlan,
-								  f, rdst,
-								  extack);
-					if (rc)
-						goto unlock;
-				}
-			}
-		}
-		spin_unlock_bh(&vxlan->hash_lock[h]);
-	}
-	return 0;
-
-unlock:
-	spin_unlock_bh(&vxlan->hash_lock[h]);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
-
-void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	unsigned int h;
-
-	if (!netif_is_vxlan(dev))
-		return;
-	vxlan = netdev_priv(dev);
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_bh(&vxlan->hash_lock[h]);
-		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
-			if (f->vni == vni)
-				list_for_each_entry(rdst, &f->remotes, list)
-					rdst->offloaded = false;
-		spin_unlock_bh(&vxlan->hash_lock[h]);
-	}
-
-}
-EXPORT_SYMBOL_GPL(vxlan_fdb_clear_offload);
-
-/* Replace destination of unicast mac */
-static int vxlan_fdb_replace(struct vxlan_fdb *f,
-			     union vxlan_addr *ip, __be16 port, __be32 vni,
-			     __u32 ifindex, struct vxlan_rdst *oldrd)
-{
-	struct vxlan_rdst *rd;
-
-	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
-	if (rd)
-		return 0;
-
-	rd = list_first_entry_or_null(&f->remotes, struct vxlan_rdst, list);
-	if (!rd)
-		return 0;
-
-	*oldrd = *rd;
-	dst_cache_reset(&rd->dst_cache);
-	rd->remote_ip = *ip;
-	rd->remote_port = port;
-	rd->remote_vni = vni;
-	rd->remote_ifindex = ifindex;
-	rd->offloaded = false;
-	return 1;
-}
-
-/* Add/update destinations for multicast */
-static int vxlan_fdb_append(struct vxlan_fdb *f,
-			    union vxlan_addr *ip, __be16 port, __be32 vni,
-			    __u32 ifindex, struct vxlan_rdst **rdp)
-{
-	struct vxlan_rdst *rd;
-
-	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
-	if (rd)
-		return 0;
-
-	rd = kmalloc(sizeof(*rd), GFP_ATOMIC);
-	if (rd == NULL)
-		return -ENOMEM;
-
-	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
-		kfree(rd);
-		return -ENOMEM;
-	}
-
-	rd->remote_ip = *ip;
-	rd->remote_port = port;
-	rd->offloaded = false;
-	rd->remote_vni = vni;
-	rd->remote_ifindex = ifindex;
-
-	list_add_tail_rcu(&rd->list, &f->remotes);
-
-	*rdp = rd;
-	return 1;
-}
-
-static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
-					  unsigned int off,
-					  struct vxlanhdr *vh, size_t hdrlen,
-					  __be32 vni_field,
-					  struct gro_remcsum *grc,
-					  bool nopartial)
-{
-	size_t start, offset;
-
-	if (skb->remcsum_offload)
-		return vh;
-
-	if (!NAPI_GRO_CB(skb)->csum_valid)
-		return NULL;
-
-	start = vxlan_rco_start(vni_field);
-	offset = start + vxlan_rco_offset(vni_field);
-
-	vh = skb_gro_remcsum_process(skb, (void *)vh, off, hdrlen,
-				     start, offset, grc, nopartial);
-
-	skb->remcsum_offload = 1;
-
-	return vh;
-}
-
-static struct sk_buff *vxlan_gro_receive(struct sock *sk,
-					 struct list_head *head,
-					 struct sk_buff *skb)
-{
-	struct sk_buff *pp = NULL;
-	struct sk_buff *p;
-	struct vxlanhdr *vh, *vh2;
-	unsigned int hlen, off_vx;
-	int flush = 1;
-	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
-	__be32 flags;
-	struct gro_remcsum grc;
-
-	skb_gro_remcsum_init(&grc);
-
-	off_vx = skb_gro_offset(skb);
-	hlen = off_vx + sizeof(*vh);
-	vh   = skb_gro_header_fast(skb, off_vx);
-	if (skb_gro_header_hard(skb, hlen)) {
-		vh = skb_gro_header_slow(skb, hlen, off_vx);
-		if (unlikely(!vh))
-			goto out;
-	}
-
-	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
-
-	flags = vh->vx_flags;
-
-	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
-		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
-				       vh->vx_vni, &grc,
-				       !!(vs->flags &
-					  VXLAN_F_REMCSUM_NOPARTIAL));
-
-		if (!vh)
-			goto out;
-	}
-
-	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
-
-	list_for_each_entry(p, head, list) {
-		if (!NAPI_GRO_CB(p)->same_flow)
-			continue;
-
-		vh2 = (struct vxlanhdr *)(p->data + off_vx);
-		if (vh->vx_flags != vh2->vx_flags ||
-		    vh->vx_vni != vh2->vx_vni) {
-			NAPI_GRO_CB(p)->same_flow = 0;
-			continue;
-		}
-	}
-
-	pp = call_gro_receive(eth_gro_receive, head, skb);
-	flush = 0;
-
-out:
-	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
-
-	return pp;
-}
-
-static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
-{
-	/* Sets 'skb->inner_mac_header' since we are always called with
-	 * 'skb->encapsulation' set.
-	 */
-	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
-}
-
-static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
-					 __u16 state, __be32 src_vni,
-					 __u16 ndm_flags)
-{
-	struct vxlan_fdb *f;
-
-	f = kmalloc(sizeof(*f), GFP_ATOMIC);
-	if (!f)
-		return NULL;
-	f->state = state;
-	f->flags = ndm_flags;
-	f->updated = f->used = jiffies;
-	f->vni = src_vni;
-	f->nh = NULL;
-	RCU_INIT_POINTER(f->vdev, vxlan);
-	INIT_LIST_HEAD(&f->nh_list);
-	INIT_LIST_HEAD(&f->remotes);
-	memcpy(f->eth_addr, mac, ETH_ALEN);
-
-	return f;
-}
-
-static void vxlan_fdb_insert(struct vxlan_dev *vxlan, const u8 *mac,
-			     __be32 src_vni, struct vxlan_fdb *f)
-{
-	++vxlan->addrcnt;
-	hlist_add_head_rcu(&f->hlist,
-			   vxlan_fdb_head(vxlan, mac, src_vni));
-}
-
-static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			       u32 nhid, struct netlink_ext_ack *extack)
-{
-	struct nexthop *old_nh = rtnl_dereference(fdb->nh);
-	struct nexthop *nh;
-	int err = -EINVAL;
-
-	if (old_nh && old_nh->id == nhid)
-		return 0;
-
-	nh = nexthop_find_by_id(vxlan->net, nhid);
-	if (!nh) {
-		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
-		goto err_inval;
-	}
-
-	if (nh) {
-		if (!nexthop_get(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
-			nh = NULL;
-			goto err_inval;
-		}
-		if (!nexthop_is_fdb(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop is not a fdb nexthop");
-			goto err_inval;
-		}
-
-		if (!nexthop_is_multipath(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop is not a multipath group");
-			goto err_inval;
-		}
-
-		/* check nexthop group family */
-		switch (vxlan->default_dst.remote_ip.sa.sa_family) {
-		case AF_INET:
-			if (!nexthop_has_v4(nh)) {
-				err = -EAFNOSUPPORT;
-				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
-				goto err_inval;
-			}
-			break;
-		case AF_INET6:
-			if (nexthop_has_v4(nh)) {
-				err = -EAFNOSUPPORT;
-				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
-				goto err_inval;
-			}
-		}
-	}
-
-	if (old_nh) {
-		list_del_rcu(&fdb->nh_list);
-		nexthop_put(old_nh);
-	}
-	rcu_assign_pointer(fdb->nh, nh);
-	list_add_tail_rcu(&fdb->nh_list, &nh->fdb_list);
-	return 1;
-
-err_inval:
-	if (nh)
-		nexthop_put(nh);
-	return err;
-}
-
-static int vxlan_fdb_create(struct vxlan_dev *vxlan,
-			    const u8 *mac, union vxlan_addr *ip,
-			    __u16 state, __be16 port, __be32 src_vni,
-			    __be32 vni, __u32 ifindex, __u16 ndm_flags,
-			    u32 nhid, struct vxlan_fdb **fdb,
-			    struct netlink_ext_ack *extack)
-{
-	struct vxlan_rdst *rd = NULL;
-	struct vxlan_fdb *f;
-	int rc;
-
-	if (vxlan->cfg.addrmax &&
-	    vxlan->addrcnt >= vxlan->cfg.addrmax)
-		return -ENOSPC;
-
-	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-	f = vxlan_fdb_alloc(vxlan, mac, state, src_vni, ndm_flags);
-	if (!f)
-		return -ENOMEM;
-
-	if (nhid)
-		rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
-	else
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-	if (rc < 0)
-		goto errout;
-
-	*fdb = f;
-
-	return 0;
-
-errout:
-	kfree(f);
-	return rc;
-}
-
-static void __vxlan_fdb_free(struct vxlan_fdb *f)
-{
-	struct vxlan_rdst *rd, *nd;
-	struct nexthop *nh;
-
-	nh = rcu_dereference_raw(f->nh);
-	if (nh) {
-		rcu_assign_pointer(f->nh, NULL);
-		rcu_assign_pointer(f->vdev, NULL);
-		nexthop_put(nh);
-	}
-
-	list_for_each_entry_safe(rd, nd, &f->remotes, list) {
-		dst_cache_destroy(&rd->dst_cache);
-		kfree(rd);
-	}
-	kfree(f);
-}
-
-static void vxlan_fdb_free(struct rcu_head *head)
-{
-	struct vxlan_fdb *f = container_of(head, struct vxlan_fdb, rcu);
-
-	__vxlan_fdb_free(f);
-}
-
-static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
-			      bool do_notify, bool swdev_notify)
-{
-	struct vxlan_rdst *rd;
-
-	netdev_dbg(vxlan->dev, "delete %pM\n", f->eth_addr);
-
-	--vxlan->addrcnt;
-	if (do_notify) {
-		if (rcu_access_pointer(f->nh))
-			vxlan_fdb_notify(vxlan, f, NULL, RTM_DELNEIGH,
-					 swdev_notify, NULL);
-		else
-			list_for_each_entry(rd, &f->remotes, list)
-				vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH,
-						 swdev_notify, NULL);
-	}
-
-	hlist_del_rcu(&f->hlist);
-	list_del_rcu(&f->nh_list);
-	call_rcu(&f->rcu, vxlan_fdb_free);
-}
-
-static void vxlan_dst_free(struct rcu_head *head)
-{
-	struct vxlan_rdst *rd = container_of(head, struct vxlan_rdst, rcu);
-
-	dst_cache_destroy(&rd->dst_cache);
-	kfree(rd);
-}
-
-static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
-				     union vxlan_addr *ip,
-				     __u16 state, __u16 flags,
-				     __be16 port, __be32 vni,
-				     __u32 ifindex, __u16 ndm_flags,
-				     struct vxlan_fdb *f, u32 nhid,
-				     bool swdev_notify,
-				     struct netlink_ext_ack *extack)
-{
-	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
-	struct vxlan_rdst *rd = NULL;
-	struct vxlan_rdst oldrd;
-	int notify = 0;
-	int rc = 0;
-	int err;
-
-	if (nhid && !rcu_access_pointer(f->nh)) {
-		NL_SET_ERR_MSG(extack,
-			       "Cannot replace an existing non nexthop fdb with a nexthop");
-		return -EOPNOTSUPP;
-	}
-
-	if (nhid && (flags & NLM_F_APPEND)) {
-		NL_SET_ERR_MSG(extack,
-			       "Cannot append to a nexthop fdb");
-		return -EOPNOTSUPP;
-	}
-
-	/* Do not allow an externally learned entry to take over an entry added
-	 * by the user.
-	 */
-	if (!(fdb_flags & NTF_EXT_LEARNED) ||
-	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
-		if (f->state != state) {
-			f->state = state;
-			f->updated = jiffies;
-			notify = 1;
-		}
-		if (f->flags != fdb_flags) {
-			f->flags = fdb_flags;
-			f->updated = jiffies;
-			notify = 1;
-		}
-	}
-
-	if ((flags & NLM_F_REPLACE)) {
-		/* Only change unicasts */
-		if (!(is_multicast_ether_addr(f->eth_addr) ||
-		      is_zero_ether_addr(f->eth_addr))) {
-			if (nhid) {
-				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
-				if (rc < 0)
-					return rc;
-			} else {
-				rc = vxlan_fdb_replace(f, ip, port, vni,
-						       ifindex, &oldrd);
-			}
-			notify |= rc;
-		} else {
-			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
-			return -EOPNOTSUPP;
-		}
-	}
-	if ((flags & NLM_F_APPEND) &&
-	    (is_multicast_ether_addr(f->eth_addr) ||
-	     is_zero_ether_addr(f->eth_addr))) {
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-
-		if (rc < 0)
-			return rc;
-		notify |= rc;
-	}
-
-	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
-
-	if (notify) {
-		if (rd == NULL)
-			rd = first_remote_rtnl(f);
-
-		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
-				       swdev_notify, extack);
-		if (err)
-			goto err_notify;
-	}
-
-	return 0;
-
-err_notify:
-	if (nhid)
-		return err;
-	if ((flags & NLM_F_REPLACE) && rc)
-		*rd = oldrd;
-	else if ((flags & NLM_F_APPEND) && rc) {
-		list_del_rcu(&rd->list);
-		call_rcu(&rd->rcu, vxlan_dst_free);
-	}
-	return err;
-}
-
-static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
-				   const u8 *mac, union vxlan_addr *ip,
-				   __u16 state, __u16 flags,
-				   __be16 port, __be32 src_vni, __be32 vni,
-				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
-				   bool swdev_notify,
-				   struct netlink_ext_ack *extack)
-{
-	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
-	struct vxlan_fdb *f;
-	int rc;
-
-	/* Disallow replace to add a multicast entry */
-	if ((flags & NLM_F_REPLACE) &&
-	    (is_multicast_ether_addr(mac) || is_zero_ether_addr(mac)))
-		return -EOPNOTSUPP;
-
-	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-	rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
-			      vni, ifindex, fdb_flags, nhid, &f, extack);
-	if (rc < 0)
-		return rc;
-
-	vxlan_fdb_insert(vxlan, mac, src_vni, f);
-	rc = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
-			      swdev_notify, extack);
-	if (rc)
-		goto err_notify;
-
-	return 0;
-
-err_notify:
-	vxlan_fdb_destroy(vxlan, f, false, false);
-	return rc;
-}
-
-/* Add new entry to forwarding table -- assumes lock held */
-static int vxlan_fdb_update(struct vxlan_dev *vxlan,
-			    const u8 *mac, union vxlan_addr *ip,
-			    __u16 state, __u16 flags,
-			    __be16 port, __be32 src_vni, __be32 vni,
-			    __u32 ifindex, __u16 ndm_flags, u32 nhid,
-			    bool swdev_notify,
-			    struct netlink_ext_ack *extack)
-{
-	struct vxlan_fdb *f;
-
-	f = __vxlan_find_mac(vxlan, mac, src_vni);
-	if (f) {
-		if (flags & NLM_F_EXCL) {
-			netdev_dbg(vxlan->dev,
-				   "lost race to create %pM\n", mac);
-			return -EEXIST;
-		}
-
-		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
-						 vni, ifindex, ndm_flags, f,
-						 nhid, swdev_notify, extack);
-	} else {
-		if (!(flags & NLM_F_CREATE))
-			return -ENOENT;
-
-		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
-					       port, src_vni, vni, ifindex,
-					       ndm_flags, nhid, swdev_notify,
-					       extack);
-	}
-}
-
-static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
-				  struct vxlan_rdst *rd, bool swdev_notify)
-{
-	list_del_rcu(&rd->list);
-	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, swdev_notify, NULL);
-	call_rcu(&rd->rcu, vxlan_dst_free);
-}
-
-static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
-			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
-			   __be32 *vni, u32 *ifindex, u32 *nhid)
-{
-	struct net *net = dev_net(vxlan->dev);
-	int err;
-
-	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
-	    tb[NDA_PORT]))
-		return -EINVAL;
-
-	if (tb[NDA_DST]) {
-		err = vxlan_nla_get_addr(ip, tb[NDA_DST]);
-		if (err)
-			return err;
-	} else {
-		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
-
-		if (remote->sa.sa_family == AF_INET) {
-			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
-			ip->sa.sa_family = AF_INET;
-#if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			ip->sin6.sin6_addr = in6addr_any;
-			ip->sa.sa_family = AF_INET6;
-#endif
-		}
-	}
-
-	if (tb[NDA_PORT]) {
-		if (nla_len(tb[NDA_PORT]) != sizeof(__be16))
-			return -EINVAL;
-		*port = nla_get_be16(tb[NDA_PORT]);
-	} else {
-		*port = vxlan->cfg.dst_port;
-	}
-
-	if (tb[NDA_VNI]) {
-		if (nla_len(tb[NDA_VNI]) != sizeof(u32))
-			return -EINVAL;
-		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
-	} else {
-		*vni = vxlan->default_dst.remote_vni;
-	}
-
-	if (tb[NDA_SRC_VNI]) {
-		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32))
-			return -EINVAL;
-		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
-	} else {
-		*src_vni = vxlan->default_dst.remote_vni;
-	}
-
-	if (tb[NDA_IFINDEX]) {
-		struct net_device *tdev;
-
-		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
-			return -EINVAL;
-		*ifindex = nla_get_u32(tb[NDA_IFINDEX]);
-		tdev = __dev_get_by_index(net, *ifindex);
-		if (!tdev)
-			return -EADDRNOTAVAIL;
-	} else {
-		*ifindex = 0;
-	}
-
-	if (tb[NDA_NH_ID])
-		*nhid = nla_get_u32(tb[NDA_NH_ID]);
-	else
-		*nhid = 0;
-
-	return 0;
-}
-
-/* Add static entry (via netlink) */
-static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			 struct net_device *dev,
-			 const unsigned char *addr, u16 vid, u16 flags,
-			 struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	/* struct net *net = dev_net(vxlan->dev); */
-	union vxlan_addr ip;
-	__be16 port;
-	__be32 src_vni, vni;
-	u32 ifindex, nhid;
-	u32 hash_index;
-	int err;
-
-	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
-		pr_info("RTM_NEWNEIGH with invalid state %#x\n",
-			ndm->ndm_state);
-		return -EINVAL;
-	}
-
-	if (!tb || (!tb[NDA_DST] && !tb[NDA_NH_ID]))
-		return -EINVAL;
-
-	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
-			      &nhid);
-	if (err)
-		return err;
-
-	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
-		return -EAFNOSUPPORT;
-
-	hash_index = fdb_head_index(vxlan, addr, src_vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
-			       port, src_vni, vni, ifindex,
-			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
-			       nhid, true, extack);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-static int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
-			      const unsigned char *addr, union vxlan_addr ip,
-			      __be16 port, __be32 src_vni, __be32 vni,
-			      u32 ifindex, bool swdev_notify)
-{
-	struct vxlan_rdst *rd = NULL;
-	struct vxlan_fdb *f;
-	int err = -ENOENT;
-
-	f = vxlan_find_mac(vxlan, addr, src_vni);
-	if (!f)
-		return err;
-
-	if (!vxlan_addr_any(&ip)) {
-		rd = vxlan_fdb_find_rdst(f, &ip, port, vni, ifindex);
-		if (!rd)
-			goto out;
-	}
-
-	/* remove a destination if it's not the only one on the list,
-	 * otherwise destroy the fdb entry
-	 */
-	if (rd && !list_is_singular(&f->remotes)) {
-		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
-		goto out;
-	}
-
-	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
-
-out:
-	return 0;
-}
-
-/* Delete entry (via netlink) */
-static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr, u16 vid)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	union vxlan_addr ip;
-	__be32 src_vni, vni;
-	u32 ifindex, nhid;
-	u32 hash_index;
-	__be16 port;
-	int err;
-
-	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
-			      &nhid);
-	if (err)
-		return err;
-
-	hash_index = fdb_head_index(vxlan, addr, src_vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	err = __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
-				 true);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-/* Dump forwarding table */
-static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
-			  struct net_device *dev,
-			  struct net_device *filter_dev, int *idx)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	unsigned int h;
-	int err = 0;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct vxlan_fdb *f;
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(f, &vxlan->fdb_head[h], hlist) {
-			struct vxlan_rdst *rd;
-
-			if (rcu_access_pointer(f->nh)) {
-				if (*idx < cb->args[2])
-					goto skip_nh;
-				err = vxlan_fdb_info(skb, vxlan, f,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWNEIGH,
-						     NLM_F_MULTI, NULL);
-				if (err < 0) {
-					rcu_read_unlock();
-					goto out;
-				}
-skip_nh:
-				*idx += 1;
-				continue;
-			}
-
-			list_for_each_entry_rcu(rd, &f->remotes, list) {
-				if (*idx < cb->args[2])
-					goto skip;
-
-				err = vxlan_fdb_info(skb, vxlan, f,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWNEIGH,
-						     NLM_F_MULTI, rd);
-				if (err < 0) {
-					rcu_read_unlock();
-					goto out;
-				}
-skip:
-				*idx += 1;
-			}
-		}
-		rcu_read_unlock();
-	}
-out:
-	return err;
-}
-
-static int vxlan_fdb_get(struct sk_buff *skb,
-			 struct nlattr *tb[],
-			 struct net_device *dev,
-			 const unsigned char *addr,
-			 u16 vid, u32 portid, u32 seq,
-			 struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb *f;
-	__be32 vni;
-	int err;
-
-	if (tb[NDA_VNI])
-		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
-	else
-		vni = vxlan->default_dst.remote_vni;
-
-	rcu_read_lock();
-
-	f = __vxlan_find_mac(vxlan, addr, vni);
-	if (!f) {
-		NL_SET_ERR_MSG(extack, "Fdb entry not found");
-		err = -ENOENT;
-		goto errout;
-	}
-
-	err = vxlan_fdb_info(skb, vxlan, f, portid, seq,
-			     RTM_NEWNEIGH, 0, first_remote_rcu(f));
-errout:
-	rcu_read_unlock();
-	return err;
-}
-
-/* Watch incoming packets to learn mapping between Ethernet address
- * and Tunnel endpoint.
- * Return true if packet is bogus and should be dropped.
- */
-static bool vxlan_snoop(struct net_device *dev,
-			union vxlan_addr *src_ip, const u8 *src_mac,
-			u32 src_ifindex, __be32 vni)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb *f;
-	u32 ifindex = 0;
-
-#if IS_ENABLED(CONFIG_IPV6)
-	if (src_ip->sa.sa_family == AF_INET6 &&
-	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
-		ifindex = src_ifindex;
-#endif
-
-	f = vxlan_find_mac(vxlan, src_mac, vni);
-	if (likely(f)) {
-		struct vxlan_rdst *rdst = first_remote_rcu(f);
-
-		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
-			   rdst->remote_ifindex == ifindex))
-			return false;
-
-		/* Don't migrate static entries, drop packets */
-		if (f->state & (NUD_PERMANENT | NUD_NOARP))
-			return true;
-
-		/* Don't override an fdb with nexthop with a learnt entry */
-		if (rcu_access_pointer(f->nh))
-			return true;
-
-		if (net_ratelimit())
-			netdev_info(dev,
-				    "%pM migrated from %pIS to %pIS\n",
-				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
-
-		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
-		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
-	} else {
-		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
-
-		/* learned new entry */
-		spin_lock(&vxlan->hash_lock[hash_index]);
-
-		/* close off race between vxlan_flush and incoming packets */
-		if (netif_running(dev))
-			vxlan_fdb_update(vxlan, src_mac, src_ip,
-					 NUD_REACHABLE,
-					 NLM_F_EXCL|NLM_F_CREATE,
-					 vxlan->cfg.dst_port,
-					 vni,
-					 vxlan->default_dst.remote_vni,
-					 ifindex, NTF_SELF, 0, true, NULL);
-		spin_unlock(&vxlan->hash_lock[hash_index]);
-	}
-
-	return false;
-}
-
-/* See if multicast group is already in use by other ID */
-static bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *sock4;
-#if IS_ENABLED(CONFIG_IPV6)
-	struct vxlan_sock *sock6;
-#endif
-	unsigned short family = dev->default_dst.remote_ip.sa.sa_family;
-
-	sock4 = rtnl_dereference(dev->vn4_sock);
-
-	/* The vxlan_sock is only used by dev, leaving group has
-	 * no effect on other vxlan devices.
-	 */
-	if (family == AF_INET && sock4 && refcount_read(&sock4->refcnt) == 1)
-		return false;
-#if IS_ENABLED(CONFIG_IPV6)
-	sock6 = rtnl_dereference(dev->vn6_sock);
-	if (family == AF_INET6 && sock6 && refcount_read(&sock6->refcnt) == 1)
-		return false;
-#endif
-
-	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
-		if (!netif_running(vxlan->dev) || vxlan == dev)
-			continue;
-
-		if (family == AF_INET &&
-		    rtnl_dereference(vxlan->vn4_sock) != sock4)
-			continue;
-#if IS_ENABLED(CONFIG_IPV6)
-		if (family == AF_INET6 &&
-		    rtnl_dereference(vxlan->vn6_sock) != sock6)
-			continue;
-#endif
-
-		if (!vxlan_addr_equal(&vxlan->default_dst.remote_ip,
-				      &dev->default_dst.remote_ip))
-			continue;
-
-		if (vxlan->default_dst.remote_ifindex !=
-		    dev->default_dst.remote_ifindex)
-			continue;
-
-		return true;
-	}
-
-	return false;
-}
-
-static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
-{
-	struct vxlan_net *vn;
-
-	if (!vs)
-		return false;
-	if (!refcount_dec_and_test(&vs->refcnt))
-		return false;
-
-	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
-	spin_lock(&vn->sock_lock);
-	hlist_del_rcu(&vs->hlist);
-	udp_tunnel_notify_del_rx_port(vs->sock,
-				      (vs->flags & VXLAN_F_GPE) ?
-				      UDP_TUNNEL_TYPE_VXLAN_GPE :
-				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
-
-	return true;
-}
-
-static void vxlan_sock_release(struct vxlan_dev *vxlan)
-{
-	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
-#if IS_ENABLED(CONFIG_IPV6)
-	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
-
-	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
-#endif
-
-	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
-	synchronize_net();
-
-	vxlan_vs_del_dev(vxlan);
-
-	if (__vxlan_sock_release_prep(sock4)) {
-		udp_tunnel_sock_release(sock4->sock);
-		kfree(sock4);
-	}
-
-#if IS_ENABLED(CONFIG_IPV6)
-	if (__vxlan_sock_release_prep(sock6)) {
-		udp_tunnel_sock_release(sock6->sock);
-		kfree(sock6);
-	}
-#endif
-}
-
-/* Update multicast group membership when first VNI on
- * multicast address is brought up
- */
-static int vxlan_igmp_join(struct vxlan_dev *vxlan)
-{
-	struct sock *sk;
-	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
-	int ifindex = vxlan->default_dst.remote_ifindex;
-	int ret = -EINVAL;
-
-	if (ip->sa.sa_family == AF_INET) {
-		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
-		struct ip_mreqn mreq = {
-			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
-			.imr_ifindex		= ifindex,
-		};
-
-		sk = sock4->sock->sk;
-		lock_sock(sk);
-		ret = ip_mc_join_group(sk, &mreq);
-		release_sock(sk);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
-
-		sk = sock6->sock->sk;
-		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
-						   &ip->sin6.sin6_addr);
-		release_sock(sk);
-#endif
-	}
-
-	return ret;
-}
-
-/* Inverse of vxlan_igmp_join when last VNI is brought down */
-static int vxlan_igmp_leave(struct vxlan_dev *vxlan)
-{
-	struct sock *sk;
-	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
-	int ifindex = vxlan->default_dst.remote_ifindex;
-	int ret = -EINVAL;
-
-	if (ip->sa.sa_family == AF_INET) {
-		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
-		struct ip_mreqn mreq = {
-			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
-			.imr_ifindex		= ifindex,
-		};
-
-		sk = sock4->sock->sk;
-		lock_sock(sk);
-		ret = ip_mc_leave_group(sk, &mreq);
-		release_sock(sk);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
-
-		sk = sock6->sock->sk;
-		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
-						   &ip->sin6.sin6_addr);
-		release_sock(sk);
-#endif
-	}
-
-	return ret;
-}
-
-static bool vxlan_remcsum(struct vxlanhdr *unparsed,
-			  struct sk_buff *skb, u32 vxflags)
-{
-	size_t start, offset;
-
-	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
-		goto out;
-
-	start = vxlan_rco_start(unparsed->vx_vni);
-	offset = start + vxlan_rco_offset(unparsed->vx_vni);
-
-	if (!pskb_may_pull(skb, offset + sizeof(u16)))
-		return false;
-
-	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
-			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
-out:
-	unparsed->vx_flags &= ~VXLAN_HF_RCO;
-	unparsed->vx_vni &= VXLAN_VNI_MASK;
-	return true;
-}
-
-static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
-				struct sk_buff *skb, u32 vxflags,
-				struct vxlan_metadata *md)
-{
-	struct vxlanhdr_gbp *gbp = (struct vxlanhdr_gbp *)unparsed;
-	struct metadata_dst *tun_dst;
-
-	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
-		goto out;
-
-	md->gbp = ntohs(gbp->policy_id);
-
-	tun_dst = (struct metadata_dst *)skb_dst(skb);
-	if (tun_dst) {
-		tun_dst->u.tun_info.key.tun_flags |= TUNNEL_VXLAN_OPT;
-		tun_dst->u.tun_info.options_len = sizeof(*md);
-	}
-	if (gbp->dont_learn)
-		md->gbp |= VXLAN_GBP_DONT_LEARN;
-
-	if (gbp->policy_applied)
-		md->gbp |= VXLAN_GBP_POLICY_APPLIED;
-
-	/* In flow-based mode, GBP is carried in dst_metadata */
-	if (!(vxflags & VXLAN_F_COLLECT_METADATA))
-		skb->mark = md->gbp;
-out:
-	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
-}
-
-static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
-				__be16 *protocol,
-				struct sk_buff *skb, u32 vxflags)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
-
-	/* Need to have Next Protocol set for interfaces in GPE mode. */
-	if (!gpe->np_applied)
-		return false;
-	/* "The initial version is 0. If a receiver does not support the
-	 * version indicated it MUST drop the packet.
-	 */
-	if (gpe->version != 0)
-		return false;
-	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
-	 * processing MUST occur." However, we don't implement OAM
-	 * processing, thus drop the packet.
-	 */
-	if (gpe->oam_flag)
-		return false;
-
-	*protocol = tun_p_to_eth_p(gpe->next_protocol);
-	if (!*protocol)
-		return false;
-
-	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
-	return true;
-}
-
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
-{
-	union vxlan_addr saddr;
-	u32 ifindex = skb->dev->ifindex;
-
-	skb_reset_mac_header(skb);
-	skb->protocol = eth_type_trans(skb, vxlan->dev);
-	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
-
-	/* Ignore packet loops (and multicast echo) */
-	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
-
-	/* Get address from the outer IP header */
-	if (vxlan_get_sk_family(vs) == AF_INET) {
-		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
-		saddr.sa.sa_family = AF_INET;
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
-		saddr.sa.sa_family = AF_INET6;
-#endif
-	}
-
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
-	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
-
-	return true;
-}
-
-static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
-				  struct sk_buff *skb)
-{
-	int err = 0;
-
-	if (vxlan_get_sk_family(vs) == AF_INET)
-		err = IP_ECN_decapsulate(oiph, skb);
-#if IS_ENABLED(CONFIG_IPV6)
-	else
-		err = IP6_ECN_decapsulate(oiph, skb);
-#endif
-
-	if (unlikely(err) && log_ecn_error) {
-		if (vxlan_get_sk_family(vs) == AF_INET)
-			net_info_ratelimited("non-ECT from %pI4 with TOS=%#x\n",
-					     &((struct iphdr *)oiph)->saddr,
-					     ((struct iphdr *)oiph)->tos);
-		else
-			net_info_ratelimited("non-ECT from %pI6\n",
-					     &((struct ipv6hdr *)oiph)->saddr);
-	}
-	return err <= 1;
-}
-
-/* Callback from net/ipv4/udp.c to receive packets */
-static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *vs;
-	struct vxlanhdr unparsed;
-	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
-	__be16 protocol = htons(ETH_P_TEB);
-	bool raw_proto = false;
-	void *oiph;
-	__be32 vni = 0;
-
-	/* Need UDP and VXLAN header to be present */
-	if (!pskb_may_pull(skb, VXLAN_HLEN))
-		goto drop;
-
-	unparsed = *vxlan_hdr(skb);
-	/* VNI flag always required to be set */
-	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
-		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
-			   ntohl(vxlan_hdr(skb)->vx_flags),
-			   ntohl(vxlan_hdr(skb)->vx_vni));
-		/* Return non vxlan pkt */
-		goto drop;
-	}
-	unparsed.vx_flags &= ~VXLAN_HF_VNI;
-	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
-
-	vs = rcu_dereference_sk_user_data(sk);
-	if (!vs)
-		goto drop;
-
-	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
-
-	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
-	if (!vxlan)
-		goto drop;
-
-	/* For backwards compatibility, only allow reserved fields to be
-	 * used by VXLAN extensions if explicitly requested.
-	 */
-	if (vs->flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
-			goto drop;
-		raw_proto = true;
-	}
-
-	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
-		goto drop;
-
-	if (vs->flags & VXLAN_F_REMCSUM_RX)
-		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
-			goto drop;
-
-	if (vxlan_collect_metadata(vs)) {
-		struct metadata_dst *tun_dst;
-
-		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), TUNNEL_KEY,
-					 key32_to_tunnel_id(vni), sizeof(*md));
-
-		if (!tun_dst)
-			goto drop;
-
-		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
-
-		skb_dst_set(skb, (struct dst_entry *)tun_dst);
-	} else {
-		memset(md, 0, sizeof(*md));
-	}
-
-	if (vs->flags & VXLAN_F_GBP)
-		vxlan_parse_gbp_hdr(&unparsed, skb, vs->flags, md);
-	/* Note that GBP and GPE can never be active together. This is
-	 * ensured in vxlan_dev_configure.
-	 */
-
-	if (unparsed.vx_flags || unparsed.vx_vni) {
-		/* If there are any unprocessed flags remaining treat
-		 * this as a malformed packet. This behavior diverges from
-		 * VXLAN RFC (RFC7348) which stipulates that bits in reserved
-		 * in reserved fields are to be ignored. The approach here
-		 * maintains compatibility with previous stack code, and also
-		 * is more robust and provides a little more security in
-		 * adding extensions to VXLAN.
-		 */
-		goto drop;
-	}
-
-	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
-			goto drop;
-	} else {
-		skb_reset_mac_header(skb);
-		skb->dev = vxlan->dev;
-		skb->pkt_type = PACKET_HOST;
-	}
-
-	oiph = skb_network_header(skb);
-	skb_reset_network_header(skb);
-
-	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
-		++vxlan->dev->stats.rx_frame_errors;
-		++vxlan->dev->stats.rx_errors;
-		goto drop;
-	}
-
-	rcu_read_lock();
-
-	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
-		rcu_read_unlock();
-		atomic_long_inc(&vxlan->dev->rx_dropped);
-		goto drop;
-	}
-
-	dev_sw_netstats_rx_add(vxlan->dev, skb->len);
-	gro_cells_receive(&vxlan->gro_cells, skb);
-
-	rcu_read_unlock();
-
-	return 0;
-
-drop:
-	/* Consume bad packet */
-	kfree_skb(skb);
-	return 0;
-}
-
-/* Callback from net/ipv{4,6}/udp.c to check that we have a VNI for errors */
-static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *vs;
-	struct vxlanhdr *hdr;
-	__be32 vni;
-
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + VXLAN_HLEN))
-		return -EINVAL;
-
-	hdr = vxlan_hdr(skb);
-
-	if (!(hdr->vx_flags & VXLAN_HF_VNI))
-		return -EINVAL;
-
-	vs = rcu_dereference_sk_user_data(sk);
-	if (!vs)
-		return -ENOENT;
-
-	vni = vxlan_vni(hdr->vx_vni);
-	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
-	if (!vxlan)
-		return -ENOENT;
-
-	return 0;
-}
-
-static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct arphdr *parp;
-	u8 *arpptr, *sha;
-	__be32 sip, tip;
-	struct neighbour *n;
-
-	if (dev->flags & IFF_NOARP)
-		goto out;
-
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev->stats.tx_dropped++;
-		goto out;
-	}
-	parp = arp_hdr(skb);
-
-	if ((parp->ar_hrd != htons(ARPHRD_ETHER) &&
-	     parp->ar_hrd != htons(ARPHRD_IEEE802)) ||
-	    parp->ar_pro != htons(ETH_P_IP) ||
-	    parp->ar_op != htons(ARPOP_REQUEST) ||
-	    parp->ar_hln != dev->addr_len ||
-	    parp->ar_pln != 4)
-		goto out;
-	arpptr = (u8 *)parp + sizeof(struct arphdr);
-	sha = arpptr;
-	arpptr += dev->addr_len;	/* sha */
-	memcpy(&sip, arpptr, sizeof(sip));
-	arpptr += sizeof(sip);
-	arpptr += dev->addr_len;	/* tha */
-	memcpy(&tip, arpptr, sizeof(tip));
-
-	if (ipv4_is_loopback(tip) ||
-	    ipv4_is_multicast(tip))
-		goto out;
-
-	n = neigh_lookup(&arp_tbl, &tip, dev);
-
-	if (n) {
-		struct vxlan_fdb *f;
-		struct sk_buff	*reply;
-
-		if (!(n->nud_state & NUD_CONNECTED)) {
-			neigh_release(n);
-			goto out;
-		}
-
-		f = vxlan_find_mac(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
-			/* bridge-local neighbor */
-			neigh_release(n);
-			goto out;
-		}
-
-		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
-				n->ha, sha);
-
-		neigh_release(n);
-
-		if (reply == NULL)
-			goto out;
-
-		skb_reset_mac_header(reply);
-		__skb_pull(reply, skb_network_offset(reply));
-		reply->ip_summed = CHECKSUM_UNNECESSARY;
-		reply->pkt_type = PACKET_HOST;
-
-		if (netif_rx_ni(reply) == NET_RX_DROP)
-			dev->stats.rx_dropped++;
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
-		union vxlan_addr ipa = {
-			.sin.sin_addr.s_addr = tip,
-			.sin.sin_family = AF_INET,
-		};
-
-		vxlan_ip_miss(dev, &ipa);
-	}
-out:
-	consume_skb(skb);
-	return NETDEV_TX_OK;
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static struct sk_buff *vxlan_na_create(struct sk_buff *request,
-	struct neighbour *n, bool isrouter)
-{
-	struct net_device *dev = request->dev;
-	struct sk_buff *reply;
-	struct nd_msg *ns, *na;
-	struct ipv6hdr *pip6;
-	u8 *daddr;
-	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
-	int ns_olen;
-	int i, len;
-
-	if (dev == NULL || !pskb_may_pull(request, request->len))
-		return NULL;
-
-	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
-		sizeof(*na) + na_olen + dev->needed_tailroom;
-	reply = alloc_skb(len, GFP_ATOMIC);
-	if (reply == NULL)
-		return NULL;
-
-	reply->protocol = htons(ETH_P_IPV6);
-	reply->dev = dev;
-	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
-	skb_push(reply, sizeof(struct ethhdr));
-	skb_reset_mac_header(reply);
-
-	ns = (struct nd_msg *)(ipv6_hdr(request) + 1);
-
-	daddr = eth_hdr(request)->h_source;
-	ns_olen = request->len - skb_network_offset(request) -
-		sizeof(struct ipv6hdr) - sizeof(*ns);
-	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
-		if (!ns->opt[i + 1]) {
-			kfree_skb(reply);
-			return NULL;
-		}
-		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
-			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
-			break;
-		}
-	}
-
-	/* Ethernet header */
-	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
-	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
-	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
-	reply->protocol = htons(ETH_P_IPV6);
-
-	skb_pull(reply, sizeof(struct ethhdr));
-	skb_reset_network_header(reply);
-	skb_put(reply, sizeof(struct ipv6hdr));
-
-	/* IPv6 header */
-
-	pip6 = ipv6_hdr(reply);
-	memset(pip6, 0, sizeof(struct ipv6hdr));
-	pip6->version = 6;
-	pip6->priority = ipv6_hdr(request)->priority;
-	pip6->nexthdr = IPPROTO_ICMPV6;
-	pip6->hop_limit = 255;
-	pip6->daddr = ipv6_hdr(request)->saddr;
-	pip6->saddr = *(struct in6_addr *)n->primary_key;
-
-	skb_pull(reply, sizeof(struct ipv6hdr));
-	skb_reset_transport_header(reply);
-
-	/* Neighbor Advertisement */
-	na = skb_put_zero(reply, sizeof(*na) + na_olen);
-	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
-	na->icmph.icmp6_router = isrouter;
-	na->icmph.icmp6_override = 1;
-	na->icmph.icmp6_solicited = 1;
-	na->target = ns->target;
-	ether_addr_copy(&na->opt[2], n->ha);
-	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
-	na->opt[1] = na_olen >> 3;
-
-	na->icmph.icmp6_cksum = csum_ipv6_magic(&pip6->saddr,
-		&pip6->daddr, sizeof(*na)+na_olen, IPPROTO_ICMPV6,
-		csum_partial(na, sizeof(*na)+na_olen, 0));
-
-	pip6->payload_len = htons(sizeof(*na)+na_olen);
-
-	skb_push(reply, sizeof(struct ipv6hdr));
-
-	reply->ip_summed = CHECKSUM_UNNECESSARY;
-
-	return reply;
-}
-
-static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct in6_addr *daddr;
-	const struct ipv6hdr *iphdr;
-	struct inet6_dev *in6_dev;
-	struct neighbour *n;
-	struct nd_msg *msg;
-
-	rcu_read_lock();
-	in6_dev = __in6_dev_get(dev);
-	if (!in6_dev)
-		goto out;
-
-	iphdr = ipv6_hdr(skb);
-	daddr = &iphdr->daddr;
-	msg = (struct nd_msg *)(iphdr + 1);
-
-	if (ipv6_addr_loopback(daddr) ||
-	    ipv6_addr_is_multicast(&msg->target))
-		goto out;
-
-	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
-
-	if (n) {
-		struct vxlan_fdb *f;
-		struct sk_buff *reply;
-
-		if (!(n->nud_state & NUD_CONNECTED)) {
-			neigh_release(n);
-			goto out;
-		}
-
-		f = vxlan_find_mac(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
-			/* bridge-local neighbor */
-			neigh_release(n);
-			goto out;
-		}
-
-		reply = vxlan_na_create(skb, n,
-					!!(f ? f->flags & NTF_ROUTER : 0));
-
-		neigh_release(n);
-
-		if (reply == NULL)
-			goto out;
-
-		if (netif_rx_ni(reply) == NET_RX_DROP)
-			dev->stats.rx_dropped++;
-
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
-		union vxlan_addr ipa = {
-			.sin6.sin6_addr = msg->target,
-			.sin6.sin6_family = AF_INET6,
-		};
-
-		vxlan_ip_miss(dev, &ipa);
-	}
-
-out:
-	rcu_read_unlock();
-	consume_skb(skb);
-	return NETDEV_TX_OK;
-}
-#endif
-
-static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct neighbour *n;
-
-	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
-		return false;
-
-	n = NULL;
-	switch (ntohs(eth_hdr(skb)->h_proto)) {
-	case ETH_P_IP:
-	{
-		struct iphdr *pip;
-
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return false;
-		pip = ip_hdr(skb);
-		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
-			union vxlan_addr ipa = {
-				.sin.sin_addr.s_addr = pip->daddr,
-				.sin.sin_family = AF_INET,
-			};
-
-			vxlan_ip_miss(dev, &ipa);
-			return false;
-		}
-
-		break;
-	}
-#if IS_ENABLED(CONFIG_IPV6)
-	case ETH_P_IPV6:
-	{
-		struct ipv6hdr *pip6;
-
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return false;
-		pip6 = ipv6_hdr(skb);
-		n = neigh_lookup(ipv6_stub->nd_tbl, &pip6->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
-			union vxlan_addr ipa = {
-				.sin6.sin6_addr = pip6->daddr,
-				.sin6.sin6_family = AF_INET6,
-			};
-
-			vxlan_ip_miss(dev, &ipa);
-			return false;
-		}
-
-		break;
-	}
-#endif
-	default:
-		return false;
-	}
-
-	if (n) {
-		bool diff;
-
-		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
-		if (diff) {
-			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
-				dev->addr_len);
-			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
-		}
-		neigh_release(n);
-		return diff;
-	}
-
-	return false;
-}
-
-static void vxlan_build_gbp_hdr(struct vxlanhdr *vxh, u32 vxflags,
-				struct vxlan_metadata *md)
-{
-	struct vxlanhdr_gbp *gbp;
-
-	if (!md->gbp)
-		return;
-
-	gbp = (struct vxlanhdr_gbp *)vxh;
-	vxh->vx_flags |= VXLAN_HF_GBP;
-
-	if (md->gbp & VXLAN_GBP_DONT_LEARN)
-		gbp->dont_learn = 1;
-
-	if (md->gbp & VXLAN_GBP_POLICY_APPLIED)
-		gbp->policy_applied = 1;
-
-	gbp->policy_id = htons(md->gbp & VXLAN_GBP_ID_MASK);
-}
-
-static int vxlan_build_gpe_hdr(struct vxlanhdr *vxh, u32 vxflags,
-			       __be16 protocol)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)vxh;
-
-	gpe->np_applied = 1;
-	gpe->next_protocol = tun_p_from_eth_p(protocol);
-	if (!gpe->next_protocol)
-		return -EPFNOSUPPORT;
-	return 0;
-}
-
-static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
-			   int iphdr_len, __be32 vni,
-			   struct vxlan_metadata *md, u32 vxflags,
-			   bool udp_sum)
-{
-	struct vxlanhdr *vxh;
-	int min_headroom;
-	int err;
-	int type = udp_sum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
-	__be16 inner_protocol = htons(ETH_P_TEB);
-
-	if ((vxflags & VXLAN_F_REMCSUM_TX) &&
-	    skb->ip_summed == CHECKSUM_PARTIAL) {
-		int csum_start = skb_checksum_start_offset(skb);
-
-		if (csum_start <= VXLAN_MAX_REMCSUM_START &&
-		    !(csum_start & VXLAN_RCO_SHIFT_MASK) &&
-		    (skb->csum_offset == offsetof(struct udphdr, check) ||
-		     skb->csum_offset == offsetof(struct tcphdr, check)))
-			type |= SKB_GSO_TUNNEL_REMCSUM;
-	}
-
-	min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len
-			+ VXLAN_HLEN + iphdr_len;
-
-	/* Need space for new headers (invalidates iph ptr) */
-	err = skb_cow_head(skb, min_headroom);
-	if (unlikely(err))
-		return err;
-
-	err = iptunnel_handle_offloads(skb, type);
-	if (err)
-		return err;
-
-	vxh = __skb_push(skb, sizeof(*vxh));
-	vxh->vx_flags = VXLAN_HF_VNI;
-	vxh->vx_vni = vxlan_vni_field(vni);
-
-	if (type & SKB_GSO_TUNNEL_REMCSUM) {
-		unsigned int start;
-
-		start = skb_checksum_start_offset(skb) - sizeof(struct vxlanhdr);
-		vxh->vx_vni |= vxlan_compute_rco(start, skb->csum_offset);
-		vxh->vx_flags |= VXLAN_HF_RCO;
-
-		if (!skb_is_gso(skb)) {
-			skb->ip_summed = CHECKSUM_NONE;
-			skb->encapsulation = 0;
-		}
-	}
-
-	if (vxflags & VXLAN_F_GBP)
-		vxlan_build_gbp_hdr(vxh, vxflags, md);
-	if (vxflags & VXLAN_F_GPE) {
-		err = vxlan_build_gpe_hdr(vxh, vxflags, skb->protocol);
-		if (err < 0)
-			return err;
-		inner_protocol = skb->protocol;
-	}
-
-	skb_set_inner_protocol(skb, inner_protocol);
-	return 0;
-}
-
-static struct rtable *vxlan_get_route(struct vxlan_dev *vxlan, struct net_device *dev,
-				      struct vxlan_sock *sock4,
-				      struct sk_buff *skb, int oif, u8 tos,
-				      __be32 daddr, __be32 *saddr, __be16 dport, __be16 sport,
-				      struct dst_cache *dst_cache,
-				      const struct ip_tunnel_info *info)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct rtable *rt = NULL;
-	struct flowi4 fl4;
-
-	if (!sock4)
-		return ERR_PTR(-EIO);
-
-	if (tos && !info)
-		use_cache = false;
-	if (use_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
-			return rt;
-	}
-
-	memset(&fl4, 0, sizeof(fl4));
-	fl4.flowi4_oif = oif;
-	fl4.flowi4_tos = RT_TOS(tos);
-	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_proto = IPPROTO_UDP;
-	fl4.daddr = daddr;
-	fl4.saddr = *saddr;
-	fl4.fl4_dport = dport;
-	fl4.fl4_sport = sport;
-
-	rt = ip_route_output_key(vxlan->net, &fl4);
-	if (!IS_ERR(rt)) {
-		if (rt->dst.dev == dev) {
-			netdev_dbg(dev, "circular route to %pI4\n", &daddr);
-			ip_rt_put(rt);
-			return ERR_PTR(-ELOOP);
-		}
-
-		*saddr = fl4.saddr;
-		if (use_cache)
-			dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
-	} else {
-		netdev_dbg(dev, "no route to %pI4\n", &daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	return rt;
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
-					  struct net_device *dev,
-					  struct vxlan_sock *sock6,
-					  struct sk_buff *skb, int oif, u8 tos,
-					  __be32 label,
-					  const struct in6_addr *daddr,
-					  struct in6_addr *saddr,
-					  __be16 dport, __be16 sport,
-					  struct dst_cache *dst_cache,
-					  const struct ip_tunnel_info *info)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct dst_entry *ndst;
-	struct flowi6 fl6;
-
-	if (!sock6)
-		return ERR_PTR(-EIO);
-
-	if (tos && !info)
-		use_cache = false;
-	if (use_cache) {
-		ndst = dst_cache_get_ip6(dst_cache, saddr);
-		if (ndst)
-			return ndst;
-	}
-
-	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_oif = oif;
-	fl6.daddr = *daddr;
-	fl6.saddr = *saddr;
-	fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tos), label);
-	fl6.flowi6_mark = skb->mark;
-	fl6.flowi6_proto = IPPROTO_UDP;
-	fl6.fl6_dport = dport;
-	fl6.fl6_sport = sport;
-
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(vxlan->net, sock6->sock->sk,
-					       &fl6, NULL);
-	if (unlikely(IS_ERR(ndst))) {
-		netdev_dbg(dev, "no route to %pI6\n", daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-
-	if (unlikely(ndst->dev == dev)) {
-		netdev_dbg(dev, "circular route to %pI6\n", daddr);
-		dst_release(ndst);
-		return ERR_PTR(-ELOOP);
-	}
-
-	*saddr = fl6.saddr;
-	if (use_cache)
-		dst_cache_set_ip6(dst_cache, ndst, saddr);
-	return ndst;
-}
-#endif
-
-/* Bypass encapsulation if the destination is local */
-static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
-			       struct vxlan_dev *dst_vxlan, __be32 vni,
-			       bool snoop)
-{
-	struct pcpu_sw_netstats *tx_stats, *rx_stats;
-	union vxlan_addr loopback;
-	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
-	struct net_device *dev;
-	int len = skb->len;
-
-	tx_stats = this_cpu_ptr(src_vxlan->dev->tstats);
-	rx_stats = this_cpu_ptr(dst_vxlan->dev->tstats);
-	skb->pkt_type = PACKET_HOST;
-	skb->encapsulation = 0;
-	skb->dev = dst_vxlan->dev;
-	__skb_pull(skb, skb_network_offset(skb));
-
-	if (remote_ip->sa.sa_family == AF_INET) {
-		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-		loopback.sa.sa_family =  AF_INET;
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		loopback.sin6.sin6_addr = in6addr_loopback;
-		loopback.sa.sa_family =  AF_INET6;
-#endif
-	}
-
-	rcu_read_lock();
-	dev = skb->dev;
-	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
-		goto drop;
-	}
-
-	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
-		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
-
-	u64_stats_update_begin(&tx_stats->syncp);
-	tx_stats->tx_packets++;
-	tx_stats->tx_bytes += len;
-	u64_stats_update_end(&tx_stats->syncp);
-
-	if (netif_rx(skb) == NET_RX_SUCCESS) {
-		u64_stats_update_begin(&rx_stats->syncp);
-		rx_stats->rx_packets++;
-		rx_stats->rx_bytes += len;
-		u64_stats_update_end(&rx_stats->syncp);
-	} else {
-drop:
-		dev->stats.rx_dropped++;
-	}
-	rcu_read_unlock();
-}
-
-static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
-				 struct vxlan_dev *vxlan,
-				 union vxlan_addr *daddr,
-				 __be16 dst_port, int dst_ifindex, __be32 vni,
-				 struct dst_entry *dst,
-				 u32 rt_flags)
-{
-#if IS_ENABLED(CONFIG_IPV6)
-	/* IPv6 rt-flags are checked against RTF_LOCAL, but the value of
-	 * RTF_LOCAL is equal to RTCF_LOCAL. So to keep code simple
-	 * we can use RTCF_LOCAL which works for ipv4 and ipv6 route entry.
-	 */
-	BUILD_BUG_ON(RTCF_LOCAL != RTF_LOCAL);
-#endif
-	/* Bypass encapsulation if the destination is local */
-	if (rt_flags & RTCF_LOCAL &&
-	    !(rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))) {
-		struct vxlan_dev *dst_vxlan;
-
-		dst_release(dst);
-		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
-					   daddr->sa.sa_family, dst_port,
-					   vxlan->cfg.flags);
-		if (!dst_vxlan) {
-			dev->stats.tx_errors++;
-			kfree_skb(skb);
-
-			return -ENOENT;
-		}
-		vxlan_encap_bypass(skb, vxlan, dst_vxlan, vni, true);
-		return 1;
-	}
-
-	return 0;
-}
-
-static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
-			   __be32 default_vni, struct vxlan_rdst *rdst,
-			   bool did_rsc)
-{
-	struct dst_cache *dst_cache;
-	struct ip_tunnel_info *info;
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct iphdr *old_iph = ip_hdr(skb);
-	union vxlan_addr *dst;
-	union vxlan_addr remote_ip, local_ip;
-	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
-	__be16 src_port = 0, dst_port;
-	struct dst_entry *ndst = NULL;
-	__be32 vni, label;
-	__u8 tos, ttl;
-	int ifindex;
-	int err;
-	u32 flags = vxlan->cfg.flags;
-	bool udp_sum = false;
-	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
-
-	info = skb_tunnel_info(skb);
-
-	if (rdst) {
-		dst = &rdst->remote_ip;
-		if (vxlan_addr_any(dst)) {
-			if (did_rsc) {
-				/* short-circuited back to local bridge */
-				vxlan_encap_bypass(skb, vxlan, vxlan,
-						   default_vni, true);
-				return;
-			}
-			goto drop;
-		}
-
-		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
-		vni = (rdst->remote_vni) ? : default_vni;
-		ifindex = rdst->remote_ifindex;
-		local_ip = vxlan->cfg.saddr;
-		dst_cache = &rdst->dst_cache;
-		md->gbp = skb->mark;
-		if (flags & VXLAN_F_TTL_INHERIT) {
-			ttl = ip_tunnel_get_ttl(old_iph, skb);
-		} else {
-			ttl = vxlan->cfg.ttl;
-			if (!ttl && vxlan_addr_multicast(dst))
-				ttl = 1;
-		}
-
-		tos = vxlan->cfg.tos;
-		if (tos == 1)
-			tos = ip_tunnel_get_dsfield(old_iph, skb);
-
-		if (dst->sa.sa_family == AF_INET)
-			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
-		else
-			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
-		label = vxlan->cfg.label;
-	} else {
-		if (!info) {
-			WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
-				  dev->name);
-			goto drop;
-		}
-		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
-		if (remote_ip.sa.sa_family == AF_INET) {
-			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
-			local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
-		} else {
-			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
-			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
-		}
-		dst = &remote_ip;
-		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
-		vni = tunnel_id_to_key32(info->key.tun_id);
-		ifindex = 0;
-		dst_cache = &info->dst_cache;
-		if (info->key.tun_flags & TUNNEL_VXLAN_OPT) {
-			if (info->options_len < sizeof(*md))
-				goto drop;
-			md = ip_tunnel_info_opts(info);
-		}
-		ttl = info->key.ttl;
-		tos = info->key.tos;
-		label = info->key.label;
-		udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
-	}
-	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				     vxlan->cfg.port_max, true);
-
-	rcu_read_lock();
-	if (dst->sa.sa_family == AF_INET) {
-		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
-		struct rtable *rt;
-		__be16 df = 0;
-
-		if (!ifindex)
-			ifindex = sock4->sock->sk->sk_bound_dev_if;
-
-		rt = vxlan_get_route(vxlan, dev, sock4, skb, ifindex, tos,
-				     dst->sin.sin_addr.s_addr,
-				     &local_ip.sin.sin_addr.s_addr,
-				     dst_port, src_port,
-				     dst_cache, info);
-		if (IS_ERR(rt)) {
-			err = PTR_ERR(rt);
-			goto tx_error;
-		}
-
-		if (!info) {
-			/* Bypass encapsulation if the destination is local */
-			err = encap_bypass_if_local(skb, dev, vxlan, dst,
-						    dst_port, ifindex, vni,
-						    &rt->dst, rt->rt_flags);
-			if (err)
-				goto out_unlock;
-
-			if (vxlan->cfg.df == VXLAN_DF_SET) {
-				df = htons(IP_DF);
-			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
-				struct ethhdr *eth = eth_hdr(skb);
-
-				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
-				    (ntohs(eth->h_proto) == ETH_P_IP &&
-				     old_iph->frag_off & htons(IP_DF)))
-					df = htons(IP_DF);
-			}
-		} else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT) {
-			df = htons(IP_DF);
-		}
-
-		ndst = &rt->dst;
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN_HEADROOM,
-					    netif_is_any_bridge_port(dev));
-		if (err < 0) {
-			goto tx_error;
-		} else if (err) {
-			if (info) {
-				struct ip_tunnel_info *unclone;
-				struct in_addr src, dst;
-
-				unclone = skb_tunnel_info_unclone(skb);
-				if (unlikely(!unclone))
-					goto tx_error;
-
-				src = remote_ip.sin.sin_addr;
-				dst = local_ip.sin.sin_addr;
-				unclone->key.u.ipv4.src = src.s_addr;
-				unclone->key.u.ipv4.dst = dst.s_addr;
-			}
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
-			goto out_unlock;
-		}
-
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
-		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
-		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
-				      vni, md, flags, udp_sum);
-		if (err < 0)
-			goto tx_error;
-
-		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
-				    dst->sin.sin_addr.s_addr, tos, ttl, df,
-				    src_port, dst_port, xnet, !udp_sum);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
-
-		if (!ifindex)
-			ifindex = sock6->sock->sk->sk_bound_dev_if;
-
-		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
-					label, &dst->sin6.sin6_addr,
-					&local_ip.sin6.sin6_addr,
-					dst_port, src_port,
-					dst_cache, info);
-		if (IS_ERR(ndst)) {
-			err = PTR_ERR(ndst);
-			ndst = NULL;
-			goto tx_error;
-		}
-
-		if (!info) {
-			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
-
-			err = encap_bypass_if_local(skb, dev, vxlan, dst,
-						    dst_port, ifindex, vni,
-						    ndst, rt6i_flags);
-			if (err)
-				goto out_unlock;
-		}
-
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN6_HEADROOM,
-					    netif_is_any_bridge_port(dev));
-		if (err < 0) {
-			goto tx_error;
-		} else if (err) {
-			if (info) {
-				struct ip_tunnel_info *unclone;
-				struct in6_addr src, dst;
-
-				unclone = skb_tunnel_info_unclone(skb);
-				if (unlikely(!unclone))
-					goto tx_error;
-
-				src = remote_ip.sin6.sin6_addr;
-				dst = local_ip.sin6.sin6_addr;
-				unclone->key.u.ipv6.src = src;
-				unclone->key.u.ipv6.dst = dst;
-			}
-
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
-			goto out_unlock;
-		}
-
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
-		ttl = ttl ? : ip6_dst_hoplimit(ndst);
-		skb_scrub_packet(skb, xnet);
-		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
-				      vni, md, flags, udp_sum);
-		if (err < 0)
-			goto tx_error;
-
-		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
-				     &local_ip.sin6.sin6_addr,
-				     &dst->sin6.sin6_addr, tos, ttl,
-				     label, src_port, dst_port, !udp_sum);
-#endif
-	}
-out_unlock:
-	rcu_read_unlock();
-	return;
-
-drop:
-	dev->stats.tx_dropped++;
-	dev_kfree_skb(skb);
-	return;
-
-tx_error:
-	rcu_read_unlock();
-	if (err == -ELOOP)
-		dev->stats.collisions++;
-	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
-	dst_release(ndst);
-	dev->stats.tx_errors++;
-	kfree_skb(skb);
-}
-
-static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
-			  struct vxlan_fdb *f, __be32 vni, bool did_rsc)
-{
-	struct vxlan_rdst nh_rdst;
-	struct nexthop *nh;
-	bool do_xmit;
-	u32 hash;
-
-	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
-	hash = skb_get_hash(skb);
-
-	rcu_read_lock();
-	nh = rcu_dereference(f->nh);
-	if (!nh) {
-		rcu_read_unlock();
-		goto drop;
-	}
-	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
-	rcu_read_unlock();
-
-	if (likely(do_xmit))
-		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
-	else
-		goto drop;
-
-	return;
-
-drop:
-	dev->stats.tx_dropped++;
-	dev_kfree_skb(skb);
-}
-
-/* Transmit local packets over Vxlan
- *
- * Outer IP header inherits ECN and DF from inner header.
- * Outer UDP destination is the VXLAN assigned port.
- *           source port is based on hash of flow
- */
-static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *rdst, *fdst = NULL;
-	const struct ip_tunnel_info *info;
-	bool did_rsc = false;
-	struct vxlan_fdb *f;
-	struct ethhdr *eth;
-	__be32 vni = 0;
-
-	info = skb_tunnel_info(skb);
-
-	skb_reset_mac_header(skb);
-
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
-		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
-		    info->mode & IP_TUNNEL_INFO_TX) {
-			vni = tunnel_id_to_key32(info->key.tun_id);
-		} else {
-			if (info && info->mode & IP_TUNNEL_INFO_TX)
-				vxlan_xmit_one(skb, dev, vni, NULL, false);
-			else
-				kfree_skb(skb);
-			return NETDEV_TX_OK;
-		}
-	}
-
-	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
-		eth = eth_hdr(skb);
-		if (ntohs(eth->h_proto) == ETH_P_ARP)
-			return arp_reduce(dev, skb, vni);
-#if IS_ENABLED(CONFIG_IPV6)
-		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
-			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-					    sizeof(struct nd_msg)) &&
-			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
-			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
-
-			if (m->icmph.icmp6_code == 0 &&
-			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, vni);
-		}
-#endif
-	}
-
-	eth = eth_hdr(skb);
-	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
-	did_rsc = false;
-
-	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
-	    (ntohs(eth->h_proto) == ETH_P_IP ||
-	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
-		did_rsc = route_shortcircuit(dev, skb);
-		if (did_rsc)
-			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
-	}
-
-	if (f == NULL) {
-		f = vxlan_find_mac(vxlan, all_zeros_mac, vni);
-		if (f == NULL) {
-			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
-			    !is_multicast_ether_addr(eth->h_dest))
-				vxlan_fdb_miss(vxlan, eth->h_dest);
-
-			dev->stats.tx_dropped++;
-			kfree_skb(skb);
-			return NETDEV_TX_OK;
-		}
-	}
-
-	if (rcu_access_pointer(f->nh)) {
-		vxlan_xmit_nh(skb, dev, f,
-			      (vni ? : vxlan->default_dst.remote_vni), did_rsc);
-	} else {
-		list_for_each_entry_rcu(rdst, &f->remotes, list) {
-			struct sk_buff *skb1;
-
-			if (!fdst) {
-				fdst = rdst;
-				continue;
-			}
-			skb1 = skb_clone(skb, GFP_ATOMIC);
-			if (skb1)
-				vxlan_xmit_one(skb1, dev, vni, rdst, did_rsc);
-		}
-		if (fdst)
-			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
-		else
-			kfree_skb(skb);
-	}
-
-	return NETDEV_TX_OK;
-}
-
-/* Walk the forwarding table and purge stale entries */
-static void vxlan_cleanup(struct timer_list *t)
-{
-	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
-	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
-	unsigned int h;
-
-	if (!netif_running(vxlan->dev))
-		return;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct hlist_node *p, *n;
-
-		spin_lock(&vxlan->hash_lock[h]);
-		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
-			struct vxlan_fdb *f
-				= container_of(p, struct vxlan_fdb, hlist);
-			unsigned long timeout;
-
-			if (f->state & (NUD_PERMANENT | NUD_NOARP))
-				continue;
-
-			if (f->flags & NTF_EXT_LEARNED)
-				continue;
-
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
-			if (time_before_eq(timeout, jiffies)) {
-				netdev_dbg(vxlan->dev,
-					   "garbage collect %pM\n",
-					   f->eth_addr);
-				f->state = NUD_STALE;
-				vxlan_fdb_destroy(vxlan, f, true, true);
-			} else if (time_before(timeout, next_timer))
-				next_timer = timeout;
-		}
-		spin_unlock(&vxlan->hash_lock[h]);
-	}
-
-	mod_timer(&vxlan->age_timer, next_timer);
-}
-
-static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
-{
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-
-	spin_lock(&vn->sock_lock);
-	hlist_del_init_rcu(&vxlan->hlist4.hlist);
-#if IS_ENABLED(CONFIG_IPV6)
-	hlist_del_init_rcu(&vxlan->hlist6.hlist);
-#endif
-	spin_unlock(&vn->sock_lock);
-}
-
-static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
-			     struct vxlan_dev_node *node)
-{
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	__be32 vni = vxlan->default_dst.remote_vni;
-
-	node->vxlan = vxlan;
-	spin_lock(&vn->sock_lock);
-	hlist_add_head_rcu(&node->hlist, vni_head(vs, vni));
-	spin_unlock(&vn->sock_lock);
-}
-
-/* Setup stats when device is created */
-static int vxlan_init(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	int err;
-
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
-	err = gro_cells_init(&vxlan->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
-		return err;
-	}
-
-	return 0;
-}
-
-static void vxlan_fdb_delete_default(struct vxlan_dev *vxlan, __be32 vni)
-{
-	struct vxlan_fdb *f;
-	u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, vni);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	f = __vxlan_find_mac(vxlan, all_zeros_mac, vni);
-	if (f)
-		vxlan_fdb_destroy(vxlan, f, true, true);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-}
-
-static void vxlan_uninit(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-
-	gro_cells_destroy(&vxlan->gro_cells);
-
-	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
-
-	free_percpu(dev->tstats);
-}
-
-/* Start ageing timer and join group when device is brought up */
-static int vxlan_open(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	int ret;
-
-	ret = vxlan_sock_add(vxlan);
-	if (ret < 0)
-		return ret;
-
-	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
-		ret = vxlan_igmp_join(vxlan);
-		if (ret == -EADDRINUSE)
-			ret = 0;
-		if (ret) {
-			vxlan_sock_release(vxlan);
-			return ret;
-		}
-	}
-
-	if (vxlan->cfg.age_interval)
-		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
-
-	return ret;
-}
-
-/* Purge the forwarding table */
-static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
-{
-	unsigned int h;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct hlist_node *p, *n;
-
-		spin_lock_bh(&vxlan->hash_lock[h]);
-		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
-			struct vxlan_fdb *f
-				= container_of(p, struct vxlan_fdb, hlist);
-			if (!do_all && (f->state & (NUD_PERMANENT | NUD_NOARP)))
-				continue;
-			/* the all_zeros_mac entry is deleted at vxlan_uninit */
-			if (is_zero_ether_addr(f->eth_addr) &&
-			    f->vni == vxlan->cfg.vni)
-				continue;
-			vxlan_fdb_destroy(vxlan, f, true, true);
-		}
-		spin_unlock_bh(&vxlan->hash_lock[h]);
-	}
-}
-
-/* Cleanup timer and forwarding table on shutdown */
-static int vxlan_stop(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	int ret = 0;
-
-	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
-	    !vxlan_group_used(vn, vxlan))
-		ret = vxlan_igmp_leave(vxlan);
-
-	del_timer_sync(&vxlan->age_timer);
-
-	vxlan_flush(vxlan, false);
-	vxlan_sock_release(vxlan);
-
-	return ret;
-}
-
-/* Stub, nothing needs to be done. */
-static void vxlan_set_multicast_list(struct net_device *dev)
-{
-}
-
-static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
-	bool use_ipv6 = !!(vxlan->cfg.flags & VXLAN_F_IPV6);
-
-	/* This check is different than dev->max_mtu, because it looks at
-	 * the lowerdev->mtu, rather than the static dev->max_mtu
-	 */
-	if (lowerdev) {
-		int max_mtu = lowerdev->mtu -
-			      (use_ipv6 ? VXLAN6_HEADROOM : VXLAN_HEADROOM);
-		if (new_mtu > max_mtu)
-			return -EINVAL;
-	}
-
-	dev->mtu = new_mtu;
-	return 0;
-}
-
-static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct ip_tunnel_info *info = skb_tunnel_info(skb);
-	__be16 sport, dport;
-
-	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				  vxlan->cfg.port_max, true);
-	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
-
-	if (ip_tunnel_info_af(info) == AF_INET) {
-		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
-		struct rtable *rt;
-
-		rt = vxlan_get_route(vxlan, dev, sock4, skb, 0, info->key.tos,
-				     info->key.u.ipv4.dst,
-				     &info->key.u.ipv4.src, dport, sport,
-				     &info->dst_cache, info);
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
-		ip_rt_put(rt);
-	} else {
-#if IS_ENABLED(CONFIG_IPV6)
-		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
-		struct dst_entry *ndst;
-
-		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, 0, info->key.tos,
-					info->key.label, &info->key.u.ipv6.dst,
-					&info->key.u.ipv6.src, dport, sport,
-					&info->dst_cache, info);
-		if (IS_ERR(ndst))
-			return PTR_ERR(ndst);
-		dst_release(ndst);
-#else /* !CONFIG_IPV6 */
-		return -EPFNOSUPPORT;
-#endif
-	}
-	info->key.tp_src = sport;
-	info->key.tp_dst = dport;
-	return 0;
-}
-
-static const struct net_device_ops vxlan_netdev_ether_ops = {
-	.ndo_init		= vxlan_init,
-	.ndo_uninit		= vxlan_uninit,
-	.ndo_open		= vxlan_open,
-	.ndo_stop		= vxlan_stop,
-	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= ip_tunnel_get_stats64,
-	.ndo_set_rx_mode	= vxlan_set_multicast_list,
-	.ndo_change_mtu		= vxlan_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
-	.ndo_fdb_add		= vxlan_fdb_add,
-	.ndo_fdb_del		= vxlan_fdb_delete,
-	.ndo_fdb_dump		= vxlan_fdb_dump,
-	.ndo_fdb_get		= vxlan_fdb_get,
-	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
-	.ndo_change_proto_down  = dev_change_proto_down_generic,
-};
-
-static const struct net_device_ops vxlan_netdev_raw_ops = {
-	.ndo_init		= vxlan_init,
-	.ndo_uninit		= vxlan_uninit,
-	.ndo_open		= vxlan_open,
-	.ndo_stop		= vxlan_stop,
-	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= ip_tunnel_get_stats64,
-	.ndo_change_mtu		= vxlan_change_mtu,
-	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
-};
-
-/* Info for udev, that this is a virtual tunnel endpoint */
-static struct device_type vxlan_type = {
-	.name = "vxlan",
-};
-
-/* Calls the ndo_udp_tunnel_add of the caller in order to
- * supply the listening VXLAN udp ports. Callers are expected
- * to implement the ndo_udp_tunnel_add.
- */
-static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
-{
-	struct vxlan_sock *vs;
-	struct net *net = dev_net(dev);
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	unsigned int i;
-
-	spin_lock(&vn->sock_lock);
-	for (i = 0; i < PORT_HASH_SIZE; ++i) {
-		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
-			unsigned short type;
-
-			if (vs->flags & VXLAN_F_GPE)
-				type = UDP_TUNNEL_TYPE_VXLAN_GPE;
-			else
-				type = UDP_TUNNEL_TYPE_VXLAN;
-
-			if (push)
-				udp_tunnel_push_rx_port(dev, vs->sock, type);
-			else
-				udp_tunnel_drop_rx_port(dev, vs->sock, type);
-		}
-	}
-	spin_unlock(&vn->sock_lock);
-}
-
-/* Initialize the device structure. */
-static void vxlan_setup(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	unsigned int h;
-
-	eth_hw_addr_random(dev);
-	ether_setup(dev);
-
-	dev->needs_free_netdev = true;
-	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
-
-	dev->features	|= NETIF_F_LLTX;
-	dev->features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
-	dev->features   |= NETIF_F_RXCSUM;
-	dev->features   |= NETIF_F_GSO_SOFTWARE;
-
-	dev->vlan_features = dev->features;
-	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
-	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
-	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE;
-
-	/* MTU range: 68 - 65535 */
-	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = ETH_MAX_MTU;
-
-	INIT_LIST_HEAD(&vxlan->next);
-
-	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
-
-	vxlan->dev = dev;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_init(&vxlan->hash_lock[h]);
-		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
-	}
-}
-
-static void vxlan_ether_setup(struct net_device *dev)
-{
-	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	dev->netdev_ops = &vxlan_netdev_ether_ops;
-}
-
-static void vxlan_raw_setup(struct net_device *dev)
-{
-	dev->header_ops = NULL;
-	dev->type = ARPHRD_NONE;
-	dev->hard_header_len = 0;
-	dev->addr_len = 0;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
-	dev->netdev_ops = &vxlan_netdev_raw_ops;
-}
-
-static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
-	[IFLA_VXLAN_ID]		= { .type = NLA_U32 },
-	[IFLA_VXLAN_GROUP]	= { .len = sizeof_field(struct iphdr, daddr) },
-	[IFLA_VXLAN_GROUP6]	= { .len = sizeof(struct in6_addr) },
-	[IFLA_VXLAN_LINK]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_LOCAL]	= { .len = sizeof_field(struct iphdr, saddr) },
-	[IFLA_VXLAN_LOCAL6]	= { .len = sizeof(struct in6_addr) },
-	[IFLA_VXLAN_TOS]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_TTL]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_LABEL]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_LEARNING]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_AGEING]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_LIMIT]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_PORT_RANGE] = { .len  = sizeof(struct ifla_vxlan_port_range) },
-	[IFLA_VXLAN_PROXY]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_RSC]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_L2MISS]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_L3MISS]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_COLLECT_METADATA]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_PORT]	= { .type = NLA_U16 },
-	[IFLA_VXLAN_UDP_CSUM]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_REMCSUM_TX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_REMCSUM_RX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_GBP]	= { .type = NLA_FLAG, },
-	[IFLA_VXLAN_GPE]	= { .type = NLA_FLAG, },
-	[IFLA_VXLAN_REMCSUM_NOPARTIAL]	= { .type = NLA_FLAG },
-	[IFLA_VXLAN_TTL_INHERIT]	= { .type = NLA_FLAG },
-	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
-};
-
-static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
-{
-	if (tb[IFLA_ADDRESS]) {
-		if (nla_len(tb[IFLA_ADDRESS]) != ETH_ALEN) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
-					    "Provided link layer address is not Ethernet");
-			return -EINVAL;
-		}
-
-		if (!is_valid_ether_addr(nla_data(tb[IFLA_ADDRESS]))) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
-					    "Provided Ethernet address is not unicast");
-			return -EADDRNOTAVAIL;
-		}
-	}
-
-	if (tb[IFLA_MTU]) {
-		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
-
-		if (mtu < ETH_MIN_MTU || mtu > ETH_MAX_MTU) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
-					    "MTU must be between 68 and 65535");
-			return -EINVAL;
-		}
-	}
-
-	if (!data) {
-		NL_SET_ERR_MSG(extack,
-			       "Required attributes not provided to perform the operation");
-		return -EINVAL;
-	}
-
-	if (data[IFLA_VXLAN_ID]) {
-		u32 id = nla_get_u32(data[IFLA_VXLAN_ID]);
-
-		if (id >= VXLAN_N_VID) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_ID],
-					    "VXLAN ID must be lower than 16777216");
-			return -ERANGE;
-		}
-	}
-
-	if (data[IFLA_VXLAN_PORT_RANGE]) {
-		const struct ifla_vxlan_port_range *p
-			= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
-
-		if (ntohs(p->high) < ntohs(p->low)) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_PORT_RANGE],
-					    "Invalid source port range");
-			return -EINVAL;
-		}
-	}
-
-	if (data[IFLA_VXLAN_DF]) {
-		enum ifla_vxlan_df df = nla_get_u8(data[IFLA_VXLAN_DF]);
-
-		if (df < 0 || df > VXLAN_DF_MAX) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_DF],
-					    "Invalid DF attribute");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-static void vxlan_get_drvinfo(struct net_device *netdev,
-			      struct ethtool_drvinfo *drvinfo)
-{
-	strlcpy(drvinfo->version, VXLAN_VERSION, sizeof(drvinfo->version));
-	strlcpy(drvinfo->driver, "vxlan", sizeof(drvinfo->driver));
-}
-
-static int vxlan_get_link_ksettings(struct net_device *dev,
-				    struct ethtool_link_ksettings *cmd)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
-
-	if (!lowerdev) {
-		cmd->base.duplex = DUPLEX_UNKNOWN;
-		cmd->base.port = PORT_OTHER;
-		cmd->base.speed = SPEED_UNKNOWN;
-
-		return 0;
-	}
-
-	return __ethtool_get_link_ksettings(lowerdev, cmd);
-}
-
-static const struct ethtool_ops vxlan_ethtool_ops = {
-	.get_drvinfo		= vxlan_get_drvinfo,
-	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= vxlan_get_link_ksettings,
-};
-
-static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
-					__be16 port, u32 flags, int ifindex)
-{
-	struct socket *sock;
-	struct udp_port_cfg udp_conf;
-	int err;
-
-	memset(&udp_conf, 0, sizeof(udp_conf));
-
-	if (ipv6) {
-		udp_conf.family = AF_INET6;
-		udp_conf.use_udp6_rx_checksums =
-		    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
-		udp_conf.ipv6_v6only = 1;
-	} else {
-		udp_conf.family = AF_INET;
-	}
-
-	udp_conf.local_udp_port = port;
-	udp_conf.bind_ifindex = ifindex;
-
-	/* Open UDP socket */
-	err = udp_sock_create(net, &udp_conf, &sock);
-	if (err < 0)
-		return ERR_PTR(err);
-
-	return sock;
-}
-
-/* Create new listen socket if needed */
-static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
-					      __be16 port, u32 flags,
-					      int ifindex)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	struct vxlan_sock *vs;
-	struct socket *sock;
-	unsigned int h;
-	struct udp_tunnel_sock_cfg tunnel_cfg;
-
-	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
-	if (!vs)
-		return ERR_PTR(-ENOMEM);
-
-	for (h = 0; h < VNI_HASH_SIZE; ++h)
-		INIT_HLIST_HEAD(&vs->vni_list[h]);
-
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
-	if (IS_ERR(sock)) {
-		kfree(vs);
-		return ERR_CAST(sock);
-	}
-
-	vs->sock = sock;
-	refcount_set(&vs->refcnt, 1);
-	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
-
-	spin_lock(&vn->sock_lock);
-	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
-	udp_tunnel_notify_add_rx_port(sock,
-				      (vs->flags & VXLAN_F_GPE) ?
-				      UDP_TUNNEL_TYPE_VXLAN_GPE :
-				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
-
-	/* Mark socket as an encapsulation socket. */
-	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
-	tunnel_cfg.sk_user_data = vs;
-	tunnel_cfg.encap_type = 1;
-	tunnel_cfg.encap_rcv = vxlan_rcv;
-	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
-	tunnel_cfg.encap_destroy = NULL;
-	tunnel_cfg.gro_receive = vxlan_gro_receive;
-	tunnel_cfg.gro_complete = vxlan_gro_complete;
-
-	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
-
-	return vs;
-}
-
-static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
-{
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	struct vxlan_sock *vs = NULL;
-	struct vxlan_dev_node *node;
-	int l3mdev_index = 0;
-
-	if (vxlan->cfg.remote_ifindex)
-		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
-			vxlan->net, vxlan->cfg.remote_ifindex);
-
-	if (!vxlan->cfg.no_share) {
-		spin_lock(&vn->sock_lock);
-		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
-				     vxlan->cfg.dst_port, vxlan->cfg.flags,
-				     l3mdev_index);
-		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
-			spin_unlock(&vn->sock_lock);
-			return -EBUSY;
-		}
-		spin_unlock(&vn->sock_lock);
-	}
-	if (!vs)
-		vs = vxlan_socket_create(vxlan->net, ipv6,
-					 vxlan->cfg.dst_port, vxlan->cfg.flags,
-					 l3mdev_index);
-	if (IS_ERR(vs))
-		return PTR_ERR(vs);
-#if IS_ENABLED(CONFIG_IPV6)
-	if (ipv6) {
-		rcu_assign_pointer(vxlan->vn6_sock, vs);
-		node = &vxlan->hlist6;
-	} else
-#endif
-	{
-		rcu_assign_pointer(vxlan->vn4_sock, vs);
-		node = &vxlan->hlist4;
-	}
-	vxlan_vs_add_dev(vs, vxlan, node);
-	return 0;
-}
-
-static int vxlan_sock_add(struct vxlan_dev *vxlan)
-{
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
-	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
-	bool ipv4 = !ipv6 || metadata;
-	int ret = 0;
-
-	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
-#if IS_ENABLED(CONFIG_IPV6)
-	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
-	if (ipv6) {
-		ret = __vxlan_sock_add(vxlan, true);
-		if (ret < 0 && ret != -EAFNOSUPPORT)
-			ipv4 = false;
-	}
-#endif
-	if (ipv4)
-		ret = __vxlan_sock_add(vxlan, false);
-	if (ret < 0)
-		vxlan_sock_release(vxlan);
-	return ret;
-}
-
-static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
-				 struct net_device **lower,
-				 struct vxlan_dev *old,
-				 struct netlink_ext_ack *extack)
-{
-	struct vxlan_net *vn = net_generic(src_net, vxlan_net_id);
-	struct vxlan_dev *tmp;
-	bool use_ipv6 = false;
-
-	if (conf->flags & VXLAN_F_GPE) {
-		/* For now, allow GPE only together with
-		 * COLLECT_METADATA. This can be relaxed later; in such
-		 * case, the other side of the PtP link will have to be
-		 * provided.
-		 */
-		if ((conf->flags & ~VXLAN_F_ALLOWED_GPE) ||
-		    !(conf->flags & VXLAN_F_COLLECT_METADATA)) {
-			NL_SET_ERR_MSG(extack,
-				       "VXLAN GPE does not support this combination of attributes");
-			return -EINVAL;
-		}
-	}
-
-	if (!conf->remote_ip.sa.sa_family && !conf->saddr.sa.sa_family) {
-		/* Unless IPv6 is explicitly requested, assume IPv4 */
-		conf->remote_ip.sa.sa_family = AF_INET;
-		conf->saddr.sa.sa_family = AF_INET;
-	} else if (!conf->remote_ip.sa.sa_family) {
-		conf->remote_ip.sa.sa_family = conf->saddr.sa.sa_family;
-	} else if (!conf->saddr.sa.sa_family) {
-		conf->saddr.sa.sa_family = conf->remote_ip.sa.sa_family;
-	}
-
-	if (conf->saddr.sa.sa_family != conf->remote_ip.sa.sa_family) {
-		NL_SET_ERR_MSG(extack,
-			       "Local and remote address must be from the same family");
-		return -EINVAL;
-	}
-
-	if (vxlan_addr_multicast(&conf->saddr)) {
-		NL_SET_ERR_MSG(extack, "Local address cannot be multicast");
-		return -EINVAL;
-	}
-
-	if (conf->saddr.sa.sa_family == AF_INET6) {
-		if (!IS_ENABLED(CONFIG_IPV6)) {
-			NL_SET_ERR_MSG(extack,
-				       "IPv6 support not enabled in the kernel");
-			return -EPFNOSUPPORT;
-		}
-		use_ipv6 = true;
-		conf->flags |= VXLAN_F_IPV6;
-
-		if (!(conf->flags & VXLAN_F_COLLECT_METADATA)) {
-			int local_type =
-				ipv6_addr_type(&conf->saddr.sin6.sin6_addr);
-			int remote_type =
-				ipv6_addr_type(&conf->remote_ip.sin6.sin6_addr);
-
-			if (local_type & IPV6_ADDR_LINKLOCAL) {
-				if (!(remote_type & IPV6_ADDR_LINKLOCAL) &&
-				    (remote_type != IPV6_ADDR_ANY)) {
-					NL_SET_ERR_MSG(extack,
-						       "Invalid combination of local and remote address scopes");
-					return -EINVAL;
-				}
-
-				conf->flags |= VXLAN_F_IPV6_LINKLOCAL;
-			} else {
-				if (remote_type ==
-				    (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL)) {
-					NL_SET_ERR_MSG(extack,
-						       "Invalid combination of local and remote address scopes");
-					return -EINVAL;
-				}
-
-				conf->flags &= ~VXLAN_F_IPV6_LINKLOCAL;
-			}
-		}
-	}
-
-	if (conf->label && !use_ipv6) {
-		NL_SET_ERR_MSG(extack,
-			       "Label attribute only applies to IPv6 VXLAN devices");
-		return -EINVAL;
-	}
-
-	if (conf->remote_ifindex) {
-		struct net_device *lowerdev;
-
-		lowerdev = __dev_get_by_index(src_net, conf->remote_ifindex);
-		if (!lowerdev) {
-			NL_SET_ERR_MSG(extack,
-				       "Invalid local interface, device not found");
-			return -ENODEV;
-		}
-
-#if IS_ENABLED(CONFIG_IPV6)
-		if (use_ipv6) {
-			struct inet6_dev *idev = __in6_dev_get(lowerdev);
-			if (idev && idev->cnf.disable_ipv6) {
-				NL_SET_ERR_MSG(extack,
-					       "IPv6 support disabled by administrator");
-				return -EPERM;
-			}
-		}
-#endif
-
-		*lower = lowerdev;
-	} else {
-		if (vxlan_addr_multicast(&conf->remote_ip)) {
-			NL_SET_ERR_MSG(extack,
-				       "Local interface required for multicast remote destination");
-
-			return -EINVAL;
-		}
-
-#if IS_ENABLED(CONFIG_IPV6)
-		if (conf->flags & VXLAN_F_IPV6_LINKLOCAL) {
-			NL_SET_ERR_MSG(extack,
-				       "Local interface required for link-local local/remote addresses");
-			return -EINVAL;
-		}
-#endif
-
-		*lower = NULL;
-	}
-
-	if (!conf->dst_port) {
-		if (conf->flags & VXLAN_F_GPE)
-			conf->dst_port = htons(4790); /* IANA VXLAN-GPE port */
-		else
-			conf->dst_port = htons(vxlan_port);
-	}
-
-	if (!conf->age_interval)
-		conf->age_interval = FDB_AGE_DEFAULT;
-
-	list_for_each_entry(tmp, &vn->vxlan_list, next) {
-		if (tmp == old)
-			continue;
-
-		if (tmp->cfg.vni != conf->vni)
-			continue;
-		if (tmp->cfg.dst_port != conf->dst_port)
-			continue;
-		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
-		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
-			continue;
-
-		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
-		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
-			continue;
-
-		NL_SET_ERR_MSG(extack,
-			       "A VXLAN device with the specified VNI already exists");
-		return -EEXIST;
-	}
-
-	return 0;
-}
-
-static void vxlan_config_apply(struct net_device *dev,
-			       struct vxlan_config *conf,
-			       struct net_device *lowerdev,
-			       struct net *src_net,
-			       bool changelink)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	unsigned short needed_headroom = ETH_HLEN;
-	bool use_ipv6 = !!(conf->flags & VXLAN_F_IPV6);
-	int max_mtu = ETH_MAX_MTU;
-
-	if (!changelink) {
-		if (conf->flags & VXLAN_F_GPE)
-			vxlan_raw_setup(dev);
-		else
-			vxlan_ether_setup(dev);
-
-		if (conf->mtu)
-			dev->mtu = conf->mtu;
-
-		vxlan->net = src_net;
-	}
-
-	dst->remote_vni = conf->vni;
-
-	memcpy(&dst->remote_ip, &conf->remote_ip, sizeof(conf->remote_ip));
-
-	if (lowerdev) {
-		dst->remote_ifindex = conf->remote_ifindex;
-
-		dev->gso_max_size = lowerdev->gso_max_size;
-		dev->gso_max_segs = lowerdev->gso_max_segs;
-
-		needed_headroom = lowerdev->hard_header_len;
-		needed_headroom += lowerdev->needed_headroom;
-
-		dev->needed_tailroom = lowerdev->needed_tailroom;
-
-		max_mtu = lowerdev->mtu - (use_ipv6 ? VXLAN6_HEADROOM :
-					   VXLAN_HEADROOM);
-		if (max_mtu < ETH_MIN_MTU)
-			max_mtu = ETH_MIN_MTU;
-
-		if (!changelink && !conf->mtu)
-			dev->mtu = max_mtu;
-	}
-
-	if (dev->mtu > max_mtu)
-		dev->mtu = max_mtu;
-
-	if (use_ipv6 || conf->flags & VXLAN_F_COLLECT_METADATA)
-		needed_headroom += VXLAN6_HEADROOM;
-	else
-		needed_headroom += VXLAN_HEADROOM;
-	dev->needed_headroom = needed_headroom;
-
-	memcpy(&vxlan->cfg, conf, sizeof(*conf));
-}
-
-static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
-			       struct vxlan_config *conf, bool changelink,
-			       struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct net_device *lowerdev;
-	int ret;
-
-	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
-	if (ret)
-		return ret;
-
-	vxlan_config_apply(dev, conf, lowerdev, src_net, changelink);
-
-	return 0;
-}
-
-static int __vxlan_dev_create(struct net *net, struct net_device *dev,
-			      struct vxlan_config *conf,
-			      struct netlink_ext_ack *extack)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct net_device *remote_dev = NULL;
-	struct vxlan_fdb *f = NULL;
-	bool unregister = false;
-	struct vxlan_rdst *dst;
-	int err;
-
-	dst = &vxlan->default_dst;
-	err = vxlan_dev_configure(net, dev, conf, false, extack);
-	if (err)
-		return err;
-
-	dev->ethtool_ops = &vxlan_ethtool_ops;
-
-	/* create an fdb entry for a valid default destination */
-	if (!vxlan_addr_any(&dst->remote_ip)) {
-		err = vxlan_fdb_create(vxlan, all_zeros_mac,
-				       &dst->remote_ip,
-				       NUD_REACHABLE | NUD_PERMANENT,
-				       vxlan->cfg.dst_port,
-				       dst->remote_vni,
-				       dst->remote_vni,
-				       dst->remote_ifindex,
-				       NTF_SELF, 0, &f, extack);
-		if (err)
-			return err;
-	}
-
-	err = register_netdevice(dev);
-	if (err)
-		goto errout;
-	unregister = true;
-
-	if (dst->remote_ifindex) {
-		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
-		if (!remote_dev) {
-			err = -ENODEV;
-			goto errout;
-		}
-
-		err = netdev_upper_dev_link(remote_dev, dev, extack);
-		if (err)
-			goto errout;
-	}
-
-	err = rtnl_configure_link(dev, NULL);
-	if (err < 0)
-		goto unlink;
-
-	if (f) {
-		vxlan_fdb_insert(vxlan, all_zeros_mac, dst->remote_vni, f);
-
-		/* notify default fdb entry */
-		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
-				       RTM_NEWNEIGH, true, extack);
-		if (err) {
-			vxlan_fdb_destroy(vxlan, f, false, false);
-			if (remote_dev)
-				netdev_upper_dev_unlink(remote_dev, dev);
-			goto unregister;
-		}
-	}
-
-	list_add(&vxlan->next, &vn->vxlan_list);
-	if (remote_dev)
-		dst->remote_dev = remote_dev;
-	return 0;
-unlink:
-	if (remote_dev)
-		netdev_upper_dev_unlink(remote_dev, dev);
-errout:
-	/* unregister_netdevice() destroys the default FDB entry with deletion
-	 * notification. But the addition notification was not sent yet, so
-	 * destroy the entry by hand here.
-	 */
-	if (f)
-		__vxlan_fdb_free(f);
-unregister:
-	if (unregister)
-		unregister_netdevice(dev);
-	return err;
-}
-
-/* Set/clear flags based on attribute */
-static int vxlan_nl2flag(struct vxlan_config *conf, struct nlattr *tb[],
-			  int attrtype, unsigned long mask, bool changelink,
-			  bool changelink_supported,
-			  struct netlink_ext_ack *extack)
-{
-	unsigned long flags;
-
-	if (!tb[attrtype])
-		return 0;
-
-	if (changelink && !changelink_supported) {
-		vxlan_flag_attr_error(attrtype, extack);
-		return -EOPNOTSUPP;
-	}
-
-	if (vxlan_policy[attrtype].type == NLA_FLAG)
-		flags = conf->flags | mask;
-	else if (nla_get_u8(tb[attrtype]))
-		flags = conf->flags | mask;
-	else
-		flags = conf->flags & ~mask;
-
-	conf->flags = flags;
-
-	return 0;
-}
-
-static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
-			 struct net_device *dev, struct vxlan_config *conf,
-			 bool changelink, struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	int err = 0;
-
-	memset(conf, 0, sizeof(*conf));
-
-	/* if changelink operation, start with old existing cfg */
-	if (changelink)
-		memcpy(conf, &vxlan->cfg, sizeof(*conf));
-
-	if (data[IFLA_VXLAN_ID]) {
-		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
-
-		if (changelink && (vni != conf->vni)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
-			return -EOPNOTSUPP;
-		}
-		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
-	}
-
-	if (data[IFLA_VXLAN_GROUP]) {
-		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
-			return -EOPNOTSUPP;
-		}
-
-		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
-		conf->remote_ip.sa.sa_family = AF_INET;
-	} else if (data[IFLA_VXLAN_GROUP6]) {
-		if (!IS_ENABLED(CONFIG_IPV6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
-			return -EPFNOSUPPORT;
-		}
-
-		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "New group address family does not match old group");
-			return -EOPNOTSUPP;
-		}
-
-		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
-		conf->remote_ip.sa.sa_family = AF_INET6;
-	}
-
-	if (data[IFLA_VXLAN_LOCAL]) {
-		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
-			return -EOPNOTSUPP;
-		}
-
-		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
-		conf->saddr.sa.sa_family = AF_INET;
-	} else if (data[IFLA_VXLAN_LOCAL6]) {
-		if (!IS_ENABLED(CONFIG_IPV6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "IPv6 support not enabled in the kernel");
-			return -EPFNOSUPPORT;
-		}
-
-		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
-			return -EOPNOTSUPP;
-		}
-
-		/* TODO: respect scope id */
-		conf->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_LOCAL6]);
-		conf->saddr.sa.sa_family = AF_INET6;
-	}
-
-	if (data[IFLA_VXLAN_LINK])
-		conf->remote_ifindex = nla_get_u32(data[IFLA_VXLAN_LINK]);
-
-	if (data[IFLA_VXLAN_TOS])
-		conf->tos  = nla_get_u8(data[IFLA_VXLAN_TOS]);
-
-	if (data[IFLA_VXLAN_TTL])
-		conf->ttl = nla_get_u8(data[IFLA_VXLAN_TTL]);
-
-	if (data[IFLA_VXLAN_TTL_INHERIT]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_TTL_INHERIT,
-				    VXLAN_F_TTL_INHERIT, changelink, false,
-				    extack);
-		if (err)
-			return err;
-
-	}
-
-	if (data[IFLA_VXLAN_LABEL])
-		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
-			     IPV6_FLOWLABEL_MASK;
-
-	if (data[IFLA_VXLAN_LEARNING]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
-				    VXLAN_F_LEARN, changelink, true,
-				    extack);
-		if (err)
-			return err;
-	} else if (!changelink) {
-		/* default to learn on a new device */
-		conf->flags |= VXLAN_F_LEARN;
-	}
-
-	if (data[IFLA_VXLAN_AGEING])
-		conf->age_interval = nla_get_u32(data[IFLA_VXLAN_AGEING]);
-
-	if (data[IFLA_VXLAN_PROXY]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_PROXY,
-				    VXLAN_F_PROXY, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_RSC]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_RSC,
-				    VXLAN_F_RSC, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_L2MISS]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L2MISS,
-				    VXLAN_F_L2MISS, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_L3MISS]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L3MISS,
-				    VXLAN_F_L3MISS, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_LIMIT]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LIMIT],
-					    "Cannot change limit");
-			return -EOPNOTSUPP;
-		}
-		conf->addrmax = nla_get_u32(data[IFLA_VXLAN_LIMIT]);
-	}
-
-	if (data[IFLA_VXLAN_COLLECT_METADATA]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_COLLECT_METADATA,
-				    VXLAN_F_COLLECT_METADATA, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_PORT_RANGE]) {
-		if (!changelink) {
-			const struct ifla_vxlan_port_range *p
-				= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
-			conf->port_min = ntohs(p->low);
-			conf->port_max = ntohs(p->high);
-		} else {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT_RANGE],
-					    "Cannot change port range");
-			return -EOPNOTSUPP;
-		}
-	}
-
-	if (data[IFLA_VXLAN_PORT]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT],
-					    "Cannot change port");
-			return -EOPNOTSUPP;
-		}
-		conf->dst_port = nla_get_be16(data[IFLA_VXLAN_PORT]);
-	}
-
-	if (data[IFLA_VXLAN_UDP_CSUM]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_UDP_CSUM],
-					    "Cannot change UDP_CSUM flag");
-			return -EOPNOTSUPP;
-		}
-		if (!nla_get_u8(data[IFLA_VXLAN_UDP_CSUM]))
-			conf->flags |= VXLAN_F_UDP_ZERO_CSUM_TX;
-	}
-
-	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-				    VXLAN_F_UDP_ZERO_CSUM6_TX, changelink,
-				    false, extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-				    VXLAN_F_UDP_ZERO_CSUM6_RX, changelink,
-				    false, extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_REMCSUM_TX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_TX,
-				    VXLAN_F_REMCSUM_TX, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_REMCSUM_RX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_RX,
-				    VXLAN_F_REMCSUM_RX, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_GBP]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GBP,
-				    VXLAN_F_GBP, changelink, false, extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_GPE]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GPE,
-				    VXLAN_F_GPE, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
-				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
-				    false, extack);
-		if (err)
-			return err;
-	}
-
-	if (tb[IFLA_MTU]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
-					    "Cannot change mtu");
-			return -EOPNOTSUPP;
-		}
-		conf->mtu = nla_get_u32(tb[IFLA_MTU]);
-	}
-
-	if (data[IFLA_VXLAN_DF])
-		conf->df = nla_get_u8(data[IFLA_VXLAN_DF]);
-
-	return 0;
-}
-
-static int vxlan_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
-{
-	struct vxlan_config conf;
-	int err;
-
-	err = vxlan_nl2conf(tb, data, dev, &conf, false, extack);
-	if (err)
-		return err;
-
-	return __vxlan_dev_create(src_net, dev, &conf, extack);
-}
-
-static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
-			    struct nlattr *data[],
-			    struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct net_device *lowerdev;
-	struct vxlan_config conf;
-	struct vxlan_rdst *dst;
-	int err;
-
-	dst = &vxlan->default_dst;
-	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
-	if (err)
-		return err;
-
-	err = vxlan_config_validate(vxlan->net, &conf, &lowerdev,
-				    vxlan, extack);
-	if (err)
-		return err;
-
-	if (dst->remote_dev == lowerdev)
-		lowerdev = NULL;
-
-	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
-					     extack);
-	if (err)
-		return err;
-
-	/* handle default dst entry */
-	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
-		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
-
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
-		if (!vxlan_addr_any(&conf.remote_ip)) {
-			err = vxlan_fdb_update(vxlan, all_zeros_mac,
-					       &conf.remote_ip,
-					       NUD_REACHABLE | NUD_PERMANENT,
-					       NLM_F_APPEND | NLM_F_CREATE,
-					       vxlan->cfg.dst_port,
-					       conf.vni, conf.vni,
-					       conf.remote_ifindex,
-					       NTF_SELF, 0, true, extack);
-			if (err) {
-				spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-				netdev_adjacent_change_abort(dst->remote_dev,
-							     lowerdev, dev);
-				return err;
-			}
-		}
-		if (!vxlan_addr_any(&dst->remote_ip))
-			__vxlan_fdb_delete(vxlan, all_zeros_mac,
-					   dst->remote_ip,
-					   vxlan->cfg.dst_port,
-					   dst->remote_vni,
-					   dst->remote_vni,
-					   dst->remote_ifindex,
-					   true);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-	}
-
-	if (conf.age_interval != vxlan->cfg.age_interval)
-		mod_timer(&vxlan->age_timer, jiffies);
-
-	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
-	if (lowerdev && lowerdev != dst->remote_dev)
-		dst->remote_dev = lowerdev;
-	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
-	return 0;
-}
-
-static void vxlan_dellink(struct net_device *dev, struct list_head *head)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-
-	vxlan_flush(vxlan, true);
-
-	list_del(&vxlan->next);
-	unregister_netdevice_queue(dev, head);
-	if (vxlan->default_dst.remote_dev)
-		netdev_upper_dev_unlink(vxlan->default_dst.remote_dev, dev);
-}
-
-static size_t vxlan_get_size(const struct net_device *dev)
-{
-
-	return nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_ID */
-		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_GROUP{6} */
-		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LINK */
-		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_LOCAL{6} */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL_INHERIT */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
-		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L2MISS */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L3MISS */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_COLLECT_METADATA */
-		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_AGEING */
-		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LIMIT */
-		nla_total_size(sizeof(struct ifla_vxlan_port_range)) +
-		nla_total_size(sizeof(__be16)) + /* IFLA_VXLAN_PORT */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_CSUM */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_TX */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_RX */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
-		0;
-}
-
-static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
-{
-	const struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct ifla_vxlan_port_range ports = {
-		.low =  htons(vxlan->cfg.port_min),
-		.high = htons(vxlan->cfg.port_max),
-	};
-
-	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
-		goto nla_put_failure;
-
-	if (!vxlan_addr_any(&dst->remote_ip)) {
-		if (dst->remote_ip.sa.sa_family == AF_INET) {
-			if (nla_put_in_addr(skb, IFLA_VXLAN_GROUP,
-					    dst->remote_ip.sin.sin_addr.s_addr))
-				goto nla_put_failure;
-#if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			if (nla_put_in6_addr(skb, IFLA_VXLAN_GROUP6,
-					     &dst->remote_ip.sin6.sin6_addr))
-				goto nla_put_failure;
-#endif
-		}
-	}
-
-	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
-		goto nla_put_failure;
-
-	if (!vxlan_addr_any(&vxlan->cfg.saddr)) {
-		if (vxlan->cfg.saddr.sa.sa_family == AF_INET) {
-			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
-					    vxlan->cfg.saddr.sin.sin_addr.s_addr))
-				goto nla_put_failure;
-#if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
-					     &vxlan->cfg.saddr.sin6.sin6_addr))
-				goto nla_put_failure;
-#endif
-		}
-	}
-
-	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
-	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
-		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
-	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
-	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
-	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
-		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
-		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_RSC,
-		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
-		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
-	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
-	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
-	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
-	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
-		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)))
-		goto nla_put_failure;
-
-	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
-		goto nla_put_failure;
-
-	if (vxlan->cfg.flags & VXLAN_F_GBP &&
-	    nla_put_flag(skb, IFLA_VXLAN_GBP))
-		goto nla_put_failure;
-
-	if (vxlan->cfg.flags & VXLAN_F_GPE &&
-	    nla_put_flag(skb, IFLA_VXLAN_GPE))
-		goto nla_put_failure;
-
-	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_NOPARTIAL &&
-	    nla_put_flag(skb, IFLA_VXLAN_REMCSUM_NOPARTIAL))
-		goto nla_put_failure;
-
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-static struct net *vxlan_get_link_net(const struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-
-	return vxlan->net;
-}
-
-static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
-	.kind		= "vxlan",
-	.maxtype	= IFLA_VXLAN_MAX,
-	.policy		= vxlan_policy,
-	.priv_size	= sizeof(struct vxlan_dev),
-	.setup		= vxlan_setup,
-	.validate	= vxlan_validate,
-	.newlink	= vxlan_newlink,
-	.changelink	= vxlan_changelink,
-	.dellink	= vxlan_dellink,
-	.get_size	= vxlan_get_size,
-	.fill_info	= vxlan_fill_info,
-	.get_link_net	= vxlan_get_link_net,
-};
-
-struct net_device *vxlan_dev_create(struct net *net, const char *name,
-				    u8 name_assign_type,
-				    struct vxlan_config *conf)
-{
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	int err;
-
-	memset(&tb, 0, sizeof(tb));
-
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &vxlan_link_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	err = __vxlan_dev_create(net, dev, conf, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	err = rtnl_configure_link(dev, NULL);
-	if (err < 0) {
-		LIST_HEAD(list_kill);
-
-		vxlan_dellink(dev, &list_kill);
-		unregister_netdevice_many(&list_kill);
-		return ERR_PTR(err);
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL_GPL(vxlan_dev_create);
-
-static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
-					     struct net_device *dev)
-{
-	struct vxlan_dev *vxlan, *next;
-	LIST_HEAD(list_kill);
-
-	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		struct vxlan_rdst *dst = &vxlan->default_dst;
-
-		/* In case we created vxlan device with carrier
-		 * and we loose the carrier due to module unload
-		 * we also need to remove vxlan device. In other
-		 * cases, it's not necessary and remote_ifindex
-		 * is 0 here, so no matches.
-		 */
-		if (dst->remote_ifindex == dev->ifindex)
-			vxlan_dellink(vxlan->dev, &list_kill);
-	}
-
-	unregister_netdevice_many(&list_kill);
-}
-
-static int vxlan_netdevice_event(struct notifier_block *unused,
-				 unsigned long event, void *ptr)
-{
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct vxlan_net *vn = net_generic(dev_net(dev), vxlan_net_id);
-
-	if (event == NETDEV_UNREGISTER) {
-		if (!dev->udp_tunnel_nic_info)
-			vxlan_offload_rx_ports(dev, false);
-		vxlan_handle_lowerdev_unregister(vn, dev);
-	} else if (event == NETDEV_REGISTER) {
-		if (!dev->udp_tunnel_nic_info)
-			vxlan_offload_rx_ports(dev, true);
-	} else if (event == NETDEV_UDP_TUNNEL_PUSH_INFO ||
-		   event == NETDEV_UDP_TUNNEL_DROP_INFO) {
-		vxlan_offload_rx_ports(dev, event == NETDEV_UDP_TUNNEL_PUSH_INFO);
-	}
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block vxlan_notifier_block __read_mostly = {
-	.notifier_call = vxlan_netdevice_event,
-};
-
-static void
-vxlan_fdb_offloaded_set(struct net_device *dev,
-			struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	u32 hash_index;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	if (!f)
-		goto out;
-
-	rdst = vxlan_fdb_find_rdst(f, &fdb_info->remote_ip,
-				   fdb_info->remote_port,
-				   fdb_info->remote_vni,
-				   fdb_info->remote_ifindex);
-	if (!rdst)
-		goto out;
-
-	rdst->offloaded = fdb_info->offloaded;
-
-out:
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-}
-
-static int
-vxlan_fdb_external_learn_add(struct net_device *dev,
-			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct netlink_ext_ack *extack;
-	u32 hash_index;
-	int err;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	extack = switchdev_notifier_info_to_extack(&fdb_info->info);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	err = vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
-			       NUD_REACHABLE,
-			       NLM_F_CREATE | NLM_F_REPLACE,
-			       fdb_info->remote_port,
-			       fdb_info->vni,
-			       fdb_info->remote_vni,
-			       fdb_info->remote_ifindex,
-			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
-			       0, false, extack);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-static int
-vxlan_fdb_external_learn_del(struct net_device *dev,
-			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb *f;
-	u32 hash_index;
-	int err = 0;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	if (!f)
-		err = -ENOENT;
-	else if (f->flags & NTF_EXT_LEARNED)
-		err = __vxlan_fdb_delete(vxlan, fdb_info->eth_addr,
-					 fdb_info->remote_ip,
-					 fdb_info->remote_port,
-					 fdb_info->vni,
-					 fdb_info->remote_vni,
-					 fdb_info->remote_ifindex,
-					 false);
-
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-static int vxlan_switchdev_event(struct notifier_block *unused,
-				 unsigned long event, void *ptr)
-{
-	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
-	struct switchdev_notifier_vxlan_fdb_info *fdb_info;
-	int err = 0;
-
-	switch (event) {
-	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
-		vxlan_fdb_offloaded_set(dev, ptr);
-		break;
-	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
-		fdb_info = ptr;
-		err = vxlan_fdb_external_learn_add(dev, fdb_info);
-		if (err) {
-			err = notifier_from_errno(err);
-			break;
-		}
-		fdb_info->offloaded = true;
-		vxlan_fdb_offloaded_set(dev, fdb_info);
-		break;
-	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
-		fdb_info = ptr;
-		err = vxlan_fdb_external_learn_del(dev, fdb_info);
-		if (err) {
-			err = notifier_from_errno(err);
-			break;
-		}
-		fdb_info->offloaded = false;
-		vxlan_fdb_offloaded_set(dev, fdb_info);
-		break;
-	}
-
-	return err;
-}
-
-static struct notifier_block vxlan_switchdev_notifier_block __read_mostly = {
-	.notifier_call = vxlan_switchdev_event,
-};
-
-static void vxlan_fdb_nh_flush(struct nexthop *nh)
-{
-	struct vxlan_fdb *fdb;
-	struct vxlan_dev *vxlan;
-	u32 hash_index;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(fdb, &nh->fdb_list, nh_list) {
-		vxlan = rcu_dereference(fdb->vdev);
-		WARN_ON(!vxlan);
-		hash_index = fdb_head_index(vxlan, fdb->eth_addr,
-					    vxlan->default_dst.remote_vni);
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
-		if (!hlist_unhashed(&fdb->hlist))
-			vxlan_fdb_destroy(vxlan, fdb, false, false);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-	}
-	rcu_read_unlock();
-}
-
-static int vxlan_nexthop_event(struct notifier_block *nb,
-			       unsigned long event, void *ptr)
-{
-	struct nexthop *nh = ptr;
-
-	if (!nh || event != NEXTHOP_EVENT_DEL)
-		return NOTIFY_DONE;
-
-	vxlan_fdb_nh_flush(nh);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block vxlan_nexthop_notifier_block __read_mostly = {
-	.notifier_call = vxlan_nexthop_event,
-};
-
-static __net_init int vxlan_init_net(struct net *net)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	unsigned int h;
-
-	INIT_LIST_HEAD(&vn->vxlan_list);
-	spin_lock_init(&vn->sock_lock);
-
-	for (h = 0; h < PORT_HASH_SIZE; ++h)
-		INIT_HLIST_HEAD(&vn->sock_list[h]);
-
-	return register_nexthop_notifier(net, &vxlan_nexthop_notifier_block);
-}
-
-static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	struct vxlan_dev *vxlan, *next;
-	struct net_device *dev, *aux;
-
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &vxlan_link_ops)
-			unregister_netdevice_queue(dev, head);
-
-	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		/* If vxlan->dev is in the same netns, it has already been added
-		 * to the list by the previous loop.
-		 */
-		if (!net_eq(dev_net(vxlan->dev), net))
-			unregister_netdevice_queue(vxlan->dev, head);
-	}
-
-}
-
-static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
-{
-	struct net *net;
-	LIST_HEAD(list);
-	unsigned int h;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		unregister_nexthop_notifier(net, &vxlan_nexthop_notifier_block);
-	list_for_each_entry(net, net_list, exit_list)
-		vxlan_destroy_tunnels(net, &list);
-
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
-
-	list_for_each_entry(net, net_list, exit_list) {
-		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-
-		for (h = 0; h < PORT_HASH_SIZE; ++h)
-			WARN_ON_ONCE(!hlist_empty(&vn->sock_list[h]));
-	}
-}
-
-static struct pernet_operations vxlan_net_ops = {
-	.init = vxlan_init_net,
-	.exit_batch = vxlan_exit_batch_net,
-	.id   = &vxlan_net_id,
-	.size = sizeof(struct vxlan_net),
-};
-
-static int __init vxlan_init_module(void)
-{
-	int rc;
-
-	get_random_bytes(&vxlan_salt, sizeof(vxlan_salt));
-
-	rc = register_pernet_subsys(&vxlan_net_ops);
-	if (rc)
-		goto out1;
-
-	rc = register_netdevice_notifier(&vxlan_notifier_block);
-	if (rc)
-		goto out2;
-
-	rc = register_switchdev_notifier(&vxlan_switchdev_notifier_block);
-	if (rc)
-		goto out3;
-
-	rc = rtnl_link_register(&vxlan_link_ops);
-	if (rc)
-		goto out4;
-
-	return 0;
-out4:
-	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
-out3:
-	unregister_netdevice_notifier(&vxlan_notifier_block);
-out2:
-	unregister_pernet_subsys(&vxlan_net_ops);
-out1:
-	return rc;
-}
-late_initcall(vxlan_init_module);
-
-static void __exit vxlan_cleanup_module(void)
-{
-	rtnl_link_unregister(&vxlan_link_ops);
-	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
-	unregister_netdevice_notifier(&vxlan_notifier_block);
-	unregister_pernet_subsys(&vxlan_net_ops);
-	/* rcu_barrier() is called by netns */
-}
-module_exit(vxlan_cleanup_module);
-
-MODULE_LICENSE("GPL");
-MODULE_VERSION(VXLAN_VERSION);
-MODULE_AUTHOR("Stephen Hemminger <stephen@networkplumber.org>");
-MODULE_DESCRIPTION("Driver for VXLAN encapsulated traffic");
-MODULE_ALIAS_RTNL_LINK("vxlan");
diff --git a/drivers/net/vxlan/Makefile b/drivers/net/vxlan/Makefile
new file mode 100644
index 000000000000..567266133593
--- /dev/null
+++ b/drivers/net/vxlan/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the vxlan driver
+#
+
+obj-$(CONFIG_VXLAN) += vxlan.o
+
+vxlan-objs := vxlan_core.o
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
new file mode 100644
index 000000000000..1ac9de69bde6
--- /dev/null
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -0,0 +1,4826 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VXLAN: Virtual eXtensible Local Area Network
+ *
+ * Copyright (c) 2012-2013 Vyatta Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/udp.h>
+#include <linux/igmp.h>
+#include <linux/if_ether.h>
+#include <linux/ethtool.h>
+#include <net/arp.h>
+#include <net/ndisc.h>
+#include <net/ipv6_stubs.h>
+#include <net/ip.h>
+#include <net/icmp.h>
+#include <net/rtnetlink.h>
+#include <net/inet_ecn.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <net/tun_proto.h>
+#include <net/vxlan.h>
+#include <net/nexthop.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ip6_tunnel.h>
+#include <net/ip6_checksum.h>
+#endif
+
+#define VXLAN_VERSION	"0.1"
+
+#define PORT_HASH_BITS	8
+#define PORT_HASH_SIZE  (1<<PORT_HASH_BITS)
+#define FDB_AGE_DEFAULT 300 /* 5 min */
+#define FDB_AGE_INTERVAL (10 * HZ)	/* rescan interval */
+
+/* UDP port for VXLAN traffic.
+ * The IANA assigned port is 4789, but the Linux default is 8472
+ * for compatibility with early adopters.
+ */
+static unsigned short vxlan_port __read_mostly = 8472;
+module_param_named(udp_port, vxlan_port, ushort, 0444);
+MODULE_PARM_DESC(udp_port, "Destination UDP port");
+
+static bool log_ecn_error = true;
+module_param(log_ecn_error, bool, 0644);
+MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
+
+static unsigned int vxlan_net_id;
+static struct rtnl_link_ops vxlan_link_ops;
+
+static const u8 all_zeros_mac[ETH_ALEN + 2];
+
+static int vxlan_sock_add(struct vxlan_dev *vxlan);
+
+static void vxlan_vs_del_dev(struct vxlan_dev *vxlan);
+
+/* per-network namespace private data for this module */
+struct vxlan_net {
+	struct list_head  vxlan_list;
+	struct hlist_head sock_list[PORT_HASH_SIZE];
+	spinlock_t	  sock_lock;
+};
+
+/* Forwarding table entry */
+struct vxlan_fdb {
+	struct hlist_node hlist;	/* linked list of entries */
+	struct rcu_head	  rcu;
+	unsigned long	  updated;	/* jiffies */
+	unsigned long	  used;
+	struct list_head  remotes;
+	u8		  eth_addr[ETH_ALEN];
+	u16		  state;	/* see ndm_state */
+	__be32		  vni;
+	u16		  flags;	/* see ndm_flags and below */
+	struct list_head  nh_list;
+	struct nexthop __rcu *nh;
+	struct vxlan_dev  __rcu *vdev;
+};
+
+#define NTF_VXLAN_ADDED_BY_USER 0x100
+
+/* salt for hash table */
+static u32 vxlan_salt __read_mostly;
+
+static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
+{
+	return vs->flags & VXLAN_F_COLLECT_METADATA ||
+	       ip_tunnel_collect_metadata();
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static inline
+bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
+{
+	if (a->sa.sa_family != b->sa.sa_family)
+		return false;
+	if (a->sa.sa_family == AF_INET6)
+		return ipv6_addr_equal(&a->sin6.sin6_addr, &b->sin6.sin6_addr);
+	else
+		return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
+}
+
+static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
+{
+	if (nla_len(nla) >= sizeof(struct in6_addr)) {
+		ip->sin6.sin6_addr = nla_get_in6_addr(nla);
+		ip->sa.sa_family = AF_INET6;
+		return 0;
+	} else if (nla_len(nla) >= sizeof(__be32)) {
+		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
+		ip->sa.sa_family = AF_INET;
+		return 0;
+	} else {
+		return -EAFNOSUPPORT;
+	}
+}
+
+static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
+			      const union vxlan_addr *ip)
+{
+	if (ip->sa.sa_family == AF_INET6)
+		return nla_put_in6_addr(skb, attr, &ip->sin6.sin6_addr);
+	else
+		return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
+}
+
+#else /* !CONFIG_IPV6 */
+
+static inline
+bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
+{
+	return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
+}
+
+static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
+{
+	if (nla_len(nla) >= sizeof(struct in6_addr)) {
+		return -EAFNOSUPPORT;
+	} else if (nla_len(nla) >= sizeof(__be32)) {
+		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
+		ip->sa.sa_family = AF_INET;
+		return 0;
+	} else {
+		return -EAFNOSUPPORT;
+	}
+}
+
+static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
+			      const union vxlan_addr *ip)
+{
+	return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
+}
+#endif
+
+/* Virtual Network hash table head */
+static inline struct hlist_head *vni_head(struct vxlan_sock *vs, __be32 vni)
+{
+	return &vs->vni_list[hash_32((__force u32)vni, VNI_HASH_BITS)];
+}
+
+/* Socket hash table head */
+static inline struct hlist_head *vs_head(struct net *net, __be16 port)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+
+	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
+}
+
+/* First remote destination for a forwarding entry.
+ * Guaranteed to be non-NULL because remotes are never deleted.
+ */
+static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
+{
+	if (rcu_access_pointer(fdb->nh))
+		return NULL;
+	return list_entry_rcu(fdb->remotes.next, struct vxlan_rdst, list);
+}
+
+static inline struct vxlan_rdst *first_remote_rtnl(struct vxlan_fdb *fdb)
+{
+	if (rcu_access_pointer(fdb->nh))
+		return NULL;
+	return list_first_entry(&fdb->remotes, struct vxlan_rdst, list);
+}
+
+/* Find VXLAN socket based on network namespace, address family, UDP port,
+ * enabled unshareable flags and socket device binding (see l3mdev with
+ * non-default VRF).
+ */
+static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
+					  __be16 port, u32 flags, int ifindex)
+{
+	struct vxlan_sock *vs;
+
+	flags &= VXLAN_F_RCV_FLAGS;
+
+	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
+		if (inet_sk(vs->sock->sk)->inet_sport == port &&
+		    vxlan_get_sk_family(vs) == family &&
+		    vs->flags == flags &&
+		    vs->sock->sk->sk_bound_dev_if == ifindex)
+			return vs;
+	}
+	return NULL;
+}
+
+static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs, int ifindex,
+					   __be32 vni)
+{
+	struct vxlan_dev_node *node;
+
+	/* For flow based devices, map all packets to VNI 0 */
+	if (vs->flags & VXLAN_F_COLLECT_METADATA)
+		vni = 0;
+
+	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
+		if (node->vxlan->default_dst.remote_vni != vni)
+			continue;
+
+		if (IS_ENABLED(CONFIG_IPV6)) {
+			const struct vxlan_config *cfg = &node->vxlan->cfg;
+
+			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
+			    cfg->remote_ifindex != ifindex)
+				continue;
+		}
+
+		return node->vxlan;
+	}
+
+	return NULL;
+}
+
+/* Look up VNI in a per net namespace table */
+static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
+					__be32 vni, sa_family_t family,
+					__be16 port, u32 flags)
+{
+	struct vxlan_sock *vs;
+
+	vs = vxlan_find_sock(net, family, port, flags, ifindex);
+	if (!vs)
+		return NULL;
+
+	return vxlan_vs_find_vni(vs, ifindex, vni);
+}
+
+/* Fill in neighbour message in skbuff. */
+static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
+			  const struct vxlan_fdb *fdb,
+			  u32 portid, u32 seq, int type, unsigned int flags,
+			  const struct vxlan_rdst *rdst)
+{
+	unsigned long now = jiffies;
+	struct nda_cacheinfo ci;
+	bool send_ip, send_eth;
+	struct nlmsghdr *nlh;
+	struct nexthop *nh;
+	struct ndmsg *ndm;
+	int nh_family;
+	u32 nh_id;
+
+	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
+	if (nlh == NULL)
+		return -EMSGSIZE;
+
+	ndm = nlmsg_data(nlh);
+	memset(ndm, 0, sizeof(*ndm));
+
+	send_eth = send_ip = true;
+
+	rcu_read_lock();
+	nh = rcu_dereference(fdb->nh);
+	if (nh) {
+		nh_family = nexthop_get_family(nh);
+		nh_id = nh->id;
+	}
+	rcu_read_unlock();
+
+	if (type == RTM_GETNEIGH) {
+		if (rdst) {
+			send_ip = !vxlan_addr_any(&rdst->remote_ip);
+			ndm->ndm_family = send_ip ? rdst->remote_ip.sa.sa_family : AF_INET;
+		} else if (nh) {
+			ndm->ndm_family = nh_family;
+		}
+		send_eth = !is_zero_ether_addr(fdb->eth_addr);
+	} else
+		ndm->ndm_family	= AF_BRIDGE;
+	ndm->ndm_state = fdb->state;
+	ndm->ndm_ifindex = vxlan->dev->ifindex;
+	ndm->ndm_flags = fdb->flags;
+	if (rdst && rdst->offloaded)
+		ndm->ndm_flags |= NTF_OFFLOADED;
+	ndm->ndm_type = RTN_UNICAST;
+
+	if (!net_eq(dev_net(vxlan->dev), vxlan->net) &&
+	    nla_put_s32(skb, NDA_LINK_NETNSID,
+			peernet2id(dev_net(vxlan->dev), vxlan->net)))
+		goto nla_put_failure;
+
+	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->eth_addr))
+		goto nla_put_failure;
+	if (nh) {
+		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
+			goto nla_put_failure;
+	} else if (rdst) {
+		if (send_ip && vxlan_nla_put_addr(skb, NDA_DST,
+						  &rdst->remote_ip))
+			goto nla_put_failure;
+
+		if (rdst->remote_port &&
+		    rdst->remote_port != vxlan->cfg.dst_port &&
+		    nla_put_be16(skb, NDA_PORT, rdst->remote_port))
+			goto nla_put_failure;
+		if (rdst->remote_vni != vxlan->default_dst.remote_vni &&
+		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
+			goto nla_put_failure;
+		if (rdst->remote_ifindex &&
+		    nla_put_u32(skb, NDA_IFINDEX, rdst->remote_ifindex))
+			goto nla_put_failure;
+	}
+
+	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->vni &&
+	    nla_put_u32(skb, NDA_SRC_VNI,
+			be32_to_cpu(fdb->vni)))
+		goto nla_put_failure;
+
+	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_confirmed = 0;
+	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_refcnt	 = 0;
+
+	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
+		goto nla_put_failure;
+
+	nlmsg_end(skb, nlh);
+	return 0;
+
+nla_put_failure:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
+static inline size_t vxlan_nlmsg_size(void)
+{
+	return NLMSG_ALIGN(sizeof(struct ndmsg))
+		+ nla_total_size(ETH_ALEN) /* NDA_LLADDR */
+		+ nla_total_size(sizeof(struct in6_addr)) /* NDA_DST */
+		+ nla_total_size(sizeof(__be16)) /* NDA_PORT */
+		+ nla_total_size(sizeof(__be32)) /* NDA_VNI */
+		+ nla_total_size(sizeof(__u32)) /* NDA_IFINDEX */
+		+ nla_total_size(sizeof(__s32)) /* NDA_LINK_NETNSID */
+		+ nla_total_size(sizeof(struct nda_cacheinfo));
+}
+
+static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
+			       struct vxlan_rdst *rd, int type)
+{
+	struct net *net = dev_net(vxlan->dev);
+	struct sk_buff *skb;
+	int err = -ENOBUFS;
+
+	skb = nlmsg_new(vxlan_nlmsg_size(), GFP_ATOMIC);
+	if (skb == NULL)
+		goto errout;
+
+	err = vxlan_fdb_info(skb, vxlan, fdb, 0, 0, type, 0, rd);
+	if (err < 0) {
+		/* -EMSGSIZE implies BUG in vxlan_nlmsg_size() */
+		WARN_ON(err == -EMSGSIZE);
+		kfree_skb(skb);
+		goto errout;
+	}
+
+	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
+	return;
+errout:
+	if (err < 0)
+		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+}
+
+static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
+			    const struct vxlan_fdb *fdb,
+			    const struct vxlan_rdst *rd,
+			    struct netlink_ext_ack *extack,
+			    struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	fdb_info->info.dev = vxlan->dev;
+	fdb_info->info.extack = extack;
+	fdb_info->remote_ip = rd->remote_ip;
+	fdb_info->remote_port = rd->remote_port;
+	fdb_info->remote_vni = rd->remote_vni;
+	fdb_info->remote_ifindex = rd->remote_ifindex;
+	memcpy(fdb_info->eth_addr, fdb->eth_addr, ETH_ALEN);
+	fdb_info->vni = fdb->vni;
+	fdb_info->offloaded = rd->offloaded;
+	fdb_info->added_by_user = fdb->flags & NTF_VXLAN_ADDED_BY_USER;
+}
+
+static int vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
+					      struct vxlan_fdb *fdb,
+					      struct vxlan_rdst *rd,
+					      bool adding,
+					      struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_vxlan_fdb_info info;
+	enum switchdev_notifier_type notifier_type;
+	int ret;
+
+	if (WARN_ON(!rd))
+		return 0;
+
+	notifier_type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE
+			       : SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE;
+	vxlan_fdb_switchdev_notifier_info(vxlan, fdb, rd, NULL, &info);
+	ret = call_switchdev_notifiers(notifier_type, vxlan->dev,
+				       &info.info, extack);
+	return notifier_to_errno(ret);
+}
+
+static int vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
+			    struct vxlan_rdst *rd, int type, bool swdev_notify,
+			    struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (swdev_notify && rd) {
+		switch (type) {
+		case RTM_NEWNEIGH:
+			err = vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
+								 true, extack);
+			if (err)
+				return err;
+			break;
+		case RTM_DELNEIGH:
+			vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
+							   false, extack);
+			break;
+		}
+	}
+
+	__vxlan_fdb_notify(vxlan, fdb, rd, type);
+	return 0;
+}
+
+static void vxlan_ip_miss(struct net_device *dev, union vxlan_addr *ipa)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb f = {
+		.state = NUD_STALE,
+	};
+	struct vxlan_rdst remote = {
+		.remote_ip = *ipa, /* goes to NDA_DST */
+		.remote_vni = cpu_to_be32(VXLAN_N_VID),
+	};
+
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
+}
+
+static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
+{
+	struct vxlan_fdb f = {
+		.state = NUD_STALE,
+	};
+	struct vxlan_rdst remote = { };
+
+	memcpy(f.eth_addr, eth_addr, ETH_ALEN);
+
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
+}
+
+/* Hash Ethernet address */
+static u32 eth_hash(const unsigned char *addr)
+{
+	u64 value = get_unaligned((u64 *)addr);
+
+	/* only want 6 bytes */
+#ifdef __BIG_ENDIAN
+	value >>= 16;
+#else
+	value <<= 16;
+#endif
+	return hash_64(value, FDB_HASH_BITS);
+}
+
+static u32 eth_vni_hash(const unsigned char *addr, __be32 vni)
+{
+	/* use 1 byte of OUI and 3 bytes of NIC */
+	u32 key = get_unaligned((u32 *)(addr + 2));
+
+	return jhash_2words(key, vni, vxlan_salt) & (FDB_HASH_SIZE - 1);
+}
+
+static u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni)
+{
+	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)
+		return eth_vni_hash(mac, vni);
+	else
+		return eth_hash(mac);
+}
+
+/* Hash chain to use given mac address */
+static inline struct hlist_head *vxlan_fdb_head(struct vxlan_dev *vxlan,
+						const u8 *mac, __be32 vni)
+{
+	return &vxlan->fdb_head[fdb_head_index(vxlan, mac, vni)];
+}
+
+/* Look up Ethernet address in forwarding table */
+static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
+					  const u8 *mac, __be32 vni)
+{
+	struct hlist_head *head = vxlan_fdb_head(vxlan, mac, vni);
+	struct vxlan_fdb *f;
+
+	hlist_for_each_entry_rcu(f, head, hlist) {
+		if (ether_addr_equal(mac, f->eth_addr)) {
+			if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
+				if (vni == f->vni)
+					return f;
+			} else {
+				return f;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
+					const u8 *mac, __be32 vni)
+{
+	struct vxlan_fdb *f;
+
+	f = __vxlan_find_mac(vxlan, mac, vni);
+	if (f && f->used != jiffies)
+		f->used = jiffies;
+
+	return f;
+}
+
+/* caller should hold vxlan->hash_lock */
+static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
+					      union vxlan_addr *ip, __be16 port,
+					      __be32 vni, __u32 ifindex)
+{
+	struct vxlan_rdst *rd;
+
+	list_for_each_entry(rd, &f->remotes, list) {
+		if (vxlan_addr_equal(&rd->remote_ip, ip) &&
+		    rd->remote_port == port &&
+		    rd->remote_vni == vni &&
+		    rd->remote_ifindex == ifindex)
+			return rd;
+	}
+
+	return NULL;
+}
+
+int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
+		      struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	u8 eth_addr[ETH_ALEN + 2] = { 0 };
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	int rc = 0;
+
+	if (is_multicast_ether_addr(mac) ||
+	    is_zero_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(eth_addr, mac);
+
+	rcu_read_lock();
+
+	f = __vxlan_find_mac(vxlan, eth_addr, vni);
+	if (!f) {
+		rc = -ENOENT;
+		goto out;
+	}
+
+	rdst = first_remote_rcu(f);
+	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
+
+out:
+	rcu_read_unlock();
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_find_uc);
+
+static int vxlan_fdb_notify_one(struct notifier_block *nb,
+				const struct vxlan_dev *vxlan,
+				const struct vxlan_fdb *f,
+				const struct vxlan_rdst *rdst,
+				struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_vxlan_fdb_info fdb_info;
+	int rc;
+
+	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, extack, &fdb_info);
+	rc = nb->notifier_call(nb, SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
+			       &fdb_info);
+	return notifier_to_errno(rc);
+}
+
+int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
+		     struct notifier_block *nb,
+		     struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	unsigned int h;
+	int rc = 0;
+
+	if (!netif_is_vxlan(dev))
+		return -EINVAL;
+	vxlan = netdev_priv(dev);
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		spin_lock_bh(&vxlan->hash_lock[h]);
+		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
+			if (f->vni == vni) {
+				list_for_each_entry(rdst, &f->remotes, list) {
+					rc = vxlan_fdb_notify_one(nb, vxlan,
+								  f, rdst,
+								  extack);
+					if (rc)
+						goto unlock;
+				}
+			}
+		}
+		spin_unlock_bh(&vxlan->hash_lock[h]);
+	}
+	return 0;
+
+unlock:
+	spin_unlock_bh(&vxlan->hash_lock[h]);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
+
+void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	unsigned int h;
+
+	if (!netif_is_vxlan(dev))
+		return;
+	vxlan = netdev_priv(dev);
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		spin_lock_bh(&vxlan->hash_lock[h]);
+		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
+			if (f->vni == vni)
+				list_for_each_entry(rdst, &f->remotes, list)
+					rdst->offloaded = false;
+		spin_unlock_bh(&vxlan->hash_lock[h]);
+	}
+
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_clear_offload);
+
+/* Replace destination of unicast mac */
+static int vxlan_fdb_replace(struct vxlan_fdb *f,
+			     union vxlan_addr *ip, __be16 port, __be32 vni,
+			     __u32 ifindex, struct vxlan_rdst *oldrd)
+{
+	struct vxlan_rdst *rd;
+
+	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
+	if (rd)
+		return 0;
+
+	rd = list_first_entry_or_null(&f->remotes, struct vxlan_rdst, list);
+	if (!rd)
+		return 0;
+
+	*oldrd = *rd;
+	dst_cache_reset(&rd->dst_cache);
+	rd->remote_ip = *ip;
+	rd->remote_port = port;
+	rd->remote_vni = vni;
+	rd->remote_ifindex = ifindex;
+	rd->offloaded = false;
+	return 1;
+}
+
+/* Add/update destinations for multicast */
+static int vxlan_fdb_append(struct vxlan_fdb *f,
+			    union vxlan_addr *ip, __be16 port, __be32 vni,
+			    __u32 ifindex, struct vxlan_rdst **rdp)
+{
+	struct vxlan_rdst *rd;
+
+	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
+	if (rd)
+		return 0;
+
+	rd = kmalloc(sizeof(*rd), GFP_ATOMIC);
+	if (rd == NULL)
+		return -ENOMEM;
+
+	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
+		kfree(rd);
+		return -ENOMEM;
+	}
+
+	rd->remote_ip = *ip;
+	rd->remote_port = port;
+	rd->offloaded = false;
+	rd->remote_vni = vni;
+	rd->remote_ifindex = ifindex;
+
+	list_add_tail_rcu(&rd->list, &f->remotes);
+
+	*rdp = rd;
+	return 1;
+}
+
+static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
+					  unsigned int off,
+					  struct vxlanhdr *vh, size_t hdrlen,
+					  __be32 vni_field,
+					  struct gro_remcsum *grc,
+					  bool nopartial)
+{
+	size_t start, offset;
+
+	if (skb->remcsum_offload)
+		return vh;
+
+	if (!NAPI_GRO_CB(skb)->csum_valid)
+		return NULL;
+
+	start = vxlan_rco_start(vni_field);
+	offset = start + vxlan_rco_offset(vni_field);
+
+	vh = skb_gro_remcsum_process(skb, (void *)vh, off, hdrlen,
+				     start, offset, grc, nopartial);
+
+	skb->remcsum_offload = 1;
+
+	return vh;
+}
+
+static struct sk_buff *vxlan_gro_receive(struct sock *sk,
+					 struct list_head *head,
+					 struct sk_buff *skb)
+{
+	struct sk_buff *pp = NULL;
+	struct sk_buff *p;
+	struct vxlanhdr *vh, *vh2;
+	unsigned int hlen, off_vx;
+	int flush = 1;
+	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
+	__be32 flags;
+	struct gro_remcsum grc;
+
+	skb_gro_remcsum_init(&grc);
+
+	off_vx = skb_gro_offset(skb);
+	hlen = off_vx + sizeof(*vh);
+	vh   = skb_gro_header_fast(skb, off_vx);
+	if (skb_gro_header_hard(skb, hlen)) {
+		vh = skb_gro_header_slow(skb, hlen, off_vx);
+		if (unlikely(!vh))
+			goto out;
+	}
+
+	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
+
+	flags = vh->vx_flags;
+
+	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
+		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
+				       vh->vx_vni, &grc,
+				       !!(vs->flags &
+					  VXLAN_F_REMCSUM_NOPARTIAL));
+
+		if (!vh)
+			goto out;
+	}
+
+	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		vh2 = (struct vxlanhdr *)(p->data + off_vx);
+		if (vh->vx_flags != vh2->vx_flags ||
+		    vh->vx_vni != vh2->vx_vni) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+	}
+
+	pp = call_gro_receive(eth_gro_receive, head, skb);
+	flush = 0;
+
+out:
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
+
+	return pp;
+}
+
+static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+{
+	/* Sets 'skb->inner_mac_header' since we are always called with
+	 * 'skb->encapsulation' set.
+	 */
+	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+}
+
+static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
+					 __u16 state, __be32 src_vni,
+					 __u16 ndm_flags)
+{
+	struct vxlan_fdb *f;
+
+	f = kmalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+	f->state = state;
+	f->flags = ndm_flags;
+	f->updated = f->used = jiffies;
+	f->vni = src_vni;
+	f->nh = NULL;
+	RCU_INIT_POINTER(f->vdev, vxlan);
+	INIT_LIST_HEAD(&f->nh_list);
+	INIT_LIST_HEAD(&f->remotes);
+	memcpy(f->eth_addr, mac, ETH_ALEN);
+
+	return f;
+}
+
+static void vxlan_fdb_insert(struct vxlan_dev *vxlan, const u8 *mac,
+			     __be32 src_vni, struct vxlan_fdb *f)
+{
+	++vxlan->addrcnt;
+	hlist_add_head_rcu(&f->hlist,
+			   vxlan_fdb_head(vxlan, mac, src_vni));
+}
+
+static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
+			       u32 nhid, struct netlink_ext_ack *extack)
+{
+	struct nexthop *old_nh = rtnl_dereference(fdb->nh);
+	struct nexthop *nh;
+	int err = -EINVAL;
+
+	if (old_nh && old_nh->id == nhid)
+		return 0;
+
+	nh = nexthop_find_by_id(vxlan->net, nhid);
+	if (!nh) {
+		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
+		goto err_inval;
+	}
+
+	if (nh) {
+		if (!nexthop_get(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			nh = NULL;
+			goto err_inval;
+		}
+		if (!nexthop_is_fdb(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop is not a fdb nexthop");
+			goto err_inval;
+		}
+
+		if (!nexthop_is_multipath(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop is not a multipath group");
+			goto err_inval;
+		}
+
+		/* check nexthop group family */
+		switch (vxlan->default_dst.remote_ip.sa.sa_family) {
+		case AF_INET:
+			if (!nexthop_has_v4(nh)) {
+				err = -EAFNOSUPPORT;
+				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
+				goto err_inval;
+			}
+			break;
+		case AF_INET6:
+			if (nexthop_has_v4(nh)) {
+				err = -EAFNOSUPPORT;
+				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
+				goto err_inval;
+			}
+		}
+	}
+
+	if (old_nh) {
+		list_del_rcu(&fdb->nh_list);
+		nexthop_put(old_nh);
+	}
+	rcu_assign_pointer(fdb->nh, nh);
+	list_add_tail_rcu(&fdb->nh_list, &nh->fdb_list);
+	return 1;
+
+err_inval:
+	if (nh)
+		nexthop_put(nh);
+	return err;
+}
+
+static int vxlan_fdb_create(struct vxlan_dev *vxlan,
+			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __be16 port, __be32 src_vni,
+			    __be32 vni, __u32 ifindex, __u16 ndm_flags,
+			    u32 nhid, struct vxlan_fdb **fdb,
+			    struct netlink_ext_ack *extack)
+{
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_fdb *f;
+	int rc;
+
+	if (vxlan->cfg.addrmax &&
+	    vxlan->addrcnt >= vxlan->cfg.addrmax)
+		return -ENOSPC;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	f = vxlan_fdb_alloc(vxlan, mac, state, src_vni, ndm_flags);
+	if (!f)
+		return -ENOMEM;
+
+	if (nhid)
+		rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
+	else
+		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+	if (rc < 0)
+		goto errout;
+
+	*fdb = f;
+
+	return 0;
+
+errout:
+	kfree(f);
+	return rc;
+}
+
+static void __vxlan_fdb_free(struct vxlan_fdb *f)
+{
+	struct vxlan_rdst *rd, *nd;
+	struct nexthop *nh;
+
+	nh = rcu_dereference_raw(f->nh);
+	if (nh) {
+		rcu_assign_pointer(f->nh, NULL);
+		rcu_assign_pointer(f->vdev, NULL);
+		nexthop_put(nh);
+	}
+
+	list_for_each_entry_safe(rd, nd, &f->remotes, list) {
+		dst_cache_destroy(&rd->dst_cache);
+		kfree(rd);
+	}
+	kfree(f);
+}
+
+static void vxlan_fdb_free(struct rcu_head *head)
+{
+	struct vxlan_fdb *f = container_of(head, struct vxlan_fdb, rcu);
+
+	__vxlan_fdb_free(f);
+}
+
+static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
+			      bool do_notify, bool swdev_notify)
+{
+	struct vxlan_rdst *rd;
+
+	netdev_dbg(vxlan->dev, "delete %pM\n", f->eth_addr);
+
+	--vxlan->addrcnt;
+	if (do_notify) {
+		if (rcu_access_pointer(f->nh))
+			vxlan_fdb_notify(vxlan, f, NULL, RTM_DELNEIGH,
+					 swdev_notify, NULL);
+		else
+			list_for_each_entry(rd, &f->remotes, list)
+				vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH,
+						 swdev_notify, NULL);
+	}
+
+	hlist_del_rcu(&f->hlist);
+	list_del_rcu(&f->nh_list);
+	call_rcu(&f->rcu, vxlan_fdb_free);
+}
+
+static void vxlan_dst_free(struct rcu_head *head)
+{
+	struct vxlan_rdst *rd = container_of(head, struct vxlan_rdst, rcu);
+
+	dst_cache_destroy(&rd->dst_cache);
+	kfree(rd);
+}
+
+static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
+				     union vxlan_addr *ip,
+				     __u16 state, __u16 flags,
+				     __be16 port, __be32 vni,
+				     __u32 ifindex, __u16 ndm_flags,
+				     struct vxlan_fdb *f, u32 nhid,
+				     bool swdev_notify,
+				     struct netlink_ext_ack *extack)
+{
+	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_rdst oldrd;
+	int notify = 0;
+	int rc = 0;
+	int err;
+
+	if (nhid && !rcu_access_pointer(f->nh)) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot replace an existing non nexthop fdb with a nexthop");
+		return -EOPNOTSUPP;
+	}
+
+	if (nhid && (flags & NLM_F_APPEND)) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot append to a nexthop fdb");
+		return -EOPNOTSUPP;
+	}
+
+	/* Do not allow an externally learned entry to take over an entry added
+	 * by the user.
+	 */
+	if (!(fdb_flags & NTF_EXT_LEARNED) ||
+	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
+		if (f->state != state) {
+			f->state = state;
+			f->updated = jiffies;
+			notify = 1;
+		}
+		if (f->flags != fdb_flags) {
+			f->flags = fdb_flags;
+			f->updated = jiffies;
+			notify = 1;
+		}
+	}
+
+	if ((flags & NLM_F_REPLACE)) {
+		/* Only change unicasts */
+		if (!(is_multicast_ether_addr(f->eth_addr) ||
+		      is_zero_ether_addr(f->eth_addr))) {
+			if (nhid) {
+				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
+				if (rc < 0)
+					return rc;
+			} else {
+				rc = vxlan_fdb_replace(f, ip, port, vni,
+						       ifindex, &oldrd);
+			}
+			notify |= rc;
+		} else {
+			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
+			return -EOPNOTSUPP;
+		}
+	}
+	if ((flags & NLM_F_APPEND) &&
+	    (is_multicast_ether_addr(f->eth_addr) ||
+	     is_zero_ether_addr(f->eth_addr))) {
+		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+
+		if (rc < 0)
+			return rc;
+		notify |= rc;
+	}
+
+	if (ndm_flags & NTF_USE)
+		f->used = jiffies;
+
+	if (notify) {
+		if (rd == NULL)
+			rd = first_remote_rtnl(f);
+
+		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
+				       swdev_notify, extack);
+		if (err)
+			goto err_notify;
+	}
+
+	return 0;
+
+err_notify:
+	if (nhid)
+		return err;
+	if ((flags & NLM_F_REPLACE) && rc)
+		*rd = oldrd;
+	else if ((flags & NLM_F_APPEND) && rc) {
+		list_del_rcu(&rd->list);
+		call_rcu(&rd->rcu, vxlan_dst_free);
+	}
+	return err;
+}
+
+static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
+				   const u8 *mac, union vxlan_addr *ip,
+				   __u16 state, __u16 flags,
+				   __be16 port, __be32 src_vni, __be32 vni,
+				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
+				   bool swdev_notify,
+				   struct netlink_ext_ack *extack)
+{
+	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
+	struct vxlan_fdb *f;
+	int rc;
+
+	/* Disallow replace to add a multicast entry */
+	if ((flags & NLM_F_REPLACE) &&
+	    (is_multicast_ether_addr(mac) || is_zero_ether_addr(mac)))
+		return -EOPNOTSUPP;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
+			      vni, ifindex, fdb_flags, nhid, &f, extack);
+	if (rc < 0)
+		return rc;
+
+	vxlan_fdb_insert(vxlan, mac, src_vni, f);
+	rc = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
+			      swdev_notify, extack);
+	if (rc)
+		goto err_notify;
+
+	return 0;
+
+err_notify:
+	vxlan_fdb_destroy(vxlan, f, false, false);
+	return rc;
+}
+
+/* Add new entry to forwarding table -- assumes lock held */
+static int vxlan_fdb_update(struct vxlan_dev *vxlan,
+			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __u16 flags,
+			    __be16 port, __be32 src_vni, __be32 vni,
+			    __u32 ifindex, __u16 ndm_flags, u32 nhid,
+			    bool swdev_notify,
+			    struct netlink_ext_ack *extack)
+{
+	struct vxlan_fdb *f;
+
+	f = __vxlan_find_mac(vxlan, mac, src_vni);
+	if (f) {
+		if (flags & NLM_F_EXCL) {
+			netdev_dbg(vxlan->dev,
+				   "lost race to create %pM\n", mac);
+			return -EEXIST;
+		}
+
+		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
+						 vni, ifindex, ndm_flags, f,
+						 nhid, swdev_notify, extack);
+	} else {
+		if (!(flags & NLM_F_CREATE))
+			return -ENOENT;
+
+		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
+					       port, src_vni, vni, ifindex,
+					       ndm_flags, nhid, swdev_notify,
+					       extack);
+	}
+}
+
+static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
+				  struct vxlan_rdst *rd, bool swdev_notify)
+{
+	list_del_rcu(&rd->list);
+	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, swdev_notify, NULL);
+	call_rcu(&rd->rcu, vxlan_dst_free);
+}
+
+static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
+			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
+			   __be32 *vni, u32 *ifindex, u32 *nhid)
+{
+	struct net *net = dev_net(vxlan->dev);
+	int err;
+
+	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
+	    tb[NDA_PORT]))
+		return -EINVAL;
+
+	if (tb[NDA_DST]) {
+		err = vxlan_nla_get_addr(ip, tb[NDA_DST]);
+		if (err)
+			return err;
+	} else {
+		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
+
+		if (remote->sa.sa_family == AF_INET) {
+			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
+			ip->sa.sa_family = AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			ip->sin6.sin6_addr = in6addr_any;
+			ip->sa.sa_family = AF_INET6;
+#endif
+		}
+	}
+
+	if (tb[NDA_PORT]) {
+		if (nla_len(tb[NDA_PORT]) != sizeof(__be16))
+			return -EINVAL;
+		*port = nla_get_be16(tb[NDA_PORT]);
+	} else {
+		*port = vxlan->cfg.dst_port;
+	}
+
+	if (tb[NDA_VNI]) {
+		if (nla_len(tb[NDA_VNI]) != sizeof(u32))
+			return -EINVAL;
+		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+	} else {
+		*vni = vxlan->default_dst.remote_vni;
+	}
+
+	if (tb[NDA_SRC_VNI]) {
+		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32))
+			return -EINVAL;
+		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
+	} else {
+		*src_vni = vxlan->default_dst.remote_vni;
+	}
+
+	if (tb[NDA_IFINDEX]) {
+		struct net_device *tdev;
+
+		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
+			return -EINVAL;
+		*ifindex = nla_get_u32(tb[NDA_IFINDEX]);
+		tdev = __dev_get_by_index(net, *ifindex);
+		if (!tdev)
+			return -EADDRNOTAVAIL;
+	} else {
+		*ifindex = 0;
+	}
+
+	if (tb[NDA_NH_ID])
+		*nhid = nla_get_u32(tb[NDA_NH_ID]);
+	else
+		*nhid = 0;
+
+	return 0;
+}
+
+/* Add static entry (via netlink) */
+static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
+			 struct net_device *dev,
+			 const unsigned char *addr, u16 vid, u16 flags,
+			 struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	/* struct net *net = dev_net(vxlan->dev); */
+	union vxlan_addr ip;
+	__be16 port;
+	__be32 src_vni, vni;
+	u32 ifindex, nhid;
+	u32 hash_index;
+	int err;
+
+	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
+		pr_info("RTM_NEWNEIGH with invalid state %#x\n",
+			ndm->ndm_state);
+		return -EINVAL;
+	}
+
+	if (!tb || (!tb[NDA_DST] && !tb[NDA_NH_ID]))
+		return -EINVAL;
+
+	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
+			      &nhid);
+	if (err)
+		return err;
+
+	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
+		return -EAFNOSUPPORT;
+
+	hash_index = fdb_head_index(vxlan, addr, src_vni);
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
+			       port, src_vni, vni, ifindex,
+			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
+			       nhid, true, extack);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+static int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
+			      const unsigned char *addr, union vxlan_addr ip,
+			      __be16 port, __be32 src_vni, __be32 vni,
+			      u32 ifindex, bool swdev_notify)
+{
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_fdb *f;
+	int err = -ENOENT;
+
+	f = vxlan_find_mac(vxlan, addr, src_vni);
+	if (!f)
+		return err;
+
+	if (!vxlan_addr_any(&ip)) {
+		rd = vxlan_fdb_find_rdst(f, &ip, port, vni, ifindex);
+		if (!rd)
+			goto out;
+	}
+
+	/* remove a destination if it's not the only one on the list,
+	 * otherwise destroy the fdb entry
+	 */
+	if (rd && !list_is_singular(&f->remotes)) {
+		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
+		goto out;
+	}
+
+	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
+
+out:
+	return 0;
+}
+
+/* Delete entry (via netlink) */
+static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
+			    struct net_device *dev,
+			    const unsigned char *addr, u16 vid)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	union vxlan_addr ip;
+	__be32 src_vni, vni;
+	u32 ifindex, nhid;
+	u32 hash_index;
+	__be16 port;
+	int err;
+
+	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
+			      &nhid);
+	if (err)
+		return err;
+
+	hash_index = fdb_head_index(vxlan, addr, src_vni);
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	err = __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
+				 true);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+/* Dump forwarding table */
+static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			  struct net_device *dev,
+			  struct net_device *filter_dev, int *idx)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	unsigned int h;
+	int err = 0;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		struct vxlan_fdb *f;
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(f, &vxlan->fdb_head[h], hlist) {
+			struct vxlan_rdst *rd;
+
+			if (rcu_access_pointer(f->nh)) {
+				if (*idx < cb->args[2])
+					goto skip_nh;
+				err = vxlan_fdb_info(skb, vxlan, f,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     RTM_NEWNEIGH,
+						     NLM_F_MULTI, NULL);
+				if (err < 0) {
+					rcu_read_unlock();
+					goto out;
+				}
+skip_nh:
+				*idx += 1;
+				continue;
+			}
+
+			list_for_each_entry_rcu(rd, &f->remotes, list) {
+				if (*idx < cb->args[2])
+					goto skip;
+
+				err = vxlan_fdb_info(skb, vxlan, f,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     RTM_NEWNEIGH,
+						     NLM_F_MULTI, rd);
+				if (err < 0) {
+					rcu_read_unlock();
+					goto out;
+				}
+skip:
+				*idx += 1;
+			}
+		}
+		rcu_read_unlock();
+	}
+out:
+	return err;
+}
+
+static int vxlan_fdb_get(struct sk_buff *skb,
+			 struct nlattr *tb[],
+			 struct net_device *dev,
+			 const unsigned char *addr,
+			 u16 vid, u32 portid, u32 seq,
+			 struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f;
+	__be32 vni;
+	int err;
+
+	if (tb[NDA_VNI])
+		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+	else
+		vni = vxlan->default_dst.remote_vni;
+
+	rcu_read_lock();
+
+	f = __vxlan_find_mac(vxlan, addr, vni);
+	if (!f) {
+		NL_SET_ERR_MSG(extack, "Fdb entry not found");
+		err = -ENOENT;
+		goto errout;
+	}
+
+	err = vxlan_fdb_info(skb, vxlan, f, portid, seq,
+			     RTM_NEWNEIGH, 0, first_remote_rcu(f));
+errout:
+	rcu_read_unlock();
+	return err;
+}
+
+/* Watch incoming packets to learn mapping between Ethernet address
+ * and Tunnel endpoint.
+ * Return true if packet is bogus and should be dropped.
+ */
+static bool vxlan_snoop(struct net_device *dev,
+			union vxlan_addr *src_ip, const u8 *src_mac,
+			u32 src_ifindex, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f;
+	u32 ifindex = 0;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (src_ip->sa.sa_family == AF_INET6 &&
+	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
+		ifindex = src_ifindex;
+#endif
+
+	f = vxlan_find_mac(vxlan, src_mac, vni);
+	if (likely(f)) {
+		struct vxlan_rdst *rdst = first_remote_rcu(f);
+
+		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
+			   rdst->remote_ifindex == ifindex))
+			return false;
+
+		/* Don't migrate static entries, drop packets */
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
+			return true;
+
+		/* Don't override an fdb with nexthop with a learnt entry */
+		if (rcu_access_pointer(f->nh))
+			return true;
+
+		if (net_ratelimit())
+			netdev_info(dev,
+				    "%pM migrated from %pIS to %pIS\n",
+				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
+
+		rdst->remote_ip = *src_ip;
+		f->updated = jiffies;
+		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
+	} else {
+		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
+
+		/* learned new entry */
+		spin_lock(&vxlan->hash_lock[hash_index]);
+
+		/* close off race between vxlan_flush and incoming packets */
+		if (netif_running(dev))
+			vxlan_fdb_update(vxlan, src_mac, src_ip,
+					 NUD_REACHABLE,
+					 NLM_F_EXCL|NLM_F_CREATE,
+					 vxlan->cfg.dst_port,
+					 vni,
+					 vxlan->default_dst.remote_vni,
+					 ifindex, NTF_SELF, 0, true, NULL);
+		spin_unlock(&vxlan->hash_lock[hash_index]);
+	}
+
+	return false;
+}
+
+/* See if multicast group is already in use by other ID */
+static bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_sock *sock4;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct vxlan_sock *sock6;
+#endif
+	unsigned short family = dev->default_dst.remote_ip.sa.sa_family;
+
+	sock4 = rtnl_dereference(dev->vn4_sock);
+
+	/* The vxlan_sock is only used by dev, leaving group has
+	 * no effect on other vxlan devices.
+	 */
+	if (family == AF_INET && sock4 && refcount_read(&sock4->refcnt) == 1)
+		return false;
+#if IS_ENABLED(CONFIG_IPV6)
+	sock6 = rtnl_dereference(dev->vn6_sock);
+	if (family == AF_INET6 && sock6 && refcount_read(&sock6->refcnt) == 1)
+		return false;
+#endif
+
+	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
+		if (!netif_running(vxlan->dev) || vxlan == dev)
+			continue;
+
+		if (family == AF_INET &&
+		    rtnl_dereference(vxlan->vn4_sock) != sock4)
+			continue;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (family == AF_INET6 &&
+		    rtnl_dereference(vxlan->vn6_sock) != sock6)
+			continue;
+#endif
+
+		if (!vxlan_addr_equal(&vxlan->default_dst.remote_ip,
+				      &dev->default_dst.remote_ip))
+			continue;
+
+		if (vxlan->default_dst.remote_ifindex !=
+		    dev->default_dst.remote_ifindex)
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
+{
+	struct vxlan_net *vn;
+
+	if (!vs)
+		return false;
+	if (!refcount_dec_and_test(&vs->refcnt))
+		return false;
+
+	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
+	spin_lock(&vn->sock_lock);
+	hlist_del_rcu(&vs->hlist);
+	udp_tunnel_notify_del_rx_port(vs->sock,
+				      (vs->flags & VXLAN_F_GPE) ?
+				      UDP_TUNNEL_TYPE_VXLAN_GPE :
+				      UDP_TUNNEL_TYPE_VXLAN);
+	spin_unlock(&vn->sock_lock);
+
+	return true;
+}
+
+static void vxlan_sock_release(struct vxlan_dev *vxlan)
+{
+	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
+#if IS_ENABLED(CONFIG_IPV6)
+	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
+
+	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
+#endif
+
+	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
+	synchronize_net();
+
+	vxlan_vs_del_dev(vxlan);
+
+	if (__vxlan_sock_release_prep(sock4)) {
+		udp_tunnel_sock_release(sock4->sock);
+		kfree(sock4);
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (__vxlan_sock_release_prep(sock6)) {
+		udp_tunnel_sock_release(sock6->sock);
+		kfree(sock6);
+	}
+#endif
+}
+
+/* Update multicast group membership when first VNI on
+ * multicast address is brought up
+ */
+static int vxlan_igmp_join(struct vxlan_dev *vxlan)
+{
+	struct sock *sk;
+	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
+	int ifindex = vxlan->default_dst.remote_ifindex;
+	int ret = -EINVAL;
+
+	if (ip->sa.sa_family == AF_INET) {
+		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
+		struct ip_mreqn mreq = {
+			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
+			.imr_ifindex		= ifindex,
+		};
+
+		sk = sock4->sock->sk;
+		lock_sock(sk);
+		ret = ip_mc_join_group(sk, &mreq);
+		release_sock(sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
+
+		sk = sock6->sock->sk;
+		lock_sock(sk);
+		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
+						   &ip->sin6.sin6_addr);
+		release_sock(sk);
+#endif
+	}
+
+	return ret;
+}
+
+/* Inverse of vxlan_igmp_join when last VNI is brought down */
+static int vxlan_igmp_leave(struct vxlan_dev *vxlan)
+{
+	struct sock *sk;
+	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
+	int ifindex = vxlan->default_dst.remote_ifindex;
+	int ret = -EINVAL;
+
+	if (ip->sa.sa_family == AF_INET) {
+		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
+		struct ip_mreqn mreq = {
+			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
+			.imr_ifindex		= ifindex,
+		};
+
+		sk = sock4->sock->sk;
+		lock_sock(sk);
+		ret = ip_mc_leave_group(sk, &mreq);
+		release_sock(sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
+
+		sk = sock6->sock->sk;
+		lock_sock(sk);
+		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
+						   &ip->sin6.sin6_addr);
+		release_sock(sk);
+#endif
+	}
+
+	return ret;
+}
+
+static bool vxlan_remcsum(struct vxlanhdr *unparsed,
+			  struct sk_buff *skb, u32 vxflags)
+{
+	size_t start, offset;
+
+	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
+		goto out;
+
+	start = vxlan_rco_start(unparsed->vx_vni);
+	offset = start + vxlan_rco_offset(unparsed->vx_vni);
+
+	if (!pskb_may_pull(skb, offset + sizeof(u16)))
+		return false;
+
+	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
+			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
+out:
+	unparsed->vx_flags &= ~VXLAN_HF_RCO;
+	unparsed->vx_vni &= VXLAN_VNI_MASK;
+	return true;
+}
+
+static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
+				struct sk_buff *skb, u32 vxflags,
+				struct vxlan_metadata *md)
+{
+	struct vxlanhdr_gbp *gbp = (struct vxlanhdr_gbp *)unparsed;
+	struct metadata_dst *tun_dst;
+
+	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
+		goto out;
+
+	md->gbp = ntohs(gbp->policy_id);
+
+	tun_dst = (struct metadata_dst *)skb_dst(skb);
+	if (tun_dst) {
+		tun_dst->u.tun_info.key.tun_flags |= TUNNEL_VXLAN_OPT;
+		tun_dst->u.tun_info.options_len = sizeof(*md);
+	}
+	if (gbp->dont_learn)
+		md->gbp |= VXLAN_GBP_DONT_LEARN;
+
+	if (gbp->policy_applied)
+		md->gbp |= VXLAN_GBP_POLICY_APPLIED;
+
+	/* In flow-based mode, GBP is carried in dst_metadata */
+	if (!(vxflags & VXLAN_F_COLLECT_METADATA))
+		skb->mark = md->gbp;
+out:
+	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
+}
+
+static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
+				__be16 *protocol,
+				struct sk_buff *skb, u32 vxflags)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
+
+	/* Need to have Next Protocol set for interfaces in GPE mode. */
+	if (!gpe->np_applied)
+		return false;
+	/* "The initial version is 0. If a receiver does not support the
+	 * version indicated it MUST drop the packet.
+	 */
+	if (gpe->version != 0)
+		return false;
+	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
+	 * processing MUST occur." However, we don't implement OAM
+	 * processing, thus drop the packet.
+	 */
+	if (gpe->oam_flag)
+		return false;
+
+	*protocol = tun_p_to_eth_p(gpe->next_protocol);
+	if (!*protocol)
+		return false;
+
+	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
+	return true;
+}
+
+static bool vxlan_set_mac(struct vxlan_dev *vxlan,
+			  struct vxlan_sock *vs,
+			  struct sk_buff *skb, __be32 vni)
+{
+	union vxlan_addr saddr;
+	u32 ifindex = skb->dev->ifindex;
+
+	skb_reset_mac_header(skb);
+	skb->protocol = eth_type_trans(skb, vxlan->dev);
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
+
+	/* Ignore packet loops (and multicast echo) */
+	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
+		return false;
+
+	/* Get address from the outer IP header */
+	if (vxlan_get_sk_family(vs) == AF_INET) {
+		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
+		saddr.sa.sa_family = AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
+		saddr.sa.sa_family = AF_INET6;
+#endif
+	}
+
+	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
+	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
+		return false;
+
+	return true;
+}
+
+static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
+				  struct sk_buff *skb)
+{
+	int err = 0;
+
+	if (vxlan_get_sk_family(vs) == AF_INET)
+		err = IP_ECN_decapsulate(oiph, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		err = IP6_ECN_decapsulate(oiph, skb);
+#endif
+
+	if (unlikely(err) && log_ecn_error) {
+		if (vxlan_get_sk_family(vs) == AF_INET)
+			net_info_ratelimited("non-ECT from %pI4 with TOS=%#x\n",
+					     &((struct iphdr *)oiph)->saddr,
+					     ((struct iphdr *)oiph)->tos);
+		else
+			net_info_ratelimited("non-ECT from %pI6\n",
+					     &((struct ipv6hdr *)oiph)->saddr);
+	}
+	return err <= 1;
+}
+
+/* Callback from net/ipv4/udp.c to receive packets */
+static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_sock *vs;
+	struct vxlanhdr unparsed;
+	struct vxlan_metadata _md;
+	struct vxlan_metadata *md = &_md;
+	__be16 protocol = htons(ETH_P_TEB);
+	bool raw_proto = false;
+	void *oiph;
+	__be32 vni = 0;
+
+	/* Need UDP and VXLAN header to be present */
+	if (!pskb_may_pull(skb, VXLAN_HLEN))
+		goto drop;
+
+	unparsed = *vxlan_hdr(skb);
+	/* VNI flag always required to be set */
+	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
+		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
+			   ntohl(vxlan_hdr(skb)->vx_flags),
+			   ntohl(vxlan_hdr(skb)->vx_vni));
+		/* Return non vxlan pkt */
+		goto drop;
+	}
+	unparsed.vx_flags &= ~VXLAN_HF_VNI;
+	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
+
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		goto drop;
+
+	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
+
+	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
+	if (!vxlan)
+		goto drop;
+
+	/* For backwards compatibility, only allow reserved fields to be
+	 * used by VXLAN extensions if explicitly requested.
+	 */
+	if (vs->flags & VXLAN_F_GPE) {
+		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
+			goto drop;
+		raw_proto = true;
+	}
+
+	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
+				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
+		goto drop;
+
+	if (vs->flags & VXLAN_F_REMCSUM_RX)
+		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
+			goto drop;
+
+	if (vxlan_collect_metadata(vs)) {
+		struct metadata_dst *tun_dst;
+
+		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), TUNNEL_KEY,
+					 key32_to_tunnel_id(vni), sizeof(*md));
+
+		if (!tun_dst)
+			goto drop;
+
+		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
+
+		skb_dst_set(skb, (struct dst_entry *)tun_dst);
+	} else {
+		memset(md, 0, sizeof(*md));
+	}
+
+	if (vs->flags & VXLAN_F_GBP)
+		vxlan_parse_gbp_hdr(&unparsed, skb, vs->flags, md);
+	/* Note that GBP and GPE can never be active together. This is
+	 * ensured in vxlan_dev_configure.
+	 */
+
+	if (unparsed.vx_flags || unparsed.vx_vni) {
+		/* If there are any unprocessed flags remaining treat
+		 * this as a malformed packet. This behavior diverges from
+		 * VXLAN RFC (RFC7348) which stipulates that bits in reserved
+		 * in reserved fields are to be ignored. The approach here
+		 * maintains compatibility with previous stack code, and also
+		 * is more robust and provides a little more security in
+		 * adding extensions to VXLAN.
+		 */
+		goto drop;
+	}
+
+	if (!raw_proto) {
+		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+			goto drop;
+	} else {
+		skb_reset_mac_header(skb);
+		skb->dev = vxlan->dev;
+		skb->pkt_type = PACKET_HOST;
+	}
+
+	oiph = skb_network_header(skb);
+	skb_reset_network_header(skb);
+
+	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
+		++vxlan->dev->stats.rx_frame_errors;
+		++vxlan->dev->stats.rx_errors;
+		goto drop;
+	}
+
+	rcu_read_lock();
+
+	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
+		rcu_read_unlock();
+		atomic_long_inc(&vxlan->dev->rx_dropped);
+		goto drop;
+	}
+
+	dev_sw_netstats_rx_add(vxlan->dev, skb->len);
+	gro_cells_receive(&vxlan->gro_cells, skb);
+
+	rcu_read_unlock();
+
+	return 0;
+
+drop:
+	/* Consume bad packet */
+	kfree_skb(skb);
+	return 0;
+}
+
+/* Callback from net/ipv{4,6}/udp.c to check that we have a VNI for errors */
+static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_sock *vs;
+	struct vxlanhdr *hdr;
+	__be32 vni;
+
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) + VXLAN_HLEN))
+		return -EINVAL;
+
+	hdr = vxlan_hdr(skb);
+
+	if (!(hdr->vx_flags & VXLAN_HF_VNI))
+		return -EINVAL;
+
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		return -ENOENT;
+
+	vni = vxlan_vni(hdr->vx_vni);
+	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
+	if (!vxlan)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct arphdr *parp;
+	u8 *arpptr, *sha;
+	__be32 sip, tip;
+	struct neighbour *n;
+
+	if (dev->flags & IFF_NOARP)
+		goto out;
+
+	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+		dev->stats.tx_dropped++;
+		goto out;
+	}
+	parp = arp_hdr(skb);
+
+	if ((parp->ar_hrd != htons(ARPHRD_ETHER) &&
+	     parp->ar_hrd != htons(ARPHRD_IEEE802)) ||
+	    parp->ar_pro != htons(ETH_P_IP) ||
+	    parp->ar_op != htons(ARPOP_REQUEST) ||
+	    parp->ar_hln != dev->addr_len ||
+	    parp->ar_pln != 4)
+		goto out;
+	arpptr = (u8 *)parp + sizeof(struct arphdr);
+	sha = arpptr;
+	arpptr += dev->addr_len;	/* sha */
+	memcpy(&sip, arpptr, sizeof(sip));
+	arpptr += sizeof(sip);
+	arpptr += dev->addr_len;	/* tha */
+	memcpy(&tip, arpptr, sizeof(tip));
+
+	if (ipv4_is_loopback(tip) ||
+	    ipv4_is_multicast(tip))
+		goto out;
+
+	n = neigh_lookup(&arp_tbl, &tip, dev);
+
+	if (n) {
+		struct vxlan_fdb *f;
+		struct sk_buff	*reply;
+
+		if (!(n->nud_state & NUD_CONNECTED)) {
+			neigh_release(n);
+			goto out;
+		}
+
+		f = vxlan_find_mac(vxlan, n->ha, vni);
+		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+			/* bridge-local neighbor */
+			neigh_release(n);
+			goto out;
+		}
+
+		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
+				n->ha, sha);
+
+		neigh_release(n);
+
+		if (reply == NULL)
+			goto out;
+
+		skb_reset_mac_header(reply);
+		__skb_pull(reply, skb_network_offset(reply));
+		reply->ip_summed = CHECKSUM_UNNECESSARY;
+		reply->pkt_type = PACKET_HOST;
+
+		if (netif_rx_ni(reply) == NET_RX_DROP)
+			dev->stats.rx_dropped++;
+	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+		union vxlan_addr ipa = {
+			.sin.sin_addr.s_addr = tip,
+			.sin.sin_family = AF_INET,
+		};
+
+		vxlan_ip_miss(dev, &ipa);
+	}
+out:
+	consume_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct sk_buff *vxlan_na_create(struct sk_buff *request,
+	struct neighbour *n, bool isrouter)
+{
+	struct net_device *dev = request->dev;
+	struct sk_buff *reply;
+	struct nd_msg *ns, *na;
+	struct ipv6hdr *pip6;
+	u8 *daddr;
+	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
+	int ns_olen;
+	int i, len;
+
+	if (dev == NULL || !pskb_may_pull(request, request->len))
+		return NULL;
+
+	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
+		sizeof(*na) + na_olen + dev->needed_tailroom;
+	reply = alloc_skb(len, GFP_ATOMIC);
+	if (reply == NULL)
+		return NULL;
+
+	reply->protocol = htons(ETH_P_IPV6);
+	reply->dev = dev;
+	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
+	skb_push(reply, sizeof(struct ethhdr));
+	skb_reset_mac_header(reply);
+
+	ns = (struct nd_msg *)(ipv6_hdr(request) + 1);
+
+	daddr = eth_hdr(request)->h_source;
+	ns_olen = request->len - skb_network_offset(request) -
+		sizeof(struct ipv6hdr) - sizeof(*ns);
+	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
+		if (!ns->opt[i + 1]) {
+			kfree_skb(reply);
+			return NULL;
+		}
+		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
+			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
+			break;
+		}
+	}
+
+	/* Ethernet header */
+	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
+	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
+	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
+	reply->protocol = htons(ETH_P_IPV6);
+
+	skb_pull(reply, sizeof(struct ethhdr));
+	skb_reset_network_header(reply);
+	skb_put(reply, sizeof(struct ipv6hdr));
+
+	/* IPv6 header */
+
+	pip6 = ipv6_hdr(reply);
+	memset(pip6, 0, sizeof(struct ipv6hdr));
+	pip6->version = 6;
+	pip6->priority = ipv6_hdr(request)->priority;
+	pip6->nexthdr = IPPROTO_ICMPV6;
+	pip6->hop_limit = 255;
+	pip6->daddr = ipv6_hdr(request)->saddr;
+	pip6->saddr = *(struct in6_addr *)n->primary_key;
+
+	skb_pull(reply, sizeof(struct ipv6hdr));
+	skb_reset_transport_header(reply);
+
+	/* Neighbor Advertisement */
+	na = skb_put_zero(reply, sizeof(*na) + na_olen);
+	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
+	na->icmph.icmp6_router = isrouter;
+	na->icmph.icmp6_override = 1;
+	na->icmph.icmp6_solicited = 1;
+	na->target = ns->target;
+	ether_addr_copy(&na->opt[2], n->ha);
+	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
+	na->opt[1] = na_olen >> 3;
+
+	na->icmph.icmp6_cksum = csum_ipv6_magic(&pip6->saddr,
+		&pip6->daddr, sizeof(*na)+na_olen, IPPROTO_ICMPV6,
+		csum_partial(na, sizeof(*na)+na_olen, 0));
+
+	pip6->payload_len = htons(sizeof(*na)+na_olen);
+
+	skb_push(reply, sizeof(struct ipv6hdr));
+
+	reply->ip_summed = CHECKSUM_UNNECESSARY;
+
+	return reply;
+}
+
+static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct in6_addr *daddr;
+	const struct ipv6hdr *iphdr;
+	struct inet6_dev *in6_dev;
+	struct neighbour *n;
+	struct nd_msg *msg;
+
+	rcu_read_lock();
+	in6_dev = __in6_dev_get(dev);
+	if (!in6_dev)
+		goto out;
+
+	iphdr = ipv6_hdr(skb);
+	daddr = &iphdr->daddr;
+	msg = (struct nd_msg *)(iphdr + 1);
+
+	if (ipv6_addr_loopback(daddr) ||
+	    ipv6_addr_is_multicast(&msg->target))
+		goto out;
+
+	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
+
+	if (n) {
+		struct vxlan_fdb *f;
+		struct sk_buff *reply;
+
+		if (!(n->nud_state & NUD_CONNECTED)) {
+			neigh_release(n);
+			goto out;
+		}
+
+		f = vxlan_find_mac(vxlan, n->ha, vni);
+		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+			/* bridge-local neighbor */
+			neigh_release(n);
+			goto out;
+		}
+
+		reply = vxlan_na_create(skb, n,
+					!!(f ? f->flags & NTF_ROUTER : 0));
+
+		neigh_release(n);
+
+		if (reply == NULL)
+			goto out;
+
+		if (netif_rx_ni(reply) == NET_RX_DROP)
+			dev->stats.rx_dropped++;
+
+	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+		union vxlan_addr ipa = {
+			.sin6.sin6_addr = msg->target,
+			.sin6.sin6_family = AF_INET6,
+		};
+
+		vxlan_ip_miss(dev, &ipa);
+	}
+
+out:
+	rcu_read_unlock();
+	consume_skb(skb);
+	return NETDEV_TX_OK;
+}
+#endif
+
+static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct neighbour *n;
+
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
+		return false;
+
+	n = NULL;
+	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	case ETH_P_IP:
+	{
+		struct iphdr *pip;
+
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return false;
+		pip = ip_hdr(skb);
+		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
+		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+			union vxlan_addr ipa = {
+				.sin.sin_addr.s_addr = pip->daddr,
+				.sin.sin_family = AF_INET,
+			};
+
+			vxlan_ip_miss(dev, &ipa);
+			return false;
+		}
+
+		break;
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
+	{
+		struct ipv6hdr *pip6;
+
+		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+			return false;
+		pip6 = ipv6_hdr(skb);
+		n = neigh_lookup(ipv6_stub->nd_tbl, &pip6->daddr, dev);
+		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+			union vxlan_addr ipa = {
+				.sin6.sin6_addr = pip6->daddr,
+				.sin6.sin6_family = AF_INET6,
+			};
+
+			vxlan_ip_miss(dev, &ipa);
+			return false;
+		}
+
+		break;
+	}
+#endif
+	default:
+		return false;
+	}
+
+	if (n) {
+		bool diff;
+
+		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
+		if (diff) {
+			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
+				dev->addr_len);
+			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
+		}
+		neigh_release(n);
+		return diff;
+	}
+
+	return false;
+}
+
+static void vxlan_build_gbp_hdr(struct vxlanhdr *vxh, u32 vxflags,
+				struct vxlan_metadata *md)
+{
+	struct vxlanhdr_gbp *gbp;
+
+	if (!md->gbp)
+		return;
+
+	gbp = (struct vxlanhdr_gbp *)vxh;
+	vxh->vx_flags |= VXLAN_HF_GBP;
+
+	if (md->gbp & VXLAN_GBP_DONT_LEARN)
+		gbp->dont_learn = 1;
+
+	if (md->gbp & VXLAN_GBP_POLICY_APPLIED)
+		gbp->policy_applied = 1;
+
+	gbp->policy_id = htons(md->gbp & VXLAN_GBP_ID_MASK);
+}
+
+static int vxlan_build_gpe_hdr(struct vxlanhdr *vxh, u32 vxflags,
+			       __be16 protocol)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)vxh;
+
+	gpe->np_applied = 1;
+	gpe->next_protocol = tun_p_from_eth_p(protocol);
+	if (!gpe->next_protocol)
+		return -EPFNOSUPPORT;
+	return 0;
+}
+
+static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
+			   int iphdr_len, __be32 vni,
+			   struct vxlan_metadata *md, u32 vxflags,
+			   bool udp_sum)
+{
+	struct vxlanhdr *vxh;
+	int min_headroom;
+	int err;
+	int type = udp_sum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
+	__be16 inner_protocol = htons(ETH_P_TEB);
+
+	if ((vxflags & VXLAN_F_REMCSUM_TX) &&
+	    skb->ip_summed == CHECKSUM_PARTIAL) {
+		int csum_start = skb_checksum_start_offset(skb);
+
+		if (csum_start <= VXLAN_MAX_REMCSUM_START &&
+		    !(csum_start & VXLAN_RCO_SHIFT_MASK) &&
+		    (skb->csum_offset == offsetof(struct udphdr, check) ||
+		     skb->csum_offset == offsetof(struct tcphdr, check)))
+			type |= SKB_GSO_TUNNEL_REMCSUM;
+	}
+
+	min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len
+			+ VXLAN_HLEN + iphdr_len;
+
+	/* Need space for new headers (invalidates iph ptr) */
+	err = skb_cow_head(skb, min_headroom);
+	if (unlikely(err))
+		return err;
+
+	err = iptunnel_handle_offloads(skb, type);
+	if (err)
+		return err;
+
+	vxh = __skb_push(skb, sizeof(*vxh));
+	vxh->vx_flags = VXLAN_HF_VNI;
+	vxh->vx_vni = vxlan_vni_field(vni);
+
+	if (type & SKB_GSO_TUNNEL_REMCSUM) {
+		unsigned int start;
+
+		start = skb_checksum_start_offset(skb) - sizeof(struct vxlanhdr);
+		vxh->vx_vni |= vxlan_compute_rco(start, skb->csum_offset);
+		vxh->vx_flags |= VXLAN_HF_RCO;
+
+		if (!skb_is_gso(skb)) {
+			skb->ip_summed = CHECKSUM_NONE;
+			skb->encapsulation = 0;
+		}
+	}
+
+	if (vxflags & VXLAN_F_GBP)
+		vxlan_build_gbp_hdr(vxh, vxflags, md);
+	if (vxflags & VXLAN_F_GPE) {
+		err = vxlan_build_gpe_hdr(vxh, vxflags, skb->protocol);
+		if (err < 0)
+			return err;
+		inner_protocol = skb->protocol;
+	}
+
+	skb_set_inner_protocol(skb, inner_protocol);
+	return 0;
+}
+
+static struct rtable *vxlan_get_route(struct vxlan_dev *vxlan, struct net_device *dev,
+				      struct vxlan_sock *sock4,
+				      struct sk_buff *skb, int oif, u8 tos,
+				      __be32 daddr, __be32 *saddr, __be16 dport, __be16 sport,
+				      struct dst_cache *dst_cache,
+				      const struct ip_tunnel_info *info)
+{
+	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	struct rtable *rt = NULL;
+	struct flowi4 fl4;
+
+	if (!sock4)
+		return ERR_PTR(-EIO);
+
+	if (tos && !info)
+		use_cache = false;
+	if (use_cache) {
+		rt = dst_cache_get_ip4(dst_cache, saddr);
+		if (rt)
+			return rt;
+	}
+
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.flowi4_oif = oif;
+	fl4.flowi4_tos = RT_TOS(tos);
+	fl4.flowi4_mark = skb->mark;
+	fl4.flowi4_proto = IPPROTO_UDP;
+	fl4.daddr = daddr;
+	fl4.saddr = *saddr;
+	fl4.fl4_dport = dport;
+	fl4.fl4_sport = sport;
+
+	rt = ip_route_output_key(vxlan->net, &fl4);
+	if (!IS_ERR(rt)) {
+		if (rt->dst.dev == dev) {
+			netdev_dbg(dev, "circular route to %pI4\n", &daddr);
+			ip_rt_put(rt);
+			return ERR_PTR(-ELOOP);
+		}
+
+		*saddr = fl4.saddr;
+		if (use_cache)
+			dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+	} else {
+		netdev_dbg(dev, "no route to %pI4\n", &daddr);
+		return ERR_PTR(-ENETUNREACH);
+	}
+	return rt;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
+					  struct net_device *dev,
+					  struct vxlan_sock *sock6,
+					  struct sk_buff *skb, int oif, u8 tos,
+					  __be32 label,
+					  const struct in6_addr *daddr,
+					  struct in6_addr *saddr,
+					  __be16 dport, __be16 sport,
+					  struct dst_cache *dst_cache,
+					  const struct ip_tunnel_info *info)
+{
+	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	struct dst_entry *ndst;
+	struct flowi6 fl6;
+
+	if (!sock6)
+		return ERR_PTR(-EIO);
+
+	if (tos && !info)
+		use_cache = false;
+	if (use_cache) {
+		ndst = dst_cache_get_ip6(dst_cache, saddr);
+		if (ndst)
+			return ndst;
+	}
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_oif = oif;
+	fl6.daddr = *daddr;
+	fl6.saddr = *saddr;
+	fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tos), label);
+	fl6.flowi6_mark = skb->mark;
+	fl6.flowi6_proto = IPPROTO_UDP;
+	fl6.fl6_dport = dport;
+	fl6.fl6_sport = sport;
+
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(vxlan->net, sock6->sock->sk,
+					       &fl6, NULL);
+	if (unlikely(IS_ERR(ndst))) {
+		netdev_dbg(dev, "no route to %pI6\n", daddr);
+		return ERR_PTR(-ENETUNREACH);
+	}
+
+	if (unlikely(ndst->dev == dev)) {
+		netdev_dbg(dev, "circular route to %pI6\n", daddr);
+		dst_release(ndst);
+		return ERR_PTR(-ELOOP);
+	}
+
+	*saddr = fl6.saddr;
+	if (use_cache)
+		dst_cache_set_ip6(dst_cache, ndst, saddr);
+	return ndst;
+}
+#endif
+
+/* Bypass encapsulation if the destination is local */
+static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
+			       struct vxlan_dev *dst_vxlan, __be32 vni,
+			       bool snoop)
+{
+	struct pcpu_sw_netstats *tx_stats, *rx_stats;
+	union vxlan_addr loopback;
+	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
+	struct net_device *dev;
+	int len = skb->len;
+
+	tx_stats = this_cpu_ptr(src_vxlan->dev->tstats);
+	rx_stats = this_cpu_ptr(dst_vxlan->dev->tstats);
+	skb->pkt_type = PACKET_HOST;
+	skb->encapsulation = 0;
+	skb->dev = dst_vxlan->dev;
+	__skb_pull(skb, skb_network_offset(skb));
+
+	if (remote_ip->sa.sa_family == AF_INET) {
+		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+		loopback.sa.sa_family =  AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		loopback.sin6.sin6_addr = in6addr_loopback;
+		loopback.sa.sa_family =  AF_INET6;
+#endif
+	}
+
+	rcu_read_lock();
+	dev = skb->dev;
+	if (unlikely(!(dev->flags & IFF_UP))) {
+		kfree_skb(skb);
+		goto drop;
+	}
+
+	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
+		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
+
+	u64_stats_update_begin(&tx_stats->syncp);
+	tx_stats->tx_packets++;
+	tx_stats->tx_bytes += len;
+	u64_stats_update_end(&tx_stats->syncp);
+
+	if (netif_rx(skb) == NET_RX_SUCCESS) {
+		u64_stats_update_begin(&rx_stats->syncp);
+		rx_stats->rx_packets++;
+		rx_stats->rx_bytes += len;
+		u64_stats_update_end(&rx_stats->syncp);
+	} else {
+drop:
+		dev->stats.rx_dropped++;
+	}
+	rcu_read_unlock();
+}
+
+static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
+				 struct vxlan_dev *vxlan,
+				 union vxlan_addr *daddr,
+				 __be16 dst_port, int dst_ifindex, __be32 vni,
+				 struct dst_entry *dst,
+				 u32 rt_flags)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	/* IPv6 rt-flags are checked against RTF_LOCAL, but the value of
+	 * RTF_LOCAL is equal to RTCF_LOCAL. So to keep code simple
+	 * we can use RTCF_LOCAL which works for ipv4 and ipv6 route entry.
+	 */
+	BUILD_BUG_ON(RTCF_LOCAL != RTF_LOCAL);
+#endif
+	/* Bypass encapsulation if the destination is local */
+	if (rt_flags & RTCF_LOCAL &&
+	    !(rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))) {
+		struct vxlan_dev *dst_vxlan;
+
+		dst_release(dst);
+		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
+					   daddr->sa.sa_family, dst_port,
+					   vxlan->cfg.flags);
+		if (!dst_vxlan) {
+			dev->stats.tx_errors++;
+			kfree_skb(skb);
+
+			return -ENOENT;
+		}
+		vxlan_encap_bypass(skb, vxlan, dst_vxlan, vni, true);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+			   __be32 default_vni, struct vxlan_rdst *rdst,
+			   bool did_rsc)
+{
+	struct dst_cache *dst_cache;
+	struct ip_tunnel_info *info;
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct iphdr *old_iph = ip_hdr(skb);
+	union vxlan_addr *dst;
+	union vxlan_addr remote_ip, local_ip;
+	struct vxlan_metadata _md;
+	struct vxlan_metadata *md = &_md;
+	__be16 src_port = 0, dst_port;
+	struct dst_entry *ndst = NULL;
+	__be32 vni, label;
+	__u8 tos, ttl;
+	int ifindex;
+	int err;
+	u32 flags = vxlan->cfg.flags;
+	bool udp_sum = false;
+	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
+
+	info = skb_tunnel_info(skb);
+
+	if (rdst) {
+		dst = &rdst->remote_ip;
+		if (vxlan_addr_any(dst)) {
+			if (did_rsc) {
+				/* short-circuited back to local bridge */
+				vxlan_encap_bypass(skb, vxlan, vxlan,
+						   default_vni, true);
+				return;
+			}
+			goto drop;
+		}
+
+		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
+		vni = (rdst->remote_vni) ? : default_vni;
+		ifindex = rdst->remote_ifindex;
+		local_ip = vxlan->cfg.saddr;
+		dst_cache = &rdst->dst_cache;
+		md->gbp = skb->mark;
+		if (flags & VXLAN_F_TTL_INHERIT) {
+			ttl = ip_tunnel_get_ttl(old_iph, skb);
+		} else {
+			ttl = vxlan->cfg.ttl;
+			if (!ttl && vxlan_addr_multicast(dst))
+				ttl = 1;
+		}
+
+		tos = vxlan->cfg.tos;
+		if (tos == 1)
+			tos = ip_tunnel_get_dsfield(old_iph, skb);
+
+		if (dst->sa.sa_family == AF_INET)
+			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
+		else
+			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
+		label = vxlan->cfg.label;
+	} else {
+		if (!info) {
+			WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
+				  dev->name);
+			goto drop;
+		}
+		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
+		if (remote_ip.sa.sa_family == AF_INET) {
+			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
+			local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
+		} else {
+			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
+			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
+		}
+		dst = &remote_ip;
+		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
+		vni = tunnel_id_to_key32(info->key.tun_id);
+		ifindex = 0;
+		dst_cache = &info->dst_cache;
+		if (info->key.tun_flags & TUNNEL_VXLAN_OPT) {
+			if (info->options_len < sizeof(*md))
+				goto drop;
+			md = ip_tunnel_info_opts(info);
+		}
+		ttl = info->key.ttl;
+		tos = info->key.tos;
+		label = info->key.label;
+		udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
+	}
+	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
+				     vxlan->cfg.port_max, true);
+
+	rcu_read_lock();
+	if (dst->sa.sa_family == AF_INET) {
+		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		struct rtable *rt;
+		__be16 df = 0;
+
+		if (!ifindex)
+			ifindex = sock4->sock->sk->sk_bound_dev_if;
+
+		rt = vxlan_get_route(vxlan, dev, sock4, skb, ifindex, tos,
+				     dst->sin.sin_addr.s_addr,
+				     &local_ip.sin.sin_addr.s_addr,
+				     dst_port, src_port,
+				     dst_cache, info);
+		if (IS_ERR(rt)) {
+			err = PTR_ERR(rt);
+			goto tx_error;
+		}
+
+		if (!info) {
+			/* Bypass encapsulation if the destination is local */
+			err = encap_bypass_if_local(skb, dev, vxlan, dst,
+						    dst_port, ifindex, vni,
+						    &rt->dst, rt->rt_flags);
+			if (err)
+				goto out_unlock;
+
+			if (vxlan->cfg.df == VXLAN_DF_SET) {
+				df = htons(IP_DF);
+			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
+				struct ethhdr *eth = eth_hdr(skb);
+
+				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
+				    (ntohs(eth->h_proto) == ETH_P_IP &&
+				     old_iph->frag_off & htons(IP_DF)))
+					df = htons(IP_DF);
+			}
+		} else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT) {
+			df = htons(IP_DF);
+		}
+
+		ndst = &rt->dst;
+		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
+					    netif_is_any_bridge_port(dev));
+		if (err < 0) {
+			goto tx_error;
+		} else if (err) {
+			if (info) {
+				struct ip_tunnel_info *unclone;
+				struct in_addr src, dst;
+
+				unclone = skb_tunnel_info_unclone(skb);
+				if (unlikely(!unclone))
+					goto tx_error;
+
+				src = remote_ip.sin.sin_addr;
+				dst = local_ip.sin.sin_addr;
+				unclone->key.u.ipv4.src = src.s_addr;
+				unclone->key.u.ipv4.dst = dst.s_addr;
+			}
+			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			dst_release(ndst);
+			goto out_unlock;
+		}
+
+		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
+		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
+				      vni, md, flags, udp_sum);
+		if (err < 0)
+			goto tx_error;
+
+		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
+				    dst->sin.sin_addr.s_addr, tos, ttl, df,
+				    src_port, dst_port, xnet, !udp_sum);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+
+		if (!ifindex)
+			ifindex = sock6->sock->sk->sk_bound_dev_if;
+
+		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
+					label, &dst->sin6.sin6_addr,
+					&local_ip.sin6.sin6_addr,
+					dst_port, src_port,
+					dst_cache, info);
+		if (IS_ERR(ndst)) {
+			err = PTR_ERR(ndst);
+			ndst = NULL;
+			goto tx_error;
+		}
+
+		if (!info) {
+			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
+
+			err = encap_bypass_if_local(skb, dev, vxlan, dst,
+						    dst_port, ifindex, vni,
+						    ndst, rt6i_flags);
+			if (err)
+				goto out_unlock;
+		}
+
+		err = skb_tunnel_check_pmtu(skb, ndst,
+					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
+					    netif_is_any_bridge_port(dev));
+		if (err < 0) {
+			goto tx_error;
+		} else if (err) {
+			if (info) {
+				struct ip_tunnel_info *unclone;
+				struct in6_addr src, dst;
+
+				unclone = skb_tunnel_info_unclone(skb);
+				if (unlikely(!unclone))
+					goto tx_error;
+
+				src = remote_ip.sin6.sin6_addr;
+				dst = local_ip.sin6.sin6_addr;
+				unclone->key.u.ipv6.src = src;
+				unclone->key.u.ipv6.dst = dst;
+			}
+
+			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			dst_release(ndst);
+			goto out_unlock;
+		}
+
+		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		ttl = ttl ? : ip6_dst_hoplimit(ndst);
+		skb_scrub_packet(skb, xnet);
+		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
+				      vni, md, flags, udp_sum);
+		if (err < 0)
+			goto tx_error;
+
+		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
+				     &local_ip.sin6.sin6_addr,
+				     &dst->sin6.sin6_addr, tos, ttl,
+				     label, src_port, dst_port, !udp_sum);
+#endif
+	}
+out_unlock:
+	rcu_read_unlock();
+	return;
+
+drop:
+	dev->stats.tx_dropped++;
+	dev_kfree_skb(skb);
+	return;
+
+tx_error:
+	rcu_read_unlock();
+	if (err == -ELOOP)
+		dev->stats.collisions++;
+	else if (err == -ENETUNREACH)
+		dev->stats.tx_carrier_errors++;
+	dst_release(ndst);
+	dev->stats.tx_errors++;
+	kfree_skb(skb);
+}
+
+static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
+			  struct vxlan_fdb *f, __be32 vni, bool did_rsc)
+{
+	struct vxlan_rdst nh_rdst;
+	struct nexthop *nh;
+	bool do_xmit;
+	u32 hash;
+
+	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
+	hash = skb_get_hash(skb);
+
+	rcu_read_lock();
+	nh = rcu_dereference(f->nh);
+	if (!nh) {
+		rcu_read_unlock();
+		goto drop;
+	}
+	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
+	rcu_read_unlock();
+
+	if (likely(do_xmit))
+		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
+	else
+		goto drop;
+
+	return;
+
+drop:
+	dev->stats.tx_dropped++;
+	dev_kfree_skb(skb);
+}
+
+/* Transmit local packets over Vxlan
+ *
+ * Outer IP header inherits ECN and DF from inner header.
+ * Outer UDP destination is the VXLAN assigned port.
+ *           source port is based on hash of flow
+ */
+static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *rdst, *fdst = NULL;
+	const struct ip_tunnel_info *info;
+	bool did_rsc = false;
+	struct vxlan_fdb *f;
+	struct ethhdr *eth;
+	__be32 vni = 0;
+
+	info = skb_tunnel_info(skb);
+
+	skb_reset_mac_header(skb);
+
+	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
+		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
+		    info->mode & IP_TUNNEL_INFO_TX) {
+			vni = tunnel_id_to_key32(info->key.tun_id);
+		} else {
+			if (info && info->mode & IP_TUNNEL_INFO_TX)
+				vxlan_xmit_one(skb, dev, vni, NULL, false);
+			else
+				kfree_skb(skb);
+			return NETDEV_TX_OK;
+		}
+	}
+
+	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
+		eth = eth_hdr(skb);
+		if (ntohs(eth->h_proto) == ETH_P_ARP)
+			return arp_reduce(dev, skb, vni);
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
+			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
+					    sizeof(struct nd_msg)) &&
+			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
+			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
+
+			if (m->icmph.icmp6_code == 0 &&
+			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
+				return neigh_reduce(dev, skb, vni);
+		}
+#endif
+	}
+
+	eth = eth_hdr(skb);
+	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+	did_rsc = false;
+
+	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
+	    (ntohs(eth->h_proto) == ETH_P_IP ||
+	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
+		did_rsc = route_shortcircuit(dev, skb);
+		if (did_rsc)
+			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+	}
+
+	if (f == NULL) {
+		f = vxlan_find_mac(vxlan, all_zeros_mac, vni);
+		if (f == NULL) {
+			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
+			    !is_multicast_ether_addr(eth->h_dest))
+				vxlan_fdb_miss(vxlan, eth->h_dest);
+
+			dev->stats.tx_dropped++;
+			kfree_skb(skb);
+			return NETDEV_TX_OK;
+		}
+	}
+
+	if (rcu_access_pointer(f->nh)) {
+		vxlan_xmit_nh(skb, dev, f,
+			      (vni ? : vxlan->default_dst.remote_vni), did_rsc);
+	} else {
+		list_for_each_entry_rcu(rdst, &f->remotes, list) {
+			struct sk_buff *skb1;
+
+			if (!fdst) {
+				fdst = rdst;
+				continue;
+			}
+			skb1 = skb_clone(skb, GFP_ATOMIC);
+			if (skb1)
+				vxlan_xmit_one(skb1, dev, vni, rdst, did_rsc);
+		}
+		if (fdst)
+			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
+		else
+			kfree_skb(skb);
+	}
+
+	return NETDEV_TX_OK;
+}
+
+/* Walk the forwarding table and purge stale entries */
+static void vxlan_cleanup(struct timer_list *t)
+{
+	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
+	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
+	unsigned int h;
+
+	if (!netif_running(vxlan->dev))
+		return;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		struct hlist_node *p, *n;
+
+		spin_lock(&vxlan->hash_lock[h]);
+		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
+			struct vxlan_fdb *f
+				= container_of(p, struct vxlan_fdb, hlist);
+			unsigned long timeout;
+
+			if (f->state & (NUD_PERMANENT | NUD_NOARP))
+				continue;
+
+			if (f->flags & NTF_EXT_LEARNED)
+				continue;
+
+			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			if (time_before_eq(timeout, jiffies)) {
+				netdev_dbg(vxlan->dev,
+					   "garbage collect %pM\n",
+					   f->eth_addr);
+				f->state = NUD_STALE;
+				vxlan_fdb_destroy(vxlan, f, true, true);
+			} else if (time_before(timeout, next_timer))
+				next_timer = timeout;
+		}
+		spin_unlock(&vxlan->hash_lock[h]);
+	}
+
+	mod_timer(&vxlan->age_timer, next_timer);
+}
+
+static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
+{
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+
+	spin_lock(&vn->sock_lock);
+	hlist_del_init_rcu(&vxlan->hlist4.hlist);
+#if IS_ENABLED(CONFIG_IPV6)
+	hlist_del_init_rcu(&vxlan->hlist6.hlist);
+#endif
+	spin_unlock(&vn->sock_lock);
+}
+
+static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
+			     struct vxlan_dev_node *node)
+{
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	__be32 vni = vxlan->default_dst.remote_vni;
+
+	node->vxlan = vxlan;
+	spin_lock(&vn->sock_lock);
+	hlist_add_head_rcu(&node->hlist, vni_head(vs, vni));
+	spin_unlock(&vn->sock_lock);
+}
+
+/* Setup stats when device is created */
+static int vxlan_init(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err;
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
+
+	err = gro_cells_init(&vxlan->gro_cells, dev);
+	if (err) {
+		free_percpu(dev->tstats);
+		return err;
+	}
+
+	return 0;
+}
+
+static void vxlan_fdb_delete_default(struct vxlan_dev *vxlan, __be32 vni)
+{
+	struct vxlan_fdb *f;
+	u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, vni);
+
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	f = __vxlan_find_mac(vxlan, all_zeros_mac, vni);
+	if (f)
+		vxlan_fdb_destroy(vxlan, f, true, true);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+}
+
+static void vxlan_uninit(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	gro_cells_destroy(&vxlan->gro_cells);
+
+	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
+
+	free_percpu(dev->tstats);
+}
+
+/* Start ageing timer and join group when device is brought up */
+static int vxlan_open(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int ret;
+
+	ret = vxlan_sock_add(vxlan);
+	if (ret < 0)
+		return ret;
+
+	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
+		ret = vxlan_igmp_join(vxlan);
+		if (ret == -EADDRINUSE)
+			ret = 0;
+		if (ret) {
+			vxlan_sock_release(vxlan);
+			return ret;
+		}
+	}
+
+	if (vxlan->cfg.age_interval)
+		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
+
+	return ret;
+}
+
+/* Purge the forwarding table */
+static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
+{
+	unsigned int h;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		struct hlist_node *p, *n;
+
+		spin_lock_bh(&vxlan->hash_lock[h]);
+		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
+			struct vxlan_fdb *f
+				= container_of(p, struct vxlan_fdb, hlist);
+			if (!do_all && (f->state & (NUD_PERMANENT | NUD_NOARP)))
+				continue;
+			/* the all_zeros_mac entry is deleted at vxlan_uninit */
+			if (is_zero_ether_addr(f->eth_addr) &&
+			    f->vni == vxlan->cfg.vni)
+				continue;
+			vxlan_fdb_destroy(vxlan, f, true, true);
+		}
+		spin_unlock_bh(&vxlan->hash_lock[h]);
+	}
+}
+
+/* Cleanup timer and forwarding table on shutdown */
+static int vxlan_stop(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	int ret = 0;
+
+	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
+	    !vxlan_group_used(vn, vxlan))
+		ret = vxlan_igmp_leave(vxlan);
+
+	del_timer_sync(&vxlan->age_timer);
+
+	vxlan_flush(vxlan, false);
+	vxlan_sock_release(vxlan);
+
+	return ret;
+}
+
+/* Stub, nothing needs to be done. */
+static void vxlan_set_multicast_list(struct net_device *dev)
+{
+}
+
+static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
+							 dst->remote_ifindex);
+
+	/* This check is different than dev->max_mtu, because it looks at
+	 * the lowerdev->mtu, rather than the static dev->max_mtu
+	 */
+	if (lowerdev) {
+		int max_mtu = lowerdev->mtu - vxlan_headroom(vxlan->cfg.flags);
+		if (new_mtu > max_mtu)
+			return -EINVAL;
+	}
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct ip_tunnel_info *info = skb_tunnel_info(skb);
+	__be16 sport, dport;
+
+	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
+				  vxlan->cfg.port_max, true);
+	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
+
+	if (ip_tunnel_info_af(info) == AF_INET) {
+		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		struct rtable *rt;
+
+		rt = vxlan_get_route(vxlan, dev, sock4, skb, 0, info->key.tos,
+				     info->key.u.ipv4.dst,
+				     &info->key.u.ipv4.src, dport, sport,
+				     &info->dst_cache, info);
+		if (IS_ERR(rt))
+			return PTR_ERR(rt);
+		ip_rt_put(rt);
+	} else {
+#if IS_ENABLED(CONFIG_IPV6)
+		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+		struct dst_entry *ndst;
+
+		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, 0, info->key.tos,
+					info->key.label, &info->key.u.ipv6.dst,
+					&info->key.u.ipv6.src, dport, sport,
+					&info->dst_cache, info);
+		if (IS_ERR(ndst))
+			return PTR_ERR(ndst);
+		dst_release(ndst);
+#else /* !CONFIG_IPV6 */
+		return -EPFNOSUPPORT;
+#endif
+	}
+	info->key.tp_src = sport;
+	info->key.tp_dst = dport;
+	return 0;
+}
+
+static const struct net_device_ops vxlan_netdev_ether_ops = {
+	.ndo_init		= vxlan_init,
+	.ndo_uninit		= vxlan_uninit,
+	.ndo_open		= vxlan_open,
+	.ndo_stop		= vxlan_stop,
+	.ndo_start_xmit		= vxlan_xmit,
+	.ndo_get_stats64	= ip_tunnel_get_stats64,
+	.ndo_set_rx_mode	= vxlan_set_multicast_list,
+	.ndo_change_mtu		= vxlan_change_mtu,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_fdb_add		= vxlan_fdb_add,
+	.ndo_fdb_del		= vxlan_fdb_delete,
+	.ndo_fdb_dump		= vxlan_fdb_dump,
+	.ndo_fdb_get		= vxlan_fdb_get,
+	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
+	.ndo_change_proto_down  = dev_change_proto_down_generic,
+};
+
+static const struct net_device_ops vxlan_netdev_raw_ops = {
+	.ndo_init		= vxlan_init,
+	.ndo_uninit		= vxlan_uninit,
+	.ndo_open		= vxlan_open,
+	.ndo_stop		= vxlan_stop,
+	.ndo_start_xmit		= vxlan_xmit,
+	.ndo_get_stats64	= ip_tunnel_get_stats64,
+	.ndo_change_mtu		= vxlan_change_mtu,
+	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
+};
+
+/* Info for udev, that this is a virtual tunnel endpoint */
+static struct device_type vxlan_type = {
+	.name = "vxlan",
+};
+
+/* Calls the ndo_udp_tunnel_add of the caller in order to
+ * supply the listening VXLAN udp ports. Callers are expected
+ * to implement the ndo_udp_tunnel_add.
+ */
+static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
+{
+	struct vxlan_sock *vs;
+	struct net *net = dev_net(dev);
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	unsigned int i;
+
+	spin_lock(&vn->sock_lock);
+	for (i = 0; i < PORT_HASH_SIZE; ++i) {
+		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
+			unsigned short type;
+
+			if (vs->flags & VXLAN_F_GPE)
+				type = UDP_TUNNEL_TYPE_VXLAN_GPE;
+			else
+				type = UDP_TUNNEL_TYPE_VXLAN;
+
+			if (push)
+				udp_tunnel_push_rx_port(dev, vs->sock, type);
+			else
+				udp_tunnel_drop_rx_port(dev, vs->sock, type);
+		}
+	}
+	spin_unlock(&vn->sock_lock);
+}
+
+/* Initialize the device structure. */
+static void vxlan_setup(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	unsigned int h;
+
+	eth_hw_addr_random(dev);
+	ether_setup(dev);
+
+	dev->needs_free_netdev = true;
+	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
+
+	dev->features	|= NETIF_F_LLTX;
+	dev->features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
+	dev->features   |= NETIF_F_RXCSUM;
+	dev->features   |= NETIF_F_GSO_SOFTWARE;
+
+	dev->vlan_features = dev->features;
+	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+	netif_keep_dst(dev);
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	/* MTU range: 68 - 65535 */
+	dev->min_mtu = ETH_MIN_MTU;
+	dev->max_mtu = ETH_MAX_MTU;
+
+	INIT_LIST_HEAD(&vxlan->next);
+
+	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
+
+	vxlan->dev = dev;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		spin_lock_init(&vxlan->hash_lock[h]);
+		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
+	}
+}
+
+static void vxlan_ether_setup(struct net_device *dev)
+{
+	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->netdev_ops = &vxlan_netdev_ether_ops;
+}
+
+static void vxlan_raw_setup(struct net_device *dev)
+{
+	dev->header_ops = NULL;
+	dev->type = ARPHRD_NONE;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
+	dev->netdev_ops = &vxlan_netdev_raw_ops;
+}
+
+static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
+	[IFLA_VXLAN_ID]		= { .type = NLA_U32 },
+	[IFLA_VXLAN_GROUP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_VXLAN_GROUP6]	= { .len = sizeof(struct in6_addr) },
+	[IFLA_VXLAN_LINK]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_LOCAL]	= { .len = sizeof_field(struct iphdr, saddr) },
+	[IFLA_VXLAN_LOCAL6]	= { .len = sizeof(struct in6_addr) },
+	[IFLA_VXLAN_TOS]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_TTL]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_LABEL]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_LEARNING]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_AGEING]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_LIMIT]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_PORT_RANGE] = { .len  = sizeof(struct ifla_vxlan_port_range) },
+	[IFLA_VXLAN_PROXY]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_RSC]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_L2MISS]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_L3MISS]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_COLLECT_METADATA]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_PORT]	= { .type = NLA_U16 },
+	[IFLA_VXLAN_UDP_CSUM]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_REMCSUM_TX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_REMCSUM_RX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_GBP]	= { .type = NLA_FLAG, },
+	[IFLA_VXLAN_GPE]	= { .type = NLA_FLAG, },
+	[IFLA_VXLAN_REMCSUM_NOPARTIAL]	= { .type = NLA_FLAG },
+	[IFLA_VXLAN_TTL_INHERIT]	= { .type = NLA_FLAG },
+	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
+};
+
+static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
+			  struct netlink_ext_ack *extack)
+{
+	if (tb[IFLA_ADDRESS]) {
+		if (nla_len(tb[IFLA_ADDRESS]) != ETH_ALEN) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
+					    "Provided link layer address is not Ethernet");
+			return -EINVAL;
+		}
+
+		if (!is_valid_ether_addr(nla_data(tb[IFLA_ADDRESS]))) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
+					    "Provided Ethernet address is not unicast");
+			return -EADDRNOTAVAIL;
+		}
+	}
+
+	if (tb[IFLA_MTU]) {
+		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
+
+		if (mtu < ETH_MIN_MTU || mtu > ETH_MAX_MTU) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
+					    "MTU must be between 68 and 65535");
+			return -EINVAL;
+		}
+	}
+
+	if (!data) {
+		NL_SET_ERR_MSG(extack,
+			       "Required attributes not provided to perform the operation");
+		return -EINVAL;
+	}
+
+	if (data[IFLA_VXLAN_ID]) {
+		u32 id = nla_get_u32(data[IFLA_VXLAN_ID]);
+
+		if (id >= VXLAN_N_VID) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_ID],
+					    "VXLAN ID must be lower than 16777216");
+			return -ERANGE;
+		}
+	}
+
+	if (data[IFLA_VXLAN_PORT_RANGE]) {
+		const struct ifla_vxlan_port_range *p
+			= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
+
+		if (ntohs(p->high) < ntohs(p->low)) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_PORT_RANGE],
+					    "Invalid source port range");
+			return -EINVAL;
+		}
+	}
+
+	if (data[IFLA_VXLAN_DF]) {
+		enum ifla_vxlan_df df = nla_get_u8(data[IFLA_VXLAN_DF]);
+
+		if (df < 0 || df > VXLAN_DF_MAX) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_DF],
+					    "Invalid DF attribute");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void vxlan_get_drvinfo(struct net_device *netdev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	strlcpy(drvinfo->version, VXLAN_VERSION, sizeof(drvinfo->version));
+	strlcpy(drvinfo->driver, "vxlan", sizeof(drvinfo->driver));
+}
+
+static int vxlan_get_link_ksettings(struct net_device *dev,
+				    struct ethtool_link_ksettings *cmd)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
+							 dst->remote_ifindex);
+
+	if (!lowerdev) {
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+		cmd->base.port = PORT_OTHER;
+		cmd->base.speed = SPEED_UNKNOWN;
+
+		return 0;
+	}
+
+	return __ethtool_get_link_ksettings(lowerdev, cmd);
+}
+
+static const struct ethtool_ops vxlan_ethtool_ops = {
+	.get_drvinfo		= vxlan_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= vxlan_get_link_ksettings,
+};
+
+static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
+					__be16 port, u32 flags, int ifindex)
+{
+	struct socket *sock;
+	struct udp_port_cfg udp_conf;
+	int err;
+
+	memset(&udp_conf, 0, sizeof(udp_conf));
+
+	if (ipv6) {
+		udp_conf.family = AF_INET6;
+		udp_conf.use_udp6_rx_checksums =
+		    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
+		udp_conf.ipv6_v6only = 1;
+	} else {
+		udp_conf.family = AF_INET;
+	}
+
+	udp_conf.local_udp_port = port;
+	udp_conf.bind_ifindex = ifindex;
+
+	/* Open UDP socket */
+	err = udp_sock_create(net, &udp_conf, &sock);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return sock;
+}
+
+/* Create new listen socket if needed */
+static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
+					      __be16 port, u32 flags,
+					      int ifindex)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_sock *vs;
+	struct socket *sock;
+	unsigned int h;
+	struct udp_tunnel_sock_cfg tunnel_cfg;
+
+	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
+	if (!vs)
+		return ERR_PTR(-ENOMEM);
+
+	for (h = 0; h < VNI_HASH_SIZE; ++h)
+		INIT_HLIST_HEAD(&vs->vni_list[h]);
+
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	if (IS_ERR(sock)) {
+		kfree(vs);
+		return ERR_CAST(sock);
+	}
+
+	vs->sock = sock;
+	refcount_set(&vs->refcnt, 1);
+	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
+
+	spin_lock(&vn->sock_lock);
+	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
+	udp_tunnel_notify_add_rx_port(sock,
+				      (vs->flags & VXLAN_F_GPE) ?
+				      UDP_TUNNEL_TYPE_VXLAN_GPE :
+				      UDP_TUNNEL_TYPE_VXLAN);
+	spin_unlock(&vn->sock_lock);
+
+	/* Mark socket as an encapsulation socket. */
+	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
+	tunnel_cfg.sk_user_data = vs;
+	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_rcv = vxlan_rcv;
+	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
+	tunnel_cfg.encap_destroy = NULL;
+	tunnel_cfg.gro_receive = vxlan_gro_receive;
+	tunnel_cfg.gro_complete = vxlan_gro_complete;
+
+	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
+
+	return vs;
+}
+
+static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
+{
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	struct vxlan_sock *vs = NULL;
+	struct vxlan_dev_node *node;
+	int l3mdev_index = 0;
+
+	if (vxlan->cfg.remote_ifindex)
+		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
+			vxlan->net, vxlan->cfg.remote_ifindex);
+
+	if (!vxlan->cfg.no_share) {
+		spin_lock(&vn->sock_lock);
+		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
+				     vxlan->cfg.dst_port, vxlan->cfg.flags,
+				     l3mdev_index);
+		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
+			spin_unlock(&vn->sock_lock);
+			return -EBUSY;
+		}
+		spin_unlock(&vn->sock_lock);
+	}
+	if (!vs)
+		vs = vxlan_socket_create(vxlan->net, ipv6,
+					 vxlan->cfg.dst_port, vxlan->cfg.flags,
+					 l3mdev_index);
+	if (IS_ERR(vs))
+		return PTR_ERR(vs);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ipv6) {
+		rcu_assign_pointer(vxlan->vn6_sock, vs);
+		node = &vxlan->hlist6;
+	} else
+#endif
+	{
+		rcu_assign_pointer(vxlan->vn4_sock, vs);
+		node = &vxlan->hlist4;
+	}
+	vxlan_vs_add_dev(vs, vxlan, node);
+	return 0;
+}
+
+static int vxlan_sock_add(struct vxlan_dev *vxlan)
+{
+	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
+	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
+	bool ipv4 = !ipv6 || metadata;
+	int ret = 0;
+
+	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
+#if IS_ENABLED(CONFIG_IPV6)
+	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
+	if (ipv6) {
+		ret = __vxlan_sock_add(vxlan, true);
+		if (ret < 0 && ret != -EAFNOSUPPORT)
+			ipv4 = false;
+	}
+#endif
+	if (ipv4)
+		ret = __vxlan_sock_add(vxlan, false);
+	if (ret < 0)
+		vxlan_sock_release(vxlan);
+	return ret;
+}
+
+static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
+				 struct net_device **lower,
+				 struct vxlan_dev *old,
+				 struct netlink_ext_ack *extack)
+{
+	struct vxlan_net *vn = net_generic(src_net, vxlan_net_id);
+	struct vxlan_dev *tmp;
+	bool use_ipv6 = false;
+
+	if (conf->flags & VXLAN_F_GPE) {
+		/* For now, allow GPE only together with
+		 * COLLECT_METADATA. This can be relaxed later; in such
+		 * case, the other side of the PtP link will have to be
+		 * provided.
+		 */
+		if ((conf->flags & ~VXLAN_F_ALLOWED_GPE) ||
+		    !(conf->flags & VXLAN_F_COLLECT_METADATA)) {
+			NL_SET_ERR_MSG(extack,
+				       "VXLAN GPE does not support this combination of attributes");
+			return -EINVAL;
+		}
+	}
+
+	if (!conf->remote_ip.sa.sa_family && !conf->saddr.sa.sa_family) {
+		/* Unless IPv6 is explicitly requested, assume IPv4 */
+		conf->remote_ip.sa.sa_family = AF_INET;
+		conf->saddr.sa.sa_family = AF_INET;
+	} else if (!conf->remote_ip.sa.sa_family) {
+		conf->remote_ip.sa.sa_family = conf->saddr.sa.sa_family;
+	} else if (!conf->saddr.sa.sa_family) {
+		conf->saddr.sa.sa_family = conf->remote_ip.sa.sa_family;
+	}
+
+	if (conf->saddr.sa.sa_family != conf->remote_ip.sa.sa_family) {
+		NL_SET_ERR_MSG(extack,
+			       "Local and remote address must be from the same family");
+		return -EINVAL;
+	}
+
+	if (vxlan_addr_multicast(&conf->saddr)) {
+		NL_SET_ERR_MSG(extack, "Local address cannot be multicast");
+		return -EINVAL;
+	}
+
+	if (conf->saddr.sa.sa_family == AF_INET6) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG(extack,
+				       "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+		use_ipv6 = true;
+		conf->flags |= VXLAN_F_IPV6;
+
+		if (!(conf->flags & VXLAN_F_COLLECT_METADATA)) {
+			int local_type =
+				ipv6_addr_type(&conf->saddr.sin6.sin6_addr);
+			int remote_type =
+				ipv6_addr_type(&conf->remote_ip.sin6.sin6_addr);
+
+			if (local_type & IPV6_ADDR_LINKLOCAL) {
+				if (!(remote_type & IPV6_ADDR_LINKLOCAL) &&
+				    (remote_type != IPV6_ADDR_ANY)) {
+					NL_SET_ERR_MSG(extack,
+						       "Invalid combination of local and remote address scopes");
+					return -EINVAL;
+				}
+
+				conf->flags |= VXLAN_F_IPV6_LINKLOCAL;
+			} else {
+				if (remote_type ==
+				    (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL)) {
+					NL_SET_ERR_MSG(extack,
+						       "Invalid combination of local and remote address scopes");
+					return -EINVAL;
+				}
+
+				conf->flags &= ~VXLAN_F_IPV6_LINKLOCAL;
+			}
+		}
+	}
+
+	if (conf->label && !use_ipv6) {
+		NL_SET_ERR_MSG(extack,
+			       "Label attribute only applies to IPv6 VXLAN devices");
+		return -EINVAL;
+	}
+
+	if (conf->remote_ifindex) {
+		struct net_device *lowerdev;
+
+		lowerdev = __dev_get_by_index(src_net, conf->remote_ifindex);
+		if (!lowerdev) {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid local interface, device not found");
+			return -ENODEV;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (use_ipv6) {
+			struct inet6_dev *idev = __in6_dev_get(lowerdev);
+			if (idev && idev->cnf.disable_ipv6) {
+				NL_SET_ERR_MSG(extack,
+					       "IPv6 support disabled by administrator");
+				return -EPERM;
+			}
+		}
+#endif
+
+		*lower = lowerdev;
+	} else {
+		if (vxlan_addr_multicast(&conf->remote_ip)) {
+			NL_SET_ERR_MSG(extack,
+				       "Local interface required for multicast remote destination");
+
+			return -EINVAL;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (conf->flags & VXLAN_F_IPV6_LINKLOCAL) {
+			NL_SET_ERR_MSG(extack,
+				       "Local interface required for link-local local/remote addresses");
+			return -EINVAL;
+		}
+#endif
+
+		*lower = NULL;
+	}
+
+	if (!conf->dst_port) {
+		if (conf->flags & VXLAN_F_GPE)
+			conf->dst_port = htons(4790); /* IANA VXLAN-GPE port */
+		else
+			conf->dst_port = htons(vxlan_port);
+	}
+
+	if (!conf->age_interval)
+		conf->age_interval = FDB_AGE_DEFAULT;
+
+	list_for_each_entry(tmp, &vn->vxlan_list, next) {
+		if (tmp == old)
+			continue;
+
+		if (tmp->cfg.vni != conf->vni)
+			continue;
+		if (tmp->cfg.dst_port != conf->dst_port)
+			continue;
+		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
+		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
+			continue;
+
+		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
+		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
+			continue;
+
+		NL_SET_ERR_MSG(extack,
+			       "A VXLAN device with the specified VNI already exists");
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+static void vxlan_config_apply(struct net_device *dev,
+			       struct vxlan_config *conf,
+			       struct net_device *lowerdev,
+			       struct net *src_net,
+			       bool changelink)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	unsigned short needed_headroom = ETH_HLEN;
+	int max_mtu = ETH_MAX_MTU;
+	u32 flags = conf->flags;
+
+	if (!changelink) {
+		if (flags & VXLAN_F_GPE)
+			vxlan_raw_setup(dev);
+		else
+			vxlan_ether_setup(dev);
+
+		if (conf->mtu)
+			dev->mtu = conf->mtu;
+
+		vxlan->net = src_net;
+	}
+
+	dst->remote_vni = conf->vni;
+
+	memcpy(&dst->remote_ip, &conf->remote_ip, sizeof(conf->remote_ip));
+
+	if (lowerdev) {
+		dst->remote_ifindex = conf->remote_ifindex;
+
+		dev->gso_max_size = lowerdev->gso_max_size;
+		dev->gso_max_segs = lowerdev->gso_max_segs;
+
+		needed_headroom = lowerdev->hard_header_len;
+		needed_headroom += lowerdev->needed_headroom;
+
+		dev->needed_tailroom = lowerdev->needed_tailroom;
+
+		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
+		if (max_mtu < ETH_MIN_MTU)
+			max_mtu = ETH_MIN_MTU;
+
+		if (!changelink && !conf->mtu)
+			dev->mtu = max_mtu;
+	}
+
+	if (dev->mtu > max_mtu)
+		dev->mtu = max_mtu;
+
+	if (flags & VXLAN_F_COLLECT_METADATA)
+		flags |= VXLAN_F_IPV6;
+	needed_headroom += vxlan_headroom(flags);
+	dev->needed_headroom = needed_headroom;
+
+	memcpy(&vxlan->cfg, conf, sizeof(*conf));
+}
+
+static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
+			       struct vxlan_config *conf, bool changelink,
+			       struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+	int ret;
+
+	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
+	if (ret)
+		return ret;
+
+	vxlan_config_apply(dev, conf, lowerdev, src_net, changelink);
+
+	return 0;
+}
+
+static int __vxlan_dev_create(struct net *net, struct net_device *dev,
+			      struct vxlan_config *conf,
+			      struct netlink_ext_ack *extack)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct net_device *remote_dev = NULL;
+	struct vxlan_fdb *f = NULL;
+	bool unregister = false;
+	struct vxlan_rdst *dst;
+	int err;
+
+	dst = &vxlan->default_dst;
+	err = vxlan_dev_configure(net, dev, conf, false, extack);
+	if (err)
+		return err;
+
+	dev->ethtool_ops = &vxlan_ethtool_ops;
+
+	/* create an fdb entry for a valid default destination */
+	if (!vxlan_addr_any(&dst->remote_ip)) {
+		err = vxlan_fdb_create(vxlan, all_zeros_mac,
+				       &dst->remote_ip,
+				       NUD_REACHABLE | NUD_PERMANENT,
+				       vxlan->cfg.dst_port,
+				       dst->remote_vni,
+				       dst->remote_vni,
+				       dst->remote_ifindex,
+				       NTF_SELF, 0, &f, extack);
+		if (err)
+			return err;
+	}
+
+	err = register_netdevice(dev);
+	if (err)
+		goto errout;
+	unregister = true;
+
+	if (dst->remote_ifindex) {
+		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
+		if (!remote_dev) {
+			err = -ENODEV;
+			goto errout;
+		}
+
+		err = netdev_upper_dev_link(remote_dev, dev, extack);
+		if (err)
+			goto errout;
+	}
+
+	err = rtnl_configure_link(dev, NULL);
+	if (err < 0)
+		goto unlink;
+
+	if (f) {
+		vxlan_fdb_insert(vxlan, all_zeros_mac, dst->remote_vni, f);
+
+		/* notify default fdb entry */
+		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
+				       RTM_NEWNEIGH, true, extack);
+		if (err) {
+			vxlan_fdb_destroy(vxlan, f, false, false);
+			if (remote_dev)
+				netdev_upper_dev_unlink(remote_dev, dev);
+			goto unregister;
+		}
+	}
+
+	list_add(&vxlan->next, &vn->vxlan_list);
+	if (remote_dev)
+		dst->remote_dev = remote_dev;
+	return 0;
+unlink:
+	if (remote_dev)
+		netdev_upper_dev_unlink(remote_dev, dev);
+errout:
+	/* unregister_netdevice() destroys the default FDB entry with deletion
+	 * notification. But the addition notification was not sent yet, so
+	 * destroy the entry by hand here.
+	 */
+	if (f)
+		__vxlan_fdb_free(f);
+unregister:
+	if (unregister)
+		unregister_netdevice(dev);
+	return err;
+}
+
+/* Set/clear flags based on attribute */
+static int vxlan_nl2flag(struct vxlan_config *conf, struct nlattr *tb[],
+			  int attrtype, unsigned long mask, bool changelink,
+			  bool changelink_supported,
+			  struct netlink_ext_ack *extack)
+{
+	unsigned long flags;
+
+	if (!tb[attrtype])
+		return 0;
+
+	if (changelink && !changelink_supported) {
+		vxlan_flag_attr_error(attrtype, extack);
+		return -EOPNOTSUPP;
+	}
+
+	if (vxlan_policy[attrtype].type == NLA_FLAG)
+		flags = conf->flags | mask;
+	else if (nla_get_u8(tb[attrtype]))
+		flags = conf->flags | mask;
+	else
+		flags = conf->flags & ~mask;
+
+	conf->flags = flags;
+
+	return 0;
+}
+
+static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
+			 struct net_device *dev, struct vxlan_config *conf,
+			 bool changelink, struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err = 0;
+
+	memset(conf, 0, sizeof(*conf));
+
+	/* if changelink operation, start with old existing cfg */
+	if (changelink)
+		memcpy(conf, &vxlan->cfg, sizeof(*conf));
+
+	if (data[IFLA_VXLAN_ID]) {
+		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
+
+		if (changelink && (vni != conf->vni)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
+			return -EOPNOTSUPP;
+		}
+		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
+	}
+
+	if (data[IFLA_VXLAN_GROUP]) {
+		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
+			return -EOPNOTSUPP;
+		}
+
+		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
+		conf->remote_ip.sa.sa_family = AF_INET;
+	} else if (data[IFLA_VXLAN_GROUP6]) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+
+		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "New group address family does not match old group");
+			return -EOPNOTSUPP;
+		}
+
+		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
+		conf->remote_ip.sa.sa_family = AF_INET6;
+	}
+
+	if (data[IFLA_VXLAN_LOCAL]) {
+		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
+		conf->saddr.sa.sa_family = AF_INET;
+	} else if (data[IFLA_VXLAN_LOCAL6]) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+
+		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		/* TODO: respect scope id */
+		conf->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_LOCAL6]);
+		conf->saddr.sa.sa_family = AF_INET6;
+	}
+
+	if (data[IFLA_VXLAN_LINK])
+		conf->remote_ifindex = nla_get_u32(data[IFLA_VXLAN_LINK]);
+
+	if (data[IFLA_VXLAN_TOS])
+		conf->tos  = nla_get_u8(data[IFLA_VXLAN_TOS]);
+
+	if (data[IFLA_VXLAN_TTL])
+		conf->ttl = nla_get_u8(data[IFLA_VXLAN_TTL]);
+
+	if (data[IFLA_VXLAN_TTL_INHERIT]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_TTL_INHERIT,
+				    VXLAN_F_TTL_INHERIT, changelink, false,
+				    extack);
+		if (err)
+			return err;
+
+	}
+
+	if (data[IFLA_VXLAN_LABEL])
+		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
+			     IPV6_FLOWLABEL_MASK;
+
+	if (data[IFLA_VXLAN_LEARNING]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
+				    VXLAN_F_LEARN, changelink, true,
+				    extack);
+		if (err)
+			return err;
+	} else if (!changelink) {
+		/* default to learn on a new device */
+		conf->flags |= VXLAN_F_LEARN;
+	}
+
+	if (data[IFLA_VXLAN_AGEING])
+		conf->age_interval = nla_get_u32(data[IFLA_VXLAN_AGEING]);
+
+	if (data[IFLA_VXLAN_PROXY]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_PROXY,
+				    VXLAN_F_PROXY, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_RSC]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_RSC,
+				    VXLAN_F_RSC, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_L2MISS]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L2MISS,
+				    VXLAN_F_L2MISS, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_L3MISS]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L3MISS,
+				    VXLAN_F_L3MISS, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_LIMIT]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LIMIT],
+					    "Cannot change limit");
+			return -EOPNOTSUPP;
+		}
+		conf->addrmax = nla_get_u32(data[IFLA_VXLAN_LIMIT]);
+	}
+
+	if (data[IFLA_VXLAN_COLLECT_METADATA]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_COLLECT_METADATA,
+				    VXLAN_F_COLLECT_METADATA, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_PORT_RANGE]) {
+		if (!changelink) {
+			const struct ifla_vxlan_port_range *p
+				= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
+			conf->port_min = ntohs(p->low);
+			conf->port_max = ntohs(p->high);
+		} else {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT_RANGE],
+					    "Cannot change port range");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (data[IFLA_VXLAN_PORT]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT],
+					    "Cannot change port");
+			return -EOPNOTSUPP;
+		}
+		conf->dst_port = nla_get_be16(data[IFLA_VXLAN_PORT]);
+	}
+
+	if (data[IFLA_VXLAN_UDP_CSUM]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_UDP_CSUM],
+					    "Cannot change UDP_CSUM flag");
+			return -EOPNOTSUPP;
+		}
+		if (!nla_get_u8(data[IFLA_VXLAN_UDP_CSUM]))
+			conf->flags |= VXLAN_F_UDP_ZERO_CSUM_TX;
+	}
+
+	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
+				    VXLAN_F_UDP_ZERO_CSUM6_TX, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
+				    VXLAN_F_UDP_ZERO_CSUM6_RX, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_REMCSUM_TX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_TX,
+				    VXLAN_F_REMCSUM_TX, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_REMCSUM_RX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_RX,
+				    VXLAN_F_REMCSUM_RX, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_GBP]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GBP,
+				    VXLAN_F_GBP, changelink, false, extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_GPE]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GPE,
+				    VXLAN_F_GPE, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
+				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
+	if (tb[IFLA_MTU]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
+					    "Cannot change mtu");
+			return -EOPNOTSUPP;
+		}
+		conf->mtu = nla_get_u32(tb[IFLA_MTU]);
+	}
+
+	if (data[IFLA_VXLAN_DF])
+		conf->df = nla_get_u8(data[IFLA_VXLAN_DF]);
+
+	return 0;
+}
+
+static int vxlan_newlink(struct net *src_net, struct net_device *dev,
+			 struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
+{
+	struct vxlan_config conf;
+	int err;
+
+	err = vxlan_nl2conf(tb, data, dev, &conf, false, extack);
+	if (err)
+		return err;
+
+	return __vxlan_dev_create(src_net, dev, &conf, extack);
+}
+
+static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
+			    struct nlattr *data[],
+			    struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+	struct vxlan_config conf;
+	struct vxlan_rdst *dst;
+	int err;
+
+	dst = &vxlan->default_dst;
+	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
+	if (err)
+		return err;
+
+	err = vxlan_config_validate(vxlan->net, &conf, &lowerdev,
+				    vxlan, extack);
+	if (err)
+		return err;
+
+	if (dst->remote_dev == lowerdev)
+		lowerdev = NULL;
+
+	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
+					     extack);
+	if (err)
+		return err;
+
+	/* handle default dst entry */
+	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
+		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
+
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		if (!vxlan_addr_any(&conf.remote_ip)) {
+			err = vxlan_fdb_update(vxlan, all_zeros_mac,
+					       &conf.remote_ip,
+					       NUD_REACHABLE | NUD_PERMANENT,
+					       NLM_F_APPEND | NLM_F_CREATE,
+					       vxlan->cfg.dst_port,
+					       conf.vni, conf.vni,
+					       conf.remote_ifindex,
+					       NTF_SELF, 0, true, extack);
+			if (err) {
+				spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+				netdev_adjacent_change_abort(dst->remote_dev,
+							     lowerdev, dev);
+				return err;
+			}
+		}
+		if (!vxlan_addr_any(&dst->remote_ip))
+			__vxlan_fdb_delete(vxlan, all_zeros_mac,
+					   dst->remote_ip,
+					   vxlan->cfg.dst_port,
+					   dst->remote_vni,
+					   dst->remote_vni,
+					   dst->remote_ifindex,
+					   true);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
+
+	if (conf.age_interval != vxlan->cfg.age_interval)
+		mod_timer(&vxlan->age_timer, jiffies);
+
+	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
+	if (lowerdev && lowerdev != dst->remote_dev)
+		dst->remote_dev = lowerdev;
+	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
+	return 0;
+}
+
+static void vxlan_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	vxlan_flush(vxlan, true);
+
+	list_del(&vxlan->next);
+	unregister_netdevice_queue(dev, head);
+	if (vxlan->default_dst.remote_dev)
+		netdev_upper_dev_unlink(vxlan->default_dst.remote_dev, dev);
+}
+
+static size_t vxlan_get_size(const struct net_device *dev)
+{
+
+	return nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_ID */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_GROUP{6} */
+		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LINK */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_LOCAL{6} */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL_INHERIT */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
+		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L2MISS */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L3MISS */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_COLLECT_METADATA */
+		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_AGEING */
+		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LIMIT */
+		nla_total_size(sizeof(struct ifla_vxlan_port_range)) +
+		nla_total_size(sizeof(__be16)) + /* IFLA_VXLAN_PORT */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_CSUM */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_TX */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_RX */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
+		0;
+}
+
+static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	const struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct ifla_vxlan_port_range ports = {
+		.low =  htons(vxlan->cfg.port_min),
+		.high = htons(vxlan->cfg.port_max),
+	};
+
+	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
+		goto nla_put_failure;
+
+	if (!vxlan_addr_any(&dst->remote_ip)) {
+		if (dst->remote_ip.sa.sa_family == AF_INET) {
+			if (nla_put_in_addr(skb, IFLA_VXLAN_GROUP,
+					    dst->remote_ip.sin.sin_addr.s_addr))
+				goto nla_put_failure;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			if (nla_put_in6_addr(skb, IFLA_VXLAN_GROUP6,
+					     &dst->remote_ip.sin6.sin6_addr))
+				goto nla_put_failure;
+#endif
+		}
+	}
+
+	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
+		goto nla_put_failure;
+
+	if (!vxlan_addr_any(&vxlan->cfg.saddr)) {
+		if (vxlan->cfg.saddr.sa.sa_family == AF_INET) {
+			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
+					    vxlan->cfg.saddr.sin.sin_addr.s_addr))
+				goto nla_put_failure;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
+					     &vxlan->cfg.saddr.sin6.sin6_addr))
+				goto nla_put_failure;
+#endif
+		}
+	}
+
+	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
+		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
+	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
+	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
+	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
+		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
+		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_RSC,
+		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
+		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
+		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
+		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
+	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
+	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
+	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
+	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
+		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
+		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
+		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
+		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
+		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)))
+		goto nla_put_failure;
+
+	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
+		goto nla_put_failure;
+
+	if (vxlan->cfg.flags & VXLAN_F_GBP &&
+	    nla_put_flag(skb, IFLA_VXLAN_GBP))
+		goto nla_put_failure;
+
+	if (vxlan->cfg.flags & VXLAN_F_GPE &&
+	    nla_put_flag(skb, IFLA_VXLAN_GPE))
+		goto nla_put_failure;
+
+	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_NOPARTIAL &&
+	    nla_put_flag(skb, IFLA_VXLAN_REMCSUM_NOPARTIAL))
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+static struct net *vxlan_get_link_net(const struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	return vxlan->net;
+}
+
+static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
+	.kind		= "vxlan",
+	.maxtype	= IFLA_VXLAN_MAX,
+	.policy		= vxlan_policy,
+	.priv_size	= sizeof(struct vxlan_dev),
+	.setup		= vxlan_setup,
+	.validate	= vxlan_validate,
+	.newlink	= vxlan_newlink,
+	.changelink	= vxlan_changelink,
+	.dellink	= vxlan_dellink,
+	.get_size	= vxlan_get_size,
+	.fill_info	= vxlan_fill_info,
+	.get_link_net	= vxlan_get_link_net,
+};
+
+struct net_device *vxlan_dev_create(struct net *net, const char *name,
+				    u8 name_assign_type,
+				    struct vxlan_config *conf)
+{
+	struct nlattr *tb[IFLA_MAX + 1];
+	struct net_device *dev;
+	int err;
+
+	memset(&tb, 0, sizeof(tb));
+
+	dev = rtnl_create_link(net, name, name_assign_type,
+			       &vxlan_link_ops, tb, NULL);
+	if (IS_ERR(dev))
+		return dev;
+
+	err = __vxlan_dev_create(net, dev, conf, NULL);
+	if (err < 0) {
+		free_netdev(dev);
+		return ERR_PTR(err);
+	}
+
+	err = rtnl_configure_link(dev, NULL);
+	if (err < 0) {
+		LIST_HEAD(list_kill);
+
+		vxlan_dellink(dev, &list_kill);
+		unregister_netdevice_many(&list_kill);
+		return ERR_PTR(err);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(vxlan_dev_create);
+
+static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
+					     struct net_device *dev)
+{
+	struct vxlan_dev *vxlan, *next;
+	LIST_HEAD(list_kill);
+
+	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
+		struct vxlan_rdst *dst = &vxlan->default_dst;
+
+		/* In case we created vxlan device with carrier
+		 * and we loose the carrier due to module unload
+		 * we also need to remove vxlan device. In other
+		 * cases, it's not necessary and remote_ifindex
+		 * is 0 here, so no matches.
+		 */
+		if (dst->remote_ifindex == dev->ifindex)
+			vxlan_dellink(vxlan->dev, &list_kill);
+	}
+
+	unregister_netdevice_many(&list_kill);
+}
+
+static int vxlan_netdevice_event(struct notifier_block *unused,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct vxlan_net *vn = net_generic(dev_net(dev), vxlan_net_id);
+
+	if (event == NETDEV_UNREGISTER) {
+		if (!dev->udp_tunnel_nic_info)
+			vxlan_offload_rx_ports(dev, false);
+		vxlan_handle_lowerdev_unregister(vn, dev);
+	} else if (event == NETDEV_REGISTER) {
+		if (!dev->udp_tunnel_nic_info)
+			vxlan_offload_rx_ports(dev, true);
+	} else if (event == NETDEV_UDP_TUNNEL_PUSH_INFO ||
+		   event == NETDEV_UDP_TUNNEL_DROP_INFO) {
+		vxlan_offload_rx_ports(dev, event == NETDEV_UDP_TUNNEL_PUSH_INFO);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vxlan_notifier_block __read_mostly = {
+	.notifier_call = vxlan_netdevice_event,
+};
+
+static void
+vxlan_fdb_offloaded_set(struct net_device *dev,
+			struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	u32 hash_index;
+
+	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
+
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+
+	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	if (!f)
+		goto out;
+
+	rdst = vxlan_fdb_find_rdst(f, &fdb_info->remote_ip,
+				   fdb_info->remote_port,
+				   fdb_info->remote_vni,
+				   fdb_info->remote_ifindex);
+	if (!rdst)
+		goto out;
+
+	rdst->offloaded = fdb_info->offloaded;
+
+out:
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+}
+
+static int
+vxlan_fdb_external_learn_add(struct net_device *dev,
+			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct netlink_ext_ack *extack;
+	u32 hash_index;
+	int err;
+
+	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	extack = switchdev_notifier_info_to_extack(&fdb_info->info);
+
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	err = vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
+			       NUD_REACHABLE,
+			       NLM_F_CREATE | NLM_F_REPLACE,
+			       fdb_info->remote_port,
+			       fdb_info->vni,
+			       fdb_info->remote_vni,
+			       fdb_info->remote_ifindex,
+			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
+			       0, false, extack);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+static int
+vxlan_fdb_external_learn_del(struct net_device *dev,
+			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f;
+	u32 hash_index;
+	int err = 0;
+
+	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+
+	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	if (!f)
+		err = -ENOENT;
+	else if (f->flags & NTF_EXT_LEARNED)
+		err = __vxlan_fdb_delete(vxlan, fdb_info->eth_addr,
+					 fdb_info->remote_ip,
+					 fdb_info->remote_port,
+					 fdb_info->vni,
+					 fdb_info->remote_vni,
+					 fdb_info->remote_ifindex,
+					 false);
+
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+static int vxlan_switchdev_event(struct notifier_block *unused,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_vxlan_fdb_info *fdb_info;
+	int err = 0;
+
+	switch (event) {
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		vxlan_fdb_offloaded_set(dev, ptr);
+		break;
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+		fdb_info = ptr;
+		err = vxlan_fdb_external_learn_add(dev, fdb_info);
+		if (err) {
+			err = notifier_from_errno(err);
+			break;
+		}
+		fdb_info->offloaded = true;
+		vxlan_fdb_offloaded_set(dev, fdb_info);
+		break;
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+		fdb_info = ptr;
+		err = vxlan_fdb_external_learn_del(dev, fdb_info);
+		if (err) {
+			err = notifier_from_errno(err);
+			break;
+		}
+		fdb_info->offloaded = false;
+		vxlan_fdb_offloaded_set(dev, fdb_info);
+		break;
+	}
+
+	return err;
+}
+
+static struct notifier_block vxlan_switchdev_notifier_block __read_mostly = {
+	.notifier_call = vxlan_switchdev_event,
+};
+
+static void vxlan_fdb_nh_flush(struct nexthop *nh)
+{
+	struct vxlan_fdb *fdb;
+	struct vxlan_dev *vxlan;
+	u32 hash_index;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(fdb, &nh->fdb_list, nh_list) {
+		vxlan = rcu_dereference(fdb->vdev);
+		WARN_ON(!vxlan);
+		hash_index = fdb_head_index(vxlan, fdb->eth_addr,
+					    vxlan->default_dst.remote_vni);
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		if (!hlist_unhashed(&fdb->hlist))
+			vxlan_fdb_destroy(vxlan, fdb, false, false);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
+	rcu_read_unlock();
+}
+
+static int vxlan_nexthop_event(struct notifier_block *nb,
+			       unsigned long event, void *ptr)
+{
+	struct nexthop *nh = ptr;
+
+	if (!nh || event != NEXTHOP_EVENT_DEL)
+		return NOTIFY_DONE;
+
+	vxlan_fdb_nh_flush(nh);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vxlan_nexthop_notifier_block __read_mostly = {
+	.notifier_call = vxlan_nexthop_event,
+};
+
+static __net_init int vxlan_init_net(struct net *net)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	unsigned int h;
+
+	INIT_LIST_HEAD(&vn->vxlan_list);
+	spin_lock_init(&vn->sock_lock);
+
+	for (h = 0; h < PORT_HASH_SIZE; ++h)
+		INIT_HLIST_HEAD(&vn->sock_list[h]);
+
+	return register_nexthop_notifier(net, &vxlan_nexthop_notifier_block);
+}
+
+static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_dev *vxlan, *next;
+	struct net_device *dev, *aux;
+
+	for_each_netdev_safe(net, dev, aux)
+		if (dev->rtnl_link_ops == &vxlan_link_ops)
+			unregister_netdevice_queue(dev, head);
+
+	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
+		/* If vxlan->dev is in the same netns, it has already been added
+		 * to the list by the previous loop.
+		 */
+		if (!net_eq(dev_net(vxlan->dev), net))
+			unregister_netdevice_queue(vxlan->dev, head);
+	}
+
+}
+
+static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+{
+	struct net *net;
+	LIST_HEAD(list);
+	unsigned int h;
+
+	rtnl_lock();
+	list_for_each_entry(net, net_list, exit_list)
+		unregister_nexthop_notifier(net, &vxlan_nexthop_notifier_block);
+	list_for_each_entry(net, net_list, exit_list)
+		vxlan_destroy_tunnels(net, &list);
+
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
+
+	list_for_each_entry(net, net_list, exit_list) {
+		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+
+		for (h = 0; h < PORT_HASH_SIZE; ++h)
+			WARN_ON_ONCE(!hlist_empty(&vn->sock_list[h]));
+	}
+}
+
+static struct pernet_operations vxlan_net_ops = {
+	.init = vxlan_init_net,
+	.exit_batch = vxlan_exit_batch_net,
+	.id   = &vxlan_net_id,
+	.size = sizeof(struct vxlan_net),
+};
+
+static int __init vxlan_init_module(void)
+{
+	int rc;
+
+	get_random_bytes(&vxlan_salt, sizeof(vxlan_salt));
+
+	rc = register_pernet_subsys(&vxlan_net_ops);
+	if (rc)
+		goto out1;
+
+	rc = register_netdevice_notifier(&vxlan_notifier_block);
+	if (rc)
+		goto out2;
+
+	rc = register_switchdev_notifier(&vxlan_switchdev_notifier_block);
+	if (rc)
+		goto out3;
+
+	rc = rtnl_link_register(&vxlan_link_ops);
+	if (rc)
+		goto out4;
+
+	return 0;
+out4:
+	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
+out3:
+	unregister_netdevice_notifier(&vxlan_notifier_block);
+out2:
+	unregister_pernet_subsys(&vxlan_net_ops);
+out1:
+	return rc;
+}
+late_initcall(vxlan_init_module);
+
+static void __exit vxlan_cleanup_module(void)
+{
+	rtnl_link_unregister(&vxlan_link_ops);
+	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
+	unregister_netdevice_notifier(&vxlan_notifier_block);
+	unregister_pernet_subsys(&vxlan_net_ops);
+	/* rcu_barrier() is called by netns */
+}
+module_exit(vxlan_cleanup_module);
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION(VXLAN_VERSION);
+MODULE_AUTHOR("Stephen Hemminger <stephen@networkplumber.org>");
+MODULE_DESCRIPTION("Driver for VXLAN encapsulated traffic");
+MODULE_ALIAS_RTNL_LINK("vxlan");
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 81ff3b4c6c1b..dc1191aa0443 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -160,9 +160,9 @@ static void mt76_init_stream_cap(struct mt76_phy *phy,
 
 void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
 {
-	if (phy->dev->cap.has_2ghz)
+	if (phy->cap.has_2ghz)
 		mt76_init_stream_cap(phy, &phy->sband_2g.sband, false);
-	if (phy->dev->cap.has_5ghz)
+	if (phy->cap.has_5ghz)
 		mt76_init_stream_cap(phy, &phy->sband_5g.sband, vht);
 }
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
@@ -463,13 +463,13 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	dev_set_drvdata(dev->dev, dev);
 	mt76_phy_init(dev, hw);
 
-	if (dev->cap.has_2ghz) {
+	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(dev, rates, n_rates);
 		if (ret)
 			return ret;
 	}
 
-	if (dev->cap.has_5ghz) {
+	if (phy->cap.has_5ghz) {
 		ret = mt76_init_sband_5g(dev, rates + 4, n_rates - 4, vht);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5a8060790a61..16e65020a242 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -561,6 +561,7 @@ struct mt76_phy {
 	struct mt76_channel_state *chan_state;
 	ktime_t survey_time;
 
+	struct mt76_hw_cap cap;
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
 
@@ -630,7 +631,6 @@ struct mt76_dev {
 
 	struct debugfs_blob_wrapper eeprom;
 	struct debugfs_blob_wrapper otp;
-	struct mt76_hw_cap cap;
 
 	struct mt76_rate_power rate_power;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 01f1e0da5ee1..a6df733aca49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -170,7 +170,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 	}
 
 	eeprom = (u8 *)dev->mt76.eeprom.data;
-	dev->mt76.cap.has_2ghz = true;
+	dev->mphy.cap.has_2ghz = true;
 	memcpy(dev->mt76.macaddr, eeprom + MT_EE_MAC_ADDR, ETH_ALEN);
 
 	/* Check for 1SS devices */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index bf8ae14121db..637ef0882436 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -202,7 +202,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	int ret;
 
 	/* Increase buffer size to receive large VHT MPDUs */
-	if (dev->mt76.cap.has_5ghz)
+	if (dev->mphy.cap.has_5ghz)
 		rx_buf_size *= 2;
 
 	mt76_dma_attach(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index e9cdcdc54d5c..85f56487feff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -100,20 +100,20 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 
 	if (is_mt7663(&dev->mt76)) {
 		/* dual band */
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		return;
 	}
 
 	if (is_mt7622(&dev->mt76)) {
 		/* 2GHz only */
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		return;
 	}
 
 	if (is_mt7611(&dev->mt76)) {
 		/* 5GHz only */
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		return;
 	}
 
@@ -121,17 +121,17 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 			eeprom[MT_EE_WIFI_CONF]);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
-		break;
-	case MT_EE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case MT_EE_DBDC:
 		dev->dbdc_support = true;
-		/* fall through */
+		fallthrough;
+	case MT_EE_2GHZ:
+		dev->mphy.cap.has_2ghz = true;
+		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index 9087607b621e..ebf4c96532d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -52,15 +52,15 @@ static void mt76x0_set_chip_cap(struct mt76x02_dev *dev)
 
 	mt76x02_eeprom_parse_hw_cap(dev);
 	dev_dbg(dev->mt76.dev, "2GHz %d 5GHz %d\n",
-		dev->mt76.cap.has_2ghz, dev->mt76.cap.has_5ghz);
+		dev->mphy.cap.has_2ghz, dev->mphy.cap.has_5ghz);
 
 	if (dev->no_2ghz) {
-		dev->mt76.cap.has_2ghz = false;
+		dev->mphy.cap.has_2ghz = false;
 		dev_dbg(dev->mt76.dev, "mask out 2GHz support\n");
 	}
 
 	if (is_mt7630(dev)) {
-		dev->mt76.cap.has_5ghz = false;
+		dev->mphy.cap.has_5ghz = false;
 		dev_dbg(dev->mt76.dev, "mask out 5GHz support\n");
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index d78866bf41ba..0bac39bf3b66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -245,7 +245,7 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	if (dev->mt76.cap.has_5ghz) {
+	if (dev->mphy.cap.has_5ghz) {
 		struct ieee80211_supported_band *sband;
 
 		sband = &dev->mphy.sband_5g.sband;
@@ -253,7 +253,7 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 		mt76x0_init_txpower(dev, sband);
 	}
 
-	if (dev->mt76.cap.has_2ghz)
+	if (dev->mphy.cap.has_2ghz)
 		mt76x0_init_txpower(dev, &dev->mphy.sband_2g.sband);
 
 	mt76x02_init_debugfs(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 3de33aadf794..e91c314cdfac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -447,11 +447,11 @@ static void mt76x0_phy_ant_select(struct mt76x02_dev *dev)
 		else
 			coex3 |= BIT(4);
 		coex3 |= BIT(3);
-		if (dev->mt76.cap.has_2ghz)
+		if (dev->mphy.cap.has_2ghz)
 			wlan |= BIT(6);
 	} else {
 		/* sigle antenna mode */
-		if (dev->mt76.cap.has_5ghz) {
+		if (dev->mphy.cap.has_5ghz) {
 			coex3 |= BIT(3) | BIT(4);
 		} else {
 			wlan |= BIT(6);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index c54c50fd639a..0acabba2d1a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -75,14 +75,14 @@ void mt76x02_eeprom_parse_hw_cap(struct mt76x02_dev *dev)
 
 	switch (FIELD_GET(MT_EE_NIC_CONF_0_BOARD_TYPE, val)) {
 	case BOARD_TYPE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case BOARD_TYPE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index e4c5f968f706..5f6c527611f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -57,14 +57,14 @@ static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
 	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case MT_EE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 8f01ca1694bc..99683688a836 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -528,10 +528,9 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 {
 	struct ieee80211_sband_iftype_data *data;
 	struct ieee80211_supported_band *band;
-	struct mt76_dev *mdev = &phy->dev->mt76;
 	int n;
 
-	if (mdev->cap.has_2ghz) {
+	if (phy->mt76->cap.has_2ghz) {
 		data = phy->iftype[NL80211_BAND_2GHZ];
 		n = mt7915_init_he_caps(phy, NL80211_BAND_2GHZ, data);
 
@@ -540,7 +539,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		band->n_iftype_data = n;
 	}
 
-	if (mdev->cap.has_5ghz) {
+	if (phy->mt76->cap.has_5ghz) {
 		data = phy->iftype[NL80211_BAND_5GHZ];
 		n = mt7915_init_he_caps(phy, NL80211_BAND_5GHZ, data);
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 51da8ba67d21..7a3cf8aaec25 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -192,12 +192,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
-static bool pcie_retrain_link(struct pcie_link_state *link)
+static int pcie_wait_for_retrain(struct pci_dev *pdev)
 {
-	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
 
+	/* Wait for Link Training to be cleared by hardware */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			return 0;
+		msleep(1);
+	} while (time_before(jiffies, end_jiffies));
+
+	return -ETIMEDOUT;
+}
+
+static int pcie_retrain_link(struct pcie_link_state *link)
+{
+	struct pci_dev *parent = link->pdev;
+	int rc;
+	u16 reg16;
+
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training to
+	 * avoid LTSSM race as recommended in Implementation Note at the
+	 * end of PCIe r6.0.1 sec 7.5.3.7.
+	 */
+	rc = pcie_wait_for_retrain(parent);
+	if (rc)
+		return rc;
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
@@ -211,15 +238,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 	}
 
-	/* Wait for link training end. Break out after waiting for timeout */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		msleep(1);
-	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return pcie_wait_for_retrain(parent);
 }
 
 /*
@@ -288,15 +307,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	if (pcie_retrain_link(link))
-		return;
+	if (pcie_retrain_link(link)) {
 
-	/* Training failed. Restore common clock configurations */
-	pci_err(parent, "ASPM: Could not configure common clock\n");
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+		/* Training failed. Restore common clock configurations */
+		pci_err(parent, "ASPM: Could not configure common clock\n");
+		list_for_each_entry(child, &linkbus->devices, bus_list)
+			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+	}
 }
 
 /* Convert L0s latency encoding to ns */
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 34a6a9a1ceb2..897c6bb4cbb8 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -153,7 +153,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, &priv->ports[i]);
 		i++;
 
-		if (i > INNO_PHY_PORT_NUM) {
+		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
 			break;
 		}
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 7e61202aa234..abb926456933 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -68,23 +68,27 @@ static const char * const qcom_snps_hsphy_vreg_names[] = {
 /**
  * struct qcom_snps_hsphy - snps hs phy attributes
  *
+ * @dev: device structure
+ *
  * @phy: generic phy
  * @base: iomapped memory space for snps hs phy
  *
- * @cfg_ahb_clk: AHB2PHY interface clock
- * @ref_clk: phy reference clock
- * @iface_clk: phy interface clock
+ * @num_clks: number of clocks
+ * @clks: array of clocks
  * @phy_reset: phy reset control
  * @vregs: regulator supplies bulk data
  * @phy_initialized: if PHY has been initialized correctly
  * @mode: contains the current mode the PHY is in
+ * @update_seq_cfg: tuning parameters for phy init
  */
 struct qcom_snps_hsphy {
+	struct device *dev;
+
 	struct phy *phy;
 	void __iomem *base;
 
-	struct clk *cfg_ahb_clk;
-	struct clk *ref_clk;
+	int num_clks;
+	struct clk_bulk_data *clks;
 	struct reset_control *phy_reset;
 	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
 
@@ -92,6 +96,34 @@ struct qcom_snps_hsphy {
 	enum phy_mode mode;
 };
 
+static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
+{
+	struct device *dev = hsphy->dev;
+
+	hsphy->num_clks = 2;
+	hsphy->clks = devm_kcalloc(dev, hsphy->num_clks, sizeof(*hsphy->clks), GFP_KERNEL);
+	if (!hsphy->clks)
+		return -ENOMEM;
+
+	/*
+	 * TODO: Currently no device tree instantiation of the PHY is using the clock.
+	 * This needs to be fixed in order for this code to be able to use devm_clk_bulk_get().
+	 */
+	hsphy->clks[0].id = "cfg_ahb";
+	hsphy->clks[0].clk = devm_clk_get_optional(dev, "cfg_ahb");
+	if (IS_ERR(hsphy->clks[0].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[0].clk),
+				     "failed to get cfg_ahb clk\n");
+
+	hsphy->clks[1].id = "ref";
+	hsphy->clks[1].clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(hsphy->clks[1].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[1].clk),
+				     "failed to get ref clk\n");
+
+	return 0;
+}
+
 static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
 						u32 mask, u32 val)
 {
@@ -122,22 +154,13 @@ static int qcom_snps_hsphy_suspend(struct qcom_snps_hsphy *hsphy)
 					   0, USB2_AUTO_RESUME);
 	}
 
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
 	return 0;
 }
 
 static int qcom_snps_hsphy_resume(struct qcom_snps_hsphy *hsphy)
 {
-	int ret;
-
 	dev_dbg(&hsphy->phy->dev, "Resume QCOM SNPS PHY, mode\n");
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
-	if (ret) {
-		dev_err(&hsphy->phy->dev, "failed to enable cfg ahb clock\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -183,16 +206,16 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
+	ret = clk_bulk_prepare_enable(hsphy->num_clks, hsphy->clks);
 	if (ret) {
-		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		dev_err(&phy->dev, "failed to enable clocks, %d\n", ret);
 		goto poweroff_phy;
 	}
 
 	ret = reset_control_assert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	usleep_range(100, 150);
@@ -200,7 +223,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	ret = reset_control_deassert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to de-assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_CFG0,
@@ -246,8 +269,8 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 
 	return 0;
 
-disable_ahb_clk:
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+disable_clks:
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 poweroff_phy:
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 
@@ -259,7 +282,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
 	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
 
 	reset_control_assert(hsphy->phy_reset);
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 	hsphy->phy_initialized = false;
 
@@ -299,17 +322,15 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 	if (!hsphy)
 		return -ENOMEM;
 
+	hsphy->dev = dev;
+
 	hsphy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsphy->base))
 		return PTR_ERR(hsphy->base);
 
-	hsphy->ref_clk = devm_clk_get(dev, "ref");
-	if (IS_ERR(hsphy->ref_clk)) {
-		ret = PTR_ERR(hsphy->ref_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get ref clk, %d\n", ret);
-		return ret;
-	}
+	ret = qcom_snps_hsphy_clk_init(hsphy);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize clocks\n");
 
 	hsphy->phy_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(hsphy->phy_reset)) {
@@ -322,12 +343,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 		hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
 
 	ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulator supplies: %d\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get regulator supplies\n");
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 0e804b6c2d24..dfb4af759aa7 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -210,7 +210,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -841,15 +841,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
 static void msi_init_rfkill(struct work_struct *ignored)
 {
 	if (rfk_wlan) {
-		rfkill_set_sw_state(rfk_wlan, !wlan_s);
+		msi_rfkill_set_state(rfk_wlan, !wlan_s);
 		rfkill_wlan_set(NULL, !wlan_s);
 	}
 	if (rfk_bluetooth) {
-		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
+		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
 		rfkill_bluetooth_set(NULL, !bluetooth_s);
 	}
 	if (rfk_threeg) {
-		rfkill_set_sw_state(rfk_threeg, !threeg_s);
+		msi_rfkill_set_state(rfk_threeg, !threeg_s);
 		rfkill_threeg_set(NULL, !threeg_s);
 	}
 }
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 0283163ddbe8..5b5fd1671350 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -147,12 +147,13 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	return pwm_set_chip_data(pwm, channel);
+	return 0;
 }
 
 static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 
 	if (channel)
 		clk_disable_unprepare(channel->clk);
@@ -161,9 +162,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -185,19 +187,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	pre_div = div64_u64(fin_freq * period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * period, NSEC_PER_SEC * (pre_div + 1));
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
+	dev_dbg(meson->chip.dev, "period=%llu pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
 	if (duty == period) {
@@ -210,14 +212,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
+		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
 
 		channel->pre_div = pre_div;
@@ -230,7 +231,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
 	u32 value;
@@ -273,8 +274,8 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	int err = 0;
 
 	if (!state)
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 6d5c9cb83592..99b1b01e23e9 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -133,6 +133,7 @@ static int dasd_ioctl_resume(struct dasd_block *block)
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index bf8404b0e74f..2544edd4d2b5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -719,7 +719,6 @@ struct qeth_card_info {
 	u16 chid;
 	u8 ids_valid:1; /* cssid,iid,chid */
 	u8 dev_addr_is_registered:1;
-	u8 open_when_online:1;
 	u8 promisc_mode:1;
 	u8 use_v1_blkt:1;
 	u8 is_vm_nic:1;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7b0155b0e99e..73d564906d04 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5351,8 +5351,6 @@ int qeth_set_offline(struct qeth_card *card, const struct qeth_discipline *disc,
 	qeth_clear_ipacmd_list(card);
 
 	rtnl_lock();
-	card->info.open_when_online = card->dev->flags & IFF_UP;
-	dev_close(card->dev);
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index cfc931f2b7e2..1797addf69b6 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2270,9 +2270,12 @@ static int qeth_l2_set_online(struct qeth_card *card, bool carrier_ok)
 		qeth_enable_hw_features(dev);
 		qeth_l2_enable_brport_features(card);
 
-		if (card->info.open_when_online) {
-			card->info.open_when_online = 0;
-			dev_open(dev, NULL);
+		if (netif_running(dev)) {
+			local_bh_disable();
+			napi_schedule(&card->napi);
+			/* kick-start the NAPI softirq: */
+			local_bh_enable();
+			qeth_l2_set_rx_mode(dev);
 		}
 		rtnl_unlock();
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 291861c9b956..d8cdf9024126 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2037,9 +2037,11 @@ static int qeth_l3_set_online(struct qeth_card *card, bool carrier_ok)
 		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
-		if (card->info.open_when_online) {
-			card->info.open_when_online = 0;
-			dev_open(dev, NULL);
+		if (netif_running(dev)) {
+			local_bh_disable();
+			napi_schedule(&card->napi);
+			/* kick-start the NAPI softirq: */
+			local_bh_enable();
 		}
 		rtnl_unlock();
 	}
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index b61acbb09be3..d323f9985c48 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -534,8 +534,7 @@ static void zfcp_fc_adisc_handler(void *data)
 
 	/* re-init to undo drop from zfcp_fc_adisc() */
 	port->d_id = ntoh24(adisc_resp->adisc_port_id);
-	/* port is good, unblock rport without going through erp */
-	zfcp_scsi_schedule_rport_register(port);
+	/* port is still good, nothing to do */
  out:
 	atomic_andnot(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 	put_device(&port->dev);
@@ -595,9 +594,6 @@ void zfcp_fc_link_test_work(struct work_struct *work)
 	int retval;
 
 	set_worker_desc("zadisc%16llx", port->wwpn); /* < WORKER_DESC_LEN=24 */
-	get_device(&port->dev);
-	port->rport_task = RPORT_DEL;
-	zfcp_scsi_rport_work(&port->rport_work);
 
 	/* only issue one test command at one time per port */
 	if (atomic_read(&port->status) & ZFCP_STATUS_PORT_LINK_TEST)
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3317a02bcc17..0e0a19030c35 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -797,19 +797,19 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 
 	if (status == SDW_SLAVE_UNATTACHED) {
 		dev_dbg(&slave->dev,
-			"%s: initializing completion for Slave %d\n",
+			"%s: initializing enumeration and init completion for Slave %d\n",
 			__func__, slave->dev_num);
 
-		init_completion(&slave->enumeration_complete);
-		init_completion(&slave->initialization_complete);
+		reinit_completion(&slave->enumeration_complete);
+		reinit_completion(&slave->initialization_complete);
 
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
 		dev_dbg(&slave->dev,
-			"%s: signaling completion for Slave %d\n",
+			"%s: signaling enumeration completion for Slave %d\n",
 			__func__, slave->dev_num);
 
-		complete(&slave->enumeration_complete);
+		complete_all(&slave->enumeration_complete);
 	}
 	slave->status = status;
 	mutex_unlock(&slave->bus->bus_lock);
@@ -1734,8 +1734,25 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
-		if (attached_initializing)
-			complete(&slave->initialization_complete);
+		if (attached_initializing) {
+			dev_dbg(&slave->dev,
+				"%s: signaling initialization completion for Slave %d\n",
+				__func__, slave->dev_num);
+
+			complete_all(&slave->initialization_complete);
+
+			/*
+			 * If the manager became pm_runtime active, the peripherals will be
+			 * restarted and attach, but their pm_runtime status may remain
+			 * suspended. If the 'update_slave_status' callback initiates
+			 * any sort of deferred processing, this processing would not be
+			 * cancelled on pm_runtime suspend.
+			 * To avoid such zombie states, we queue a request to resume.
+			 * This would be a no-op in case the peripheral was being resumed
+			 * by e.g. the ALSA/ASoC framework.
+			 */
+			pm_request_resume(&slave->dev);
+		}
 	}
 
 	return ret;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 09e7b4cd0138..604882279adc 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1584,8 +1584,10 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 			commit |= SME_WEP_FLAG;
 		}
 		if (enc->key_len) {
-			memcpy(&key->key_val[0], &enc->key[0], enc->key_len);
-			key->key_len = enc->key_len;
+			int key_len = clamp_val(enc->key_len, 0, IW_ENCODING_TOKEN_MAX);
+
+			memcpy(&key->key_val[0], &enc->key[0], key_len);
+			key->key_len = key_len;
 			commit |= (SME_WEP_VAL1 << index);
 		}
 		break;
diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index 37577bb72998..1a0b958f1aa0 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -13,6 +13,7 @@ config VIDEO_ATOMISP
 	tristate "Intel Atom Image Signal Processor Driver"
 	depends on VIDEO_V4L2 && INTEL_ATOMISP
 	depends on PMIC_OPREGION
+	select V4L2_FWNODE
 	select IOSF_MBI
 	select VIDEOBUF_VMALLOC
 	help
diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index b4a099169c7c..8075ed2ba61e 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -181,25 +181,25 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
 	sz += 2;
 	ie += 2;
 	/*SSID*/
-	ie = r8712_set_ie(ie, _SSID_IE_, dev_network->Ssid.SsidLength,
+	ie = r8712_set_ie(ie, WLAN_EID_SSID, dev_network->Ssid.SsidLength,
 			  dev_network->Ssid.Ssid, &sz);
 	/*supported rates*/
 	set_supported_rate(dev_network->rates, registrypriv->wireless_mode);
 	rate_len = r8712_get_rateset_len(dev_network->rates);
 	if (rate_len > 8) {
-		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_, 8,
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES, 8,
 				  dev_network->rates, &sz);
-		ie = r8712_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8),
+		ie = r8712_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8),
 				  (dev_network->rates + 8), &sz);
 	} else {
-		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_,
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES,
 				  rate_len, dev_network->rates, &sz);
 	}
 	/*DS parameter set*/
-	ie = r8712_set_ie(ie, _DSSET_IE_, 1,
+	ie = r8712_set_ie(ie, WLAN_EID_DS_PARAMS, 1,
 			  (u8 *)&dev_network->Configuration.DSConfig, &sz);
 	/*IBSS Parameter Set*/
-	ie = r8712_set_ie(ie, _IBSS_PARA_IE_, 2,
+	ie = r8712_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2,
 			  (u8 *)&dev_network->Configuration.ATIMWindow, &sz);
 	return sz;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 2a661b04cd25..15c6ac518c16 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -236,7 +236,7 @@ static char *translate_scan(struct _adapter *padapter,
 	start = iwe_stream_add_point(info, start, stop, &iwe,
 				     pnetwork->network.Ssid.Ssid);
 	/* parsing HT_CAP_IE */
-	p = r8712_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_,
+	p = r8712_get_ie(&pnetwork->network.IEs[12], WLAN_EID_HT_CAPABILITY,
 			 &ht_ielen, pnetwork->network.IELength - 12);
 	if (p && ht_ielen > 0)
 		ht_cap = true;
@@ -567,7 +567,7 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 			while (cnt < ielen) {
 				eid = buf[cnt];
 
-				if ((eid == _VENDOR_SPECIFIC_IE_) &&
+				if ((eid == WLAN_EID_VENDOR_SPECIFIC) &&
 				    (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
 					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE\n");
 					padapter->securitypriv.wps_ie_len =
@@ -609,7 +609,7 @@ static int r8711_wx_get_name(struct net_device *dev,
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) ==
 	    true) {
 		/* parsing HT_CAP_IE */
-		p = r8712_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_,
+		p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY,
 				 &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
@@ -1403,7 +1403,7 @@ static int r8711_wx_get_rate(struct net_device *dev,
 	i = 0;
 	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
 		return -ENOLINK;
-	p = r8712_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen,
+	p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen,
 			 pcur_bss->IELength - 12);
 	if (p && ht_ielen > 0) {
 		ht_cap = true;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 6074383ec0b5..250cb0c4ed08 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1649,11 +1649,11 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	phtpriv->ht_option = 0;
-	p = r8712_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
+	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len - 12);
 	if (p && (ielen > 0)) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
-			r8712_set_ie(out_ie + out_len, _VENDOR_SPECIFIC_IE_,
+			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
 				     _WMM_IE_Length_, WMM_IE, pout_len);
 			pqospriv->qos_option = 1;
 		}
@@ -1667,7 +1667,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 				    IEEE80211_HT_CAP_DSSSCCK40);
 		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
 				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
-		r8712_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
+		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
 			     sizeof(struct rtl_ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
@@ -1698,7 +1698,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-				_HT_CAPABILITY_IE_,
+				WLAN_EID_HT_CAPABILITY,
 				&len, ie_len -
 				sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
@@ -1733,7 +1733,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-		   _HT_ADD_INFO_IE_, &len,
+		   WLAN_EID_HT_OPERATION, &len,
 		   ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index fd99782a400a..eb6493047aaf 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -22,6 +22,8 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
+#include <linux/usb.h>
+#include <linux/ieee80211.h>
 
 static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
 static const u8 RFC1042_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0x00};
@@ -55,6 +57,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	sint i;
 	struct xmit_buf *pxmitbuf;
 	struct xmit_frame *pxframe;
+	int j;
 
 	memset((unsigned char *)pxmitpriv, 0, sizeof(struct xmit_priv));
 	spin_lock_init(&pxmitpriv->lock);
@@ -117,11 +120,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto clean_up_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -129,13 +129,17 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		INIT_LIST_HEAD(&pxmitbuf->list);
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
-		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+		if (!pxmitbuf->pallocated_buf) {
+			j = 0;
+			goto clean_up_alloc_buf;
+		}
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
-		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
+			j = 1;
+			goto clean_up_alloc_buf;
+		}
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +150,28 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+clean_up_alloc_buf:
+	if (j) {
+		/* failure happened in r8712_xmit_resource_alloc()
+		 * delete extra pxmitbuf->pallocated_buf
+		 */
+		kfree(pxmitbuf->pallocated_buf);
+	}
+	for (j = 0; j < i; j++) {
+		int k;
+
+		pxmitbuf--;			/* reset pointer */
+		kfree(pxmitbuf->pallocated_buf);
+		for (k = 0; k < 8; k++)		/* delete xmit urb's */
+			usb_free_urb(pxmitbuf->pxmit_urb[k]);
+	}
+	kfree(pxmitpriv->pallocated_xmitbuf);
+	pxmitpriv->pallocated_xmitbuf = NULL;
+clean_up_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	pxmitpriv->pallocated_frame_buf = NULL;
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
@@ -709,7 +735,7 @@ void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_len)
 		break;
 	case AUTO_VCS:
 	default:
-		perp = r8712_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
+		perp = r8712_get_ie(ie, WLAN_EID_ERP_INFO, &erp_len, ie_len);
 		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
 		} else {
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 601d4ff607bc..9bb310b24589 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -374,21 +374,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_	_BEACON_IE_OFFSET_
 
-#define _SSID_IE_		0
-#define _SUPPORTEDRATES_IE_	1
-#define _DSSET_IE_		3
-#define _IBSS_PARA_IE_		6
-#define _ERPINFO_IE_		42
-#define _EXT_SUPPORTEDRATES_IE_	50
-
-#define _HT_CAPABILITY_IE_	45
-#define _HT_EXTRA_INFO_IE_	61
-#define _HT_ADD_INFO_IE_	61 /* _HT_EXTRA_INFO_IE_ */
-
-#define _VENDOR_SPECIFIC_IE_	221
-
-#define	_RESERVED47_		47
-
 /* ---------------------------------------------------------------------------
  *			Below is the fixed elements...
  * ---------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 1f67d86c606f..9050e51aa407 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -119,6 +119,12 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
+			int k;
+
+			for (k = i - 1; k >= 0; k--) {
+				/* handle allocation errors part way through loop */
+				usb_free_urb(pxmitbuf->pxmit_urb[k]);
+			}
 			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
 			return -ENOMEM;
 		}
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 23b014b8c919..d439afef9212 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2178,8 +2178,10 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 
 	/* Free up any link layer users and finally the control channel */
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i])
+		if (gsm->dlci[i]) {
 			gsm_dlci_release(gsm->dlci[i]);
+			gsm->dlci[i] = NULL;
+		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 6d6a78eead3e..1cf229cca592 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -80,7 +80,7 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, old_dlf;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -93,9 +93,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
 	if (reg) {
 		struct dw8250_port_data *d = p->private_data;
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f50ffc8076d8..65a0c4e2bb29 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1468,13 +1468,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	/*
-	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
-	 * enabled/disabled from dev_pm_arm_wake_irq during system
-	 * suspend/resume respectively.
-	 */
-	pm_runtime_set_active(&pdev->dev);
-
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 91952be01074..c234114b5052 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -844,7 +844,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static int __init sifive_serial_console_setup(struct console *co, char *options)
+static int sifive_serial_console_setup(struct console *co, char *options)
 {
 	struct sifive_serial_port *ssp;
 	int baud = SIFIVE_DEFAULT_BAUD_RATE;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 4ac1c22f13be..856947620f14 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -437,6 +437,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* novation SoundControl XL */
 	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Focusrite Scarlett Solo USB */
+	{ USB_DEVICE(0x1235, 0x8211), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5709b959b1d9..b02b10acb884 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -275,9 +275,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -1066,22 +1066,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index cbebe541f7e8..291893d27429 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -249,9 +249,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index a5a8c5712bce..9f420cc8d7c7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -173,10 +173,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc)
 
 			/*
 			 * A lot of BYT devices lack ACPI resource entries for
-			 * the GPIOs, add a fallback mapping to the reference
+			 * the GPIOs. If the ACPI entry for the GPIO controller
+			 * is present add a fallback mapping to the reference
 			 * design GPIOs which all boards seem to use.
 			 */
-			gpiod_add_lookup_table(&platform_bytcr_gpios);
+			if (acpi_dev_present("INT33FC", NULL, -1))
+				gpiod_add_lookup_table(&platform_bytcr_gpios);
 
 			/*
 			 * These GPIOs will turn on the USB2 PHY. Note that we have to
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b496ca937dee..ddb39e672801 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -309,13 +309,15 @@ static int gadget_bind(struct usb_gadget *gadget,
 	dev->eps_num = i;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	/* Matches kref_put() in gadget_unbind(). */
-	kref_get(&dev->count);
-
 	ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&gadget->dev, "failed to queue event\n");
+		set_gadget_data(gadget, NULL);
+		return ret;
+	}
 
+	/* Matches kref_put() in gadget_unbind(). */
+	kref_get(&dev->count);
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 66d5f6a85c84..c5f0fbb8ffe4 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3693,15 +3693,15 @@ static int tegra_xudc_powerdomain_init(struct tegra_xudc *xudc)
 	int err;
 
 	xudc->genpd_dev_device = dev_pm_domain_attach_by_name(dev, "dev");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_device)) {
-		err = PTR_ERR(xudc->genpd_dev_device) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_device)) {
+		err = PTR_ERR(xudc->genpd_dev_device);
 		dev_err(dev, "failed to get device power domain: %d\n", err);
 		return err;
 	}
 
 	xudc->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "ss");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_ss)) {
-		err = PTR_ERR(xudc->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_ss)) {
+		err = PTR_ERR(xudc->genpd_dev_ss);
 		dev_err(dev, "failed to get SuperSpeed power domain: %d\n", err);
 		return err;
 	}
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 99e994fd3d1d..2ba3c1b6ad6d 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -647,7 +647,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 1c331577fca9..122777b21b24 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -535,6 +535,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 9fa4f8f39830..ffb09737b5d0 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1042,15 +1042,15 @@ static int tegra_xusb_powerdomain_init(struct device *dev,
 	int err;
 
 	tegra->genpd_dev_host = dev_pm_domain_attach_by_name(dev, "xusb_host");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_host)) {
-		err = PTR_ERR(tegra->genpd_dev_host) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_host)) {
+		err = PTR_ERR(tegra->genpd_dev_host);
 		dev_err(dev, "failed to get host pm-domain: %d\n", err);
 		return err;
 	}
 
 	tegra->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "xusb_ss");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_ss)) {
-		err = PTR_ERR(tegra->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_ss)) {
+		err = PTR_ERR(tegra->genpd_dev_ss);
 		dev_err(dev, "failed to get superspeed pm-domain: %d\n", err);
 		return err;
 	}
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 625d9dc776be..0b3422c06ab9 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -251,6 +251,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LTA		0x0123
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_EM060K_128		0x0128
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -268,6 +269,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
@@ -1197,6 +1199,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1225,6 +1230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 0x0900, 0xff, 0, 0), /* RM500U-CN */
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4c6747889a19..24b8772a345e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -38,16 +38,6 @@ static struct usb_serial_driver vendor##_device = {		\
 	{ USB_DEVICE(0x0a21, 0x8001) }	/* MMT-7305WW */
 DEVICE(carelink, CARELINK_IDS);
 
-/* ZIO Motherboard USB driver */
-#define ZIO_IDS()			\
-	{ USB_DEVICE(0x1CBE, 0x0103) }
-DEVICE(zio, ZIO_IDS);
-
-/* Funsoft Serial USB driver */
-#define FUNSOFT_IDS()			\
-	{ USB_DEVICE(0x1404, 0xcddc) }
-DEVICE(funsoft, FUNSOFT_IDS);
-
 /* Infineon Flashloader driver */
 #define FLASHLOADER_IDS()		\
 	{ USB_DEVICE_INTERFACE_CLASS(0x058b, 0x0041, USB_CLASS_CDC_DATA) }, \
@@ -55,6 +45,11 @@ DEVICE(funsoft, FUNSOFT_IDS);
 	{ USB_DEVICE(0x8087, 0x0801) }
 DEVICE(flashloader, FLASHLOADER_IDS);
 
+/* Funsoft Serial USB driver */
+#define FUNSOFT_IDS()			\
+	{ USB_DEVICE(0x1404, 0xcddc) }
+DEVICE(funsoft, FUNSOFT_IDS);
+
 /* Google Serial USB SubClass */
 #define GOOGLE_IDS()						\
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
@@ -63,16 +58,21 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* HP4x (48/49) Generic Serial driver */
+#define HP4X_IDS()			\
+	{ USB_DEVICE(0x03f0, 0x0121) }
+DEVICE(hp4x, HP4X_IDS);
+
+/* KAUFMANN RKS+CAN VCP */
+#define KAUFMANN_IDS()			\
+	{ USB_DEVICE(0x16d0, 0x0870) }
+DEVICE(kaufmann, KAUFMANN_IDS);
+
 /* Libtransistor USB console */
 #define LIBTRANSISTOR_IDS()			\
 	{ USB_DEVICE(0x1209, 0x8b00) }
 DEVICE(libtransistor, LIBTRANSISTOR_IDS);
 
-/* ViVOpay USB Serial Driver */
-#define VIVOPAY_IDS()			\
-	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
-DEVICE(vivopay, VIVOPAY_IDS);
-
 /* Motorola USB Phone driver */
 #define MOTO_IDS()			\
 	{ USB_DEVICE(0x05c6, 0x3197) },	/* unknown Motorola phone */	\
@@ -101,10 +101,10 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
-/* HP4x (48/49) Generic Serial driver */
-#define HP4X_IDS()			\
-	{ USB_DEVICE(0x03f0, 0x0121) }
-DEVICE(hp4x, HP4X_IDS);
+/* Siemens USB/MPI adapter */
+#define SIEMENS_IDS()			\
+	{ USB_DEVICE(0x908, 0x0004) }
+DEVICE(siemens_mpi, SIEMENS_IDS);
 
 /* Suunto ANT+ USB Driver */
 #define SUUNTO_IDS()			\
@@ -112,45 +112,52 @@ DEVICE(hp4x, HP4X_IDS);
 	{ USB_DEVICE(0x0fcf, 0x1009) } /* Dynastream ANT USB-m Stick */
 DEVICE(suunto, SUUNTO_IDS);
 
-/* Siemens USB/MPI adapter */
-#define SIEMENS_IDS()			\
-	{ USB_DEVICE(0x908, 0x0004) }
-DEVICE(siemens_mpi, SIEMENS_IDS);
+/* ViVOpay USB Serial Driver */
+#define VIVOPAY_IDS()			\
+	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
+DEVICE(vivopay, VIVOPAY_IDS);
+
+/* ZIO Motherboard USB driver */
+#define ZIO_IDS()			\
+	{ USB_DEVICE(0x1CBE, 0x0103) }
+DEVICE(zio, ZIO_IDS);
 
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
-	&zio_device,
-	&funsoft_device,
 	&flashloader_device,
+	&funsoft_device,
 	&google_device,
+	&hp4x_device,
+	&kaufmann_device,
 	&libtransistor_device,
-	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
-	&hp4x_device,
-	&suunto_device,
 	&siemens_mpi_device,
+	&suunto_device,
+	&vivopay_device,
+	&zio_device,
 	NULL
 };
 
 static const struct usb_device_id id_table[] = {
 	CARELINK_IDS(),
-	ZIO_IDS(),
-	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
+	FUNSOFT_IDS(),
 	GOOGLE_IDS(),
+	HP4X_IDS(),
+	KAUFMANN_IDS(),
 	LIBTRANSISTOR_IDS(),
-	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
-	HP4X_IDS(),
-	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	SUUNTO_IDS(),
+	VIVOPAY_IDS(),
+	ZIO_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 41a7ace9998e..814f2f07e74c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3589,6 +3589,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 828a7ff4aebe..a67323c2d41f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1202,12 +1202,23 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 
 	/*
-	 * We need to have subvol_sem write locked, to prevent races between
-	 * concurrent tasks trying to disable quotas, because we will unlock
-	 * and relock qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
+	 * We need to have subvol_sem write locked to prevent races with
+	 * snapshot creation.
 	 */
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
+	/*
+	 * Lock the cleaner mutex to prevent races with concurrent relocation,
+	 * because relocation may be building backrefs for blocks of the quota
+	 * root while we are deleting the root. This is like dropping fs roots
+	 * of deleted snapshots/subvolumes, we need the same protection.
+	 *
+	 * This also prevents races between concurrent tasks trying to disable
+	 * quotas, because we will unlock and relock qgroup_ioctl_lock across
+	 * BTRFS_FS_QUOTA_ENABLED changes.
+	 */
+	mutex_lock(&fs_info->cleaner_mutex);
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
 		goto out;
@@ -1287,6 +1298,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
+	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8daa9e4eb1d2..abd67f984fbc 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -821,8 +821,13 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
 				  BTRFS_RESERVE_NO_FLUSH, true);
-	if (trans == ERR_PTR(-ENOENT))
-		btrfs_wait_for_commit(root->fs_info, 0);
+	if (trans == ERR_PTR(-ENOENT)) {
+		int ret;
+
+		ret = btrfs_wait_for_commit(root->fs_info, 0);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return trans;
 }
@@ -886,6 +891,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 	}
 
 	wait_for_commit(cur_trans);
+	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
 out:
 	return ret;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 87a9e9096421..df1ecb8bfebf 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4511,7 +4511,7 @@ static void delayed_work(struct work_struct *work)
 
 	dout("mdsc delayed_work\n");
 
-	if (mdsc->stopping)
+	if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
 		return;
 
 	mutex_lock(&mdsc->mutex);
@@ -4701,7 +4701,7 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
 	dout("pre_umount\n");
-	mdsc->stopping = 1;
+	mdsc->stopping = CEPH_MDSC_STOPPING_BEGIN;
 
 	ceph_mdsc_iterate_sessions(mdsc, send_flush_mdlog, true);
 	ceph_mdsc_iterate_sessions(mdsc, lock_unlock_session, false);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index a92e42e8a9f8..1c958510f00f 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -372,6 +372,11 @@ struct cap_wait {
 	int			want;
 };
 
+enum {
+       CEPH_MDSC_STOPPING_BEGIN = 1,
+       CEPH_MDSC_STOPPING_FLUSHED = 2,
+};
+
 /*
  * mds client state
  */
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 9e0a0e26294e..906e446abb46 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -130,7 +130,7 @@ static void metric_delayed_work(struct work_struct *work)
 	struct ceph_mds_client *mdsc =
 		container_of(m, struct ceph_mds_client, metric);
 
-	if (mdsc->stopping)
+	if (mdsc->stopping || disable_send_metrics)
 		return;
 
 	if (!m->session || !check_session_state(m->session)) {
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 08c8d34c9809..f2aff97348bc 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1222,6 +1222,16 @@ static void ceph_kill_sb(struct super_block *s)
 	ceph_mdsc_pre_umount(fsc->mdsc);
 	flush_fs_workqueues(fsc);
 
+	/*
+	 * Though the kill_anon_super() will finally trigger the
+	 * sync_filesystem() anyway, we still need to do it here
+	 * and then bump the stage of shutdown to stop the work
+	 * queue as earlier as possible.
+	 */
+	sync_filesystem(s);
+
+	fsc->mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
+
 	kill_anon_super(s);
 
 	fsc->client->extra_mon_dispatch = NULL;
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index edce0b25cd90..f3482e936cc2 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -19,20 +19,20 @@ static struct list_head recv_list;
 static wait_queue_head_t send_wq;
 static wait_queue_head_t recv_wq;
 
-struct plock_op {
-	struct list_head list;
-	int done;
-	struct dlm_plock_info info;
-	int (*callback)(struct file_lock *fl, int result);
-};
-
-struct plock_xop {
-	struct plock_op xop;
+struct plock_async_data {
 	void *fl;
 	void *file;
 	struct file_lock flc;
+	int (*callback)(struct file_lock *fl, int result);
 };
 
+struct plock_op {
+	struct list_head list;
+	int done;
+	struct dlm_plock_info info;
+	/* if set indicates async handling */
+	struct plock_async_data *data;
+};
 
 static inline void set_version(struct dlm_plock_info *info)
 {
@@ -58,6 +58,12 @@ static int check_version(struct dlm_plock_info *info)
 	return 0;
 }
 
+static void dlm_release_plock_op(struct plock_op *op)
+{
+	kfree(op->data);
+	kfree(op);
+}
+
 static void send_op(struct plock_op *op)
 {
 	set_version(&op->info);
@@ -101,22 +107,21 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
 int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		   int cmd, struct file_lock *fl)
 {
+	struct plock_async_data *op_data;
 	struct dlm_ls *ls;
 	struct plock_op *op;
-	struct plock_xop *xop;
 	int rv;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
 		return -EINVAL;
 
-	xop = kzalloc(sizeof(*xop), GFP_NOFS);
-	if (!xop) {
+	op = kzalloc(sizeof(*op), GFP_NOFS);
+	if (!op) {
 		rv = -ENOMEM;
 		goto out;
 	}
 
-	op = &xop->xop;
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
 	op->info.pid		= fl->fl_pid;
 	op->info.ex		= (fl->fl_type == F_WRLCK);
@@ -125,35 +130,44 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
+	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
+		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
+		if (!op_data) {
+			dlm_release_plock_op(op);
+			rv = -ENOMEM;
+			goto out;
+		}
+
 		/* fl_owner is lockd which doesn't distinguish
 		   processes on the nfs client */
 		op->info.owner	= (__u64) fl->fl_pid;
-		op->callback	= fl->fl_lmops->lm_grant;
-		locks_init_lock(&xop->flc);
-		locks_copy_lock(&xop->flc, fl);
-		xop->fl		= fl;
-		xop->file	= file;
+		op_data->callback = fl->fl_lmops->lm_grant;
+		locks_init_lock(&op_data->flc);
+		locks_copy_lock(&op_data->flc, fl);
+		op_data->fl		= fl;
+		op_data->file	= file;
+
+		op->data = op_data;
+
+		send_op(op);
+		rv = FILE_LOCK_DEFERRED;
+		goto out;
 	} else {
 		op->info.owner	= (__u64)(long) fl->fl_owner;
 	}
 
 	send_op(op);
 
-	if (!op->callback) {
-		rv = wait_event_interruptible(recv_wq, (op->done != 0));
-		if (rv == -ERESTARTSYS) {
-			log_debug(ls, "dlm_posix_lock: wait killed %llx",
-				  (unsigned long long)number);
-			spin_lock(&ops_lock);
-			list_del(&op->list);
-			spin_unlock(&ops_lock);
-			kfree(xop);
-			do_unlock_close(ls, number, file, fl);
-			goto out;
-		}
-	} else {
-		rv = FILE_LOCK_DEFERRED;
+	rv = wait_event_killable(recv_wq, (op->done != 0));
+	if (rv == -ERESTARTSYS) {
+		log_debug(ls, "%s: wait killed %llx", __func__,
+			  (unsigned long long)number);
+		spin_lock(&ops_lock);
+		list_del(&op->list);
+		spin_unlock(&ops_lock);
+		dlm_release_plock_op(op);
+		do_unlock_close(ls, number, file, fl);
 		goto out;
 	}
 
@@ -173,7 +187,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 				  (unsigned long long)number);
 	}
 
-	kfree(xop);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -183,11 +197,11 @@ EXPORT_SYMBOL_GPL(dlm_posix_lock);
 /* Returns failure iff a successful lock operation should be canceled */
 static int dlm_plock_callback(struct plock_op *op)
 {
+	struct plock_async_data *op_data = op->data;
 	struct file *file;
 	struct file_lock *fl;
 	struct file_lock *flc;
 	int (*notify)(struct file_lock *fl, int result) = NULL;
-	struct plock_xop *xop = (struct plock_xop *)op;
 	int rv = 0;
 
 	spin_lock(&ops_lock);
@@ -199,10 +213,10 @@ static int dlm_plock_callback(struct plock_op *op)
 	spin_unlock(&ops_lock);
 
 	/* check if the following 2 are still valid or make a copy */
-	file = xop->file;
-	flc = &xop->flc;
-	fl = xop->fl;
-	notify = op->callback;
+	file = op_data->file;
+	flc = &op_data->flc;
+	fl = op_data->fl;
+	notify = op_data->callback;
 
 	if (op->info.rv) {
 		notify(fl, op->info.rv);
@@ -233,7 +247,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 out:
-	kfree(xop);
+	dlm_release_plock_op(op);
 	return rv;
 }
 
@@ -303,7 +317,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 
 out_free:
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	fl->fl_flags = fl_flags;
@@ -371,7 +385,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 	}
 
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -407,7 +421,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	   (the process did not make an unlock call). */
 
 	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
-		kfree(op);
+		dlm_release_plock_op(op);
 
 	if (copy_to_user(u, &info, sizeof(info)))
 		return -EFAULT;
@@ -439,7 +453,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		    op->info.owner == info.owner) {
 			list_del_init(&op->list);
 			memcpy(&op->info, &info, sizeof(info));
-			if (op->callback)
+			if (op->data)
 				do_callback = 1;
 			else
 				op->done = 1;
diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 258b6bb5762a..ab091440e8b9 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -69,7 +69,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 	}
 	sbi->map_sectors = ((need_map_size - 1) >>
 			(sb->s_blocksize_bits)) + 1;
-	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
+	sbi->vol_amap = kvmalloc_array(sbi->map_sectors,
 				sizeof(struct buffer_head *), GFP_KERNEL);
 	if (!sbi->vol_amap)
 		return -ENOMEM;
@@ -84,7 +84,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 			while (j < i)
 				brelse(sbi->vol_amap[j++]);
 
-			kfree(sbi->vol_amap);
+			kvfree(sbi->vol_amap);
 			sbi->vol_amap = NULL;
 			return -EIO;
 		}
@@ -138,7 +138,7 @@ void exfat_free_bitmap(struct exfat_sb_info *sbi)
 	for (i = 0; i < sbi->map_sectors; i++)
 		__brelse(sbi->vol_amap[i]);
 
-	kfree(sbi->vol_amap);
+	kvfree(sbi->vol_amap);
 }
 
 int exfat_set_bitmap(struct inode *inode, unsigned int clu)
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 6caded58cda5..db735a0d32fc 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -33,6 +33,7 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 {
 	int i;
 	struct exfat_entry_set_cache *es;
+	unsigned int uni_len = 0, len;
 
 	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (!es)
@@ -51,7 +52,10 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
 			break;
 
-		exfat_extract_uni_name(ep, uniname);
+		len = exfat_extract_uni_name(ep, uniname);
+		uni_len += len;
+		if (len != EXFAT_FILE_NAME_LEN || uni_len >= MAX_NAME_LENGTH)
+			break;
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
@@ -148,7 +152,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 					0);
 
 			*uni_name.name = 0x0;
-			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
+			exfat_get_uniname_from_ext_entry(sb, &clu, i,
 				uni_name.name);
 			exfat_utf16_to_nls(sb, &uni_name,
 				dir_entry->namebuf.lfn,
@@ -210,7 +214,10 @@ static void exfat_free_namebuf(struct exfat_dentry_namebuf *nb)
 	exfat_init_namebuf(nb);
 }
 
-/* skip iterating emit_dots when dir is empty */
+/*
+ * Before calling dir_emit*(), sbi->s_lock should be released
+ * because page fault can occur in dir_emit*().
+ */
 #define ITER_POS_FILLED_DOTS    (2)
 static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 {
@@ -225,11 +232,10 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 	int err = 0, fake_offset = 0;
 
 	exfat_init_namebuf(nb);
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
 
 	cpos = ctx->pos;
 	if (!dir_emit_dots(filp, ctx))
-		goto unlock;
+		goto out;
 
 	if (ctx->pos == ITER_POS_FILLED_DOTS) {
 		cpos = 0;
@@ -241,16 +247,18 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 	/* name buffer should be allocated before use */
 	err = exfat_alloc_namebuf(nb);
 	if (err)
-		goto unlock;
+		goto out;
 get_new:
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+
 	if (ei->flags == ALLOC_NO_FAT_CHAIN && cpos >= i_size_read(inode))
 		goto end_of_dir;
 
 	err = exfat_readdir(inode, &cpos, &de);
 	if (err) {
 		/*
-		 * At least we tried to read a sector.  Move cpos to next sector
-		 * position (should be aligned).
+		 * At least we tried to read a sector.
+		 * Move cpos to next sector position (should be aligned).
 		 */
 		if (err == -EIO) {
 			cpos += 1 << (sb->s_blocksize_bits);
@@ -273,16 +281,10 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 		inum = iunique(sb, EXFAT_ROOT_INO);
 	}
 
-	/*
-	 * Before calling dir_emit(), sb_lock should be released.
-	 * Because page fault can occur in dir_emit() when the size
-	 * of buffer given from user is larger than one page size.
-	 */
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
 	if (!dir_emit(ctx, nb->lfn, strlen(nb->lfn), inum,
 			(de.attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
-		goto out_unlocked;
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
+		goto out;
 	ctx->pos = cpos;
 	goto get_new;
 
@@ -290,9 +292,8 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 	if (!cpos && fake_offset)
 		cpos = ITER_POS_FILLED_DOTS;
 	ctx->pos = cpos;
-unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
-out_unlocked:
+out:
 	/*
 	 * To improve performance, free namebuf after unlock sb_lock.
 	 * If namebuf is not allocated, this function do nothing
@@ -612,6 +613,10 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
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
@@ -847,6 +852,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	/* byte offset in sector */
 	off = EXFAT_BLK_OFFSET(byte_offset, sb);
 	es->start_off = off;
+	es->bh = es->__bh;
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -866,6 +872,16 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
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
@@ -905,14 +921,19 @@ enum {
 };
 
 /*
- * return values:
- *   >= 0	: return dir entiry position with the name in dir
- *   -ENOENT	: entry with the name does not exist
- *   -EIO	: I/O error
+ * @ei:         inode info of parent directory
+ * @p_dir:      directory structure of parent directory
+ * @num_entries:entry size of p_uniname
+ * @hint_opt:   If p_uniname is found, filled with optimized dir/entry
+ *              for traversing cluster chain.
+ * @return:
+ *   >= 0:      file directory entry position where the name exists
+ *   -ENOENT:   entry with the name does not exist
+ *   -EIO:      I/O error
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type)
+		int num_entries, unsigned int type, struct exfat_hint *hint_opt)
 {
 	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
 	int order, step, name_len = 0;
@@ -989,6 +1010,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 
 			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR) {
 				step = DIRENT_STEP_FILE;
+				hint_opt->clu = clu.dir;
+				hint_opt->eidx = i;
 				if (type == TYPE_ALL || type == entry_type) {
 					num_ext = ep->dentry.file.num_ext;
 					step = DIRENT_STEP_STRM;
@@ -1023,7 +1046,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
-				if (step != DIRENT_STEP_NAME) {
+				if (step != DIRENT_STEP_NAME ||
+				    name_len >= MAX_NAME_LENGTH) {
 					step = DIRENT_STEP_FILE;
 					continue;
 				}
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 07b09af57436..11e579a2598d 100644
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
@@ -458,7 +461,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries, unsigned int type, struct exfat_hint *hint_opt);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1382d816912c..bd00afc5e4c1 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -596,6 +596,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	struct exfat_inode_info *ei = EXFAT_I(dir);
 	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es;
+	/* for optimized dir & entry to prevent long traverse of cluster chain */
+	struct exfat_hint hint_opt;
 
 	if (qname->len == 0)
 		return -ENOENT;
@@ -619,7 +621,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 	/* search the file name for directories */
 	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
-			num_entries, TYPE_ALL);
+			num_entries, TYPE_ALL, &hint_opt);
 
 	if (dentry < 0)
 		return dentry; /* -error value */
@@ -628,6 +630,11 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->entry = dentry;
 	info->num_subdirs = 0;
 
+	/* adjust cdir to the optimized value */
+	cdir.dir = hint_opt.clu;
+	if (cdir.flags & ALLOC_NO_FAT_CHAIN)
+		cdir.size -= dentry / sbi->dentries_per_clu;
+	dentry = hint_opt.eidx;
 	es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 	if (!es)
 		return -EIO;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index f06367cfd764..fb2086bcbbf8 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -68,10 +68,7 @@ struct mb_cache;
  * second extended-fs super-block data in memory
  */
 struct ext2_sb_info {
-	unsigned long s_frag_size;	/* Size of a fragment in bytes */
-	unsigned long s_frags_per_block;/* Number of fragments per block */
 	unsigned long s_inodes_per_block;/* Number of inodes per block */
-	unsigned long s_frags_per_group;/* Number of fragments in a group */
 	unsigned long s_blocks_per_group;/* Number of blocks in a group */
 	unsigned long s_inodes_per_group;/* Number of inodes in a group */
 	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
@@ -185,15 +182,6 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
 #define EXT2_FIRST_INO(s)		(EXT2_SB(s)->s_first_ino)
 
-/*
- * Macro-instructions used to manage fragments
- */
-#define EXT2_MIN_FRAG_SIZE		1024
-#define	EXT2_MAX_FRAG_SIZE		4096
-#define EXT2_MIN_FRAG_LOG_SIZE		  10
-#define EXT2_FRAG_SIZE(s)		(EXT2_SB(s)->s_frag_size)
-#define EXT2_FRAGS_PER_BLOCK(s)		(EXT2_SB(s)->s_frags_per_block)
-
 /*
  * Structure of a blocks group descriptor
  */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index ab01ec7ac48c..a810b9c9e8eb 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -673,10 +673,9 @@ static int ext2_setup_super (struct super_block * sb,
 		es->s_max_mnt_count = cpu_to_le16(EXT2_DFL_MAX_MNT_COUNT);
 	le16_add_cpu(&es->s_mnt_count, 1);
 	if (test_opt (sb, DEBUG))
-		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, fs=%lu, gc=%lu, "
+		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sbi->s_frag_size,
 			sbi->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
@@ -1014,14 +1013,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	sbi->s_frag_size = EXT2_MIN_FRAG_SIZE <<
-				   le32_to_cpu(es->s_log_frag_size);
-	if (sbi->s_frag_size == 0)
-		goto cantfind_ext2;
-	sbi->s_frags_per_block = sb->s_blocksize / sbi->s_frag_size;
-
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
 	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
@@ -1047,11 +1039,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sbi->s_frag_size) {
+	if (es->s_log_frag_size != es->s_log_block_size) {
 		ext2_msg(sb, KERN_ERR,
-			"error: fragsize %lu != blocksize %lu"
-			"(not supported yet)",
-			sbi->s_frag_size, sb->s_blocksize);
+			"error: fragsize log %u != blocksize log %u",
+			le32_to_cpu(es->s_log_frag_size), sb->s_blocksize_bits);
 		goto failed_mount;
 	}
 
@@ -1061,12 +1052,6 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
-		ext2_msg(sb, KERN_ERR,
-			"error: #fragments per group too big: %lu",
-			sbi->s_frags_per_group);
-		goto failed_mount;
-	}
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1171618f6549..56829507e68c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -612,6 +612,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	struct super_block *ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -630,7 +631,9 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (IS_ERR(ret))
+			return PTR_ERR(ret);
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev, sb);
 		break;
diff --git a/fs/file.c b/fs/file.c
index 173d318208b8..d6bc73960e4a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1007,16 +1007,30 @@ unsigned long __fdget_raw(unsigned int fd)
 	return __fget_light(fd, 0);
 }
 
+/*
+ * Try to avoid f_pos locking. We only need it if the
+ * file is marked for FMODE_ATOMIC_POS, and it can be
+ * accessed multiple ways.
+ *
+ * Always do it for directories, because pidfd_getfd()
+ * can make a file accessible even if it otherwise would
+ * not be, and for directories this is a correctness
+ * issue, not a "POSIX requirement".
+ */
+static inline bool file_needs_f_pos_lock(struct file *file)
+{
+	return (file->f_mode & FMODE_ATOMIC_POS) &&
+		(file_count(file) > 1 || S_ISDIR(file_inode(file)->i_mode));
+}
+
 unsigned long __fdget_pos(unsigned int fd)
 {
 	unsigned long v = __fdget(fd);
 	struct file *file = (struct file *)(v & ~3);
 
-	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
-		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
-			mutex_lock(&file->f_pos_lock);
-		}
+	if (file && file_needs_f_pos_lock(file)) {
+		v |= FDPUT_POS_UNLOCK;
+		mutex_lock(&file->f_pos_lock);
 	}
 	return v;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cb13a1649632..1c1b231b2ab3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5656,8 +5656,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
diff --git a/fs/open.c b/fs/open.c
index 1ca4b236fdbe..83f62cf1432c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1101,7 +1101,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_IN_ROOT;
 	if (how->resolve & RESOLVE_CACHED) {
 		/* Don't bother even trying for create/truncate/tmpfile open */
-		if (flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+		if (flags & (O_TRUNC | O_CREAT | __O_TMPFILE))
 			return -EAGAIN;
 		lookup_flags |= LOOKUP_CACHED;
 	}
diff --git a/fs/super.c b/fs/super.c
index 7629f9dd031c..f9795e72e3bf 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -906,6 +906,7 @@ int reconfigure_super(struct fs_context *fc)
 	struct super_block *sb = fc->root->d_sb;
 	int retval;
 	bool remount_ro = false;
+	bool remount_rw = false;
 	bool force = fc->sb_flags & SB_FORCE;
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
@@ -922,7 +923,7 @@ int reconfigure_super(struct fs_context *fc)
 		if (!(fc->sb_flags & SB_RDONLY) && bdev_read_only(sb->s_bdev))
 			return -EACCES;
 #endif
-
+		remount_rw = !(fc->sb_flags & SB_RDONLY) && sb_rdonly(sb);
 		remount_ro = (fc->sb_flags & SB_RDONLY) && !sb_rdonly(sb);
 	}
 
@@ -952,6 +953,14 @@ int reconfigure_super(struct fs_context *fc)
 			if (retval)
 				return retval;
 		}
+	} else if (remount_rw) {
+		/*
+		 * We set s_readonly_remount here to protect filesystem's
+		 * reconfigure code from writes from userspace until
+		 * reconfigure finishes.
+		 */
+		sb->s_readonly_remount = 1;
+		smp_wmb();
 	}
 
 	if (fc->ops->reconfigure) {
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 31f66053e239..e3d1673b8ec9 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,10 @@ static int alloc_branch(struct inode *inode,
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			sysv_free_block(inode->i_sb, branch[n].key);
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 20c93f08c993..95a1d214108a 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -38,7 +38,7 @@ static inline long find_zero(unsigned long mask)
 	return (mask >> 8) ? byte : byte + 1;
 }
 
-static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+static inline unsigned long has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
 {
 	unsigned long rhs = val | c->low_bits;
 	*data = rhs;
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 0f7cd21d6d74..09ccfee48fb4 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -157,6 +157,7 @@ struct ttm_buffer_object {
 
 	struct dma_fence *moving;
 	unsigned priority;
+	unsigned pin_count;
 
 	/**
 	 * Special members that are protected by the reserve lock
@@ -606,6 +607,33 @@ static inline bool ttm_bo_uses_embedded_gem_object(struct ttm_buffer_object *bo)
 	return bo->base.dev != NULL;
 }
 
+/**
+ * ttm_bo_pin - Pin the buffer object.
+ * @bo: The buffer object to pin
+ *
+ * Make sure the buffer is not evicted any more during memory pressure.
+ */
+static inline void ttm_bo_pin(struct ttm_buffer_object *bo)
+{
+	dma_resv_assert_held(bo->base.resv);
+	++bo->pin_count;
+}
+
+/**
+ * ttm_bo_unpin - Unpin the buffer object.
+ * @bo: The buffer object to unpin
+ *
+ * Allows the buffer object to be evicted again during memory pressure.
+ */
+static inline void ttm_bo_unpin(struct ttm_buffer_object *bo)
+{
+	dma_resv_assert_held(bo->base.resv);
+	if (bo->pin_count)
+		--bo->pin_count;
+	else
+		WARN_ON_ONCE(true);
+}
+
 int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 			struct ttm_resource_manager *man,
 			const struct ttm_place *place,
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index cd5b62db9084..e63a63aa47a3 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -17,8 +17,8 @@
 #ifdef CONFIG_PM
 
 extern int dev_pm_set_wake_irq(struct device *dev, int irq);
-extern int dev_pm_set_dedicated_wake_irq(struct device *dev,
-					 int irq);
+extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern void dev_pm_enable_wake_irq(struct device *dev);
 extern void dev_pm_disable_wake_irq(struct device *dev);
@@ -35,6 +35,11 @@ static inline int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return 0;
+}
+
 static inline void dev_pm_clear_wake_irq(struct device *dev)
 {
 }
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index c57b79301a75..e418065c2c90 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -55,6 +55,8 @@ struct trace_event;
 
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *event);
+extern __printf(2, 3)
+void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 
 /*
  * The trace entry - the most basic unit of tracing. This is what
@@ -87,6 +89,8 @@ struct trace_iterator {
 	unsigned long		iter_flags;
 	void			*temp;	/* temp holder */
 	unsigned int		temp_size;
+	char			*fmt;	/* modified format holder */
+	unsigned int		fmt_size;
 
 	/* trace_seq for __print_flags() and __print_symbolic() etc. */
 	struct trace_seq	tmp_seq;
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 8879c0ab0b89..4c8f97a6da5a 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -663,12 +663,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
-			    (__force u32)a->s6_addr32[2],
-			    (__force u32)a->s6_addr32[3],
-			    initval);
+	return jhash2((__force const u32 *)a->s6_addr32,
+		      ARRAY_SIZE(a->s6_addr32), initval);
 }
 
 static inline bool ipv6_addr_loopback(const struct in6_addr *a)
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 08537aa14f7c..e149a0b6f9a3 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -327,10 +327,15 @@ static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 	return features;
 }
 
-/* IP header + UDP + VXLAN + Ethernet header */
-#define VXLAN_HEADROOM (20 + 8 + 8 + 14)
-/* IPv6 header + UDP + VXLAN + Ethernet header */
-#define VXLAN6_HEADROOM (40 + 8 + 8 + 14)
+static inline int vxlan_headroom(u32 flags)
+{
+	/* VXLAN:     IP4/6 header + UDP + VXLAN + Ethernet header */
+	/* VXLAN-GPE: IP4/6 header + UDP + VXLAN */
+	return (flags & VXLAN_F_IPV6 ? sizeof(struct ipv6hdr) :
+				       sizeof(struct iphdr)) +
+	       sizeof(struct udphdr) + sizeof(struct vxlanhdr) +
+	       (flags & VXLAN_F_GPE ? 0 : ETH_HLEN);
+}
 
 static inline struct vxlanhdr *vxlan_hdr(struct sk_buff *skb)
 {
@@ -492,12 +497,12 @@ static inline void vxlan_flag_attr_error(int attrtype,
 }
 
 static inline bool vxlan_fdb_nh_path_select(struct nexthop *nh,
-					    int hash,
+					    u32 hash,
 					    struct vxlan_rdst *rdst)
 {
 	struct fib_nh_common *nhc;
 
-	nhc = nexthop_path_fdb_result(nh, hash);
+	nhc = nexthop_path_fdb_result(nh, hash >> 1);
 	if (unlikely(!nhc))
 		return false;
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 717d388ecbd6..29917bce6dbc 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -364,7 +364,7 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 	if (ret != TRACE_TYPE_HANDLED)					\
 		return ret;						\
 									\
-	trace_seq_printf(s, print);					\
+	trace_event_printf(iter, print);				\
 									\
 	return trace_handle_return(s);					\
 }									\
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 656a326821a2..321965feee35 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -51,13 +51,13 @@ enum blk_zone_type {
  *
  * The Zone Condition state machine in the ZBC/ZAC standards maps the above
  * deinitions as:
- *   - ZC1: Empty         | BLK_ZONE_EMPTY
+ *   - ZC1: Empty         | BLK_ZONE_COND_EMPTY
  *   - ZC2: Implicit Open | BLK_ZONE_COND_IMP_OPEN
  *   - ZC3: Explicit Open | BLK_ZONE_COND_EXP_OPEN
- *   - ZC4: Closed        | BLK_ZONE_CLOSED
- *   - ZC5: Full          | BLK_ZONE_FULL
- *   - ZC6: Read Only     | BLK_ZONE_READONLY
- *   - ZC7: Offline       | BLK_ZONE_OFFLINE
+ *   - ZC4: Closed        | BLK_ZONE_COND_CLOSED
+ *   - ZC5: Full          | BLK_ZONE_COND_FULL
+ *   - ZC6: Read Only     | BLK_ZONE_COND_READONLY
+ *   - ZC7: Offline       | BLK_ZONE_COND_OFFLINE
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 51e6ebe72caf..92eb4769b0a3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6895,6 +6895,14 @@ static void io_wq_submit_work(struct io_wq_work *work)
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
+
+			/*
+			 * If REQ_F_NOWAIT is set, then don't wait or retry with
+			 * poll. -EAGAIN is final for that case.
+			 */
+			if (req->flags & REQ_F_NOWAIT)
+				break;
+
 			cond_resched();
 		} while (1);
 	}
@@ -7623,12 +7631,21 @@ static int io_run_task_work_sig(void)
 	return -EINTR;
 }
 
+static bool current_pending_io(void)
+{
+	struct io_uring_task *tctx = current->io_uring;
+
+	if (!tctx)
+		return false;
+	return percpu_counter_read_positive(&tctx->inflight);
+}
+
 /* when returns >0, the caller should retry */
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int token, ret;
+	int io_wait, ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7639,15 +7656,17 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		return 1;
 
 	/*
-	 * Use io_schedule_prepare/finish, so cpufreq can take into account
-	 * that the task is waiting for IO - turns out to be important for low
-	 * QD IO.
+	 * Mark us as being in io_wait if we have pending requests, so cpufreq
+	 * can take into account that the task is waiting for IO - turns out
+	 * to be important for low QD IO.
 	 */
-	token = io_schedule_prepare();
+	io_wait = current->in_iowait;
+	if (current_pending_io())
+		current->in_iowait = 1;
 	ret = 1;
 	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	io_schedule_finish(token);
+	current->in_iowait = io_wait;
 	return ret;
 }
 
@@ -10431,7 +10450,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 	if (!ctx)
 		return -ENOMEM;
 	ctx->compat = in_compat_syscall();
-	if (!capable(CAP_IPC_LOCK))
+	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
 		ctx->user = get_uid(current_user());
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 53f36bbaf0c6..8c5400fd227b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1222,6 +1222,11 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
 	return 0;
 }
 
+static int perf_mux_hrtimer_restart_ipi(void *arg)
+{
+	return perf_mux_hrtimer_restart(arg);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
 	int *count = this_cpu_ptr(pmu->pmu_disable_count);
@@ -10772,8 +10777,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
-		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpuctx);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9e90d1e7af2c..1de9a6bf8471 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -970,7 +970,6 @@ static DEFINE_PER_CPU(struct bpf_trace_sample_data, bpf_misc_sds);
 u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
 {
-	int nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
 	struct perf_raw_frag frag = {
 		.copy		= ctx_copy,
 		.size		= ctx_size,
@@ -987,8 +986,12 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	};
 	struct perf_sample_data *sd;
 	struct pt_regs *regs;
+	int nest_level;
 	u64 ret;
 
+	preempt_disable();
+	nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
+
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bpf_misc_sds.sds))) {
 		ret = -EBUSY;
 		goto out;
@@ -1003,6 +1006,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
+	preempt_enable();
 	return ret;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 593e446f6c48..3b8c53264441 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -526,6 +526,8 @@ struct ring_buffer_per_cpu {
 	rb_time_t			write_stamp;
 	rb_time_t			before_stamp;
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -561,6 +563,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
@@ -1833,6 +1836,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1854,12 +1859,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -4105,6 +4104,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head) {
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4558,12 +4558,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -5005,6 +5006,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7867fc39c4fc..7e99319bd536 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3582,6 +3582,62 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
 	return next;
 }
 
+#define STATIC_FMT_BUF_SIZE	128
+static char static_fmt_buf[STATIC_FMT_BUF_SIZE];
+
+static char *trace_iter_expand_format(struct trace_iterator *iter)
+{
+	char *tmp;
+
+	if (iter->fmt == static_fmt_buf)
+		return NULL;
+
+	tmp = krealloc(iter->fmt, iter->fmt_size + STATIC_FMT_BUF_SIZE,
+		       GFP_KERNEL);
+	if (tmp) {
+		iter->fmt_size += STATIC_FMT_BUF_SIZE;
+		iter->fmt = tmp;
+	}
+
+	return tmp;
+}
+
+const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
+{
+	const char *p, *new_fmt;
+	char *q;
+
+	if (WARN_ON_ONCE(!fmt))
+		return fmt;
+
+	p = fmt;
+	new_fmt = q = iter->fmt;
+	while (*p) {
+		if (unlikely(q - new_fmt + 3 > iter->fmt_size)) {
+			if (!trace_iter_expand_format(iter))
+				return fmt;
+
+			q += iter->fmt - new_fmt;
+			new_fmt = iter->fmt;
+		}
+
+		*q++ = *p++;
+
+		/* Replace %p with %px */
+		if (p[-1] == '%') {
+			if (p[0] == '%') {
+				*q++ = *p++;
+			} else if (p[0] == 'p' && !isalnum(p[1])) {
+				*q++ = *p++;
+				*q++ = 'x';
+			}
+		}
+	}
+	*q = '\0';
+
+	return new_fmt;
+}
+
 #define STATIC_TEMP_BUF_SIZE	128
 static char static_temp_buf[STATIC_TEMP_BUF_SIZE] __aligned(4);
 
@@ -4368,6 +4424,16 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (iter->temp)
 		iter->temp_size = 128;
 
+	/*
+	 * trace_event_printf() may need to modify given format
+	 * string to replace %p with %px so that it shows real address
+	 * instead of hash value. However, that is only for the event
+	 * tracing, other tracer may not need. Defer the allocation
+	 * until it is needed.
+	 */
+	iter->fmt = NULL;
+	iter->fmt_size = 0;
+
 	/*
 	 * We make a copy of the current tracer to avoid concurrent
 	 * changes on it while we are reading.
@@ -4519,6 +4585,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 
 	mutex_destroy(&iter->mutex);
 	free_cpumask_var(iter->started);
+	kfree(iter->fmt);
 	kfree(iter->temp);
 	kfree(iter->trace);
 	kfree(iter->buffer_iter);
@@ -9349,6 +9416,12 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	/* Output in nanoseconds only if we are using a clock in nanoseconds. */
 	if (trace_clocks[iter->tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
+
+	/* Can not use kmalloc for iter.temp and iter.fmt */
+	iter->temp = static_temp_buf;
+	iter->temp_size = STATIC_TEMP_BUF_SIZE;
+	iter->fmt = static_fmt_buf;
+	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
@@ -9382,9 +9455,6 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
-	/* Can not use kmalloc for iter.temp */
-	iter.temp = static_temp_buf;
-	iter.temp_size = STATIC_TEMP_BUF_SIZE;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e5b505b5b7d0..892b3d2f33b7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -758,6 +758,8 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 void trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 					struct ring_buffer_event *event);
 
+const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
+
 int trace_empty(struct trace_iterator *iter);
 
 void *trace_find_next_entry_inc(struct trace_iterator *iter);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f8ed66f38175..a46d34d840f6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -371,7 +371,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -395,6 +394,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -433,6 +434,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -472,15 +475,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b3ee8d9b6b62..94b0991717b6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -312,13 +312,23 @@ int trace_raw_output_prep(struct trace_iterator *iter,
 }
 EXPORT_SYMBOL(trace_raw_output_prep);
 
+void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace_seq_vprintf(&iter->seq, trace_event_format(iter, fmt), ap);
+	va_end(ap);
+}
+EXPORT_SYMBOL(trace_event_printf);
+
 static int trace_output_raw(struct trace_iterator *iter, char *name,
 			    char *fmt, va_list ap)
 {
 	struct trace_seq *s = &iter->seq;
 
 	trace_seq_printf(s, "%s: ", name);
-	trace_seq_vprintf(s, fmt, ap);
+	trace_seq_vprintf(s, trace_event_format(iter, fmt), ap);
 
 	return trace_handle_return(s);
 }
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a267c9b6bcef..756523e5402a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -45,6 +45,7 @@ static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     int proto, gfp_t prio, int kern);
+static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
 {
@@ -1414,6 +1415,7 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	l2cap_sock_cleanup_listen(sk);
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, SHUT_RDWR);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1e9fab79e245..d594cd501861 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3330,17 +3330,24 @@ static int linger_reg_commit_wait(struct ceph_osd_linger_request *lreq)
 	int ret;
 
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
-	ret = wait_for_completion_interruptible(&lreq->reg_commit_wait);
+	ret = wait_for_completion_killable(&lreq->reg_commit_wait);
 	return ret ?: lreq->reg_commit_error;
 }
 
-static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq)
+static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq,
+				     unsigned long timeout)
 {
-	int ret;
+	long left;
 
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
-	ret = wait_for_completion_interruptible(&lreq->notify_finish_wait);
-	return ret ?: lreq->notify_finish_error;
+	left = wait_for_completion_killable_timeout(&lreq->notify_finish_wait,
+						ceph_timeout_jiffies(timeout));
+	if (left <= 0)
+		left = left ?: -ETIMEDOUT;
+	else
+		left = lreq->notify_finish_error; /* completed */
+
+	return left;
 }
 
 /*
@@ -4888,7 +4895,8 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	linger_submit(lreq);
 	ret = linger_reg_commit_wait(lreq);
 	if (!ret)
-		ret = linger_notify_finish_wait(lreq);
+		ret = linger_notify_finish_wait(lreq,
+				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
 	else
 		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d67d06d6b817..a811fe0f0f6f 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -446,8 +446,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 		return ERR_PTR(-EPERM);
 
 	nla_for_each_nested(nla, nla_stgs, rem) {
-		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
+		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD) {
+			if (nla_len(nla) != sizeof(u32))
+				return ERR_PTR(-EINVAL);
 			nr_maps++;
+		}
 	}
 
 	diag = kzalloc(sizeof(*diag) + sizeof(diag->maps[0]) * nr_maps,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d3c03ebf06a5..ce37a052b9c3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4897,13 +4897,17 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (br_spec) {
 		nla_for_each_nested(attr, br_spec, rem) {
-			if (nla_type(attr) == IFLA_BRIDGE_FLAGS) {
+			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
 				if (nla_len(attr) < sizeof(flags))
 					return -EINVAL;
 
 				have_flags = true;
 				flags = nla_get_u16(attr);
-				break;
+			}
+
+			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
+				if (nla_len(attr) < sizeof(u16))
+					return -EINVAL;
 			}
 		}
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index 4e00c6e2cb43..98f4b4a80de4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1183,7 +1183,8 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			cmpxchg(&sk->sk_pacing_status,
 				SK_PACING_NONE,
 				SK_PACING_NEEDED);
-		sk->sk_max_pacing_rate = ulval;
+		/* Pairs with READ_ONCE() from sk_getsockopt() */
+		WRITE_ONCE(sk->sk_max_pacing_rate, ulval);
 		sk->sk_pacing_rate = min(sk->sk_pacing_rate, ulval);
 		break;
 		}
@@ -1331,11 +1332,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_SNDBUF:
-		v.val = sk->sk_sndbuf;
+		v.val = READ_ONCE(sk->sk_sndbuf);
 		break;
 
 	case SO_RCVBUF:
-		v.val = sk->sk_rcvbuf;
+		v.val = READ_ONCE(sk->sk_rcvbuf);
 		break;
 
 	case SO_REUSEADDR:
@@ -1422,7 +1423,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVLOWAT:
-		v.val = sk->sk_rcvlowat;
+		v.val = READ_ONCE(sk->sk_rcvlowat);
 		break;
 
 	case SO_SNDLOWAT:
@@ -1516,7 +1517,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (!sock->ops->set_peek_off)
 			return -EOPNOTSUPP;
 
-		v.val = sk->sk_peek_off;
+		v.val = READ_ONCE(sk->sk_peek_off);
 		break;
 	case SO_NOFCS:
 		v.val = sock_flag(sk, SOCK_NOFCS);
@@ -1546,17 +1547,19 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
-		v.val = sk->sk_ll_usec;
+		v.val = READ_ONCE(sk->sk_ll_usec);
 		break;
 #endif
 
 	case SO_MAX_PACING_RATE:
+		/* The READ_ONCE() pair with the WRITE_ONCE() in sk_setsockopt() */
 		if (sizeof(v.ulval) != sizeof(v.val) && len >= sizeof(v.ulval)) {
 			lv = sizeof(v.ulval);
-			v.ulval = sk->sk_max_pacing_rate;
+			v.ulval = READ_ONCE(sk->sk_max_pacing_rate);
 		} else {
 			/* 32bit version */
-			v.val = min_t(unsigned long, sk->sk_max_pacing_rate, ~0U);
+			v.val = min_t(unsigned long, ~0U,
+				      READ_ONCE(sk->sk_max_pacing_rate));
 		}
 		break;
 
@@ -2742,7 +2745,7 @@ EXPORT_SYMBOL(__sk_mem_reclaim);
 
 int sk_set_peek_off(struct sock *sk, int val)
 {
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sk_set_peek_off);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index ee5d3f49b0b5..f375ef150149 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -122,7 +122,6 @@ static void sock_map_sk_acquire(struct sock *sk)
 	__acquires(&sk->sk_lock.slock)
 {
 	lock_sock(sk);
-	preempt_disable();
 	rcu_read_lock();
 }
 
@@ -130,7 +129,6 @@ static void sock_map_sk_release(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 {
 	rcu_read_unlock();
-	preempt_enable();
 	release_sock(sk);
 }
 
diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 2535d3dfb92c..c0fb70936ca1 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -946,7 +946,7 @@ static int dcbnl_bcn_setcfg(struct net_device *netdev, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 
 	ret = nla_parse_nested_deprecated(data, DCB_BCN_ATTR_MAX,
-					  tb[DCB_ATTR_BCN], dcbnl_pfc_up_nest,
+					  tb[DCB_ATTR_BCN], dcbnl_bcn_nest,
 					  NULL);
 	if (ret)
 		return ret;
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index f3ca6eea2ca3..a707fa1dbcaf 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -40,7 +40,7 @@ struct tcp_fastopen_metrics {
 
 struct tcp_metrics_block {
 	struct tcp_metrics_block __rcu	*tcpm_next;
-	possible_net_t			tcpm_net;
+	struct net			*tcpm_net;
 	struct inetpeer_addr		tcpm_saddr;
 	struct inetpeer_addr		tcpm_daddr;
 	unsigned long			tcpm_stamp;
@@ -51,34 +51,38 @@ struct tcp_metrics_block {
 	struct rcu_head			rcu_head;
 };
 
-static inline struct net *tm_net(struct tcp_metrics_block *tm)
+static inline struct net *tm_net(const struct tcp_metrics_block *tm)
 {
-	return read_pnet(&tm->tcpm_net);
+	/* Paired with the WRITE_ONCE() in tcpm_new() */
+	return READ_ONCE(tm->tcpm_net);
 }
 
 static bool tcp_metric_locked(struct tcp_metrics_block *tm,
 			      enum tcp_metric_index idx)
 {
-	return tm->tcpm_lock & (1 << idx);
+	/* Paired with WRITE_ONCE() in tcpm_suck_dst() */
+	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
 }
 
-static u32 tcp_metric_get(struct tcp_metrics_block *tm,
+static u32 tcp_metric_get(const struct tcp_metrics_block *tm,
 			  enum tcp_metric_index idx)
 {
-	return tm->tcpm_vals[idx];
+	/* Paired with WRITE_ONCE() in tcp_metric_set() */
+	return READ_ONCE(tm->tcpm_vals[idx]);
 }
 
 static void tcp_metric_set(struct tcp_metrics_block *tm,
 			   enum tcp_metric_index idx,
 			   u32 val)
 {
-	tm->tcpm_vals[idx] = val;
+	/* Paired with READ_ONCE() in tcp_metric_get() */
+	WRITE_ONCE(tm->tcpm_vals[idx], val);
 }
 
 static bool addr_same(const struct inetpeer_addr *a,
 		      const struct inetpeer_addr *b)
 {
-	return inetpeer_addr_cmp(a, b) == 0;
+	return (a->family == b->family) && !inetpeer_addr_cmp(a, b);
 }
 
 struct tcpm_hash_bucket {
@@ -89,6 +93,7 @@ static struct tcpm_hash_bucket	*tcp_metrics_hash __read_mostly;
 static unsigned int		tcp_metrics_hash_log __read_mostly;
 
 static DEFINE_SPINLOCK(tcp_metrics_lock);
+static DEFINE_SEQLOCK(fastopen_seqlock);
 
 static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 			  const struct dst_entry *dst,
@@ -97,7 +102,7 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 	u32 msval;
 	u32 val;
 
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 
 	val = 0;
 	if (dst_metric_locked(dst, RTAX_RTT))
@@ -110,30 +115,42 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 		val |= 1 << TCP_METRIC_CWND;
 	if (dst_metric_locked(dst, RTAX_REORDERING))
 		val |= 1 << TCP_METRIC_REORDERING;
-	tm->tcpm_lock = val;
+	/* Paired with READ_ONCE() in tcp_metric_locked() */
+	WRITE_ONCE(tm->tcpm_lock, val);
 
 	msval = dst_metric_raw(dst, RTAX_RTT);
-	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
+	tcp_metric_set(tm, TCP_METRIC_RTT, msval * USEC_PER_MSEC);
 
 	msval = dst_metric_raw(dst, RTAX_RTTVAR);
-	tm->tcpm_vals[TCP_METRIC_RTTVAR] = msval * USEC_PER_MSEC;
-	tm->tcpm_vals[TCP_METRIC_SSTHRESH] = dst_metric_raw(dst, RTAX_SSTHRESH);
-	tm->tcpm_vals[TCP_METRIC_CWND] = dst_metric_raw(dst, RTAX_CWND);
-	tm->tcpm_vals[TCP_METRIC_REORDERING] = dst_metric_raw(dst, RTAX_REORDERING);
+	tcp_metric_set(tm, TCP_METRIC_RTTVAR, msval * USEC_PER_MSEC);
+	tcp_metric_set(tm, TCP_METRIC_SSTHRESH,
+		       dst_metric_raw(dst, RTAX_SSTHRESH));
+	tcp_metric_set(tm, TCP_METRIC_CWND,
+		       dst_metric_raw(dst, RTAX_CWND));
+	tcp_metric_set(tm, TCP_METRIC_REORDERING,
+		       dst_metric_raw(dst, RTAX_REORDERING));
 	if (fastopen_clear) {
+		write_seqlock(&fastopen_seqlock);
 		tm->tcpm_fastopen.mss = 0;
 		tm->tcpm_fastopen.syn_loss = 0;
 		tm->tcpm_fastopen.try_exp = 0;
 		tm->tcpm_fastopen.cookie.exp = false;
 		tm->tcpm_fastopen.cookie.len = 0;
+		write_sequnlock(&fastopen_seqlock);
 	}
 }
 
 #define TCP_METRICS_TIMEOUT		(60 * 60 * HZ)
 
-static void tcpm_check_stamp(struct tcp_metrics_block *tm, struct dst_entry *dst)
+static void tcpm_check_stamp(struct tcp_metrics_block *tm,
+			     const struct dst_entry *dst)
 {
-	if (tm && unlikely(time_after(jiffies, tm->tcpm_stamp + TCP_METRICS_TIMEOUT)))
+	unsigned long limit;
+
+	if (!tm)
+		return;
+	limit = READ_ONCE(tm->tcpm_stamp) + TCP_METRICS_TIMEOUT;
+	if (unlikely(time_after(jiffies, limit)))
 		tcpm_suck_dst(tm, dst, false);
 }
 
@@ -174,20 +191,23 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 		oldest = deref_locked(tcp_metrics_hash[hash].chain);
 		for (tm = deref_locked(oldest->tcpm_next); tm;
 		     tm = deref_locked(tm->tcpm_next)) {
-			if (time_before(tm->tcpm_stamp, oldest->tcpm_stamp))
+			if (time_before(READ_ONCE(tm->tcpm_stamp),
+					READ_ONCE(oldest->tcpm_stamp)))
 				oldest = tm;
 		}
 		tm = oldest;
 	} else {
-		tm = kmalloc(sizeof(*tm), GFP_ATOMIC);
+		tm = kzalloc(sizeof(*tm), GFP_ATOMIC);
 		if (!tm)
 			goto out_unlock;
 	}
-	write_pnet(&tm->tcpm_net, net);
+	/* Paired with the READ_ONCE() in tm_net() */
+	WRITE_ONCE(tm->tcpm_net, net);
+
 	tm->tcpm_saddr = *saddr;
 	tm->tcpm_daddr = *daddr;
 
-	tcpm_suck_dst(tm, dst, true);
+	tcpm_suck_dst(tm, dst, reclaim);
 
 	if (likely(!reclaim)) {
 		tm->tcpm_next = tcp_metrics_hash[hash].chain;
@@ -434,7 +454,7 @@ void tcp_update_metrics(struct sock *sk)
 					       tp->reordering);
 		}
 	}
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 out_unlock:
 	rcu_read_unlock();
 }
@@ -539,8 +559,6 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
 	return ret;
 }
 
-static DEFINE_SEQLOCK(fastopen_seqlock);
-
 void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
 			    struct tcp_fastopen_cookie *cookie)
 {
@@ -647,7 +665,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 	}
 
 	if (nla_put_msecs(msg, TCP_METRICS_ATTR_AGE,
-			  jiffies - tm->tcpm_stamp,
+			  jiffies - READ_ONCE(tm->tcpm_stamp),
 			  TCP_METRICS_ATTR_PAD) < 0)
 		goto nla_put_failure;
 
@@ -658,7 +676,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 		if (!nest)
 			goto nla_put_failure;
 		for (i = 0; i < TCP_METRIC_MAX_KERNEL + 1; i++) {
-			u32 val = tm->tcpm_vals[i];
+			u32 val = tcp_metric_get(tm, i);
 
 			if (!val)
 				continue;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d5d10496b4ae..9b414681500a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2555,12 +2555,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			ipv6_ifa_notify(0, ift);
 	}
 
-	if ((create || list_empty(&idev->tempaddr_list)) &&
-	    idev->cnf.use_tempaddr > 0) {
+	/* Also create a temporary address if it's enabled but no temporary
+	 * address currently exists.
+	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
+	 * as part of cleanup (ie. deleting the mngtmpaddr).
+	 * We don't want that to result in creating a new temporary ip address.
+	 */
+	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+		create = true;
+
+	if (create && idev->cnf.use_tempaddr > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
-		 * Also create a temporary address if it's enabled but
-		 * no temporary address currently exists.
 		 */
 		read_unlock_bh(&idev->lock);
 		ipv6_create_tempaddr(ifp, false);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 5f0ac47acc74..c758d0cc6146 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1069,7 +1069,7 @@ static int ip6mr_cache_report(struct mr_table *mrt, struct sk_buff *pkt,
 		   And all this only to mangle msg->im6_msgtype and
 		   to set msg->im6_mbz to "mbz" :-)
 		 */
-		skb_push(skb, -skb_network_offset(pkt));
+		__skb_pull(skb, skb_network_offset(pkt));
 
 		skb_push(skb, sizeof(*msg));
 		skb_reset_transport_header(skb);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 356416564d9f..19653b8784bb 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3350,8 +3350,6 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
-			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
 		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
@@ -3364,6 +3362,9 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		return -EINVAL;
 	}
 
+	if (nft_chain_is_bound(chain))
+		return -EOPNOTSUPP;
+
 	if (nla[NFTA_RULE_HANDLE]) {
 		handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_HANDLE]));
 		rule = __nft_rule_lookup(chain, handle);
@@ -4576,10 +4577,9 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 				       enum nft_data_types type,
 				       unsigned int len);
 
-static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
-					struct nft_set *set,
-					const struct nft_set_iter *iter,
-					struct nft_set_elem *elem)
+static int nft_setelem_data_validate(const struct nft_ctx *ctx,
+				     struct nft_set *set,
+				     struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	enum nft_registers dreg;
@@ -4591,6 +4591,14 @@ static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
 					   set->dlen);
 }
 
+static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
+					struct nft_set *set,
+					const struct nft_set_iter *iter,
+					struct nft_set_elem *elem)
+{
+	return nft_setelem_data_validate(ctx, set, elem);
+}
+
 int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 		       struct nft_set_binding *binding)
 {
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 6b0efab4fad0..6bf1c852e8ea 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -125,15 +125,27 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
+static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
+					   struct nft_chain *chain,
+					   enum nft_trans_phase phase)
+{
+	struct nft_ctx chain_ctx;
+	struct nft_rule *rule;
+
+	chain_ctx = *ctx;
+	chain_ctx.chain = chain;
+
+	list_for_each_entry(rule, &chain->rules, list)
+		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+}
+
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 	const struct nft_data *data = &priv->data;
-	struct nft_ctx chain_ctx;
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (priv->dreg == NFT_REG_VERDICT) {
 		switch (data->verdict.code) {
@@ -143,20 +155,17 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 			if (!nft_chain_binding(chain))
 				break;
 
-			chain_ctx = *ctx;
-			chain_ctx.chain = chain;
-
-			list_for_each_entry(rule, &chain->rules, list)
-				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
-
 			switch (phase) {
 			case NFT_TRANS_PREPARE_ERROR:
 				nf_tables_unbind_chain(ctx, chain);
-				fallthrough;
+				nft_deactivate_next(ctx->net, chain);
+				break;
 			case NFT_TRANS_PREPARE:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_deactivate_next(ctx->net, chain);
 				break;
 			default:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
 				chain->table->use--;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 172b994790a0..eae760adae4d 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -216,29 +216,37 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
-			      struct nft_rbtree_elem *rbe)
+			      struct nft_rbtree_elem *rbe,
+			      u8 genmask)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
-	struct nft_rbtree_elem *rbe_prev = NULL;
+	struct nft_rbtree_elem *rbe_prev;
 	struct nft_set_gc_batch *gcb;
 
 	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
 	if (!gcb)
 		return -ENOMEM;
 
-	/* search for expired end interval coming before this element. */
+	/* search for end interval coming before this element.
+	 * end intervals don't carry a timeout extension, they
+	 * are coupled with the interval start element.
+	 */
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
-		if (nft_rbtree_interval_end(rbe_prev))
+		if (nft_rbtree_interval_end(rbe_prev) &&
+		    nft_set_elem_active(&rbe_prev->ext, genmask))
 			break;
 
 		prev = rb_prev(prev);
 	}
 
-	if (rbe_prev) {
+	if (prev) {
+		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+
 		rb_erase(&rbe_prev->node, &priv->root);
 		atomic_dec(&set->nelems);
+		nft_set_gc_batch_add(gcb, rbe_prev);
 	}
 
 	rb_erase(&rbe->node, &priv->root);
@@ -320,7 +328,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		/* perform garbage collection to avoid bogus overlap reports. */
 		if (nft_set_elem_expired(&rbe->ext)) {
-			err = nft_rbtree_gc_elem(set, priv, rbe);
+			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
 
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 41f0898a5a56..08c41f1976c4 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -266,7 +266,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 		fnew->ifindex = f->ifindex;
 		fnew->tp = f->tp;
 
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index b775e681cb56..1ad4b3e60eb3 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -511,7 +511,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 1ac8ff445a6d..b2d2ba561eba 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -812,7 +812,6 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 
 	new->ifindex = n->ifindex;
 	new->fshift = n->fshift;
-	new->res = n->res;
 	new->flags = n->flags;
 	RCU_INIT_POINTER(new->ht_down, ht);
 
@@ -999,18 +998,62 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return -EINVAL;
 	}
 
+	/* At this point, we need to derive the new handle that will be used to
+	 * uniquely map the identity of this table match entry. The
+	 * identity of the entry that we need to construct is 32 bits made of:
+	 *     htid(12b):bucketid(8b):node/entryid(12b)
+	 *
+	 * At this point _we have the table(ht)_ in which we will insert this
+	 * entry. We carry the table's id in variable "htid".
+	 * Note that earlier code picked the ht selection either by a) the user
+	 * providing the htid specified via TCA_U32_HASH attribute or b) when
+	 * no such attribute is passed then the root ht, is default to at ID
+	 * 0x[800][00][000]. Rule: the root table has a single bucket with ID 0.
+	 * If OTOH the user passed us the htid, they may also pass a bucketid of
+	 * choice. 0 is fine. For example a user htid is 0x[600][01][000] it is
+	 * indicating hash bucketid of 1. Rule: the entry/node ID _cannot_ be
+	 * passed via the htid, so even if it was non-zero it will be ignored.
+	 *
+	 * We may also have a handle, if the user passed one. The handle also
+	 * carries the same addressing of htid(12b):bucketid(8b):node/entryid(12b).
+	 * Rule: the bucketid on the handle is ignored even if one was passed;
+	 * rather the value on "htid" is always assumed to be the bucketid.
+	 */
 	if (handle) {
+		/* Rule: The htid from handle and tableid from htid must match */
 		if (TC_U32_HTID(handle) && TC_U32_HTID(handle ^ htid)) {
 			NL_SET_ERR_MSG_MOD(extack, "Handle specified hash table address mismatch");
 			return -EINVAL;
 		}
-		handle = htid | TC_U32_NODE(handle);
-		err = idr_alloc_u32(&ht->handle_idr, NULL, &handle, handle,
-				    GFP_KERNEL);
-		if (err)
-			return err;
-	} else
+		/* Ok, so far we have a valid htid(12b):bucketid(8b) but we
+		 * need to finalize the table entry identification with the last
+		 * part - the node/entryid(12b)). Rule: Nodeid _cannot be 0_ for
+		 * entries. Rule: nodeid of 0 is reserved only for tables(see
+		 * earlier code which processes TC_U32_DIVISOR attribute).
+		 * Rule: The nodeid can only be derived from the handle (and not
+		 * htid).
+		 * Rule: if the handle specified zero for the node id example
+		 * 0x60000000, then pick a new nodeid from the pool of IDs
+		 * this hash table has been allocating from.
+		 * If OTOH it is specified (i.e for example the user passed a
+		 * handle such as 0x60000123), then we use it generate our final
+		 * handle which is used to uniquely identify the match entry.
+		 */
+		if (!TC_U32_NODE(handle)) {
+			handle = gen_new_kid(ht, htid);
+		} else {
+			handle = htid | TC_U32_NODE(handle);
+			err = idr_alloc_u32(&ht->handle_idr, NULL, &handle,
+					    handle, GFP_KERNEL);
+			if (err)
+				return err;
+		}
+	} else {
+		/* The user did not give us a handle; lets just generate one
+		 * from the table's pool of nodeids.
+		 */
 		handle = gen_new_kid(ht, htid);
+	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
 		NL_SET_ERR_MSG_MOD(extack, "Selector not specified");
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 50e15add6068..56d3dc5e95c7 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -130,6 +130,97 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
+static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
+			       struct nlattr *opt,
+			       struct netlink_ext_ack *extack)
+{
+	struct mqprio_sched *priv = qdisc_priv(sch);
+	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
+	struct nlattr *attr;
+	int i, rem, err;
+
+	err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
+			 sizeof(*qopt));
+	if (err < 0)
+		return err;
+
+	if (!qopt->hw) {
+		NL_SET_ERR_MSG(extack,
+			       "mqprio TCA_OPTIONS can only contain netlink attributes in hardware mode");
+		return -EINVAL;
+	}
+
+	if (tb[TCA_MQPRIO_MODE]) {
+		priv->flags |= TC_MQPRIO_F_MODE;
+		priv->mode = *(u16 *)nla_data(tb[TCA_MQPRIO_MODE]);
+	}
+
+	if (tb[TCA_MQPRIO_SHAPER]) {
+		priv->flags |= TC_MQPRIO_F_SHAPER;
+		priv->shaper = *(u16 *)nla_data(tb[TCA_MQPRIO_SHAPER]);
+	}
+
+	if (tb[TCA_MQPRIO_MIN_RATE64]) {
+		if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_MQPRIO_MIN_RATE64],
+					    "min_rate accepted only when shaper is in bw_rlimit mode");
+			return -EINVAL;
+		}
+		i = 0;
+		nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
+				    rem) {
+			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute type expected to be TCA_MQPRIO_MIN_RATE64");
+				return -EINVAL;
+			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MIN_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
+			if (i >= qopt->num_tc)
+				break;
+			priv->min_rate[i] = *(u64 *)nla_data(attr);
+			i++;
+		}
+		priv->flags |= TC_MQPRIO_F_MIN_RATE;
+	}
+
+	if (tb[TCA_MQPRIO_MAX_RATE64]) {
+		if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_MQPRIO_MAX_RATE64],
+					    "max_rate accepted only when shaper is in bw_rlimit mode");
+			return -EINVAL;
+		}
+		i = 0;
+		nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
+				    rem) {
+			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute type expected to be TCA_MQPRIO_MAX_RATE64");
+				return -EINVAL;
+			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MAX_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
+			if (i >= qopt->num_tc)
+				break;
+			priv->max_rate[i] = *(u64 *)nla_data(attr);
+			i++;
+		}
+		priv->flags |= TC_MQPRIO_F_MAX_RATE;
+	}
+
+	return 0;
+}
+
 static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 		       struct netlink_ext_ack *extack)
 {
@@ -139,9 +230,6 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *qdisc;
 	int i, err = -EOPNOTSUPP;
 	struct tc_mqprio_qopt *qopt = NULL;
-	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
-	struct nlattr *attr;
-	int rem;
 	int len;
 
 	BUILD_BUG_ON(TC_MAX_QUEUE != TC_QOPT_MAX_QUEUE);
@@ -166,55 +254,9 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 
 	len = nla_len(opt) - NLA_ALIGN(sizeof(*qopt));
 	if (len > 0) {
-		err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
-				 sizeof(*qopt));
-		if (err < 0)
+		err = mqprio_parse_nlattr(sch, qopt, opt, extack);
+		if (err)
 			return err;
-
-		if (!qopt->hw)
-			return -EINVAL;
-
-		if (tb[TCA_MQPRIO_MODE]) {
-			priv->flags |= TC_MQPRIO_F_MODE;
-			priv->mode = *(u16 *)nla_data(tb[TCA_MQPRIO_MODE]);
-		}
-
-		if (tb[TCA_MQPRIO_SHAPER]) {
-			priv->flags |= TC_MQPRIO_F_SHAPER;
-			priv->shaper = *(u16 *)nla_data(tb[TCA_MQPRIO_SHAPER]);
-		}
-
-		if (tb[TCA_MQPRIO_MIN_RATE64]) {
-			if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE)
-				return -EINVAL;
-			i = 0;
-			nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
-					    rem) {
-				if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64)
-					return -EINVAL;
-				if (i >= qopt->num_tc)
-					break;
-				priv->min_rate[i] = *(u64 *)nla_data(attr);
-				i++;
-			}
-			priv->flags |= TC_MQPRIO_F_MIN_RATE;
-		}
-
-		if (tb[TCA_MQPRIO_MAX_RATE64]) {
-			if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE)
-				return -EINVAL;
-			i = 0;
-			nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
-					    rem) {
-				if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64)
-					return -EINVAL;
-				if (i >= qopt->num_tc)
-					break;
-				priv->max_rate[i] = *(u64 *)nla_data(attr);
-				i++;
-			}
-			priv->flags |= TC_MQPRIO_F_MAX_RATE;
-		}
 	}
 
 	/* pre-allocate qdisc, attachment can't fail */
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index de63d6d41645..2784d6989211 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1964,7 +1964,8 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 
 	skb_reset_network_header(*skb);
 	skb_pull(*skb, tipc_ehdr_size(ehdr));
-	pskb_trim(*skb, (*skb)->len - aead->authsize);
+	if (pskb_trim(*skb, (*skb)->len - aead->authsize))
+		goto free_skb;
 
 	/* Validate TIPCv2 message */
 	if (unlikely(!tipc_msg_validate(skb))) {
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 38f61dccb855..9e3cfeb82a23 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -567,7 +567,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
+		tipc_node_put(n);
 		n = NULL;
 		goto exit;
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2fe0efcbfed1..3aa783a23c5f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -697,7 +697,7 @@ static int unix_set_peek_off(struct sock *sk, int val)
 	if (mutex_lock_interruptible(&u->iolock))
 		return -EINTR;
 
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	mutex_unlock(&u->iolock);
 
 	return 0;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 671c7f83d5fc..f59691936e5b 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -641,7 +641,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 
 	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
 	if (ret)
-		return ret;
+		return 0;
 
 	/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
 	while (pos + sizeof(*ap_info) <= end) {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6bfc7e28515a..db8593d79431 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9015,6 +9015,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 70260e0a8f09..3ff73367897d 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -19,6 +19,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
+const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index c61b17dc2af8..4b026e1c3fe3 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -825,13 +825,6 @@ int __maybe_unused cs42l51_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs42l51_resume);
 
-const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-EXPORT_SYMBOL_GPL(cs42l51_of_match);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 9d06cf7f8876..4f13c38484b7 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -16,7 +16,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap);
 int cs42l51_remove(struct device *dev);
 int __maybe_unused cs42l51_suspend(struct device *dev);
 int __maybe_unused cs42l51_resume(struct device *dev);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index cc96c9bdff41..c90e776f7a54 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2306,6 +2306,9 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
+	/* Fill the cache for the ADC test register */
+	regmap_read(wm8904->regmap, WM8904_ADC_TEST_0, &val);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index d01e8d516df1..64b85b786bf6 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -612,6 +612,8 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(regmap, REG_SPDIF_SCR, dmaen, 0);
 		regmap_update_bits(regmap, REG_SPDIF_SIE, intr, 0);
+		regmap_write(regmap, REG_SPDIF_STL, 0x0);
+		regmap_write(regmap, REG_SPDIF_STR, 0x0);
 		break;
 	default:
 		return -EINVAL;
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 00d2e0e2e0c2..319f36ebb9a4 100644
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,12 @@
 
 set -e
 
+# skip if there's no gcc
+if ! [ -x "$(command -v gcc)" ]; then
+        echo "failed: no gcc compiler"
+        exit 2
+fi
+
 temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
 
 cleanup()
@@ -11,7 +17,7 @@ cleanup()
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo
+		perf probe -x ${temp_dir}/testfile -d foo || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 1a4c11a444d9..8867c40258b5 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,3 +6,4 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 986b9458efb2..b736a5169aad 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -32,9 +32,17 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-static const ptrdiff_t *libc_rseq_offset_p;
-static const unsigned int *libc_rseq_size_p;
-static const unsigned int *libc_rseq_flags_p;
+/*
+ * Define weak versions to play nice with binaries that are statically linked
+ * against a libc that doesn't support registering its own rseq.
+ */
+__weak ptrdiff_t __rseq_offset;
+__weak unsigned int __rseq_size;
+__weak unsigned int __rseq_flags;
+
+static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
+static const unsigned int *libc_rseq_size_p = &__rseq_size;
+static const unsigned int *libc_rseq_flags_p = &__rseq_flags;
 
 /* Offset from the thread pointer to the rseq area.  */
 ptrdiff_t rseq_offset;
@@ -108,10 +116,19 @@ int rseq_unregister_current_thread(void)
 static __attribute__((constructor))
 void rseq_init(void)
 {
-	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
-	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
-	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
-	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p) {
+	/*
+	 * If the libc's registered rseq size isn't already valid, it may be
+	 * because the binary is dynamically linked and not necessarily due to
+	 * libc not having registered a restartable sequence.  Try to find the
+	 * symbols if that's the case.
+	 */
+	if (!*libc_rseq_size_p) {
+		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
+		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
+		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
+	}
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
+			*libc_rseq_size_p != 0) {
 		/* rseq registration owned by glibc */
 		rseq_offset = *libc_rseq_offset_p;
 		rseq_size = *libc_rseq_size_p;
