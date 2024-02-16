Return-Path: <linux-kernel+bounces-69221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2318585EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C4FB219E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FF135A64;
	Fri, 16 Feb 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTTLFWQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4F1353FD;
	Fri, 16 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110237; cv=none; b=dn6hJxdIA4uZ75lDqXSVqhLbkZ+y6AUcvaHNSzgbwuWQ1PxkQqOjhT7QN3k6NJ2YLO35+x9BgIc5lpft4pWglKc/k9JVoz2qxSPkyzKBrkycEY98RNF6ISe5Dp41J4JyaOBTv9h1Pd3KDDNnE11WDAn4sP/3D0Zesh4wJshNkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110237; c=relaxed/simple;
	bh=Zv4cPeyVJDLB/TvNG/DJYoKenA7k7ijVed+YxbCFd04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECCMxPWiLgIPUCvJFnhVTfgCcRrbTjUKe16jt2WqB1Nha92yvXsFDyvA2fCY2wkbJaRuQKo9UxVd44X5G0rMiihMhirMGtbT6brBDtBX0tipO+ylqFpK+wzqk1MWYfYdwUICxcwQrFT1QlN2HI5QBPA5tfvLrcAiNQOSVQX5c6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTTLFWQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80137C433C7;
	Fri, 16 Feb 2024 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708110236;
	bh=Zv4cPeyVJDLB/TvNG/DJYoKenA7k7ijVed+YxbCFd04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fTTLFWQk8Bg/dwggOXUDRXelJZOC2XOZmfB8DffPENLY5Db2QdyFCJySMp57mfT/h
	 it4o2jimrk22UoeQeftpgq/CnD83KEsB4wumP2kL99cBkARVIBJrHpSbBP9vwYeBEM
	 7e2+9ik8tTdhpkV2Pj1EcXIVVduFkHMVzLuGzFBt9T9hh9Re1nQo+sewdALx8l647F
	 /kZUuee0CkaSuCQG771/oStF4wy5zhWpSfNqq7YOWY5pm3mJ4p8yuwF55c70gHv6bi
	 YGweChb3KMp+/HPqEaNBWTHt3hCn0LSEbwnUDJtEQXo21x72AqaGMWa+kEDmubW70G
	 UfMBwSOuy2x9g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511976c126dso3048046e87.1;
        Fri, 16 Feb 2024 11:03:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqPgvw8lGTlUxMtrV2XeA9GTQX3Vx5w21SWhuAUqdrHDNlkLxgeo1te/xGnujwamMhsN36phsZEjfFimEvstC5qxCQKjU4NQkeo66csu6IXblglewiNTnEXRKoKlADnHTBw2jC1bVJ2PfBqPehkfxI/QFcAJqbnqjrtcE0d6zm4MmCPO/N
X-Gm-Message-State: AOJu0YzLQQS8vm5TTwq06omahPSU1p93xY42XrxxQnmcFWXxc4xezCu7
	x68rRUu58yN2//KWxt+WPglcaIUqr+CSj89w+tfCWDTvfeP97K7rAz9Xxlsh44/h54JIL85fYxV
	pZuJe3Oap8/GADEs5poskJxx5Ook=
X-Google-Smtp-Source: AGHT+IEycf+NM9n+P8mdOFvZz+EtAfjPtC1B7CFJzSUv0WLyR/fxT5QjiwPKU3tH/DqHNhYF216exWdMLQjfU/95U4Q=
X-Received: by 2002:ac2:464f:0:b0:512:9f9b:ec50 with SMTP id
 s15-20020ac2464f000000b005129f9bec50mr422755lfo.38.1708110234637; Fri, 16 Feb
 2024 11:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
 <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
 <6849835d-a3ac-e840-09e9-8539e7953fe4@huaweicloud.com> <CAPhsuW4k_C=UxwESU4t7R+fpoAJ_HE8g_PpCJXSUGWOdbpCEoQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4k_C=UxwESU4t7R+fpoAJ_HE8g_PpCJXSUGWOdbpCEoQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 16 Feb 2024 11:03:42 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4H=ehc1UiuFdhBXZUfU_okQ=-rbti1oEWHcs7ajT89iw@mail.gmail.com>
Message-ID: <CAPhsuW4H=ehc1UiuFdhBXZUfU_okQ=-rbti1oEWHcs7ajT89iw@mail.gmail.com>
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: Li Nan <linan666@huaweicloud.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 4:49=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Feb 8, 2024 at 12:44=E2=80=AFAM Li Nan <linan666@huaweicloud.com>=
 wrote:
> >
> >
> >
> > =E5=9C=A8 2024/2/8 14:50, Song Liu =E5=86=99=E9=81=93:
> > > On Wed, Feb 7, 2024 at 1:32=E2=80=AFAM <linan666@huaweicloud.com> wro=
te:
> > >>
> > >> From: Li Nan <linan122@huawei.com>
> > >>
> > >> 'open_mutex' of gendisk is used to protect open/close block devices.=
 But
