Return-Path: <linux-kernel+bounces-117321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE088A9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983041C3B3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6361384A3;
	Mon, 25 Mar 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOvqTvIb"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1F7EEFE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378954; cv=none; b=kAkeafhZplu4oWI283FtBkAjVli9dyQOW4cto76dTTz7aknmDI4XeVjiZUf2sAQfneVEzmC+JwVBQEHR5sJ8BdUD+aAr38KrVbrruF9t9OaMbfxCZUiQfA0dzV5iQQzPelHVUw/ib3EQqhZhYeygYm01b9efohVJ8xjw91bYT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378954; c=relaxed/simple;
	bh=k0xDgOSMDQbGv76F+USpe31dZqIKJwFIb1GGpeF3ZQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOxJR9sEDYnQyFFdfi6VT3uL/bPzgHNPaeABp+/0tNsbZ+rb1YH2JYDYfWzWHn3KF4AD2bDhF1E5SooOZiXWcumShrb6uWngKSrFcxumT+C9AM3N3Z2OWgHYqIAIHVOJZfp9vw+1Uje+dnoGPeBKtSq2GC+3Olsi9y5t1qfYA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOvqTvIb; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c396fec63aso1523458b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711378952; x=1711983752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgMCYmFkhuYojEFo2nYez3F6tl2yguGZg3Z/AU6fEKk=;
        b=JOvqTvIb61W4pCNOgTje3IMF8PbMbGVfLFgfTLsFSxkL4T6E7LSQFoOCGQ2r7ZUlO3
         lS7hSxXlG3B6i+Tp2OcY1E+lKnO3mtQZHeNvxdVRl11cVxkSd1aYA6AnWy/ILhuIPtN+
         jF/OpqRS9JVgMuXjsPsk42CBjJHvTEHKRuNoV2Ej5efbNk8MoXshNjX/k6ghUnBbtchR
         mTaTRdajD8FOJLEPzEEUV9VWys3cBnvU9b6+p5vOa7GiRmVCZBUB6j7ibDP0Lv8xh/ug
         hkl9s+tOlg1RaC19Sm577V0TMB0v2PXRMPYfKUtNsm90gLAev/stKntPHAMscKBI4DFX
         dLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378952; x=1711983752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgMCYmFkhuYojEFo2nYez3F6tl2yguGZg3Z/AU6fEKk=;
        b=elC65A/AMi/ERcsMnOAtJs+6liBUGQcH8sypED4JyboP5Ldx2t2CTSQMlXTxhg+ENa
         0MxFqiJYwklWlHt18qfFaOYzvtt6JOrUc/4nL0yuIsJukDBSnrylzWyC0be4DQCoW7tr
         iYk122Joss9kRwM7wK4K+sKBPYVXYmcoQ3CWzVfbdsmTLsEsa8WAUmg1D9tG71DoptV4
         +1m3O5kRSpLrugamkwwf4zUb6S+e47ZzwMi8Dhe5wQ3Ou34shG3qjr7cFVLhnscvP1H8
         q16pC+sypErdDdctrXzn813VQ4JhnBbzAFVzRNTRANABP9Ux2KImMjPnOZQOexIffNNz
         XdPg==
X-Gm-Message-State: AOJu0YxOiWv3IZatOxAG0gFOjPPmmKZNTLQC9Wk1eaOYCqlCv9nUbrck
	AxwGMCb3gOPVNZNl93K8PbKGOMW11VJlTJPuY0eimSZhUFdRYW0nqBU3kiHLzl0++uysc77s78U
	DUCpG4g9GS/MeHZGiBj1arwo2PsA=
X-Google-Smtp-Source: AGHT+IGT6JFd3y6nczDx1HWbAuLSB1jl1UG8yZKH2UDyA5uhVX3x/+pDzUYAA/NbQ37tzmuOkb/qonUNG5NguhwbF24=
X-Received: by 2002:a05:6808:ec8:b0:3c2:39d1:f111 with SMTP id
 q8-20020a0568080ec800b003c239d1f111mr56649oiv.48.1711378952070; Mon, 25 Mar
 2024 08:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212316.4193790-1-daeho43@gmail.com> <712f380c-68ef-4743-bd9b-7342e838ced7@kernel.org>
 <CACOAw_yAWGbx2Bx2or1OyVUUw6HSgTd=fo3e151d1JHU+Op5qQ@mail.gmail.com> <c1fd6c09-0083-439b-a81d-0d2f39cb10d4@kernel.org>
