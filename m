Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3E7D67EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjJYKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjJYKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:09:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0172312D;
        Wed, 25 Oct 2023 03:08:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834DDC433C7;
        Wed, 25 Oct 2023 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698228538;
        bh=7xuVdKMQWuOprkXwBBTftsNFrIBwjy+MQOcpWnXgn4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQzRu6ZMuoaeOFlRUANoVLXS6XXN63F0TvTZNr6b3grODUYqnCvZLiWbhcsg8gMHb
         64CrcwnZ3yOqDeqTCRrOgy6iQmZLu/M6WEj7AeQD9LfQJi8hfhpA0cPznEj4uQ6+sX
         nkcWqzIcbSaRoiaV52NifboPK1lXNfC3JoFCXj74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.199
Date:   Wed, 25 Oct 2023 12:08:46 +0200
Message-ID: <2023102546-wireless-ducktail-a804@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023102546-headcount-award-0f06@gregkh>
References: <2023102546-headcount-award-0f06@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 4f1a686b4b64..1ba6c0b9c161 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -31,18 +31,18 @@ see only some of them, depending on your kernel's configuration.
 
 Table : Subdirectories in /proc/sys/net
 
- ========= =================== = ========== ==================
+ ========= =================== = ========== ===================
  Directory Content               Directory  Content
- ========= =================== = ========== ==================
- 802       E802 protocol         mptcp     Multipath TCP
- appletalk Appletalk protocol    netfilter Network Filter
+ ========= =================== = ========== ===================
+ 802       E802 protocol         mptcp      Multipath TCP
+ appletalk Appletalk protocol    netfilter  Network Filter
  ax25      AX25                  netrom     NET/ROM
- bridge    Bridging              rose      X.25 PLP layer
- core      General parameter     tipc      TIPC
- ethernet  Ethernet protocol     unix      Unix domain sockets
- ipv4      IP version 4          x25       X.25 protocol
+ bridge    Bridging              rose       X.25 PLP layer
+ core      General parameter     tipc       TIPC
+ ethernet  Ethernet protocol     unix       Unix domain sockets
+ ipv4      IP version 4          x25        X.25 protocol
  ipv6      IP version 6
- ========= =================== = ========== ==================
+ ========= =================== = ========== ===================
 
 1. /proc/sys/net/core - Network core options
 ============================================
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 252212998378..e912a47765f3 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1916,6 +1916,14 @@ accept_ra_min_hop_limit - INTEGER
 
 	Default: 1
 
+accept_ra_min_lft - INTEGER
+	Minimum acceptable lifetime value in Router Advertisement.
+
+	RA sections with a lifetime less than this value shall be
+	ignored. Zero lifetimes stay unaffected.
+
+	Default: 0
+
 accept_ra_pinfo - BOOLEAN
 	Learn Prefix Information in Router Advertisement.
 
diff --git a/Makefile b/Makefile
index 470e11dcf2a3..5105828bf6da 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 198
+SUBLEVEL = 199
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 8cb26b924d3c..f9392a135d38 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -765,6 +765,7 @@ &uart1 {
 &uart3 {
 	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x17c>;
+	overrun-throttle-ms = <500>;
 };
 
 &uart4 {
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 31ba0ac7db63..7a2007c57d3c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -759,7 +759,8 @@ static inline bool system_supports_tlb_range(void)
 		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
 }
 
-extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
+int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
+bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
 static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 {
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 59c3facb8a56..cc5b2203d876 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -33,19 +33,22 @@ asmlinkage void exit_to_user_mode(void);
 void arm64_enter_nmi(struct pt_regs *regs);
 void arm64_exit_nmi(struct pt_regs *regs);
 void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
-void do_undefinstr(struct pt_regs *regs);
-void do_bti(struct pt_regs *regs);
+void do_el0_undef(struct pt_regs *regs, unsigned long esr);
+void do_el1_undef(struct pt_regs *regs, unsigned long esr);
+void do_el0_bti(struct pt_regs *regs);
+void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 			struct pt_regs *regs);
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs);
 void do_sve_acc(unsigned int esr, struct pt_regs *regs);
 void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs);
-void do_sysinstr(unsigned int esr, struct pt_regs *regs);
+void do_el0_sys(unsigned long esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr);
-void do_cp15instr(unsigned int esr, struct pt_regs *regs);
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
-void do_ptrauth_fault(struct pt_regs *regs, unsigned int esr);
+void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
+void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 4b3a5f050f71..e48afcb69392 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -18,6 +18,7 @@ enum mitigation_state {
 	SPECTRE_VULNERABLE,
 };
 
+struct pt_regs;
 struct task_struct;
 
 enum mitigation_state arm64_get_spectre_v2_state(void);
@@ -33,4 +34,5 @@ enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
 u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
+bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 1ab63cfbbaf1..624a608933f1 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -18,7 +18,7 @@
 
 struct pt_regs;
 
-void die(const char *msg, struct pt_regs *regs, int err);
+void die(const char *msg, struct pt_regs *regs, long err);
 
 struct siginfo;
 void arm64_notify_die(const char *str, struct pt_regs *regs,
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d96dc2c7c09d..ca8f19956b92 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -13,17 +13,16 @@
 
 struct pt_regs;
 
-struct undef_hook {
-	struct list_head node;
-	u32 instr_mask;
-	u32 instr_val;
-	u64 pstate_mask;
-	u64 pstate_val;
-	int (*fn)(struct pt_regs *regs, u32 instr);
-};
+#ifdef CONFIG_ARMV8_DEPRECATED
+bool try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn);
+#else
+static inline bool
+try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
+{
+	return false;
+}
+#endif /* CONFIG_ARMV8_DEPRECATED */
 
-void register_undef_hook(struct undef_hook *hook);
-void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address, unsigned int err);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 91b8a8378ba3..f0ba854f0045 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -17,7 +17,6 @@
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
-#include <asm/kprobes.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace-events-emulation.h"
@@ -39,226 +38,46 @@ enum insn_emulation_mode {
 enum legacy_insn_status {
 	INSN_DEPRECATED,
 	INSN_OBSOLETE,
-};
-
-struct insn_emulation_ops {
-	const char		*name;
-	enum legacy_insn_status	status;
-	struct undef_hook	*hooks;
-	int			(*set_hw_mode)(bool enable);
+	INSN_UNAVAILABLE,
 };
 
 struct insn_emulation {
-	struct list_head node;
-	struct insn_emulation_ops *ops;
+	const char			*name;
+	enum legacy_insn_status		status;
+	bool				(*try_emulate)(struct pt_regs *regs,
+						       u32 insn);
+	int				(*set_hw_mode)(bool enable);
+
 	int current_mode;
 	int min;
 	int max;
-};
-
-static LIST_HEAD(insn_emulation);
-static int nr_insn_emulated __initdata;
-static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
-static DEFINE_MUTEX(insn_emulation_mutex);
-
-static void register_emulation_hooks(struct insn_emulation_ops *ops)
-{
-	struct undef_hook *hook;
-
-	BUG_ON(!ops->hooks);
-
-	for (hook = ops->hooks; hook->instr_mask; hook++)
-		register_undef_hook(hook);
-
-	pr_notice("Registered %s emulation handler\n", ops->name);
-}
-
-static void remove_emulation_hooks(struct insn_emulation_ops *ops)
-{
-	struct undef_hook *hook;
-
-	BUG_ON(!ops->hooks);
-
-	for (hook = ops->hooks; hook->instr_mask; hook++)
-		unregister_undef_hook(hook);
-
-	pr_notice("Removed %s emulation handler\n", ops->name);
-}
-
-static void enable_insn_hw_mode(void *data)
-{
-	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->ops->set_hw_mode)
-		insn->ops->set_hw_mode(true);
-}
-
-static void disable_insn_hw_mode(void *data)
-{
-	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->ops->set_hw_mode)
-		insn->ops->set_hw_mode(false);
-}
-
-/* Run set_hw_mode(mode) on all active CPUs */
-static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
-{
-	if (!insn->ops->set_hw_mode)
-		return -EINVAL;
-	if (enable)
-		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
-	else
-		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
-	return 0;
-}
-
-/*
- * Run set_hw_mode for all insns on a starting CPU.
- * Returns:
- *  0 		- If all the hooks ran successfully.
- * -EINVAL	- At least one hook is not supported by the CPU.
- */
-static int run_all_insn_set_hw_mode(unsigned int cpu)
-{
-	int rc = 0;
-	unsigned long flags;
-	struct insn_emulation *insn;
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_for_each_entry(insn, &insn_emulation, node) {
-		bool enable = (insn->current_mode == INSN_HW);
-		if (insn->ops->set_hw_mode && insn->ops->set_hw_mode(enable)) {
-			pr_warn("CPU[%u] cannot support the emulation of %s",
-				cpu, insn->ops->name);
-			rc = -EINVAL;
-		}
-	}
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-	return rc;
-}
-
-static int update_insn_emulation_mode(struct insn_emulation *insn,
-				       enum insn_emulation_mode prev)
-{
-	int ret = 0;
-
-	switch (prev) {
-	case INSN_UNDEF: /* Nothing to be done */
-		break;
-	case INSN_EMULATE:
-		remove_emulation_hooks(insn->ops);
-		break;
-	case INSN_HW:
-		if (!run_all_cpu_set_hw_mode(insn, false))
-			pr_notice("Disabled %s support\n", insn->ops->name);
-		break;
-	}
-
-	switch (insn->current_mode) {
-	case INSN_UNDEF:
-		break;
-	case INSN_EMULATE:
-		register_emulation_hooks(insn->ops);
-		break;
-	case INSN_HW:
-		ret = run_all_cpu_set_hw_mode(insn, true);
-		if (!ret)
-			pr_notice("Enabled %s support\n", insn->ops->name);
-		break;
-	}
 
-	return ret;
-}
-
-static void __init register_insn_emulation(struct insn_emulation_ops *ops)
-{
-	unsigned long flags;
-	struct insn_emulation *insn;
-
-	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
-	if (!insn)
-		return;
-
-	insn->ops = ops;
-	insn->min = INSN_UNDEF;
-
-	switch (ops->status) {
-	case INSN_DEPRECATED:
-		insn->current_mode = INSN_EMULATE;
-		/* Disable the HW mode if it was turned on at early boot time */
-		run_all_cpu_set_hw_mode(insn, false);
-		insn->max = INSN_HW;
-		break;
-	case INSN_OBSOLETE:
-		insn->current_mode = INSN_UNDEF;
-		insn->max = INSN_EMULATE;
-		break;
-	}
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_add(&insn->node, &insn_emulation);
-	nr_insn_emulated++;
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-
-	/* Register any handlers if required */
-	update_insn_emulation_mode(insn, INSN_UNDEF);
-}
-
-static int emulation_proc_handler(struct ctl_table *table, int write,
-				  void *buffer, size_t *lenp,
-				  loff_t *ppos)
-{
-	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
-
-	mutex_lock(&insn_emulation_mutex);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	/*
+	 * sysctl for this emulation + a sentinal entry.
+	 */
+	struct ctl_table sysctl[2];
+};
 
-	if (ret || !write || prev_mode == insn->current_mode)
-		goto ret;
+#define ARM_OPCODE_CONDTEST_FAIL   0
+#define ARM_OPCODE_CONDTEST_PASS   1
+#define ARM_OPCODE_CONDTEST_UNCOND 2
 
-	ret = update_insn_emulation_mode(insn, prev_mode);
-	if (ret) {
-		/* Mode change failed, revert to previous mode. */
-		insn->current_mode = prev_mode;
-		update_insn_emulation_mode(insn, INSN_UNDEF);
-	}
-ret:
-	mutex_unlock(&insn_emulation_mutex);
-	return ret;
-}
+#define	ARM_OPCODE_CONDITION_UNCOND	0xf
 
-static void __init register_insn_emulation_sysctl(void)
+static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
 {
-	unsigned long flags;
-	int i = 0;
-	struct insn_emulation *insn;
-	struct ctl_table *insns_sysctl, *sysctl;
-
-	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
-			       GFP_KERNEL);
-	if (!insns_sysctl)
-		return;
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_for_each_entry(insn, &insn_emulation, node) {
-		sysctl = &insns_sysctl[i];
-
-		sysctl->mode = 0644;
-		sysctl->maxlen = sizeof(int);
+	u32 cc_bits  = opcode >> 28;
 
-		sysctl->procname = insn->ops->name;
-		sysctl->data = &insn->current_mode;
-		sysctl->extra1 = &insn->min;
-		sysctl->extra2 = &insn->max;
-		sysctl->proc_handler = emulation_proc_handler;
-		i++;
+	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
+		if ((*aarch32_opcode_cond_checks[cc_bits])(psr))
+			return ARM_OPCODE_CONDTEST_PASS;
+		else
+			return ARM_OPCODE_CONDTEST_FAIL;
 	}
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-
-	register_sysctl("abi", insns_sysctl);
+	return ARM_OPCODE_CONDTEST_UNCOND;
 }
 
+#ifdef CONFIG_SWP_EMULATION
 /*
  *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
  *  store-exclusive.
@@ -345,25 +164,6 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	return res;
 }
 
-#define ARM_OPCODE_CONDTEST_FAIL   0
-#define ARM_OPCODE_CONDTEST_PASS   1
-#define ARM_OPCODE_CONDTEST_UNCOND 2
-
-#define	ARM_OPCODE_CONDITION_UNCOND	0xf
-
-static unsigned int __kprobes aarch32_check_condition(u32 opcode, u32 psr)
-{
-	u32 cc_bits  = opcode >> 28;
-
-	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
-		if ((*aarch32_opcode_cond_checks[cc_bits])(psr))
-			return ARM_OPCODE_CONDTEST_PASS;
-		else
-			return ARM_OPCODE_CONDTEST_FAIL;
-	}
-	return ARM_OPCODE_CONDTEST_UNCOND;
-}
-
 /*
  * swp_handler logs the id of calling process, dissects the instruction, sanity
  * checks the memory location, calls emulate_swpX for the actual operation and
@@ -436,28 +236,27 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 	return 0;
 }
 
-/*
- * Only emulate SWP/SWPB executed in ARM state/User mode.
- * The kernel must be SWP free and SWP{B} does not exist in Thumb.
- */
-static struct undef_hook swp_hooks[] = {
-	{
-		.instr_mask	= 0x0fb00ff0,
-		.instr_val	= 0x01000090,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= swp_handler
-	},
-	{ }
-};
+static bool try_emulate_swp(struct pt_regs *regs, u32 insn)
+{
+	/* SWP{B} only exists in ARM state and does not exist in Thumb */
+	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
+		return false;
+
+	if ((insn & 0x0fb00ff0) != 0x01000090)
+		return false;
+
+	return swp_handler(regs, insn) == 0;
+}
 
-static struct insn_emulation_ops swp_ops = {
+static struct insn_emulation insn_swp = {
 	.name = "swp",
 	.status = INSN_OBSOLETE,
-	.hooks = swp_hooks,
+	.try_emulate = try_emulate_swp,
 	.set_hw_mode = NULL,
 };
+#endif /* CONFIG_SWP_EMULATION */
 
+#ifdef CONFIG_CP15_BARRIER_EMULATION
 static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
 {
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
@@ -520,31 +319,29 @@ static int cp15_barrier_set_hw_mode(bool enable)
 	return 0;
 }
 
-static struct undef_hook cp15_barrier_hooks[] = {
-	{
-		.instr_mask	= 0x0fff0fdf,
-		.instr_val	= 0x0e070f9a,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= cp15barrier_handler,
-	},
-	{
-		.instr_mask	= 0x0fff0fff,
-		.instr_val	= 0x0e070f95,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= cp15barrier_handler,
-	},
-	{ }
-};
+static bool try_emulate_cp15_barrier(struct pt_regs *regs, u32 insn)
+{
+	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
+		return false;
+
+	if ((insn & 0x0fff0fdf) == 0x0e070f9a)
+		return cp15barrier_handler(regs, insn) == 0;
+
+	if ((insn & 0x0fff0fff) == 0x0e070f95)
+		return cp15barrier_handler(regs, insn) == 0;
+
+	return false;
+}
 
-static struct insn_emulation_ops cp15_barrier_ops = {
+static struct insn_emulation insn_cp15_barrier = {
 	.name = "cp15_barrier",
 	.status = INSN_DEPRECATED,
-	.hooks = cp15_barrier_hooks,
+	.try_emulate = try_emulate_cp15_barrier,
 	.set_hw_mode = cp15_barrier_set_hw_mode,
 };
+#endif /* CONFIG_CP15_BARRIER_EMULATION */
 
+#ifdef CONFIG_SETEND_EMULATION
 static int setend_set_hw_mode(bool enable)
 {
 	if (!cpu_supports_mixed_endian_el0())
@@ -592,31 +389,221 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
 	return rc;
 }
 
-static struct undef_hook setend_hooks[] = {
-	{
-		.instr_mask	= 0xfffffdff,
-		.instr_val	= 0xf1010000,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= a32_setend_handler,
-	},
-	{
-		/* Thumb mode */
-		.instr_mask	= 0xfffffff7,
-		.instr_val	= 0x0000b650,
-		.pstate_mask	= (PSR_AA32_T_BIT | PSR_AA32_MODE_MASK),
-		.pstate_val	= (PSR_AA32_T_BIT | PSR_AA32_MODE_USR),
-		.fn		= t16_setend_handler,
-	},
-	{}
-};
+static bool try_emulate_setend(struct pt_regs *regs, u32 insn)
+{
+	if (compat_thumb_mode(regs) &&
+	    (insn & 0xfffffff7) == 0x0000b650)
+		return t16_setend_handler(regs, insn) == 0;
+
+	if (compat_user_mode(regs) &&
+	    (insn & 0xfffffdff) == 0xf1010000)
+		return a32_setend_handler(regs, insn) == 0;
+
+	return false;
+}
 
-static struct insn_emulation_ops setend_ops = {
+static struct insn_emulation insn_setend = {
 	.name = "setend",
 	.status = INSN_DEPRECATED,
-	.hooks = setend_hooks,
+	.try_emulate = try_emulate_setend,
 	.set_hw_mode = setend_set_hw_mode,
 };
+#endif /* CONFIG_SETEND_EMULATION */
+
+static struct insn_emulation *insn_emulations[] = {
+#ifdef CONFIG_SWP_EMULATION
+	&insn_swp,
+#endif
+#ifdef CONFIG_CP15_BARRIER_EMULATION
+	&insn_cp15_barrier,
+#endif
+#ifdef CONFIG_SETEND_EMULATION
+	&insn_setend,
+#endif
+};
+
+static DEFINE_MUTEX(insn_emulation_mutex);
+
+static void enable_insn_hw_mode(void *data)
+{
+	struct insn_emulation *insn = (struct insn_emulation *)data;
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(true);
+}
+
+static void disable_insn_hw_mode(void *data)
+{
+	struct insn_emulation *insn = (struct insn_emulation *)data;
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(false);
+}
+
+/* Run set_hw_mode(mode) on all active CPUs */
+static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
+{
+	if (!insn->set_hw_mode)
+		return -EINVAL;
+	if (enable)
+		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
+	else
+		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
+	return 0;
+}
+
+/*
+ * Run set_hw_mode for all insns on a starting CPU.
+ * Returns:
+ *  0 		- If all the hooks ran successfully.
+ * -EINVAL	- At least one hook is not supported by the CPU.
+ */
+static int run_all_insn_set_hw_mode(unsigned int cpu)
+{
+	int i;
+	int rc = 0;
+	unsigned long flags;
+
+	/*
+	 * Disable IRQs to serialize against an IPI from
+	 * run_all_cpu_set_hw_mode(), ensuring the HW is programmed to the most
+	 * recent enablement state if the two race with one another.
+	 */
+	local_irq_save(flags);
+	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
+		struct insn_emulation *insn = insn_emulations[i];
+		bool enable = READ_ONCE(insn->current_mode) == INSN_HW;
+		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
+			pr_warn("CPU[%u] cannot support the emulation of %s",
+				cpu, insn->name);
+			rc = -EINVAL;
+		}
+	}
+	local_irq_restore(flags);
+
+	return rc;
+}
+
+static int update_insn_emulation_mode(struct insn_emulation *insn,
+				       enum insn_emulation_mode prev)
+{
+	int ret = 0;
+
+	switch (prev) {
+	case INSN_UNDEF: /* Nothing to be done */
+		break;
+	case INSN_EMULATE:
+		break;
+	case INSN_HW:
+		if (!run_all_cpu_set_hw_mode(insn, false))
+			pr_notice("Disabled %s support\n", insn->name);
+		break;
+	}
+
+	switch (insn->current_mode) {
+	case INSN_UNDEF:
+		break;
+	case INSN_EMULATE:
+		break;
+	case INSN_HW:
+		ret = run_all_cpu_set_hw_mode(insn, true);
+		if (!ret)
+			pr_notice("Enabled %s support\n", insn->name);
+		break;
+	}
+
+	return ret;
+}
+
+static int emulation_proc_handler(struct ctl_table *table, int write,
+				  void *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	int ret = 0;
+	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
+	enum insn_emulation_mode prev_mode = insn->current_mode;
+
+	mutex_lock(&insn_emulation_mutex);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write || prev_mode == insn->current_mode)
+		goto ret;
+
+	ret = update_insn_emulation_mode(insn, prev_mode);
+	if (ret) {
+		/* Mode change failed, revert to previous mode. */
+		WRITE_ONCE(insn->current_mode, prev_mode);
+		update_insn_emulation_mode(insn, INSN_UNDEF);
+	}
+ret:
+	mutex_unlock(&insn_emulation_mutex);
+	return ret;
+}
+
+static void __init register_insn_emulation(struct insn_emulation *insn)
+{
+	struct ctl_table *sysctl;
+
+	insn->min = INSN_UNDEF;
+
+	switch (insn->status) {
+	case INSN_DEPRECATED:
+		insn->current_mode = INSN_EMULATE;
+		/* Disable the HW mode if it was turned on at early boot time */
+		run_all_cpu_set_hw_mode(insn, false);
+		insn->max = INSN_HW;
+		break;
+	case INSN_OBSOLETE:
+		insn->current_mode = INSN_UNDEF;
+		insn->max = INSN_EMULATE;
+		break;
+	case INSN_UNAVAILABLE:
+		insn->current_mode = INSN_UNDEF;
+		insn->max = INSN_UNDEF;
+		break;
+	}
+
+	/* Program the HW if required */
+	update_insn_emulation_mode(insn, INSN_UNDEF);
+
+	if (insn->status != INSN_UNAVAILABLE) {
+		sysctl = &insn->sysctl[0];
+
+		sysctl->mode = 0644;
+		sysctl->maxlen = sizeof(int);
+
+		sysctl->procname = insn->name;
+		sysctl->data = &insn->current_mode;
+		sysctl->extra1 = &insn->min;
+		sysctl->extra2 = &insn->max;
+		sysctl->proc_handler = emulation_proc_handler;
+
+		register_sysctl("abi", sysctl);
+	}
+}
+
+bool try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
+		struct insn_emulation *ie = insn_emulations[i];
+
+		if (ie->status == INSN_UNAVAILABLE)
+			continue;
+
+		/*
+		 * A trap may race with the mode being changed
+		 * INSN_EMULATE<->INSN_HW. Try to emulate the instruction to
+		 * avoid a spurious UNDEF.
+		 */
+		if (READ_ONCE(ie->current_mode) == INSN_UNDEF)
+			continue;
+
+		if (ie->try_emulate(regs, insn))
+			return true;
+	}
+
+	return false;
+}
 
 /*
  * Invoked as core_initcall, which guarantees that the instruction
@@ -624,24 +611,27 @@ static struct insn_emulation_ops setend_ops = {
  */
 static int __init armv8_deprecated_init(void)
 {
-	if (IS_ENABLED(CONFIG_SWP_EMULATION))
-		register_insn_emulation(&swp_ops);
+	int i;
 
-	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
-		register_insn_emulation(&cp15_barrier_ops);
+#ifdef CONFIG_SETEND_EMULATION
+	if (!system_supports_mixed_endian_el0()) {
+		insn_setend.status = INSN_UNAVAILABLE;
+		pr_info("setend instruction emulation is not supported on this system\n");
+	}
 
-	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
-		if (system_supports_mixed_endian_el0())
-			register_insn_emulation(&setend_ops);
-		else
-			pr_info("setend instruction emulation is not supported on this system\n");
+#endif
+	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
+		struct insn_emulation *ie = insn_emulations[i];
+
+		if (ie->status == INSN_UNAVAILABLE)
+			continue;
+
+		register_insn_emulation(ie);
 	}
 
 	cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
 				  "arm64/isndep:starting",
 				  run_all_insn_set_hw_mode, NULL);
