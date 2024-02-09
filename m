Return-Path: <linux-kernel+bounces-59347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A584F5AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CAF287DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57F3838B;
	Fri,  9 Feb 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXcj3iuY"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5037716;
	Fri,  9 Feb 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484605; cv=none; b=aA6iiyr1cKDRQV7S2dfGLjSoehCjQeVIFglN/MrJZXaejmNO9DFBkHL7FH1TpxLg0tSF8f9r37HR2eOvWNHlEUr1hdtVvWOiQa9B7I8M1Zkwz33GF47iVjkN+mBxwy3FtCFu88PEk3zm85u2/PXHTMsZVr0yUxTaFm4p5cUq9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484605; c=relaxed/simple;
	bh=qhOoCQNzPzHiOCmjwCButX1WGPZUV4R16n68RDJmqt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUwOMMaDgyHF6RLW/TmEjElvPkYiMf/r68VBdHxSieRUgw4gJzLcwIdEQHm5fovftTRcXz5GOVMG5YV9EVR4yt6daGGMguOEP/8PEot0gwuHeC3zQkINRNc87+PZb3qRWl3k0tpmXobHRSCHZhWHAGRvpbMCKjntWznMUTqpA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXcj3iuY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so668885a12.1;
        Fri, 09 Feb 2024 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707484603; x=1708089403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDApktuVCr/Bgtqf/JWCLMMqtiZv/VT6n1DxWHxTHaM=;
        b=EXcj3iuYmobodLEoGWEJRxop6W1lZlhGPW69eWIGPFlBqLx3UD9HQlphKSgDCr7juo
         x5LdcgcIzYdxIHsGq7zrZUxn4/F6LVhUdx84MhsBz7iMbAfWmskX9JsuxyAD/AFxMxiJ
         dGo0bsCGKF0rQ3YpkTNKmv6xlbiH9222qnrbam13pK4oqlr0BYNmjqtMTituFhMYnWF4
         QX8cxc1kxtQDDGo3t5GESdx6Whs7vH4HWamzYcdD2EEMvPs3F1NDQ+nhNZIXlMJSiA8Z
         KMMTMZsW1cJprm2Zm8P2keXKBbNWWHFookYsR5a8JkiUbJ8MM1YKkYqWxNwiIv5SdZLD
         sTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484603; x=1708089403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDApktuVCr/Bgtqf/JWCLMMqtiZv/VT6n1DxWHxTHaM=;
        b=R2uZUYXX6WGT8VZfy2qzg0SmmgmvYUH64iYPGD5NQ4Rej730U2koEVhFz55dg/MYZG
         Q/5o4mshWi5bEfNdPM1O8BDa3bPmv0x4OC6evwaSR3alXakeX6NDHz1IUwemvKvyHsDS
         9/MAfrkMV7pQz161RJSTBIG2bT9xY18t2krW7uA8WwYRpZU8q3H8M1APgOFP78J9ssto
         uUMauxlNoXu1yNSC9jyZEs6OomepPnejS7tQSdLXHI4kKWVWZnzTFISwBO7IokRfXa4C
         kAA6KcXodMroIK2ujSy4oa0ANWZlQfEQK6VFBukVPyz51FE3byxAnAU3K0oA1yF0G3YH
         dF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6MwGJwnCmqZmj+C71R+HydxVVdI+4BARwgwo3EK31J3H/xe1/0MlcjYdMmVEP+e1bI3kCV6WwsDESE8zIFGQYMW2FhtupADGFjekeg6WPeibcfBxJ8qvGxJIFvuibBQkv/An25wDaXw==
X-Gm-Message-State: AOJu0YzZkEVM+fRGeJYBtN+4cNrRWQdWjwct7f/65NBFfI6skiOytoQH
	6p2bnKaZ8gtnzVVwmxSjVEeRIex269MeJF8ObAeSh3aLNVZRISjq
X-Google-Smtp-Source: AGHT+IEZLYzCsuhSVIJKYHrwwq5iW4GGVezk9GHauRqFhNs1rHp3ewhEGWqubc6GldWG2dBqM8bZvg==
X-Received: by 2002:a17:90b:1d82:b0:296:a13c:8f84 with SMTP id pf2-20020a17090b1d8200b00296a13c8f84mr1250435pjb.33.1707484603168;
        Fri, 09 Feb 2024 05:16:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxM2ydgQESyUHQ+CSJwn5oQ8r7qDl74zOftXmtLBlNQ+huAHMs9px8efhFI8gYBX0NVOgBOlbfX0ZRixgzl1fxUnivF3AJh9iRrXsAfBBWkoxu5GM4eiZc5QXtm3XGS91WRGXnL4ezWAeJKBlcVRGi3CJad63sx/FOe2eWFejn5WHM0u7embCcXxuJifoOQSSxu9jsNYklfc/g1136ZI8tNNI+pgfllFZQ+vgcn8AUS3IVGThilkYs1eAjhG/KHvfXrjOULVjhM6rRK1Xi95yG6+klcNrxbE9KPH+WmXvuKRCYB1W4ZbkoewX/JEy9i1RiwF9ol1XYZ8h03mC5G9p2TrsHlysRbdJu2EGAyA==
