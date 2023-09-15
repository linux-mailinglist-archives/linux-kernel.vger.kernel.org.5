Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254A7A161B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjIOG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjIOG3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:29:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77296CCD;
        Thu, 14 Sep 2023 23:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaZLobU1NmJLRxDjFZXJVU0ppMXwwqC2KZxE/kaqf+HchWVkXC+H0ygNx9iUD+9NxwdV7N+hKRls2g4PO49EhTkFlsiXSvJ6V8qmZOvR3Pq5pD31VnamEDBw1aylfKbcN72bZ1FIZh9ReH3sbQgsAAlUGyvBwsLMsy1eDfMl7+v3dbSsd5iEVmEtI6p7zz1oRLt1O2g5VgLcClS9PoCuxURNvlCALvoS6xpRQk731Qt5dnNSbaJVelU2giVfgkfPRpqInDcTFIfcjVuCm/raO54HTnDK0t0a4e7Qcm3xQOZuVAXgyc1ca+pLKOEE8Bl2XOnThCW4g/SyTM8tVECtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFDqZCYrA0aklQDE11Blsokis2MVHnDcqZwbL2HaPAY=;
 b=K01coJsF5egboDFm4QVwiq4zIC7h8rj3bg/TiNMiGmqkE/3LWy8KBgkqtoJIDrrn7EDIK2DA+7fOsuxV3MzLzEP+1eFaQ41h3nQxXVehgO4b91/EhukFIZav871Ei0L0VTRJLD4CEtNavdEhLc7iK7QbABkVGm2AGo3XBl8tDaBxmnw6uzdebHId5TIr+6dOWCbNQF4dxz3z6AVp936dsodSDU+VcHEOT+fpkrb7brHywwYLtlVZbQB+LeaOiuBfR+RaypEmZzenbZ4f5AiMm3t60wJQoFvzofwi6hLSpDRUZz502VX1tjbP/BAvBikSJuR8Bjdu3NNU1G+DpFbfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFDqZCYrA0aklQDE11Blsokis2MVHnDcqZwbL2HaPAY=;
 b=DbIQP9JwMrSRcuM/YxbMJBVto+FVYK5J4c1kgRsmeLQ0sxkHGbenlqqzFnRD8udXH9OvsGzyZtcuz3vFuc7KuTQBoqmVHiFEJT8KnTDD6wkSOc4gs0bDpGm5MRTR7+UMUAEvG4QCO7nToZsrLwDorZhr9gVWLry7IwW+k8HGBX0xOcDyDm/FPu9lHp+4qjmsJUxmfF/v+5sK2TwknLhQLIubobblmv0vP/aEjSCcqizo7jQpjrYm7Ucfw/k+hmQJ8NKHgd8SH3Cjag2PvlyTBdkbhq5cyaWxKS5h+qwvWJNrFxXM5e18WxajtyZ8owtiwIEoEJUxMbHhkqbZeMY26g==
