Return-Path: <linux-kernel+bounces-1741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98197815368
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC492863A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E818EDB;
	Fri, 15 Dec 2023 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I1tRGW0v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405E18ED1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678704; bh=DnwPkOYZraIIhFEbNt5Wju9rOS7ndRvvMLf58bGhDCY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=I1tRGW0vmxhhvIh6UrZ6UaWoeGYSbgTl1vxc8/G4RDR0jcPwPurXsL5H/94oKRhdyIF/TXl+dZ/nACryUTOxAb4k1aTBnw+wBnaqkmzMDI1c7DBXmqMl17eItPLHeBwzmR5nS4xL9GsEWjnSSBfNuZJYunwkmZGc/6OjA2Db3FDFty7T7Ub1F9YcYuPBKUashxamATo6QR/HVMm2OFjfmVjl5gfGXp35w6S+TqftrR4rMmZ8RYJUiswwAn3TF9n7+oUXOHyHN/1has2TAvMESZ88/cGjSUhrQvDlw52zLl84IeOZeApZP1NvU3AEnyei0+gkM/8gV0cRazAMTxlLmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678704; bh=0EF/uQY77fW47L/zanuKc52hNgOFFesyhMuWU/QQ6ys=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WR6TFvVYBOUG/bD+aeRe3yqVsJ36QSpzYWxON/desqZGrLVvTQk14J78duyvkEf4SiUhNg0c8icYjGbT0fwaF+X7+YAUjatBl+qNBJ/MctQNOqvzU4n4IDtMD7mD3IEfOTlUqN4I/GlDJmwjfallT6iEilmenwBkGgg7j03oAGA5ZNlVlFEQScuw8pKT/LKq2n2qq4shoDVab5rUBHqFaV3iBFAD5xURy2bSCY6+SYjU67xGikX7BY7+Kc/6D+3lwOiSkTJdPRogAcAtLnOL7hOVcP5iat27P6sDKxKzzdSMGWTxXodoxUBuiyWe4sZuhEwZ69v7TrXOz7TPDzC7Vw==
