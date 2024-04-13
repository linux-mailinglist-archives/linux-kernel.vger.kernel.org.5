Return-Path: <linux-kernel+bounces-143520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D538A3A78
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D6BB21593
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23531862F;
	Sat, 13 Apr 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWs9ENIN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2914A8E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975054; cv=none; b=XaDXC5Mafx1eR2q74Tn5EAFEgR2ZBnyBO8kewotnUruZrfQU1ty9++rd8X7I1hY/HjMIYMsEXbuRfcGrkx2WBSSni0VmbUBaDqWnZzsWC5I5cmDqQMOoT2lG/fcY9dAg3HUttkXWAsQ3MJ2rr9QgAvM6imZOJ08iWoTBlINVF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975054; c=relaxed/simple;
	bh=uRXFHOd3GYWfX4hZygsGS6tgsg+JAiT7ierWKzgvHk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sHKpJlhATcuWp3+5QU5M6n6Sx589H4dSurx/kG6fRkzaHtZ7WZCpQw0afnRZcMtRLloQdpLLHy+LhPO2NTm+K4/mg5gSo51BtyG7/AROTgyOceggor9l4mrd37mZtQjmXoHcZJCsZamAmjupYRj2vCZgXW3S29wW4O44dEiiyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWs9ENIN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso25066737b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712975051; x=1713579851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOPR1bddD//aUuRH48FEXSlgeu+YRgqWmevGjhR2ITY=;
        b=qWs9ENINeF0m20/cY0Av3i+furL+uW4LBZfsUuzU5fTHeU8GBBcIMq6U0Pd0+hfX9T
         5jz2fdahb8MgXbjGeIARouTT2/L7+QevdI+5hMhJIVeom1/tVbJ/8fJFLsYCJk3hEP7Y
         2fVuD9uf5FB1uXYj57asstKkn2YBLzoRwzVDK2Ce3AmnfOWz+IuOz8S844mvFEwQ821L
         Lm/PLZ8ICelAYJF9uuD1aBGGUzIfA7YHGV2mxYP/GakDLT4jnhj1RnB9SzYvMoADOytj
         7ScKKQeNmPdVXbYPgpj+Ie82LFEZbNbD5IFJcvgzdbgqnZrW/kmpLNPsbMWNHfQSvs+u
         bt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712975051; x=1713579851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOPR1bddD//aUuRH48FEXSlgeu+YRgqWmevGjhR2ITY=;
        b=Jtu9qgLwWhVi38WzllzXA93R+BT2K13lVrgSQhzdKc3/DhQhtztO9IVJc+zChLQwwT
         e9s6G9lsVeoX1VWqaEdqm1phX8xx9LKQId2uDOCW9fEfCSTAW8OR5gIll9JnSdmflBhr
         KKWpvO1AWf2b+YJDvrGU8+hESdeVgznoNGIifFHm9gSjQm7YprGpDoFjd4/Zn/4KdQgU
         uU2H9QUX0L2zTeA8fezfs73c4V1/0DvDMpI6w7dseN9yGCNy04e+XGF3ekj8cLP3pdro
         B5azK+Ske/j04mPw6Wcub9GvvIEf0IEHDFu3yjopvFdAT7DR2Qk2DX5FTlK16vMeDlSt
         mGFg==
X-Forwarded-Encrypted: i=1; AJvYcCXQdSixhY9lLEYJXzos5QK03Gq/3aRkvUR2mb7vcPJTe5QN9st3jJEoz33pXjG/tAfLO9Wkpkfjga3ZjdpC49v1Z/Z6O6qWHElH2hpB
X-Gm-Message-State: AOJu0YzW0/PDdKZV14LFJurqAq+LzXzg1IhOEJNXpsUjUnVZzJ3GXVnh
	zP/d1BZDPeTvl8UfTNbWVSvSAAi73q4bBEgHjbjFyMyHTIJolBk+FmXB7xDo1X6403UACxL/xul
	UujzSS08sQyQ/WEGrpg==
X-Google-Smtp-Source: AGHT+IEIyih7J9L34SbhPW1Fs19b+bJp1g0bk94AkYr3vPB7zcxk8Z47Mpof1dxsaJMt8h1S+jqO5WIy+IoUE+4+
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:dc3:b0:610:f5e6:375a with SMTP
 id db3-20020a05690c0dc300b00610f5e6375amr996613ywb.9.1712975051525; Fri, 12
 Apr 2024 19:24:11 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:24:04 +0000
In-Reply-To: <20240413022407.785696-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413022407.785696-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240413022407.785696-2-yosryahmed@google.com>
Subject: [PATCH v3 1/4] mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
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
index 741957f36f38b..77b6bb2099763 100644
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
2.44.0.683.g7961c838ac-goog