Received: from SG2PR02CA0042.apcprd02.prod.outlook.com (2603:1096:3:18::30) by
 TYZPR04MB5974.apcprd04.prod.outlook.com (2603:1096:400:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 06:29:35 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::33) by SG2PR02CA0042.outlook.office365.com
 (2603:1096:3:18::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 06:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023
 06:29:34 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: max31790: support to config PWM as TACH
Date:   Fri, 15 Sep 2023 14:29:23 +0800
Message-Id: <20230915062926.2460502-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYZPR04MB5974:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 029950d5-3b78-4b0a-ba49-08dbb5b52143
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iw1/p7HBw84nQxwJ0blDp3QVB1ef7Sxw2PsKNGMGtIIauBqM7HelCDDBUNHNSHJVlDCDQ6YRA3pihu+V6N1XfurkVQop4zYYTbqVjRXPA13ofqefFDaYZ+JzbJoHlJg2mcACyHhUta7TLn2Q3n2TWd3jC59PkBush/m2iY3dZrwFUOFlO/gMwpaLd9eYq0no7aVcRMhNq/FyyMmXqriCLxs6lNQZSjgwp7pPv7MmTZjvOVdcjDYCAHaHFtFb6epj/GbgwB1Pv5gRSX6yllUCrNztAq4QghITA9GWbUladmW0n1NJNv06d1FgQYQD8FEdhAX9BLPR21ndATnr7ZqafiiKwMiLcdGWxikGj1Re29OF4GtamfbQVHwa58ZqPhkadPWQ6aKf5cgBDM3kiuZpWgZ4tJrwWhG+IFOSDZ2LG12JDlV+ReTF+5/y0uDkp7ppq8ilzqF4Ah5cc6cGAGcVaNXV0p2GIhsOdFraurX5qb0k9v6hNXEHr214JWnnB7rd3rupC3dpsLHGkmr5COEeRapcl3zy0hn9iDlZQFwlzq/UsXqI9NdvCT/TqWhWA33qtqFm+ib2eG4OLC/Bcb/vCfX8BEach3sWgJcdqaBooX6/t8TvItXNUnBlWipcItTKdYJ1WgA5gShv3gLURQwpSddtLdBKTZEuWVS7q8UjMRLI6M821k+9WgYS/ebpFF7SqdDOgqk0/axQWuJXvdULpw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(396003)(39850400004)(376002)(136003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(36860700001)(336012)(83380400001)(26005)(2616005)(1076003)(47076005)(956004)(6512007)(6666004)(5660300002)(6486002)(9316004)(6506007)(356005)(82740400003)(110136005)(2906002)(8936002)(40480700001)(70586007)(478600001)(70206006)(4326008)(8676002)(36756003)(316002)(54906003)(36736006)(81166007)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:29:34.8914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029950d5-3b78-4b0a-ba49-08dbb5b52143
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5974
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
For example: set `pwm-as-tach = <2 5>` in DTS for max31790 and
the driver will config PWMOUT2 and PWMOUT5 as TACH8 and TACH11.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v2 - Remove unnecessary parentheses.
   - Add more error handling.
   - Change the type of "pwm-as-tach" from u8 to u32 to match binding
     document.
v1 - Support to config PWM as TACH
---
 drivers/hwmon/max31790.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 0cd44c1e998a..7826d94306c5 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -480,6 +480,60 @@ static const struct hwmon_chip_info max31790_chip_info = {
 	.info = max31790_info,
 };
 
+static int max31790_config_pwm_as_tach(struct device *dev,
+				       struct i2c_client *client)
+{
+	struct device_node *np = dev->of_node;
+	int i, ret, size, channel;
+	u32 pwm_index[NR_CHANNEL] = { 0 };
+	u8 fan_config;
+
+	size = of_property_count_u32_elems(np, "pwm-as-tach");
+
+	if (size > 0 && size <= NR_CHANNEL) {
+		ret = of_property_read_u32_array(np, "pwm-as-tach", pwm_index,
+						 size);
+		if (ret) {
+			dev_err(dev,
+				"Property 'pwm-as-tach' cannot be read.\n");
+			return ret;
+		}
+
+		for (i = 0; i < size; i++) {
+			if (pwm_index[i] == 0 || pwm_index[i] > NR_CHANNEL) {
+				dev_err(dev, "Not support to config PWM %x.\n",
+					pwm_index[i]);
+				return -EOPNOTSUPP;
+			}
+
+			channel = pwm_index[i] - 1;
+			ret = i2c_smbus_read_byte_data(
+				client, MAX31790_REG_FAN_CONFIG(channel));
+			if (ret < 0) {
+				dev_err(dev,
+					"Read fan config for channel %d failed.\n",
+					channel);
+				return ret;
+			}
+			fan_config = ret;
+			fan_config |= (MAX31790_FAN_CFG_CTRL_MON |
+				       MAX31790_FAN_CFG_TACH_INPUT);
+
+			ret = i2c_smbus_write_byte_data(
+				client, MAX31790_REG_FAN_CONFIG(channel),
+				fan_config);
+			if (ret < 0) {
+				dev_err(dev,
+					"Write fan config for channel %d failed.\n",
+					channel);
+				return ret;
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
@@ -521,6 +575,10 @@ static int max31790_probe(struct i2c_client *client)
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

