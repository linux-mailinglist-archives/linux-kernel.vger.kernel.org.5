Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067279DA65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbjILU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjILU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:58:54 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591810EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552326; bh=MPVYkpIj/1ZskQ+ad3fQJpU4mJsUfdkCSRiDHYQ9dHw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XK5Dmy8y+qKWxVKERzmSckhHwWqMjd2XVbjon4qogkDYIiqvkAZqL6olD2edG7DZQsZ6YXXiTPcHxFhQoh5xOoMOBYw/dbOvLzF7GjFu9sObywBWspu3mDbbooCw0LHKwetFwJl77g6HCmI2bcIlDmI9W4CblDN7jCYvo0Or+28DWRFAsAtgdhaXsNkUZOqjwxxeXet3YFu8j/NBFAKiUI94fPMW51l+KYLW7zZKqCXiYq8i8V5rRoiz5XGAeAEhIFreqQKkTdMRdkufIDOhOVCjwoV7tZZs81qSUpIHAiSXy8AmV8Q7IkuAXEjMyr8Sg+rKYX6LcuigXG/eWot/Xg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552326; bh=gTQOM6nJeLBm2fNjNm0bWXW79Bi1tNbSSeeH+7ltkek=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=H9mZ6gMLeLytiLcrArDSSkjY+b0J54J3V7S543J/6M2rLkKbW3JW6iUwLcmH+fOb79fRejSZFuXLhLU2HIkYOw+hWQhhkQ1sWfgsgTbysVYGBfipny6uRr5fynYXTNbSiGHgw4QiYutokkBJ6c+sCgjstFNtSkH6W2/uP+WtmOS8VGomT689xst1qQiDYKxOE2Amttq38r+H2LAXYiXNcbqeSF+ZmM87vci75KLrgEFOR3fWvCYxxsjAGQXYO7xT/1MXQMkdMgcaNYW/DFqbyYsS6ehpoV0Zqg3awYrk/51VRPu2qn7iwGUysyvC2jR5Ja+hnEuVniISIlD7LYPv0g==
X-YMail-OSG: u0xlR4sVM1l4e6Cqs8mvK4XAODfWxm5SQRObO.rOOR8Aux4qd6sz2P2bECw8W52
 PqZ7kIAzWRslepHWCO2P0pGSALml8seJukc_HwhzY.jygPgqok1JSvqLG3Rv6Rm8ouE1FpgIMM.e
 sgohWTurMxJHwd0_m54ZBQFhzPvW6scHXzBDs2ylchBqSs9LcvwNIQ3BWxl2Ankq1hrq1i7lnrEc
 StnocN91yPqtgjvRRpP9DtSkY3fFR5O3Oiid.8VNRY851iyoRf0zhWRbYERD1yROiy1cX75ctaNJ
 kZVEROxrb7muApoA.Vdbp1mDjiLxmIZOJJeAjmlmLa05Qryk1_qTDlznFfZvP3rK0keEJfe.2I02
 _M.8Uq3IequYCnTJFmvnXDi50KOuWGWPBaNieV0d4b1JRXwgsYG.grA36gytKikj8FHeYxBFGltT
 6zuS.8T.jdWRVX543xM9a1YaaTILPylEiO.7qgwk_5ze_MugDNTcY0M0FAMYLDUxbVMDVtEiqKI1
 FuEqqq5qu.PvLMwszr14e6uRZl55FH2PfwyhEnv.2YvaWFOBmXOEdHFT8jhpNkxo0_rum9C200Ne
 I4H8qzOfX.zcmCU4nI1ia8WLIqEaI_e_UfXZYrWUXlgo09a4iKWpjlurOE_knST7A.nTI1jrEnSY
 IgL6ff8EjNZm4qqrQNghFDr_H1GQ02ppZzHveVheJeHyq0jkFJr84bUISpk5DEr.XQM4bqIwoStY
 eyR5RPnL0KaccnQqYFUhQnZ0GWACsSIttV0GxS2DYoVtP1CYOVhkhkdy3fe06ZsEp7qtCr9vUL87
 J7kHbidvyahb1EVoJdb0xWy3S8Qzgm.HVeBJzcG0.qGzM9Ml4U4o827MmGb4M242Lhz8HCU.q8n8
 tJJ7npawOnpSmnVuf.yxSpelcArfGLdW0EQf54kecp87lSo7VLMOPJtOjZOZvbca98U.oCut_yKS
 f2l6qDOE3jAkF.wefzd3dpWQskXhRHu9Z2oLzDKLxVSVfWcQaQsnpnn2V7_ROT4TH8yhOqydR5hN
 y67nCFvTk61ioUQCsgNihDtf3WTmPZRgsaReR8dxwPDv63WUuw6cmJ7yOAfXb1WvKyNpPSIgBRcF
 NzEm7tPQPvxp0Ydb9OODik_kjWNADM5FH039lANF.8cdOWtkOB0wwyWgkXYADK3Rjby8Wx8Lkr7i
 Q1BsbwblBcPpeJbj1CtZ0Or6dbxelVdGLp2Dc1bCTNfvLLH5jM1jstzD04yIOLVJZ7MLAAWm_Eq6
 j6mU21UdViSyMKMYZ.O2hkRPQ9GFsvdsX3EFEMJxjASmrzDS1G9Lxd_ekAyktAzvb0UrOsXLYKAE
 kKKzUxU7HUpYocEI9tFfHAbWVgE6GiojgU0C.9RlX6xgz52k9PHzhlKkuDPI4ehi65mavtfGxu0C
 Zvg12Xkdr75.LS0D9M_HBQUpEHP12DnGf_hhiVtN4udEF0C37rlHYdSj6RI.R52tZ0RFJ3qd0VC4
 JyfYBHRO9QWJSh8Vj2dZNVF7.LYfIu05ONVuf8Zx7xzRDgQulEoLuW9FoVO.wyBTgrVBT96PH1x8
 eV0magM5GP96MSIBcnISe_6BMbEEUsVPHeT_FZHB182.K8fjuZ8Ki824Nv3bVnwf1Ti2w4b9Zg1H
 ncjZ89BvTwczdHaqwnjHECS8yF4tSCA53irkP8NWJjwBjJWf6L7ZhoWnv2kYqqG2u2nlrnaqWKMZ
 hbsrVPQzkfbMtFQpL0oLaWkIolxShJFrN9UXe9w8N_o880K1S9Rqvt8B8h2f2hSJcDXXMfQhpI.c
 iDMVN87cyQcloTJcsVREqhE2Af3nIoBnpI.fSAsGXf21nLrEAwmkj.ydfZBj_R7nfqA7Gkavx9.I
 QOEZZ2IicskkZ.FgqMO6h25jvWv0hIrNwtFEYVJUkW.nF1iiT28qgk0vwSyxcNl2oWe_PmvlmyRA
 2ufX2TzNczhSiFLGAaRCCl_i7WgKa5JmH_jn74PMWHsc4Y11S..UyHMOgYXiotDY4Eup5Pi7Uc8l
 Qm2QWRgXdQMUlHba8ZpVMRHw3n_n_Ww6z3lHb_HwC4Gh0tmKRNo9Yb4i.gqXEhe7iueUdxYFaZX3
 L8jV0QleJXgpuBh7MWgER5z_ruXSG2kSrNbVXwE.71Av8SZ9N0ianahETYcFcRQPbgdPbP805fG7
 bEnMqWs2GUdlf_uLaV0NE0g45YQp.9Sfty6KsTce_25_wLNOdZl4kCj_cMSs68BfnJV8lLC4znBm
 7Y.ePvXc2.yxbs7CFN0Tw3NCOWNZyw0j9SWJaI2_p1PgRnI0AbtPtdZZzZ8LGrmISLxEeS2exnJn
 BTrZiW5HB78g7wk9kZQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 55fbf51b-1e90-4765-9e10-367ed1e94a2f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 20:58:46 +0000
