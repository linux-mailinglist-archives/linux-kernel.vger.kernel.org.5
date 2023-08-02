Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93076D5E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjHBRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjHBRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:47:07 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB23598
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998386; bh=uZc+MJKnm/BXANfaxK7gQt6Nw8eojtSaMlCWNkfATAc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Etx5IFe/BHMp1iQV5NJpbEW95vHl/B445Gdp4wH7b32X1iAthi4+17clcd32/roph99rBAL+NH0GxTujEeX5Lv7PkJm8cjvMveJl7Q89F+xGX7lcB0lGIF+qC8Xvnx34sCRCA2PEzCPoIlutiFRlKyA4hB8mX0sBy837klRYidTmqiO4xOk5xHEh5yqPC3YFYAzeHrslTIo4Ej31iwMxF+M3gUJ82UCvyIADjtkBgT+nJfrDiZxLCnyJrpHlFWLeVe33ET6+cw3esSv2obEwieSdHRYgg7jwzFlgTaWFd8bLMJc5d+8Mf+ieawwV4lEPqcu+8+5w4BWKDmHKurKjAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998386; bh=/L4COYQ3d4j16mx5eVu4E6gTXdyeAG7gbVGWPNXDI88=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UJq/zjNh98EGYeEOlSGfVDLtSHAU19cJ1Lgkci0WiuxUZNzddY2IWJhnHXXfHn2s5Jw8tJ9cSA+eMyA8623AdpCBnYkqS/EfTpqT5xJi/TXEiGK0bb23rwNit41q04CwPZ8XNICr7/R1NBRG1hFGa0/Ycl6OFXGGJaAUYBiRadmNZhC1o0jrG19LSziwsMGkjQLVZgXBM7rYtZDC7LK0/lZBs9DRwB8iqWJYSw7qh3kjDSw2nZj5hAlnY2K9AXCXYeb/tHQPJ5eTLJt6/r86u57RTzAyZScCdd50fGhotcfgT9ItM8UP3aohUtsMZClE7AMGDGijgM7HTOBkNXSnzA==
X-YMail-OSG: g9XArv8VM1kudSpHQKdzx8TLrbzsDDdG.sOyRBocrDYdWrPhESO785DVA6Mybh6
 _V0Gn4th4w7PTdo1c9d34cD2RQ0Uesylnmdg5Jw8BmUbc.FGQvb7psinTJGvagVZcuy8QJEPFVEJ
 r9.fLf9VVANdNYjtN0MlGeO_E77ItHjqMApC4M7radQ.6J.4dDyURXZWkmSmulmD8tRRmz4gwCVi
 xlHhI9dKagSgOGYaPLZ8EIYs4Fj.2p3f3GesdQLN_RcjQfvZoWT5oUQ8jxbCxxyn7MsgmJHRHYc2
 y2kh9HxI6iEeiAGQVsXIwcMOQb2lc887V5h.4xXzLizhll3XP5z.f5bQkEQrlQV9.ZW37TuuSRqC
 UXEHwF9.1YnxzYj7njck4qERRrLVPGMXS7p2veKbX8GaU0bcOYOWzUX.zKr8AhZ2v9O8bmMpY5xD
 pbq86PF0nMbIYTdNEuSnGIpDbFPoHZDUFTbo0z.gBnQnOWbgfsLsoYKoZ0cN74RTDnjHir6Ez3uM
 wfiuaCugEpgEVni.EqUEW0yzgWE24j5s234P.uOY6H7YLOR7yV9IxK187nC_SPzFolZF5vjrUgdc
 a6o2JraNxL0xbM7OHsrEZOK15nD4Wu1C4fNEN1IQH4ugO_ABfSDn0sa4LvmqtHrLdKcuSVn7zRn3
 cOTb2LxplLngdpqoYNinlpOXsSuV1lVfbG4J0Zjj2F502GP63iS5qqDP_zS2h34whb.GNVwu8lFF
 wRUXAJ615rI5k.A3OTcXTXOeTscIOHR.IFOu7reVg2HOkDGnN1H8IX9egQ48rkc4Urb.wZZdSb_q
 .UOOl4kgAIocNeVTBeeWKIWr8bFMbuZhhEYrIuu0HPHvdqqWVRsHvB3bk28B20ak8jpeRse1_lnv
 v_.cjspqC1MG2NSRJkhVykbdKY7jY3EI9iB4RrjxRdknn8rNtCBdrUTPwRbXFWwOiid6uZ64384t
 1U5EQiUhdE9go9UaKjCLkEFPkIQx024HJ_85l18yHinJRg6KCIUfJTE.op95tAY60p1WVmJCn9.h
 bu2B0hU8YOOqJD_KIz7Elw_5HE6neRpJWpyqDBcu1rtZgBOi4EYRxFpriWkKJGdvSak5WtKIHsAL
 AMhRt_7RF3S1WVqgCen91gpG8w62gJOTyHdWz2vGxiuNe_v5FjowjpdCg9mSF8yFMqwiBSUjmGZ1
 _imJz3mUkuSHoNIHNRHcP11bMv35QrEkzA03qAOz8Ai0rD100nS0pF4sWu0BcSjCIkQGaDz_4zVT
 hC4WfoURmdRgXXbOVII_dFei23SXFUA80UhCa9XpT0xv.SrUIaNffS5D6_PZG1O7KMcPnMMUvafG
 u.Z0xIxN0o599FRJwV8MErpJpvV_cS0WY.yKeneKT8NMTncgztK7wlclw.PqToR6LG98vYCLC5Nu
 9znOQ5C8q_FmK_DzeSqFG7qEq.UFDsZdKqHRpAUpTuEYBLZKKLlZ4i3SB9fIGPjSO4X0bQ6SwxTQ
 gWsrtxVWyZ423NduD6U9pab.RKhZRSbxua4AENEd3U.U.YbEo_WBd72Nezuk2vhWqYj0by1l_R3v
 Lztgt91X_a86Mo4V5ERv74d8OkYjQAXufH.cxPIRO2gMP4AObIo8ZHqWTxT6Fruv7RiqkyEKP2c_
 8vzOAxU9cey0pN8YY08cXobitFdcDSA8dsRmjz5hatsMIb267hnaegeWHjDV0vP9vmf36cRfT3ew
 SP7GEyo_6790febLV0iAJJLk5kQC3mEIG2H3FTp2hq.YFMzr6neNNQnjNN6s17xpph.XPsWwiafo
 Apiou4SPdO_MvgFj8wK9McO6CZw66cUkFXwCMaEt3kUgrTHdVcIhhWysYV.CFd1swUOeOC3iZybV
 2KXXPJBM8V3E4MZWWVGDBpI3cvNSqZCMOT8HyYu1t5_Lqm_Dr4lk0SPULB5t8ptw7QjomOUP677B
 ASOfmpMiy84hvr.pZs9.H_zlatClQ1ouXTJ3VFSDgtYMWqjdKAwCTLSZMkeUyZ3N9hFEgX07cY0x
 i0AAjAgJkDze2o1qiPxIv30Upauso..GzwHqRgD.B2It4eeKI5LSC1yotulHOFZvdLh5JRTymLpy
 7Px3sApZ4t3BDfWSCnSqDNy5fR8jxaoItjnTJxZGafz9tUZn1HyeFRn_BmaAJG9J5p8RYSYOQYlg
 WElkw40TUiYlgOAojTnh1uciDNyPcJV6aGzjIgsXyKA2HOQySY6yvUBDxCU_zgNSZigVuW0us4NL
 Qd4XEwuTvrQlEnU5SfKxTi5ljDMeF6joEiACGzg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c542e6b9-7384-4f37-bb0f-f8a230afe973
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:46:26 +0000
Received: by hermes--production-bf1-7c4db57b6-4hrkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49a3a41e5715f67667cdb3b18eebd6de;
          Wed, 02 Aug 2023 17:46:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 04/11] LSM: syscalls for current process attributes
