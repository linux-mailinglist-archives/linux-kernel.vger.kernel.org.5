Return-Path: <linux-kernel+bounces-82181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6E868058
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE8A1C21A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42DD12F39C;
	Mon, 26 Feb 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atZmTXWh"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB812F395
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974213; cv=none; b=aL5Fjh/Wnnxo6n9viw3zaVtIGmlUhTEmbbRbzdKEt0GKgD1scQm3wT2/1TkoCbpjxy9M30tb9VGlrvJ4X3EYfTTGLZxBVQSFNLG0nEMRMcQXRxsmq+nnZ10JFDuytp/3GNev9WTVuIZIIjuRiB2YFvH+aR9mTGd1gJrySzukGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974213; c=relaxed/simple;
	bh=Udycx0oIE0S8DeqbKLCeuuAq6hRc466uxCDBkmemw9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNTt0s0TPkqTcQ+EnJftRvrIerulekaGVP5u+6AvsOxVMJPF3UI22vvKO/R5jEnJO6V5Yp3Q1fpJnkaURzV3O7JTWAHBbk7nRbBMGnuywdho1TCSm5rdG7hkmAH4+OoIvswZ54ZH6ZNcZZ8EDX7tuZwLpIoUSQVaoHhIATDSwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atZmTXWh; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c199237eaeso1835184b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974211; x=1709579011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuvPxKO4uVcD2vgzVVeLbz3odA34taf8iIIWEI+/hXQ=;
        b=atZmTXWhkHfg1hYokDm5/DpDuI8R0XIkvwlTmBeA8CTFcNF4JXaLtXuKmeDDkESiOU
         L8WnVGyhxesLdoy6Ze7gIQjw0cGc7mCjZw/DvT8tfApZgMu/zaZ0sRQ5f9p7lq4AojXm
         bnO8R7ZrJziEIrC+NrXeKaHIdX2EdNcFMs2f5tjREel8Lj6PCA12V5lXHmtEOJ6KuFn7
         9DvAiAqJ994kLmR3e9czbcd3ASBrLGwkMTeHRmClztWjClqmy96JhefWJZcH1pxsj7kb
         kQjfVHk630Ii2RHgOkT/mtFwDSJePd0VCRoh+puVka9Tb236WDET+4nqXojBNT9BrmLv
         qp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974211; x=1709579011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuvPxKO4uVcD2vgzVVeLbz3odA34taf8iIIWEI+/hXQ=;
        b=TUll0S/3pK8SzTS+uzkhG7IDgQxgLkKMSPJaL+xlf29yjxXlkhoIY+v+ZFMpvCYMRl
         aab6N0OBgTPWkGyWzkt1e1sVGddv4HDNJoNHvDTeLQlxEk9WLyhZakFVhUIiw0jvkxq1
         PF0kIehMzYM0dCwVUZAO3xPGzDfyktFILukGqu4wHa93+aQ8vfB3VG2eu79Cwm9+j+zO
         2cskvnZRH0hz5XP1E1dBCejzODnXPvJk0vjVoljI8bui1qlrsWMCZzihcoMuMLu5aGc0
         eW0pbJLy5StGyqyoZKSs0wHdG9f3gxcQ6JdWz6sq4XTqYTAEBXV/iauRFIxOwp37uNGv
         5ruA==
X-Gm-Message-State: AOJu0YyN97NtTAjB8yIPOXTEDwX/LYM/ms0ErEMMxJg+ryBLaBSfGuI3
	+yR/0K5ZX6F6+49FjuUJTZOihAPB1+QsRWW19rpEtH8fI2+jE5pYynQoXH6KpXNsOfK4F5RR137
	EHl+xB830W2MWxWv4gY+1MwHzPpr4CVdrcZ4=
X-Google-Smtp-Source: AGHT+IFIGq6hMpMFJZJrdbZS097cdfFD0C17fWtOJ02dFrT1kKywN2eSdVZhPHgFkg8ilBoOrBSXpJWRTtM9THiKgIU=
X-Received: by 2002:a05:6808:4086:b0:3c1:a93c:1255 with SMTP id
 db6-20020a056808408600b003c1a93c1255mr33176oib.26.1708974211350; Mon, 26 Feb
 2024 11:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org> <20240223205535.307307-3-jaegeuk@kernel.org>