Received: by hermes--production-gq1-6b7c87dcf5-6x8bf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7160b6de539f095788df3fe36388d168;
          Tue, 12 Sep 2023 20:58:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 04/11] LSM: syscalls for current process attributes
Date:   Tue, 12 Sep 2023 13:56:49 -0700
Message-ID: <20230912205658.3432-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call lsm_get_self_attr() to provide the security
module maintained attributes of the current process.
Create a system call lsm_set_self_attr() to set a security
module maintained attribute of the current process.
Historically these attributes have been exposed to user space via
entries in procfs under /proc/self/attr.

The attribute value is provided in a lsm_ctx structure. The structure
identifies the size of the attribute, and the attribute value. The format
of the attribute value is defined by the security module. A flags field
is included for LSM specific information. It is currently unused and must
be 0. The total size of the data, including the lsm_ctx structure and any
padding, is maintained as well.

struct lsm_ctx {
        __u64 id;
        __u64 flags;
        __u64 len;
        __u64 ctx_len;
        __u8 ctx[];
};

Two new LSM hooks are used to interface with the LSMs.
security_getselfattr() collects the lsm_ctx values from the
LSMs that support the hook, accounting for space requirements.
security_setselfattr() identifies which LSM the attribute is
intended for and passes it along.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 Documentation/userspace-api/lsm.rst |  70 +++++++++++++
 include/linux/lsm_hook_defs.h       |   4 +
 include/linux/lsm_hooks.h           |   1 +
 include/linux/security.h            |  19 ++++
 include/linux/syscalls.h            |   5 +
 include/uapi/linux/lsm.h            |  36 +++++++
 kernel/sys_ni.c                     |   2 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             |  57 +++++++++++
 security/security.c                 | 152 ++++++++++++++++++++++++++++
 10 files changed, 347 insertions(+)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 security/lsm_syscalls.c

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
new file mode 100644
index 000000000000..f8499f3e2826
--- /dev/null
+++ b/Documentation/userspace-api/lsm.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+.. Copyright (C) 2022 Intel Corporation
+
+=====================================
+Linux Security Modules
+=====================================
+
+:Author: Casey Schaufler
+:Date: July 2023
+
+Linux security modules (LSM) provide a mechanism to implement
+additional access controls to the Linux security policies.
+
+The various security modules may support any of these attributes:
+
+``LSM_ATTR_CURRENT`` is the current, active security context of the
+process.
+The proc filesystem provides this value in ``/proc/self/attr/current``.
+This is supported by the SELinux, Smack and AppArmor security modules.
+Smack also provides this value in ``/proc/self/attr/smack/current``.
+AppArmor also provides this value in ``/proc/self/attr/apparmor/current``.
+
+``LSM_ATTR_EXEC`` is the security context of the process at the time the
+current image was executed.
+The proc filesystem provides this value in ``/proc/self/attr/exec``.
+This is supported by the SELinux and AppArmor security modules.
+AppArmor also provides this value in ``/proc/self/attr/apparmor/exec``.
+
+``LSM_ATTR_FSCREATE`` is the security context of the process used when
+creating file system objects.
+The proc filesystem provides this value in ``/proc/self/attr/fscreate``.
+This is supported by the SELinux security module.
+
+``LSM_ATTR_KEYCREATE`` is the security context of the process used when
+creating key objects.
+The proc filesystem provides this value in ``/proc/self/attr/keycreate``.
+This is supported by the SELinux security module.
+
+``LSM_ATTR_PREV`` is the security context of the process at the time the
+current security context was set.
+The proc filesystem provides this value in ``/proc/self/attr/prev``.
+This is supported by the SELinux and AppArmor security modules.
+AppArmor also provides this value in ``/proc/self/attr/apparmor/prev``.
+
+``LSM_ATTR_SOCKCREATE`` is the security context of the process used when
+creating socket objects.
+The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
+This is supported by the SELinux security module.
+
+Kernel interface
+================
+
+Set a security attribute of the current process
+-----------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_set_self_attr
+
+Get the specified security attributes of the current process
+------------------------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_get_self_attr
+
+Additional documentation
+========================
+
+* Documentation/security/lsm.rst
+* Documentation/security/lsm-development.rst
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ac962c4cb44b..97233e6e2091 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -262,6 +262,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
+LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
+	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
+LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
+	 struct lsm_ctx *ctx, size_t size, u32 flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7f0adb33caaa..a2ade0ffe9e7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -25,6 +25,7 @@
 #ifndef __LINUX_LSM_HOOKS_H
 #define __LINUX_LSM_HOOKS_H
 
