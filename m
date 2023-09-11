Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58D79BC09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378651AbjIKWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjIKIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:39:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2AAFB;
        Mon, 11 Sep 2023 01:39:33 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38B7ECBS032077;
        Mon, 11 Sep 2023 04:39:16 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t15ueede2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 04:39:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 38B8dEba024319
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 04:39:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Sep 2023 04:39:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Sep 2023 04:39:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Sep 2023 04:39:13 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.230])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38B8cSYx008521;
        Mon, 11 Sep 2023 04:39:04 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: max31827: Functional enhancement of the driver
Date:   Mon, 11 Sep 2023 11:37:35 +0300
Message-ID: <20230911083735.11795-2-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911083735.11795-1-daniel.matyas@analog.com>
References: <20230911083735.11795-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yCWugSTe5kWOfdlnYDodfJ8SEGUO_7BT
X-Proofpoint-GUID: yCWugSTe5kWOfdlnYDodfJ8SEGUO_7BT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309110078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify some bits depending on the device tree.

Added custom device attributes for resolution and timeout. The wait time
for a conversion in one-shot mode (enable = 0) depends on the
resolution.

Used enums and static const arrays in order to remove nested switch
blocks.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 Documentation/hwmon/max31827.rst |  65 ++++--
 drivers/hwmon/max31827.c         | 326 ++++++++++++++++++++++++-------
 2 files changed, 306 insertions(+), 85 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index b0971d05b8a4..ae884e9e6085 100644
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
@@ -68,13 +76,32 @@ clear the status bits before changing the operating mode.
 
 The conversions can be manual with the one-shot functionality and automatic with
 a set frequency. When powered on, the chip measures temperatures with 1 conv/s.
+The conversion rate can be modified with update_interval attribute of the chip.
+Conversion/second = 1/update_interval. Thus, the available options according to
+the data sheet are:
+	- 64000 (ms) = 1 conv/64 sec
+	- 32000 (ms) = 1 conv/32 sec
+	- 16000 (ms) = 1 conv/16 sec
+	- 4000 (ms) = 1 conv/4 sec
+	- 1000 (ms) = 1 conv/sec (default)
+	- 250 (ms) = 4 conv/sec
+	- 125 (ms) = 8 conv/sec
+
 Enabling the device when it is already enabled has the side effect of setting
 the conversion frequency to 1 conv/s. The conversion time varies depending on
-the resolution. The conversion time doubles with every bit of increased
-resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
-(default) 140ms. When chip is in shutdown mode and a read operation is
-requested, one-shot is triggered, the device waits for 140 (conversion time) + 1
-(error) ms, and only after that is the temperature value register read.
+the resolution.
+
+The conversion time doubles with every bit of increased resolution. The
+available resolutions are:
+	- 8 bit -> 8.75 ms conversion time
+	- 9 bit -> 17.5 ms conversion time
+	- 10 bit -> 35 ms conversion time
+	- 12 bit (default) -> 140 ms conversion time
+
+When chip is in shutdown mode and a read operation is requested, one-shot is
+triggered, the device waits for <conversion time> ms, and only after that is
+the temperature value register read. Note that the conversion times are rounded
+up to the nearest possible integer.
 
 The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
 the temperatures are displayed in milli-degrees. This means, that some data is
@@ -83,8 +110,18 @@ in the writing of alarm values too. For positive numbers the user-input value
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
+PEC is not implemented.
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 66f5fcf937ff..9f48dec99b7f 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -12,6 +12,18 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/hwmon-sysfs.h>
+
+/*
+ * gcc turns __builtin_ffsll() into a call to __ffsdi2(), which is not provided
+ * by every architecture. __ffs64() is available on all architectures, but the
+ * result is not defined if no bits are set.
+ */
+#define max31827__bf_shf(x)			 \
+	({					 \
+		typeof(x) x_ = (x);		 \
+		((x_) != 0) ? __ffs64(x_) : 0x0; \
+	})
 
 #define MAX31827_T_REG	0x0
 #define MAX31827_CONFIGURATION_REG	0x2
@@ -22,22 +34,120 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
+#define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
+#define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
+#define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
+#define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
 #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
 