> > >> in bd_link_disk_holder(), it is used to protect the creation of syml=
ink
> > >> between holding disk and slave bdev, which introduces some issues.
> > >>
> > >> When bd_link_disk_holder() is called, the driver is usually in the p=
rocess
> > >> of initialization/modification and may suspend submitting io. At thi=
s
> > >> time, any io hold 'open_mutex', such as scanning partitions, can cau=
se
> > >> deadlocks. For example, in raid:
> > >>
> > >> T1                              T2
> > >> bdev_open_by_dev
> > >>   lock open_mutex [1]
> > >>   ...
> > >>    efi_partition
> > >>    ...
> > >>     md_submit_bio
> > >>                                  md_ioctl mddev_syspend
> > >>                                    -> suspend all io
> > >>                                   md_add_new_disk
> > >>                                    bind_rdev_to_array
> > >>                                     bd_link_disk_holder
> > >>                                      try lock open_mutex [2]
> > >>      md_handle_request
> > >>       -> wait mddev_resume
> > >>
> > >> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to r=
esume
> > >> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
> > >>
> > >> Fix it by introducing a local mutex 'holder_mutex' to replace 'open_=
mutex'.
> > >
> > > Is this to fix [1]? Do we need some Fixes and/or Closes tags?
> > >
> >
> > No. Just use another way to fix [2], and both [2] and this patch can fi=
x
> > the issue. I am not sure about the root cause of [1] yet.
> >
> > [2] https://patchwork.kernel.org/project/linux-raid/list/?series=3D8120=
45
> >
> > > Could you please add steps to reproduce this issue?
> >
> > We need to modify the kernel, add sleep in md_submit_bio() and md_ioctl=
()
> > as below, and then:
> >    1. mdadm -CR /dev/md0 -l1 -n2 /dev/sd[bc]  #create a raid
> >    2. echo 1 > /sys/module/md_mod/parameters/error_inject  #enable slee=
p
> >    3. 'mdadm --add /dev/md0 /dev/sda'  #add a disk to raid
> >    4. submit ioctl BLKRRPART to raid within 10s.
>
> The analysis makes sense. I also hit the issue a couple times without add=
ing
> extra delays. But I am not sure whether this is the best fix (I didn't fi=
nd real
> issues with it either).

To be extra safe and future proof, we can do something like the
following to only
suspend the array for ADD_NEW_DISK on not-running arrays.

This appear to solve the problem reported in

https://bugzilla.kernel.org/show_bug.cgi?id=3D218459

Thanks,
Song

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9e41a9aaba8b..395911d5f4d6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7570,10 +7570,11 @@ static inline bool md_ioctl_valid(unsigned int cmd)
        }
 }

-static bool md_ioctl_need_suspend(unsigned int cmd)
+static bool md_ioctl_need_suspend(struct mddev *mddev, unsigned int cmd)
 {
        switch (cmd) {
        case ADD_NEW_DISK:
+               return mddev->pers !=3D NULL;
        case HOT_ADD_DISK:
        case HOT_REMOVE_DISK:
        case SET_BITMAP_FILE:
@@ -7625,6 +7626,7 @@ static int md_ioctl(struct block_device *bdev,
blk_mode_t mode,
        void __user *argp =3D (void __user *)arg;
        struct mddev *mddev =3D NULL;
        bool did_set_md_closing =3D false;
+       bool need_suspend;

        if (!md_ioctl_valid(cmd))
                return -ENOTTY;
@@ -7716,8 +7718,11 @@ static int md_ioctl(struct block_device *bdev,
blk_mode_t mode,
        if (!md_is_rdwr(mddev))
                flush_work(&mddev->sync_work);

-       err =3D md_ioctl_need_suspend(cmd) ? mddev_suspend_and_lock(mddev) =
:
-                                          mddev_lock(mddev);
+       need_suspend =3D md_ioctl_need_suspend(mddev, cmd);
+       if (need_suspend)
+               err =3D mddev_suspend_and_lock(mddev);
+       else
+               err =3D mddev_lock(mddev);
        if (err) {
                pr_debug("md: ioctl lock interrupted, reason %d, cmd %d\n",
                         err, cmd);
@@ -7846,8 +7851,10 @@ static int md_ioctl(struct block_device *bdev,
blk_mode_t mode,
            err !=3D -EINVAL)
                mddev->hold_active =3D 0;

-       md_ioctl_need_suspend(cmd) ? mddev_unlock_and_resume(mddev) :
-                                    mddev_unlock(mddev);
+       if (need_suspend)
+               mddev_unlock_and_resume(mddev);
+       else
+               mddev_unlock(mddev);

 out:
        if(did_set_md_closing)

