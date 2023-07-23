Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7375E4B7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGWUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWUG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7EE40
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 652CE60E9E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3970C433CB;
        Sun, 23 Jul 2023 20:06:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qNfLx-001c2C-2D;
        Sun, 23 Jul 2023 16:06:53 -0400
Message-ID: <20230723200653.506168754@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 23 Jul 2023 16:06:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [for-linus][PATCH 1/3] tracing: Remove unused extern declaration
 tracing_map_set_field_descr()
References: <20230723200623.034313147@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Since commit 08d43a5fa063 ("tracing: Add lock-free tracing_map"),
this is never used, so can be removed.

Link: https://lore.kernel.org/linux-trace-kernel/20230722032123.24664-1-yuehaibing@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 2c765ee2a4d4..99c37eeebc16 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -272,10 +272,6 @@ extern u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i);
 
-extern void tracing_map_set_field_descr(struct tracing_map *map,
-					unsigned int i,
-					unsigned int key_offset,
-					tracing_map_cmp_fn_t cmp_fn);
 extern int
 tracing_map_sort_entries(struct tracing_map *map,
 			 struct tracing_map_sort_key *sort_keys,
-- 
2.40.1
