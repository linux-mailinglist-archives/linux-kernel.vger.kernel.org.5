Return-Path: <linux-kernel+bounces-1786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E78153EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81F8B218CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD21DDC5;
	Fri, 15 Dec 2023 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YzD++rAj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248018EAF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680318; bh=q3GJ/ydywQ11Q5gXfImcpvZcBSkSEwJUqRpdOx0312E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YzD++rAj8fArr7vAm3sUyJzrrVF5efT4glTlRY5IEtN53Zs4ke6gxeviycRQpUmGeAklERslAvjX58JjrC/kxDwAexz3n8+Pi0Fa610dFiH/8hBHcJdbMrHbzQbqhCtaJxL1AzXX5zVAP+fZB0fbhz+iJUPsAOSTy+jFbPMwWkFBwcjVpJcN94bf9wypi6a7z4ShuXGyAKrtr1uHVRy4CEaF8Ik8oxJqU3fqvSPTl3cu6EaJI4TKBPwM6+l0JXMLTjv7+iz6kQQVG/T7MrUPuz1tbBBrG4mPT6VN5/2t+0T3ALU7kW/bMiNn8xg0shkm6qz4ZvWvZymXEEa5cO64dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680318; bh=i1KpasmTOcn/CQBphNgw9BBsygmY8VTXE4TE39k8yrT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GTMql7sQEvQ8xLUTvU0eT/0J7FfiNKQh92IhpDHzw+ksYjSffS1i/iagqrofRVjlpSAnqwCvssVG0+jyKNQT9f4g+1qyOmjrXc/w/tyPIMGre4tQX2wLdP4WHYg9kfAeNJ+w8oAwulmobr8YlsbGcldfJIEPBgOmtXYYpvRpNqksM5Q6GV+6xNBOt8GkBVYx8UjLxgjSgYHgUI9ZoqEk4Tc+q5Y2CJ6EqjlkjqXgY6ww5+dgERRNNhCNPLeTb43ylVIZsJ7OmlDKPHJbTprXUTNiVT9COmjJGT6+2Hzwp30qifYsBu7irR/xgivG5yeZsDg+X5Powzbs85pgLcZf6g==
