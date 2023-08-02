Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3365E76D618
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHBRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjHBRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:50:46 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E64B3C3D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998576; bh=7+Se1+Ef5nv1L5D0ZYy5ttVjUz7zz9DskE81Pzn1f2s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qZIx+UGAsF/q3yBkxwWiLY/tIU3wGTLYkQZ4ABNrIz+WrogeWMIw65CQ+6DW1Mw9MTPZYMhnXUmp12hJ9mAOTCb7CHZ5EUiySUVV26ZQbRIMu3hozUpy5K0MnkHjrBdBsvsfWQQ04uL/P9s1CCYH7bsWyM8H8UWPvl2c47UtB1BP4GgVoWDEWXUfj23WTaU/vfAXkwJI24dfOYMpjjb7Yp44vQlXeDMrFLKqfDKvFrrH6LLDS2r49UOLRQL7nR9oYkqqFoe5SGmC2d53GdmH/XrCNPo0bBCAKyTlHM4yPlgO5A+tvM3Dy0qtJNGpwjMaGPnpqeUWIzwOT46rnG1eyg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998576; bh=wU7xfLI4hi0p4/9Hm8Mf+VzD72RutSPiUUBUwzRd/Y5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bCLXIh/SR9oMOR3UTwV8u5NM2qozhN8gtDA8CDAUbfLQyJVxRTbJ5/6n2uG4skdTnEcclKElzHJ/xL4jGQakDm19tzS4GweAaFmr0E9aIbuIqd8cCJ5dkrGrIHX4aCFBxRLZyngRZ11raT2Sen8T2DaRgO5vT+1WZTIYCZ92G+QfmHK4rxFEqRcZtZPN/6tUP3OY1ZYS529fYNxaCMsipo1u7rRxP/fxw88wNBzxpiaH1QzbF7Ob2ufbsVpu6SINsBsW39iUhzhXBWeIpEzLAR0fcsuBzv4V6ec3u0eNUwLxwJnUogsTYIyeF6qfA8BSiEjZ7kNAHGfVHRYxu4hoOQ==
X-YMail-OSG: PpRoHtYVM1kL6Fdpcxx6CR5GzkNgG2N8f.KbOR41IjWQPxyGYnIB1gM1Rqmgh9j
 OFcS1u_BoOk4Tr4ajCnI2T1jSvSn8Vqh7kz4ygti083bGn9aURvEec3wldpDJunvAlYEwRC22Qcc
 Qt0Bc_T_MViQJF7aNxuotai4K0QadPPLCTzuGh6D9LgC41XT.Vvp7QHEmRaWsK4cK7UF6Pm8heW.
 QACliooASQkAQGXNq7nkMzMIuyuuxApv57cPGqMH18Sxnoz4vQsUoL6E4EbOdZDBUZDofRSlPSxm
 FTxa.g3psdZzQFS.7P1ohQkaa9D3aW6wzyATPkRO5GdKNOfMFLZaQ_byjSdv_Nv_Oxuy5oTD9q7A
 8pKwRB02Md9_iAW3O_v_If1Mmxyak3E9KdZj_VuteA3CJAzT.vDz_KKsQQgW655LIbro3Cc7gZTM
 8NiLVroAswU.f5H_7AgsuAkWFXCDd2g0VjEZeoN4oPn2uTXZXoAMR72X7.53_dhhy1ezjQmjLzDh
 naXV6yCvG7Q3uZKjS4JneVvaHs2FhPGfX.2o8H7.lQAIka6BpR83qMJeC9mtNFYX5Q_jLAus0qOv
 SUn0CZAgBVuubc_o7O3rxmQnVnxO9iZFdxo0olp5tWP9rtc9wybgl9eWn3VvdKdCEFUFOa9zgOFU
 Isptm06ivV8FXrK1Vrz2up3q9GWlE.UFqQOxwR2JZfomH8DZEEANr7y7bSfGBE54nL0MDtPfJfjJ
 4XC2PqyTo9kgXmpNHB1Yj9BDoCYOnkorb7eWddkjceZdjBZLJ.k1hySmaelKXfkdpWBME9Vb1wmV
 saXnNb765nDv18P10kzSLAltOeJskll0lCJOG9EMcbWOFHOwR_u2sXI0hduKR_s7G1.KEINJZIyH
 aqJUgbhYGRqiZrH7TNd9cwOtGVVfsG9uF74iRiAXkWA3rXjhdiT_2RLYe14aJnVM0elg.LnC1I91
 HN7N0nozo15uYIOXSLr42IrmEtu69vWvi1LlV_qHgvn30pAIEdoffgrGFtPeia9_5ABuLdH0geVs
 lFbDWouswjETA0K9IyoWQ4YP6EgsiDE0qfKe9ValjT9QpxDUWu5H2eywdtKrG.jOJ2SJQzLxshou
 e9hXPTHHXOUuhUHqxfNJvF3xo0avdkmEK5GlU68NSKXO1CFTb7yGyIMS3dfjLD1A5MROhMi89m5B
 RD.O3j2Fd7o257kBu4RDfatQA.wIhYnXP_lTzXfwNMx9GHP6rbivEqHioVNFKpOgoszx62r76jwS
 zKGJcuN.RYpRv3mSLoYuo7O8muPKvKcu4UIiy2OQ2kgRZQwMYWs8QnpVaZDjrowLxHQsFRIr7qJQ
 PoGJ0zxha7uHlUav4QzCBrHYn973ttEYrnZ5h1hyhs.A3BR7ZEurAK59bYKqEEIwl0GeTIT6We6S
 MsssyKcKZ_ZRGw_w3Ay6FBq4vyJBND7ZBRpLnqqLO14bKfJuI2ql6iN5loNS5Wt75ihGblWJ2eZg
 84ENiz8KLk.4gzA0QVje__CZUCWbDSd85SCtHsKr3_hKckaZlV4JcPHJGNY6NYveao3VtX5nW6SF
 vL1M5QZTNq5Boyd5i7TZP9P3qcd4qnrRo8QJthdRuNoEXQBh4I3PrnWNQ9pngV08XeqWR4tb7k7B
 4rEW_VtPCsw1uQrWruAgN7SJMPl976zWWxi7YtiiwNxRxnQWv5z0iwo.6XqqyWlLmflsh7D43XdS
 HXKiADyMG45rFQ0YoeX.NowkdNp5OMtDcE81KbgHVV4NSfxKKL1DiW9ot2wagHuqqc5kRfb5b3GO
 5eko7do6PDr7jvQiKC.JA2CYMyXmR1kD5.07wdHekZl.asN9AOiNpmC8FfUAOsaFecgOqSRuAx6I
 MN_hMmJOMJrVoIqec7R5E7Ur017Vq0UtS5sWyCYeeGMLkqCxaPcznaLYpt2SMl1stSO2i5xn_P46
 Dkpe2TUHZN1l.xgYy9qlM5ztOPQWO2aN8sSNIEiMYUb0fENbRbq6sswCgRexCBRb.2Ez2YbWBIGo
 xUk1TxXruCcdXxLS.Xo7JcRuASAm7tXopq52IKVnY0biMFVe2O21u5aBJUqSfRmxjyvW0r1NdNUQ
 xgOKbYsu.Q.3wxg8DI4HI9Zx_ckAysvrYm8yqMyi4L5XC6TbdsARTwjroasl0Qv3hN83kFAticf4
 FaoNpe1TyYB0YYF.QqkXnYnA10uzDklFZ5EHIzVELX7X3dDyN1hts8mwVo9M2XTZ1s2OTaVhAvFC
 WC1pwq4XzHrpKej2CQud1fzkiJaaMZUijEHFQCHRMoMv3tNUfVY93ua72kiRc7A_qsH7sQ5otcs0
 syFDiBkYK.uWx4Aao5aeNcupo3Bp7
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b02ce2e0-359c-4f18-823b-92ae002194e0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:49:36 +0000
Received: by hermes--production-gq1-7d844d8954-l5pzx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6a2fae4a0e3a5f2539f1465356d53db3;
          Wed, 02 Aug 2023 17:49:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v13 10/11] SELinux: Add selfattr hooks
Date:   Wed,  2 Aug 2023 10:44:33 -0700
Message-ID: <20230802174435.11928-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 security/selinux/hooks.c | 136 +++++++++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 27 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c900813fc8f7..f66a28f672b2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6265,8 +6265,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
+			       char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6283,20 +6283,27 @@ static int selinux_getprocattr(struct task_struct *p,
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
@@ -6314,7 +6321,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6325,23 +6332,31 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
 
@@ -6353,13 +6368,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6370,7 +6386,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6393,11 +6410,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6405,9 +6422,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6449,6 +6466,69 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			       size_t *size, u32 flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc;
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
+	else
+		rc = 1;
+
+	kfree(value);
+	*size = total_len;
+	if (rc < 0)
+		return rc;
+	return 1;
+}
+
+static int selinux_setselfattr(unsigned int __user attr, struct lsm_ctx *ctx,
+			       size_t __user size, u32 __user flags)
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
@@ -7080,6 +7160,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.41.0

