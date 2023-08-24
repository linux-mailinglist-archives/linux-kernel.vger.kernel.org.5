Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E078789D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbjHXThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbjHXTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:36:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E601B0;
        Thu, 24 Aug 2023 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eoB4gbV/oYw5Dkw8MYUKcw3Rv5zfAt8VrbVigwxJuTQ=; b=ghES/e6bSG61n2H4JeUxOhZSnI
        LDVuKmScqUy36Ce/8AHQunKIZ844T9P3g0Bp+JKklxpwQLYO4Y/p5ttUQMGhJ12cZZu9orElXf08i
        ga11i7LvnvxIxa6UuJQohTTa2WDC2FzdX4eHttGBaOjBTxeL41LY+MuRTB/Cks1iBW7d1GlySUbn8
        qUeqtoC9tOUtM18oh/s2rXvsu+iJOX0atIazsaNPh2uzxzayOojT3qnQLSR5HTVWFIcZsBk8vR5U4
        ATD9stLv/tuKzw082t678y3ObqVEfDc6W+f5sEQdK8fSoDCs4kt6PDZcXjz+vLuqk8OXcIuRQcH8N
        7Cb0DpTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZG8M-00Ci1H-6t; Thu, 24 Aug 2023 19:36:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fork: Fix kernel-doc
Date:   Thu, 24 Aug 2023 20:36:44 +0100
Message-Id: <20230824193644.3029141-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the various warnings from kernel-doc in kernel/fork.c

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/fork.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index a9c18d480dc5..63d8c6c057a9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1400,6 +1400,8 @@ EXPORT_SYMBOL_GPL(mmput_async);
 
 /**
  * set_mm_exe_file - change a reference to the mm's executable file
+ * @mm: The mm to change.
+ * @new_exe_file: The new file to use.
  *
  * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
  *
@@ -1439,6 +1441,8 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 
 /**
  * replace_mm_exe_file - replace a reference to the mm's executable file
+ * @mm: The mm to change.
+ * @new_exe_file: The new file to use.
  *
  * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
  *
@@ -1490,6 +1494,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 
 /**
  * get_mm_exe_file - acquire a reference to the mm's executable file
+ * @mm: The mm of interest.
  *
  * Returns %NULL if mm has no associated executable file.
  * User must release file via fput().
@@ -1508,6 +1513,7 @@ struct file *get_mm_exe_file(struct mm_struct *mm)
 
 /**
  * get_task_exe_file - acquire a reference to the task's executable file
+ * @task: The task.
  *
  * Returns %NULL if task's mm (if any) has no associated executable file or
  * this is a kernel thread with borrowed mm (see the comment above get_task_mm).
@@ -1530,6 +1536,7 @@ struct file *get_task_exe_file(struct task_struct *task)
 
 /**
  * get_task_mm - acquire a reference to the task's mm
+ * @task: The task.
  *
  * Returns %NULL if the task has no mm.  Checks PF_KTHREAD (meaning
  * this kernel workthread has transiently adopted a user mm with use_mm,
@@ -2109,11 +2116,11 @@ const struct file_operations pidfd_fops = {
  * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  * @pid:   the struct pid for which to create a pidfd
  * @flags: flags of the new @pidfd
- * @pidfd: the pidfd to return
+ * @ret: Where to return the file for the pidfd.
  *
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
-
+ *
  * The helper doesn't perform checks on @pid which makes it useful for pidfds
  * created via CLONE_PIDFD where @pid has no task attached when the pidfd and
  * pidfd file are prepared.
@@ -2160,7 +2167,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  * @pid:   the struct pid for which to create a pidfd
  * @flags: flags of the new @pidfd
- * @pidfd: the pidfd to return
+ * @ret: Where to return the pidfd.
  *
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
@@ -3188,7 +3195,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 }
 
 /**
- * clone3 - create a new process with specific properties
+ * sys_clone3 - create a new process with specific properties
  * @uargs: argument structure
  * @size:  size of @uargs
  *
-- 
2.40.1

