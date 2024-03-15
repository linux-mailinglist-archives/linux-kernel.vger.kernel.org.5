Return-Path: <linux-kernel+bounces-104727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3D87D2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE382844FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087D4C600;
	Fri, 15 Mar 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LiRpwiB8"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6654642A;
	Fri, 15 Mar 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523874; cv=none; b=WbcKNfx2zbcOOSthdfZOyiTI5Qx7cMZE92K2byTqrs+QKGQ6WQaqw4pNZ7RJ4xU2zdQH04pTsJPQ20MXcfNUs1v0bTuGPra08i0Y1v/NU+Wm2oDusLc/Jq4nc39rVLObn5xtw23F2tCkT0Skm8d46Rm58rFVH85oUY3EiSf/eTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523874; c=relaxed/simple;
	bh=rjDnkjs+ZYqLGAWaK7/C4IYmXWE3AUvsfoFz7CE1bAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/YZDtvhH7+UPrJbh2ckd+QuXik5o21U5WHKgJUg2YTpWblkIt/7oFQhsn3nj9ELrh93tU5MyiHbKY7a19tWdcDJMInSqfMZvnEmM8+6bIA+VVdmDknqVLuptFJxLBy7H54f9GJbG3sLGATb1tXAEiR3/9uCqqLZva5uTVJGMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LiRpwiB8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so2752943a12.0;
        Fri, 15 Mar 2024 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710523870; x=1711128670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDsYhpfipGym17a6LaH0lhvlMbNzYHAToLHVYi0KWTs=;
        b=LiRpwiB8dPS09pF49p5nbOpo4mPy8IXhlMw1SNXkES/5QBTyPG6F018NM2ifrgLZip
         LI5qKBPERcGIJMzNZgwUdpzIvbIZvl0AnVVTV0s9aiGY4lcaM4E3ys6i1dRSvz1YSyI4
         t8SrWcN6bupvQWnPlIK8UZyCgKLjAw1VPdyWlatqER0nAEWn8QFQFq2Z6hFxDL2wLMlU
         dSAzaPx3W4mFT+AUBenQ89MSSo7Jh/2DCYkEh+UXObOBPrEfBHdjI49ORKlY2hHY00SR
         +QuTCHpc0wIk7ld/pQgoLIA2YLY4i+Awh44sGizuv5iE73luD6pvv7hkP5RBA692bYmc
         Nw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523870; x=1711128670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDsYhpfipGym17a6LaH0lhvlMbNzYHAToLHVYi0KWTs=;
        b=XsoY8R681H2n6B7ywe7ja+4ZYjISBxF158trc6Qh3Jg3hzZN4PONr/kWfVvFsaeBPe
         iqKq42NtRDRb8f4pqGB0JRt90M6GKKl/8kiISwlxOZDgf2ifDOLlCSaNG6eo/VqoceLd
         kAZz4lLU5gkBdveOBsMJeLmtAWEvJGLyHHrzZzLHsvgzjA4+ViDuNC/GqCdwdNcq2Mdz
         DTyVMv4tv5b2sGb8Pa22D+5Nga6RFVTz3UEq+frNx7Bj9+XKPRVbhBircTfm4zfFQlDS
         6E0pCvozNJk53yefHt41Zj69wrwth7nkTyJek4sKkr8f43i3Yqf7hDljPap3ijsd4p2U
         nkgw==
X-Forwarded-Encrypted: i=1; AJvYcCWRWdcte/zUg+81PnS7IHRMCMxX8ZqnsF0JHwd7d8aUMm2/Gs2GxYKSKW3GHCezxo1V7toQ6+4wa7pje4xwa6ZCPANxiEOlqolJNftk
X-Gm-Message-State: AOJu0YzoufYdGjX9Fas/KdFjzrbFZ4G2nZgQ3q+aQ4AkcOR4ojuAYvwn
	AafpvCofgIB3al/5B5/zFhGxGcGlSTpGZOEiDW6o17PY6HyRDv0CMFC6EZ6wKvRKdw==
X-Google-Smtp-Source: AGHT+IHpyUZXiIN8kGjVmByDzzTyMESb0L/JkcRU11qQ26QKy5L7v3Z5vhKpomS7I/0PiWnGTnJCrw==
X-Received: by 2002:a05:6402:5486:b0:566:806a:6f9e with SMTP id fg6-20020a056402548600b00566806a6f9emr3777774edb.28.1710523869433;
        Fri, 15 Mar 2024 10:31:09 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7da57000000b00568ba93876esm88935eds.28.2024.03.15.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:31:09 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selinux: make more use of current_sid()
Date: Fri, 15 Mar 2024 18:31:00 +0100
Message-ID: <20240315173105.636749-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the internal helper current_sid() where applicable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 22 ++++++----------------
 security/selinux/xfrm.c  |  7 ++-----
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f9a61ff64b83..9c41dc9eb0a0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2961,7 +2961,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 					    const struct qstr *name,
 					    const struct inode *context_inode)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	u32 sid = current_sid();
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
 	int rc;
@@ -2990,7 +2990,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	} else {
 		isec->sclass = SECCLASS_ANON_INODE;
 		rc = security_transition_sid(
-			tsec->sid, tsec->sid,
+			sid, sid,
 			isec->sclass, name, &isec->sid);
 		if (rc)
 			return rc;
@@ -3005,7 +3005,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return avc_has_perm(tsec->sid,
+	return avc_has_perm(sid,
 			    isec->sid,
 			    isec->sclass,
 			    FILE__CREATE,
@@ -3063,14 +3063,12 @@ static int selinux_inode_readlink(struct dentry *dentry)
 static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 				     bool rcu)
 {
-	const struct cred *cred = current_cred();
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
-	u32 sid;
+	u32 sid = current_sid();
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
-	sid = cred_sid(cred);
 	isec = inode_security_rcu(inode, rcu);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
@@ -3094,12 +3092,11 @@ static noinline int audit_inode_permission(struct inode *inode,
 
 static int selinux_inode_permission(struct inode *inode, int mask)
 {
-	const struct cred *cred = current_cred();
 	u32 perms;
 	bool from_access;
 	bool no_block = mask & MAY_NOT_BLOCK;
 	struct inode_security_struct *isec;
-	u32 sid;
+	u32 sid = current_sid();
 	struct av_decision avd;
 	int rc, rc2;
 	u32 audited, denied;
@@ -3116,7 +3113,6 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 
 	perms = file_mask_to_av(inode->i_mode, mask);
 
-	sid = cred_sid(cred);
 	isec = inode_security_rcu(inode, no_block);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
@@ -5563,13 +5559,7 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	const struct task_security_struct *tsec;
-	u32 tsid;
-
-	tsec = selinux_cred(current_cred());
-	tsid = tsec->sid;
-
-	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO,
+	return avc_has_perm(current_sid(), sid, SECCLASS_PACKET, PACKET__RELABELTO,
 			    NULL);
 }
 
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 95fcd2d3433e..90ec4ef1b082 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -76,7 +76,6 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 				   gfp_t gfp)
 {
 	int rc;
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct xfrm_sec_ctx *ctx = NULL;
 	u32 str_len;
 
@@ -103,7 +102,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 	if (rc)
 		goto err;
 
-	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
+	rc = avc_has_perm(current_sid(), ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, NULL);
 	if (rc)
 		goto err;
@@ -134,12 +133,10 @@ static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
  */
 static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
-
 	if (!ctx)
 		return 0;
 
-	return avc_has_perm(tsec->sid, ctx->ctx_sid,
+	return avc_has_perm(current_sid(), ctx->ctx_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
 			    NULL);
 }
-- 
2.43.0


