Return-Path: <linux-kernel+bounces-93309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2F872DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8699A1F2622A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F915E97;
	Wed,  6 Mar 2024 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPOw+uia"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E417EF;
	Wed,  6 Mar 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698515; cv=none; b=Khtq6bB9lqg8cv7Tnh2yD35i7EGFm3IkHU1rp2NkQ7p7cwxn7uO6RrWGHs37JUCooFfu06ADycu3gEOacYhM3C3lKYtFASewOAU6uWcnqLtmM8r7ydIJRbzp1h/1e5bfw1ZKniSKEYIgJEbqJY3fHUmK/A/u44ykrcICgC57bTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698515; c=relaxed/simple;
	bh=/jhrTBxLSLvzECLjF2rywVcOsK8mUFVHiMFt9+NPgXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6FMT9Rpe/W4e/yJl+F6Hh2ofnvy3uijY2Hr7h0CreBBTqDSpYWev3PcDVDCz6iz5WjqWqGlSKH8xnuI0ZT+HgirFaWjwG2BmErPf4bnBBGSPSYem4imIA2aGzTVFJ4j50MMnGDmZ80MJTL4Fb+f4fNoOz63u0ZfVnNeTjNrYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPOw+uia; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d28e465655so97924621fa.0;
        Tue, 05 Mar 2024 20:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709698511; x=1710303311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrOuO6D3eZC9zhgMmTM97Ln7XLUrDPnl3GyRcD94bss=;
        b=GPOw+uiaFDcCrnZZHsGW3ayp9gVPHpha09rmjAs9PBBWMJWnaIuCaiuFA0S5mqVajs
         v0aK4Vcba6hXM/zILxRlmhWbsLEOmhHixnQgHk2299W9XxaafnqfMiQ28PJaOCmhBRFM
         3qFyjMul8a04CC6+fDDuZtvEbb9KmN8o19pL/Uy/tFtcCjdOBR5GZOe/6wOtnNjqhiYT
         ohjtarpIUzpZYJPH2Z7OrCm6z2/RF1LlIY1wpfsFZ3zDa2KagVvXyD9ycHJSiIfDNmYK
         fJMM6D+tye/OkhjOcIh9eyZNbkpZIUeWI+s5j6QpKzHl01nbuNb/Rj2XMFbPX8E/vGwU
         aPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698511; x=1710303311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrOuO6D3eZC9zhgMmTM97Ln7XLUrDPnl3GyRcD94bss=;
        b=mSWggE+n2K8pmTdPbZYOerTSCOan2grxtzmTo+N2riovr59C2KDU17exBJOE4NJMLZ
         oIJwrpoyWN3E1xcyeZ4OnkZBg0PbEaUgJo3PX4Jff6K62H96cqAFwium7rbJwDd7JqNe
         O5XTqHPSh9bXudJI7OOLT4KOYxeruAlqeypuU+QhGLHNozAS1Jv6V5QRESJig9QD3z87
         BgJ/qiac+Lo14eYX8UrequIn7cBJnxQ462ptvFRNtulZSdC4rgev5wBhWYRlKJyDjksl
         MvxHEaSSKKHpCkSjV0jfZyVhVc01dPrp6leHfywYZ8xd2S/NHF9NfJuYN9KmpxZ2YPFf
         X+DA==
X-Forwarded-Encrypted: i=1; AJvYcCUe+gaUqTp+o+d18Ofn+MgnG+Xj8130bUxFKmCM2gbrvMKXhmWBXB0KWT5PaZp0JooJbeY0Lw+0FmUbYs8p2VJ+XcwourCAEwo4YcYuNKTy8NesfneiJATxQzHSVac/wgGlZ9IxtZjadQ==
X-Gm-Message-State: AOJu0Yy7TpWQrz9RVML8SBZgRz58mfh1LEyXkFNOuio6MA12ycIAWMr+
	qRAvR0tFTaXjDF5yo8YMW8HXTGTJxaIbfyuJJqabf9u+8munGayX+InqoZ50UP/MRX0GI1ZufeB
	T4RDXM9421Dy/ESnDM01tT0MMzjQ=
X-Google-Smtp-Source: AGHT+IH9mbzqKqaYzBZNNjANdsO7xsBhKC8ztjZRJTP1CursUiQW/cCLxc8qyDohT/l/3LVuShVyWaIQXPIO6iJSSSY=
X-Received: by 2002:ac2:59c5:0:b0:513:4e6a:b40f with SMTP id
 x5-20020ac259c5000000b005134e6ab40fmr2477739lfn.47.1709698510510; Tue, 05 Mar
 2024 20:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 6 Mar 2024 09:44:58 +0530
