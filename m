Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89C1761AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGYOGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGYOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:06:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89944106
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:06:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE6B15BF;
        Tue, 25 Jul 2023 07:06:54 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.2.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C53FD3F6C4;
        Tue, 25 Jul 2023 07:06:09 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: Fix all W=1 build warnings
Date:   Tue, 25 Jul 2023 15:06:04 +0100
Message-Id: <20230725140604.1350406-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot looks for new warnings in a W=1 build, so fix all
the existing warnings to make it easier to spot new ones when building
locally.

The fixes are for undocumented function arguments and an incorrect doc
style.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti-core.c  | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 7023ff70cc28..3999d0a2cb60 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -22,7 +22,7 @@
 #include "coresight-priv.h"
 #include "coresight-cti.h"
 
-/**
+/*
  * CTI devices can be associated with a PE, or be connected to CoreSight
  * hardware. We have a list of all CTIs irrespective of CPU bound or
  * otherwise.
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index d2ea903231b2..c302072b293a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -40,7 +40,7 @@
  * Invalid offsets will result in fail code return and feature load failure.
  *
  * @drvdata:	driver data to map into.
- * @reg:	register to map.
+ * @reg_csdev:	register to map.
  * @offset:	device offset for the register
  */
 static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
@@ -132,7 +132,7 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
  * etm4_cfg_load_feature - load a feature into a device instance.
  *
  * @csdev:	An ETMv4 CoreSight device.
- * @feat:	The feature to be loaded.
+ * @feat_csdev:	The feature to be loaded.
  *
  * The function will load a feature instance into the device, checking that
  * the register definitions are valid for the device.
-- 
2.34.1

