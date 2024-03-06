Return-Path: <linux-kernel+bounces-93291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B17872D97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D983C1C21E75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A614A98;
	Wed,  6 Mar 2024 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNpE05pp"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45302173;
	Wed,  6 Mar 2024 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696641; cv=none; b=oKJmNoua5BvCfFixxY6pAS6VxIS2BBaorqWfk1pB9obkf0UCsHxyh3vQhOZt+xQTyzhlCnFUp3nfq8eKr4UimEeeWyN5o8CLrcuagzryMQoELYvgNzFRsUoJlKCuA0ndAi16Zwy17PXP25eCLQPzeAj04M6/JbPFj1qbS90bFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696641; c=relaxed/simple;
	bh=rREKfGyeLsi7U8KWXmPSj4cPErDPLaYLM31aROKAF+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VbHnZ9WA/dLDAVC2jXO5zrvF0buZADfQDPxZtxroJz1Wyi/AJfBOm7CTX7zQPZCPIndxtk0Adaw8QUrUG2K4o6v7xQQuSzjOpCPkrc86oS+nMjUX1qAUPlXggdy9U/N6jfEy6vgnedZ6PzvERn1l2Nk4iHpdyd8/6UT279/twnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNpE05pp; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1e992f069so192744b6e.3;
        Tue, 05 Mar 2024 19:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696638; x=1710301438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow0Cmf62S6CGs5TLbMKI23uaJJvz87r8Z80q04Fa77M=;
        b=mNpE05ppIJKL6K8OBrxbPogTbYlN8DMSt7wBH/YVxvAMePJP62O7rec4VedCYsh18O
         iGJprhjTPtrXHx8DPvQGHO9WDCNz4wazIWvGauA8rtBrTOWOWckLwVm5ATKNFKCya9qP
         AfbwO5+S6Oj1xwDfkdh7gfo2rMVADXDV2mKFVCpq+dJe3yZEyV3vRpJzTQN+cxFZR1Hs
         bcUV+4NHKvksa4z3RKgJXWp/PjSkRHOcrLQwS85efc89/Z0uLV9tmQCywJlvhDk7mEEH
         274yasmNeqYqHuhcRlQVUCGtK8Cxk4FZOeVNgh5Q4uXlgCARbhrmQVLAV6/7NJL9Ysfv
         7g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696638; x=1710301438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow0Cmf62S6CGs5TLbMKI23uaJJvz87r8Z80q04Fa77M=;
        b=YrDmHV7wzk/qZzfztY6aJ+0v4alDvZRqH9xxvXbxn5qo3DnRiJy/y7zpgCwAibT4kW
         LhAbRQTesmrlapIwO/ZkBChiJ1Bakh1bJZ9ZAlYUmQYo1FCuD/brz25iAvu6Q2OUtPYG
         iIIwQjYYo7D8RUvB1kzoYBGFp34mAHjrvyCt1wCD69xCyPfDgkied00FAUhUgpeKkck9
         d3YpRhJNVcNdz8fHG6CczGdcsoaQsUs5oDidWg7v0p6PkidfY8qay56JOJunuZ7ClTit
         ZTx0i6OJU4HMH2lXzlx0ZbIrYfygkXrYPRvCrL6wGGglWgwFFM2u1AfynS+rWOful8uz
         jSVA==
X-Forwarded-Encrypted: i=1; AJvYcCUBA+K9ohOmzKJwcKeBUwe/Dco/WuHKuqy2uyayLz179xSvBh3AanWEQ0LGHUwOgxQ0zW5ZIBPDB1y8a8YjCih/UJ+8olX9eNsnu3rby0X8Rus7eQ7c1Gasjpsb1qoqNy2MD0ZL3Te/rQ==
X-Gm-Message-State: AOJu0YzfOtJHGUNOMa7bicfKkKEV4R5Q7geZzwnfd33699Ll+P2wRVlD
	hFjovCLYF4xZJfpGjue8FInJmNoasRC+bJAkuzI5vWIEGeTJqTdERWVWNDC2nNs=
X-Google-Smtp-Source: AGHT+IE3umW5vIsnWK9VAzOkRzZs+Z2PMvGU29XhXNO3Q6p++HuaumPjxCKTo0KRArVGTCsmgM9Kkg==
X-Received: by 2002:aca:f1a:0:b0:3c1:f531:7e9b with SMTP id 26-20020aca0f1a000000b003c1f5317e9bmr3222149oip.27.1709696638281;
        Tue, 05 Mar 2024 19:43:58 -0800 (PST)
