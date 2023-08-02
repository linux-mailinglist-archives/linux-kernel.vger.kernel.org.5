Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8576D5F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjHBRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjHBRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:48:18 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702BC30C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998481; bh=Bqvmvro4aAZS2a+tdLb2NZiYYDGjE4eh/yVeJTod7Ck=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LufJ1UnZzKL//NvLgIYAlaSrkAnt9MZhXKzoYo0RhQiG85ed82Bx/RJSKZwdkO30rHkdymvkqzUShTBVlqXC+5jKvmjKt8+3AmvNW9WHlRxRxb7SmnmKBBY/ctgfZwG4Tv2BiTqhRkG/vPzHzD0RmolRKaHsVezomSAllyxmLNTKbAuWeRpxDSn7N4rQ4GSgrUPc/4ms/4OGMglL+akTFZxECmxmpp3PsFhHNqEudg5T2JZV0t1AqpGQgTOyFubtr0l7BfMKFI6g+c2vHNj5LRaVtPOfS7WUHUu0fimihnEPk+y/aVlPj9Y1bIXgYQuflXF0ZO3+XXKB0P2imJsOUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998481; bh=lUZEcSqoqsO3WJh39E6Hb3StZmsVIETByHfyb1nqeWG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=exP97waVpyBY8RbhqUlKuQ9X6w8abrKe7cAX/ByLPohED5tvBavIgbYSIRAL4VOqzpzuj7tbHv1M6tfZrTOD1bJYK/RfCgInQqV0FSCkDINyAUEt76DG6JDwsQyTcC0B12FnLFVaeKjGz6WFaOD6YT2BHSyXnKF7679wLYJcl89S5XYSf8p1+Aihm5sg+1VTkdeEMl33pdh7iT3Fj0H5ha+inLjURBPi09se2jEgDTbTagJ+Nc5aKxH8WV0YfcA+x4ijBGBblqdyjeJPHAeXIPyf0WftR1Y+iBi+V9sF1S5UgsGpog35RuzltXcYS/sVtJ8vMTFdGTqy4VL9wqZZog==
X-YMail-OSG: vFXWvg0VM1nRViHeKmrmN.eoSiakjOo6_aM5h4nh2m6SbNtiuGDSMApJK4LtnrF
 sZgd_aDQltT1atpYzePTdH44BTVeHpnktfQNGNxW35bn82AoNhAgP2aO_ZpVJnSkXtpFXmT2QwMA
 i7eCjxEFybEQgHzGsru_Kghfg4bkLOl4j.MaQobXhkvIrQrcOcjNYj3GRfyfMWWFr3vFBxNrR7LM
 BQwtfXtGwddbH8d1U238i25lu9sj_72OATprfbH6doZ6xU5gQqZFMB2P4SNTSull.IMY1li6mwzo
 Wf4NxDPNKXjCXeH9cGat9QVTULA5CliC9O0TCesBUBJGM6MR2sCKxvXsM49f0dIl78fpR4aY75Xn
 VvpHVFC_33ujnJTbIbjEYhAhr2DghcS4wt5.KknYd1u2afIub7q.TO9OMu6Q2_P6MzhDEJiZdKfa
 FsJlFfcrTsTwkNq191XZd6flyfmbrWzkG2on4qGS_3xGM70cnJ0dx6Mis6tKOQV6VMFID6u.ZHmb
 uSH0xgf_H5gOYVR7PsaDprr.rOEgmy_TNZ8azLaRHF3CCMis0pD_Avifc4H4PnKL4DmeFkKY6v_v
 FEcL_sBSyQqFufK2Nf_6J7rt2UX4taVU7DhNE8TcAvjBFXDz_Td96fX_vLR0xi42Y7N3tUBMNhA1
 uvyNzZQC5SyDn7evljpfDnWABtjeSR1vrL2VdNPuQP3ehEdkGEUQSuDX8XSr0WHICszKh_X4_GsF
 IYigJuqG_ISwoYsqO2F5_JeR53_w78Y2z35IrCdMsk1pRakt4uwX9U4t.nFf0IVXF.A1hg4GIHLr
 zstjViVqc69E6UfLclQKZZLWkeujHxAygpVnccWs39hoakwRhXH1xYzNqq3L.AURRjU3KD6iMNrn
 v53B_m.7uOoY1A.CdZXSO9tnFLxnTexViBC4.V1zqoTxIhFS4urbm6x5uxLP0dG8tiO0Q8FuHPHH
 dO6oSkG6OkJrvauTts._FHI73dHK5SueApFVQHkNqBoqPTXM5wshDvUA6E46Qe43makw1TooT8tL
 mecBdbJk3Ww7zWKSQiSqb2Pn2wMr0OUVU0Mg.AuttWnLwhn1m_CCcJx24A0fNGXLZCW6w6q5zxpv
 HvbU9FN42AzsZiKg7Fyi4LvE1IzcmBobOhJtGW3Uf93TimyQ2M9OS0fvgYBV61o3WowgRv4d3CfF
 jzvj_5bS3e1zS.JBJDPto4DjJ9Xjq6eB8wUUgvexfNzc77NWfHi_jICt08dDAztvjQPsjikZTTGp
 53cLdQsqmX_VxlqkrY3mHxc9sOxwDWjRtMIQnrb3LN1qBAuqEFPZgQGsyLopLN_U5bJayt3hKQs_
 aL89_ysE66L22zaAhV4XyomgiliTVeEHk32D5D6ipfqLfy7hwQZLiXOCTAefZ2CjhfeCu7U8__s8
 a5_2qRLeqdgLcVQlIRx2Z7yWg7Jdv1.FO7nN9.YpMdDYXA_dEcbyNQo.VH4XvL8VaBMfP_HCyAx_
 4g2VFnYWirspv.5S3doyjBEhS8LOMYn3LOY_lBruaj29QbkX5n8C1tgVcZvfpLccFaQkg8rC6M0j
 2pHF4dpT5.N0RcofvYHIZQIs7lZ7FpTwgA_01gj3o_Epcu6tgV0hi2Og6vqSu.fluCg6JyZYQSFl
 iw8Winvdwk0HD.sE6XZxInpdECSougdCnTd_yZ7oxo8LSNn_4dwcuzq8jmR6vTTX3hHy8DdVN8Mb
 oCWgvfpv51Kq0RGeLeZYhzSa5BekPvvjxyatTfN0fZsfeflyA7CwPvx7KapILHMniwFyEa24_qkl
 kGD4ZVDVYmEkCrsmFHjK6Wi5mU2fCK6P9e27mUrAVi8lc6Q1j2G3jmvE7Mag4iP3qvsKDsIChJNl
 hQpgPQxm3LBaMrQiCYE1th1e4ELN1663lG9Kgo0XeI_NdoFDzp2oyD84T0mlZ3_ospsHWa3lKYr0
 Wq1agwMI5lK8AmxHa0TXMIO2OuwJf9F70NVX6Q1TThyv3De4hJL0FeqL6rv1VVAn25K.W4KMfDy_
 iNpYgGwVGXuNkAzUx5_RPzmchDhkCQKFo1.oy4J8LvhsekAHsV0k0z9nIWoYsVjR0kbKFBLPVb5r
 UN8jlEY.e0fWTWdEeiLJlBpqL_qsfLOyjD1Sz8FJl5v.E8Silj1Ez.slrFl3vY0SwHZhBn_Y7RPb
 tjZg1bFaz.qb9l_mhxOcY3_wS32iB4gFZhiexgPfgpAVbMGv74tc8j9rPhSs.9DFzI7s_xMZTld5
 PRUeCdYRKO0Ye14TdzKe6elMQ1hmw5hrNM7GFHtseQa4AxRbT5pTZWNcvyRDjJpHlbIgcDHwZhVj
 lkBn2Ts7U6WH1jgQW
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6165fa16-f8ce-4019-927b-f4d96006686c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:48:01 +0000
Received: by hermes--production-gq1-7d844d8954-t8s9w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9cf20a3b1a5c807479089b2cf544b53b;
          Wed, 02 Aug 2023 17:47:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Wed,  2 Aug 2023 10:44:30 -0700
