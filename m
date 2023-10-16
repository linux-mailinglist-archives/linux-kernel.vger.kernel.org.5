Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890717CB2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjJPSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPSla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:41:30 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFF95;
        Mon, 16 Oct 2023 11:41:24 -0700 (PDT)
Message-ID: <457a5483c3c4ca5bb6c7ec6f4231074c.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1697481683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQNUXAK2ljoBMjJUatHonR/afLaW5rgWBa8Y22SoWTc=;
        b=Z4+W8D3a/AAgj+ob1QaptkZNSLllasqrbZRtZa6tkqq25rOnxdBmohPGVhc8AU8uPGLieq
        njP9bejOaeEL7SKZpmBmUA3WK2ROPn+4Pv8p1dvqqbkJ3VpuYrK9OhXei7Qyitr1MXHvnz
        NMHHlpKn88gWFpijXU2So8R94l6eXmyM/uVPdMAcAI0+jhNxUx+oacPeM2Q9CywIukCeYM
        MhUVeU3gu/ryPf4COUeSy1JLtyypwFbsHcNLSvaqsc6HSqvU9A0TR+Hbq125fI+QNVbalh
        jPd0QWKclcyHjvstLwEd5HzCw4HdS3OH+pCMg5vFT68dLpdYjHU1f7KKF9/Miw==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1697481683; a=rsa-sha256;
        cv=none;
        b=BQqcEh0q3b8HRE7CvF3a9mcWzRZX9pU1B5pXyinK/aP8oA7cCx10LL0RrvUVeaMVvRQ9UV
        0arKZw5xa01e8+IaW3H8xiQnsMocfAsfAWlTpQdWtDswEXizlaAp7S7zuBQbLHfY9tZOvB
        I4YNk75dKrzv8OLkyQcZ+CtEXYk2V4S60M4Xs7bU2kGicud0oGjaKng6ILsBvzhggCgpuY
        x04O8u+nR6GrhWosU994l0+Pj+DDnFuUKYsUKJxeTFXwgrlyAUlDpRK7OHW3D2dCqwdRs2
        CwM916kaNHFyJJKcVS7Jkn+yfpOBk7e/HcGqcG6DAGdv8CDImM0OXZn/vggitQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1697481683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQNUXAK2ljoBMjJUatHonR/afLaW5rgWBa8Y22SoWTc=;
        b=MFcF1N71r+0qA1q3MdGDjGhTKCi7Hl4cCiAGu6WDD8yTfpAADiwkb3l0xRceHHHQtCdIip
        D2g9O7PYtI+iCoX54GGS43sEBXxwHfqMYFPsrC1CA00xf9x5BVGq+lwHT2w0dYCx/FC+FA
        pfRV7hl8QvpHUHlqHpQtQ23K7pJ5SFJyeYkYxLiZHp4GfYlMRhYzw+7lrYMQnNTRoGBcH9
        5fXhGMWp3K6DjnK36+SBfg3i5i6i7iYSK2YYScIya8yy/YVdKFFbLEdxNv3/2Ua9axvndo
        hSanHxUNjbsA4EVyklB3Y8C4p2EZP9S4TT5pKugjNERW2kwXXau2ycH46e8q+g==
From:   Paulo Alcantara <pc@manguebit.com>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        Steve French <smfrench@gmail.com>
Cc:     "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>,
        Tom Talpey <tom@talpey.com>, Paul Aurich <paul@darkrain42.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Brian Pardy <brian.pardy@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS
 share is mounted (cifsd-cfid-laundromat in"D" state)
In-Reply-To: <c88b2ecd27524153c2acd8aba6ae3c80@matoro.tk>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
 <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
 <ZRN9MtBqYnT6oX60@vaarsuvius>
 <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
 <83d00d50bc628a85db71adb440d8afb5@matoro.tk>
 <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
 <CA6E0F87-65FD-4672-AA0C-A761E5006B7D@manguebit.com>
 <CAH2r5mse_2sfXF+tdTmie5LLtBuc+6DOumDH3rn=5V24yhrYVQ@mail.gmail.com>
 <c88b2ecd27524153c2acd8aba6ae3c80@matoro.tk>
Date:   Mon, 16 Oct 2023 15:41:16 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

matoro <matoro_mailinglist_kernel@matoro.tk> writes:

> Do you have backports of these to 6.5?  I tried to do it manually but 
> there's already so many changes between 6.5 and these commits.

Please find attached two patches that should fix your SMB1 case.  They
applied cleanly on top of v6.5.y branch.

Let me know if it works for you and then I'll ask stable team to pick
those up.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-smb3-do-not-start-laundromat-thread-when-dir-leases-.patch

From b5aa3d1b8550613570a5ebb0c6be291d58d371a3 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Tue, 19 Sep 2023 11:35:53 -0500
Subject: [PATCH 1/2] smb3: do not start laundromat thread when dir leases
 disabled

When no directory lease support, or for IPC shares where directories
can not be opened, do not start an unneeded laundromat thread for
that mount (it wastes resources).

Fixes: d14de8067e3f ("cifs: Add a laundromat thread for cached directories")
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/cached_dir.c |  6 ++++++
 fs/smb/client/cifsglob.h   |  2 +-
 fs/smb/client/cifsproto.h  |  2 +-
 fs/smb/client/connect.c    |  8 ++++++--
 fs/smb/client/misc.c       | 14 +++++++++-----
 fs/smb/client/smb2pdu.c    |  2 +-
 6 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 2d5e9a9d5b8b..23e853a32de7 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -451,6 +451,9 @@ void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 	struct cached_fid *cfid, *q;
 	LIST_HEAD(entry);
 