-	register_insn_emulation_sysctl();
-
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f3767c144593..1f0a2deafd64 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2852,35 +2852,22 @@ int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt)
 	return rc;
 }
 
-static int emulate_mrs(struct pt_regs *regs, u32 insn)
+bool try_emulate_mrs(struct pt_regs *regs, u32 insn)
 {
 	u32 sys_reg, rt;
 
+	if (compat_user_mode(regs) || !aarch64_insn_is_mrs(insn))
+		return false;
+
 	/*
 	 * sys_reg values are defined as used in mrs/msr instruction.
 	 * shift the imm value to get the encoding.
 	 */
 	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
 	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
-	return do_emulate_mrs(regs, sys_reg, rt);
+	return do_emulate_mrs(regs, sys_reg, rt) == 0;
 }
 
-static struct undef_hook mrs_hook = {
-	.instr_mask = 0xfff00000,
-	.instr_val  = 0xd5300000,
-	.pstate_mask = PSR_AA32_MODE_MASK,
-	.pstate_val = PSR_MODE_EL0t,
-	.fn = emulate_mrs,
-};
-
-static int __init enable_mrs_emulation(void)
-{
-	register_undef_hook(&mrs_hook);
-	return 0;
-}
-
-core_initcall(enable_mrs_emulation);
-
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ec120ed18faf..7a8cd856ee85 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -132,11 +132,20 @@ static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
 	exit_to_kernel_mode(regs);
 }
 
-static void noinstr el1_undef(struct pt_regs *regs)
+static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_undefinstr(regs);
+	do_el1_undef(regs, esr);
+	local_daif_mask();
+	exit_to_kernel_mode(regs);
+}
+
+static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_kernel_mode(regs);
+	local_daif_inherit(regs);
+	do_el1_bti(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -187,7 +196,7 @@ static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_ptrauth_fault(regs, esr);
+	do_el1_fpac(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -210,7 +219,10 @@ asmlinkage void noinstr el1_sync_handler(struct pt_regs *regs)
 		break;
 	case ESR_ELx_EC_SYS64:
 	case ESR_ELx_EC_UNKNOWN:
-		el1_undef(regs);
+		el1_undef(regs, esr);
+		break;
+	case ESR_ELx_EC_BTI:
+		el1_bti(regs, esr);
 		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
@@ -294,7 +306,7 @@ static void noinstr el0_sys(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_sysinstr(esr, regs);
+	do_el0_sys(esr, regs);
 }
 
 static void noinstr el0_pc(struct pt_regs *regs, unsigned long esr)
@@ -316,18 +328,18 @@ static void noinstr el0_sp(struct pt_regs *regs, unsigned long esr)
 	do_sp_pc_abort(regs->sp, esr, regs);
 }
 
-static void noinstr el0_undef(struct pt_regs *regs)
+static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_undefinstr(regs);
+	do_el0_undef(regs, esr);
 }
 
 static void noinstr el0_bti(struct pt_regs *regs)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_bti(regs);
+	do_el0_bti(regs);
 }
 
 static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
@@ -357,7 +369,7 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_ptrauth_fault(regs, esr);
+	do_el0_fpac(regs, esr);
 }
 
 asmlinkage void noinstr el0_sync_handler(struct pt_regs *regs)
@@ -394,7 +406,7 @@ asmlinkage void noinstr el0_sync_handler(struct pt_regs *regs)
 		el0_pc(regs, esr);
 		break;
 	case ESR_ELx_EC_UNKNOWN:
-		el0_undef(regs);
+		el0_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_BTI:
 		el0_bti(regs);
@@ -418,7 +430,7 @@ static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_cp15instr(esr, regs);
+	do_el0_cp15(esr, regs);
 }
 
 static void noinstr el0_svc_compat(struct pt_regs *regs)
@@ -454,7 +466,7 @@ asmlinkage void noinstr el0_sync_compat_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_CP14_MR:
 	case ESR_ELx_EC_CP14_LS:
 	case ESR_ELx_EC_CP14_64:
-		el0_undef(regs);
+		el0_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_CP15_32:
 	case ESR_ELx_EC_CP15_64:
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index faa8a6bf2376..9c0e9d9eed6e 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -537,10 +537,13 @@ bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope)
 	return state != SPECTRE_UNAFFECTED;
 }
 
-static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
+bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr)
 {
-	if (user_mode(regs))
-		return 1;
+	const u32 instr_mask = ~(1U << PSTATE_Imm_shift);
+	const u32 instr_val = 0xd500401f | PSTATE_SSBS;
+
+	if ((instr & instr_mask) != instr_val)
+		return false;
 
 	if (instr & BIT(PSTATE_Imm_shift))
 		regs->pstate |= PSR_SSBS_BIT;
@@ -548,19 +551,11 @@ static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
 		regs->pstate &= ~PSR_SSBS_BIT;
 
 	arm64_skip_faulting_instruction(regs, 4);
-	return 0;
+	return true;
 }
 
-static struct undef_hook ssbs_emulation_hook = {
-	.instr_mask	= ~(1U << PSTATE_Imm_shift),
-	.instr_val	= 0xd500401f | PSTATE_SSBS,
-	.fn		= ssbs_emulation_handler,
-};
-
 static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 {
-	static bool undef_hook_registered = false;
-	static DEFINE_RAW_SPINLOCK(hook_lock);
 	enum mitigation_state state;
 
 	/*
@@ -571,13 +566,6 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 	if (state != SPECTRE_MITIGATED || !this_cpu_has_cap(ARM64_SSBS))
 		return state;
 
-	raw_spin_lock(&hook_lock);
-	if (!undef_hook_registered) {
-		register_undef_hook(&ssbs_emulation_hook);
-		undef_hook_registered = true;
-	}
-	raw_spin_unlock(&hook_lock);
-
 	if (spectre_v4_mitigations_off()) {
 		sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_DSSBS);
 		asm volatile(SET_PSTATE_SSBS(1));
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 2cdd53425509..10a58017d024 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -90,12 +90,12 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 
 #define S_SMP " SMP"
 
-static int __die(const char *str, int err, struct pt_regs *regs)
+static int __die(const char *str, long err, struct pt_regs *regs)
 {
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
+	pr_emerg("Internal error: %s: %016lx [#%d]" S_PREEMPT S_SMP "\n",
 		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
@@ -116,7 +116,7 @@ static DEFINE_RAW_SPINLOCK(die_lock);
 /*
  * This function is protected against re-entrancy.
  */
-void die(const char *str, struct pt_regs *regs, int err)
+void die(const char *str, struct pt_regs *regs, long err)
 {
 	int ret;
 	unsigned long flags;
@@ -282,51 +282,22 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 		regs->pstate &= ~PSR_BTYPE_MASK;
 }
 
-static LIST_HEAD(undef_hook);
-static DEFINE_RAW_SPINLOCK(undef_lock);
-
-void register_undef_hook(struct undef_hook *hook)
+static int user_insn_read(struct pt_regs *regs, u32 *insnp)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&undef_lock, flags);
-	list_add(&hook->node, &undef_hook);
-	raw_spin_unlock_irqrestore(&undef_lock, flags);
-}
-
-void unregister_undef_hook(struct undef_hook *hook)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&undef_lock, flags);
-	list_del(&hook->node);
-	raw_spin_unlock_irqrestore(&undef_lock, flags);
-}
-
-static int call_undef_hook(struct pt_regs *regs)
-{
-	struct undef_hook *hook;
-	unsigned long flags;
 	u32 instr;
-	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
-	if (!user_mode(regs)) {
-		__le32 instr_le;
-		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
-			goto exit;
-		instr = le32_to_cpu(instr_le);
-	} else if (compat_thumb_mode(regs)) {
+	if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le16_to_cpu(instr_le);
 		if (aarch32_insn_is_wide(instr)) {
 			u32 instr2;
 
 			if (get_user(instr_le, (__le16 __user *)(pc + 2)))
-				goto exit;
+				return -EFAULT;
 			instr2 = le16_to_cpu(instr_le);
 			instr = (instr << 16) | instr2;
 		}
@@ -334,19 +305,12 @@ static int call_undef_hook(struct pt_regs *regs)
 		/* 32-bit ARM instruction */
 		__le32 instr_le;
 		if (get_user(instr_le, (__le32 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le32_to_cpu(instr_le);
 	}
 
-	raw_spin_lock_irqsave(&undef_lock, flags);
-	list_for_each_entry(hook, &undef_hook, node)
-		if ((instr & hook->instr_mask) == hook->instr_val &&
-			(regs->pstate & hook->pstate_mask) == hook->pstate_val)
-			fn = hook->fn;
-
-	raw_spin_unlock_irqrestore(&undef_lock, flags);
-exit:
-	return fn ? fn(regs, instr) : 1;
+	*insnp = instr;
+	return 0;
 }
 
 void force_signal_inject(int signal, int code, unsigned long address, unsigned int err)
@@ -395,37 +359,64 @@ void arm64_notify_segfault(unsigned long addr)
 	force_signal_inject(SIGSEGV, code, addr, 0);
 }
 
-void do_undefinstr(struct pt_regs *regs)
+void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
+	u32 insn;
+
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
 		return;
 
-	if (call_undef_hook(regs) == 0)
+	if (user_insn_read(regs, &insn))
+		goto out_err;
+
+	if (try_emulate_mrs(regs, insn))
+		return;
+
+	if (try_emulate_armv8_deprecated(regs, insn))
 		return;
 
-	BUG_ON(!user_mode(regs));
+out_err:
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_undefinstr);
 
-void do_bti(struct pt_regs *regs)
+void do_el1_undef(struct pt_regs *regs, unsigned long esr)
+{
+	u32 insn;
+
+	if (aarch64_insn_read((void *)regs->pc, &insn))
+		goto out_err;
+
+	if (try_emulate_el1_ssbs(regs, insn))
+		return;
+
+out_err:
+	die("Oops - Undefined instruction", regs, esr);
+}
+
+void do_el0_bti(struct pt_regs *regs)
 {
-	BUG_ON(!user_mode(regs));
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_bti);
 
-void do_ptrauth_fault(struct pt_regs *regs, unsigned int esr)
+void do_el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	die("Oops - BTI", regs, esr);
+}
+
+void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
+{
+	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
+}
+
+void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	/*
-	 * Unexpected FPAC exception or pointer authentication failure in
-	 * the kernel: kill the task before it does any more harm.
+	 * Unexpected FPAC exception in the kernel: kill the task before it
+	 * does any more harm.
 	 */
-	BUG_ON(!user_mode(regs));
-	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
+	die("Oops - FPAC", regs, esr);
 }
-NOKPROBE_SYMBOL(do_ptrauth_fault);
 
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
@@ -640,7 +631,7 @@ static const struct sys64_hook cp15_64_hooks[] = {
 	{},
 };
 
-void do_cp15instr(unsigned int esr, struct pt_regs *regs)
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook, *hook_base;
 
@@ -661,7 +652,7 @@ void do_cp15instr(unsigned int esr, struct pt_regs *regs)
 		hook_base = cp15_64_hooks;
 		break;
 	default:
-		do_undefinstr(regs);
+		do_el0_undef(regs, esr);
 		return;
 	}
 
@@ -676,12 +667,11 @@ void do_cp15instr(unsigned int esr, struct pt_regs *regs)
 	 * EL0. Fall back to our usual undefined instruction handler
 	 * so that we handle these consistently.
 	 */
-	do_undefinstr(regs);
+	do_el0_undef(regs, esr);
 }
-NOKPROBE_SYMBOL(do_cp15instr);
 #endif
 
-void do_sysinstr(unsigned int esr, struct pt_regs *regs)
+void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook;
 
@@ -696,9 +686,8 @@ void do_sysinstr(unsigned int esr, struct pt_regs *regs)
 	 * back to our usual undefined instruction handler so that we handle
 	 * these consistently.
 	 */
-	do_undefinstr(regs);
+	do_el0_undef(regs, esr);
 }
-NOKPROBE_SYMBOL(do_sysinstr);
 
 static const char *esr_class_str[] = {
 	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
@@ -899,7 +888,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 {
 	switch (report_bug(regs->pc, regs)) {
 	case BUG_TRAP_TYPE_BUG:
-		die("Oops - BUG", regs, 0);
+		die("Oops - BUG", regs, esr);
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
@@ -967,7 +956,7 @@ static int kasan_handler(struct pt_regs *regs, unsigned int esr)
 	 * This is something that might be fixed at some point in the future.
 	 */
 	if (!recover)
-		die("Oops - KASAN", regs, 0);
+		die("Oops - KASAN", regs, esr);
 
 	/* If thread survives, skip over the brk instruction and continue: */
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1581204467e1..2b06da0ffd2d 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -94,6 +94,13 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 #define pte_wrprotect pte_wrprotect
 
+static inline int pte_read(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_RO) != _PAGE_NA;
+}
+
+#define pte_read pte_read
+
 static inline int pte_write(pte_t pte)
 {
 	return !(pte_val(pte) & _PAGE_RO);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index a4d475c0fc2c..6075fac88286 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -216,7 +216,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if (pte_young(*ptep))
+	if (!pte_young(*ptep))
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index ac75f4ab0dba..7ad1d1b042a6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -45,7 +45,9 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_RW;
 }
 #endif
+#ifndef pte_read
 static inline int pte_read(pte_t pte)		{ return 1; }
+#endif
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 053dc83e323b..0cc3dd9d32e6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -201,7 +201,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
+		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? 4 : 0, /* skip TCC init */
 		  ctx);
@@ -394,12 +394,12 @@ static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
 	*rd = RV_REG_T2;
 }
 
-static int emit_jump_and_link(u8 rd, s64 rvoff, bool force_jalr,
+static int emit_jump_and_link(u8 rd, s64 rvoff, bool fixed_addr,
 			      struct rv_jit_context *ctx)
 {
 	s64 upper, lower;
 
-	if (rvoff && is_21b_int(rvoff) && !force_jalr) {
+	if (rvoff && fixed_addr && is_21b_int(rvoff)) {
 		emit(rv_jal(rd, rvoff >> 1), ctx);
 		return 0;
 	} else if (in_auipc_jalr_range(rvoff)) {
@@ -420,24 +420,17 @@ static bool is_signed_bpf_cond(u8 cond)
 		cond == BPF_JSGE || cond == BPF_JSLE;
 }
 
-static int emit_call(bool fixed, u64 addr, struct rv_jit_context *ctx)
+static int emit_call(u64 addr, bool fixed_addr, struct rv_jit_context *ctx)
 {
 	s64 off = 0;
 	u64 ip;
-	u8 rd;
-	int ret;
 
 	if (addr && ctx->insns) {
 		ip = (u64)(long)(ctx->insns + ctx->ninsns);
 		off = addr - ip;
 	}
 
-	ret = emit_jump_and_link(RV_REG_RA, off, !fixed, ctx);
-	if (ret)
-		return ret;
-	rd = bpf_to_rv_reg(BPF_REG_0, ctx);
-	emit_mv(rd, RV_REG_A0, ctx);
-	return 0;
+	return emit_jump_and_link(RV_REG_RA, off, fixed_addr, ctx);
 }
 
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
@@ -731,7 +724,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
 		rvoff = rv_offset(i, off, ctx);
-		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
+		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, true, ctx);
 		if (ret)
 			return ret;
 		break;
@@ -850,17 +843,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		bool fixed;
+		bool fixed_addr;
 		u64 addr;
 
 		mark_call(ctx);
-		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass, &addr,
-					    &fixed);
+		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
+					    &addr, &fixed_addr);
 		if (ret < 0)
 			return ret;
-		ret = emit_call(fixed, addr, ctx);
+
+		ret = emit_call(addr, fixed_addr, ctx);
 		if (ret)
 			return ret;
+
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
@@ -875,7 +872,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 
 		rvoff = epilogue_offset(ctx);
-		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
+		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, true, ctx);
 		if (ret)
 			return ret;
 		break;
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index ebc9a49523aa..f6690a7003c6 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -541,6 +541,17 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		s->dma_length = 0;
 	}
 }
+
+static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
+{
+	size_t n = BITS_TO_LONGS(bits);
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
+		return NULL;
+
+	return vzalloc(bytes);
+}
 	
 int zpci_dma_init_device(struct zpci_dev *zdev)
 {
@@ -577,13 +588,13 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 				zdev->end_dma - zdev->start_dma + 1);
 	zdev->end_dma = zdev->start_dma + zdev->iommu_size - 1;
 	zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;
-	zdev->iommu_bitmap = vzalloc(zdev->iommu_pages / 8);
+	zdev->iommu_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 	if (!zdev->iommu_bitmap) {
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
 	if (!s390_iommu_strict) {
-		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
+		zdev->lazy_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
 			goto free_bitmap;
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 27826c265aab..e23748fa2d5f 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -106,6 +106,16 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	return ES_OK;
 }
 
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	return ES_OK;
+}
+
+static bool fault_in_kernel_space(unsigned long address)
+{
+	return false;
+}
+
 #undef __init
 #undef __pa
 #define __init
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 202a52e42a36..8465fc8ffd99 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -541,12 +541,17 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
-/* Fam 17h MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
+/* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
 #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
 
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e6e63a9d27cb..d58621f0fe51 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -424,6 +424,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK("alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -491,6 +502,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 next:
 		optimize_nops(instr, a->instrlen);
 	}
+
+	kasan_enable_current();
 }
 
 #if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2bc1c78a7cc5..d254e02aa179 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -81,6 +81,10 @@ static const int amd_div0[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1178,6 +1182,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
 	}
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 82db4014deb2..e9f8a2bc5de9 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -217,6 +217,23 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 		asm volatile("hlt\n");
 }
 
+static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
+					   unsigned long address,
+					   bool write)
+{
+	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_USER;
+		ctxt->fi.cr2        = address;
+		if (write)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return ES_EXCEPTION;
+	}
+
+	return ES_OK;
+}
+
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
 					  void *src, char *buf,
 					  unsigned int data_size,
@@ -224,7 +241,12 @@ static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
 					  bool backwards)
 {
 	int i, b = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
+	unsigned long address = (unsigned long)src;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, false);
+	if (ret != ES_OK)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		void *s = src + (i * data_size * b);
@@ -245,7 +267,12 @@ static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
 					   bool backwards)
 {
 	int i, s = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
+	unsigned long address = (unsigned long)dst;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, true);
+	if (ret != ES_OK)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		void *d = dst + (i * data_size * s);
@@ -281,6 +308,9 @@ static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
 static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 {
 	struct insn *insn = &ctxt->insn;
+	size_t size;
+	u64 port;
+
 	*exitinfo = 0;
 
 	switch (insn->opcode.bytes[0]) {
@@ -289,7 +319,7 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0x6d:
 		*exitinfo |= IOIO_TYPE_INS;
 		*exitinfo |= IOIO_SEG_ES;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* OUTS opcodes */
@@ -297,41 +327,43 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0x6f:
 		*exitinfo |= IOIO_TYPE_OUTS;
 		*exitinfo |= IOIO_SEG_DS;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* IN immediate opcodes */
 	case 0xe4:
 	case 0xe5:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u8)insn->immediate.value << 16;
+		port	   = (u8)insn->immediate.value & 0xffff;
 		break;
 
 	/* OUT immediate opcodes */
 	case 0xe6:
 	case 0xe7:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u8)insn->immediate.value << 16;
+		port	   = (u8)insn->immediate.value & 0xffff;
 		break;
 
 	/* IN register opcodes */
 	case 0xec:
 	case 0xed:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* OUT register opcodes */
 	case 0xee:
 	case 0xef:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	default:
 		return ES_DECODE_FAILED;
 	}
 
+	*exitinfo |= port << 16;
+
 	switch (insn->opcode.bytes[0]) {
 	case 0x6c:
 	case 0x6e:
@@ -341,12 +373,15 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0xee:
 		/* Single byte opcodes */
 		*exitinfo |= IOIO_DATA_8;
+		size       = 1;
 		break;
 	default:
 		/* Length determined by instruction parsing */
 		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
 						     : IOIO_DATA_32;
+		size       = (insn->opnd_bytes == 2) ? 2 : 4;
 	}
