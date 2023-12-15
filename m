Return-Path: <linux-kernel+bounces-1759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B898153A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB294286E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB318ED4;
	Fri, 15 Dec 2023 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a1FP82km"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0818EB6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679372; bh=4LhKS1dSp6/aRhZhVxxpOMfzUTMlpn6YH3k+S376Occ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=a1FP82km1z3caVooNt2FMFfdMyUTRZf13iMB7SZ32fNGIYKmddGWgfP1LXxdBL+gqcTZArkfrPWp4+nuTpiUUki483X10m9YsQhOVMeve0qNRliHWbH6yKbG5NJcbKZIZ6D2FkrNOwObRVfB5bYBGXFVIWmhgQzswsDGdAkTEE6KtFpf3a/1m6zMe9Zd9tw5hFU/ibeTu1HLqk2Sa7nHg7l30e6H2hmCznugfd/Gj3qQJN1NcYyAHeT6oy4TZfk+961aeL+tAtz3yPOcJJtRDl8LEgl9et0Pav7jW0rdBlwjRr3nMeM7rsXOK1pI+iFvDcqZtlgMubVLnuhDpz9x1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679372; bh=SWHPnTAgjCxjL/NgCROjTqbzvJAgirvRVZRe2R0YNuZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ep+F8MyeHyJxwgAdiJNfEVAbaNccUQnTqLD5wV+Nk6gBUtNw5AZ/QlDOaUfA0UEHAbSQf0XVWt/29Upkc16qxOSDKGmaughOd94OwxbJsULRjtqaCSXu+dsh09Q9yGs7yPSE1UjXO3Ddwz+kE3QaVmwLr3lv2uBhR6RBJu6ZHGKXgyKWPOPzIf1NNr0SZY3AB8kk08YhEdR8iKfwSHJ85kde3SqHvqNNdMxzyhkLznvjEaBjllMnWT33OrTeMzN7JYtigpur0HAHwjZuuRC3FqQPHD+LDtC7doLsDxK8Y8xheybMDQEdfzSrlhwGbNltS8KNb93HVNfBo45NpH/97g==
