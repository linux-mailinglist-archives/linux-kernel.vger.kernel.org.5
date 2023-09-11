Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7779A462
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjIKHZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIKHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:25:20 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E639CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:25:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VrnkK5U_1694417111;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VrnkK5U_1694417111)
          by smtp.aliyun-inc.com;
          Mon, 11 Sep 2023 15:25:13 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        Jay Chen <jkchen@linux.alibaba.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH] coresight: etm4x: Add ACPI id for THEAD YiTian SOC
Date:   Mon, 11 Sep 2023 15:25:09 +0800
Message-Id: <20230911072509.126063-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Chen <jkchen@linux.alibaba.com>

Add support for detcting ETE device of THEAD YiTian SOC.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 77b0271ce6eb..329bb554b168 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2351,6 +2351,7 @@ static const struct of_device_id etm4_sysreg_match[] = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id etm4x_acpi_ids[] = {
 	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
+	{"BABA6000", 0 }, /* THEAD CoreSight ETE */
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
-- 
2.33.1

