Return-Path: <linux-kernel+bounces-1753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5681538D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F43286C62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C318EC6;
	Fri, 15 Dec 2023 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ezsOsT0i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89C13B13E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679084; bh=ya0OCYd/b1yyh4uzXzAyH0lituR0lp9LeCsospqdOmE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ezsOsT0iVIiMzWakeQboTpN55HwqCCZ5/hBr9qm3hxZVebROS3slB4hhFLIrsaPeKE2ulVMhfzWPvBZaTEU5abaoYzQ1H2eJTNFAfT+1vR+fbIMXWVDw9howdpIoJ1M1RD6xnp+wXgmYtk58VGFjpxm5eRn3bFs8ZMZ5rkIQoDYHPWZmxi8BW8XG2sqrJdA989ICRHvg1B32UGz70m+v2hdeaV6Tz5RGhWw2C/r+2iPjZZYCY7QhKrfmEpTxMocKaMfYnAhVX5lSPz1h7NXYwvujhLUQe9Ko8xi6scC/sPKsSVfDRH1AsXdGc96KtaBXEIduySqw4caun+K1cY6s8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679084; bh=ec9K0gp/YeS3lx9Mu8qvVcYa7PUUxMItvUguWAEC1xS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M+hjx3MHwoY66xRLPtFd10vBS6+fHX4XfE0YUKkuu32tsy4KdL5sSXn7Jdlhsq3OtUYBst4BVdzHiRccXKs2J+iy7AzD82JzN+EioxMeK32pXAEEAwECTojbIzvxn2xzywy18UHuLZC9Log8oaIQE8BIxMIuqtiWX88hIEEWJfJwDEX8YnlA0eaHcxk/liX3w2IvrntEQo2tr2tY+QFUxY8jEqejj1+oSg01xcameNZkB5kl6CyDwMRT15mKgPJyBmZAGngKd7dcbTakOMLEuzphlKQPOGQVKtH46mD/yJzL5j0I4OxJpGyHEmncjy6+59AgPQrucamBk4/axzx6Vw==
