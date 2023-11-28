Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A837FC2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjK1SSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjK1SSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:18:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3E19A7;
        Tue, 28 Nov 2023 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701195529; x=1732731529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcWMDkc+5dxwvDVGtTBhtqPuSWadgpqLZKPUZgHhT7c=;
  b=LsxP3byv+QJSOkFS7n5BKlEuOc/JebN7cC1OJIbFbZQGlGj7vqpS7EsT
   s+f0NK8bT539dcqbj7/KzoldScr5zqW5xIH0kUOngSN4k18KL6vPFceQG
   sSYMPoHgYOJ/vkpC7BzL5KsfzatsEDuJD4/PRJChJnjfeSZFkcSqB2h1l
   aFmY8wgZ+uyXVYfKnpFDOBQ8EYzdNMaomG/eUjCyqg747XhHJMQrYuNwq
   /87K8YQWsKL/mIfSLkaua96oJeGSp4y3T34ScvZ6qhQPN0cVKq5bvI4vh
   G/eBJSO6FIpdgUiS/o5qRgrwdX5g6cAietQ2KDSufSzrJ+i8MZm5rCq0U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="383375348"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="383375348"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="886494447"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="886494447"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2023 10:17:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1886D24C; Tue, 28 Nov 2023 20:06:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] hwmon: tmp513: Use SI constants from units.h
Date:   Tue, 28 Nov 2023 20:06:04 +0200
Message-ID: <20231128180654.395692-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
References: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MILLI and MICRO may be used in the driver to make code more robust
against possible miscalculations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/tmp513.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 6e01800404fc..e0abdb27131e 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -32,6 +32,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 // Common register definition
 #define TMP51X_SHUNT_CONFIG		0x00
@@ -101,8 +102,8 @@
 #define TMP51X_REMOTE_TEMP_LIMIT_2_POS		8
 #define TMP513_REMOTE_TEMP_LIMIT_3_POS		7
 
-#define TMP51X_VBUS_RANGE_32V		32000000
-#define TMP51X_VBUS_RANGE_16V		16000000
+#define TMP51X_VBUS_RANGE_32V		(32 * MICRO)
+#define TMP51X_VBUS_RANGE_16V		(16 * MICRO)
 
 // Max and Min value
 #define MAX_BUS_VOLTAGE_32_LIMIT	32764
@@ -204,7 +205,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		 * on the pga gain setting. 1lsb = 10uV
 		 */
 		*val = sign_extend32(regval, 17 - tmp51x_get_pga_shift(data));
-		*val = DIV_ROUND_CLOSEST(*val * 10000, data->shunt_uohms);
+		*val = DIV_ROUND_CLOSEST(*val * 10 * MILLI, data->shunt_uohms);
 		break;
 	case TMP51X_BUS_VOLTAGE_RESULT:
 	case TMP51X_BUS_VOLTAGE_H_LIMIT:
@@ -220,7 +221,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 	case TMP51X_BUS_CURRENT_RESULT:
 		// Current = (ShuntVoltage * CalibrationRegister) / 4096
 		*val = sign_extend32(regval, 16) * data->curr_lsb_ua;
-		*val = DIV_ROUND_CLOSEST(*val, 1000);
+		*val = DIV_ROUND_CLOSEST(*val, MILLI);
 		break;
 	case TMP51X_LOCAL_TEMP_RESULT:
 	case TMP51X_REMOTE_TEMP_RESULT_1:
@@ -260,7 +261,7 @@ static int tmp51x_set_value(struct tmp51x_data *data, u8 reg, long val)
 		 * The user enter current value and we convert it to
 		 * voltage. 1lsb = 10uV
 		 */
-		val = DIV_ROUND_CLOSEST(val * data->shunt_uohms, 10000);
+		val = DIV_ROUND_CLOSEST(val * data->shunt_uohms, 10 * MILLI);
 		max_val = U16_MAX >> tmp51x_get_pga_shift(data);
 		regval = clamp_val(val, -max_val, max_val);
 		break;
@@ -550,18 +551,16 @@ static int tmp51x_calibrate(struct tmp51x_data *data)
 	if (data->shunt_uohms == 0)
 		return regmap_write(data->regmap, TMP51X_SHUNT_CALIBRATION, 0);
 
-	max_curr_ma = DIV_ROUND_CLOSEST_ULL(vshunt_max * 1000 * 1000,
-					    data->shunt_uohms);
+	max_curr_ma = DIV_ROUND_CLOSEST_ULL(vshunt_max * MICRO, data->shunt_uohms);
 
 	/*
 	 * Calculate the minimal bit resolution for the current and the power.
 	 * Those values will be used during register interpretation.
 	 */
-	data->curr_lsb_ua = DIV_ROUND_CLOSEST_ULL(max_curr_ma * 1000, 32767);
+	data->curr_lsb_ua = DIV_ROUND_CLOSEST_ULL(max_curr_ma * MILLI, 32767);
 	data->pwr_lsb_uw = 20 * data->curr_lsb_ua;
 
-	div = DIV_ROUND_CLOSEST_ULL(data->curr_lsb_ua * data->shunt_uohms,
-				    1000 * 1000);
+	div = DIV_ROUND_CLOSEST_ULL(data->curr_lsb_ua * data->shunt_uohms, MICRO);
 
 	return regmap_write(data->regmap, TMP51X_SHUNT_CALIBRATION,
 			    DIV_ROUND_CLOSEST(40960, div));
@@ -678,7 +677,7 @@ static int tmp51x_read_properties(struct device *dev, struct tmp51x_data *data)
 				       data->max_channels - 1);
 
 	// Check if shunt value is compatible with pga-gain
-	if (data->shunt_uohms > data->pga_gain * 40 * 1000 * 1000) {
+	if (data->shunt_uohms > data->pga_gain * 40 * MICRO) {
 		return dev_err_probe(dev, -EINVAL,
 				     "shunt-resistor: %u too big for pga_gain: %u\n",
 				     data->shunt_uohms, data->pga_gain);
-- 
2.43.0.rc1.1.gbec44491f096

