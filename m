Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CF79DA53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjILU5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjILU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:57:10 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD72199
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552226; bh=aIi122Y/rRpmVw4Umfkbhj9bss7sAbaqRZ5FtF1XhlQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=f0aBYzT2GmVhpwlWUtVSMVb8BOLywIUFRY8S9Wopk9cbPvVyvBExlFccA0Sr/XhfbezKVI3a/djNY5mjXvsILW+RpAKt7uvAygAc7ueRhljNq28EdyTLq1ijCnSPM0Npq7lIw+ZkUdLPDOF3JxRhV6aUmJ0fBZ7F+wsw3mbu2WskmiFcZOVB6QIJhysITJ8lfor59PEDokMSPk4vxF3V7KQCMbCqJddKQqBSLq5WOTOfRxfIZAzjpglkOYha4d6SYphJR87dSEXYBcF0ff4bq2tpUFbblwvuP7JyD1uWXZKGgeafobtL5L69SXP3BwDOiJRfXdbySAUTxnuvh2TD9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552226; bh=dIk7oZEgdAGLgwiXjx2mBNS/4ZOpQ8ddoxH8MmAFTZG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TGW0ExmTtpuOUDb77OHAZ275jaD7RFqgV01KCecFuJ9KMDVL08q14p/khxcYJFT+qPveJl29oY+mMbb46gUddFoQalaS+OlzVIrcHPy+cHQOEZyfbSS7Rcuz8hsrZ0S/sPuUkPsl/DOxKhwRolLjKMLVwfnnQ9csgNNk0fibNNlqKvkeFMrIo2waPz8db6WgtQuIAupIAb65AOj8Mk6TAPaM6CmkQMAi+CaM50+02kk55650f5pD8px70yWSPdcCTBFPEU9eG3NSzfm9R/HxMDG/0lpqLH8PORG/LTs4MRgfkDErUgt+DtI5ha0NkScl43s6l0WFVDOqKErv4dR9GQ==
X-YMail-OSG: oAyQz9kVM1mL7KxSl55x1jZaciG_fWvpBNl.7wb7J7aavoInh4Pwf99uP1vdpeL
 earSDxrKepc6ykpsDdJ4SxU8yXdHS9lNhANlMBwBhHr4ZOpJ67tiwV6vodfd1GqMzL_ydT1l7R1k
 DyFRaN4v.Jm8SCQU_XfkvfjEhAW_b.VgjevWL.kPmGtFWJLrVWoM7_MvDmkMedPi2x70dJVje6Md
 uJqI32mPatTkoRcp86aWIMkfkheMx6tkZRcGj3OUwZ0SXI9HIURXB5lull6ctWE_8tfzm_wzkYxi
 C_K54YvqfAB_dsaTyoOGGuKmFrQUM1tQlrYKt3YpvwEjn74WK4zlyNCOUk5vE7B4XX.fAF6mJiKi
 H4TMX.2DqOaQ25f7heMVZtmb2FzV7zAy8NVNALKYtoHy_Pcvy8Jj9D_uNP0W8Ki.o5YI5zDQrm9D
 20ETaY3LDmKqxlDxWXngcs9Ndamf8OrCqmohduWd4nleKCKsPxh2X0XRHzgLE8haHc7xcWAmALiN
 _AC1akd2r._DUwnElfv3xRNfbwpbqtXmcK_adbSc79akspmSszYICY72abK0uKa2TzIsfAeavHPg
 95hm0LIsyXX4JqK7WSjZ142oh6xp_iy438XrzaQCInUnyOYijla16ibqW8tBoDYM4jfoakrIF3gz
 UbOAhf_8gUz0tNaS5Z5SQnjyjchIU1Q5EiBnatBW5XwtnPkWV4yfDE0BVftA_SvkaJFpILiXceTd
 I.KCr0wqeQLNK6riIDi3wZRyrmdHty5c0sjiZ3hAljxywYfvXCNCIQODEjJ.okwBl_9lIzRyX_qZ
 9NuD0VMuWx8fAB8KNkmz1oPZujH0IY_AnBcf8yDiy33UH637M6lVUGRNZuBPRLAnb0K6YiGzXIt1
 Wh8PSf4FAzQlZ8pIkwKOjPlrfqI1EBN_w0ltXFIShd5u5xpSwCvrIu6sxNX8Mz4PyPQ7fTcowXCj
 .VSN8ch341g_CH7bdFyZukLvh5zpC0kwvJRO1sfGvLInHXsRjvV4zf_QqBbu1k4M2ry92SE9CatZ
 Al3pH7L5e.z4ySiNdxeR6G8ROE2uicLGpoRQqC82EfN8RMe3TYwcaHLz4NdzH4Ku0ABN7LEAadCW
 _qYy65tWoUqVRvhzTl2lhUnmm1u1JiqTQnkfiPJ7l2X1QkO4A68sRhXzGYO3cw1zvHe_btbIerSS
 CU3XmySUEeBZxewpbo7_cJ7p776QiAouOV2_Nestr9dKYi6FDcEkkdCzCn5jB78mHpS4tL5z1UAk
 MMgIIZP8zsAoOhJb8rNk82vHDbnW.XQETofkzTXVenl9R5hShTrKHghtzFpiY29lFlr2yUzkm7zA
 Mme7AiCAtTBF70LMjJCya222BYcfLuSwphztEM_iBZHr9r5qzfQ_tZsoM6b6ZakP0_6aLKg9L54X
 f98dkYfGHyNmCyFFbaTTWYFKpLdYaHQahsRl2XZCqpyJ2JgwCDv98VrVPInqOFE2CYXLsNEH27I1
 QPr9meihMT3rj1_zazzAYypbTENy12ZNe3rpmKKaJFim0YE9.BCuHrKVZLr9p1R7zLB9zgNiLk86
 3HaRSYXrg.0qXoLObJDQjDAow9b9rGmobsCUE_zrGXGrryZcbpqtpFx2J00T.iC6nYT0G.ygE46d
 cE8agn1XGSzOIAAupQIxUll8CVxIM8zRryuvMxZoU2cEmR85hzNughW9nHM4w1NrO4hJ7H.iMPPF
 1suUidnRzCFe2i1ghxv7SLz1g3jZT6pDrk8a7X7qcKt3a0q5vgBPUnHPUwxBFERU6j38z5S.7gPL
 ifOxNlVNZLqFLv2j0754t8OAjPjmDwkC9J3v8JVRMZAg_1H6EoJGKkypfxzxx7jsCIyS1m6BI0nr
 gf6XNMfHwprFUuvSaRY3mcYd.NSCum9WL5mTy4jX93XujS5n5bTyyLXEQ4KvDRskre9MvGgH6ZF_
 WK9XOEolxoI.vZh7TEKfxNNI0sfXkIeyQ3TNB3pA.Lx5I6Uk5ziuJEzQAK5GOG9wwyiIfHtD6XRe
 wwEgwqJFw6SHQhZUWNGbs2Rg3YE8MzYRsu6XodwRhil9iriHBQi6fTAnOr1.qBnH6wrI8X75XgaR
 dX2fysCgg_cL._vPGlF3CkVb5qBYgnPJ0vi6e_vadPXNXymyp0ecBCeb3JbTNvyzDK8jAooqk.IA
 YKvWLOhkaNiBbEUA2zmFA6DYSFULuUd3_ZD.AjeJEuQhwhqYX6Q0HLp3KqOKM__s_zXXUNlIUVtE
 NjkVbONOaW0ltUzOvctriGvsPUfr0k8b9Ie7GYE3c7WgAwFGFb0o1SJN8jfXy8yIyVw5NwhgR.JQ
 firpcx6xW5uVXz1nT
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f851a7e8-398b-4621-8711-5597922e3846
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 20:57:06 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f651283ea04feeaf2c9a6af092ec150;
          Tue, 12 Sep 2023 20:57:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 01/11] LSM: Identify modules by more than name
