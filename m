Return-Path: <linux-kernel+bounces-1769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020C8153BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D99B21330
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4B19452;
	Fri, 15 Dec 2023 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cZx2YgbZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90D18EC2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679750; bh=7oGr4ctFH9QOr0JDyPZF54I+ATweTTJfL6KeAVlw3sg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cZx2YgbZ0yWw8PpjV3NBeAE4zqX0pXv1QozyWcijSEUi7mMMMmSz4A28juWjG9QSvTRx0LxJEngNKyEFhIoSS8gMCYfE1KNTeqbDYiD0NENd0z2DZSElMt4sOFdeDah2agSRFMXnsjo10h/sNzZvML3peFldRC3XD4qImGroW3VqtHAi5xs3CjZqENEzmgraiy1tNSqKtE1hZLk87kDa4VrC6OXHQfeMsvMhSVJF8d9SEAkYJ490hwymy9a2xs+G63ZtLt09LAbUCS0/4Th1EcgqP4TdYw+1RaplrupGprIlDsABYdL+du3lGQEJhDUu8zKinlAJAoI2l8qG/NX5jQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679750; bh=cZH7URqADBFeRFOdehMoNbzHoLzBFNRIHZY4YfjZzcE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=uKm7o6iHNoldhoYCf2qCc+1apLB+99AQBzcaYAfNdeddf0Hm4Fx244M0xQGl18FPHnVtE8vunlIwcAffiR7FcZqZB13T4bUH34GGHETixcYEWh9TKVFyKoSAAkkNWsIV9EKi516g+HNsz3ZfffvLdND+Xgz6SaHUfWxnIQaGV9qvgxzQMFpIlp3sihobjy2Fk+Z7M6aHglGOQaExv+cdC/kNBdnx9N8p9QkbieN0VQ77VXwX8RdStO9x/Saf4HJYTsemvhFM+RshWcR8eizVcql2l0T2ae1g21DzXiKSk1FP2RhwDWjJYXUiUZNVZRflJmLkplSZrF45NEhv1HxUKg==
X-YMail-OSG: 5Zw6fdMVM1nvxgH9LBsMWQy7JWOMc3r_aNw741QEytgrLfSY.XsGwvJmleLxaai
 uzo6gmtXdLcCYZ95dthMySItWzE4dU7jXJ3I2sOo6ctlDZnQ72Y8knZr70dhZlMJhpQ81679A8Q2
 LuOsMc1_c44Rpkdx.QZaMT6g59ydug56lB8jPQ2LEy_dkxhr9sWPsXDmWkSJ_EJascLmRHG.WJK_
 7iwFXNPLTIgXu0nJ7ssD2E6MSJR_J86fnDz.oZtsbwmlI8KUuYDBcXgy9mwsI6dB2jFrYUMvzwdM
 y1Rlb5P6itVnh426wXUin3Ie6fb.5qOCGLWUBbJc_zlVppE4uJ1xF01rcX1d5QbujVPmmXj98EYZ
 QDkluDZ2Np1VLWXhNJobcrYalvhF4t3fiLjWX_CAEIOx7diYaQiaw9OPJYwJSpHaO6Ica0kJtgnh
 bbIy9Cs8s1YQW1.dmhK10YgC8n25yss6pxn5Ne_jAc93wYyvi6PAF5Bf5QNW4_wnU82p9f5JfD1C
 feuudW3Exd67VZs3T_iPu2iXnsWzAn_TVJ2PkoyElU2ba0nwvxKH0tSszSJseD7I7vJjmI9BRYs3
 4fYFIzkAk7auDDQBlJUkkEnNFjFvXPcu1UllOiSnXj.lKN_mdQ.qGB_GFgM29K09_MMzFVwqyp6x
 Y0g5j2bcmIc2IWv0.cgGyFDXNB7lsZ8caRwJd6rtD1ILVo3P1TE.VO9OzKPEoQ9GINQygj0YLo21
 CLlGwQWEJnFVoDxYOo89yP5I5l24gdBxpl9FNgwOfc7AdVgZ1HCch.SCMUvuuTth8XRmwOfqjYKA
 H14E6MlG_ilJ__IswPl6nlinLN7GezO4AZFGOqcXJR.drkDRnIN.cWjR8.7xDdUxHZ5o0BTBTsHu
 WrszOIsff.mPIpXmPPCnJi_vNpAOHssw6SDmZrrdB5cg_2QYGtlOly9K_brgFmFDqeJkAlt8wWWI
 LblQ6bj1I_igp1surKGIYZrqeuTGLCtGKWOid8x2tkzAy17G17yideQkOu1t0VsrrzcHJjisJc0W
 yK6WvgTZWMQ8vXbnErLvhBHv144b5Lw8dYdOVbzR0z7G2qdPcy8AfaQqbCbw8rXvL2qtBne7VDaP
 FgyXtf49oopVvon_5aCSWe7L5JaqZcEq.iYcD0FpqEFwtWvsi62eItoip.DvCBl_OVSbkNBMTSQH
 nv4x_Lkw_IntnK0aMrBJZpHy1oQh1zckPnkyiI43W9Ye8qYvVqFl9lK7F09WSRjV1OxQB9Y34Rps
 H8nG9.QN0mCf9P03kFHGzzwHeCVOr.Jz4jZz66IyXjxVYE1YoS9Brz00ihDeuRVtrF3XOub3sgus
 gCver4bqGE9K6zjodxhZPSGPasRshtn3doJ.koKoUa01PItoyry2ybkw9HgtwmNuNkAYY7MBlAyo
 _7DaETVj8AYVrtaU9o_IYMJOv0xKUcTLGpOpyRDmW7BTIKb5MAajAxLE9EB0wcu0IlkVK6lbhuAY
 VcxsJ4DvkoJbnziW2VWqqifBqnVzs034G6cU2auYdRYUJGdhdm3xJ04la2mEdcLajQ3oxd2KELSI
 _W0Z3dXlKT.mbzetSS1Y22abuuq.AoNMfp3qL7CQ6L8Szux5R1OFItphR13_jVKphG2Os7QCvSwT
 N_NvELC_kHAtwkl82Uq9.dHkIGB0QhlQ1uiHJt45Ln2scDJxTIfCGXREqMn8XkNBqqI8ukpABJsB
 rFHhtbMyIXilBLkT2c5SwDVb2RGkUEd0j26wDDfHH6I2Yd_06fxOfXX8WILX5vY778RVF1iuOhwH
 0udeZLU2NK1mGFLsAP.Y.JO1qKLOVxT5O20xbQhFloXPcKc1nhQ7MK1pdwI3Gk1.o1Dk8K.AVsgC
 r7bIMm7V19sWwgRhUrhwRQYfikoyF5JdQ1MP_pNZ4GXMBMXf4WudVr0GqZWxY9bc1_fWRp5ABQ6U
 ikwGA8hvF1J_NTtB85DhOSIXWBQ56.Uf36yq08DbHT_5S.kU10AykF160.sL8OODBun2vv_fNSjC
 3WqOG1REeUMTyz4dFdZh7OQFClvzj6PluR9i5eHaRFXwl5JrOf6rbVns1pWUy1bzDRtz4LKE.mYB
 kxsT1CEp3QiUss4I49r2TqnpsNT0yx07lnO0dF_cDkMzdJX2W1sJG29UH4x3ATLSZvQlZmvJKmCb
 N_mb.FfYdqQEpgWt3oFxM4AugF9HmfaTjVf6XYCoMkBEjQM4SxDCpt5irf17shekX7XJx13bMlDl
 qfAFBOILIfJxdmbEgQomPDZNBaxB_m2GOQwW590LmGI49zrrNHCqe4PuPT1xh.QfAT6BawFyAk1.
 73Uw4ijlsptbMoe82_tJZQA7rGqsq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a6d2c742-c961-47ca-aaf3-9c461d42ba67
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:35:50 +0000
Received: by hermes--production-gq1-6949d6d8f9-c9pk7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4756c4ce944f308f64e0301afd197084;
          Fri, 15 Dec 2023 22:35:46 +0000 (UTC)
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
Subject: [PATCH v39 25/42] audit: multiple subject lsm values for netlabel
Date: Fri, 15 Dec 2023 14:16:19 -0800
Message-ID: <20231215221636.105680-26-casey@schaufler-ca.com>
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

