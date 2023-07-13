Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D88752578
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGMOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjGMOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:48:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05972706;
        Thu, 13 Jul 2023 07:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9j3jWS8YLqw503+yVrt1yrDLCRo1+k2UxogsXEpAC7hXYyX893OWsdkVBxq9HrMUlSzK8vHlOPfKo8c4ly+9PGkp9ym+e+C4oKYXMbnifgjlm8vUj5Yx/aqHsmU9r0Oa9/RmgP1kvSNuRrx5ZSHqvPOrJfRas+EueBVxMu/YlFZOzFDnc7kCqSJi4DqHXjXDLrADUrOltL8ZS3AseaBfV3XwHD50lML6BYMH8z+AIOAGIeQlU//tDltborj39P1fiOv2GOx7P7Hu9Z/iTciXWWXkV1FS2hqmDmngVjGx2a5hp/8suh5rF+CTmXlg2r1w7zGkKPNO4hL5r4409X5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/HluFMKQS5ktWNZtfA2E12vdKIElvq4CU8Sq4UHZfU=;
 b=R0tAVMECDBOT+sKzQhi9lkEWhycCQV5H01XLJUq0aihY5mpS17/o6Zv37AJAN0reWwO0MirTIFmGNF378wI5m3BvaYjhINUUxnybVaHXcAU+Geda9NCKc945UGGfx7sSo813Q3oLPgst0HPOIp4yC3IigAGzzB5WVA4DYR091a/ASjXS38cOjU60RKqHnBE+eGKkUOiHKNwj8WNN1J2gUq2cDtVIfncfZeMrw7Sx6Ty0Fsel6/+BtHuDzxVVRhqZsfZ7FQc2amql7FLgSmaR7lMoHNZHdsMJ9e2kq/LFYRvqW1zZQAXF5O7BP6FlzUBUwDjZK7THgaa79Lj3TEgI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/HluFMKQS5ktWNZtfA2E12vdKIElvq4CU8Sq4UHZfU=;
 b=j+mgxFgyXfZW8OaCa7e1xdfvPaTL0Tb/+2J+uEgjUvLJ9Zv3uvsBKBFnkyOfDEIgLWpYHnMVD1YHzW5iQAeXj1aIkHgPmwaWyvmEkbg/xknBdeZxmtVJraH37fWjgui+0wE3tM4ccmJhwhv4hLkvLo25wspGXSqWzbSaRcODsvJlUvC4tTu1OUEXHicFjD4xHhDNEcrxL1zhTSmuuk9lFxUTkKJQ4vF3ZseHDpU8Go+IZ7hMxuaVIyQfz9zcrCCxZVqBAL132KuxB//iDTYWajILt52KMHRP1yIJiRzusysA+E2fM8hpjkmF6tBdyR6wi/mS0MgSJ+rJM0fjllFh3g==
Received: from FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a0::9) by
 AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 14:48:43 +0000