Received: from met-Virtual-Machine.. ([131.107.159.31])
        by smtp.gmail.com with ESMTPSA id j5-20020a654305000000b005db034d1514sm8639808pgq.82.2024.03.05.19.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:43:57 -0800 (PST)
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
Subject: [PATCH 1/3] smb: client: reuse file lease key in compound operations
Date: Tue,  5 Mar 2024 22:43:51 -0500
Message-Id: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

Currently, when a rename, unlink or set path size compound operation
is requested on a file that has a lot of dirty pages to be written
to the server, we do not send the lease key for these requests. As a
result, the server can assume that this request is from a new client, and
send a lease break notification to the same client, on the same
connection. As a response to the lease break, the client can consume
several credits to write the dirty pages to the server. Depending on the
server's credit grant implementation, the server can stop granting more
credits to this connection, and this can cause a deadlock (which can only
be resolved when the lease timer on the server expires).
One of the problems here is that the client is sending no lease key,
even if it has a lease for the file. This patch fixes the problem by
reusing the existing lease key on the file for rename, unlink and set path
size compound operations so that the client does not break its own lease.

A very trivial example could be a set of commands by a client that
maintains open handle (for write) to a file and then tries to copy the
contents of that file to another one, eg.,

tail -f /dev/null > myfile &
mv myfile myfile2

Presently, the network capture on the client shows that the move (or
rename) would trigger a lease break on the same client, for the same file.
With the lease key reused, the lease break request-response overhead is
eliminated, thereby reducing the roundtrips performed for this set of
operations.

The patch fixes the bug described above and also provides perf benefit.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/smb/client/cifsglob.h  |  5 ++--
 fs/smb/client/cifsproto.h |  6 +++--
 fs/smb/client/cifssmb.c   |  4 ++--
 fs/smb/client/inode.c     | 10 ++++----
 fs/smb/client/smb2inode.c | 48 ++++++++++++++++++++++++---------------
 fs/smb/client/smb2proto.h |  6 +++--
 6 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 16befff4cbb4..50f7e47c2229 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -371,7 +371,8 @@ struct smb_version_operations {
 			    struct cifs_open_info_data *data);
 	/* set size by path */
 	int (*set_path_size)(const unsigned int, struct cifs_tcon *,
-			     const char *, __u64, struct cifs_sb_info *, bool);
+			     const char *, __u64, struct cifs_sb_info *, bool,
+				 struct dentry *);
 	/* set size by file handle */
 	int (*set_file_size)(const unsigned int, struct cifs_tcon *,
 			     struct cifsFileInfo *, __u64, bool);
@@ -401,7 +402,7 @@ struct smb_version_operations {
 		     struct cifs_sb_info *);
 	/* unlink file */
 	int (*unlink)(const unsigned int, struct cifs_tcon *, const char *,
-		      struct cifs_sb_info *);
+		      struct cifs_sb_info *, struct dentry *);
 	/* open, rename and delete file */
 	int (*rename_pending_delete)(const char *, struct dentry *,
 				     const unsigned int);
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a841bf4967fa..ef98c840791f 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -402,7 +402,8 @@ extern int CIFSSMBSetFileDisposition(const unsigned int xid,
 				     __u32 pid_of_opener);
 extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 			 const char *file_name, __u64 size,
-			 struct cifs_sb_info *cifs_sb, bool set_allocation);
+			 struct cifs_sb_info *cifs_sb, bool set_allocation,
+			 struct dentry *dentry);
 extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 			      struct cifsFileInfo *cfile, __u64 size,
 			      bool set_allocation);
@@ -438,7 +439,8 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 			const struct nls_table *nls_codepage,
 			int remap_special_chars);
 extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-			  const char *name, struct cifs_sb_info *cifs_sb);
+			  const char *name, struct cifs_sb_info *cifs_sb,
+			  struct dentry *dentry);
 int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
 		  struct dentry *source_dentry,
 		  const char *from_name, const char *to_name,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01e89070df5a..301189ee1335 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -738,7 +738,7 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 
 int
 CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
-	       struct cifs_sb_info *cifs_sb)
+	       struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
 	DELETE_FILE_REQ *pSMB = NULL;
 	DELETE_FILE_RSP *pSMBr = NULL;
@@ -4993,7 +4993,7 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
 int
 CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 	      const char *file_name, __u64 size, struct cifs_sb_info *cifs_sb,
