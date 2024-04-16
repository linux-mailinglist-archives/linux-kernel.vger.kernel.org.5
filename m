Return-Path: <linux-kernel+bounces-146405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079608A64DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F7B2190A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0984DE7;
	Tue, 16 Apr 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNraq+km"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0A78C68
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251868; cv=none; b=kosfUDjCrwgvD5qod3AuTTysGMxNRk896Pv9ja988Zoi8s68PfBct45vKvaMetsOF9lLMjeGZHtPVR3YdjL7Uecsw9u73YKOofanBVpDTQ9RToZYjOWuKaBnuL9SuTtvp56br8VRGVSj506zI8/HzfMgA8wYVAxam4T0DmEFPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251868; c=relaxed/simple;
	bh=wcyQ5gVyf+KKx9kuWHRyg4D2bhvtU+PMnIoNIeFRXbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qXPhYLQjd9YVpLpwrHwhQWyOuW+vutZx5kvZUhNkqAaeoUI8p9v4/mh6Fb62nqU7fGvn8mW5LsWLZe1PSfx6s8YcxfwMra+SjiFvZaYApZ84lxPttVXfi+BCQ9d4PJypWYBmPKpN09VCxtFAP4BlJ7cEIlu5T7OvHatZ+T8adBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNraq+km; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22f078f1aecso2509052fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713251866; x=1713856666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LBhWV67y6b0WgcIZ1Dkb9cu6NZAVWwfF3kgN+jwSeQ=;
        b=UNraq+kmPHd5rpvk+bYk80BqDIc/OMGa7mCBwgDxcJ02V4ZwbvJZnHf7hpMxTaW5Qz
         TaLLf5Zv+43l4rgeyFotcnrAYEF9d4ncd4JY0f1GBm4gziJoXRu27lifwLD0BXYRRr56
         R1AeF3nFvXpLgDuLXkRTFAck4gp2midu43h0X4RFel2kk+7lv9FtnXtLNU9SsCTJA2Lh
         5SXPT43BNbVO9N+elz/jDBQBE7q0OIF35FIsBwkglHrxL43xayjbK8Yagukp8wGU4Tbe
         8fkZc9NTL5L30Axx7zjTYXxMGkSk5g73+sLD8wNc7QwTyGrN6M/5y1bkAHdyMaG6eeRc
         61zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251866; x=1713856666;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LBhWV67y6b0WgcIZ1Dkb9cu6NZAVWwfF3kgN+jwSeQ=;
        b=fXdDKMTchk+H7XpjLJvk7qTqe0BLDhbHphXFeM0V0tbsbxnXGKShaYZXaD3OjK1fT7
         wPQumvkSk77XizYhOmw2od3xnmCEkgptTdb6/hbzPvyKNeKV/RVm0srG6mLSOVfWYtMx
         U88FXg/o+pNHg4oyFOFxF+TOjzlsMrzeL0RdQlbqgV99qygG4Mx5oamPUTUwb6qTQalg
         VDXauQv0pOh+iXQ91lYfXM5YDshHOfqkNIgppQxnHCkiQWS6auwNbtv2FGQ6JU76JwVd
         ewVhflR8UOs4WF3d0G6gP5qwDXpC8KHIGOkeznsyQy97Ug2kyTrXJCxewJmQlsIJi2hZ
         4pTg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXBwHUm4lZ9dXj32WEC6e7VrLp1WlsHRU+vFE6EiyOb9bg2eJ2Li4hiTdV4Pot5n/GXGIs9CEFMh6VXmJsJQBeNwf8qyj2QxhhJMr
X-Gm-Message-State: AOJu0YwXJJpu1AOE1OOlR/x8d58T/mq5qbjMPQNd5grN7auMnDLG07iP
	ckO7A4ahKlOH99MppAVGeUzckpoYb07JTDpTxxL0i/bVuNsaMb3e/e5KRACw
X-Google-Smtp-Source: AGHT+IHgv+eiaC3hjMju7rm9Qo7jLE7d9pZ+EJk4lWRkxaTVzSmh0SwpD32NoJ8kG1H43a01F3F4eQ==
X-Received: by 2002:a05:6870:7012:b0:22e:ca59:8faa with SMTP id u18-20020a056870701200b0022eca598faamr13780993oae.34.1713251866075;
        Tue, 16 Apr 2024 00:17:46 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id lr48-20020a056a0073b000b006e724ccdc3esm8340029pfb.55.2024.04.16.00.17.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Apr 2024 00:17:45 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 0/4] mm/filemap: optimize folio adding and splitting
