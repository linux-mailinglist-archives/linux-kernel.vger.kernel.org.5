Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F879DA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjILVAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjILVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:00:30 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84A10DD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552425; bh=qaYQrhaQXIPpO8mOBHridGYKIryoRHLIL6vxBAApMvk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=df6j8f/SAc+ytCeqX1F0XpBhLSAck5S8pMozwYmZ7JmLjSGjT084sWRvyjhjqtDDVnV/XUfGTVpd9NsICu1OsEOozCSWtKjiGwF5uy0Bg6jG3aa8UCowb2ktporYiZZLUulX5khNKRCPFRNuKgO9V+qwWoDjRn3KmD+C0oHqntyLPOZkOAzY+ILJiAMeH/Q32HUGkvG7sQOB0VtdnT61TsBWKPxBMH+ruiwXLXjjqPYSymhNuLOgL8jv/Scor4/s6dkkQPwIog+R1IMeADINYxfQlqkYdcIuvHaz1NAABxAZHbMYxXzqgZ8qcrNZhS6gcLg3yUn7skoxM3usrFPPsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552425; bh=XFROA2RgV5lKnpTzzctrH1vHjcVtcjoqv5tnuZ8BQNR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c3lhguPPhKtU19fSUUgyFDBCw7C2Oc2BFM2WnGa+6huRxDaGx4kE6bBcBp6fGToFLviddsW9b+oaiYd8qOrTfQ0MJeDboKI/yJLpKgqxf2rAcPfrmz5Ay7j+ryh1SpyEThsZrQrmvEuwLzj92En932TubPaekh6ccyjE7fMc2jIgWRf6+aYSEtm5fA3vsDaBmYfh6X1G33Q1/IH2hAyxLSWAA7N7fAXdG87nH7nJfU4bc5i+k6+CMre41sK7Zj02npM67LGbjbzgNSaAAfcAcngi/Xs1oN2JFQkVxMh5OqRtmWFxnJtqCQLyYH9mWKdEdyDuU9/YpcPbTEQ5ulhRcw==
X-YMail-OSG: TMdhFToVM1mS9qj5vUhs_sgHbhBsCw0nivxnD40W7BR.Kedydj1OkeEUN_gJb8x
 0Rju2B87LuYtoC9OW6JkdlqIbzSqV9zYL9S6UaqINphWGrjd0X2__5DblPaqSt_Nyqgq6T38mCOv
 5AfFt8LQnqgLNkYSpM2B8MwfpP3kSgj70uClwY3D_wb_dor0uwpXlCxbP0YKIJSIQNN6makI6wr2
 JWkrpBgNiaouXpJNuVV2geFR1f7owRLKpYDHi1X23jZI.92ZxNAWWzMJpqVrku8d.rsGVfEgOkrU
 dBRqCD2DMSLZA5uIunnLryGwBF.dR4NVnREC6miX_rLp_ODW1HijGnW5WSfktaUcRMjgFyBMxoJ4
 2XFli42MhswIIOj0GEc2MP0SwN7y60niI3HPMqno3Hk7RK48t9NkItcmGNPIfM9GMWma7js2qCVT
 gsfkO9u0XofOySarIBaqGayXJ8ojVFnwEHTcSHrR1c3YKXrCKd09MOdhC7c8cIJtb_jAvsbtBTR8
 JwxkTWAMO.4piIq4QJFNoEPHseSqe06TAt8cEf1dwiUIyCXHTlhWhur36o7dIC7wdMe..sVIDt34
 8j6oprZ92k_SplQbeTJTQWP8o4sQHZ_VP.phcyrOofQYzpA18ICwd8Tl_QbbdSb5wvfWVrGS7_sO
 msOx1llEHTIhtvAOJ1GOd70KM7usxsUN2xN_X5V9VEWuDVaQeKBSs4Ohb_b2ahSCyswvm.0mkj6A
 ifWEiiQe6kV8q8.9JWhLyRl8BSXWUqVg8MgmawN1NTC2.0ZIloIB7UekKt8KmByupRb7eyGKNvsn
 j9QaBlHtmSM5V.8KaUtyjcSnuuAIKiLr1w.WRAo_y3ribL8Rsg6nA5oO9KVVtetY9eahyKcKvG_H
 DODYZeuEhKQkuSJXXHT0ZNQxFBgmvWasqVyml325xDVR4nvd9b5XOfYWuTRFbDbXzhjfvRY5gouS
 9pJJ00Y_Dac9BpJh8xj2LWMjge2ruK3vs7CoURWLy7VALG5rjt8GTWeo9wIINbCVfk48zRrroOOZ
 9WbNhPtN0XAKfS3v29iNa8yWMERL7BwvYP99g4Al8w77FwVhFEQzYO9jhT_GFAn1Kq3Cyczb8ncb
 kAyWY6jmN2U.z0GiR7oGvg0PiVfh0CaxQ1oOxqIZKscCbFlyxZtFSiZWxp3Dxh2QsRvfTT2kWCGe
 4DdXsp0RUBOgDh9uKT2opybRHr87rBlSWKCZphxVbUHoiiHtHU09BAfJMAM_kII4Fb8PfJBlpXbb
 3UQDxLeUx44pNnW6I4EPwXS0z_nYCggzxbK7jSWVpXSBZk8yda0HqE8szQMWEQ_V85bHk7re4uA4
 .0ZyLcOaZSa1dZpZUZLDTkIJBGO7tSvIwK29yoINgYoCb8XlOvk2qO4UtfQNexO3.sfv6aPKX7On
 6_1GHs91vjQpsO5eGWzFX.3NiYQGc5SbbhAv5gNgpGzJ3FqSJdmBXKrV3iJay4LoS76eh_j5cCK7
 4_6m9XaZU1OU72kj.2vTluoY92iap5Ep.gOBJLOWARoNCmieadl9MWrdREB68Y_ZDUielPz06Ezs
 84VSyescTi1chFLVDNZGcLxtu8qjOClJnK0PPURj5_vsbRceuS8E9t6iBwPK.KwAa6cwOK.kuuVc
 zFA7bmfbNQiXpVVpyvTVY_28PXnnCKyiVlQjEk_1C4QOPaWcuZbBaFjNSAzAR.f2wBOC6tVhJU6b
 BWwQoIMJFh_srAMFCn1yP1_wIADxL16J5MARAFIrnwKXIyE_0kD5EqamTAplxoyoJp2gGZcHkZxI
 GeiQGLIHrWzYWnAFUMZKr9_BYxJdFLEy2XWyodRCxQZflZ6VkgIXXRzwaUJhKzReA4pSqCU1GMzY
 sMfhkrM9nNhUtJoUSlxi4rmv3JUznttTVngCIYzPojnstZ5jvzGoJ3A9dxkTGA.yi9TLxfWvNgEi
 b3gw.Piou2nGiZDn0e_PLoNJfAbPgpIb4WJ2Uy6zx3td60FCaWep2jeKQ8bjwQWDvSXcI31AUThz
 6OY7qD7w_jcCejiSVrubgYEWwntgYAzXTP1GBqA9cCu6Z5_17h8V1LPjmYywt0NtJRY8akX0EF01
 C.XE88hHU2ORVK4L4CVPhsrOlLX7Pb6HtDBbTv.jSO7NrNH0.DWeDFeTqSG_4pHCakTamV6iROow
 cvkL0Ng5nmje9yzi_X08vuidek9Sp4RvCmNeOEi0V1DEKBVw4btVAGuuLXWsHy4T9sPsZsvsjloQ
 0xLH_.b8KGvOf0Myp.3DA4h9BZeoNiRHKgmxyUxLUZSKv1yPA_3d0UrQnw0bsNyk0Jj9ICp_1krg
 3D3jtRekwG7ThU7sR
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 981f1edd-eeea-47f3-95c4-ab77608ad756
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 21:00:25 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a386478821340d4a39b6ed725da40e04;
          Tue, 12 Sep 2023 21:00:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Tue, 12 Sep 2023 13:56:53 -0700
