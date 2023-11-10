Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1D7E8251
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjKJTPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbjKJTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:15:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596964AC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:47:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507962561adso3487296e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699642071; x=1700246871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmbYajD08fm65gGrSXTrDbpon/28Zm/ptp7h3ynBKeQ=;
        b=ROvBxyd0ZrxUhhB5V0vlmJfJ5yoBbJzm1QGFUBbuZU3vvQtTsCtpdmCnA3lMwV2R5q
         W6P7uyyNbh5zjSqQxY6/7Ho0UD1IjVuM8FCr3NdTo7FKNqvCTL2EhAZKMGudDoeZosee
         a2/ZMdRkdH7KIaLPD5WuowRFhsYTcd3S2klnoYg+xhH3QMm9qg8ccfCdfPzptRstMjIN
         9dGRIpGcNga1qWy/mw2wFmuGkhXzM4ko+aR9woV1UpJPMhyQL6Xp/l7T7c65Ts974oVN
         70fYBfqdEksvkACzHQ/FfLdcRJdxOfE1iZGnkMdc+orGTmUYkGeMJZCzSlj0tC+ySZro
         nnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699642071; x=1700246871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmbYajD08fm65gGrSXTrDbpon/28Zm/ptp7h3ynBKeQ=;
        b=mQuAfbe77gFrcK4l723QeniWKOR0uwJw+XdNkKc5fo3xeb0UoHwoNxIjydFjN223/q
         9ztMNs4lJKXYHjLAJYTY519LMwY7dKXJgvSf6o0rdF6i8n806xG0z/RQBljzLEUjdExr
         mZyGyL+5Ak5GJ1p4KCAqupkBAtoU6S4/IegDv19gDnmZ6yxvUmZVq5ZQlr1GxAdNZna2
         eGQvv3VYdY7gHlnvxOaTvYey6oy9J4PsBU9sJ5AfpuHTK3D+8JDSa5gHftgELnDC0ZFU
         F+8wf/VF36Z7i499KN65+WBVkHgl03IQmFl58gpGHMM7HRVfBUTiVsjtbM48xSmnTLXD
         /0DA==
X-Gm-Message-State: AOJu0YwI5LToFv3Ll4xNoF9llyv/F0aHBao8vYMv76MjQTMfzBamICr4
        PN4EP0W1aUVdKKX2KmP1hwo=
X-Google-Smtp-Source: AGHT+IFVxibl/afL5qy37HZrcArXFlaoMosQ7C9Ad1C9Tj+NAV4eHkIMffqiETcw+oE5ExSAqrIKXQ==
X-Received: by 2002:a19:7013:0:b0:505:8075:7c10 with SMTP id h19-20020a197013000000b0050580757c10mr30327lfc.25.1699642070353;
        Fri, 10 Nov 2023 10:47:50 -0800 (PST)
Received: from yjn-Lenovo-V14-G2-ITL.Speedport_W_724V_01011603_07_008 (p200300cddf0851ea14bb4542fea1462a.dip0.t-ipconnect.de. [2003:cd:df08:51ea:14bb:4542:fea1:462a])
        by smtp.gmail.com with ESMTPSA id fi22-20020a1709073ad600b009e6165226absm1249047ejc.108.2023.11.10.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:47:49 -0800 (PST)
From:   York Jasper Niebuhr <yjnworkstation@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: exitz syscall
Date:   Fri, 10 Nov 2023 19:47:20 +0100
Message-Id: <20231110184720.39780-1-yjnworkstation@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a system call to flag a process' resources to be cleared on
exit (or, in the case of memory, on free). Currently, only zeroing
memory is implemented. This system call is meant to act as an
alternative to CONFIG_INIT_ON_FREE_DEFAULT_ON that does not generally
impact the entire system's performance, but is restricted to occasional
applications for single process' that require the extra security.

