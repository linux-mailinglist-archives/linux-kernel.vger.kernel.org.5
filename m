Return-Path: <linux-kernel+bounces-104147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724987C9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2131F21BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DE15E81;
	Fri, 15 Mar 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P01aSKbo"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783014A99;
	Fri, 15 Mar 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490350; cv=none; b=jiokUjpouoo1hNQFjMDKkV5T/v1MEzTGNb9xSPGS5w4twOUDWQAw6XiDXrLwMGzPUnV7VuHI8G8v503JYIDJwsCysQW7afgjIN1zP0vCZR2h+HQQvNlwwMsyvbMENNruk6MLEV+dMdAFPee507qWkDoOYNjx9wtgJwV0Q2ABY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490350; c=relaxed/simple;
	bh=d2Po614jWmI70mnvc/w9zgb2I/bK6oEyGZ/VPVHjWeE=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o24XVX++GLvpDal9McZduInG4XhK7kU/yDz1rWdH/ZlP0YDiYg2FG0XF8uK6MsyogccLnpSnrut1iMpXxHrrTBueNlwoJY9kzqxkRmE12pP8mm64d+B8vpubsroEKgU8i3fv+YrJZzyaLSlcPLa+2spiauo/eBgC/9jxzBBpnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P01aSKbo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789e2bf854dso41809685a.3;
        Fri, 15 Mar 2024 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710490347; x=1711095147; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FT8G2QqYDoocZIhfjdACapItl0ZiuuSfi2pODZo6+74=;
        b=P01aSKboghr3cypd31SYrjWJ9W3syr9PdS3ZK743W9HGr/I+wgpLB/Xpjc5m3c66bW
         bhjwEW2XX4k+VtB4zAPZcQVlRWHvAD2PBWQS6NRLh6/gRBGwkDNlknqr55X7CRrG985M
         vhCqKxwRkiUsOkDY+MZX/fPHJWQwcF/ErXT6sCOpmRlWD6e0OXNhqc9dBvp/Zq1134Om
         1amT3H153OhV0T3nguWnJZfZOxu0jTOJg+0rKjr/IjbSuV/RUD9+CLXCoIIKWoXTJN8f
         P77qCB7md0D/2pvLZF/xW1miZZHADgN533G4XU0KiGM9cpJKmemzdfBUi1qUkXKfoM0A
         46jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490347; x=1711095147;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FT8G2QqYDoocZIhfjdACapItl0ZiuuSfi2pODZo6+74=;
        b=oOudaIcagxgupWXhk1UisKnHA2gIKPUb/gnEV8yJLr3Nc856LZuB4S/Qezg3Lvx4b1
         Rs64KdnfvCkHDN5zKoO3Dw/r0CsMVdgx9pFtNxhvK6Z1/4j3IB+WsaROpMD2/KSWPhX5
         AU28JuZ4zlgnbg5KOw7mF664jI1dTaY74q5vJbW447Y1YdC9qjl2KIfe1CkuV2ILyqfC
         0I8Zu4/z/k3MI/SBQmTg/QkwcB7ANn7rwpHDFilaomjfieNz9Ef/O3I6VE/o171ZgxT9
         siTEhbPIzhs8dP0zf/h4kE+jTixYQQ4y3Gwzpt/X35TehjLDPxUld3A2CRA4CsLo34hM
         T+9g==
X-Forwarded-Encrypted: i=1; AJvYcCUaB3ABhZlySWEgla0V/9qewjwB7fVpTgnTVHWcRsDtMw1r7AO/+Uw0FMEPhS88sUoYIu4payM3GL6LNeOyksVGpxKSPqRXyZPq0oET+pKywJeg74FoRfIVgie95B95nb2EAsypnYxWmg==
X-Gm-Message-State: AOJu0YwJQKaX/7K74Memm2j7Bgv5rzpUfdR+zhRVIqwGDhTLcsYFwXpO
	lGhwC6yjO2jH+zuFhb6D/se+/FOjwfHCKnNKH7M67dqX6ApWRCE6
X-Google-Smtp-Source: AGHT+IErOCiRZVSqymxrukWj9zNLPnl3x6nKn3fhlBWEBAni7jhVxxYEjsZZKNbWX45T9ziMScoq3w==
X-Received: by 2002:a05:620a:31a0:b0:788:45c9:bc53 with SMTP id bi32-20020a05620a31a000b0078845c9bc53mr5369234qkb.15.1710490347295;
        Fri, 15 Mar 2024 01:12:27 -0700 (PDT)
Received: from rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net ([40.71.76.248])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b0078820f053b0sm1311084qkb.109.2024.03.15.01.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:12:26 -0700 (PDT)
From: Ritvik Budhiraja <budhirajaritviksmb@gmail.com>
X-Google-Original-From: Ritvik Budhiraja <rbudhiraja@microsoft.com>
Date: Fri, 15 Mar 2024 08:12:25 +0000
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
	sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	bharathsm.hsk@gmail.com