X-YMail-OSG: zQGojZEVM1lOimhzZ77u0GJgPwUZNXqifFQcTrR.mIl.ET36DXntMDVhXmW9GB2
 I.dPndgvFEOCfLjT3tkxg1_j1bq7I0ACuGOVGleKeUrp_L7BHd0jrbC2ye4P47oKBjiiDw61KY_Z
 PGH4W35tEyGgT6ZG2R0qoPiU8.AKRJt1hR6C0X8JyIe_ry2WBXlKj9tJkPA8Db2sK6kva2Pr0hDw
 ttkfcIh.pbnoIl65bRCC.CcRGMFHxw0X_i3w6t0f5aeJx3NKGCV6m.ihDalxI6FbXq.KgYbgvIoT
 4AhpdPOjc21Bqgib1EEoDkiriszXQ.4VHhV67kYS.eP9UsqRLVuHI3G7ZFierm321JvaOXh0PerV
 Qi.PL9xlKn4jwE3mvri4t_LOMDDC2gWD8WXHt4rvqckBVp5Mk4U6gygj_ATz.KqQIhJavc5518uX
 3xsRQgF.YUcaTxQoT9Wq6WK37jLwpZlPpI6r04osJHlLHdpTjLuSfzSdYuTBz4WQO5kQsda9rSo2
 9pH4LW091LVEcAiFI5S6rrfS1lnrr5gdriRp_oDSnDdjQcSyK2zXgEHw5mm4ODX1NrGRirG6q7ab
 WeIRPctUnQ3dKW0elC2ocmp5it._5Yb.Na2sLbfOS8GXRjanypXs_hw32qEpIjIxQhTwSzFk5XJ2
 ffWQp8atdpnA0gd39br5MhNHoc26KVGLF7ahPDh4yzKZaYi1aWUioWF.rOF17XKwC3xU1jSfZ79b
 .rRMoIvQYuIaca8cd91wmrbqDB1EGquy27YxoPo6hF4S_gTw9.xAYNVMRZOQGkBZSAsLemA8lQ4c
 lt7CJnW4HMv4NoMKaevSOr4zZDPvuTRtO2JBiOw_cBOc7ytnLWTgr5aKoGO.VgMHG_iW8na3d9RS
 Cu4f1kgqJztOcVnXb.LKGZNzp_Dn_O0qH33ksvqSdgH7wp0H_qbyKDweOQxpw3VFMjuE8oVuY2OD
 qAMnXo8rIS.Rhhn73BG9RhV0ibPw0M5ozbiKOlYrvtIvcry7mjS7W2kik7OU5cKfq611x0nKDgu9
 ZQifOEg9R1FQlJEratdrafbBLT1u606RO5v_MlJvIgLwWM77Zsexb25AJWdb0Mje53CWNfN9JbhH
 mvQ1cxsQHgA5lcIvNisMhbN.3rfPkcte.EavWgpdk3.7cVGkvGfgcR80.uwPTS7XKDHeiEqag35A
 zkMuGBCsnSg8k21FQz30ADcWemAm2MaygWtmsygwjB.zejndI2aK5WPPyHyqHIUYsWYz4ghkofXT
 sAjJPSgVpc2kyFpFiDK9uvH.cmahwMvzb2h3KT9ljtkUqQHM.ErPHf1TQp8CZf._9IuiBl9tkcF_
 KXsgQRS7rntzsUqc6AJ6X0ljD5EjbGgzRXLtmE9cqKHOtTkLFl9tzGVFFUDegLmC9nxPDWiIkBVJ
 xQ5lnHLnF9nmzHTSNUQL.p2Q1QgWTeWYCUvSM8lEvP5Jw.CZD7p4I6KLWnQUT0jJztHwTn0dqOjv
 0zf5NW0n11iChZ1KzbMRsrLYR5JLne46T0o4.g3FExlxvZbfCpIL.32QoqM3hyiXR5N3z_Zjc2Jh
 CFKwb8pJSqX.W4lHgHeSbAGWTiIYsnH65Wi2RVve3LAkzFqYI9Y__7KBH_rL64_magtdWxCFV4PK
 bRmXyJ8RAc9.8vHn_jbgAJFe6Zf7zXap.eEMelyInJgyXFQuljjx0s03ImOZwdS8_jbnoQm.VkQc
 CktLT6VmZEwU7f5bB_Lz7rpSoUZL46eoLrOEiz64AxDFHYZ23gFImw_bjT8b4zOJxjKfvLRqVVCs
 eniCBffuUMAd_khNXhFeXPKUym7WZ1CerTXcy3zPmSCLdlWefXyGWDYeulXqdWEnW4y87Xl64X52
 1dqiH8buFM2T1iOxmBfl3A.ud7bOmmkMS.pHey8jihFokbHClIuRKtLa.Ak9SCUp78Q7CKw.BaRf
 XDmXJOtgaseYPd40ie202fZwosa_d3c716cQGxyG2auDSv8shS_je_Jz3HlOSLCRNtHm479XNHoa
 MG57mhqojYeLuEbV0TlurzhPxonTzsZl_4NX6.k2GXkoQGgz5FODdf8LHpPS4nSSxd6BByGucDF1
 u5rK4UUF_RppfLlrJ8Mn51VPpX4GbieKmCxMFhOE8MimQu19UHR967IMo0iFVPlPkt8UsuyE8iNP
 5s1Dc.sU64bxtHdz0weUTV76sA71sGqb951wQIN4Kq.xwQ648j3j2EKPh3n0fujPsDbhdMOAy7E0
 sDaMj0sE_FMOh43wN456btf1wcA6FxG5OvGdyLx.60oBvmqRTyo8wSYPOnihSDkjoI3QqhM5Mf1k
 _BA_5ONGaDFDcSuRp5teCLjiBWRLeUA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d9c7d73f-dd58-4f27-ba34-839cdfadde7f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:45:18 +0000
Received: by hermes--production-gq1-6949d6d8f9-hnk4w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eb823cd57ae610622380a59672438916;
          Fri, 15 Dec 2023 22:45:13 +0000 (UTC)
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
	mic@digikod.net
Subject: [PATCH v39 36/42] LSM: Infrastructure management of the key security blob
Date: Fri, 15 Dec 2023 14:16:30 -0800
Message-ID: <20231215221636.105680-37-casey@schaufler-ca.com>
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

Move management of the key->security blob out of the
individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 41 +++++++++++++++++++++++++++++--
 security/selinux/hooks.c          | 23 +++++------------
 security/selinux/include/objsec.h |  7 ++++++
 security/smack/smack.h            |  7 ++++++
 security/smack/smack_lsm.c        | 33 +++++++++++--------------
 6 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 24a0f62ec2ac..fdeffa0c8d13 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -78,6 +78,7 @@ struct lsm_blob_sizes {
 	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
+	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
diff --git a/security/security.c b/security/security.c
index 7a9fbe706525..092752666fb6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -226,6 +226,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
+#endif
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -449,6 +452,9 @@ static void __init ordered_lsm_init(void)
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -768,6 +774,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
 	return 0;
 }
 
