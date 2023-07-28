Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06553766E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjG1NXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjG1NXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:23:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32328DB;
        Fri, 28 Jul 2023 06:23:48 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC7Zy6KYbzVjrs;
        Fri, 28 Jul 2023 21:22:02 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 21:23:39 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
        <yuehaibing@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] i2c: s3c2410: Remove unused extern declarations
Date:   Fri, 28 Jul 2023 21:23:18 +0800
Message-ID: <20230728132318.25072-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

commit 0d297df03890 ("ARM: s3c: simplify platform code") left behind
s3c_i2c(*)_set_platdata().
commit d78c16ccde96 ("ARM: SAMSUNG: Remove remaining legacy code")
leave s5p_i2c_hdmiphy_set_platdata() declaration.
And commit bad1e6aadd17 ("ARM: SAMSUNG: Cleanup plat-samsung/devs.c and devs.h")
leave s3c_i2c(*)_cfg_gpio() alone.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/platform_data/i2c-s3c2410.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/platform_data/i2c-s3c2410.h b/include/linux/platform_data/i2c-s3c2410.h
index 550746715139..c8c3146c34ea 100644
--- a/include/linux/platform_data/i2c-s3c2410.h
+++ b/include/linux/platform_data/i2c-s3c2410.h
@@ -52,23 +52,10 @@ struct s3c2410_platform_i2c {
  */
 extern void s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *i2c);
 extern void s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s5p_i2c_hdmiphy_set_platdata(struct s3c2410_platform_i2c *i2c);
 
 /* defined by architecture to configure gpio */
 extern void s3c_i2c0_cfg_gpio(struct platform_device *dev);
 extern void s3c_i2c1_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c2_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c3_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c4_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c5_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c6_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c7_cfg_gpio(struct platform_device *dev);
 
 extern struct s3c2410_platform_i2c default_i2c_data;
 
-- 
2.34.1