In-Reply-To: <20240223205535.307307-3-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 26 Feb 2024 11:03:20 -0800
Message-ID: <CACOAw_x1CtXDm5zf+e5y9PZfWY7rCVc5+Cpg6Hr01q3QJSyJ+Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: print zone status in string and some log
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:56=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> w=
rote:
>
> No functional change, but add some more logs.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 34 ++++++++++++++++++++++++----------
>  fs/f2fs/super.c   |  1 +
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d4f228e6f771..6d586ae8b55f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4912,6 +4912,16 @@ static int sanity_check_curseg(struct f2fs_sb_info=
 *sbi)
>  }
>
>  #ifdef CONFIG_BLK_DEV_ZONED
> +const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] =3D {
> +       [BLK_ZONE_COND_NOT_WP]          =3D "NOT_WP",
> +       [BLK_ZONE_COND_EMPTY]           =3D "EMPTY",
> +       [BLK_ZONE_COND_IMP_OPEN]        =3D "IMPLICITE_OPEN",
> +       [BLK_ZONE_COND_EXP_OPEN]        =3D "EXPLICITE_OPEN",
> +       [BLK_ZONE_COND_CLOSED]          =3D "CLOSED",
> +       [BLK_ZONE_COND_READONLY]        =3D "READONLY",
> +       [BLK_ZONE_COND_FULL]            =3D "FULL",
> +       [BLK_ZONE_COND_OFFLINE]         =3D "OFFLINE",
> +};
>
>  static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
>                                     struct f2fs_dev_info *fdev,
> @@ -4928,18 +4938,22 @@ static int check_zone_write_pointer(struct f2fs_s=
b_info *sbi,
>         zone_block =3D fdev->start_blk + (zone->start >> log_sectors_per_=
block);
>         zone_segno =3D GET_SEGNO(sbi, zone_block);
>
> +       /*
> +        * Get # of valid block of the zone.
> +        */
> +       valid_block_cnt =3D get_valid_blocks(sbi, zone_segno, true);
> +
>         /*
>          * Skip check of zones cursegs point to, since
>          * fix_curseg_write_pointer() checks them.
>          */
>         if (zone_segno >=3D MAIN_SEGS(sbi) ||

How about this not to use a wrong segno value for get_valid_blocks()
and not to print a wrong segment info?

    if (zone_segno >=3D MAIN_SEGS(sbi))
        return 0;

    valid_block_cnt =3D get_valid_blocks(sbi, zone_segno, true);

> -           IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
> +           IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno))) {
> +               f2fs_notice(sbi, "Open zones: valid block[0x%x,0x%x] cond=
[%s]",
> +                               zone_segno, valid_block_cnt,
> +                               f2fs_zone_status[zone->cond]);
>                 return 0;
> -
> -       /*
> -        * Get # of valid block of the zone.
> -        */
> -       valid_block_cnt =3D get_valid_blocks(sbi, zone_segno, true);
> +       }
>
>         if ((!valid_block_cnt && zone->cond =3D=3D BLK_ZONE_COND_EMPTY) |=
|
>             (valid_block_cnt && zone->cond =3D=3D BLK_ZONE_COND_FULL))
> @@ -4947,8 +4961,8 @@ static int check_zone_write_pointer(struct f2fs_sb_=
info *sbi,
>
>         if (!valid_block_cnt) {
>                 f2fs_notice(sbi, "Zone without valid block has non-zero w=
rite "
> -                           "pointer. Reset the write pointer: cond[0x%x]=
",
> -                           zone->cond);
> +                           "pointer. Reset the write pointer: cond[%s]",
> +                           f2fs_zone_status[zone->cond]);
>                 ret =3D __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_b=
lock,
>                                         zone->len >> log_sectors_per_bloc=
k);
>                 if (ret)
> @@ -4965,8 +4979,8 @@ static int check_zone_write_pointer(struct f2fs_sb_=
info *sbi,
>          * selected for write operation until it get discarded.
>          */
>         f2fs_notice(sbi, "Valid blocks are not aligned with write "
> -                   "pointer: valid block[0x%x,0x%x] cond[0x%x]",
> -                   zone_segno, valid_block_cnt, zone->cond);
> +                   "pointer: valid block[0x%x,0x%x] cond[%s]",
> +                   zone_segno, valid_block_cnt, f2fs_zone_status[zone->c=
ond]);
>
>         ret =3D blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
>                                 zone->start, zone->len, GFP_NOFS);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4d03ce1109ad..fc7f1a9fbbda 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4674,6 +4674,7 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>          * check zoned block devices' write pointer consistency.
>          */
>         if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> +               f2fs_notice(sbi, "Checking entire write pointers");
>                 err =3D f2fs_check_write_pointer(sbi);
>                 if (err)
>                         goto free_meta;
> --
> 2.44.0.rc0.258.g7320e95886-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

