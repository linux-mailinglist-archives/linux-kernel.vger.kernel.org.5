Return-Path: <linux-kernel+bounces-68046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C969B857548
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1461F2A33F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8617721;
	Fri, 16 Feb 2024 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwzcx4fV"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85D17551;
	Fri, 16 Feb 2024 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056546; cv=none; b=YNQE+AFeAXco/pTqfDs2vY+ArbkVMRdk2Uf30dDBEFlFqFe9mvhxd0eccIVOfojnfbOo+0lMiWQHJhSm9fd654YYhZY4pN44Ln0BTPog9QblYb+BeTrlS5G6g0xnTuShU1tHxUZOtqqfi1ruCvBfGTt7bBPTEs2ods2PLsEcGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056546; c=relaxed/simple;
	bh=PIYvWr5DMLF8+jxHRgFqYx/2Q2KnJ/Jtsvfz7TqNIu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t76syD5n0bnF3t8lTBwFtg4PelYeKwdWGzndjXEO8A22HvApEvPaw59dtVso5JiJ769qltZiqUiN3w9h9/s5fXsYWrpcmXW1GEqhg+/4h0hhit/Zi8rpBgFcUSWo5mcLtdVoXfWsHQbf0lU90IDT6rqgsjmrAmlHipS0Ebn1VwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwzcx4fV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso302340a12.3;
        Thu, 15 Feb 2024 20:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708056545; x=1708661345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ9C4C07Lh00QdEMEtLL7F2M/Vil3VvFnVKlElC+iJU=;
        b=mwzcx4fVqYo6YP3/p+OJBp2EqeOemf24U/B/c3aryo1z0Z5GJEgzEeYzgw/KQtMK5O
         7zWALR0cg6mUqmYl7AWMQwd5PgYJM5jagyHmygWN+p1mYcWGs2lUDGIRJzZ8IlPJwe7d
         YHLPKyndSx5GKGRv0NABZYsk7vLqjvdH2FyPzaR1o9m4gZ+GA5dsTHm24hsXABCrSVNc
         JJi0MpXAGVnrYCZzbshAn6z/qJG9xp7ZkGmTd/Y8jkCB7PnS3PVzoEE/OAe1SkaeSWZA
         Y6XnPmGpaUWTZnNpKet9eFzHIWmrIFsZgbfeo5n4AkITX9sKJJme59v+0+O41t+pzqGn
         T2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708056545; x=1708661345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ9C4C07Lh00QdEMEtLL7F2M/Vil3VvFnVKlElC+iJU=;
        b=rr2o9ZGkeflidRPpw8/LEAdJkzucagkxZDJJvUwtfI4uxNuW0KCt2sz7WvswmQEI+v
         DNkuR+1S4ik73TC6Jz6Ps3eIk5wYl1ckb/wNItj/MaqDg6pfqMGM+Mz5JUq4Xsic5vTL
         MGjZBFWxuj67vT9F3u6MN3bQtugdxTD6SJVBvqG9TiJTs/2CVlf1lhRmVLtelYpWbbrh
         4umz7Yp6QVm3RSdNp09sWpPreEmn+ZPvVy+GazVJ71Wi/uF+xaJ9hJxurw2734ifaXae
         ctcXtOiXG58VAkbUq/RSLxyXJ6CWpD3sIBNtV+rlhDz7xSxorUNBVSKocwHH2i4K4NQG
         hKww==
X-Forwarded-Encrypted: i=1; AJvYcCV/LOydAloFbm2JV4la88O8Ei5Ek5gVZ/zBohoOi5sJgpQrGbBqw0pUTXufjdFUYbqWcw4ftBp1boA6WCEOzMoYWbTJTJuYcurgKY51zviZHexKYGvL5ibwo+W8HdlbYTpmX7kTctPghHbb
X-Gm-Message-State: AOJu0YyXSC7P09Lvzybj5pcRieJ81/xzB/QSdAKe5f1RmtzEFAKR5Cah
	hneWZfRNdXqbhlaiizi4qU0s675zE90rlv50Ws/p5kEPwSYAH4vN
X-Google-Smtp-Source: AGHT+IGm+c27oE9nV1vTL6DqB17c0WIc/pNE/jU1ctzgiqcPDvRGxQ+m4LGav7LM74bm7qpn24bzHg==
X-Received: by 2002:a17:90b:3606:b0:299:3657:4950 with SMTP id ml6-20020a17090b360600b0029936574950mr257715pjb.2.1708056544708;
        Thu, 15 Feb 2024 20:09:04 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:f28b:3925:777f:45d4])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b00298ff26e4c8sm2321393pjb.26.2024.02.15.20.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:09:04 -0800 (PST)
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
Subject: [PATCH v2 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
Date: Fri, 16 Feb 2024 17:08:14 +1300
Message-Id: <20240216040815.114202-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216040815.114202-1-21cnbao@gmail.com>
References: <20240216040815.114202-1-21cnbao@gmail.com>
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
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 350dd2fc8159..6319d2281020 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
+	bool is_sleepable;
 };
 
 /*
@@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_sleepable(acomp);
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
 	if (!req) {
@@ -1368,7 +1370,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
+	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1382,7 +1384,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(zpool))
+	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


