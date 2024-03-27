Return-Path: <linux-kernel+bounces-121199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C0C88E3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782EA1F2DF06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17713F439;
	Wed, 27 Mar 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpPFp3jA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7C184108;
	Wed, 27 Mar 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542325; cv=none; b=AK7RA1Aa9t5O46vSRFZMX/wvCK4wGSaR18iRRyhF6CdBZPxQQb+OFstp4aZN1OWS208B1r4+z/F+JMLbWPqbfa43qP5cEjq0gh+RoqBqsFkM5MSJpLbihmxaIf5HwZb2ScRFU1k3Fmqrqt39x/VAZPfhmTLUTzKm44xOOcmAzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542325; c=relaxed/simple;
	bh=mJZYKMtrrTuEV8WhZd4pepdH5Oqrz6U/ELgMWFf3jmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UY7wAxIlzzGXDEqPvL3zTNWZ2PMVDqdr8z+x5y6IJKi9beQ4Z60XLEYLiAZBmcvsALQfZKGf17eXsZklO1rWtD8eIE2y785bdYdrWgI+FIIGysBmrLA9nlgI5/gxRss+XwIBNBMLYPzwqAUrRMLkbhgzkYG6lXCFd1At/5ypKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpPFp3jA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87147C433C7;
	Wed, 27 Mar 2024 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542325;
	bh=mJZYKMtrrTuEV8WhZd4pepdH5Oqrz6U/ELgMWFf3jmg=;
	h=From:To:Cc:Subject:Date:From;
	b=RpPFp3jAh5Min6xIfkQvs+2WPzaIuibR7WVmd4gn/SLz9Z3yYj9/Ii1VTxOTUJ95F
	 nJiBp6+da4E4B8VGuvB7wipyEK2iHaW9ZFl2IeKZx20guKyn0v3KhrcPVhtE58zo9m
	 dsO/oMeM4H4d1p072WceRh4qTzvUeFjVa7KWDJjgsqRP+VQ9ZLfn9DrhRPWv78YZkL
	 +Wwb5XZgNG+bdxrrHN23JEeJPVGarf2iGH5luiVu5VnqcsU7gPwMBuu1+HEsF6uEg7
	 W+r2RitbZiZB7nh64TjDzedhvLY4VQl2Bd46nSAQFhsEo2BBA6tvFGN7FujCa/Bd6o
	 dXuOFYMtCeLRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ekorenevsky@astralinux.ru
Cc: Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: open_cached_dir(): add FILE_READ_EA to desired access" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:23 -0400
Message-ID: <20240327122523.2840193-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