+
 	switch (insn->addr_bytes) {
 	case 2:
 		*exitinfo |= IOIO_ADDR_16;
@@ -362,7 +397,7 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	if (insn_has_rep_prefix(insn))
 		*exitinfo |= IOIO_REP;
 
-	return ES_OK;
+	return vc_ioio_check(ctxt, (u16)port, size);
 }
 
 static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index f441002c2327..b6f9fe0d6173 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -448,6 +448,33 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_OK;
 }
 
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	BUG_ON(size > 4);
+
+	if (user_mode(ctxt->regs)) {
+		struct thread_struct *t = &current->thread;
+		struct io_bitmap *iobm = t->io_bitmap;
+		size_t idx;
+
+		if (!iobm)
+			goto fault;
+
+		for (idx = port; idx < port + size; ++idx) {
+			if (test_bit(idx, iobm->bitmap))
+				goto fault;
+		}
+	}
+
+	return ES_OK;
+
+fault:
+	ctxt->fi.vector = X86_TRAP_GP;
+	ctxt->fi.error_code = 0;
+
+	return ES_EXCEPTION;
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
@@ -970,6 +997,9 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
 	enum es_result ret;
 	long *reg_data;
 
+	if (user_mode(ctxt->regs))
+		return ES_UNSUPPORTED;
+
 	switch (insn->opcode.bytes[0]) {
 	/* MMIO Write */
 	case 0x88:
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 21189804524a..a40408895e23 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2397,13 +2397,17 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 {
 	u32 reg = kvm_lapic_get_reg(apic, lvt_type);
 	int vector, mode, trig_mode;
+	int r;
 
 	if (kvm_apic_hw_enabled(apic) && !(reg & APIC_LVT_MASKED)) {
 		vector = reg & APIC_VECTOR_MASK;
 		mode = reg & APIC_MODE_MASK;
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
-		return __apic_accept_irq(apic, mode, vector, 1, trig_mode,
-					NULL);
+
+		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
+		if (r && lvt_type == APIC_LVTPC)
+			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
+		return r;
 	}
 	return 0;
 }
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index e209081d644b..6a9490ad78ce 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -52,6 +52,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	unsigned int irq;
 
 	if (WARN_ON(!acpi_gsi_domain_id)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
@@ -63,7 +64,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
-	return irq_create_fwspec_mapping(&fwspec);
+	irq = irq_create_fwspec_mapping(&fwspec);
+	if (!irq)
+		return -EINVAL;
+
+	return irq;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index f2f5f1dc7c61..bfd821173f86 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
@@ -380,21 +381,117 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
+static const struct dmi_system_id medion_laptop[] = {
+	{
+		.ident = "MEDION P15651",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
+		},
+	},
+	{ }
+};
+
+static const struct dmi_system_id asus_laptop[] = {
+	{
+		.ident = "Asus Vivobook K3402ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
+		},
+	},
+	{
+		.ident = "Asus Vivobook K3502ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
+		},
+	},
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
+		.ident = "Asus ExpertBook B1402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
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
+	{ }
+};
+
+struct irq_override_cmp {
+	const struct dmi_system_id *system;
+	unsigned char irq;
+	unsigned char triggering;
+	unsigned char polarity;
+	unsigned char shareable;
+};
+
+static const struct irq_override_cmp skip_override_table[] = {
+	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+};
+
+static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
+				  u8 shareable)
 {
-	res->start = gsi;
-	res->end = gsi;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
+		const struct irq_override_cmp *entry = &skip_override_table[i];
+
+		if (dmi_check_system(entry->system) &&
+		    entry->irq == gsi &&
+		    entry->triggering == triggering &&
+		    entry->polarity == polarity &&
+		    entry->shareable == shareable)
+			return false;
+	}
+
+	return true;
 }
 
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
-				     bool legacy)
+				     bool check_override)
 {
 	int irq, p, t;
 
 	if (!valid_IRQ(gsi)) {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 		return;
 	}
 
@@ -408,7 +505,9 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	 * using extended IRQ descriptors we take the IRQ configuration
 	 * from _CRS directly.
 	 */
-	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
+	if (check_override &&
+	    acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
+	    !acpi_get_override_irq(gsi, &t, &p)) {
 		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
@@ -426,7 +525,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		res->start = irq;
 		res->end = irq;
 	} else {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 	}
 }
 
@@ -463,7 +562,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		 */
 		irq = &ares->data.irq;
 		if (index >= irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
@@ -473,7 +572,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
 		if (index >= ext_irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		if (is_gsi(ext_irq))
@@ -481,7 +580,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->shareable, false);
 		else
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5fb3eda0a280..2308c2be85a1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2224,7 +2224,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_queued_cmd *qc;
 	const char *frozen, *desc;
-	char tries_buf[6] = "";
+	char tries_buf[16] = "";
 	int tag, nr_failed = 0;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 55a30afc14a0..3edff8606ac9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1511,7 +1511,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return !strcmp((*r)->name, data);
+		return (*r)->name && !strcmp((*r)->name, data);
 	else
 		return 1;
 }
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8469f9876dd2..31d70bad83d2 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -67,7 +67,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
+	mutex_unlock(&data->open_mutex);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 85fbbac06d31..6f17644b6e0b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -111,7 +111,7 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
 		priv->qdec_mode = 0;
 		/* Set highest rate based on whether soc has gclk or not */
 		bmr &= ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
-		if (priv->tc_cfg->has_gclk)
+		if (!priv->tc_cfg->has_gclk)
 			cmr |= ATMEL_TC_TIMER_CLOCK2;
 		else
 			cmr |= ATMEL_TC_TIMER_CLOCK1;
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index a1517ef1f4a0..0acf6a92a4ad 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -451,9 +451,8 @@ static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
 	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_CLR_B);
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
 
-	synchronize_irq(c->irq);
-
 	spin_unlock_irqrestore(&c->vc.lock, flags);
+	synchronize_irq(c->irq);
 
 	return 0;
 }
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 9d54746c422c..3e57176ca0ca 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1206,6 +1206,10 @@ static int stm32_mdma_resume(struct dma_chan *c)
 	unsigned long flags;
 	u32 status, reg;
 
+	/* Transfer can be terminated */
+	if (!chan->desc || (stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & STM32_MDMA_CCR_EN))
+		return -EPERM;
+
 	hwdesc = chan->desc->node[chan->curr_hwdesc].hwdesc;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index de14949a3fe5..92c1f2baa4bf 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -43,9 +43,10 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 	unsigned offset, bool enabled)
 {
 	struct timbgpio *tgpio = gpiochip_get_data(gpio);
+	unsigned long flags;
 	u32 reg;
 
-	spin_lock(&tgpio->lock);
+	spin_lock_irqsave(&tgpio->lock, flags);
 	reg = ioread32(tgpio->membase + offset);
 
 	if (enabled)
@@ -54,7 +55,7 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 		reg &= ~(1 << index);
 
 	iowrite32(reg, tgpio->membase + offset);
-	spin_unlock(&tgpio->lock);
+	spin_unlock_irqrestore(&tgpio->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 396a687e020f..c2c38f13801f 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -127,14 +127,14 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
+	vf610_gpio_set(chip, gpio, value);
+
 	if (port->sdata && port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	vf610_gpio_set(chip, gpio, value);
-
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 099542dd3154..36a9e9c84ed4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -862,12 +862,19 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
+		// only looking for first odm pipe
+		if (pipe->prev_odm_pipe)
+			continue;
+
 		if (stream->link->local_sink &&
 			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 			link = stream->link;
 		}
 
-		if (link != NULL) {
+		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			unsigned int enc_inst, tg_inst = 0;
 			unsigned int pix_clk_100hz;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 9c3bbe2c3e6f..c4ed4f1b369c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -64,6 +64,14 @@
  * support can instead use e.g. drm_helper_hpd_irq_event().
  */
 
+/*
+ * Global connector list for drm_connector_find_by_fwnode().
+ * Note drm_connector_[un]register() first take connector->lock and then
+ * take the connector_list_lock.
+ */
+static DEFINE_MUTEX(connector_list_lock);
+static LIST_HEAD(connector_list);
+
 struct drm_conn_prop_enum_list {
 	int type;
 	const char *name;
@@ -265,6 +273,7 @@ int drm_connector_init(struct drm_device *dev,
 		goto out_put_type_id;
 	}
 
+	INIT_LIST_HEAD(&connector->global_connector_list_entry);
 	INIT_LIST_HEAD(&connector->probed_modes);
 	INIT_LIST_HEAD(&connector->modes);
 	mutex_init(&connector->mutex);
@@ -471,6 +480,8 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	drm_mode_object_unregister(dev, &connector->base);
 	kfree(connector->name);
 	connector->name = NULL;
+	fwnode_handle_put(connector->fwnode);
+	connector->fwnode = NULL;
 	spin_lock_irq(&dev->mode_config.connector_list_lock);
 	list_del(&connector->head);
 	dev->mode_config.num_connector--;
@@ -532,6 +543,9 @@ int drm_connector_register(struct drm_connector *connector)
 	/* Let userspace know we have a new connector */
 	drm_sysfs_hotplug_event(connector->dev);
 
+	mutex_lock(&connector_list_lock);
+	list_add_tail(&connector->global_connector_list_entry, &connector_list);
+	mutex_unlock(&connector_list_lock);
 	goto unlock;
 
 err_debugfs:
@@ -560,6 +574,10 @@ void drm_connector_unregister(struct drm_connector *connector)
 		return;
 	}
 
+	mutex_lock(&connector_list_lock);
+	list_del_init(&connector->global_connector_list_entry);
+	mutex_unlock(&connector_list_lock);
+
 	if (connector->funcs->early_unregister)
 		connector->funcs->early_unregister(connector);
 
@@ -2462,6 +2480,67 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 	return ret;
 }
 
+/**
+ * drm_connector_find_by_fwnode - Find a connector based on the associated fwnode
+ * @fwnode: fwnode for which to find the matching drm_connector
+ *
+ * This functions looks up a drm_connector based on its associated fwnode. When
+ * a connector is found a reference to the connector is returned. The caller must
+ * call drm_connector_put() to release this reference when it is done with the
+ * connector.
+ *
+ * Returns: A reference to the found connector or an ERR_PTR().
+ */
+struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct drm_connector *connector, *found = ERR_PTR(-ENODEV);
+
+	if (!fwnode)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&connector_list_lock);
+
+	list_for_each_entry(connector, &connector_list, global_connector_list_entry) {
+		if (connector->fwnode == fwnode ||
+		    (connector->fwnode && connector->fwnode->secondary == fwnode)) {
+			drm_connector_get(connector);
+			found = connector;
+			break;
+		}
+	}
+
+	mutex_unlock(&connector_list_lock);
+
+	return found;
+}
+
+/**
+ * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
+ * @connector: connector to report the event on
+ *
+ * On some hardware a hotplug event notification may come from outside the display
+ * driver / device. An example of this is some USB Type-C setups where the hardware
+ * muxes the DisplayPort data and aux-lines but does not pass the altmode HPD
+ * status bit to the GPU's DP HPD pin.
+ *
+ * This function can be used to report these out-of-band events after obtaining
+ * a drm_connector reference through calling drm_connector_find_by_fwnode().
+ */
+void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
+{
+	struct drm_connector *connector;
+
+	connector = drm_connector_find_by_fwnode(connector_fwnode);
+	if (IS_ERR(connector))
+		return;
+
+	if (connector->funcs->oob_hotplug_event)
+		connector->funcs->oob_hotplug_event(connector);
+
+	drm_connector_put(connector);
+}
+EXPORT_SYMBOL(drm_connector_oob_hotplug_event);
+
 
 /**
  * DOC: Tile group
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index da96b2f64d7e..c3577eaee416 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -57,6 +57,7 @@ struct drm_property;
 struct edid;
 struct kref;
 struct work_struct;
+struct fwnode_handle;
 
 /* drm_crtc.c */
 int drm_mode_crtc_set_obj_prop(struct drm_mode_object *obj,
@@ -182,6 +183,7 @@ int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 int drm_connector_create_standard_properties(struct drm_device *dev);
 const char *drm_get_connector_force_name(enum drm_connector_force force);
 void drm_connector_free_work_fn(struct work_struct *work);
+struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode);
 
 /* IOCTL */
 int drm_connector_property_set_ioctl(struct drm_device *dev,
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 6106fa7c4302..43de9dfcba19 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -44,6 +44,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
+	.width = 1200,
+	.height = 1920,
+	.bios_dates = (const char * const []){ "05/21/2018", "10/26/2018",
+		"03/04/2019", NULL },
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data gpd_pocket = {
 	.width = 1200,
 	.height = 1920,
@@ -329,6 +337,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* One Mix 2S (generic strings, also match on bios date) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+		},
+		.driver_data = (void *)&gpd_onemix2s,
 	},
 	{}
 };
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index f0336c804639..71a0d9596efe 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -10,6 +10,7 @@
  * Copyright (c) 2003-2004 IBM Corp.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -50,8 +51,45 @@ static struct device_type drm_sysfs_device_minor = {
 	.name = "drm_minor"
 };
 
+static struct device_type drm_sysfs_device_connector = {
+	.name = "drm_connector",
+};
+
 struct class *drm_class;
 
+#ifdef CONFIG_ACPI
+static bool drm_connector_acpi_bus_match(struct device *dev)
+{
+	return dev->type == &drm_sysfs_device_connector;
+}
+
+static struct acpi_device *drm_connector_acpi_find_companion(struct device *dev)
+{
+	struct drm_connector *connector = to_drm_connector(dev);
+
+	return to_acpi_device_node(connector->fwnode);
+}
+
+static struct acpi_bus_type drm_connector_acpi_bus = {
+	.name = "drm_connector",
+	.match = drm_connector_acpi_bus_match,
+	.find_companion = drm_connector_acpi_find_companion,
+};
+
+static void drm_sysfs_acpi_register(void)
+{
+	register_acpi_bus_type(&drm_connector_acpi_bus);
+}
+
+static void drm_sysfs_acpi_unregister(void)
+{
+	unregister_acpi_bus_type(&drm_connector_acpi_bus);
+}
+#else
+static void drm_sysfs_acpi_register(void) { }
+static void drm_sysfs_acpi_unregister(void) { }
+#endif
+
 static char *drm_devnode(struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
@@ -85,6 +123,8 @@ int drm_sysfs_init(void)
 	}
 
 	drm_class->devnode = drm_devnode;
+
+	drm_sysfs_acpi_register();
 	return 0;
 }
 
@@ -97,11 +137,17 @@ void drm_sysfs_destroy(void)
 {
 	if (IS_ERR_OR_NULL(drm_class))
 		return;
+	drm_sysfs_acpi_unregister();
 	class_remove_file(drm_class, &class_attr_version.attr);
 	class_destroy(drm_class);
 	drm_class = NULL;
 }
 
+static void drm_sysfs_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 /*
  * Connector properties
  */
@@ -274,27 +320,47 @@ static const struct attribute_group *connector_dev_groups[] = {
 int drm_sysfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	struct device *kdev;
+	int r;
 
 	if (connector->kdev)
 		return 0;
 
-	connector->kdev =
-		device_create_with_groups(drm_class, dev->primary->kdev, 0,
-					  connector, connector_dev_groups,
-					  "card%d-%s", dev->primary->index,
-					  connector->name);
+	kdev = kzalloc(sizeof(*kdev), GFP_KERNEL);
+	if (!kdev)
+		return -ENOMEM;
+
+	device_initialize(kdev);
+	kdev->class = drm_class;
+	kdev->type = &drm_sysfs_device_connector;
+	kdev->parent = dev->primary->kdev;
+	kdev->groups = connector_dev_groups;
+	kdev->release = drm_sysfs_release;
+	dev_set_drvdata(kdev, connector);
+
+	r = dev_set_name(kdev, "card%d-%s", dev->primary->index, connector->name);
+	if (r)
+		goto err_free;
+
 	DRM_DEBUG("adding \"%s\" to sysfs\n",
 		  connector->name);
 
-	if (IS_ERR(connector->kdev)) {
-		DRM_ERROR("failed to register connector device: %ld\n", PTR_ERR(connector->kdev));
-		return PTR_ERR(connector->kdev);
+	r = device_add(kdev);
+	if (r) {
+		drm_err(dev, "failed to register connector device: %d\n", r);
+		goto err_free;
 	}
 
+	connector->kdev = kdev;
+
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
 	return 0;
+
+err_free:
+	put_device(kdev);
+	return r;
 }
 
 void drm_sysfs_connector_remove(struct drm_connector *connector)
@@ -375,11 +441,6 @@ void drm_sysfs_connector_status_event(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_sysfs_connector_status_event);
 
-static void drm_sysfs_release(struct device *dev)
-{
-	kfree(dev);
-}
-
 struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 {
 	const char *minor_str;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 92dd65befbcb..01a88b03bc6d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -222,6 +222,7 @@ static vm_fault_t i915_error_to_vmf_fault(int err)
 	case 0:
 	case -EAGAIN:
 	case -ENOSPC: /* transient failure to evict? */
+	case -ENOBUFS: /* temporarily out of fences? */
 	case -ERESTARTSYS:
 	case -EINTR:
 	case -EBUSY:
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 7ea90d25a3b6..8aa9f2335f57 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -147,6 +147,7 @@ static void _dpu_plane_calc_bw(struct drm_plane *plane,
 	const struct dpu_format *fmt = NULL;
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 	int src_width, src_height, dst_height, fps;
+	u64 plane_pixel_rate, plane_bit_rate;
 	u64 plane_prefill_bw;
 	u64 plane_bw;
 	u32 hw_latency_lines;
@@ -168,13 +169,12 @@ static void _dpu_plane_calc_bw(struct drm_plane *plane,
 	scale_factor = src_height > dst_height ?
 		mult_frac(src_height, 1, dst_height) : 1;
 
-	plane_bw =
-		src_width * mode->vtotal * fps * fmt->bpp *
-		scale_factor;
+	plane_pixel_rate = src_width * mode->vtotal * fps;
+	plane_bit_rate = plane_pixel_rate * fmt->bpp;
 
-	plane_prefill_bw =
-		src_width * hw_latency_lines * fps * fmt->bpp *
-		scale_factor * mode->vtotal;
+	plane_bw = plane_bit_rate * scale_factor;
+
+	plane_prefill_bw = plane_bw * hw_latency_lines;
 
 	do_div(plane_prefill_bw, (vbp+vpw));
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9fac55c24214..07becbf3c64f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1665,13 +1665,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 		return rc;
 
 	while (--link_train_max_retries) {
-		rc = dp_ctrl_reinitialize_mainlink(ctrl);
-		if (rc) {
-			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
-					rc);
-			break;
-		}
-
 		training_step = DP_TRAINING_NONE;
 		rc = dp_ctrl_setup_main_link(ctrl, &cr, &training_step);
 		if (rc == 0) {
@@ -1712,6 +1705,12 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 				break; /* lane == 1 already */
 			}
 		}
+
+		rc = dp_ctrl_reinitialize_mainlink(ctrl);
+		if (rc) {
+			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
+			break;
+		}
 	}
 
 	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 5a76aa138917..fb7792ca39e2 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1075,9 +1075,21 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
 
 static void dsi_wait4video_eng_busy(struct msm_dsi_host *msm_host)
 {
+	u32 data;
+
 	if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
 		return;
 
+	data = dsi_read(msm_host, REG_DSI_STATUS0);
+
+	/* if video mode engine is not busy, its because
+	 * either timing engine was not turned on or the
+	 * DSI controller has finished transmitting the video
+	 * data already, so no need to wait in those cases
+	 */
+	if (!(data & DSI_STATUS0_VIDEO_MODE_ENGINE_BUSY))
+		return;
+
 	if (msm_host->power_on && msm_host->enabled) {
 		dsi_wait4video_done(msm_host);
 		/* delay 4 ms to skip BLLP */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 4c6c2e5abf95..00082c679170 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1627,7 +1627,7 @@ static int vmw_cmd_tex_state(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdSetTextureState);
 	SVGA3dTextureState *last_state = (SVGA3dTextureState *)
-	  ((unsigned long) header + header->size + sizeof(header));
+	  ((unsigned long) header + header->size + sizeof(*header));
 	SVGA3dTextureState *cur_state = (SVGA3dTextureState *)
 		((unsigned long) header + sizeof(*cmd));
 	struct vmw_resource *ctx;
diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index 403506b9697e..b346d68a06f5 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -130,6 +130,10 @@ static int holtek_kbd_input_event(struct input_dev *dev, unsigned int type,
 		return -ENODEV;
 
 	boot_hid = usb_get_intfdata(boot_interface);
+	if (list_empty(&boot_hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
 	boot_hid_input = list_first_entry(&boot_hid->inputs,
 		struct hid_input, list);
 
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6ac0c2d9a147..651fa0966939 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3936,7 +3936,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto hid_hw_init_fail;
 	}
 
-	hidpp_connect_event(hidpp);
+	schedule_work(&hidpp->work);
+	flush_work(&hidpp->work);
 
 	if (will_restart) {
 		/* Reset the HID node state */
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index dc7c33f6b2c4..84b12599eaf6 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2058,6 +2058,10 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_MTP_STM)},
 
 	/* Synaptics devices */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 774507b54b57..c90cec8d9656 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -340,7 +340,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/* Sanity check on class */
-	if (i2c_mux_parent_classes(parent) & class)
+	if (i2c_mux_parent_classes(parent) & class & ~I2C_CLASS_DEPRECATED)
 		dev_err(&parent->dev,
 			"Segment %d behind mux can't share classes with ancestors\n",
 			chan_id);
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6b7da40f99c8..919a338d9181 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1112,7 +1112,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index cf8b92fae1b3..1b6b9530f166 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -57,8 +57,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
-/* Make sure sleep time is <= 20ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Make sure sleep time is <= 30ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
 #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
 
@@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *data)
 	if (rc)
 		return rc;
 
-	/* Wait for device chip access: 2.5ms in specification */
-	usleep_range(2500, 12000);
+	/* Wait for device chip access: 15ms in specification */
+	usleep_range(15000, 55000);
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 874a73b3ea9d..f88d8f2ce610 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -76,7 +76,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index e42c812e74c3..8c54b1be0442 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1965,6 +1965,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
 	int win;
 
 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
 	req = __skb_put_zero(skb, sizeof(*req));
 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 9b9b9557ae74..68df080263f2 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -965,67 +965,52 @@ static void srp_disconnect_target(struct srp_target_port *target)
 	}
 }
 
-static void srp_free_req_data(struct srp_target_port *target,
-			      struct srp_rdma_ch *ch)
+static int srp_exit_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 {
+	struct srp_target_port *target = host_to_target(shost);
 	struct srp_device *dev = target->srp_host->srp_dev;
 	struct ib_device *ibdev = dev->dev;
-	struct srp_request *req;
-	int i;
+	struct srp_request *req = scsi_cmd_priv(cmd);
 
-	if (!ch->req_ring)
-		return;
-
-	for (i = 0; i < target->req_ring_size; ++i) {
-		req = &ch->req_ring[i];
-		if (dev->use_fast_reg)
-			kfree(req->fr_list);
-		if (req->indirect_dma_addr) {
-			ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
-					    target->indirect_size,
-					    DMA_TO_DEVICE);
-		}
-		kfree(req->indirect_desc);
+	kfree(req->fr_list);
+	if (req->indirect_dma_addr) {
+		ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
+				    target->indirect_size,
+				    DMA_TO_DEVICE);
 	}
+	kfree(req->indirect_desc);
 
-	kfree(ch->req_ring);
-	ch->req_ring = NULL;
+	return 0;
 }
 
-static int srp_alloc_req_data(struct srp_rdma_ch *ch)
+static int srp_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 {
-	struct srp_target_port *target = ch->target;
+	struct srp_target_port *target = host_to_target(shost);
 	struct srp_device *srp_dev = target->srp_host->srp_dev;
 	struct ib_device *ibdev = srp_dev->dev;
-	struct srp_request *req;
+	struct srp_request *req = scsi_cmd_priv(cmd);
 	dma_addr_t dma_addr;
-	int i, ret = -ENOMEM;
-
-	ch->req_ring = kcalloc(target->req_ring_size, sizeof(*ch->req_ring),
-			       GFP_KERNEL);
-	if (!ch->req_ring)
-		goto out;
-
-	for (i = 0; i < target->req_ring_size; ++i) {
-		req = &ch->req_ring[i];
-		if (srp_dev->use_fast_reg) {
-			req->fr_list = kmalloc_array(target->mr_per_cmd,
-						sizeof(void *), GFP_KERNEL);
-			if (!req->fr_list)
-				goto out;
-		}
-		req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
-		if (!req->indirect_desc)
-			goto out;
+	int ret = -ENOMEM;
 
-		dma_addr = ib_dma_map_single(ibdev, req->indirect_desc,
-					     target->indirect_size,
-					     DMA_TO_DEVICE);
-		if (ib_dma_mapping_error(ibdev, dma_addr))
+	if (srp_dev->use_fast_reg) {
+		req->fr_list = kmalloc_array(target->mr_per_cmd, sizeof(void *),
+					GFP_KERNEL);
+		if (!req->fr_list)
 			goto out;
+	}
+	req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
+	if (!req->indirect_desc)
+		goto out;
 
-		req->indirect_dma_addr = dma_addr;
+	dma_addr = ib_dma_map_single(ibdev, req->indirect_desc,
+				     target->indirect_size,
+				     DMA_TO_DEVICE);
+	if (ib_dma_mapping_error(ibdev, dma_addr)) {
+		srp_exit_cmd_priv(shost, cmd);
+		goto out;
 	}
+
+	req->indirect_dma_addr = dma_addr;
 	ret = 0;
 
 out:
@@ -1067,10 +1052,6 @@ static void srp_remove_target(struct srp_target_port *target)
 	}
 	cancel_work_sync(&target->tl_err_work);
 	srp_rport_put(target->rport);
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
-		srp_free_req_data(target, ch);
-	}
 	kfree(target->ch);
 	target->ch = NULL;
 
@@ -1289,22 +1270,32 @@ static void srp_finish_req(struct srp_rdma_ch *ch, struct srp_request *req,
 	}
 }
 
-static void srp_terminate_io(struct srp_rport *rport)
+struct srp_terminate_context {
+	struct srp_target_port *srp_target;
+	int scsi_result;
+};
+
+static bool srp_terminate_cmd(struct scsi_cmnd *scmnd, void *context_ptr,
+			      bool reserved)
 {
-	struct srp_target_port *target = rport->lld_data;
-	struct srp_rdma_ch *ch;
-	int i, j;
+	struct srp_terminate_context *context = context_ptr;
+	struct srp_target_port *target = context->srp_target;
+	u32 tag = blk_mq_unique_tag(scmnd->request);
+	struct srp_rdma_ch *ch = &target->ch[blk_mq_unique_tag_to_hwq(tag)];
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
+	srp_finish_req(ch, req, NULL, context->scsi_result);
 
-		for (j = 0; j < target->req_ring_size; ++j) {
-			struct srp_request *req = &ch->req_ring[j];
+	return true;
+}
 
-			srp_finish_req(ch, req, NULL,
-				       DID_TRANSPORT_FAILFAST << 16);
-		}
-	}
+static void srp_terminate_io(struct srp_rport *rport)
+{
+	struct srp_target_port *target = rport->lld_data;
+	struct srp_terminate_context context = { .srp_target = target,
+		.scsi_result = DID_TRANSPORT_FAILFAST << 16 };
+
+	scsi_host_busy_iter(target->scsi_host, srp_terminate_cmd, &context);
 }
 
 /* Calculate maximum initiator to target information unit length. */
