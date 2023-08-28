Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71DA78B908
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjH1UDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjH1UDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:03:24 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FAA1AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252991; bh=up/aA7/QNfJGLVpclvQeY9aOOs+lf7Mo3aokP1R6FkY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gSAy572FTfDr7GfVeQFgFjB1lx0IYFXlpkiuqTh6DIbLu/J0ThGu756noPQKMIXIetayfPnarUZ3lv5sxKtxRilj/GDKTawlhZXqs3gwi8pjOjhcl/iAO2EwrFI/yJluWeklDd7viwRUuZCPFvO32txXNhcqCnMjdF7JOE4e8FjYJqqHnjXr+rRDycV9heGWJ6tThuyoZCLrICPWJLi4dsb5xvT0I/CCLf1JXez1LfEw/Db9BJ6ySfApoM+xdWF/lRldrOHWpbHfLRgw8fZlHaq0v8MGb4WSDiljNqIwYoaMAtUt8VY1ZsOZbcKKU9lkI25JjX2iJhUlG6KRnhMevw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252991; bh=5Uys4xcrkWcUJ+jzrbRey5oSUeQJFk0DjjzonVrl11y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bCa+ynLRdw/15lKl/4Y+4xu8p6YeP+g82ZCiBfx6rf9DuLAWG1eSdra9BEUvWF0DFmh9MyNkU7F++4GEYA37jxA0THscwPg7U0RMkDTeDlDUWcNQq4WQZssHh9d9OTanqHX3+gy0q7WjBwNpcCTIOxxQXckOksQw5G/dQsR3OqnTcW5abcz2vASmiaLY6vBydYKfgezo5K0qaXbuKFq+ndLk5Gp/AaXLjGKXYUV4eAG0VX/XygKKMJ8nWBeE+HS6haepjjkNrn39pvMeZ2ypA8lO06v0/P4xxx4jWPSnAvU6ZFH4+V6EaHXBgyKa4H7+CjvazfEShKZLdWsdMR+fSQ==
X-YMail-OSG: 9sJOiAQVM1m9INDAdDKTLB1ydO.5XYpJU5VTEKKPBzRRhD8A6SoFwkuDKT3F1lW
 vcyl1AVZJsy.hGmqdYIGYaDJFZROzZ6AaW6Lm_gij1JH1GoZHW5L2AcUeiQ0SGPepTJ6RB5QA.wz
 ahH6fExifbof6CHthZQEE6TyK.STDSS4vmRYIZCl6ZZ.U2GndDAeGCthYd__j_a8COzSG_TrcGaV
 xtGjxrhy8IG78wTddaK8ZM8f2e6qAHWF.X1aKaf..J7K8vEG1IivZsTIPkSXis4MvEK3Cloj9MOy
 7lqNo17vfiDE3wPX83GIbtJVFbVx2L6HLwdOW50U.kFceCzM8Z.mVHNXEFp6kP89W0N_dEWKZx7W
 E2beuEdFA4ib7G0Mejx5hnlIzl3Sw0ejuVnay4KNg_9XZxR95Ui_JNxWaYEAc_v2Yu.ZsBnFkbm3
 _JCfQXx.R2sDGT3.yU9i.59wuoz0D3c11muRfz9jho.ZBPaqcmasuVkE5u0.4pS.C.yzJ0RFyXJs
 yweqp7naptUE6uiyoHbo2xSHI6Fn7jx5313kA_5RFDUskPlygktY8RRueZ_LeGC5Or_Og34SzBpN
 FSAXlcZcCOBftvhmfK1E3pe2AwXT66Nod.dFVU4EZld.p5k52DAsAzVMMIU88OlhT6iTyjxQ5QJm
 XW0sitgorLwd5azuwSklbW7ouzZ.5zlHSS5AE63tbxbcL1H0JsuXfQ7.eHwwNEqjqPL4Qq7ToMkJ
 UOLf9EHSpfUo0LpurS64YYS_B.JLVImO7LlLLffxkUn.pQI79xpAkRj45B30O2B.pIHOHuFM0VGE
 s7H.U7DgTEsqwXx8jb1rLVIY_C9K2I7YCjb1faaGe4uMORHTjKeokk8T0Y6Obm3EgaqbKvHNF.xJ
 0Kg8eTjsK0f2m09sltIzfddZLSiG5FS7Wb2Zyvjrd2BE13fz1UWcjqtsF3IKJehZLEmJgSCJU7fR
 Wc7nwC_tyrQhccMwHJMMpTeSuMAfhOBycEkWWPyB87volv.txGpGf.do3vAEJkkB.XX.T0P9s8pn
 SH0Hg8Q1gCCU5BZ_buTOuCucwUaG.hebvbi_SJ7nBHyZ4bitBd9qboyWU.qUC7Ey5hZfrmytAiP2
 cqDqUEkWkCWpjGzEm9kVquE1D7EzT7bPN5HyOXlv7XsF4MmF3lud9Pxf0wQwke4aHYpj2Bu.X6mU
 WhCsETfhvQhaO2KMREoZfI6Ut4cFyCN9IjCnYHqCk1rbi0khPXgnsjH.e8xA_gFhFHFLMAkpXVnr
 CmDGeUOkgT0osalgHFlfnrMHurE8jJnv74eIdictMUlWt_oQ61z4fXnfdPsa5Pa71KxtIm519BI3
 4Z6lzDicnSdpgJpO8ckiN4zd13YMMSs74CvxKjINmkN_k0xH4tPTW058spDS8Olx6XBd7kA5xCmP
 WBb6VpX3HObmxPFW5XQWUGBnX8Bgl.VBBaeK7nJ.l1iC9ZwvQeFmxuo7NwCSozEB2ElZlZLMT0XC
 K3bL51EUkPBn0DHjua.hyahuTb6mMW_EH2y6JRv4jeD.kGW7XxcZ1yaj56835HAG6MEd4pFdn_47
 YGBhTSOHIg8PsRw1DK_nsIorhNVsRPkSIppFsH6amBAMSqDWaGX.hsCiFj0k22Hwe.CKEcHmzW0E
 9YvG96y3uakZCla4ZQDmoRNvFWQLEtWLqTS9.gCpuGdm9wFgggYuBaQAxO.RrnUN7XMDequnmddq
 4OOWWP.mqSplI63eGO7ThGUMqTRe89VeR3KuHxqHtkeG9R7qjMJLeSvTdHEhOwNozm395Pz91VbI
 N2ZxQYqZS7uYHM_Yz0FtOyKl1nzfH0aSvuHcjptbYfPBkwt_LZW5DNeK2ICv64AQpAbvCvEaWOBs
 VBtyuoJMHDA4Fk7v55rJvUmPObpOclQ5W__zONSyQ3CdssQVdClXXvk05gnjpvwNQ0q4Gm30ztfR
 TmkN9.SbDjozTQNWpBNnhVQEHq.2zw2gkDa4GiVujtfO1Uo8fP0.uTW5faccVDC6.Zvur0nBEfxh
 mWxsD6lWDrWxr1wz.CO17tCasPz1lS6hZIO9.swQK.H1j90Hfp2sSq272wOizRGpqLXy6IijAHBS
 IyaSI9fZG4bbWhlIghNrnVqGVv5E6Mfz.L_PNJjGaFcxEROxIZe6aNP1lLftMo5qftNhfKN_bAyH
 kCi8XGXxAHp1tXbmhOD1cYne3Z3HEAHkWo0N_CWbfhTaBTy7N3z6EyUO6rtCdQTvT.n3NhflmiJj
 7oNQdJOpDDAG5wRbqy5XmOjqrC1LmJ8TR_FkSAGFsI4EmW7kHctMt5fB4ZmGvCPhwjOVnHqRQubW
 7LMXm40DG.8.H4R.H.8Z2BE4lnuqD
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f9a0cff6-2dda-4811-a3f3-093bc8258692
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 20:03:11 +0000
Received: by hermes--production-gq1-6b7c87dcf5-6x8bf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29138cd0d16732a579d2f4720912c9a5;
          Mon, 28 Aug 2023 20:03:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v14 10/11] SELinux: Add selfattr hooks
