Return-Path: <linux-kernel+bounces-111066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC47886785
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B9284376
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047C12E58;
	Fri, 22 Mar 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLP7FoAt"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBC15AD0;
	Fri, 22 Mar 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092763; cv=none; b=TiRHMgl+YBleyGxXho9X8jT+mo2pR/KZddEJw0KXKBxQKHwj4UVT9Mnf2F2kp+enruKwDa4HQUNMeEr4cDwbiWqYp1rZeUII86PXpLGpVu7emcZ1e3p50fG1WgDSEltFci9LCb4TzF3q+GRG2s5Ds8oNCSq58pACyfhDM7ArRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092763; c=relaxed/simple;
	bh=lHEG80d9o0viGmJ+1Znrd8k+LPCVTS0bK7ZBVCU1o3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=V5uYnphcRgkZTA9Eswh0eB6w2H0dzlwGAqgv5i4AneCwz82HR1tq+tWXLG2SCDyAkjdWwrrWKkqU4xlddonG4T+/7pzN4vlM7EGIDYcFl74BcKr3drni43l3CZxYoZgpAwB1dtCbiztAw8sPsEctodODORgoSecNg7zwyl2x+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLP7FoAt; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so1555334276.0;
        Fri, 22 Mar 2024 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711092760; x=1711697560; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avAEAhdtv4Ns7aQNqc5TeQSh+BdTaTIhfaJ3tgDV3kk=;
        b=KLP7FoAtvyYNZWiQDMLYU62YNYUzFnzfn3eybOyVNjo7Hp50BZtrnINmb8Mv32tk2a
         1nlc0cCujOTJqVoOZTwt5T13PQ/zpqSRRDekYK2Kg2+OFt7LelcEUjw3t4+qQEx+JKra
         j+jUqhT97wBLbLCvDn19qTLiXEG8GivTj1ibWPqNNeh2buq46UsddPnWOtp0s8JSSF9W
         rTo7Q3RLwNIGp9DJOwUpb3VyqlsW3/mHbQIF7F0Owz6ECEt7+IWezlOQ/TxMdqhMnOWK
         mAnpPQRDZKD6n9cUfHd5noYT0RvBlCB6ccVeBhYwB4NCHqbiWJy7z2y02Qcoj8TvOTo3
         AK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711092760; x=1711697560;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avAEAhdtv4Ns7aQNqc5TeQSh+BdTaTIhfaJ3tgDV3kk=;
        b=UP1UOGTwnGWMpESwpNfB+o37Amw/fwEkX0yy4doigIS8u68S9rfB7tg6qqGw7hOooS
         +GZxwKIu6PNobhdBEQf4k9EEVD22jBjUWDOSCiLPsjFE8JaYBCX6Vrc1L7c5w4eLf7RP
         rmi6pALdUTemroyfueCQeKfMc+7spCxFtmhmxfCgMj2dL+U8FNbVbJiI+mh7XzYOcCAh
         enkIhpFu79riobuSG7Eti+c/wavgGGyHL/m4pGnC1s7aBp6jOnzNN2Wv0XFTdrNqnP0G
         MtfAvVHxPMzHESeFWLDZ73Pxrr1Zp3IDCatvwniToPRKiR+dwM2dlXcDl8lhZmb+gW4z
         sPzw==
X-Forwarded-Encrypted: i=1; AJvYcCU1t966bpMNIm5rVobKdIDBG49kyDIUP9PKePeBgBItgL9jthFS/LNHETevKOt8jq2ZJLMxk6gTmDghZcjtdxLrNHsUyc4vl3y8b95HO1XdQDn9ADmh99WML1OXKhOykirXibKwbwEl4w==
X-Gm-Message-State: AOJu0YzfbGESD24XRh6RX8Wi/QMdrETXXBrQfdLgFGiy2vrVP6ggKm0O
	GQ5lJQFjX5l18Xi1TPxbYkFrCQcthpMRGx4DDiRT7q6K3m7xD+7iGHmh+tVTbK9jmv9VmBxoax4
	ES+u3Agf7OiEmk0dK68VpGfMsamQ=
X-Google-Smtp-Source: AGHT+IEDJ++QXRObjhTKsTK4/3CqyKE8dENUPVoEVhHNBmH6bj1Ghg1h71nJNUMf5YYoM9bTL+BcvOxmWsuR6kFM9rg=
X-Received: by 2002:a25:2690:0:b0:dc6:c617:7ca with SMTP id
 m138-20020a252690000000b00dc6c61707camr1441874ybm.29.1711092760308; Fri, 22
 Mar 2024 00:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfQC6Xk+E6HtCtsI@rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net>
In-Reply-To: <ZfQC6Xk+E6HtCtsI@rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net>
From: Ritvik Budhiraja <budhirajaritviksmb@gmail.com>
Date: Fri, 22 Mar 2024 00:32:29 -0700
Message-ID: <CA+EPQ67TC27FTmN30QRHji61ymrD=0y-NZ_CHOi7tAq2qcFWQw@mail.gmail.com>
Subject: Re: [PATCH] Retrying on failed server close
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	bharathsm.hsk@gmail.com
Content-Type: multipart/mixed; boundary="000000000000281cef06143ad4c4"

--000000000000281cef06143ad4c4
Content-Type: multipart/alternative; boundary="000000000000281ced06143ad4c2"

--000000000000281ced06143ad4c2
Content-Type: text/plain; charset="UTF-8"

Attaching the updated patch


On Fri, 15 Mar 2024 at 01:12, Ritvik Budhiraja <budhirajaritviksmb@gmail.com>
wrote:

