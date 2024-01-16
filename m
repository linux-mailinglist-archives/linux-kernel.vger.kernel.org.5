Return-Path: <linux-kernel+bounces-26842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD2182E6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4A8285613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C2208AD;
	Tue, 16 Jan 2024 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/2hP/qx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC012032C;
	Tue, 16 Jan 2024 01:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6972C433C7;
	Tue, 16 Jan 2024 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367164;
	bh=86xLXhYSMvu32FARZ5Pxl3JK/oUTBtbgMS0hXaOtL4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/2hP/qxFtHW5xZi14SMd8q3DQDY2hWCG3JxI0/zM6DA7bi3wIKmI9HeKHXARTX+v
	 Kl/NxkOmY3z6hmdCdv5x/6OC20X0F5mEO79MXxiAnJlfKyOJdzfeIG9ovOsHaklBIR
	 ZEUNlHUiQsHljhzMnnySmImqnBNKejv5Z0Ec4eLa3bSYgk6Mtkwy28hza5wByBjvJM
	 TekRYN+W0i9ajh+jwyTa3g4zKrgu39iKTNVlCmBzVxusvf0oKVlYE+9228jxFROssE
	 yFUTS+7wGp+DXUIylkT5WaFUYqf9bXnGzS9YOlVbLJNdaqmJZShujaQAzTj7XGdI89
	 ydJSJRRLm1Q7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre Mariani <pierre.mariani@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 12/19] smb: client: Fix minor whitespace errors and warnings
Date: Mon, 15 Jan 2024 20:05:07 -0500
Message-ID: <20240116010532.218428-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Pierre Mariani <pierre.mariani@gmail.com>

[ Upstream commit 0108ce08aed195d200ffbad74c1948bbaefe6625 ]

Fixes no-op checkpatch errors and warnings.

Signed-off-by: Pierre Mariani <pierre.mariani@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 76ccbdba5855..a763097f0af3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -455,6 +455,7 @@ static int reconnect_target_unlocked(struct TCP_Server_Info *server, struct dfs_
 static int reconnect_dfs_server(struct TCP_Server_Info *server)
 {
 	struct dfs_cache_tgt_iterator *target_hint = NULL;
+
 	DFS_CACHE_TGT_LIST(tl);
 	int num_targets = 0;
 	int rc = 0;
@@ -717,6 +718,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 {
 	struct msghdr smb_msg = {};
 	struct kvec iov = {.iov_base = buf, .iov_len = to_read};
+
 	iov_iter_kvec(&smb_msg.msg_iter, ITER_DEST, &iov, 1, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
@@ -1372,11 +1374,13 @@ cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs)
 	case AF_INET: {
 		struct sockaddr_in *saddr4 = (struct sockaddr_in *)srcaddr;
 		struct sockaddr_in *vaddr4 = (struct sockaddr_in *)rhs;
+
 		return (saddr4->sin_addr.s_addr == vaddr4->sin_addr.s_addr);
 	}
 	case AF_INET6: {
 		struct sockaddr_in6 *saddr6 = (struct sockaddr_in6 *)srcaddr;
 		struct sockaddr_in6 *vaddr6 = (struct sockaddr_in6 *)rhs;
+
 		return (ipv6_addr_equal(&saddr6->sin6_addr, &vaddr6->sin6_addr)
 			&& saddr6->sin6_scope_id == vaddr6->sin6_scope_id);
 	}
@@ -2576,8 +2580,8 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 			rc = -EOPNOTSUPP;
 			goto out_fail;
 		} else {
-			cifs_dbg(VFS, "Check vers= mount option. SMB3.11 "
-				"disabled but required for POSIX extensions\n");
+			cifs_dbg(VFS,
+				"Check vers= mount option. SMB3.11 disabled but required for POSIX extensions\n");
 			rc = -EOPNOTSUPP;
 			goto out_fail;
 		}
@@ -2720,7 +2724,6 @@ cifs_put_tlink(struct tcon_link *tlink)
 	if (!IS_ERR(tlink_tcon(tlink)))
 		cifs_put_tcon(tlink_tcon(tlink));
 	kfree(tlink);
-	return;
 }
 
 static int
@@ -2861,6 +2864,7 @@ static inline void
 cifs_reclassify_socket4(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
+
 	BUG_ON(!sock_allow_reclassification(sk));
 	sock_lock_init_class_and_name(sk, "slock-AF_INET-CIFS",
 		&cifs_slock_key[0], "sk_lock-AF_INET-CIFS", &cifs_key[0]);
@@ -2870,6 +2874,7 @@ static inline void
 cifs_reclassify_socket6(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
+
 	BUG_ON(!sock_allow_reclassification(sk));
 	sock_lock_init_class_and_name(sk, "slock-AF_INET6-CIFS",
 		&cifs_slock_key[1], "sk_lock-AF_INET6-CIFS", &cifs_key[1]);
@@ -2904,15 +2909,18 @@ static int
 bind_socket(struct TCP_Server_Info *server)
 {
 	int rc = 0;
+
 	if (server->srcaddr.ss_family != AF_UNSPEC) {
 		/* Bind to the specified local IP address */
 		struct socket *socket = server->ssocket;
+
 		rc = kernel_bind(socket,
 				 (struct sockaddr *) &server->srcaddr,
 				 sizeof(server->srcaddr));
 		if (rc < 0) {
 			struct sockaddr_in *saddr4;
 			struct sockaddr_in6 *saddr6;
+
 			saddr4 = (struct sockaddr_in *)&server->srcaddr;
 			saddr6 = (struct sockaddr_in6 *)&server->srcaddr;
 			if (saddr6->sin6_family == AF_INET6)
@@ -3142,6 +3150,7 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 
 	if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
 		__u64 cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
+
 		cifs_dbg(FYI, "unix caps which server supports %lld\n", cap);
 		/*
 		 * check for reconnect case in which we do not
@@ -3645,7 +3654,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 	smb_buffer_response = smb_buffer;
 
 	header_assemble(smb_buffer, SMB_COM_TREE_CONNECT_ANDX,
-			NULL /*no tid */ , 4 /*wct */ );
+			NULL /*no tid */, 4 /*wct */);
 
 	smb_buffer->Mid = get_next_mid(ses->server);
 	smb_buffer->Uid = ses->Suid;
@@ -3664,12 +3673,12 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 	if (ses->server->sign)
 		smb_buffer->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
 
-	if (ses->capabilities & CAP_STATUS32) {
+	if (ses->capabilities & CAP_STATUS32)
 		smb_buffer->Flags2 |= SMBFLG2_ERR_STATUS;
-	}
-	if (ses->capabilities & CAP_DFS) {
+
+	if (ses->capabilities & CAP_DFS)
 		smb_buffer->Flags2 |= SMBFLG2_DFS;
-	}
+
 	if (ses->capabilities & CAP_UNICODE) {
 		smb_buffer->Flags2 |= SMBFLG2_UNICODE;
 		length =
-- 
2.43.0