X-YMail-OSG: Ma1O6GMVM1nxIpbBLmG.pYTD21spsB1YngIitqUoRskKRZiwyX9YYznJoD16mfn
 yK3ksPM.u.iKnz8jowqrVu4H5T4Si784oFxFEekFvb4x02vO0UK5rTz01rSsURPR_4aU3pYB2RQS
 h5N5qatC1JlM7tzVx2uqy9dBu_tb1.2RrJRZN1Q5mycO0KmMK20qnj_iA9rkBf2PHDSykID8f3xd
 9E5677x5RV6bV8DV9MDa30GwtcP0k3pffc72d53sKjYDr7H_PkWGtk76jGO3Nh901y1CwthsoaS.
 V335nByvimLzKdbtoQFeWRMo7oZSoZCEEyH8dHmQzwsdQQycDG4pPylLurcP0WhZ7Y60zvfmA1Ys
 Py3CYCDFnZHdO9FuZxOPLlcJPCDNoBOH9CZB_ZMSUwB7Z5.k.b2XF_LUg3IAlVTa9cZwyMlh2u5m
 n.EOlaoOUCtCBJws4BlJcFQfSVFbpPnomeLpxRcPnwiP7Vm9drsWyFOVYZsLLyzXU7FfI_dJAU9Q
 G2rMmskdNRhcnLp1N28sQI_Eh9oMeEAUHg0NZEXbvMUyrEnH_RDLMjOx1IrJQKqL6GBddGM3BcdK
 ASmbHwo7XHsz5NQWjWhHICv5A6fAxiqjO_tzZdHHKi77ljJPJhQxBegyonJyfOWksMWB0.HrquhG
 x0nL.bjS0iQYvQqrYoo.UQ9YOm9GWyEHh3bHEPy9LCU56BmImxDZTg10PrWBWqcR_aPN9WBV1_PE
 0sT6Rk2jF.MmDEvCiDJneEPPhVi5psHc_AYT7udFX2OalX6BSz9dw4qei.g3SaDFJdXApIMor5pU
 wKjv3BXwuMTY1b1l0OdrEYtAF2X9PKVfmbGFn2CX70wuFxW0HQHJaDQdxnkk6xrExAMinMh07Yq7
 8PeVFTtrp9jSdLe_nONNtZsWj8rQ3ZiyDkpaErpZ2QZQqsh2GIeYts5x7nmHOt.osSbcGSEcWK4C
 oq4lQB_N4mnXTFJWSUKMluZfhppO.rySQuqLLM2XOO3Aefh55ey3ONUawJjTvga47SSY4_UxDhmR
 25ioZmauruff7Wx8DiyMTvyQD2gT_n6GB5CJ0gPPohc58V8tmZnpuKSL5kJjcc0twZz9OoOgjhpv
 9PYV8PDXT5API5ZAKUNK5B6eadkqjaUlQVTfaGo.yCWfHSLgnTRKyCtkKwftScS.k.gTDEIZXSYu
 QeM7yPj0XP6Sx3eiieq0Cjj0n_iqSpZNPOuK1XF4ZYRvEuqWggRu3HpAtrF5GSO.dzXWexzmRWrP
 oKtwOgOvM9C1vrrdI2XQjcojuaRpijp2D50C1t119pb.xDwrcmMaiqE3_JCECxYTBeGkN4w4S7VC
 z3UEsEkmKNkVduIAQGrSsNwFTxIr8bcyN0SPh8XJz3cKVkh2M9d_fBn_B2W_DM12wacujYchUpb9
 F_L.760UO9DwKiyq25dweP0Gzk7hVajvloyhaTzW2_FIiUXX.v7UXkWppA15K5JZE6XEYVAtui2S
 IRqd5xJMkBX_61B.3txr6SoVakSZ_Euv2DWWD4_s7HPdamaDqG0_PT1gO4bPVAaqbzO1.7nLn_NR
 JB.YCemt_.mAaC_cFuTI_0e1WKFhbIaaj4KuToSl.Hr2rIsg4YpUz5crilUw6ZfdqXBk7mBYX0i3
 jo7.LIJWmiUfH8nK6tSj7RILU02J3nI993BqdthVnsI2gvxkHnReYxved7zKrwKyB6gEQE_okxnU
 hiAdvHgFis7qh_FshFm6ywpNV9B_qvOUYVdwwFVpZRBgzMbx3FpVPDblO2rKmG9kGKhIvjq8btqG
 ZO34ehWio3dTRl0n8__3uoqn.bekXvIl73SpIzqxD74BtKLf8MWzYZ5Cc7Qg0WDqxwoRSokP7nR6
 nnqXYEz6jOdPoUzFJ3bRHC9wHFhiOtulttkL7Eg9mAY08CneQfh7gf8H7GX0KaZeMVLBtVYV3CRC
 NSu8VFkzWg7ECktOI_RXPwyPmiU6.G82LU6a4lHxKX3ugJRSzPnrdjkspXuPgTkXCk3CK42AdaH8
 eJ23BodqJdrCpPKus.x9SPjy6og0N4LMUM3XYdub6jn0j7ZJ3sXB1qugP72C0pD1WNRTbuxj4ZLD
 KAhKYEdwzB5mQfuok_Qm_FBRLoIq8zSMZ03jDn_tSbpZrD..dvT4wvlFYAhAt7ZwYdA2nAymyy8E
 CkE7DMO2V0skdg0.7Rv9kxG9y2QICVSHFpALVox4JMD9dlqvS_QMA4B1mGE657BefE0aXmYabZwk
 _DcFHL9MuJAf19Q7sBwBoLqKwrlaXX_0hIesmJCltht5yjgYy6JvpsPpHCwJOJ4J6le4wkXqerFJ
 I0osv2XHek.xg6n9dHdZr28_86YrcrA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4a404d4f-f93e-4b92-96f2-dc46c989ad72
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:24:44 +0000
Received: by hermes--production-gq1-6949d6d8f9-ghhkt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aee9c1d49ff512a4183bc9eedbd8cede;
          Fri, 15 Dec 2023 22:24:38 +0000 (UTC)
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
	linux-audit@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH v39 10/42] LSM: Use lsmblob in security_current_getsecid
Date: Fri, 15 Dec 2023 14:16:04 -0800
Message-ID: <20231215221636.105680-11-casey@schaufler-ca.com>
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

Change the security_current_getsecid_subj() and
security_task_getsecid_obj() interfaces to fill in
a lsmblob structure instead of a u32 secid in support of
LSM stacking. Audit interfaces will need to collect all
possible security data for possible reporting.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
Cc: netdev@vger.kernel.org
---
 include/linux/lsm_hook_defs.h         |  6 +--
 include/linux/security.h              | 13 +++---
 kernel/audit.c                        | 11 +++--
 kernel/auditfilter.c                  |  3 +-
 kernel/auditsc.c                      | 22 ++++++----
 net/netlabel/netlabel_unlabeled.c     |  5 ++-
 net/netlabel/netlabel_user.h          |  6 ++-
 security/apparmor/lsm.c               | 20 ++++++---
 security/integrity/ima/ima.h          |  6 +--
 security/integrity/ima/ima_api.c      |  6 +--
 security/integrity/ima/ima_appraise.c |  6 +--
 security/integrity/ima/ima_main.c     | 59 ++++++++++++++-------------
 security/integrity/ima/ima_policy.c   | 14 +++----
 security/security.c                   | 28 ++++++-------
 security/selinux/hooks.c              | 17 +++++---
 security/smack/smack_lsm.c            | 23 +++++++----
 16 files changed, 138 insertions(+), 107 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index d69332031270..2db7320a1e05 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -213,9 +213,9 @@ LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
