Return-Path: <linux-kernel+bounces-88449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B21986E1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E17FB23461
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DF70CB0;
	Fri,  1 Mar 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDe1zg8M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6166E2B8;
	Fri,  1 Mar 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298951; cv=none; b=kbymj2T+tDOOOL5AOBpy3aQgoTSsCyC76znAiKUd6syzi9Nox/cCoEtNg76JDY0NptotmlbDqef+MZwPo5ZDLPo++sS0i7PaWMVxfFZw7bBJuHbj/uKEi7oe6dsenBOXqUoxgtVOCobYcjve5mlS2NIh2T/bbAMZjISFiQDNAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298951; c=relaxed/simple;
	bh=RmChQgG7MacPMMGTJeCcyz5Z77Harzv4uXxVv1pUY/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQuS1aIukggTd1AVRp0Yri1GMVvd29NMsgwB8OyUtbwuGPCk/e43PKQgffXUiUL9Fv0HfsEuYy1UZEURKRjcmJrRP7uMnBtYTOztzDZZN/MMJ6JU9zXr3NdVgAoFGYqgkrRHbMsYXgBeEcrFtheb5lUoXe+UaH3k5dNUrt6SeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDe1zg8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F33C43394;
	Fri,  1 Mar 2024 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298950;
	bh=RmChQgG7MacPMMGTJeCcyz5Z77Harzv4uXxVv1pUY/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDe1zg8MiuTaGtNwq4eheXE1+8H+tlI6SNbCCTjLgEBg6AC6fEPq3FNPB+BkDa6QG
	 rILttgGBSEXF/xvSFcCbLSbxj7ndNlLNcskNotpipVkR3Gj5jIsBDWwDCcg+VLmN0v
	 Mp1BaNvf7a2Qq3QoBKX4N6VlVCqgcwEWmvZN/Ixc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.211
Date: Fri,  1 Mar 2024 14:15:40 +0100
Message-ID: <2024030140-vacate-starlight-50e7@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030140-spendable-turtle-d886@gregkh>
References: <2024030140-spendable-turtle-d886@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 6e9ee164b9df..dc55a86e0f7d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 210
+SUBLEVEL = 211
 EXTRAVERSION =
 NAME = Dare mighty things
 
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
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 08332f70a8dc..51491b7418e4 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -981,6 +981,8 @@ usdhc1: mmc@2190000 {
 					 <&clks IMX6SX_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -993,6 +995,8 @@ usdhc2: mmc@2194000 {
 					 <&clks IMX6SX_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -1005,6 +1009,8 @@ usdhc3: mmc@2198000 {
 					 <&clks IMX6SX_CLK_USDHC3>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 6fb19a393fd2..c06ae33dc53e 100644
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
index 0d6761074b11..f241e7c318bc 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -577,6 +577,7 @@ spi0: spi@ff1d0000 {
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac 12>, <&dmac 13>;
 		dma-names = "tx", "rx";
+		num-cs = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_csn &spi0_miso &spi0_mosi>;
 		#address-cells = <1>;
@@ -592,6 +593,7 @@ spi1: spi@ff1d8000 {
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac 14>, <&dmac 15>;
 		dma-names = "tx", "rx";
+		num-cs = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_csn0 &spi1_csn1 &spi1_miso &spi1_mosi>;
 		#address-cells = <1>;
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 62f261b8eb62..93c0365cdd7b 100644
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
 
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 6e5bed50c357..ca3374c6f374 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -504,6 +504,11 @@ static bool is_larx_stcx_instr(int type)
 	return type == LARX || type == STCX;
 }
 
+static bool is_octword_vsx_instr(int type, int size)
+{
+	return ((type == LOAD_VSX || type == STORE_VSX) && size == 32);
+}
+
 /*
  * We've failed in reliably handling the hw-breakpoint. Unregister
  * it and throw a warning message to let the user know about it.
@@ -554,6 +559,63 @@ static bool stepping_handler(struct pt_regs *regs, struct perf_event **bp,
 	return true;
 }
 
+static void handle_p10dd1_spurious_exception(struct arch_hw_breakpoint **info,
+					     int *hit, unsigned long ea)
+{
+	int i;
+	unsigned long hw_end_addr;
+
+	/*
+	 * Handle spurious exception only when any bp_per_reg is set.
+	 * Otherwise this might be created by xmon and not actually a
+	 * spurious exception.
+	 */
+	for (i = 0; i < nr_wp_slots(); i++) {
+		if (!info[i])
+			continue;
+
+		hw_end_addr = ALIGN(info[i]->address + info[i]->len, HW_BREAKPOINT_SIZE);
+
+		/*
+		 * Ending address of DAWR range is less than starting
+		 * address of op.
+		 */
+		if ((hw_end_addr - 1) >= ea)
+			continue;
+
+		/*
+		 * Those addresses need to be in the same or in two
+		 * consecutive 512B blocks;
+		 */
+		if (((hw_end_addr - 1) >> 10) != (ea >> 10))
+			continue;
+
+		/*
+		 * 'op address + 64B' generates an address that has a
+		 * carry into bit 52 (crosses 2K boundary).
+		 */
+		if ((ea & 0x800) == ((ea + 64) & 0x800))
+			continue;
+
+		break;
+	}
+
+	if (i == nr_wp_slots())
+		return;
+
+	for (i = 0; i < nr_wp_slots(); i++) {
+		if (info[i]) {
+			hit[i] = 1;
+			info[i]->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
+		}
+	}
+}
+
+/*
+ * Handle a DABR or DAWR exception.
+ *
+ * Called in atomic context.
+ */
 int hw_breakpoint_handler(struct die_args *args)
 {
 	bool err = false;
@@ -612,8 +674,14 @@ int hw_breakpoint_handler(struct die_args *args)
 		goto reset;
 
 	if (!nr_hit) {
-		rc = NOTIFY_DONE;
-		goto out;
+		/* Workaround for Power10 DD1 */
+		if (!IS_ENABLED(CONFIG_PPC_8xx) && mfspr(SPRN_PVR) == 0x800100 &&
+		    is_octword_vsx_instr(type, size)) {
+			handle_p10dd1_spurious_exception(info, hit, ea);
+		} else {
+			rc = NOTIFY_DONE;
+			goto out;
+		}
 	}
 
 	/*
@@ -674,6 +742,8 @@ NOKPROBE_SYMBOL(hw_breakpoint_handler);
 
 /*
  * Handle single-step exceptions following a DABR hit.
+ *
+ * Called in atomic context.
  */
 static int single_step_dabr_instruction(struct die_args *args)
 {
@@ -731,6 +801,8 @@ NOKPROBE_SYMBOL(single_step_dabr_instruction);
 
 /*
  * Handle debug exception notifications.
+ *
+ * Called in atomic context.
  */
 int hw_breakpoint_exceptions_notify(
 		struct notifier_block *unused, unsigned long val, void *data)
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 74799439b259..beecc36c3027 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -225,7 +225,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 /* combine single writes by using store-block insn */
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
-       zpci_memcpy_toio(to, from, count);
+	zpci_memcpy_toio(to, from, count * 8);
 }
 
 static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index dd5ea1bdf04c..75efc4c6f076 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -143,7 +143,7 @@ extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
 
 extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
 
-static inline struct entry_stack *cpu_entry_stack(int cpu)
+static __always_inline struct entry_stack *cpu_entry_stack(int cpu)
 {
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7b4782249a92..7711ba5342a1 100644
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
 
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index bf2561a5eb58..3616fd4ba395 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -414,6 +414,103 @@ do {									\
 
 #endif // CONFIG_CC_ASM_GOTO_OUTPUT
 
+#ifdef CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
+#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] ltype (__new)				\
+		     : "memory"						\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
+#ifdef CONFIG_X86_32
+#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({	\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       "+A" (__old),					\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u32)__new),				\
+		       "c" ((u32)((u64)__new >> 32))			\
+		     : "memory"						\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+#endif // CONFIG_X86_32
+#else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
+#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
+	int __err = 0;							\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     CC_SET(z)						\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : CC_OUT(z) (success),				\
+		       [errout] "+r" (__err),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] ltype (__new)				\
+		     : "memory");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
+#ifdef CONFIG_X86_32
+/*
+ * Unlike the normal CMPXCHG, hardcode ECX for both success/fail and error.
+ * There are only six GPRs available and four (EAX, EBX, ECX, and EDX) are
+ * hardcoded by CMPXCHG8B, leaving only ESI and EDI.  If the compiler uses
+ * both ESI and EDI for the memory operand, compilation will fail if the error
+ * is an input+output as there will be no register available for input.
+ */
+#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({	\
+	int __result;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
+		     "mov $0, %%ecx\n\t"				\
+		     "setz %%cl\n"					\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %%ecx) \
+		     : [result]"=c" (__result),				\
+		       "+A" (__old),					\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u32)__new),				\
+		       "c" ((u32)((u64)__new >> 32))			\
+		     : "memory", "cc");					\
+	if (unlikely(__result < 0))					\
+		goto label;						\
+	if (unlikely(!__result))					\
+		*_old = __old;						\
+	likely(__result);					})
+#endif // CONFIG_X86_32
+#endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
+
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct __user *)(x))
@@ -506,6 +603,51 @@ do {										\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+
+#ifndef CONFIG_X86_32
+#define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
+	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
+#endif
+
+/*
+ * Force the pointer to u<size> to match the size expected by the asm helper.
+ * clang/LLVM compiles all cases and only discards the unused paths after
+ * processing errors, which breaks i386 if the pointer is an 8-byte value.
+ */
+#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({			\
+	bool __ret;								\
+	__chk_user_ptr(_ptr);							\
+	switch (sizeof(*(_ptr))) {						\
+	case 1:	__ret = __try_cmpxchg_user_asm("b", "q",			\
+					       (__force u8 *)(_ptr), (_oldp),	\
+					       (_nval), _label);		\
+		break;								\
+	case 2:	__ret = __try_cmpxchg_user_asm("w", "r",			\
+					       (__force u16 *)(_ptr), (_oldp),	\
+					       (_nval), _label);		\
+		break;								\
+	case 4:	__ret = __try_cmpxchg_user_asm("l", "r",			\
+					       (__force u32 *)(_ptr), (_oldp),	\
+					       (_nval), _label);		\
+		break;								\
+	case 8:	__ret = __try_cmpxchg64_user_asm((__force u64 *)(_ptr), (_oldp),\
+						 (_nval), _label);		\
+		break;								\
+	default: __try_cmpxchg_user_wrong_size();				\
+	}									\
+	__ret;						})
+
+/* "Returns" 0 on success, 1 on failure, -EFAULT if the access faults. */
+#define __try_cmpxchg_user(_ptr, _oldp, _nval, _label)	({		\
+	int __ret = -EFAULT;						\
+	__uaccess_begin_nospec();					\
+	__ret = !unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label);	\
+_label:									\
+	__uaccess_end();						\
+	__ret;								\
+							})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9e0a3daa838c..9ceef8515c03 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -676,6 +676,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 }
 
 #ifdef CONFIG_RETHUNK
