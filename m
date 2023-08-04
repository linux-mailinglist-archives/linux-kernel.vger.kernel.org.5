Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32776FCB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjHDI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjHDI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:58:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E45B89
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:53:47 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHKF11sjGzVk2H;
        Fri,  4 Aug 2023 16:51:01 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:52:48 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scftorture: Make torture_type static
Date:   Fri, 4 Aug 2023 16:52:16 +0800
Message-ID: <20230804085216.550-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

torture_type is not referred elsewhere, so make it static.

This resolves sparse warning:
  warning: symbol 'torture_type' was not declared. Should it be static?

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5d113aa59e77..b92da02d0293 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -67,7 +67,7 @@ torture_param(int, weight_many_wait, -1, "Testing weight for multi-CPU operation
 torture_param(int, weight_all, -1, "Testing weight for all-CPU no-wait operations.");
 torture_param(int, weight_all_wait, -1, "Testing weight for all-CPU operations.");
 
-char *torture_type = "";
+static char *torture_type = "";
 
 #ifdef MODULE
 # define SCFTORT_SHUTDOWN 0
-- 
2.17.1

