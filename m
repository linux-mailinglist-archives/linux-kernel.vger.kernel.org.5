Return-Path: <linux-kernel+bounces-1752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432D815388
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF50C286BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6113B14E;
	Fri, 15 Dec 2023 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XgA2Ul+H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429E13B141
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679085; bh=gM+LsHgIihuJigplOYZBWLpN1B0KNpUXeKsws5Epi88=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XgA2Ul+HkuBJmXYTuZHKX1hJeapIjvKzGgy1If/1zQPoA09oh0IUw7tlw8uGEafQstODmnb2UiJE8++jD78zu/7+w7c1nme8zDx9WdjK5KxSBKd81Pat70qhWDtIjtxDG7NHcAsa64CFjl+FcFefmHbPD9FIU/oFPEXutX7Tq3c9mYe3X0R1vDw6AeKEOpB2Eg7RqhyJChH/wtaq8wVyhu/ezXeYPxzk0rE7E4sLcPUHLAjmk8quJ5hKwj0ojOVcI1tt4m5t2Z2iNbk7TaxZroigqFv/2MpYTCHy4C5+2S0AUz0YLB9dRCI29A7h0SwjFPumA0Grq6m1QnMfHXjlHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679085; bh=sJisvyEaiEIDTvHJoCBm959AQyUp2ajfAaIoeslpkEv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RJdVqm7YtTgRmgYS5OaT3Bryze+oouKK2KdpPldhLKp9cbDdVEDK8bztfNk+MezcYi31bZU409oSrJNmZMuYxugJnW5OGPnO3ASrZzmc6S0CAKU26BadtZ+Ik9Gz01+tZGVfyEkkggmzfXgGjqfkqg+k1JCl7IhOsMREGTU7p7I61Y/vkRqygy5HWKWoYe+RDU7sGDIrJaNE97XR/i+orWnL/R4RoX3dCwj1kIwIw1SYN4CZjDLzVoq0XJw4bz3FlKjPUe1iHHGPdXDBBpAf8xu2UWenE7RVGSN/4+u7GMM4sVVOb7nwXy0ytGFQz3V52vKZRz0WjWxDTvwbpirgtA==
X-YMail-OSG: j48yVbgVM1lH6smcB8G24yK2ZUW8_4Tx.H1cT_wnooEsxERehzA1g23E6RTyf2O
 MDwKYLO2CUnNmWrSxmsuzTkHtI3Mxsc.t01dcVNxm.FWE4c353ZaB1JiW0I3._3u6oaHyCRBM_KN
 UT6_uQAiEeXS3RDJIaFexpxaNITUfrPq2LhrKWJoB4kUDV.oyMkZrhI_w4tdWwpWuY3zVPKiGNFT
 mHmwysM_gvg05lTAzAmMMOwpQI6VjC8LQBS.6JzBx25GurMamU6wOST28Ma7U4.zU2fBF9ZLYhm_
 Wbb84U_Gv9FXwd.f_cPlUuIl4X7CC.KJaRBm1RIj8DlYdk4EcsKS.lMxBPkudmsnvj7tLe10_JRh
 j3jh11y_MEDK4U2FpQJ2fltsSLOUpCVq80yza2RnRA5fD04UkztusJXKnBC7vW9fl90bBTFEybz4
 FUxbuMDQQ_g43vKDIg2iv8h9pRBDB1tKejzCmSn.oLkk6nx7puZpdT11AvAyeqcZK9fYk49QFxdJ
 tViNue4SHIF7GKIOUvtlCWCrQBDprfvFMiqF07YFpkRvhs6J0J0CQsjUepojTDDBGb5RxiyBH2rh
 kQgaijESZmr3kAFbuXRzA.h9VijSzf7M2S4Zzu9ytoHlJoSjLI38yyxhcOKaaNWYVRHtovjJQyFy
 hzbRusjA3zUl5Xk_FbUuHKhok.IReyv8vHM7vEjWwI82I88NNpfTczMbENmH9qGcHjUMynh17kbY
 NTNF9GzDdGU2hP.pijNn3aBifQlUiepdjsWzjf7tO58Wf8iCLnRen3oNQ_oS17JgkEe065IWTs.0
 OJX9BcswXqh8FAd_x5cGKVxsnuHgUntG5Y6qhB7C13l.FrwscKb4CFveymrC2uI3BjHaTbykLIV1
 Eneb2lRBqid_gW7FZaoObm6I6bx8KV.PaKqR6.qTxjbiF6iYfHZOLbchBnfaFuW0xittxSwBLciq
 9utwt6abGB46dM94i7Jwj70lrfs7iDxP2ftg9WlG40pdtURtzq4l8FqnjWzeETPkUVdDs.Up5A0e
 fL_ahGvMeimta9j8hrzf1JUhCbcwa59gL7YWsN.e0VQ2o.fxls_zH4grab6nLJtnSJXPZieCZrqC
 MGtBfa0wiF5DA0SLLO2K5iXCSKzbOZJg6P8LKKMtCozJD3SA.qIrDMuprXEmggNYuorrrV.4nld8
 qvhKamGz_Sd0oipW8iX8rvkBAT3yrmQqEsXu2YziOJvOLnBRnelfqrHqurFiqp3VW3bfQ1S8F8nl
 ZfElLDytX20xedow_VxV7WfCIJkWK3e8iALigBHZWqTnooS3zMo8xXVTKKzMaFrCKpFdTfYoB0qA
 E4kZn1KohYWFKzD9l.eQBAEIaGTfDCc_q.2wXf.1w9FjteF7rPsSjn40NpK5MkRyhYH4fEgrrAnZ
 E5_0Vc_unRUgwQj5RZDoLVaFn9.FkwVpI1TWENKg_sazL_uowz5wACkC1U2L2szbieGdHKs3cISk
 GRw1GiYeFLQzMi8sTJTx7KZEgxTk3OcNouGZwftvlmef_ZONSPC6kXTi3NkjlUnoteNBiKU9FnJJ
 qq_ZGIDTGZFw6L4LUgTk6qWc1tHbdRlonyhr90P3DoXGibsJ8VL78mnlHRw5hn9BV9_VV.xFbyZ.
 aFkrn4ywD1RglF5QODebrwsUFt3Tmf1IGF13KBLSGAay42aHLoNHtfJGSwznD1QFldDqXI3.kCgC
 0dU0aVG6R62E4z2_1UZpX7AuC5.T5hVGqKhmlzR.QGmrl0gtWgSl4DJ6k0vi6lYFKQzWv34QRzWC
 Kn6uHA4kAGKF55MqG1m5H9h..vRaT7dxIhZDLj9ATyU4wtWDlnrossSjMICt7rvqsAgH2zvV472y
 c0ODctFnljLdbviqpo28vHUB0x0BX5bA9iMvH.e39ZRLhxR54uYS2Ks7pEKXjhCqz4Ytzo5YKIBz
 fh3IqH_o1FpVw8Mhm8.9J44xEKN6J.MyZXOySMsrPXu_lKQVizf4QIAt1yJnjIo3.SUIdi3tDU60
 6EfVFLoBCDdHT075LeSBfL9tp_ZTZJDTLo0VzGGTsEH9HyTAKQOdpSwjI3CyowFr55HEIgzabwPQ
 ZRZB10YG_Ex_CB3L_D2eExZ0o4IM90kxR71f7c9x5Mc0U_eIW2pN9UrcBKyBchMd1Zsv.wq8HmFX
 0cGYrsZYG7hV5O7XjDsY.GsFpBreidrfYmqnvjFHpNLo95q8hH2hO1nTNOqE7MjODUPMtJbyPal.
 AQYraiuH8uSlHH1ZHh1y1MS8HQZw9MaVpJT.1tj4fquaZyCZ5mCD8Jk.z75mSFhbrZr6ZUGwAA3d
 kNhaH_yAdZGl8f8cykucwMO9dre9zpho-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 830ae4f8-7df5-44b1-a4f9-bcff6dbf4917
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:24:45 +0000
Received: by hermes--production-gq1-6949d6d8f9-ghhkt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aee9c1d49ff512a4183bc9eedbd8cede;
          Fri, 15 Dec 2023 22:24:40 +0000 (UTC)
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
	linux-integrity@vger.kernel.org,
	audit@vger.kernel.org
