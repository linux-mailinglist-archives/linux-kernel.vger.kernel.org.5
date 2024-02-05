Return-Path: <linux-kernel+bounces-52039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D857849337
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B65281DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D8B673;
	Mon,  5 Feb 2024 05:13:52 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2136.outbound.protection.outlook.com [40.107.222.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36CB65D;
	Mon,  5 Feb 2024 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110031; cv=fail; b=LhYSum4+zQvOL78H4VSxqFfg+FFF8NAh+ifZ0oZ7u5wD7NxSRQ4kgtWf3u3j4rb6sz7FzMD0vQZoj78qDVZR3T8V7w1YLQhyp/Br+ZSkR+adDZ/7Iv+oHP481zqiDAk8GZqHdT70xLZNa4blo61EFizMtUfudlNI9n5sswUtjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110031; c=relaxed/simple;
	bh=oHK5nQriiB6h9xMedAEPg4pqI0JWQ8qWWsiADuTWufg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PhBaHn58tySdnRvO+NEKTUdv8ADLQS76MWSkBt6haC8vhgAPew8CSZvDhAXG4VwRr+FaxI69+tcGQWif41yAkyHabwyPND2aHJxxr/4cs7B0lu80KktTw7p/c2yaYa52fk+nvyWEPQrVYP51zhRwd8y1dek5FJkdFh6hi9rBZdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk5bNu4oNJ3gVJwJNBwAuYcZDv/TbGmkJoleX8NNQg5OM0ZXQlpZtDBBefxrjCsdoRnz/yzAxRH5X9r+BJBdqcoyxqR3sx2H34CAqdb6BiQNNl+mABs0TGa6niSqyMwCVcmFXv4hLMbWNhbRlOc6jJ55xvDRFX1dfM9xLQYHHy0quHy5n6P8BGLNeuDq8BVWd/O9ouORWldNOZLlSlg8YYEwXfyIhK06irn60lq0PWnxkiI4TJvV/t/eqRP+O4ivnpeS1b8po5nfXIfi7kV0X+WNanD6q9WCd/CTQCGP/szo8kS6SQ5hQ4YwBMBeDICrfYLQtEV3fU0pGS4YIqsuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck/RK1k8Lt2fShut1w+cKgVzxJDNr/D1Kx+TZP8kdbQ=;
 b=UjW39Q56VmXHuVKg9NDY9HHYDsrAvNKkO8Ptngzi4V4WyVdu1E5fJh4bX+8p0YnDWl7Fe6JR9nktnh5jOXT6COA1NnUgcHIudMVOF5eNJMlFLaBnuHsTK85mjKUz2rURqvJZ/zC4nxsEDTLWCjKC8HvG2VfDFCseEXwNIOe6Gt85zpK+UoaVXNBFv812mnxV9A9Hy8/i0KARp9veWIugfo6iVS/OU5EREDmAs9CTvL7c+oWCz7eMpxXmiYz4rUDVwrCq+uoOMy7enryKuAJJq9IFuzOeRrfTL/q2WD3Srmg3LLawNnVUlHPw3npeYxWLF+QGUS4PskoMjNAfRdvKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PN0PR01MB5496.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:63::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 05:13:45 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 05:13:45 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Mon,  5 Feb 2024 10:43:17 +0530
Message-Id: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|PN0PR01MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbc2cfc-6bd0-45aa-5918-08dc26093a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OMA7eKlJac7me31QHuo3KZmDVzQUXHXDNlFUZif8xMiCTjD2fJ8xm0Zx4VKJsY+tfmLYf6QnaA9nUBmcQc+KNaLaAjjlu5772uLJsJJSvtT8f5ABUk6bUIvLQt8J/EZQnGiwVtlOncqF1QLR50lHSC4W1gKMzS7O59oz53VJiU/6tkysAyBNYGQczAwc6rDfjm+r4HuRPyxfZFNgT1fnDA4N5sxN4isECBlpQ4c274wAfZNN9jrZGh1M+IZQ78oM7mYAW4mgbOFLqXrkrJUFqD3DcKcu4y6Na/Q46tpDrU/EdHSy8qc9A0y3CgYI07R2t31BhkdG2+Uor48nteLKJ0coyyXHS7k3TkKFG5o2p9EPiFmDM1rBJMT9zKlJl8RvgCjOfpCLOVldv0m+gbWpzIOcgj3mpUhN7bxnl5sCp6A1ykmUWRtt7rszQsHzQyq9ncPLxvTVp66GA9BAPx5mTHERA6qgP3rZzVlbqdo/7qsx0hlUBdsPYtIjKl6ik/+CS+rz8v3/126nWcB0LTJYBBeAfm71kfjSN8VQythpFZgQly4AnJCN8Rr5erU/c+PM9nA7M3ahIXR+MvcDcPA/jBmFkKsFBov0Hj5OQv39VMclH6db280eHU/JhqpfkyuP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39830400003)(366004)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(36756003)(38350700005)(2906002)(66476007)(6486002)(66946007)(2616005)(1076003)(52116002)(6512007)(6506007)(6666004)(478600001)(86362001)(44832011)(83380400001)(5660300002)(54906003)(26005)(316002)(8936002)(4326008)(66556008)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XNXAeYlWuMZwJ9PTHA6mppcJFPtpzhpJAsFUqn3Nza3XyPUoxuypCTUVUkv6?=
 =?us-ascii?Q?RIfZKEkQ677fSgNIdo9gpymB7/IyYaAMrDBi2ZeYnTlxVJBzBoyGzyku4ww0?=
 =?us-ascii?Q?mYidgxvpqsQEEgSjzMNzWYd9qTZl6j9Uld8Q+MgxWNeQzBpzFVIu5sTqXVVe?=
 =?us-ascii?Q?gQnZwKBqixtjrrytK4Zq3Q7WdOchRwr8KyuT6hJQVW152gmWBoGEEJPEUyKC?=
 =?us-ascii?Q?lp0eY1jRLTprNAgpF99idOxxML6LxB7uzRcnenI6Ux6uLqMY6ExWAYgW+Cnl?=
 =?us-ascii?Q?l/LtjPKYux7ejxoIatkWlj5F9iRGlakwXZkZukS8UaHH/t+wluqSH8WLXBGO?=
 =?us-ascii?Q?YUPxtUnTC4OHWFFjHNvcaCoh3yOmTjQRoO4nagQ/+5tmZHeoJvONhLJPv4S7?=
 =?us-ascii?Q?zPOm5Wvv6RwkE0SOC/eZmkElnm5SRTDqh4Rhou5aL5OyaQ1R3gHOILBx73r5?=
 =?us-ascii?Q?0xsO4bmBeulvRWHbcsmPV98gV4KjwHDhfz+tZ/19H3ttajy38t4gk8urQYmc?=
 =?us-ascii?Q?jnJU/kXrhQwKRwfm+pjahWD8gvyoEuh52CFhxAfV8sdH/xq/aT/45RDGnH7d?=
 =?us-ascii?Q?oY03e73ejpCGwaAQAUZucLoNCG2CczeDQkzvRlVMqptYaYVK6W/19TjryOfB?=
 =?us-ascii?Q?t35P2Xfu0bJIy7Y+IU161vCuvixJCn3w7MMBXXzHU/w45z+H5VwYg+HiFHK7?=
 =?us-ascii?Q?HIjL2JoX31w0zEYK/mQaArQMaEZ+S32DTVW7D8qopHFg3B2DCuMgqgVA+U/j?=
 =?us-ascii?Q?MwcGmt0fVHfpEkyuOM1unS3ah8bXiJSeiaqr4DEzkJQrbZ5RlPMjqxWssh3K?=
 =?us-ascii?Q?EHbgwIbktxOulsCcA2udzdL0R4sFPJBSTwkvdALprXW2knKJKl11TbLBti0l?=
 =?us-ascii?Q?NXpQmAs/VC5JNE7+YWtWoUinU8oXHEt/rKhlubwodQarEyHQfx4+636VuIbX?=
 =?us-ascii?Q?Z03foA+PaAST4fdZy11COfPmyqv/KlQES3Sbe5OosqiVX1MNr0xQ7Iw9U/hv?=
 =?us-ascii?Q?xz3Th+WF3hFoKHdhHnN0H5n+lKNZ8Ea4VHEvXLV0Q7zQI8rrLQtevb72hQhh?=
 =?us-ascii?Q?OMJ8YDMoYOGD+JKMpDnyHFy0CEQmDl0Mi9HD300NFJtp/vnt+cPm+ColULcQ?=
 =?us-ascii?Q?gQi4EaWWaJIwaXMgG31mvjDPp9TMgqRkV6X5EU07wd9Ko220gaEuikDkySYx?=
 =?us-ascii?Q?4jdD2TV7E3YQJQyKvblvlthYJ8GW1YSSJANwy4UZXJvb4N0S03vl2TJDqDZv?=
 =?us-ascii?Q?aHV2H8xNzvO+6f7CPQDtsbGbxXhzIKkDrD3y9C1pzZibflW1JMHg4Gj9Ejck?=
 =?us-ascii?Q?/7nh4HexCiW0ZCa+1bb8kjQMGV+ZHE/qakOYn4KDsJqjzfkekjuiBrgA3al5?=
 =?us-ascii?Q?qsHFJc23wXIdgpsLzVAteoDIOWXl3ouW4J21b6E+rhjOOG8AmTFVW0MkuASQ?=
 =?us-ascii?Q?CCphoriDXDfy1BodcyGNjOYDUSWR0YoU/BDxg8+jKoEwnlFpotLEsmTQQdjt?=
 =?us-ascii?Q?kWz3rNuvCh+MjDwAFtyvnb9v55vLKT4w+ofd6Hh5uFYIPEc1n6ggh8Wj1Bkq?=
 =?us-ascii?Q?eXBcqaf67taQ5M/i3MG12vnExE5WwNBjLpAiwsPENIA5D0zg6eYotaJmlqUz?=
 =?us-ascii?Q?Ys/2EFqQZayoLqw9s6BZnxI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc2cfc-6bd0-45aa-5918-08dc26093a4c
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 05:13:45.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9aINSWVua3UTKxaMfQzCAjnxFwVJIipyYl8RxMTJUTFN6xUbIDDnMYeu3NwIFF3pne8iIbtYPfZZs/xeyY1VIUXSjZxZiqr/CYaUmFEy4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5496

