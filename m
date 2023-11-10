Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A787E77E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbjKJDQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKJDQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:16:31 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA44F44B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:16:29 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ef36a04931so858725fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 19:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699586189; x=1700190989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3K8rAVzVe8bjIieIRG2YA9aTB4kxcEVJINAgXKkNfA=;
        b=WMr9BYxPPBQAZ3lUw0Ee0qhHZRZPttigLgi+KlrslyXmeoK58LsBE797DoZIwp5I7p
         yLp1hJHFxF4T+elGTHjiFTIX4AbOCWxOT47MfDuvTjVKYowC0mj7TaaK+rMuBZ9AFQTD
         qHmRj5pcTfzUG4RFZjph9fvXnCpyKD3HXV+N/NwTS4qj7rSxttt9BF/d76/iBF/Z8nRx
         4id1dvqdxLI02uom2RuqHILBwNRga5wfsqPAOaJK7gGJq7huqNv2fw2GxIMa9xcQxmAt
         7L1n3yX30q13Zv85KY7q/qK4t2DZKw+nBts1yuHvlxAzZ2oaAw7fFPn5+g3343xXNzMs
         127A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699586189; x=1700190989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3K8rAVzVe8bjIieIRG2YA9aTB4kxcEVJINAgXKkNfA=;
        b=Vev5oaf0XAQdCAv9gJD2H5zabWaTzon26iz5n7odM2dVJ6G7LJCiGIsbGwKcDpAy89
         HmhI6sYY0XwgCZyAs2g2jtOEX/cJoApwdIamtSqdArjkUvhnM32lqp+KJd3U5g6a7ehR
         34AqTSe0SRDr3kOYFdZmLIHBoNJU4Yla2ZH6qr8AO4XjNAlBNuLmlZSQLmN42wNc4G21
         gy2tzCqjcujJZxUdiozdwP7uqXCEj4p1fNTKiQpjhqqRV5c/T3opcSmOTpE0liM4Kjds
         AhRVKQh5/WE7oXFULauhK7/jwnFli3esuByV0JSEPDP44hmALEsvkaze2IQidGblrW17
         Twvg==
X-Gm-Message-State: AOJu0Yy+epkd6r0oKyMvobAlR120YoPyuSoNvGzlMwpAyJr1KrOm6k2L
        t4Z65o5xAHbA7KBaP7tZ1lA=
X-Google-Smtp-Source: AGHT+IGRD/omHjgpzcYAZQYWlZOIRBl0cZzxXDpndH/DY3jQfOWyKSvEeNn01LgYNVSzmQh0MnJkHw==
X-Received: by 2002:a05:6871:4487:b0:1e9:dfe4:743d with SMTP id ne7-20020a056871448700b001e9dfe4743dmr6875296oab.16.1699586188817;
        Thu, 09 Nov 2023 19:16:28 -0800 (PST)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id b21-20020a056a0002d500b00688965c5227sm11411211pft.120.2023.11.09.19.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 19:16:28 -0800 (PST)
From:   chenqiwu <qiwuchen55@gmail.com>
X-Google-Original-From: chenqiwu <qiwu.chen@transsion.com>
To:     axboe@kernel.dk, keescook@chromium.org, akpm@linux-foundation.org,
        npiggin@gmail.com, ebiederm@xmission.com
Cc:     michael.christie@oracle.com, mark.rutland@arm.com,
        jannh@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu <qiwu.chen@transsion.com>
Subject: [PATCH v2] exit: dump thread info on global init exit
Date:   Fri, 10 Nov 2023 11:15:53 +0800
Message-Id: <20231110031553.33186-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are various global init exit issues encountered
on Andriod/linux system. It's hard to debug these issues on product
environment without a usable coredump, This patch dump the last
exit thread executable sections and regs to find the exit reason
before panic.

Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
Tested-by: chenqiwu <qiwu.chen@transsion.com>
---
 kernel/exit.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index ee9f43bed49a..d8a623173520 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -13,6 +13,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/debug.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/capability.h>
@@ -806,6 +807,76 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	spin_unlock_irq(&sighand->siglock);
 }
 
+/*
+ * This function only dump thread executable sections to reduce maps space,
+ * since an unhandled falut in user mode is likely generated from code section.
+ */
+static void dump_thread_maps_info(struct task_struct *tsk)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = tsk->mm;
+
+	if (!mmap_read_trylock(mm))
+		return;
+
+	VMA_ITERATOR(vmi, mm, 0);
+	pr_info("%s-%d: Dump maps info start\n", tsk->comm, task_pid_nr(tsk));
+	for_each_vma(vmi, vma) {
+		struct file *file = vma->vm_file;
+		int flags = vma->vm_flags;
+		unsigned long long pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
+
+		if (file) {
+			if (flags & VM_EXEC) {
+				char tpath[256] = {0};
+				char *pathname = d_path(&file->f_path, tpath, sizeof(tpath));
+
+				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
+					vma->vm_start, vma->vm_end,
+					flags & VM_READ ? 'r' : '-',
+					flags & VM_WRITE ? 'w' : '-',
+					flags & VM_EXEC ? 'x' : '-',
+					flags & VM_MAYSHARE ? 's' : 'p',
+					pgoff, pathname);
+			}
+		} else {
+			const char *name = arch_vma_name(vma);
+
+			if (!name) {
+				struct mm_struct *mm = vma->vm_mm;
+
+				if (mm) {
+					if (vma_is_initial_heap(vma))
+						name = "[heap]";
+					else if (vma_is_initial_stack(vma))
+						name = "[stack]";
+				} else {
+					name = "[vdso]";
+				}
+			}
+
+			if (name && (flags & VM_EXEC)) {
+				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
+					vma->vm_start, vma->vm_end,
+					flags & VM_READ ? 'r' : '-',
+					flags & VM_WRITE ? 'w' : '-',
+					flags & VM_EXEC ? 'x' : '-',
+					flags & VM_MAYSHARE ? 's' : 'p', pgoff, name);
+			}
+		}
+	}
+	mmap_read_unlock(mm);
+	pr_info("%s-%d: Dump maps info end\n", tsk->comm, task_pid_nr(tsk));
+}
+
+static void dump_thread_info(struct task_struct *tsk)
+{
+	struct pt_regs *regs = task_pt_regs(tsk);
+
+	dump_thread_maps_info(tsk);
+	show_regs(regs);
+}
+
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -828,17 +899,20 @@ void __noreturn do_exit(long code)
 
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
-
+	if (unlikely(is_global_init(tsk)))
+		dump_thread_info(tsk);
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
 		/*
-		 * If the last thread of global init has exited, panic
-		 * immediately to get a useable coredump.
+		 * If the last thread of global init has exited, dump
+		 * some usable information before panic.
 		 */
-		if (unlikely(is_global_init(tsk)))
+		if (unlikely(is_global_init(tsk))) {
+			dump_thread_info(tsk);
 			panic("Attempted to kill init! exitcode=0x%08x\n",
 				tsk->signal->group_exit_code ?: (int)code);
+		}
 
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
-- 
2.25.1

