Return-Path: <linux-kernel+bounces-18580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226AD825FB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952EB1F225D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AD37498;
	Sat,  6 Jan 2024 13:36:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2071.outbound.protection.outlook.com [40.107.239.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C1747C;
	Sat,  6 Jan 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cASncjrKf7+9sq9r8FTiua0WBjCjh8lEtOktl3hhJ+08dqfh7/oFJVnF9GZiipGntrT3VxfrgDHR08mKKEYSMq+tF4euknxJ8tYXcWZhxZvVjWpn0rvVs38jwFgsOQjWc75NJizaMYPwF6IlblqDj/w4+RuYAa85BM27/1+mo7wGtyjMhQW1c0acGEvK/eO/p6H+r7OND0b3zaT/BDyZOFtZzqN6OrDS0rxt3X6x5z5KsQzIh1iAg5SvIcF/eEzarXgc8uqKjfTgHrXQcLbfCFfpPfAXmNmuAhAVHBR/skEBiECE9dAk70YCT9Dig8uwklogiTn6J6dBouRPxdJuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wwk6m9u3N0UKtKoL5dnXMW81O2EX6msPg70iq+GdFFY=;
 b=dSz+0rrvjuui2/mBRaNySy470WS3z3PPM2lJp+cK3V0NcyaWPrqf6ejGitAlJ0OEHn+Z0RGciVAO0uIBBubWu1mXuUKWMfSwskwTphevfdYDZuGLxQZRsIH7iaQUcfa52qGC3qhWcOjPyl/V11lveML6s9GuXZsuJvpT6gshVHC74m8x2+wqjgopMfbWoitnLpfSp1ksN9xV11p39/e7uYLIJrKfIA1DlB4TCY9oXkgbPFRAuFU4aqHGpmfWcYew/y10Mfb7LYTxcmIP6ha+Z1zQRnODLtGAV3QmeKUyGUG3vYe94G1eeGk0h5nf48OOY9wGkjD1my8Mo5bQQWGmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MA0PR01MB8931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 13:36:05 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 13:36:05 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Sat,  6 Jan 2024 19:05:43 +0530
Message-Id: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|MA0PR01MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e466bf-b959-4700-8ef0-08dc0ebc6eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wx7sa/bgOBdFMfIsvSauCm6saU5r6H2hdGnzQ95yKnuZhBHc2bva0v5vM81GtnJv4V6lDRL5Zg2QP8Hg7Zdt2DbOvTIp5Tb5h80NkfL0VOapWBQAE3swQIyRmA7pKLWPdzLU6ZlMBzGeWW/S9PLIw8h56aBVNlRO0ZFo41CgbLKnCLSPBKRhFosary4RSENWdkDeE+sF2pr8aW4IquH85a3efUsmRF8BWVe/Cb8j2Yvm11qR49Ob+f+uoLv7Q18pZjNDha1gMLk6PYFoyu4a3D1c0JYu3Qd+Qbfp3IUt0HgYhWuDWmPTmMmmBbVd7LJOGSnmczfTt1d/7Uj0IUMD0dq88R60qFazetid9v4kQmzD8NTxYAgmAFT4OqH0QarYDqYbH+fLEFFhRnIiuRajJIk1DlsvAzsV3Y/3k8pP8LvYnuCjQNT6e+dnv0hOPHqQjUABBpNIY2rfFWuS3tT5UysCyr1AHjDLCn8zE/acByP/yYH5i+c19UJNgFWmYJ2FDYTwajA/CYZIOXWKVeCkHGs2Z9qQbWJjsqhztT1pX/KELWsL0a8flRvNYslpEl5KVZyafPcbwD3XTgCfVadqZbG7mnegELZ5MfQ/xAOgyHhsJdA6O8QY7fI9dyLWsDBo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39830400003)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(44832011)(4326008)(5660300002)(2906002)(38350700005)(6512007)(478600001)(6666004)(6506007)(52116002)(83380400001)(26005)(2616005)(1076003)(54906003)(316002)(66946007)(66476007)(6916009)(36756003)(66556008)(8936002)(8676002)(6486002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gCLHgOB53GooIwR64j4oVZlWSTn29LpAMHHeZxhGDmOA+aB4E3Dl65F3IxOR?=
 =?us-ascii?Q?JOGj2a+YloZiVT1gjtTRz27c99goAfsc6wJ1xFpCfmCt/30x9MniDjsvh/o/?=
 =?us-ascii?Q?+Fhet9hmLopnKOw4R0qkq2a9dMczT9sMbZNMktUfb42TBZ/OTZoJ9CU1s+Ub?=
 =?us-ascii?Q?HXRelIFcZRTYNs8Lou0xyLVAmapoVWggop8DE3pkT2NA5eL7jkmllvpiNSuF?=
 =?us-ascii?Q?KnomVcDM3GYiII+0fnXJhqT84bx0a5na7OdW3kY6paeIeQe2Ttd2m1FFQ2pQ?=
 =?us-ascii?Q?kFpctyq1YdCG0ZcUuAq+7zCYZkbhL35uKAtpXAEcXJSGY5nm8xA/JmuDZcSZ?=
 =?us-ascii?Q?pHNf9RYt1vHV9q+wXeBsNPnDPy0eluH/tcPoi2HnGwCCwjw3LkXB6mZOiWnV?=
 =?us-ascii?Q?sSMnOb5/Wv6aNSowNDjTioR+f/Co9evhCIiKKUP8iSGgw7Z+/73dGbpK1lmQ?=
 =?us-ascii?Q?X0S4earfxM6/mvGYV0f+AfSv266eORureoz6PSXg9TVufzaRr9ejw2mE1W4l?=
 =?us-ascii?Q?frlT5DfxNcAyDNVYOMGsxHanF9S+DaTxk3gyUuTZQapJ6CIh/iejuwuAJfVS?=
 =?us-ascii?Q?Khm0dgGAQi2OAM6jCTn2sBU9TZn4D80pH7zHcNJw+wtOXJ1H7A8FfZoENlmg?=
 =?us-ascii?Q?++wOBh5cVQW2bugpA1lXCNKoTXYTusa2/9BA0IiYERwboLRNE67Phb2a0ld7?=
 =?us-ascii?Q?pECIesDwMktP1IroKqSnDOaUf++qmO0s5HIFVL0Fn8FfEB6ukKpqLf6PdRRb?=
 =?us-ascii?Q?YLFsDecdnGvEwzlUzvRHJ8x4TJOdBef+xJxeF3090mLo6cJbT1yansnC0qcx?=
 =?us-ascii?Q?ii0JOWL0HOq9PMQgepr3VIL4rJyN+IBPcvy2O7cc/dXnAiWU+u/bJ4y+ems6?=
 =?us-ascii?Q?HDpupX+X+OwgZtSmvIG+bZSC2jBD0831fD+20mbAqQkFB2TeJ35DIJaxzHp9?=
 =?us-ascii?Q?Yu1xTMvpolLFZ2Aiy98mnES/vEz0/SA3oAqIdI49TFOX+dBRi55GqwPSl+xD?=
 =?us-ascii?Q?MKZYPlJ97p7NloKzH2tdiiHjYn55bxsVS524BgDQ39RkSRu0DyQiVzuwmPGb?=
 =?us-ascii?Q?SdAHn+z6J6+JHZ6Wk0dfE/lwAnQ0Ig1LpPt0sNLxl23iXizz2K9qOaeoLgOs?=
 =?us-ascii?Q?MRRJWztnzLl3JgayZ8KMEFG6dYX9bN8GXLEF1rARcdEsHzV43uERaDUYvRRm?=
 =?us-ascii?Q?fu4ImGhDeYqZo/D8ZjS3IZIts5+UAUSayViLSC+R8vo7NT4RhH5vaiYBXHFW?=
 =?us-ascii?Q?JRYpkMT8OqCzXBi79+gfwZNDAkSM7E9HfjSaj6xND6DEP74eC+RYscZDKOls?=
 =?us-ascii?Q?9nh2nJC7VeIbD25tTUTA8iXZLJitMkOpWAxEyBX+G8xHY5QuMpZW8JYbjBOo?=
 =?us-ascii?Q?YDcIzH3T4jfxs0fkT4FsAGOmfJWa/DcgQ9NdJmaZ6J+Fg3JtoPF9psV/3X4x?=
 =?us-ascii?Q?kylQ0lG28amOMKaQNvPfSJhxwBQG4kjpmyaTrrbBQ/pJEwuyrqdEr8Q0jpR0?=
 =?us-ascii?Q?z32rE3+CAvC+1rqtCvEL1R2TCG4OILiLzxc9LYMVv9G5vLNor4fp4pm0Pi7A?=
 =?us-ascii?Q?GaXDkHKnbTpK0GE/pxq1ZvVUJk+CdLkk5JTM3SEPv3wl8Kjl3UYTYvGGPMZt?=
 =?us-ascii?Q?wzzHKLPgxqknC3YHIEyWSmI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e466bf-b959-4700-8ef0-08dc0ebc6eb4
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 13:36:05.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vza/vxOcwoSQ2y+TsFdNH6mUFvw4qWVrQfnHlBanx2aS5yF3MzZ2DJbPHgSBrd/otxIS+EFsf2CzqYdYBtGACgVXa3Lmgs13PMHlDG/Wigk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8931

Adding support for stc3117 fuel gauge driver with
minimal functionality to read voltage level currently

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 drivers/power/supply/Kconfig              |   7 ++
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 136 ++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f21cb0581..02df55b0d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -875,6 +875,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+	tristate "STMicroelectronics STC3117 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for fuel gauge with STC3117
+	  PMIC chips.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278..f8ed3e5a8 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)	+= stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000..bf87bc1b9
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ */
+
+
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/power_supply.h>
+
+#define VOLTAGE_REG_ADDR	0x08
+#define VOLTAGE_REG_ADDR_SIZE	1		//in bytes
+#define VOLTAGE_DATA_SIZE	2		//in bytes
+#define LSB_VALUE		2200		//in micro-volts
+
+
+static int stc3117_probe(struct i2c_client *client);
+static void stc3117_dev_remove(struct i2c_client *client);
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val);
+static int stc3117_get_batt_volt(const struct i2c_client *client);
+
+const struct i2c_client *tmp_client;
+struct power_supply *stc_sply;
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117-fgu" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static const struct i2c_device_id stc3117_id[] = {
+	{"stc3117", 0},
+	{},
+};
+
+
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(stc3117_of_match),
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+	.remove = stc3117_dev_remove,
+};
+
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = stc3117_get_batt_volt(tmp_client);
+	break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static int stc3117_get_batt_volt(const struct i2c_client *stc_client)
+{
+	int ret, volt = 0;
+	char i2c_tx = VOLTAGE_REG_ADDR, i2c_rx[2] = {0};
+
+	ret = i2c_master_send(stc_client, &i2c_tx, VOLTAGE_REG_ADDR_SIZE);
+	if (ret > 0) {
+
+		ret = i2c_master_recv(stc_client, i2c_rx, VOLTAGE_DATA_SIZE);
+		if (ret > 0) {
+
+			volt = (i2c_rx[1] << 8) + i2c_rx[0];
+			volt *= LSB_VALUE;
+
+			return volt;
+		}
+	}
+
+	return ret;
+}
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev;
+
+	dev = &client->dev;
+
+	psy_cfg.of_node = dev->of_node;
+
+	tmp_client = client;
+
+	stc_sply = power_supply_register(dev, &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(stc_sply))
+		pr_err("failed to register battery\n");
+
+	return 0;
+}
+
+static void stc3117_dev_remove(struct i2c_client *client)
+{
+	power_supply_unregister(stc_sply);
+}
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.25.1


