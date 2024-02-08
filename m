Return-Path: <linux-kernel+bounces-57316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDB84D6F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E2E2876B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E735101C3;
	Thu,  8 Feb 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDUVurlo"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E769D53C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351084; cv=none; b=imfOY2qsNldvfrSRorzN/usa3yFrIV8+QQwcwTO2BbO1tV2yHRPiIBotMkfzOW0XKyVQvzRVpWdQjHomIOTR0A5kRnAuLMUOyoQvgXvAp1YVul29TvknTx3bUSziZOAAnrQO3dgEuXRpMU7vvGqavh3jWqJYiAzh2exblgaLWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351084; c=relaxed/simple;
	bh=z01ZW8+UWT0BLNkvRuqQRRCgA0AXwG+doSHPzHP38rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM5BHfkNb45JTsSoZtvQmpsMJRdKHEgbmx0gBpic/FCbcEZfikbZiYoNRWSX9HInC0W47jmwkJdaZ9q7ZIrLGbl44fVkkvJ3nJtbeu1zejNY5jiVciAWu5jsPsKTu8EoeFpMfwC0ZyfGI2DMCbG5FI0dI2y7KL+h+8RGlrlBQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDUVurlo; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso605526241.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 16:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707351081; x=1707955881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGK6vYCvNZfpPsdvd/0H42FbCslpzkNqaM5qJwtPUbA=;
        b=MDUVurlo7S1/CsBUc8KFjQkFBhpxTSOKu1jxiwyLRNWfEUumHFmyLpQWCCZStMESlK
         CTZIj+fXbPmskYmhHDV/SRpRhlGiYdRp39DMQzYo+LY3d5Ls2Mz8UfokwWGS/Srg0WH/
         YYpZorPaMVSd8To8+ux4GnMwilUEGqwM/YTDlwmZ3ixucaI9jRforRXyZ15bJHCF9u3o
         ZTclfjCUxwYRx3sMzo6NFXjKldRpaCchCNmvNDreUJI2ndaY/IsZTZWJN/WJYhKiCVRd
         rUrfcHYj22XktWRrhLyCNiOE37EH4qCA10LWsLdsDCnP1qTBfDdXUZfUzFcpjGdetoVN
         PC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351081; x=1707955881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGK6vYCvNZfpPsdvd/0H42FbCslpzkNqaM5qJwtPUbA=;
        b=TlxEkkroOeAzj7Cg9x6iYgvpcqcLjJnoF32kqFWxY394ozt/RV3z4D490KpKZsBPge
         xDVbSIlHQ2pU8I3am3MhjIJVVjKOK8L/SwNPLp76/YatWTU0Ee5Y2QJ9F8ZLT5m5kULd
         QYdj9cfwl6KV5gPV/YtihCwi4wNQlRZsAkR0yhcaqK3uN8JMrH0kEO1vIj5pQbK1Z6Sc
         PrGh6bmVPzEuYb5rw4O0feJXpc8NDvsW0pT/ESMmmWa7pV6DLw31IEMANxRwFD8XeSzW
         HLkDB3moOX+TWAnE3qmY9RErgUzhu5oB/milSZhxC/g4xWKrkFbjrN6m1W8P2itxAZLK
         WgQw==
X-Gm-Message-State: AOJu0Yw1alvvvyXnomoSAJOI9vhLZZCF48qA4Ue0+HQhr67zqmefpE2q
	/nNqe03uKpkji7Pq3Wv1FQx+1hhcRRisTcSnm3FAgVN6yEZ5QPeTycX5h56w2CCg0K9XNm8Gkeh
	NkSUiPHbPGIYUWn2TxhlRc4tVEjQ=
X-Google-Smtp-Source: AGHT+IF3GP1h/TYJ117H2vshDSM13sYkIMTBj8O15HI980dWRTHb8pcu+A4vqMUH7mLxs3icpNbKZASbxHsNpqvnj1w=
X-Received: by 2002:a05:6102:83c:b0:46d:408f:5568 with SMTP id
 k28-20020a056102083c00b0046d408f5568mr3804870vsb.7.1707351080814; Wed, 07 Feb
 2024 16:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