X-YMail-OSG: C8R6ojoVM1mPBBe.JlbfoPhuIHkgWruFpgJ4Hn17_b1pXpagOzp7CBzGvQ3uNn7
 SkcHMzRAkFR7eViuX5pA08G5fyCE3FR_G2BpL3lZa7UkFVVHMZazSrq0t2Qr.87IxVL50Vw2FRj5
 tVxjM4R_K1kJw9j3fz_R0XDfWe9H_F_sTi2qyIDJvaClGFLI8EVZPVDQF0XkUMqZO7TSlao1F58G
 zr30IPBJa1SlLO43qe4FFk8r_PF6l7lHaLf6K28fEupXIMN9EfB1_fxteiEXE_4YbwrP3rMIf03J
 Ko7LyxZOQvXS5zawzcGXjOSRH9WVq9udz27E9JkyHfQ36r44tr4eY9FWcT7e2wXcULnAc66Wjoyv
 W7Pupt_jEJdivoVw52PZJcXTLCwWP2dn7IhZ2iEoMcIESswE61nXXgKXhrYhKo8BzR8Ywu2Plduh
 nq9O2yQUVdPS4UhwdrexBnshbpuphhX8d1psBptqxmPoff0hJfqolIgClfJdUxjTvr8LEHynkjTZ
 P_XCw.IOvAPMoAfrL7E8leouoMQ8HPnwIcCG8Ofj93WEPDRTbZksXmFgvPM1zqtmum7dhIvtQX_1
 CE8tvuormyCF5mMF2OWVXYMJA5bg3yWr_p4D1hCfhpOw2sa9h31NbCRiUaPbvqAlA6vMKdvGwxc4
 OpK9HUxkHenqH01cs2_rAz0FH0n06N98lxc57X4TamrPoPkc7eppQ4nlcntTtf_9wXFZuApawG9E
 uuW3hKj95XOG1EUCoOkCebeaZeJ8JgOautXNToppumAlBtxrptzUUHXBXE7Ap8qEfLqqFWeZTmoC
 tzJZBTUNxgO95UFgWLttQg610F6CNCSNRzjjOokWGQUqLNiqTGoo1H6NZEzxVA.HWsmMAffffGQW
 dA3nY1YyFraZ4b4YdLG7Wq79PumAeqUhZurRwIiaruulMry2qibAQ6GAo4gYwcyMXdePNDm4Rgnc
 tUnfVvXluV_zS5s5msLSL7iSrKPpBrJJolepg_kmJlL3kzbxAs5IGJsLuWLiGTftC7WIyIffU_JZ
 0qou4.oxbrpO4Taa5OcyiGVICwlVFF2AS6sTo6ZjkaA12gg5.WAGwLhx1UW4SClQVDnT2eTkJAQE
 E1hiDd9Jv0tQ3Q.FXmuvRW4qAbzKbDXCoYqLrf0.FGz7GoGBHo9sDQm4gRJnSwb4ZHODQrvhaKcS
 rZ9t9RjaDA43wZCER7ZRRhDqRlTIgLN2CCg5v1CdJhbkSmPRlfdLmqxuET9ODnMKJjnNqQd04.Yp
 DDv8pL9s69OMTlhJA0j_IL.CGx2Ct81a.lHM.8ZTc2dL51LV.OD4TIJujNqfNZEw4hKvSuJo0VJ5
 dxSL9xtNtqK2Msw1GotWT8LkZNOA1.aDjGcio0McktvuIRp6vSa7RcaM2MTbLR2N27jqgHLlGn3h
 MsF3uH7UGxgJAaMJOixMqJOx_JocELXtU05Dh10Ar5RLq68x_bGjiI3Te2J20tC_NWCXgLsmIecb
 gkKRIXijM91xjh6yt_wj2x7ykimH1gHK_4raATXAvazMIi8wdV4TFVgiE33jqnVyW9R645iRdzKC
 cJMcQyV0dkPwyKB00Qwt5tC0qnAbRdxv5LJ1_ddMnPxEJ7UFHwHlsYPteBr5jHOXSrmtx8tQvugE
 YpVzRiCHjOh2akeOjnB9Zx1DO7HXu8rr5qZbzjVLmAhHXJmXIm_Nf._1Jp29RMqwFpkQzcC1XLb_
 H9PlhApTE6SkjF5Sqdkbh8O2aB0.mShLUqT9DcxoGPUpm8hf0CmADwUyrcRjqsMgMlyaUmBFaDUj
 hKAbInucH74TUwpOCrn3FBFsgLCFURekrLP4yA_xJ9u_XPsQhcDVcuLgNp8..U_VWB.vg_.d1UaD
 u5GG5KULZLcNQM485jKSqsPnpZEV_TgsHmT4k7yCtChnIT1GQWD8UsLOo5GGhB2N.ftkYLRxFC0L
 cZ5wXjmnTCWU1nSTAinKxQ_Wd6hJ4cJ.z3oi_JFRRlDMmU4y2SiP_XBMRxQzrat80WBAJ3Olg2j2
 v2Hs8DHGEaGpDHpowP.tHOamXfszDPi72ffs6aebZSbQIZNDmeK7CS8I4hSgQgGdMB7OGatyADKf
 ZgqTfoVspwMQ7Ek1FiP4_PG8qHvJipG7VsvecLMOGJbzkB1iYao1BNfy4wTJ1sQe68dYEmc8qlef
 A8CP4QZCZvdT1UaTgX5lcy3HyroaqXXTtDbslwl2lQ6BJpyvenbGUOTKkPxRJK16nQg8Dj7.5XOQ
 WrfT7vYAe9xyAlMBvXoYPEBFu2ZAIwg9Bjz_9duoclK9FPTO5xzLTaxPiwTXVivIUciLVu_IwWnB
 CiQVEUthhMM7WXReuwIfAaLBMvE68cw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 78e8c0bb-cb01-438b-ab26-b82b1d5134d3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:29:32 +0000
Received: by hermes--production-gq1-6949d6d8f9-nsbdm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d22b1f6ad07bda71c6e1d3c51ac27d9d;
          Fri, 15 Dec 2023 22:29:26 +0000 (UTC)
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
	mic@digikod.net,
	netdev@vger.kernel.org,
	audit@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH v39 17/42] LSM: Use lsmcontext in security_secid_to_secctx
Date: Fri, 15 Dec 2023 14:16:11 -0800
Message-ID: <20231215221636.105680-18-casey@schaufler-ca.com>
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

Replace the (secctx,seclen) pointer pair with a single
lsmcontext pointer to allow return of the LSM identifier
along with the context and context length. This allows
security_release_secctx() to know how to release the
context. Callers have been modified to use or save the
returned data from the new structure.

