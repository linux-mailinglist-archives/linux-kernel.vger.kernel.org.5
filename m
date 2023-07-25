Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9DA761A71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGYNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGYNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21076A1;
        Tue, 25 Jul 2023 06:48:21 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9JDl5WTszCrLy;
        Tue, 25 Jul 2023 21:44:55 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:48:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ftrace: Remove unused extern declarations
Date:   Tue, 25 Jul 2023 21:48:08 +0800
Message-ID: <20230725134808.9716-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6a9c981b1e96 ("ftrace: Remove unused function ftrace_arch_read_dyn_info()")
left ftrace_arch_read_dyn_info() extern declaration.
And commit 1d74f2a0f64b ("ftrace: remove ftrace_ip_converted()")
leave ftrace_ip_converted() declaration.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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
2.34.1