In-Reply-To: <20240207005105.3744811-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 7 Feb 2024 16:11:09 -0800
Message-ID: <CACOAw_wmYwTBdJHfezVPeAeW7kmSyxXoFPnNBAt6=H=wOrvS4w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: deprecate io_bits
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Tue, Feb 6, 2024 at 4:54=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> Let's deprecate an unused io_bits feature to save CPU cycles and memory.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/filesystems/f2fs.rst |  2 -
>  fs/f2fs/data.c                     | 73 +------------------------
>  fs/f2fs/f2fs.h                     | 25 ++-------
>  fs/f2fs/file.c                     |  2 -
>  fs/f2fs/gc.c                       | 10 +---
>  fs/f2fs/segment.c                  |  9 +--
>  fs/f2fs/super.c                    | 88 +-----------------------------
>  include/linux/f2fs_fs.h            |  6 --
>  8 files changed, 10 insertions(+), 205 deletions(-)
>
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesyste=
ms/f2fs.rst
> index 32cbfa864f38..9ac5083dae8e 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -229,8 +229,6 @@ mode=3D%s                      Control block allocati=
on mode which supports "adaptive"
>                          option for more randomness.
>                          Please, use these options for your experiments a=
nd we strongly
>                          recommend to re-format the filesystem after usin=
g these options.
> -io_bits=3D%u              Set the bit size of write IO requests. It shou=
ld be set
> -                        with "mode=3Dlfs".
>  usrquota                Enable plain user disk quota accounting.
>  grpquota                Enable plain group disk quota accounting.
>  prjquota                Enable plain project quota accounting.
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 05158f89ef32..828c797cd47c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -338,17 +338,6 @@ static void f2fs_write_end_io(struct bio *bio)
>                 struct page *page =3D bvec->bv_page;
>                 enum count_type type =3D WB_DATA_TYPE(page, false);
>
> -               if (page_private_dummy(page)) {
> -                       clear_page_private_dummy(page);
> -                       unlock_page(page);
> -                       mempool_free(page, sbi->write_io_dummy);
> -
> -                       if (unlikely(bio->bi_status))
> -                               f2fs_stop_checkpoint(sbi, true,
> -                                               STOP_CP_REASON_WRITE_FAIL=
);
> -                       continue;
> -               }
> -
>                 fscrypt_finalize_bounce_page(&page);
>
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -522,50 +511,13 @@ void f2fs_submit_read_bio(struct f2fs_sb_info *sbi,=
 struct bio *bio,
>         submit_bio(bio);
>  }
>
> -static void f2fs_align_write_bio(struct f2fs_sb_info *sbi, struct bio *b=
io)
> -{
> -       unsigned int start =3D
> -               (bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS) % F2FS_IO_SIZ=
E(sbi);
> -
> -       if (start =3D=3D 0)
> -               return;
> -
> -       /* fill dummy pages */
> -       for (; start < F2FS_IO_SIZE(sbi); start++) {
> -               struct page *page =3D
> -                       mempool_alloc(sbi->write_io_dummy,
> -                                     GFP_NOIO | __GFP_NOFAIL);
> -               f2fs_bug_on(sbi, !page);
> -
> -               lock_page(page);
> -
> -               zero_user_segment(page, 0, PAGE_SIZE);
> -               set_page_private_dummy(page);
> -
> -               if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
> -                       f2fs_bug_on(sbi, 1);
> -       }
> -}
> -
>  static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *=
bio,
>                                   enum page_type type)
>  {
>         WARN_ON_ONCE(is_read_io(bio_op(bio)));
>
> -       if (type =3D=3D DATA || type =3D=3D NODE) {
> -               if (f2fs_lfs_mode(sbi) && current->plug)
> -                       blk_finish_plug(current->plug);
> -
> -               if (F2FS_IO_ALIGNED(sbi)) {
> -                       f2fs_align_write_bio(sbi, bio);
> -                       /*
> -                        * In the NODE case, we lose next block address c=
hain.
> -                        * So, we need to do checkpoint in f2fs_sync_file=
.
> -                        */
> -                       if (type =3D=3D NODE)
> -                               set_sbi_flag(sbi, SBI_NEED_CP);
> -               }
> -       }
> +       if (f2fs_lfs_mode(sbi) && current->plug && PAGE_TYPE_ON_MAIN(type=
))
> +               blk_finish_plug(current->plug);
>
>         trace_f2fs_submit_write_bio(sbi->sb, type, bio);
>         iostat_update_submit_ctx(bio, type);
> @@ -794,16 +746,6 @@ static bool io_is_mergeable(struct f2fs_sb_info *sbi=
, struct bio *bio,
>                                         block_t last_blkaddr,
>                                         block_t cur_blkaddr)
>  {
> -       if (F2FS_IO_ALIGNED(sbi) && (fio->type =3D=3D DATA || fio->type =
=3D=3D NODE)) {
> -               unsigned int filled_blocks =3D
> -                               F2FS_BYTES_TO_BLK(bio->bi_iter.bi_size);
> -               unsigned int io_size =3D F2FS_IO_SIZE(sbi);
> -               unsigned int left_vecs =3D bio->bi_max_vecs - bio->bi_vcn=
t;
> -
> -               /* IOs in bio is aligned and left space of vectors is not=
 enough */
> -               if (!(filled_blocks % io_size) && left_vecs < io_size)
> -                       return false;
> -       }
>         if (!page_is_mergeable(sbi, bio, last_blkaddr, cur_blkaddr))
>                 return false;
>         return io_type_is_mergeable(io, fio);
> @@ -1055,14 +997,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>                 __submit_merged_bio(io);
>  alloc_new:
>         if (io->bio =3D=3D NULL) {
> -               if (F2FS_IO_ALIGNED(sbi) &&
> -                               (fio->type =3D=3D DATA || fio->type =3D=
=3D NODE) &&
> -                               fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)=
) {
> -                       dec_page_count(sbi, WB_DATA_TYPE(bio_page,
> -                                               fio->compressed_page));
> -                       fio->retry =3D 1;
> -                       goto skip;
> -               }
>                 io->bio =3D __bio_alloc(fio, BIO_MAX_VECS);
>                 f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
>                                        bio_page->index, fio, GFP_NOIO);
> @@ -1092,7 +1026,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>                 __submit_merged_bio(io);
>         }
>  #endif
> -skip:
>         if (fio->in_list)
>                 goto next;
>  out:
> @@ -2669,8 +2602,6 @@ bool f2fs_should_update_outplace(struct inode *inod=
e, struct f2fs_io_info *fio)
>         if (fio) {
>                 if (page_private_gcing(fio->page))
>                         return true;
> -               if (page_private_dummy(fio->page))
> -                       return true;
>                 if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>                         f2fs_is_checkpointed_data(sbi, fio->old_blkaddr))=
)
>                         return true;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 543898482f8b..4c52136cbc10 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -148,7 +148,6 @@ struct f2fs_rwsem {
>
>  struct f2fs_mount_info {
>         unsigned int opt;
> -       int write_io_size_bits;         /* Write IO size bits */
>         block_t root_reserved_blocks;   /* root reserved blocks */
>         kuid_t s_resuid;                /* reserved blocks for uid */
>         kgid_t s_resgid;                /* reserved blocks for gid */
> @@ -1117,6 +1116,7 @@ enum count_type {
>   * ...                 Only can be used with META.
>   */
>  #define PAGE_TYPE_OF_BIO(type) ((type) > META ? META : (type))
> +#define PAGE_TYPE_ON_MAIN(type)        ((type) =3D=3D DATA || (type) =3D=
=3D NODE)
>  enum page_type {
>         DATA =3D 0,
>         NODE =3D 1,       /* should not change this */
> @@ -1211,7 +1211,6 @@ struct f2fs_io_info {
>         unsigned int submitted:1;       /* indicate IO submission */
>         unsigned int in_list:1;         /* indicate fio is in io_list */
>         unsigned int is_por:1;          /* indicate IO is from recovery o=
r not */
> -       unsigned int retry:1;           /* need to reallocate block addre=
ss */
>         unsigned int encrypted:1;       /* indicate file is encrypted */
>         unsigned int post_read:1;       /* require post read */
>         enum iostat_type io_type;       /* io type */
> @@ -1413,18 +1412,16 @@ static inline void f2fs_clear_bit(unsigned int nr=
, char *addr);
>   * Layout A: lowest bit should be 1
>   * | bit0 =3D 1 | bit1 | bit2 | ... | bit MAX | private data .... |
>   * bit 0       PAGE_PRIVATE_NOT_POINTER
> - * bit 1       PAGE_PRIVATE_DUMMY_WRITE
> - * bit 2       PAGE_PRIVATE_ONGOING_MIGRATION
> - * bit 3       PAGE_PRIVATE_INLINE_INODE
> - * bit 4       PAGE_PRIVATE_REF_RESOURCE
> - * bit 5-      f2fs private data
> + * bit 1       PAGE_PRIVATE_ONGOING_MIGRATION
> + * bit 2       PAGE_PRIVATE_INLINE_INODE
> + * bit 3       PAGE_PRIVATE_REF_RESOURCE
> + * bit 4-      f2fs private data
>   *
>   * Layout B: lowest bit should be 0
>   * page.private is a wrapped pointer.
>   */
>  enum {
>         PAGE_PRIVATE_NOT_POINTER,               /* private contains non-p=
ointer data */
> -       PAGE_PRIVATE_DUMMY_WRITE,               /* data page for padding =
aligned IO */
>         PAGE_PRIVATE_ONGOING_MIGRATION,         /* data page which is on-=
going migrating */
>         PAGE_PRIVATE_INLINE_INODE,              /* inode page contains in=
line data */
>         PAGE_PRIVATE_REF_RESOURCE,              /* dirty page has referen=
ced resources */
> @@ -1571,7 +1568,6 @@ struct f2fs_sb_info {
>         struct f2fs_bio_info *write_io[NR_PAGE_TYPE];   /* for write bios=
 */
>         /* keep migration IO order for LFS mode */
>         struct f2fs_rwsem io_order_lock;
> -       mempool_t *write_io_dummy;              /* Dummy pages */
>         pgoff_t page_eio_ofs[NR_PAGE_TYPE];     /* EIO page offset */
>         int page_eio_cnt[NR_PAGE_TYPE];         /* EIO count */
>
> @@ -2307,10 +2303,6 @@ static inline int inc_valid_block_count(struct f2f=
s_sb_info *sbi,
>         if (!__allow_reserved_blocks(sbi, inode, true))
>                 avail_user_block_count -=3D F2FS_OPTION(sbi).root_reserve=
d_blocks;
>
> -       if (F2FS_IO_ALIGNED(sbi))
> -               avail_user_block_count -=3D sbi->blocks_per_seg *
> -                               SM_I(sbi)->additional_reserved_segments;
> -
>         if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>                 if (avail_user_block_count > sbi->unusable_block_count)
>                         avail_user_block_count -=3D sbi->unusable_block_c=
ount;
> @@ -2378,17 +2370,14 @@ static inline void clear_page_private_##name(stru=
ct page *page) \
>  PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
>  PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
>  PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
> -PAGE_PRIVATE_GET_FUNC(dummy, DUMMY_WRITE);
>
>  PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
>  PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
>  PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
> -PAGE_PRIVATE_SET_FUNC(dummy, DUMMY_WRITE);
>
>  PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
>  PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
>  PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
> -PAGE_PRIVATE_CLEAR_FUNC(dummy, DUMMY_WRITE);
>
>  static inline unsigned long get_page_private_data(struct page *page)
>  {
> @@ -2644,10 +2633,6 @@ static inline int inc_valid_node_count(struct f2fs=
_sb_info *sbi,
>         if (!__allow_reserved_blocks(sbi, inode, false))
>                 valid_block_count +=3D F2FS_OPTION(sbi).root_reserved_blo=
cks;
>
> -       if (F2FS_IO_ALIGNED(sbi))
> -               valid_block_count +=3D sbi->blocks_per_seg *
> -                               SM_I(sbi)->additional_reserved_segments;
> -
>         user_block_count =3D sbi->user_block_count;
>         if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>                 user_block_count -=3D sbi->unusable_block_count;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 25b119cf3499..c6cd9474ba2d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -822,8 +822,6 @@ static bool f2fs_force_buffered_io(struct inode *inod=
e, int rw)
>          */
>         if (f2fs_sb_has_blkzoned(sbi) && (rw =3D=3D WRITE))
>                 return true;
> -       if (f2fs_lfs_mode(sbi) && rw =3D=3D WRITE && F2FS_IO_ALIGNED(sbi)=
)
> -               return true;
>         if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
>                 return true;
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a079eebfb080..6899f434ad68 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1184,7 +1184,6 @@ static int ra_data_block(struct inode *inode, pgoff=
_t index)
>                 .op_flags =3D 0,
>                 .encrypted_page =3D NULL,
>                 .in_list =3D 0,
> -               .retry =3D 0,
>         };
>         int err;
>
> @@ -1273,7 +1272,6 @@ static int move_data_block(struct inode *inode, blo=
ck_t bidx,
>                 .op_flags =3D 0,
>                 .encrypted_page =3D NULL,
>                 .in_list =3D 0,
> -               .retry =3D 0,
>         };
>         struct dnode_of_data dn;
>         struct f2fs_summary sum;
> @@ -1393,18 +1391,12 @@ static int move_data_block(struct inode *inode, b=
lock_t bidx,
>         fio.op_flags =3D REQ_SYNC;
>         fio.new_blkaddr =3D newaddr;
>         f2fs_submit_page_write(&fio);
> -       if (fio.retry) {
> -               err =3D -EAGAIN;
> -               if (PageWriteback(fio.encrypted_page))
> -                       end_page_writeback(fio.encrypted_page);
> -               goto put_page_out;
> -       }
>
>         f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO, F2FS_BLKSIZE);
>
>         f2fs_update_data_blkaddr(&dn, newaddr);
>         set_inode_flag(inode, FI_APPEND_WRITE);
> -put_page_out:
> +
>         f2fs_put_page(fio.encrypted_page, 1);
>  recover_block:
>         if (err)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7901ede58113..e5759813276a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3507,9 +3507,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *=
sbi, struct page *page,
>         if (fio) {
>                 struct f2fs_bio_info *io;
>
> -               if (F2FS_IO_ALIGNED(sbi))
> -                       fio->retry =3D 0;
> -
>                 INIT_LIST_HEAD(&fio->list);
>                 fio->in_list =3D 1;
>                 io =3D sbi->write_io[fio->type] + fio->temp;
> @@ -3557,7 +3554,7 @@ static void do_write_page(struct f2fs_summary *sum,=
 struct f2fs_io_info *fio)
>
>         if (keep_order)
>                 f2fs_down_read(&fio->sbi->io_order_lock);
> -reallocate:
> +
>         f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
>                         &fio->new_blkaddr, sum, type, fio);
>         if (GET_SEGNO(fio->sbi, fio->old_blkaddr) !=3D NULL_SEGNO)
> @@ -3565,10 +3562,6 @@ static void do_write_page(struct f2fs_summary *sum=
, struct f2fs_io_info *fio)
>
>         /* writeout dirty page into bdev */
>         f2fs_submit_page_write(fio);
> -       if (fio->retry) {
> -               fio->old_blkaddr =3D fio->new_blkaddr;
> -               goto reallocate;
> -       }
>
>         f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1)=
;
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1b718bebfaa1..f1516fd5088a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -138,7 +138,6 @@ enum {
>         Opt_resgid,
>         Opt_resuid,
>         Opt_mode,
> -       Opt_io_size_bits,
>         Opt_fault_injection,
>         Opt_fault_type,
>         Opt_lazytime,
> @@ -217,7 +216,6 @@ static match_table_t f2fs_tokens =3D {
>         {Opt_resgid, "resgid=3D%u"},
>         {Opt_resuid, "resuid=3D%u"},
>         {Opt_mode, "mode=3D%s"},
> -       {Opt_io_size_bits, "io_bits=3D%u"},
>         {Opt_fault_injection, "fault_injection=3D%u"},
>         {Opt_fault_type, "fault_type=3D%u"},
>         {Opt_lazytime, "lazytime"},
> @@ -349,46 +347,6 @@ static inline void limit_reserve_root(struct f2fs_sb=
_info *sbi)
>                                            F2FS_OPTION(sbi).s_resgid));
>  }
>
> -static inline int adjust_reserved_segment(struct f2fs_sb_info *sbi)
> -{
> -       unsigned int sec_blks =3D sbi->blocks_per_seg * sbi->segs_per_sec=
;
> -       unsigned int avg_vblocks;
> -       unsigned int wanted_reserved_segments;
> -       block_t avail_user_block_count;
> -
> -       if (!F2FS_IO_ALIGNED(sbi))
> -               return 0;
> -
> -       /* average valid block count in section in worst case */
> -       avg_vblocks =3D sec_blks / F2FS_IO_SIZE(sbi);
> -
> -       /*
> -        * we need enough free space when migrating one section in worst =
case
> -        */
> -       wanted_reserved_segments =3D (F2FS_IO_SIZE(sbi) / avg_vblocks) *
> -                                               reserved_segments(sbi);
> -       wanted_reserved_segments -=3D reserved_segments(sbi);
> -
> -       avail_user_block_count =3D sbi->user_block_count -
> -                               sbi->current_reserved_blocks -
> -                               F2FS_OPTION(sbi).root_reserved_blocks;
> -
> -       if (wanted_reserved_segments * sbi->blocks_per_seg >
> -                                       avail_user_block_count) {
> -               f2fs_err(sbi, "IO align feature can't grab additional res=
erved segment: %u, available segments: %u",
> -                       wanted_reserved_segments,
> -                       avail_user_block_count >> sbi->log_blocks_per_seg=
);
> -               return -ENOSPC;
> -       }
> -
> -       SM_I(sbi)->additional_reserved_segments =3D wanted_reserved_segme=
nts;
> -
> -       f2fs_info(sbi, "IO align feature needs additional reserved segmen=
t: %u",
> -                        wanted_reserved_segments);
> -
> -       return 0;
> -}
> -
>  static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
>  {
>         if (!F2FS_OPTION(sbi).unusable_cap_perc)
> @@ -919,16 +877,6 @@ static int parse_options(struct super_block *sb, cha=
r *options, bool is_remount)
>                         }
>                         kfree(name);
>                         break;
> -               case Opt_io_size_bits:
> -                       if (args->from && match_int(args, &arg))
> -                               return -EINVAL;
> -                       if (arg <=3D 0 || arg > __ilog2_u32(BIO_MAX_VECS)=
) {
> -                               f2fs_warn(sbi, "Not support %ld, larger t=
han %d",
> -                                       BIT(arg), BIO_MAX_VECS);
> -                               return -EINVAL;
> -                       }
> -                       F2FS_OPTION(sbi).write_io_size_bits =3D arg;
> -                       break;
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>                 case Opt_fault_injection:
>                         if (args->from && match_int(args, &arg))
> @@ -1398,12 +1346,6 @@ static int parse_options(struct super_block *sb, c=
har *options, bool is_remount)
>         }
>  #endif
>
> -       if (F2FS_IO_SIZE_BITS(sbi) && !f2fs_lfs_mode(sbi)) {
> -               f2fs_err(sbi, "Should set mode=3Dlfs with %luKB-sized IO"=
,
> -                        F2FS_IO_SIZE_KB(sbi));
> -               return -EINVAL;
> -       }
> -
>         if (test_opt(sbi, INLINE_XATTR_SIZE)) {
>                 int min_size, max_size;
>
> @@ -1724,7 +1666,6 @@ static void f2fs_put_super(struct super_block *sb)
>
>         f2fs_destroy_page_array_cache(sbi);
>         f2fs_destroy_xattr_caches(sbi);
> -       mempool_destroy(sbi->write_io_dummy);
>  #ifdef CONFIG_QUOTA
>         for (i =3D 0; i < MAXQUOTAS; i++)
>                 kfree(F2FS_OPTION(sbi).s_qf_names[i]);
> @@ -2084,9 +2025,6 @@ static int f2fs_show_options(struct seq_file *seq, =
struct dentry *root)
>                                         F2FS_OPTION(sbi).s_resuid),
>                                 from_kgid_munged(&init_user_ns,
>                                         F2FS_OPTION(sbi).s_resgid));
> -       if (F2FS_IO_SIZE_BITS(sbi))
> -               seq_printf(seq, ",io_bits=3D%u",
> -                               F2FS_OPTION(sbi).write_io_size_bits);
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>         if (test_opt(sbi, FAULT_INJECTION)) {
>                 seq_printf(seq, ",fault_injection=3D%u",
> @@ -2338,7 +2276,6 @@ static int f2fs_remount(struct super_block *sb, int=
 *flags, char *data)
>         bool no_read_extent_cache =3D !test_opt(sbi, READ_EXTENT_CACHE);
>         bool no_age_extent_cache =3D !test_opt(sbi, AGE_EXTENT_CACHE);
>         bool enable_checkpoint =3D !test_opt(sbi, DISABLE_CHECKPOINT);
> -       bool no_io_align =3D !F2FS_IO_ALIGNED(sbi);
>         bool no_atgc =3D !test_opt(sbi, ATGC);
>         bool no_discard =3D !test_opt(sbi, DISCARD);
>         bool no_compress_cache =3D !test_opt(sbi, COMPRESS_CACHE);
> @@ -2446,12 +2383,6 @@ static int f2fs_remount(struct super_block *sb, in=
t *flags, char *data)
>                 goto restore_opts;
>         }
>
> -       if (no_io_align =3D=3D !!F2FS_IO_ALIGNED(sbi)) {
> -               err =3D -EINVAL;
> -               f2fs_warn(sbi, "switch io_bits option is not allowed");
> -               goto restore_opts;
> -       }
> -
>         if (no_compress_cache =3D=3D !!test_opt(sbi, COMPRESS_CACHE)) {
>                 err =3D -EINVAL;
>                 f2fs_warn(sbi, "switch compress_cache option is not allow=
ed");
> @@ -4314,8 +4245,6 @@ static int f2fs_scan_devices(struct f2fs_sb_info *s=
bi)
>                           FDEV(i).total_segments,
>                           FDEV(i).start_blk, FDEV(i).end_blk);
>         }
> -       f2fs_info(sbi,
> -                 "IO Block Size: %8ld KB", F2FS_IO_SIZE_KB(sbi));
>         return 0;
>  }
>
> @@ -4528,19 +4457,10 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
>         if (err)
>                 goto free_iostat;
>
> -       if (F2FS_IO_ALIGNED(sbi)) {
> -               sbi->write_io_dummy =3D
> -                       mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) -=
 1), 0);
> -               if (!sbi->write_io_dummy) {
> -                       err =3D -ENOMEM;
> -                       goto free_percpu;
> -               }
> -       }
> -
>         /* init per sbi slab cache */
>         err =3D f2fs_init_xattr_caches(sbi);
>         if (err)
> -               goto free_io_dummy;
> +               goto free_percpu;
>         err =3D f2fs_init_page_array_cache(sbi);
>         if (err)
>                 goto free_xattr_cache;
> @@ -4628,10 +4548,6 @@ static int f2fs_fill_super(struct super_block *sb,=
 void *data, int silent)
