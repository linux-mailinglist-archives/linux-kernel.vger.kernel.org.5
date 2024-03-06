Return-Path: <linux-kernel+bounces-93400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A092872F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7CA1C21967
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBC5C5EB;
	Wed,  6 Mar 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnj8J3ud"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E256171BB;
	Wed,  6 Mar 2024 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708982; cv=none; b=NY07NmpSJxqWWSmfxlFQtZRm7zppJBMto+H2z0izFbWboEqskvNXY6jtNL7w1G6G4GIBvKTiGuZRTr1UDqkQuNMbZZB/3UTK5Gwj9MFc0nUjT6dT8cRjWVjvzN/3zlfzzvfaIOQSz90HURTR+fMXcSciEdu7IKdxfMJNk17xDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708982; c=relaxed/simple;
	bh=StweNtPpC0lTWstisxCBeMYC2cNUG3bA8NN1BNOXZNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqA4O8D2DkNaqJqB3Z+TJ0I+wn6M4cgtQeX2LaIOfJEZXC1T1WF4WXclfaJcMrSkMbyJhNA6o4pZZKVz2ueqWxmz6rIaRezlY89J4iOKGS9S9xaH6Z3UPBo0/j24p9T73o2Hb6ojdLpFC+pZoDyEsw/jahnnGqb6gdN9rlZVNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnj8J3ud; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so80103061fa.3;
        Tue, 05 Mar 2024 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709708978; x=1710313778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ao/NqUHnXz0y/dqbjymF0MdeSFoyjq+6regVYQoE+cU=;
        b=Dnj8J3udgAc45/SVevPKC8XUOESWvt984NfoI433eXbBM3/ypY7ctTxC+Oh7q9XjVa
         hwut02QFRNA9NpKT1EU8Q41qcUAlW8ONffMkXmT+P3vNf0E/a3uXh91pR/G3XjH5Bxzb
         z/3rw4J+mStA3eSqinf0fn5PVkIPsQ5fIlWaCx2lwZld81H2MUf/Pkx60xG+bin94M03
         Kcqs0E1jTpd0Rph1SdugYSFHp9E6cwf+AhOCXvPGDMgH1Cca2ev7DuBzs2Ilt+tlCvNM
         LtHf1QHbshUwcTMT8AwmS1erBXnVYEFtoNySA4r0eo2cldV6CZhu8r1z/kOitkdGn9Zt
         Gxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709708978; x=1710313778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ao/NqUHnXz0y/dqbjymF0MdeSFoyjq+6regVYQoE+cU=;
        b=OQjiqZMpYZBNCRT5Y8mQD9eKh5OWQPQvErJVt1k0GAhojedE25KtcH5XlqlmggWY3k
         5m+V+eCJGlKHB/54xDagMV628rRVTIFAnHBRy+q1B2C3gMdGpWJSM7w106EEAbw3VINv
         EvVuk4MPCJzAI6WzzjGfous/7gthW+lYk85V/ZBrqgyjSA6iEB060pNbxrJUsMCp42kb
         XXPvGnQO+7Z291Y0Vf4rYyC+p0ohrVBdpjIuKRcxIKWYiU8s9zJG1J52PR6WSbEYTBkZ
         PaUJ5+bQWrwC8Pka/Qe49C8Q94qAo/LxETMf+P35LegPzxkPZSvC7vgiEK/mwAVoLe/U
         TpLA==
X-Forwarded-Encrypted: i=1; AJvYcCUPFiJdrjJDOKHSWPgZL55WoZ+zTtZ1rGMULQQKkQX6DRgiXf3NcOuHEZf7d5lnhjcYCcZ0Mc4PcfbeDG49euZQfirQSKV39qR91AJyJL5Bb7B6TjhGG+YPuzGqgZtwh+htw5U7tQoocA==
X-Gm-Message-State: AOJu0Yx398rBsW9hfzwnBPdG5momNn25EUCSWw71+THoMLeaU3f0oxg1
	y8p452x+e0WDnmkKAh0vdI0fO3PxyQj1G+UZmqQMPbxHovDmUWSQPd+7FiVftcA6tLkbfEzD3Nz
	CmvF83H3yhjKWOcQ8kJhaMZEQwXs=
X-Google-Smtp-Source: AGHT+IHEXGZGzM810gptGkkjCkQG6oalmgYTpxBuR9tExjJMf3LON51g7QyuOvfN3tMBE7e75vN8ehUOaY5/mnhRqbY=
X-Received: by 2002:a2e:86c8:0:b0:2d2:e784:abc2 with SMTP id
 n8-20020a2e86c8000000b002d2e784abc2mr2836590ljj.33.1709708977667; Tue, 05 Mar
 2024 23:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com> <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 6 Mar 2024 01:09:25 -0600
Message-ID: <CAH2r5mtt0aBrWCK3QgkHv7HHv0wpRHeOVM=5aXr=E5MFsmfFfg@mail.gmail.com>
Subject: Re: [PATCH 2/3] smb: client: do not defer close open handles to
 deleted files
