Return-Path: <linux-kernel+bounces-41008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CDF83E990
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD24B28D3A1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30AB1170A;
	Sat, 27 Jan 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2qhYgE2"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6D11185
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321293; cv=none; b=EWabYmyp84/EBX+BSVxE31pJFjr9dCCxdvLxCK3spJs3eWmZf53g1xOQKfyOAGDOtM98sbp9t1WPrfYMrPUKm8j2cbEq8Ydp+f26uSMyKJBZik9ELX58HM8QBj5ams0baYT3iR3iOAAZXfGZWLoS3AjgXiyXfrZIyfJ25T9CfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321293; c=relaxed/simple;
	bh=fD49DlnyYMk9lw7QpaVl1s5GRZQ7VJwmIhtXiK2PBpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3p8/S+bUAKvpWPKNtTSUfUARb+4irlkT9Y8NgIMOcrWVSsOc5yAfZG9oeUkr/AJR1kkf3Dh8zkt6MH62VwF9/cqSZv36nrHQb3pac8lexA25w9zvtesEAk5wbV4WOJhKuaqKStfDXkMsL6VXBbLaUh134vkvqZNE+dn0WTx55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2qhYgE2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42989a64713so7072911cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706321290; x=1706926090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xNPHrDRbEwgseEcXWiWvKYi6gCDcCUo7j4+QwPqXQg=;
        b=A2qhYgE21g4lDnH1uUoPWbbEx2KDDwxImSUrngNIgrgdTJPpRmbikERGPIoQ/OcfB6
         qg0KYgB3sx/r4/JHNB5U4ja4B5pF6MXTJsAPRaG7l5eYQ9Wy1NNJXMz4w3QagpJe+yT/
         xVrJ/iVlubjGHE58n9/yaGCGgdpDsdAJTviRX9SQezU6TwN9menxdHVSeynXNAfLsNUq
         p63OQXCCJLj1uWfPSX0lfeRiHNqrjPmCAvge2sHbUcki4d/Yk5dWzeMpGfLXuJWLoNjB
         1R2JPT4N7nIECpE8nLS/Fz8DaFZhf9/ex3PaBxsGJN88EbXT88nVQQSvKjFgG8kEmwlf
         N9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706321290; x=1706926090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xNPHrDRbEwgseEcXWiWvKYi6gCDcCUo7j4+QwPqXQg=;
        b=Qc/T0/CnoUxO1xjBthxEo3AjTEykQHfqvIRdU37HgvrXunR6xV8ZR0ktxmQEX+bCT7
         b0MWFrC6MsjOoGathKskIlJhhiKKrI4BkSf+IOtW719cYHXixBA6nl+aK6XTJqyDNzSg
         SZXfd9R7lfZ5YDoVqk1AcNkdxtaidYmIYP2hHtqcg4rVKEP5Icr95LBdCitmJtI/Sgcj
         uXhYL/ZCpF8oNnffF4LD0fZbqEY6x3l1YslOVHkDDhJw4hcebhGHjXInhdWwKVahS/vC
         kwwIdEEW8Ztmu6O5ZvlAl0iBzteOHKJC8DVg5B6nmq5sds9G1x9gwZkkQB/IZ+EyXsaC
         Wfbg==
X-Gm-Message-State: AOJu0Yyu6WNSrixJKk38QF9eelKp5H5p0FK0/xK8LNrZLbp5lp+Ck6MM
	CNmBnXDHQrbs2JOQPutVzi0BINPB9a5y5pSDM3WURb9N7mCQWlYqgSn1ymFuU0p3fJ9ZLv2Zfmp
	aF67Ui8tbC1ytW9hCovkuN08ljr0=
X-Google-Smtp-Source: AGHT+IHSjxcCejNgIcI9TPSg2zRU5MRffZ1qU+PozDV0/9CBYwez4Z5MAq/kiCKGrWU/4d32ygrLFUjHRNxbabGZwYs=
X-Received: by 2002:a05:622a:1192:b0:42a:84a3:2d6b with SMTP id
 m18-20020a05622a119200b0042a84a32d6bmr1108950qtk.61.1706321289852; Fri, 26
 Jan 2024 18:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109035804.642-1-qwjhust@gmail.com> <ZbQ7XmFpAMSXslkU@google.com>
In-Reply-To: <ZbQ7XmFpAMSXslkU@google.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Sat, 27 Jan 2024 10:07:59 +0800
Message-ID: <CAGFpFsQ8j4H8hym8FkdbF1U_k-ns36kF=HQ0LWtnTAj8z_CuAg@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: fix max open zone constraints
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, guoweichao@oppo.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jaegeuk,

Thank you for your suggestions. I have split this patch into three patches.
Here is a link to the latest email list.
The [1] of these links is the patch for the third point above.

[1] https://lore.kernel.org/linux-f2fs-devel/CAGFpFsT6XyTNPRxrTg+=3DF_eQ_-c=
ryhdYd-k7rXxy1oJn4F4oLA@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-f2fs-devel/CAGFpFsTJAJXjrkRT2n9oFHCMW-V3B=
gVmouR_8-GD4ZqxC2n_nw@mail.gmail.com/T/#t
[3] https://lore.kernel.org/linux-f2fs-devel/cedb4875-5795-4789-a010-a9c66f=
a61707@oppo.com/T/#t


