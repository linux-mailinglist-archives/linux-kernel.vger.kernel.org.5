Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD027EF6FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbjKQRdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjKQRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:33:15 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD190
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:33:11 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so743242241.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700242390; x=1700847190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4IGSPPXFxvyFrNsP2ouXWKjMKNelkHQsMHxgrB79o8=;
        b=HcRhLlm1uFJ+99Jh6jk7z97HDD4ix6Cw0hL0tTSKQEcxd46MccoBvQstsKAZDd9R/m
         cVIEA1wx8cY8iGV1EqlhF6vLJ0GfeKQfKJiv5/wOL9in0CCAM/nfxSXfH2ufjwHAKvEi
         NMtfseCh0N+GohwhimS2lCo4SjIcWrcfQh2Nm18o8Wt0FOBnBJzx5nMOV5G37Qvenye9
         K5+5FLyQfHSCoL+wmyH1ijNdXMEMHTvRVVq9m5XkLKazqpEVezHtKK1WpHLJccSmTbkk
         j8uAsM6Us9oLRjVgRafA0rMx7OmLyeffOvcYRU9kWRsuPI7jRFwxL7JtC0u4kPeO9pc5
         2YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242390; x=1700847190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4IGSPPXFxvyFrNsP2ouXWKjMKNelkHQsMHxgrB79o8=;
        b=uEnFIUuiBucJmfUFP4zUSZrtpIZyMvWNbOk8heSSc2T/mO2tJi4Z+WP9zVJxc54+Ss
         Bww25JW/e3iLR8BWgd1Z2MKvWkGjs22hoSfSkyFevgNs/zKA5u9Ve0gfOX/ptzc3dQKb
         XrP6gYQmc9Vw1RaSucFftOctvw7hhqPkdXD2/LPsRB5E4orw+lG3x9VrgNAGIAc/6cQz
         tWvX9L0V+AjMe5I+2pHKE3erfgcga2fYNvdta5ABf7Ipfgm93zphssG9DYSJpcCNl5Jy
         Um00gw8NVtTlZieJ5SScm790p3czoQw83rHIhUrgUymQ1kVM/u2ILZuNANl5QLZj/LQw
         nf/A==
X-Gm-Message-State: AOJu0YyrSE+wijvEqeiDBy+4b7QKi1G9rEB0QlU0/dXP3VrYhJ258VVl
        dQAIMfhYwu6kSK7VqA4j4ubZd0K0aHFX51OykJ4=
X-Google-Smtp-Source: AGHT+IGEFslOx1/yTAKTVAqCKUIFwSo1ETKHjLqhB6x/O9BzXoG8Da0V8mA3Elmto+xtcPp3/tN2dwpPgDTOeA1E4sA=
X-Received: by 2002:a05:6122:3090:b0:493:7df9:bcc4 with SMTP id
 cd16-20020a056122309000b004937df9bcc4mr16311749vkb.4.1700242389940; Fri, 17
 Nov 2023 09:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20231027002123.1195780-1-daeho43@gmail.com> <e307e1bc-9c50-ed43-be12-c535b95a417e@kernel.org>
 <ZVeh2hyhHsCXIR3N@google.com>
