Return-Path: <linux-kernel+bounces-60476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8174085056D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C66FB222B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711AE5C907;
	Sat, 10 Feb 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNSMBu/h"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971015BAC4;
	Sat, 10 Feb 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583804; cv=none; b=lbdzh52Ax9YN8ggLNiFCWvINiWPwoI8ua0zI2yH5vDsJUUqrbNKvnXQEyVeua/Xs03+pgn3dvQEPH+jTUJjhP4p27AMKv96Cjju+uH/089SssH9UAc3U5ppCehBdrH8pNP06OoWUI6bQYPUeryjDO9LbWkPTXpsAI6eLHlv2tLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583804; c=relaxed/simple;
	bh=kQ4HjhJzE7L8FicXuvcZaMPqNQ6wBIdBwlPFmTH6cWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1wyeLf7f+y6/MP2I4Ji+EDq7Bj8BxLRT1Q4yqhyWkHZS1agFgGeVFOvMOASCOvzi5BQUZOZ0Rj4uQVhK/IzHyJjwRtk/R+4jxpHCoWH2+Nau3Idht6qFcYQtZuc4P82sZV5V7OLVCe8Hmy8o04GfEqls44oE7gBZqYVUpMudfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNSMBu/h; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116588189aso3487075e87.1;
        Sat, 10 Feb 2024 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707583800; x=1708188600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWKZT2/oteDyi+BBd13gxQnt1+YGW4A+h11i3bzUnAc=;
        b=TNSMBu/hKE42smhghc7CHUHp0NHSC+b5D0GpcE7fOMYu9tEwKJnB1xA/XGp+i4kjUI
         U9/Bj49kNDNXnEiD8tEgud102p2g5S5QO9mP6CwKvZmHjgUf2HfXjpzMCkXqJVdL+mbb
         C9W1xtLJwr3+j/QM2mzrZI59dmlr22ldNrU68E3673t75fLPuMfj1EblC4JmLvPrBPig
         2Ns+3sT/LRvr59TyLZWJb/ciiAzs1rtN0ujQvjun2y7CC7gEjlLDXWQmKgjU4/Wrpi4f
         /Gu0B/d6tHDNCrlbkvyOZ7gGPnUubrKz9dMvBWfI356kHtz2Cp8e16WpounUO9qnL/3o
         5xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707583800; x=1708188600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWKZT2/oteDyi+BBd13gxQnt1+YGW4A+h11i3bzUnAc=;
        b=gf1Pj2Phc1uYlO4S0ViOQgb7SYA0ryXFauJ6+Fx2E7neVoxxM7VcS3LL96lPVOZ4fJ
         /ec2bd0m0rrzMHZC9T1qcscIRubpLJBFAldc1RpgTe2ChreuvixGYODjyh/09nnUlQjE
         M36Vr4XX2o58f9rVLaOPBxDba9/Nx7ZY76xvfUehKxxIAabrg/XqPbU1FTxSp26nOvqu
         wK6qHeiyCol5yMf8+qQo2j09Rn/pD9S1fDTrTtu7BAKDlUWpRrubuZm7xf1NE1sWtpE0
         ggtwBAOsm+uzVTYURaUTWqn9YjZdehpEI3DPgSTWDlmT1NuXsieIAceAH1a68+bJEDEU
         o76w==
X-Gm-Message-State: AOJu0YwX7pSZcfFqVOEm5s3i6fWO2rpEmUBhDXKpGOed4SMW6+7GJ0w8
	Ya1qSreV7uP85jRfesVjV2VFpBxXzfgXiQ4uQvIGqo79Hh6nk88zd4Wf9F8AwK8hXax+N8CcOmU
	UkX3m8HyeuPhg8YrNB5p8/x77qG4=
