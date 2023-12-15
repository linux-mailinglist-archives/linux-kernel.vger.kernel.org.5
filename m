Return-Path: <linux-kernel+bounces-1763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF68153B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6BA1F25B61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8A30138;
	Fri, 15 Dec 2023 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QCZJbU6L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11E18EC9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679561; bh=wsEZq6q3+06miaqCNUNybAu13net40ImW1aiAhPQhxQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QCZJbU6LrMTJCc1hOfHZbSe+1Uc5TEhFp2zc7su0C2gO+NHc8gLc0b+UcqkhErBX/v0H/sUzkLGualahkkDLxM2jeKFHcM1Pu3Sx+Upyu8IBDSsOO3zIv4f9vLKLk8tf9a6SNNu0+x+vcD5zei0kTRNLM74I6hGnrx3F0P0guKn4gw/V3NjmOw+ZF2A1341/q3d7r6u9Jh1ZskkI3sLTPmgQJ+1PnRfatN2R5VyAcCNLIRekluI1xC5PmwNr9LPnvqLz9vVrq8YegGj0FHwkoaLC2+HfgfpoMGoT9BMLhmYumoM/655QOpbMrY8pZbieO7BVlvZ2TOE2diqFuupONg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679561; bh=7HZaBEZxB3eI5UhvDTGUKLIn6qQxXCBNIualX0pMysA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SptKgulM0OOltFnCe+1IgKhXS3sSbE9zGajcKi/1yabAbJ60yGEYJySCFW29wgGLVnC19IG6atBlxTbhJZfnp9tnR6o9C83o28fg0aw3i0aVtfzLGY5EfJerGqrhhNR8ES0UHio13RqN+AQ8KuH3DAUvSGIq+AnCpNcaw8eE+6bLQhujKczLAwV9KfiLniyMoRlVNBQsp2toAUY3cMSXIkFvjRlW/pJsrvDDPVANBVp5jYg7JOQI/MD53grJCflYOdL2X0+Gm8BYvFuiDJPVPKfQrYaBrtvQ+IuxPTvSFOZXv3d83WL5uczp6KBtyORzaLG6Gfmd5IdsKwI2FNVnhQ==
