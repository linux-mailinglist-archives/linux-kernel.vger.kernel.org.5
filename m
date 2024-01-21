Return-Path: <linux-kernel+bounces-31772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBAB8333CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D55B2217F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144910A03;
	Sat, 20 Jan 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9ejTYOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FDCDF53;
	Sat, 20 Jan 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749063; cv=none; b=A30J3AAhc4bi8p7C8xIKEvNbbakkjay5gPheqe1fHa58ErB42wPo9LCYjBLDRte3yZc0P22VL0HYGczkOL4VMdqq6QKD9eaBlm8kZ9XU6t/g8Ph7CPAaearU6W7BAUt1jEh4+xph29kQNIyFQ0xdHUQAG3bqsfykA8PV7TY8vSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749063; c=relaxed/simple;
	bh=MwE/i+64i3nzGx9RqFJ2A9COhDlnMtv8CS4xEtLwEDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIJjRz0Qug/bF4FHiPXVyCCP+7mZ20l8DRH0WLHHBOiiB4qORtP0m62pbXlOG7hTyyqvSZC91pslCILH691u99BMKNWqsCEAapF6DT8pmxpbaD5y1lnql2UBYRdAn8/2HnHilOid9aLqSt8bqhPROWKRLJXmgjKSmpyl9W/jHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9ejTYOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA90C433C7;
	Sat, 20 Jan 2024 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705749062;
	bh=MwE/i+64i3nzGx9RqFJ2A9COhDlnMtv8CS4xEtLwEDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9ejTYOrhJHRV/CM9CTvaxuu0PCafr/Cwap4SaaLYiV5oNI3SEcwyUVyNXfYMZkay
	 gVu8DuVV11cHi9KN7jAkv0s9WGbXAicFwteqnYPuUqnMp3loprpa0s+88MAvyckyDU
	 61fumj538UAg6BKL0Vj1ZXxLsGCVGYuLe9OEiYQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.13
Date: Sat, 20 Jan 2024 12:10:50 +0100
Message-ID: <2024012050-slacks-lavender-16a5@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024012050-scoff-phonics-d473@gregkh>
References: <2024012050-scoff-phonics-d473@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index a05c69afc045..a4a2932a4318 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 12
+SUBLEVEL = 13
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 4dcf8589b708..d08a5092c2b4 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -153,7 +153,7 @@ static int arcv2_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
 {
 	int n = 0;
 #ifdef CONFIG_ISA_ARCV2
-	const char *release, *cpu_nm, *isa_nm = "ARCv2";
+	const char *release = "", *cpu_nm = "HS38", *isa_nm = "ARCv2";
 	int dual_issue = 0, dual_enb = 0, mpy_opt, present;
 	int bpu_full, bpu_cache, bpu_pred, bpu_ret_stk;
 	char mpy_nm[16], lpb_nm[32];
@@ -172,8 +172,6 @@ static int arcv2_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
 	 * releases only update it.
 	 */
 
-	cpu_nm = "HS38";
-
 	if (info->arcver > 0x50 && info->arcver <= 0x53) {
 		release = arc_hs_rel[info->arcver - 0x51].str;
 	} else {
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 0b3bb529d246..8f6f4a542964 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -62,7 +62,7 @@ struct rt_sigframe {
 	unsigned int sigret_magic;
 };
 
-static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int save_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
@@ -75,12 +75,12 @@ static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
 #else
 	v2abi.r58 = v2abi.r59 = 0;
 #endif
-	err = __copy_to_user(&mctx->v2abi, &v2abi, sizeof(v2abi));
+	err = __copy_to_user(&mctx->v2abi, (void const *)&v2abi, sizeof(v2abi));
 #endif
 	return err;
 }
 
-static int restore_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int restore_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 6ec3445f3c72..277f6aa8e6c2 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -803,12 +803,12 @@ static int __init sunxi_mc_smp_init(void)
 	for (i = 0; i < ARRAY_SIZE(sunxi_mc_smp_data); i++) {
 		ret = of_property_match_string(node, "enable-method",
 					       sunxi_mc_smp_data[i].enable_method);
-		if (!ret)
+		if (ret >= 0)
 			break;
 	}
 
 	of_node_put(node);
-	if (ret)
+	if (ret < 0)
 		return -ENODEV;
 
 	is_a83t = sunxi_mc_smp_data[i].is_a83t;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 5c1929d41cc0..cacbad35cfc8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -509,8 +509,7 @@ wacky_spi_audio: spi2@0 {
 &pci_rootport {
 	mvl_wifi: wifi@0,0 {
 		compatible = "pci1b4b,2b42";
-		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
-		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		reg = <0x0000 0x0 0x0 0x0 0x0>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
index 853e88455e75..9e4b12ed62cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
@@ -34,8 +34,8 @@ &mipi_panel {
 &pci_rootport {
 	wifi@0,0 {
 		compatible = "qcom,ath10k";
-		reg = <0x00010000 0x0 0x00000000 0x0 0x00000000>,
-		      <0x03010010 0x0 0x00000000 0x0 0x00200000>;
+		reg = <0x00000000 0x0 0x00000000 0x0 0x00000000>,
+		      <0x03000010 0x0 0x00000000 0x0 0x00200000>;
 		qcom,ath10k-calibration-variant = "GO_DUMO";
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index c9bf1d5c3a42..789fd0dcc88b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -489,6 +489,7 @@ pci_rootport: pcie@0,0 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
+		device_type = "pci";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index abee88911982..b7e2b475f070 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -970,7 +970,7 @@ pcie2x1: pcie@fe260000 {
 			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "sys", "pmc", "msi", "legacy", "err";
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
 		bus-range = <0x0 0xf>;
 		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
 			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index 17f687510c48..7a0e7b59be9b 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -44,9 +44,6 @@
 		return sys_ni_syscall();						\
 	}
 
-#define COMPAT_SYS_NI(name) \
-	SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
@@ -82,6 +79,5 @@
 	}
 
 asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused);
-#define SYS_NI(name) SYSCALL_ALIAS(__arm64_sys_##name, sys_ni_posix_timers);
 
 #endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 96747bfec1a1..d423fba7c406 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -80,7 +80,7 @@ endif
 
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS_KERNEL		+= -fPIE
-LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
+LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
 cflags-y += $(call cc-option, -mno-check-zero-division)
diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 091897d40b03..91d81f9730ab 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -32,6 +32,6 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
 
-unsigned long kernel_entry_address(void);
+unsigned long kernel_entry_address(unsigned long kernel_addr);
 
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index b9a4ab54285c..9b16a3b8e706 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -293,7 +293,7 @@ extern const char *__elf_platform;
 #define ELF_PLAT_INIT(_r, load_addr)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
-	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
+	_r->regs[9] = _r->regs[10] /* syscall n */ = _r->regs[12] = 0;	\
 	_r->regs[13] = _r->regs[14] = _r->regs[15] = _r->regs[16] = 0;	\
 	_r->regs[17] = _r->regs[18] = _r->regs[19] = _r->regs[20] = 0;	\
 	_r->regs[21] = _r->regs[22] = _r->regs[23] = _r->regs[24] = 0;	\
diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
index 92270f14db94..f623feb2129f 100644
--- a/arch/loongarch/kernel/stacktrace.c
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -32,7 +32,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 
 	for (unwind_start(&state, task, regs);
-	     !unwind_done(&state) && !unwind_error(&state); unwind_next_frame(&state)) {
+	     !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
 		if (!addr || !consume_entry(cookie, addr))
 			break;
diff --git a/arch/loongarch/kernel/unwind.c b/arch/loongarch/kernel/unwind.c
index ba324ba76fa1..a463d6961344 100644
--- a/arch/loongarch/kernel/unwind.c
+++ b/arch/loongarch/kernel/unwind.c
@@ -28,6 +28,5 @@ bool default_next_frame(struct unwind_state *state)
 
 	} while (!get_stack_info(state->sp, state->task, info));
 
-	state->error = true;
 	return false;
 }
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index 55afc27320e1..929ae240280a 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -227,7 +227,7 @@ static bool next_frame(struct unwind_state *state)
 	} while (!get_stack_info(state->sp, state->task, info));
 
 out:
-	state->error = true;
+	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
 }
 
diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index f878f47e4501..ee3e2153dd13 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -130,8 +130,7 @@ gmac@3,0 {
 				compatible = "pci0014,7a03.0",
 						   "pci0014,7a03",
 						   "pciclass0c0320",
-						   "pciclass0c03",
-						   "loongson, pci-gmac";
+						   "pciclass0c03";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
 				interrupts = <12 IRQ_TYPE_LEVEL_LOW>,
diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 7c69e8245c2f..cce9428afc41 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -193,8 +193,7 @@ gmac@3,0 {
 				compatible = "pci0014,7a03.0",
 						   "pci0014,7a03",
 						   "pciclass020000",
-						   "pciclass0200",
-						   "loongson, pci-gmac";
+						   "pciclass0200";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index 1d7942c8a6cb..eeec04b7dae6 100644
--- a/arch/riscv/include/asm/syscall_wrapper.h
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -46,9 +46,6 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 		return sys_ni_syscall();						\
 	}
 
-#define COMPAT_SYS_NI(name) \
-	SYSCALL_ALIAS(__riscv_compat_sys_##name, sys_ni_posix_timers);
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
@@ -82,6 +79,4 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 		return sys_ni_syscall();					\
 	}
 
-#define SYS_NI(name) SYSCALL_ALIAS(__riscv_sys_##name, sys_ni_posix_timers);
-
 #endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 9286430fe729..35c1d1b860d8 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -63,10 +63,6 @@
 	cond_syscall(__s390x_sys_##name);				\
 	cond_syscall(__s390_sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers)
-
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
 	long __s390_compat_sys##name(struct pt_regs *regs);				\
 	ALLOW_ERROR_INJECTION(__s390_compat_sys##name, ERRNO);				\
@@ -85,15 +81,11 @@
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
- * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
- * kernel/time/posix-stubs.c to cover this case as well.
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name)					\
 	cond_syscall(__s390_compat_sys_##name)
 
-#define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__s390_compat_sys_##name, sys_ni_posix_timers)
-
 #define __S390_SYS_STUBx(x, name, ...)						\
 	long __s390_sys##name(struct pt_regs *regs);				\
 	ALLOW_ERROR_INJECTION(__s390_sys##name, ERRNO);				\
@@ -124,9 +116,6 @@
 #define COND_SYSCALL(name)						\
 	cond_syscall(__s390x_sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers)
-
 #define __S390_SYS_STUBx(x, fullname, name, ...)
 
 #endif /* CONFIG_COMPAT */
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index fd2669b1cb2d..21f9407be5d3 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -86,9 +86,6 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		return sys_ni_syscall();				\
 	}
 
-#define __SYS_NI(abi, name)						\
-	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);
-
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -100,13 +97,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X64_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, sys_##name)
 
-#define __X64_SYS_NI(name)						\
-	__SYS_NI(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
 #define __X64_COND_SYSCALL(name)
-#define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
@@ -120,13 +114,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COND_SYSCALL(name)					\
 	__COND_SYSCALL(ia32, sys_##name)
 
-#define __IA32_SYS_NI(name)						\
-	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
 #define __IA32_COND_SYSCALL(name)
-#define __IA32_SYS_NI(name)
 #endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -135,8 +126,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * additional wrappers (aptly named __ia32_sys_xyzzy) which decode the
  * ia32 regs in the proper order for shared or "common" syscalls. As some
  * syscalls may not be implemented, we need to expand COND_SYSCALL in
- * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
- * case as well.
+ * kernel/sys_ni.c to cover this case as well.
  */
 #define __IA32_COMPAT_SYS_STUB0(name)					\
 	__SYS_STUB0(ia32, compat_sys_##name)
@@ -148,14 +138,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COMPAT_COND_SYSCALL(name)				\
 	__COND_SYSCALL(ia32, compat_sys_##name)
 
-#define __IA32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(ia32, compat_sys_##name)
-
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
-#define __IA32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -175,13 +161,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, compat_sys_##name)
 
-#define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x64, compat_sys_##name)
 #else /* CONFIG_X86_X32_ABI */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
-#define __X32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_X86_X32_ABI */
 
 
@@ -212,17 +195,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
- * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
- * kernel/time/posix-stubs.c to cover this case as well.
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
 	__IA32_COMPAT_COND_SYSCALL(name)				\
 	__X32_COMPAT_COND_SYSCALL(name)
 
-#define COMPAT_SYS_NI(name)						\
-	__IA32_COMPAT_SYS_NI(name)					\
-	__X32_COMPAT_SYS_NI(name)
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)					\
@@ -243,8 +221,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
  * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
  * hurt, we only need to re-define it here to keep the naming congruent to
- * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
- * macros to work correctly.
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() macro
+ * to work correctly.
  */
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
@@ -257,10 +235,6 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-#define SYS_NI(name)							\
-	__X64_SYS_NI(name)						\
-	__IA32_SYS_NI(name)
-
 
 /*
  * For VSYSCALLS, we need to declare these three syscalls with the new
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6cc7a2c181da..a4ebd5e0ae82 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -208,6 +208,11 @@ static int __init save_microcode_in_initrd(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int ret = -EINVAL;
 
+	if (dis_ucode_ldr) {
+		ret = 0;
+		goto out;
+	}
+
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		if (c->x86 >= 6)
@@ -221,6 +226,7 @@ static int __init save_microcode_in_initrd(void)
 		break;
 	}
 
+out:
 	initrd_gone = true;
 
 	return ret;
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index cea25ca8b8cf..c9dae65ac01b 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -11,26 +11,23 @@
 #include <asm/checksum.h>
 #include <asm/word-at-a-time.h>
 
-static inline unsigned short from32to16(unsigned a)
+static inline __wsum csum_finalize_sum(u64 temp64)
 {
-	unsigned short b = a >> 16;
-	asm("addw %w2,%w0\n\t"
-	    "adcw $0,%w0\n"
-	    : "=r" (b)
-	    : "0" (b), "r" (a));
-	return b;
+	return (__force __wsum)((temp64 + ror64(temp64, 32)) >> 32);
 }
 
-static inline __wsum csum_tail(u64 temp64, int odd)
+static inline unsigned long update_csum_40b(unsigned long sum, const unsigned long m[5])
 {
-	unsigned int result;
-
-	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
-	if (unlikely(odd)) {
-		result = from32to16(result);
-		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
-	}
-	return (__force __wsum)result;
+	asm("addq %1,%0\n\t"
+	     "adcq %2,%0\n\t"
+	     "adcq %3,%0\n\t"
+	     "adcq %4,%0\n\t"
+	     "adcq %5,%0\n\t"
+	     "adcq $0,%0"
+		:"+r" (sum)
+		:"m" (m[0]), "m" (m[1]), "m" (m[2]),
+		 "m" (m[3]), "m" (m[4]));
+	return sum;
 }
 
 /*
@@ -47,64 +44,32 @@ static inline __wsum csum_tail(u64 temp64, int odd)
 __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	u64 temp64 = (__force u64)sum;
-	unsigned odd;
 
-	odd = 1 & (unsigned long) buff;
-	if (unlikely(odd)) {
-		if (unlikely(len == 0))
-			return sum;
-		temp64 = ror32((__force u32)sum, 8);
-		temp64 += (*(unsigned char *)buff << 8);
-		len--;
-		buff++;
+	/* Do two 40-byte chunks in parallel to get better ILP */
+	if (likely(len >= 80)) {
+		u64 temp64_2 = 0;
+		do {
+			temp64 = update_csum_40b(temp64, buff);
+			temp64_2 = update_csum_40b(temp64_2, buff + 40);
+			buff += 80;
+			len -= 80;
+		} while (len >= 80);
+
+		asm("addq %1,%0\n\t"
+		    "adcq $0,%0"
+		    :"+r" (temp64): "r" (temp64_2));
 	}
 
 	/*
-	 * len == 40 is the hot case due to IPv6 headers, but annotating it likely()
-	 * has noticeable negative affect on codegen for all other cases with
-	 * minimal performance benefit here.
+	 * len == 40 is the hot case due to IPv6 headers, so return
+	 * early for that exact case without checking the tail bytes.
 	 */
-	if (len == 40) {
-		asm("addq 0*8(%[src]),%[res]\n\t"
-		    "adcq 1*8(%[src]),%[res]\n\t"
-		    "adcq 2*8(%[src]),%[res]\n\t"
-		    "adcq 3*8(%[src]),%[res]\n\t"
-		    "adcq 4*8(%[src]),%[res]\n\t"
-		    "adcq $0,%[res]"
-		    : [res] "+r"(temp64)
-		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
-		return csum_tail(temp64, odd);
-	}
-	if (unlikely(len >= 64)) {
-		/*
-		 * Extra accumulators for better ILP in the loop.
-		 */
-		u64 tmp_accum, tmp_carries;
-
-		asm("xorl %k[tmp_accum],%k[tmp_accum]\n\t"
-		    "xorl %k[tmp_carries],%k[tmp_carries]\n\t"
-		    "subl $64, %[len]\n\t"
-		    "1:\n\t"
-		    "addq 0*8(%[src]),%[res]\n\t"
-		    "adcq 1*8(%[src]),%[res]\n\t"
-		    "adcq 2*8(%[src]),%[res]\n\t"
-		    "adcq 3*8(%[src]),%[res]\n\t"
-		    "adcl $0,%k[tmp_carries]\n\t"
-		    "addq 4*8(%[src]),%[tmp_accum]\n\t"
-		    "adcq 5*8(%[src]),%[tmp_accum]\n\t"
-		    "adcq 6*8(%[src]),%[tmp_accum]\n\t"
-		    "adcq 7*8(%[src]),%[tmp_accum]\n\t"
-		    "adcl $0,%k[tmp_carries]\n\t"
-		    "addq $64, %[src]\n\t"
-		    "subl $64, %[len]\n\t"
-		    "jge 1b\n\t"
-		    "addq %[tmp_accum],%[res]\n\t"
-		    "adcq %[tmp_carries],%[res]\n\t"
-		    "adcq $0,%[res]"
-		    : [tmp_accum] "=&r"(tmp_accum),
-		      [tmp_carries] "=&r"(tmp_carries), [res] "+r"(temp64),
-		      [len] "+r"(len), [src] "+r"(buff)
-		    : "m"(*(const char *)buff));
+	if (len >= 40) {
+		temp64 = update_csum_40b(temp64, buff);
+		len -= 40;
+		if (!len)
+			return csum_finalize_sum(temp64);
+		buff += 40;
 	}
 
 	if (len & 32) {
@@ -143,7 +108,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    : [res] "+r"(temp64)
 		    : [trail] "r"(trail));
 	}
-	return csum_tail(temp64, odd);
+	return csum_finalize_sum(temp64);
 }
 EXPORT_SYMBOL(csum_partial);
 
diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..2eca76ccf4ee 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -501,9 +501,17 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
-		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
-				    bio->bi_bdev);
-		/* Older lvm-tools actually trigger this */
+
+		if (bio->bi_bdev->bd_ro_warned)
+			return;
+
+		bio->bi_bdev->bd_ro_warned = true;
+		/*
+		 * Use ioctl to set underlying disk of raid/dm to read-only
+		 * will trigger this.
+		 */
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bio->bi_bdev);
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6ab7f360ff2a..20ecd0ab616f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1511,14 +1511,26 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
+static bool blk_is_flush_data_rq(struct request *rq)
+{
+	return (rq->rq_flags & RQF_FLUSH_SEQ) && !is_flush_rq(rq);
+}
+
 static bool blk_mq_rq_inflight(struct request *rq, void *priv)
 {
 	/*
 	 * If we find a request that isn't idle we know the queue is busy
 	 * as it's checked in the iter.
 	 * Return false to stop the iteration.
+	 *
+	 * In case of queue quiesce, if one flush data request is completed,
+	 * don't count it as inflight given the flush sequence is suspended,
+	 * and the original flush data request is invisible to driver, just
+	 * like other pending requests because of quiesce
 	 */
-	if (blk_mq_request_started(rq)) {
+	if (blk_mq_request_started(rq) && !(blk_queue_quiesced(rq->q) &&
+				blk_is_flush_data_rq(rq) &&
+				blk_mq_request_completed(rq))) {
 		bool *busy = priv;
 
 		*busy = true;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d09e3e7bcb58..85ae394e793e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -508,6 +508,13 @@ static const struct dmi_system_id maingear_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
 		},
 	},
+	{
+		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 92128aae2d06..71a40a4c546f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5030,7 +5030,7 @@ static __poll_t binder_poll(struct file *filp,
 
 	thread = binder_get_thread(proc);
 	if (!thread)
-		return POLLERR;
+		return EPOLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e3db8297095a..5e2505fa82ff 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -557,7 +557,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * is the sum of the three given sizes (each rounded up to
  * pointer-sized boundary)
  *
- * Return:	The allocated buffer or %NULL if error
+ * Return:	The allocated buffer or %ERR_PTR(-errno) if error
  */
 struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
@@ -706,7 +706,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
@@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	vma = binder_alloc_get_vma(alloc);
+	vma = vma_lookup(mm, page_addr);
+	if (vma && vma != binder_alloc_get_vma(alloc))
+		goto err_invalid_vma;
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -1031,6 +1033,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
+err_invalid_vma:
+	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4a4b9bad551e..225c86c74d4e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1021,12 +1021,12 @@ static void virtblk_config_changed(struct virtio_device *vdev)
 static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
-	int i;
+	unsigned short i;
 	vq_callback_t **callbacks;
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
-	unsigned int num_poll_vqs;
+	unsigned short num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -1070,13 +1070,13 @@ static int init_vq(struct virtio_blk *vblk)
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
 		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
 		callbacks[i] = NULL;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 5eb0fe73ddc4..e384fbc6c1d9 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -755,7 +755,7 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 	moxtet->irq.masked = ~0;
 
 	ret = request_threaded_irq(moxtet->dev_irq, NULL, moxtet_irq_thread_fn,
-				   IRQF_ONESHOT, "moxtet", moxtet);
+				   IRQF_SHARED | IRQF_ONESHOT, "moxtet", moxtet);
 	if (ret < 0)
 		goto err_free;
 
@@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
 	mutex_destroy(&moxtet->lock);
 }
 
+static const struct spi_device_id moxtet_spi_ids[] = {
+	{ "moxtet" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
+
 static const struct of_device_id moxtet_dt_ids[] = {
 	{ .compatible = "cznic,moxtet" },
 	{},
@@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver = {
 		.name		= "moxtet",
 		.of_match_table = moxtet_dt_ids,
 	},
+	.id_table	= moxtet_spi_ids,
 	.probe		= moxtet_probe,
 	.remove		= moxtet_remove,
 };
diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 22e752236030..75071e0cd321 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -484,7 +484,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_I2S_2CH, "hclk_i2s_2ch", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS),
 	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 13, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(0, "hclk_peri_ahb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 14, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 12, GFLAGS),
diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 16dabe2b9c47..db713e1526cd 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -72,6 +72,7 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
 	RK3036_PLL_RATE(408000000, 1, 68, 2, 2, 1, 0),
 	RK3036_PLL_RATE(312000000, 1, 78, 6, 1, 1, 0),
 	RK3036_PLL_RATE(297000000, 2, 99, 4, 1, 1, 0),
+	RK3036_PLL_RATE(292500000, 1, 195, 4, 4, 1, 0),
 	RK3036_PLL_RATE(241500000, 2, 161, 4, 2, 1, 0),
 	RK3036_PLL_RATE(216000000, 1, 72, 4, 2, 1, 0),
 	RK3036_PLL_RATE(200000000, 1, 100, 3, 4, 1, 0),
diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e696176..3d5e6d705fc6 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -108,8 +108,9 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data);
+	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data) == -ESRCH)
+		atomic_set(&proc_event_num_listeners, 0);
 
 	local_unlock(&local_event.lock);
 }
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index 72c71ae201f0..d6ec5d4b8dbe 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -35,9 +35,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	return status;
 }
 
-unsigned long kernel_entry_address(void)
+unsigned long kernel_entry_address(unsigned long kernel_addr)
 {
 	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
 
-	return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
+	return (unsigned long)&kernel_entry - base + kernel_addr;
 }
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 807cba2693fc..0e0aa6cda73f 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(void)
+unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
 {
-	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+	return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
 }
 
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
@@ -73,7 +73,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
-	real_kernel_entry = (void *)kernel_entry_address();
+	real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 05405da51e7a..3f2126f99923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -638,6 +638,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -694,6 +697,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_wreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f85eec05d218..ae45656eb877 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -604,11 +604,6 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 		dev_info(adev->dev, "RAS controller interrupt triggered "
 					"by NBIF error\n");
-
-		/* ras_controller_int is dedicated for nbif ras error,
-		 * not the global interrupt for sync flood
-		 */
-		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 28094cd7d9c2..3667f9a54841 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1160,6 +1160,11 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x46;
+		/* GC 9.4.3 uses MMIO register region hole at a different offset */
+		if (!amdgpu_sriov_vf(adev)) {
+			adev->rmmio_remap.reg_offset = 0x1A000;
+			adev->rmmio_remap.bus_addr = adev->rmmio_base + 0x1A000;
+		}
 		break;
 	default:
 		/* FIXME: not supported yet */
@@ -1417,9 +1422,11 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	adev->nbio.funcs->get_clockgating_state(adev, flags);
+	if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
+		adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	adev->hdp.funcs->get_clock_gating_state(adev, flags);
+	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
+		adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(13, 0, 2)) {
 
@@ -1435,9 +1442,11 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	}
 
 	/* AMD_CG_SUPPORT_ROM_MGCG */
-	adev->smuio.funcs->get_clock_gating_state(adev, flags);
+	if (adev->smuio.funcs && adev->smuio.funcs->get_clock_gating_state)
+		adev->smuio.funcs->get_clock_gating_state(adev, flags);
 
-	adev->df.funcs->get_clockgating_state(adev, flags);
+	if (adev->df.funcs && adev->df.funcs->get_clockgating_state)
+		adev->df.funcs->get_clockgating_state(adev, flags);
 }
 
 static int soc15_common_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fa24e1852493..df7a5cdb8693 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1128,7 +1128,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
-	if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 77649392e233..77f493262e05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -169,16 +169,43 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
+				     struct process_queue_node *pqn)
+{
+	struct kfd_node *dev;
+	struct kfd_process_device *pdd;
+
+	dev = pqn->q->device;
+
+	pdd = kfd_get_process_device_data(dev, pqm->process);
+	if (!pdd) {
+		pr_err("Process device data doesn't exist\n");
+		return;
+	}
+
+	if (pqn->q->gws) {
+		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    !dev->kfd->shared_resources.enable_mes)
+			amdgpu_amdkfd_remove_gws_from_process(
+				pqm->process->kgd_process_info, pqn->q->gws);
+		pdd->qpd.num_gws = 0;
+	}
+
+	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		if (pqn->q->wptr_bo)
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+	}
+}
+
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-		    !pqn->q->device->kfd->shared_resources.enable_mes)
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+		if (pqn->q)
+			pqm_clean_queue_resource(pqm, pqn);
+
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
@@ -461,22 +488,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				goto err_destroy_queue;
 		}
 