-	      bool set_allocation)
+	      bool set_allocation, struct dentry *dentry)
 {
 	struct smb_com_transaction2_spi_req *pSMB = NULL;
 	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d02f8ba29cb5..3073eac989ea 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1846,7 +1846,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 		goto psx_del_no_retry;
 	}
 
-	rc = server->ops->unlink(xid, tcon, full_path, cifs_sb);
+	rc = server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry);
 
 psx_del_no_retry:
 	if (!rc) {
@@ -2797,7 +2797,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 
 static int
 cifs_set_file_size(struct inode *inode, struct iattr *attrs,
-		   unsigned int xid, const char *full_path)
+		   unsigned int xid, const char *full_path, struct dentry *dentry)
 {
 	int rc;
 	struct cifsFileInfo *open_file;
@@ -2848,7 +2848,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 	 */
 	if (server->ops->set_path_size)
 		rc = server->ops->set_path_size(xid, tcon, full_path,
-						attrs->ia_size, cifs_sb, false);
+						attrs->ia_size, cifs_sb, false, dentry);
 	else
 		rc = -ENOSYS;
 	cifs_dbg(FYI, "SetEOF by path (setattrs) rc = %d\n", rc);
@@ -2938,7 +2938,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	rc = 0;
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		rc = cifs_set_file_size(inode, attrs, xid, full_path);
+		rc = cifs_set_file_size(inode, attrs, xid, full_path, direntry);
 		if (rc != 0)
 			goto out;
 	}
@@ -3105,7 +3105,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		rc = cifs_set_file_size(inode, attrs, xid, full_path);
+		rc = cifs_set_file_size(inode, attrs, xid, full_path, direntry);
 		if (rc != 0)
 			goto cifs_setattr_exit;
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 05818cd6d932..69f3442c5b96 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -98,7 +98,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    __u32 desired_access, __u32 create_disposition,
 			    __u32 create_options, umode_t mode, struct kvec *in_iov,
 			    int *cmds, int num_cmds, struct cifsFileInfo *cfile,
-			    struct kvec *out_iov, int *out_buftype)
+			    struct kvec *out_iov, int *out_buftype, struct dentry *dentry)
 {
 
 	struct reparse_data_buffer *rbuf;
@@ -115,6 +115,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	int resp_buftype[MAX_COMPOUND];
 	struct smb2_query_info_rsp *qi_rsp = NULL;
 	struct cifs_open_info_data *idata;
+	struct inode *inode = NULL;
 	int flags = 0;
 	__u8 delete_pending[8] = {1, 0, 0, 0, 0, 0, 0, 0};
 	unsigned int size[2];
@@ -152,6 +153,15 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		goto finished;
 	}
 
+	/* if there is an existing lease, reuse it */
+	if (dentry) {
+		inode = d_inode(dentry);
+		if (CIFS_I(inode)->lease_granted && server->ops->get_lease_key) {
+			oplock = SMB2_OPLOCK_LEVEL_LEASE;
+			server->ops->get_lease_key(inode, &fid);
+		}
+	}
+
 	vars->oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.path = full_path,
@@ -747,7 +757,7 @@ int smb2_query_path_info(const unsigned int xid,
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
 			      create_options, ACL_NO_MODE, in_iov,
-			      cmds, 1, cfile, out_iov, out_buftype);
+			      cmds, 1, cfile, out_iov, out_buftype, NULL);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -779,7 +789,7 @@ int smb2_query_path_info(const unsigned int xid,
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
 				      create_options, ACL_NO_MODE, in_iov,
-				      cmds, num_cmds, cfile, NULL, NULL);
+				      cmds, num_cmds, cfile, NULL, NULL, NULL);
 		break;
 	case -EREMOTE:
 		break;
@@ -811,7 +821,7 @@ smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
 				FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				CREATE_NOT_FILE, mode,
 				NULL, &(int){SMB2_OP_MKDIR}, 1,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 void
@@ -836,7 +846,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				 CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
 				 &(int){SMB2_OP_SET_INFO}, 1,
-				 cfile, NULL, NULL);
+				 cfile, NULL, NULL, NULL);
 	if (tmprc == 0)
 		cifs_i->cifsAttrs = dosattrs;
 }
@@ -850,25 +860,26 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 				DELETE, FILE_OPEN, CREATE_NOT_FILE,
 				ACL_NO_MODE, NULL,
 				&(int){SMB2_OP_RMDIR}, 1,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 int
 smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
