Return-Path: <linux-kernel+bounces-433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3281410F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF88B22027
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E75697;
	Fri, 15 Dec 2023 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRznM/id"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A38CA66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35f69467104so41815ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702616202; x=1703221002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K/dX0zLfI/nY6VbbThOBImXbjKTVQzpJ9vw0Og0/5Rw=;
        b=CRznM/idvEVCF/Sc8cCr2NvMh5LZu25awLnbQp3b+U/B+XmSrblQ0FF3PXY2PQC1/n
         HfPvd1OnjuyzY0zZMGSmbed6QG1QyVP0xCB2BGTJ7BvxrPMJ25f29VyAVC3o/LOxglLd
         RwCDrAU95hnUYate0LZNAp71Nst30D4Wjqgi2QVRlkkjnj70XTmBruSECbvTMyGSH0TF
         A2umSyFIT0Dj/BUD5IX8X/0a/pV6Y1M30ojS+9seEf4fKB/fGQT4X9bSzX+uE/YKsDvK
         HaaCkD95EAookdcQXL0gJRS8b4kd1ShL83dP9LgOofstQjcNHxgVJu8F+8LxSE8570NL
         Ol0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702616202; x=1703221002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/dX0zLfI/nY6VbbThOBImXbjKTVQzpJ9vw0Og0/5Rw=;
        b=clGenN2fyuP8iO/X1GVHRv+D5b9LZ5xNlUz7K4xqP04XE1TQFw/Rz9LDy3fIp2HcU6
         k+daWZO5NAV5nyfEpWB7ZariIxerI6j574byOx7DrJPo53F0liSKvP2s3SNWfWLNFxWx
         5tgfdLkBUjn3XkYAoBPw+dS34i+y8Iwi0z/+LW7NfF9fMfvVOgE3FErKi75TMHWSkXNb
         IjFUjAd4+tY5HQnmCss3VhnxaoR3vmWf5Lp3RWtsZoHkHahW7K+igcofT3m4On/kBmLN
         gRc0B4Pm27dHIF35HCwJa2Vr87w4af1UDuOJbTDGdayaTeBXbk0KYz2MD9gZarYI/fHA
         ooIg==
X-Gm-Message-State: AOJu0Yx3jetm7XJg2PvRf8KcWEZ0aZLzWegJUypSZfbHtWIhixdURC5O
	mq2E7KOeATWO1VZCfS6X5zTYUQ==
X-Google-Smtp-Source: AGHT+IHa4SGtu+L9um4Z3Ybj/jcb+iPdbzMXlKaN5QRN7Ieo6NlURYk4znSVPuTBesP0DgZnrFNTOw==
X-Received: by 2002:a92:d209:0:b0:35f:7cfd:c5d0 with SMTP id y9-20020a92d209000000b0035f7cfdc5d0mr404085ily.22.1702616201352;
        Thu, 14 Dec 2023 20:56:41 -0800 (PST)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id bu13-20020a056e02350d00b0035d70b70d1csm4562636ilb.2.2023.12.14.20.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 20:56:40 -0800 (PST)
Date: Thu, 14 Dec 2023 21:56:35 -0700
From: Yu Zhao <yuzhao@google.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page
 cache
Message-ID: <ZXvcgyjTu92Qqk5X@google.com>
References: <20231208061407.2125867-1-yuzhao@google.com>
 <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
 <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
 <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
 <CAOUHufa=ybd-EPos9DryLHYyhphN0P7qyV5NY3Pui0dfVSk9tQ@mail.gmail.com>
 <ZXpx0K8Vdo3FJixg@google.com>
 <CAMgjq7CRf4iEKuW2qWKzbhssMbixBo3UoLPqsSk4b+Tvw8at8A@mail.gmail.com>
 <CAOUHufY6x_Erz02Bzoejfs_g2hcmrMFpiOdjiaWZ97oirz71aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufY6x_Erz02Bzoejfs_g2hcmrMFpiOdjiaWZ97oirz71aQ@mail.gmail.com>

