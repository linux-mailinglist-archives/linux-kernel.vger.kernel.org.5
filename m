Return-Path: <linux-kernel+bounces-1745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107E5815379
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350BB1C23DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6FE13B13E;
	Fri, 15 Dec 2023 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iu6zT0cu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34018EB9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678891; bh=r4sv6r1Tr6ohOGlxHLuy3Yttmx0SO3JcXgN2XVd1JEQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iu6zT0cuHdfJDJ6T0Hgcxgd8VjwbeNYpCQAIod7PuuUjYHkuQ0cdjFl/v37RJUaFTYQRnncyCasGjHSgBeyeeuCwNZaK8B4YSJY2b8+l+H3L0b1oe2D6a9aaB/hlMxSYZonfHhRCCJKJ/PQWU4ueQ/8wVhn4Jxc2x06a+qry5Jug2XiUxgwrSGfHQOf6wv2rfrnZatTT9pEvTFvzP5VWR/QEbfZp5yXmzOtzKWEe6en/N+U/PZNK8X9baXVAtVXDgN8ArT1VPTPWoTtwvv+5a/xw4VY46X3cRTUwVbCuQLdZsGr76m3pSzu+Kl7zB2nMe4GATp4MQxkJC6r0ZLPyXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678891; bh=FbWzL3LnCJaSNO4au1TSsAw4G5Vl+MLv7Tk7jzgz83V=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IT9DB9mWGFN/PLrHpbVaNeWJPDIkABYpTr4biFXJwiB6W39mDyAVYiS7mjvn7GBitxiGm3HGidfyYn64JaLvUv9LWgYiS7s1V1XlWoyqlJF8O8CoCfxAAB97J0CDYnfJ1Hj0SwIt6JhnepIX4w3dvSwxPQLdCfgI+/gtf3ZURb3dAXjRHLcUXjg/BW1svhzOhXJzSadMPagXZbRToyXGnIkZrnXoTSJ8GLIlQYEd38ZAipgxuzSyVMbWDZvDS2wdV+x4du9lt5FEpCNS4kW0Pj+nXXqzQeu3hqhi+cmJr3qRrXTXaj2PIX3RxMBejxm2RQQjFKchmIQcGwX399fm9g==
