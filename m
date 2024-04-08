Return-Path: <linux-kernel+bounces-135790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0027D89CB4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F03B283530
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09E91442F6;
	Mon,  8 Apr 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am3NTPIK"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D61E489
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598993; cv=none; b=DZ1KLvmvxCmqj9uSc/ksoyy6aeKgIUrSBcWkSKelYm96V82C6Xg1wGkY9dcRBr7bp+GK2JQ85aQ3+42mNR1+4RIXC+nLbXCxo12y5AM39cYTXC3tC2dCm2zqAkNbLmbbev5A8w7Kj9FlHNs1p6pxfOH0jGJlv9YM45wtg2F/H5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598993; c=relaxed/simple;
	bh=AjIP/aIjADY0dHfSZONVNpKc78h8ru+dlReyZG+LToY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st4oTdV8ga8MbOcPBjHMYxdJVRmsXm1Pr+bsZgsNWkj9xN8QuZc4s7clxRtJ4WTh7q7fKmLtU995Rvm/vXT4u+RyLgUdyZmGDKJEkU5auVVE0T2zSCUH8UTQcV8kf2BHDoBEGNrzIuyhKedZn1ZbBAS1hraHZz3z5aiDBPYyT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am3NTPIK; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479c9c2d2b0so1399534137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598989; x=1713203789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/dc4+cjV1nRvMlJvOrHmfnnqBQu1vw9EU5dHurwIFw=;
        b=am3NTPIKO4olo0X1UtDGl5BwqUMVoFc2kVtIrZnm1w1uYzqih31DEAnfjBDbjtW/Ig
         hEbRaxxWZh8CLh2p1U1WUawAQwzrjQo03C2+oEHx2NnSTVPNFDXunDd+p9eW1jayFVmx
         ZU/OZPgDg7qAqcHtJ2bmmyvRUHRjfbSJQHWwH/9SK8fMrA3FWoEqNWV9jK/G9GVCU8OD
         zOLmemnPpVvS/W3OMVwEuV0qssmbw8IFDCZWYanNzvS+X5vwSJJiBai31szJAFU0ew6C
         IXB+Zr9uvqczdxbfNw/cnXZygtfgBPJdgRLbUJfJDNsOPXPPy91C3Nr+7L+ZRZAYZ/XM
         qRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598989; x=1713203789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/dc4+cjV1nRvMlJvOrHmfnnqBQu1vw9EU5dHurwIFw=;
        b=SFSKyvHVOAB32S28mXzGX+DmzDd/h3EjgHgzv/0e7mai7G4idWQ59gFzXxRg++Dicf
         wmJmNASNpi5Yi1F34SVLukjwAdJNvf0/476EBMjH4Kh/Vh+qlTpSgvCYAa7gC9ogMFhI
         zuuCDWkTnSb1Ps4vsBUjaUZWLnULg+LWwnrNSjd7RyfZn7auRP6q5X0yayvh8/RIHj8C
         M/AicF8PA2M6ygfZrouPAWsGL+zozm23inXZHr7ESBVVZ8viYsVs4tz3v9eO/8N4I/MG
         52nTHF5Uyljhp+apX0RJDwTXTvtXwJFZDbgj25abHP6qPeM5joZU7HlH/rFSifgZsFnQ
         wrhw==
X-Forwarded-Encrypted: i=1; AJvYcCWC+TRTXwC0ohLciXGguAPadPTPl0S9isdOX40glBYsgsbK9o5t7Ys/H10cZml3NenElKhyJhMZcGFWzeK5+8tC6JQTNrRqafPLuPsk
X-Gm-Message-State: AOJu0Yx9+hdq/J0tVAcVyNNgDqdc5S7qzu6bQPUjKF2GreUSxeMn/5jV
	2g7bGeLBNxaAjvSK0l/F0E1gYY7wJjP5s7VzlbOS6puqCO4h8dBNld9vxB8oGH4MTq5V8hSCUqh
	yfsH+kWZpKw7zWzl4n5CeD3oIZ88=
