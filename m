Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160157850DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjHWGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjHWGyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:54:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC402C7;
        Tue, 22 Aug 2023 23:54:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4680736f8f.0;
        Tue, 22 Aug 2023 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692773641; x=1693378441;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRJbu2VWppGYKNpBHFTEv9Y+VuI16n9z+Mb3bjCacWM=;
        b=GbBYjN1AhGbgv25zzxmtNaQj3+u05ygAFTtl9LQ/2ozXaFj0W+wJn7ZPDvE56geNle
         ndXVXmp7qUWIERbSm3jFMryyGOWkouvBOH/h5NKvPxncaIk+jxMyK6L0a+H+INV114w0
         E4wgO/HgU408UaLk+zM5jtzwnApAwkdEQKJcMgEy/kk3P93WOK1ZTkQ6+5ZZBfmsj7TZ
         F5SImDkAyfjt9Z7Db8XlwKp7vNnQV/tcvGmZvGtvspClmR06qoeqrQLu5D0MzmtXQNIF
         K9xALmqrZPOq6QtSuv58VJZD28tUS6FWebRtafqHUgb3MwsosyiARClnsBUECsCyIno/
         Nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692773641; x=1693378441;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRJbu2VWppGYKNpBHFTEv9Y+VuI16n9z+Mb3bjCacWM=;
        b=aiU33XB//3YZAGzoEPe+oYbaTf5/xogwHgKccY1csqzRwauUGG+yn5rfWn98RxVzpx
         9KFZtHAD0NXat//+PRox6bHyUmzLxCfUxCPkTXlW7xYwhtFF/majP+F0LrUReoJzg8sj
         sC1XPqRVVxLCC/GTK4Pm0mrvbBwRYeP68u+T27H01nYJRS9wQeNOCf6AUtHgaTpbKbmL
         kyzDqKVc5brBuXc/I1KUZU5EhGnFyLYbfZ3OFwhh/uTgc1CU4HfzWB+PEXD1mMHOk0UD
         7RgIJ03XD756kT1AzhG0VBMZEsqBzB0NVCNyIJp0DKoRapyfVhT1gUrmVwL+RaCRc7fX
         bUjA==
X-Gm-Message-State: AOJu0YxuCzg8IHV3N6CXMIk5Vlm0wG/nYsOtWblBKXyWY7vTxnBzo/s5
        suTnJqTtJ0xmPxzFg2tFk0s=
X-Google-Smtp-Source: AGHT+IE8B7x2NLCXkn9XsQOgy6nerf/jeibqut1EJ8tEH1t0fMQXHBGYPaDB0Df0Qb80oWqBrQNlCQ==
X-Received: by 2002:a05:6000:234:b0:317:67bf:337f with SMTP id l20-20020a056000023400b0031767bf337fmr11255411wrz.2.1692773640972;
        Tue, 22 Aug 2023 23:54:00 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm18068477wrj.52.2023.08.22.23.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 23:54:00 -0700 (PDT)
Date:   Wed, 23 Aug 2023 11:53:57 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: [PATCH] lsm: constify the 'mm' parameter in
 security_vm_enough_memory_mm()
Message-ID: <ZOWtBTKkfcc8sKkY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'vm_enough_memory' hook has implementations registered in SELinux
and commoncap. Looking at the function implementations we observe that
the 'mm' parameter is not changing.

Mark the 'mm' parameter of LSM hook security_vm_enough_memory_mm() as
'const' since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/mm.h            | 2 +-
 include/linux/security.h      | 6 +++---
 security/commoncap.c          | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..aabf13482721 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 0, vm_enough_memory, const struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..52d43c5c20cd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3064,7 +3064,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 /* mmap.c */
-extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
+extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next);
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..442495335ffd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -169,7 +169,7 @@ extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 extern int cap_task_setscheduler(struct task_struct *p);
 extern int cap_task_setioprio(struct task_struct *p, int ioprio);
 extern int cap_task_setnice(struct task_struct *p, int nice);
-extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
+extern int cap_vm_enough_memory(const struct mm_struct *mm, long pages);
 
 struct msghdr;
 struct sk_buff;
@@ -287,7 +287,7 @@ int security_quotactl(int cmds, int type, int id, struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
-int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
+int security_vm_enough_memory_mm(const struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
 int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
@@ -600,7 +600,7 @@ static inline int security_settime64(const struct timespec64 *ts,
 	return cap_settime(ts, tz);
 }
 
-static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
+static inline int security_vm_enough_memory_mm(const struct mm_struct *mm, long pages)
 {
 	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 0b3fc2f3afe7..b7193f916b2c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1397,7 +1397,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
  *
  * Return: 1 if permission is granted, 0 if not.
  */
-int cap_vm_enough_memory(struct mm_struct *mm, long pages)
+int cap_vm_enough_memory(const struct mm_struct *mm, long pages)
 {
 	int cap_sys_admin = 0;
 
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..f9c3dbc2376b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1017,7 +1017,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  * Return: Returns 0 if permission is granted by the LSM infrastructure to the
  *         caller.
  */
-int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
+int security_vm_enough_memory_mm(const struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..8ae9cc81902c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2158,7 +2158,7 @@ static int selinux_syslog(int type)
  * Do not audit the selinux permission check, as this is applied to all
  * processes that allocate mappings.
  */
-static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
+static int selinux_vm_enough_memory(const struct mm_struct *mm, long pages)
 {
 	int rc, cap_sys_admin = 0;
 
-- 
2.34.1