security_secid_to_secctx() will now return the length value
on success instead of 0.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: netdev@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c                |  5 ++---
 include/linux/lsm_hook_defs.h           |  3 +--
 include/linux/security.h                |  5 ++---
 include/net/scm.h                       |  5 ++---
 net/ipv4/ip_sockglue.c                  |  4 ++--
 net/netfilter/nf_conntrack_netlink.c    |  8 ++++----
 net/netfilter/nf_conntrack_standalone.c |  4 ++--
 net/netfilter/nfnetlink_queue.c         | 27 ++++++++++---------------
 net/netlabel/netlabel_unlabeled.c       | 13 +++++-------
 security/apparmor/include/secid.h       |  2 +-
 security/apparmor/secid.c               | 13 +++++++-----
 security/security.c                     | 17 ++++++++--------
 security/selinux/hooks.c                | 17 ++++++++++++++--
 security/smack/smack_lsm.c              | 16 ++++++++-------
 14 files changed, 72 insertions(+), 67 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 58bdb5b75131..c0fa95e64e7c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3199,9 +3199,8 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &secid);
-		ret = security_secid_to_secctx(secid, &lsmctx.context,
-					       &lsmctx.len);
-		if (ret) {
+		ret = security_secid_to_secctx(secid, &lsmctx);
+		if (ret < 0) {
 			binder_txn_error("%d:%d failed to get security context\n",
 				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c5e5a32f5e07..8e0155ac6697 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -273,8 +273,7 @@ LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
-LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
-	 u32 *seclen)
+LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsmcontext *cp)
 LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
 	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
diff --git a/include/linux/security.h b/include/linux/security.h
index 9712056d71a0..03b79089eaf7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -562,7 +562,7 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_secid_to_secctx(u32 secid, struct lsmcontext *cp);
 int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 			       u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
@@ -1487,8 +1487,7 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata,
-					   u32 *seclen)
+static inline int security_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 6e1add51d4c2..91452b36b5bf 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -97,10 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &ctx.context,
-					       &ctx.len);
+		err = security_secid_to_secctx(scm->secid, &ctx);
 
-		if (!err) {
+		if (err >= 0) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, ctx.len,
 				 ctx.context);
 			security_release_secctx(&ctx);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 3bf8ff9d4434..38b9f822a70d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -138,8 +138,8 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
-	if (err)
+	err = security_secid_to_secctx(secid, &ctx);
+	if (err < 0)
 		return;
 
 	put_cmsg(msg, SOL_IP, SCM_SECURITY, ctx.len, ctx.context);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3e79b339a1bc..a7dfc39bfbf3 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -360,8 +360,8 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct lsmcontext ctx;
 	int ret;
 
-	ret = security_secid_to_secctx(ct->secmark, &ctx.context, &ctx.len);
-	if (ret)
+	ret = security_secid_to_secctx(ct->secmark, &ctx);
+	if (ret < 0)
 		return 0;
 
 	ret = -1;
@@ -669,8 +669,8 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
-	if (ret)
+	ret = security_secid_to_secctx(ct->secmark, NULL);
+	if (ret < 0)
 		return 0;
 
 	return nla_total_size(0) /* CTA_SECCTX */
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 23949d233375..a1d8952db1c1 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -178,8 +178,8 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	struct lsmcontext ctx;
 	int ret;
 
-	ret = security_secid_to_secctx(ct->secmark, &ctx.context, &ctx.len);
-	if (ret)
+	ret = security_secid_to_secctx(ct->secmark, &ctx);
+	if (ret < 0)
 		return;
 
 	seq_printf(s, "secctx=%s ", ctx.context);
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 8b4c5c08daa7..f7918b21672d 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -319,18 +319,18 @@ static int nfqnl_put_sk_classid(struct sk_buff *skb, struct sock *sk)
 	return 0;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
+static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *ctx)
 {
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
+
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark)
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
-
+		seclen = security_secid_to_secctx(skb->secmark, ctx);
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
 	return seclen;
@@ -408,8 +408,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info ctinfo = 0;
 	const struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
+	struct lsmcontext ctx;
 	u32 seclen = 0;
 	ktime_t tstamp;
 
@@ -484,8 +483,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
-		if (seclen)
+		seclen = nfqnl_get_sk_secctx(entskb, &ctx);
+		if (seclen >= 0)
 			size += nla_total_size(seclen);
 	}
 
@@ -624,7 +623,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	if (nfqnl_put_sk_classid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (seclen && nla_put(skb, NFQA_SECCTX, ctx.len, ctx.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -652,10 +651,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen >= 0)
+		security_release_secctx(&ctx);
 	return skb;
 
 nla_put_failure:
@@ -663,10 +660,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen >= 0)
+		security_release_secctx(&ctx);
 	return NULL;
 }
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 464105080245..b43cfb4fe4f1 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -437,8 +437,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid, &ctx.context,
-					     &ctx.len) == 0) {
+		if (security_secid_to_secctx(secid, &ctx) >= 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
 			security_release_secctx(&ctx);
 		}
@@ -491,8 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid, &ctx.context,
-					     &ctx.len) == 0) {
+		    security_secid_to_secctx(entry->secid, &ctx) >= 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
 			security_release_secctx(&ctx);
 		}