+#ifdef CONFIG_KEYS
+/**
+ * lsm_key_alloc - allocate a composite key blob
+ * @key: the key that needs a blob
+ *
+ * Allocate the key blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_key_alloc(struct key *key)
+{
+	if (blob_sizes.lbs_key == 0) {
+		key->security = NULL;
+		return 0;
+	}
+
+	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
+	if (key->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+#endif /* CONFIG_KEYS */
+
 /**
  * lsm_msg_msg_alloc - allocate a composite msg_msg blob
  * @mp: the msg_msg that needs a blob
@@ -5390,7 +5419,14 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, 0, key, cred, flags);
+	int rc = lsm_key_alloc(key);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(key_alloc, 0, key, cred, flags);
+	if (unlikely(rc))
+		security_key_free(key);
+	return rc;
 }
 
 /**
@@ -5401,7 +5437,8 @@ int security_key_alloc(struct key *key, const struct cred *cred,
  */
 void security_key_free(struct key *key)
 {
-	call_void_hook(key_free, key);
+	kfree(key->security);
+	key->security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3d046c9d0121..a9af3c848a16 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6672,11 +6672,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
 	const struct task_security_struct *tsec;
-	struct key_security_struct *ksec;
-
-	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
-	if (!ksec)
-		return -ENOMEM;
+	struct key_security_struct *ksec = selinux_key(k);
 
 	tsec = selinux_cred(cred);
 	if (tsec->keycreate_sid)
@@ -6684,18 +6680,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	else
 		ksec->sid = tsec->sid;
 
-	k->security = ksec;
 	return 0;
 }
 
-static void selinux_key_free(struct key *k)
-{
-	struct key_security_struct *ksec = k->security;
-
-	k->security = NULL;
-	kfree(ksec);
-}
-
 static int selinux_key_permission(key_ref_t key_ref,
 				  const struct cred *cred,
 				  enum key_need_perm need_perm)
@@ -6736,14 +6723,14 @@ static int selinux_key_permission(key_ref_t key_ref,
 
 	sid = cred_sid(cred);
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = selinux_key(key);
 
 	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = selinux_key(key);
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -6970,6 +6957,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct key_security_struct),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
@@ -7310,7 +7300,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #endif
 
 #ifdef CONFIG_KEYS
-	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #ifdef CONFIG_KEY_NOTIFICATIONS
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ca12d4d7cfc6..a76d39528262 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -194,6 +194,13 @@ static inline struct superblock_security_struct *selinux_superblock(
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct key_security_struct *selinux_key(const struct key *key)
+{
+	return key->security + selinux_blob_sizes.lbs_key;
+}
+#endif /* CONFIG_KEYS */
+
 static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 {
 	return sock->sk_security + selinux_blob_sizes.lbs_sock;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 0f5bc5c03b9e..85ec8141fe70 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -360,6 +360,13 @@ static inline struct socket_smack *smack_sock(const struct sock *sock)
 	return sock->sk_security + smack_blob_sizes.lbs_sock;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct smack_known **smack_key(const struct key *key)
+{
+	return key->security + smack_blob_sizes.lbs_key;
+}
+#endif /* CONFIG_KEYS */
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 97ffb07797e9..b273e94028bb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4486,23 +4486,13 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
+	struct smack_known **blob = smack_key(key);
 	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
-	key->security = skp;
+	*blob = skp;
 	return 0;
 }
 
-/**
- * smack_key_free - Clear the key security blob
- * @key: the object
- *
- * Clear the blob pointer
- */
-static void smack_key_free(struct key *key)
-{
-	key->security = NULL;
-}
-
 /**
  * smack_key_permission - Smack access on a key
  * @key_ref: gets to the object
@@ -4516,6 +4506,8 @@ static int smack_key_permission(key_ref_t key_ref,
 				const struct cred *cred,
 				enum key_need_perm need_perm)
 {
+	struct smack_known **blob;
+	struct smack_known *skp;
 	struct key *keyp;
 	struct smk_audit_info ad;
 	struct smack_known *tkp = smk_of_task(smack_cred(cred));
@@ -4553,7 +4545,9 @@ static int smack_key_permission(key_ref_t key_ref,
 	 * If the key hasn't been initialized give it access so that
 	 * it may do so.
 	 */
-	if (keyp->security == NULL)
+	blob = smack_key(keyp);
+	skp = *blob;
+	if (skp == NULL)
 		return 0;
 	/*
 	 * This should not occur
@@ -4569,8 +4563,8 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	rc = smk_access(tkp, keyp->security, request, &ad);
-	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
+	rc = smk_access(tkp, skp, request, &ad);
+	rc = smk_bu_note("key access", tkp, skp, request, rc);
 	return rc;
 }
 
@@ -4585,11 +4579,12 @@ static int smack_key_permission(key_ref_t key_ref,
  */
 static int smack_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct smack_known *skp = key->security;
+	struct smack_known **blob = smack_key(key);
+	struct smack_known *skp = *blob;
 	size_t length;
 	char *copy;
 
-	if (key->security == NULL) {
+	if (skp == NULL) {
 		*_buffer = NULL;
 		return 0;
 	}
@@ -5060,6 +5055,9 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct smack_known *),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
@@ -5199,7 +5197,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
  /* key management security hooks */
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
-	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
 #ifdef CONFIG_KEY_NOTIFICATIONS
-- 
2.41.0


