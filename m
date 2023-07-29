Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDCF768102
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjG2Sef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjG2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49ED30FA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8D7E60AF3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AD5C433CB;
        Sat, 29 Jul 2023 18:34:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPoli-0035LE-0s;
        Sat, 29 Jul 2023 14:34:22 -0400
Message-ID: <20230729183422.087580772@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [for-linus][PATCH 6/7] ftrace: Remove unused extern declarations
References: <20230729183333.357029101@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 6a9c981b1e96 ("ftrace: Remove unused function ftrace_arch_read_dyn_info()")
left ftrace_arch_read_dyn_info() extern declaration.
And commit 1d74f2a0f64b ("ftrace: remove ftrace_ip_converted()")
leave ftrace_ip_converted() declaration.

Link: https://lore.kernel.org/linux-trace-kernel/20230725134808.9716-1-yuehaibing@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce156c7704ee..aad9cf8876b5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -684,7 +684,6 @@ void __init
 ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable);
 
 /* defined in arch */
-extern int ftrace_ip_converted(unsigned long ip);
 extern int ftrace_dyn_arch_init(void);
 extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
@@ -859,9 +858,6 @@ static inline int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_a
 }
 #endif
 
-/* May be defined in arch */
-extern int ftrace_arch_read_dyn_info(char *buf, int size);
-
 extern int skip_trace(unsigned long ip);
 extern void ftrace_module_init(struct module *mod);
 extern void ftrace_module_enable(struct module *mod);
-- 
2.40.1
