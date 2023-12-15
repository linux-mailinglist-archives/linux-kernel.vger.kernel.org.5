Return-Path: <linux-kernel+bounces-1793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB978153F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D861F24279
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356246554;
	Fri, 15 Dec 2023 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o42C0lgv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBC18EDD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680511; bh=K7csj15FYLLSxxZ7kmvWUnCpbvfgQe4Te4FnBFnK+kc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=o42C0lgvhJJccYUQJIt3HAj2Mp25A9V4iriVooDx9znzphhTVPMPe2Ci/FLEbxk9I6qQwU6Uy2BvujwGC1iqoucayfhJt9mQ2MLoYEAxDQLAJfNa7G/5BbvwyHyQZLpmzGcoQ8r+pA+BvYl3XcFM38+bDod4sDxBpvC3HaFpdyjcyh7wPmsmjN8xRKledvsKL7yhgsuny8Gw5P6wNtkkqrAHpG7CVU34JK0Ga4ayyI2+0EwHlriJbP3jNO183lGG+9us+cPKQmr/3bJ4dnGzWP7nR722+XfTCQKs93/MwLzuG/HWLrNgxxBO/RzgYXURLY7tYEG756RHchSlhldX4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680511; bh=DtL8HKeo5K0jeMbDCKFA+5LU5qxUJKbqKjaC0bD6jGG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RSBKnnBYBZLwiWPvCKmzj2dPWHIAe/Wq9FTAy4TVyBjTs/Xdg2u1tjKGMOIaNx6HmNoNnCBS5Kth9ojYusDUUXPu0Anq+7B4kwxR/7HwqHn2uCEqTZe+CQUHNGVk45oqgmOGCr2Vuotj1fr+QoD0YD4unXmORvD8bcJog4u6oV9mfjSBS8lGEqTvYWDK4YOphh4djbzAznYLZHlNwhxKlBehOR2yksw2o+7OmFw+r4F1Ectd9XqpHz3r5pKhlAsH56LwMCDOV8uo6sf+StLVUk4W0KezzrHK8owzICc0cQvhzsj2wyKXKcgS8ScuN+oiIuTkpZU7UTRh4bnf+RMJEw==
