Return-Path: <linux-kernel+bounces-25058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA782C708
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1C41F23A58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D217745;
	Fri, 12 Jan 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8pCtRWZ"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67117734
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so1873201241.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705097717; x=1705702517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhMe8z8Sw2vM4e+MnbwTOmnay90Wc0ycXpHjBgOQgjI=;
        b=L8pCtRWZFDXxjUQ49dRWiWoTtTU+lqbiLDj8Tt8M2PzHtvm17ad83Or4x5sYISAjbT
         ZTggisDPw2w5YhCbD15PYsprgSm28Vx7kOTAP2/wCOPVO3QRmMZt2PSz2DhfodLBNMCO
         W14R/BTYtZxCH0SybEt2nJXN7OZvK0idk79TYHBWCHqspzmwDoEWPUAzwX8xGxMwvFB8
         e4vbeok3pcLmu5u6Upsw4FkF1zWpGi2tHUHg89UQ+dytPO/+RR6QMKSZR7dATYpqIVwg
         IiFp9G+VE9Z9SUFP7119Dq9TmncW/lZqxsqsATUUM1nv3S6Lils9skTzrjEPzfIk1k+Q
         Iuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097717; x=1705702517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhMe8z8Sw2vM4e+MnbwTOmnay90Wc0ycXpHjBgOQgjI=;
        b=nvOrd0rBGejPj0/5nhAFo2Otn6+HNDNXKhZd9ebN1j7k6AXQd+B8nOVorh5FD+nP4F
         wtxMlZdUq1QfS1TRxGMQe1lW9kv3bPyR5BeXUxhEzQ3mJ1XWJnl+1yqQnws4C3Y82f2f
         S7lVv7qpWGIYIEEUoJUlt4gBc7tAcLeGMHfjB5z1zEOibIjQu8eQ2JUjRXn2+ndUcGIS
         Ow2aGnUR/y/3bYoz74GG3UEBCk+rPOo6Xzw/ab9idbTw+gJMoBNqcntW44f8B6lrH3h2
         ulha/8WEVtf5LkY5yRV7mmzOD2fjxSHKb/1lzi9hqyKHadKOnS42TkEIL7nlgPmaCBtZ
         7qmw==
X-Gm-Message-State: AOJu0YwrCOVqc9BsJXOFy35hzUdJn71KiD4XSbFLR/FqfdCrLDDN/IlO
	tkkv0gq4eiTqM2HQMtEVOwi+NgcIp1vtAJO3nZ0snWSdUQmeog==
X-Google-Smtp-Source: AGHT+IEeNFxFQtUxxk8Cp92BdPQ9DeDWBFE8dPARbDo7V83RFzc6XAOBg7gwxYZ1n6iIa85TJzyW4YgtF7Umz8vsdQs=
X-Received: by 2002:a05:6122:4491:b0:4b7:8199:5d17 with SMTP id
 cz17-20020a056122449100b004b781995d17mr1742638vkb.25.1705097717189; Fri, 12
 Jan 2024 14:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143152.1543509-1-chao@kernel.org> <CACOAw_xXGUt=2JJgq5yfW5ZG7EfZMm1iNTVxvfA9FoJVDwbH_A@mail.gmail.com>
 <dcefc352-d528-41e3-bc7a-5cb388f43240@kernel.org> <CACOAw_z=kVrD8ZctrK=ejh8TSMgzMf0-jaUM7q6CYtB3=Bqb8A@mail.gmail.com>
