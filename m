Return-Path: <linux-kernel+bounces-121029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBFB88E1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0535D1F2182E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E9315AD99;
	Wed, 27 Mar 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv+GDRSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4015B0F1;
	Wed, 27 Mar 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541885; cv=none; b=biO7KaW5Z88iQduynRWXyraFxE6GZH6uVV7Wc3EDFzJ2YwSJd4xdNLlEjwSOCTs6EL0W7yqO21UBVyzUb/JineJSBJtIF7ixRygdEt0KTz/irNyL9gFuC1kBNdUruPynXpk2d6oW88UL6v85XjI9DwB5L0aMWvD/L3PL70UZ+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541885; c=relaxed/simple;
	bh=yVJlr6IIVy2A+HoDXn3iOpcjwINm8BC2DgjVpBCtXVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Plr8+hEt6aHgBdWBinf/GRjayXLLy/osFH73z1ScyFhilOWI8mj/DNC2ri9e6YSw/elAefZJ3QtCbA12htmA65yGhQpU9YfEtcA4c5gGFJpW3go8fMwJXddJifWS73CfStyrvZfxsQTvrx78EyslkX/AJJDxa3dWMZwIjzFk+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv+GDRSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4CBC433C7;
	Wed, 27 Mar 2024 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541885;
	bh=yVJlr6IIVy2A+HoDXn3iOpcjwINm8BC2DgjVpBCtXVg=;
	h=From:To:Cc:Subject:Date:From;
	b=Nv+GDRSscQImOrFskeqnCrPsLuU8cxKxitCPV7w1HAc+I2WsI4E4U3BJciEsojcfS
	 qMNr02+B/jqKrmL+6TxZG84Mn/L55lcYTixSWQcktLoegDeki/E+1LlbeX5n2hYWve
	 xH/KyKXmeIlNaaIJGEKRQkrfCi3sUeFFe2Y43YuN6QW0Q0dAdWvGZmyJxWo47th/gD
	 CBPIZccxVVArPJvwVMIlF7/m6MHiFE748yZhHvoATqKxI50+CrRhNpwW7nu3yY00L8
	 bpPtf/HiQfUP+5v5dB4LlPrI4g4hhQZg6ux7jj5WoicNrshkkg0dMPIBMDup7Cw2Xe
	 +fBcnOD9I269Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ekorenevsky@astralinux.ru
Cc: Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: open_cached_dir(): add FILE_READ_EA to desired access" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:03 -0400
Message-ID: <20240327121804.2834033-1-sashal@kernel.org>
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





