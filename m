Return-Path: <linux-kernel+bounces-4504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E68817E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF5C28597D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6BE760BE;
	Mon, 18 Dec 2023 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQV5sTtt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5026740A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso1205695f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702943989; x=1703548789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq3IPb9MxUI/WofczsPTB2b0KO9e9TG8+h96NbTnoHA=;
        b=RQV5sTttAHGwsPKxSHrZ8Rn1U6ntJxt2iNAEFBeEpL/f+1JnlXStgDJZsq+7n3f6Xy
         tqCtwjBb419hRVNVHS/HLQ6pXWiHilWZBLxNzy4zPWM/hqecGo5VhRvjVniAcboJy2uh
         lhe4ku2YQHYTNMO44YJ2lnEqUCL1Kd8vOGyYtUEnb+WaD1plRp8E7lnydsIXSDfF5qC+
         p4JlLYr3oEEaMGGXHiAHgEmqSjutLG8Nj8sT4j2207JNrYGPghLe+XJBPa4uNFiFdixA
         /t4yUbZIIs6hBWfJ3MiiQsp/p3PgNzTOQ0A8mQNJhF3LnYI6jJyrKUE3xP1OSrQnHF9B
         1ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702943989; x=1703548789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3IPb9MxUI/WofczsPTB2b0KO9e9TG8+h96NbTnoHA=;
        b=fNwdMcH0E9UrC2sxPlXhpyWZg1eF72ylW1CFZsOGAsgCnhGdl9Rs7vZmTBBoRJwmjl
         KnjZg9dDlirW34rimmdORY6C8ZXY1mSfQqbnfY7bwUCbAnTwgKPrCIu/rsnY6CD3YmIX
         kXwvc5fqbvq8M6N5HlSwHuZ7ScGEY6ROuDODjy+IuzIptwXowcQWL3dswsKkMoThwJ0q
         L5+Y9yA9x2jWhwbzmWFQNdzuJzuH8ft3DP/Ysmu5ucO4JoJ96axuVpF5jE4f9xAV6SwC
         TalitTQMmAMDlbfJe1/jLkV56VQsRNAxYuAEuhTxvECJSVRWMUsOdynh0OW+PsOoUo2U
         E1oQ==
X-Gm-Message-State: AOJu0Yw8lfECAjvcIIZQamLaSbXHxxc8zVWopCuGxN24S4JlVKEiF5ME
	4sASOA03NGTjaW3wc+7lXiq5zS4ZBu+FKJQxS5U=
X-Google-Smtp-Source: AGHT+IEEg+ro2wr1eP4EEpxwF1bjId8wJ5nQM/4YgsUGkOLSWNtyHnagsO1N5oEir7r8m6skfrJu3tOPg8vSNVQ0gGs=
X-Received: by 2002:a5d:564e:0:b0:336:5423:6c9c with SMTP id
 j14-20020a5d564e000000b0033654236c9cmr1622154wrw.16.1702943988822; Mon, 18
 Dec 2023 15:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702897676-12851-1-git-send-email-zhiguo.niu@unisoc.com> <ZYCFH4cyjjCVbpDF@google.com>
In-Reply-To: <ZYCFH4cyjjCVbpDF@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 19 Dec 2023 07:59:37 +0800
Message-ID: <CAHJ8P3LoN0eAJyO378zFss13mprZ1VegGFe=23d9UL2jFnnT-Q@mail.gmail.com>
Subject: Re: [PATCH V3] f2fs: show more discard status by sysfs
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:45=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 12/18, Zhiguo Niu wrote:
> > The current pending_discard attr just only shows the discard_cmd_cnt
> > information. More discard status can be shown so that we can check
> > them through sysfs when needed.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > changes of v2: Improve the patch according to Chao's suggestions.
> > changes of v3: Add a blank line for easy reading.
> > ---
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
> >  fs/f2fs/sysfs.c                         | 19 +++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index 36c3cb5..c6970e5 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -498,6 +498,12 @@ Description:     Show status of f2fs checkpoint in=
 real time.
> >               CP_RESIZEFS_FLAG                0x00004000
> >               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +What:                /sys/fs/f2fs/<disk>/stat/discard_status
> > +Date:                November 2023
> > +Contact:     "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> > +Description: Show status of f2fs discard in real time, including
> > +             "issued discard","queued discard" and "undiscard blocks".
> > +
> >  What:                /sys/fs/f2fs/<disk>/ckpt_thread_ioprio
> >  Date:                January 2021
> >  Contact:     "Daeho Jeong" <daehojeong@google.com>
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 417fae96..312a4dc 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -134,6 +134,22 @@ static ssize_t cp_status_show(struct f2fs_attr *a,
> >       return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_f=
lags));
> >  }
> >
> > +static ssize_t discard_status_show(struct f2fs_attr *a,
> > +             struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +     struct discard_cmd_control *dcc =3D SM_I(sbi)->dcc_info;
> > +
> > +     if (!dcc)
> > +             return -EINVAL;
> > +
> > +     return sysfs_emit(buf, "%llu, %llu, %u\n",
> > +                     (unsigned long long)atomic_read(
> > +                             &dcc->issued_discard),
> > +                     (unsigned long long)atomic_read(
> > +                             &dcc->queued_discard),
> > +                     dcc->undiscard_blks);
>
> We cannot do this since it needs one value per one entry.
OK, I will split this into three entry. thanks
>
> > +}
> > +
> >  static ssize_t pending_discard_show(struct f2fs_attr *a,
> >               struct f2fs_sb_info *sbi, char *buf)
> >  {
> > @@ -1197,9 +1213,12 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_=
attr *a,
> >
> >  F2FS_GENERAL_RO_ATTR(sb_status);
> >  F2FS_GENERAL_RO_ATTR(cp_status);
> > +F2FS_GENERAL_RO_ATTR(discard_status);
> > +
> >  static struct attribute *f2fs_stat_attrs[] =3D {
> >       ATTR_LIST(sb_status),
> >       ATTR_LIST(cp_status),
> > +     ATTR_LIST(discard_status),
> >       NULL,
> >  };
> >  ATTRIBUTE_GROUPS(f2fs_stat);
> > --
> > 1.9.1

