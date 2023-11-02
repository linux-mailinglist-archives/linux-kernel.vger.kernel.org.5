Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F977DEB59
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjKBD3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbjKBD25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:28:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5F113;
        Wed,  1 Nov 2023 20:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsFVwqXJ3HjNoz/aZT+6SLusTTh14SXdf4cei1FvtJC9wBaOCBbGoFK2YLojzKy5ELhqcpHvbB0TCaMcjdL2dsYU3F5KfNO3NhuYo5hKCMBAhK4ceUrBZrItwDDouV6vh56CqmkLtmlFRytlGoddfQjiuyPsOe/2BtxOhCJyMSZoV25RpYMTn7jIg26K4+QLLtbIAPyCBMQRWp6I9VYcowaoLcj2QkooHWFOX2T4WkrqYS2mY6hfHzvN7he49uhc65DZ2FQVackyY3isf7LXn2sbAlZGqcg0AzyjPCa//lqhznLeE45bKCJoOxBXHUxOQbXB0a6OidtiWI8fjpt72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B/LaJXYfe0Z7H/8Zgl9w9YnK4JI/a1utXV39Qi1W9g=;
 b=HzZF5aNgWhIh3Aj+A+KOTY1RJHSPqLj4gbEMSITqY7Ul7YT9fmog+xpPYiScj1UjNCJGj8MODA5h6Ht10necs7rkcHk6YDgaMswyZvt63hNkNpJSSDMPML48uLNVEHqhai4RHfVulA/Ibjfzq1DHPREQqSmYURpCJq7gQNMdHu4zVAp3CFhI+llKR2pnPQC8b0hImcVMabGLlnG3uI/Y9NlqDhqvRxaVLYV6epPuSanhaYRiZEA6JkGoNZH5dmasUHqjiSgZMecHfGiZMUGx/cP252jmEWiUtAyy4JQPSi+3KuDhyCiteAA0672fNJQXSfEK0UB2Ch9nqCiwKtSRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B/LaJXYfe0Z7H/8Zgl9w9YnK4JI/a1utXV39Qi1W9g=;
 b=bbSo7pqh26hw5nbpWm/d4BChEDvE9XqwfSoCFp7Cqf4YdFtmesGZd8s9O2wQKeTzGkalJ2TNjUWgSk4fiuq/vM2vFLPi9Zgf2kByPA/84Ma1+K2GD2l0kjP1Xc+Fo6erX0itXRZaIItEu3cpLTTBQ+C2KpHgwaOPVLg0c/6Qtfbcilt/S3IPtZWL5qxzSkm0gIBXLXPqdcsCNO3sW5zjXoSGX8fmFCJZyu6KKd/uSnKpSI8ciwKc7HbzbkJMix7mb72A56MAhaEXh9ufWlXZIOHfIq8jrHlng5DTKSon12zLn3bmnECXOPKNhMi4MHJewdJTdxoMENLAK6TTgjCv3g==
