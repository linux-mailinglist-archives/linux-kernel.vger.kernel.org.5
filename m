Return-Path: <linux-kernel+bounces-1789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A08153F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE641C247F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510A18EAC;
	Fri, 15 Dec 2023 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o6nK9tPX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE718ED6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680413; bh=2ItutyWCOqum5ggW8vKDaicqqW2B05naexATsg5BxIQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=o6nK9tPXZEDlhK1RQFmUfDBpU1FFmGVc5SqOuEt5ivSppKyjWRmLoj+Wnz4v/7Gqy2WrR7h9g+/6gxIV58lneIfy6sXDcZsKvq9K8tTj+Zw8J7s5U8ggUevdghiRy3LHh+rZmb73dtqCvHrAzbykQr9RyCvBu9b+ekf+gFe+tHVEiPfPYhQNCS5JXqiwNwZuM0GCaMBbEqIu6i6YB5QClOqylEtF1F2qi+nxPJ9q2SBZHv5kbfxgHOKA4KaLuIXp5Kbj8KH7RFx/ed15nPgF0eSZYy8Pss4tGAlgnZYBYHmdu4Lu51IoXGsAiHZ9RIPq9hCzVqLSK2ik4W4yXWsTEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680413; bh=q2MmQW1mPAbzMStPB9LmS+O7dSyQ31yTK+IfVeQq9Al=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=p/H/VYwqo3eF7m2bPDBhxmWOvDqbAyh36ugNyjiOi9bTixHqoO3Geu7UuMuLUxSdcQ5T48x1vJnr7CO0UaSr9hAuk0yhsuncyzx+SlU1sk9FnHlFp2MlVsRdTToeFajhtx8bip2PV2Y0bQNgUOV9MN/hOQObmDhfAD2+mWw2wvna+XBHME5uQDMJtzFeAMd7KgKuvsNBFjlbUwkjDGO/8RT9KIuGDJJD+82XfqtGOtpL6ugJSus1whTJ9o1Otuz6ScmH4rs1FUwLqeY3olc66NmqeiPYh/te+vVP0Sy6/nxFdhhLDxGTZU2iko3LZXh3U4rksa92Ean8h1TkB3xaWg==
