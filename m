Return-Path: <linux-kernel+bounces-1738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D1815360
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059AB2862BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE918EBA;
	Fri, 15 Dec 2023 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m1m3Yf9c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCF18EA7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678606; bh=FmMcsVVDLGfPaI0hFOy8AYrMrLRvj34ZN+ckuE1msOk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=m1m3Yf9ciOM+tToNpqpK7z3qn2dnhZjs6lQVTgz0JD2oPdjAlYO3+eQR9OB7yJDlXfQqsfzqVh5npgvn1dlF24mkydf70HNMhPj2Pq3VesF7Z19Yummk0DRCsuwGshwPPA3PafoNuHDTsaIAFEPmaFJD8Ygw11LH9Mu/AXCOjLYDlwg4Y53SRDdNFNSSs0CRqcTtOUON1RwMUxdrYiqlJiLq/kzj5P1qW7Bhksjq4NjFIWszyxK0HhhbCXRTn/lxHV9MkzciEsrnO16W4O8xG6r9SM/ji9lZleXsFuw9pz7uw6sNYiH158oLvNTcxkPoxhzlgN9z5nLSJ3NpltwPHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678606; bh=rhXq6UaWj3lymorjt1SjraObFjPjZaSh7yi8ccPuT+9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mXNGDMh0LBTGw+XTniM1m7qNGTst9CF6/iGsd40kdssv790dpumHcGYr8JtN0F5qJiJcEMXorIDPjRzJm01twSHAMmYnslMxVlvvxN06+2OL5zJfYniy8op33kU0yVt8IA2hOtLWWOkL39g9jjx5BbnL7KvfcH+sNijsAPLIaemex4g6bv6dF0E02MhiTRtuNORWNCe/77EDpir1AyHC/iZQDL3Ou2ScFtC3k18jc1T/Dv/n7LboeLGiLJmjcMY+LV0tsc/vIlUxysp66NcAV88POes0vnh1KSa42lT8WsTWVYZSkLeiA1u8j1g/GwC++BxGPsnxOKori8MgTGMToA==