Received: from VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a0:cafe::a2) by FR3P281CA0166.outlook.office365.com
 (2603:10a6:d10:a0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.8 via Frontend
 Transport; Thu, 13 Jul 2023 14:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT073.mail.protection.outlook.com (10.152.3.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.25 via Frontend Transport; Thu, 13 Jul 2023 14:48:43 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 16:48:42 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 16:48:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 2/3] platform/x86: simatic-ipc: add auto-loading of hwmon modules
Date:   Thu, 13 Jul 2023 16:48:31 +0200
Message-ID: <20230713144832.26473-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713144832.26473-1-henning.schild@siemens.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT073:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: aa12dd2c-1a54-4f2c-9a32-08db83b0414a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65rRxKXf6wbe3b7W75NHYRko7Cr2yzOwcwOJDuRgwBmKI4oL6WsXWJbvanbCRaD4o38BwT47Fi/QYDL3QJe7yPq4VDZ0KxMr2dggKA7/3SrzOD7wzTiJb8Rn/KqUCMVQFk8fXxiYAgyzBakpOYIccwRvzq3gi/LXU6659Z83JKXp3GwxUsGpUJ93SYSxjLy9nXh2GKl2Y+5tVNriFcAoBqMltz1L9zgimjiMzKj6LAWP7BLPTsJ0mWqqwHMCmsmSoNbYpXBi5LXJQs6aPk3hPpojJVtLqWm4yAU5UnspYNtNJbM0jeD0eSZaJSc+dE8IBvn56JonkfcrLpcP0PLgOcWpumrPVMK0mbq2+7+GuEu5587fc9UNz3idq4UzRIWFEbe4fQ/g+GmHecJuKRx7U81R9Dfy2ys4nQ8eB8RUclc9lJ5z+xduD6llXYFMgsbDP1/rZ3IRX2V0trzykFA+Fs5CEL9LnSTKVxqN41ojJ368IKlAlRmhbST1b+CaGLxbVGJnxRmFrH0lSVevEyZS0fVtMCi/8dWMfzM6IbuDbf8rdWm1dpI3geUp3zd0uQ6qFHFckzyWz/zgXJoHV88Of8gu7xGDNTfrx66Pqg5q17ZfJxV+6jRZgGtveuSa0sYyCC9KnSrWS8kUK15dcQRYvzpsiM1TZtGj+LCkRim8Cz+G7ABmpIRkgYCgCh764apf8iSR7rncaIqi1zsFbmDDagfjwj83HoCEGMKRIJU8AG5pVbkO2MkN5Ukm8jt6B+MtzS2EmFgqhh7vzpyBdr/9Eg==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(66899021)(47076005)(36860700001)(41300700001)(70206006)(2616005)(956004)(83380400001)(40460700003)(2906002)(44832011)(5660300002)(336012)(186003)(36756003)(16526019)(81166007)(26005)(82960400001)(82740400003)(8936002)(8676002)(107886003)(1076003)(316002)(4326008)(40480700001)(70586007)(82310400005)(110136005)(86362001)(478600001)(356005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:48:43.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa12dd2c-1a54-4f2c-9a32-08db83b0414a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to know which hwmon modules to load one would have to usually
first probe from user-land i.e. with sensors-detect and create a config
for each machine. But here we know exactly what machines we are dealing
with, so we can request those howmon modules without user-mode detection
and config files.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c | 66 ++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 71487216d33f..46487b4e0016 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -2,7 +2,7 @@
 /*
  * Siemens SIMATIC IPC platform driver
  *
- * Copyright (c) Siemens AG, 2018-2021
+ * Copyright (c) Siemens AG, 2018-2023
  *
  * Authors:
  *  Henning Schild <henning.schild@siemens.com>
@@ -34,36 +34,51 @@ static const struct dmi_system_id simatic_ipc_whitelist[] = {
 
 static struct simatic_ipc_platform platform_data;
 
+#define SIMATIC_IPC_MAX_EXTRA_MODULES 1
+
 static struct {
 	u32 station_id;
 	u8 led_mode;
 	u8 wdt_mode;
 	u8 batt_mode;
+	char *extra_modules[SIMATIC_IPC_MAX_EXTRA_MODULES];
 } device_modes[] = {
 	{SIMATIC_IPC_IPC127E,
-		SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_127E},
+		SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_127E,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPC227D,
-		SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE},
+		SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPC227E,
-		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
+		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPC227G,
-		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
+		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G,
+		{ "nct6775" }},
 	{SIMATIC_IPC_IPC277G,
-		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G,
+		{ "nct6775" }},
 	{SIMATIC_IPC_IPC277E,
-		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPC427D,
-		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE},
+		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPC427E,
-		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
+		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPC477E,
-		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE,
+		{ "emc1403" }},
 	{SIMATIC_IPC_IPCBX_39A,
-		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A},
+		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A,
+		{ "nct6775" }},
 	{SIMATIC_IPC_IPCPX_39A,
-		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A},
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A,
+		{ "nct6775" }},
 	{SIMATIC_IPC_IPCBX_21A,
-		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A},
+		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A,
+		{ "emc1403" }},
 };
 
 static int register_platform_devices(u32 station_id)
@@ -153,6 +168,29 @@ static int register_platform_devices(u32 station_id)
 	return 0;
 }
 
+static void request_additional_modules(u32 station_id)
+{
+	char **extra_modules = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
+		if (device_modes[i].station_id == station_id) {
+			extra_modules = device_modes[i].extra_modules;
+			break;
+		}
+	}
+
+	if (!extra_modules)
+		return;
+
+	for (i = 0; i < SIMATIC_IPC_MAX_EXTRA_MODULES; i++) {
+		if (extra_modules[i])
+			request_module(extra_modules[i]);
+		else
+			break;
+	}
+}
+
 static int __init simatic_ipc_init_module(void)
 {
 	const struct dmi_system_id *match;
@@ -170,6 +208,8 @@ static int __init simatic_ipc_init_module(void)
 		return 0;
 	}
 
+	request_additional_modules(station_id);
+
 	return register_platform_devices(station_id);
 }
 
-- 
2.41.0

