Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88F78B90A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjH1UDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjH1UDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:03:22 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD0E1A1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252988; bh=aU7TbA4srC4O/mkH7MA73Us9gBHIFBXBeNrnqlHFtaA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l3+IRFMaghBexZF76IbrJQr76uSCg/KxTKeEYDa7OqVZcIScTm5bIPzXS/rm/6VWZDmRaahaPii7QaWsC6oXTa0M4YR2saO5HvojMcdy7CWMPYw0OZ3wtn5niXzy1REVM19RJUOCvUocN07DqelgBz/IKHbzq5kAm3e52cIho6due3SZgh/jo4UfpPzwNp5YI7mc7vQun5MDk7ZfZt5M2iOT//U7CFNrnN/jhC2DkuR4tykz8fL1a3YVXP3C80OAFvxzPz539njlh4ZOxTNuPy2I6uVVVbNBPKmlmHHm6dfW88hXvZrSsjrkaiHLxjR8E7BaCgKwpMLcY1qrBDRH7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252988; bh=7pdxPlHpS27mhZoYwt1KeWP1wvKoXCR9ugMpV2p+XOm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RLUydUFXmaymybpKwkvvKhnc0wGZz/gJuGhl5S2m/iqGOWlOk12ToJqW3slJUb2nvgVFR8fKFiSPE+EnEsrMwnY/ucJ6I7K/g7gR8Q162qCThFOYBXXnHcaKiwcRAk7jia4hYRlNmoqHSnjw08brKERt198rgWosvRg2GlCHcVn7dR65eYgg+z2q1kvvGB0OU6JoxbNrDUIP7MOXC8YXRA0GVmgqaBGtCcxAJ8sT8Mqk13uRA+lHMqqr4oJA4ckrwi0fruS4vFxommLwHsKcgNZOeLwxDb4iAzpY+gBu6gQAx0k6IPm8+Icd5lg3bEHmyBFX8p6dslPnYn/EIGJSgQ==
X-YMail-OSG: qU9bn3sVM1mWM4c1_pp3hxTgKFbXFVa3OYxEiiEGMo8gZBPriOthI79A5FZdqW9
 Pyx84brBHMsg4fvAc5IRpd4lioLT_BopO3kegjSx7UXa5YQ6k.xAMHyYW7DOujFoVonkEgtxeCXX
 vzmH_K1Rzek8f26ewggju2MqXwr9w6XRLMhVWer8HWPcMfCQ4it7wGrf.GhgNLEOMmQBX6hEqTRM
 9z5STrvWnt9vH5rAagno.08cS_RB5avOs2erpyPZlfpgz_8L2L5m9rP5l7aQGItkcAVP0V4CJNhu
 zcyDhztHDUBBDrxvjl.M8kqHcavYFeo28IszdOdijBVX8CMQf_6UQ5M8U3hdOWIjG.KsEnMyHJSa
 zDt_U.OPX4ctnvd278KWR15FzWTZhnMVqILPOn3pIbj3PQVPfYbO2zU71cZFpOtu32GIxu8tap0V
 kbM5JJ0XFgwlLiFQZiYWzRaVgN4Z5y7P_YYVBOaHLVQYHK2rVxwfY2LRjtjt95O521VJRAerge6T
 wseaeciWiQYRC_0kibt_RqKlp9RLbZrRIPIKot_gE3W8uRzRVgRoIyV81QVbtchuGGKtanSA.UyA
 2oxjQuCbC0r.GaZ6ElRfZ2uLBpu5QG2l2_PM3BcAbQJPA7skADimrlS34BbCe3ussFVda7WfNRDo
 SIPFGSPlfzxtes6sJ.RPvRgP3I2utVdxQkuIQKw7XpsqJqJaaGH6HpYuNDZ.rTkVg35TDCBdWKLz
 nPI4xGzjR1xSPm8YKL3DHd9rKHWwQlIa9MVyyO3r0k2IXW2gcBdruI2kn0X3Inc6txE0.wFx4gOh
 BT1vQ63hVFgTj4IwyelpUypjQQS7qNk1cH6QVmynMOJFHnZ6KfEm4nnigb.QjnuIwSB9GTrroDN8
 Y3qSQHyb9X3E0JX6QXRd5rxSR_sTvK_ecy2vbU_wlKi2KMZwlZlC202yO7V57FJzA0nvY3I5rSqa
 wJhJjC56mEQ_dByybSI2P8LSokvfFiVJArZS6lhSnVZ4Q_.Vfl8uMcQppEkXcLv7jiZnKwF7wiZk
 feik6X1_ZydMo7Yc.wNFOU6Bn00LU9PKb3P8EHVwX57D0H0ooIpZQYsEMukIWvxjpZclPm.oHuL9
 PEPf0iDtdUrrXmeOTQ9Iyh1f0h.b9Fn9ytwRj_JPfYrWWHLZVftvsJp0WnCywBmaNdj1Z6rufGn_
 7EPSvpUenjU9YUosxBYzui1_WAp_mVsKzp8T6K4kj6gu1EeJtrBl2jmJWTKpHCQq_3gdaReG5bW7
 VIaMdFA_JbNEcEmN_JNkcvcFGo1ecGg6ZMchLB3V62NSFHGcxI5mX.aKLq.7RUstwGLV7_9p5cOW
 hOI9r2JVceT9MEhswlBP71Bf9Q2J1KY8A1gMNKeOlroEwv4W8AumibgQzUmBgcbbpOulMwSYmYza
 LzoY9eaDfthUziHuQCJaY08iJQr4LJ3HKWD8elFv6bFs7_2EKrumKIvw6e28eF7Q6tz2mTN.UfOE
 9xViVGdV.v77oIZkYql0tZnZLX.d4SqWNtrw0A3tdJTluDsAOuubOTcrqC4AnORFq0ko93CZoBQ7
 tQ5vASEM_M9xlOS1CHQVbXHgK3xY9lqtIhI04gbSdMpA5HDw.iz3BiBSaRAc29h4O12h.cRmcygR
 qHS970cB70KUIXaIyZuJ9kPgx4YdFUjQIJfi.s4aV.P3unlq47Yue6xuur.GOaMAdxjKycQKVAi2
 0X6MEDTB4v477GNJusgTW_OcB2KntZCmVv_m3Fl4EKQ.8vIUjky3Cx89YVUaEGKhOApx.rBBopkK
 LostXR65zhkpMzE8Pa60rNaG4Jeq3WiNgTXXKm0jWj.uA1jpfpgLbdVWSU_w_0xjd2JEezI3gcUZ
 6qqBCwLDWtjf5Jml7JC07HAwcv5T_0x9G_FF8UboghPwQekZcsy9J..GElsbm819JcJQ07azQVQG
 4USlU._lkBqf6L0Gp61sXeW4TtuVqgdEpEaudW1BKb6R_UfQVxaEkvz_6_qB1QY.p1hbijqqUQjz
 AHum6HGWDaXQtWc9ZL0byD4lvv8VG8MXozp76zjNLc1mCsHF5l5CV5CLnoCDG6fhJleYvlDd7RbH
 F8hnEfTlqK95DqDJ0HbVSnYPuxMcfEUx6X9JzFfZhpkN1oEFXcHReUn873fMHLiTTtcY.7qfr5oL
 FTOCq5soZVeFF88gq3GG.Xb6UlbVi00.gyAPhkzZbAwlzzdFr.1086uR9QAzyaSly5oxmTZbUxZ_
 N3wGXl1uNUx4eRXhIjOwirII7LPdDT2DRIYG_PR0qM.e1Vg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1d27e4a5-13d1-4dd4-a0b5-ebcb7f6da7c4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 20:03:08 +0000
