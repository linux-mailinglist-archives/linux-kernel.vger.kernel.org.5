Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3379DA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjILVCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbjILVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:02:06 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9700B10DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552522; bh=QUxa5qfQ2yoMwNBu3j0TFzU79I6CvGM+LdAFgw4GuXM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=D0YVa6sppX83SX18hGNiFMW6OIghAbgK1pDXjA77QyqysPX+uZE1L/20letT71GHXdFzks5Z7wUoXNPhkr6BQKMNwjJY/MfCBBeVZFqI0cuVyVjhd9XuYb9dLpqddD9AqAS+Uj6XdO9ZpMBMq/91a1JklwytXdMownMTrmAmCwdsyiAl8cUp7iZz/xZFIARsc634cLBIoZlCl4LfZ4+kmNxrm9jZnSNa1I5WPu5vCJnZXgbLrL/zD9VSL/F6Z0gDQcK/z66ChNvS01HB3c51VOCbto3f5b5UR84HE91u3HE6InQlwqZHHsqPuleJoUgzXPqqlo8acbwjw16QA4BU+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552522; bh=tl7TO9k060zsMHGCGNAyWDal1V1TvMPB3ScajfDLX1N=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pGdlt9ED77ZZpnvcy6sFz3A3WivTLj5+urIdRsIMXInpS9LD3NlrJ/1uG3FYq3IYwh2VVqgmrRdmvM9uGU1RHmx7qF2f9uC+uMMgKIo4xM6CvCvE3zBf3qU+BNcTvD5IBOeSmIYbs3qEOzQGOfM1g+5CtJy97iYuenIZ583ic4eGphLneixhbfmdemg3mVs+G5Rzgn3HXpJzmP7T5yybJRmzi77bU9hCCRNqnYjCRTldDuuqt/LnNIOIEMX2QTBhVXAxNGNlI1QJHz3LCk6WjMoOvafQitjRv1TW+UVgCd1E8ZPc4BcK8r5VKtYSV3/UsbCwtmhysqW25/RxkumLkw==
X-YMail-OSG: blW_mU0VM1mOOJplAr1UemXa9tSD5dNNQXvcr9EWW5ZyxfLQh2.CUIvXXSbdYxN
 JZSzHPhuFMECCveQapc5U_e0SAqekyzExEmJ7anWBvbQBOwwuXbWHEw1OhiBBAl6mDgI7hhEUZBH
 UN0x9wUwoiBg.kata0h7YqrOem.ubaNo9ITcS1FfvF5u_rbQ6wnD_jaDvU6q_3NshRt4jYRF6pBP
 tanrG9kTC5tn.ecfIMe.m9kQXRlGo7TvQi3ZQ_5knT8pa.CkTmvr3VNgKSArstjHxXyky6dx_ckf
 zQI7bbB_GrDVGYbkJxBN8PaaDVl.a6EZuaaUOCFg7J2sC9mtxeL4eMUADNm6jupxk63atgQQB3n6
 f37U9_Ips7l.Bjv9BqTlJweBobMryHzMlNeO2WiqiQw_LPhkqrXaJSI8394TKNZSrEpqKZVGnKuU
 ce1ZcteHezXNjyAwf9CjANas4zk6R_WCQk.XjEmO.dPdcqplyDf7iCRNrM1KA9.Ep5.rBG8VXRDS
 iuCNzxeKxl_bgE1rNWRwziU5PDEIMK4TT7F3ASMySbS8.QWE8kNtpC_mWunoonUJRwGQsWEykyRM
 cOWOoaOO8Mw9jmhUG9D4YIW6UylLF7EuOGQT3U7go7uIg5GwgH8la9fNEVokwYzkl.5lNCMuMZst
 fjm1kT6CHUkyGNVWwVYAjbUuBVpPtit20EkmAURQwGmgtABamqW7mYENbBtoTDcgZeg2JPMXubEC
 GmibZNrFte1l1vlnrPeca7kN3rae6Qh5nLgpUnz79EH4sR1lsuATn9VcORL.u7B1MHXvlezMnY7J
 CcBnquQtidH22OZeu3tX45ntXVH8CEe7IzcHPPJUgIma7mOq2k0c9r8n_AvDZvzkpygVceqGkGqZ
 NqvLCxjx32zomV9Pi09NJ1Q0.uAGuMEWro5UT6CRcCQv5gaW9cLdUEuTX0eEt24myUsmQzl6geF6
 trl0URUGrY2A_oAX4q4q9Qtq.GhGvaQY7w6aWOv3ZSf06_cz3zYJNfSPUDCe6OpadbXhAS5tdTig
 K1CeHqzoJJjJkQxKYjM_k6sE74TLtLe1YtXHnHrwOCscr57L.egaaWn1q.Ih.KM7Jqwz.q8tFl4.
 ueH2WQudIlGeMVu1DFtIGB0y1nJg2FXC_SRkfMyPbJWd5nuwpZup0kapU0ix.fLHJXCKCG2lreoO
 UZBnSVOJtfhGBEb9ZsaAMUm1l2yi3bd6IyQU4iI7poVrGbdq093w35F3JhJPdT6YkyjLf0CWIA6T
 jFSsK33hX2qxjJjYLJOWS69B4Ftvd1x05oSiMqDDllgUX0XLH2W2bcOF_9TMdHBFbWstnR9osZRI
 C0wPGimGuL_aoV5oXYBKLHfGsm.9CIbN0D8nnFxRMFNG.s1DWaD0rGW66WKHJ4nKfallhm_oRm82
 DTjrfSd8BjTwMWmBzAZs2yXWyY.pK_kFHKWNVXJMEXucwM_wrsprl2YVGRYMKi31qD.tQ1J.RIy4
 8zV9e.RyFL3mYzcukwAHZf0c8Y9W0HpyWrcR0SnHkVzCbd.luTtJ1_2KzM9RDNp183VHsPtNbpN_
 PJq0mbQEw9JvZ6Gsp20f9aP2LHCrZ4jtbaLo35zShzDz7oA756NW3twuCIPnCCxnKE9BRyDp9alQ
 FZcuMdG399fwfzLilQ09Mz7P4tVdN9.D1eGUHSL5f1IOf.RIizghEp2tAW.dN.O6rvFWTZwk_U.G
 TDU6ix9H9WpbfKLd3s_0umZy_XnJUR2QSmGmKsdw34Fj9VY3O4vE8exDWAPSaN.HFG66Kvg2G7q9
 gFk2GxiVZsfsfYraGsxUdSCPAftekw4DbkjuTpoCZ.sDaP3wItBV1sMndvEro6XkUfT3yAUW2YmP
 8eB7ZqsEB3l3hABP9p8fEdHJ0ECvWuwGLNAQH3miBw.O2GANBuucOrfywsHjAiIJ6jkgRDsxPe9Y
 hV8b8uiyPxS44ZgQP2CjIIYyTRR1fxJcMuWJkkJhaZCbRtnajZPozBTT0tbrShl6BkAIcvJWsvkj
 kCDfHdepkvrWU2dynphxqFzD3kKlH6HWHByH1SfNMpTm.FaugG6Ry.So5qbX_ZlcK.D9M6bLRaE9
 fnh74hH703p4iO.4KVDflPYDbboWwkNLPI70.0YvVeNQiWiN7CamRLVSCLp3lRFi.dqny5EcJo6p
 DRONU6.Bld9bYwYeOZWUc4FVzKkP4pvotSv_HgRzB9VJ.5fPaMrQfNLqfUa.b8QHQJT.aW0rDIcL
 ZbLcbMj5TNWKfnznJEq_9Idohisa556nxvpRCkqB8KVwlD06zBdXpEAWElhsmw_r36x0OdvNgHAe
 1peHvjKuSxMdtlZUntL1nM8CoI6YB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cf37f695-b99e-40e4-a64e-2e7561f5ea09
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 21:02:02 +0000
Received: by hermes--production-ne1-7b767b77cc-84nnk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dca4072a6b7e00ec57f039d5e03e840b;
          Tue, 12 Sep 2023 21:01:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v15 10/11] SELinux: Add selfattr hooks