+
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
@@ -691,14 +692,18 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
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
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 6d546f4426ac..46447877b594 100644
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
index e21937680d1f..5bea8d93883a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -55,28 +55,16 @@ void __init default_banner(void)
 static const unsigned char ud2a[] = { 0x0f, 0x0b };
 
 struct branch {
-	unsigned char opcode;
-	u32 delta;
+       unsigned char opcode;
+       u32 delta;
 } __attribute__((packed));
 
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
index 759b986b7f03..273e9b77b730 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,7 +41,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 
 	case RET:
 		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, &__x86_return_thunk);
+			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
 		break;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8e3c3d8916dd..d7d592c09298 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -405,7 +405,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 	int cnt = 0;
 
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		emit_jump(&prog, &__x86_return_thunk, ip);
+		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_SLS))
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4297a8d69dbf..6f7f8e41404d 100644
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
@@ -594,11 +602,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
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
 
@@ -654,6 +662,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
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
@@ -946,11 +959,20 @@ static int ahci_pci_device_resume(struct device *dev)
 
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
@@ -1928,7 +1950,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_gtf_filter_workaround(host);
 
 	/* initialize adapter */
-	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
+	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7cc6feb17e97..b8db2b0d7414 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -244,6 +244,7 @@ enum {
 	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
 						      from phy_power_on() */
 	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
+	AHCI_HFLAG_43BIT_ONLY		= BIT(29), /* 43bit DMA addr limit */
 
 	/* ap->flags bits */
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 3e881fdb06e0..224450c90e45 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -456,10 +456,20 @@ static DEFINE_TIMER(fd_timer, check_change);
 	
 static void fd_end_request_cur(blk_status_t err)
 {
+	DPRINT(("fd_end_request_cur(), bytes %d of %d\n",
+		blk_rq_cur_bytes(fd_request),
+		blk_rq_bytes(fd_request)));
+
 	if (!blk_update_request(fd_request, err,
 				blk_rq_cur_bytes(fd_request))) {
+		DPRINT(("calling __blk_mq_end_request()\n"));
 		__blk_mq_end_request(fd_request, err);
 		fd_request = NULL;
+	} else {
+		/* requeue rest of request */
+		DPRINT(("calling blk_mq_requeue_request()\n"));
+		blk_mq_requeue_request(fd_request, true);
+		fd_request = NULL;
 	}
 }
 
@@ -653,9 +663,6 @@ static inline void copy_buffer(void *from, void *to)
 		*p2++ = *p1++;
 }
 
-  
-  
-
 /* General Interrupt Handling */
 
 static void (*FloppyIRQHandler)( int status ) = NULL;
@@ -700,12 +707,21 @@ static void fd_error( void )
 	if (fd_request->error_count >= MAX_ERRORS) {
 		printk(KERN_ERR "fd%d: too many errors.\n", SelectedDrive );
 		fd_end_request_cur(BLK_STS_IOERR);
+		finish_fdc();
+		return;
 	}
 	else if (fd_request->error_count == RECALIBRATE_ERRORS) {
 		printk(KERN_WARNING "fd%d: recalibrating\n", SelectedDrive );
 		if (SelectedDrive != -1)
 			SUD.track = -1;
 	}
+	/* need to re-run request to recalibrate */
+	atari_disable_irq( IRQ_MFP_FDC );
+
+	setup_req_params( SelectedDrive );
+	do_fd_action( SelectedDrive );
+
+	atari_enable_irq( IRQ_MFP_FDC );
 }
 
 
@@ -740,6 +756,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	if (type) {
 		if (--type >= NUM_DISK_MINORS ||
 		    minor2disktype[type].drive_types > DriveType) {
+			finish_fdc();
 			ret = -EINVAL;
 			goto out;
 		}
@@ -748,6 +765,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	}
 
 	if (!UDT || desc->track >= UDT->blocks/UDT->spt/2 || desc->head >= 2) {
+		finish_fdc();
 		ret = -EINVAL;
 		goto out;
 	}
@@ -788,6 +806,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 
 	wait_for_completion(&format_wait);
 
+	finish_fdc();
 	ret = FormatError ? -EIO : 0;
 out:
 	blk_mq_unquiesce_queue(q);
@@ -822,6 +841,7 @@ static void do_fd_action( int drive )
 		    else {
 			/* all sectors finished */
 			fd_end_request_cur(BLK_STS_OK);
+			finish_fdc();
 			return;
 		    }
 		}
@@ -1226,6 +1246,7 @@ static void fd_rwsec_done1(int status)
 	else {
 		/* all sectors finished */
 		fd_end_request_cur(BLK_STS_OK);
+		finish_fdc();
 	}
 	return;
   
@@ -1347,7 +1368,7 @@ static void fd_times_out(struct timer_list *unused)
 
 static void finish_fdc( void )
 {
-	if (!NeedSeek) {
+	if (!NeedSeek || !stdma_is_locked_by(floppy_irq)) {
 		finish_fdc_done( 0 );
 	}
 	else {
@@ -1382,7 +1403,8 @@ static void finish_fdc_done( int dummy )
 	start_motor_off_timer();
 
 	local_irq_save(flags);
-	stdma_release();
+	if (stdma_is_locked_by(floppy_irq))
+		stdma_release();
 	local_irq_restore(flags);
 
 	DPRINT(("finish_fdc() finished\n"));
@@ -1472,15 +1494,6 @@ static void setup_req_params( int drive )
 			ReqTrack, ReqSector, (unsigned long)ReqData ));
 }
 
-static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
-{
-	spin_lock_irq(&ataflop_lock);
-	atari_disable_irq(IRQ_MFP_FDC);
-	finish_fdc();
-	atari_enable_irq(IRQ_MFP_FDC);
-	spin_unlock_irq(&ataflop_lock);
-}
-
 static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
@@ -1488,6 +1501,10 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int drive = floppy - unit;
 	int type = floppy->type;
 
+	DPRINT(("Queue request: drive %d type %d sectors %d of %d last %d\n",
+		drive, type, blk_rq_cur_sectors(bd->rq),
+		blk_rq_sectors(bd->rq), bd->last));
+
 	spin_lock_irq(&ataflop_lock);
 	if (fd_request) {
 		spin_unlock_irq(&ataflop_lock);
@@ -1508,6 +1525,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		/* drive not connected */
 		printk(KERN_ERR "Unknown Device: fd%d\n", drive );
 		fd_end_request_cur(BLK_STS_IOERR);
+		stdma_release();
 		goto out;
 	}
 		
