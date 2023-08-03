Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762C76ECE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjHCOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjHCOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:41:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799FF448F;
        Thu,  3 Aug 2023 07:40:50 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGs1h4gKSzrS8q;
        Thu,  3 Aug 2023 22:39:36 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:40:40 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] tracing: Remove unused function declarations
Date:   Thu, 3 Aug 2023 22:40:28 +0800
Message-ID: <20230803144028.25492-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9457158bbc0e ("tracing: Fix reset of time stamps during trace_clock changes")
left behind tracing_reset_current() declaration.
Also commit 6954e415264e ("tracing: Place trace_pid_list logic into abstract functions")
removed trace_free_pid_list() implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
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
2.34.1