Refactor audit_log_task_context(), creating a new
audit_log_subject_context(). This is used in netlabel auditing
to provide multiple subject security contexts as necessary.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  8 ++++++++
 kernel/audit.c               | 21 ++++++++++++++-------
 net/netlabel/netlabel_user.c |  8 +-------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 51b1b7054a23..8974500f730f 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -36,6 +36,7 @@ struct mqstat;
 struct audit_watch;
 struct audit_tree;
 struct sk_buff;
+struct lsmblob;
 
 struct audit_krule {
 	u32			pflags;
@@ -184,6 +185,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subject_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -244,6 +247,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subject_context(struct audit_buffer *ab,
+					    struct lsmblob *blob)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index 9d971fa96c0e..626942c38bca 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2225,20 +2225,18 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+int audit_log_subject_context(struct audit_buffer *ab, struct lsmblob *blob)
 {
 	struct lsmcontext ctx;
-	struct lsmblob blob;
 	bool space = false;
 	int error;
 	int i;
 
-	security_current_getlsmblob_subj(&blob);
-	if (!lsmblob_is_set(&blob))
+	if (!lsmblob_is_set(blob))
 		return 0;
 
 	if (lsm_blob_cnt < 2) {
-		error = security_lsmblob_to_secctx(&blob, &ctx, LSM_ID_UNDEF);
+		error = security_lsmblob_to_secctx(blob, &ctx, LSM_ID_UNDEF);
 		if (error < 0) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2257,7 +2255,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	for (i = 0; i < lsm_active_cnt; i++) {
 		if (!lsm_idlist[i]->lsmblob)
 			continue;
-		error = security_lsmblob_to_secctx(&blob, &ctx,
+		error = security_lsmblob_to_secctx(blob, &ctx,
 						   lsm_idlist[i]->id);
 		if (error < 0) {
 			if (error == -EOPNOTSUPP)
@@ -2277,9 +2275,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subject_context");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subject_context);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsmblob blob;
+
+	security_current_getlsmblob_subj(&blob);
+	return audit_log_subject_context(ab, &blob);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 842a236540b0..4dd0f453bb4e 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsmcontext ctx;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -97,12 +96,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (lsmblob_is_set(&audit_info->blob) &&
-	    security_lsmblob_to_secctx(&audit_info->blob, &ctx,
-				       LSM_ID_UNDEF) >= 0) {
-		audit_log_format(audit_buf, " subj=%s", ctx.context);
-		security_release_secctx(&ctx);
-	}
+	audit_log_subject_context(audit_buf, &audit_info->blob);
 
 	return audit_buf;
 }
-- 
2.41.0


