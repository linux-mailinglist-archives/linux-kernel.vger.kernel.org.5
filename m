Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39A78B8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjH1UAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjH1UAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:00:37 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3B1AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252795; bh=zBGG0Z0RxU0ZNNk7pSWrIsOALLqk89mqFtOrYHgPhQ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AB/3Kofy0NtRJDTcBXp4xlCYWVF7AitTZ3Nh9T5BcYfUQrDToZPDZaGmBelQNGzEZrXpMjlR14I4eN80kQrliHLoevnCUyWCc1Y7EiYlJJ3dalvedtnEQ5B9H0Xwbd69BUGsv9Yd1seeHq6ue6hREjU2I7KZT7lRH7eL16fb88jGZCjzH6qjDtAwqypd263Rl/Wq+BLL6gxTYJeoVJ2biXZzi8F9fhM6AG+55Sj097Y4kWfKpJDP759lZSjisWM9ScB1DmrC4r/mUYvZ8GYFkMYf1OuPAUFvT6lzNkggFJAvu1rp7GrO8mAwwgalh1SRiFNqlmu6zjjCFEgsjHxDyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252795; bh=lVvbZCKT5PMFWPW+4plIYpvpHcRe5a7xFpGfASG01Du=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NnaAR8kcCqt7ZG4HChfQdBiHtsK0ifjHFdOFFN7mLpu6+9FH9Q62s2yxXZVbeHaQqCf0LK//uNjRAljeQpbS4wqQ2p9Y4jLEJm5aykd68Yx3KMzMhXKEpS/uPgCF81EW0ifwYLaOa+64nQN1K1qR54IK9h9OV7iHapkbwDZUK05woKcPZChi+ToXDvhVq+bJdXZVVo3v/Zm3Ez2dF4CDY5MdtWUaMp7c5umyFcB4Busn7Xuq0gASNWoc6qkRfAt+fx4f/b5N5R+iXtC2IHFH15Lb8Ggq+aMGZ1nOyw6K8kZXF1zsrKjE4UCuZ5gnoz/+Gf2radqcgoMxxYLO2jh2CA==
X-YMail-OSG: 3pIdc54VM1ktsmYGZHG5EUv3GSaNeIIa4DIJUnZSsArGZjwSrCr8wx4Av_YBM5n
 FHRlxYXoKMWWfsDWinSEmuzTpLY4J85JcelSNUFYEcUK_GyERtOVDEE9MoumWksI4zZowO8MtyHg
 aq8fmCmJ1mSWL173Ta4VO_efFxFQWElHHzkvJMERPRGK5h4NDkcwNbKBs6cYk4Tq5.hhy9V6cx8p
 oRV_DI7HSW2w6Tp9bBpHOEsFA.2xoJIzssQanqwnocGzE1AkwLF4rvWWkG0.DtQ2pNmwApMl53p0
 mwG0HsrHAfs5vvCX7F8JXkdBL94i3Vni7dM_6XNaUVe8aGCdtSeyn4JDVPa_5pyALntioILrwtVg
 BX5WYn23_jg7FpfERvCnJs5ExGi9PjFNYBuup3LSiB.5DBmlReTbGJxOVrKU3IA3AsHr13DiGF83
 5DaNIJPNjmaemr0lY2e9B6mqvYLSQ7RAA6ZWrxAuGp0bxA4VhWZL6gHmmgOAlWa9lB0MfGOZiYQj
 SHsX74VtWlg.0U9WEDgHyX25oF3W.lTq01Gj1JsW9nRRJXK00ABJfObDxG8aJPlD1.46tjA5rUcV
 r3zKSc8wxKiD2lcjQHXIqulPhhqVYIlpx022H0gtWJKHHjJ8E7tml2DvhsYWMGZfGpZnyL4vGUiG
 DdBdZg9eZV9l4mjc4.66LEhH9w6afQvuM5H5j2uhbvr07uagLWr9Ce0yGTxB45hF16oEf6Ru._mf
 42A8RmuU428ewnWpUD9ph33v9XAaFz8wS5.p_8bEaJGAK71w5ndh8qls7Ax30aO4zDbVPYHDfZUI
 BzxQKYlVxm8hp17HfUXKmdQIcvFpMi26c7sYDldNH4.N6o0ld9wpP3BrIpujk.gl.IkxhzdfJ.vZ
 cGZSmXkszquIYxNkPIhiaQ49GrPk3eAQAf8yBEXvBItagWwea.4JClZ2tehuuBf2vRBLJr1P6qG9
 DeiNLMKn70mg3Hemf4t2WzC3ZFscllap77Ij1gHfOMz3VIeL4VNL2UNTrBQ3hT9nIhsJE3oR3Prq
 OmEwqheDGEZIQcGO0zhurCFxZqfBImVdYnQcZKlpRTbDx5CcXPJOiCOKMgaJ5MhjCG8A6DzEOAzR
 dyKs9d2neBJwM8zMpyWedgx7mfwpIv4z7vru4JSuu1hZnh23EQ2dd04jeFfIm27zP9zRRLjUmtLb
 50f9uS1Nx_3z6xs1CMJlpazN7xAcr2uru7V.h1a.bnez5bOSmzvRuAx9xBbXjfm9zn9vIOL6IJeV
 1afhj.FJdXiCyIEPUPpiGqZ96tmZiX1EranM0TEnYPNn9DVPCo0MQPEPa43SPdPqyvt.DrAwNPv2
 GToGev9ds9aBo1x90pjhoNH.fiu1dXB6vuC0nHR0s5SUhhwWwkIwKqUJtXTkUMbpOHw643f5r5LL
 wt_XybK_9KyWN_e8yr9oYpg4OAIGadc_yrWgr8dO0YKtqymJ.FYuGMMizz9lc4xxmSURWkBWeX3n
 1Mz_JUGMRmRrU_ikXSgSnFFNooG5uxwCmha.zcDWQokvlZ0tZ5GJgSzvTdsp4QMnPcxhRc.aM_rE
 vNxfAomAe3T0scfgkqMRbjk7.LZC9ocUmSSwbr2I.aqfkNPoXqb1gXVQJ5TLxxdmKdTjNqN4IF3y
 lRYht68lP97MhVU_nGL5XY1HsLJ7JjwUPnHwBnBIZXtIveK6Q18oRvZ3wIuZ5u8ysUhJTIx1ZkPj
 HfDuSGBEoTuGKsQfFTxbAUBCGsvXv_iHy.8zcDlSU.4lprKLvWp9OOBfUVRrh.5OiNNqNYu6LtQ0
 zqotv_7OyEJfUNr6vO.PprTFgFHCuekVLzK1QL4Tily2Fg2sXFIzJP2Rm9NMuWmLzjfFF6inF8Xp
 dfbzl7ZkAXk6suSQ8qy6_IrUOZzFqw.ED0iWoPtlLF.Hs4PGxY9Pi.rQ.hrsvsiZFmvKc1lNAyRX
 _aQtHOBZXQVwCSxK0KP7yTG.BiW_iqWTV5suofnuU2FC.1bBVVdpDvjNp66KM.t924KP507h59WO
 xv5zW9awiNnELV17E0CnhAjXI6y_y7AwIfFVIAHrnDHgv0cjAl01xuPZOCd18FWzvEZIs1M1xmRi
 rM2W8hfwUO0oamFmB.snteoy2vFcEIe9Lox7uHYFVFKLMqVaNdcN.CzfaYydy9bUio1aANdyu4dH
 6HTE_QeDZSZ8C6y_NntgI7M8v2Nh9RRKRSNSFeSVaWr3Qas06CkZpFj5CdRtyLW5jEDzk3424XrA
 GnU0rcEa9odAqu7XEzPSbgIWaOlGlfdSiO5f5nxTwEp2zyZDIeAgITRBOr7Pdl3bqt3moKFzIiuP
 JcSjBsY915qef34s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8675275e-9b15-4279-8e87-84f83365935c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 19:59:55 +0000
Received: by hermes--production-bf1-865889d799-x5klk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4fa193a662e8d287c56340453369fa5e;
          Mon, 28 Aug 2023 19:59:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 05/11] LSM: Create lsm_list_modules system call
Date:   Mon, 28 Aug 2023 12:57:55 -0700
Message-ID: <20230828195802.135055-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index a3938850752a..4e1596b5c300 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -958,6 +958,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 		size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 		size_t size, __u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 8b96cd01b485..7663ef16c07e 100644
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

