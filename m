Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36B78B901
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjH1UDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjH1UCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:02:35 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA21AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252895; bh=c9gbUKDKCtAgVvj9/FjFK28NvQAqbhjz1AgV7p+i+4Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GLLy4Pmx/bshjTSXOliBNJlWBPHducqZYmaf/xbhTR3E2x+n+IiGJIGA6jZCUfekLmDi8pkaF00BpPaT41wGZiwtBhrbouRdTHMDC36vpSEFfBJpErPWq3Gg3pAxZsyy1jgNwg8qM6rZEfTqs9mzWtv5OP+r0C+F+ZbrYTudj8KC0u39S7G75h5iu7A7EHuMmvp7N7svUKzwuZE4PvIlZue4NMR69ei6goRu9CtQnwpGtSkPmqotO1YDrqowtwvEIBBn/wu1IaZGmdrkc4KNgA030S06YADmrujUMzKKg0XKeYAD2K5rSFUyW3e4yQcxptyXASm5C3eNukiKQTW0hg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252895; bh=J6i7tBpc+ZB+IsVOA2QByfrEnLTAVSELaHpwuOA2Xij=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=E/6fXxeW5uJx0nYmH1EUeyFJPYTVzxEyqi8lVCj46xSfRZmJGWDOGg/Jnr/3/C/KJeV8vybsaj3jH+C8uyppB0sAS8zWcMWRJFAo4JmltL0ILtwPjWsG+qb4SaJ84mtt0ytAl+ppvUHmTXkyK94GlDs0eCfAdCxt3OUkTd4niKkV544J383zyL1xhfKBHQbCeRE4oDTznQOCPxx+osfUA+4LcxT0VHZzuMiVcI/hMhCXJ8SjEyV18kNGm4w0tlq8m8sjBHV7Hm8QxpvlrlNguanqESRTSPZr6iwJXEs3bsL65017USjoS+k8Cg5k41WBmoM4JHOsJfKYUbA7MKbYoA==
X-YMail-OSG: IEWijHEVM1kSIGGWXBX9vyHb3C6upUTQToOKdQvKbFH6ahr.MT2sfTpEBkpkeCM
 AD.x328CU6o7srPrSpWwm3UvEGBKQmvG5.RObxIO_CN0_Ihb1Ut8Vgd0hu8QY00t857qHbQIEj4p
 IwkNiF4qNdpbCjRnG7ZhqljVdcLXI6FMj5FGv88LKj5rXnlcc3z22CiIJn9eYai_aUtCrmC_M7zk
 W8cnd.HUHw2ry.Q0bVTIT6CiNieOqggm2eFN9o4pb38ULLDblx9luzDbK61KJVPwVwFwLc1NJri7
 5tSHKEHs_DvW3lTlfl.uuiLYyDQLdRviYpVHMYktcvZ9WewkE8yl9KNRpy1m0sHDj5WADXuUKvqg
 PIAbSZEErPj1oedNC0y2KY0fkMVUj0cD9rfa6JfKf9Jf4iD5R1Hvv8jhVYDDsMnKdI8bpSO.xwhJ
 axKyhmQSoqYRtf3fF1W1UoFu1GjFlKMIw6DmERMKXfurRFjdhUyIughDEJI3K4rtJVfJSP7XXbp6
 ZtfzpFtN9iQiFJlXaOo.bZgvVsO0739G9hh7ivOsdIuawxKw9DjyDaErLH2VzsNxITAJBDc_ccth
 Mf4kgtkxKxzdTJB6fzY76ave5BhxuTBhMLoSvpQSzLKps1TRpVgSH.zsuKdg9ZtsumxmFuULgMDT
 nylbCgFUFaSMJyK9.jyKJK6cW2cy5QVeqwAA3aXEjh_oHw8XUycAztpOW9gk3etwdk06Y5ogcLvR
 oaQ_PKbVJobH3d2KXEVree5vPp2zriCY4QZhltYi35KctEDT4vCwB8TNROAbFVEMtGlfAncbUVmK
 9B1NQ8LZEeDjxuGNfG1STVjEGQ99fSreZLOVfCJpeRbao8dQ8smTm4RbdLcej.8yOurhPDFHPN.0
 P_RGtXHuifBuLwdiUv5KX7hyoCayB6hfDV3pPAPmZ.byaCoI29gVuftVM2u7A3s2W3f7SWqbXwd1
 IlBRci3uGGvmJZ1yDd8aThherOzYjlo.dtjYn0ay1cW._PQgQeUvj.GVLAvgf9_8wuyy1RGKcuUJ
 o_8GQ4iPXMK1VR3kKH4bDohXx79QgdLcvpECTVC.8IAOiRY2l3Nq55YHcdxZItPAvHIs6jNYNXRG
 58Sx_yeInk7tyrKT..1BeyAYJ3qCffg0yzJQFwCmSrMxxk1vKsFBlpqsNsYQBLoSZ4EzM9e2JGnR
 vun.eFav6XLaLGPMqHzYndQ9cexdwQvKJZdYfu.Nz1wYSKsy2xzsdoDrpHRSiXEHTqwiWJqtdt5e
 LUmqjAkB0PmQasSGFnQi3UQz1H8TlRUCXlFv9QJTpYQlXpm7GC3rXDWHvoRYMh3mAUHvCE66w8Xd
 J0eA26r4ymP_YV9ccaiKxipc7sRgimBMT2YR5qvYOTkl7cC.gaa9bQJrGMbayM7i.OrfSdpKkrN4
 BDH.PoH_ISsMisPhC_Qt2zSsrpzjCFzU5Z63.sx5Qp3lG5hZmWKmPr.Yh0jbSbMDBRTn2zq.LdG6
 MDXE8QC8FuSJYBaxMMhoFVUlNe.3PTexmFO9mLmcniOd2DxvXTbWN4NPd7hbstqACeuGBeoJV9qz
 yYlRd4G4rtFFwyBl4L8b3VSZgoN0OCBB3AOB5ZVIb7DCMI0TUQhXtP77Cy9C_bVtcEHUJiy7KNBB
 WqDv86uUMPAmBQaF.ZYtZp8eDtn3AEj32eCigWheRkGF5EljzcaSGRjSPWJJJ7H8oYFMLktGTqaw
 z.W2Hz82OnIpXNWA8V2PQc8FbTDctD1sWuuzoSj59B_qXe3GBfBjygkH1dyzb0eC7Cq_xPliJCqD
 5_vhnLL40WqmXXhcB2gxivifDf5qEmAK9PkiEUkk9MihevVCs3O_7mUgU1xqKeqEysETLKt40n79
 X9GRXBajp3qCOn4M0gbdIQfx9WbzkSkz4wNg_XlO0X9_Pqo7CC5y09e3o99fI2zVfkkVE66hEzxs
 2okfr1PwkTE_b2SadGOPuWLsex5eKeouC4uEtUu6wg87JrlO4lw3ZuMcGZ40YIssjjS67I2Zp9cy
 D0oKcBa8ErO9hGhbqTEYVDEjdj0NDTbBXpFNrVmp4ZigNR_gFAxUrc4bN3sOTPj58Mnf8Pde9.qD
 929q3uZKGaXf0r24uCnd6eS7nMOaU9N5_yLw41BgvqMBhQg0TK4.zEM12QFcwJriyiEMERi6RRwk
 EzGV6VziXHcSnDgMrZdXSoeLTQhjc.Bt2wm412IAgYWGI8I5TPRyhpkgwXPKVmbUlJFDByTD66dg
 OAcE5hTcTy5SFkQTBIgXy7di5g4TX5Af.bp7UOvAOWsGhCiJNhOObh7eAlCZiVyVpL2GcK3mdYS6
 ZzSYfKiSIhaN4g62bvjo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 884e8dc7-9432-4337-8f4e-5a4e2a2adba1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 20:01:35 +0000
Received: by hermes--production-bf1-865889d799-xc84r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41e108e68e35436397144cebae3e0d39;
          Mon, 28 Aug 2023 20:01:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Mon, 28 Aug 2023 12:57:58 -0700
Message-ID: <20230828195802.135055-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d2dfef74e4e2..1bbe0f9f9fde 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3565,6 +3565,46 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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
@@ -3594,8 +3634,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3604,7 +3644,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3618,8 +3658,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
@@ -3658,6 +3698,49 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
@@ -4970,6 +5053,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.41.0

