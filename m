Return-Path: <linux-kernel+bounces-1757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBBE815395
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702D41C24411
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF018EC9;
	Fri, 15 Dec 2023 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RYo4PIki"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40218EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679275; bh=rpVF07UMGtg88DKNUmDaWG5YnR644Gu2+YORdLn3CjM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RYo4PIki48OzhQDXTVF78fjQALs6vR1XwPl1zE5is6LKjjTqISVMy0SAf6fMYVUjXPuE/YZApCzIBBZ4gawjXwxrnnKQiFIO8HtR04HSOqKKxL9JDq2cqise40zmDJi+1m7itqKeZaM/rX5D0rDj9kANIrae+NXicYYDKAus+aDCsb76tShPd4hfFHXvY0dEThd9nf/aQAaSasLa2kX1bcfeeReOsDTGaEfV6ElS4egevQsmLDeNmabQ/WdDGSyu3rV65x7uSZVSkiGj7V1yVWo+TE97QAqJdTd88hdMs4Yy7TCKv4ebRJZ48f6AgSWmMPFVPSxb1QB7i9WUwVcL7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679275; bh=KjvpqDT/X0DPTRduLA9P9hC/fZRG9wcfX6H0AXdSwqo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rUFoS6wAmIEqGFbDkB7rg/f6y1TCaBLOeMRSOhdYOt7OJbb8fSWZ4dC7ytvj4a86TxK2isXCTg59t453TQqpz3AIgpVWJgWHuF09dveiXQXolrCpumR/31G0IUTsP8x8iq5eFU9yjkg5hbY2dSMwQivWLO2lC7Jp1I+HhTlkWCIdY0J8wj14nemBu+qL6BExQD+EOvnZzxN4DYy4xZlMBpkgxCfCjfSo1905ZyebG2wqJvFibKjDp775DMMqxt1/C6qth+he4s588aMYQwjkxEVsO1Wk8Yx/QHMgMzZ1GlypQCBH8H0B3a5eH06peQD5Pv1ArhzolEWhKazzi5AfQw==
