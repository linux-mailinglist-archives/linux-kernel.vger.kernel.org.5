Return-Path: <linux-kernel+bounces-6128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F18194F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FAF287982
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98993210;
	Wed, 20 Dec 2023 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si7ms8hP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A5210A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so36148581fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703030819; x=1703635619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOR+RPgbaBE5VnzmKzfwV+b/Yqnim5AGeLaNFxas2yY=;
        b=Si7ms8hPxVb140TVHX5eo5mvxGjgCYCVbnYIgAKcOPODGuvMEH3yuQIy28hEdbAyLr
         BD993x4mxouEaSzSjWKLwESoioR5t9lRc4dWhCXyfUCsSPFtUMBASHRviTs2WECG1/im
         MXokNKurA6cJx0V7W0j49PMREU2yS9ADS53ME17Q2JGwEmMmqh0bThp/FerHKQk/H0wb
         ua1JBzvisgGg10aPpEb6Vp1JfiR0NsJTheQP9j6QFGi8bXAltC1DIVeVTNg30Vg01Aks
         LGIK60NsY5mDwlAbXeHYzTtuPPPVlG5nI3BDfweziTp6/3/eJyvZ64JGWuMN2re1pek6
         JvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703030819; x=1703635619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOR+RPgbaBE5VnzmKzfwV+b/Yqnim5AGeLaNFxas2yY=;
        b=jv9WkBNrdNd7qRk6I8fbVpJzF9giB19L5ueUvAC/3uMXvF2/6mTo6ulbqewksjigiN
         WDDvIAmIApC67Uo8j+ybrzRuNaMFFT8ncZUcFjJTMFD8giamZHZ/TcFqT/zwNspAqmCY
         ujEPtAkgCsG00RsHn9PfWA4XgseULJx6//s/YyMYYI67RbA+ijSeaGDGyL1gnKnhJCFH
         Edf7yEkBVHUVe/kUrKIQoTm4ttQVaSN6GbzleRQCUOEGdnJHTctK6pcI0J15rIDY4W36
         7uEzGQP+Xb5U70TdkdGbDJA3Y2afvdDPWTODA0YU1KuTNiiOxAnH0eegJYsErXQJRbNx
         sJfA==
X-Gm-Message-State: AOJu0YxRuWk2DBT43hv7tLlG1jCVFap7BLFw80oNuol5NkBCUNk6y2F5
	XRbbTFPGJV6jeEqFg85xwLQnSVtzEYGgZgEE3lwBkYcq
X-Google-Smtp-Source: AGHT+IE/0GFbN1G49K+i8mz1KyhrAnocdbXAqapZQOqL0QubEj0Dk2SePK/BbZCznIJtOyyua976XOBgNX4wMuz24gU=
X-Received: by 2002:a05:651c:1993:b0:2cb:ebc9:45d2 with SMTP id
 bx19-20020a05651c199300b002cbebc945d2mr8997806ljb.23.1703030818884; Tue, 19
 Dec 2023 16:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702952464-22050-1-git-send-email-zhiguo.niu@unisoc.com>
 <6c553a75-4842-4b28-9725-ba5e297ff793@kernel.org> <CAHJ8P3LgQB9Q_TQj0nmjKXLsk95uVA2xvPXdvpK8Gjsonz-fHg@mail.gmail.com>
 <cac5bf07-9091-40b7-8fb2-01f7a032d2ef@kernel.org>