X-YMail-OSG: 92CbLl4VM1m_S56aS.Q1V7aDv.lw2pScJBAFIF0.M4NScuLtPChQPQfb8V4u1gX
 zTuwnglMGNwMWNXim6W0UPyAXxJ3AXE8BPfLtLKXWtCWiXRWVwJ7Lj1nAWJfJaig218gV2pQi0OV
 SnxlBXFwYQkjcUFRrjJHk6RlvuEmt9mLhXftg1rI8O6yUaViBLSFsWbf3NMJvJN5tl7UdntdR6Fd
 xzRUhRPHroNL0j0DC6sYRakM9ej7.JbrWoBkFOvpD4i6S1U.Yt4h8S6ITknZ3SulrIW2eDm7gPbD
 mFrCFPjoEfK9HFFqbBUDZpAU5AeIM7spWtQA8AMxcWGRddvy8tzDOasf2Cobfo.3xOAbjqxsWMpw
 lZ6GdgVFefOifxeiIbJomZyLnxKig3FAcxCzPT3poJF5cTAAhKcM8TV6wva0Xn2yjk4ACrRmpCnJ
 TMKZnqe_IGhT2v3JC_Dpp5y0_YaQuu3UCAQHRUY4lYMQPWEAPwSY9Ci4r_kqtC9_vSITbBVF7pPn
 sj9tHnILl_RcIDFiJnBo2MbcSqV2KieihZJ4M5jI2KXFlyVC2E3c_6DEFFeB2vYqoUgzUPaBYyf1
 0wFvuNqTPySeN2Sl.8qBvNu47BasHUWXul53LEz3kcRyB3rLoYDbbQTuVHysqyfFOclHlhgsYV8N
 KE0QEgdGT0DNjD7QOIG9oOPTfiswdDBBGIn34hemi2bchoLU4TIFlREu6BG9Hb9uZQfVAbYiDTnp
 77WwjKQKMkzAuT8XklsqEKuntyRyTxUL7aeK0Y2RLrJxqoIeY5.1ObXHZ6fxmR3IM6Jn7KmQx9XC
 tGPsbQB0CjT7lmhaZfRfk2J_44LEHEEJRt0P0hjyV.1caWCWbe_8gepIDDRKZpak6kytx9z2KHrR
 2wPhLc3bFdM62RFfFd2NsxOymIFOWj6O6OrQB4Q2QFeV3Wtg.2_KUh_5GebsspTh3UgfMuYbDJaK
 .WTW.8Vev0mEKixLBpQsvXjduWsj4k6iDY_Ij01FYIOyxXZBJK9Z2acd9RRUQU4AzYD_nNX90ZDM
 CnWXlncRyxrxt92gvlfzBesrWhYeyWpWB21itSQdZKClgD6ZlFUtvcBBP.o3k7AZzV885tULrmCB
 fN6fyGbsA6pOPJLGuZ44IZQ20BcnaabeIFVUnU2WCOFT0eGPTlCUN8gG_NR2gPKidQmpcCQMlamH
 aiiG4bGQ95b3lgs_TLSDt7p90bJ6KDHxQVrn8VEDDsvr_kS02cXvi9nOoFhbcR9Q66culMPd5u30
 htNPXYLPgxn7dOX179VU2Cg2CErtS..tOX_bVmbAApWvv6YSAsOnYrK2CX_tzsNbZBrh8CDAGexd
 xnchwbflqxQ9DWAkijPJNH9gC1DbQerWeqFT3IF09FkeSSq85UKtt_wBNMjrIbfQx3YknncvpFmL
 Pgnf6.FUZi3hfk5cr4NyPa9kBjNb4irEr69WMYhr29H6uWoWVeld8ogmwIxIIZkXcsC.0kzWTRuj
 LTw9m.l3QLtipPIbjhAZSLfW60aPY4qietdKwrBNXExgkT2vdQS10roCEabLBhywB7KSYH7CClwF
 ZiV2k4ALgEWRsAnDR2UtmuCOQ1zrFyg9rE47pPoRFl4tiXp1AUfvwJEen6QGhsICku_B6CKxkROz
 YVm1y99Ycopaihopv9Yai6qZOGn90G0jkoCEb5Nzk.FoiVrpLsHhAfxjy6Ml.Nn15YCXXtpExfaY
 K42IFfOoenJPC_1Mh46hkSusPfS5bta.xsRtifPW5fSTVds_3ZqbNCu3RyFmUhxj5EY_uQ1GDXXK
 slUPHPXx7Atc6lqU9ciffHW7LYdFX4tgDNqb4oh9gOZVe2wNhgz5p_bObaREsfD_JF6Gsw_VsyOe
 _9r07lFbVIDbBpcCQeRsWrcOFvjRvHZGc0QF7UrVgRihuKJ6iLKT4GOHvlgWiO6A6S2RbDFwV_me
 QVOInMkX6oe4Ff24QnmyFasL9bLCt3xjclQIehkMxtaIPJHFlmhYsMRyrI0CE8VFZ0WDzv7qRZWq
 D1cgdHUhwl5b1cPTGaJA8m9sxjJazPYlKiqtkC9YWKLUvUs5hzOhCjuIhxJC7H_m7LRV7fc8HK53
 37lL4YC.UHj9K7DgkpekjKYVMYl7AMBhRFnzkEdsL9aak4xUWYlyY2BvnmkKL8mDzuBdFRKQbacO
 bHmKnzA2_IlqybXP01xNC4F_ipb8f2zTZawSSIv396jvY.jg09IiH00C8MzkAgC4VwLlTs57SxlB
 s0QAf7GfjkjPrKpLGlunnTN7tBwJbaj6J2ptzo3.ujA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 24a17b18-0db7-4e1c-b805-ac479274476e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:18:24 +0000
Received: by hermes--production-gq1-6949d6d8f9-c9pk7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f3cc26e4d12b933f3b6c85ffc86b5c01;
          Fri, 15 Dec 2023 22:18:18 +0000 (UTC)
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
Subject: [PATCH v39 02/42] SM: Infrastructure management of the sock security
Date: Fri, 15 Dec 2023 14:15:56 -0800
Message-ID: <20231215221636.105680-3-casey@schaufler-ca.com>
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

Move management of the sock->sk_security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/apparmor/include/net.h   |  3 +-
 security/apparmor/lsm.c           | 20 +-------
 security/apparmor/net.c           |  2 +-
 security/security.c               | 36 ++++++++++++++-
 security/selinux/hooks.c          | 76 ++++++++++++++-----------------
 security/selinux/include/objsec.h |  5 ++
 security/selinux/netlabel.c       | 23 +++++-----
 security/smack/smack.h            |  5 ++
 security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
 security/smack/smack_netfilter.c  |  4 +-
 11 files changed, 131 insertions(+), 114 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..efd4a0655159 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -73,6 +73,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index 67bf888c3bd6..c42ed8a73f1c 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,10 +51,9 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
-#define SK_CTX(X) ((X)->sk_security)
 static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
 {
-	return sk->sk_security;
+	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
 }
 
 #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e490a7000408..8af5f458e218 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1056,22 +1056,6 @@ static int apparmor_userns_create(const struct cred *cred)
 	return error;
 }
 
-/**
- * apparmor_sk_alloc_security - allocate and attach the sk_security field
- */
-static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
-{
-	struct aa_sk_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), flags);
-	if (!ctx)
-		return -ENOMEM;
-
-	sk->sk_security = ctx;
-
-	return 0;
-}
-
 /**
  * apparmor_sk_free_security - free the sk_security field
  */
