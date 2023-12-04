Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AB803E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjLDTLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjLDTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:11:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F5AB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:11:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9b90f8708so511989b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701717095; x=1702321895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNWhwgxA2BiTvHW89Z07Z595FxAGmmg4SjHrT/mUPFA=;
        b=WLAey6F8R73prLtgkSZ1/khLiX1znNc6PNfRtdR79oMb7oat0xRAz5yNl//xpMVAqy
         D6OQBFT2jCSNYwSUC/cVRGrL3ePYxc+2jagALTTGxOa/llcZHViWkY9ym80U4IjrHm/E
         CqUYK2eENp1eQDGhG9hfVyuPJbz8v7IoKab1z8H7C4+BRIGwzUDAlpn2KCqAJqa95R6/
         UxL8sVd4pHHPG6V2/QQ/WoDMd2lnTNTucUQHX4O1pBgGj0ZUdLp6T32j5vzxQSyBh1aw
         gqn9YMd/tIe3CpIpkEA9f3Y0HLNm2eAqGCvWdO3FJeyfA1BpcHvCfS++Vtll4b9Br8U5
         seYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717095; x=1702321895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNWhwgxA2BiTvHW89Z07Z595FxAGmmg4SjHrT/mUPFA=;
        b=aUUvLIhiXPH3+0N1F+gfBL711HXJxGwUykcwVndElg4E0RC2g3k3K4lSMb3Rp2kbcH
         5N8WEwEWfMVx/QT/mTV4w17w0tzBAB2OuC1iaKJWhROEFydwVvf9LxyxYyk1IPAojxyP
         JB/8trRDhyqZo2cdZdxBprfy2rg61hteC0sqVhWjg1fZNdlzCOTsexWT5fS2AM6qLLtO
         7B3oqewIxc+jRi3O1LhDR6TqxEzMhi6+pT+fVVSCLIGu7Yj9k6IhysZ9hMXs/GFCxeky
         i2fwp1Qwq/X8az26z56+4Wm2xvUAz2QC6Sfq31oEYKl+tMVDUJNdk4CBLpeM5uCQHb1r
         4LZA==
X-Gm-Message-State: AOJu0YwuqzoH0hoQhecOowKo6F+1JJ6HppPVy7QYFINsnlp8oU6tlzNt
        wuv7MiFHkJDW3bOO0HV+4UqSIhqZU1UyX7TdD4mHW+oEs0o=
X-Google-Smtp-Source: AGHT+IGI3NuhYdnDsfW5NKV8CS89bnfjdUH54fiNP+eKer/Ubh3Ahm/hdA7CZIyoqaUWVK/5Nu33YkDO4XcJCeT2nHM=
X-Received: by 2002:a05:6830:459:b0:6d9:a231:73e2 with SMTP id
 d25-20020a056830045900b006d9a23173e2mr1888962otc.18.1701717094981; Mon, 04
 Dec 2023 11:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20231204180428.925779-1-jaegeuk@kernel.org> <20231204180428.925779-4-jaegeuk@kernel.org>
In-Reply-To: <20231204180428.925779-4-jaegeuk@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 4 Dec 2023 11:11:24 -0800
Message-ID: <CACOAw_zF8o8=z0enFBciZF+SaYbBxHxg2rOh=aRdBuv=dpcvkg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: let's finish or reset zones all the time
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

LGTM