-	 struct task_struct *p, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, current_getlsmblob_subj, struct lsmblob *blob)
+LSM_HOOK(void, LSM_RET_VOID, task_getlsmblob_obj,
+	 struct task_struct *p, struct lsmblob *blob)
 LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
 LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
 LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
diff --git a/include/linux/security.h b/include/linux/security.h
index 2ca118960234..6306e8ab0cf6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -479,8 +479,8 @@ int security_task_fix_setgroups(struct cred *new, const struct cred *old);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_current_getsecid_subj(u32 *secid);
-void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
+void security_current_getlsmblob_subj(struct lsmblob *blob);
+void security_task_getlsmblob_obj(struct task_struct *p, struct lsmblob *blob);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1227,14 +1227,15 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_current_getsecid_subj(u32 *secid)
+static inline void security_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
-static inline void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static inline void security_task_getlsmblob_obj(struct task_struct *p,
+						struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index 875df831fb61..54dfe339e341 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2164,16 +2164,16 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	struct lsmblob blob;
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 
-	security_current_getsecid_subj(&sid);
-	if (!sid)
+	security_current_getlsmblob_subj(&blob);
+	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	error = security_lsmblob_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
@@ -2390,8 +2390,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		/* stacking scaffolding */
-		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
+		security_current_getlsmblob_subj(&audit_sig_lsm);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 08dc64bb8496..d0df226bdc51 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1370,8 +1370,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					/* stacking scaffolding */
-					security_current_getsecid_subj(
-							&blob.scaffold.secid);
+					security_current_getlsmblob_subj(&blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
 						   f->lsm_rule);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 89d490db0494..7afeae468745 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -470,7 +470,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob blob = { };
 	unsigned int sessionid;
 
@@ -675,15 +674,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * fork()/copy_process() in which case
 					 * the new @tsk creds are still a dup
 					 * of @current's creds so we can still
-					 * use security_current_getsecid_subj()
+					 * use
+					 * security_current_getlsmblob_subj()
 					 * here even though it always refs
 					 * @current's creds
 					 */
-					security_current_getsecid_subj(&sid);
+					security_current_getlsmblob_subj(&blob);
 					need_sid = 0;
 				}
-				/* stacking scaffolding */
-				blob.scaffold.secid = sid;
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
@@ -2730,12 +2728,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &context->target_sid);
+	security_task_getlsmblob_obj(t, &blob);
+	/* stacking scaffolding */
+	context->target_sid = blob.scaffold.secid;
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2751,6 +2752,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
+	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2762,7 +2764,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid_obj(t, &ctx->target_sid);
+		security_task_getlsmblob_obj(t, &blob);
+		/* stacking scaffolding */
+		ctx->target_sid = blob.scaffold.secid;
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2783,7 +2787,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
+	security_task_getlsmblob_obj(t, &blob);
+	/* stacking scaffolding */
+	axp->target_sid[axp->pid_count] = blob.scaffold.secid;
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 9996883bf2b7..129d71c147f1 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,11 +1534,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getsecid_subj(&audit_info.secid);
+	security_current_getlsmblob_subj(&blob);
+	/* stacking scaffolding */
+	audit_info.secid = blob.scaffold.secid;
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index d6c5b31eb4eb..c4864fa18a08 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,7 +32,11 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	security_current_getsecid_subj(&audit_info->secid);
+	struct lsmblob blob;
+
+	security_current_getlsmblob_subj(&blob);
+	/* stacking scaffolding */
+	audit_info->secid = blob.scaffold.secid;
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1b230ade84fc..b5f3beb26d5a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -979,17 +979,24 @@ static void apparmor_bprm_committed_creds(const struct linux_binprm *bprm)
 	return;
 }
 
