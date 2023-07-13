Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA43875208F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjGML5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGML5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:57:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3382D45;
        Thu, 13 Jul 2023 04:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoGmlS89Vg22ymG3LjMffRUhwgDvg0FblKwEiJXkkflYTuxehbGX9PbssdXRjH+Q80RZZVOx57TM4ULnttkPI/G7Z/2A38ivFS3cdjrGMKrC+vUKCoJsP3IDFiuWP/qpVtgZH+0+I+42GSyABqfUPHNtmnEsQDjejUDRRwpG3nKBPS7CRLxNVPqWv3a8oT6TVWs5XrfjLWjUOysB2Qb6XBw6HomQJLrREaJ5mT6XiavzWGeCbuOpa8N3+WOQ4Fy55nVHpwqwh9qm85lMNt2KZ+BLYbx/oLVaTrRTc7sVCBGQOxDn1VPmEuep5o+g3Vz0+Z+loAnes+JnrlG+85DD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZQ5qw8oWe1omtboaaJ0IoawZ4rWhOCXLWyyq1bZm48=;
 b=V5tMFzY9Ctood3T2Rz3cdPXqeyt09YsWqB8GdPq2E4LvlbBv7J2VbB9YJ3fZAtbiyGEZDkWrbzq5GLNmgdI6jAuzC7lLPRH89BQ2W6euvLUD798eg00YHkcMgGWnl9TMwtq0sVRhbBpJ+c2kvELvO24h9m+x+VOnofeflKVod8iqQEhLGFk1hcbuajY8KzHjx9zVtUfE/WvkcaTnLFo8MXEUHwKrH7hM1n1oUT8E5jgxJ19PZOwOsTD4eHclRas211ZzTQxJPXeRMiVz5YaXJ4Ovy4VjiT50genWGyzzoPEqSeBJQS+t9O0wJQMi/SVHWzvD/Fg9oBrKzFQxRNt9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZQ5qw8oWe1omtboaaJ0IoawZ4rWhOCXLWyyq1bZm48=;
 b=nzXGuN+ITqDqhJprk+I4NFieLsf+3vwPMhvXf83SSUoUoI9KyoMz4O/Yn1xSHDrwxkuOvDHbFd5Rd8idR/Hq3SxzK3G6XK6sFRywLh6XO8KNvEvk7ATTV8EA6v+XfZDQkPhq742b32hwA7sa18PALtxHaYLpXWNku5tJvU30zSY1fpyH4THZFgqzm6PciiGOVRfQrzkEfrilk3kZca8CrZZHL4tO32F4Xhpib4sekzyfiJwSRPl9VBUjqolyJVGZjO3iZhYgYZDkft47D3Q9+lnSciQVVn1D+Yk+mKO3m1xlJhEMq6vPGcbrxCDjm6Inxvp+L1awq3VFu4WGIrUx6g==
Received: from DU2PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:10:234::28)
 by PR3PR10MB4014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 11:56:52 +0000