In-Reply-To: <CACOAw_z=kVrD8ZctrK=ejh8TSMgzMf0-jaUM7q6CYtB3=Bqb8A@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:15:06 -0800
Message-ID: <CACOAw_y-nnM3ms-TAiHMxGRw9n+Ad5qdf+40yzQ-jVYg4uR-TA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 1/6] f2fs: compress: fix to guarantee
 persisting compressed blocks by CP
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Thu, Jan 11, 2024 at 9:17=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> On Wed, Jan 10, 2024 at 5:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2024/1/11 8:55, Daeho Jeong wrote:
> > > On Thu, Dec 28, 2023 at 6:33=E2=80=AFAM Chao Yu <chao@kernel.org> wro=
te:
> > >>
> > >> If data block in compressed cluster is not persisted with metadata
> > >> during checkpoint, after SPOR, the data may be corrupted, let's
> > >> guarantee to write compressed page by checkpoint.
> > >>
> > >> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > >> Signed-off-by: Chao Yu <chao@kernel.org>
> > >> ---
> > >> v3:
> > >> - treat compressed page as CP guaranteed data explictly.
> > >>   fs/f2fs/compress.c |  4 +++-
> > >>   fs/f2fs/data.c     | 17 +++++++++--------
> > >>   fs/f2fs/f2fs.h     |  4 +++-
> > >>   3 files changed, 15 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > >> index c5a4364c4482..9940b7886e5d 100644
> > >> --- a/fs/f2fs/compress.c
> > >> +++ b/fs/f2fs/compress.c
> > >> @@ -1418,6 +1418,8 @@ void f2fs_compress_write_end_io(struct bio *bi=
o, struct page *page)
> > >>          struct f2fs_sb_info *sbi =3D bio->bi_private;
> > >>          struct compress_io_ctx *cic =3D
> > >>                          (struct compress_io_ctx *)page_private(page=
);
> > >> +       enum count_type type =3D WB_DATA_TYPE(page,
> > >> +                               f2fs_is_compressed_page(page));
> > >>          int i;
> > >>
> > >>          if (unlikely(bio->bi_status))
> > >> @@ -1425,7 +1427,7 @@ void f2fs_compress_write_end_io(struct bio *bi=
o, struct page *page)
> > >>
> > >>          f2fs_compress_free_page(page);
> > >>
> > >> -       dec_page_count(sbi, F2FS_WB_DATA);
> > >> +       dec_page_count(sbi, type);
> > >>
> > >>          if (atomic_dec_return(&cic->pending_pages))
> > >>                  return;
> > >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > >> index dce8defdf4c7..81f9e2cc49e2 100644
> > >> --- a/fs/f2fs/data.c
> > >> +++ b/fs/f2fs/data.c
> > >> @@ -48,7 +48,7 @@ void f2fs_destroy_bioset(void)
> > >>          bioset_exit(&f2fs_bioset);
> > >>   }
> > >>
> > >> -static bool __is_cp_guaranteed(struct page *page)
> > >> +bool f2fs_is_cp_guaranteed(struct page *page)
> > >>   {
> > >>          struct address_space *mapping =3D page->mapping;
> > >>          struct inode *inode;
> > >> @@ -65,8 +65,6 @@ static bool __is_cp_guaranteed(struct page *page)
> > >>                          S_ISDIR(inode->i_mode))
> > >>                  return true;
> > >>
> > >> -       if (f2fs_is_compressed_page(page))
> > >> -               return false;
> > >
> > > Out of curiosity, why don't we simply change the above to "return tru=
e"?
> >
> > Daeho,
> >
> > I used the implementation, please check v1 and related comments
> > from Jaegeuk and me, let me know if that was not clear enough. :)
> >
> > https://lore.kernel.org/linux-f2fs-devel/aae654e7-8a7e-478d-9f5a-65807a=
0e0343@kernel.org/
>
> Oh, I missed it. Sorry~
>
> >
> > >
> > >>          if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
> > >>                          page_private_gcing(page))
> > >>                  return true;
> > >> @@ -338,7 +336,7 @@ static void f2fs_write_end_io(struct bio *bio)
> > >>
> > >>          bio_for_each_segment_all(bvec, bio, iter_all) {
> > >>                  struct page *page =3D bvec->bv_page;
> > >> -               enum count_type type =3D WB_DATA_TYPE(page);
> > >> +               enum count_type type =3D WB_DATA_TYPE(page, false);
> > >>
> > >>                  if (page_private_dummy(page)) {
> > >>                          clear_page_private_dummy(page);
> > >> @@ -762,7 +760,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fi=
o)
> > >>                  wbc_account_cgroup_owner(fio->io_wbc, fio->page, PA=
GE_SIZE);
> > >>
> > >>          inc_page_count(fio->sbi, is_read_io(fio->op) ?
> > >> -                       __read_io_type(page) : WB_DATA_TYPE(fio->pag=
e));
> > >> +                       __read_io_type(page) : WB_DATA_TYPE(fio->pag=
e, false));
> > >>
> > >>          if (is_read_io(bio_op(bio)))
> > >>                  f2fs_submit_read_bio(fio->sbi, bio, fio->type);
> > >> @@ -973,7 +971,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio=
)
> > >>          if (fio->io_wbc)
> > >>                  wbc_account_cgroup_owner(fio->io_wbc, fio->page, PA=
GE_SIZE);
> > >>
> > >> -       inc_page_count(fio->sbi, WB_DATA_TYPE(page));
> > >> +       inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
> > >>
> > >>          *fio->last_block =3D fio->new_blkaddr;
> > >>          *fio->bio =3D bio;
> > >> @@ -1007,6 +1005,7 @@ void f2fs_submit_page_write(struct f2fs_io_inf=
o *fio)
> > >>          enum page_type btype =3D PAGE_TYPE_OF_BIO(fio->type);
> > >>          struct f2fs_bio_info *io =3D sbi->write_io[btype] + fio->te=
mp;
> > >>          struct page *bio_page;
> > >> +       enum count_type type;
> > >>
> > >>          f2fs_bug_on(sbi, is_read_io(fio->op));
> > >>
> > >> @@ -1046,7 +1045,8 @@ void f2fs_submit_page_write(struct f2fs_io_inf=
o *fio)
> > >>          /* set submitted =3D true as a return value */
> > >>          fio->submitted =3D 1;
> > >>
> > >> -       inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> > >> +       type =3D WB_DATA_TYPE(bio_page, fio->compressed_page);
> > >> +       inc_page_count(sbi, type);
> > >>
> > >>          if (io->bio &&
> > >>              (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block=
_in_bio,
> > >> @@ -1059,7 +1059,8 @@ void f2fs_submit_page_write(struct f2fs_io_inf=
o *fio)
> > >>                  if (F2FS_IO_ALIGNED(sbi) &&
> > >>                                  (fio->type =3D=3D DATA || fio->type=
 =3D=3D NODE) &&
> > >>                                  fio->new_blkaddr & F2FS_IO_SIZE_MAS=
K(sbi)) {
> > >> -                       dec_page_count(sbi, WB_DATA_TYPE(bio_page));
> > >> +                       dec_page_count(sbi, WB_DATA_TYPE(bio_page,
> > >> +                                               fio->compressed_page=
));
> > >>                          fio->retry =3D 1;
> > >>                          goto skip;
> > >>                  }
> > >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > >> index 65294e3b0bef..50f3d546ded8 100644
> > >> --- a/fs/f2fs/f2fs.h
> > >> +++ b/fs/f2fs/f2fs.h
> > >> @@ -1080,7 +1080,8 @@ struct f2fs_sm_info {
> > >>    * f2fs monitors the number of several block types such as on-writ=
eback,
> > >>    * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
> > >>    */
> > >> -#define WB_DATA_TYPE(p)        (__is_cp_guaranteed(p) ? F2FS_WB_CP_=
DATA : F2FS_WB_DATA)
> > >> +#define WB_DATA_TYPE(p, f)                     \
> > >> +       (f || f2fs_is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_D=
ATA)
> > >>   enum count_type {
> > >>          F2FS_DIRTY_DENTS,
> > >>          F2FS_DIRTY_DATA,
> > >> @@ -3804,6 +3805,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb=
_info *sbi);
> > >>    */
> > >>   int __init f2fs_init_bioset(void);
> > >>   void f2fs_destroy_bioset(void);
> > >> +bool f2fs_is_cp_guaranteed(struct page *page);
> > >>   int f2fs_init_bio_entry_cache(void);
> > >>   void f2fs_destroy_bio_entry_cache(void);
> > >>   void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bi=
o,
> > >> --
> > >> 2.40.1
> > >>
> > >>
> > >>
> > >> _______________________________________________
> > >> Linux-f2fs-devel mailing list
> > >> Linux-f2fs-devel@lists.sourceforge.net
> > >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

