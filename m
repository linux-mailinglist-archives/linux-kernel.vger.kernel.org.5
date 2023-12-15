Return-Path: <linux-kernel+bounces-1768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B448153BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B91286BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D06718B06;
	Fri, 15 Dec 2023 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Cbeu0CWu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6A20EC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679747; bh=c7E3EinGlYIO5DFIuwJVpD1kjxNAwcYojPiiLg1ANXo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Cbeu0CWuLslNmc7PxcRvqMyT1SoSDMnGmRrQZfTNCQRrddiZ1TECQHuID6rx9zoZdaNK7FU73JvhHCBR/RqWYgESwC812oSuFW87yGCOU9YqTROysAed/HCuUwqO86zNMEZryDouUR0UccxtCdas8aO/OUDCf7+c3iT6ACwFlK/g0ENNcd32zmkL0Ky8EmM5EbeaESiM5VgXoqefeGySE3gmhVcpBFOnMlaHl5RbHSAUt7/+z9HQWvIoVPMWXoCLHesh8fT6FiTRLiVh5EmodRD+56yKBigaN1M2JVmnZxoYN3uz6Os+X1XItfKxoHL86Sl8f0lU3SQncOx84IeJdA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679747; bh=4g0jPcAkz+MM31SdD1zEI+4JpoZmv25pL7oQyuni4NI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mXXAGg9GNOryPQQn7V9Ox2kVP0oPru1Z3+4SIBuwAHBC1cs2RbcGDj7Rv8J6uFatfgeJHYdbG68YVYEtrq62mnri/P3tUHHxu+N7XOqOJ5Hrfs7cDG4HP30ibxwvNTZwcOsCvlIwLfsdAc9PwTCf8Ey5P7J4JV457wlcUmIHGXoi9w1M4HuvRhOOUqHjDqWlOcssOhvETjx55us7kNRKNsZcfhTto2xUCxcxlHhXgx+7U8F6xGWprksIAphDAu5vwgaTGqMDzNLksX+E3TL3cIvWAyYMKafINrEz/rKFiFxDuloSJHMWp5ijtou0GKphZFqzeEtqKP2YpuVPNwguMg==
