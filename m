Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115437D8508
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbjJZOox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:44:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BD1AA;
        Thu, 26 Oct 2023 07:44:48 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39QCiU0l024121;
        Thu, 26 Oct 2023 10:44:32 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ty72k6q12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:44:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39QEiU8D010649
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 10:44:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Oct 2023 10:44:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Oct 2023 10:44:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 Oct 2023 10:44:29 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.198])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39QEiEiv031489;
        Thu, 26 Oct 2023 10:44:17 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/4] hwmon: max31827: Handle new properties from the devicetree
Date:   Thu, 26 Oct 2023 17:44:01 +0300
Message-ID: <20231026144405.546822-1-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: e-zsm7FdMSo8LYQFMuuXaldwCwOnPovq
X-Proofpoint-GUID: e-zsm7FdMSo8LYQFMuuXaldwCwOnPovq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310260127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used fwnode to retrieve data from the devicetree in the init_client
function.

If the uint32 properties are not present, the default values are used
for max31827 chip.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---

v4 -> v5: Removed comment from __bf_shf() and used ffs() instead of
ffs64().
Added tabs where there was a need.
Removed i2c_client from private structure. In init_client() passed
device structure, because I only used that.
Changed error message when the data in adi,fault-q is invalid.
Fwnode is initialized in init_client().

v3 -> v4: Renamed property names to correspond with binding.

v2 -> v3: Separated patch into 2. Fixed 'WARNING: Unexpected
indentation.'
Reported-by: kernel test robot <lkp@intel.com>

v2: Added patch.

 Documentation/hwmon/max31827.rst | 48 +++++++++++++++++++-----
 drivers/hwmon/max31827.c         | 64 +++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9a1055a007cf..a8bbfb85dd02 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -52,13 +52,21 @@ MAX31827 has low and over temperature alarms with an effective value and a
 hysteresis value: -40 and -30 degrees for under temperature alarm and +100 and
 +90 degrees for over temperature alarm.
 
-The alarm can be configured in comparator and interrupt mode. Currently only
-comparator mode is implemented. In Comparator mode, the OT/UT status bits have a
-value of 1 when the temperature rises above the TH value or falls below TL,
-which is also subject to the Fault Queue selection. OT status returns to 0 when
-the temperature drops below the TH_HYST value or when shutdown mode is entered.
-Similarly, UT status returns to 0 when the temperature rises above TL_HYST value
-or when shutdown mode is entered.
+The alarm can be configured in comparator and interrupt mode from the
+devicetree. In Comparator mode, the OT/UT status bits have a value of 1 when the
+temperature rises above the TH value or falls below TL, which is also subject to
+the Fault Queue selection. OT status returns to 0 when the temperature drops
+below the TH_HYST value or when shutdown mode is entered. Similarly, UT status
+returns to 0 when the temperature rises above TL_HYST value or when shutdown
+mode is entered.
+
+In interrupt mode exceeding TH also sets OT status to 1, which remains set until
+a read operation is performed on the configuration/status register (max or min
+attribute); at this point, it returns to 0. Once OT status is set to 1 from
+exceeding TH and reset, it is set to 1 again only when the temperature drops
+below TH_HYST. The output remains asserted until it is reset by a read. It is
+set again if the temperature rises above TH, and so on. The same logic applies
+to the operation of the UT status bit.
 
 Putting the MAX31827 into shutdown mode also resets the OT/UT status bits. Note
 that if the mode is changed while OT/UT status bits are set, an OT/UT status
@@ -68,6 +76,18 @@ clear the status bits before changing the operating mode.
 
 The conversions can be manual with the one-shot functionality and automatic with
 a set frequency. When powered on, the chip measures temperatures with 1 conv/s.