X-YMail-OSG: LMx2RTsVM1l4HPMjS8coAPC.2n_3OKvu2Oy.C6C8n49wLINMG8Rs9hhUwe35Q3P
 GcnagTgAmNb48nb653IxjbkMGSmyeP97_YCHx0aa81zD6PyLI02dwmod2CictfTpisES6lcK6PWu
 FatSmZu2xgYha9KoyxscnecRtHJsxu68RvPNoC37BjENkn6WgsgIw.4MQ6y.fBQ6A1IRFbWzCeN8
 qnrepxtQfzN5UYybJpt8pymFEYwvj3KCreOxZ350jDDPNt1efQ1oDdopo8lHizhM.NP9Bmk14MxX
 vG9wpA0yK93aB8cr0kHutsik2qrloISYiA0isMKnqnvSgM8CmXdTbkOUA5XONcha3u78DMNK3LHc
 G9fG5CocNAKjBF0EXoFJZrTn_sFotAzsCSg8wyGt6eN6aEDs9IKpt3aE0S.4XOStcN3gBWF9XdVB
 IuHghgW0w0LPCScSdUu3vAPK4fV9Njuf97Kz38o5uvPEoBeRMevR2BfGLWzABu1IBt4TBKCq7Ex7
 yQE7vfNuac2M8sHZ8DS7gvd9mgttBCev7am5_zFy.WtD5_7x6vdB4ywX_CDiD2vPlSDlquPlCUMe
 T7NW1uyXxcBkM7nDE3rMMNkEZ.JtJhKN2EX3Xk2mwN2d2ACxmu1srat5vQmCQcV5.xFaxUGqEvlU
 PXcDTnUdDPsQ1j8uUK5RlgskIlua0F4UFihcsXylq2cCGxLQKGE1iMKACccTSv.GR_ZfpqifiLbM
 YnVeIgWcqGm8j0wy4ZXaD72fJ2JVnQrKgEScmJ1DEwAJX.G9i0PbuKZ9QhW9pGH_f0KE1mou7.ny
 lQthPfJyhgDMr3y9.5dF8qoOoSw1TWsCgIy3JWiNtc6pndhi1xrUadhAI867IvvRzN7b2a9h6ZxQ
 oU8WSfENeqXVWjd2sLJulP99NOIM.G4f1Zu.B8PVVMSwSeJMlj8a08Zv43TSn6jpM3FIVjw1.Y1V
 ZcEwmTWokF43.jUhh8_SvVMcQVIUe2dhP9pxfDCVjKD_VAC3_a_7pC2VblBfce2T_72r1EgR71vu
 x4KZFAg7kVyF.91grJILjj7f0ZWNkaS6R1h3LDemz.17rvCSp7RPRm.B28XKLJwQFYwRJyY3x_K5
 QsRp9T0Eh31YPDUL5j4VF2rHJia_Dgk.m4uIY5jG1XXK7P_6oR5BrZL2m0opF8WFqDd7ujWQL9b1
 .rgezKfgXz0y4zBwgLCEq6hsfORNmx4i0iPDlMe7obYx6gqgjTlLzwF290ow6T2TxHfa7JLPQrb6
 JkdUHhsbzmfhtFvoufk_GuhFZiUxzGnWug7r8mdP9nxyb4SXwuN6uERlHOUT2jgnR9N6Q8HO5j8b
 gqqzFWZ4MZADII5Fh55rYaI414eTxD2IldTcN3KSoDz0LVr0n0POzF9ZLZ03kmi_SsrVUTKE.6IJ
 MsofwFNXzZod5mmUxf5tOox4zFERBk4YI.DhkzM6_IYULLpQkZTVXq0nvgInW8POa_LVsIc.Jfmo
 jHUeQEPOeLO.JIF834jsS3xlW_kZQexRcR622saTRxDhqvSUGiTvf7hRFZ0Mg6IFsWMZuGIUtrps
 ulyqUyCO499RHeNb0T8K50zwDTMfkGnjSpd_Ci3IBCzbwH4sT.os1NmnnuNh7wZL67fTTsaHuH3z
 YP8YqSw5IVpLbo.nb3MJafRbbp3Xc.SnG3aH8e9MbAM0HKXsdQQy1Eslocb678ypKQROogqi2luU
 9BoQJ6sCck.BQbJSXAAX.N95F4r.9pE9ua5KjM1TjqD3tTX8dlc4OAsmsjulRal.Im0lOCo42G9W
 6naZ_hF2TxWbSZuj4gA33NO9ckebZyKqiWinLRs1q53NFBzdMsZeXoXXJahuREaqZy60UwwETDdq
 Rx9vuvEQMO.frT3ApOvwCNQhebEM4V9wYtA607Ew_exJQHePc6xhobkhN8eMG3F6dw2SlSw3maPS
 YSGL02LpqF0iF1HPM1SHVcR7NXtfzIqBycgTEnVGZtPvSlADOtxa_NvH.Sr7ERTLRBeVxp3YYVIb
 CYkem_y7_5JlM46YIkWTU0yuQl7njV4ghx4cTvJXW_7LHIzKSiWkC3.oRcDppv96IYn82p.O.9Wa
 7LvlXb6t2oGZaGMxmgYYfY4uBo3FEstsVK.giu9ar7Gq7GbwD12I16mQXEsfnwymjZp0nHD9sSQB
 CqRRuxCepmoNqMH839vpAr_jg2mMG3GKuVOe22x29zg2dlKoN9j7yv5kEBG6F4RDTAhsWbbvKbuR
 Huc4o7knfICdWxVdIHzulFHnh3IDtDgYofwhN79mdfv7Srkm99iNt7fwntO5WVmakQDL3DOUae2.
 _EzZh77zcb4FKPBudYxwJugCA2ayByg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0df4a50c-3bf3-44d5-aef7-5af268ef7bef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:46:53 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c8320ae1bddb7a2f7fa2be3a3860d99b;
          Fri, 15 Dec 2023 22:46:51 +0000 (UTC)
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
Subject: [PATCH v39 39/42] LSM: Remove lsmblob scaffolding
Date: Fri, 15 Dec 2023 14:16:33 -0800
Message-ID: <20231215221636.105680-40-casey@schaufler-ca.com>
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

Remove the scaffold member from the lsmblob. Remove the
remaining places it is being set.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h       |  6 ------
 security/apparmor/audit.c      |  6 +-----
 security/apparmor/lsm.c        |  4 ----
 security/apparmor/secid.c      |  6 +-----
 security/selinux/hooks.c       | 14 --------------
 security/selinux/ss/services.c |  4 ----
 security/smack/smack_lsm.c     | 33 ++++-----------------------------
 7 files changed, 6 insertions(+), 67 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 529671a89ce0..f7727bf767e5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -143,11 +143,6 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
-/* stacking scaffolding */
-struct lsmblob_scaffold {
-	u32 secid;
-};
-
 /*
  * A "security context" is the text representation of
  * the information used by LSMs.
@@ -168,7 +163,6 @@ struct lsmblob {
 	struct lsmblob_smack smack;
 	struct lsmblob_apparmor apparmor;
 	struct lsmblob_bpf bpf;
-	struct lsmblob_scaffold scaffold;
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 72c414d00ba6..d51ab2f1284f 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -279,11 +279,7 @@ int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule,
 	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_APPARMOR)
 		return 0;
 
-	/* stacking scaffolding */
-	if (!blob->apparmor.label && blob->scaffold.secid)
-		label = aa_secid_to_label(blob->scaffold.secid);
-	else
-		label = blob->apparmor.label;
+	label = blob->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d47816e91bd3..c31d5c008b14 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -984,8 +984,6 @@ static void apparmor_current_getlsmblob_subj(struct lsmblob *blob)
 	struct aa_label *label = __begin_current_label_crit_section();
 
 	blob->apparmor.label = label;
