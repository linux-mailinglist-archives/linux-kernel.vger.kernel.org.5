Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8B754696
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGODhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGODhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:37:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC6F19B4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:37:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R2v973F39zLnlY;
        Sat, 15 Jul 2023 11:34:35 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 15 Jul
 2023 11:36:58 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] memory tier: Use helper macro __ATTR_RW()
Date:   Sat, 15 Jul 2023 11:37:08 +0800
Message-ID: <20230715033708.2568201-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro __ATTR_RW to define numa demotion attributes. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-tiers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c49ab03f49b1..2898701b5209 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -693,8 +693,7 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
 }
 
 static struct kobj_attribute numa_demotion_enabled_attr =
-	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
-	       numa_demotion_enabled_store);
+	__ATTR_RW(numa_demotion_enabled);
 
 static struct attribute *numa_attrs[] = {
 	&numa_demotion_enabled_attr.attr,
-- 
2.33.0

