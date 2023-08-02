Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6B76D5D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjHBRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHBRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:44:48 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908C173A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998286; bh=ToC+SC5FgpVH1bMwFJ4SomOW39/rLrbS89hxS3BAGhk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j10ToaCh3Xkb2u+AZwrCYZKaSGdHKnLwxuroIVAEEDtk+e+5G6SIzZN25Xjfj58pp5mFs5OPUY8lVvD8XIQyCl59ZHnOxpXirMYwRDQBFW7Fi870uSSeYeuaHKL04tRGCp+xsxWEaea9fbtySf5s/x1+nFJo5rNyx8avmXGI76Ko3iFqlXb8vZQR8AXE2kEviifMufYkMRKQ9jKUl2YiddxB0BiP/+apOTPVAnqT7jiVl5+BS+nMAOwIkmJN6gasZ6PDkeZjPFBSAfLC3nuKQ9CAp32ei9UQExUFug+/3BqzUsygYzNrAnad0ExNCpKwMYNCeD0myBOFY55DsCM92w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998286; bh=ZHTlAUptwH2igMnYQ3BV9OGV3cb7oAoxuRmMOPRs4j/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aKJACkIO84YJ9CYuxV/YQpvICTwt5DI9NADpR+qcOzvSXPsFoeeC12rAiaHmWMAZHG7egryBjxuSrlpCor/UiVItSAhEvbIysSSpJdnMpaTETMqPmumroJRR50KYVGMlfn7wXjSfMm2eKwRsOZKA54ipU4Bec+38lMe/kg2K57Y6LNt2+5VyO5xxNHkvjV65YEvqAUJvZ3aKNTSGIqyF2UbU9lnzHHsflWxqj/Ul4ZE653O4pGSjemoB0oiimEzgnbiS6RwSQCDzA3fatutBDmXmIGLBYC0VBRGaT9XrtJBK0emXICVHAJZ9qz3occcCyBmTkD6kvThcj7qeH9j4GA==
X-YMail-OSG: TKkGTagVM1mvN9I3wCAqCytbgC_iQUrEN9ir8FtHCwQCdGd7iVlTd6h62jryj.9
 Bk8ofJjZ9yXIO2nQM3gQXpCnzfK_FAhVIe5UR5dadNn9edqiZdXBpBvLM80QnHEMto_yWDQkoiac
 toRCt6SaRcZzlXfruD_B77Cy_StwtylydmNIShom_YsyMCiiU363Wx9ZfinfQIqQSaagqa6ZqIwZ
 sikwjpHL0kgZ6gUWWd0_gECWIjEM82aTY6yqLOktIUnfEq6KYHAvICpOUiLnPH5ATDaAwRfcDn6e
 hHeocTHW39wXIk.XnPDuw6lwoVMrkujXMr2zxZf9P9vnUJMRMpO4nt83mzRNALzjACMCwX2ElGip
 _SguUCp9oxVlBle4QUpjrG3kvW6UtHNtZQJ8qgBKEr0Rv3lyaFZCR9UGn9vza35SsoX0E4dGHLZW
 MKOgaEc0.rwtOaQFFKwApMj_ZoGhR_EJnG1KI1c.voCIhB.8fclHs7DnNb22XjRquz6NWeodqlkQ
 NuI0ryhg12V60rFoxCkGrBEfuxMzGtXGh_LZKKmpUGNzcVVZNF.GOsbxo39BYH3XMQ8AoOUiEfzC
 lYsXGY0Yo4hier9wcJJ8xWnbkYd_m2S9HAyDr.5Z_K4Wq.Tjw_P2JvSGre.f.snzIurpfJFl0FTR
 H0ClAob9SwxLlacQ6CIrqdc53M_ypBhMWE23pvvnJv9coPxf0LfbfHjJBq7rhIYn3e_iViwxVZNi
 _ORLiww5Ab0leuKaIBuVdNOzXXClMmLtDQyxSQaioR_NiN8AO46zpflJ_ks1Zy0XTepO.dw7Kkzk
 7lFfDygmq8cgjaJzZwUbGKEybWfg.VvPXbN2AkXEYtWU9YkaqsCq9eEnP1LiMHrzo161SiiKCfnC
 d_CfuEZE0Fv1H7mlcwrSgMIWMpiJ9oZnZHam7mUmNF3PlE.t6tNSjDqtz4uN7MXH5FSQ7owYm7op
 b7g9OYvsvtMeVIjGJhvKBQC5TZsZ50DIgwkF7VvvATJUt3NQGZQOsy2DUAdSPQSjt7TCxgOv01Do
 lrh_ZNy58ageulI2Ksag8jqtgaLvA5zi2dOeUGYwD5xsg2Rz424mAd.xP3VPrDm0Ozfszh6f1nkd
 1UAPAp6DgU991VDzurE_BTXFlIaccOzVFlHSuODXg5KweCLewtgNzHCqXVOKD9eU8Gm1UWgz9REU
 K5ZnnPhn8qAOvTZNXp726oCvtItGgSLbJho0791I_b1CrHv.968ZfQxpqNdhOpJnbaaiH5j152fQ
 51Xb1YfrktSYqet8wr8fHyS26vg1CaXOm6ww35kfrUnQIfoOsKZwdjHz6gD2KOmPQSGDijWRVTwA
 72cqnSTRwoqEpSXmZyTj_.fXgwMxinI6KSkt27A6pSwUB.sdsRvplxrXg.qYZWe45MAHJshLMW3n
 ZsTIjlICEd1MoOQ6iU7HFqe2ZdtOC1JD7.lx3I8eCbwejq0oc_fgybTGQVw9p70WLNRGFpPJHcHn
 4diKDoBazKZcJQD2KoiuI3hSbZS_BFFpeuu5XrUn7N0Mjy0b.gni5tRZ2TA73Qz75ppUE_dir8vJ
 EpShvwLG6CE5mAB0vX8EdvHgzQvTjD8XueIHqcvR8OYPUJNZHLPHfl58LtwAorzEnHKZ9yZXHZJw
 v4KDASZocOoCJmN.oUyPi7lzgLYW9y3LViGHX2aZ9fpigqyi34z9FXFtCYALisbhAs7Oo0c1cjYz
 YZCBFW3_yq3dLN_5aJ_x_Qj23ESpWSna48SsWTrswAcNwaFGPf8LntE_p3B1GnRWm8R_bS258HEb
 j9mrn0pF2gYHlpmF35PiutGkoOScQ4pB8f7Y8AVvtaWatUjUNWCrNaNf0B9vD1rv4CRPp1pnSH1Q
 wg9d1M99dKgcppPF9poGkM8RWS2WAJ5Hzp8w4FCx_NHPlsEDLC5kq57wsgxhb4Z.i2kQrf_JQFKk
 fvRRZN7XSe9fKi2nIMalg5Aoh4MpVQAtQWOqz1QKWb90bPPt7wIwGjgFRFuyofFvQ0yJMKAHZmKP
 qGihEetmL4v0eav4GfUvi1HnD7ztTRFT4pa.b7WqzGBhTxzsxVmv89k6rSaL05RwMmmWT4B9fGrq
 sTzM0q5gmrN_J0Dv1aegYEo6LhUmac6m8gnzxjqdmtuC3YdvOMoD9BeTqqhQWpg7Kp_3Y3uxdJtF
 .QtF4aH2E_ZBgAOIUpHsDvGxZcH6Ya1oWTu2UGqVCOvmRZp5vOO66PLkxGZUAPaa5JOMWtS9hiTk
 MngtvroZOJr.14IHlx9_9WWMziYiARUVQKR8EUq4RRbnDcsmie2y3iyQ4CzVuDvcTp9hxLTy8GSe
 npkBBpsJkuJsjRfv2
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 427dd040-a3fe-46a8-a4cf-987a71033c9c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:44:46 +0000
Received: by hermes--production-gq1-7d844d8954-psjqr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 839fbc661e28c041ce8f4c5628604c14;
          Wed, 02 Aug 2023 17:44:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 02/11] LSM: Maintain a table of LSM attribute data