-	/* stacking scaffolding */
-	blob->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
@@ -995,8 +993,6 @@ static void apparmor_task_getlsmblob_obj(struct task_struct *p,
 	struct aa_label *label = aa_get_task_label(p);
 
 	blob->apparmor.label = label;
-	/* stacking scaffolding */
-	blob->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 1df08372bf1b..e5cfaedf1a9f 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -102,11 +102,7 @@ int apparmor_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 
 	AA_BUG(!seclen);
 
-	/* stacking scaffolding */
-	if (!blob->apparmor.label && blob->scaffold.secid)
-		label = aa_secid_to_label(blob->scaffold.secid);
-	else
-		label = blob->apparmor.label;
+	label = blob->apparmor.label;
 
 	if (!label)
 		return -EINVAL;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4ac4b536c568..113ee3df9b5a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3520,8 +3520,6 @@ static void selinux_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
 
 	blob->selinux.secid = isec->sid;
-	/* stacking scaffolding */
-	blob->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
@@ -4014,8 +4012,6 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 static void selinux_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
 {
 	blob->selinux.secid = cred_sid(c);
-	/* stacking scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 /*
@@ -4156,16 +4152,12 @@ static int selinux_task_getsid(struct task_struct *p)
 static void selinux_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	blob->selinux.secid = current_sid();
-	/* stacking scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static void selinux_task_getlsmblob_obj(struct task_struct *p,
 					struct lsmblob *blob)
 {
 	blob->selinux.secid = task_sid_obj(p);
-	/* stacking scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -6305,8 +6297,6 @@ static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	blob->selinux.secid = isec->sid;
-	/* stacking scaffolding */
-	blob->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -6609,10 +6599,6 @@ static int selinux_lsmblob_to_secctx(struct lsmblob *blob,
 	u32 seclen;
 	u32 ret;
 
-	/* stacking scaffolding */
-	if (!secid)
-		secid = blob->scaffold.secid;
-
 	if (cp) {
 		cp->id = LSM_ID_SELINUX;
 		ret = security_sid_to_context(secid, &cp->context, &cp->len);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index eef6655f7730..48211352345e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3656,10 +3656,6 @@ int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		goto out;
 	}
 
-	/* stacking scaffolding */
-	if (!blob->selinux.secid && blob->scaffold.secid)
-		blob->selinux.secid = blob->scaffold.secid;
-
 	ctxt = sidtab_search(policy->sidtab, blob->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 02b9aa200ad4..a486ac42caac 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1644,11 +1644,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_inode(inode);
-
-	blob->smack.skp = skp;
-	/* stacking scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_inode(inode);
 }
 
 /*
@@ -2156,8 +2152,6 @@ static void smack_cred_getlsmblob(const struct cred *cred,
 {
 	rcu_read_lock();
 	blob->smack.skp = smk_of_task(smack_cred(cred));
-	/* stacking scaffolding */
-	blob->scaffold.secid = blob->smack.skp->smk_secid;
 	rcu_read_unlock();
 }
 
@@ -2259,11 +2253,7 @@ static int smack_task_getsid(struct task_struct *p)
  */
 static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_current();
-
-	blob->smack.skp = skp;
-	/* stacking scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_current();
 }
 
 /**
@@ -2276,11 +2266,7 @@ static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 static void smack_task_getlsmblob_obj(struct task_struct *p,
 				      struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_task_struct_obj(p);
-
-	blob->smack.skp = skp;
-	/* stacking scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_task_struct_obj(p);
 }
 
 /**
@@ -3451,11 +3437,8 @@ static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
 				 struct lsmblob *blob)
 {
 	struct smack_known **iskpp = smack_ipc(ipp);
-	struct smack_known *iskp = *iskpp;
 
-	blob->smack.skp = iskp;
-	/* stacking scaffolding */
-	blob->scaffold.secid = iskp->smk_secid;
+	blob->smack.skp = *iskpp;
 }
 
 /**
@@ -4796,10 +4779,6 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	/* stacking scaffolding */
-	if (!skp && blob->scaffold.secid)
-		skp = smack_from_secid(blob->scaffold.secid);
-
 	/*
 	 * No need to do string comparisons. If a match occurs,
 	 * both pointers will point to the same smack_known
@@ -4862,10 +4841,6 @@ static int smack_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 	struct smack_known *skp = blob->smack.skp;
 	int len;
 
-	/* stacking scaffolding */
-	if (!skp && blob->scaffold.secid)
-		skp = smack_from_secid(blob->scaffold.secid);
-
 	len = strlen(skp->smk_known);
 
 	if (cp) {
-- 
2.41.0