Cc: rbudhiraja@microsoft.com
Subject: [PATCH] Retrying on failed server close
Message-ID: <ZfQC6Xk+E6HtCtsI@rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In the current implementation, CIFS close sends a close to the server 
and does not check for the success of the server close. This patch adds 
functionality to check for server close return status and retries 
in case of an EBUSY or EAGAIN error

Signed-off-by: Ritvik Budhiraja <rbudhiraja@microsoft.com>
---
 fs/smb/client/cifsfs.c   | 11 +++++++
 fs/smb/client/cifsglob.h |  7 +++--
 fs/smb/client/file.c     | 63 ++++++++++++++++++++++++++++++++++++----
 fs/smb/client/smb1ops.c  |  4 +--
 fs/smb/client/smb2ops.c  |  9 +++---
 5 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index fb368b191eef..e4b2ded86fce 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -160,6 +160,7 @@ struct workqueue_struct	*decrypt_wq;
 struct workqueue_struct	*fileinfo_put_wq;
 struct workqueue_struct	*cifsoplockd_wq;
 struct workqueue_struct	*deferredclose_wq;
+struct workqueue_struct	*serverclose_wq;
 __u32 cifs_lock_secret;
 
 /*
@@ -1890,6 +1891,13 @@ init_cifs(void)
 		goto out_destroy_cifsoplockd_wq;
 	}
 
+	serverclose_wq = alloc_workqueue("serverclose",
+					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	if (!serverclose_wq) {
+		rc = -ENOMEM;
+		goto out_destroy_serverclose_wq;
+	}
+
 	rc = cifs_init_inodecache();
 	if (rc)
 		goto out_destroy_deferredclose_wq;
@@ -1964,6 +1972,8 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
+out_destroy_serverclose_wq:
+	destroy_workqueue(serverclose_wq);
 out_clean_proc:
 	cifs_proc_clean();
 	return rc;
@@ -1993,6 +2003,7 @@ exit_cifs(void)
 	destroy_workqueue(cifsoplockd_wq);
 	destroy_workqueue(decrypt_wq);
 	destroy_workqueue(fileinfo_put_wq);
+	destroy_workqueue(serverclose_wq);
 	destroy_workqueue(cifsiod_wq);
 	cifs_proc_clean();
 }
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 53c75cfb33ab..c99bc3b3ff56 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -429,10 +429,10 @@ struct smb_version_operations {
 	/* set fid protocol-specific info */
 	void (*set_fid)(struct cifsFileInfo *, struct cifs_fid *, __u32);
 	/* close a file */
