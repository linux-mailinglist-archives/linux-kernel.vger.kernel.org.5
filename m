Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52691786540
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjHXCTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbjHXCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60347E6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C72633C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A219DC433C7;
        Thu, 24 Aug 2023 02:18:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvw-001hVh-2Y;
        Wed, 23 Aug 2023 22:18:52 -0400
Message-ID: <20230824021852.606651710@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Zekun <zhangzekun11@huawei.com>
Subject: [for-next][PATCH 11/14] ftrace: Remove empty declaration ftrace_enable_daemon() and
 ftrace_disable_daemon()
References: <20230824021812.938245293@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Zekun <zhangzekun11@huawei.com>

The definition of ftrace_enable_daemon() and ftrace_disable_daemon() has
been removed since commit cb7be3b2fc2c ("ftrace: remove daemon"), remain
the declarations in the header files, so remove it.

Link: https://lore.kernel.org/linux-trace-kernel/20230804013636.115940-1-zhangzekun11@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index aad9cf8876b5..e8921871ef9a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -862,13 +862,8 @@ extern int skip_trace(unsigned long ip);
 extern void ftrace_module_init(struct module *mod);
 extern void ftrace_module_enable(struct module *mod);
 extern void ftrace_release_mod(struct module *mod);
-
-extern void ftrace_disable_daemon(void);
-extern void ftrace_enable_daemon(void);
 #else /* CONFIG_DYNAMIC_FTRACE */
 static inline int skip_trace(unsigned long ip) { return 0; }
-static inline void ftrace_disable_daemon(void) { }
-static inline void ftrace_enable_daemon(void) { }
 static inline void ftrace_module_init(struct module *mod) { }
 static inline void ftrace_module_enable(struct module *mod) { }
 static inline void ftrace_release_mod(struct module *mod) { }
-- 
2.40.1
