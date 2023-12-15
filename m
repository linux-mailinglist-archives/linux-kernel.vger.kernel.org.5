Return-Path: <linux-kernel+bounces-1746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01481537B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D2E1C23AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8E18ED0;
	Fri, 15 Dec 2023 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EzqDWxXQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218613B139
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678893; bh=lBi3k2ICfoYFWhBJYrFpICQoyPO6may1y/R8xZSsEgQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EzqDWxXQQDo91wTVg8AgyVbgcwHZOH54+QvMk0ikHbHZ1I8nZCl7W0qxbaX4rku3GPkfyov+UdnjhhpD77Q724BPfwTn7hz/3XrJb4zC1IBOSqXl8vQl3ABQ/xsgsjRO2XkV5v8IuntG6MbGZxM1dPJRMsYqkhGq17C0jVwd6LqGpOiM7ZHKkvgX/hXDbF0V3bveEnpgQwOmU2sUBcYeQ0ydKLg8ovLY5j4e1tvNsoa2NUYr3ewRgIDQfTgtyAC5gP2aJ4TN0JD/pLcfVgj1BwBxFncqWZgPvsDIsSs8crf++XU8Wgf2klOHdoADKY1noKiZPgitlJcBqN2z2i/KjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678893; bh=KQh7kwWXMhkLV2D8r40HzsA2QJD/rfuVKZN7A7sSF68=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=th8w8bfGVuKpnNY0HSrdvMYFOoytmt7YZZsB++n1NhBvAHK+Jd2ovlpuFgvvSLIZSSvD09C0f18qOKF1uUDtr09ZRh1h60pTUVprytry0BVkRKJ7T3VEPxEYTnPCa68Na1w21P2vXYRV+FB3W3vfGNihzO8xvLyyo9n+vMYRfFdUmbej8bYECLjaZhOxKZ9dhl37uhxk7AoodnPp9aIfkMoEp4KHyoLHQoZKFbX2figQ2NK8kFVptZld+bt8XrotrvVhzfegTuG+n3Kz7g3zEaxekOl/HJPaAuVeR3/2tuVg9DBAi9Magr0FA4dXinKKG53emtTQot1E8Q10Cwyc5A==
X-YMail-OSG: IXqotckVM1n85PzG8jhgr7f2n7hZP8jAtRfQBwFXaCeD4keWtEMwubghUYBoJAS
 Z8.vzDy9Cp7dE1925CuCVkvDC.MdXLMS2CnCxqJpGAktr02Mmwoc09MfbCF7JQJQGsvcr8hm9plY
 JA1SILk.2425c3GYkbVi0X9UeuTG8mQ1VcVgX906DTWr79BDV7Smy1tNdrEtATGrAePS7sz46keh
 VNoH2_ZBJQZMlHAYPR7OFPdax6Z_wB6iQBlQ_EsyNUsb_Z1lHvAvSFOXz28n1BFo0Ryb2LrsHqa.
 ZhP1D18IpsAMhLLH14URQdLkTYX1yVDd4HY.pXfwjnNoaBMmowClSHg7rYkKEXtAZFC_wghKRZrP
 Njqph1c0psKiAKgxwFJPntX0.18TOaj4NesJfUVhAoArdzUeub3KMVY9RhPms_7CU8tsjq1E1TJy
 7Gzmw2WucTkIpYgRUobwA3aAfUNnZZ68rTMeRx27yj_UGbsnuiGHCZIZFVTCk6G2LezH4RsKjGl0
 dxaaDjDdIHlJZwqe8JuKpHkUesQXO_uafefjMqIHNhkouMiISmTQUJe2uWXQEKpnNQMAQ2mwr_4V
 RGtA8HRdafAYhJsQlzXP822evjFLcYapfIZvmLYU35AglWGr1dQpZv6SiJqIeuFBUqZn9EGTZmrJ
 6qPHNQCvXz.2DQ2DuJnWRBSjGaJ8.0bPG0uasUUmmHDorY3Yl04ds9PgjdBF.kYBCWrlRBhRhqtc
 qGKSuVa358.s2Mx1RoFdOiGfl5MNT8RgvDLncZp2MUk0yay3pxs2a4XPckGIfdEj7XRbiz9C20Fn
 zj9kj8VsL7VzqRn1yGbuBGqSWTdeMSMSaHSTszOJTMLPGyunqTJ_R1rVMBxmpl9f_JkRggV8J92W
 IefzLRe.FZJTG0Qsq.RrM4St3KUZA4IK1dje3r_OmR8O_vNqVM1M23vRyoIrnORUzFJfC8Xt0KO6
 RtZLBiLQgenR0ylh7kdQQ2CERPxYNpde8a8ZNz0Iq.CIQzns138G0s__YgSlXB4vD5p21rseKYUE
 N_2Dzi8iS2N40OG3iK59hhbuvkSMfXXY24YYS84clhljbFgq301EYILUnSfJRDM6zlsWupLyECqT
 kpPuZOvk9Dh9pn_MbSRwI42xer09NXkC.xRlo5fZpAfYTkL0q62zaPouuqyYeePKHaiQ7qUTZBKI
 xlIiZfD8j6SN0H1gb.RAXhjFvr36j9A3sBmDDP32YFTtdUsUPPlsfCOFCbJNbOJytoTjA7aYSQ4X
 KqSvjZMTWM3IndAE.yD4d787LBt3ZAOxrXip9eNdan989OD3WNJGXNM0F1L0AfhMwAuoCLZcuSQ2
 Yegg8WIKmf.Ui28fcpocRkUtgxd_cSeUZeT._Nq.q1gKVCX8rOIG70D7yw069ok7GJnv_nc8JueX
 bkyW_FiyIKFrHjcIopRouvg9f6.unx1nJB9T_EcK59NGeRTe1FX9GkHUmKS0OmMHica3N8RB3_TS
 droRhXBsB2nIoDFte3iJvneL0IpC5YzKXm60X70xtjRUD6T1UXmpAGDfhzrSWZcWo2L1Po.3XTE4
 QeHQJiCZi4nA9Klj._IYSc3xagRwyVlxOUCLt9Q59Qmr4LjAt05tS7HgJitB9BIlr9xhlb1p49uT
 gslNuX0fatowK024B.a5OvGOF_Lu8vnvms3KHxm6m4mX0FPeZYY8YQW6_noec0E10VXLD9BvehBb
 ULEH473X7arMn7wrUZsb9aHsIlMTU_y5OCs6txZcmUTv1oYodQnnpvGmU0691UtKZIDSez9yGUC1
 iXI_SK3UyL1bkaU0wwXSJSzuPkWsOF2E7oWvUgiL1gF9Dk6gx7R.0A5gdKoOotshNNwVcnGkry2.
 sj3k81h3V7z3uQ_V7.JLWcsteArfgX2njZpZwtzY_kBDWs1aRRy3ZMHF5QTIasLj7YWb3OIDOvwl
 aHGnOS9GXYwIjc0xkC8stoLja4NrhKDY4os21qF0Y_EK0glmtah.u0mdFahJhZa5k09RVFNoUVfq
 eL5rTm3YTKvY_thf2iYtwIujPpNEdA.MG_PCkTOpyZtZ5dF3v8qzmm_OkEzOgY4jXLPgHHL0k.zs
 _3niSTV0XsL0YNVknWcx1x8SUsf_B64wmRjYpsqpFTcal2p9KPElCF4vFIuX3EToAcibr4iyWbyI
 qEbHRIFwn2j.OGZ9THwbEWdUHWhGFoX2C29IWQ4PcbEZQcdQ8wN5gpLz4KimnYVhZDnvwFuZXewn
 MeSiw1jaeI_qxzV1e1Uu6IEh.f05GOosfV7nKKJYvdPOFpQRJwFrqylJoDyJqvdjEo41yBcC6ctA
 5ic64s9dUT9GQe2hidgXAjw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3dd58605-0086-4829-9451-8c281b363c15
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:21:33 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 53259725741f313dacdbfffb86fd7fff;
          Fri, 15 Dec 2023 22:21:28 +0000 (UTC)
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
Subject: [PATCH v39 06/42] LSM: Add lsmblob_to_secctx hook
Date: Fri, 15 Dec 2023 14:16:00 -0800
Message-ID: <20231215221636.105680-7-casey@schaufler-ca.com>
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