In-Reply-To: <cac5bf07-9091-40b7-8fb2-01f7a032d2ef@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 20 Dec 2023 08:06:46 +0800
Message-ID: <CAHJ8P3LnsFkFR3+74=vYj+_s3f0LafqMrpnO9zpo=E0V4QA54g@mail.gmail.com>
Subject: Re: [PATCH V4] f2fs: show more discard status by sysfs
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:24=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/12/19 12:09, Zhiguo Niu wrote:
> > On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Chao Yu <chao@kernel.org> wrot=
e:
> >>
> >> On 2023/12/19 10:21, Zhiguo Niu wrote:
> >>> The current pending_discard attr just only shows the discard_cmd_cnt
> >>> information. More discard status can be shown so that we can check
> >>> them through sysfs when needed.
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>> changes of v2: Improve the patch according to Chao's suggestions.
> >>> changes of v3: Add a blank line for easy reading.
> >>> changes of v4: Split to three entries
> >>> ---
> >>> ---
> >>>    Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
> >>>    fs/f2fs/sysfs.c                         | 33 +++++++++++++++++++++=
++++++++++++
> >>>    2 files changed, 48 insertions(+)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/=
ABI/testing/sysfs-fs-f2fs
> >>> index 4f1d4e6..606a298 100644
> >>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> >>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> >>> @@ -159,6 +159,21 @@ Date:            November 2021
> >>>    Contact:    "Jaegeuk Kim" <jaegeuk@kernel.org>
> >>>    Description:        Shows the number of pending discard commands i=
n the queue.
> >>>
> >>> +What:           /sys/fs/f2fs/<disk>/issued_discard
> >>
> >> Add them to /sys/fs/f2fs/<disk>/stat/?
> > I just want to keep them consistent with the entry "pending_discard"
>
> There are too many entries in root directory of f2fs sysfs entry, so I
> created the 'stat' sub-directory for later all read-only stat-related
> entry. I think it's fine to create new discard stat entries there.
I got it  and will update the patch. thanks.
>
> Thanks,
>
> > if they are split to 3 entries.
> > they are all discard related infos.
> > Thanks
> >>
> >> Thanks,
> >>
> >>> +Date:           December 2023
> >>> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> >>> +Description:    Shows the number of issued discard.
> >>> +
> >>> +What:           /sys/fs/f2fs/<disk>/queued_discard
> >>> +Date:           December 2023
> >>> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> >>> +Description:    Shows the number of queued discard.
> >>> +
> >>> +What:           /sys/fs/f2fs/<disk>/undiscard_blks
> >>> +Date:           December 2023
> >>> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> >>> +Description:    Shows the total number of undiscard blocks.
> >>> +
> >>>    What:               /sys/fs/f2fs/<disk>/max_victim_search
> >>>    Date:               January 2014
> >>>    Contact:    "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> >>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>> index 7099ffa..666efdd 100644
> >>> --- a/fs/f2fs/sysfs.c
> >>> +++ b/fs/f2fs/sysfs.c
> >>> @@ -143,6 +143,33 @@ static ssize_t pending_discard_show(struct f2fs_=
attr *a,
> >>>                                &SM_I(sbi)->dcc_info->discard_cmd_cnt)=
);
> >>>    }
> >>>
> >>> +static ssize_t issued_discard_show(struct f2fs_attr *a,
> >>> +             struct f2fs_sb_info *sbi, char *buf)
> >>> +{
> >>> +     if (!SM_I(sbi)->dcc_info)
> >>> +             return -EINVAL;
> >>> +     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_rea=
d(
> >>> +                             &SM_I(sbi)->dcc_info->issued_discard));
> >>> +}
> >>> +
> >>> +static ssize_t queued_discard_show(struct f2fs_attr *a,
> >>> +             struct f2fs_sb_info *sbi, char *buf)
> >>> +{
> >>> +     if (!SM_I(sbi)->dcc_info)
> >>> +             return -EINVAL;
> >>> +     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_rea=
d(
> >>> +                             &SM_I(sbi)->dcc_info->queued_discard));
> >>> +}
> >>> +
> >>> +static ssize_t undiscard_blks_show(struct f2fs_attr *a,
> >>> +             struct f2fs_sb_info *sbi, char *buf)
> >>> +{
> >>> +     if (!SM_I(sbi)->dcc_info)
> >>> +             return -EINVAL;
> >>> +     return sysfs_emit(buf, "%u\n",
> >>> +                             SM_I(sbi)->dcc_info->undiscard_blks);
> >>> +}
> >>> +
> >>>    static ssize_t gc_mode_show(struct f2fs_attr *a,
> >>>                struct f2fs_sb_info *sbi, char *buf)
> >>>    {
> >>> @@ -1025,6 +1052,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs=
_attr *a,
> >>>    F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> >>>    F2FS_GENERAL_RO_ATTR(main_blkaddr);
> >>>    F2FS_GENERAL_RO_ATTR(pending_discard);
> >>> +F2FS_GENERAL_RO_ATTR(issued_discard);
> >>> +F2FS_GENERAL_RO_ATTR(queued_discard);
> >>> +F2FS_GENERAL_RO_ATTR(undiscard_blks);
> >>>    F2FS_GENERAL_RO_ATTR(gc_mode);
> >>>    #ifdef CONFIG_F2FS_STAT_FS
> >>>    F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> >>> @@ -1084,6 +1114,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs=
_attr *a,
> >>>        ATTR_LIST(max_ordered_discard),
> >>>        ATTR_LIST(discard_io_aware),
> >>>        ATTR_LIST(pending_discard),
> >>> +     ATTR_LIST(issued_discard),
> >>> +     ATTR_LIST(queued_discard),
> >>> +     ATTR_LIST(undiscard_blks),
> >>>        ATTR_LIST(gc_mode),
> >>>        ATTR_LIST(ipu_policy),
> >>>        ATTR_LIST(min_ipu_util),

