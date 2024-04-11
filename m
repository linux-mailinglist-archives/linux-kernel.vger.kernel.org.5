Return-Path: <linux-kernel+bounces-140689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B98A17C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5728386F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61DD134A6;
	Thu, 11 Apr 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI2X5Haz"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27A10A20
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846790; cv=none; b=fX2LL1kOGkagwEh2MkbLILwzgloecgc+nyjW+2N+1BeW9ypis+Mrj6+X4yUbruI4EFi2NbNkGBxvJWKHyl9XhNubzwozJD5zTMRIt122ogD5vN2y5Rc3o75fWr4Gs/Ox1SvUhN8dm13gOW0kImeK6IXmA5B/dXh0IEI14Aaipp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846790; c=relaxed/simple;
	bh=o922b4tIcTnDXP2Ucuq5flvYof0usrQJ0LMdBTyejjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8MbF9DaavnoNyC2gTOAK1piRP2ILtpPqQ0AwCek1bGRbwfWqqoxemGUPZpRcspdXdaIDS1ODHCTEvvG3NFzkfH5GY82fgRIF7lc79O4YytM51xlcwDPfzY9BpS3migoSwMDO5V08d08NEKNQVJFiqv0X9Rp89GvHoCDTM3JHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI2X5Haz; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e043f577c5so496839241.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712846787; x=1713451587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPBLg90NOUWtWo409Kn8D+0xt5FUJr/iGVha3fSehxY=;
        b=gI2X5HazJJ4bHgPap20ZVPub/+LlRESXS8l18gHu/5fXsi8KVuPXRLikmLuxBXPNPG
         xlrS5sSGvPiAhO6d/zObGfII71CtV4uiVoimrxeXV8LEtazbTRBxE/Wgp3hQw/0G0OM4
         p6cVXBYjWrFsECKhpPjyT161me+LkvQ2isIF/9SOblDVXxK2bDTMzZj0lZf6i0dNcqu0
         q+4dafuc8ctaQ7arWAYRT3GF3pfNLZw63iiUlgBlYchE2LznRBrsQMb25U9V08lSFqDv
         Y5t5nfeGriQMGLlPkVsQnMzRANk811rPhhJZsdoFZ3e07ITWuZnaVfIIvVY5fdg7Yqz2
         Wlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712846787; x=1713451587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPBLg90NOUWtWo409Kn8D+0xt5FUJr/iGVha3fSehxY=;
        b=ZYGYv5rxNs8gpkNZ9Humz+mvWraW2A6bFhlFTlgJA0nM2TpteCiMmbqlVp0CQP57u6
         nAGCcMtNo9pAhTkjRF7Dj9MZi4Cq//vFooeJcYrfzHPf2PC+oZ+uQaBcYycg3TWirq2t
         waCpvQiCxfmY3hHNXLHf68plJvwxIdz0VA+JQKhFpYWTOs8/J4CIUzG94OUvVZLybDbI
         pS3u+9bS2wxvMTfXGr4fZhopxqWflqACXyc9WDIZfMUuLAmUIWLbrOYKcxwT09HNw1y/
         fRqi6Dlyl6TOjvSGArAiOV25xmjiVsfmmoTAgWrfdPKJdPtR1TUABgzKsmQrT4erDUZw
         bLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXohrDpsiaDt6TtRPgedqoOLEmgrB/ku9dd8HNnkNrt1M+mOu8mxFhH/pn8sjrXAcnLLE6bm+ZVw1rH07n3m1K1tMd0GrsRe30805XE
X-Gm-Message-State: AOJu0YynlT10PqDWYTVxFHAYFjQeNGeD0jHagh+D0FAmfxeaQN81yvQ/
	ky2XfuGIrekyqwkdHEz4nm5PnUxl+98zfs3PERMOK3gH31JIyQ1qwiM5JUvsf2N0VAuL9OxiJP6
	CqGm3K7fJ1kjEASsPMtVPn+Ho09s=
X-Google-Smtp-Source: AGHT+IHR86LvaODSM9T3K/qax/c9xILIvGUy/L2lELqYtAJgVWndaFs1b29DfOL2K6Z6r15dwXi51IrMXFUqwIsnuVU=
X-Received: by 2002:a05:6122:909:b0:4d8:7d49:18fe with SMTP id
 j9-20020a056122090900b004d87d4918femr2449178vka.4.1712846787023; Thu, 11 Apr
 2024 07:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411083153.1697156-1-chao@kernel.org>
