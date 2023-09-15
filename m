Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3FD7A20ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjIOO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjIOO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:29:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A426B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:29:17 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38FC3mvV012750;
        Fri, 15 Sep 2023 09:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=T
        rz4kyXVUWgb16VKCTRJ4EijKbpUCL5Y3dKsrQduNlA=; b=eQWyeMKkCdDWxT/ig
        Ufc7P3zTqlfaHz7mt3AxHxDZxqoWUemlLCVvZHQiKK6hhTQmWOR5fBdwQglLp5SL
        b/ejYZQu2/ZBA3VyIlGsdwAUvEKljyuNIwhdsNvEP675NOLyqZL1Db7ywhKpz70A
        4hyetptgLYV1y0AF27fQNz8sUTVMph4Z5o1Jx4Mgv/5Ty44S5jURSmC5LjJpS3w4
        p6EABKeecLRzW63DqmA1RBDjWT+7LzqqgpOIra6YbEgmih/h6EPlklR7X2YQJGaU
        LOlngY3gE8M5Q4tSTv801D6Vi5WjYRqwY3dMitnRvUq2G451pcA3roEGE3fFnpJa
        rOyzg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7skhur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 09:29:01 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 15 Sep
 2023 15:29:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 15 Sep 2023 15:29:00 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DFED3563;
        Fri, 15 Sep 2023 14:29:00 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] soundwire: bus: Add explicit include for irqdomain.h
Date:   Fri, 15 Sep 2023 15:29:00 +0100
Message-ID: <20230915142900.34498-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CD4twaIgADeMT_VdDTyjJplg3AtC74Jh
X-Proofpoint-ORIG-GUID: CD4twaIgADeMT_VdDTyjJplg3AtC74Jh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header should be explicitly included, to make sure it is included
for all Kconfigs.

Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus.c      | 1 +
 drivers/soundwire/bus_type.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1720031f35a35..5869b71f10923 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -4,6 +4,7 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_registers.h>
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index fafbc284e82da..dc9c508f48a4b 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright(c) 2015-17 Intel Corporation.
 
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_domain.h>
-- 
2.30.2