-static void apparmor_current_getsecid_subj(u32 *secid)
+static void apparmor_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	struct aa_label *label = __begin_current_label_crit_section();
-	*secid = label->secid;
+
+	blob->apparmor.label = label;
+	/* stacking scaffolding */
+	blob->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
-static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void apparmor_task_getlsmblob_obj(struct task_struct *p,
+					  struct lsmblob *blob)
 {
 	struct aa_label *label = aa_get_task_label(p);
-	*secid = label->secid;
+
+	blob->apparmor.label = label;
+	/* stacking scaffolding */
+	blob->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
@@ -1519,8 +1526,9 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(task_free, apparmor_task_free),
 	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
-	LSM_HOOK_INIT(current_getsecid_subj, apparmor_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmblob_subj,
+		      apparmor_current_getlsmblob_subj),
+	LSM_HOOK_INIT(task_getlsmblob_obj, apparmor_task_getlsmblob_obj),
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 	LSM_HOOK_INIT(userns_create, apparmor_userns_create),
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 560d6104de72..53f794b75bf9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -256,7 +256,7 @@ static inline void ima_process_queued_keys(void) {}
 
 /* LIM API function definitions */
 int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos);
@@ -287,8 +287,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 597ea0c4d72f..f9f74419f5ef 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -165,7 +165,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @idmap: idmap of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: secid(s) of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -187,7 +187,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *
  */
 int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos)