---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/exitz.h                  |  27 ++++++
 include/linux/sched.h                  |   4 +
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/Makefile                        |   2 +
 kernel/exit.c                          |   5 ++
 kernel/exitz.c                         | 112 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   3 +
 mm/mmap.c                              |  12 +++
 security/Kconfig                       |   9 ++
 12 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/exitz.h
 create mode 100644 kernel/exitz.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..8be9d1471b5c 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -461,3 +461,4 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	exitz			sys_exitz
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..e6aeca443a88 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	exitz			sys_exitz
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/exitz.h b/include/linux/exitz.h
new file mode 100644
index 000000000000..b1a5ad194839
--- /dev/null
+++ b/include/linux/exitz.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_EXITZ_SYSCALL
+
+/*
+ * Zero resource on exit flags
+ */
+#define EZ_NONE			0x00000000
+#define EZ_MEM                  0x00000001      /* Memory pages are cleared on exit */
+#define EZ_FLAGS (EZ_MEM)
+
+/*
+ * Overwrite current process memory range with zeros (end excluded).
+ */
+int memz_range(unsigned long start, unsigned long end);
+
+/*
+ * Overwrite all flagged resources with zeros.
+ */
+void exit_z(void);
+
+/*
+ * Set task_struct flags to zero flagged resources on exit.
+ */
+void do_exitz(int flags);
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..cbe8c198f28e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -766,6 +766,10 @@ struct task_struct {
 	refcount_t			usage;
 	/* Per task flags (PF_*), defined further below: */
 	unsigned int			flags;
+#ifdef CONFIG_EXITZ_SYSCALL
+	/* Zero resource on exit flags (EZ_*). */
+	unsigned int			ezflags;
+#endif
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..8c29b9ea3677 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -949,6 +949,7 @@ asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
 asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
+asmlinkage long sys_exitz(int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..782222ffa0d7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_exitz 457
+__SYSCALL(__NR_exitz, sys_exitz)
 
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..17602af88adc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -158,3 +158,5 @@ $(obj)/kheaders_data.tar.xz: FORCE
 	$(call cmd,genikh)
 
 clean-files := kheaders_data.tar.xz kheaders.md5
+
+obj-$(CONFIG_EXITZ_SYSCALL) += exitz.o
diff --git a/kernel/exit.c b/kernel/exit.c
index ee9f43bed49a..35469decd9e9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,7 @@
 #include <linux/rethook.h>
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
+#include <linux/exitz.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -808,6 +809,10 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 
 void __noreturn do_exit(long code)
 {
+#ifdef CONFIG_EXITZ_SYSCALL
+	exit_z();
+#endif
+
 	struct task_struct *tsk = current;
 	int group_dead;
 
diff --git a/kernel/exitz.c b/kernel/exitz.c
new file mode 100644
index 000000000000..75875685bd3c
--- /dev/null
+++ b/kernel/exitz.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/exitz.h>
+#include <linux/syscalls.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/string.h>
+
+#define EZ_MAX_PAGES_ARRAY_COUNT 16
+#define EZ_MAX_KMALLOC_PAGES (PAGE_SIZE * 2)
+#define EZ_MAX_PAGES_PER_LOOP (EZ_MAX_KMALLOC_PAGES / sizeof(struct page *))
+
+/*
+ * Overwrite a range of process memory with zeros (end excluded).
+ */
+int memz_range(unsigned long start, unsigned long end)
+{
+	if (end <= start)
+		return 0;
+
+	unsigned long nr_pages = (end - 1) / PAGE_SIZE - start / PAGE_SIZE + 1;
+
+	struct page *pages_stack[EZ_MAX_PAGES_ARRAY_COUNT];
+	struct page **pages = pages_stack;
+
+	if (nr_pages > EZ_MAX_PAGES_ARRAY_COUNT) {
+		/* For reliability, cap kmalloc size */
+		pages = kmalloc(min_t(size_t, EZ_MAX_KMALLOC_PAGES,
+					sizeof(struct page *) * nr_pages),
+				GFP_KERNEL);
+
+		if (!pages)
+			return -ENOMEM;
+	}
+
+	unsigned long page_address = start & PAGE_MASK;
+
+	while (nr_pages) {
+		long pinned_pages = min(nr_pages, EZ_MAX_PAGES_PER_LOOP);
+
+		pinned_pages = pin_user_pages(page_address, pinned_pages, FOLL_WRITE, pages);
+
+		if (pinned_pages <= 0)
+			return -EFAULT;
+
+		/* Map and zero each page */
+		for (long i = 0; i < pinned_pages; i++) {
+			void *kaddr = kmap_local_page(pages[i]);
+
+			memset(kaddr, 0, PAGE_SIZE);
+
+			kunmap_local(kaddr);
+		}
+
+		nr_pages -= pinned_pages;
+		page_address += pinned_pages * PAGE_SIZE;
+
+		unpin_user_pages_dirty_lock(pages, pinned_pages, 1);
+	}
+
+	if (pages != pages_stack)
+		kfree(pages);
+
+	return 0;
+}
+
+/*
+ * Overwrite any memory associated to current process with zeros.
+ */
+void exit_memz(void)
+{
+	if (!(current->ezflags & EZ_MEM))
+		return;
+
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, current->mm, 0);
+
+	for_each_vma(vmi, vma) {
+		memz_range(vma->vm_start, vma->vm_end);
+	}
+}
+
+/*
+ * Overwrite all flagged resources with zeros.
+ */
+void exit_z(void)
+{
+	exit_memz();
+}
+
+/*
+ * Set task_struct flags to zero flagged resources on exit.
+ */
+void do_exitz(int flags)
+{
+	current->ezflags = flags;
+}
+
+#ifdef CONFIG_EXITZ_SYSCALL
+SYSCALL_DEFINE1(exitz, int, flags)
+{
+	if (flags & ~EZ_FLAGS)
+		return -EINVAL;
+
+	do_exitz(flags);
+	return 0;
+}
+#endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e1a6e3c675c0..ff5468f1d2f2 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -254,6 +254,9 @@ COND_SYSCALL(pkey_free);
 /* memfd_secret */
 COND_SYSCALL(memfd_secret);
 
+/* exitz */
+COND_SYSCALL(exitz);
+
 /*
  * Architecture specific weak syscall entries.
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 4f1cb814586d..d66bd314aca9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
+#include <linux/exitz.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -225,6 +226,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
+		/* Overwrite memory with zeros */
+#ifdef CONFIG_EXITZ_SYSCALL
+		if (current->ezflags & EZ_MEM)
+			memz_range(brk, mm->brk);
+#endif
+
 		/* Search one past newbrk */
 		vma_iter_init(&vmi, mm, newbrk);
 		brkvma = vma_find(&vmi, oldbrk);
@@ -3001,6 +3008,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
+#ifdef CONFIG_EXITZ_SYSCALL
+	if (current->ezflags & EZ_MEM)
+		memz_range(start, start + len);
+#endif
+
 	int ret;
 	struct mm_struct *mm = current->mm;
 	LIST_HEAD(uf);
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..3509bb5fb2f4 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -249,5 +249,14 @@ config LSM
 
 source "security/Kconfig.hardening"
 
+config EXITZ_SYSCALL
+	bool "Exitz syscall" if EXPERT
+	default y
+	help
+	  sys_exitz is a system call to flag a process' resources to be erased
+	  on exit. It can be used to harden the system against memory forensics
+	  attacks after a process has finished. It is meant to be a more fine
+	  grained alternative to CONFIG_INIT_ON_FREE_DEFAULT_ON.
+
 endmenu
 

base-commit: 8728c14129df7a6e29188a2e737b4774fb200953
-- 
2.34.1

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>
