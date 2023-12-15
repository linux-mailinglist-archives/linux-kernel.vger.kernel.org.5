Return-Path: <linux-kernel+bounces-1750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48662815384
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B9C28640F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1518EB4;
	Fri, 15 Dec 2023 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DKhPVw4U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC518EC5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678985; bh=3K2HpHNKhJjYC/jlHqs8c4QospmLiwGAijJoid6Lhnc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DKhPVw4UDyUBJVlvdOCbp4QubI/rR98eR1dqQde7ANvmLh1KkmxNjMqzTAhO1tw/ZFV64fXnB9vCHMd2NPL94Dll8OdPOgOsZ5+wZ4nGzhNQ71Oo2xXoD1aBkkn1O/eOHigxp+IeiC6UW3FWKNu5hjWC7dNieXy7cs1ZjrA1vi3lisfv4zEjEjFEu+v319rn+pv595OEedznkehTNmi4QA5AoPnOyzPRdWrEWPZS2Z0oIguG/F1qmglG3HEBVe+AKTCvKvG2OgKBeI7pJlfXxEIfpQMRozLJr+as4jxHzsjYPR0xs6cPf2/QZ2nJiM/hk8mdggwl29j59Mf6YPhdkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678985; bh=MZlb38rYf8W/vHI2h+PHatLwwFEtf+RcJsUCjZNVPSg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UGEnKkw9Wxb1IltArVG+6nPj8eZ3iJn1NlS1mayB9y8lLNKwE/sw+HkhHHTfyAT4OBsZb8s9AGw7oSH7dM2sxP4XzHINCzVK5ERj9ySS+XQBPlhxfIQcLIEkXzXx27dWlSTW9dMJfED0JvpWMvC/y5ZPvGdOSFgS5vThWOEEdWM4vlw71/Fb7H+5yA/MY34JARWPz79BSzBkQRgA/i7ol2Oq4xRmAN/TJT1jbMkbBKpGHF1cUXHlAZNn8P5ZbW0e0roNljIgFwTXnDIwYKL779Vd0Ll2DDFumqTIU/Y6/iiHQt2L6Kf+zq2X5bjjIGhbRTg4jXvBSxLeItCgJ2rxyg==
