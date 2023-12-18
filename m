Return-Path: <linux-kernel+bounces-2939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C6816500
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A72829E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B91FCA;
	Mon, 18 Dec 2023 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hptNvZbA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038153C0C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2335d81693so180786966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702867420; x=1703472220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOoNWk0wy4PVV0rZoMMe0QIJQCjUubfioasa5iFcQXs=;
        b=hptNvZbA3aJHmMuo+urqECX4T8VSWwGItOtceuER2ifhgGxwPteZGFh6iXbqwuOOhY
         B7UEXOLWxqRDwZUq8LFRbQmCJYjhNYFvTREUTEAl66emVHJx29mL1iyCyb0XqNfG0Eau
         bwiIHBoUYr9Kqtg8l+Pk+27I8WtsHEjLggCJLyolzd5GPYwswUw4xZ/PWRn5upy4ARU9
         9LsZCnZIfp9Sbbly0UepBqg3sb1JX7CgACOZqp1P4JPHc5kq8RcATl5Q2qojxXZ5uAgd
         7ETby6mf0hKQhQi1lcolfXaiou5nPkz6zgIAAWOUWgcDA+EFype5CFDGiw4Vz5TKrh5d
         HpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867420; x=1703472220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOoNWk0wy4PVV0rZoMMe0QIJQCjUubfioasa5iFcQXs=;
        b=MPbORdBaKcZU80V9mesheGyp1WKIoYWH/khXLlAmOVLpD4DVjhaqCk4fBZlcqBRW5a
         9/uvbDV0D8orBgOM5FMDs7FMCLQcKubuNhGeBTmEC6N+FPg2iclXhA8dptUKG1/Y/mh6
         X07Ab1MbEd5CyVdBwjD4IkCTAxq71Jx0QiSw3W36e02kWt8zSM9D9kOLkaTtWo+sC+7x
         RDrcmdBG9v/msn+eB4b2+c9Q5Qgl2jyxweaDyXEFcHPbXqC62EN4IhJKl5S6b6rCNkM8
         r34h7+ElB1QKwEtzNeftN7efC9IOy4nSQa70S+MnJrR5OW+lne4tsFmtk8mVGMV7WhGT
         gZ/Q==
X-Gm-Message-State: AOJu0YzAqOWR9LYVmVrBlPEPmro9W1M6C6Up6h8ChyGQ7L8xTviGpSPD
	FgeMpdGQthyOsA4rlOcZzJjhCuyMiIMpK47zQ6E=
X-Google-Smtp-Source: AGHT+IGQU6MPfgX3WvZmK7sG1krwxSHU3x2TU7O0U8AjyuhZRgGG6RnovB+5JLAZQlgsO6zRGmiAhEEjkDZx4aYCW9M=
X-Received: by 2002:a17:907:2723:b0:a1f:8149:558c with SMTP id
 d3-20020a170907272300b00a1f8149558cmr14221001ejl.30.1702867419931; Sun, 17
 Dec 2023 18:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702358603-26270-1-git-send-email-zhiguo.niu@unisoc.com> <6a133254-b086-4557-be2a-65fe1637efd3@kernel.org>
In-Reply-To: <6a133254-b086-4557-be2a-65fe1637efd3@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 18 Dec 2023 10:43:28 +0800
Message-ID: <CAHJ8P3+Y1GkdQ405tBCq9wbAwEruK3ezaZYkRu_W+U=76P6hQg@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chao,
thanks for your feedback.

