Return-Path: <linux-kernel+bounces-35170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F8838D07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EE81C22DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BE5F863;
	Tue, 23 Jan 2024 11:09:25 +0000 (UTC)
Received: from out0-201.mail.aliyun.com (out0-201.mail.aliyun.com [140.205.0.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223645DF3D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008164; cv=none; b=hc+U5Lq3vavuPL2YiaVeSnMQnhgrLn/g5ZTDOZci2E+c2MgIPAxAPXT4oMGyOkRHBtpW5nmlWOPqYz+oZLFdgASGaJ5+OFWjO8sx1RlA9ERCWCgp188+C6WYLKJPQ4DO1cAdV0/m56/VL2qpO8yzde8FV88NRULmQpMGOqWdV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008164; c=relaxed/simple;
	bh=awK4ouFeeJNCU3Mx7RTOrJMX6P6PIS34KaVNNCUJsFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aODY4nqJjK47KHukY2hq9miRF5DciNhcFgMRnBKB2bokRpFNoQ7vJkBGELqXuiW06WC1v6ApZkL8IBmS8p/Q2Rk7kO+JlrcuLB/Us3fWA5IrWsOlCuXdBMyJtPcnqp5ajalv+Non9YSoW3dvJy+WvesVdSLDj5JqYSkRoSKkvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKTkS_1706007837;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKTkS_1706007837)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/5] um: Add missing headers
Date: Tue, 23 Jan 2024 19:03:47 +0800
Message-Id: <20240123110347.1274217-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
References: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This will address below -Wmissing-prototypes warnings:

arch/um/kernel/mem.c:202:8: warning: no previous prototype for ‘pgd_alloc’ [-Wmissing-prototypes]
arch/um/kernel/mem.c:215:7: warning: no previous prototype for ‘uml_kmalloc’ [-Wmissing-prototypes]
arch/um/kernel/process.c:207:6: warning: no previous prototype for ‘arch_cpu_idle’ [-Wmissing-prototypes]
arch/um/kernel/process.c:328:15: warning: no previous prototype for ‘arch_align_stack’ [-Wmissing-prototypes]
arch/um/kernel/reboot.c:45:6: warning: no previous prototype for ‘machine_restart’ [-Wmissing-prototypes]
arch/um/kernel/reboot.c:51:6: warning: no previous prototype for ‘machine_power_off’ [-Wmissing-prototypes]
arch/um/kernel/reboot.c:57:6: warning: no previous prototype for ‘machine_halt’ [-Wmissing-prototypes]
arch/um/kernel/skas/mmu.c:17:5: warning: no previous prototype for ‘init_new_context’ [-Wmissing-prototypes]
arch/um/kernel/skas/mmu.c:60:6: warning: no previous prototype for ‘destroy_context’ [-Wmissing-prototypes]
arch/um/kernel/skas/process.c:36:12: warning: no previous prototype for ‘start_uml’ [-Wmissing-prototypes]
arch/um/kernel/tlb.c:594:6: warning: no previous prototype for ‘force_flush_all’ [-Wmissing-prototypes]
arch/x86/um/bugs_64.c:9:6: warning: no previous prototype for ‘arch_check_bugs’ [-Wmissing-prototypes]
arch/x86/um/bugs_64.c:13:6: warning: no previous prototype for ‘arch_examine_signal’ [-Wmissing-prototypes]
arch/x86/um/fault.c:18:5: warning: no previous prototype for ‘arch_fixup’ [-Wmissing-prototypes]
arch/x86/um/os-Linux/mcontext.c:7:6: warning: no previous prototype for ‘get_regs_from_mc’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/mem.c            | 2 ++
 arch/um/kernel/process.c        | 2 ++
 arch/um/kernel/reboot.c         | 1 +
 arch/um/kernel/skas/mmu.c       | 1 +
 arch/um/kernel/skas/process.c   | 1 +
 arch/um/kernel/tlb.c            | 1 +
 arch/x86/um/bugs_32.c           | 1 +
 arch/x86/um/bugs_64.c           | 1 +
 arch/x86/um/fault.c             | 1 +
 arch/x86/um/os-Linux/mcontext.c | 1 +
 10 files changed, 12 insertions(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 38d5a71a579b..ca91accd64fc 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -12,12 +12,14 @@
 #include <linux/slab.h>
 #include <asm/fixmap.h>
 #include <asm/page.h>
+#include <asm/pgalloc.h>
 #include <as-layout.h>
 #include <init.h>
 #include <kern.h>
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <um_malloc.h>
 #include <linux/sched/task.h>
 
 #ifdef CONFIG_KASAN
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index a7607ef1b02f..4235e2ca2664 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -27,6 +28,7 @@
 #include <asm/current.h>
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
+#include <asm/exec.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 48c0610d506e..25840eee1068 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/oom.h>
+#include <linux/reboot.h>
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 656fe16c9b63..aeed1c2aaf3c 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -10,6 +10,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
+#include <asm/mmu_context.h>
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index f2ac134c9752..fdd5922f9222 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -12,6 +12,7 @@
 #include <kern.h>
 #include <os.h>
 #include <skas.h>
+#include <kern_util.h>
 
 extern void start_kernel(void);
 
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 70b5e47e9761..8784f03fa4a6 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/sched/signal.h>
 
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 #include <as-layout.h>
 #include <mem_user.h>
 #include <os.h>
diff --git a/arch/x86/um/bugs_32.c b/arch/x86/um/bugs_32.c
index 33daff4dade4..d29929efcc07 100644
--- a/arch/x86/um/bugs_32.c
+++ b/arch/x86/um/bugs_32.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <arch.h>
 #include <signal.h>
 #include <kern_util.h>
 #include <longjmp.h>
diff --git a/arch/x86/um/bugs_64.c b/arch/x86/um/bugs_64.c
index 8cc8256c698d..b01295e8a676 100644
--- a/arch/x86/um/bugs_64.c
+++ b/arch/x86/um/bugs_64.c
@@ -4,6 +4,7 @@
  * Licensed under the GPL
  */
 
+#include <arch.h>
 #include <sysdep/ptrace.h>
 
 void arch_check_bugs(void)
diff --git a/arch/x86/um/fault.c b/arch/x86/um/fault.c
index 84ac7f7b0257..0dde4d613a87 100644
--- a/arch/x86/um/fault.c
+++ b/arch/x86/um/fault.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <arch.h>
 #include <sysdep/ptrace.h>
 
 /* These two are from asm-um/uaccess.h and linux/module.h, check them. */
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 49c3744cac37..e80ab7d28117 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -3,6 +3,7 @@
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
+#include <sysdep/mcontext.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
-- 
2.34.1