X-YMail-OSG: Q.B9lmMVM1ljekOpGmYVAs.JLwyntks5YzILaO2SQ316mgjmH2U05UxEPKy66Ej
 Us0tQUypAJNAcR7VEODx4vjQIul.hXqezoj2VWSxbrDmpItpayOVqL6mDodfMXoTlORLNzM4WG6X
 8dO3WC0H8KrnIFoo5FX3FmZbYKaR4HA16f1MYPRHZgIIbe7wq693RcKssIm8JYtk_4lDxXTwcjig
 fg4uxrhGjScWMl0nVX7hxEveY3BZyZQcV8mr6AB7m1b_q5oUGSB8bCOFBdVhfM51XUWMp3wjdPKX
 WnBlLRqhHsnqD5CMdXi59e9trKEPSMhN7JQo5x.D0zdcw2q7w5I8cF5FHjlds9PDsaaEpmFIf70b
 kDfGtmPdjDJ70JbCQQDFZOrXhUrmAdwUqWXpXFLZ8BJbTV7MalTNit7VN8w3B_uvjxcYSBpQHRap
 Q2mwydb7.KgtT5OuGY4BvBnmvd8Bkzul21._vfJx84xoGCPhrFvvfk2zMlucQB8N_s4Ej.wLYmgm
 QVR8n.S1V6kzdnG_mlfEU1IJan1miQQAcNMJ5vFazBQ7ktPRG1Mit2vJKkqsiEaenfOllfiHBADU
 ObXEjs7peS5SQZBgLmGXnqm3TZCzDOCBgZCM_5OWYErESq4R6SAY5MBFXavgy0UH.ssR.KLeCGdI
 NqqR8PnVAyCuh6uRwOb3B14bcVUjOJTilIBi_OICf0fPhwlogRp5N4h5CliCNiLYcW4SdPMg9A5u
 t2en8jdaRZCmnCcp4Yki.Q_H9ge4MIeNS7qC5nzllv_jWBD6VBgPc.V6SeKAbOL8yTvXf1SdViBb
 5paHHvVum.gc7a7GkGer4dAtVljgYbi8saZldYilziVch7bnkZXyUdiguXmVTSmOFcciSxkYeIR2
 8PWN.oSaFF8Vh6xXl5U.YhpPEQ3rxFgK2TCUu7ED9VScWAuwMMIsdxGxq71_UPZMllL.2wxI_53M
 LDY334lEnwvXjnBmdePckPcGRWS.tWMNOSaFWya0lL5OqDyMAfIDkL1NnisbsSzwtNZ14E6n87Ct
 qE_Zr1fTcCXxaNZ71azYf8YCeHa6Z_u6dHA7bcV35.8EVg1ne1Vj3LwvyhRtQUKYZgmrcipE0_hc
 NOO8db000zuhzkeixO8zq_3_1A3P1Hbgeq191cjMX1A_erXXZGdQKSPLVqweeTiGmtUecPFZgNdr
 ZJdiwVt4ngJeH8LxdbgW6wajyOuvB3UObAWSDo6LsBIQjSDvzK1bqccR.izi3r3a_x7EWfZk6BRU
 et6b6U8po9vj2sEm0KvZygZLTKNmbymMvcUeACm1C.5O2jWUhbntlAj1LD7KesGzU9EazdJ616li
 DFJHaHSEO03D6F_7QvUtk9SrL4bC1ZOFbkmOC4Lc1Vyz4uMctFc4flJrHwi7S1S5LNOD1mL73gKg
 0KHl0NAno9bjwqzes0DmZrA.niRWDYBunytUeFpxvEK8D3HpBekVqN6gW7x8_UEIXbxzwqXt2i4r
 NEXX9nuSc3tXP33_sugllxo8WUmRlxjEVatMEjm060l2dXwNs9OlWP0FprxNca53O5Fcg4kI68wz
 CXynIHI3pqTE7zN1ZL5X55JcpDoK83aD2Y3_LooT7dXh.pH.qfunMsg_a6Znx4m0Xm.FQBJkgvrB
 O8XmB3rwhTpKrTui6j3aVTBDahq._wND2bclVJYGJCrSDEfvDfwmblTo8Mwuq2r0rZCXH4t8z_FV
 Hda.mHOGOh7itxALUgtulE4t6CVIUjtVlLjmrgRJSYaGA4OaD2qM.9T6TWBOFRJ3n9aNATQeTMAF
 etXEuvPIgXgvAvI8QyTGr5X5v4jYa26hE52XOKulKx0N3Y8.3RJxNB5jGuBVOp34fspGOCawJb_w
 KlsMsk8JiyVXMFk2dAYfgz54.KlBninprh_7Q5yxu0gFmsw6_jjTSE0.kK7u3HKHKcN32Z9DNREN
 f6mtxub6AEqvOdrdqRVzhOwoWsuXSp5ROExQis4Oo.rAIid3KfBbm4KbroUNp8FusBGODwnf2qof
 P65QPE.NMp5JdFwoAbdLyaWjoN8xMJmCpgSUD1YeXGl.z8nVQc3pwDfbMZtyx5mraotSfBZ.gQKM
 tFeVJRpKWmfSh72VU3Wcyb2ZASE0DZQO2ZRTMQvrLLLb3PgvXO3PbhTayz5FWkfEJRZm7xOad6O0
 iZGklOA.67VHLbaUIrDqeZULEn2pjAObzjZGLX65_NiooJfcrGW2wRBW7Sf2yVk2d5NrWyZkf5nJ
 E_do5GxqgAlVRJrqUnJFz4O9.KryApjfQ5gNtdG9dpsqf8OiMGQkilPT2.otxSWfqe_3O5iXfx2n
 CkhcpUcUeQoQogEYhpp8CE7RzBd4X
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 74795a18-4949-44d0-9593-75fef32c61a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:32:41 +0000
Received: by hermes--production-gq1-6949d6d8f9-ghhkt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e3e0e17187ae06698f220367a4c91416;
          Fri, 15 Dec 2023 22:32:37 +0000 (UTC)
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
Subject: [PATCH v39 21/42] LSM: security_lsmblob_to_secctx module selection
Date: Fri, 15 Dec 2023 14:16:15 -0800
Message-ID: <20231215221636.105680-22-casey@schaufler-ca.com>
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

Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
of the security modules that may be active should provide the security
context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
a hook is used. security_secid_to_secctx() is unchanged, and will
always report the first LSM providing a hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h     |  5 +++--
 kernel/audit.c               |  4 ++--
 kernel/auditsc.c             |  8 +++++---
 net/netlabel/netlabel_user.c |  3 ++-
 security/security.c          | 11 ++++++-----
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 35604f43d4ff..360a454d5f8e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -563,7 +563,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsmcontext *cp);
-int security_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1491,7 +1492,7 @@ static inline int security_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 }
 
 static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