In-Reply-To: <c1fd6c09-0083-439b-a81d-0d2f39cb10d4@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 25 Mar 2024 08:02:21 -0700
Message-ID: <CACOAw_xejyoA9f2x9J0Z-MgbmrHAPYeAmpz8Lf1GfLDs-yHh5w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: prevent writing without fallocate()
 for pinned files
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/21 1:42, Daeho Jeong wrote:
> > On Wed, Mar 20, 2024 at 2:38=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/3/20 5:23, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> In a case writing without fallocate(), we can't guarantee it's alloca=
ted
> >>> in the conventional area for zoned stroage.
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>> v2: covered the direct io case
> >>> v3: covered the mkwrite case
> >>> ---
> >>>    fs/f2fs/data.c | 14 ++++++++++++--
> >>>    fs/f2fs/file.c | 16 ++++++++--------
> >>>    2 files changed, 20 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index c21b92f18463..d3e5ab2736a6 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struc=
t f2fs_map_blocks *map, int flag)
> >>>
> >>>        /* use out-place-update for direct IO under LFS mode */
> >>>        if (map->m_may_create &&
> >>> -         (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_BLO=
CK_DIO))) {
> >>> -             if (unlikely(f2fs_cp_error(sbi))) {
> >>> +         (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_BLO=
CK_DIO &&
> >>> +                      !f2fs_is_pinned_file(inode)))) {
> >>> +             if (unlikely(f2fs_cp_error(sbi)) ||
> >>> +                 (f2fs_is_pinned_file(inode) && is_hole &&
> >>> +                  flag !=3D F2FS_GET_BLOCK_PRE_DIO)) {
> >>>                        err =3D -EIO;
> >>>                        goto sync_out;
> >>>                }
> >>> @@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_i=
nfo *sbi,
> >>>                f2fs_map_lock(sbi, flag);
> >>>                locked =3D true;
> >>>        } else if ((pos & PAGE_MASK) >=3D i_size_read(inode)) {
> >>> +             if (f2fs_is_pinned_file(inode))
> >>> +                     return -EIO;
> >>>                f2fs_map_lock(sbi, flag);
> >>>                locked =3D true;
> >>>        }
> >>> @@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_=
info *sbi,
> >>>
> >>>        if (!f2fs_lookup_read_extent_cache_block(inode, index,
> >>>                                                 &dn.data_blkaddr)) {
> >>> +             if (f2fs_is_pinned_file(inode)) {
> >>> +                     err =3D -EIO;
> >>> +                     goto out;
> >>> +             }
> >>> +
> >>>                if (locked) {
> >>>                        err =3D f2fs_reserve_block(&dn, index);
> >>>                        goto out;
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index 82277e95c88f..4db3b21c804b 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fa=
ult *vmf)
> >>>        struct inode *inode =3D file_inode(vmf->vma->vm_file);
> >>>        struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >>>        struct dnode_of_data dn;
> >>> -     bool need_alloc =3D true;
> >>> +     bool need_alloc =3D !f2fs_is_pinned_file(inode);
> >>
> >> Will this check races w/ pinfile get|set?
> >
> > Do you mean "set/clear" case? I believe "set" case is okay, since we
>
> Yup,
>
> > can't set if the inode already has a data block. For "clear" case, I
>
> However, we can set pinfile on written inode in regular block device:

You're right. I missed it. Maybe I think we should keep the concept
consistent across devices regardless of zoned storage support. How
about preventing file pinning for already written inodes across all
device types? I am changing the pinfile concept by allowing the users
to write on only fallocate()-ed space.

>
>         if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
>                 ret =3D -EFBIG;
>                 goto out;
>         }
>
> Should we add the logic only if blkzoned feture is enabled?
>
> > believe mkwrite failure is okay in racy conditions caused by clearing
> > the pin flag. What do you think?
>
> Or we can use filemap_invalidate_lock() in f2fs_ioc_set_pin_file() to
> avoid the race condition?
>
> Thanks,
>
> >
> >>
> >> Thanks,
> >>
> >>>        int err =3D 0;
> >>>        vm_fault_t ret;
> >>>
> >>> @@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct v=
m_fault *vmf)
> >>>                goto out_sem;
> >>>        }
> >>>
> >>> +     set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>        if (need_alloc) {
> >>>                /* block allocation */
> >>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>                err =3D f2fs_get_block_locked(&dn, page->index);
> >>> -     }
> >>> -
> >>> -#ifdef CONFIG_F2FS_FS_COMPRESSION
> >>> -     if (!need_alloc) {
> >>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>> +     } else {
> >>>                err =3D f2fs_get_dnode_of_data(&dn, page->index, LOOKU=
P_NODE);
> >>>                f2fs_put_dnode(&dn);
> >>>        }
> >>> -#endif
> >>> +
> >>>        if (err) {
> >>>                unlock_page(page);
> >>>                goto out_sem;
> >>> @@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kioc=
b *iocb, struct iov_iter *iter,
> >>>                        return ret;
> >>>        }
> >>>
> >>> +     /* For pinned files, it should be fallocate()-ed in advance. */
> >>> +     if (f2fs_is_pinned_file(inode))
> >>> +             return 0;
> >>> +
> >>>        /* Do not preallocate blocks that will be written partially in=
 4KB. */
> >>>        map.m_lblk =3D F2FS_BLK_ALIGN(pos);
> >>>        map.m_len =3D F2FS_BYTES_TO_BLK(pos + count);

