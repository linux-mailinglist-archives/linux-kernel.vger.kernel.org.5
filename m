Return-Path: <linux-kernel+bounces-14677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FA8220A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882481C226B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773F156D0;
	Tue,  2 Jan 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYCA3Euf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C4156C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d409bcb0e7so31926065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218032; x=1704822832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8hA/72KITSlGftqc83O7J2ZNglP6mXl1Xu18eqxeHI=;
        b=PYCA3EufazMTcC21hYxbdZqKa08M4BYn1Um9vPJRS7a+7zO7eXCKaZ1rmOuCePkz12
         3RZPYyP3FySPe90yf8IXk0sOhDbPhIZUoTCV4k0Ro84Pb7YFZtMqcW8H58ezMCSp45Ae
         DUG90gAGBHfNSMzI5fsPoQZOuMXuD7qxjWkKKOMrhy4n0qOBSrEYwlhOnOPF0kQVZv8B
         MIEuxsWN3S2kYDGIjUwY2UrkkRL4lahBsX9P0x7ioGtVoGrEt3xAkotnU+Eez5+5BLs2
         MvRJZKuXBSwvianZda70EtjqwmujShTVSr1rWzmAOLZZi/7oFo9/jcx3x3mevZb2951v
         q9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218032; x=1704822832;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8hA/72KITSlGftqc83O7J2ZNglP6mXl1Xu18eqxeHI=;
        b=HcqIZZeG0roDIcalBNBvXneQEZsB+OTrbKpYR7ZEsyc64BxSZD4bzTXIuVmWDkzrJd
         vpOpBuL1r05n815uBPwSRFyCa92FzykJy5sZAsMN3GiDXdsRc7hzByTgrfkRb50u3ZBh
         1fY1jAt4Hutomt7qTRi4vtLP+nCC7prD95WAxD8zzPy5seQjRIfW1LznNJSEbL6DsqKT
         FEjqzfoLCW8rMwZQLGJ7FPWI/3DKbplPt+kIy89lnqGnJdkkDTv+8+7bnYCMCRF3vCyJ
         GWsW08Bkp5ukBVxp4YZ+TCRXAhWk3Rg7UIkQT5PsyF0J4SmbjSApHC0ttXwIDIUL5SvH
         rC/w==
X-Gm-Message-State: AOJu0YwPRd3oKCkrOUiMYWImquIAZsvb3oHLC+fb07ECw947xmOVaUnR
	LvC3rALWzepW7ILMyaODM3ATREE1nJWxbxpe
X-Google-Smtp-Source: AGHT+IEwPqnH6rm6GvjwS5rmDTNtvrSi/Q9MvKWuVpyN3fIKb/ncxZoEHKsqrw1LI+/pJpZD5Mb6lg==
X-Received: by 2002:a17:902:ea04:b0:1d4:55e0:bd0e with SMTP id s4-20020a170902ea0400b001d455e0bd0emr8204290plg.18.1704218032001;
        Tue, 02 Jan 2024 09:53:52 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.53.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:53:51 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/9] swapin refactor for optimization and unified readahead
Date: Wed,  3 Jan 2024 01:53:29 +0800
Message-ID: <20240102175338.62012-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series is rebased on latest mm-stable to avoid conflicts.

This series tries to unify and clean up the swapin path, introduce minor
optimization, and make both shmem swapoff make use of SWP_SYNCHRONOUS_IO
flag to skip readahead and swapcache for better performance.

1. Some benchmark for dropping readahead and swapcache for shmem with ZRAM:

- Single file sequence read:
  perf stat --repeat 20 dd if=/tmpfs/test of=/dev/null bs=1M count=8192
  (/tmpfs/test is a zero filled file, using brd as swap, 4G memcg limit)
  Before: 22.248 +- 0.549
  After:  22.021 +- 0.684 (-1.1%)

- Random read stress test:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs \
  --size=256m --ioengine=mmap --rw=randread --random_distribution=random \
  --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

  Before: 1818MiB/s
  After:  1888MiB/s (+3.85%)

- Zipf biased random read stress test:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs \
  --size=256m --ioengine=mmap --rw=randread --random_distribution=zipf:1.2 \
  --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

  Before: 31.1GiB/s
  After:  32.3GiB/s (+3.86%)

Previously, shmem always used cluster readahead, it doesn't help much even
for single sequence read, and for random stress tests, the performance is
better without it. In reality, due to memory and swap fragmentation cluster
read-head is less helpful for ZRAM.

2. Micro benchmark which use madvise to swap out 10G zero-filled data to
   ZRAM then read them in, shows a performance gain for swapin path:

Before: 11143285 us
After:  10692644 us (+4.1%)

3. Swap off an 10G ZRAM:

Before:
time swapoff /dev/zram0
real    0m12.337s
user    0m0.001s
sys     0m12.329s

After:
time swapoff /dev/zram0
real    0m9.728s
user    0m0.001s
sys     0m9.719s

This also clean up the path to apply a per swap device readahead
policy for all swapin paths.

V1: https://lkml.org/lkml/2023/11/19/296
Update from V1:
  - Rebased based on mm-unstable.
  - Remove behaviour changing patches, will submit in seperate series
    later.
  - Code style, naming and comments updates.
  - Thanks to Chris Li for very detailed and helpful review of V1. Thanks
    to Matthew Wilcox and Huang Ying for helpful suggestions.

Kairui Song (9):
  mm/swapfile.c: add back some comment
  mm/swap: move no readahead swapin code to a stand-alone helper
  mm/swap: avoid doing extra unlock error checks for direct swapin
  mm/swap: always account swapped in page into current memcg
  mm/swap: introduce swapin_entry for unified readahead policy
  mm/swap: also handle swapcache lookup in swapin_entry
  mm/swap: avoid a duplicated swap cache lookup for SWP_SYNCHRONOUS_IO
  mm/swap: introduce a helper for swapin without vmfault
  swap, shmem: use new swapin helper and skip readahead conditionally

 mm/memory.c     |  74 +++++++-------------------
 mm/shmem.c      |  67 +++++++++++------------
 mm/swap.h       |  39 ++++++++++----
 mm/swap_state.c | 138 +++++++++++++++++++++++++++++++++++++++++-------
 mm/swapfile.c   |  32 +++++------
 5 files changed, 218 insertions(+), 132 deletions(-)

-- 
2.43.0


