Return-Path: <linux-kernel+bounces-22918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67AB82A570
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A01C22E72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2113624;
	Thu, 11 Jan 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anDN13/M"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225F38F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4b743ca0597so1113743e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704934519; x=1705539319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea5zVOpj9Ubd0eJbED71QzNo2kZcGma98yI7Zk7sjq0=;
        b=anDN13/Mo9jVdRvGxAJ4TyyMCD0EDsgwXZw/ENcLybc9dv7pr49+DtHqiznBwAdFIH
         X30gtPTPNZwOi8FGjzj/na6pGMzo/NSUsEC6JZ7vMzQkmc5KT1+Km03jmKc/WIZmaCaZ
         ofORQGjYXVRRx363zca9Wkf0SBwftIpbzfCUSP01mFG+yfyouUEAdOEziPpQIaHvDVag
         D1J/d+ldSfcnUCVkRbI1/k++dmZJveN0NDFw3x/GY0e/NEvGWmcdYIa8R/QCW9uAc7ps
         cuW2byxfk9XhcOKSQUbA+/IleNU9jxI+VqRDbxaJ8dK7d8z28S17/L9DZiuMP1a/7iQh
         TyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704934519; x=1705539319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea5zVOpj9Ubd0eJbED71QzNo2kZcGma98yI7Zk7sjq0=;
        b=Va7oS1uk23JIQUhkxJBbVLoSJgDyoMptfhHHNXVDJHDObyIJysc3HVxtvMM/u103D7
         1sZ/2gpz6uaAaouFKzYjNikOr1emwY/TdXsAkA9hoLgfvTVPDqDFkmS1iAMhEcPisg4B
         s9J7tYtKqrSIBK9cToLtpln9IhpIS3KRSjVburuShY97kPdGw9qi5CF3VuDJFaljBG2F
         m1rQRlzjp1TDR9LR126vabHQa9qd/3hbaUY2iETqbs5c989A2EhBJjY6Ysd4mkK2jGDv
         /+tUyyOnqhwRCUA/c5guJ260O1nHDCUK2ZPwqKBxN1WzHZmVvP+hopdWpLfj0HX1bGKN
         ArAw==
X-Gm-Message-State: AOJu0Yz3QUHKpwn9w9M2Bi3JJaoN8mL6R+BjSEs0MuIDsu0gTEshYIJa
	7kysIdR1emRL+qCY6G2BzDCIuGIql+Kfl7uSK2F40gGCCDkFJnzy
X-Google-Smtp-Source: AGHT+IG5mwXZAP7USA5jhPRJfZddHDN87iEqYGpOZIQwm06Lr02djACIpQ+KguRRuDjeoOgQC4kC1utQU14QNTgsq5Q=
X-Received: by 2002:a05:6122:289a:b0:4b6:ea3a:f887 with SMTP id
 fl26-20020a056122289a00b004b6ea3af887mr285475vkb.22.1704934518993; Wed, 10
 Jan 2024 16:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143152.1543509-1-chao@kernel.org>
In-Reply-To: <20231228143152.1543509-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 10 Jan 2024 16:55:07 -0800
Message-ID: <CACOAw_xXGUt=2JJgq5yfW5ZG7EfZMm1iNTVxvfA9FoJVDwbH_A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 1/6] f2fs: compress: fix to guarantee
 persisting compressed blocks by CP
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 6:33=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> If data block in compressed cluster is not persisted with metadata
> during checkpoint, after SPOR, the data may be corrupted, let's
> guarantee to write compressed page by checkpoint.
>
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - treat compressed page as CP guaranteed data explictly.
>  fs/f2fs/compress.c |  4 +++-
>  fs/f2fs/data.c     | 17 +++++++++--------
>  fs/f2fs/f2fs.h     |  4 +++-
>  3 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c5a4364c4482..9940b7886e5d 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1418,6 +1418,8 @@ void f2fs_compress_write_end_io(struct bio *bio, st=
ruct page *page)
>         struct f2fs_sb_info *sbi =3D bio->bi_private;
>         struct compress_io_ctx *cic =3D
>                         (struct compress_io_ctx *)page_private(page);
> +       enum count_type type =3D WB_DATA_TYPE(page,
> +                               f2fs_is_compressed_page(page));
>         int i;
>
>         if (unlikely(bio->bi_status))
> @@ -1425,7 +1427,7 @@ void f2fs_compress_write_end_io(struct bio *bio, st=
ruct page *page)
>
>         f2fs_compress_free_page(page);
>
> -       dec_page_count(sbi, F2FS_WB_DATA);
> +       dec_page_count(sbi, type);
>
>         if (atomic_dec_return(&cic->pending_pages))
>                 return;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index dce8defdf4c7..81f9e2cc49e2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -48,7 +48,7 @@ void f2fs_destroy_bioset(void)
>         bioset_exit(&f2fs_bioset);
>  }
>
> -static bool __is_cp_guaranteed(struct page *page)
> +bool f2fs_is_cp_guaranteed(struct page *page)
>  {
>         struct address_space *mapping =3D page->mapping;
>         struct inode *inode;
> @@ -65,8 +65,6 @@ static bool __is_cp_guaranteed(struct page *page)
>                         S_ISDIR(inode->i_mode))
>                 return true;
>
> -       if (f2fs_is_compressed_page(page))
> -               return false;