X-Google-Smtp-Source: AGHT+IHkhA+E1kUgb0xNkb7GX/VlVovE4kmPXlMs09LDe9DVt9TWKnEN5PDbNsr24bDkEtAAFOJ6ggT1+QgjimhCA6s=
X-Received: by 2002:a19:f007:0:b0:511:69bf:d1a6 with SMTP id
 p7-20020a19f007000000b0051169bfd1a6mr1279706lfc.40.1707583800255; Sat, 10 Feb
 2024 08:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com> <CAH2r5mtdebsVFbOoQeYYL79GVXe0wn=GfdgVE1RkQrnowHOO5Q@mail.gmail.com>
In-Reply-To: <CAH2r5mtdebsVFbOoQeYYL79GVXe0wn=GfdgVE1RkQrnowHOO5Q@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 10 Feb 2024 22:19:48 +0530
Message-ID: <CANT5p=p+TYwH7yLH9+kvum0O5KjxKc9MrWtERCc7WCv_wzODQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] smb: client: do not defer close open handles to
 deleted files
To: Steve French <smfrench@gmail.com>
Cc: meetakshisetiyaoss@gmail.com, sfrench@samba.org, pc@manguebit.com, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 11:29=E2=80=AFAM Steve French <smfrench@gmail.com> =
wrote:
>
> could we make the "file_is_deleted" a boolean instead of using up more
> space making it an int?

Meetakshi initially had it as a bool. I asked her to make it a bitmap,
just in case there can be other such flags that are needed in the
future.

>
> Alternatively - would it be possible to simply look at the file
> attributes to see if it was marked as deleted (ie we should already be
> setting ATTR_DELETE_ON_CLOSE)

It does not look like we use this attr anywhere today. (Am I missing someth=
ing?)
Also, it looks like a flag that SMB uses in requests and responses.
I feel that it's better to keep a different flag for this purpose.

