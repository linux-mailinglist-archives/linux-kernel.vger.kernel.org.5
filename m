Return-Path: <linux-kernel+bounces-28365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AF82FD55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AB0B22C08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346CE67C55;
	Tue, 16 Jan 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjpZM+s9"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB9747C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705445948; cv=none; b=kqFrJK96D+zYd8fmO0dYA3+4DGRz/wciAgpULsSjzNxhzJRi7ZJXNiEDxPvAnDYvSoGE3zDcMMOX/W8Cjy3wKon6KOJFK00Q1rME+eM34GwIiA/dHyiaGTZzHAAy9W737BdmuuBPW2Nfli4UpFnfAyG8wb/IixEwYxGnvEvrX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705445948; c=relaxed/simple;
	bh=7Wsd/jOTYI/sXKp1MHPfgtk6JEs/FTrRn6lgQvr2ttA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ZagBmchqGUBa/FpRh5JsI4FIn+rP5QtjWchUVaOA3kREqXpz2WWF9JMTieryI+0ssfO5VKhtObJCTtuQKdRPgP4WjfL1Cfez8UWN4CHa47hA8Xw1Fi2PL7PUFcZN9KQOH+MYop4pvu5sUclpP1U8oyzmjb9HNUVehwTDk+tu9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjpZM+s9; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4670a58b118so2143842137.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705445946; x=1706050746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMnHpL+vhTW2DCzeEp+JjD4dTKshtiO76qcppsELxrs=;
        b=FjpZM+s9rvoPC0de2rE+hzo1u73B4gAXjUG5519WvIWEg9w7ps62pyyPpIoJX3IlZD
         ah6wzptL5RQwEgIrpj6sdzwyCadXZm5dXUE7S6YNdIKmXAwwFYC0aV74KlqLkO6TKbhp
         fRJ9CI+yxvKWc5o1HRYx94zYX0YJOYQwqyONf3KadHSvN54F2fVeCcgueS6Rr3B2pryz
         VzUMStwhzMbEMw8Y9vLKQBw90QEE8FQrkpCAX5r3XEmN+1V12aZ4tj0ds2zMinpjWGr0
         A2D4mCs+xhrsgjIbcE1YxNIrc1sgkUcCVxkpTVPNUoECw0+mNq3ksFPuJjDjrcmEnyPv
         oIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705445946; x=1706050746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMnHpL+vhTW2DCzeEp+JjD4dTKshtiO76qcppsELxrs=;
        b=PLj0KalyaYFlj+SajnjFSEcGsTKldIeFDmGXcefp2IOTc77saM2FPyuShz2/ksVbwi
         KstES+dqXKaZ4QCTlYtZ1ALayfSWbpeFK6YDAM5Lj+J0pJxbtge2JKaWU+YpW1xMRHHk
         7rH/KGiQMzUUuFRKeCq4I/lKMprJfePRZCkjzfu+S2qBR/aLSJ74fAJ40oTq9Jzihnzx
         TVUo+x1nNSP9ERNWkn8ErPwY8kWsu75UlCdwwLk6BUMyHKBWero/ZnPRVEkQAH6gwNb7
         i+PtvfQCqsGShZoCWK/to33Qr4ot4ArPfI5z+vmAeWVXcdQ3SKtq3goEdqqXRWDEM+xx
         ZBwg==
X-Gm-Message-State: AOJu0YyPOUKMvWjVdnDZStPfi87ruL/4iP+6e+L64QuDzN7GOWkJ6vJp
	WQvygVRvfNI//+1U8lWWyX00NXdo20JnStiHOTs=
X-Google-Smtp-Source: AGHT+IHWq/tEZLCUuFynVNiAxScW31SKXfD359pdij+7fjmjDwJHwaJMjLO/OhGHOkleKQFY4FtoqimceHAxrZGHfeI=
X-Received: by 2002:a67:fb91:0:b0:467:cd7c:b9f1 with SMTP id
 n17-20020a67fb91000000b00467cd7cb9f1mr4253480vsr.12.1705445945695; Tue, 16
 Jan 2024 14:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116143422.1268-1-qwjhust@gmail.com>
