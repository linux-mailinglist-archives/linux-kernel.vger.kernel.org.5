Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8576813352
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573538AbjLNOhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573528AbjLNOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:37:28 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CCC10E;
        Thu, 14 Dec 2023 06:37:34 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEDbMT8014342;
        Thu, 14 Dec 2023 09:37:13 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v02rj0758-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:37:13 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BEEbC7K003520
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Dec 2023 09:37:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 14 Dec
 2023 09:37:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Dec 2023 09:37:11 -0500
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.152])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BEEaqwf017595;
        Thu, 14 Dec 2023 09:37:05 -0500
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
Subject: [PATCH 3/3] hwmon: max31827: Compatible for adaq4224
Date:   Thu, 14 Dec 2023 16:36:47 +0200
Message-ID: <20231214143648.175336-3-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214143648.175336-1-daniel.matyas@analog.com>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yDk8UywQApKBChYIyuwG22fgLvWSUpGZ
X-Proofpoint-ORIG-GUID: yDk8UywQApKBChYIyuwG22fgLvWSUpGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible string "adi,adaq4224_temp" is accepted in device tree.
When this string is seen in the device tree, the name of the device
changes to "adaq4224_temp" and the default configuration of max31827
is loaded.

This modification was requested by the costumer, so that whenever one
analyzes the available devices, one can know for sure, that max31827 is
part of the adaq4224.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 drivers/hwmon/max31827.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index db93492193bd..c3500a5b2c29 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -48,7 +48,7 @@
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
-enum chips { max31827 = 1, max31828, max31829 };
+enum chips { max31827 = 1, max31828, max31829, adaq4224_temp };
 
 enum max31827_cnv {
 	MAX31827_CNV_1_DIV_64_HZ = 1,
@@ -592,6 +592,7 @@ static const struct i2c_device_id max31827_i2c_ids[] = {
 	{ "max31827", max31827 },
 	{ "max31828", max31828 },
 	{ "max31829", max31829 },
+	{ "adaq4224_temp", adaq4224_temp },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
@@ -620,6 +621,9 @@ static int max31827_init_client(struct max31827_state *st)
 	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
 
 	type = (enum chips)(uintptr_t)device_get_match_data(dev);
+	if (type == adaq4224_temp) {
+		dev->driver->name = "adaq4224_temp";
+	}
 
 	if (fwnode_property_present(fwnode, "adi,alarm-pol")) {
 		ret = fwnode_property_read_u32(fwnode, "adi,alarm-pol", &data);
@@ -633,6 +637,7 @@ static int max31827_init_client(struct max31827_state *st)
 		 */
 		switch (type) {
 		case max31827:
+		case adaq4224_temp:
 		case max31828:
 			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
 					  MAX31827_ALRM_POL_LOW);
@@ -669,6 +674,7 @@ static int max31827_init_client(struct max31827_state *st)
 		 */
 		switch (type) {
 		case max31827:
+		case adaq4224_temp:
 			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
 					  MAX31827_FLT_Q_1);
 			break;
@@ -750,6 +756,10 @@ static const struct of_device_id max31827_of_match[] = {
 		.compatible = "adi,max31829",
 		.data = (void *)max31829
 	},
+	{
+		.compatible = "adi,adaq4224_temp",
+		.data = (void *)adaq4224_temp
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max31827_of_match);
-- 
2.34.1

