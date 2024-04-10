Return-Path: <linux-kernel+bounces-139202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8D89FFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE001C25806
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89F1802D4;
	Wed, 10 Apr 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpprW95g"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91171802CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773618; cv=none; b=na96jcKtcYFOqoUlBEoanyd/ZCwnSdvV+dXu8l/pPJoaPhmolS5+Y/vmUFGlqs5jper492lKyqz1d/JdJg+7QVCOcv8Etf09+Dm8kVYnFOnuYXlZivdfjDft7xXq5staSpsadHhVRrSvRG/5SMRenXO7cLbsZZmBN1uZvR0ou4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773618; c=relaxed/simple;
	bh=2EiSmTfDRoAJiUH3vqq+zn1TONWEe3H+C4vOhGjabx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMUHxEXIhEw6T+ycou2YYbFbD/KixxAk5gCTw+7XsowBS+squngive0nMXk0Y5/U2VdP9Dh/3ULTs2uau7xLVwxIm+YzEhg2KSUUYMwrCNlXvD9Vl1IL4jL/9c/Tj1YlKFoyoMiDFdY9CyyKen3bKEV+TSPazuuSe261MylSX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpprW95g; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e0425e5aa8so2721665241.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712773615; x=1713378415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc7iei40SYQYMeVwuT40zPKWTolMKwn+ZR2XX26uTIc=;
        b=gpprW95g1iKwTWoAbDeY5nj+GjtimpPHqEMekP3e7EKAsaMX/YMimcG9VmF2G3t/YT
         UUQgzlMD1EncAQEuEABup/6OY4tsj78LtQhJgOjPBFJWhE3gD6YLWISBDiqwN4UCzaEB
         6B+vCwmvP6fuKQNrjqEq3+xD3/uslkhVgyRVMVHpPh6FydCCQWxK8nwwIiTNyQvv4fEL
         QaWiYQOQ+vxPAPWiQy4mI8g0LwwWZtfJTTK8/NvCwcW6CpPlFJpvDKgVNXvyEMOiTeJb
         NjLwVfgm6OnQm09qWFCGIDvVBaAUcUFVhXSdHwOoKsNhOyP2OvDb2QBYthIZ5HBeG4KA
         rCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773615; x=1713378415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc7iei40SYQYMeVwuT40zPKWTolMKwn+ZR2XX26uTIc=;
        b=c1SEoH7mpcwt3UEqBiXyAYIxgrsJ+mAgpfl3bxheZAFNyHWl3vhZ8mEeH12iIB6hl5
         2Bs+ry+AtbHZ2d7xveNQpYzetKHLlBYEgKsptC2fgs1f9R8K/jEJPu/U1qPLsQprAvsZ
         3SaG9l7UWS0o0QT5/FZIQLZaVi/24ZzqtRaA3mNwXmKc0PA+W5gub/kvaX7ud0ZJnqqb
         wxxClDF9nBJ4VlqwQTK8XUUojMj5+Irbvx90qOFPmnsZaoX3FgRM6FRSmUoRjP7rnS/t
         uS41KIZEEKevxeMkurV/qNtLDXFF7FVwBc43hpHVd0yMXbzUW/TAF0cWeSuceQxduA66
         CujA==
X-Forwarded-Encrypted: i=1; AJvYcCVtcSqFPu6DCZIYj+YLDoVCR+BtN4adhroZZ09vG0nf2c7KXcttXkBVTg1lfDbnL6VsOV4IXQ8OLhz8rNw1iAzq7LOgNsfU+x72SSTB
X-Gm-Message-State: AOJu0Yy1aIj0k/a3WmO8V9vtHRRuKk4jbVfFzukhLmQ/C8xPDxr83V9F
	e65ImaN9cdp9LanzTx4fYNNmXJy8/omU07NtruLd6rJapNkoKSDJ0nhE8hhbg3jR38KSXrOFxpm
	lAzPx1Wd1dbGXW8OXYbm8Hwoo9iM=
X-Google-Smtp-Source: AGHT+IH9picqOpij1mjVRmG3L4ufpoQ+6PF/LdBgtfOdnYhMBYqKZAyKMjjKwwLbQbE99HvhWmdjjBJaUe22IoRpQU0=
X-Received: by 2002:a05:6102:3a0d:b0:47a:2951:2a2b with SMTP id
 b13-20020a0561023a0d00b0047a29512a2bmr2251916vsu.32.1712773615490; Wed, 10
 Apr 2024 11:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407135848.3638669-1-chao@kernel.org>
In-Reply-To: <20240407135848.3638669-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 10 Apr 2024 11:26:44 -0700
Message-ID: <CACOAw_xwxTMZVjfn4YF3vx=j7Q9SKMnOS6S6mJxsKSLZ0ymU8g@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: zone: don't block IO if there is remained open zone
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 6:58=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
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
> v3:
> - avoid race condition in between __submit_merged_bio()
> and __allocate_new_segment().
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
> index 0d88649c60a5..18a4ac0a06bc 100644
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
> +               } else if (io->zone_openned) {

We already checked if this value is true above.

Thanks,

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
> index 694f8a52cb84..8a26530cf4fb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1234,16 +1234,16 @@ struct f2fs_bio_info {
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
> @@ -1560,6 +1560,7 @@ struct f2fs_sb_info {
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
> @@ -3822,6 +3823,7 @@ void f2fs_destroy_bio_entry_cache(void);
>  void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>                           enum page_type type);
>  int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
> +void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int typ=
e);
>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type t=
ype);
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>                                 struct inode *inode, struct page *page,
> @@ -4469,6 +4471,28 @@ static inline bool f2fs_blkz_is_seq(struct f2fs_sb=
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
> index 4fd76e867e0a..4a3cf2888faf 100644
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
> @@ -4132,6 +4130,27 @@ static int restore_curseg_summaries(struct f2fs_sb=
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
> @@ -5451,6 +5470,18 @@ static void destroy_curseg(struct f2fs_sb_info *sb=
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
> index fdf358c7f808..954baa6c100d 100644
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
>