Date:   Wed,  2 Aug 2023 10:44:27 -0700
Message-ID: <20230802174435.11928-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 Documentation/userspace-api/lsm.rst |  70 ++++++++++++++++
 include/linux/lsm_hook_defs.h       |   4 +
 include/linux/lsm_hooks.h           |   1 +
 include/linux/security.h            |  19 +++++
 include/linux/syscalls.h            |   5 ++
 include/uapi/linux/lsm.h            |  90 ++++++++++++++++++++
 kernel/sys_ni.c                     |   2 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             |  55 ++++++++++++
 security/security.c                 | 125 ++++++++++++++++++++++++++++
 10 files changed, 372 insertions(+)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
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
new file mode 100644
index 000000000000..eeda59a77c02
--- /dev/null
+++ b/include/uapi/linux/lsm.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linux Security Modules (LSM) - User space API
+ *
+ * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_LSM_H
+#define _UAPI_LINUX_LSM_H
+
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
+/*
+ * ID tokens to identify Linux Security Modules (LSMs)
+ *
+ * These token values are used to uniquely identify specific LSMs
+ * in the kernel as well as in the kernel's LSM userspace API.
+ *
+ * A value of zero/0 is considered undefined and should not be used
+ * outside the kernel. Values 1-99 are reserved for potential
+ * future use.
+ */
+#define LSM_ID_UNDEF		0
+#define LSM_ID_CAPABILITY	100
+#define LSM_ID_SELINUX		101
+#define LSM_ID_SMACK		102
+#define LSM_ID_TOMOYO		103
+#define LSM_ID_IMA		104
+#define LSM_ID_APPARMOR		105
+#define LSM_ID_YAMA		106
+#define LSM_ID_LOADPIN		107
+#define LSM_ID_SAFESETID	108
+#define LSM_ID_LOCKDOWN		109
+#define LSM_ID_BPF		110
+#define LSM_ID_LANDLOCK		111
+
+/*
+ * LSM_ATTR_XXX definitions identify different LSM attributes
+ * which are used in the kernel's LSM userspace API. Support
+ * for these attributes vary across the different LSMs. None
+ * are required.
+ *
+ * A value of zero/0 is considered undefined and should not be used
+ * outside the kernel. Values 1-99 are reserved for potential
+ * future use.
+ */
+#define LSM_ATTR_UNDEF		0
+#define LSM_ATTR_CURRENT	100
+#define LSM_ATTR_EXEC		101
+#define LSM_ATTR_FSCREATE	102
+#define LSM_ATTR_KEYCREATE	103
+#define LSM_ATTR_PREV		104
+#define LSM_ATTR_SOCKCREATE	105
+
+/*
+ * LSM_FLAG_XXX definitions identify special handling instructions
+ * for the API.
+ */
+#define LSM_FLAG_SINGLE	0x0001
+
+#endif /* _UAPI_LINUX_LSM_H */
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
index 000000000000..ee3881159241
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,55 @@
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
+ * @attr: which attribute to set
+ * @ctx: the LSM contexts
+ * @size: size of @ctx, updated on return
+ * @flags: reserved for future use
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
index 5e9cd548dd95..cde7f3a13e7c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3798,6 +3798,131 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: pointer to the size of space available to receive the data
+ * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
+ * attributes associated with the LSM identified in the passed @ctx be
+ * reported
+ *
+ * A NULL value for @ctx can be used to get both the number of attributes
+ * and the size of the data.
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
+	u8 __user *base = (u8 __user *)ctx;
+	size_t total = 0;
+	size_t entrysize;
+	size_t left;
+	bool toobig = false;
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
+	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
+		if (!ctx)
+			return -EINVAL;
+		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
+			return -EFAULT;
+		if (lctx.id == LSM_ID_UNDEF)
+			return -EINVAL;
+	} else if (flags) {
+		return -EINVAL;
+	}
+
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
+			continue;
+		entrysize = left;
+		if (base)
+			ctx = (struct lsm_ctx __user *)(base + total);
+		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
+		if (rc == -EOPNOTSUPP) {
+			rc = 0;
+			continue;
+		}
+		if (rc == -E2BIG) {
+			toobig = true;
+			left = 0;
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
+ * @ctx: the user-space source for the information
+ * @size: the size of the data
+ * @flags: reserved for future use, must be 0
+ *
+ * Set an LSM attribute for the current process. The LSM, attribute
+ * and new value are included in @ctx.
+ *
+ * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
+ * if the user buffer is inaccessible or an LSM specific failure.
+ */
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx *lctx;
+	int rc = LSM_RET_DEFAULT(setselfattr);
+
+	if (flags)
+		return -EINVAL;
+	if (size < sizeof(*ctx))
+		return -EINVAL;
+
+	lctx = kmalloc(size, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(&lctx, ctx, size))
+		return -EFAULT;
+
+	if (size < lctx->len || size < lctx->ctx_len + sizeof(ctx) ||
+	    lctx->len < lctx->ctx_len + sizeof(ctx))
+		return -EINVAL;
+
+	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
+		if ((hp->lsmid->id) == lctx->id) {
+			rc = hp->hook.setselfattr(attr, lctx, size, flags);
+			break;
+		}
+
+	kfree(lctx);
+	return rc;
+}
+
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
-- 
2.41.0

