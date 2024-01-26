Return-Path: <linux-kernel+bounces-39453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9683D162
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D712910E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837E10EB;
	Fri, 26 Jan 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCEcaTNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05973633;
	Fri, 26 Jan 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228073; cv=none; b=gdMDdUscS2XhkMbvQeXQ9DUnE1/W9gyPQ9D+n54t2KHJZ4RW8zWnIJMkD5so9izeVkP7ii+FIGKN0saJw9286SspyzwtDRkMydFdVvzWnkbETWl2GNgBnBmL3nBQvqRcavRc9wmxyXDnRUm1EU9095u8sVvY7WcM3W7E3+dUdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228073; c=relaxed/simple;
	bh=Qm9TZuL9HTa2j4FLC1XOdPmC6N+VcY2tavBjeFAxuxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qShPzejpKniluvEa94TId9KMPVSwbhXdkKhwyh6Zn1pdG5s13xFLeKX2Bvm1WQlnwHU5YChS02kg0bOkfu3b1zGZ6SSB/cv4zDfc1tqzBhRopTjri//7yKtZdDFySA3yYuLUG75TvkRMr6WRdaz5mOe8xPBqDbS0Ph0qXFtzTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCEcaTNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D6C433F1;
	Fri, 26 Jan 2024 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706228072;
	bh=Qm9TZuL9HTa2j4FLC1XOdPmC6N+VcY2tavBjeFAxuxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eCEcaTNXiNSoEbAtz/bVrD+OPWQMdE8uaZ2TlIpTbOwFiQpLtLJLR54n5zKLQNlUi
	 SIO9KpHd1ukJQQKlt+k56I1yu8RFvzvLhLQ8JfiCRxLOv7sP4w6FgkeUwBG9COMoXb
	 0RMbAw5yObcGhcoIat1xX4W84AqswkumhvPb5u7/PVx9rPXGdh3qPAOY1ZCcTIR604
	 B6Loc6VuXEd6+RbyUcuMgUh750oxVHnRVlwMLQAQMEt0/WbiKmryDoeKcZhJdBcbT4
	 vbgfZXYm99Hj3ihk6XIiAHgE4aklieGb6fIjJGzU2OWRztUy0C2BJyi8nYSlY1IT59
	 9Cye0cSAZI40A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51021ba75edso1035268e87.3;
        Thu, 25 Jan 2024 16:14:32 -0800 (PST)
X-Gm-Message-State: AOJu0YwNMDNonu/5YSQPKRVnYm8Yh8/O+md9ZKURQfswmM3hN016BPLF
	ao0GXavwkiI4TsAVkeydEGAT5lqGFIE9yg1DNoVO10jugiTuAFfKkasacqy3khe5dz2sOxdKIlh
	OXMi9iNHORWJqSc/ETeSaTd/tldQ=
X-Google-Smtp-Source: AGHT+IED9CJWsDJSk49BPkNStrwuc6tSM4rMBKOHwZqetFqvJrPjTD8O/vlKnTlptPI5eCGjFtZBcMGLEwtLw1lUEyY=
X-Received: by 2002:a05:6512:3b2c:b0:50e:36ad:5f6e with SMTP id
 f44-20020a0565123b2c00b0050e36ad5f6emr344390lfv.20.1706228070641; Thu, 25 Jan
 2024 16:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124091421.1261579-1-yukuai3@huawei.com> <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww291wiYYMWuqUdDf1t7cKkHFs9gGQSRw+iPhUCsNv-Y6yg@mail.gmail.com>
In-Reply-To: <CALTww291wiYYMWuqUdDf1t7cKkHFs9gGQSRw+iPhUCsNv-Y6yg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 25 Jan 2024 16:14:18 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4kauNB8jAsXYjRohCBMDvY15y0CzzWYqzGvNsqAJ59jQ@mail.gmail.com>
Message-ID: <CAPhsuW4kauNB8jAsXYjRohCBMDvY15y0CzzWYqzGvNsqAJ59jQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Xiao Ni <xni@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com, 
	neilb@suse.de, heinzm@redhat.com, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Thu, Jan 25, 2024 at 5:33=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
>
> Hi all
>
> I build the kernel 6.7.0-rc8 with this patch set. The lvm2 regression
> test result:

I believe the patchset is built on top of upstream (6.8-rc1). There are
quite some md and dm changes between 6.7-rc8 and 6.8-rc1. Could
you please rerun the test on top of 6.8-rc1? Once we identify the right
set of fixes, we will see which ones to back port to older kernels.

Thanks,
Song

> ###       failed: [ndev-vanilla] shell/integrity.sh
> ###       failed: [ndev-vanilla] shell/lvchange-partial-raid10.sh
> ###       failed: [ndev-vanilla] shell/lvchange-raid-transient-failures.s=
h
> ###       failed: [ndev-vanilla] shell/lvchange-raid10.sh
> ###       failed: [ndev-vanilla] shell/lvchange-rebuild-raid.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-cache-abort.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid-regionsize.sh
> ###       failed: [ndev-vanilla]
> shell/lvconvert-raid-reshape-linear_to_raid6-single-type.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid-reshape.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid-takeover-alloc-fail=
ure.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid-takeover-thin.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid-takeover.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid0-striped.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid0_to_raid10.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid10.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-raid5_to_raid10.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-striped-raid0.sh
> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid10.sh
> ###       failed: [ndev-vanilla] shell/lvcreate-raid-nosync.sh
> ###       failed: [ndev-vanilla] shell/lvcreate-raid10.sh
> ###       failed: [ndev-vanilla] shell/lvdisplay-raid.sh
> ###       failed: [ndev-vanilla] shell/lvextend-thin-raid.sh
> ###       failed: [ndev-vanilla] shell/lvresize-fs-crypt.sh
> ###       failed: [ndev-vanilla] shell/lvresize-raid.sh
> ###       failed: [ndev-vanilla] shell/lvresize-raid10.sh
> ###       failed: [ndev-vanilla] shell/pvck-dump.sh
> ###       failed: [ndev-vanilla] shell/pvmove-raid-segtypes.sh
> ###       failed: [ndev-vanilla] shell/select-report.sh

