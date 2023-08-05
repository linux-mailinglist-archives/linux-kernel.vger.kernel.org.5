Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773C770F66
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHELEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHELEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 07:04:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C04215
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 04:04:38 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RJ07P0W73zrS4q;
        Sat,  5 Aug 2023 19:03:29 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 19:04:35 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>
CC:     <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] cpu/hotplug: Remove unused function declaration cpu_set_state_online()
Date:   Sat, 5 Aug 2023 19:04:06 +0800
Message-ID: <20230805110406.45900-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5356297d12d9 ("cpu/hotplug: Remove cpu_report_state() and related unused cruft")
removed function but leave the declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6b326a9e8191..ed56b2534500 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -191,7 +191,6 @@ void arch_cpu_finalize_init(void);
 static inline void arch_cpu_finalize_init(void) { }
 #endif
 
-void cpu_set_state_online(int cpu);
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
 
 static inline void play_idle(unsigned long duration_us)
-- 
2.34.1