@@ -1360,13 +1351,12 @@ static int srp_rport_reconnect(struct srp_rport *rport)
 		ch = &target->ch[i];
 		ret += srp_new_cm_id(ch);
 	}
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
-		for (j = 0; j < target->req_ring_size; ++j) {
-			struct srp_request *req = &ch->req_ring[j];
+	{
+		struct srp_terminate_context context = {
+			.srp_target = target, .scsi_result = DID_RESET << 16};
 
-			srp_finish_req(ch, req, NULL, DID_RESET << 16);
-		}
+		scsi_host_busy_iter(target->scsi_host, srp_terminate_cmd,
+				    &context);
 	}
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
@@ -1962,11 +1952,9 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	} else {
 		scmnd = scsi_host_find_tag(target->scsi_host, rsp->tag);
-		if (scmnd && scmnd->host_scribble) {
-			req = (void *)scmnd->host_scribble;
+		if (scmnd) {
+			req = scsi_cmd_priv(scmnd);
 			scmnd = srp_claim_req(ch, req, NULL, scmnd);
-		} else {
-			scmnd = NULL;
 		}
 		if (!scmnd) {
 			shost_printk(KERN_ERR, target->scsi_host,
@@ -1996,7 +1984,6 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		srp_free_req(ch, req, scmnd,
 			     be32_to_cpu(rsp->req_lim_delta));
 
-		scmnd->host_scribble = NULL;
 		scmnd->scsi_done(scmnd);
 	}
 }
@@ -2164,13 +2151,12 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(shost);
 	struct srp_rdma_ch *ch;
-	struct srp_request *req;
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 	struct srp_iu *iu;
 	struct srp_cmd *cmd;
 	struct ib_device *dev;
 	unsigned long flags;
 	u32 tag;
-	u16 idx;
 	int len, ret;
 
 	scmnd->result = srp_chkready(target->rport);
@@ -2180,10 +2166,6 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	WARN_ON_ONCE(scmnd->request->tag < 0);
 	tag = blk_mq_unique_tag(scmnd->request);
 	ch = &target->ch[blk_mq_unique_tag_to_hwq(tag)];
-	idx = blk_mq_unique_tag_to_tag(tag);
-	WARN_ONCE(idx >= target->req_ring_size, "%s: tag %#x: idx %d >= %d\n",
-		  dev_name(&shost->shost_gendev), tag, idx,
-		  target->req_ring_size);
 
 	spin_lock_irqsave(&ch->lock, flags);
 	iu = __srp_get_tx_iu(ch, SRP_IU_CMD);
@@ -2192,13 +2174,10 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	if (!iu)
 		goto err;
 
-	req = &ch->req_ring[idx];
 	dev = target->srp_host->srp_dev->dev;
 	ib_dma_sync_single_for_cpu(dev, iu->dma, ch->max_it_iu_len,
 				   DMA_TO_DEVICE);
 
-	scmnd->host_scribble = (void *) req;
-
 	cmd = iu->buf;
 	memset(cmd, 0, sizeof *cmd);
 
@@ -2799,16 +2778,13 @@ static int srp_send_tsk_mgmt(struct srp_rdma_ch *ch, u64 req_tag, u64 lun,
 static int srp_abort(struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
-	struct srp_request *req = (struct srp_request *) scmnd->host_scribble;
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
-	int ret;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
-	if (!req)
-		return SUCCESS;
 	tag = blk_mq_unique_tag(scmnd->request);
 	ch_idx = blk_mq_unique_tag_to_hwq(tag);
 	if (WARN_ON_ONCE(ch_idx >= target->ch_count))
@@ -2819,19 +2795,14 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	shost_printk(KERN_ERR, target->scsi_host,
 		     "Sending SRP abort for tag %#x\n", tag);
 	if (srp_send_tsk_mgmt(ch, tag, scmnd->device->lun,
-			      SRP_TSK_ABORT_TASK, NULL) == 0)
-		ret = SUCCESS;
-	else if (target->rport->state == SRP_RPORT_LOST)
-		ret = FAST_IO_FAIL;
-	else
-		ret = FAILED;
-	if (ret == SUCCESS) {
+			      SRP_TSK_ABORT_TASK, NULL) == 0) {
 		srp_free_req(ch, req, scmnd, 0);
-		scmnd->result = DID_ABORT << 16;
-		scmnd->scsi_done(scmnd);
+		return SUCCESS;
 	}
+	if (target->rport->state == SRP_RPORT_LOST)
+		return FAST_IO_FAIL;
 
-	return ret;
+	return FAILED;
 }
 
 static int srp_reset_device(struct scsi_cmnd *scmnd)
@@ -3075,6 +3046,8 @@ static struct scsi_host_template srp_template = {
 	.target_alloc			= srp_target_alloc,
 	.slave_configure		= srp_slave_configure,
 	.info				= srp_target_info,
+	.init_cmd_priv			= srp_init_cmd_priv,
+	.exit_cmd_priv			= srp_exit_cmd_priv,
 	.queuecommand			= srp_queuecommand,
 	.change_queue_depth             = srp_change_queue_depth,
 	.eh_timed_out			= srp_timed_out,
@@ -3088,6 +3061,7 @@ static struct scsi_host_template srp_template = {
 	.cmd_per_lun			= SRP_DEFAULT_CMD_SQ_SIZE,
 	.shost_attrs			= srp_host_attrs,
 	.track_queue_depth		= 1,
+	.cmd_size			= sizeof(struct srp_request),
 };
 
 static int srp_sdev_count(struct Scsi_Host *host)
@@ -3735,8 +3709,6 @@ static ssize_t srp_create_target(struct device *dev,
 	if (ret)
 		goto out;
 
-	target->req_ring_size = target->queue_size - SRP_TSK_MGMT_SQ_SIZE;
-
 	if (!srp_conn_unique(target->srp_host, target)) {
 		if (target->using_rdma_cm) {
 			shost_printk(KERN_INFO, target->scsi_host,
@@ -3839,10 +3811,6 @@ static ssize_t srp_create_target(struct device *dev,
 		if (ret)
 			goto err_disconnect;
 
-		ret = srp_alloc_req_data(ch);
-		if (ret)
-			goto err_disconnect;
-
 		ret = srp_connect_ch(ch, max_iu_len, multich);
 		if (ret) {
 			char dst[64];
@@ -3861,7 +3829,6 @@ static ssize_t srp_create_target(struct device *dev,
 				goto free_ch;
 			} else {
 				srp_free_ch_ib(target, ch);
-				srp_free_req_data(target, ch);
 				target->ch_count = ch - target->ch;
 				goto connected;
 			}
@@ -3922,7 +3889,6 @@ static ssize_t srp_create_target(struct device *dev,
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
 		srp_free_ch_ib(target, ch);
-		srp_free_req_data(target, ch);
 	}
 
 	kfree(target->ch);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 85bac20d9007..152242e8f733 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -176,7 +176,6 @@ struct srp_rdma_ch {
 
 	struct srp_iu	      **tx_ring;
 	struct srp_iu	      **rx_ring;
-	struct srp_request     *req_ring;
 	int			comp_vector;
 
 	u64			tsk_mgmt_tag;
@@ -222,7 +221,6 @@ struct srp_target_port {
 	int			mr_pool_size;
 	int			mr_per_cmd;
 	int			queue_size;
-	int			req_ring_size;
 	int			comp_vector;
 	int			tl_retry_count;
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b99318fb58dc..762c50239146 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -252,6 +252,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -446,6 +447,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c4e0e1886061..6b1b95d58e6b 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -425,6 +425,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 598fcb99f6c9..400281feb4e8 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -2112,6 +2112,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->pktsize = info->hw_version > 1 ? 6 : 4;
 
 	return 0;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 82577095e175..afa5d2623c41 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1619,6 +1619,7 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->cleanup = synaptics_reset;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 1bd5898abb97..09528c0a8a34 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
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
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 098115eb8084..53792a1b6ac3 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -820,6 +820,25 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
 		dev_info(dev, "No ACPI GpioInt resource, assuming that the GPIO order is reset, int\n");
 		ts->irq_pin_access_method = IRQ_PIN_ACCESS_ACPI_GPIO;
 		gpio_mapping = acpi_goodix_int_last_gpios;
+	} else if (ts->gpio_count == 1 && ts->gpio_int_idx == 0) {
+		/*
+		 * On newer devices there is only 1 GpioInt resource and _PS0
+		 * does the whole reset sequence for us.
+		 */
+		acpi_device_fix_up_power(ACPI_COMPANION(dev));
+
+		/*
+		 * Before the _PS0 call the int GPIO may have been in output
+		 * mode and the call should have put the int GPIO in input mode,
+		 * but the GPIO subsys cached state may still think it is
+		 * in output mode, causing gpiochip_lock_as_irq() failure.
+		 *
+		 * Add a mapping for the int GPIO to make the
+		 * gpiod_int = gpiod_get(..., GPIOD_IN) call succeed,
+		 * which will explicitly set the direction to input.
+		 */
+		ts->irq_pin_access_method = IRQ_PIN_ACCESS_NONE;
+		gpio_mapping = acpi_goodix_int_first_gpios;
 	} else {
 		dev_warn(dev, "Unexpected ACPI resources: gpio_count %d, gpio_int_idx %d\n",
 			 ts->gpio_count, ts->gpio_int_idx);
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 8b8cd751fe9a..806a3d9da12f 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -389,17 +389,13 @@ EXPORT_SYMBOL_NS_GPL(mcb_free_dev, MCB);
 
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
-	struct mcb_device *mdev = to_mcb_device(dev);
 	int retval;
 
-	if (mdev->is_added)
-		return 0;
-
 	retval = device_attach(dev);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err(dev, "Error adding device (%d)\n", retval);
-
-	mdev->is_added = true;
+		return retval;
+	}
 
 	return 0;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index aa6938da0db8..c41cbacc75a2 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -99,8 +99,6 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	mdev->mem.end = mdev->mem.start + size - 1;
 	mdev->mem.flags = IORESOURCE_MEM;
 
-	mdev->is_added = false;
-
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
 		goto err;
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 88a23bce569d..36109c324cb6 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1455,6 +1455,7 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&jpeg->job_timeout_work);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
 	video_device_release(jpeg->vdev);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 87807ef010a9..91c929bd69c0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -95,7 +95,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 99a4ce68d82f..85c2947ed45e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1075,8 +1075,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
-		/* We may have switched to 1-bit mode during suspend */
+		/*
+		 * We may have switched to 1-bit mode during suspend,
+		 * need to hold retuning, because tuning only supprt
+		 * 4-bit mode or 8 bit mode.
+		 */
+		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
+		mmc_retune_release(host);
 	}
 
 	if (err)
diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 4f63b8430c71..9ab795f03c54 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -556,6 +556,17 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (info->probe_type) {
 			info->mtds[i] = do_map_probe(info->probe_type,
 						     &info->maps[i]);
+
+			/* Fall back to mapping region as ROM */
+			if (!info->mtds[i] && IS_ENABLED(CONFIG_MTD_ROM) &&
+			    strcmp(info->probe_type, "map_rom")) {
+				dev_warn(&dev->dev,
+					 "map_probe() failed for type %s\n",
+					 info->probe_type);
+
+				info->mtds[i] = do_map_probe("map_rom",
+							     &info->maps[i]);
+			}
 		} else {
 			int j;
 
diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 6a0d48c42cfa..ef062b5ea9cd 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -451,6 +451,7 @@ static int anfc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int len = mtd->writesize + (oob_required ? mtd->oobsize : 0);
 	dma_addr_t dma_addr;
+	u8 status;
 	int ret;
 	struct anfc_op nfc_op = {
 		.pkt_reg =
@@ -497,10 +498,21 @@ static int anfc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	}
 
 	/* Spare data is not protected */
-	if (oob_required)
+	if (oob_required) {
 		ret = nand_write_oob_std(chip, page);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
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
 
 static int anfc_sel_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 2ef1a5adfcfc..9ed3ff7f4cf9 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1148,6 +1148,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
 	};
 	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
+	u8 status;
 	int ret;
 
 	/* NFCv2 needs more information about the operation being executed */
@@ -1181,7 +1182,18 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 
 	ret = marvell_nfc_wait_op(chip,
 				  PSEC_TO_MSEC(sdr->tPROG_max));
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
@@ -1610,6 +1622,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	int data_len = lt->data_bytes;
 	int spare_len = lt->spare_bytes;
 	int chunk, ret;
+	u8 status;
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
 
@@ -1646,6 +1659,14 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
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
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index bb181e18c7c5..be7190f0499b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2996,7 +2996,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 err_aon_clk:
 	clk_disable_unprepare(nandc->core_clk);
 err_core_clk:
-	dma_unmap_resource(dev, res->start, resource_size(res),
+	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
 			   DMA_BIDIRECTIONAL, 0);
 	return ret;
 }
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..89e2b46bdc46 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -12,7 +12,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index f2f890e559f3..a5849663f65c 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -497,17 +497,16 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	dn = of_find_compatible_node(NULL, NULL, "brcm,unimac-mdio");
 	priv->master_mii_bus = of_mdio_find_bus(dn);
 	if (!priv->master_mii_bus) {
-		of_node_put(dn);
-		return -EPROBE_DEFER;
+		err = -EPROBE_DEFER;
+		goto err_of_node_put;
 	}
 
-	get_device(&priv->master_mii_bus->dev);
 	priv->master_mii_dn = dn;
 
 	priv->slave_mii_bus = mdiobus_alloc();
 	if (!priv->slave_mii_bus) {
-		of_node_put(dn);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_put_master_mii_bus_dev;
 	}
 
 	priv->slave_mii_bus->priv = priv;
@@ -564,11 +563,17 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
-		of_node_put(dn);
-	}
+	if (err && dn)
+		goto err_free_slave_mii_bus;
 
+	return 0;
+
+err_free_slave_mii_bus:
+	mdiobus_free(priv->slave_mii_bus);
+err_put_master_mii_bus_dev:
+	put_device(&priv->master_mii_bus->dev);
+err_of_node_put:
+	of_node_put(dn);
 	return err;
 }
 
@@ -576,6 +581,7 @@ static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
 {
 	mdiobus_unregister(priv->slave_mii_bus);
 	mdiobus_free(priv->slave_mii_bus);
+	put_device(&priv->master_mii_bus->dev);
 	of_node_put(priv->master_mii_dn);
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ba109073d605..59a467f7aba3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1339,7 +1339,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 		     I40E_PFLAN_QALLOC_FIRSTQ_SHIFT;
 	j = (val & I40E_PFLAN_QALLOC_LASTQ_MASK) >>
 	    I40E_PFLAN_QALLOC_LASTQ_SHIFT;
-	if (val & I40E_PFLAN_QALLOC_VALID_MASK)
+	if (val & I40E_PFLAN_QALLOC_VALID_MASK && j >= base_queue)
 		num_queues = (j - base_queue) + 1;
 	else
 		num_queues = 0;
@@ -1349,7 +1349,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	    I40E_PF_VT_PFALLOC_FIRSTVF_SHIFT;
 	j = (val & I40E_PF_VT_PFALLOC_LASTVF_MASK) >>
 	    I40E_PF_VT_PFALLOC_LASTVF_SHIFT;
-	if (val & I40E_PF_VT_PFALLOC_VALID_MASK)
+	if (val & I40E_PF_VT_PFALLOC_VALID_MASK && j >= i)
 		num_vfs = (j - i) + 1;
 	else
 		num_vfs = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ea8d868c8f30..e99c8c10bc61 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -931,8 +931,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d2ee760f9294..02f72fbec104 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
@@ -4025,6 +4026,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return -EINVAL;
 	}
 
+	/* when under a kdump kernel initiate a reset before enabling the
+	 * device in order to clear out any pending DMA transactions. These
+	 * transactions can cause some systems to machine check when doing
+	 * the pcim_enable_device() below.
+	 */
+	if (is_kdump_kernel()) {
+		pci_save_state(pdev);
+		pci_clear_master(pdev);
+		err = pcie_flr(pdev);
+		if (err)
+			return err;
+		pci_restore_state(pdev);
+	}
+
 	/* this driver uses devres, see
 	 * Documentation/driver-api/driver-model/devres.rst
 	 */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 0078ae592616..5eba086690ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	struct vf_macvlans *mv_list;
 	int num_vf_macvlans, i;
 
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&adapter->vf_mvs.l);
+
 	num_vf_macvlans = hw->mac.num_rar_entries -
 			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
 	if (!num_vf_macvlans)
@@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
 			  GFP_KERNEL);
 	if (mv_list) {
-		/* Initialize list of VF macvlans */
-		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
 			mv_list[i].vf = -1;
 			mv_list[i].free = true;
diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index b2dddd8a246c..2bd0a7971ae6 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2195,7 +2195,7 @@ struct rx_ring_info {
 	struct sk_buff	*skb;
 	dma_addr_t	data_addr;
 	DEFINE_DMA_UNMAP_LEN(data_size);
-	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
+	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
 };
 
 enum flow_control {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 5273644fb2bf..86088ccab23a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -821,7 +821,7 @@ static void mlx5_fw_tracer_ownership_change(struct work_struct *work)
 
 	mlx5_core_dbg(tracer->dev, "FWTracer: ownership changed, current=(%d)\n", tracer->owner);
 	if (tracer->owner) {
-		tracer->owner = false;
+		mlx5_fw_tracer_ownership_acquire(tracer);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 05517c7feaa5..a20ba23f0ed7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -294,8 +294,8 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops = {
 	.fdb_clear_offload = mlxsw_sp_nve_vxlan_clear_offload,
 };
 
-static bool mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
-					     bool learning_en)
+static int mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
+					    bool learning_en)
 {
 	char tnpc_pl[MLXSW_REG_TNPC_LEN];
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index f2c8273dce67..3f59834a0d3a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -87,7 +87,10 @@ static void qed_ll2b_complete_tx_packet(void *cxt,
 static int qed_ll2_alloc_buffer(struct qed_dev *cdev,
 				u8 **data, dma_addr_t *phys_addr)
 {
-	*data = kmalloc(cdev->ll2->rx_size, GFP_ATOMIC);
+	size_t size = cdev->ll2->rx_size + NET_SKB_PAD +
+		      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	*data = kmalloc(size, GFP_ATOMIC);
 	if (!(*data)) {
 		DP_INFO(cdev, "Failed to allocate LL2 buffer data\n");
 		return -ENOMEM;
@@ -2541,7 +2544,7 @@ static int qed_ll2_start(struct qed_dev *cdev, struct qed_ll2_params *params)
 	INIT_LIST_HEAD(&cdev->ll2->list);
 	spin_lock_init(&cdev->ll2->lock);
 
-	cdev->ll2->rx_size = NET_SKB_PAD + ETH_HLEN +
+	cdev->ll2->rx_size = PRM_DMA_PAD_BYTES_NUM + ETH_HLEN +
 			     L1_CACHE_BYTES + params->mtu;
 
 	/* Allocate memory for LL2.
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 410ccd28f653..f218bacec001 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1706,6 +1706,8 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
 
+	cancel_work_sync(&priv->work);
+
 	if (priv->chip_id != RCAR_GEN2) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
@@ -2249,14 +2251,14 @@ static int ravb_remove(struct platform_device *pdev)
 	if (priv->chip_id != RCAR_GEN2)
 		ravb_ptp_stop(ndev);
 
-	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
-			  priv->desc_bat_dma);
 	/* Set reset mode */
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	unregister_netdev(ndev);
 	netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
+	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
+			  priv->desc_bat_dma);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	free_netdev(ndev);
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 1c5d70c60354..0ce426c0c0bf 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2783,7 +2783,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 	struct ca8210_platform_data *pdata = spi->dev.platform_data;
-	int ret = 0;
 
 	if (!np)
 		return -EFAULT;
@@ -2800,18 +2799,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 		dev_crit(&spi->dev, "Failed to register external clk\n");
 		return PTR_ERR(priv->clk);
 	}
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
-	if (ret) {
-		clk_unregister(priv->clk);
-		dev_crit(
-			&spi->dev,
-			"Failed to register external clock as clock provider\n"
-		);
-	} else {
-		dev_info(&spi->dev, "External clock set as clock provider\n");
-	}
 
-	return ret;
+	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
 }
 
 /**
@@ -2823,8 +2812,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
 {
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 
-	if (!priv->clk)
-		return
+	if (IS_ERR_OR_NULL(priv->clk))
+		return;
 
 	of_clk_del_provider(spi->dev.of_node);
 	clk_unregister(priv->clk);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4fb58fc5ec95..0ffcef2fa10a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2414,6 +2414,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2507,6 +2508,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/drivers/net/phy/mscc/mscc_macsec.c b/drivers/net/phy/mscc/mscc_macsec.c
index c00eef457b85..bec270785c59 100644
--- a/drivers/net/phy/mscc/mscc_macsec.c
+++ b/drivers/net/phy/mscc/mscc_macsec.c
@@ -880,6 +880,9 @@ static int vsc8584_macsec_upd_rxsa(struct macsec_context *ctx)
 {
 	struct macsec_flow *flow;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_INGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
@@ -929,6 +932,9 @@ static int vsc8584_macsec_upd_txsa(struct macsec_context *ctx)
 {
 	struct macsec_flow *flow;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_EGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 191bf0df1466..0b25b59f4403 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3064,10 +3064,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct net *net = sock_net(&tfile->sk);
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	unsigned int ifindex, carrier;
+	unsigned int carrier;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
+	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
 	int le;
@@ -3124,7 +3125,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EFAULT;
 		if (copy_from_user(&ifindex, argp, sizeof(ifindex)))
 			goto unlock;
-
+		ret = -EINVAL;
+		if (ifindex < 0)
+			goto unlock;
 		ret = 0;
 		tfile->ifindex = ifindex;
 		goto unlock;
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 915ac75b55fc..5aad26600b03 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -221,13 +221,18 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err < 0) {
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 975f52605867..9297f2078fd2 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -863,7 +863,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 
 	if (timeout >= 100) {
 		netdev_warn(dev->net, "timeout waiting for completion of Lite Reset\n");
-		return ret;
+		return -ETIMEDOUT;
 	}
 
 	ret = smsc95xx_write_reg(dev, PM_CTRL, PM_CTL_PHY_RST_);
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 97cf5bc48902..09fc4bc0622e 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -41,7 +41,6 @@
 #include <asm/xen/hypercall.h>
 #include <xen/balloon.h>
 
-#define XENVIF_QUEUE_LENGTH 32
 #define XENVIF_NAPI_WEIGHT  64
 
 /* Number of bytes allowed on the internal guest Rx queue. */
@@ -528,8 +527,6 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 	dev->features = dev->hw_features | NETIF_F_RXCSUM;
 	dev->ethtool_ops = &xenvif_ethtool_ops;
 
-	dev->tx_queue_len = XENVIF_QUEUE_LENGTH;
-
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU - VLAN_ETH_HLEN;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9c67ebd4eac3..970a1b374a66 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3181,7 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 825c961c6fd5..ecc3f822df24 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -644,6 +644,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (!test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+		return;
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 2ddbd4f4f628..7ce22d173fc7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -336,6 +336,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -882,15 +883,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
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
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 36061aaf026c..ac4428e8fae9 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1177,7 +1177,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		u64 delta;
 		int i;
 
-		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
+		for (i = 0; i < CMN_DT_NUM_COUNTERS; i++) {
 			if (status & (1U << i)) {
 				ret = IRQ_HANDLED;
 				if (WARN_ON(!dtc->counters[i]))
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 3cd4d51c247c..67802f9e40ba 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -122,16 +122,10 @@ static int phy_mdm6600_power_on(struct phy *x)
 {
 	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
 	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
-	int error;
 
 	if (!ddata->enabled)
 		return -ENODEV;
 
-	error = pinctrl_pm_select_default_state(ddata->dev);
-	if (error)
-		dev_warn(ddata->dev, "%s: error with default_state: %i\n",
-			 __func__, error);
-
 	gpiod_set_value_cansleep(enable_gpio, 1);
 
 	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
@@ -160,11 +154,6 @@ static int phy_mdm6600_power_off(struct phy *x)
 
 	gpiod_set_value_cansleep(enable_gpio, 0);
 
-	error = pinctrl_pm_select_sleep_state(ddata->dev);
-	if (error)
-		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
-			 __func__, error);
-
 	return 0;
 }
 
@@ -456,6 +445,7 @@ static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
 {
 	struct gpio_desc *reset_gpio =
 		ddata->ctrl_gpios[PHY_MDM6600_RESET];
+	int error;
 
 	ddata->enabled = false;
 	phy_mdm6600_cmd(ddata, PHY_MDM6600_CMD_BP_SHUTDOWN_REQ);
@@ -471,6 +461,17 @@ static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
 	} else {
 		dev_err(ddata->dev, "Timed out powering down\n");
 	}
+
+	/*
+	 * Keep reset gpio high with padconf internal pull-up resistor to
+	 * prevent modem from waking up during deeper SoC idle states. The
+	 * gpio bank lines can have glitches if not in the always-on wkup
+	 * domain.
+	 */
+	error = pinctrl_pm_select_sleep_state(ddata->dev);
+	if (error)
+		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
+			 __func__, error);
 }
 
 static void phy_mdm6600_deferred_power_on(struct work_struct *work)
@@ -571,12 +572,6 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	ddata->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ddata);
 
-	/* Active state selected in phy_mdm6600_power_on() */
-	error = pinctrl_pm_select_sleep_state(ddata->dev);
-	if (error)
-		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
-			 __func__, error);
-
 	error = phy_mdm6600_init_lines(ddata);
 	if (error)
 		return error;
@@ -627,10 +622,12 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(ddata->dev);
 
 cleanup:
-	if (error < 0)
+	if (error < 0) {
 		phy_mdm6600_device_power_off(ddata);
-	pm_runtime_disable(ddata->dev);
-	pm_runtime_dont_use_autosuspend(ddata->dev);
+		pm_runtime_disable(ddata->dev);
+		pm_runtime_dont_use_autosuspend(ddata->dev);
+	}
+
 	return error;
 }
 
@@ -639,6 +636,7 @@ static int phy_mdm6600_remove(struct platform_device *pdev)
 	struct phy_mdm6600 *ddata = platform_get_drvdata(pdev);
 	struct gpio_desc *reset_gpio = ddata->ctrl_gpios[PHY_MDM6600_RESET];
 
+	pm_runtime_get_noresume(ddata->dev);
 	pm_runtime_dont_use_autosuspend(ddata->dev);
 	pm_runtime_put_sync(ddata->dev);
 	pm_runtime_disable(ddata->dev);
diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index e941b8440dbc..39559ce9d1ed 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -212,6 +212,7 @@ config PINCTRL_RZN1
 	depends on OF
 	depends on ARCH_RZN1 || COMPILE_TEST
 	select GENERIC_PINCONF
+	select PINMUX
 	help
 	  This selects pinctrl driver for Renesas RZ/N1 devices.
 
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b4a5cbdae904..04503ad6c7fb 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -475,6 +475,9 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, ASUS_WMI_BRN_DOWN, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY, ASUS_WMI_BRN_UP, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x2a, { KEY_SELECTIVE_SCREENSHOT } },
+	{ KE_IGNORE, 0x2b, }, /* PrintScreen (also send via PS/2) on newer models */
+	{ KE_IGNORE, 0x2c, }, /* CapsLock (also send via PS/2) on newer models */
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 1a95c172f94b..1d0b592e2651 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,7 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
-#define ASUS_WMI_BRN_DOWN	0x20
+#define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
 struct module;
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 55a18cd0c298..eedff2ae2851 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -726,6 +726,21 @@ static const struct ts_dmi_data pipo_w11_data = {
 	.properties	= pipo_w11_props,
 };
 
+static const struct property_entry positivo_c4128b_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 13),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1915),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1269),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-positivo-c4128b.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data positivo_c4128b_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= positivo_c4128b_props,
+};
+
 static const struct property_entry pov_mobii_wintab_p800w_v20_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 32),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
