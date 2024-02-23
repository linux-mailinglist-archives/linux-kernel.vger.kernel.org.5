Return-Path: <linux-kernel+bounces-78347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6EE861242
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C2BB2290A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134D7EEF9;
	Fri, 23 Feb 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpZt3tYw"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF87E788;
	Fri, 23 Feb 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693723; cv=none; b=to4S2jUR5E7jTyCMtrgkxnAG1fAseqqXhiueK6Mta6SDHFbu6pdIU6UY2IJPrTGeowj/ToaqCmTzn+40By1zpMU+eKefT/umFWpRm3m1rrzxla+WijhzPoXCBKfHhWJOTIkwzTlxbqEQgQ5LwS5iNM391ZfcYAdqyK6avl8P/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693723; c=relaxed/simple;
	bh=3JHiPpvRlDEZZoeO6iNCxZQbvnIV0zqN2uCtPHE6bMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozc/K4EIbgY9IwbtGYD873RyuTva36p0xYEIZX76/M2fuOq56pShcdWPORxA3HWaSzVxjfvM5sgfLKjnTI74Ek//xMmPasRvdCu6MKIcxVPKSm/vfmLczo2eYCEXOLACoZfbzss4IXWyZLd1O2AjlLoMCQECgfIy3CELtJXG3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpZt3tYw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512b4388dafso357390e87.2;
        Fri, 23 Feb 2024 05:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708693707; x=1709298507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEvHv0RCDK9H2MJD01J685Bl9xsmxHc938rJVeHVDmk=;
        b=DpZt3tYwFq0v/ZcYwncYtrV8SgP98ApPexNFen+Jqs9I/ogNqfZ0ZQcPbZSh364ofD
         K4EeIJZFHtossw5BOXnobV9G3mOUKjdHn7GlEnErSTtVE0Y37fMg4f309fp4FDAOwzAj
         cLVefmLZwhTob2xxxXY9VM3wQIHM90ROahQPLTcjbwnq5RcVhfAwFyFt1wDBiKV29qBU
         fa76V6UY6PZCPDXX1OrjUlhj/19c9+bkv/IEVXqUN1vIBWKleNBWT98sqanHeTlF6iea
         Jstp2GJQd0V17Jip2Q+dptE8hkkye/JSmb26oGlNKRrCF3d6GZjqHNhR5lskQF0XiH5O
         uH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693707; x=1709298507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEvHv0RCDK9H2MJD01J685Bl9xsmxHc938rJVeHVDmk=;
        b=QyTMwznA+Cv0tyKRY3yb7RUE3BigND0XSWvvH4SCdgLkyWiJbXLKqjEM2yhSsprzZz
         u9VOP5JnORUnx8qzW+hskfKwAUWKrTrT7QZNbZj5KZQVuvTb4LCLXxkWzcBtjlqmRCor
         kAUmVPwE/9MKDXM6q3OrCkJnU+GNPJiogJXiGxXV9miUsdTrgaGlML7RS/SY4husf2na
         L/WJnW9ZsnSWdrMiGX7NyXSBjUlJhAqqAhWvscLd0p/OCmU3dzwZcz+7DWzBKflq68HA
         3qgIq/jZGKlM4EFgKiUCoDCaQQpCsP6kxSmRg19mpLm7mRwB/PRF6+5b125SLdkp5S5B
         /V3A==
X-Forwarded-Encrypted: i=1; AJvYcCWciHKDmz880ClKqQ4cA0alyaK2J+47IMLcfQkkP5cvRllXoJy0DjvVVeh0CnKdouCxDTn9LgduB4ljrfZGenvjKh3FVXEWlTqAaZPsV9o2BmTvJMR4gpBlttgrz02pQ8uqo1qsL8yz0g==
X-Gm-Message-State: AOJu0YxJ4jcFIYBuoTrvvuRtH5Rnsc9goKR3WW2XUQQ2hXRySLdiKlKP
	tm9c6x+ak6CEKsU8HwxW5wSzJzMWxc7wn1JXZLdcb/ZA+iuB6Ub7eUNAjVDR4lzzbCiXOy/PxJV
	PPNNIngiuSQUWuHvjcDFqZ8f21w0hfk/zM+Y=
