Return-Path: <linux-kernel+bounces-126975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B4894549
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76BC1F21EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DF51C49;
	Mon,  1 Apr 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az9I0rBj"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4CF9DF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998538; cv=none; b=U2QNsHEa03VLA/gAlWdB+By5K+p5mP0JAHwGbc+yyruC+Ym/ClE/d0xprponpVqDRxmp00ULg0S3eWqQ4ORD4J6qaxgiQledbQNLLTTDOhf9GVg8lzHfL3NqY3/rGsGmMyau7ENZbjdQX19mZWwoHdhTJB9Rbu9uV/1+ece3mlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998538; c=relaxed/simple;
	bh=ybphQqSU6j1Wo8qaWgjdrw2/wnuLjDikNQaajh1bvO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpUgOlR2rI2fEg/5s0Ojvs9+ni3W8KdivywufY588TeuJmlELk/bYWU44JgoJWL5/qvaDeuf4QrV68AqIcAdMeBMOBizE1fXCqo6Y0zStsoFy77VnOWSZZ1OZPuwVsxWbgCeNWIV+rvMes3ZBx6x3ZfcK4JKfWIZSnYMAiZ1gUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az9I0rBj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e3402349f3so393699241.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711998535; x=1712603335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOvrzTCyLU2zYSdwGyhKNeLxcLQi2Cb3/NLDK3kcm0A=;
        b=Az9I0rBj1UCXhw7L1S87Kn7DWMRw1ibyK2su0OdIXIjgkAx6Lts1jr66F2E2k53ftU
         zZrCmkxKJgIRqCieK79iQjWgb++6Xl7w1k7yb3inZD30YPF95dh0k7x0W84u3dPKqVmQ
         qXdMc65AkGrWIIByAHi6EaBDz1egT45kFv8uaJBSuLgD5RwrLluMIpEXBg25ugbkvjcB
         eBszeK1TeyKxuhxec4uaPvut3yKQrQns75yaaapWUODvI8x/nM9P7Bif0DB0DR7E4/Bv
         CkTgettp4E7WhmoyFUMvcYJkRJgfWbpL5BuXVpA5FeXnfJ30uKRayPTPb65Ij9Y7VdjJ
         OFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998535; x=1712603335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOvrzTCyLU2zYSdwGyhKNeLxcLQi2Cb3/NLDK3kcm0A=;
        b=pgppBc3LvMPRRmrkyENjfq0q6cOL6ffGU3yZ6XsA20kqGx10vy0pSunSl9E9PLHH8c
         FEMUhOdzUZoX7/TEE1iKn3tnR+nXPxP6CIqNvbxAWYJorldGTW09a9f3qRO5ClI/Y+e5
         r324xzPyLCuQAkIkAEDJQE5RJzeQyABgwXE0DGGSO0x+sVpd6XL2v0vZhLpxGjzGId9Y
         b065J4jd2Jp0JVocDiCzwj291m30TQGbAbD/C0fq9NLFgQze/989LKci2IcS2225Qrqs
         wZ0TZzslxArfv8ClSBs1V1SXH9UU/2PbIX5t/LQjhV+O0RpLgKiFFxv14xBPc2jleVQl
         19BA==
X-Forwarded-Encrypted: i=1; AJvYcCVaxV2pQg20GI1kecxhyoXNKo6zY0r11R2p3JLH+bEiG0yxpmW4dUB5bsDhVDDTueNv2aBA0N5f8U/1RsVdh1AXUIbX5utfKgsg5aCH
X-Gm-Message-State: AOJu0YzZpD85xth3+TGouWwbvlrN24ZqR5wzXHF/inoM1Jt8azOKpQ2E
	YvisZKl9e9SFDFYZ7d6peSnr+I+crmsca6OdISgWESthuy9iMbMLpd+i/KMhtH410cMOxEAFVAT
	magNtbAzd3TLP6A9MJFgmOzoytC+tPf7QUnLQ6A==
