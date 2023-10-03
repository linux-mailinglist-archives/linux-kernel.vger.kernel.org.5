Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03347B5F49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjJCDPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjJCDPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:15:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30202BF;
        Mon,  2 Oct 2023 20:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4wUYJZH/QukVlr3CSe3m+qI1XlXvwW6SzMtFW5ls6SQacwbKchWnemZcWK6QOBDzooD6r7KjRcK9+3T884kknD29E0GES2xSfkFqe3wI6UGJX38uRsTGBoSkfGHtahidtBMihQs6niBEkHdrU4BeP/hCYO0NiWhGcpo0x+8ZKHX3lIq8ktGYl6VoROQpvgJ8xWPmYCK0l0U6dR6iDaDy/+hl7PjF50Mzb3UZPn2kujSqgu/mBtOsGqxPgHBhgL1xFBQv7GzdscDpq5x3aa6XJ5BfH7Oqb4EDxeXf6reXrL+mrWE2TZFLGNsjlrbb6vRTHjzAN5t92sVQkjd+orkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhcupRVguHD23QKE8oNsJAFJDqkHYCOuasp3ePxcOYM=;
 b=WqoegegHcge8wup6Lb/F/vn+AmurXe5ERg3slQdG+qhNoC578ISReIxtMH5NtU0t7z6yzvB6uEQPjREeyaLk4IUnmpy6ZioDw8UI/2SAP4zbF6zpJSqvop9wufdHofaHRGiab/avcZGHPH8ti45QmavpueIvsSga/q5Yg+EUN1M5GJtUsNjwdlou3hhbPTWrrwcBvNBZ9WmwB7keY27HjsO1qL5YNyj05ED25uXR8e+XQ5St2jyQPoze1vlmU8qMbeGr1KmPa3XDOO9/Sg6NfzeHfrqGYMx3/T6fHAdafDbhq1fq9cQ1y9Ynxmvh+C1AGlnbwC6CvApv+Q3Jg6vIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhcupRVguHD23QKE8oNsJAFJDqkHYCOuasp3ePxcOYM=;
 b=nzRCRMMjkAHkQ4xL7t1vHwsbwTPIaNEcuidzoN9sKp27x91AWjbyti0Igg581Ubshm0i/69fmqquRX4LrV0qfaYpGYc7aw2T1gguctpTJreJ2cYuxhvl3AA9ErvhesaaT0X9H86g3oXFsm1qVxzJAxqjmef2OvtIA4kkXhwD9jHdrgCWnDucW801L37S7kBdi1BloTH+xWGWLeQ1haKZw7yz0z6PJgdsgoKCnHRO3l+hB/vbdUb3CHu97yoPSKu2PlWmbugD8xMaLwz1Bom19LNX81ZaD3xBZANTrosL3kE57Ag45vD9ca4nF+2OzsLSgrYogNmpz8hj4h6HOSSxWA==
Received: from SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) by
 SEZPR04MB6356.apcprd04.prod.outlook.com (2603:1096:101:ca::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 3 Oct 2023 03:15:29 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:fc) by SG2P153CA0017.outlook.office365.com
 (2603:1096::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.6 via Frontend
 Transport; Tue, 3 Oct 2023 03:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:15:29
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] hwmon: max31790: support to config PWM as TACH
Date:   Tue,  3 Oct 2023 11:15:17 +0800
Message-Id: <20231003031520.3091047-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003031520.3091047-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231003031520.3091047-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB6356:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4d53379-66cc-4cf7-dcc4-08dbc3beff45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjIOBp5BWywxc9UvYXLXSdxZwBeP8DmbzF5jUt9VcpWx8rwmuvSU6uoL8vnonjKf2HqKNETuZh88tNS9P8xH4V6QsOQlGyN0xvaV98nfNi0B6laaqarn+Q+dv0dsPtwd0qT2S77XzfWPlwiL/82XujGJwbEJDDdH/ROjDtoMT+c7EHzoLUWIeXnl7kkr50cDwN9BWZ/zY1iVtMPF6yacFr581l3AMjyd6yNndAcX0k2YMbt+jnrzU6XzPFshvHtOHud55oyB1W1cALGLomg23p8SQIL0JPAM6rJcYz0HczUXIIPuXg6Wz/6ivHbOd3nUOuBlQlzk8SMRayBH4wad3xTJvCkhGKNu2gFuEZlvqw/6HgmYNLJX3a/C8+gi03ZJPUfl2di79rpwZf08wFRvFB2hhUT7fH1s56A6p32oY44XT5hZeXeWbw0aKeAagGqSap5Y/ddE2CEDc7D3vn9+xWpIRzVVk+lGa/Wra9pbzHMDw8Bqhe2XCGlIcCbWH3Nbqm8fcrfiu6L6eRPSp9DQMpBdlgwBW7lhQrLdmu7bJtxhyHe/DJt/e6FoqoHPSO9zw9RF2i+IyG1C9jwoxcZyOjekkZTsxeKTcTvCOHHCzQDUUMoG+vgxQ3fD0KixjRFGQ12HQGUAUwxEBbTFPwaXljHK5b8SpPOkwXFL4e8gDDs5kX4pGSYgjXH/btyn2vzOwVTRUSOoJ7rbGSFMSgXQVw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(36736006)(82740400003)(86362001)(36860700001)(6512007)(70586007)(5660300002)(956004)(2616005)(110136005)(8936002)(1076003)(36756003)(4326008)(6486002)(47076005)(316002)(478600001)(8676002)(356005)(70206006)(54906003)(26005)(6506007)(2906002)(41300700001)(81166007)(83380400001)(336012)(9316004)(40480700001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:15:29.0778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d53379-66cc-4cf7-dcc4-08dbc3beff45
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6356
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

