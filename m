Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3443E768104
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjG2Sej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjG2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257B3588
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9921560AD7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B4DC433C8;
        Sat, 29 Jul 2023 18:34:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPoli-0035Kg-0D;
        Sat, 29 Jul 2023 14:34:22 -0400
Message-ID: <20230729183421.877315009@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-linus][PATCH 5/7] tracing: Fix kernel-doc warnings in trace_seq.c
References: <20230729183333.357029101@goodmis.org>
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

Fix kernel-doc warning:

kernel/trace/trace_seq.c:142: warning: Function parameter or member
'args' not described in 'trace_seq_vprintf'

Link: https://lkml.kernel.org/r/20230724140827.1023266-5-cuigaosheng1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_seq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index e5e299260d0c..bac06ee3b98b 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -131,6 +131,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
  * trace_seq_vprintf - sequence printing of trace information
  * @s: trace sequence descriptor
  * @fmt: printf format string
+ * @args: Arguments for the format string
  *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formatting of a trace
-- 
2.40.1
