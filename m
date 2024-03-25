Return-Path: <linux-kernel+bounces-118191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64888B668
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF38B2956C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A5612882F;
	Mon, 25 Mar 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdUFuZPc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D684D2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410636; cv=none; b=GSJhdTCMevmm7h6jgValq2fhxpqESSTuwAwqc848G2IDz9eZHEdKav5aHcds2bL2AAD7+mWWXgAK6nYYPLHhQbw9PppWRWXeM8obwlfeDmxgG40OBGmYKpezqIGvKX/BUKi0OA562AazR/A3sbBfJUM7pxr9a+o0lXV6cFSCzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410636; c=relaxed/simple;
	bh=1ETm0Kb/hFLFDlFEAvOSDyN5Z9LPHRKS7vvJJ/LpulI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ozyijLqEOU8THTiz0tOc5++894vIRDIrYMcisz6PF0cuyTkJNqxsSyV8HMx1kOkKLLY/QDw02YTDlxtEOv+h7kAp71Buf4sF2p812685Payjigw8Lbl+V0xqxzJ6RzLLKWP/Dkb+RAtCaV5pijMGbpLbQzo3kyzMAsatC0+9i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdUFuZPc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd944567b6cso6712983276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410633; x=1712015433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KO2q76LvMLcDayey/RN5wyIAuuRCIUh2utVXFGvhTms=;
        b=BdUFuZPc/DzYe3O+g2m/cdEFg97bSr+3WUmHdMInMEFTF8s49+PqB6fxqH3rfUOwEF
         ZoDRpD5Dyb2OhvP098bfaKsAHqkfV+blDb0utrkKE5WbpU9WEh3p8VU9WGpUQuLFX5lx
         WfbF1Xlg7WOTiSu4fJiCSBds6s7TG6ur0FIFEwhQeyJyI1eKTXKlcsJwZzoVygW6Jss2
         vNlpuVIyKL+6/1FrtwIu9rcHaQDmxFfNWkbkCYhJqFNJWwNllnAR0gNLWMwDsXdIitOd
         mqT/G4Zz0f/ijuJ090ZRO2hz7HgZnEkXj+2CNwiPqHh22IW5bNDSokEb61WQGBuS8Se0
         2bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410633; x=1712015433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KO2q76LvMLcDayey/RN5wyIAuuRCIUh2utVXFGvhTms=;
        b=bYqKB522o1NnI3QRzJil2k/Ldp+qylGCSXMiCTsfEQTJdGLqXQJN4iBCLofVECMu0F
         fDXTadTxQvTPlfrHemtB6krYg2IbWEnCKxuwbNqeLIgd7BJUNnBKotrCr4wnJ5XDcrdV
         +NIZwDBL7BxgRxRK8iLr+usm5ZK8wy2+38fV6tGq02rkrd+ENl10xB/L4DllEQRP7Gkd
         GSNR85oFtMnCCluEWfa3mN0FjZ02DKHTy1jUzIaLnjux7UxjnYR8tUDl/jHaescjvEDn
         Yfz7Ca/E7f9BDx5FqyvFgYBZ9xUMhrcNrEd/ZawPEO8opQqqdsK7LmKlaWdgQlJy8npE
         9IDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKxsqI9qz1cwnCIy3V4UFZBuO/qKgpjORYr+3wPfEw3K2JwZOoGp5V1r/1PDoV+1s/D1Gz/j2mTpw7t/Ft6xYXMaZZEgOSz4s3US8J
X-Gm-Message-State: AOJu0YxD/2GiI/NVDusHxvlbYiI6w+4hafbJkNUwW1A0y6myqCFtJQK4
	s37oKjsEK1zXlYx6iXquF7iQzI4ysnr9NpYa1E2/nbsexv3uTzPxsepqi8jFxCLHzLwFLHfE5j+
	tAC6CvTD3gPQYZO4q2w==
X-Google-Smtp-Source: AGHT+IGsngKICRKq/pDsaMChol7XL6fK76guiT9EmRwqzuuG62psC+Y/KoJk23mBwa/MlcuS5UwOswLoFZ1CnMT3
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1241:b0:dcc:4785:b51e with
 SMTP id t1-20020a056902124100b00dcc4785b51emr370308ybu.12.1711410633551; Mon,
 25 Mar 2024 16:50:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:16 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-9-yosryahmed@google.com>
Subject: [RFC PATCH 8/9] mm: zswap: do not check the global limit for
 zero-filled pages
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

When storing zero-filled pages, there is no point of checking the global
zswap limit. These pages do not consume any memory that contributes
toward the limit. Move the limit checking after zero-filled pages are
handled.

This avoids having zero-filled pages skip zswap and go to disk swap if
the limit is hit. It also avoids queueing the shrink worker, which may
end up being unnecessary if the zswap usage goes down on its own before
another store is attempted.

Ignoring the memcg limits as well for zero-filled pages is more
controversial. Those limits are more a matter of per-workload policy.
Some workloads disable zswap completely by setting memory.zswap.max = 0,
and those workloads could start observing some zswap activity even after
disabling zswap. Although harmless, this could cause confusion to
userspace. Remain conservative and keep respecting those limits.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index efc323bab2f22..9357328d940af 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1460,9 +1460,6 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	if (!zswap_check_limit())
-		goto reject;
-
 	if (zswap_is_folio_zero_filled(folio)) {
 		if (zswap_store_zero_filled(tree, offset, objcg))
 			goto reject;
@@ -1472,6 +1469,9 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_non_zero_filled_pages_enabled)
 		goto reject;
 
+	if (!zswap_check_limit())
+		goto reject;
+
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
-- 
2.44.0.396.g6e790dbe36-goog


