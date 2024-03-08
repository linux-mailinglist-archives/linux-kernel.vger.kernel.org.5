Return-Path: <linux-kernel+bounces-97445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FB876AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19041C210D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1456776;
	Fri,  8 Mar 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl9s1mpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B854792;
	Fri,  8 Mar 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921799; cv=none; b=dkPWO5vN4j3lP/8dM+XClq2z8znycOVDZ1wsWYWj30LgD7Hd6x+SXb5Na7xMdymcLix+u9vvpbpo+1KqS2n7oYXdztDZuR7ByoZd7SHPdYiAYmOg4ao2G6ODuNpJtnEAhCWeQPB3INEj9JoNl16NNttt3q0LBtZAzov250Va+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921799; c=relaxed/simple;
	bh=ynk0RIbZahLH1X6UDA5NrHZBUAFBMJsppWEzwh0UKN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXu3EG3abuo/p1Hg46yhx9X6Yptxt4w7Do44wgNoAgClFjFOLmjwRWtPYA0po5qa+/lxLfJ7h4kBaFbpgTijaDAGsylPaQxA0K9FLtaBDd+r7bq4lsQ7eAs7VGHKJTtxOXwYLbfTyvecvBC6/CF7gHLqSG4kCLHI8ETusfnxR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl9s1mpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A90C43390;
	Fri,  8 Mar 2024 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709921798;
	bh=ynk0RIbZahLH1X6UDA5NrHZBUAFBMJsppWEzwh0UKN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dl9s1mpW426zxPvzH0bYAUpeNtQhHMOGok6BU/+bIsZxXRWFEXvkh6+kg+MO7TCiH
	 g+gQvNmxQSTY4YjuBb11OPdTKNJGKwJqG7limqyZUfESWNh9sJ6P1Zrz6vygucIxew
	 sxReij1QNXX3wJ1ub9zyOs+U3xCCh7iePT2JIL/SiUoGX6k/TI6gK/hM14qXwOcs/F
	 nDb2GSO07QThe9YPZ9VY20/lrnaSqprmoDkvYUGn4ub7ZDm+E8N5fgYQQclzwuqN3Y
	 7pvhI2EvMZ5SkY3YNYhLVgr+l1/OqqmXu2SZzQKUsI6tNVmHpLWGtlY4UFmc48nz1k
	 UrBnqMzPAbmxA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512f3e75391so2127222e87.2;
        Fri, 08 Mar 2024 10:16:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNZ3p5dgZpjXczSqr+BzBIla8ZekriENkjltoTh78w1TlIP7dGo/O1lZkeLm5b/ZoDUD4GVOwMuqaIdfOiTw4XcE9cW8xNWqaH/EXbHsi1tve5kibe+ML4WfTiYZ3AEBoZrFJDqDZ2rQ==
X-Gm-Message-State: AOJu0YzS7rsymj5wOTNUzVe2G6xtufthipxiho+yHKrhxjhmruARNzLz
	EoH5bqByo1vE7Lwb9EbjfpY1Cra0fAXgVHxDyZFRbCIn+E3wIIHR8uNqXKWWJDc8wTtm9GvsBXp
	AGQ/p2dFTgJtdWwlJp+Lt13h0GEo=
X-Google-Smtp-Source: AGHT+IHvTxzzSEHaEFqgLKeFyKdBKoqbHPYUR1IXdoRrbvIZmqCRO4Vvt5vUrwtAQceainIpVlYXsPea3RYzTgwULj8=
X-Received: by 2002:a05:6512:159d:b0:513:4705:a4f3 with SMTP id
 bp29-20020a056512159d00b005134705a4f3mr4767791lfb.65.1709921796512; Fri, 08
 Mar 2024 10:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308093726.1047420-1-yukuai1@huaweicloud.com> <lch3c5p36igfup7vzsagjfxwr3otefv4igr2qahxwc2fpsntrd@qoeo67iwxzvr>
