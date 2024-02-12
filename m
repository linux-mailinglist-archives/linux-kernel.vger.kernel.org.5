Return-Path: <linux-kernel+bounces-62484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B28D85217E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086E2284A00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6FE5026F;
	Mon, 12 Feb 2024 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFPQP32S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97394EB34;
	Mon, 12 Feb 2024 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777054; cv=none; b=u11+yf8YSjcjIXZDt4lVEDLrouV8L2JGGwJRkVSnPJZgiE8O1T5QSkHNYHYkKfpTyWt91xGOrwhfC7CwsdxYWreaGVJhkQg9s+IdFRyoPwYEYk2aqM1QJgpzOJNjfZH2H9h4/iSQ9NReN8Sayd67TIvJolMfbX9KM1Wr2lYo//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777054; c=relaxed/simple;
	bh=WUFOaH/E/iapfdXo1UGkJDI0yYCu7twt3pknV3Y1Ofs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL8/zJtBEXqMm0YMdck3YxuYL86HdH090pJE5fRtIOagvGdVEMCrE1y5hg3HwxOlFWMFiWm288OQkwa0NqM295wrh975HCnEq7pfLj3baa3Ny3V2wSIYjf90VtAUvur64WM5aht1OmdzfvxiGlytxuaV0iwplrXF1TmBpRboCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFPQP32S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26861C43330;
	Mon, 12 Feb 2024 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707777054;
	bh=WUFOaH/E/iapfdXo1UGkJDI0yYCu7twt3pknV3Y1Ofs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BFPQP32SbJ1BpBA9N/Whkpr9v4RpEwFF8czY0Tdx6ampGzAhJ/lNkc1GfAh4CxmCC
	 6NR989sCFFM5DviMD90MYj224CF97V/3zM8SY0Nj5UgHiob8nKQhgrBgaqLwwU0M5b
	 bru5V1eLDCLn4VyBkPOwPvIooDrPgYZDx2FqZqlwccfE1uWvU4QMAL1Zc4PXlbHbIV
	 I/HpMy4i9+rbIZADccgZjsiYKfJ7p/FvJK7fNvW50QEot+T3t0OXgXeOjb5Un71DC7
	 yZUh1kIdtgbPr2LfuZl9Vk+kw8IqSs//FuDRnrcoLOIMkRZbE2hWlAoGSYUP7zXrq3
	 sa8WjekVYQaTA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5116063585aso4665964e87.1;
        Mon, 12 Feb 2024 14:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhqCKtytViegyh5439GxQSpQrryRLwh9ikXc+ZtAth41spNtkFxNIDVhRLLP7fxIDLYj5WRgDqXqbx0J9xzqliTwhoKO+NywiCWK1vuUDM/0+2KylZJTXjGClFdMdhEENUWV+Wn1ASFQ==
X-Gm-Message-State: AOJu0YweY4GCBLfFl7Jdef8M9HlHe655tHcsSESpLzmsQvPyg4rF6CUX
	/ClPOS1RpT3dI0vkNVFnzx/sVrT9lo+2z+xssbbUYyXdOSfN1ViaA4nVmW9erb9nCVNa2N5To4f
	J8Z4YLXbWvQL3ClmwSZfvTBTrLgs=
X-Google-Smtp-Source: AGHT+IGk0Dtfb3kirEtedRS1LQrpCKzhyPrG0RTqqHWNmGkVvXtpYuVD2YnbtZMJW1WLP+kvcoEIXrb1fPsNGmFQD/M=
X-Received: by 2002:a05:6512:75:b0:511:4fae:ff9 with SMTP id
 i21-20020a056512007500b005114fae0ff9mr4547030lfo.39.1707777052111; Mon, 12
 Feb 2024 14:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 Feb 2024 14:30:40 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7AR4hEj7g3MaAgfsBNdOBtU8M-2gQdDz5hAzjbA=xfbQ@mail.gmail.com>
Message-ID: <CAPhsuW7AR4hEj7g3MaAgfsBNdOBtU8M-2gQdDz5hAzjbA=xfbQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, agk@redhat.com
Cc: heinzm@redhat.com, xni@redhat.com, blazej.kucman@linux.intel.com, 
	yukuai3@huawei.com, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, 
	akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, 
	"Luse, Paul E" <paul.e.luse@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikulas and DM folks,

This patchset looks good to me. Please help review the dm-raid code
so that we can ship it to 6.8 kernel and back port the fixes to 6.7
stable kernels.

In the longer term, we will invest more into a CI system and include the
lvm2 test suite as part of the tests. Hopefully, this effort will help us
catch similar issues much sooner.

Thanks,
Song