Date:   Tue, 12 Sep 2023 13:56:46 -0700
Message-ID: <20230912205658.3432-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a struct lsm_id to contain identifying information about Linux
Security Modules (LSMs). At inception this contains the name of the
module and an identifier associated with the security module.  Change
the security_add_hooks() interface to use this structure.  Change the
individual modules to maintain their own struct lsm_id and pass it to
security_add_hooks().

The values are for LSM identifiers are defined in a new UAPI
header file linux/lsm.h. Each existing LSM has been updated to
include it's LSMID in the lsm_id.

The LSM ID values are sequential, with the oldest module
LSM_ID_CAPABILITY being the lowest value and the existing modules
numbered in the order they were included in the main line kernel.
This is an arbitrary convention for assigning the values, but
none better presents itself. The value 0 is defined as being invalid.
The values 1-99 are reserved for any special case uses which may
arise in the future. This may include attributes of the LSM
infrastructure itself, possibly related to namespacing or network
attribute management. A special range is identified for such attributes
to help reduce confusion for developers unfamiliar with LSMs.

LSM attribute values are defined for the attributes presented by
modules that are available today. As with the LSM IDs, The value 0
is defined as being invalid. The values 1-99 are reserved for any
special case uses which may arise in the future.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Mickael Salaun <mic@digikod.net>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 Documentation/userspace-api/index.rst |  1 +
 MAINTAINERS                           |  1 +
 include/linux/lsm_hooks.h             | 16 +++++++-
 include/uapi/linux/lsm.h              | 54 +++++++++++++++++++++++++++
 security/apparmor/lsm.c               |  8 +++-
 security/bpf/hooks.c                  |  9 ++++-
 security/commoncap.c                  |  8 +++-
 security/landlock/cred.c              |  2 +-
 security/landlock/fs.c                |  2 +-
 security/landlock/ptrace.c            |  2 +-
 security/landlock/setup.c             |  6 +++
 security/landlock/setup.h             |  1 +
 security/loadpin/loadpin.c            |  9 ++++-
 security/lockdown/lockdown.c          |  8 +++-
 security/safesetid/lsm.c              |  9 ++++-
 security/security.c                   | 12 +++---
 security/selinux/hooks.c              |  9 ++++-
 security/smack/smack_lsm.c            |  8 +++-
 security/tomoyo/tomoyo.c              |  9 ++++-
 security/yama/yama_lsm.c              |  8 +++-
 20 files changed, 161 insertions(+), 21 deletions(-)
 create mode 100644 include/uapi/linux/lsm.h

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 72a65db0c498..b5fa29c077eb 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -32,6 +32,7 @@ place where this information is gathered.
    sysfs-platform_profile
    vduse
    futex2
