Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F676EB2D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjHCNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjHCNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:49:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B714218;
        Thu,  3 Aug 2023 06:49:41 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGqtq22rpz1KC9Y;
        Thu,  3 Aug 2023 21:48:35 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:49:38 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <qiang.zhang1211@gmail.com>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH -next] rcu: Remove unused function declaration rcu_eqs_special_set()
Date:   Thu, 3 Aug 2023 21:49:19 +0800
Message-ID: <20230803134919.38832-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a86baa69c2b7 ("rcu: Remove special bit at the bottom of the ->dynticks counter")
left behind this, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/rcutree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 126f6b418f6a..153cfc7bbffd 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,7 +37,6 @@ void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
-bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
-- 
2.34.1