X-YMail-OSG: MqD1QvEVM1mzRvOFxVeJteBxh.3_0ejux3rZfLw1NuBTZFSCG0SXigzMUQJMboc
 OUVHg1hLd59R97LEs.5KR.eUsCKGFr0BYlMTEl8Acj5mfP4JoNrLgjbC34XZ0q1mNT1oLSC7RJ9V
 dnAqdS8hYP5t6OMYvQFJ7EOJ9oL29wwC3K4vKfOzL5oIZ.WyHtfzPpORDBI9QM3um47BynpPgaPs
 T_rlkZ3QqGx9ngV1VuYzVQ3Ay2lRvySSOXF3dtwk6z1UQH_nLffChyoHzRqJo54y7oe9eU74bRnz
 LJ25Jsu1W_X1pTyOF90D_3t9MfsvyJmQT75IKgrvLhACJXIHt6XYltNdprXtT.GPPFt99XOtsa6N
 iHqFXeKXNaBpZTebUb6Dyae8QFyIjxc0CHq2dl1EcTfhTGmhnP3EyW1qAxSJXaTIRszsIPkKyjda
 51kpT34xH43GHRQ9cAtvvTKK4g83DFNf3YanvKs42ZxgLUCi9qFgmqvYsAsv_HHD17qVvurV3n4o
 Hwmovc4Ngbu3N_LdHB_Ls8KWCc8qMDODDMxdGdOSqR3gQj7hMl1yU3UbXUJ5zi_tTssOv8jdjLdi
 LnGUOyEBGpx5ye3cUTvlShTrwkBkHiWlDtyIb9D5EzbwnvjGA99.FRNaYn_mK1PsgSr5s1EAD1r3
 tNwzMjtjLLyOW1qXtELIb8VrpAv_5_RXdw761kvuliPR.hjbEalLKFAxStLaAZLNeMbmjOhuXjE_
 PJNitrxarnaIgXrvBFsGAeEucedvHtxEKCvmk_whTtCeW4Dk2uJG80xLEvaAdGD8Q.mAPPTlZmhf
 7G29OMa9HHoFqrgtqKD5MJhqUuNSViwhJ3YroD05iuf9nJxkhLJW5zqBrKLlvUEENzRRkJq9z.kG
 KRLGFrtzl1.tVXaHHkNLhG8.nMoADpuSD0ymoo_6_Mt7Bt.6rLMvhr0NKmZOMMRRGPq2Jxv1hMal
 kgELtulFLV3ACpFUL5JDNuYtlEBJsIY7jgR8I9R3xV60uy4F88mgnz2ILSfEWr1V1IgX7Fgu3Quk
 RApobblUPf1YjF.g8cwbuqxR22b.8sHtFhLj9Nvv_qwN_jd9FJ3ZmJVvoVCvcJMcRHwVTV_dqYAp
 3DqIj3SHphJjsHRvCPN2IzfUE26DOzLvdbzkQZ7WJhdGhC1DEZpK06mzB4NiE2CxcWG1t.kDpgME
 0cue3FJYDeM8Q6Hj1QGCNAzRV2.e8_yEVWFF_OyTtNkO0_m7MDY_wjCzCub3ZeVwXZ4nBT.fWjlO
 UCiYJPPsbfmqehehvLLekQt3Pd9W4hKBnBuFSAQcvTauJGmeC9CbJJXYUq1SdNfzQWaQgwuhb4E5
 k9j4v_TrMMt4E7IkOYUhmumtEy87IWPMoXoirfr00zX55RsiytnIomHo2QHYx6mLBhsYYUaru_HK
 3eZA6A_01w.8_7LiGB9ca.87rgF0spMslLBcB4XBLzFPI2mEPp2y6Q8.cuAgFUiJ.UppriKpiBuO
 vxhIIUNqSMHO8R866MfhqgZDzHzLQhP_RuzfhbNXsh500RuFyUdgAAgINRnvA7wMV0GEnI30QjIn
 _MTsRKVjLMiwX1xyuExwjtTHWS4wp_w1ASnTu0xt6etpuv.bolC5yF9TH9Yn9_o_bcbak4.h_b2z
 N109owM.GaAo1APZ5xySnl.v_0cWCAgPl3F4BPYkC1WnFZ.gYknQ6F1NBRlfLk1X5CyKq7J8G0C5
 XONELvaHVWOOKUe2Ef5E8Lt6ZB2KdX858PYpdyzSUvS6RmsVG6polN_09YQlfSgrihrIV2N8gLzj
 qtQmsNtuN5i70.jsi9uRDqivxmATWbIVn6wAsnyiRLrh2dzJ9kZJWeO.Y0Tr5kudaDM8tdaaqROq
 vpyDzP9GY93K9ernnYW7jtqVfEv58V1CBYXo4U3ByyzvsM.dbYKQKFKxoXtVcY6SNTlf5muMuMgM
 EsU7STc.R7yObS820_O8FQBvZAlHi4bB3PpO2SfOFR3kn5PIaZn0yz1AlcCNeSe0ZzJtoDxOTInW
 3Z_i3NNOUkw78ilppG7QujhJL1MD8jeuaTq1zVWAefOrhe88C3n64FUVzsKqlpKV7rkRNLfSxJLj
 ochBEVe8BRXat.9uSD7BnVETt3mPh3or8nt07zFIVAyDs.yaTspJX_3kgBnBSOqxe.D7RMMiF3S5
 DICrfg6Hnhzm8PWdNfGPq1T9F.hHasoeDqVqIIVFfWQR0w0c1ify7LHdBvt9HN_JtlZGRfPXwf1D
 fZ4szefntB0PgfrdjBcjCGQR6.yXuZp7w98Hibjug2gMeivCnDlL13LEGwszQinxpJpO_DmqD3Np
 ANpmaJqSYJJs1YwqjqXZS7KfC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fa0799ff-e34b-4ec5-bfc7-8fc06b8687f9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:23:05 +0000
