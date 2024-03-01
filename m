Return-Path: <linux-kernel+bounces-89201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7C86EBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E02821F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC758ABA;
	Fri,  1 Mar 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP7Y4icl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1150275;
	Fri,  1 Mar 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332577; cv=none; b=jakl0ZxAkWF9rmzoCuH1HlWcWvEwHJNjAG91JkthOPGjqyT8tb/nAUf7q3DCAuBVbqIbwjNE0mVNqil9f37TYBzCPFM+fuirjbu5JS4nGIHtFDZftgrMrLlt7ZUfzXr1aH9N0YWntLEz3SaK/dsKzcUuLJIqxGdKC5gRNBco8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332577; c=relaxed/simple;
	bh=DDBABTEQnOqeqqECMxJZ/iSvNM2D0uYA2vJsSOOC7sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soZG5tAbaj/bYE1gGHFD/ChakJVmVMMHz54wKeD99iJcRMUv5KOAKI0fgsvAEBiiRW3DJzRAgFqCPi1LYY4T0Yw8S/uidn7/ylYN5hB+m5Sl+15LmMpzj9AphnY9BBlwjVOxNDQSz+qkbw4OnqdCPboXxB1ddEdneRFpumAv8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP7Y4icl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58299C433A6;
	Fri,  1 Mar 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709332577;
	bh=DDBABTEQnOqeqqECMxJZ/iSvNM2D0uYA2vJsSOOC7sM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rP7Y4iclffQD9N4geloyo5elmP+7ih4lth34w8OUrz4c1SxbvoPAgm1GrZzOUqNrU
	 8+V5uS6tYPf4NDKsYNQ3clpky7RgNtSoHY7VLHNhhi7sVHV5Fm8kq3o+TOYTjXtWcx
	 nygTCLXnx1Pq9rbjkqIqQXHyu7qiGsB6Rb2F4BmJZxtzhSnYA9keXsorr+D69Nse7/
	 YTqlvqzaNlCuGquBSQmB9P/a/WbgDxwWxIjFfA7cdTESPXdOUKImpIhBSBp7NQwWzV
	 DGUKUrW4pIoETOzI9YtauTBlwrzPshbn27ojPVBNU3UwGdIlFMZkWI5/9a5Tf+S0zx
	 VZc/wNkgIRByQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23d301452so27898151fa.1;
        Fri, 01 Mar 2024 14:36:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXp2XTfxPKrU8D48wvsbU4xyBR0H4jd89ckuwOXtT4ZNmDdobKihZtQUPz9wf10H/aI+u9XblbcT/3cOxxLCAu+zehSI124yNzkF2txuPVVQ2VOmk8N5jKQRguInn/8n6v1NfacxOb32Q==
X-Gm-Message-State: AOJu0YwW3GwBQrGV4rxXPKledjv8e0djlIHu3qqTHcduPCLF2Roo+Ito
	SLhmDDbob9OaWdMeS5aucQmdMVSw/scYRxAb0qdAf0sxiaGUsWkFlLEQkJ8XNy3P7N+DKOWwn3Q
	6E36XtwugSpZOG9ZalkWlQNxGAp8=
X-Google-Smtp-Source: AGHT+IGOCH2FAIGBKvHB6VwjnphoBNXo7u1B9bRGUUrE9L32hdS8YVf0SCFeVKb6RwWIQqkDVxssNaeFHcu5KVLytH8=
X-Received: by 2002:a19:f013:0:b0:512:9dee:44fe with SMTP id
 p19-20020a19f013000000b005129dee44femr2080076lfc.26.1709332575505; Fri, 01
 Mar 2024 14:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240301095657.662111-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 1 Mar 2024 14:36:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5B8EOakkqeewNL7jXHH-wa=7b=ko3zZ_zcigTV9ptCoA@mail.gmail.com>
Message-ID: <CAPhsuW5B8EOakkqeewNL7jXHH-wa=7b=ko3zZ_zcigTV9ptCoA@mail.gmail.com>
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc: zkabelac@redhat.com, xni@redhat.com, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, dm-devel@lists.linux.dev, yukuai3@huawei.com, 
	heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:03=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> link to part1: https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGem=
Dz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com/
>
> part1 contains fixes for deadlocks for stopping sync_thread
>
> This set contains fixes:
>  - reshape can start unexpected, cause data corruption, patch 1,5,6;
>  - deadlocks that reshape concurrent with IO, patch 8;
>  - a lockdep warning, patch 9;
>
> I'm runing lvm2 tests with following scripts with a few rounds now,
>
> for t in `ls test/shell`; do
>         if cat test/shell/$t | grep raid &> /dev/null; then
>                 make check T=3Dshell/$t
>         fi
> done
>
> There are no deadlock and no fs corrupt now, however, there are still fou=
r
> failed tests:
>
> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
>
> And failed reasons are the same:
>
> ## ERROR: The test started dmeventd (147856) unexpectedly
>
> I have no clue yet, and it seems other folks doesn't have this issue.
>
> Yu Kuai (9):
>   md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
>   md: export helpers to stop sync_thread
>   md: export helper md_is_rdwr()
>   md: add a new helper reshape_interrupted()
>   dm-raid: really frozen sync_thread during suspend
>   md/dm-raid: don't call md_reap_sync_thread() directly
>   dm-raid: add a new helper prepare_suspend() in md_personality
>   dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
>     concurrent with reshape
>   dm-raid: fix lockdep waring in "pers->hot_add_disk"

This set looks good to me and passes the tests: reshape tests from
lvm2, mdadm tests, and the reboot test that catches some issue in
Xiao's version.

DM folks, please help review and test this set. If it looks good, we
can route it either via the md tree (I am thinking about md-6.8
branch) or the dm tree.

CC Jens,

I understand it is already late in the release cycle for 6.8 kernel.
Please let us know your thoughts on this set. These patches fixes
a crash when running lvm2 tests that are related to md-raid
reshape.

Thanks,
Song