-		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-			    !dev->kfd->shared_resources.enable_mes)
-				amdgpu_amdkfd_remove_gws_from_process(
-						pqm->process->kgd_process_info,
-						pqn->q->gws);
-			pdd->qpd.num_gws = 0;
-		}
-
-		if (dev->kfd->shared_resources.enable_mes) {
-			amdgpu_amdkfd_free_gtt_mem(dev->adev,
-						   pqn->q->gang_ctx_bo);
-			if (pqn->q->wptr_bo)
-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
-
-		}
+		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 63ce30ea6891..8e368e4659fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1632,18 +1632,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			if (test_bit(gpuidx, prange->bitmap_access))
 				bitmap_set(ctx->bitmap, gpuidx, 1);
 		}
+
+		/*
+		 * If prange is already mapped or with always mapped flag,
+		 * update mapping on GPUs with ACCESS attribute
+		 */
+		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
+			if (prange->mapped_to_gpu ||
+			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+		}
 	} else {
 		bitmap_or(ctx->bitmap, prange->bitmap_access,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
 	}
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange->mapped_to_gpu ||
-		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-			r = 0;
-			goto free_ctx;
-		}
+		r = 0;
+		goto free_ctx;
 	}
 
 	if (prange->actual_loc && !prange->ttm_res) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 4b230933b28e..87a1000b8572 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -63,6 +63,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
