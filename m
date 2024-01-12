Return-Path: <linux-kernel+bounces-25065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8E82C721
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BCA1F22B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236917732;
	Fri, 12 Jan 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOUMKqeh"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3C17731
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7cd4d77e2ebso1856557241.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705097998; x=1705702798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lFqZjkPZLgpWdQzQexGYvvvqn/GuOyoQcQUtJrcBd0=;
        b=WOUMKqehPo2s78qFvwS1XNuuDhslIEXIv0MfjkSrK4aMIxf0alBGzJvGxbw6j24Noh
         iQzFmOotgA2rHg+gK5l/qQRMHQaL75zxyhAQDBuVwrxgeIU+Mw5FHwX1VhdsEjsU6SD1
         HItEvKdcnCcPl/hWdHFq95Cg8GYKs6qhhmBtGRYp8bDMk9qKJETeAgW2QWQNI4t/LuDa
         b+AJa97twYHGFerN73SQh9CJmduN18/JJnvC5Ogp//pjlT61AddD/UFXk5NUwaXz8Utw
         J7gLqRfSF1R0e+PvgTBOttbjEi27VD9CXCV9Cwv5qxR6PVFxmcrYb34AkRi0hbohSYxo
         vaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097998; x=1705702798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lFqZjkPZLgpWdQzQexGYvvvqn/GuOyoQcQUtJrcBd0=;
        b=OCRcqypQeDNLc2Ew/OXvL8iUDkltt7pjVXgXfHEuMAPOESRikfUYQxHemDIiZ29oaM
         2FfM2GqEnppN8jS/OwpHHDgcveppRsyPD39oCue/fACrsYugHkTAgB74kJeoSq3c4+ub
         XBG8izLMB8MKCGpKFo0Bs/XYf4TKKqEZwl4gPgucPzSsmf6TXGZ6r3h0Phm6iWBI01Sh
         D1Y8gq71q1gLSKecldrOzN86Xdki53pSzLOXHgvsf6gWjt/KiPeQMDxaUbenSe0ztvgb
         1KQzDwLqqNYwkOYAgIIsLpmj1ie78jNaywbQuK2wLJ5xIRKNTkMpsKWZv4/H9YNnCtPz
         RtOQ==
X-Gm-Message-State: AOJu0YxfCbuGaNaa2AoTLBPrcfZoJxUG0qLtxG3dWfDT1DOmxZlMjHv2
	T/5ZPNw3zVjoWDpjcDeoHcl6JptqFca05nuJ4P8=
X-Google-Smtp-Source: AGHT+IF92SkdZZTxt+ctl9b5km9Ne4xAZqZW7Ez9/O6g/iyL2onhoDLSjphK+u8uX4e99lZZXh2Tk/UtqExTS7i7Vm0=
X-Received: by 2002:a05:6102:3a6f:b0:468:7d:6e3c with SMTP id
 bf15-20020a0561023a6f00b00468007d6e3cmr2340436vsb.33.1705097997740; Fri, 12
 Jan 2024 14:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111064208.2969599-1-chao@kernel.org> <20240111064208.2969599-4-chao@kernel.org>