-					     struct lsmcontext *cp)
+					     struct lsmcontext *cp, int lsmid)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index a93a710c980e..edefb370a72e 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1462,7 +1462,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_lsmblob_to_secctx(&audit_sig_lsm,
-							 &lsmctx);
+							 &lsmctx, LSM_ID_UNDEF);
 			if (err < 0)
 				return err;
 		}
@@ -2174,7 +2174,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_lsmblob_to_secctx(&blob, &ctx);
+	error = security_lsmblob_to_secctx(&blob, &ctx, LSM_ID_UNDEF);
 	if (error < 0) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c37cc02ea4cc..3c0559b01677 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1109,7 +1109,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_lsmblob_to_secctx(blob, &ctx) < 0) {
+		if (security_lsmblob_to_secctx(blob, &ctx, LSM_ID_UNDEF) < 0) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1394,7 +1394,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 context->ipc.mode);
 		if (lsmblob_is_set(&context->ipc.oblob)) {
 			if (security_lsmblob_to_secctx(&context->ipc.oblob,
-						       &lsmctx) < 0) {
+						       &lsmctx,
+						       LSM_ID_UNDEF) < 0) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", lsmctx.context);
@@ -1559,7 +1560,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (lsmblob_is_set(&n->oblob)) {
 		struct lsmcontext ctx;
 
-		if (security_lsmblob_to_secctx(&n->oblob, &ctx) < 0) {
+		if (security_lsmblob_to_secctx(&n->oblob, &ctx,
+					       LSM_ID_UNDEF) < 0) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 561e1e476a49..842a236540b0 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,7 +98,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsmblob_is_set(&audit_info->blob) &&
-	    security_lsmblob_to_secctx(&audit_info->blob, &ctx) >= 0) {
+	    security_lsmblob_to_secctx(&audit_info->blob, &ctx,
+				       LSM_ID_UNDEF) >= 0) {
 		audit_log_format(audit_buf, " subj=%s", ctx.context);
 		security_release_secctx(&ctx);
 	}
diff --git a/security/security.c b/security/security.c
index cea3c1b614a1..444051575793 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4203,6 +4203,7 @@ EXPORT_SYMBOL(security_secid_to_secctx);
  * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
  * @blob: lsm specific information
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert a @blob entry to security context. If @cp is NULL the
  * length of the result will be returned, but no data will be returned.
@@ -4212,15 +4213,15 @@ EXPORT_SYMBOL(security_secid_to_secctx);
  *
  * Return: Return length of data on success, error on failure.
  */
-int security_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
+int security_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			       int lsmid)
 {
 	struct security_hook_list *hp;
-	int rc;
 
 	hlist_for_each_entry(hp, &security_hook_heads.lsmblob_to_secctx, list) {
-		rc = hp->hook.lsmblob_to_secctx(blob, cp);
-		if (rc != LSM_RET_DEFAULT(lsmblob_to_secctx))
-			return rc;
+		if (lsmid != hp->lsmid->id && lsmid != LSM_ID_UNDEF)
+			continue;
+		return hp->hook.lsmblob_to_secctx(blob, cp);
 	}
 
 	return LSM_RET_DEFAULT(lsmblob_to_secctx);
-- 
2.41.0


