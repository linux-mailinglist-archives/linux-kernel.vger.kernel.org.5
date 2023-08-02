Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B124B76D61C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjHBRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjHBRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:50:48 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04791FF3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998578; bh=1z4JIHZm4iFDoZgr2SE/Rwlkjm9zpKdJXxkkP4ltcr8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ya4849+EibzjiYC6YiBGwSSn3hrQiTvFBuCwN1z9Y142YQD7mpkxzO15ZT9+ygtJ5rgKW0ErA7OkuRaC76myRfOPxWC/CgIIbik62msyyVyfCjhNIwovPfdcG1bHltnnPUL9WXlATO3APULkkimgSxUiFY4YFGKX22dxPMUE7g8vqKmAqj7CUSuiV8nOd25lzq4SE7K067IvU/rHOTeE+ooue8OnOtGq/sFJ2NzbIdeuPc5VpJbWS+FdR6Z9DPOcm1cpT3MfaXbjUJG4AKlGzs1Hqbe6/pU/h7WOIxxF5SPHW4Co1kxp+WVTCTdmyyidDVIFJMF/pS6CJzTnTMFMFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998578; bh=bOXpcUw4fHfXosFGEw3mClIfJtv5DvZGIp5zMC9Pu9m=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kVZW6WaWDG20sR1XeGAhb84VPgG1iiICYQuM+dyWpCHZkyCJCudF7U2LmpIpytuYy1CL6s14f8dZLoOlCoQ7hHVchNAnr4w1PEQ1UzYxqYYbXs+m8JCSA+mPWl/lUGm4sKHC7fJ+fbyXM4Dvz1YBe6h+tSjDd1JP/0rV5D14+g/v1QjYVZNRltsBUcBeFYD8W95NoPPPo/Coj4BnUCdDFlJKWyiuX1NTaGtnmhS1LU0N4P6ZlYCsiAAnYpVUhu4f2qa+P1632dOjlUUq92SZCANRrjcItf4Rhns3F6nDpenjNL6hJjv0NqTf/9w5xDdXwBceUV1pnZXanX0TI6Q+uA==
X-YMail-OSG: Z9o4sn4VM1lUq1.nMo31d1OxXYCvtZNr8s4VI1hGquFl6QBwarjcMSnMw_ql.yl
 3d9yoPSF05SfULSCvZKtUaGz_RHPIxsARICHdfRD1AOWsTKi4yPbMA.S5k3_OrqKi_hoYFQPpSFP
 mCpJhleyAzjbYCawADMqo1ojI3oBSbJ4hCtwTHILbddlNy2VzCJiCpkN1KRt2_q4F.QXmVV.NjnA
 mM9OCBOIp.bGFR4hAJFxt3ELFQzWIqkixhO3qbPXqMT_Pkm1x6TiGBD3dwLM_glOzNopoFQy__P9
 4gi5CEo5hC2g666kyNkHyBHUJ9EhRNwlTjKn.9RhxVAkvvWZbolsRsMxnWpdBmQJJd0Oz.5ugNrs
 5mbuHdaCsYwpERX3SwgeeCbku.RarfPusoI1cse9Kg4EmFBVa7Yokw0FrEQZVB1O0O3DRWe3p1a3
 g9kHhMwOo9XYo64n14XOWpyb_.81a1Iv8MinJcu_dpfkNDiCEFKrhqKu1Di37hMyyCtRiKlfNdtB
 vd5v.iNkmbRtIpBRo41mtb__NepPQ_TvXmmg8h.MBW7hqYj_r2o2fPWhvIwaKjCbwHdj23cZETao
 Yhzz7K5BC0SiXxdgKPFJqS6QfeedTxpB3KomsLj7RZYHEuoyMAK2Huqyoe8hxkGO9dTiHhRoDd1D
 tBPi97FXIruw8M4u73T.WWQprXIkbFOeZk8mx5xDvnH2.BwpNRN4e5IA45Q1v.rnNXmb_4RkEuPZ
 d_3e5VNZdIFCeiS4QI_Q.B5Csr8U1L6dDCpNjZyz7DiJCf._Mj.CgX7wrT03GOyZm7pEEitPYR6r
 8bVphPuwKToIl_akWRXEhbWK0tM.RXOimCtEKmDAwWT1XDf2v0X8M7WEeHJbt541x.ytpYXPNxx_
 6rYLqhpjNQMiUTSiOFQfyYNR9nqMBVhhXi_Uie7a_nr9sykBefudf7G0hWES2C9WZ6qYbd0av3Cn
 Tsi6ur0giULQ4Z27cXgu7lDiumO_L3e4hrnFUOCYWZSskxJTapvhR23_Q8650txZ1ZPztTaTfCcN
 zi1KrNEISNzOIfj8Knn3HrFZGgp1xbeNO703EDLbYugQaUq6x_9oNqo0_sh4D5E.0UqsTooM2M57
 _FlXGWsXFRiq4ot06fHIdqm8LKRYF41w4kKo.4e8cId4KdbHIgXNBUCzZbCdSsqtqFOY.MtmKufw
 _r_NiyoHMyKiARDttboFhnxLKubAuUwhbUrcefF4S4exyOx3NZ6zyzM0wXDSHVNGaopwLwR47DIM
 eSHKlwKwoN3CJDHXv8_xubKrLfjOlNfgQ2qAbJGd96cmaOOU6iSh88nfJg9XVaXecyy6QdMnvxmD
 Rihfludsvzmf8u7As2cWLnyz2zymbvxZJggftgjOGculCg6yMtYyyLZzwl_WcRUzGekC.wF3tJ28
 dkFczx2iBsmxIsB0aDgwKW1MloctjIWeuq1a9TZsMciojbvS8Umv4_fLn17ntO1RNWvk0bLgc3oo
 1loEP5RcQBKEE0fRZ8xccf.AIVALjLPQ0IapQDs3ieI4I4.RcFbP5MroSQHCNURbfrwEF57Bip3o
 R6d9mYecdJpIRyno4Y9ETvPbGt1K3R9Dej11Hw5SRmJNR7F7JZXKQqkAiBlsoPxBbFxncCxbUHa7
 fvaCxKkex8gNMp0UaMfNhZBjim_BaJOFbX6X39Du4aUqJDcHzumtpX_SyvzA8Giz3Q5y_deTv4o3
 xSFzqBI1.F2SLtGPbubodnEzwYw5Pmo8F8hZgrlEOeR0RTsPfLLWB_PV.0b1cJDDXkuu38O1kQnE
 ZpuaruhqHbHSYn..AySxfebZ71wB1nO8pJ1t2..phlavRjN4JA3tRKAz9KVTIJtVQRaeS8Esw8za
 akoJ2ccEohPxpk6hxKrRnAIT9YC8db2PCDJ0r3TnQiGJtzuZc63JPQrWABUoCVyP6YXTsvDtis1U
 tDX7qfhPgJfIeIWWY.CL2N7IYq1E0CUqWQYdY7Hw1vQAMhWNV_JCHZBdsrQoRQzb6K3aVYUaMkqu
 8ig0EVFwQn61m.0BrJE5bV.f26DepnG507qESzsn17IsCuh0bmLfPfAwldic0lHRksbKG04vSinK
 xAA8t0Tcke743BVl61Ti3oPbpwaaP_yiODenLPIpldisuMtzMmJ0PnUyKivedQZjd0P1H3YpUmIN
 ykueReD4hSiOLd5QuRlobfyVTahGciUKbAJJ0Ky7wDcw8VAzptTkuUVWDp9weFoDWQs6.mjh9fKZ
 mFWzj6o8wyxVh9FipXFO5xHB6wIJOJj9wIDz0dRyHb3gcsDWjhyagSefqS3ExZ1Q6IR9Xd2MLsH1
 JxHDlEWF18fjJZInrh5GOn50-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5e9be14c-e0e3-4c9f-a8c6-35d62f10c7ad
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:49:38 +0000
Received: by hermes--production-gq1-7d844d8954-l5pzx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6a2fae4a0e3a5f2539f1465356d53db3;
          Wed, 02 Aug 2023 17:49:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 09/11] AppArmor: Add selfattr hooks
Date:   Wed,  2 Aug 2023 10:44:32 -0700
Message-ID: <20230802174435.11928-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
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
index bfd049c3fd22..cd54e5ecb46a 100644
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