Received: by hermes--production-gq1-6949d6d8f9-q7525 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7388d6c7a490bc7dfaae35982f4a3b58;
          Fri, 15 Dec 2023 22:23:03 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net,
	linux-audit@redhat.com,
	audit@vger.kernel.org
Subject: [PATCH v39 08/42] LSM: Use lsmblob in security_ipc_getsecid
Date: Fri, 15 Dec 2023 14:16:02 -0800
Message-ID: <20231215221636.105680-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be more than one LSM that provides IPC data for auditing.
Change security_ipc_getsecid() to fill in a lsmblob structure instead
of the u32 secid.  Change the name to security_ipc_getlsmblob() to
reflect the change.  The audit data structure containing the secid
will be updated later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
Cc: audit@vger.kernel.org
---
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      | 18 +++++++++++++++---
 kernel/auditsc.c              |  3 +--
 security/security.c           | 14 +++++++-------
 security/selinux/hooks.c      |  9 ++++++---
 security/smack/smack_lsm.c    | 17 ++++++++++-------
 6 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 52d090d1957c..d69332031270 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -234,8 +234,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
 LSM_HOOK(int, 0, userns_create, const struct cred *cred)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
-	 u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
 LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
 LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
diff --git a/include/linux/security.h b/include/linux/security.h
index 029cf071148b..2ca118960234 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -289,6 +289,17 @@ static inline bool lsmblob_is_set(struct lsmblob *blob)
 	return !!memcmp(blob, &empty, sizeof(*blob));
 }
 
+/**
+ * lsmblob_init - initialize a lsmblob structure
+ * @blob: Pointer to the data to initialize
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob)
+{
+	memset(blob, 0, sizeof(*blob));
+}
+
 #ifdef CONFIG_SECURITY
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
@@ -487,7 +498,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1299,9 +1310,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 52b4697d938c..89d490db0494 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2638,8 +2638,7 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	/* stacking scaffolding */
-	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
+	security_ipc_getlsmblob(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 4b78bface040..b82245d55f66 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3595,17 +3595,17 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 }
 
 /**
- * security_ipc_getsecid() - Get the sysv ipc object's secid
+ * security_ipc_getlsmblob() - Get the sysv ipc object LSM data
  * @ipcp: ipc permission structure
- * @secid: secid pointer
+ * @blob: pointer to lsm information
  *
- * Get the secid associated with the ipc object.  In case of failure, @secid
- * will be set to zero.
+ * Get the lsm information associated with the ipc object.
  */
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+
+void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	lsmblob_init(blob);
+	call_void_hook(ipc_getlsmblob, ipcp, blob);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 83ce496e8ef6..f15991ef6ca8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6266,10 +6266,13 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return ipc_has_perm(ipcp, av);
 }
 
-static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
+				   struct lsmblob *blob)
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
-	*secid = isec->sid;
+	blob->selinux.secid = isec->sid;
+	/* stacking scaffolding */
+	blob->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -7165,7 +7168,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmblob, selinux_ipc_getlsmblob),
 
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a4ace6ea2ab0..b00f4f44f9c5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3396,16 +3396,19 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 }
 
 /**
- * smack_ipc_getsecid - Extract smack security id
+ * smack_ipc_getlsmblob - Extract smack security data
  * @ipp: the object permissions
- * @secid: where result will be saved
+ * @blob: where result will be saved
  */
-static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
+static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
+				 struct lsmblob *blob)
 {
-	struct smack_known **blob = smack_ipc(ipp);
-	struct smack_known *iskp = *blob;
+	struct smack_known **iskpp = smack_ipc(ipp);
+	struct smack_known *iskp = *iskpp;
 
-	*secid = iskp->smk_secid;
+	blob->smack.skp = iskp;
+	/* stacking scaffolding */
+	blob->scaffold.secid = iskp->smk_secid;
 }
 
 /**
@@ -5109,7 +5112,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmblob, smack_ipc_getlsmblob),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
 
-- 
2.41.0


