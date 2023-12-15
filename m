Return-Path: <linux-kernel+bounces-1754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468481538F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DBB24105
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF913B143;
	Fri, 15 Dec 2023 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lgAPuz89"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C018EA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679179; bh=rEz0OJc8nFf9kWkBCfqRtfoAcWA/jm97QnB3Ho7hKzw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lgAPuz89S1/R/+ijaVL4CdZPKAN9+bbK75NMb80OdMRDs6lbBSiAra68+4OHq0ZeVYVs162JRpSVll23PqcN97Xyu075mSW5GgIhcUDtsFpJumns83VwCOkqj3o5E48y/UezGP5WogwlNnoWZf18bexm4vIv9WbvLYWsGVaeB32CcE7WtoJlaxo1CGsD1DPFQhVK0hS8MADFSnjp7vHrK55pIbGFKk4G+0tfe5PGvQUi3dFELMICUFDjc96/qA/W79kRylaveGiw5YXspKA9hHkS/QFGoZcfWDLnt1atezAibFHCvfLb+111/fQfEZHA5zjvd92D3InLIOxyyjnLnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679179; bh=smnZW4VeD6pHtPVZifDGQCxn0DmciFPSthPYcomNrfa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=B6nQqUDv3WrMQDocvRJ1+CFVK10n1SA/0348TLIDnLztx+4J1AzbG2ugd8K1KeqzYjvmLd3W2cL5CNXTX/LouTICtgFo7SsaErF6rPmKQUPWKjzyv7SZsy45tyGFJ8j2XvsRU+n/EnFm51sh3qjVM/MrxrbETO6xsyMztYXRPd1iuBzbkID9lMXWyY4vmUN6K4Zuh3xnLl0Ns3XxfX96TwxsryAd42IpPGE434TLc5JeqHgJ8r9voEgp+ovREcRHwTBftFZxmUR0uqSW0JRfRVU/YDvIdeER8pmCtFBxkPzVflDZKfBIPyodmN7q817aqUToHGQaAtYo4wgw9GpcgQ==
