Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95579DEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjIMDvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjIMDvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:08 -0400
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FD172C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:51:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aeyr0b8bkN4XBJ+a0mzzF1/q2aGdqqSXg3ngYkNm6+A=;
        b=k6T9cjd09/oWsfoS1Z0mAxCYfxs6/85c7/1HNB0lo1xf2PF2eEqgSb9tXNsdQxYEDgYuk7
        MCPnbjnJavUmGQZ3hvbLb2VlYyPOCtJgXmcK/D3h9SYYXkUEq6JRT0fiV0nAU+064hq4Px
        R9xGy2/IKYPlXbAaFizIEqEfnx93sjc=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 0/6] blk-mq-tag: remove bt_for_each()
Date:   Wed, 13 Sep 2023 03:50:27 +0000
Message-Id: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Changes in v4:
  - Add Reviewed-by tag from Bart Van Assche. Thanks for review!
  - Rebased on the newest block/for-next branch.

Changes in v3:
  - Document the argument 'q' in the patch which add it.
  - Add Fixes tag and Reviewed-by tags.

Changes in v2:
  - Split by one change per patch and add Fixes tag.
  - Improve commit messages, suggested by Bart Van Assche.

There are two almost identical mechanisms in blk-mq-tag to iterate over
requests of one tags: bt_for_each() and the newer bt_tags_for_each().

This series aim to add support of queue filter in bt_tags_for_each()
then remove bt_for_each(). Fix and update documentation as we're here.

Thanks for review!

Chengming Zhou (6):
  blk-mq-tag: support queue filter in bt_tags_iter()
  blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
  blk-mq-tag: remove bt_for_each()
  blk-mq: delete superfluous check in iterate callback
  blk-mq-tag: fix functions documentation
  blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation

 block/blk-mq-tag.c | 176 ++++++++++++---------------------------------
 block/blk-mq.c     |  12 ++--
 2 files changed, 49 insertions(+), 139 deletions(-)

-- 
2.40.1

