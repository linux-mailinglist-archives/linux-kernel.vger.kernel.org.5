Return-Path: <linux-kernel+bounces-37835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2378A83B636
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A41F2678C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5041A1C17;
	Thu, 25 Jan 2024 00:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBVIOu4l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A580A;
	Thu, 25 Jan 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143627; cv=none; b=V2k4veqdOh14aeEFeX0x+1iYZb3XZnaqGac/sz4fF4l3Fw3diR4vniyjjrmSKpsrtDdqIyV66qpFM4kH/FwtT5KIw7w99bDj0sfa+hNtQLD9SsWMY8pgtGv6nuDM7TNedahSPmCmSRE+YKgOXxDyl4Z62YCB1roBQez6z0qMh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143627; c=relaxed/simple;
	bh=7uXYff/R4xEs2dtqwToxhzOjaflMcgu0xAQ7Ut93OX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq1j8iHuXEiLfTpx2gwXkgVkTF5ilxoaqEngw7mONGmqlq2aoJcT70xNPIf6K66Z0wfXv7VuV9mskM1Hj5GlzIKu0PgBbLjKJ6gft8Ha5DoyfA/trF6pjU1UdRni7TQcYbVf62gw1ogk4ucBkShtpWp5lUls22tAQsFISN1Ea7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBVIOu4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1468EC433C7;
	Thu, 25 Jan 2024 00:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706143627;
	bh=7uXYff/R4xEs2dtqwToxhzOjaflMcgu0xAQ7Ut93OX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eBVIOu4lr73PpyuZ9Nc9P9YCA+ZlH+w+t6vUa52YspA+1Pp1+f67/UPjKm7q1itSR
	 mDnyaFEG9BzZ5P0ObL9gIrXkR5+6R8hqa+vElUV9ZJF2Rez/PhMeyabtU9wX/a/yHS
	 Y24S5qNbdnXzGtv7+elAy6Kz2BaLqaqEH0LVdWFbmCFi7Kw2kfzx4BoZ3m8HcDSoKv
	 PLKobG5ebxUKZ7ZiUoQO7fa9ER5uZjnlKU/KVeWcBZANydKPeaw6CFDWFXhAtArxjn
	 SnHxjvleyXYB/cQEGUzmhoLLm8dZIw0SqedKaYSuL9kbF/UwKD84S6A7sdjBZvbroX
	 mXT4gjEzGrndw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51008c86ecbso2960729e87.2;
        Wed, 24 Jan 2024 16:47:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yw4Mex4tQPT8XDCPDZyKInrrrUjkAQIeUjv5NxQAj2q4djo3k7A
	t7enpf8eO5H57bSflp6HrWaAMcbqu3qbTQnqt5DaGY7A+Ay1Q4MvlN0ZcCbjeCxPHbdw9MPKTtt
	ZV/83bA3UhM4TqVMezSLI+B+wA94=
X-Google-Smtp-Source: AGHT+IFJd/5OFokGofwIuti+Q3VsaUDwODFAyvNiJuRTaF0KHeEvyQNXTmIPWfQCx9uB2vBVnOPuF+ycykoEledk+tc=
X-Received: by 2002:a19:ad45:0:b0:50e:50ac:2c84 with SMTP id
 s5-20020a19ad45000000b0050e50ac2c84mr40890lfd.51.1706143625241; Wed, 24 Jan
 2024 16:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124091421.1261579-1-yukuai3@huawei.com>
In-Reply-To: <20240124091421.1261579-1-yukuai3@huawei.com>
From: Song Liu <song@kernel.org>
Date: Wed, 24 Jan 2024 16:46:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4aqpQfQvBaeDaiJwOOOy-XspdDjAdvQVfFBEvHN-WUQA@mail.gmail.com>
Message-ID: <CAPhsuW4aqpQfQvBaeDaiJwOOOy-XspdDjAdvQVfFBEvHN-WUQA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] dm-raid: fix v6.7 regressions
To: Yu Kuai <yukuai3@huawei.com>, mpatocka@redhat.com, dm-devel@lists.linux.dev, 
	snitzer@kernel.org, agk@redhat.com
Cc: xni@redhat.com, jbrassow@f14.redhat.com, neilb@suse.de, heinzm@redhat.com, 
	shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:18=E2=80=AFAM Yu Kuai <yukuai3@huawei.com> wrote:
