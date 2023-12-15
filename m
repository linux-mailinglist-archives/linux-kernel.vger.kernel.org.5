Return-Path: <linux-kernel+bounces-1780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07988153DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07D71F2689A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B618EC7;
	Fri, 15 Dec 2023 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PPZC3NED"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18618EAF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680032; bh=HgKzEIUhaILipzY9DdZwoNSdFerxS4tj7fn6yV2s/8c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PPZC3NEDdt7Us7Ydx1VW0Sl1zTTAqxBCOp1DbkHH0feKwMcyMmOlSJivc6XjYd+QvMM/wzd0mk9LMyN1BintFp1YQQ2FwtnR39zwyfKQWLE4yAcgM28UT9LXtAVx0Wr+rRpXpUzXkH5klCVlXuLywnlLFE1HGsxsbFC3iqgrYJfnFc0D9hKxDPpazyRCigzzdufSOBIkLfxmC8QzbHfYr4ZfsCLXhdtUHrumX+aRDBK7zHUe1dEvAQTNXhn0MpNIuWtfOW7/Z5uXYgTTtdV5Zm028nD4Xjmr2Ok8Zh1DMhv4pkxNuHwLQ9EgOa7tsdJS4IRNWMZ900pjWAIau/qMBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680032; bh=20Z0uj3l4zIsBAGeaBkSy96dDVzLo/RmCINWO23RmQW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W6OlrNS9Kn1r21it5z8rUtTpJsfIqDPMFrmaxKjYSDhGL1iuRwhWMmrRIA+XiC/E21YlldeawmEfzfUS2MxCFdPWMOOFsbpu932OOrMC2OKkcm1gJAZpA7a/doZvag6NiDYp/7xU+p0YEA2r4ADRvPUZ7d2p16b9Fj7yvHRizqm3M9TtG1avYODFuuK6b5KJvMlVG5iZxD8WUY0WnJxmgHw5FvhaEJrmANhAypsPnV+OS9OL5sXrZsl8qMsKZEw4ANhxqX8Kh6TxUJ0bgoQdRxaweL5tvFDOtunc3dFLjMgHdwToGOiCyYVyehp2w5zABRlMFyO1hEmoHbMPH3TLBg==
