Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60907DC8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjJaI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjJaI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:58:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB08C2;
        Tue, 31 Oct 2023 01:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFh+ZcLD8hfGnVP27l4iKO2u3Dn5wVQwNb8K+IOwdyXmwQIzPD+PV5ocvy9R58hJbJOG8lVK7zmdR10D1hggS6Sb4Y9W3TatL+SrxV6A8XlWV+9QwbmhOr1VWffW30zhhb6DBJh1JKeLxjPfadB1jd/DdOSp182vI7hufDJiisfZaNNur8+X8DFcx557vgpob7Nkj2ISCKJh1ty6n7XBGHQJ9IPdj1ZoebW9X7ZM20V/4OAaoXr4vJxnOPQQEemylBW8i+/YSlkhQqyomWL8mlCeZNyImEuqFk565sIQphlKkijtcYdhRE0TyYuLRxzDtb+5JKnc9DrP9omDpenkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5tZDsk9Y8+0YlwhhI/qyiE11J0X2fieajcZ84TAajw=;
 b=kF/mfUu5wOAmqloGE821PQyXNmnC10IAA4HB7pyps3ox2IuCk0pBVq+W6sSdFWCywkhEuBPkQXKwTE29jCVaCKxMM7wsJi7bksbHepj60C/DLCDC3aj8kkKt/c1EXFXfpTeeaEY33tFJ6VEhNx3M+J5aDrJiFcNYeBnFwBHbEAB784NZ70yen2376nRHnMgl8QvqDJkP1x3ZlLXRl6wrJaYTM9ozZaDQTmJDJG8J3hmAMNZwf9yumfZBuBKcoQEz4K1/x/aSOpxsYHdY1H6uL9Wka1wM2u3sJaNRb7LoIy4OzB+nPL89elkpGLf6NtDH9Ck5QxpsdSAiG0etKnOIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5tZDsk9Y8+0YlwhhI/qyiE11J0X2fieajcZ84TAajw=;
 b=edGw6k9rNKWqud3kb6Ihz7bPZm8iRrBc21zgnOxwIp4fb5YBZ6VyeTP7FaBCVfzvYdPxKXDjt66//9m16CmqqPZGBRz7wxv4flGvcEmTjxEMTpNhA3HKTXqFqIodqGtyrrUX4EeH3d8OG2695Yc2EOBoggW8oZOWGib+K23JL82EdenBl+AlGfRgbxae0eBUn3m4sVtSpXp74Y77RW4oeNp0Mdp4MxRDTlFlTXtQ3ckFbf76sBnC4ZNeFNCl+AFWUwN/Bcr4eKPXQjGi7kamINa7P4NFnQ57gJPUKUtRKPJg3oxJ07F2HeMe7gKKXaxkqniVFyeddBO80Yr7nYKLWg==
Received: from SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) by TYZPR04MB4477.apcprd04.prod.outlook.com
 (2603:1096:400:23::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Tue, 31 Oct
 2023 08:58:11 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::f2) by SI2PR01CA0043.outlook.office365.com
 (2603:1096:4:193::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 08:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023
 08:58:09 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Date:   Tue, 31 Oct 2023 16:58:06 +0800
Message-Id: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|TYZPR04MB4477:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a84f87bb-aff3-4d07-c8a2-08dbd9ef8184
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WAq7jZZnNzwXZj7W3CM0lTdZ69faCFIDXHJvu0cw1i9eDtJDdD65vLx2ATEpf057VZ4Q2U9YuOmPxKYwU+SAvLQkaNVGCV6WVI3rAxDORXhhnbte+AxOfGF83GxdFNj2Lmzz1GFTASlFk9nGQgNRxPkAm25vUeQPCdcqPKO5H+VZxDGStFQy85SpDsPn8PxUCUChxNwZofQhs0y2rZ6KW8XYUqlP4d1OtNIb/XSvn5vxS1l8O46Ao2txILqXx+OR+9BUYnW8eN3D3m9ChI7DPwoFV4iy7Vl7jy6NxGoH7rp1o1RpWhUH3a9GR/wsDEEkRItkV5FZB3kTk+/qQSU8aJ/xJvCO7cnHcor/3g1GNUsjMp7Q/ss+r9uvi+jA7RyzaH7lnt8BvedGUnujYFGm1FPJPqyHULwbS/wBfm7za8TI2HK9RmOPNa3gPGldthCUWrRn7npOqsl5L2gnl8OZdX0h2OeY7UDT/JznhwEJoebAdu/xQ6Mib0wHl6ZemdO4N6VelY7eTu54d5gH1eRwiINikosS1589WpQ54GlZg8Ec5yTHSxpC8ysOHZNbKKZq7u7coFe43+ezucrN4DeNW4SNlb7SyygSGoQ3lWK1nxuL2MZmxPBPwzBwY/zgo8C84Lfw6phhbnRGBQaGTR1nXwv440etpEb+xyqsIZi6uMvEvSYNqPhzLiKJxAhhxrOj9dg3RumLmWGjWcjVVHh5Q==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(346002)(396003)(39850400004)(136003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(6506007)(47076005)(2906002)(478600001)(6486002)(6666004)(6512007)(36860700001)(86362001)(36756003)(82740400003)(110136005)(40480700001)(356005)(81166007)(2616005)(956004)(1076003)(336012)(70586007)(26005)(5660300002)(316002)(36736006)(70206006)(41300700001)(8676002)(8936002)(83380400001)(4326008)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 08:58:09.2368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84f87bb-aff3-4d07-c8a2-08dbd9ef8184
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for EMC1442 which is compatible with EMC1403.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 drivers/hwmon/emc1403.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index bb7c859e799d..c0d2e96c5077 100644
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
+	{ "emc1442", emc1403 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
-- 
2.25.1

