Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61B786547
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjHXCTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbjHXCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FD10D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50EA640A7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3423C433C7;
        Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvw-001hV9-1t;
        Wed, 23 Aug 2023 22:18:52 -0400
Message-ID: <20230824021852.401456868@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Haibing <yuehaibing@huawei.com>
Subject: [for-next][PATCH 10/14] tracing: Remove unused function declarations
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

From: Yue Haibing <yuehaibing@huawei.com>

Commit 9457158bbc0e ("tracing: Fix reset of time stamps during trace_clock changes")
left behind tracing_reset_current() declaration.
Also commit 6954e415264e ("tracing: Place trace_pid_list logic into abstract functions")
removed trace_free_pid_list() implementation but leave declaration.

Link: https://lore.kernel.org/linux-trace-kernel/20230803144028.25492-1-yuehaibing@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5b1f9e24764a..b6e44a39b4ce 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -604,7 +604,6 @@ trace_buffer_iter(struct trace_iterator *iter, int cpu)
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
-void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
@@ -705,7 +704,6 @@ void trace_filter_add_remove_task(struct trace_pid_list *pid_list,
 void *trace_pid_next(struct trace_pid_list *pid_list, void *v, loff_t *pos);
 void *trace_pid_start(struct trace_pid_list *pid_list, loff_t *pos);
 int trace_pid_show(struct seq_file *m, void *v);
-void trace_free_pid_list(struct trace_pid_list *pid_list);
 int trace_pid_write(struct trace_pid_list *filtered_pids,
 		    struct trace_pid_list **new_pid_list,
 		    const char __user *ubuf, size_t cnt);
-- 
2.40.1
