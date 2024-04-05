Return-Path: <linux-kernel+bounces-132308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693138992D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D684285E45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF888FC1D;
	Fri,  5 Apr 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/IkkluX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C3B64B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280954; cv=none; b=VRRHK6nApzvosCKKmJXMLzCovB/dT1PzgpdxPjTz9VI6VMDnkwwNMrcO7BnoUimD644885GSc0ugUUH5X0pjswZ0d3opXYJ3cPx2wKTQbGlZ24FOmPa3KzcL3Xr2Sui5UKOhWOFsfCUxMCrWYjJ4U2hGrA5gN+vqb7bS4aheMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280954; c=relaxed/simple;
	bh=0EwsJFsFqxelfzk3PZ8b/+zJHvbghrn5+keHiziw9TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUU0Nz7B8Dmzq57QShiRqCQIG6401ww63lgn7fg2qNWPTe8SnF3GGn0gVw5HDs35BoGgFycGPDO6A9IMrFkHXQVqwaC3s7vs0jVE7QAF5D3f1sOUH2V5iAEma1+A6U4f4nRp+28vlRjPwQivBtkF4Yql9wp5aLGMB9gPeLNx2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/IkkluX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b96c8ca2so27492427b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712280951; x=1712885751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbFnbwv9ZL9vnT6aD0Y4iZUVe+aMA3yOt75trlF6TiA=;
        b=X/IkkluXiEVJ5EKk7J0A8+yObqRNvDLo0ep30HXuSpU0+npT3vZt2uJypTJEfJGjJd
         1SgVawoNeHogbJPS7AMmqdVcxlCg1yCLXpdqnC6uIlDI02bS8N9NfwphPROp9iFAp17g
         CL/Y4nZrSHQysvn3XQB9sS0CReeDHKJVWoqdK5FSATcH40Wx7rbiPKNradeXNsmTc5o8
         kSUCA9nsMzw6l9pdrrH1M0dAM4ofoGFqluGil0aR+RG62cLEzc/u7/xbGYs5ogqv2/iR
         GBnucTFJyvVuMxobpuaxodiL9rPatwrCb34/+3d3Y20V0gLl5e7+uzg2Ej844PyAKNRq
         IxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712280951; x=1712885751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbFnbwv9ZL9vnT6aD0Y4iZUVe+aMA3yOt75trlF6TiA=;
        b=qV7Hm82iwDxK78nGGsnxkK7z/S1rMWe4K23dO0smWXy1d4tX+mSCCp/5w10nHAQIhF
         WoT3VdWFIS5O0XweYnT6ETZN3FEH/fHSxgNdVPhc60OuWuovO5chu+K07Fu4btru/5Eh
         Gdhi99iDbrEdyLCjs0llSnkzFpMblsMM3LChKDJ0T9IUlGj4sqcMACwB8iFzORNZQK6V
         iA6F9RS7o8njTnhAV0IUzxlyZ/59f067x2jAbeFItjUCDlJ3rNCJ9h35JVavvd43l4Go
         MvmVw01aD4jg9b99HbAkrEB3sRu94ms4NHYsfuWsjAjRML7+ow9V7iAbeOk/dsUVqJYn
         NZCw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxi4ZO6MLB51+K+HzemvT0GuN2KAGmAYwIPUIxO++Yfm3JhDa/2qNdLr3mVOW/8wAxFc9oAfEK7Hbn1wasbiIZEN8jdOEFsiUskcD
X-Gm-Message-State: AOJu0Yw0YQL1SWNyoArGTxGO3JYW1CR8VX1dokd4LOBz+JqScCaBTTLD
	T3DqFIdcQ28q8kos7YbZuHBw7AEndPfgaBPzj6vakht1y2+9HJDlyr4l6wORyEOcTeuObdz5Elw
	ere7HrxmlKQBfluHbcw==
X-Google-Smtp-Source: AGHT+IGJTA/i85YTUBVw2cs8xuSEjY+bqpz8Alc8JIdeIpUrh1LGBbhlTI/u/mBkLRKZfoJj4MNZLvSP1tmwvTZh
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:dc4:b0:615:102e:7d3b with SMTP
 id db4-20020a05690c0dc400b00615102e7d3bmr343711ywb.1.1712280951511; Thu, 04
 Apr 2024 18:35:51 -0700 (PDT)
Date: Fri,  5 Apr 2024 01:35:43 +0000
In-Reply-To: <20240405013547.1859126-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405013547.1859126-2-yosryahmed@google.com>
Subject: [PATCH v1 1/5] mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The cleanup code in zswap_store() is not pretty, particularly the
'shrink' label at the bottom that ends up jumping between cleanup
labels.

Instead of having a dedicated label to shrink the pool, just use
zswap_pool_reached_full directly to figure out if the pool needs
shrinking. zswap_pool_reached_full should be true if and only if the
pool needs shrinking.

The only caveat is that the value of zswap_pool_reached_full may be
changed by concurrent zswap_store() calls between checking the limit and
testing zswap_pool_reached_full in the cleanup code. This is fine
because:
- If zswap_pool_reached_full was true during limit checking then became
  false during the cleanup code, then someone else already took care of
  shrinking the pool and there is no need to queue the worker. That
  would be a good change.
- If zswap_pool_reached_full was false during limit checking then became
  true during the cleanup code, then someone else hit the limit
  meanwhile. In this case, both threads will try to queue the worker,
  but it never gets queued more than once anyway. Also, calling
  queue_work() multiple times when the limit is hit could already happen
  today, so this isn't a significant change in any way.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index c4979c76d58e3..1cf3ab4b22e64 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1429,12 +1429,12 @@ bool zswap_store(struct folio *folio)
 	if (cur_pages >= max_pages) {
 		zswap_pool_limit_hit++;
 		zswap_pool_reached_full = true;
-		goto shrink;
+		goto reject;
 	}
 
 	if (zswap_pool_reached_full) {
 		if (cur_pages > zswap_accept_thr_pages())
-			goto shrink;
+			goto reject;
 		else
 			zswap_pool_reached_full = false;
 	}
@@ -1540,6 +1540,8 @@ bool zswap_store(struct folio *folio)
 	zswap_entry_cache_free(entry);
 reject:
 	obj_cgroup_put(objcg);
+	if (zswap_pool_reached_full)
+		queue_work(shrink_wq, &zswap_shrink_work);
 check_old:
 	/*
 	 * If the zswap store fails or zswap is disabled, we must invalidate the
@@ -1550,10 +1552,6 @@ bool zswap_store(struct folio *folio)
 	if (entry)
 		zswap_entry_free(entry);
 	return false;
-
-shrink:
-	queue_work(shrink_wq, &zswap_shrink_work);
-	goto reject;
 }
 
 bool zswap_load(struct folio *folio)
-- 
2.44.0.478.gd926399ef9-goog