X-YMail-OSG: iOqyNHkVM1m_yVy3N01Hs1wdrRke9sf1gUAzxy_cIByHGRjwkzC2OflT2ugr3HI
 sxv1H59KVqOqhBlk2l0pIP9isgNGmtz5df8thedoToovaRMdPP9VJCSgk1_4DhLUXZZijXBa3dgV
 erISGrakYfgtr.SCnhUYbVbH996UG.4t59xAYHb5jsXdt5ZlMwdH5YCU6pYwoy_teAKHjVb1bgMI
 rEl69ejqzVYUWglgdMOayRF_TYLnRGhQfjaWWqGncOdFHbTl7JCBxYwuXrQDOCv1nuRmEfwNOlGg
 Sy76_vw4QSIXh2pLuztViKG3kuoRspMRkBq8VhIwy0zLrgcn9zcwUYm29Omv.rL4_zbu9DHSwR5b
 s5MJvc_Z2eYJpHuz9llvxPgmJxPJ8.lbzFrHa1aVFm7qEgKhf_LXf5wa3rHyWUAg.mCWZFCuQw9I
 xIaspae4zUnUo33w_In4OYRL3DNlaF3EXBmfFCnBINrv1Vv0OJruRR7EbGyzNAhHI5Gdf8sbheoa
 vh5WdniIl1oXpxdwzy_aqweWiSTNyvam_IvvDu.4rYpIWAgNJgY3QYhfUgEByIxw15KQoSW__yN0
 Pcfy_It_AvNAMqe_QjZ6dxZPGL94zm3r0.NrAyNPqurhtB11zp2V8owzeoNBs_d6K6RJad4DH6Xv
 fjvAW9CArNSN9APImuHWL.rkHEDlazjbq0EUkvk65OQ5cif5rMX_Dzic_TSR.Dbxs2t1UyF.LHGr
 I.CpDloOFnjYY18R.vA5eFOsugzZpN5wxEdQ79mbl_uQMqPb9Ci0LL_lxuA4NYDagQb4cGcytU3z
 M6aG6ig5i_h9QILbQBAUlO_bYa2g_dMcMAzl9g3U6reCYYaURIUo5LJt7rMHRBYxXXZ4ArLTBqyB
 T24lZDxJOeAUyRmVKSwQe2SZMnlBL6QsEs_rY.qRxkHkjDzFO9gt0dXgP2MWmX3P8uTmddXEPc2Q
 Uo_WHEJjWeADCfuGe08VkWu438D7myXiFcHTeXUuG3ILaJa0MtTdFZ.naK42p9nkVprO0N3qQ9pZ
 IV1cQxOfyw3VInl0UDlB14R6ufxFnCDtCuXCnP0KeSxttFrKD5sA4bvVBN0ZxTW60pFX1pd4XtDv
 mwi6MoKHZXSiiIVstWjfY0v.J0arF6Zk_WbfF4.Utg5Ob7AljHNKt6AhXXJbIzWB9NO5us3jlr9b
 200vn2pv_FHjQIE_O2ZECnkXPbMq4OPc.egWpHNbq_VfNhf6FX5zYbpfkw3atsHN2U0VpkpzWOL_
 JgferiqTIO8yZmxsSye83ij5oNW8yuoziWxHwxvZvNfLfyT6.j9yFvdgBEMxryPykESBSnMMg42Z
 It02Gc6uRnhpXQJdcv_MxfnPTy9MpUylJ_pOd3v0SYrZFjGhRQujZEY7TMIJbkcCey5PvoOWmFU8
 oe__yp9pKCnjPou2h215cmnXo6xKhTXFHLBAuURPXez9WHDR2ejp4EIRR77grn1rD1jcSoItu9Kq
 rEKT5TnQX843MYQJdeRXuT95hEd9ObHzEm93paJrxCQrRdwOLf0vaH6I.xv5ccNd_pmCL2F24RbF
 EA5if92tzerLVIIJ_UM1ijpSKbscodCZhZxmEE3pdlwpOa3ww4VFjW5xtcJC9683csaoOddATWT3
 DQnKIMKUWhfWOZm4JCuJ67yuKoao2g5eG9uSMdQCFw1z0iqNyjSYFeRvjB7oySoNUXyQ1on93XQy
 Rhd4pxqwAdEOuzyiC1DDDaYyM.aPJxXlkLUNXmXiEIqx4LRT2pcmnJaWMrNgyKBTZyPklTYJVtij
 vBhyJQpv650EdrzTAH8.PYyWgGxFb4muQn4sia2pH13YzefjsouF3uweiyeb_M0Xb.WT24Mc4Ds3
 cRXYMqhhjp5bAQjKrx0NUZo1S3e5m0L3lk83TKQNzLQIV0wiQJOi6f1vVd_AlKFUY1lSAgEkcS5E
 fLv9uFLk.b2zrGrSPKAxVOQLoM.cTZCQiySEkXiqkvNyCiVZTvZGxfUt577LiM_emPsS3OdnKdHY
 Box9E_RTMacLn9OkYqM2Opcr38YvLveAF9Ayg.KwDAqfJOvC.htioiiR63HYFlGWlVKK3tzkopS9
 buoblYYHswhrdkXmlsR1yL8CNM1hW6.ZxikAmInwL6Bc5gmEJxXpZNyTjIuW5OCI3tbKzl0kNh64
 8WHwQBvIrDJWXpICn0qDJxYOZSg_DahiAeIUcn6rmzt3DN26UL7hZ9be6UXW_VhJEPJYrWKm8.am
 xMMc7hTWIeO3DvW_Ws1dbTQhG8AVZELef8tgXwLwIEwm5UK0.jBh42q7AK2Aai_RKS8oOT4eOsvW
 z8XLibiYA99XY5CcssWYywGagCuCf.g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 15c8c364-5e98-40d6-a6bd-e2c4ffe2f2b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:40:32 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 154018758a06b94c4980c22812ec859e;
          Fri, 15 Dec 2023 22:40:31 +0000 (UTC)
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
Subject: [PATCH v39 31/42] LSM: Exclusive secmark usage
Date: Fri, 15 Dec 2023 14:16:25 -0800
Message-ID: <20231215221636.105680-32-casey@schaufler-ca.com>
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

