Return-Path: <linux-kernel+bounces-18313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D364D825B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A4B1F24315
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB436087;
	Fri,  5 Jan 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1I1SDDI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C935EF9;
	Fri,  5 Jan 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so22983521fa.3;
        Fri, 05 Jan 2024 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704484956; x=1705089756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsvjmNHo6qhLAK2xa0iLQABFz+5g9tXEflTtkgq7O+M=;
        b=i1I1SDDIQG5R3sNa0npsXJSBJGatQr/+Uu8kn+rY7R8GpAu272vrfNtAkXRTBZtrOW
         211VkZ/L+OzAXKeYrkuzVFalefMZSTRxSwbSyGR0kkiQqEOciZQQ2m3qo0ee8uy8bS7d
         ol/sIfsbJL9sqr3q61zbrO3AaBFiU4d1FvE2sTM0pEFhSCYkX4TS0Qc8LliKnI6xjx9A
         zGgRqKGtOdknGM5+7xO6I4rc3B/5LYYqDLoB07/IrsNER5AvPbjFDE/vvF6XAwTuWGMy
         6j32elw1k7cqJvmzgTumFAhsEF+YuRs8ADt2WCQwnGA3fVd2E5nvI/8GjSsvdqvp44pF
         V03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704484956; x=1705089756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsvjmNHo6qhLAK2xa0iLQABFz+5g9tXEflTtkgq7O+M=;
        b=n8rsqDdSRroNoVea8omeTUNJdizLJYDOf39ADgoDrpRKwEAQ81bT5H60ifrn7e/liF
         9xlBpFfCEblxjmUFFZtNvexdad+mDVWN3Nt15QVkf0fIaDrsED8IBp3Rbm0LbDXOaQWh
         APLnBtE75svpmCxTc5PS8hQG2o8b0x3antf7TRXnEed7IIibXo0vcq+sKKsjc0vSu4G5
         T2oMVzUtDrvjFI64T3pWl9fb6eFA0JJJr8dxoUe6/qRYOn5JmRfOMpBOs+JUxghMt02Q
         Qxg3FNvEps4DXTwnZSApJ1cp3yq0VTfvT395R57gBq2Y6hpChJTav2YYz/2B9vhtuvw8
         HqLA==
X-Gm-Message-State: AOJu0YzRUaRUACSjTqHdmIKza+dqpvjY2vnWdB/nbiBcdiP+cz8g/9BJ
	Z1BhATGXjXWIYrVJ5F3e7AlG9YqqY2EWt/iJu6U=
X-Google-Smtp-Source: AGHT+IGoo2kRa4oDQ0+COth+d/bgnyyA6BjWPNzSt7AGxWpS2+BTWIqk0FNjHKw2pxiD5PHURmFFyep7jy7DHf8IfUo=
X-Received: by 2002:a2e:a405:0:b0:2cc:e9e1:e6a6 with SMTP id
 p5-20020a2ea405000000b002cce9e1e6a6mr1305443ljn.92.1704484955949; Fri, 05 Jan
 2024 12:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3349332.1704123610@warthog.procyon.org.uk>
