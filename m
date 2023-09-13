Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A8D79DEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbjIMDvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbjIMDvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:22 -0400
Received: from out-211.mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174C172B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:51:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJ+K59AtY5YkcpgFDD7Z6/goeR9+RX3ce7piF7Aa0ls=;
        b=ec8W6HwLVuud2KIvlVS4SYZAbsWXI7UUGxXY9Ut/TyTKG3LM275Rxk+Wj9LxEWy+VkzHdk
        daotb2zixe1uiRnmvd7iqjXHY91/2BPW0OVtoMC2ik2Tci1U6oqAHBCHggCR/Fm3022Wz2
        iaFoMP5HWb+YA8QwELrFDILYH2ONp5s=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 6/6] blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation
Date:   Wed, 13 Sep 2023 03:50:33 +0000
Message-Id: <20230913035033.1549277-7-chengming.zhou@linux.dev>
In-Reply-To: <20230913035033.1549277-1-chengming.zhou@linux.dev>
References: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The blk_mq_queue_tag_busy_iter() is only used to iterate over requests
of the specified queue, fix the documentation.

Fixes: c7b1bf5cca76 ("blk-mq: Document the functions that iterate over requests")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0d42f3c4d76e..69b156750559 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -433,8 +433,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * @priv:	Will be passed as second argument to @fn.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
- * called for all requests on all queues that share that tag set and not only
- * for requests associated with @q.
+ * called only for requests associated with @q.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
-- 
2.40.1

