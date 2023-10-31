Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CC7DCA45
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjJaJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjJaJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:57:27 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9AA1;
        Tue, 31 Oct 2023 02:57:25 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V7VJmb030860;
        Tue, 31 Oct 2023 05:57:08 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3u1fef689q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 05:57:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39V9v7D5039683
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Oct 2023 05:57:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 31 Oct 2023 05:57:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 31 Oct 2023 05:57:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 31 Oct 2023 05:57:06 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.145])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39V9usbA024643;
        Tue, 31 Oct 2023 05:56:56 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: ltc2991: remove device reference from state
Date:   Tue, 31 Oct 2023 11:56:46 +0200
Message-ID: <20231031095647.48376-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vlt0LP1E8CL2YEfj4nxWHBODGB3h0aeV
X-Proofpoint-GUID: vlt0LP1E8CL2YEfj4nxWHBODGB3h0aeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310240000
 definitions=main-2310310077
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove device reference from struct ltc2991_state since it is used only
inside the init function.

Pass the struct device as parameter to the init function instead.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/hwmon/ltc2991.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
index bd63c61129a9..773e7211643f 100644
--- a/drivers/hwmon/ltc2991.c
+++ b/drivers/hwmon/ltc2991.c
@@ -54,7 +54,6 @@
 #define LTC2991_VCC_CH_NR		0
 
 struct ltc2991_state {
-	struct device		*dev;
 	struct regmap		*regmap;
 	u32			r_sense_uohm[LTC2991_MAX_CHANNEL];
 	bool			temp_en[LTC2991_MAX_CHANNEL];
@@ -283,19 +282,19 @@ static const struct regmap_config ltc2991_regmap_config = {
 	.max_register = 0x1D,
 };
 
-static int ltc2991_init(struct ltc2991_state *st)
+static int ltc2991_init(struct ltc2991_state *st, struct device *dev)
 {
 	struct fwnode_handle *child;
 	int ret;
 	u32 val, addr;
 	u8 v5_v8_reg_data = 0, v1_v4_reg_data = 0;
 
-	ret = devm_regulator_get_enable(st->dev, "vcc");
+	ret = devm_regulator_get_enable(dev, "vcc");
 	if (ret)
-		return dev_err_probe(st->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "failed to enable regulator\n");
 
-	device_for_each_child_node(st->dev, child) {
+	device_for_each_child_node(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &addr);
 		if (ret < 0) {
 			fwnode_handle_put(child);
@@ -312,7 +311,7 @@ static int ltc2991_init(struct ltc2991_state *st)
 					       &val);
 		if (!ret) {
 			if (!val)
-				return dev_err_probe(st->dev, -EINVAL,
+				return dev_err_probe(dev, -EINVAL,
 						     "shunt resistor value cannot be zero\n");
 
 			st->r_sense_uohm[addr] = val;
@@ -361,18 +360,18 @@ static int ltc2991_init(struct ltc2991_state *st)
 
 	ret = regmap_write(st->regmap, LTC2991_V5_V8_CTRL, v5_v8_reg_data);
 	if (ret)
-		return dev_err_probe(st->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Error: Failed to set V5-V8 CTRL reg.\n");
 
 	ret = regmap_write(st->regmap, LTC2991_V1_V4_CTRL, v1_v4_reg_data);
 	if (ret)
-		return dev_err_probe(st->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Error: Failed to set V1-V4 CTRL reg.\n");
 
 	ret = regmap_write(st->regmap, LTC2991_PWM_TH_LSB_T_INT,
 			   LTC2991_REPEAT_ACQ_EN);
 	if (ret)
-		return dev_err_probe(st->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Error: Failed to set contiuous mode.\n");
 
 	/* Enable all channels and trigger conversions */
@@ -392,12 +391,11 @@ static int ltc2991_i2c_probe(struct i2c_client *client)
 	if (!st)
 		return -ENOMEM;
 
-	st->dev = &client->dev;
 	st->regmap = devm_regmap_init_i2c(client, &ltc2991_regmap_config);
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
-	ret = ltc2991_init(st);
+	ret = ltc2991_init(st, &client->dev);
 	if (ret)
 		return ret;
 
-- 
2.42.0