@@ -1079,10 +1063,8 @@ static void apparmor_sk_free_security(struct sock *sk)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	sk->sk_security = NULL;
 	aa_put_label(ctx->label);
 	aa_put_label(ctx->peer);
-	kfree(ctx);
 }
 
 /**
@@ -1452,6 +1434,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct aa_label *),
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
+	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
 static const struct lsm_id apparmor_lsmid = {
@@ -1497,7 +1480,6 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
 
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 87e934b2b548..77413a519117 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -151,7 +151,7 @@ static int aa_label_sk_perm(const struct cred *subj_cred,
 			    const char *op, u32 request,
 			    struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 	int error = 0;
 
 	AA_BUG(!label);
diff --git a/security/security.c b/security/security.c
index 8e5379a76369..0a51e3d23570 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,7 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <net/sock.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -226,6 +227,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
@@ -400,6 +402,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
@@ -4626,6 +4629,28 @@ int security_socket_getpeersec_dgram(struct socket *sock,
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
+/**
+ * lsm_sock_alloc - allocate a composite sock blob
+ * @sock: the sock that needs a blob
+ * @priority: allocation mode
+ *
+ * Allocate the sock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+{
+	if (blob_sizes.lbs_sock == 0) {
+		sock->sk_security = NULL;
+		return 0;
+	}
+
+	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
+	if (sock->sk_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * security_sk_alloc() - Allocate and initialize a sock's LSM blob
  * @sk: sock
@@ -4639,7 +4664,14 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
  */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	int rc = lsm_sock_alloc(sk, priority);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	if (unlikely(rc))
+		security_sk_free(sk);
+	return rc;
 }
 
 /**
@@ -4651,6 +4683,8 @@ int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b340425ccfae..aa15acd344ea 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4547,7 +4547,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -4600,7 +4600,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
 		/* Allows detection of the first association on this socket */
