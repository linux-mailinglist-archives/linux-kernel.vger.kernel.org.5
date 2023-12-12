Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505680E118
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjLLBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLLBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:51:32 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E1A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:51:38 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so59284171fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702345896; x=1702950696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG9ZVTzBnb5q5QH9SpjWxO+wWPkuT4pPnNvRh66kz5g=;
        b=CZVDH9m0yIkMKBB5QokiklKtBddYyTnH16ImixwefBDjbCTxztvW+kPN4rDY10AaZP
         zS+OEkpiS486LJ8r2b7rbhrb2nv61O9n6vh+wqr42pqiww6/VTosWfAzafmS9ySjnDvD
         tlY+Vl+7V8iXpMHPRg3OTPphBl8HAMTH/zbi9pbwaQiYbMRiISZTyaDKTifUODL7YrLK
         e36/OfbsQGXTxxaID3fSp26QG0s5v5wuJIapiIwUJGjY0HcXGrN2bStIfq85XBPrk6hG
         +HRa18znP0Ba+xw86pGPO73ltOCgRcvJhFoaGj/9tMtih3768MXkEeopb36Vz1+7F1x/
         egAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702345896; x=1702950696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG9ZVTzBnb5q5QH9SpjWxO+wWPkuT4pPnNvRh66kz5g=;
        b=GdVCQVTLxUMv1ew9blt0Ytq6lNq0zZxWdzm0IFyqUEU8jOITlGrPhRxtleFHiRTYpF
         hKJQWssh4tNPI5kOFlQCgZRpdtCOLUoMcj3yJJgYREmt6DZYRQw98RY2hSKnpHAw6t5H
         +6UpzF+3K4IUJZ62piLKvNInucUseia8/fYB6qJe8/9mz9qlAYJdTzAw5gNwPrxDiKNx
         mrzip1NlkofupP67D17r6kAWBL0ctlLzRiJAh72fc1YUZgAfKJlKbDkRdslEKNgsnvXA
         4FmH+iMlWuxSjbY1VBNdjYtmGTR6ZVQ4QH9v60zLxlXg3+eoiWgjLxAY+c2L9yJoLDxA
         TefQ==
X-Gm-Message-State: AOJu0Yy27ffVYD+r/bul4eXBi9oooPfUiSnGyrAQoPmNmLBsmnSFLXVB
        GXQhD4f3u0NXdeC2oCw/JOrfNaDujdvWcAEZNdU=
X-Google-Smtp-Source: AGHT+IH/K54/DiaA15oobflIumoS3vCcWdx4bKWb+xOnQG7vCdWsujBFt24uu/d/oLuMa3BxnpvjVsYA4k4U1oMX3i8=
X-Received: by 2002:a2e:a22c:0:b0:2cb:82a1:9893 with SMTP id
 i12-20020a2ea22c000000b002cb82a19893mr1404863ljm.88.1702345896009; Mon, 11
 Dec 2023 17:51:36 -0800 (PST)
MIME-Version: 1.0
References: <1701409331-1519-1-git-send-email-zhiguo.niu@unisoc.com> <91160032-704c-480f-8a09-c61ac7be46bd@kernel.org>
In-Reply-To: <91160032-704c-480f-8a09-c61ac7be46bd@kernel.org>
From:   Zhiguo Niu <niuzhiguo84@gmail.com>
Date:   Tue, 12 Dec 2023 09:51:24 +0800
Message-ID: <CAHJ8P3LwW=rRTg=Wrs2wODiZ3c29WFUSN5JABhYt-cz_cL7Rag@mail.gmail.com>
Subject: Re: [PATCH] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To:     Chao Yu <chao@kernel.org>
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chao