X-YMail-OSG: LC6mkRAVM1l7e5HM0_6jX4Hj7otrxSTEpj83RH0zZhphiPXFX1LiS2CyNG7BJ.w
 2IiTgED9z3WqFAydqYiC0IqxyvQEo4OIbaZt_CZCEo87m4j8OL_hQAs1jz3cpEbNImrDvdw1eCim
 IWWxUlRiEOoIdBYvcXKr60.EU8KAJ3F7kdrnpnTrZTJueIAMC_C_1XrgUbWwNNY7IVB7YV_YmJvG
 gGgWpiSZ85D3miifviNR0TQKlMFmFzJn.oM4cGzPvqQVyIBtQrzLonZsJma5KvYv.eL1aFuSgGoK
 dr1ieWq42r6qDGZaiDuv5XWJfbvveJxU4LDntvBwsVwdYlZrzDixLDKzc1OQ2oqwFh2fTQSILSJh
 AECwD8fXNESwmXJ8SXHa6r8FI6qP8sw326xUV3aG0F1OSwbMTOD3g3T6eFmcqVzD0vaV9PxlZKYp
 aG.WMpEoc185y3o9BkiirY.vZgtEG5bNZoAyqq2GfB01uLRYwHCgxDQ3CQrELB1E6ipImB9ki7y7
 AeRLKKyk2AHFHEtWq8pmDIiz3UHyzf9MQi0F3Ew4oHqhzRrbTkRElt9wzyxq9Pt_3dZtdFEu8DwB
 9JQEua4sVPq0CD8WE5YFiswA.fMBRRBufVb.b9Ncbsz18pbPA83HpHy67Zwt1HWhFDPvF7hAPMls
 AE_ipml0ZYIkA4OHOuQkJyGBH15gK38yUM6shilBX.tqldMxagtYO5V8WGi8VUAJLMne6VrvcFb5
 XEgJ2JHvOX_rXR10CpX264L.B3yjGuciLnLf4VwXkhk6z_oiQ89c5Ed1QX3l4YfPkJqlXpkxi_jw
 gZEcIiOo3PDtlcveREIv_lsHhecwmVoJ88sXShmj2_.lpPmmyCn_kHgOfATc.0QPrkyS0FtTd.LY
 nynDH_ouqdN3tdoFu7czd4N2GiYWPJ4glSjpGwd8ybBGGF3TNYqMp0QtmdwcRMXO5WFGxyz5KWC7
 A2fMEAXRRNIR1GqUIoutL.jOh2cHpGSaEzqnCET3ey6WVWdtJPpoQW2o43BZh16_kAhGngG0wZoh
 5ALVOLWjsDNTELR5Kwse1uG6TKhvG0IryYKXhGx1AwT8IE2I6XDMdi7UO_B1YWo5ydmXZ2X27OD_
 XV4.7mtEjyH3ms9bS2.f_eMyHs0qXWhGerH6M.iZXj.cBHw5ZUCkICpv2nxB3NoJPZ_77agex8hX
 bkG3qNB1oA0rA_htPO47JdDrf9FIE5W7hnUgR9F2p4vdW_5kF59Y_TEDz43uARqC2qR9gLrtHUrp
 x2vfG.ZT1fy.eUtHzPavIWnZ0H17PHp0IpirBhjKB3rYde3AejQruQNyzbhkPjx_JkJELUz_VwEy
 y249zpcCLck2r30581A6mL9peWZRMRFu05th0B5OkY2BRhwRUZHmbkCYSftwfHQBlpW5qhInFe4N
 z3l8fDmM60bHZzigpwhqiU6BHt0h3OAjbSjkGZH.tS1Z3sqFrF8dlaFMY6UYTcnKxANaGKcNS1uQ
 iKhJDEP_xgG8LNuDuF70MzmGNaUVvzKm69PwFd0XfmzNfgP9w4AFAusN8KYjstYYc8BFXuIzARdz
 vuS.UoPccKiDLwSsIZn_RfHELSryTcx94xK1G1v_T.aEz3cXA6VPBIteSzGAWkMvAW2fJ02787GS
 CGIquzSn5g14hB0T2RN6g_KOMgK_0sj1WmBIWi8Fmr0ITlS7k8MBrMNTSU4Y_UxvSBqsbtUU9NaG
 vGNVcVSHf4_SclMyen0vXZxagQkkRuzZZTFDDCsYxwzKWzSa4daZBLJh5Fk03zY0nBGrmrXEqYLd
 Fc6rFkwYl0ocH84IrlxTUBf.I8GB9LFYIdMo7Iro6EoEmDUBYmCt3OGJ.3h6jOuuyf5r9yDRmVDy
 d5VX0DR60GDyz99u52DspIFHDQTvoQZoTv7W6Eq4HzbgPg9E5kYYlfn4fvXv1CGR1b1giZaizseP
 SIao88GhaiIa3nbb6FQr0yWFZABN_G7IwogWJTY_mv6RkLcxq5lWxRooHre0MV8.abOOmk4K9Ndv
 Jj9xJUsukoPBVbOYtu4c6n1BvFKNa0wmMnPfiQlrxRoBOaNouy8_j2LuwS3cT63AK0PrJmX0ybbW
 Mjs.jW4O5uTaIVHlhDTT6Kf6NGxB1qTGv5Kt.4vSSe7jSXypMxdD6no_7UIU3AI7Ei80VD5d0DZZ
 zs9aqepZBJbCjgzirjR66GJGVs5kUZZ_tsDe.OVFT2fpcLCnpHmtJY0BknM5iV9Ovc2K_hQFZ8Qd
 2q3O9aE9vd5w350vR9aC.lTqWkxSEy25.J5Zdk8UU5Rg5M45NP4Q8NHLHSohlVoohj1nR6wY3A4U
 E9N.G9GVq0HP6VvCGAj2ohBwLaANv
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cdc641ab-9029-499e-b365-09cc3fca6299
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:35:47 +0000
Received: by hermes--production-gq1-6949d6d8f9-c9pk7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4756c4ce944f308f64e0301afd197084;
          Fri, 15 Dec 2023 22:35:45 +0000 (UTC)
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
Subject: [PATCH v39 24/42] Audit: Add record for multiple task security contexts
Date: Fri, 15 Dec 2023 14:16:18 -0800
Message-ID: <20231215221636.105680-25-casey@schaufler-ca.com>
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

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=MAC_TASK_CONTEXTS[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  2 ++
 include/linux/security.h   |  1 +
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 45 ++++++++++++++++++++++++++++++++------
 security/apparmor/lsm.c    |  1 +
 security/bpf/hooks.c       |  1 +
 security/security.c        |  3 +++
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 9 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index efd4a0655159..605aaf38c3f5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -47,12 +47,14 @@ struct security_hook_heads {
  * struct lsm_id - Identify a Linux Security Module.
  * @lsm: name of the LSM, must be approved by the LSM maintainers
  * @id: LSM ID number from uapi/linux/lsm.h
+ * @lsmblob: indicates the LSM has an entry in struct lsmblob
  *
  * Contains the information that identifies the LSM.
  */
 struct lsm_id {
 	const char	*name;
 	u64		id;
+	bool		lsmblob;
 };
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 360a454d5f8e..947cb3a35db4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -192,6 +192,7 @@ struct lsmblob {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
+extern u32 lsm_blob_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d676ed2b246e..dc045164b86b 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -143,6 +143,7 @@
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
+#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index b194494c4dc4..9d971fa96c0e 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -54,6 +54,7 @@
 #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/security.h>
+#include <linux/lsm_hooks.h>
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
@@ -2228,21 +2229,51 @@ int audit_log_task_context(struct audit_buffer *ab)
 {
 	struct lsmcontext ctx;
 	struct lsmblob blob;
+	bool space = false;
 	int error;
+	int i;
 
 	security_current_getlsmblob_subj(&blob);
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_lsmblob_to_secctx(&blob, &ctx, LSM_ID_UNDEF);
-	if (error < 0) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (lsm_blob_cnt < 2) {
+		error = security_lsmblob_to_secctx(&blob, &ctx, LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", ctx.context);
+		security_release_secctx(&ctx);
 		return 0;
 	}
-
-	audit_log_format(ab, " subj=%s", ctx.context);
-	security_release_secctx(&ctx);
+	/* Multiple LSMs provide contexts. Include an aux record. */
+	audit_log_format(ab, " subj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if (!lsm_idlist[i]->lsmblob)
+			continue;
+		error = security_lsmblob_to_secctx(&blob, &ctx,
+						   lsm_idlist[i]->id);
+		if (error < 0) {
+			if (error == -EOPNOTSUPP)
+				continue;
+			audit_log_format(ab, "%ssubj_%s=?", space ? " " : "",
+					 lsm_idlist[i]->name);
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_task_context");
+		} else {
+			audit_log_format(ab, "%ssubj_%s=%s", space ? " " : "",
+					 lsm_idlist[i]->name, ctx.context);
+			security_release_secctx(&ctx);
+		}
+		space = true;
+	}
+	audit_buffer_aux_end(ab);
 	return 0;
 
 error_path:
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b5f3beb26d5a..075942b253ae 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1447,6 +1447,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 static const struct lsm_id apparmor_lsmid = {
 	.name = "apparmor",
 	.id = LSM_ID_APPARMOR,
+	.lsmblob = true,
 };
 
 static struct security_hook_list apparmor_hooks[] __ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 57b9ffd53c98..2da40774dd20 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -19,6 +19,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 static const struct lsm_id bpf_lsmid = {
 	.name = "bpf",
 	.id = LSM_ID_BPF,
+	.lsmblob = true,
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/security.c b/security/security.c
index 444051575793..8ff6cef26e6c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -269,6 +269,7 @@ static void __init initialize_lsm(struct lsm_info *lsm)
  * Current index to use while initializing the lsm id list.
  */
 u32 lsm_active_cnt __ro_after_init;
+u32 lsm_blob_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT];
 
 /**
@@ -599,6 +600,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		if (lsm_active_cnt >= LSM_CONFIG_COUNT)
 			panic("%s Too many LSMs registered.\n", __func__);
 		lsm_idlist[lsm_active_cnt++] = lsmid;
+		if (lsmid->lsmblob)
+			lsm_blob_cnt++;
 	}
 
 	for (i = 0; i < count; i++) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ed4237223959..656f25337334 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7092,6 +7092,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
+	.lsmblob = true,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a58e2c14f120..a9ab31a40e36 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5069,6 +5069,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 static const struct lsm_id smack_lsmid = {
 	.name = "smack",
 	.id = LSM_ID_SMACK,
+	.lsmblob = true,
 };
 
 static struct security_hook_list smack_hooks[] __ro_after_init = {
-- 
2.41.0