In-Reply-To: <3349332.1704123610@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Fri, 5 Jan 2024 14:02:24 -0600
Message-ID: <CAH2r5mu0XUMH8aM9oSq1LA=x6StNZ9kGOpLS99=mdieoxVnXeg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Pass unbyteswapped eof value into SMB2_set_eof()
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Mon, Jan 1, 2024 at 9:40=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Steve,
>
> How about something like the attached?
>
> David
> ---
> cifs: Pass unbyteswapped eof value into SMB2_set_eof()
>
> Change SMB2_set_eof() to take eof as CPU order rather than __le64 and pas=
s
> it directly rather than by pointer.  This moves the conversion down into
> SMB_set_eof() rather than all of its callers and means we don't need to
> undo it for the traceline.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/smb/client/smb2ops.c   |   37 ++++++++++++++++---------------------
>  fs/smb/client/smb2pdu.c   |    6 +++---
>  fs/smb/client/smb2proto.h |    2 +-
>  3 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 66b310208545..82de0e205607 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -1923,7 +1923,6 @@ static int
>  smb2_set_file_size(const unsigned int xid, struct cifs_tcon *tcon,
>                    struct cifsFileInfo *cfile, __u64 size, bool set_alloc=
)
>  {
> -       __le64 eof =3D cpu_to_le64(size);
>         struct inode *inode;
>
>         /*
> @@ -1940,7 +1939,7 @@ smb2_set_file_size(const unsigned int xid, struct c=
ifs_tcon *tcon,
>         }
>
>         return SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
> -                           cfile->fid.volatile_fid, cfile->pid, &eof);
> +                           cfile->fid.volatile_fid, cfile->pid, size);
>  }
>
>  static int
> @@ -3324,7 +3323,6 @@ static long smb3_zero_range(struct file *file, stru=
ct cifs_tcon *tcon,
>         unsigned long long new_size;
>         long rc;
>         unsigned int xid;
> -       __le64 eof;
>
>         xid =3D get_xid();
>
> @@ -3354,9 +3352,8 @@ static long smb3_zero_range(struct file *file, stru=
ct cifs_tcon *tcon,
>          */
>         new_size =3D offset + len;
>         if (keep_size =3D=3D false && (unsigned long long)i_size_read(ino=
de) < new_size) {
> -               eof =3D cpu_to_le64(new_size);
>                 rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
> -                                 cfile->fid.volatile_fid, cfile->pid, &e=
of);
> +                                 cfile->fid.volatile_fid, cfile->pid, ne=
w_size);
>                 if (rc >=3D 0) {
>                         truncate_setsize(inode, new_size);
>                         fscache_resize_cookie(cifs_inode_cookie(inode), n=
ew_size);
> @@ -3549,7 +3546,7 @@ static long smb3_simple_falloc(struct file *file, s=
truct cifs_tcon *tcon,
>         struct cifsFileInfo *cfile =3D file->private_data;
>         long rc =3D -EOPNOTSUPP;
>         unsigned int xid;
> -       __le64 eof;
> +       loff_t new_eof;
>
>         xid =3D get_xid();
>
> @@ -3578,14 +3575,14 @@ static long smb3_simple_falloc(struct file *file,=
 struct cifs_tcon *tcon,
>                 if (cifsi->cifsAttrs & FILE_ATTRIBUTE_SPARSE_FILE)
>                         smb2_set_sparse(xid, tcon, cfile, inode, false);
>
> -               eof =3D cpu_to_le64(off + len);
> +               new_eof =3D off + len;
>                 rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
> -                                 cfile->fid.volatile_fid, cfile->pid, &e=
of);
> +                                 cfile->fid.volatile_fid, cfile->pid, ne=
w_eof);
>                 if (rc =3D=3D 0) {
> -                       cifsi->server_eof =3D off + len;
> -                       cifs_setsize(inode, off + len);
> +                       cifsi->server_eof =3D new_eof;
> +                       cifs_setsize(inode, new_eof);
>                         cifs_truncate_page(inode->i_mapping, inode->i_siz=
e);
> -                       truncate_setsize(inode, off + len);
> +                       truncate_setsize(inode, new_eof);
>                 }
>                 goto out;
>         }
> @@ -3676,8 +3673,7 @@ static long smb3_collapse_range(struct file *file, =
struct cifs_tcon *tcon,
>         struct inode *inode =3D file_inode(file);
>         struct cifsFileInfo *cfile =3D file->private_data;
>         struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
> -       __le64 eof;
> -       loff_t old_eof;
> +       loff_t old_eof, new_eof;
>
>         xid =3D get_xid();
>
> @@ -3702,9 +3698,9 @@ static long smb3_collapse_range(struct file *file, =
struct cifs_tcon *tcon,
>         if (rc < 0)
>                 goto out_2;
>
> -       eof =3D cpu_to_le64(old_eof - len);
> +       new_eof =3D old_eof - len;
>         rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
> -                         cfile->fid.volatile_fid, cfile->pid, &eof);
> +                         cfile->fid.volatile_fid, cfile->pid, new_eof);
>         if (rc < 0)
>                 goto out_2;
>
> @@ -3728,8 +3724,7 @@ static long smb3_insert_range(struct file *file, st=
ruct cifs_tcon *tcon,
>         unsigned int xid;
>         struct cifsFileInfo *cfile =3D file->private_data;
>         struct inode *inode =3D file_inode(file);
> -       __le64 eof;
> -       __u64  count, old_eof;
> +       __u64 count, old_eof, new_eof;
>
>         xid =3D get_xid();
>
> @@ -3742,20 +3737,20 @@ static long smb3_insert_range(struct file *file, =
struct cifs_tcon *tcon,
>         }
>
>         count =3D old_eof - off;
> -       eof =3D cpu_to_le64(old_eof + len);
> +       new_eof =3D old_eof + len;
>
>         filemap_invalidate_lock(inode->i_mapping);
> -       rc =3D filemap_write_and_wait_range(inode->i_mapping, off, old_eo=
f + len - 1);
> +       rc =3D filemap_write_and_wait_range(inode->i_mapping, off, new_eo=
f - 1);
>         if (rc < 0)
>                 goto out_2;
>         truncate_pagecache_range(inode, off, old_eof);
>
>         rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
> -                         cfile->fid.volatile_fid, cfile->pid, &eof);
> +                         cfile->fid.volatile_fid, cfile->pid, new_eof);
>         if (rc < 0)
>                 goto out_2;
>
> -       truncate_setsize(inode, old_eof + len);
> +       truncate_setsize(inode, new_eof);
>         fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode=
));
>
>         rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + =
len);
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 4f971c1061f0..bd25c34dc398 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -5347,18 +5347,18 @@ send_set_info(const unsigned int xid, struct cifs=
_tcon *tcon,
>
>  int
>  SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon, u64 persist=
ent_fid,
> -            u64 volatile_fid, u32 pid, __le64 *eof)
> +            u64 volatile_fid, u32 pid, loff_t new_eof)
>  {
>         struct smb2_file_eof_info info;
>         void *data;
>         unsigned int size;
>
> -       info.EndOfFile =3D *eof;
> +       info.EndOfFile =3D cpu_to_le64(new_eof);
>
>         data =3D &info;
>         size =3D sizeof(struct smb2_file_eof_info);
>
> -       trace_smb3_set_eof(xid, persistent_fid, tcon->tid, tcon->ses->Sui=
d, le64_to_cpu(*eof));
> +       trace_smb3_set_eof(xid, persistent_fid, tcon->tid, tcon->ses->Sui=
d, new_eof);
>
>         return send_set_info(xid, tcon, persistent_fid, volatile_fid,
>                         pid, FILE_END_OF_FILE_INFORMATION, SMB2_O_INFO_FI=
LE,
> diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> index 0e371f7e2854..95e5ca69fdf3 100644
> --- a/fs/smb/client/smb2proto.h
> +++ b/fs/smb/client/smb2proto.h
> @@ -205,7 +205,7 @@ extern int SMB2_query_directory_init(unsigned int xid=
, struct cifs_tcon *tcon,
>  extern void SMB2_query_directory_free(struct smb_rqst *rqst);
>  extern int SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon,
>                         u64 persistent_fid, u64 volatile_fid, u32 pid,
> -                       __le64 *eof);
> +                       loff_t new_eof);
>  extern int SMB2_set_info_init(struct cifs_tcon *tcon,
>                               struct TCP_Server_Info *server,
>                               struct smb_rqst *rqst,
>
>


--=20
Thanks,

Steve