@@ -1389,6 +1404,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "MOMO.G.WI71C.MABMRBA02"),
 		},
 	},
+	{
+		/* Positivo C4128B */
+		.driver_data = (void *)&positivo_c4128b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C4128B-1"),
+		},
+	},
 	{
 		/* Point of View mobii wintab p800w (v2.0) */
 		.driver_data = (void *)&pov_mobii_wintab_p800w_v20_data,
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 52b75779dbb7..51c4f604d3b2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5483,15 +5483,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
-	put_device(&rdev->dev);
-	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	if (rdev && rdev->dev.of_node)
-		of_node_put(rdev->dev.of_node);
-	kfree(rdev);
 	kfree(config);
+	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 12d9c5d6b9e2..3d3ac48243eb 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1147,16 +1147,11 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to pm_runtime_get_sync: %d\n", ret);
-		goto clk_dis_all;
-	}
-
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1183,7 +1178,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
-	ctlr->auto_runtime_pm = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
@@ -1191,15 +1185,11 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
-
 	return 0;
 
 clk_dis_all:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1223,15 +1213,11 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(&pdev->dev);
-
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 372d64756ed6..3c15f6a9e91c 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 	return rc;
 }
 
+/* mutex must be held by caller */
 static void destroy_session(struct kref *ref)
 {
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);
 
-	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
 	mutex_unlock(&session_list_mutex);
 	kfree(sess);
@@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
 	if (arg->ret != TEEC_SUCCESS) {
 		pr_err("open_session failed %d\n", arg->ret);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		goto out;
 	}
 
@@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
 		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	handle_close_session(ta_handle, session_info);
 	handle_unload_ta(ta_handle);
 
-	kref_put(&sess->refcount, destroy_session);
+	kref_put_mutex(&sess->refcount, destroy_session, &session_list_mutex);
 
 	return 0;
 }
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index b2fb3397310e..90f1d9a53461 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,6 +41,7 @@
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
 #define ICM_TIMEOUT			5000	/* ms */
+#define ICM_RETRIES			3
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 
@@ -280,10 +281,9 @@ static bool icm_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 
 static int icm_request(struct tb *tb, const void *request, size_t request_size,
 		       void *response, size_t response_size, size_t npackets,
-		       unsigned int timeout_msec)
+		       int retries, unsigned int timeout_msec)
 {
 	struct icm *icm = tb_priv(tb);
-	int retries = 3;
 
 	do {
 		struct tb_cfg_request *req;
@@ -394,7 +394,7 @@ static int icm_fr_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 		return -ENOMEM;
 
 	ret = icm_request(tb, &request, sizeof(request), switches,
-			  sizeof(*switches), npackets, ICM_TIMEOUT);
+			  sizeof(*switches), npackets, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		goto err_free;
 
@@ -447,7 +447,7 @@ icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -472,7 +472,7 @@ static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -499,7 +499,7 @@ static int icm_fr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -527,7 +527,7 @@ static int icm_fr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -559,7 +559,7 @@ static int icm_fr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -996,7 +996,7 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, 10, 2000);
 	if (ret)
 		return ret;
 
@@ -1026,7 +1026,7 @@ static int icm_tr_approve_switch(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1054,7 +1054,7 @@ static int icm_tr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1083,7 +1083,7 @@ static int icm_tr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1115,7 +1115,7 @@ static int icm_tr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1141,7 +1141,7 @@ static int icm_tr_xdomain_tear_down(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1460,7 +1460,7 @@ icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1486,7 +1486,7 @@ static int icm_ar_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1507,7 +1507,7 @@ static int icm_ar_get_boot_acl(struct tb *tb, uuid_t *uuids, size_t nuuids)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1568,7 +1568,7 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1590,7 +1590,7 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, ICM_RETRIES, 20000);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index e881b72833dc..22e5c4de345b 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2303,6 +2303,13 @@ int tb_switch_lane_bonding_enable(struct tb_switch *sw)
 	    !tb_port_is_width_supported(down, 2))
 		return 0;
 
+	/*
+	 * Both lanes need to be in CL0. Here we assume lane 0 already be in
+	 * CL0 and check just for lane 1.
+	 */
+	if (tb_wait_for_port(down->dual_link_port, false) <= 0)
+		return -ENOTCONN;
+
 	ret = tb_port_lane_bonding_enable(up);
 	if (ret) {
 		tb_port_warn(up, "failed to enable lane bonding\n");
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e26ac3f42e05..e7e84aa2c5f8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -32,6 +32,7 @@
 #include "8250.h"
 
 #define DEFAULT_CLK_SPEED	48000000
+#define OMAP_UART_REGSHIFT	2
 
 #define UART_ERRATA_i202_MDR1_ACCESS	(1 << 0)
 #define OMAP_UART_WER_HAS_TX_WAKEUP	(1 << 1)
@@ -109,6 +110,7 @@
 #define UART_OMAP_RX_LVL		0x19
 
 struct omap8250_priv {
+	void __iomem *membase;
 	int line;
 	u8 habit;
 	u8 mdr1;
@@ -152,9 +154,14 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p);
 static inline void omap_8250_rx_dma_flush(struct uart_8250_port *p) { }
 #endif
 
-static u32 uart_read(struct uart_8250_port *up, u32 reg)
+static u32 uart_read(struct omap8250_priv *priv, u32 reg)
+{
+	return readl(priv->membase + (reg << OMAP_UART_REGSHIFT));
+}
+
+static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
 {
-	return readl(up->port.membase + (reg << up->port.regshift));
+	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
 /*
@@ -552,7 +559,7 @@ static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 	u32 mvr, scheme;
 	u16 revision, major, minor;
 
-	mvr = uart_read(up, UART_OMAP_MVER);
+	mvr = uart_read(priv, UART_OMAP_MVER);
 
 	/* Check revision register scheme */
 	scheme = mvr >> OMAP_UART_MVR_SCHEME_SHIFT;
@@ -1336,7 +1343,7 @@ static int omap8250_probe(struct platform_device *pdev)
 		UPF_HARD_FLOW;
 	up.port.private_data = priv;
 
-	up.port.regshift = 2;
+	up.port.regshift = OMAP_UART_REGSHIFT;
 	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
 	up.capabilities = UART_CAP_FIFO;
@@ -1397,6 +1404,8 @@ static int omap8250_probe(struct platform_device *pdev)
 			 DEFAULT_CLK_SPEED);
 	}
 
+	priv->membase = membase;
+	priv->line = -ENODEV;
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
@@ -1404,6 +1413,8 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->rx_dma_lock);
 
+	platform_set_drvdata(pdev, priv);
+
 	device_init_wakeup(&pdev->dev, true);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1465,7 +1476,6 @@ static int omap8250_probe(struct platform_device *pdev)
 		goto err;
 	}
 	priv->line = ret;