@@ -1524,11 +1542,13 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (--type >= NUM_DISK_MINORS) {
 			printk(KERN_WARNING "fd%d: invalid disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
+			stdma_release();
 			goto out;
 		}
 		if (minor2disktype[type].drive_types > DriveType)  {
 			printk(KERN_WARNING "fd%d: unsupported disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
+			stdma_release();
 			goto out;
 		}
 		type = minor2disktype[type].index;
@@ -1547,8 +1567,6 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	setup_req_params( drive );
 	do_fd_action( drive );
 
-	if (bd->last)
-		finish_fdc();
 	atari_enable_irq( IRQ_MFP_FDC );
 
 out:
@@ -1631,6 +1649,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* what if type > 0 here? Overwrite specified entry ? */
 		if (type) {
 		        /* refuse to re-set a predefined type for now */
+			finish_fdc();
 			return -EINVAL;
 		}
 
@@ -1698,8 +1717,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 
 		/* sanity check */
 		if (setprm.track != dtp->blocks/dtp->spt/2 ||
-		    setprm.head != 2)
+		    setprm.head != 2) {
+			finish_fdc();
 			return -EINVAL;
+		}
 
 		UDT = dtp;
 		set_capacity(floppy->disk, UDT->blocks);
@@ -1959,7 +1980,6 @@ static const struct block_device_operations floppy_fops = {
 
 static const struct blk_mq_ops ataflop_mq_ops = {
 	.queue_rq = ataflop_queue_rq,
-	.commit_rqs = ataflop_commit_rqs,
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b54eec9b17e..7eae3f373233 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -952,14 +952,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
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
 
@@ -977,7 +978,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
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
index f55a92ff12c0..86da3c7a5036 100644
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 54d6b4128721..3578e3b3536e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1456,6 +1456,7 @@ static int dm_sw_fini(void *handle)
 
 	if (adev->dm.dmub_srv) {
 		dmub_srv_destroy(adev->dm.dmub_srv);
+		kfree(adev->dm.dmub_srv);
 		adev->dm.dmub_srv = NULL;
 	}
 
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 738e60139db9..6ce446cc8878 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -387,6 +387,15 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	if (!syncobj)
 		return -ENOENT;
 
+	/* Waiting for userspace with locks help is illegal cause that can
+	 * trivial deadlock with page faults for example. Make lockdep complain
+	 * about it early on.
+	 */
+	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+		might_sleep();
+		lockdep_assert_none_held_once();
+	}
+
 	*fence = drm_syncobj_fence_get(syncobj);
 
 	if (*fence) {
@@ -951,6 +960,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	uint64_t *points;
 	uint32_t signaled_count, i;
 
+	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
+		lockdep_assert_none_held_once();
+
 	points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
 	if (points == NULL)
 		return -ENOMEM;
@@ -1017,7 +1030,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	 * fallthough and try a 0 timeout wait!
 	 */
 
-	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
 		for (i = 0; i < count; ++i)
 			drm_syncobj_fence_add_wait(syncobjs[i], &entries[i]);
 	}
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
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2a973a1390a4..a0d7777acb6d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1711,7 +1711,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
 		/* SRQ resize is not supported */
-		break;
+		return -EINVAL;
 	case IB_SRQ_LIMIT:
 		/* Change the SRQ threshold */
 		if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)
@@ -1726,13 +1726,12 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
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
index 60eb3a64518f..969004258692 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -2131,7 +2131,7 @@ int init_credit_return(struct hfi1_devdata *dd)
 				   "Unable to allocate credit return DMA range for NUMA %d\n",
 				   i);
 			ret = -ENOMEM;
-			goto done;
+			goto free_cr_base;
 		}
 	}
 	set_dev_node(&dd->pcidev->dev, dd->node);
@@ -2139,6 +2139,10 @@ int init_credit_return(struct hfi1_devdata *dd)
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
index 2dc97de434a5..68a8557e9a7c 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3200,7 +3200,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3543b9af10b7..d382ac21159c 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1865,8 +1865,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
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
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 983f59c87b79..41abf9cf11c6 100644
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
@@ -1803,8 +1809,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	ch->cq_size = ch->rq_size + sq_size;
 
 	qp_init->qp_context = (void *)ch;
-	qp_init->event_handler
-		= (void(*)(struct ib_event *, void*))srpt_qp_event;
+	qp_init->event_handler = srpt_qp_event;
 	qp_init->send_cq = ch->cq;
 	qp_init->recv_cq = ch->cq;
 	qp_init->sq_sig_type = IB_SIGNAL_REQ_WR;
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index cd21c92a6b2c..6804970d8f51 100644
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
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index fc25b900cef7..7888e3c08df4 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -398,6 +398,8 @@ static void gic_all_vpes_irq_cpu_online(void)
 		unsigned int intr = local_intrs[i];
 		struct gic_all_vpes_chip_data *cd;
 
+		if (!gic_local_irq_is_routable(intr))
+			continue;
 		cd = &gic_all_vpes_chip_data[intr];
 		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
 		if (cd->mask)
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5d772f322a24..5edcdcee91c2 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2064,6 +2064,12 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
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
diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index ea9f7d0058a2..e201d5a56bc6 100644
--- a/drivers/media/pci/ttpci/av7110_av.c
+++ b/drivers/media/pci/ttpci/av7110_av.c
@@ -822,10 +822,10 @@ static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, s
 		av7110_ipack_flush(ipack);
 
 	if (buf[3] & ADAPT_FIELD) {
+		if (buf[4] > len - 1 - 4)
+			return 0;
 		len -= buf[4] + 1;
 		buf += buf[4] + 1;
-		if (!len)
-			return 0;
 	}
 
 	av7110_ipack_instant_repack(buf + 4, len - 4, ipack);
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index cd7a9cacc3fb..8bd3f6bf9b10 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -119,6 +119,26 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35LF4GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37),
+		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index dcde496da7fb..c5de8f46cdd3 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -780,7 +780,9 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 
 	wol->supported = 0;
 	wol->wolopts = 0;
-	phy_ethtool_get_wol(netdev->phydev, wol);
+
+	if (netdev->phydev)
+		phy_ethtool_get_wol(netdev->phydev, wol);
 
 	wol->supported |= WAKE_BCAST | WAKE_UCAST | WAKE_MCAST |
 		WAKE_MAGIC | WAKE_PHY | WAKE_ARP;
@@ -809,9 +811,8 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 
 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
 
-	phy_ethtool_set_wol(netdev->phydev, wol);
-
-	return 0;
+	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
+			: -ENETDOWN;
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ed247cba2291..9534f58368cc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1410,20 +1410,20 @@ static int __init gtp_init(void)
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
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d2c6fdb70273..08008b0c0637 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5155,8 +5155,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 
 	if (notif->sync) {
 		notif->cookie = mvm->queue_sync_cookie;
-		atomic_set(&mvm->queue_sync_counter,
-			   mvm->trans->num_rx_queues);
+		mvm->queue_sync_state = (1 << mvm->trans->num_rx_queues) - 1;
 	}
 
 	ret = iwl_mvm_notify_rx_queue(mvm, qmask, (u8 *)notif,
@@ -5169,16 +5168,19 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	if (notif->sync) {
 		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
-					 atomic_read(&mvm->queue_sync_counter) == 0 ||
+					 READ_ONCE(mvm->queue_sync_state) == 0 ||
 					 iwl_mvm_is_radio_killed(mvm),
 					 HZ);
-		WARN_ON_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm));
+		WARN_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm),
+			  "queue sync: failed to sync, state is 0x%lx\n",
+			  mvm->queue_sync_state);
 	}
 
 out:
-	atomic_set(&mvm->queue_sync_counter, 0);
-	if (notif->sync)
+	if (notif->sync) {
+		mvm->queue_sync_state = 0;
 		mvm->queue_sync_cookie++;
+	}
 }
 
 static void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 64f5a4cb3d3a..8b779c3a92d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -842,7 +842,7 @@ struct iwl_mvm {
 	unsigned long status;
 
 	u32 queue_sync_cookie;
-	atomic_t queue_sync_counter;
+	unsigned long queue_sync_state;
 	/*
 	 * for beacon filtering -
 	 * currently only one interface can be supported
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5b173f21e87b..3548eb57f1f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -725,7 +725,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
-	atomic_set(&mvm->queue_sync_counter, 0);
+	mvm->queue_sync_state = 0;
 
 	SET_IEEE80211_DEV(mvm->hw, mvm->trans->dev);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 86b3fb321dfd..e2a39e8b98d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -853,9 +853,13 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 		WARN_ONCE(1, "Invalid identifier %d", internal_notif->type);
 	}
 
-	if (internal_notif->sync &&
-	    !atomic_dec_return(&mvm->queue_sync_counter))
-		wake_up(&mvm->rx_sync_waitq);
+	if (internal_notif->sync) {
+		WARN_ONCE(!test_and_clear_bit(queue, &mvm->queue_sync_state),
+			  "queue sync: queue %d responded a second time!\n",
+			  queue);
+		if (READ_ONCE(mvm->queue_sync_state) == 0)
+			wake_up(&mvm->rx_sync_waitq);
+	}
 }
 
 static void iwl_mvm_oldsn_workaround(struct iwl_mvm *mvm,
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 906cab35afe7..8e05239073ef 100644
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
@@ -3823,10 +3816,6 @@ static int __init nvme_fc_init_module(void)
 {
 	int ret;
 
-	nvme_fc_wq = alloc_workqueue("nvme_fc_wq", WQ_MEM_RECLAIM, 0);
-	if (!nvme_fc_wq)
-		return -ENOMEM;
-
 	/*
 	 * NOTE:
 	 * It is expected that in the future the kernel will combine
@@ -3844,7 +3833,7 @@ static int __init nvme_fc_init_module(void)
 	ret = class_register(&fc_class);
 	if (ret) {
 		pr_err("couldn't register class fc\n");
-		goto out_destroy_wq;
+		return ret;
 	}
 
 	/*
@@ -3868,8 +3857,6 @@ static int __init nvme_fc_init_module(void)
 	device_destroy(&fc_class, MKDEV(0, 0));
 out_destroy_class:
 	class_unregister(&fc_class);
-out_destroy_wq:
-	destroy_workqueue(nvme_fc_wq);
 
 	return ret;
 }
@@ -3889,45 +3876,23 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
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
index 46fc44ce8671..846fb41da643 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -357,7 +357,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -370,6 +370,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
@@ -1101,6 +1102,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2528,8 +2532,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 80a208fb34f5..f2c5136bf2b8 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		schedule_work(&rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		schedule_work(&rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		schedule_work(&tport->ls_work);
 		return ret;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 116ae6fd35e2..d70a2fa4ba45 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1852,6 +1852,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 3da69b26e674..27377f2f9e84 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1409,7 +1409,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index a90c32d072da..9c8a6722f115 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -230,6 +230,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7352"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion 13 x360 PC"),
+		},
+	},
 	{} /* Array terminator */
 };
 
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
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index c533d1dadc6b..a5dba3829769 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -202,7 +202,8 @@ int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
-	if (cdev->private->state == DEV_STATE_VERIFY) {
+	if (cdev->private->state == DEV_STATE_VERIFY ||
+	    cdev->private->flags.doverify) {
 		/* Remember to fake irb when finished. */
 		if (!cdev->private->flags.fake_irb) {
 			cdev->private->flags.fake_irb = FAKE_CMD_IRB;
@@ -214,8 +215,7 @@ int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE ||
 	    ((sch->schib.scsw.cmd.stctl & SCSW_STCTL_PRIM_STATUS) &&
-	     !(sch->schib.scsw.cmd.stctl & SCSW_STCTL_SEC_STATUS)) ||
-	    cdev->private->flags.doverify)
+	     !(sch->schib.scsw.cmd.stctl & SCSW_STCTL_SEC_STATUS)))
 		return -EBUSY;
 	ret = cio_set_options (sch, flags);
 	if (ret)
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 6524e1fe54d2..f59c9002468c 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1289,7 +1289,7 @@ source "drivers/scsi/arm/Kconfig"
 
 config JAZZ_ESP
 	bool "MIPS JAZZ FAS216 SCSI support"
