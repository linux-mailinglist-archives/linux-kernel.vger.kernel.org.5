Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A4F79DA58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjILU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjILU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:57:12 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C5199
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552227; bh=Y4eR3cF/OSEH3onZVwRYKnGSOMuEQA8do45zV1I/Bk4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FsdGsvnX96nXPfaCgXk6XHumPAFbNhQUuluP/KOUtCDoBa4AGBV9Xz89C9XQ+RLukf4sYaTJFcng4sM+SSX3xqT0t2VAC7MrerF8H+1kTkeQTQQ9+5n2M0QQf7C/jkJsqOC2X2TnsESqGPUt8YZuxFxIZiZOvCtk5Eo32JAdaU6eAfsMF9JR+VC19Ujpa4ZiwAFofwhRznJCU4TzDiOP/vJV599XGVA7kIdl0R160LJW0IcRJ0KPmH8ADjWCfNUY+Zh7Ln4JQBTHgu+Rw65R4km8KhYolWs2cBSb36jhJjODrGmYulG+BcHwotR9pedB3RnwixBB4PxhJ7LbUeuFLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552227; bh=FW0r94/+Y2fblH0ky1pLnUkM4uOwUSCsAwMebMAgFmr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZygtBADH+rNAcDejuqsy7djZ/RfjEUL1xRUc9dkYjo3+FEw/TMpXPskDYRBjyOa1yMHyaLin7+rJ94l4WxJg3IdvjL7hFuCtervZYM2P86hgluTbbonFXnsTznCACs0CeUc0X2K1Vbetry6j7NZfjAz+LT+ob93NZj3uqb0Zs/kHza64kmc2uxVYbdu6ehaIp0z3PwmiGGscOXfxc/E+xJCnf5c7kquo8jSk4l0E7o9OyY22lZGA1wiw/zN8yWDw3xXt2DTxr6Dy1CDYjj2sITGUQbXQmaYTdGWZXOAw3F0DFzl8XTjOBMP8j0gJpFkHXWnFkRtQjkaq1aMiD4PXBw==
X-YMail-OSG: xu1WkRIVM1nA7oxR2FIwoLIoH6fxFf.Q5hR8nb4sgvfQSag1NYq8Rww6IBCFrzU
 zH5CEv4dvl4AvnSNjDV04_a4RkWYcf9Jj7HvNErxk1YjC6Hbny1jRuDWULOeDDdYbx6qvrrSbNNc
 e4Sqlxz5kosRka0VFbTxjU0bm2UCwAQaD1KRY44wZhaoI9k6ZFXNoJazfCL5LYI.ZFtKWNSmSKQx
 hCqAMd.lQIDhb8l.cnh8rWzxg6QxResrpE3..zjUK9dez6jwDjdSAh_ymDFtdZ72dpiBFoemELpj
 MavCC1Hus.ODqkx8Z6cfqP6.GWJcJ8yFdOYJJT8ac60ssT0uBtpdRa5_4Nzv7j._g0mVZgSkLRHO
 kOav8UCVycIEiuMFLou4Uk408Is3sOsM._ScSfeSbIqpm2VL8dNFkRs1WrF2D4OKh.8cZLoArmCy
 DO1gYzLbTUaxb47Ueas4uR1ECwSmnnXEfEHMNAFoD9yX6VpzwtfVWjEMcgtPigVMHhqu4OcodAuD
 nw7rOmBASa9eUAxWdMIY5YbkoTFVkxeM31z4akEq_YAyTJJ_tk9IGAJYFJbJ4lOoga8YneA21UKA
 F1YEiwr2b7FuQBazg8jJDv6TvYp5Wgs0Wkuofr6YUgW45C4xGdn4rOEUubxWZEdpZyVXZyNinaVA
 4TGiEmviWfw4EwnC2CUP3hlFRis1KbFHrxWRbqQIyZKGh15Bw0Btnyib2EF.9agU_8pIRk0evVU4
 r9DyXi5rgkB7czZRYz1tzptNpnJ4OSkUQCl_xPKFByaZMzmIQXoUYMFJ0uo.VvaJR142RASKGrqq
 eMyrfKNjCRrtMajQmoxK_PcDIOsQ_TEnFNafjlLihAAXF4rdJN240UMJuC7TMGUCGCs9zVGM91GH
 TF5KVzwmkR0J2Ac5OY17oP2RzzjLkkZ5qELbTWqi2n67R.oOO5fO_TJXNLRjDsqlKY4sE7HhiuNt
 mkD4TVC9NsEA70_h6c.gB6UrUSGJJLNnuVNp78g6gu2A15OhqzDGOKFJRgAyurups3kUdAdBnGQH
 SV_U9qNnD4xX2wrzEJb5JYs1GW3ZIdEK4ktZ9g9.if.VluTu6lQDmtsCEU2zVW_PvxEzAb8wT.Ud
 oR0V6QHhO9EcEm5pSKvsI724MnuRVoI0Bs7dLYeuAzQ06NpXnvtq8AKNZPCR3earQrd.IcHlv6nS
 OEgpXRF53QgssoWW.RTJlkkfb69k43qkiag977TSLqL51nG_eUcm8Dlez7WN0X6TUJUGn0aE4Vrk
 Gp5fDdoKFKHP9gRCCGtm3WOtys_h6XYcxwFXKvBnLezzMbxjePrP8VrCo.hCiXeUdlBJNX0osWwx
 Zu15OR5SBdLM9vAsT.KOBuqLN91FYCPVpmPgvZi_q2lUHsVpzSsiUYkHojbgiH37O3MG1Kn7KstE
 YBnNUjMNYEr.GJn_cj1M4ExUcIlO9HC4Z3Jw0nKbRfNdDceCvGpLOfr2rN7JZTpYr9ytRhCNNXmb
 54aQ3vCDXrZB56DcPwjWP5mxrgPT3cacqh7JY_MyiF.leZjZTlXHbA7CTRdF5CqZKACCRwpOZG24
 xgc1U4iWP_PmSbIOIsa088p1RM_IhNu6d4edZq48a_sO7u0KMkjfFHCfKxCwicKu3KB.6_Xbi.OM
 ZLIJG1ZghfvnpDNnq5xzsHtPXdX2CKQ0LKCjt01hTfkSIXGlvfDQKsd20KzqRMUaw2cKGup9cXAL
 cvfa6cUPxFEioL14WlpYOPOSTA4NL7hOFCptZwSFzPk3bthTXKn5rgpfowHqFlua6jn_m4jpV6ed
 w6wibNnGiBd2dGt2ROu_rQ2beJxjfAmOdCY97ZZYlotbyiW_2VGGrAf5kCx5GajnXOvaNYRzAgkb
 ipsq8mr4liIOjcaJUeSiK7o3k.mVJWHCENvOHA5IE.sn0PkLHws1qtVu2ldCFBo4mfL9BZsN2x2_
 t947CQXuZ7LGhi3X4vc5LrpwY.S4UGqSgFN7X6csHwz9XAjQonKpMWkjG17Qs5FCBRCoO9Ico_.1
 fsjuZpiEQCXE5B6uVrKwrIRtnq.ykBVUxearQa9L35CU4suieULMPI2XFuV4afLaHkX118gANT2C
 G4rPu.BfqN5eSvMm6DR7u3nbGXNamIptonrryswrxp3cJwckZyn2G3IB5NW590FwSWfxHxrhy1rl
 SKfvDbdnt6TBQkxHqda1Kj23EDejkBuA6DxNXX97Eq1PxKFmKJtTVSRWY0yJqnh1wsHEGNC0FiFp
 xttexCel4p_1KV4TAqNlJdPOTm0XhPqvaeNcPXxpib4jn8PT1oaE9I0AB6AOwz_xOUa1R1bHUFni
 VdrDrKiIS_4o9xw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8719b6c6-5de0-40f1-8e18-ee998464eb71
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 20:57:07 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f651283ea04feeaf2c9a6af092ec150;
          Tue, 12 Sep 2023 20:57:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 02/11] LSM: Maintain a table of LSM attribute data
Date:   Tue, 12 Sep 2023 13:56:47 -0700
Message-ID: <20230912205658.3432-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 5f16eecde00b..c1a6af37a538 100644
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
index ea69e83936fc..f71715a6f5dd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,6 +34,25 @@
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
@@ -522,6 +547,18 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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

