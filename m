Return-Path: <linux-kernel+bounces-15355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A80822A95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688FE2855A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFF618E23;
	Wed,  3 Jan 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTRu68CT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61118E0C;
	Wed,  3 Jan 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9bec20980so2479131b3a.2;
        Wed, 03 Jan 2024 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704275440; x=1704880240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF2P2SEmq7vRAtkf5d5h6lFP1PY7Yzig5CUd/10AwIg=;
        b=VTRu68CTFBoX1r0Mj1eTNq+EXifaN3iJsc1gO40YkQrHijbSbvHDsMwEQiuK2uPR0v
         eEy2MTuIU7ZJ7VJRIMeOy2tkaQAIJ2PkVEPPzipSzaww4UXcS/6y9Nf1cISOEwDhMiXW
         XK72tIQ0TkIO6Z8jDkF+xMHUMsYJ7a2+Mvd5jCBhe91OHy9LXQRpL08y7J3rjFxKe9o/
         lJhzlVF1suxWh2uhSpFVLISKc/xxWV2BvwZj47DQfpGXmyigc36402nkY4b3SJdzBZKr
         S3Xm7pgmnWmSVbusBgNQ9USXOgMBbdmIgVGmSan+xCSHhzrjoJ0jrX7oJxGzTi3D5osD
         MjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275440; x=1704880240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HF2P2SEmq7vRAtkf5d5h6lFP1PY7Yzig5CUd/10AwIg=;
        b=p2jnxtZdG/aM6y0jSNjjx4HgTzpP3U63bUFfWqemL/n0RCIl2hf5c70BwFlBvYuZGx
         T5IuLBTNGT0IHUXiKPse6yPxS7iDmMyu3mRvs/JOUK82SicQmUlU1Fv4x5gtATmIeSXQ
         1Twgu5bbXh7SdOwYa+kkgE3HDhRSE9tquc00ASaj9c+da1XCQl4hCGTYLbECzBmmzVoH
         SzNdZlm18AMaGEFNP569KygghG7XgJrp+dEwhdEubeoR77NEZkgMIX1CQDnq/rfO2sWQ
         FMM0HApetX/TnCH2fIbNJOd0SrXPsuXIkDbCVKRLFBzvJbV96lEBrT8bURKCDVzQDZus
         /s4A==
X-Gm-Message-State: AOJu0Yzbgs2kc9oot2B901oHR0IR+mfvM3gRL6rWm3oYncbJ4AwMvjo1
	h4xrpDN92mhIa4/QLwWvOM8=
X-Google-Smtp-Source: AGHT+IFhQWnb8yS8UAuFwFy8vb78sg6hucpOXjJ6Kq+ulrOpwt7NgLV10YadMn0i2Bik7OAWQ2a24g==
X-Received: by 2002:a05:6a21:a585:b0:197:7997:b69 with SMTP id gd5-20020a056a21a58500b0019779970b69mr296409pzc.69.1704275440398;
        Wed, 03 Jan 2024 01:50:40 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id a34-20020a631a22000000b005c65e82a0cbsm21823483pga.17.2024.01.03.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:50:40 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	ddstreet@ieee.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	linux-crypto@vger.kernel.org
Cc: chriscli@google.com,
	chrisl@kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH 2/3] mm/zswap: remove the memcpy if acomp is not asynchronous
Date: Wed,  3 Jan 2024 22:50:05 +1300
Message-Id: <20240103095006.608744-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103095006.608744-1-21cnbao@gmail.com>
References: <20240103095006.608744-1-21cnbao@gmail.com>
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

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ca25b676048e..36898614ebcc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
+	bool is_async; /* if acomp can sleep */
 };
 
 /*
@@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_async = acomp_is_async(acomp);
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
 	if (!req) {
@@ -1370,7 +1372,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
+	if (acomp_ctx->is_async && !zpool_can_sleep_mapped(zpool)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1384,7 +1386,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(zpool))
+	if (!acomp_ctx->is_async || zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