-	depends on MACH_JAZZ && SCSI
+	depends on MACH_JAZZ && SCSI=y
 	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the onboard SCSI host adapter of MIPS Magnum
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 983eeb0e3d07..b4b87e5d8b29 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1944,7 +1944,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datasegcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -1952,8 +1952,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
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
@@ -2124,7 +2124,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datacnt, int protcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -2148,8 +2148,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	uint32_t rc;
 #endif
 	uint32_t checking = 1;
-	uint32_t dma_offset = 0;
-	int num_sge = 0, j = 2;
+	uint32_t dma_offset = 0, num_sge = 0;
+	int j = 2;
 	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	sgpe = scsi_prot_sglist(sc);
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
index 4650b483a33d..e0c3ad73c576 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -365,6 +365,11 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
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
index 35d30378256f..12fd02f92e37 100644
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
index 9aeedcff7d02..daa4d06ce233 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -150,7 +150,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, se_cmd->orig_fe_lun);
@@ -181,10 +180,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
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
index 2e97937f005f..8d294b658592 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3436,6 +3436,10 @@ int transport_generic_handle_tmr(
 	unsigned long flags;
 	bool aborted = false;
 
+	spin_lock_irqsave(&cmd->se_dev->se_tmr_lock, flags);
+	list_add_tail(&cmd->se_tmr_req->tmr_list, &cmd->se_dev->dev_tmr_list);
+	spin_unlock_irqrestore(&cmd->se_dev->se_tmr_lock, flags);
+
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	if (cmd->transport_state & CMD_T_ABORTED) {
 		aborted = true;
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index cf0fb650a924..4886cad0fde6 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -43,6 +43,7 @@ struct xencons_info {
 	int irq;
 	int vtermno;
 	grant_ref_t gntref;
+	spinlock_t ring_lock;
 };
 
 static LIST_HEAD(xenconsoles);
@@ -89,12 +90,15 @@ static int __write_console(struct xencons_info *xencons,
 	XENCONS_RING_IDX cons, prod;
 	struct xencons_interface *intf = xencons->intf;
 	int sent = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&xencons->ring_lock, flags);
 	cons = intf->out_cons;
 	prod = intf->out_prod;
 	mb();			/* update queue values before going on */
 
 	if ((prod - cons) > sizeof(intf->out)) {
+		spin_unlock_irqrestore(&xencons->ring_lock, flags);
 		pr_err_once("xencons: Illegal ring page indices");
 		return -EINVAL;
 	}
@@ -104,6 +108,7 @@ static int __write_console(struct xencons_info *xencons,
 
 	wmb();			/* write ring before updating pointer */
 	intf->out_prod = prod;
+	spin_unlock_irqrestore(&xencons->ring_lock, flags);
 
 	if (sent)
 		notify_daemon(xencons);
@@ -146,16 +151,19 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 	int recv = 0;
 	struct xencons_info *xencons = vtermno_to_xencons(vtermno);
 	unsigned int eoiflag = 0;
+	unsigned long flags;
 
 	if (xencons == NULL)
 		return -EINVAL;
 	intf = xencons->intf;
 
+	spin_lock_irqsave(&xencons->ring_lock, flags);
 	cons = intf->in_cons;
 	prod = intf->in_prod;
 	mb();			/* get pointers before reading ring */
 
 	if ((prod - cons) > sizeof(intf->in)) {
+		spin_unlock_irqrestore(&xencons->ring_lock, flags);
 		pr_err_once("xencons: Illegal ring page indices");
 		return -EINVAL;
 	}
@@ -179,10 +187,13 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 		xencons->out_cons = intf->out_cons;
 		xencons->out_cons_same = 0;
 	}
+	if (!recv && xencons->out_cons_same++ > 1) {
+		eoiflag = XEN_EOI_FLAG_SPURIOUS;
+	}
+	spin_unlock_irqrestore(&xencons->ring_lock, flags);
+
 	if (recv) {
 		notify_daemon(xencons);
-	} else if (xencons->out_cons_same++ > 1) {
-		eoiflag = XEN_EOI_FLAG_SPURIOUS;
 	}
 
 	xen_irq_lateeoi(xencons->irq, eoiflag);
@@ -239,6 +250,7 @@ static int xen_hvm_console_init(void)
 		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
+		spin_lock_init(&info->ring_lock);
 	} else if (info->intf != NULL) {
 		/* already configured */
 		return 0;
@@ -275,6 +287,7 @@ static int xen_hvm_console_init(void)
 
 static int xencons_info_pv_init(struct xencons_info *info, int vtermno)
 {
+	spin_lock_init(&info->ring_lock);
 	info->evtchn = xen_start_info->console.domU.evtchn;
 	/* GFN == MFN for PV guest */
 	info->intf = gfn_to_virt(xen_start_info->console.domU.mfn);
@@ -325,6 +338,7 @@ static int xen_initial_domain_console_init(void)
 		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
+		spin_lock_init(&info->ring_lock);
 	}
 
 	info->irq = bind_virq_to_irq(VIRQ_CONSOLE, 0, false);
@@ -485,6 +499,7 @@ static int xencons_probe(struct xenbus_device *dev,
 	info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
+	spin_lock_init(&info->ring_lock);
 	dev_set_drvdata(&dev->dev, info);
 	info->xbdev = dev;
 	info->vtermno = xenbus_devid_to_vtermno(devid);
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 8a1f0a636848..eeea892248b5 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -837,7 +837,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
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
@@ -2538,11 +2542,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		list_del_init(&priv_req->list);
 
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 	}
 
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index d42cd1d036bd..8fac7a67db76 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1349,7 +1349,15 @@ static int ncm_unwrap_ntb(struct gether *port,
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
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 5cc20275335d..e1dff4a44fd2 100644
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
 
@@ -328,6 +336,7 @@ usb_role_switch_register(struct device *parent,
 	sw->set = desc->set;
 	sw->get = desc->get;
 
+	sw->module = parent->driver->owner;
 	sw->dev.parent = parent;
 	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = role_class;
@@ -342,6 +351,8 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	sw->registered = true;
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -356,8 +367,10 @@ EXPORT_SYMBOL_GPL(usb_role_switch_register);
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
index 03c736f6f3d0..e540cb0c5172 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1474,6 +1474,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f84194b791d3..fb19c69284ab 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -302,7 +302,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[24];
 	int ret, idsz;
 
 	_enter("");
@@ -310,7 +310,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz = sprintf(idbuf, "%llu", volume->vid);
+	idsz = snprintf(idbuf, sizeof(idbuf), "%llu", volume->vid);
 
 	vldb = afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {
diff --git a/fs/aio.c b/fs/aio.c
index 5934ea84b499..900ed5207540 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -569,6 +569,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
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
 
@@ -1454,7 +1461,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 67831868ef0d..3ddb09f2b168 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2879,7 +2879,7 @@ struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 objectid, const char *name, int name_len,
+			    u64 index, const char *name, int name_len,
 			    int mod);
 struct btrfs_dir_item *
 btrfs_search_dir_index_item(struct btrfs_root *root,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 863367c2c620..98c6faa8ce15 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -171,10 +171,40 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	return 0;
 }
 
+static struct btrfs_dir_item *btrfs_lookup_match_dir(
+			struct btrfs_trans_handle *trans,
+			struct btrfs_root *root, struct btrfs_path *path,
+			struct btrfs_key *key, const char *name,
+			int name_len, int mod)
+{
+	const int ins_len = (mod < 0 ? -1 : 0);
+	const int cow = (mod != 0);
+	int ret;
+
+	ret = btrfs_search_slot(trans, root, key, path, ins_len, cow);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (ret > 0)
+		return ERR_PTR(-ENOENT);
+
+	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+}
+
 /*
- * lookup a directory item based on name.  'dir' is the objectid
- * we're searching in, and 'mod' tells us if you plan on deleting the
- * item (use mod < 0) or changing the options (use mod > 0)
+ * Lookup for a directory item by name.
+ *
+ * @trans:	The transaction handle to use. Can be NULL if @mod is 0.
+ * @root:	The root of the target tree.
+ * @path:	Path to use for the search.
+ * @dir:	The inode number (objectid) of the directory.
+ * @name:	The name associated to the directory entry we are looking for.
+ * @name_len:	The length of the name.
+ * @mod:	Used to indicate if the tree search is meant for a read only
+ *		lookup, for a modification lookup or for a deletion lookup, so
+ *		its value should be 0, 1 or -1, respectively.
+ *
+ * Returns: NULL if the dir item does not exists, an error pointer if an error
+ * happened, or a pointer to a dir item if a dir item exists for the given name.
  */
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
@@ -182,23 +212,18 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     const char *name, int name_len,
 					     int mod)
 {
-	int ret;
 	struct btrfs_key key;
-	int ins_len = mod < 0 ? -1 : 0;
-	int cow = mod != 0;
+	struct btrfs_dir_item *di;
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-
 	key.offset = btrfs_name_hash(name, name_len);
 
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (ret > 0)
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return di;
 }
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
@@ -212,7 +237,6 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	int slot;
 	struct btrfs_path *path;
 
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -221,20 +245,20 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(name, name_len);
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-
-	/* return back any errors */
-	if (ret < 0)
-		goto out;
+	di = btrfs_lookup_match_dir(NULL, root, path, &key, name, name_len, 0);
+	if (IS_ERR(di)) {
+		ret = PTR_ERR(di);
+		/* Nothing found, we're safe */
+		if (ret == -ENOENT) {
+			ret = 0;
+			goto out;
+		}
 
-	/* nothing found, we're safe */
-	if (ret > 0) {
-		ret = 0;
-		goto out;
+		if (ret < 0)
+			goto out;
 	}
 
 	/* we found an item, look for our name in the item */
-	di = btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
 	if (di) {
 		/* our exact name was found */
 		ret = -EEXIST;
@@ -261,35 +285,42 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 }
 
 /*
- * lookup a directory item based on index.  'dir' is the objectid
- * we're searching in, and 'mod' tells us if you plan on deleting the
- * item (use mod < 0) or changing the options (use mod > 0)
+ * Lookup for a directory index item by name and index number.
+ *
+ * @trans:	The transaction handle to use. Can be NULL if @mod is 0.
+ * @root:	The root of the target tree.
+ * @path:	Path to use for the search.
+ * @dir:	The inode number (objectid) of the directory.
+ * @index:	The index number.
+ * @name:	The name associated to the directory entry we are looking for.
+ * @name_len:	The length of the name.
+ * @mod:	Used to indicate if the tree search is meant for a read only
+ *		lookup, for a modification lookup or for a deletion lookup, so
+ *		its value should be 0, 1 or -1, respectively.
  *
- * The name is used to make sure the index really points to the name you were
- * looking for.
+ * Returns: NULL if the dir index item does not exists, an error pointer if an
+ * error happened, or a pointer to a dir item if the dir index item exists and
+ * matches the criteria (name and index number).
  */
 struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 objectid, const char *name, int name_len,
+			    u64 index, const char *name, int name_len,
 			    int mod)
 {
-	int ret;
+	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	int ins_len = mod < 0 ? -1 : 0;
-	int cow = mod != 0;
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = objectid;
+	key.offset = index;
 
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (ret > 0)
-		return ERR_PTR(-ENOENT);
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	if (di == ERR_PTR(-ENOENT))
+		return NULL;
+
+	return di;
 }
 
 struct btrfs_dir_item *
@@ -346,21 +377,18 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 					  const char *name, u16 name_len,
 					  int mod)
 {
-	int ret;
 	struct btrfs_key key;
-	int ins_len = mod < 0 ? -1 : 0;
-	int cow = mod != 0;
+	struct btrfs_dir_item *di;
 
 	key.objectid = dir;
 	key.type = BTRFS_XATTR_ITEM_KEY;
 	key.offset = btrfs_name_hash(name, name_len);
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (ret > 0)
+
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return di;
 }
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 250b6064876d..591caac2bf81 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8968,8 +8968,6 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		btrfs_pin_log_trans(root);
-		root_log_pinned = true;
 		ret = btrfs_insert_inode_ref(trans, dest,
 					     new_dentry->d_name.name,
 					     new_dentry->d_name.len,
@@ -8986,8 +8984,6 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		btrfs_pin_log_trans(dest);
-		dest_log_pinned = true;
 		ret = btrfs_insert_inode_ref(trans, root,
 					     old_dentry->d_name.name,
 					     old_dentry->d_name.len,
@@ -9018,6 +9014,29 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 				BTRFS_I(new_inode), 1);
 	}
 
+	/*
+	 * Now pin the logs of the roots. We do it to ensure that no other task
+	 * can sync the logs while we are in progress with the rename, because
+	 * that could result in an inconsistency in case any of the inodes that
+	 * are part of this rename operation were logged before.
+	 *
+	 * We pin the logs even if at this precise moment none of the inodes was
+	 * logged before. This is because right after we checked for that, some
+	 * other task fsyncing some other inode not involved with this rename
+	 * operation could log that one of our inodes exists.
+	 *
+	 * We don't need to pin the logs before the above calls to
+	 * btrfs_insert_inode_ref(), since those don't ever need to change a log.
+	 */
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID) {
+		btrfs_pin_log_trans(root);
+		root_log_pinned = true;
+	}
+	if (new_ino != BTRFS_FIRST_FREE_OBJECTID) {
+		btrfs_pin_log_trans(dest);
+		dest_log_pinned = true;
+	}
+
 	/* src is a subvolume */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
@@ -9267,8 +9286,6 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		btrfs_pin_log_trans(root);
-		log_pinned = true;
 		ret = btrfs_insert_inode_ref(trans, dest,
 					     new_dentry->d_name.name,
 					     new_dentry->d_name.len,
@@ -9292,6 +9309,25 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else {
+		/*
+		 * Now pin the log. We do it to ensure that no other task can
+		 * sync the log while we are in progress with the rename, as
+		 * that could result in an inconsistency in case any of the
+		 * inodes that are part of this rename operation were logged
+		 * before.
+		 *
+		 * We pin the log even if at this precise moment none of the
+		 * inodes was logged before. This is because right after we
+		 * checked for that, some other task fsyncing some other inode
+		 * not involved with this rename operation could log that one of
+		 * our inodes exists.
+		 *
+		 * We don't need to pin the logs before the above call to
+		 * btrfs_insert_inode_ref(), since that does not need to change
+		 * a log.
+		 */
+		btrfs_pin_log_trans(root);
+		log_pinned = true;
 		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
 					old_dentry->d_name.name,
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c0eda3816f68..5b952f69bc1f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1189,7 +1189,8 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 }
 
 static int check_extent_item(struct extent_buffer *leaf,
-			     struct btrfs_key *key, int slot)
+			     struct btrfs_key *key, int slot,
+			     struct btrfs_key *prev_key)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_extent_item *ei;
@@ -1400,6 +1401,26 @@ static int check_extent_item(struct extent_buffer *leaf,
 			   total_refs, inline_refs);
 		return -EUCLEAN;
 	}
