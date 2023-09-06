Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E8793774
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjIFItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjIFItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:49:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C410C9;
        Wed,  6 Sep 2023 01:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2/DUXnS4+8DqecJS90oVYuzbJcGirkwEXy9hJmPZWa2zjSgbknMLgU6IQCuGX+GXnzMlxPnysQd8mOFfFOnl4BLyjzXIiROJSJ/FFIxLU+lrx9b/FySyf2cZPMtSi11+oQUwU6pkMIlqZFcntpfsajkyTVnjbajNtlu4hbEvaKWNYo9pitLaZmSbgL9Tu+FOk3zYxBriJBBlho0wOS5UsV7FERK5vw7nphLq7LPh/wg3U1OuQoEO9k5LXqCv/3Tfuu+sZkTS3wyCHesgHy6m4N8RjyGjTBdGRz9egmL1P0Antac9dKWVzbsWdiHh/XQaSiPoNH42VgPsSrf/D2dZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKXNr/oe2wYvRQjWCId679VfS7TWHLak1NRImP25ofg=;
 b=K6Piq7Xz2nNaw+8PaEtsBnew06pftaH6WTp4Nd0qr/5kCq5iEGu2u9Zc6YRoCgLjiB0PW1xHAkEoVSgUKeVBoKCu/UUBUev+yeC+RFnEp2oq9C5l1Tae2Y4q+9pxwI0ZRDqMhQekphiZDE/uhKNi7rXhPQWj+/Cr0Ubzu7LmzwSyDXZ+zwGV2cyx6ojU2LWK/+3AmpKarLcQ0o9hkMc3ZnnHw/hh6uic6rs7cF10eIvxi6ZR2nJSB1ICCdQKntfmeoXeHycdEMmvsmP5VlrBDnV8P9+KRnN66BAWupMNAxuy8vRF2NORraMj5WGRw9/J+z3BRfnol7ix1VQq3mCiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKXNr/oe2wYvRQjWCId679VfS7TWHLak1NRImP25ofg=;
 b=vh64jZrv5W6by7FRLtUwQG4gmn1cg0DToeVmRMQ5DBQiOEolzEy95I+3O7JspnEfz/cX8Exa4WCYG73BAtdNXV0kvWVndgWDZEgHdQmYTZea80i4Ny72SE30UjhqpEl+XsGvi6UTC/7Uuhg/UvWtdSZh/b0pdK9IWt5jvMITGWEfV6T/1DqiwkwGK0z5J4YbZF5MB83bt1YxJRLd6+iQM4bYElhYNl3UTeaL4abtpJgPSomJIZOy49Q1+E7Qlc9NHZ1If77dVEz+l1lw+SCX2/ROH1XK8ImVzsiN4jkd7zTla/mXx1eu6lIcBaMMctlhvwKwjRj0a+P+bBWLDBHkNw==
Received: from SI1PR02CA0055.apcprd02.prod.outlook.com (2603:1096:4:1f5::16)
 by SEZPR04MB5897.apcprd04.prod.outlook.com (2603:1096:101:7d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Wed, 6 Sep
 2023 08:48:47 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::85) by SI1PR02CA0055.outlook.office365.com
 (2603:1096:4:1f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 08:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 08:48:47
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] hwmon: max31790: support to config PWM as TACH
Date:   Wed,  6 Sep 2023 16:48:35 +0800
Message-Id: <20230906084837.3043030-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SEZPR04MB5897:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88363c6c-2264-4478-03bd-08dbaeb615c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ush1z/y5wMsEsuBOCFDf9x/2gXj/a4P1Du4L56LiIXRxz2lyJFPM7yYj7ojzvzgiZ4TDLuRKGoLox1k1EuHa6weO75oW0xX52tYvbnRv607Hw+Ix7hk05RJhjb/1kMgKU6agH5HegtfkE3X/5ahaIDTuTUX30nFj44acCqXanU0ZdzxrPPlvefUE6Kp9QoupvS6goSlRuW/foXLeFT9n69ffFCrl4iARoowQx/1ZGXTHdasDHuR7d1/npfbvExkTau6sOYb22dPA1A+u3qDhffBcFHj+KLg+/apBRqyGrqHkHwUcJEZlxSjpryA3MwDJr4veLkIQaSFMtQqJhWFVINITOBmwtlw6GKZjO07/YkxIgu5rjwU7Y2eTqNXlM0xGeilrPqMX9Ky1xwRglcxIPClZrUrtKQLR6h3bwMu+x+gK1zJ0IRyguqkaWEEKdpG8b2dgQtmwYM/yqvVnNGp13jSfiklUxYNTFmQ7uA7rqBDya1Hpv8dpGjB0muZKvSmOVmUzvQSjyuYcJq5IEb3kXPfuoXBINUSp/bCjRbI4WELfXtDSJzAlBV0KTYvXjNfF2UwFszwBFspGKxACZaZX1PmBN1pnUePv56hf4XEEOc+yZgTct0B6nupsdZIxWihQQ5lPadipBRCHlAw4Jn0Y8KrnLFxeH0q0fgoCrW08cM4cTiHRezkpP5fB9vRybxgD9vZWwJOXmlxOGQCWV6Pkg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(110136005)(36756003)(36736006)(86362001)(9316004)(70586007)(70206006)(316002)(2906002)(40480700001)(5660300002)(8936002)(4326008)(8676002)(41300700001)(47076005)(26005)(83380400001)(336012)(1076003)(956004)(2616005)(36860700001)(6486002)(6512007)(81166007)(356005)(82740400003)(478600001)(6506007)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:48:47.4124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88363c6c-2264-4478-03bd-08dbaeb615c2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5897
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