Date:   Wed,  2 Aug 2023 10:44:25 -0700
Message-ID: <20230802174435.11928-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Determine the number of possible security modules based on
their respective CONFIG options. This allows the number to be
known at build time. This allows data structures and tables
to use the constant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h |  2 ++
 security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 32828502f09e..a20a4ceda6d9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -138,6 +138,8 @@ enum lockdown_reason {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
+extern u32 lsm_active_cnt;
+extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/security.c b/security/security.c
index feaae09581dc..87b70a55a028 100644
--- a/security/security.c
+++ b/security/security.c
@@ -36,6 +36,25 @@
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
+/*
+ * How many LSMs are built into the kernel as determined at
+ * build time. Used to determine fixed array sizes.
+ * The capability module is accounted for by CONFIG_SECURITY
+ */
+#define LSM_CONFIG_COUNT ( \
+	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+
 /*
  * These are descriptions of the reasons that can be passed to the
  * security_locked_down() LSM hook. Placing this array here allows
@@ -245,6 +264,12 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -521,6 +546,18 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once during initialization, and LSM initialization
+	 * is serialized. Landlock is one such case.
+	 * Look at the previous entry, if there is one, for duplication.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
+		if (lsm_active_cnt >= LSM_CONFIG_COUNT)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+	}
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.41.0