X-YMail-OSG: O2HtxKcVM1mb_7stTd9ZNKZ7qkd_vxRRuArVX4xEflH6EQ.OY.yFXfjCgI1UwjP
 tkkFAUYdFJJpupA9pp5fyvTgO49M9yMGMS2up.KPYE1z.2Rj1bwA0fXsBJBoDf4uf3sdXHoo.aFY
 oY2qL9C1Wvz1NOGxLeMPEFQuV88s.BmVCyJV3et9XB0jAUriPUYn7ND9gATf80kYpq3pA_Pcz.sH
 7cgC8pUXx1qMI7QTrLwxpbuSJCB6yuaRoq8NlzAf8ZU5F43HvdLlBTrwdM7OXwA9jrD4hpCKpMhW
 hJCmmw6zWNhy71FXsa64FAmA7RhDg_G61ZQlEkJyNGSoVqqHLwx1uJ66KqVuA67DCcplNR45cdSU
 TGSUIiC6JqtCrgC6cIOkclWDbaeRM5SdfUOfwcXDh326Xyzc_rL7kOMp5a5MvW0CgP4RWlp6HJlh
 GwrYZEzf66Rhht2TG3wwg8H07rHyhVVCnzInfebsMEJ3F6tZlEemvmZ2HzsLN60Ys26F6WBHqqSj
 WlujBflq5c5v4pWooEBKYaTSDhjNa4G7tuZtRROqdtlI7dSAxHgZCyeGY623EAK58KHuKG671M4t
 PbWr4X5vExVHAcjVc3E2jKvzDUWb9SyqKM2dPkLPU1OtimmEt8nu0vBkK32KHlZFqn3vSejF0F1b
 LUPwgyRPqlvVZfAMqDxPcry9XSbgk4GGpLenPtpPN.bvGri3lLRB1jgVo53j3LS14m3fCKXVS306
 K0R9nVaBDrzwfQFiJqcQ30oZWf_WLnsF30ZIKWpDd6XPhqE5VlF8BIVy7.qK4Ex8l8_7riMjBuNe
 riIUAW1jpmoTeJzljNcYWhxm4IKbropoAf0C6I.kPuZmxT.v.GIN7gbQnPiZbrWSWvlLHKoOw9SJ
 K8pj6LVqIrgk2V55DNUbbS8i_O9hbAy5bE6NkyXztgNueDGdz.ucqYwVu6dE2sfstwYTp5y1N4d6
 CONHksJUnOS62CTnS1bRh1G11UylfveCcMF78zsvLWAjG5R1Umtig_Fz9RCsi65dbh03osMdD9QD
 BzYkJfVHu_r4B6QP6JBQVtNJDIH3zrrx53obYcPi3pMWuQyX59ZW_hZKT_e6haYB9UObbVsvyo_s
 1zlKts5piDGRBG7.rjg.Hsni2vRkQl8rAN99S3VlYN3toSqDFTKjEgSgQjzOV8Bb.LgA9jwMQM5M
 h_5DXuuRlhZzyTSANd6FDJUtwaWDqwR3iNub.fLKgAbnCYf2ylWuTM_m2QWaAYfB0hQsHzdve906
 .b6b7IFBXuchobanW5iHCNtBaQ4LWvisPOpBfVz2u5Bk4molBf4V4g7ivQI5RHjv_S89zasgQT_q
 JX0l9Zs_CwfkOBCELPSjt.OphzypDe985doTAdvTuanjdocJSl.8MHWaD5TaotVagvXX.Dl1DLhL
 n65oggb7nzUMHlHccBlqghusyBtD_9tiUK_Jk.ln7xmsdKn6r4a7DUpvjz82c4eyvjtaZbdsDDuH
 CAkLEKJoR9U_T5oaQjEROv94lFXSJYEx5_ow6CpiuCGIVXCdeYwNKWu2FnPO00NAEI3Q5euWrxs3
 OV3Aap5EM78W7Q8jlTxHWHqlwTsy0zhKMyyb_CRzL.gICEhda4jU4RJyIwG51D6RZL2Xq0TolO.X
 XbT29E.0DC7o5FsS8Twa7QqaE0_l59Lqy0NsnO731DhiyKwDHvaq6aK_E7JQUm8Drg0H5bS1G2EC
 9LjZPxEeCoqXhxVPDBqnnuGOQFuxIpN2eb4oiLksMUikldRpDI9SQu74355ms3dI6QNQUL.uw3D6
 GLHsAxh7QseICmelTDb2kJIMxhlIZ_g7ofSEiPeUbXADtmLzz0Xd0XMQh5usq7f5IYrhRtUMktvy
 x8VMXgKup1iqPJy0wahF11ApM7gPaJBVt52IJFKI2.aDnvPqBksTT1vjPzv2.ZGjmg2hpsBsvAi6
 bOeAQDLBhWCd7dp89QkvTNelQyrAB854EUEmSmID1TrMGdoqdxT_ZByUHMyt.A190WmV9.5T9PnE
 hyYqWP5iPrEK8UAKK_kYW.CmaPfuy59K7ldkqQO1CQOZnS_Nv_VtEJk9aeyeapcBP5.xAeD2LIZy
 elAOnU_tAWJ_1wU6UOAhcs0_t10PjP7Ya6M9nHEmU8XsMuVfXjsP8LReK1lvwl1S3U9yMWyZLIBJ
 O7u4aGXYc_uKC.uh2JuvKWMjzSKW8Q_gF2hBtodIZYEib19LTznnxgJBVfivR.M.rSU4fCqCeioE
 Bx1oNnI7BugXQ83w9C2UWJK0l4D4CeLmNPV4yjd4J0z0d.O8C8POxEt6JMl8DdOEPstJzoFfCF3Y
 K5NijeCAaTIOUhMCv1Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dab07133-ca5a-4854-a152-4a9956023969
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:16:46 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af526ee8ff178a31e5a49e4e8cc011a6;
          Fri, 15 Dec 2023 22:16:44 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net,
	linux-integrity@vger.kernel.org
Subject: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
Date: Fri, 15 Dec 2023 14:15:55 -0800
Message-ID: <20231215221636.105680-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new functions are put in security.c because
they use security module registered hooks that we don't
want exported.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h     | 24 ++++++++++++++++++++++++
 security/integrity/ima/ima.h | 26 --------------------------
 security/security.c          | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 750130a7b9dd..4790508818ee 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *lsmrule)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
+#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+void ima_filter_rule_free(void *lsmrule);
+
+#else
+
+static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
+					   void **lsmrule)
+{
+	return 0;
+}
+
+static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+					    void *lsmrule)
+{
+	return 0;
+}
+
+static inline void ima_filter_rule_free(void *lsmrule)
+{ }
+
+#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
+
 #ifdef CONFIG_SECURITYFS
 
 extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..560d6104de72 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
-/* LSM based policy rules require audit */
-#ifdef CONFIG_IMA_LSM_RULES
-
-#define ima_filter_rule_init security_audit_rule_init
-#define ima_filter_rule_free security_audit_rule_free
-#define ima_filter_rule_match security_audit_rule_match
-
-#else
-
-static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
-{
-	return -EINVAL;
-}
-
-static inline void ima_filter_rule_free(void *lsmrule)
-{
-}
-
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_IMA_LSM_RULES */
-
 #ifdef	CONFIG_IMA_READ_POLICY
 #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
 #else
diff --git a/security/security.c b/security/security.c
index d7b15ea67c3f..8e5379a76369 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 }
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+/*
+ * The integrity subsystem uses the same hooks as
+ * the audit subsystem.
+ */
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+{
+	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+}
+
+void ima_filter_rule_free(void *lsmrule)
+{
+	call_void_hook(audit_rule_free, lsmrule);
+}
+
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+{
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+}
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_BPF_SYSCALL
 /**
  * security_bpf() - Check if the bpf syscall operation is allowed
-- 
2.41.0