>                 goto free_nm;
>         }
>
> -       err =3D adjust_reserved_segment(sbi);
> -       if (err)
> -               goto free_nm;
> -
>         /* For write statistics */
>         sbi->sectors_written_start =3D f2fs_get_sectors_written(sbi);
>
> @@ -4862,8 +4778,6 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>         f2fs_destroy_page_array_cache(sbi);
>  free_xattr_cache:
>         f2fs_destroy_xattr_caches(sbi);
> -free_io_dummy:
> -       mempool_destroy(sbi->write_io_dummy);
>  free_percpu:
>         destroy_percpu_info(sbi);
>  free_iostat:
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 053137a0fe45..9b69c50255b2 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -40,12 +40,6 @@
>
>  #define F2FS_ENC_UTF8_12_1     1
>
> -#define F2FS_IO_SIZE(sbi)      BIT(F2FS_OPTION(sbi).write_io_size_bits) =
/* Blocks */
> -#define F2FS_IO_SIZE_KB(sbi)   BIT(F2FS_OPTION(sbi).write_io_size_bits +=
 2) /* KB */
> -#define F2FS_IO_SIZE_BITS(sbi) (F2FS_OPTION(sbi).write_io_size_bits) /* =
power of 2 */
> -#define F2FS_IO_SIZE_MASK(sbi) (F2FS_IO_SIZE(sbi) - 1)
> -#define F2FS_IO_ALIGNED(sbi)   (F2FS_IO_SIZE(sbi) > 1)
> -
>  /* This flag is used by node and meta inodes, and by recovery */
>  #define GFP_F2FS_ZERO          (GFP_NOFS | __GFP_ZERO)
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

