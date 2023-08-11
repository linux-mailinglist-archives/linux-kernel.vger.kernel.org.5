Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB20778BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjHKKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjHKKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443E212B;
        Fri, 11 Aug 2023 03:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C427C63525;
        Fri, 11 Aug 2023 10:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B70C433C8;
        Fri, 11 Aug 2023 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691749047;
        bh=SrwoEw7qR5CWQ0NksRcYUnDQJMt+H3EcUMhWi4RL148=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4HtorKeM1W1cGcGc//s+NsdwH2KCiMKqOaUc8GvWLp1VPoEmHA7CW6YsyeH1MtOi
         eIaKFx8xo4O66xT7lvLjzfEmTI2oPRBDvY2CentY0OmtlFPeNh0/VDNohP1WimgXSp
         zeJKFEMFtMKeFH7NVrANsoLm5WT4GN4VQ1vcHZPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.291
Date:   Fri, 11 Aug 2023 12:17:14 +0200
Message-ID: <2023081114-pucker-putdown-2fff@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081114-zone-ebony-d4a9@gregkh>
References: <2023081114-zone-ebony-d4a9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 30187d49dc2c..67161e1b0f0b 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -56,31 +56,28 @@ information submitted to the security list and any followup discussions
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d3d7f5d1c3f..59003315a959 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1180,7 +1180,7 @@ N:	owl
 F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
-F:	drivers/clocksource/owl-*
+F:	drivers/clocksource/timer-owl*
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1603,7 +1603,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/lpc43*
 F:	drivers/clk/nxp/clk-lpc18xx*
-F:	drivers/clocksource/time-lpc32xx.c
+F:	drivers/clocksource/timer-lpc32xx.c
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/nxp-spifi.c
@@ -2219,7 +2219,7 @@ F:	arch/arm/mach-vexpress/
 F:	*/*/vexpress*
 F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
-F:	drivers/clocksource/versatile.c
+F:	drivers/clocksource/timer-versatile.c
 N:	mps2
 
 ARM/VFP SUPPORT
@@ -2241,7 +2241,7 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
-F:	drivers/clocksource/vt8500_timer.c
+F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-wmt.c
 F:	drivers/mmc/host/wmt-sdmmc.c
 F:	drivers/pwm/pwm-vt8500.c
@@ -2306,7 +2306,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
-F:	drivers/clocksource/cadence_ttc_timer.c
+F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 F:	drivers/edac/synopsys_edac.c
diff --git a/Makefile b/Makefile
index 5cd8768fc083..f110fc4f127f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 290
+SUBLEVEL = 291
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 225e7df2d8ed..0733752ce7fe 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -7,232 +7,252 @@
 #include <asm/irqflags-arcv2.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
+/*
+ * Interrupt/Exception stack layout (pt_regs) for ARCv2
+ *   (End of struct aligned to end of page [unless nested])
+ *
+ *  INTERRUPT                          EXCEPTION
+ *
+ *    manual    ---------------------  manual
+ *              |      orig_r0      |
+ *              |      event/ECR    |
+ *              |      bta          |
+ *              |      user_r25     |
+ *              |      gp           |
+ *              |      fp           |
+ *              |      sp           |
+ *              |      r12          |
+ *              |      r30          |
+ *              |      r58          |
+ *              |      r59          |
+ *  hw autosave ---------------------
+ *    optional  |      r0           |
+ *              |      r1           |
+ *              ~                   ~
+ *              |      r9           |
+ *              |      r10          |
+ *              |      r11          |
+ *              |      blink        |
+ *              |      lpe          |
+ *              |      lps          |
+ *              |      lpc          |
+ *              |      ei base      |
+ *              |      ldi base     |
+ *              |      jli base     |
+ *              ---------------------
+ *  hw autosave |       pc / eret   |
+ *   mandatory  | stat32 / erstatus |
+ *              ---------------------
+ */
+
 /*------------------------------------------------------------------------*/
-.macro INTERRUPT_PROLOGUE	called_from
+.macro INTERRUPT_PROLOGUE
 
-	; Before jumping to Interrupt Vector, hardware micro-ops did following:
+	; (A) Before jumping to Interrupt Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1, K:0)
-	;   3. Auto saved: r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI, PC, STAT32
+	;   2. STATUS32.Z flag set if in U mode at time of interrupt (U:1,K:0)
+	;   3. Auto save: (mandatory) Push PC and STAT32 on stack
+	;                 hardware does even if CONFIG_ARC_IRQ_NO_AUTOSAVE
+	;   4. Auto save: (optional) r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI
 	;
-	; Now manually save: r12, sp, fp, gp, r25
+	; (B) Manually saved some regs: r12,r25,r30, sp,fp,gp, ACCL pair
 
 #ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
-.ifnc \called_from, exception
-	st.as	r9, [sp, -10]	; save r9 in it's final stack slot
-	sub	sp, sp, 12	; skip JLI, LDI, EI
-
-	PUSH	lp_count
-	PUSHAX	lp_start
-	PUSHAX	lp_end
-	PUSH	blink
-
-	PUSH	r11
-	PUSH	r10
-
-	sub	sp, sp, 4	; skip r9
-
-	PUSH	r8
-	PUSH	r7
-	PUSH	r6
-	PUSH	r5
-	PUSH	r4
-	PUSH	r3
-	PUSH	r2
-	PUSH	r1
-	PUSH	r0
-.endif
-#endif
+	; carve pt_regs on stack (case #3), PC/STAT32 already on stack
+	sub	sp, sp, SZ_PT_REGS - 8
 
-#ifdef CONFIG_ARC_HAS_ACCL_REGS
-	PUSH	r59
-	PUSH	r58
+	__SAVE_REGFILE_HARD
+#else
+	; carve pt_regs on stack (case #4), which grew partially already
+	sub	sp, sp, PT_r0
 #endif
 
-	PUSH	r30
-	PUSH	r12
+	__SAVE_REGFILE_SOFT
+.endm
+
+/*------------------------------------------------------------------------*/
+.macro EXCEPTION_PROLOGUE
+
+	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
+	;   1. SP auto-switched to kernel mode stack
+	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
+	;
+	; (B) Manually save the complete reg file below
+
+	sub	sp, sp, SZ_PT_REGS	; carve pt_regs
+
+	; _HARD saves r10 clobbered by _SOFT as scratch hence comes first
+
+	__SAVE_REGFILE_HARD
+	__SAVE_REGFILE_SOFT
+
+	st	r0, [sp]	; orig_r0
+
+	lr	r10, [eret]
+	lr	r11, [erstatus]
+	ST2	r10, r11, PT_ret
+
+	lr	r10, [ecr]
+	lr	r11, [erbta]
+	ST2	r10, r11, PT_event
+	mov	r9, r10
+
+	; OUTPUT: r9 has ECR
+.endm
+
+/*------------------------------------------------------------------------
+ * This macro saves the registers manually which would normally be autosaved
+ * by hardware on taken interrupts. It is used by
+ *   - exception handlers (which don't have autosave)
+ *   - interrupt autosave disabled due to CONFIG_ARC_IRQ_NO_AUTOSAVE
+ */
+.macro __SAVE_REGFILE_HARD
+
+	ST2	r0,  r1,  PT_r0
+	ST2	r2,  r3,  PT_r2
+	ST2	r4,  r5,  PT_r4
+	ST2	r6,  r7,  PT_r6
+	ST2	r8,  r9,  PT_r8
+	ST2	r10, r11, PT_r10
+
+	st	blink, [sp, PT_blink]
+
+	lr	r10, [lp_end]
+	lr	r11, [lp_start]
+	ST2	r10, r11, PT_lpe
+
+	st	lp_count, [sp, PT_lpc]
+
+	; skip JLI, LDI, EI for now
+.endm
+
+/*------------------------------------------------------------------------
+ * This macros saves a bunch of other registers which can't be autosaved for
+ * various reasons:
+ *   - r12: the last caller saved scratch reg since hardware saves in pairs so r0-r11
+ *   - r30: free reg, used by gcc as scratch
+ *   - ACCL/ACCH pair when they exist
+ */
+.macro __SAVE_REGFILE_SOFT
+
+	ST2	gp, fp, PT_r26		; gp (r26), fp (r27)
+
+	st	r12, [sp, PT_sp + 4]
+	st	r30, [sp, PT_sp + 8]
 
 	; Saving pt_regs->sp correctly requires some extra work due to the way
 	; Auto stack switch works
 	;  - U mode: retrieve it from AUX_USER_SP
 	;  - K mode: add the offset from current SP where H/w starts auto push
 	;
-	; Utilize the fact that Z bit is set if Intr taken in U mode
-	mov.nz	r9, sp
-	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4
-	bnz	1f
+	; 1. Utilize the fact that Z bit is set if Intr taken in U mode
+	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
+	;    but on return, restored only if U mode
 
-	lr	r9, [AUX_USER_SP]
-1:
-	PUSH	r9	; SP
+	lr	r10, [AUX_USER_SP]	; U mode SP
+
+	; ISA requires ADD.nz to have same dest and src reg operands
+	mov.nz	r10, sp
+	add.nz	r10, r10, SZ_PT_REGS	; K mode SP
 
-	PUSH	fp
-	PUSH	gp
+	st	r10, [sp, PT_sp]	; SP (pt_regs->sp)
 
 #ifdef CONFIG_ARC_CURR_IN_REG
-	PUSH	r25			; user_r25
+	st	r25, [sp, PT_user_r25]
 	GET_CURR_TASK_ON_CPU	r25
-#else
-	sub	sp, sp, 4
 #endif
 
-.ifnc \called_from, exception
-	sub	sp, sp, 12	; BTA/ECR/orig_r0 placeholder per pt_regs
-.endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	ST2	r58, r59, PT_sp + 12
+#endif
 
 .endm
 
 /*------------------------------------------------------------------------*/
-.macro INTERRUPT_EPILOGUE	called_from
+.macro __RESTORE_REGFILE_SOFT
 
-.ifnc \called_from, exception
-	add	sp, sp, 12	; skip BTA/ECR/orig_r0 placeholderss
-.endif
+	LD2	gp, fp, PT_r26		; gp (r26), fp (r27)
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	POP	r25
-#else
-	add	sp, sp, 4
-#endif
+	ld	r12, [sp, PT_sp + 4]
+	ld	r30, [sp, PT_sp + 8]
 
-	POP	gp
-	POP	fp
-
-	; Don't touch AUX_USER_SP if returning to K mode (Z bit set)
-	; (Z bit set on K mode is inverse of INTERRUPT_PROLOGUE)
-	add.z	sp, sp, 4
+	; Restore SP (into AUX_USER_SP) only if returning to U mode
+	;  - for K mode, it will be implicitly restored as stack is unwound
+	;  - Z flag set on K is inverse of what hardware does on interrupt entry
+	;    but that doesn't really matter
 	bz	1f
 
-	POPAX	AUX_USER_SP
+	ld	r10, [sp, PT_sp]	; SP (pt_regs->sp)
+	sr	r10, [AUX_USER_SP]
 1:
-	POP	r12
-	POP	r30
 
-#ifdef CONFIG_ARC_HAS_ACCL_REGS
-	POP	r58
-	POP	r59
+#ifdef CONFIG_ARC_CURR_IN_REG
+	ld	r25, [sp, PT_user_r25]
 #endif
 
-#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
-.ifnc \called_from, exception
-	POP	r0
-	POP	r1
-	POP	r2
-	POP	r3
-	POP	r4
-	POP	r5
-	POP	r6
-	POP	r7
-	POP	r8
-	POP	r9
-	POP	r10
-	POP	r11
-
-	POP	blink
-	POPAX	lp_end
-	POPAX	lp_start
-
-	POP	r9
-	mov	lp_count, r9
-
-	add	sp, sp, 12	; skip JLI, LDI, EI
-	ld.as	r9, [sp, -10]	; reload r9 which got clobbered
-.endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	LD2	r58, r59, PT_sp + 12
 #endif
+.endm
 
+/*------------------------------------------------------------------------*/
+.macro __RESTORE_REGFILE_HARD
+
+	ld	blink, [sp, PT_blink]
+
+	LD2	r10, r11, PT_lpe
+	sr	r10, [lp_end]
+	sr	r11, [lp_start]
+
+	ld	r10, [sp, PT_lpc]	; lp_count can't be target of LD
+	mov	lp_count, r10
+
+	LD2	r0,  r1,  PT_r0
+	LD2	r2,  r3,  PT_r2
+	LD2	r4,  r5,  PT_r4
+	LD2	r6,  r7,  PT_r6
+	LD2	r8,  r9,  PT_r8
+	LD2	r10, r11, PT_r10
 .endm
 
+
 /*------------------------------------------------------------------------*/
-.macro EXCEPTION_PROLOGUE
+.macro INTERRUPT_EPILOGUE
 
-	; Before jumping to Exception Vector, hardware micro-ops did following:
-	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1,K:0)
-	;
-	; Now manually save the complete reg file
-
-	PUSH	r9		; freeup a register: slot of erstatus
-
-	PUSHAX	eret
-	sub	sp, sp, 12	; skip JLI, LDI, EI
-	PUSH	lp_count
-	PUSHAX	lp_start
-	PUSHAX	lp_end
-	PUSH	blink
-
-	PUSH	r11
-	PUSH	r10
-
-	ld.as	r9,  [sp, 10]	; load stashed r9 (status32 stack slot)
-	lr	r10, [erstatus]
-	st.as	r10, [sp, 10]	; save status32 at it's right stack slot
-
-	PUSH	r9
-	PUSH	r8
-	PUSH	r7
-	PUSH	r6
-	PUSH	r5
-	PUSH	r4
-	PUSH	r3
-	PUSH	r2
-	PUSH	r1
-	PUSH	r0
-
-	; -- for interrupts, regs above are auto-saved by h/w in that order --
-	; Now do what ISR prologue does (manually save r12, sp, fp, gp, r25)
-	;
-	; Set Z flag if this was from U mode (expected by INTERRUPT_PROLOGUE)
-	; Although H/w exception micro-ops do set Z flag for U mode (just like
-	; for interrupts), it could get clobbered in case we soft land here from
-	; a TLB Miss exception handler (tlbex.S)
+	; INPUT: r0 has STAT32 of calling context
+	; INPUT: Z flag set if returning to K mode
 
-	and	r10, r10, STATUS_U_MASK
-	xor.f	0, r10, STATUS_U_MASK
+	; _SOFT clobbers r10 restored by _HARD hence the order
 
-	INTERRUPT_PROLOGUE  exception
+	__RESTORE_REGFILE_SOFT
 
-	PUSHAX	erbta
-	PUSHAX	ecr		; r9 contains ECR, expected by EV_Trap
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+	__RESTORE_REGFILE_HARD
+	add	sp, sp, SZ_PT_REGS - 8
+#else
+	add	sp, sp, PT_r0
+#endif
 
-	PUSH	r0		; orig_r0
 .endm
 
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
 
-	; Assumes r0 has PT_status32
-	btst   r0, STATUS_U_BIT	; Z flag set if K, used in INTERRUPT_EPILOGUE
-
-	add	sp, sp, 8	; orig_r0/ECR don't need restoring
-	POPAX	erbta
-
-	INTERRUPT_EPILOGUE  exception
+	; INPUT: r0 has STAT32 of calling context
 
-	POP	r0
-	POP	r1
-	POP	r2
-	POP	r3
-	POP	r4
-	POP	r5
-	POP	r6
-	POP	r7
-	POP	r8
-	POP	r9
-	POP	r10
-	POP	r11
+	btst	r0, STATUS_U_BIT	; Z flag set if K, used in restoring SP
 
-	POP	blink
-	POPAX	lp_end
-	POPAX	lp_start
+	ld	r10, [sp, PT_event + 4]
+	sr	r10, [erbta]
 
-	POP	r9
-	mov	lp_count, r9
+	LD2	r10, r11, PT_ret
+	sr	r10, [eret]
+	sr	r11, [erstatus]
 
-	add	sp, sp, 12	; skip JLI, LDI, EI
-	POPAX	eret
-	POPAX	erstatus
+	__RESTORE_REGFILE_SOFT
+	__RESTORE_REGFILE_HARD
 
-	ld.as	r9, [sp, -12]	; reload r9 which got clobbered
+	add	sp, sp, SZ_PT_REGS
 .endm
 
 .macro FAKE_RET_FROM_EXCPN
diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index 07c8e1a6c56e..b89ca8b4d597 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -11,12 +11,30 @@
 
 #include <asm/dwarf.h>
 
-#ifdef __ASSEMBLY__
-
 #define ASM_NL		 `	/* use '`' to mark new line in macro */
 #define __ALIGN		.align 4
 #define __ALIGN_STR	__stringify(__ALIGN)
 
+#ifdef __ASSEMBLY__
+
+.macro ST2 e, o, off
+#ifdef CONFIG_ARC_HAS_LL64
+	std	\e, [sp, \off]
+#else
+	st	\e, [sp, \off]
+	st	\o, [sp, \off+4]
+#endif
+.endm
+
+.macro LD2 e, o, off
+#ifdef CONFIG_ARC_HAS_LL64
+	ldd	\e, [sp, \off]
+#else
+	ld	\e, [sp, \off]
+	ld	\o, [sp, \off+4]
+#endif
+.endm
+
 /* annotation for data we want in DCCM - if enabled in .config */
 .macro ARCFP_DATA nm
 #ifdef CONFIG_ARC_HAS_DCCM
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index ecaf34e9235c..e90dccecfd83 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -58,7 +58,14 @@ int main(void)
 	DEFINE(PT_r5, offsetof(struct pt_regs, r5));
 	DEFINE(PT_r6, offsetof(struct pt_regs, r6));
 	DEFINE(PT_r7, offsetof(struct pt_regs, r7));
+	DEFINE(PT_r8, offsetof(struct pt_regs, r8));
+	DEFINE(PT_r10, offsetof(struct pt_regs, r10));
+	DEFINE(PT_r26, offsetof(struct pt_regs, r26));
 	DEFINE(PT_ret, offsetof(struct pt_regs, ret));
+	DEFINE(PT_blink, offsetof(struct pt_regs, blink));
+	DEFINE(PT_lpe, offsetof(struct pt_regs, lp_end));
+	DEFINE(PT_lpc, offsetof(struct pt_regs, lp_count));
+	DEFINE(PT_user_r25, offsetof(struct pt_regs, user_r25));
 
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 562089d62d9d..6cbf0ee8a20a 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -70,7 +70,7 @@ reserved:
 
 ENTRY(handle_interrupt)
 
-	INTERRUPT_PROLOGUE  irq
+	INTERRUPT_PROLOGUE
 
 	# irq control APIs local_irq_save/restore/disable/enable fiddle with
 	# global interrupt enable bits in STATUS32 (.IE for 1 prio, .E[] for 2 prio)
@@ -226,7 +226,7 @@ debug_marker_l1:
 	bset.nz	r11, r11, AUX_IRQ_ACT_BIT_U	; NZ means U
 	sr	r11, [AUX_IRQ_ACT]
 
-	INTERRUPT_EPILOGUE  irq
+	INTERRUPT_EPILOGUE
 	rtie
 
 ;####### Return from Exception / pure kernel mode #######
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 0e1e47a67c73..e50cac799a51 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -396,6 +396,17 @@ EV_TLBMissD_fast_ret:	; additional label for VDK OS-kit instrumentation
 ;-------- Common routine to call Linux Page Fault Handler -----------
 do_slow_path_pf:
 
+#ifdef CONFIG_ISA_ARCV2
+	; Set Z flag if exception in U mode. Hardware micro-ops do this on any
+	; taken interrupt/exception, and thus is already the case at the entry
+	; above, but ensuing code would have already clobbered.
+	; EXCEPTION_PROLOGUE called in slow path, relies on correct Z flag set
+
+	lr	r2, [erstatus]
+	and	r2, r2, STATUS_U_MASK
+	bxor.f	0, r2, STATUS_U_BIT
+#endif
+
 	; Restore the 4-scratch regs saved by fast path miss handler
 	TLBMISS_RESTORE_REGS
 
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 6edc4bd1e7ea..a6406a347690 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -468,7 +468,6 @@
 				  "spi_lr_session_done",
 				  "spi_lr_overread";
 		clocks = <&iprocmed>;
-		clock-names = "iprocmed";
 		num-cs = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d91cc532d0e2..fcd7e4dc949a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -46,6 +46,10 @@
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
index afde0ed6d71a..b00f791471c6 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -32,6 +32,9 @@
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
index d7d092a5522a..9f0c82d79a36 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -36,6 +36,8 @@
 		spi1 = &ecspi2;
 		spi3 = &ecspi3;
 		spi4 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
@@ -49,20 +51,18 @@
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
 			clocks = <&clks IMX6SLL_CLK_ARM>,
 				 <&clks IMX6SLL_CLK_PLL2_PFD2>,
@@ -271,7 +271,7 @@
 					status = "disabled";
 				};
 
-				ssi1: ssi-controller@2028000 {
+				ssi1: ssi@2028000 {
 					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
@@ -284,7 +284,7 @@
 					status = "disabled";
 				};
 
-				ssi2: ssi-controller@202c000 {
+				ssi2: ssi@202c000 {
 					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
@@ -297,7 +297,7 @@
 					status = "disabled";
 				};
 
-				ssi3: ssi-controller@2030000 {
+				ssi3: ssi@2030000 {
 					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
@@ -518,7 +518,7 @@
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
-				phy-reg_3p0-supply = <&reg_3p0>;
+				phy-3p0-supply = <&reg_3p0>;
 				fsl,anatop = <&anatop>;
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index b9ab1118be30..a0c0e631ebbe 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -49,6 +49,9 @@
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
index 334638ff5075..dcb187995f76 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -47,6 +47,8 @@
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7234e8330a57..34904f7eeb13 100644
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
index 7eaf96b425be..8a6d698e253d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -46,6 +46,8 @@
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbh;
 	};
 
 	cpus {
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index de998830f534..b07956883e16 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <asm/mach/time.h>
 #include "soc.h"
+#include "platform.h"
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -60,7 +61,7 @@ static u64 notrace ep93xx_read_sched_clock(void)
 	return ret;
 }
 
-u64 ep93xx_clocksource_read(struct clocksource *c)
+static u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 3d36f1d95196..3f651df3a71c 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -63,6 +63,9 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
+	if (of_machine_is_compatible("lacie,d2-network"))
+		d2net_init();
+
 	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index eb96009e21c4..b9cfdb456456 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -75,6 +75,12 @@ extern void mss2_init(void);
 static inline void mss2_init(void) {}
 #endif
 
+#ifdef CONFIG_MACH_D2NET_DT
+void d2net_init(void);
+#else
+static inline void d2net_init(void) {}
+#endif
+
 /*****************************************************************************
  * Helpers to access Orion registers
  ****************************************************************************/
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 575ec085cffa..73bedccedb58 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -570,7 +570,7 @@ static void __init map_sa1100_gpio_regs( void )
  */
 static void __init get_assabet_scr(void)
 {
-	unsigned long uninitialized_var(scr), i;
+	unsigned long scr, i;
 
 	GPDR |= 0x3fc;			/* Configure GPIO 9:2 as outputs */
 	GPSR = 0x3fc;			/* Write 0xFF to GPIO 9:2 */
diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 971119c29474..aa10e5e46ebb 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -48,7 +48,7 @@ enum probes_insn checker_stack_use_imm_0xx(probes_opcode_t insn,
  * Different from other insn uses imm8, the real addressing offset of
  * STRD in T32 encoding should be imm8 * 4. See ARMARM description.
  */
-enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
+static enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
 		struct arch_probes_insn *asi,
 		const struct decode_header *h)
 {
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 62da8e2211e4..0a7090a65bca 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -239,7 +239,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
  * kprobe, and that level is reserved for user kprobe handlers, so we can't
  * risk encountering a new kprobe in an interrupt handler.
  */
-void __kprobes kprobe_handler(struct pt_regs *regs)
+static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index cf08cb726767..1516c340a076 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -158,8 +158,6 @@ __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 	}
 }
 
-extern void kprobe_handler(struct pt_regs *regs);
-
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 {
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index cc237fa9b90f..1c86c5d980c5 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -723,7 +723,7 @@ static const char coverage_register_lookup[16] = {
 	[REG_TYPE_NOSPPCX]	= COVERAGE_ANY_REG | COVERAGE_SP,
 };
 
-unsigned coverage_start_registers(const struct decode_header *h)
+static unsigned coverage_start_registers(const struct decode_header *h)
 {
 	unsigned regs = 0;
 	int i;
diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
index 94285203e9f7..459ebda07713 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -456,3 +456,7 @@ void kprobe_thumb32_test_cases(void);
 #else
 void kprobe_arm_test_cases(void);
 #endif
+
+void __kprobes_test_case_start(void);
+void __kprobes_test_case_end_16(void);
+void __kprobes_test_case_end_32(void);
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 636bab51de38..40a54b55abab 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -125,7 +125,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 8bf3091a899c..5abffdaf4077 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -165,7 +165,7 @@
 	};
 
 	scif1_pins: scif1 {
-		groups = "scif1_data_b", "scif1_ctrl";
+		groups = "scif1_data_b";
 		function = "scif1";
 	};
 
@@ -178,7 +178,6 @@
 &scif1 {
 	pinctrl-0 = <&scif1_pins>;
 	pinctrl-names = "default";
-	uart-has-rtscts;
 
 	status = "okay";
 };
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 968b5f33e725..1a8e20652e7c 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -444,7 +444,7 @@ static void
 do_copy_task_regs (struct task_struct *task, struct unw_frame_info *info, void *arg)
 {
 	unsigned long mask, sp, nat_bits = 0, ar_rnat, urbs_end, cfm;
-	unsigned long uninitialized_var(ip);	/* GCC be quiet */
+	unsigned long ip;
 	elf_greg_t *dst = arg;
 	struct pt_regs *pt;
 	char nat;
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index db3104c9fac5..33f68be018a2 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -181,7 +181,7 @@ static void *per_cpu_node_setup(void *cpu_data, int node)
 void __init setup_per_cpu_areas(void)
 {
 	struct pcpu_alloc_info *ai;
-	struct pcpu_group_info *uninitialized_var(gi);
+	struct pcpu_group_info *gi;
 	unsigned int *cpu_map;
 	void *base;
 	unsigned long base_offset;
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index acf10eb9da15..02470929fb39 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -339,7 +339,7 @@ EXPORT_SYMBOL(flush_tlb_range);
 
 void ia64_tlb_init(void)
 {
-	ia64_ptce_info_t uninitialized_var(ptce_info); /* GCC be quiet */
+	ia64_ptce_info_t ptce_info;
 	u64 tr_pgbits;
 	long status;
 	pal_vm_info_1_u_t vm_info_1;
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index ffe0cf0f0bea..923b3b794d13 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -232,7 +232,7 @@ config PPC_EARLY_DEBUG_40x
 
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
-	depends on SERIAL_CPM
+	depends on SERIAL_CPM=y
 	help
 	  Select this to enable early debugging for Freescale chips
 	  using a CPM-based serial port.  This assumes that the bootwrapper
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
index a5091c034747..aff86679af96 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -266,8 +266,7 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 	start = _ALIGN_DOWN(start, page_size);
 	if (altmap) {
 		alt_start = altmap->base_pfn;
-		alt_end = altmap->base_pfn + altmap->reserve +
-			  altmap->free + altmap->alloc + altmap->align;
+		alt_end = altmap->base_pfn + altmap->reserve + altmap->free;
 	}
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index fc98912f42cf..76a8102bdb98 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -340,7 +340,7 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *uninitialized_var(irqchip);
+	struct irq_chip *irqchip;
 	void *hndlr;
 	int type;
 	u32 reg;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index bce678c7179c..f272b662301e 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -145,7 +145,7 @@ static int pcpu_sigp_retry(struct pcpu *pcpu, u8 order, u32 parm)
 
 static inline int pcpu_stopped(struct pcpu *pcpu)
 {
-	u32 uninitialized_var(status);
+	u32 status;
 
 	if (__pcpu_sigp(pcpu->address, SIGP_SENSE,
 			0, &status) != SIGP_CC_STATUS_STORED)
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
index a389fa85cca2..5450d43d26ea 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -360,8 +360,8 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
  */
 int handle_sthyi(struct kvm_vcpu *vcpu)
 {
-	int reg1, reg2, r = 0;
-	u64 code, addr, cc = 0, rc = 0;
+	int reg1, reg2, cc = 0, r = 0;
+	u64 code, addr, rc = 0;
 	struct sthyi_sctns *sctns = NULL;
 
 	if (!test_kvm_facility(vcpu->kvm, 74))
@@ -392,7 +392,10 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	cc = sthyi_fill(sctns, &rc);
-
+	if (cc < 0) {
+		free_page((unsigned long)sctns);
+		return cc;
+	}
 out:
 	if (!cc) {
 		r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3aade928c18d..92041d442d2e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1716,6 +1716,10 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
 		ms = slots->memslots + slotidx;
 		ofs = 0;
 	}
+
+	if (cur_gfn < ms->base_gfn)
+		ofs = 0;
+
 	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
 	while ((slotidx > 0) && (ofs >= ms->npages)) {
 		slotidx--;
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index afde2a7d3eb3..e0679d8a9b34 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -21,6 +21,18 @@
 #include <cpu/dma-register.h>
 #include <cpu/dma.h>
 
+/*
+ * Some of the SoCs feature two DMAC modules. In such a case, the channels are
+ * distributed equally among them.
+ */
+#ifdef	SH_DMAC_BASE1
+#define	SH_DMAC_NR_MD_CH	(CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
+#else
+#define	SH_DMAC_NR_MD_CH	CONFIG_NR_ONCHIP_DMA_CHANNELS
+#endif
+
+#define	SH_DMAC_CH_SZ		0x10
+
 /*
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
@@ -32,7 +44,7 @@ static unsigned long dma_find_base(unsigned int chan)
 	unsigned long base = SH_DMAC_BASE0;
 
 #ifdef SH_DMAC_BASE1
-	if (chan >= 6)
+	if (chan >= SH_DMAC_NR_MD_CH)
 		base = SH_DMAC_BASE1;
 #endif
 
@@ -43,13 +55,13 @@ static unsigned long dma_base_addr(unsigned int chan)
 {
 	unsigned long base = dma_find_base(chan);
 
-	/* Normalize offset calculation */
-	if (chan >= 9)
-		chan -= 6;
-	if (chan >= 4)
-		base += 0x10;
+	chan = (chan % SH_DMAC_NR_MD_CH) * SH_DMAC_CH_SZ;
+
+	/* DMAOR is placed inside the channel register space. Step over it. */
+	if (chan >= DMAOR)
+		base += SH_DMAC_CH_SZ;
 
-	return base + (chan * 0x10);
+	return base + chan;
 }
 
 #ifdef CONFIG_SH_DMA_IRQ_MULTI
@@ -253,12 +265,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
 #define NR_DMAOR	1
 #endif
 
-/*
- * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
- * channels 0 - 5, DMAOR1 6 - 11 (optional).
- */
-#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
-#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
+#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * \
+						    SH_DMAC_NR_MD_CH) + DMAOR)
+#define dmaor_write_reg(n, data)	__raw_writew(data, \
+						     dma_find_base((n) * \
+						     SH_DMAC_NR_MD_CH) + DMAOR)
 
 static inline int dmaor_reset(int no)
 {
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index a5bd03642678..75dcb1d6bc62 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -24,7 +24,7 @@ static int __init scan_cache(unsigned long node, const char *uname,
 	if (!of_flat_dt_is_compatible(node, "jcore,cache"))
 		return 0;
 
-	j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
+	j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);
 
 	return 1;
 }
diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 736348ead421..2ecf1dcc86b2 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -96,7 +96,7 @@ static void ich_force_hpet_resume(void)
 static void ich_force_enable_hpet(struct pci_dev *dev)
 {
 	u32 val;
-	u32 uninitialized_var(rcba);
+	u32 rcba;
 	int err = 0;
 
 	if (hpet_address || force_hpet_address)
@@ -186,7 +186,7 @@ static void hpet_print_force_info(void)
 static void old_ich_force_hpet_resume(void)
 {
 	u32 val;
-	u32 uninitialized_var(gen_cntl);
+	u32 gen_cntl;
 
 	if (!force_hpet_address || !cached_dev)
 		return;
@@ -208,7 +208,7 @@ static void old_ich_force_hpet_resume(void)
 static void old_ich_force_enable_hpet(struct pci_dev *dev)
 {
 	u32 val;
-	u32 uninitialized_var(gen_cntl);
+	u32 gen_cntl;
 
 	if (hpet_address || force_hpet_address)
 		return;
@@ -299,7 +299,7 @@ static void vt8237_force_hpet_resume(void)
 
 static void vt8237_force_enable_hpet(struct pci_dev *dev)
 {
-	u32 uninitialized_var(val);
+	u32 val;
 
 	if (hpet_address || force_hpet_address)
 		return;
@@ -430,7 +430,7 @@ static void nvidia_force_hpet_resume(void)
 
 static void nvidia_force_enable_hpet(struct pci_dev *dev)
 {
-	u32 uninitialized_var(val);
+	u32 val;
 
 	if (hpet_address || force_hpet_address)
 		return;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 1f1298f6cbc2..2e4f6a1ebca5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -96,6 +96,17 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -1595,10 +1606,10 @@ static bool wakeup_cpu0(void)
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
-	void *mwait_ptr;
 	int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
@@ -1632,13 +1643,6 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr = &current_thread_info()->flags;
-
 	wbinvd();
 
 	while (1) {
@@ -1650,9 +1654,9 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
 		/*
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index d027dddc41ca..f49329aabec8 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -236,7 +236,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f725b6c..40188632958c 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -95,7 +95,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	cpumask_var_t tmp;
 	int cpu;
 	unsigned long min_weight = -1;
-	unsigned long uninitialized_var(preferred_cpu);
+	unsigned long preferred_cpu;
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 957f6b28bcea..2295b74714e1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -178,7 +178,7 @@ static ssize_t ata_scsi_park_show(struct device *device,
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long now;
-	unsigned int uninitialized_var(msecs);
+	unsigned int msecs;
 	int rc = 0;
 
 	ap = ata_shost_to_port(sdev->host);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 84c6b225b56e..9ee4aefca867 100644
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
 
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index d5c76b50d357..88f810745fd8 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -939,7 +939,7 @@ static int open_tx_first(struct atm_vcc *vcc)
 	    vcc->qos.txtp.max_pcr >= ATM_OC3_PCR);
 	if (unlimited && zatm_dev->ubr != -1) zatm_vcc->shaper = zatm_dev->ubr;
 	else {
-		int uninitialized_var(pcr);
+		int pcr;
 
 		if (unlimited) vcc->qos.txtp.max_sdu = ATM_MAX_AAL5_PDU;
 		if ((zatm_vcc->shaper = alloc_shaper(vcc->dev,&pcr,
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..d89f618231cb 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -44,7 +44,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ce015ce2977c..51eb403f89de 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -372,7 +372,7 @@ static ssize_t size_show(struct device *dev,
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%uK\n", this_leaf->size >> 10);
+	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
 }
 
 static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
@@ -402,11 +402,11 @@ static ssize_t type_show(struct device *dev,
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sprintf(buf, "Data\n");
+		return sysfs_emit(buf, "Data\n");
 	case CACHE_TYPE_INST:
-		return sprintf(buf, "Instruction\n");
+		return sysfs_emit(buf, "Instruction\n");
 	case CACHE_TYPE_UNIFIED:
-		return sprintf(buf, "Unified\n");
+		return sysfs_emit(buf, "Unified\n");
 	default:
 		return -EINVAL;
 	}
@@ -420,11 +420,11 @@ static ssize_t allocation_policy_show(struct device *dev,
 	int n = 0;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sprintf(buf, "ReadWriteAllocate\n");
+		n = sysfs_emit(buf, "ReadWriteAllocate\n");
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sprintf(buf, "ReadAllocate\n");
+		n = sysfs_emit(buf, "ReadAllocate\n");
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sprintf(buf, "WriteAllocate\n");
+		n = sysfs_emit(buf, "WriteAllocate\n");
 	return n;
 }
 
@@ -436,9 +436,9 @@ static ssize_t write_policy_show(struct device *dev,
 	int n = 0;
 
 	if (ci_attr & CACHE_WRITE_THROUGH)
-		n = sprintf(buf, "WriteThrough\n");
+		n = sysfs_emit(buf, "WriteThrough\n");
 	else if (ci_attr & CACHE_WRITE_BACK)
-		n = sprintf(buf, "WriteBack\n");
+		n = sysfs_emit(buf, "WriteBack\n");
 	return n;
 }
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6e380ad9d08a..0332800dffd8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -994,7 +994,7 @@ ssize_t device_show_ulong(struct device *dev,
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
+	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -1019,7 +1019,7 @@ ssize_t device_show_int(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -1040,7 +1040,7 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
@@ -1273,7 +1273,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	val = !dev->offline;
 	device_unlock(dev);
-	return sprintf(buf, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t online_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index b1bb6f43f896..607fc189e57c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -156,7 +156,7 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sprintf(buf, "%Lx\n", addr);
+	rc = sysfs_emit(buf, "%Lx\n", addr);
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
@@ -167,7 +167,7 @@ static ssize_t show_crash_notes_size(struct device *dev,
 {
 	ssize_t rc;
 
-	rc = sprintf(buf, "%zu\n", sizeof(note_buf_t));
+	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
 	return rc;
 }
 static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
@@ -264,7 +264,7 @@ static ssize_t print_cpus_offline(struct device *dev,
 						      nr_cpu_ids, total_cpus-1);
 	}
 
-	n += snprintf(&buf[n], len - n, "\n");
+	n += sysfs_emit(&buf[n], "\n");
 	return n;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
@@ -272,7 +272,7 @@ static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int n = 0;
 	cpumask_var_t isolated;
 
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
@@ -280,7 +280,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(isolated));
+	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -292,9 +292,9 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int n = 0;
 
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 
 	return n;
 }
@@ -328,7 +328,7 @@ static ssize_t print_cpu_modalias(struct device *dev,
 	ssize_t n;
 	u32 i;
 
-	n = sprintf(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
 		    CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
@@ -520,56 +520,56 @@ static void __init cpu_dev_register_generic(void)
 ssize_t __weak cpu_show_meltdown(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v1(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_l1tf(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_srbds(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 821e27bda4ca..2116926cc1d5 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -215,7 +215,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 		loading = fw_sysfs_loading(fw_sysfs->fw_priv);
 	mutex_unlock(&fw_lock);
 
-	return sprintf(buf, "%d\n", loading);
+	return sysfs_emit(buf, "%d\n", loading);
 }
 
 /* one pages buffer should be mapped/unmapped only once */
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index e270abc86d46..5dbe00a5c7c1 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -121,7 +121,7 @@ static ssize_t show_mem_start_phys_index(struct device *dev,
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
-	return sprintf(buf, "%08lx\n", phys_index);
+	return sysfs_emit(buf, "%08lx\n", phys_index);
 }
 
 /*
@@ -145,7 +145,7 @@ static ssize_t show_mem_removable(struct device *dev,
 	}
 
 out:
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 /*
@@ -163,17 +163,17 @@ static ssize_t show_mem_state(struct device *dev,
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sprintf(buf, "online\n");
+		len = sysfs_emit(buf, "online\n");
 		break;
 	case MEM_OFFLINE:
-		len = sprintf(buf, "offline\n");
+		len = sysfs_emit(buf, "offline\n");
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sprintf(buf, "going-offline\n");
+		len = sysfs_emit(buf, "going-offline\n");
 		break;
 	default:
-		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
-				mem->state);
+		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
+				 mem->state);
 		WARN_ON(1);
 		break;
 	}
@@ -384,7 +384,7 @@ static ssize_t show_phys_device(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	return sprintf(buf, "%d\n", mem->phys_device);
+	return sysfs_emit(buf, "%d\n", mem->phys_device);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -422,7 +422,7 @@ static ssize_t show_valid_zones(struct device *dev,
 		 */
 		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
 					  &valid_start_pfn, &valid_end_pfn))
-			return sprintf(buf, "none\n");
+			return sysfs_emit(buf, "none\n");
 		start_pfn = valid_start_pfn;
 		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
 		goto out;
@@ -456,7 +456,7 @@ static ssize_t
 print_block_size(struct device *dev, struct device_attribute *attr,
 		 char *buf)
 {
-	return sprintf(buf, "%lx\n", get_memory_block_size());
+	return sysfs_emit(buf, "%lx\n", get_memory_block_size());
 }
 
 static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
@@ -470,9 +470,9 @@ show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	if (memhp_auto_online)
-		return sprintf(buf, "online\n");
+		return sysfs_emit(buf, "online\n");
 	else
-		return sprintf(buf, "offline\n");
+		return sysfs_emit(buf, "offline\n");
 }
 
 static ssize_t
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 60c2e32f9f61..8defeace001e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -69,7 +69,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 	struct sysinfo i;
 
 	si_meminfo_node(&i, nid);
-	n = sprintf(buf,
+	n = sysfs_emit(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
 		       "Node %d MemUsed:        %8lu kB\n"
@@ -96,7 +96,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
 
 #ifdef CONFIG_HIGHMEM
-	n += sprintf(buf + n,
+	n += sysfs_emit(buf + n,
 		       "Node %d HighTotal:      %8lu kB\n"
 		       "Node %d HighFree:       %8lu kB\n"
 		       "Node %d LowTotal:       %8lu kB\n"
@@ -106,7 +106,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh));
 #endif
-	n += sprintf(buf + n,
+	n += sysfs_emit(buf + n,
 		       "Node %d Dirty:          %8lu kB\n"
 		       "Node %d Writeback:      %8lu kB\n"
 		       "Node %d FilePages:      %8lu kB\n"
@@ -162,19 +162,19 @@ static DEVICE_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf,
-		       "numa_hit %lu\n"
-		       "numa_miss %lu\n"
-		       "numa_foreign %lu\n"
-		       "interleave_hit %lu\n"
-		       "local_node %lu\n"
-		       "other_node %lu\n",
-		       sum_zone_numa_state(dev->id, NUMA_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_MISS),
-		       sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-		       sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_LOCAL),
-		       sum_zone_numa_state(dev->id, NUMA_OTHER));
+	return sysfs_emit(buf,
+			  "numa_hit %lu\n"
+			  "numa_miss %lu\n"
+			  "numa_foreign %lu\n"
+			  "interleave_hit %lu\n"
+			  "local_node %lu\n"
+			  "other_node %lu\n",
+			  sum_zone_numa_state(dev->id, NUMA_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_MISS),
+			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
+			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
+			  sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
@@ -612,7 +612,7 @@ static ssize_t print_nodes_state(enum node_states state, char *buf)
 {
 	int n;
 
-	n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
+	n = sysfs_emit(buf, "%*pbl",
 		      nodemask_pr_args(&node_states[state]));
 	buf[n++] = '\n';
 	buf[n] = '\0';
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2f89e618b142..1819da6889a7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -927,7 +927,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = sprintf(buf, "%s\n", pdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e865aa4b2504..b32d3cf4f670 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2433,10 +2433,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	err = of_property_read_u32(state_node, "min-residency-us", &residency);
 	if (!err)
-		genpd_state->residency_ns = 1000 * residency;
+		genpd_state->residency_ns = 1000LL * residency;
 
-	genpd_state->power_on_latency_ns = 1000 * exit_latency;
-	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->power_on_latency_ns = 1000LL * exit_latency;
+	genpd_state->power_off_latency_ns = 1000LL * entry_latency;
 	genpd_state->fwnode = &state_node->fwnode;
 
 	return 0;
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index c511def48b48..3f9934bd6137 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -24,8 +24,11 @@ extern void pm_runtime_remove(struct device *dev);
 
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
@@ -38,7 +41,8 @@ extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_enable_wake_irq_check(struct device *dev,
 					 bool can_change_status);
-extern void dev_pm_disable_wake_irq_check(struct device *dev);
+extern void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable);
+extern void dev_pm_enable_wake_irq_complete(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 911bb8a4bf6d..ab0898c33880 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -606,6 +606,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	if (retval)
 		goto fail;
 
+	dev_pm_enable_wake_irq_complete(dev);
+
  no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
@@ -640,7 +642,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, true);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -823,7 +825,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, false);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738ce796..c61b50aa1d81 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -101,7 +101,7 @@ static const char ctrl_on[] = "on";
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
@@ -127,7 +127,7 @@ static ssize_t runtime_active_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	ret = sysfs_emit(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -140,7 +140,7 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n",
+	ret = sysfs_emit(buf, "%i\n",
 		jiffies_to_msecs(dev->power.suspended_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
@@ -175,7 +175,7 @@ static ssize_t runtime_status_show(struct device *dev,
 			return -EIO;
 		}
 	}
-	return sprintf(buf, p);
+	return sysfs_emit(buf, p);
 }
 
 static DEVICE_ATTR_RO(runtime_status);
@@ -185,7 +185,7 @@ static ssize_t autosuspend_delay_ms_show(struct device *dev,
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
-	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
+	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
 static ssize_t autosuspend_delay_ms_store(struct device *dev,
@@ -214,11 +214,11 @@ static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
 	if (value == 0)
-		return sprintf(buf, "n/a\n");
+		return sysfs_emit(buf, "n/a\n");
 	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 		value = 0;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
@@ -258,11 +258,11 @@ static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sprintf(buf, "auto\n");
+		return sysfs_emit(buf, "auto\n");
 	if (value == PM_QOS_LATENCY_ANY)
-		return sprintf(buf, "any\n");
+		return sysfs_emit(buf, "any\n");
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_latency_tolerance_us_store(struct device *dev,
@@ -294,8 +294,8 @@ static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					& PM_QOS_FLAG_NO_POWER_OFF));
+	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					  & PM_QOS_FLAG_NO_POWER_OFF));
 }
 
 static ssize_t pm_qos_no_power_off_store(struct device *dev,
@@ -323,9 +323,9 @@ static const char _disabled[] = "disabled";
 static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%s\n", device_can_wakeup(dev)
-		? (device_may_wakeup(dev) ? _enabled : _disabled)
-		: "");
+	return sysfs_emit(buf, "%s\n", device_can_wakeup(dev)
+			  ? (device_may_wakeup(dev) ? _enabled : _disabled)
+			  : "");
 }
 
 static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
@@ -511,7 +511,7 @@ static DEVICE_ATTR_RO(wakeup_prevent_sleep_time_ms);
 static ssize_t runtime_usage_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
+	return sysfs_emit(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
 static DEVICE_ATTR_RO(runtime_usage);
 
@@ -519,8 +519,8 @@ static ssize_t runtime_active_kids_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", dev->power.ignore_children ?
-		0 : atomic_read(&dev->power.child_count));
+	return sysfs_emit(buf, "%d\n", dev->power.ignore_children ?
+			  0 : atomic_read(&dev->power.child_count));
 }
 static DEVICE_ATTR_RO(runtime_active_kids);
 
@@ -528,12 +528,12 @@ static ssize_t runtime_enabled_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
-		return sprintf(buf, "disabled & forbidden\n");
+		return sysfs_emit(buf, "disabled & forbidden\n");
 	if (dev->power.disable_depth)
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 	if (dev->power.runtime_auto == false)
-		return sprintf(buf, "forbidden\n");
-	return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "forbidden\n");
+	return sysfs_emit(buf, "enabled\n");
 }
 static DEVICE_ATTR_RO(runtime_enabled);
 
@@ -541,9 +541,9 @@ static DEVICE_ATTR_RO(runtime_enabled);
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	return sprintf(buf, "%s\n",
-			device_async_suspend_enabled(dev) ?
-				_enabled : _disabled);
+	return sysfs_emit(buf, "%s\n",
+			  device_async_suspend_enabled(dev) ?
+			  _enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index b8fa5c0f2d13..e7ba51499916 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -156,24 +156,7 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
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
@@ -211,7 +194,7 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	if (err)
 		goto err_free_irq;
 
-	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED;
+	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED | flag;
 
 	return err;
 
@@ -224,8 +207,57 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
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
@@ -296,25 +328,56 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
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
 
 	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
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
@@ -331,7 +394,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 
 	if (device_may_wakeup(wirq->dev)) {
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -354,7 +417,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 7e91894a380b..23bc9eb794a2 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -72,13 +72,13 @@ static ssize_t soc_info_get(struct device *dev,
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if (attr == &dev_attr_machine)
-		return sprintf(buf, "%s\n", soc_dev->attr->machine);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
 	if (attr == &dev_attr_family)
-		return sprintf(buf, "%s\n", soc_dev->attr->family);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
-		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
 	if (attr == &dev_attr_soc_id)
-		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
 
 	return -EINVAL;
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3f403aab55e1..b4c2a2c2769b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3394,7 +3394,7 @@ int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
-	struct drbd_device *uninitialized_var(device);
+	struct drbd_device *device;
 	int minor, err, retcode;
 	struct drbd_genlmsghdr *dh;
 	struct device_info device_info;
@@ -3483,7 +3483,7 @@ int drbd_adm_dump_connections(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource = NULL, *next_resource;
-	struct drbd_connection *uninitialized_var(connection);
+	struct drbd_connection *connection;
 	int err = 0, retcode;
 	struct drbd_genlmsghdr *dh;
 	struct connection_info connection_info;
@@ -3645,7 +3645,7 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
-	struct drbd_device *uninitialized_var(device);
+	struct drbd_device *device;
 	struct drbd_peer_device *peer_device = NULL;
 	int minor, err, retcode;
 	struct drbd_genlmsghdr *dh;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 12eb48980df7..2e6c3f658894 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1991,7 +1991,8 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
+		BLK_MQ_F_NO_SCHED;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 28024248a7b5..5a07964a1e67 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1646,7 +1646,8 @@ static int nbd_dev_add(int index)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index dc9b8f377907..084f7e4254eb 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -105,7 +105,7 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, RNGC_TIMEOUT);
+	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 	if (!ret) {
 		imx_rngc_irq_mask_clear(rngc);
 		return -ETIMEDOUT;
@@ -188,9 +188,7 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-				RNGC_TIMEOUT);
-
+		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 		if (!ret) {
 			imx_rngc_irq_mask_clear(rngc);
 			return -ETIMEDOUT;
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 7abd604e938c..58884d875201 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -17,6 +17,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
  */
 
+#include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
@@ -30,71 +31,111 @@ static DEFINE_IDA(rng_index_ida);
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
-	struct completion have_data;
 	char name[25];
-	unsigned int data_avail;
 	int index;
-	bool busy;
 	bool hwrng_register_done;
 	bool hwrng_removed;
+	/* data transfer */
+	struct completion have_data;
+	unsigned int data_avail;
+	unsigned int data_idx;
+	/* minimal size returned by rng_buffer_size() */
+#if SMP_CACHE_BYTES < 32
+	u8 data[32];
+#else
+	u8 data[SMP_CACHE_BYTES];
+#endif
 };
 
 static void random_recv_done(struct virtqueue *vq)
 {
 	struct virtrng_info *vi = vq->vdev->priv;
+	unsigned int len;
 
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
-	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
+	if (!virtqueue_get_buf(vi->vq, &len))
 		return;
 
+	smp_store_release(&vi->data_avail, len);
 	complete(&vi->have_data);
 }
 
-/* The host will fill any buffer we give it with sweet, sweet randomness. */
-static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
+static void request_entropy(struct virtrng_info *vi)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, buf, size);
+	reinit_completion(&vi->have_data);
+	vi->data_idx = 0;
+
+	sg_init_one(&sg, vi->data, sizeof(vi->data));
 
 	/* There should always be room for one buffer. */
-	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
+	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
 
 	virtqueue_kick(vi->vq);
 }
 
+static unsigned int copy_data(struct virtrng_info *vi, void *buf,
+			      unsigned int size)
+{
+	size = min_t(unsigned int, size, vi->data_avail);
+	memcpy(buf, vi->data + vi->data_idx, size);
+	vi->data_idx += size;
+	vi->data_avail -= size;
+	if (vi->data_avail == 0)
+		request_entropy(vi);
+	return size;
+}
+
 static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
 	int ret;
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
+	unsigned int chunk;
+	size_t read;
 
 	if (vi->hwrng_removed)
 		return -ENODEV;
 
-	if (!vi->busy) {
-		vi->busy = true;
-		reinit_completion(&vi->have_data);
-		register_buffer(vi, buf, size);
+	read = 0;
+
+	/* copy available data */
+	if (smp_load_acquire(&vi->data_avail)) {
+		chunk = copy_data(vi, buf, size);
+		size -= chunk;
+		read += chunk;
 	}
 
 	if (!wait)
-		return 0;
-
-	ret = wait_for_completion_killable(&vi->have_data);
-	if (ret < 0)
-		return ret;
+		return read;
+
+	/* We have already copied available entropy,
+	 * so either size is 0 or data_avail is 0
+	 */
+	while (size != 0) {
+		/* data_avail is 0 but a request is pending */
+		ret = wait_for_completion_killable(&vi->have_data);
+		if (ret < 0)
+			return ret;
+		/* if vi->data_avail is 0, we have been interrupted
+		 * by a cleanup, but buffer stays in the queue
+		 */
+		if (vi->data_avail == 0)
+			return read;
 
-	vi->busy = false;
+		chunk = copy_data(vi, buf + read, size);
+		size -= chunk;
+		read += chunk;
+	}
 
-	return vi->data_avail;
+	return read;
 }
 
 static void virtio_cleanup(struct hwrng *rng)
 {
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
-	if (vi->busy)
-		wait_for_completion(&vi->have_data);
+	complete(&vi->have_data);
 }
 
 static int probe_common(struct virtio_device *vdev)
@@ -130,6 +171,9 @@ static int probe_common(struct virtio_device *vdev)
 		goto err_find;
 	}
 
+	/* we always have a pending entropy request */
+	request_entropy(vi);
+
 	return 0;
 
 err_find:
@@ -145,9 +189,9 @@ static void remove_common(struct virtio_device *vdev)
 
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
+	vi->data_idx = 0;
 	complete(&vi->have_data);
 	vdev->config->reset(vdev);
-	vi->busy = false;
 	if (vi->hwrng_register_done)
 		hwrng_unregister(&vi->hwrng);
 	vdev->config->del_vqs(vdev);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c95ce9323d77..430a9eac67e1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -270,6 +270,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0;
 	int status;
 	u32 expected;
+	int rc;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -289,8 +290,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
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
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index ecbb63f8d231..05c77812b650 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -700,37 +700,21 @@ static struct miscdevice vtpmx_miscdev = {
 	.fops = &vtpmx_fops,
 };
 
-static int vtpmx_init(void)
-{
-	return misc_register(&vtpmx_miscdev);
-}
-
-static void vtpmx_cleanup(void)
-{
-	misc_deregister(&vtpmx_miscdev);
-}
-
 static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
 	}
 
-	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+	rc = misc_register(&vtpmx_miscdev);
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		destroy_workqueue(workqueue);
+	}
 
 	return rc;
 }
@@ -738,7 +722,7 @@ static int __init vtpm_module_init(void)
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index dd82485e09a1..c110f5d40b58 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -43,7 +43,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	u32 reg;
 
 	set ^= enable;
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b2427e8a..e33b21d3f9d8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -23,8 +23,8 @@ obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
-obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
-obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
+obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
+obj-$(CONFIG_ORION_TIMER)	+= timer-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
@@ -36,25 +36,25 @@ obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra20_timer.o
-obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
-obj-$(CONFIG_NSPIRE_TIMER)	+= zevio-timer.o
+obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
+obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
-obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
-obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
+obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
+obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
-obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
+obj-$(CONFIG_CLKSRC_LPC32XX)	+= timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
-obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
-obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
-obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
+obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
+obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
+obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
-obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
+obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
-obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
+obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 
@@ -66,7 +66,7 @@ obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
-obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
+obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
deleted file mode 100644
index a7eb858a84a0..000000000000
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ /dev/null
@@ -1,543 +0,0 @@
-/*
- * This file contains driver for the Cadence Triple Timer Counter Rev 06
- *
- *  Copyright (C) 2011-2013 Xilinx
- *
- * based on arch/mips/kernel/time.c timer driver
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/slab.h>
-#include <linux/sched_clock.h>
-
-/*
- * This driver configures the 2 16/32-bit count-up timers as follows:
- *
- * T1: Timer 1, clocksource for generic timekeeping
- * T2: Timer 2, clockevent source for hrtimers
- * T3: Timer 3, <unused>
- *
- * The input frequency to the timer module for emulation is 2.5MHz which is
- * common to all the timer channels (T1, T2, and T3). With a pre-scaler of 32,
- * the timers are clocked at 78.125KHz (12.8 us resolution).
-
- * The input frequency to the timer module in silicon is configurable and
- * obtained from device tree. The pre-scaler of 32 is used.
- */
-
-/*
- * Timer Register Offset Definitions of Timer 1, Increment base address by 4
- * and use same offsets for Timer 2
- */
-#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
-#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
-#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
-#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
-#define TTC_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
-#define TTC_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
-
-#define TTC_CNT_CNTRL_DISABLE_MASK	0x1
-
-#define TTC_CLK_CNTRL_CSRC_MASK		(1 << 5)	/* clock source */
-#define TTC_CLK_CNTRL_PSV_MASK		0x1e
-#define TTC_CLK_CNTRL_PSV_SHIFT		1
-
-/*
- * Setup the timers to use pre-scaling, using a fixed value for now that will
- * work across most input frequency, but it may need to be more dynamic
- */
-#define PRESCALE_EXPONENT	11	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
-#define PRESCALE		2048	/* The exponent must match this */
-#define CLK_CNTRL_PRESCALE	((PRESCALE_EXPONENT - 1) << 1)
-#define CLK_CNTRL_PRESCALE_EN	1
-#define CNT_CNTRL_RESET		(1 << 4)
-
-#define MAX_F_ERR 50
-
-/**
- * struct ttc_timer - This definition defines local timer structure
- *
- * @base_addr:	Base address of timer
- * @freq:	Timer input clock frequency
- * @clk:	Associated clock source
- * @clk_rate_change_nb	Notifier block for clock rate changes
- */
-struct ttc_timer {
-	void __iomem *base_addr;
-	unsigned long freq;
-	struct clk *clk;
-	struct notifier_block clk_rate_change_nb;
-};
-
-#define to_ttc_timer(x) \
-		container_of(x, struct ttc_timer, clk_rate_change_nb)
-
-struct ttc_timer_clocksource {
-	u32			scale_clk_ctrl_reg_old;
-	u32			scale_clk_ctrl_reg_new;
-	struct ttc_timer	ttc;
-	struct clocksource	cs;
-};
-
-#define to_ttc_timer_clksrc(x) \
-		container_of(x, struct ttc_timer_clocksource, cs)
-
-struct ttc_timer_clockevent {
-	struct ttc_timer		ttc;
-	struct clock_event_device	ce;
-};
-
-#define to_ttc_timer_clkevent(x) \
-		container_of(x, struct ttc_timer_clockevent, ce)
-
-static void __iomem *ttc_sched_clock_val_reg;
-
-/**
- * ttc_set_interval - Set the timer interval value
- *
- * @timer:	Pointer to the timer instance
- * @cycles:	Timer interval ticks
- **/
-static void ttc_set_interval(struct ttc_timer *timer,
-					unsigned long cycles)
-{
-	u32 ctrl_reg;
-
-	/* Disable the counter, set the counter value  and re-enable counter */
-	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-
-	writel_relaxed(cycles, timer->base_addr + TTC_INTR_VAL_OFFSET);
-
-	/*
-	 * Reset the counter (0x10) so that it starts from 0, one-shot
-	 * mode makes this needed for timing to be right.
-	 */
-	ctrl_reg |= CNT_CNTRL_RESET;
-	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-}
-
-/**
- * ttc_clock_event_interrupt - Clock event timer interrupt handler
- *
- * @irq:	IRQ number of the Timer
- * @dev_id:	void pointer to the ttc_timer instance
- *
- * returns: Always IRQ_HANDLED - success
- **/
-static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
-{
-	struct ttc_timer_clockevent *ttce = dev_id;
-	struct ttc_timer *timer = &ttce->ttc;
-
-	/* Acknowledge the interrupt and call event handler */
-	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
-
-	ttce->ce.event_handler(&ttce->ce);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * __ttc_clocksource_read - Reads the timer counter register
- *
- * returns: Current timer counter register value
- **/
-static u64 __ttc_clocksource_read(struct clocksource *cs)
-{
-	struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
-
-	return (u64)readl_relaxed(timer->base_addr +
-				TTC_COUNT_VAL_OFFSET);
-}
-
-static u64 notrace ttc_sched_clock_read(void)
-{
-	return readl_relaxed(ttc_sched_clock_val_reg);
-}
-
-/**
- * ttc_set_next_event - Sets the time interval for next event
- *
- * @cycles:	Timer interval ticks
- * @evt:	Address of clock event instance
- *
- * returns: Always 0 - success
- **/
-static int ttc_set_next_event(unsigned long cycles,
-					struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-
-	ttc_set_interval(timer, cycles);
-	return 0;
-}
-
-/**
- * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
- *
- * @evt:	Address of clock event instance
- **/
-static int ttc_shutdown(struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-	u32 ctrl_reg;
-
-	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	return 0;
-}
-
-static int ttc_set_periodic(struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-
-	ttc_set_interval(timer,
-			 DIV_ROUND_CLOSEST(ttce->ttc.freq, PRESCALE * HZ));
-	return 0;
-}
-
-static int ttc_resume(struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-	u32 ctrl_reg;
-
-	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	return 0;
-}
-
-static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
-		unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct ttc_timer *ttc = to_ttc_timer(nb);
-	struct ttc_timer_clocksource *ttccs = container_of(ttc,
-			struct ttc_timer_clocksource, ttc);
-
-	switch (event) {
-	case PRE_RATE_CHANGE:
-	{
-		u32 psv;
-		unsigned long factor, rate_low, rate_high;
-
-		if (ndata->new_rate > ndata->old_rate) {
-			factor = DIV_ROUND_CLOSEST(ndata->new_rate,
-					ndata->old_rate);
-			rate_low = ndata->old_rate;
-			rate_high = ndata->new_rate;
-		} else {
-			factor = DIV_ROUND_CLOSEST(ndata->old_rate,
-					ndata->new_rate);
-			rate_low = ndata->new_rate;
-			rate_high = ndata->old_rate;
-		}
-
-		if (!is_power_of_2(factor))
-				return NOTIFY_BAD;
-
-		if (abs(rate_high - (factor * rate_low)) > MAX_F_ERR)
-			return NOTIFY_BAD;
-
-		factor = __ilog2_u32(factor);
-
-		/*
-		 * store timer clock ctrl register so we can restore it in case
-		 * of an abort.
-		 */
-		ttccs->scale_clk_ctrl_reg_old =
-			readl_relaxed(ttccs->ttc.base_addr +
-			TTC_CLK_CNTRL_OFFSET);
-
-		psv = (ttccs->scale_clk_ctrl_reg_old &
-				TTC_CLK_CNTRL_PSV_MASK) >>
-				TTC_CLK_CNTRL_PSV_SHIFT;
-		if (ndata->new_rate < ndata->old_rate)
-			psv -= factor;
-		else
-			psv += factor;
-
-		/* prescaler within legal range? */
-		if (psv & ~(TTC_CLK_CNTRL_PSV_MASK >> TTC_CLK_CNTRL_PSV_SHIFT))
-			return NOTIFY_BAD;
-
-		ttccs->scale_clk_ctrl_reg_new = ttccs->scale_clk_ctrl_reg_old &
-			~TTC_CLK_CNTRL_PSV_MASK;
-		ttccs->scale_clk_ctrl_reg_new |= psv << TTC_CLK_CNTRL_PSV_SHIFT;
-
-
-		/* scale down: adjust divider in post-change notification */
-		if (ndata->new_rate < ndata->old_rate)
-			return NOTIFY_DONE;
-
-		/* scale up: adjust divider now - before frequency change */
-		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
-			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-		break;
-	}
-	case POST_RATE_CHANGE:
-		/* scale up: pre-change notification did the adjustment */
-		if (ndata->new_rate > ndata->old_rate)
-			return NOTIFY_OK;
-
-		/* scale down: adjust divider now - after frequency change */
-		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
-			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-		break;
-
-	case ABORT_RATE_CHANGE:
-		/* we have to undo the adjustment in case we scale up */
-		if (ndata->new_rate < ndata->old_rate)
-			return NOTIFY_OK;
-
-		/* restore original register value */
-		writel_relaxed(ttccs->scale_clk_ctrl_reg_old,
-			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-		/* fall through */
-	default:
-		return NOTIFY_DONE;
-	}
-
-	return NOTIFY_DONE;
-}
-
-static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
-					 u32 timer_width)
-{
-	struct ttc_timer_clocksource *ttccs;
-	int err;
-
-	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
-	if (!ttccs)
-		return -ENOMEM;
-
-	ttccs->ttc.clk = clk;
-
-	err = clk_prepare_enable(ttccs->ttc.clk);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
-
-	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
-
-	ttccs->ttc.clk_rate_change_nb.notifier_call =
-		ttc_rate_change_clocksource_cb;
-	ttccs->ttc.clk_rate_change_nb.next = NULL;
-
-	err = clk_notifier_register(ttccs->ttc.clk,
-				    &ttccs->ttc.clk_rate_change_nb);
-	if (err)
-		pr_warn("Unable to register clock notifier.\n");
-
-	ttccs->ttc.base_addr = base;
-	ttccs->cs.name = "ttc_clocksource";
-	ttccs->cs.rating = 200;
-	ttccs->cs.read = __ttc_clocksource_read;
-	ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
-	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-
-	/*
-	 * Setup the clock source counter to be an incrementing counter
-	 * with no interrupt and it rolls over at 0xFFFF. Pre-scale
-	 * it by 32 also. Let it start running now.
-	 */
-	writel_relaxed(0x0,  ttccs->ttc.base_addr + TTC_IER_OFFSET);
-	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-		     ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-	writel_relaxed(CNT_CNTRL_RESET,
-		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
-
-	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
-
-	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
-	sched_clock_register(ttc_sched_clock_read, timer_width,
-			     ttccs->ttc.freq / PRESCALE);
-
-	return 0;
-}
-
-static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
-		unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct ttc_timer *ttc = to_ttc_timer(nb);
-	struct ttc_timer_clockevent *ttcce = container_of(ttc,
-			struct ttc_timer_clockevent, ttc);
-
-	switch (event) {
-	case POST_RATE_CHANGE:
-		/* update cached frequency */
-		ttc->freq = ndata->new_rate;
-
-		clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
-
-		/* fall through */
-	case PRE_RATE_CHANGE:
-	case ABORT_RATE_CHANGE:
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static int __init ttc_setup_clockevent(struct clk *clk,
-				       void __iomem *base, u32 irq)
-{
-	struct ttc_timer_clockevent *ttcce;
-	int err;
-
-	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
-	if (!ttcce)
-		return -ENOMEM;
-
-	ttcce->ttc.clk = clk;
-
-	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err)
-		goto out_kfree;
-
-	ttcce->ttc.clk_rate_change_nb.notifier_call =
-		ttc_rate_change_clockevent_cb;
-	ttcce->ttc.clk_rate_change_nb.next = NULL;
-
-	err = clk_notifier_register(ttcce->ttc.clk,
-				    &ttcce->ttc.clk_rate_change_nb);
-	if (err) {
-		pr_warn("Unable to register clock notifier.\n");
-		goto out_kfree;
-	}
-
-	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
-
-	ttcce->ttc.base_addr = base;
-	ttcce->ce.name = "ttc_clockevent";
-	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	ttcce->ce.set_next_event = ttc_set_next_event;
-	ttcce->ce.set_state_shutdown = ttc_shutdown;
-	ttcce->ce.set_state_periodic = ttc_set_periodic;
-	ttcce->ce.set_state_oneshot = ttc_shutdown;
-	ttcce->ce.tick_resume = ttc_resume;
-	ttcce->ce.rating = 200;
-	ttcce->ce.irq = irq;
-	ttcce->ce.cpumask = cpu_possible_mask;
-
-	/*
-	 * Setup the clock event timer to be an interval timer which
-	 * is prescaled by 32 using the interval interrupt. Leave it
-	 * disabled for now.
-	 */
-	writel_relaxed(0x23, ttcce->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
-	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-		     ttcce->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-	writel_relaxed(0x1,  ttcce->ttc.base_addr + TTC_IER_OFFSET);
-
-	err = request_irq(irq, ttc_clock_event_interrupt,
-			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err)
-		goto out_kfree;
-
-	clockevents_config_and_register(&ttcce->ce,
-			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
-
-	return 0;
-
-out_kfree:
-	kfree(ttcce);
-	return err;
-}
-
-/**
- * ttc_timer_init - Initialize the timer
- *
- * Initializes the timer hardware and register the clock source and clock event
- * timers with Linux kernal timer framework
- */
-static int __init ttc_timer_init(struct device_node *timer)
-{
-	unsigned int irq;
-	void __iomem *timer_baseaddr;
-	struct clk *clk_cs, *clk_ce;
-	static int initialized;
-	int clksel, ret;
-	u32 timer_width = 16;
-
-	if (initialized)
-		return 0;
-
-	initialized = 1;
-
-	/*
-	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
-	 * and use it. Note that the event timer uses the interrupt and it's the
-	 * 2nd TTC hence the irq_of_parse_and_map(,1)
-	 */
-	timer_baseaddr = of_iomap(timer, 0);
-	if (!timer_baseaddr) {
-		pr_err("ERROR: invalid timer base address\n");
-		return -ENXIO;
-	}
-
-	irq = irq_of_parse_and_map(timer, 1);
-	if (irq <= 0) {
-		pr_err("ERROR: invalid interrupt number\n");
-		return -EINVAL;
-	}
-
-	of_property_read_u32(timer, "timer-width", &timer_width);
-
-	clksel = readl_relaxed(timer_baseaddr + TTC_CLK_CNTRL_OFFSET);
-	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
-	clk_cs = of_clk_get(timer, clksel);
-	if (IS_ERR(clk_cs)) {
-		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_cs);
-	}
-
-	clksel = readl_relaxed(timer_baseaddr + 4 + TTC_CLK_CNTRL_OFFSET);
-	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
-	clk_ce = of_clk_get(timer, clksel);
-	if (IS_ERR(clk_ce)) {
-		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_ce);
-	}
-
-	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
-	if (ret)
-		return ret;
-
-	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
-	if (ret)
-		return ret;
-
-	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
deleted file mode 100644
index 846d18daf893..000000000000
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ /dev/null
@@ -1,376 +0,0 @@
-/*
- * Freescale FlexTimer Module (FTM) timer driver.
- *
- * Copyright 2014 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- */
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-#include <linux/slab.h>
-
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
-
-struct ftm_clock_device {
-	void __iomem *clksrc_base;
-	void __iomem *clkevt_base;
-	unsigned long periodic_cyc;
-	unsigned long ps;
-	bool big_endian;
-};
-
-static struct ftm_clock_device *priv;
-
-static inline u32 ftm_readl(void __iomem *addr)
-{
-	if (priv->big_endian)
-		return ioread32be(addr);
-	else
-		return ioread32(addr);
-}
-
-static inline void ftm_writel(u32 val, void __iomem *addr)
-{
-	if (priv->big_endian)
-		iowrite32be(val, addr);
-	else
-		iowrite32(val, addr);
-}
-
-static inline void ftm_counter_enable(void __iomem *base)
-{
-	u32 val;
-
-	/* select and enable counter clock source */
-	val = ftm_readl(base + FTM_SC);
-	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
-	val |= priv->ps | FTM_SC_CLK(1);
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_counter_disable(void __iomem *base)
-{
-	u32 val;
-
-	/* disable counter clock source */
-	val = ftm_readl(base + FTM_SC);
-	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_irq_acknowledge(void __iomem *base)
-{
-	u32 val;
-
-	val = ftm_readl(base + FTM_SC);
-	val &= ~FTM_SC_TOF;
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_irq_enable(void __iomem *base)
-{
-	u32 val;
-
-	val = ftm_readl(base + FTM_SC);
-	val |= FTM_SC_TOIE;
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_irq_disable(void __iomem *base)
-{
-	u32 val;
-
-	val = ftm_readl(base + FTM_SC);
-	val &= ~FTM_SC_TOIE;
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_reset_counter(void __iomem *base)
-{
-	/*
-	 * The CNT register contains the FTM counter value.
-	 * Reset clears the CNT register. Writing any value to COUNT
-	 * updates the counter with its initial value, CNTIN.
-	 */
-	ftm_writel(0x00, base + FTM_CNT);
-}
-
-static u64 notrace ftm_read_sched_clock(void)
-{
-	return ftm_readl(priv->clksrc_base + FTM_CNT);
-}
-
-static int ftm_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
-{
-	/*
-	 * The CNNIN and MOD are all double buffer registers, writing
-	 * to the MOD register latches the value into a buffer. The MOD
-	 * register is updated with the value of its write buffer with
-	 * the following scenario:
-	 * a, the counter source clock is diabled.
-	 */
-	ftm_counter_disable(priv->clkevt_base);
-
-	/* Force the value of CNTIN to be loaded into the FTM counter */
-	ftm_reset_counter(priv->clkevt_base);
-
-	/*
-	 * The counter increments until the value of MOD is reached,
-	 * at which point the counter is reloaded with the value of CNTIN.
-	 * The TOF (the overflow flag) bit is set when the FTM counter
-	 * changes from MOD to CNTIN. So we should using the delta - 1.
-	 */
-	ftm_writel(delta - 1, priv->clkevt_base + FTM_MOD);
-
-	ftm_counter_enable(priv->clkevt_base);
-
-	ftm_irq_enable(priv->clkevt_base);
-
-	return 0;
-}
-
-static int ftm_set_oneshot(struct clock_event_device *evt)
-{
-	ftm_counter_disable(priv->clkevt_base);
-	return 0;
-}
-
-static int ftm_set_periodic(struct clock_event_device *evt)
-{
-	ftm_set_next_event(priv->periodic_cyc, evt);
-	return 0;
-}
-
-static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	ftm_irq_acknowledge(priv->clkevt_base);
-
-	if (likely(clockevent_state_oneshot(evt))) {
-		ftm_irq_disable(priv->clkevt_base);
-		ftm_counter_disable(priv->clkevt_base);
-	}
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct clock_event_device ftm_clockevent = {
-	.name			= "Freescale ftm timer",
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_periodic	= ftm_set_periodic,
-	.set_state_oneshot	= ftm_set_oneshot,
-	.set_next_event		= ftm_set_next_event,
-	.rating			= 300,
-};
-
-static struct irqaction ftm_timer_irq = {
-	.name		= "Freescale ftm timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ftm_evt_interrupt,
-	.dev_id		= &ftm_clockevent,
-};
-
-static int __init ftm_clockevent_init(unsigned long freq, int irq)
-{
-	int err;
-
-	ftm_writel(0x00, priv->clkevt_base + FTM_CNTIN);
-	ftm_writel(~0u, priv->clkevt_base + FTM_MOD);
-
-	ftm_reset_counter(priv->clkevt_base);
-
-	err = setup_irq(irq, &ftm_timer_irq);
-	if (err) {
-		pr_err("ftm: setup irq failed: %d\n", err);
-		return err;
-	}
-
-	ftm_clockevent.cpumask = cpumask_of(0);
-	ftm_clockevent.irq = irq;
-
-	clockevents_config_and_register(&ftm_clockevent,
-					freq / (1 << priv->ps),
-					1, 0xffff);
-
-	ftm_counter_enable(priv->clkevt_base);
-
-	return 0;
-}
-
-static int __init ftm_clocksource_init(unsigned long freq)
-{
-	int err;
-
-	ftm_writel(0x00, priv->clksrc_base + FTM_CNTIN);
-	ftm_writel(~0u, priv->clksrc_base + FTM_MOD);
-
-	ftm_reset_counter(priv->clksrc_base);
-
-	sched_clock_register(ftm_read_sched_clock, 16, freq / (1 << priv->ps));
-	err = clocksource_mmio_init(priv->clksrc_base + FTM_CNT, "fsl-ftm",
-				    freq / (1 << priv->ps), 300, 16,
-				    clocksource_mmio_readl_up);
-	if (err) {
-		pr_err("ftm: init clock source mmio failed: %d\n", err);
-		return err;
-	}
-
-	ftm_counter_enable(priv->clksrc_base);
-
-	return 0;
-}
-
-static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
-				 char *ftm_name)
-{
-	struct clk *clk;
-	int err;
-
-	clk = of_clk_get_by_name(np, cnt_name);
-	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", cnt_name, PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-	err = clk_prepare_enable(clk);
-	if (err) {
-		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
-			cnt_name, err);
-		return err;
-	}
-
-	clk = of_clk_get_by_name(np, ftm_name);
-	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name, PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-	err = clk_prepare_enable(clk);
-	if (err)
-		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
-			ftm_name, err);
-
-	return clk_get_rate(clk);
-}
-
-static unsigned long __init ftm_clk_init(struct device_node *np)
-{
-	long freq;
-
-	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
-	if (freq <= 0)
-		return 0;
-
-	freq = __ftm_clk_init(np, "ftm-src-counter-en", "ftm-src");
-	if (freq <= 0)
-		return 0;
-
-	return freq;
-}
-
-static int __init ftm_calc_closest_round_cyc(unsigned long freq)
-{
-	priv->ps = 0;
-
-	/* The counter register is only using the lower 16 bits, and
-	 * if the 'freq' value is to big here, then the periodic_cyc
-	 * may exceed 0xFFFF.
-	 */
-	do {
-		priv->periodic_cyc = DIV_ROUND_CLOSEST(freq,
-						HZ * (1 << priv->ps++));
-	} while (priv->periodic_cyc > 0xFFFF);
-
-	if (priv->ps > FTM_PS_MAX) {
-		pr_err("ftm: the prescaler is %lu > %d\n",
-				priv->ps, FTM_PS_MAX);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init ftm_timer_init(struct device_node *np)
-{
-	unsigned long freq;
-	int ret, irq;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	ret = -ENXIO;
-	priv->clkevt_base = of_iomap(np, 0);
-	if (!priv->clkevt_base) {
-		pr_err("ftm: unable to map event timer registers\n");
-		goto err_clkevt;
-	}
-
-	priv->clksrc_base = of_iomap(np, 1);
-	if (!priv->clksrc_base) {
-		pr_err("ftm: unable to map source timer registers\n");
-		goto err_clksrc;
-	}
-
-	ret = -EINVAL;
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0) {
-		pr_err("ftm: unable to get IRQ from DT, %d\n", irq);
-		goto err;
-	}
-
-	priv->big_endian = of_property_read_bool(np, "big-endian");
-
-	freq = ftm_clk_init(np);
-	if (!freq)
-		goto err;
-
-	ret = ftm_calc_closest_round_cyc(freq);
-	if (ret)
-		goto err;
-
-	ret = ftm_clocksource_init(freq);
-	if (ret)
-		goto err;
-
-	ret = ftm_clockevent_init(freq, irq);
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	iounmap(priv->clksrc_base);
-err_clksrc:
-	iounmap(priv->clkevt_base);
-err_clkevt:
-	kfree(priv);
-	return ret;
-}
-TIMER_OF_DECLARE(flextimer, "fsl,ftm-timer", ftm_timer_init);
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
deleted file mode 100644
index ea00a5e8f95d..000000000000
--- a/drivers/clocksource/owl-timer.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Actions Semi Owl timer
- *
- * Copyright 2012 Actions Semi Inc.
- * Author: Actions Semi, Inc.
- *
- * Copyright (c) 2017 SUSE Linux GmbH
- * Author: Andreas Färber
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqreturn.h>
-#include <linux/sched_clock.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#define OWL_Tx_CTL		0x0
-#define OWL_Tx_CMP		0x4
-#define OWL_Tx_VAL		0x8
-
-#define OWL_Tx_CTL_PD		BIT(0)
-#define OWL_Tx_CTL_INTEN	BIT(1)
-#define OWL_Tx_CTL_EN		BIT(2)
-
-static void __iomem *owl_timer_base;
-static void __iomem *owl_clksrc_base;
-static void __iomem *owl_clkevt_base;
-
-static inline void owl_timer_reset(void __iomem *base)
-{
-	writel(0, base + OWL_Tx_CTL);
-	writel(0, base + OWL_Tx_VAL);
-	writel(0, base + OWL_Tx_CMP);
-}
-
-static inline void owl_timer_set_enabled(void __iomem *base, bool enabled)
-{
-	u32 ctl = readl(base + OWL_Tx_CTL);
-
-	/* PD bit is cleared when set */
-	ctl &= ~OWL_Tx_CTL_PD;
-
-	if (enabled)
-		ctl |= OWL_Tx_CTL_EN;
-	else
-		ctl &= ~OWL_Tx_CTL_EN;
-
-	writel(ctl, base + OWL_Tx_CTL);
-}
-
-static u64 notrace owl_timer_sched_read(void)
-{
-	return (u64)readl(owl_clksrc_base + OWL_Tx_VAL);
-}
-
-static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
-{
-	owl_timer_set_enabled(owl_clkevt_base, false);
-
-	return 0;
-}
-
-static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
-{
-	owl_timer_reset(owl_clkevt_base);
-
-	return 0;
-}
-
-static int owl_timer_tick_resume(struct clock_event_device *evt)
-{
-	return 0;
-}
-
-static int owl_timer_set_next_event(unsigned long evt,
-				    struct clock_event_device *ev)
-{
-	void __iomem *base = owl_clkevt_base;
-
-	owl_timer_set_enabled(base, false);
-	writel(OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
-	writel(0, base + OWL_Tx_VAL);
-	writel(evt, base + OWL_Tx_CMP);
-	owl_timer_set_enabled(base, true);
-
-	return 0;
-}
-
-static struct clock_event_device owl_clockevent = {
-	.name			= "owl_tick",
-	.rating			= 200,
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_DYNIRQ,
-	.set_state_shutdown	= owl_timer_set_state_shutdown,
-	.set_state_oneshot	= owl_timer_set_state_oneshot,
-	.tick_resume		= owl_timer_tick_resume,
-	.set_next_event		= owl_timer_set_next_event,
-};
-
-static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-
-	writel(OWL_Tx_CTL_PD, owl_clkevt_base + OWL_Tx_CTL);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static int __init owl_timer_init(struct device_node *node)
-{
-	struct clk *clk;
-	unsigned long rate;
-	int timer1_irq, ret;
-
-	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
-	if (IS_ERR(owl_timer_base)) {
-		pr_err("Can't map timer registers\n");
-		return PTR_ERR(owl_timer_base);
-	}
-
-	owl_clksrc_base = owl_timer_base + 0x08;
-	owl_clkevt_base = owl_timer_base + 0x14;
-
-	timer1_irq = of_irq_get_byname(node, "timer1");
-	if (timer1_irq <= 0) {
-		pr_err("Can't parse timer1 IRQ\n");
-		return -EINVAL;
-	}
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	rate = clk_get_rate(clk);
-
-	owl_timer_reset(owl_clksrc_base);
-	owl_timer_set_enabled(owl_clksrc_base, true);
-
-	sched_clock_register(owl_timer_sched_read, 32, rate);
-	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
-			      rate, 200, 32, clocksource_mmio_readl_up);
-
-	owl_timer_reset(owl_clkevt_base);
-
-	ret = request_irq(timer1_irq, owl_timer1_interrupt, IRQF_TIMER,
-			  "owl-timer", &owl_clockevent);
-	if (ret) {
-		pr_err("failed to request irq %d\n", timer1_irq);
-		return ret;
-	}
-
-	owl_clockevent.cpumask = cpumask_of(0);
-	owl_clockevent.irq = timer1_irq;
-
-	clockevents_config_and_register(&owl_clockevent, rate,
-					0xf, 0xffffffff);
-
-	return 0;
-}
-TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
-TIMER_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
-TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
deleted file mode 100644
index 89816f89ff3f..000000000000
--- a/drivers/clocksource/qcom-timer.c
+++ /dev/null
@@ -1,258 +0,0 @@
-/*
- *
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2009-2012,2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/cpu.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-#include <asm/delay.h>
-
-#define TIMER_MATCH_VAL			0x0000
-#define TIMER_COUNT_VAL			0x0004
-#define TIMER_ENABLE			0x0008
-#define TIMER_ENABLE_CLR_ON_MATCH_EN	BIT(1)
-#define TIMER_ENABLE_EN			BIT(0)
-#define TIMER_CLEAR			0x000C
-#define DGT_CLK_CTL			0x10
-#define DGT_CLK_CTL_DIV_4		0x3
-#define TIMER_STS_GPT0_CLR_PEND		BIT(10)
-
-#define GPT_HZ 32768
-
-static void __iomem *event_base;
-static void __iomem *sts_base;
-
-static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-	/* Stop the timer tick */
-	if (clockevent_state_oneshot(evt)) {
-		u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
-		ctrl &= ~TIMER_ENABLE_EN;
-		writel_relaxed(ctrl, event_base + TIMER_ENABLE);
-	}
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-static int msm_timer_set_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
-{
-	u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
-
-	ctrl &= ~TIMER_ENABLE_EN;
-	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
-
-	writel_relaxed(ctrl, event_base + TIMER_CLEAR);
-	writel_relaxed(cycles, event_base + TIMER_MATCH_VAL);
-
-	if (sts_base)
-		while (readl_relaxed(sts_base) & TIMER_STS_GPT0_CLR_PEND)
-			cpu_relax();
-
-	writel_relaxed(ctrl | TIMER_ENABLE_EN, event_base + TIMER_ENABLE);
-	return 0;
-}
-
-static int msm_timer_shutdown(struct clock_event_device *evt)
-{
-	u32 ctrl;
-
-	ctrl = readl_relaxed(event_base + TIMER_ENABLE);
-	ctrl &= ~(TIMER_ENABLE_EN | TIMER_ENABLE_CLR_ON_MATCH_EN);
-	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
-	return 0;
-}
-
-static struct clock_event_device __percpu *msm_evt;
-
-static void __iomem *source_base;
-
-static notrace u64 msm_read_timer_count(struct clocksource *cs)
-{
-	return readl_relaxed(source_base + TIMER_COUNT_VAL);
-}
-
-static struct clocksource msm_clocksource = {
-	.name	= "dg_timer",
-	.rating	= 300,
-	.read	= msm_read_timer_count,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int msm_timer_irq;
-static int msm_timer_has_ppi;
-
-static int msm_local_timer_starting_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
-	int err;
-
-	evt->irq = msm_timer_irq;
-	evt->name = "msm_timer";
-	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 200;
-	evt->set_state_shutdown = msm_timer_shutdown;
-	evt->set_state_oneshot = msm_timer_shutdown;
-	evt->tick_resume = msm_timer_shutdown;
-	evt->set_next_event = msm_timer_set_next_event;
-	evt->cpumask = cpumask_of(cpu);
-
-	clockevents_config_and_register(evt, GPT_HZ, 4, 0xffffffff);
-
-	if (msm_timer_has_ppi) {
-		enable_percpu_irq(evt->irq, IRQ_TYPE_EDGE_RISING);
-	} else {
-		err = request_irq(evt->irq, msm_timer_interrupt,
-				IRQF_TIMER | IRQF_NOBALANCING |
-				IRQF_TRIGGER_RISING, "gp_timer", evt);
-		if (err)
-			pr_err("request_irq failed\n");
-	}
-
-	return 0;
-}
-
-static int msm_local_timer_dying_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
-
-	evt->set_state_shutdown(evt);
-	disable_percpu_irq(evt->irq);
-	return 0;
-}
-
-static u64 notrace msm_sched_clock_read(void)
-{
-	return msm_clocksource.read(&msm_clocksource);
-}
-
-static unsigned long msm_read_current_timer(void)
-{
-	return msm_clocksource.read(&msm_clocksource);
-}
-
-static struct delay_timer msm_delay_timer = {
-	.read_current_timer = msm_read_current_timer,
-};
-
-static int __init msm_timer_init(u32 dgt_hz, int sched_bits, int irq,
-				  bool percpu)
-{
-	struct clocksource *cs = &msm_clocksource;
-	int res = 0;
-
-	msm_timer_irq = irq;
-	msm_timer_has_ppi = percpu;
-
-	msm_evt = alloc_percpu(struct clock_event_device);
-	if (!msm_evt) {
-		pr_err("memory allocation failed for clockevents\n");
-		goto err;
-	}
-
-	if (percpu)
-		res = request_percpu_irq(irq, msm_timer_interrupt,
-					 "gp_timer", msm_evt);
-
-	if (res) {
-		pr_err("request_percpu_irq failed\n");
-	} else {
-		/* Install and invoke hotplug callbacks */
-		res = cpuhp_setup_state(CPUHP_AP_QCOM_TIMER_STARTING,
-					"clockevents/qcom/timer:starting",
-					msm_local_timer_starting_cpu,
-					msm_local_timer_dying_cpu);
-		if (res) {
-			free_percpu_irq(irq, msm_evt);
-			goto err;
-		}
-	}
-
-err:
-	writel_relaxed(TIMER_ENABLE_EN, source_base + TIMER_ENABLE);
-	res = clocksource_register_hz(cs, dgt_hz);
-	if (res)
-		pr_err("clocksource_register failed\n");
-	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz);
-	msm_delay_timer.freq = dgt_hz;
-	register_current_timer_delay(&msm_delay_timer);
-
-	return res;
-}
-
-static int __init msm_dt_timer_init(struct device_node *np)
-{
-	u32 freq;
-	int irq, ret;
-	struct resource res;
-	u32 percpu_offset;
-	void __iomem *base;
-	void __iomem *cpu0_base;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("Failed to map event base\n");
-		return -ENXIO;
-	}
-
-	/* We use GPT0 for the clockevent */
-	irq = irq_of_parse_and_map(np, 1);
-	if (irq <= 0) {
-		pr_err("Can't get irq\n");
-		return -EINVAL;
-	}
-
-	/* We use CPU0's DGT for the clocksource */
-	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
-		percpu_offset = 0;
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		pr_err("Failed to parse DGT resource\n");
-		return ret;
-	}
-
-	cpu0_base = ioremap(res.start + percpu_offset, resource_size(&res));
-	if (!cpu0_base) {
-		pr_err("Failed to map source base\n");
-		return -EINVAL;
-	}
-
-	if (of_property_read_u32(np, "clock-frequency", &freq)) {
-		pr_err("Unknown frequency\n");
-		return -EINVAL;
-	}
-
-	event_base = base + 0x4;
-	sts_base = base + 0x88;
-	source_base = cpu0_base + 0x24;
-	freq /= 4;
-	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
-
-	return msm_timer_init(freq, 32, irq, !!percpu_offset);
-}
-TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
-TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
deleted file mode 100644
index edf1a46269f1..000000000000
--- a/drivers/clocksource/time-armada-370-xp.c
+++ /dev/null
@@ -1,416 +0,0 @@
-/*
- * Marvell Armada 370/XP SoC timer handling.
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- * Gregory CLEMENT <gregory.clement@free-electrons.com>
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * Timer 0 is used as free-running clocksource, while timer 1 is
- * used as clock_event_device.
- *
- * ---
- * Clocksource driver for Armada 370 and Armada XP SoC.
- * This driver implements one compatible string for each SoC, given
- * each has its own characteristics:
- *
- *   * Armada 370 has no 25 MHz fixed timer.
- *
- *   * Armada XP cannot work properly without such 25 MHz fixed timer as
- *     doing otherwise leads to using a clocksource whose frequency varies
- *     when doing cpufreq frequency changes.
- *
- * See Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/cpu.h>
-#include <linux/timer.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/sched_clock.h>
-#include <linux/percpu.h>
-#include <linux/syscore_ops.h>
-
-#include <asm/delay.h>
-
-/*
- * Timer block registers.
- */
-#define TIMER_CTRL_OFF		0x0000
-#define  TIMER0_EN		 BIT(0)
-#define  TIMER0_RELOAD_EN	 BIT(1)
-#define  TIMER0_25MHZ            BIT(11)
-#define  TIMER0_DIV(div)         ((div) << 19)
-#define  TIMER1_EN		 BIT(2)
-#define  TIMER1_RELOAD_EN	 BIT(3)
-#define  TIMER1_25MHZ            BIT(12)
-#define  TIMER1_DIV(div)         ((div) << 22)
-#define TIMER_EVENTS_STATUS	0x0004
-#define  TIMER0_CLR_MASK         (~0x1)
-#define  TIMER1_CLR_MASK         (~0x100)
-#define TIMER0_RELOAD_OFF	0x0010
-#define TIMER0_VAL_OFF		0x0014
-#define TIMER1_RELOAD_OFF	0x0018
-#define TIMER1_VAL_OFF		0x001c
-
-#define LCL_TIMER_EVENTS_STATUS	0x0028
-/* Global timers are connected to the coherency fabric clock, and the
-   below divider reduces their incrementing frequency. */
-#define TIMER_DIVIDER_SHIFT     5
-#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
-
-/*
- * SoC-specific data.
- */
-static void __iomem *timer_base, *local_base;
-static unsigned int timer_clk;
-static bool timer25Mhz = true;
-static u32 enable_mask;
-
-/*
- * Number of timer ticks per jiffy.
- */
-static u32 ticks_per_jiffy;
-
-static struct clock_event_device __percpu *armada_370_xp_evt;
-
-static void local_timer_ctrl_clrset(u32 clr, u32 set)
-{
-	writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
-		local_base + TIMER_CTRL_OFF);
-}
-
-static u64 notrace armada_370_xp_read_sched_clock(void)
-{
-	return ~readl(timer_base + TIMER0_VAL_OFF);
-}
-
-/*
- * Clockevent handling.
- */
-static int
-armada_370_xp_clkevt_next_event(unsigned long delta,
-				struct clock_event_device *dev)
-{
-	/*
-	 * Clear clockevent timer interrupt.
-	 */
-	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-
-	/*
-	 * Setup new clockevent timer value.
-	 */
-	writel(delta, local_base + TIMER0_VAL_OFF);
-
-	/*
-	 * Enable the timer.
-	 */
-	local_timer_ctrl_clrset(TIMER0_RELOAD_EN, enable_mask);
-	return 0;
-}
-
-static int armada_370_xp_clkevt_shutdown(struct clock_event_device *evt)
-{
-	/*
-	 * Disable timer.
-	 */
-	local_timer_ctrl_clrset(TIMER0_EN, 0);
-
-	/*
-	 * ACK pending timer interrupt.
-	 */
-	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-	return 0;
-}
-
-static int armada_370_xp_clkevt_set_periodic(struct clock_event_device *evt)
-{
-	/*
-	 * Setup timer to fire at 1/HZ intervals.
-	 */
-	writel(ticks_per_jiffy - 1, local_base + TIMER0_RELOAD_OFF);
-	writel(ticks_per_jiffy - 1, local_base + TIMER0_VAL_OFF);
-
-	/*
-	 * Enable timer.
-	 */
-	local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
-	return 0;
-}
-
-static int armada_370_xp_clkevt_irq;
-
-static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
-{
-	/*
-	 * ACK timer interrupt and call event handler.
-	 */
-	struct clock_event_device *evt = dev_id;
-
-	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Setup the local clock events for a CPU.
- */
-static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
-	u32 clr = 0, set = 0;
-
-	if (timer25Mhz)
-		set = TIMER0_25MHZ;
-	else
-		clr = TIMER0_25MHZ;
-	local_timer_ctrl_clrset(clr, set);
-
-	evt->name		= "armada_370_xp_per_cpu_tick",
-	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC;
-	evt->shift		= 32,
-	evt->rating		= 300,
-	evt->set_next_event	= armada_370_xp_clkevt_next_event,
-	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
-	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
-	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
-	evt->tick_resume	= armada_370_xp_clkevt_shutdown;
-	evt->irq		= armada_370_xp_clkevt_irq;
-	evt->cpumask		= cpumask_of(cpu);
-
-	clockevents_config_and_register(evt, timer_clk, 1, 0xfffffffe);
-	enable_percpu_irq(evt->irq, 0);
-
-	return 0;
-}
-
-static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
-
-	evt->set_state_shutdown(evt);
-	disable_percpu_irq(evt->irq);
-	return 0;
-}
-
-static u32 timer0_ctrl_reg, timer0_local_ctrl_reg;
-
-static int armada_370_xp_timer_suspend(void)
-{
-	timer0_ctrl_reg = readl(timer_base + TIMER_CTRL_OFF);
-	timer0_local_ctrl_reg = readl(local_base + TIMER_CTRL_OFF);
-	return 0;
-}
-
-static void armada_370_xp_timer_resume(void)
-{
-	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
-	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
-	writel(timer0_ctrl_reg, timer_base + TIMER_CTRL_OFF);
-	writel(timer0_local_ctrl_reg, local_base + TIMER_CTRL_OFF);
-}
-
-static struct syscore_ops armada_370_xp_timer_syscore_ops = {
-	.suspend	= armada_370_xp_timer_suspend,
-	.resume		= armada_370_xp_timer_resume,
-};
-
-static unsigned long armada_370_delay_timer_read(void)
-{
-	return ~readl(timer_base + TIMER0_VAL_OFF);
-}
-
-static struct delay_timer armada_370_delay_timer = {
-	.read_current_timer = armada_370_delay_timer_read,
-};
-
-static int __init armada_370_xp_timer_common_init(struct device_node *np)
-{
-	u32 clr = 0, set = 0;
-	int res;
-
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	local_base = of_iomap(np, 1);
-	if (!local_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	if (timer25Mhz) {
-		set = TIMER0_25MHZ;		
-		enable_mask = TIMER0_EN;
-	} else {
-		clr = TIMER0_25MHZ;
-		enable_mask = TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT);
-	}
-	atomic_io_modify(timer_base + TIMER_CTRL_OFF, clr | set, set);
-	local_timer_ctrl_clrset(clr, set);
-
-	/*
-	 * We use timer 0 as clocksource, and private(local) timer 0
-	 * for clockevents
-	 */
-	armada_370_xp_clkevt_irq = irq_of_parse_and_map(np, 4);
-
-	ticks_per_jiffy = (timer_clk + HZ / 2) / HZ;
-
-	/*
-	 * Setup free-running clocksource timer (interrupts
-	 * disabled).
-	 */
-	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
-	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
-
-	atomic_io_modify(timer_base + TIMER_CTRL_OFF,
-		TIMER0_RELOAD_EN | enable_mask,
-		TIMER0_RELOAD_EN | enable_mask);
-
-	armada_370_delay_timer.freq = timer_clk;
-	register_current_timer_delay(&armada_370_delay_timer);
-
-	/*
-	 * Set scale and timer for sched_clock.
-	 */
-	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
-
-	res = clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
-				    "armada_370_xp_clocksource",
-				    timer_clk, 300, 32, clocksource_mmio_readl_down);
-	if (res) {
-		pr_err("Failed to initialize clocksource mmio\n");
-		return res;
-	}
-
-	armada_370_xp_evt = alloc_percpu(struct clock_event_device);
-	if (!armada_370_xp_evt)
-		return -ENOMEM;
-
-	/*
-	 * Setup clockevent timer (interrupt-driven).
-	 */
-	res = request_percpu_irq(armada_370_xp_clkevt_irq,
-				armada_370_xp_timer_interrupt,
-				"armada_370_xp_per_cpu_tick",
-				armada_370_xp_evt);
-	/* Immediately configure the timer on the boot CPU */
-	if (res) {
-		pr_err("Failed to request percpu irq\n");
-		return res;
-	}
-
-	res = cpuhp_setup_state(CPUHP_AP_ARMADA_TIMER_STARTING,
-				"clockevents/armada:starting",
-				armada_370_xp_timer_starting_cpu,
-				armada_370_xp_timer_dying_cpu);
-	if (res) {
-		pr_err("Failed to setup hotplug state and timer\n");
-		return res;
-	}
-
-	register_syscore_ops(&armada_370_xp_timer_syscore_ops);
-	
-	return 0;
-}
-
-static int __init armada_xp_timer_init(struct device_node *np)
-{
-	struct clk *clk = of_clk_get_by_name(np, "fixed");
-	int ret;
-
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	timer_clk = clk_get_rate(clk);
-
-	return armada_370_xp_timer_common_init(np);
-}
-TIMER_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
-		       armada_xp_timer_init);
-
-static int __init armada_375_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get_by_name(np, "fixed");
-	if (!IS_ERR(clk)) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-		timer_clk = clk_get_rate(clk);
-	} else {
-
-		/*
-		 * This fallback is required in order to retain proper
-		 * devicetree backwards compatibility.
-		 */
-		clk = of_clk_get(np, 0);
-
-		/* Must have at least a clock */
-		if (IS_ERR(clk)) {
-			pr_err("Failed to get clock\n");
-			return PTR_ERR(clk);
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-
-		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
-		timer25Mhz = false;
-	}
-
-	return armada_370_xp_timer_common_init(np);
-}
-TIMER_OF_DECLARE(armada_375, "marvell,armada-375-timer",
-		       armada_375_timer_init);
-
-static int __init armada_370_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
-	timer25Mhz = false;
-
-	return armada_370_xp_timer_common_init(np);
-}
-TIMER_OF_DECLARE(armada_370, "marvell,armada-370-timer",
-		       armada_370_timer_init);
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
deleted file mode 100644
index 257e810ec1ad..000000000000
--- a/drivers/clocksource/time-efm32.c
+++ /dev/null
@@ -1,287 +0,0 @@
-/*
- * Copyright (C) 2013 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/clk.h>
-
-#define TIMERn_CTRL			0x00
-#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
-#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
-#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
-#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
-#define TIMERn_CTRL_OSMEN			0x00000010
-#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
-#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
-#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
-
-#define TIMERn_CMD			0x04
-#define TIMERn_CMD_START			0x00000001
-#define TIMERn_CMD_STOP				0x00000002
-
-#define TIMERn_IEN			0x0c
-#define TIMERn_IF			0x10
-#define TIMERn_IFS			0x14
-#define TIMERn_IFC			0x18
-#define TIMERn_IRQ_UF				0x00000002
-
-#define TIMERn_TOP			0x1c
-#define TIMERn_CNT			0x24
-
-struct efm32_clock_event_ddata {
-	struct clock_event_device evtdev;
-	void __iomem *base;
-	unsigned periodic_top;
-};
-
-static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_OSMEN |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	return 0;
-}
-
-static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(evt, ddata->base + TIMERn_CNT);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-
-	return 0;
-}
-
-static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
-{
-	struct efm32_clock_event_ddata *ddata = dev_id;
-
-	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
-
-	ddata->evtdev.event_handler(&ddata->evtdev);
-
-	return IRQ_HANDLED;
-}
-
-static struct efm32_clock_event_ddata clock_event_ddata = {
-	.evtdev = {
-		.name = "efm32 clockevent",
-		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_state_shutdown = efm32_clock_event_shutdown,
-		.set_state_periodic = efm32_clock_event_set_periodic,
-		.set_state_oneshot = efm32_clock_event_set_oneshot,
-		.set_next_event = efm32_clock_event_set_next_event,
-		.rating = 200,
-	},
-};
-
-static struct irqaction efm32_clock_event_irq = {
-	.name = "efm32 clockevent",
-	.flags = IRQF_TIMER,
-	.handler = efm32_clock_event_handler,
-	.dev_id = &clock_event_ddata,
-};
-
-static int __init efm32_clocksource_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clocksource (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clocksource (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate = clk_get_rate(clk);
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clocksource\n");
-		goto err_iomap;
-	}
-
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
-
-	ret = clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
-				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
-				    clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
-		goto err_clocksource_init;
-	}
-
-	return 0;
-
-err_clocksource_init:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-static int __init efm32_clockevent_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int irq;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clockevent (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clockevent (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate = clk_get_rate(clk);
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clockevent\n");
-		goto err_iomap;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -ENOENT;
-		pr_err("failed to get irq for clockevent\n");
-		goto err_get_irq;
-	}
-
-	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
-
-	clock_event_ddata.base = base;
-	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
-
-	clockevents_config_and_register(&clock_event_ddata.evtdev,
-					DIV_ROUND_CLOSEST(rate, 1024),
-					0xf, 0xffff);
-
-	ret = setup_irq(irq, &efm32_clock_event_irq);
-	if (ret) {
-		pr_err("Failed setup irq\n");
-		goto err_setup_irq;
-	}
-
-	return 0;
-
-err_setup_irq:
-err_get_irq:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-/*
- * This function asserts that we have exactly one clocksource and one
- * clock_event_device in the end.
- */
-static int __init efm32_timer_init(struct device_node *np)
-{
-	static int has_clocksource, has_clockevent;
-	int ret = 0;
-
-	if (!has_clocksource) {
-		ret = efm32_clocksource_init(np);
-		if (!ret) {
-			has_clocksource = 1;
-			return 0;
-		}
-	}
-
-	if (!has_clockevent) {
-		ret = efm32_clockevent_init(np);
-		if (!ret) {
-			has_clockevent = 1;
-			return 0;
-		}
-	}
-
-	return ret;
-}
-TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
-TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
deleted file mode 100644
index d51a62a79ef7..000000000000
--- a/drivers/clocksource/time-lpc32xx.c
+++ /dev/null
@@ -1,314 +0,0 @@
-/*
- * Clocksource driver for NXP LPC32xx/18xx/43xx timer
- *
- * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
- *
- * Based on:
- * time-efm32 Copyright (C) 2013 Pengutronix
- * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- */
-
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-#define LPC32XX_TIMER_IR		0x000
-#define  LPC32XX_TIMER_IR_MR0INT	BIT(0)
-#define LPC32XX_TIMER_TCR		0x004
-#define  LPC32XX_TIMER_TCR_CEN		BIT(0)
-#define  LPC32XX_TIMER_TCR_CRST		BIT(1)
-#define LPC32XX_TIMER_TC		0x008
-#define LPC32XX_TIMER_PR		0x00c
-#define LPC32XX_TIMER_MCR		0x014
-#define  LPC32XX_TIMER_MCR_MR0I		BIT(0)
-#define  LPC32XX_TIMER_MCR_MR0R		BIT(1)
-#define  LPC32XX_TIMER_MCR_MR0S		BIT(2)
-#define LPC32XX_TIMER_MR0		0x018
-#define LPC32XX_TIMER_CTCR		0x070
-
-struct lpc32xx_clock_event_ddata {
-	struct clock_event_device evtdev;
-	void __iomem *base;
-	u32 ticks_per_jiffy;
-};
-
-/* Needed for the sched clock */
-static void __iomem *clocksource_timer_counter;
-
-static u64 notrace lpc32xx_read_sched_clock(void)
-{
-	return readl(clocksource_timer_counter);
-}
-
-static unsigned long lpc32xx_delay_timer_read(void)
-{
-	return readl(clocksource_timer_counter);
-}
-
-static struct delay_timer lpc32xx_delay_timer = {
-	.read_current_timer = lpc32xx_delay_timer_read,
-};
-
-static int lpc32xx_clkevt_next_event(unsigned long delta,
-				     struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/*
-	 * Place timer in reset and program the delta in the match
-	 * channel 0 (MR0). When the timer counter matches the value
-	 * in MR0 register the match will trigger an interrupt.
-	 * After setup the timer is released from reset and enabled.
-	 */
-	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
-	writel_relaxed(delta, ddata->base + LPC32XX_TIMER_MR0);
-	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
-
-	return 0;
-}
-
-static int lpc32xx_clkevt_shutdown(struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/* Disable the timer */
-	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
-
-	return 0;
-}
-
-static int lpc32xx_clkevt_oneshot(struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/*
-	 * When using oneshot, we must also disable the timer
-	 * to wait for the first call to set_next_event().
-	 */
-	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
-
-	/* Enable interrupt, reset on match and stop on match (MCR). */
-	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
-		       LPC32XX_TIMER_MCR_MR0S, ddata->base + LPC32XX_TIMER_MCR);
-	return 0;
-}
-
-static int lpc32xx_clkevt_periodic(struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/* Enable interrupt and reset on match. */
-	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R,
-		       ddata->base + LPC32XX_TIMER_MCR);
-
-	/*
-	 * Place timer in reset and program the delta in the match
-	 * channel 0 (MR0).
-	 */
-	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
-	writel_relaxed(ddata->ticks_per_jiffy, ddata->base + LPC32XX_TIMER_MR0);
-	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
-
-	return 0;
-}
-
-static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
-{
-	struct lpc32xx_clock_event_ddata *ddata = dev_id;
-
-	/* Clear match on channel 0 */
-	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, ddata->base + LPC32XX_TIMER_IR);
-
-	ddata->evtdev.event_handler(&ddata->evtdev);
-
-	return IRQ_HANDLED;
-}
-
-static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
-	.evtdev = {
-		.name			= "lpc3220 clockevent",
-		.features		= CLOCK_EVT_FEAT_ONESHOT |
-					  CLOCK_EVT_FEAT_PERIODIC,
-		.rating			= 300,
-		.set_next_event		= lpc32xx_clkevt_next_event,
-		.set_state_shutdown	= lpc32xx_clkevt_shutdown,
-		.set_state_oneshot	= lpc32xx_clkevt_oneshot,
-		.set_state_periodic	= lpc32xx_clkevt_periodic,
-	},
-};
-
-static int __init lpc32xx_clocksource_init(struct device_node *np)
-{
-	void __iomem *base;
-	unsigned long rate;
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get_by_name(np, "timerclk");
-	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("clock enable failed (%d)\n", ret);
-		goto err_clk_enable;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("unable to map registers\n");
-		ret = -EADDRNOTAVAIL;
-		goto err_iomap;
-	}
-
-	/*
-	 * Disable and reset timer then set it to free running timer
-	 * mode (CTCR) with no prescaler (PR) or match operations (MCR).
-	 * After setup the timer is released from reset and enabled.
-	 */
-	writel_relaxed(LPC32XX_TIMER_TCR_CRST, base + LPC32XX_TIMER_TCR);
-	writel_relaxed(0, base + LPC32XX_TIMER_PR);
-	writel_relaxed(0, base + LPC32XX_TIMER_MCR);
-	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
-	writel_relaxed(LPC32XX_TIMER_TCR_CEN, base + LPC32XX_TIMER_TCR);
-
-	rate = clk_get_rate(clk);
-	ret = clocksource_mmio_init(base + LPC32XX_TIMER_TC, "lpc3220 timer",
-				    rate, 300, 32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
-		goto err_clocksource_init;
-	}
-
-	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
-	lpc32xx_delay_timer.freq = rate;
-	register_current_timer_delay(&lpc32xx_delay_timer);
-	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
-
-	return 0;
-
-err_clocksource_init:
-	iounmap(base);
-err_iomap:
-	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-	return ret;
-}
-
-static int __init lpc32xx_clockevent_init(struct device_node *np)
-{
-	void __iomem *base;
-	unsigned long rate;
-	struct clk *clk;
-	int ret, irq;
-
-	clk = of_clk_get_by_name(np, "timerclk");
-	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("clock enable failed (%d)\n", ret);
-		goto err_clk_enable;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("unable to map registers\n");
-		ret = -EADDRNOTAVAIL;
-		goto err_iomap;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		pr_err("get irq failed\n");
-		ret = -ENOENT;
-		goto err_irq;
-	}
-
-	/*
-	 * Disable timer and clear any pending interrupt (IR) on match
-	 * channel 0 (MR0). Clear the prescaler as it's not used.
-	 */
-	writel_relaxed(0, base + LPC32XX_TIMER_TCR);
-	writel_relaxed(0, base + LPC32XX_TIMER_PR);
-	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
-	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
-
-	rate = clk_get_rate(clk);
-	lpc32xx_clk_event_ddata.base = base;
-	lpc32xx_clk_event_ddata.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
-	clockevents_config_and_register(&lpc32xx_clk_event_ddata.evtdev,
-					rate, 1, -1);
-
-	ret = request_irq(irq, lpc32xx_clock_event_handler,
-			  IRQF_TIMER | IRQF_IRQPOLL, "lpc3220 clockevent",
-			  &lpc32xx_clk_event_ddata);
-	if (ret) {
-		pr_err("request irq failed\n");
-		goto err_irq;
-	}
-
-	return 0;
-
-err_irq:
-	iounmap(base);
-err_iomap:
-	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-	return ret;
-}
-
-/*
- * This function asserts that we have exactly one clocksource and one
- * clock_event_device in the end.
- */
-static int __init lpc32xx_timer_init(struct device_node *np)
-{
-	static int has_clocksource, has_clockevent;
-	int ret = 0;
-
-	if (!has_clocksource) {
-		ret = lpc32xx_clocksource_init(np);
-		if (!ret) {
-			has_clocksource = 1;
-			return 0;
-		}
-	}
-
-	if (!has_clockevent) {
-		ret = lpc32xx_clockevent_init(np);
-		if (!ret) {
-			has_clockevent = 1;
-			return 0;
-		}
-	}
-
-	return ret;
-}
-TIMER_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
deleted file mode 100644
index 12202067fe4b..000000000000
--- a/drivers/clocksource/time-orion.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * Marvell Orion SoC timer handling.
- *
- * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * Timer 0 is used as free-running clocksource, while timer 1 is
- * used as clock_event_device.
- */
-
-#include <linux/kernel.h>
-#include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/spinlock.h>
-#include <linux/sched_clock.h>
-
-#define TIMER_CTRL		0x00
-#define  TIMER0_EN		BIT(0)
-#define  TIMER0_RELOAD_EN	BIT(1)
-#define  TIMER1_EN		BIT(2)
-#define  TIMER1_RELOAD_EN	BIT(3)
-#define TIMER0_RELOAD		0x10
-#define TIMER0_VAL		0x14
-#define TIMER1_RELOAD		0x18
-#define TIMER1_VAL		0x1c
-
-#define ORION_ONESHOT_MIN	1
-#define ORION_ONESHOT_MAX	0xfffffffe
-
-static void __iomem *timer_base;
-
-static unsigned long notrace orion_read_timer(void)
-{
-	return ~readl(timer_base + TIMER0_VAL);
-}
-
-static struct delay_timer orion_delay_timer = {
-	.read_current_timer = orion_read_timer,
-};
-
-static void orion_delay_timer_init(unsigned long rate)
-{
-	orion_delay_timer.freq = rate;
-	register_current_timer_delay(&orion_delay_timer);
-}
-
-/*
- * Free-running clocksource handling.
- */
-static u64 notrace orion_read_sched_clock(void)
-{
-	return ~readl(timer_base + TIMER0_VAL);
-}
-
-/*
- * Clockevent handling.
- */
-static u32 ticks_per_jiffy;
-
-static int orion_clkevt_next_event(unsigned long delta,
-				   struct clock_event_device *dev)
-{
-	/* setup and enable one-shot timer */
-	writel(delta, timer_base + TIMER1_VAL);
-	atomic_io_modify(timer_base + TIMER_CTRL,
-		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
-
-	return 0;
-}
-
-static int orion_clkevt_shutdown(struct clock_event_device *dev)
-{
-	/* disable timer */
-	atomic_io_modify(timer_base + TIMER_CTRL,
-			 TIMER1_RELOAD_EN | TIMER1_EN, 0);
-	return 0;
-}
-
-static int orion_clkevt_set_periodic(struct clock_event_device *dev)
-{
-	/* setup and enable periodic timer at 1/HZ intervals */
-	writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
-	writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
-	atomic_io_modify(timer_base + TIMER_CTRL,
-			 TIMER1_RELOAD_EN | TIMER1_EN,
-			 TIMER1_RELOAD_EN | TIMER1_EN);
-	return 0;
-}
-
-static struct clock_event_device orion_clkevt = {
-	.name			= "orion_event",
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC,
-	.shift			= 32,
-	.rating			= 300,
-	.set_next_event		= orion_clkevt_next_event,
-	.set_state_shutdown	= orion_clkevt_shutdown,
-	.set_state_periodic	= orion_clkevt_set_periodic,
-	.set_state_oneshot	= orion_clkevt_shutdown,
-	.tick_resume		= orion_clkevt_shutdown,
-};
-
-static irqreturn_t orion_clkevt_irq_handler(int irq, void *dev_id)
-{
-	orion_clkevt.event_handler(&orion_clkevt);
-	return IRQ_HANDLED;
-}
-
-static struct irqaction orion_clkevt_irq = {
-	.name		= "orion_event",
-	.flags		= IRQF_TIMER,
-	.handler	= orion_clkevt_irq_handler,
-};
-
-static int __init orion_timer_init(struct device_node *np)
-{
-	unsigned long rate;
-	struct clk *clk;
-	int irq, ret;
-
-	/* timer registers are shared with watchdog timer */
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
-		return -ENXIO;
-	}
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("%s: unable to get clk\n", np->name);
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Failed to prepare clock\n");
-		return ret;
-	}
-
-	/* we are only interested in timer1 irq */
-	irq = irq_of_parse_and_map(np, 1);
-	if (irq <= 0) {
-		pr_err("%s: unable to parse timer1 irq\n", np->name);
-		return -EINVAL;
-	}
-
-	rate = clk_get_rate(clk);
-
-	/* setup timer0 as free-running clocksource */
-	writel(~0, timer_base + TIMER0_VAL);
-	writel(~0, timer_base + TIMER0_RELOAD);
-	atomic_io_modify(timer_base + TIMER_CTRL,
-		TIMER0_RELOAD_EN | TIMER0_EN,
-		TIMER0_RELOAD_EN | TIMER0_EN);
-
-	ret = clocksource_mmio_init(timer_base + TIMER0_VAL,
-				    "orion_clocksource", rate, 300, 32,
-				    clocksource_mmio_readl_down);
-	if (ret) {
-		pr_err("Failed to initialize mmio timer\n");
-		return ret;
-	}
-
-	sched_clock_register(orion_read_sched_clock, 32, rate);
-
-	/* setup timer1 as clockevent timer */
-	ret = setup_irq(irq, &orion_clkevt_irq);
-	if (ret) {
-		pr_err("%s: unable to setup irq\n", np->name);
-		return ret;
-	}
-
-	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
-	orion_clkevt.cpumask = cpumask_of(0);
-	orion_clkevt.irq = irq;
-	clockevents_config_and_register(&orion_clkevt, rate,
-					ORION_ONESHOT_MIN, ORION_ONESHOT_MAX);
-
-
-	orion_delay_timer_init(rate);
-
-	return 0;
-}
-TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
deleted file mode 100644
index a2dd85d0c1d7..000000000000
--- a/drivers/clocksource/time-pistachio.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * Pistachio clocksource based on general-purpose timers
- *
- * Copyright (C) 2015 Imagination Technologies
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
-#include <linux/clk.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/sched_clock.h>
-#include <linux/time.h>
-
-/* Top level reg */
-#define CR_TIMER_CTRL_CFG		0x00
-#define TIMER_ME_GLOBAL			BIT(0)
-#define CR_TIMER_REV			0x10
-
-/* Timer specific registers */
-#define TIMER_CFG			0x20
-#define TIMER_ME_LOCAL			BIT(0)
-#define TIMER_RELOAD_VALUE		0x24
-#define TIMER_CURRENT_VALUE		0x28
-#define TIMER_CURRENT_OVERFLOW_VALUE	0x2C
-#define TIMER_IRQ_STATUS		0x30
-#define TIMER_IRQ_CLEAR			0x34
-#define TIMER_IRQ_MASK			0x38
-
-#define PERIP_TIMER_CONTROL		0x90
-
-/* Timer specific configuration Values */
-#define RELOAD_VALUE			0xffffffff
-
-struct pistachio_clocksource {
-	void __iomem *base;
-	raw_spinlock_t lock;
-	struct clocksource cs;
-};
-
-static struct pistachio_clocksource pcs_gpt;
-
-#define to_pistachio_clocksource(cs)	\
-	container_of(cs, struct pistachio_clocksource, cs)
-
-static inline u32 gpt_readl(void __iomem *base, u32 offset, u32 gpt_id)
-{
-	return readl(base + 0x20 * gpt_id + offset);
-}
-
-static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
-		u32 gpt_id)
-{
-	writel(value, base + 0x20 * gpt_id + offset);
-}
-
-static u64 notrace
-pistachio_clocksource_read_cycles(struct clocksource *cs)
-{
-	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 counter, overflw;
-	unsigned long flags;
-
-	/*
-	 * The counter value is only refreshed after the overflow value is read.
-	 * And they must be read in strict order, hence raw spin lock added.
-	 */
-
-	raw_spin_lock_irqsave(&pcs->lock, flags);
-	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
-	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
-	raw_spin_unlock_irqrestore(&pcs->lock, flags);
-
-	return (u64)~counter;
-}
-
-static u64 notrace pistachio_read_sched_clock(void)
-{
-	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);
-}
-
-static void pistachio_clksrc_set_mode(struct clocksource *cs, int timeridx,
-			int enable)
-{
-	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 val;
-
-	val = gpt_readl(pcs->base, TIMER_CFG, timeridx);
-	if (enable)
-		val |= TIMER_ME_LOCAL;
-	else
-		val &= ~TIMER_ME_LOCAL;
-
-	gpt_writel(pcs->base, val, TIMER_CFG, timeridx);
-}
-
-static void pistachio_clksrc_enable(struct clocksource *cs, int timeridx)
-{
-	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-
-	/* Disable GPT local before loading reload value */
-	pistachio_clksrc_set_mode(cs, timeridx, false);
-	gpt_writel(pcs->base, RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
-	pistachio_clksrc_set_mode(cs, timeridx, true);
-}
-
-static void pistachio_clksrc_disable(struct clocksource *cs, int timeridx)
-{
-	/* Disable GPT local */
-	pistachio_clksrc_set_mode(cs, timeridx, false);
-}
-
-static int pistachio_clocksource_enable(struct clocksource *cs)
-{
-	pistachio_clksrc_enable(cs, 0);
-	return 0;
-}
-
-static void pistachio_clocksource_disable(struct clocksource *cs)
-{
-	pistachio_clksrc_disable(cs, 0);
-}
-
-/* Desirable clock source for pistachio platform */
-static struct pistachio_clocksource pcs_gpt = {
-	.cs =	{
-		.name		= "gptimer",
-		.rating		= 300,
-		.enable		= pistachio_clocksource_enable,
-		.disable	= pistachio_clocksource_disable,
-		.read		= pistachio_clocksource_read_cycles,
-		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_SUSPEND_NONSTOP,
-		},
-};
-
-static int __init pistachio_clksrc_of_init(struct device_node *node)
-{
-	struct clk *sys_clk, *fast_clk;
-	struct regmap *periph_regs;
-	unsigned long rate;
-	int ret;
-
-	pcs_gpt.base = of_iomap(node, 0);
-	if (!pcs_gpt.base) {
-		pr_err("cannot iomap\n");
-		return -ENXIO;
-	}
-
-	periph_regs = syscon_regmap_lookup_by_phandle(node, "img,cr-periph");
-	if (IS_ERR(periph_regs)) {
-		pr_err("cannot get peripheral regmap (%ld)\n",
-		       PTR_ERR(periph_regs));
-		return PTR_ERR(periph_regs);
-	}
-
-	/* Switch to using the fast counter clock */
-	ret = regmap_update_bits(periph_regs, PERIP_TIMER_CONTROL,
-				 0xf, 0x0);
-	if (ret)
-		return ret;
-
-	sys_clk = of_clk_get_by_name(node, "sys");
-	if (IS_ERR(sys_clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(sys_clk));
-		return PTR_ERR(sys_clk);
-	}
-
-	fast_clk = of_clk_get_by_name(node, "fast");
-	if (IS_ERR(fast_clk)) {
-		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
-		return PTR_ERR(fast_clk);
-	}
-
-	ret = clk_prepare_enable(sys_clk);
-	if (ret < 0) {
-		pr_err("failed to enable clock (%d)\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(fast_clk);
-	if (ret < 0) {
-		pr_err("failed to enable clock (%d)\n", ret);
-		clk_disable_unprepare(sys_clk);
-		return ret;
-	}
-
-	rate = clk_get_rate(fast_clk);
-
-	/* Disable irq's for clocksource usage */
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
-
-	/* Enable timer block */
-	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
-
-	raw_spin_lock_init(&pcs_gpt.lock);
-	sched_clock_register(pistachio_read_sched_clock, 32, rate);
-	return clocksource_register_hz(&pcs_gpt.cs, rate);
-}
-TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
-		       pistachio_clksrc_of_init);
diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
new file mode 100644
index 000000000000..edf1a46269f1
--- /dev/null
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -0,0 +1,416 @@
+/*
+ * Marvell Armada 370/XP SoC timer handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ *
+ * ---
+ * Clocksource driver for Armada 370 and Armada XP SoC.
+ * This driver implements one compatible string for each SoC, given
+ * each has its own characteristics:
+ *
+ *   * Armada 370 has no 25 MHz fixed timer.
+ *
+ *   * Armada XP cannot work properly without such 25 MHz fixed timer as
+ *     doing otherwise leads to using a clocksource whose frequency varies
+ *     when doing cpufreq frequency changes.
+ *
+ * See Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/timer.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/sched_clock.h>
+#include <linux/percpu.h>
+#include <linux/syscore_ops.h>
+
+#include <asm/delay.h>
+
+/*
+ * Timer block registers.
+ */
+#define TIMER_CTRL_OFF		0x0000
+#define  TIMER0_EN		 BIT(0)
+#define  TIMER0_RELOAD_EN	 BIT(1)
+#define  TIMER0_25MHZ            BIT(11)
+#define  TIMER0_DIV(div)         ((div) << 19)
+#define  TIMER1_EN		 BIT(2)
+#define  TIMER1_RELOAD_EN	 BIT(3)
+#define  TIMER1_25MHZ            BIT(12)
+#define  TIMER1_DIV(div)         ((div) << 22)
+#define TIMER_EVENTS_STATUS	0x0004
+#define  TIMER0_CLR_MASK         (~0x1)
+#define  TIMER1_CLR_MASK         (~0x100)
+#define TIMER0_RELOAD_OFF	0x0010
+#define TIMER0_VAL_OFF		0x0014
+#define TIMER1_RELOAD_OFF	0x0018
+#define TIMER1_VAL_OFF		0x001c
+
+#define LCL_TIMER_EVENTS_STATUS	0x0028
+/* Global timers are connected to the coherency fabric clock, and the
+   below divider reduces their incrementing frequency. */
+#define TIMER_DIVIDER_SHIFT     5
+#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
+
+/*
+ * SoC-specific data.
+ */
+static void __iomem *timer_base, *local_base;
+static unsigned int timer_clk;
+static bool timer25Mhz = true;
+static u32 enable_mask;
+
+/*
+ * Number of timer ticks per jiffy.
+ */
+static u32 ticks_per_jiffy;
+
+static struct clock_event_device __percpu *armada_370_xp_evt;
+
+static void local_timer_ctrl_clrset(u32 clr, u32 set)
+{
+	writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
+		local_base + TIMER_CTRL_OFF);
+}
+
+static u64 notrace armada_370_xp_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+/*
+ * Clockevent handling.
+ */
+static int
+armada_370_xp_clkevt_next_event(unsigned long delta,
+				struct clock_event_device *dev)
+{
+	/*
+	 * Clear clockevent timer interrupt.
+	 */
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+
+	/*
+	 * Setup new clockevent timer value.
+	 */
+	writel(delta, local_base + TIMER0_VAL_OFF);
+
+	/*
+	 * Enable the timer.
+	 */
+	local_timer_ctrl_clrset(TIMER0_RELOAD_EN, enable_mask);
+	return 0;
+}
+
+static int armada_370_xp_clkevt_shutdown(struct clock_event_device *evt)
+{
+	/*
+	 * Disable timer.
+	 */
+	local_timer_ctrl_clrset(TIMER0_EN, 0);
+
+	/*
+	 * ACK pending timer interrupt.
+	 */
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+	return 0;
+}
+
+static int armada_370_xp_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	/*
+	 * Setup timer to fire at 1/HZ intervals.
+	 */
+	writel(ticks_per_jiffy - 1, local_base + TIMER0_RELOAD_OFF);
+	writel(ticks_per_jiffy - 1, local_base + TIMER0_VAL_OFF);
+
+	/*
+	 * Enable timer.
+	 */
+	local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
+	return 0;
+}
+
+static int armada_370_xp_clkevt_irq;
+
+static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * ACK timer interrupt and call event handler.
+	 */
+	struct clock_event_device *evt = dev_id;
+
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
+	u32 clr = 0, set = 0;
+
+	if (timer25Mhz)
+		set = TIMER0_25MHZ;
+	else
+		clr = TIMER0_25MHZ;
+	local_timer_ctrl_clrset(clr, set);
+
+	evt->name		= "armada_370_xp_per_cpu_tick",
+	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC;
+	evt->shift		= 32,
+	evt->rating		= 300,
+	evt->set_next_event	= armada_370_xp_clkevt_next_event,
+	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
+	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
+	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
+	evt->tick_resume	= armada_370_xp_clkevt_shutdown;
+	evt->irq		= armada_370_xp_clkevt_irq;
+	evt->cpumask		= cpumask_of(cpu);
+
+	clockevents_config_and_register(evt, timer_clk, 1, 0xfffffffe);
+	enable_percpu_irq(evt->irq, 0);
+
+	return 0;
+}
+
+static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
+
+	evt->set_state_shutdown(evt);
+	disable_percpu_irq(evt->irq);
+	return 0;
+}
+
+static u32 timer0_ctrl_reg, timer0_local_ctrl_reg;
+
+static int armada_370_xp_timer_suspend(void)
+{
+	timer0_ctrl_reg = readl(timer_base + TIMER_CTRL_OFF);
+	timer0_local_ctrl_reg = readl(local_base + TIMER_CTRL_OFF);
+	return 0;
+}
+
+static void armada_370_xp_timer_resume(void)
+{
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+	writel(timer0_ctrl_reg, timer_base + TIMER_CTRL_OFF);
+	writel(timer0_local_ctrl_reg, local_base + TIMER_CTRL_OFF);
+}
+
+static struct syscore_ops armada_370_xp_timer_syscore_ops = {
+	.suspend	= armada_370_xp_timer_suspend,
+	.resume		= armada_370_xp_timer_resume,
+};
+
+static unsigned long armada_370_delay_timer_read(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+static struct delay_timer armada_370_delay_timer = {
+	.read_current_timer = armada_370_delay_timer_read,
+};
+
+static int __init armada_370_xp_timer_common_init(struct device_node *np)
+{
+	u32 clr = 0, set = 0;
+	int res;
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("Failed to iomap\n");
+		return -ENXIO;
+	}
+
+	local_base = of_iomap(np, 1);
+	if (!local_base) {
+		pr_err("Failed to iomap\n");
+		return -ENXIO;
+	}
+
+	if (timer25Mhz) {
+		set = TIMER0_25MHZ;		
+		enable_mask = TIMER0_EN;
+	} else {
+		clr = TIMER0_25MHZ;
+		enable_mask = TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT);
+	}
+	atomic_io_modify(timer_base + TIMER_CTRL_OFF, clr | set, set);
+	local_timer_ctrl_clrset(clr, set);
+
+	/*
+	 * We use timer 0 as clocksource, and private(local) timer 0
+	 * for clockevents
+	 */
+	armada_370_xp_clkevt_irq = irq_of_parse_and_map(np, 4);
+
+	ticks_per_jiffy = (timer_clk + HZ / 2) / HZ;
+
+	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled).
+	 */
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+
+	atomic_io_modify(timer_base + TIMER_CTRL_OFF,
+		TIMER0_RELOAD_EN | enable_mask,
+		TIMER0_RELOAD_EN | enable_mask);
+
+	armada_370_delay_timer.freq = timer_clk;
+	register_current_timer_delay(&armada_370_delay_timer);
+
+	/*
+	 * Set scale and timer for sched_clock.
+	 */
+	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
+
+	res = clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
+				    "armada_370_xp_clocksource",
+				    timer_clk, 300, 32, clocksource_mmio_readl_down);
+	if (res) {
+		pr_err("Failed to initialize clocksource mmio\n");
+		return res;
+	}
+
+	armada_370_xp_evt = alloc_percpu(struct clock_event_device);
+	if (!armada_370_xp_evt)
+		return -ENOMEM;
+
+	/*
+	 * Setup clockevent timer (interrupt-driven).
+	 */
+	res = request_percpu_irq(armada_370_xp_clkevt_irq,
+				armada_370_xp_timer_interrupt,
+				"armada_370_xp_per_cpu_tick",
+				armada_370_xp_evt);
+	/* Immediately configure the timer on the boot CPU */
+	if (res) {
+		pr_err("Failed to request percpu irq\n");
+		return res;
+	}
+
+	res = cpuhp_setup_state(CPUHP_AP_ARMADA_TIMER_STARTING,
+				"clockevents/armada:starting",
+				armada_370_xp_timer_starting_cpu,
+				armada_370_xp_timer_dying_cpu);
+	if (res) {
+		pr_err("Failed to setup hotplug state and timer\n");
+		return res;
+	}
+
+	register_syscore_ops(&armada_370_xp_timer_syscore_ops);
+	
+	return 0;
+}
+
+static int __init armada_xp_timer_init(struct device_node *np)
+{
+	struct clk *clk = of_clk_get_by_name(np, "fixed");
+	int ret;
+
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	timer_clk = clk_get_rate(clk);
+
+	return armada_370_xp_timer_common_init(np);
+}
+TIMER_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
+		       armada_xp_timer_init);
+
+static int __init armada_375_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get_by_name(np, "fixed");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+		timer_clk = clk_get_rate(clk);
+	} else {
+
+		/*
+		 * This fallback is required in order to retain proper
+		 * devicetree backwards compatibility.
+		 */
+		clk = of_clk_get(np, 0);
+
+		/* Must have at least a clock */
+		if (IS_ERR(clk)) {
+			pr_err("Failed to get clock\n");
+			return PTR_ERR(clk);
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+
+		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
+		timer25Mhz = false;
+	}
+
+	return armada_370_xp_timer_common_init(np);
+}
+TIMER_OF_DECLARE(armada_375, "marvell,armada-375-timer",
+		       armada_375_timer_init);
+
+static int __init armada_370_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
+	timer25Mhz = false;
+
+	return armada_370_xp_timer_common_init(np);
+}
+TIMER_OF_DECLARE(armada_370, "marvell,armada-370-timer",
+		       armada_370_timer_init);
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
new file mode 100644
index 000000000000..16b9bfb25756
--- /dev/null
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -0,0 +1,560 @@
+/*
+ * This file contains driver for the Cadence Triple Timer Counter Rev 06
+ *
+ *  Copyright (C) 2011-2013 Xilinx
+ *
+ * based on arch/mips/kernel/time.c timer driver
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/sched_clock.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+
+/*
+ * This driver configures the 2 16/32-bit count-up timers as follows:
+ *
+ * T1: Timer 1, clocksource for generic timekeeping
+ * T2: Timer 2, clockevent source for hrtimers
+ * T3: Timer 3, <unused>
+ *
+ * The input frequency to the timer module for emulation is 2.5MHz which is
+ * common to all the timer channels (T1, T2, and T3). With a pre-scaler of 32,
+ * the timers are clocked at 78.125KHz (12.8 us resolution).
+
+ * The input frequency to the timer module in silicon is configurable and
+ * obtained from device tree. The pre-scaler of 32 is used.
+ */
+
+/*
+ * Timer Register Offset Definitions of Timer 1, Increment base address by 4
+ * and use same offsets for Timer 2
+ */
+#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
+#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
+#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
+#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
+#define TTC_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
+#define TTC_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
+
+#define TTC_CNT_CNTRL_DISABLE_MASK	0x1
+
+#define TTC_CLK_CNTRL_CSRC_MASK		(1 << 5)	/* clock source */
+#define TTC_CLK_CNTRL_PSV_MASK		0x1e
+#define TTC_CLK_CNTRL_PSV_SHIFT		1
+
+/*
+ * Setup the timers to use pre-scaling, using a fixed value for now that will
+ * work across most input frequency, but it may need to be more dynamic
+ */
+#define PRESCALE_EXPONENT	11	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
+#define PRESCALE		2048	/* The exponent must match this */
+#define CLK_CNTRL_PRESCALE	((PRESCALE_EXPONENT - 1) << 1)
+#define CLK_CNTRL_PRESCALE_EN	1
+#define CNT_CNTRL_RESET		(1 << 4)
+
+#define MAX_F_ERR 50
+
+/**
+ * struct ttc_timer - This definition defines local timer structure
+ *
+ * @base_addr:	Base address of timer
+ * @freq:	Timer input clock frequency
+ * @clk:	Associated clock source
+ * @clk_rate_change_nb	Notifier block for clock rate changes
+ */
+struct ttc_timer {
+	void __iomem *base_addr;
+	unsigned long freq;
+	struct clk *clk;
+	struct notifier_block clk_rate_change_nb;
+};
+
+#define to_ttc_timer(x) \
+		container_of(x, struct ttc_timer, clk_rate_change_nb)
+
+struct ttc_timer_clocksource {
+	u32			scale_clk_ctrl_reg_old;
+	u32			scale_clk_ctrl_reg_new;
+	struct ttc_timer	ttc;
+	struct clocksource	cs;
+};
+
+#define to_ttc_timer_clksrc(x) \
+		container_of(x, struct ttc_timer_clocksource, cs)
+
+struct ttc_timer_clockevent {
+	struct ttc_timer		ttc;
+	struct clock_event_device	ce;
+};
+
+#define to_ttc_timer_clkevent(x) \
+		container_of(x, struct ttc_timer_clockevent, ce)
+
+static void __iomem *ttc_sched_clock_val_reg;
+
+/**
+ * ttc_set_interval - Set the timer interval value
+ *
+ * @timer:	Pointer to the timer instance
+ * @cycles:	Timer interval ticks
+ **/
+static void ttc_set_interval(struct ttc_timer *timer,
+					unsigned long cycles)
+{
+	u32 ctrl_reg;
+
+	/* Disable the counter, set the counter value  and re-enable counter */
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+
+	writel_relaxed(cycles, timer->base_addr + TTC_INTR_VAL_OFFSET);
+
+	/*
+	 * Reset the counter (0x10) so that it starts from 0, one-shot
+	 * mode makes this needed for timing to be right.
+	 */
+	ctrl_reg |= CNT_CNTRL_RESET;
+	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+}
+
+/**
+ * ttc_clock_event_interrupt - Clock event timer interrupt handler
+ *
+ * @irq:	IRQ number of the Timer
+ * @dev_id:	void pointer to the ttc_timer instance
+ *
+ * returns: Always IRQ_HANDLED - success
+ **/
+static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
+{
+	struct ttc_timer_clockevent *ttce = dev_id;
+	struct ttc_timer *timer = &ttce->ttc;
+
+	/* Acknowledge the interrupt and call event handler */
+	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
+
+	ttce->ce.event_handler(&ttce->ce);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * __ttc_clocksource_read - Reads the timer counter register
+ *
+ * returns: Current timer counter register value
+ **/
+static u64 __ttc_clocksource_read(struct clocksource *cs)
+{
+	struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
+
+	return (u64)readl_relaxed(timer->base_addr +
+				TTC_COUNT_VAL_OFFSET);
+}
+
+static u64 notrace ttc_sched_clock_read(void)
+{
+	return readl_relaxed(ttc_sched_clock_val_reg);
+}
+
+/**
+ * ttc_set_next_event - Sets the time interval for next event
+ *
+ * @cycles:	Timer interval ticks
+ * @evt:	Address of clock event instance
+ *
+ * returns: Always 0 - success
+ **/
+static int ttc_set_next_event(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+
+	ttc_set_interval(timer, cycles);
+	return 0;
+}
+
+/**
+ * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
+ *
+ * @evt:	Address of clock event instance
+ **/
+static int ttc_shutdown(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+	u32 ctrl_reg;
+
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	return 0;
+}
+
+static int ttc_set_periodic(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+
+	ttc_set_interval(timer,
+			 DIV_ROUND_CLOSEST(ttce->ttc.freq, PRESCALE * HZ));
+	return 0;
+}
+
+static int ttc_resume(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+	u32 ctrl_reg;
+
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	return 0;
+}
+
+static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct ttc_timer *ttc = to_ttc_timer(nb);
+	struct ttc_timer_clocksource *ttccs = container_of(ttc,
+			struct ttc_timer_clocksource, ttc);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+	{
+		u32 psv;
+		unsigned long factor, rate_low, rate_high;
+
+		if (ndata->new_rate > ndata->old_rate) {
+			factor = DIV_ROUND_CLOSEST(ndata->new_rate,
+					ndata->old_rate);
+			rate_low = ndata->old_rate;
+			rate_high = ndata->new_rate;
+		} else {
+			factor = DIV_ROUND_CLOSEST(ndata->old_rate,
+					ndata->new_rate);
+			rate_low = ndata->new_rate;
+			rate_high = ndata->old_rate;
+		}
+
+		if (!is_power_of_2(factor))
+				return NOTIFY_BAD;
+
+		if (abs(rate_high - (factor * rate_low)) > MAX_F_ERR)
+			return NOTIFY_BAD;
+
+		factor = __ilog2_u32(factor);
+
+		/*
+		 * store timer clock ctrl register so we can restore it in case
+		 * of an abort.
+		 */
+		ttccs->scale_clk_ctrl_reg_old =
+			readl_relaxed(ttccs->ttc.base_addr +
+			TTC_CLK_CNTRL_OFFSET);
+
+		psv = (ttccs->scale_clk_ctrl_reg_old &
+				TTC_CLK_CNTRL_PSV_MASK) >>
+				TTC_CLK_CNTRL_PSV_SHIFT;
+		if (ndata->new_rate < ndata->old_rate)
+			psv -= factor;
+		else
+			psv += factor;
+
+		/* prescaler within legal range? */
+		if (psv & ~(TTC_CLK_CNTRL_PSV_MASK >> TTC_CLK_CNTRL_PSV_SHIFT))
+			return NOTIFY_BAD;
+
+		ttccs->scale_clk_ctrl_reg_new = ttccs->scale_clk_ctrl_reg_old &
+			~TTC_CLK_CNTRL_PSV_MASK;
+		ttccs->scale_clk_ctrl_reg_new |= psv << TTC_CLK_CNTRL_PSV_SHIFT;
+
+
+		/* scale down: adjust divider in post-change notification */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_DONE;
+
+		/* scale up: adjust divider now - before frequency change */
+		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
+			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+		break;
+	}
+	case POST_RATE_CHANGE:
+		/* scale up: pre-change notification did the adjustment */
+		if (ndata->new_rate > ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* scale down: adjust divider now - after frequency change */
+		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
+			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+		break;
+
+	case ABORT_RATE_CHANGE:
+		/* we have to undo the adjustment in case we scale up */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* restore original register value */
+		writel_relaxed(ttccs->scale_clk_ctrl_reg_old,
+			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+		/* fall through */
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
+					 u32 timer_width)
+{
+	struct ttc_timer_clocksource *ttccs;
+	int err;
+
+	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
+	if (!ttccs)
+		return -ENOMEM;
+
+	ttccs->ttc.clk = clk;
+
+	err = clk_prepare_enable(ttccs->ttc.clk);
+	if (err) {
+		kfree(ttccs);
+		return err;
+	}
+
+	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
+
+	ttccs->ttc.clk_rate_change_nb.notifier_call =
+		ttc_rate_change_clocksource_cb;
+	ttccs->ttc.clk_rate_change_nb.next = NULL;
+
+	err = clk_notifier_register(ttccs->ttc.clk,
+				    &ttccs->ttc.clk_rate_change_nb);
+	if (err)
+		pr_warn("Unable to register clock notifier.\n");
+
+	ttccs->ttc.base_addr = base;
+	ttccs->cs.name = "ttc_clocksource";
+	ttccs->cs.rating = 200;
+	ttccs->cs.read = __ttc_clocksource_read;
+	ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
+	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	/*
+	 * Setup the clock source counter to be an incrementing counter
+	 * with no interrupt and it rolls over at 0xFFFF. Pre-scale
+	 * it by 32 also. Let it start running now.
+	 */
+	writel_relaxed(0x0,  ttccs->ttc.base_addr + TTC_IER_OFFSET);
+	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
+		     ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+	writel_relaxed(CNT_CNTRL_RESET,
+		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
+
+	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
+	if (err) {
+		kfree(ttccs);
+		return err;
+	}
+
+	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
+	sched_clock_register(ttc_sched_clock_read, timer_width,
+			     ttccs->ttc.freq / PRESCALE);
+
+	return 0;
+}
+
+static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct ttc_timer *ttc = to_ttc_timer(nb);
+	struct ttc_timer_clockevent *ttcce = container_of(ttc,
+			struct ttc_timer_clockevent, ttc);
+
+	switch (event) {
+	case POST_RATE_CHANGE:
+		/* update cached frequency */
+		ttc->freq = ndata->new_rate;
+
+		clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
+
+		/* fall through */
+	case PRE_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static int __init ttc_setup_clockevent(struct clk *clk,
+				       void __iomem *base, u32 irq)
+{
+	struct ttc_timer_clockevent *ttcce;
+	int err;
+
+	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
+	if (!ttcce)
+		return -ENOMEM;
+
+	ttcce->ttc.clk = clk;
+
+	err = clk_prepare_enable(ttcce->ttc.clk);
+	if (err)
+		goto out_kfree;
+
+	ttcce->ttc.clk_rate_change_nb.notifier_call =
+		ttc_rate_change_clockevent_cb;
+	ttcce->ttc.clk_rate_change_nb.next = NULL;
+
+	err = clk_notifier_register(ttcce->ttc.clk,
+				    &ttcce->ttc.clk_rate_change_nb);
+	if (err) {
+		pr_warn("Unable to register clock notifier.\n");
+		goto out_kfree;
+	}
+
+	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
+
+	ttcce->ttc.base_addr = base;
+	ttcce->ce.name = "ttc_clockevent";
+	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	ttcce->ce.set_next_event = ttc_set_next_event;
+	ttcce->ce.set_state_shutdown = ttc_shutdown;
+	ttcce->ce.set_state_periodic = ttc_set_periodic;
+	ttcce->ce.set_state_oneshot = ttc_shutdown;
+	ttcce->ce.tick_resume = ttc_resume;
+	ttcce->ce.rating = 200;
+	ttcce->ce.irq = irq;
+	ttcce->ce.cpumask = cpu_possible_mask;
+
+	/*
+	 * Setup the clock event timer to be an interval timer which
+	 * is prescaled by 32 using the interval interrupt. Leave it
+	 * disabled for now.
+	 */
+	writel_relaxed(0x23, ttcce->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
+	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
+		     ttcce->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+	writel_relaxed(0x1,  ttcce->ttc.base_addr + TTC_IER_OFFSET);
+
+	err = request_irq(irq, ttc_clock_event_interrupt,
+			  IRQF_TIMER, ttcce->ce.name, ttcce);
+	if (err)
+		goto out_kfree;
+
+	clockevents_config_and_register(&ttcce->ce,
+			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
+
+	return 0;
+
+out_kfree:
+	kfree(ttcce);
+	return err;
+}
+
+static int __init ttc_timer_probe(struct platform_device *pdev)
+{
+	unsigned int irq;
+	void __iomem *timer_baseaddr;
+	struct clk *clk_cs, *clk_ce;
+	static int initialized;
+	int clksel, ret;
+	u32 timer_width = 16;
+	struct device_node *timer = pdev->dev.of_node;
+
+	if (initialized)
+		return 0;
+
+	initialized = 1;
+
+	/*
+	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
+	 * and use it. Note that the event timer uses the interrupt and it's the
+	 * 2nd TTC hence the irq_of_parse_and_map(,1)
+	 */
+	timer_baseaddr = devm_of_iomap(&pdev->dev, timer, 0, NULL);
+	if (IS_ERR(timer_baseaddr)) {
+		pr_err("ERROR: invalid timer base address\n");
+		return PTR_ERR(timer_baseaddr);
+	}
+
+	irq = irq_of_parse_and_map(timer, 1);
+	if (irq <= 0) {
+		pr_err("ERROR: invalid interrupt number\n");
+		return -EINVAL;
+	}
+
+	of_property_read_u32(timer, "timer-width", &timer_width);
+
+	clksel = readl_relaxed(timer_baseaddr + TTC_CLK_CNTRL_OFFSET);
+	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
+	clk_cs = of_clk_get(timer, clksel);
+	if (IS_ERR(clk_cs)) {
+		pr_err("ERROR: timer input clock not found\n");
+		return PTR_ERR(clk_cs);
+	}
+
+	clksel = readl_relaxed(timer_baseaddr + 4 + TTC_CLK_CNTRL_OFFSET);
+	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
+	clk_ce = of_clk_get(timer, clksel);
+	if (IS_ERR(clk_ce)) {
+		pr_err("ERROR: timer input clock not found\n");
+		ret = PTR_ERR(clk_ce);
+		goto put_clk_cs;
+	}
+
+	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
+	if (ret)
+		goto put_clk_ce;
+
+	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
+	if (ret)
+		goto put_clk_ce;
+
+	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
+
+	return 0;
+
+put_clk_ce:
+	clk_put(clk_ce);
+put_clk_cs:
+	clk_put(clk_cs);
+	return ret;
+}
+
+static const struct of_device_id ttc_timer_of_match[] = {
+	{.compatible = "cdns,ttc"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
+
+static struct platform_driver ttc_timer_driver = {
+	.driver = {
+		.name	= "cdns_ttc_timer",
+		.of_match_table = ttc_timer_of_match,
+	},
+};
+builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
diff --git a/drivers/clocksource/timer-efm32.c b/drivers/clocksource/timer-efm32.c
new file mode 100644
index 000000000000..257e810ec1ad
--- /dev/null
+++ b/drivers/clocksource/timer-efm32.c
@@ -0,0 +1,287 @@
+/*
+ * Copyright (C) 2013 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+
+#define TIMERn_CTRL			0x00
+#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
+#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
+#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
+#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
+#define TIMERn_CTRL_OSMEN			0x00000010
+#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
+#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
+#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
+
+#define TIMERn_CMD			0x04
+#define TIMERn_CMD_START			0x00000001
+#define TIMERn_CMD_STOP				0x00000002
+
+#define TIMERn_IEN			0x0c
+#define TIMERn_IF			0x10
+#define TIMERn_IFS			0x14
+#define TIMERn_IFC			0x18
+#define TIMERn_IRQ_UF				0x00000002
+
+#define TIMERn_TOP			0x1c
+#define TIMERn_CNT			0x24
+
+struct efm32_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+	unsigned periodic_top;
+};
+
+static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	return 0;
+}
+
+static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_OSMEN |
+		       TIMERn_CTRL_MODE_DOWN,
+		       ddata->base + TIMERn_CTRL);
+	return 0;
+}
+
+static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_MODE_DOWN,
+		       ddata->base + TIMERn_CTRL);
+	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+	return 0;
+}
+
+static int efm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(evt, ddata->base + TIMERn_CNT);
+	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+
+	return 0;
+}
+
+static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
+{
+	struct efm32_clock_event_ddata *ddata = dev_id;
+
+	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
+
+	ddata->evtdev.event_handler(&ddata->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct efm32_clock_event_ddata clock_event_ddata = {
+	.evtdev = {
+		.name = "efm32 clockevent",
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+		.set_state_shutdown = efm32_clock_event_shutdown,
+		.set_state_periodic = efm32_clock_event_set_periodic,
+		.set_state_oneshot = efm32_clock_event_set_oneshot,
+		.set_next_event = efm32_clock_event_set_next_event,
+		.rating = 200,
+	},
+};
+
+static struct irqaction efm32_clock_event_irq = {
+	.name = "efm32 clockevent",
+	.flags = IRQF_TIMER,
+	.handler = efm32_clock_event_handler,
+	.dev_id = &clock_event_ddata,
+};
+
+static int __init efm32_clocksource_init(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("failed to get clock for clocksource (%d)\n", ret);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clocksource (%d)\n",
+		       ret);
+		goto err_clk_enable;
+	}
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		ret = -EADDRNOTAVAIL;
+		pr_err("failed to map registers for clocksource\n");
+		goto err_iomap;
+	}
+
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
+	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
+
+	ret = clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
+				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
+				    clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("failed to init clocksource (%d)\n", ret);
+		goto err_clocksource_init;
+	}
+
+	return 0;
+
+err_clocksource_init:
+
+	iounmap(base);
+err_iomap:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+err_clk_get:
+
+	return ret;
+}
+
+static int __init efm32_clockevent_init(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int irq;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("failed to get clock for clockevent (%d)\n", ret);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clockevent (%d)\n",
+		       ret);
+		goto err_clk_enable;
+	}
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		ret = -EADDRNOTAVAIL;
+		pr_err("failed to map registers for clockevent\n");
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		ret = -ENOENT;
+		pr_err("failed to get irq for clockevent\n");
+		goto err_get_irq;
+	}
+
+	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
+
+	clock_event_ddata.base = base;
+	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
+
+	clockevents_config_and_register(&clock_event_ddata.evtdev,
+					DIV_ROUND_CLOSEST(rate, 1024),
+					0xf, 0xffff);
+
+	ret = setup_irq(irq, &efm32_clock_event_irq);
+	if (ret) {
+		pr_err("Failed setup irq\n");
+		goto err_setup_irq;
+	}
+
+	return 0;
+
+err_setup_irq:
+err_get_irq:
+
+	iounmap(base);
+err_iomap:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+err_clk_get:
+
+	return ret;
+}
+
+/*
+ * This function asserts that we have exactly one clocksource and one
+ * clock_event_device in the end.
+ */
+static int __init efm32_timer_init(struct device_node *np)
+{
+	static int has_clocksource, has_clockevent;
+	int ret = 0;
+
+	if (!has_clocksource) {
+		ret = efm32_clocksource_init(np);
+		if (!ret) {
+			has_clocksource = 1;
+			return 0;
+		}
+	}
+
+	if (!has_clockevent) {
+		ret = efm32_clockevent_init(np);
+		if (!ret) {
+			has_clockevent = 1;
+			return 0;
+		}
+	}
+
+	return ret;
+}
+TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
+TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
new file mode 100644
index 000000000000..846d18daf893
--- /dev/null
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -0,0 +1,376 @@
+/*
+ * Freescale FlexTimer Module (FTM) timer driver.
+ *
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+#define FTM_SC		0x00
+#define FTM_SC_CLK_SHIFT	3
+#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
+#define FTM_SC_PS_MASK	0x7
+#define FTM_SC_TOIE	BIT(6)
+#define FTM_SC_TOF	BIT(7)
+
+#define FTM_CNT		0x04
+#define FTM_MOD		0x08
+#define FTM_CNTIN	0x4C
+
+#define FTM_PS_MAX	7
+
+struct ftm_clock_device {
+	void __iomem *clksrc_base;
+	void __iomem *clkevt_base;
+	unsigned long periodic_cyc;
+	unsigned long ps;
+	bool big_endian;
+};
+
+static struct ftm_clock_device *priv;
+
+static inline u32 ftm_readl(void __iomem *addr)
+{
+	if (priv->big_endian)
+		return ioread32be(addr);
+	else
+		return ioread32(addr);
+}
+
+static inline void ftm_writel(u32 val, void __iomem *addr)
+{
+	if (priv->big_endian)
+		iowrite32be(val, addr);
+	else
+		iowrite32(val, addr);
+}
+
+static inline void ftm_counter_enable(void __iomem *base)
+{
+	u32 val;
+
+	/* select and enable counter clock source */
+	val = ftm_readl(base + FTM_SC);
+	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
+	val |= priv->ps | FTM_SC_CLK(1);
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_counter_disable(void __iomem *base)
+{
+	u32 val;
+
+	/* disable counter clock source */
+	val = ftm_readl(base + FTM_SC);
+	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_irq_acknowledge(void __iomem *base)
+{
+	u32 val;
+
+	val = ftm_readl(base + FTM_SC);
+	val &= ~FTM_SC_TOF;
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_irq_enable(void __iomem *base)
+{
+	u32 val;
+
+	val = ftm_readl(base + FTM_SC);
+	val |= FTM_SC_TOIE;
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_irq_disable(void __iomem *base)
+{
+	u32 val;
+
+	val = ftm_readl(base + FTM_SC);
+	val &= ~FTM_SC_TOIE;
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_reset_counter(void __iomem *base)
+{
+	/*
+	 * The CNT register contains the FTM counter value.
+	 * Reset clears the CNT register. Writing any value to COUNT
+	 * updates the counter with its initial value, CNTIN.
+	 */
+	ftm_writel(0x00, base + FTM_CNT);
+}
+
+static u64 notrace ftm_read_sched_clock(void)
+{
+	return ftm_readl(priv->clksrc_base + FTM_CNT);
+}
+
+static int ftm_set_next_event(unsigned long delta,
+				struct clock_event_device *unused)
+{
+	/*
+	 * The CNNIN and MOD are all double buffer registers, writing
+	 * to the MOD register latches the value into a buffer. The MOD
+	 * register is updated with the value of its write buffer with
+	 * the following scenario:
+	 * a, the counter source clock is diabled.
+	 */
+	ftm_counter_disable(priv->clkevt_base);
+
+	/* Force the value of CNTIN to be loaded into the FTM counter */
+	ftm_reset_counter(priv->clkevt_base);
+
+	/*
+	 * The counter increments until the value of MOD is reached,
+	 * at which point the counter is reloaded with the value of CNTIN.
+	 * The TOF (the overflow flag) bit is set when the FTM counter
+	 * changes from MOD to CNTIN. So we should using the delta - 1.
+	 */
+	ftm_writel(delta - 1, priv->clkevt_base + FTM_MOD);
+
+	ftm_counter_enable(priv->clkevt_base);
+
+	ftm_irq_enable(priv->clkevt_base);
+
+	return 0;
+}
+
+static int ftm_set_oneshot(struct clock_event_device *evt)
+{
+	ftm_counter_disable(priv->clkevt_base);
+	return 0;
+}
+
+static int ftm_set_periodic(struct clock_event_device *evt)
+{
+	ftm_set_next_event(priv->periodic_cyc, evt);
+	return 0;
+}
+
+static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	ftm_irq_acknowledge(priv->clkevt_base);
+
+	if (likely(clockevent_state_oneshot(evt))) {
+		ftm_irq_disable(priv->clkevt_base);
+		ftm_counter_disable(priv->clkevt_base);
+	}
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device ftm_clockevent = {
+	.name			= "Freescale ftm timer",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_periodic	= ftm_set_periodic,
+	.set_state_oneshot	= ftm_set_oneshot,
+	.set_next_event		= ftm_set_next_event,
+	.rating			= 300,
+};
+
+static struct irqaction ftm_timer_irq = {
+	.name		= "Freescale ftm timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= ftm_evt_interrupt,
+	.dev_id		= &ftm_clockevent,
+};
+
+static int __init ftm_clockevent_init(unsigned long freq, int irq)
+{
+	int err;
+
+	ftm_writel(0x00, priv->clkevt_base + FTM_CNTIN);
+	ftm_writel(~0u, priv->clkevt_base + FTM_MOD);
+
+	ftm_reset_counter(priv->clkevt_base);
+
+	err = setup_irq(irq, &ftm_timer_irq);
+	if (err) {
+		pr_err("ftm: setup irq failed: %d\n", err);
+		return err;
+	}
+
+	ftm_clockevent.cpumask = cpumask_of(0);
+	ftm_clockevent.irq = irq;
+
+	clockevents_config_and_register(&ftm_clockevent,
+					freq / (1 << priv->ps),
+					1, 0xffff);
+
+	ftm_counter_enable(priv->clkevt_base);
+
+	return 0;
+}
+
+static int __init ftm_clocksource_init(unsigned long freq)
+{
+	int err;
+
+	ftm_writel(0x00, priv->clksrc_base + FTM_CNTIN);
+	ftm_writel(~0u, priv->clksrc_base + FTM_MOD);
+
+	ftm_reset_counter(priv->clksrc_base);
+
+	sched_clock_register(ftm_read_sched_clock, 16, freq / (1 << priv->ps));
+	err = clocksource_mmio_init(priv->clksrc_base + FTM_CNT, "fsl-ftm",
+				    freq / (1 << priv->ps), 300, 16,
+				    clocksource_mmio_readl_up);
+	if (err) {
+		pr_err("ftm: init clock source mmio failed: %d\n", err);
+		return err;
+	}
+
+	ftm_counter_enable(priv->clksrc_base);
+
+	return 0;
+}
+
+static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
+				 char *ftm_name)
+{
+	struct clk *clk;
+	int err;
+
+	clk = of_clk_get_by_name(np, cnt_name);
+	if (IS_ERR(clk)) {
+		pr_err("ftm: Cannot get \"%s\": %ld\n", cnt_name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+	err = clk_prepare_enable(clk);
+	if (err) {
+		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
+			cnt_name, err);
+		return err;
+	}
+
+	clk = of_clk_get_by_name(np, ftm_name);
+	if (IS_ERR(clk)) {
+		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+	err = clk_prepare_enable(clk);
+	if (err)
+		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
+			ftm_name, err);
+
+	return clk_get_rate(clk);
+}
+
+static unsigned long __init ftm_clk_init(struct device_node *np)
+{
+	long freq;
+
+	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
+	if (freq <= 0)
+		return 0;
+
+	freq = __ftm_clk_init(np, "ftm-src-counter-en", "ftm-src");
+	if (freq <= 0)
+		return 0;
+
+	return freq;
+}
+
+static int __init ftm_calc_closest_round_cyc(unsigned long freq)
+{
+	priv->ps = 0;
+
+	/* The counter register is only using the lower 16 bits, and
+	 * if the 'freq' value is to big here, then the periodic_cyc
+	 * may exceed 0xFFFF.
+	 */
+	do {
+		priv->periodic_cyc = DIV_ROUND_CLOSEST(freq,
+						HZ * (1 << priv->ps++));
+	} while (priv->periodic_cyc > 0xFFFF);
+
+	if (priv->ps > FTM_PS_MAX) {
+		pr_err("ftm: the prescaler is %lu > %d\n",
+				priv->ps, FTM_PS_MAX);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init ftm_timer_init(struct device_node *np)
+{
+	unsigned long freq;
+	int ret, irq;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = -ENXIO;
+	priv->clkevt_base = of_iomap(np, 0);
+	if (!priv->clkevt_base) {
+		pr_err("ftm: unable to map event timer registers\n");
+		goto err_clkevt;
+	}
+
+	priv->clksrc_base = of_iomap(np, 1);
+	if (!priv->clksrc_base) {
+		pr_err("ftm: unable to map source timer registers\n");
+		goto err_clksrc;
+	}
+
+	ret = -EINVAL;
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("ftm: unable to get IRQ from DT, %d\n", irq);
+		goto err;
+	}
+
+	priv->big_endian = of_property_read_bool(np, "big-endian");
+
+	freq = ftm_clk_init(np);
+	if (!freq)
+		goto err;
+
+	ret = ftm_calc_closest_round_cyc(freq);
+	if (ret)
+		goto err;
+
+	ret = ftm_clocksource_init(freq);
+	if (ret)
+		goto err;
+
+	ret = ftm_clockevent_init(freq, irq);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	iounmap(priv->clksrc_base);
+err_clksrc:
+	iounmap(priv->clkevt_base);
+err_clkevt:
+	kfree(priv);
+	return ret;
+}
+TIMER_OF_DECLARE(flextimer, "fsl,ftm-timer", ftm_timer_init);
diff --git a/drivers/clocksource/timer-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
new file mode 100644
index 000000000000..d51a62a79ef7
--- /dev/null
+++ b/drivers/clocksource/timer-lpc32xx.c
@@ -0,0 +1,314 @@
+/*
+ * Clocksource driver for NXP LPC32xx/18xx/43xx timer
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Based on:
+ * time-efm32 Copyright (C) 2013 Pengutronix
+ * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#define LPC32XX_TIMER_IR		0x000
+#define  LPC32XX_TIMER_IR_MR0INT	BIT(0)
+#define LPC32XX_TIMER_TCR		0x004
+#define  LPC32XX_TIMER_TCR_CEN		BIT(0)
+#define  LPC32XX_TIMER_TCR_CRST		BIT(1)
+#define LPC32XX_TIMER_TC		0x008
+#define LPC32XX_TIMER_PR		0x00c
+#define LPC32XX_TIMER_MCR		0x014
+#define  LPC32XX_TIMER_MCR_MR0I		BIT(0)
+#define  LPC32XX_TIMER_MCR_MR0R		BIT(1)
+#define  LPC32XX_TIMER_MCR_MR0S		BIT(2)
+#define LPC32XX_TIMER_MR0		0x018
+#define LPC32XX_TIMER_CTCR		0x070
+
+struct lpc32xx_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+	u32 ticks_per_jiffy;
+};
+
+/* Needed for the sched clock */
+static void __iomem *clocksource_timer_counter;
+
+static u64 notrace lpc32xx_read_sched_clock(void)
+{
+	return readl(clocksource_timer_counter);
+}
+
+static unsigned long lpc32xx_delay_timer_read(void)
+{
+	return readl(clocksource_timer_counter);
+}
+
+static struct delay_timer lpc32xx_delay_timer = {
+	.read_current_timer = lpc32xx_delay_timer_read,
+};
+
+static int lpc32xx_clkevt_next_event(unsigned long delta,
+				     struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/*
+	 * Place timer in reset and program the delta in the match
+	 * channel 0 (MR0). When the timer counter matches the value
+	 * in MR0 register the match will trigger an interrupt.
+	 * After setup the timer is released from reset and enabled.
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
+	writel_relaxed(delta, ddata->base + LPC32XX_TIMER_MR0);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static int lpc32xx_clkevt_shutdown(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/* Disable the timer */
+	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static int lpc32xx_clkevt_oneshot(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/*
+	 * When using oneshot, we must also disable the timer
+	 * to wait for the first call to set_next_event().
+	 */
+	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
+
+	/* Enable interrupt, reset on match and stop on match (MCR). */
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
+		       LPC32XX_TIMER_MCR_MR0S, ddata->base + LPC32XX_TIMER_MCR);
+	return 0;
+}
+
+static int lpc32xx_clkevt_periodic(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/* Enable interrupt and reset on match. */
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R,
+		       ddata->base + LPC32XX_TIMER_MCR);
+
+	/*
+	 * Place timer in reset and program the delta in the match
+	 * channel 0 (MR0).
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
+	writel_relaxed(ddata->ticks_per_jiffy, ddata->base + LPC32XX_TIMER_MR0);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
+{
+	struct lpc32xx_clock_event_ddata *ddata = dev_id;
+
+	/* Clear match on channel 0 */
+	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, ddata->base + LPC32XX_TIMER_IR);
+
+	ddata->evtdev.event_handler(&ddata->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
+	.evtdev = {
+		.name			= "lpc3220 clockevent",
+		.features		= CLOCK_EVT_FEAT_ONESHOT |
+					  CLOCK_EVT_FEAT_PERIODIC,
+		.rating			= 300,
+		.set_next_event		= lpc32xx_clkevt_next_event,
+		.set_state_shutdown	= lpc32xx_clkevt_shutdown,
+		.set_state_oneshot	= lpc32xx_clkevt_oneshot,
+		.set_state_periodic	= lpc32xx_clkevt_periodic,
+	},
+};
+
+static int __init lpc32xx_clocksource_init(struct device_node *np)
+{
+	void __iomem *base;
+	unsigned long rate;
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get_by_name(np, "timerclk");
+	if (IS_ERR(clk)) {
+		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("clock enable failed (%d)\n", ret);
+		goto err_clk_enable;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("unable to map registers\n");
+		ret = -EADDRNOTAVAIL;
+		goto err_iomap;
+	}
+
+	/*
+	 * Disable and reset timer then set it to free running timer
+	 * mode (CTCR) with no prescaler (PR) or match operations (MCR).
+	 * After setup the timer is released from reset and enabled.
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, base + LPC32XX_TIMER_TCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_PR);
+	writel_relaxed(0, base + LPC32XX_TIMER_MCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, base + LPC32XX_TIMER_TCR);
+
+	rate = clk_get_rate(clk);
+	ret = clocksource_mmio_init(base + LPC32XX_TIMER_TC, "lpc3220 timer",
+				    rate, 300, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("failed to init clocksource (%d)\n", ret);
+		goto err_clocksource_init;
+	}
+
+	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
+	lpc32xx_delay_timer.freq = rate;
+	register_current_timer_delay(&lpc32xx_delay_timer);
+	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
+
+	return 0;
+
+err_clocksource_init:
+	iounmap(base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+	return ret;
+}
+
+static int __init lpc32xx_clockevent_init(struct device_node *np)
+{
+	void __iomem *base;
+	unsigned long rate;
+	struct clk *clk;
+	int ret, irq;
+
+	clk = of_clk_get_by_name(np, "timerclk");
+	if (IS_ERR(clk)) {
+		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("clock enable failed (%d)\n", ret);
+		goto err_clk_enable;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("unable to map registers\n");
+		ret = -EADDRNOTAVAIL;
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("get irq failed\n");
+		ret = -ENOENT;
+		goto err_irq;
+	}
+
+	/*
+	 * Disable timer and clear any pending interrupt (IR) on match
+	 * channel 0 (MR0). Clear the prescaler as it's not used.
+	 */
+	writel_relaxed(0, base + LPC32XX_TIMER_TCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_PR);
+	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
+	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
+
+	rate = clk_get_rate(clk);
+	lpc32xx_clk_event_ddata.base = base;
+	lpc32xx_clk_event_ddata.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
+	clockevents_config_and_register(&lpc32xx_clk_event_ddata.evtdev,
+					rate, 1, -1);
+
+	ret = request_irq(irq, lpc32xx_clock_event_handler,
+			  IRQF_TIMER | IRQF_IRQPOLL, "lpc3220 clockevent",
+			  &lpc32xx_clk_event_ddata);
+	if (ret) {
+		pr_err("request irq failed\n");
+		goto err_irq;
+	}
+
+	return 0;
+
+err_irq:
+	iounmap(base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+	return ret;
+}
+
+/*
+ * This function asserts that we have exactly one clocksource and one
+ * clock_event_device in the end.
+ */
+static int __init lpc32xx_timer_init(struct device_node *np)
+{
+	static int has_clocksource, has_clockevent;
+	int ret = 0;
+
+	if (!has_clocksource) {
+		ret = lpc32xx_clocksource_init(np);
+		if (!ret) {
+			has_clocksource = 1;
+			return 0;
+		}
+	}
+
+	if (!has_clockevent) {
+		ret = lpc32xx_clockevent_init(np);
+		if (!ret) {
+			has_clockevent = 1;
+			return 0;
+		}
+	}
+
+	return ret;
+}
+TIMER_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
new file mode 100644
index 000000000000..12202067fe4b
--- /dev/null
+++ b/drivers/clocksource/timer-orion.c
@@ -0,0 +1,192 @@
+/*
+ * Marvell Orion SoC timer handling.
+ *
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+#include <linux/sched_clock.h>
+
+#define TIMER_CTRL		0x00
+#define  TIMER0_EN		BIT(0)
+#define  TIMER0_RELOAD_EN	BIT(1)
+#define  TIMER1_EN		BIT(2)
+#define  TIMER1_RELOAD_EN	BIT(3)
+#define TIMER0_RELOAD		0x10
+#define TIMER0_VAL		0x14
+#define TIMER1_RELOAD		0x18
+#define TIMER1_VAL		0x1c
+
+#define ORION_ONESHOT_MIN	1
+#define ORION_ONESHOT_MAX	0xfffffffe
+
+static void __iomem *timer_base;
+
+static unsigned long notrace orion_read_timer(void)
+{
+	return ~readl(timer_base + TIMER0_VAL);
+}
+
+static struct delay_timer orion_delay_timer = {
+	.read_current_timer = orion_read_timer,
+};
+
+static void orion_delay_timer_init(unsigned long rate)
+{
+	orion_delay_timer.freq = rate;
+	register_current_timer_delay(&orion_delay_timer);
+}
+
+/*
+ * Free-running clocksource handling.
+ */
+static u64 notrace orion_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL);
+}
+
+/*
+ * Clockevent handling.
+ */
+static u32 ticks_per_jiffy;
+
+static int orion_clkevt_next_event(unsigned long delta,
+				   struct clock_event_device *dev)
+{
+	/* setup and enable one-shot timer */
+	writel(delta, timer_base + TIMER1_VAL);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
+
+	return 0;
+}
+
+static int orion_clkevt_shutdown(struct clock_event_device *dev)
+{
+	/* disable timer */
+	atomic_io_modify(timer_base + TIMER_CTRL,
+			 TIMER1_RELOAD_EN | TIMER1_EN, 0);
+	return 0;
+}
+
+static int orion_clkevt_set_periodic(struct clock_event_device *dev)
+{
+	/* setup and enable periodic timer at 1/HZ intervals */
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+			 TIMER1_RELOAD_EN | TIMER1_EN,
+			 TIMER1_RELOAD_EN | TIMER1_EN);
+	return 0;
+}
+
+static struct clock_event_device orion_clkevt = {
+	.name			= "orion_event",
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC,
+	.shift			= 32,
+	.rating			= 300,
+	.set_next_event		= orion_clkevt_next_event,
+	.set_state_shutdown	= orion_clkevt_shutdown,
+	.set_state_periodic	= orion_clkevt_set_periodic,
+	.set_state_oneshot	= orion_clkevt_shutdown,
+	.tick_resume		= orion_clkevt_shutdown,
+};
+
+static irqreturn_t orion_clkevt_irq_handler(int irq, void *dev_id)
+{
+	orion_clkevt.event_handler(&orion_clkevt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction orion_clkevt_irq = {
+	.name		= "orion_event",
+	.flags		= IRQF_TIMER,
+	.handler	= orion_clkevt_irq_handler,
+};
+
+static int __init orion_timer_init(struct device_node *np)
+{
+	unsigned long rate;
+	struct clk *clk;
+	int irq, ret;
+
+	/* timer registers are shared with watchdog timer */
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("%s: unable to map resource\n", np->name);
+		return -ENXIO;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%s: unable to get clk\n", np->name);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to prepare clock\n");
+		return ret;
+	}
+
+	/* we are only interested in timer1 irq */
+	irq = irq_of_parse_and_map(np, 1);
+	if (irq <= 0) {
+		pr_err("%s: unable to parse timer1 irq\n", np->name);
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(clk);
+
+	/* setup timer0 as free-running clocksource */
+	writel(~0, timer_base + TIMER0_VAL);
+	writel(~0, timer_base + TIMER0_RELOAD);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER0_RELOAD_EN | TIMER0_EN,
+		TIMER0_RELOAD_EN | TIMER0_EN);
+
+	ret = clocksource_mmio_init(timer_base + TIMER0_VAL,
+				    "orion_clocksource", rate, 300, 32,
+				    clocksource_mmio_readl_down);
+	if (ret) {
+		pr_err("Failed to initialize mmio timer\n");
+		return ret;
+	}
+
+	sched_clock_register(orion_read_sched_clock, 32, rate);
+
+	/* setup timer1 as clockevent timer */
+	ret = setup_irq(irq, &orion_clkevt_irq);
+	if (ret) {
+		pr_err("%s: unable to setup irq\n", np->name);
+		return ret;
+	}
+
+	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
+	orion_clkevt.cpumask = cpumask_of(0);
+	orion_clkevt.irq = irq;
+	clockevents_config_and_register(&orion_clkevt, rate,
+					ORION_ONESHOT_MIN, ORION_ONESHOT_MAX);
+
+
+	orion_delay_timer_init(rate);
+
+	return 0;
+}
+TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
new file mode 100644
index 000000000000..ea00a5e8f95d
--- /dev/null
+++ b/drivers/clocksource/timer-owl.c
@@ -0,0 +1,173 @@
+/*
+ * Actions Semi Owl timer
+ *
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2017 SUSE Linux GmbH
+ * Author: Andreas Färber
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define OWL_Tx_CTL		0x0
+#define OWL_Tx_CMP		0x4
+#define OWL_Tx_VAL		0x8
+
+#define OWL_Tx_CTL_PD		BIT(0)
+#define OWL_Tx_CTL_INTEN	BIT(1)
+#define OWL_Tx_CTL_EN		BIT(2)
+
+static void __iomem *owl_timer_base;
+static void __iomem *owl_clksrc_base;
+static void __iomem *owl_clkevt_base;
+
+static inline void owl_timer_reset(void __iomem *base)
+{
+	writel(0, base + OWL_Tx_CTL);
+	writel(0, base + OWL_Tx_VAL);
+	writel(0, base + OWL_Tx_CMP);
+}
+
+static inline void owl_timer_set_enabled(void __iomem *base, bool enabled)
+{
+	u32 ctl = readl(base + OWL_Tx_CTL);
+
+	/* PD bit is cleared when set */
+	ctl &= ~OWL_Tx_CTL_PD;
+
+	if (enabled)
+		ctl |= OWL_Tx_CTL_EN;
+	else
+		ctl &= ~OWL_Tx_CTL_EN;
+
+	writel(ctl, base + OWL_Tx_CTL);
+}
+
+static u64 notrace owl_timer_sched_read(void)
+{
+	return (u64)readl(owl_clksrc_base + OWL_Tx_VAL);
+}
+
+static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
+{
+	owl_timer_set_enabled(owl_clkevt_base, false);
+
+	return 0;
+}
+
+static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
+{
+	owl_timer_reset(owl_clkevt_base);
+
+	return 0;
+}
+
+static int owl_timer_tick_resume(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int owl_timer_set_next_event(unsigned long evt,
+				    struct clock_event_device *ev)
+{
+	void __iomem *base = owl_clkevt_base;
+
+	owl_timer_set_enabled(base, false);
+	writel(OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
+	writel(0, base + OWL_Tx_VAL);
+	writel(evt, base + OWL_Tx_CMP);
+	owl_timer_set_enabled(base, true);
+
+	return 0;
+}
+
+static struct clock_event_device owl_clockevent = {
+	.name			= "owl_tick",
+	.rating			= 200,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_DYNIRQ,
+	.set_state_shutdown	= owl_timer_set_state_shutdown,
+	.set_state_oneshot	= owl_timer_set_state_oneshot,
+	.tick_resume		= owl_timer_tick_resume,
+	.set_next_event		= owl_timer_set_next_event,
+};
+
+static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+
+	writel(OWL_Tx_CTL_PD, owl_clkevt_base + OWL_Tx_CTL);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init owl_timer_init(struct device_node *node)
+{
+	struct clk *clk;
+	unsigned long rate;
+	int timer1_irq, ret;
+
+	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
+	if (IS_ERR(owl_timer_base)) {
+		pr_err("Can't map timer registers\n");
+		return PTR_ERR(owl_timer_base);
+	}
+
+	owl_clksrc_base = owl_timer_base + 0x08;
+	owl_clkevt_base = owl_timer_base + 0x14;
+
+	timer1_irq = of_irq_get_byname(node, "timer1");
+	if (timer1_irq <= 0) {
+		pr_err("Can't parse timer1 IRQ\n");
+		return -EINVAL;
+	}
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rate = clk_get_rate(clk);
+
+	owl_timer_reset(owl_clksrc_base);
+	owl_timer_set_enabled(owl_clksrc_base, true);
+
+	sched_clock_register(owl_timer_sched_read, 32, rate);
+	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+			      rate, 200, 32, clocksource_mmio_readl_up);
+
+	owl_timer_reset(owl_clkevt_base);
+
+	ret = request_irq(timer1_irq, owl_timer1_interrupt, IRQF_TIMER,
+			  "owl-timer", &owl_clockevent);
+	if (ret) {
+		pr_err("failed to request irq %d\n", timer1_irq);
+		return ret;
+	}
+
+	owl_clockevent.cpumask = cpumask_of(0);
+	owl_clockevent.irq = timer1_irq;
+
+	clockevents_config_and_register(&owl_clockevent, rate,
+					0xf, 0xffffffff);
+
+	return 0;
+}
+TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
new file mode 100644
index 000000000000..a2dd85d0c1d7
--- /dev/null
+++ b/drivers/clocksource/timer-pistachio.c
@@ -0,0 +1,218 @@
+/*
+ * Pistachio clocksource based on general-purpose timers
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+#include <linux/time.h>
+
+/* Top level reg */
+#define CR_TIMER_CTRL_CFG		0x00
+#define TIMER_ME_GLOBAL			BIT(0)
+#define CR_TIMER_REV			0x10
+
+/* Timer specific registers */
+#define TIMER_CFG			0x20
+#define TIMER_ME_LOCAL			BIT(0)
+#define TIMER_RELOAD_VALUE		0x24
+#define TIMER_CURRENT_VALUE		0x28
+#define TIMER_CURRENT_OVERFLOW_VALUE	0x2C
+#define TIMER_IRQ_STATUS		0x30
+#define TIMER_IRQ_CLEAR			0x34
+#define TIMER_IRQ_MASK			0x38
+
+#define PERIP_TIMER_CONTROL		0x90
+
+/* Timer specific configuration Values */
+#define RELOAD_VALUE			0xffffffff
+
+struct pistachio_clocksource {
+	void __iomem *base;
+	raw_spinlock_t lock;
+	struct clocksource cs;
+};
+
+static struct pistachio_clocksource pcs_gpt;
+
+#define to_pistachio_clocksource(cs)	\
+	container_of(cs, struct pistachio_clocksource, cs)
+
+static inline u32 gpt_readl(void __iomem *base, u32 offset, u32 gpt_id)
+{
+	return readl(base + 0x20 * gpt_id + offset);
+}
+
+static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
+		u32 gpt_id)
+{
+	writel(value, base + 0x20 * gpt_id + offset);
+}
+
+static u64 notrace
+pistachio_clocksource_read_cycles(struct clocksource *cs)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+	u32 counter, overflw;
+	unsigned long flags;
+
+	/*
+	 * The counter value is only refreshed after the overflow value is read.
+	 * And they must be read in strict order, hence raw spin lock added.
+	 */
+
+	raw_spin_lock_irqsave(&pcs->lock, flags);
+	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
+	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
+	raw_spin_unlock_irqrestore(&pcs->lock, flags);
+
+	return (u64)~counter;
+}
+
+static u64 notrace pistachio_read_sched_clock(void)
+{
+	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);
+}
+
+static void pistachio_clksrc_set_mode(struct clocksource *cs, int timeridx,
+			int enable)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+	u32 val;
+
+	val = gpt_readl(pcs->base, TIMER_CFG, timeridx);
+	if (enable)
+		val |= TIMER_ME_LOCAL;
+	else
+		val &= ~TIMER_ME_LOCAL;
+
+	gpt_writel(pcs->base, val, TIMER_CFG, timeridx);
+}
+
+static void pistachio_clksrc_enable(struct clocksource *cs, int timeridx)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+
+	/* Disable GPT local before loading reload value */
+	pistachio_clksrc_set_mode(cs, timeridx, false);
+	gpt_writel(pcs->base, RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
+	pistachio_clksrc_set_mode(cs, timeridx, true);
+}
+
+static void pistachio_clksrc_disable(struct clocksource *cs, int timeridx)
+{
+	/* Disable GPT local */
+	pistachio_clksrc_set_mode(cs, timeridx, false);
+}
+
+static int pistachio_clocksource_enable(struct clocksource *cs)
+{
+	pistachio_clksrc_enable(cs, 0);
+	return 0;
+}
+
+static void pistachio_clocksource_disable(struct clocksource *cs)
+{
+	pistachio_clksrc_disable(cs, 0);
+}
+
+/* Desirable clock source for pistachio platform */
+static struct pistachio_clocksource pcs_gpt = {
+	.cs =	{
+		.name		= "gptimer",
+		.rating		= 300,
+		.enable		= pistachio_clocksource_enable,
+		.disable	= pistachio_clocksource_disable,
+		.read		= pistachio_clocksource_read_cycles,
+		.mask		= CLOCKSOURCE_MASK(32),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
+				  CLOCK_SOURCE_SUSPEND_NONSTOP,
+		},
+};
+
+static int __init pistachio_clksrc_of_init(struct device_node *node)
+{
+	struct clk *sys_clk, *fast_clk;
+	struct regmap *periph_regs;
+	unsigned long rate;
+	int ret;
+
+	pcs_gpt.base = of_iomap(node, 0);
+	if (!pcs_gpt.base) {
+		pr_err("cannot iomap\n");
+		return -ENXIO;
+	}
+
+	periph_regs = syscon_regmap_lookup_by_phandle(node, "img,cr-periph");
+	if (IS_ERR(periph_regs)) {
+		pr_err("cannot get peripheral regmap (%ld)\n",
+		       PTR_ERR(periph_regs));
+		return PTR_ERR(periph_regs);
+	}
+
+	/* Switch to using the fast counter clock */
+	ret = regmap_update_bits(periph_regs, PERIP_TIMER_CONTROL,
+				 0xf, 0x0);
+	if (ret)
+		return ret;
+
+	sys_clk = of_clk_get_by_name(node, "sys");
+	if (IS_ERR(sys_clk)) {
+		pr_err("clock get failed (%ld)\n", PTR_ERR(sys_clk));
+		return PTR_ERR(sys_clk);
+	}
+
+	fast_clk = of_clk_get_by_name(node, "fast");
+	if (IS_ERR(fast_clk)) {
+		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
+		return PTR_ERR(fast_clk);
+	}
+
+	ret = clk_prepare_enable(sys_clk);
+	if (ret < 0) {
+		pr_err("failed to enable clock (%d)\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(fast_clk);
+	if (ret < 0) {
+		pr_err("failed to enable clock (%d)\n", ret);
+		clk_disable_unprepare(sys_clk);
+		return ret;
+	}
+
+	rate = clk_get_rate(fast_clk);
+
+	/* Disable irq's for clocksource usage */
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
+
+	/* Enable timer block */
+	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
+
+	raw_spin_lock_init(&pcs_gpt.lock);
+	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	return clocksource_register_hz(&pcs_gpt.cs, rate);
+}
+TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
+		       pistachio_clksrc_of_init);
diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
new file mode 100644
index 000000000000..89816f89ff3f
--- /dev/null
+++ b/drivers/clocksource/timer-qcom.c
@@ -0,0 +1,258 @@
+/*
+ *
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2009-2012,2014, The Linux Foundation. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <asm/delay.h>
+
+#define TIMER_MATCH_VAL			0x0000
+#define TIMER_COUNT_VAL			0x0004
+#define TIMER_ENABLE			0x0008
+#define TIMER_ENABLE_CLR_ON_MATCH_EN	BIT(1)
+#define TIMER_ENABLE_EN			BIT(0)
+#define TIMER_CLEAR			0x000C
+#define DGT_CLK_CTL			0x10
+#define DGT_CLK_CTL_DIV_4		0x3
+#define TIMER_STS_GPT0_CLR_PEND		BIT(10)
+
+#define GPT_HZ 32768
+
+static void __iomem *event_base;
+static void __iomem *sts_base;
+
+static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	/* Stop the timer tick */
+	if (clockevent_state_oneshot(evt)) {
+		u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
+		ctrl &= ~TIMER_ENABLE_EN;
+		writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+	}
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static int msm_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
+
+	ctrl &= ~TIMER_ENABLE_EN;
+	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+
+	writel_relaxed(ctrl, event_base + TIMER_CLEAR);
+	writel_relaxed(cycles, event_base + TIMER_MATCH_VAL);
+
+	if (sts_base)
+		while (readl_relaxed(sts_base) & TIMER_STS_GPT0_CLR_PEND)
+			cpu_relax();
+
+	writel_relaxed(ctrl | TIMER_ENABLE_EN, event_base + TIMER_ENABLE);
+	return 0;
+}
+
+static int msm_timer_shutdown(struct clock_event_device *evt)
+{
+	u32 ctrl;
+
+	ctrl = readl_relaxed(event_base + TIMER_ENABLE);
+	ctrl &= ~(TIMER_ENABLE_EN | TIMER_ENABLE_CLR_ON_MATCH_EN);
+	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+	return 0;
+}
+
+static struct clock_event_device __percpu *msm_evt;
+
+static void __iomem *source_base;
+
+static notrace u64 msm_read_timer_count(struct clocksource *cs)
+{
+	return readl_relaxed(source_base + TIMER_COUNT_VAL);
+}
+
+static struct clocksource msm_clocksource = {
+	.name	= "dg_timer",
+	.rating	= 300,
+	.read	= msm_read_timer_count,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int msm_timer_irq;
+static int msm_timer_has_ppi;
+
+static int msm_local_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
+	int err;
+
+	evt->irq = msm_timer_irq;
+	evt->name = "msm_timer";
+	evt->features = CLOCK_EVT_FEAT_ONESHOT;
+	evt->rating = 200;
+	evt->set_state_shutdown = msm_timer_shutdown;
+	evt->set_state_oneshot = msm_timer_shutdown;
+	evt->tick_resume = msm_timer_shutdown;
+	evt->set_next_event = msm_timer_set_next_event;
+	evt->cpumask = cpumask_of(cpu);
+
+	clockevents_config_and_register(evt, GPT_HZ, 4, 0xffffffff);
+
+	if (msm_timer_has_ppi) {
+		enable_percpu_irq(evt->irq, IRQ_TYPE_EDGE_RISING);
+	} else {
+		err = request_irq(evt->irq, msm_timer_interrupt,
+				IRQF_TIMER | IRQF_NOBALANCING |
+				IRQF_TRIGGER_RISING, "gp_timer", evt);
+		if (err)
+			pr_err("request_irq failed\n");
+	}
+
+	return 0;
+}
+
+static int msm_local_timer_dying_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
+
+	evt->set_state_shutdown(evt);
+	disable_percpu_irq(evt->irq);
+	return 0;
+}
+
+static u64 notrace msm_sched_clock_read(void)
+{
+	return msm_clocksource.read(&msm_clocksource);
+}
+
+static unsigned long msm_read_current_timer(void)
+{
+	return msm_clocksource.read(&msm_clocksource);
+}
+
+static struct delay_timer msm_delay_timer = {
+	.read_current_timer = msm_read_current_timer,
+};
+
+static int __init msm_timer_init(u32 dgt_hz, int sched_bits, int irq,
+				  bool percpu)
+{
+	struct clocksource *cs = &msm_clocksource;
+	int res = 0;
+
+	msm_timer_irq = irq;
+	msm_timer_has_ppi = percpu;
+
+	msm_evt = alloc_percpu(struct clock_event_device);
+	if (!msm_evt) {
+		pr_err("memory allocation failed for clockevents\n");
+		goto err;
+	}
+
+	if (percpu)
+		res = request_percpu_irq(irq, msm_timer_interrupt,
+					 "gp_timer", msm_evt);
+
+	if (res) {
+		pr_err("request_percpu_irq failed\n");
+	} else {
+		/* Install and invoke hotplug callbacks */
+		res = cpuhp_setup_state(CPUHP_AP_QCOM_TIMER_STARTING,
+					"clockevents/qcom/timer:starting",
+					msm_local_timer_starting_cpu,
+					msm_local_timer_dying_cpu);
+		if (res) {
+			free_percpu_irq(irq, msm_evt);
+			goto err;
+		}
+	}
+
+err:
+	writel_relaxed(TIMER_ENABLE_EN, source_base + TIMER_ENABLE);
+	res = clocksource_register_hz(cs, dgt_hz);
+	if (res)
+		pr_err("clocksource_register failed\n");
+	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz);
+	msm_delay_timer.freq = dgt_hz;
+	register_current_timer_delay(&msm_delay_timer);
+
+	return res;
+}
+
+static int __init msm_dt_timer_init(struct device_node *np)
+{
+	u32 freq;
+	int irq, ret;
+	struct resource res;
+	u32 percpu_offset;
+	void __iomem *base;
+	void __iomem *cpu0_base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("Failed to map event base\n");
+		return -ENXIO;
+	}
+
+	/* We use GPT0 for the clockevent */
+	irq = irq_of_parse_and_map(np, 1);
+	if (irq <= 0) {
+		pr_err("Can't get irq\n");
+		return -EINVAL;
+	}
+
+	/* We use CPU0's DGT for the clocksource */
+	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
+		percpu_offset = 0;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		pr_err("Failed to parse DGT resource\n");
+		return ret;
+	}
+
+	cpu0_base = ioremap(res.start + percpu_offset, resource_size(&res));
+	if (!cpu0_base) {
+		pr_err("Failed to map source base\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(np, "clock-frequency", &freq)) {
+		pr_err("Unknown frequency\n");
+		return -EINVAL;
+	}
+
+	event_base = base + 0x4;
+	sts_base = base + 0x88;
+	source_base = cpu0_base + 0x24;
+	freq /= 4;
+	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
+
+	return msm_timer_init(freq, 32, irq, !!percpu_offset);
+}
+TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
+TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/clocksource/timer-versatile.c b/drivers/clocksource/timer-versatile.c
new file mode 100644
index 000000000000..39725d38aede
--- /dev/null
+++ b/drivers/clocksource/timer-versatile.c
@@ -0,0 +1,44 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2014 ARM Limited
+ */
+
+#include <linux/clocksource.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/sched_clock.h>
+
+#define SYS_24MHZ 0x05c
+
+static void __iomem *versatile_sys_24mhz;
+
+static u64 notrace versatile_sys_24mhz_read(void)
+{
+	return readl(versatile_sys_24mhz);
+}
+
+static int __init versatile_sched_clock_init(struct device_node *node)
+{
+	void __iomem *base = of_iomap(node, 0);
+
+	if (!base)
+		return -ENXIO;
+
+	versatile_sys_24mhz = base + SYS_24MHZ;
+
+	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
+
+	return 0;
+}
+TIMER_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
+		       versatile_sched_clock_init);
+TIMER_OF_DECLARE(versatile, "arm,versatile-sysreg",
+		       versatile_sched_clock_init);
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
new file mode 100644
index 000000000000..0f92089ec08c
--- /dev/null
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+/*
+ * Each pit takes 0x10 Bytes register space
+ */
+#define PITMCR		0x00
+#define PIT0_OFFSET	0x100
+#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
+#define PITLDVAL	0x00
+#define PITCVAL		0x04
+#define PITTCTRL	0x08
+#define PITTFLG		0x0c
+
+#define PITMCR_MDIS	(0x1 << 1)
+
+#define PITTCTRL_TEN	(0x1 << 0)
+#define PITTCTRL_TIE	(0x1 << 1)
+#define PITCTRL_CHN	(0x1 << 2)
+
+#define PITTFLG_TIF	0x1
+
+static void __iomem *clksrc_base;
+static void __iomem *clkevt_base;
+static unsigned long cycle_per_jiffy;
+
+static inline void pit_timer_enable(void)
+{
+	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_timer_disable(void)
+{
+	__raw_writel(0, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_irq_acknowledge(void)
+{
+	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+}
+
+static u64 notrace pit_read_sched_clock(void)
+{
+	return ~__raw_readl(clksrc_base + PITCVAL);
+}
+
+static int __init pit_clocksource_init(unsigned long rate)
+{
+	/* set the max load value and start the clock source counter */
+	__raw_writel(0, clksrc_base + PITTCTRL);
+	__raw_writel(~0UL, clksrc_base + PITLDVAL);
+	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+
+	sched_clock_register(pit_read_sched_clock, 32, rate);
+	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
+			300, 32, clocksource_mmio_readl_down);
+}
+
+static int pit_set_next_event(unsigned long delta,
+				struct clock_event_device *unused)
+{
+	/*
+	 * set a new value to PITLDVAL register will not restart the timer,
+	 * to abort the current cycle and start a timer period with the new
+	 * value, the timer must be disabled and enabled again.
+	 * and the PITLAVAL should be set to delta minus one according to pit
+	 * hardware requirement.
+	 */
+	pit_timer_disable();
+	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
+	pit_timer_enable();
+
+	return 0;
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	pit_timer_disable();
+	return 0;
+}
+
+static int pit_set_periodic(struct clock_event_device *evt)
+{
+	pit_set_next_event(cycle_per_jiffy, evt);
+	return 0;
+}
+
+static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	pit_irq_acknowledge();
+
+	/*
+	 * pit hardware doesn't support oneshot, it will generate an interrupt
+	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
+	 * and start the counter again. So software need to disable the timer
+	 * to stop the counter loop in ONESHOT mode.
+	 */
+	if (likely(clockevent_state_oneshot(evt)))
+		pit_timer_disable();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device clockevent_pit = {
+	.name		= "VF pit timer",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown = pit_shutdown,
+	.set_state_periodic = pit_set_periodic,
+	.set_next_event	= pit_set_next_event,
+	.rating		= 300,
+};
+
+static struct irqaction pit_timer_irq = {
+	.name		= "VF pit timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= pit_timer_interrupt,
+	.dev_id		= &clockevent_pit,
+};
+
+static int __init pit_clockevent_init(unsigned long rate, int irq)
+{
+	__raw_writel(0, clkevt_base + PITTCTRL);
+	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+
+	BUG_ON(setup_irq(irq, &pit_timer_irq));
+
+	clockevent_pit.cpumask = cpumask_of(0);
+	clockevent_pit.irq = irq;
+	/*
+	 * The value for the LDVAL register trigger is calculated as:
+	 * LDVAL trigger = (period / clock period) - 1
+	 * The pit is a 32-bit down count timer, when the conter value
+	 * reaches 0, it will generate an interrupt, thus the minimal
+	 * LDVAL trigger value is 1. And then the min_delta is
+	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
+	 */
+	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
+
+	return 0;
+}
+
+static int __init pit_timer_init(struct device_node *np)
+{
+	struct clk *pit_clk;
+	void __iomem *timer_base;
+	unsigned long clk_rate;
+	int irq, ret;
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("Failed to iomap\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
+	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
+	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
+	 */
+	clksrc_base = timer_base + PITn_OFFSET(2);
+	clkevt_base = timer_base + PITn_OFFSET(3);
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0)
+		return -EINVAL;
+
+	pit_clk = of_clk_get(np, 0);
+	if (IS_ERR(pit_clk))
+		return PTR_ERR(pit_clk);
+
+	ret = clk_prepare_enable(pit_clk);
+	if (ret)
+		return ret;
+
+	clk_rate = clk_get_rate(pit_clk);
+	cycle_per_jiffy = clk_rate / (HZ);
+
+	/* enable the pit module */
+	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
+
+	ret = pit_clocksource_init(clk_rate);
+	if (ret)
+		return ret;
+
+	return pit_clockevent_init(clk_rate, irq);
+}
+TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
new file mode 100644
index 000000000000..e0f7489cfc8e
--- /dev/null
+++ b/drivers/clocksource/timer-vt8500.c
@@ -0,0 +1,168 @@
+/*
+ *  arch/arm/mach-vt8500/timer.c
+ *
+ *  Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * This file is copied and modified from the original timer.c provided by
+ * Alexey Charkov. Minor changes have been made for Device Tree Support.
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define VT8500_TIMER_OFFSET	0x0100
+#define VT8500_TIMER_HZ		3000000
+#define TIMER_MATCH_VAL		0x0000
+#define TIMER_COUNT_VAL		0x0010
+#define TIMER_STATUS_VAL	0x0014
+#define TIMER_IER_VAL		0x001c		/* interrupt enable */
+#define TIMER_CTRL_VAL		0x0020
+#define TIMER_AS_VAL		0x0024		/* access status */
+#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
+#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
+#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
+
+#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
+
+#define MIN_OSCR_DELTA		16
+
+static void __iomem *regbase;
+
+static u64 vt8500_timer_read(struct clocksource *cs)
+{
+	int loops = msecs_to_loops(10);
+	writel(3, regbase + TIMER_CTRL_VAL);
+	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
+						&& --loops)
+		cpu_relax();
+	return readl(regbase + TIMER_COUNT_VAL);
+}
+
+static struct clocksource clocksource = {
+	.name           = "vt8500_timer",
+	.rating         = 200,
+	.read           = vt8500_timer_read,
+	.mask           = CLOCKSOURCE_MASK(32),
+	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int vt8500_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	int loops = msecs_to_loops(10);
+	u64 alarm = clocksource.read(&clocksource) + cycles;
+	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
+						&& --loops)
+		cpu_relax();
+	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
+
+	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
+		return -ETIME;
+
+	writel(1, regbase + TIMER_IER_VAL);
+
+	return 0;
+}
+
+static int vt8500_shutdown(struct clock_event_device *evt)
+{
+	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
+	writel(0, regbase + TIMER_IER_VAL);
+	return 0;
+}
+
+static struct clock_event_device clockevent = {
+	.name			= "vt8500_timer",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_next_event		= vt8500_timer_set_next_event,
+	.set_state_shutdown	= vt8500_shutdown,
+	.set_state_oneshot	= vt8500_shutdown,
+};
+
+static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	writel(0xf, regbase + TIMER_STATUS_VAL);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq = {
+	.name    = "vt8500_timer",
+	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
+	.handler = vt8500_timer_interrupt,
+	.dev_id  = &clockevent,
+};
+
+static int __init vt8500_timer_init(struct device_node *np)
+{
+	int timer_irq, ret;
+
+	regbase = of_iomap(np, 0);
+	if (!regbase) {
+		pr_err("%s: Missing iobase description in Device Tree\n",
+								__func__);
+		return -ENXIO;
+	}
+
+	timer_irq = irq_of_parse_and_map(np, 0);
+	if (!timer_irq) {
+		pr_err("%s: Missing irq description in Device Tree\n",
+								__func__);
+		return -EINVAL;
+	}
+
+	writel(1, regbase + TIMER_CTRL_VAL);
+	writel(0xf, regbase + TIMER_STATUS_VAL);
+	writel(~0, regbase + TIMER_MATCH_VAL);
+
+	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
+	if (ret) {
+		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
+		       __func__, clocksource.name);
+		return ret;
+	}
+
+	clockevent.cpumask = cpumask_of(0);
+
+	ret = setup_irq(timer_irq, &irq);
+	if (ret) {
+		pr_err("%s: setup_irq failed for %s\n", __func__,
+							clockevent.name);
+		return ret;
+	}
+
+	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
+					MIN_OSCR_DELTA * 2, 0xf0000000);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
diff --git a/drivers/clocksource/timer-zevio.c b/drivers/clocksource/timer-zevio.c
new file mode 100644
index 000000000000..f74689334f7c
--- /dev/null
+++ b/drivers/clocksource/timer-zevio.c
@@ -0,0 +1,218 @@
+/*
+ *  linux/drivers/clocksource/zevio-timer.c
+ *
+ *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#define IO_CURRENT_VAL	0x00
+#define IO_DIVIDER	0x04
+#define IO_CONTROL	0x08
+
+#define IO_TIMER1	0x00
+#define IO_TIMER2	0x0C
+
+#define IO_MATCH_BEGIN	0x18
+#define IO_MATCH(x)	(IO_MATCH_BEGIN + ((x) << 2))
+
+#define IO_INTR_STS	0x00
+#define IO_INTR_ACK	0x00
+#define IO_INTR_MSK	0x04
+
+#define CNTL_STOP_TIMER	(1 << 4)
+#define CNTL_RUN_TIMER	(0 << 4)
+
+#define CNTL_INC	(1 << 3)
+#define CNTL_DEC	(0 << 3)
+
+#define CNTL_TOZERO	0
+#define CNTL_MATCH(x)	((x) + 1)
+#define CNTL_FOREVER	7
+
+/* There are 6 match registers but we only use one. */
+#define TIMER_MATCH	0
+
+#define TIMER_INTR_MSK	(1 << (TIMER_MATCH))
+#define TIMER_INTR_ALL	0x3F
+
+struct zevio_timer {
+	void __iomem *base;
+	void __iomem *timer1, *timer2;
+	void __iomem *interrupt_regs;
+
+	struct clk *clk;
+	struct clock_event_device clkevt;
+	struct irqaction clkevt_irq;
+
+	char clocksource_name[64];
+	char clockevent_name[64];
+};
+
+static int zevio_timer_set_event(unsigned long delta,
+				 struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	writel(delta, timer->timer1 + IO_CURRENT_VAL);
+	writel(CNTL_RUN_TIMER | CNTL_DEC | CNTL_MATCH(TIMER_MATCH),
+			timer->timer1 + IO_CONTROL);
+
+	return 0;
+}
+
+static int zevio_timer_shutdown(struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	/* Disable timer interrupts */
+	writel(0, timer->interrupt_regs + IO_INTR_MSK);
+	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+	/* Stop timer */
+	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+	return 0;
+}
+
+static int zevio_timer_set_oneshot(struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	/* Enable timer interrupts */
+	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
+	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+	return 0;
+}
+
+static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
+{
+	struct zevio_timer *timer = dev_id;
+	u32 intr;
+
+	intr = readl(timer->interrupt_regs + IO_INTR_ACK);
+	if (!(intr & TIMER_INTR_MSK))
+		return IRQ_NONE;
+
+	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_ACK);
+	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+
+	if (timer->clkevt.event_handler)
+		timer->clkevt.event_handler(&timer->clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init zevio_timer_add(struct device_node *node)
+{
+	struct zevio_timer *timer;
+	struct resource res;
+	int irqnr, ret;
+
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	timer->base = of_iomap(node, 0);
+	if (!timer->base) {
+		ret = -EINVAL;
+		goto error_free;
+	}
+	timer->timer1 = timer->base + IO_TIMER1;
+	timer->timer2 = timer->base + IO_TIMER2;
+
+	timer->clk = of_clk_get(node, 0);
+	if (IS_ERR(timer->clk)) {
+		ret = PTR_ERR(timer->clk);
+		pr_err("Timer clock not found! (error %d)\n", ret);
+		goto error_unmap;
+	}
+
+	timer->interrupt_regs = of_iomap(node, 1);
+	irqnr = irq_of_parse_and_map(node, 0);
+
+	of_address_to_resource(node, 0, &res);
+	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
+			"%llx.%s_clocksource",
+			(unsigned long long)res.start, node->name);
+
+	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
+			"%llx.%s_clockevent",
+			(unsigned long long)res.start, node->name);
+
+	if (timer->interrupt_regs && irqnr) {
+		timer->clkevt.name		= timer->clockevent_name;
+		timer->clkevt.set_next_event	= zevio_timer_set_event;
+		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
+		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
+		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
+		timer->clkevt.rating		= 200;
+		timer->clkevt.cpumask		= cpu_possible_mask;
+		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
+		timer->clkevt.irq		= irqnr;
+
+		writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+		writel(0, timer->timer1 + IO_DIVIDER);
+
+		/* Start with timer interrupts disabled */
+		writel(0, timer->interrupt_regs + IO_INTR_MSK);
+		writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+
+		/* Interrupt to occur when timer value matches 0 */
+		writel(0, timer->base + IO_MATCH(TIMER_MATCH));
+
+		timer->clkevt_irq.name		= timer->clockevent_name;
+		timer->clkevt_irq.handler	= zevio_timer_interrupt;
+		timer->clkevt_irq.dev_id	= timer;
+		timer->clkevt_irq.flags		= IRQF_TIMER | IRQF_IRQPOLL;
+
+		setup_irq(irqnr, &timer->clkevt_irq);
+
+		clockevents_config_and_register(&timer->clkevt,
+				clk_get_rate(timer->clk), 0x0001, 0xffff);
+		pr_info("Added %s as clockevent\n", timer->clockevent_name);
+	}
+
+	writel(CNTL_STOP_TIMER, timer->timer2 + IO_CONTROL);
+	writel(0, timer->timer2 + IO_CURRENT_VAL);
+	writel(0, timer->timer2 + IO_DIVIDER);
+	writel(CNTL_RUN_TIMER | CNTL_FOREVER | CNTL_INC,
+			timer->timer2 + IO_CONTROL);
+
+	clocksource_mmio_init(timer->timer2 + IO_CURRENT_VAL,
+			timer->clocksource_name,
+			clk_get_rate(timer->clk),
+			200, 16,
+			clocksource_mmio_readw_up);
+
+	pr_info("Added %s as clocksource\n", timer->clocksource_name);
+
+	return 0;
+error_unmap:
+	iounmap(timer->base);
+error_free:
+	kfree(timer);
+	return ret;
+}
+
+static int __init zevio_timer_init(struct device_node *node)
+{
+	return zevio_timer_add(node);
+}
+
+TIMER_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/versatile.c
deleted file mode 100644
index 39725d38aede..000000000000
--- a/drivers/clocksource/versatile.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2014 ARM Limited
- */
-
-#include <linux/clocksource.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/sched_clock.h>
-
-#define SYS_24MHZ 0x05c
-
-static void __iomem *versatile_sys_24mhz;
-
-static u64 notrace versatile_sys_24mhz_read(void)
-{
-	return readl(versatile_sys_24mhz);
-}
-
-static int __init versatile_sched_clock_init(struct device_node *node)
-{
-	void __iomem *base = of_iomap(node, 0);
-
-	if (!base)
-		return -ENXIO;
-
-	versatile_sys_24mhz = base + SYS_24MHZ;
-
-	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
-
-	return 0;
-}
-TIMER_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
-		       versatile_sched_clock_init);
-TIMER_OF_DECLARE(versatile, "arm,versatile-sysreg",
-		       versatile_sched_clock_init);
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
deleted file mode 100644
index 0f92089ec08c..000000000000
--- a/drivers/clocksource/vf_pit_timer.c
+++ /dev/null
@@ -1,204 +0,0 @@
-/*
- * Copyright 2012-2013 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- */
-
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clk.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-/*
- * Each pit takes 0x10 Bytes register space
- */
-#define PITMCR		0x00
-#define PIT0_OFFSET	0x100
-#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
-#define PITLDVAL	0x00
-#define PITCVAL		0x04
-#define PITTCTRL	0x08
-#define PITTFLG		0x0c
-
-#define PITMCR_MDIS	(0x1 << 1)
-
-#define PITTCTRL_TEN	(0x1 << 0)
-#define PITTCTRL_TIE	(0x1 << 1)
-#define PITCTRL_CHN	(0x1 << 2)
-
-#define PITTFLG_TIF	0x1
-
-static void __iomem *clksrc_base;
-static void __iomem *clkevt_base;
-static unsigned long cycle_per_jiffy;
-
-static inline void pit_timer_enable(void)
-{
-	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
-}
-
-static inline void pit_timer_disable(void)
-{
-	__raw_writel(0, clkevt_base + PITTCTRL);
-}
-
-static inline void pit_irq_acknowledge(void)
-{
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
-}
-
-static u64 notrace pit_read_sched_clock(void)
-{
-	return ~__raw_readl(clksrc_base + PITCVAL);
-}
-
-static int __init pit_clocksource_init(unsigned long rate)
-{
-	/* set the max load value and start the clock source counter */
-	__raw_writel(0, clksrc_base + PITTCTRL);
-	__raw_writel(~0UL, clksrc_base + PITLDVAL);
-	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
-
-	sched_clock_register(pit_read_sched_clock, 32, rate);
-	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
-			300, 32, clocksource_mmio_readl_down);
-}
-
-static int pit_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
-{
-	/*
-	 * set a new value to PITLDVAL register will not restart the timer,
-	 * to abort the current cycle and start a timer period with the new
-	 * value, the timer must be disabled and enabled again.
-	 * and the PITLAVAL should be set to delta minus one according to pit
-	 * hardware requirement.
-	 */
-	pit_timer_disable();
-	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
-	pit_timer_enable();
-
-	return 0;
-}
-
-static int pit_shutdown(struct clock_event_device *evt)
-{
-	pit_timer_disable();
-	return 0;
-}
-
-static int pit_set_periodic(struct clock_event_device *evt)
-{
-	pit_set_next_event(cycle_per_jiffy, evt);
-	return 0;
-}
-
-static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	pit_irq_acknowledge();
-
-	/*
-	 * pit hardware doesn't support oneshot, it will generate an interrupt
-	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
-	 * and start the counter again. So software need to disable the timer
-	 * to stop the counter loop in ONESHOT mode.
-	 */
-	if (likely(clockevent_state_oneshot(evt)))
-		pit_timer_disable();
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct clock_event_device clockevent_pit = {
-	.name		= "VF pit timer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown = pit_shutdown,
-	.set_state_periodic = pit_set_periodic,
-	.set_next_event	= pit_set_next_event,
-	.rating		= 300,
-};
-
-static struct irqaction pit_timer_irq = {
-	.name		= "VF pit timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= pit_timer_interrupt,
-	.dev_id		= &clockevent_pit,
-};
-
-static int __init pit_clockevent_init(unsigned long rate, int irq)
-{
-	__raw_writel(0, clkevt_base + PITTCTRL);
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
-
-	BUG_ON(setup_irq(irq, &pit_timer_irq));
-
-	clockevent_pit.cpumask = cpumask_of(0);
-	clockevent_pit.irq = irq;
-	/*
-	 * The value for the LDVAL register trigger is calculated as:
-	 * LDVAL trigger = (period / clock period) - 1
-	 * The pit is a 32-bit down count timer, when the conter value
-	 * reaches 0, it will generate an interrupt, thus the minimal
-	 * LDVAL trigger value is 1. And then the min_delta is
-	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
-	 */
-	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
-
-	return 0;
-}
-
-static int __init pit_timer_init(struct device_node *np)
-{
-	struct clk *pit_clk;
-	void __iomem *timer_base;
-	unsigned long clk_rate;
-	int irq, ret;
-
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
-	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
-	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
-	 */
-	clksrc_base = timer_base + PITn_OFFSET(2);
-	clkevt_base = timer_base + PITn_OFFSET(3);
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0)
-		return -EINVAL;
-
-	pit_clk = of_clk_get(np, 0);
-	if (IS_ERR(pit_clk))
-		return PTR_ERR(pit_clk);
-
-	ret = clk_prepare_enable(pit_clk);
-	if (ret)
-		return ret;
-
-	clk_rate = clk_get_rate(pit_clk);
-	cycle_per_jiffy = clk_rate / (HZ);
-
-	/* enable the pit module */
-	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
-
-	ret = pit_clocksource_init(clk_rate);
-	if (ret)
-		return ret;
-
-	return pit_clockevent_init(clk_rate, irq);
-}
-TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
deleted file mode 100644
index e0f7489cfc8e..000000000000
--- a/drivers/clocksource/vt8500_timer.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
- *  arch/arm/mach-vt8500/timer.c
- *
- *  Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
- *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This file is copied and modified from the original timer.c provided by
- * Alexey Charkov. Minor changes have been made for Device Tree Support.
- */
-
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/delay.h>
-
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#define VT8500_TIMER_OFFSET	0x0100
-#define VT8500_TIMER_HZ		3000000
-#define TIMER_MATCH_VAL		0x0000
-#define TIMER_COUNT_VAL		0x0010
-#define TIMER_STATUS_VAL	0x0014
-#define TIMER_IER_VAL		0x001c		/* interrupt enable */
-#define TIMER_CTRL_VAL		0x0020
-#define TIMER_AS_VAL		0x0024		/* access status */
-#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
-#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
-#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
-
-#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-
-#define MIN_OSCR_DELTA		16
-
-static void __iomem *regbase;
-
-static u64 vt8500_timer_read(struct clocksource *cs)
-{
-	int loops = msecs_to_loops(10);
-	writel(3, regbase + TIMER_CTRL_VAL);
-	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
-						&& --loops)
-		cpu_relax();
-	return readl(regbase + TIMER_COUNT_VAL);
-}
-
-static struct clocksource clocksource = {
-	.name           = "vt8500_timer",
-	.rating         = 200,
-	.read           = vt8500_timer_read,
-	.mask           = CLOCKSOURCE_MASK(32),
-	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int vt8500_timer_set_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
-{
-	int loops = msecs_to_loops(10);
-	u64 alarm = clocksource.read(&clocksource) + cycles;
-	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
-						&& --loops)
-		cpu_relax();
-	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
-
-	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
-		return -ETIME;
-
-	writel(1, regbase + TIMER_IER_VAL);
-
-	return 0;
-}
-
-static int vt8500_shutdown(struct clock_event_device *evt)
-{
-	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
-	writel(0, regbase + TIMER_IER_VAL);
-	return 0;
-}
-
-static struct clock_event_device clockevent = {
-	.name			= "vt8500_timer",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 200,
-	.set_next_event		= vt8500_timer_set_next_event,
-	.set_state_shutdown	= vt8500_shutdown,
-	.set_state_oneshot	= vt8500_shutdown,
-};
-
-static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction irq = {
-	.name    = "vt8500_timer",
-	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = vt8500_timer_interrupt,
-	.dev_id  = &clockevent,
-};
-
-static int __init vt8500_timer_init(struct device_node *np)
-{
-	int timer_irq, ret;
-
-	regbase = of_iomap(np, 0);
-	if (!regbase) {
-		pr_err("%s: Missing iobase description in Device Tree\n",
-								__func__);
-		return -ENXIO;
-	}
-
-	timer_irq = irq_of_parse_and_map(np, 0);
-	if (!timer_irq) {
-		pr_err("%s: Missing irq description in Device Tree\n",
-								__func__);
-		return -EINVAL;
-	}
-
-	writel(1, regbase + TIMER_CTRL_VAL);
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	writel(~0, regbase + TIMER_MATCH_VAL);
-
-	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
-	if (ret) {
-		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
-		       __func__, clocksource.name);
-		return ret;
-	}
-
-	clockevent.cpumask = cpumask_of(0);
-
-	ret = setup_irq(timer_irq, &irq);
-	if (ret) {
-		pr_err("%s: setup_irq failed for %s\n", __func__,
-							clockevent.name);
-		return ret;
-	}
-
-	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
-					MIN_OSCR_DELTA * 2, 0xf0000000);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
deleted file mode 100644
index f74689334f7c..000000000000
--- a/drivers/clocksource/zevio-timer.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- *  linux/drivers/clocksource/zevio-timer.c
- *
- *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/cpumask.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-#define IO_CURRENT_VAL	0x00
-#define IO_DIVIDER	0x04
-#define IO_CONTROL	0x08
-
-#define IO_TIMER1	0x00
-#define IO_TIMER2	0x0C
-
-#define IO_MATCH_BEGIN	0x18
-#define IO_MATCH(x)	(IO_MATCH_BEGIN + ((x) << 2))
-
-#define IO_INTR_STS	0x00
-#define IO_INTR_ACK	0x00
-#define IO_INTR_MSK	0x04
-
-#define CNTL_STOP_TIMER	(1 << 4)
-#define CNTL_RUN_TIMER	(0 << 4)
-
-#define CNTL_INC	(1 << 3)
-#define CNTL_DEC	(0 << 3)
-
-#define CNTL_TOZERO	0
-#define CNTL_MATCH(x)	((x) + 1)
-#define CNTL_FOREVER	7
-
-/* There are 6 match registers but we only use one. */
-#define TIMER_MATCH	0
-
-#define TIMER_INTR_MSK	(1 << (TIMER_MATCH))
-#define TIMER_INTR_ALL	0x3F
-
-struct zevio_timer {
-	void __iomem *base;
-	void __iomem *timer1, *timer2;
-	void __iomem *interrupt_regs;
-
-	struct clk *clk;
-	struct clock_event_device clkevt;
-	struct irqaction clkevt_irq;
-
-	char clocksource_name[64];
-	char clockevent_name[64];
-};
-
-static int zevio_timer_set_event(unsigned long delta,
-				 struct clock_event_device *dev)
-{
-	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
-						 clkevt);
-
-	writel(delta, timer->timer1 + IO_CURRENT_VAL);
-	writel(CNTL_RUN_TIMER | CNTL_DEC | CNTL_MATCH(TIMER_MATCH),
-			timer->timer1 + IO_CONTROL);
-
-	return 0;
-}
-
-static int zevio_timer_shutdown(struct clock_event_device *dev)
-{
-	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
-						 clkevt);
-
-	/* Disable timer interrupts */
-	writel(0, timer->interrupt_regs + IO_INTR_MSK);
-	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-	/* Stop timer */
-	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-	return 0;
-}
-
-static int zevio_timer_set_oneshot(struct clock_event_device *dev)
-{
-	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
-						 clkevt);
-
-	/* Enable timer interrupts */
-	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
-	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-	return 0;
-}
-
-static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
-{
-	struct zevio_timer *timer = dev_id;
-	u32 intr;
-
-	intr = readl(timer->interrupt_regs + IO_INTR_ACK);
-	if (!(intr & TIMER_INTR_MSK))
-		return IRQ_NONE;
-
-	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_ACK);
-	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-
-	if (timer->clkevt.event_handler)
-		timer->clkevt.event_handler(&timer->clkevt);
-
-	return IRQ_HANDLED;
-}
-
-static int __init zevio_timer_add(struct device_node *node)
-{
-	struct zevio_timer *timer;
-	struct resource res;
-	int irqnr, ret;
-
-	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
-	if (!timer)
-		return -ENOMEM;
-
-	timer->base = of_iomap(node, 0);
-	if (!timer->base) {
-		ret = -EINVAL;
-		goto error_free;
-	}
-	timer->timer1 = timer->base + IO_TIMER1;
-	timer->timer2 = timer->base + IO_TIMER2;
-
-	timer->clk = of_clk_get(node, 0);
-	if (IS_ERR(timer->clk)) {
-		ret = PTR_ERR(timer->clk);
-		pr_err("Timer clock not found! (error %d)\n", ret);
-		goto error_unmap;
-	}
-
-	timer->interrupt_regs = of_iomap(node, 1);
-	irqnr = irq_of_parse_and_map(node, 0);
-
-	of_address_to_resource(node, 0, &res);
-	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
-			"%llx.%s_clocksource",
-			(unsigned long long)res.start, node->name);
-
-	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
-			"%llx.%s_clockevent",
-			(unsigned long long)res.start, node->name);
-
-	if (timer->interrupt_regs && irqnr) {
-		timer->clkevt.name		= timer->clockevent_name;
-		timer->clkevt.set_next_event	= zevio_timer_set_event;
-		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
-		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
-		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
-		timer->clkevt.rating		= 200;
-		timer->clkevt.cpumask		= cpu_possible_mask;
-		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
-		timer->clkevt.irq		= irqnr;
-
-		writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-		writel(0, timer->timer1 + IO_DIVIDER);
-
-		/* Start with timer interrupts disabled */
-		writel(0, timer->interrupt_regs + IO_INTR_MSK);
-		writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-
-		/* Interrupt to occur when timer value matches 0 */
-		writel(0, timer->base + IO_MATCH(TIMER_MATCH));
-
-		timer->clkevt_irq.name		= timer->clockevent_name;
-		timer->clkevt_irq.handler	= zevio_timer_interrupt;
-		timer->clkevt_irq.dev_id	= timer;
-		timer->clkevt_irq.flags		= IRQF_TIMER | IRQF_IRQPOLL;
-
-		setup_irq(irqnr, &timer->clkevt_irq);
-
-		clockevents_config_and_register(&timer->clkevt,
-				clk_get_rate(timer->clk), 0x0001, 0xffff);
-		pr_info("Added %s as clockevent\n", timer->clockevent_name);
-	}
-
-	writel(CNTL_STOP_TIMER, timer->timer2 + IO_CONTROL);
-	writel(0, timer->timer2 + IO_CURRENT_VAL);
-	writel(0, timer->timer2 + IO_DIVIDER);
-	writel(CNTL_RUN_TIMER | CNTL_FOREVER | CNTL_INC,
-			timer->timer2 + IO_CONTROL);
-
-	clocksource_mmio_init(timer->timer2 + IO_CURRENT_VAL,
-			timer->clocksource_name,
-			clk_get_rate(timer->clk),
-			200, 16,
-			clocksource_mmio_readw_up);
-
-	pr_info("Added %s as clocksource\n", timer->clocksource_name);
-
-	return 0;
-error_unmap:
-	iounmap(timer->base);
-error_free:
-	kfree(timer);
-	return ret;
-}
-
-static int __init zevio_timer_init(struct device_node *node)
-{
-	return zevio_timer_add(node);
-}
-
-TIMER_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
index 015155da59c2..76139865d7fa 100644
--- a/drivers/crypto/nx/Makefile
+++ b/drivers/crypto/nx/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_NX_ENCRYPT) += nx-crypto.o
 nx-crypto-objs := nx.o \
-		  nx_debugfs.o \
 		  nx-aes-cbc.o \
 		  nx-aes-ecb.o \
 		  nx-aes-gcm.o \
@@ -11,6 +10,7 @@ nx-crypto-objs := nx.o \
 		  nx-sha256.o \
 		  nx-sha512.o
 
+nx-crypto-$(CONFIG_DEBUG_FS) += nx_debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES) += nx-compress-pseries.o nx-compress.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV) += nx-compress-powernv.o nx-compress.o
 nx-compress-objs := nx-842.o
diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index c3e54af18645..ebad937a9545 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -180,8 +180,8 @@ struct nx_sg *nx_walk_and_build(struct nx_sg *, unsigned int,
 int nx_debugfs_init(struct nx_crypto_driver *);
 void nx_debugfs_fini(struct nx_crypto_driver *);
 #else
-#define NX_DEBUGFS_INIT(drv)	(0)
-#define NX_DEBUGFS_FINI(drv)	(0)
+#define NX_DEBUGFS_INIT(drv)	do {} while (0)
+#define NX_DEBUGFS_FINI(drv)	do {} while (0)
 #endif
 
 #define NX_PAGE_NUM(x)		((u64)(x) & 0xfffffffffffff000ULL)
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 4c70136c7aa3..84fc0e48bb0e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -204,6 +204,14 @@ static const struct __extcon_info {
  * @attr_name:		"name" sysfs entry
  * @attr_state:		"state" sysfs entry
  * @attrs:		the array pointing to attr_name and attr_state for attr_g
+ * @usb_propval:	the array of USB connector properties
+ * @chg_propval:	the array of charger connector properties
+ * @jack_propval:	the array of jack connector properties
+ * @disp_propval:	the array of display connector properties
+ * @usb_bits:		the bit array of the USB connector property capabilities
+ * @chg_bits:		the bit array of the charger connector property capabilities
+ * @jack_bits:		the bit array of the jack connector property capabilities
+ * @disp_bits:		the bit array of the display connector property capabilities
  */
 struct extcon_cable {
 	struct extcon_dev *edev;
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 45c048751f3b..9e7abc86de8c 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1112,7 +1112,7 @@ static void context_tasklet(unsigned long data)
 static int context_add_buffer(struct context *ctx)
 {
 	struct descriptor_buffer *desc;
-	dma_addr_t uninitialized_var(bus_addr);
+	dma_addr_t bus_addr;
 	int offset;
 
 	/*
@@ -1302,7 +1302,7 @@ static int at_context_queue_packet(struct context *ctx,
 				   struct fw_packet *packet)
 {
 	struct fw_ohci *ohci = ctx->ohci;
-	dma_addr_t d_bus, uninitialized_var(payload_bus);
+	dma_addr_t d_bus, payload_bus;
 	struct driver_data *driver_data;
 	struct descriptor *d, *last;
 	__le32 *header;
@@ -2458,7 +2458,7 @@ static int ohci_set_config_rom(struct fw_card *card,
 {
 	struct fw_ohci *ohci;
 	__be32 *next_config_rom;
-	dma_addr_t uninitialized_var(next_config_rom_bus);
+	dma_addr_t next_config_rom_bus;
 
 	ohci = fw_ohci(card);
 
@@ -2947,10 +2947,10 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
 				int type, int channel, size_t header_size)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	struct iso_context *uninitialized_var(ctx);
-	descriptor_callback_t uninitialized_var(callback);
-	u64 *uninitialized_var(channels);
-	u32 *uninitialized_var(mask), uninitialized_var(regs);
+	struct iso_context *ctx;
+	descriptor_callback_t callback;
+	u64 *channels;
+	u32 *mask, regs;
 	int index, ret = -EBUSY;
 
 	spin_lock_irq(&ohci->lock);
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
index aff6e504c666..9704cff9b4aa 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a1f5df4bc07..cdcf9e697c39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2989,6 +2989,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
+	/* No valid flags defined yet */
+	if (args->in.flags)
+		return -EINVAL;
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* current, we only have requirement to reserve vmid from gfxhub */
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index c72092319a53..214cd2028cd5 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -988,7 +988,7 @@ static void sii8620_set_auto_zone(struct sii8620 *ctx)
 
 static void sii8620_stop_video(struct sii8620 *ctx)
 {
-	u8 uninitialized_var(val);
+	u8 val;
 
 	sii8620_write_seq_static(ctx,
 		REG_TPI_INTR_EN, 0,
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 281cf9cbb44c..70b26487de79 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -91,6 +91,12 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
 	if (!state->planes)
 		goto fail;
 
+	/*
+	 * Because drm_atomic_state can be committed asynchronously we need our
+	 * own reference and cannot rely on the on implied by drm_file in the
+	 * ioctl call.
+	 */
+	drm_dev_get(dev);
 	state->dev = dev;
 
 	DRM_DEBUG_ATOMIC("Allocated atomic state %p\n", state);
@@ -250,7 +256,8 @@ EXPORT_SYMBOL(drm_atomic_state_clear);
 void __drm_atomic_state_free(struct kref *ref)
 {
 	struct drm_atomic_state *state = container_of(ref, typeof(*state), ref);
-	struct drm_mode_config *config = &state->dev->mode_config;
+	struct drm_device *dev = state->dev;
+	struct drm_mode_config *config = &dev->mode_config;
 
 	drm_atomic_state_clear(state);
 
@@ -262,6 +269,8 @@ void __drm_atomic_state_free(struct kref *ref)
 		drm_atomic_state_default_release(state);
 		kfree(state);
 	}
+
+	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(__drm_atomic_state_free);
 
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 28ea3d260bea..8b7b107cf2ce 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2778,7 +2778,7 @@ static int drm_cvt_modes(struct drm_connector *connector,
 	const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
-		int uninitialized_var(width), height;
+		int width, height;
 		cvt = &(timing->data.other_data.data.cvt[i]);
 
 		if (!memcmp(cvt->code, empty, 3))
@@ -2786,6 +2786,8 @@ static int drm_cvt_modes(struct drm_connector *connector,
 
 		height = (cvt->code[0] + ((cvt->code[1] & 0xf0) << 4) + 1) * 2;
 		switch (cvt->code[1] & 0x0c) {
+		/* default - because compiler doesn't see that we've enumerated all cases */
+		default:
 		case 0x00:
 			width = height * 4 / 3;
 			break;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index fbe9156c9e7c..ee6801fa36ad 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2233,6 +2233,9 @@ static bool drm_target_cloned(struct drm_fb_helper *fb_helper,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(fb_helper->dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	drm_fb_helper_for_each_connector(fb_helper, i) {
 		if (!enabled[i])
 			continue;
@@ -2249,11 +2252,13 @@ static bool drm_target_cloned(struct drm_fb_helper *fb_helper,
 		if (!modes[i])
 			can_clone = false;
 	}
+	kfree(dmt_mode);
 
 	if (can_clone) {
 		DRM_DEBUG_KMS("can clone using 1024x768\n");
 		return true;
 	}
+fail:
 	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
 	return false;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 8d776070913d..8610589299fc 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -544,9 +544,9 @@ static unsigned long exynos_dsi_pll_find_pms(struct exynos_dsi *dsi,
 	unsigned long best_freq = 0;
 	u32 min_delta = 0xffffffff;
 	u8 p_min, p_max;
-	u8 _p, uninitialized_var(best_p);
-	u16 _m, uninitialized_var(best_m);
-	u8 _s, uninitialized_var(best_s);
+	u8 _p, best_p;
+	u16 _m, best_m;
+	u8 _s, best_s;
 
 	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
 	p_max = fin / (6 * MHZ);
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index ba513018534e..1bdba8cc25d3 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -173,7 +173,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 			 * since we've already mapped it once in
 			 * submit_reloc()
 			 */
-			if (WARN_ON(!ptr))
+			if (WARN_ON(IS_ERR_OR_NULL(ptr)))
 				return;
 
 			for (i = 0; i < dwords; i++) {
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a424afdcc77a..35771e0e69fa 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -405,8 +405,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
 	.num_modes = 1,
 	.bpc = 8,
 	.size = {
-		.width = 105,
-		.height = 67,
+		.width = 99,
+		.height = 58,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 90c1afe498be..ce8b14592b69 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5552,6 +5552,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	u8 frev, crev;
 	u8 *power_state_offset;
 	struct ci_ps *ps;
+	int ret;
 
 	if (!atom_parse_data_header(mode_info->atom_context, index, NULL,
 				   &frev, &crev, &data_offset))
@@ -5581,11 +5582,15 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info)
-			return -EINVAL;
+		if (!rdev->pm.power_state[i].clock_info) {
+			ret = -EINVAL;
+			goto err_free_ps;
+		}
 		ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
-		if (ps == NULL)
-			return -ENOMEM;
+		if (ps == NULL) {
+			ret = -ENOMEM;
+			goto err_free_ps;
+		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -5625,6 +5630,12 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	}
 
 	return 0;
+
+err_free_ps:
+	for (i = 0; i < rdev->pm.dpm.num_ps; i++)
+		kfree(rdev->pm.dpm.ps[i].ps_priv);
+	kfree(rdev->pm.dpm.ps);
+	return ret;
 }
 
 static int ci_get_vbios_boot_values(struct radeon_device *rdev,
@@ -5713,25 +5724,26 @@ int ci_dpm_init(struct radeon_device *rdev)
 
 	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_get_platform_caps(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_parse_extended_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = ci_parse_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
+		r600_free_extended_power_table(rdev);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index 3eb7899a4035..2c637e04dfeb 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -558,8 +558,12 @@ static int cypress_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index a7273c01de34..2a9d415400f7 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2239,8 +2239,12 @@ static int ni_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/rv740_dpm.c b/drivers/gpu/drm/radeon/rv740_dpm.c
index afd597ec5085..50290e93c79d 100644
--- a/drivers/gpu/drm/radeon/rv740_dpm.c
+++ b/drivers/gpu/drm/radeon/rv740_dpm.c
@@ -251,8 +251,12 @@ int rv740_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = 0x40000 * ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = 0x40000 * ss.percentage *
 				(dividers.whole_fb_div + (dividers.frac_fb_div / 8)) / (clk_s * 10000);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 779ec8fdfae0..56dd2d6ba9e4 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -698,7 +698,7 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 46 && !(reg & 0x02))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 61ab462fd94c..fe7642b916cf 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -421,7 +421,7 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
 {
 	unsigned int i;
 	unsigned int len = i2c->msg->len - i2c->processed;
-	u32 uninitialized_var(val);
+	u32 val;
 	u8 byte;
 
 	/* we only care for MBRF here. */
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 03ce9b7d6456..c1f85114ab81 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -362,6 +362,9 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	struct xiic_i2c *i2c = dev_id;
 	u32 pend, isr, ier;
 	u32 clr = 0;
+	int xfer_more = 0;
+	int wakeup_req = 0;
+	int wakeup_code = 0;
 
 	/* Get the interrupt Status from the IPIF. There is no clearing of
 	 * interrupts in the IPIF. Interrupts must be cleared at the source.
@@ -398,10 +401,16 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		 */
 		xiic_reinit(i2c);
 
-		if (i2c->rx_msg)
-			xiic_wakeup(i2c, STATE_ERROR);
-		if (i2c->tx_msg)
-			xiic_wakeup(i2c, STATE_ERROR);
+		if (i2c->rx_msg) {
+			wakeup_req = 1;
+			wakeup_code = STATE_ERROR;
+		}
+		if (i2c->tx_msg) {
+			wakeup_req = 1;
+			wakeup_code = STATE_ERROR;
+		}
+		/* don't try to handle other events */
+		goto out;
 	}
 	if (pend & XIIC_INTR_RX_FULL_MASK) {
 		/* Receive register/FIFO is full */
@@ -435,8 +444,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 				i2c->tx_msg++;
 				dev_dbg(i2c->adap.dev.parent,
 					"%s will start next...\n", __func__);
-
-				__xiic_start_xfer(i2c);
+				xfer_more = 1;
 			}
 		}
 	}
@@ -450,11 +458,13 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		if (!i2c->tx_msg)
 			goto out;
 
-		if ((i2c->nmsgs == 1) && !i2c->rx_msg &&
-			xiic_tx_space(i2c) == 0)
-			xiic_wakeup(i2c, STATE_DONE);
+		wakeup_req = 1;
+
+		if (i2c->nmsgs == 1 && !i2c->rx_msg &&
+		    xiic_tx_space(i2c) == 0)
+			wakeup_code = STATE_DONE;
 		else
-			xiic_wakeup(i2c, STATE_ERROR);
+			wakeup_code = STATE_ERROR;
 	}
 	if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK)) {
 		/* Transmit register/FIFO is empty or ½ empty */
@@ -478,7 +488,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 			if (i2c->nmsgs > 1) {
 				i2c->nmsgs--;
 				i2c->tx_msg++;
-				__xiic_start_xfer(i2c);
+				xfer_more = 1;
 			} else {
 				xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
 
@@ -496,6 +506,13 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
 
 	xiic_setreg32(i2c, XIIC_IISR_OFFSET, clr);
+	if (xfer_more)
+		__xiic_start_xfer(i2c);
+	if (wakeup_req)
+		xiic_wakeup(i2c, wakeup_code);
+
+	WARN_ON(xfer_more && wakeup_req);
+
 	mutex_unlock(&i2c->lock);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 7d4e5c08f133..05e18d658141 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -180,7 +180,7 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 static acpi_handle ide_acpi_hwif_get_handle(ide_hwif_t *hwif)
 {
 	struct device		*dev = hwif->gendev.parent;
-	acpi_handle		uninitialized_var(dev_handle);
+	acpi_handle		dev_handle;
 	u64			pcidevfn;
 	acpi_handle		chan_handle;
 	int			err;
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 4224c4dd8963..9a4c094c897c 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -591,7 +591,7 @@ static int ide_delayed_transfer_pc(ide_drive_t *drive)
 
 static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 {
-	struct ide_atapi_pc *uninitialized_var(pc);
+	struct ide_atapi_pc *pc;
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->rq;
 	ide_expiry_t *expiry;
diff --git a/drivers/ide/ide-io-std.c b/drivers/ide/ide-io-std.c
index 19763977568c..508f98ca3fe8 100644
--- a/drivers/ide/ide-io-std.c
+++ b/drivers/ide/ide-io-std.c
@@ -172,7 +172,7 @@ void ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd, void *buf,
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (io_32bit) {
-		unsigned long uninitialized_var(flags);
+		unsigned long flags;
 
 		if ((io_32bit & 2) && !mmio) {
 			local_irq_save(flags);
@@ -216,7 +216,7 @@ void ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd, void *buf,
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (io_32bit) {
-		unsigned long uninitialized_var(flags);
+		unsigned long flags;
 
 		if ((io_32bit & 2) && !mmio) {
 			local_irq_save(flags);
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 438176084610..a01cc0124442 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -605,12 +605,12 @@ static int drive_is_ready(ide_drive_t *drive)
 void ide_timer_expiry (struct timer_list *t)
 {
 	ide_hwif_t	*hwif = from_timer(hwif, t, timer);
-	ide_drive_t	*uninitialized_var(drive);
+	ide_drive_t	*drive;
 	ide_handler_t	*handler;
 	unsigned long	flags;
 	int		wait = -1;
 	int		plug_device = 0;
-	struct request	*uninitialized_var(rq_in_flight);
+	struct request	*rq_in_flight;
 
 	spin_lock_irqsave(&hwif->lock, flags);
 
@@ -763,13 +763,13 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 {
 	ide_hwif_t *hwif = (ide_hwif_t *)dev_id;
 	struct ide_host *host = hwif->host;
-	ide_drive_t *uninitialized_var(drive);
+	ide_drive_t *drive;
 	ide_handler_t *handler;
 	unsigned long flags;
 	ide_startstop_t startstop;
 	irqreturn_t irq_ret = IRQ_NONE;
 	int plug_device = 0;
-	struct request *uninitialized_var(rq_in_flight);
+	struct request *rq_in_flight;
 
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
 		if (hwif != host->cur_port)
diff --git a/drivers/ide/ide-sysfs.c b/drivers/ide/ide-sysfs.c
index b9dfeb2e8bd6..c08a8a0916e2 100644
--- a/drivers/ide/ide-sysfs.c
+++ b/drivers/ide/ide-sysfs.c
@@ -131,7 +131,7 @@ static struct device_attribute *ide_port_attrs[] = {
 
 int ide_sysfs_register_port(ide_hwif_t *hwif)
 {
-	int i, uninitialized_var(rc);
+	int i, rc;
 
 	for (i = 0; ide_port_attrs[i]; i++) {
 		rc = device_create_file(hwif->portdev, ide_port_attrs[i]);
diff --git a/drivers/ide/umc8672.c b/drivers/ide/umc8672.c
index 3aa0fea0f3d9..1414caa97b40 100644
--- a/drivers/ide/umc8672.c
+++ b/drivers/ide/umc8672.c
@@ -107,7 +107,7 @@ static void umc_set_speeds(u8 speeds[])
 static void umc_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	ide_hwif_t *mate = hwif->mate;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n",
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 6e0ef9bb2497..c44876935750 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -75,7 +75,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d28e6f6ad497..3b287a51cd62 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1726,7 +1726,7 @@ ssize_t ib_uverbs_open_qp(struct ib_uverbs_file *file,
 	struct ib_udata                 udata;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
-	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
+	struct ib_uobject	       *xrcd_uobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_open_attr          attr;
 	int ret;
@@ -3694,7 +3694,7 @@ static int __uverbs_create_xsrq(struct ib_uverbs_file *file,
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
-	struct ib_uobject               *uninitialized_var(xrcd_uobj);
+	struct ib_uobject               *xrcd_uobj;
 	struct ib_srq_init_attr          attr;
 	int ret;
 	struct ib_device *ib_dev;
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 6c1a093b164e..a252b13958b3 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3195,7 +3195,7 @@ static int get_lladdr(struct net_device *dev, struct in6_addr *addr,
 
 static int pick_local_ip6addrs(struct c4iw_dev *dev, struct iw_cm_id *cm_id)
 {
-	struct in6_addr uninitialized_var(addr);
+	struct in6_addr addr;
 	struct sockaddr_in6 *la6 = (struct sockaddr_in6 *)&cm_id->m_local_addr;
 	struct sockaddr_in6 *ra6 = (struct sockaddr_in6 *)&cm_id->m_remote_addr;
 
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 43c611aa068c..8f30d477ab76 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -755,7 +755,7 @@ static int poll_cq(struct t4_wq *wq, struct t4_cq *cq, struct t4_cqe *cqe,
 static int __c4iw_poll_cq_one(struct c4iw_cq *chp, struct c4iw_qp *qhp,
 			      struct ib_wc *wc, struct c4iw_srq *srq)
 {
-	struct t4_cqe uninitialized_var(cqe);
+	struct t4_cqe cqe;
 	struct t4_wq *wq = qhp ? &qhp->wq : NULL;
 	u32 credit = 0;
 	u8 cqe_flushed;
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 33ff9eca28f6..245f9505a9ac 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3202,8 +3202,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	tx->num_desc++;
-	if ((unlikely(tx->num_desc == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
@@ -3216,6 +3215,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 		SDMA_MAP_NONE,
 		dd->sdma_pad_phys,
 		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
 }
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 46c775f255d1..a3dd2f3d56cc 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -680,14 +680,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 				  struct sdma_txreq *tx)
 {
-	tx->descp[tx->num_desc].qw[0] |=
-		SDMA_DESC0_LAST_DESC_FLAG;
-	tx->descp[tx->num_desc].qw[1] |=
-		dd->default_desc1;
+	u16 last_desc = tx->num_desc - 1;
+
+	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
+	tx->descp[last_desc].qw[1] |= dd->default_desc1;
 	if (tx->flags & SDMA_TXREQ_F_URGENT)
-		tx->descp[tx->num_desc].qw[1] |=
-			(SDMA_DESC1_HEAD_TO_HOST_FLAG |
-			 SDMA_DESC1_INT_REQ_FLAG);
+		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+					       SDMA_DESC1_INT_REQ_FLAG);
 }
 
 static inline int _sdma_txadd_daddr(
@@ -704,6 +703,7 @@ static inline int _sdma_txadd_daddr(
 		type,
 		addr, len);
 	WARN_ON(len > tx->tlen);
+	tx->num_desc++;
 	tx->tlen -= len;
 	/* special cases for last */
 	if (!tx->tlen) {
@@ -715,7 +715,6 @@ static inline int _sdma_txadd_daddr(
 			_sdma_close_tx(dd, tx);
 		}
 	}
-	tx->num_desc++;
 	return rval;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 87358b8c4558..b48596e174d6 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -554,15 +554,15 @@ static int set_qp_rss(struct mlx4_ib_dev *dev, struct mlx4_ib_rss *rss_ctx,
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
@@ -3463,11 +3463,11 @@ static int _mlx4_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	int nreq;
 	int err = 0;
 	unsigned ind;
-	int uninitialized_var(size);
-	unsigned uninitialized_var(seglen);
+	int size;
+	unsigned seglen;
 	__be32 dummy;
 	__be32 *lso_wqe;
-	__be32 uninitialized_var(lso_hdr_sz);
+	__be32 lso_hdr_sz;
 	__be32 blh;
 	int i;
 	struct mlx4_ib_dev *mdev = to_mdev(ibqp->device);
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 872985e4eebe..c5d3fe256182 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1333,7 +1333,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	__be64 *pas;
 	int page_shift;
 	int inlen;
-	int uninitialized_var(cqe_size);
+	int cqe_size;
 	unsigned long flags;
 
 	if (!MLX5_CAP_GEN(dev->mdev, cq_resize)) {
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 3d37f2373d63..a336f69c2653 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1630,8 +1630,8 @@ int mthca_tavor_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	 * without initializing f0 and size0, and they are in fact
 	 * never used uninitialized.
 	 */
-	int uninitialized_var(size0);
-	u32 uninitialized_var(f0);
+	int size0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
@@ -1831,7 +1831,7 @@ int mthca_tavor_post_receive(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	 * without initializing size0, and it is in fact never used
 	 * uninitialized.
 	 */
-	int uninitialized_var(size0);
+	int size0;
 	int ind;
 	void *wqe;
 	void *prev_wqe;
@@ -1945,8 +1945,8 @@ int mthca_arbel_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	 * without initializing f0 and size0, and they are in fact
 	 * never used uninitialized.
 	 */
-	int uninitialized_var(size0);
-	u32 uninitialized_var(f0);
+	int size0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 3695dd7dbb9b..ec0c91ec5227 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -811,8 +811,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	AC_WRITE(ac, POWER_CTL, 0);
 
 	err = request_threaded_irq(ac->irq, NULL, adxl34x_irq,
-				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-				   dev_name(dev), ac);
+				   IRQF_ONESHOT, dev_name(dev), ac);
 	if (err) {
 		dev_err(dev, "irq %d busy?\n", ac->irq);
 		goto err_free_mem;
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 17eb84ab4c0b..fe3fbde989be 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -443,6 +443,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 	}
 
 	do {
+		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
 		if (error) {
 			dev_err(&haptics->client->dev,
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 17b7fbecd9fe..d25059672323 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -162,7 +162,7 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer,
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
-	char uninitialized_var(c);
+	char c;
 	ssize_t read = 0;
 	int error;
 
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 31ea6332ecb8..60dc64b4ac6d 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -85,6 +85,7 @@ struct bcm6345_l1_chip {
 };
 
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -118,17 +119,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l1_chip *intc,
 
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
@@ -260,6 +255,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu)
 		return -ENOMEM;
 
+	cpu->intc = intc;
 	cpu->map_base = ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -275,7 +271,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 033bccb41455..b9dcc8e78c75 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int ret;
 
 	pr_info("Initializing J-Core AIC\n");
 
@@ -100,11 +101,17 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
-	domain = irq_domain_add_linear(node, dom_sz, &jcore_aic_irqdomain_ops,
+	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
+			      of_node_to_nid(node));
+
+	if (ret < 0)
+		return ret;
+
+	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
+				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
 	if (!domain)
 		return -ENOMEM;
-	irq_create_strict_mappings(domain, min_irq, min_irq, dom_sz - min_irq);
 
 	return 0;
 }
diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 01e9e462512b..eb1e9771037f 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -385,14 +385,20 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 		/* Ensure all unused data is 0 */
 		data_trail &= 0xFFFFFFFF >> (8 * (sizeof(u32) - trail_bytes));
 		writel(data_trail, data_reg);
-		data_reg++;
+		data_reg += sizeof(u32);
 	}
+
 	/*
 	 * 'data_reg' indicates next register to write. If we did not already
 	 * write on tx complete reg(last reg), we must do so for transmit
+	 * In addition, we also need to make sure all intermediate data
+	 * registers(if any required), are reset to 0 for TISCI backward
+	 * compatibility to be maintained.
 	 */
-	if (data_reg <= qinst->queue_buff_end)
-		writel(0, qinst->queue_buff_end);
+	while (data_reg <= qinst->queue_buff_end) {
+		writel(0, data_reg);
+		data_reg += sizeof(u32);
+	}
 
 	return 0;
 }
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 46794cac167e..5310e1f4a282 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -49,7 +49,7 @@
  *
  * bch_bucket_alloc() allocates a single bucket from a specific cache.
  *
- * bch_bucket_alloc_set() allocates one or more buckets from different caches
+ * bch_bucket_alloc_set() allocates one  bucket from different caches
  * out of a cache set.
  *
  * free_some_buckets() drives all the processes described above. It's called
@@ -488,34 +488,29 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k)
 }
 
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			   struct bkey *k, int n, bool wait)
+			   struct bkey *k, bool wait)
 {
-	int i;
+	struct cache *ca;
+	long b;
 
 	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
 	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags)))
 		return -1;
 
 	lockdep_assert_held(&c->bucket_lock);
-	BUG_ON(!n || n > c->caches_loaded || n > 8);
 
 	bkey_init(k);
 
-	/* sort by free space/prio of oldest data in caches */
-
-	for (i = 0; i < n; i++) {
-		struct cache *ca = c->cache_by_alloc[i];
-		long b = bch_bucket_alloc(ca, reserve, wait);
+	ca = c->cache_by_alloc[0];
+	b = bch_bucket_alloc(ca, reserve, wait);
+	if (b == -1)
+		goto err;
 
-		if (b == -1)
-			goto err;
+	k->ptr[0] = MAKE_PTR(ca->buckets[b].gen,
+			     bucket_to_sector(c, b),
+			     ca->sb.nr_this_dev);
 
-		k->ptr[i] = MAKE_PTR(ca->buckets[b].gen,
-				bucket_to_sector(c, b),
-				ca->sb.nr_this_dev);
-
-		SET_KEY_PTRS(k, i + 1);
-	}
+	SET_KEY_PTRS(k, 1);
 
 	return 0;
 err:
@@ -525,12 +520,12 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 }
 
 int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			 struct bkey *k, int n, bool wait)
+			 struct bkey *k, bool wait)
 {
 	int ret;
 
 	mutex_lock(&c->bucket_lock);
-	ret = __bch_bucket_alloc_set(c, reserve, k, n, wait);
+	ret = __bch_bucket_alloc_set(c, reserve, k, wait);
 	mutex_unlock(&c->bucket_lock);
 	return ret;
 }
@@ -638,7 +633,7 @@ bool bch_alloc_sectors(struct cache_set *c,
 
 		spin_unlock(&c->data_bucket_lock);
 
-		if (bch_bucket_alloc_set(c, watermark, &alloc.key, 1, wait))
+		if (bch_bucket_alloc_set(c, watermark, &alloc.key, wait))
 			return false;
 
 		spin_lock(&c->data_bucket_lock);
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 6a380ed4919a..e81d78310984 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -952,9 +952,9 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k);
 
 long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait);
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			   struct bkey *k, int n, bool wait);
+			   struct bkey *k, bool wait);
 int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			 struct bkey *k, int n, bool wait);
+			 struct bkey *k, bool wait);
 bool bch_alloc_sectors(struct cache_set *c, struct bkey *k,
 		       unsigned int sectors, unsigned int write_point,
 		       unsigned int write_prio, bool wait);
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index e388e7bb7b5d..71d670934a07 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1125,11 +1125,13 @@ struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 				     struct btree *parent)
 {
 	BKEY_PADDED(key) k;
-	struct btree *b = ERR_PTR(-EAGAIN);
+	struct btree *b;
 
 	mutex_lock(&c->bucket_lock);
 retry:
-	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, wait))
+	/* return ERR_PTR(-EAGAIN) when it fails */
+	b = ERR_PTR(-EAGAIN);
+	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, wait))
 		goto err;
 
 	bkey_put(c, &k.key);
@@ -1174,7 +1176,7 @@ static struct btree *btree_node_alloc_replacement(struct btree *b,
 {
 	struct btree *n = bch_btree_node_alloc(b->c, op, b->level, b->parent);
 
-	if (!IS_ERR_OR_NULL(n)) {
+	if (!IS_ERR(n)) {
 		mutex_lock(&n->write_lock);
 		bch_btree_sort_into(&b->keys, &n->keys, &b->c->sort);
 		bkey_copy_key(&n->key, &b->key);
@@ -1377,7 +1379,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1389,7 +1391,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 
 	for (i = 0; i < nodes; i++) {
 		new_nodes[i] = btree_node_alloc_replacement(r[i].b, NULL);
-		if (IS_ERR_OR_NULL(new_nodes[i]))
+		if (IS_ERR(new_nodes[i]))
 			goto out_nocoalesce;
 	}
 
@@ -1524,7 +1526,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			atomic_dec(&b->c->prio_blocked);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR_OR_NULL(new_nodes[i])) {
+		if (!IS_ERR(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
@@ -1706,7 +1708,7 @@ static int bch_btree_gc_root(struct btree *b, struct btree_op *op,
 	if (should_rewrite) {
 		n = btree_node_alloc_replacement(b, NULL);
 
-		if (!IS_ERR_OR_NULL(n)) {
+		if (!IS_ERR(n)) {
 			bch_btree_node_write_sync(n);
 
 			bch_btree_set_root(n);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2df75db52e91..4b076f7f184b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -423,7 +423,7 @@ static int __uuid_write(struct cache_set *c)
 	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
 
-	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, true))
+	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, true))
 		return 1;
 
 	SET_KEY_SIZE(&k.key, c->sb.bucket_size);
@@ -1576,7 +1576,7 @@ static void cache_set_flush(struct closure *cl)
 	if (!IS_ERR_OR_NULL(c->gc_thread))
 		kthread_stop(c->gc_thread);
 
-	if (!IS_ERR_OR_NULL(c->root))
+	if (!IS_ERR(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
 	/* Should skip this if we're unregistering because of an error */
@@ -1921,7 +1921,7 @@ static int run_cache_set(struct cache_set *c)
 
 		err = "cannot allocate new btree root";
 		c->root = __bch_btree_node_alloc(c, NULL, 0, true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		mutex_lock(&c->root->write_lock);
diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index 1b5b9ad9e492..6030193b216e 100644
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
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 81ffc59d05c9..4312007d2d34 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -306,7 +306,7 @@ static void do_region(int op, int op_flags, unsigned region,
 	struct request_queue *q = bdev_get_queue(where->bdev);
 	unsigned short logical_block_size = queue_logical_block_size(q);
 	sector_t num_sectors;
-	unsigned int uninitialized_var(special_cmd_max_sectors);
+	unsigned int special_cmd_max_sectors;
 
 	/*
 	 * Reject unsupported discard and write same requests.
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index e1603c17e346..88e89796ccbf 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1822,7 +1822,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	int ioctl_flags;
 	int param_flags;
 	unsigned int cmd;
-	struct dm_ioctl *uninitialized_var(param);
+	struct dm_ioctl *param;
 	ioctl_fn fn = NULL;
 	size_t input_param_size;
 	struct dm_ioctl param_kernel;
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5c45100f6d53..72aa5097b68f 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3289,15 +3289,19 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	/* Try to adjust the raid4/5/6 stripe cache size to the stripe size */
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
-		if (r)
+		if (r) {
+			mddev_unlock(&rs->md);
 			goto bad_stripe_cache;
+		}
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
-		if (r)
+		if (r) {
+			mddev_unlock(&rs->md);
 			goto bad_check_reshape;
+		}
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3306,6 +3310,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
+				mddev_unlock(&rs->md);
 				goto bad_check_reshape;
 			}
 		}
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 963d3774c93e..247089c2be25 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -613,7 +613,7 @@ static int persistent_read_metadata(struct dm_exception_store *store,
 						    chunk_t old, chunk_t new),
 				    void *callback_context)
 {
-	int r, uninitialized_var(new_snapshot);
+	int r, new_snapshot;
 	struct pstore *ps = get_info(store);
 
 	/*
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 71d3fdbce50a..3faaf21be5b6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -671,7 +671,7 @@ static int validate_hardware_logical_block_alignment(struct dm_table *table,
 	 */
 	unsigned short remaining = 0;
 
-	struct dm_target *uninitialized_var(ti);
+	struct dm_target *ti;
 	struct queue_limits ti_limits;
 	unsigned i;
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 1c4c46278719..7ca81e917aef 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -53,14 +53,7 @@ __acquires(bitmap->lock)
 {
 	unsigned char *mappage;
 
-	if (page >= bitmap->pages) {
-		/* This can happen if bitmap_start_sync goes beyond
-		 * End-of-device while looking for a whole page.
-		 * It is harmless.
-		 */
-		return -EINVAL;
-	}
-
+	WARN_ON_ONCE(page >= bitmap->pages);
 	if (bitmap->bp[page].hijacked) /* it's hijacked, don't try to alloc */
 		return 0;
 
@@ -1368,6 +1361,14 @@ __acquires(bitmap->lock)
 	sector_t csize;
 	int err;
 
+	if (page >= bitmap->pages) {
+		/*
+		 * This can happen if bitmap_start_sync goes beyond
+		 * End-of-device while looking for a whole page or
+		 * user set a huge number to sysfs bitmap_set_bits.
+		 */
+		return NULL;
+	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
 
 	if (bitmap->bp[page].hijacked ||
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f8c111b36992..6b074c2202d5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3671,8 +3671,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
 static ssize_t
 safe_delay_show(struct mddev *mddev, char *page)
 {
-	int msec = (mddev->safemode_delay*1000)/HZ;
-	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
+	unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
+
+	return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
 }
 static ssize_t
 safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
@@ -3684,7 +3685,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
@@ -4336,6 +4337,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
 	rv = kstrtouint(buf, 10, &n);
 	if (rv < 0)
 		return rv;
+	if (n > INT_MAX)
+		return -EINVAL;
 	atomic_set(&mddev->max_corr_read_errors, n);
 	return len;
 }
@@ -4636,11 +4639,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
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
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 252ef0eab41c..6f5710e833c1 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -296,6 +296,18 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		goto abort;
 	}
 
+	if (conf->layout == RAID0_ORIG_LAYOUT) {
+		for (i = 1; i < conf->nr_strip_zones; i++) {
+			sector_t first_sector = conf->strip_zone[i-1].zone_end;
+
+			sector_div(first_sector, mddev->chunk_sectors);
+			zone = conf->strip_zone + i;
+			/* disk_shift is first disk index used in the zone */
+			zone->disk_shift = sector_div(first_sector,
+						      zone->nb_dev);
+		}
+	}
+
 	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
 	*private_conf = conf;
 
@@ -482,6 +494,20 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
 	}
 }
 
+/*
+ * Convert disk_index to the disk order in which it is read/written.
+ *  For example, if we have 4 disks, they are numbered 0,1,2,3. If we
+ *  write the disks starting at disk 3, then the read/write order would
+ *  be disk 3, then 0, then 1, and then disk 2 and we want map_disk_shift()
+ *  to map the disks as follows 0,1,2,3 => 1,2,3,0. So disk 0 would map
+ *  to 1, 1 to 2, 2 to 3, and 3 to 0. That way we can compare disks in
+ *  that 'output' space to understand the read/write disk ordering.
+ */
+static int map_disk_shift(int disk_index, int num_disks, int disk_shift)
+{
+	return ((disk_index + num_disks - disk_shift) % num_disks);
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -495,7 +521,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -509,6 +537,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -520,13 +549,26 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	last_stripe_index = end;
 	sector_div(last_stripe_index, stripe_size);
 
-	start_disk_index = (int)(start - first_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
+	/* In the first zone the original and alternate layouts are the same */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) && (zone != conf->strip_zone)) {
+		sector_div(orig_start, mddev->chunk_sectors);
+		start_disk_index = sector_div(orig_start, zone->nb_dev);
+		start_disk_index = map_disk_shift(start_disk_index,
+						  zone->nb_dev,
+						  zone->disk_shift);
+		sector_div(orig_end, mddev->chunk_sectors);
+		end_disk_index = sector_div(orig_end, zone->nb_dev);
+		end_disk_index = map_disk_shift(end_disk_index,
+						zone->nb_dev, zone->disk_shift);
+	} else {
+		start_disk_index = (int)(start - first_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+		end_disk_index = (int)(end - last_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+	}
 	start_disk_offset = ((int)(start - first_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		first_stripe_index * mddev->chunk_sectors;
-	end_disk_index = (int)(end - last_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
 	end_disk_offset = ((int)(end - last_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		last_stripe_index * mddev->chunk_sectors;
@@ -535,18 +577,22 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		sector_t dev_start, dev_end;
 		struct bio *discard_bio = NULL;
 		struct md_rdev *rdev;
+		int compare_disk;
+
+		compare_disk = map_disk_shift(disk, zone->nb_dev,
+					      zone->disk_shift);
 
-		if (disk < start_disk_index)
+		if (compare_disk < start_disk_index)
 			dev_start = (first_stripe_index + 1) *
 				mddev->chunk_sectors;
-		else if (disk > start_disk_index)
+		else if (compare_disk > start_disk_index)
 			dev_start = first_stripe_index * mddev->chunk_sectors;
 		else
 			dev_start = start_disk_offset;
 
-		if (disk < end_disk_index)
+		if (compare_disk < end_disk_index)
 			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
-		else if (disk > end_disk_index)
+		else if (compare_disk > end_disk_index)
 			dev_end = last_stripe_index * mddev->chunk_sectors;
 		else
 			dev_end = end_disk_offset;
diff --git a/drivers/md/raid0.h b/drivers/md/raid0.h
index 3816e5477db1..8cc761ca7423 100644
--- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -6,6 +6,7 @@ struct strip_zone {
 	sector_t zone_end;	/* Start of the next zone (in sectors) */
 	sector_t dev_start;	/* Zone offset in real dev (in sectors) */
 	int	 nb_dev;	/* # of devices attached to the zone */
+	int	 disk_shift;	/* start disk for the original layout */
 };
 
 /* Linux 3.14 (20d0189b101) made an unintended change to
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f6d2be1d2386..bee694be2013 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -781,8 +781,16 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		disk = r10_bio->devs[slot].devnum;
 		rdev = rcu_dereference(conf->mirrors[disk].replacement);
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags) ||
-		    r10_bio->devs[slot].addr + sectors > rdev->recovery_offset)
+		    r10_bio->devs[slot].addr + sectors >
+		    rdev->recovery_offset) {
+			/*
+			 * Read replacement first to prevent reading both rdev
+			 * and replacement as NULL during replacement replace
+			 * rdev.
+			 */
+			smp_mb();
 			rdev = rcu_dereference(conf->mirrors[disk].rdev);
+		}
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags))
 			continue;
@@ -934,6 +942,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			else
 				generic_make_request(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1119,6 +1128,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		else
 			generic_make_request(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
@@ -1400,9 +1410,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 	for (i = 0;  i < conf->copies; i++) {
 		int d = r10_bio->devs[i].devnum;
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[d].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[d].replacement);
+		struct md_rdev *rdev, *rrdev;
+
+		rrdev = rcu_dereference(conf->mirrors[d].replacement);
+		/*
+		 * Read replacement first to prevent reading both rdev and
+		 * replacement as NULL during replacement replace rdev.
+		 */
+		smp_mb();
+		rdev = rcu_dereference(conf->mirrors[d].rdev);
 		if (rdev == rrdev)
 			rrdev = NULL;
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7eeae0301ccc..b98abe927d06 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2603,7 +2603,7 @@ static void raid5_end_write_request(struct bio *bi)
 	struct stripe_head *sh = bi->bi_private;
 	struct r5conf *conf = sh->raid_conf;
 	int disks = sh->disks, i;
-	struct md_rdev *uninitialized_var(rdev);
+	struct md_rdev *rdev;
 	sector_t first_bad;
 	int bad_sectors;
 	int replacement = 0;
diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 2f1f5cbaf03c..7cad4e985315 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -653,7 +653,7 @@ static int rtl2832_read_status(struct dvb_frontend *fe, enum fe_status *status)
 	struct i2c_client *client = dev->client;
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	int ret;
-	u32 uninitialized_var(tmp);
+	u32 tmp;
 	u8 u8tmp, buf[2];
 	u16 u16tmp;
 
diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
index 4565c06b1617..6d397cc85428 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -224,7 +224,7 @@ static int qt1010_set_params(struct dvb_frontend *fe)
 static int qt1010_init_meas1(struct qt1010_priv *priv,
 			     u8 oper, u8 reg, u8 reg_init_val, u8 *retval)
 {
-	u8 i, val1, uninitialized_var(val2);
+	u8 i, val1, val2;
 	int err;
 
 	qt1010_i2c_oper_t i2c_data[] = {
@@ -259,7 +259,7 @@ static int qt1010_init_meas1(struct qt1010_priv *priv,
 static int qt1010_init_meas2(struct qt1010_priv *priv,
 			    u8 reg_init_val, u8 *retval)
 {
-	u8 i, uninitialized_var(val);
+	u8 i, val;
 	int err;
 	qt1010_i2c_oper_t i2c_data[] = {
 		{ QT1010_WR, 0x07, reg_init_val },
diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 746926364535..8e914be5b7c5 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -210,7 +210,8 @@ static int az6007_rc_query(struct dvb_usb_device *d)
 	unsigned code;
 	enum rc_proto proto;
 
-	az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10);
+	if (az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10) < 0)
+		return -EIO;
 
 	if (st->data[1] == 0x44)
 		return 0;
diff --git a/drivers/media/usb/gspca/vicam.c b/drivers/media/usb/gspca/vicam.c
index 8562bda0ef88..624fdcfdc85a 100644
--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -234,7 +234,7 @@ static int sd_init(struct gspca_dev *gspca_dev)
 {
 	int ret;
 	const struct ihex_binrec *rec;
-	const struct firmware *uninitialized_var(fw);
+	const struct firmware *fw;
 	u8 *firmware_buf;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 2df3d730ea76..cd706874899c 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -190,7 +190,8 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
-		cancel_work_sync(&dev->surbs[i].wq);
+		if (dev->surbs[i].wq.func)
+			cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1c0249df5256..c57bc62251bb 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -802,9 +802,9 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	unsigned int header_size;
 	bool has_pts = false;
 	bool has_scr = false;
-	u16 uninitialized_var(scr_sof);
-	u32 uninitialized_var(scr_stc);
-	u32 uninitialized_var(pts);
+	u16 scr_sof;
+	u32 scr_stc;
+	u32 pts;
 
 	if (stream->stats.stream.nb_frames == 0 &&
 	    stream->stats.frame.nb_packets == 0)
@@ -1801,7 +1801,7 @@ static int uvc_init_video(struct uvc_streaming *stream, gfp_t gfp_flags)
 		struct usb_host_endpoint *best_ep = NULL;
 		unsigned int best_psize = UINT_MAX;
 		unsigned int bandwidth;
-		unsigned int uninitialized_var(altsetting);
+		unsigned int altsetting;
 		int intfnum = stream->intfnum;
 
 		/* Isochronous endpoint, select the alternate setting. */
diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 0610d3c9f131..9f65db9a69b3 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -316,7 +316,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 	}
 
 	while (length) {
-		unsigned int uninitialized_var(p_off);
+		unsigned int p_off;
 
 		if (host->req->long_data) {
 			pg = nth_page(sg_page(&host->req->sg),
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index edb1b5588b7a..6360f5c6d395 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -47,12 +47,10 @@ static const char *tpc_names[] = {
  * memstick_debug_get_tpc_name - debug helper that returns string for
  * a TPC number
  */
-const char *memstick_debug_get_tpc_name(int tpc)
+static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
 {
 	return tpc_names[tpc-1];
 }
-EXPORT_SYMBOL(memstick_debug_get_tpc_name);
-
 
 /* Read a register*/
 static inline u32 r592_read_reg(struct r592_device *dev, int address)
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index bed205849d02..ecd8d71f8a39 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -200,7 +200,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
 		host->block_pos);
 
 	while (length) {
-		unsigned int uninitialized_var(p_off);
+		unsigned int p_off;
 
 		if (host->req->long_data) {
 			pg = nth_page(sg_page(&host->req->sg),
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index fc44fb7c595b..281ef5f52eb5 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -92,6 +92,9 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!info->mem)
+		return -ENODEV;
+
 	info->irq = platform_get_irq(pdev, 0);
 
 	ret = intel_lpss_probe(&pdev->dev, info);
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 9bd089c56375..94cdad91c065 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -44,9 +44,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 722ad2c368a5..d752c56d60e4 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1428,9 +1428,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 int stmpe_remove(struct stmpe *stmpe)
 {
-	if (!IS_ERR(stmpe->vio))
+	if (!IS_ERR(stmpe->vio) && regulator_is_enabled(stmpe->vio))
 		regulator_disable(stmpe->vio);
-	if (!IS_ERR(stmpe->vcc))
+	if (!IS_ERR(stmpe->vcc) && regulator_is_enabled(stmpe->vcc))
 		regulator_disable(stmpe->vcc);
 
 	mfd_remove_devices(stmpe->dev);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 7d166f57f624..e5b05e11675b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -601,6 +601,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
@@ -785,6 +789,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	ida_simple_remove(&pci_endpoint_test_ida, id);
@@ -793,9 +800,6 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index d5bbe8e544de..e35c204cdac1 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -90,6 +90,20 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
 	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
 
+	/*
+	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	/*
+	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
 	/*
 	 *  On Some Kingston eMMCs, performing trim can result in
 	 *  unrecoverable data conrruption occasionally due to a firmware bug.
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 57be129fe4f3..b7afbeeca08a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -374,7 +374,7 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 {
 	unsigned long flags;
 	size_t blksize, len, chunk;
-	u32 uninitialized_var(scratch);
+	u32 scratch;
 	u8 *buf;
 
 	DBG("PIO reading\n");
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 8e132edbc5ce..d1066f635e4c 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -144,7 +144,7 @@ void __nand_calculate_ecc(const unsigned char *buf, unsigned int eccsize,
 	/* rp0..rp15..rp17 are the various accumulated parities (per byte) */
 	uint32_t rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
 	uint32_t rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15, rp16;
-	uint32_t uninitialized_var(rp17);	/* to make compiler happy */
+	uint32_t rp17;
 	uint32_t par;		/* the cumulative parity for all data */
 	uint32_t tmppar;	/* the cumulative parity for this iteration;
 				   for rp12, rp14 and rp16 at the end of the
diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 6736777a4156..02d174038312 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -184,17 +184,17 @@ static void elm_load_syndrome(struct elm_info *info,
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
@@ -204,35 +204,35 @@ static void elm_load_syndrome(struct elm_info *info,
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
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index cf045813c160..83d3e3cb77de 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -304,7 +304,7 @@ static int s3c2410_nand_setrate(struct s3c2410_nand_info *info)
 	int tacls_max = (info->cpu_type == TYPE_S3C2412) ? 8 : 4;
 	int tacls, twrph0, twrph1;
 	unsigned long clkrate = clk_get_rate(info->clk);
-	unsigned long uninitialized_var(set), cfg, uninitialized_var(mask);
+	unsigned long set, cfg, mask;
 	unsigned long flags;
 
 	/* calculate the timing information for the controller */
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 3e25421f22a2..fa6ff75459c6 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -612,7 +612,7 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
 	int err, pnum, scrub = 0, vol_id = vol->vol_id;
 	struct ubi_vid_io_buf *vidb;
 	struct ubi_vid_hdr *vid_hdr;
-	uint32_t uninitialized_var(crc);
+	uint32_t crc;
 
 	err = leb_read_lock(ubi, vol_id, lnum);
 	if (err)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e4adacb5c2c..47e02c5342b2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1128,6 +1128,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 02042cb09bd2..0e939a4cd999 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1455,7 +1455,7 @@ static int ican3_napi(struct napi_struct *napi, int budget)
 
 	/* process all communication messages */
 	while (true) {
-		struct ican3_msg uninitialized_var(msg);
+		struct ican3_msg msg;
 		ret = ican3_recv_msg(mod, &msg);
 		if (ret)
 			break;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 62ca4964a863..b2e48c8595f0 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -740,6 +740,8 @@ static int gs_can_close(struct net_device *netdev)
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(dev);
 	if (rc < 0)
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 3164aad29bcf..e4d58c7aeaf8 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1651,8 +1651,11 @@ static int atl1e_tso_csum(struct atl1e_adapter *adapter,
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
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 9993f1162ac6..c69700088082 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -1461,7 +1461,7 @@ bnx2_test_and_disable_2g5(struct bnx2 *bp)
 static void
 bnx2_enable_forced_2g5(struct bnx2 *bp)
 {
-	u32 uninitialized_var(bmcr);
+	u32 bmcr;
 	int err;
 
 	if (!(bp->phy_flags & BNX2_PHY_FLAG_2_5G_CAPABLE))
@@ -1505,7 +1505,7 @@ bnx2_enable_forced_2g5(struct bnx2 *bp)
 static void
 bnx2_disable_forced_2g5(struct bnx2 *bp)
 {
-	u32 uninitialized_var(bmcr);
+	u32 bmcr;
 	int err;
 
 	if (!(bp->phy_flags & BNX2_PHY_FLAG_2_5G_CAPABLE))
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 494601c39b84..9041a422dd15 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -620,5 +620,7 @@ void bcmgenet_mii_exit(struct net_device *dev)
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
+	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
+	clk_disable_unprepare(priv->clk);
 }
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 2cf144bbef3e..43b83a3a2804 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -235,6 +235,7 @@ MODULE_DESCRIPTION("Broadcom Tigon3 ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 MODULE_FIRMWARE(FIRMWARE_TG3);
+MODULE_FIRMWARE(FIRMWARE_TG357766);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO5);
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 8603df2ae173..d0d9a420f557 100644
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
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index a66492b9403c..5b82c89330e3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1798,7 +1798,7 @@ void i40e_dbg_pf_exit(struct i40e_pf *pf)
 void i40e_dbg_init(void)
 {
 	i40e_dbg_root = debugfs_create_dir(i40e_driver_name, NULL);
-	if (!i40e_dbg_root)
+	if (IS_ERR(i40e_dbg_root))
 		pr_info("init of debugfs failed\n");
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6f9d563deb6b..be5117908985 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9059,6 +9059,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (state == pci_channel_io_normal) {
+		dev_warn(&pdev->dev, "Non-correctable non-fatal error reported.\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
 	netif_device_detach(netdev);
 
 	if (state == pci_channel_io_perm_failure)
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f1a4b11ce0d1..512f9cd68070 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1415,7 +1415,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -3665,7 +3665,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 128a82b1dbfc..ad9db70eb879 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index fc880c02459d..c9ba97b400fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -471,8 +471,8 @@ void mlx5_core_req_pages_handler(struct mlx5_core_dev *dev, u16 func_id,
 
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
 {
-	u16 uninitialized_var(func_id);
-	s32 uninitialized_var(npages);
+	u16 func_id;
+	s32 npages;
 	int err;
 
 	err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e734bc5e3ceb..112d374e7166 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -80,6 +80,18 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
 				  !(data & HW_CFG_LRST_), 100000, 10000000);
 }
 
+static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
+					   int offset, u32 bit_mask,
+					   int target_value, int udelay_min,
+					   int udelay_max, int count)
+{
+	u32 data;
+
+	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
+					 target_value == !!(data & bit_mask),
+					 udelay_max, udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -675,8 +687,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -687,8 +699,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
+						    DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b42f81d0c6f0..f5272d2fcc7e 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -7291,7 +7291,7 @@ static int rx_osm_handler(struct ring_info *ring_data, struct RxD_t * rxdp)
 	int ring_no = ring_data->ring_no;
 	u16 l3_csum, l4_csum;
 	unsigned long long err = rxdp->Control_1 & RXD_T_CODE;
-	struct lro *uninitialized_var(lro);
+	struct lro *lro;
 	u8 err_mask;
 	struct swStat *swstats = &sp->mac_control.stats_info->sw_stat;
 
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 7a65a1534e41..d545593354c6 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3771,7 +3771,7 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	struct net_device *ndev = NULL;
 	struct ql3_adapter *qdev = NULL;
 	static int cards_found;
-	int uninitialized_var(pci_using_dac), err;
+	int pci_using_dac, err;
 
 	err = pci_enable_device(pdev);
 	if (err) {
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 909f6d1605f7..861d1f6d7508 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -2291,7 +2291,7 @@ static int cas_rx_ringN(struct cas *cp, int ring, int budget)
 	drops = 0;
 	while (1) {
 		struct cas_rx_comp *rxc = rxcs + entry;
-		struct sk_buff *uninitialized_var(skb);
+		struct sk_buff *skb;
 		int type, len;
 		u64 words[4];
 		int i, dring;
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 1693a70325c5..1c13c08c4f96 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -429,7 +429,7 @@ static int serdes_init_niu_1g_serdes(struct niu *np)
 	struct niu_link_config *lp = &np->link_config;
 	u16 pll_cfg, pll_sts;
 	int max_retry = 100;
-	u64 uninitialized_var(sig), mask, val;
+	u64 sig, mask, val;
 	u32 tx_cfg, rx_cfg;
 	unsigned long i;
 	int err;
@@ -526,7 +526,7 @@ static int serdes_init_niu_10g_serdes(struct niu *np)
 	struct niu_link_config *lp = &np->link_config;
 	u32 tx_cfg, rx_cfg, pll_cfg, pll_sts;
 	int max_retry = 100;
-	u64 uninitialized_var(sig), mask, val;
+	u64 sig, mask, val;
 	unsigned long i;
 	int err;
 
@@ -714,7 +714,7 @@ static int esr_write_glue0(struct niu *np, unsigned long chan, u32 val)
 
 static int esr_reset(struct niu *np)
 {
-	u32 uninitialized_var(reset);
+	u32 reset;
 	int err;
 
 	err = mdio_write(np, np->port, NIU_ESR_DEV_ADDR,
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index c245629a38c7..6cb98760bc84 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -67,23 +67,37 @@
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index e18d06cb2173..2718b0507f71 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -301,7 +301,9 @@ static void __gtp_encap_destroy(struct sock *sk)
 			gtp->sk1u = NULL;
 		udp_sk(sk)->encap_type = 0;
 		rcu_assign_sk_user_data(sk, NULL);
+		release_sock(sk);
 		sock_put(sk);
+		return;
 	}
 	release_sock(sk);
 }
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index eb80d277b56f..6b6c5a7250a6 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -592,7 +592,8 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
 				consume_skb(skb);
 				return NET_XMIT_DROP;
 			}
-			return ipvlan_rcv_frame(addr, &skb, true);
+			ipvlan_rcv_frame(addr, &skb, true);
+			return NET_XMIT_SUCCESS;
 		}
 	}
 out:
@@ -618,7 +619,8 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 					consume_skb(skb);
 					return NET_XMIT_DROP;
 				}
-				return ipvlan_rcv_frame(addr, &skb, true);
+				ipvlan_rcv_frame(addr, &skb, true);
+				return NET_XMIT_SUCCESS;
 			}
 		}
 		skb = skb_share_check(skb, GFP_ATOMIC);
@@ -630,7 +632,8 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 		 * the skb for the main-dev. At the RX side we just return
 		 * RX_PASS for it to be processed further on the stack.
 		 */
-		return dev_forward_skb(ipvlan->phy_dev, skb);
+		dev_forward_skb(ipvlan->phy_dev, skb);
+		return NET_XMIT_SUCCESS;
 
 	} else if (is_multicast_ether_addr(eth->h_dest)) {
 		skb_reset_mac_header(skb);
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 2410f08e2bb5..d80bc5f59b3f 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2103,6 +2103,15 @@ static void team_setup_by_port(struct net_device *dev,
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
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 17b932505be0..e2ce3c5541ba 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -618,9 +618,23 @@ static const struct usb_device_id	products[] = {
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
@@ -628,6 +642,13 @@ static const struct usb_device_id	products[] = {
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
index 2263a66f6314..f7f037b399a7 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1767,6 +1767,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
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
@@ -1776,6 +1780,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		else
 			status = 0;
 
+		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
+			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
 		status = init_status (dev, udev);
diff --git a/drivers/net/usb/zaurus.c b/drivers/net/usb/zaurus.c
index 1f19fc5e6117..9a6ab75752e1 100644
--- a/drivers/net/usb/zaurus.c
+++ b/drivers/net/usb/zaurus.c
@@ -301,9 +301,23 @@ static const struct usb_device_id	products [] = {
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
@@ -311,6 +325,13 @@ static const struct usb_device_id	products [] = {
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
index d45e8de79f28..03e0f8060cc2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3120,6 +3120,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3140,8 +3142,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
diff --git a/drivers/net/wan/z85230.c b/drivers/net/wan/z85230.c
index deea41e96f01..96025d42b0ee 100644
--- a/drivers/net/wan/z85230.c
+++ b/drivers/net/wan/z85230.c
@@ -705,7 +705,7 @@ EXPORT_SYMBOL(z8530_nop);
 irqreturn_t z8530_interrupt(int irq, void *dev_id)
 {
 	struct z8530_dev *dev=dev_id;
-	u8 uninitialized_var(intr);
+	u8 intr;
 	static volatile int locker=0;
 	int work=0;
 	struct z8530_irqhandler *irqs;
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 436eac342b62..7e43d449131d 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1891,7 +1891,7 @@ static int ath10k_init_uart(struct ath10k *ar)
 
 static int ath10k_init_hw_params(struct ath10k *ar)
 {
-	const struct ath10k_hw_params *uninitialized_var(hw_params);
+	const struct ath10k_hw_params *hw_params;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ath10k_hw_params_list); i++) {
diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 58fb227a849f..49b93a5b7a72 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1575,7 +1575,7 @@ static int ath6kl_init_upload(struct ath6kl *ar)
 
 int ath6kl_init_hw_params(struct ath6kl *ar)
 {
-	const struct ath6kl_hw *uninitialized_var(hw);
+	const struct ath6kl_hw *hw;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
index 2fe12b0de5b4..dea8a998fb62 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *ah, unsigned int queue)
 {
 	u32 dma_dbg_chain, dma_dbg_complete;
 	u8 dcu_chain_state, dcu_complete_state;
+	unsigned int dbg_reg, reg_offset;
 	int i;
 
-	for (i = 0; i < NUM_STATUS_READS; i++) {
-		if (queue < 6)
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_4);
-		else
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_5);
+	if (queue < 6) {
+		dbg_reg = AR_DMADBG_4;
+		reg_offset = queue * 5;
+	} else {
+		dbg_reg = AR_DMADBG_5;
+		reg_offset = (queue - 6) * 5;
+	}
 
+	for (i = 0; i < NUM_STATUS_READS; i++) {
+		dma_dbg_chain = REG_READ(ah, dbg_reg);
 		dma_dbg_complete = REG_READ(ah, AR_DMADBG_6);
 
-		dcu_chain_state = (dma_dbg_chain >> (5 * queue)) & 0x1f;
+		dcu_chain_state = (dma_dbg_chain >> reg_offset) & 0x1f;
 		dcu_complete_state = dma_dbg_complete & 0x3;
 
 		if ((dcu_chain_state != 0x6) || (dcu_complete_state != 0x1))
@@ -1128,6 +1133,7 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 	u8 dcu_chain_state, dcu_complete_state;
 	bool dcu_wait_frdone = false;
 	unsigned long chk_dcu = 0;
+	unsigned int reg_offset;
 	unsigned int i = 0;
 
 	dma_dbg_4 = REG_READ(ah, AR_DMADBG_4);
@@ -1139,12 +1145,15 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 		goto exit;
 
 	for (i = 0; i < ATH9K_NUM_TX_QUEUES; i++) {
-		if (i < 6)
+		if (i < 6) {
 			chk_dbg = dma_dbg_4;
-		else
+			reg_offset = i * 5;
+		} else {
 			chk_dbg = dma_dbg_5;
+			reg_offset = (i - 6) * 5;
+		}
 
-		dcu_chain_state = (chk_dbg >> (5 * i)) & 0x1f;
+		dcu_chain_state = (chk_dbg >> reg_offset) & 0x1f;
 		if (dcu_chain_state == 0x6) {
 			dcu_wait_frdone = true;
 			chk_dcu |= BIT(i);
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 6331c98088e0..d5e5f9cf4ca8 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -114,7 +114,13 @@ static void htc_process_conn_rsp(struct htc_target *target,
 
 	if (svc_rspmsg->status == HTC_SERVICE_SUCCESS) {
 		epid = svc_rspmsg->endpoint_id;
-		if (epid < 0 || epid >= ENDPOINT_MAX)
+
+		/* Check that the received epid for the endpoint to attach
+		 * a new service is valid. ENDPOINT0 can't be used here as it
+		 * is already reserved for HTC_CTRL_RSVD_SVC service and thus
+		 * should not be modified.
+		 */
+		if (epid <= ENDPOINT0 || epid >= ENDPOINT_MAX)
 			return;
 
 		service_id = be16_to_cpu(svc_rspmsg->service_id);
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index fae572b38416..922a3f208837 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -230,7 +230,7 @@ static unsigned int ath9k_reg_rmw(void *hw_priv, u32 reg_offset, u32 set, u32 cl
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath_softc *sc = (struct ath_softc *) common->priv;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	u32 val;
 
 	if (NR_CPUS > 1 && ah->config.serialize_regmode == SER_REG_MODE_ON) {
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index ee1b9c39bad7..2fdf9858a73d 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -200,7 +200,7 @@ void ath_cancel_work(struct ath_softc *sc)
 void ath_restart_work(struct ath_softc *sc)
 {
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 
 	if (AR_SREV_9340(sc->sc_ah) || AR_SREV_9330(sc->sc_ah))
 		ieee80211_queue_delayed_work(sc->hw, &sc->hw_pll_work,
@@ -847,7 +847,7 @@ static bool ath9k_txq_list_has_key(struct list_head *txq_list, u32 keyix)
 static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 {
 	struct ath_hw *ah = sc->sc_ah;
-	int i;
+	int i, j;
 	struct ath_txq *txq;
 	bool key_in_use = false;
 
@@ -865,8 +865,9 @@ static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 		if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
 			int idx = txq->txq_tailidx;
 
-			while (!key_in_use &&
-			       !list_empty(&txq->txq_fifo[idx])) {
+			for (j = 0; !key_in_use &&
+			     !list_empty(&txq->txq_fifo[idx]) &&
+			     j < ATH_TXFIFO_DEPTH; j++) {
 				key_in_use = ath9k_txq_list_has_key(
 					&txq->txq_fifo[idx], keyix);
 				INCR(idx, ATH_TXFIFO_DEPTH);
@@ -2227,7 +2228,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
 	}
 
 	ieee80211_queue_delayed_work(hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 }
 
 static bool ath9k_tx_frames_pending(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index e4ea6f5cc78a..5e2a610df61c 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -218,6 +218,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	/* Validate the obtained SKB. */
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/net/wireless/atmel/atmel_cs.c
index 7afc9c5329fb..f5fa1a95b0c1 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -73,6 +73,7 @@ struct local_info {
 static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	struct local_info *local;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "atmel_attach()\n");
 
@@ -83,8 +84,16 @@ static int atmel_probe(struct pcmcia_device *p_dev)
 
 	p_dev->priv = local;
 
-	return atmel_config(p_dev);
-} /* atmel_attach */
+	ret = atmel_config(p_dev);
+	if (ret)
+		goto err_free_priv;
+
+	return 0;
+
+err_free_priv:
+	kfree(p_dev->priv);
+	return ret;
+}
 
 static void atmel_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/broadcom/b43/debugfs.c b/drivers/net/wireless/broadcom/b43/debugfs.c
index 77046384dd80..70b02d664170 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -506,7 +506,7 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 	struct b43_wldev *dev;
 	struct b43_debugfs_fops *dfops;
 	struct b43_dfs_file *dfile;
-	ssize_t uninitialized_var(ret);
+	ssize_t ret;
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 kiB buffer */
 	const size_t buforder = get_order(bufsize);
diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index d46d57b989ae..06139835055f 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -50,7 +50,7 @@
 static u32 b43_dma_address(struct b43_dma *dma, dma_addr_t dmaaddr,
 			   enum b43_addrtype addrtype)
 {
-	u32 uninitialized_var(addr);
+	u32 addr;
 
 	switch (addrtype) {
 	case B43_DMA_ADDR_LOW:
diff --git a/drivers/net/wireless/broadcom/b43/lo.c b/drivers/net/wireless/broadcom/b43/lo.c
index a335f94c72ff..10cc0c0d70c3 100644
--- a/drivers/net/wireless/broadcom/b43/lo.c
+++ b/drivers/net/wireless/broadcom/b43/lo.c
@@ -742,7 +742,7 @@ struct b43_lo_calib *b43_calibrate_lo_setting(struct b43_wldev *dev,
 	};
 	int max_rx_gain;
 	struct b43_lo_calib *cal;
-	struct lo_g_saved_values uninitialized_var(saved_regs);
+	struct lo_g_saved_values saved_regs;
 	/* Values from the "TXCTL Register and Value Table" */
 	u16 txctl_reg;
 	u16 txctl_value;
diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index 3508a7822619..3a74e82c9fb6 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -5655,7 +5655,7 @@ static int b43_nphy_rev2_cal_rx_iq(struct b43_wldev *dev,
 	u8 rfctl[2];
 	u8 afectl_core;
 	u16 tmp[6];
-	u16 uninitialized_var(cur_hpf1), uninitialized_var(cur_hpf2), cur_lna;
+	u16 cur_hpf1, cur_hpf2, cur_lna;
 	u32 real, imag;
 	enum nl80211_band band;
 
diff --git a/drivers/net/wireless/broadcom/b43/xmit.c b/drivers/net/wireless/broadcom/b43/xmit.c
index 1b9c191e2a22..c123e2204663 100644
--- a/drivers/net/wireless/broadcom/b43/xmit.c
+++ b/drivers/net/wireless/broadcom/b43/xmit.c
@@ -435,10 +435,10 @@ int b43_generate_txhdr(struct b43_wldev *dev,
 	if ((rates[0].flags & IEEE80211_TX_RC_USE_RTS_CTS) ||
 	    (rates[0].flags & IEEE80211_TX_RC_USE_CTS_PROTECT)) {
 		unsigned int len;
-		struct ieee80211_hdr *uninitialized_var(hdr);
+		struct ieee80211_hdr *hdr;
 		int rts_rate, rts_rate_fb;
 		int rts_rate_ofdm, rts_rate_fb_ofdm;
-		struct b43_plcp_hdr6 *uninitialized_var(plcp);
+		struct b43_plcp_hdr6 *plcp;
 		struct ieee80211_rate *rts_cts_rate;
 
 		rts_cts_rate = ieee80211_get_rts_cts_rate(dev->wl->hw, info);
@@ -449,7 +449,7 @@ int b43_generate_txhdr(struct b43_wldev *dev,
 		rts_rate_fb_ofdm = b43_is_ofdm_rate(rts_rate_fb);
 
 		if (rates[0].flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
-			struct ieee80211_cts *uninitialized_var(cts);
+			struct ieee80211_cts *cts;
 
 			switch (dev->fw.hdr_format) {
 			case B43_FW_HDR_598:
@@ -471,7 +471,7 @@ int b43_generate_txhdr(struct b43_wldev *dev,
 			mac_ctl |= B43_TXH_MAC_SENDCTS;
 			len = sizeof(struct ieee80211_cts);
 		} else {
-			struct ieee80211_rts *uninitialized_var(rts);
+			struct ieee80211_rts *rts;
 
 			switch (dev->fw.hdr_format) {
 			case B43_FW_HDR_598:
@@ -663,8 +663,8 @@ void b43_rx(struct b43_wldev *dev, struct sk_buff *skb, const void *_rxhdr)
 	const struct b43_rxhdr_fw4 *rxhdr = _rxhdr;
 	__le16 fctl;
 	u16 phystat0, phystat3;
-	u16 uninitialized_var(chanstat), uninitialized_var(mactime);
-	u32 uninitialized_var(macstat);
+	u16 chanstat, mactime;
+	u32 macstat;
 	u16 chanid;
 	int padding, rate_idx;
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 82ef56ed7ca1..d3c9a916b44c 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -203,7 +203,7 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 	struct b43legacy_wldev *dev;
 	struct b43legacy_debugfs_fops *dfops;
 	struct b43legacy_dfs_file *dfile;
-	ssize_t uninitialized_var(ret);
+	ssize_t ret;
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 KiB buffer */
 	const size_t buforder = get_order(bufsize);
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index ef1f1b5d63b1..a147c93583b2 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -2612,7 +2612,7 @@ static void b43legacy_put_phy_into_reset(struct b43legacy_wldev *dev)
 static int b43legacy_switch_phymode(struct b43legacy_wl *wl,
 				      unsigned int new_mode)
 {
-	struct b43legacy_wldev *uninitialized_var(up_dev);
+	struct b43legacy_wldev *up_dev;
 	struct b43legacy_wldev *down_dev;
 	int err;
 	bool gmode = false;
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 5a6ee0b014da..a01b42c7c07a 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6100,8 +6100,11 @@ static int airo_get_rate(struct net_device *dev,
 {
 	struct airo_info *local = dev->ml_priv;
 	StatusRid status_rid;		/* Card status info */
+	int ret;
 
-	readStatusRid(local, &status_rid, 1);
+	ret = readStatusRid(local, &status_rid, 1);
+	if (ret)
+		return -EBUSY;
 
 	vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
 	/* If more than one rate, set auto */
diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index 3e568ce2fb20..6703ce95e640 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -2115,7 +2115,7 @@ il3945_txpower_set_from_eeprom(struct il_priv *il)
 
 		/* set tx power value for all OFDM rates */
 		for (rate_idx = 0; rate_idx < IL_OFDM_RATES; rate_idx++) {
-			s32 uninitialized_var(power_idx);
+			s32 power_idx;
 			int rc;
 
 			/* use channel group's clip-power table,
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 4970c19df582..2b60473e7bf9 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -2784,7 +2784,7 @@ il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
 	struct ieee80211_tx_info *info;
 	struct il4965_tx_resp *tx_resp = (void *)&pkt->u.raw[0];
 	u32 status = le32_to_cpu(tx_resp->u.status);
-	int uninitialized_var(tid);
+	int tid;
 	int sta_id;
 	int freed;
 	u8 *qc = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 373ace38edab..83883ce7f55d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2237,7 +2237,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
index a956f965a1e5..03bfd2482656 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
@@ -96,6 +96,7 @@ orinoco_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				orinoco_cs_hard_reset, NULL);
@@ -107,8 +108,16 @@ orinoco_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return orinoco_cs_config(link);
-}				/* orinoco_cs_attach */
+	ret = orinoco_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void orinoco_cs_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
index b60048c95e0a..011c86e55923 100644
--- a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
@@ -157,6 +157,7 @@ spectrum_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				spectrum_cs_hard_reset,
@@ -169,8 +170,16 @@ spectrum_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return spectrum_cs_config(link);
-}				/* spectrum_cs_attach */
+	ret = spectrum_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void spectrum_cs_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index c9f6cd291969..4f0e78ae3dbd 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2208,9 +2208,9 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 
 	if (nd_config) {
 		adapter->nd_info =
-			kzalloc(sizeof(struct cfg80211_wowlan_nd_match) +
-				sizeof(struct cfg80211_wowlan_nd_match *) *
-				scan_rsp->number_of_sets, GFP_ATOMIC);
+			kzalloc(struct_size(adapter->nd_info, matches,
+					    scan_rsp->number_of_sets),
+				GFP_ATOMIC);
 
 		if (adapter->nd_info)
 			adapter->nd_info->n_matches = scan_rsp->number_of_sets;
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 8704bae39e1b..edc990d09978 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -282,13 +282,14 @@ static int ray_probe(struct pcmcia_device *p_dev)
 {
 	ray_dev_t *local;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "ray_attach()\n");
 
 	/* Allocate space for private device-specific data */
 	dev = alloc_etherdev(sizeof(ray_dev_t));
 	if (!dev)
-		goto fail_alloc_dev;
+		return -ENOMEM;
 
 	local = netdev_priv(dev);
 	local->finder = p_dev;
@@ -325,11 +326,16 @@ static int ray_probe(struct pcmcia_device *p_dev)
 	timer_setup(&local->timer, NULL, 0);
 
 	this_device = p_dev;
-	return ray_config(p_dev);
+	ret = ray_config(p_dev);
+	if (ret)
+		goto err_free_dev;
+
+	return 0;
 
-fail_alloc_dev:
-	return -ENOMEM;
-} /* ray_attach */
+err_free_dev:
+	free_netdev(dev);
+	return ret;
+}
 
 static void ray_detach(struct pcmcia_device *link)
 {
@@ -1651,38 +1657,34 @@ static void authenticate_timeout(struct timer_list *t)
 /*===========================================================================*/
 static int parse_addr(char *in_str, UCHAR *out)
 {
+	int i, k;
 	int len;
-	int i, j, k;
-	int status;
 
 	if (in_str == NULL)
 		return 0;
-	if ((len = strlen(in_str)) < 2)
+	len = strnlen(in_str, ADDRLEN * 2 + 1) - 1;
+	if (len < 1)
 		return 0;
 	memset(out, 0, ADDRLEN);
 
-	status = 1;
-	j = len - 1;
-	if (j > 12)
-		j = 12;
 	i = 5;
 
-	while (j > 0) {
-		if ((k = hex_to_bin(in_str[j--])) != -1)
+	while (len > 0) {
+		if ((k = hex_to_bin(in_str[len--])) != -1)
 			out[i] = k;
 		else
 			return 0;
 
-		if (j == 0)
+		if (len == 0)
 			break;
-		if ((k = hex_to_bin(in_str[j--])) != -1)
+		if ((k = hex_to_bin(in_str[len--])) != -1)
 			out[i] += k << 4;
 		else
 			return 0;
 		if (!i--)
 			break;
 	}
-	return status;
+	return 1;
 }
 
 /*===========================================================================*/
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 48efe83c58d8..409a3e830576 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1368,9 +1368,6 @@ static void rsi_shutdown(struct device *dev)
 	if (sdev->write_fail)
 		rsi_dbg(INFO_ZONE, "###### Device is not ready #######\n");
 
-	if (rsi_set_sdio_pm_caps(adapter))
-		rsi_dbg(INFO_ZONE, "Setting power management caps failed\n");
-
 	rsi_dbg(INFO_ZONE, "***** RSI module shut down *****\n");
 }
 
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index cfde9b94b4b6..4380c5d8fdd2 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -133,8 +133,8 @@ static const struct {
 
 /**
  * iw_valid_channel - validate channel in regulatory domain
- * @reg_comain - regulatory domain
- * @channel - channel to validate
+ * @reg_domain: regulatory domain
+ * @channel: channel to validate
  *
  * Returns 0 if invalid in the specified regulatory domain, non-zero if valid.
  */
@@ -153,7 +153,7 @@ static int iw_valid_channel(int reg_domain, int channel)
 
 /**
  * iw_default_channel - get default channel for a regulatory domain
- * @reg_comain - regulatory domain
+ * @reg_domain: regulatory domain
  *
  * Returns the default channel for a regulatory domain
  */
@@ -236,6 +236,7 @@ static int wl3501_get_flash_mac_addr(struct wl3501_card *this)
 
 /**
  * wl3501_set_to_wla - Move 'size' bytes from PC to card
+ * @this: Card
  * @dest: Card addressing space
  * @src: PC addressing space
  * @size: Bytes to move
@@ -258,6 +259,7 @@ static void wl3501_set_to_wla(struct wl3501_card *this, u16 dest, void *src,
 
 /**
  * wl3501_get_from_wla - Move 'size' bytes from card to PC
+ * @this: Card
  * @src: Card addressing space
  * @dest: PC addressing space
  * @size: Bytes to move
@@ -454,12 +456,10 @@ static int wl3501_pwr_mgmt(struct wl3501_card *this, int suspend)
 
 /**
  * wl3501_send_pkt - Send a packet.
- * @this - card
- *
- * Send a packet.
- *
- * data = Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
+ * @this: Card
+ * @data: Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
  *                                   data[6] - data[11] is Src MAC Addr)
+ * @len: Packet length
  * Ref: IEEE 802.11
  */
 static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
@@ -722,7 +722,7 @@ static void wl3501_mgmt_scan_confirm(struct wl3501_card *this, u16 addr)
 
 /**
  * wl3501_block_interrupt - Mask interrupt from SUTRO
- * @this - card
+ * @this: Card
  *
  * Mask interrupt from SUTRO. (i.e. SUTRO cannot interrupt the HOST)
  * Return: 1 if interrupt is originally enabled
@@ -739,7 +739,7 @@ static int wl3501_block_interrupt(struct wl3501_card *this)
 
 /**
  * wl3501_unblock_interrupt - Enable interrupt from SUTRO
- * @this - card
+ * @this: Card
  *
  * Enable interrupt from SUTRO. (i.e. SUTRO can interrupt the HOST)
  * Return: 1 if interrupt is originally enabled
@@ -1113,8 +1113,8 @@ static inline void wl3501_ack_interrupt(struct wl3501_card *this)
 
 /**
  * wl3501_interrupt - Hardware interrupt from card.
- * @irq - Interrupt number
- * @dev_id - net_device
+ * @irq: Interrupt number
+ * @dev_id: net_device
  *
  * We must acknowledge the interrupt as soon as possible, and block the
  * interrupt from the same card immediately to prevent re-entry.
@@ -1252,7 +1252,7 @@ static int wl3501_close(struct net_device *dev)
 
 /**
  * wl3501_reset - Reset the SUTRO.
- * @dev - network device
+ * @dev: network device
  *
  * It is almost the same as wl3501_open(). In fact, we may just wl3501_close()
  * and wl3501_open() again, but I wouldn't like to free_irq() when the driver
@@ -1415,7 +1415,7 @@ static struct iw_statistics *wl3501_get_wireless_stats(struct net_device *dev)
 
 /**
  * wl3501_detach - deletes a driver "instance"
- * @link - FILL_IN
+ * @link: FILL_IN
  *
  * This deletes a driver "instance". The device is de-registered with Card
  * Services. If it has been released, all local data structures are freed.
@@ -1436,9 +1436,7 @@ static void wl3501_detach(struct pcmcia_device *link)
 	wl3501_release(link);
 
 	unregister_netdev(dev);
-
-	if (link->priv)
-		free_netdev(link->priv);
+	free_netdev(dev);
 }
 
 static int wl3501_get_name(struct net_device *dev, struct iw_request_info *info,
@@ -1865,6 +1863,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
+	int ret;
 
 	/* The io structure describes IO port mapping */
 	p_dev->resource[0]->end	= 16;
@@ -1876,8 +1875,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 
 	dev = alloc_etherdev(sizeof(struct wl3501_card));
 	if (!dev)
-		goto out_link;
-
+		return -ENOMEM;
 
 	dev->netdev_ops		= &wl3501_netdev_ops;
 	dev->watchdog_timeo	= 5 * HZ;
@@ -1890,9 +1888,15 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 	netif_stop_queue(dev);
 	p_dev->priv = dev;
 
-	return wl3501_config(p_dev);
-out_link:
-	return -ENOMEM;
+	ret = wl3501_config(p_dev);
+	if (ret)
+		goto out_free_etherdev;
+
+	return 0;
+
+out_free_etherdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static int wl3501_config(struct pcmcia_device *link)
@@ -1948,8 +1952,7 @@ static int wl3501_config(struct pcmcia_device *link)
 		goto failed;
 	}
 
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = ((char *)&this->mac_addr)[i];
+	eth_hw_addr_set(dev, this->mac_addr);
 
 	/* print probe information */
 	printk(KERN_INFO "%s: wl3501 @ 0x%3.3x, IRQ %d, "
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 0b1fbb5dba9b..7de761680393 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1139,12 +1139,17 @@ static struct pci_driver amd_ntb_pci_driver = {
 
 static int __init amd_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&amd_ntb_pci_driver);
+	ret = pci_register_driver(&amd_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(amd_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index a67ef23e81bc..82e08f583980 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2692,6 +2692,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2699,7 +2700,11 @@ static int __init idt_pci_driver_init(void)
 		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
-	return pci_register_driver(&idt_pci_driver);
+	ret = pci_register_driver(&idt_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(dbgfs_topdir);
+
+	return ret;
 }
 module_init(idt_pci_driver_init);
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 2ad263f708da..084bd1d1ac1d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -2052,12 +2052,17 @@ static struct pci_driver intel_ntb_pci_driver = {
 
 static int __init intel_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&intel_ntb_pci_driver);
+	ret = pci_register_driver(&intel_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(intel_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 939895966476..2d647a1cd0ee 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -393,7 +393,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 6301aa413c3b..1f6414654622 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
 		tc->peers[pidx].outmws =
 			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
 				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+		if (tc->peers[pidx].outmws == NULL)
+			return -ENOMEM;
 
 		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
 			tc->peers[pidx].outmws[widx].pidx = pidx;
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 133fad284c9f..ea0cd2401d6b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -758,6 +758,8 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->phy_ahb_reset))
 		return PTR_ERR(res->phy_ahb_reset);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 06dd2ab73b6e..4d3a589af129 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -124,6 +124,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 					 struct pci_epf_header *hdr)
 {
+	u32 reg;
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
@@ -136,8 +137,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
-	rockchip_pcie_write(rockchip, hdr->deviceid << 16,
-			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_VENDOR_ID);
+	reg = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_DID_VID);
+	reg = (reg & 0xFFFF) | (hdr->deviceid << 16);
+	rockchip_pcie_write(rockchip, reg, PCIE_EP_CONFIG_DID_VID);
 
 	rockchip_pcie_write(rockchip,
 			    hdr->revid |
@@ -311,15 +313,15 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
 				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK;
 	flags |=
-	   ((multi_msg_cap << 1) <<  ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
-	   PCI_MSI_FLAGS_64BIT;
+	   (multi_msg_cap << ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
+	   (PCI_MSI_FLAGS_64BIT << ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP;
 	rockchip_pcie_write(rockchip, flags,
 			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -331,7 +333,7 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -344,48 +346,25 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 }
 
 static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
-					 u8 intx, bool is_asserted)
+					 u8 intx, bool do_assert)
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u32 r = ep->max_regions - 1;
-	u32 offset;
-	u32 status;
-	u8 msg_code;
-
-	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
-		     ep->irq_pci_fn != fn)) {
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
-					     AXI_WRAPPER_NOR_MSG,
-					     ep->irq_phys_addr, 0, 0);
-		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;
-		ep->irq_pci_fn = fn;
-	}
 
 	intx &= 3;
-	if (is_asserted) {
+
+	if (do_assert) {
 		ep->irq_pending |= BIT(intx);
-		msg_code = ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA + intx;
+		rockchip_pcie_write(rockchip,
+				    PCIE_CLIENT_INT_IN_ASSERT |
+				    PCIE_CLIENT_INT_PEND_ST_PEND,
+				    PCIE_CLIENT_LEGACY_INT_CTRL);
 	} else {
 		ep->irq_pending &= ~BIT(intx);
-		msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;
+		rockchip_pcie_write(rockchip,
+				    PCIE_CLIENT_INT_IN_DEASSERT |
+				    PCIE_CLIENT_INT_PEND_ST_NORMAL,
+				    PCIE_CLIENT_LEGACY_INT_CTRL);
 	}
-
-	status = rockchip_pcie_read(rockchip,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	status &= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-
-	if ((status != 0) ^ (ep->irq_pending != 0)) {
-		status ^= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-		rockchip_pcie_write(rockchip, status,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	}
-
-	offset =
-	   ROCKCHIP_PCIE_MSG_ROUTING(ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX) |
-	   ROCKCHIP_PCIE_MSG_CODE(msg_code) | ROCKCHIP_PCIE_MSG_NO_DATA;
-	writel(0, ep->irq_cpu_addr + offset);
 }
 
 static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
@@ -415,7 +394,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 					 u8 interrupt_num)
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags, mme, data, data_mask;
+	u32 flags, mme, data, data_mask;
 	u8 msi_count;
 	u64 pci_addr, pci_addr_mask = 0xff;
 
@@ -620,6 +599,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
+			    PCIE_CLIENT_CONFIG);
+
 	return 0;
 err_epc_mem_exit:
 	pci_epc_mem_exit(epc);
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c53d1322a3d6..b047437605cb 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -154,6 +155,12 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
 
+#define rockchip_pcie_read_addr(addr) rockchip_pcie_read(rockchip, addr)
+/* 100 ms max wait time for PHY PLLs to lock */
+#define RK_PHY_PLL_LOCK_TIMEOUT_US 100000
+/* Sleep should be less than 20ms */
+#define RK_PHY_PLL_LOCK_SLEEP_US 1000
+
 int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
@@ -255,6 +262,16 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
+	err = readx_poll_timeout(rockchip_pcie_read_addr,
+				 PCIE_CLIENT_SIDE_BAND_STATUS,
+				 regs, !(regs & PCIE_CLIENT_PHY_ST),
+				 RK_PHY_PLL_LOCK_SLEEP_US,
+				 RK_PHY_PLL_LOCK_TIMEOUT_US);
+	if (err) {
+		dev_err(dev, "PHY PLLs could not lock, %d\n", err);
+		goto err_power_off_phy;
+	}
+
 	/*
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 8e87a059ce73..1c45b3c32151 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -37,6 +37,13 @@
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
+#define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
+#define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
+#define   PCIE_CLIENT_INT_IN_DEASSERT		HIWORD_UPDATE(0x0002, 0)
+#define   PCIE_CLIENT_INT_PEND_ST_PEND		HIWORD_UPDATE_BIT(0x0001)
+#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HIWORD_UPDATE(0x0001, 0)
+#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
+#define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
@@ -132,6 +139,8 @@
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
@@ -223,6 +232,7 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20
@@ -230,7 +240,6 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
-#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7ac6f4710908..c8326c7b468f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2521,13 +2521,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{
 		/*
 		 * Downstream device is not accessible after putting a root port
-		 * into D3cold and back into D0 on Elo i2.
+		 * into D3cold and back into D0 on Elo Continental Z2 board
 		 */
-		.ident = "Elo i2",
+		.ident = "Elo Continental Z2",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
+			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 279f9f0197b0..eec62f7377f4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -203,12 +203,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
-static bool pcie_retrain_link(struct pcie_link_state *link)
+static int pcie_wait_for_retrain(struct pci_dev *pdev)
+{
+	unsigned long end_jiffies;
+	u16 reg16;
+
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
 {
 	struct pci_dev *parent = link->pdev;
-	unsigned long start_jiffies;
+	int rc;
 	u16 reg16;
 
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
@@ -222,17 +249,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 	}
 
-	/* Wait for link training end. Break out after waiting for timeout */
-	start_jiffies = jiffies;
-	for (;;) {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
-			break;
-		msleep(1);
-	}
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return pcie_wait_for_retrain(parent);
 }
 
 /*
@@ -301,15 +318,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
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
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index afa6acb58eec..fa9d6c8f1cf8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4074,6 +4074,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 524381249a2b..b51e19402ab0 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -167,7 +167,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, &priv->ports[i]);
 		i++;
 
-		if (i > INNO_PHY_PORT_NUM) {
+		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
 			break;
 		}
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 25932d2a7154..ef8eb42e4d38 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1032,11 +1032,6 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 
 		break;
 
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
-			return -EINVAL;
-		break;
-
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE: {
 		u32 cfg;
 
@@ -1046,6 +1041,16 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 			return -EINVAL;
 
 		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (ctrl1 & CHV_PADCTRL1_ODEN)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
+			return -EINVAL;
+		break;
 	}
 
 	default:
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a44902b14087..c140ee16fe7c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -127,6 +127,14 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+	/* Use special handling for Pin0 debounce */
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
+
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
 	if (debounce) {
@@ -182,18 +190,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -216,6 +212,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *output_value;
 	char *output_enable;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		seq_printf(s, "GPIO bank%d\t", bank);
 
@@ -677,7 +674,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -767,6 +764,20 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		u32 debounce = pinconf_to_config_argument(config);
+
+		return amd_gpio_set_debounce(gc, pin, debounce);
+	}
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
@@ -794,9 +805,9 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
-		pin_reg = readl(gpio_dev->base + i * 4);
+		pin_reg = readl(gpio_dev->base + pin * 4);
 		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + i * 4);
+		writel(pin_reg, gpio_dev->base + pin * 4);
 
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 91da7527f002..0f7c02bc9044 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -21,6 +21,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 5b883eb49ce9..cbbda24bf6a8 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1024,6 +1024,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
 		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%d",
 						  bank + 'A', line);
+		if (!pin_desc[i].name)
+			return -ENOMEM;
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
diff --git a/drivers/platform/x86/hdaps.c b/drivers/platform/x86/hdaps.c
index c26baf77938e..96cc87d12329 100644
--- a/drivers/platform/x86/hdaps.c
+++ b/drivers/platform/x86/hdaps.c
@@ -378,7 +378,7 @@ static ssize_t hdaps_variance_show(struct device *dev,
 static ssize_t hdaps_temp1_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 uninitialized_var(temp);
+	u8 temp;
 	int ret;
 
 	ret = hdaps_readb_one(HDAPS_PORT_TEMP1, &temp);
@@ -391,7 +391,7 @@ static ssize_t hdaps_temp1_show(struct device *dev,
 static ssize_t hdaps_temp2_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 uninitialized_var(temp);
+	u8 temp;
 	int ret;
 
 	ret = hdaps_readb_one(HDAPS_PORT_TEMP2, &temp);
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 42b31c549db0..1781e67781a5 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -223,7 +223,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -854,15 +854,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
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
diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index e66439b6247a..e8a8ca3545f0 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -239,7 +239,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	enable_irq_wake(rtc->irq);
 	disable_irq(rtc->irq);
 
-	rtc->clk = clk_get(&pdev->dev, NULL);
+	rtc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rtc->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		return PTR_ERR(rtc->clk);
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 2016e0ed5865..9f3f48313759 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -137,6 +137,7 @@ static int dasd_ioctl_resume(struct dasd_block *block)
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index dc87a6b84d73..72e9e2945ee0 100644
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
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 471366945bd4..8a61e832607e 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2303,8 +2303,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
 
 	/* Initialize the card */
-	if (tw_reset_sequence(tw_dev))
+	if (tw_reset_sequence(tw_dev)) {
+		retval = -EINVAL;
 		goto out_release_mem_region;
+	}
 
 	/* Set host specific parameters */
 	host->max_id = TW_MAX_UNITS;
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 8b5a07503d5f..fdfa88e0d1d0 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4275,7 +4275,7 @@ static int adapter_sg_tables_alloc(struct AdapterCtlBlk *acb)
 	const unsigned srbs_per_page = PAGE_SIZE/SEGMENTX_LEN;
 	int srb_idx = 0;
 	unsigned i = 0;
-	struct SGentry *uninitialized_var(ptr);
+	struct SGentry *ptr;
 
 	for (i = 0; i < DC395x_MAX_SRB_CNT; i++)
 		acb->srb_array[i].segment_x = NULL;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index d532230c62f3..69695bb99925 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4174,7 +4174,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	struct outbound_queue_table *circularQ;
 	void *pMsg1 = NULL;
-	u8 uninitialized_var(bc);
+	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index d655f72db51d..067be417e251 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3811,7 +3811,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	struct outbound_queue_table *circularQ;
 	void *pMsg1 = NULL;
-	u8 uninitialized_var(bc);
+	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
 	u32 regval;
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index d46a10d24ed4..6c9095d0aa0f 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -1800,6 +1800,7 @@ static void
 qla2x00_terminate_rport_io(struct fc_rport *rport)
 {
 	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+	scsi_qla_host_t *vha;
 
 	if (!fcport)
 		return;
@@ -1809,9 +1810,12 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 
 	if (test_bit(ABORT_ISP_ACTIVE, &fcport->vha->dpc_flags))
 		return;
+	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
 		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+			0, WAIT_TARGET);
 		return;
 	}
 	/*
@@ -1826,6 +1830,15 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 		else
 			qla2x00_port_logout(fcport->vha, fcport);
 	}
+
+	/* check for any straggling io left behind */
+	if (qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x300b,
+		       "IO not return.  Resetting. \n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
 }
 
 static int
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index eae166572964..430dfe3d5416 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -264,6 +264,10 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
@@ -2484,6 +2488,8 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport)
+			return ret;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
 	} else {
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 7e47321e003c..23cd9ff82478 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -603,7 +603,8 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	*((uint32_t *)(&cmd_pkt->entry_type)) = cpu_to_le32(COMMAND_TYPE_6);
 
 	/* No data transfer */
-	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
+	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE ||
+	    tot_dsds == 0) {
 		cmd_pkt->byte_count = cpu_to_le32(0);
 		return 0;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7863ad1390f8..4580774b2c3e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4604,7 +4604,8 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%ld", QLA2XXX_DRIVER_NAME, vha->host_no);
+	snprintf(vha->host_str, sizeof(vha->host_str), "%s_%lu",
+		 QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,
@@ -4735,7 +4736,7 @@ qla2x00_uevent_emit(struct scsi_qla_host *vha, u32 code)
 
 	switch (code) {
 	case QLA_UEVENT_CODE_FW_DUMP:
-		snprintf(event_string, sizeof(event_string), "FW_DUMP=%ld",
+		snprintf(event_string, sizeof(event_string), "FW_DUMP=%lu",
 		    vha->host_no);
 		break;
 	default:
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index fabba17e9d65..7ec158e2acf9 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -37,6 +37,7 @@ config QE_TDM
 
 config QE_USB
 	bool
+	depends on QUICC_ENGINE
 	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 3f291db7b39a..e3c69b623770 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1255,13 +1255,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "mspi");
 
-	if (res) {
-		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qspi->base[MSPI]))
-			return PTR_ERR(qspi->base[MSPI]);
-	} else {
-		return 0;
-	}
+	qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qspi->base[MSPI]))
+		return PTR_ERR(qspi->base[MSPI]);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
 	if (res) {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index bfe5754768f9..cc6ec3fb5bfd 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -134,7 +134,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 5e49fed487f8..fd15b030b381 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -339,7 +339,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
-	int status;
+	int status, last_bpw;
 
 	/*
 	 * In CPU mode, optimize large byte transfers to use larger
@@ -373,26 +373,27 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	/* Don't allow changes if CS is active */
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change = 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if ((first->bits_per_word != t->bits_per_word) ||
-			(first->speed_hz != t->speed_hz)) {
+		if (cs_change)
+			first = t;
+		cs_change = t->cs_change;
+		if (first->speed_hz != t->speed_hz) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
 
+	last_bpw = -1;
 	cs_change = 1;
 	status = -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			if (cs_change)
-				status = fsl_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (cs_change || last_bpw != t->bits_per_word)
+			status = fsl_spi_setup_transfer(spi, t);
+		if (status < 0)
+			break;
+		last_bpw = t->bits_per_word;
 
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
diff --git a/drivers/ssb/driver_chipcommon.c b/drivers/ssb/driver_chipcommon.c
index 99a4656d113d..832ee69f45f5 100644
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -119,7 +119,7 @@ void ssb_chipco_set_clockmode(struct ssb_chipcommon *cc,
 static enum ssb_clksrc chipco_pctl_get_slowclksrc(struct ssb_chipcommon *cc)
 {
 	struct ssb_bus *bus = cc->dev->bus;
-	u32 uninitialized_var(tmp);
+	u32 tmp;
 
 	if (cc->dev->id.revision < 6) {
 		if (bus->bustype == SSB_BUSTYPE_SSB ||
@@ -149,7 +149,7 @@ static enum ssb_clksrc chipco_pctl_get_slowclksrc(struct ssb_chipcommon *cc)
 /* Get maximum or minimum (depending on get_max flag) slowclock frequency. */
 static int chipco_pctl_clockfreqlimit(struct ssb_chipcommon *cc, int get_max)
 {
-	int uninitialized_var(limit);
+	int limit;
 	enum ssb_clksrc clocksrc;
 	int divisor = 1;
 	u32 tmp;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index f624d0d53a8f..1b6226efe15e 100644
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
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index db048dbe9f78..6fec20c01ef1 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -3648,7 +3648,7 @@ static int cy_pci_probe(struct pci_dev *pdev,
 	struct cyclades_card *card;
 	void __iomem *addr0 = NULL, *addr2 = NULL;
 	char *card_name = NULL;
-	u32 uninitialized_var(mailbox);
+	u32 mailbox;
 	unsigned int device_id, nchan = 0, card_no, i, j;
 	unsigned char plx_ver;
 	int retval, irq;
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 8d96e86966f1..274480a3c4b9 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -1537,7 +1537,7 @@ static unsigned int card_count;
 static int isicom_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
-	unsigned int uninitialized_var(signature), index;
+	unsigned int signature, index;
 	int retval = -EPERM;
 	struct isi_board *board = NULL;
 
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 8c8aa3b9c298..b0c5f0dba6fc 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -85,7 +85,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
 
 
 #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
new file mode 100644
index 000000000000..1cf229cca592
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Synopsys DesignWare 8250 library. */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+
+#include "8250_dwlib.h"
+
+/* Offsets for the DesignWare specific registers */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
+#define DW_UART_CPR	0xf4 /* Component Parameter Register */
+#define DW_UART_UCV	0xf8 /* UART Component Version */
+
+/* Component Parameter Register bits */
+#define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
+#define DW_UART_CPR_AFCE_MODE		(1 << 4)
+#define DW_UART_CPR_THRE_MODE		(1 << 5)
+#define DW_UART_CPR_SIR_MODE		(1 << 6)
+#define DW_UART_CPR_SIR_LP_MODE		(1 << 7)
+#define DW_UART_CPR_ADDITIONAL_FEATURES	(1 << 8)
+#define DW_UART_CPR_FIFO_ACCESS		(1 << 9)
+#define DW_UART_CPR_FIFO_STAT		(1 << 10)
+#define DW_UART_CPR_SHADOW		(1 << 11)
+#define DW_UART_CPR_ENCODED_PARMS	(1 << 12)
+#define DW_UART_CPR_DMA_EXTRA		(1 << 13)
+#define DW_UART_CPR_FIFO_MODE		(0xff << 16)
+
+/* Helper for FIFO size calculation */
+#define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
+
+static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
+{
+	if (p->iotype == UPIO_MEM32BE)
+		return ioread32be(p->membase + offset);
+	return readl(p->membase + offset);
+}
+
+static inline void dw8250_writel_ext(struct uart_port *p, int offset, u32 reg)
+{
+	if (p->iotype == UPIO_MEM32BE)
+		iowrite32be(reg, p->membase + offset);
+	else
+		writel(reg, p->membase + offset);
+}
+
+/*
+ * divisor = div(I) + div(F)
+ * "I" means integer, "F" means fractional
+ * quot = div(I) = clk / (16 * baud)
+ * frac = div(F) * 2^dlf_size
+ *
+ * let rem = clk % (16 * baud)
+ * we have: div(F) * (16 * baud) = rem
+ * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
+ */
+static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot, rem, base_baud = baud * 16;
+	struct dw8250_port_data *d = p->private_data;
+
+	quot = p->uartclk / base_baud;
+	rem = p->uartclk % base_baud;
+	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);
+
+	return quot;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+}
+
+void dw8250_setup_port(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 reg, old_dlf;
+
+	/*
+	 * If the Component Version Register returns zero, we know that
+	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
+	 */
+	reg = dw8250_readl_ext(p, DW_UART_UCV);
+	if (!reg)
+		return;
+
+	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
+		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
+
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
+	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
+	reg = dw8250_readl_ext(p, DW_UART_DLF);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
+
+	if (reg) {
+		struct dw8250_port_data *d = p->private_data;
+
+		d->dlf_size = fls(reg);
+		p->get_divisor = dw8250_get_divisor;
+		p->set_divisor = dw8250_set_divisor;
+	}
+
+	reg = dw8250_readl_ext(p, DW_UART_CPR);
+	if (!reg)
+		return;
+
+	/* Select the type based on FIFO */
+	if (reg & DW_UART_CPR_FIFO_MODE) {
+		p->type = PORT_16550A;
+		p->flags |= UPF_FIXED_TYPE;
+		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
+		up->capabilities = UART_CAP_FIFO;
+	}
+
+	if (reg & DW_UART_CPR_AFCE_MODE)
+		up->capabilities |= UART_CAP_AFE;
+
+	if (reg & DW_UART_CPR_SIR_MODE)
+		up->capabilities |= UART_CAP_IRDA;
+}
+EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
new file mode 100644
index 000000000000..87a4db2a8aba
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Synopsys DesignWare 8250 library header file. */
+
+#include <linux/types.h>
+
+#include "8250.h"
+
+struct dw8250_port_data {
+	/* Port properties */
+	int			line;
+
+	/* DMA operations */
+	struct uart_8250_dma	dma;
+
+	/* Hardware configuration */
+	u8			dlf_size;
+};
+
+void dw8250_setup_port(struct uart_port *p);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 274e644f34f2..2c224bf70cfd 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1049,14 +1049,6 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 	return number_uarts;
 }
 
-static int pci_asix_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->bugs |= UART_BUG_PARITY;
-	return pci_default_setup(priv, board, port, idx);
-}
-
 /* Quatech devices have their own extra interface features */
 
 struct quatech_feature {
@@ -1683,7 +1675,6 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2454,16 +2445,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
-	/*
-	 * ASIX devices with FIFO bug
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_ASIX,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_asix_setup,
-	},
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cba4888bc482..66de3a59f577 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2617,11 +2617,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (c_cflag & PARENB) {
+	if (c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-		if (up->bugs & UART_BUG_PARITY)
-			up->fifo_bug = true;
-	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 #ifdef CMSPAR
@@ -2735,8 +2732,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3072,8 +3068,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a9ddd76d4170..733ac320938c 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -312,6 +312,9 @@ config SERIAL_8250_RSA
 
 	  If you don't have such card, or if unsure, say N.
 
+config SERIAL_8250_DWLIB
+	bool
+
 config SERIAL_8250_ACORN
 	tristate "Acorn expansion card serial port support"
 	depends on ARCH_ACORN && SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a84..9b451d81588b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
+8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 50c4058a00e6..1688c190fc7d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -791,11 +791,11 @@ static void atmel_complete_tx_dma(void *arg)
 
 	port->icount.tx += atmel_port->tx_len;
 
-	spin_lock_irq(&atmel_port->lock_tx);
+	spin_lock(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
 	atmel_port->cookie_tx = -EINVAL;
 	atmel_port->desc_tx = NULL;
-	spin_unlock_irq(&atmel_port->lock_tx);
+	spin_unlock(&atmel_port->lock_tx);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 964d6d33b609..5f1f52cc6395 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1199,8 +1199,12 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			continue;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			dev_err(ourport->port.dev,
+				"Failed to get clock rate for %s.\n", clkname);
+			clk_put(clk);
 			continue;
+		}
 
 		if (ourport->info->has_divslot) {
 			unsigned long div = rate / req_baud;
@@ -1226,10 +1230,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			calc_deviation = -calc_deviation;
 
 		if (calc_deviation < deviation) {
+			/*
+			 * If we find a better clk, release the previous one, if
+			 * any.
+			 */
+			if (!IS_ERR(*best_clk))
+				clk_put(*best_clk);
 			*best_clk = clk;
 			best_quot = quot;
 			*clk_num = cnt;
 			deviation = calc_deviation;
+		} else {
+			clk_put(clk);
 		}
 	}
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 1346c600ebed..48cda9b7a8f2 100644
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
index 81a5ca15b9c7..d31cc8d75595 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -242,9 +242,9 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
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
@@ -993,22 +993,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
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
index 55ee41283f39..a1d65e36a4d4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -238,9 +238,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 955bf820f410..8d4f1b13f415 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -171,10 +171,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc)
 
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
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index ec6739ef3129..687aeab64e4d 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -642,7 +642,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 
 	at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	ohci_at91_port_suspend(ohci_at91->sfr_regmap, 0);
 
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index f4b2e766f195..cb22beb55f7e 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -538,6 +538,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index b4d6d9bb3239..c545b27ea568 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1146,7 +1146,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 	struct musb_hw_ep	*hw_ep = NULL;
 	u32			rx, tx;
 	int			i, index;
-	unsigned long		uninitialized_var(flags);
+	unsigned long		flags;
 
 	cppi = container_of(musb->dma_controller, struct cppi, controller);
 	if (cppi->irq)
diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index 60d390e28289..2923a7f6952d 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -398,7 +398,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	tu->irq = ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		return ret;
+		goto err_remove_phy;
 	ret = request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,
 				   IRQF_ONESHOT,
 				   "tahvo-vbus", tu);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 126e276edd2e..cf68a422e75e 100644
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
@@ -1151,6 +1153,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x90fa),
 	  .driver_info = RSVD(3) },
 	/* u-blox products */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1311) },	/* u-blox LARA-R6 01B */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1312),		/* u-blox LARA-R6 01B (RMNET) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(UBLOX_VENDOR_ID, 0x1313, 0xff) },	/* u-blox LARA-R6 01B (ECM) */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1341) },	/* u-blox LARA-L6 */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1342),		/* u-blox LARA-L6 (RMNET) */
 	  .driver_info = RSVD(4) },
@@ -1193,6 +1199,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1221,6 +1230,7 @@ static const struct usb_device_id option_ids[] = {
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
diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8527c55335b..35306c055962 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -553,8 +553,8 @@ static int sddr55_reset(struct us_data *us)
 
 static unsigned long sddr55_get_capacity(struct us_data *us) {
 
-	unsigned char uninitialized_var(manufacturerID);
-	unsigned char uninitialized_var(deviceID);
+	unsigned char manufacturerID;
+	unsigned char deviceID;
 	int result;
 	struct sddr55_card_info *info = (struct sddr55_card_info *)us->extra;
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 5ea7b0a94fe3..4dc1842e3e8e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -828,7 +828,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 	/* len is always initialized before use since we are always called with
 	 * datalen > 0.
 	 */
-	u32 uninitialized_var(len);
+	u32 len;
 
 	while (datalen > 0 && headcount < quota) {
 		if (unlikely(seg >= UIO_MAXIOV)) {
@@ -885,7 +885,7 @@ static void handle_rx(struct vhost_net *net)
 {
 	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_virtqueue *vq = &nvq->vq;
-	unsigned uninitialized_var(in), log;
+	unsigned in, log;
 	struct vhost_log *vq_log;
 	struct msghdr msg = {
 		.msg_name = NULL,
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index f8e83a951918..593c390e9862 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1744,6 +1744,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index ecdcf358ad5e..4a3f89b22360 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1348,7 +1348,7 @@ static struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1420,7 +1420,7 @@ static void init_imstt(struct fb_info *info)
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1456,12 +1456,13 @@ static void init_imstt(struct fb_info *info)
 
 	if (register_framebuffer(info) < 0) {
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	tmp = (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }
 
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1470,6 +1471,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
+	int ret = -ENOMEM;
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
@@ -1508,23 +1510,37 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
-			release_mem_region(addr, size);
-			framebuffer_release(info);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto error;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base)
+		goto error;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
+	if (!par->dc_regs)
+		goto error;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
+	if (!par->cmap_regs)
+		goto error;
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
+
+error:
+	if (par->dc_regs)
+		iounmap(par->dc_regs);
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(addr, size);
+	framebuffer_release(info);
+	return ret;
 }
 
 static void imsttfb_remove(struct pci_dev *pdev)
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index c4eb8661f751..8ec260ed9a6f 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -601,10 +601,10 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin > 255)
+	if (var->left_margin < 3  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
-	if (var->right_margin > 255)
+	if (var->right_margin < 1 || var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
diff --git a/drivers/video/fbdev/matrox/matroxfb_maven.c b/drivers/video/fbdev/matrox/matroxfb_maven.c
index bf5ce04f9aea..267b31ddb02d 100644
--- a/drivers/video/fbdev/matrox/matroxfb_maven.c
+++ b/drivers/video/fbdev/matrox/matroxfb_maven.c
@@ -299,7 +299,7 @@ static int matroxfb_mavenclock(const struct matrox_pll_ctl *ctl,
 		unsigned int* in, unsigned int* feed, unsigned int* post,
 		unsigned int* htotal2) {
 	unsigned int fvco;
-	unsigned int uninitialized_var(p);
+	unsigned int p;
 
 	fvco = matroxfb_PLL_mavenclock(&maven1000_pll, ctl, htotal, vtotal, in, feed, &p, htotal2);
 	if (!fvco)
@@ -731,8 +731,8 @@ static int maven_find_exact_clocks(unsigned int ht, unsigned int vt,
 
 	for (x = 0; x < 8; x++) {
 		unsigned int c;
-		unsigned int uninitialized_var(a), uninitialized_var(b),
-			     uninitialized_var(h2);
+		unsigned int a, b,
+			     h2;
 		unsigned int h = ht + 2 + x;
 
 		if (!matroxfb_mavenclock((m->mode == MATROXFB_OUTPUT_MODE_PAL) ? &maven_PAL : &maven_NTSC, h, vt, &a, &b, &c, &h2)) {
diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index e3a85432f926..5730355ee598 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -576,11 +576,15 @@ static int mipid_spi_probe(struct spi_device *spi)
 
 	r = mipid_detect(md);
 	if (r < 0)
-		return r;
+		goto free_md;
 
 	omapfb_register_panel(&md->panel);
 
 	return 0;
+
+free_md:
+	kfree(md);
+	return r;
 }
 
 static int mipid_spi_remove(struct spi_device *spi)
diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 6130aa56a1e9..7bd45334dcac 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -821,9 +821,9 @@ static void pm3fb_write_mode(struct fb_info *info)
 
 	wmb();
 	{
-		unsigned char uninitialized_var(m);	/* ClkPreScale */
-		unsigned char uninitialized_var(n);	/* ClkFeedBackScale */
-		unsigned char uninitialized_var(p);	/* ClkPostScale */
+		unsigned char m;	/* ClkPreScale */
+		unsigned char n;	/* ClkFeedBackScale */
+		unsigned char p;	/* ClkPostScale */
 		unsigned long pixclock = PICOS2KHZ(info->var.pixclock);
 
 		(void)pm3fb_calculate_clock(pixclock, &m, &n, &p);
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 0601c13f2105..f90b9327bae7 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -1245,8 +1245,7 @@ int CalcStateExt
 )
 {
     int pixelDepth;
-    int uninitialized_var(VClk),uninitialized_var(m),
-        uninitialized_var(n),	uninitialized_var(p);
+    int VClk, m, n, p;
 
     /*
      * Save mode parameters.
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0cc0cfd3a3cb..8acfbe420b5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -268,7 +268,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, uninitialized_var(prev), err_idx;
+	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index cb3650efc29c..8db9ca241d99 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1237,10 +1237,10 @@ static int __init w1_init(void)
 
 static void __exit w1_fini(void)
 {
-	struct w1_master *dev;
+	struct w1_master *dev, *n;
 
 	/* Set netlink removal messages and some cleanup */
-	list_for_each_entry(dev, &w1_masters, w1_master_entry)
+	list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
 
 	w1_fini_netlink();
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 59eb92484051..31055d71b788 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -887,7 +887,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct afs_vnode *vnode, *dir;
-	struct afs_fid uninitialized_var(fid);
+	struct afs_fid fid;
 	struct dentry *parent;
 	struct inode *inode;
 	struct key *key;
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 66042b432baa..e12e532069ee 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -340,7 +340,7 @@ int afs_check_permit(struct afs_vnode *vnode, struct key *key,
 int afs_permission(struct inode *inode, int mask)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
-	afs_access_t uninitialized_var(access);
+	afs_access_t access;
 	struct key *key;
 	int ret;
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 34d56f0fa750..e48c6d7a860f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3590,6 +3590,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = tree_mod_log_eb_copy(fs_info, split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 69b43df186a8..ef95525fa6cd 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1115,7 +1115,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		goto end_trans;
 	}
 
+	spin_lock(&fs_info->trans_lock);
 	list_del(&quota_root->dirty_list);
+	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_tree_lock(quota_root->node);
 	clean_tree_block(fs_info, quota_root->node);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 049535115c9d..1f31861453d9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -703,8 +703,13 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 
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
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ba65b4bd7c0a..fcfba2af5f98 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3285,6 +3285,15 @@ static void handle_cap_grant(struct inode *inode,
 	}
 	BUG_ON(cap->issued & ~cap->implemented);
 
+	/* don't let check_caps skip sending a response to MDS for revoke msgs */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		cap->mds_wanted = 0;
+		if (cap == ci->i_auth_cap)
+			check_caps = 1; /* check auth cap only */
+		else
+			check_caps = 2; /* check all caps */
+	}
+
 	if (extra_info->inline_version > 0 &&
 	    extra_info->inline_version >= ci->i_inline_version) {
 		ci->i_inline_version = extra_info->inline_version;
diff --git a/fs/dlm/netlink.c b/fs/dlm/netlink.c
index 43a96c330570..ea50f59610e5 100644
--- a/fs/dlm/netlink.c
+++ b/fs/dlm/netlink.c
@@ -115,7 +115,7 @@ static void fill_data(struct dlm_lock_data *data, struct dlm_lkb *lkb)
 
 void dlm_timeout_warn(struct dlm_lkb *lkb)
 {
-	struct sk_buff *uninitialized_var(send_skb);
+	struct sk_buff *send_skb;
 	struct dlm_lock_data *data;
 	size_t size;
 	int rv;
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e0c05e08d8bf..9fef426ce6f4 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -22,20 +22,20 @@ static struct list_head recv_list;
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
@@ -61,6 +61,12 @@ static int check_version(struct dlm_plock_info *info)
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
@@ -104,22 +110,21 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
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
@@ -128,35 +133,44 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
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
 
@@ -176,7 +190,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 				  (unsigned long long)number);
 	}
 
-	kfree(xop);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -186,11 +200,11 @@ EXPORT_SYMBOL_GPL(dlm_posix_lock);
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
@@ -202,10 +216,10 @@ static int dlm_plock_callback(struct plock_op *op)
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
@@ -236,7 +250,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 out:
-	kfree(xop);
+	dlm_release_plock_op(op);
 	return rv;
 }
 
@@ -306,7 +320,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 
 out_free:
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	fl->fl_flags = fl_flags;
@@ -366,13 +380,15 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		locks_init_lock(fl);
 		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
 		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = -op->info.pid;
+		fl->fl_pid = op->info.pid;
+		if (op->info.nodeid != dlm_our_nodeid())
+			fl->fl_pid = -fl->fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;
 	}
 
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -408,7 +424,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	   (the process did not make an unlock call). */
 
 	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
-		kfree(op);
+		dlm_release_plock_op(op);
 
 	if (copy_to_user(u, &info, sizeof(info)))
 		return -EFAULT;
@@ -440,7 +456,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		    op->info.owner == info.owner) {
 			list_del_init(&op->list);
 			memcpy(&op->info, &info, sizeof(info));
-			if (op->callback)
+			if (op->data)
 				do_callback = 1;
 			else
 				op->done = 1;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index a203a5723e2c..598dc2874808 100644
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
index 3349ce85d27c..5c0af53f2e8f 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -691,10 +691,9 @@ static int ext2_setup_super (struct super_block * sb,
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
@@ -1040,14 +1039,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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
 
 	if (EXT2_INODE_SIZE(sb) == 0)
@@ -1075,11 +1067,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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
 
@@ -1089,12 +1080,6 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 19e2a52d1e5a..909f231a387d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1412,7 +1412,7 @@ struct ext4_sb_info {
 	unsigned long s_commit_interval;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
-	struct block_device *journal_bdev;
+	struct block_device *s_journal_bdev;
 #ifdef CONFIG_QUOTA
 	/* Names of quota files with journalled quota */
 	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 6b52ace1463c..69c76327792e 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -576,8 +576,8 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
 		return true;
-	if (EXT4_SB(sb)->journal_bdev &&
-	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->journal_bdev->bd_dev))
+	if (EXT4_SB(sb)->s_journal_bdev &&
+	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
 		return true;
 	return false;
 }
@@ -647,9 +647,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
 	handlers[0].gfd_fn = ext4_getfsmap_datadev;
-	if (EXT4_SB(sb)->journal_bdev) {
+	if (EXT4_SB(sb)->s_journal_bdev) {
 		handlers[1].gfd_dev = new_encode_dev(
-				EXT4_SB(sb)->journal_bdev->bd_dev);
+				EXT4_SB(sb)->s_journal_bdev->bd_dev);
 		handlers[1].gfd_fn = ext4_getfsmap_logdev;
 	}
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 0cc0d22c0856..9bf711d63368 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -642,6 +642,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
+
+	/*
+	 * Update reserved blocks/metadata blocks after successful block
+	 * allocation which had been deferred till now.
+	 */
+	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
+		ext4_da_update_reserve_space(inode, count, 1);
+
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7aaf4dafd3e7..646285fbc9fc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -668,16 +668,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
 		}
-
-		/*
-		 * Update reserved blocks/metadata blocks after successful
-		 * block allocation which had been deferred till now. We don't
-		 * support fallocate for non extent files. So we can update
-		 * reserve space here.
-		 */
-		if ((retval > 0) &&
-			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
-			ext4_da_update_reserve_space(inode, retval, 1);
 	}
 
 	if (retval > 0) {
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index b930e8d559d4..43e036f0b661 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -561,6 +561,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	struct super_block *ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -579,7 +580,9 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (IS_ERR(ret))
+			return PTR_ERR(ret);
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev, sb);
 		break;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 23e56c1ffc1b..7692c12b8528 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4948,8 +4948,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		 * them with group lock_held
 		 */
 		if (test_opt(sb, DISCARD)) {
-			err = ext4_issue_discard(sb, block_group, bit, count,
-						 NULL);
+			err = ext4_issue_discard(sb, block_group, bit,
+						 count_clusters, NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%d block:%d count:%lu failed"
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ce5abd25eb99..926063a6d232 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -905,10 +905,16 @@ static void ext4_blkdev_put(struct block_device *bdev)
 static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 {
 	struct block_device *bdev;
-	bdev = sbi->journal_bdev;
+	bdev = sbi->s_journal_bdev;
 	if (bdev) {
+		/*
+		 * Invalidate the journal device's buffers.  We don't want them
+		 * floating about in memory - the physical journal device may
+		 * hotswapped, and it breaks the `ro-after' testing code.
+		 */
+		invalidate_bdev(bdev);
 		ext4_blkdev_put(bdev);
-		sbi->journal_bdev = NULL;
+		sbi->s_journal_bdev = NULL;
 	}
 }
 
@@ -1032,14 +1038,8 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->journal_bdev && sbi->journal_bdev != sb->s_bdev) {
-		/*
-		 * Invalidate the journal device's buffers.  We don't want them
-		 * floating about in memory - the physical journal device may
-		 * hotswapped, and it breaks the `ro-after' testing code.
-		 */
-		sync_blockdev(sbi->journal_bdev);
-		invalidate_bdev(sbi->journal_bdev);
+	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
+		sync_blockdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 	if (sbi->s_ea_inode_cache) {
@@ -3537,7 +3537,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -4673,6 +4673,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_blkdev_remove(sbi);
 	brelse(bh);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 out_free_base:
@@ -4848,7 +4849,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 			be32_to_cpu(journal->j_superblock->s_nr_users));
 		goto out_journal;
 	}
-	EXT4_SB(sb)->journal_bdev = bdev;
+	EXT4_SB(sb)->s_journal_bdev = bdev;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f8a8807c2097..88bdb2714e51 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1767,6 +1767,20 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2c28f488ac2f..9911f780e013 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -879,8 +879,10 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	dn->ofs_in_node = 0;
 	f2fs_truncate_data_blocks(dn);
 	err = truncate_node(dn);
-	if (err)
+	if (err) {
+		f2fs_put_page(page, 1);
 		return err;
+	}
 
 	return 1;
 }
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index de60c05c0ca1..10769b2e4d46 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1287,7 +1287,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
-	struct msdos_dir_entry *uninitialized_var(de);
+	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos, i_pos;
 
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index acc35819aae6..af253127b309 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -117,7 +117,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 					      const char __user *buf,
 					      size_t count, loff_t *ppos)
 {
-	unsigned uninitialized_var(val);
+	unsigned val;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index e10e2b62ccf4..acd985aa2cba 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -269,7 +269,7 @@ static int cuse_parse_one(char **pp, char *end, char **keyp, char **valp)
 static int cuse_parse_devinfo(char *p, size_t len, struct cuse_devinfo *devinfo)
 {
 	char *end = p + len;
-	char *uninitialized_var(key), *uninitialized_var(val);
+	char *key, *val;
 	int rc;
 
 	while (true) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6098e0c7f87b..0e03adbcf942 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -232,7 +232,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			spin_unlock(&fc->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
 		    (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 599a6eeed02e..c629ccafb2b0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2774,7 +2774,7 @@ static void fuse_register_polled_file(struct fuse_conn *fc,
 {
 	spin_lock(&fc->lock);
 	if (RB_EMPTY_NODE(&ff->polled_node)) {
-		struct rb_node **link, *uninitialized_var(parent);
+		struct rb_node **link, *parent;
 
 		link = fuse_find_polled_node(fc, ff->kh, &parent);
 		BUG_ON(*link);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index d9866d89f2fb..910bfc39dc4b 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -359,7 +359,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 	int done = 0;
 	struct pagevec pvec;
 	int nr_pages;
-	pgoff_t uninitialized_var(writeback_index);
+	pgoff_t writeback_index;
 	pgoff_t index;
 	pgoff_t end;
 	pgoff_t done_index;
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ccafd45b63f6..729f36fdced1 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1754,7 +1754,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
-	unsigned int start_aligned, uninitialized_var(end_aligned);
+	unsigned int start_aligned, end_aligned;
 	unsigned int strip_h = ip->i_height - 1;
 	u32 btotal = 0;
 	int ret, state;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 3cc2237e5896..bb0eaa4638e3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1586,6 +1586,14 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (inode->i_nlink || sb_rdonly(sb))
 		goto out;
 
+	/*
+	 * In case of an incomplete mount, gfs2_evict_inode() may be called for
+	 * system files without having an active journal to write to.  In that
+	 * case, skip the filesystem evict.
+	 */
+	if (!sdp->sd_jdesc)
+		goto out;
+
 	if (test_bit(GIF_ALLOC_FAILED, &ip->i_flags)) {
 		BUG_ON(!gfs2_glock_is_locked_by_me(ip->i_gl));
 		gfs2_holder_mark_uninitialized(&gh);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index c8d1b2be7854..73342c925a4b 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -398,7 +398,7 @@ int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
 	astr = str->name;
 	len = str->len;
 	while (len > 0) {
-		int uninitialized_var(dsize);
+		int dsize;
 		size = asc2unichar(sb, astr, len, &c);
 		astr += size;
 		len -= size;
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 558e7c51ce0d..58f80e1b3ac0 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -153,8 +153,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	int found;
-	unsigned long uninitialized_var(block);
-	unsigned long uninitialized_var(offset);
+	unsigned long block;
+	unsigned long offset;
 	struct inode *inode;
 	struct page *page;
 
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index 837cd55fd4c5..6ae9d6fefb86 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 		ic->scan_dents = NULL;
 		cond_resched();
 	}
-	jffs2_build_xattr_subsystem(c);
+	ret = jffs2_build_xattr_subsystem(c);
+	if (ret)
+		goto exit;
+
 	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
 
 	dbg_fsbuild("FS build complete\n");
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 83b8f06b4a64..7e9abdb89712 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -401,7 +401,7 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
 {
 	size_t retlen;
 	int ret;
-	uint32_t uninitialized_var(bad_offset);
+	uint32_t bad_offset;
 
 	switch (jffs2_block_check_erase(c, jeb, &bad_offset)) {
 	case -EAGAIN:	goto refile;
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..acb4492f5970 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c)
 }
 
 #define XREF_TMPHASH_SIZE	(128)
-void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
+int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 {
 	struct jffs2_xattr_ref *ref, *_ref;
-	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
+	struct jffs2_xattr_ref **xref_tmphash;
 	struct jffs2_xattr_datum *xd, *_xd;
 	struct jffs2_inode_cache *ic;
 	struct jffs2_raw_node_ref *raw;
@@ -784,9 +784,12 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 
 	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
 
+	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
+			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
+	if (!xref_tmphash)
+		return -ENOMEM;
+
 	/* Phase.1 : Merge same xref */
-	for (i=0; i < XREF_TMPHASH_SIZE; i++)
-		xref_tmphash[i] = NULL;
 	for (ref=c->xref_temp; ref; ref=_ref) {
 		struct jffs2_xattr_ref *tmp;
 
@@ -884,6 +887,8 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 		     "%u of xref (%u dead, %u orphan) found.\n",
 		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
 		     xref_count, xref_dead_count, xref_orphan_count);
+	kfree(xref_tmphash);
+	return 0;
 }
 
 struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 720007b2fd65..1b5030a3349d 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(struct jffs2_xattr_ref *ref)
 #ifdef CONFIG_JFFS2_FS_XATTR
 
 extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
-extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
+extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
 extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
 
 extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
@@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
 #else
 
 #define jffs2_init_xattr_subsystem(c)
-#define jffs2_build_xattr_subsystem(c)
+#define jffs2_build_xattr_subsystem(c)		(0)
 #define jffs2_clear_xattr_subsystem(c)
 
 #define jffs2_xattr_do_crccheck_inode(c, ic)
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 3ad0a33e0443..07b9df8938f2 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -191,7 +191,13 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
+
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
 	if (!bmp->db_numag) {
 		err = -EINVAL;
diff --git a/fs/jfs/jfs_filsys.h b/fs/jfs/jfs_filsys.h
index 415bfa90607a..0c36ce6318d5 100644
--- a/fs/jfs/jfs_filsys.h
+++ b/fs/jfs/jfs_filsys.h
@@ -135,7 +135,9 @@
 #define NUM_INODE_PER_IAG	INOSPERIAG
 
 #define MINBLOCKSIZE		512
+#define L2MINBLOCKSIZE		9
 #define MAXBLOCKSIZE		4096
+#define L2MAXBLOCKSIZE		12
 #define	MAXFILESIZE		((s64)1 << 52)
 
 #define JFS_LINK_MAX		0xffffffff
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c82f898325c1..74ab20c89e75 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3403,7 +3403,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 		p = xdr_reserve_space(xdr, 32);
 		if (!p)
 			return nfserr_resource;
-		*p++ = cpu_to_be32(0);
+		*p++ = cpu_to_be32(open->op_recall);
 
 		/*
 		 * TODO: space_limit's in delegations
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ff9899cc9913..7af48d306f20 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -347,7 +347,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 {
 	char *dname, *path;
-	int uninitialized_var(maxsize);
+	int maxsize;
 	char *mesg = buf;
 	int len;
 	struct auth_domain *dom;
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 046f5e3c9622..c7cf0913229c 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -4722,7 +4722,7 @@ int ocfs2_insert_extent(handle_t *handle,
 			struct ocfs2_alloc_context *meta_ac)
 {
 	int status;
-	int uninitialized_var(free_records);
+	int free_records;
 	struct buffer_head *last_eb_bh = NULL;
 	struct ocfs2_insert_type insert = {0, };
 	struct ocfs2_extent_rec rec;
@@ -7052,7 +7052,7 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	int need_free = 0;
 	u32 bit_off, num;
 	handle_t *handle;
-	u64 uninitialized_var(block);
+	u64 block;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index c121abbdfc7d..13f4bb4e174c 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -866,9 +866,9 @@ static int ocfs2_dx_dir_lookup(struct inode *inode,
 			       u64 *ret_phys_blkno)
 {
 	int ret = 0;
-	unsigned int cend, uninitialized_var(clen);
-	u32 uninitialized_var(cpos);
-	u64 uninitialized_var(blkno);
+	unsigned int cend, clen;
+	u32 cpos;
+	u64 blkno;
 	u32 name_hash = hinfo->major_hash;
 
 	ret = ocfs2_dx_dir_lookup_rec(inode, el, name_hash, &cpos, &blkno,
@@ -912,7 +912,7 @@ static int ocfs2_dx_dir_search(const char *name, int namelen,
 			       struct ocfs2_dir_lookup_result *res)
 {
 	int ret, i, found;
-	u64 uninitialized_var(phys);
+	u64 phys;
 	struct buffer_head *dx_leaf_bh = NULL;
 	struct ocfs2_dx_leaf *dx_leaf;
 	struct ocfs2_dx_entry *dx_entry = NULL;
@@ -4420,9 +4420,9 @@ static int ocfs2_dx_dir_remove_index(struct inode *dir,
 int ocfs2_dx_dir_truncate(struct inode *dir, struct buffer_head *di_bh)
 {
 	int ret;
-	unsigned int uninitialized_var(clen);
-	u32 major_hash = UINT_MAX, p_cpos, uninitialized_var(cpos);
-	u64 uninitialized_var(blkno);
+	unsigned int clen;
+	u32 major_hash = UINT_MAX, p_cpos, cpos;
+	u64 blkno;
 	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
 	struct buffer_head *dx_root_bh = NULL;
 	struct ocfs2_dx_root_block *dx_root;
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 06cb96462bf9..1f41171c1468 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -416,7 +416,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 {
 	int i, ret, tree_height, len;
 	struct ocfs2_dinode *di;
-	struct ocfs2_extent_block *uninitialized_var(eb);
+	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
 	struct ocfs2_extent_rec *rec;
 	struct buffer_head *eb_bh = NULL;
@@ -613,7 +613,7 @@ int ocfs2_get_clusters(struct inode *inode, u32 v_cluster,
 		       unsigned int *extent_flags)
 {
 	int ret;
-	unsigned int uninitialized_var(hole_len), flags = 0;
+	unsigned int hole_len, flags = 0;
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index d437b2192522..bd8d742adf65 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2506,7 +2506,7 @@ int ocfs2_create_inode_in_orphan(struct inode *dir,
 	struct buffer_head *new_di_bh = NULL;
 	struct ocfs2_alloc_context *inode_ac = NULL;
 	struct ocfs2_dir_lookup_result orphan_insert = { NULL, };
-	u64 uninitialized_var(di_blkno), suballoc_loc;
+	u64 di_blkno, suballoc_loc;
 	u16 suballoc_bit;
 
 	status = ocfs2_inode_lock(dir, &parent_di_bh, 1);
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index fc197e599e8c..e184b36f8dd3 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1069,7 +1069,7 @@ static int ocfs2_get_refcount_rec(struct ocfs2_caching_info *ci,
 				  struct buffer_head **ret_bh)
 {
 	int ret = 0, i, found;
-	u32 low_cpos, uninitialized_var(cpos_end);
+	u32 low_cpos, cpos_end;
 	struct ocfs2_extent_list *el;
 	struct ocfs2_extent_rec *rec = NULL;
 	struct ocfs2_extent_block *eb = NULL;
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index c146e12a8601..54d881c9ac81 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1219,7 +1219,7 @@ static int ocfs2_xattr_block_get(struct inode *inode,
 	struct ocfs2_xattr_value_root *xv;
 	size_t size;
 	int ret = -ENODATA, name_offset, name_len, i;
-	int uninitialized_var(block_off);
+	int block_off;
 
 	xs->bucket = ocfs2_xattr_bucket_new(inode);
 	if (!xs->bucket) {
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index bf83e6644333..ce59b2fb50c7 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -220,7 +220,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 	struct buffer_head *bh;
 	sector_t next, offset;
 	int ret;
-	u64 uninitialized_var(new_block);
+	u64 new_block;
 	u32 max_extents;
 	int extent_count;
 	struct omfs_extent *oe;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 30abafcd4ecc..3d7a700350c1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -713,7 +713,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	struct path upperpath, datapath;
 	int err;
 	char *capability = NULL;
-	ssize_t uninitialized_var(cap_size);
+	ssize_t cap_size;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
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
diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index 591f2c7a48f0..583e20787689 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -564,11 +564,11 @@ int dbg_old_index_check_init(struct ubifs_info *c, struct ubifs_zbranch *zroot)
  */
 int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 {
-	int lnum, offs, len, err = 0, uninitialized_var(last_level), child_cnt;
+	int lnum, offs, len, err = 0, last_level, child_cnt;
 	int first = 1, iip;
 	struct ubifs_debug_info *d = c->dbg;
-	union ubifs_key uninitialized_var(lower_key), upper_key, l_key, u_key;
-	unsigned long long uninitialized_var(last_sqnum);
+	union ubifs_key lower_key, upper_key, l_key, u_key;
+	unsigned long long last_sqnum;
 	struct ubifs_idx_node *idx;
 	struct list_head list;
 	struct idx_node *i;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index cb52aa9ea276..39296e801242 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1294,7 +1294,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct ubifs_budget_req ino_req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(old_inode_ui->data_len, 8) };
 	struct timespec64 time;
-	unsigned int uninitialized_var(saved_nlink);
+	unsigned int saved_nlink;
 	struct fscrypt_name old_nm, new_nm;
 
 	/*
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index ae836e8bb293..fca3b7f483c7 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -234,7 +234,7 @@ static int write_begin_slow(struct address_space *mapping,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct ubifs_budget_req req = { .new_page = 1 };
-	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int err, appending = !!(pos + len > inode->i_size);
 	struct page *page;
 
 	dbg_gen("ino %lu, pos %llu, len %u, i_size %lld",
@@ -438,7 +438,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
-	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int err, appending = !!(pos + len > inode->i_size);
 	int skipped_read = 0;
 	struct page *page;
 
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 802565a17733..0a60a065c7e8 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1355,7 +1355,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 	union ubifs_key key, to_key;
 	struct ubifs_ino_node *ino;
 	struct ubifs_trun_node *trun;
-	struct ubifs_data_node *uninitialized_var(dn);
+	struct ubifs_data_node *dn;
 	int err, dlen, len, lnum, offs, bit, sz, sync = IS_SYNC(inode);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	ino_t inum = inode->i_ino;
diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 31393370e334..433bfcddc497 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -287,7 +287,7 @@ uint32_t ubifs_unpack_bits(const struct ubifs_info *c, uint8_t **addr, int *pos,
 	const int k = 32 - nrbits;
 	uint8_t *p = *addr;
 	int b = *pos;
-	uint32_t uninitialized_var(val);
+	uint32_t val;
 	const int bytes = (nrbits + b + 7) >> 3;
 
 	ubifs_assert(c, nrbits > 0);
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 08ed942b7627..330ccf72745b 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -936,7 +936,7 @@ static int fallible_resolve_collision(struct ubifs_info *c,
 				      int adding)
 {
 	struct ubifs_znode *o_znode = NULL, *znode = *zn;
-	int uninitialized_var(o_n), err, cmp, unsure = 0, nn = *n;
+	int o_n, err, cmp, unsure = 0, nn = *n;
 
 	cmp = fallible_matches_name(c, &znode->zbranch[nn], nm);
 	if (unlikely(cmp < 0))
@@ -1558,8 +1558,8 @@ int ubifs_tnc_locate(struct ubifs_info *c, const union ubifs_key *key,
  */
 int ubifs_tnc_get_bu_keys(struct ubifs_info *c, struct bu_info *bu)
 {
-	int n, err = 0, lnum = -1, uninitialized_var(offs);
-	int uninitialized_var(len);
+	int n, err = 0, lnum = -1, offs;
+	int len;
 	unsigned int block = key_block(c, &bu->key);
 	struct ubifs_znode *znode;
 
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index d90ee01076a9..fe3b52d2749b 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -138,8 +138,8 @@ int ubifs_search_zbranch(const struct ubifs_info *c,
 			 const struct ubifs_znode *znode,
 			 const union ubifs_key *key, int *n)
 {
-	int beg = 0, end = znode->child_cnt, uninitialized_var(mid);
-	int uninitialized_var(cmp);
+	int beg = 0, end = znode->child_cnt, mid;
+	int cmp;
 	const struct ubifs_zbranch *zbr = &znode->zbranch[0];
 
 	ubifs_assert(c, end > beg);
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index fcda0fc97b90..4c0307f378d7 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -555,7 +555,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	udf_pblk_t newblock = 0;
 	uint32_t adsize;
 	uint32_t elen, goal_elen = 0;
-	struct kernel_lb_addr eloc, uninitialized_var(goal_eloc);
+	struct kernel_lb_addr eloc, goal_eloc;
 	struct extent_position epos, goal_epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(table);
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 3e1dd66bd676..734b80a4220c 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -130,7 +130,7 @@ xfs_bmap_rtalloc(
 	 * pick an extent that will space things out in the rt area.
 	 */
 	if (ap->eof && ap->offset == 0) {
-		xfs_rtblock_t uninitialized_var(rtx); /* realtime extent no */
+		xfs_rtblock_t rtx; /* realtime extent no */
 
 		error = xfs_rtpick_extent(mp, ap->tp, ralen, &rtx);
 		if (error)
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
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index e1e9eff096d0..2932a40060c1 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -291,6 +291,18 @@ static inline void ether_addr_copy(u8 *dst, const u8 *src)
 #endif
 }
 
+/**
+ * eth_hw_addr_set - Assign Ethernet address to a net_device
+ * @dev: pointer to net_device structure
+ * @addr: address to assign
+ *
+ * Assign given address to the net_device, addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
+{
+	ether_addr_copy(dev->dev_addr, addr);
+}
+
 /**
  * eth_hw_addr_inherit - Copy dev_addr from another net_device
  * @dst: pointer to net_device to copy dev_addr to
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 90827d85265b..7e9df3854420 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4079,6 +4079,24 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 void __hw_addr_init(struct netdev_hw_addr_list *list);
 
 /* Functions used for device addresses handling */
+static inline void
+__dev_addr_set(struct net_device *dev, const u8 *addr, size_t len)
+{
+	memcpy(dev->dev_addr, addr, len);
+}
+
+static inline void dev_addr_set(struct net_device *dev, const u8 *addr)
+{
+	__dev_addr_set(dev, addr, dev->addr_len);
+}
+
+static inline void
+dev_addr_mod(struct net_device *dev, unsigned int offset,
+	     const u8 *addr, size_t len)
+{
+	memcpy(&dev->dev_addr[offset], addr, len);
+}
+
 int dev_addr_add(struct net_device *dev, const unsigned char *addr,
 		 unsigned char addr_type);
 int dev_addr_del(struct net_device *dev, const unsigned char *addr,
diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index a806803fbe37..de206e410ee2 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -49,6 +49,33 @@ static inline u16 nfnl_msg_type(u8 subsys, u8 msg_type)
 	return subsys << 8 | msg_type;
 }
 
+static inline void nfnl_fill_hdr(struct nlmsghdr *nlh, u8 family, u8 version,
+				 __be16 res_id)
+{
+	struct nfgenmsg *nfmsg;
+
+	nfmsg = nlmsg_data(nlh);
+	nfmsg->nfgen_family = family;
+	nfmsg->version = version;
+	nfmsg->res_id = res_id;
+}
+
+static inline struct nlmsghdr *nfnl_msg_put(struct sk_buff *skb, u32 portid,
+					    u32 seq, int type, int flags,
+					    u8 family, u8 version,
+					    __be16 res_id)
+{
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
+	if (!nlh)
+		return NULL;
+
+	nfnl_fill_hdr(nlh, family, version, res_id);
+
+	return nlh;
+}
+
 void nfnl_lock(__u8 subsys_id);
 void nfnl_unlock(__u8 subsys_id);
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e972d1ae1ee6..6cb593d9ed08 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -197,7 +197,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
-    defined(CONFIG_HARDLOCKUP_DETECTOR)
+    defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 void watchdog_update_hrtimer_threshold(u64 period);
 #else
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3e06e9790c25..1d1b0bfd5196 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1643,6 +1643,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
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
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 660d78c9af6c..6a55b30ae742 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -127,7 +127,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 5a655ba8d273..bfde7f1a7674 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -99,7 +99,6 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
 	unsigned char		fcr;
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 621ab5a7fb8f..0d63a428e6f9 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -460,7 +460,7 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e15632..a7224fec99a7 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -73,7 +73,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -84,12 +83,6 @@ enum {
 	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-	WORK_OFFQ_POOL_NONE	= (1LU << WORK_OFFQ_POOL_BITS) - 1,
-
-	/* convenience constants */
-	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
-	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
@@ -99,6 +92,14 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
+/* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
+#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
+
+#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+
 struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index db2a87981dd4..9583d3bbab03 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -340,6 +340,22 @@ static inline struct inet6_dev *__in6_dev_get(const struct net_device *dev)
 	return rcu_dereference_rtnl(dev->ip6_ptr);
 }
 
+/**
+ * __in6_dev_stats_get - get inet6_dev pointer for stats
+ * @dev: network device
+ * @skb: skb for original incoming interface if neeeded
+ *
+ * Caller must hold rcu_read_lock or RTNL, because this function
+ * does not take a reference on the inet6_dev.
+ */
+static inline struct inet6_dev *__in6_dev_stats_get(const struct net_device *dev,
+						    const struct sk_buff *skb)
+{
+	if (netif_is_l3_master(dev))
+		dev = dev_get_by_index_rcu(dev_net(dev), inet6_iif(skb));
+	return __in6_dev_get(dev);
+}
+
 /**
  * __in6_dev_get_safely - get inet6_dev pointer from netdevice
  * @dev: network device
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0c883249814c..3a55a0931ed8 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -602,12 +602,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
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
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 1b4f47a87806..471944087372 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -736,6 +736,7 @@ struct nft_expr_type {
 
 enum nft_trans_phase {
 	NFT_TRANS_PREPARE,
+	NFT_TRANS_PREPARE_ERROR,
 	NFT_TRANS_ABORT,
 	NFT_TRANS_COMMIT,
 	NFT_TRANS_RELEASE
@@ -1319,12 +1320,14 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  *	struct nft_trans - nf_tables object update in transaction
  *
  *	@list: used internally
+ *	@binding_list: list of objects with possible bindings
  *	@msg_type: message type
  *	@ctx: transaction context
  *	@data: internal information related to the transaction
  */
 struct nft_trans {
 	struct list_head		list;
+	struct list_head		binding_list;
 	int				msg_type;
 	struct nft_ctx			ctx;
 	char				data[0];
@@ -1409,4 +1412,15 @@ struct nft_trans_flowtable {
 int __init nft_chain_filter_init(void);
 void nft_chain_filter_fini(void);
 
+struct nftables_pernet {
+	struct list_head	tables;
+	struct list_head	commit_list;
+	struct list_head	binding_list;
+	struct list_head	module_list;
+	struct list_head	notify_list;
+	struct mutex		commit_mutex;
+	unsigned int		base_seq;
+	u8			validate_state;
+};
+
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 286fd960896f..8c77832d0240 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -5,12 +5,7 @@
 #include <linux/list.h>
 
 struct netns_nftables {
-	struct list_head	tables;
-	struct list_head	commit_list;
-	struct mutex		commit_mutex;
-	unsigned int		base_seq;
 	u8			gencursor;
-	u8			validate_state;
 };
 
 #endif
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index bbdc73a3239d..8b86560b5cfb 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -278,7 +278,7 @@ struct sk_buff *nfc_alloc_send_skb(struct nfc_dev *dev, struct sock *sk,
 struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
-				 u8 *gt, u8 gt_len);
+				 const u8 *gt, u8 gt_len);
 u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len);
 
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
@@ -292,7 +292,7 @@ int nfc_dep_link_is_up(struct nfc_dev *dev, u32 target_idx,
 		       u8 comm_mode, u8 rf_mode);
 
 int nfc_tm_activated(struct nfc_dev *dev, u32 protocol, u8 comm_mode,
-		     u8 *gb, size_t gb_len);
+		     const u8 *gb, size_t gb_len);
 int nfc_tm_deactivated(struct nfc_dev *dev);
 int nfc_tm_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index e09ea6917c06..83a16f3bd6e6 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -131,7 +131,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline struct net *qdisc_net(struct Qdisc *q)
diff --git a/include/net/sock.h b/include/net/sock.h
index 616e84d1670d..72739f72e4b9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1840,6 +1840,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 81300a04b580..c6c48409e7b4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -128,6 +128,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 				  * to combine FIN-WAIT-2 timeout with
 				  * TIME-WAIT timer.
 				  */
+#define TCP_FIN_TIMEOUT_MAX (120 * HZ) /* max TCP_LINGER2 value (two minutes) */
 
 #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
 #if HZ >= 100
@@ -1882,7 +1883,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 /* @wake is one when sk_stream_write_space() calls us.
diff --git a/include/uapi/linux/affs_hardblocks.h b/include/uapi/linux/affs_hardblocks.h
index 5e2fb8481252..a5aff2eb5f70 100644
--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -7,42 +7,42 @@
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
 struct RigidDiskBlock {
-	__u32	rdb_ID;
+	__be32	rdb_ID;
 	__be32	rdb_SummedLongs;
-	__s32	rdb_ChkSum;
-	__u32	rdb_HostID;
+	__be32	rdb_ChkSum;
+	__be32	rdb_HostID;
 	__be32	rdb_BlockBytes;
-	__u32	rdb_Flags;
-	__u32	rdb_BadBlockList;
+	__be32	rdb_Flags;
+	__be32	rdb_BadBlockList;
 	__be32	rdb_PartitionList;
-	__u32	rdb_FileSysHeaderList;
-	__u32	rdb_DriveInit;
-	__u32	rdb_Reserved1[6];
-	__u32	rdb_Cylinders;
-	__u32	rdb_Sectors;
-	__u32	rdb_Heads;
-	__u32	rdb_Interleave;
-	__u32	rdb_Park;
-	__u32	rdb_Reserved2[3];
-	__u32	rdb_WritePreComp;
-	__u32	rdb_ReducedWrite;
-	__u32	rdb_StepRate;
-	__u32	rdb_Reserved3[5];
-	__u32	rdb_RDBBlocksLo;
-	__u32	rdb_RDBBlocksHi;
-	__u32	rdb_LoCylinder;
-	__u32	rdb_HiCylinder;
-	__u32	rdb_CylBlocks;
-	__u32	rdb_AutoParkSeconds;
-	__u32	rdb_HighRDSKBlock;
-	__u32	rdb_Reserved4;
+	__be32	rdb_FileSysHeaderList;
+	__be32	rdb_DriveInit;
+	__be32	rdb_Reserved1[6];
+	__be32	rdb_Cylinders;
+	__be32	rdb_Sectors;
+	__be32	rdb_Heads;
+	__be32	rdb_Interleave;
+	__be32	rdb_Park;
+	__be32	rdb_Reserved2[3];
+	__be32	rdb_WritePreComp;
+	__be32	rdb_ReducedWrite;
+	__be32	rdb_StepRate;
+	__be32	rdb_Reserved3[5];
+	__be32	rdb_RDBBlocksLo;
+	__be32	rdb_RDBBlocksHi;
+	__be32	rdb_LoCylinder;
+	__be32	rdb_HiCylinder;
+	__be32	rdb_CylBlocks;
+	__be32	rdb_AutoParkSeconds;
+	__be32	rdb_HighRDSKBlock;
+	__be32	rdb_Reserved4;
 	char	rdb_DiskVendor[8];
 	char	rdb_DiskProduct[16];
 	char	rdb_DiskRevision[4];
 	char	rdb_ControllerVendor[8];
 	char	rdb_ControllerProduct[16];
 	char	rdb_ControllerRevision[4];
-	__u32	rdb_Reserved5[10];
+	__be32	rdb_Reserved5[10];
 };
 
 #define	IDNAME_RIGIDDISK	0x5244534B	/* "RDSK" */
@@ -50,16 +50,16 @@ struct RigidDiskBlock {
 struct PartitionBlock {
 	__be32	pb_ID;
 	__be32	pb_SummedLongs;
-	__s32	pb_ChkSum;
-	__u32	pb_HostID;
+	__be32	pb_ChkSum;
+	__be32	pb_HostID;
 	__be32	pb_Next;
-	__u32	pb_Flags;
-	__u32	pb_Reserved1[2];
-	__u32	pb_DevFlags;
+	__be32	pb_Flags;
+	__be32	pb_Reserved1[2];
+	__be32	pb_DevFlags;
 	__u8	pb_DriveName[32];
-	__u32	pb_Reserved2[15];
+	__be32	pb_Reserved2[15];
 	__be32	pb_Environment[17];
-	__u32	pb_EReserved[15];
+	__be32	pb_EReserved[15];
 };
 
 #define	IDNAME_PARTITION	0x50415254	/* "PART" */
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index ff5a5db8906a..2f3a0cca4b78 100644
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
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index ad6a633f5848..ac22e7f06239 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1510,7 +1510,7 @@ struct v4l2_input {
 	__u8	     name[32];		/*  Label */
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
-	__u32        tuner;             /*  enum v4l2_tuner_type */
+	__u32        tuner;             /*  Tuner index */
 	v4l2_std_id  std;
 	__u32	     status;
 	__u32	     capabilities;
diff --git a/kernel/async.c b/kernel/async.c
index 4bf1b00a28d8..e59bd2240cb8 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -115,7 +115,7 @@ static void async_run_entry_fn(struct work_struct *work)
 	struct async_entry *entry =
 		container_of(work, struct async_entry, work);
 	unsigned long flags;
-	ktime_t uninitialized_var(calltime), delta, rettime;
+	ktime_t calltime, delta, rettime;
 
 	/* 1) run (and print duration) */
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
@@ -283,7 +283,7 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
  */
 void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
 {
-	ktime_t uninitialized_var(starttime), delta, endtime;
+	ktime_t starttime, delta, endtime;
 
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		pr_debug("async_waiting @ %i\n", task_pid_nr(current));
diff --git a/kernel/audit.c b/kernel/audit.c
index 7dc14a4d9e3c..471d3ad910aa 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1796,7 +1796,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 {
 	struct audit_buffer *ab;
 	struct timespec64 t;
-	unsigned int uninitialized_var(serial);
+	unsigned int serial;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 9b5eeff72fd3..39a0e768adc3 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -44,7 +44,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
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
@@ -92,7 +97,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -113,7 +118,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -356,7 +361,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -422,7 +427,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -525,7 +530,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -571,7 +576,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -597,7 +602,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 7d4f89b7cb84..08da78b59f0b 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -66,11 +66,8 @@ struct bpf_lru {
 
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
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7c6cd00d0fca..c345a6e2f7b7 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -963,7 +963,7 @@ static int device_dma_allocations(struct device *dev, struct dma_debug_entry **o
 static int dma_debug_device_change(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct device *dev = data;
-	struct dma_debug_entry *uninitialized_var(entry);
+	struct dma_debug_entry *entry;
 	int count;
 
 	if (dma_debug_disabled())
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2bf4b6b109bf..cb2b717666ce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1133,6 +1133,11 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
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
@@ -9644,8 +9649,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
-		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpuctx);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
@@ -10575,7 +10579,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event *group_leader = NULL, *output_event = NULL;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
-	struct perf_event_context *ctx, *uninitialized_var(gctx);
+	struct perf_event_context *ctx, *gctx;
 	struct file *event_file = NULL;
 	struct fd group = {NULL, 0};
 	struct task_struct *task = NULL;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 24342bca11f2..72ae05d65066 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1887,7 +1887,7 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int uninitialized_var(is_swbp);
+	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == get_trampoline_vaddr())
diff --git a/kernel/exit.c b/kernel/exit.c
index 02360ec3b122..0d1cca15e66f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -140,7 +140,7 @@ static void __exit_signal(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	bool group_dead = thread_group_leader(tsk);
 	struct sighand_struct *sighand;
-	struct tty_struct *uninitialized_var(tty);
+	struct tty_struct *tty;
 	u64 utime, stime;
 
 	sighand = rcu_dereference_check(tsk->sighand,
diff --git a/kernel/futex.c b/kernel/futex.c
index 3c67da9b8408..ca2a2a894839 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1398,7 +1398,7 @@ static int lookup_pi_state(u32 __user *uaddr, u32 uval,
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
-	u32 uninitialized_var(curval);
+	u32 curval;
 
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
@@ -1569,7 +1569,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	u32 uninitialized_var(curval), newval;
+	u32 curval, newval;
 	struct task_struct *new_owner;
 	bool postunlock = false;
 	DEFINE_WAKE_Q(wake_q);
@@ -3083,7 +3083,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
  */
 static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
-	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
+	u32 curval, uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb;
 	struct futex_q *top_waiter;
@@ -3558,7 +3558,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 			      bool pi, bool pending_op)
 {
-	u32 uval, uninitialized_var(nval), mval;
+	u32 uval, nval, mval;
 	int err;
 
 	/* Futex address must be 32bit aligned */
@@ -3688,7 +3688,7 @@ static void exit_robust_list(struct task_struct *curr)
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	unsigned int next_pi;
 	unsigned long futex_offset;
 	int rc;
 
@@ -3987,7 +3987,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	unsigned int next_pi;
 	compat_uptr_t uentry, next_uentry, upending;
 	compat_long_t futex_offset;
 	int rc;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 6b3d7f7211dd..3666d434a8f5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1020,6 +1020,7 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
@@ -1031,9 +1032,7 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
-	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
-
+	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4dc79f57af82..46a6d1f7c351 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1246,7 +1246,7 @@ static int noop_count(struct lock_list *entry, void *data)
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
 
@@ -1274,7 +1274,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
 
@@ -2662,7 +2662,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 {
 	int ret;
 	struct lock_list root;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eb67f42fb96b..09f82c84474b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8721,7 +8721,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
-		.dst_grpmask    = sched_group_span(sd->groups),
+		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= sched_nr_migrate_break,
 		.cpus		= cpus,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1234868b3b03..8768ce2c4bf5 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -159,25 +159,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
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
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5c0463dbe16e..81f5c9c85d06 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1124,7 +1124,7 @@ struct ftrace_page {
 	struct ftrace_page	*next;
 	struct dyn_ftrace	*records;
 	int			index;
-	int			size;
+	int			order;
 };
 
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
@@ -2915,6 +2915,8 @@ static void ftrace_shutdown_sysctl(void)
 
 static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
+unsigned long		ftrace_number_of_pages;
+unsigned long		ftrace_number_of_groups;
 
 static inline int ops_traces_mod(struct ftrace_ops *ops)
 {
@@ -3039,8 +3041,11 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		goto again;
 	}
 
+	ftrace_number_of_pages += 1 << order;
+	ftrace_number_of_groups++;
+
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
-	pg->size = cnt;
+	pg->order = order;
 
 	if (cnt > count)
 		cnt = count;
@@ -3048,12 +3053,27 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	return cnt;
 }
 
+static void ftrace_free_pages(struct ftrace_page *pages)
+{
+	struct ftrace_page *pg = pages;
+
+	while (pg) {
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
+		pages = pg->next;
+		kfree(pg);
+		pg = pages;
+		ftrace_number_of_groups--;
+	}
+}
+
 static struct ftrace_page *
 ftrace_allocate_pages(unsigned long num_to_init)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
-	int order;
 	int cnt;
 
 	if (!num_to_init)
@@ -3087,14 +3107,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	return start_pg;
 
  free_pages:
-	pg = start_pg;
-	while (pg) {
-		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		free_pages((unsigned long)pg->records, order);
-		start_pg = pg->next;
-		kfree(pg);
-		pg = start_pg;
-	}
+	ftrace_free_pages(start_pg);
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
 }
@@ -5586,9 +5599,11 @@ static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
 {
+	struct ftrace_page *pg_unuse = NULL;
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
+	unsigned long skipped = 0;
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
@@ -5634,6 +5649,7 @@ static int ftrace_process_locs(struct module *mod,
 	p = start;
 	pg = start_pg;
 	while (p < end) {
+		unsigned long end_offset;
 		addr = ftrace_call_adjust(*p++);
 		/*
 		 * Some architecture linkers will pad between
@@ -5641,10 +5657,13 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
-		if (pg->index == pg->size) {
+		end_offset = (pg->index+1) * sizeof(pg->records[0]);
+		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
 			if (WARN_ON(!pg->next))
 				break;
@@ -5655,8 +5674,10 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	/* We should have used all pages */
-	WARN_ON(pg->next);
+	if (pg->next) {
+		pg_unuse = pg->next;
+		pg->next = NULL;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -5678,6 +5699,11 @@ static int ftrace_process_locs(struct module *mod,
  out:
 	mutex_unlock(&ftrace_lock);
 
+	/* We should have used all pages unless we skipped some */
+	if (pg_unuse) {
+		WARN_ON(!skipped);
+		ftrace_free_pages(pg_unuse);
+	}
 	return ret;
 }
 
@@ -5784,7 +5810,6 @@ void ftrace_release_mod(struct module *mod)
 	struct ftrace_page **last_pg;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
-	int order;
 
 	mutex_lock(&ftrace_lock);
 
@@ -5835,10 +5860,13 @@ void ftrace_release_mod(struct module *mod)
 		/* Needs to be called outside of ftrace_lock */
 		clear_mod_from_hashes(pg);
 
-		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		free_pages((unsigned long)pg->records, order);
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
 		tmp_page = pg->next;
 		kfree(pg);
+		ftrace_number_of_groups--;
 	}
 }
 
@@ -6144,7 +6172,6 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_mod_map *mod_map = NULL;
 	struct ftrace_init_func *func, *func_next;
 	struct list_head clear_hash;
-	int order;
 
 	INIT_LIST_HEAD(&clear_hash);
 
@@ -6182,8 +6209,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-			free_pages((unsigned long)pg->records, order);
+			if (pg->records) {
+				free_pages((unsigned long)pg->records, pg->order);
+				ftrace_number_of_pages -= 1 << pg->order;
+			}
+			ftrace_number_of_groups--;
 			kfree(pg);
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
@@ -6239,6 +6269,9 @@ void __init ftrace_init(void)
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
 
+	pr_info("ftrace: allocated %ld pages with %ld groups\n",
+		ftrace_number_of_pages, ftrace_number_of_groups);
+
 	set_ftrace_early_filters();
 
 	return;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ba8b72f9cdc0..c8a7de7a1d63 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -493,6 +493,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			read_bytes;
 	u64				write_stamp;
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -528,6 +530,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 };
 
@@ -561,7 +564,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
  */
 int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 {
-	struct ring_buffer_per_cpu *uninitialized_var(cpu_buffer);
+	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
 	int ret = 0;
@@ -1514,6 +1517,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1535,12 +1540,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
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
@@ -3582,6 +3581,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head)
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4022,12 +4022,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -4408,28 +4409,34 @@ unsigned long ring_buffer_size(struct ring_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+static void rb_clear_buffer_page(struct buffer_page *page)
+{
+	local_set(&page->write, 0);
+	local_set(&page->entries, 0);
+	rb_init_page(page->page);
+	page->read = 0;
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	struct buffer_page *page;
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
 		= list_entry(cpu_buffer->pages, struct buffer_page, list);
-	local_set(&cpu_buffer->head_page->write, 0);
-	local_set(&cpu_buffer->head_page->entries, 0);
-	local_set(&cpu_buffer->head_page->page->commit, 0);
-
-	cpu_buffer->head_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->head_page);
+	list_for_each_entry(page, cpu_buffer->pages, list) {
+		rb_clear_buffer_page(page);
+	}
 
 	cpu_buffer->tail_page = cpu_buffer->head_page;
 	cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
-	local_set(&cpu_buffer->reader_page->write, 0);
-	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
-	cpu_buffer->reader_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->reader_page);
 
 	local_set(&cpu_buffer->entries_bytes, 0);
 	local_set(&cpu_buffer->overrun, 0);
@@ -4448,6 +4455,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 98abff046236..9da7b10e56d2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7107,14 +7107,23 @@ static ssize_t
 tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		  size_t cnt, loff_t *ppos)
 {
-	unsigned long *p = filp->private_data;
-	char buf[64]; /* Not too big for a shallow stack */
+	ssize_t ret;
+	char *buf;
 	int r;
 
-	r = scnprintf(buf, 63, "%ld", *p);
-	buf[r++] = '\n';
+	/* 256 should be plenty to hold the amount needed */
+	buf = kmalloc(256, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
+		      ftrace_update_tot_cnt,
+		      ftrace_number_of_pages,
+		      ftrace_number_of_groups);
+
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	kfree(buf);
+	return ret;
 }
 
 static const struct file_operations tracing_dyn_info_fops = {
@@ -8246,7 +8255,7 @@ static __init int tracer_init_tracefs(void)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	trace_create_file("dyn_ftrace_total_info", 0444, d_tracer,
-			&ftrace_update_tot_cnt, &tracing_dyn_info_fops);
+			NULL, &tracing_dyn_info_fops);
 #endif
 
 	create_trace_instances(d_tracer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0923d1b18d1f..f4d83b552a47 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -748,6 +748,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_update_tot_cnt;
+extern unsigned long ftrace_number_of_pages;
+extern unsigned long ftrace_number_of_groups;
 void ftrace_init_trace_array(struct trace_array *tr);
 #else
 static inline void ftrace_init_trace_array(struct trace_array *tr) { }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index d2f9146d1ad7..a3dc6c126b3e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -372,7 +372,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -396,6 +395,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -434,6 +435,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -473,15 +476,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
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
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 455cf41aedbb..e004daf8cad5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5787,13 +5787,16 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	if (has_hist_vars(hist_data))
-		save_hist_vars(hist_data);
-
 	ret = create_actions(hist_data, file);
 	if (ret)
 		goto out_unreg;
 
+	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+		ret = save_hist_vars(hist_data);
+		if (ret)
+			goto out_unreg;
+	}
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 71381168dede..f8e460b4a59d 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -114,14 +114,14 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (!watchdog_check_timestamp())
+		return;
+
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
 	}
 
-	if (!watchdog_check_timestamp())
-		return;
-
 	/* check for a hardlockup
 	 * This is done by making sure our timer interrupt
 	 * is incrementing.  The timer interrupt should have
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4ea2f7fd20ce..5533206cb6f4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -680,12 +680,17 @@ static void clear_work_data(struct work_struct *work)
 	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
 }
 
+static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
+{
+	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
 {
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return work_struct_pwq(data);
 	else
 		return NULL;
 }
@@ -713,8 +718,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -735,8 +739,7 @@ static int get_work_pool_id(struct work_struct *work)
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5f23d896df55..62d095fd0c52 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -371,6 +371,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	struct debug_obj_descr *descr = obj->descr;
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
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index e5cab5c4e383..8d29fa5b2695 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1498,7 +1498,7 @@ void *radix_tree_tag_clear(struct radix_tree_root *root,
 {
 	struct radix_tree_node *node, *parent;
 	unsigned long maxindex;
-	int uninitialized_var(offset);
+	int offset;
 
 	radix_tree_load_root(root, &node, &maxindex);
 	if (index > maxindex)
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index f4cc874021da..b5e779bcfb34 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -160,7 +160,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -456,7 +456,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -497,7 +497,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -540,7 +540,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
@@ -618,6 +618,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -721,6 +726,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 9e66ee4020e9..5de382e79a45 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -64,10 +64,12 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 	struct ts_bm *bm = ts_config_priv(conf);
 	unsigned int i, text_len, consumed = state->offset;
 	const u8 *text;
-	int shift = bm->patlen - 1, bs;
+	int bs;
 	const u8 icase = conf->flags & TS_IGNORECASE;
 
 	for (;;) {
+		int shift = bm->patlen - 1;
+
 		text_len = conf->get_next_block(consumed, &text, conf, state);
 
 		if (unlikely(text_len == 0))
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 157e5bf63504..80bf870d881a 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -447,7 +447,7 @@ static int __frontswap_shrink(unsigned long target_pages,
 void frontswap_shrink(unsigned long target_pages)
 {
 	unsigned long pages_to_unuse = 0;
-	int uninitialized_var(type), ret;
+	int type, ret;
 
 	/*
 	 * we don't want to hold swap_lock while doing a very
diff --git a/mm/ksm.c b/mm/ksm.c
index 87a541ab1474..9693aadec6e2 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2381,7 +2381,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct rmap_item *rmap_item;
-	struct page *uninitialized_var(page);
+	struct page *page;
 
 	while (scan_npages-- && likely(!freezing(current))) {
 		cond_resched();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bc4c61dcf95c..5a366cf79821 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -919,7 +919,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
-	struct mem_cgroup_reclaim_iter *uninitialized_var(iter);
+	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *pos = NULL;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 35088e830bff..86fd6bedaff4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1147,7 +1147,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 static struct page *new_page(struct page *page, unsigned long start)
 {
 	struct vm_area_struct *vma;
-	unsigned long uninitialized_var(address);
+	unsigned long address;
 
 	vma = find_vma(current->mm, start);
 	while (vma) {
@@ -1545,7 +1545,7 @@ static int kernel_get_mempolicy(int __user *policy,
 				unsigned long flags)
 {
 	int err;
-	int uninitialized_var(pval);
+	int pval;
 	nodemask_t nodes;
 
 	if (nmask != NULL && maxnode < nr_node_ids)
diff --git a/mm/percpu.c b/mm/percpu.c
index 0151f276ae68..6ae4993214b4 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2283,7 +2283,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
 	const size_t static_size = __per_cpu_end - __per_cpu_start;
 	int nr_groups = 1, nr_units = 0;
 	size_t size_sum, min_unit_size, alloc_size;
-	int upa, max_upa, uninitialized_var(best_upa);	/* units_per_alloc */
+	int upa, max_upa, best_upa;	/* units_per_alloc */
 	int last_allocs, group, unit;
 	unsigned int cpu, tcpu;
 	struct pcpu_alloc_info *ai;
diff --git a/mm/slub.c b/mm/slub.c
index ef730ea8263c..edf766f1de63 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1179,7 +1179,7 @@ static noinline int free_debug_processing(
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
 	void *object = head;
 	int cnt = 0;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&n->list_lock, flags);
@@ -2826,7 +2826,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 	struct page new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 
 	stat(s, FREE_SLOWPATH);
 
diff --git a/mm/swap.c b/mm/swap.c
index 45fdbfb6b2a6..ce13e428380e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -721,8 +721,8 @@ void release_pages(struct page **pages, int nr)
 	LIST_HEAD(pages_to_free);
 	struct pglist_data *locked_pgdat = NULL;
 	struct lruvec *lruvec;
-	unsigned long uninitialized_var(flags);
-	unsigned int uninitialized_var(lock_batch);
+	unsigned long flags;
+	unsigned int lock_batch;
 
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1c6d01a27e0e..b831e5fe3ebc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -45,6 +45,7 @@ static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     int proto, gfp_t prio, int kern);
+static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
 {
@@ -1205,6 +1206,7 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	l2cap_sock_cleanup_listen(sk);
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, 2);
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index b5fb2b682e19..ab539551b7d3 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -161,8 +161,9 @@ void br_manage_promisc(struct net_bridge *br)
 			 * This lets us disable promiscuous mode and write
 			 * this config to hw.
 			 */
-			if (br->auto_cnt == 0 ||
-			    (br->auto_cnt == 1 && br_auto_port(p)))
+			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
+			    (br->auto_cnt == 0 ||
+			     (br->auto_cnt == 1 && br_auto_port(p))))
 				br_port_clear_promisc(p);
 			else
 				br_port_set_promisc(p);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 61269cc2fa82..1c9953c68f09 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1520,6 +1520,12 @@ static int bcm_release(struct socket *sock)
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1555,12 +1561,6 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 713fe1fbcb18..90ebb0ba927c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3137,17 +3137,24 @@ static int linger_reg_commit_wait(struct ceph_osd_linger_request *lreq)
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
@@ -4760,7 +4767,8 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 
 	ret = linger_reg_commit_wait(lreq);
 	if (!ret)
-		ret = linger_notify_finish_wait(lreq);
+		ret = linger_notify_finish_wait(lreq,
+				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
 	else
 		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2837cc03f69e..79f62517e24a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3436,7 +3436,7 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	ndm->ndm_ifindex = dev->ifindex;
 	ndm->ndm_state   = ndm_state;
 
-	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, addr))
+	if (nla_put(skb, NDA_LLADDR, dev->addr_len, addr))
 		goto nla_put_failure;
 	if (vid)
 		if (nla_put(skb, NDA_VLAN, sizeof(u16), &vid))
@@ -3450,10 +3450,10 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static inline size_t rtnl_fdb_nlmsg_size(void)
+static inline size_t rtnl_fdb_nlmsg_size(const struct net_device *dev)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg)) +
-	       nla_total_size(ETH_ALEN) +	/* NDA_LLADDR */
+	       nla_total_size(dev->addr_len) +	/* NDA_LLADDR */
 	       nla_total_size(sizeof(u16)) +	/* NDA_VLAN */
 	       0;
 }
@@ -3465,7 +3465,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(rtnl_fdb_nlmsg_size(), GFP_ATOMIC);
+	skb = nlmsg_new(rtnl_fdb_nlmsg_size(dev), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 347a55519d0a..3e6da3694a5a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1319,7 +1319,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (!sock->ops->set_peek_off)
 			return -EOPNOTSUPP;
 
-		v.val = sk->sk_peek_off;
+		v.val = READ_ONCE(sk->sk_peek_off);
 		break;
 	case SO_NOFCS:
 		v.val = sock_flag(sk, SOCK_NOFCS);
@@ -1349,7 +1349,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
-		v.val = sk->sk_ll_usec;
+		v.val = READ_ONCE(sk->sk_ll_usec);
 		break;
 #endif
 
@@ -1939,13 +1939,24 @@ kuid_t sock_i_uid(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_i_uid);
 
-unsigned long sock_i_ino(struct sock *sk)
+unsigned long __sock_i_ino(struct sock *sk)
 {
 	unsigned long ino;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	read_lock(&sk->sk_callback_lock);
 	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock(&sk->sk_callback_lock);
+	return ino;
+}
+EXPORT_SYMBOL(__sock_i_ino);
+
+unsigned long sock_i_ino(struct sock *sk)
+{
+	unsigned long ino;
+
+	local_bh_disable();
+	ino = __sock_i_ino(sk);
+	local_bh_enable();
 	return ino;
 }
 EXPORT_SYMBOL(sock_i_ino);
@@ -2548,7 +2559,7 @@ EXPORT_SYMBOL(__sk_mem_reclaim);
 
 int sk_set_peek_off(struct sock *sk, int val)
 {
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sk_set_peek_off);
diff --git a/net/dccp/options.c b/net/dccp/options.c
index 4e40db017e19..3c464d63b0bb 100644
--- a/net/dccp/options.c
+++ b/net/dccp/options.c
@@ -60,7 +60,7 @@ int dccp_parse_options(struct sock *sk, struct dccp_request_sock *dreq,
 					(dh->dccph_doff * 4);
 	struct dccp_options_received *opt_recv = &dp->dccps_options_received;
 	unsigned char opt, len;
-	unsigned char *uninitialized_var(value);
+	unsigned char *value;
 	u32 elapsed_time;
 	__be32 opt_val;
 	int rc;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 5a272d09b824..c6d670cd872f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -579,20 +579,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_hashed(osk);
-		if (ret) {
-			/* Before deleting the node, we insert a new one to make
-			 * sure that the look-up-sk process would not miss either
-			 * of them and that at least one node would exist in ehash
-			 * table all the time. Otherwise there's a tiny chance
-			 * that lookup process could find nothing in ehash table.
-			 */
-			__sk_nulls_add_node_tail_rcu(sk, list);
-			sk_nulls_del_node_init_rcu(osk);
-		}
-		goto unlock;
-	}
-	if (found_dup_sk) {
+		ret = sk_nulls_del_node_init_rcu(osk);
+	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -601,7 +589,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index fedd19c22b39..88c5069b5d20 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -80,10 +80,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_tail_rcu(struct inet_timewait_sock *tw,
-					struct hlist_nulls_head *list)
+static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
+				   struct hlist_nulls_head *list)
 {
-	hlist_nulls_add_tail_rcu(&tw->tw_node, list);
+	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
 static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
@@ -119,7 +119,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
diff --git a/net/ipv4/netfilter/nf_socket_ipv4.c b/net/ipv4/netfilter/nf_socket_ipv4.c
index 4824b1e183a1..bff2b85c5fd6 100644
--- a/net/ipv4/netfilter/nf_socket_ipv4.c
+++ b/net/ipv4/netfilter/nf_socket_ipv4.c
@@ -96,11 +96,11 @@ nf_socket_get_sock_v4(struct net *net, struct sk_buff *skb, const int doff,
 struct sock *nf_sk_lookup_slow_v4(struct net *net, const struct sk_buff *skb,
 				  const struct net_device *indev)
 {
-	__be32 uninitialized_var(daddr), uninitialized_var(saddr);
-	__be16 uninitialized_var(dport), uninitialized_var(sport);
+	__be32 daddr, saddr;
+	__be16 dport, sport;
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sk_buff *data_skb = NULL;
-	u8 uninitialized_var(protocol);
+	u8 protocol;
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn const *ct;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cb96775fc86f..00648a478c6a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3000,18 +3000,18 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
-		else if (val > net->ipv4.sysctl_tcp_fin_timeout / HZ)
-			tp->linger2 = 0;
+			WRITE_ONCE(tp->linger2, -1);
+		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -3099,7 +3099,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -3401,13 +3401,14 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_syn_retries;
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
@@ -3553,7 +3554,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
@@ -3568,7 +3569,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = tcp_time_stamp_raw() + tp->tsoffset;
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index f726591de7c7..f7bb78b443fa 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -276,6 +276,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -288,10 +289,11 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bd921fa7b9ab..281f7799aeaf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3429,8 +3429,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 				   u32 *last_oow_ack_time)
 {
-	if (*last_oow_ack_time) {
-		s32 elapsed = (s32)(tcp_jiffies32 - *last_oow_ack_time);
+	/* Paired with the WRITE_ONCE() in this function. */
+	u32 val = READ_ONCE(*last_oow_ack_time);
+
+	if (val) {
+		s32 elapsed = (s32)(tcp_jiffies32 - val);
 
 		if (0 <= elapsed &&
 		    elapsed < READ_ONCE(net->ipv4.sysctl_tcp_invalid_ratelimit)) {
@@ -3439,7 +3442,10 @@ static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 		}
 	}
 
-	*last_oow_ack_time = tcp_jiffies32;
+	/* Paired with the prior READ_ONCE() and with itself,
+	 * as we might be lockless.
+	 */
+	WRITE_ONCE(*last_oow_ack_time, tcp_jiffies32);
 
 	return false;	/* not rate-limited: go ahead, send dupack now! */
 }
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 4960e2b6bd7f..7bbd9125b500 100644
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
@@ -431,7 +451,7 @@ void tcp_update_metrics(struct sock *sk)
 					       tp->reordering);
 		}
 	}
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 out_unlock:
 	rcu_read_unlock();
 }
@@ -544,8 +564,6 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
 	return ret;
 }
 
-static DEFINE_SEQLOCK(fastopen_seqlock);
-
 void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
 			    struct tcp_fastopen_cookie *cookie)
 {
@@ -652,7 +670,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 	}
 
 	if (nla_put_msecs(msg, TCP_METRICS_ATTR_AGE,
-			  jiffies - tm->tcpm_stamp,
+			  jiffies - READ_ONCE(tm->tcpm_stamp),
 			  TCP_METRICS_ATTR_PAD) < 0)
 		goto nla_put_failure;
 
@@ -663,7 +681,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 		if (!nest)
 			goto nla_put_failure;
 		for (i = 0; i < TCP_METRIC_MAX_KERNEL + 1; i++) {
-			u32 val = tm->tcpm_vals[i];
+			u32 val = tcp_metric_get(tm, i);
 
 			if (!val)
 				continue;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f261c6d7f1f2..5c5c5736f689 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -316,9 +316,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
 static void addrconf_mod_rs_timer(struct inet6_dev *idev,
 				  unsigned long when)
 {
-	if (!timer_pending(&idev->rs_timer))
+	if (!mod_timer(&idev->rs_timer, jiffies + when))
 		in6_dev_hold(idev);
-	mod_timer(&idev->rs_timer, jiffies + when);
 }
 
 static void addrconf_mod_dad_work(struct inet6_ifaddr *ifp,
@@ -2489,12 +2488,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
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
 		ipv6_create_tempaddr(ifp, NULL, false);
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index fbc8746371b6..bfafd7649ccb 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -395,23 +395,31 @@ static struct dst_entry *icmpv6_route_lookup(struct net *net,
 	return ERR_PTR(err);
 }
 
-static int icmp6_iif(const struct sk_buff *skb)
+static struct net_device *icmp6_dev(const struct sk_buff *skb)
 {
-	int iif = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
 
 	/* for local traffic to local address, skb dev is the loopback
 	 * device. Check if there is a dst attached to the skb and if so
 	 * get the real device index. Same is needed for replies to a link
 	 * local address on a device enslaved to an L3 master device
 	 */
-	if (unlikely(iif == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
+	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
-		if (rt6)
-			iif = rt6->rt6i_idev->dev->ifindex;
+		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
+		 * and ip6_null_entry could be set to skb if no route is found.
+		 */
+		if (rt6 && rt6->rt6i_idev)
+			dev = rt6->rt6i_idev->dev;
 	}
 
-	return iif;
+	return dev;
+}
+
+static int icmp6_iif(const struct sk_buff *skb)
+{
+	return icmp6_dev(skb)->ifindex;
 }
 
 /*
@@ -800,7 +808,7 @@ void icmpv6_notify(struct sk_buff *skb, u8 type, u8 code, __be32 info)
 static int icmpv6_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
-	struct net_device *dev = skb->dev;
+	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
 	struct icmp6hdr *hdr;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index f994f50e1516..1858cf783a4f 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -518,7 +518,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 {
-	int uninitialized_var(err);
+	int err;
 	struct net *net = sock_net(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_flowlabel_req freq;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 45c304b51b2b..aa8ada354a39 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -960,7 +960,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		goto tx_err;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto tx_err;
 		truncate = true;
 	}
 
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e9eb917342b8..329bad6cbb76 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1064,7 +1064,7 @@ static int ip6mr_cache_report(struct mr_table *mrt, struct sk_buff *pkt,
 		   And all this only to mangle msg->im6_msgtype and
 		   to set msg->im6_mbz to "mbz" :-)
 		 */
-		skb_push(skb, -skb_network_offset(pkt));
+		__skb_pull(skb, skb_network_offset(pkt));
 
 		skb_push(skb, sizeof(*msg));
 		skb_reset_transport_header(skb);
diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
index 58e839e2ce1d..5e5463459563 100644
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -102,7 +102,7 @@ nf_socket_get_sock_v6(struct net *net, struct sk_buff *skb, int doff,
 struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 				  const struct net_device *indev)
 {
-	__be16 uninitialized_var(dport), uninitialized_var(sport);
+	__be16 dport, sport;
 	const struct in6_addr *daddr = NULL, *saddr = NULL;
 	struct ipv6hdr *iph = ipv6_hdr(skb), ipv6_var;
 	struct sk_buff *data_skb = NULL;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 60dfd0d11851..b596727f0497 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -302,7 +302,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 			   skb_network_header_len(skb));
 
 	rcu_read_lock();
-	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMOKS);
+	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMOKS);
 	rcu_read_unlock();
 	fq->q.fragments = NULL;
 	fq->q.rb_fragments = RB_ROOT;
@@ -317,7 +317,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	net_dbg_ratelimited("ip6_frag_reasm: no memory for reassembly\n");
 out_fail:
 	rcu_read_lock();
-	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
+	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
 	rcu_read_unlock();
 	inet_frag_kill(&fq->q);
 	return -1;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9274603514e5..cf0bbe2e3a79 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -99,7 +99,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 int udp_v6_get_port(struct sock *sk, unsigned short snum)
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 82cb93f66b9b..f9e801cc50f5 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -162,9 +162,6 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
 	 * receives, do not try to analyse it.
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0427e66bc478..31756d1bf83e 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -791,20 +791,9 @@ static struct nlmsghdr *
 start_msg(struct sk_buff *skb, u32 portid, u32 seq, unsigned int flags,
 	  enum ipset_cmd cmd)
 {
-	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
-
-	nlh = nlmsg_put(skb, portid, seq, nfnl_msg_type(NFNL_SUBSYS_IPSET, cmd),
-			sizeof(*nfmsg), flags);
-	if (!nlh)
-		return NULL;
-
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = NFPROTO_IPV4;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
-	return nlh;
+	return nfnl_msg_put(skb, portid, seq,
+			    nfnl_msg_type(NFNL_SUBSYS_IPSET, cmd), flags,
+			    NFPROTO_IPV4, NFNETLINK_V0, 0);
 }
 
 /* Create a set */
diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index efc14c7b4f8e..c2fece0593ea 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -383,7 +383,7 @@ static int help(struct sk_buff *skb,
 	int ret;
 	u32 seq;
 	int dir = CTINFO2DIR(ctinfo);
-	unsigned int uninitialized_var(matchlen), uninitialized_var(matchoff);
+	unsigned int matchlen, matchoff;
 	struct nf_ct_ftp_master *ct_ftp_info = nfct_help_data(ct);
 	struct nf_conntrack_expect *exp;
 	union nf_inet_addr *daddr;
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index e24b762ffa1d..06c70d4584cf 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -400,6 +400,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
+	if (!nf_ct_helper_hash)
+		return -ENOENT;
+
 	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
@@ -570,4 +573,5 @@ void nf_conntrack_helper_fini(void)
 {
 	nf_ct_extend_unregister(&helper_extend);
 	kvfree(nf_ct_helper_hash);
+	nf_ct_helper_hash = NULL;
 }
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index b710889a90f6..83e8566ec3f0 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -517,20 +517,15 @@ ctnetlink_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 {
 	const struct nf_conntrack_zone *zone;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct nlattr *nest_parms;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, IPCTNL_MSG_CT_NEW);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, nf_ct_l3num(ct),
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = nf_ct_l3num(ct);
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	zone = nf_ct_zone(ct);
 
 	nest_parms = nla_nest_start(skb, CTA_TUPLE_ORIG | NLA_F_NESTED);
@@ -687,7 +682,6 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 	const struct nf_conntrack_zone *zone;
 	struct net *net;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct nlattr *nest_parms;
 	struct nf_conn *ct = item->ct;
 	struct sk_buff *skb;
@@ -717,15 +711,11 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 		goto errout;
 
 	type = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, type);
-	nlh = nlmsg_put(skb, item->portid, 0, type, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, item->portid, 0, type, flags, nf_ct_l3num(ct),
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = nf_ct_l3num(ct);
-	nfmsg->version	= NFNETLINK_V0;
-	nfmsg->res_id	= 0;
-
 	zone = nf_ct_zone(ct);
 
 	nest_parms = nla_nest_start(skb, CTA_TUPLE_ORIG | NLA_F_NESTED);
@@ -2170,20 +2160,15 @@ ctnetlink_ct_stat_cpu_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
 				__u16 cpu, const struct ip_conntrack_stat *st)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK,
 			      IPCTNL_MSG_CT_GET_STATS_CPU);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, htons(cpu));
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(cpu);
-
 	if (nla_put_be32(skb, CTA_STATS_FOUND, htonl(st->found)) ||
 	    nla_put_be32(skb, CTA_STATS_INVALID, htonl(st->invalid)) ||
 	    nla_put_be32(skb, CTA_STATS_IGNORE, htonl(st->ignore)) ||
@@ -2254,20 +2239,15 @@ ctnetlink_stat_ct_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			    struct net *net)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 	unsigned int nr_conntracks = atomic_read(&net->ct.count);
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, IPCTNL_MSG_CT_GET_STATS);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (nla_put_be32(skb, CTA_STATS_GLOBAL_ENTRIES, htonl(nr_conntracks)))
 		goto nla_put_failure;
 
@@ -2780,19 +2760,14 @@ ctnetlink_exp_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
 			int event, const struct nf_conntrack_expect *exp)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_EXP, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags,
+			   exp->tuple.src.l3num, NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = exp->tuple.src.l3num;
-	nfmsg->version	    = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (ctnetlink_exp_dump_expect(skb, exp) < 0)
 		goto nla_put_failure;
 
@@ -2812,7 +2787,6 @@ ctnetlink_expect_event(unsigned int events, struct nf_exp_event *item)
 	struct nf_conntrack_expect *exp = item->exp;
 	struct net *net = nf_ct_exp_net(exp);
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct sk_buff *skb;
 	unsigned int type, group;
 	int flags = 0;
@@ -2835,15 +2809,11 @@ ctnetlink_expect_event(unsigned int events, struct nf_exp_event *item)
 		goto errout;
 
 	type = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_EXP, type);
-	nlh = nlmsg_put(skb, item->portid, 0, type, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, item->portid, 0, type, flags,
+			   exp->tuple.src.l3num, NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = exp->tuple.src.l3num;
-	nfmsg->version	    = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (ctnetlink_exp_dump_expect(skb, exp) < 0)
 		goto nla_put_failure;
 
@@ -3413,20 +3383,15 @@ ctnetlink_exp_stat_fill_info(struct sk_buff *skb, u32 portid, u32 seq, int cpu,
 			     const struct ip_conntrack_stat *st)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK,
 			      IPCTNL_MSG_EXP_GET_STATS_CPU);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, htons(cpu));
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(cpu);
-
 	if (nla_put_be32(skb, CTA_STATS_EXP_NEW, htonl(st->expect_new)) ||
 	    nla_put_be32(skb, CTA_STATS_EXP_CREATE, htonl(st->expect_create)) ||
 	    nla_put_be32(skb, CTA_STATS_EXP_DELETE, htonl(st->expect_delete)))
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 046f118dea06..d16aa43ebd4d 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -605,7 +605,7 @@ int ct_sip_parse_numerical_param(const struct nf_conn *ct, const char *dptr,
 	start += strlen(name);
 	*val = simple_strtoul(start, &end, 0);
 	if (start == end)
-		return 0;
+		return -1;
 	if (matchoff && matchlen) {
 		*matchoff = start - dptr;
 		*matchlen = end - start;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2968f21915dd..115bc79ec905 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -22,10 +22,13 @@
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/sock.h>
 
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
 
+unsigned int nf_tables_net_id __read_mostly;
+
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
@@ -53,7 +56,9 @@ static const struct rhashtable_params nft_chain_ht_params = {
 
 static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 {
-	switch (net->nft.validate_state) {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	switch (nft_net->validate_state) {
 	case NFT_VALIDATE_SKIP:
 		WARN_ON_ONCE(new_validate_state == NFT_VALIDATE_DO);
 		break;
@@ -64,7 +69,7 @@ static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 			return;
 	}
 
-	net->nft.validate_state = new_validate_state;
+	nft_net->validate_state = new_validate_state;
 }
 
 static void nft_ctx_init(struct nft_ctx *ctx,
@@ -97,6 +102,7 @@ static struct nft_trans *nft_trans_alloc_gfp(const struct nft_ctx *ctx,
 		return NULL;
 
 	INIT_LIST_HEAD(&trans->list);
+	INIT_LIST_HEAD(&trans->binding_list);
 	trans->msg_type = msg_type;
 	trans->ctx	= *ctx;
 
@@ -109,34 +115,68 @@ static struct nft_trans *nft_trans_alloc(const struct nft_ctx *ctx,
 	return nft_trans_alloc_gfp(ctx, msg_type, size, GFP_KERNEL);
 }
 
-static void nft_trans_destroy(struct nft_trans *trans)
+static void nft_trans_list_del(struct nft_trans *trans)
 {
 	list_del(&trans->list);
+	list_del(&trans->binding_list);
+}
+
+static void nft_trans_destroy(struct nft_trans *trans)
+{
+	nft_trans_list_del(trans);
 	kfree(trans);
 }
 
-static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+static void __nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set,
+				 bool bind)
 {
+	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
 	struct nft_trans *trans;
 
 	if (!nft_set_is_anonymous(set))
 		return;
 
-	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
-				nft_trans_set_bound(trans) = true;
+				nft_trans_set_bound(trans) = bind;
 			break;
 		case NFT_MSG_NEWSETELEM:
 			if (nft_trans_elem_set(trans) == set)
-				nft_trans_elem_set_bound(trans) = true;
+				nft_trans_elem_set_bound(trans) = bind;
 			break;
 		}
 	}
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, true);
+}
+
+static void nft_set_trans_unbind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, false);
+}
+
+static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *trans)
+{
+	struct nftables_pernet *nft_net;
+
+	nft_net = net_generic(net, nf_tables_net_id);
+	switch (trans->msg_type) {
+	case NFT_MSG_NEWSET:
+		if (nft_set_is_anonymous(nft_trans_set(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	}
+
+	list_add_tail(&trans->list, &nft_net->commit_list);
+}
+
 static int nf_tables_register_hook(struct net *net,
 				   const struct nft_table *table,
 				   struct nft_chain *chain)
@@ -187,7 +227,7 @@ static int nft_trans_table_add(struct nft_ctx *ctx, int msg_type)
 	if (msg_type == NFT_MSG_NEWTABLE)
 		nft_activate_next(ctx->net, ctx->table);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 }
 
@@ -214,7 +254,7 @@ static int nft_trans_chain_add(struct nft_ctx *ctx, int msg_type)
 	if (msg_type == NFT_MSG_NEWCHAIN)
 		nft_activate_next(ctx->net, ctx->chain);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 }
 
@@ -287,7 +327,7 @@ static struct nft_trans *nft_trans_rule_add(struct nft_ctx *ctx, int msg_type,
 			ntohl(nla_get_be32(ctx->nla[NFTA_RULE_ID]));
 	}
 	nft_trans_rule(trans) = rule;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return trans;
 }
@@ -342,7 +382,7 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 		nft_activate_next(ctx->net, set);
 	}
 	nft_trans_set(trans) = set;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -374,7 +414,7 @@ static int nft_trans_obj_add(struct nft_ctx *ctx, int msg_type,
 		nft_activate_next(ctx->net, obj);
 
 	nft_trans_obj(trans) = obj;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -407,7 +447,7 @@ static int nft_trans_flowtable_add(struct nft_ctx *ctx, int msg_type,
 		nft_activate_next(ctx->net, flowtable);
 
 	nft_trans_flowtable(trans) = flowtable;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -435,12 +475,14 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 					  const struct nlattr *nla,
 					  u8 family, u8 genmask)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (!nla_strcmp(nla, table->name) &&
 		    table->family == family &&
 		    nft_active_genmask(table, genmask))
@@ -454,9 +496,11 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
 						   u8 genmask)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
 		    nft_active_genmask(table, genmask))
 			return table;
@@ -509,11 +553,13 @@ __nf_tables_chain_type_lookup(const struct nlattr *nla, u8 family)
 static void nft_request_module(struct net *net, const char *fmt, ...)
 {
 	char module_name[MODULE_NAME_LEN];
+	struct nftables_pernet *nft_net;
 	LIST_HEAD(commit_list);
 	va_list args;
 	int ret;
 
-	list_splice_init(&net->nft.commit_list, &commit_list);
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_splice_init(&nft_net->commit_list, &commit_list);
 
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
@@ -521,12 +567,12 @@ static void nft_request_module(struct net *net, const char *fmt, ...)
 	if (ret >= MODULE_NAME_LEN)
 		return;
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 	request_module("%s", module_name);
-	mutex_lock(&net->nft.commit_mutex);
+	mutex_lock(&nft_net->commit_mutex);
 
-	WARN_ON_ONCE(!list_empty(&net->nft.commit_list));
-	list_splice(&commit_list, &net->nft.commit_list);
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+	list_splice(&commit_list, &nft_net->commit_list);
 }
 #endif
 
@@ -561,6 +607,13 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 	return ERR_PTR(-ENOENT);
 }
 
+static __be16 nft_base_seq(const struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return htons(nft_net->base_seq & 0xffff);
+}
+
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
 	[NFTA_TABLE_NAME]	= { .type = NLA_STRING,
 				    .len = NFT_TABLE_MAXNAMELEN - 1 },
@@ -573,18 +626,13 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 				     int family, const struct nft_table *table)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_TABLE_NAME, table->name) ||
 	    nla_put_be32(skb, NFTA_TABLE_FLAGS, htonl(table->flags)) ||
 	    nla_put_be32(skb, NFTA_TABLE_USE, htonl(table->use)) ||
@@ -631,15 +679,17 @@ static int nf_tables_dump_tables(struct sk_buff *skb,
 				 struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
+	struct nftables_pernet *nft_net;
 	const struct nft_table *table;
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -743,7 +793,7 @@ static void nft_table_disable(struct net *net, struct nft_table *table, u32 cnt)
 		if (cnt && i++ == cnt)
 			break;
 
-		nf_unregister_net_hook(net, &nft_base_chain(chain)->ops);
+		nf_tables_unregister_hook(net, table, chain);
 	}
 }
 
@@ -758,7 +808,7 @@ static int nf_tables_table_enable(struct net *net, struct nft_table *table)
 		if (!nft_is_base_chain(chain))
 			continue;
 
-		err = nf_register_net_hook(net, &nft_base_chain(chain)->ops);
+		err = nf_tables_register_hook(net, table, chain);
 		if (err < 0)
 			goto err;
 
@@ -802,17 +852,18 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 		nft_trans_table_enable(trans) = false;
 	} else if (!(flags & NFT_TABLE_F_DORMANT) &&
 		   ctx->table->flags & NFT_TABLE_F_DORMANT) {
+		ctx->table->flags &= ~NFT_TABLE_F_DORMANT;
 		ret = nf_tables_table_enable(ctx->net, ctx->table);
-		if (ret >= 0) {
-			ctx->table->flags &= ~NFT_TABLE_F_DORMANT;
+		if (ret >= 0)
 			nft_trans_table_enable(trans) = true;
-		}
+		else
+			ctx->table->flags |= NFT_TABLE_F_DORMANT;
 	}
 	if (ret < 0)
 		goto err;
 
 	nft_trans_table_update(trans) = true;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 err:
 	nft_trans_destroy(trans);
@@ -847,6 +898,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 			      const struct nlattr * const nla[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	int family = nfmsg->nfgen_family;
@@ -856,7 +908,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	struct nft_ctx ctx;
 	int err;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
 	if (IS_ERR(table)) {
@@ -906,7 +958,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	if (err < 0)
 		goto err_trans;
 
-	list_add_tail_rcu(&table->list, &net->nft.tables);
+	list_add_tail_rcu(&table->list, &nft_net->tables);
 	return 0;
 err_trans:
 	rhltable_destroy(&table->chains_ht);
@@ -986,11 +1038,12 @@ static int nft_flush_table(struct nft_ctx *ctx)
 
 static int nft_flush(struct nft_ctx *ctx, int family)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct nft_table *table, *nt;
 	const struct nlattr * const *nla = ctx->nla;
 	int err = 0;
 
-	list_for_each_entry_safe(table, nt, &ctx->net->nft.tables, list) {
+	list_for_each_entry_safe(table, nt, &nft_net->tables, list) {
 		if (family != AF_UNSPEC && table->family != family)
 			continue;
 
@@ -1104,7 +1157,9 @@ nft_chain_lookup_byhandle(const struct nft_table *table, u64 handle, u8 genmask)
 static bool lockdep_commit_lock_is_held(struct net *net)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	return lockdep_is_held(&net->nft.commit_mutex);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return lockdep_is_held(&nft_net->commit_mutex);
 #else
 	return true;
 #endif
@@ -1207,18 +1262,13 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 				     const struct nft_chain *chain)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_CHAIN_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_be64(skb, NFTA_CHAIN_HANDLE, cpu_to_be64(chain->handle),
@@ -1306,11 +1356,13 @@ static int nf_tables_dump_chains(struct sk_buff *skb,
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -1503,12 +1555,13 @@ static int nft_chain_parse_hook(struct net *net,
 				struct nft_chain_hook *hook, u8 family,
 				bool autoload)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlattr *ha[NFTA_HOOK_MAX + 1];
 	const struct nft_chain_type *type;
 	struct net_device *dev;
 	int err;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
 
 	err = nla_parse_nested(ha, NFTA_HOOK_MAX, nla[NFTA_CHAIN_HOOK],
@@ -1777,6 +1830,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy)
 
 	if (nla[NFTA_CHAIN_HANDLE] &&
 	    nla[NFTA_CHAIN_NAME]) {
+		struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 		struct nft_trans *tmp;
 		char *name;
 
@@ -1786,7 +1840,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy)
 			goto err;
 
 		err = -EEXIST;
-		list_for_each_entry(tmp, &ctx->net->nft.commit_list, list) {
+		list_for_each_entry(tmp, &nft_net->commit_list, list) {
 			if (tmp->msg_type == NFT_MSG_NEWCHAIN &&
 			    tmp->ctx.table == table &&
 			    nft_trans_chain_update(tmp) &&
@@ -1799,7 +1853,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy)
 
 		nft_trans_chain_name(trans) = name;
 	}
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 err:
@@ -1813,6 +1867,7 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 			      const struct nlattr * const nla[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	int family = nfmsg->nfgen_family;
@@ -1823,7 +1878,7 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 	struct nft_ctx ctx;
 	u64 handle = 0;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	table = nft_table_lookup(net, nla[NFTA_CHAIN_TABLE], family, genmask);
 	if (IS_ERR(table)) {
@@ -2251,21 +2306,16 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 				    const struct nft_rule *rule)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	const struct nft_expr *expr, *next;
 	struct nlattr *list;
 	const struct nft_rule *prule;
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
-	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
+			   nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_RULE_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_RULE_CHAIN, chain->name))
@@ -2351,11 +2401,13 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -2508,7 +2560,6 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_expr *expr, *next;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
 	/*
 	 * Careful: some expressions might not be initialized in case this
 	 * is called on error from nf_tables_newrule().
@@ -2574,6 +2625,8 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 		err = nft_chain_validate(&ctx, chain);
 		if (err < 0)
 			return err;
+
+		cond_resched();
 	}
 
 	return 0;
@@ -2586,6 +2639,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			     const struct nlattr * const nla[],
 			     struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	struct nft_expr_info *info = NULL;
@@ -2602,7 +2656,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	int err, rem;
 	u64 handle, pos_handle;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	table = nft_table_lookup(net, nla[NFTA_RULE_TABLE], family, genmask);
 	if (IS_ERR(table)) {
@@ -2750,12 +2804,13 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	kvfree(info);
 	chain->use++;
 
-	if (net->nft.validate_state == NFT_VALIDATE_DO)
+	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
 
 	return 0;
 err2:
-	nf_tables_rule_release(&ctx, rule);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
+	nf_tables_rule_destroy(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
 		if (info[i].ops) {
@@ -2772,10 +2827,11 @@ static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
 					     const struct nft_chain *chain,
 					     const struct nlattr *nla)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u32 id = ntohl(nla_get_be32(nla));
 	struct nft_trans *trans;
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		struct nft_rule *rule = nft_trans_rule(trans);
 
 		if (trans->msg_type == NFT_MSG_NEWRULE &&
@@ -2894,12 +2950,13 @@ nft_select_set_ops(const struct nft_ctx *ctx,
 		   const struct nft_set_desc *desc,
 		   enum nft_set_policies policy)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	const struct nft_set_ops *ops, *bops;
 	struct nft_set_estimate est, best;
 	const struct nft_set_type *type;
 	u32 flags = 0;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (list_empty(&nf_tables_set_types)) {
@@ -3045,10 +3102,11 @@ static struct nft_set *nft_set_lookup_byid(const struct net *net,
 					   const struct nft_table *table,
 					   const struct nlattr *nla, u8 genmask)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 	u32 id = ntohl(nla_get_be32(nla));
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->msg_type == NFT_MSG_NEWSET) {
 			struct nft_set *set = nft_trans_set(trans);
 
@@ -3158,23 +3216,17 @@ static __be64 nf_jiffies64_to_msecs(u64 input)
 static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			      const struct nft_set *set, u16 event, u16 flags)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *desc;
 	u32 portid = ctx->portid;
 	u32 seq = ctx->seq;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
+			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= ctx->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(ctx->net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_SET_TABLE, ctx->table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_NAME, set->name))
@@ -3270,14 +3322,16 @@ static int nf_tables_dump_sets(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nft_table *table, *cur_table = (struct nft_table *)cb->args[2];
 	struct net *net = sock_net(skb->sk);
 	struct nft_ctx *ctx = cb->data, ctx_set;
+	struct nftables_pernet *nft_net;
 
 	if (cb->args[1])
 		return skb->len;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
 		    ctx->family != table->family)
 			continue;
@@ -3780,6 +3834,15 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
+		nft_set_trans_unbind(ctx, set);
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
+
+		set->use--;
+		break;
 	case NFT_TRANS_PREPARE:
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
@@ -3984,18 +4047,19 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nft_set_dump_ctx *dump_ctx = cb->data;
 	struct net *net = sock_net(skb->sk);
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct nft_set *set;
 	struct nft_set_dump_args args;
 	bool set_found = false;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 	u32 portid, seq;
 	int event;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (dump_ctx->ctx.family != NFPROTO_UNSPEC &&
 		    dump_ctx->ctx.family != table->family)
 			continue;
@@ -4021,16 +4085,11 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	portid = NETLINK_CB(cb->skb).portid;
 	seq    = cb->nlh->nlmsg_seq;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			NLM_F_MULTI);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
+			   table->family, NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = table->family;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_SET_ELEM_LIST_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_ELEM_LIST_SET, set->name))
@@ -4087,22 +4146,16 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 				       const struct nft_set *set,
 				       const struct nft_set_elem *elem)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 	int err;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
+			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= ctx->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(ctx->net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_SET_TABLE, ctx->table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_NAME, set->name))
@@ -4596,7 +4649,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	nft_trans_elem(trans) = elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 
 err6:
@@ -4621,6 +4674,7 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 				const struct nlattr * const nla[],
 				struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u8 genmask = nft_genmask_next(net);
 	const struct nlattr *attr;
 	struct nft_set *set;
@@ -4650,7 +4704,7 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 			return err;
 	}
 
-	if (net->nft.validate_state == NFT_VALIDATE_DO)
+	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, ctx.table);
 
 	return 0;
@@ -4763,7 +4817,7 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	nft_set_elem_deactivate(ctx->net, set, &elem);
 
 	nft_trans_elem(trans) = elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 
 fail_ops:
@@ -4797,7 +4851,7 @@ static int nft_flush_set(const struct nft_ctx *ctx,
 	nft_set_elem_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) = set;
 	nft_trans_elem(trans) = *elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 err1:
@@ -5138,19 +5192,14 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 				   int family, const struct nft_table *table,
 				   struct nft_object *obj, bool reset)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_OBJ_TABLE, table->name) ||
 	    nla_put_string(skb, NFTA_OBJ_NAME, obj->name) ||
 	    nla_put_be32(skb, NFTA_OBJ_TYPE, htonl(obj->ops->type->type)) ||
@@ -5181,6 +5230,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nft_obj_filter *filter = cb->data;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 	struct nft_object *obj;
 	bool reset = false;
 
@@ -5188,9 +5238,10 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 		reset = true;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -5798,20 +5849,15 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 					 struct nft_flowtable *flowtable)
 {
 	struct nlattr *nest, *nest_devs;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	int i;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(net->nft.base_seq & 0xffff);
-
 	if (nla_put_string(skb, NFTA_FLOWTABLE_TABLE, flowtable->table->name) ||
 	    nla_put_string(skb, NFTA_FLOWTABLE_NAME, flowtable->name) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_USE, htonl(flowtable->use)) ||
@@ -5861,12 +5907,14 @@ static int nf_tables_dump_flowtable(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nft_flowtable *flowtable;
+	struct nftables_pernet *nft_net;
 	const struct nft_table *table;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -6036,21 +6084,17 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), 0);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, 0, AF_UNSPEC,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= AF_UNSPEC;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= htons(net->nft.base_seq & 0xffff);
-
-	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(net->nft.base_seq)) ||
+	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
 		goto nla_put_failure;
@@ -6083,6 +6127,7 @@ static int nf_tables_flowtable_event(struct notifier_block *this,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct nft_flowtable *flowtable;
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct net *net;
 
@@ -6090,13 +6135,14 @@ static int nf_tables_flowtable_event(struct notifier_block *this,
 		return 0;
 
 	net = dev_net(dev);
-	mutex_lock(&net->nft.commit_mutex);
-	list_for_each_entry(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(flowtable, &table->flowtables, list) {
 			nft_flowtable_event(event, dev, flowtable);
 		}
 	}
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -6277,16 +6323,17 @@ static const struct nfnl_callback nf_tables_cb[NFT_MSG_MAX] = {
 
 static int nf_tables_validate(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
 
-	switch (net->nft.validate_state) {
+	switch (nft_net->validate_state) {
 	case NFT_VALIDATE_SKIP:
 		break;
 	case NFT_VALIDATE_NEED:
 		nft_validate_state_update(net, NFT_VALIDATE_DO);
 		/* fall through */
 	case NFT_VALIDATE_DO:
-		list_for_each_entry(table, &net->nft.tables, list) {
+		list_for_each_entry(table, &nft_net->tables, list) {
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
@@ -6363,15 +6410,16 @@ static void nft_commit_release(struct nft_trans *trans)
 
 static void nf_tables_commit_release(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 
-	if (list_empty(&net->nft.commit_list))
+	if (list_empty(&nft_net->commit_list))
 		return;
 
 	synchronize_rcu();
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
-		list_del(&trans->list);
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
+		nft_trans_list_del(trans);
 		nft_commit_release(trans);
 	}
 }
@@ -6409,9 +6457,10 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 
 static void nf_tables_commit_chain_prepare_cancel(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		struct nft_chain *chain = trans->ctx.chain;
 
 		if (trans->msg_type == NFT_MSG_NEWRULE ||
@@ -6503,17 +6552,30 @@ static void nft_chain_del(struct nft_chain *chain)
 
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
 
+	list_for_each_entry(trans, &nft_net->binding_list, binding_list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWSET:
+			if (nft_set_is_anonymous(nft_trans_set(trans)) &&
+			    !nft_trans_set_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound set\n");
+				return -EINVAL;
+			}
+			break;
+		}
+	}
+
 	/* 0. Validate ruleset, otherwise roll back for error reporting. */
 	if (nf_tables_validate(net) < 0)
 		return -EAGAIN;
 
 	/* 1.  Allocate space for next generation rules_gen_X[] */
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		int ret;
 
 		if (trans->msg_type == NFT_MSG_NEWRULE ||
@@ -6529,7 +6591,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	}
 
 	/* step 2.  Make rules_gen_X visible to packet path */
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(chain, &table->chains, list)
 			nf_tables_commit_chain(net, chain);
 	}
@@ -6538,12 +6600,13 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	 * Bump generation counter, invalidate any dump in progress.
 	 * Cannot fail after this point.
 	 */
-	while (++net->nft.base_seq == 0);
+	while (++nft_net->base_seq == 0)
+		;
 
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
 			if (nft_trans_table_update(trans)) {
@@ -6664,7 +6727,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	nf_tables_commit_release(net);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return 0;
 }
@@ -6700,10 +6763,11 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 
 static int __nf_tables_abort(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 
-	list_for_each_entry_safe_reverse(trans, next, &net->nft.commit_list,
+	list_for_each_entry_safe_reverse(trans, next, &nft_net->commit_list,
 					 list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
@@ -6810,8 +6874,8 @@ static int __nf_tables_abort(struct net *net)
 	synchronize_rcu();
 
 	list_for_each_entry_safe_reverse(trans, next,
-					 &net->nft.commit_list, list) {
-		list_del(&trans->list);
+					 &nft_net->commit_list, list) {
+		nft_trans_list_del(trans);
 		nf_tables_abort_release(trans);
 	}
 
@@ -6820,22 +6884,24 @@ static int __nf_tables_abort(struct net *net)
 
 static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	int ret = __nf_tables_abort(net);
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
 }
 
 static bool nf_tables_valid_genid(struct net *net, u32 genid)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	bool genid_ok;
 
-	mutex_lock(&net->nft.commit_mutex);
+	mutex_lock(&nft_net->commit_mutex);
 
-	genid_ok = genid == 0 || net->nft.base_seq == genid;
+	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
-		mutex_unlock(&net->nft.commit_mutex);
+		mutex_unlock(&nft_net->commit_mutex);
 
 	/* else, commit mutex has to be released by commit or abort function */
 	return genid_ok;
@@ -7182,6 +7248,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 	if (!tb[NFTA_VERDICT_CODE])
 		return -EINVAL;
+
+	/* zero padding hole for memcmp */
+	memset(data, 0, sizeof(*data));
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
@@ -7389,10 +7458,9 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
-static void __nft_release_tables(struct net *net)
+static void __nft_release_table(struct net *net, struct nft_table *table)
 {
 	struct nft_flowtable *flowtable, *nf;
-	struct nft_table *table, *nt;
 	struct nft_chain *chain, *nc;
 	struct nft_object *obj, *ne;
 	struct nft_rule *rule, *nr;
@@ -7402,71 +7470,85 @@ static void __nft_release_tables(struct net *net)
 		.family	= NFPROTO_NETDEV,
 	};
 
-	list_for_each_entry_safe(table, nt, &net->nft.tables, list) {
-		ctx.family = table->family;
+	ctx.family = table->family;
 
-		list_for_each_entry(chain, &table->chains, list)
-			nf_tables_unregister_hook(net, table, chain);
-		/* No packets are walking on these chains anymore. */
-		ctx.table = table;
-		list_for_each_entry(chain, &table->chains, list) {
-			ctx.chain = chain;
-			list_for_each_entry_safe(rule, nr, &chain->rules, list) {
-				list_del(&rule->list);
-				chain->use--;
-				nf_tables_rule_release(&ctx, rule);
-			}
-		}
-		list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
-			list_del(&flowtable->list);
-			table->use--;
-			nf_tables_flowtable_destroy(flowtable);
-		}
-		list_for_each_entry_safe(set, ns, &table->sets, list) {
-			list_del(&set->list);
-			table->use--;
-			nft_set_destroy(set);
-		}
-		list_for_each_entry_safe(obj, ne, &table->objects, list) {
-			list_del(&obj->list);
-			table->use--;
-			nft_obj_destroy(&ctx, obj);
-		}
-		list_for_each_entry_safe(chain, nc, &table->chains, list) {
-			ctx.chain = chain;
-			nft_chain_del(chain);
-			table->use--;
-			nf_tables_chain_destroy(&ctx);
+	list_for_each_entry(chain, &table->chains, list)
+		nf_tables_unregister_hook(net, table, chain);
+	/* No packets are walking on these chains anymore. */
+	ctx.table = table;
+	list_for_each_entry(chain, &table->chains, list) {
+		ctx.chain = chain;
+		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
+			list_del(&rule->list);
+			chain->use--;
+			nf_tables_rule_release(&ctx, rule);
 		}
-		list_del(&table->list);
-		nf_tables_table_destroy(&ctx);
 	}
+	list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
+		list_del(&flowtable->list);
+		table->use--;
+		nf_tables_flowtable_destroy(flowtable);
+	}
+	list_for_each_entry_safe(set, ns, &table->sets, list) {
+		list_del(&set->list);
+		table->use--;
+		nft_set_destroy(set);
+	}
+	list_for_each_entry_safe(obj, ne, &table->objects, list) {
+		list_del(&obj->list);
+		table->use--;
+		nft_obj_destroy(&ctx, obj);
+	}
+	list_for_each_entry_safe(chain, nc, &table->chains, list) {
+		ctx.chain = chain;
+		nft_chain_del(chain);
+		table->use--;
+		nf_tables_chain_destroy(&ctx);
+	}
+	list_del(&table->list);
+	nf_tables_table_destroy(&ctx);
+}
+
+static void __nft_release_tables(struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+	struct nft_table *table, *nt;
+
+	list_for_each_entry_safe(table, nt, &nft_net->tables, list)
+		__nft_release_table(net, table);
 }
 
 static int __net_init nf_tables_init_net(struct net *net)
 {
-	INIT_LIST_HEAD(&net->nft.tables);
-	INIT_LIST_HEAD(&net->nft.commit_list);
-	mutex_init(&net->nft.commit_mutex);
-	net->nft.base_seq = 1;
-	net->nft.validate_state = NFT_VALIDATE_SKIP;
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	INIT_LIST_HEAD(&nft_net->tables);
+	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->binding_list);
+	mutex_init(&nft_net->commit_mutex);
+	nft_net->base_seq = 1;
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 
 	return 0;
 }
 
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
-	mutex_lock(&net->nft.commit_mutex);
-	if (!list_empty(&net->nft.commit_list))
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
+	if (!list_empty(&nft_net->commit_list))
 		__nf_tables_abort(net);
 	__nft_release_tables(net);
-	mutex_unlock(&net->nft.commit_mutex);
-	WARN_ON_ONCE(!list_empty(&net->nft.tables));
+	mutex_unlock(&nft_net->commit_mutex);
+	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 }
 
 static struct pernet_operations nf_tables_net_ops = {
 	.init	= nf_tables_init_net,
 	.exit	= nf_tables_exit_net,
+	.id	= &nf_tables_net_id,
+	.size	= sizeof(struct nftables_pernet),
 };
 
 static int __init nf_tables_module_init(void)
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index e1dc527a493b..7a19c517b191 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -186,7 +186,6 @@ static bool nft_trace_have_verdict_chain(struct nft_traceinfo *info)
 void nft_trace_notify(struct nft_traceinfo *info)
 {
 	const struct nft_pktinfo *pkt = info->pkt;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 	unsigned int size;
@@ -222,15 +221,11 @@ void nft_trace_notify(struct nft_traceinfo *info)
 		return;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_TRACE);
-	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(skb, 0, 0, event, 0, info->basechain->type->family,
+			   NFNETLINK_V0, 0);
 	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= info->basechain->type->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= 0;
-
 	if (nla_put_be32(skb, NFTA_TRACE_NFPROTO, htonl(nft_pf(pkt))))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_acct.c b/net/netfilter/nfnetlink_acct.c
index 8fa8bf7c48e6..7c5f428dc5c9 100644
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -135,21 +135,16 @@ nfnl_acct_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		   int event, struct nf_acct *acct)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	u64 pkts, bytes;
 	u32 old_flags;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_ACCT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFACCT_NAME, acct->name))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index c8b0f1122c44..720177721e3c 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -532,20 +532,15 @@ nfnl_cthelper_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			int event, struct nf_conntrack_helper *helper)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	int status;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTHELPER, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFCTH_NAME, helper->name))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 70a7382b9787..ae01e9ad5546 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -164,20 +164,15 @@ ctnl_timeout_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		       int event, struct ctnl_timeout *timeout)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	const struct nf_conntrack_l4proto *l4proto = timeout->timeout.l4proto;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_TIMEOUT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, CTA_TIMEOUT_NAME, timeout->name) ||
 	    nla_put_be16(skb, CTA_TIMEOUT_L3PROTO,
 			 htons(timeout->timeout.l3num)) ||
@@ -396,19 +391,14 @@ cttimeout_default_fill_info(struct net *net, struct sk_buff *skb, u32 portid,
 			    const unsigned int *timeouts)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_TIMEOUT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_be16(skb, CTA_TIMEOUT_L3PROTO, htons(l4proto->l3proto)) ||
 	    nla_put_u8(skb, CTA_TIMEOUT_L4PROTO, l4proto->l4proto))
 		goto nla_put_failure;
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 17ca9a681d47..da05c4d82b94 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -404,20 +404,15 @@ __build_packet_message(struct nfnl_log_net *log,
 {
 	struct nfulnl_msg_packet_hdr pmsg;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	sk_buff_data_t old_tail = inst->skb->tail;
 	struct sock *sk;
 	const unsigned char *hwhdrp;
 
-	nlh = nlmsg_put(inst->skb, 0, 0,
-			nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
-			sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(inst->skb, 0, 0,
+			   nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
+			   0, pf, NFNETLINK_V0, htons(inst->group_num));
 	if (!nlh)
 		return -1;
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = pf;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = htons(inst->group_num);
 
 	memset(&pmsg, 0, sizeof(pmsg));
 	pmsg.hw_protocol	= skb->protocol;
@@ -637,7 +632,7 @@ nfulnl_log_packet(struct net *net,
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index cd496b074a71..1aacc31a6bf9 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -387,12 +387,11 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	struct nlattr *nla;
 	struct nfqnl_msg_packet_hdr *pmsg;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct sk_buff *entskb = entry->skb;
 	struct net_device *indev;
 	struct net_device *outdev;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
 	char *secdata = NULL;
@@ -473,18 +472,15 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 		goto nlmsg_failure;
 	}
 
-	nlh = nlmsg_put(skb, 0, 0,
-			nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
-			sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(skb, 0, 0,
+			   nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
+			   0, entry->state.pf, NFNETLINK_V0,
+			   htons(queue->queue_num));
 	if (!nlh) {
 		skb_tx_error(entskb);
 		kfree_skb(skb);
 		goto nlmsg_failure;
 	}
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = entry->state.pf;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = htons(queue->queue_num);
 
 	nla = __nla_reserve(skb, NFQA_PACKET_HDR, sizeof(*pmsg));
 	pmsg = nla_data(nla);
@@ -1191,7 +1187,7 @@ static int nfqnl_recv_verdict(struct net *net, struct sock *ctnl,
 	struct nfqnl_instance *queue;
 	unsigned int verdict;
 	struct nf_queue_entry *entry;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	struct nf_conn *ct = NULL;
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 5e1fbdd7b284..dba16126c7ee 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -33,11 +33,11 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 	const struct nft_byteorder *priv = nft_expr_priv(expr);
 	u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
-	union { u32 u32; u16 u16; } *s, *d;
+	u16 *s16, *d16;
 	unsigned int i;
 
-	s = (void *)src;
-	d = (void *)dst;
+	s16 = (void *)src;
+	d16 = (void *)dst;
 
 	switch (priv->size) {
 	case 8: {
@@ -63,11 +63,11 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = ntohl((__force __be32)s[i].u32);
+				dst[i] = ntohl((__force __be32)src[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = (__force __u32)htonl(s[i].u32);
+				dst[i] = (__force __u32)htonl(src[i]);
 			break;
 		}
 		break;
@@ -75,11 +75,11 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = ntohs((__force __be16)s[i].u16);
+				d16[i] = ntohs((__force __be16)s16[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = (__force __u16)htons(s[i].u16);
+				d16[i] = (__force __u16)htons(s16[i]);
 			break;
 		}
 		break;
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 3fd540b2c6ba..a308d45ee95e 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/netfilter/nf_tables.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
@@ -10,6 +11,8 @@
 #include <net/netfilter/nf_tables_ipv4.h>
 #include <net/netfilter/nf_tables_ipv6.h>
 
+extern unsigned int nf_tables_net_id;
+
 #ifdef CONFIG_NF_TABLES_IPV4
 static unsigned int nft_do_chain_ipv4(void *priv,
 				      struct sk_buff *skb,
@@ -315,6 +318,7 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 				  unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct nft_chain *chain, *nr;
 	struct nft_ctx ctx = {
@@ -325,8 +329,9 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	    event != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
-	mutex_lock(&ctx.net->nft.commit_mutex);
-	list_for_each_entry(table, &ctx.net->nft.tables, list) {
+	nft_net = net_generic(ctx.net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (table->family != NFPROTO_NETDEV)
 			continue;
 
@@ -340,7 +345,7 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 			nft_netdev_event(event, dev, &ctx);
 		}
 	}
-	mutex_unlock(&ctx.net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 469f9da5073b..2846d64659f2 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -575,19 +575,14 @@ nfnl_compat_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		      int rev, int target)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFT_COMPAT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = family;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFTA_COMPAT_NAME, name) ||
 	    nla_put_be32(skb, NFTA_COMPAT_REV, htonl(rev)) ||
 	    nla_put_be32(skb, NFTA_COMPAT_TYPE, htonl(target)))
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index c5d42e704f04..651c9784904c 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -15,6 +15,9 @@
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 struct nft_dynset {
 	struct nft_set			*set;
@@ -112,13 +115,14 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 			   const struct nft_expr *expr,
 			   const struct nlattr * const tb[])
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct nft_dynset *priv = nft_expr_priv(expr);
 	u8 genmask = nft_genmask_next(ctx->net);
 	struct nft_set *set;
 	u64 timeout;
 	int err;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	if (tb[NFTA_DYNSET_SET_NAME] == NULL ||
 	    tb[NFTA_DYNSET_OP] == NULL ||
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 57fd9b7cfc75..35ecaa93f213 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1603,6 +1603,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 {
 	struct netlink_set_err_data info;
+	unsigned long flags;
 	struct sock *sk;
 	int ret = 0;
 
@@ -1612,12 +1613,12 @@ int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 	/* sk->sk_err wants a positive error value */
 	info.code = -code;
 
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 
 	sk_for_each_bound(sk, &nl_table[ssk->sk_protocol].mc_list)
 		ret += do_one_set_err(sk, &info);
 
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(netlink_set_err);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 7dda33b9b784..85ee4891c2c7 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -93,6 +93,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net *net = sock_net(skb->sk);
 	struct netlink_diag_req *req;
 	struct netlink_sock *nlsk;
+	unsigned long flags;
 	struct sock *sk;
 	int num = 2;
 	int ret = 0;
@@ -151,7 +152,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	num++;
 
 mc_list:
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 	sk_for_each_bound(sk, &tbl->mc_list) {
 		if (sk_hashed(sk))
 			continue;
@@ -166,13 +167,13 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 sock_i_ino(sk)) < 0) {
+				 __sock_i_ino(sk)) < 0) {
 			ret = 1;
 			break;
 		}
 		num++;
 	}
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 
 done:
 	cb->args[0] = num;
diff --git a/net/nfc/core.c b/net/nfc/core.c
index a84f824da051..dd12ee46ac73 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -646,7 +646,7 @@ int nfc_disable_se(struct nfc_dev *dev, u32 se_idx)
 	return rc;
 }
 
-int nfc_set_remote_general_bytes(struct nfc_dev *dev, u8 *gb, u8 gb_len)
+int nfc_set_remote_general_bytes(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	pr_debug("dev_name=%s gb_len=%d\n", dev_name(&dev->dev), gb_len);
 
@@ -675,7 +675,7 @@ int nfc_tm_data_received(struct nfc_dev *dev, struct sk_buff *skb)
 EXPORT_SYMBOL(nfc_tm_data_received);
 
 int nfc_tm_activated(struct nfc_dev *dev, u32 protocol, u8 comm_mode,
-		     u8 *gb, size_t gb_len)
+		     const u8 *gb, size_t gb_len)
 {
 	int rc;
 
diff --git a/net/nfc/hci/llc_shdlc.c b/net/nfc/hci/llc_shdlc.c
index fe988936ad92..e6863c71f566 100644
--- a/net/nfc/hci/llc_shdlc.c
+++ b/net/nfc/hci/llc_shdlc.c
@@ -134,7 +134,7 @@ static bool llc_shdlc_x_lteq_y_lt_z(int x, int y, int z)
 		return ((y >= x) || (y < z)) ? true : false;
 }
 
-static struct sk_buff *llc_shdlc_alloc_skb(struct llc_shdlc *shdlc,
+static struct sk_buff *llc_shdlc_alloc_skb(const struct llc_shdlc *shdlc,
 					   int payload_len)
 {
 	struct sk_buff *skb;
@@ -148,7 +148,7 @@ static struct sk_buff *llc_shdlc_alloc_skb(struct llc_shdlc *shdlc,
 }
 
 /* immediately sends an S frame. */
-static int llc_shdlc_send_s_frame(struct llc_shdlc *shdlc,
+static int llc_shdlc_send_s_frame(const struct llc_shdlc *shdlc,
 				  enum sframe_type sframe_type, int nr)
 {
 	int r;
@@ -170,7 +170,7 @@ static int llc_shdlc_send_s_frame(struct llc_shdlc *shdlc,
 }
 
 /* immediately sends an U frame. skb may contain optional payload */
-static int llc_shdlc_send_u_frame(struct llc_shdlc *shdlc,
+static int llc_shdlc_send_u_frame(const struct llc_shdlc *shdlc,
 				  struct sk_buff *skb,
 				  enum uframe_modifier uframe_modifier)
 {
@@ -372,7 +372,7 @@ static void llc_shdlc_connect_complete(struct llc_shdlc *shdlc, int r)
 	wake_up(shdlc->connect_wq);
 }
 
-static int llc_shdlc_connect_initiate(struct llc_shdlc *shdlc)
+static int llc_shdlc_connect_initiate(const struct llc_shdlc *shdlc)
 {
 	struct sk_buff *skb;
 
@@ -388,7 +388,7 @@ static int llc_shdlc_connect_initiate(struct llc_shdlc *shdlc)
 	return llc_shdlc_send_u_frame(shdlc, skb, U_FRAME_RSET);
 }
 
-static int llc_shdlc_connect_send_ua(struct llc_shdlc *shdlc)
+static int llc_shdlc_connect_send_ua(const struct llc_shdlc *shdlc)
 {
 	struct sk_buff *skb;
 
diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index 1f68724d44d3..a070a57fc151 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -233,15 +233,15 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *sk, struct socket *newsock);
 
 /* TLV API */
 int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
-			  u8 *tlv_array, u16 tlv_array_len);
+			  const u8 *tlv_array, u16 tlv_array_len);
 int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
-				  u8 *tlv_array, u16 tlv_array_len);
+				  const u8 *tlv_array, u16 tlv_array_len);
 
 /* Commands API */
 void nfc_llcp_recv(void *data, struct sk_buff *skb, int err);
-u8 *nfc_llcp_build_tlv(u8 type, u8 *value, u8 value_length, u8 *tlv_length);
+u8 *nfc_llcp_build_tlv(u8 type, const u8 *value, u8 value_length, u8 *tlv_length);
 struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdres_tlv(u8 tid, u8 sap);
-struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
+struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 						  size_t uri_len);
 void nfc_llcp_free_sdp_tlv(struct nfc_llcp_sdp_tlv *sdp);
 void nfc_llcp_free_sdp_tlv_list(struct hlist_head *sdp_head);
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index d1fc019e932e..737c7aa384f4 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -27,7 +27,7 @@
 #include "nfc.h"
 #include "llcp.h"
 
-static u8 llcp_tlv_length[LLCP_TLV_MAX] = {
+static const u8 llcp_tlv_length[LLCP_TLV_MAX] = {
 	0,
 	1, /* VERSION */
 	2, /* MIUX */
@@ -41,7 +41,7 @@ static u8 llcp_tlv_length[LLCP_TLV_MAX] = {
 
 };
 
-static u8 llcp_tlv8(u8 *tlv, u8 type)
+static u8 llcp_tlv8(const u8 *tlv, u8 type)
 {
 	if (tlv[0] != type || tlv[1] != llcp_tlv_length[tlv[0]])
 		return 0;
@@ -49,7 +49,7 @@ static u8 llcp_tlv8(u8 *tlv, u8 type)
 	return tlv[2];
 }
 
-static u16 llcp_tlv16(u8 *tlv, u8 type)
+static u16 llcp_tlv16(const u8 *tlv, u8 type)
 {
 	if (tlv[0] != type || tlv[1] != llcp_tlv_length[tlv[0]])
 		return 0;
@@ -58,37 +58,37 @@ static u16 llcp_tlv16(u8 *tlv, u8 type)
 }
 
 
-static u8 llcp_tlv_version(u8 *tlv)
+static u8 llcp_tlv_version(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_VERSION);
 }
 
-static u16 llcp_tlv_miux(u8 *tlv)
+static u16 llcp_tlv_miux(const u8 *tlv)
 {
 	return llcp_tlv16(tlv, LLCP_TLV_MIUX) & 0x7ff;
 }
 
-static u16 llcp_tlv_wks(u8 *tlv)
+static u16 llcp_tlv_wks(const u8 *tlv)
 {
 	return llcp_tlv16(tlv, LLCP_TLV_WKS);
 }
 
-static u16 llcp_tlv_lto(u8 *tlv)
+static u16 llcp_tlv_lto(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_LTO);
 }
 
-static u8 llcp_tlv_opt(u8 *tlv)
+static u8 llcp_tlv_opt(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_OPT);
 }
 
-static u8 llcp_tlv_rw(u8 *tlv)
+static u8 llcp_tlv_rw(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_RW) & 0xf;
 }
 
-u8 *nfc_llcp_build_tlv(u8 type, u8 *value, u8 value_length, u8 *tlv_length)
+u8 *nfc_llcp_build_tlv(u8 type, const u8 *value, u8 value_length, u8 *tlv_length)
 {
 	u8 *tlv, length;
 
@@ -142,7 +142,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdres_tlv(u8 tid, u8 sap)
 	return sdres;
 }
 
-struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
+struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 						  size_t uri_len)
 {
 	struct nfc_llcp_sdp_tlv *sdreq;
@@ -202,9 +202,10 @@ void nfc_llcp_free_sdp_tlv_list(struct hlist_head *head)
 }
 
 int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
-			  u8 *tlv_array, u16 tlv_array_len)
+			  const u8 *tlv_array, u16 tlv_array_len)
 {
-	u8 *tlv = tlv_array, type, length, offset = 0;
+	const u8 *tlv = tlv_array;
+	u8 type, length, offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +252,10 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 }
 
 int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
-				  u8 *tlv_array, u16 tlv_array_len)
+				  const u8 *tlv_array, u16 tlv_array_len)
 {
-	u8 *tlv = tlv_array, type, length, offset = 0;
+	const u8 *tlv = tlv_array;
+	u8 type, length, offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -307,7 +309,7 @@ static struct sk_buff *llcp_add_header(struct sk_buff *pdu,
 	return pdu;
 }
 
-static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, u8 *tlv,
+static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, const u8 *tlv,
 				    u8 tlv_length)
 {
 	/* XXX Add an skb length check */
@@ -401,9 +403,11 @@ int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local;
 	struct sk_buff *skb;
-	u8 *service_name_tlv = NULL, service_name_tlv_length;
-	u8 *miux_tlv = NULL, miux_tlv_length;
-	u8 *rw_tlv = NULL, rw_tlv_length, rw;
+	const u8 *service_name_tlv = NULL;
+	const u8 *miux_tlv = NULL;
+	const u8 *rw_tlv = NULL;
+	u8 service_name_tlv_length = 0;
+	u8 miux_tlv_length,  rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
@@ -477,8 +481,9 @@ int nfc_llcp_send_cc(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local;
 	struct sk_buff *skb;
-	u8 *miux_tlv = NULL, miux_tlv_length;
-	u8 *rw_tlv = NULL, rw_tlv_length, rw;
+	const u8 *miux_tlv = NULL;
+	const u8 *rw_tlv = NULL;
+	u8 miux_tlv_length, rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 3290f2275b85..bdc1a9d0965a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -314,7 +314,7 @@ static char *wks[] = {
 	"urn:nfc:sn:snep",
 };
 
-static int nfc_llcp_wks_sap(char *service_name, size_t service_name_len)
+static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
@@ -338,7 +338,7 @@ static int nfc_llcp_wks_sap(char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -535,7 +535,7 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 {
 	u8 *gb_cur, version, version_length;
 	u8 lto_length, wks_length, miux_length;
-	u8 *version_tlv = NULL, *lto_tlv = NULL,
+	const u8 *version_tlv = NULL, *lto_tlv = NULL,
 	   *wks_tlv = NULL, *miux_tlv = NULL;
 	__be16 wks = cpu_to_be16(local->local_wks);
 	u8 gb_len = 0;
@@ -625,7 +625,7 @@ u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
 	return local->gb;
 }
 
-int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len)
+int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	struct nfc_llcp_local *local;
 
@@ -652,27 +652,27 @@ int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len)
 				     local->remote_gb_len - 3);
 }
 
-static u8 nfc_llcp_dsap(struct sk_buff *pdu)
+static u8 nfc_llcp_dsap(const struct sk_buff *pdu)
 {
 	return (pdu->data[0] & 0xfc) >> 2;
 }
 
-static u8 nfc_llcp_ptype(struct sk_buff *pdu)
+static u8 nfc_llcp_ptype(const struct sk_buff *pdu)
 {
 	return ((pdu->data[0] & 0x03) << 2) | ((pdu->data[1] & 0xc0) >> 6);
 }
 
-static u8 nfc_llcp_ssap(struct sk_buff *pdu)
+static u8 nfc_llcp_ssap(const struct sk_buff *pdu)
 {
 	return pdu->data[1] & 0x3f;
 }
 
-static u8 nfc_llcp_ns(struct sk_buff *pdu)
+static u8 nfc_llcp_ns(const struct sk_buff *pdu)
 {
 	return pdu->data[2] >> 4;
 }
 
-static u8 nfc_llcp_nr(struct sk_buff *pdu)
+static u8 nfc_llcp_nr(const struct sk_buff *pdu)
 {
 	return pdu->data[2] & 0xf;
 }
@@ -814,7 +814,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
-						  u8 *sn, size_t sn_len)
+						  const u8 *sn, size_t sn_len)
 {
 	struct nfc_llcp_sock *llcp_sock;
 
@@ -828,9 +828,10 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 	return llcp_sock;
 }
 
-static u8 *nfc_llcp_connect_sn(struct sk_buff *skb, size_t *sn_len)
+static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
-	u8 *tlv = &skb->data[2], type, length;
+	u8 type, length;
+	const u8 *tlv = &skb->data[2];
 	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
 
 	while (offset < tlv_array_len) {
@@ -888,7 +889,7 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
 }
 
 static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
-				  struct sk_buff *skb)
+				  const struct sk_buff *skb)
 {
 	struct sock *new_sk, *parent;
 	struct nfc_llcp_sock *sock, *new_sock;
@@ -906,7 +907,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 			goto fail;
 		}
 	} else {
-		u8 *sn;
+		const u8 *sn;
 		size_t sn_len;
 
 		sn = nfc_llcp_connect_sn(skb, &sn_len);
@@ -1125,7 +1126,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 }
 
 static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
-			       struct sk_buff *skb)
+			       const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1168,7 +1169,8 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-static void nfc_llcp_recv_cc(struct nfc_llcp_local *local, struct sk_buff *skb)
+static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
+			     const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1201,7 +1203,8 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local, struct sk_buff *skb)
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-static void nfc_llcp_recv_dm(struct nfc_llcp_local *local, struct sk_buff *skb)
+static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
+			     const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1239,12 +1242,13 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local, struct sk_buff *skb)
 }
 
 static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
-			      struct sk_buff *skb)
+			      const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
-	u8 dsap, ssap, *tlv, type, length, tid, sap;
+	u8 dsap, ssap, type, length, tid, sap;
+	const u8 *tlv;
 	u16 tlv_len, offset;
-	char *service_name;
+	const char *service_name;
 	size_t service_name_len;
 	struct nfc_llcp_sdp_tlv *sdp;
 	HLIST_HEAD(llc_sdres_list);
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 6c6f76b370b1..c792165f523f 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -60,7 +60,7 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 			u8 comm_mode, u8 rf_mode);
 int nfc_llcp_register_device(struct nfc_dev *dev);
 void nfc_llcp_unregister_device(struct nfc_dev *dev);
-int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len);
+int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
 u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index aeb8f84cbd9e..255d4ecf6252 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -29,6 +29,7 @@ static struct tc_action_ops act_pedit_ops;
 
 static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
 	[TCA_PEDIT_PARMS]	= { .len = sizeof(struct tc_pedit) },
+	[TCA_PEDIT_PARMS_EX]	= { .len = sizeof(struct tc_pedit) },
 	[TCA_PEDIT_KEYS_EX]   = { .type = NLA_NESTED },
 };
 
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 55bf75cb1f16..164049d20f4d 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -229,7 +229,7 @@ static u32 flow_get_skgid(const struct sk_buff *skb)
 
 static u32 flow_get_vlan_tag(const struct sk_buff *skb)
 {
-	u16 uninitialized_var(tag);
+	u16 tag;
 
 	if (vlan_get_tag(skb, &tag) < 0)
 		return 0;
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index cb2c62605fc7..5284a473c697 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -221,11 +221,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 #ifdef CONFIG_NET_CLS_IND
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
@@ -244,6 +239,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 4c7fa1cfd8e3..a924292623ec 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -513,7 +513,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d30256ac3537..1e71ff093c91 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -778,11 +778,22 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct netlink_ext_ack *extack)
 {
 	int err;
+#ifdef CONFIG_NET_CLS_IND
+	int ifindex = -1;
+#endif
 
 	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr, extack);
 	if (err < 0)
 		return err;
 
+#ifdef CONFIG_NET_CLS_IND
+	if (tb[TCA_U32_INDEV]) {
+		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
+		if (ifindex < 0)
+			return -EINVAL;
+	}
+#endif
+
 	if (tb[TCA_U32_LINK]) {
 		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
 		struct tc_u_hnode *ht_down = NULL, *ht_old;
@@ -814,13 +825,8 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 	}
 
 #ifdef CONFIG_NET_CLS_IND
-	if (tb[TCA_U32_INDEV]) {
-		int ret;
-		ret = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-		if (ret < 0)
-			return -EINVAL;
-		n->ifindex = ret;
-	}
+	if (ifindex >= 0)
+		n->ifindex = ifindex;
 #endif
 	return 0;
 }
@@ -873,7 +879,6 @@ static struct tc_u_knode *u32_init_knode(struct tcf_proto *tp,
 	new->ifindex = n->ifindex;
 #endif
 	new->fshift = n->fshift;
-	new->res = n->res;
 	new->flags = n->flags;
 	RCU_INIT_POINTER(new->ht_down, ht);
 
@@ -1061,18 +1066,62 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
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
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 01a177cfa533..d91665ea7b14 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1649,7 +1649,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb);
-	int uninitialized_var(ret);
+	int ret;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
index 2974f7262f88..7f0a5d22deaf 100644
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -365,7 +365,7 @@ cbq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	    struct sk_buff **to_free)
 {
 	struct cbq_sched_data *q = qdisc_priv(sch);
-	int uninitialized_var(ret);
+	int ret;
 	struct cbq_class *cl = cbq_classify(skb, sch, &ret);
 
 #ifdef CONFIG_NET_CLS_ACT
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index e4f69c779b8c..7a4777ee0536 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -192,7 +192,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	unsigned int idx, prev_backlog, prev_qlen;
 	struct fq_codel_flow *flow;
-	int uninitialized_var(ret);
+	int ret;
 	unsigned int pkt_len;
 	bool memory_limited;
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 64d7f876d7de..c0ab1e38e80c 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -132,6 +132,97 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
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
@@ -141,9 +232,6 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *qdisc;
 	int i, err = -EOPNOTSUPP;
 	struct tc_mqprio_qopt *qopt = NULL;
-	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
-	struct nlattr *attr;
-	int rem;
 	int len;
 
 	BUILD_BUG_ON(TC_MAX_QUEUE != TC_QOPT_MAX_QUEUE);
@@ -168,55 +256,9 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 
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
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index c2a68f6e427e..e9420ca261d6 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -387,8 +387,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
 
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > (1UL << QFQ_MTU_SHIFT))
+		return -EINVAL;
+
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 1bfdf90fa0cc..07721a1e98d8 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -353,7 +353,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	unsigned int hash, dropped;
 	sfq_index x, qlen;
 	struct sfq_slot *slot;
-	int uninitialized_var(ret);
+	int ret;
 	struct sk_buff *head;
 	int delta;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index a68f3d6b7233..baa825751c39 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -380,9 +380,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *sp)
 	struct net *net = sock_net(&sp->inet.sk);
 
 	if (net->sctp.default_auto_asconf) {
-		spin_lock(&net->sctp.addr_wq_lock);
+		spin_lock_bh(&net->sctp.addr_wq_lock);
 		list_add_tail(&sp->auto_asconf_list, &net->sctp.auto_asconf_splist);
-		spin_unlock(&net->sctp.addr_wq_lock);
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
 		sp->do_auto_asconf = 1;
 	}
 }
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d0b5a1c47a32..b5ee21d5d1f3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -757,12 +757,6 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	dprintk("svc: socket %p TCP (listen) state change %d\n",
 		sk, sk->sk_state);
 
-	if (svsk) {
-		/* Refer to svc_setup_socket() for details. */
-		rmb();
-		svsk->sk_odata(sk);
-	}
-
 	/*
 	 * This callback may called twice when a new connection
 	 * is established as a child socket inherits everything
@@ -771,15 +765,20 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	 *    when one of child sockets become ESTABLISHED.
 	 * 2) data_ready method of the child socket may be called
 	 *    when it receives data before the socket is accepted.
-	 * In case of 2, we should ignore it silently.
+	 * In case of 2, we should ignore it silently and DO NOT
+	 * dereference svsk.
 	 */
-	if (sk->sk_state == TCP_LISTEN) {
-		if (svsk) {
-			set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
-			svc_xprt_enqueue(&svsk->sk_xprt);
-		} else
-			printk("svc: socket %p: no user data\n", sk);
-	}
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
+	if (svsk) {
+		/* Refer to svc_setup_socket() for details. */
+		rmb();
+		svsk->sk_odata(sk);
+		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
+		svc_xprt_enqueue(&svsk->sk_xprt);
+	} else
+		printk("svc: socket %p: no user data\n", sk);
 }
 
 /*
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b0dcbb08e60d..8971341c4f8a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -706,7 +706,7 @@ static int unix_set_peek_off(struct sock *sk, int val)
 	if (mutex_lock_interruptible(&u->iolock))
 		return -EINTR;
 
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	mutex_unlock(&u->iolock);
 
 	return 0;
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 76a80a41615b..a57f54bc0e1a 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -796,6 +796,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
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
diff --git a/samples/bpf/tcp_basertt_kern.c b/samples/bpf/tcp_basertt_kern.c
index 4bf4fc597db9..653d233714ad 100644
--- a/samples/bpf/tcp_basertt_kern.c
+++ b/samples/bpf/tcp_basertt_kern.c
@@ -54,7 +54,7 @@ int bpf_basertt(struct bpf_sock_ops *skops)
 		case BPF_SOCK_OPS_BASE_RTT:
 			n = bpf_getsockopt(skops, SOL_TCP, TCP_CONGESTION,
 					   cong, sizeof(cong));
-			if (!n && !__builtin_memcmp(cong, nv, sizeof(nv)+1)) {
+			if (!n && !__builtin_memcmp(cong, nv, sizeof(nv))) {
 				/* Set base_rtt to 80us */
 				rv = 80;
 			} else if (n) {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8c2847ef4e42..2060a3fe9691 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1260,6 +1260,10 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 	if (relsym->st_name != 0)
 		return relsym;
 
+	/*
+	 * Strive to find a better symbol name, but the resulting name may not
+	 * match the symbol referenced in the original code.
+	 */
 	relsym_secindex = get_secindex(elf, relsym);
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != relsym_secindex)
@@ -1747,19 +1751,33 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define	R_ARM_THM_JUMP19	51
 #endif
 
+static int32_t sign_extend32(int32_t value, int index)
+{
+	uint8_t shift = 31 - index;
+
+	return (int32_t)(value << shift) >> shift;
+}
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
+	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
+	void *loc = reloc_location(elf, sechdr, r);
+	uint32_t inst;
+	int32_t offset;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
-		/* From ARM ABI: (S + A) | T */
-		r->r_addend = (int)(long)
-			      (elf->symtab_start + ELF_R_SYM(r->r_info));
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		r->r_addend = inst + sym->st_value;
 		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		offset = sign_extend32((inst & 0x00ffffff) << 2, 25);
+		r->r_addend = offset + sym->st_value + 8;
+		break;
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
 	case R_ARM_THM_JUMP19:
diff --git a/scripts/tags.sh b/scripts/tags.sh
index 26de7d5aa5c8..de02c44549f7 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -28,6 +28,13 @@ fi
 # ignore userspace tools
 ignore="$ignore ( -path ${tree}tools ) -prune -o"
 
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [[ "$1" == "gtags" && -n "${tree}" ]]; then
+	tree=$(realpath "$tree")/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -136,7 +143,7 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	all_target_sources | gtags -i -C "${tree:-.}" -f - "$PWD"
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 6d1efe1359f1..9c036a41e734 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -474,7 +474,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
+ * @attr: iattr structure containing the new file attributes
  *
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 5a6810041e5c..d5b9253ebd12 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -46,12 +46,10 @@ static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
 		else if (inode > iint->inode)
 			n = n->rb_right;
 		else
-			break;
+			return iint;
 	}
-	if (!n)
-		return NULL;
 
-	return iint;
+	return NULL;
 }
 
 /*
@@ -116,10 +114,15 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 		parent = *p;
 		test_iint = rb_entry(parent, struct integrity_iint_cache,
 				     rb_node);
-		if (inode < test_iint->inode)
+		if (inode < test_iint->inode) {
 			p = &(*p)->rb_left;
-		else
+		} else if (inode > test_iint->inode) {
 			p = &(*p)->rb_right;
+		} else {
+			write_unlock(&integrity_iint_lock);
+			kmem_cache_free(iint_cache, iint);
+			return test_iint;
+		}
 	}
 
 	iint->inode = inode;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 00d826b048c4..eb6735f16b93 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -236,7 +236,7 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 {
 	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, type, size;
-	int uninitialized_var(count);
+	int count;
 	unsigned int indirect;
 
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 074b15fcb0ac..06e0fc7b6417 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -378,6 +378,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 {
 	struct snd_jack_kctl *jack_kctl;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
+	struct input_dev *idev;
 	int i;
 #endif
 
@@ -389,30 +390,28 @@ void snd_jack_report(struct snd_jack *jack, int status)
 					    status & jack_kctl->mask_bits);
 
 #ifdef CONFIG_SND_JACK_INPUT_DEV
-	mutex_lock(&jack->input_dev_lock);
-	if (!jack->input_dev) {
-		mutex_unlock(&jack->input_dev_lock);
+	idev = input_get_device(jack->input_dev);
+	if (!idev)
 		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(jack->key); i++) {
 		int testbit = SND_JACK_BTN_0 >> i;
 
 		if (jack->type & testbit)
-			input_report_key(jack->input_dev, jack->key[i],
+			input_report_key(idev, jack->key[i],
 					 status & testbit);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
 		int testbit = 1 << i;
 		if (jack->type & testbit)
-			input_report_switch(jack->input_dev,
+			input_report_switch(idev,
 					    jack_switch_types[i],
 					    status & testbit);
 	}
 
-	input_sync(jack->input_dev);
-	mutex_unlock(&jack->input_dev_lock);
+	input_sync(idev);
+	input_put_device(idev);
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 }
 EXPORT_SYMBOL(snd_jack_report);
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index c16c8151160c..970aef2cf513 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -116,7 +116,7 @@ static void info_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 int snd_sb_csp_new(struct snd_sb *chip, int device, struct snd_hwdep ** rhwdep)
 {
 	struct snd_sb_csp *p;
-	int uninitialized_var(version);
+	int version;
 	int err;
 	struct snd_hwdep *hw;
 
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index a276c4283c7b..3f13666a0190 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2026,8 +2026,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		.dev_disconnect =	snd_ac97_dev_disconnect,
 	};
 
-	if (rac97)
-		*rac97 = NULL;
+	if (!rac97)
+		return -EINVAL;
 	if (snd_BUG_ON(!bus || !template))
 		return -EINVAL;
 	if (snd_BUG_ON(template->num >= 4))
diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 4b5731a41876..cd93e93a5983 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -23,6 +23,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
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
index 5080d7a3c279..662f1f85ba36 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -563,13 +563,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
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
index 0ca805492ac4..8c55bf384bc6 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,7 +22,6 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 57130edaf3ab..834e542021fe 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -45,7 +45,12 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_max_gain_tlv, -650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_min_gain_tlv, -1200, 150, 0);
-static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_target_tlv, -1650, 150, 0);
+
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(alc_target_tlv,
+	0, 10, TLV_DB_SCALE_ITEM(-1650, 150, 0),
+	11, 11, TLV_DB_SCALE_ITEM(-150, 0, 0),
+);
+
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
 	0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
 	8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
@@ -107,7 +112,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 		       alc_max_gain_tlv),
 	SOC_SINGLE_TLV("ALC Capture Min Volume", ES8316_ADC_ALC2, 0, 28, 0,
 		       alc_min_gain_tlv),
-	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 10, 0,
+	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 11, 0,
 		       alc_target_tlv),
 	SOC_SINGLE("ALC Capture Hold Time", ES8316_ADC_ALC3, 0, 10, 0),
 	SOC_SINGLE("ALC Capture Decay Time", ES8316_ADC_ALC4, 4, 10, 0),
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index d14e851b9160..03d3b0f17f87 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2264,6 +2264,9 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
+	/* Fill the cache for the ADC test register */
+	regmap_read(wm8904->regmap, WM8904_ADC_TEST_0, &val);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 740b90df44bb..0a1ba64ed63c 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -614,6 +614,8 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(regmap, REG_SPDIF_SCR, dmaen, 0);
 		regmap_update_bits(regmap, REG_SPDIF_SIE, intr, 0);
+		regmap_write(regmap, REG_SPDIF_STL, 0x0);
+		regmap_write(regmap, REG_SPDIF_STR, 0x0);
 		break;
 	default:
 		return -EINVAL;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e428d8b36c00..56119a96d350 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -324,7 +324,7 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 	while (test_bit(EP_FLAG_RUNNING, &ep->flags)) {
 
 		unsigned long flags;
-		struct snd_usb_packet_info *uninitialized_var(packet);
+		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
 		int err, i;
 
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
new file mode 100644
index 000000000000..319f36ebb9a4
--- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# skip if there's no gcc
+if ! [ -x "$(command -v gcc)" ]; then
+        echo "failed: no gcc compiler"
+        exit 2
+fi
+
+temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo || true
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res = 0;
+  for (j = 0; j < i && j < t->c; j++)
+    res += t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c = argc;
+  g.p = j;
+  for (i = 0; i < argc; i++)
+    j[i] = (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 6de57d9ee7cc..db099dc20a68 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1020,7 +1020,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	ret = die_get_typename(vr_die, buf);
 	if (ret < 0) {
 		pr_debug("Failed to get type, make it unknown.\n");
-		ret = strbuf_add(buf, " (unknown_type)", 14);
+		ret = strbuf_add(buf, "(unknown_type)", 14);
 	}
 
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e2a6c22959f2..aabd42378552 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1499,6 +1499,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+	decoder->cyc_ref_timestamp = decoder->timestamp;
+	decoder->cycle_cnt = 0;
 }
 
 static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