X-Google-Smtp-Source: AGHT+IE5rCTfnPwEV1LpuhXD64/5XG0d1xw7QCBCiuJpLWM93bWclsqoFVdWV5gXBlS/pSHEKSMsvuunp1HEc/YYATM=
X-Received: by 2002:a05:6102:3166:b0:476:de04:5953 with SMTP id
 l6-20020a056102316600b00476de045953mr7211552vsm.23.1711998535354; Mon, 01 Apr
 2024 12:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329032009.3395384-1-chao@kernel.org>
In-Reply-To: <20240329032009.3395384-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 1 Apr 2024 12:08:44 -0700
Message-ID: <CACOAw_xNmY1Fcd7MccX33LfGr4bgqDT29y8xdfBBFxVMj9xxPg@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: zone: don't block IO if there is remained open zone
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:20=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
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
> v2:
> - remove unneeded declaration.
>  fs/f2fs/data.c    | 80 +++++++++++++++++++++++++----------------------
>  fs/f2fs/f2fs.h    | 33 ++++++++++++++++---
>  fs/f2fs/iostat.c  |  7 +++++
>  fs/f2fs/iostat.h  |  2 ++
>  fs/f2fs/segment.c | 58 ++++++++++++++++++++++++++++++----
>  fs/f2fs/segment.h | 12 ++++++-
>  fs/f2fs/super.c   |  2 ++
>  7 files changed, 145 insertions(+), 49 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0d88649c60a5..132a3ede60b1 100644
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

I am not sure this part isn't racy with the part in __allocate_new_segment(=
).

Thanks,

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
> @@ -918,22 +935,16 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
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
> @@ -944,20 +955,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
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
> @@ -985,6 +990,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio=
)
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
> @@ -1010,15 +1020,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *=
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
> index 694f8a52cb84..41a07bedf0a1 100644
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
> @@ -4469,6 +4470,28 @@ static inline bool f2fs_blkz_is_seq(struct f2fs_sb=
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
> index 4fd76e867e0a..9b11cd7888b9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3140,6 +3140,23 @@ static int __allocate_new_segment(struct f2fs_sb_i=
nfo *sbi, int type,
>                 return err;
>         stat_inc_seg_type(sbi, curseg);
>         locate_dirty_segment(sbi, old_segno);
> +
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (f2fs_sb_has_blkzoned(sbi)) {
> +               struct f2fs_bio_info *io;
> +
> +               io =3D sbi->write_io[PAGE_TYPE(type)] + type_to_temp(type=
);
> +
> +               f2fs_down_write(&io->io_rwsem);
> +               if (io->zone_openned) {
> +                       up(&sbi->available_open_zones);
> +                       io->zone_openned =3D false;
> +               }
> +               f2fs_up_write(&io->io_rwsem);
> +       }
> +#endif
> +
>         return 0;
>  }
>
> @@ -3461,12 +3478,7 @@ static int __get_segment_type(struct f2fs_io_info =
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
> @@ -4132,6 +4144,27 @@ static int restore_curseg_summaries(struct f2fs_sb=
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
> @@ -5451,6 +5484,19 @@ static void destroy_curseg(struct f2fs_sb_info *sb=
i)
>         for (i =3D 0; i < NR_CURSEG_TYPE; i++) {
>                 kfree(array[i].sum_blk);
>                 kfree(array[i].journal);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (f2fs_sb_has_blkzoned(sbi)) {
> +               enum page_type ptype =3D PAGE_TYPE(i);
> +               enum temp_type temp =3D type_to_temp(i);
> +
> +               if (sbi->write_io[ptype][temp].zone_openned) {
> +                       up(&sbi->available_open_zones);
> +                       sbi->write_io[ptype][temp].zone_openned =3D false=
;
> +               }
> +       }
> +#endif
> +
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
> index 642540782471..e398800a192d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3895,6 +3895,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi,=
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