>
> On Fri, Feb 9, 2024 at 7:17=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wro=
te:
> >
> > From: Meetakshi Setiya <msetiya@microsoft.com>
> >
> > When a file/dentry has been deleted before closing all its open handles=
,
> > currently, closing them can add them to the deferred close list. This c=
an
> > lead to problems in creating file with the same name when the file is
> > re-created before the deferred close completes. This issue was seen whi=
le
> > reusing a client's already existing lease on a file for compound operat=
ions
> > and xfstest 591 failed because of the deferred close handle that remain=
ed
> > valid even after the file was deleted and was being reused to create a =
file
> > with the same name. The server in this case returns an error on open wi=
th
> > STATUS_DELETE_PENDING. Recreating the file would fail till the deferred
> > handles are closed (duration specified in closetimeo).
> >
> > This patch fixes the issue by flagging all open handles for the deleted
> > file (file path to be precise) with FILE_DELETED at the end of the unli=
nk
> > operation. A new field cflags has been introduced in the cifsFileInfo
> > structure to set the FILE_DELETED flag without interfering with the f_f=
lags
> > field. This cflags field could be useful in the future for setting more
> > flags specific to cfile.
> > When doing close in cifs_close for each of these handles, check the
> > FILE_DELETED flag and do not defer close these handles if the correspon=
ding
> > filepath has been deleted.
> >
> > Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> > ---
> >  fs/smb/client/cifsglob.h  |  3 +++
> >  fs/smb/client/cifsproto.h |  4 ++++
> >  fs/smb/client/file.c      |  3 ++-
> >  fs/smb/client/inode.c     |  2 ++
> >  fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
> >  5 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> > index 16befff4cbb4..f6b4acdcdeb3 100644
> > --- a/fs/smb/client/cifsglob.h
> > +++ b/fs/smb/client/cifsglob.h
> > @@ -1398,6 +1398,8 @@ struct cifs_fid_locks {
> >         struct list_head locks;         /* locks held by fid above */
> >  };
> >
> > +#define FILE_DELETED 00000001
> > +
> >  struct cifsFileInfo {
> >         /* following two lists are protected by tcon->open_file_lock */
> >         struct list_head tlist; /* pointer to next fid owned by tcon */
> > @@ -1413,6 +1415,7 @@ struct cifsFileInfo {
> >         struct dentry *dentry;
> >         struct tcon_link *tlink;
> >         unsigned int f_flags;
> > +       unsigned int cflags;    /* flags for this file */
> >         bool invalidHandle:1;   /* file closed via session abend */
> >         bool swapfile:1;
> >         bool oplock_break_cancelled:1;
> > diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> > index a841bf4967fa..f995b766b177 100644
> > --- a/fs/smb/client/cifsproto.h
> > +++ b/fs/smb/client/cifsproto.h
> > @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct c=
ifs_tcon *cifs_tcon);
> >
> >  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *ci=
fs_tcon,
> >                                 const char *path);
> > +
> > +extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon
> > +                               *cifs_tcon, const char *path);
> > +
> >  extern struct TCP_Server_Info *
> >  cifs_get_tcp_session(struct smb3_fs_context *ctx,
> >                      struct TCP_Server_Info *primary_server);
> > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> > index b75282c204da..91cf4d2df4de 100644
> > --- a/fs/smb/client/file.c
> > +++ b/fs/smb/client/file.c
> > @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_=
fid *fid, struct file *file,
> >         cfile->uid =3D current_fsuid();
> >         cfile->dentry =3D dget(dentry);
> >         cfile->f_flags =3D file->f_flags;
> > +       cfile->cflags =3D 0;
> >         cfile->invalidHandle =3D false;
> >         cfile->deferred_close_scheduled =3D false;
> >         cfile->tlink =3D cifs_get_tlink(tlink);
> > @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *=
file)
> >                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D =
CIFS_CACHE_RHW_FLG)
> >                     && cinode->lease_granted &&
> >                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &=
&
> > -                   dclose) {
> > +                   dclose && !(cfile->cflags & FILE_DELETED)) {
> >                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, =
&cinode->flags)) {
> >                                 inode_set_mtime_to_ts(inode,
> >                                                       inode_set_ctime_c=
urrent(inode));
> > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> > index d02f8ba29cb5..8121b5b1aa22 100644
> > --- a/fs/smb/client/inode.c
> > +++ b/fs/smb/client/inode.c
> > @@ -1900,6 +1900,8 @@ int cifs_unlink(struct inode *dir, struct dentry =
*dentry)
> >         cifs_inode =3D CIFS_I(dir);
> >         CIFS_I(dir)->time =3D 0;  /* force revalidate of dir as well */
> >  unlink_out:
> > +       if (rc =3D=3D 0)
> > +               cifs_mark_open_handles_for_deleted_file(tcon, full_path=
);
> >         free_dentry_path(page);
> >         kfree(attrs);
> >         free_xid(xid);
> > diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> > index 0748d7b757b9..8e46dee1a36c 100644
> > --- a/fs/smb/client/misc.c
> > +++ b/fs/smb/client/misc.c
> > @@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct cifs_=
tcon *tcon, const char *path)
> >         free_dentry_path(page);
> >  }
> >
> > +/*
> > + * If a dentry has been deleted, all corresponding open handles should=
 know that
> > + * so that we do not defer close them.
> > + */
> > +void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon,
> > +                                            const char *path)
> > +{
> > +       struct cifsFileInfo *cfile;
> > +       void *page;
> > +       const char *full_path;
> > +
> > +       page =3D alloc_dentry_path();
> > +       spin_lock(&tcon->open_file_lock);
> > +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
> > +               full_path =3D build_path_from_dentry(cfile->dentry, pag=
e);
> > +               if (strcmp(full_path, path) =3D=3D 0)
> > +                       cfile->cflags |=3D FILE_DELETED;
> > +       }
> > +       spin_unlock(&tcon->open_file_lock);
> > +       free_dentry_path(page);
> > +}
> > +
> >  /* parses DFS referral V3 structure
> >   * caller is responsible for freeing target_nodes
> >   * returns:
> > --
> > 2.39.2
> >
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Regards,
Shyam

