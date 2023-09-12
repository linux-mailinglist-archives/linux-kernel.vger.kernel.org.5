Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D079DA66
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbjILU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjILU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:58:55 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431761702
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552327; bh=iAQMxR3VEQ9M+gvIgGii9vKZpV7iSCvfcfgE1y9Jf68=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XAW/42bI7cdkhzApeZ9nPHkcfyIyDMZI0CXPO+s1jlvDZx6IJeObqFllRRaCq54WWQudT4vIYhoimdAMNjxXIadKzsrFkMW0uCLUTupIsJV5jbb+7MRl46CkK2vowKE88NxsWOGuoIlFP/22s3/hajVzIPZ1ggUpBNC6Px/ghKGP5UoX+61yZYSiFqFiernx+SupHa9XWXEaTKfdGVwC3ngiKqQ45iCqxOpIbakD6b2heR/S8kfitjCYW8TxB7A7DFwkxAbKPKmyHeQuUi8tQnPSrjBTFekyOTOSNy1KiOBORiOHmorVckcMBzAGvzGdZi8djgqYvPi0rjwN+fXGwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552327; bh=eMvIaGd0ztXaOO/jCklpApD02O8TSVZiAf7yY4esOox=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tNbO89ALrv1RO8dooYt0/tuzzt4ivueqkfQCwmEP0RcTsiUBb85+vVAfugy2dtGnhvxfJevY1uGGf20RFwRzuL8aL/cb3tM563dP34YBifLgJvkhgJbP3x9kf2BKrt9GJSFDMHyvML8E9lGszoAhj+4SNAQSpAqPUDJ9Vqtt7obwBr3oxFjcM3pFayR+pyf6+Bce4FbsCluryAfr7uPyPegi63i96p5Wk3sGaCC/iHl0dYdVbL/+qZ1kbKBmpwvXGxKnrP0HlBaRdEdNJF+E8QGsd+mK2OnyNrpr5An6G7MFx6Tlj7ZZI+JVMC5hFFzF2jTWk8c0ZvxCU7eP9IA26A==
X-YMail-OSG: XG_IJ_gVM1me5O1k0G6WxJumq9fA5StxpJFoIeM3rzMDFrkFm.J3waBusavKD_n
 cZofxjavrUB27kEIrwlzS0Xtic_AUngWd51wHmWrIf36Y.n.ZEmOmK0CjLauyEARZYlavDLdwfTz
 zTTsm94.MfzPdujzlU5HNa.DPhbVzD6NSOfLl1WyUiY57IHpoAHxtRipYBQLVw.ZyXpoxI7uBsPW
 I9E1wExQhRRPJ3uAhw1TekJ61Ge3IAWa_WQ1L3TwmhSTIaYNrtw_AHRH6bpsRuzKGz80IZHE71wh
 e1GrBxQkzBpL3M8JX0dAPErLiqyNw7KMsSJ76VZt_pW1n58yq.Oj.B0RTbMzxC7rJtBPxPu52_n0
 cjdXS9xWOQZbS3DVxMu8tAzkf9Yi_Nds.n9X.3O5CH7dLpVIhC0KQCBvqF3D06mLNQZUk5zrHi0Y
 HbJQpvAIKtbleK37mHj_mYdrH2cDChFrfMONWkwn9BPn2IbqpAol3SgLw1vs0wZySxMORpI7dCBY
 n.nPkyYxMTAhiU.._puBlCxXbw04EVBnyvdCBhcYnfLSxK0RgU3CLqQ3k1cal7E8SteueBkmKhVN
 U2XoZRJ8zraxIdWyb8w5KsF9pXzpM7we5Yx_WJlWXsdlA8QFw8YehNwOecMPb_JYSZCLYZJpxpDp
 OYAqocD_kg2xHBBi.OL0P_smzdNx0BxkD5hQgxDOdmg7tTXl984978NrOwxrZXDH2wrz6qCiBSha
 DIjXBxbj1b2mg6NKudJdDcmtZmaue_wIaRmglELxGkuvE.LTl_l1_FIjkyyG.vY0yGPZHYCSTjoS
 7LkbccfOvo3EzcKl1sUThLyeZd38uxB0OkCN9JYfq7UJ0yHn8I3SRSJ7YYBhWqn5PKzEK8zz61ya
 aZkoHJC2W6LqaWk8ZDLaLyc2tP1S8cVB5jh2JKUVcXsmnGPHpXmdNY6gBTbXPRVp6VYiTBUo9WZy
 YP8O6ZoPVh7IwmTlD1QnGJCx98jAahhCSeMygEjARnWuM7dUprK_btKrGIM7WH4kZzLPL1DHwMjq
 GnwCD6TRYr7DvLQXd4z3B3dmHgf83z4GVdsPwrxtEfHOjD07HsT61_bdDLLSjaCfh2NLStaQMmOL
 HjsaBLGkUp88B6Hse4raURACLQ4j1ZvNoaT3DxsBTk9d29Uatj4toEa3nX03TVVeFLKbQBEA5Q1s
 PGMwmyau.JRWYzYjC9sQfF_uksqIYR9pu7x__WAHBg.PdHM4M4JyhyeMQLnSQ6DEH9WI1brEKFGV
 2fytCt4WNSAaDCMkHs5J94HCZz7qQ5pmw3IjuCWNKsj7Lw2trXvpogj59iyODWpfd7sEvB6gwJgJ
 bFrwixYvC5NorwPSbo6wm76Ow5mnKL5UZNdXLSKznkYCVw.I5gqpmWKL_v5FFfb9VD_Q_o2MUgZE
 QpmjAOsLE3PK0uPoS62ZQIN1U5VmuX2rwfQnZK.AV6WdrtY0o5N5HWh6sdttYN7JFb4HI1Qvp2D1
 _6yeXEY.dKduIedgS6FDMBavU.Ea9X0F1sAhy0_MWZH0aqdGweNYeergX7kv3A2ilNHK5IjER_AV
 pjDl6H.Kw91GeNQi0U2nX1m5zJs0tQJiyphIKcWbs6DDdAgiyTiSmqB7WsXUZE.OnQzJFRy1H_S2
 EnAOZTknfFT072fNqOQ44ymK.8VED8_Rlf75kOQ84tyniK1e2oIV6qrpEqPDopoyYwCk5BrNqTr5
 wO9MinRW92Zlay7M0hAEdL68U0r7cfAExPdked0JBrbgqzXKIdunnovvAXfJSjeTWuZqXaGy4RIr
 2aYW0kqMYRcKFwo9vPgJ_GY8hg74P9exDp4YvgzcwxOULyxsk8kp_.r1jAp2XUCZZX4XcFCw0hgk
 E7A9s_ZTIzPmEHHlfu6Nc0J3AdGWfMW5YSQ_MMixjpnC66qJPt9REmsrcQq9f1lQVf.HwXuXNxU8
 2TDdYcwIGXe0kxNAlpGR.ccZtHocbMS62zJUpPrlj.TZUm7Q4COOgagGd1jNRPpcDJAXwoKoo3jM
 s26gif.6Z0IkkmwPi2cyY6rS2pSEgkas_FmKzl2U7bvYZvc9zU1zEPpp50sVEmM8nzt.H7pizFBN
 dzRhx6bDSbChBQCo_rt58MQGeOzMW2r.hKawk51Ku4p5X_sMFjCwUn62oTUaJfz_cnc6yWw4MDvn
 DnyaNdLRueoLtekamiiUgG.4we7AempXyeaaUuxKFGlSWbEaWfJUiguyUxlVhRaNDexai9m2.rX2
 x0ixlY2O7P6hJxP2yampzW6i.QO_m2KfS3X.MNg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a72d7c1f-7aaf-45d3-afc3-d307a69ed22c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 20:58:47 +0000