Adding minimal support for stc3117 fuel gauge driver
to read battery voltage level

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
Changelogs :

v2 -> v3
- Resolved kernel test robot build warnings
- Aligned included header files in alphabetical order
- Removed unused header files
- Removed unnecessary blank lines
- Aligned all the macros in alphabetical order
- Changed macro LSB_VALUE to VOLTAGE_LSB_VALUE
- Dropped function prototypes and arranged the code accordingly
- Used macros instead of static numbers for array declaration
- Removed redundant code
- Replaced 'power_supply_register' with 'devm_power_supply_register' and 'pr_err' with 'dev_err'
- Removed global variables

v1 -> v2
- No change
---
 drivers/power/supply/Kconfig              |   7 ++
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 107 ++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f21cb05815ec..e2e3af4bcd5f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -875,6 +875,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+        tristate "STMicroelectronics STC3117 fuel gauge driver"
+        depends on I2C
+        help
+          Say Y here to enable support for fuel gauge with STC3117
+          PMIC chips.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..be8961661bd1 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)        += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..29eb00b44e21
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+
+#define VOLTAGE_DATA_SIZE	2		// in bytes
+#define VOLTAGE_LSB_VALUE	2200		// in micro-volts
+#define VOLTAGE_REG_ADDR	0x08
+#define VOLTAGE_REG_ADDR_SIZE	1		// in bytes
+
+static int stc3117_get_batt_volt(const struct i2c_client *stc_client)
+{
+	int ret, volt = 0;
+	char i2c_tx = VOLTAGE_REG_ADDR, i2c_rx[VOLTAGE_DATA_SIZE] = {0};
+
+	ret = i2c_master_send(stc_client, &i2c_tx, VOLTAGE_REG_ADDR_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(stc_client, i2c_rx, VOLTAGE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	volt = (i2c_rx[1] << 8) + i2c_rx[0];
+	volt *= VOLTAGE_LSB_VALUE;
+
+	return volt;
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct i2c_client *client = to_i2c_client(psy->dev.parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = stc3117_get_batt_volt(client);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
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
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev;
+	struct power_supply *stc_sply;
+
+	dev = &client->dev;
+
+	psy_cfg.of_node = dev->of_node;
+
+	stc_sply = devm_power_supply_register(dev, &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(stc_sply))
+		dev_err(dev, "failed to register battery\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{"stc3117", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.25.1


