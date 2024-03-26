Return-Path: <linux-kernel+bounces-119609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AF88CB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D22F1C66536
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5631B21344;
	Tue, 26 Mar 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoQ/MSOZ"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B420DFC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474497; cv=none; b=Yw2KDPaTqtHZzJcd+KX1lCGln94sL3zeiTENEXqaHU+Ozky5aoff6ZN/ECXzjHD0IlvJfjA/Tpyno9fb8lnIjibvkJwqvC6JYPJp7zrCK4QkyF/avpIPjabAF3sirO2KzXcB9hh15qsnolYIeDDC3QPnRSHw2K0dULbtmnMpIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474497; c=relaxed/simple;
	bh=m2w3ra/vLTtdfASbbEeXbAqU4LoxnYVueub8n5/zmtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvVgem/HoI5fSlrzG2lSXcAz98+HgOeq4Y94GFqB3sM0xIIEQJCxTEzra1+lOWILEkgnxL9S9ZvpCwanWRRNOWlFb89Y8tYhn0cl/9zjX1+CQFilvL21KmUigyzgUZIbduHAtYxjv33khyhS+j9GNVU5Jyfw9G87Jxvb2PLQR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoQ/MSOZ; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d436ab8a36so2068359e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711474494; x=1712079294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQ35C+kL3axh6L7EwSqgU9ptD4Ff3HJAuCiRN7ziw38=;
        b=LoQ/MSOZV0+LRQAoK1Ah643sZ5C5gz6dB7RmxkZ9YRY6L2PThiGpcevvK0cX1W0ZR9
         Lc7604IjV3nvTt+ozYrngOFT+hLQt2yh5/CdULsz3FLyH9Tm9j9mn9IcvuOv3Mjw1zl9
         1XGyKGIPbGthLYRqGjZ8fg0CVVX11AKppQuztf34h1Ubt3wTckK+Js0aRyZdxqkM0pg8
         HwA9JxNxCH7yfunPe162JkqQqgczpdzWY17tYcdzF3VgtW10A5yqIPDcYqoXc/49UISL
         N/wr8v0D7patIbU0y/YkmG3HgKsP/3aE4cR0NgaiBAH2BOfA9dr5AYmBBQJLFSw84WNp
         tk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474494; x=1712079294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ35C+kL3axh6L7EwSqgU9ptD4Ff3HJAuCiRN7ziw38=;
        b=HzhWvI/DXRJSmKpRv42U8rtgTtJOv8BNBP46cAr/VNgMzpL9Yzy2jbIaCUh3L72HFn
         7J03tnLKdVKZhYqNUI9syC5vVSxmI8hJTTNnqF64wCZbqi7kSDiPvrwKGabLeTBRimn0
         YDiju3sIf1H806VYQZVQOEQymYjTfJV0P4V1LXRorBO1ze/cfkF9Pj4qMWIx62qrQa8B
         894raADGXaFY7ByjpUSus5ifBR9dDEOQf6LX+JtJtOppQOsCrwTjNkDR5pdA1r2Ubrf+
         tTQT9xiV1XueEQqCjSsmUsS1a/Dub84TXn0e7yhXs+S8ucw/hoU6wkIJ5DQKaP1ex3uw
         5Qrg==
X-Gm-Message-State: AOJu0YwHLtdbH8zIcEIy3ODEKwA6MXPQD6kvVjRphtEUV8nOip/svYXd
	ks1jDNJJ6tS0IDZXOmfdYFsdKP5kydnILuRLgvuh1tGa/EkEyyqYZGCRB4pHeAClxNvhOoPodJW
	TPxMSXxQDWb5EMShf7hfLkypxEBU=