@@ -196,7 +196,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(idmap, inode, cred, secid, func, mask,
+	return ima_match_policy(idmap, inode, cred, blob, func, mask,
 				flags, pcr, template_desc, func_data,
 				allowed_algos);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 870dde67707b..41cf92d15972 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -73,13 +73,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_current_getsecid_subj(&secid);
-	return ima_match_policy(idmap, inode, current_cred(), secid,
+	security_current_getlsmblob_subj(&blob);
+	return ima_match_policy(idmap, inode, current_cred(), &blob,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
 				NULL, NULL, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cc1217ac2c6f..657143fe558d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -205,8 +205,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -230,7 +230,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
+	action = ima_get_action(file_mnt_idmap(file), inode, cred, blob,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
@@ -430,23 +430,23 @@ static int process_measurement(struct file *file, const struct cred *cred,
 int ima_file_mmap(struct file *file, unsigned long reqprot,
 		  unsigned long prot, unsigned long flags)
 {
-	u32 secid;
+	struct lsmblob blob;
 	int ret;
 
 	if (!file)
 		return 0;
 
-	security_current_getsecid_subj(&secid);
+	security_current_getlsmblob_subj(&blob);
 
 	if (reqprot & PROT_EXEC) {
-		ret = process_measurement(file, current_cred(), secid, NULL,
+		ret = process_measurement(file, current_cred(), &blob, NULL,
 					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
-		return process_measurement(file, current_cred(), secid, NULL,
+		return process_measurement(file, current_cred(), &blob, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 
 	return 0;
@@ -473,9 +473,9 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
 	struct inode *inode;
+	struct lsmblob blob;
 	int result = 0;
 	int action;
-	u32 secid;
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
@@ -483,13 +483,13 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
-	security_current_getsecid_subj(&secid);
+	security_current_getlsmblob_subj(&blob);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
-				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
+				current_cred(), &blob, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
-				 current_cred(), secid, MAY_EXEC,
+				 current_cred(), &blob, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
 				 NULL);
 
@@ -527,15 +527,18 @@ int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsmblob blob = { };
 
-	security_current_getsecid_subj(&secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_current_getlsmblob_subj(&blob);
+	ret = process_measurement(bprm->file, current_cred(),
+				  &blob, NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
+	/* stacking scaffolding */
+	blob.scaffold.secid = secid;
+	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
@@ -551,10 +554,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsmblob blob;
 
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_current_getlsmblob_subj(&blob);
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -755,7 +758,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
@@ -775,9 +778,9 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, NULL,
-				   0, MAY_READ, func);
+	security_current_getlsmblob_subj(&blob);
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
+				   MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -805,7 +808,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
@@ -818,8 +821,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	security_current_getlsmblob_subj(&blob);
+	return process_measurement(file, current_cred(), &blob, buf, size,
 				   MAY_READ, func);
 }
 
@@ -945,7 +948,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	int digest_hash_len = hash_digest_size[ima_hash_algo];
 	int violation = 0;
 	int action = 0;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (digest && digest_len < digest_hash_len)
 		return -EINVAL;
@@ -968,9 +971,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_current_getsecid_subj(&secid);
+		security_current_getlsmblob_subj(&blob);
 		action = ima_get_action(idmap, inode, current_cred(),
-					secid, 0, func, &pcr, &template,
+					&blob, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d24205aa1beb..48287b75fe77 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -579,7 +579,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @idmap: idmap of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the secid(s) of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
@@ -589,7 +589,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct mnt_idmap *idmap,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
+			    struct lsmblob *blob, enum ima_hooks func, int mask,
 			    const char *func_data)
 {
 	int i;
@@ -681,8 +681,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			/* stacking scaffolding */
-			blob.scaffold.secid = secid;
 			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule,
@@ -748,7 +746,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM secid(s) of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
@@ -765,8 +763,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos)
 {
@@ -784,7 +782,7 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, idmap, inode, cred, secid,
+		if (!ima_match_rules(entry, idmap, inode, cred, blob,
 				     func, mask, func_data))
 			continue;
 
diff --git a/security/security.c b/security/security.c
index b82245d55f66..58387e1f0c04 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3357,33 +3357,33 @@ int security_task_getsid(struct task_struct *p)
 }
 
 /**
- * security_current_getsecid_subj() - Get the current task's subjective secid
- * @secid: secid value
+ * security_current_getlsmblob_subj() - Current task's subjective LSM data
+ * @blob: lsm specific information
  *
  * Retrieve the subjective security identifier of the current task and return
- * it in @secid.  In case of failure, @secid will be set to zero.
+ * it in @blob.
  */
-void security_current_getsecid_subj(u32 *secid)
+void security_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(current_getsecid_subj, secid);
+	lsmblob_init(blob);
+	call_void_hook(current_getlsmblob_subj, blob);
 }
-EXPORT_SYMBOL(security_current_getsecid_subj);
+EXPORT_SYMBOL(security_current_getlsmblob_subj);
 
 /**
- * security_task_getsecid_obj() - Get a task's objective secid
+ * security_task_getlsmblob_obj() - Get a task's objective LSM data
  * @p: target task
- * @secid: secid value
+ * @blob: lsm specific information
  *
  * Retrieve the objective security identifier of the task_struct in @p and
- * return it in @secid. In case of failure, @secid will be set to zero.
+ * return it in @blob.
  */
-void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+void security_task_getlsmblob_obj(struct task_struct *p, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid_obj, p, secid);
+	lsmblob_init(blob);
+	call_void_hook(task_getlsmblob_obj, p, blob);
 }
-EXPORT_SYMBOL(security_task_getsecid_obj);
+EXPORT_SYMBOL(security_task_getlsmblob_obj);
 
 /**
  * security_task_setnice() - Check if setting a task's nice value is allowed
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f15991ef6ca8..d70000363b7a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4124,14 +4124,19 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_current_getsecid_subj(u32 *secid)
+static void selinux_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	*secid = current_sid();
+	blob->selinux.secid = current_sid();
+	/* stacking scaffolding */
+	blob->scaffold.secid = blob->selinux.secid;
 }
 
-static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void selinux_task_getlsmblob_obj(struct task_struct *p,
+					struct lsmblob *blob)
 {
-	*secid = task_sid_obj(p);
+	blob->selinux.secid = task_sid_obj(p);
+	/* stacking scaffolding */
+	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -7153,8 +7158,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(current_getsecid_subj, selinux_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmblob_subj, selinux_current_getlsmblob_subj),
+	LSM_HOOK_INIT(task_getlsmblob_obj, selinux_task_getlsmblob_obj),
 	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b00f4f44f9c5..46cc79eb1200 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2210,30 +2210,35 @@ static int smack_task_getsid(struct task_struct *p)
 }
 
 /**
- * smack_current_getsecid_subj - get the subjective secid of the current task
- * @secid: where to put the result
+ * smack_current_getlsmblob_subj - get the subjective secid of the current task
+ * @blob: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's subjective smack label.
  */
-static void smack_current_getsecid_subj(u32 *secid)
+static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	struct smack_known *skp = smk_of_current();
 
-	*secid = skp->smk_secid;
+	blob->smack.skp = skp;
+	/* stacking scaffolding */
+	blob->scaffold.secid = skp->smk_secid;
 }
 
 /**
- * smack_task_getsecid_obj - get the objective secid of the task
+ * smack_task_getlsmblob_obj - get the objective data of the task
  * @p: the task
  * @secid: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's objective smack label.
  */
-static void smack_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void smack_task_getlsmblob_obj(struct task_struct *p,
+				      struct lsmblob *blob)
 {
 	struct smack_known *skp = smk_of_task_struct_obj(p);
 
-	*secid = skp->smk_secid;
+	blob->smack.skp = skp;
+	/* stacking scaffolding */
+	blob->scaffold.secid = skp->smk_secid;
 }
 
 /**
@@ -5100,8 +5105,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
-	LSM_HOOK_INIT(current_getsecid_subj, smack_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmblob_subj, smack_current_getlsmblob_subj),
+	LSM_HOOK_INIT(task_getlsmblob_obj, smack_task_getlsmblob_obj),
 	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),
-- 
2.41.0