To: meetakshisetiyaoss@gmail.com
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged the three patches into cifs-2.6.git pending testing but I had
to rebase this one.  I also had to rebase one of Paulo's patches "smb:
client: move most of reparse point handling code to common file"

If you see anything wrong with the minor rebase let me know.

On Tue, Mar 5, 2024 at 9:44=E2=80=AFPM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> When a file/dentry has been deleted before closing all its open
> handles, currently, closing them can add them to the deferred
> close list. This can lead to problems in creating file with the
> same name when the file is re-created before the deferred close
> completes. This issue was seen while reusing a client's already
> existing lease on a file for compound operations and xfstest 591
> failed because of the deferred close handle that remained valid
> even after the file was deleted and was being reused to create a
> file with the same name. The server in this case returns an error
> on open with STATUS_DELETE_PENDING. Recreating the file would
> fail till the deferred handles are closed (duration specified in
> closetimeo).
>
> This patch fixes the issue by flagging all open handles for the
> deleted file (file path to be precise) by setting
> status_file_deleted to true in the cifsFileInfo structure. As per
> the information classes specified in MS-FSCC, SMB2 query info
> response from the server has a DeletePending field, set to true
> to indicate that deletion has been requested on that file. If
> this is the case, flag the open handles for this file too.
>
> When doing close in cifs_close for each of these handles, check the
> value of this boolean field and do not defer close these handles
> if the corresponding filepath has been deleted.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/cifsglob.h  |  1 +
>  fs/smb/client/cifsproto.h |  4 ++++
>  fs/smb/client/file.c      |  3 ++-
>  fs/smb/client/inode.c     | 28 +++++++++++++++++++++++++---
>  fs/smb/client/misc.c      | 34 ++++++++++++++++++++++++++++++++++
>  fs/smb/client/smb2inode.c |  9 ++++++++-
>  6 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 50f7e47c2229..a88c8328b29c 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -1417,6 +1417,7 @@ struct cifsFileInfo {
>         bool invalidHandle:1;   /* file closed via session abend */
>         bool swapfile:1;
>         bool oplock_break_cancelled:1;
> +       bool status_file_deleted:1; /* file has been deleted */
>         unsigned int oplock_epoch; /* epoch from the lease break */
>         __u32 oplock_level; /* oplock/lease level from the lease break */
>         int count;
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index ef98c840791f..1f46e0db6e92 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct cif=
s_tcon *cifs_tcon);
>
>  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs=
_tcon,
>                                 const char *path);
> +
> +extern void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
> +                               const char *path);
> +
>  extern struct TCP_Server_Info *
>  cifs_get_tcp_session(struct smb3_fs_context *ctx,
>                      struct TCP_Server_Info *primary_server);
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b75282c204da..46951f403d31 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fi=
d *fid, struct file *file,
>         cfile->uid =3D current_fsuid();
>         cfile->dentry =3D dget(dentry);
>         cfile->f_flags =3D file->f_flags;
> +       cfile->status_file_deleted =3D false;
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
> +                   dclose && !(cfile->status_file_deleted)) {
>                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &c=
inode->flags)) {
>                                 inode_set_mtime_to_ts(inode,
>                                                       inode_set_ctime_cur=
rent(inode));
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 3073eac989ea..3242e3b74386 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -893,6 +893,9 @@ cifs_get_file_info(struct file *filp)
>         struct cifsFileInfo *cfile =3D filp->private_data;
>         struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
>         struct TCP_Server_Info *server =3D tcon->ses->server;
> +       struct dentry *dentry =3D filp->f_path.dentry;
> +       void *page =3D alloc_dentry_path();
> +       const unsigned char *path;
>
>         if (!server->ops->query_file_info)
>                 return -ENOSYS;
> @@ -907,7 +910,14 @@ cifs_get_file_info(struct file *filp)
>                         data.symlink =3D true;
>                         data.reparse.tag =3D IO_REPARSE_TAG_SYMLINK;
>                 }
> +               path =3D build_path_from_dentry(dentry, page);
> +               if (IS_ERR(path)) {
> +                       free_dentry_path(page);
> +                       return PTR_ERR(path);
> +               }
>                 cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
> +               if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
> +                       cifs_mark_open_handles_for_deleted_file(inode, pa=
th);
>                 break;
>         case -EREMOTE:
>                 cifs_create_junction_fattr(&fattr, inode->i_sb);
> @@ -937,6 +947,7 @@ cifs_get_file_info(struct file *filp)
>         rc =3D cifs_fattr_to_inode(inode, &fattr);
>  cgfi_exit:
>         cifs_free_open_info(&data);
> +       free_dentry_path(page);
>         free_xid(xid);
>         return rc;
>  }
> @@ -1075,6 +1086,7 @@ static int reparse_info_to_fattr(struct cifs_open_i=
nfo_data *data,
>         struct kvec rsp_iov, *iov =3D NULL;
>         int rsp_buftype =3D CIFS_NO_BUFFER;
>         u32 tag =3D data->reparse.tag;
> +       struct inode *inode =3D NULL;
>         int rc =3D 0;
>
>         if (!tag && server->ops->query_reparse_point) {
> @@ -1114,8 +1126,12 @@ static int reparse_info_to_fattr(struct cifs_open_=
info_data *data,
>
>         if (tcon->posix_extensions)
>                 smb311_posix_info_to_fattr(fattr, data, sb);
> -       else
> +       else {
>                 cifs_open_info_to_fattr(fattr, data, sb);
> +               inode =3D cifs_iget(sb, fattr);
> +               if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
> +                       cifs_mark_open_handles_for_deleted_file(inode, fu=
ll_path);
> +       }
>  out:
>         fattr->cf_cifstag =3D data->reparse.tag;
>         free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
> @@ -1170,6 +1186,8 @@ static int cifs_get_fattr(struct cifs_open_info_dat=
a *data,
>                                                    full_path, fattr);
>                 } else {
>                         cifs_open_info_to_fattr(fattr, data, sb);
> +                       if (fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
> +                               cifs_mark_open_handles_for_deleted_file(*=
inode, full_path);
>                 }
>                 break;
>         case -EREMOTE:
> @@ -1850,16 +1868,20 @@ int cifs_unlink(struct inode *dir, struct dentry =
*dentry)
>
>  psx_del_no_retry:
>         if (!rc) {
> -               if (inode)
> +               if (inode) {
> +                       cifs_mark_open_handles_for_deleted_file(inode, fu=
ll_path);
>                         cifs_drop_nlink(inode);
> +               }
>         } else if (rc =3D=3D -ENOENT) {
>                 d_drop(dentry);
>         } else if (rc =3D=3D -EBUSY) {
>                 if (server->ops->rename_pending_delete) {
>                         rc =3D server->ops->rename_pending_delete(full_pa=
th,
>                                                                 dentry, x=
id);
> -                       if (rc =3D=3D 0)
> +                       if (rc =3D=3D 0) {
> +                               cifs_mark_open_handles_for_deleted_file(i=
node, full_path);
>                                 cifs_drop_nlink(inode);
> +                       }
>                 }
>         } else if ((rc =3D=3D -EACCES) && (dosattr =3D=3D 0) && inode) {
>                 attrs =3D kzalloc(sizeof(*attrs), GFP_KERNEL);
> diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> index 0748d7b757b9..9428a0db7718 100644
> --- a/fs/smb/client/misc.c
> +++ b/fs/smb/client/misc.c
> @@ -853,6 +853,40 @@ cifs_close_deferred_file_under_dentry(struct cifs_tc=
on *tcon, const char *path)
>         free_dentry_path(page);
>  }
>
> +/*
> + * If a dentry has been deleted, all corresponding open handles should k=
now that
> + * so that we do not defer close them.
> + */
> +void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
> +                                            const char *path)
> +{
> +       struct cifsFileInfo *cfile;
> +       void *page;
> +       const char *full_path;
> +       struct cifsInodeInfo *cinode =3D CIFS_I(inode);
> +
> +       page =3D alloc_dentry_path();
> +       spin_lock(&cinode->open_file_lock);
> +
> +       /*
> +        * note: we need to construct path from dentry and compare only i=
f the
> +        * inode has any hardlinks. When number of hardlinks is 1, we can=
 just
> +        * mark all open handles since they are going to be from the same=
 file.
> +        */
> +       if (inode->i_nlink > 1) {
> +               list_for_each_entry(cfile, &cinode->openFileList, flist) =
{
> +                       full_path =3D build_path_from_dentry(cfile->dentr=
y, page);
> +                       if (!IS_ERR(full_path) && strcmp(full_path, path)=
 =3D=3D 0)
> +                               cfile->status_file_deleted =3D true;
> +               }
> +       } else {
> +               list_for_each_entry(cfile, &cinode->openFileList, flist)
> +                       cfile->status_file_deleted =3D true;
> +       }
> +       spin_unlock(&cinode->open_file_lock);
> +       free_dentry_path(page);
> +}
> +
>  /* parses DFS referral V3 structure
>   * caller is responsible for freeing target_nodes
>   * returns:
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 69f3442c5b96..429d83d31280 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -561,8 +561,15 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>                 case SMB2_OP_DELETE:
>                         if (rc)
>                                 trace_smb3_delete_err(xid,  ses->Suid, tc=
on->tid, rc);
> -                       else
> +                       else {
> +                               /*
> +                                * If dentry (hence, inode) is NULL, leas=
e break is going to
> +                                * take care of degrading leases on handl=
es for deleted files.
> +                                */
> +                               if (inode)
> +                                       cifs_mark_open_handles_for_delete=
d_file(inode, full_path);
>                                 trace_smb3_delete_done(xid, ses->Suid, tc=
on->tid);
> +                       }
>                         break;
>                 case SMB2_OP_MKDIR:
>                         if (rc)
> --
> 2.39.2
>
>


--=20
Thanks,

Steve