X-Google-Smtp-Source: AGHT+IHEFhbaMjen9gSSeeq/fufxuTZqBXLekfs/XCh+Ncjc6V0xCelJzbZ3eaaVz6od+T7+5BEO58TXpRd6HQuXCeA=
X-Received: by 2002:a05:6512:3b24:b0:512:e00b:9120 with SMTP id
 f36-20020a0565123b2400b00512e00b9120mr1725997lfv.32.1708693707164; Fri, 23
 Feb 2024 05:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
 <CAH2r5mtdebsVFbOoQeYYL79GVXe0wn=GfdgVE1RkQrnowHOO5Q@mail.gmail.com>
 <CANT5p=p+TYwH7yLH9+kvum0O5KjxKc9MrWtERCc7WCv_wzODQg@mail.gmail.com>
 <CAH2r5mumpNgm62mSFQmtMANm-njH1VJsv4ZT50Cww9dTCed3XQ@mail.gmail.com> <CAFTVevU94O1NEJ1XzrUSDoC7b4=W=wciqRWX8LoB1X1=AUNZfA@mail.gmail.com>
In-Reply-To: <CAFTVevU94O1NEJ1XzrUSDoC7b4=W=wciqRWX8LoB1X1=AUNZfA@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 23 Feb 2024 18:38:15 +0530
Message-ID: <CANT5p=r4U8R=bYv=iB1OO+cwCpKxt7jqbutviWHB5yp5NC0j4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] smb: client: do not defer close open handles to
 deleted files
To: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, Bharath SM <bharathsm.hsk@gmail.com>, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:14=E2=80=AFAM Meetakshi Setiya
<meetakshisetiyaoss@gmail.com> wrote:
>
> PFA the follow up patch that uses a boolean field status_file_deleted
> instead of a bitmap to mark open handles for files that have been deleted=
.
> Additionally, if SMB2 query info response is received with the DeletePend=
ing
> flag set to true for a client, mark the corresponding open file handles
> in this case too.
>
> Thanks
> Meetakshi
>
> On Sun, Feb 11, 2024 at 2:34=E2=80=AFAM Steve French <smfrench@gmail.com>=
 wrote:
> >
> > I lean toward using the existing attr field since it presumably could b=
e set remotely and best to be safe and consistent and also uses less space
> >
> > ATTR_DELETE_ON_CLOSE
> >
> > On Sat, Feb 10, 2024, 11:50 Shyam Prasad N <nspmangalore@gmail.com> wro=
te:
> >>
> >> On Sat, Feb 10, 2024 at 11:29=E2=80=AFAM Steve French <smfrench@gmail.=
com> wrote:
> >> >
> >> > could we make the "file_is_deleted" a boolean instead of using up mo=
re
> >> > space making it an int?
> >>
> >> Meetakshi initially had it as a bool. I asked her to make it a bitmap,
> >> just in case there can be other such flags that are needed in the
> >> future.
> >>
> >> >
> >> > Alternatively - would it be possible to simply look at the file
> >> > attributes to see if it was marked as deleted (ie we should already =
be
> >> > setting ATTR_DELETE_ON_CLOSE)
> >>
> >> It does not look like we use this attr anywhere today. (Am I missing s=
omething?)
> >> Also, it looks like a flag that SMB uses in requests and responses.
> >> I feel that it's better to keep a different flag for this purpose.
> >>
> >> >
> >> > On Fri, Feb 9, 2024 at 7:17=E2=80=AFAM <meetakshisetiyaoss@gmail.com=
> wrote:
> >> > >
> >> > > From: Meetakshi Setiya <msetiya@microsoft.com>
> >> > >
> >> > > When a file/dentry has been deleted before closing all its open ha=
ndles,
> >> > > currently, closing them can add them to the deferred close list. T=
his can
> >> > > lead to problems in creating file with the same name when the file=
 is
