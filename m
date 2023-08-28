Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4F78B8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjH1T6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjH1T6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:16 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD1198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252692; bh=86NOatTwcSpk7wyjUbIzSnDgLk93pV2eDbNg2QFxdBU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=n216jDejC6V0X4xzJWC2DIA7/ZMjgho+jMlyFew95DZlS5JoUIyIIodoGNqBt2ZBEfJw1PIdz+mHBKV8BEacw6JxfYvq3Ufzd8bCbjUFD32S0JbHdfz3RIDcg5chH3W9b42KikX7qcjk4x6I3tPE2ODzq2eqEESMS/GGUM/iFeXyNKlYvPxPeY+qfAG1P21Nmu5Ipg5PWeYJodBH7Cm+qZnUc7YSCjafvO62+78wiHVNtpUANW4Cdl7v2LL0ZwzjonEL7Td/xD+EoiiIBvd4L++yL7zw6CHtxujOny/7vclWhxxPfhTuR9avHxo7NJVQRVGtk/HflrGAjQbtI3PETg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252692; bh=do/uNzKh/XPJBakq4yI32UUCweSNheGPYM0MPPJk1og=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PE2g8JraxfoAfuipj17DGRnK3jXSB3NwhsB73rlxBYT1wTM3EmEcCmZYYlI8gYa4SC+g9GB4nNEa+RRb+1CsqAsjomZKs0JPK2a9zvPRQgfnLjdWObjLey6Ds6PztAFh2MzYOrj24sa8MRCWWa2ZiNXRCw9wChzJBtYbsnjimViCHNW60WHxOkwadS4yrwAsArSXAf5eC8CY2QiK09zu8UlEouvZsMXu2c9kzbN98mICXXCTystloK9RcJ1N8D/8IWigX5UPib4n2sRabC6s5C55AyMMuK0Gj9PNaJ55a6pCMAQqLhLd2U5oAkv3Z/3fczPUyA2rj/3fxy2weewb0Q==
X-YMail-OSG: CyRRcEEVM1kADcGXnyKucPw4UtEIBKgxZ_LpAiaf8nJtBGHFnhyf6Nkbx6oP.wx
 xSbeQWqYahLm69RKdHbGpc2VXIq9vZxTZG1a5l1u0wLWRlFCyZB6eHTeBHXR.Bblis_h76v47BsR
 OdKgqyK7U1Egtxk0Iz7nZgSgxy.1R8SPfS6rVnOoJ1N24hM6LOLEq_dTTKARuIPhNAIK6mW8Hrc5
 IcqTl08HON5_JewhdAGSpFL3_h3G6ymqmkFWP0LMLc0oo0d5IML2u2daNUyajzC.F8G37R2IpmcF
 mxS_Yt1rxRRVt6wcXopRIqM1M9sYFE.ADjRQKOIm7mcPxDdZnzHlkENSKvDgRp97zAX5WIj4sP13
 VHnS2PynqUXZh2fDeStldSg00fIrroO233sQuYNYBZRTL8J9tHw3PQ2G2q1J01l6ISaNy_ImQaVm
 DbOH1v8nS7I80tQvnsAY4rUTVU3GTMGljdpX9QH7KYjU6mPluMXDjQtXbTuFig4Tz1mH9spaHlEE
 ht16yEJfHxDCLzExlFRnZo6P7QHfevz9Ah_.78tx_ivlWuA2n1fB6_VmHGEMVelAkpMXioZBDNdg
 x7vDtr8qVqgf_Jx6gFW7z7kGtX5yxQ25nA_Rb0bhrjJ8FiB_H._lR8api__0uPVpPtQAsdao3V7o
 3xLqrprNdf8xNiIXWWSvWb4d6LK31144Xz.XHsx0WNcWNL4WROF7YseKvHULSDWDVxSQz44EIHxv
 sLlNmILoANjc3.ldmLtTjqhbZVt7zIP1oAyepVayLIwTp6C.RhiBc5SD59KPBoBRCJJzQZBftpHB
 piemQurQaB5cg2fWOJF9wlAiNp7ou_zmhWkfok6swXspmL9qaMU5OBffohXLIQZv9BZLWRijPTEu
 RGncv376_.1Q9B06tU9iOi8YMvSopSH6mg3omZFhixwg_DEsPnCWiBnhUbHzzuhVusZdrbyTx.QE
 R38P5khADAWDEyEYHNaQl.ejpgLrgWh4t0HxEWXUhM1L2Yo6Vy0qjz94foRpMV.e.Md..aAbMF3z
 f01Nv9sM0_10OM1vL_JJ34yv_59UDEN0YmeF.3ZugZhe5Y7aSONzoxIjIIP092SrCtK2prGs6Dkl
 B3FqL.gy0SU2ShHC69i1yHDORSGBnZ_kuqPs97heanY4OzMz9Qybto8RnLEKRhdCWn7ZrTKiOO5c
 krcJ_fEQ_qjR0KZVPclnROtarQYSkvT6zn_0wK4q6BYpjHbWAg0scoNVgen_yMjDCLpUho_fi2vS
 Jk6niQdBsvOr_uQpoMiR37Y__roezWEPixWusLs1yNOo_pDsm_SJhcngD2ds_oLhDE4d9yakStQw
 lw3zXnPPS4makSY1by3RhN9EXlJYkR4PGSIKP.fFXJlom1iubs.Kr1pX5E8Jb0AQpTXnUYcBXiAM
 cx3wpjbvK3IhtWiVmqiQAHqGzL70DdHs2QVGVSb1AndCVr4R.YOPe8rv13kR92ypaK0lZH7ZUm1P
 5SkX2o2Zlvd6lTz0NXUEmepd_e.KZeXmp6G1FpfY9kYQ1uUhq0dRF.vb6QfDUrXTPOwDdX0my4ut
 uQweRZh8BKbuaKX8Q3vP.gCAOGZUVjwBrz4k1f6FjbYzHxfJNlMs60ssnpXL.7e69P9qiJM9JScZ
 A1UAAK47aN9gvjgKW12mfvhA7mhQhEmLqnj52_UX35HYtyhwoD9IKzdw8EbTv0cMvcP9L6AQYbqK
 lDuY8fDz9YyP9dRS0icUZnBhUYjHSQ1PGjxNR2VG5X21ZvLfJ2zUboqaLtrZVW0BRxpCmK7_alSh
 qWi.ZdzcCBr6giQejJWIn.ifTNZagv7WSX4MtUalpkleNZpjQin3yAS4evk3nCWixKUZfBdyB8Be
 xWIRwyXhKQR54T_3gBZctmpFT8eBfEKhHlgfQRsyy2SNH_VpDC_cnla67_3inB34CLhzAJdclLPC
 bA.Z_f97i3HsSqGh9FEMPxkY_r18dDkKyGYu80gEk7Pj2vS.tQqLcEZy65.hp0baOgNPyWGn2OZy
 z6UMnwcrt7qqGgBBxbrIui05WWrmbAiWRsE0ASuwLdloVI_ttEg.xlM4V712ads.y0pgCDEGRqvc
 4PcntEpbU6Ow_.30DILNcjjop.0b7xAXfI38Cqfbgxoeh722JphOli4ExE3Mqfeft13rx6FZBjcr
 mDrHFZ5GbYE4y3TpkXgd8vDd3c6wjajN_EhMowSy23ZiPmFI._HiMZ13m76zZuj2vlarIn2mLTvN
 NRgg7nZikL1U6BNJWg7XogY_zZ6rg.YcSZ_2pKLx5htJY8.pgjDl7mwbxdIDDPm4mIVZo3Zcv4Nt
 sgbZVG95TJwL06Xur
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: df643134-b983-4a28-8b89-9f5ea3933991
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 19:58:12 +0000
Received: by hermes--production-gq1-6b7c87dcf5-rj4xx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5b607809d087525ffd4c5fd459fa4399;
          Mon, 28 Aug 2023 19:58:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 02/11] LSM: Maintain a table of LSM attribute data
Date:   Mon, 28 Aug 2023 12:57:52 -0700
Message-ID: <20230828195802.135055-3-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Determine the number of possible security modules based on
their respective CONFIG options. This allows the number to be
known at build time. This allows data structures and tables
to use the constant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Mickael Salaun <mic@digikod.net>
Reviewed-by: John Johansen <john.johansen@canonical.com>
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
index feaae09581dc..3c0342410531 100644
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
+const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT];
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

