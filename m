Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644C0787EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjHYDiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbjHYDiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:38:08 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26171BD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:38:05 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37P3bDZO075933;
        Fri, 25 Aug 2023 11:37:13 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RX5DQ3gD9z2QTWgH;
        Fri, 25 Aug 2023 11:34:46 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 25 Aug
 2023 11:37:12 +0800
From:   Linhua Xu <Linhua.xu@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH 5/6] pinctrl: sprd: Increase the range of register values
Date:   Fri, 25 Aug 2023 11:18:25 +0800
Message-ID: <20230825031826.31599-6-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825031826.31599-1-Linhua.xu@unisoc.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 37P3bDZO075933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

As the UNISOC pin controller version iterates, more registers are required
to meet new functional requirements. Thus modify them.

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h b/drivers/pinctrl/sprd/pinctrl-sprd.h
index a696f81ce663..43b920f27bf9 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.h
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
@@ -9,17 +9,17 @@
 
 struct platform_device;
 
-#define NUM_OFFSET	(20)
-#define TYPE_OFFSET	(16)
-#define BIT_OFFSET	(8)
-#define WIDTH_OFFSET	(4)
+#define NUM_OFFSET	(22)
+#define TYPE_OFFSET	(18)
+#define BIT_OFFSET	(10)
+#define WIDTH_OFFSET	(6)
 
 #define SPRD_PIN_INFO(num, type, offset, width, reg)	\
 		(((num) & 0xFFF) << NUM_OFFSET |	\
 		 ((type) & 0xF) << TYPE_OFFSET |	\
 		 ((offset) & 0xFF) << BIT_OFFSET |	\
 		 ((width) & 0xF) << WIDTH_OFFSET |	\
-		 ((reg) & 0xF))
+		 ((reg) & 0x1F))
 
 #define SPRD_PINCTRL_PIN(pin)	SPRD_PINCTRL_PIN_DATA(pin, #pin)
 
@@ -30,7 +30,7 @@ struct platform_device;
 		.type = (((a) >> TYPE_OFFSET) & 0xf),		\
 		.bit_offset = (((a) >> BIT_OFFSET) & 0xff),	\
 		.bit_width = ((a) >> WIDTH_OFFSET & 0xf),	\
-		.reg = ((a) & 0xf)				\
+		.reg = ((a) & 0x1f)				\
 	}
 
 enum pin_type {
-- 
2.17.1