Message-ID: <20230802174435.11928-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

Both are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h | 14 ++++++++++++++
 security/lsm_syscalls.c  | 24 +++++++++++++++++++++++
 security/security.c      | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 0d882cb221f4..817cf28dbf8a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/lsm.h>
 
 struct linux_binprm;
 struct cred;
@@ -263,6 +264,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -488,6 +490,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -505,6 +509,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return LSM_ATTR_UNDEF;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1408,6 +1417,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index f03f2d17ab49..bc22f05e2d8c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,30 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	if (!strcmp(name, "current"))
+		return LSM_ATTR_CURRENT;
+	if (!strcmp(name, "exec"))
+		return LSM_ATTR_EXEC;
+	if (!strcmp(name, "fscreate"))
+		return LSM_ATTR_FSCREATE;
+	if (!strcmp(name, "keycreate"))
+		return LSM_ATTR_KEYCREATE;
+	if (!strcmp(name, "prev"))
+		return LSM_ATTR_PREV;
+	if (!strcmp(name, "sockcreate"))
+		return LSM_ATTR_SOCKCREATE;
+	return LSM_ATTR_UNDEF;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index cde7f3a13e7c..f1038686ebd0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -770,6 +770,47 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
+ * @ctx: an LSM context to be filled
+ * @context: the new context value
+ * @context_size: the size of the new context value
+ * @id: LSM id
+ * @flags: LSM defined flags
+ *
+ * Fill all of the fields in a user space lsm_ctx structure.
+ * Caller is assumed to have verified that @ctx has enough space
+ * for @context.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
+ * if memory can't be allocated.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen = struct_size(lctx, ctx, context_size);
+	int rc = 0;
+
+	lctx = kzalloc(locallen, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	lctx->id = id;
+	lctx->flags = flags;
+	lctx->ctx_len = context_size;
+	lctx->len = locallen;
+
+	memcpy(lctx->ctx, context, context_size);
+
+	if (copy_to_user(ctx, lctx, locallen))
+		rc = -EFAULT;
+
+	kfree(lctx);
+
+	return rc;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.41.0