Add a new hook security_lsmblob_to_secctx() and its LSM specific
implementations. The LSM specific code will use the lsmblob element
allocated for that module. This allows for the possibility that more
than one module may be called upon to translate a secid to a string,
as can occur in the audit code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          | 11 +++++++++-
 kernel/auditfilter.c              |  1 -
 security/apparmor/include/secid.h |  2 ++
 security/apparmor/lsm.c           |  1 +
 security/apparmor/secid.c         | 36 +++++++++++++++++++++++++++++++
 security/security.c               | 30 ++++++++++++++++++++++++++
 security/selinux/hooks.c          | 16 ++++++++++++--
 security/smack/smack_lsm.c        | 31 +++++++++++++++++++++-----
 9 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 24c588b87412..52d090d1957c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -272,6 +272,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
 	 u32 *seclen)
+LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
+	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index 6ded4f04f117..7e4b31b771c1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -507,6 +507,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1420,7 +1422,14 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(u32 secid, char **secdata,
+					   u32 *seclen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
+					     char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 0a6a1c4c3507..08dc64bb8496 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1340,7 +1340,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			struct lsmblob blob = { };
 			pid_t pid;
-			u32 sid;
 
 			switch (f->type) {
 			case AUDIT_PID:
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index a912a5d5d04f..816a425e2023 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
 
 struct aa_label *aa_secid_to_label(u32 secid);
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8af5f458e218..1b230ade84fc 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1533,6 +1533,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 #endif
 
 	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, apparmor_lsmblob_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
 	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 83d3d1e6d9dc..a7c6f5061882 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -90,6 +90,42 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen)
+{
+	/* TODO: cache secctx and ref count so we don't have to recreate */
+	struct aa_label *label;
+	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
+	int len;
+
+	AA_BUG(!seclen);
+
+	/* stacking scaffolding */
+	if (!blob->apparmor.label && blob->scaffold.secid)
+		label = aa_secid_to_label(blob->scaffold.secid);
+	else
+		label = blob->apparmor.label;
+
+	if (!label)
+		return -EINVAL;
+
+	if (apparmor_display_secid_mode)
+		flags |= FLAG_SHOW_MODE;
+
+	if (secdata)
+		len = aa_label_asxprint(secdata, root_ns, label,
+					flags, GFP_ATOMIC);
+	else
+		len = aa_label_snxprint(NULL, 0, root_ns, label, flags);
+
+	if (len < 0)
+		return -ENOMEM;
+
+	*seclen = len;
+
+	return 0;
+}
+
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	struct aa_label *label;
diff --git a/security/security.c b/security/security.c
index b3d150b6248e..4b78bface040 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4187,6 +4187,36 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
+/**
+ * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
+ * @blob: lsm specific information
+ * @secdata: secctx
+ * @seclen: secctx length
+ *
+ * Convert a @blob entry to security context.  If @secdata is NULL the
+ * length of the result will be returned in @seclen, but no @secdata
+ * will be returned.  This does mean that the length could change between
+ * calls to check the length and the next call which actually allocates
+ * and returns the @secdata.
+ *
+ * Return: Return 0 on success, error on failure.
+ */
+int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen)
+{
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
+		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(secid_to_secctx);
+}
+EXPORT_SYMBOL(security_lsmblob_to_secctx);
+
 /**
  * security_secctx_to_secid() - Convert a secctx to a secid
  * @secdata: secctx
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index aa15acd344ea..83ce496e8ef6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6549,8 +6549,19 @@ static int selinux_ismaclabel(const char *name)
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_sid_to_context(secid,
-				       secdata, seclen);
+	return security_sid_to_context(secid, secdata, seclen);
+}
+
+static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+				     u32 *seclen)
+{
+	u32 secid = blob->selinux.secid;
+
+	/* stacking scaffolding */
+	if (!secid)
+		secid = blob->scaffold.secid;
+
+	return security_sid_to_context(secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
@@ -7300,6 +7311,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, selinux_lsmblob_to_secctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9851d56dff69..a4ace6ea2ab0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4738,7 +4738,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 				  void *vrule, int lsmid)
 {
-	struct smack_known *skp;
+	struct smack_known *skp = blob->smack.skp;
 	char *rule = vrule;
 
 	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_SMACK)