> >> > > re-created before the deferred close completes. This issue was see=
n while
> >> > > reusing a client's already existing lease on a file for compound o=
perations
> >> > > and xfstest 591 failed because of the deferred close handle that r=
emained
> >> > > valid even after the file was deleted and was being reused to crea=
te a file
> >> > > with the same name. The server in this case returns an error on op=
en with
> >> > > STATUS_DELETE_PENDING. Recreating the file would fail till the def=
erred
> >> > > handles are closed (duration specified in closetimeo).
> >> > >
> >> > > This patch fixes the issue by flagging all open handles for the de=
leted
> >> > > file (file path to be precise) with FILE_DELETED at the end of the=
 unlink
> >> > > operation. A new field cflags has been introduced in the cifsFileI=
nfo
> >> > > structure to set the FILE_DELETED flag without interfering with th=
e f_flags
> >> > > field. This cflags field could be useful in the future for setting=
 more
> >> > > flags specific to cfile.
> >> > > When doing close in cifs_close for each of these handles, check th=
e
> >> > > FILE_DELETED flag and do not defer close these handles if the corr=
esponding
> >> > > filepath has been deleted.
> >> > >
> >> > > Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> >> > > ---
> >> > >  fs/smb/client/cifsglob.h  |  3 +++
> >> > >  fs/smb/client/cifsproto.h |  4 ++++
> >> > >  fs/smb/client/file.c      |  3 ++-
> >> > >  fs/smb/client/inode.c     |  2 ++
> >> > >  fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
> >> > >  5 files changed, 33 insertions(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> >> > > index 16befff4cbb4..f6b4acdcdeb3 100644
> >> > > --- a/fs/smb/client/cifsglob.h
> >> > > +++ b/fs/smb/client/cifsglob.h
> >> > > @@ -1398,6 +1398,8 @@ struct cifs_fid_locks {
> >> > >         struct list_head locks;         /* locks held by fid above=
 */
> >> > >  };
> >> > >
> >> > > +#define FILE_DELETED 00000001
> >> > > +
> >> > >  struct cifsFileInfo {
> >> > >         /* following two lists are protected by tcon->open_file_lo=
ck */
> >> > >         struct list_head tlist; /* pointer to next fid owned by tc=
on */
> >> > > @@ -1413,6 +1415,7 @@ struct cifsFileInfo {
> >> > >         struct dentry *dentry;
> >> > >         struct tcon_link *tlink;
> >> > >         unsigned int f_flags;
> >> > > +       unsigned int cflags;    /* flags for this file */
> >> > >         bool invalidHandle:1;   /* file closed via session abend *=
/
> >> > >         bool swapfile:1;
> >> > >         bool oplock_break_cancelled:1;
> >> > > diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> >> > > index a841bf4967fa..f995b766b177 100644
> >> > > --- a/fs/smb/client/cifsproto.h
> >> > > +++ b/fs/smb/client/cifsproto.h
> >> > > @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(str=
uct cifs_tcon *cifs_tcon);
> >> > >
> >> > >  extern void cifs_close_deferred_file_under_dentry(struct cifs_tco=
n *cifs_tcon,
> >> > >                                 const char *path);
> >> > > +
> >> > > +extern void cifs_mark_open_handles_for_deleted_file(struct cifs_t=
con
> >> > > +                               *cifs_tcon, const char *path);
> >> > > +
> >> > >  extern struct TCP_Server_Info *
> >> > >  cifs_get_tcp_session(struct smb3_fs_context *ctx,
> >> > >                      struct TCP_Server_Info *primary_server);
> >> > > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> >> > > index b75282c204da..91cf4d2df4de 100644
> >> > > --- a/fs/smb/client/file.c
> >> > > +++ b/fs/smb/client/file.c
> >> > > @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct =
cifs_fid *fid, struct file *file,
> >> > >         cfile->uid =3D current_fsuid();
> >> > >         cfile->dentry =3D dget(dentry);
> >> > >         cfile->f_flags =3D file->f_flags;
> >> > > +       cfile->cflags =3D 0;
> >> > >         cfile->invalidHandle =3D false;
> >> > >         cfile->deferred_close_scheduled =3D false;
> >> > >         cfile->tlink =3D cifs_get_tlink(tlink);
> >> > > @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct f=
ile *file)
> >> > >                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =
=3D=3D CIFS_CACHE_RHW_FLG)
> >> > >                     && cinode->lease_granted &&
> >> > >                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->fla=
gs) &&
> >> > > -                   dclose) {
> >> > > +                   dclose && !(cfile->cflags & FILE_DELETED)) {
> >> > >                         if (test_and_clear_bit(CIFS_INO_MODIFIED_A=
TTR, &cinode->flags)) {
> >> > >                                 inode_set_mtime_to_ts(inode,
> >> > >                                                       inode_set_ct=
ime_current(inode));
> >> > > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> >> > > index d02f8ba29cb5..8121b5b1aa22 100644
> >> > > --- a/fs/smb/client/inode.c
> >> > > +++ b/fs/smb/client/inode.c
> >> > > @@ -1900,6 +1900,8 @@ int cifs_unlink(struct inode *dir, struct de=
ntry *dentry)
> >> > >         cifs_inode =3D CIFS_I(dir);
> >> > >         CIFS_I(dir)->time =3D 0;  /* force revalidate of dir as we=
ll */
> >> > >  unlink_out:
> >> > > +       if (rc =3D=3D 0)
> >> > > +               cifs_mark_open_handles_for_deleted_file(tcon, full=
_path);
> >> > >         free_dentry_path(page);
> >> > >         kfree(attrs);
> >> > >         free_xid(xid);
> >> > > diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> >> > > index 0748d7b757b9..8e46dee1a36c 100644
> >> > > --- a/fs/smb/client/misc.c
> >> > > +++ b/fs/smb/client/misc.c
> >> > > @@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct =
cifs_tcon *tcon, const char *path)
> >> > >         free_dentry_path(page);
> >> > >  }
> >> > >
> >> > > +/*
> >> > > + * If a dentry has been deleted, all corresponding open handles s=
hould know that
> >> > > + * so that we do not defer close them.
> >> > > + */
> >> > > +void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tc=
on,
> >> > > +                                            const char *path)
> >> > > +{
> >> > > +       struct cifsFileInfo *cfile;
> >> > > +       void *page;
> >> > > +       const char *full_path;
> >> > > +
> >> > > +       page =3D alloc_dentry_path();
> >> > > +       spin_lock(&tcon->open_file_lock);
> >> > > +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {

Is there a reason why we need to iterate over tcon->openFileList here?
There may be a large number of open files in the tcon.
Why not iterate over cinode->openFileList? That will be a much smaller
list and should cover all the open files that you need. Right?

> >> > > +               full_path =3D build_path_from_dentry(cfile->dentry=
, page);
> >> > > +               if (strcmp(full_path, path) =3D=3D 0)
> >> > > +                       cfile->cflags |=3D FILE_DELETED;
> >> > > +       }
> >> > > +       spin_unlock(&tcon->open_file_lock);
> >> > > +       free_dentry_path(page);
> >> > > +}
> >> > > +
> >> > >  /* parses DFS referral V3 structure
> >> > >   * caller is responsible for freeing target_nodes
> >> > >   * returns:
> >> > > --
> >> > > 2.39.2
> >> > >
> >> > >
> >> >
> >> >
> >> > --
> >> > Thanks,
> >> >
> >> > Steve
> >>
> >>
> >>
> >> --
> >> Regards,
> >> Shyam



--=20
Regards,
Shyam

