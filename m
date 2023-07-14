Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94C753791
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjGNKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjGNKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:11:34 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49826BC;
        Fri, 14 Jul 2023 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1689329473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dTC6edpovjQeO4taZ580kPMKMfE3II88gvz0it+T+DI=;
  b=YxLqgjPKmW+h9zEvc1M8lCWFgSY3UR19CSKm7HmARhCqBs/Kvp/GijEx
   IkeKO+YtxR1FED00fEzS4aGqYNr/saMHGqmL8LqO8FGSE3UR9uuOsbQ66
   zdScTVkgrNpZX1niTIleOhp5bsSoX7nqIQW7/mRNu5J2pVdajXhcI6556
   E=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 115513386
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:xagDfqhrwjdHqTuMjUdX8QX9X161QBAKZh0ujC45NGQN5FlHY01je
 htvWWmFM/aDMGbzLd0nOtzn8hsAvJLdmN4yHVM/q3pkF3wb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyr0N8klgZmP6sT4waCzyB94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQzOikdTEncmN6n+4+HQMU8ps0udND0adZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJYw1MYH49tL7Aan3XaTpDsxSRrKU6+XfayAhZ27nxKtvFPNeNQK25m27B/
 z+bpj+iUk9y2Nq3+B6MriOXltD1xQDyQ6UND6y0zsYwjwjGroAUIEJPDgbqyRWjsWa+UNJ3K
 koa4CMioKE+skuxQbHVVg2yp3OsvRMGXddUVeE5gCmJy6zJ80OTAm8PTRZfZ9E88sw7Xzon0
 hmOhdyBLThutqCFDHGQ7LGZqRusNiUPa2wPfykJSU0C+daLnW0opkuRFJA5Svfz14CrX2iqm
 FhmsRTSmZ04n9cb9fzk4mzWuA+QrLSZbgc4vhzICzfNAhxCWGK1W2C5wQGFvacbdt7JFgbpU
 GsswJbHsr1XZX2ZvGnUGbhWQun0jxqQGGeE6WODCaXN4NhEF5SLWYlLqA9zK05yWirvUW+4O
 RSD0e+9CXI6AZdLUUOUS9jrYyjS5fK8fekJr9iNBja0XrB/dRWc4AZlblOK0mbmnSAEyP9va
 M3EKp7zUShHWcyLKQZaoc9HitfHIQhnlQvuqW3TlUz7gdJymlbIIVv6DLd+Rr9gt/7VyOkk2
 91eK9GL231ivB7WO0HqHXooBQlSdxATXMmmw/G7g8bfemKK7kl9Ua6OqV7gEqQ595loehDgo
 ivlBBIHlAKm3BUq62yiMxheVV8mZr4nxVpTAMDmFQzAN6QLCWp30JoiSg==
IronPort-HdrOrdr: A9a23:6IO9aazqiLd2HfVB2rhHKrPwIL1zdoMgy1knxilNoRw8SKKlfq
 eV7ZAmPH7P+VAssR4b+exoVJPtfZq+z+8R3WByB8bAYOCOggLBR+sO0WKL+UyGJ8SUzI9gPM
 lbHJSWcOeAb2RHsQ==
X-Talos-CUID: 9a23:vrIsZ22XLsEgd9w4k5j+trxfMdI8Yl+Ek2jsMnSFNWxFGJ2cRAeJ5/Yx
X-Talos-MUID: 9a23:rNjukwivUOLX8qgx7002CcMpBeNhv/WVGH83ybYPoO6bLj18Aw/Hg2Hi
X-IronPort-AV: E=Sophos;i="6.01,205,1684814400"; 
   d="scan'208";a="115513386"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>
Subject: [PATCH v2] blk-mq: Fix stall due to recursive flush plug
Date:   Fri, 14 Jul 2023 11:11:06 +0100
Message-ID: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen rare IO stalls as follows:

* blk_mq_plug_issue_direct() is entered with an mq_list containing two
requests.
* For the first request, it sets last == false and enters the driver's
queue_rq callback.
* The driver queue_rq callback indirectly calls schedule() which calls
blk_flush_plug(). This may happen if the driver has the
BLK_MQ_F_BLOCKING flag set and is allowed to sleep in ->queue_rq.
* blk_flush_plug() handles the remaining request in the mq_list. mq_list
is now empty.
* The original call to queue_rq resumes (with last == false).
* The loop in blk_mq_plug_issue_direct() terminates because there are no
remaining requests in mq_list.

The IO is now stalled because the last request submitted to the driver
had last == false and there was no subsequent call to commit_rqs().

Fix this by returning early in blk_mq_flush_plug_list() if rq_count is 0
which it will be in the recursive case, rather than checking if the
mq_list is empty. At the same time, adjust one of the callers to skip
the mq_list empty check as it is not necessary.

Fixes: dc5fc361d891 ("block: attempt direct issue of plug list")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

In v2:
* Update commit message and add a comment.

 block/blk-core.c | 3 +--
 block/blk-mq.c   | 9 ++++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 99d8b9812b18..90de50082146 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1144,8 +1144,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
-	if (!rq_list_empty(plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+	blk_mq_flush_plug_list(plug, from_schedule);
 	/*
 	 * Unconditionally flush out cached requests, even if the unplug
 	 * event came from schedule. Since we know hold references to the
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d..e6bd9c5f42bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2742,7 +2742,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct request *rq;
 
-	if (rq_list_empty(plug->mq_list))
+	/*
+	 * We may have been called recursively midway through handling
+	 * plug->mq_list via a schedule() in the driver's queue_rq() callback.
+	 * To avoid mq_list changing under our feet, clear rq_count early and
+	 * bail out specifically if rq_count is 0 rather than checking
+	 * whether the mq_list is empty.
+	 */
+	if (plug->rq_count == 0)
 		return;
 	plug->rq_count = 0;
 
-- 
2.39.3

