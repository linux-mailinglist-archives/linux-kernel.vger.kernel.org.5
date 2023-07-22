Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C975D93C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGVCzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGVCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:55:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D41701;
        Fri, 21 Jul 2023 19:55:08 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R79vR4kRWzHnhd;
        Sat, 22 Jul 2023 10:52:35 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 10:55:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ACPI: Remove unsued extern declaration acpi_paddr_to_node()
Date:   Sat, 22 Jul 2023 10:55:05 +0800
Message-ID: <20230722025505.5052-1-yuehaibing@huawei.com>
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

This is never used since commit 1e3590e2e4a3 ("[PATCH] pgdat allocation for new node
add (get node id by acpi)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/acpi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc4843987..58a0fdf68ca2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,8 +477,6 @@ static inline int acpi_get_node(acpi_handle handle)
 	return 0;
 }
 #endif
-extern int acpi_paddr_to_node(u64 start_addr, u64 size);
-
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
-- 
2.34.1