On Thu, Feb 1, 2024 at 1:30=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v5:
>  - remove the patch to wait for bio completion while removing dm disk;
>  - add patch 6;
>  - reorder the patches, patch 1-8 is for md/raid, and patch 9-14 is
>  related to dm-raid;
>
> Changes in v4:
>  - add patch 10 to fix a raid456 deadlock(for both md/raid and dm-raid);
>  - add patch 13 to wait for inflight IO completion while removing dm
>  device;
>
> Changes in v3:
>  - fix a problem in patch 5;
>  - add patch 12;
>
> Changes in v2:
>  - replace revert changes for dm-raid with real fixes;
>  - fix dm-raid5 deadlock that exist for a long time, this deadlock is
>  triggered because another problem is fixed in raid5, and instead of
>  deadlock, user will read wrong data before v6.7, patch 9-11;
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
>  MD_RECOVERY_RUNNING is set directly, md/raid behaviour, not related to
>  dm-raid;
>
> With patch 1-4, the above test won't hang anymore, however, the test
> will still fail and complain that ext4 is corrupted;
>
>
> Second regression is found by code review, interrupted reshape
> concurrent with IO can deadlock, patch 5;
>
>
> Third regression fix 'active_io' leakage, patch 6;
>
>
> The fifth regression related to frozen sync thread:
>
> Noted that for raid456, if reshape is interrupted, then call
> "pers->start_reshape" will corrupt data. And dm-raid rely on md_do_sync()
> doesn't set MD_RECOVERY_DONE so that new sync_thread won't be registered,
> and patch 3 just break this.
>
>  - Patch 9 fix this problem by interrupting reshape and frozen
>  sync_thread in dm_suspend(), then unfrozen and continue reshape in
> dm_resume(). It's verified that dm-raid tests won't complain that
> ext4 is corrupted anymore.
>  - Patch 10 fix the problem that raid_message() call
>  md_reap_sync_thread() directly, without holding 'reconfig_mutex'.
>
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
>  - patch 11,12 fix this problem by detecting the above 3 cases in
>  dm_suspend(), and fail those IO directly.
>
> If user really meet the IO error, then it means they're reading the wrong
> data before c467e97f079f. And it's safe to read/write the array after
> reshape make progress successfully.
>
> There are also some other minor changes: patch 8 and patch 12;
>
>
> Test result (for v4, I don't think it's necessary to test this patchset
> again for v5, except for a new fix, patch 6, which is tested separately,
> there are no other functional changes):
>
> I apply this patchset on top of v6.8-rc1, and run lvm2 tests suite with
> folling cmd for 24 round(for about 2 days):
>
> for t in `ls test/shell`; do
>         if cat test/shell/$t | grep raid &> /dev/null; then
>                 make check T=3Dshell/$t
>         fi
> done
>
> failed count                             failed test
>       1 ###       failed: [ndev-vanilla] shell/dmsecuretest.sh
>       1 ###       failed: [ndev-vanilla] shell/dmsetup-integrity-keys.sh
>       1 ###       failed: [ndev-vanilla] shell/dmsetup-keyring.sh
>       5 ###       failed: [ndev-vanilla] shell/duplicate-pvs-md0.sh
>       1 ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
>       2 ###       failed: [ndev-vanilla] shell/duplicate-vgnames.sh
>       1 ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
>       1 ###       failed: [ndev-vanilla] shell/integrity.sh
>       6 ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly=
sh
>       2 ###       failed: [ndev-vanilla] shell/lvchange-rebuild-raid.sh
>       5 ###       failed: [ndev-vanilla] shell/lvconvert-raid-reshape-str=
ipes-load-reload.sh
>       4 ###       failed: [ndev-vanilla] shell/lvconvert-raid-restripe-li=
near.sh
>       1 ###       failed: [ndev-vanilla] shell/lvconvert-raid1-split-trac=
kchanges.sh
>      20 ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
>      20 ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
>      24 ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
>
> And I ramdomly pick some tests verified by hand that these test will
> fail in v6.6 as well(not all tests):
>
> shell/lvextend-raid.sh
> shell/lvcreate-large-raid.sh
> shell/lvconvert-repair-raid.sh
> shell/lvchange-rebuild-raid.sh
> shell/lvchange-raid1-writemostly.sh
>
> Xiao Ni also test the last version on a real machine, see [1].
>
> [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=3D-8W5F52tJjHKSgrfU=
c1Z1ZAeRKHHA@mail.gmail.com/
>
> Yu Kuai (14):
>   md: don't ignore suspended array in md_check_recovery()
>   md: don't ignore read-only array in md_check_recovery()
>   md: make sure md_do_sync() will set MD_RECOVERY_DONE
>   md: don't register sync_thread for reshape directly
>   md: don't suspend the array for interrupted reshape
>   md: fix missing release of 'active_io' for flush
>   md: export helpers to stop sync_thread
>   md: export helper md_is_rdwr()
>   dm-raid: really frozen sync_thread during suspend
>   md/dm-raid: don't call md_reap_sync_thread() directly
>   dm-raid: add a new helper prepare_suspend() in md_personality
>   md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>     reshape
>   dm-raid: fix lockdep waring in "pers->hot_add_disk"
>   dm-raid: remove mddev_suspend/resume()
>
>  drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
>  drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
>  drivers/md/md.h      |  16 ++++++
>  drivers/md/raid10.c  |  16 +-----
>  drivers/md/raid5.c   |  61 +++++++++++----------
>  5 files changed, 192 insertions(+), 105 deletions(-)
>
> --
> 2.39.2
>
>

