Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847B7FD49F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjK2Kpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjK2Kpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:45:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0A10D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:45:48 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so5351980b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701254748; x=1701859548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WUGmqoJPaeTzET/O78MEEgB8PQJztuihLmKtgPXGxM=;
        b=cevsIwfUjDSpF4Nq9v5TmQfzRVoIbtgaoQDeATM5qX0YASQFaAUY15y+F+F3JBpii0
         SI6mU9r4BrkqZlVgHsCBM8KxfqP1EzBm2RJB3hjaLmzX8Zkl7iwR0ScMgw3EAu/uVpyd
         yLbQ1C5ZmDgW2Hj/OxRZCvzfNguglyfbSRxhmBhzbWJBe26DAMyLXndeniFzYL7Zx7WN
         i+bd1vlWTI3WUmgBpd4FATF309aLm5510FLog+ukZACZc+CF7bnQNgTRRsusqxwOAJR2
         2E1NMQp/Hovr7vafYeBFCOy7wEQu+5rssjUdZkaRZgHkO8n7zMNZfxCgnZOXWH9PYB0g
         I+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701254748; x=1701859548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WUGmqoJPaeTzET/O78MEEgB8PQJztuihLmKtgPXGxM=;
        b=kS+5s7Q/aRP/q3O0Zcgtn1pTZUkN6IVZmoLirIvPwBqgwuJaDKdVSNUIjIfp5P2qoY
         h4f+lHW14JZp33KR5eYSE6nJmZsHUSJJ22PjoyC5aB6kK0/6UBHDzaC8edCT8208nfU1
         guvi5sYN3SEChqFO7FhPBetvPYykmNMvWyqfRnfwBEGCu18hElN61C6HGVdSlAVLSnYi
         qMix/xlGphBAp1/8D4kdhHFiEYV9Z3pPcXEbv2TfFr38JrIs+v/FZuJHzbMzgjVg4F/1
         UUI1gd1+vg5Bl/EW6SqGJJibYUbPsVF60b+khWOpq6n/NX/tDdWk4YyPD3RPgIBzPvlx
         92lA==
X-Gm-Message-State: AOJu0YwrySSPPKJ9e6lCQ69QxKF/v/hse9IANUduSBzoi1QPaoB5a95M
        gH+G3fe8KAPTyvktyZqYN4w=
X-Google-Smtp-Source: AGHT+IHysOytrkTST2jcGXPY02XcKwCnysM0RueAvsHVUcsNAXvv5s58XHBB2X2LY1B+xAL/f+cnQQ==
X-Received: by 2002:a05:6a20:a10a:b0:18a:e176:87e9 with SMTP id q10-20020a056a20a10a00b0018ae17687e9mr15899897pzk.15.1701254747980;
        Wed, 29 Nov 2023 02:45:47 -0800 (PST)
Received: from barry-desktop.. (47-72-151-223.dsl.dyn.ihug.co.nz. [47.72.151.223])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79112000000b0068fcb70ccafsm10425917pfh.129.2023.11.29.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:45:47 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     david@redhat.com, shikemeng@huaweicloud.com, willy@infradead.org,
        mgorman@techsingularity.net, hannes@cmpxchg.org,
        baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        Barry Song <v-songbaohua@oppo.com>,
        Zhanyuan Hu <huzhanyuan@oppo.com>
Subject: [RFC PATCH] mm: compaction: avoid fast_isolate_freepages blindly choose improper pageblock
Date:   Wed, 29 Nov 2023 23:45:30 +1300
Message-Id: <20231129104530.63787-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing shows fast_isolate_freepages can blindly choose an unsuitable
pageblock from time to time particularly while the min mark is used
from XXX path:
 if (!page) {
         cc->fast_search_fail++;
         if (scan_start) {
                 /*
                  * Use the highest PFN found above min. If one was
                  * not found, be pessimistic for direct compaction
                  * and use the min mark.
                  */
                 if (highest >= min_pfn) {
                         page = pfn_to_page(highest);
                         cc->free_pfn = highest;
                 } else {
                         if (cc->direct_compaction && pfn_valid(min_pfn)) { /* XXX */
                                 page = pageblock_pfn_to_page(min_pfn,
                                         min(pageblock_end_pfn(min_pfn),
                                             zone_end_pfn(cc->zone)),
                                         cc->zone);
                                 cc->free_pfn = min_pfn;
                         }
                 }
         }
 }

In contrast, slow path is skipping unsuitable pageblocks in a decent way.

I don't know if it is an intended design or just an oversight. But
it seems more sensible to skip unsuitable pageblock.

Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/compaction.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..98c485a25614 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1625,6 +1625,12 @@ static void fast_isolate_freepages(struct compact_control *cc)
 	cc->total_free_scanned += nr_scanned;
 	if (!page)
 		return;
+	/*
+	 * Otherwise, we can blindly choose an improper pageblock especially
+	 * while using the min mark
+	 */
+	if (!suitable_migration_target(cc, page))
+		return;
 
 	low_pfn = page_to_pfn(page);
 	fast_isolate_around(cc, low_pfn);
-- 
2.34.1

