Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3400C78B9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjH1Ujz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjH1UAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:00:22 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B05E5B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252790; bh=HCIySn/1FKI3yeDY1naM2LdltXRa1H636L7BVhL2cJo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lFpS8wUzuFEEcL4kma80MY9s+sAkio8CMafwoamhGWdsttdrWMyoUveu8E0fe1g8g1N6J/o5wldSN6ih6Vem1LuHCKKuApCXoqGDhNXeGpfL8AM7oHc5XvfYRcwriSO5uwx/jcXllmIB05oSCLcgN9H0kK8mbgd9UL1ul+vj68z32dsv+XI4nl4vveMpkzn3Ln7qcmE27o7RhxDMkgS+02pbXOescPXZPa7VU4mB6h1BIUk9WeXSUurJMmaQghl02q7vA0w3QKYIj7QKlnB2R6VZZMD4ipZu/gafk+BNEYXqFGLzNUh7Rmt94UC5p/3rxd8l6hNiy2cReSrgOaUIZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252790; bh=urR5AKNWQCLxBi7dWZHsE31hyrPkomVwWr7cs4YnzZx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=A97Mkz2daPNGa7S7tjiMhxy2q+1dHVRHARV8+Ak6QIgJCwGmVliVv8kaofnD1FPoITXg/Sjasb4Wr2qWAPG1NpkTQIioUv1Pouzbv/mYXRlM5G7wBynZDzvNtwy0iWs3MRjrbYK7wctnZdBngz0GcR5+ZYlrlzMni1OBuHToFkh0Zt3xPeigmzCFzJEbHC6RGZBTqjG5ce3282lJtPQkke118B1x7gw9N7RtuI2TRio7l6pVFyLNpLaMogEqS9LGCrJq6Ihy+8BWpeS0kOXI09FvansoMJWKTeSPM+GkS343AqfcLJgB/LS2EQm2ZlcaDPE5ki5DN1um96/bKGMmqw==
X-YMail-OSG: YhkHmAkVM1m0jDlQHLtn2YlDHxfvE5rtb6XGf1AI10TnB_Zk0Bp6U45QYe9YZh9
 ck.LxiUwMQwGjX_rXpJANiruQuBujoCKekARsj0wIKBtkFQzFEx7vuWK614VJ28DqOVvuc9Yj2dn
 s2FCGyoW0hmXvhFLL9cLfVvl1Y.wD2OkILi_nh99QV9JlBvrft8Whn0N.1dZNfcbdJXx3_wByxPl
 CZxzCK2v0T1kPI9HIkhhMKcNhDhQGYhDmmWMwcflcEUzEN6m8xJRHQ_oVOgChdWwFs_7bqpIm2Rd
 nrpJ4D9RSZDginPbkWqWmPaIFQGgEtnAZq1G3O8s.k7jMcdwVKMWuQaFms36lFiWc9KcU7MC6H.B
 E5KAj5m7ennJDj56hlm5jxcjgGm_LzhGt4KuP0.ZboeYBNZ_d6pfSy7klhc1sG6p8eDUh2AH9umk
 tI25Cc2pU43Vl8Wh.ZQhEPuPxn61yKtBQo9e7YWbWbfSMTXI1huAxTMmnGodtNNjy6QMvF3Co65n
 DkWm0DF_5KM9IaeYZAwdSIDDcitIWk6SBDu08Li6noO5RLEv_rC8jcy6Gc7Btf8908RSq4p3Glxd
 ixUSf7BkZJHlEqp7h7bjosoQc807kMjWVeybVUZvCRATRKKE0V.ARq6bl5yvwjpmbjNvwENig_HR
 Pm31ww9NsSzhAVBseUcDAmVz9gBnukG5p4Yf6gkr4QBq4mPwsVO33C39FhqemoLGIXUq36MDvoZ2
 moQNPAQ3QlAQ6prYgmIx30msJ6gAqJOJq6QdyJA12TGD6GIegy3Vo.L99qrWUKcKPbJdiYnpia0h
 B1O3fyp0ZcVk.TNwUlLG4he83MhS9HQqj3wY35ve4Dzsys7YeI7vgXgue2NgbZSRhxDHrKHc8SJT
 _8hcD7aXN4XDNJdX67n_PS4CJqc1_iBMkN1e6nHOssy9oxUSHtc_8Kv_7ME4jr6_IFLfUJLy3_xh
 GsUFnSqyDtt16EEMuUxZk0DUV.6_zQOkCpE6arzY_uIAu6ydbE3jGgRz8_6okMrBRQdYWoUtDd40
 gSbLa333NMeBUIOzwbCXeYMhIFK0MrFGUn0hbJTZuX0LkWsQYjgzq2WwZI.3Fv2XbkHpwEIQx5ee
 JGYGQobUe1aHshTphKiEs1LkRfgUqHNr8B8biW35CRlEZBksLTbXBBcP7FISbwEUlfC6QdwljiU9
 JAueg7ckH91jd1dBHNvNhNFC5SKdqkFiw6if839nL9m.GnVwOoaWz1bUk2VcG4yesT8iW1T5LnSK
 vmdZiXbcD5qj66nrIVWmBywH4djN1n67zzx3J0bwDHknnuyuWhJfua63A3KunH9q.kScB0m5Gcaa
 QPDqyQ6vwgshy.tmVY1jvXsJGjE8a2xIli_F0i03rpqmN.4wKV7xWbw_WU3.R1BvJY9mRk1PHztn
 UdqgD9txn8IlmBR4ERTp1VtxCC4JtQ8uR4r8OJtZRa86Ic5WoqUrLK8ir6TMBIJYDlSmzCI1Wb4g
 FHfuYbaJ94a7Tt9F2LpFXdky5opgi.MRhuAFnswBAC_k5R0JC.4TPHNb4jWh_KUM8y9khQhTBv0X
 wSor6q4N_.BgchAxrHftLT55T7T9rWBLLRri8P6Q1VQ1aNLdcRyEOK7eyhIhUEv25_6iyGEBMfk1
 2gTr0MTW4ILwyx01ANZIT3iW33FbXeMx5n__WtZkp_URZad9WuPCkrT6TTroO2Gj0Ks25dBffSFy
 PPxnJs.eRhmCEwCjmxaZlNCnKUugy6QHeu0no1vUfr5cfM6Lkog_is6UT7kmkyrE0th8e37vICdX
 0QtHMo5ROS33qSSd46x1WR8Bx6uxd0TcHK7ulzaThnICu0yemvpkTdQKhnHk3SacPEu4Xv4WgcMR
 9rmWR8yhppixFoipwNl.AzOk.UWP.NQkaGO8xzW9BQlDEMaKtytiMCbRp4S07ZsCodEfojPiHoM6
 5F13wBSrrhris764RchbiTOMfP5Mbsx6tYCd1T5v3ZVVZL3lbHvda6gKT4s.x0MvP1q1pDARqsSp
 PmrixneIdDKfhEaDFqXTcMnnXctN5ImkklI5H0m9B3dYAKS684FZ7WgZ2JyqJdE4p3mtpNsaM4md
 VsHvOKF5vn206kUtTINTAvA35uIJvUvLDrWbM2wAvwlx07RGwC0_OZynXENRrAHrakFboRpOgP0C
 Nw3kAtedO634fopfM_OxSVK2mSsIap5RDssvRxL_QDgxR9b1kBfvzv_PeqvOB219Ur7tqJSkGNfu
 0LaY9ObZqrjvjx_r5t_AlvAUkTqruPqxGXoBRVSeUCf2zxOxybAuxyl7_4CbtdjNPvmuwJDwAcuF
 29fR39l.WZ_PitkZBtg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 468d03e6-880f-4db0-b2ac-c34562176d52
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 19:59:50 +0000
Received: by hermes--production-bf1-865889d799-x5klk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4fa193a662e8d287c56340453369fa5e;
          Mon, 28 Aug 2023 19:59:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 04/11] LSM: syscalls for current process attributes
