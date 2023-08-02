Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30076C969
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjHBJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjHBJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:24:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4801716
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:24:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RG6320rJhz1GDSK;
        Wed,  2 Aug 2023 17:23:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 17:24:11 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <lee@kernel.org>
CC:     <lizetao1@huawei.com>, <bot@kernelci.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: ipaq-micro: Remove unused variable i in micro_rx_msg()
Date:   Wed, 2 Aug 2023 17:23:42 +0800
Message-ID: <20230802092342.970476-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit "92d82d76c84", the variable i is unused. Remove it
to silence the warning.

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://lore.kernel.org/all/64c8aeac.170a0220.e3234.2745@mx.google.com/
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
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

