Return-Path: <linux-kernel+bounces-15104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20002822746
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27EF1F22A01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D7016406;
	Wed,  3 Jan 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOic/KjS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC064A3B;
	Wed,  3 Jan 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdfa676fa3so35930a12.1;
        Tue, 02 Jan 2024 18:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704250703; x=1704855503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8Y0j0Jt26z5Mz6Dk1T+PNwiPxDyxcm45d9joAfXn8=;
        b=ZOic/KjSNCc7P18PRT39Lc29QHs4x43NpAsrOCUVt7q6t5OfJskYU+DFIaIL5Yguir
         EW+nYFoSRIAWI6JrtQ9NtU+H9Py2JOXkKMN/6zyE2QyP9pX+AHhX1PNbhhs5+3cW7lyM
         VE0UOunB/JlQi/5MAkNwGlM4NK2lRYDid/+sgk0EyzHoPkyGDq5rinKWiGj5PtCz/dQW
         zQEVggwXYUnoIC2KHoEldrHvWcgwLEdzuiDAvGYyYlZa2kjAuNRY0+6jIyQUPKgoSIHh
         smmZioJhqYzgmOkJ+fYZ3uTSdq/oSEhNLnjp+HAmFKGowg8CESeVJRqjMEEkWbO3ttDS
         mtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704250703; x=1704855503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro8Y0j0Jt26z5Mz6Dk1T+PNwiPxDyxcm45d9joAfXn8=;
        b=l9czeXcaWuL2tpvXHDixxlxY+f1s9nIiaf1UtowyMaen2qEHjSyqMW6sTJVJn1b66B
         icG4xDxH4i4MwEj9sbAteDmyn06HRInsUPbcOdmn7T70YyF5/xlXXRGlblXRLnPKcqdj
         6aGrtn8P7Cw2HHC7xdR4GjccM7qPmYAB3mYmZQMBCThx4A5s3kiAj2qSrk1npGeBbW14
         4581qrJNyNQrx/hE9gyhWH33oEKtRg/fCCY+kY5egV3tNM9hqevrQIvwt6kT+B+cOokG
         OhKPPPk7ssiIFNGqhetqLn3L8/2xyTwWkcRngQHVfg9QiWUH0UqaO1X/C4fiiNshohjw
         QH8w==
X-Gm-Message-State: AOJu0YxpmnDG26qusKeblCBMfRqvVRTjtUeZjYOfC/HR2sU7S2pO6qtC
	rF5itL7D1ZG7cu3HmzpUABA=
X-Google-Smtp-Source: AGHT+IHg0kL0VkhfiKjZqGlDkvzVw6ytZtdeJvrtTSssilg7C2zxj//va2NtexTtk2eArS6S4PPYUQ==
X-Received: by 2002:a05:6a20:2443:b0:196:c543:abaf with SMTP id t3-20020a056a20244300b00196c543abafmr513723pzc.38.1704250702826;
        Tue, 02 Jan 2024 18:58:22 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id d6-20020a63fd06000000b005cd8ada89e5sm21168572pgh.70.2024.01.02.18.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 18:58:22 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 2/2] mm/zswap: remove the memcpy if acomp is not asynchronous
Date: Wed,  3 Jan 2024 15:57:58 +1300
Message-Id: <20240103025759.523120-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103025759.523120-1-21cnbao@gmail.com>
References: <ZY1EnEefZsRTGYnP@gondor.apana.org.au>
 <20240103025759.523120-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Most compressors are actually CPU-based, they won't sleep during
decompression. we should be able to remove the redundant memcpy
for them.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
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