Message-ID: <20230912205658.3432-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/smack/smack_lsm.c | 95 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f73f9a2834eb..12160d060cc1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3626,6 +3626,46 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	return;
 }
 
+/**
+ * smack_getselfattr - Smack current process attribute
+ * @attr: which attribute to fetch
+ * @ctx: buffer to receive the result
+ * @size: available size in, actual size out
+ * @flags: unused
+ *
+ * Fill the passed user space @ctx with the details of the requested
+ * attribute.
+ *
+ * Returns the number of attributes on success, an error code otherwise.
+ * There will only ever be one attribute.
+ */
+static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			     size_t *size, u32 flags)
+{
+	struct smack_known *skp = smk_of_current();
+	int total;
+	int slen;
+	int rc;
+
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
+
+	slen = strlen(skp->smk_known) + 1;
+	total = ALIGN(slen + sizeof(*ctx), 8);
+	if (total > *size)
+		rc = -E2BIG;
+	else if (ctx)
+		rc = lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK,
+				       0);
+	else
+		rc = 1;
+
+	*size = total;
+	if (rc >= 0)
+		return 1;
+	return rc;
+}
+
 /**
  * smack_getprocattr - Smack process attribute access
  * @p: the object task
@@ -3655,8 +3695,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3665,7 +3705,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3679,8 +3719,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
@@ -3719,6 +3759,49 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	return size;
 }
 
+/**
+ * smack_setselfattr - Set a Smack process attribute
+ * @attr: which attribute to set
+ * @ctx: buffer containing the data
+ * @size: size of @ctx
+ * @flags: unused
+ *
+ * Fill the passed user space @ctx with the details of the requested
+ * attribute.
+ *
+ * Returns 0 on success, an error code otherwise.
+ */
+static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
+			     size_t size, u32 flags)
+{
+	int rc;
+
+	rc = do_setattr(attr, ctx->ctx, ctx->ctx_len);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+/**
+ * smack_setprocattr - Smack process attribute setting
+ * @name: the name of the attribute in /proc/.../attr
+ * @value: the value to set
+ * @size: the size of the value
+ *
+ * Sets the Smack value of the task. Only setting self
+ * is permitted and only with privilege
+ *
+ * Returns the length of the smack label or an error code
+ */
+static int smack_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr != LSM_ATTR_UNDEF)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 /**
  * smack_unix_stream_connect - Smack access on UDS
  * @sock: one sock
@@ -5033,6 +5116,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.41.0

