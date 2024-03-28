Return-Path: <linux-kernel+bounces-123068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F258901B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9CE1C22D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EF85930;
	Thu, 28 Mar 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="KPsui874";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aO62qSft"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EA1DDF6;
	Thu, 28 Mar 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636085; cv=none; b=Y3lAZHrcm6JLBysRjg1YF5ifh3faAn+ehIrcgzZcUuTFbL9uKHFs6qGCP6FLRjrn+iDd8Q5c6ZGugc7VvU49KSiRUF44UpPnqLQnHwWRuUnz/xyDr+SzCjkBHN39Kj89MM6Skplyk0FwqLtQ6PjxRmiUZfFcDB8qvPN/2DbTTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636085; c=relaxed/simple;
	bh=mwGtBgGJj6bBMqTbrLQj1+R4eADWpsK1gfd2taxNtNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L7p21pJuq5JA181MKfwcd/fdcO+rk6BO/5Lh5HkGZbXbEQP4RvFZNAeKCg8CL2eDMo988eYpZ3DxQtxQpB7pZAPH4b5y14n4rEnU/lpMUDvoMSOreR3h4Vvj/pfJWiPv6PIvR+/pvcE6F84HqcD2/L+UjBXTkmTtyDS38c8YOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=KPsui874; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aO62qSft; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 815151140141;
	Thu, 28 Mar 2024 10:28:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Mar 2024 10:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1711636082; x=1711722482; bh=9S
	0hsBa+ooMwSt3IfFcNHyKHIupDb10Kyxeb/hBGlq4=; b=KPsui874iMg+NdeupL
	HqhmcdVgJMPhMIAIOHwKOhpHKRaV4Q0lxBYqnGNboVNUUeHOG6H4huq9KBVRgeRP
	1iJdZzYduty2QhlVlWq4BOcSiZbeiItXeVvr/44cR1eITiOAPJ6ZBbQt4DVjRH8Z
	NHhBVuEYE7vnutOaUcZN2nxbzCWw19CQFLuvlnYF/h+lwBpx1sLG+CFjVmye1LDw
	melXnipPTPynIode5q08R72s6cPcFb+McPE3ozDLq32/EtdDA2FOXebGHiddDKln
	nxPWtXJp7lP7YxvY+j6YOpPMIC25PxqTq2PWr7w6jm+eeCdAVoVWGK8uz+hq596U
	65Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711636082; x=1711722482; bh=9S0hsBa+ooMwS
	t3IfFcNHyKHIupDb10Kyxeb/hBGlq4=; b=aO62qSftb7Dofp+tANAbacqUICmEe
	/SdEQwusZI4p/hy8LjdK3hx3u55WnoSPDmF2cNZVOhMry5thOSVjqW8iqfSlXrpP
	+1fKU2BmPQ/QYIKLOHqzrrI08nSdmdVzliu9xt/JJ2KUNZ4dJak/VHhNNIkWGfQi
	ANumU7Gj2kM+FVb6YRljKJffFhfSFDScwBpLrGL/kzxui4bzZ67e+G5vYOxQe47F
	6sL6K3dxlJx6WQ3L2kwoqtj7LkIW2xYtMQ4fp7snMpOMv3Vk2wx+4vkNnK43Wstv
	+bRteI5aQfMkkTmHUwvdSa2j16+jVDbRlFoG672/p1bHu0wDe6kR6KCXw==
X-ME-Sender: <xms:cX4FZjfJlZXo0SSyHwwkPwr38aPqERdXyPCbqnw9Ympz5WFjSbMIbw>
    <xme:cX4FZpMyOLwo8COTQPfu3WdEtQ6fqVL1pxwkS-c_n9ZWWEiyBSIbrfkNHlpir0OU2
    jyJzbnJJmILGtnAc_0>
X-ME-Received: <xmr:cX4FZsjyQbK2gcalnhaCP2fwqct_eRuphtOOGM6hPGX-8INTpeohHGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepuddtudevudffjeffhfelgeeileektdelleelkeekteeltefgudei
    keeuhfejvefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpshgtrghllhefvddqoh
    efvddrshgspdhstggrlhhlieegqdhnfedvrdhssgdpshgtrghllheigedqnheigedrshgs
    pdhstggrlhhlieegqdhofedvrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cX4FZk97d6sDT9sx3s1VLqyYoNhGlTYs5LI9VVNIGZ414ZidcwNNIg>
    <xmx:cn4FZvs-wMVW9uOwJ4GnSnYuitpRl9sMkgf21tOno5uGRKi051hTtA>
    <xmx:cn4FZjHvuiUdv9YBGy9WuoA18sCNJ8RoFMNcc-Kqspj_3wkVPSNTdQ>
    <xmx:cn4FZmNvR3UecyoGyQEOO1KG2xWlHSm7g77s6fDDqfb_egd2bkQbig>
    <xmx:cn4FZo-HrzcW94TYy_Gf3hsqGr6UPH9oCJ42SOxtE81f_WfjDBwwKQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 10:28:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 28 Mar 2024 14:27:56 +0000