X-Google-Smtp-Source: AGHT+IExCzWf5fCgMlqv7sQc5JEBTKzoCjYEl5Gxdi9K/wPbqPt23T5REnExk5HjeMHU/LH+WDUj5Nf+IsYJ9YV2qvo=
X-Received: by 2002:a05:6122:1d02:b0:4d8:79c1:2a21 with SMTP id
 gc2-20020a0561221d0200b004d879c12a21mr9063727vkb.7.1711474494503; Tue, 26 Mar
 2024 10:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212316.4193790-1-daeho43@gmail.com> <712f380c-68ef-4743-bd9b-7342e838ced7@kernel.org>
 <CACOAw_yAWGbx2Bx2or1OyVUUw6HSgTd=fo3e151d1JHU+Op5qQ@mail.gmail.com>
 <c1fd6c09-0083-439b-a81d-0d2f39cb10d4@kernel.org> <CACOAw_xejyoA9f2x9J0Z-MgbmrHAPYeAmpz8Lf1GfLDs-yHh5w@mail.gmail.com>
 <30419139-6fdd-48df-b32a-9db7575cebb8@kernel.org>
In-Reply-To: <30419139-6fdd-48df-b32a-9db7575cebb8@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 26 Mar 2024 10:34:43 -0700
Message-ID: <CACOAw_ypTqWMPac=5vr+LFamYmS4uegiJfeNvRG_h_yBnfJCLQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: prevent writing without fallocate()
 for pinned files
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:39=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/25 23:02, Daeho Jeong wrote:
> > On Fri, Mar 22, 2024 at 9:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/3/21 1:42, Daeho Jeong wrote:
> >>> On Wed, Mar 20, 2024 at 2:38=E2=80=AFAM Chao Yu <chao@kernel.org> wro=
te:
> >>>>
> >>>> On 2024/3/20 5:23, Daeho Jeong wrote:
> >>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> In a case writing without fallocate(), we can't guarantee it's allo=
cated
> >>>>> in the conventional area for zoned stroage.
> >>>>>
> >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>> ---
> >>>>> v2: covered the direct io case
> >>>>> v3: covered the mkwrite case
> >>>>> ---
> >>>>>     fs/f2fs/data.c | 14 ++++++++++++--
> >>>>>     fs/f2fs/file.c | 16 ++++++++--------
> >>>>>     2 files changed, 20 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>> index c21b92f18463..d3e5ab2736a6 100644
> >>>>> --- a/fs/f2fs/data.c
> >>>>> +++ b/fs/f2fs/data.c
> >>>>> @@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, str=
uct f2fs_map_blocks *map, int flag)
> >>>>>
> >>>>>         /* use out-place-update for direct IO under LFS mode */
> >>>>>         if (map->m_may_create &&
> >>>>> -         (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_B=
LOCK_DIO))) {
> >>>>> -             if (unlikely(f2fs_cp_error(sbi))) {
> >>>>> +         (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_B=
LOCK_DIO &&
> >>>>> +                      !f2fs_is_pinned_file(inode)))) {
> >>>>> +             if (unlikely(f2fs_cp_error(sbi)) ||
> >>>>> +                 (f2fs_is_pinned_file(inode) && is_hole &&
> >>>>> +                  flag !=3D F2FS_GET_BLOCK_PRE_DIO)) {
> >>>>>                         err =3D -EIO;
> >>>>>                         goto sync_out;
> >>>>>                 }
> >>>>> @@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb=
_info *sbi,
> >>>>>                 f2fs_map_lock(sbi, flag);
> >>>>>                 locked =3D true;
> >>>>>         } else if ((pos & PAGE_MASK) >=3D i_size_read(inode)) {
> >>>>> +             if (f2fs_is_pinned_file(inode))
> >>>>> +                     return -EIO;
> >>>>>                 f2fs_map_lock(sbi, flag);
> >>>>>                 locked =3D true;
> >>>>>         }
> >>>>> @@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_s=
b_info *sbi,
> >>>>>
> >>>>>         if (!f2fs_lookup_read_extent_cache_block(inode, index,
> >>>>>                                                  &dn.data_blkaddr))=
 {
> >>>>> +             if (f2fs_is_pinned_file(inode)) {
> >>>>> +                     err =3D -EIO;
> >>>>> +                     goto out;
> >>>>> +             }
> >>>>> +
> >>>>>                 if (locked) {
> >>>>>                         err =3D f2fs_reserve_block(&dn, index);
> >>>>>                         goto out;
> >>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>>> index 82277e95c88f..4db3b21c804b 100644
> >>>>> --- a/fs/f2fs/file.c
> >>>>> +++ b/fs/f2fs/file.c
> >>>>> @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_=
fault *vmf)
> >>>>>         struct inode *inode =3D file_inode(vmf->vma->vm_file);
> >>>>>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >>>>>         struct dnode_of_data dn;
> >>>>> -     bool need_alloc =3D true;
> >>>>> +     bool need_alloc =3D !f2fs_is_pinned_file(inode);
> >>>>
> >>>> Will this check races w/ pinfile get|set?
> >>>
> >>> Do you mean "set/clear" case? I believe "set" case is okay, since we
> >>
> >> Yup,
> >>
> >>> can't set if the inode already has a data block. For "clear" case, I
> >>
> >> However, we can set pinfile on written inode in regular block device:
> >
> > You're right. I missed it. Maybe I think we should keep the concept
> > consistent across devices regardless of zoned storage support. How
> > about preventing file pinning for already written inodes across all
> > device types? I am changing the pinfile concept by allowing the users
>
> I'm okay with that, or we can tries to migrate data block of target file
> from seq-zone to conv-zone or regular-device before setting it w/ pin fla=
g...

I can't see lots of benefits by supporting file pinning for
pre-written inodes, while the design can become complicated. Since we
consolidate the way to support file pinning as fallocate() before
using it, we might as well not support pre-written inodes.

>
> Thanks,
>
> > to write on only fallocate()-ed space.
> >
> >>
> >>          if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
> >>                  ret =3D -EFBIG;
> >>                  goto out;
> >>          }
> >>
> >> Should we add the logic only if blkzoned feture is enabled?
> >>
> >>> believe mkwrite failure is okay in racy conditions caused by clearing
> >>> the pin flag. What do you think?
> >>
> >> Or we can use filemap_invalidate_lock() in f2fs_ioc_set_pin_file() to
> >> avoid the race condition?
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>         int err =3D 0;
> >>>>>         vm_fault_t ret;
> >>>>>
> >>>>> @@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct=
 vm_fault *vmf)