-	void (*close)(const unsigned int, struct cifs_tcon *,
+	int (*close)(const unsigned int, struct cifs_tcon *,
 		      struct cifs_fid *);
 	/* close a file, returning file attributes and timestamps */
-	void (*close_getattr)(const unsigned int xid, struct cifs_tcon *tcon,
+	int (*close_getattr)(const unsigned int xid, struct cifs_tcon *tcon,
 		      struct cifsFileInfo *pfile_info);
 	/* send a flush request to the server */
 	int (*flush)(const unsigned int, struct cifs_tcon *, struct cifs_fid *);
@@ -1420,6 +1420,7 @@ struct cifsFileInfo {
 	bool invalidHandle:1;	/* file closed via session abend */
 	bool swapfile:1;
 	bool oplock_break_cancelled:1;
+	bool offload:1; /* offload final part of _put to a wq */
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
@@ -1428,6 +1429,7 @@ struct cifsFileInfo {
 	struct cifs_search_info srch_inf;
 	struct work_struct oplock_break; /* work for oplock breaks */
 	struct work_struct put; /* work for the final part of _put */
+	struct work_struct serverclose; /* work for serverclose */
 	struct delayed_work deferred;
 	bool deferred_close_scheduled; /* Flag to indicate close is scheduled */
 	char *symlink_target;
@@ -2085,6 +2087,7 @@ extern struct workqueue_struct *decrypt_wq;
 extern struct workqueue_struct *fileinfo_put_wq;
 extern struct workqueue_struct *cifsoplockd_wq;
 extern struct workqueue_struct *deferredclose_wq;
+extern struct workqueue_struct *serverclose_wq;
 extern __u32 cifs_lock_secret;
 
 extern mempool_t *cifs_mid_poolp;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index c3b8e7091a4d..c1379ec27dcd 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -445,6 +445,7 @@ cifs_down_write(struct rw_semaphore *sem)
 }
 
 static void cifsFileInfo_put_work(struct work_struct *work);
+void serverclose_work(struct work_struct *work);
 
 struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 				       struct tcon_link *tlink, __u32 oplock,
@@ -491,6 +492,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	cfile->tlink = cifs_get_tlink(tlink);
 	INIT_WORK(&cfile->oplock_break, cifs_oplock_break);
 	INIT_WORK(&cfile->put, cifsFileInfo_put_work);
+	INIT_WORK(&cfile->serverclose, serverclose_work);
 	INIT_DELAYED_WORK(&cfile->deferred, smb2_deferred_work_close);
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
@@ -582,6 +584,40 @@ static void cifsFileInfo_put_work(struct work_struct *work)
 	cifsFileInfo_put_final(cifs_file);
 }
 
+void serverclose_work(struct work_struct *work)
+{
+	struct cifsFileInfo *cifs_file = container_of(work,
+			struct cifsFileInfo, serverclose);
+
+	struct cifs_tcon *tcon = tlink_tcon(cifs_file->tlink);
+
+	struct TCP_Server_Info *server = tcon->ses->server;
+	int rc;
+	int retries = 0;
+	int MAX_RETRIES = 4;
+
+	do {
+		if (server->ops->close_getattr)
+			rc = server->ops->close_getattr(0, tcon, cifs_file);
+		else if (server->ops->close)
+			rc = server->ops->close(0, tcon, &cifs_file->fid);
+
+		if (rc == -EBUSY || rc == -EAGAIN) {
+			retries++;
+			msleep(250);
+		}
+	} while ((rc == -EBUSY || rc == -EAGAIN) && (retries < MAX_RETRIES)
+	);
+
+	if (retries == MAX_RETRIES)
+		printk(KERN_WARNING "[CIFS_CLOSE] Serverclose failed %d times, giving up\n", MAX_RETRIES);
+
+	if (cifs_file->offload)
+		queue_work(fileinfo_put_wq, &cifs_file->put);
+	else
+		cifsFileInfo_put_final(cifs_file);
+}
+
 /**
  * cifsFileInfo_put - release a reference of file priv data
  *
@@ -622,10 +658,13 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
 	struct cifs_fid fid = {};
 	struct cifs_pending_open open;
 	bool oplock_break_cancelled;
+	bool serverclose_offloaded = false;
 
 	spin_lock(&tcon->open_file_lock);
 	spin_lock(&cifsi->open_file_lock);
 	spin_lock(&cifs_file->file_info_lock);
+
+	cifs_file->offload = offload;
 	if (--cifs_file->count > 0) {
 		spin_unlock(&cifs_file->file_info_lock);
 		spin_unlock(&cifsi->open_file_lock);
@@ -667,13 +706,20 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
 	if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
 		struct TCP_Server_Info *server = tcon->ses->server;
 		unsigned int xid;
+		int rc;
 
 		xid = get_xid();
 		if (server->ops->close_getattr)
-			server->ops->close_getattr(xid, tcon, cifs_file);
+			rc = server->ops->close_getattr(xid, tcon, cifs_file);
 		else if (server->ops->close)
-			server->ops->close(xid, tcon, &cifs_file->fid);
+			rc = server->ops->close(xid, tcon, &cifs_file->fid);
 		_free_xid(xid);
+
+		if (rc == -EBUSY || rc == -EAGAIN) {
+			// Server close failed, hence offloading it as an async op
+			queue_work(serverclose_wq, &cifs_file->serverclose);
+			serverclose_offloaded = true;
+		}
 	}
 
 	if (oplock_break_cancelled)
@@ -681,10 +727,15 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
 
 	cifs_del_pending_open(&open);
 
-	if (offload)
-		queue_work(fileinfo_put_wq, &cifs_file->put);
-	else
-		cifsFileInfo_put_final(cifs_file);
+	// if serverclose has been offloaded to wq (on failure), it will
+	// handle offloading put as well. If serverclose not offloaded,
+	// we need to handle offloading put here.
+	if (!serverclose_offloaded) {
+		if (offload)
+			queue_work(fileinfo_put_wq, &cifs_file->put);
+		else
+			cifsFileInfo_put_final(cifs_file);
+	}
 }
 
 int cifs_open(struct inode *inode, struct file *file)
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index a9eaba8083b0..212ec6f66ec6 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -753,11 +753,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct cifs_fid *fid, __u32 oplock)
 	cinode->can_cache_brlcks = CIFS_CACHE_WRITE(cinode);
 }
 
-static void
+static int
 cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,
 		struct cifs_fid *fid)
 {
-	CIFSSMBClose(xid, tcon, fid->netfid);
+	return CIFSSMBClose(xid, tcon, fid->netfid);
 }
 
 static int
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4695433fcf39..1dcd4944958f 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1411,14 +1411,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct cifs_fid *fid, __u32 oplock)
 	memcpy(cfile->fid.create_guid, fid->create_guid, 16);
 }
 
-static void
+static int
 smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,
 		struct cifs_fid *fid)
 {
-	SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid);
+	return SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid);
 }
 
-static void
+static int
 smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 		   struct cifsFileInfo *cfile)
 {
@@ -1429,7 +1429,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = __SMB2_close(xid, tcon, cfile->fid.persistent_fid,
 		   cfile->fid.volatile_fid, &file_inf);
 	if (rc)
-		return;
+		return rc;
 
 	inode = d_inode(cfile->dentry);
 
@@ -1458,6 +1458,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* End of file and Attributes should not have to be updated on close */
 	spin_unlock(&inode->i_lock);
+	return rc;
 }
 
 static int
-- 
2.34.1