X-YMail-OSG: p.dJWzcVM1lYfQW_x5Xn0e67PlR.G1L6XH3ostQy4WcPfZBRFNM4TIxpYKjRcXz
 Vy3ayZju0.Qk8o5.QWydogqavZjOpse3PSvjb.K1cvza1Tv0lBPpzxL2iG3tJXa2mc5kehJR5ZSG
 76Xviodp4Gk7XXn5DeFMC0KZ11UwsF6TM.TLNlDmAc.DxbtaI_YTwyyA3hdtfeDf_99PpyHiuePT
 r1JssMgLr8uVyd4Pm42BM_NZiOVsB5nQNbTnPvKobhSjwb37gglmHZs7g1XLrov3u4M_0a67iSlC
 qqnNGNp8KWKZyc5adezmWvgKCCKKxrHw8XniHZhIP.Rj9OPM_tE.Ty5Ot.z1NJMKqCPxAKrji1fj
 lJbS5A_JjtNhGDG0BQuBwLs7G6I4TH7PJdY98rzhG9CTl_hqI4abzbHjw1P4spxTn4MiB0Tp.5SD
 Ja_asG0uyFY72Zg0T4qorKgoQ4dRhbbRo_9G4WFGWf.Ki6VjrHQXge1JBd_N993dti8YLSOZDfUV
 ekpX9yZDCaB6I8ZZo09xhcmFwICal5SGbZttH0qrdXHoBmG8yehriVUfmVvxrwa7AnnM532ljWdD
 A2s6iSfW1vOJhx22g2MMvDWxfUo4BIKHzWa_tNr6ZPmcpCkqPekuUOK3KzjtjbK67elVbz9mRR1x
 d9tQT41Rgv1j65sfyKlXL84M8hNoo7by1IHratjaPBO7EQsN_DU_V4yRhqaZ4yPInGLdDqgl5bbs
 OPkNTTtSYuxO_KqAvliD82f6AIeIzwabAejcJk8d7ckJDZ8ZBCtXMywVgaamtmBfO_RpeZrxQ7Id
 bmtoAILn6PJYseKjFG5jzEQf2CCNfFRHNaD3O09AYZYtPjCfvZ0JA2vQ7ba_e0AZuqIwFrvma6nj
 IPmV_XQwDGscjix72KIbbG_xjFohLY3iXqmheZKYCD.hiJy_8WY_puMtlzYMihG.coXbHzxnGora
 rBq_d.lBRbNuRT5h6V31hzvf0BOpN0U8ovAbokE493sasd6Q62fFOdEXqLX3vE2max2xUy.ucetq
 3bkNFVjmGtTQbUQ3VN.zUxMKGyxxndnaHrFg1t2CpZQ457xpc_mtDxCqczcJQV65nZjbALhyjG3a
 9qtterWsOuSZPpwRviET9Uivd7UZOLmjvq5krSJkId1D7GrzENxuw46acI47Y4G8Ri78C4ljn7Jv
 4nM_KTzhwuXLR3uAb6MSxySHL9u1uvGin3CZMJSVY8JLoOdns.0U.EyyEXzsI3elAujJTea6pJFX
 2iTaA6ZBPP6vnjOKSNC9DJz_T8Z0fWPi7yXawLTMkfXru6OKVm6mspjiL8qwQBJ1rc0JV1Gq6UDF
 .aAEWaBLLvSESDxDKnUszsXuT4j0QLQ5yigNtDLB2fQ63aN6nJwFx5UbCLhrOumYGk19PojbAT5b
 O..kan4SIeWcowvv6bKQOTfaTbFa5eD15PHtgi1EbSKVWQuDydUZFa6vNeTa.FzYZDG6_acY77J9
 Ce9OeSV06mo5n8rQD0iRiASvzxNVv47X3_sMF_a65TmUNTh1cX5jSrrz6qoPTizjb52rY68RR_Wz
 kReDZttV_3O1h1X7InI.vSBtqsWnenryfXCeUk7Z7sMLTo4Aa4cl7MGdDNRh0QZ8HA0wc9jcQVTn
 Getc9TnIciE_CH29P55_l9LnWeKE1FrBL.lR_QYEBTevgwMqW0KaXojH5ib302J4PedEgvUA8rt3
 KvEsK893TX6jrtl6Ls7XpAQsr0B8cZU6Q.DE55azP05ZK3Z355onPR8L_u9HZNn7PXd3YWj3xr42
 htWK3HC7CtsjSCZf9sx6FGH5n1TcqAVFBtjr_dVfcnukQnn5xK23tA0WlpwI_aaBkKSO5_tCWAGa
 weVMUhUXYn0P2QdFjlL9uMScvgyGGajtWS.PeNorqG1pKYADOwt_EmjvZiFcBF6b1452v5uNNhUn
 yBbl1hVIXdXF4VA1X1hdxmmwUJEQVXGBKCNZ8DOM5NoX8_3YEL1XAc.fS71lwNAcbLXCSKBTSnV0
 gSsyRsUaMENhLk7Nea73PsQ2NwS6lvDVamqVi1HvzznYeu0Z.cMqPTFebFYV.eETBhUCQCgpJMkw
 gR.dvfJRU4ucf3Ouvbc64W5Eq9Ab5wARK7imUAAwfacG7OfCD06XLNL0UyObWIBc2QoHp2PwUFgt
 xz7YOejldqFrOB4ylpVvovniIJz3AAMWiP3U6.ZwWp.EputK1LQl3Z8FFM5h.NFA0l8PUz00.i55
 LtTaxO1nLp7lZOJryhKUV52RPpA2f_5p4HGV52mm3aRkTXufGLCjurmnxwfOyGwJON.aqVqFSfcX
 qeAZgrDs9qZ.XPZBks68VCBOK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f742a184-4405-4544-a521-c51fc18dd0d3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:26:19 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82d6a093b466d43a3aa36e3491ebb0ec;
          Fri, 15 Dec 2023 22:26:13 +0000 (UTC)
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
Subject: [PATCH v39 12/42] Audit: use an lsmblob in audit_names
Date: Fri, 15 Dec 2023 14:16:06 -0800
Message-ID: <20231215221636.105680-13-casey@schaufler-ca.com>
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

Replace the osid field in the audit_names structure with a
lsmblob structure. This accommodates the use of an lsmblob in
security_audit_rule_match() and security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index b1f2de4d4f1e..6c664aed8f89 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b15e44e56409..aaea62822505 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -698,19 +698,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					/* stacking scaffolding */
-					blob.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								&blob,
+								&name->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						/* stacking scaffolding */
-						blob.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								&blob,
+								&n->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -1562,13 +1558,11 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (lsmblob_is_set(&n->oblob)) {
 		char *ctx = NULL;
 		u32 len;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_lsmblob_to_secctx(&n->oblob, &ctx, &len)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2276,17 +2270,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getlsmblob(inode, &blob);
-	/* stacking scaffolding */
-	name->osid = blob.scaffold.secid;
+	security_inode_getlsmblob(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.41.0


