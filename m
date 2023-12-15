Return-Path: <linux-kernel+bounces-1785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14C8153E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529F5282DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F018EC5;
	Fri, 15 Dec 2023 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VWDM4zzk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33018EAC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680318; bh=IGboAo7eFziof5CfECIvA248+i4VKISGr6D9poWTQsA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VWDM4zzksd2Gf64oGlAl9GHtZ2JQI6d90bHMM+8qij0+NP6oVfwH16B8ny6HMDXZzJ6uzCochV71t1KI7AoacBPJJXyFzsnU4CyBrsyt1Y6oLOHyc/zzMFiOdrlpPqv66iA1rifHOSzNXiddorxEPtduq2aLgjQ+6R9XYiN5L/B7CALOAkRuboTUaeL4KwkIrm+PjO6bQZNVf5oewsIPGiMX/KCJONmBckgQysbZ2ftoXpwbU+CesVn7f0RLj5N4bQJfYBEL0QnaX7dcYsAs6QDElZCxu6vsfRosjzRV3112LEB9WG+bIfxazbUKiGU4wRaBohAYxL46jjEsLnqoxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680318; bh=i3Q4Jv+BeKcP5htciuGw83/sHswM3vBj2rN3B5mr+3H=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e8cZ/c1DPSn3vpbPKcadJs4krgNz/pSkRdS45rRVJ5t8FM9mIzOmUQ6wnxlxdi0NcWs9OuxMcMmha73WsZ19gzTQ5gCxBw5vhxO+pcO3DuhBOO7YIttxrmj7hTwexTsgTXTo1JG6c4XLUSOq6Qh8PAQPvvibjzFIlB5IkOYjIChfs0dLBW1pHaralVUuxxUWg21+X53sGuRYbIFsOr9eUsejrnKg8bh4eDZh4zEybsmZ8XHVPjRlelwRGyfg3N3dTjrkIEFIE8jzSsO8ho40vsrZD1RxlTLem7te5PsB01sO52p1RSrguLi/zb4KiAamDUUG2MkcNsDprndpgaFPLg==
