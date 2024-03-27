Return-Path: <linux-kernel+bounces-121254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3588E466
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DD329C35C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA451B04BC;
	Wed, 27 Mar 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S50GLx+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7D1422DE;
	Wed, 27 Mar 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542469; cv=none; b=pdMg9WZKl19OEU1ZR2ifxiocblCn33gAUA0PKx5+whTN77Mm3tRAoBIO6/hGkfSk9MZP8CW6TsI63CwzZCPtvN55kGnjZyTurhmUkqugyc0iwsHftMbDuiDjW0TYAnf6PEstjwBlboSvS7dHwW6wIkvEMg9Rx2urmjliAKCXvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542469; c=relaxed/simple;
	bh=GuThiu88jslfOpu4M5qOFs7lY97oECR5vktwUGjQj1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyri6sAM+WnYupYqhWsSpXHst6JGy/cLuJIG18t38eyAuy/bgY9KXFCvfLu72E1RGgAj7/abm4wHx4WUGcp3N40FpEsL61mLqvb+FcytFPIlpSErfP1nh0akaH3Ihej7zVNXVcn7Yb1WBxyoSJtpWRUkoFaEbMKnGbaYTAK33Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S50GLx+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44587C433F1;
	Wed, 27 Mar 2024 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542469;
	bh=GuThiu88jslfOpu4M5qOFs7lY97oECR5vktwUGjQj1c=;
	h=From:To:Cc:Subject:Date:From;
	b=S50GLx+OTGXKLfCMC8kuRBMiIIesFsOHWcHdDUtM1prXFRoNEwxn1rD6OKlenFabt
	 IgInOnDU2W/OHa9kFuqwXtoFP54pMZRKkPPxTd03edzeV7JYeAkKj92/kEA8L+7lSU
	 bK5SopYgpcGlNXvmUpTZXqQp3SVkk1vR0xkHoXzcsIVGylNf2HcfaRHWc88EIIjN0f
	 xUndpY86KhMecvYHvRMtjuSl9AizGHdBv4lKCTEoZQyAUNJkdf7kz5I15wc9qaK7NQ
	 2ewEvi9vPzKApNumvHBvmY56IwlSBB3D2sgA8rrfY1touqNc4CvqR8Qs2YzDCucEPu
	 8QHSQnwHY2zuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mmakassikis@freebox.fr
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:47 -0400
Message-ID: <20240327122747.2842216-1-sashal@kernel.org>
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

From 34cd86b6632718b7df3999d96f51e63de41c5e4f Mon Sep 17 00:00:00 2001
From: Marios Makassikis <mmakassikis@freebox.fr>
Date: Thu, 22 Feb 2024 10:58:21 +0100
Subject: [PATCH] ksmbd: retrieve number of blocks using vfs_getattr in
 set_file_allocation_info

Use vfs_getattr() to retrieve stat information, rather than make
assumptions about how a filesystem fills inode structs.

Cc: stable@vger.kernel.org
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f6cc5d2730ffb..199c31c275e5b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5809,15 +5809,21 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 
 	loff_t alloc_blks;
 	struct inode *inode;
+	struct kstat stat;
 	int rc;
 
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
+	rc = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			 AT_STATX_SYNC_AS_STAT);
+	if (rc)
+		return rc;
+
 	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
 	inode = file_inode(fp->filp);
 
-	if (alloc_blks > inode->i_blocks) {
+	if (alloc_blks > stat.blocks) {
 		smb_break_all_levII_oplock(work, fp, 1);
 		rc = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
 				   alloc_blks * 512);
@@ -5825,7 +5831,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 			pr_err("vfs_fallocate is failed : %d\n", rc);
 			return rc;
 		}
-	} else if (alloc_blks < inode->i_blocks) {
+	} else if (alloc_blks < stat.blocks) {
 		loff_t size;
 
 		/*
-- 
2.43.0