The network secmark can only be used by one security module
at a time. Establish mechanism to identify to security modules
whether they have access to the secmark. SELinux already
incorparates mechanism, but it has to be added to Smack and
AppArmor.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  1 +
 security/apparmor/include/net.h  |  5 +++++
 security/apparmor/lsm.c          |  7 ++++---
 security/security.c              |  6 ++++++
 security/selinux/hooks.c         |  4 +++-
 security/smack/smack.h           |  5 +++++
 security/smack/smack_lsm.c       |  3 ++-
 security/smack/smack_netfilter.c | 10 ++++++++--
 8 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 605aaf38c3f5..4deb1a4d2d1a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -81,6 +81,7 @@ struct lsm_blob_sizes {
 	int	lbs_msg_msg;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
+	bool	lbs_secmark;	/* expressed desire for secmark use */
 };
 
 /**
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index c42ed8a73f1c..2e43e1e8303c 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,6 +51,11 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
+static inline bool aa_secmark(void)
+{
+	return apparmor_blob_sizes.lbs_secmark;
+}
+
 static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
 {
 	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 075942b253ae..ab9b0b37f1f7 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1322,7 +1322,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return 0;
 
 	return apparmor_secmark_check(ctx->label, OP_RECVMSG, AA_MAY_RECEIVE,
@@ -1426,7 +1426,7 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return 0;
 
 	return apparmor_secmark_check(ctx->label, OP_CONNECT, AA_MAY_CONNECT,
@@ -1442,6 +1442,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
 	.lbs_sock = sizeof(struct aa_sk_ctx),
+	.lbs_secmark = true,
 };
 
 static const struct lsm_id apparmor_lsmid = {
@@ -2105,7 +2106,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	struct aa_sk_ctx *ctx;
 	struct sock *sk;
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return NF_ACCEPT;
 
 	sk = skb_to_full_sk(skb);
diff --git a/security/security.c b/security/security.c
index 3f0a4c5094a5..8469816c0472 100644
--- a/security/security.c
+++ b/security/security.c
@@ -232,6 +232,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
+	if (needed->lbs_secmark) {
+		if (!blob_sizes.lbs_secmark)
+			blob_sizes.lbs_secmark = true;
+		else
+			needed->lbs_secmark = false;
+	}
 }
 
 /* Prepare LSM for initialization. */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6deccbbcc40..3e590f632f59 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -164,7 +164,8 @@ __setup("checkreqprot=", checkreqprot_setup);
  */
 static int selinux_secmark_enabled(void)
 {
-	return (selinux_policycap_alwaysnetwork() ||
+	return selinux_blob_sizes.lbs_secmark &&
+	       (selinux_policycap_alwaysnetwork() ||
 		atomic_read(&selinux_secmark_refcount));
 }
 
@@ -6969,6 +6970,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
+	.lbs_secmark = true,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 297f21446f45..0f5bc5c03b9e 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -369,6 +369,11 @@ static inline int smk_inode_transmutable(const struct inode *isp)
 	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
+static inline bool smack_secmark(void)
+{
+	return smack_blob_sizes.lbs_secmark;
+}
+
 /*
  * Present a pointer to the smack label entry in an inode blob.
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a9ab31a40e36..c93e81facf1b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4090,7 +4090,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 #ifdef CONFIG_NETWORK_SECMARK
 static struct smack_known *smack_from_skb(struct sk_buff *skb)
 {
-	if (skb == NULL || skb->secmark == 0)
+	if (!smack_secmark() || skb == NULL || skb->secmark == 0)
 		return NULL;
 
 	return smack_from_secid(skb->secmark);
@@ -5064,6 +5064,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_secmark = true,
 };
 
 static const struct lsm_id smack_lsmid = {
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index bad71b7e648d..fd146e3a2286 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,7 +26,7 @@ static unsigned int smack_ip_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk) {
+	if (smack_secmark() && sk) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
@@ -54,12 +54,18 @@ static const struct nf_hook_ops smack_nf_ops[] = {
 
 static int __net_init smack_nf_register(struct net *net)
 {
+	if (!smack_secmark())
+		return 0;
+
 	return nf_register_net_hooks(net, smack_nf_ops,
 				     ARRAY_SIZE(smack_nf_ops));
 }
 
 static void __net_exit smack_nf_unregister(struct net *net)
 {
+	if (!smack_secmark())
+		return;
+
 	nf_unregister_net_hooks(net, smack_nf_ops, ARRAY_SIZE(smack_nf_ops));
 }
 
@@ -70,7 +76,7 @@ static struct pernet_operations smack_net_ops = {
 
 static int __init smack_nf_ip_init(void)
 {
-	if (smack_enabled == 0)
+	if (smack_enabled == 0 || !smack_secmark())
 		return 0;
 
 	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
-- 
2.41.0