X-YMail-OSG: qOGcv2YVM1kUlpfgd5gHgw_uNj77p8Lb4lXB7D1yMO_dFeRQop3gfAL4iUW_Hpz
 yc1YhKztk27TMdZIPlMk_b1U0VvRGnUs_I_E7z.dwq391cxxHAX5RLKFVJcALN5RiDQagySEeYcF
 b1Z3aWbiTM1.h7vhu0oT9.YN1k9soFgx8JFCG4o.DrMcI7OJUy6OZsMyViKAijFSMx.uc3kgCbjG
 svS2wD_.Zbcf.yiikY7y5HKDz0itMomDdVICMCgaR5SzkoKH1ziSv5hmv.4uUcnsxIYcjIK2P6Fj
 C6sSXl9JNoHsacyZs8HhfzG4XC.CfvMthSE82Mu0gP4nE6ECx9RDO_ykD9f8WCyTjn5K5xOMTFqp
 xIpufTfC7SOIPbeJEuq0HpgCsSVe.94ztLdzr5rZqg8WWjTv4C.AYhWOwbB14Dqe4HkRDakdNWXh
 HYSZ0XipgcUrWq20N89ThRTo3urp_3e7K599MQFMtYe6B456osPVjoSTITeOtc5i7Sx3dwOE6Bxg
 mlBdaQA37JLWi32_QdXXQqOyDP4FspCs4Phsv555n3T57i_j2Qc6Hv8FSzdQVLnAlgK_u4FlLY25
 0bYaKUAsvx1i3Dg1LBH6zBNC.gJno0aIbBcc2xcTtLTqJgmBGrPIyBlmNd7kbbjOh.IAqZViZQNh
 BXz_87IeQsXJ83HXxB0p0xuu6MORsJeZVqY_TTSALxcT5QFRP92qirSiLI_z678mQ2UWi05pnP11
 rWmCZow0LrAPYthNe0wO0Ghyw8BH3WLITuz.DWy8kfN_zRrhoZZDPd4zmSNbZZfiQStTf7MhHUE6
 WDV2fcd7SE8W7OazYv7r2YlIY.8Qa3ecWwumODOgRgthuyO8RBsHaFA_Q3VQMSPg5Uff_X0KGax3
 YALih6PW0XAB_PHIy0Aps8CDsMeyeQqHe0Vr6FfrRrX0wP9aKYwTwjTAulbwfYQ5fKOFxdadBl2s
 9kGQiT7VFKQCGnh2NXeV.Sl8.fyVn8TQWdewPCKUypJJZy3dDuDsLAgG01O1Sg7xzAthlgl6bWF2
 I2orI959sI1AFnjqsJni2gKp6Nt7Y0TTnJ71DLmIaBNZusrGWKQ.eKXw1ELbgGmhhNypx7NYGmah
 JUPQPj_E6fA9br6VaZ5L4fktcycVyCFiXL_XMo1V672nwnvp42oMTu3rAScznSRwLimAQwk22cgo
 DUyzLRhYvlW8SAwR.7_9lfL_bSTDWFN2trSm9Ln1sAjE5V49RwZlHfFXO_ML0.7MFMc82uP.aR8H
 YtMeoAVn.mKFRspoYiY8hX.BpptUKvssJ4H.jQxN0cU6p3zXHMvFhMzoDiO9dbyzh1AGebqiBWwM
 j6yImSZ9VMgiORtNycLXQOUaONpNQePSrUumAXFzZQrgoqVNWRjifAMdwwzNr4NG3EAhiSmF72TI
 TFnt9Pfo52rC7LwopB6Voesga3c9pNCYTFak71xFF7XzrYZwKkpnLLO1A9k1_GJibHgPoMt62gN3
 G2YPlNRbQAlt..xwiNTsPNpru40tc7BiDLda08_cfvGLyiI1Guzp0Bp4va4vr5cT3gNoR2.pOz9x
 mnuGHXgja3pUArBOpoVOCQFmM0yH40i0ggIsizS7jUSpd36PCkirW4dnQeBLoBrPAZUL25hkFUjL
 kz69.jdUJ1A2ybonaOOX4cdQhOgPs.sZWFBeSnzR4DSkhkZy95hL4chcTLMFRrPX_Ra_Wu25.Unp
 YemGSRqw4.7kSAJn63qxXFfyLeEwQv0agcA9ZbId3ki6KP9lYWGvOrd4pTz2wTf7VvyuGFe9v6oy
 Myf76xB_LjiX7B8ny5tkhTKJQZTg1ukYPEmSgIZLCoPICCs.rKXUAsxRDzgFkV0CDQMx9DHfPE4K
 jYuI8JsazhJrwb7ZSt5VL3SkRbSsqEflumNrhrlMl8HqdK5BBK.BEExD18s6mXFKAeKiM66.ue7c
 lrTHvW5xxEfaZRpaDKkvJ4vAltFhwshrItvpJkezOkA4AAFhztF_SoVyEIRY5q_hRqCJSOT6tS7C
 97b62co3fQx4cEqfbSuduIOAGwN0jDEJhpvhUrZ.AOIqaRuptGLgDJaBM0CJxXYV14v.BjRyrQmd
 ZEpGylD9._93csowidlPVRctilG3HAf9wIJermoRaBpUiIN_l3hUH8KOXu8U_Id7ojiF9C4ncm9S
 CmykhQ3LzcY1DDDUaE34TeX8jsNG8WdxxoPyON1UgrKncM.7ddewvuCvmgvXTxl0X0sllnuyDS9J
 wyK7ishvEhFyM5Tf1ijxyTVBZqn2FwtAihxxh9QYd5RrZE0wmu9iOJP9CkyKaGZHXqS2d.oblv.S
 TAhUz5yAf3yu32NHcRjTj45QUzDFJfQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 00781111-531e-48f1-8001-67903e0535c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:45:18 +0000
Received: by hermes--production-gq1-6949d6d8f9-hnk4w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eb823cd57ae610622380a59672438916;
          Fri, 15 Dec 2023 22:45:15 +0000 (UTC)
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
Subject: [PATCH v39 37/42] LSM: Infrastructure management of the mnt_opts security blob
Date: Fri, 15 Dec 2023 14:16:31 -0800
Message-ID: <20231215221636.105680-38-casey@schaufler-ca.com>
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