On Thu, Dec 14, 2023 at 04:51:00PM -0700, Yu Zhao wrote:
> On Thu, Dec 14, 2023 at 11:38 AM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > Yu Zhao <yuzhao@google.com> 于2023年12月14日周四 11:09写道：
> > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu Zhao wrote:
> > > > On Tue, Dec 12, 2023 at 8:03 PM Kairui Song <ryncsn@gmail.com> wrote:
> > > > >
> > > > > Kairui Song <ryncsn@gmail.com> 于2023年12月12日周二 14:52写道：
> > > > > >
> > > > > > Yu Zhao <yuzhao@google.com> 于2023年12月12日周二 06:07写道：
> > > > > > >
> > > > > > > On Fri, Dec 8, 2023 at 1:24 AM Kairui Song <ryncsn@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Yu Zhao <yuzhao@google.com> 于2023年12月8日周五 14:14写道：
> > > > > > > > >
> > > > > > > > > Unmapped folios accessed through file descriptors can be
> > > > > > > > > underprotected. Those folios are added to the oldest generation based
> > > > > > > > > on:
> > > > > > > > > 1. The fact that they are less costly to reclaim (no need to walk the
> > > > > > > > >    rmap and flush the TLB) and have less impact on performance (don't
> > > > > > > > >    cause major PFs and can be non-blocking if needed again).
> > > > > > > > > 2. The observation that they are likely to be single-use. E.g., for
> > > > > > > > >    client use cases like Android, its apps parse configuration files
> > > > > > > > >    and store the data in heap (anon); for server use cases like MySQL,
> > > > > > > > >    it reads from InnoDB files and holds the cached data for tables in
> > > > > > > > >    buffer pools (anon).
> > > > > > > > >
> > > > > > > > > However, the oldest generation can be very short lived, and if so, it
> > > > > > > > > doesn't provide the PID controller with enough time to respond to a
> > > > > > > > > surge of refaults. (Note that the PID controller uses weighted
> > > > > > > > > refaults and those from evicted generations only take a half of the
> > > > > > > > > whole weight.) In other words, for a short lived generation, the
> > > > > > > > > moving average smooths out the spike quickly.
> > > > > > > > >
> > > > > > > > > To fix the problem:
> > > > > > > > > 1. For folios that are already on LRU, if they can be beyond the
> > > > > > > > >    tracking range of tiers, i.e., five accesses through file
> > > > > > > > >    descriptors, move them to the second oldest generation to give them
> > > > > > > > >    more time to age. (Note that tiers are used by the PID controller
> > > > > > > > >    to statistically determine whether folios accessed multiple times
> > > > > > > > >    through file descriptors are worth protecting.)
> > > > > > > > > 2. When adding unmapped folios to LRU, adjust the placement of them so
> > > > > > > > >    that they are not too close to the tail. The effect of this is
> > > > > > > > >    similar to the above.
> > > > > > > > >
> > > > > > > > > On Android, launching 55 apps sequentially:
> > > > > > > > >                            Before     After      Change
> > > > > > > > >   workingset_refault_anon  25641024   25598972   0%
> > > > > > > > >   workingset_refault_file  115016834  106178438  -8%
> > > > > > > >
> > > > > > > > Hi Yu,
> > > > > > > >
> > > > > > > > Thanks you for your amazing works on MGLRU.
> > > > > > > >
> > > > > > > > I believe this is the similar issue I was trying to resolve previously:
> > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > The idea is to use refault distance to decide if the page should be
> > > > > > > > place in oldest generation or some other gen, which per my test,
> > > > > > > > worked very well, and we have been using refault distance for MGLRU in
> > > > > > > > multiple workloads.
> > > > > > > >
> > > > > > > > There are a few issues left in my previous RFC series, like anon pages
> > > > > > > > in MGLRU shouldn't be considered, I wanted to collect feedback or test
> > > > > > > > cases, but unfortunately it seems didn't get too much attention
> > > > > > > > upstream.
> > > > > > > >
> > > > > > > > I think both this patch and my previous series are for solving the
> > > > > > > > file pages underpertected issue, and I did a quick test using this
> > > > > > > > series, for mongodb test, refault distance seems still a better
> > > > > > > > solution (I'm not saying these two optimization are mutually exclusive
> > > > > > > > though, just they do have some conflicts in implementation and solving
> > > > > > > > similar problem):
> > > > > > > >
> > > > > > > > Previous result:
> > > > > > > > ==================================================================
> > > > > > > > Execution Results after 905 seconds
> > > > > > > > ------------------------------------------------------------------
> > > > > > > >                   Executed        Time (µs)       Rate
> > > > > > > >   STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
> > > > > > > > ------------------------------------------------------------------
> > > > > > > >   TOTAL           2542            27121571486.2   0.09 txn/s
> > > > > > > >
> > > > > > > > This patch:
> > > > > > > > ==================================================================
> > > > > > > > Execution Results after 900 seconds
> > > > > > > > ------------------------------------------------------------------
> > > > > > > >                   Executed        Time (µs)       Rate
> > > > > > > >   STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
> > > > > > > > ------------------------------------------------------------------
> > > > > > > >   TOTAL           1594            27061522574.4   0.06 txn/s
> > > > > > > >
> > > > > > > > Unpatched version is always around ~500.
> > > > > > >
> > > > > > > Thanks for the test results!
> > > > > > >
> > > > > > > > I think there are a few points here:
> > > > > > > > - Refault distance make use of page shadow so it can better
> > > > > > > > distinguish evicted pages of different access pattern (re-access
> > > > > > > > distance).
> > > > > > > > - Throttled refault distance can help hold part of workingset when
> > > > > > > > memory is too small to hold the whole workingset.
> > > > > > > >
> > > > > > > > So maybe part of this patch and the bits of previous series can be
> > > > > > > > combined to work better on this issue, how do you think?
> > > > > > >
> > > > > > > I'll try to find some time this week to look at your RFC. It'd be a
> > > > >
> > > > > Hi Yu,
> > > > >
> > > > > I'm working on V4 of the RFC now, which just update some comments, and
> > > > > skip anon page re-activation in refault path for mglru which was not
> > > > > very helpful, only some tiny adjustment.
> > > > > And I found it easier to test with fio, using following test script:
> > > > >
> > > > > #!/bin/bash
> > > > > swapoff -a
> > > > >
> > > > > modprobe brd rd_nr=1 rd_size=16777216
> > > > > mkfs.ext4 /dev/ram0
> > > > > mount /dev/ram0 /mnt
> > > > >
> > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > cd /sys/fs/cgroup/benchmark
> > > > >
> > > > > echo 4G > memory.max
> > > > > echo $$ > cgroup.procs
> > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > >
> > > > > fio -name=mglru --numjobs=12 --directory=/mnt --size=1024m \
> > > > >           --buffered=1 --ioengine=io_uring --iodepth=128 \
> > > > >           --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
> > > > >           --rw=randread --random_distribution=zipf:0.5 --norandommap \
> > > > >           --time_based --ramp_time=5m --runtime=5m --group_reporting
> > > > >
> > > > > zipf:0.5 is used here to simulate a cached read with slight bias
> > > > > towards certain pages.
> > > > > Unpatched 6.7-rc4:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=6548MiB/s (6866MB/s), 6548MiB/s-6548MiB/s
> > > > > (6866MB/s-6866MB/s), io=1918GiB (2060GB), run=300001-300001msec
> > > > >
> > > > > Patched with RFC v4:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=7270MiB/s (7623MB/s), 7270MiB/s-7270MiB/s
> > > > > (7623MB/s-7623MB/s), io=2130GiB (2287GB), run=300001-300001msec
> > > > >
> > > > > Patched with this series:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=7098MiB/s (7442MB/s), 7098MiB/s-7098MiB/s
> > > > > (7442MB/s-7442MB/s), io=2079GiB (2233GB), run=300002-300002msec
> > > > >
> > > > > MGLRU off:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=6525MiB/s (6842MB/s), 6525MiB/s-6525MiB/s
> > > > > (6842MB/s-6842MB/s), io=1912GiB (2052GB), run=300002-300002msec
> > > > >
> > > > > - If I change zipf:0.5 to random:
> > > > > Unpatched 6.7-rc4:
> > > > > Patched with this series:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=5975MiB/s (6265MB/s), 5975MiB/s-5975MiB/s
> > > > > (6265MB/s-6265MB/s), io=1750GiB (1879GB), run=300002-300002msec
> > > > >
> > > > > Patched with RFC v4:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=5987MiB/s (6278MB/s), 5987MiB/s-5987MiB/s
> > > > > (6278MB/s-6278MB/s), io=1754GiB (1883GB), run=300001-300001msec
> > > > >
> > > > > Patched with this series:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=5839MiB/s (6123MB/s), 5839MiB/s-5839MiB/s
> > > > > (6123MB/s-6123MB/s), io=1711GiB (1837GB), run=300001-300001msec
> > > > >
> > > > > MGLRU off:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s
> > > > > (5965MB/s-5965MB/s), io=1667GiB (1790GB), run=300003-300003msec
> > > > >
> > > > > fio uses ramdisk so LRU accuracy will have smaller impact. The Mongodb
> > > > > test I provided before uses a SATA SSD so it will have a much higher
> > > > > impact. I'll provides a script to setup the test case and run it, it's
> > > > > more complex to setup than fio since involving setting up multiple
> > > > > replicas and auth and hundreds of GB of test fixtures, I'm currently
> > > > > occupied by some other tasks but will try best to send them out as
> > > > > soon as possible.
> > > >
> > > > Thanks! Apparently your RFC did show better IOPS with both access
> > > > patterns, which was a surprise to me because it had higher refaults
> > > > and usually higher refautls result in worse performance.