> In the current implementation, CIFS close sends a close to the server
> and does not check for the success of the server close. This patch adds
> functionality to check for server close return status and retries
> in case of an EBUSY or EAGAIN error
>
> Signed-off-by: Ritvik Budhiraja <rbudhiraja@microsoft.com>
> ---
>  fs/smb/client/cifsfs.c   | 11 +++++++
>  fs/smb/client/cifsglob.h |  7 +++--
>  fs/smb/client/file.c     | 63 ++++++++++++++++++++++++++++++++++++----
>  fs/smb/client/smb1ops.c  |  4 +--
>  fs/smb/client/smb2ops.c  |  9 +++---
>  5 files changed, 80 insertions(+), 14 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index fb368b191eef..e4b2ded86fce 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -160,6 +160,7 @@ struct workqueue_struct     *decrypt_wq;
>  struct workqueue_struct        *fileinfo_put_wq;
>  struct workqueue_struct        *cifsoplockd_wq;
>  struct workqueue_struct        *deferredclose_wq;
> +struct workqueue_struct        *serverclose_wq;
>  __u32 cifs_lock_secret;
>
>  /*
> @@ -1890,6 +1891,13 @@ init_cifs(void)
>                 goto out_destroy_cifsoplockd_wq;
>         }
>
> +       serverclose_wq = alloc_workqueue("serverclose",
> +                                          WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
> +       if (!serverclose_wq) {
> +               rc = -ENOMEM;
> +               goto out_destroy_serverclose_wq;
> +       }
> +
>         rc = cifs_init_inodecache();
>         if (rc)
>                 goto out_destroy_deferredclose_wq;
> @@ -1964,6 +1972,8 @@ init_cifs(void)
>         destroy_workqueue(decrypt_wq);
>  out_destroy_cifsiod_wq:
>         destroy_workqueue(cifsiod_wq);
> +out_destroy_serverclose_wq:
> +       destroy_workqueue(serverclose_wq);
>  out_clean_proc:
>         cifs_proc_clean();
>         return rc;
> @@ -1993,6 +2003,7 @@ exit_cifs(void)
>         destroy_workqueue(cifsoplockd_wq);
>         destroy_workqueue(decrypt_wq);
>         destroy_workqueue(fileinfo_put_wq);
> +       destroy_workqueue(serverclose_wq);
>         destroy_workqueue(cifsiod_wq);
>         cifs_proc_clean();
>  }
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 53c75cfb33ab..c99bc3b3ff56 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -429,10 +429,10 @@ struct smb_version_operations {
>         /* set fid protocol-specific info */
>         void (*set_fid)(struct cifsFileInfo *, struct cifs_fid *, __u32);
>         /* close a file */
> -       void (*close)(const unsigned int, struct cifs_tcon *,
> +       int (*close)(const unsigned int, struct cifs_tcon *,
>                       struct cifs_fid *);
>         /* close a file, returning file attributes and timestamps */
> -       void (*close_getattr)(const unsigned int xid, struct cifs_tcon
> *tcon,
> +       int (*close_getattr)(const unsigned int xid, struct cifs_tcon
> *tcon,
>                       struct cifsFileInfo *pfile_info);
>         /* send a flush request to the server */
>         int (*flush)(const unsigned int, struct cifs_tcon *, struct
> cifs_fid *);
> @@ -1420,6 +1420,7 @@ struct cifsFileInfo {
>         bool invalidHandle:1;   /* file closed via session abend */
>         bool swapfile:1;
>         bool oplock_break_cancelled:1;
> +       bool offload:1; /* offload final part of _put to a wq */
>         unsigned int oplock_epoch; /* epoch from the lease break */
>         __u32 oplock_level; /* oplock/lease level from the lease break */
>         int count;
> @@ -1428,6 +1429,7 @@ struct cifsFileInfo {
>         struct cifs_search_info srch_inf;
>         struct work_struct oplock_break; /* work for oplock breaks */
>         struct work_struct put; /* work for the final part of _put */
> +       struct work_struct serverclose; /* work for serverclose */
>         struct delayed_work deferred;
>         bool deferred_close_scheduled; /* Flag to indicate close is
> scheduled */
>         char *symlink_target;
> @@ -2085,6 +2087,7 @@ extern struct workqueue_struct *decrypt_wq;
>  extern struct workqueue_struct *fileinfo_put_wq;
>  extern struct workqueue_struct *cifsoplockd_wq;
>  extern struct workqueue_struct *deferredclose_wq;
> +extern struct workqueue_struct *serverclose_wq;
>  extern __u32 cifs_lock_secret;
>
>  extern mempool_t *cifs_mid_poolp;
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index c3b8e7091a4d..c1379ec27dcd 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -445,6 +445,7 @@ cifs_down_write(struct rw_semaphore *sem)
>  }
>
>  static void cifsFileInfo_put_work(struct work_struct *work);
> +void serverclose_work(struct work_struct *work);
>
>  struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file
> *file,
>                                        struct tcon_link *tlink, __u32
> oplock,
> @@ -491,6 +492,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid
> *fid, struct file *file,
>         cfile->tlink = cifs_get_tlink(tlink);
>         INIT_WORK(&cfile->oplock_break, cifs_oplock_break);
>         INIT_WORK(&cfile->put, cifsFileInfo_put_work);
> +       INIT_WORK(&cfile->serverclose, serverclose_work);
>         INIT_DELAYED_WORK(&cfile->deferred, smb2_deferred_work_close);
>         mutex_init(&cfile->fh_mutex);
>         spin_lock_init(&cfile->file_info_lock);
> @@ -582,6 +584,40 @@ static void cifsFileInfo_put_work(struct work_struct
> *work)
>         cifsFileInfo_put_final(cifs_file);
>  }
>
> +void serverclose_work(struct work_struct *work)
> +{
> +       struct cifsFileInfo *cifs_file = container_of(work,
> +                       struct cifsFileInfo, serverclose);
> +
> +       struct cifs_tcon *tcon = tlink_tcon(cifs_file->tlink);
> +
> +       struct TCP_Server_Info *server = tcon->ses->server;
> +       int rc;
> +       int retries = 0;
> +       int MAX_RETRIES = 4;
> +
> +       do {
> +               if (server->ops->close_getattr)
> +                       rc = server->ops->close_getattr(0, tcon,
> cifs_file);
> +               else if (server->ops->close)
> +                       rc = server->ops->close(0, tcon, &cifs_file->fid);
> +
> +               if (rc == -EBUSY || rc == -EAGAIN) {
> +                       retries++;
> +                       msleep(250);
> +               }
> +       } while ((rc == -EBUSY || rc == -EAGAIN) && (retries < MAX_RETRIES)
> +       );
> +
> +       if (retries == MAX_RETRIES)
> +               printk(KERN_WARNING "[CIFS_CLOSE] Serverclose failed %d
> times, giving up\n", MAX_RETRIES);
> +
> +       if (cifs_file->offload)
> +               queue_work(fileinfo_put_wq, &cifs_file->put);
> +       else
> +               cifsFileInfo_put_final(cifs_file);
> +}
> +
>  /**
>   * cifsFileInfo_put - release a reference of file priv data
>   *
> @@ -622,10 +658,13 @@ void _cifsFileInfo_put(struct cifsFileInfo
> *cifs_file,
>         struct cifs_fid fid = {};
>         struct cifs_pending_open open;
>         bool oplock_break_cancelled;
> +       bool serverclose_offloaded = false;
>
>         spin_lock(&tcon->open_file_lock);
>         spin_lock(&cifsi->open_file_lock);
>         spin_lock(&cifs_file->file_info_lock);
> +
> +       cifs_file->offload = offload;
>         if (--cifs_file->count > 0) {
>                 spin_unlock(&cifs_file->file_info_lock);
>                 spin_unlock(&cifsi->open_file_lock);
> @@ -667,13 +706,20 @@ void _cifsFileInfo_put(struct cifsFileInfo
> *cifs_file,
>         if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
>                 struct TCP_Server_Info *server = tcon->ses->server;
>                 unsigned int xid;
> +               int rc;
>
>                 xid = get_xid();
>                 if (server->ops->close_getattr)
> -                       server->ops->close_getattr(xid, tcon, cifs_file);
> +                       rc = server->ops->close_getattr(xid, tcon,
> cifs_file);
>                 else if (server->ops->close)
> -                       server->ops->close(xid, tcon, &cifs_file->fid);
> +                       rc = server->ops->close(xid, tcon,
> &cifs_file->fid);
>                 _free_xid(xid);
> +
> +               if (rc == -EBUSY || rc == -EAGAIN) {
> +                       // Server close failed, hence offloading it as an
> async op
> +                       queue_work(serverclose_wq,
> &cifs_file->serverclose);
> +                       serverclose_offloaded = true;
> +               }
>         }
>
>         if (oplock_break_cancelled)
> @@ -681,10 +727,15 @@ void _cifsFileInfo_put(struct cifsFileInfo
> *cifs_file,
>
>         cifs_del_pending_open(&open);
>
> -       if (offload)
> -               queue_work(fileinfo_put_wq, &cifs_file->put);
> -       else
> -               cifsFileInfo_put_final(cifs_file);
> +       // if serverclose has been offloaded to wq (on failure), it will
> +       // handle offloading put as well. If serverclose not offloaded,
> +       // we need to handle offloading put here.
> +       if (!serverclose_offloaded) {
> +               if (offload)
> +                       queue_work(fileinfo_put_wq, &cifs_file->put);
> +               else
> +                       cifsFileInfo_put_final(cifs_file);
> +       }
>  }
>
>  int cifs_open(struct inode *inode, struct file *file)
> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> index a9eaba8083b0..212ec6f66ec6 100644
> --- a/fs/smb/client/smb1ops.c
> +++ b/fs/smb/client/smb1ops.c
> @@ -753,11 +753,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct
> cifs_fid *fid, __u32 oplock)
>         cinode->can_cache_brlcks = CIFS_CACHE_WRITE(cinode);
>  }
>
> -static void
> +static int
>  cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,
>                 struct cifs_fid *fid)
>  {
> -       CIFSSMBClose(xid, tcon, fid->netfid);
> +       return CIFSSMBClose(xid, tcon, fid->netfid);
>  }
>
>  static int
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 4695433fcf39..1dcd4944958f 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -1411,14 +1411,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct
> cifs_fid *fid, __u32 oplock)
>         memcpy(cfile->fid.create_guid, fid->create_guid, 16);
>  }
>
> -static void
> +static int
>  smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,
>                 struct cifs_fid *fid)
>  {
> -       SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid);
> +       return SMB2_close(xid, tcon, fid->persistent_fid,
> fid->volatile_fid);
>  }
>
> -static void
> +static int
>  smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
>                    struct cifsFileInfo *cfile)
>  {
> @@ -1429,7 +1429,7 @@ smb2_close_getattr(const unsigned int xid, struct
> cifs_tcon *tcon,
>         rc = __SMB2_close(xid, tcon, cfile->fid.persistent_fid,
>                    cfile->fid.volatile_fid, &file_inf);
>         if (rc)
> -               return;
> +               return rc;
>
>         inode = d_inode(cfile->dentry);
>
> @@ -1458,6 +1458,7 @@ smb2_close_getattr(const unsigned int xid, struct
> cifs_tcon *tcon,
>
>         /* End of file and Attributes should not have to be updated on
> close */
>         spin_unlock(&inode->i_lock);
> +       return rc;
>  }
>
>  static int
> --
> 2.34.1
>
>

--000000000000281ced06143ad4c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Attaching the updated patch<div><br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 15 Mar 2=
024 at 01:12, Ritvik Budhiraja &lt;<a href=3D"mailto:budhirajaritviksmb@gma=
il.com" target=3D"_blank">budhirajaritviksmb@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">In the current implem=
entation, CIFS close sends a close to the server <br>
and does not check for the success of the server close. This patch adds <br=
>
functionality to check for server close return status and retries <br>
in case of an EBUSY or EAGAIN error<br>
<br>
Signed-off-by: Ritvik Budhiraja &lt;<a href=3D"mailto:rbudhiraja@microsoft.=
com" target=3D"_blank">rbudhiraja@microsoft.com</a>&gt;<br>
---<br>
=C2=A0fs/smb/client/cifsfs.c=C2=A0 =C2=A0| 11 +++++++<br>
=C2=A0fs/smb/client/cifsglob.h |=C2=A0 7 +++--<br>
=C2=A0fs/smb/client/file.c=C2=A0 =C2=A0 =C2=A0| 63 ++++++++++++++++++++++++=
++++++++++++----<br>
=C2=A0fs/smb/client/smb1ops.c=C2=A0 |=C2=A0 4 +--<br>
=C2=A0fs/smb/client/smb2ops.c=C2=A0 |=C2=A0 9 +++---<br>
=C2=A05 files changed, 80 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c<br>
index fb368b191eef..e4b2ded86fce 100644<br>
--- a/fs/smb/client/cifsfs.c<br>
+++ b/fs/smb/client/cifsfs.c<br>
@@ -160,6 +160,7 @@ struct workqueue_struct=C2=A0 =C2=A0 =C2=A0*decrypt_wq;=
<br>
=C2=A0struct workqueue_struct=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fileinfo_put_wq;<=
br>
=C2=A0struct workqueue_struct=C2=A0 =C2=A0 =C2=A0 =C2=A0 *cifsoplockd_wq;<b=
r>
=C2=A0struct workqueue_struct=C2=A0 =C2=A0 =C2=A0 =C2=A0 *deferredclose_wq;=
<br>
+struct workqueue_struct=C2=A0 =C2=A0 =C2=A0 =C2=A0 *serverclose_wq;<br>
=C2=A0__u32 cifs_lock_secret;<br>
<br>
=C2=A0/*<br>
@@ -1890,6 +1891,13 @@ init_cifs(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_destroy_ci=
fsoplockd_wq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serverclose_wq =3D alloc_workqueue(&quot;server=
close&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 W=
Q_FREEZABLE|WQ_MEM_RECLAIM, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!serverclose_wq) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_destroy_se=
rverclose_wq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cifs_init_inodecache();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_destroy_de=
ferredclose_wq;<br>
@@ -1964,6 +1972,8 @@ init_cifs(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(decrypt_wq);<br>
=C2=A0out_destroy_cifsiod_wq:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(cifsiod_wq);<br>
+out_destroy_serverclose_wq:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_workqueue(serverclose_wq);<br>
=C2=A0out_clean_proc:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cifs_proc_clean();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
@@ -1993,6 +2003,7 @@ exit_cifs(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(cifsoplockd_wq);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(decrypt_wq);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(fileinfo_put_wq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_workqueue(serverclose_wq);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(cifsiod_wq);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cifs_proc_clean();<br>
=C2=A0}<br>
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h<br>
index 53c75cfb33ab..c99bc3b3ff56 100644<br>
--- a/fs/smb/client/cifsglob.h<br>
+++ b/fs/smb/client/cifsglob.h<br>
@@ -429,10 +429,10 @@ struct smb_version_operations {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set fid protocol-specific info */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*set_fid)(struct cifsFileInfo *, struct c=
ifs_fid *, __u32);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* close a file */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*close)(const unsigned int, struct cifs_t=
con *,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*close)(const unsigned int, struct cifs_tc=
on *,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct cifs_fid *);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* close a file, returning file attributes and =
timestamps */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*close_getattr)(const unsigned int xid, s=
truct cifs_tcon *tcon,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*close_getattr)(const unsigned int xid, st=
ruct cifs_tcon *tcon,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct cifsFileInfo *pfile_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send a flush request to the server */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*flush)(const unsigned int, struct cifs_tc=
on *, struct cifs_fid *);<br>
@@ -1420,6 +1420,7 @@ struct cifsFileInfo {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool invalidHandle:1;=C2=A0 =C2=A0/* file close=
d via session abend */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool swapfile:1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool oplock_break_cancelled:1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool offload:1; /* offload final part of _put t=
o a wq */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int oplock_epoch; /* epoch from the le=
ase break */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 oplock_level; /* oplock/lease level from =
the lease break */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int count;<br>
@@ -1428,6 +1429,7 @@ struct cifsFileInfo {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cifs_search_info srch_inf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct work_struct oplock_break; /* work for op=
lock breaks */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct work_struct put; /* work for the final p=
art of _put */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct work_struct serverclose; /* work for ser=
verclose */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct delayed_work deferred;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool deferred_close_scheduled; /* Flag to indic=
ate close is scheduled */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *symlink_target;<br>
@@ -2085,6 +2087,7 @@ extern struct workqueue_struct *decrypt_wq;<br>
=C2=A0extern struct workqueue_struct *fileinfo_put_wq;<br>
=C2=A0extern struct workqueue_struct *cifsoplockd_wq;<br>
=C2=A0extern struct workqueue_struct *deferredclose_wq;<br>
+extern struct workqueue_struct *serverclose_wq;<br>
=C2=A0extern __u32 cifs_lock_secret;<br>
<br>
=C2=A0extern mempool_t *cifs_mid_poolp;<br>
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c<br>
index c3b8e7091a4d..c1379ec27dcd 100644<br>
--- a/fs/smb/client/file.c<br>
+++ b/fs/smb/client/file.c<br>
@@ -445,6 +445,7 @@ cifs_down_write(struct rw_semaphore *sem)<br>
=C2=A0}<br>
<br>
=C2=A0static void cifsFileInfo_put_work(struct work_struct *work);<br>
+void serverclose_work(struct work_struct *work);<br>
<br>
=C2=A0struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct f=
ile *file,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tc=
on_link *tlink, __u32 oplock,<br>
@@ -491,6 +492,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid =
*fid, struct file *file,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfile-&gt;tlink =3D cifs_get_tlink(tlink);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&amp;cfile-&gt;oplock_break, cifs_opl=
ock_break);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&amp;cfile-&gt;put, cifsFileInfo_put_=
work);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&amp;cfile-&gt;serverclose, serverclo=
se_work);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_DELAYED_WORK(&amp;cfile-&gt;deferred, smb2=
_deferred_work_close);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&amp;cfile-&gt;fh_mutex);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&amp;cfile-&gt;file_info_lock);<=
br>
@@ -582,6 +584,40 @@ static void cifsFileInfo_put_work(struct work_struct *=
work)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cifsFileInfo_put_final(cifs_file);<br>
=C2=A0}<br>
<br>
+void serverclose_work(struct work_struct *work)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cifsFileInfo *cifs_file =3D container_of=
(work,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct cifsFileInfo, serverclose);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cifs_tcon *tcon =3D tlink_tcon(cifs_file=
-&gt;tlink);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct TCP_Server_Info *server =3D tcon-&gt;ses=
-&gt;server;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int retries =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int MAX_RETRIES =3D 4;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (server-&gt;ops-=
&gt;close_getattr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D server-&gt;ops-&gt;close_getattr(0, tcon, cifs_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (server-&gt=
;ops-&gt;close)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D server-&gt;ops-&gt;close(0, tcon, &amp;cifs_file-&gt;fid);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc =3D=3D -EBUS=
Y || rc =3D=3D -EAGAIN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0retries++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msleep(250);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while ((rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN=
) &amp;&amp; (retries &lt; MAX_RETRIES)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (retries =3D=3D MAX_RETRIES)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_WARNING=
 &quot;[CIFS_CLOSE] Serverclose failed %d times, giving up\n&quot;, MAX_RET=
RIES);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cifs_file-&gt;offload)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_work(fileinfo=
_put_wq, &amp;cifs_file-&gt;put);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cifsFileInfo_put_fi=
nal(cifs_file);<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * cifsFileInfo_put - release a reference of file priv data<br>
=C2=A0 *<br>
@@ -622,10 +658,13 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cifs_fid fid =3D {};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cifs_pending_open open;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool oplock_break_cancelled;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool serverclose_offloaded =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;tcon-&gt;open_file_lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;cifsi-&gt;open_file_lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;cifs_file-&gt;file_info_lock);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cifs_file-&gt;offload =3D offload;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (--cifs_file-&gt;count &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;ci=
fs_file-&gt;file_info_lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;ci=
fsi-&gt;open_file_lock);<br>
@@ -667,13 +706,20 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tcon-&gt;need_reconnect &amp;&amp; !cifs_f=
ile-&gt;invalidHandle) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct TCP_Server_I=
nfo *server =3D tcon-&gt;ses-&gt;server;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int xid;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xid =3D get_xid();<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (server-&gt;ops-=
&gt;close_getattr)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0server-&gt;ops-&gt;close_getattr(xid, tcon, cifs_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D server-&gt;ops-&gt;close_getattr(xid, tcon, cifs_file);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (server-&gt=
;ops-&gt;close)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0server-&gt;ops-&gt;close(xid, tcon, &amp;cifs_file-&gt;fid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D server-&gt;ops-&gt;close(xid, tcon, &amp;cifs_file-&gt;fid=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _free_xid(xid);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc =3D=3D -EBUS=
Y || rc =3D=3D -EAGAIN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0// Server close failed, hence offloading it as an async op<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0queue_work(serverclose_wq, &amp;cifs_file-&gt;serverclose);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0serverclose_offloaded =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (oplock_break_cancelled)<br>
@@ -681,10 +727,15 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cifs_del_pending_open(&amp;open);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (offload)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_work(fileinfo=
_put_wq, &amp;cifs_file-&gt;put);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cifsFileInfo_put_fi=
nal(cifs_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0// if serverclose has been offloaded to wq (on =
failure), it will<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0// handle offloading put as well. If serverclos=
e not offloaded,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0// we need to handle offloading put here.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!serverclose_offloaded) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (offload)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0queue_work(fileinfo_put_wq, &amp;cifs_file-&gt;put);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cifsFileInfo_put_final(cifs_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
=C2=A0int cifs_open(struct inode *inode, struct file *file)<br>
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c<br>
index a9eaba8083b0..212ec6f66ec6 100644<br>
--- a/fs/smb/client/smb1ops.c<br>
+++ b/fs/smb/client/smb1ops.c<br>
@@ -753,11 +753,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct cifs_=
fid *fid, __u32 oplock)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cinode-&gt;can_cache_brlcks =3D CIFS_CACHE_WRIT=
E(cinode);<br>
=C2=A0}<br>
<br>
-static void<br>
+static int<br>
=C2=A0cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cifs_fid *fi=
d)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0CIFSSMBClose(xid, tcon, fid-&gt;netfid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return CIFSSMBClose(xid, tcon, fid-&gt;netfid);=
<br>
=C2=A0}<br>
<br>
=C2=A0static int<br>
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c<br>
index 4695433fcf39..1dcd4944958f 100644<br>
--- a/fs/smb/client/smb2ops.c<br>
+++ b/fs/smb/client/smb2ops.c<br>
@@ -1411,14 +1411,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct cif=
s_fid *fid, __u32 oplock)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(cfile-&gt;fid.create_guid, fid-&gt;creat=
e_guid, 16);<br>
=C2=A0}<br>
<br>
-static void<br>
+static int<br>
=C2=A0smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cifs_fid *fi=
d)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SMB2_close(xid, tcon, fid-&gt;persistent_fid, f=
id-&gt;volatile_fid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return SMB2_close(xid, tcon, fid-&gt;persistent=
_fid, fid-&gt;volatile_fid);<br>
=C2=A0}<br>
<br>
-static void<br>
+static int<br>
=C2=A0smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 cifsFileInfo *cfile)<br>
=C2=A0{<br>
@@ -1429,7 +1429,7 @@ smb2_close_getattr(const unsigned int xid, struct cif=
s_tcon *tcon,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D __SMB2_close(xid, tcon, cfile-&gt;fid.pe=
rsistent_fid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfile-=
&gt;fid.volatile_fid, &amp;file_inf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inode =3D d_inode(cfile-&gt;dentry);<br>
<br>
@@ -1458,6 +1458,7 @@ smb2_close_getattr(const unsigned int xid, struct cif=
s_tcon *tcon,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* End of file and Attributes should not have t=
o be updated on close */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;inode-&gt;i_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
=C2=A0}<br>
<br>
=C2=A0static int<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000281ced06143ad4c2--
--000000000000281cef06143ad4c4
Content-Type: application/octet-stream; 
	name="0001-In-the-current-implementation-CIFS-close-sends-a-clo.patch"
Content-Disposition: attachment; 
	filename="0001-In-the-current-implementation-CIFS-close-sends-a-clo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lu2cfwbo0>
X-Attachment-Id: f_lu2cfwbo0

RnJvbSAzMzM3NGQ4MjQ3NGY1OTg0YzIxMDkxMWEyOGY3ZmViN2I2ODJmYjgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSaXR2aWsgQnVkaGlyYWphIDxyYnVkaGlyYWphQG1pY3Jvc29m
dC5jb20+CkRhdGU6IEZyaSwgMTUgTWFyIDIwMjQgMDc6MjM6MzEgKzAwMDAKU3ViamVjdDogW1BB
VENIXSBJbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgQ0lGUyBjbG9zZSBzZW5kcyBhIGNs
b3NlIHRvCiB0aGUgc2VydmVyIGFuZCBkb2VzIG5vdCBjaGVjayBmb3IgdGhlIHN1Y2Nlc3Mgb2Yg
dGhlIHNlcnZlciBjbG9zZS4gVGhpcyBwYXRjaAogYWRkcyBmdW5jdGlvbmFsaXR5IHRvIGNoZWNr
IGZvciBzZXJ2ZXIgY2xvc2UgcmV0dXJuIHN0YXR1cyBhbmQgcmV0cmllcyBpbgogY2FzZSBvZiBh
biBFQlVTWSBvciBFQUdBSU4gZXJyb3IKClNpZ25lZC1vZmYtYnk6IFJpdHZpayBCdWRoaXJhamEg
PHJidWRoaXJhamFAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY2xpZW50L2NhY2hlZF9kaXIu
YyB8ICA2ICsrLS0KIGZzL3NtYi9jbGllbnQvY2lmc2ZzLmMgICAgIHwgMTEgKysrKysrKwogZnMv
c21iL2NsaWVudC9jaWZzZ2xvYi5oICAgfCAgNyArKystLQogZnMvc21iL2NsaWVudC9maWxlLmMg
ICAgICAgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogZnMvc21i
L2NsaWVudC9zbWIxb3BzLmMgICAgfCAgNCArLS0KIGZzL3NtYi9jbGllbnQvc21iMm9wcy5jICAg
IHwgIDkgKysrLS0tCiBmcy9zbWIvY2xpZW50L3NtYjJwZHUuYyAgICB8ICAyICstCiA3IGZpbGVz
IGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jIGIvZnMvc21iL2NsaWVudC9jYWNoZWRfZGlyLmMK
aW5kZXggM2RlNTA0N2E3ZmY5Li5hZjk1ZTFkYTZmZjcgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGll
bnQvY2FjaGVkX2Rpci5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jCkBAIC00MTYs
NiArNDE2LDcgQEAgc21iMl9jbG9zZV9jYWNoZWRfZmlkKHN0cnVjdCBrcmVmICpyZWYpCiB7CiAJ
c3RydWN0IGNhY2hlZF9maWQgKmNmaWQgPSBjb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgY2FjaGVk
X2ZpZCwKIAkJCQkJICAgICAgIHJlZmNvdW50KTsKKwlpbnQgcmM7CiAKIAlzcGluX2xvY2soJmNm
aWQtPmNmaWRzLT5jZmlkX2xpc3RfbG9jayk7CiAJaWYgKGNmaWQtPm9uX2xpc3QpIHsKQEAgLTQy
OSw5ICs0MzAsMTAgQEAgc21iMl9jbG9zZV9jYWNoZWRfZmlkKHN0cnVjdCBrcmVmICpyZWYpCiAJ
Y2ZpZC0+ZGVudHJ5ID0gTlVMTDsKIAogCWlmIChjZmlkLT5pc19vcGVuKSB7Ci0JCVNNQjJfY2xv
c2UoMCwgY2ZpZC0+dGNvbiwgY2ZpZC0+ZmlkLnBlcnNpc3RlbnRfZmlkLAorCQlyYyA9IFNNQjJf
Y2xvc2UoMCwgY2ZpZC0+dGNvbiwgY2ZpZC0+ZmlkLnBlcnNpc3RlbnRfZmlkLAogCQkJICAgY2Zp
ZC0+ZmlkLnZvbGF0aWxlX2ZpZCk7Ci0JCWF0b21pY19kZWMoJmNmaWQtPnRjb24tPm51bV9yZW1v
dGVfb3BlbnMpOworCQlpZiAocmMgIT0gLUVCVVNZICYmIHJjICE9IC1FQUdBSU4pCisJCQlhdG9t
aWNfZGVjKCZjZmlkLT50Y29uLT5udW1fcmVtb3RlX29wZW5zKTsKIAl9CiAKIAlmcmVlX2NhY2hl
ZF9kaXIoY2ZpZCk7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2NpZnNmcy5jIGIvZnMvc21i
L2NsaWVudC9jaWZzZnMuYwppbmRleCBmYjM2OGIxOTFlZWYuLmU0YjJkZWQ4NmZjZSAxMDA2NDQK
LS0tIGEvZnMvc21iL2NsaWVudC9jaWZzZnMuYworKysgYi9mcy9zbWIvY2xpZW50L2NpZnNmcy5j
CkBAIC0xNjAsNiArMTYwLDcgQEAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QJKmRlY3J5cHRfd3E7
CiBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdAkqZmlsZWluZm9fcHV0X3dxOwogc3RydWN0IHdvcmtx
dWV1ZV9zdHJ1Y3QJKmNpZnNvcGxvY2tkX3dxOwogc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QJKmRl
ZmVycmVkY2xvc2Vfd3E7CitzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdAkqc2VydmVyY2xvc2Vfd3E7
CiBfX3UzMiBjaWZzX2xvY2tfc2VjcmV0OwogCiAvKgpAQCAtMTg5MCw2ICsxODkxLDEzIEBAIGlu
aXRfY2lmcyh2b2lkKQogCQlnb3RvIG91dF9kZXN0cm95X2NpZnNvcGxvY2tkX3dxOwogCX0KIAor
CXNlcnZlcmNsb3NlX3dxID0gYWxsb2Nfd29ya3F1ZXVlKCJzZXJ2ZXJjbG9zZSIsCisJCQkJCSAg
IFdRX0ZSRUVaQUJMRXxXUV9NRU1fUkVDTEFJTSwgMCk7CisJaWYgKCFzZXJ2ZXJjbG9zZV93cSkg
eworCQlyYyA9IC1FTk9NRU07CisJCWdvdG8gb3V0X2Rlc3Ryb3lfc2VydmVyY2xvc2Vfd3E7CisJ
fQorCiAJcmMgPSBjaWZzX2luaXRfaW5vZGVjYWNoZSgpOwogCWlmIChyYykKIAkJZ290byBvdXRf
ZGVzdHJveV9kZWZlcnJlZGNsb3NlX3dxOwpAQCAtMTk2NCw2ICsxOTcyLDggQEAgaW5pdF9jaWZz
KHZvaWQpCiAJZGVzdHJveV93b3JrcXVldWUoZGVjcnlwdF93cSk7CiBvdXRfZGVzdHJveV9jaWZz
aW9kX3dxOgogCWRlc3Ryb3lfd29ya3F1ZXVlKGNpZnNpb2Rfd3EpOworb3V0X2Rlc3Ryb3lfc2Vy
dmVyY2xvc2Vfd3E6CisJZGVzdHJveV93b3JrcXVldWUoc2VydmVyY2xvc2Vfd3EpOwogb3V0X2Ns
ZWFuX3Byb2M6CiAJY2lmc19wcm9jX2NsZWFuKCk7CiAJcmV0dXJuIHJjOwpAQCAtMTk5Myw2ICsy
MDAzLDcgQEAgZXhpdF9jaWZzKHZvaWQpCiAJZGVzdHJveV93b3JrcXVldWUoY2lmc29wbG9ja2Rf
d3EpOwogCWRlc3Ryb3lfd29ya3F1ZXVlKGRlY3J5cHRfd3EpOwogCWRlc3Ryb3lfd29ya3F1ZXVl
KGZpbGVpbmZvX3B1dF93cSk7CisJZGVzdHJveV93b3JrcXVldWUoc2VydmVyY2xvc2Vfd3EpOwog
CWRlc3Ryb3lfd29ya3F1ZXVlKGNpZnNpb2Rfd3EpOwogCWNpZnNfcHJvY19jbGVhbigpOwogfQpk
aWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oIGIvZnMvc21iL2NsaWVudC9jaWZz
Z2xvYi5oCmluZGV4IDUzYzc1Y2ZiMzNhYi4uYzk5YmMzYjNmZjU2IDEwMDY0NAotLS0gYS9mcy9z
bWIvY2xpZW50L2NpZnNnbG9iLmgKKysrIGIvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCkBAIC00
MjksMTAgKzQyOSwxMCBAQCBzdHJ1Y3Qgc21iX3ZlcnNpb25fb3BlcmF0aW9ucyB7CiAJLyogc2V0
IGZpZCBwcm90b2NvbC1zcGVjaWZpYyBpbmZvICovCiAJdm9pZCAoKnNldF9maWQpKHN0cnVjdCBj
aWZzRmlsZUluZm8gKiwgc3RydWN0IGNpZnNfZmlkICosIF9fdTMyKTsKIAkvKiBjbG9zZSBhIGZp
bGUgKi8KLQl2b2lkICgqY2xvc2UpKGNvbnN0IHVuc2lnbmVkIGludCwgc3RydWN0IGNpZnNfdGNv
biAqLAorCWludCAoKmNsb3NlKShjb25zdCB1bnNpZ25lZCBpbnQsIHN0cnVjdCBjaWZzX3Rjb24g
KiwKIAkJICAgICAgc3RydWN0IGNpZnNfZmlkICopOwogCS8qIGNsb3NlIGEgZmlsZSwgcmV0dXJu
aW5nIGZpbGUgYXR0cmlidXRlcyBhbmQgdGltZXN0YW1wcyAqLwotCXZvaWQgKCpjbG9zZV9nZXRh
dHRyKShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAorCWlu
dCAoKmNsb3NlX2dldGF0dHIpKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rj
b24gKnRjb24sCiAJCSAgICAgIHN0cnVjdCBjaWZzRmlsZUluZm8gKnBmaWxlX2luZm8pOwogCS8q
IHNlbmQgYSBmbHVzaCByZXF1ZXN0IHRvIHRoZSBzZXJ2ZXIgKi8KIAlpbnQgKCpmbHVzaCkoY29u
c3QgdW5zaWduZWQgaW50LCBzdHJ1Y3QgY2lmc190Y29uICosIHN0cnVjdCBjaWZzX2ZpZCAqKTsK
QEAgLTE0MjAsNiArMTQyMCw3IEBAIHN0cnVjdCBjaWZzRmlsZUluZm8gewogCWJvb2wgaW52YWxp
ZEhhbmRsZToxOwkvKiBmaWxlIGNsb3NlZCB2aWEgc2Vzc2lvbiBhYmVuZCAqLwogCWJvb2wgc3dh
cGZpbGU6MTsKIAlib29sIG9wbG9ja19icmVha19jYW5jZWxsZWQ6MTsKKwlib29sIG9mZmxvYWQ6
MTsgLyogb2ZmbG9hZCBmaW5hbCBwYXJ0IG9mIF9wdXQgdG8gYSB3cSAqLwogCXVuc2lnbmVkIGlu
dCBvcGxvY2tfZXBvY2g7IC8qIGVwb2NoIGZyb20gdGhlIGxlYXNlIGJyZWFrICovCiAJX191MzIg
b3Bsb2NrX2xldmVsOyAvKiBvcGxvY2svbGVhc2UgbGV2ZWwgZnJvbSB0aGUgbGVhc2UgYnJlYWsg
Ki8KIAlpbnQgY291bnQ7CkBAIC0xNDI4LDYgKzE0MjksNyBAQCBzdHJ1Y3QgY2lmc0ZpbGVJbmZv
IHsKIAlzdHJ1Y3QgY2lmc19zZWFyY2hfaW5mbyBzcmNoX2luZjsKIAlzdHJ1Y3Qgd29ya19zdHJ1
Y3Qgb3Bsb2NrX2JyZWFrOyAvKiB3b3JrIGZvciBvcGxvY2sgYnJlYWtzICovCiAJc3RydWN0IHdv
cmtfc3RydWN0IHB1dDsgLyogd29yayBmb3IgdGhlIGZpbmFsIHBhcnQgb2YgX3B1dCAqLworCXN0
cnVjdCB3b3JrX3N0cnVjdCBzZXJ2ZXJjbG9zZTsgLyogd29yayBmb3Igc2VydmVyY2xvc2UgKi8K
IAlzdHJ1Y3QgZGVsYXllZF93b3JrIGRlZmVycmVkOwogCWJvb2wgZGVmZXJyZWRfY2xvc2Vfc2No
ZWR1bGVkOyAvKiBGbGFnIHRvIGluZGljYXRlIGNsb3NlIGlzIHNjaGVkdWxlZCAqLwogCWNoYXIg
KnN5bWxpbmtfdGFyZ2V0OwpAQCAtMjA4NSw2ICsyMDg3LDcgQEAgZXh0ZXJuIHN0cnVjdCB3b3Jr
cXVldWVfc3RydWN0ICpkZWNyeXB0X3dxOwogZXh0ZXJuIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0
ICpmaWxlaW5mb19wdXRfd3E7CiBleHRlcm4gc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmNpZnNv
cGxvY2tkX3dxOwogZXh0ZXJuIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpkZWZlcnJlZGNsb3Nl
X3dxOworZXh0ZXJuIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpzZXJ2ZXJjbG9zZV93cTsKIGV4
dGVybiBfX3UzMiBjaWZzX2xvY2tfc2VjcmV0OwogCiBleHRlcm4gbWVtcG9vbF90ICpjaWZzX21p
ZF9wb29scDsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvZmlsZS5jIGIvZnMvc21iL2NsaWVu
dC9maWxlLmMKaW5kZXggYzNiOGU3MDkxYTRkLi40OWRlNmNiZDlkZGUgMTAwNjQ0Ci0tLSBhL2Zz
L3NtYi9jbGllbnQvZmlsZS5jCisrKyBiL2ZzL3NtYi9jbGllbnQvZmlsZS5jCkBAIC00NDUsNiAr
NDQ1LDcgQEAgY2lmc19kb3duX3dyaXRlKHN0cnVjdCByd19zZW1hcGhvcmUgKnNlbSkKIH0KIAog
c3RhdGljIHZvaWQgY2lmc0ZpbGVJbmZvX3B1dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
ayk7Cit2b2lkIHNlcnZlcmNsb3NlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsKIAog
c3RydWN0IGNpZnNGaWxlSW5mbyAqY2lmc19uZXdfZmlsZWluZm8oc3RydWN0IGNpZnNfZmlkICpm
aWQsIHN0cnVjdCBmaWxlICpmaWxlLAogCQkJCSAgICAgICBzdHJ1Y3QgdGNvbl9saW5rICp0bGlu
aywgX191MzIgb3Bsb2NrLApAQCAtNDkxLDYgKzQ5Miw3IEBAIHN0cnVjdCBjaWZzRmlsZUluZm8g
KmNpZnNfbmV3X2ZpbGVpbmZvKHN0cnVjdCBjaWZzX2ZpZCAqZmlkLCBzdHJ1Y3QgZmlsZSAqZmls
ZSwKIAljZmlsZS0+dGxpbmsgPSBjaWZzX2dldF90bGluayh0bGluayk7CiAJSU5JVF9XT1JLKCZj
ZmlsZS0+b3Bsb2NrX2JyZWFrLCBjaWZzX29wbG9ja19icmVhayk7CiAJSU5JVF9XT1JLKCZjZmls
ZS0+cHV0LCBjaWZzRmlsZUluZm9fcHV0X3dvcmspOworCUlOSVRfV09SSygmY2ZpbGUtPnNlcnZl
cmNsb3NlLCBzZXJ2ZXJjbG9zZV93b3JrKTsKIAlJTklUX0RFTEFZRURfV09SSygmY2ZpbGUtPmRl
ZmVycmVkLCBzbWIyX2RlZmVycmVkX3dvcmtfY2xvc2UpOwogCW11dGV4X2luaXQoJmNmaWxlLT5m
aF9tdXRleCk7CiAJc3Bpbl9sb2NrX2luaXQoJmNmaWxlLT5maWxlX2luZm9fbG9jayk7CkBAIC01
ODIsNiArNTg0LDQwIEBAIHN0YXRpYyB2b2lkIGNpZnNGaWxlSW5mb19wdXRfd29yayhzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCiAJY2lmc0ZpbGVJbmZvX3B1dF9maW5hbChjaWZzX2ZpbGUpOwog
fQogCit2b2lkIHNlcnZlcmNsb3NlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQorewor
CXN0cnVjdCBjaWZzRmlsZUluZm8gKmNpZnNfZmlsZSA9IGNvbnRhaW5lcl9vZih3b3JrLAorCQkJ
c3RydWN0IGNpZnNGaWxlSW5mbywgc2VydmVyY2xvc2UpOworCisJc3RydWN0IGNpZnNfdGNvbiAq
dGNvbiA9IHRsaW5rX3Rjb24oY2lmc19maWxlLT50bGluayk7CisKKwlzdHJ1Y3QgVENQX1NlcnZl
cl9JbmZvICpzZXJ2ZXIgPSB0Y29uLT5zZXMtPnNlcnZlcjsKKwlpbnQgcmM7CisJaW50IHJldHJp
ZXMgPSAwOworCWludCBNQVhfUkVUUklFUyA9IDQ7CisKKwlkbyB7CisJCWlmIChzZXJ2ZXItPm9w
cy0+Y2xvc2VfZ2V0YXR0cikKKwkJCXJjID0gc2VydmVyLT5vcHMtPmNsb3NlX2dldGF0dHIoMCwg
dGNvbiwgY2lmc19maWxlKTsKKwkJZWxzZSBpZiAoc2VydmVyLT5vcHMtPmNsb3NlKQorCQkJcmMg
PSBzZXJ2ZXItPm9wcy0+Y2xvc2UoMCwgdGNvbiwgJmNpZnNfZmlsZS0+ZmlkKTsKKworCQlpZiAo
cmMgPT0gLUVCVVNZIHx8IHJjID09IC1FQUdBSU4pIHsKKwkJCXJldHJpZXMrKzsKKwkJCW1zbGVl
cCgyNTApOworCQl9CisJfSB3aGlsZSAoKHJjID09IC1FQlVTWSB8fCByYyA9PSAtRUFHQUlOKSAm
JiAocmV0cmllcyA8IE1BWF9SRVRSSUVTKQorCSk7CisKKwlpZiAocmV0cmllcyA9PSBNQVhfUkVU
UklFUykKKwkJcHJpbnRrKEtFUk5fV0FSTklORyAiU2VydmVyY2xvc2UgZmFpbGVkICVkIHRpbWVz
LCBnaXZpbmcgdXBcbiIsIE1BWF9SRVRSSUVTKTsKKworCWlmIChjaWZzX2ZpbGUtPm9mZmxvYWQp
CisJCXF1ZXVlX3dvcmsoZmlsZWluZm9fcHV0X3dxLCAmY2lmc19maWxlLT5wdXQpOworCWVsc2UK
KwkJY2lmc0ZpbGVJbmZvX3B1dF9maW5hbChjaWZzX2ZpbGUpOworfQorCiAvKioKICAqIGNpZnNG
aWxlSW5mb19wdXQgLSByZWxlYXNlIGEgcmVmZXJlbmNlIG9mIGZpbGUgcHJpdiBkYXRhCiAgKgpA
QCAtNjIyLDEwICs2NTgsMTMgQEAgdm9pZCBfY2lmc0ZpbGVJbmZvX3B1dChzdHJ1Y3QgY2lmc0Zp
bGVJbmZvICpjaWZzX2ZpbGUsCiAJc3RydWN0IGNpZnNfZmlkIGZpZCA9IHt9OwogCXN0cnVjdCBj
aWZzX3BlbmRpbmdfb3BlbiBvcGVuOwogCWJvb2wgb3Bsb2NrX2JyZWFrX2NhbmNlbGxlZDsKKwli
b29sIHNlcnZlcmNsb3NlX29mZmxvYWRlZCA9IGZhbHNlOwogCiAJc3Bpbl9sb2NrKCZ0Y29uLT5v
cGVuX2ZpbGVfbG9jayk7CiAJc3Bpbl9sb2NrKCZjaWZzaS0+b3Blbl9maWxlX2xvY2spOwogCXNw
aW5fbG9jaygmY2lmc19maWxlLT5maWxlX2luZm9fbG9jayk7CisKKwljaWZzX2ZpbGUtPm9mZmxv
YWQgPSBvZmZsb2FkOwogCWlmICgtLWNpZnNfZmlsZS0+Y291bnQgPiAwKSB7CiAJCXNwaW5fdW5s
b2NrKCZjaWZzX2ZpbGUtPmZpbGVfaW5mb19sb2NrKTsKIAkJc3Bpbl91bmxvY2soJmNpZnNpLT5v
cGVuX2ZpbGVfbG9jayk7CkBAIC02NjcsMTMgKzcwNiwyMCBAQCB2b2lkIF9jaWZzRmlsZUluZm9f
cHV0KHN0cnVjdCBjaWZzRmlsZUluZm8gKmNpZnNfZmlsZSwKIAlpZiAoIXRjb24tPm5lZWRfcmVj
b25uZWN0ICYmICFjaWZzX2ZpbGUtPmludmFsaWRIYW5kbGUpIHsKIAkJc3RydWN0IFRDUF9TZXJ2
ZXJfSW5mbyAqc2VydmVyID0gdGNvbi0+c2VzLT5zZXJ2ZXI7CiAJCXVuc2lnbmVkIGludCB4aWQ7
CisJCWludCByYzsKIAogCQl4aWQgPSBnZXRfeGlkKCk7CiAJCWlmIChzZXJ2ZXItPm9wcy0+Y2xv
c2VfZ2V0YXR0cikKLQkJCXNlcnZlci0+b3BzLT5jbG9zZV9nZXRhdHRyKHhpZCwgdGNvbiwgY2lm
c19maWxlKTsKKwkJCXJjID0gc2VydmVyLT5vcHMtPmNsb3NlX2dldGF0dHIoeGlkLCB0Y29uLCBj
aWZzX2ZpbGUpOwogCQllbHNlIGlmIChzZXJ2ZXItPm9wcy0+Y2xvc2UpCi0JCQlzZXJ2ZXItPm9w
cy0+Y2xvc2UoeGlkLCB0Y29uLCAmY2lmc19maWxlLT5maWQpOworCQkJcmMgPSBzZXJ2ZXItPm9w
cy0+Y2xvc2UoeGlkLCB0Y29uLCAmY2lmc19maWxlLT5maWQpOwogCQlfZnJlZV94aWQoeGlkKTsK
KworCQlpZiAocmMgPT0gLUVCVVNZIHx8IHJjID09IC1FQUdBSU4pIHsKKwkJCS8vIFNlcnZlciBj
bG9zZSBmYWlsZWQsIGhlbmNlIG9mZmxvYWRpbmcgaXQgYXMgYW4gYXN5bmMgb3AKKwkJCXF1ZXVl
X3dvcmsoc2VydmVyY2xvc2Vfd3EsICZjaWZzX2ZpbGUtPnNlcnZlcmNsb3NlKTsKKwkJCXNlcnZl
cmNsb3NlX29mZmxvYWRlZCA9IHRydWU7CisJCX0KIAl9CiAKIAlpZiAob3Bsb2NrX2JyZWFrX2Nh
bmNlbGxlZCkKQEAgLTY4MSwxMCArNzI3LDE1IEBAIHZvaWQgX2NpZnNGaWxlSW5mb19wdXQoc3Ry
dWN0IGNpZnNGaWxlSW5mbyAqY2lmc19maWxlLAogCiAJY2lmc19kZWxfcGVuZGluZ19vcGVuKCZv
cGVuKTsKIAotCWlmIChvZmZsb2FkKQotCQlxdWV1ZV93b3JrKGZpbGVpbmZvX3B1dF93cSwgJmNp
ZnNfZmlsZS0+cHV0KTsKLQllbHNlCi0JCWNpZnNGaWxlSW5mb19wdXRfZmluYWwoY2lmc19maWxl
KTsKKwkvLyBpZiBzZXJ2ZXJjbG9zZSBoYXMgYmVlbiBvZmZsb2FkZWQgdG8gd3EgKG9uIGZhaWx1
cmUpLCBpdCB3aWxsCisJLy8gaGFuZGxlIG9mZmxvYWRpbmcgcHV0IGFzIHdlbGwuIElmIHNlcnZl
cmNsb3NlIG5vdCBvZmZsb2FkZWQsCisJLy8gd2UgbmVlZCB0byBoYW5kbGUgb2ZmbG9hZGluZyBw
dXQgaGVyZS4KKwlpZiAoIXNlcnZlcmNsb3NlX29mZmxvYWRlZCkgeworCQlpZiAob2ZmbG9hZCkK
KwkJCXF1ZXVlX3dvcmsoZmlsZWluZm9fcHV0X3dxLCAmY2lmc19maWxlLT5wdXQpOworCQllbHNl
CisJCQljaWZzRmlsZUluZm9fcHV0X2ZpbmFsKGNpZnNfZmlsZSk7CisJfQogfQogCiBpbnQgY2lm
c19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQpkaWZmIC0tZ2l0
IGEvZnMvc21iL2NsaWVudC9zbWIxb3BzLmMgYi9mcy9zbWIvY2xpZW50L3NtYjFvcHMuYwppbmRl
eCBhOWVhYmE4MDgzYjAuLjIxMmVjNmY2NmVjNiAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9z
bWIxb3BzLmMKKysrIGIvZnMvc21iL2NsaWVudC9zbWIxb3BzLmMKQEAgLTc1MywxMSArNzUzLDEx
IEBAIGNpZnNfc2V0X2ZpZChzdHJ1Y3QgY2lmc0ZpbGVJbmZvICpjZmlsZSwgc3RydWN0IGNpZnNf
ZmlkICpmaWQsIF9fdTMyIG9wbG9jaykKIAljaW5vZGUtPmNhbl9jYWNoZV9icmxja3MgPSBDSUZT
X0NBQ0hFX1dSSVRFKGNpbm9kZSk7CiB9CiAKLXN0YXRpYyB2b2lkCitzdGF0aWMgaW50CiBjaWZz
X2Nsb3NlX2ZpbGUoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNv
biwKIAkJc3RydWN0IGNpZnNfZmlkICpmaWQpCiB7Ci0JQ0lGU1NNQkNsb3NlKHhpZCwgdGNvbiwg
ZmlkLT5uZXRmaWQpOworCXJldHVybiBDSUZTU01CQ2xvc2UoeGlkLCB0Y29uLCBmaWQtPm5ldGZp
ZCk7CiB9CiAKIHN0YXRpYyBpbnQKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvc21iMm9wcy5j
IGIvZnMvc21iL2NsaWVudC9zbWIyb3BzLmMKaW5kZXggNDY5NTQzM2ZjZjM5Li4xZGNkNDk0NDk1
OGYgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvc21iMm9wcy5jCisrKyBiL2ZzL3NtYi9jbGll
bnQvc21iMm9wcy5jCkBAIC0xNDExLDE0ICsxNDExLDE0IEBAIHNtYjJfc2V0X2ZpZChzdHJ1Y3Qg
Y2lmc0ZpbGVJbmZvICpjZmlsZSwgc3RydWN0IGNpZnNfZmlkICpmaWQsIF9fdTMyIG9wbG9jaykK
IAltZW1jcHkoY2ZpbGUtPmZpZC5jcmVhdGVfZ3VpZCwgZmlkLT5jcmVhdGVfZ3VpZCwgMTYpOwog
fQogCi1zdGF0aWMgdm9pZAorc3RhdGljIGludAogc21iMl9jbG9zZV9maWxlKGNvbnN0IHVuc2ln
bmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJCXN0cnVjdCBjaWZzX2ZpZCAq
ZmlkKQogewotCVNNQjJfY2xvc2UoeGlkLCB0Y29uLCBmaWQtPnBlcnNpc3RlbnRfZmlkLCBmaWQt
PnZvbGF0aWxlX2ZpZCk7CisJcmV0dXJuIFNNQjJfY2xvc2UoeGlkLCB0Y29uLCBmaWQtPnBlcnNp
c3RlbnRfZmlkLCBmaWQtPnZvbGF0aWxlX2ZpZCk7CiB9CiAKLXN0YXRpYyB2b2lkCitzdGF0aWMg
aW50CiBzbWIyX2Nsb3NlX2dldGF0dHIoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNp
ZnNfdGNvbiAqdGNvbiwKIAkJICAgc3RydWN0IGNpZnNGaWxlSW5mbyAqY2ZpbGUpCiB7CkBAIC0x
NDI5LDcgKzE0MjksNyBAQCBzbWIyX2Nsb3NlX2dldGF0dHIoY29uc3QgdW5zaWduZWQgaW50IHhp
ZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwKIAlyYyA9IF9fU01CMl9jbG9zZSh4aWQsIHRjb24s
IGNmaWxlLT5maWQucGVyc2lzdGVudF9maWQsCiAJCSAgIGNmaWxlLT5maWQudm9sYXRpbGVfZmlk
LCAmZmlsZV9pbmYpOwogCWlmIChyYykKLQkJcmV0dXJuOworCQlyZXR1cm4gcmM7CiAKIAlpbm9k
ZSA9IGRfaW5vZGUoY2ZpbGUtPmRlbnRyeSk7CiAKQEAgLTE0NTgsNiArMTQ1OCw3IEBAIHNtYjJf
Y2xvc2VfZ2V0YXR0cihjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0
Y29uLAogCiAJLyogRW5kIG9mIGZpbGUgYW5kIEF0dHJpYnV0ZXMgc2hvdWxkIG5vdCBoYXZlIHRv
IGJlIHVwZGF0ZWQgb24gY2xvc2UgKi8KIAlzcGluX3VubG9jaygmaW5vZGUtPmlfbG9jayk7CisJ
cmV0dXJuIHJjOwogfQogCiBzdGF0aWMgaW50CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L3Nt
YjJwZHUuYyBiL2ZzL3NtYi9jbGllbnQvc21iMnBkdS5jCmluZGV4IDYwOGVlMDU0OTFlMi4uYjE3
YWZlOTQxYTc1IDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L3NtYjJwZHUuYworKysgYi9mcy9z
bWIvY2xpZW50L3NtYjJwZHUuYwpAQCAtMzYwMCw5ICszNjAwLDkgQEAgX19TTUIyX2Nsb3NlKGNv
bnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJCQltZW1jcHko
JnBidWYtPm5ldHdvcmtfb3Blbl9pbmZvLAogCQkJICAgICAgICZyc3AtPm5ldHdvcmtfb3Blbl9p
bmZvLAogCQkJICAgICAgIHNpemVvZihwYnVmLT5uZXR3b3JrX29wZW5faW5mbykpOworCQlhdG9t
aWNfZGVjKCZ0Y29uLT5udW1fcmVtb3RlX29wZW5zKTsKIAl9CiAKLQlhdG9taWNfZGVjKCZ0Y29u
LT5udW1fcmVtb3RlX29wZW5zKTsKIGNsb3NlX2V4aXQ6CiAJU01CMl9jbG9zZV9mcmVlKCZycXN0
KTsKIAlmcmVlX3JzcF9idWYocmVzcF9idWZ0eXBlLCByc3ApOwotLSAKMi4zNC4xCgo=
--000000000000281cef06143ad4c4--