Received: by hermes--production-gq1-6b7c87dcf5-6x8bf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29138cd0d16732a579d2f4720912c9a5;
          Mon, 28 Aug 2023 20:03:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 09/11] AppArmor: Add selfattr hooks
Date:   Mon, 28 Aug 2023 12:57:59 -0700
Message-ID: <20230828195802.135055-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              | 91 ++++++++++++++++++++++++++--
 security/apparmor/procattr.c         | 10 +--
 3 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6ff020ff3fcb..0f77ce0a59dd 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -630,6 +630,55 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 	return error;
 }
 
+static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
+				size_t *size, u32 flags)
+{
+	int error = -ENOENT;
+	struct aa_task_ctx *ctx = task_ctx(current);
+	struct aa_label *label = NULL;
+	size_t total_len = 0;
+	char *value;
+
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
+		label = aa_get_newest_label(cred_label(current_cred()));
+		break;
+	case LSM_ATTR_PREV:
+		if (ctx->previous)
+			label = aa_get_newest_label(ctx->previous);
+		break;
+	case LSM_ATTR_EXEC:
+		if (ctx->onexec)
+			label = aa_get_newest_label(ctx->onexec);
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
+
+	if (label) {
+		error = aa_getprocattr(label, &value, false);
+		if (error > 0) {
+			total_len = ALIGN(struct_size(lx, ctx, error), 8);
+			if (total_len > *size)
+				error = -E2BIG;
+			else if (lx)
+				error = lsm_fill_user_ctx(lx, value, error,
+							  LSM_ID_APPARMOR, 0);
+			else
+				error = 1;
+		}
+		kfree(value);
+	}
+
+	aa_put_label(label);
+
+	*size = total_len;
+	if (error < 0)
+		return error;
+	return 1;
+}
+
 static int apparmor_getprocattr(struct task_struct *task, const char *name,
 				char **value)
 {
@@ -649,7 +698,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, true);
 
 	aa_put_label(label);
 	put_cred(cred);