Move management of the mnt_opts->security blob out of the
individual security modules and into the security
infrastructure. Blobs are atill allocated within the modules
as they are only required when mount options are present.
The modules tell the infrastructure how much space is required,
and the space is allocated if needed. Modules can no longer
count on the presence of a blob implying that mount options
specific to that module are present, so flags are added
to the module specific blobs to indicate that this module
has options.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c        | 14 ++++-----
 security/selinux/hooks.c   | 58 +++++++++++++++++++++++-------------
 security/smack/smack_lsm.c | 61 ++++++++++++++++++++++++++------------
 3 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/security/security.c b/security/security.c
index 092752666fb6..64cdf0e09832 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1352,18 +1352,15 @@ int security_fs_context_parse_param(struct fs_context *fc,
 				    struct fs_parameter *param)
 {
 	struct security_hook_list *hp;
-	int trc;
-	int rc = -ENOPARAM;
+	int rc;
 
 	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
 			     list) {
-		trc = hp->hook.fs_context_parse_param(fc, param);
-		if (trc == 0)
-			rc = 0;
-		else if (trc != -ENOPARAM)
-			return trc;
+		rc = hp->hook.fs_context_parse_param(fc, param);
+		if (rc != -ENOPARAM)
+			return rc;
 	}
-	return rc;
+	return -ENOPARAM;
 }
 
 /**
@@ -1437,6 +1434,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a9af3c848a16..46dee63eec12 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -365,15 +365,28 @@ static void inode_free_security(struct inode *inode)
 }
 
 struct selinux_mnt_opts {
+	bool initialized;
 	u32 fscontext_sid;
 	u32 context_sid;
 	u32 rootcontext_sid;
 	u32 defcontext_sid;
 };
 
+static inline struct selinux_mnt_opts *selinux_mnt_opts(void *mnt_opts)
+{
+	if (mnt_opts)
+		return mnt_opts + selinux_blob_sizes.lbs_mnt_opts;
+	return NULL;
+}
+
 static void selinux_free_mnt_opts(void *mnt_opts)
 {
-	kfree(mnt_opts);
+	struct selinux_mnt_opts *opts;
+
+	if (mnt_opts) {
+		opts = selinux_mnt_opts(mnt_opts);
+		opts->initialized = false;
+	}
 }
 
 enum {
@@ -628,7 +641,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -644,7 +657,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	mutex_lock(&sbsec->lock);
 
 	if (!selinux_initialized()) {
-		if (!opts) {
+		if (!opts || !opts->initialized) {
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
@@ -682,7 +695,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * also check if someone is trying to mount the same sb more
 	 * than once with different security options.
 	 */
