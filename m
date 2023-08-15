Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F6877C5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjHOCf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjHOCfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:36 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0013198D;
        Mon, 14 Aug 2023 19:35:28 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2YwpO067565;
        Tue, 15 Aug 2023 10:34:58 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKZ6cSCz2P8CXW;
        Tue, 15 Aug 2023 10:32:50 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:56 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 8/8] spi: add sprd ADI for UMS9620
Date:   Tue, 15 Aug 2023 10:34:26 +0800
Message-ID: <20230815023426.15076-8-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2YwpO067565
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for UMS9620.

Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
index 903b06f88b1b..8efea6dfcf25 100644
--- a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
+++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
@@ -51,6 +51,7 @@ properties:
       - sprd,sc9860-adi
       - sprd,sc9863-adi
       - sprd,ums512-adi
+      - sprd,ums9620-adi
 
   reg:
     maxItems: 1
-- 
2.17.1