@@ -4616,8 +4616,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 static int selinux_socket_socketpair(struct socket *socka,
 				     struct socket *sockb)
 {
-	struct sk_security_struct *sksec_a = socka->sk->sk_security;
-	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
+	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
 
 	sksec_a->peer_sid = sksec_b->sid;
 	sksec_b->peer_sid = sksec_a->sid;
@@ -4632,7 +4632,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
@@ -4765,7 +4765,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
 	err = sock_has_perm(sk, SOCKET__CONNECT);
@@ -4943,9 +4943,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = selinux_sock(sock);
+	struct sk_security_struct *sksec_other = selinux_sock(other);
+	struct sk_security_struct *sksec_new = selinux_sock(newsk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -4974,8 +4974,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = selinux_sock(sock->sk);
+	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -5012,7 +5012,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
@@ -5041,7 +5041,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err, peerlbl_active, secmark_active;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -5109,7 +5109,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	int err = 0;
 	char *scontext = NULL;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -5167,34 +5167,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
-	sk->sk_security = NULL;
 	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -5208,7 +5201,7 @@ static void selinux_sk_getsecid(const struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		const struct sk_security_struct *sksec = sk->sk_security;
+		const struct sk_security_struct *sksec = selinux_sock(sk);
 
 		*secid = sksec->sid;
 	}
@@ -5218,7 +5211,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
 	struct inode_security_struct *isec =
 		inode_security_novalidate(SOCK_INODE(parent));
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -5235,7 +5228,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 {
 	struct sock *sk = asoc->base.sk;
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -5290,7 +5283,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 				      struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	u32 conn_sid;
 	int err;
 
@@ -5323,7 +5316,7 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 static int selinux_sctp_assoc_established(struct sctp_association *asoc,
 					  struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
@@ -5422,8 +5415,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 				  struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	/* If policy does not support SECCLASS_SCTP_SOCKET then call
 	 * the non-sctp clone version.
@@ -5455,7 +5448,7 @@ static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -5476,7 +5469,7 @@ static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -5493,7 +5486,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -5574,7 +5567,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -5697,7 +5690,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -5720,7 +5713,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = selinux_sock(sk);
 
 	ad_net_init_from_iif(&ad, &net, state->out->ifindex, state->pf);
 	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
@@ -5809,7 +5802,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		u32 skb_sid;
 		struct sk_security_struct *sksec;
 
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -5838,7 +5831,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -5881,7 +5874,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	unsigned int data_len = skb->len;
 	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 sclass = sksec->sclass;
 	u32 perm;
 
@@ -6915,6 +6908,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 };
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 8159fd53c3de..ca12d4d7cfc6 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -194,4 +194,9 @@ static inline struct superblock_security_struct *selinux_superblock(
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
+{
+	return sock->sk_security + selinux_blob_sizes.lbs_sock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 8f182800e412..e8832726bd86 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/netlabel.h>
 #include <net/ip.h>
@@ -68,7 +69,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -100,7 +101,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -240,7 +241,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
@@ -277,7 +278,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 
@@ -356,7 +357,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -374,8 +375,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->nlbl_state = sksec->nlbl_state;
 }
@@ -393,7 +394,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET && family != PF_INET6)
@@ -507,7 +508,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr secattr;
 
 	if (selinux_netlbl_option(level, optname) &&
@@ -545,7 +546,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 						struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	/* connected sockets are allowed to disconnect when the address family
@@ -584,7 +585,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
 	    sksec->nlbl_state != NLBL_CONNLABELED)
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 041688e5a77a..297f21446f45 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -355,6 +355,11 @@ static inline struct superblock_smack *smack_superblock(
 	return superblock->s_security + smack_blob_sizes.lbs_superblock;
 }
 
+static inline struct socket_smack *smack_sock(const struct sock *sock)
+{
+	return sock->sk_security + smack_blob_sizes.lbs_sock;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 53336d7daa93..cd44f7f3f393 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1572,7 +1572,7 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 		if (sock == NULL || sock->sk == NULL)
 			return -EOPNOTSUPP;
 
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
@@ -1960,7 +1960,7 @@ static int smack_file_receive(struct file *file)
 
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
@@ -2380,11 +2380,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 {
 	struct smack_known *skp = smk_of_current();
-	struct socket_smack *ssp;
-
-	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
-	if (ssp == NULL)
-		return -ENOMEM;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Sockets created by kernel threads receive web label.
@@ -2398,11 +2394,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	}
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
-
 	return 0;
 }
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_sk_free_security - Free a socket blob
  * @sk: the socket
@@ -2411,7 +2406,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2424,9 +2418,8 @@ static void smack_sk_free_security(struct sock *sk)
 		}
 		rcu_read_unlock();
 	}
-#endif
-	kfree(sk->sk_security);
 }
+#endif
 
 /**
  * smack_sk_clone_security - Copy security context
@@ -2437,8 +2430,8 @@ static void smack_sk_free_security(struct sock *sk)
  */
 static void smack_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct socket_smack *ssp_old = sk->sk_security;
-	struct socket_smack *ssp_new = newsk->sk_security;
+	struct socket_smack *ssp_old = smack_sock(sk);
+	struct socket_smack *ssp_new = smack_sock(newsk);
 
 	*ssp_new = *ssp_old;
 }
@@ -2554,7 +2547,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
  */
 static int smack_netlbl_add(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
@@ -2586,7 +2579,7 @@ static int smack_netlbl_add(struct sock *sk)
  */
 static void smack_netlbl_delete(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Take the label off the socket if one is set.
@@ -2618,7 +2611,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	struct smack_known *skp;
 	int rc = 0;
 	struct smack_known *hkp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -2691,7 +2684,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -2779,7 +2772,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 				int act)
 {
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	unsigned short port;
 	struct smack_known *object;
@@ -2873,7 +2866,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
@@ -2921,7 +2914,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2946,8 +2939,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
 {
-	struct socket_smack *asp = socka->sk->sk_security;
-	struct socket_smack *bsp = sockb->sk->sk_security;
+	struct socket_smack *asp = smack_sock(socka->sk);
+	struct socket_smack *bsp = smack_sock(sockb->sk);
 
 	asp->smk_packet = bsp->smk_out;
 	bsp->smk_packet = asp->smk_out;
@@ -3010,7 +3003,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
 			rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL) {
-			struct socket_smack *ssp = sock->sk->sk_security;
+			struct socket_smack *ssp = smack_sock(sock->sk);
 
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
@@ -3805,9 +3798,9 @@ static int smack_unix_stream_connect(struct sock *sock,
 {
 	struct smack_known *skp;
 	struct smack_known *okp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock);
+	struct socket_smack *osp = smack_sock(other);
+	struct socket_smack *nsp = smack_sock(newsk);
 	struct smk_audit_info ad;
 	int rc = 0;
 #ifdef CONFIG_AUDIT
@@ -3853,8 +3846,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	struct socket_smack *osp = smack_sock(other->sk);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3891,7 +3884,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;
@@ -4103,7 +4096,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
-		ssp = sk->sk_security;
+		ssp = smack_sock(sk);
 
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
@@ -4125,7 +4118,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
@@ -4229,7 +4222,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	u32 slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
@@ -4279,7 +4272,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 
 	switch (family) {
 	case PF_UNIX:
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
@@ -4328,7 +4321,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = smack_sock(sk);
 	ssp->smk_in = skp;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -4348,7 +4341,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4434,7 +4427,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -5002,6 +4995,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 };
@@ -5124,7 +5118,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
+#ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
 	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index b945c1d3a743..bad71b7e648d 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,8 +26,8 @@ static unsigned int smack_ip_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
-- 
2.41.0