+
+	if ((prev_key->type == BTRFS_EXTENT_ITEM_KEY) ||
+	    (prev_key->type == BTRFS_METADATA_ITEM_KEY)) {
+		u64 prev_end = prev_key->objectid;
+
+		if (prev_key->type == BTRFS_METADATA_ITEM_KEY)
+			prev_end += fs_info->nodesize;
+		else
+			prev_end += prev_key->offset;
+
+		if (unlikely(prev_end > key->objectid)) {
+			extent_err(leaf, slot,
+	"previous extent [%llu %u %llu] overlaps current extent [%llu %u %llu]",
+				   prev_key->objectid, prev_key->type,
+				   prev_key->offset, key->objectid, key->type,
+				   key->offset);
+			return -EUCLEAN;
+		}
+	}
+
 	return 0;
 }
 
@@ -1568,7 +1589,7 @@ static int check_leaf_item(struct extent_buffer *leaf,
 		break;
 	case BTRFS_EXTENT_ITEM_KEY:
 	case BTRFS_METADATA_ITEM_KEY:
-		ret = check_extent_item(leaf, key, slot);
+		ret = check_extent_item(leaf, key, slot, prev_key);
 		break;
 	case BTRFS_TREE_BLOCK_REF_KEY:
 	case BTRFS_SHARED_DATA_REF_KEY:
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 10a0913ffb49..34e9eb5010cd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -912,8 +912,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 	di = btrfs_lookup_dir_index_item(NULL, root, path, dirid,
 					 index, name, name_len, 0);
 	if (IS_ERR(di)) {
-		if (PTR_ERR(di) != -ENOENT)
-			ret = PTR_ERR(di);
+		ret = PTR_ERR(di);
 		goto out;
 	} else if (di) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
@@ -1149,8 +1148,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
 					 ref_index, name, namelen, 0);
 	if (IS_ERR(di)) {
-		if (PTR_ERR(di) != -ENOENT)
-			return PTR_ERR(di);
+		return PTR_ERR(di);
 	} else if (di) {
 		ret = drop_one_dir_item(trans, root, path, dir, di);
 		if (ret)
@@ -1976,9 +1974,6 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (dst_di == ERR_PTR(-ENOENT))
-		dst_di = NULL;
-
 	if (IS_ERR(dst_di)) {
 		ret = PTR_ERR(dst_di);
 		goto out;
@@ -2286,7 +2281,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 						     dir_key->offset,
 						     name, name_len, 0);
 		}
