Return-Path: <linux-kernel+bounces-121081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6588E22B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBEF1C2A85E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04313B2BC;
	Wed, 27 Mar 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+z4sUAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434116B44B;
	Wed, 27 Mar 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542028; cv=none; b=IOwKO4ADEboEyS4F0vxfyvOkqAqM/nxDuibJXzJ75JRoiaF+3da6zi/Wx9SSsg2ESXAuY1YlmVeUlX6DYEIiwPrfm+yYMJNcQLJ8XHBK1haeFEAjQkvjSkA7a88ajGaVNnia8AinyK2qya/nvxqFEmHXervCdj9Oq0uk0N7ePOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542028; c=relaxed/simple;
	bh=ajzpZ7mbS9f4diigeTEoqFowa0NlPCQAFiGJXhpB3/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYox7ii8lcijdesowcDu+s4Nzvlf43hL4mnY4m40djRReJE1GbqDdWGC5X2swT7AejGgssfh5VpqIh9VNeXM6vbqypyVJ5AkX0ZLFTbrNyp/drk/O3h6OjH0MNf3UGmK0t0XD3NOHEVmIaQI6LBNqDon35/ZE/UySTm6owLMZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+z4sUAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDBFC433C7;
	Wed, 27 Mar 2024 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542028;
	bh=ajzpZ7mbS9f4diigeTEoqFowa0NlPCQAFiGJXhpB3/o=;
	h=From:To:Cc:Subject:Date:From;
	b=B+z4sUADsxP9VsUXkQ87PyOkmF0L+moSg5vX0XiZWJo9U441LwyzTEGbHI4FLnwnW
	 oBM53Y59t+0fajjHdfS/njquK8TObgjwuBT58NWbaBLMlrQ9Usxu5RBSHCdgfW1RPL
	 4aFmCftzvSfx0akothVTC6qCeQR4AdgloHY3g1DMzBVFdci3kBbJd0AHJGF+LsGTyV
	 Lsg5vNYFpPp9DWvfPTRK/2Eh8P0dCJbFBQcYpQIuXkt7RwhREkmDIImt/iRDY8ML60
	 IO9DL0dwUGUGXS54Oq8LP/fxgSMQyxG8Ql6GfMWYtAKowTtGbeyYOCn3Bw6R8+N0vC
	 Ah4w3XnG7uTaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sprasad@microsoft.com
Cc: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: make sure server interfaces are requested only for SMB3+" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:26 -0400
Message-ID: <20240327122026.2836042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 13c0a74747cb7fdadf58c5d3a7d52cfca2d51736 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Wed, 13 Mar 2024 10:40:41 +0000
Subject: [PATCH] cifs: make sure server interfaces are requested only for
 SMB3+
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some code paths for querying server interfaces make a false
assumption that it will only get called for SMB3+. Since this
function now can get called from a generic code paths, the correct
thing to do is to have specific handler for this functionality
per SMB dialect, and call this handler.

This change adds such a handler and implements this handler only
for SMB 3.0 and 3.1.1.

Cc: stable@vger.kernel.org
Cc: Jan Čermák <sairon@sairon.cz>
Reported-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/cifsglob.h | 3 +++
 fs/smb/client/connect.c  | 6 +++++-
 fs/smb/client/smb2ops.c  | 2 ++
 fs/smb/client/smb2pdu.c  | 5 +++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 8be62ed053a25..3da625d532359 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -355,6 +355,9 @@ struct smb_version_operations {
 	/* informational QFS call */
 	void (*qfs_tcon)(const unsigned int, struct cifs_tcon *,
 			 struct cifs_sb_info *);
+	/* query for server interfaces */
+	int (*query_server_interfaces)(const unsigned int, struct cifs_tcon *,
+				       bool);
 	/* check if a path is accessible or not */
 	int (*is_path_accessible)(const unsigned int, struct cifs_tcon *,
 				  struct cifs_sb_info *, const char *);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 86ae578904a26..4cbb79418e506 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -123,12 +123,16 @@ static void smb2_query_server_interfaces(struct work_struct *work)
 	struct cifs_tcon *tcon = container_of(work,
 					struct cifs_tcon,
 					query_interfaces.work);
+	struct TCP_Server_Info *server = tcon->ses->server;
 
 	/*
 	 * query server network interfaces, in case they change
 	 */
+	if (!server->ops->query_server_interfaces)
+		return;
+
 	xid = get_xid();
-	rc = SMB3_request_interfaces(xid, tcon, false);
+	rc = server->ops->query_server_interfaces(xid, tcon, false);
 	free_xid(xid);
 
 	if (rc) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6ee22d0dbc006..2ed456948f34c 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5290,6 +5290,7 @@ struct smb_version_operations smb30_operations = {
 	.tree_connect = SMB2_tcon,
 	.tree_disconnect = SMB2_tdis,
 	.qfs_tcon = smb3_qfs_tcon,
+	.query_server_interfaces = SMB3_request_interfaces,
 	.is_path_accessible = smb2_is_path_accessible,
 	.can_echo = smb2_can_echo,
 	.echo = SMB2_echo,
@@ -5405,6 +5406,7 @@ struct smb_version_operations smb311_operations = {
 	.tree_connect = SMB2_tcon,
 	.tree_disconnect = SMB2_tdis,
 	.qfs_tcon = smb3_qfs_tcon,
+	.query_server_interfaces = SMB3_request_interfaces,
 	.is_path_accessible = smb2_is_path_accessible,
 	.can_echo = smb2_can_echo,
 	.echo = SMB2_echo,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e5e6b14f8cae3..3ea688558e6c9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -409,14 +409,15 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	spin_unlock(&ses->ses_lock);
 
 	if (!rc &&
-	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
+	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL) &&
+	    server->ops->query_server_interfaces) {
 		mutex_unlock(&ses->session_mutex);
 
 		/*
 		 * query server network interfaces, in case they change
 		 */
 		xid = get_xid();
-		rc = SMB3_request_interfaces(xid, tcon, false);
+		rc = server->ops->query_server_interfaces(xid, tcon, false);
 		free_xid(xid);
 
 		if (rc == -EOPNOTSUPP && ses->chan_count > 1) {
-- 
2.43.0