Message-ID: <CAFTVevUPYBO8vgFY3+yYuJYf4TnwMFk9JHPfAa+ZJQLDEEVHeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] smb: client: reuse file lease key in compound operations
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On its own, the patch is expected to regress xfstests generic 013,
002 and 591.

The fix for 591 is in part 2 of this patch series
https://lore.kernel.org/all/20240306034353.190039-2-meetakshisetiyaoss@gmai=
l.com/

The fix for 002 and 013 is in part 3 of this patch series
https://lore.kernel.org/all/20240306034353.190039-3-meetakshisetiyaoss@gmai=
l.com/

On Wed, Mar 6, 2024 at 9:13=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> Currently, when a rename, unlink or set path size compound operation
> is requested on a file that has a lot of dirty pages to be written
> to the server, we do not send the lease key for these requests. As a
> result, the server can assume that this request is from a new client, and
> send a lease break notification to the same client, on the same
> connection. As a response to the lease break, the client can consume
> several credits to write the dirty pages to the server. Depending on the
> server's credit grant implementation, the server can stop granting more
> credits to this connection, and this can cause a deadlock (which can only
> be resolved when the lease timer on the server expires).
> One of the problems here is that the client is sending no lease key,
> even if it has a lease for the file. This patch fixes the problem by
> reusing the existing lease key on the file for rename, unlink and set pat=
h
> size compound operations so that the client does not break its own lease.
>
> A very trivial example could be a set of commands by a client that
> maintains open handle (for write) to a file and then tries to copy the
> contents of that file to another one, eg.,
>
> tail -f /dev/null > myfile &
> mv myfile myfile2
>
> Presently, the network capture on the client shows that the move (or
> rename) would trigger a lease break on the same client, for the same file=
.
> With the lease key reused, the lease break request-response overhead is
> eliminated, thereby reducing the roundtrips performed for this set of
> operations.
>
> The patch fixes the bug described above and also provides perf benefit.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/cifsglob.h  |  5 ++--
>  fs/smb/client/cifsproto.h |  6 +++--
>  fs/smb/client/cifssmb.c   |  4 ++--
>  fs/smb/client/inode.c     | 10 ++++----
>  fs/smb/client/smb2inode.c | 48 ++++++++++++++++++++++++---------------
>  fs/smb/client/smb2proto.h |  6 +++--
>  6 files changed, 48 insertions(+), 31 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 16befff4cbb4..50f7e47c2229 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -371,7 +371,8 @@ struct smb_version_operations {
>                             struct cifs_open_info_data *data);
>         /* set size by path */
>         int (*set_path_size)(const unsigned int, struct cifs_tcon *,
> -                            const char *, __u64, struct cifs_sb_info *, =
bool);
> +                            const char *, __u64, struct cifs_sb_info *, =
bool,
> +                                struct dentry *);
>         /* set size by file handle */
>         int (*set_file_size)(const unsigned int, struct cifs_tcon *,
>                              struct cifsFileInfo *, __u64, bool);
> @@ -401,7 +402,7 @@ struct smb_version_operations {
>                      struct cifs_sb_info *);
>         /* unlink file */
>         int (*unlink)(const unsigned int, struct cifs_tcon *, const char =
*,
> -                     struct cifs_sb_info *);
> +                     struct cifs_sb_info *, struct dentry *);
>         /* open, rename and delete file */
>         int (*rename_pending_delete)(const char *, struct dentry *,
>                                      const unsigned int);
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index a841bf4967fa..ef98c840791f 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -402,7 +402,8 @@ extern int CIFSSMBSetFileDisposition(const unsigned i=
nt xid,
>                                      __u32 pid_of_opener);
>  extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
>                          const char *file_name, __u64 size,
> -                        struct cifs_sb_info *cifs_sb, bool set_allocatio=
n);
> +                        struct cifs_sb_info *cifs_sb, bool set_allocatio=
n,
> +                        struct dentry *dentry);
>  extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *=
tcon,
>                               struct cifsFileInfo *cfile, __u64 size,
>                               bool set_allocation);
> @@ -438,7 +439,8 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, s=
truct cifs_tcon *tcon,
>                         const struct nls_table *nls_codepage,
>                         int remap_special_chars);
>  extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon=
,
> -                         const char *name, struct cifs_sb_info *cifs_sb)=
;
> +                         const char *name, struct cifs_sb_info *cifs_sb,
> +                         struct dentry *dentry);
>  int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
>                   struct dentry *source_dentry,
>                   const char *from_name, const char *to_name,
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 01e89070df5a..301189ee1335 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -738,7 +738,7 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_=
tcon *tcon,
>
>  int
>  CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const cha=
r *name,
> -              struct cifs_sb_info *cifs_sb)
> +              struct cifs_sb_info *cifs_sb, struct dentry *dentry)
>  {
>         DELETE_FILE_REQ *pSMB =3D NULL;
>         DELETE_FILE_RSP *pSMBr =3D NULL;
> @@ -4993,7 +4993,7 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct =
cifs_tcon *tcon,
>  int
>  CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
>               const char *file_name, __u64 size, struct cifs_sb_info *cif=
s_sb,
> -             bool set_allocation)
> +             bool set_allocation, struct dentry *dentry)
>  {
>         struct smb_com_transaction2_spi_req *pSMB =3D NULL;
>         struct smb_com_transaction2_spi_rsp *pSMBr =3D NULL;
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index d02f8ba29cb5..3073eac989ea 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1846,7 +1846,7 @@ int cifs_unlink(struct inode *dir, struct dentry *d=
entry)
>                 goto psx_del_no_retry;
>         }
>
> -       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb);
> +       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry)=
;
>
>  psx_del_no_retry:
>         if (!rc) {
> @@ -2797,7 +2797,7 @@ void cifs_setsize(struct inode *inode, loff_t offse=
t)
>
>  static int
>  cifs_set_file_size(struct inode *inode, struct iattr *attrs,
> -                  unsigned int xid, const char *full_path)
> +                  unsigned int xid, const char *full_path, struct dentry=
 *dentry)