-		if (!log_di || log_di == ERR_PTR(-ENOENT)) {
+		if (!log_di) {
 			btrfs_dir_item_key_to_cpu(eb, di, &location);
 			btrfs_release_path(path);
 			btrfs_release_path(log_path);
@@ -3495,8 +3490,7 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	if (err == -ENOSPC) {
 		btrfs_set_log_full_commit(trans);
 		err = 0;
-	} else if (err < 0 && err != -ENOENT) {
-		/* ENOENT can be returned if the entry hasn't been fsynced yet */
+	} else if (err < 0) {
 		btrfs_abort_transaction(trans, err);
 	}
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 84850a55c8b7..b2a7238a3422 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -82,6 +82,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		pr_warn_once("server overflowed SMB3 credits\n");
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 && (optype & CIFS_OP_MASK) != CIFS_NEG_OP)
 		rc = change_conf(server);
@@ -818,10 +819,12 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 	if (o_rsp->OplockLevel == SMB2_OPLOCK_LEVEL_LEASE) {
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
 
@@ -4892,6 +4895,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	struct smb2_sync_hdr *shdr;
 	unsigned int pdu_length = server->pdu_size;
 	unsigned int buf_size;
+	unsigned int next_cmd;
 	struct mid_q_entry *mid_entry;
 	int next_is_large;
 	char *next_buffer = NULL;
@@ -4920,14 +4924,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
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
@@ -4951,8 +4956,8 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
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
index 4aec01841f0f..aa3211d8cce3 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1991,17 +1991,18 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
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
@@ -2010,45 +2011,63 @@ smb2_parse_contexts(struct TCP_Server_Info *server,
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
@@ -2915,8 +2934,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	}
 
 
-	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf, posix);
+	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
+				 oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index ed2b4fb012a4..3184a5efcdba 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -270,11 +270,13 @@ extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
 
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
index f921580b56cb..36693924db18 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -24,7 +24,8 @@ struct z_erofs_decompressor {
 	 */
 	int (*prepare_destpages)(struct z_erofs_decompress_req *rq,
 				 struct list_head *pagepool);
-	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out);
+	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out,
+			  u8 *obase);
 	char *name;
 };
 
@@ -114,10 +115,13 @@ static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
 	return tmp;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out,
+				  u8 *obase)
 {
+	const uint nrpages_out = PAGE_ALIGN(rq->pageofs_out +
+					    rq->outputsize) >> PAGE_SHIFT;
 	unsigned int inputmargin, inlen;
-	u8 *src;
+	u8 *src, *src2;
 	bool copied, support_0padding;
 	int ret;
 
@@ -125,6 +129,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		return -EOPNOTSUPP;
 
 	src = kmap_atomic(*rq->in);
+	src2 = src;
 	inputmargin = 0;
 	support_0padding = false;
 
@@ -148,16 +153,15 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (rq->inplace_io) {
 		const uint oend = (rq->pageofs_out +
 				   rq->outputsize) & ~PAGE_MASK;
-		const uint nr = PAGE_ALIGN(rq->pageofs_out +
-					   rq->outputsize) >> PAGE_SHIFT;
-
 		if (rq->partial_decoding || !support_0padding ||
-		    rq->out[nr - 1] != rq->in[0] ||
+		    rq->out[nrpages_out - 1] != rq->in[0] ||
 		    rq->inputsize - oend <
 		      LZ4_DECOMPRESS_INPLACE_MARGIN(inlen)) {
 			src = generic_copy_inplace_data(rq, src, inputmargin);
 			inputmargin = 0;
 			copied = true;
+		} else {
+			src = obase + ((nrpages_out - 1) << PAGE_SHIFT);
 		}
 	}
 
@@ -187,7 +191,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (copied)
 		erofs_put_pcpubuf(src);
 	else
-		kunmap_atomic(src);
+		kunmap_atomic(src2);
 	return ret;
 }
 
@@ -257,7 +261,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 			return PTR_ERR(dst);
 
 		rq->inplace_io = false;
-		ret = alg->decompress(rq, dst);
+		ret = alg->decompress(rq, dst, NULL);
 		if (!ret)
 			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 					  rq->outputsize);
@@ -291,7 +295,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
+	ret = alg->decompress(rq, dst + rq->pageofs_out, dst);
 
 	if (!dst_maptype)
 		kunmap_atomic(dst);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 193b13630ac1..68aa8760cb46 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2222,7 +2222,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 
 /*
- * ext4_ext_determine_hole - determine hole around given block
+ * ext4_ext_find_hole - find hole around given block according to the given path
  * @inode:	inode we lookup in
  * @path:	path in extent tree to @lblk
  * @lblk:	pointer to logical block around which we want to determine hole
@@ -2234,9 +2234,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
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
@@ -2263,30 +2263,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
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
@@ -4058,6 +4034,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
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
@@ -4175,22 +4214,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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
index 9bec75847b85..d66ba6f6a811 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -823,6 +823,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	atomic64_add(period, &sbi->s_mb_generation_time);
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
@@ -1505,6 +1523,8 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 			ext4_mark_group_bitmap_corrupted(
 				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		} else {
+			mb_regenerate_buddy(e4b);
 		}
 		goto done;
 	}
@@ -1854,6 +1874,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -1861,6 +1884,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
@@ -1889,12 +1913,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
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
@@ -1927,6 +1949,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 472932b9e6bc..7898983c9fba 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -57,28 +57,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
 	}
 }
 
-/*
- * Move a buffer from the checkpoint list to the checkpoint io list
- *
- * Called with j_list_lock held
- */
-static inline void __buffer_relink_io(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-
-	if (!transaction->t_checkpoint_io_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_io_list;
-		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_io_list = jh;
-}
-
 /*
  * Try to release a checkpointed buffer from its transaction.
  * Returns 1 if we released it and 2 if we also released the
@@ -91,8 +69,7 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
 	int ret = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
-	if (jh->b_transaction == NULL && !buffer_locked(bh) &&
-	    !buffer_dirty(bh) && !buffer_write_io_error(bh)) {
+	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
 		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
 	}
@@ -191,6 +168,7 @@ __flush_batch(journal_t *journal, int *batch_count)
 		struct buffer_head *bh = journal->j_chkpt_bhs[i];
 		BUFFER_TRACE(bh, "brelse");
 		__brelse(bh);
+		journal->j_chkpt_bhs[i] = NULL;
 	}
 	*batch_count = 0;
 }
@@ -228,7 +206,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 * OK, we need to start writing disk blocks.  Take one transaction
 	 * and write it.
 	 */
-	result = 0;
 	spin_lock(&journal->j_list_lock);
 	if (!journal->j_checkpoint_transactions)
 		goto out;
@@ -251,15 +228,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			goto retry;
-		}
 		if (jh->b_transaction != NULL) {
 			transaction_t *t = jh->b_transaction;
 			tid_t tid = t->t_tid;
@@ -294,32 +262,50 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 		}
-		if (!buffer_dirty(bh)) {
-			if (unlikely(buffer_write_io_error(bh)) && !result)
-				result = -EIO;
+		if (!trylock_buffer(bh)) {
+			/*
+			 * The buffer is locked, it may be writing back, or
+			 * flushing out in the last couple of cycles, or
+			 * re-adding into a new transaction, need to check
+			 * it again until it's unlocked.
+			 */
+			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			/* the journal_head may have gone by now */
+			BUFFER_TRACE(bh, "brelse");
+			__brelse(bh);
+			goto retry;
+		} else if (!buffer_dirty(bh)) {
+			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "remove from checkpoint");
-			if (__jbd2_journal_remove_checkpoint(jh))
-				/* The transaction was released; we're done */
+			/*
+			 * If the transaction was released or the checkpoint
+			 * list was empty, we're done.
+			 */
+			if (__jbd2_journal_remove_checkpoint(jh) ||
+			    !transaction->t_checkpoint_list)
 				goto out;
-			continue;
+		} else {
+			unlock_buffer(bh);
+			/*
+			 * We are about to write the buffer, it could be
+			 * raced by some other transaction shrink or buffer
+			 * re-log logic once we release the j_list_lock,
+			 * leave it on the checkpoint list and check status
+			 * again to make sure it's clean.
+			 */
+			BUFFER_TRACE(bh, "queue");
+			get_bh(bh);
+			J_ASSERT_BH(bh, !buffer_jwrite(bh));
+			journal->j_chkpt_bhs[batch_count++] = bh;
+			transaction->t_chp_stats.cs_written++;
+			transaction->t_checkpoint_list = jh->b_cpnext;
 		}
-		/*
-		 * Important: we are about to write the buffer, and
-		 * possibly block, while still holding the journal
-		 * lock.  We cannot afford to let the transaction
-		 * logic start messing around with this buffer before
-		 * we write it to disk, as that would break
-		 * recoverability.
-		 */
-		BUFFER_TRACE(bh, "queue");
-		get_bh(bh);
-		J_ASSERT_BH(bh, !buffer_jwrite(bh));
-		journal->j_chkpt_bhs[batch_count++] = bh;
-		__buffer_relink_io(jh);
-		transaction->t_chp_stats.cs_written++;
+
 		if ((batch_count == JBD2_NR_BATCH) ||
-		    need_resched() ||
-		    spin_needbreak(&journal->j_list_lock))
+		    need_resched() || spin_needbreak(&journal->j_list_lock) ||
+		    jh2bh(transaction->t_checkpoint_list) == journal->j_chkpt_bhs[0])
 			goto unlock_and_flush;
 	}
 
@@ -333,46 +319,9 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 	}
 
-	/*
-	 * Now we issued all of the transaction's buffers, let's deal
-	 * with the buffers that are out for I/O.
-	 */
-restart2:
-	/* Did somebody clean up the transaction in the meanwhile? */
-	if (journal->j_checkpoint_transactions != transaction ||
-	    transaction->t_tid != this_tid)
-		goto out;
-
-	while (transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
-		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart2;
-		}
-		if (unlikely(buffer_write_io_error(bh)) && !result)
-			result = -EIO;
-
-		/*
-		 * Now in whatever state the buffer currently is, we
-		 * know that it has been written out and so we can
-		 * drop it from the list
-		 */
-		if (__jbd2_journal_remove_checkpoint(jh))
-			break;
-	}
 out:
 	spin_unlock(&journal->j_list_lock);
