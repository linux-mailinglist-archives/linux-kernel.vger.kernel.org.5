Return-Path: <linux-kernel+bounces-1743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C081536E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899F1B23E97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F718ED2;
	Fri, 15 Dec 2023 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hTnkUEkj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF618EAC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678799; bh=PTIMd+egNKmt7pb1HPXpAuOoq8vFOuUgx1vm0aUiDzI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hTnkUEkj18EyV6z1Xnc1tLqdXqDTJNRptD3oHrf0i/lPUip2fiYgfBsMWzqjurHHSq+JSJhvO8Q7cznP4gSPf7Bs8LOWWo1JQUpWREerPHeaml3U4HF5HZsVxjVIicRfEyGHScr86ymNiHB7uxZHsK+Ps0oDZsKwPhcpaSUp2QY4aqEHFbyGRN/EGFZNI3wxHOGeLRlPIxY5M0jC8duaYvN/y+3XTowrUK4qHg6uYqP/60zMTVicIeUROOjqQWHZpR9rU8rEFHPFPxRpiIHmqzZv47/o3PbblU/EUX1isxA9lj0R1nrDlE9pxZB5FkURBtu9KgJ4xemQz4jg7vqfXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678799; bh=hV/pZR27iBooGLF539XutgsypFvYkVA8nGKEUbz4S91=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qtrqBqn66M5c2Ly1isBSIPwYP6MMUlq2i/JAM2Jv4PJtiAoMyqWkkoIYFlVWFhLkGjSAhbJCJh7uI7Ylm6wQjTYdUZTziJMX6ITefGq9H97hOIaNMLWWNn93P8vzOtuOS/kmRHd/U+pMAopSajDFIZdubjXj2wrvOiNrg4Dp1Gya0uJhQWjnUP708hahEITXQHug5ELNS1U9A+KZWQ+tC/c6BIHTK9+AP+dzjKXi99PXONzvexiraeBouBWzFXUnIyyv+HleLzv9wYOEJALNK9m+6FQvZZKEmYXju65R0I94407tmRtVxcGilYOUxg4I884dTEqbANQZEDPoL5L0Dg==
