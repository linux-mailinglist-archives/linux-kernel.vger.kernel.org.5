Return-Path: <linux-kernel+bounces-72233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C185B105
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938E428522C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2255E58;
	Tue, 20 Feb 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYZEeUr8"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB553E3B;
	Tue, 20 Feb 2024 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397780; cv=none; b=jtQZzVFJj6TiNxZEy68nZucyKbLyO6YMtEwD/0DaFshrvjYkUG6aYrAqBPKQCE5wPgTcW5daznd0ZVQmSTPZz447Zmng7lkBVA9F1smutIVvl3BKCQvH55r94DsAlivFjH7a0aWR5t4h0Dc5TR5aRUXBAzDCYzQujZjXAON6KgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397780; c=relaxed/simple;
	bh=d8lZbxxH193DsIqhz4rMaDcs2mD6vkrcp7zJWBzckbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbV7x7v0BR190MN2vqiFYPKMUvRa2puDwz1G/DpEOA4LMBhYMvxqEadpk59OTG5GjSB7cs4IXsTkr+wCTRW4cldZkw2HI73u2KR7NXZdebsYHy8/UNXrWQmF6SGBiRSgpX5vVEu6+8BUSc6086Jc2KtuNVeYi1XNhIzpJvivw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYZEeUr8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2999329dfe7so1518145a91.0;
        Mon, 19 Feb 2024 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708397778; x=1709002578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x09aF372n2E4KjAq0WuthNT6iC+2DOlm894AWq4Fis=;
        b=VYZEeUr8Xqo5pK/T5en6P1ItVOq+yFFQnDGijqlMbBYIlqhG1rwvP+zQyC9jtRowSE
         RJR3QNalyFqWg1t2NnbUswGzRAuuVBIbYBXUEhwhVqXABxxWwbQ4toLPA04Ssdsf/cnX
         +9w3s1A2Nmucszmd+/0zbM2AE/YZX/Wn/4Q3C/dJB0duf4U0ATQvp6OGhPXVHAxaAdLS
         3BboO2jSoDx6TNYRMq2g2ibisuOLgiJecliZhAHVJ0oOlfMU15hlv2Ui4YfSdBonosla
         ViJ7dryuCLGNq5oblX9i1bOTigNhE9dEHjP4V5hW1YYE3aHAlwXMrIa8x/2j2gKrr8yb
         C+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708397778; x=1709002578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x09aF372n2E4KjAq0WuthNT6iC+2DOlm894AWq4Fis=;
        b=H76JEVp5joHU4usaxqnbm3Jqa0zxS0wqzte1sGsFjT3PT184g3HmTab5xdPzP2CghC
         RccQTqjuqWd4JrDu4wVct1fi1CH78Z79c6ixciVbb/PnE6ttAYllwOIIDzW1t56T1y5/
         uVuZslCWWWFMoHEJ97rXtsa7qpKdGhI+aGRy35c7wOlXten7NpXDarEQSG0vVljYurwC
         wQhq11znFSfBcpdjAEwSVekGBtrix3yTtMQO5TDidDS8ykvYBTXo1Mn7xjG7lM7xlZ7W
         WTyI/Af56Cbuk/ZJ4LCAbBNoyuzieaIRTyygVrSX98HJaVaaFCQInNqT9mJ/vns4BhD/
         cmGw==
X-Forwarded-Encrypted: i=1; AJvYcCXPtA9CVWyD3hLY/iNGvl0HVCRwLWziw/Nh7dWCmFwIf0E35ltpW1HHvGgSChVC+0mIKO+nFA6ImaFGZMyhxqLyL76t5pgeoChit6EX5uUDQ9gOH23UlhSYVGvNQUxco1EW5f9ovGKPog+T
X-Gm-Message-State: AOJu0Yz8/l6zrGxUxsJnM7xzkbJ/Q2UzdXgj9bQ5fwxshqb+4ADNlpag
	atQUrifccsZrm6hQ5ZfoADWugN7Yzkbsarkq9pBPx//Zi8wmpjVv
X-Google-Smtp-Source: AGHT+IHU7hs7P+vFcx0S81/nTm/28ngSUvZjSrzTKAbOsDkdi7c59QtXqE4hy9y4VXKC0lM9IVR2mg==
X-Received: by 2002:a17:90a:f48a:b0:299:2b9a:88bc with SMTP id bx10-20020a17090af48a00b002992b9a88bcmr10421142pjb.37.1708397778390;
        Mon, 19 Feb 2024 18:56:18 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id j34-20020a63fc22000000b005dc1edf7371sm5500047pgi.9.2024.02.19.18.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:56:18 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v4 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
Date: Tue, 20 Feb 2024 15:55:44 +1300
Message-Id: <20240220025545.194886-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220025545.194886-1-21cnbao@gmail.com>
References: <20240220025545.194886-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Most compressors are actually CPU-based and won't sleep during
compression and decompression. We should remove the redundant
memcpy for them.
This patch checks the algorithm flags CRYPTO_ALG_ASYNC to know
if acomp is sleepable.
Generally speaking, async and sleepable are semantically similar
but not equal. But for compress drivers, they are actually equal
at least due to the below facts.
Firstly, scompress drivers - crypto/deflate.c, lz4.c, zstd.c,
lzo.c etc have no sleep. Secondly, zRAM has been using these
scompress drivers for years in atomic contexts, and never
worried those drivers going to sleep.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 51de79aa8659..115a780fa2c1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -162,6 +162,7 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
+	bool is_sleepable;
 };
 
 /*
@@ -973,6 +974,8 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = crypto_acomp_get_alg_flags(acomp) &
+				  CRYPTO_ALG_ASYNC;
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
 	if (!req) {
@@ -1100,7 +1103,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
+	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1114,7 +1117,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(zpool))
+	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


