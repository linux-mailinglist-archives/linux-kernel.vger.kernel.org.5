Return-Path: <linux-kernel+bounces-23919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792E82B3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0583F1C23EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E551C5E;
	Thu, 11 Jan 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsTrGLkd"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7C51C26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7cc4647543aso1557309241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704993443; x=1705598243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JljDCXTDI/7l0Qx8Rn44RazHxwBpD6tDFdZc+qfx8CA=;
        b=DsTrGLkdH/EBZ+GQnkBbFCBsXftECJGrXTW5Ry/dh6dMSkVzTo//0AlMjV/n+86veU
         jX0wouJ4wJnh9vh1ae4NuqntERBjixOvFm+Cn5NLoj3JSK6SuohSwsVlIxoQVr/UCjb8
         yAb98RIWJfbGjnzSG4aLcLWwjbwIYa3dtgkk3ROIpnhvAOJfbsNPxzUUM4pF+E0Q2QDo
         /3AWq5TOqIsCG9NyyyXq/dQ3B+jGCmsdFdA4CX7dvy1ztIZKJbrzQbo1OyWfxVFjcNA9
         GLzpvJkOnxf+MpWiwyOhg5XX85OpicJP2Cy8lOqr5IIlVQdl1oc5QM9Pu80fJtxxL7jV
         CASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993443; x=1705598243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JljDCXTDI/7l0Qx8Rn44RazHxwBpD6tDFdZc+qfx8CA=;
        b=Psv8asJKCKuFmOtYLSAGth0hzumI0M6Iigyg1jjUEZ8UsAryvc0XoraRe8KjpfMSYG
         z+CIlC4BqLeVm3FfhIy7qsdGLtZDK/r6FvzqZKZ0ruO3dC8y+1AqXTrLor3mnyXXQfLZ
         syJRTeUHuTobQs16Gcflq91BcJdHjEYM96K6AFZDMY6oM0oGNgh6QpBn9Ov+xYKobfVp
         z3yUs1PymtF0SrLrQrxTwHKS1NRErFWi6++Au4+bR/RJunBHy36LlVlrksHMzcxJv2sr
         CeE5xrOaY0gP4ZwQ/keX9w9dompxg8J2CbMumYlj2vwTjZGRMPH+rQ7Zo8N3byBLzvxE
         f2Gg==
X-Gm-Message-State: AOJu0YzYyi2Xu6pqU5NpAY/m4JM5AeZiNg6fr5ESlU02K2+7DivSL4W/
	Qh/PJ8/pJkW6ndPd67MX9LZ76/7OVRlZwJg1G9eDHBbNx35yZg==
X-Google-Smtp-Source: AGHT+IFam9uWy1vkwWojbcvxb000l0KFofS7gMtWL7ZScMT4pPuV1oxtmt9VU9gOyB4Dea+gvFiEwF2SbKJtjQykW3Q=
X-Received: by 2002:a05:6122:1812:b0:4b6:d49f:c228 with SMTP id
 ay18-20020a056122181200b004b6d49fc228mr185717vkb.26.1704993443317; Thu, 11
 Jan 2024 09:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143152.1543509-1-chao@kernel.org> <CACOAw_xXGUt=2JJgq5yfW5ZG7EfZMm1iNTVxvfA9FoJVDwbH_A@mail.gmail.com>
 <dcefc352-d528-41e3-bc7a-5cb388f43240@kernel.org>
In-Reply-To: <dcefc352-d528-41e3-bc7a-5cb388f43240@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 11 Jan 2024 09:17:12 -0800
Message-ID: <CACOAw_z=kVrD8ZctrK=ejh8TSMgzMf0-jaUM7q6CYtB3=Bqb8A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 1/6] f2fs: compress: fix to guarantee
 persisting compressed blocks by CP
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 5:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/11 8:55, Daeho Jeong wrote:
> > On Thu, Dec 28, 2023 at 6:33=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> If data block in compressed cluster is not persisted with metadata
> >> during checkpoint, after SPOR, the data may be corrupted, let's
> >> guarantee to write compressed page by checkpoint.
> >>
> >> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >> v3:
> >> - treat compressed page as CP guaranteed data explictly.
> >>   fs/f2fs/compress.c |  4 +++-
> >>   fs/f2fs/data.c     | 17 +++++++++--------
> >>   fs/f2fs/f2fs.h     |  4 +++-
> >>   3 files changed, 15 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >> index c5a4364c4482..9940b7886e5d 100644
> >> --- a/fs/f2fs/compress.c
> >> +++ b/fs/f2fs/compress.c
> >> @@ -1418,6 +1418,8 @@ void f2fs_compress_write_end_io(struct bio *bio,=
 struct page *page)
> >>          struct f2fs_sb_info *sbi =3D bio->bi_private;
> >>          struct compress_io_ctx *cic =3D
> >>                          (struct compress_io_ctx *)page_private(page);
> >> +       enum count_type type =3D WB_DATA_TYPE(page,
> >> +                               f2fs_is_compressed_page(page));
> >>          int i;
> >>
> >>          if (unlikely(bio->bi_status))
> >> @@ -1425,7 +1427,7 @@ void f2fs_compress_write_end_io(struct bio *bio,=
 struct page *page)
> >>
> >>          f2fs_compress_free_page(page);
> >>
> >> -       dec_page_count(sbi, F2FS_WB_DATA);
> >> +       dec_page_count(sbi, type);
> >>
> >>          if (atomic_dec_return(&cic->pending_pages))
> >>                  return;
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index dce8defdf4c7..81f9e2cc49e2 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -48,7 +48,7 @@ void f2fs_destroy_bioset(void)
> >>          bioset_exit(&f2fs_bioset);
> >>   }
> >>
> >> -static bool __is_cp_guaranteed(struct page *page)
> >> +bool f2fs_is_cp_guaranteed(struct page *page)
> >>   {
> >>          struct address_space *mapping =3D page->mapping;
> >>          struct inode *inode;
> >> @@ -65,8 +65,6 @@ static bool __is_cp_guaranteed(struct page *page)
> >>                          S_ISDIR(inode->i_mode))
> >>                  return true;
> >>
> >> -       if (f2fs_is_compressed_page(page))
> >> -               return false;
> >
> > Out of curiosity, why don't we simply change the above to "return true"=
?
>
> Daeho,
>
> I used the implementation, please check v1 and related comments
> from Jaegeuk and me, let me know if that was not clear enough. :)
>
> https://lore.kernel.org/linux-f2fs-devel/aae654e7-8a7e-478d-9f5a-65807a0e=
0343@kernel.org/

Oh, I missed it. Sorry~

>
> >
> >>          if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
> >>                          page_private_gcing(page))
> >>                  return true;
> >> @@ -338,7 +336,7 @@ static void f2fs_write_end_io(struct bio *bio)
> >>
> >>          bio_for_each_segment_all(bvec, bio, iter_all) {
> >>                  struct page *page =3D bvec->bv_page;
> >> -               enum count_type type =3D WB_DATA_TYPE(page);
> >> +               enum count_type type =3D WB_DATA_TYPE(page, false);
> >>
> >>                  if (page_private_dummy(page)) {
> >>                          clear_page_private_dummy(page);
> >> @@ -762,7 +760,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> >>                  wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE=
_SIZE);
> >>
> >>          inc_page_count(fio->sbi, is_read_io(fio->op) ?
> >> -                       __read_io_type(page) : WB_DATA_TYPE(fio->page)=
);
> >> +                       __read_io_type(page) : WB_DATA_TYPE(fio->page,=
 false));
> >>
> >>          if (is_read_io(bio_op(bio)))
> >>                  f2fs_submit_read_bio(fio->sbi, bio, fio->type);
> >> @@ -973,7 +971,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >>          if (fio->io_wbc)
> >>                  wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE=
_SIZE);
> >>
> >> -       inc_page_count(fio->sbi, WB_DATA_TYPE(page));
> >> +       inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
> >>
> >>          *fio->last_block =3D fio->new_blkaddr;
> >>          *fio->bio =3D bio;
> >> @@ -1007,6 +1005,7 @@ void f2fs_submit_page_write(struct f2fs_io_info =
*fio)
> >>          enum page_type btype =3D PAGE_TYPE_OF_BIO(fio->type);
> >>          struct f2fs_bio_info *io =3D sbi->write_io[btype] + fio->temp=
;
> >>          struct page *bio_page;
> >> +       enum count_type type;
> >>
> >>          f2fs_bug_on(sbi, is_read_io(fio->op));
> >>
> >> @@ -1046,7 +1045,8 @@ void f2fs_submit_page_write(struct f2fs_io_info =
*fio)
> >>          /* set submitted =3D true as a return value */
> >>          fio->submitted =3D 1;
> >>
> >> -       inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> >> +       type =3D WB_DATA_TYPE(bio_page, fio->compressed_page);
> >> +       inc_page_count(sbi, type);
> >>
> >>          if (io->bio &&
> >>              (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_i=
n_bio,
> >> @@ -1059,7 +1059,8 @@ void f2fs_submit_page_write(struct f2fs_io_info =
*fio)
> >>                  if (F2FS_IO_ALIGNED(sbi) &&
> >>                                  (fio->type =3D=3D DATA || fio->type =
=3D=3D NODE) &&
> >>                                  fio->new_blkaddr & F2FS_IO_SIZE_MASK(=
sbi)) {
> >> -                       dec_page_count(sbi, WB_DATA_TYPE(bio_page));
> >> +                       dec_page_count(sbi, WB_DATA_TYPE(bio_page,
> >> +                                               fio->compressed_page))=
;
> >>                          fio->retry =3D 1;
> >>                          goto skip;
> >>                  }
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 65294e3b0bef..50f3d546ded8 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -1080,7 +1080,8 @@ struct f2fs_sm_info {
> >>    * f2fs monitors the number of several block types such as on-writeb=
ack,
> >>    * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
> >>    */
> >> -#define WB_DATA_TYPE(p)        (__is_cp_guaranteed(p) ? F2FS_WB_CP_DA=
TA : F2FS_WB_DATA)
> >> +#define WB_DATA_TYPE(p, f)                     \
> >> +       (f || f2fs_is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DAT=
A)
> >>   enum count_type {
> >>          F2FS_DIRTY_DENTS,
> >>          F2FS_DIRTY_DATA,
> >> @@ -3804,6 +3805,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb_i=
nfo *sbi);
> >>    */
> >>   int __init f2fs_init_bioset(void);
> >>   void f2fs_destroy_bioset(void);
> >> +bool f2fs_is_cp_guaranteed(struct page *page);
> >>   int f2fs_init_bio_entry_cache(void);
> >>   void f2fs_destroy_bio_entry_cache(void);
> >>   void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
> >> --
> >> 2.40.1
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