On Mon, Dec 4, 2023 at 10:07=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> In order to limit # of open zones, let's finish or reset zones given # of
> valid blocks per section and its zone condition.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 74 +++++++++++------------------------------------
>  1 file changed, 17 insertions(+), 57 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9081c9af977a..5696a4d381ff 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4870,82 +4870,44 @@ static int check_zone_write_pointer(struct f2fs_s=
b_info *sbi,
>                                     struct f2fs_dev_info *fdev,
>                                     struct blk_zone *zone)
>  {
> -       unsigned int wp_segno, wp_blkoff, zone_secno, zone_segno, segno;
> -       block_t zone_block, wp_block, last_valid_block;
> +       unsigned int zone_segno;
> +       block_t zone_block, wp_block, valid_block_cnt;
>         unsigned int log_sectors_per_block =3D sbi->log_blocksize - SECTO=
R_SHIFT;
> -       int i, s, b, ret;
> -       struct seg_entry *se;
> +       int ret;
>
>         if (zone->type !=3D BLK_ZONE_TYPE_SEQWRITE_REQ)
>                 return 0;
>
>         wp_block =3D fdev->start_blk + (zone->wp >> log_sectors_per_block=
);
> -       wp_segno =3D GET_SEGNO(sbi, wp_block);
> -       wp_blkoff =3D wp_block - START_BLOCK(sbi, wp_segno);
>         zone_block =3D fdev->start_blk + (zone->start >> log_sectors_per_=
block);
>         zone_segno =3D GET_SEGNO(sbi, zone_block);
> -       zone_secno =3D GET_SEC_FROM_SEG(sbi, zone_segno);
> -
> -       if (zone_segno >=3D MAIN_SEGS(sbi))
> -               return 0;
>
>         /*
>          * Skip check of zones cursegs point to, since
>          * fix_curseg_write_pointer() checks them.
>          */
> -       for (i =3D 0; i < NO_CHECK_TYPE; i++)
> -               if (zone_secno =3D=3D GET_SEC_FROM_SEG(sbi,
> -                                                  CURSEG_I(sbi, i)->segn=
o))
> -                       return 0;
> +       if (zone_segno >=3D MAIN_SEGS(sbi) ||
> +           IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
> +               return 0;
>
>         /*
> -        * Get last valid block of the zone.
> +        * Get # of valid block of the zone.
>          */
> -       last_valid_block =3D zone_block - 1;
> -       for (s =3D sbi->segs_per_sec - 1; s >=3D 0; s--) {
> -               segno =3D zone_segno + s;
> -               se =3D get_seg_entry(sbi, segno);
> -               for (b =3D sbi->blocks_per_seg - 1; b >=3D 0; b--)
> -                       if (f2fs_test_bit(b, se->cur_valid_map)) {
> -                               last_valid_block =3D START_BLOCK(sbi, seg=
no) + b;
> -                               break;
> -                       }
> -               if (last_valid_block >=3D zone_block)
> -                       break;
> -       }
> +       valid_block_cnt =3D get_valid_blocks(sbi, zone_segno, true);
>
> -       /*
> -        * When safely unmounted in the previous mount, we can trust writ=
e
> -        * pointers. Otherwise, finish zones.
> -        */
> -       if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> -               /*
> -                * The write pointer matches with the valid blocks or
> -                * already points to the end of the zone.
> -                */
> -               if ((last_valid_block + 1 =3D=3D wp_block) ||
> -                               (zone->wp =3D=3D zone->start + zone->len)=
)
> -                       return 0;
> -       }
> +       if ((!valid_block_cnt && zone->cond =3D=3D BLK_ZONE_COND_EMPTY) |=
|
> +           (valid_block_cnt && zone->cond =3D=3D BLK_ZONE_COND_FULL))
> +               return 0;
>
> -       if (last_valid_block + 1 =3D=3D zone_block) {
> -               if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> -                       /*
> -                        * If there is no valid block in the zone and if =
write
> -                        * pointer is not at zone start, reset the write
> -                        * pointer.
> -                        */
> -                       f2fs_notice(sbi,
> -                             "Zone without valid block has non-zero writ=
e "
> -                             "pointer. Reset the write pointer: wp[0x%x,=
0x%x]",
> -                             wp_segno, wp_blkoff);
> -               }
> +       if (!valid_block_cnt) {
> +               f2fs_notice(sbi, "Zone without valid block has non-zero w=
rite "
> +                           "pointer. Reset the write pointer: cond[0x%x]=
",
> +                           zone->cond);
>                 ret =3D __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_b=
lock,
>                                         zone->len >> log_sectors_per_bloc=
k);
>                 if (ret)
>                         f2fs_err(sbi, "Discard zone failed: %s (errno=3D%=
d)",
>                                  fdev->path, ret);
> -
>                 return ret;
>         }
>
> @@ -4957,10 +4919,8 @@ static int check_zone_write_pointer(struct f2fs_sb=
_info *sbi,
>          * selected for write operation until it get discarded.
>          */
>         f2fs_notice(sbi, "Valid blocks are not aligned with write "
> -                           "pointer: valid block[0x%x,0x%x] wp[0x%x,0x%x=
]",
> -                           GET_SEGNO(sbi, last_valid_block),
> -                           GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
> -                           wp_segno, wp_blkoff);
> +                   "pointer: valid block[0x%x,0x%x] cond[0x%x]",
> +                   zone_segno, valid_block_cnt, zone->cond);
>
>         ret =3D blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
>                                 zone->start, zone->len, GFP_NOFS);
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