+	if (cfids == NULL)
+		return;
+
 	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
 		list_move(&cfid->entry, &entry);
@@ -650,6 +653,9 @@ void free_cached_dirs(struct cached_fids *cfids)
 	struct cached_fid *cfid, *q;
 	LIST_HEAD(entry);
 
+	if (cfids == NULL)
+		return;
+
 	if (cfids->laundromat) {
 		kthread_stop(cfids->laundromat);
 		cfids->laundromat = NULL;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 35782a6bede0..bc44474daf88 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1913,7 +1913,7 @@ require use of the stronger protocol */
  * cifsInodeInfo->lock_sem	cifsInodeInfo->llist		cifs_init_once
  *				->can_cache_brlcks
  * cifsInodeInfo->deferred_lock	cifsInodeInfo->deferred_closes	cifsInodeInfo_alloc
- * cached_fid->fid_mutex		cifs_tcon->crfid		tconInfoAlloc
+ * cached_fid->fid_mutex		cifs_tcon->crfid		tcon_info_alloc
  * cifsFileInfo->fh_mutex		cifsFileInfo			cifs_new_fileinfo
  * cifsFileInfo->file_info_lock	cifsFileInfo->count		cifs_new_fileinfo
  *				->invalidHandle			initiate_cifs_search
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 1d71d658e167..bd0a1505719a 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -513,7 +513,7 @@ extern int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
 
 extern struct cifs_ses *sesInfoAlloc(void);
 extern void sesInfoFree(struct cifs_ses *);
-extern struct cifs_tcon *tconInfoAlloc(void);
+extern struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled);
 extern void tconInfoFree(struct cifs_tcon *);
 
 extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 352e251c4113..d4562d36e160 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1882,7 +1882,8 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		}
 	}
 
-	tcon = tconInfoAlloc();
+	/* no need to setup directory caching on IPC share, so pass in false */
+	tcon = tcon_info_alloc(false);
 	if (tcon == NULL)
 		return -ENOMEM;
 
@@ -2492,7 +2493,10 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		goto out_fail;
 	}
 
-	tcon = tconInfoAlloc();
+	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
+		tcon = tcon_info_alloc(true);
+	else
+		tcon = tcon_info_alloc(false);
 	if (tcon == NULL) {
 		rc = -ENOMEM;
 		goto out_fail;
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index d7e85d9a2655..249fac8be5a5 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -113,18 +113,22 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 }
 
 struct cifs_tcon *
-tconInfoAlloc(void)
+tcon_info_alloc(bool dir_leases_enabled)
 {
 	struct cifs_tcon *ret_buf;
 
 	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (!ret_buf)
 		return NULL;
-	ret_buf->cfids = init_cached_dirs();
-	if (!ret_buf->cfids) {
-		kfree(ret_buf);
-		return NULL;
+
+	if (dir_leases_enabled == true) {
+		ret_buf->cfids = init_cached_dirs();
+		if (!ret_buf->cfids) {
+			kfree(ret_buf);
+			return NULL;
+		}
 	}
+	/* else ret_buf->cfids is already set to NULL above */
 
 	atomic_inc(&tconInfoAllocCount);
 	ret_buf->status = TID_NEW;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9c7e46b7e7c7..c22cc7222381 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3871,7 +3871,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		goto done;
 
 	/* allocate a dummy tcon struct used for reconnect */
-	tcon = tconInfoAlloc();
+	tcon = tcon_info_alloc(false);
 	if (!tcon) {
 		resched = true;
 		list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
-- 
2.42.0


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0002-smb-client-do-not-start-laundromat-thread-on-nohandl.patch

From a259c24cfe48ae6d44ea12543773f39a6b8d2cfa Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Wed, 4 Oct 2023 17:28:38 -0300
Subject: [PATCH 2/2] smb: client: do not start laundromat thread on
 nohandlecache

Honor 'nohandlecache' mount option by not starting laundromat thread
even when SMB server supports directory leases. Do not waste system
resources by having laundromat thread running with no directory
caching at all.

Fixes: 2da338ff752a ("smb3: do not start laundromat thread when dir leases  disabled")
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/connect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d4562d36e160..3915ac5a2543 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2474,8 +2474,9 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 static struct cifs_tcon *
 cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
+	struct cifs_tcon *tcon;
+	bool nohandlecache;
 	int rc, xid;
-	struct cifs_tcon *tcon;
 
 	tcon = cifs_find_tcon(ses, ctx);
 	if (tcon) {
@@ -2493,14 +2494,17 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		goto out_fail;
 	}
 
-	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
-		tcon = tcon_info_alloc(true);
+	if (ses->server->dialect >= SMB20_PROT_ID &&
+	    (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING))
+		nohandlecache = ctx->nohandlecache;
 	else
-		tcon = tcon_info_alloc(false);
+		nohandlecache = true;
+	tcon = tcon_info_alloc(!nohandlecache);
 	if (tcon == NULL) {
 		rc = -ENOMEM;
 		goto out_fail;
 	}
+	tcon->nohandlecache = nohandlecache;
 
 	if (ctx->snapshot_time) {
 		if (ses->server->vals->protocol_id == 0) {
@@ -2661,10 +2665,6 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->retry = ctx->retry;
 	tcon->nocase = ctx->nocase;
 	tcon->broken_sparse_sup = ctx->no_sparse;
-	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
-		tcon->nohandlecache = ctx->nohandlecache;
-	else
-		tcon->nohandlecache = true;
 	tcon->nodelete = ctx->nodelete;
 	tcon->local_lease = ctx->local_lease;
 	INIT_LIST_HEAD(&tcon->pending_opens);
-- 
2.42.0


--=-=-=--
