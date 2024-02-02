Return-Path: <linux-kernel+bounces-49039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF3846529
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3D9283E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2134F3D65;
	Fri,  2 Feb 2024 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwHPY+WW"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB65C97
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835251; cv=none; b=k7/Tm+agEUfV8wkONCc3PWGfH9hOdASPDGaCJfPVKYPeNZ98Ywk1wRmCLhtBRyIx6MLqPxd58buJ6niNr/CCBvfMdgKvMlGx+nwpHHbDSLDTFicPlz1qUoWkMr+9SwSeBsVRWrGwzJb79AwpyZafcBfPnKFqicAaanbnFKV/trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835251; c=relaxed/simple;
	bh=gT23I/436jYlzMdZ50okQlSTuOYqejiZr5ytuUp0RO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJjG/ilF+0D2ArxXsQcs5lL3eY81eXIc0fCBtUXK/TpKmYV3w0Rd48W/Hz+cFfKB1+YuYg3VbvcJZbl/OH6O5EGK8ed0JLlTPV8bZfgYPKJTsSou+sb8lA6Gb1SKiPwhQc72P87Wc5gHjrJgsjs5TNTKXEd5yZs4WLQveb2us6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwHPY+WW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so2178081a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706835244; x=1707440044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqNDJf52zzZringUNt6+4TLB4lj4/1SiS2TmVWMXbCE=;
        b=VwHPY+WWLsaaLiqVjjNJ6eceSrP7TPUKYRqbYZ+akO32iSQs969+8UQ6LEkS44Amw5
         lrPoKdj5wpQjDuKDii7d4MlZ8Oev2+LkEGpN7FzW/tOYroEMHESds8iKsiWSP/QBjvwY
         5IKsf3uKvvMW7QAkzWCuTTqRhj8MY2ftSYF8m2TyiRbHrR7CeRC7/YGfdnqDI0uUYzM/
         bExb6pP8oHmdd+wgZpADI27UOBLl3TeFO6irlIE+hl/Sx3xlYGnar8u+b217nIfIPxXm
         zAFMT9sgrigE8CGsQU2F/7VrsqrPuzP5k8xRjHgnSqPWDaFm+ktNFa4VesRkgBDfGoJK
         411A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706835244; x=1707440044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqNDJf52zzZringUNt6+4TLB4lj4/1SiS2TmVWMXbCE=;
        b=MUQ8WpPBP4sGBQswq9eMdhhf5vsWu7daOV+5iairbotCHLALMXb0m0NVKsHn0XomAB
         YXkvw6I94hEeV6e8S83H9fFgo4H0nbqfXfFtPWrY9Ahhy0KNF4lz0Hxvh7duJyyizNB+
         LZWbDISfpjMLijtTh/TDzArC020BCSVJkRXKFrg+BKKeR6e4fQAKPXDam0SqRh9KDV3R
         pQXJctLR6WdzNRCsOAaNKneb0iSgyS7eTW/r1hwybwGiSCY3xvZFIg8dtoDjDFjbtZv6
         k75lrbADL3YRdN5L5cC/5KUQV+mh3vzcn4lWVwTGZi5qjx57SnAVb5S+ry6qhMAaeV0z
         Tmxw==
X-Gm-Message-State: AOJu0YzFJDfrs6WsQxvfRJFMpvdSHNJEex0iycKyvT9oAjcBKdSnUXCP
	UDrka9EH/D+bSRjadeEd3VCl5yyfZlRRTwchT0bBtDfzZ5K5YmZ4UsOrSqTI6VQUmQD+VvMlxlB
	3L/G81l3MTGIHmkIvJEgjDOa9Evg=
X-Google-Smtp-Source: AGHT+IEkmE4YerCEoCHEfj+8h0mf+8oxun4TJdCoelxDJ6rg0Bu3CSq81IalkI0MFz9A5gyFVY+SFv7v/668k11sXNM=
X-Received: by 2002:aa7:d88b:0:b0:55f:c5b7:5855 with SMTP id
 u11-20020aa7d88b000000b0055fc5b75855mr222430edq.6.1706835244095; Thu, 01 Feb
 2024 16:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706668994-7384-1-git-send-email-zhiguo.niu@unisoc.com> <cc9d1f72-681e-48d7-9ce8-bd0ee9f31e4a@kernel.org>
