Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC37E8AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 13:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjKKMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 07:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjKKMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 07:52:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A32D7F;
        Sat, 11 Nov 2023 04:52:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a0907896so3896971e87.2;
        Sat, 11 Nov 2023 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699707142; x=1700311942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tH+6Le1/+mj0tTFQ4TIMWr4D5Ja96BtxNDzl+b3J72c=;
        b=VunhPeQ9fIpz65LPQYI7+BTU8sofCJKwFP4tlXenoZpjdws/8tQSd6RG/GJHrR0olI
         y5YCp6Hs5hPlj6fD0Pisfemf3HIL2B97RBaEkRhHD0Q62kKpzynsi6XYRQlffNdqBXeV
         3f8EjG888ktR3Sss8N4/tX3S8MfIqLJisj71fopb11ls3sLXAn1rfoxJek4vYvGMs1bq
         +3rfQjBde6PmhH8uumP+krYiEWOrAvr2XtF5DtXZ6RKie663KQ+RYHnocW9B7NPUKB/5
         pYYCUT1VvD6dSwFNragIeXIeIbtCYHV5yKD1NphXyNrvSrRrRJY8P5WrCS/AdWu+B7vs
         gVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699707142; x=1700311942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tH+6Le1/+mj0tTFQ4TIMWr4D5Ja96BtxNDzl+b3J72c=;
        b=EJewsphzTpfM8h5nxpllPKBzNGY1r66PPc44bI/LwLct1SfWKK/XuUE+0rrxqxXJTO
         eyv/K3vLMbKWLqH4F/lZmlW8LVlmFEIXjk55q2AFsNbvgbSv4u6OIf4UQyVdYlLZzllg
         KA7vBah6dZKu9A5HVueST8M0In9ChDTESgtTUc9AbSzXIXc24KCD5r8yNb+4NWJePGQF
         YknwRy6PL2SOD3ep2Ig8FyzG0m3QwehTOqSkdBIaE9Pw2ciAkd1KSoPSG4NICHjK3qFQ
         0wEHMUiby0yA6Dt3bGEEKj/mMqcwBC1Itf3Q2cvEYjlWi3s0eh4CsWqMI8V02k/aQYMr
         oYBA==
X-Gm-Message-State: AOJu0Yz+7qhoURXS+UxQyM8mmPOSvE7Nwzf79W3nWXii8wwc9GMoiwJU
        rV50IEmcHqv4a6GBfce9yOM=
X-Google-Smtp-Source: AGHT+IFSopr+OvdN7pLiISfW/v8hBXXsNGLEgzldQau7JV/aCeyajqYI9CrQnTfoi1Cd8ITb6ibzlA==
X-Received: by 2002:ac2:4198:0:b0:509:2b82:385c with SMTP id z24-20020ac24198000000b005092b82385cmr1232565lfh.61.1699707142103;
        Sat, 11 Nov 2023 04:52:22 -0800 (PST)
Received: from yjn-Lenovo-V14-G2-ITL.Speedport_W_724V_01011603_07_008 (p200300cddf0851c5ab1fae0925a828e1.dip0.t-ipconnect.de. [2003:cd:df08:51c5:ab1f:ae09:25a8:28e1])
        by smtp.gmail.com with ESMTPSA id dn10-20020a05640222ea00b0053ff311f388sm942481edb.23.2023.11.11.04.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 04:52:21 -0800 (PST)
From:   York Jasper Niebuhr <yjnworkstation@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] exitz syscall
Date:   Sat, 11 Nov 2023 13:51:26 +0100
Message-Id: <20231111125126.11665-1-yjnworkstation@gmail.com>
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
applications for individual processes that require the extra security.

This system call could in the future be extended to clear other
resources such as internal buffers, e.g. of sockets. However, its main
focus for now is process memory. It is supposed to protect systems
against memory forensics attacks that extract system memory (e.g. cold
boot attack) after programs that work with confidential data or keys
already exited. Currently, a process' memory could still be entirely
read until the according pages were reassigned to another process, as
page initialization is by default performed on alloc, not on free. The
configuration CONFIG_INIT_ON_FREE_DEFAULT_ON enables initialization on
free for the entire system and can result in performance deductions,
which are in many cases unnecessary. With sys_exitz, this performance
hit can be restricted to just the processes that actually require this
feature.

To keep track of any memory that contains keys or sensitive data is
incredibly tedious. Especially, when using cryptographic libraries,
developers often don't even know if the memory will be cleared after
certain operations. This system call could be invoked once at the start
of a program and the problem would be dealt with, including crashes or
other unexpected terminations that might otherwise prevent user-space
routines from zeroing memory.

To get proper security, sys_exitz should be used in combination with
mlock.

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>

---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/exitz.h                  |  27 ++++++
 include/linux/sched.h                  |   4 +
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/Makefile                        |   2 +
 kernel/exit.c                          |   5 ++
 kernel/exitz.c                         | 119 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   3 +
 mm/mmap.c                              |  12 +++
 security/Kconfig                       |   9 ++
 12 files changed, 187 insertions(+), 1 deletion(-)
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
index 000000000000..33a0b16f93a9
--- /dev/null
+++ b/kernel/exitz.c
@@ -0,0 +1,119 @@
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
+			unsigned long page_offset = 0;
+
+			if (page_address < start)
+				page_offset = min_t(unsigned long, start - page_address, PAGE_SIZE);
+
+			unsigned long page_part =
+				min_t(unsigned long, PAGE_SIZE, end - page_address) - page_offset;
+
+			memset(kaddr + page_offset, 0, page_part);
+
+			kunmap_local(kaddr);
+			page_address += PAGE_SIZE;
+		}
+
+		nr_pages -= pinned_pages;
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
+static void exit_memz(void)
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