Date:   Mon, 28 Aug 2023 12:57:54 -0700
Message-ID: <20230828195802.135055-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 security/security.c                 | 146 ++++++++++++++++++++++++++++
 10 files changed, 341 insertions(+)
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
index 7308a1a7599b..6dffac59dfe3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
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
index 5f7d8caacc00..0662e5c2cd06 100644
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
index b5fd3f7f4cd3..0d882cb221f4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -470,6 +471,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1331,6 +1336,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index 03e3d0121d5e..a3938850752a 100644
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
@@ -953,6 +954,10 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
+asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+		size_t *size, __u32 flags);
+asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+		size_t size, __u32 flags);
 
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
index 781de7cc6a4e..8b96cd01b485 100644
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
index 82253294069c..aa4ade1f71b9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3798,6 +3798,152 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
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
+		if (flags & LSM_FLAG_SINGLE)
+			return -EINVAL;
+		if (uctx &&
+		    copy_struct_from_user(&lctx, sizeof(lctx), uctx, left))
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
+		if (single) {
+			if (count > 0)
+				break;
+			if (lctx.id != hp->lsmid->id)
+				continue;
+		}
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
+			total += entrysize;
+			continue;
+		}
+		if (rc < 0)
+			return rc;
+
+		left -= entrysize;
+		total += entrysize;
+		count += rc;
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
+ * if the user buffer is inaccessible or an LSM specific failure.
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
+	if (size < sizeof(*lctx) || size > PAGE_SIZE)
+		return -EINVAL;
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