X-YMail-OSG: OwJShbQVM1kRuOTC47pBP7x5vUuEs8W6NDxO5m8rzV6KQ6rWDWZ3H4XFIRb3g7n
 o2y7UPcTEFJio0bDWBpFOrdKb8QliZZKWyVkKIIXC.Txp1ZsRJ_GAULufHP3IOIEuLnj7GGiZYcP
 k20a421F6882jxB.DktikNoCdrLwuR07CpnZydiVPLE.KPI8Z5Fwa_ruK3g1VNfLqiKWgWw265lx
 vbmMH8vDM7bCdg4Rni47R1jQLKtvNDNuLw.x8NaeHRNTX5noetebn2FjUaxQJ3HbZg8p7yA4AnnS
 2_ZeiBZbCwDDRkfgjd2A.Q2MGR3rtB8ZsUrM7bo.SxSzIYm8_Rnreic_756RyZb4ysygh4DJ2jqd
 bHM3mN.ySN0_ketgmlgeNl5rfZl9gV90U0bNw0Xlc9KqeAKV6BCDcgBw2XaumBxMydZz67iEGktK
 ZnxZ.f22p7EYMGges5DZTxUe9KFMn7KQikD7xOsgSijgRYUSI0.JdqJpJ8nublFyfysaOVvvQ9hx
 wg3F7KGItOChavAszQadWJGUCKoMJdyhoaPlcTCNO.ZTn.uTRPQ8.8IdGQsE6QOzthr.aLlTsTkc
 bNZHN48RmilXBD18ZpWGbf6iGvdtUSK05yyYcsuRw5sqD1lyxE802GbRTueLzMp50mwtaivL9PRE
 Qyz75jsca2_pn_xY76mn.xPD70caRHSxzvV4_A7K_cp.loymc.teWXuF_CmJSnaLIpFqbXCvhbPO
 xK6QsZJgLatAy5eTgszZGT85rsnK3V5XgdT_qsSp3IwXkGjF3BJors8e9bxQKt0i9RgClL0zeI5_
 fXQiHuok3Md5MGnG42wZ5daygPh.od2E_k1rLPVHA7XOk_ZUlriG4sIWDP_fxjzSWE4nPA4Z2uel
 I8Erm.dNcee9gD4YGqvUNHGmYtLG01s3xHLnOnTb_C_irQBB3I_BmMkR3JIuO9sw_YtZBAzlE1Xi
 bMyENADb2lU_.PwEKcH7NdhePYztT6J6nc7fyruAfs7tEgiC6wYcZgtAGkIcpNfTvGpRQC8LMSYn
 o7J06vOzd26UeYwIH86tqHFXv4kzGius0AtDeGRy_mmoW.BK3DJeKdlzOJtpUiBu.CdYGGMF04fU
 GgeutXOwi3g7LvkINK7o6R7.GWvhE.HxTzAhWcv1h9AWg56NerFSAAoEIoAWx4NR7B.9HcdCxipZ
 _zJEX8qq.SknusaBF7DgMsK_ogBr7ZykNzbh628q7yTWpGRowsO3FowqcL7.VXRgPbZqiMD2y0.d
 5p23P48KANFaDBUxEnv3_pFFmyqzaT6cddP3sHiifDvdhJdEk7syLtdXhGIswkDtA45152xnXy15
 YXlTKvKF3AztkVGTh_zYjP4KcpD3FbWQQnFKysxT0Iq3kywyTQqPAZqYlTq9osY9dkv.5Cir7Qhg
 _6Ombz9zE_w2JvBdzoMnJJnHOu3f0ZZKpODNfyUk6bF_QFYEw2q__66x3XjjkKuXoxRNjVYMhKJI
 1W.OPKnUCGvQOFcXFEe1zsUKC8bBdBPlpwB1yH0v9NKge1UF5Fb64klVpc8tvQ_QqDZbo0.VJ5gA
 .mXwfr3_9mSxZerA6XoJi39IZ71cfrRYimsWp0wFTJAGpP4EKCJ4ONq62DWhIIzYTVlxuJpgzQ1w
 rX6uTQfJlbwpCbgtyC8gTCpt.2pxty8R5Sa3XwSlgK0QewW7jAHxHbyQimKBjd.QdPput0lpMm9j
 aai6CfXd0xlnoFqahrhh5p1H3EktdA1g2hc3rJCfig0erJ1zAO2edZ9jrtm8GJzuBSKGPamLfoQj
 ghvyz98n7xwxsdeZ2O.vxfqg8Cz21GkOgnlCnP7SJ_1QmrSbEtqoFvXS0vvN1MPRgXc7_K4bOQqQ
 nIRm_V6sdVM25PKQ3ekhbhcCYl5fn3YXlKcCRkm6MDe4YV7o1QD7zOopYpOBSRF4wpdxe0E6uusf
 Uohmb8Iy5ujvjHVVetb5PwSSrc6C.2dJFt0OvJ7VJJm.QuJXC1J_rSZ9Fp8jJZTrZFLpkX7vYeaI
 8weynnlHCN3tsPRh9WOuVoHMacS247dU23AQ4tId2PwhnM1_hxYHd3dRZDtxMwFKRB7wG.n16COX
 FYeT2Cpa6QwpOPcnqp.p_yiyFGUlgoA8I9tfB81XiZNMJFc61oicAmNsliObstikL4zSFFElHu2T
 zll5L7mbNYE.ckeCiNy5bEZ4.aO5W8BwswGZKr85tX8ptz4911g1YrALJGu3wRiK9psfzJa1PQnH
 YpcVZHChVOmyRjYwb.o5lfloG8w_ixLBm8o270YVrDaWX4GxKOgRsP4aAbJgicQ2aYgSb6SkIGjt
 l3O5dmHdUDJpocf4adNQqEXPlrUEp
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1c8bf860-4283-47c4-a644-eb7e3b01e7c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:27:55 +0000
Received: by hermes--production-gq1-6949d6d8f9-ghhkt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2d8de7c709cc71c362074832ee86fab;
          Fri, 15 Dec 2023 22:27:50 +0000 (UTC)
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
	mic@digikod.net
Subject: [PATCH v39 15/42] Netlabel: Use lsmblob for audit data
Date: Fri, 15 Dec 2023 14:16:09 -0800
Message-ID: <20231215221636.105680-16-casey@schaufler-ca.com>
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

Replace the secid in the netlbl_audit structure with an lsmblob.
Remove stacking scaffolding that was required when the value
was a secid.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h            | 2 +-
 net/netlabel/netlabel_unlabeled.c | 5 +----
 net/netlabel/netlabel_user.c      | 7 +++----
 net/netlabel/netlabel_user.h      | 6 +-----
 security/smack/smackfs.c          | 4 +---
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 43ae50337685..03656b8d0b4f 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -97,7 +97,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsmblob blob;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 129d71c147f1..7bac13ae07a3 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,14 +1534,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getlsmblob_subj(&blob);
-	/* stacking scaffolding */
-	audit_info.secid = blob.scaffold.secid;
+	security_current_getlsmblob_subj(&audit_info.blob);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 3ed4fea2a2de..6cd1fcb3902b 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,10 +98,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	if (lsmblob_is_set(&audit_info->blob) &&
+	    security_lsmblob_to_secctx(&audit_info->blob, &secctx,
+				       &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index c4864fa18a08..1a9639005d09 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,11 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	struct lsmblob blob;
-
-	security_current_getlsmblob_subj(&blob);
-	/* stacking scaffolding */
-	audit_info->secid = blob.scaffold.secid;
+	security_current_getlsmblob_subj(&audit_info->blob);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..878fe44b662d 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -182,11 +182,9 @@ static inline void smack_catset_bit(unsigned int cat, char *catsetp)
  */
 static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 {
-	struct smack_known *skp = smk_of_current();
-
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->blob.smack.skp = smk_of_current();
 }
 
 /*
-- 
2.41.0


