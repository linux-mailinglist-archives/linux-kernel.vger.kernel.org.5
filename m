Return-Path: <linux-kernel+bounces-11855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404681EC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473A9B224BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2546ABD;
	Wed, 27 Dec 2023 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/jJP4jv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F56AA3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ba14203a34so5096194b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703658215; x=1704263015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AP6TTZGYZvR9kHCkhdIlC9uA60kF06pnesaOZz6qvzM=;
        b=d/jJP4jvI0YJ4tRlbejSoCruKhDe8WxJ4b+np4WVj5bV4/F6ZYAGi2HVC+fynbIPzJ
         3u/m6oNy7yX2hJX+IsMLKEDFWlnGUI6aSzC49MI88R7ofd75bHxYzqKh6pvCWL1/zFbX
         CkoY/Vkc5dDhjm8SLw2y0O1COm8gni1OkRcDEFSRX4VLTdYiBkccjxslUAzvBo5Ul601
         YmyH2oLjIbLh1So66q1lWBOwMzcLDGQR11aqrbBTXABcvI+3caobxa6DVKtPr2XEjb+h
         cBnHJVkA9GszREdCr2FK1BkbTGr/rCw+EY5CuxyLUCsDxWeZbtabf43la0J0UCfqEjb8
         +mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703658215; x=1704263015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AP6TTZGYZvR9kHCkhdIlC9uA60kF06pnesaOZz6qvzM=;
        b=Ujp5/epcKb/QFhxQdDp3PSv43v96aozVLo0vTQsB/433QzebcjZTyyvEYxws/ZIkMj
         /wGOhcO7LbMid1G6tGgTe5RtssBhz8BqqTdoRZUqxhZ4+N2pxzg6wyzWdAo+07tZscd4
         luRO6wcEwy9WO3FXhEaYD/mJ2Ft31bfCU2rEewxZx8nvQjMuyYYMyHacffwwW8ge0O2J
         mOpE2PS4wrLPMN0scL9YdMYbOy4eo5+pio31Iea4RAJxWwQp37bsUUCCr7LgdAZHEgg8
         GrvgdfTZUzIPqwO9DrA4tflBUzYrbMSZPvHHt++sLrVBSO9aaUFTcUlAUs4RrpQmrNeV
         wjtA==
X-Gm-Message-State: AOJu0Yy7P9m0t4azMfC9WSxw3AsYjAbuGxyLMvlF1+g2gvQv85dpt/ox
	yD7jamtIDMjx8y/T/E7Jf2c=
X-Google-Smtp-Source: AGHT+IEQnS7vuOvg/nAGGlBYshazr+OpTFsczOIxBKICvJiuY0y9UfgggJ7L/wkKYVZkauUyHhxH2Q==
X-Received: by 2002:a05:6808:1598:b0:3bb:c930:47fe with SMTP id t24-20020a056808159800b003bbc93047femr46219oiw.46.1703658215139;
        Tue, 26 Dec 2023 22:23:35 -0800 (PST)
Received: from arm4c24g.vcn09251619.oraclevcn.com ([144.24.45.176])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000cd300b006d99125b114sm8028907pfv.65.2023.12.26.22.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 22:23:34 -0800 (PST)
From: Xiaobing Luo <luoxiaobing0926@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xiaobing Luo <luoxiaobing0926@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/cma: change print format of pointer in pr_debug() With %p, the pointer will be hashed and print (____ptrval____) instead.
Date: Wed, 27 Dec 2023 06:18:25 +0000
Message-Id: <20231227061825.116177-1-luoxiaobing0926@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 [    0.070467] cma: cma_alloc(cma (____ptrval____), count 256, align 8)
 [    0.073003] cma: cma_alloc(): returned (____ptrval____)

Use 0x%px instead of %p to print the pointer. Then the print will be like:

 [    0.054963] cma: cma_alloc(cma 0xffffffde9ad42a60, count 256, align 8)
 [    0.057385] cma: cma_alloc(): returned 0xfffffffe003b0000

Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>
---
 mm/cma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2b2494fd6b59..4559f903df8f 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -440,7 +440,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
 
-	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
+	pr_debug("%s(cma 0x%px, name: %s, count %lu, align %d)\n", __func__,
 		(void *)cma, cma->name, count, align);
 
 	if (!count)
@@ -487,7 +487,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		if (ret != -EBUSY)
 			break;
 
-		pr_debug("%s(): memory range at pfn 0x%lx %p is busy, retrying\n",
+		pr_debug("%s(): memory range at pfn 0x%lx 0x%px is busy, retrying\n",
 			 __func__, pfn, pfn_to_page(pfn));
 
 		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
@@ -514,7 +514,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		cma_debug_show_areas(cma);
 	}
 
-	pr_debug("%s(): returned %p\n", __func__, page);
+	pr_debug("%s(): returned 0x%px\n", __func__, page);
 out:
 	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
@@ -539,7 +539,7 @@ bool cma_pages_valid(struct cma *cma, const struct page *pages,
 	pfn = page_to_pfn(pages);
 
 	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count) {
-		pr_debug("%s(page %p, count %lu)\n", __func__,
+		pr_debug("%s(page 0x%px, count %lu)\n", __func__,
 						(void *)pages, count);
 		return false;
 	}
@@ -565,7 +565,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 	if (!cma_pages_valid(cma, pages, count))
 		return false;
 
-	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
+	pr_debug("%s(page 0x%px, count %lu)\n", __func__, (void *)pages, count);
 
 	pfn = page_to_pfn(pages);
 
-- 
2.34.1