Subject: [PATCH v39 11/42] LSM: Use lsmblob in security_inode_getsecid
Date: Fri, 15 Dec 2023 14:16:05 -0800
Message-ID: <20231215221636.105680-12-casey@schaufler-ca.com>
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

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit. Change the name to security_inode_getlsmblob().

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: audit@vger.kernel.org
---
 include/linux/lsm_hook_defs.h       |  3 ++-
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  3 +--
 security/security.c                 | 11 +++++------
 security/selinux/hooks.c            | 15 +++++++++------
 security/smack/smack_lsm.c          | 12 +++++++-----
 7 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2db7320a1e05..3c51ee8e3d6c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -161,7 +161,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
 	 size_t buffer_size)
-LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, inode_getlsmblob, struct inode *inode,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
 LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
 LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
diff --git a/include/linux/security.h b/include/linux/security.h
index 6306e8ab0cf6..e8b7f858de04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -431,7 +431,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getlsmblob(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1020,9 +1020,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getlsmblob(struct inode *inode,
+					     struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7afeae468745..b15e44e56409 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2276,13 +2276,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getlsmblob(inode, &blob);
+	/* stacking scaffolding */
+	name->osid = blob.scaffold.secid;
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 48287b75fe77..8edf7a0ef9f6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -671,8 +671,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			/* stacking scaffolding */
-			security_inode_getsecid(inode, &blob.scaffold.secid);
+			security_inode_getlsmblob(inode, &blob);
 			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule,
diff --git a/security/security.c b/security/security.c
index 58387e1f0c04..ed4e9b5fdf70 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2607,16 +2607,15 @@ int security_inode_listsecurity(struct inode *inode,
 EXPORT_SYMBOL(security_inode_listsecurity);
 
 /**
- * security_inode_getsecid() - Get an inode's secid
+ * security_inode_getlsmblob() - Get an inode's LSM data
  * @inode: inode
- * @secid: secid to return
+ * @blob: lsm specific information to return
  *
- * Get the secid associated with the node.  In case of failure, @secid will be
- * set to zero.
+ * Get the lsm specific information associated with the node.
  */
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	call_void_hook(inode_getlsmblob, inode, blob);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d70000363b7a..4ab923698da9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3496,15 +3496,18 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
+static void selinux_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
-	*secid = isec->sid;
+
+	blob->selinux.secid = isec->sid;
+	/* stacking scaffolding */
+	blob->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	u32 sid;
+	struct lsmblob blob;
 	struct task_security_struct *tsec;
 	struct cred *new_creds = *new;
 
@@ -3516,8 +3519,8 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
 	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
-	selinux_inode_getsecid(d_inode(src), &sid);
-	tsec->create_sid = sid;
+	selinux_inode_getlsmblob(d_inode(src), &blob);
+	tsec->create_sid = blob.selinux.secid;
 	*new = new_creds;
 	return 0;
 }
@@ -7125,7 +7128,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmblob, selinux_inode_getlsmblob),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 	LSM_HOOK_INIT(path_notify, selinux_path_notify),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46cc79eb1200..e6d49e59a0c0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1615,15 +1615,17 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
 }
 
 /**
- * smack_inode_getsecid - Extract inode's security id
+ * smack_inode_getlsmblob - Extract inode's security id
  * @inode: inode to extract the info from
- * @secid: where result will be saved
+ * @blob: where result will be saved
  */
-static void smack_inode_getsecid(struct inode *inode, u32 *secid)
+static void smack_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*secid = skp->smk_secid;
+	blob->smack.skp = skp;
+	/* stacking scaffolding */
+	blob->scaffold.secid = skp->smk_secid;
 }
 
 /*
@@ -5081,7 +5083,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmblob, smack_inode_getlsmblob),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
-- 
2.41.0


