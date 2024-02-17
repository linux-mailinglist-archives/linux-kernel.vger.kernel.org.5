Return-Path: <linux-kernel+bounces-69692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3B858D57
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBFA1F21D73
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5111C6A0;
	Sat, 17 Feb 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhJj8n1O"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E5149E0B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708148219; cv=none; b=d1VhydrRfkSMblgaJeywGLFqpJCk2YubEAfea9r6yPl+I8g+hU93KvietIEBYn+G/A3j3WkbcPBtZfXFJdQRjFBRMi7Ximfq7RDmirKHgAobhpf51g+t0brCCjF1BwYIVXXsmD0VB3nn8fjhbZ2ljhzdTYzDCmcU2L7qAeutJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708148219; c=relaxed/simple;
	bh=I0rH/AzGKnIIcT7lLmWH05RQnkNtY+vk5eDC9ZMYQDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JIxN2egilL9oJvXBFvsAkaIU7CWahIsG5Dwhr0t2w6kdbL85t9LbgRlekg/cIy6sSIo2UjfwO3rDNemSLaj0zDcfLo2qVdmdiUXSpiBh21vFH1aUY/lQNEEqMkNHXLWWvdf3F3yx2PAPUqdUbONuiHGR+IyC4ayh46+VBKwnDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhJj8n1O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d918008b99so23430195ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708148217; x=1708753017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCLVx9kxWQaFnG1OpMOPtJ5A7Khl6+OxNkxfvJDWGlc=;
        b=hhJj8n1OMced4nuv98oo3BOejI91EY6ZgM+H92sHlPsrRZPsXlnyuv1ZJNpDHnmFcH
         BtBQq3HUZ5VCeiVKLsURAhRYKiMNpBicN0crLEJ3PQBezgW98b4tPyoY3T+bmztFz0uk
         k0OCyePxqaawTtF+h+rLs08rSFuEAPk/+WHqWVhp+t8pGcBsaGsoSfBQ6Erzoqe27IBo
         OFan16T1kn9PgUHK96Tqf3zjdYw9sHd6zHpRQKdl0kZwFN+nw8TYAhyzhmLsaupOnseT
         nSpucO0g4KP7tSC+Opx2S6kzm3A/sx8IcJ+ygkKbvOtmhQSmBuYdjjYUKqVltKVsDJX+
         +SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708148217; x=1708753017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCLVx9kxWQaFnG1OpMOPtJ5A7Khl6+OxNkxfvJDWGlc=;
        b=mnZnSqr8kRYzJQjw8HJhqDmuhmkIt6kSAlgwjD1bfbv00s2YtXLC15T58aboYYYWtw
         IuksAFLeKcCU3hheSccDCuyi3VvBIEXrGRQY3huBZrqFppNvBWdLQTXiVNJmEoEAvmuj
         cDs0Hsw9imfYDZIxpb648SfOHWv20+4LXJBHblpmVX+XaOyCkyXTV26WFI7iEr+iCL6a
         d0g3fYxeGV0LdutCvL/e/S3ThOHQ3gkFIpteBXF1htN5vbYLmfDKmoThtWMPDR+6B9Ma
         lzdb4Mn3swT77qDdIRUK/SLBjw1EJA2KYrH8xNudz4RnupymQzETEsE5OXrLBT0RoEuJ
         UyZA==
X-Forwarded-Encrypted: i=1; AJvYcCV9LOhFXp9V/QPoJ7kWAWPwBaXXSC4d99CUsLvlzaV4zs35jLcXZEmNyWvW3d2KwjCNmXynKpJebzzc5cQAumycRQ4ae6mokrmpvLFo
X-Gm-Message-State: AOJu0Yyti3yOzbf8le0B87GxvxxVZ/+/iQWVslpmn2NlXY/SdH9LIw/S
	evYbBnXxQ0HZaDnZN86VqY3kauRU9bJ5ZpZTA92cA5jduc8syWno
X-Google-Smtp-Source: AGHT+IH5+jSNUQZJD7pveaLpbnf27JozpiZW+iIpVps6y29SNJKVQ4jrWmBgLkB5IZKAir6i+qLx2g==
X-Received: by 2002:a17:902:ea0d:b0:1d9:5f11:d018 with SMTP id s13-20020a170902ea0d00b001d95f11d018mr8459194plg.1.1708148216595;
        Fri, 16 Feb 2024 21:36:56 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e82e:22f2:1bdb:989f])
        by smtp.gmail.com with ESMTPSA id w3-20020a170903310300b001db3d365082sm694251plc.265.2024.02.16.21.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:36:56 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org
Cc: nphamcs@gmail.com,
	zhouchengming@bytedance.com,
	senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2] mm: zswap: increase reject_compress_poor but not reject_compress_fail if compression returns ENOSPC
Date: Sat, 17 Feb 2024 18:36:42 +1300
Message-Id: <20240217053642.79558-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

We used to rely on the returned -ENOSPC of zpool_malloc() to increase
reject_compress_poor. But the code wouldn't get to there after commit
744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
new code will goto out immediately after the special compression case
happens. So there might be no longer a chance to execute zpool_malloc
now. We are incorrectly increasing zswap_reject_compress_fail instead.
Thus, we need to fix the counters handling right after compressions
return ENOSPC. This patch also centralizes the counters handling for
all of compress_poor, compress_fail and alloc_fail.

Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2: 
 * correct the fixes target according to Yosry, Chengming, Nhat's
   comments;
 * centralize the counters handling according to Yosry's comment

 mm/zswap.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 350dd2fc8159..47cf07d56362 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1498,6 +1498,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry, *dupentry;
 	struct scatterlist input, output;
+	int comp_ret = 0, alloc_ret = 0;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
@@ -1508,7 +1509,6 @@ bool zswap_store(struct folio *folio)
 	char *buf;
 	u8 *src, *dst;
 	gfp_t gfp;
-	int ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1621,28 +1621,20 @@ bool zswap_store(struct folio *folio)
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parallel.
 	 */
-	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
 
-	if (ret) {
-		zswap_reject_compress_fail++;
+	if (comp_ret)
 		goto put_dstmem;
-	}
 
 	/* store */
 	zpool = zswap_find_zpool(entry);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto put_dstmem;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
+	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	if (alloc_ret)
 		goto put_dstmem;
-	}
 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
 	zpool_unmap_handle(zpool, handle);
@@ -1689,6 +1681,13 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 put_dstmem:
+	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
+		zswap_reject_compress_poor++;
+	else if (comp_ret)
+		zswap_reject_compress_fail++;
+	else if (alloc_ret)
+		zswap_reject_alloc_fail++;
+
 	mutex_unlock(&acomp_ctx->mutex);
 put_pool:
 	zswap_pool_put(entry->pool);
-- 
2.34.1


