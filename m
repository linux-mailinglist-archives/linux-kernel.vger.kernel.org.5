Return-Path: <linux-kernel+bounces-1760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1C8153A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168DEB2100E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C291802B;
	Fri, 15 Dec 2023 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B8WXlYQr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0918034
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679462; bh=tvjpqyt0BcyonO3ugUYGc4el/VCR47tpN/rANrjzTAc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=B8WXlYQrZfgt6RefCIoEB/5GKWJuNMD+0Hh4axrMtbk2WHtNsJ1ccCn91LqTlGGc2oyLohn2Pa+P2Vgyj/evMdowV803vIs3YOnNIChPr2jl4bsk5Rmoii9M24FoDzJqlFRNxu7NME8CiFrheF53bpTote2B0EiVMVg3gCNn4lB4SkZPU6wi4MuRT3YuNBHSto2uW2iAuRjmE/rqyWsPOi4SCyDmfBaTIEO+KI6XnVZF1hM5QwEVb3AyJFSEp3Xf0a2mJvFn3amuxEVpbZkln2LKfCUyVYtijA6UCb2bld7dZ4aIkx7GPD32k2wswqvpF+XmlOfXVssXDl99xaR/aw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679462; bh=bPByZF8rLBiGTktlsL90nGtynZWnHPGEnlWUsFGMw7Y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=umMoMCO/tUrPh6OHT/boS359m0VX7LFdo+Z2cseYI/mF2GS9ReSYkFiIjjNi2tOeO3xT3lgeK3EVSiEV0V0X2TK7Zl1n5l/yKTSQ6pbwodBs/qsiEphDt6Zy2w9jtS0oupbSCVcmAW9AjH46jyNkiwHgyNktUREJSjukXovubEKkJtzR5y0oZQssGQDIujDY4dS8AdblsPKtem5ul70D5ZyRVZjO/7/y9nLN+osvYmMvByWYClc6Iys6Yv3u6aFaOZ3hRG6whP6gddDPGT5mWuSCygsy8+IUOU0qBmw1/VFmRzh4P2061laL5eH6mkuD/9n6HNceJKHBhp0IaV65lA==
X-YMail-OSG: 0QMuOSUVM1kw95lhlQabvIQO0DmMjM8MwkYIHISkR6S1Zmjjqgmd1I6VG9HAu9s
 UW_uEKG_0Sp2XDyGA8934o315tAC5keTiNrHG4JDyzYck7hndZAP2PKyyU.rMNQod_U4kmOCZ2Wy
 sk0UCaY2pordIKX_5L1ekzeOZPv9vbia0vs1N3RCDWYDz4nR99LHvCK46d1sRncAMHUEoMCgyDGI
 rDVzrGFezs0uQUf5u52Nn_tqwPWsLfqDetUoR.a09FEcPpncIKnnbaRtWDBgr9rghbIeuF8jga8k
 p8Dv_UZ25sQ80OBNe2VwH7v9n23d.2KJcKHL5zUai9R7_gvHxf3ks.dxANjdLElKXcpsQ6NOo55s
 VtkKTiwmi25mcyw5ACbwDvT6d5_dGBz7Eo6uezZ6Ex7lzgs8ebTQlyY.AwJFQncxUmo1NEapx_66
 147cq_gkS2CnK3obiy5CPAdB6C3PwtLHBQWgMabf_HxZkRflxck93UGi3btsFVzuyzxe4opbUswu
 XB7PQvQSlD4mI4KKnB962k0BG1ro.yP6kA2rjSxqL7MKYSNxSpQVi6_KMRFHO2DRVBlMyT7uafLN
 EwVdf1uC7HRwzhg0UXDNXdZpRJcARWJsNHU0rlMuo0M9CJFXBmENC.mvRmUxIxTRmCUK1aacyELh
 xqRWgCysYoNjpTn1xwseyTIbRLh8KhLxrgns.gmAOQafuZvycSaVl8FOg4SnRPdePmqYGsEnDl0T
 fwaF.CB8PwrC472JhGTBKpN7fqwTrC.FfF3py5LcoQ.dwu5aYdOQDvdW31bfcbk9_bjtbH8XZ57Y
 qCXZnnPzYaPl2d1zDRduFapJ970p39_0g1m6Me5Yt5lAfvUF.lqtkC5RDUopAQxzBd18z.3pJtIL
 pYhLKV94ukFJI6p2fwozXbtcBJQgjTtYXNAM42vFADlk7EA6iUgJqsLYgKvP90gnwd5nazaLAER5
 yCNIMKkHtO2mROFmSyLJrJv6CDjiAgzjQJVoFFW5L4jQZlSSn5waamtljUN2QDnwCeTuic_LXa3f
 ST5sfLa7HslBpNW6SSLmWCAtRnbvy9cX_GUtNb5JMgJ2G4NAlkWhrLyyT7ZWb6R38uq.Ei14C88s
 nKSR_cSjjU1Tox49cnA8q7hSZz2udJgOuAnczrR5uyBfreTyGmnScVDpI3xOnrmOBTFzBS8cNdwn
 DMKeeIroFaIChJ_vxV2w5vfdsrn8bT.q_PdtP7M6uzzPPLVADt.v.Iyrjr.2t56a7InX6O7qfr_u
 ol0V2GSaG2oASl9Gb.J2NO0qrAgE6ouzkd1rU_UhtQoed.R.kD_2uWciajUzhEjBuzbs8PEqMbFK
 xOSIkVnq5vY02CJ.o6xVOMoPNaKP.1B_z9mW4yieW.8NKU4YMUqc296NpnD_GGTrPrqYkEFlxwq4
 U_ReCyYwjl_gb2HwHloap6jXnS0IyjpN8qyfKX3aFeXpFkbUEbYPjD8cgZMfLhZJ2jn0Cnz2Dnmu
 LSN.oaX0KmrVvaHu9n93HGn6HHAksFV9xiY2wEC52FjlJU5xLW5Sj17RDeU7WxD8E3QDjHyogf6K
 gKRBDwKBeR7IduSAT4jHgA1D2ics.zwF.6db9CW0Py3Gy0xGdfsryGqI8KeOcOhQyUO.GQQ6umr4
 ShEZ11ygArhdvo2fJ9E2bSBp7YiXYwPQF_JD45e3WO96Yif2tyzEkJHSudpdbW4BTEcmroRgMJ.v
 _HXeBO1m8QOPZQhy8GUYJiTR0fVsVSABNm1VzCPIDBm_JoO.OHAsEvOdVuKN0Yj0eWx1Wxw3U9k1
 xfem9cUF5HFh30J2ZEyreqhN50EDCWZyoAPyA1DImbDQdzzpZhMuET5UD46x.AK05l_.eo0YhQIz
 tRpW8YXXkkZ12lXvrL7ZU9AttkuqsmWBCKkbevy2N9fL5SP9BclDCnN1NMjasmbeVLz52AtjYqwr
 uPXbHb369j405k_wSvySYVBX5.IQ_mFgApi_lry5zETXKdvq9LjfQ2Lpij83x3nRPV34c5jKVekn
 QgTd0C7.hHSE3jb7nM..1QjQteixOmzz7ASD3lNPDVQ_xU16DU0bG0TlTkCLK0ZGdIpaUAH7zVTF
 JYMHRMnX9B0CYvSjRknVXjOXrclpQSXVYXKd.3qE9kj2VxL6Zdo15w5FSnBuSdBwjnSfYHLwz1jo
 gF1hWSQkoIwTnqHcvY3.WjOQXmyBDnpeuzZJm6TG78cGkcd8uAHJm4EOCI1yhtVuvd1dJn3AOidd
 Fqlu.EKQa7ylT0xaXILS2UaSSlDS2Ryb4J5BmzPN8IG9Gpf.jOz8LNLkIALkbInS6Om4ZWoVMtFj
 FkeKGSl8JYvVJCZ1vJ6X6H9K7H5Fk8w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 47bdd27c-92f1-4436-8090-65bda4506aeb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:31:02 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f41d5d0227d5bac936de484a6531ff5;
          Fri, 15 Dec 2023 22:31:00 +0000 (UTC)
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
Subject: [PATCH v39 18/42] LSM: Use lsmcontext in security_lsmblob_to_secctx
Date: Fri, 15 Dec 2023 14:16:12 -0800
Message-ID: <20231215221636.105680-19-casey@schaufler-ca.com>
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