-	platform_set_drvdata(pdev, priv);
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
@@ -1487,11 +1497,12 @@ static int omap8250_remove(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	serial8250_unregister_port(priv->line);
+	priv->line = -ENODEV;
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
-	serial8250_unregister_port(priv->line);
 	cpu_latency_qos_remove_request(&priv->pm_qos_request);
 	device_init_wakeup(&pdev->dev, false);
 	return 0;
@@ -1521,7 +1532,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1531,7 +1542,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1540,11 +1552,15 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
-	err = pm_runtime_force_resume(dev);
-	if (err)
-		return err;
+	if (uart_console(&up->port) && console_suspend_enabled) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
@@ -1577,7 +1593,6 @@ static int omap8250_lost_context(struct uart_8250_port *up)
 static int omap8250_soft_reset(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int timeout = 100;
 	int sysc;
 	int syss;
@@ -1591,20 +1606,20 @@ static int omap8250_soft_reset(struct device *dev)
 	 * needing omap8250_soft_reset() quirk. Do it in two writes as
 	 * recommended in the comment for omap8250_update_scr().
 	 */
-	serial_out(up, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
-	serial_out(up, UART_OMAP_SCR,
+	uart_write(priv, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
+	uart_write(priv, UART_OMAP_SCR,
 		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
 
-	sysc = serial_in(up, UART_OMAP_SYSC);
+	sysc = uart_read(priv, UART_OMAP_SYSC);
 
 	/* softreset the UART */
 	sysc |= OMAP_UART_SYSC_SOFTRESET;
-	serial_out(up, UART_OMAP_SYSC, sysc);
+	uart_write(priv, UART_OMAP_SYSC, sysc);
 
 	/* By experiments, 1us enough for reset complete on AM335x */
 	do {
 		udelay(1);
-		syss = serial_in(up, UART_OMAP_SYSS);
+		syss = uart_read(priv, UART_OMAP_SYSS);
 	} while (--timeout && !(syss & OMAP_UART_SYSS_RESETDONE));
 
 	if (!timeout) {
@@ -1618,23 +1633,10 @@ static int omap8250_soft_reset(struct device *dev)
 static int omap8250_runtime_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up;
+	struct uart_8250_port *up = NULL;
 
-	/* In case runtime-pm tries this before we are setup */
-	if (!priv)
-		return 0;
-
-	up = serial8250_get_port(priv->line);
-	/*
-	 * When using 'no_console_suspend', the console UART must not be
-	 * suspended. Since driver suspend is managed by runtime suspend,
-	 * preventing runtime suspend (by returning error) will keep device
-	 * active during suspend.
-	 */
-	if (priv->is_suspending && !console_suspend_enabled) {
-		if (uart_console(&up->port))
-			return -EBUSY;
-	}
+	if (priv->line >= 0)
+		up = serial8250_get_port(priv->line);
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
@@ -1643,13 +1645,15 @@ static int omap8250_runtime_suspend(struct device *dev)
 		if (ret)
 			return ret;
 
-		/* Restore to UART mode after reset (for wakeup) */
-		omap8250_update_mdr1(up, priv);
-		/* Restore wakeup enable register */
-		serial_out(up, UART_OMAP_WER, priv->wer);
+		if (up) {
+			/* Restore to UART mode after reset (for wakeup) */
+			omap8250_update_mdr1(up, priv);
+			/* Restore wakeup enable register */
+			serial_out(up, UART_OMAP_WER, priv->wer);
+		}
 	}
 
-	if (up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan)
 		omap_8250_rx_dma_flush(up);
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
@@ -1661,18 +1665,15 @@ static int omap8250_runtime_suspend(struct device *dev)
 static int omap8250_runtime_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up;
-
-	/* In case runtime-pm tries this before we are setup */
-	if (!priv)
-		return 0;
+	struct uart_8250_port *up = NULL;
 
-	up = serial8250_get_port(priv->line);
+	if (priv->line >= 0)
+		up = serial8250_get_port(priv->line);
 
-	if (omap8250_lost_context(up))
+	if (up && omap8250_lost_context(up))
 		omap8250_restore_regs(up);
 
-	if (up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
+	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
 		omap_8250_rx_dma(up);
 
 	priv->latency = priv->calc_latency;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 63bb04d262d8..0a77717d6af2 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2745,6 +2745,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	rhdev->rx_lanes = 1;
 	rhdev->tx_lanes = 1;
+	rhdev->ssp_rate = USB_SSP_GEN_UNKNOWN;
 
 	switch (hcd->speed) {
 	case HCD_USB11:
@@ -2762,8 +2763,11 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	case HCD_USB32:
 		rhdev->rx_lanes = 2;
 		rhdev->tx_lanes = 2;
-		fallthrough;
+		rhdev->ssp_rate = USB_SSP_GEN_2x2;
+		rhdev->speed = USB_SPEED_SUPER_PLUS;
+		break;
 	case HCD_USB31:
+		rhdev->ssp_rate = USB_SSP_GEN_2x1;
 		rhdev->speed = USB_SPEED_SUPER_PLUS;
 		break;
 	default:
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 580604596499..cfcd4f2ffffa 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -31,6 +31,7 @@
 #include <linux/pm_qos.h>
 #include <linux/kobject.h>
 
+#include <linux/bitfield.h>
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
 
@@ -149,6 +150,10 @@ int usb_device_supports_lpm(struct usb_device *udev)
 	if (udev->quirks & USB_QUIRK_NO_LPM)
 		return 0;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return 0;
+
 	/* USB 2.1 (and greater) devices indicate LPM support through
 	 * their USB 2.0 Extended Capabilities BOS descriptor.
 	 */
@@ -325,6 +330,10 @@ static void usb_set_lpm_parameters(struct usb_device *udev)
 	if (!udev->lpm_capable || udev->speed < USB_SPEED_SUPER)
 		return;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
 	hub = usb_hub_to_struct_hub(udev->parent);
 	/* It doesn't take time to transition the roothub into U0, since it
 	 * doesn't have an upstream link.
@@ -2683,8 +2692,84 @@ int usb_authorize_device(struct usb_device *usb_dev)
 	return result;
 }
 
+/**
+ * get_port_ssp_rate - Match the extended port status to SSP rate
+ * @hdev: The hub device
+ * @ext_portstatus: extended port status
+ *
+ * Match the extended port status speed id to the SuperSpeed Plus sublink speed
+ * capability attributes. Base on the number of connected lanes and speed,
+ * return the corresponding enum usb_ssp_rate.
+ */
+static enum usb_ssp_rate get_port_ssp_rate(struct usb_device *hdev,
+					   u32 ext_portstatus)
+{
+	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	u32 attr;
+	u8 speed_id;
+	u8 ssac;
+	u8 lanes;
+	int i;
+
+	if (!ssp_cap)
+		goto out;
+
+	speed_id = ext_portstatus & USB_EXT_PORT_STAT_RX_SPEED_ID;
+	lanes = USB_EXT_PORT_RX_LANES(ext_portstatus) + 1;
+
+	ssac = le32_to_cpu(ssp_cap->bmAttributes) &
+		USB_SSP_SUBLINK_SPEED_ATTRIBS;
+
+	for (i = 0; i <= ssac; i++) {
+		u8 ssid;
+
+		attr = le32_to_cpu(ssp_cap->bmSublinkSpeedAttr[i]);
+		ssid = FIELD_GET(USB_SSP_SUBLINK_SPEED_SSID, attr);
+		if (speed_id == ssid) {
+			u16 mantissa;
+			u8 lse;
+			u8 type;
+
+			/*
+			 * Note: currently asymmetric lane types are only
+			 * applicable for SSIC operate in SuperSpeed protocol
+			 */
+			type = FIELD_GET(USB_SSP_SUBLINK_SPEED_ST, attr);
+			if (type == USB_SSP_SUBLINK_SPEED_ST_ASYM_RX ||
+			    type == USB_SSP_SUBLINK_SPEED_ST_ASYM_TX)
+				goto out;
+
+			if (FIELD_GET(USB_SSP_SUBLINK_SPEED_LP, attr) !=
+			    USB_SSP_SUBLINK_SPEED_LP_SSP)
+				goto out;
+
+			lse = FIELD_GET(USB_SSP_SUBLINK_SPEED_LSE, attr);
+			mantissa = FIELD_GET(USB_SSP_SUBLINK_SPEED_LSM, attr);
+
+			/* Convert to Gbps */
+			for (; lse < USB_SSP_SUBLINK_SPEED_LSE_GBPS; lse++)
+				mantissa /= 1000;
+
+			if (mantissa >= 10 && lanes == 1)
+				return USB_SSP_GEN_2x1;
+
+			if (mantissa >= 10 && lanes == 2)
+				return USB_SSP_GEN_2x2;
+
+			if (mantissa >= 5 && lanes == 2)
+				return USB_SSP_GEN_1x2;
+
+			goto out;
+		}
+	}
+
+out:
+	return USB_SSP_GEN_UNKNOWN;
+}
+
 /*
- * Return 1 if port speed is SuperSpeedPlus, 0 otherwise
+ * Return 1 if port speed is SuperSpeedPlus, 0 otherwise or if the
+ * capability couldn't be checked.
  * check it from the link protocol field of the current speed ID attribute.
  * current speed ID is got from ext port status request. Sublink speed attribute
  * table is returned with the hub BOS SSP device capability descriptor
@@ -2694,8 +2779,12 @@ static int port_speed_is_ssp(struct usb_device *hdev, int speed_id)
 	int ssa_count;
 	u32 ss_attr;
 	int i;
-	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	struct usb_ssp_cap_descriptor *ssp_cap;
 
+	if (!hdev->bos)
+		return 0;
+
+	ssp_cap = hdev->bos->ssp_cap;
 	if (!ssp_cap)
 		return 0;
 
@@ -2865,9 +2954,11 @@ static int hub_port_wait_reset(struct usb_hub *hub, int port1,
 		/* extended portstatus Rx and Tx lane count are zero based */
 		udev->rx_lanes = USB_EXT_PORT_RX_LANES(ext_portstatus) + 1;
 		udev->tx_lanes = USB_EXT_PORT_TX_LANES(ext_portstatus) + 1;
+		udev->ssp_rate = get_port_ssp_rate(hub->hdev, ext_portstatus);
 	} else {
 		udev->rx_lanes = 1;
 		udev->tx_lanes = 1;
+		udev->ssp_rate = USB_SSP_GEN_UNKNOWN;
 	}
 	if (hub_is_wusb(hub))
 		udev->speed = USB_SPEED_WIRELESS;
@@ -4114,8 +4205,15 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
 		enum usb3_link_state state)
 {
 	int timeout, ret;
-	__u8 u1_mel = udev->bos->ss_cap->bU1devExitLat;
-	__le16 u2_mel = udev->bos->ss_cap->bU2DevExitLat;
+	__u8 u1_mel;
+	__le16 u2_mel;
+
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
+	u1_mel = udev->bos->ss_cap->bU1devExitLat;
+	u2_mel = udev->bos->ss_cap->bU2DevExitLat;
 
 	/* If the device says it doesn't have *any* exit latency to come out of
 	 * U1 or U2, it's probably lying.  Assume it doesn't implement that link
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 22ea1f4f2d66..db4c7e2c5960 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -141,7 +141,7 @@ static inline int hub_is_superspeedplus(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS &&
 		le16_to_cpu(hdev->descriptor.bcdUSB) >= 0x0310 &&
-		hdev->bos->ssp_cap);
+		hdev->bos && hdev->bos->ssp_cap);
 }
 
 static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b02b10acb884..5bc245b4be44 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,46 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
+	/*
+	 * If the dr_mode is host and the dwc->current_dr_role is not the
+	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
+	 * isn't executed yet. Ensure the phy is ready before the controller
+	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
+	 * the phy.
+	 *
+	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
+	 * is port index. If this is a multiport host, then we need to reset
+	 * all active ports.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		u32 usb3_port;
+		u32 usb2_port;
+
+		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Small delay for phy reset assertion */
+		usleep_range(1000, 2000);
+
+		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Wait for clock synchronization */
+		msleep(50);
+		return 0;
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index f56147489835..00aea45a04e9 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1180,7 +1180,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 			  struct sk_buff_head *list)
 {
 	struct f_ncm	*ncm = func_to_ncm(&port->func);
-	__le16		*tmp = (void *) skb->data;
+	unsigned char	*ntb_ptr = skb->data;
+	__le16		*tmp;
 	unsigned	index, index2;
 	int		ndp_index;
 	unsigned	dg_len, dg_len2;
@@ -1193,6 +1194,10 @@ static int ncm_unwrap_ntb(struct gether *port,
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
+	int		to_process = skb->len;
+
+parse_ntb:
+	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
 	if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1239,7 +1244,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 		 * walk through NDP
 		 * dwSignature
 		 */
-		tmp = (void *)(skb->data + ndp_index);
+		tmp = (__le16 *)(ntb_ptr + ndp_index);
 		if (get_unaligned_le32(tmp) != ncm->ndp_sign) {
 			INFO(port->func.config->cdev, "Wrong NDP SIGN\n");
 			goto err;
@@ -1296,11 +1301,11 @@ static int ncm_unwrap_ntb(struct gether *port,
 			if (ncm->is_crc) {
 				uint32_t crc, crc2;
 
-				crc = get_unaligned_le32(skb->data +
+				crc = get_unaligned_le32(ntb_ptr +
 							 index + dg_len -
 							 crc_len);
 				crc2 = ~crc32_le(~0,
-						 skb->data + index,
+						 ntb_ptr + index,
 						 dg_len - crc_len);
 				if (crc != crc2) {
 					INFO(port->func.config->cdev,
@@ -1327,7 +1332,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 							 dg_len - crc_len);
 			if (skb2 == NULL)
 				goto err;
-			skb_put_data(skb2, skb->data + index,
+			skb_put_data(skb2, ntb_ptr + index,
 				     dg_len - crc_len);
 
 			skb_queue_tail(list, skb2);
@@ -1340,10 +1345,17 @@ static int ncm_unwrap_ntb(struct gether *port,
 		} while (ndp_len > 2 * (opts->dgram_item_len * 2));
 	} while (ndp_index);
 
-	dev_consume_skb_any(skb);
-
 	VDBG(port->func.config->cdev,
 	     "Parsed NTB with %d frames\n", dgram_counter);
+
+	to_process -= block_len;
+	if (to_process != 0) {
+		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
+		goto parse_ntb;
+	}
+
+	dev_consume_skb_any(skb);
+
 	return 0;
 err:
 	skb_queue_purge(list);
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 096f56a09e6a..47486f0f21e5 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -496,11 +496,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -514,11 +516,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1020,7 +1024,7 @@ static int __xudc_ep0_queue(struct xusb_ep *ep0, struct xusb_req *req)
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio((void __iomem *)corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1746,7 +1750,7 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio((void __iomem *)&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16(setup.wValue);
@@ -1833,7 +1837,7 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1909,7 +1913,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio((void __iomem *)ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 7bb306741807..e92f920256b2 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -819,7 +819,7 @@ static void xhci_del_comp_mod_timer(struct xhci_hcd *xhci, u32 status,
 }
 
 static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
-					     u32 *status, u32 portsc,
+					     u32 portsc,
 					     unsigned long *flags)
 {
 	struct xhci_bus_state *bus_state;
@@ -834,11 +834,10 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
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
@@ -855,28 +854,29 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
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
 
@@ -885,7 +885,6 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 							    wIndex + 1);
 			if (!slot_id) {
 				xhci_dbg(xhci, "slot_id is zero\n");
-				*status = 0xffffffff;
 				return -ENODEV;
 			}
 			xhci_ring_device(xhci, slot_id);
@@ -894,22 +893,19 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 
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
 
@@ -961,19 +957,19 @@ static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
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
@@ -986,7 +982,7 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 	struct xhci_bus_state *bus_state;
 	u32 link_state;
 	u32 portnum;
-	int ret;
+	int err;
 
 	bus_state = &port->rhub->bus_state;
 	link_state = portsc & PORT_PLS_MASK;
@@ -1002,22 +998,35 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
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
 
@@ -1073,18 +1082,6 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
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
@@ -1108,11 +1105,14 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1146,10 +1146,12 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1162,7 +1164,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 
 		xhci_dbg(xhci, "Get port status %d-%d read: 0x%x, return 0x%x",
-			 hcd->self.busnum, wIndex + 1, temp, status);
+			 hcd->self.busnum, portnum1, temp, status);
 
 		put_unaligned(cpu_to_le32(status), (__le32 *) buf);
 		/* if USB 3.1 extended port status return additional 4 bytes */
@@ -1174,7 +1176,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				retval = -EINVAL;
 				break;
 			}
-			port_li = readl(ports[wIndex]->addr + PORTLI);
+			port_li = readl(port->addr + PORTLI);
 			status = xhci_get_ext_port_status(temp, port_li);
 			put_unaligned_le32(status, &buf[4]);
 		}
@@ -1188,11 +1190,14 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1202,11 +1207,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1215,16 +1219,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1234,21 +1238,21 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1257,18 +1261,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
 
@@ -1298,11 +1301,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1313,8 +1315,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			/* Can't set port link state above '3' (U3) */
 			if (link_state > USB_SS_PORT_LS_U3) {
 				xhci_warn(xhci, "Cannot set port %d-%d link state %d\n",
-					  hcd->self.busnum, wIndex + 1,
-					  link_state);
+					  hcd->self.busnum, portnum1, link_state);
 				goto error;
 			}
 
@@ -1336,30 +1337,29 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1368,16 +1368,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1392,39 +1392,38 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1440,13 +1439,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1456,7 +1458,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = xhci_port_state_to_neutral(temp);
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "clear USB_PORT_FEAT_SUSPEND\n");
 			xhci_dbg(xhci, "PORTSC %04x\n", temp);
 			if (temp & PORT_RESET)
@@ -1467,20 +1469,18 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
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
@@ -1498,11 +1498,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -1586,8 +1586,8 @@ int xhci_hub_status_data(struct usb_hcd *hcd, char *buf)
 
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
index 390bdf823e08..006e1b15fbda 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2336,6 +2336,9 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 		xhci->hw_ports[i].addr = &xhci->op_regs->port_status_base +
 			NUM_PORT_REGS * i;
 		xhci->hw_ports[i].hw_portnum = i;
+
+		init_completion(&xhci->hw_ports[i].rexit_done);
+		init_completion(&xhci->hw_ports[i].u3exit_done);
 	}
 
 	xhci->rh_bw = kcalloc_node(num_ports, sizeof(*xhci->rh_bw), flags,
@@ -2603,13 +2606,6 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
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
index b69b8c7e7966..5ee095a5d38a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -742,7 +742,7 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		struct xhci_ring *ring, struct xhci_td *td)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
@@ -1851,7 +1851,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 			goto cleanup;
 		} else if (!test_bit(hcd_portnum, &bus_state->resuming_ports)) {
 			xhci_dbg(xhci, "resume HS port %d\n", port_id);
-			bus_state->resume_done[hcd_portnum] = jiffies +
+			port->resume_timestamp = jiffies +
 				msecs_to_jiffies(USB_RESUME_TIMEOUT);
 			set_bit(hcd_portnum, &bus_state->resuming_ports);
 			/* Do the rest in GetPortStatus after resume time delay.
@@ -1860,7 +1860,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 			 */
 			set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 			mod_timer(&hcd->rh_timer,
-				  bus_state->resume_done[hcd_portnum]);
+				  port->resume_timestamp);
 			usb_hcd_start_port_resume(&hcd->self, hcd_portnum);
 			bogus_port_status = true;
 		}
@@ -1872,7 +1872,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
 	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
 		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
-		complete(&bus_state->u3exit_done[hcd_portnum]);
+		complete(&port->u3exit_done);
 		/* We've just brought the device into U0/1/2 through either the
 		 * Resume state after a device remote wakeup, or through the
 		 * U3Exit state after a host-initiated resume.  If it's a device
@@ -1897,10 +1897,9 @@ static void handle_port_status(struct xhci_hcd *xhci,
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
@@ -3325,7 +3324,7 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
 			 u32 *trb_buff_len, struct xhci_segment *seg)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
 	unsigned int max_pkt;
 	u32 new_buff_len;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6a7c05940e66..bb3c362a194b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1699,13 +1699,8 @@ struct xhci_bus_state {
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
 
 
@@ -1729,6 +1724,10 @@ struct xhci_port {
 	struct xhci_hub		*rhub;
 	struct xhci_port_cap	*port_cap;
 	unsigned int		lpm_incapable:1;
+	unsigned long		resume_timestamp;
+	bool			rexit_active;
+	struct completion	rexit_done;
+	struct completion	u3exit_done;
 };
 
 struct xhci_hub {
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 30a89aa8a3e7..5401ae66894e 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -39,7 +39,7 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "IntrUsbE",	MUSB_INTRUSBE,	8 },
 	{ "DevCtl",	MUSB_DEVCTL,	8 },
 	{ "VControl",	0x68,		32 },
-	{ "HWVers",	0x69,		16 },
+	{ "HWVers",	MUSB_HWVERS,	16 },
 	{ "LinkInfo",	MUSB_LINKINFO,	8 },
 	{ "VPLen",	MUSB_VPLEN,	8 },
 	{ "HS_EOF1",	MUSB_HS_EOF1,	8 },
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 30c5e7de0761..1880b0f20df0 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
 
+	/*
+	 * musb->lock had been unlocked in musb_giveback, so qh may
+	 * be freed, need to get it again
+	 */
+	qh = musb_ep_get_qh(hw_ep, is_in);
+
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (qh && list_empty(&qh->hep->urb_list)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2404,6 +2410,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		 * and its URB list has emptied, recycle this qh.
 		 */
 		if (ready && list_empty(&qh->hep->urb_list)) {
+			musb_ep_set_qh(qh->hw_ep, is_in, NULL);
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 83567e6e32e0..3e0579d6ec82 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,6 +203,9 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
+#define DELL_PRODUCT_FM101R			0x8213
+#define DELL_PRODUCT_FM101R_ESIM		0x8215
+
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
 #define KYOCERA_PRODUCT_KPC680			0x180a
@@ -1108,6 +1111,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },
@@ -1290,6 +1295,7 @@ static const struct usb_device_id option_ids[] = {
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
 	 .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1035, 0xff) }, /* Telit LE910C4-WWX (ECM) */
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),
@@ -2262,6 +2268,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmodes/Kconfig
index 60d375e9c3c7..1a6b5e872b0d 100644
--- a/drivers/usb/typec/altmodes/Kconfig
+++ b/drivers/usb/typec/altmodes/Kconfig
@@ -4,6 +4,7 @@ menu "USB Type-C Alternate Mode drivers"
 
 config TYPEC_DP_ALTMODE
 	tristate "DisplayPort Alternate Mode driver"
+	depends on DRM
 	help
 	  DisplayPort USB Type-C Alternate Mode allows DisplayPort
 	  displays and adapters to be attached to the USB Type-C
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 0d4b1c0eeefb..def903e9d2ab 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -11,8 +11,10 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_dp.h>
+#include <drm/drm_connector.h>
 #include "displayport.h"
 
 #define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, cmd) | \
@@ -57,11 +59,13 @@ struct dp_altmode {
 	struct typec_displayport_data data;
 
 	enum dp_state state;
+	bool hpd;
 
 	struct mutex lock; /* device lock */
 	struct work_struct work;
 	struct typec_altmode *alt;
 	const struct typec_altmode *port;
+	struct fwnode_handle *connector_fwnode;
 };
 
 static int dp_altmode_notify(struct dp_altmode *dp)
@@ -122,6 +126,7 @@ static int dp_altmode_configure(struct dp_altmode *dp, u8 con)
 static int dp_altmode_status_update(struct dp_altmode *dp)
 {
 	bool configured = !!DP_CONF_GET_PIN_ASSIGN(dp->data.conf);
+	bool hpd = !!(dp->data.status & DP_STATUS_HPD_STATE);
 	u8 con = DP_STATUS_CONNECTION(dp->data.status);
 	int ret = 0;
 
@@ -134,6 +139,11 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 		ret = dp_altmode_configure(dp, con);
 		if (!ret)
 			dp->state = DP_STATE_CONFIGURE;
+	} else {
+		if (dp->hpd != hpd) {
+			drm_connector_oob_hotplug_event(dp->connector_fwnode);
+			dp->hpd = hpd;
+		}
 	}
 
 	return ret;
@@ -275,6 +285,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 		case CMD_EXIT_MODE:
 			dp->data.status = 0;
 			dp->data.conf = 0;
+			if (dp->hpd) {
+				drm_connector_oob_hotplug_event(dp->connector_fwnode);
+				dp->hpd = false;
+				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
+			}
 			break;
 		case DP_CMD_STATUS_UPDATE:
 			dp->data.status = *vdo;
@@ -526,6 +541,7 @@ static const struct attribute_group dp_altmode_group = {
 int dp_altmode_probe(struct typec_altmode *alt)
 {
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
+	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
 	int ret;
 
@@ -554,6 +570,11 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	alt->desc = "DisplayPort";
 	alt->ops = &dp_altmode_ops;
 
+	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
+	dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
+	if (IS_ERR(dp->connector_fwnode))
+		dp->connector_fwnode = NULL;
+
 	typec_altmode_set_drvdata(alt, dp);
 
 	dp->state = DP_STATE_ENTER;
@@ -569,6 +590,13 @@ void dp_altmode_remove(struct typec_altmode *alt)
 
 	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
+
+	if (dp->connector_fwnode) {
+		if (dp->hpd)
+			drm_connector_oob_hotplug_event(dp->connector_fwnode);
+
+		fwnode_handle_put(dp->connector_fwnode);
+	}
 }
 EXPORT_SYMBOL_GPL(dp_altmode_remove);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4d2f25ebe304..8f62e171053b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1641,12 +1641,12 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		parent = ref->parent;
 	ref_root = ref->root;
 
-	if (node->ref_mod != 1) {
+	if (unlikely(node->ref_mod != 1)) {
 		btrfs_err(trans->fs_info,
-	"btree block(%llu) has %d references rather than 1: action %d ref_root %llu parent %llu",
+	"btree block %llu has %d references rather than 1: action %d ref_root %llu parent %llu",
 			  node->bytenr, node->ref_mod, node->action, ref_root,
 			  parent);
-		return -EIO;
+		return -EUCLEAN;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		BUG_ON(!extent_op || !extent_op->update_flags);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 930126b094ad..cffd149faf63 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3518,7 +3518,7 @@ static void get_block_group_info(struct list_head *groups_list,
 static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 				   void __user *arg)
 {
-	struct btrfs_ioctl_space_args space_args;
+	struct btrfs_ioctl_space_args space_args = { 0 };
 	struct btrfs_ioctl_space_info space;
 	struct btrfs_ioctl_space_info *dest;
 	struct btrfs_ioctl_space_info *dest_orig;
@@ -4858,7 +4858,7 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_send_args_32 args32;
+		struct btrfs_ioctl_send_args_32 args32 = { 0 };
 
 		ret = copy_from_user(&args32, argp, sizeof(args32));
 		if (ret)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9a8dc16673b4..10a0913ffb49 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4337,7 +4337,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int slot;
 	int ins_nr = 0;
-	int start_slot;
+	int start_slot = 0;
 	int ret;
 
 	if (!(inode->flags & BTRFS_INODE_PREALLOC))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 943655e36a79..d4974c652e8e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2428,7 +2428,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		ret = do_splice_direct(src_file, &src_off, dst_file,
 				       &dst_off, src_objlen, flags);
 		/* Abort on short copies or on error */
-		if (ret < src_objlen) {
+		if (ret < (long)src_objlen) {
 			dout("Failed partial copy (%zd)\n", ret);
 			goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 76be50f6f041..36e3342d3633 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -635,9 +635,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
-			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
-					       CEPH_CAP_FILE_RD |
-					       CEPH_CAP_FILE_WR |
+			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_RD |
 					       CEPH_CAP_FILE_LAZYIO));
 			/*
 			 * If we hold relevant caps, or in the case where we're
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 21436721745b..ed6a3ed83755 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2633,31 +2633,44 @@ pnfs_should_return_unused_layout(struct pnfs_layout_hdr *lo,
 	return mode == 0;
 }
 
-static int
-pnfs_layout_return_unused_byserver(struct nfs_server *server, void *data)
+static int pnfs_layout_return_unused_byserver(struct nfs_server *server,
+					      void *data)
 {
 	const struct pnfs_layout_range *range = data;
+	const struct cred *cred;
 	struct pnfs_layout_hdr *lo;
 	struct inode *inode;
+	nfs4_stateid stateid;
+	enum pnfs_iomode iomode;
+
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
-		if (!pnfs_layout_can_be_returned(lo) ||
+		inode = lo->plh_inode;
+		if (!inode || !pnfs_layout_can_be_returned(lo) ||
 		    test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
 			continue;
-		inode = lo->plh_inode;
 		spin_lock(&inode->i_lock);
-		if (!pnfs_should_return_unused_layout(lo, range)) {
+		if (!lo->plh_inode ||
+		    !pnfs_should_return_unused_layout(lo, range)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
+		pnfs_get_layout_hdr(lo);
+		pnfs_set_plh_return_info(lo, range->iomode, 0);
+		if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
+						    range, 0) != 0 ||
+		    !pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode)) {
+			spin_unlock(&inode->i_lock);
+			rcu_read_unlock();
+			pnfs_put_layout_hdr(lo);
+			cond_resched();
+			goto restart;
+		}
 		spin_unlock(&inode->i_lock);
-		inode = pnfs_grab_inode_layout_hdr(lo);
-		if (!inode)
-			continue;
 		rcu_read_unlock();
-		pnfs_mark_layout_for_return(inode, range);
-		iput(inode);
+		pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
+		pnfs_put_layout_hdr(lo);
 		cond_resched();
 		goto restart;
 	}
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7ef3c87f8a23..65ac504595ba 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -243,7 +243,7 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
-		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
+		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
 		.ia_atime = stat->atime,
 		.ia_mtime = stat->mtime,
 	};
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 13a9a17d6a13..fd2ca079448d 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -233,19 +233,18 @@ static void put_quota_format(struct quota_format_type *fmt)
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
- * When the last reference of a dquot will be dropped, the dquot will be
- * added to releasing_dquots. We'd then queue work item which would call
+ * When the last reference of a dquot is dropped, the dquot is added to
+ * releasing_dquots. We'll then queue work item which will call
  * synchronize_srcu() and after that perform the final cleanup of all the
- * dquots on the list. Both releasing_dquots and free_dquots use the
- * dq_free list_head in the dquot struct. When a dquot is removed from
- * releasing_dquots, a reference count is always subtracted, and if
- * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ * dquots on the list. Each cleaned up dquot is moved to free_dquots list.
+ * Both releasing_dquots and free_dquots use the dq_free list_head in the dquot
+ * struct.
  *
- * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
- * and this list is searched whenever we need an available dquot.  Dquots are
- * removed from the list as soon as they are used again, and
- * dqstats.free_dquots gives the number of dquots on the list. When
- * dquot is invalidated it's completely released from memory.
+ * Unused and cleaned up dquots are in the free_dquots list and this list is
+ * searched whenever we need an available dquot. Dquots are removed from the
+ * list as soon as they are used again and dqstats.free_dquots gives the number
+ * of dquots on the list. When dquot is invalidated it's completely released
+ * from memory.
  *
  * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
  * dirtied, and this list is searched when writing dirty dquots back to
@@ -323,6 +322,7 @@ static inline void put_dquot_last(struct dquot *dquot)
 static inline void put_releasing_dquots(struct dquot *dquot)
 {
 	list_add_tail(&dquot->dq_free, &releasing_dquots);
+	set_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void remove_free_dquot(struct dquot *dquot)
@@ -330,8 +330,10 @@ static inline void remove_free_dquot(struct dquot *dquot)
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	if (!atomic_read(&dquot->dq_count))
+	if (!test_bit(DQ_RELEASING_B, &dquot->dq_flags))
 		dqstats_dec(DQST_FREE_DQUOTS);
+	else
+		clear_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -583,12 +585,6 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			/* dquot in releasing_dquots, flush and retry */
-			if (!list_empty(&dquot->dq_free)) {
-				spin_unlock(&dq_list_lock);
-				goto restart;
-			}
-
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -607,6 +603,15 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			 * restart. */
 			goto restart;
 		}
+		/*
+		 * The last user already dropped its reference but dquot didn't
+		 * get fully cleaned up yet. Restart the scan which flushes the
+		 * work cleaning up released dquots.
+		 */
+		if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+			spin_unlock(&dq_list_lock);
+			goto restart;
+		}
 		/*
 		 * Quota now has no users and it has been written on last
 		 * dqput()
@@ -698,6 +703,13 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 						 dq_dirty);
 
 			WARN_ON(!dquot_active(dquot));
+			/* If the dquot is releasing we should not touch it */
+			if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+				spin_unlock(&dq_list_lock);
+				flush_delayed_work(&quota_release_work);
+				spin_lock(&dq_list_lock);
+				continue;
+			}
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
@@ -811,18 +823,18 @@ static void quota_release_workfn(struct work_struct *work)
 	/* Exchange the list head to avoid livelock. */
 	list_replace_init(&releasing_dquots, &rls_head);
 	spin_unlock(&dq_list_lock);
+	synchronize_srcu(&dquot_srcu);
 
 restart:
-	synchronize_srcu(&dquot_srcu);
 	spin_lock(&dq_list_lock);
 	while (!list_empty(&rls_head)) {
 		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
-		/* Dquot got used again? */
-		if (atomic_read(&dquot->dq_count) > 1) {
-			remove_free_dquot(dquot);
-			atomic_dec(&dquot->dq_count);
-			continue;
-		}
+		WARN_ON_ONCE(atomic_read(&dquot->dq_count));
+		/*
+		 * Note that DQ_RELEASING_B protects us from racing with
+		 * invalidate_dquots() calls so we are safe to work with the
+		 * dquot even after we drop dq_list_lock.
+		 */
 		if (dquot_dirty(dquot)) {
 			spin_unlock(&dq_list_lock);
 			/* Commit dquot before releasing */
@@ -836,7 +848,6 @@ static void quota_release_workfn(struct work_struct *work)
 		}
 		/* Dquot is inactive and clean, now move it to free list */
 		remove_free_dquot(dquot);
-		atomic_dec(&dquot->dq_count);
 		put_dquot_last(dquot);
 	}
 	spin_unlock(&dq_list_lock);
@@ -877,6 +888,7 @@ void dqput(struct dquot *dquot)
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
 	put_releasing_dquots(dquot);
+	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
 	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
@@ -965,7 +977,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 		dqstats_inc(DQST_LOOKUPS);
 	}
 	/* Wait for dq_lock - after this we know that either dquot_release() is
-	 * already finished or it will be canceled due to dq_count > 1 test */
+	 * already finished or it will be canceled due to dq_count > 0 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
 	if (!dquot_active(dquot)) {
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 928136556174..03d39532c708 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1030,6 +1030,14 @@ struct drm_connector_funcs {
 	 */
 	void (*atomic_print_state)(struct drm_printer *p,
 				   const struct drm_connector_state *state);
+
+	/**
+	 * @oob_hotplug_event:
+	 *
+	 * This will get called when a hotplug-event for a drm-connector
+	 * has been received from a source outside the display driver / device.
+	 */
+	void (*oob_hotplug_event)(struct drm_connector *connector);
 };
 
 /**
@@ -1174,6 +1182,14 @@ struct drm_connector {
 	struct device *kdev;
 	/** @attr: sysfs attributes */
 	struct device_attribute *attr;
+	/**
+	 * @fwnode: associated fwnode supplied by platform firmware
+	 *
+	 * Drivers can set this to associate a fwnode with a connector, drivers
+	 * are expected to get a reference on the fwnode when setting this.
+	 * drm_connector_cleanup() will call fwnode_handle_put() on this.
+	 */
+	struct fwnode_handle *fwnode;
 
 	/**
 	 * @head:
@@ -1185,6 +1201,14 @@ struct drm_connector {
 	 */
 	struct list_head head;
 
+	/**
+	 * @global_connector_list_entry:
+	 *
+	 * Connector entry in the global connector-list, used by
+	 * drm_connector_find_by_fwnode().
+	 */
+	struct list_head global_connector_list_entry;
+
 	/** @base: base KMS object */
 	struct drm_mode_object base;
 
@@ -1596,6 +1620,7 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 		DRM_CONNECTOR_UNREGISTERED;
 }
 
+void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode);
 const char *drm_get_connector_type_name(unsigned int connector_type);
 const char *drm_get_connector_status_name(enum drm_connector_status status);
 const char *drm_get_subpixel_order_name(enum subpixel_order order);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5135d4b86cd6..f9bf374f9633 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -307,6 +307,13 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
+static inline void irqresource_disabled(struct resource *res, u32 irq)
+{
+	res->start = irq;
+	res->end = irq;
+	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+}
+
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res);
 #else
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 510f87656479..d758c131ed5e 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -32,6 +32,7 @@ struct ipv6_devconf {
 	__s32		max_addresses;
 	__s32		accept_ra_defrtr;
 	__s32		accept_ra_min_hop_limit;
+	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index 71dd10a3d928..01fd26170e6b 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -63,7 +63,6 @@ static inline struct mcb_bus *to_mcb_bus(struct device *dev)
 struct mcb_device {
 	struct device dev;
 	struct mcb_bus *bus;
-	bool is_added;
 	struct mcb_driver *driver;
 	u16 id;
 	int inst;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 302abfc2a1f6..e814ce78a196 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3972,7 +3972,7 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
 		return NET_RX_DROP;
 	}
 
-	skb_scrub_packet(skb, true);
+	skb_scrub_packet(skb, !net_eq(dev_net(dev), dev_net(skb->dev)));
 	skb->priority = 0;
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 93dffe2f3fff..50557d903a05 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -659,6 +659,7 @@ struct perf_event {
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
 
+	unsigned int			group_generation;
 	struct perf_event		*group_leader;
 	struct pmu			*pmu;
 	void				*pmu_private;
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 27aab84fcbaa..b93cb93d1956 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -285,7 +285,9 @@ static inline void dqstats_dec(unsigned int type)
 #define DQ_FAKE_B	3	/* no limits only usage */
 #define DQ_READ_B	4	/* dquot was read into memory */
 #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
-#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
+#define DQ_RELEASING_B	6	/* dquot is in releasing_dquots list waiting
+				 * to be cleaned up */
+#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
 				 * for the mask of entries set via SETQUOTA\
 				 * quotactl. They are set under dq_data_lock\
 				 * and the quota format handling dquot can\
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index a0f6668924d3..4bc8ff2a6614 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -56,7 +56,7 @@ static inline bool dquot_is_busy(struct dquot *dquot)
 {
 	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
 		return true;
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (atomic_read(&dquot->dq_count) > 0)
 		return true;
 	return false;
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index bc5923772703..8bc1119afc31 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -565,6 +565,7 @@ struct usb3_lpm_parameters {
  * @speed: device speed: high/full/low (or error)
  * @rx_lanes: number of rx lanes in use, USB 3.2 adds dual-lane support
  * @tx_lanes: number of tx lanes in use, USB 3.2 adds dual-lane support
+ * @ssp_rate: SuperSpeed Plus phy signaling rate and lane count
  * @tt: Transaction Translator info; used with low/full speed dev, highspeed hub
  * @ttport: device port on that tt hub
  * @toggle: one bit for each endpoint, with ([0] = IN, [1] = OUT) endpoints
@@ -642,6 +643,7 @@ struct usb_device {
 	enum usb_device_speed	speed;
 	unsigned int		rx_lanes;
 	unsigned int		tx_lanes;
+	enum usb_ssp_rate	ssp_rate;
 
 	struct usb_tt	*tt;
 	int		ttport;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 11a92bb4d7a9..e33433ec4a98 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -287,7 +287,7 @@ struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
 
-	char		name[8];
+	const char	*name;
 	unsigned long	flags;
 	__u16		id;
 	__u8		bus;
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 2d5fcda1bcd0..082f89531b88 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -56,7 +56,7 @@ struct hci_mon_new_index {
 	__u8		type;
 	__u8		bus;
 	bdaddr_t	bdaddr;
-	char		name[8];
+	char		name[8] __nonstring;
 } __packed;
 #define HCI_MON_NEW_INDEX_SIZE 16
 
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 088f257cd6fb..0d3cb34c7abc 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -151,6 +151,7 @@ struct fib_info {
 	int			fib_nhs;
 	bool			fib_nh_is_v6;
 	bool			nh_updated;
+	bool			pfsrc_removed;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
 	struct fib_nh		fib_nh[];
diff --git a/include/net/macsec.h b/include/net/macsec.h
index d6fa6b97f6ef..0dc430332939 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -240,6 +240,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 69e4161462fb..7b87da22b295 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -49,6 +49,7 @@ struct netns_xfrm {
 	struct list_head	policy_all;
 	struct hlist_head	*policy_byidx;
 	unsigned int		policy_idx_hmask;
+	unsigned int		idx_generator;
 	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
 	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
diff --git a/include/net/tcp.h b/include/net/tcp.h
index cb4b2fddd9eb..772e59391028 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -141,6 +141,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_RTO_MAX	((unsigned)(120*HZ))
 #define TCP_RTO_MIN	((unsigned)(HZ/5))
 #define TCP_TIMEOUT_MIN	(2U) /* Min timeout for TCP timers in jiffies */
+
+#define TCP_TIMEOUT_MIN_US (2*USEC_PER_MSEC) /* Min TCP timeout in microsecs */
+
 #define TCP_TIMEOUT_INIT ((unsigned)(1*HZ))	/* RFC6298 2.1 initial RTO value	*/
 #define TCP_TIMEOUT_FALLBACK ((unsigned)(3*HZ))	/* RFC 1122 initial RTO value, now
 						 * used as a fallback RTO for the
diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
index 62bb17516713..5ade62ac49b4 100644
--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -39,7 +39,6 @@ TRACE_EVENT(neigh_create,
 	),
 
 	TP_fast_assign(
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->family = tbl->family;
@@ -47,7 +46,6 @@ TRACE_EVENT(neigh_create,
 		__entry->entries = atomic_read(&tbl->gc_entries);
 		__entry->created = n != NULL;
 		__entry->gc_exempt = exempt_from_gc;
-		pin6 = (struct in6_addr *)__entry->primary_key6;
 		p32 = (__be32 *)__entry->primary_key4;
 
 		if (tbl->family == AF_INET)
@@ -57,6 +55,8 @@ TRACE_EVENT(neigh_create,
 
 #if IS_ENABLED(CONFIG_IPV6)
 		if (tbl->family == AF_INET6) {
+			struct in6_addr *pin6;
+
 			pin6 = (struct in6_addr *)__entry->primary_key6;
 			*pin6 = *(struct in6_addr *)pkey;
 		}
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index d44d0483fd73..4fa8511b1e35 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -192,6 +192,13 @@ enum {
 	DEVCONF_ACCEPT_RA_RT_INFO_MIN_PLEN,
 	DEVCONF_NDISC_TCLASS,
 	DEVCONF_RPL_SEG_ENABLED,
+	DEVCONF_RA_DEFRTR_METRIC,
+	DEVCONF_IOAM6_ENABLED,
+	DEVCONF_IOAM6_ID,
+	DEVCONF_IOAM6_ID_WIDE,
+	DEVCONF_NDISC_EVICT_NOCARRIER,
+	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_LFT,
 	DEVCONF_MAX
 };
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 433b9e840b38..b044ce3026eb 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -361,10 +361,9 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 	}
 	css_task_iter_end(&it);
 	length = n;
-	/* now sort & (if procs) strip out duplicates */
+	/* now sort & strip out duplicates (tgids or recycled thread PIDs) */
 	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
+	length = pidlist_uniq(array, length);
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8c5400fd227b..b23961475692 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2053,6 +2053,7 @@ static void perf_group_attach(struct perf_event *event)
 
 	list_add_tail(&event->sibling_list, &group_leader->sibling_list);
 	group_leader->nr_siblings++;
+	group_leader->group_generation++;
 
 	perf_event__header_size(group_leader);
 
@@ -2245,6 +2246,7 @@ static void perf_group_detach(struct perf_event *event)
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
+		event->group_leader->group_generation++;
 		goto out;
 	}
 
@@ -5222,7 +5224,7 @@ static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
 	struct perf_event_context *ctx = leader->ctx;
-	struct perf_event *sub;
+	struct perf_event *sub, *parent;
 	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
@@ -5232,6 +5234,33 @@ static int __perf_read_group_add(struct perf_event *leader,
 		return ret;
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
+	/*
+	 * Verify the grouping between the parent and child (inherited)
+	 * events is still in tact.
+	 *
+	 * Specifically:
+	 *  - leader->ctx->lock pins leader->sibling_list
+	 *  - parent->child_mutex pins parent->child_list
+	 *  - parent->ctx->mutex pins parent->sibling_list
+	 *
+	 * Because parent->ctx != leader->ctx (and child_list nests inside
+	 * ctx->mutex), group destruction is not atomic between children, also
+	 * see perf_event_release_kernel(). Additionally, parent can grow the
+	 * group.
+	 *
+	 * Therefore it is possible to have parent and child groups in a
+	 * different configuration and summing over such a beast makes no sense
+	 * what so ever.
+	 *
+	 * Reject this.
+	 */
+	parent = leader->parent;
+	if (parent &&
+	    (parent->group_generation != leader->group_generation ||
+	     parent->nr_siblings != leader->nr_siblings)) {
+		ret = -ECHILD;
+		goto unlock;
+	}
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -5261,8 +5290,9 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = primary_event_id(sub);
 	}
 
+unlock:
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	return 0;
+	return ret;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -5281,10 +5311,6 @@ static int perf_read_group(struct perf_event *event,
 
 	values[0] = 1 + leader->nr_siblings;
 
-	/*
-	 * By locking the child_mutex of the leader we effectively
-	 * lock the child list of all siblings.. XXX explain how.
-	 */
 	mutex_lock(&leader->child_mutex);
 
 	ret = __perf_read_group_add(leader, read_format, values);
@@ -12820,6 +12846,7 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
+	leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 321cfda1b333..c7f0a02442e5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2451,6 +2451,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_printk(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fa0a0e59b385..37d01e44d483 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5300,9 +5300,13 @@ static int workqueue_apply_unbound_cpumask(void)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
+
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
+		if (!list_empty(&wq->pwqs)) {
+			if (wq->flags & __WQ_ORDERED_EXPLICIT)
+				continue;
+			wq->flags &= ~__WQ_ORDERED;
+		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
 		if (!ctx) {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 19c28a34c5f1..24ca61cf86dd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1136,13 +1136,16 @@ config DEBUG_TIMEKEEPING
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
-	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+	  This option has potential to introduce high runtime overhead,
+	  depending on workload as it triggers debugging routines for each
+	  this_cpu operation. It should only be used for debugging purposes.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 75638404ed57..0f1a3bd09b7b 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -86,7 +86,7 @@ static int __init test_pages(int *total_failures)
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i <= MAX_ORDER; i++)
+	for (i = 0; i < MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9ec9e1e67705..5286945470b9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1279,6 +1279,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	struct page *page, *head;
 	int ret = 0;
 	LIST_HEAD(source);
+	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!pfn_valid(pfn))
@@ -1325,8 +1327,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 						    page_is_file_lru(page));
 
 		} else {
-			pr_warn("failed to isolate pfn %lx\n", pfn);
-			dump_page(page, "isolation failed");
+			if (__ratelimit(&migrate_rs)) {
+				pr_warn("failed to isolate pfn %lx\n", pfn);
+				dump_page(page, "isolation failed");
+			}
 		}
 		put_page(page);
 	}
@@ -1355,9 +1359,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
-				pr_warn("migrating pfn %lx failed ret:%d ",
-				       page_to_pfn(page), ret);
-				dump_page(page, "migration failure");
+				if (__ratelimit(&migrate_rs)) {
+					pr_warn("migrating pfn %lx failed ret:%d\n",
+						page_to_pfn(page), ret);
+					dump_page(page, "migration failure");
+				}
 			}
 			putback_movable_pages(&source);
 		}
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 140d9764c77e..a9f6089a2ae2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1249,6 +1249,15 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Reject outgoing connection to device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (!bacmp(&hdev->bdaddr, dst)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   dst);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
@@ -1426,34 +1435,41 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 	if (!test_bit(HCI_CONN_AUTH, &conn->flags))
 		goto auth;
 
-	/* An authenticated FIPS approved combination key has sufficient
-	 * security for security level 4. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256 &&
-	    sec_level == BT_SECURITY_FIPS)
-		goto encrypt;
-
-	/* An authenticated combination key has sufficient security for
-	   security level 3. */
-	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
-	    sec_level == BT_SECURITY_HIGH)
-		goto encrypt;
-
-	/* An unauthenticated combination key has sufficient security for
-	   security level 1 and 2. */
-	if ((conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_UNAUTH_COMBINATION_P256) &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
-		goto encrypt;
-
-	/* A combination key has always sufficient security for the security
-	   levels 1 or 2. High security level requires the combination key
-	   is generated using maximum PIN code length (16).
-	   For pre 2.1 units. */
-	if (conn->key_type == HCI_LK_COMBINATION &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW ||
-	     conn->pin_length == 16))
-		goto encrypt;
+	switch (conn->key_type) {
+	case HCI_LK_AUTH_COMBINATION_P256:
+		/* An authenticated FIPS approved combination key has
+		 * sufficient security for security level 4 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_FIPS)
+			goto encrypt;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P192:
+		/* An authenticated combination key has sufficient security for
+		 * security level 3 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_HIGH)
+			goto encrypt;
+		break;
+	case HCI_LK_UNAUTH_COMBINATION_P192:
+	case HCI_LK_UNAUTH_COMBINATION_P256:
+		/* An unauthenticated combination key has sufficient security
+		 * for security level 2 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM)
+			goto encrypt;
+		break;
+	case HCI_LK_COMBINATION:
+		/* A combination key has always sufficient security for the
+		 * security levels 2 or lower. High security level requires the
+		 * combination key is generated using maximum PIN code length
+		 * (16). For pre 2.1 units.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM || conn->pin_length == 16)
+			goto encrypt;
+		break;
+	default:
+		break;
+	}
 
 auth:
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 46e1e51ff28e..e33fe4b1c4e2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3734,7 +3734,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
+	error = dev_set_name(&hdev->dev, "hci%u", id);
+	if (error)
+		return error;
+
+	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
@@ -3756,8 +3760,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	dev_set_name(&hdev->dev, "%s", hdev->name);
-
 	error = device_add(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eb111504afc6..ad5294de9759 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -25,6 +25,8 @@
 /* Bluetooth HCI event handling. */
 
 #include <asm/unaligned.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -2701,6 +2703,16 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
+	/* Reject incoming connection from device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   &ev->bdaddr);
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 
@@ -4065,6 +4077,15 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!crypto_memneq(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR",
+			   &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
@@ -4569,8 +4590,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 		 * available, then do not declare that OOB data is
 		 * present.
 		 */
-		if (!memcmp(data->rand256, ZERO_KEY, 16) ||
-		    !memcmp(data->hash256, ZERO_KEY, 16))
+		if (!crypto_memneq(data->rand256, ZERO_KEY, 16) ||
+		    !crypto_memneq(data->hash256, ZERO_KEY, 16))
 			return 0x00;
 
 		return 0x02;
@@ -4580,8 +4601,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	 * not supported by the hardware, then check that if
 	 * P-192 data values are present.
 	 */
-	if (!memcmp(data->rand192, ZERO_KEY, 16) ||
-	    !memcmp(data->hash192, ZERO_KEY, 16))
+	if (!crypto_memneq(data->rand192, ZERO_KEY, 16) ||
+	    !crypto_memneq(data->hash192, ZERO_KEY, 16))
 		return 0x00;
 
 	return 0x01;
@@ -4597,7 +4618,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	hci_conn_hold(conn);
@@ -4842,7 +4863,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	/* Reset the authentication requirement to unknown */
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index eafb2bebc12c..04db39f67c90 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -438,7 +438,8 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, 8);
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index af0f1fa24937..192a43f8efa2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -477,8 +477,8 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 	dout("connect %s\n", ceph_pr_addr(&con->peer_addr));
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 3fba429f1f57..c1e3d3bea128 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -645,19 +645,19 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "     Flags: ");
 
 	for (i = 0; i < NR_PKT_FLAGS; i++) {
-		if (i == F_FLOW_SEQ)
+		if (i == FLOW_SEQ_SHIFT)
 			if (!pkt_dev->cflows)
 				continue;
 
-		if (pkt_dev->flags & (1 << i))
+		if (pkt_dev->flags & (1 << i)) {
 			seq_printf(seq, "%s  ", pkt_flag_names[i]);
-		else if (i == F_FLOW_SEQ)
-			seq_puts(seq, "FLOW_RND  ");
-
 #ifdef CONFIG_XFRM
-		if (i == F_IPSEC && pkt_dev->spi)
-			seq_printf(seq, "spi:%u", pkt_dev->spi);
+			if (i == IPSEC_SHIFT && pkt_dev->spi)
+				seq_printf(seq, "spi:%u  ", pkt_dev->spi);
 #endif
+		} else if (i == FLOW_SEQ_SHIFT) {
+			seq_puts(seq, "FLOW_RND  ");
+		}
 	}
 
 	seq_puts(seq, "\n");
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 28252029bd79..412a3c153cad 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -741,7 +741,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ed20d6ac10dc..bb5255178d75 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1345,15 +1345,18 @@ __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
 				 unsigned char scope)
 {
 	struct fib_nh *nh;
+	__be32 saddr;
 
 	if (nhc->nhc_family != AF_INET)
 		return inet_select_addr(nhc->nhc_dev, 0, scope);
 
 	nh = container_of(nhc, struct fib_nh, nh_common);
-	nh->nh_saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
-	nh->nh_saddr_genid = atomic_read(&net->ipv4.dev_addr_genid);
+	saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
 
-	return nh->nh_saddr;
+	WRITE_ONCE(nh->nh_saddr, saddr);
+	WRITE_ONCE(nh->nh_saddr_genid, atomic_read(&net->ipv4.dev_addr_genid));
+
+	return saddr;
 }
 
 __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
@@ -1367,8 +1370,9 @@ __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
 		struct fib_nh *nh;
 
 		nh = container_of(nhc, struct fib_nh, nh_common);
-		if (nh->nh_saddr_genid == atomic_read(&net->ipv4.dev_addr_genid))
-			return nh->nh_saddr;
+		if (READ_ONCE(nh->nh_saddr_genid) ==
+		    atomic_read(&net->ipv4.dev_addr_genid))
+			return READ_ONCE(nh->nh_saddr);
 	}
 
 	return fib_info_update_nhc_saddr(net, nhc, res->fi->fib_scope);
@@ -1904,6 +1908,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 			continue;
 		if (fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
+			fi->pfsrc_removed = true;
 			ret++;
 		}
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 456240d2adc1..3f4f6458d40e 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1977,6 +1977,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2039,6 +2040,9 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			if (fi->pfsrc_removed)
+				rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+					  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b40780fde791..7a94acbd9f14 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1832,6 +1832,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6c14d67715d1..4df287885dd7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2482,6 +2482,18 @@ static bool tcp_pacing_check(struct sock *sk)
 	return true;
 }
 
+static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
+{
+	const struct rb_node *node = sk->tcp_rtx_queue.rb_node;
+
+	/* No skb in the rtx queue. */
+	if (!node)
+		return true;
+
+	/* Only one skb in rtx queue. */
+	return !node->rb_left && !node->rb_right;
+}
+
 /* TCP Small Queues :
  * Control number of packets in qdisc/devices to two packets / or ~1 ms.
  * (These limits are doubled for retransmits)
@@ -2519,12 +2531,12 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 		limit += extra_bytes;
 	}
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
-		/* Always send skb if rtx queue is empty.
+		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
 		 * after softirq/tasklet schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
-		if (tcp_rtx_queue_empty(sk))
+		if (tcp_rtx_queue_empty_or_single_skb(sk))
 			return false;
 
 		set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
@@ -2727,7 +2739,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 timeout, rto_delta_us;
+	u32 timeout, timeout_us, rto_delta_us;
 	int early_retrans;
 
 	/* Don't do any loss probe on a Fast Open connection before 3WHS
@@ -2751,11 +2763,12 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	 * sample is available then probe after TCP_TIMEOUT_INIT.
 	 */
 	if (tp->srtt_us) {
-		timeout = usecs_to_jiffies(tp->srtt_us >> 2);
+		timeout_us = tp->srtt_us >> 2;
 		if (tp->packets_out == 1)
-			timeout += TCP_RTO_MIN;
+			timeout_us += tcp_rto_min_us(sk);
 		else
-			timeout += TCP_TIMEOUT_MIN;
+			timeout_us += TCP_TIMEOUT_MIN_US;
+		timeout = usecs_to_jiffies(timeout_us);
 	} else {
 		timeout = TCP_TIMEOUT_INIT;
 	}
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index 21fc9859d421..f84c5804e2db 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -109,7 +109,7 @@ bool tcp_rack_mark_lost(struct sock *sk)
 	tp->rack.advanced = 0;
 	tcp_rack_detect_loss(sk, &timeout);
 	if (timeout) {
-		timeout = usecs_to_jiffies(timeout) + TCP_TIMEOUT_MIN;
+		timeout = usecs_to_jiffies(timeout + TCP_TIMEOUT_MIN_US);
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_REO_TIMEOUT,
 					  timeout, inet_csk(sk)->icsk_rto);
 	}
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0eafe26c05f7..193e5f275733 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -207,6 +207,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.accept_ra_defrtr	= 1,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
+	.accept_ra_min_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -262,6 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.accept_ra_defrtr	= 1,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
+	.accept_ra_min_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -2724,6 +2726,9 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 		return;
 	}
 
+	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
+		goto put;
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5559,6 +5564,7 @@ static inline void ipv6_store_devconf(struct ipv6_devconf *cnf,
 	array[DEVCONF_DISABLE_POLICY] = cnf->disable_policy;
 	array[DEVCONF_NDISC_TCLASS] = cnf->ndisc_tclass;
 	array[DEVCONF_RPL_SEG_ENABLED] = cnf->rpl_seg_enabled;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] = cnf->accept_ra_min_lft;
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -6716,6 +6722,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "accept_ra_min_lft",
+		.data		= &ipv6_devconf.accept_ra_min_lft,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "accept_ra_pinfo",
 		.data		= &ipv6_devconf.accept_ra_pinfo,
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index cb28f8928f9e..fddc811bbde1 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -776,7 +776,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ac1e51087b1d..14251347c4a5 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1269,6 +1269,14 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 		goto skip_defrtr;
 	}
 
+	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_defrtr;
+	}
+
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
@@ -1281,8 +1289,6 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 		goto skip_defrtr;
 	}
 