In-Reply-To: <ZVeh2hyhHsCXIR3N@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 17 Nov 2023 09:32:58 -0800
Message-ID: <CACOAw_zjUH+T69WUT18Lr8hEcyENfv8tCGobxa0ogG+7rEFBFQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: do not reuse corrupted quota inodes
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 9:24=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 11/15, Chao Yu wrote:
> > On 2023/10/27 8:21, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > When we detect quota inode corruption, we better deallocate the curre=
nt
> > > space and allocate new ones for a clean start.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > >
> > > ---
> > > v2: change node count check when creating a new node block
> > > ---
> > >   fsck/fsck.c    | 148 +++++++++++++++++++++++++++++++++++-----------=
---
> > >   fsck/segment.c |   5 +-
> > >   2 files changed, 109 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/fsck/fsck.c b/fsck/fsck.c
> > > index 99cface..dc8e282 100644
> > > --- a/fsck/fsck.c
> > > +++ b/fsck/fsck.c
> > > @@ -67,6 +67,14 @@ int f2fs_set_sit_bitmap(struct f2fs_sb_info *sbi, =
u32 blk)
> > >     return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->sit_area_bi=
tmap);
> > >   }
> > > +static inline int f2fs_clear_sit_bitmap(struct f2fs_sb_info *sbi, u3=
2 blk)
> > > +{
> > > +   struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
> > > +
> > > +   return f2fs_clear_bit(BLKOFF_FROM_MAIN(sbi, blk),
> > > +                                           fsck->sit_area_bitmap);
> > > +}
> > > +
> > >   static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
> > >                                             u32 nid, u32 link_cnt)
> > >   {
> > > @@ -2150,6 +2158,9 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sb=
i)
> > >     return ret;
> > >   }
> > > +static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino=
,
> > > +                   bool dealloc);
> > > +
> > >   int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
> > >   {
> > >     struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
> > > @@ -2181,6 +2192,8 @@ int fsck_chk_quota_files(struct f2fs_sb_info *s=
bi)
> > >             if (c.fix_on) {
> > >                     DBG(0, "Fixing Quota file ([%3d] ino [0x%x])\n",
> > >                                                     qtype, ino);
> > > +                   fsck_disconnect_file(sbi, ino, true);
> > > +                   f2fs_rebuild_qf_inode(sbi, qtype);
> > >                     f2fs_filesize_update(sbi, ino, 0);
> > >                     ret =3D quota_write_inode(sbi, qtype);
> > >                     if (!ret) {
> > > @@ -2874,10 +2887,53 @@ static int fsck_do_reconnect_file(struct f2fs=
_sb_info *sbi,
> > >     return 0;
> > >   }
> > > -static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sb=
i,
> > > -                                   struct f2fs_inode *inode, nid_t n=
id)
> > > +static inline void release_inode_cnt(struct f2fs_sb_info *sbi, bool =
dealloc)
> > > +{
> > > +   F2FS_FSCK(sbi)->chk.valid_inode_cnt--;
> > > +   if (dealloc)
> > > +           sbi->total_valid_inode_count--;
> > > +}
> > > +
> > > +static inline void release_node_cnt(struct f2fs_sb_info *sbi, bool d=
ealloc)
> > > +{
> > > +   F2FS_FSCK(sbi)->chk.valid_node_cnt--;
> > > +   if (dealloc)
> > > +           sbi->total_valid_node_count--;
> > > +}
> > > +
> > > +static inline void release_block_cnt(struct f2fs_sb_info *sbi, bool =
dealloc)
> > > +{
> > > +   F2FS_FSCK(sbi)->chk.valid_blk_cnt--;
> > > +   if (dealloc)
> > > +           sbi->total_valid_block_count--;
> > > +}
> > > +
> > > +static inline void release_block(struct f2fs_sb_info *sbi, u64 blkad=
dr,
> > > +                   bool dealloc)
> > > +{
> > > +   f2fs_clear_main_bitmap(sbi, blkaddr);
> > > +   if (dealloc) {
> > > +           struct seg_entry *se;
> > > +           u64 offset;
> > > +
> > > +           se =3D get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
> > > +           offset =3D OFFSET_IN_SEG(sbi, blkaddr);
> > > +           se->valid_blocks--;
> > > +           f2fs_clear_bit(offset, (char *)se->cur_valid_map);
> > > +           se->dirty =3D 1;
> > > +           f2fs_clear_sit_bitmap(sbi, blkaddr);
> > > +   }
> > > +}
> > > +
> > > +static inline void release_nat_entry(struct f2fs_sb_info *sbi, u32 n=
id)
> > > +{
> > > +   nullify_nat_entry(sbi, nid);
> > > +   F2FS_FSCK(sbi)->chk.valid_nat_entry_cnt--;
> > > +}
> > > +
> > > +static void fsck_disconnect_file_dnode(struct f2fs_sb_info *sbi,
> > > +                   struct f2fs_inode *inode, nid_t nid, bool dealloc=
)
> > >   {
> > > -   struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
> > >     struct f2fs_node *node;
> > >     struct node_info ni;
> > >     u32 addr;
> > > @@ -2890,27 +2946,29 @@ static void fsck_failed_reconnect_file_dnode(=
struct f2fs_sb_info *sbi,
> > >     err =3D dev_read_block(node, ni.blk_addr);
> > >     ASSERT(err >=3D 0);
> > > -   fsck->chk.valid_node_cnt--;
> > > -   fsck->chk.valid_blk_cnt--;
> > > -   f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > > +   release_node_cnt(sbi, dealloc);
> > > +   release_block_cnt(sbi, dealloc);
> > > +   release_block(sbi, ni.blk_addr, dealloc);
> > >     for (i =3D 0; i < ADDRS_PER_BLOCK(inode); i++) {
> > >             addr =3D le32_to_cpu(node->dn.addr[i]);
> > >             if (!addr)
> > >                     continue;
> > > -           fsck->chk.valid_blk_cnt--;
> > > +           release_block_cnt(sbi, dealloc);
> > >             if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> > >                     continue;
> > > -           f2fs_clear_main_bitmap(sbi, addr);
> > > +           release_block(sbi, addr, dealloc);
> > >     }
> > > +   if (dealloc)
> > > +           release_nat_entry(sbi, nid);
> > > +
> > >     free(node);
> > >   }
> > > -static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *s=
bi,
> > > -                                   struct f2fs_inode *inode, nid_t n=
id)
> > > +static void fsck_disconnect_file_idnode(struct f2fs_sb_info *sbi,
> > > +                   struct f2fs_inode *inode, nid_t nid, bool dealloc=
)
> > >   {
> > > -   struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
> > >     struct f2fs_node *node;
> > >     struct node_info ni;
> > >     nid_t tmp;
> > > @@ -2923,24 +2981,26 @@ static void fsck_failed_reconnect_file_idnode=
(struct f2fs_sb_info *sbi,
> > >     err =3D dev_read_block(node, ni.blk_addr);
> > >     ASSERT(err >=3D 0);
> > > -   fsck->chk.valid_node_cnt--;
> > > -   fsck->chk.valid_blk_cnt--;
> > > -   f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > > +   release_node_cnt(sbi, dealloc);
> > > +   release_block_cnt(sbi, dealloc);
> > > +   release_block(sbi, ni.blk_addr, dealloc);
> > >     for (i =3D 0; i < NIDS_PER_BLOCK; i++) {
> > >             tmp =3D le32_to_cpu(node->in.nid[i]);
> > >             if (!tmp)
> > >                     continue;
> > > -           fsck_failed_reconnect_file_dnode(sbi, inode, tmp);
> > > +           fsck_disconnect_file_dnode(sbi, inode, tmp, dealloc);
> > >     }
> > > +   if (dealloc)
> > > +           release_nat_entry(sbi, nid);
> > > +
> > >     free(node);
> > >   }
> > > -static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *=
sbi,
> > > -                                   struct f2fs_inode *inode, nid_t n=
id)
> > > +static void fsck_disconnect_file_didnode(struct f2fs_sb_info *sbi,
> > > +                   struct f2fs_inode *inode, nid_t nid, bool dealloc=
)
> > >   {
> > > -   struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
> > >     struct f2fs_node *node;
> > >     struct node_info ni;
> > >     nid_t tmp;
> > > @@ -2953,28 +3013,26 @@ static void fsck_failed_reconnect_file_didnod=
e(struct f2fs_sb_info *sbi,
> > >     err =3D dev_read_block(node, ni.blk_addr);
> > >     ASSERT(err >=3D 0);
> > > -   fsck->chk.valid_node_cnt--;
> > > -   fsck->chk.valid_blk_cnt--;
> > > -   f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > > +   release_node_cnt(sbi, dealloc);
> > > +   release_block_cnt(sbi, dealloc);
> > > +   release_block(sbi, ni.blk_addr, dealloc);
> > >     for (i =3D 0; i < NIDS_PER_BLOCK; i++) {
> > >             tmp =3D le32_to_cpu(node->in.nid[i]);
> > >             if (!tmp)
> > >                     continue;
> > > -           fsck_failed_reconnect_file_idnode(sbi, inode, tmp);
> > > +           fsck_disconnect_file_idnode(sbi, inode, tmp, dealloc);
> > >     }
> > > +   if (dealloc)
> > > +           release_nat_entry(sbi, nid);
> > > +
> > >     free(node);
> > >   }
> > > -/*
> > > - * Counters and main_area_bitmap are already changed during checking
> > > - * inode block, so clear them. There is no need to clear new blocks
> > > - * allocted to lost+found.
> > > - */
> > > -static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid=
_t ino)
> > > +static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino=
,
> > > +                   bool dealloc)
> > >   {
> > > -   struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
> > >     struct f2fs_node *node;
> > >     struct node_info ni;
> > >     nid_t nid;
> > > @@ -2988,18 +3046,18 @@ static void fsck_failed_reconnect_file(struct=
 f2fs_sb_info *sbi, nid_t ino)
> > >     ASSERT(err >=3D 0);
> > >     /* clear inode counters */
> > > -   fsck->chk.valid_inode_cnt--;
> > > -   fsck->chk.valid_node_cnt--;
> > > -   fsck->chk.valid_blk_cnt--;
> > > -   f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > > +   release_inode_cnt(sbi, dealloc);
> > > +   release_node_cnt(sbi, dealloc);
> > > +   release_block_cnt(sbi, dealloc);
> > > +   release_block(sbi, ni.blk_addr, dealloc);
> > >     /* clear xnid counters */
> > >     if (node->i.i_xattr_nid) {
> > >             nid =3D le32_to_cpu(node->i.i_xattr_nid);
> > > -           fsck->chk.valid_node_cnt--;
> > > -           fsck->chk.valid_blk_cnt--;
> > > +           release_node_cnt(sbi, dealloc);
> > > +           release_block_cnt(sbi, dealloc);
> > >             get_node_info(sbi, nid, &ni);
> > > -           f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > > +           release_block(sbi, ni.blk_addr, dealloc);
> >
> > Needs to release xattr node's nat entry, right?
> >
> > if (dealloc)
> >       release_nat_entry(sbi, nid);
>
> Daeho?
>

Thanks, I am going to make a fix for this.

> >
> > Thanks,
> >
> > >     }
> > >     /* clear data counters */
> > > @@ -3009,10 +3067,10 @@ static void fsck_failed_reconnect_file(struct=
 f2fs_sb_info *sbi, nid_t ino)
> > >                     block_t addr =3D le32_to_cpu(node->i.i_addr[ofs +=
 i]);
> > >                     if (!addr)
> > >                             continue;
> > > -                   fsck->chk.valid_blk_cnt--;
> > > +                   release_block_cnt(sbi, dealloc);
> > >                     if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_=
ADDR)
> > >                             continue;
> > > -                   f2fs_clear_main_bitmap(sbi, addr);
> > > +                   release_block(sbi, addr, dealloc);
> > >             }
> > >     }
> > > @@ -3024,18 +3082,24 @@ static void fsck_failed_reconnect_file(struct=
 f2fs_sb_info *sbi, nid_t ino)
