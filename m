Return-Path: <linux-kernel+bounces-31680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E4833277
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A211F221BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450715C5;
	Sat, 20 Jan 2024 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L76Wp16h"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD917ECD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705718414; cv=none; b=pK5KsUFKfZysHzk7TBLb30briC1WknYLpp62J14mUTx3pw8NaC2vA3atGoOQjsokuW+y0ohUp84G49JgUvERHtxvoJuEM5mj2eCQ8RxDWjtmnBqCAedTE+UQIR4jzipCq/1hA+saX8TuRN5ZfOjY6crRHmHoIytDG/tfIua+RvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705718414; c=relaxed/simple;
	bh=m4diYmOYVKLGCGrK9Hsr0ffU5nNLz7Mrao6JAX5cFng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gxYRVjwcUkJraysA9LjkDoh6gLbgPof0pyY1ECPd+3TpDiu7bYCTBCOfMAQUaBlpwNCHRh+3JsNfcAhQQOlNflkxuZQ4TMrNxJ64S2tVrqiZJu9X+aSdnd+xZWa3MV23ldjUs4SW8UHDm3rLnUX8hwcO4H5mXbvvKba9B4Lzkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L76Wp16h; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f325796097so28524447b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705718411; x=1706323211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rd1qGVyD1ykzuzHvmAyHpTUAK3rrqoLF0G2J9vWoPEg=;
        b=L76Wp16hCxW7Rd+K1UvDEzPstAQu1U3L3gMmT+uhK6W81sTGaZeV6gSvqfaxZvBUt3
         B4kZtEtbqrp1954fC+aVNK/95JHN8yRX7k7sf79471mNCLkDEQQ1HW28fu8JnfHKjPWj
         oPaKNMIgrb4Hu7TG7cF33Xf5YNDc44NhAgdAEC8rfr2yHlZuUAkksmwdVakd4jm1r7Gl
         3XKM3J+GKdYGUccFj1ANaUtoc16526nY3m/eck4txPFB3EEmd1h/PqTGDjYPUcmQC+V+
         uNxgxrcJvA9uzh85IR+WRt/UXi0MQVhfil+nc3hwGABP1LzWUAo5kNaJgoMWgB1WnTr3
         FchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705718411; x=1706323211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rd1qGVyD1ykzuzHvmAyHpTUAK3rrqoLF0G2J9vWoPEg=;
        b=CV8kDUfpAYtUMpWqJ86O20dzzyf3Fs741vSg6zbkk0HTxCKfQw+Z4ceGVm/AvwYvt+
         r6mvdNRlxYDJjD0MwA5QyniXfmf8mRrS9B2F3wAmRF0Snc2p4H8zBj3YXIe4eF8vEkQh
         Ti7wU59kP8NSDRDfyoxfBKKWateK6O5nZSn2GN4keGszCoQv8L3ffgNO1+JU6yB+Mu4k
         EWn3YHzdz3ww1KSMe1xgk8CqwJX04SH8FqKiOgLDF6Subdv0kqA8IjI+RDavTk/SotuV
         FjfWhT5j6XxOZxM2Un5KCpDYdN54lNohGT5jRskc1KUNr0OHe90uwLuztNgGSM/SXkEi
         GTHA==
X-Gm-Message-State: AOJu0YyreBZBOayYrTEIPUFyvsds90jRyCwD+tOdUDVp97QBBTCNBmgt
	Pp4ehvmK9z+9sH7moaK/Xpy0ClmTAapPpJnXQNVWc53AJ5ThxOMsUkUttC41MIlSV6PPI7lEQfu
	8n9+j87+RjZrTy3rsAg==
X-Google-Smtp-Source: AGHT+IGlzWtqjzUJGH6Nvhp7hFYQayoidp39fFZ1FF6ynSjqhu4fayTUmM2j9bMmUmgkgFBRYlOjhIVRaw6xjzai
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:cc52:0:b0:5ff:a9fa:2722 with SMTP
 id o79-20020a0dcc52000000b005ffa9fa2722mr367712ywd.3.1705718411731; Fri, 19
 Jan 2024 18:40:11 -0800 (PST)
Date: Sat, 20 Jan 2024 02:40:06 +0000
In-Reply-To: <20240120024007.2850671-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240120024007.2850671-2-yosryahmed@google.com>
Subject: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are done
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In swap_range_free(), we update inuse_pages then do some cleanups (arch
invalidation, zswap invalidation, swap cache cleanups, etc). During
swapoff, try_to_unuse() uses inuse_pages to make sure all swap entries
are freed. Make sure we only update inuse_pages after we are done with
the cleanups.

In practice, this shouldn't matter, because swap_range_free() is called
with the swap info lock held, and the swapoff code will spin for that
lock after try_to_unuse() anyway.

The goal is to make it obvious and more future proof that once
try_to_unuse() returns, all cleanups are done. This also facilitates a
following zswap cleanup patch which uses this fact to simplify
zswap_swapoff().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f0..2fedb148b9404 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -737,8 +737,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		if (was_full && (si->flags & SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
-	atomic_long_add(nr_entries, &nr_swap_pages);
-	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
 			si->bdev->bd_disk->fops->swap_slot_free_notify;
@@ -752,6 +750,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		offset++;
 	}
 	clear_shadow_from_swap_cache(si->type, begin, end);
+	atomic_long_add(nr_entries, &nr_swap_pages);
+	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 }
 
 static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
-- 
2.43.0.429.g432eaa2c6b-goog


