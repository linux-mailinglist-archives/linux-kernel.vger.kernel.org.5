Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805777D8576
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjJZOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJZOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:44:51 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FEA1AE;
        Thu, 26 Oct 2023 07:44:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39QD24ta024132;
        Thu, 26 Oct 2023 10:44:33 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ty72k6q13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:44:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39QEiUPX010652
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 10:44:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Oct 2023 10:44:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Oct 2023 10:44:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 Oct 2023 10:44:29 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.198])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39QEiEiw031489;
        Thu, 26 Oct 2023 10:44:23 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and max31829
Date:   Thu, 26 Oct 2023 17:44:02 +0300
Message-ID: <20231026144405.546822-2-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026144405.546822-1-daniel.matyas@analog.com>
References: <20231026144405.546822-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 2EWS_F3M6VtnUmcC1YzEiwvYmE4R8W3Z
X-Proofpoint-GUID: 2EWS_F3M6VtnUmcC1YzEiwvYmE4R8W3Z
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

When adi,flt-q and/or adi,alrm-pol are not mentioned,
the default configuration is loaded.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---

v4 -> v5: Passed i2c_client to init_client(), because I needed it to
retrieve device id.
Used a simple if to load default configuration. No more switch.

v3 -> v4: No change.

v3: Added patch.

 drivers/hwmon/max31827.c | 51 +++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 7976d668ffd4..446232fa1710 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -39,10 +39,15 @@
 
 #define MAX31827_12_BIT_CNV_TIME	140
 
+#define MAX31827_ALRM_POL_HIGH	0x1
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
@@ -373,12 +378,22 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }
 
+static const struct i2c_device_id max31827_i2c_ids[] = {
+	{ "max31827", max31827 },
+	{ "max31828", max31828 },
+	{ "max31829", max31829 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
+
 static int max31827_init_client(struct max31827_state *st,
-				struct device *dev)
+				struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct fwnode_handle *fwnode;
 	unsigned int res = 0;
 	u32 data, lsb_idx;
+	enum chips type;
 	bool prop;
 	int ret;
 
@@ -395,13 +410,20 @@ static int max31827_init_client(struct max31827_state *st,
 	prop = fwnode_property_read_bool(fwnode, "adi,timeout-enable");
 	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
 
+	if (dev->of_node)
+		type = (enum chips)of_device_get_match_data(dev);
+	else
+		type = i2c_match_id(max31827_i2c_ids, client)->driver_data;
+
 	if (fwnode_property_present(fwnode, "adi,alarm-pol")) {
 		ret = fwnode_property_read_u32(fwnode, "adi,alarm-pol", &data);
 		if (ret)
 			return ret;
 
 		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, !!data);
-	}
+	} else if (type == max31829)
+		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
+				  MAX31827_ALRM_POL_HIGH);
 
 	if (fwnode_property_present(fwnode, "adi,fault-q")) {
 		ret = fwnode_property_read_u32(fwnode, "adi,fault-q", &data);
@@ -418,7 +440,9 @@ static int max31827_init_client(struct max31827_state *st,
 		}
 
 		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
-	}
+	} else if ((type == max31828) || (type == max31829))
+		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
+				  MAX31827_FLT_Q_4);
 
 	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
 }
@@ -464,7 +488,7 @@ static int max31827_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to allocate regmap.\n");
 
-	err = max31827_init_client(st, dev);
+	err = max31827_init_client(st, client);
 	if (err)
 		return err;
 
@@ -475,14 +499,19 @@ static int max31827_probe(struct i2c_client *client)
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