Received: from SG2PR02CA0009.apcprd02.prod.outlook.com (2603:1096:3:17::21) by
 KL1PR0401MB4276.apcprd04.prod.outlook.com (2603:1096:820:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 03:28:45 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::ab) by SG2PR02CA0009.outlook.office365.com
 (2603:1096:3:17::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 03:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 03:28:44
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 1/3] hwmon: max31790: support to config PWM as TACH
Date:   Thu,  2 Nov 2023 11:28:30 +0800
Message-Id: <20231102032834.3827289-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|KL1PR0401MB4276:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b9726b6-1829-44e7-9a20-08dbdb53d1e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vFtcxr2iRnYNGoBUShqcRMzcGzNuCbA7J7pi4ojsAKVBqnTcN0Mpwy6ljL5nhKrB0mS6jA/Fa7I7LUFfXQjL1uT6dLBuFGJMZim+Nc3gShVhgkGriBV8ZzkDT7NNGehiqSasHLWFz9dQBIEAigX762xQ5yPXsJg/X0MWXxT492PsPjYhmshvmLUXrmzdMyDbsJXtZ1x5ZsA9GKCrW1NM9lcHPerEbzF7MODMd0ZOQxnuTULfwkwMOFN+D1v64/7U6OrWDLO1Gvr6yOCMLrKrGAgXjn3zj4YVS/lEYJFjv12pWkbPv3PHOA6qcT1PVwbc4YSeX1lYpkKHKTJzRk8e30Z5wictvC6ywl4wEOG3+Rho8KYLXqPTWaNVHKKwoNeh3jOr2l3h+27cnKertKl2GU1p99R2a1z2h0Xr4ITTwh70Cs71npaNPMqkSlVg+QntId9GEFA2LzcCtsNWAFNWLeiPzz+sQkXPTpRQMlLZRNhFjb9wWQX/srakVuUX5Yi8cq0Xq6mCW7GhLymJDY6eLbSKj7DwL1qbikwm1YLwm25RGSYglNsbqo7EtXsN0j15o8HePL4QVNPbrKDhhMu5VO284khoQlsH5B5KGaPHkWItsTpBSodVUxeSw4QSGfRtG9KQta43Eahibe2uOF/ExJyYu6KWuu1bFvZn+1FIirnvzTDaM1kcyo+LfpdbKILr6KcOOPklXiIlwC2KlSDLA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(136003)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(64100799003)(82310400011)(36840700001)(46966006)(83380400001)(26005)(2616005)(1076003)(110136005)(316002)(36736006)(70586007)(86362001)(356005)(336012)(82740400003)(70206006)(54906003)(41300700001)(956004)(81166007)(36756003)(7416002)(8676002)(36860700001)(47076005)(5660300002)(4326008)(2906002)(8936002)(6512007)(9316004)(40480700001)(6666004)(6486002)(6506007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 03:28:44.6541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9726b6-1829-44e7-9a20-08dbdb53d1e9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM outputs of max31790 could be used as tachometer inputs by
setting the fan configuration register, but the driver doesn't support
to config the PWM outputs as tachometer inputs currently.

Add a function to get properties of the setting of max31790 to config
PWM outputs as tachometer inputs before initializing max31790.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v4 - No change.
v3 - Use 'sensor-type' in 'channel' node to config pwm as tach.
v2 - Remove unnecessary parentheses.
   - Add more error handling.
   - Change the type of "pwm-as-tach" from u8 to u32 to match binding
     document.
v1 - Support to config PWM as TACH
---
 drivers/hwmon/max31790.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 0cd44c1e998a..378ff32c7c1e 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -480,6 +480,85 @@ static const struct hwmon_chip_info max31790_chip_info = {
 	.info = max31790_info,
 };
 
+static int max31790_config_pwm_as_tach(struct i2c_client *client,
+				       struct device *dev,
+				       struct device_node *node)
+{
+	int ret, channel;
+	u32 reg;
+	u8 fan_config;
+	const char *type_str;
+
+	if (!node->name || of_node_cmp(node->name, "channel"))
+		return 0;
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		dev_err(dev, "Could not read reg value for '%s'\n",
+			node->full_name);
+		return -EINVAL;
+	}
+
+	if (reg > NR_CHANNEL || reg == 0) {
+		dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
+			node->full_name);
+		return -EINVAL;
+	}
+
+	channel = (int)reg - 1;
+
+	if (of_property_read_string(node, "sensor-type", &type_str)) {
+		dev_info(
+			dev,
+			"No sensor-type for '%s', use default setting as PWM output.\n",
+			node->full_name);
+		return 0;
+	}
+
+	if (!strcmp(type_str, "TACH")) {
+		ret = i2c_smbus_read_byte_data(
+			client, MAX31790_REG_FAN_CONFIG(channel));
+		if (ret < 0) {
+			dev_err(dev, "Read fan config for channel %d failed.\n",
+				channel);
+			return ret;
+		}
+		fan_config = ret;
+		fan_config |= (MAX31790_FAN_CFG_CTRL_MON |
+			       MAX31790_FAN_CFG_TACH_INPUT);
+
+		ret = i2c_smbus_write_byte_data(
+			client, MAX31790_REG_FAN_CONFIG(channel), fan_config);
+		if (ret < 0) {
+			dev_err(dev,
+				"Write fan config for channel %d failed.\n",
+				channel);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int max31790_configure_channels(struct i2c_client *client,
+				       struct device *dev)
+{
+	struct device_node *node;
+	int err;
+
+	if (dev->of_node) {
+		for_each_child_of_node(dev->of_node, node) {
+			err = max31790_config_pwm_as_tach(client, dev, node);
+			if (err) {
+				dev_err(dev, "Configure for %s failed.\n",
+					node->full_name);
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int max31790_init_client(struct i2c_client *client,
 				struct max31790_data *data)
 {
@@ -521,6 +600,10 @@ static int max31790_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->update_lock);
 
+	err = max31790_configure_channels(client, dev);
+	if (err)
+		dev_crit(dev, "Config PWM as TACH failed.\n");
+
 	/*
 	 * Initialize the max31790 chip
 	 */
-- 
2.25.1

