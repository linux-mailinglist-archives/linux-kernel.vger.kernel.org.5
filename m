Return-Path: <linux-kernel+bounces-10845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1881DD38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FCAB21325
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A0107A2;
	Sun, 24 Dec 2023 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXysfQYZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FF10785
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5537114380bso2735235a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703459546; x=1704064346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz8BH250DNXZnm5NCC+KVYngN4WvNA2Pb5EJ+OBJ8nA=;
        b=FXysfQYZwWAl2poJt8YSGkO5xkqkegMyRPP2juq21GPT5SRs6iQb3peM8E/UjA6ggd
         NReJ5r/4qrgq/gi0l5IxkHeF3rsujQAQGoIX9RHprSMCMdUXd2jNOQol4XAYx4rFlwTm
         nIqF/Ug/1gOhmGy3JHqy+R/HA3lkaHnYFGWk13TD6oYWrXVbqxlApQyXHMCTJWUzx4H0
         koUwskeRmvgu7Zf/hiWExd+iO86HizvO0xhSgBLGZ3T6deW4pXD8MvdkmgxZxDX818SG
         bHjjhnVQ2zfM0WXCXyYilSKK6JMjJfitfR6MDRM8OWyZ6EbBtIk50MrJbpzRQt4HSQR0
         sDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703459546; x=1704064346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz8BH250DNXZnm5NCC+KVYngN4WvNA2Pb5EJ+OBJ8nA=;
        b=m/UAauIXo+4VgdG9Lui/j1osbvKR57Nlzoe0xy6h9HgmIqOy5j45oeErKehuLJgw4i
         wfz2S2bWjuTcVSDl9MTBGXqt0SLDSJIZ6ycYYhP8XdHtmNORWzmgaeJzV4MtMwMmUDMa
         Z0lDTDVJBVIRIIv9+dWk54/AQwvuNy7u/z1rHywbbMdkCUoZZXrcloWhOeZ//cJmWcyt
         N1iMyWPZfVXCf0quoxybKNRoZhwfJnzQDPqsWmZUxZ6qffqv//4NXvpVqgk6zjEX3qHk
         0vg3SUolIuPA7gX/vzMNLOpMqFqEaCsjrbV1HwLIosL656vxF+yACpWO+p4crFyLtzik
         EHOg==
X-Gm-Message-State: AOJu0Yzyn/ovwB6B9eu9Zy4yF4HGB0iRYwRI7YSI8Jh+CCXxWrClVRPZ
	oQpnZkhoLYfSk8eknHnOxL5gK/Nxbql5iDugDbw0WsriIv0=
X-Google-Smtp-Source: AGHT+IFwQtEULHizg0wgmKB2Tzs4nt5pOcJGolKX1QgIJMxCpJWHELuK3qTMyTTtDz4+yh7TvAGgRSlyAW8mfXxPEAQ=
X-Received: by 2002:a50:ccc4:0:b0:552:ad20:521d with SMTP id
 b4-20020a50ccc4000000b00552ad20521dmr3216036edj.40.1703459545582; Sun, 24 Dec
 2023 15:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702958211-23176-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1702958211-23176-1-git-send-email-zhiguo.niu@unisoc.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 25 Dec 2023 07:12:15 +0800
Message-ID: <CAHJ8P3+HD++GyQzCVsktF1zBrHv+CD39WByNJvL6FT0poB4g9w@mail.gmail.com>
Subject: Re: [PATCH V3] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chao,

Do you have any other suggestions about this patch version?
thanks!

On Tue, Dec 19, 2023 at 11:57=E2=80=AFAM Zhiguo Niu <zhiguo.niu@unisoc.com>=
 wrote:
>
> unify the error handling of ERROR_INVALID_BLKADDR in f2fs_is_valid_blkadd=
r
> and remove some redundant codes in f2fs_cache_compressed_page.
>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v2: improve patch according Chao's suggestions.
> changes of v3:
>         -rebase patch to dev-test
>         -correct return value for some f2fs_is_valid_blkaddr error case
> ---
> ---
>  fs/f2fs/checkpoint.c   | 39 ++++++++++++++++++++-------------------
>  fs/f2fs/compress.c     |  4 ----
>  fs/f2fs/data.c         | 24 ++++--------------------
>  fs/f2fs/extent_cache.c |  7 ++-----
>  fs/f2fs/file.c         | 12 ++----------
>  fs/f2fs/gc.c           |  2 --
>  fs/f2fs/node.c         |  2 +-
>  fs/f2fs/recovery.c     |  4 ----
>  fs/f2fs/segment.c      |  2 --
>  9 files changed, 29 insertions(+), 67 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b0597a5..83119aa 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -154,19 +154,17 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *=
sbi, block_t blkaddr,
>         if (unlikely(f2fs_cp_error(sbi)))
>                 return exist;
>
> -       if (exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) {
> -               f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> -                        blkaddr, exist);
> -               set_sbi_flag(sbi, SBI_NEED_FSCK);
> -               return exist;
> -       }
> +       if ((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) ||
> +                       (!exist && type =3D=3D DATA_GENERIC_ENHANCE))
> +               goto err;
>
> -       if (!exist && type =3D=3D DATA_GENERIC_ENHANCE) {
> -               f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> -                        blkaddr, exist);
> -               set_sbi_flag(sbi, SBI_NEED_FSCK);
> -               dump_stack();
> -       }
> +       return exist;
> +err:
> +       f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> +               blkaddr, exist);
> +       set_sbi_flag(sbi, SBI_NEED_FSCK);
> +       dump_stack();
> +       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>         return exist;
>  }
>
> @@ -174,29 +172,29 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi=
,
>                                         block_t blkaddr, int type)
>  {
>         if (time_to_inject(sbi, FAULT_BLKADDR))
> -               return false;
> +               goto err;
>
>         switch (type) {
>         case META_NAT:
>                 break;
>         case META_SIT:
>                 if (unlikely(blkaddr >=3D SIT_BLK_CNT(sbi)))
> -                       return false;
> +                       goto err;
>                 break;
>         case META_SSA:
>                 if (unlikely(blkaddr >=3D MAIN_BLKADDR(sbi) ||
>                         blkaddr < SM_I(sbi)->ssa_blkaddr))
> -                       return false;
> +                       goto err;
>                 break;
>         case META_CP:
>                 if (unlikely(blkaddr >=3D SIT_I(sbi)->sit_base_addr ||
>                         blkaddr < __start_cp_addr(sbi)))
> -                       return false;
> +                       goto err;
>                 break;
>         case META_POR:
>                 if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
>                         blkaddr < MAIN_BLKADDR(sbi)))
> -                       return false;
> +                       goto err;
>                 break;
>         case DATA_GENERIC:
>         case DATA_GENERIC_ENHANCE:
> @@ -213,7 +211,7 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>                                   blkaddr);
>                         set_sbi_flag(sbi, SBI_NEED_FSCK);
>                         dump_stack();
> -                       return false;
> +                       goto err;
>                 } else {
>                         return __is_bitmap_valid(sbi, blkaddr, type);
>                 }
> @@ -221,13 +219,16 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi=
,
>         case META_GENERIC:
>                 if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
>                         blkaddr >=3D MAIN_BLKADDR(sbi)))
> -                       return false;
> +                       goto err;
>                 break;
>         default:
>                 BUG();
>         }
>
>         return true;
> +err:
> +       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +       return false;
>  }
>
>  /*
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c5a4364..cf075ca 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1878,12 +1878,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_inf=
o *sbi, struct page *page,
>
>         set_page_private_data(cpage, ino);
>
> -       if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_REA=
D))
> -               goto out;
> -
>         memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
>         SetPageUptodate(cpage);
> -out:
>         f2fs_put_page(cpage, 1);
>  }
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index dce8def..61be01f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -740,10 +740,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>
>         if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>                         fio->is_por ? META_POR : (__is_meta_io(fio) ?
> -                       META_GENERIC : DATA_GENERIC_ENHANCE))) {
> -               f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> +                       META_GENERIC : DATA_GENERIC_ENHANCE)))
>                 return -EFSCORRUPTED;
> -       }
>
>         trace_f2fs_submit_page_bio(page, fio);
>
> @@ -948,10 +946,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>                         fio->encrypted_page : fio->page;
>
>         if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> -                       __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))=
 {
> -               f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> +                       __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
>                 return -EFSCORRUPTED;
> -       }
>
>         trace_f2fs_submit_page_bio(page, fio);
>
> @@ -1285,8 +1281,6 @@ struct page *f2fs_get_read_data_page(struct inode *=
inode, pgoff_t index,
>                 if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blka=
ddr,
>                                                 DATA_GENERIC_ENHANCE_READ=
)) {
>                         err =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(F2FS_I_SB(inode),
> -                                               ERROR_INVALID_BLKADDR);
>                         goto put_err;
>                 }
>                 goto got_it;
> @@ -1312,8 +1306,6 @@ struct page *f2fs_get_read_data_page(struct inode *=
inode, pgoff_t index,
>                                                 dn.data_blkaddr,
>                                                 DATA_GENERIC_ENHANCE)) {
>                 err =3D -EFSCORRUPTED;
> -               f2fs_handle_error(F2FS_I_SB(inode),
> -                                       ERROR_INVALID_BLKADDR);
>                 goto put_err;
>         }
>  got_it:
> @@ -1641,7 +1633,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2f=
s_map_blocks *map, int flag)
>         if (!is_hole &&
>             !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
>                 err =3D -EFSCORRUPTED;
> -               f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                 goto sync_out;
>         }
>
> @@ -2165,8 +2156,6 @@ static int f2fs_read_single_page(struct inode *inod=
e, struct page *page,
>                 if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
>                                                 DATA_GENERIC_ENHANCE_READ=
)) {
>                         ret =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(F2FS_I_SB(inode),
> -                                               ERROR_INVALID_BLKADDR);
>                         goto out;
>                 }
>         } else {
> @@ -2299,7 +2288,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, =
struct bio **bio_ret,
>                         break;
>
>                 if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC)) {
> -                       ret =3D -EFAULT;
> +                       ret =3D -EFSCORRUPTED;
>                         goto out_put_dnode;
>                 }
>                 cc->nr_cpages++;
> @@ -2706,11 +2695,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *f=
io)
>             f2fs_lookup_read_extent_cache_block(inode, page->index,
>                                                 &fio->old_blkaddr)) {
>                 if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> -                                               DATA_GENERIC_ENHANCE)) {
> -                       f2fs_handle_error(fio->sbi,
> -                                               ERROR_INVALID_BLKADDR);
> +                                               DATA_GENERIC_ENHANCE))
>                         return -EFSCORRUPTED;
> -               }
>
>                 ipu_force =3D true;
>                 fio->need_lock =3D LOCK_DONE;
> @@ -2738,7 +2724,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fi=
o)
>                 !f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
>                                                 DATA_GENERIC_ENHANCE)) {
>                 err =3D -EFSCORRUPTED;
> -               f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
>                 goto out_writepage;
>         }
>
> @@ -3704,7 +3689,6 @@ static int f2fs_write_begin(struct file *file, stru=
ct address_space *mapping,
>                 if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
>                                 DATA_GENERIC_ENHANCE_READ)) {
>                         err =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                         goto fail;
>                 }
>                 err =3D f2fs_submit_page_read(use_cow ?
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index ad8dfac7..99d0442 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
>         if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
>             !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>                                         DATA_GENERIC_ENHANCE)) {
> -               set_sbi_flag(sbi, SBI_NEED_FSCK);
>                 f2fs_warn(sbi, "%s: inode (ino=3D%lx) extent info [%u, %u=
, %u] is incorrect, run fsck to fix",
>                           __func__, inode->i_ino,
>                           ei->blk, ei->fofs, ei->len);
> @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *inode, =
struct extent_info *ei,
>                 goto out;
>
>         if (__is_valid_data_blkaddr(blkaddr) &&
> -           !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> -               f2fs_bug_on(sbi, 1);
> -               return -EINVAL;
> -       }
> +           !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> +               return -EFSCORRUPTED;
>  out:
>         /*
>          * init block age with zero, this can happen when the block age e=
xtent
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 026d05a7..b3df24c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1192,7 +1192,6 @@ static int __read_out_blkaddrs(struct inode *inode,=
 block_t *blkaddr,
>                         !f2fs_is_valid_blkaddr(sbi, *blkaddr,
>                                         DATA_GENERIC_ENHANCE)) {
>                         f2fs_put_dnode(&dn);
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                         return -EFSCORRUPTED;
>                 }
>
> @@ -1478,7 +1477,6 @@ static int f2fs_do_zero_range(struct dnode_of_data =
*dn, pgoff_t start,
>                 if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
>                                         DATA_GENERIC_ENHANCE)) {
>                         ret =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                         break;
>                 }
>
> @@ -3438,10 +3436,8 @@ static int release_compress_blocks(struct dnode_of=
_data *dn, pgoff_t count)
>                 if (!__is_valid_data_blkaddr(blkaddr))
>                         continue;
>                 if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -                                       DATA_GENERIC_ENHANCE))) {
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +                                       DATA_GENERIC_ENHANCE)))
>                         return -EFSCORRUPTED;
> -               }
>         }
>
>         while (count) {
> @@ -3603,10 +3599,8 @@ static int reserve_compress_blocks(struct dnode_of=
_data *dn, pgoff_t count)
>                 if (!__is_valid_data_blkaddr(blkaddr))
>                         continue;
>                 if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -                                       DATA_GENERIC_ENHANCE))) {
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +                                       DATA_GENERIC_ENHANCE)))
>                         return -EFSCORRUPTED;
> -               }
>         }
>
>         while (count) {
> @@ -3877,8 +3871,6 @@ static int f2fs_sec_trim_file(struct file *filp, un=
signed long arg)
>                                                 DATA_GENERIC_ENHANCE)) {
>                                 ret =3D -EFSCORRUPTED;
>                                 f2fs_put_dnode(&dn);
> -                               f2fs_handle_error(sbi,
> -                                               ERROR_INVALID_BLKADDR);
>                                 goto out;
>                         }
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 405a6077..9161050 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, pgoff=
_t index)
>                 if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>                                                 DATA_GENERIC_ENHANCE_READ=
))) {
>                         err =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                         goto put_page;
>                 }
>                 goto got_it;
> @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, pgoff=
_t index)
>         if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>                                                 DATA_GENERIC_ENHANCE))) {
>                 err =3D -EFSCORRUPTED;
> -               f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                 goto put_page;
>         }
>  got_it:
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 9b546fd..541c4ad 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -612,7 +612,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_=
t nid,
>         blkaddr =3D le32_to_cpu(ne.block_addr);
>         if (__is_valid_data_blkaddr(blkaddr) &&
>                 !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE=
))
> -               return -EFAULT;
> +               return -EFSCORRUPTED;
>
>         /* cache nat entry */
>         cache_nat_entry(sbi, nid, &ne);
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index d0f24cc..21381b7 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -680,14 +680,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi=
, struct inode *inode,
>                 if (__is_valid_data_blkaddr(src) &&
>                         !f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
>                         err =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                         goto err;
>                 }
>
>                 if (__is_valid_data_blkaddr(dest) &&
>                         !f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
>                         err =3D -EFSCORRUPTED;
> -                       f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>                         goto err;
>                 }
>
> @@ -756,8 +754,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, =
struct inode *inode,
>                                 f2fs_err(sbi, "Inconsistent dest blkaddr:=
%u, ino:%lu, ofs:%u",
>                                         dest, inode->i_ino, dn.ofs_in_nod=
e);
>                                 err =3D -EFSCORRUPTED;
> -                               f2fs_handle_error(sbi,
> -                                               ERROR_INVALID_BLKADDR);
>                                 goto err;
>                         }
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 61da26e..0449498 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inode *i=
node)
>                                         DATA_GENERIC_ENHANCE)) {
>                                 f2fs_put_dnode(&dn);
>                                 ret =3D -EFSCORRUPTED;
> -                               f2fs_handle_error(sbi,
> -                                               ERROR_INVALID_BLKADDR);
>                                 goto out;
>                         }
>
> --
> 1.9.1
>