X-YMail-OSG: 4QAj2FwVM1lommx4rdIU9JNyciqzLySONrfykdnGjujlATa6JO.WG0c.gplS2Xr
 OHrNZ3Ae8RvSJxT2jcMBf35CTFbuphDmPJRedYw2XzPkeVPcrSdjfPKdWGErcIai3HyxySXuUH3I
 VMKc2ms3gcjO6xhaRA1C7kHce3C5DebM8sYhB6wUe7nEkF1K8JHD2yfKi563EVBE.JLw8DfNu4tO
 LPZL0J58plS_HSPIgR65jxdJVp_uZk6vB1fOTJWjAouhOlp3tGnk6cbu2bU7cbYKp3ooZ9vzgPGk
 rp.MOzKOSXRWFGAC5Xo1M6.sp9KUtYEh7k1SH5.3Jys4oHlkd7cwtEltIF4Hu.F3VZjCExNHvAGS
 I3aEwP4dugL7NI2ujSt.GwxtW_w6qybVDi7XZBty5zkbTBBSSSn4e0_EAVNTU0i3IE3LswDg0nuY
 DazVh0zWkr5ZC103b_jNX0wporJYFBR35enF0mTsjvGoTMoBuZ7rg8GcUP3_zfjyFpKoVe98_eMr
 JSFyboZUgbe7LAZN2b2BPw8v8YodgaIJQorPT.Vc7lK_MatGcBk6DYJyFA4epdto9GBXl0.hP619
 Hg6_ge.SSTYESxtwMIGx23pj90OvA68VMoTVh9ejHpI5RF74VrtoGHRelZP8glpdsqOSnDYt5FGA
 8Kmiplu.RB7KhylwJgITlRSeWGDOAlIQoYZn8d1nc14PYEe9HrBxTy4iVUA.6oRWUnJ5r6mnl.kG
 MiO.899uIfzEKTVpifpzYtEhVuUGttaIct8aBrPND715AdZkILh5EzJ3YX5xoILWY1HgxgQ0iCGY
 L00JPnQtho_gfOoBX8FZZvthlHyrLkGIgRZUy4ZQZFCnQVLBykhj4nuGgJvpjhUVXAQ9kpAPnJfF
 6ejItIUuvrXTTqnFuuvFotcNmRLewB_FzVTVdq9F5_mYDMOtSxHrACRlMUmjA6TtJwmaB7r16oXm
 R4lVvCCvLlMc_ysTXq_XFrrTBofmbupyptmEwJxDwD2LAncipHiivuXr4Ew_j8hc5QWtCXmB2FFq
 9Vi_YKJhBtIcCJ5Gwnw3Tl4KdqVJKrNztNO7MvIRl0Ycvx3R8wzoqEP6NLEHAKu7psXUX8Ag09yE
 pYicFyhOmJJhnEs40FDlJCFCTUlfXwglxllVmbk.o.T.ZJScx.nDmaJvFthiqrqv3lG8u1tk.8s1
 eCU_R37aSeHQSMwh9iFh_bT1KkTZwOtv30tUhct4oybsSyxHEsRdfBXOrOxhMy2qmBGBJeFTYEBO
 nrMRl6dfHAXD2xQzeOQSSEblk8PGh_a93KhNC6RQjg0FzEh9U0LQpFj74N6j6vnXWQB7DEVrbPkf
 v2u78JAjymEv2HINRAS1sh8jWuaieohGAijWFbr9FZYNKKjA_mvzWgErZj9vmAE1kfIXxQBBn.iU
 ZPzx5..Ig2CnI8zfPoPWz0VU1kW2BJYWuMxrxKq_AugcSEYjW.vTFduX7M3u3eFvNpxvTpzNyu0g
 oXpMpo9qEM8J0hv6RdKxxFRN34zTqPdCbd71tQsGW_cidxQ0aJ36sEbvNvERK6Qz_mdfFKrvpK_r
 ogeKjP9IH0MPPX2ctTMTDY426udF_yH2q2K7vex2tA0KlPHiKb28P_bdR0nkV30peJLmRPincYsN
 LHSGd1b2QfBpPlICS.FHxt1_xdxGPNJlk_pDclrUsitznwqKuKwwBwv7.NYqu_xDETkbZm5nvmgT
 7OAjmYqLl0G_EP.vRgTxJeEkmfitsqyiAXmLCMYwa3Stx.y8fZYHPEfbV3cN5v4VBQQW5c2fh0f.
 LwF6OwvryVxbe2EN_A5eI3Z7xELOkc03lpLgkgF3o25H.H_weaFJTX5VWxcWu8ayuBvf6hIIIm5k
 p_S0ts3knYAmYGC83XL2KQsSNlZ.C4zPA8Q.V4tJMmkFuVWyq3p1zDQT1PNC1mLi4yI2D5aFt_RY
 bHwVCb1D7DVdYI1bo_9hcf2aN6QC7LrUFKB67eiX8l0e9cziwbeJZwPjTCSboDerkSM4W5YH1AHL
 LD0Hrywrgdc_jICZ3HFi9QtWKGtpE1izq16G9CFn7nRob81A.WjUf5N5zTzXd1M2XTJvuK9YPYMP
 VAqHSfoxO8QSrXUah.NR0GBRLOBBonfeWZ.eUC_MnaBuICtfiMBkxscWgy6Bkdj3Ruxtzg.UnvWE
 AupHduPf.rRi3UvcDrWqnbl.7QZo269FkDSJX.5JnCTtiW.PIGq00Hv2bOYhFtBe2BaMOntjwZ2g
 9a3iRsqMKG6_NU4vgFwCMf1icJbwYRG31GgJiiiJr2puRU2xJk4KhnCCZNj3GlK.mJKRlTbbD.XF
 eg0pT3TZeNy92Ys_Pe0WA
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1aad6597-2ff4-4b0b-9299-7f93af5445b2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:19:59 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 015b8086b2cbbee47da79b085b628701;
          Fri, 15 Dec 2023 22:19:54 +0000 (UTC)
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
	linux-audit@redhat.com
Subject: [PATCH v39 05/42] LSM: Use lsmblob in security_audit_rule_match
Date: Fri, 15 Dec 2023 14:15:59 -0800
Message-ID: <20231215221636.105680-6-casey@schaufler-ca.com>
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

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Cc: linux-audit@redhat.com
---
 include/linux/lsm_hook_defs.h       |  4 ++--
 include/linux/security.h            | 13 +++++++------
 kernel/auditfilter.c                | 10 +++++++---
 kernel/auditsc.c                    | 18 ++++++++++++++----
 security/apparmor/audit.c           | 10 ++++++++--
 security/apparmor/include/audit.h   |  3 ++-
 security/integrity/ima/ima_policy.c | 11 +++++++----
 security/security.c                 | 12 ++++++------
 security/selinux/include/audit.h    |  5 +++--
 security/selinux/ss/services.c      | 11 ++++++++---
 security/smack/smack_lsm.c          | 12 ++++++++----
 11 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2159013890aa..24c588b87412 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -394,8 +394,8 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule, int lsmid)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule,
-	 int lsmid)
+LSM_HOOK(int, 0, audit_rule_match, struct lsmblob *blob, u32 field, u32 op,
+	 void *lsmrule, int lsmid)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule, int lsmid)
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 2320ed78c4de..6ded4f04f117 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2013,7 +2013,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -2029,8 +2030,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
@@ -2044,8 +2045,8 @@ static inline void security_audit_rule_free(void *lsmrule)
 #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
 int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			 int lsmid);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmid);
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmid);
 void ima_filter_rule_free(void *lsmrule, int lsmid);
 
 #else