X-YMail-OSG: oBmP0J0VM1mym6yc5Gp3a9_15t6J9XSDppTDpHUsmj6MnaiAdbXU9C26zxhS6vx
 u6oUtGKCsByZN.b51ldHCc7Rwx0HCOM.Ebhw9MDi6NlcqEkgTtbOmAlyWCNTdi1NSf5vJrlX1QlX
 k6Y6iDs0O7G6Mb0juy5tZwEj2YsfEa0UqaQ_yvyHEUKvCrRY4Xu_xpaQVWo5VdfsGfTqgdV0HVg4
 OMjXUxGiwKYQwe3V38ZoWrPVSwtFkTstALsmNohS35EJW3gdicHUwg83jHoLgYCPHDCLamzJROjq
 J_p.WpuB10_XomKafKlat0mc.JVyd2cWoKDhR0J8tfH7_mK9IwPcWGYo6N.6ygqYC19oNy3tfmWK
 RzINYpgeZ2S6aBskXwOdcx5ADtibgoD.pG8LjAhTmPC_.A85P2nK3NM.e8dSdeyJUMA5.c.tye7D
 dKA3VaFfysThkL3Hl9TImEt01WDQbgeGQtl3dE8rfLmHd74Q58U6Zqh6AZW9E8j5lLHERvJQQ96z
 wnvU_tR1lAWeywKshGfj014HyzObVDRNrr6LanZWhXNcMFUKgnc1cciqLV1VJY4BMwUbEFRYssnx
 fqiSPnfbBvMTaizuxDBTr8eKwcng0bSBdLrEDaDPAcQZE9eIlAfQ.JgfnPoBeUUPiCd1cEs4aivP
 xWnsw._XkmXKa3o26D5zKv_jcV3FgpAwKZykbtuOwsUlGY3Ogkr2L6VtP_afA554ebfTqIhXy..1
 v2xSi2LTNynbB6WdCeEz0cWJmbiSrhGWsUnqggDw3yQxcxyjOIXaat2garwGbhlQ_LPVKxoDApQU
 s_nSU4pZI.ROxnvDcsvzMnCgbmGWV9FZjbEpGEsvspsl9MJv80luwmBCeV3kO6F1ewxubRumcEXC
 2T4Yq3VuJmcv4YxFPhYZiM6ZwFytDh4HzPa0j8wzFq5eSKg.njYnyauTWUyEOP8ypW2Z3pZ7Cx.K
 M1VfV0xrMlYj.Q7_cif5DASZ1lPOYsEkwgJLg_s.5KBmmWilCzBYqLhwWWvBCoSlQm9h626b9gff
 mP4N2a_x82pzl1HPm7PF7CmgzVgz8JLPicgOqmgQ9PtPAPpTz6Zl15hFk.jzIdVVLgrk2CbjAH3G
 YPY5QJc86kZ5dpKl9a.w2vOzrX5uPJciF5Ovthq7q43QHsOEuEqF5dWxFmGW4n2CGPE6FkHq9MCY
 nV9V32IybxfuOOeoLFIaCApKUtvHsSz4eMPR3IBGxBxhc2Y_HPYS7Sw798XqZKWNnqvXlw0nxJCr
 88MB_nkgMIvdLIIH5F7C20QC0ia.F42wBYr24v.RnaOdTJaJKcJ0fq05q3.tfsSdjPmm.G3ptE7D
 dixjZ4PEDpKo9QVMvJ3.9Mi4C0UAme3VSA2D4r1VOs4Tm8oeqTVk4KVBgRtZhLHqL3JXXtrvNFCL
 QM7W_Ti.ycoR6B9X70g2085zGMSzS_dclDdEn6caAjAmiZocO7qPR8BgAKrytFHgiErlxLoYw7iT
 QJuga7KaYbfmr2w8xzo_zgCWM.slTPeEfER8sOdVzbU4ckqKbNKfcpZ_8G9lBGAkJpntc47XecsH
 O9lJAFEh9c.vCwAIqSA0Usrbk0FiNazWXjxpwzmU9IOwCyFzC_1aMDADcDY0O7VQDmAgaLAhCs7O
 ahWkHKi.VvUZVokBfLxKZ5Ud_nRlfCPkTjnnpi9jtV.vE0XwPM0iK_R35k8jAZd0eA0Spyciw..m
 XmwIZizaBaQB9qza2rDMe8lqAMtXe9BCqby4qIVY7mBg9nodZb_WKnECVMqa8I0EbNp2mJlybsn0
 SQGM.yrk9Rk_hOgiTtw2vXOiH0zuPJ4yDJsSbsyxtDxhS_Zmw5PPb1Khc8nek7mlgMXp6gyR39Ku
 5ojg1Y6LJPoPMEfAw_toJMMKy8LVfqa0w1Il3dK4jP5G4JcTWzgUFjNyAV4BqhId12nPhftXkgMR
 0B3lzYpo_EhIQvvyhC_6rvGkJlQDaJqix4vWW7N5oKezo.1cDRBycUcVWPg9egJL2vW1VKgg83vv
 ClMY4DW1iK9LZLq0rHMcYuUvqZDAnV8NScr3bPhM9q0DdmGfwBLTB_GdL5XdDrIxZCz6bKIufIqe
 cve5uNG6.WUaabWPzyjb6MzVEeZIe7lOUdkDzAW_xXM.9c3432fmE3DK8Z0c93ycYSDocJvqzJ0m
 epPWLSfMetOyfBF.E8DzO_eZfOqIFvNt93.2AAXvUYThPzANtcUEszB8cEJQ3gq44T4wtA3eW.Su
 zGDUvlopJXqDTvjA00gg9NX02s27mZb1s1iqizdPaLiKi0N3LW0cy5St.7FdRSiBOINaEG1hGco1
 GbdU9jaqUw4EFCAdT03UTE8tv5EaD
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 39fbb8ec-7d31-4bc7-827d-e816f8f08030
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:48:31 +0000
Received: by hermes--production-gq1-6949d6d8f9-qkzts (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 98319ae8e5188ac722d06529a3337566;
          Fri, 15 Dec 2023 22:48:25 +0000 (UTC)
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
Subject: [PATCH v39 40/42] LSM: Allow reservation of netlabel
Date: Fri, 15 Dec 2023 14:16:34 -0800
Message-ID: <20231215221636.105680-41-casey@schaufler-ca.com>
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

Allow LSMs to request exclusive access to the netlabel facility.
Provide mechanism for LSMs to determine if they have access to
netlabel. Update the current users of netlabel, SELinux and Smack,
to use and respect the exclusive use of netlabel.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h           |  1 +
 security/security.c                 |  6 +++++
 security/selinux/hooks.c            |  7 +++---
 security/selinux/include/netlabel.h |  5 +++++
 security/selinux/netlabel.c         |  4 ++--
 security/smack/smack.h              |  5 +++++
 security/smack/smack_lsm.c          | 35 +++++++++++++++++++++--------
 security/smack/smackfs.c            | 20 ++++++++++++++++-
 8 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fdeffa0c8d13..da60bf163447 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -84,6 +84,7 @@ struct lsm_blob_sizes {
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
 	int	lbs_mnt_opts;
 	bool	lbs_secmark;	/* expressed desire for secmark use */
+	bool	lbs_netlabel;	/* expressed desire for netlabel use */
 };
 
 /**
diff --git a/security/security.c b/security/security.c
index b1a849e8589c..f1bff6b5b076 100644
--- a/security/security.c
+++ b/security/security.c
@@ -242,6 +242,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		else
 			needed->lbs_secmark = false;
 	}
+	if (needed->lbs_netlabel) {
+		if (!blob_sizes.lbs_netlabel)
+			blob_sizes.lbs_netlabel = true;
+		else
+			needed->lbs_netlabel = false;
+	}
 }
 
 /* Prepare LSM for initialization. */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 113ee3df9b5a..6da2e95ad5b7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -182,7 +182,7 @@ static int selinux_secmark_enabled(void)
 static int selinux_peerlbl_enabled(void)
 {
 	return (selinux_policycap_alwaysnetwork() ||
-		netlbl_enabled() || selinux_xfrm_enabled());
+		selinux_netlbl_enabled() || selinux_xfrm_enabled());
 }
 
 static int selinux_netcache_avc_callback(u32 event)
