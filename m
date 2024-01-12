Return-Path: <linux-kernel+bounces-25077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808782C736
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EE71C2248B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40A1945E;
	Fri, 12 Jan 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je85hg6c"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0D18C01
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ddf388ca74so1706926a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705098028; x=1705702828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsyhCTVxxckx0n+ATAL7x0fno4ad8i+6BqknWTE/NcQ=;
        b=je85hg6cMRlyuGdUkc07GFztuF38ktx86hidNth3WGOqtOouF5v7xiJmEQ+poqBhXo
         pDcFtryKrlmkUChJydFOmhYoZNNq9yyKBQmdOt+oApeQu83Qg1hIw9eNpR0bOced/jg2
         2l3OmhgBarD4U3/+ACLWZ0cRWFOTONOzj6HvLsharndNeQti05liX80Fl4BBdmhnLmkS
         pQSSt5zH13G/Numv1Ahf+L87sUvk0RmW3U7d5hHmGquCQKzJzqpAO/d8azly5HRozeNj
         PlJ47GPhIt+F2TJTAKGjyCtKCMby8LC8brUG0jp/aDEtSCEXpIFmqmFP+ey62v/hJ5JZ
         W7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705098028; x=1705702828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsyhCTVxxckx0n+ATAL7x0fno4ad8i+6BqknWTE/NcQ=;
        b=oTRK89mKFTsL1yTgPeFbRPyL4SczMz1d5ShV2OJAypv8qsBpgdfYHt4/GNkdcj2wRF
         ADIgOhIUoCoYiARRCt58H62EkuiAKb4f2Y/dEFq+4Zr7F4eizQfVaZzYooaUoRDEm2Cy
         Rl9m/wM9dVy2wuiGoJ2b/MWfVpBiVLKBtgkccBcfxB63OaGlvO5TiIhAcLsCSIRvUlY3
         WICFpnvFlqbFJxw6LXY+rBg2Ka2R/ZRk//3+5YVPI1ZW6bPBB1D4WrolQrsqBRCrWhAP
         kOkJAEx2/9X1BCcWuKhqsnCfjPvriLS28PfcMGn7j5uKNBsbiV9YuFsVt8qxdkqtL2Vr
         Yzgg==
X-Gm-Message-State: AOJu0Yw2TSAJPkVkUncltjmkML3ywK5ExZBTjPoq4/ehdTWC8qb96Sj2
	rBnVuCsqXTCQxygj74jixKkzsZ02ZA1SclNGsdlGanyJnne1nA==
X-Google-Smtp-Source: AGHT+IHUgf8bIMRZW6OWV5FbOMUg/ttXmJhymJVHC0BedU4/xNBh+ld0HEoVYtiRlO0ElxhVo0JIZCUJV6UXwGl4Sa8=
X-Received: by 2002:a9d:7d06:0:b0:6dc:41c:9bc6 with SMTP id
 v6-20020a9d7d06000000b006dc041c9bc6mr2113012otn.36.1705098028448; Fri, 12 Jan
 2024 14:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111064208.2969599-1-chao@kernel.org> <20240111064208.2969599-6-chao@kernel.org>