security_lsmblob_to_secctx() will now return the length value
on success instead of 0.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: netdev@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
---
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/security.h          |  5 ++---
 kernel/audit.c                    |  9 ++++-----
 kernel/auditsc.c                  | 17 ++++++-----------
 net/netlabel/netlabel_user.c      |  3 +--
 security/apparmor/include/secid.h |  3 +--
 security/apparmor/secid.c         | 14 ++++++++------
 security/security.c               | 24 +++++++++++-------------
 security/selinux/hooks.c          | 18 +++++++++++++++---
 security/smack/smack_lsm.c        | 16 ++++++++++------
 10 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8e0155ac6697..339a4559daf8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -275,7 +275,7 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsmcontext *cp)
 LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
-	 char **secdata, u32 *seclen)
+	 struct lsmcontext *cp)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsmcontext *cp)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index 03b79089eaf7..2a0615a62125 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -563,8 +563,7 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsmcontext *cp);
-int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
-			       u32 *seclen);
+int security_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1493,7 +1492,7 @@ static inline int security_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 }
 
 static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
-					     char **secdata, u32 *seclen)
+					     struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 47cfb6b20c3c..a93a710c980e 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1462,9 +1462,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_lsmblob_to_secctx(&audit_sig_lsm,
-							 &lsmctx.context,
-							 &lsmctx.len);
-			if (err)
+							 &lsmctx);
+			if (err < 0)
 				return err;
 		}
 		sig_data_size = struct_size(sig_data, ctx, lsmctx.len);