> > >             switch (i) {
> > >             case 0: /* direct node */
> > >             case 1:
> > > -                   fsck_failed_reconnect_file_dnode(sbi, &node->i, n=
id);
> > > +                   fsck_disconnect_file_dnode(sbi, &node->i, nid,
> > > +                                   dealloc);
> > >                     break;
> > >             case 2: /* indirect node */
> > >             case 3:
> > > -                   fsck_failed_reconnect_file_idnode(sbi, &node->i, =
nid);
> > > +                   fsck_disconnect_file_idnode(sbi, &node->i, nid,
> > > +                                   dealloc);
> > >                     break;
> > >             case 4: /* double indirect node */
> > > -                   fsck_failed_reconnect_file_didnode(sbi, &node->i,=
 nid);
> > > +                   fsck_disconnect_file_didnode(sbi, &node->i, nid,
> > > +                                   dealloc);
> > >                     break;
> > >             }
> > >     }
> > > +   if (dealloc)
> > > +           release_nat_entry(sbi, ino);
> > > +
> > >     free(node);
> > >   }
> > > @@ -3121,7 +3185,7 @@ static int fsck_reconnect_file(struct f2fs_sb_i=
nfo *sbi)
> > >                     if (fsck_do_reconnect_file(sbi, lpf_node, node)) =
{
> > >                             DBG(1, "Failed to reconnect inode [0x%x]\=
n",
> > >                                 nid);
> > > -                           fsck_failed_reconnect_file(sbi, nid);
> > > +                           fsck_disconnect_file(sbi, nid, false);
> > >                             continue;
> > >                     }
> > > diff --git a/fsck/segment.c b/fsck/segment.c
> > > index 3a9500f..4e326c4 100644
> > > --- a/fsck/segment.c
> > > +++ b/fsck/segment.c
> > > @@ -37,7 +37,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, blo=
ck_t *to,
> > >                             return -ENOSPC;
> > >                     }
> > >                     if (is_node && fsck->chk.valid_node_cnt >=3D
> > > -                                   sbi->total_valid_node_count) {
> > > +                                   sbi->total_node_count) {
> > >                             ERR_MSG("Not enough space for node block\=
n");
> > >                             return -ENOSPC;
> > >                     }
> > > @@ -76,7 +76,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, blo=
ck_t *to,
> > >     se =3D get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
> > >     offset =3D OFFSET_IN_SEG(sbi, blkaddr);
> > > -   se->type =3D type;
> > > +   se->type =3D se->orig_type =3D type;
> > >     if (se->valid_blocks =3D=3D 0)
> > >             SM_I(sbi)->free_segments--;
> > >     se->valid_blocks++;
> > > @@ -101,6 +101,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, b=
lock_t *to,
> > >             if (c.func =3D=3D FSCK) {
> > >                     fsck->chk.valid_blk_cnt++;
> > >                     if (is_node) {
> > > +                           fsck->chk.valid_nat_entry_cnt++;
> > >                             fsck->chk.valid_node_cnt++;
> > >                             if (is_inode)
> > >                                     fsck->chk.valid_inode_cnt++;