Date:   Mon, 28 Aug 2023 12:58:00 -0700
Message-ID: <20230828195802.135055-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 134 +++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 27 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 931348c79cde..97de4e7c46bf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6265,8 +6265,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
+			       char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6283,20 +6283,27 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
 		sid = __tsec->sid;
-	else if (!strcmp(name, "prev"))
+		break;
+	case LSM_ATTR_PREV:
 		sid = __tsec->osid;
-	else if (!strcmp(name, "exec"))
+		break;
+	case LSM_ATTR_EXEC:
 		sid = __tsec->exec_sid;
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		sid = __tsec->create_sid;
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		sid = __tsec->keycreate_sid;
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		sid = __tsec->sockcreate_sid;
-	else {
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
 		goto bad;
 	}
 	rcu_read_unlock();
@@ -6314,7 +6321,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6325,23 +6332,31 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
-	if (!strcmp(name, "exec"))
+	switch (attr) {
+	case LSM_ATTR_EXEC:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
-	else if (!strcmp(name, "current"))
+		break;
+	case LSM_ATTR_CURRENT:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
-	else
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
 	if (error)
 		return error;
 
@@ -6353,13 +6368,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		}
 		error = security_context_to_sid(value, size,
 						&sid, GFP_KERNEL);
-		if (error == -EINVAL && !strcmp(name, "fscreate")) {
+		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
 				struct audit_buffer *ab;
 				size_t audit_size;
 
-				/* We strip a nul only if it is at the end, otherwise the
-				 * context contains a nul and we should audit that */
+				/* We strip a nul only if it is at the end,
+				 * otherwise the context contains a nul and
+				 * we should audit that */
 				if (str[size - 1] == '\0')
 					audit_size = size - 1;
 				else
@@ -6370,7 +6386,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6393,11 +6410,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
 	tsec = selinux_cred(new);
-	if (!strcmp(name, "exec")) {
+	if (attr == LSM_ATTR_EXEC) {
 		tsec->exec_sid = sid;
-	} else if (!strcmp(name, "fscreate")) {
+	} else if (attr == LSM_ATTR_FSCREATE) {
 		tsec->create_sid = sid;
-	} else if (!strcmp(name, "keycreate")) {
+	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
 			error = avc_has_perm(mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
@@ -6405,9 +6422,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				goto abort_change;
 		}
 		tsec->keycreate_sid = sid;
-	} else if (!strcmp(name, "sockcreate")) {
+	} else if (attr == LSM_ATTR_SOCKCREATE) {
 		tsec->sockcreate_sid = sid;
-	} else if (!strcmp(name, "current")) {
+	} else if (attr == LSM_ATTR_CURRENT) {
 		error = -EINVAL;
 		if (sid == 0)
 			goto abort_change;
@@ -6449,6 +6466,67 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			       size_t *size, u32 flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc = 0;
+
+	len = selinux_lsm_getattr(attr, current, &value);
+	if (len < 0)
+		return len;
+
+	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
+
+	if (total_len > *size)
+		rc = -E2BIG;
+	else if (ctx)
+		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
+
+	kfree(value);
+	*size = total_len;
+	if (rc < 0)
+		return rc;
+	return 1;
+}
+
+static int selinux_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
+			       size_t size, u32 flags)
+{
+	int rc;
+
+	rc = selinux_lsm_setattr(attr, ctx->ctx, ctx->ctx_len);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+static int selinux_getprocattr(struct task_struct *p,
+			       const char *name, char **value)
+{
+	unsigned int attr = lsm_name_to_attr(name);
+	int rc;
+
+	if (attr) {
+		rc = selinux_lsm_getattr(attr, p, value);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+
+	return -EINVAL;
+}
+
+static int selinux_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return selinux_lsm_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 static int selinux_ismaclabel(const char *name)
 {
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
@@ -7080,6 +7158,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.41.0