Date:   Tue, 12 Sep 2023 13:56:55 -0700
Message-ID: <20230912205658.3432-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 134 +++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 27 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3ad500dff390..f066dcf30ec0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6279,8 +6279,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
+			       char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6297,20 +6297,27 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
 		sid = __tsec->sid;
-	else if (!strcmp(name, "prev"))
+		break;
+	case LSM_ATTR_PREV:
 		sid = __tsec->osid;
-	else if (!strcmp(name, "exec"))
+		break;
+	case LSM_ATTR_EXEC:
 		sid = __tsec->exec_sid;
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		sid = __tsec->create_sid;
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		sid = __tsec->keycreate_sid;
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		sid = __tsec->sockcreate_sid;
-	else {
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
 		goto bad;
 	}
 	rcu_read_unlock();
@@ -6328,7 +6335,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6339,23 +6346,31 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
-	if (!strcmp(name, "exec"))
+	switch (attr) {
+	case LSM_ATTR_EXEC:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
-	else if (!strcmp(name, "current"))
+		break;
+	case LSM_ATTR_CURRENT:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
-	else
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
 	if (error)
 		return error;
 
@@ -6367,13 +6382,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		}
 		error = security_context_to_sid(value, size,
 						&sid, GFP_KERNEL);
-		if (error == -EINVAL && !strcmp(name, "fscreate")) {
+		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
 				struct audit_buffer *ab;
 				size_t audit_size;
 
-				/* We strip a nul only if it is at the end, otherwise the
-				 * context contains a nul and we should audit that */
+				/* We strip a nul only if it is at the end,
+				 * otherwise the context contains a nul and
+				 * we should audit that */
 				if (str[size - 1] == '\0')
 					audit_size = size - 1;
 				else
@@ -6384,7 +6400,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6407,11 +6424,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
 	tsec = selinux_cred(new);
-	if (!strcmp(name, "exec")) {
+	if (attr == LSM_ATTR_EXEC) {
 		tsec->exec_sid = sid;
-	} else if (!strcmp(name, "fscreate")) {
+	} else if (attr == LSM_ATTR_FSCREATE) {
 		tsec->create_sid = sid;
-	} else if (!strcmp(name, "keycreate")) {
+	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
 			error = avc_has_perm(mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
@@ -6419,9 +6436,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				goto abort_change;
 		}
 		tsec->keycreate_sid = sid;
-	} else if (!strcmp(name, "sockcreate")) {
+	} else if (attr == LSM_ATTR_SOCKCREATE) {
 		tsec->sockcreate_sid = sid;
-	} else if (!strcmp(name, "current")) {
+	} else if (attr == LSM_ATTR_CURRENT) {
 		error = -EINVAL;
 		if (sid == 0)
 			goto abort_change;
@@ -6463,6 +6480,67 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			       size_t *size, u32 flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc = 0;
+
+	len = selinux_lsm_getattr(attr, current, &value);
+	if (len < 0)
+		return len;
+
+	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
+
+	if (total_len > *size)
+		rc = -E2BIG;
+	else if (ctx)
+		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
+
+	kfree(value);
+	*size = total_len;
+	if (rc < 0)
+		return rc;
+	return 1;
+}
+
+static int selinux_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
+			       size_t size, u32 flags)
+{
+	int rc;
+
+	rc = selinux_lsm_setattr(attr, ctx->ctx, ctx->ctx_len);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+static int selinux_getprocattr(struct task_struct *p,
+			       const char *name, char **value)
+{
+	unsigned int attr = lsm_name_to_attr(name);
+	int rc;
+
+	if (attr) {
+		rc = selinux_lsm_getattr(attr, p, value);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+
+	return -EINVAL;
+}
+
+static int selinux_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return selinux_lsm_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 static int selinux_ismaclabel(const char *name)
 {
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
@@ -7091,6 +7169,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.41.0