+   lsm
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..935334123b04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19307,6 +19307,7 @@ L:	linux-security-module@vger.kernel.org (suggested Cc:)
 S:	Supported
 W:	http://kernsec.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	include/uapi/linux/lsm.h
 F:	security/
 X:	security/selinux/
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dcb5e5b5eb13..7f0adb33caaa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -42,6 +42,18 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/**
+ * struct lsm_id - Identify a Linux Security Module.
+ * @lsm: name of the LSM, must be approved by the LSM maintainers
+ * @id: LSM ID number from uapi/linux/lsm.h
+ *
+ * Contains the information that identifies the LSM.
+ */
+struct lsm_id {
+	const char	*name;
+	u64		id;
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -50,7 +62,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	const struct lsm_id		*lsmid;
 } __randomize_layout;
 
 /*
@@ -104,7 +116,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       const struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
new file mode 100644
index 000000000000..f27c9a9cc376
--- /dev/null
+++ b/include/uapi/linux/lsm.h
@@ -0,0 +1,54 @@
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
+#endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 108eccc5ada5..20b93501fbd1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/zstd.h>
 #include <net/sock.h>
 #include <uapi/linux/mount.h>
+#include <uapi/linux/lsm.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
@@ -1215,6 +1216,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+const struct lsm_id apparmor_lsmid = {
+	.name = "apparmor",
+	.id = LSM_ID_APPARMOR,
+};
+
 static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1904,7 +1910,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index cfaf1d0e6a5f..91011e0c361a 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,7 @@
  */
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -15,9 +16,15 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+const struct lsm_id bpf_lsmid = {
+	.name = "bpf",
+	.id = LSM_ID_BPF,
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index bc0521104197..9aaad2c3e54a 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/mnt_idmapping.h>
+#include <uapi/linux/lsm.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1440,6 +1441,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+const struct lsm_id capability_lsmid = {
+	.name = "capability",
+	.id = LSM_ID_CAPABILITY,
+};
+
 static struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1464,7 +1470,7 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 13dff2a31545..786af18c4a1c 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..db5ebecfbf02 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1307,5 +1307,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 8a06d6c492bf..2bfc533d36e4 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 0f6113528fa4..aab13750edde 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
