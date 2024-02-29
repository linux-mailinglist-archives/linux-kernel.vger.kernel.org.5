Return-Path: <linux-kernel+bounces-87231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6C86D16D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7067228452F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB878268;
	Thu, 29 Feb 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Oph2AG"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3D16062E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230051; cv=none; b=oqs4f2EYvx4zHgmcS5g846coeE3lfnPUbDow9rxault/uf2OkUB4bEH0QNSErgCc/FoNnSJyVSV9jDwccIiCkMCMx/zxjVgrxAaXuP51TEb+PkohH11SWhvkKPTlC37cJUXQj7bjrFb+sUJ5x188RoV3JjihYBcO3+EZvzt93S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230051; c=relaxed/simple;
	bh=1huf7QSRKz4j2YSUX5zuQki23is1yKa09RlMpGRiswM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqLO5IyqS34nYRC1HWalMN4rTBs/pN7gzd1sJdNGcHYErr+R15H2tsnWv5zSRHe4RoCyOAyt6IARRowx3xBBy4iI/pWcbxgaqHwNuz63bL9yq/+cctLB04ojp8ILcWR8cMmbGunNggVWZqU4MWzJOgrFck61tZS73K9fiPRP4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6Oph2AG; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so690091241.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230049; x=1709834849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5aO9FKYCVkPiimp5ZLTW2UUTWK+L37GG2aW8Lkr1OY=;
        b=m6Oph2AGPQjSY0/6bVUTjebk37N7qQU0QvfD/PLV0ms1Ox4vbwTfASmVoZAMkh9sCU
         JKM5rN+lnDDmYkAqJk4Jeh6qoCxWiH9P4zJ1GTQO0g3gYzagHFU8PKOEY513Vu+5mxl4
         f5OLtXp129NOFiv2FPUTmUnglE7TzTdMVlWSOx2CCxjomENj5vLVdUspvZByPLdcHSnV
         bxBovtx25oEdgiZDgHh6Xj1hAFkFUD2mgeHUmfMGlIOaKiHdoibhTVN9qs9Gneok6bSK
         i/74VGsnUB4/f3kI62PyVyiFjJmxf8pJwCfK2B+B+NKZlUkitNpXax7k9tTXGhrlbM6u
         o/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230049; x=1709834849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5aO9FKYCVkPiimp5ZLTW2UUTWK+L37GG2aW8Lkr1OY=;
        b=W497yN/eADai54A7p8dOu9CouPKJ+6VqsjAzFlp25dxUDlcadyhBLkeLrUFdlxYWBM
         fo21IWiqx0fRRi0buYhd1u/Yox7jb/PEjB5YB3r2A3/Ku3mfePhHj+FCIKeQzDpPL3Li
         RggakyWHynNOuIWr2JIBqVVPs7XZQpHGd5LEycsqGAqNAkfHLxRckjg+XhMr000bH9hD
         f+r36SHPin9bWpmv3PPyZscToy7glFW7QxfGAWMNc5yVrVcd2kfCzK4wnlvMsdQ66ZhG
         WRXtDTTmpH02gseQTuk7YImR23MBzhPC86F3Boqt9FKDfRYBtBz4i+tyQCDSoR1ZbYPD
         V+ug==
X-Forwarded-Encrypted: i=1; AJvYcCVihl4XK3y7igTO22Hq11arE/NyLjPAKMSJ3n5/4TQ0z70lJy3eI/zNK8Bq/oBYll8HErbEkKxCZ8wFHi2yHKWB5l5s7EeJQwgQmX4A
X-Gm-Message-State: AOJu0Yx1t5UwXcE8bYyxHq00LoA6N4Wjau1nYOy1IkVyfYXLb1u9x7DN
	IiLCPFd/EH/Jkj8oP7Cm+UOsHgjhKq1/rbpis53a3duk7januHUml+gkUJ4mGfqirolreYvMn3m
	roP3rIsdA+9wBKpCvfcrAZBqPY0TMQVOQk98=
X-Google-Smtp-Source: AGHT+IHm0Q3ixNNu9cmggWgNNsR8ASg0FLqyjz36T/uPBKyzWma2Rx7sIr/qnpSDb4vMRsldinkwtqy7QMI+FvSqI9Y=
X-Received: by 2002:a05:6122:1c0d:b0:4cf:da07:fb01 with SMTP id
 et13-20020a0561221c0d00b004cfda07fb01mr2408795vkb.8.1709230049114; Thu, 29
 Feb 2024 10:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226013208.2389246-1-chao@kernel.org> <20240226013208.2389246-4-chao@kernel.org>
In-Reply-To: <20240226013208.2389246-4-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 29 Feb 2024 10:07:16 -0800
Message-ID: <CACOAw_zMrGQp4oX1x559jrOVkcmj54gS0bHepMhYgFPCQKFcOg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: fix to reset fields for unloaded curseg
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

On Sun, Feb 25, 2024 at 5:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> In f2fs_allocate_data_block(), before skip allocating new segment
> for DATA_PINNED log header, it needs to tag log header as unloaded
> one to avoid skipping logic in locate_dirty_segment() and
> __f2fs_save_inmem_curseg().
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c159b0985596..5e45afd69f3f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3101,12 +3101,16 @@ static int __allocate_new_segment(struct f2fs_sb_=
info *sbi, int type,
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
>         unsigned int old_segno;
>
> +       if (type =3D=3D CURSEG_COLD_DATA_PINNED && !curseg->inited)
> +               goto allocate;
> +
>         if (!force && curseg->inited &&
>             !curseg->next_blkoff &&
>             !get_valid_blocks(sbi, curseg->segno, new_sec) &&
>             !get_ckpt_valid_blocks(sbi, curseg->segno, new_sec))
>                 return 0;
>
> +allocate:
>         old_segno =3D curseg->segno;
>         if (new_curseg(sbi, type, true))
>                 return -EAGAIN;
> @@ -3451,6 +3455,13 @@ static void f2fs_randomize_chunk(struct f2fs_sb_in=
fo *sbi,
>                 get_random_u32_inclusive(1, sbi->max_fragment_hole);
>  }
>
> +static void reset_curseg_fields(struct curseg_info *curseg)
> +{
> +       curseg->inited =3D false;
> +       curseg->segno =3D NULL_SEGNO;
> +       curseg->next_segno =3D 0;
> +}
> +
>  int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page=
,
>                 block_t old_blkaddr, block_t *new_blkaddr,
>                 struct f2fs_summary *sum, int type,
> @@ -3516,8 +3527,10 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *=
sbi, struct page *page,
>          */
>         if (segment_full) {
>                 if (type =3D=3D CURSEG_COLD_DATA_PINNED &&
> -                   !((curseg->segno + 1) % sbi->segs_per_sec))
> +                   !((curseg->segno + 1) % sbi->segs_per_sec)) {
> +                       reset_curseg_fields(curseg);
>                         goto skip_new_segment;
> +               }
>
>                 if (from_gc) {
>                         get_atssr_segment(sbi, type, se->type,
> @@ -4595,9 +4608,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
>                         array[i].seg_type =3D CURSEG_COLD_DATA;
>                 else if (i =3D=3D CURSEG_ALL_DATA_ATGC)
>                         array[i].seg_type =3D CURSEG_COLD_DATA;
> -               array[i].segno =3D NULL_SEGNO;
> -               array[i].next_blkoff =3D 0;
> -               array[i].inited =3D false;
> +               reset_curseg_fields(&array[i]);
>         }
>         return restore_curseg_summaries(sbi);
>  }
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