In-Reply-To: <20240411083153.1697156-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 11 Apr 2024 07:46:15 -0700
Message-ID: <CACOAw_yEFnfaSmbO-y2XMwznMfGvcB54V0XL6q67JzUHdgXxuA@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: zone: don't block IO if there is remained open zone
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:32=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> max open zone may be larger than log header number of f2fs, for
> such case, it doesn't need to wait last IO in previous zone, let's
> introduce available_open_zone semaphore, and reduce it once we
> submit first write IO in a zone, and increase it after completion
> of last IO in the zone.
>
> Cc: Daeho Jeong <daeho43@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - avoid unneeded condition in f2fs_blkzoned_submit_merged_write().
>  fs/f2fs/data.c    | 105 ++++++++++++++++++++++++++++++----------------
>  fs/f2fs/f2fs.h    |  34 ++++++++++++---
>  fs/f2fs/iostat.c  |   7 ++++
>  fs/f2fs/iostat.h  |   2 +
>  fs/f2fs/segment.c |  43 ++++++++++++++++---
>  fs/f2fs/segment.h |  12 +++++-
>  fs/f2fs/super.c   |   2 +
>  7 files changed, 156 insertions(+), 49 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 60056b9a51be..71472ab6b7e7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -373,11 +373,10 @@ static void f2fs_write_end_io(struct bio *bio)
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static void f2fs_zone_write_end_io(struct bio *bio)
>  {
> -       struct f2fs_bio_info *io =3D (struct f2fs_bio_info *)bio->bi_priv=
ate;
> +       struct f2fs_sb_info *sbi =3D iostat_get_bio_private(bio);
>
> -       bio->bi_private =3D io->bi_private;
> -       complete(&io->zone_wait);
>         f2fs_write_end_io(bio);
> +       up(&sbi->available_open_zones);
>  }
>  #endif
>
> @@ -531,6 +530,24 @@ static void __submit_merged_bio(struct f2fs_bio_info=
 *io)