-	    struct cifs_sb_info *cifs_sb)
+	    struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
 				ACL_NO_MODE, NULL,
 				&(int){SMB2_OP_DELETE}, 1,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, dentry);
 }
 
 static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 			      const char *from_name, const char *to_name,
 			      struct cifs_sb_info *cifs_sb,
 			      __u32 create_options, __u32 access,
-			      int command, struct cifsFileInfo *cfile)
+			      int command, struct cifsFileInfo *cfile,
+				  struct dentry *dentry)
 {
 	struct kvec in_iov;
 	__le16 *smb2_to_name = NULL;
@@ -883,7 +894,7 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	in_iov.iov_len = 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_MAX);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
 			      FILE_OPEN, create_options, ACL_NO_MODE,
-			      &in_iov, &command, 1, cfile, NULL, NULL);
+			      &in_iov, &command, 1, cfile, NULL, NULL, dentry);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
@@ -902,7 +913,7 @@ int smb2_rename_path(const unsigned int xid,
 	cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile);
 
 	return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
-				  co, DELETE, SMB2_OP_RENAME, cfile);
+				  co, DELETE, SMB2_OP_RENAME, cfile, source_dentry);
 }
 
 int smb2_create_hardlink(const unsigned int xid,
@@ -915,13 +926,14 @@ int smb2_create_hardlink(const unsigned int xid,
 
 	return smb2_set_path_attr(xid, tcon, from_name, to_name,
 				  cifs_sb, co, FILE_READ_ATTRIBUTES,
-				  SMB2_OP_HARDLINK, NULL);
+				  SMB2_OP_HARDLINK, NULL, NULL);
 }
 
 int
 smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 		   const char *full_path, __u64 size,
-		   struct cifs_sb_info *cifs_sb, bool set_alloc)
+		   struct cifs_sb_info *cifs_sb, bool set_alloc,
+		   struct dentry *dentry)
 {
 	struct cifsFileInfo *cfile;
 	struct kvec in_iov;
@@ -934,7 +946,7 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 				FILE_WRITE_DATA, FILE_OPEN,
 				0, ACL_NO_MODE, &in_iov,
 				&(int){SMB2_OP_SET_EOF}, 1,
-				cfile, NULL, NULL);
+				cfile, NULL, NULL, dentry);
 }
 
 int
@@ -963,7 +975,7 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN,
 			      0, ACL_NO_MODE, &in_iov,
 			      &(int){SMB2_OP_SET_INFO}, 1,
-			      cfile, NULL, NULL);
+			      cfile, NULL, NULL, NULL);
 	cifs_put_tlink(tlink);
 	return rc;
 }
@@ -998,7 +1010,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL, NULL);
 		if (!rc) {
 			rc = smb311_posix_get_inode_info(&new, full_path,
 							 data, sb, xid);
@@ -1008,7 +1020,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL, NULL);
 		if (!rc) {
 			rc = cifs_get_inode_info(&new, full_path,
 						 data, sb, xid, NULL);
@@ -1036,7 +1048,7 @@ int smb2_query_reparse_point(const unsigned int xid,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
 			      OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
 			      &(int){SMB2_OP_GET_REPARSE}, 1,
-			      cfile, NULL, NULL);
+			      cfile, NULL, NULL, NULL);
 	if (rc)
 		goto out;
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index b3069911e9dd..221143788a1c 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -75,7 +75,8 @@ int smb2_query_path_info(const unsigned int xid,
 			 struct cifs_open_info_data *data);
 extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 			      const char *full_path, __u64 size,
-			      struct cifs_sb_info *cifs_sb, bool set_alloc);
+			      struct cifs_sb_info *cifs_sb, bool set_alloc,
+				  struct dentry *dentry);
 extern int smb2_set_file_info(struct inode *inode, const char *full_path,
 			      FILE_BASIC_INFO *buf, const unsigned int xid);
 extern int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
@@ -91,7 +92,8 @@ extern void smb2_mkdir_setinfo(struct inode *inode, const char *full_path,
 extern int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon,
 		      const char *name, struct cifs_sb_info *cifs_sb);
 extern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
-		       const char *name, struct cifs_sb_info *cifs_sb);
+		       const char *name, struct cifs_sb_info *cifs_sb,
+			   struct dentry *dentry);
 int smb2_rename_path(const unsigned int xid,
 		     struct cifs_tcon *tcon,
 		     struct dentry *source_dentry,
-- 
2.39.2


