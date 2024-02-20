Return-Path: <linux-kernel+bounces-72425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E485B316
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EE9B214E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F05376F8;
	Tue, 20 Feb 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvzrMOMB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3A2EB0A;
	Tue, 20 Feb 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411488; cv=none; b=tB5DVpGUCGV/KMDc91al0imQYHmWa8nJGdEQ7/SbrTWJ3n01ZemQaVRdtxrr5LxiVYNE2ixveIi9jrZs+S2IxMr3bIpzujIKYHwUPZ6x1TMcYxUTZqS3jsY1JqERSpwCPBRZZaLRgIKFhLY++58U3kbN7HJ08Ze8ie6OxL8kHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411488; c=relaxed/simple;
	bh=QBjD0UNrqJv6Dnwf8bQ7P7DqYnYL3lr2GgKmLuKcx5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R27xHCOOk00ekYHiuA1B0B62+wLN2sbTQnZhuKQkn0gho+q1/LVAICHrN7OgBzsWWe8KAcEfJAL4Dd+RCiMSEXPl0kzSMQa4z3AolnDL9rsxhmtfalM+CmjqoPaEkd+jL9DMuqFdCKHfgYHPpQxW46c2Qwh5v2G+1iPfDMsdeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvzrMOMB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dba94f9201so31412085ad.0;
        Mon, 19 Feb 2024 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708411485; x=1709016285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8rNl+BjuOiPHO8BwMbPluxA5iMY9ZQk2ZuevI5ELxs=;
        b=kvzrMOMBULe+FFGd5lChgE6ZAGN4edqEYZoK6UDbtWJ5/XQRqXX4sSC/lpNk3eqhui
         ov47XimiIBX6kWHaD2EwO1Vk50E34BMv75EktocCuRatgJZYoGGd5kIQp1vVgh8dn0XG
         2W+gmz+W0ne3t3dbekyCxkbn9eGcJmdgrDiDCHqwbkdhmD3zHbT8hppJPDwishz9tiY+
         dNRyMRIStGBIDzKL5GaAl17lhYQ+0i9c2hcHU1d43dnz4JEZSdn2GaFlGNWTozJuwX68
         3cjxJ03dyRuTMmHOv1Ut2FZwJVRrJuQM2CcHUVAdJph7yEMqBMXYHVG/QdflnYdx7Xwv
         scrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411485; x=1709016285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8rNl+BjuOiPHO8BwMbPluxA5iMY9ZQk2ZuevI5ELxs=;
        b=wCXYxyvFPrubKagHRPVU8oyfufC9DPJ9bGa/m235czbR+/iL3oWWxvN0HvFLC4jihy
         x7t3R9VAp42EEoX9xqUAL2lcnrl/iqFhGHvUg2JAu5Cvf/gl6AeDJ7dr6uq9/fP3GOn+
         GP177MMjY8zKvMuq4FmEk/3mmgziEWJ2vpqTdG2Gqge+6zkpH94rNRGg3tigUbDHycrN
         JwiS5Nl1pSw/sOfWgjBFU9Lm58H+famoQ+iXY+c7Rz1dTrUpbs6qiMLQrKirGTHnEQen
         IvaVniafr8EW1/ekOrSZGHR1JTgxV1+SoaKWGi3jlTuKycN1UaWRWGZe8NPpqyq3wnW9
         GUVg==
X-Forwarded-Encrypted: i=1; AJvYcCWw58r6FLhxLBihEJJgVMGIkSw/kXcc7YHDdF9woU/jUgUS+c1tUjemb8UZg7vhV5UXDlZpfxZ25PsUGsnT+GVEcnfzQ0VoMLvi1A8QjnAxlm8YQuKBs4xmfaSmZl2OUbcAR/lvnw+bSlfP
X-Gm-Message-State: AOJu0YwsUCBJrJ1S92+EgGFF9+8HIxx8ORLx+wciWMFD+TL+jWw6ZeUq
	W/jFPB3jM1KTSD7i6loO911P3ivV2sb0yWR0qTOpk/6L3W42QGoS
X-Google-Smtp-Source: AGHT+IGjLI8WrT5H3cLslymf3abuNOE5Ga3w1JP7qFoprv9R9pGvpeHXjEqD7rjwt07BKGzckg9xsg==
X-Received: by 2002:a17:903:11cd:b0:1db:82e3:8d7f with SMTP id q13-20020a17090311cd00b001db82e38d7fmr19374961plh.16.1708411485583;
        Mon, 19 Feb 2024 22:44:45 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db60446abdsm5419090plp.262.2024.02.19.22.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:44:45 -0800 (PST)
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
Subject: [PATCH v5 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
Date: Tue, 20 Feb 2024 19:44:13 +1300
Message-Id: <20240220064414.262582-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220064414.262582-1-21cnbao@gmail.com>
References: <20240220064414.262582-1-21cnbao@gmail.com>
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
This patch checks if the algorithm is sleepable by testing the
CRYPTO_ALG_ASYNC algorithm flag.
Generally speaking, async and sleepable are semantically similar
but not equal. But for compress drivers, they are basically equal
at least due to the below facts.
Firstly, scompress drivers - crypto/deflate.c, lz4.c, zstd.c,
lzo.c etc have no sleep. Secondly, zRAM has been using these
scompress drivers for years in atomic contexts, and never
worried those drivers going to sleep.
One exception is that an async driver can sometimes still return
synchronously per Herbert's clarification. In this case, we are
still having a redundant memcpy. But we can't know if one
particular acomp request will sleep or not unless crypto can
expose more details for each specific request from offload
drivers.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 51de79aa8659..ef782879291a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -162,6 +162,7 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
+	bool is_sleepable;
 };
 
 /*
@@ -973,6 +974,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
 	if (!req) {
@@ -1100,7 +1102,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
+	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1114,7 +1116,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(zpool))
+	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