-	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref = ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1453,6 +1459,9 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 			if (ri->prefix_len == 0 &&
 			    !in6_dev->cnf.accept_ra_defrtr)
 				continue;
+			if (ri->lifetime != 0 &&
+			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+				continue;
 			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
 				continue;
 			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 247296e3294b..4c3aa97f23fa 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -120,11 +120,11 @@ static void xfrm6_dst_destroy(struct dst_entry *dst)
 {
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 
-	if (likely(xdst->u.rt6.rt6i_idev))
-		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	dst_destroy_metrics_generic(dst);
 	if (xdst->u.rt6.rt6i_uncached_list)
 		rt6_uncached_list_del(&xdst->u.rt6);
+	if (likely(xdst->u.rt6.rt6i_idev))
+		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	xfrm_dst_destroy(xdst);
 }
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bbbcc678c655..788b6a3c1419 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -656,7 +656,8 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		}
 
 		if (unlikely(tx->key && tx->key->flags & KEY_FLAG_TAINTED &&
-			     !ieee80211_is_deauth(hdr->frame_control)))
+			     !ieee80211_is_deauth(hdr->frame_control)) &&
+			     tx->skb->protocol != tx->sdata->control_port_protocol)
 			return TX_DROP;
 
 		if (!skip_hw && tx->key &&
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index e45ffa762bbe..87b1cf69b9c2 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1441,7 +1441,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1548,7 +1548,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index b2b63c3653d4..56f6c05362ae 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -93,7 +93,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 
 	switch (priv->base) {
 	case NFT_PAYLOAD_LL_HEADER:
-		if (!skb_mac_header_was_set(skb))
+		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
 		if (skb_vlan_tag_present(skb)) {
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 17abf17b673e..12d9d0d0c602 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -570,6 +570,8 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
+			} else if (nft_set_elem_expired(&rbe->ext)) {
+				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
 				continue;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index b1107570eaee..92f70686bee0 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -205,17 +205,13 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
 
 		if (tmp_sock->ssap == ssap && tmp_sock->dsap == dsap) {
 			llcp_sock = tmp_sock;
+			sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
 
 	read_unlock(&local->sockets.lock);
 
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
 	return llcp_sock;
 }
 
@@ -348,7 +344,8 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    const u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len,
+					    bool needref)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -384,6 +381,8 @@ struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
 
 		if (memcmp(sn, tmp_sock->service_name, sn_len) == 0) {
 			llcp_sock = tmp_sock;
+			if (needref)
+				sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
@@ -425,7 +424,8 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 		 * to this service name.
 		 */
 		if (nfc_llcp_sock_from_sn(local, sock->service_name,
-					  sock->service_name_len) != NULL) {
+					  sock->service_name_len,
+					  false) != NULL) {
 			mutex_unlock(&local->sdp_lock);
 
 			return LLCP_SAP_MAX;
@@ -833,16 +833,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 						  const u8 *sn, size_t sn_len)
 {
-	struct nfc_llcp_sock *llcp_sock;
-
-	llcp_sock = nfc_llcp_sock_from_sn(local, sn, sn_len);
-
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
-	return llcp_sock;
+	return nfc_llcp_sock_from_sn(local, sn, sn_len, true);
 }
 
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
@@ -1307,7 +1298,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			}
 
 			llcp_sock = nfc_llcp_sock_from_sn(local, service_name,
-							  service_name_len);
+							  service_name_len,
+							  true);
 			if (!llcp_sock) {
 				sap = 0;
 				goto add_snl;
@@ -1327,6 +1319,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 				if (sap == LLCP_SAP_MAX) {
 					sap = 0;
+					nfc_llcp_sock_put(llcp_sock);
 					goto add_snl;
 				}
 
@@ -1344,6 +1337,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 			pr_debug("%p %d\n", llcp_sock, sap);
 
+			nfc_llcp_sock_put(llcp_sock);
 add_snl:
 			sdp = nfc_llcp_build_sdres_tlv(tid, sap);
 			if (sdp == NULL)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index ed9019d807c7..4c931bd1c174 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -894,6 +894,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
diff --git a/net/nfc/nci/spi.c b/net/nfc/nci/spi.c
index 7d8e10e27c20..0651640d6868 100644
--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -151,6 +151,8 @@ static int send_acknowledge(struct nci_spi *nspi, u8 acknowledge)
 	int ret;
 
 	skb = nci_skb_alloc(nspi->ndev, 0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 
 	/* add the NCI SPI header to the start of the buffer */
 	hdr = skb_push(skb, NCI_SPI_HDR_LEN);
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 2f38dac0160e..09967bab2c36 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -141,7 +141,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = sock->ops->bind(sock, addr, addrlen);
+	ret = kernel_bind(sock, addr, addrlen);
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 09cadd556d1e..3994eeef95a3 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -301,7 +301,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		addr_len = sizeof(*sin);
 	}
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&ss, addr_len);
+	ret = kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
 	if (ret < 0) {
 		rdsdebug("could not bind %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index f5afc9bcdee6..2cc95c8dc4c7 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -98,13 +98,13 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 
 	rfkill->clk = devm_clk_get(&pdev->dev, NULL);
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
 	rfkill->reset_gpio = gpio;
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 6076294a632c..adcf87d417ae 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -903,6 +903,14 @@ hfsc_change_usc(struct hfsc_class *cl, struct tc_service_curve *usc,
 	cl->cl_flags |= HFSC_USC;
 }
 
+static void
+hfsc_upgrade_rt(struct hfsc_class *cl)
+{
+	cl->cl_fsc = cl->cl_rsc;
+	rtsc_init(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total);
+	cl->cl_flags |= HFSC_FSC;
+}
+
 static const struct nla_policy hfsc_policy[TCA_HFSC_MAX + 1] = {
 	[TCA_HFSC_RSC]	= { .len = sizeof(struct tc_service_curve) },
 	[TCA_HFSC_FSC]	= { .len = sizeof(struct tc_service_curve) },
@@ -1012,10 +1020,6 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
-	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
-		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
-		return -EINVAL;
-	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
@@ -1068,6 +1072,12 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	cl->cf_tree = RB_ROOT;
 
 	sch_tree_lock(sch);
+	/* Check if the inner class is a misconfigured 'rt' */
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack,
+			       "Forced curve change on parent 'rt' to 'sc'");
+		hfsc_upgrade_rt(parent);
+	}
 	qdisc_class_hash_insert(&q->clhash, &cl->cl_common);
 	list_add_tail(&cl->siblings, &parent->children);
 	if (parent->level == 0)
diff --git a/net/socket.c b/net/socket.c
index de89ab55d475..36e38ee434ea 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3414,7 +3414,11 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
-	return sock->ops->bind(sock, addr, addrlen);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->bind(sock, (struct sockaddr *)&address, addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ea36d8c47b31..0ac829c8f188 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7467,7 +7467,7 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct mesh_config cfg;
+	struct mesh_config cfg = {};
 	u32 mask;
 	int err;
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f59691936e5b..1e6dfe204ff3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -875,6 +875,10 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		    !cfg80211_find_ssid_match(ap, request))
 			continue;
 
+		if (!is_broadcast_ether_addr(request->bssid) &&
+		    !ether_addr_equal(request->bssid, ap->bssid))
+			continue;
+
 		if (!request->n_ssids && ap->multi_bss && !ap->transmitted_bssid)
 			continue;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 4eeec3367575..9eaf0174d998 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -274,8 +274,8 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	skb->dev = dev;
 
 	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
+		DEV_STATS_INC(dev, rx_errors);
+		DEV_STATS_INC(dev, rx_dropped);
 
 		return 0;
 	}
