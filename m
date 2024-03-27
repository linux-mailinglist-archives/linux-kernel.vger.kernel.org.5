Return-Path: <linux-kernel+bounces-120954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C42D88E0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935D21C22A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE232152174;
	Wed, 27 Mar 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk5R+f2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB49152166;
	Wed, 27 Mar 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541684; cv=none; b=hdVfLhxcw7wKjXNiTkGd2i1+jAd8RHfeCdKy96S4gJgMyVsN979qrpfbXvMWSRC/aaYGigdUAoYt+LTYFEVMGNTs4ynyAoWVXjI1WfbSSrUKdUXF+cDfHipwDINwkHP9SnEuu56szXjoK1vI5pEsAR+QKOhxMAC2snkt/HqhUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541684; c=relaxed/simple;
	bh=wuTit2sxYCEdnSs212cpa9uLxc70sSmaZGKXufWzt9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYeHogQ+2+d3iyzMjxXpt40E9DyAyDB8+6ofORQ8ZNlqG1qSt8P5OlEkl90P8gI55dqCZ6wg5c5iAJEVlQq+XIoT5FHk9XM2HrgS7n4vvuv1NAM7n6fiEF93iCvjvvLuzO3Rye5bKIjeLAi88umKBvODG0kYNeX0E7oxcvVNtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk5R+f2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F390C433C7;
	Wed, 27 Mar 2024 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541683;
	bh=wuTit2sxYCEdnSs212cpa9uLxc70sSmaZGKXufWzt9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=kk5R+f2Kfx8hy+5oZAKeH5B3+7Dd+uhdAyt2oR0ymUhxU8o+WfOaN8r6cb8zwqL9K
	 jw8SVrtWHXVr5S7klPWM+k04NRjDdUU+rWWoZvO/qH+GuSFd/K8QxoZZzAVxl9S5is
	 rEjGHnQWcKEacmvSs3+ZU8IafFy6coTXkDsaBHvIniupEosj5V83uCzonAGMYsOP49
	 1bJcXYSi96lPsbrsYI30MmhrTqUzP2H0dMqpQ2VIoLGiYSkVzGTK+wUSsvEPnRPhom
	 83HvHL6BzdbPoYPqRpTAFJcNcTCAPKLslwijl5PVTCD7iTsItmdHn9lkyYIhdlW77M
	 BmfRzJgCQxM4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ekorenevsky@astralinux.ru
Cc: Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: open_cached_dir(): add FILE_READ_EA to desired access" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:14:41 -0400
Message-ID: <20240327121442.2831301-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f1b8224b4e6ed59e7e6f5c548673c67410098d8d Mon Sep 17 00:00:00 2001
From: Eugene Korenevsky <ekorenevsky@astralinux.ru>
Date: Fri, 1 Mar 2024 17:53:44 +0300
Subject: [PATCH] cifs: open_cached_dir(): add FILE_READ_EA to desired access

Since smb2_query_eas() reads EA and uses cached directory,
open_cached_dir() should request FILE_READ_EA access.

Otherwise listxattr() and getxattr() will fail with EACCES
(0xc0000022 STATUS_ACCESS_DENIED SMB status).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218543
Cc: stable@vger.kernel.org
Signed-off-by: Eugene Korenevsky <ekorenevsky@astralinux.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/cached_dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 3de5047a7ff98..a0017724d5239 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -239,7 +239,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		.tcon = tcon,
 		.path = path,
 		.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE),
-		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES,
+		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES |
+				   FILE_READ_EA,
 		.disposition = FILE_OPEN,
 		.fid = pfid,
 		.replay = !!(retries),
-- 
2.43.0





