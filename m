Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC5A79DA76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjILVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbjILVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:02:03 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39E10DD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552518; bh=8xNuesFAKrxRfQC9eej8Jzmx3zK6vD1Z3sUQEcFEY0Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LJ/h0O4uDVUw7GRYIzAbuUSCBOjdYsFJVrcAEjz95ZqAxWFb+lN3Pdf94iK76qg/Xq/8p91UonJanaKs8ABnvU8tui+lNO+MmG5G6b5PnqIk2i9vz+PCHxQzqiER+azWh8UWivaYxTmUtXaqA1tkcsHe3FcATFbsAume8TWWigupSqdZS9Y7ElJSQlpDk4rywhSeRjiL3bJyTccr1mj2WAHL9p66u/kUhyYkBm71tOQRuVaduGuW74o2bCF1wvMh9nCjdSl8cx54tCe3ERp4GXLJ6ZubmuuHAnXRmWu7W8eB8yV6X0bS+5S/nwBGOAe00pqho4S0tztIcuxI+qHYeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552518; bh=eKBXeegk5Opxl903f9gXklLNeTrIO3QuzwlYjFLKwHW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rKU7FFp6ABXn4zHS1PASoy44zoMpXFzqXUnV/dV2/i6cFerk6j+GIHHJQ5QFhYd8wCBcfs5Uu5oR9/suGu7uoQpcCfrJ4fyOFyKuVi7EzAuqCXEIpVZTJop3lsRVO7HJLrgvH2WBzzcFWGtw7t9BC782Pw9WuPY0FgNZFO/RfnxhlSnsZtZAc9nFeZorBJjOr+/G+IxTrt0mSP+NBx0q3HkckXy//RpK76ALisfPnmq8MfdCISTIupbhinYkt43X2aT+nmWzE5hN9/Oemti/uSKPzGvlSEJ8LqQiAD6udEnKttkZpuGOxD88pylBWGPJzogwBjWQ6rLYi1S697xssA==
X-YMail-OSG: T0Aub7kVM1m2eSjrNenuyYN4Y3CfxTMPR4ZJ2hl4jMOENsmDuzHqkbH2fsvdk9J
 d04urAJHc.BS3iu5ZN.8nsE.rw2oBPmr1iktFUtU4yAqs1_QW4hyVoED1TPjL6jxst7rz32_h3Mo
 uWY0cor_3ZmzFknYV1lE7veiUT8kAIs8YXftYxGNf2NOypVQ1u5J48VjSwMTXAgOLAbwZBUqpNEG
 0msORk.2ld0QEE3s08E1SjSe87ExAPjc4vcGm5jQ.97UUq7BLzUicUEVqugMd0e2qJbKI2pB_6Qt
 nse6emKm_N9OF7hN4q0mUdQiVTfL8Zamb6eEwHtIB0CzTXuwZ3xXdmnmuvuHCLgzh0qzFfT6lxtc
 Nh_T6smdufDcmtEQunn4rmjd08YGQKAOJoAq_hjVRZzzttWH5Hmr_6KLq2yuOJhXkbkdLuEOnADh
 VoWgVa4VAeKJEE2QH2RgVOcN5bhY7Nk.wkX9Uwx6VG5m97IyCqqCaU0CK0ioUv1eYTTsqvM6YRzw
 5vijUPBjipKZwV2Pe7eJzUYhfkza0fl3_YzAABpwIn1e2uqNhfrP3zUlXgtWm13OCZxlRJLcO3Z8
 tUfD6ys87tjb0Xk.D0Fxy7lV7zq_dYUA3zb0fIl.0HTx_lKZ9Lji.6IRsLzz6lvm1h.9pASbPYKv
 7_i1TSYicFk9D_1gE.j84W1dISOilpT_FQF_USuolnZ23d6wUBJ5ENGmtru_NiqNsC0RDwqTZZkF
 yf3K4nJ1qxqxK4UbXsn2tW5ce_dgqHOni4BRbD4F9vi2fySdHaqnCqqo49ZLK.W5ehVGjrxFtxNt
 SxJCV_dp3U9h6zQuARbBSPUW0EvoxLjlAMSq2Zd4sN.JxJg2Er1mp7W.pXpd9KPUuaBw2de0mSyS
 iCr_GgU6o_AVFa1yhlIUOm89FES1C8x16OGOilgaR8y.cXIpFQGerlvv66Tcw.Osu_JVd1XT.kMJ
 3_POXX5xTc.Tw2hOo0trML5sh9Wi__SQaWUEr823t9K7ZG_OnEHfbwWmKssSsnFpwFDlgVsfukvp
 6t9NKG.vZU.uEbDicuPSpb8Skm_b66LXPSHTlg70GLwk1WhCgSup8teNlsFvVLkSKwV5kJNBQT32
 8Y9WluiNs09NyeTBqLRviGA2vS35LWQ4GBSMnosYDNU5aCU.YuqYypEZPtyNAwvMkcTsoQHMebam
 fGa6moF9uxECOaIVMBH7gWvyq1SfzUzxW1y2kgnvoweZZLWugiUQbBCz8FNaJ_aW5AjB7qSBi9Jt
 XFfJBdSJ_KE6najV_UwZdODxj6ilEukaOC3l9iBB_5lU7YLgWwWzKXPpJQ_S.kI_2Yf54IMKOkWO
 WzEtig6O1fvvOX0fC68JbU5gRZddFsQlOnXSsn8W7C4lzhVnf9uUcjaKiTZUr3eEPBK4oY3NZJAx
 MW0FhMI7A34FSNmScj3RMuTM_P_TKwb6jLVXnKN3SYqYyXuuvOiHPv0AQOPBEmqO5RWIv0YkPUQY
 nuQqzXJ5F8e3cxLK3h7IBn7Jq7S6BzGXIZQxXWkCkXiKxOmkdvOz0X8zPdmEhg8U08XkPfkZbLCe
 OPfOjdGtiNHfFl4bJsEFzDr8GdbwElDNgxMHOC_WbJ0di0RLOR3P55MWrhloB.vwEA_XOyt.Dq.d
 PdJDi4AvQt7rgIiOGaGczr6PlE9nmNT15dKBTSUoBvg0GMO3TRrBwB62lCL06yiIokoz.DYsixKW
 x7iwjihTw8iZvI.j4GOmVX8pjbb5WGQav3YKQGDpdySsqc1jurR07st6S_3aIH.3gC.WJt1bYGWP
 XT1qmTjeTNEIRVF0_rP3nvf93o4aWS3bBLcZASh9rnsw3TWtBxunePIRm3dKwwgSKTt6wSfy_QH5
 Rh3egnfElS9zLp0BYvtnkPf7wJZIYGwjEafvbhbwUE0BxgiU2a3UkOH8h2fxlWDZy80h0J7hEdk1
 pAblKq45pMw.oDH1QjP8WBaUG4g0pFAlHOkmOu5Ws99L1j4yJIElEJH4Xc8Xaf85NB965QwV1moV
 IWckOInDJ8SiBTzyLHha95lPq4R_cLwyIPG0MG4kwJt6eZ3czqI50frlbs7jM5IzL4WHkPiWrSwR
 UgfGo.yj6Jf.DFKsIIcm8FymmeOsOrKd7qIk0qmR6jsm9rI77wWLO8OJVB.aDojO.DXZ2h.5Vx9o
 Yz9hmBBsHHQ3TGeIzB6lL44MCBQ4c7HMhtJfq8l1_PvT4cb.UjJKlMS8gxYm6XXvwl.rslYLRy32
 3HP1i91LjtlIFFmW_Mf6fORneZ.8Wh3RNhapKU4nY2YIEyhHO3ETMZPpKC0LAQBYqlsK5PF_NT_z
 enzd5OOYUBUdSgxY1mE9Ayio-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 036c133b-5b8e-4796-9aa2-b6d1833f160e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 21:01:58 +0000
Received: by hermes--production-ne1-7b767b77cc-84nnk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dca4072a6b7e00ec57f039d5e03e840b;
          Tue, 12 Sep 2023 21:01:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 09/11] AppArmor: Add selfattr hooks
Date:   Tue, 12 Sep 2023 13:56:54 -0700
Message-ID: <20230912205658.3432-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 20b93501fbd1..ac75e95e68a5 100644
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

