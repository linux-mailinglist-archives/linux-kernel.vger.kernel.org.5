Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F207A7254
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjITFsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjITFsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:48:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06C94;
        Tue, 19 Sep 2023 22:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukg30gJzyF86fJvd3APKQo10aXFiyb+DG5BbJkXN2Nqa3H94svpTHL2J4HE9RlKqB9zde9ilAzqtU7GF+SrgwjLAv5bjTrECFhzpIb7m5/7a/0G94RC8AYNyw8MKJ1shfkvWyrir4ZGeM9A+OrzwJ6sp8QEVukrM8XKq8BNs0jvsHxgVecDxZl1PevDlRfyQbyuxFs8FSq4v/Kfi+PqbJQP3fxGhqe2tZOeVYWIxrs/t5RuiyKMgJg4kcKO3KRQdjeF6XXtbCZDO/w6BnqeCm8+T2/KW5tDLZj8ZWNqOVMCiqFTfgQQkGlBfJQhTZbCKTfK7vjhLLlY4Slx7MBeiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S17km5CeonZm49NhOUG2r3JRsmHCF2JpAAud5YPWx6E=;
 b=LugUTsg+PJpgZA2GK/K/Vmo1WzT5xqdF7v1ZyzWxvGSJSVWdJVNwSS5r0HnRw/8rGgj9k701S5lFhmtbpVXKTR6zAh2hXy235xmmledDwkDxKdbJl/xrIsJ3uROJmwQukRsys1tqcd+FAwVKiNBAKKOpT+JEJxm+NaKUyyazyoEPV72aBIRW2rqJ0GxY3Wyg/DUsYZxuwPmYOF8SXf9up1aznVX9hOEwq+VsHGR+WKv0srM4xcYjGhXG7UbeWGWQWshzuCxP8DMeA9dZplUbXxXaBwR+S3y9DqHBWMC6X2vxvgpA0y2qdSVpx9DfpXhJCoV8+XstSbTSANNHwFUCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S17km5CeonZm49NhOUG2r3JRsmHCF2JpAAud5YPWx6E=;
 b=ru8sD5OaZsVI/o97eXuGrlgwWWnB+mfV+U7bbwxLqzjEGThhyNhQ2kgZ7mEXE1EolQoGvGqKsnczO5RQmBBxpq59ILySzHmV4zmVWJjNy1jjWBB9wW+8/4D8Ia8aWKs3tAMJ6iZqL3mhjllD2N/XLRVzPjPfD4sZNSibW/weWi9itH9C204CKXl1S9D5AyWFRNq9oSwFzTs7NmdyVHfG7GB2kh8CC6OndQZFOTSmmZP8aE9Pw+7AIjPgfoJBISOVmr0XjnoOvReHEA+X93RmIvBDQSdbmxJx1o0D4WZyOuHI11QPYZ3zac/jiu6zzGMNhdt26oVeqaljt7Y2l2oolA==
Received: from SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32) by
 KL1PR0401MB4467.apcprd04.prod.outlook.com (2603:1096:820:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 05:47:52 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::d6) by SG2PR04CA0170.outlook.office365.com
 (2603:1096:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 05:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server id 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023
 05:47:51 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] hwmon: Add support for ina233
Date:   Wed, 20 Sep 2023 13:47:37 +0800
Message-Id: <20230920054739.1561080-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|KL1PR0401MB4467:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c664747-10bd-4495-ee70-08dbb99d2111
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtqKx/1H4hLvYTRFv8S13b5J87xiuENTsBJELP64HIXhhmIvrDsFW+khYB7hJwLOC0yeGCsHAp88AESwqfSRZRgh5CKauEMXyKwctIHLwAiKkkrd+EqyhT7U9yUZtjOPJ4dER9XF3flsiAR3LaxEUQB9FKmfcLeflLf4z5bo6/sDIv/pxi5p8e0jlib96wm/wDZiKwZacMxw5ttmdot5DlhDQhxYg3vwdB4zJkR2ew44F+jc5jfgTf2orLYDNqFb0B/3GNMZi0ZmiCYier296JKxMUGpHeDqdtylpaSIaJAvDdJLsw6rIDeSfJwRqO5Gawm7YnwRj0QYpC29p0PFNFonvqjtNK5bIZ9y6ERIHyRl4TcXU/hrNEmcou8tGI7DMHK6H+7GQejgi/fPQwjnPBgEz6HBmjDkIVpNLOpMwRP4Gs5g2BUHvFnhs2AlCOXJ/oM9XWpGB0a8CqSzH4XcvKy31ecye5KAU8uR0Tux3MIuJZMYRTh92n3khHpVpSIsqB+sQeBdcFRU7QtbHiivnKQO2CI5HPAEAjAAoe1gLX3etcMpBpRWA52tpJHZRlDhkXHNYLeHYHdl3yE0jmwngRDDbJNI+gtxkPbLxR61a35ZuSAFTsp0m2AVwTyrC6M5j9L6fC4WO1pOSDV1wJnX+cq7bVR+bK5E5TImeONmbFmEdpVuXqdjNrLA9KXKNiqK7yegDHr1s+kZSaMi8zWnRg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(6666004)(6486002)(6506007)(36756003)(9316004)(478600001)(40480700001)(86362001)(316002)(83380400001)(2906002)(5660300002)(47076005)(36860700001)(956004)(82740400003)(2616005)(81166007)(6512007)(356005)(336012)(26005)(70206006)(54906003)(41300700001)(36736006)(110136005)(70586007)(4326008)(8936002)(1076003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:47:51.2634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c664747-10bd-4495-ee70-08dbb99d2111
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INA233 device is a current, voltage and power monitor
with an I2C-, SMBus-,and PMBus-compatible interface
that is compliant with digital bus voltages from 1.8 V to 5.0 V.
The device monitors and reports values for current, voltage and power.
The integrated power accumulator can be used for energy
or average power calculations. Programmable calibration value,
conversion times and averaging when combined with an internal multiplier
enable direct readouts of current in amperes and power in watts.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 drivers/hwmon/pmbus/Kconfig  |  9 ++++
 drivers/hwmon/pmbus/Makefile |  1 +
 drivers/hwmon/pmbus/ina233.c | 89 ++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/ina233.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index b4e93bd5835e..0abc1fd20bbb 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -509,4 +509,13 @@ config SENSORS_ZL6100
 	  This driver can also be built as a module. If so, the module will
 	  be called zl6100.
 
+config SENSORS_INA233
+        tristate "Texas Instruments INA233 and compatibles"
+        help
+          If you say yes here you get hardware monitoring support for Texas
+          Instruments INA233.
+
+          This driver can also be built as a module. If so, the module will
+          be called ina233.
+
 endif # PMBUS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 84ee960a6c2d..c8888e7ac94f 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
 obj-$(CONFIG_SENSORS_XDPE152)	+= xdpe152c4.o
 obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
 obj-$(CONFIG_SENSORS_PIM4328)	+= pim4328.o
+obj-$(CONFIG_SENSORS_INA233) 	+= ina233.o
diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
new file mode 100644
index 000000000000..393b595344c5
--- /dev/null
+++ b/drivers/hwmon/pmbus/ina233.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Texas Instruments INA233
+ *
+ * Copyright (c) 2017 Google Inc
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+#define MFR_CALIBRATION	0xd4
+
+struct pmbus_driver_info ina233_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT
+		| PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
+	.m[PSC_VOLTAGE_IN] = 8,
+	.m[PSC_VOLTAGE_OUT] = 8,
+	.R[PSC_VOLTAGE_IN] = 2,
+	.R[PSC_VOLTAGE_OUT] = 2,
+};
+
+static int ina233_probe(struct i2c_client *client)
+{
+	int ret;
+	u16 shunt;
+	u16 current_lsb;
+	of_property_read_u16(client->dev.of_node, "resistor-calibration", &shunt);
+
+	ret = i2c_smbus_write_word_data(client, MFR_CALIBRATION, shunt);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to set calibration\n");
+		return ret;
+	}
+	ret = of_property_read_u16(client->dev.of_node, "current-lsb", &current_lsb);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to set current_lsb\n");
+		return ret;
+	} else {
+		// Referenced by table of Telemetryand WarningConversionCoefficients in datasheet
+		ina233_info.m[PSC_CURRENT_IN] = 1000 / current_lsb;
+		ina233_info.m[PSC_CURRENT_OUT] = 1000 / current_lsb;
+		ina233_info.m[PSC_POWER] = 40 / current_lsb;
+	}
+
+	return pmbus_do_probe(client, &ina233_info);
+}
+
+static const struct i2c_device_id ina233_id[] = {
+	{"ina233", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ina233_id);
+
+static const struct of_device_id __maybe_unused ina233_of_match[] = {
+	{ .compatible = "ti,ina233" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ina233_of_match);
+
+static struct i2c_driver ina233_driver = {
+	.driver = {
+		   .name = "ina233",
+		   .of_match_table = of_match_ptr(ina233_of_match),
+		   },
+	.probe_new = ina233_probe,
+	.id_table = ina233_id,
+};
+
+module_i2c_driver(ina233_driver);
+
+MODULE_AUTHOR("Eli Huang <eli_huang@wiwynn.com>");
+MODULE_DESCRIPTION("PMBus driver for Texas Instruments INA233 and compatible chips");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
+
-- 
2.25.1