In-Reply-To: <cc9d1f72-681e-48d7-9ce8-bd0ee9f31e4a@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 2 Feb 2024 08:53:52 +0800
Message-ID: <CAHJ8P3Luwtwv_m9bnpwyWBbsHujuryFi-it99BNta=7O34SSDw@mail.gmail.com>
Subject: Re: [PATCH v5] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:04=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/31 10:43, Zhiguo Niu wrote:
> > There are some cases of f2fs_is_valid_blkaddr not handled as
> > ERROR_INVALID_BLKADDR,so unify the error handling about all of
> > f2fs_is_valid_blkaddr.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > changes of v2: improve patch according Chao's suggestions.
> > changes of v3:
> >    -rebase patch to dev-test
> >    -correct return value for some f2fs_is_valid_blkaddr error case
> > changes of v4: update according to the latest code
> > changes of v5: improve patch according Jaegeuk's suggestiongs
> >    -restore return value of some f2fs_is_valid_blkaddr error case to or=
iginal
> >    -remove cp_err checking in __is_bitmap_valid becasue it has done in
> >     if case
> >    -return true directly for case (type=3DDATA_GENERIC_ENHANCE_READ) in
> >     __is_bitmap_valid to avoid meaningless flow
> >    -rename __is_bitmap_valid to __is_bitmap_check_valid for avoiding am=
biguity
> >     and handling its return value in the caller uniformly, also coopera=
te
> >     switch checking true to false in do_recover_data for error case of
> >     f2fs_is_valid_blkaddr(type=3DDATA_GENERIC_ENHANCE_UPDATE) for more =
readable
> > ---
> > ---
> >   fs/f2fs/checkpoint.c   | 53 +++++++++++++++++++++++------------------=
---------
> >   fs/f2fs/data.c         | 22 +++------------------
> >   fs/f2fs/extent_cache.c |  5 +----
> >   fs/f2fs/file.c         | 16 +++------------
> >   fs/f2fs/gc.c           |  2 --
> >   fs/f2fs/recovery.c     |  6 +-----
> >   fs/f2fs/segment.c      |  2 --
> >   7 files changed, 32 insertions(+), 74 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index b85820e..e90fa46 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -134,14 +134,15 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_inf=
o *sbi, pgoff_t index)
> >       return __get_meta_page(sbi, index, false);
> >   }
> >
> > -static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkadd=
r,
> > +static bool __is_bitmap_check_valid(struct f2fs_sb_info *sbi, block_t =
blkaddr,
> >                                                       int type)
> >   {
> >       struct seg_entry *se;
> >       unsigned int segno, offset;
> >       bool exist;
> >
> > -     if (type =3D=3D DATA_GENERIC)
> > +     if (type =3D=3D DATA_GENERIC ||
> > +             type =3D=3D DATA_GENERIC_ENHANCE_READ)
> >               return true;
> >
> >       segno =3D GET_SEGNO(sbi, blkaddr);
> > @@ -149,25 +150,16 @@ static bool __is_bitmap_valid(struct f2fs_sb_info=
 *sbi, block_t blkaddr,
> >       se =3D get_seg_entry(sbi, segno);
> >
> >       exist =3D f2fs_test_bit(offset, se->cur_valid_map);
> > +     if ((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) ||
> > +                     (!exist && type =3D=3D DATA_GENERIC_ENHANCE))
> > +             goto err;
> >
> > -     /* skip data, if we already have an error in checkpoint. */
> > -     if (unlikely(f2fs_cp_error(sbi)))
> > -             return exist;
> > -
> > -     if (exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) {
> > -             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> > -                      blkaddr, exist);
> > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -             return exist;
> > -     }
> > -
> > -     if (!exist && type =3D=3D DATA_GENERIC_ENHANCE) {
> > -             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> > -                      blkaddr, exist);
> > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -             dump_stack();
> > -     }
> > -     return exist;
> > +     return true;
> > +err:
> > +     f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> > +             blkaddr, exist);
> > +     set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +     return false;
>
>         if (unlikely((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) |=
|
>                         (!exist && type =3D=3D DATA_GENERIC_ENHANCE))) {
>                 f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
>                         blkaddr, exist);
>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
>                 dump_stack();
>                 return false;
>         }
>         return exist;
>
> >   }
> >
> >   static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> > @@ -178,22 +170,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_s=
b_info *sbi,
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
> > @@ -209,22 +201,25 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_s=
b_info *sbi,
> >                       f2fs_warn(sbi, "access invalid blkaddr:%u",
> >                                 blkaddr);
> >                       set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -                     dump_stack();
> > -                     return false;
> > -             } else {
> > -                     return __is_bitmap_valid(sbi, blkaddr, type);
> > +                     goto err;
> > +             } else if (!__is_bitmap_check_valid(sbi, blkaddr, type)) =
{
> > +                     goto err;
> >               }
> >               break;
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
> > +     dump_stack();
>
> I don't think we need to call dump_stack() for all cases.
I see and thank for your review.
>
> Thanks,
>
> > +     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +     return false;
> >   }
> >
> >   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 05158f8..300f9ae 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
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
> > @@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
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
> > @@ -1286,8 +1282,6 @@ struct page *f2fs_get_read_data_page(struct inode=
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
> > @@ -1313,8 +1307,6 @@ struct page *f2fs_get_read_data_page(struct inode=
 *inode, pgoff_t index,
> >                                               dn.data_blkaddr,
> >                                               DATA_GENERIC_ENHANCE)) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(F2FS_I_SB(inode),
> > -                                     ERROR_INVALID_BLKADDR);
> >               goto put_err;
> >       }
> >   got_it:
> > @@ -1642,7 +1634,6 @@ int f2fs_map_blocks(struct inode *inode, struct f=
2fs_map_blocks *map, int flag)
> >       if (!is_hole &&
> >           !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >               goto sync_out;
> >       }
> >
> > @@ -2166,8 +2157,6 @@ static int f2fs_read_single_page(struct inode *in=
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
> > @@ -2707,11 +2696,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info =
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
> > @@ -2739,7 +2725,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *=
fio)
> >               !f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> >                                               DATA_GENERIC_ENHANCE)) {
> >               err =3D -EFSCORRUPTED;
> > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> >               goto out_writepage;
> >       }
> >
> > @@ -3706,7 +3691,6 @@ static int f2fs_write_begin(struct file *file, st=
ruct address_space *mapping,
> >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> >                               DATA_GENERIC_ENHANCE_READ)) {
> >                       err =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto fail;
> >               }
> >               err =3D f2fs_submit_page_read(use_cow ?
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index ad8dfac7..48048fa 100644
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
> > +         !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> >               return -EINVAL;
> > -     }
> >   out:
> >       /*
> >        * init block age with zero, this can happen when the block age e=
xtent
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 25b119cf..23cd6a1 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_=
of_data *dn, int count)
> >                       if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE=
))
> >                               continue;
> >                       if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> > -                                             DATA_GENERIC_ENHANCE)) {
> > -                             f2fs_handle_error(sbi, ERROR_INVALID_BLKA=
DDR);
> > +                                             DATA_GENERIC_ENHANCE))
> >                               continue;
> > -                     }
> >                       if (compressed_cluster)
> >                               valid_blocks++;
> >               }
> > @@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *inod=
e, block_t *blkaddr,
> >                       !f2fs_is_valid_blkaddr(sbi, *blkaddr,
> >                                       DATA_GENERIC_ENHANCE)) {
> >                       f2fs_put_dnode(&dn);
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       return -EFSCORRUPTED;
> >               }
> >
> > @@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_dat=
a *dn, pgoff_t start,
> >               if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
> >                                       DATA_GENERIC_ENHANCE)) {
> >                       ret =3D -EFSCORRUPTED;
> > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       break;
> >               }
> >
> > @@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnode_=
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
> > @@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnode_=
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
> > @@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp, =
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
> > index a079eeb..30e93d8 100644
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
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index aad1d1a..73d81e0 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -693,14 +693,12 @@ static int do_recover_data(struct f2fs_sb_info *s=
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
> > @@ -750,13 +748,11 @@ static int do_recover_data(struct f2fs_sb_info *s=
bi, struct inode *inode,
> >                               goto err;
> >                       }
> >
> > -                     if (f2fs_is_valid_blkaddr(sbi, dest,
> > +                     if (!f2fs_is_valid_blkaddr(sbi, dest,
> >                                       DATA_GENERIC_ENHANCE_UPDATE)) {
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
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 7901ede..ad6511f 100644
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

