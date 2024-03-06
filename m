Return-Path: <linux-kernel+bounces-93772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821887345D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9731C21D0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E0605C1;
	Wed,  6 Mar 2024 10:35:21 +0000 (UTC)
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC66605B3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721321; cv=none; b=AcVWhr9SfvXiygntFng8Xf3hwE4c97eFJZ3zG0dbyIpX8UnJ7vZ8j7wbJfuomjzgRrvgTsHpYpqioopLJ4xt4rcHjfCnCedNve+dEKjyXpUuB/vM1VCNab+u6LkG+DuGICM02gEmfFYL7aFyFwvG5ubQO9AAx7gNyauHOrpjbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721321; c=relaxed/simple;
	bh=/GC90DWrL7cXoxLWup0Y9mv2Ik+79aVESmMJJq8tlo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zhph66ub8BnU9vvMPrMoXZiuh/ann8Ou6vvVcLCNBOdSRVMPEdz/pWctury1MgVnJ98F066upVm0yVj0uQz3aYA+R+XSNVyKvxEv/aM9GCBFj3vvac1kb0Tc74ImqvRXE6ASvysDN+gawlEXTiXVqXg0/0g7r8LfZ2x2EC5iWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-Jx_1709720383;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-Jx_1709720383)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:43 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 7/9] um: Move declarations to proper headers
Date: Wed, 06 Mar 2024 18:19:23 +0800
Message-Id: <20240306101925.1088870-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This will address below -Wmissing-prototypes warnings:

arch/um/kernel/initrd.c:18:12: warning: no previous prototype for ‘read_initrd’ [-Wmissing-prototypes]
arch/um/kernel/um_arch.c:408:19: warning: no previous prototype for ‘read_initrd’ [-Wmissing-prototypes]
arch/um/os-Linux/start_up.c:301:12: warning: no previous prototype for ‘parse_iomem’ [-Wmissing-prototypes]
arch/x86/um/ptrace_32.c:15:6: warning: no previous prototype for ‘arch_switch_to’ [-Wmissing-prototypes]
arch/x86/um/ptrace_32.c:101:5: warning: no previous prototype for ‘poke_user’ [-Wmissing-prototypes]
arch/x86/um/ptrace_32.c:153:5: warning: no previous prototype for ‘peek_user’ [-Wmissing-prototypes]
arch/x86/um/ptrace_64.c:111:5: warning: no previous prototype for ‘poke_user’ [-Wmissing-prototypes]
arch/x86/um/ptrace_64.c:171:5: warning: no previous prototype for ‘peek_user’ [-Wmissing-prototypes]
arch/x86/um/syscalls_64.c:48:6: warning: no previous prototype for ‘arch_switch_to’ [-Wmissing-prototypes]
arch/x86/um/tls_32.c:184:5: warning: no previous prototype for ‘arch_switch_tls’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/ptrace-generic.h | 3 +++
 arch/um/include/shared/kern_util.h   | 1 +
 arch/um/kernel/physmem.c             | 3 +--
 arch/um/kernel/process.c             | 2 --
 arch/um/kernel/ptrace.c              | 3 ---
 arch/um/kernel/um_arch.h             | 2 ++
 arch/um/os-Linux/start_up.c          | 1 +
 arch/x86/um/asm/ptrace.h             | 6 ++++++
 arch/x86/um/ptrace_32.c              | 2 --
 9 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index adf91ef553ae..4696f24d1492 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -36,6 +36,9 @@ extern long subarch_ptrace(struct task_struct *child, long request,
 extern unsigned long getreg(struct task_struct *child, int regno);
 extern int putreg(struct task_struct *child, int regno, unsigned long value);
 
+extern int poke_user(struct task_struct *child, long addr, long data);
+extern int peek_user(struct task_struct *child, long addr, long data);
+
 extern int arch_set_tls(struct task_struct *new, unsigned long tls);
 extern void clear_flushed_tls(struct task_struct *task);
 extern int syscall_trace_enter(struct pt_regs *regs);
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 789b83013f35..81bc38a2e3fc 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -41,6 +41,7 @@ extern void uml_pm_wake(void);
 
 extern int start_uml(void);
 extern void paging_init(void);
+extern int parse_iomem(char *str, int *add);
 
 extern void uml_cleanup(void);
 extern void do_uml_exitcalls(void);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 91485119ae67..fb2adfb49945 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -12,6 +12,7 @@
 #include <as-layout.h>
 #include <init.h>
 #include <kern.h>
+#include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
 
@@ -161,8 +162,6 @@ __uml_setup("mem=", uml_mem_setup,
 "	Example: mem=64M\n\n"
 );
 
-extern int __init parse_iomem(char *str, int *add);
-
 __uml_setup("iomem=", parse_iomem,
 "iomem=<name>,<file>\n"
 "    Configure <file> as an IO memory region named <name>.\n\n"
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 1201c1a79b23..30bf7739ed0f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -67,8 +67,6 @@ static inline void set_current(struct task_struct *task)
 	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) { task });
 }
 
-extern void arch_switch_to(struct task_struct *to);
-
 struct task_struct *__switch_to(struct task_struct *from, struct task_struct *to)
 {
 	to->thread.prev_sched = from;
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 6600a2782796..2124624b7817 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -35,9 +35,6 @@ void ptrace_disable(struct task_struct *child)
 	user_disable_single_step(child);
 }
 
-extern int peek_user(struct task_struct * child, long addr, long data);
-extern int poke_user(struct task_struct * child, long addr, long data);
-
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
diff --git a/arch/um/kernel/um_arch.h b/arch/um/kernel/um_arch.h
index 1e07fb7ee35e..46e731ab9dfc 100644
--- a/arch/um/kernel/um_arch.h
+++ b/arch/um/kernel/um_arch.h
@@ -11,4 +11,6 @@ extern void __init uml_dtb_init(void);
 static inline void uml_dtb_init(void) { }
 #endif
 
+extern int __init read_initrd(void);
+
 #endif
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 8b0e98ab842c..6b21061c431c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -20,6 +20,7 @@
 #include <asm/unistd.h>
 #include <init.h>
 #include <os.h>
+#include <kern_util.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
 #include <registers.h>
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index 83822fd42204..2fef3da55533 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -54,6 +54,8 @@ extern int ptrace_get_thread_area(struct task_struct *child, int idx,
 extern int ptrace_set_thread_area(struct task_struct *child, int idx,
                                   struct user_desc __user *user_desc);
 
+extern int arch_switch_tls(struct task_struct *to);
+
 #else
 
 #define PT_REGS_R8(r) UPT_R8(&(r)->regs)
@@ -83,5 +85,9 @@ extern long arch_prctl(struct task_struct *task, int option,
 		       unsigned long __user *addr);
 
 #endif
+
 #define user_stack_pointer(regs) PT_REGS_SP(regs)
+
+extern void arch_switch_to(struct task_struct *to);
+
 #endif /* __UM_X86_PTRACE_H */
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 7f1abde2c84b..b0a71c6cdc6e 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -10,8 +10,6 @@
 #include <registers.h>
 #include <skas.h>
 
-extern int arch_switch_tls(struct task_struct *to);
-
 void arch_switch_to(struct task_struct *to)
 {
 	int err = arch_switch_tls(to);
-- 
2.34.1


