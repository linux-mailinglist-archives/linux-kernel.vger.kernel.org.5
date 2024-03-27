Return-Path: <linux-kernel+bounces-121044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6288E1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B841C2146B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEE713A877;
	Wed, 27 Mar 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5Kc1lEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83C13A876;
	Wed, 27 Mar 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541926; cv=none; b=FYvJR//+doRx1guzHpxTbqQOSp5NsWh88RBtE6PDVrCD2kT4DmWyJ+8kM7mEZ3RX6aFR8rLSwg1IwRa3c0yIPw4UJE8ms76M089VuykmYeRH4K+ocmRZk+8mDvgGf/rRFMYuINg2zA2B+Sx/6yI29nL2lh2lHxCRxVrAmPQdwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541926; c=relaxed/simple;
	bh=9OPj6gjborEVQg8+r+em2kDklBBJ4BsY+YIJnMleLrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EELZ1iNYy0BP4laZDOH4SVAFDy1EvwW0edUXRq+J66LwJHDafsYnxMdKHTQRKt5TznGASzAUZ5/5ggAcCNSkKPCzwzBh8OUqv/lGwiuyPDmxllQGtP0gRXwI38X1ETrUZd7Mf18ub46rwkgsC9Uap6qWMUMk+5SwzraaPOvzUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5Kc1lEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660BFC433F1;
	Wed, 27 Mar 2024 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541926;
	bh=9OPj6gjborEVQg8+r+em2kDklBBJ4BsY+YIJnMleLrA=;
	h=From:To:Cc:Subject:Date:From;
	b=V5Kc1lEOFCcYAhZoDSkSiIMmnrgSzE7MS2T/gbTjYY0EGYjVxGvNJito69gblkFdP
	 cMViX6gO4IeU1/qAiXwRkbxHmooCwCCE8Eo8BlKyAIlUk36Z8zoGA3fzc3fP49QniF
	 EtOFWJtPim00MvUVbzI7fo5KoGFQDUGVDKd8VKxsiywl2loJrAnKgUO4gdum0suNoA
	 V0s0iW6WGbS2dUojTb+b9ac0YdvJcZaWg4RDr5mLPPhEx2q9QDt35oB266UdxCDZoB
	 ATw+fsOetCwNppSZziVMLQ61jI2Zt8KZMeuCTAWH8knuAgYf29q0bWGcZP6lUXKWY8
	 1eLDnavpO0Q2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stfrench@microsoft.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: allow changing password during remount" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:44 -0400
Message-ID: <20240327121844.2834627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c1eb537bf4560b3ad4df606c266c665624f3b502 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Tue, 13 Feb 2024 00:40:01 -0600
Subject: [PATCH] cifs: allow changing password during remount

There are cases where a session is disconnected and password has changed
on the server (or expired) for this user and this currently can not
be fixed without unmount and mounting again.  This patch allows
remount to change the password (for the non Kerberos case, Kerberos
ticket refresh is handled differently) when the session is disconnected
and the user can not reconnect due to still using old password.

Future patches should also allow us to setup the keyring (cifscreds)
to have an "alternate password" so we would be able to change
the password before the session drops (without the risk of races
between when the password changes and the disconnect occurs -
ie cases where the old password is still needed because the new
password has not fully rolled out to all servers yet).

Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/cifs_debug.c |  2 ++
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/fs_context.c | 27 ++++++++++++++++++++++-----
 fs/smb/client/smb2pdu.c    |  5 +++++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 3e4209f41c18f..23d2622b969f0 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -488,6 +488,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				ses->ses_count, ses->serverOS, ses->serverNOS,
 				ses->capabilities, ses->ses_status);
 			}
+			if (ses->expired_pwd)
+				seq_puts(m, "password no longer valid ");
 			spin_unlock(&ses->ses_lock);
 
 			seq_printf(m, "\n\tSecurity type: %s ",
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 53c75cfb33ab9..ec9a26bd05a12 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1066,6 +1066,7 @@ struct cifs_ses {
 	enum securityEnum sectype; /* what security flavor was specified? */
 	bool sign;		/* is signing required? */
 	bool domainAuto:1;
+	bool expired_pwd;  /* track if access denied or expired pwd so can know if need to update */
 	unsigned int flags;
 	__u16 session_flags;
 	__u8 smb3signingkey[SMB3_SIGN_KEY_SIZE];
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 4b2f5aa2ea0e1..415e87635d5aa 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -772,7 +772,7 @@ static void smb3_fs_context_free(struct fs_context *fc)
  */
 static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 				       struct smb3_fs_context *new_ctx,
-				       struct smb3_fs_context *old_ctx)
+				       struct smb3_fs_context *old_ctx, bool need_recon)
 {
 	if (new_ctx->posix_paths != old_ctx->posix_paths) {
 		cifs_errorf(fc, "can not change posixpaths during remount\n");
@@ -798,8 +798,15 @@ static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 	}
 	if (new_ctx->password &&
 	    (!old_ctx->password || strcmp(new_ctx->password, old_ctx->password))) {
-		cifs_errorf(fc, "can not change password during remount\n");
-		return -EINVAL;
+		if (need_recon == false) {
+			cifs_errorf(fc,
+				    "can not change password of active session during remount\n");
+			return -EINVAL;
+		} else if (old_ctx->sectype == Kerberos) {
+			cifs_errorf(fc,
+				    "can not change password for Kerberos via remount\n");
+			return -EINVAL;
+		}
 	}
 	if (new_ctx->domainname &&
 	    (!old_ctx->domainname || strcmp(new_ctx->domainname, old_ctx->domainname))) {
@@ -843,9 +850,14 @@ static int smb3_reconfigure(struct fs_context *fc)
 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
 	struct dentry *root = fc->root;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(root->d_sb);
+	struct cifs_ses *ses = cifs_sb_master_tcon(cifs_sb)->ses;
+	bool need_recon = false;
 	int rc;
 
-	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx);
+	if (ses->expired_pwd)
+		need_recon = true;
+
+	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx, need_recon);
 	if (rc)
 		return rc;
 
@@ -858,7 +870,12 @@ static int smb3_reconfigure(struct fs_context *fc)
 	STEAL_STRING(cifs_sb, ctx, UNC);
 	STEAL_STRING(cifs_sb, ctx, source);
 	STEAL_STRING(cifs_sb, ctx, username);
-	STEAL_STRING_SENSITIVE(cifs_sb, ctx, password);
+	if (need_recon == false)
+		STEAL_STRING_SENSITIVE(cifs_sb, ctx, password);
+	else  {
+		kfree_sensitive(ses->password);
+		ses->password = kstrdup(ctx->password, GFP_KERNEL);
+	}
 	STEAL_STRING(cifs_sb, ctx, domainname);
 	STEAL_STRING(cifs_sb, ctx, nodename);
 	STEAL_STRING(cifs_sb, ctx, iocharset);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 608ee05491e26..a500380d1b2e9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1536,6 +1536,11 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 			    &sess_data->buf0_type,
 			    CIFS_LOG_ERROR | CIFS_SESS_OP, &rsp_iov);
 	cifs_small_buf_release(sess_data->iov[0].iov_base);
+	if (rc == 0)
+		sess_data->ses->expired_pwd = false;
+	else if ((rc == -EACCES) || (rc == -EKEYEXPIRED) || (rc == -EKEYREVOKED))
+		sess_data->ses->expired_pwd = true;
+
 	memcpy(&sess_data->iov[0], &rsp_iov, sizeof(struct kvec));
 
 	return rc;
-- 
2.43.0