> >>>>>                 goto out_sem;
> >>>>>         }
> >>>>>
> >>>>> +     set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>>>         if (need_alloc) {
> >>>>>                 /* block allocation */
> >>>>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>>>                 err =3D f2fs_get_block_locked(&dn, page->index);
> >>>>> -     }
> >>>>> -
> >>>>> -#ifdef CONFIG_F2FS_FS_COMPRESSION
> >>>>> -     if (!need_alloc) {
> >>>>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >>>>> +     } else {
> >>>>>                 err =3D f2fs_get_dnode_of_data(&dn, page->index, LO=
OKUP_NODE);
> >>>>>                 f2fs_put_dnode(&dn);
> >>>>>         }
> >>>>> -#endif
> >>>>> +
> >>>>>         if (err) {
> >>>>>                 unlock_page(page);
> >>>>>                 goto out_sem;
> >>>>> @@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct ki=
ocb *iocb, struct iov_iter *iter,
> >>>>>                         return ret;
> >>>>>         }
> >>>>>
> >>>>> +     /* For pinned files, it should be fallocate()-ed in advance. =
*/
> >>>>> +     if (f2fs_is_pinned_file(inode))
> >>>>> +             return 0;
> >>>>> +
> >>>>>         /* Do not preallocate blocks that will be written partially=
 in 4KB. */
> >>>>>         map.m_lblk =3D F2FS_BLK_ALIGN(pos);
> >>>>>         map.m_len =3D F2FS_BYTES_TO_BLK(pos + count);

