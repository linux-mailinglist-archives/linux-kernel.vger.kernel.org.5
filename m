Return-Path: <linux-kernel+bounces-60290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A98502B4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D827A287C61
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89412E7B;
	Sat, 10 Feb 2024 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJVjBK4v"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500DCA7F;
	Sat, 10 Feb 2024 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707544783; cv=none; b=disIb8uoq1Gj1FVgrEFwK+Xaqexpl+bunukSeDZLB+OeMdBsNkShZ+VvExMjDF43gi8KsEKFZjLLSDBAr1/rZ7M4yTlDW8iD7Oml7qa64IoB/rohHanUXG5hKZh91oMJ6L3Hbd0YtAdte3SUJ6cD81BoZU4SuwdyzV24zumdOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707544783; c=relaxed/simple;
	bh=y9kcuSiOiwy8MICB6Ar5PCUqfBTyww2F/Q1Q+SkDi0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxjGy49A5vYcjrtmKB14CFZ2TE4pZijIunw7S3DbgQpLMoxOWzfdXfKbTJiHH43hajPd/k2Ol/+t9j5WlmqL1m3d0heoEpBdUt9TQBqIW0rtDz1qDHhYDPWL9wtNztYP9Ggdj78VGXW/0tavnUnSh9HqpVXKeWXyzzRmTJjTVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJVjBK4v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0a0e40672so15659121fa.0;
        Fri, 09 Feb 2024 21:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707544779; x=1708149579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wek0JZ73neh6GWKWE+h3Kw/oFlmB85kyLUmRA1c2rc4=;
        b=GJVjBK4vtckt6paP9jQAnbyXdy+rQqyAlAi1zSE75YFxSpEaiHa8zk1AWCxJ+3ib7L
         VFbbt2tYCsadC4hwUjv2M1tqdrhzaLPrlhHkKD2e1IJLAPPvB2cdfz6mP5PBRtS2CO/t
         dtgADBB5U/p7Tc0EstPKx0bQGUOaLhQnDhFggdpgwlFZhDUbVdI9vy0iUJDJ+u++ZYiX
         jbSM4KyTnq6mh9ZAHzTS5W6I8X2wVqHExMBYZ1SBS6QodrvZfTMNxGHwpOjTGZPwupUZ
         YVnUSEkJJOJf2rSD67rBPYOgRDBGCzQbebJ1pWyA7DLEakhHJMtbuQusGT8gNgY6AdE5
         oh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707544779; x=1708149579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wek0JZ73neh6GWKWE+h3Kw/oFlmB85kyLUmRA1c2rc4=;
        b=ji/F4gojVef2GCsnpKta5KEpyMNEQqSD68QXVg5OOgZlCbiOUQGUScDnzKscZ9/9V5
         TCCYbTECcvjv0LTL9BVw8Cz6K1JysmMISjPT/ni4Ylr06SUMzBp8qNHVstqtsOd3ZQbr
         r3FwBi5C3dj8vviqteKjuEOnwslQGe+rY+uRC4hQ4kyB3+KAZ7veCPvPxwmFBvKiiSkX
         s8AALrIVeqPT60HMOOQ2XoWC0xiIJ8E+S3XTfWUHmNIZXAGSbN8MzB1u+s3i6j25YnKx
         HyckDqOYMXQxtyr0G8mup3BDX0z3p/2UGE31Nkbm693AGm87i8dqbN9jwi9sr6odQFn8
         3BoA==
X-Forwarded-Encrypted: i=1; AJvYcCVNZt0LpscUI4Vn/Fcg6e3HVqQl/eXapF3R18YKNhcQxU5lOzlRSCJKyTQqrONV8dqo3ublzPrlNooNC25vDTuXDWNbxzxe14o4iqehy9cmLrDzkSrGJ5AuPYn5W63o27J6/S/gs9Lfcg==
X-Gm-Message-State: AOJu0YwpjJ9SlIunjWKQVyzhvKknUiDzGiWUs4TOPWiodxhSY7+xQSzS
	Ay7TF5sS3+rV80tY+deVcRED0x9HbNZFxS5YmePX4dkLWQiUcJVLVlEJ2zsvHPevI5otIjdMa+B
	eE1IcGMFEMzSRFfuQYfctHHp/6Ao=
X-Google-Smtp-Source: AGHT+IGUheCrBWLlcPoGm3XubVoPIaG12TmgizWAJUUFkm986wGle/8z1Qj10eQ/1UYDB1ycYIG+up5tXrPODBrikPU=
X-Received: by 2002:a2e:bc08:0:b0:2cf:57d7:6d35 with SMTP id
 b8-20020a2ebc08000000b002cf57d76d35mr1332543ljf.10.1707544778728; Fri, 09 Feb
 2024 21:59:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 9 Feb 2024 23:59:26 -0600
Message-ID: <CAH2r5mtdebsVFbOoQeYYL79GVXe0wn=GfdgVE1RkQrnowHOO5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] smb: client: do not defer close open handles to
 deleted files
To: meetakshisetiyaoss@gmail.com
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

could we make the "file_is_deleted" a boolean instead of using up more
space making it an int?

Alternatively - would it be possible to simply look at the file
attributes to see if it was marked as deleted (ie we should already be
setting ATTR_DELETE_ON_CLOSE)