Received: from met-Virtual-Machine.. ([131.107.1.159])
        by smtp.gmail.com with ESMTPSA id sk12-20020a17090b2dcc00b00296540086a5sm1713246pjb.23.2024.02.09.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:16:42 -0800 (PST)
From: meetakshisetiyaoss@gmail.com
To: sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	nspmangalore@gmail.com,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	samba-technical@lists.samba.org,
	bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Subject: [PATCH 3/3] smb: client: retry compound request without reusing lease
Date: Fri,  9 Feb 2024 08:15:52 -0500
Message-Id: <20240209131552.471765-3-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

There is a shortcoming in the current implementation of the file
lease mechanism exposed when the lease keys were attempted to be
reused for unlink, rename and set_path_size operations for a client. As
per MS-SMB2, lease keys are associated with the file name. Linux smb
client maintains lease keys with the inode. If the file has any hardlinks,
it is possible that the lease for a file be wrongly reused for an
operation on the hardlink or vice versa. In these cases, the mentioned
compound operations fail with STATUS_INVALID_PARAMETER.
This patch adds a fallback to the old mechanism of not sending any
lease with these compound operations if the request with lease key fails
with STATUS_INVALID_PARAMETER.
Resending the same request without lease key should not hurt any
functionality, but might impact performance especially in cases where
the error is not because of the usage of wrong lease key and we might
end up doing an extra roundtrip.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/smb/client/smb2inode.c | 41 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 69f3442c5b96..c0d099a9e1ee 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -154,6 +154,17 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	/* if there is an existing lease, reuse it */
+
+	/*
+	 * note: files with hardlinks cause unexpected behaviour. As per MS-SMB2,
+	 * lease keys are associated with the filepath. We are maintaining lease keys
+	 * with the inode on the client. If the file has hardlinks, it is possible
+	 * that the lease for a file be reused for an operation on its hardlink or
+	 * vice versa.
+	 * As a workaround, send request using an existing lease key and if the server
+	 * returns STATUS_INVALID_PARAMETER, which maps to EINVAL, send the request
+	 * again without the lease.
+	 */
 	if (dentry) {
 		inode = d_inode(dentry);
 		if (CIFS_I(inode)->lease_granted && server->ops->get_lease_key) {
@@ -867,11 +878,20 @@ int
 smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	    struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
-	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
+	int rc = smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
 				ACL_NO_MODE, NULL,
 				&(int){SMB2_OP_DELETE}, 1,
 				NULL, NULL, NULL, dentry);
+	if (rc == -EINVAL) {
+		cifs_dbg(FYI, "invalid lease key, resending request without lease");
+		rc = smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
+				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
+				ACL_NO_MODE, NULL,
+				&(int){SMB2_OP_DELETE}, 1,
+				NULL, NULL, NULL, NULL);
+	}
+	return rc;
 }
 
 static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
@@ -912,8 +932,14 @@ int smb2_rename_path(const unsigned int xid,
 	drop_cached_dir_by_name(xid, tcon, from_name, cifs_sb);
 	cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile);
 
-	return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
+	int rc = smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
 				  co, DELETE, SMB2_OP_RENAME, cfile, source_dentry);
+	if (rc == -EINVAL) {
+		cifs_dbg(FYI, "invalid lease key, resending request without lease");
+		rc = smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
+				  co, DELETE, SMB2_OP_RENAME, cfile, NULL);
+	}
+	return rc;
 }
 
 int smb2_create_hardlink(const unsigned int xid,
@@ -942,11 +968,20 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 	in_iov.iov_base = &eof;
 	in_iov.iov_len = sizeof(eof);
 	cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
-	return smb2_compound_op(xid, tcon, cifs_sb, full_path,
+	int rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				FILE_WRITE_DATA, FILE_OPEN,
 				0, ACL_NO_MODE, &in_iov,
 				&(int){SMB2_OP_SET_EOF}, 1,
 				cfile, NULL, NULL, dentry);
+	if (rc == -EINVAL) {
+		cifs_dbg(FYI, "invalid lease key, resending request without lease");
+		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
+				FILE_WRITE_DATA, FILE_OPEN,
+				0, ACL_NO_MODE, &in_iov,
+				&(int){SMB2_OP_SET_EOF}, 1,
+				cfile, NULL, NULL, NULL);
+	}
+	return rc;
 }
 
 int
-- 
2.39.2


