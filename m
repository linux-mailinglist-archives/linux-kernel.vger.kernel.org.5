Return-Path: <linux-kernel+bounces-1774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910C8153C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B4F287462
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787871EA90;
	Fri, 15 Dec 2023 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AhqJWdJA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803018EAF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679845; bh=rC84q4bv3pOtqZ3VRmXBUeRBFuqoQ0GIzDt+InZd7gQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AhqJWdJAQn+9Fkp9Gbd9jOytDRNEXFej9nWk++B0/E4HBPk1ZndK9HZ19N7zXLN47c58tL+4L//ztGpaHqK8jSKLnjrYBSJJQJWGqQwrZjLCXTwj5zH1Fg64LuO2y+wTV5sfQAMrFH8gbvaH7dMMFYOSFg7M849P6Zp5EYjW65z7ic6CwzG1Wy4Dw5M7kTgFRd/m5xI9Yy7wRY/hCDScEbfjFs2A9Hg/Uiv+IRFpJxbzj7Q0wdoSoJC8EneQFHszaoAGRvxreSdycdrs/H7h+4s1ZQam+XOrq1yfVKYNfe1GISSz3Iw6HjnMwxG6cKdso528+AfAH5s3hyP58ddmlg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679845; bh=xxqyIWfLrsoSC0eg4eaY/Ihbdbw7/1QkMeH4uCpRhjA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bsWxJ+qAnxmSFGKm+DwFKdDbsTm8glU06xW2gXaMjdcRq4Dtqe0vC+U4AjIwc3/4fELJ1HyWiWBcvUQy9aQAxTkTu82KcUZzXfxNg+/A/g3UspP2KTR1WQ61+nO/FqJKbcuDrTeXQDs7cgYYKYXM6uUJsD3g5QSrUvVRIeVJZlPpvl0DwzIOMO1/s4Xfixn2xjYxYy62yNWg9aYTb1w39bdCQ+HiBIt7+SvbEm/dJn3PLo4tFv4lDCnRxeAmZ6us/kwi/16txYUhQtjB6j5MmNsQU062X1AyF14hcpavBT+eSz5kFG2qvdqIy8Z3z13NQsP63Ia30MrECghldmJE8A==