On Fri, Dec 15, 2023 at 10:28=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/12/12 13:23, Zhiguo Niu wrote:
> > unify the error handling of ERROR_INVALID_BLKADDR in f2fs_is_valid_blka=
ddr
> > and remove some redundant codes in f2fs_cache_compressed_page.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > changes of v2: improve patch according Chao's suggestions.
> > ---
> > ---
> >   fs/f2fs/checkpoint.c   | 43 +++++++++++++++++++++++------------------=
--
> >   fs/f2fs/compress.c     |  4 ----
> >   fs/f2fs/data.c         | 24 ++++--------------------
> >   fs/f2fs/extent_cache.c |  7 ++-----
> >   fs/f2fs/f2fs.h         |  5 ++---
> >   fs/f2fs/file.c         | 17 +++++------------
> >   fs/f2fs/gc.c           |  2 --
> >   fs/f2fs/inode.c        |  5 ++---
> >   fs/f2fs/node.c         |  2 +-
> >   fs/f2fs/recovery.c     | 13 ++++++-------
> >   fs/f2fs/segment.c      |  2 --
> >   11 files changed, 45 insertions(+), 79 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index b0597a5..d8ff056 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -154,19 +154,17 @@ static bool __is_bitmap_valid(struct f2fs_sb_info=
 *sbi, block_t blkaddr,
> >       if (unlikely(f2fs_cp_error(sbi)))
> >               return exist;
> >
> > -     if (exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) {
> > -             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> > -                      blkaddr, exist);
> > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -             return exist;
> > -     }
> > +     if ((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) ||
> > +                     (!exist && type =3D=3D DATA_GENERIC_ENHANCE))
> > +             goto err;
> >
> > -     if (!exist && type =3D=3D DATA_GENERIC_ENHANCE) {
> > -             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> > -                      blkaddr, exist);
> > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -             dump_stack();
> > -     }
> > +     return exist;
> > +err:
> > +     f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> > +             blkaddr, exist);
> > +     set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +     dump_stack();
> > +     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >       return exist;
> >   }
> >
> > @@ -174,29 +172,29 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *s=
bi,
> >                                       block_t blkaddr, int type)
> >   {
> >       if (time_to_inject(sbi, FAULT_BLKADDR))
> > -             return false;
> > +             goto err;
> >
> >       switch (type) {
> >       case META_NAT:
> >               break;
> >       case META_SIT:
> >               if (unlikely(blkaddr >=3D SIT_BLK_CNT(sbi)))
> > -                     return false;
> > +                     goto err;
> >               break;
> >       case META_SSA:
> >               if (unlikely(blkaddr >=3D MAIN_BLKADDR(sbi) ||
> >                       blkaddr < SM_I(sbi)->ssa_blkaddr))
> > -                     return false;
> > +                     goto err;
> >               break;
> >       case META_CP:
> >               if (unlikely(blkaddr >=3D SIT_I(sbi)->sit_base_addr ||
> >                       blkaddr < __start_cp_addr(sbi)))
> > -                     return false;
> > +                     goto err;
> >               break;
> >       case META_POR:
> >               if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
> >                       blkaddr < MAIN_BLKADDR(sbi)))
> > -                     return false;
> > +                     goto err;
> >               break;
> >       case DATA_GENERIC:
> >       case DATA_GENERIC_ENHANCE:
> > @@ -213,7 +211,7 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi=
,
> >                                 blkaddr);
> >                       set_sbi_flag(sbi, SBI_NEED_FSCK);
> >                       dump_stack();
> > -                     return false;
> > +                     goto err;
> >               } else {
> >                       return __is_bitmap_valid(sbi, blkaddr, type);
> >               }
> > @@ -221,13 +219,16 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *s=
bi,
> >       case META_GENERIC:
> >               if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
> >                       blkaddr >=3D MAIN_BLKADDR(sbi)))
> > -                     return false;
> > +                     goto err;
> >               break;
> >       default:
> >               BUG();
> >       }
> >
> >       return true;
> > +err:
> > +     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +     return false;
> >   }
> >
> >   /*
> > @@ -256,8 +257,10 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, b=
lock_t start, int nrpages,
> >       blk_start_plug(&plug);
> >       for (; nrpages-- > 0; blkno++) {
> >
> > -             if (!f2fs_is_valid_blkaddr(sbi, blkno, type))
> > +             if (!f2fs_is_valid_blkaddr(sbi, blkno, type)) {
> > +                     err =3D -EFSCORRUPTED;
> >                       goto out;
> > +             }
> >
> >               switch (type) {
> >               case META_NAT:
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 36e5dab..bd5acb5 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1878,12 +1878,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_i=
nfo *sbi, struct page *page,
> >
> >       set_page_private_data(cpage, ino);
> >
> > -     if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_REA=
D))
> > -             goto out;
> > -
> >       memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
> >       SetPageUptodate(cpage);
> > -out:
> >       f2fs_put_page(cpage, 1);
> >   }
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 4e42b5f..14b6ea2 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -740,10 +740,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> >
> >       if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> >                       fio->is_por ? META_POR : (__is_meta_io(fio) ?
> > -                     META_GENERIC : DATA_GENERIC_ENHANCE))) {
> > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> > +                     META_GENERIC : DATA_GENERIC_ENHANCE)))
> >               return -EFSCORRUPTED;
> > -     }
> >
> >       trace_f2fs_submit_page_bio(page, fio);
> >
> > @@ -948,10 +946,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >                       fio->encrypted_page : fio->page;
> >
> >       if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> > -                     __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))=
 {
> > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> > +                     __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
> >               return -EFSCORRUPTED;
> > -     }
> >
> >       trace_f2fs_submit_page_bio(page, fio);
> >
> > @@ -1293,8 +1289,6 @@ struct page *f2fs_get_read_data_page(struct inode=
 *inode, pgoff_t index,
> >               if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blka=
ddr,
> >                                               DATA_GENERIC_ENHANCE_READ=
)) {
> >                       err =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(F2FS_I_SB(inode),
> > -                                             ERROR_INVALID_BLKADDR);
> >                       goto put_err;
> >               }
> >               goto got_it;
> > @@ -1320,8 +1314,6 @@ struct page *f2fs_get_read_data_page(struct inode=
 *inode, pgoff_t index,
> >                                               dn.data_blkaddr,
> >                                               DATA_GENERIC_ENHANCE)) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(F2FS_I_SB(inode),
> > -                                     ERROR_INVALID_BLKADDR);
> >               goto put_err;
> >       }
> >   got_it:
> > @@ -1651,7 +1643,6 @@ int f2fs_map_blocks(struct inode *inode, struct f=
2fs_map_blocks *map, int flag)
> >       if (!is_hole &&
> >           !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >               goto sync_out;
> >       }
> >
> > @@ -2175,8 +2166,6 @@ static int f2fs_read_single_page(struct inode *in=
ode, struct page *page,
> >               if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
> >                                               DATA_GENERIC_ENHANCE_READ=
)) {
> >                       ret =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(F2FS_I_SB(inode),
> > -                                             ERROR_INVALID_BLKADDR);
> >                       goto out;
> >               }
> >       } else {
> > @@ -2309,7 +2298,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc=
, struct bio **bio_ret,
> >                       break;
> >
> >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC)) {
> > -                     ret =3D -EFAULT;
> > +                     ret =3D -EFSCORRUPTED;
> >                       goto out_put_dnode;
> >               }
> >               cc->nr_cpages++;
> > @@ -2719,11 +2708,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info =
*fio)
> >           f2fs_lookup_read_extent_cache_block(inode, page->index,
> >                                               &fio->old_blkaddr)) {
> >               if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> > -                                             DATA_GENERIC_ENHANCE)) {
> > -                     f2fs_handle_error(fio->sbi,
> > -                                             ERROR_INVALID_BLKADDR);
> > +                                             DATA_GENERIC_ENHANCE))
> >                       return -EFSCORRUPTED;
> > -             }
> >
> >               ipu_force =3D true;
> >               fio->need_lock =3D LOCK_DONE;
> > @@ -2751,7 +2737,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *=
fio)
> >               !f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> >                                               DATA_GENERIC_ENHANCE)) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> >               goto out_writepage;
> >       }
> >
> > @@ -3718,7 +3703,6 @@ static int f2fs_write_begin(struct file *file, st=
ruct address_space *mapping,
> >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> >                               DATA_GENERIC_ENHANCE_READ)) {
> >                       err =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto fail;
> >               }
> >               err =3D f2fs_submit_page_read(use_cow ?
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index ad8dfac7..99d0442 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
> >       if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
> >           !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
> >                                       DATA_GENERIC_ENHANCE)) {
> > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> >               f2fs_warn(sbi, "%s: inode (ino=3D%lx) extent info [%u, %u=
, %u] is incorrect, run fsck to fix",
> >                         __func__, inode->i_ino,
> >                         ei->blk, ei->fofs, ei->len);
> > @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *inode=
, struct extent_info *ei,
> >               goto out;
> >
> >       if (__is_valid_data_blkaddr(blkaddr) &&
> > -         !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> > -             f2fs_bug_on(sbi, 1);
> > -             return -EINVAL;
> > -     }
> > +         !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> > +             return -EFSCORRUPTED;
> >   out:
> >       /*
> >        * init block age with zero, this can happen when the block age e=
xtent
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9043ced..e36630c 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3454,14 +3454,13 @@ static inline int get_inline_xattr_addrs(struct=
 inode *inode)
> >
> >   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >                                       block_t blkaddr, int type);
> > +
> >   static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
> >                                       block_t blkaddr, int type)
> >   {
> > -     if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
> > +     if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type))
> >               f2fs_err(sbi, "invalid blkaddr: %u, type: %d, run fsck to=
 fix.",
> >                        blkaddr, type);
> > -             f2fs_bug_on(sbi, 1);
>
> It looks like an impossible case, how about keeping this f2fs_bug_on()?
OK.
>
> > -     }
> >   }
> >
> >   static inline bool __is_valid_data_blkaddr(block_t blkaddr)
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index e503635..3d193a3 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -416,7 +416,7 @@ static loff_t f2fs_seek_block(struct file *file, lo=
ff_t offset, int whence)
> >       pgoff_t pgofs, end_offset;
> >       loff_t data_ofs =3D offset;
> >       loff_t isize;
> > -     int err =3D 0;
> > +     int err =3D -ENXIO;
> >
> >       inode_lock(inode);
> >
> > @@ -466,6 +466,7 @@ static loff_t f2fs_seek_block(struct file *file, lo=
ff_t offset, int whence)
> >                               !f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> >                                       blkaddr, DATA_GENERIC_ENHANCE)) {
> >                               f2fs_put_dnode(&dn);
> > +                             err =3D -EFSCORRUPTED;
> >                               goto fail;
> >                       }
> >
> > @@ -487,7 +488,7 @@ static loff_t f2fs_seek_block(struct file *file, lo=
ff_t offset, int whence)
> >       return vfs_setpos(file, data_ofs, maxbytes);
> >   fail:
> >       inode_unlock(inode);
> > -     return -ENXIO;
> > +     return err;
>
> Can you please check all 'goto found' and 'goto fail' cases?
YES,  I have checked, and I think all of fail cases return the same
error: "-ENXIO" is not suitable in my original intention
I will follow the origin handling way if any concerned.
>
> >   }
> >
> >   static loff_t f2fs_llseek(struct file *file, loff_t offset, int whenc=
e)
> > @@ -1197,7 +1198,6 @@ static int __read_out_blkaddrs(struct inode *inod=
e, block_t *blkaddr,
> >                       !f2fs_is_valid_blkaddr(sbi, *blkaddr,
> >                                       DATA_GENERIC_ENHANCE)) {
> >                       f2fs_put_dnode(&dn);
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       return -EFSCORRUPTED;
> >               }
> >
> > @@ -1482,7 +1482,6 @@ static int f2fs_do_zero_range(struct dnode_of_dat=
a *dn, pgoff_t start,
> >               if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
> >                                       DATA_GENERIC_ENHANCE)) {
> >                       ret =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       break;
> >               }
> >
> > @@ -3438,10 +3437,8 @@ static int release_compress_blocks(struct dnode_=
of_data *dn, pgoff_t count)
> >               if (!__is_valid_data_blkaddr(blkaddr))
> >                       continue;
> >               if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > -                                     DATA_GENERIC_ENHANCE))) {
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +                                     DATA_GENERIC_ENHANCE)))
> >                       return -EFSCORRUPTED;
> > -             }
> >       }
> >
> >       while (count) {
> > @@ -3604,10 +3601,8 @@ static int reserve_compress_blocks(struct dnode_=
of_data *dn, pgoff_t count)
> >               if (!__is_valid_data_blkaddr(blkaddr))
> >                       continue;
> >               if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > -                                     DATA_GENERIC_ENHANCE))) {
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +                                     DATA_GENERIC_ENHANCE)))
> >                       return -EFSCORRUPTED;
> > -             }
> >       }
> >
> >       while (count) {
> > @@ -3879,8 +3874,6 @@ static int f2fs_sec_trim_file(struct file *filp, =
unsigned long arg)
> >                                               DATA_GENERIC_ENHANCE)) {
> >                               ret =3D -EFSCORRUPTED;
> >                               f2fs_put_dnode(&dn);
> > -                             f2fs_handle_error(sbi,
> > -                                             ERROR_INVALID_BLKADDR);
> >                               goto out;
> >                       }
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index f550cde..2f16f7a 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, pgo=
ff_t index)
> >               if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> >                                               DATA_GENERIC_ENHANCE_READ=
))) {
> >                       err =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto put_page;
> >               }
> >               goto got_it;
> > @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, pgo=
ff_t index)
> >       if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> >                                               DATA_GENERIC_ENHANCE))) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >               goto put_page;
> >       }
> >   got_it:
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 560bfca..05bfb36 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -83,10 +83,9 @@ static int __written_first_block(struct f2fs_sb_info=
 *sbi,
> >
> >       if (!__is_valid_data_blkaddr(addr))
> >               return 1;
> > -     if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC_ENHANCE)) {
> > -             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +     if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC_ENHANCE))
> >               return -EFSCORRUPTED;
> > -     }
> > +
> >       return 0;
>
> This function was removed by a53936361330 ("f2fs: delete obsolete
> FI_FIRST_BLOCK_WRITTEN"), can you please rebase code to last dev-test
> branch?
OK,  I will do this. I use the mainline code now.
>
> >   }
> >
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 6c7f6a6..f6c9cef 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -612,7 +612,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, ni=
d_t nid,
> >       blkaddr =3D le32_to_cpu(ne.block_addr);
> >       if (__is_valid_data_blkaddr(blkaddr) &&
> >               !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE=
))
> > -             return -EFAULT;
> > +             return -EFSCORRUPTED;
> >
> >       /* cache nat entry */
> >       cache_nat_entry(sbi, nid, &ne);
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index b56d0f1..1a322bb 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -374,7 +374,7 @@ static int sanity_check_node_chain(struct f2fs_sb_i=
nfo *sbi, block_t blkaddr,
> >       for (i =3D 0; i < 2; i++) {
> >               if (!f2fs_is_valid_blkaddr(sbi, *blkaddr_fast, META_POR))=
 {
>
> What about introduce DATA_POR and use it here?
>
> And in f2fs_is_valid_blkaddr(), we can handle this case as:
>
>         case META_POR:
>         case DATA_POR:
>                 if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
>                         blkaddr < MAIN_BLKADDR(sbi)))
>                         return false;
>                 break;
>
I think  another separated  patch can be for this purpose?
But I don't understand why a new type "DATA_POR"   need be introduced?
META_POR is used for recovery data type seems quite reasonable.

> >                       *is_detecting =3D false;
> > -                     return 0;
> > +                     return -EFSCORRUPTED;
>
> I guess we should not return EFSCORRUPTED, because blkaddr_fast can be
> invalid as we expect.
OK,  I understand it
>
> >               }
> >
> >               page =3D f2fs_get_tmp_page(sbi, *blkaddr_fast);
> > @@ -399,6 +399,7 @@ static int sanity_check_node_chain(struct f2fs_sb_i=
nfo *sbi, block_t blkaddr,
> >       if (*blkaddr_fast =3D=3D blkaddr) {
> >               f2fs_notice(sbi, "%s: Detect looped node chain on blkaddr=
:%u."
> >                               " Run fsck to fix it.", __func__, blkaddr=
);
> > +             set_sbi_flag(sbi, SBI_NEED_FSCK);
>
> It's not needed, because there will be no checkpoint to persist the flag.
OK  and Got it.
>
> >               return -EINVAL;
> >       }
> >       return 0;
> > @@ -422,7 +423,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *s=
bi, struct list_head *head,
> >               struct fsync_inode_entry *entry;
> >
> >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> > -                     return 0;
> > +                     return -EFSCORRUPTED;
>
> Ditto,
OK,  I understand it
>
> >
> >               page =3D f2fs_get_tmp_page(sbi, blkaddr);
> >               if (IS_ERR(page)) {
> > @@ -680,14 +681,12 @@ static int do_recover_data(struct f2fs_sb_info *s=
bi, struct inode *inode,
> >               if (__is_valid_data_blkaddr(src) &&
> >                       !f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
> >                       err =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto err;
> >               }
> >
> >               if (__is_valid_data_blkaddr(dest) &&
> >                       !f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
> >                       err =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto err;
> >               }
> >
> > @@ -745,8 +744,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi=
, struct inode *inode,
> >                               f2fs_err(sbi, "Inconsistent dest blkaddr:=
%u, ino:%lu, ofs:%u",
> >                                       dest, inode->i_ino, dn.ofs_in_nod=
e);
> >                               err =3D -EFSCORRUPTED;
> > -                             f2fs_handle_error(sbi,
> > -                                             ERROR_INVALID_BLKADDR);
> >                               goto err;
> >                       }
> >
> > @@ -786,8 +783,10 @@ static int recover_data(struct f2fs_sb_info *sbi, =
struct list_head *inode_list,
> >       while (1) {
> >               struct fsync_inode_entry *entry;
> >
> > -             if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> > +             if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR)) {
> > +                     err =3D -EFSCORRUPTED;
>
> I guess we should not return EFSCORRUPTED, because blkaddr can be
> invalid as we expect.
OK,  I understand it
>
> Thanks,
>
> >                       break;
> > +             }
> >
> >               page =3D f2fs_get_tmp_page(sbi, blkaddr);
> >               if (IS_ERR(page)) {
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 727d016..e427c3c 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inode =
*inode)
> >                                       DATA_GENERIC_ENHANCE)) {
> >                               f2fs_put_dnode(&dn);
> >                               ret =3D -EFSCORRUPTED;
> > -                             f2fs_handle_error(sbi,
> > -                                             ERROR_INVALID_BLKADDR);
> >                               goto out;
> >                       }
> >