In-Reply-To: <lch3c5p36igfup7vzsagjfxwr3otefv4igr2qahxwc2fpsntrd@qoeo67iwxzvr>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Mar 2024 10:16:25 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7mK3J6st9PG2tu6EjTmPK7cUqXX1JMRyvhKo8ehFWi+Q@mail.gmail.com>
Message-ID: <CAPhsuW7mK3J6st9PG2tu6EjTmPK7cUqXX1JMRyvhKo8ehFWi+Q@mail.gmail.com>
Subject: Re: [PATCH] raid1: fix use-after-free for original bio in raid1_write_request()
To: Coly Li <colyli@suse.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, xueshi.hu@smartx.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 6:29=E2=80=AFAM Coly Li <colyli@suse.de> wrote:
>
> On Fri, Mar 08, 2024 at 05:37:26PM +0800, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > r1_bio->bios[] is used to record new bios that will be issued to
> > underlying disks, however, in raid1_write_request(), r1_bio->bios[]
> > will set to the original bio temporarily. Meanwhile, if blocked rdev
> > is set, free_r1bio() will be called causing that all r1_bio->bios[]
> > to be freed:
> >
> > raid1_write_request()
> >  r1_bio =3D alloc_r1bio(mddev, bio); -> r1_bio->bios[] is NULL
> >  for (i =3D 0;  i < disks; i++) -> for each rdev in conf
> >   // first rdev is normal
> >   r1_bio->bios[0] =3D bio; -> set to original bio
> >   // second rdev is blocked
> >   if (test_bit(Blocked, &rdev->flags))
> >    break
> >
> >  if (blocked_rdev)
> >   free_r1bio()
> >    put_all_bios()
> >     bio_put(r1_bio->bios[0]) -> original bio is freed
> >
> > Test scripts:
> >
> > mdadm -CR /dev/md0 -l1 -n4 /dev/sd[abcd] --assume-clean
> > fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -bs=3D4k -numjo=
bs=3D1 \
> >     -iodepth=3D128 -name=3Dtest -direct=3D1
> > echo blocked > /sys/block/md0/md/rd2/state
> >
> > Test result:
> >
> > BUG bio-264 (Not tainted): Object already free
> > -----------------------------------------------------------------------=
------
> >
> > Allocated in mempool_alloc_slab+0x24/0x50 age=3D1 cpu=3D1 pid=3D869
> >  kmem_cache_alloc+0x324/0x480
> >  mempool_alloc_slab+0x24/0x50
> >  mempool_alloc+0x6e/0x220
> >  bio_alloc_bioset+0x1af/0x4d0
> >  blkdev_direct_IO+0x164/0x8a0
> >  blkdev_write_iter+0x309/0x440
> >  aio_write+0x139/0x2f0
> >  io_submit_one+0x5ca/0xb70
> >  __do_sys_io_submit+0x86/0x270
> >  __x64_sys_io_submit+0x22/0x30
> >  do_syscall_64+0xb1/0x210
> >  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> > Freed in mempool_free_slab+0x1f/0x30 age=3D1 cpu=3D1 pid=3D869
> >  kmem_cache_free+0x28c/0x550
> >  mempool_free_slab+0x1f/0x30
> >  mempool_free+0x40/0x100
> >  bio_free+0x59/0x80
> >  bio_put+0xf0/0x220
> >  free_r1bio+0x74/0xb0
> >  raid1_make_request+0xadf/0x1150
> >  md_handle_request+0xc7/0x3b0
> >  md_submit_bio+0x76/0x130
> >  __submit_bio+0xd8/0x1d0
> >  submit_bio_noacct_nocheck+0x1eb/0x5c0
> >  submit_bio_noacct+0x169/0xd40
> >  submit_bio+0xee/0x1d0
> >  blkdev_direct_IO+0x322/0x8a0
> >  blkdev_write_iter+0x309/0x440
> >  aio_write+0x139/0x2f0
> >
> > Since that bios for underlying disks are not allocated yet, fix this
> > problem by using mempool_free() directly to free the r1_bio.
> >
>
> Yes, the panic doesn't show up anymore with this patch.
>
> Thanks for the fixup.
>
>
> > Fixes: 992db13a4aee ("md/raid1: free the r1bio before waiting for block=
ed rdev")
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>
> Reported-and-tested-by: Coly Li <colyli@suse.de>

Applied to md-6.9. Thanks!

Song