+#include <uapi/linux/lsm.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
diff --git a/include/linux/security.h b/include/linux/security.h
index 3f79bc191a7c..8831d7cf0a6b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -472,6 +473,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags);
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -1338,6 +1343,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
+static inline int security_getselfattr(unsigned int attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user *size, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_setselfattr(unsigned int attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t size, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..8637287bd39d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_ctx;
 enum landlock_rule_type;
 struct cachestat_range;
 struct cachestat;
@@ -940,6 +941,10 @@ asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
 asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
+asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      size_t *size, __u32 flags);
+asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      size_t size, __u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f27c9a9cc376..eeda59a77c02 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -9,6 +9,36 @@
 #ifndef _UAPI_LINUX_LSM_H
 #define _UAPI_LINUX_LSM_H
 
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+/**
+ * struct lsm_ctx - LSM context information
+ * @id: the LSM id number, see LSM_ID_XXX
+ * @flags: LSM specific flags
+ * @len: length of the lsm_ctx struct, @ctx and any other data or padding
+ * @ctx_len: the size of @ctx
+ * @ctx: the LSM context value
+ *
+ * The @len field MUST be equal to the size of the lsm_ctx struct
+ * plus any additional padding and/or data placed after @ctx.
+ *
+ * In all cases @ctx_len MUST be equal to the length of @ctx.
+ * If @ctx is a string value it should be nul terminated with
+ * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
+ * supported.
+ *
+ * The @flags and @ctx fields SHOULD only be interpreted by the
+ * LSM specified by @id; they MUST be set to zero/0 when not used.
+ */
+struct lsm_ctx {
+	__u64 id;
+	__u64 flags;
+	__u64 len;
+	__u64 ctx_len;
+	__u8 ctx[];
+};
+
 /*
  * ID tokens to identify Linux Security Modules (LSMs)
  *
@@ -51,4 +81,10 @@
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
 
+/*
+ * LSM_FLAG_XXX definitions identify special handling instructions
+ * for the API.
+ */
+#define LSM_FLAG_SINGLE	0x0001
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e137c1385c56..f81f2468c0ce 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -170,6 +170,8 @@ COND_SYSCALL(landlock_add_rule);
 COND_SYSCALL(landlock_restrict_self);
 COND_SYSCALL(fadvise64_64);
 COND_SYSCALL_COMPAT(fadvise64_64);
+COND_SYSCALL(lsm_get_self_attr);
+COND_SYSCALL(lsm_set_self_attr);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..59f238490665 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
 
 # always enable default capabilities
 obj-y					+= commoncap.o
+obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
new file mode 100644
index 000000000000..226ae80d9683
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * System calls implementing the Linux Security Module API.
+ *
+ *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ *  Copyright (C) 2022 Intel Corporation
+ */
+
+#include <asm/current.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/security.h>
+#include <linux/stddef.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+/**
+ * sys_lsm_set_self_attr - Set current task's security module attribute
+ * @attr: which attribute to set
+ * @ctx: the LSM contexts
+ * @size: size of @ctx
+ * @flags: reserved for future use
+ *
+ * Sets the calling task's LSM context. On success this function
+ * returns 0. If the attribute specified cannot be set a negative
+ * value indicating the reason for the error is returned.
+ */
+SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
+		ctx, size_t, size, u32, flags)
+{
+	return security_setselfattr(attr, ctx, size, flags);
+}
+
+/**
+ * sys_lsm_get_self_attr - Return current task's security module attributes
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: pointer to the size of space available to receive the data
+ * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
+ * attributes associated with the LSM identified in the passed @ctx be
+ * reported.
+ *
+ * Returns the calling task's LSM contexts. On success this
+ * function returns the number of @ctx array elements. This value
+ * may be zero if there are no LSM contexts assigned. If @size is
+ * insufficient to contain the return data -E2BIG is returned and
+ * @size is set to the minimum required size. In all other cases
+ * a negative value indicating the error is returned.
+ */
+SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
+		ctx, size_t __user *, size, u32, flags)
+{
+	return security_getselfattr(attr, ctx, size, flags);
+}
diff --git a/security/security.c b/security/security.c
index a3489c04b783..0d179750d964 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3837,6 +3837,158 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/*
+ * Please keep this in sync with it's counterpart in security/lsm_syscalls.c
+ */
+
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @uctx: the user-space destination for the information, or NULL
+ * @size: pointer to the size of space available to receive the data
+ * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
+ * attributes associated with the LSM identified in the passed @ctx be
+ * reported.
+ *
+ * A NULL value for @uctx can be used to get both the number of attributes
+ * and the size of the data.
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
+			 size_t __user *size, u32 flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
+	u8 __user *base = (u8 __user *)uctx;
+	size_t total = 0;
+	size_t entrysize;
+	size_t left;
+	bool toobig = false;
+	bool single = false;
+	int count = 0;
+	int rc;
+
+	if (attr == LSM_ATTR_UNDEF)
+		return -EINVAL;
+	if (size == NULL)
+		return -EINVAL;
+	if (get_user(left, size))
+		return -EFAULT;
+
+	if (flags) {
+		/*
+		 * Only flag supported is LSM_FLAG_SINGLE
+		 */
+		if (flags != LSM_FLAG_SINGLE)
+			return -EINVAL;
+		if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx)))
+			return -EFAULT;
+		/*
+		 * If the LSM ID isn't specified it is an error.
+		 */
+		if (lctx.id == LSM_ID_UNDEF)
+			return -EINVAL;
+		single = true;
+	}
+
+	/*
+	 * In the usual case gather all the data from the LSMs.
+	 * In the single case only get the data from the LSM specified.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+		if (single && lctx.id != hp->lsmid->id)
+			continue;
+		entrysize = left;
+		if (base)
+			uctx = (struct lsm_ctx __user *)(base + total);
+		rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
+		if (rc == -EOPNOTSUPP) {
+			rc = 0;
+			continue;
+		}
+		if (rc == -E2BIG) {
+			toobig = true;
+			left = 0;
+		} else if (rc < 0)
+			return rc;
+		else
+			left -= entrysize;
+
+		total += entrysize;
+		count += rc;
+		if (single)
+			break;
+	}
+	if (put_user(total, size))
+		return -EFAULT;
+	if (toobig)
+		return -E2BIG;
+	if (count == 0)
+		return LSM_RET_DEFAULT(getselfattr);
+	return count;
+}
+
+/*
+ * Please keep this in sync with it's counterpart in security/lsm_syscalls.c
+ */
+
+/**
+ * security_setselfattr - Set an LSM attribute on the current process.
+ * @attr: which attribute to set
+ * @uctx: the user-space source for the information
+ * @size: the size of the data
+ * @flags: reserved for future use, must be 0
+ *
+ * Set an LSM attribute for the current process. The LSM, attribute
+ * and new value are included in @uctx.
+ *
+ * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
+ * if the user buffer is inaccessible, E2BIG if size is too big, or an
+ * LSM specific failure.
+ */
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
+			 size_t size, u32 flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx *lctx;
+	int rc = LSM_RET_DEFAULT(setselfattr);
+
+	if (flags)
+		return -EINVAL;
+	if (size < sizeof(*lctx))
+		return -EINVAL;
+	if (size > PAGE_SIZE)
+		return -E2BIG;
+
+	lctx = kmalloc(size, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(lctx, uctx, size)) {
+		rc = -EFAULT;
+		goto free_out;
+	}
+
+	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
+	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
+		rc = -EINVAL;
+		goto free_out;
+	}
+
+	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
+		if ((hp->lsmid->id) == lctx->id) {
+			rc = hp->hook.setselfattr(attr, lctx, size, flags);
+			break;
+		}
+
+free_out:
+	kfree(lctx);
+	return rc;
+}
+
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
-- 
2.41.0