@@ -4752,10 +4752,8 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		return 0;
 
 	/* stacking scaffolding */
-	if (!blob->smack.skp && blob->scaffold.secid)
+	if (!skp && blob->scaffold.secid)
 		skp = smack_from_secid(blob->scaffold.secid);
-	else
-		skp = blob->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
@@ -4786,7 +4784,6 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
-
 /**
  * smack_secid_to_secctx - return the smack label for a secid
  * @secid: incoming integer
@@ -4805,6 +4802,29 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+/**
+ * smack_lsmblob_to_secctx - return the smack label
+ * @blob: includes incoming Smack data
+ * @secdata: destination
+ * @seclen: how long it is
+ *
+ * Exists for audit code.
+ */
+static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+				   u32 *seclen)
+{
+	struct smack_known *skp = blob->smack.skp;
+
+	/* stacking scaffolding */
+	if (!skp && blob->scaffold.secid)
+		skp = smack_from_secid(blob->scaffold.secid);
+
+	if (secdata)
+		*secdata = skp->smk_known;
+	*seclen = strlen(skp->smk_known);
+	return 0;
+}
+
 /**
  * smack_secctx_to_secid - return the secid for a smack label
  * @secdata: smack label
@@ -5162,6 +5182,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, smack_lsmblob_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
-- 
2.41.0


