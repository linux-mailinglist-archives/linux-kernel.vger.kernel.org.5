Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6879EC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjIMPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjIMPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:22:51 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490571BC7;
        Wed, 13 Sep 2023 08:22:46 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DEEHYt006418;
        Wed, 13 Sep 2023 11:22:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t2y8f563r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:22:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38DFMQCV004940
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 11:22:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 13 Sep 2023 11:22:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 13 Sep 2023 11:22:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 13 Sep 2023 11:22:25 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.230])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38DFLmjD007886;
        Wed, 13 Sep 2023 11:22:20 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 3/4] hwmon: max31827: Handle new properties from the devicetree
Date:   Wed, 13 Sep 2023 18:21:33 +0300
Message-ID: <20230913152135.457892-4-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913152135.457892-1-daniel.matyas@analog.com>
References: <20230913152135.457892-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: heyb1qUt5La3BdiFHl9CybmkStKD-fWc
X-Proofpoint-GUID: heyb1qUt5La3BdiFHl9CybmkStKD-fWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_09,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309130125
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used fwnode to retrieve data from the devicetree in the init_client
function.

Added support for devices max31828 and max31829. For these devices, when
adi,flt-q and/or adi,alrm-pol are not mentioned, the default
configuration is loaded.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 Documentation/hwmon/max31827.rst |  47 ++++++++--
 drivers/hwmon/max31827.c         | 142 +++++++++++++++++++++++++++----
 2 files changed, 165 insertions(+), 24 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9a1055a007cf..e0eca1eb5c06 100644
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
@@ -68,6 +76,17 @@ clear the status bits before changing the operating mode.
 
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
 the resolution. The conversion time doubles with every bit of increased
@@ -83,8 +102,18 @@ in the writing of alarm values too. For positive numbers the user-input value
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
index f05762219995..4dc14642775a 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -12,6 +12,19 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/of_device.h>
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
 
 #define MAX31827_T_REG			0x0
 #define MAX31827_CONFIGURATION_REG	0x2
@@ -22,15 +35,25 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
-#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
-#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
+#define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
+#define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
+#define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
+#define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
+#define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
+#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
+#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
 
 #define MAX31827_12_BIT_CNV_TIME	140
 
+#define MAX31827_FLT_Q_1	0x0
+#define MAX31827_FLT_Q_4	0x2
+
 #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
+enum chips { max31827, max31828, max31829 };
+
 enum max31827_cnv {
 	MAX31827_CNV_1_DIV_64_HZ = 1,
 	MAX31827_CNV_1_DIV_32_HZ,
@@ -58,6 +81,7 @@ struct max31827_state {
 	struct mutex lock;
 	struct regmap *regmap;
 	bool enable;
+	struct i2c_client *client;
 };
 
 static const struct regmap_config max31827_regmap = {
@@ -361,14 +385,93 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }
 
-static int max31827_init_client(struct max31827_state *st)
+static const struct i2c_device_id max31827_i2c_ids[] = {
+       { "max31827", max31827 },
+       { "max31828", max31828 },
+       { "max31829", max31829 },
+       { }
+};
+MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
+
+static int max31827_init_client(struct max31827_state *st,
+				struct fwnode_handle *fwnode)
 {
+	bool prop;
+	u32 data, lsb_idx;
+	unsigned int res = 0;
+	enum chips type;
+	int ret;
+
 	st->enable = true;
+	res |= MAX31827_DEVICE_ENABLE(1);
+
+	res |= MAX31827_CONFIGURATION_RESOLUTION_MASK;
 
-	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
-				  MAX31827_CONFIGURATION_1SHOT_MASK |
-					  MAX31827_CONFIGURATION_CNV_RATE_MASK,
-				  MAX31827_DEVICE_ENABLE(1));
+	prop = fwnode_property_read_bool(fwnode, "adi,comp-int");
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_COMP_INT_MASK, prop);
+
+	prop = fwnode_property_read_bool(fwnode, "adi,timeout-enable");
+	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
+
+	if (st->client->dev.of_node)
+		type = (enum chips)of_device_get_match_data(&st->client->dev);
+	else
+		type = i2c_match_id(max31827_i2c_ids, st->client)->driver_data;
+
+	if (fwnode_property_present(fwnode, "adi,alrm-pol")) {
+		ret = fwnode_property_read_u32(fwnode, "adi,alrm-pol", &data);
+		if (ret)
+			return ret;
+
+		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, !!data);
+	} else {
+		switch (type) {
+		case max31827:
+		case max31828:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
+					  0x0);
+			break;
+		case max31829:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
+					  0x1);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (fwnode_property_present(fwnode, "adi,flt-q")) {
+		ret = fwnode_property_read_u32(fwnode, "adi,flt-q", &data);
+		if (ret)
+			return ret;
+
+		/*
+		 * Convert the desired fault queue into register bits.
+		 */
+		lsb_idx = max31827__bf_shf(data);
+		if (lsb_idx > 3 || data != BIT(lsb_idx)) {
+			dev_err(&st->client->dev, "Invalid data in fault queue\n");
+			return -EOPNOTSUPP;
+		}
+
+		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
+	} else {
+		switch (type) {
+		case max31827:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
+					  MAX31827_FLT_Q_1);
+			break;
+		case max31828:
+		case max31829:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
+					  MAX31827_FLT_Q_4);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
 }
 
 static const struct hwmon_channel_info *max31827_info[] = {
@@ -396,6 +499,7 @@ static int max31827_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct max31827_state *st;
+	struct fwnode_handle *fwnode;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -412,7 +516,10 @@ static int max31827_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to allocate regmap.\n");
 
-	err = max31827_init_client(st);
+	st->client = client;
+	fwnode = dev_fwnode(dev);
+
+	err = max31827_init_client(st, fwnode);
 	if (err)
 		return err;
 
@@ -423,14 +530,19 @@ static int max31827_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static const struct i2c_device_id max31827_i2c_ids[] = {
-	{ "max31827", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
-
 static const struct of_device_id max31827_of_match[] = {
-	{ .compatible = "adi,max31827" },
+	{
+		.compatible = "adi,max31827",
+		.data = (void *)max31827
+	},
+	{
+		.compatible = "adi,max31828",
+		.data = (void *)max31828
+	},
+	{
+		.compatible = "adi,max31829",
+		.data = (void *)max31829
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max31827_of_match);
-- 
2.34.1