-	if (opts) {
+	if (opts && opts->initialized) {
 		if (opts->fscontext_sid) {
 			fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
@@ -991,7 +1004,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
  */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct selinux_mnt_opts *opts = *mnt_opts;
+	struct selinux_mnt_opts *opts;
 	u32 *dst_sid;
 	int rc;
 
@@ -1006,12 +1019,12 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		return -EINVAL;
 	}
 
-	if (!opts) {
-		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
-		if (!opts)
+	if (!*mnt_opts) {
+		*mnt_opts = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!*mnt_opts)
 			return -ENOMEM;
-		*mnt_opts = opts;
 	}
+	opts = selinux_mnt_opts(*mnt_opts);
 
 	switch (token) {
 	case Opt_context:
@@ -1038,6 +1051,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		WARN_ON(1);
 		return -EINVAL;
 	}
+	opts->initialized = true;
 	rc = security_context_str_to_sid(s, dst_sid, GFP_KERNEL);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
@@ -2629,10 +2643,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return 0;
 
 free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
+	selinux_free_mnt_opts(*mnt_opts);
 	return rc;
 }
 
@@ -2683,13 +2694,13 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
 
-	if (!opts)
+	if (!opts || !opts->initialized)
 		return 0;
 
 	if (opts->fscontext_sid) {
@@ -2787,9 +2798,13 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = lsm_mnt_opts_alloc(GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
+	if (!fc->security) {
+		fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!fc->security)
+			return -ENOMEM;
+	}
+	opts = selinux_mnt_opts(fc->security);
+	opts->initialized = true;
 
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
@@ -2797,14 +2812,14 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 		opts->context_sid = sbsec->mntpoint_sid;
 	if (sbsec->flags & DEFCONTEXT_MNT)
 		opts->defcontext_sid = sbsec->def_sid;
-	fc->security = opts;
 	return 0;
 }
 
 static int selinux_fs_context_dup(struct fs_context *fc,
 				  struct fs_context *src_fc)
 {
-	const struct selinux_mnt_opts *src = src_fc->security;
+	const struct selinux_mnt_opts *src = selinux_mnt_opts(src_fc->security);
+	struct selinux_mnt_opts *dst;
 
 	if (!src)
 		return 0;
@@ -2813,7 +2828,8 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (!fc->security)
 		return -ENOMEM;
 
-	memcpy(fc->security, src, sizeof(*src));
+	dst = selinux_mnt_opts(fc->security);
+	memcpy(dst, src, sizeof(*src));
 	return 0;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b273e94028bb..61bd3f626e7d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -560,6 +560,7 @@ static int smack_sb_alloc_security(struct super_block *sb)
 }
 
 struct smack_mnt_opts {
+	bool initialized;
 	const char *fsdefault;
 	const char *fsfloor;
 	const char *fshat;
@@ -567,24 +568,37 @@ struct smack_mnt_opts {
 	const char *fstransmute;
 };
 
+static inline struct smack_mnt_opts *smack_mnt_opts(void *mnt_opts)
+{
+	if (mnt_opts)
+		return mnt_opts + smack_blob_sizes.lbs_mnt_opts;
+	return NULL;
+}
+
 static void smack_free_mnt_opts(void *mnt_opts)
 {
-	kfree(mnt_opts);
+	struct smack_mnt_opts *opts;
+
+	if (mnt_opts) {
+		opts = smack_mnt_opts(mnt_opts);
+		opts->initialized = false;
+	}
 }
 
 static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct smack_mnt_opts *opts = *mnt_opts;
+	struct smack_mnt_opts *opts;
 	struct smack_known *skp;
 
-	if (!opts) {
-		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
-		if (!opts)
+	if (!s)
+		return -EINVAL;
+
+	if (!*mnt_opts) {
+		*mnt_opts = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!*mnt_opts)
 			return -ENOMEM;
-		*mnt_opts = opts;
 	}
-	if (!s)
-		return -ENOMEM;
+	opts = smack_mnt_opts(*mnt_opts);
 
 	skp = smk_import_entry(s, 0);
 	if (IS_ERR(skp))
@@ -617,6 +631,7 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 		opts->fstransmute = skp->smk_known;
 		break;
 	}
+	opts->initialized = true;
 	return 0;
 
 out_opt_err:
@@ -638,10 +653,12 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-	fc->security = ctx;
+	if (!fc->security) {
+		fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!fc->security)
+			return -ENOMEM;
+	}
+	ctx = smack_mnt_opts(fc->security);
 
 	sbsp = smack_superblock(reference);
 	isp = smack_inode(reference->s_root->d_inode);
@@ -671,6 +688,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
 				return -ENOMEM;
 		}
 	}
+	ctx->initialized = true;
 	return 0;
 }
 
@@ -684,16 +702,21 @@ static int smack_fs_context_submount(struct fs_context *fc,
 static int smack_fs_context_dup(struct fs_context *fc,
 				struct fs_context *src_fc)
 {
-	struct smack_mnt_opts *dst, *src = src_fc->security;
+	struct smack_mnt_opts *src;
+	struct smack_mnt_opts *dst;
 
+	src = smack_mnt_opts(src_fc->security);
 	if (!src)
 		return 0;
 
-	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
-	if (!fc->security)
-		return -ENOMEM;
+	if (!fc->security) {
+		fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!fc->security)
+			return -ENOMEM;
+	}
 
-	dst = fc->security;
+	dst = smack_mnt_opts(fc->security);
+	dst->initialized = src->initialized;
 	dst->fsdefault = src->fsdefault;
 	dst->fsfloor = src->fsfloor;
 	dst->fshat = src->fshat;
@@ -803,7 +826,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	bool transmute = false;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -836,7 +859,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 
 	sp->smk_flags |= SMK_SB_INITIALIZED;
 
-	if (opts) {
+	if (opts && opts->initialized) {
 		if (opts->fsdefault) {
 			skp = smk_import_entry(opts->fsdefault, 0);
 			if (IS_ERR(skp))
-- 
2.41.0