And thanks for providing the refaults I requested for -- your data
below confirms what I mentioned above:

For fio:
                           Your RFC   This series   Change
  workingset_refault_file  628192729  596790506     -5%
  IOPS                     1862k      1830k         -2%

For MongoDB:
                           Your RFC   This series   Change
  workingset_refault_anon  10512      35277         +30%
  workingset_refault_file  22751782   20335355      -11%
  total                    22762294   20370632      -11%
  TPS                      0.09       0.06          -33%

For MongoDB, this series should be a big win (but apparently it's not),
especially when using zram, since an anon refault should be a lot
cheaper than a file refault.

So, I'm baffled...

One important detail I forgot to mention: based on your data from
lru_gen_full, I think there is another difference between our Kconfigs:

                  Your Kconfig  My Kconfig  Max possible
  LRU_REFS_WIDTH  1             2           2

This means you can only track 3 accesses through file descriptors
at most, and when you hit 3, the folio is moved to the next generation
by sort_folio() in the eviction path. IOW, your aging runs faster than
mine sine more folios are moved to the next generation (mine only does
so when it hits 5).

In case you want to try a larger LRU_REFS_WIDTH, you can make
CONFIG_NODES_SHIFT smaller or disable CONFIG_IDLE_PAGE_TRACKING.