+	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.remove_sink_ext_caps = true;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 484d62bcf2c2..bbf2a465f400 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1015,13 +1015,20 @@ static enum bp_result get_ss_info_v4_5(
 		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
-		ss_info->spread_spectrum_percentage =
+		if (bp->base.integrated_info) {
+			DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", bp->base.integrated_info->gpuclk_ss_percentage);
+			ss_info->spread_spectrum_percentage =
+					bp->base.integrated_info->gpuclk_ss_percentage;
+			ss_info->type.CENTER_MODE =
+					bp->base.integrated_info->gpuclk_ss_type;
+		} else {
+			ss_info->spread_spectrum_percentage =
 				disp_cntl_tbl->dp_ss_percentage;
-		ss_info->spread_spectrum_range =
+			ss_info->spread_spectrum_range =
 				disp_cntl_tbl->dp_ss_rate_10hz * 10;
-		if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
-			ss_info->type.CENTER_MODE = true;
-
+			if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
+				ss_info->type.CENTER_MODE = true;
+		}
 		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
@@ -1692,7 +1699,7 @@ static enum bp_result bios_parser_enable_disp_power_gating(
 static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
@@ -1700,7 +1707,7 @@ static enum bp_result bios_parser_enable_lvtma_control(
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_panel_control_wait);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, pwrseq_instance, bypass_panel_control_wait);
 }
 
 static bool bios_parser_is_accelerated_mode(
@@ -2826,6 +2833,8 @@ static enum bp_result get_integrated_info_v2_2(
 	info->ma_channel_number = info_v2_2->umachannelnumber;
 	info->dp_ss_control =
 		le16_to_cpu(info_v2_2->reserved1);
+	info->gpuclk_ss_percentage = info_v2_2->gpuclk_ss_percentage;
+	info->gpuclk_ss_type = info_v2_2->gpuclk_ss_type;
 
 	for (i = 0; i < NUMBER_OF_UCHAR_FOR_GUID; ++i) {
 		info->ext_disp_conn_info.gu_id[i] =
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 90a02d7bd3da..ab0adabf9dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -976,7 +976,7 @@ static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
@@ -989,7 +989,7 @@ static void init_enable_lvtma_control(struct bios_parser *bp)
 static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 
@@ -1002,8 +1002,8 @@ static void enable_lvtma_control_dmcub(
 			DMUB_CMD__VBIOS_LVTMA_CONTROL;
 	cmd.lvtma_control.data.uc_pwr_action =
 			uc_pwr_on;
-	cmd.lvtma_control.data.panel_inst =
-			panel_instance;
+	cmd.lvtma_control.data.pwrseq_inst =
+			pwrseq_instance;
 	cmd.lvtma_control.data.bypass_panel_control_wait =
 			bypass_panel_control_wait;
 	dm_execute_dmub_cmd(dmcub->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
@@ -1012,7 +1012,7 @@ static void enable_lvtma_control_dmcub(
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
@@ -1021,7 +1021,7 @@ static enum bp_result enable_lvtma_control(
 	    bp->base.ctx->dc->debug.dmub_command_table) {
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
 				uc_pwr_on,
-				panel_instance,
+				pwrseq_instance,
 				bypass_panel_control_wait);
 		return BP_RESULT_OK;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index b6d09bf6cf72..41c8c014397f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -96,7 +96,7 @@ struct cmd_tbl {
 			struct bios_parser *bp, uint8_t id);
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
 			uint8_t uc_pwr_on,
-			uint8_t panel_instance,
+			uint8_t pwrseq_instance,
 			uint8_t bypass_panel_control_wait);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index b2c4f97afc8b..8776055bbeaa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -334,7 +334,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -342,7 +342,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -350,7 +350,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -358,7 +358,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a1be93f6385c..8cdf380bf366 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4865,18 +4865,28 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
-	/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
-	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	switch (dc->ctx->asic_id.chip_family) {
 
-	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	case FAMILY_YELLOW_CARP:
+		/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
+		if (dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
+		    !dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	case AMDGPU_FAMILY_GC_11_0_1:
+	case AMDGPU_FAMILY_GC_11_5_0:
+		if (!dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	default:
+		break;
+	}
 
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
+
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index be9aa1a71847..26940d94d8fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -140,7 +140,7 @@ struct dc_vbios_funcs {
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on,
-		uint8_t panel_instance,
+		uint8_t pwrseq_instance,
 		uint8_t bypass_panel_control_wait);
 
 	enum bp_result (*get_soc_bb_info)(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index d3e6544022b7..930fd929e93a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -145,7 +145,11 @@ static bool dmub_abm_save_restore_ex(
 	return ret;
 }
 
-static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe_ex(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	bool ret = false;
 	unsigned int feature_support;
@@ -153,7 +157,7 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t op
 	feature_support = abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
-		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst);
+		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 592a8f7a1c6d..42c802afc468 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -254,7 +254,11 @@ bool dmub_abm_save_restore(
 	return true;
 }
 
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+bool dmub_abm_set_pipe(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -264,6 +268,7 @@ bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
index 853564d7f471..07ea6c8d414f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -44,7 +44,7 @@ bool dmub_abm_save_restore(
 		struct dc_context *dc,
 		unsigned int panel_inst,
 		struct abm_save_restore *pData);
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 bool dmub_abm_set_backlight_level(struct abm *abm,
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9c78e42418f3..7fbbad69064f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -788,7 +788,7 @@ void dce110_edp_power_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result bp_result;
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
@@ -871,7 +871,7 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
-		panel_instance = link->panel_cntl->inst;
+		pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
@@ -879,11 +879,11 @@ void dce110_edp_power_control(
 			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON) {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_ON,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			} else {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_OFF,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			}
 		}
 
@@ -954,7 +954,7 @@ void dce110_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
 	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
 
@@ -1007,7 +1007,7 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	panel_instance = link->panel_cntl->inst;
+	pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -1032,11 +1032,11 @@ void dce110_edp_backlight_control(
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLON,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 43463d08f21b..f99b1bc49694 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -137,7 +137,8 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
+		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -147,6 +148,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t optio
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
@@ -179,7 +181,6 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	struct abm *abm = pipe_ctx->stream_res.abm;
 	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
-
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 
 	if (dmcu) {
@@ -190,9 +191,13 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
 			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-			panel_cntl->inst);
+					panel_cntl->inst, panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE, panel_cntl->inst);
+				dmub_abm_set_pipe(abm,
+						otg_inst,
+						SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
@@ -212,9 +217,16 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				dmub_abm_set_pipe(abm, otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 	}
 }
@@ -237,9 +249,17 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 
 		if (abm && panel_cntl) {
 			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				abm->funcs->set_pipe_ex(abm,
+						otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 			} else {
-				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+					dmub_abm_set_pipe(abm,
+							otg_inst,
+							SET_ABM_PIPE_NORMAL,
+							panel_cntl->inst,
+							panel_cntl->pwrseq_inst);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 217acd4e292a..d849b1eaa4a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -50,7 +50,7 @@ static bool dcn31_query_backlight_info(struct panel_cntl *panel_cntl, union dmub
 	cmd->panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd->panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO;
 	cmd->panel_cntl.header.payload_bytes = sizeof(cmd->panel_cntl.data);
-	cmd->panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd->panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 
 	return dm_execute_dmub_cmd(dc_dmub_srv->ctx, cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 }
@@ -78,7 +78,7 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	cmd.panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd.panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_HW_INIT;
 	cmd.panel_cntl.header.payload_bytes = sizeof(cmd.panel_cntl.data);
-	cmd.panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd.panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 	cmd.panel_cntl.data.bl_pwm_cntl = panel_cntl->stored_backlight_registers.BL_PWM_CNTL;
 	cmd.panel_cntl.data.bl_pwm_period_cntl = panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL;
 	cmd.panel_cntl.data.bl_pwm_ref_div1 =
@@ -157,4 +157,5 @@ void dcn31_panel_cntl_construct(
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
+	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 33db15d69f23..9f521cf0fc5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -64,7 +64,8 @@ struct abm_funcs {
 	bool (*set_pipe_ex)(struct abm *abm,
 			unsigned int otg_inst,
 			unsigned int option,
-			unsigned int panel_inst);
+			unsigned int panel_inst,
+			unsigned int pwrseq_inst);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 24af9d80b937..248adc1705e3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -56,12 +56,14 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 };
 
 struct panel_cntl {
 	const struct panel_cntl_funcs *funcs;
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 	/* registers setting needs to be saved and restored at InitBacklight */
 	struct panel_cntl_backlight_registers stored_backlight_registers;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index e406561c2c23..2c366866f570 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -367,6 +367,27 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
+static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
+{
+	uint8_t pwrseq_inst = 0xF;
+
+	switch (link->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	return pwrseq_inst;
+}
+
+
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -594,24 +615,6 @@ static bool construct_phy(struct dc_link *link,
 	link->ddc_hw_inst =
 		dal_ddc_get_line(get_ddc_pin(link->ddc));
 
-
-	if (link->dc->res_pool->funcs->panel_cntl_create &&
-		(link->link_id.id == CONNECTOR_ID_EDP ||
-			link->link_id.id == CONNECTOR_ID_LVDS)) {
-		panel_cntl_init_data.ctx = dc_ctx;
-		panel_cntl_init_data.inst =
-			panel_cntl_init_data.ctx->dc_edp_id_count;
-		link->panel_cntl =
-			link->dc->res_pool->funcs->panel_cntl_create(
-								&panel_cntl_init_data);
-		panel_cntl_init_data.ctx->dc_edp_id_count++;
-
-		if (link->panel_cntl == NULL) {
-			DC_ERROR("Failed to create link panel_cntl!\n");
-			goto panel_cntl_create_fail;
-		}
-	}
-
 	enc_init_data.ctx = dc_ctx;
 	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
 			      &enc_init_data.encoder);
@@ -642,6 +645,23 @@ static bool construct_phy(struct dc_link *link,
 	link->dc->res_pool->dig_link_enc_count++;
 
 	link->link_enc_hw_inst = link->link_enc->transmitter;
+
+	if (link->dc->res_pool->funcs->panel_cntl_create &&
+		(link->link_id.id == CONNECTOR_ID_EDP ||
+			link->link_id.id == CONNECTOR_ID_LVDS)) {
+		panel_cntl_init_data.ctx = dc_ctx;
+		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
+		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		link->panel_cntl =
+			link->dc->res_pool->funcs->panel_cntl_create(
+								&panel_cntl_init_data);
+		panel_cntl_init_data.ctx->dc_edp_id_count++;
+
+		if (link->panel_cntl == NULL) {
+			DC_ERROR("Failed to create link panel_cntl!\n");
+			goto panel_cntl_create_fail;
+		}
+	}
 	for (i = 0; i < 4; i++) {
 		if (bp_funcs->get_device_tag(dc_ctx->dc_bios,
 					     link->link_id, i,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7afa78b918b5..d58cb7f63a4b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3301,6 +3301,16 @@ struct dmub_cmd_abm_set_pipe_data {
 	 * TODO: Remove.
 	 */
 	uint8_t ramping_boundary;
+
+	/**
+	 * PwrSeq HW Instance.
+	 */
+	uint8_t pwrseq_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
 };
 
 /**
@@ -3715,7 +3725,7 @@ enum dmub_cmd_panel_cntl_type {
  * struct dmub_cmd_panel_cntl_data - Panel control data.
  */
 struct dmub_cmd_panel_cntl_data {
-	uint32_t inst; /**< panel instance */
+	uint32_t pwrseq_inst; /**< pwrseq instance */
 	uint32_t current_backlight; /* in/out */
 	uint32_t bl_pwm_cntl; /* in/out */
 	uint32_t bl_pwm_period_cntl; /* in/out */
@@ -3742,7 +3752,7 @@ struct dmub_cmd_lvtma_control_data {
 	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
 	uint8_t bypass_panel_control_wait;
 	uint8_t reserved_0[2]; /**< For future use */
-	uint8_t panel_inst; /**< LVTMA control instance */
+	uint8_t pwrseq_inst; /**< LVTMA control instance */
 	uint8_t reserved_1[3]; /**< For future use */
 };
 
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index bc96d0211360..813463ffe15c 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -417,6 +417,8 @@ struct integrated_info {
 	/* V2.1 */
 	struct edp_info edp1_info;
 	struct edp_info edp2_info;
+	uint32_t gpuclk_ss_percentage;
+	uint32_t gpuclk_ss_type;
 };
 
 /*
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index df9bf3c9206e..cb90e70d85e8 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -715,8 +715,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_set set;
 	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
-	int ret;
-	int i;
+	int ret, i, num_connectors = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
@@ -871,6 +870,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 					connector->name);
 
 			connector_set[i] = connector;
+			num_connectors++;
 		}
 	}
 
@@ -879,7 +879,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	set.y = crtc_req->y;
 	set.mode = mode;
 	set.connectors = connector_set;
-	set.num_connectors = crtc_req->count_connectors;
+	set.num_connectors = num_connectors;
 	set.fb = fb;
 
 	if (drm_drv_uses_atomic_modeset(dev))
@@ -892,7 +892,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		drm_framebuffer_put(fb);
 
 	if (connector_set) {
-		for (i = 0; i < crtc_req->count_connectors; i++) {
+		for (i = 0; i < num_connectors; i++) {
 			if (connector_set[i])
 				drm_connector_put(connector_set[i]);
 		}
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 63b709a67471..834a5e28abbe 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -278,7 +278,7 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_release);
 
-/*
+/**
  * drm_gem_prime_fd_to_handle - PRIME import function for GEM drivers
  * @dev: drm_device to import into
  * @file_priv: drm file-private structure
@@ -292,9 +292,9 @@ EXPORT_SYMBOL(drm_gem_dmabuf_release);
  *
  * Returns 0 on success or a negative error code on failure.
  */
-static int drm_gem_prime_fd_to_handle(struct drm_device *dev,
-				      struct drm_file *file_priv, int prime_fd,
-				      uint32_t *handle)
+int drm_gem_prime_fd_to_handle(struct drm_device *dev,
+			       struct drm_file *file_priv, int prime_fd,
+			       uint32_t *handle)
 {
 	struct dma_buf *dma_buf;
 	struct drm_gem_object *obj;
@@ -360,6 +360,7 @@ static int drm_gem_prime_fd_to_handle(struct drm_device *dev,
 	dma_buf_put(dma_buf);
 	return ret;
 }
+EXPORT_SYMBOL(drm_gem_prime_fd_to_handle);
 
 int drm_prime_fd_to_handle_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv)
@@ -408,7 +409,7 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
 	return dmabuf;
 }
 
-/*
+/**
  * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
  * @dev: dev to export the buffer from
  * @file_priv: drm file-private structure
@@ -421,10 +422,10 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
  * The actual exporting from GEM object to a dma-buf is done through the
  * &drm_gem_object_funcs.export callback.
  */
-static int drm_gem_prime_handle_to_fd(struct drm_device *dev,
-				      struct drm_file *file_priv, uint32_t handle,
-				      uint32_t flags,
-				      int *prime_fd)
+int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+			       struct drm_file *file_priv, uint32_t handle,
+			       uint32_t flags,
+			       int *prime_fd)
 {
 	struct drm_gem_object *obj;
 	int ret = 0;
@@ -506,6 +507,7 @@ static int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
 
 int drm_prime_handle_to_fd_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv)
@@ -864,9 +866,9 @@ EXPORT_SYMBOL(drm_prime_get_contiguous_size);
  * @obj: GEM object to export
  * @flags: flags like DRM_CLOEXEC and DRM_RDWR
  *
- * This is the implementation of the &drm_gem_object_funcs.export functions
- * for GEM drivers using the PRIME helpers. It is used as the default for
- * drivers that do not set their own.
+ * This is the implementation of the &drm_gem_object_funcs.export functions for GEM drivers
+ * using the PRIME helpers. It is used as the default in
+ * drm_gem_prime_handle_to_fd().
  */
 struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 				     int flags)
@@ -962,9 +964,10 @@ EXPORT_SYMBOL(drm_gem_prime_import_dev);
  * @dev: drm_device to import into
  * @dma_buf: dma-buf object to import
  *
- * This is the implementation of the gem_prime_import functions for GEM
- * drivers using the PRIME helpers. It is the default for drivers that do
- * not set their own &drm_driver.gem_prime_import.
+ * This is the implementation of the gem_prime_import functions for GEM drivers
+ * using the PRIME helpers. Drivers can use this as their
+ * &drm_driver.gem_prime_import implementation. It is used as the default
+ * implementation in drm_gem_prime_fd_to_handle().
  *
  * Drivers must arrange to call drm_prime_gem_destroy() from their
  * &drm_gem_object_funcs.free hook when using this function.
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index a971590b8132..e2c7373f20c6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -107,18 +107,16 @@ int exynos_drm_register_dma(struct drm_device *drm, struct device *dev,
 		return 0;
 
 	if (!priv->mapping) {
-		void *mapping;
+		void *mapping = NULL;
 
 		if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
 			mapping = arm_iommu_create_mapping(&platform_bus_type,
 				EXYNOS_DEV_ADDR_START, EXYNOS_DEV_ADDR_SIZE);
 		else if (IS_ENABLED(CONFIG_IOMMU_DMA))
 			mapping = iommu_get_domain_for_dev(priv->dma_dev);
-		else
-			mapping = ERR_PTR(-ENODEV);
 
-		if (IS_ERR(mapping))
-			return PTR_ERR(mapping);
+		if (!mapping)
+			return -ENODEV;
 		priv->mapping = mapping;
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index f3aaa4ea3e68..dd9903eab563 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1861,6 +1861,8 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	crtc = exynos_drm_crtc_get_by_type(drm_dev, EXYNOS_DISPLAY_TYPE_HDMI);
+	if (IS_ERR(crtc))
+		return PTR_ERR(crtc);
 	crtc->pipe_clk = &hdata->phy_clk;
 
 	ret = hdmi_create_connector(encoder);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
index 6cb5eefa45e9..5a08458fe1b7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
@@ -31,7 +31,7 @@ tu102_vmm_flush(struct nvkm_vmm *vmm, int depth)
 
 	type |= 0x00000001; /* PAGE_ALL */
 	if (atomic_read(&vmm->engref[NVKM_SUBDEV_BAR]))
-		type |= 0x00000004; /* HUB_ONLY */
+		type |= 0x00000006; /* HUB_ONLY | ALL PDB (hack) */
 
 	mutex_lock(&vmm->mmu->mutex);
 
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 10468f727e5b..4850e915a57d 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -325,28 +325,28 @@ struct joycon_imu_cal {
  * All the controller's button values are stored in a u32.
  * They can be accessed with bitwise ANDs.
  */
-static const u32 JC_BTN_Y	= BIT(0);
-static const u32 JC_BTN_X	= BIT(1);
-static const u32 JC_BTN_B	= BIT(2);
-static const u32 JC_BTN_A	= BIT(3);
-static const u32 JC_BTN_SR_R	= BIT(4);
-static const u32 JC_BTN_SL_R	= BIT(5);
-static const u32 JC_BTN_R	= BIT(6);
-static const u32 JC_BTN_ZR	= BIT(7);
-static const u32 JC_BTN_MINUS	= BIT(8);
-static const u32 JC_BTN_PLUS	= BIT(9);
-static const u32 JC_BTN_RSTICK	= BIT(10);
-static const u32 JC_BTN_LSTICK	= BIT(11);
-static const u32 JC_BTN_HOME	= BIT(12);
-static const u32 JC_BTN_CAP	= BIT(13); /* capture button */
-static const u32 JC_BTN_DOWN	= BIT(16);
-static const u32 JC_BTN_UP	= BIT(17);
-static const u32 JC_BTN_RIGHT	= BIT(18);
-static const u32 JC_BTN_LEFT	= BIT(19);
-static const u32 JC_BTN_SR_L	= BIT(20);
-static const u32 JC_BTN_SL_L	= BIT(21);
-static const u32 JC_BTN_L	= BIT(22);
-static const u32 JC_BTN_ZL	= BIT(23);
+#define JC_BTN_Y	 BIT(0)
+#define JC_BTN_X	 BIT(1)
+#define JC_BTN_B	 BIT(2)
+#define JC_BTN_A	 BIT(3)
+#define JC_BTN_SR_R	 BIT(4)
+#define JC_BTN_SL_R	 BIT(5)
+#define JC_BTN_R	 BIT(6)
+#define JC_BTN_ZR	 BIT(7)
+#define JC_BTN_MINUS	 BIT(8)
+#define JC_BTN_PLUS	 BIT(9)
+#define JC_BTN_RSTICK	 BIT(10)
+#define JC_BTN_LSTICK	 BIT(11)
+#define JC_BTN_HOME	 BIT(12)
+#define JC_BTN_CAP	 BIT(13) /* capture button */
+#define JC_BTN_DOWN	 BIT(16)
+#define JC_BTN_UP	 BIT(17)
+#define JC_BTN_RIGHT	 BIT(18)
+#define JC_BTN_LEFT	 BIT(19)
+#define JC_BTN_SR_L	 BIT(20)
+#define JC_BTN_SL_L	 BIT(21)
+#define JC_BTN_L	 BIT(22)
+#define JC_BTN_ZL	 BIT(23)
 
 enum joycon_msg_type {
 	JOYCON_MSG_TYPE_NONE,
@@ -896,14 +896,27 @@ static int joycon_request_calibration(struct joycon_ctlr *ctlr)
  */
 static void joycon_calc_imu_cal_divisors(struct joycon_ctlr *ctlr)
 {
-	int i;
+	int i, divz = 0;
 
 	for (i = 0; i < 3; i++) {
 		ctlr->imu_cal_accel_divisor[i] = ctlr->accel_cal.scale[i] -
 						ctlr->accel_cal.offset[i];
 		ctlr->imu_cal_gyro_divisor[i] = ctlr->gyro_cal.scale[i] -
 						ctlr->gyro_cal.offset[i];
+
+		if (ctlr->imu_cal_accel_divisor[i] == 0) {
+			ctlr->imu_cal_accel_divisor[i] = 1;
+			divz++;
+		}
+
+		if (ctlr->imu_cal_gyro_divisor[i] == 0) {
+			ctlr->imu_cal_gyro_divisor[i] = 1;
+			divz++;
+		}
 	}
+
+	if (divz)
+		hid_warn(ctlr->hdev, "inaccurate IMU divisors (%d)\n", divz);
 }
 
 static const s16 DFLT_ACCEL_OFFSET /*= 0*/;
@@ -1132,16 +1145,16 @@ static void joycon_parse_imu_report(struct joycon_ctlr *ctlr,
 		    JC_IMU_SAMPLES_PER_DELTA_AVG) {
 			ctlr->imu_avg_delta_ms = ctlr->imu_delta_samples_sum /
 						 ctlr->imu_delta_samples_count;
-			/* don't ever want divide by zero shenanigans */
-			if (ctlr->imu_avg_delta_ms == 0) {
-				ctlr->imu_avg_delta_ms = 1;
-				hid_warn(ctlr->hdev,
-					 "calculated avg imu delta of 0\n");
-			}
 			ctlr->imu_delta_samples_count = 0;
 			ctlr->imu_delta_samples_sum = 0;
 		}
 
+		/* don't ever want divide by zero shenanigans */
+		if (ctlr->imu_avg_delta_ms == 0) {
+			ctlr->imu_avg_delta_ms = 1;
+			hid_warn(ctlr->hdev, "calculated avg imu delta of 0\n");
+		}
+
 		/* useful for debugging IMU sample rate */
 		hid_dbg(ctlr->hdev,
 			"imu_report: ms=%u last_ms=%u delta=%u avg_delta=%u\n",
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 904890598c11..2c7c92272fe3 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -899,7 +899,23 @@ static struct hid_driver corsairpsu_driver = {
 	.reset_resume	= corsairpsu_resume,
 #endif
 };
-module_hid_driver(corsairpsu_driver);
+
+static int __init corsair_init(void)
+{
+	return hid_register_driver(&corsairpsu_driver);
+}
+
+static void __exit corsair_exit(void)
+{
+	hid_unregister_driver(&corsairpsu_driver);
+}
+
+/*
+ * With module_init() the driver would load before the HID bus when
+ * built-in, so use late_initcall() instead.
+ */
+late_initcall(corsair_init);
+module_exit(corsair_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 20e2e4cb7614..da17b6c49b0f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1036,7 +1036,7 @@ struct etmv4_drvdata {
 	u8				ctxid_size;
 	u8				vmid_size;
 	u8				ccsize;
-	u8				ccitmin;
+	u16				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
 	u8				q_support;
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 3045d1894b81..a991ecb7515a 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -342,9 +342,9 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 		return ret;
 
 	hisi_ptt->trace_irq = pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ);
-	ret = devm_request_threaded_irq(&pdev->dev, hisi_ptt->trace_irq,
-					NULL, hisi_ptt_isr, 0,
-					DRV_NAME, hisi_ptt);
+	ret = devm_request_irq(&pdev->dev, hisi_ptt->trace_irq, hisi_ptt_isr,
+				IRQF_NOBALANCING | IRQF_NO_THREAD, DRV_NAME,
+				hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "failed to request irq %d, ret = %d\n",
 			hisi_ptt->trace_irq, ret);
@@ -1000,6 +1000,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
 	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
 		return -ENOENT;
 
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index a044ca0c35a1..4362db7c5789 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -178,6 +178,7 @@ struct rk3x_i2c_soc_data {
  * @clk: function clk for rk3399 or function & Bus clks for others
  * @pclk: Bus clk for rk3399
  * @clk_rate_nb: i2c clk rate change notify
+ * @irq: irq number
  * @t: I2C known timing information
  * @lock: spinlock for the i2c bus
  * @wait: the waitqueue to wait for i2c transfer
@@ -200,6 +201,7 @@ struct rk3x_i2c {
 	struct clk *clk;
 	struct clk *pclk;
 	struct notifier_block clk_rate_nb;
+	int irq;
 
 	/* Settings */
 	struct i2c_timings t;
@@ -1087,13 +1089,18 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 
 		spin_unlock_irqrestore(&i2c->lock, flags);
 
-		rk3x_i2c_start(i2c);
-
 		if (!polling) {
+			rk3x_i2c_start(i2c);
+
 			timeout = wait_event_timeout(i2c->wait, !i2c->busy,
 						     msecs_to_jiffies(WAIT_TIMEOUT));
 		} else {
+			disable_irq(i2c->irq);
+			rk3x_i2c_start(i2c);
+
 			timeout = rk3x_i2c_wait_xfer_poll(i2c);
+
+			enable_irq(i2c->irq);
 		}
 
 		spin_lock_irqsave(&i2c->lock, flags);
@@ -1310,6 +1317,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	i2c->irq = irq;
+
 	platform_set_drvdata(pdev, i2c);
 
 	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f5c21565bb3c..e2c1848182de 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -286,6 +286,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c92e544c792d..786f00f6b7fd 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -765,6 +765,44 @@ static void atkbd_deactivate(struct atkbd *atkbd)
 			ps2dev->serio->phys);
 }
 
+#ifdef CONFIG_X86
+static bool atkbd_is_portable_device(void)
+{
+	static const char * const chassis_types[] = {
+		"8",	/* Portable */
+		"9",	/* Laptop */
+		"10",	/* Notebook */
+		"14",	/* Sub-Notebook */
+		"31",	/* Convertible */
+		"32",	/* Detachable */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chassis_types); i++)
+		if (dmi_match(DMI_CHASSIS_TYPE, chassis_types[i]))
+			return true;
+
+	return false;
+}
+
+/*
+ * On many modern laptops ATKBD_CMD_GETID may cause problems, on these laptops
+ * the controller is always in translated mode. In this mode mice/touchpads will
+ * not work. So in this case simply assume a keyboard is connected to avoid
+ * confusing some laptop keyboards.
+ *
+ * Skipping ATKBD_CMD_GETID ends up using a fake keyboard id. Using a fake id is
+ * ok in translated mode, only atkbd_select_set() checks atkbd->id and in
+ * translated mode that is a no-op.
+ */
+static bool atkbd_skip_getid(struct atkbd *atkbd)
+{
+	return atkbd->translated && atkbd_is_portable_device();
+}
+#else
+static inline bool atkbd_skip_getid(struct atkbd *atkbd) { return false; }
+#endif
+
 /*
  * atkbd_probe() probes for an AT keyboard on a serio port.
  */
@@ -794,12 +832,12 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (atkbd_skip_getid(atkbd) || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command failed, we check if we can at least set the LEDs on
- * the keyboard. This should work on every keyboard out there. It also turns
- * the LEDs off, which we want anyway.
+ * If the get ID command was skipped or failed, we check if we can at least set
+ * the LEDs on the keyboard. This should work on every keyboard out there.
+ * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 22d16d80efb9..7a303a9d6bf7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN009b", /* T580 */
 	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
 	"LEN040f", /* P1 Gen 3 */
+	"LEN0411", /* L14 Gen 1 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 9c39553d30fa..b585b1dab870 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -360,6 +360,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
+	{
+		/* Acer TravelMate P459-G2-M */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Amoi M636/A737 */
 		.matches = {
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index 8ae0d2d284af..3e69a7bde928 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct led_classdev *led_cdev)
 
 	cancel_delayed_work_sync(&trigger_data->dwork);
 
+	kfree(trigger_data->ttyname);
+	tty_kref_put(trigger_data->tty);
+	trigger_data->tty = NULL;
+
 	kfree(trigger_data);
 }
 
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 2a8b081bce7d..3ff87cb4dc49 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -660,6 +660,7 @@ config DM_ZONED
 
 config DM_AUDIT
 	bool "DM audit events"
+	depends on BLK_DEV_DM
 	depends on AUDIT
 	help
 	  Generate audit events for device-mapper.
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 68d86dbecb4a..4bbd2a247dc7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,7 +36,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6843,18 +6842,7 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b7acd994a393..f1c8ff5b63ac 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6439,6 +6439,14 @@ static void tg3_dump_state(struct tg3 *tp)
 	int i;
 	u32 *regs;
 
+	/* If it is a PCI error, all registers will be 0xffff,
+	 * we don't dump them out, just report the error and return
+	 */
+	if (tp->pdev->error_state != pci_channel_io_normal) {
+		netdev_err(tp->dev, "PCI channel ERROR!\n");
+		return;
+	}
+
 	regs = kzalloc(TG3_REG_BLK_SIZE, GFP_ATOMIC);
 	if (!regs)
 		return;
@@ -11179,7 +11187,8 @@ static void tg3_reset_task(struct work_struct *work)
 	rtnl_lock();
 	tg3_full_lock(tp, 0);
 
-	if (tp->pcierr_recovery || !netif_running(tp->dev)) {
+	if (tp->pcierr_recovery || !netif_running(tp->dev) ||
+	    tp->pdev->error_state != pci_channel_io_normal) {
 		tg3_flag_clear(tp, RESET_TASK_PENDING);
 		tg3_full_unlock(tp);
 		rtnl_unlock();
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index e7701326adc6..9e40c28d453a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -59,11 +59,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		return -ENODEV;
 	}
 
-	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
-		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
-		return -ENODEV;
-	}
-
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index a9415d333490..63091c45a576 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1385,7 +1385,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		 * if it is true then one of the handlers took the page.
 		 */
 
-		if (reclaim) {
+		if (reclaim && txq) {
 			u16 sequence = le16_to_cpu(pkt->hdr.sequence);
 			int index = SEQ_TO_INDEX(sequence);
 			int cmd_index = iwl_txq_get_cmd_index(txq, index);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b32e3cff37b1..d4564a2517eb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -131,7 +131,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE && ctrl->tagset)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
@@ -143,7 +143,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
  */
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->state != NVME_CTRL_RESETTING)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_RESETTING)
 		return -EBUSY;
 	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
 		return -EBUSY;
@@ -156,7 +156,7 @@ static void nvme_failfast_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, failfast_work);
 
-	if (ctrl->state != NVME_CTRL_CONNECTING)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_CONNECTING)
 		return;
 
 	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
@@ -200,7 +200,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
 			ret = -ENETRESET;
 	}
 
@@ -499,7 +499,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 
-	old_state = ctrl->state;
+	old_state = nvme_ctrl_state(ctrl);
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
@@ -567,7 +567,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	if (changed) {
-		ctrl->state = new_state;
+		WRITE_ONCE(ctrl->state, new_state);
 		wake_up_all(&ctrl->state_wq);
 	}
 
@@ -575,11 +575,11 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	if (!changed)
 		return false;
 
-	if (ctrl->state == NVME_CTRL_LIVE) {
+	if (new_state == NVME_CTRL_LIVE) {
 		if (old_state == NVME_CTRL_CONNECTING)
 			nvme_stop_failfast_work(ctrl);
 		nvme_kick_requeue_lists(ctrl);
-	} else if (ctrl->state == NVME_CTRL_CONNECTING &&
+	} else if (new_state == NVME_CTRL_CONNECTING &&
 		old_state == NVME_CTRL_RESETTING) {
 		nvme_start_failfast_work(ctrl);
 	}
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
  */
 static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 {
-	switch (ctrl->state) {
+	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 	case NVME_CTRL_RESETTING:
@@ -617,7 +617,7 @@ bool nvme_wait_reset(struct nvme_ctrl *ctrl)
 	wait_event(ctrl->state_wq,
 		   nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) ||
 		   nvme_state_terminal(ctrl));
-	return ctrl->state == NVME_CTRL_RESETTING;
+	return nvme_ctrl_state(ctrl) == NVME_CTRL_RESETTING;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_reset);
 
@@ -704,9 +704,11 @@ EXPORT_SYMBOL_GPL(nvme_init_request);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
-	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
-	    ctrl->state != NVME_CTRL_DELETING &&
-	    ctrl->state != NVME_CTRL_DEAD &&
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+	if (state != NVME_CTRL_DELETING_NOIO &&
+	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
@@ -736,7 +738,7 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		 * command, which is require to set the queue live in the
 		 * appropinquate states.
 		 */
-		switch (ctrl->state) {
+		switch (nvme_ctrl_state(ctrl)) {
 		case NVME_CTRL_CONNECTING:
 			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
 			    (req->cmd->fabrics.fctype == nvme_fabrics_type_connect ||
@@ -1479,7 +1481,8 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	info->anagrpid = id->anagrpid;
@@ -1497,8 +1500,10 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
+
+error:
 	kfree(id);
-	return 0;
+	return ret;
 }
 
 static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
@@ -1890,9 +1895,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
@@ -2538,7 +2544,7 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 
 	if (ctrl->ps_max_latency_us != latency) {
 		ctrl->ps_max_latency_us = latency;
-		if (ctrl->state == NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
 			nvme_configure_apst(ctrl);
 	}
 }
@@ -3224,7 +3230,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	switch (ctrl->state) {
+	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_LIVE:
 		break;
 	default:
@@ -3646,6 +3652,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
+	/*
+	 * Ensure that no namespaces are added to the ctrl list after the queues
+	 * are frozen, thereby avoiding a deadlock between scan and reset.
+	 */
+	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
+		up_write(&ctrl->namespaces_rwsem);
+		goto out_unlink_ns;
+	}
 	nvme_ns_add_to_ctrl_list(ns);
 	up_write(&ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
@@ -3910,7 +3924,7 @@ static void nvme_scan_work(struct work_struct *work)
 	int ret;
 
 	/* No tagset on a live ctrl means IO queues could not created */
-	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
 
 	/*
@@ -3980,7 +3994,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD)
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
 
 	/* this is a no-op when called from the controller reset handler */
@@ -4062,7 +4076,7 @@ static void nvme_async_event_work(struct work_struct *work)
 	 * flushing ctrl async_event_work after changing the controller state
 	 * from LIVE and before freeing the admin queue.
 	*/
-	if (ctrl->state == NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
 		ctrl->ops->submit_async_event(ctrl);
 }
 
@@ -4447,7 +4461,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 {
 	int ret;
 
-	ctrl->state = NVME_CTRL_NEW;
+	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
@@ -4556,6 +4570,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
+	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
@@ -4589,6 +4604,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
+	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 206f1b4e5eb1..46cce0ec35e9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -557,7 +557,7 @@ nvme_fc_rport_get(struct nvme_fc_rport *rport)
 static void
 nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 {
-	switch (ctrl->ctrl.state) {
+	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 		/*
@@ -793,7 +793,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);
 
-	switch (ctrl->ctrl.state) {
+	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 		/*
@@ -3305,7 +3305,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
 	bool recon = true;
 
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
+	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
 		return;
 
 	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 529b9954d2b8..4939ed35638f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -18,15 +18,12 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 {
 	u32 effects;
 
-	if (capable(CAP_SYS_ADMIN))
-		return true;
-
 	/*
 	 * Do not allow unprivileged passthrough on partitions, as that allows an
 	 * escape from the containment of the partition.
 	 */
 	if (flags & NVME_IOCTL_PARTITION)
-		return false;
+		goto admin;
 
 	/*
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
@@ -34,7 +31,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	if (c->common.opcode >= nvme_cmd_vendor_start ||
 	    c->common.opcode == nvme_fabrics_command)
-		return false;
+		goto admin;
 
 	/*
 	 * Do not allow unprivileged passthrough of admin commands except
@@ -53,7 +50,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 				return true;
 			}
 		}
-		return false;
+		goto admin;
 	}
 
 	/*
@@ -63,7 +60,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
-		return false;
+		goto admin;
 
 	/*
 	 * Don't allow passthrough for command that have intrusive (or unknown)
@@ -72,16 +69,20 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
 			NVME_CMD_EFFECTS_UUID_SEL |
 			NVME_CMD_EFFECTS_SCOPE_MASK))
-		return false;
+		goto admin;
 
 	/*
 	 * Only allow I/O commands that transfer data to the controller or that
 	 * change the logical block contents if the file descriptor is open for
 	 * writing.
 	 */
-	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
-		return open_for_write;
+	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
+	    !open_for_write)
+		goto admin;
+
 	return true;
+admin:
+	return capable(CAP_SYS_ADMIN);
 }
 
 /*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 74f74b459f5f..ba62d42d2a8b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -256,6 +256,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STOPPED		= 3,
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
+	NVME_CTRL_FROZEN		= 6,
 };
 
 struct nvme_ctrl {
@@ -391,6 +392,11 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5c2a3af26d4d..f8e92404a659 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1234,7 +1234,7 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
 
 	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
-	switch (dev->ctrl.state) {
+	switch (nvme_ctrl_state(&dev->ctrl)) {
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
@@ -1322,7 +1322,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * cancellation error. All outstanding requests are completed on
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
-	switch (dev->ctrl.state) {
+	switch (nvme_ctrl_state(&dev->ctrl)) {
 	case NVME_CTRL_CONNECTING:
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 		fallthrough;
@@ -1594,7 +1594,7 @@ static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
 	/*
 	 * Controller is in wrong state, fail early.
 	 */
-	if (dev->ctrl.state != NVME_CTRL_CONNECTING) {
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_CONNECTING) {
 		mutex_unlock(&dev->shutdown_lock);
 		return -ENODEV;
 	}
@@ -2574,13 +2574,13 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(&dev->ctrl);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	bool dead;
 
 	mutex_lock(&dev->shutdown_lock);
 	dead = nvme_pci_ctrl_is_dead(dev);
-	if (dev->ctrl.state == NVME_CTRL_LIVE ||
-	    dev->ctrl.state == NVME_CTRL_RESETTING) {
+	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
 		if (pci_is_enabled(pdev))
 			nvme_start_freeze(&dev->ctrl);
 		/*
@@ -2691,7 +2691,7 @@ static void nvme_reset_work(struct work_struct *work)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
 
-	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
 		result = -ENODEV;
@@ -3207,7 +3207,7 @@ static int nvme_suspend(struct device *dev)
 	nvme_wait_freeze(ctrl);
 	nvme_sync_queues(ctrl);
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
 		goto unfreeze;
 
 	/*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a7fea4cbacd7..c04317a966b3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -984,10 +984,11 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 
 static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
+	if (state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(state == NVME_CTRL_NEW || state == NVME_CTRL_LIVE);
 		return;
 	}
 
@@ -1059,8 +1060,10 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -1128,8 +1131,10 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -1161,7 +1166,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_LIVE)
 		dev_info(ctrl->ctrl.device,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
@@ -1944,7 +1949,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
 		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5b332d9f87fc..f1d62d74426f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1993,10 +1993,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
-			ctrl->state == NVME_CTRL_LIVE);
+	if (state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(state == NVME_CTRL_NEW || state == NVME_CTRL_LIVE);
 		return;
 	}
 
@@ -2056,8 +2057,10 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -2124,8 +2127,10 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -2155,8 +2160,10 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -2274,7 +2281,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
 		opc, nvme_opcode_str(qid, opc, fctype));
 
-	if (ctrl->state != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..01b2a3d1a5e6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -17,6 +17,7 @@
 #endif
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
+#include <linux/nospec.h>
 
 #include "nvmet.h"
 
@@ -509,6 +510,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 
 	down_write(&nvmet_ana_sem);
 	oldgrpid = ns->anagrpid;
+	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
 	nvmet_ana_group_enabled[newgrpid]++;
 	ns->anagrpid = newgrpid;
 	nvmet_ana_group_enabled[oldgrpid]--;
@@ -1700,6 +1702,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	grp->grpid = grpid;
 
 	down_write(&nvmet_ana_sem);
+	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
 	nvmet_ana_group_enabled[grpid]++;
 	up_write(&nvmet_ana_sem);
 
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 9f5d784cd95d..3644997a8342 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
 	sunix_5069a,
 	sunix_5079a,
 	sunix_5099a,
+	brainboxes_uc257,
+	brainboxes_is300,
+	brainboxes_uc414,
+	brainboxes_px263,
 };
 
 /* each element directly indexed from enum list, above */
@@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
 	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
+	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
+	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -277,6 +285,38 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
 	  0x0104, 0, 0, sunix_5099a },
 
+	/* Brainboxes UC-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0862,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0863,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-414 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0e61,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc414 },
+
+	/* Brainboxes UC-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0981,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0982,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes IS-300/IS-500 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0da0,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_is300 },
+
+	/* Brainboxes PX-263/PX-295 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px263 },
+
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -542,6 +582,30 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[brainboxes_uc257] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_is300] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_uc414] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_px263] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 };
 
 struct parport_serial_private {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ae95d0950772..e0081914052f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4699,17 +4699,21 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
 		return -ENOTTY;
 
+	/*
+	 * Future Zhaoxin Root Ports and Switch Downstream Ports will
+	 * implement ACS capability in accordance with the PCIe Spec.
+	 */
 	switch (dev->device) {
 	case 0x0710 ... 0x071e:
 	case 0x0721:
-	case 0x0723 ... 0x0732:
+	case 0x0723 ... 0x0752:
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
index d6318cb57aff..e7e827a8877a 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -12,7 +12,8 @@ config PINCTRL_CS42L43
 
 config PINCTRL_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar pinctrl driver"
-	depends on MFD_LOCHNAGAR
+	# Avoid clash caused by MIPS defining RST, which is used in the driver
+	depends on MFD_LOCHNAGAR && !MIPS
 	select GPIOLIB
 	select PINMUX
 	select PINCONF
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 7daff9f186cd..f0cad2c501f7 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -843,8 +843,8 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	if (mem_regions == 0) {
-		dev_err(&pdev->dev, "mem_regions is 0\n");
+	if (mem_regions == 0 || mem_regions >= 10000) {
+		dev_err(&pdev->dev, "mem_regions is invalid: %u\n", mem_regions);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 74241b2ff21e..86034c457c04 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -923,6 +923,15 @@ static int amd_gpio_suspend(struct device *dev)
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 		gpio_dev->saved_regs[i] = readl(gpio_dev->base + pin * 4) & ~PIN_IRQ_PENDING;
+
+		/* mask any interrupts not intended to be a wake source */
+		if (!(gpio_dev->saved_regs[i] & WAKE_SOURCE)) {
+			writel(gpio_dev->saved_regs[i] & ~BIT(INTERRUPT_MASK_OFF),
+			       gpio_dev->base + pin * 4);
+			pm_pr_dbg("Disabling GPIO #%d interrupt for suspend.\n",
+				  pin);
+		}
+
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
 
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 34c5c3e71fb2..cf59089f2776 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -80,6 +80,11 @@
 #define FUNCTION_MASK		GENMASK(1, 0)
 #define FUNCTION_INVALID	GENMASK(7, 0)
 
+#define WAKE_SOURCE	(BIT(WAKE_CNTRL_OFF_S0I3) | \
+			 BIT(WAKE_CNTRL_OFF_S3)   | \
+			 BIT(WAKE_CNTRL_OFF_S4)   | \
+			 BIT(WAKECNTRL_Z_OFF))
+
 struct amd_function {
 	const char *name;
 	const char * const groups[NSELECTS];
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 58ca6fac7849..f2b9db66fdb6 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -307,6 +307,9 @@ static const char * const cy8c95x0_groups[] = {
 	"gp77",
 };
 
+static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
+				     unsigned int pin, bool input);
+
 static inline u8 cypress_get_port(struct cy8c95x0_pinctrl *chip, unsigned int pin)
 {
 	/* Account for GPORT2 which only has 4 bits */
@@ -711,6 +714,8 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 	ret = regmap_read(chip->regmap, reg, &reg_val);
 	if (reg_val & bit)
 		arg = 1;
+	if (param == PIN_CONFIG_OUTPUT_ENABLE)
+		arg = !arg;
 
 	*config = pinconf_to_config_packed(param, (u16)arg);
 out:
@@ -726,6 +731,7 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
 	unsigned long param = pinconf_to_config_param(config);
+	unsigned long arg = pinconf_to_config_argument(config);
 	unsigned int reg;
 	int ret;
 
@@ -764,6 +770,12 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	case PIN_CONFIG_MODE_PWM:
 		reg = CY8C95X0_PWMSEL;
 		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		ret = cy8c95x0_pinmux_direction(chip, off, !arg);
+		goto out;
+	case PIN_CONFIG_INPUT_ENABLE:
+		ret = cy8c95x0_pinmux_direction(chip, off, arg);
+		goto out;
 	default:
 		ret = -ENOTSUPP;
 		goto out;
@@ -821,7 +833,7 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 	gc->get_direction = cy8c95x0_gpio_get_direction;
 	gc->get_multiple = cy8c95x0_gpio_get_multiple;
 	gc->set_multiple = cy8c95x0_gpio_set_multiple;
-	gc->set_config = gpiochip_generic_config,
+	gc->set_config = gpiochip_generic_config;
 	gc->can_sleep = true;
 	gc->add_pin_ranges = cy8c95x0_add_pin_ranges;
 
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 6bbffb081053..b456370166b6 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -16,12 +16,17 @@
 
 struct quirk_entry {
 	u32 s2idle_bug_mmio;
+	bool spurious_8042;
 };
 
 static struct quirk_entry quirk_s2idle_bug = {
 	.s2idle_bug_mmio = 0xfed80380,
 };
 
+static struct quirk_entry quirk_spurious_8042 = {
+	.spurious_8042 = true,
+};
+
 static const struct dmi_system_id fwbug_list[] = {
 	{
 		.ident = "L14 Gen2 AMD",
@@ -193,6 +198,16 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15s-eq2xxx"),
 		}
 	},
+	/* https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid-wakeup-behavior-feedback/39128 */
+	{
+		.ident = "Framework Laptop 13 (Phoenix)",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop 13 (AMD Ryzen 7040Series)"),
+			DMI_MATCH(DMI_BIOS_VERSION, "03.03"),
+		}
+	},
 	{}
 };
 
@@ -235,6 +250,9 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 {
 	const struct dmi_system_id *dmi_id;
 
+	if (dev->cpu_id == AMD_CPU_ID_CZN)
+		dev->disable_8042_wakeup = true;
+
 	dmi_id = dmi_first_match(fwbug_list);
 	if (!dmi_id)
 		return;
@@ -242,4 +260,6 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 	if (dev->quirks->s2idle_bug_mmio)
 		pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
 			dmi_id->ident);
+	if (dev->quirks->spurious_8042)
+		dev->disable_8042_wakeup = true;
 }
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 212f164bc3db..96caf2221d87 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -87,16 +87,6 @@
 #define SMU_MSG_LOG_RESET		0x07
 #define SMU_MSG_LOG_DUMP_DATA		0x08
 #define SMU_MSG_GET_SUP_CONSTRAINTS	0x09
-/* List of supported CPU ids */
-#define AMD_CPU_ID_RV			0x15D0
-#define AMD_CPU_ID_RN			0x1630
-#define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
-#define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
-#define AMD_CPU_ID_YC			0x14B5
-#define AMD_CPU_ID_CB			0x14D8
-#define AMD_CPU_ID_PS			0x14E8
-#define AMD_CPU_ID_SP			0x14A4
-#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT 0x1507
 
 #define PMC_MSG_DELAY_MIN_US		50
 #define RESPONSE_REGISTER_LOOP_MAX	20000
@@ -714,19 +704,22 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	return -EINVAL;
 }
 
-static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
+static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
 {
 	struct device *d;
 	int rc;
 
-	if (!pdev->major) {
-		rc = amd_pmc_get_smu_version(pdev);
-		if (rc)
-			return rc;
-	}
+	/* cezanne platform firmware has a fix in 64.66.0 */
+	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
+		if (!pdev->major) {
+			rc = amd_pmc_get_smu_version(pdev);
+			if (rc)
+				return rc;
+		}
 
-	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
-		return 0;
+		if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
+			return 0;
+	}
 
 	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
 	if (!d)
@@ -885,8 +878,8 @@ static int amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
 
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
-		int rc = amd_pmc_czn_wa_irq1(pdev);
+	if (pdev->disable_8042_wakeup && !disable_workarounds) {
+		int rc = amd_pmc_wa_irq1(pdev);
 
 		if (rc) {
 			dev_err(pdev->dev, "failed to adjust keyboard wakeup: %d\n", rc);
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index c27bd6a5642f..b4794f118739 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -36,9 +36,21 @@ struct amd_pmc_dev {
 	struct mutex lock; /* generic mutex lock */
 	struct dentry *dbgfs_dir;
 	struct quirk_entry *quirks;
+	bool disable_8042_wakeup;
 };
 
 void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
 void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
 
+/* List of supported CPU ids */
+#define AMD_CPU_ID_RV			0x15D0
+#define AMD_CPU_ID_RN			0x1630
+#define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
+#define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
+#define AMD_CPU_ID_YC			0x14B5
+#define AMD_CPU_ID_CB			0x14D8
+#define AMD_CPU_ID_PS			0x14E8
+#define AMD_CPU_ID_SP			0x14A4
+#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT 0x1507
+
 #endif /* PMC_H */
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 6fa1735ad7a4..210b0a81b7ec 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -73,10 +73,10 @@ struct intel_vbtn_priv {
 	bool wakeup_mode;
 };
 
-static void detect_tablet_mode(struct platform_device *device)
+static void detect_tablet_mode(struct device *dev)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	unsigned long long vgbs;
 	acpi_status status;
 	int m;
@@ -89,6 +89,8 @@ static void detect_tablet_mode(struct platform_device *device)
 	input_report_switch(priv->switches_dev, SW_TABLET_MODE, m);
 	m = (vgbs & VGBS_DOCK_MODE_FLAG) ? 1 : 0;
 	input_report_switch(priv->switches_dev, SW_DOCK, m);
+
+	input_sync(priv->switches_dev);
 }
 
 /*
@@ -134,7 +136,7 @@ static int intel_vbtn_input_setup(struct platform_device *device)
 	priv->switches_dev->id.bustype = BUS_HOST;
 
 	if (priv->has_switches) {
-		detect_tablet_mode(device);
+		detect_tablet_mode(&device->dev);
 
 		ret = input_register_device(priv->switches_dev);
 		if (ret)
@@ -198,6 +200,9 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	autorelease = val && (!ke_rel || ke_rel->type == KE_IGNORE);
 
 	sparse_keymap_report_event(input_dev, event, val, autorelease);
+
+	/* Some devices need this to report further events */
+	acpi_evaluate_object(handle, "VBDL", NULL, NULL);
 }
 
 /*
@@ -352,7 +357,13 @@ static void intel_vbtn_pm_complete(struct device *dev)
 
 static int intel_vbtn_pm_resume(struct device *dev)
 {
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+
 	intel_vbtn_pm_complete(dev);
+
+	if (priv->has_switches)
+		detect_tablet_mode(dev);
+
 	return 0;
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a46fc417cb20..d73cbae4aa21 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7948,8 +7948,19 @@ static struct ibm_struct volume_driver_data = {
  * 	TPACPI_FAN_WR_TPEC is also available and should be used to
  * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
  * 	but the ACPI tables just mention level 7.
+ *
+ * TPACPI_FAN_RD_TPEC_NS:
+ *	This mode is used for a few ThinkPads (L13 Yoga Gen2, X13 Yoga Gen2 etc.)
+ *	that are using non-standard EC locations for reporting fan speeds.
+ *	Currently these platforms only provide fan rpm reporting.
+ *
  */
 
+#define FAN_RPM_CAL_CONST 491520	/* FAN RPM calculation offset for some non-standard ECFW */
+
+#define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is enabled or not */
+#define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host or EC */
+
 enum {					/* Fan control constants */
 	fan_status_offset = 0x2f,	/* EC register 0x2f */
 	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
@@ -7957,6 +7968,11 @@ enum {					/* Fan control constants */
 	fan_select_offset = 0x31,	/* EC register 0x31 (Firmware 7M)
 					   bit 0 selects which fan is active */
 
+	fan_status_offset_ns = 0x93,	/* Special status/control offset for non-standard EC Fan1 */
+	fan2_status_offset_ns = 0x96,	/* Special status/control offset for non-standard EC Fan2 */
+	fan_rpm_status_ns = 0x95,	/* Special offset for Fan1 RPM status for non-standard EC */
+	fan2_rpm_status_ns = 0x98,	/* Special offset for Fan2 RPM status for non-standard EC */
+
 	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
 	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
 
@@ -7967,6 +7983,7 @@ enum fan_status_access_mode {
 	TPACPI_FAN_NONE = 0,		/* No fan status or control */
 	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
 	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
 };
 
 enum fan_control_access_mode {
@@ -7994,6 +8011,8 @@ static u8 fan_control_desired_level;
 static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
+static bool fan_with_ns_addr;
+
 static struct mutex fan_mutex;
 
 static void fan_watchdog_fire(struct work_struct *ignored);
@@ -8123,6 +8142,15 @@ static int fan_get_status(u8 *status)
 		}
 
 		break;
+	case TPACPI_FAN_RD_TPEC_NS:
+		/* Default mode is AUTO which means controlled by EC */
+		if (!acpi_ec_read(fan_status_offset_ns, &s))
+			return -EIO;
+
+		if (status)
+			*status = s;
+
+		break;
 
 	default:
 		return -ENXIO;
@@ -8139,7 +8167,8 @@ static int fan_get_status_safe(u8 *status)
 	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 	rc = fan_get_status(&s);
-	if (!rc)
+	/* NS EC doesn't have register with level settings */
+	if (!rc && !fan_with_ns_addr)
 		fan_update_desired_level(s);
 	mutex_unlock(&fan_mutex);
 
@@ -8166,7 +8195,13 @@ static int fan_get_speed(unsigned int *speed)
 
 		if (likely(speed))
 			*speed = (hi << 8) | lo;
+		break;
+	case TPACPI_FAN_RD_TPEC_NS:
+		if (!acpi_ec_read(fan_rpm_status_ns, &lo))
+			return -EIO;
 
+		if (speed)
+			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
 
 	default:
@@ -8178,7 +8213,7 @@ static int fan_get_speed(unsigned int *speed)
 
 static int fan2_get_speed(unsigned int *speed)
 {
-	u8 hi, lo;
+	u8 hi, lo, status;
 	bool rc;
 
 	switch (fan_status_access_mode) {
@@ -8194,7 +8229,21 @@ static int fan2_get_speed(unsigned int *speed)
 
 		if (likely(speed))
 			*speed = (hi << 8) | lo;
+		break;
 
+	case TPACPI_FAN_RD_TPEC_NS:
+		rc = !acpi_ec_read(fan2_status_offset_ns, &status);
+		if (rc)
+			return -EIO;
+		if (!(status & FAN_NS_CTRL_STATUS)) {
+			pr_info("secondary fan control not supported\n");
+			return -EIO;
+		}
+		rc = !acpi_ec_read(fan2_rpm_status_ns, &lo);
+		if (rc)
+			return -EIO;
+		if (speed)
+			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
 
 	default:
@@ -8697,6 +8746,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_2FAN		0x0002		/* EC 0x31 bit 0 selects fan2 */
 #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
+#define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8715,6 +8765,8 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
 	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
 	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
+	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
+	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 };
 
@@ -8749,18 +8801,27 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		return -ENODEV;
 	}
 
+	if (quirks & TPACPI_FAN_NS) {
+		pr_info("ECFW with non-standard fan reg control found\n");
+		fan_with_ns_addr = 1;
+		/* Fan ctrl support from host is undefined for now */
+		tp_features.fan_ctrl_status_undef = 1;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
-		if (likely(acpi_ec_read(fan_status_offset,
-					&fan_control_initial_status))) {
+		if (fan_with_ns_addr ||
+		    likely(acpi_ec_read(fan_status_offset, &fan_control_initial_status))) {
 			int res;
 			unsigned int speed;
 
-			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
+			fan_status_access_mode = fan_with_ns_addr ?
+				TPACPI_FAN_RD_TPEC_NS : TPACPI_FAN_RD_TPEC;
+
 			if (quirks & TPACPI_FAN_Q1)
 				fan_quirk1_setup();
 			/* Try and probe the 2nd fan */
@@ -8769,7 +8830,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 			if (res >= 0 && speed != FAN_NOT_PRESENT) {
 				/* It responded - so let's assume it's there */
 				tp_features.second_fan = 1;
-				tp_features.second_fan_ctl = 1;
+				/* fan control not currently available for ns ECFW */
+				tp_features.second_fan_ctl = !fan_with_ns_addr;
 				pr_info("secondary fan control detected & enabled\n");
 			} else {
 				/* Fan not auto-detected */
@@ -8944,6 +9006,7 @@ static int fan_read(struct seq_file *m)
 			       str_enabled_disabled(status), status);
 		break;
 
+	case TPACPI_FAN_RD_TPEC_NS:
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		rc = fan_get_status_safe(&status);
@@ -8958,13 +9021,22 @@ static int fan_read(struct seq_file *m)
 
 		seq_printf(m, "speed:\t\t%d\n", speed);
 
-		if (status & TP_EC_FAN_FULLSPEED)
-			/* Disengaged mode takes precedence */
-			seq_printf(m, "level:\t\tdisengaged\n");
-		else if (status & TP_EC_FAN_AUTO)
-			seq_printf(m, "level:\t\tauto\n");
-		else
-			seq_printf(m, "level:\t\t%d\n", status);
+		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
+			/*
+			 * No full speed bit in NS EC
+			 * EC Auto mode is set by default.
+			 * No other levels settings available
+			 */
+			seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown" : "auto");
+		} else {
+			if (status & TP_EC_FAN_FULLSPEED)
+				/* Disengaged mode takes precedence */
+				seq_printf(m, "level:\t\tdisengaged\n");
+			else if (status & TP_EC_FAN_AUTO)
+				seq_printf(m, "level:\t\tauto\n");
+			else
+				seq_printf(m, "level:\t\t%d\n", status);
+		}
 		break;
 
 	case TPACPI_FAN_NONE:
diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 8d1fce18ded7..5c3267acd2b1 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -163,7 +163,7 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	type = (enum hi6220_reset_ctrl_type)of_device_get_match_data(dev);
+	type = (uintptr_t)of_device_get_match_data(dev);
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 3a9cc8a4a230..ade95e91b3c8 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -17,6 +17,7 @@
 #include <linux/blk-mq.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/io.h>
 #include <asm/eadm.h>
 #include "scm_blk.h"
 
@@ -130,7 +131,7 @@ static void scm_request_done(struct scm_request *scmrq)
 
 	for (i = 0; i < nr_requests_per_io && scmrq->request[i]; i++) {
 		msb = &scmrq->aob->msb[i];
-		aidaw = msb->data_addr;
+		aidaw = (u64)phys_to_virt(msb->data_addr);
 
 		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
 		    IS_ALIGNED(aidaw, PAGE_SIZE))
@@ -195,12 +196,12 @@ static int scm_request_prepare(struct scm_request *scmrq)
 	msb->scm_addr = scmdev->address + ((u64) blk_rq_pos(req) << 9);
 	msb->oc = (rq_data_dir(req) == READ) ? MSB_OC_READ : MSB_OC_WRITE;
 	msb->flags |= MSB_FLAG_IDA;
-	msb->data_addr = (u64) aidaw;
+	msb->data_addr = (u64)virt_to_phys(aidaw);
 
 	rq_for_each_segment(bv, req, iter) {
 		WARN_ON(bv.bv_offset);
 		msb->blk_count += bv.bv_len >> 12;
-		aidaw->data_addr = (u64) page_address(bv.bv_page);
+		aidaw->data_addr = virt_to_phys(page_address(bv.bv_page));
 		aidaw++;
 	}
 
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index a9d25ae0b73f..e320c9128913 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -23,8 +23,9 @@
 static void intel_shim_vs_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
-	u16 act = 0;
+	u16 act;
 
+	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
 	u16p_replace_bits(&act, 0x1, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
 	act |= SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE;
 	act |=  SDW_SHIM2_INTEL_VS_ACTMCTL_DODS;
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 62082d64ece0..2d572f6c8ec8 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -466,13 +466,13 @@ static int uio_open(struct inode *inode, struct file *filep)
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
-	mutex_unlock(&minor_lock);
 	if (!idev) {
 		ret = -ENODEV;
+		mutex_unlock(&minor_lock);
 		goto out;
 	}
-
 	get_device(&idev->dev);
+	mutex_unlock(&minor_lock);
 
 	if (!try_module_get(idev->owner)) {
 		ret = -ENODEV;
@@ -1064,9 +1064,8 @@ void uio_unregister_device(struct uio_info *info)
 	wake_up_interruptible(&idev->wait);
 	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
 
-	device_unregister(&idev->dev);
-
 	uio_free_minor(minor);
+	device_unregister(&idev->dev);
 
 	return;
 }
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index 9b04aad6ec35..c328e694f6e7 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -261,7 +261,7 @@ void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
 	debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
 
 	for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
-		char name[8];
+		char name[16];
 
 		snprintf(name, sizeof(name), "vq%02d", i);
 		debugfs_create_file(name, 0400, vdpa_aux->dentry,
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 52b2449182ad..25c0fe5ec3d5 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -318,9 +318,8 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 		return -EOPNOTSUPP;
 	}
 
-	pdsv->negotiated_features = nego_features;
-
 	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
+	pdsv->negotiated_features = nego_features;
 	dev_dbg(dev, "%s: %#llx => %#llx\n",
 		__func__, driver_features, nego_features);
 
@@ -461,8 +460,10 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	pds_vdpa_cmd_set_status(pdsv, status);
 
-	/* Note: still working with FW on the need for this reset cmd */
 	if (status == 0) {
+		struct vdpa_callback null_cb = { };
+
+		pds_vdpa_set_config_cb(vdpa_dev, &null_cb);
 		pds_vdpa_cmd_reset(pdsv);
 
 		for (i = 0; i < pdsv->num_vqs; i++) {
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c45e8c2d62e1..e40229c47fe5 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -84,6 +84,14 @@ int debugfs_file_get(struct dentry *dentry)
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
 
+	/*
+	 * This could only happen if some debugfs user erroneously calls
+	 * debugfs_file_get() on a dentry that isn't even a file, let
+	 * them know about it.
+	 */
+	if (WARN_ON(!d_is_reg(dentry)))
+		return -EINVAL;
+
 	d_fsd = READ_ONCE(dentry->d_fsdata);
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 83e57e9f9fa0..dcde4199a625 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -236,17 +236,19 @@ static const struct super_operations debugfs_super_operations = {
 
 static void debugfs_release_dentry(struct dentry *dentry)
 {
-	void *fsd = dentry->d_fsdata;
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		kfree(dentry->d_fsdata);
+	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+		return;
+
+	kfree(fsd);
 }
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	debugfs_automount_t f;
-	f = (debugfs_automount_t)path->dentry->d_fsdata;
-	return f(path->dentry, d_inode(path->dentry)->i_private);
+	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+
+	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -634,13 +636,23 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
+	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
+	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
+	if (!fsd) {
+		failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fsd->automount = f;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
+		kfree(fsd);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -648,13 +660,14 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
+		kfree(fsd);
 		return failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = (void *)f;
+	dentry->d_fsdata = fsd;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 92af8ae31313..f7c489b5a368 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -17,8 +17,14 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
-	refcount_t active_users;
-	struct completion active_users_drained;
+	union {
+		/* automount_fn is used when real_fops is NULL */
+		debugfs_automount_t automount;
+		struct {
+			refcount_t active_users;
+			struct completion active_users_drained;
+		};
+	};
 };
 
 /*
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 465d145360de..e197657db36b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -754,6 +754,12 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		memcpy(pval, value, size);
 		last->e_value_size = cpu_to_le16(size);
 		new_hsize += newsize;
+		/*
+		 * Explicitly add the null terminator.  The unused xattr space
+		 * is supposed to always be zeroed, which would make this
+		 * unnecessary, but don't depend on that.
+		 */
+		*(u32 *)((u8 *)last + newsize) = 0;
 	}
 
 	error = write_all_xattrs(inode, new_hsize, base_addr, ipage);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 8d6f934c3d95..5e122586e06e 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -119,7 +119,7 @@ static int journal_submit_commit_record(journal_t *journal,
 	struct commit_header *tmp;
 	struct buffer_head *bh;
 	struct timespec64 now;
-	blk_opf_t write_flags = REQ_OP_WRITE | REQ_SYNC;
+	blk_opf_t write_flags = REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS;
 
 	*cbh = NULL;
 
@@ -270,6 +270,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 			if (!ret)
 				ret = err;
 		}
+		cond_resched();
 		spin_lock(&journal->j_list_lock);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
 		smp_mb();
@@ -395,8 +396,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC);
+						journal->j_tail, 0);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
 		jbd2_debug(3, "superblock not updated\n");
@@ -715,6 +715,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 			for (i = 0; i < bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
+
 				/*
 				 * Compute checksum.
 				 */
@@ -727,7 +728,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+				submit_bh(REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS,
+					  bh);
 			}
 			cond_resched();
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 30dec2bd2ecc..19c69229ac6e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1100,8 +1100,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 	 * space and if we lose sb update during power failure we'd replay
 	 * old transaction with possibly newly overwritten data.
 	 */
-	ret = jbd2_journal_update_sb_log_tail(journal, tid, block,
-					      REQ_SYNC | REQ_FUA);
+	ret = jbd2_journal_update_sb_log_tail(journal, tid, block, REQ_FUA);
 	if (ret)
 		goto out;
 
@@ -1768,8 +1767,7 @@ static int journal_reset(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC | REQ_FUA);
+						journal->j_tail, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 	return jbd2_journal_start_thread(journal);
@@ -1791,9 +1789,16 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		return -EIO;
 	}
 
-	trace_jbd2_write_superblock(journal, write_flags);
+	/*
+	 * Always set high priority flags to exempt from block layer's
+	 * QOS policies, e.g. writeback throttle.
+	 */
+	write_flags |= JBD2_JOURNAL_REQ_FLAGS;
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
+
+	trace_jbd2_write_superblock(journal, write_flags);
+
 	if (buffer_write_io_error(bh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the journal
@@ -2043,7 +2048,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	jbd2_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
-	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
+	jbd2_write_superblock(journal, REQ_FUA);
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
@@ -2164,8 +2169,7 @@ int jbd2_journal_destroy(journal_t *journal)
 				++journal->j_transaction_sequence;
 			write_unlock(&journal->j_state_lock);
 
-			jbd2_mark_journal_empty(journal,
-					REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
+			jbd2_mark_journal_empty(journal, REQ_PREFLUSH | REQ_FUA);
 			mutex_unlock(&journal->j_checkpoint_mutex);
 		} else
 			err = -EIO;
@@ -2466,7 +2470,7 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
-	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+	jbd2_mark_journal_empty(journal, REQ_FUA);
 
 	if (flags)
 		err = __jbd2_journal_erase(journal, flags);
@@ -2512,7 +2516,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 	if (write) {
 		/* Lock to make assertions happy... */
 		mutex_lock_io(&journal->j_checkpoint_mutex);
-		jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+		jbd2_mark_journal_empty(journal, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 83ccc51a54d0..c0513fbb8a59 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -882,11 +882,13 @@ typedef struct smb_com_open_rsp {
 	__u8 OplockLevel;
 	__u16 Fid;
 	__le32 CreateAction;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le32 FileAttributes;
+	struct_group(common_attributes,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		__le32 FileAttributes;
+	);
 	__le64 AllocationSize;
 	__le64 EndOfFile;
 	__le16 FileType;
@@ -2264,11 +2266,13 @@ typedef struct {
 /* QueryFileInfo/QueryPathinfo (also for SetPath/SetFile) data buffer formats */
 /******************************************************************************/
 typedef struct { /* data block encoding of response to level 263 QPathInfo */
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le32 Attributes;
+	struct_group(common_attributes,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		__le32 Attributes;
+	);
 	__u32 Pad1;
 	__le64 AllocationSize;
 	__le64 EndOfFile;	/* size ie offset to first free byte in file */
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index bad91ba6c3a9..9ee348e6d106 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1244,8 +1244,10 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 		*oplock |= CIFS_CREATE_ACTION;
 
 	if (buf) {
-		/* copy from CreationTime to Attributes */
-		memcpy((char *)buf, (char *)&rsp->CreationTime, 36);
+		/* copy commonly used attributes */
+		memcpy(&buf->common_attributes,
+		       &rsp->common_attributes,
+		       sizeof(buf->common_attributes));
 		/* the file_info buf is endian converted by caller */
 		buf->AllocationSize = rsp->AllocationSize;
 		buf->EndOfFile = rsp->EndOfFile;
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index e20b4354e703..82b84a4941dd 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -173,6 +173,21 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 	}
 
 	mid = le64_to_cpu(shdr->MessageId);
+	if (check_smb2_hdr(shdr, mid))
+		return 1;
+
+	if (shdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
+		cifs_dbg(VFS, "Invalid structure size %u\n",
+			 le16_to_cpu(shdr->StructureSize));
+		return 1;
+	}
+
+	command = le16_to_cpu(shdr->Command);
+	if (command >= NUMBER_OF_SMB2_COMMANDS) {
+		cifs_dbg(VFS, "Invalid SMB2 command %d\n", command);
+		return 1;
+	}
+
 	if (len < pdu_size) {
 		if ((len >= hdr_size)
 		    && (shdr->Status != 0)) {
@@ -193,21 +208,6 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 		return 1;
 	}
 
-	if (check_smb2_hdr(shdr, mid))
-		return 1;
-
-	if (shdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
-		cifs_dbg(VFS, "Invalid structure size %u\n",
-			 le16_to_cpu(shdr->StructureSize));
-		return 1;
-	}
-
-	command = le16_to_cpu(shdr->Command);
-	if (command >= NUMBER_OF_SMB2_COMMANDS) {
-		cifs_dbg(VFS, "Invalid SMB2 command %d\n", command);
-		return 1;
-	}
-
 	if (smb2_rsp_struct_sizes[command] != pdu->StructureSize2) {
 		if (command != SMB2_OPLOCK_BREAK_HE && (shdr->Status == 0 ||
 		    pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 94e4af4128f1..0604696f59c1 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -403,8 +403,10 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 	cifs_server_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Mid: %llu Pid: %d\n",
 		 shdr->Command, shdr->Status, shdr->Flags, shdr->MessageId,
 		 shdr->Id.SyncId.ProcessId);
-	cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
-		 server->ops->calc_smb_size(buf));
+	if (!server->ops->check_message(buf, server->total_read, server)) {
+		cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
+				server->ops->calc_smb_size(buf));
+	}
 #endif
 }
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 76a0b9dbcf75..5276992e3647 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3401,12 +3401,10 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 	} else {
 		trace_smb3_close_done(xid, persistent_fid, tcon->tid,
 				      ses->Suid);
-		/*
-		 * Note that have to subtract 4 since struct network_open_info
-		 * has a final 4 byte pad that close response does not have
-		 */
 		if (pbuf)
-			memcpy(pbuf, (char *)&rsp->CreationTime, sizeof(*pbuf) - 4);
+			memcpy(&pbuf->network_open_info,
+			       &rsp->network_open_info,
+			       sizeof(pbuf->network_open_info));
 	}
 
 	atomic_dec(&tcon->num_remote_opens);
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 220994d0a0f7..db08194484e0 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -319,13 +319,15 @@ struct smb2_file_reparse_point_info {
 } __packed;
 
 struct smb2_file_network_open_info {
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 AllocationSize;
-	__le64 EndOfFile;
-	__le32 Attributes;
+	struct_group(network_open_info,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		__le64 AllocationSize;
+		__le64 EndOfFile;
+		__le32 Attributes;
+	);
 	__le32 Reserved;
 } __packed; /* level 34 Query also similar returned in close rsp and open rsp */
 
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index d58550c1c937..63f969a8e44d 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -700,13 +700,16 @@ struct smb2_close_rsp {
 	__le16 StructureSize; /* 60 */
 	__le16 Flags;
 	__le32 Reserved;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
-	__le64 EndOfFile;
-	__le32 Attributes;
+	struct_group(network_open_info,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		/* Beginning of FILE_STANDARD_INFO equivalent */
+		__le64 AllocationSize;
+		__le64 EndOfFile;
+		__le32 Attributes;
+	);
 } __packed;
 
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index fbd708bb4a5b..0e4d514a8c2b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2971,7 +2971,7 @@ int smb2_open(struct ksmbd_work *work)
 					    &may_flags);
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-		if (open_flags & O_CREAT) {
+		if (open_flags & (O_CREAT | O_TRUNC)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			rc = -EACCES;
@@ -5943,12 +5943,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_RENAME_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_rename_info))
 			return -EINVAL;
 
@@ -5968,12 +5962,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_DISPOSITION_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_disposition_info))
 			return -EINVAL;
 
@@ -6035,7 +6023,7 @@ int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
 	struct smb2_set_info_rsp *rsp;
-	struct ksmbd_file *fp;
+	struct ksmbd_file *fp = NULL;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
@@ -6055,6 +6043,13 @@ int smb2_set_info(struct ksmbd_work *work)
 		rsp = smb2_get_msg(work->response_buf);
 	}
 
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		pr_err("User does not have write permission\n");
+		rc = -EACCES;
+		goto err_out;
+	}
+
 	if (!has_file_id(id)) {
 		id = req->VolatileFileId;
 		pid = req->PersistentFileId;
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 1164365533f0..1c9775f1efa5 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -401,10 +401,6 @@ static void parse_dacl(struct mnt_idmap *idmap,
 	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 		return;
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
-	if (!ppace)
-		return;
-
 	ret = init_acl_state(&acl_state, num_aces);
 	if (ret)
 		return;
@@ -414,6 +410,13 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		return;
 	}
 
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace) {
+		free_acl_state(&default_acl_state);
+		free_acl_state(&acl_state);
+		return;
+	}
+
 	/*
 	 * reset rwx permissions for user/group/other.
 	 * Also, if num_aces is 0 i.e. DACL has no ACEs,
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index a7abf9f3e697..2a1d01e5b56b 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -60,12 +60,19 @@ enum dma_data_direction;
 
 struct drm_device;
 struct drm_gem_object;
+struct drm_file;
 
 /* core prime functions */
 struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
 				      struct dma_buf_export_info *exp_info);
 void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
 
+int drm_gem_prime_fd_to_handle(struct drm_device *dev,
+			       struct drm_file *file_priv, int prime_fd, uint32_t *handle);
+int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+			       struct drm_file *file_priv, uint32_t handle, uint32_t flags,
+			       int *prime_fd);
+
 /* helper functions for exporting */
 int drm_gem_map_attach(struct dma_buf *dma_buf,
 		       struct dma_buf_attachment *attach);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..92c8997b1938 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -69,6 +69,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	bool			bd_ro_warned;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..99496a0a5ddb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1007,6 +1007,8 @@ static inline void device_unlock(struct device *dev)
 	mutex_unlock(&dev->mutex);
 }
 
+DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+
 static inline void device_lock_assert(struct device *dev)
 {
 	lockdep_assert_held(&dev->mutex);
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2b0a73cb7cbb..2fa186258e35 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2790,12 +2790,14 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 static inline const struct ieee80211_he_6ghz_oper *
 ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 {
-	const u8 *ret = (const void *)&he_oper->optional;
+	const u8 *ret;
 	u32 he_oper_params;
 
 	if (!he_oper)
 		return NULL;
 
+	ret = (const void *)&he_oper->optional;
+
 	he_oper_params = le32_to_cpu(he_oper->he_oper_params);
 
 	if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 52772c826c86..0fc6c1f51262 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1374,6 +1374,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
+/* Journal high priority write IO operation flags */
+#define JBD2_JOURNAL_REQ_FLAGS		(REQ_META | REQ_SYNC | REQ_IDLE)
+
 /*
  * Journal flag definitions
  */
diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 7b23607cf4af..a5d51471feeb 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -263,7 +263,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	};
 	ktime_t timeout = KTIME_MAX;
 	struct io_uring_sync_cancel_reg sc;
-	struct fd f = { };
+	struct file *file = NULL;
 	DEFINE_WAIT(wait);
 	int ret, i;
 
@@ -285,10 +285,10 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	/* we can grab a normal file descriptor upfront */
 	if ((cd.flags & IORING_ASYNC_CANCEL_FD) &&
 	   !(cd.flags & IORING_ASYNC_CANCEL_FD_FIXED)) {
-		f = fdget(sc.fd);
-		if (!f.file)
+		file = fget(sc.fd);
+		if (!file)
 			return -EBADF;
-		cd.file = f.file;
+		cd.file = file;
 	}
 
 	ret = __io_sync_cancel(current->io_uring, &cd, sc.fd);
@@ -338,6 +338,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	if (ret == -ENOENT || ret > 0)
 		ret = 0;
 out:
-	fdput(f);
+	if (file)
+		fput(file);
 	return ret;
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index bb8880d1e084..586ac65becfd 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3607,7 +3607,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		size_t, argsz)
 {
 	struct io_ring_ctx *ctx;
-	struct fd f;
+	struct file *file;
 	long ret;
 
 	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
@@ -3625,20 +3625,19 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
-		f.file = tctx->registered_rings[fd];
-		f.flags = 0;
-		if (unlikely(!f.file))
+		file = tctx->registered_rings[fd];
+		if (unlikely(!file))
 			return -EBADF;
 	} else {
-		f = fdget(fd);
-		if (unlikely(!f.file))
+		file = fget(fd);
+		if (unlikely(!file))
 			return -EBADF;
 		ret = -EOPNOTSUPP;
-		if (unlikely(!io_is_uring_fops(f.file)))
+		if (unlikely(!io_is_uring_fops(file)))
 			goto out;
 	}
 
-	ctx = f.file->private_data;
+	ctx = file->private_data;
 	ret = -EBADFD;
 	if (unlikely(ctx->flags & IORING_SETUP_R_DISABLED))
 		goto out;
@@ -3732,7 +3731,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		}
 	}
 out:
-	fdput(f);
+	if (!(flags & IORING_ENTER_REGISTERED_RING))
+		fput(file);
 	return ret;
 }
 
@@ -4573,7 +4573,7 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 {
 	struct io_ring_ctx *ctx;
 	long ret = -EBADF;
-	struct fd f;
+	struct file *file;
 	bool use_registered_ring;
 
 	use_registered_ring = !!(opcode & IORING_REGISTER_USE_REGISTERED_RING);
@@ -4592,27 +4592,27 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 		if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
-		f.file = tctx->registered_rings[fd];
-		f.flags = 0;
-		if (unlikely(!f.file))
+		file = tctx->registered_rings[fd];
+		if (unlikely(!file))
 			return -EBADF;
 	} else {
-		f = fdget(fd);
-		if (unlikely(!f.file))
+		file = fget(fd);
+		if (unlikely(!file))
 			return -EBADF;
 		ret = -EOPNOTSUPP;
-		if (!io_is_uring_fops(f.file))
+		if (!io_is_uring_fops(file))
 			goto out_fput;
 	}
 
-	ctx = f.file->private_data;
+	ctx = file->private_data;
 
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_uring_register(ctx, opcode, arg, nr_args);
 	mutex_unlock(&ctx->uring_lock);
 	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs, ret);
 out_fput:
-	fdput(f);
+	if (!use_registered_ring)
+		fput(file);
 	return ret;
 }
 
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e137c1385c56..11c55593a2e9 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -200,6 +200,20 @@ COND_SYSCALL(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time64);
 
+/* Posix timer syscalls may be configured out */
+COND_SYSCALL(timer_create);
+COND_SYSCALL(timer_gettime);
+COND_SYSCALL(timer_getoverrun);
+COND_SYSCALL(timer_settime);
+COND_SYSCALL(timer_delete);
+COND_SYSCALL(clock_adjtime);
+COND_SYSCALL(getitimer);
+COND_SYSCALL(setitimer);
+COND_SYSCALL(alarm);
+COND_SYSCALL_COMPAT(timer_create);
+COND_SYSCALL_COMPAT(getitimer);
+COND_SYSCALL_COMPAT(setitimer);
+
 /*
  * Architecture specific syscalls: see further below
  */
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 828aeecbd1e8..9b6fcb8d85e7 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -17,40 +17,6 @@
 #include <linux/time_namespace.h>
 #include <linux/compat.h>
 
-#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
-/* Architectures may override SYS_NI and COMPAT_SYS_NI */
-#include <asm/syscall_wrapper.h>
-#endif
-
-asmlinkage long sys_ni_posix_timers(void)
-{
-	pr_err_once("process %d (%s) attempted a POSIX timer syscall "
-		    "while CONFIG_POSIX_TIMERS is not set\n",
-		    current->pid, current->comm);
-	return -ENOSYS;
-}
-
-#ifndef SYS_NI
-#define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
-#endif
-
-#ifndef COMPAT_SYS_NI
-#define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
-#endif
-
-SYS_NI(timer_create);
-SYS_NI(timer_gettime);
-SYS_NI(timer_getoverrun);
-SYS_NI(timer_settime);
-SYS_NI(timer_delete);
-SYS_NI(clock_adjtime);
-SYS_NI(getitimer);
-SYS_NI(setitimer);
-SYS_NI(clock_adjtime32);
-#ifdef __ARCH_WANT_SYS_ALARM
-SYS_NI(alarm);
-#endif
-
 /*
  * We preserve minimal support for CLOCK_REALTIME and CLOCK_MONOTONIC
  * as it is easy to remain compatible with little code. CLOCK_BOOTTIME
@@ -158,18 +124,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 				 which_clock);
 }
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYS_NI(timer_create);
-#endif
-
-#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
-COMPAT_SYS_NI(getitimer);
-COMPAT_SYS_NI(setitimer);
-#endif
-
 #ifdef CONFIG_COMPAT_32BIT_TIME
-SYS_NI(timer_settime32);
-SYS_NI(timer_gettime32);
 
 SYSCALL_DEFINE2(clock_settime32, const clockid_t, which_clock,
 		struct old_timespec32 __user *, tp)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 901a140e30fa..f232cf56fa05 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3649,6 +3649,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
+	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	    (unlikely(in_nmi()))) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a55f7d091355..fc00356a5a0a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4744,7 +4744,11 @@ static int s_show(struct seq_file *m, void *v)
 		iter->leftover = ret;
 
 	} else {
-		print_trace_line(iter);
+		ret = print_trace_line(iter);
+		if (ret == TRACE_TYPE_PARTIAL_LINE) {
+			iter->seq.full = 0;
+			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
+		}
 		ret = trace_print_seq(m, &iter->seq);
 		/*
 		 * If we overflow the seq_file buffer, then it will
@@ -4986,6 +4990,12 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
+{
+	tracing_release_file_tr(inode, filp);
+	return single_release(inode, filp);
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d608f6128704..51c0a970339e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -612,6 +612,7 @@ int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
+int tracing_single_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d06938ae0717..68aaf0bd7a78 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5630,10 +5630,12 @@ static int event_hist_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	/* Clear private_data to avoid warning in single_open() */
+	file->private_data = NULL;
 	return single_open(file, hist_show, file);
 }
 
@@ -5641,7 +5643,7 @@ const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = tracing_single_release_file_tr,
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
@@ -5907,10 +5909,12 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	/* Clear private_data to avoid warning in single_open() */
+	file->private_data = NULL;
 	return single_open(file, hist_debug_show, file);
 }
 
@@ -5918,7 +5922,7 @@ const struct file_operations event_hist_debug_fops = {
 	.open = event_hist_debug_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = tracing_single_release_file_tr,
 };
 #endif
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index db575094c498..3b7d3e9eb6ea 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1587,11 +1587,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %s", field->buf);
+	trace_seq_printf(s, ": %.*s", max, field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1600,10 +1601,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }
diff --git a/lib/idr.c b/lib/idr.c
index 13f2758c2377..da36054c3ca0 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -508,7 +508,7 @@ void ida_free(struct ida *ida, unsigned int id)
 			goto delete;
 		xas_store(&xas, xa_mk_value(v));
 	} else {
-		if (!test_bit(bit, bitmap->bitmap))
+		if (!bitmap || !test_bit(bit, bitmap->bitmap))
 			goto err;
 		__clear_bit(bit, bitmap->bitmap);
 		xas_set_mark(&xas, XA_FREE_MARK);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..7452d1a2acd9 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -372,6 +372,36 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
+/* Only warn when a test takes more than twice the threshold */
+#define KUNIT_SPEED_WARNING_MULTIPLIER	2
+
+/* Slow tests are defined as taking more than 1s */
+#define KUNIT_SPEED_SLOW_THRESHOLD_S	1
+
+#define KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S	\
+	(KUNIT_SPEED_WARNING_MULTIPLIER * KUNIT_SPEED_SLOW_THRESHOLD_S)
+
+#define s_to_timespec64(s) ns_to_timespec64((s) * NSEC_PER_SEC)
+
+static void kunit_run_case_check_speed(struct kunit *test,
+				       struct kunit_case *test_case,
+				       struct timespec64 duration)
+{
+	struct timespec64 slow_thr =
+		s_to_timespec64(KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S);
+	enum kunit_speed speed = test_case->attr.speed;
+
+	if (timespec64_compare(&duration, &slow_thr) < 0)
+		return;
+
+	if (speed == KUNIT_SPEED_VERY_SLOW || speed == KUNIT_SPEED_SLOW)
+		return;
+
+	kunit_warn(test,
+		   "Test should be marked slow (runtime: %lld.%09lds)",
+		   duration.tv_sec, duration.tv_nsec);
+}
+
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
@@ -379,6 +409,8 @@ static void kunit_run_case_internal(struct kunit *test,
 				    struct kunit_suite *suite,
 				    struct kunit_case *test_case)
 {
+	struct timespec64 start, end;
+
 	if (suite->init) {
 		int ret;
 
@@ -390,7 +422,13 @@ static void kunit_run_case_internal(struct kunit *test,
 		}
 	}
 
+	ktime_get_ts64(&start);
+
 	test_case->run_case(test);
+
+	ktime_get_ts64(&end);
+
+	kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
@@ -702,6 +740,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	kunit_suite_counter = 1;
+
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -728,8 +768,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 
 	for (i = 0; i < num_suites; i++)
 		kunit_exit_suite(suites[i]);
-
-	kunit_suite_counter = 1;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
diff --git a/lib/test_ida.c b/lib/test_ida.c
index b06880625961..55105baa19da 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -150,6 +150,45 @@ static void ida_check_conv(struct ida *ida)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+/*
+ * Check various situations where we attempt to free an ID we don't own.
+ */
+static void ida_check_bad_free(struct ida *ida)
+{
+	unsigned long i;
+
+	printk("vvv Ignore \"not allocated\" warnings\n");
+	/* IDA is empty; all of these will fail */
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single value entry */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 3, GFP_KERNEL) != 3);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single bitmap */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1023, GFP_KERNEL) != 1023);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a tree */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, (1 << 20) - 1, GFP_KERNEL) != (1 << 20) - 1);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+	printk("^^^ \"not allocated\" warnings over\n");
+
+	ida_free(ida, 3);
+	ida_free(ida, 1023);
+	ida_free(ida, (1 << 20) - 1);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static DEFINE_IDA(ida);
 
 static int ida_checks(void)
@@ -162,6 +201,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 1024 * 64);
 	ida_check_max(&ida);
 	ida_check_conv(&ida);
+	ida_check_bad_free(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 144758820e3a..f36525a595a9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -101,9 +101,11 @@ static int set_memmap_mode(const char *val, const struct kernel_param *kp)
 
 static int get_memmap_mode(char *buffer, const struct kernel_param *kp)
 {
-	if (*((int *)kp->arg) == MEMMAP_ON_MEMORY_FORCE)
-		return sprintf(buffer,  "force\n");
-	return param_get_bool(buffer, kp);
+	int mode = *((int *)kp->arg);
+
+	if (mode == MEMMAP_ON_MEMORY_FORCE)
+		return sprintf(buffer, "force\n");
+	return sprintf(buffer, "%c\n", mode ? 'Y' : 'N');
 }
 
 static const struct kernel_param_ops memmap_mode_ops = {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..552719c3bbc3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
 			READ_ONCE(tbl->gc_thresh2);
+	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	int loop = 0;
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (++loop == 16) {
+				if (ktime_get_ns() > tmax)
+					goto unlock;
+				loop = 0;
+			}
 		}
 	}
 
 	WRITE_ONCE(tbl->last_flush, jiffies);
-
+unlock:
 	write_unlock_bh(&tbl->lock);
 
 	return shrunk;
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 33729870ad8a..b3371872895c 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -271,6 +271,7 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	case NL80211_CHAN_WIDTH_80:
 	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_320:
 		bw = ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 		break;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd15ec73073e..c53914012d01 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..819157bbb5a2 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b1db0b519179..abb0c70ffc8b 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -512,7 +512,9 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 	if (!node)
 		return -ENOENT;
 
-	return server_del(node, port, true);
+	server_del(node, port, true);
+
+	return 0;
 }
 
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 563cfbe3237c..f6ada0a72977 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -221,7 +221,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 564c5632e1a2..bfe5a4082d8e 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
 	cppfilt_opts=-i
 fi
 
+UTIL_SUFFIX=
+if [[ -z ${LLVM:-} ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+	if [[ ${LLVM} == */ ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ ${LLVM} == -* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
+ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -75,7 +90,7 @@ find_module() {
 
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
 				echo $fn
 				return
 			fi
@@ -169,7 +184,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
+		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
 		if [[ $aarray_support == true ]]; then
 			cache[$module,$address]=$code
 		fi
diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index b59b78a09224..b8bff5522bce 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -397,7 +397,6 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
 
 	timer_shutdown_sync(&v_iter->timer_instance);
-	v_iter->substream = NULL;
 	playback_capture_test = !v_iter->is_buf_corrupted;
 	kfree(v_iter);
 	return 0;
@@ -435,6 +434,7 @@ static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		// We can't call timer_shutdown_sync here, as it is forbidden to sleep here
 		v_iter->suspend = true;
+		timer_delete(&v_iter->timer_instance);
 		break;
 	}
 
@@ -512,12 +512,22 @@ static int snd_pcmtst_ioctl(struct snd_pcm_substream *substream, unsigned int cm
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
+static int snd_pcmtst_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	timer_delete_sync(&v_iter->timer_instance);
+
+	return 0;
+}
+
 static const struct snd_pcm_ops snd_pcmtst_playback_ops = {
 	.open =		snd_pcmtst_pcm_open,
 	.close =	snd_pcmtst_pcm_close,
 	.trigger =	snd_pcmtst_pcm_trigger,
 	.hw_params =	snd_pcmtst_pcm_hw_params,
 	.ioctl =	snd_pcmtst_ioctl,
+	.sync_stop =	snd_pcmtst_sync_stop,
 	.hw_free =	snd_pcmtst_pcm_hw_free,
 	.prepare =	snd_pcmtst_pcm_prepare,
 	.pointer =	snd_pcmtst_pcm_pointer,
@@ -530,6 +540,7 @@ static const struct snd_pcm_ops snd_pcmtst_capture_ops = {
 	.hw_params =	snd_pcmtst_pcm_hw_params,
 	.hw_free =	snd_pcmtst_pcm_hw_free,
 	.ioctl =	snd_pcmtst_ioctl,
+	.sync_stop =	snd_pcmtst_sync_stop,
 	.prepare =	snd_pcmtst_pcm_prepare,
 	.pointer =	snd_pcmtst_pcm_pointer,
 };
diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 2c4dfc0b7e34..696a958d93e9 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -238,7 +238,7 @@ EXPORT_SYMBOL(intel_nhlt_ssp_mclk_mask);
 
 static struct nhlt_specific_cfg *
 nhlt_get_specific_cfg(struct device *dev, struct nhlt_fmt *fmt, u8 num_ch,
-		      u32 rate, u8 vbps, u8 bps)
+		      u32 rate, u8 vbps, u8 bps, bool ignore_vbps)
 {
 	struct nhlt_fmt_cfg *cfg = fmt->fmt_config;
 	struct wav_fmt *wfmt;
@@ -255,8 +255,12 @@ nhlt_get_specific_cfg(struct device *dev, struct nhlt_fmt *fmt, u8 num_ch,
 		dev_dbg(dev, "Endpoint format: ch=%d fmt=%d/%d rate=%d\n",
 			wfmt->channels, _vbps, _bps, wfmt->samples_per_sec);
 
+		/*
+		 * When looking for exact match of configuration ignore the vbps
+		 * from NHLT table when ignore_vbps is true
+		 */
 		if (wfmt->channels == num_ch && wfmt->samples_per_sec == rate &&
-		    vbps == _vbps && bps == _bps)
+		    (ignore_vbps || vbps == _vbps) && bps == _bps)
 			return &cfg->config;
 
 		cfg = (struct nhlt_fmt_cfg *)(cfg->config.caps + cfg->config.size);
@@ -289,6 +293,7 @@ intel_nhlt_get_endpoint_blob(struct device *dev, struct nhlt_acpi_table *nhlt,
 {
 	struct nhlt_specific_cfg *cfg;
 	struct nhlt_endpoint *epnt;
+	bool ignore_vbps = false;
 	struct nhlt_fmt *fmt;
 	int i;
 
@@ -298,7 +303,26 @@ intel_nhlt_get_endpoint_blob(struct device *dev, struct nhlt_acpi_table *nhlt,
 	dev_dbg(dev, "Looking for configuration:\n");
 	dev_dbg(dev, "  vbus_id=%d link_type=%d dir=%d, dev_type=%d\n",
 		bus_id, link_type, dir, dev_type);
-	dev_dbg(dev, "  ch=%d fmt=%d/%d rate=%d\n", num_ch, vbps, bps, rate);
+	if (link_type == NHLT_LINK_DMIC && bps == 32 && (vbps == 24 || vbps == 32)) {
+		/*
+		 * The DMIC hardware supports only one type of 32 bits sample
+		 * size, which is 24 bit sampling on the MSB side and bits[1:0]
+		 * are used for indicating the channel number.
+		 * It has been observed that some NHLT tables have the vbps
+		 * specified as 32 while some uses 24.
+		 * The format these variations describe are identical, the
+		 * hardware is configured and behaves the same way.
+		 * Note: when the samples assumed to be vbps=32 then the 'noise'
+		 * introduced by the lower two bits (channel number) have no
+		 * real life implication on audio quality.
+		 */
+		dev_dbg(dev,
+			"  ch=%d fmt=%d rate=%d (vbps is ignored for DMIC 32bit format)\n",
+			num_ch, bps, rate);
+		ignore_vbps = true;
+	} else {
+		dev_dbg(dev, "  ch=%d fmt=%d/%d rate=%d\n", num_ch, vbps, bps, rate);
+	}
 	dev_dbg(dev, "Endpoint count=%d\n", nhlt->endpoint_count);
 
 	epnt = (struct nhlt_endpoint *)nhlt->desc;
@@ -307,7 +331,8 @@ intel_nhlt_get_endpoint_blob(struct device *dev, struct nhlt_acpi_table *nhlt,
 		if (nhlt_check_ep_match(dev, epnt, bus_id, link_type, dir, dev_type)) {
 			fmt = (struct nhlt_fmt *)(epnt->config.caps + epnt->config.size);
 
-			cfg = nhlt_get_specific_cfg(dev, fmt, num_ch, rate, vbps, bps);
+			cfg = nhlt_get_specific_cfg(dev, fmt, num_ch, rate,
+						    vbps, bps, ignore_vbps);
 			if (cfg)
 				return cfg;
 		}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a9822d731ae0..576e0f265abd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7180,6 +7180,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7532,6 +7533,14 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
 	},
+	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x03a19020 }, /* headset mic */
+			{ 0x1b, 0x90170150 }, /* speaker */
+			{ }
+		},
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9726,6 +9735,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8735, "HP ProBook 435 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x876e, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8780, "HP ZBook Fury 17 G7 Mobile Workstation",
@@ -9907,17 +9917,20 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d1f, "ASUS ROG Strix G17 2023 (G713PV)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
+	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
-	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
@@ -10183,6 +10196,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 3babb17a56bb..d83cb6e4c62a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -374,6 +374,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -388,6 +395,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
+		}
+	},
 	{}
 };
 
diff --git a/sound/soc/codecs/cs35l45-i2c.c b/sound/soc/codecs/cs35l45-i2c.c
index 77e0f8750f37..bc2af1ed0fe9 100644
--- a/sound/soc/codecs/cs35l45-i2c.c
+++ b/sound/soc/codecs/cs35l45-i2c.c
@@ -62,7 +62,7 @@ static struct i2c_driver cs35l45_i2c_driver = {
 	.driver = {
 		.name		= "cs35l45",
 		.of_match_table = cs35l45_of_match,
-		.pm		= &cs35l45_pm_ops,
+		.pm		= pm_ptr(&cs35l45_pm_ops),
 	},
 	.id_table	= cs35l45_id_i2c,
 	.probe		= cs35l45_i2c_probe,
diff --git a/sound/soc/codecs/cs35l45-spi.c b/sound/soc/codecs/cs35l45-spi.c
index 5efb77530cc3..39e203a5f060 100644
--- a/sound/soc/codecs/cs35l45-spi.c
+++ b/sound/soc/codecs/cs35l45-spi.c
@@ -64,7 +64,7 @@ static struct spi_driver cs35l45_spi_driver = {
 	.driver = {
 		.name		= "cs35l45",
 		.of_match_table = cs35l45_of_match,
-		.pm		= &cs35l45_pm_ops,
+		.pm		= pm_ptr(&cs35l45_pm_ops),
 	},
 	.id_table	= cs35l45_id_spi,
 	.probe		= cs35l45_spi_probe,
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index be4f4229576c..9b9fc2d49108 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -775,6 +775,8 @@ static int cs35l45_enter_hibernate(struct cs35l45_private *cs35l45)
 
 	cs35l45_setup_hibernate(cs35l45);
 
+	regmap_set_bits(cs35l45->regmap, CS35L45_IRQ1_MASK_2, CS35L45_DSP_VIRT2_MBOX_MASK);
+
 	// Don't wait for ACK since bus activity would wake the device
 	regmap_write(cs35l45->regmap, CS35L45_DSP_VIRT1_MBOX_1, CSPL_MBOX_CMD_HIBERNATE);
 
@@ -795,6 +797,8 @@ static int cs35l45_exit_hibernate(struct cs35l45_private *cs35l45)
 					  CSPL_MBOX_CMD_OUT_OF_HIBERNATE);
 			if (!ret) {
 				dev_dbg(cs35l45->dev, "Wake success at cycle: %d\n", j);
+				regmap_clear_bits(cs35l45->regmap, CS35L45_IRQ1_MASK_2,
+						 CS35L45_DSP_VIRT2_MBOX_MASK);
 				return 0;
 			}
 			usleep_range(100, 200);
@@ -810,7 +814,7 @@ static int cs35l45_exit_hibernate(struct cs35l45_private *cs35l45)
 	return -ETIMEDOUT;
 }
 
-static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
+static int cs35l45_runtime_suspend(struct device *dev)
 {
 	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
 
@@ -827,7 +831,7 @@ static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l45_runtime_resume(struct device *dev)
+static int cs35l45_runtime_resume(struct device *dev)
 {
 	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
 	int ret;
@@ -854,6 +858,46 @@ static int __maybe_unused cs35l45_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int cs35l45_sys_suspend(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "System suspend, disabling IRQ\n");
+	disable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_suspend_noirq(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "Late system suspend, reenabling IRQ\n");
+	enable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_resume_noirq(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "Early system resume, disabling IRQ\n");
+	disable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_resume(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "System resume, reenabling IRQ\n");
+	enable_irq(cs35l45->irq);
+
+	return 0;
+}
+
 static int cs35l45_apply_property_config(struct cs35l45_private *cs35l45)
 {
 	struct device_node *node = cs35l45->dev->of_node;
@@ -1289,10 +1333,12 @@ void cs35l45_remove(struct cs35l45_private *cs35l45)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l45_remove, SND_SOC_CS35L45);
 
-const struct dev_pm_ops cs35l45_pm_ops = {
-	SET_RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
+EXPORT_GPL_DEV_PM_OPS(cs35l45_pm_ops) = {
+	RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
+
+	SYSTEM_SLEEP_PM_OPS(cs35l45_sys_suspend, cs35l45_sys_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l45_sys_suspend_noirq, cs35l45_sys_resume_noirq)
 };
-EXPORT_SYMBOL_NS_GPL(cs35l45_pm_ops, SND_SOC_CS35L45);
 
 MODULE_DESCRIPTION("ASoC CS35L45 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 3292405024bc..206008bdecac 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -579,7 +579,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
@@ -1683,7 +1683,7 @@ static ssize_t hpload_dc_r_show(struct device *dev,
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
 
-static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+static const u16 cs43130_ac_freq[CS43130_AC_FREQ] = {
 	24,
 	43,
 	93,
@@ -2363,7 +2363,7 @@ static const struct regmap_config cs43130_regmap = {
 	.use_single_write	= true,
 };
 
-static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	50,
 	120,
 };
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 3bbe85091649..8537c96307a9 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -696,7 +696,7 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		aad_pdata->mic_det_thr =
 			da7219_aad_fw_mic_det_thr(dev, fw_val32);
 	else
-		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;
+		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_200_OHMS;
 
 	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index be66853afbe2..d59d38ce5657 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -124,6 +124,9 @@ static struct snd_soc_dai_driver hdac_hda_dais[] = {
 		.sig_bits = 24,
 	},
 },
+};
+
+static struct snd_soc_dai_driver hdac_hda_hdmi_dais[] = {
 {
 	.id = HDAC_HDMI_0_DAI_ID,
 	.name = "intel-hdmi-hifi1",
@@ -578,8 +581,16 @@ static const struct snd_soc_component_driver hdac_hda_codec = {
 	.endianness		= 1,
 };
 
+static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
+	.probe			= hdac_hda_codec_probe,
+	.remove			= hdac_hda_codec_remove,
+	.idle_bias_on		= false,
+	.endianness		= 1,
+};
+
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
+	struct hdac_hda_priv *hda_pvt = dev_get_drvdata(&hdev->dev);
 	struct hdac_ext_link *hlink;
 	int ret;
 
@@ -592,9 +603,15 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
 
 	/* ASoC specific initialization */
-	ret = devm_snd_soc_register_component(&hdev->dev,
-					 &hdac_hda_codec, hdac_hda_dais,
-					 ARRAY_SIZE(hdac_hda_dais));
+	if (hda_pvt->need_display_power)
+		ret = devm_snd_soc_register_component(&hdev->dev,
+						&hdac_hda_hdmi_codec, hdac_hda_hdmi_dais,
+						ARRAY_SIZE(hdac_hda_hdmi_dais));
+	else
+		ret = devm_snd_soc_register_component(&hdev->dev,
+						&hdac_hda_codec, hdac_hda_dais,
+						ARRAY_SIZE(hdac_hda_dais));
+
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
 		return ret;
diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index ff3024899f45..7199d734c79f 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -184,6 +184,7 @@ static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 	int i, reg;
 	u16 reg_val, *val;
+	__be16 tmp;
 
 	val = (u16 *)ucontrol->value.bytes.data;
 	reg = NAU8822_REG_EQ1;
@@ -192,8 +193,8 @@ static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
 		/* conversion of 16-bit integers between native CPU format
 		 * and big endian format
 		 */
-		reg_val = cpu_to_be16(reg_val);
-		memcpy(val + i, &reg_val, sizeof(reg_val));
+		tmp = cpu_to_be16(reg_val);
+		memcpy(val + i, &tmp, sizeof(tmp));
 	}
 
 	return 0;
@@ -216,6 +217,7 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 	void *data;
 	u16 *val, value;
 	int i, reg, ret;
+	__be16 *tmp;
 
 	data = kmemdup(ucontrol->value.bytes.data,
 		params->max, GFP_KERNEL | GFP_DMA);
@@ -228,7 +230,8 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 		/* conversion of 16-bit integers between native CPU format
 		 * and big endian format
 		 */
-		value = be16_to_cpu(*(val + i));
+		tmp = (__be16 *)(val + i);
+		value = be16_to_cpup(tmp);
 		ret = snd_soc_component_write(component, reg + i, value);
 		if (ret) {
 			dev_err(component->dev,
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7938b52d741d..a0d01d71d8b5 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -448,6 +448,7 @@ struct rt5645_priv {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
 	struct rt5645_eq_param_s *eq_param;
 	struct timer_list btn_check_timer;
+	struct mutex jd_mutex;
 
 	int codec_type;
 	int sysclk;
@@ -3193,6 +3194,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 				rt5645_enable_push_button_irq(component, true);
 			}
 		} else {
+			if (rt5645->en_button_func)
+				rt5645_enable_push_button_irq(component, false);
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
@@ -3295,6 +3298,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	if (!rt5645->component)
 		return;
 
+	mutex_lock(&rt5645->jd_mutex);
+
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
@@ -3321,7 +3326,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 
 	if (!val && (rt5645->jack_type == 0)) { /* jack in */
 		report = rt5645_jack_detect(rt5645->component, 1);
-	} else if (!val && rt5645->jack_type != 0) {
+	} else if (!val && rt5645->jack_type == SND_JACK_HEADSET) {
 		/* for push button and jack out */
 		btn_type = 0;
 		if (snd_soc_component_read(rt5645->component, RT5645_INT_IRQ_ST) & 0x4) {
@@ -3377,6 +3382,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		rt5645_jack_detect(rt5645->component, 0);
 	}
 
+	mutex_unlock(&rt5645->jd_mutex);
+
 	snd_soc_jack_report(rt5645->hp_jack, report, SND_JACK_HEADPHONE);
 	snd_soc_jack_report(rt5645->mic_jack, report, SND_JACK_MICROPHONE);
 	if (rt5645->en_button_func)
@@ -4150,6 +4157,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c)
 	}
 	timer_setup(&rt5645->btn_check_timer, rt5645_btn_check_callback, 0);
 
+	mutex_init(&rt5645->jd_mutex);
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
 
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 044b6f604c09..260bac695b20 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -186,7 +186,7 @@ SOC_DAPM_SINGLE("PCM Playback Switch", WM8974_MONOMIX, 0, 1, 0),
 
 /* Boost mixer */
 static const struct snd_kcontrol_new wm8974_boost_mixer[] = {
-SOC_DAPM_SINGLE("Aux Switch", WM8974_INPPGA, 6, 1, 1),
+SOC_DAPM_SINGLE("PGA Switch", WM8974_INPPGA, 6, 1, 1),
 };
 
 /* Input PGA */
@@ -246,8 +246,8 @@ static const struct snd_soc_dapm_route wm8974_dapm_routes[] = {
 
 	/* Boost Mixer */
 	{"ADC", NULL, "Boost Mixer"},
-	{"Boost Mixer", "Aux Switch", "Aux Input"},
-	{"Boost Mixer", NULL, "Input PGA"},
+	{"Boost Mixer", NULL, "Aux Input"},
+	{"Boost Mixer", "PGA Switch", "Input PGA"},
 	{"Boost Mixer", NULL, "MICP"},
 
 	/* Input PGA */
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index fa0a15263c66..f0fb33d719c2 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -358,7 +358,7 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 	struct device *dev = &xcvr->pdev->dev;
 	int ret;
 
-	freq = xcvr->soc_data->spdif_only ? freq / 10 : freq;
+	freq = xcvr->soc_data->spdif_only ? freq / 5 : freq;
 	clk_disable_unprepare(xcvr->phy_clk);
 	ret = clk_set_rate(xcvr->phy_clk, freq);
 	if (ret < 0) {
@@ -409,11 +409,21 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 m_ctl = 0, v_ctl = 0;
 	u32 r = substream->runtime->rate, ch = substream->runtime->channels;
-	u32 fout = 32 * r * ch * 10 * 2;
+	u32 fout = 32 * r * ch * 10;
 	int ret = 0;
 
 	switch (xcvr->mode) {
 	case FSL_XCVR_MODE_SPDIF:
+		if (xcvr->soc_data->spdif_only && tx) {
+			ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_TX_DPTH_CTRL_SET,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM);
+			if (ret < 0) {
+				dev_err(dai->dev, "Failed to set bypass fem: %d\n", ret);
+				return ret;
+			}
+		}
+		fallthrough;
 	case FSL_XCVR_MODE_ARC:
 		if (tx) {
 			ret = fsl_xcvr_en_aud_pll(xcvr, fout);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 630784b6cb6d..6b631a608ae8 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -83,6 +83,7 @@ enum {
 #define BYT_RT5640_HSMIC2_ON_IN1	BIT(27)
 #define BYT_RT5640_JD_HP_ELITEP_1000G2	BIT(28)
 #define BYT_RT5640_USE_AMCR0F28		BIT(29)
+#define BYT_RT5640_SWAPPED_SPEAKERS	BIT(30)
 
 #define BYTCR_INPUT_DEFAULTS				\
 	(BYT_RT5640_IN3_MAP |				\
@@ -157,6 +158,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS)
 		dev_info(dev, "quirk NO_SPEAKERS enabled\n");
+	if (byt_rt5640_quirk & BYT_RT5640_SWAPPED_SPEAKERS)
+		dev_info(dev, "quirk SWAPPED_SPEAKERS enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT)
 		dev_info(dev, "quirk LINEOUT enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
@@ -894,6 +897,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		/* Medion Lifetab S10346 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are much too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "10/22/2015"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_SWAPPED_SPEAKERS |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Mele PCG03 Mini PC */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
@@ -1619,11 +1635,11 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
+	const char *cfg_spk;
 	bool sof_parent;
 	int ret_val = 0;
 	int dai_index = 0;
-	int i, cfg_spk;
-	int aif;
+	int i, aif;
 
 	is_bytcr = false;
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -1783,13 +1799,16 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	if (byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS) {
-		cfg_spk = 0;
+		cfg_spk = "0";
 		spk_type = "none";
 	} else if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) {
-		cfg_spk = 1;
+		cfg_spk = "1";
 		spk_type = "mono";
+	} else if (byt_rt5640_quirk & BYT_RT5640_SWAPPED_SPEAKERS) {
+		cfg_spk = "swapped";
+		spk_type = "swapped";
 	} else {
-		cfg_spk = 2;
+		cfg_spk = "2";
 		spk_type = "stereo";
 	}
 
@@ -1804,7 +1823,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		headset2_string = " cfg-hs2:in1";
 
 	snprintf(byt_rt5640_components, sizeof(byt_rt5640_components),
-		 "cfg-spk:%d cfg-mic:%s aif:%d%s%s", cfg_spk,
+		 "cfg-spk:%s cfg-mic:%s aif:%d%s%s", cfg_spk,
 		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)], aif,
 		 lineout_string, headset2_string);
 	byt_rt5640_card.components = byt_rt5640_components;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index a06e05154ae1..70c806cc5b2e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -154,6 +154,8 @@ static int skl_hda_fill_card_info(struct snd_soc_acpi_mach_params *mach_params)
 		card->dapm_widgets = skl_hda_widgets;
 		card->num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets);
 		if (!ctx->idisp_codec) {
+			card->dapm_routes = &skl_hda_map[IDISP_ROUTE_COUNT];
+			num_route -= IDISP_ROUTE_COUNT;
 			for (i = 0; i < IDISP_DAI_COUNT; i++) {
 				skl_hda_be_dai_links[i].codecs = &asoc_dummy_dlc;
 				skl_hda_be_dai_links[i].num_codecs = 1;
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ac3dc8c63c26..c602275fcf71 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -252,8 +252,10 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	snd_pcm_set_sync(substream);
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
-	if (!mconfig)
+	if (!mconfig) {
+		kfree(dma_params);
 		return -EINVAL;
+	}
 
 	skl_tplg_d0i3_get(skl, mconfig->d0i3_caps);
 
@@ -1471,6 +1473,7 @@ int skl_platform_register(struct device *dev)
 		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
 				sizeof(skl_platform_dai), GFP_KERNEL);
 		if (!dais) {
+			kfree(skl->dais);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -1483,8 +1486,10 @@ int skl_platform_register(struct device *dev)
 
 	ret = devm_snd_soc_register_component(dev, &skl_component,
 					 skl->dais, num_dais);
-	if (ret)
+	if (ret) {
+		kfree(skl->dais);
 		dev_err(dev, "soc component registration failed %d\n", ret);
+	}
 err:
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 7a425271b08b..fd9624ad5f72 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -1003,8 +1003,10 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 
 	reply.size = (reply.header >> 32) & IPC_DATA_OFFSET_SZ_MASK;
 	buf = krealloc(reply.data, reply.size, GFP_KERNEL);
-	if (!buf)
+	if (!buf) {
+		kfree(reply.data);
 		return -ENOMEM;
+	}
 	*payload = buf;
 	*bytes = reply.size;
 
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 8a5e99a898ec..328d7c227b21 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -54,8 +54,16 @@ static int request_codec_module(struct hda_codec *codec)
 
 static int hda_codec_load_module(struct hda_codec *codec)
 {
-	int ret = request_codec_module(codec);
+	int ret;
+
+	ret = snd_hdac_device_register(&codec->core);
+	if (ret) {
+		dev_err(&codec->core.dev, "failed to register hdac device\n");
+		put_device(&codec->core.dev);
+		return ret;
+	}
 
+	ret = request_codec_module(codec);
 	if (ret <= 0) {
 		codec->probe_id = HDA_CODEC_ID_GENERIC;
 		ret = request_codec_module(codec);
@@ -116,7 +124,6 @@ EXPORT_SYMBOL_NS_GPL(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, int type)
 {
 	struct hda_codec *codec;
-	int ret;
 
 	codec = snd_hda_codec_device_init(to_hda_bus(bus), addr, "ehdaudio%dD%d", bus->idx, addr);
 	if (IS_ERR(codec)) {
@@ -126,13 +133,6 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 
 	codec->core.type = type;
 
-	ret = snd_hdac_device_register(&codec->core);
-	if (ret) {
-		dev_err(bus->dev, "failed to register hdac device\n");
-		put_device(&codec->core.dev);
-		return ERR_PTR(ret);
-	}
-
 	return codec;
 }
 
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index ba4ef290b634..2c7a5e7a364c 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -493,6 +493,7 @@ static int sof_ipc3_widget_setup_comp_mixer(struct snd_sof_widget *swidget)
 static int sof_ipc3_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct sof_ipc_pipe_new *pipeline;
 	struct snd_sof_widget *comp_swidget;
 	int ret;
@@ -545,6 +546,7 @@ static int sof_ipc3_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 		swidget->dynamic_pipeline_widget);
 
 	swidget->core = pipeline->core;
+	spipe->core_mask |= BIT(pipeline->core);
 
 	return 0;
 
diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index c6d404d44097..e4ce1b53fba6 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -89,7 +89,7 @@ sof_ipc4_set_volume_data(struct snd_sof_dev *sdev, struct snd_sof_widget *swidge
 	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
 	struct sof_ipc4_gain *gain = swidget->private;
 	struct sof_ipc4_msg *msg = &cdata->msg;
-	struct sof_ipc4_gain_data data;
+	struct sof_ipc4_gain_params params;
 	bool all_channels_equal = true;
 	u32 value;
 	int ret, i;
@@ -109,20 +109,20 @@ sof_ipc4_set_volume_data(struct snd_sof_dev *sdev, struct snd_sof_widget *swidge
 	 */
 	for (i = 0; i < scontrol->num_channels; i++) {
 		if (all_channels_equal) {
-			data.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
-			data.init_val = cdata->chanv[0].value;
+			params.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
+			params.init_val = cdata->chanv[0].value;
 		} else {
-			data.channels = cdata->chanv[i].channel;
-			data.init_val = cdata->chanv[i].value;
+			params.channels = cdata->chanv[i].channel;
+			params.init_val = cdata->chanv[i].value;
 		}
 
 		/* set curve type and duration from topology */
-		data.curve_duration_l = gain->data.curve_duration_l;
-		data.curve_duration_h = gain->data.curve_duration_h;
-		data.curve_type = gain->data.curve_type;
+		params.curve_duration_l = gain->data.params.curve_duration_l;
+		params.curve_duration_h = gain->data.params.curve_duration_h;
+		params.curve_type = gain->data.params.curve_type;
 
-		msg->data_ptr = &data;
-		msg->data_size = sizeof(data);
+		msg->data_ptr = &params;
+		msg->data_size = sizeof(params);
 
 		ret = sof_ipc4_set_get_kcontrol_data(scontrol, true, lock);
 		msg->data_ptr = NULL;
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index c9c1d2ec7af2..2c075afd237c 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -128,18 +128,18 @@ static const struct sof_topology_token comp_ext_tokens[] = {
 
 static const struct sof_topology_token gain_tokens[] = {
 	{SOF_TKN_GAIN_RAMP_TYPE, SND_SOC_TPLG_TUPLE_TYPE_WORD,
-		get_token_u32, offsetof(struct sof_ipc4_gain_data, curve_type)},
+		get_token_u32, offsetof(struct sof_ipc4_gain_params, curve_type)},
 	{SOF_TKN_GAIN_RAMP_DURATION,
 		SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
-		offsetof(struct sof_ipc4_gain_data, curve_duration_l)},
+		offsetof(struct sof_ipc4_gain_params, curve_duration_l)},
 	{SOF_TKN_GAIN_VAL, SND_SOC_TPLG_TUPLE_TYPE_WORD,
-		get_token_u32, offsetof(struct sof_ipc4_gain_data, init_val)},
+		get_token_u32, offsetof(struct sof_ipc4_gain_params, init_val)},
 };
 
 /* SRC */
 static const struct sof_topology_token src_tokens[] = {
 	{SOF_TKN_SRC_RATE_OUT, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
-		offsetof(struct sof_ipc4_src, sink_rate)},
+		offsetof(struct sof_ipc4_src_data, sink_rate)},
 };
 
 static const struct sof_token_info ipc4_token_list[SOF_TOKEN_COUNT] = {
@@ -654,6 +654,7 @@ static int sof_ipc4_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
 	struct sof_ipc4_pipeline *pipeline;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	int ret;
 
 	pipeline = kzalloc(sizeof(*pipeline), GFP_KERNEL);
@@ -668,6 +669,7 @@ static int sof_ipc4_widget_setup_comp_pipeline(struct snd_sof_widget *swidget)
 	}
 
 	swidget->core = pipeline->core_id;
+	spipe->core_mask |= BIT(pipeline->core_id);
 
 	if (pipeline->use_chain_dma) {
 		dev_dbg(scomp->dev, "Set up chain DMA for %s\n", swidget->widget->name);
@@ -719,15 +721,15 @@ static int sof_ipc4_widget_setup_comp_pga(struct snd_sof_widget *swidget)
 
 	swidget->private = gain;
 
-	gain->data.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
-	gain->data.init_val = SOF_IPC4_VOL_ZERO_DB;
+	gain->data.params.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
+	gain->data.params.init_val = SOF_IPC4_VOL_ZERO_DB;
 
-	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &gain->available_fmt, &gain->base_config);
+	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &gain->available_fmt, &gain->data.base_config);
 	if (ret)
 		goto err;
 
-	ret = sof_update_ipc_object(scomp, &gain->data, SOF_GAIN_TOKENS, swidget->tuples,
-				    swidget->num_tuples, sizeof(gain->data), 1);
+	ret = sof_update_ipc_object(scomp, &gain->data.params, SOF_GAIN_TOKENS,
+				    swidget->tuples, swidget->num_tuples, sizeof(gain->data), 1);
 	if (ret) {
 		dev_err(scomp->dev, "Parsing gain tokens failed\n");
 		goto err;
@@ -735,8 +737,8 @@ static int sof_ipc4_widget_setup_comp_pga(struct snd_sof_widget *swidget)
 
 	dev_dbg(scomp->dev,
 		"pga widget %s: ramp type: %d, ramp duration %d, initial gain value: %#x\n",
-		swidget->widget->name, gain->data.curve_type, gain->data.curve_duration_l,
-		gain->data.init_val);
+		swidget->widget->name, gain->data.params.curve_type,
+		gain->data.params.curve_duration_l, gain->data.params.init_val);
 
 	ret = sof_ipc4_widget_setup_msg(swidget, &gain->msg);
 	if (ret)
@@ -798,6 +800,7 @@ static int sof_ipc4_widget_setup_comp_mixer(struct snd_sof_widget *swidget)
 static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct sof_ipc4_src *src;
 	int ret;
 
@@ -809,18 +812,21 @@ static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
 
 	swidget->private = src;
 
-	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &src->available_fmt, &src->base_config);
+	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &src->available_fmt,
+				     &src->data.base_config);
 	if (ret)
 		goto err;
 
-	ret = sof_update_ipc_object(scomp, src, SOF_SRC_TOKENS, swidget->tuples,
+	ret = sof_update_ipc_object(scomp, &src->data, SOF_SRC_TOKENS, swidget->tuples,
 				    swidget->num_tuples, sizeof(*src), 1);
 	if (ret) {
 		dev_err(scomp->dev, "Parsing SRC tokens failed\n");
 		goto err;
 	}
 
-	dev_dbg(scomp->dev, "SRC sink rate %d\n", src->sink_rate);
+	spipe->core_mask |= BIT(swidget->core);
+
+	dev_dbg(scomp->dev, "SRC sink rate %d\n", src->data.sink_rate);
 
 	ret = sof_ipc4_widget_setup_msg(swidget, &src->msg);
 	if (ret)
@@ -865,6 +871,7 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 {
 	struct snd_soc_component *scomp = swidget->scomp;
 	struct sof_ipc4_fw_module *fw_module;
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct sof_ipc4_process *process;
 	void *cfg;
 	int ret;
@@ -921,6 +928,9 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 
 	sof_ipc4_widget_update_kcontrol_module_id(swidget);
 
+	/* set pipeline core mask to keep track of the core the module is scheduled to run on */
+	spipe->core_mask |= BIT(swidget->core);
+
 	return 0;
 free_base_cfg_ext:
 	kfree(process->base_config_ext);
@@ -1812,7 +1822,7 @@ static int sof_ipc4_prepare_gain_module(struct snd_sof_widget *swidget,
 	u32 out_ref_rate, out_ref_channels, out_ref_valid_bits;
 	int ret;
 
-	ret = sof_ipc4_init_input_audio_fmt(sdev, swidget, &gain->base_config,
+	ret = sof_ipc4_init_input_audio_fmt(sdev, swidget, &gain->data.base_config,
 					    pipeline_params, available_fmt);
 	if (ret < 0)
 		return ret;
@@ -1822,7 +1832,7 @@ static int sof_ipc4_prepare_gain_module(struct snd_sof_widget *swidget,
 	out_ref_channels = SOF_IPC4_AUDIO_FORMAT_CFG_CHANNELS_COUNT(in_fmt->fmt_cfg);
 	out_ref_valid_bits = SOF_IPC4_AUDIO_FORMAT_CFG_V_BIT_DEPTH(in_fmt->fmt_cfg);
 
-	ret = sof_ipc4_init_output_audio_fmt(sdev, &gain->base_config, available_fmt,
+	ret = sof_ipc4_init_output_audio_fmt(sdev, &gain->data.base_config, available_fmt,
 					     out_ref_rate, out_ref_channels, out_ref_valid_bits);
 	if (ret < 0) {
 		dev_err(sdev->dev, "Failed to initialize output format for %s",
@@ -1831,7 +1841,7 @@ static int sof_ipc4_prepare_gain_module(struct snd_sof_widget *swidget,
 	}
 
 	/* update pipeline memory usage */
-	sof_ipc4_update_resource_usage(sdev, swidget, &gain->base_config);
+	sof_ipc4_update_resource_usage(sdev, swidget, &gain->data.base_config);
 
 	return 0;
 }
@@ -1887,7 +1897,7 @@ static int sof_ipc4_prepare_src_module(struct snd_sof_widget *swidget,
 	u32 out_ref_rate, out_ref_channels, out_ref_valid_bits;
 	int output_format_index, input_format_index;
 
-	input_format_index = sof_ipc4_init_input_audio_fmt(sdev, swidget, &src->base_config,
+	input_format_index = sof_ipc4_init_input_audio_fmt(sdev, swidget, &src->data.base_config,
 							   pipeline_params, available_fmt);
 	if (input_format_index < 0)
 		return input_format_index;
@@ -1917,7 +1927,7 @@ static int sof_ipc4_prepare_src_module(struct snd_sof_widget *swidget,
 	 */
 	out_ref_rate = params_rate(fe_params);
 
-	output_format_index = sof_ipc4_init_output_audio_fmt(sdev, &src->base_config,
+	output_format_index = sof_ipc4_init_output_audio_fmt(sdev, &src->data.base_config,
 							     available_fmt, out_ref_rate,
 							     out_ref_channels, out_ref_valid_bits);
 	if (output_format_index < 0) {
@@ -1927,10 +1937,10 @@ static int sof_ipc4_prepare_src_module(struct snd_sof_widget *swidget,
 	}
 
 	/* update pipeline memory usage */
-	sof_ipc4_update_resource_usage(sdev, swidget, &src->base_config);
+	sof_ipc4_update_resource_usage(sdev, swidget, &src->data.base_config);
 
 	out_audio_fmt = &available_fmt->output_pin_fmts[output_format_index].audio_fmt;
-	src->sink_rate = out_audio_fmt->sampling_frequency;
+	src->data.sink_rate = out_audio_fmt->sampling_frequency;
 
 	/* update pipeline_params for sink widgets */
 	return sof_ipc4_update_hw_params(sdev, pipeline_params, out_audio_fmt);
@@ -2267,9 +2277,8 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct sof_ipc4_gain *gain = swidget->private;
 
-		ipc_size = sizeof(struct sof_ipc4_base_module_cfg) +
-			   sizeof(struct sof_ipc4_gain_data);
-		ipc_data = gain;
+		ipc_size = sizeof(gain->data);
+		ipc_data = &gain->data;
 
 		msg = &gain->msg;
 		break;
@@ -2288,8 +2297,8 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct sof_ipc4_src *src = swidget->private;
 
-		ipc_size = sizeof(struct sof_ipc4_base_module_cfg) + sizeof(src->sink_rate);
-		ipc_data = src;
+		ipc_size = sizeof(src->data);
+		ipc_data = &src->data;
 
 		msg = &src->msg;
 		break;
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index d75f17f4749c..21436657ad85 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -344,7 +344,7 @@ struct sof_ipc4_control_data {
 };
 
 /**
- * struct sof_ipc4_gain_data - IPC gain blob
+ * struct sof_ipc4_gain_params - IPC gain parameters
  * @channels: Channels
  * @init_val: Initial value
  * @curve_type: Curve type
@@ -352,24 +352,32 @@ struct sof_ipc4_control_data {
  * @curve_duration_l: Curve duration low part
  * @curve_duration_h: Curve duration high part
  */
-struct sof_ipc4_gain_data {
+struct sof_ipc4_gain_params {
 	uint32_t channels;
 	uint32_t init_val;
 	uint32_t curve_type;
 	uint32_t reserved;
 	uint32_t curve_duration_l;
 	uint32_t curve_duration_h;
-} __aligned(8);
+} __packed __aligned(4);
 
 /**
- * struct sof_ipc4_gain - gain config data
+ * struct sof_ipc4_gain_data - IPC gain init blob
  * @base_config: IPC base config data
+ * @params: Initial parameters for the gain module
+ */
+struct sof_ipc4_gain_data {
+	struct sof_ipc4_base_module_cfg base_config;
+	struct sof_ipc4_gain_params params;
+} __packed __aligned(4);
+
+/**
+ * struct sof_ipc4_gain - gain config data
  * @data: IPC gain blob
  * @available_fmt: Available audio format
  * @msg: message structure for gain
  */
 struct sof_ipc4_gain {
-	struct sof_ipc4_base_module_cfg base_config;
 	struct sof_ipc4_gain_data data;
 	struct sof_ipc4_available_audio_format available_fmt;
 	struct sof_ipc4_msg msg;
@@ -387,16 +395,24 @@ struct sof_ipc4_mixer {
 	struct sof_ipc4_msg msg;
 };
 
-/**
- * struct sof_ipc4_src SRC config data
+/*
+ * struct sof_ipc4_src_data - IPC data for SRC
  * @base_config: IPC base config data
  * @sink_rate: Output rate for sink module
+ */
+struct sof_ipc4_src_data {
+	struct sof_ipc4_base_module_cfg base_config;
+	uint32_t sink_rate;
+} __packed __aligned(4);
+
+/**
+ * struct sof_ipc4_src - SRC config data
+ * @data: IPC base config data
  * @available_fmt: Available audio format
  * @msg: IPC4 message struct containing header and data info
  */
 struct sof_ipc4_src {
-	struct sof_ipc4_base_module_cfg base_config;
-	uint32_t sink_rate;
+	struct sof_ipc4_src_data data;
 	struct sof_ipc4_available_audio_format available_fmt;
 	struct sof_ipc4_msg msg;
 };
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 563fe6f7789f..77cc64ac7113 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -46,6 +46,7 @@ static int sof_widget_free_unlocked(struct snd_sof_dev *sdev,
 				    struct snd_sof_widget *swidget)
 {
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct snd_sof_widget *pipe_widget;
 	int err = 0;
 	int ret;
@@ -87,15 +88,22 @@ static int sof_widget_free_unlocked(struct snd_sof_dev *sdev,
 	}
 
 	/*
-	 * disable widget core. continue to route setup status and complete flag
-	 * even if this fails and return the appropriate error
+	 * decrement ref count for cores associated with all modules in the pipeline and clear
+	 * the complete flag
 	 */
-	ret = snd_sof_dsp_core_put(sdev, swidget->core);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to disable target core: %d for widget %s\n",
-			swidget->core, swidget->widget->name);
-		if (!err)
-			err = ret;
+	if (swidget->id == snd_soc_dapm_scheduler) {
+		int i;
+
+		for_each_set_bit(i, &spipe->core_mask, sdev->num_cores) {
+			ret = snd_sof_dsp_core_put(sdev, i);
+			if (ret < 0) {
+				dev_err(sdev->dev, "failed to disable target core: %d for pipeline %s\n",
+					i, swidget->widget->name);
+				if (!err)
+					err = ret;
+			}
+		}
+		swidget->spipe->complete = 0;
 	}
 
 	/*
@@ -108,10 +116,6 @@ static int sof_widget_free_unlocked(struct snd_sof_dev *sdev,
 			err = ret;
 	}
 
-	/* clear pipeline complete */
-	if (swidget->id == snd_soc_dapm_scheduler)
-		swidget->spipe->complete = 0;
-
 	if (!err)
 		dev_dbg(sdev->dev, "widget %s freed\n", swidget->widget->name);
 
@@ -134,8 +138,10 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 				     struct snd_sof_widget *swidget)
 {
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	bool use_count_decremented = false;
 	int ret;
+	int i;
 
 	/* skip if there is no private data */
 	if (!swidget->private)
@@ -166,19 +172,23 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 			goto use_count_dec;
 	}
 
-	/* enable widget core */
-	ret = snd_sof_dsp_core_get(sdev, swidget->core);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to enable target core for widget %s\n",
-			swidget->widget->name);
-		goto pipe_widget_free;
+	/* update ref count for cores associated with all modules in the pipeline */
+	if (swidget->id == snd_soc_dapm_scheduler) {
+		for_each_set_bit(i, &spipe->core_mask, sdev->num_cores) {
+			ret = snd_sof_dsp_core_get(sdev, i);
+			if (ret < 0) {
+				dev_err(sdev->dev, "failed to enable target core %d for pipeline %s\n",
+					i, swidget->widget->name);
+				goto pipe_widget_free;
+			}
+		}
 	}
 
 	/* setup widget in the DSP */
 	if (tplg_ops && tplg_ops->widget_setup) {
 		ret = tplg_ops->widget_setup(sdev, swidget);
 		if (ret < 0)
-			goto core_put;
+			goto pipe_widget_free;
 	}
 
 	/* send config for DAI components */
@@ -208,15 +218,22 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 	return 0;
 
 widget_free:
-	/* widget use_count and core ref_count will both be decremented by sof_widget_free() */
+	/* widget use_count will be decremented by sof_widget_free() */
 	sof_widget_free_unlocked(sdev, swidget);
 	use_count_decremented = true;
-core_put:
-	if (!use_count_decremented)
-		snd_sof_dsp_core_put(sdev, swidget->core);
 pipe_widget_free:
-	if (swidget->id != snd_soc_dapm_scheduler)
+	if (swidget->id != snd_soc_dapm_scheduler) {
 		sof_widget_free_unlocked(sdev, swidget->spipe->pipe_widget);
+	} else {
+		int j;
+
+		/* decrement ref count for all cores that were updated previously */
+		for_each_set_bit(j, &spipe->core_mask, sdev->num_cores) {
+			if (j >= i)
+				break;
+			snd_sof_dsp_core_put(sdev, j);
+		}
+	}
 use_count_dec:
 	if (!use_count_decremented)
 		swidget->use_count--;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 5d5eeb1a1a6f..a6d6bcd00cee 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -480,6 +480,7 @@ struct snd_sof_widget {
  * @paused_count: Count of number of PCM's that have started and have currently paused this
 		  pipeline
  * @complete: flag used to indicate that pipeline set up is complete.
+ * @core_mask: Mask containing target cores for all modules in the pipeline
  * @list: List item in sdev pipeline_list
  */
 struct snd_sof_pipeline {
@@ -487,6 +488,7 @@ struct snd_sof_pipeline {
 	int started_count;
 	int paused_count;
 	int complete;
+	unsigned long core_mask;
 	struct list_head list;
 };
 
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index a3a3af252259..37ec671a2d76 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1736,8 +1736,10 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	/* perform pcm set op */
 	if (ipc_pcm_ops && ipc_pcm_ops->pcm_setup) {
 		ret = ipc_pcm_ops->pcm_setup(sdev, spcm);
-		if (ret < 0)
+		if (ret < 0) {
+			kfree(spcm);
 			return ret;
+		}
 	}
 
 	dai_drv->dobj.private = spcm;
diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 21e482b23f50..23df154fcdd7 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -138,7 +138,7 @@ static void find_controls(void)
 			err = snd_ctl_elem_info(card_data->handle,
 						ctl_data->info);
 			if (err < 0) {
-				ksft_print_msg("%s getting info for %d\n",
+				ksft_print_msg("%s getting info for %s\n",
 					       snd_strerror(err),
 					       ctl_data->name);
 			}