-#define MAX31827_12_BIT_CNV_TIME	141
-
-#define MAX31827_CNV_1_DIV_64_HZ	0x1
-#define MAX31827_CNV_1_DIV_32_HZ	0x2
-#define MAX31827_CNV_1_DIV_16_HZ	0x3
-#define MAX31827_CNV_1_DIV_4_HZ		0x4
-#define MAX31827_CNV_1_HZ	0x5
-#define MAX31827_CNV_4_HZ	0x6
-#define MAX31827_CNV_8_HZ	0x7
+#define MAX31827_8_BIT_CNV_TIME		9
+#define MAX31827_9_BIT_CNV_TIME		18
+#define MAX31827_10_BIT_CNV_TIME	35
+#define MAX31827_12_BIT_CNV_TIME	140
 
 #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
+#define MAX31827_FLT_Q
+
+enum max31827_cnv {
+	MAX31827_CNV_1_DIV_64_HZ = 1,
+	MAX31827_CNV_1_DIV_32_HZ,
+	MAX31827_CNV_1_DIV_16_HZ,
+	MAX31827_CNV_1_DIV_4_HZ,
+	MAX31827_CNV_1_HZ,
+	MAX31827_CNV_4_HZ,
+	MAX31827_CNV_8_HZ,
+};
+
+static const u16 max31827_conversions[] = {
+	[MAX31827_CNV_1_DIV_64_HZ] = 64000,
+	[MAX31827_CNV_1_DIV_32_HZ] = 32000,
+	[MAX31827_CNV_1_DIV_16_HZ] = 16000,
+	[MAX31827_CNV_1_DIV_4_HZ] = 4000,
+	[MAX31827_CNV_1_HZ] = 1000,
+	[MAX31827_CNV_4_HZ] = 250,
+	[MAX31827_CNV_8_HZ] = 125,
+};
+
+enum max31827_resolution {
+	MAX31827_RES_8_BIT = 0,
+	MAX31827_RES_9_BIT,
+	MAX31827_RES_10_BIT,
+	MAX31827_RES_12_BIT,
+};
+
+static const u16 max31827_resolutions[] = {
+	[MAX31827_RES_8_BIT] = 8,
+	[MAX31827_RES_9_BIT] = 9,
+	[MAX31827_RES_10_BIT] = 10,
+	[MAX31827_RES_12_BIT] = 12,
+};
+
+enum cfg_index {
+	cfg_timeout_idx = 0,
+	cfg_res_idx,
+	cfg_num
+};
+
+static const unsigned int cfg_masks[cfg_num] = {
+	[cfg_timeout_idx] = MAX31827_CONFIGURATION_TIMEOUT_MASK,
+	[cfg_res_idx] = MAX31827_CONFIGURATION_RESOLUTION_MASK,
+};
+
+enum max31827_cnv {
+	MAX31827_CNV_1_DIV_64_HZ = 1,
+	MAX31827_CNV_1_DIV_32_HZ,
+	MAX31827_CNV_1_DIV_16_HZ,
+	MAX31827_CNV_1_DIV_4_HZ,
+	MAX31827_CNV_1_HZ,
+	MAX31827_CNV_4_HZ,
+	MAX31827_CNV_8_HZ,
+};
+
+static const u16 max31827_conversions[] = {
+	[MAX31827_CNV_1_DIV_64_HZ] = 64000,
+	[MAX31827_CNV_1_DIV_32_HZ] = 32000,
+	[MAX31827_CNV_1_DIV_16_HZ] = 16000,
+	[MAX31827_CNV_1_DIV_4_HZ] = 4000,
+	[MAX31827_CNV_1_HZ] = 1000,
+	[MAX31827_CNV_4_HZ] = 250,
+	[MAX31827_CNV_8_HZ] = 125,
+};
+
+enum max31827_resolution {
+	MAX31827_RES_8_BIT = 0,
+	MAX31827_RES_9_BIT,
+	MAX31827_RES_10_BIT,
+	MAX31827_RES_12_BIT,
+};
+
+static const u16 max31827_resolutions[] = {
+	[MAX31827_RES_8_BIT] = 8,
+	[MAX31827_RES_9_BIT] = 9,
+	[MAX31827_RES_10_BIT] = 10,
+	[MAX31827_RES_12_BIT] = 12,
+};
+
+static const u16 max31827_conv_times[] = {
+	[MAX31827_RES_8_BIT] = MAX31827_8_BIT_CNV_TIME,
+	[MAX31827_RES_9_BIT] = MAX31827_9_BIT_CNV_TIME,
+	[MAX31827_RES_10_BIT] = MAX31827_10_BIT_CNV_TIME,
+	[MAX31827_RES_12_BIT] = MAX31827_12_BIT_CNV_TIME,
+};
+
+enum cfg_index {
+	cfg_timeout_idx = 0,
+	cfg_res_idx,
+	cfg_num
+};
+
+static const unsigned int cfg_masks[cfg_num] = {
+	[cfg_timeout_idx] = MAX31827_CONFIGURATION_TIMEOUT_MASK,
+	[cfg_res_idx] = MAX31827_CONFIGURATION_RESOLUTION_MASK,
+};
 
 struct max31827_state {
 	/*
@@ -46,6 +156,7 @@ struct max31827_state {
 	struct mutex lock;
 	struct regmap *regmap;
 	bool enable;
+	unsigned int resolution;
 };
 
 static const struct regmap_config max31827_regmap = {
@@ -166,8 +277,7 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 					mutex_unlock(&st->lock);
 					return ret;
 				}
-
-				msleep(MAX31827_12_BIT_CNV_TIME);
+				msleep(max31827_conv_times[st->resolution]);
 			}
 			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
 
@@ -243,32 +353,7 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 
 			uval = FIELD_GET(MAX31827_CONFIGURATION_CNV_RATE_MASK,
 					 uval);
-			switch (uval) {
-			case MAX31827_CNV_1_DIV_64_HZ:
-				*val = 64000;
-				break;
-			case MAX31827_CNV_1_DIV_32_HZ:
-				*val = 32000;
-				break;
-			case MAX31827_CNV_1_DIV_16_HZ:
-				*val = 16000;
-				break;
-			case MAX31827_CNV_1_DIV_4_HZ:
-				*val = 4000;
-				break;
-			case MAX31827_CNV_1_HZ:
-				*val = 1000;
-				break;
-			case MAX31827_CNV_4_HZ:
-				*val = 250;
-				break;
-			case MAX31827_CNV_8_HZ:
-				*val = 125;
-				break;
-			default:
-				*val = 0;
-				break;
-			}
+			*val = max31827_conversions[uval];
 		}
 		break;
 
@@ -284,6 +369,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			  u32 attr, int channel, long val)
 {
 	struct max31827_state *st = dev_get_drvdata(dev);
+	int res = 1;
 	int ret;
 
 	switch (type) {
@@ -333,39 +419,27 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			if (!st->enable)
 				return -EOPNOTSUPP;
 
-			switch (val) {
-			case 125:
-				val = MAX31827_CNV_8_HZ;
-				break;
-			case 250:
-				val = MAX31827_CNV_4_HZ;
-				break;
-			case 1000:
-				val = MAX31827_CNV_1_HZ;
-				break;
-			case 4000:
-				val = MAX31827_CNV_1_DIV_4_HZ;
-				break;
-			case 16000:
-				val = MAX31827_CNV_1_DIV_16_HZ;
-				break;
-			case 32000:
-				val = MAX31827_CNV_1_DIV_32_HZ;
-				break;
-			case 64000:
-				val = MAX31827_CNV_1_DIV_64_HZ;
-				break;
-			default:
+			/*
+			 * Convert the desired conversion rate into register
+			 * bits. res is already initialized with 1.
+			 *
+			 * This was inspired by lm73 driver.
+			 */
+			while (res < ARRAY_SIZE(max31827_conversions) &&
+			       val < max31827_conversions[res])
+				res++;
+
+			if (res == ARRAY_SIZE(max31827_conversions) ||
+			    val != max31827_conversions[res])
 				return -EOPNOTSUPP;
-			}
 