@@ -657,8 +706,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 	return error;
 }
 
-static int apparmor_setprocattr(const char *name, void *value,
-				size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	char *command, *largs = NULL, *args = value;
 	size_t arg_size;
@@ -689,7 +737,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 		goto out;
 
 	arg_size = size - (args - (largs ? largs : (char *) value));
-	if (strcmp(name, "current") == 0) {
+	if (attr == LSM_ATTR_CURRENT) {
 		if (strcmp(command, "changehat") == 0) {
 			error = aa_setprocattr_changehat(args, arg_size,
 							 AA_CHANGE_NOFLAGS);
@@ -704,7 +752,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 			error = aa_change_profile(args, AA_CHANGE_STACK);
 		} else
 			goto fail;
-	} else if (strcmp(name, "exec") == 0) {
+	} else if (attr == LSM_ATTR_EXEC) {
 		if (strcmp(command, "exec") == 0)
 			error = aa_change_profile(args, AA_CHANGE_ONEXEC);
 		else if (strcmp(command, "stack") == 0)
@@ -724,13 +772,42 @@ static int apparmor_setprocattr(const char *name, void *value,
 
 fail:
 	aad(&sa)->label = begin_current_label_crit_section();
-	aad(&sa)->info = name;
+	if (attr == LSM_ATTR_CURRENT)
+		aad(&sa)->info = "current";
+	else if (attr == LSM_ATTR_EXEC)
+		aad(&sa)->info = "exec";
+	else
+		aad(&sa)->info = "invalid";
 	aad(&sa)->error = error = -EINVAL;
 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
 	end_current_label_crit_section(aad(&sa)->label);
 	goto out;
 }
 
+static int apparmor_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
+				size_t size, u32 flags)
+{
+	int rc;
+
+	if (attr != LSM_ATTR_CURRENT && attr != LSM_ATTR_EXEC)
+		return -EOPNOTSUPP;
+
+	rc = do_setattr(attr, ctx->ctx, ctx->ctx_len);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+static int apparmor_setprocattr(const char *name, void *value,
+				size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 /**
  * apparmor_bprm_committing_creds - do task cleanup on committing new creds
  * @bprm: binprm for the exec  (NOT NULL)
@@ -1253,6 +1330,8 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
 	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
 
+	LSM_HOOK_INIT(getselfattr, apparmor_getselfattr),
+	LSM_HOOK_INIT(setselfattr, apparmor_setselfattr),
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index 197d41f9c32b..e3857e3d7c6c 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the label information for @label
  * @label: the label to print label info about  (NOT NULL)
  * @string: Returns - string containing the label info (NOT NULL)
+ * @newline: indicates that a newline should be added
  *
  * Requires: label != NULL && string != NULL
  *
@@ -27,7 +28,7 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
@@ -57,11 +58,12 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline)
+		(*string)[len++] = '\n';
+	(*string)[len] = 0;
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
-- 
2.41.0