On Tue, Dec 12, 2023 at 9:32=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/12/1 13:42, Zhiguo Niu wrote:
> > unify the error handling of f2fs_is_valid_blkaddr and remove some
> > redundant codes in f2fs_cache_compressed_page.
>
> What about moving f2fs_handle_error(ERROR_INVALID_BLKADDR) into
> f2fs_is_valid_blkaddr() for cleanup?
Thanks  for your suggestion and I think it is a good opinion.  I will
update this patch.
>
> Thanks,
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/checkpoint.c   |  6 +++++-
> >   fs/f2fs/compress.c     |  8 +++-----
> >   fs/f2fs/data.c         |  3 ++-
> >   fs/f2fs/extent_cache.c |  7 ++++---
> >   fs/f2fs/f2fs.h         |  6 ++++--
> >   fs/f2fs/file.c         | 10 +++++++---
> >   fs/f2fs/node.c         |  7 +++++--
> >   fs/f2fs/recovery.c     | 15 +++++++++++----
> >   8 files changed, 41 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index b0597a5..47a1335 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -158,6 +158,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *=
sbi, block_t blkaddr,
> >               f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> >                        blkaddr, exist);
> >               set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +             dump_stack();
> >               return exist;
> >       }
> >
> > @@ -256,8 +257,11 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, b=
lock_t start, int nrpages,
> >       blk_start_plug(&plug);
> >       for (; nrpages-- > 0; blkno++) {
> >
> > -             if (!f2fs_is_valid_blkaddr(sbi, blkno, type))
> > +             if (!f2fs_is_valid_blkaddr(sbi, blkno, type)) {
> > +                     err =3D -EFSCORRUPTED;
> > +                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto out;
> > +             }
> >
> >               switch (type) {
> >               case META_NAT:
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 36e5dab..15d5035 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1853,8 +1853,10 @@ void f2fs_cache_compressed_page(struct f2fs_sb_i=
nfo *sbi, struct page *page,
> >       if (!test_opt(sbi, COMPRESS_CACHE))
> >               return;
> >
> > -     if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_REA=
D))
> > +     if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_REA=
D)) {
> > +             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >               return;
> > +     }
> >
> >       if (!f2fs_available_free_memory(sbi, COMPRESS_PAGE))
> >               return;
> > @@ -1878,12 +1880,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_i=
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
> > index 4e42b5f..e1a37ea 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2309,7 +2309,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc=
, struct bio **bio_ret,
> >                       break;
> >
> >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC)) {
> > -                     ret =3D -EFAULT;
> > +                     ret =3D -EFSCORRUPTED;
> > +                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       goto out_put_dnode;
> >               }
> >               cc->nr_cpages++;
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index ad8dfac7..33e5632 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -43,7 +43,7 @@ bool sanity_check_extent_cache(struct inode *inode)
> >       if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
> >           !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
> >                                       DATA_GENERIC_ENHANCE)) {
> > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >               f2fs_warn(sbi, "%s: inode (ino=3D%lx) extent info [%u, %u=
, %u] is incorrect, run fsck to fix",
> >                         __func__, inode->i_ino,
> >                         ei->blk, ei->fofs, ei->len);
> > @@ -857,8 +857,9 @@ static int __get_new_block_age(struct inode *inode,=
 struct extent_info *ei,
> >
> >       if (__is_valid_data_blkaddr(blkaddr) &&
> >           !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> > -             f2fs_bug_on(sbi, 1);
> > -             return -EINVAL;
> > +             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +             return -EFSCORRUPTED;
> > +
> >       }
> >   out:
> >       /*
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9043ced..a4b8d86 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3454,13 +3454,16 @@ static inline int get_inline_xattr_addrs(struct=
 inode *inode)
> >
> >   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >                                       block_t blkaddr, int type);
> > +void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
> > +
> >   static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
> >                                       block_t blkaddr, int type)
> >   {
> >       if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
> >               f2fs_err(sbi, "invalid blkaddr: %u, type: %d, run fsck to=
 fix.",
> >                        blkaddr, type);
> > -             f2fs_bug_on(sbi, 1);
> > +             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +
> >       }
> >   }
> >
> > @@ -3587,7 +3590,6 @@ static inline int f2fs_add_link(struct dentry *de=
ntry, struct inode *inode)
> >   void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
> >   void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned ch=
ar reason,
> >                                                       bool irq_context)=
;
> > -void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
> >   void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char =
error);
> >   int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
> >   int f2fs_sync_fs(struct super_block *sb, int sync);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index e503635..5a7dd87 100644
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
> > @@ -466,6 +466,8 @@ static loff_t f2fs_seek_block(struct file *file, lo=
ff_t offset, int whence)
> >                               !f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> >                                       blkaddr, DATA_GENERIC_ENHANCE)) {
> >                               f2fs_put_dnode(&dn);
> > +                             err =3D -EFSCORRUPTED;
> > +                             f2fs_handle_error(F2FS_I_SB(inode), ERROR=
_INVALID_BLKADDR);
> >                               goto fail;
> >                       }
> >
> > @@ -487,7 +489,7 @@ static loff_t f2fs_seek_block(struct file *file, lo=
ff_t offset, int whence)
> >       return vfs_setpos(file, data_ofs, maxbytes);
> >   fail:
> >       inode_unlock(inode);
> > -     return -ENXIO;
> > +     return err;
> >   }
> >
> >   static loff_t f2fs_llseek(struct file *file, loff_t offset, int whenc=
e)
> > @@ -593,8 +595,10 @@ void f2fs_truncate_data_blocks_range(struct dnode_=
of_data *dn, int count)
> >
> >               if (__is_valid_data_blkaddr(blkaddr)) {
> >                       if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > -                                     DATA_GENERIC_ENHANCE))
> > +                                     DATA_GENERIC_ENHANCE)) {
> > +                             f2fs_handle_error(sbi, ERROR_INVALID_BLKA=
DDR);
> >                               continue;
> > +                     }
> >                       if (compressed_cluster)
> >                               valid_blocks++;
> >               }
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 6c7f6a6..e50a093 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -611,8 +611,10 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, n=
id_t nid,
> >   cache:
> >       blkaddr =3D le32_to_cpu(ne.block_addr);
> >       if (__is_valid_data_blkaddr(blkaddr) &&
> > -             !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE=
))
> > -             return -EFAULT;
> > +             !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE=
)) {
> > +             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +             return -EFSCORRUPTED;
> > +     }
> >
> >       /* cache nat entry */
> >       cache_nat_entry(sbi, nid, &ne);
> > @@ -1652,6 +1654,7 @@ static int __write_node_page(struct page *page, b=
ool atomic, bool *submitted,
> >       if (__is_valid_data_blkaddr(ni.blk_addr) &&
> >               !f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
> >                                       DATA_GENERIC_ENHANCE)) {
> > +             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >               f2fs_up_read(&sbi->node_write);
> >               goto redirty_out;
> >       }
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index b56d0f1..1244b8e 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -374,7 +374,8 @@ static int sanity_check_node_chain(struct f2fs_sb_i=
nfo *sbi, block_t blkaddr,
> >       for (i =3D 0; i < 2; i++) {
> >               if (!f2fs_is_valid_blkaddr(sbi, *blkaddr_fast, META_POR))=
 {
> >                       *is_detecting =3D false;
> > -                     return 0;
> > +                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +                     return -EFSCORRUPTED;
> >               }
> >
> >               page =3D f2fs_get_tmp_page(sbi, *blkaddr_fast);
> > @@ -399,6 +400,7 @@ static int sanity_check_node_chain(struct f2fs_sb_i=
nfo *sbi, block_t blkaddr,
> >       if (*blkaddr_fast =3D=3D blkaddr) {
> >               f2fs_notice(sbi, "%s: Detect looped node chain on blkaddr=
:%u."
> >                               " Run fsck to fix it.", __func__, blkaddr=
);
> > +             set_sbi_flag(sbi, SBI_NEED_FSCK);
> >               return -EINVAL;
> >       }
> >       return 0;
> > @@ -421,8 +423,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *=
sbi, struct list_head *head,
> >       while (1) {
> >               struct fsync_inode_entry *entry;
> >
> > -             if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> > -                     return 0;
> > +             if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR)) {
> > +                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +                     return -EFSCORRUPTED;
> > +             }
> >
> >               page =3D f2fs_get_tmp_page(sbi, blkaddr);
> >               if (IS_ERR(page)) {
> > @@ -786,8 +790,11 @@ static int recover_data(struct f2fs_sb_info *sbi, =
struct list_head *inode_list,
> >       while (1) {
> >               struct fsync_inode_entry *entry;
> >
> > -             if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> > +             if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR)) {
> > +                     err =3D -EFSCORRUPTED;
> > +                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                       break;
> > +             }
> >
> >               page =3D f2fs_get_tmp_page(sbi, blkaddr);
> >               if (IS_ERR(page)) {
