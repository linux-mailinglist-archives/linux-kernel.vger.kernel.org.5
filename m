Return-Path: <linux-kernel+bounces-118184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE788B58F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697AF1F63A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105E284D3C;
	Mon, 25 Mar 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjRJCKjx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E884A26
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410624; cv=none; b=PzUptR7EonH+S4b7ro7XSbnW9Vn6OAHl6wPjcMVqgFvbe0RVy6HS1N99y+eOTgD9aZLZP+h/02fzPm6bHgxdG+M/vNPuA9Fr+NhB2XjXcmmE9h5nR4MY9LXoc/JfiM0wTt0MJ82rv/YkJSivojPQWJCj4wvubXReLBC5QimMmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410624; c=relaxed/simple;
	bh=6xxUCt1k7C+LwXDbzCekm9e6ZfMrsxua/6M5UyPsHns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LgFjXUwKO2kp/U0wp5gfR8k99qpHqyRdPWB/mRWzYWlEL+LMZB91JfeFUukYIAYyFJf2Twa90qMNJhxW8pNhr6RFfJ2QHgEsgRUZjX8gmWENa5uKbaQ/H6yEoR+FknwFx0GQBh99WWFezMjdFLPKs0xdIAuBRRINevYk7g1yzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kjRJCKjx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a03635590so99284487b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410622; x=1712015422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9fvbqW1pLtPErlE8l2YKQeiKLLE5wFNh7avewbFYWs=;
        b=kjRJCKjxUN2aU1haa67W+vz+lyNDM3VM4OeLHTfKotzkn3jMo3uakiw2baap7rZ0Bw
         EN4tb8BK9AaV1Kgpzh2/4PWKOdgnOyXu7gHZQOrn8RGOyH9h8k0Kt0VrBBEOi65PskXs
         +KM3arrq/7cFfwMDFXFS2UgkzxKMTRe/Dyw00T+zcIrQu/DAk7fmFMQTLCPL6ApyOJ/c
         Acm2aASX7xFDapHAauKyj7477grt++HAYeEp3H759KS55WxqvnK3bxSMwhd5XoHb5jHG
         1c3Be2qgoM42YOAtwyPRcCiHLcePuAidbIfPGrvgBOiIJXxsmLb18j6RCfaarjmDab8o
         0d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410622; x=1712015422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9fvbqW1pLtPErlE8l2YKQeiKLLE5wFNh7avewbFYWs=;
        b=tFiM2ZzIqmr1RDPhDJUF0L6CZYjdYWE1icLNADF1MdcY0ewDkJSQ060OZ+OElYvfX2
         Db8zU+eSlZF56NsF/0c37Z610IdvbItT9gxYbolLzc2n5u5SywUD0jkQZCr4llkmHdEx
         gqlnC8AiKsETxH+hOlJ1mE0qHeR/uyO+SVCv/eSdxR4NHZvKJq6yytMbmvETfYNU9TF3
         ObihNcuQRF9EYsRQzyQz5sW5BXOUJJJR0O+/PKyIcS37R9gGEP9jae+ZAFhDjPN5xa5z
         7nw6GjqIuqf20lnFhsPak6TYISGUahxiJ8rome69WIh21uV3uysWByHrTperuUAbP/7e
         WTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt9tYZ/99jf9cxGAk/hMveLz33tk8Tr7YTq07/7M2QHRxNoBysugPv3UZ75WU3mZkTU5ozgBj4aFmO57okx21G1GCVQaN0qTNmKEYE
X-Gm-Message-State: AOJu0YyNPivweKkekyZB+VgN7y/b3hYIHF1J8GLqFlJUDLIVxYJCW/rF
	CAPneKZZM3CqqcXRdw9peoS3+W9QH+twg8wZdRI2F9IpCj5W7dgsVWk8GFzfyMueyHDwaxdGanH
	PeNNprfbpCaGKIcLn6g==
X-Google-Smtp-Source: AGHT+IH+DXWV+vX4OULsfH+Uyq0gzOaLllxrZEK/FYDaAYjBCM9JZ11SOX35Q3oKMnkT3VL0MGvjY9eZ8pU6LA5R
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2491:b0:dcb:e982:4e40 with
 SMTP id ds17-20020a056902249100b00dcbe9824e40mr2590953ybb.12.1711410621894;
 Mon, 25 Mar 2024 16:50:21 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:09 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-2-yosryahmed@google.com>
Subject: [RFC PATCH 1/9] mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
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
2.44.0.396.g6e790dbe36-goog