>         if (!io->bio)
>                 return;
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (io->open_zone) {
> +               /*
> +                * if there is no open zone, it will wait for last IO in
> +                * previous zone before submitting new IO.
> +                */
> +               down(&fio->sbi->available_open_zones);
> +               io->open_zone =3D false;
> +               io->zone_openned =3D true;
> +       }
> +
> +       if (io->close_zone) {
> +               io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> +               io->zone_openned =3D false;
> +               io->close_zone =3D false;
> +       }
> +#endif
> +
>         if (is_read_io(fio->op)) {
>                 trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->b=
io);
>                 f2fs_submit_read_bio(io->sbi, io->bio, fio->type);
> @@ -601,9 +618,9 @@ int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi=
)
>                         INIT_LIST_HEAD(&sbi->write_io[i][j].bio_list);
>                         init_f2fs_rwsem(&sbi->write_io[i][j].bio_list_loc=
k);
>  #ifdef CONFIG_BLK_DEV_ZONED
> -                       init_completion(&sbi->write_io[i][j].zone_wait);
> -                       sbi->write_io[i][j].zone_pending_bio =3D NULL;
> -                       sbi->write_io[i][j].bi_private =3D NULL;
> +                       sbi->write_io[i][j].open_zone =3D false;
> +                       sbi->write_io[i][j].zone_openned =3D false;
> +                       sbi->write_io[i][j].close_zone =3D false;
>  #endif
>                 }
>         }
> @@ -634,6 +651,31 @@ static void __f2fs_submit_merged_write(struct f2fs_s=
b_info *sbi,
>         f2fs_up_write(&io->io_rwsem);
>  }
>
> +void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int typ=
e)
> +{
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       struct f2fs_bio_info *io;
> +
> +       if (!f2fs_sb_has_blkzoned(sbi))
> +               return;
> +
> +       io =3D sbi->write_io[PAGE_TYPE(type)] + type_to_temp(type);
> +
> +       f2fs_down_write(&io->io_rwsem);
> +       if (io->zone_openned) {
> +               if (io->bio) {
> +                       io->close_zone =3D true;
> +                       __submit_merged_bio(io);
> +               } else {
> +                       up(&sbi->available_open_zones);
> +                       io->zone_openned =3D false;
> +               }
> +       }
> +       f2fs_up_write(&io->io_rwsem);
> +#endif
> +
> +}
> +
>  static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>                                 struct inode *inode, struct page *page,
>                                 nid_t ino, enum page_type type, bool forc=
e)
> @@ -918,22 +960,16 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  }
>
>  #ifdef CONFIG_BLK_DEV_ZONED
> -static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkadd=
r)
> +static bool is_blkaddr_zone_boundary(struct f2fs_sb_info *sbi,
> +                                       block_t blkaddr, bool start)
>  {
> -       int devi =3D 0;
> +       if (!f2fs_blkaddr_in_seqzone(sbi, blkaddr))
> +               return false;
> +
> +       if (start)
> +               return (blkaddr % sbi->blocks_per_blkz) =3D=3D 0;
> +       return (blkaddr % sbi->blocks_per_blkz =3D=3D sbi->blocks_per_blk=
z - 1);
>
> -       if (f2fs_is_multi_device(sbi)) {
> -               devi =3D f2fs_target_device_index(sbi, blkaddr);
> -               if (blkaddr < FDEV(devi).start_blk ||
> -                   blkaddr > FDEV(devi).end_blk) {
> -                       f2fs_err(sbi, "Invalid block %x", blkaddr);
> -                       return false;
> -               }
> -               blkaddr -=3D FDEV(devi).start_blk;
> -       }
> -       return bdev_is_zoned(FDEV(devi).bdev) &&
> -               f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
> -               (blkaddr % sbi->blocks_per_blkz =3D=3D sbi->blocks_per_bl=
kz - 1);
>  }
>  #endif
>
> @@ -944,20 +980,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>         struct f2fs_bio_info *io =3D sbi->write_io[btype] + fio->temp;
>         struct page *bio_page;
>         enum count_type type;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       bool blkzoned =3D f2fs_sb_has_blkzoned(sbi) && btype < META;
> +#endif
>
>         f2fs_bug_on(sbi, is_read_io(fio->op));
>
>         f2fs_down_write(&io->io_rwsem);
>  next:
> -#ifdef CONFIG_BLK_DEV_ZONED
> -       if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending=
_bio) {
> -               wait_for_completion_io(&io->zone_wait);
> -               bio_put(io->zone_pending_bio);
> -               io->zone_pending_bio =3D NULL;
> -               io->bi_private =3D NULL;
> -       }
> -#endif
> -
>         if (fio->in_list) {
>                 spin_lock(&io->io_lock);
>                 if (list_empty(&io->io_list)) {
> @@ -985,6 +1015,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>         type =3D WB_DATA_TYPE(bio_page, fio->compressed_page);
>         inc_page_count(sbi, type);
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (blkzoned && is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, t=
rue))
> +               io->open_zone =3D true;
> +#endif
> +
>         if (io->bio &&
>             (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bi=
o,
>                               fio->new_blkaddr) ||
> @@ -1010,15 +1045,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *=
fio)
>         io->last_block_in_bio =3D fio->new_blkaddr;
>
>         trace_f2fs_submit_page_write(fio->page, fio);
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
> -       if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> -                       is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> -               bio_get(io->bio);
> -               reinit_completion(&io->zone_wait);
> -               io->bi_private =3D io->bio->bi_private;
> -               io->bio->bi_private =3D io;
> -               io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> -               io->zone_pending_bio =3D io->bio;
> +       if (blkzoned &&
> +               is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, false)) {
> +               io->close_zone =3D true;
>                 __submit_merged_bio(io);
>         }
>  #endif
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e9ef971f4dba..4cc20e49c18c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1232,16 +1232,16 @@ struct f2fs_bio_info {
>         struct bio *bio;                /* bios to merge */
>         sector_t last_block_in_bio;     /* last block number */
>         struct f2fs_io_info fio;        /* store buffered io info. */
> -#ifdef CONFIG_BLK_DEV_ZONED
> -       struct completion zone_wait;    /* condition value for the previo=
us open zone to close */
> -       struct bio *zone_pending_bio;   /* pending bio for the previous z=
one */
> -       void *bi_private;               /* previous bi_private for pendin=
g bio */
> -#endif
>         struct f2fs_rwsem io_rwsem;     /* blocking op for bio */
>         spinlock_t io_lock;             /* serialize DATA/NODE IOs */
>         struct list_head io_list;       /* track fios */
>         struct list_head bio_list;      /* bio entry list head */
>         struct f2fs_rwsem bio_list_lock;        /* lock to protect bio en=
try list */
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       bool open_zone;                 /* open a zone */
> +       bool zone_openned;              /* zone has been openned */
> +       bool close_zone;                /* close a zone */
> +#endif
>  };
>
>  #define FDEV(i)                                (sbi->devs[i])
> @@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
>  #ifdef CONFIG_BLK_DEV_ZONED
>         unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
>         unsigned int max_open_zones;            /* max open zone resource=
s of the zoned device */
> +       struct semaphore available_open_zones;  /* available open zones *=
/
>  #endif
>
>         /* for node-related operations */
> @@ -3820,6 +3821,7 @@ void f2fs_destroy_bio_entry_cache(void);
>  void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>                           enum page_type type);
>  int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
> +void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int typ=
e);
>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type t=
ype);
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>                                 struct inode *inode, struct page *page,
> @@ -4467,6 +4469,28 @@ static inline bool f2fs_blkz_is_seq(struct f2fs_sb=
_info *sbi, int devi,
>
>         return test_bit(zno, FDEV(devi).blkz_seq);
>  }
> +
> +static inline bool f2fs_blkaddr_in_seqzone(struct f2fs_sb_info *sbi,
> +                                                       block_t blkaddr)
> +{
> +       int devi =3D 0;
> +
> +       if (f2fs_is_multi_device(sbi)) {
> +               devi =3D f2fs_target_device_index(sbi, blkaddr);
> +               if (blkaddr < FDEV(devi).start_blk ||
> +                   blkaddr > FDEV(devi).end_blk) {
> +                       f2fs_err(sbi, "Invalid block %x", blkaddr);
> +                       return false;
> +               }
> +               blkaddr -=3D FDEV(devi).start_blk;
> +       }
> +
> +       if (!bdev_is_zoned(FDEV(devi).bdev) ||
> +               !f2fs_blkz_is_seq(sbi, devi, blkaddr))
> +               return false;
> +
> +       return true;
> +}
>  #endif
>
>  static inline int f2fs_bdev_index(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index f8703038e1d8..a8626e297876 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -237,6 +237,13 @@ static inline void __update_iostat_latency(struct bi=
o_iostat_ctx *iostat_ctx,
>         spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>  }
>
> +void *iostat_get_bio_private(struct bio *bio)
> +{
> +       struct bio_iostat_ctx *iostat_ctx =3D bio->bi_private;
> +
> +       return iostat_ctx->sbi;
> +}
> +
>  void iostat_update_and_unbind_ctx(struct bio *bio)
>  {
>         struct bio_iostat_ctx *iostat_ctx =3D bio->bi_private;
> diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
> index eb99d05cf272..9006c3d41590 100644
> --- a/fs/f2fs/iostat.h
> +++ b/fs/f2fs/iostat.h
> @@ -58,6 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_c=
tx(struct bio *bio)
>         return iostat_ctx->post_read_ctx;
>  }
>
> +extern void *iostat_get_bio_private(struct bio *bio);
>  extern void iostat_update_and_unbind_ctx(struct bio *bio);
>  extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>                 struct bio *bio, struct bio_post_read_ctx *ctx);
> @@ -68,6 +69,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sb=
i);
>  #else
>  static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct i=
node *inode,
>                 enum iostat_type type, unsigned long long io_bytes) {}
> +static inline void *iostat_get_bio_private(struct bio *bio) { return bio=
->bi_private; }
>  static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
>  static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>                 struct bio *bio, struct bio_post_read_ctx *ctx) {}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6474b7338e81..58cce79156bf 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3140,6 +3140,9 @@ static int __allocate_new_segment(struct f2fs_sb_in=
fo *sbi, int type,
>                 return err;
>         stat_inc_seg_type(sbi, curseg);
>         locate_dirty_segment(sbi, old_segno);
> +
> +       f2fs_blkzoned_submit_merged_write(sbi, type);
> +
>         return 0;
>  }
>
> @@ -3461,12 +3464,7 @@ static int __get_segment_type(struct f2fs_io_info =
*fio)
>                 f2fs_bug_on(fio->sbi, true);
>         }
>
> -       if (IS_HOT(type))
> -               fio->temp =3D HOT;
> -       else if (IS_WARM(type))
> -               fio->temp =3D WARM;
> -       else
> -               fio->temp =3D COLD;
> +       fio->temp =3D type_to_temp(type);
>         return type;
>  }
>
> @@ -4134,6 +4132,27 @@ static int restore_curseg_summaries(struct f2fs_sb=
_info *sbi)
>                 return -EINVAL;
>         }
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (f2fs_sb_has_blkzoned(sbi)) {
> +               for (type =3D 0; type < NR_PERSISTENT_LOG; type++) {
> +                       struct curseg_info *curseg =3D CURSEG_I(sbi, type=
);
> +                       enum page_type ptype;
> +                       enum temp_type temp;
> +
> +                       if (!(curseg->next_blkoff % sbi->blocks_per_blkz)=
)
> +                               continue;
> +
> +                       if (!f2fs_blkaddr_in_seqzone(sbi,
> +                                       START_BLOCK(sbi, curseg->segno)))
> +                               continue;
> +
> +                       ptype =3D PAGE_TYPE(type);
> +                       temp =3D type_to_temp(type);
> +                       down(&sbi->available_open_zones);
> +                       sbi->write_io[ptype][temp].zone_openned =3D true;
> +               }
> +       }
> +#endif
>         return 0;
>  }
>
> @@ -5453,6 +5472,18 @@ static void destroy_curseg(struct f2fs_sb_info *sb=
i)
>         for (i =3D 0; i < NR_CURSEG_TYPE; i++) {
>                 kfree(array[i].sum_blk);
>                 kfree(array[i].journal);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +               if (f2fs_sb_has_blkzoned(sbi)) {
> +                       enum page_type ptype =3D PAGE_TYPE(i);
> +                       enum temp_type temp =3D type_to_temp(i);
> +
> +                       if (sbi->write_io[ptype][temp].zone_openned) {
> +                               up(&sbi->available_open_zones);
> +                               sbi->write_io[ptype][temp].zone_openned =
=3D false;
> +                       }
> +               }
> +#endif
>         }
>         kfree(array);
>  }
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index e1c0f418aa11..855978ca869f 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -24,7 +24,8 @@
>
>  #define IS_DATASEG(t)  ((t) <=3D CURSEG_COLD_DATA)
>  #define IS_NODESEG(t)  ((t) >=3D CURSEG_HOT_NODE && (t) <=3D CURSEG_COLD=
_NODE)
> -#define SE_PAGETYPE(se)        ((IS_NODESEG((se)->type) ? NODE : DATA))
> +#define PAGE_TYPE(t)   (IS_NODESEG(t) ? NODE : DATA)
> +#define SE_PAGETYPE(se)        (PAGE_TYPE((se)->type))
>
>  static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>                                                 unsigned short seg_type)
> @@ -965,3 +966,12 @@ static inline unsigned int first_zoned_segno(struct =
f2fs_sb_info *sbi)
>                         return GET_SEGNO(sbi, FDEV(devi).start_blk);
>         return 0;
>  }
> +
> +static inline enum temp_type type_to_temp(int type)
> +{
> +       if (IS_HOT(type))
> +               return HOT;
> +       else if (IS_WARM(type))
> +               return WARM;
> +       return COLD;
> +}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index df32573d1f62..0a34c8746782 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3893,6 +3893,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi,=
 int devi)
>                                 sbi->max_open_zones, F2FS_OPTION(sbi).act=
ive_logs);
>                         return -EINVAL;
>                 }
> +
> +               sema_init(&sbi->available_open_zones, sbi->max_open_zones=
);
>         }
>
>         zone_sectors =3D bdev_zone_sectors(bdev);
> --
> 2.40.1

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

>