X-YMail-OSG: wpQks4kVM1ks7bL54iPNm92BB7fVWR4.pHazEAku13DFNhodHpOV32ok5_AO.ji
 Oo84oXteJa4mOngt0RJ8cd4QQR1TogNA1jPbptU6zIQfnMc23rcDFO0vEnukdPH5aCkkfEWxWu9G
 QfmoDClkRmOJMDTiIFJrA.592876aqSWT7bRPRlC_ykjYRTTdDxlCqlp.j8kaYsA36xY.du.chhX
 TxN7M4wpPyVCufkavSbTeyF70.DvXqfR0_rc.1WJxhqah1e5h7nu0dqOcjFiTKA3IVg2OHQeWb9o
 .qFQ2m3.SIfnzGw2Ed8fsyd0ahlevNU8k1psEdtdA.Kv3U5mI2nBJBLMH4eRwd7rgqGq6tdc4PRI
 Xwq5HaYrnwWVZoVus_Fu6f_8bxy2sbM_TJHE4cGQdcOp5ApNuSYui11.3VxHmWC4m80t3zvhvpUF
 lQs6D9NJRuAKR3Ohk4uNB1pFcLhS7AhBLd1vQLQbuhxPXz4p.Az9BuL1CzPgYwPvbBbTC58BREEq
 76BQBMYU05V9sWFfp9e.hQDngquiorlWU0p.iXvygxDKBpMH5iXy0g.wSiru44n7DBrHFElMqJ3H
 rhw42hEHdBHMsouuft.C_eE.ILsFp0yWnLWq80JvY0YssLZMUQozNLrNm5vjRUCavwzqtYzdazoB
 BGjPz0_exSg69WVa3ZzhkFwCE3VVnGEsDr0ecZ8u2TXp_pLxzLS1zT2mhkJcumDd0nXGpjxqrVPi
 AoIdnAaBLoAkR51kFbooSGo4Xp8LsQ6g22VhM6_fm8FNPZoQzuS53vIfBax9ke8oNh0uDVjOg8Xw
 FxzJbsB4wH0TBdnMmgMZRE0n9X3HZW6KD2UVXYU8H0bChyNbDIBTgbQooJPT3O6Z.bGenaoSeImg
 pl5X6tOhAXcl6gE8pB4fPDoi1qxALbCRCP6IydH8egqmw64HGGo9bcfH0NN94ofnOP5muO2Fe0Qv
 NxYK75LxQot.PTDfkSj34eTlwfx6nhbbzCPtGg1LSLBq9sggrvky06Vm38pQFfQeZHwRzbNNWPS3
 kcA.BVy8UofbEVS5N4EdzzfDLOaK1UDhRtfG61_iofge98GISiqM7B7XBJOWlSLnh.VShxPkUdby
 lRLE9F4KUOr.orQ6B8xy8RPZwYx5Nhq.90WsuW2lQqZdyV9qYhxEQCssQFhdpCkX93bQplPv4CAe
 bJY8zyxaAhnsaREToaJ5go.gRaZBgKiJiE2bWUvEWcia6WzTWCVgjRQsJgBm3a.wE6xNFtB.o6D6
 LfTg2.HuYDg6qAPdNBmOsN9vSTaEjFWBGup.AfNaK9M7sAxpHusDB3t3TPXnVxxdOV7k8eMsiwLH
 .bIU2_NR76sDhjQ07odnCYo0LPBJhshGeOyLvO9IpT6zAnslyUTvoBoThg1us9fdkaKtWGWJwN_a
 zJnC9ls.1kRRKZgebAngNgmDWP76qyb3idNB0rnaDZEGeksrU61buzTCR_QuzoK_ZaX7u_7KPelO
 12Y9wCE8qGSrKad2M0Hmn7I43BesikCE8ORhoE3_HDbJFtKhux_9CK4JfMr2dkuNh7o5MAfqHCHD
 31vBrC3aETvCvZo6yCmPeIb5gMGK6XKUCHto1KrY.pHSL0YxGD7dy5l1Y7f.kcuAs6KqBSQYNZJB
 KIuUc.kSQ.mLVL3QneW4Op8Db9M3PQPchn9LWL9BtSJNPo_D_DmcUeR0hlP6LSFe72mxw0o2lGnC
 NeRrJ4veLY91e1cdWlCsvACEucdEkHY2Hx80e_YwroiQou.hQ8QTawwpxVQaV20qoDYbvoPBqeQm
 yNS4XXlBrkxEDGXEVESkIjfIVlvmULjfMd7Xhrp6l4h3p1o8x4kHgDj7EYZ8rYNWo1PSFY6QVqwC
 C3Ys_gEAYTcPIhkzoAfuSDcIg0aUfFOhOX_.VHlWTJuAGEdEQrarbIXHAPr15Z0cvRL.cwAAHOgO
 eRYQKXX4T5u3nybyntYofe5wEGOvuqpRohr5Mc8vWPtUwdife1htyobvDazwHqPnbKXDZZ0Z3yHT
 aldwUGznnXcTF0MgN9N6UIWaLXGR6rvSCQGR3PVpt2945IJN4ffMapsHiCgdW5mQaEXUTfYRE34T
 R5dWIP6QNfufdJeJEVVkHzDjXTUdaBOOMXSLCl2NY_7J8x05Zu2gZtC_vX1V9j0vvEuP17w6L0lK
 b.gPKrxz5uNu5.IsvPth.6sNEJBjeL7pWmRD8QVfvKwDm_c7Ad5MKJ84inmehdxTk2673ED.lhdL
 FsMifpdQ3ibB2m4X0dymSxxWRN6z1ZWPEUXgfkdS3W7Y04mVYUwnpYuTkod.WVm8Z2uFHrO9NFl8
 ODPvFwBLhjtsD93zl1glW.c01pqLehA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 087cb55c-d788-456f-a84f-8c7f42d79f4b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:37:25 +0000