Out of curiosity, why don't we simply change the above to "return true"?

>         if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
>                         page_private_gcing(page))
>                 return true;
> @@ -338,7 +336,7 @@ static void f2fs_write_end_io(struct bio *bio)
>
>         bio_for_each_segment_all(bvec, bio, iter_all) {
>                 struct page *page =3D bvec->bv_page;
> -               enum count_type type =3D WB_DATA_TYPE(page);
> +               enum count_type type =3D WB_DATA_TYPE(page, false);
>
>                 if (page_private_dummy(page)) {
>                         clear_page_private_dummy(page);
> @@ -762,7 +760,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>                 wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZ=
E);
>
>         inc_page_count(fio->sbi, is_read_io(fio->op) ?
> -                       __read_io_type(page) : WB_DATA_TYPE(fio->page));
> +                       __read_io_type(page) : WB_DATA_TYPE(fio->page, fa=
lse));
>
>         if (is_read_io(bio_op(bio)))
>                 f2fs_submit_read_bio(fio->sbi, bio, fio->type);
> @@ -973,7 +971,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>         if (fio->io_wbc)
>                 wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZ=
E);
>
> -       inc_page_count(fio->sbi, WB_DATA_TYPE(page));
> +       inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
>
>         *fio->last_block =3D fio->new_blkaddr;
>         *fio->bio =3D bio;
> @@ -1007,6 +1005,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>         enum page_type btype =3D PAGE_TYPE_OF_BIO(fio->type);
>         struct f2fs_bio_info *io =3D sbi->write_io[btype] + fio->temp;
>         struct page *bio_page;
> +       enum count_type type;
>
>         f2fs_bug_on(sbi, is_read_io(fio->op));
>
> @@ -1046,7 +1045,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>         /* set submitted =3D true as a return value */
>         fio->submitted =3D 1;
>
> -       inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> +       type =3D WB_DATA_TYPE(bio_page, fio->compressed_page);
> +       inc_page_count(sbi, type);
>
>         if (io->bio &&
>             (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bi=
o,
> @@ -1059,7 +1059,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>                 if (F2FS_IO_ALIGNED(sbi) &&
>                                 (fio->type =3D=3D DATA || fio->type =3D=
=3D NODE) &&
>                                 fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)=
) {
> -                       dec_page_count(sbi, WB_DATA_TYPE(bio_page));
> +                       dec_page_count(sbi, WB_DATA_TYPE(bio_page,
> +                                               fio->compressed_page));
>                         fio->retry =3D 1;
>                         goto skip;
>                 }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..50f3d546ded8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1080,7 +1080,8 @@ struct f2fs_sm_info {
>   * f2fs monitors the number of several block types such as on-writeback,
>   * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
>   */
> -#define WB_DATA_TYPE(p)        (__is_cp_guaranteed(p) ? F2FS_WB_CP_DATA =
: F2FS_WB_DATA)
> +#define WB_DATA_TYPE(p, f)                     \
> +       (f || f2fs_is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
>  enum count_type {
>         F2FS_DIRTY_DENTS,
>         F2FS_DIRTY_DATA,
> @@ -3804,6 +3805,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb_info=
 *sbi);
>   */
>  int __init f2fs_init_bioset(void);
>  void f2fs_destroy_bioset(void);
> +bool f2fs_is_cp_guaranteed(struct page *page);
>  int f2fs_init_bio_entry_cache(void);
>  void f2fs_destroy_bio_entry_cache(void);
>  void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