Date: Tue, 16 Apr 2024 15:17:18 +0800
Message-ID: <20240416071722.45997-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently, at least 3 tree walks are needed for filemap folio adding if
the folio is previously evicted. One for getting the order of current slot,
one for ranged conflict check, and one for another order retrieving.
If a split is needed, more walks are needed.

This series is trying to merge these walks, and speed up filemap_add_folio,
I see a 7.5% - 12.5% performance gain for fio stress test.

So instead of doing multiple tree walks, do one optimism range check
with lock hold, and exit if raced with another insertion. If a shadow
exists, check it with a new xas_get_order helper before releasing the
lock to avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once. If it needs
to alloc and split, 3 walks are issued (One for first ranged
conflict check and order retrieving, one for the second check after
allocation, one for the insert after split).

Testing with 4K pages, in an 8G cgroup, with 16G brd as block device:

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
    --buffered=1 --ioengine=mmap --rw=randread --time_based \
    --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min= 1027, max= 3520, per=100.00%, avg=2445.02, stdev=18.90, samples=8691
iops        : min=263001, max=901288, avg=625924.36, stdev=4837.28, samples=8691

After (+7.3%):
bw (  MiB/s): min=  493, max= 3947, per=100.00%, avg=2625.56, stdev=25.74, samples=8651
iops        : min=126454, max=1010681, avg=672142.61, stdev=6590.48, samples=8651

Test result with THP (do a THP randread then switch to 4K page in hope it
issues a lot of splitting):

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap -thp=1 --readonly \
      --rw=randread --time_based --ramp_time=30s --runtime=10m \
      --group_reporting

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap \
      --rw=randread --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min= 4141, max=14202, per=100.00%, avg=7935.51, stdev=96.85, samples=18976
iops        : min= 1029, max= 3548, avg=1979.52, stdev=24.23, samples=18976·

READ: bw=4545B/s (4545B/s), 4545B/s-4545B/s (4545B/s-4545B/s), io=64.0KiB (65.5kB), run=14419-14419msec

After (+10.4%):
bw (  KiB/s): min= 4611, max=15370, per=100.00%, avg=8928.74, stdev=105.17, samples=19146
iops        : min= 1151, max= 3842, avg=2231.27, stdev=26.29, samples=19146

READ: bw=4635B/s (4635B/s), 4635B/s-4635B/s (4635B/s-4635B/s), io=64.0KiB (65.5kB), run=14137-14137msec

The performance is better for both 4K (+7.5%) and THP (+12.5%) cached read.

V3: https://lore.kernel.org/linux-mm/20240415171857.19244-1-ryncsn@gmail.com/
Updates from V3:
- Simplify comment, and fold in a sparse warning fix, as
  suggested by Matthew Wilcox.

V2: https://lore.kernel.org/lkml/20240325171405.99971-1-ryncsn@gmail.com/
Updates from V2:
- Fix the misusage of locks in test module:
  https://lore.kernel.org/oe-lkp/202404151046.448e2d6e-lkp@intel.com

V1: https://lore.kernel.org/lkml/20240319092733.4501-1-ryncsn@gmail.com/
Updates from V1:
- Collect Acks.
- Add tests for new xas_get_order and combined usage of xas_get_order with
  xas_for_each_conflict.
- Fix a memleak for patch 4/4 and modify the function in place instead
  of adding a new helper.
- Update benchmark, I forgot to drop cache and disable THP for pervious
  test, so the result was for mixed usaged of split and add. The result
  is even better now.

Kairui Song (4):
  mm/filemap: return early if failed to allocate memory for split
  mm/filemap: clean up hugetlb exclusion code
  lib/xarray: introduce a new helper xas_get_order
  mm/filemap: optimize filemap folio adding

 include/linux/xarray.h |  6 +++
 lib/test_xarray.c      | 93 ++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++--------
 mm/filemap.c           | 74 +++++++++++++++++++++------------
 4 files changed, 179 insertions(+), 43 deletions(-)

-- 
2.44.0


