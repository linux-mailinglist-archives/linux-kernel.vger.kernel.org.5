Return-Path: <linux-kernel+bounces-1756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D2815394
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF518286C82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCFD13B14B;
	Fri, 15 Dec 2023 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S635WZGu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CD18EA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679272; bh=0xhRzVzL77uFNzvgfzEeytBOt25I4y9r8KJQkUff9Rs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=S635WZGutjA0fM2+I03Er0WW8GqRslS3Adtw9IpI5pzCgaG/nAaCLUxdRNo3rwsiIncPW+CY2JDvqjnUMFrJp8JlnRoFF+M9veeHePdJy1qLpOTEYkKr4OQvJFZMJc+T4KkTVOxvQdMUQKo2HzVqv5OyrwhvUDG7GmmWlkpmB95hnhVe9oWwhh0WvitkNo6yWIbI5uLVC5HOTsANUzpBWRoue4KHBhSOPc9NPuCdfZD9O5sXVloKw2VdruNBbw8hfJ5lo+CIjGS+BqZWfWG1O5rdf9bfnJmwI2tK0OL5iclHvbPfUUxZozXzoSeI8AZpzy46A2X6CrsRkDQC9jg8ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679272; bh=SKPWV8ey4mzCkDWp91daijRkgT1+ie4X/UBDMuLVczs=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qmbyDRsoe1Qbqqe+yzwBv2k9CgcuybdGc0UaLTk8hcAd0IU1ZWU6XiwQo7jrj5HzHlRpGBdLjDmGk25ci5S5CXpgifMjS83oqKPujJPPMBFMe09zXkVS2jCJqlh2ykkgOvUHGwtDFDf63J9a07Ud+dCrkkvGmpUr7vS++1iDzXGVFpjPQAVtrKDawiOk/PTSqmMFukzgY20KekfXOpNHJSRzKjZhBPonvq6B/etQOJiy6Htd5MsSofsZzLxdbEbAHmGC3abfSf19mgrAwB1meDzdrUAfyO+nK0h4ThkjL9VOHJOJp+DfLprOaRLC1tKnY2zhAMrIKobQOBoVvFdKiA==