Received: by hermes--production-gq1-6b7c87dcf5-6x8bf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7160b6de539f095788df3fe36388d168;
          Tue, 12 Sep 2023 20:58:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Date:   Tue, 12 Sep 2023 13:56:50 -0700
Message-ID: <20230912205658.3432-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include choosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index f8499f3e2826..a76da373841b 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -63,6 +63,9 @@ Get the specified security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_list_modules
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8637287bd39d..323ef5e2667d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -945,6 +945,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t size, __u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f81f2468c0ce..738ca470fcce 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -172,6 +172,7 @@ COND_SYSCALL(fadvise64_64);
 COND_SYSCALL_COMPAT(fadvise64_64);
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
+COND_SYSCALL(lsm_list_modules);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 226ae80d9683..329aaca5efc0 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
+
+/**
+ * sys_lsm_list_modules - Return a list of the active security modules
+ * @ids: the LSM module ids
+ * @size: pointer to size of @ids, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns a list of the active LSM ids. On success this function
+ * returns the number of @ids array elements. This value may be zero
+ * if there are no LSMs active. If @size is insufficient to contain
+ * the return data -E2BIG is returned and @size is set to the minimum
+ * required size. In all other cases a negative value indicating the
+ * error is returned.
+ */
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+		u32, flags)
+{
+	size_t total_size = lsm_active_cnt * sizeof(*ids);
+	size_t usize;
+	int i;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	if (put_user(total_size, size) != 0)
+		return -EFAULT;
+
+	if (usize < total_size)
+		return -E2BIG;
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		if (put_user(lsm_idlist[i]->id, ids++))
+			return -EFAULT;
+
+	return lsm_active_cnt;
+}
-- 
2.41.0

