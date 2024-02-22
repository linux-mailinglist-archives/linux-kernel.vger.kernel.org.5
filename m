Return-Path: <linux-kernel+bounces-76068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6985F288
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978FF1C232FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4CF19452;
	Thu, 22 Feb 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRwFqxMY"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2C20310;
	Thu, 22 Feb 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589529; cv=none; b=TK/6SdnBakjM4lDPiEBxIZBgnbZU1eocOX3r1fROJ6Xn8lh7aaQXoocMfDGyk0rpj5zrFe+tZMi84BINWwwEzi/8F6UGrJ/EurMuT0ErD7nbK34W2SDEWL7D5j3p3lbJp8oE40AX1NNpS1+mlZeAduNZuUkPUZtRV3T4v42ltB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589529; c=relaxed/simple;
	bh=OhUr3xHewTNQYlcnCfLYnZEEBSimq47w7Mls+ifxF5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsositIwS6r/r1xKcXvLvfLZBP95ApN4IAQZH3D/MzbA9PKfWaQ8QWP5DHayRER/52PiTKnDI4Bng5LMX7sYGVP/Kneu59GAtBCDj8F+K0X++ixsIzIjZiyfV5dgZ34UTBWL0FKohQ7ucaGGPMTR60rKjrJNlL8/2LB7Rv4MeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRwFqxMY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e32a92e0fdso2016697b3a.0;
        Thu, 22 Feb 2024 00:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708589527; x=1709194327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jyzbw4yb6Txj6TvozTLsczGvcpX/acfEaP+bFGtpG1E=;
        b=FRwFqxMYdefYSx9szuexuu301Ii+irwD8Qm4JaSm8nwQihwkogJY4Jers+GZn3DHe9
         htvJliHSU/dJrDidgFkcfAppK0RdCVwtVPQHdijQH7vsg9Lw9gdiP5egxhQF1wAkkkD0
         sSVaT7WgDpeD+aAB7+trxyrag8/BLaQ9iyt3T18DwsZ4h5eqIzMr9DI1T4JNwWTNpYOx
         Gua2deDGqu9rKS1GshKuXjRCsHOcyTHe1gABKeC/IMEJkScaTcapKjJFOmAILPqsRZ1b
         fUG4qtDkQibIipuDk5OYld4T9YiVSLi4HJ32solybSUDAVKl/jew23ON0SFE6LxBS1NX
         Xn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589527; x=1709194327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jyzbw4yb6Txj6TvozTLsczGvcpX/acfEaP+bFGtpG1E=;
        b=wuJyjdV0D0m7ZwFyl6dAsApjjXK4XRU1ZHo3CxMzUVf+Mk1WSz9q4yxTDs6MhKteKs
         shVcO8lRgKzx33rdHOTHjomPqjW81Nm6R9EpJyQ9H9AHwytsRD50v2D5QSp266xhMppK
         1+W4WCvbBVa7WEzG+TUsVrT+0mKqDPCd8XUlNR/ccblIfXlphi88LXWd5ERGqEUhfIbo
         KlbKdhIZpwdtq8FB31ij/H5d6omihfl1+s4iYwV4hRaLWaB6+7W46ZYDAE3NlKjohjkm
         3qjaU6j+uD/pKSO63w68WseAFPW1fcAZnt/wXjNrINgXzP4u4eSaNEeDif88kt6/dkNz
         uiiw==
X-Forwarded-Encrypted: i=1; AJvYcCXK5K3PxoPk60d/bc4xcGX3L0c9QtKd3TYR6bIuGZKpTd2XDEn+suM4Z2Ih7q8DqfeUoj1xqQd3dYs20IJGJXF/WGQ90bx6XoKBYfM9nzAS5kxpI5uHbYRuiB3SAdRL/euNRIJ54LF4MA9z
X-Gm-Message-State: AOJu0YyiuU+J4ugNj4h2SH895XW3oZgJgd10Qi4HfX7/j9k7trRs6P1q
	2FdvZdC6OnvqqkmEN0ZquNIb4WkVkZZ6kF3Amj4WgFbL77tv9Sqc
X-Google-Smtp-Source: AGHT+IFbrZ0+tDkMM94Z/QC2yq6Sf/RISBWbgl0RWkGMZYK099YKho/soN4snFIb+Czo7k6uHvjhzg==
X-Received: by 2002:a05:6a00:13a6:b0:6e4:c54b:9681 with SMTP id t38-20020a056a0013a600b006e4c54b9681mr2437450pfg.9.1708589527080;
        Thu, 22 Feb 2024 00:12:07 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:3b18:a2e2:f00b:c965])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm6989554pfb.75.2024.02.22.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:12:06 -0800 (PST)
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
Subject: [PATCH v6 2/2] mm/zswap: remove the memcpy if acomp is not sleepable
Date: Thu, 22 Feb 2024 21:11:35 +1300
Message-Id: <20240222081135.173040-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222081135.173040-1-21cnbao@gmail.com>
References: <20240222081135.173040-1-21cnbao@gmail.com>
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
index 011e068eb355..de3c9e30bed7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -162,6 +162,7 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
+	bool is_sleepable;
 };
 
 /*
@@ -950,6 +951,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
 	if (!req) {
@@ -1077,7 +1079,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
+	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1091,7 +1093,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(zpool))
+	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