@@ -2175,8 +2174,8 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_lsmblob_to_secctx(&blob, &ctx.context, &ctx.len);
-	if (error) {
+	error = security_lsmblob_to_secctx(&blob, &ctx);
+	if (error < 0) {
 		if (error != -EINVAL)
 			goto error_path;
 		return 0;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2874255f5f25..c37cc02ea4cc 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1109,7 +1109,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_lsmblob_to_secctx(blob, &ctx.context, &ctx.len)) {
+		if (security_lsmblob_to_secctx(blob, &ctx) < 0) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1370,7 +1370,7 @@ static void audit_log_time(struct audit_context *context, struct audit_buffer **
 
 static void show_special(struct audit_context *context, int *call_panic)
 {
-	struct lsmcontext lsmcxt;
+	struct lsmcontext lsmctx;
 	struct audit_buffer *ab;
 	int i;
 
@@ -1393,16 +1393,12 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (lsmblob_is_set(&context->ipc.oblob)) {
-			char *ctx = NULL;
-			u32 len;
-
 			if (security_lsmblob_to_secctx(&context->ipc.oblob,
-						       &ctx, &len)) {
+						       &lsmctx) < 0) {
 				*call_panic = 1;
 			} else {
-				audit_log_format(ab, " obj=%s", ctx);
-				lsmcontext_init(&lsmcxt, ctx, len, 0);
-				security_release_secctx(&lsmcxt);
+				audit_log_format(ab, " obj=%s", lsmctx.context);
+				security_release_secctx(&lsmctx);
 			}
 		}
 		if (context->ipc.has_perm) {
@@ -1563,8 +1559,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (lsmblob_is_set(&n->oblob)) {
 		struct lsmcontext ctx;
 
-		if (security_lsmblob_to_secctx(&n->oblob, &ctx.context,
-					       &ctx.len)) {
+		if (security_lsmblob_to_secctx(&n->oblob, &ctx) < 0) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index b9289a22b363..561e1e476a49 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,8 +98,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsmblob_is_set(&audit_info->blob) &&
-	    security_lsmblob_to_secctx(&audit_info->blob, &ctx.context,
-				       &ctx.len) == 0) {
+	    security_lsmblob_to_secctx(&audit_info->blob, &ctx) >= 0) {
 		audit_log_format(audit_buf, " subj=%s", ctx.context);
 		security_release_secctx(&ctx);
 	}
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index b66c2d043a02..568820a11efc 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,8 +26,7 @@ extern int apparmor_display_secid_mode;
 
 struct aa_label *aa_secid_to_label(u32 secid);
 int apparmor_secid_to_secctx(u32 secid, struct lsmcontext *cp);
-int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
-			       u32 *seclen);
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(struct lsmcontext *cp);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 55d6c54fe90e..c9b9a8d90afa 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -93,8 +93,7 @@ int apparmor_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 	return len;
 }
 
-int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
-			       u32 *seclen)
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label;
@@ -115,8 +114,8 @@ int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 	if (apparmor_display_secid_mode)
 		flags |= FLAG_SHOW_MODE;
 
-	if (secdata)
-		len = aa_label_asxprint(secdata, root_ns, label,
+	if (cp)
+		len = aa_label_asxprint(&cp->context, root_ns, label,
 					flags, GFP_ATOMIC);
 	else
 		len = aa_label_snxprint(NULL, 0, root_ns, label, flags);
@@ -124,9 +123,12 @@ int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
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
 
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
diff --git a/security/security.c b/security/security.c
index 708a26a88447..e070a6cd4089 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4203,30 +4203,28 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 /**
  * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
  * @blob: lsm specific information
- * @secdata: secctx
- * @seclen: secctx length
+ * @cp: the LSM context
  *
- * Convert a @blob entry to security context.  If @secdata is NULL the
- * length of the result will be returned in @seclen, but no @secdata
- * will be returned.  This does mean that the length could change between
- * calls to check the length and the next call which actually allocates
- * and returns the @secdata.
+ * Convert a @blob entry to security context. If @cp is NULL the
+ * length of the result will be returned, but no data will be returned.
+ * This does mean that the length could change between calls to check
+ * the length and the next call which actually allocates and returns
+ * the data.
  *
- * Return: Return 0 on success, error on failure.
+ * Return: Return length of data on success, error on failure.
  */
-int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
-			       u32 *seclen)
+int security_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 {
 	struct security_hook_list *hp;
 	int rc;
 
 	hlist_for_each_entry(hp, &security_hook_heads.lsmblob_to_secctx, list) {
-		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
+		rc = hp->hook.lsmblob_to_secctx(blob, cp);
+		if (rc != LSM_RET_DEFAULT(lsmblob_to_secctx))
 			return rc;
 	}
 
-	return LSM_RET_DEFAULT(secid_to_secctx);
+	return LSM_RET_DEFAULT(lsmblob_to_secctx);
 }
 EXPORT_SYMBOL(security_lsmblob_to_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 37b97cf81da1..d138aa692abd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6583,16 +6583,28 @@ static int selinux_secid_to_secctx(u32 secid, struct lsmcontext *cp)
 	return seclen;
 }
 
-static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
-				     u32 *seclen)
+static int selinux_lsmblob_to_secctx(struct lsmblob *blob,
+				     struct lsmcontext *cp)
 {
 	u32 secid = blob->selinux.secid;
+	u32 seclen;
+	u32 ret;
 
 	/* stacking scaffolding */
 	if (!secid)
 		secid = blob->scaffold.secid;
 
-	return security_sid_to_context(secid, secdata, seclen);
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
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d82753bc52ab..1fdd4233a9b3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4839,19 +4839,23 @@ static int smack_secid_to_secctx(u32 secid, struct lsmcontext *cp)
  *
  * Exists for audit code.
  */
-static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
-				   u32 *seclen)
+static int smack_lsmblob_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 {
 	struct smack_known *skp = blob->smack.skp;
+	int len;
 
 	/* stacking scaffolding */
 	if (!skp && blob->scaffold.secid)
 		skp = smack_from_secid(blob->scaffold.secid);
 
-	if (secdata)
-		*secdata = skp->smk_known;
-	*seclen = strlen(skp->smk_known);
-	return 0;
+	len = strlen(skp->smk_known);
+
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


