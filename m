Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0161576D5FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjHBRsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjHBRsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:48:21 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4430CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998482; bh=UBydeHMvtYkBeF7n7pDG2UzAIQcaUbq2whax6Z+5Xks=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Qronr+Dhhrq+VxP9HxVFkRvT5wEJ9ddg8jIAnVTi0gkKDrvlIe6ZqBm/XJ1qflOr6C3vuoUqalq/1PhYpK/I0N4tUU9uUwxUAQsWi+p19Y0rP59FrFCo7i7/HkX3051hhyn7Tctpmq/ZmROZzO0LQ49edjdtN87byJsIMIZslqZURN3iWm7lgx7qgF8Ovf5vauvzx8ZuYshWzd1lAbVjHT/qvnKv2FzKr2CGsiL9G59JHsTO4JnYDDoTppNu069uKVWP878PFOv7h1rnInyGP6sEJhGv4H0QsshnJ9FxRAuLtYRrPB45vu9dXXz9X79Z8Yi2kYHWSwg/MbNunFfNlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998482; bh=n5cDMKvgPsGNxqBG8/kwxhfcpTecafznk/335PK2ToA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DNrdOPWcUIUsaDTo/yxRRMNjrXozub1kFyPmMjObdP7taz0ZNmgr1+YR4mfP46/T3kN3Vp41nh+HR8uB+3gPUgNPpYxU+pU/u5JtGNBaLt6r6j81AuoJcSENsoazdNu335Jxn9CEw0kHJiu0ailhAIinedhbVvN0/bJxh/Yjw5DEpsTZYdwfM9f943n2SAbZbBQfXG2vL+rgNMOw9MnG485CZYM1cVhK+c8ScHiblB7MbLiO3XNTkp4z8HgwVZB//khfHeew+9IC13565oQJajJbra+d4jvXDkF1Kw6EvLxRR2qjux4Ghm0W2YyIUSb7rTI4yddXzDOfba/nA5/7ZQ==
X-YMail-OSG: GdfqacoVM1kWTHYabMjT5dv7btICj_a8ty2WjEGU8R58qbow3ptrDPsreVaSrRk
 mfEcBaO4fsbb5fZb_pnCenUlVaNJKD.q2x0_s4vG8TxWX.XPb5mV9MGlWDU5uA_T6oQ1CSOXSSbO
 qzQjftKYWfzH2M3p7tBfMSYhdqkLNUC.Ao_ScGWZL6WZ9ru_diqlvH73x06xcqmJqJ5usO2pVhr5
 H7lmqb0mFLG4bog53NqrihQ2m.NTwCTpC583H0.z7FDlTsn9emL7keA1HcRBHKiezmDswoPqAU..
 JHsVEwJRfQ7Y4tZIakBTKC4NIh1TtGwj9Y05sU2LF8usuaKWDl8GslD_y4MFOT46fkJB_HBALece
 GZm6JD0Y0t2ZAIsknZYQ0Au8nVghHMc0Iyee2nSBWfMcBfJiD34h0QYdM3eImQA_yr2C4pth5R8L
 _l5VGKMnFwfozG77IehB25vAY5HCfF8qhe3g9bmHIB9oUpEnc80PkDQ3t.lq429DHatu5VFQntKs
 _6BegsHQ30jGeLNVhqAlfUtnhFzs.JjZgrhuoq8QsazjEysPn9B32qwyN1Zu.gMvrcxDwvWzEFFz
 bx5cGnl0cazx.yFeej7xSKWmC5cJkTldZwsWbeL3w3cOpFiuYnYSNdbcIbUyDrWH_eYWABm8o_FU
 vq1qdlmngw1kf2U4aPxXL4264ScT.0nM1qqWMvvPHZr6_Ges0dv6EVwxNubw_Bu3BOOSNomZgAnY
 G0W9ZnNHGh7wUkGdl7DNGhrE3JavovFcXm3MA_cpG5tsptnnUVuB6yN3tlutm.yaRd0UwNMqoO09
 C1TKYzHo9S3C6oKci8OY92V8ftHCVL.GomT3fKyZSiG_H23pB2.LHk512mbcdubnZUZahy0o2XHE
 AbpcyCd1PLhWmMy4VANBj5dpeKPKbDo3aGAuLnmIwS0BgR97HCEhzTc6KZqiVub2LKfm5tj2MVnv
 CBq5tnvnxaOjxj6i9VZjR_26H.XEla7XsuPu85aa6GTe6r8pmpyBsV3cyGvob4_F8kB4s0CALKXT
 N_wki4ObcDiiR3qqI2c_o3SJ7CWnpbuBlPEytPC5Z35cZpQf18CSadWU_O8k6nr6y18vYBl4LqzP
 Sm6jSZRP2gXfSBP0ujTqEfKrFSFGlWTpXh5y9XZsUnWc8ofzUPHS_EKBcppVnqDbtL8noesQ_HFE
 N_9gDT_MbUXqP19t9MygyHvzAgkRoYjS4mE3ugWAGihXoR.F8_7MvkvGRd3APUocshRqS_PSD4Tm
 aXyb3fGcL4UxD.sCbFYqp2Akmu5K8fjI140DB9w1ssaYmEJuEhCC9Z1JeklA1jiAzFmwlihy.sX9
 azLa2nbvxwiEI_pPqNt5kiAB8_ALUJfFXtahfYZj8AJxYaZw6R0vrE04qQK8k.RWBl.RFnGdXBXe
 IkKtjGr0Bpw125yFvOv0lmAaPnzbjHZn41E4ceIy1rQUgVWSlW6sYtFgwsbMFB81MRTf7ylp1wlF
 JqAg9Ew2xXh8H_g.ncVahXyGOWkIWd5flFWADQI3r_WN5bRJoESCV9H8Z.DF_6BJwW1T3R4fqwEF
 BsZU0yHlRrj0OTZuvO8lmQXj1UoY15jFwq_QQCAfzI0tfgrPipxVLtirLcjRY77eJZeP.GvceGZX
 zy0XGoK_UgG7D5NWT0__Xx08T2Mfcw90gKq.nOyUhvaqVqzr0OzBN.n6R4yzwE1Iik6dBN6vj.ms
 nFVs50xWNiA3VL5BWTNoj0wCvXVDcCt7bSUV6Gh.PLkPJb1p06tdDZyFSIzF72h2onDFEGWkOj6c
 FlrimnawxhwejJCVJFLbbGnqvBfYVQSH4JEEG7gxcopoD11vN46KnYvThGVXd8wnqheWtYlFsKIJ
 ZWDbK2_Ui4SzRjQaNYaigddkr1zfbBp3NjgU2byw4gAUg2j0qzyo7O_q9FarlrRisKoHMDjv9l.S
 ddw57yK6V1MfF0thYkCL_zIs6aJuKUrW_X1.UhaGDN9OtPnWK4uhNc_WUik4xuLfXDMpzbEt1OqO
 Vq3zUa99oq.0hZEiwVfQGxA9q0klFcx7kVjzS0Iv0Dbi5DeHzuSOOPFNuYyAs_9bNqaiSmOi0tZ4
 752MBMmTIJd3mZ9wcomzSql.ujfS6bvC9oPrBRDm2.YyQIftHTETHtuS7UTCxXoHf8YdUlR7S3BW
 o0vkeHxpbD3uJCM7t_4tiKMcJedUPhjDDn1s._5nMOz0N9GDjbxbHZn_MLk8r3X9.B1Dk1cA49mX
 _RdzCW0BuEGGTzWVSF3CQCLpOQ8OQO4IXdmRCQ_zClszKJElbT5FuSCn2ClDVjS7mjy3wuUcem8M
 AnW0VWY74q.MCsQM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1277751b-e00f-4eba-9dd8-58d13e86187c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:48:02 +0000
Received: by hermes--production-gq1-7d844d8954-t8s9w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9cf20a3b1a5c807479089b2cf544b53b;
          Wed, 02 Aug 2023 17:48:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Wed,  2 Aug 2023 10:44:31 -0700
Message-ID: <20230802174435.11928-9-casey@schaufler-ca.com>
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

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 94 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f3e4b26c8a87..71c773fff971 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3565,6 +3565,45 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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
+ * Returns 1, the number of attributes, on success, an error code otherwise.
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
@@ -3594,8 +3633,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3604,7 +3643,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3618,8 +3657,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
@@ -3658,6 +3697,49 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
@@ -4970,6 +5052,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.41.0

