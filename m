Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EAC80B34F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjLIIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjLIIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:09:03 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1EFA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:09:07 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B987vPK031288;
        Sat, 9 Dec 2023 02:07:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702109277;
        bh=S53+t2ZMBhz3JwJ5YrVSIeTq3esCnFxAEKW5KaIaz0A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rH0+qt0MR0lsKU8BVLb1cIkC05D6L/gAcOlXA/iHB0h4/7ojV7PgXdckMg9K2/A6F
         +gdzkR8eU8K+rhkPr7YHbYysfH18nAz4SBmyMOM2mSo55CSGHyROW63LUlKvYrUjR/
         gXcUIYkPBKJHC4csV4lJEs0vul6dCxLJh1+PxsnU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B987vuT018993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 9 Dec 2023 02:07:57 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 9
 Dec 2023 02:07:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 9 Dec 2023 02:07:57 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.163.83])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B987lHE122124;
        Sat, 9 Dec 2023 02:07:53 -0600
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <broonie@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <tiwai@suse.de>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 2/3] ASoC: tas2781: Add tas2563 into driver
Date:   Sat, 9 Dec 2023 16:07:41 +0800
Message-ID: <20231209080742.1290-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231209080742.1290-1-shenghao-ding@ti.com>
References: <20231209080742.1290-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support tas2563.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/soc/codecs/tas2781-i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 55cd5e3c23a5..c6afc87f2c69 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -5,9 +5,9 @@
 // Copyright (C) 2022 - 2023 Texas Instruments Incorporated
 // https://www.ti.com
 //
-// The TAS2781 driver implements a flexible and configurable
+// The TAS2781/TAS2563 driver implements a flexible and configurable
 // algo coefficient setting for one, two, or even multiple
-// TAS2781 chips.
+// TAS2781/TAS2563 chips.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 // Author: Kevin Lu <kevin-lu@ti.com>
@@ -33,6 +33,7 @@
 
 static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2781", TAS2781 },
+	{ "tas2563", TAS2563 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tasdevice_id);
@@ -40,6 +41,7 @@ MODULE_DEVICE_TABLE(i2c, tasdevice_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2781" },
+	{ .compatible = "ti,tas2563" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
-- 
2.34.1

