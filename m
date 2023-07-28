Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E71766EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjG1Nu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjG1Num (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:50:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C794421D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:50:37 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RC7gk46wDzLnxP;
        Fri, 28 Jul 2023 21:26:10 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 21:28:47 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <lee@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: 88pm860x: Remove unused extern declarations
Date:   Fri, 28 Jul 2023 21:28:41 +0800
Message-ID: <20230728132841.10648-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 260a127bfbeb ("mfd: 88pm860x-i2c: Purge unused functions")
left behind this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/mfd/88pm860x.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 473545a2c425..6fa21791fc85 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -472,13 +472,7 @@ extern int pm860x_bulk_read(struct i2c_client *, int, int, unsigned char *);
 extern int pm860x_bulk_write(struct i2c_client *, int, int, unsigned char *);
 extern int pm860x_set_bits(struct i2c_client *, int, unsigned char,
 			   unsigned char);
-extern int pm860x_page_reg_read(struct i2c_client *, int);
 extern int pm860x_page_reg_write(struct i2c_client *, int, unsigned char);
 extern int pm860x_page_bulk_read(struct i2c_client *, int, int,
 				 unsigned char *);
-extern int pm860x_page_bulk_write(struct i2c_client *, int, int,
-				  unsigned char *);
-extern int pm860x_page_set_bits(struct i2c_client *, int, unsigned char,
-				unsigned char);
-
 #endif /* __LINUX_MFD_88PM860X_H */
-- 
2.34.1

