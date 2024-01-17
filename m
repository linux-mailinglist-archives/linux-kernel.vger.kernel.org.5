Return-Path: <linux-kernel+bounces-28463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAC82FECF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F445289418
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7F749A;
	Wed, 17 Jan 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaK7piCV"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD3747C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458583; cv=none; b=H6D+gCXOBVul4vpxcv9nsf6FsriomMdFCJh/61UQ6V4pVbHJ739EThOSfBF6MldgE8I+DQcnwvNb6kdX54ZUA+NSN0crl4KLvV78po3Cw4Ff6tY2Np2jQ+bauwoWn9o2qnloOr3mIIwDfvUOA832Abd/DkbsR5Q3JRuP6Lddluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458583; c=relaxed/simple;
	bh=WpfOA7nq1MIY0mVJK3yg4V8s81uaJNqDWhp8My8KiqA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=tN0SP1Yf95wt53zsfZ2i/bVHIwqioy16hmjT7DgF2kiRx0T6zQwMh4PXth7/1ywRr4jOLeTzQDVAX2eOdKUrt0Tcu8D0DRIMAfoIIkVYrQTr765M30ORrJ+3iLBcUdlW8evNEzvqG1Fm9WFZavRNKRU/4C8iBPgjYrGDZxQO52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaK7piCV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6817ecd5318so230436d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705458580; x=1706063380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smRdHfB7Q3A8TGLcisVBWK6nCAHDbkQtbFRZgWCGMlc=;
        b=JaK7piCVVBWuKQ/vo87AnkgLFfS4yN7h0FRaGOMNLoGmmd13Qd33WGfOoqXHEJ7nqp
         qC8cln3QrJinC6f6C4vCXnIlirklutzUVC6pKZjfVLPL5qd7oeVipEtxtknshvXlMBmh
         Dv31S7pnyeQa8zlnXCQKAHeK6a6bX1ACPh/LooaqsMrJ5f4i4tovPBXvlvtONj8Zlr6T
         OUhaeZo41j25ruAIFZwFYgSVL7ZZXHWnU/oCmHT9MgeDXy/3CcSg9ODZqnk7LOtuGYpO
         NP60txZrXjOh1CiFiwaLxUlOCIM8ic9nr7RIFWO/a2FAN+wxHAIjkg42XNKmKJU4gmao
         VJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705458580; x=1706063380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smRdHfB7Q3A8TGLcisVBWK6nCAHDbkQtbFRZgWCGMlc=;
        b=XTw/CgV2u+AS2msqAZQv+GFqrDReyggDHDkqIgJLFy3Xwk1haT/llwU3HDeygSMkmM
         lbidDMv9VkAMV36Ps4Ou2neV3wHJLTrzhKHknkeA7QpBnmXdzOCJphq3tPaxgF2vyycz
         w5A7iwGKC3jLu6CFvLqDKxWOLtHgElQHdcpj3ccpQ/0rz5tTeI8Su1kLTyyytelywSeh
         B9I/QfVVJ6bD388CI4EmRDgrDky/4/CaTehyFA7omudUifQSu9u0Te1Hj0yPuIpL0wuP
         I3v1ZzYThnxjhXpSOk2jBZ7XU1RVH68x+QeF5STsjsJdjMFkwaQgRNwnksJLuLfd5C01
         nFDA==
X-Gm-Message-State: AOJu0YxguyCoC11iA26/vPPM9aCfw/J0GEZJu5wMCTxC5/pKsneaTO6U
	qM6E7VHFV1gtzJ1iPYXCos6XvbYFpTNuqUyZ8jc=
X-Google-Smtp-Source: AGHT+IEpXdusZs4m7FiiTWT4q76KXWXL0r/pxA/NlMER/j2kqz+fklH6n0IKXbcIf+Ma+GBzZw4NTyUwMERLDjNH5Oc=
X-Received: by 2002:a05:622a:164d:b0:42a:a08:86ec with SMTP id
 y13-20020a05622a164d00b0042a0a0886ecmr1696343qtj.121.1705458580379; Tue, 16
 Jan 2024 18:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116143422.1268-1-qwjhust@gmail.com> <CACOAw_zP_=w21p__X5hD8Br8tARLHozn5REA5maW8OU2M=AAhg@mail.gmail.com>
 <CACOAw_wzP2emXE_Os-eutBp9L3QRCwsDWg+qt-pQEHto_BvFUw@mail.gmail.com>
In-Reply-To: <CACOAw_wzP2emXE_Os-eutBp9L3QRCwsDWg+qt-pQEHto_BvFUw@mail.gmail.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Wed, 17 Jan 2024 10:29:30 +0800
Message-ID: <CAGFpFsTJAJXjrkRT2n9oFHCMW-V3BgVmouR_8-GD4ZqxC2n_nw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix max open zone constraints
To: Daeho Jeong <daeho43@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do you mean we down the semaphore when we write the first block of the zone
and up it when the last bio of the zone finishes? That seems a bit more con=
cise.