In-Reply-To: <20240116143422.1268-1-qwjhust@gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 16 Jan 2024 14:58:54 -0800
Message-ID: <CACOAw_zP_=w21p__X5hD8Br8tARLHozn5REA5maW8OU2M=AAhg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix max open zone constraints
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:36=E2=80=AFAM Wenjie Qi <qwjhust@gmail.com> wrote=
:
>
> We can get the number of remaining available zone
> resources by subtracting the number of active logs from
> the number of max active zones of zoned devices. We can
> use these available zone resources to reduce the number
> of pending bio when switching zones.
> If max active zones is 0, there is no limit.
>
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> ---
>  fs/f2fs/data.c  | 32 +++++++++++++++++++++++++-------
>  fs/f2fs/f2fs.h  |  2 ++
>  fs/f2fs/super.c | 11 +++++++++++
>  3 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index dce8defdf4c7..0b62ca296074 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,6 +392,19 @@ static void f2fs_zone_write_end_io(struct bio *bio)
>         complete(&io->zone_wait);
>         f2fs_write_end_io(bio);
>  }
> +
> +static void f2fs_zone_write_end_io_nowait(struct bio *bio)
> +{
> +#ifdef CONFIG_F2FS_IOSTAT
> +       struct bio_iostat_ctx *iostat_ctx =3D bio->bi_private;
> +       struct f2fs_sb_info *sbi =3D iostat_ctx->sbi;
> +#else
> +       struct f2fs_sb_info *sbi =3D (struct f2fs_sb_info *)bio->bi_priva=
te;
> +#endif
> +
> +       atomic_inc(&sbi->available_active_zones);
> +       f2fs_write_end_io(bio);
> +}
>  #endif

I don't think this works. Let's assume we start with 2
available_active_zones and 4 active logs.
How about 4 active logs reach at the end of the zones at the same time?

>
>  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
> @@ -1085,14 +1098,19 @@ void f2fs_submit_page_write(struct f2fs_io_info *=
fio)
>                 goto next;
>  out:
>  #ifdef CONFIG_BLK_DEV_ZONED
> -       if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> +       if (f2fs_sb_has_blkzoned(sbi) && sbi->max_active_zones && btype <=
 META &&
>                         is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> -               bio_get(io->bio);
> -               reinit_completion(&io->zone_wait);
> -               io->bi_private =3D io->bio->bi_private;
> -               io->bio->bi_private =3D io;
> -               io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> -               io->zone_pending_bio =3D io->bio;
> +               if (!atomic_add_negative(-1, &sbi->available_active_zones=
)) {
> +                       io->bio->bi_end_io =3D f2fs_zone_write_end_io_now=
ait;
> +               } else {
> +                       atomic_inc(&sbi->available_active_zones);
> +                       bio_get(io->bio);
> +                       reinit_completion(&io->zone_wait);
> +                       io->bi_private =3D io->bio->bi_private;
> +                       io->bio->bi_private =3D io;
> +                       io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> +                       io->zone_pending_bio =3D io->bio;
> +               }
>                 __submit_merged_bio(io);
>         }
>  #endif
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..2aade367ac66 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
>
>  #ifdef CONFIG_BLK_DEV_ZONED
>         unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> +       unsigned int max_active_zones;          /* max zone resources of =
the zoned device */
> +       atomic_t available_active_zones;        /* remaining zone resourc=
es for zone switch */
>  #endif
>
>         /* for node-related operations */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 206d03c82d96..6711283ff187 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2385,6 +2385,12 @@ static int f2fs_remount(struct super_block *sb, in=
t *flags, char *data)
>         if (err)
>                 goto restore_opts;
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (sbi->max_active_zones)
> +               atomic_set(&sbi->available_active_zones,
> +                               sbi->max_active_zones - F2FS_OPTION(sbi).=
active_logs);
> +#endif
> +
>         /* flush outstanding errors before changing fs state */
>         flush_work(&sbi->s_error_work);
>
> @@ -3932,6 +3938,11 @@ static int init_blkz_info(struct f2fs_sb_info *sbi=
, int devi)
>         if (!f2fs_sb_has_blkzoned(sbi))
>                 return 0;
>
> +       sbi->max_active_zones =3D bdev_max_active_zones(bdev);
> +       if (sbi->max_active_zones)
> +               atomic_set(&sbi->available_active_zones,
> +                               sbi->max_active_zones - F2FS_OPTION(sbi).=
active_logs);
> +

Need to make available_active_zones not be negative, right?
Hmm, need to make sure active_logs should be equal or less than
max_active_zones.

>         zone_sectors =3D bdev_zone_sectors(bdev);
>         if (!is_power_of_2(zone_sectors)) {
>                 f2fs_err(sbi, "F2FS does not support non power of 2 zone =
sizes\n");
> --
> 2.34.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