X-Google-Smtp-Source: AGHT+IHVRMa1nTTtQPmvzVkbDq9045lHxqXTp1ABAB/zCyvK7s/lmgHi/WgP4n6yFdh9wtZ6d/RkmRWNaMwa5rwXVec=
X-Received: by 2002:a05:6102:c51:b0:47a:a6c:9e61 with SMTP id
 y17-20020a0561020c5100b0047a0a6c9e61mr2424671vss.16.1712598989527; Mon, 08
 Apr 2024 10:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407072123.3484300-1-chao@kernel.org>
In-Reply-To: <20240407072123.3484300-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 8 Apr 2024 10:56:18 -0700
Message-ID: <CACOAw_w2LnR4uE+psU_eq5M+PQVyOaC1iDLzGVq8Mbvx0x=ZSg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: fix zoned block device information initialization
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Wenjie Qi <qwjhust@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 12:23=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> From: Wenjie Qi <qwjhust@gmail.com>
>
> If the max open zones of zoned devices are less than
> the active logs of F2FS, the device may error due to
> insufficient zone resources when multiple active logs
> are being written at the same time.
>
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v7:
> - check f2fs_sb_has_blkzoned() instead of multiple-device condition
> in f2fs_remount().
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/super.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0550929dc6e5..694f8a52cb84 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1559,6 +1559,7 @@ struct f2fs_sb_info {
>
>  #ifdef CONFIG_BLK_DEV_ZONED
>         unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> +       unsigned int max_open_zones;            /* max open zone resource=
s of the zoned device */
>  #endif
>
>         /* for node-related operations */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ba6288e870c5..fdf358c7f808 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2324,6 +2324,17 @@ static int f2fs_remount(struct super_block *sb, in=
t *flags, char *data)
>         if (err)
>                 goto restore_opts;
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (f2fs_sb_has_blkzoned(sbi) &&
> +               sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +               f2fs_err(sbi,
> +                       "zoned: max open zones %u is too small, need at l=
east %u open zones",
> +                                sbi->max_open_zones, F2FS_OPTION(sbi).ac=
tive_logs);
> +               err =3D -EINVAL;
> +               goto restore_opts;
> +       }
> +#endif
> +
>         /* flush outstanding errors before changing fs state */
>         flush_work(&sbi->s_error_work);
>
> @@ -3866,11 +3877,24 @@ static int init_blkz_info(struct f2fs_sb_info *sb=
i, int devi)
>         sector_t nr_sectors =3D bdev_nr_sectors(bdev);
>         struct f2fs_report_zones_args rep_zone_arg;
>         u64 zone_sectors;
> +       unsigned int max_open_zones;
>         int ret;
>
>         if (!f2fs_sb_has_blkzoned(sbi))
>                 return 0;
>
> +       if (bdev_is_zoned(FDEV(devi).bdev)) {
> +               max_open_zones =3D bdev_max_open_zones(bdev);
> +               if (max_open_zones && (max_open_zones < sbi->max_open_zon=
es))
> +                       sbi->max_open_zones =3D max_open_zones;
> +               if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +                       f2fs_err(sbi,
> +                               "zoned: max open zones %u is too small, n=
eed at least %u open zones",
> +                               sbi->max_open_zones, F2FS_OPTION(sbi).act=
ive_logs);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         zone_sectors =3D bdev_zone_sectors(bdev);
>         if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=3D
>                                 SECTOR_TO_BLOCK(zone_sectors))
> @@ -4191,6 +4215,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *s=
bi)
>
>         logical_blksize =3D bdev_logical_block_size(sbi->sb->s_bdev);
>         sbi->aligned_blksize =3D true;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       sbi->max_open_zones =3D UINT_MAX;
> +#endif
>
>         for (i =3D 0; i < max_devices; i++) {
>                 if (i =3D=3D 0)
> --
> 2.40.1
>
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>


>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

