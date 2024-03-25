Return-Path: <linux-kernel+bounces-117556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1988AC93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C664A291BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4849C13D52B;
	Mon, 25 Mar 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1XULaXC"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A9131182
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386853; cv=none; b=Y7X2hU9i75r7t0boYb88pVT7VTUt8X5VJ7AjpzkGNW0VPSw9vqvCEt6xX6vucLP9sBQot9/CpQBD8KjBOWBZ00XoVpUE/syw3D5fhwoiBfXvg3u9J7RdYf2/HcEig9HzHgcdo9L33Vv9s4EN3Jx6L3+AH+SD8b5ZtzS+I/yVe6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386853; c=relaxed/simple;
	bh=LvkVT3BzkodtYUYRK6OcCV4S1qFK2Q6KT1ppRACN4BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=edF7gd7++SjL/P3hsNglt99hHTHN0XOWjdrYo7uNlv4sqT+w1vG17WLaN7/94g6p4UDolQeWI9ufZiDVaCck8Mc7mmdlTZoKbFrS/4wJGkFH3cPy/eftF3YRAGrN2EK/3pKfmVl6OmNi2fmxrRm1RyhAIaaHONpjGoex/HOgxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1XULaXC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1696747b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386851; x=1711991651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hD4pKr1Z3PiNKpEy3DKOk6KxCoRm3Zwe+f8OfrIAeqY=;
        b=g1XULaXCI7E9cdWL5PXSrZ++NsNDgYDCRsOM4nCg7AfawwiPAesfilQsSqx27GfSK3
         7C7ARAsAjKRNYZ2bPNIIcp6s47APlSODTMULopqCX/FhaJYqgITFGliRYRFcrL4fhG3W
         c2K0iux7qL7tXEBliSBMMCTkKLpcKAJ3SbDPmo+hpQUKQ4kd1CUzFplH5Hf01VEsAGGj
         tMA17ii3nvobuBZiWILDPHycVjEaqJrO3L/1cSEQQxwJO1oi+oaF2Y4D9XjcKo00QWVV
         It0bRxafwGcYW+ccXEXXUYUgokEtCoq5N/RpOH/guK39CeDxOz6GmiiSqST7mr5Yq1bD
         JDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386851; x=1711991651;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD4pKr1Z3PiNKpEy3DKOk6KxCoRm3Zwe+f8OfrIAeqY=;
        b=Yi/rTHeC3tRv8ckeASETLv8BDwr3hgbiEq9hMJ8gF/cew6yg/enV7LFBQePETjIuKP
         mjaocmXOO8nVqpJ2bqr+CHKv7nHgF9X4WgcbJEFS176YGQKYYz2cXbe4R3jmrkAWPaOR
         EdCHpM2y/CNb4mcoXER8kE46J9jAFlXRxIFX5qfY9uV/5f1gpjCJfpDItbdtKfOqFT9z
         3cVCb2pQanURDlVkeCrYwRprRvcA5vNNinfEmsW5hXOPUXb3zvo3oPfYIH6DDfmx7FjW
         ddTRpJL4OYq+XusSUO3mu6E/GMql3Nb22LxdwwbZVEcMJR24OY36xb6GpFVE+AzpEIWk
         1mKg==
X-Forwarded-Encrypted: i=1; AJvYcCVVul+Gnfqo2WoYS/FJfZFRQmLCzocji+ls8LSnXODsgfrK6GmEe3zFkF413nU/nkHhvGbNo/Owt7aAiLRC5mUXI6GcsPnSR3b337JT
X-Gm-Message-State: AOJu0YwFCUH6NIZss7O8V/rt5ixsRVkLvKxwCF2d2meyVzvdTczrmEvO
	BbEJLBMM7CtDxivnY94TtlTaueNjzMcTOspE9ss+7j2z30rcZB3G
X-Google-Smtp-Source: AGHT+IElg2PDhkm5P/uKexHiLvmcCdc6JAPhGRD2O5JRmQJNtKe/5yqqSCz31qjWUuKmGJuciTnp5g==
X-Received: by 2002:a05:6a20:8f07:b0:1a3:5920:ae9f with SMTP id b7-20020a056a208f0700b001a35920ae9fmr9155255pzk.2.1711386851022;
        Mon, 25 Mar 2024 10:14:11 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id r16-20020a63d910000000b005dc5129ba9dsm6001812pgg.72.2024.03.25.10.14.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Mar 2024 10:14:10 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/4] mm/filemap: optimize folio adding and splitting
Date: Tue, 26 Mar 2024 01:14:01 +0800
Message-ID: <20240325171405.99971-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 lib/test_xarray.c      | 89 ++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++---------
 mm/filemap.c           | 74 +++++++++++++++++++++++------------
 4 files changed, 175 insertions(+), 43 deletions(-)

-- 
2.43.0


