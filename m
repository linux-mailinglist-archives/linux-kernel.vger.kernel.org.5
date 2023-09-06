Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664F57937CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjIFJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIFJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:11:35 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB67CF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:11:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693991490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qG460FgNFhKdaY3dmJoaOHX7Iauy/+u8xD5H0MOR+Ac=;
        b=vmMzK2Rj3PX7UooJCLeFPaAv1iSYk64HxKaGPljkjFaHMW9C8b2E9yIA7TevTKwq4OUj4J
        Y7GThUGLXHyFQFlH1UWG2PILZ/t4PEfi2LpK+0O+jFrQ15UhbPC4VG3a/tMJ8BLBX/qpC2
        w5vYK6pmbKBLOew47PmwtQaqMdydTPw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mm_init.c: remove redundant pr_info when node is memoryless
Date:   Wed,  6 Sep 2023 17:11:13 +0800
Message-Id: <20230906091113.4029983-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a similar pr_info in free_area_init_node(), so remove the
redundant pr_info.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mm_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..6be6f50813b1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1871,8 +1871,6 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 		pg_data_t *pgdat;
 
 		if (!node_online(nid)) {
-			pr_info("Initializing node %d as memoryless\n", nid);
-
 			/* Allocator not initialized yet */
 			pgdat = arch_alloc_nodedata(nid);
 			if (!pgdat)
-- 
2.25.1