@@ -309,7 +309,6 @@ static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
 	struct net_device *tdev;
@@ -335,7 +334,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	tdev = dst->dev;
 
 	if (tdev == dev) {
-		stats->collisions++;
+		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     dev->name);
 		goto tx_err_dst_release;
@@ -378,13 +377,13 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 		tstats->tx_packets++;
 		u64_stats_update_end(&tstats->syncp);
 	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	}
 
 	return 0;
 tx_err_link_failure:
-	stats->tx_carrier_errors++;
+	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
@@ -394,7 +393,6 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	struct flowi fl;
 	int ret;
@@ -411,7 +409,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
 			if (dst->error) {
 				dst_release(dst);
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, dst);
@@ -427,7 +425,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
 			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
 			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, &rt->dst);
@@ -446,8 +444,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
+	DEV_STATS_INC(dev, tx_errors);
+	DEV_STATS_INC(dev, tx_dropped);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 465d28341ed6..664d55957feb 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1371,8 +1371,6 @@ EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
  * of an absolute inpredictability of ordering of rules. This will not pass. */
 static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 {
-	static u32 idx_generator;
-
 	for (;;) {
 		struct hlist_head *list;
 		struct xfrm_policy *p;
@@ -1380,8 +1378,8 @@ static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 		int found;
 
 		if (!index) {
-			idx = (idx_generator | dir);
-			idx_generator += 8;
+			idx = (net->xfrm.idx_generator | dir);
+			net->xfrm.idx_generator += 8;
 		} else {
 			idx = index;
 			index = 0;
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c4e7307a4437..d847263a18b9 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -797,7 +797,7 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		if (IS_ERR(priv->extclk)) {
 			ret = PTR_ERR(priv->extclk);
 			if (ret == -EPROBE_DEFER)
-				return ret;
+				goto err_priv;
 
 			priv->extclk = NULL;
 		}
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 18d33684faad..7536ff2f890a 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -21,19 +21,23 @@ if [[ "$1" == "-cgroup-v2" ]]; then
   reservation_usage_file=rsvd.current
 fi
 
-cgroup_path=/dev/cgroup/memory
-if [[ ! -e $cgroup_path ]]; then
-  mkdir -p $cgroup_path
-  if [[ $cgroup2 ]]; then
+if [[ $cgroup2 ]]; then
+  cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
+  if [[ -z "$cgroup_path" ]]; then
+    cgroup_path=/dev/cgroup/memory
     mount -t cgroup2 none $cgroup_path
-  else
+    do_umount=1
+  fi
+  echo "+hugetlb" >$cgroup_path/cgroup.subtree_control
+else
+  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
+  if [[ -z "$cgroup_path" ]]; then
+    cgroup_path=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $cgroup_path
+    do_umount=1
   fi
 fi
-
-if [[ $cgroup2 ]]; then
-  echo "+hugetlb" >/dev/cgroup/memory/cgroup.subtree_control
-fi
+export cgroup_path
 
 function cleanup() {
   if [[ $cgroup2 ]]; then
@@ -105,7 +109,7 @@ function setup_cgroup() {
 
 function wait_for_hugetlb_memory_to_get_depleted() {
   local cgroup="$1"
-  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
+  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
   # Wait for hugetlbfs memory to get depleted.
   while [ $(cat $path) != 0 ]; do
     echo Waiting for hugetlb memory to get depleted.
@@ -118,7 +122,7 @@ function wait_for_hugetlb_memory_to_get_reserved() {
   local cgroup="$1"
   local size="$2"
 
-  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
+  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
   # Wait for hugetlbfs memory to get written.
   while [ $(cat $path) != $size ]; do
     echo Waiting for hugetlb memory reservation to reach size $size.
@@ -131,7 +135,7 @@ function wait_for_hugetlb_memory_to_get_written() {
   local cgroup="$1"
   local size="$2"
 
-  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
+  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
   # Wait for hugetlbfs memory to get written.
   while [ $(cat $path) != $size ]; do
     echo Waiting for hugetlb memory to reach size $size.
@@ -571,5 +575,7 @@ for populate in "" "-o"; do
   done     # populate
 done       # method
 
-umount $cgroup_path
-rmdir $cgroup_path
+if [[ $do_umount ]]; then
+  umount $cgroup_path
+  rmdir $cgroup_path
+fi
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index d11d1febccc3..c665b16f1e37 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -15,19 +15,24 @@ if [[ "$1" == "-cgroup-v2" ]]; then
   usage_file=current
 fi
 
-CGROUP_ROOT='/dev/cgroup/memory'
-MNT='/mnt/huge/'
 
-if [[ ! -e $CGROUP_ROOT ]]; then
-  mkdir -p $CGROUP_ROOT
-  if [[ $cgroup2 ]]; then
+if [[ $cgroup2 ]]; then
+  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
+  if [[ -z "$CGROUP_ROOT" ]]; then
+    CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup2 none $CGROUP_ROOT
-    sleep 1
-    echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
-  else
+    do_umount=1
+  fi
+  echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
+else
+  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
+  if [[ -z "$CGROUP_ROOT" ]]; then
+    CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $CGROUP_ROOT
+    do_umount=1
   fi
 fi
+MNT='/mnt/huge/'
 
 function get_machine_hugepage_size() {
   hpz=$(grep -i hugepagesize /proc/meminfo)
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
index d3d0d108924d..70a02301f4c2 100644
--- a/tools/testing/selftests/vm/write_hugetlb_memory.sh
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -14,7 +14,7 @@ want_sleep=$8
 reserve=$9
 
 echo "Putting task in cgroup '$cgroup'"
-echo $$ > /dev/cgroup/memory/"$cgroup"/cgroup.procs
+echo $$ > ${cgroup_path:-/dev/cgroup/memory}/"$cgroup"/cgroup.procs
 
 echo "Method is $method"
 