@@ -24,6 +25,11 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+const struct lsm_id landlock_lsmid = {
+	.name = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..c4252d46d49d 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern const struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index a9d40456a064..d682a851de58 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 #define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
 
@@ -208,6 +209,11 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_check(NULL, (enum kernel_read_file_id) id);
 }
 
+const struct lsm_id loadpin_lsmid = {
+	.name = "loadpin",
+	.id = LSM_ID_LOADPIN,
+};
+
 static struct security_hook_list loadpin_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -259,7 +265,8 @@ static int __init loadpin_init(void)
 	if (!register_sysctl("kernel/loadpin", loadpin_sysctl_table))
 		pr_notice("sysctl registration failed!\n");
 #endif
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 68d19632aeb7..cd84d8ea1dfb 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -75,6 +76,11 @@ static struct security_hook_list lockdown_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+const struct lsm_id lockdown_lsmid = {
+	.name = "lockdown",
+	.id = LSM_ID_LOCKDOWN,
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +89,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 5be5894aa0ea..f42d5af5ffb0 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <uapi/linux/lsm.h>
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
@@ -261,6 +262,11 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+const struct lsm_id safesetid_lsmid = {
+	.name = "safesetid",
+	.id = LSM_ID_SAFESETID,
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -271,7 +277,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..ea69e83936fc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -513,17 +513,17 @@ static int lsm_append(const char *new, char **result)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-			       const char *lsm)
+			       const struct lsm_id *lsmid)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -532,7 +532,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->name, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -3817,7 +3817,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -3842,7 +3842,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10350534de6d..3ad500dff390 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6944,6 +6945,11 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+const struct lsm_id selinux_lsmid = {
+	.name = "selinux",
+	.id = LSM_ID_SELINUX,
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7264,7 +7270,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 65130a791f57..f73f9a2834eb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4933,6 +4934,11 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 };
 
+const struct lsm_id smack_lsmid = {
+	.name = "smack",
+	.id = LSM_ID_SMACK,
+};
+
 static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -5140,7 +5146,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 25006fddc964..556f8daecb07 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -542,6 +543,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+const struct lsm_id tomoyo_lsmid = {
+	.name = "tomoyo",
+	.id = LSM_ID_TOMOYO,
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -595,7 +601,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 2503cf153d4a..5cdff292fcae 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -18,6 +18,7 @@
 #include <linux/task_work.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <uapi/linux/lsm.h>
 
 #define YAMA_SCOPE_DISABLED	0
 #define YAMA_SCOPE_RELATIONAL	1
@@ -421,6 +422,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+const struct lsm_id yama_lsmid = {
+	.name = "yama",
+	.id = LSM_ID_YAMA,
+};
+
 static struct security_hook_list yama_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -471,7 +477,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.41.0