In-Reply-To: <20240111064208.2969599-4-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:19:44 -0800
Message-ID: <CACOAw_yzAWpHzHerTtm5vCkejt4Xiex5m_xKMTC_WHspOXFmRg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 4/6] f2fs: compress: fix to avoid
 inconsistence bewteen i_blocks and dnode
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Jan 10, 2024 at 10:43=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> In reserve_compress_blocks(), we update blkaddrs of dnode in prior to
> inc_valid_block_count(), it may cause inconsistent status bewteen
> i_blocks and blkaddrs once inc_valid_block_count() fails.
>
> To fix this issue, it needs to reverse their invoking order.
>
> Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c    |  5 +++--
>  fs/f2fs/f2fs.h    |  7 ++++++-
>  fs/f2fs/file.c    | 26 ++++++++++++++------------
>  fs/f2fs/segment.c |  2 +-
>  4 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b171a9980f6a..8d2ace723310 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1219,7 +1219,8 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *d=
n, blkcnt_t count)
>
>         if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
>                 return -EPERM;
> -       if (unlikely((err =3D inc_valid_block_count(sbi, dn->inode, &coun=
t))))
> +       err =3D inc_valid_block_count(sbi, dn->inode, &count, true);
> +       if (unlikely(err))
>                 return err;
>
>         trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
> @@ -1476,7 +1477,7 @@ static int __allocate_data_block(struct dnode_of_da=
ta *dn, int seg_type)
>
>         dn->data_blkaddr =3D f2fs_data_blkaddr(dn);
>         if (dn->data_blkaddr =3D=3D NULL_ADDR) {
> -               err =3D inc_valid_block_count(sbi, dn->inode, &count);
> +               err =3D inc_valid_block_count(sbi, dn->inode, &count, tru=
e);
>                 if (unlikely(err))
>                         return err;
>         }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 50f3d546ded8..69e71460a950 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2252,7 +2252,7 @@ static inline bool __allow_reserved_blocks(struct f=
2fs_sb_info *sbi,
>
>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bo=
ol);
>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> -                                struct inode *inode, blkcnt_t *count)
> +                                struct inode *inode, blkcnt_t *count, bo=
ol partial)
>  {
>         blkcnt_t diff =3D 0, release =3D 0;
>         block_t avail_user_block_count;
> @@ -2292,6 +2292,11 @@ static inline int inc_valid_block_count(struct f2f=
s_sb_info *sbi,
>                         avail_user_block_count =3D 0;
>         }
>         if (unlikely(sbi->total_valid_block_count > avail_user_block_coun=
t)) {
> +               if (!partial) {
> +                       spin_unlock(&sbi->stat_lock);
> +                       goto enospc;
> +               }
> +
>                 diff =3D sbi->total_valid_block_count - avail_user_block_=
count;
>                 if (diff > *count)
>                         diff =3D *count;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 80d9c4c096f0..53c495651789 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3614,14 +3614,16 @@ static int reserve_compress_blocks(struct dnode_o=
f_data *dn, pgoff_t count)
>                 blkcnt_t reserved;
>                 int ret;
>
> -               for (i =3D 0; i < cluster_size; i++, dn->ofs_in_node++) {
> -                       blkaddr =3D f2fs_data_blkaddr(dn);
> +               for (i =3D 0; i < cluster_size; i++) {
> +                       blkaddr =3D data_blkaddr(dn->inode, dn->node_page=
,
> +                                               dn->ofs_in_node + i);
>
>                         if (i =3D=3D 0) {
> -                               if (blkaddr =3D=3D COMPRESS_ADDR)
> -                                       continue;
> -                               dn->ofs_in_node +=3D cluster_size;
> -                               goto next;
> +                               if (blkaddr !=3D COMPRESS_ADDR) {
> +                                       dn->ofs_in_node +=3D cluster_size=
;
> +                                       goto next;
> +                               }
> +                               continue;
>                         }
>
>                         /*
> @@ -3634,20 +3636,20 @@ static int reserve_compress_blocks(struct dnode_o=
f_data *dn, pgoff_t count)
>                                 compr_blocks++;
>                                 continue;
>                         }
> -
> -                       f2fs_set_data_blkaddr(dn, NEW_ADDR);
>                 }
>
>                 reserved =3D cluster_size - compr_blocks;
>                 if (!reserved)
>                         goto next;
>
> -               ret =3D inc_valid_block_count(sbi, dn->inode, &reserved);
> -               if (ret)
> +               ret =3D inc_valid_block_count(sbi, dn->inode, &reserved, =
false);
> +               if (unlikely(ret))
>                         return ret;
>
> -               if (reserved !=3D cluster_size - compr_blocks)
> -                       return -ENOSPC;
> +               for (i =3D 0; i < cluster_size; i++, dn->ofs_in_node++) {
> +                       if (f2fs_data_blkaddr(dn) =3D=3D NULL_ADDR)
> +                               f2fs_set_data_blkaddr(dn, NEW_ADDR);
> +               }
>
>                 f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true)=
;
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4c8836ded90f..ef5b3848426b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -248,7 +248,7 @@ static int __replace_atomic_write_block(struct inode =
*inode, pgoff_t index,
>         } else {
>                 blkcnt_t count =3D 1;
>
> -               err =3D inc_valid_block_count(sbi, inode, &count);
> +               err =3D inc_valid_block_count(sbi, inode, &count, true);
>                 if (err) {
>                         f2fs_put_dnode(&dn);
>                         return err;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

