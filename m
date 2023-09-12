Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2879DA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjILVA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjILVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:00:26 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E08F10D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552421; bh=uWToEefsqQdOabIE7w0i3/JycE51obhl4UwYVHpi5Lw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=f9bwYyUq6CIALOPYf+k0vVgUwt7/JOgNvPe9uTlvMuVdIR7GoFkD2iRBf6r3RekYmEP8JcuWiMIYbN0b6cNraEiNxo15k1e37MFot0xsCWy+ZQDOE8/zYXSiyIPw2poRirq4IF+WCFE82EzHrfbyV1JOS5imGsYmYvcZK1FyP/IyrTG88zABOyFJofyRCgIKUXscwfE616mkQ8GxkxCwbuuQvcPLxvnoT9RSUFE/tzzQtVwHCMUbwmA74hQGMxlqn7pdNa7M67KRXutKx1WW+iH3qtBl7srViC0b63e/ycMJBx9nSeuKsUvKiupuNZ9C1amzdN0KGizyapFOtNPn7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552421; bh=5aOd2R+0qtJ0lYNHsRBtwdKx7DFHY0CA5WZH5+rwG2b=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HjvNBIk8OukraxoT5VdFABrTLqAIkOzTyKEUbVRcC2OEQXz9rPMoYGcS7f3bmeu8e6Pk7ZL81OJ+gBLY+584RHv17hMOE/0FkJoVi1dNalFciu6ZTjn4PU7vf2arTNe5PQQQaPccOj49w4XozVF+sWfFHgNQwHqciBjeGXR8GDqmK2op5KXb1+Qhan7z+jXD83V/p6Gy1H1xOQ6vw2qgtAQN9O3OBRSenI37mVYweeuaXi8skQFDzZ1fft2+joJ4uLbdW8Wv/nfEU81cX/18kWkooUAnMqLYKWM1No+MmLYjWtzdsx0XVBisHaS6Gur5EXE+iJSZCZC5pjGRlFAFXg==
X-YMail-OSG: Y1yRUAUVM1n.NkffuF5e07BBkUmSTDwYEbgoqJ57CcPtCdtl.hA.cVxtjdqyMim
 h8.ALQ500rYWG2Ke4PaZf7IcPZ2XvIYIOP7zjPqAyQK17wjF36R7KaEwMf66NIRmH.TCTQuvnOdJ
 lRRceCgeCeYud7vqnK8RYDUIiZCfBolYSHOXoPe9kKOtPYqlETFns9pCjJyg0JQy1cmnDSr4Kd4E
 3JwS9OGdsw3MdmVlDnxzMut8UfiUgplajZJtBTpIXglGDSdSDqBFCHkyh.jk8_jt4dJRI5SEa_wx
 9JOr05m6UYVH9FFrY9qmmHwgmSutyIJwQ.FaThHVS5ni4yw.g3LXkFiFOiYW5RDFkfZTV45mRZ_a
 t_8iPYEtSBv82Zr6tplD.AlUfWQI4t7ONUh9bXa_n_WlWuW8uc1DTtagE05qKv1i6nDQSenmJ.AV
 DcJ_KxirAaZX1WUw1VRAV0LyQ8EJAB_PFOI_zoCO9FAF9R2NxShDpxALpSGNia6NczMMYs5XSLqJ
 4RSNRQ1X.MvswGbAqv2OL1HbKSKznIHWF9Q81zzxAGlS9R03TCcwpkOOVPQHvhIZSbkvq_JH.dCd
 CA99hrT9Uv5kaMtswuMBiC003.xRFHCVldwm7HsjIXBdHTqNGEz4Kkjh4oc2KXE8bs1ZX0PndG5Z
 .wTtMbsjizzZtPp0ZT0JRTBD1OPuPj26mZ5UeisxFLr_NAzbzxlLvilEKXI_YeVzwo2KimJyftNF
 lGVvrFzcKbt0PInarY1mHJ7Mnv9JL2xOY8ReUPsyL6woVc_4_xaq9.eIS6ggvQaB5dOT3GXz4j.C
 KxMSrTDMdssl1wOIBs_OJh1P5_S.BfUM.Lrf3Ts3l8rUPxbyHyXA2LX9e_DcZXjKyoHVcT6_RSdA
 8j4ORFy_eGakUc_dkMxpT0XhKCip7cOo3zD5vms6CIrZkm_uKVjnfKj0jlMJcatMHh_uvvTr04jg
 .vo08DRFJM3LnPUQkKzv_moSyq9bEfv..lsQ8jo5k9yCgkYk9G_1NcXeb19Y9kNzqMjD3_S3onTi
 KIo00zB97OomnqliOtS7eKtP7idPWbpHpFuj1uwYQQkdb2W6T8qxIiC6PVSAEjKSvw74pnAfvfBF
 K1sH.XfSsilbmP31CrDvsa6KkR7Qdnfm5MYWJGUiT2n8bkRMSBfe403kS8S0SJGIJBstEydf355x
 RaIFDU69Q12i8MBHlfaGKBbPvpxHIS0o.HhQXYETVcAB2OoOfnRWwqm_SNuAhM6UtVrm88dtTLlV
 oNGntBei8XXHhrKh90DX_qTbHgk3kOvWE.r5TZDuf2f1aDaJ4NGVjNFBhGuUHK8p6.S3aCBrHzdm
 yH662Uy203d5f3sObWKElC6WqQXG2aWZA_yM6v5tHBFm6Exph2MxgMTJgOFAuFNNZ1DD_BF5Zgje
 rB7uNib22bQEeHWTi.BYPKo1MK5rqmSx1Q7IOK8nlxlImxbSm7du8nuXaaBxjAR7Amahd2kSpaZ5
 Kn6v_lSyIaibb.PmNHLFkLLTiRF1zX.jHdOOMgIlx6hq9S5a3bS0lGyINjDxucgtRORYvvq4DIsM
 ncXabHp7waFPHjn1XfgODeAGwfRKImdDgHeMEm05Fj3byCVZmwS4BvexrAN54PmpP3_B_LMv753I
 lMZRb4eCDr8vEyVz8HiP22uq92ItBnhkI90HLcsBaq_ZpQzh566biJBgtIcGavtdodCnXaAHKohL
 DH6cICIJ1CWIgfDw_2F6h31o5rjZqPbbUmwvd4ADoeDusBeX9Xh59HLFO0FeErjCC4TD7ov5YJvm
 JRM7WYZwQZxDkc2H7Mi3UGbq_HVq8UJoat0NCLSBqRXKoVgjE0cWGGB63RJo5nx93xN1kuqz7hU5
 stE1zTqFTEUHuzZhyZiCBCLNx_TNiMDeBqBE9W1BoXPptqVUHKQ2S2oqhRdxRmRjwFbbiCOLOA6d
 RFwKVAh0TrmzZSEsxPhf5qJaMEDqZaVuu4N36Y0NUF5nIOSgAKdMDZVgQgul7WVIxXJflixltDC4
 mn9oTmsYl1vGYvdhqJfxvkN0RHlrHt0Y61NFa8SCDbE.N.OJ5VonH9UDKBi59_EhTbNTCfEk3hK0
 c8rMObsHfQOFuIH8ePsqp__rb87V.nZCwYrXwC5AoDHdnENq7fdtd9kY44GWEJ4AzoQJSwlJzrR6
 Ohy1q_zSCsGaJZWlFES4y0jergqN5Ytk.tsaY_YhPkhXmfQKRH6by0QBjLRLG_Fxj1qRKNbF..fx
 H.qVq4vQ3WlR7YWF95STBCJIo98gU66DSfT_sbKS5uGlp_9kc6FBc7ksZPSKC2xokGQoNeK4J_Av
 as.iT9T4CNQlON3Y-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 606d9ae2-8ef4-4212-963f-0b7d8b8e0c67
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 21:00:21 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a386478821340d4a39b6ed725da40e04;
          Tue, 12 Sep 2023 21:00:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Tue, 12 Sep 2023 13:56:52 -0700
Message-ID: <20230912205658.3432-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

Both are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h | 14 ++++++++++++++
 security/lsm_syscalls.c  | 24 +++++++++++++++++++++++
 security/security.c      | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8831d7cf0a6b..e567f910a1c2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/lsm.h>
 
 struct linux_binprm;
 struct cred;
@@ -264,6 +265,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -490,6 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -507,6 +511,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
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
@@ -1415,6 +1424,11 @@ static inline int security_locked_down(enum lockdown_reason what)
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
index 329aaca5efc0..5d391b1f7e69 100644
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
index 0d179750d964..9136a4c3b0bc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -771,6 +771,47 @@ static int lsm_superblock_alloc(struct super_block *sb)
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