X-YMail-OSG: PH3FmKYVM1mF1hVCKF_PWKmGU_PfyDwYDJXKUjaH8c4Vj7Nhx2WLQdueqNQekjR
 sVa4xzp0IAusanfXXF..oX0721SXKzbwUErhB.sLx9qhTXUWhVlFsPpqWSibdhSQ3_IHqx5gBbJU
 NmCGS2eaeCszcB6aTPsRqvwtixdkBd6BSv1EPnGF84QMyuUnUxezUC_94bf0RkK_h6iclc8EstUw
 w5uA9_4N55f02pHmv2uyVi1811C6YcU1UPfPliB.W78rI.c2ZwbkfFLbv.qLxd5ddpymnwvCCV5g
 7xlGGA6e7E5pT7AWuldFeS12bFkqAOQSB_sP0Z0oS2TT7TvmtOCy4KNVIp1D6JoGLzYexo58NMFy
 zPiGY7DsCxngv6BvE75zZvzzOspqBY9nnN29JrlwHq3c0I6._88UO69XrFHDATli51fVErGivI0e
 UNA_tAezv2fd7chQIE60ziTlcGukSy885Bd7cG35TRbrzC7i1K8pEMKmD74.KRvmw4w2i8ZcHCpm
 p.22P60V21V0VO_M_gDZm7aM8fdzfTKklaMQKJLuhondiSBofDBr3LrDm4Gn27ATQu_MPEXMdUQc
 G0M7v5KuC0VLYxaU6ImlEfZlzL40C8iYcSg5McmfMtaNl7hmmkHxwDHTTv41WTooiOnS4I_Ne.IS
 X7mANDAaC4OWlS73r7cbheiGkJgwGTWeWeMeNrwDDdj9VxX8UYNJ0QY8tc8p.CDztmGFTaTXtYcZ
 7ctlp7UGLWZlc7_5_TZjGnLCFgnXj1MVbcGuQRWlO70DRqH.PQZATH2GP4.TiN8fnci0ZdXoYYdt
 IQC8w.bhK.5fy9PSTlpK4IeN4nfh3HNhPo4B3gC7qw1LL2pAjHOwMtbEWI6ONQHYLhk4GDsfNmv0
 XxsgFWAWRIXjXo4VtFm7q0qDA.EISbuP3_s2s4xR5slgY7wqjhGWdiLxp_azck8NPq8snXWGH_tN
 lbHGtyieJMn3Ne0Not3esxuTd_RY5fksMzEaUw1K9M2LhL3us08XvNV4wNZZxXfvGTun3JT6waWM
 DxW7R2oGTO_q771VuPQFkPBtSs9SsOpEJRk0jG54cdaiq9awAQW92toAf29GI0GMYm0lo3VbEC80
 ADdY1TlaUgH4UP_5VVLLTNmnkgtV5aH8OPTfL6lACk3djtFwm9dlA7MCNS6XNxowtO4n9fKqly4.
 Gqjs_Yw1FE_Y66Tcq.WCVUfHzYmZnZUnF6v5TAoenoKD_O3H6QHNHyhuNS18EB2IMS_vDlEyhRv4
 zliHrvN.mmRbYDfWDVNdYZgd5YY937lPGF9A9d2CZhpiVVYr.zd7bsawJK1E.hIxypSJmaqGFIss
 KE70ImlB9.Ihoz8Wau3VRvrYaITtxV4hGkuAKmUL01JHGwIQ_X685FP.grKzj3ZUv5_GDHgE92iK
 Oxk8wV9GJ1OuXGu2lcNg7u54gc_PGVaV7O6JAkR_4HzK6ydQrOz1VlIgf_Y7xl2ZjixDrbbVhYCB
 Ed0DsC1c54td2EFkvqkvKEjsM2oQd0.ojgGGS9byBEMvXMak93UuPooFubYChKErA5e2tZIlySAw
 GglXMss.qW.vxMy7bzBUCcrW5AMdzfMkbrZQPy4NpioRu9OnbFXdbNV70dvyNrw6bmA0yxMurKPS
 nUO3bXEB39topgQLWBS_RP_3lgdg30TNRXWqszdnL3I9jOuozvJc434Ea8INgg8cpEAuFlQ0VtYz
 6Rig2OnEPfHcffHkFpSuxwYA5U1Nc8O9wYQhC6VZV7MaxOFuoJswbtVVf79YVa4mFHUXNmJHUn65
 ryOcm1n7GwhyEME9NlKHDQs97q_m8nzgGx5W7k_8kKNoZVUf3dNRyBzaiDk7z_FZ8MTqgAdK2Q4h
 cCarmDg0ufu2eGWryHd.gKFbTA7WaiV3O0yeiHfBxYvy3ymMgFvx0U8jwUYoykcKsGrMLuNINqQ.
 NRe5XBn1D.7fVL7r0eiArBPwGgTLNqq8vCOLfMjX00yBmL3ee9_kJGw.oU3zjez_UGEWCmLPGGxX
 bBxOfpuCix1t_PBTMXsxLsy2FGSLrtgoHhbXw68eRybUiKBgNMHISXJhKvNflfF.BAHw.bNeywWN
 PtKv8Ui67c4DcGTNZeqpclcnN7fduBzFZwDpkStEwM0vskibOVRWp4RyKdBaKA2xt52jCWdcRy7E
 Z6gb_DiZi54519rHI1HOi9ObwU7i6ZHjTRSFF8JcLg1SxYzQkbJxU1EFwT.j5TmPDwWbl18hxlmE
 F7rm4lZXO9kY.AQYZeTm9W4qQMvUQPxxlETkJxsyrT5JhIxW.qh4.hOtRH3UjP0NgpgG.vDCh.VT
 kDLhQm_.uoOr2Kmz2fDVsQYWxOsUy
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b4d1f540-b7f0-435b-8a33-53babebcef2a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:27:52 +0000
Received: by hermes--production-gq1-6949d6d8f9-ghhkt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2d8de7c709cc71c362074832ee86fab;
          Fri, 15 Dec 2023 22:27:49 +0000 (UTC)
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
Subject: [PATCH v39 14/42] Audit: Change context data from secid to lsmblob
Date: Fri, 15 Dec 2023 14:16:08 -0800
Message-ID: <20231215221636.105680-15-casey@schaufler-ca.com>
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

Change the LSM data stored in the audit transactions from a secid
to an LSM blob. This is done in struct audit_context and struct
audit_aux_data_pids. Several cases of scaffolding can be removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h       |  2 +-
 kernel/auditfilter.c |  1 -
 kernel/auditsc.c     | 31 ++++++++++++-------------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 6c664aed8f89..b413c0420c6f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -144,7 +144,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_blob;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index d0df226bdc51..24cb8259e5b1 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1369,7 +1369,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					/* stacking scaffolding */
 					security_current_getlsmblob_subj(&blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index aaea62822505..bfe2ee3ccbe6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -100,7 +100,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_blob[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -1019,7 +1019,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_pid = 0;
 	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
 	ctx->target_sessionid = 0;
-	ctx->target_sid = 0;
+	lsmblob_init(&ctx->target_blob);
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
@@ -1093,8 +1093,9 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid, struct lsmblob *blob,
+				 char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
@@ -1108,8 +1109,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+	if (lsmblob_is_set(blob)) {
+		if (security_lsmblob_to_secctx(blob, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1778,7 +1779,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_blob[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1787,7 +1788,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_blob, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2722,15 +2723,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getlsmblob_obj(t, &blob);
-	/* stacking scaffolding */
-	context->target_sid = blob.scaffold.secid;
+	security_task_getlsmblob_obj(t, &context->target_blob);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2746,7 +2744,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2758,9 +2755,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getlsmblob_obj(t, &blob);
-		/* stacking scaffolding */
-		ctx->target_sid = blob.scaffold.secid;
+		security_task_getlsmblob_obj(t, &ctx->target_blob);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2781,9 +2776,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getlsmblob_obj(t, &blob);
-	/* stacking scaffolding */
-	axp->target_sid[axp->pid_count] = blob.scaffold.secid;
+	security_task_getlsmblob_obj(t, &axp->target_blob[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
-- 
2.41.0