-			val = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
-					 val);
+			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
+					 res);
 
 			return regmap_update_bits(st->regmap,
 						  MAX31827_CONFIGURATION_REG,
 						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
-						  val);
+						  res);
 		}
 		break;
 
@@ -376,14 +450,121 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }
 
-static int max31827_init_client(struct max31827_state *st)
+static ssize_t cfg_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31827_state *st = dev_get_drvdata(dev);
+	const unsigned int mask = cfg_masks[attr->index];
+	unsigned int val, res;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &val);
+	/*
+	 * FIELD_GET did not work because mask is not a compile time constant.
+	 * There is no bitfield check now.
+	 */
+	val = (val & mask) >> max31827__bf_shf(mask);
+
+	if (attr->index == cfg_res_idx)
+		res = max31827_resolutions[val];
+	else
+		res = !val;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", res);
+}
+
+static ssize_t cfg_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31827_state *st = dev_get_drvdata(dev);
+	const unsigned int mask = cfg_masks[attr->index];
+	unsigned int res = 0;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (attr->index == cfg_res_idx) {
+		/*
+		 * Convert the desired conversion rate into register
+		 * bits. res is already initialized with 1.
+		 *
+		 * This was inspired by lm73 driver.
+		 */
+		while (res < ARRAY_SIZE(max31827_resolutions) &&
+		       val > max31827_resolutions[res])
+			res++;
+
+		if (res == ARRAY_SIZE(max31827_resolutions) ||
+		    val != max31827_resolutions[res])
+			return -EOPNOTSUPP;
+
+		st->resolution = res;
+	} else {
+		res = !val;
+	}
+
+	/*
+	 * FIELD_PREP did not work because mask is not a compile time constant.
+	 * There is no bitfield check now.
+	 */
+	res = (res << max31827__bf_shf(mask)) & mask;
+	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+				 cfg_masks[attr->index], res);
+
+	return (ret) ? ret : count;
+}
+
+static SENSOR_DEVICE_ATTR_RW(cfg_resolution, cfg, cfg_res_idx);
+static SENSOR_DEVICE_ATTR_RW(cfg_timeout, cfg, cfg_timeout_idx);
+
+static struct attribute *max31827_attrs[] = {
+	&sensor_dev_attr_cfg_resolution.dev_attr.attr,
+	&sensor_dev_attr_cfg_timeout.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(max31827);
+
+static int max31827_init_client(struct max31827_state *st,
+				struct fwnode_handle *fwnode)
+{
+	bool comp_int, alrm_pol;
+	u32 flt_q, lsb_idx;
+	unsigned int res = 0;
+	int ret;
+
 	st->enable = true;
+	res |= MAX31827_DEVICE_ENABLE(1);
+
+	st->resolution = MAX31827_RES_12_BIT;
+	res |= MAX31827_CONFIGURATION_RESOLUTION_MASK;
 
-	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
-				  MAX31827_CONFIGURATION_1SHOT_MASK |
-					  MAX31827_CONFIGURATION_CNV_RATE_MASK,
-				  MAX31827_DEVICE_ENABLE(1));
+	comp_int = fwnode_property_read_bool(fwnode, "adi,comp-int");
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_COMP_INT_MASK, comp_int);
+
+	alrm_pol = fwnode_property_read_bool(fwnode, "adi,alrm-pol");
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, alrm_pol);
+
+	ret = fwnode_property_read_u32(fwnode, "adi,flt-q", &flt_q);
+	if (ret)
+		return ret;
+
+	/*
+	 * Convert the desired fault queue into register bits.
+	 */
+	lsb_idx = max31827__bf_shf(flt_q);
+	if (lsb_idx > 3 || flt_q != BIT(lsb_idx)) {
+		pr_err("max31827: Invalid data in fault queue\n");
+		return -EOPNOTSUPP;
+	}
+
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
+
+	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
 }
 
 static const struct hwmon_channel_info *max31827_info[] = {
@@ -411,6 +592,7 @@ static int max31827_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct max31827_state *st;
+	struct fwnode_handle *fwnode;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -427,13 +609,15 @@ static int max31827_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to allocate regmap.\n");
 
-	err = max31827_init_client(st);
+	fwnode = dev_fwnode(dev);
+
+	err = max31827_init_client(st, fwnode);
 	if (err)
 		return err;
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
 							 &max31827_chip_info,
-							 NULL);
+							 max31827_groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
2.34.1

