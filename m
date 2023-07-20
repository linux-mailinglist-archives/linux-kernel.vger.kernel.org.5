Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4075AB80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGTJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGTJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:55:25 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B407BE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:55:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JYO8AUEVeiLXQ+In8VJ0iP6vrymxYYiCE/Q88t5iZP4=;
        b=liiR8izGugvChbiOGmEZhqTabseMc+coEaFVZ5k4Ogo9fbIoGLlfQ1geKeIz8glXgWY91Y
        dj28rtyKnEDI0VG8IhOUwCBpXputS2nRQ7JbRHf/feYmG0OWlPRok7mK1tCuV1plt8g56w
        YbvTIQ8SpR7Enxj8d5TXDFZdW6f6T9I=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
Date:   Thu, 20 Jul 2023 17:55:12 +0800
Message-ID: <20230720095512.1403123-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

This counter is not used anywhere, so delete it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/blk-mq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 01e8c31db665..958ed7e89b30 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -393,8 +393,6 @@ struct blk_mq_hw_ctx {
 	 */
 	struct blk_mq_tags	*sched_tags;
 
-	/** @queued: Number of queued requests. */
-	unsigned long		queued;
 	/** @run: Number of dispatched requests. */
 	unsigned long		run;
 
-- 
2.41.0