>  {
>         int rc;
>         struct cifsFileInfo *open_file;
> @@ -2848,7 +2848,7 @@ cifs_set_file_size(struct inode *inode, struct iatt=
r *attrs,
>          */
>         if (server->ops->set_path_size)
>                 rc =3D server->ops->set_path_size(xid, tcon, full_path,
> -                                               attrs->ia_size, cifs_sb, =
false);
> +                                               attrs->ia_size, cifs_sb, =
false, dentry);
>         else
>                 rc =3D -ENOSYS;
>         cifs_dbg(FYI, "SetEOF by path (setattrs) rc =3D %d\n", rc);
> @@ -2938,7 +2938,7 @@ cifs_setattr_unix(struct dentry *direntry, struct i=
attr *attrs)
>         rc =3D 0;
>
>         if (attrs->ia_valid & ATTR_SIZE) {
> -               rc =3D cifs_set_file_size(inode, attrs, xid, full_path);
> +               rc =3D cifs_set_file_size(inode, attrs, xid, full_path, d=
irentry);
>                 if (rc !=3D 0)
>                         goto out;
>         }
> @@ -3105,7 +3105,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct=
 iattr *attrs)
>         }
>
>         if (attrs->ia_valid & ATTR_SIZE) {
> -               rc =3D cifs_set_file_size(inode, attrs, xid, full_path);
> +               rc =3D cifs_set_file_size(inode, attrs, xid, full_path, d=
irentry);
>                 if (rc !=3D 0)
>                         goto cifs_setattr_exit;
>         }
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 05818cd6d932..69f3442c5b96 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -98,7 +98,7 @@ static int smb2_compound_op(const unsigned int xid, str=
uct cifs_tcon *tcon,
>                             __u32 desired_access, __u32 create_dispositio=
n,
>                             __u32 create_options, umode_t mode, struct kv=
ec *in_iov,
>                             int *cmds, int num_cmds, struct cifsFileInfo =
*cfile,
> -                           struct kvec *out_iov, int *out_buftype)
> +                           struct kvec *out_iov, int *out_buftype, struc=
t dentry *dentry)
>  {
>
>         struct reparse_data_buffer *rbuf;
> @@ -115,6 +115,7 @@ static int smb2_compound_op(const unsigned int xid, s=
truct cifs_tcon *tcon,
>         int resp_buftype[MAX_COMPOUND];
>         struct smb2_query_info_rsp *qi_rsp =3D NULL;
>         struct cifs_open_info_data *idata;
> +       struct inode *inode =3D NULL;
>         int flags =3D 0;
>         __u8 delete_pending[8] =3D {1, 0, 0, 0, 0, 0, 0, 0};
>         unsigned int size[2];
> @@ -152,6 +153,15 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>                 goto finished;
>         }
>
> +       /* if there is an existing lease, reuse it */
> +       if (dentry) {
> +               inode =3D d_inode(dentry);
> +               if (CIFS_I(inode)->lease_granted && server->ops->get_leas=
e_key) {
> +                       oplock =3D SMB2_OPLOCK_LEVEL_LEASE;
> +                       server->ops->get_lease_key(inode, &fid);
> +               }
> +       }
> +
>         vars->oparms =3D (struct cifs_open_parms) {
>                 .tcon =3D tcon,
>                 .path =3D full_path,
> @@ -747,7 +757,7 @@ int smb2_query_path_info(const unsigned int xid,
>         rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                               FILE_READ_ATTRIBUTES, FILE_OPEN,
>                               create_options, ACL_NO_MODE, in_iov,
> -                             cmds, 1, cfile, out_iov, out_buftype);
> +                             cmds, 1, cfile, out_iov, out_buftype, NULL)=
;
>         hdr =3D out_iov[0].iov_base;
>         /*
>          * If first iov is unset, then SMB session was dropped or we've g=
ot a
> @@ -779,7 +789,7 @@ int smb2_query_path_info(const unsigned int xid,
>                 rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                       FILE_READ_ATTRIBUTES, FILE_OPEN,
>                                       create_options, ACL_NO_MODE, in_iov=
,
> -                                     cmds, num_cmds, cfile, NULL, NULL);
> +                                     cmds, num_cmds, cfile, NULL, NULL, =
NULL);
>                 break;
>         case -EREMOTE:
>                 break;
> @@ -811,7 +821,7 @@ smb2_mkdir(const unsigned int xid, struct inode *pare=
nt_inode, umode_t mode,
>                                 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
>                                 CREATE_NOT_FILE, mode,
>                                 NULL, &(int){SMB2_OP_MKDIR}, 1,
> -                               NULL, NULL, NULL);
> +                               NULL, NULL, NULL, NULL);
>  }
>
>  void
> @@ -836,7 +846,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *n=
ame,
>                                  FILE_WRITE_ATTRIBUTES, FILE_CREATE,
>                                  CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
>                                  &(int){SMB2_OP_SET_INFO}, 1,
> -                                cfile, NULL, NULL);
> +                                cfile, NULL, NULL, NULL);
>         if (tmprc =3D=3D 0)
>                 cifs_i->cifsAttrs =3D dosattrs;
>  }
> @@ -850,25 +860,26 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon=
 *tcon, const char *name,
>                                 DELETE, FILE_OPEN, CREATE_NOT_FILE,
>                                 ACL_NO_MODE, NULL,
>                                 &(int){SMB2_OP_RMDIR}, 1,
> -                               NULL, NULL, NULL);
> +                               NULL, NULL, NULL, NULL);
>  }
>
>  int
>  smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *=
name,
> -           struct cifs_sb_info *cifs_sb)
> +           struct cifs_sb_info *cifs_sb, struct dentry *dentry)
>  {
>         return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OP=
EN,
>                                 CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POI=
NT,
>                                 ACL_NO_MODE, NULL,
>                                 &(int){SMB2_OP_DELETE}, 1,
> -                               NULL, NULL, NULL);
> +                               NULL, NULL, NULL, dentry);
>  }
>
>  static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *=
tcon,
>                               const char *from_name, const char *to_name,
>                               struct cifs_sb_info *cifs_sb,
>                               __u32 create_options, __u32 access,
> -                             int command, struct cifsFileInfo *cfile)
> +                             int command, struct cifsFileInfo *cfile,
> +                                 struct dentry *dentry)
>  {
>         struct kvec in_iov;
>         __le16 *smb2_to_name =3D NULL;
> @@ -883,7 +894,7 @@ static int smb2_set_path_attr(const unsigned int xid,=
 struct cifs_tcon *tcon,
>         in_iov.iov_len =3D 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_M=
AX);
>         rc =3D smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
>                               FILE_OPEN, create_options, ACL_NO_MODE,
> -                             &in_iov, &command, 1, cfile, NULL, NULL);
> +                             &in_iov, &command, 1, cfile, NULL, NULL, de=
ntry);
>  smb2_rename_path:
>         kfree(smb2_to_name);
>         return rc;
> @@ -902,7 +913,7 @@ int smb2_rename_path(const unsigned int xid,
>         cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfi=
le);
>
>         return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
> -                                 co, DELETE, SMB2_OP_RENAME, cfile);
> +                                 co, DELETE, SMB2_OP_RENAME, cfile, sour=
ce_dentry);
>  }
>
>  int smb2_create_hardlink(const unsigned int xid,
> @@ -915,13 +926,14 @@ int smb2_create_hardlink(const unsigned int xid,
>
>         return smb2_set_path_attr(xid, tcon, from_name, to_name,
>                                   cifs_sb, co, FILE_READ_ATTRIBUTES,
> -                                 SMB2_OP_HARDLINK, NULL);
> +                                 SMB2_OP_HARDLINK, NULL, NULL);
>  }
>
>  int
>  smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
>                    const char *full_path, __u64 size,
> -                  struct cifs_sb_info *cifs_sb, bool set_alloc)
> +                  struct cifs_sb_info *cifs_sb, bool set_alloc,
> +                  struct dentry *dentry)
>  {
>         struct cifsFileInfo *cfile;
>         struct kvec in_iov;
> @@ -934,7 +946,7 @@ smb2_set_path_size(const unsigned int xid, struct cif=
s_tcon *tcon,
>                                 FILE_WRITE_DATA, FILE_OPEN,
>                                 0, ACL_NO_MODE, &in_iov,
>                                 &(int){SMB2_OP_SET_EOF}, 1,
> -                               cfile, NULL, NULL);
> +                               cfile, NULL, NULL, dentry);
>  }
>
>  int
> @@ -963,7 +975,7 @@ smb2_set_file_info(struct inode *inode, const char *f=
ull_path,
>                               FILE_WRITE_ATTRIBUTES, FILE_OPEN,
>                               0, ACL_NO_MODE, &in_iov,
>                               &(int){SMB2_OP_SET_INFO}, 1,
> -                             cfile, NULL, NULL);
> +                             cfile, NULL, NULL, NULL);
>         cifs_put_tlink(tlink);
>         return rc;
>  }
> @@ -998,7 +1010,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_ope=
n_info_data *data,
>                 cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfi=
le);
>                 rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                       da, cd, co, ACL_NO_MODE, in_iov,
> -                                     cmds, 2, cfile, NULL, NULL);
> +                                     cmds, 2, cfile, NULL, NULL, NULL);
>                 if (!rc) {
>                         rc =3D smb311_posix_get_inode_info(&new, full_pat=
h,
>                                                          data, sb, xid);
> @@ -1008,7 +1020,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_op=
en_info_data *data,
>                 cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfi=
le);
>                 rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                       da, cd, co, ACL_NO_MODE, in_iov,
> -                                     cmds, 2, cfile, NULL, NULL);
> +                                     cmds, 2, cfile, NULL, NULL, NULL);
>                 if (!rc) {
>                         rc =3D cifs_get_inode_info(&new, full_path,
>                                                  data, sb, xid, NULL);
> @@ -1036,7 +1048,7 @@ int smb2_query_reparse_point(const unsigned int xid=
,
>                               FILE_READ_ATTRIBUTES, FILE_OPEN,
>                               OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
>                               &(int){SMB2_OP_GET_REPARSE}, 1,
> -                             cfile, NULL, NULL);
> +                             cfile, NULL, NULL, NULL);
>         if (rc)
>                 goto out;
>
> diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> index b3069911e9dd..221143788a1c 100644
> --- a/fs/smb/client/smb2proto.h
> +++ b/fs/smb/client/smb2proto.h
> @@ -75,7 +75,8 @@ int smb2_query_path_info(const unsigned int xid,
>                          struct cifs_open_info_data *data);
>  extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *=
tcon,
>                               const char *full_path, __u64 size,
> -                             struct cifs_sb_info *cifs_sb, bool set_allo=
c);
> +                             struct cifs_sb_info *cifs_sb, bool set_allo=
c,
> +                                 struct dentry *dentry);
>  extern int smb2_set_file_info(struct inode *inode, const char *full_path=
,
>                               FILE_BASIC_INFO *buf, const unsigned int xi=
d);
>  extern int smb311_posix_mkdir(const unsigned int xid, struct inode *inod=
e,
> @@ -91,7 +92,8 @@ extern void smb2_mkdir_setinfo(struct inode *inode, con=
st char *full_path,
>  extern int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon,
>                       const char *name, struct cifs_sb_info *cifs_sb);
>  extern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
> -                      const char *name, struct cifs_sb_info *cifs_sb);
> +                      const char *name, struct cifs_sb_info *cifs_sb,
> +                          struct dentry *dentry);
>  int smb2_rename_path(const unsigned int xid,
>                      struct cifs_tcon *tcon,
>                      struct dentry *source_dentry,
> --
> 2.39.2
>

