Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C136777F583
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbjHQLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350437AbjHQLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:45:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF01728
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:45:28 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRNQB2V4TzNmm2;
        Thu, 17 Aug 2023 19:41:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 19:45:26 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <lizetao1@huawei.com>
CC:     <bot@kernelci.org>, <lee@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] mfd: ipaq-micro: Remove unused variable i in micro_rx_msg()
Date:   Thu, 17 Aug 2023 19:45:05 +0800
Message-ID: <20230817114505.1810920-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802092342.970476-1-lizetao1@huawei.com>
References: <20230802092342.970476-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a warning reported by kernel test robot:

drivers/mfd/ipaq-micro.c:81:6: warning:
	unused variable ‘i’ [-Wunused-variable]

Since the commit 92d82d76c842 ("mfd: ipaq-micro: Use %*ph for printing
hexdump of a small buffer"), the variable 'i' is unused. Remove it to
silence the warning.

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://lore.kernel.org/all/64c8aeac.170a0220.e3234.2745@mx.google.com/
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Modify the format of the reference commit and add warning
information
v1: https://lore.kernel.org/all/20230802092342.970476-1-lizetao1@huawei.com/

 drivers/mfd/ipaq-micro.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index cddfd2e808f2..c964ea6539aa 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -78,8 +78,6 @@ EXPORT_SYMBOL(ipaq_micro_tx_msg);
 
 static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 {
-	int i;
-
 	dev_dbg(micro->dev, "RX msg: %02x, %d bytes\n", id, len);
 
 	spin_lock(&micro->lock);
-- 
2.34.1

