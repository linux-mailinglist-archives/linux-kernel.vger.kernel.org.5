Return-Path: <linux-kernel+bounces-30035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1570831833
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BE31C22DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630C241F5;
	Thu, 18 Jan 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7gdJb16"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8A20B1C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576266; cv=none; b=K+mqDMAkrqVK7EUkMEjZwZLkCzWS5TARm9FVBD8EFhK4L1VUUGfDEZe0RpjCkOQBxJ+cFY2y9jiyyLGbTjA458vEySBUQewaG7rJp5Ot/kI/j6Sq4uXVOQVj6CV4l5duqEgGSxrD/Pa3YxXjcjQZxm7BN2K0yMGGE4D1F5aXSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576266; c=relaxed/simple;
	bh=MRHRvuKE8pc+D3f1b42nfzYaXwOhFXgFU1guzsEssug=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=g2t8QjGKR5sGP7FyBgmRAlxI7QyhI+XIFWhkVIGGiJVxzo3o6ziZ5X5FST072ygTun2YO2zHE0771et9jhcu0wopfVXTmSExmIAEuDo5/nhJeymohgcgIIQMiB/SjTsJ4rHQ/JlR3kMitwryyZlzlBDLXvE/SwolknIyDmsGe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7gdJb16; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso4729010b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576264; x=1706181064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSY4Nm43lRTnU6AD88JOhWLYGY3O5OdAdVWfL2iISCI=;
        b=j7gdJb16FeJjcnQIWCK5wLTmoCVT2hvetgS6tBoSpAt+wpftIIdMKywY7aX+W9RxCs
         GSWbZpMivARunrranboT2J5vR1IaFesy91uIcIVrjwWoAQDuzC4jjELIr0fSd7ATKKHv
         vqxyBP4yLmEstJJyRIdbKLxP5VItFrtcvV0dw4Y+p/Qj/MQQsknhXji84bO5vfjXvC5y
         sKXulny+RRiJ6TT5Iwh3iiNDiqp7H/CEEagaxX9/5OtiK2bOKVMqBYy9hRG5mAJXp1O8
         4kgXAEYI4z0pmEHundH29AEUu6RIXBqVlUlxiTLmJoynIAW2AFoF3/+dIDLn531IcXgx
         d8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576264; x=1706181064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSY4Nm43lRTnU6AD88JOhWLYGY3O5OdAdVWfL2iISCI=;
        b=B7m7nVCySFQoLxnKCmxF9KFezV9tSbNOcVu4Lp9QKsvnurU3Ph1LJxlI0UDcXOjALz
         DB1ifxSt6PEET70lbdj12aKofyy0edbG9wB2s8b2LqNc1U44hpBY8cFI5WNJ7Osf0mzk
         6WJuf8gZBT0jGqq2sN9nPhieyedc3oh1+wY+QVhSFucAtLP/P/1LjL7GgJrV2uW87daq
         XRJTRqqa4+uExUzIyOiDSAVwpA+dSb1HFKY7tGJNXbkrRnwuINjmDPSdetDcIONDKTaO
         +IcGgexaWpisuuj/dtdrhIN0fmcGG2P9jVCafc+QnXREObmIBJt8NQrIXBqgQvSdCr/+
         OmOw==
X-Gm-Message-State: AOJu0YzB2i4JPanoD57TZ8nI+0SYc3s01g7CAJL56YKlj628Bv3B3Tgr
	cHbRvsYQTjMQp5cHijXtWRHijX/vMhiRBNzxBqJXYHkF0fjxm2UL
X-Google-Smtp-Source: AGHT+IFGQGetHNHNcrVpJS0z9Hnh5gf6XgUI/KzMNMt8azUpdCJ3s6lHtwWV6MPeYa/gRhoS7M5+YQ==
X-Received: by 2002:a05:6a00:a0f:b0:6da:d8c8:f2ad with SMTP id p15-20020a056a000a0f00b006dad8c8f2admr506148pfh.43.1705576264085;
        Thu, 18 Jan 2024 03:11:04 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:11:03 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Barry Song <21cnbao@gmail.com>
Subject: [PATCH RFC 0/6] mm: support large folios swap-in
Date: Fri, 19 Jan 2024 00:10:30 +1300
Message-Id: <20240118111036.72641-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025144546.577640-1-ryan.roberts@arm.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an embedded system like Android, more than half of anon memory is actually
in swap devices such as zRAM. For example, while an app is switched to back-
ground, its most memory might be swapped-out.

Now we have mTHP features, unfortunately, if we don't support large folios
swap-in, once those large folios are swapped-out, we immediately lose the 
performance gain we can get through large folios and hardware optimization
such as CONT-PTE.

In theory, we don't need to rely on Ryan's swap out patchset[1]. That is to say,
before swap-out, if some memory were normal pages, but when swapping in, we
can also swap-in them as large folios. But this might require I/O happen at
some random places in swap devices. So we limit the large folios swap-in to
those areas which were large folios before swapping-out, aka, swaps are also
contiguous in hardware. On the other hand, in OPPO's product, we've deployed
anon large folios on millions of phones[2]. we enhanced zsmalloc and zRAM to
compress and decompress large folios as a whole, which help improve compression
ratio and decrease CPU consumption significantly. In zsmalloc and zRAM we can
save large objects whose original size are 64KiB for example. So it is also a
better choice for us to only swap-in large folios for those compressed large
objects as a large folio can be decompressed all together.

Note I am moving my previous "arm64: mm: swap: support THP_SWAP on hardware
with MTE" to this series as it might help review.

[1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
[2] OnePlusOSS / android_kernel_oneplus_sm8550 
https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11

Barry Song (2):
  arm64: mm: swap: support THP_SWAP on hardware with MTE
  mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()

Chuanhua Han (4):
  mm: swap: introduce swap_nr_free() for batched swap_free()
  mm: swap: make should_try_to_free_swap() support large-folio
  mm: support large folios swapin as a whole
  mm: madvise: don't split mTHP for MADV_PAGEOUT

 arch/arm64/include/asm/pgtable.h |  21 ++----
 arch/arm64/mm/mteswap.c          |  42 ++++++++++++
 include/asm-generic/tlb.h        |  10 +++
 include/linux/huge_mm.h          |  12 ----
 include/linux/pgtable.h          |  62 ++++++++++++++++-
 include/linux/swap.h             |   6 ++
 mm/madvise.c                     |  48 ++++++++++++++
 mm/memory.c                      | 110 ++++++++++++++++++++++++++-----
 mm/page_io.c                     |   2 +-
 mm/rmap.c                        |   5 +-
 mm/swap_slots.c                  |   2 +-
 mm/swapfile.c                    |  29 ++++++++
 12 files changed, 301 insertions(+), 48 deletions(-)

-- 
2.34.1