+The conversion rate can be modified with update_interval attribute of the chip.
+Conversion/second = 1/update_interval. Thus, the available options according to
+the data sheet are:
+
+- 64000 (ms) = 1 conv/64 sec
+- 32000 (ms) = 1 conv/32 sec
+- 16000 (ms) = 1 conv/16 sec
+- 4000 (ms) = 1 conv/4 sec
+- 1000 (ms) = 1 conv/sec (default)
+- 250 (ms) = 4 conv/sec
+- 125 (ms) = 8 conv/sec
+
 Enabling the device when it is already enabled has the side effect of setting
 the conversion frequency to 1 conv/s. The conversion time varies depending on
 the resolution. The conversion time doubles with every bit of increased
@@ -83,8 +103,18 @@ in the writing of alarm values too. For positive numbers the user-input value
 will always be rounded down to the nearest possible value, for negative numbers
 the user-input will always be rounded up to the nearest possible value.
 
+Bus timeout resets the I2C-compatible interface when SCL is low for more than
+30ms (nominal).
+
+Alarm polarity determines if the active state of the alarm is low or high. The
+behavior for both settings is dependent on the Fault Queue setting. The ALARM
+pin is an open-drain output and requires a pullup resistor to operate.
+
+The Fault Queue bits select how many consecutive temperature faults must occur
+before overtemperature or undertemperature faults are indicated in the
+corresponding status bits.
+
 Notes
 -----
 
-Currently fault queue, alarm polarity and resolution cannot be modified.
-PEC is not implemented either.
+PEC and resolution are not implemented.
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 614bbf5d25fa..7976d668ffd4 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -12,6 +12,13 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/of_device.h>
+
+#define max31827__bf_shf(x)			 \
+	({					 \
+		typeof(x) x_ = (x);		 \
+		((x_) != 0) ? __ffs(x_) : 0x0; \
+	})
 
 #define MAX31827_T_REG			0x0
 #define MAX31827_CONFIGURATION_REG	0x2
@@ -22,6 +29,11 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
+#define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
+#define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
+#define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
+#define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
 #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
 
@@ -361,14 +373,54 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }
 
-static int max31827_init_client(struct max31827_state *st)
+static int max31827_init_client(struct max31827_state *st,
+				struct device *dev)
 {
+	struct fwnode_handle *fwnode;
+	unsigned int res = 0;
+	u32 data, lsb_idx;
+	bool prop;
+	int ret;
+
+	fwnode = dev_fwnode(dev);
+
 	st->enable = true;
+	res |= MAX31827_DEVICE_ENABLE(1);
+
+	res |= MAX31827_CONFIGURATION_RESOLUTION_MASK;
+
+	prop = fwnode_property_read_bool(fwnode, "adi,comp-int");
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_COMP_INT_MASK, prop);
+
+	prop = fwnode_property_read_bool(fwnode, "adi,timeout-enable");
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
+
+	if (fwnode_property_present(fwnode, "adi,alarm-pol")) {
+		ret = fwnode_property_read_u32(fwnode, "adi,alarm-pol", &data);
+		if (ret)
+			return ret;
+
+		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, !!data);
+	}
+
+	if (fwnode_property_present(fwnode, "adi,fault-q")) {
+		ret = fwnode_property_read_u32(fwnode, "adi,fault-q", &data);
+		if (ret)
+			return ret;
+
+		/*
+		 * Convert the desired fault queue into register bits.
+		 */
+		lsb_idx = max31827__bf_shf(data);
+		if (lsb_idx > 3 || data != BIT(lsb_idx)) {
+			dev_err(dev, "Invalid data in adi,fault-q\n");
+			return -EINVAL;
+		}
+
+		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
+	}
 
-	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
-				  MAX31827_CONFIGURATION_1SHOT_MASK |
-					  MAX31827_CONFIGURATION_CNV_RATE_MASK,
-				  MAX31827_DEVICE_ENABLE(1));
+	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
 }
 
 static const struct hwmon_channel_info *max31827_info[] = {
@@ -412,7 +464,7 @@ static int max31827_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to allocate regmap.\n");
 
-	err = max31827_init_client(st);
+	err = max31827_init_client(st, dev);
 	if (err)
 		return err;
 
-- 
2.34.1

