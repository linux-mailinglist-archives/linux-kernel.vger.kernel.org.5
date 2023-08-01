Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38776AE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjHAJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHAJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:37:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22624212A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:36:06 -0700 (PDT)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFTq01zspz1GDMk;
        Tue,  1 Aug 2023 17:10:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 17:11:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 17:11:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] sched/fair: change update_entity_lag() to static
Date:   Tue, 1 Aug 2023 17:08:57 +0800
Message-ID: <20230801090857.3994462-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update_entity_lag() introduced in commit
86bfbb7ce4f6 ("sched/fair: Add lag based placement")
is only used in fair.c now, change it to static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 857c5975c8c9..4e65e3964d96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -699,7 +699,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 lag, limit;
 
-- 
2.25.1

