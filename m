Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860397DEEA1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbjKBJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKBJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:08:22 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4FFB;
        Thu,  2 Nov 2023 02:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mANoDT9nhOa1NRPIn0dpXElM9NT5vEGmrepLqU7lqnukGcDjzRrKk397CdxJiE5tjf9gSRGdzqvEQg4D+jt0c7nXnRD0P8SmXb5JoPO895wN1ZhUP66F/BdoMQKk0PLZY23gVReoky/1Oak04v6C+F1f/G4Tw65/T1jF79FPzPm+R78kWLhSXbaTLz7eHFcV3Hq37OLtOm/GYavaj2k4ilA9CC3KFxJcyPO8P53fvGzCMyRuR9jtf8LB3LRrKK68tNJeC9nosX+mmZVZdObKGyD8meDpLJXtCiSFHGcs2b7q/j5XaSlSCE91aAaCnpe03y6rtmnfXqnu4JGW1z7nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUJcYDCVknvzYwDKUZDEHnOL555F9nvKpNDh6OS23kw=;
 b=B84Smy5V7ZwDmYKZaqF69bPRRPMNqtINiftWgB6Mp9xu8V6ApM7LlpU4Z6hY7BsSWzbzxPqq5g9ydGC9SYNUZQ29J3/4kWORWRXqrwv0Tv6y+Ys6g97vfiyYBZiTYh01cNHt0rgMFQG4JvLJQ7LgfpgDJH8hXgb2Vy1QbB3xWRQAQjSMyzOjDse/iaFAtiblWX3sG5UtnvyLAYPa4QTllbMwH7TKpBI+VF7Fl+y+tebnJbeit78gZmIY9rNcVVOf+vGymSD95E3x/xvtvvXK5rzsthXb5vJOQytlm1ipw2oYxtUQENNILpJWhR/VMZvOSISzFiBROdd45nSk5bkvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUJcYDCVknvzYwDKUZDEHnOL555F9nvKpNDh6OS23kw=;
 b=WoBOD5u9zD4oO5l77Q32vzJgDBXpduMxpd2fQLlSeI6TQXRnUIAMXXxbeDPyT6bspooJt9Njf/MZFtYCSr14KyccHgJxY79kDWed1u52qvVmuoD4n5/U15/ZJQPSLfQLe+sDsGe+j+sXmhxhvMRucjXAmUNZcOnplndMgS5PkH9uQ+8fxU3fXEyoIYNUKN9uo4YNyBF5QAo972h1h8MFhqZ0/lv7/Dn21OCImtUCY2xyaYfDBIdikkInjWEfDWUEUyh+EiUXlYSk7l5npqefkSBbroYwaJ9ftai992MGSs1n4LT6gJbHiIhiZ3Zo0zifjfHfTdyNk1E+UEmWGe2jkA==
Received: from PS2PR02CA0011.apcprd02.prod.outlook.com (2603:1096:300:41::23)
 by PSAPR04MB4358.apcprd04.prod.outlook.com (2603:1096:301:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 09:08:10 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:41:cafe::d6) by PS2PR02CA0011.outlook.office365.com
 (2603:1096:300:41::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 09:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.6838.22 via Frontend Transport; Thu, 2 Nov 2023 09:08:09
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: emc1403: Add support for EMC1442
Date:   Thu,  2 Nov 2023 17:08:07 +0800
Message-Id: <20231102090808.427351-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|PSAPR04MB4358:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d547c16-8b40-4a3d-bb18-08dbdb833c0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyDY/cmX68pmPY8db/KgjHvCEB4cLJ+buiSAzjEXNz4KP8Up13svr4KA+GUtbL5y6svzebAJWuK1s/7urBXoMsGgFt4I+2hsIOQ+DX9uBvGyIwhfvd+iEeZmKlvRcU4dHYNSxc3TEkpjBoINw3kWZMteEOGxjEt93sOW+dCHHRiKOKYUfXgqxiUs1+nWpM4Ho2QfYgb6Bim3Q4A3eGTybuhzwyGxKFa5AZdZVXSCAFxEQc7ZwUWTq/ZFUgz5i6v8WDRbEG9l+AA/gSwQ7rt5U9GgOM2OYeae5oKdYKE1e3TqnaqAmxKjgJlAWCaESx+EjxTN5jJ39VIhZv+VNgv3Uj0AISekWxy0nOVGTL7FxI4TSWOe+JksxAnAVq5SSNl0TOdOGzWbPS6gBkdG9TyZqNDZSEQC9Mk++Y8Ghb2Wfc+VIEGgUypPX3blsCdWPObo6IOjKA1Xu0zXaTnEOvbhY7aCW0kjm8LF1U58in3xsCyrfnod8PayB5xja4bWxEZZg2+4510hOL/N9kAB5bP5l6Qqg/k6FqpBdOREFvM3xQv/ZgsLaK00TPpVgF9iyDSbhSmIXT5mv7/OGvmZTbkfd5Wvg+lvdAdY4cd2HgIeINXsdLnb2Z1fgeJTJQ1tI2E97bbk+Nt78cecQ4+aycSIpkm/+Y7uFhsoj5tNdrNDRIu2IPMoG/Fu5RttQtVzhIrR/55aeTo5DDdS9xRlzJx/fw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(376002)(346002)(136003)(39850400004)(451199024)(1800799009)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40480700001)(6506007)(9316004)(356005)(36860700001)(81166007)(47076005)(83380400001)(6512007)(82740400003)(2616005)(336012)(956004)(41300700001)(86362001)(2906002)(36756003)(4326008)(8936002)(26005)(8676002)(5660300002)(36736006)(54906003)(6916009)(316002)(70206006)(70586007)(1076003)(478600001)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:08:09.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d547c16-8b40-4a3d-bb18-08dbdb833c0d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for EMC1442 which is compatible with EMC1403.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
change in v2:
Revised emc1403 to emc1402
---
 drivers/hwmon/emc1403.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index bb7c859e799d..1332e4ac078c 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -346,6 +346,9 @@ static int emc1403_detect(struct i2c_client *client,
 	case 0x27:
 		strscpy(info->type, "emc1424", I2C_NAME_SIZE);
 		break;
+	case 0x60:
+		strscpy(info->type, "emc1442", I2C_NAME_SIZE);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -430,7 +433,7 @@ static int emc1403_probe(struct i2c_client *client)
 }
 
 static const unsigned short emc1403_address_list[] = {
-	0x18, 0x1c, 0x29, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
+	0x18, 0x1c, 0x29, 0x3c, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
 };
 
 /* Last digit of chip name indicates number of channels */
@@ -444,6 +447,7 @@ static const struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1422", emc1402 },
 	{ "emc1423", emc1403 },
 	{ "emc1424", emc1404 },
+	{ "emc1442", emc1402 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
-- 
2.25.1

