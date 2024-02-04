Return-Path: <linux-kernel+bounces-51491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A164848BD6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27B1283AFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC79479;
	Sun,  4 Feb 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkQXPp+h"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABC6FC5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031769; cv=none; b=U7W9i2W7urk8NmvJlvFpt/DPTLvLcb4fdh18ujdCvfykCrvWTXjEsI1xM8pS1BD1fsK3mrr43kj5Gaa90ZBfEi8oAz645Tig+GwmyZDR0vmXSZPbsQBDAtlCr93FCFiLsmX6is/TB6p55+24VMkzQgRssWihAmMyfGtB/PxyIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031769; c=relaxed/simple;
	bh=8ob69iEUZbDr69aMdpqXAmN6AEUfbl4I1t5MkI+bc4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiD1zxlQwO0GiLW45648Xx7W3byMsfK1PMDJGKPXafQPWpLrzuVDZzmC3cPJT8b5EpVs0wYALTdXY7qxA0rGg2eXkAqjjEcWr/vgPMizdS1xAjbNCu+JCr/6Jadu2rqdado7D+iMjoJPUIO9Q1XbmfaQJSjWV9vcZcFgWf1j7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkQXPp+h; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a9199cfd2so19859161cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 23:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707031767; x=1707636567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVYWotuzszhb5Bt71MvuDcibA+w+/C5yZudwo/s/w7o=;
        b=KkQXPp+h3kBLOfYQM0Xmtdp2yIszf+UkoHt+L9eBKdflSdcn9y/OzqFtvBgw7Qr3L5
         VxUxHnVk0gBt/+oqlmVzq1ePOWF5M1AiuGwJu2fP85pk6M3pOAt0SsuPcr93L5yb6ub/
         TmXyrUKl6ZX1LD+6ml0ZXuQl+z6Tp1xopPQISeCxGCgIw37tmFNFJ6aC9i95dAV8fH0h
         Er+qoIkl18RX3JjKmuLUgevgMmGlNm+FGttgXCs0o3xPCgzh8XWDNDUN/xExCaVMTv01
         9Y1LF/7r0At46OHT13LqrdiKK7a71I/R3HcMsT0sec3UfSNXaRtbAkz1nN4TXDKa5vXn
         2vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707031767; x=1707636567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVYWotuzszhb5Bt71MvuDcibA+w+/C5yZudwo/s/w7o=;
        b=KYMyFyCewYjrwXAAZ/Z1wSSXPaYPy7hAhRTiYJE/sqF60DnCobtDmLuYSdqYFkMXJW
         5+1AuWdB6iUH+AEVZg7/QEEjo01D9CB63kFXYbsp/1RGhV1BSXKgOeT7Cdxg9ZUpLJ20
         JKVrLS80wknE8bL8e7fRhDAOnkDYQC2iT2v5ILTaPVBthQmWnoqUaDfCFh0zTUyTU/lD
         OWmc6URcOJq6DHqMCsp/NbEUxiQAJ5LkSr936aQNCZLHdvLvbLHLK5i7imHoO+2jois7
         bv4yoUrHHuONRII4N+puvUwUtIgcT4/FYoifkVodfhg+QDH5C1mlFivD5z5xYEWEjNru
         Sd4A==
X-Gm-Message-State: AOJu0YyiOUYQLl3HFH0L9gre5typ1eEwp8DydyZigyNfrH9IvDgXdodf
	tCnoF2THpeq2FJXSx1A5QJ1zz+aYJi5/n/FnGdFvKbtOd3754YeNRWyLodAM7Biz/le5wqpPrao
	kJeBp5fco9mkVLfq/8M7WpyePXEo=
X-Google-Smtp-Source: AGHT+IF94BpCHtL7/7nrD+aXNLLAGT63Sx9pIncX86mc0qCFOOpcSOHfJ3sK6l86R3PvYoYSRGqEI1m4Pbnhx0upZpQ=
X-Received: by 2002:ac8:46c6:0:b0:42b:eaa1:b28c with SMTP id
 h6-20020ac846c6000000b0042beaa1b28cmr2776685qto.43.1707031766715; Sat, 03 Feb
 2024 23:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204031022.1189-1-qwjhust@gmail.com> <e6cffb6e-3228-415d-890c-76fe0a9ac08b@oppo.com>