Received: from DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::77) by DU2PR04CA0053.outlook.office365.com
 (2603:10a6:10:234::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Thu, 13 Jul 2023 11:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT053.mail.protection.outlook.com (10.152.5.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 11:56:51 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 13:56:51 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 13:56:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong . wu" <xingtong.wu@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 1/2] platform/x86: simatic-ipc: add another model BX-21A
Date:   Thu, 13 Jul 2023 13:56:38 +0200
Message-ID: <20230713115639.16419-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713115639.16419-1-henning.schild@siemens.com>
References: <20230713115639.16419-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT053:EE_|PR3PR10MB4014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f013ea9-dcb2-4b92-6941-08db83983edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzOFNRrt1GdaUspwNPb6jKeEgSMx5iQVRVtcSPnL8iOj3E6e7+n+l9jOc6JOtteVjzH8RVuh8ikwtm7WNPu/yfEjz1E3GW/5+ykjWU13rDzQbOaVpI5EOCI9mZDIO9g95TeuGmc97QMW2t1K9rCS9NCk8eeOGA2JRD477u8uEcgbWNnDRWb9neKd0kUP6lwlYZYhaKmLq1v8Z/+9MW2RBmNJY3s9ASqSNlWJRm1kZcwpyM49JngqduRHNqv9TipJWEzRF79aOXpMmypc8iAlrALmZV1214OwNyP+KxQC0ZtS9pxuhUVO1rSzAhqIIThm3p7LmVk27W8ppVzTeCe4tiW2vCkf0l34+Wn9tnrOk8LO2VdAZDJPcraYxKf9LNyWzVVQHzKIcJVN2qT0L5BJrKEvVsHqWp59CKV675JPIHSLzOWpLw7f/Xonq7YA2vPEisPS0p3FK0/F2dUrCziphz2P4LuAu5sq3pcsH1F6k36f7Ti8dc3sETC0u1A0q5POufn73z/7CDCn/O95ggozEGS/y1XiSAiYItFjxXECsadtfrfU1aO6s4131nJ76VPeSPA0ZBSStCzikmK6vchP8BeC1m+KgsD10xw310HfyyrLEeQF/YlBpB5I5CnUbOEWQSJo/O7X9mHUAbCi5Fnb+gT+ODRkYq3Igc6jvH5Bt7KomRm9q1O1EAUBZIqMaKPt809Ug8OJ/mHQABRhIx6RLYe5Dhm18c+r44ZptzYmGzfFsf5/d7Lj9tJLyw0DeEF6qdKvsfN6zOsxUBe9f9C02A==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(8936002)(8676002)(4326008)(41300700001)(316002)(2906002)(70586007)(70206006)(54906003)(110136005)(6666004)(1076003)(26005)(186003)(107886003)(16526019)(47076005)(83380400001)(336012)(956004)(2616005)(36756003)(36860700001)(86362001)(40480700001)(40460700003)(478600001)(82740400003)(356005)(82960400001)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:56:51.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f013ea9-dcb2-4b92-6941-08db83983edb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Siemens Simatic IPC model BX-21A. Actual
drivers for that model will be sent in separate patches.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c                 | 3 +++
 include/linux/platform_data/x86/simatic-ipc-base.h | 3 ++-
 include/linux/platform_data/x86/simatic-ipc.h      | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index c773995b230d..4402cd354104 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -48,6 +48,7 @@ static struct {
 	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
 	{SIMATIC_IPC_IPCBX_39A, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 	{SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G},
+	{SIMATIC_IPC_IPCBX_21A, SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE},
 };
 
 static int register_platform_devices(u32 station_id)
@@ -72,6 +73,8 @@ static int register_platform_devices(u32 station_id)
 			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
 		if (ledmode == SIMATIC_IPC_DEVICE_227G)
 			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
+		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
+			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
 			platform_device_register_data(NULL,
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 57d6a10dfc9e..68c455f5edad 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -2,7 +2,7 @@
 /*
  * Siemens SIMATIC IPC drivers
  *
- * Copyright (c) Siemens AG, 2018-2021
+ * Copyright (c) Siemens AG, 2018-2023
  *
  * Authors:
  *  Henning Schild <henning.schild@siemens.com>
@@ -20,6 +20,7 @@
 #define SIMATIC_IPC_DEVICE_127E 3
 #define SIMATIC_IPC_DEVICE_227E 4
 #define SIMATIC_IPC_DEVICE_227G 5
+#define SIMATIC_IPC_DEVICE_BX_21A 6
 
 struct simatic_ipc_platform {
 	u8	devmode;
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index a48bb5240977..1a8e4c1099e3 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -2,7 +2,7 @@
 /*
  * Siemens SIMATIC IPC drivers
  *
- * Copyright (c) Siemens AG, 2018-2021
+ * Copyright (c) Siemens AG, 2018-2023
  *
  * Authors:
  *  Henning Schild <henning.schild@siemens.com>
@@ -34,6 +34,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC227G = 0x00000F01,
 	SIMATIC_IPC_IPCBX_39A = 0x00001001,
 	SIMATIC_IPC_IPCPX_39A = 0x00001002,
+	SIMATIC_IPC_IPCBX_21A = 0x00001101,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.41.0

