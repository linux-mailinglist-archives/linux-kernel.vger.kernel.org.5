Return-Path: <linux-kernel+bounces-93293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09B872D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090551C22B85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3718B1B;
	Wed,  6 Mar 2024 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjeWUv6B"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F325179B2;
	Wed,  6 Mar 2024 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696648; cv=none; b=BbB1qztJUg8WY3sQ1QBFV7yBZtg77s4LObX7v1W46BCqSKIP2YRTxI+fQ6uuzAad6x6StlLSNgcAlXTZle/YMnu2gMrDNy13sr5dnoJEkEltc9KDUBMydvvarsNSDmydOFgalxvKhxP/NMpQvKH63w9viX/hWJqyPXRGib/QPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696648; c=relaxed/simple;
	bh=C/jtdEDa4Us6RqtlJJcTg3kI3YdurrJ2pc7QD8o8W9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8bTQaZdSoPj9INAcdPdr3La56m/Ym6fUYuPswbj6GAzbpnd0PVw2hWbdmYXrAHp1luTJxmJa1Au/FrxTGaCTGqKy8lhl+bXDB9cZooBip6VEFlKYv6iBPGUyMpuqYt/2+pe7/+4w9nNP2pcCUT9aY25PvuQjG7DNHc0hgXkutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjeWUv6B; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29aa91e173dso1033777a91.0;
        Tue, 05 Mar 2024 19:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696646; x=1710301446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNFqoOs60d2BJyKt3WPYYQhsfs7ZhiZxWwuBcouXhmU=;
        b=jjeWUv6B7omHsDIKboK7IdS4Ep96dOqrsDEzV22Rw51efBB8Tu2kvLFuE+Ix58OuAZ
         9Uwo+H9C+X//hqLHWP+dbXVQkw6pfTFf7jth+FLDITUES6KXqK8EYApus/NzXRlKS/uF
         bKvNqpQW1DM1+VhfJlSV+obpNRBuyKURXy69nvQBZRZyTLfZaJ1/YaSgtwO1Oo6Vk5Jb
         m9qfr83kI9JCm/2n2S/cOy8ydkcL7+d0DQX7V670NFe+7wdP6r9hBvH+aB5tYFxaF+uO
         nRKbSUiybOIfcaEn+zOCuwKsWt0mm+xivHmrhA3xOD2J0uIJ7b4D4kBTTYjm9Yai0NoF
         vZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696646; x=1710301446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNFqoOs60d2BJyKt3WPYYQhsfs7ZhiZxWwuBcouXhmU=;
        b=dwBsW80i2hxBrB5o+GRzt//RBEZ1DqbY8SXfcMv3lErZmhHzbhWFid+icw0XtOfwU8
         5g8JH4Y11FA/ZyIjEbQfRUYVWZEONygRZSP/xCe/soq6RT++LMOQ69CxwFoGQDKhNsKn
         g1SyX9/Lmf7q6fDaex31k6ZQfrJPIguHBJA4g92x+L92psAm+fh+0obcMEEkf/aBO1qq
         xLwt6uhmaEFlKi6bJDtP8hagIdp+6BSiB//bo7jKb3dUQBPHPibj2lMrmW1I2aEyg9qo
         R/AvuofjtB7ubQ4Dw6bw/IfoqIMYu7/YZ/wL1OO71bG9JB4FAXA+tdcrj0ZjHGsfBemx
         EOig==
X-Forwarded-Encrypted: i=1; AJvYcCV+y481NwfsaXT8/2OZgox8RxKVDzoD/+B1tpyOOKd15tdEy/l/HbsBIrSkieLf4VjN67nPYRbinp9EdD0bqwEH38Om3u4kwx/VrQrnHRDWl99q0xlTdZIa25kEGmQl0qKp9zKNyP4DVg==
X-Gm-Message-State: AOJu0YxKx5r9Ocj6TNxE9zr+/7DVmL8PDZSMew8+QAaJRiZ0sfZK2I9G
	IqjBb0le6E2R9kogEwkWKxQrkezt/opYk9+tzgrLDU/kYZzD+2cb
X-Google-Smtp-Source: AGHT+IEnShgC5axrveTeLqP6fomzKQezN5CS8/lEuoMfRyWYwejQ0SqE1+OXr9WLcHVrkgVqP9SlgQ==
X-Received: by 2002:a17:90a:c7c4:b0:29a:6c13:f0a with SMTP id gf4-20020a17090ac7c400b0029a6c130f0amr11038527pjb.16.1709696645660;
        Tue, 05 Mar 2024 19:44:05 -0800 (PST)
Received: from met-Virtual-Machine.. ([131.107.159.31])
        by smtp.gmail.com with ESMTPSA id j5-20020a654305000000b005db034d1514sm8639808pgq.82.2024.03.05.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:44:05 -0800 (PST)
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
Date: Tue,  5 Mar 2024 22:43:53 -0500
Message-Id: <20240306034353.190039-3-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
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
index 429d83d31280..f697c14cd8c6 100644
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
@@ -874,11 +885,20 @@ int
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
@@ -919,8 +939,14 @@ int smb2_rename_path(const unsigned int xid,
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
@@ -949,11 +975,20 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
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