Received: by hermes--production-gq1-6949d6d8f9-7dnvp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 99c4f57f4ffceb7049a22eccaa6e59f8;
          Fri, 15 Dec 2023 22:37:20 +0000 (UTC)
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
Subject: [PATCH v39 26/42] Audit: Add record for multiple object contexts
Date: Fri, 15 Dec 2023 14:16:20 -0800
Message-ID: <20231215221636.105680-27-casey@schaufler-ca.com>
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

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=MAC_OBJ_CONTEXTS[1421]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h      |  5 +++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 51 +++++++++++++++++++++++-
 kernel/auditsc.c           | 81 ++++++++++++--------------------------
 4 files changed, 82 insertions(+), 56 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 8974500f730f..914cfd563ce3 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -185,6 +185,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_subject_context(struct audit_buffer *ab,
 				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
@@ -247,6 +249,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline  void audit_log_object_context(struct audit_buffer *ab,
+					     struct lsmblob *blob)
+{ }
 static inline int audit_log_subject_context(struct audit_buffer *ab,
 					    struct lsmblob *blob)
 {
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index dc045164b86b..bed324162a7c 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -144,6 +144,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 626942c38bca..dc11dd4c41fc 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1105,7 +1105,6 @@ static int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2289,6 +2288,56 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	int i;
+	int error;
+	bool space = false;
+	struct lsmcontext context;
+
+	if (lsm_blob_cnt < 2) {
+		error = security_lsmblob_to_secctx(blob, &context,
+						   LSM_ID_UNDEF);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+		return;
+	}
+	audit_log_format(ab, " obj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < lsm_blob_cnt; i++) {
+		if (!lsm_idlist[i]->lsmblob)
+			continue;
+		error = security_lsmblob_to_secctx(blob, &context,
+						   lsm_idlist[i]->id);
+		if (error) {
+			audit_log_format(ab, "%sobj_%s=?",
+					 space ? " " : "", lsm_idlist[i]->name);
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_object_context");
+		} else {
+			audit_log_format(ab, "%sobj_%s=%s",
+					 space ? " " : "", lsm_idlist[i]->name,
+					 context.context);
+			security_release_secctx(&context);
+		}
+		space = true;
+	}
+
+	audit_buffer_aux_end(ab);
+	return;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+}
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 23f72c14276d..bc13666dd6ed 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1092,36 +1092,27 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
-static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid,
-				 unsigned int sessionid, struct lsmblob *blob,
-				 char *comm)
+static void audit_log_pid_context(struct audit_context *context, pid_t pid,
+				  kuid_t auid, kuid_t uid,
+				  unsigned int sessionid, struct lsmblob *blob,
+				  char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext ctx;
-	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
-		return rc;
+		return;
 
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmblob_is_set(blob)) {
-		if (security_lsmblob_to_secctx(blob, &ctx, LSM_ID_UNDEF) < 0) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
+	if (lsmblob_is_set(blob))
+		audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
 
-	return rc;
+	return;
 }
 
 static void audit_log_execve_info(struct audit_context *context,
@@ -1370,7 +1361,6 @@ static void audit_log_time(struct audit_context *context, struct audit_buffer **
 
 static void show_special(struct audit_context *context, int *call_panic)
 {
-	struct lsmcontext lsmctx;
 	struct audit_buffer *ab;
 	int i;
 
@@ -1392,16 +1382,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (lsmblob_is_set(&context->ipc.oblob)) {
-			if (security_lsmblob_to_secctx(&context->ipc.oblob,
-						       &lsmctx,
-						       LSM_ID_UNDEF) < 0) {
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmctx.context);
-				security_release_secctx(&lsmctx);
-			}
-		}
+		if (lsmblob_is_set(&context->ipc.oblob))
+			audit_log_object_context(ab, &context->ipc.oblob);
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
 			ab = audit_log_start(context, GFP_KERNEL,
@@ -1557,18 +1539,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (lsmblob_is_set(&n->oblob)) {
-		struct lsmcontext ctx;
-
-		if (security_lsmblob_to_secctx(&n->oblob, &ctx,
-					       LSM_ID_UNDEF) < 0) {
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
+	if (lsmblob_is_set(&n->oblob))
+		audit_log_object_context(ab, &n->oblob);
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -1773,21 +1745,20 @@ static void audit_log_exit(void)
 		struct audit_aux_data_pids *axs = (void *)aux;
 
 		for (i = 0; i < axs->pid_count; i++)
-			if (audit_log_pid_context(context, axs->target_pid[i],
-						  axs->target_auid[i],
-						  axs->target_uid[i],
-						  axs->target_sessionid[i],
-						  &axs->target_blob[i],
-						  axs->target_comm[i]))
-				call_panic = 1;
-	}
-
-	if (context->target_pid &&
-	    audit_log_pid_context(context, context->target_pid,
-				  context->target_auid, context->target_uid,
-				  context->target_sessionid,
-				  &context->target_blob, context->target_comm))
-			call_panic = 1;
+			audit_log_pid_context(context, axs->target_pid[i],
+					      axs->target_auid[i],
+					      axs->target_uid[i],
+					      axs->target_sessionid[i],
+					      &axs->target_blob[i],
+					      axs->target_comm[i]);
+	}
+
+	if (context->target_pid)
+		audit_log_pid_context(context, context->target_pid,
+				      context->target_auid, context->target_uid,
+				      context->target_sessionid,
+				      &context->target_blob,
+				      context->target_comm);
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.41.0