Subject: [PATCH] MIPS: scall: Save thread_info.syscall unconditionally on
 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-mips_save_syscall-v1-1-9e1d62d6999d@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAGt+BWYC/x3MSwqAMAwA0auUrC2YKvi5ikipNWpAqzQginh3i
 8u3mHlAKDIJtOqBSCcL7yEBMwV+cWEmzWMymNyUeWFqvfEhVtxJVm7xbl31QGWFBaL3zQCpOyJ
 NfP3Prn/fD55Z+nhjAAAA
To: Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xi Ruoyao <xry111@xry111.site>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8391;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=mwGtBgGJj6bBMqTbrLQj1+R4eADWpsK1gfd2taxNtNU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTWusLwF3KzudmW7EhKPaXzxlLNfeuykJUbeyUXOM6e8
 6qt1iGjo5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACayupCRYXOzrmxRd3qB0IWS
 QNcy7lXBzIv38xeqn7mmLvazs/Doe0aGWYfUrffxvG0vDo39mLZCtef6xgW7fz12M1VYWfkkXb6
 UHQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

thread_info.syscall is used by syscall_get_nr to supply syscall nr
over a thread stack frame.

Previously, thread_info.syscall is only saved at syscall_trace_enter
when syscall tracing is enabled. However rest of the kernel code do
expect syscall_get_nr to be available without syscall tracing. The
previous design breaks collect_syscall.

Move saving process to syscall entry to fix it.

Reported-by: Xi Ruoyao <xry111@xry111.site>
Link: https://github.com/util-linux/util-linux/issues/2867
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/ptrace.h |  2 +-
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/ptrace.c      | 15 ++++++---------
 arch/mips/kernel/scall32-o32.S | 23 +++++++++++++----------
 arch/mips/kernel/scall64-n32.S |  3 ++-
 arch/mips/kernel/scall64-n64.S |  3 ++-
 arch/mips/kernel/scall64-o32.S | 33 +++++++++++++++++----------------
 7 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index d14d0e37ad02..4a2b40ce39e0 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -159,7 +159,7 @@ extern unsigned long exception_ip(struct pt_regs *regs);
 #define exception_ip(regs) exception_ip(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 
-extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
+extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
 extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 extern void die(const char *, struct pt_regs *) __noreturn;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index d1b11f66f748..cb1045ebab06 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -101,6 +101,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
 	OFFSET(TI_REGS, thread_info, regs);
+	OFFSET(TI_SYSCALL, thread_info, syscall);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 59288c13b581..61503a36067e 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1317,16 +1317,13 @@ long arch_ptrace(struct task_struct *child, long request,
  * Notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
-asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
+asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 {
 	user_exit();
 
-	current_thread_info()->syscall = syscall;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (ptrace_report_syscall_entry(regs))
 			return -1;
-		syscall = current_thread_info()->syscall;
 	}
 
 #ifdef CONFIG_SECCOMP
@@ -1335,7 +1332,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		struct seccomp_data sd;
 		unsigned long args[6];
 
-		sd.nr = syscall;
+		sd.nr = current_thread_info()->syscall;
 		sd.arch = syscall_get_arch(current);
 		syscall_get_arguments(current, regs, args);
 		for (i = 0; i < 6; i++)
@@ -1345,23 +1342,23 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		ret = __secure_computing(&sd);
 		if (ret == -1)
 			return ret;
-		syscall = current_thread_info()->syscall;
 	}
 #endif
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
+	audit_syscall_entry(current_thread_info()->syscall,
+			    regs->regs[4], regs->regs[5],
 			    regs->regs[6], regs->regs[7]);
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
 	 * won't have had the return value set appropriately, so we do so now.
 	 */
-	if (syscall < 0)
+	if (current_thread_info()->syscall < 0)
 		syscall_set_return_value(current, regs, -ENOSYS, 0);
-	return syscall;
+	return current_thread_info()->syscall;
 }
 
 /*
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 18dc9b345056..2c604717e630 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -77,6 +77,18 @@ loads_done:
 	PTR_WD	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 */
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	and	t0, t1
@@ -114,16 +126,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
 
-	/*
-	 * syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 */
-	move	a1, v0
-	subu	t2, v0,  __NR_O32_Linux
-	bnez	t2, 1f /* __NR_syscall at offset 0 */
-	lw	a1, PT_R4(sp)
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 97456b2ca7dc..97788859238c 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -44,6 +44,8 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -72,7 +74,6 @@ syscall_common:
 n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index e6264aa62e45..be11ea5cc67e 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -46,6 +46,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -82,7 +84,6 @@ n64_syscall_exit:
 syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index d3c2616cba22..7a5abb73e531 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -79,6 +79,22 @@ loads_done:
 	PTR_WD	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 * note: NR_syscall is the first O32 syscall but the macro is
+	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
+	 * therefore __NR_O32_Linux is used (4000)
+	 */
+
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -113,22 +129,7 @@ trace_a_syscall:
 	sd	a7, PT_R11(sp)		# For indirect syscalls
 
 	move	a0, sp
-	/*
-	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 * note: NR_syscall is the first O32 syscall but the macro is
-	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
-	 * therefore __NR_O32_Linux is used (4000)
-	 */
-	.set	push
-	.set	reorder
-	subu	t1, v0,  __NR_O32_Linux
-	move	a1, v0
-	bnez	t1, 1f /* __NR_syscall at offset 0 */
-	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
-	.set	pop
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 

---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240328-mips_save_syscall-be471311cc9b

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


