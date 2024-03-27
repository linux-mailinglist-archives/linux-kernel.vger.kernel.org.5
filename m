Return-Path: <linux-kernel+bounces-121104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C796588E263
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8066929E902
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E51703CB;
	Wed, 27 Mar 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFQArmJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECF1703B8;
	Wed, 27 Mar 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542089; cv=none; b=SuwCj0qoamlZTJu0sltA8SA64icua+v2U9CLvnQz7I+BQJ38Qg9o8q9bn0JYFfbtNsubkU64B1VZxpWAvxrfVeEX1t4Y1CXg4lHrPe9fZiL2/pj8aLSLMUFXE4PBhiD3PG2u7s1JpFk1/G4V+SX0hHpvjXWrkMFw8vCPXkU+Djw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542089; c=relaxed/simple;
	bh=YK+TQNa3VCnUkbWzMWbaq6Ub2njQY4w4Tm60kop3Yrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOb43pdVp4x1A7BS4HPbDtRGMVMamTPPUcSeEbGRPJNGECWpxpZRVEooZi9iLw1RJfOwPtqgVZZx+mhgHzBInbp5Z69Ijf9AXHd7Sk2GLY61ObG0c/WdfUZq+HPsRzWHaZN9siM0sk+6xHmvjxWZDOEF3Sc6R2UqopiuiudmmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFQArmJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D19C433F1;
	Wed, 27 Mar 2024 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542089;
	bh=YK+TQNa3VCnUkbWzMWbaq6Ub2njQY4w4Tm60kop3Yrc=;
	h=From:To:Cc:Subject:Date:From;
	b=fFQArmJ20n5y8etum66PoJxx/+Hb23Gl+gzgCpl2dJXjg5YAwSGPQtWIo6OR2MrXV
	 ShD1LHyo40qeCcPdbaVcr3aR4RFSFMGF9353faU/cra9jJ+L0o+rs/7IUI/H/YnK1N
	 f5q2Xuga4/CXAZojE2M5yaYZOK0WVaVuEDzNBJaGfKS1/E0mnh07uIPtjSBssj5Q2s
	 xh8Ierfr2tT91xbh0IIUNbIEdewk2fz28W6H4ZuUfmHHNrnChqEnF0NTgXtz+7Vtp5
	 m0mdXirxk+ynOVKsUv8oiP4e+vulmGaZhIbXr7rW/djENC30a06C6/N4EAbMq2VxMa
	 Uf0Uf+fLxx+yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ekorenevsky@astralinux.ru
Cc: Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: open_cached_dir(): add FILE_READ_EA to desired access" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:27 -0400
Message-ID: <20240327122128.2836869-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