On Fri, Feb 9, 2024 at 7:17=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> When a file/dentry has been deleted before closing all its open handles,
> currently, closing them can add them to the deferred close list. This can
> lead to problems in creating file with the same name when the file is
> re-created before the deferred close completes. This issue was seen while
> reusing a client's already existing lease on a file for compound operatio=
ns
> and xfstest 591 failed because of the deferred close handle that remained
> valid even after the file was deleted and was being reused to create a fi=
le
> with the same name. The server in this case returns an error on open with
> STATUS_DELETE_PENDING. Recreating the file would fail till the deferred
> handles are closed (duration specified in closetimeo).
>
> This patch fixes the issue by flagging all open handles for the deleted
> file (file path to be precise) with FILE_DELETED at the end of the unlink
> operation. A new field cflags has been introduced in the cifsFileInfo
> structure to set the FILE_DELETED flag without interfering with the f_fla=
gs
> field. This cflags field could be useful in the future for setting more
> flags specific to cfile.
> When doing close in cifs_close for each of these handles, check the
> FILE_DELETED flag and do not defer close these handles if the correspondi=
ng
> filepath has been deleted.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/cifsglob.h  |  3 +++
>  fs/smb/client/cifsproto.h |  4 ++++
>  fs/smb/client/file.c      |  3 ++-
>  fs/smb/client/inode.c     |  2 ++
>  fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
>  5 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 16befff4cbb4..f6b4acdcdeb3 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -1398,6 +1398,8 @@ struct cifs_fid_locks {
>         struct list_head locks;         /* locks held by fid above */
>  };
>
> +#define FILE_DELETED 00000001
> +
>  struct cifsFileInfo {
>         /* following two lists are protected by tcon->open_file_lock */
>         struct list_head tlist; /* pointer to next fid owned by tcon */
> @@ -1413,6 +1415,7 @@ struct cifsFileInfo {
>         struct dentry *dentry;
>         struct tcon_link *tlink;
>         unsigned int f_flags;
> +       unsigned int cflags;    /* flags for this file */
>         bool invalidHandle:1;   /* file closed via session abend */
>         bool swapfile:1;
>         bool oplock_break_cancelled:1;
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index a841bf4967fa..f995b766b177 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct cif=
s_tcon *cifs_tcon);
>
>  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs=
_tcon,
>                                 const char *path);
> +
> +extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon
> +                               *cifs_tcon, const char *path);
> +
>  extern struct TCP_Server_Info *
>  cifs_get_tcp_session(struct smb3_fs_context *ctx,
>                      struct TCP_Server_Info *primary_server);
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b75282c204da..91cf4d2df4de 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fi=
d *fid, struct file *file,
>         cfile->uid =3D current_fsuid();
>         cfile->dentry =3D dget(dentry);
>         cfile->f_flags =3D file->f_flags;
> +       cfile->cflags =3D 0;
>         cfile->invalidHandle =3D false;
>         cfile->deferred_close_scheduled =3D false;
>         cfile->tlink =3D cifs_get_tlink(tlink);
> @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *fi=
le)
>                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D CI=
FS_CACHE_RHW_FLG)
>                     && cinode->lease_granted &&
>                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
> -                   dclose) {
> +                   dclose && !(cfile->cflags & FILE_DELETED)) {
>                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &c=
inode->flags)) {
>                                 inode_set_mtime_to_ts(inode,
>                                                       inode_set_ctime_cur=
rent(inode));
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index d02f8ba29cb5..8121b5b1aa22 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1900,6 +1900,8 @@ int cifs_unlink(struct inode *dir, struct dentry *d=
entry)
>         cifs_inode =3D CIFS_I(dir);
>         CIFS_I(dir)->time =3D 0;  /* force revalidate of dir as well */
>  unlink_out:
> +       if (rc =3D=3D 0)
> +               cifs_mark_open_handles_for_deleted_file(tcon, full_path);
>         free_dentry_path(page);
>         kfree(attrs);
>         free_xid(xid);
> diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> index 0748d7b757b9..8e46dee1a36c 100644
> --- a/fs/smb/client/misc.c
> +++ b/fs/smb/client/misc.c
> @@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct cifs_tc=
on *tcon, const char *path)
>         free_dentry_path(page);
>  }
>
> +/*
> + * If a dentry has been deleted, all corresponding open handles should k=
now that
> + * so that we do not defer close them.
> + */
> +void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon,
> +                                            const char *path)
> +{
> +       struct cifsFileInfo *cfile;
> +       void *page;
> +       const char *full_path;
> +
> +       page =3D alloc_dentry_path();
> +       spin_lock(&tcon->open_file_lock);
> +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
> +               full_path =3D build_path_from_dentry(cfile->dentry, page)=
;
> +               if (strcmp(full_path, path) =3D=3D 0)
> +                       cfile->cflags |=3D FILE_DELETED;
> +       }
> +       spin_unlock(&tcon->open_file_lock);
> +       free_dentry_path(page);
> +}
> +
>  /* parses DFS referral V3 structure
>   * caller is responsible for freeing target_nodes
>   * returns:
> --
> 2.39.2
>
>


--=20
Thanks,

Steve

