Return-Path: <linux-kernel+bounces-58910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949A84EE71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5045E28536D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E83EBF;
	Fri,  9 Feb 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwt5+aHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21F1370;
	Fri,  9 Feb 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707439767; cv=none; b=ABFLy5ozdli6XhUksCuSA41aXKN8nEIKrHXxNZOBi/h3BwdeFaSQupyrncXsyFc7WyIgglVuABl/hVx8osh/703G0JWYCNhe00XWUcCUZpCYjQY5Hcn+8tRM0LKdafFRfQKOOf0zvZCh5jawMcSwNTD31ES5dtPV3HZINxSphC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707439767; c=relaxed/simple;
	bh=RC69OmraJjdcQEs+JowyAepisEthltjssiKo71cIqjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzR/nri9aIekRYT1e2qIf8bMnBkMLK5DmCMz+Do8+li8od8H2eOGWrqbOGmzdxiunUI1I9i7m4D/iETTlsdx/75HP7NmIeQd5cgK64NDhDp+nbVow5krR0m/JzaIo5RFfFAmmWT7AVtd3NVyX+XvoZba1WYsshAuRAOfFWdYJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwt5+aHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DFCC43394;
	Fri,  9 Feb 2024 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707439767;
	bh=RC69OmraJjdcQEs+JowyAepisEthltjssiKo71cIqjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kwt5+aHoe3eDM7jIbPPWQI9E+qqmeI7UAekcLrr5YC+FeaAym3uVETANNfkniEcG7
	 o9C8fSRxXsFuWl/F4a+snxSbsMJ+DMrGkeYHBhFlaTaHxDXl/FjFXSDufWaetpEsZX
	 naJcqAba7hew0do1A6IdT+bMYXHzinh4qs7fziWBx52+SpKm1wW+Pm/z9AYd8oNvzy
	 Hzp1Vv4mx0ROucili1Rxq9ECpfVvtReWeo+8eQjsmKCMoeU0awZC9y+q6Qa17SoChE
	 4JOMtFFUmDVy6ksUKphQ+4Pp/ZxoZGXZkRI0XsbEUCeNYmm2JtwKBUsSdCCySCeEO1
	 UoCuJdzuM345g==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so5948801fa.1;
        Thu, 08 Feb 2024 16:49:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhSpNZM/J+Z4b0MRlFRPira8HWEZiHp7QxYZbAPiOLMjvv0foElK++iJ7TrxqrSPTCYtWJYZA6M5akw89aV/xxyVh5F9LuDKp5mbya/WpjaIOP+APTlSw6FTPTPEPEBTVHiENapqKykygVOkqUSZbsT7CT019cKxVQ4zxI3E9M6cXmogJh
X-Gm-Message-State: AOJu0YxGFu2UDtXaUuMbUyD4ryOeuaNf1Mk4cCT+J22VfWW8zNuaZRuP
	Pn2BIwh0ngmbYSAr70epdNCjg8gOXqDOniiJzRXGBdBJhl1CUiIJcwcebL1gdth8Ze2jPl4Av3C
	wWPmUNobzdB4hdP+6rt02nqF13Jo=
X-Google-Smtp-Source: AGHT+IFRVkWW5q39EprGlwVcuAq11QSUYjK4Mr3CsLeDBH1ucV0r4bBS07Q8ApUlxOmqFodrziGBADpM4smfFaTgn1Q=
X-Received: by 2002:a05:6512:3e03:b0:511:6436:66bc with SMTP id
 i3-20020a0565123e0300b00511643666bcmr743595lfv.4.1707439765288; Thu, 08 Feb
 2024 16:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
 <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com> <6849835d-a3ac-e840-09e9-8539e7953fe4@huaweicloud.com>
In-Reply-To: <6849835d-a3ac-e840-09e9-8539e7953fe4@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 Feb 2024 16:49:13 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4k_C=UxwESU4t7R+fpoAJ_HE8g_PpCJXSUGWOdbpCEoQ@mail.gmail.com>
Message-ID: <CAPhsuW4k_C=UxwESU4t7R+fpoAJ_HE8g_PpCJXSUGWOdbpCEoQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: Li Nan <linan666@huaweicloud.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:44=E2=80=AFAM Li Nan <linan666@huaweicloud.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/2/8 14:50, Song Liu =E5=86=99=E9=81=93:
> > On Wed, Feb 7, 2024 at 1:32=E2=80=AFAM <linan666@huaweicloud.com> wrote=
:
> >>
> >> From: Li Nan <linan122@huawei.com>
> >>
> >> 'open_mutex' of gendisk is used to protect open/close block devices. B=
ut
> >> in bd_link_disk_holder(), it is used to protect the creation of symlin=
k
> >> between holding disk and slave bdev, which introduces some issues.
> >>
> >> When bd_link_disk_holder() is called, the driver is usually in the pro=
cess
> >> of initialization/modification and may suspend submitting io. At this
> >> time, any io hold 'open_mutex', such as scanning partitions, can cause
> >> deadlocks. For example, in raid:
> >>
> >> T1                              T2
> >> bdev_open_by_dev
> >>   lock open_mutex [1]
> >>   ...
> >>    efi_partition
> >>    ...
> >>     md_submit_bio
> >>                                  md_ioctl mddev_syspend
> >>                                    -> suspend all io
> >>                                   md_add_new_disk
> >>                                    bind_rdev_to_array
> >>                                     bd_link_disk_holder
> >>                                      try lock open_mutex [2]
> >>      md_handle_request
> >>       -> wait mddev_resume
> >>
> >> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to res=
ume
> >> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
> >>
> >> Fix it by introducing a local mutex 'holder_mutex' to replace 'open_mu=
tex'.
> >
> > Is this to fix [1]? Do we need some Fixes and/or Closes tags?
> >
>
> No. Just use another way to fix [2], and both [2] and this patch can fix
> the issue. I am not sure about the root cause of [1] yet.
>
> [2] https://patchwork.kernel.org/project/linux-raid/list/?series=3D812045
>
> > Could you please add steps to reproduce this issue?
>
> We need to modify the kernel, add sleep in md_submit_bio() and md_ioctl()
> as below, and then:
>    1. mdadm -CR /dev/md0 -l1 -n2 /dev/sd[bc]  #create a raid
>    2. echo 1 > /sys/module/md_mod/parameters/error_inject  #enable sleep
>    3. 'mdadm --add /dev/md0 /dev/sda'  #add a disk to raid
>    4. submit ioctl BLKRRPART to raid within 10s.

The analysis makes sense. I also hit the issue a couple times without addin=
g
extra delays. But I am not sure whether this is the best fix (I didn't find=
 real
issues with it either).

Maybe we don't need to suspend the array for ADD_NEW_DISK? So that
something like the following might just work?

Thanks,
Song

@@ -7573,7 +7577,6 @@ static inline bool md_ioctl_valid(unsigned int cmd)
 static bool md_ioctl_need_suspend(unsigned int cmd)
 {
        switch (cmd) {
-       case ADD_NEW_DISK:
        case HOT_ADD_DISK:
        case HOT_REMOVE_DISK:
        case SET_BITMAP_FILE:

