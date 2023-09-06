Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAE793773
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjIFItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjIFItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:49:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226410F9;
        Wed,  6 Sep 2023 01:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzE+jqB7zGp5WDFuuIkA5V6MfL23hk5oH6/wUDpG64dilh2ggR5fav+3yzudtGW9BeHXi874MIytCNC5A9zVnsZdNCejSYLMChT0E2QXb8Kyd6+Wl8GtkfBQlfv/XeIggyRBGUmQRkLYt/HRkzk1FuULUpoI9XBtKG8GdI1GvN1jdWTZ2pJ/wlHkPIP7gvQby7+a12ASR5kfSgp9RkYG/gjcUVlzlY6TDr9U94gJTWxGi2ZHjZaGl/DUuO+R1gM9Mt02eUlKuqwtR9B0Z6R2qoDFs2D+YQWm3EE9NzO4WcQQYcOYjHYSOXX22JCsMbm9T/m/M4I8IPM2x60thUzroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKXNr/oe2wYvRQjWCId679VfS7TWHLak1NRImP25ofg=;
 b=SXhlBs1YfcarCyt9T/QM5xX9tWRtfFaeFMuydV3S7U5oE0FTDQit0EnFrnjB5yPUmvTG0zuIcmm/G7kp+ELedmzSPKGNr135y26vV8FpaeOP6ZD37kbYKCsIaAPFBolijtMqF/UFbevHZgBCmGFq2jAYnAPzrtwrYNMiOZ+B6g2lemY0XQFodP0XPj5eyGH2Frea877RwOWjSjrtLvEmSxqXDJapCQF22zHbA/lLSLPlY8aPuwd/QIxd28pfDWXBd9yfGHkSS6ZCTc/IFASWji+mDhfseOzCQJCFyIgYATlCTEbD+5D1EJXTDJVqqAYnR9JyFdYKJSEWI+rKKPiULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKXNr/oe2wYvRQjWCId679VfS7TWHLak1NRImP25ofg=;
 b=Yq8bSEkGCBCPMT3qofUBY107fhlEJ5VTedawmrP5NrWoV1ClmFFnyGwceMy+S7GeLbU8Tu57RkJ+/43tNwSMmnCOJrzf7rdzfaqELjPU7eehAX5x0f6UGnwJhBKND8SLL6o5uEMjPiomkmaHtuJvbmMHHjhFSDeZYSHCP7g5D6g9mUk3pvJDMospPkseCNQJVCMWm6WdzRIi2D6I8TpgtWfjYNmQkSggi8YvmtYIci7VoP0HyXZeXJPK3I8yhY8qEEx1h9gDAObo9L8FqqVA3EaBiVlPPlSfj7B21z517JD6CM+MyC2GsIptLETi+t/Wb4Skhm7CPBpbMhgl0M62Mg==
Received: from SI1PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:1f5::17)
 by SEZPR04MB7313.apcprd04.prod.outlook.com (2603:1096:101:180::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 08:48:50 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::3a) by SI1PR02CA0060.outlook.office365.com
 (2603:1096:4:1f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 08:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 08:48:49
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: max31790: support to config PWM as TACH
Date:   Wed,  6 Sep 2023 16:48:36 +0800
Message-Id: <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SEZPR04MB7313:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2dac4e9-f303-4e85-1a7d-08dbaeb6173d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymEWLGtsWSaYxtgn6MFd6/bm4CaBirkeGb6Fnr+g771wkUeAUCwQsx4/wTivyaqwT1h8Fznfg2eZJBMdxxpA+IDrUOq6csyfFCk/TQf3wG6Gw7tfa7cspoTzVBRFiTTPjWA0zEgXP/R3GWBxTec0uA1uIUwqZL1sn5e9rKTCb9Dt5CVtg/O6HVqam6AyeGhE4T10T53ZKRQ/qVG0vTX8wLWbzpQHj51ZxsWlgx+OpYYecY0j6795a8PmoMI2j/Ai3M+KyAKzhXQET2dP1u48vUFwRbx6I/+Z+JuC3qRqDEBHWfBvqCq5fJxfIIAyZrWs7kazuLkAWNuFCjhABckWyqzbu3louHZH2oorHlxk54vhYmBR0G8ukfMV2cmXWcuM0cq/LzBl0Xk4D6OjE0/MxvHag2WYtjNobDGVL1yuTXPly+Yq3ryp7o6gA749eSA6ccNUJ782kOaHwKJv0c8iHvAorfelAMiQtDpYzsrm3Y2mVU4m+3K6NTgnymrGMbxuBLG4WiP6nad3cUpMXKBnuK8fMpoCRQV7/0tHgFoF5LHCrMrT8jk0BaVMqubLJsavdlIhb7JZAzRJqN08DOOOCyX8alp/sqAVivYfvY6W0BZFQon9Ng4fVpn4X6fKk+KAP3jF/zCDb59nxoqfc+xoKYU5lf6ZzmVvLuPPooiqlB0zvhG2F5xjDSxZ7LjtaNsM8NTZzIFcmxfgcI96GOj8Wg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(346002)(136003)(396003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(36860700001)(83380400001)(2906002)(9316004)(36756003)(47076005)(86362001)(356005)(81166007)(6486002)(40480700001)(82740400003)(6506007)(6512007)(41300700001)(70206006)(36736006)(316002)(110136005)(70586007)(2616005)(4326008)(956004)(1076003)(8676002)(8936002)(478600001)(6666004)(336012)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:48:49.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dac4e9-f303-4e85-1a7d-08dbaeb6173d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
For example: set `pwm-as-tach = /bits/ 8 <2 5>` in DTS for max31790 and
the driver will config PWMOUT2 and PWMOUT5 as TACH8 and TACH11.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 drivers/hwmon/max31790.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 0cd44c1e998a..0f8fe911539b 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -480,6 +480,52 @@ static const struct hwmon_chip_info max31790_chip_info = {
 	.info = max31790_info,
 };
 
+static int max31790_config_pwm_as_tach(struct device *dev,
+				       struct i2c_client *client)
+{
+	struct device_node *np = dev->of_node;
+	int i, ret = 0, size, channel;
+	u8 pwm_index[NR_CHANNEL] = { 0 };
+	u8 fan_config;
+
+	size = of_property_count_u8_elems(np, "pwm-as-tach");
+
+	if ((size > 0) && (size <= NR_CHANNEL)) {
+		ret = of_property_read_u8_array(np, "pwm-as-tach", pwm_index,
+						size);
+		if (ret) {
+			dev_err(dev,
+				"Property 'pwm-as-tach' cannot be read.\n");
+			return ret;
+		}
+
+		for (i = 0; i < size; i++) {
+			if ((pwm_index[i] == 0) ||
+			    (pwm_index[i] > NR_CHANNEL)) {
+				continue;
+			}
+
+			channel = pwm_index[i] - 1;
+			fan_config = i2c_smbus_read_byte_data(
+				client, MAX31790_REG_FAN_CONFIG(channel));
+			if (fan_config < 0) {
+				dev_err(dev,
+					"Read fan config for channel %d failed.\n",
+					channel);
+				return fan_config;
+			}
+
+			fan_config |= (MAX31790_FAN_CFG_CTRL_MON |
+				       MAX31790_FAN_CFG_TACH_INPUT);
+			i2c_smbus_write_byte_data(
+				client, MAX31790_REG_FAN_CONFIG(channel),
+				fan_config);
+		}
+	}
+
+	return 0;
+}
+
 static int max31790_init_client(struct i2c_client *client,
 				struct max31790_data *data)
 {
@@ -521,6 +567,10 @@ static int max31790_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->update_lock);
 
+	err = max31790_config_pwm_as_tach(dev, client);
+	if (err)
+		dev_crit(dev, "Config PWM as TACH failed.\n");
+
 	/*
 	 * Initialize the max31790 chip
 	 */
-- 
2.25.1

