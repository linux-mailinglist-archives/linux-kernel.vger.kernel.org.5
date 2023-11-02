Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5D7DEB63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348401AbjKBD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbjKBD3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:29:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7271120;
        Wed,  1 Nov 2023 20:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4jyK9OPDGNyvBffIxxrNkrOVzmMIA8+uWiPyZoSQXSOL4jSzazIr7DOZqDBAZYUICrJ6tY6iJN3N0heJ1Yq5ptQ8+AIfPPbNFMkcBTwwFrEcEfzUujZ+UolervugGGYeOokyQMoj9ewYkY83CzJ73hfM7G9a99awE6ghFp2JKqLf1OE2ZE7bipkaNa2XxjhJMAehctkYihOMQ3TocFk0yCib2TOrvvfL+WMdZ1pVm1tiDKAecM7Edr6kbEG3dx4mZsISecicjZ74uB/sP06FduAjRzcWtbM5OxTInw6xW2FP8+tWe/GAOQCseq3NNxuH6SPj9meaeH5kTq6mMixag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5A+YGxARtmjO8LaEC8NMjLhxNaKIJpF8nCOyDvjQDU=;
 b=MSzqU+WE5Mr+qBwjrGcJ3exx9f5keLhME9t9dKFUehwXzAMYW37c7AJ+WRgqq8DKUBAheBtB8fA0Z3NLzFsczUsUpyk4Lok05xyIjsPQk5uMZdqkwIn69YipG2fYSlHEkC9e49W33Xda9btVq5O4tj/KiTYcOta0FPFK+pu0yrONFbmq3c7jmemkrlqCdumWyg+h7NrMwzQx5JbREmcUmmJlsuxEbUuezRj1xo8eGKs7Xcl9F9R11BL3F7PHDj4+noqqdSYVROzuSSUGF27SqAHr53Lftlx82MvHigHyvahC+Uta44KmY+L0Q5UTDUPxjSZrqEIl43uEJxZfv4nxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5A+YGxARtmjO8LaEC8NMjLhxNaKIJpF8nCOyDvjQDU=;
 b=j/Kizps3EQQZgFpPz5BnREpxQcL8eQSkqiqQzrkImSvzWRmUPyCxtGKm0P8PxFwSTC9jCN+GQF4fkQFp5aOgQBzq7PBfcdVq8IlWqWosRnf77CQtBhJUIc27WNC12Ie31vapK6sUsNf0TuqH8HUTJtJdt8m0cffzOtscTcqOATR7DDi2zyl7MN+M72BuufPmKWfPxWmcyArVN+pC4deOauYFHYz68ygKvm9dXtz8FhXqr/AKyiPPArAD83n9TGj2og3iuOJWKmjaErAoQDenagP09DjiWuwGC/fSpuFAyvXEAzaM9I0MDMRY8UmYwD1F9b3b8i5MwtofnizhqaEX8Q==