-	if (result < 0)
-		jbd2_journal_abort(journal, result);
-	else
-		result = jbd2_cleanup_journal_tail(journal);
+	result = jbd2_cleanup_journal_tail(journal);
 
 	return (result < 0) ? result : 0;
 }
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b9522eee1257..f9ecade9ea65 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -319,16 +319,18 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
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
@@ -344,8 +346,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	isize = i_size_read(inode);
 	if (zone->cond != BLK_ZONE_COND_OFFLINE &&
 	    zone->cond != BLK_ZONE_COND_READONLY &&
-	    !err->write && isize == data_size)
-		return 0;
+	    !write && isize == data_size)
+		return;
 
 	/*
 	 * At this point, we detected either a bad zone or an inconsistency
@@ -366,8 +368,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
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
@@ -427,8 +430,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset = data_size;
-
-	return 0;
 }
 
 /*
@@ -442,23 +443,25 @@ static void __zonefs_io_error(struct inode *inode, bool write)
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
@@ -469,12 +472,19 @@ static void __zonefs_io_error(struct inode *inode, bool write)
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 82316863c71f..6de70634e547 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -316,6 +316,8 @@ enum rw_hint {
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 2c2586312b44..3eca9f91b9a5 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -321,6 +321,10 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
 
+#define lockdep_assert_none_held_once()	do {				\
+		WARN_ON_ONCE(debug_locks && current->lockdep_depth);	\
+	} while (0)
+
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
@@ -394,6 +398,7 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 #define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
+#define lockdep_assert_none_held_once()	do { } while (0)
 
 #define lockdep_recursing(tsk)			(0)
 
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index f24575942dab..879a5c8f930b 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -16,7 +16,7 @@
  * try_get_task_stack() instead.  task_stack_page will return a pointer
  * that could get freed out from under you.
  */
-static inline void *task_stack_page(const struct task_struct *task)
+static __always_inline void *task_stack_page(const struct task_struct *task)
 {
 	return task->stack;
 }
diff --git a/include/linux/socket.h b/include/linux/socket.h
index c3b35d18bcd3..daf51fef5a8d 100644
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
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5c03dc6d0f79..d6e4b6f7d6ce 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2224,7 +2224,7 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f690f901b6cc..1289991c970e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
@@ -2727,9 +2727,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2760,7 +2757,7 @@ int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
@@ -2804,6 +2801,9 @@ int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 305f0eca163e..0b0331346e4b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -29,6 +29,9 @@
 #include <linux/syscalls.h>
 #include <linux/sysctl.h>
 
+/* Not exposed in headers: strictly internal use only. */
+#define SECCOMP_MODE_DEAD	(SECCOMP_MODE_FILTER + 1)
+
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 #include <asm/syscall.h>
 #endif
@@ -795,6 +798,7 @@ static void __secure_computing_strict(int this_syscall)
 #ifdef SECCOMP_DEBUG
 	dump_stack();
 #endif
+	current->seccomp.mode = SECCOMP_MODE_DEAD;
 	seccomp_log(this_syscall, SIGKILL, SECCOMP_RET_KILL_THREAD, true);
 	do_exit(SIGKILL);
 }
@@ -1023,6 +1027,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	case SECCOMP_RET_KILL_THREAD:
 	case SECCOMP_RET_KILL_PROCESS:
 	default:
+		current->seccomp.mode = SECCOMP_MODE_DEAD;
 		seccomp_log(this_syscall, SIGSYS, action, true);
 		/* Dump core only if this is the last remaining thread. */
 		if (action != SECCOMP_RET_KILL_THREAD ||
@@ -1075,6 +1080,11 @@ int __secure_computing(const struct seccomp_data *sd)
 		return 0;
 	case SECCOMP_MODE_FILTER:
 		return __seccomp_filter(this_syscall, sd, false);
+	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
+	case SECCOMP_MODE_DEAD:
+		WARN_ON_ONCE(1);
+		do_exit(SIGKILL);
+		return -1;
 	default:
 		BUG();
 	}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a45f0dd10b9a..99a19190196e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1859,6 +1859,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -1866,6 +1868,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_deadline_period_max_us",
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 078d95cd32c5..c28ff36f5b31 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -209,6 +209,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      bool *mmap_changing,
 					      bool zeropage)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
@@ -329,6 +330,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && READ_ONCE(*mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -410,6 +420,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      bool *mmap_changing,
 				      bool zeropage);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -529,7 +540,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+					       src_start, len, mmap_changing,
+					       zeropage);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
diff --git a/net/core/dev.c b/net/core/dev.c
index fc881d60a9dc..0619d2253aa2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8787,7 +8787,7 @@ EXPORT_SYMBOL(dev_set_mac_address_user);
 
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
-	size_t size = sizeof(sa->sa_data);
+	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
 	int ret = 0;
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 993420da2930..60e815a71909 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -245,7 +245,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, unsigned int cmd)
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
 			return -EINVAL;
 		memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-		       min(sizeof(ifr->ifr_hwaddr.sa_data),
+		       min(sizeof(ifr->ifr_hwaddr.sa_data_min),
 			   (size_t)dev->addr_len));
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 		return 0;
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index afc97d65cf2d..87fc86aade5c 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -327,9 +327,12 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	node_real->addr_B_port = port_rcv->type;
 
 	spin_lock_bh(&hsr->list_lock);
-	list_del_rcu(&node_curr->mac_list);
+	if (!node_curr->removed) {
+		list_del_rcu(&node_curr->mac_list);
+		node_curr->removed = true;
+		kfree_rcu(node_curr, rcu_head);
+	}
 	spin_unlock_bh(&hsr->list_lock);
-	kfree_rcu(node_curr, rcu_head);
 
 done:
 	/* PRP uses v0 header */
@@ -506,9 +509,12 @@ void hsr_prune_nodes(struct timer_list *t)
 		if (time_is_before_jiffies(timestamp +
 				msecs_to_jiffies(HSR_NODE_FORGET_TIME))) {
 			hsr_nl_nodedown(hsr, node->macaddress_A);
-			list_del_rcu(&node->mac_list);
-			/* Note that we need to free this entry later: */
-			kfree_rcu(node, rcu_head);
+			if (!node->removed) {
+				list_del_rcu(&node->mac_list);
+				node->removed = true;
+				/* Note that we need to free this entry later: */
+				kfree_rcu(node, rcu_head);
+			}
 		}
 	}
 	spin_unlock_bh(&hsr->list_lock);
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 5a771cb3f032..48990166e4c4 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -82,6 +82,7 @@ struct hsr_node {
 	bool			san_a;
 	bool			san_b;
 	u16			seq_out[HSR_PT_PORTS];
+	bool			removed;
 	struct rcu_head		rcu_head;
 };
 
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
index da1ca8081c03..9ac7d47d27b8 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1798,6 +1798,21 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
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
@@ -1849,8 +1864,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&tgt_net->ipv4.dev_addr_genid) ^
-			  tgt_net->dev_base_seq;
+		cb->seq = inet_base_seq(tgt_net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -2249,8 +2263,7 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
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
index 79787a1f5ab3..150c2f71ec89 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -698,6 +698,22 @@ static int inet6_netconf_get_devconf(struct sk_buff *in_skb,
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
@@ -731,8 +747,7 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv6.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet6_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -5288,7 +5303,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	}
 
 	rcu_read_lock();
-	cb->seq = atomic_read(&tgt_net->ipv6.dev_addr_genid) ^ tgt_net->dev_base_seq;
+	cb->seq = inet6_base_seq(tgt_net);
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 2278c0234c49..a8439fded12d 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -451,22 +451,24 @@ int __init seg6_init(void)
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
@@ -487,11 +489,11 @@ int __init seg6_init(void)
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
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 2e84360990f0..44bd03c6b847 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -700,6 +700,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 55abc06214c4..0d6d12fc3c07 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2959,7 +2959,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
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
index e7545bcca805..6b2a215b2786 100644
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
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f586e8b3c6cf..73b0a6925304 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1132,6 +1132,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	return 0;
 
 err_register_hooks:
+	ctx->table->flags |= NFT_TABLE_F_DORMANT;
 	nft_trans_destroy(trans);
 	return ret;
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b292d58fdcc4..6cc054dd53b6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1871,7 +1871,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
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
index 2046c16b29f0..e5f7675e587b 100644
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
index df2bcd785f7d..1b8d0fc6614c 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -32,20 +32,17 @@ obj-$(CONFIG_NET_ACT_TUNNEL_KEY)+= act_tunnel_key.o
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
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
deleted file mode 100644
index 95967ce1f370..000000000000
--- a/net/sched/sch_atm.c
+++ /dev/null
@@ -1,709 +0,0 @@
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
-static int atm_tc_delete(struct Qdisc *sch, unsigned long arg)
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
-				result = tcf_classify(skb, fl, &res, true);
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
-static void sch_atm_dequeue(unsigned long data)
-{
-	struct Qdisc *sch = (struct Qdisc *)data;
-	struct atm_qdisc_data *p = qdisc_priv(sch);
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
-	tasklet_init(&p->task, sch_atm_dequeue, (unsigned long)sch);
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
index 3da5eb313c24..000000000000
--- a/net/sched/sch_cbq.c
+++ /dev/null
@@ -1,1816 +0,0 @@
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
-		result = tcf_classify(skb, fl, &res, true);
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
-		 *	   Repeat this procdure until we hit a leaf node.
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
-/* CBQ class maintanance routines */
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
-static int cbq_delete(struct Qdisc *sch, unsigned long arg)
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
index a75bc7f80cd7..000000000000
--- a/net/sched/sch_dsmark.c
+++ /dev/null
@@ -1,521 +0,0 @@
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
-static int dsmark_delete(struct Qdisc *sch, unsigned long arg)
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
-		int result = tcf_classify(skb, fl, &res, false);
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
index 7ee3c8b03a39..2bbacd9b97e5 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -800,7 +800,7 @@ static void tls_update(struct sock *sk, struct proto *p,
 	}
 }
 
-static int tls_get_info(const struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index dd980438f201..46f1c19f7c60 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1754,6 +1754,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct sk_psock *psock;
+	int num_async, pending;
 	unsigned char control = 0;
 	ssize_t decrypted = 0;
 	struct strp_msg *rxm;
@@ -1766,8 +1767,6 @@ int tls_sw_recvmsg(struct sock *sk,
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool is_peek = flags & MSG_PEEK;
 	bool bpf_strp_enabled;
-	int num_async = 0;
-	int pending;
 
 	flags |= nonblock;
 
@@ -1784,17 +1783,18 @@ int tls_sw_recvmsg(struct sock *sk,
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
index 0ac829c8f188..279f4977e2ee 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3595,6 +3595,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 31484377b8b1..806240dda609 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -284,7 +284,7 @@ eBPF programs can have an associated license, passed along with the bytecode
 instructions to the kernel when the programs are loaded. The format for that
 string is identical to the one in use for kernel modules (Dual licenses, such
 as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
-programs that are compatible with the GNU Privacy License (GPL).
+programs that are compatible with the GNU General Public License (GNU GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
 license string passed (via **attr**) to the **bpf**\ () system call, and this
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 97f83c63e765..826829e3ff7a 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -756,18 +756,23 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
+	/*
+	 * Register platform component before registering cpu dai for there
+	 * is not defer probe for platform component in snd_soc_add_pcm_runtime().
+	 */
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to pcm register\n");
+		return ret;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
 					      &fsl_micfil_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register component %s\n",
 			fsl_micfil_component.name);
-		return ret;
 	}
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
-	if (ret)
-		dev_err(&pdev->dev, "failed to pcm register\n");
-
 	return ret;
 }
 
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 81269ed5a2aa..03b9cdbd3170 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -37,6 +37,7 @@ struct byt_cht_es8316_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
 	struct gpio_desc *speaker_en_gpio;
+	struct device *codec_dev;
 	bool speaker_en;
 };
 
@@ -549,9 +550,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	}
 
 	/* get speaker enable GPIO */
-	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL, codec_name);
+	codec_dev = acpi_get_first_physical_node(adev);
 	if (!codec_dev)
 		return -EPROBE_DEFER;
