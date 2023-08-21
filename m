Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4987824B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjHUHll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjHUHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:41:40 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D8B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:41:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692603697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e7RQqy7BBUhNj/8/XrD6FUXtKEsKzZzJXUAD1YqsjNk=;
        b=HwmtGZY4pQWX/BSwAcYXFNtHSt+aZhI2edVliI2Hvffqs8ZoM+CVIeCmzMfMAFv69fovMF
        v/umJa+wvhbbd5zbXimSknnRCkrT+1MZ4O2dgIb0qSaty4Du0oyp8DMwTL2DSfpzWGQIBm
        zfDmgNTKQEeFmPp15KPE/yj18LujX44=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 0/4] blk-mq-tag: remove bt_for_each()
Date:   Mon, 21 Aug 2023 15:35:24 +0800
Message-ID: <20230821073528.3469210-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

There are two almost identical mechanisms in blk-mq-tag to iterate over
requests of one tags: bt_for_each() and the newer bt_tags_for_each().

This series aim to add support of queue filter in bt_tags_for_each()
then remove bt_for_each(). Fix and update documentation as we're here.

Thanks for review!

Chengming Zhou (4):
  blk-mq-tag: support queue filter in bt_tags_iter()
  blk-mq-tag: remove bt_for_each()
  blk-mq: delete superfluous check in iterate callback
  blk-mq-tag: update or fix functions documentation

 block/blk-mq-tag.c | 176 ++++++++++++---------------------------------
 block/blk-mq.c     |  12 ++--
 2 files changed, 49 insertions(+), 139 deletions(-)

-- 
2.41.0