>
> First regression related to stop sync thread:
>
> The lifetime of sync_thread is designed as following:
>
> 1) Decide want to start sync_thread, set MD_RECOVERY_NEEDED, and wake up
> daemon thread;
> 2) Daemon thread detect that MD_RECOVERY_NEEDED is set, then set
> MD_RECOVERY_RUNNING and register sync_thread;
> 3) Execute md_do_sync() for the actual work, if it's done or
> interrupted, it will set MD_RECOVERY_DONE and wake up daemone thread;
> 4) Daemon thread detect that MD_RECOVERY_DONE is set, then clear
> MD_RECOVERY_RUNNING and unregister sync_thread;
>
> In v6.7, we fix md/raid to follow this design by commit f52f5c71f3d4
> ("md: fix stopping sync thread"), however, dm-raid is not considered at
> that time, and following test will hang:
>
> shell/integrity-caching.sh
> shell/lvconvert-raid-reshape.sh
>
> This patch set fix the broken test by patch 1-4;
>  - patch 1 fix that step 4) is broken by suspended array;
>  - patch 2 fix that step 4) is broken by read-only array;
>  - patch 3 fix that step 3) is broken that md_do_sync() doesn't set
>  MD_RECOVERY_DONE; Noted that this patch will introdece new problem that
>  data will be corrupted, which will be fixed in later patches.
>  - patch 4 fix that setp 1) is broken that sync_thread is register and
>  MD_RECOVERY_RUNNING is set directly;
>
> With patch 1-4, the above test won't hang anymore, however, the test
> will still fail and complain that ext4 is corrupted;
>
> Second regression related to frozen sync thread:
>
> Noted that for raid456, if reshape is interrupted, then call
> "pers->start_reshape" will corrupt data. This is because dm-raid rely on
> md_do_sync() doesn't set MD_RECOVERY_DONE so that new sync_thread won't
> be registered, and patch 3 just break this.
>
>  - Patch 5-6 fix this problem by interrupting reshape and frozen
>  sync_thread in dm_suspend(), then unfrozen and continue reshape in
> dm_resume(). It's verified that dm-raid tests won't complain that
> ext4 is corrupted anymore.
>  - Patch 7 fix the problem that raid_message() call
>  md_reap_sync_thread() directly, without holding 'reconfig_mutex'.
>
> Last regression related to dm-raid456 IO concurrent with reshape:
>
> For raid456, if reshape is still in progress, then IO across reshape
> position will wait for reshape to make progress. However, for dm-raid,
> in following cases reshape will never make progress hence IO will hang:
>
> 1) the array is read-only;
> 2) MD_RECOVERY_WAIT is set;
> 3) MD_RECOVERY_FROZEN is set;
>
> After commit c467e97f079f ("md/raid6: use valid sector values to determin=
e
> if an I/O should wait on the reshape") fix the problem that IO across
> reshape position doesn't wait for reshape, the dm-raid test
> shell/lvconvert-raid-reshape.sh start to hang at raid5_make_request().
>
> For md/raid, the problem doesn't exist because:
>
> 1) If array is read-only, it can switch to read-write by ioctl/sysfs;
> 2) md/raid never set MD_RECOVERY_WAIT;
> 3) If MD_RECOVERY_FROZEN is set, mddev_suspend() doesn't hold
>    'reconfig_mutex' anymore, it can be cleared and reshape can continue b=
y
>    sysfs api 'sync_action'.
>
> However, I'm not sure yet how to avoid the problem in dm-raid yet.
>
>  - patch 9-11 fix this problem by detecting the above 3 cases in
>  dm_suspend(), and fail those IO directly.
>
> If user really meet the IO error, then it means they're reading the wrong
> data before c467e97f079f. And it's safe to read/write the array after
> reshape make progress successfully.

c467e97f079f got back ported to stable kernels (6.6.13, for example). We
will need some fixes for them (to fix shell/lvconvert-raid-reshape.sh).

Mikulas and folks, please help review the analysis above and dm-raid
changes. The failure was triggered by c467e97f079f. However, the commit
is doing the right thing, so we really shouldn't revert it.

>
> Tests:
>
> I already run the following two tests many times and verified that they
> won't fail anymore:
>
> shell/integrity-caching.sh
> shell/lvconvert-raid-reshape.sh

shell/lvconvert-raid-reshape-linear_to_raid6-single-type.sh is failing
with upstream + this set. (I need to fix some trivial compilation errors,
which are probably last minute typos).

Thanks,
Song

