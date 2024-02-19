Return-Path: <linux-kernel+bounces-70724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB6859B90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A324D1F221F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC602030F;
	Mon, 19 Feb 2024 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkuA1cn/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54357200AB;
	Mon, 19 Feb 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319669; cv=none; b=pDkQzJzJsoZI1OBxvTHYzU/5vGE5nkyG8Bc6pryTEAE6RcrVjgeRxSaT6V2u5J5uuRAUxzyc/Aui5Ifmpp6qH+QJb4d6OiR+s+UYcCpTbccCarou9fU6t+ceDpiW6vcv8ERiEjtFlEgFZhJvLJyp+ajOEq0bO5VmInHxFoDJyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319669; c=relaxed/simple;
	bh=z4idcdiF/V/G2dzC4JCbN56aiWbN2ggIAFpdC/RrtSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gswjQ0+va/9Ynjz33Pwxz/+GlJE6/xP9rT2mSovS5UYJta13SzKHAbz2hWpFMV1anlozgSNKPuWA+UaoyzbmdC48DXaeow8YBTGgkNUJ9lq8sYVO++qQcL7SPtADfRevI8zyoDkftLDIo93heLW/8aRy6hFNKIeVN2UMDmRkPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkuA1cn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64F7C433F1;
	Mon, 19 Feb 2024 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708319668;
	bh=z4idcdiF/V/G2dzC4JCbN56aiWbN2ggIAFpdC/RrtSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KkuA1cn/g3B0W03242S+dyZ4xulDy1Yc+CzPBkUWirDOk/5zx/8cr9OvH/KgkIe2u
	 1HFr3yNUhubojkbjWZve2FQyV84Iwyns6bAhzrQdL85Hi32peO9bKQwTwmjfz7PL9v
	 6u3ogGF+GaxnMNWkWmcqMXkAkFNVCPBIhROv+Eu5OfEOXsr9I1HnANb/O0rvigpAKV
	 KrDu9C0fEy4bAAH2EpWaTeeVUnxHJrdA97DK0DkuXe/jQMO90SvnvmJP4hYCcnKuHs
	 H7K1ZnHA01YbVn68KFZAzJsFt1zi8SDuW3CfpAutmfEgwe1gDAhL/3k8tpajEhVZa3
	 5+uZdyEIuv5Ww==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51181d8f52fso4976922e87.3;
        Sun, 18 Feb 2024 21:14:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhZRdmCMtaMFluJXL76OlCNMwBCW+uq749jHPgiOcL5J2Wbcie4CUfO12bXCGWlu8TRyfu3kB3zGfHQLj7A64ZR4Cmzh9vjiLMqEq8t7eAc5svr2Y0UmpCZgdYjh4faL/iU1he0ad3VVesdjPAwED3Kp+VyudPR1HHhCkUv3Oi6ZY85OJ0
X-Gm-Message-State: AOJu0YxogTV28qmn45oTEg+5A0C7W2a/RCqYLZ/1PR2v1AsXtLf9QO5a
	6ig3/U+qoZYmoyM/gl9iGL9xeXZVdvojrpucfvjhPWI4yWmun/r2ly9BVuFJjkHQSvGz6eo7svJ
	HyBtwsjxGCNFLI5HlIboOzQiFtW4=
X-Google-Smtp-Source: AGHT+IHP0dlnJUlayhW2vHdNTwFmGK3q7309DdLzwwG1sbb0VcE+YBn293oz0kclgJ7xu4Z8sZIKEobhsBKmAOUZz3o=
X-Received: by 2002:a19:5e19:0:b0:512:b92a:be02 with SMTP id
 s25-20020a195e19000000b00512b92abe02mr244978lfb.15.1708319667012; Sun, 18 Feb
 2024 21:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
 <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
 <6849835d-a3ac-e840-09e9-8539e7953fe4@huaweicloud.com> <CAPhsuW4k_C=UxwESU4t7R+fpoAJ_HE8g_PpCJXSUGWOdbpCEoQ@mail.gmail.com>
 <CAPhsuW4H=ehc1UiuFdhBXZUfU_okQ=-rbti1oEWHcs7ajT89iw@mail.gmail.com> <6211cd80-6573-656d-e198-befe074030d8@huaweicloud.com>
In-Reply-To: <6211cd80-6573-656d-e198-befe074030d8@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Sun, 18 Feb 2024 21:14:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7T3r4_9PYHrQYPmzhA2t0MVepo-d-6Q922wfyZtB+cpg@mail.gmail.com>
Message-ID: <CAPhsuW7T3r4_9PYHrQYPmzhA2t0MVepo-d-6Q922wfyZtB+cpg@mail.gmail.com>
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Li Nan <linan666@huaweicloud.com>, axboe@kernel.dk, linux-raid@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 11:47=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/02/17 3:03, Song Liu =E5=86=99=E9=81=93:
> > On Thu, Feb 8, 2024 at 4:49=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >>
> >> On Thu, Feb 8, 2024 at 12:44=E2=80=AFAM Li Nan <linan666@huaweicloud.c=
om> wrote:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2024/2/8 14:50, Song Liu =E5=86=99=E9=81=93:
> >>>> On Wed, Feb 7, 2024 at 1:32=E2=80=AFAM <linan666@huaweicloud.com> wr=
ote:
> >>>>>
> >>>>> From: Li Nan <linan122@huawei.com>
> >>>>>
> >>>>> 'open_mutex' of gendisk is used to protect open/close block devices=
 But