On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 01/09, Wenjie wrote:
> > From: Wenjie Qi <qwjhust@gmail.com>
> >
> > 1. If the max active zones of zoned devices are less than
> > the active logs of F2FS, the device may error due to
> > insufficient zone resources when multiple active logs are
> > being written at the same time.
> >
> > 2. We can get the number of remaining available zone
> > resources by subtracting the number of active logs from
> > the number of max active zones of zoned devices.  We can
> > use these available zone resources to reduce the number
> > of pending bio when switching zones.
> >
> > 3. The original code for determining zone end was
> > after "out":, which would have missed some fio's
> > where is_end_zone_blkaddr(sbi, fio->new_blkaddr)
> > was true. I've moved this code before "skip:" to
> > make sure it's done for each fio.
>
> Could you please keep #3 as a separate patch?
>
> >
> > Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> > ---
> >  fs/f2fs/data.c  | 38 ++++++++++++++++++++++++++++----------
> >  fs/f2fs/f2fs.h  |  2 ++
> >  fs/f2fs/super.c |  9 +++++++++
> >  3 files changed, 39 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index dce8defdf4c7..6b11364e94b8 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -392,6 +392,19 @@ static void f2fs_zone_write_end_io(struct bio *bio=
)
> >       complete(&io->zone_wait);
> >       f2fs_write_end_io(bio);
> >  }
> > +
> > +static void f2fs_zone_write_end_io_nowait(struct bio *bio)
> > +{
> > +#ifdef CONFIG_F2FS_IOSTAT
> > +     struct bio_iostat_ctx *iostat_ctx =3D bio->bi_private;
> > +     struct f2fs_sb_info *sbi =3D iostat_ctx->sbi;
> > +#else
> > +     struct f2fs_sb_info *sbi =3D (struct f2fs_sb_info *)bio->bi_priva=
te;
> > +#endif
> > +
> > +     atomic_inc(&sbi->available_active_zones);
> > +     f2fs_write_end_io(bio);
> > +}
> >  #endif
> >
> >  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
> > @@ -1080,22 +1093,27 @@ void f2fs_submit_page_write(struct f2fs_io_info=
 *fio)
> >       io->last_block_in_bio =3D fio->new_blkaddr;
> >
> >       trace_f2fs_submit_page_write(fio->page, fio);
> > -skip:
> > -     if (fio->in_list)
> > -             goto next;
> > -out:
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >       if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> >                       is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> > -             bio_get(io->bio);
> > -             reinit_completion(&io->zone_wait);
> > -             io->bi_private =3D io->bio->bi_private;
> > -             io->bio->bi_private =3D io;
> > -             io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> > -             io->zone_pending_bio =3D io->bio;
> > +             if (!atomic_add_negative(-1, &sbi->available_active_zones=
)) {
> > +                     io->bio->bi_end_io =3D f2fs_zone_write_end_io_now=
ait;
> > +             } else {
> > +                     atomic_inc(&sbi->available_active_zones);
> > +                     bio_get(io->bio);
> > +                     reinit_completion(&io->zone_wait);
> > +                     io->bi_private =3D io->bio->bi_private;
> > +                     io->bio->bi_private =3D io;
> > +                     io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> > +                     io->zone_pending_bio =3D io->bio;
> > +             }
> >               __submit_merged_bio(io);
> >       }
> >  #endif
> > +skip:
> > +     if (fio->in_list)
> > +             goto next;
> > +out:
> >       if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
> >                               !f2fs_is_checkpoint_ready(sbi))
> >               __submit_merged_bio(io);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 65294e3b0bef..1b1833e1d10e 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
> >
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >       unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> > +     unsigned int max_active_zones;          /* max zone resources of =
the zoned device */
> > +     atomic_t available_active_zones;                /* remaining zone=
 resources */
> >  #endif
> >
> >       /* for node-related operations */
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 206d03c82d96..c79919425d63 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -3932,6 +3932,15 @@ static int init_blkz_info(struct f2fs_sb_info *s=
bi, int devi)
> >       if (!f2fs_sb_has_blkzoned(sbi))
> >               return 0;
> >
> > +     sbi->max_active_zones =3D bdev_max_active_zones(bdev);
> > +     if (sbi->max_active_zones && (sbi->max_active_zones < F2FS_OPTION=
(sbi).active_logs)) {
> > +             f2fs_err(sbi,
> > +                     "zoned: max active zones %u is too small, need at=
 least %u active zones",
> > +                              sbi->max_active_zones, F2FS_OPTION(sbi).=
active_logs);
> > +             return -EINVAL;
> > +     }
> > +     atomic_set(&sbi->available_active_zones, sbi->max_active_zones - =
F2FS_OPTION(sbi).active_logs);
> > +
> >       zone_sectors =3D bdev_zone_sectors(bdev);
> >       if (!is_power_of_2(zone_sectors)) {
> >               f2fs_err(sbi, "F2FS does not support non power of 2 zone =
sizes\n");
> > --
> > 2.34.1