In-Reply-To: <20240111064208.2969599-6-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:20:17 -0800
Message-ID: <CACOAw_xANX_O2hhN9M7SrA0HEzQyWS8yFqfVwS5T+_2gbyZ1LQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 6/6] f2fs: introduce FAULT_BLKADDR_CONSISTENCE
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Jan 10, 2024 at 10:43=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> We will encounter below inconsistent status when FAULT_BLKADDR type
> fault injection is on.
>
> Info: checkpoint state =3D d6 :  nat_bits crc fsck compacted_summary orph=
an_inodes sudden-power-off
> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c100 has i_blocks: 000000=
c0, but has 191 blocks
> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1c100] i_blocks=3D0x000000c0 -> 0=
xbf
> [FIX] (fsck_chk_inode_blk:1269)  --> [0x1c100] i_compr_blocks=3D0x0000002=
6 -> 0x27
> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1cadb has i_blocks: 000000=
2f, but has 46 blocks
> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1cadb] i_blocks=3D0x0000002f -> 0=
x2e
> [FIX] (fsck_chk_inode_blk:1269)  --> [0x1cadb] i_compr_blocks=3D0x0000001=
1 -> 0x12
> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c62c has i_blocks: 000000=
02, but has 1 blocks
> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1c62c] i_blocks=3D0x00000002 -> 0=
x1
>
> After we inject fault into f2fs_is_valid_blkaddr() during truncation,
> a) it missed to increase @nr_free or @valid_blocks
> b) it can cause in blkaddr leak in truncated dnode
> Which may cause inconsistent status.
>
> This patch separates FAULT_BLKADDR_CONSISTENCE from FAULT_BLKADDR,
> and rename FAULT_BLKADDR to FAULT_BLKADDR_VALIDITY
> so that we can:
> a) use FAULT_BLKADDR_CONSISTENCE in f2fs_truncate_data_blocks_range()
> to simulate inconsistent issue independently, then it can verify fsck
> repair flow.
> b) FAULT_BLKADDR_VALIDITY fault will not cause any inconsistent status,
> we can just use it to check error path handling in kernel side.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - rename macro to FAULT_BLKADDR_CONSISTENCE and FAULT_BLKADDR_VALIDITY
> suggested by Jaegeuk.
>  Documentation/ABI/testing/sysfs-fs-f2fs | 47 +++++++++++++------------
>  Documentation/filesystems/f2fs.rst      | 47 +++++++++++++------------
>  fs/f2fs/checkpoint.c                    | 19 +++++++---
>  fs/f2fs/f2fs.h                          |  5 ++-
>  fs/f2fs/file.c                          |  8 +++--
>  fs/f2fs/super.c                         | 37 +++++++++----------
>  6 files changed, 92 insertions(+), 71 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/=
testing/sysfs-fs-f2fs
> index 99fa87a43926..48c135e24eb5 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -701,29 +701,30 @@ Description:      Support configuring fault injecti=
on type, should be
>                 enabled with fault_injection option, fault type value
>                 is shown below, it supports single or combined type.
>
> -               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -               Type_Name                Type_Value
> -               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -               FAULT_KMALLOC            0x000000001
> -               FAULT_KVMALLOC           0x000000002
> -               FAULT_PAGE_ALLOC         0x000000004
> -               FAULT_PAGE_GET           0x000000008
> -               FAULT_ALLOC_BIO          0x000000010 (obsolete)
> -               FAULT_ALLOC_NID          0x000000020
> -               FAULT_ORPHAN             0x000000040
> -               FAULT_BLOCK              0x000000080
> -               FAULT_DIR_DEPTH          0x000000100
> -               FAULT_EVICT_INODE        0x000000200
> -               FAULT_TRUNCATE           0x000000400
> -               FAULT_READ_IO            0x000000800
> -               FAULT_CHECKPOINT         0x000001000
> -               FAULT_DISCARD            0x000002000
> -               FAULT_WRITE_IO           0x000004000
> -               FAULT_SLAB_ALLOC         0x000008000
> -               FAULT_DQUOT_INIT         0x000010000
> -               FAULT_LOCK_OP            0x000020000
> -               FAULT_BLKADDR            0x000040000
> -               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               Type_Name                        Type_Value
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               FAULT_KMALLOC                    0x000000001
> +               FAULT_KVMALLOC                   0x000000002
> +               FAULT_PAGE_ALLOC                 0x000000004
> +               FAULT_PAGE_GET                   0x000000008
> +               FAULT_ALLOC_BIO                  0x000000010 (obsolete)
> +               FAULT_ALLOC_NID                  0x000000020
> +               FAULT_ORPHAN                     0x000000040
> +               FAULT_BLOCK                      0x000000080
> +               FAULT_DIR_DEPTH                  0x000000100
> +               FAULT_EVICT_INODE                0x000000200
> +               FAULT_TRUNCATE                   0x000000400
> +               FAULT_READ_IO                    0x000000800
> +               FAULT_CHECKPOINT                 0x000001000
> +               FAULT_DISCARD                    0x000002000
> +               FAULT_WRITE_IO                   0x000004000
> +               FAULT_SLAB_ALLOC                 0x000008000
> +               FAULT_DQUOT_INIT                 0x000010000
> +               FAULT_LOCK_OP                    0x000020000
> +               FAULT_BLKADDR_VALIDITY           0x000040000
> +               FAULT_BLKADDR_CONSISTENCE        0x000080000
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/fs/f2fs/<disk>/discard_io_aware_gran
>  Date:          January 2023
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesyste=
ms/f2fs.rst
> index d32c6209685d..32cbfa864f38 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -184,29 +184,30 @@ fault_type=3D%d              Support configuring fa=
ult injection type, should be
>                          enabled with fault_injection option, fault type =
value
>                          is shown below, it supports single or combined t=
ype.
>
> -                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -                        Type_Name                Type_Value
> -                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -                        FAULT_KMALLOC            0x000000001
> -                        FAULT_KVMALLOC           0x000000002
> -                        FAULT_PAGE_ALLOC         0x000000004
> -                        FAULT_PAGE_GET           0x000000008
> -                        FAULT_ALLOC_BIO          0x000000010 (obsolete)
> -                        FAULT_ALLOC_NID          0x000000020
> -                        FAULT_ORPHAN             0x000000040
> -                        FAULT_BLOCK              0x000000080
> -                        FAULT_DIR_DEPTH          0x000000100
> -                        FAULT_EVICT_INODE        0x000000200
> -                        FAULT_TRUNCATE           0x000000400
> -                        FAULT_READ_IO            0x000000800
> -                        FAULT_CHECKPOINT         0x000001000
> -                        FAULT_DISCARD            0x000002000
> -                        FAULT_WRITE_IO           0x000004000
> -                        FAULT_SLAB_ALLOC         0x000008000
> -                        FAULT_DQUOT_INIT         0x000010000
> -                        FAULT_LOCK_OP            0x000020000
> -                        FAULT_BLKADDR            0x000040000
> -                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                        Type_Name                        Type_Value
> +                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                        FAULT_KMALLOC                    0x000000001
> +                        FAULT_KVMALLOC                   0x000000002
> +                        FAULT_PAGE_ALLOC                 0x000000004
> +                        FAULT_PAGE_GET                   0x000000008
> +                        FAULT_ALLOC_BIO                  0x000000010 (ob=
solete)
> +                        FAULT_ALLOC_NID                  0x000000020
> +                        FAULT_ORPHAN                     0x000000040
> +                        FAULT_BLOCK                      0x000000080
> +                        FAULT_DIR_DEPTH                  0x000000100
> +                        FAULT_EVICT_INODE                0x000000200
> +                        FAULT_TRUNCATE                   0x000000400
> +                        FAULT_READ_IO                    0x000000800
> +                        FAULT_CHECKPOINT                 0x000001000
> +                        FAULT_DISCARD                    0x000002000
> +                        FAULT_WRITE_IO                   0x000004000
> +                        FAULT_SLAB_ALLOC                 0x000008000
> +                        FAULT_DQUOT_INIT                 0x000010000
> +                        FAULT_LOCK_OP                    0x000020000
> +                        FAULT_BLKADDR_VALIDITY           0x000040000
> +                        FAULT_BLKADDR_CONSISTENCE        0x000080000
> +                        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  mode=3D%s                         Control block allocation mode which su=
pports "adaptive"
>                          and "lfs". In "lfs" mode, there should be no ran=
dom
>                          writes towards main area.
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b0597a539fc5..b85820e70f5e 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -170,12 +170,9 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *s=
bi, block_t blkaddr,
>         return exist;
>  }
>
> -bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> +static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>                                         block_t blkaddr, int type)
>  {
> -       if (time_to_inject(sbi, FAULT_BLKADDR))
> -               return false;
> -
>         switch (type) {
>         case META_NAT:
>                 break;
> @@ -230,6 +227,20 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>         return true;
>  }
>
> +bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> +                                       block_t blkaddr, int type)
> +{
> +       if (time_to_inject(sbi, FAULT_BLKADDR_VALIDITY))
> +               return false;
> +       return __f2fs_is_valid_blkaddr(sbi, blkaddr, type);
> +}
> +
> +bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
> +                                       block_t blkaddr, int type)
> +{
> +       return __f2fs_is_valid_blkaddr(sbi, blkaddr, type);
> +}
> +
>  /*
>   * Readahead CP/NAT/SIT/SSA/POR pages
>   */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ab710bb6d8b3..4481f68d6418 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -60,7 +60,8 @@ enum {
>         FAULT_SLAB_ALLOC,
>         FAULT_DQUOT_INIT,
>         FAULT_LOCK_OP,
> -       FAULT_BLKADDR,
> +       FAULT_BLKADDR_VALIDITY,
> +       FAULT_BLKADDR_CONSISTENCE,
>         FAULT_MAX,
>  };
>
> @@ -3768,6 +3769,8 @@ struct page *f2fs_get_meta_page_retry(struct f2fs_s=
b_info *sbi, pgoff_t index);
>  struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
>  bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>                                         block_t blkaddr, int type);
> +bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
> +                                       block_t blkaddr, int type);
>  int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpa=
ges,
>                         int type, bool sync);
>  void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 53c495651789..0e4c871d6aed 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -590,9 +590,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of=
_data *dn, int count)
>                 f2fs_set_data_blkaddr(dn, NULL_ADDR);
>
>                 if (__is_valid_data_blkaddr(blkaddr)) {
> -                       if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -                                       DATA_GENERIC_ENHANCE))
> +                       if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE=
))
> +                               continue;
> +                       if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> +                                               DATA_GENERIC_ENHANCE)) {
> +                               f2fs_handle_error(sbi, ERROR_INVALID_BLKA=
DDR);
>                                 continue;
> +                       }
>                         if (compressed_cluster)
>                                 valid_blocks++;
>                 }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 206d03c82d96..4de5478972b2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -44,24 +44,25 @@ static struct kmem_cache *f2fs_inode_cachep;
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>
>  const char *f2fs_fault_name[FAULT_MAX] =3D {
> -       [FAULT_KMALLOC]         =3D "kmalloc",
> -       [FAULT_KVMALLOC]        =3D "kvmalloc",
> -       [FAULT_PAGE_ALLOC]      =3D "page alloc",
> -       [FAULT_PAGE_GET]        =3D "page get",
> -       [FAULT_ALLOC_NID]       =3D "alloc nid",
> -       [FAULT_ORPHAN]          =3D "orphan",
> -       [FAULT_BLOCK]           =3D "no more block",
> -       [FAULT_DIR_DEPTH]       =3D "too big dir depth",
> -       [FAULT_EVICT_INODE]     =3D "evict_inode fail",
> -       [FAULT_TRUNCATE]        =3D "truncate fail",
> -       [FAULT_READ_IO]         =3D "read IO error",
> -       [FAULT_CHECKPOINT]      =3D "checkpoint error",
> -       [FAULT_DISCARD]         =3D "discard error",
> -       [FAULT_WRITE_IO]        =3D "write IO error",
> -       [FAULT_SLAB_ALLOC]      =3D "slab alloc",
> -       [FAULT_DQUOT_INIT]      =3D "dquot initialize",
> -       [FAULT_LOCK_OP]         =3D "lock_op",
> -       [FAULT_BLKADDR]         =3D "invalid blkaddr",
> +       [FAULT_KMALLOC]                 =3D "kmalloc",
> +       [FAULT_KVMALLOC]                =3D "kvmalloc",
> +       [FAULT_PAGE_ALLOC]              =3D "page alloc",
> +       [FAULT_PAGE_GET]                =3D "page get",
> +       [FAULT_ALLOC_NID]               =3D "alloc nid",
> +       [FAULT_ORPHAN]                  =3D "orphan",
> +       [FAULT_BLOCK]                   =3D "no more block",
> +       [FAULT_DIR_DEPTH]               =3D "too big dir depth",
> +       [FAULT_EVICT_INODE]             =3D "evict_inode fail",
> +       [FAULT_TRUNCATE]                =3D "truncate fail",
> +       [FAULT_READ_IO]                 =3D "read IO error",
> +       [FAULT_CHECKPOINT]              =3D "checkpoint error",
> +       [FAULT_DISCARD]                 =3D "discard error",
> +       [FAULT_WRITE_IO]                =3D "write IO error",
> +       [FAULT_SLAB_ALLOC]              =3D "slab alloc",
> +       [FAULT_DQUOT_INIT]              =3D "dquot initialize",
> +       [FAULT_LOCK_OP]                 =3D "lock_op",
> +       [FAULT_BLKADDR_VALIDITY]        =3D "invalid blkaddr",
> +       [FAULT_BLKADDR_CONSISTENCE]     =3D "inconsistent blkaddr",
>  };
>
>  void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

