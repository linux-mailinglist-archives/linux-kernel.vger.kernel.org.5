Return-Path: <linux-kernel+bounces-4663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D42818063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB361C21898
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A983747E;
	Tue, 19 Dec 2023 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejf3EksZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77E5233
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso4854349a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702958964; x=1703563764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9zHDHO13PjWbb8KHC4s3wKUUXJJ6KzWnl5bkPnl1h8=;
        b=Ejf3EksZL82nncjJbA9emU3qmirm7l+HHjzlwSutnNsrW6NiG6zeiDeQZkEU8RsrCQ
         IJd42ewXyr/yw/LR8qY4Dvdc8+8zAK67pt9PWBhvvgmTyeiNqSZyVk2ATROu0h3x+Gjc
         TS7a0qiUXa/VLrkDp103aRrSkff+qulxK5W9lY7/Cqe+ZxCrIfMLBhQUIqvfdoR/XVh0
         RNYNNVy5z6DfcTA9fXZ6XwHUbC2BjvHrWjHE6XRTg0i5WxkosSdSNDaUfjBYzFXeLTGm
         vqXJfdK0FB3yb7SHCqCMJb6ys8zM8hooHLhyrF4hkjkJ8SWK8eGqfcqhv1bqdx6jg1Ei
         YFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702958964; x=1703563764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9zHDHO13PjWbb8KHC4s3wKUUXJJ6KzWnl5bkPnl1h8=;
        b=HpojXVyt/x2J2xKpfHideUDtHEfz5vb0t8oe328RkyKxnUahZZWkoDp5RHhKfaqg75
         7ROuYcrcuVh2xjtvTOAF+aXl7nVqxKwo8J7R/pdHAdReNJy/BhLyzYSXjVyz5yDxFt6T
         Wc7hgJY2TqIhdRAq6OEoi9WOEtq+BQpuombFTLbQOpEki6MDCO+IJt+e4aZUfk0VLEfK
         6UZhfo9eaB0j/9bfx75kFH0Mtssn7u/yIHhRuQ6w8ZDsCtVqtmRJH02OtMN0pASUdUI0
         BOYjAKpOsIEnTKsUInsGPjfgGT0+oZkzdVjXExre892tOW5UoG8fNgruErqIYrB+GUm5
         +VIQ==
X-Gm-Message-State: AOJu0Yw8eLQrWy9VfUA5nezwr2P64YoroENsV1uF9jNZ4LgGGcgVgr1h
	RK121hNobrqCOshZQ2zX4nDzQVzhDb2ll8XrO38=
X-Google-Smtp-Source: AGHT+IFiuuV9fgrhO2LvtNhi2Ggp6UadwZA3xMpQGF68AkzGPueMilXlEIPqu4wbZ1OOOb1hUrKAtIVsba4Jk85BU4o=
X-Received: by 2002:a50:d69b:0:b0:553:9cb9:a3d6 with SMTP id
 r27-20020a50d69b000000b005539cb9a3d6mr73172edi.8.1702958964032; Mon, 18 Dec
 2023 20:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702952464-22050-1-git-send-email-zhiguo.niu@unisoc.com> <6c553a75-4842-4b28-9725-ba5e297ff793@kernel.org>
In-Reply-To: <6c553a75-4842-4b28-9725-ba5e297ff793@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 19 Dec 2023 12:09:12 +0800
Message-ID: <CAHJ8P3LgQB9Q_TQj0nmjKXLsk95uVA2xvPXdvpK8Gjsonz-fHg@mail.gmail.com>
Subject: Re: [PATCH V4] f2fs: show more discard status by sysfs
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/12/19 10:21, Zhiguo Niu wrote:
> > The current pending_discard attr just only shows the discard_cmd_cnt
> > information. More discard status can be shown so that we can check
> > them through sysfs when needed.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > changes of v2: Improve the patch according to Chao's suggestions.
> > changes of v3: Add a blank line for easy reading.
> > changes of v4: Split to three entries
> > ---
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
> >   fs/f2fs/sysfs.c                         | 33 ++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 48 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index 4f1d4e6..606a298 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -159,6 +159,21 @@ Date:            November 2021
> >   Contact:    "Jaegeuk Kim" <jaegeuk@kernel.org>
> >   Description:        Shows the number of pending discard commands in t=
he queue.
> >
> > +What:           /sys/fs/f2fs/<disk>/issued_discard
>
> Add them to /sys/fs/f2fs/<disk>/stat/?
I just want to keep them consistent with the entry "pending_discard"
if they are split to 3 entries.
they are all discard related infos.
Thanks
>
> Thanks,
>
> > +Date:           December 2023
> > +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> > +Description:    Shows the number of issued discard.
> > +
> > +What:           /sys/fs/f2fs/<disk>/queued_discard
> > +Date:           December 2023
> > +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> > +Description:    Shows the number of queued discard.
> > +
> > +What:           /sys/fs/f2fs/<disk>/undiscard_blks
> > +Date:           December 2023
> > +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> > +Description:    Shows the total number of undiscard blocks.
> > +
> >   What:               /sys/fs/f2fs/<disk>/max_victim_search
> >   Date:               January 2014
> >   Contact:    "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 7099ffa..666efdd 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -143,6 +143,33 @@ static ssize_t pending_discard_show(struct f2fs_at=
tr *a,
> >                               &SM_I(sbi)->dcc_info->discard_cmd_cnt));
> >   }
> >
> > +static ssize_t issued_discard_show(struct f2fs_attr *a,
> > +             struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +     if (!SM_I(sbi)->dcc_info)
> > +             return -EINVAL;
> > +     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
> > +                             &SM_I(sbi)->dcc_info->issued_discard));
> > +}
> > +
> > +static ssize_t queued_discard_show(struct f2fs_attr *a,
> > +             struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +     if (!SM_I(sbi)->dcc_info)
> > +             return -EINVAL;
> > +     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
> > +                             &SM_I(sbi)->dcc_info->queued_discard));
> > +}
> > +
> > +static ssize_t undiscard_blks_show(struct f2fs_attr *a,
> > +             struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +     if (!SM_I(sbi)->dcc_info)
> > +             return -EINVAL;
> > +     return sysfs_emit(buf, "%u\n",
> > +                             SM_I(sbi)->dcc_info->undiscard_blks);
> > +}
> > +
> >   static ssize_t gc_mode_show(struct f2fs_attr *a,
> >               struct f2fs_sb_info *sbi, char *buf)
> >   {
> > @@ -1025,6 +1052,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_a=
ttr *a,
> >   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> >   F2FS_GENERAL_RO_ATTR(main_blkaddr);
> >   F2FS_GENERAL_RO_ATTR(pending_discard);
> > +F2FS_GENERAL_RO_ATTR(issued_discard);
> > +F2FS_GENERAL_RO_ATTR(queued_discard);
> > +F2FS_GENERAL_RO_ATTR(undiscard_blks);
> >   F2FS_GENERAL_RO_ATTR(gc_mode);
> >   #ifdef CONFIG_F2FS_STAT_FS
> >   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> > @@ -1084,6 +1114,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_a=
ttr *a,
> >       ATTR_LIST(max_ordered_discard),
> >       ATTR_LIST(discard_io_aware),
> >       ATTR_LIST(pending_discard),
> > +     ATTR_LIST(issued_discard),
> > +     ATTR_LIST(queued_discard),
> > +     ATTR_LIST(undiscard_blks),
> >       ATTR_LIST(gc_mode),
> >       ATTR_LIST(ipu_policy),
> >       ATTR_LIST(min_ipu_util),