Received: from SG2PR02CA0013.apcprd02.prod.outlook.com (2603:1096:3:17::25) by
 SEZPR04MB7529.apcprd04.prod.outlook.com (2603:1096:101:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 03:28:53 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::93) by SG2PR02CA0013.outlook.office365.com
 (2603:1096:3:17::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 03:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 03:28:52
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 3/3] hwmon: max31790: add fanN_enable for all fans
Date:   Thu,  2 Nov 2023 11:28:32 +0800
Message-Id: <20231102032834.3827289-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SEZPR04MB7529:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e7862ea2-64d8-41ff-9e03-08dbdb53d6db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fiSQejBDy+8c4cA+2WthpFHju5S2Dvy7otkpsbi8uWFp2Q33Ln8raC+dluw/h9/zbF8wDWviwCqcATSUA3V5VgQxIgmMw6Kkke+W6Ov7Wc/P58L88P/zuYzp2AjKVwktmF+G81DzVBwdC8zW8Gkt1F795rfvYHzBrIUi4O1ymkGICwit0I8njIhCxbsa9WFX+UNKWiqFY06tbVwHg+xKYI1LnBY3csQJxnogcSCCzOPq77bgtAnvuVD5VGdZsREb4Q+RRsuS+fnceSHlv+JhfrKnuNI5OerrcnI/kbsHnHy8IcbZ6F4cHaD6WzSmzedp+/r8xMKZj3HcERoCju74WKaJ4bR7JewEk3bc3oF74mx5FqNz/qTzzQ3lj7T6xWLyOdIXxuG///7qMmC5u2RRGLPpmNgjpMXGXr47VBtY8VuEYqXKBdl3O0mBIS4IxecweuaRH2kC/5g9o14MrQr1MT4zVA0jTRwBj5W5WAilg9Ni+pcTYiHaOp+5v6twEhFRiwdEE2xUty+7xXva96WAj5Sq23pOCEdPDRWtQGDoj01PEJZsK0cbMTDxQmF66uwNtGpWmpVHhD0DavGwQH4cCz9cuSqlSO8rWidEZWQZRa7WE3LI8QOH3JqHe4lnXvbRWPpjlu18NOBkTF6raKMsTVvh+L5KQgU/jQT/DvxAMq5YKa6kkXvW+3dHpCOXWfrsOUHBZXy7FGytCTv7qIL3g==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(54906003)(110136005)(70586007)(70206006)(316002)(36736006)(336012)(6506007)(478600001)(82740400003)(1076003)(6666004)(2616005)(4326008)(26005)(956004)(40480700001)(7049001)(8936002)(83380400001)(8676002)(6486002)(6512007)(5660300002)(36756003)(47076005)(2906002)(7416002)(9316004)(81166007)(356005)(41300700001)(36860700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 03:28:52.9667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7862ea2-64d8-41ff-9e03-08dbdb53d6db
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7529
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fanN_enable will be set in dbus-sensors service according to the
index of TACH that filled in the configuration of entity-manager.
Add fanN_enable for all fans to prevent dbus-sensors service
couldn't find the corresponding fanN_enable for fanN_input.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v4 - Add fanN_enable for all fans.
---
 Documentation/hwmon/max31790.rst |  2 +-
 drivers/hwmon/max31790.c         | 57 +++++++++++++++++---------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 33c5c7330efc..510d5691b18b 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -38,7 +38,7 @@ Sysfs entries
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-6]_target    RW  desired fan speed in RPM
-fan[1-6]_enable    RW  enable or disable the tachometer input
+fan[1-12]_enable   RW  enable or disable the tachometer input
 pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
 pwm[1-6]           RW  read: current pwm duty cycle,
                        write: target pwm duty cycle (0-255)
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 378ff32c7c1e..fa31e108c7ce 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -203,7 +203,8 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		mutex_unlock(&data->update_lock);
 		return 0;
 	case hwmon_fan_enable:
-		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
+		*val = !!(data->fan_config[channel % NR_CHANNEL] &
+			  MAX31790_FAN_CFG_TACH_INPUT_EN);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -242,12 +243,12 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 
 		data->target_count[channel] = target_count << 5;
 
-		err = i2c_smbus_write_word_swapped(client,
-					MAX31790_REG_TARGET_COUNT(channel),
-					data->target_count[channel]);
+		err = i2c_smbus_write_word_swapped(
+			client, MAX31790_REG_TARGET_COUNT(channel),
+			data->target_count[channel]);
 		break;
 	case hwmon_fan_enable:
-		fan_config = data->fan_config[channel];
+		fan_config = data->fan_config[channel % NR_CHANNEL];
 		if (val == 0) {
 			fan_config &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
 		} else if (val == 1) {
@@ -256,11 +257,14 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 			err = -EINVAL;
 			break;
 		}
-		if (fan_config != data->fan_config[channel]) {
-			err = i2c_smbus_write_byte_data(client, MAX31790_REG_FAN_CONFIG(channel),
-							fan_config);
+		if (fan_config != data->fan_config[channel % NR_CHANNEL]) {
+			err = i2c_smbus_write_byte_data(
+				client,
+				MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL),
+				fan_config);
 			if (!err)
-				data->fan_config[channel] = fan_config;
+				data->fan_config[channel % NR_CHANNEL] =
+					fan_config;
 		}
 		break;
 	default:
@@ -291,7 +295,8 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 			return 0644;
 		return 0;
 	case hwmon_fan_enable:
-		if (channel < NR_CHANNEL)
+		if (channel < NR_CHANNEL ||
+		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
 		return 0;
 	default:
@@ -445,22 +450,22 @@ static umode_t max31790_is_visible(const void *data,
 	}
 }
 
-static const struct hwmon_channel_info * const max31790_info[] = {
-	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT),
-	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+static const struct hwmon_channel_info *const max31790_info[] = {
+	HWMON_CHANNEL_INFO(
+		fan,
+		HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_ENABLE,
+		HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_ENABLE),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-- 
2.25.1