X-YMail-OSG: lneyKBUVM1n0tAl.3lbmcDViRn1NZB4wLS61.xpg4tIs9jEH9Wl27J_pAuDfNdM
 rKL.zK3wPg8zm77CfdgUZLBpJQVe3QKy47u65jA_gQNvd9sqgWO81fJxc0MroEb78TObprmXI3U4
 9Ie01xUMycu1QwjA_FE1wge1I3gDbAcFKNhUL0T16xzGoAED_C7CfmXrpVA8YYemeaG_AYY74d.a
 fVy5Ky09LOyKh31uUm9WTV7Gt3V8aZ3scdIMVBdZDDt8CL79hEOM8mHrVeJYH9faDogx0s2sJwnV
 unxH2BYBFBL7Hq11j4UuCTNV3J0sQ1C0YTejQieGWln_CbgbpaNHIqJiRyjT7cJBfU1005xLmNAt
 9ngKzGmuC.NsaxxgqkG6nweGY_Eec6cLvrIKn3VoScjdXtHmi3euX1PiJwfOuigJFNHqX.OMzaOd
 FeUHxTixwzyH.wmO1mojG_2g8yCo1MoYfUS9d92EXZcs33QcF.3NBEgKUbpFoPjHwMifkHYKNp0Q
 xn.0nb0Q6IkEhM0DLBvi3PvyKvDjTUWWZEmeW32wKM0sWJo5ot9tapJ4cQTpS.zSaOu1TiF9NtWf
 QkQcc0Lny8ayB_J2wGgbMXPvUThZ0PgKWZgc0DNlFV4VpD9NojmzpFBUtna.79b7yWVg8YjvA3iF
 IAkeMzsBzfQ0lPUnhh96FzR2QhVdsIx7Umsgr_o26wtaQ1aUnlt1eKCKVI6wfHRGFqm2VmbOxq9o
 XCA_pHAGrvRCAtRK6afaTuirgVgtPC7ACwITZ.X64INn4CxyJAidXX.i4_YhaA5pNqL8AKNoVcPn
 oIqdM_Q5UZkO5MUwOrEC_oLaju0vvQW4N0OENVsin2iclZijPEs4rYp8yVdHA47P1p1uveSTy7IJ
 U3vETKdJWrXilXJ.YBzgVTJapX3bUwOxuhIkm4adeTBIsh1ueMHQSJnIWIcBFRxW9XxQ.Wks.Jyo
 cI9ei2o1mPNaDsswPOjR3BHFb0U8bWVqhYEBAevMV3dih34TjobK2I5yMuQKbTz1S3390sSGu7Su
 9dQ0gVuq40KYLJXPVAWUMhRQHr3ODU4rg6vxb4QmqxcADz7l4jEkUdIING6IJr6x5SlwSjYBtGj_
 ua9cSvyrj_kBMO0DGK..HxS6q.31t78.NhFP1WJ1rbmqz5SpLB2RtiLclFf_4mV9tt2bjpfmjbti
 xVUWjHqLEcXsYnUNhOH.2LGyciKtppBs9pC6BmzXcyPVnb4KpLTkA.vs.ySwE8LqdThvXaGwAr1N
 ItU_MuvOrytmApjSs8PriPBtf1XEZEISla6pkEM.og.xGhmLDIHqY64bkKXASSgo95Z7ZKszIBvD
 3PuRnWuiR7.NB7sjd_ofuug5sgtS0uchdjxYi2olxgJxgm71cXNmR0_.00iB0HaFTeRD3bsNVz_q
 BslDNT0t_hzrVqMdCtaXLDyXsOtqe0bUgeoz74slkaAYJDJ_7rPSx_VN8BuKKtZIkZINWiOfF09m
 Y6.sbHzoqZIaGXeIJ_ASHYJU9H2U0ijrsSOSlmPpVq4VbC5l2B9onO_WLm2FZV0ZQdF2P3QrncLP
 H5Lv02O8XF_EwxswUziZ7pLji8QERX7FYLJcAMO_231cSwqJi9Y_krwjPkdiIByccI2SuZlgVDD8
 qvTmWKnIzk1jQeP8tdg7l80b8CNPHF0XCTUZTc3fGRkps2xfNfGQMhn9z9e6X2Fph_dULGUOz3nT
 jugd30_.sxYj9aNR1W94TNWGMaS8uMKg.S2k5z5J1X_orsMD4qaXhxn8xSEeL1QYx2EbwVblr0yn
 dDNNsU_f9QkCh77OXYfaaxeEQsASMQhaEMJAcOwt1Q2MXqwZswN8NYFCq1JquEI7DuTPuCIweUmh
 2RZiuV8L4mCOdYDhmPnTEixAcATUlFjQSA4.GnNUJt3vOLCgMqawHcR_nUNWZ.igFffj7Y3abihY
 zKg_fybf5MZJ3PJ30rXwhLsD38wxQsjBSx0JBEPNeki1QON3qTgfn5_xv16XIjKPk1SNNg6FUPdm
 n_kdAlHPTdKzONnvNvlfszIvux6NwXC1BHZMIxgD64yRvwuFEEQ_rU2BmPcPjhpFBfbSkQtYJJnz
 FCksVjAj.ixTQTeBpvSnFPiXOih91OIZUE0xOgHBUdW6LCp.N3mHBsL8cjfQBUMG6uRHwYPU9uNZ
 AOubAhOVDjtfz8OT.pww3_zIwXkBjLMGDV2MIl4o2lKbqBOIZk9C1c8mahfFr494ybUWxEs.sM16
 LifJFAAHBCugFy_gbq.2ULiJAr6kP_ak_csVel8_K6CSN0SiqbNgGeZ6_xfnOrcEfpAsp89KvZXz
 qs6PQHcwp60J2lM0B56DCgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 971399df-9dab-4e22-a79f-53d4c0fe7e57
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:21:31 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 53259725741f313dacdbfffb86fd7fff;
          Fri, 15 Dec 2023 22:21:29 +0000 (UTC)
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
Subject: [PATCH v39 07/42] Audit: maintain an lsmblob in audit_context
Date: Fri, 15 Dec 2023 14:16:01 -0800
Message-ID: <20231215221636.105680-8-casey@schaufler-ca.com>
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

Replace the secid value stored in struct audit_context with a struct
lsmblob. Change the code that uses this value to accommodate the
change. security_audit_rule_match() expects a lsmblob, so existing
scaffolding can be removed. A call to security_secid_to_secctx()
is changed to security_lsmblob_to_secctx().  The call to
security_ipc_getsecid() is scaffolded.

A new function lsmblob_is_set() is introduced to identify whether
an lsmblob contains a non-zero value.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 +++++++++++++
 kernel/audit.h           |  3 ++-
 kernel/auditsc.c         | 19 ++++++++-----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7e4b31b771c1..029cf071148b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -276,6 +276,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 	return kernel_load_data_str[id];
 }
 
+/**
+ * lsmblob_is_set - report if there is a value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	const struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
 #ifdef CONFIG_SECURITY
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..b1f2de4d4f1e 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
@@ -160,7 +161,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fb001300f0c2..52b4697d938c 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				/* stacking scaffolding */
-				blob.scaffold.secid = ctx->ipc.osid;
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 			audit_log_format(ab, " a%d=%lx", i,
 				context->socketcall.args[i]);
 		break; }
-	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
-
+	case AUDIT_IPC:
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsmblob_is_set(&context->ipc.oblob)) {
 			char *ctx = NULL;
 			u32 len;
 
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_lsmblob_to_secctx(&context->ipc.oblob,
+						       &ctx, &len)) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->ipc.perm_gid,
 				context->ipc.perm_mode);
 		}
-		break; }
+		break;
 	case AUDIT_MQ_OPEN:
 		audit_log_format(ab,
 			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
@@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	/* stacking scaffolding */
+	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.41.0