@@ -2056,7 +2057,7 @@ static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return 0;
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
 					void *lsmrule, int lsmid)
 {
 	return 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 8317a37dea0b..0a6a1c4c3507 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1338,6 +1338,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob = { };
 			pid_t pid;
 			u32 sid;
 
@@ -1369,9 +1370,12 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_current_getsecid_subj(&sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					/* stacking scaffolding */
+					security_current_getsecid_subj(
+							&blob.scaffold.secid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
+						   f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..fb001300f0c2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -471,6 +471,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob = { };
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -681,7 +682,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				/* stacking scaffolding */
+				blob.scaffold.secid = sid;
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -696,15 +700,19 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					/* stacking scaffolding */
+					blob.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						/* stacking scaffolding */
+						blob.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -716,7 +724,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				/* stacking scaffolding */
+				blob.scaffold.secid = ctx->ipc.osid;
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 0a9f0019355a..72c414d00ba6 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -269,7 +269,8 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid)
+int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule,
+			int lsmid)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
@@ -277,7 +278,12 @@ int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid)
 
 	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_APPARMOR)
 		return 0;
-	label = aa_secid_to_label(sid);
+
+	/* stacking scaffolding */
+	if (!blob->apparmor.label && blob->scaffold.secid)
+		label = aa_secid_to_label(blob->scaffold.secid);
+	else
+		label = blob->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index a75c45dd059f..ae3fc4089b00 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -203,6 +203,7 @@ void aa_audit_rule_free(void *vrule, int lsmid);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 		       int lsmid);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid);
+int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule,
+			int lsmid);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a563e0478cc6..d24205aa1beb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -657,7 +657,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob blob = { };
 
 		if (!lsm_rule->lsm[i].rule) {
 			if (!lsm_rule->lsm[i].args_p)
@@ -671,8 +671,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
+			/* stacking scaffolding */
+			security_inode_getsecid(inode, &blob.scaffold.secid);
+			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule,
 						   lsm_rule->lsm[i].lsm_id);
@@ -680,7 +681,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
+			/* stacking scaffolding */
+			blob.scaffold.secid = secid;
+			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule,
 						   lsm_rule->lsm[i].lsm_id);
diff --git a/security/security.c b/security/security.c
index cdf9ee12b064..b3d150b6248e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5408,7 +5408,7 @@ void security_audit_rule_free(void *lsmrule)
 
 /**
  * security_audit_rule_match() - Check if a label matches an audit rule
- * @secid: security label
+ * @lsmblob: security label
  * @field: LSM audit field
  * @op: matching operator
  * @lsmrule: audit rule
@@ -5419,9 +5419,9 @@ void security_audit_rule_free(void *lsmrule)
  * Return: Returns 1 if secid matches the rule, 0 if it does not, -ERRNO on
  *         failure.
  */
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
+	return call_int_hook(audit_rule_match, 0, blob, field, op, lsmrule,
 			     LSM_ID_UNDEF);
 }
 #endif /* CONFIG_AUDIT */
@@ -5443,10 +5443,10 @@ void ima_filter_rule_free(void *lsmrule, int lsmid)
 	call_void_hook(audit_rule_free, lsmrule, lsmid);
 }
 
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmid)
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmid)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
+	return call_int_hook(audit_rule_match, 0, blob, field, op, lsmrule,
 			     lsmid);
 }
 #endif /* CONFIG_IMA_LSM_RULES */
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 59468baf0c91..61a396c9d9ae 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -42,7 +42,7 @@ void selinux_audit_rule_free(void *rule, int lsmid);
 
 /**
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
+ *	@blob: includes the context ID to check
  *	@field: the field this rule refers to
  *	@op: the operator the rule uses
  *	@rule: pointer to the audit rule to check against
@@ -51,7 +51,8 @@ void selinux_audit_rule_free(void *rule, int lsmid);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule, int lsmid);
+int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			     void *rule, int lsmid);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a9fe8d85acae..eef6655f7730 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3627,7 +3627,8 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid)
+int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			     void *vrule, int lsmid)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3655,10 +3656,14 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid)
 		goto out;
 	}
 
-	ctxt = sidtab_search(policy->sidtab, sid);
+	/* stacking scaffolding */
+	if (!blob->selinux.secid && blob->scaffold.secid)
+		blob->selinux.secid = blob->scaffold.secid;
+
+	ctxt = sidtab_search(policy->sidtab, blob->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
-			  sid);
+			  blob->selinux.secid);
 		match = -ENOENT;
 		goto out;
 	}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4342947f51d8..9851d56dff69 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4726,7 +4726,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @blob: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4735,8 +4735,8 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
-				  int lsmid)
+static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+				  void *vrule, int lsmid)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4751,7 +4751,11 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	skp = smack_from_secid(secid);
+	/* stacking scaffolding */
+	if (!blob->smack.skp && blob->scaffold.secid)
+		skp = smack_from_secid(blob->scaffold.secid);
+	else
+		skp = blob->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
-- 
2.41.0