@@ -5673,7 +5673,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
-	if (netlbl_enabled())
+	if (selinux_netlbl_enabled())
 		/* we do this in the FORWARD path and not the POST_ROUTING
 		 * path because we want to make sure we apply the necessary
 		 * labeling before IPsec is applied so we can leverage AH
@@ -5690,7 +5690,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	struct sock *sk;
 	u32 sid;
 
-	if (!netlbl_enabled())
+	if (!selinux_netlbl_enabled())
 		return NF_ACCEPT;
 
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
@@ -6965,6 +6965,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 	.lbs_secmark = true,
+	.lbs_netlabel = true,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 4d0456d3d459..189803009d04 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -147,4 +147,9 @@ static inline int selinux_netlbl_socket_connect_locked(struct sock *sk,
 }
 #endif /* CONFIG_NETLABEL */
 
+static inline bool selinux_netlbl_enabled(void)
+{
+	return selinux_blob_sizes.lbs_netlabel && netlbl_enabled();
+}
+
 #endif
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index e8832726bd86..1242296b5fe1 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -198,7 +198,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	int rc;
 	struct netlbl_lsm_secattr secattr;
 
-	if (!netlbl_enabled()) {
+	if (!selinux_netlbl_enabled()) {
 		*type = NETLBL_NLTYPE_NONE;
 		*sid = SECSID_NULL;
 		return 0;
@@ -440,7 +440,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 	u32 perm;
 	struct netlbl_lsm_secattr secattr;
 
-	if (!netlbl_enabled())
+	if (!selinux_netlbl_enabled())
 		return 0;
 
 	netlbl_secattr_init(&secattr);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 85ec8141fe70..2191f8304e4f 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -367,6 +367,11 @@ static inline struct smack_known **smack_key(const struct key *key)
 }
 #endif /* CONFIG_KEYS */
 
+static inline bool smack_netlabel(void)
+{
+	return smack_blob_sizes.lbs_netlabel;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a486ac42caac..9f5a37a5b47e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2584,6 +2584,9 @@ static int smack_netlbl_add(struct sock *sk)
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
+	if (!smack_netlabel())
+		return 0;
+
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
@@ -2614,6 +2617,9 @@ static void smack_netlbl_delete(struct sock *sk)
 {
 	struct socket_smack *ssp = smack_sock(sk);
 
+	if (!smack_netlabel())
+		return;
+
 	/*
 	 * Take the label off the socket if one is set.
 	 */
@@ -2664,7 +2670,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 		/*
 		 * Clear the socket netlabel if it's set.
 		 */
-		if (!rc)
+		if (!rc && smack_netlabel())
 			smack_netlbl_delete(sk);
 	}
 	rcu_read_unlock();
@@ -3970,6 +3976,8 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 	int acat;
 	int kcat;
 
+	if (!smack_netlabel())
+		return smack_net_ambient;
 	/*
 	 * Netlabel found it in the cache.
 	 */
@@ -4126,6 +4134,9 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	struct socket_smack *ssp = NULL;
 	struct smack_known *skp = NULL;
 
+	if (!smack_netlabel())
+		return NULL;
+
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
@@ -4196,7 +4207,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
-		if (rc != 0)
+		if (rc != 0 && smack_netlabel())
 			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4407,7 +4418,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	if (skp == NULL) {
 		skp = smack_from_netlbl(sk, family, skb);
 		if (skp == NULL)
-			skp = &smack_known_huh;
+			skp = smack_net_ambient;
 	}
 
 #ifdef CONFIG_AUDIT
@@ -4428,8 +4439,11 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	/*
 	 * Save the peer's label in the request_sock so we can later setup
 	 * smk_packet in the child socket so that SO_PEERCRED can report it.
+	 *
+	 * Only do this if Smack is using netlabel.
 	 */
-	req->peer_secid = skp->smk_secid;
+	if (smack_netlabel())
+		req->peer_secid = skp->smk_secid;
 
 	/*
 	 * We need to decide if we want to label the incoming connection here
@@ -4442,10 +4456,12 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	hskp = smack_ipv4host_label(&addr);
 	rcu_read_unlock();
 
-	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
-	else
-		netlbl_req_delattr(req);
+	if (smack_netlabel()) {
+		if (hskp == NULL)
+			rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		else
+			netlbl_req_delattr(req);
+	}
 
 	return rc;
 }
@@ -4463,7 +4479,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
-	if (req->peer_secid != 0) {
+	if (smack_netlabel() && req->peer_secid != 0) {
 		skp = smack_from_secid(req->peer_secid);
 		ssp->smk_packet = skp;
 	} else
@@ -5062,6 +5078,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_secmark = true,
+	.lbs_netlabel = true,
 };
 
 static const struct lsm_id smack_lsmid = {
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 878fe44b662d..f8c0ea18b2fe 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -77,7 +77,7 @@ static DEFINE_MUTEX(smk_net6addr_lock);
  * If it isn't somehow marked, use this.
  * It can be reset via smackfs/ambient
  */
-struct smack_known *smack_net_ambient;
+struct smack_known *smack_net_ambient = &smack_known_floor;
 
 /*
  * This is the level in a CIPSO header that indicates a
@@ -685,6 +685,9 @@ static void smk_cipso_doi(void)
 	struct cipso_v4_doi *doip;
 	struct netlbl_audit nai;
 
+	if (!smack_netlabel())
+		return;
+
 	smk_netlabel_audit_set(&nai);
 
 	rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
@@ -725,6 +728,9 @@ static void smk_unlbl_ambient(char *oldambient)
 	int rc;
 	struct netlbl_audit nai;
 
+	if (!smack_netlabel())
+		return;
+
 	smk_netlabel_audit_set(&nai);
 
 	if (oldambient != NULL) {
@@ -848,6 +854,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	 */
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 	if (*ppos != 0)
 		return -EINVAL;
 	if (format == SMK_FIXED24_FMT &&
@@ -1178,6 +1186,8 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	 */
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 	if (*ppos != 0)
 		return -EINVAL;
 	if (count < SMK_NETLBLADDRMIN || count > PAGE_SIZE - 1)
@@ -1437,6 +1447,8 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 	 */
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 	if (*ppos != 0)
 		return -EINVAL;
 	if (count < SMK_NETLBLADDRMIN || count > PAGE_SIZE - 1)
@@ -1608,6 +1620,8 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
@@ -1675,6 +1689,8 @@ static ssize_t smk_write_direct(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
@@ -1753,6 +1769,8 @@ static ssize_t smk_write_mapped(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
-- 
2.41.0