+	priv->codec_dev = get_device(codec_dev);
 
 	if (quirk & BYT_CHT_ES8316_JD_INVERTED)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
@@ -569,7 +571,6 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		gpiod_get_index(codec_dev, "speaker-enable", 0,
 				/* see comment in byt_cht_es8316_resume */
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-	put_device(codec_dev);
 
 	if (IS_ERR(priv->speaker_en_gpio)) {
 		ret = PTR_ERR(priv->speaker_en_gpio);
@@ -581,7 +582,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
 			fallthrough;
 		case -EPROBE_DEFER:
-			return ret;
+			goto err_put_codec;
 		}
 	}
 
@@ -604,10 +605,14 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (ret) {
 		gpiod_put(priv->speaker_en_gpio);
 		dev_err(dev, "snd_soc_register_card failed: %d\n", ret);
-		return ret;
+		goto err_put_codec;
 	}
 	platform_set_drvdata(pdev, &byt_cht_es8316_card);
 	return 0;
+
+err_put_codec:
+	put_device(priv->codec_dev);
+	return ret;
 }
 
 static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
@@ -616,6 +621,7 @@ static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
+	put_device(priv->codec_dev);
 	return 0;
 }
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 9a5ab96f917d..f5b1b3b87698 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -86,6 +86,7 @@ enum {
 struct byt_rt5640_private {
 	struct snd_soc_jack jack;
 	struct clk *mclk;
+	struct device *codec_dev;
 };
 static bool is_bytcr;
 
@@ -941,15 +942,11 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
  */
-static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
+static int byt_rt5640_add_codec_device_props(struct device *i2c_dev,
+					     struct byt_rt5640_private *priv)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
-	struct device *i2c_dev;
-	int ret, cnt = 0;
-
-	i2c_dev = bus_find_device_by_name(&i2c_bus_type, NULL, i2c_dev_name);
-	if (!i2c_dev)
-		return -EPROBE_DEFER;
+	int cnt = 0;
 
 	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
 	case BYT_RT5640_DMIC1_MAP:
@@ -989,10 +986,7 @@ static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
 	if (byt_rt5640_quirk & BYT_RT5640_JD_NOT_INV)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
 
-	ret = device_add_properties(i2c_dev, props);
-	put_device(i2c_dev);
-
-	return ret;
+	return device_add_properties(i2c_dev, props);
 }
 
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
@@ -1324,6 +1318,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct acpi_device *adev;
+	struct device *codec_dev;
 	int ret_val = 0;
 	int dai_index = 0;
 	int i, cfg_spk;
@@ -1430,10 +1425,15 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_quirk = quirk_override;
 	}
 
+	codec_dev = acpi_get_first_physical_node(adev);
+	if (!codec_dev)
+		return -EPROBE_DEFER;
+	priv->codec_dev = get_device(codec_dev);
+
 	/* Must be called before register_card, also see declaration comment. */
-	ret_val = byt_rt5640_add_codec_device_props(byt_rt5640_codec_name);
+	ret_val = byt_rt5640_add_codec_device_props(codec_dev, priv);
 	if (ret_val)
-		return ret_val;
+		goto err;
 
 	log_quirks(&pdev->dev);
 
@@ -1460,7 +1460,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			 * for all other errors, including -EPROBE_DEFER
 			 */
 			if (ret_val != -ENOENT)
-				return ret_val;
+				goto err;
 			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;
 		}
 	}
@@ -1493,17 +1493,30 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	ret_val = snd_soc_fixup_dai_links_platform_name(&byt_rt5640_card,
 							platform_name);
 	if (ret_val)
-		return ret_val;
+		goto err;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
+		goto err;
 	}
 	platform_set_drvdata(pdev, &byt_rt5640_card);
 	return ret_val;
+
+err:
+	put_device(priv->codec_dev);
+	return ret_val;
+}
+
+static int snd_byt_rt5640_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+
+	put_device(priv->codec_dev);
+	return 0;
 }
 
 static struct platform_driver snd_byt_rt5640_mc_driver = {
@@ -1514,6 +1527,7 @@ static struct platform_driver snd_byt_rt5640_mc_driver = {
 #endif
 	},
 	.probe = snd_byt_rt5640_mc_probe,
+	.remove = snd_byt_rt5640_mc_remove,
 };
 
 module_platform_driver(snd_byt_rt5640_mc_driver);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index bf8b87d45cb0..a8289f74463e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -85,6 +85,7 @@ struct byt_rt5651_private {
 	struct gpio_desc *ext_amp_gpio;
 	struct gpio_desc *hp_detect;
 	struct snd_soc_jack jack;
+	struct device *codec_dev;
 };
 
 static const struct acpi_gpio_mapping *byt_rt5651_gpios;
@@ -918,17 +919,17 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		byt_rt5651_dais[dai_index].codecs->name = byt_rt5651_codec_name;
 	} else {
 		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENODEV;
 	}
 
-	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL,
-					    byt_rt5651_codec_name);
+	codec_dev = acpi_get_first_physical_node(adev);
+	acpi_dev_put(adev);
 	if (!codec_dev)
 		return -EPROBE_DEFER;
+	priv->codec_dev = get_device(codec_dev);
 
 	/*
 	 * swap SSP0 if bytcr is detected
@@ -997,10 +998,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* Must be called before register_card, also see declaration comment. */
 	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
-	if (ret_val) {
-		put_device(codec_dev);
-		return ret_val;
-	}
+	if (ret_val)
+		goto err;
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
 	if (soc_intel_is_cht() && !byt_rt5651_gpios)
@@ -1024,8 +1023,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 					ret_val);
 				fallthrough;
 			case -EPROBE_DEFER:
-				put_device(codec_dev);
-				return ret_val;
+				goto err;
 			}
 		}
 		priv->hp_detect = devm_fwnode_gpiod_get(&pdev->dev,
@@ -1044,14 +1042,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 					ret_val);
 				fallthrough;
 			case -EPROBE_DEFER:
-				put_device(codec_dev);
-				return ret_val;
+				goto err;
 			}
 		}
 	}
 
-	put_device(codec_dev);
-
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
@@ -1075,7 +1070,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 			 * for all other errors, including -EPROBE_DEFER
 			 */
 			if (ret_val != -ENOENT)
-				return ret_val;
+				goto err;
 			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;
 		}
 	}
@@ -1104,17 +1099,30 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	ret_val = snd_soc_fixup_dai_links_platform_name(&byt_rt5651_card,
 							platform_name);
 	if (ret_val)
-		return ret_val;
+		goto err;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
 
 	if (ret_val) {
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
+		goto err;
 	}
 	platform_set_drvdata(pdev, &byt_rt5651_card);
 	return ret_val;
+
+err:
+	put_device(priv->codec_dev);
+	return ret_val;
+}
+
+static int snd_byt_rt5651_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
+
+	put_device(priv->codec_dev);
+	return 0;
 }
 
 static struct platform_driver snd_byt_rt5651_mc_driver = {
@@ -1125,6 +1133,7 @@ static struct platform_driver snd_byt_rt5651_mc_driver = {
 #endif
 	},
 	.probe = snd_byt_rt5651_mc_probe,
+	.remove = snd_byt_rt5651_mc_remove,
 };
 
 module_platform_driver(snd_byt_rt5651_mc_driver);
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 228485fe0734..6dcad1aa2503 100644
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