@@ -550,8 +548,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid, &ctx.context,
-					     &ctx.len) == 0) {
+		    security_secid_to_secctx(entry->secid, &ctx) >= 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
 			security_release_secctx(&ctx);
 		}
@@ -1122,8 +1119,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
-	if (ret_val != 0)
+	ret_val = security_secid_to_secctx(secid, &ctx);
+	if (ret_val < 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
 			  NLBL_UNLABEL_A_SECCTX,
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index e47c37c1beda..b66c2d043a02 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -25,7 +25,7 @@ struct aa_label;
 extern int apparmor_display_secid_mode;
 
 struct aa_label *aa_secid_to_label(u32 secid);
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(u32 secid, struct lsmcontext *cp);
 int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 			       u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index e9f655f54a42..55d6c54fe90e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -61,7 +61,7 @@ struct aa_label *aa_secid_to_label(u32 secid)
 	return xa_load(&aa_secids, secid);
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label = aa_secid_to_label(secid);
@@ -76,8 +76,8 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	if (apparmor_display_secid_mode)
 		flags |= FLAG_SHOW_MODE;
 
-	if (secdata)
-		len = aa_label_asxprint(secdata, root_ns, label,
+	if (cp)
+		len = aa_label_asxprint(&cp->context, root_ns, label,
 					flags, GFP_ATOMIC);
 	else
 		len = aa_label_snxprint(NULL, 0, root_ns, label, flags);
@@ -85,9 +85,12 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	if (len < 0)
 		return -ENOMEM;
 
-	*seclen = len;
+	if (cp) {
+		cp->len = len;
+		cp->id = LSM_ID_APPARMOR;
+	}
 
-	return 0;
+	return len;
 }
 
 int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
diff --git a/security/security.c b/security/security.c
index 063a209ac17f..708a26a88447 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4172,17 +4172,16 @@ EXPORT_SYMBOL(security_ismaclabel);
 /**
  * security_secid_to_secctx() - Convert a secid to a secctx
  * @secid: secid
- * @secdata: secctx
- * @seclen: secctx length
+ * @cp: the LSM context
  *
- * Convert secid to security context.  If @secdata is NULL the length of the
- * result will be returned in @seclen, but no @secdata will be returned.  This
+ * Convert secid to security context.  If @cp is NULL the length of the
+ * result will be returned, but no data will be returned.  This
  * does mean that the length could change between calls to check the length and
- * the next call which actually allocates and returns the @secdata.
+ * the next call which actually allocates and returns the data.
  *
- * Return: Return 0 on success, error on failure.
+ * Return: Return length of data on success, error on failure.
  */
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -4192,7 +4191,7 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	 * LSM hook is not "stackable").
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
+		rc = hp->hook.secid_to_secctx(secid, cp);
 		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
 			return rc;
 	}
@@ -4221,7 +4220,7 @@ int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 	struct security_hook_list *hp;
 	int rc;
 
-	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+	hlist_for_each_entry(hp, &security_hook_heads.lsmblob_to_secctx, list) {
 		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
 		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
 			return rc;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a428a6964a0..37b97cf81da1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6565,9 +6565,22 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int selinux_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 {
-	return security_sid_to_context(secid, secdata, seclen);
+	u32 seclen;
+	u32 ret;
+
+	if (cp) {
+		cp->id = LSM_ID_SELINUX;
+		ret = security_sid_to_context(secid, &cp->context, &cp->len);
+		if (ret < 0)
+			return ret;
+		return cp->len;
+	}
+	ret = security_sid_to_context(secid, NULL, &seclen);
+	if (ret < 0)
+		return ret;
+	return seclen;
 }
 
 static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7dab00bbd0ed..d82753bc52ab 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4814,19 +4814,21 @@ static int smack_ismaclabel(const char *name)
 /**
  * smack_secid_to_secctx - return the smack label for a secid
  * @secid: incoming integer
- * @secdata: destination
- * @seclen: how long it is
+ * @cp: destination
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int smack_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 {
 	struct smack_known *skp = smack_from_secid(secid);
+	int len = strlen(skp->smk_known);
 
-	if (secdata)
-		*secdata = skp->smk_known;
-	*seclen = strlen(skp->smk_known);
-	return 0;
+	if (cp) {
+		cp->context = skp->smk_known;
+		cp->len = len;
+		cp->id = LSM_ID_SMACK;
+	}
+	return len;
 }
 
 /**
-- 
2.41.0