On Wed, Jan 17, 2024 at 7:12=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> On Tue, Jan 16, 2024 at 2:58=E2=80=AFPM Daeho Jeong <daeho43@gmail.com> w=
rote:
> >
> > On Tue, Jan 16, 2024 at 6:36=E2=80=AFAM Wenjie Qi <qwjhust@gmail.com> w=
rote:
> > >
> > > We can get the number of remaining available zone
> > > resources by subtracting the number of active logs from
> > > the number of max active zones of zoned devices. We can
> > > use these available zone resources to reduce the number
> > > of pending bio when switching zones.
> > > If max active zones is 0, there is no limit.
> > >
> > > Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> > > ---
> > >  fs/f2fs/data.c  | 32 +++++++++++++++++++++++++-------
> > >  fs/f2fs/f2fs.h  |  2 ++
> > >  fs/f2fs/super.c | 11 +++++++++++
> > >  3 files changed, 38 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index dce8defdf4c7..0b62ca296074 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -392,6 +392,19 @@ static void f2fs_zone_write_end_io(struct bio *b=
io)
> > >         complete(&io->zone_wait);
> > >         f2fs_write_end_io(bio);
> > >  }
> > > +
> > > +static void f2fs_zone_write_end_io_nowait(struct bio *bio)
> > > +{
> > > +#ifdef CONFIG_F2FS_IOSTAT
> > > +       struct bio_iostat_ctx *iostat_ctx =3D bio->bi_private;
> > > +       struct f2fs_sb_info *sbi =3D iostat_ctx->sbi;
> > > +#else
> > > +       struct f2fs_sb_info *sbi =3D (struct f2fs_sb_info *)bio->bi_p=
rivate;
> > > +#endif
> > > +
> > > +       atomic_inc(&sbi->available_active_zones);
> > > +       f2fs_write_end_io(bio);
> > > +}
> > >  #endif
> >
> > I don't think this works. Let's assume we start with 2
> > available_active_zones and 4 active logs.
> > How about 4 active logs reach at the end of the zones at the same time?
>
> Sorry, I was confused. It would work. However, it might be a little clums=
y.
> How about using a data structure like a counting semaphore?
> We can decrease it as we open a zone and increase it as we close a zone.
>
> >
> > >
> > >  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
> > > @@ -1085,14 +1098,19 @@ void f2fs_submit_page_write(struct f2fs_io_in=
fo *fio)
> > >                 goto next;
> > >  out:
> > >  #ifdef CONFIG_BLK_DEV_ZONED
> > > -       if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> > > +       if (f2fs_sb_has_blkzoned(sbi) && sbi->max_active_zones && bty=
pe < META &&
> > >                         is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> > > -               bio_get(io->bio);
> > > -               reinit_completion(&io->zone_wait);
> > > -               io->bi_private =3D io->bio->bi_private;
> > > -               io->bio->bi_private =3D io;
> > > -               io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> > > -               io->zone_pending_bio =3D io->bio;
> > > +               if (!atomic_add_negative(-1, &sbi->available_active_z=
ones)) {
> > > +                       io->bio->bi_end_io =3D f2fs_zone_write_end_io=
_nowait;
> > > +               } else {
> > > +                       atomic_inc(&sbi->available_active_zones);
> > > +                       bio_get(io->bio);
> > > +                       reinit_completion(&io->zone_wait);
> > > +                       io->bi_private =3D io->bio->bi_private;
> > > +                       io->bio->bi_private =3D io;
> > > +                       io->bio->bi_end_io =3D f2fs_zone_write_end_io=
;
> > > +                       io->zone_pending_bio =3D io->bio;
> > > +               }
> > >                 __submit_merged_bio(io);
> > >         }
> > >  #endif
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 65294e3b0bef..2aade367ac66 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
> > >
> > >  #ifdef CONFIG_BLK_DEV_ZONED
> > >         unsigned int blocks_per_blkz;           /* F2FS blocks per zo=
ne */
> > > +       unsigned int max_active_zones;          /* max zone resources=
 of the zoned device */
> > > +       atomic_t available_active_zones;        /* remaining zone res=
ources for zone switch */
> > >  #endif
> > >
> > >         /* for node-related operations */
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 206d03c82d96..6711283ff187 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -2385,6 +2385,12 @@ static int f2fs_remount(struct super_block *sb=
, int *flags, char *data)
> > >         if (err)
> > >                 goto restore_opts;
> > >
> > > +#ifdef CONFIG_BLK_DEV_ZONED
> > > +       if (sbi->max_active_zones)
> > > +               atomic_set(&sbi->available_active_zones,
> > > +                               sbi->max_active_zones - F2FS_OPTION(s=
bi).active_logs);
> > > +#endif
> > > +
> > >         /* flush outstanding errors before changing fs state */
> > >         flush_work(&sbi->s_error_work);
> > >
> > > @@ -3932,6 +3938,11 @@ static int init_blkz_info(struct f2fs_sb_info =
*sbi, int devi)
> > >         if (!f2fs_sb_has_blkzoned(sbi))
> > >                 return 0;
> > >
> > > +       sbi->max_active_zones =3D bdev_max_active_zones(bdev);
> > > +       if (sbi->max_active_zones)
> > > +               atomic_set(&sbi->available_active_zones,
> > > +                               sbi->max_active_zones - F2FS_OPTION(s=
bi).active_logs);
> > > +
> >
> > Need to make available_active_zones not be negative, right?
> > Hmm, need to make sure active_logs should be equal or less than
> > max_active_zones.
> >
> > >         zone_sectors =3D bdev_zone_sectors(bdev);
> > >         if (!is_power_of_2(zone_sectors)) {
> > >                 f2fs_err(sbi, "F2FS does not support non power of 2 z=
one sizes\n");
> > > --
> > > 2.34.1
> > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