> >>>>> in bd_link_disk_holder(), it is used to protect the creation of sym=
link
> >>>>> between holding disk and slave bdev, which introduces some issues.
> >>>>>
> >>>>> When bd_link_disk_holder() is called, the driver is usually in the =
process
> >>>>> of initialization/modification and may suspend submitting io. At th=
is
> >>>>> time, any io hold 'open_mutex', such as scanning partitions, can ca=
use
> >>>>> deadlocks. For example, in raid:
> >>>>>
> >>>>> T1                              T2
> >>>>> bdev_open_by_dev
> >>>>>    lock open_mutex [1]
> >>>>>    ...
> >>>>>     efi_partition
> >>>>>     ...
> >>>>>      md_submit_bio
> >>>>>                                   md_ioctl mddev_syspend
> >>>>>                                     -> suspend all io
> >>>>>                                    md_add_new_disk
> >>>>>                                     bind_rdev_to_array
> >>>>>                                      bd_link_disk_holder
> >>>>>                                       try lock open_mutex [2]
> >>>>>       md_handle_request
> >>>>>        -> wait mddev_resume
> >>>>>
> >>>>> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to =
resume
> >>>>> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
> >>>>>
> >>>>> Fix it by introducing a local mutex 'holder_mutex' to replace 'open=
_mutex'.
> >>>>
> >>>> Is this to fix [1]? Do we need some Fixes and/or Closes tags?
> >>>>
> >>>
> >>> No. Just use another way to fix [2], and both [2] and this patch can =
fix
> >>> the issue. I am not sure about the root cause of [1] yet.
> >>>
> >>> [2] https://patchwork.kernel.org/project/linux-raid/list/?series=3D81=
2045
> >>>
> >>>> Could you please add steps to reproduce this issue?
> >>>
> >>> We need to modify the kernel, add sleep in md_submit_bio() and md_ioc=
tl()
> >>> as below, and then:
> >>>     1. mdadm -CR /dev/md0 -l1 -n2 /dev/sd[bc]  #create a raid
> >>>     2. echo 1 > /sys/module/md_mod/parameters/error_inject  #enable s=
leep
> >>>     3. 'mdadm --add /dev/md0 /dev/sda'  #add a disk to raid
> >>>     4. submit ioctl BLKRRPART to raid within 10s.
> >>
> >> The analysis makes sense. I also hit the issue a couple times without =
adding
> >> extra delays. But I am not sure whether this is the best fix (I didn't=
 find real
> >> issues with it either).
> >
> > To be extra safe and future proof, we can do something like the
> > following to only
> > suspend the array for ADD_NEW_DISK on not-running arrays.
> >
> > This appear to solve the problem reported in
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218459
> >
> > Thanks,
> > Song
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 9e41a9aaba8b..395911d5f4d6 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -7570,10 +7570,11 @@ static inline bool md_ioctl_valid(unsigned int =
cmd)
> >          }
> >   }
> >
> > -static bool md_ioctl_need_suspend(unsigned int cmd)
> > +static bool md_ioctl_need_suspend(struct mddev *mddev, unsigned int cm=
d)
> >   {
> >          switch (cmd) {
> >          case ADD_NEW_DISK:
> > +               return mddev->pers !=3D NULL;
>
> Did you check already that this problem is not related that 'active_io'
> is leaked for flush IO?
>
> I don't understand the problem reported yet. If 'mddev->pers' is not set
> yet, md_submit_bio() will return directly, and 'active_io' should not be
> grabbed in the first place.

AFAICT, this is not related to the active_io issue.

>
> md_run() is the only place to convert 'mddev->pers' from NULL to a real
> personality, and it's protected by 'reconfig_mutex', however,
> md_ioctl_need_suspend() is called without 'reconfig_mutex', hence there
> is a race condition:
>
> md_ioctl_need_suspend           array_state_store
>   // mddev->pers is NULL, return false
>                                  mddev_lock
>                                  do_md_run
>                                   mddev->pers =3D xxx
>                                  mddev_unlock
>
>   // mddev_suspend is not called
>   mddev_lock
>   md_add_new_disk
>    if (mddev->pers)
>     md_import_device
>     bind_rdev_to_array
>     add_bound_rdev
>      mddev->pers->hot_add_disk
>      -> hot add disk without suspending

Yeah, this race condition exists. We probably need some
trick with suspend and lock here.

Thanks,
Song