In-Reply-To: <e6cffb6e-3228-415d-890c-76fe0a9ac08b@oppo.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Sun, 4 Feb 2024 15:29:16 +0800
Message-ID: <CAGFpFsQevfTzirUyn7=5UOwrbwWo3SKnS_Sa7TQWXi3O6KSzMw@mail.gmail.com>
Subject: Re: [PATCH v5] f2fs: fix zoned block device information initialization
To: Yongpeng Yang <yangyongpeng1@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 12:53=E2=80=AFPM Yongpeng Yang <yangyongpeng1@oppo.c=
om> wrote:
>
> 1. f2fs_scan_devices call init_blkz_info for each zoned device, is it
> reasonable that every device need to have 6 open zones at least?

Because it is possible for all active logs to write to the same zoned
device at the same time,
each zoned device must have at least the same number of open zone
resources as active logs.

> 2. we should add all open_zones of every zoned device to
> sbi->max_open_zones, sbi->max_open_zones will be UINT_MAX or accumulated
> open_zones. Is it more reasonable?

I don't think that's right.
sbi->max_open_zone is the number of resources that are the least of
all zoned devices.

Thanks.

>
>
> On 2/4/2024 11:10 AM, Wenjie Qi wrote:
> > If the max open zones of zoned devices are less than
> > the active logs of F2FS, the device may error due to
> > insufficient zone resources when multiple active logs
> > are being written at the same time.
> >
> > Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> > ---
> >   fs/f2fs/f2fs.h  |  1 +
> >   fs/f2fs/super.c | 24 ++++++++++++++++++++++++
> >   2 files changed, 25 insertions(+)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 543898482f8b..161107f2d3bd 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
> >
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >       unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> > +     unsigned int max_open_zones;            /* max open zone resource=
s of the zoned device */
> >   #endif
> >
> >       /* for node-related operations */
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 1b718bebfaa1..c6709efbc294 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, =
int *flags, char *data)
> >       if (err)
> >               goto restore_opts;
> >
> > +#ifdef CONFIG_BLK_DEV_ZONED
> > +     if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> > +             f2fs_err(sbi,
> > +                     "zoned: max open zones %u is too small, need at l=
east %u open zones",
> > +                              sbi->max_open_zones, F2FS_OPTION(sbi).ac=
tive_logs);
> > +             err =3D -EINVAL;
> > +             goto restore_opts;
> > +     }
> > +#endif
> > +
> >       /* flush outstanding errors before changing fs state */
> >       flush_work(&sbi->s_error_work);
> >
> > @@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info *=
sbi, int devi)
> >       sector_t nr_sectors =3D bdev_nr_sectors(bdev);
> >       struct f2fs_report_zones_args rep_zone_arg;
> >       u64 zone_sectors;
> > +     unsigned int max_open_zones;
> >       int ret;
> >
> >       if (!f2fs_sb_has_blkzoned(sbi))
> >               return 0;
> >
> > +     max_open_zones =3D bdev_max_open_zones(bdev);
> > +     if (max_open_zones && (max_open_zones < sbi->max_open_zones))
> > +             sbi->max_open_zones =3D max_open_zones;
> > +     if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> > +             f2fs_err(sbi,
> > +                     "zoned: max open zones %u is too small, need at l=
east %u open zones",
> > +                              sbi->max_open_zones, F2FS_OPTION(sbi).ac=
tive_logs);
> > +             return -EINVAL;
> > +     }
> > +
> >       zone_sectors =3D bdev_zone_sectors(bdev);
> >       if (!is_power_of_2(zone_sectors)) {
> >               f2fs_err(sbi, "F2FS does not support non power of 2 zone =
sizes\n");
> > @@ -4253,6 +4274,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info =
*sbi)
> >
> >       logical_blksize =3D bdev_logical_block_size(sbi->sb->s_

