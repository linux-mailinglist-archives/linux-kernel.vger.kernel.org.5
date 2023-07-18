Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903C67579A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGRKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGRKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:52:48 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBCA10CC;
        Tue, 18 Jul 2023 03:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3FKNjjMMf76j56MtJmfjUnrl0fApsniedWKVU8Jw+IhJ+BV3r/Q1xmfwnnalS6Aos/JpIrfV62AFQXuMVFIx/pIdBO2onzHPj+XOW352U8MpwOjhJAjDrqq8kRMPfEoP9uDo4FVOiYSxWiyIpP5iNP9ab9Xk4ydseEpval+Kmhz9AZiTnqURmnnDf6mjS5YebrQgk8oXB1rmSpq+N6v+3J43ZcMDpVM0zsLFxcC1ALp8EQlZG+cBCCfrsXoFQS+fmYSvxO+Ffgun+5BXdi75rIz+HubpxZDq7FFq+lD2LvfGSQj9+MNb5h13nlkFn/jcyUJ+tObc4SkyG//VOLDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbqd7mikiY5neqLMrVO1SnH15YqBHVnwxGaJbmU2p4E=;
 b=hpDGMAae+WwyHkJ4BXBOZ4SH52hWqkX3dobz1kBb3lHD1UF9kaq9BDCZ6hPyA0Hxqq/g+fZWyBbPMXWDi9tc8LNjijjpSFekUs9Tjq/YCwrx0dykUueg8S0HXmcWCjA8vZ/gSG11eq8hiTtanqdWk5Zluw1UWzfkctKqdNua2kmtvxGR04R/Y/hy86uPYcNnZ8OxRuQRmVMWAPH36TBPRs5vOCgCdA3uAJDLlnWPvTw8LOCwIZqsSIaAUcLjUg8m+5PewArI83bfo22AdXxQWh3Pe3OEhEaFCo938/Wgep1yM3vTfuPCdH54IBZXNzf1qQ+Op3HpOwnNVip3QcsbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbqd7mikiY5neqLMrVO1SnH15YqBHVnwxGaJbmU2p4E=;
 b=rtyJlcKmI4CfoN05jJVu69w0MPaaZuyWklRGzaP38uK+I0xQUoXzDCOVrZlwJCIt1+ryVWXSY56Uru5EkeK5Lj4+/El1iSDVD23ux/qg0QVCS6abqWe+5nuVsvzBE7aD7CBAtP/lCRmALD8tDe9aAdvgAWOSEDgAkUlu79oLMRJE9Tdrx5USFESP1py3WWjrMfroW69LR7lf8YwTHOWM2dv1bmL4iVzFrg+9B1JvYcFdk50bggAj6ihW3BP8puAIzSdbj4p6n0l/SEeEe/NkiAy6tpclxt5hv1A+mBHHNzlffuEI1B6vw4jhcWto7ex99xuIv6AVlrrTVOBPmFTkIw==
Received: from OS6P279CA0076.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3e::20)
 by VI1PR10MB3710.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 10:52:34 +0000
Received: from HE1EUR01FT078.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3e:cafe::94) by OS6P279CA0076.outlook.office365.com
 (2603:10a6:e10:3e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 10:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT078.mail.protection.outlook.com (10.152.0.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Tue, 18 Jul 2023 10:52:33 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 12:52:33 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.216) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 18 Jul 2023 12:52:33 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 3/3] platform/x86: Move all simatic ipc drivers to the subdirectory siemens
Date:   Tue, 18 Jul 2023 12:52:13 +0200
Message-ID: <20230718105213.1275-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718105213.1275-1-henning.schild@siemens.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.216]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT078:EE_|VI1PR10MB3710:EE_
X-MS-Office365-Filtering-Correlation-Id: eb09c713-5fc2-4316-5410-08db877d1795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQsVAQfP6DUoYfvvkBFdK0fmvcRqAq25wJdIjA/EdydlBQKHgIYHGOG5ahmc60MWrZq1zOcv29X1bCtu6XO7Yqs9vvd0W2MWLHTDR9sX20+GnfXUn0hjAqSuIf1W+vM5O6A8NGGsxw+xrvmkHgUcblGzeNwiWNp9FS3+dYOvFt7Ydv6wd24h92DucOJ2p4TP1XbgtyIE10p/ofXraG4KfhXRFlwB1P/82rk1tr3YVAgrEOGnPKGLPSacZLsBSJgNm0X/ttPpsGUj2/YQdlH/4cymQV7oIDBPU6vlafmOSJUKcbQSaDPxMrX5qIBmLQQcCafAfbHOw4u/d4WwA0V7NlUp0GZrnnH7JhCk3BJqtJRnVj9MuBrk7l8m+HTv+oT1qT70qqxCvt57o8qhqUzXAifzjmrgSGy52QgAH1x4sV2REUP+C1m77BWm6ZnYJBe0PIvXKWkBinb8gnQRYGZw2V0dBDh6tnVLLw0teu7YenTJFqMRuqDq1Kb7vvLwg+S9fCmRudGL601rgc023FGca2cDI9n9ZYQyIVNF096HDxK+FI4SBY95U2W8LHtovs7HTNnztDrzvQKbEYROLMgt4kCKiBq5V22s50A8EHaHIjWNaKv/IZW3AvnMWDLZj4TVGAmcDxvpI2JgNZph6iqvhNPNd3IP3kIqw3l6tkk8cS4uetQJQ8Fiq7a9fEbItlp5+SCWtgbTIa+lNo5x2quBiXTlMmJWl9YXOtaXwO2hGG8+6HGTYmGe4vB8TOBCTL0HGnJksmAV2BrVWIzueMailA==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(54906003)(6666004)(478600001)(110136005)(82740400003)(36860700001)(956004)(83380400001)(47076005)(2616005)(40460700003)(86362001)(40480700001)(30864003)(70586007)(2906002)(44832011)(186003)(16526019)(336012)(1076003)(26005)(107886003)(7596003)(356005)(82960400001)(7636003)(70206006)(41300700001)(4326008)(316002)(7416002)(36756003)(8676002)(5660300002)(8936002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:52:33.8287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb09c713-5fc2-4316-5410-08db877d1795
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT078.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3710
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users without a Siemens Simatic IPC will not care about any of these
drivers. Users who do care can enable the submenu and all drivers behind
it will be enabled.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/Kconfig                  | 59 +-------------
 drivers/platform/x86/Makefile                 |  6 +-
 drivers/platform/x86/siemens/Kconfig          | 77 +++++++++++++++++++
 drivers/platform/x86/siemens/Makefile         | 11 +++
 .../simatic-ipc-batt-apollolake.c             |  0
 .../simatic-ipc-batt-elkhartlake.c            |  0
 .../{ => siemens}/simatic-ipc-batt-f7188x.c   |  0
 .../x86/{ => siemens}/simatic-ipc-batt.c      |  0
 .../x86/{ => siemens}/simatic-ipc-batt.h      |  0
 .../platform/x86/{ => siemens}/simatic-ipc.c  |  0
 10 files changed, 90 insertions(+), 63 deletions(-)
 create mode 100644 drivers/platform/x86/siemens/Kconfig
 create mode 100644 drivers/platform/x86/siemens/Makefile
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt-apollolake.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt-elkhartlake.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt-f7188x.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt.h (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 487d3d8f4da9..f5fcb1ca1b63 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1074,64 +1074,7 @@ config INTEL_SCU_IPC_UTIL
 	  low level access for debug work and updating the firmware. Say
 	  N unless you will be doing this on an Intel MID platform.
 
-config SIEMENS_SIMATIC_IPC
-	tristate "Siemens Simatic IPC Class driver"
-	help
-	  This Simatic IPC class driver is the central of several drivers. It
-	  is mainly used for system identification, after which drivers in other
-	  classes will take care of driving specifics of those machines.
-	  i.e. LEDs and watchdog.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc.
-
-config SIEMENS_SIMATIC_IPC_BATT
-	tristate "CMOS battery driver for Siemens Simatic IPCs"
-	depends on HWMON
-	depends on SIEMENS_SIMATIC_IPC
-	default SIEMENS_SIMATIC_IPC
-	help
-	  This option enables support for monitoring the voltage of the CMOS
-	  batteries of several Industrial PCs from Siemens.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc-batt.
-
-config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
-	tristate "CMOS Battery monitoring for Simatic IPCs based on Apollo Lake GPIO"
-	depends on PINCTRL_BROXTON
-	depends on SIEMENS_SIMATIC_IPC_BATT
-	default SIEMENS_SIMATIC_IPC_BATT
-	help
-	  This option enables CMOS battery monitoring for Simatic Industrial PCs
-	  from Siemens based on Apollo Lake GPIO.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc-batt-apollolake.
-
-config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
-	tristate "CMOS Battery monitoring for Simatic IPCs based on Elkhart Lake GPIO"
-	depends on PINCTRL_ELKHARTLAKE
-	depends on SIEMENS_SIMATIC_IPC_BATT
-	default SIEMENS_SIMATIC_IPC_BATT
-	help
-	  This option enables CMOS battery monitoring for Simatic Industrial PCs
-	  from Siemens based on Elkhart Lake GPIO.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc-batt-elkhartlake.
-
-config SIEMENS_SIMATIC_IPC_BATT_F7188X
-	tristate "CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO"
-	depends on GPIO_F7188X
-	depends on SIEMENS_SIMATIC_IPC_BATT
-	default SIEMENS_SIMATIC_IPC_BATT
-	help
-	  This option enables CMOS battery monitoring for Simatic Industrial PCs
-	  from Siemens based on Nuvoton GPIO.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc-batt-elkhartlake.
+source "drivers/platform/x86/siemens/Kconfig"
 
 config WINMATE_FM07_KEYS
 	tristate "Winmate FM07/FM07P front-panel keys driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 522da0d1584d..f3bf4b90b878 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -131,11 +131,7 @@ obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
 obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
 
 # Siemens Simatic Industrial PCs
-obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+= simatic-ipc.o
-obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)			+= simatic-ipc-batt.o
-obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+= simatic-ipc-batt-apollolake.o
-obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+= simatic-ipc-batt-elkhartlake.o
-obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+= simatic-ipc-batt-f7188x.o
+obj-$(CONFIG_X86_PLATFORM_DRIVERS_SIEMENS)		+= siemens/
 
 # Winmate
 obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
diff --git a/drivers/platform/x86/siemens/Kconfig b/drivers/platform/x86/siemens/Kconfig
new file mode 100644
index 000000000000..64479f83698c
--- /dev/null
+++ b/drivers/platform/x86/siemens/Kconfig
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Siemens X86 Platform Specific Drivers
+#
+
+menuconfig X86_PLATFORM_DRIVERS_SIEMENS
+	bool "Siemens X86 Platform Specific Device Drivers"
+	help
+	  Say Y here to get to see options for device drivers for various
+	  Siemens x86 platforms, mainly Simatic Industrial PCs.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if X86_PLATFORM_DRIVERS_SIEMENS
+
+config SIEMENS_SIMATIC_IPC
+	tristate "Siemens Simatic IPC Class driver"
+	default m
+	help
+	  This Simatic IPC class driver is the central of several drivers. It
+	  is mainly used for system identification, after which drivers in other
+	  classes will take care of driving specifics of those machines.
+	  i.e. LEDs and watchdog.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc.
+
+config SIEMENS_SIMATIC_IPC_BATT
+	tristate "CMOS battery driver for Siemens Simatic IPCs"
+	depends on HWMON
+	depends on SIEMENS_SIMATIC_IPC
+	default SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for monitoring the voltage of the CMOS
+	  batteries of several Industrial PCs from Siemens.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt.
+
+config SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE
+	tristate "CMOS Battery monitoring for Simatic IPCs based on Apollo Lake GPIO"
+	depends on PINCTRL_BROXTON
+	depends on SIEMENS_SIMATIC_IPC_BATT
+	default SIEMENS_SIMATIC_IPC_BATT
+	help
+	  This option enables CMOS battery monitoring for Simatic Industrial PCs
+	  from Siemens based on Apollo Lake GPIO.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt-apollolake.
+
+config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
+	tristate "CMOS Battery monitoring for Simatic IPCs based on Elkhart Lake GPIO"
+	depends on PINCTRL_ELKHARTLAKE
+	depends on SIEMENS_SIMATIC_IPC_BATT
+	default SIEMENS_SIMATIC_IPC_BATT
+	help
+	  This option enables CMOS battery monitoring for Simatic Industrial PCs
+	  from Siemens based on Elkhart Lake GPIO.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt-elkhartlake.
+
+config SIEMENS_SIMATIC_IPC_BATT_F7188X
+	tristate "CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO"
+	depends on GPIO_F7188X
+	depends on SIEMENS_SIMATIC_IPC_BATT
+	default SIEMENS_SIMATIC_IPC_BATT
+	help
+	  This option enables CMOS battery monitoring for Simatic Industrial PCs
+	  from Siemens based on Nuvoton GPIO.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-batt-elkhartlake.
+
+endif # X86_PLATFORM_DRIVERS_SIEMENS
diff --git a/drivers/platform/x86/siemens/Makefile b/drivers/platform/x86/siemens/Makefile
new file mode 100644
index 000000000000..2b384b4cb8ba
--- /dev/null
+++ b/drivers/platform/x86/siemens/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/siemens
+# Siemens x86 Platform-Specific Drivers
+#
+
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC)			+= simatic-ipc.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT)			+= simatic-ipc-batt.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE)	+= simatic-ipc-batt-apollolake.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE)	+= simatic-ipc-batt-elkhartlake.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_BATT_F7188X)		+= simatic-ipc-batt-f7188x.o
diff --git a/drivers/platform/x86/simatic-ipc-batt-apollolake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
similarity index 100%
rename from drivers/platform/x86/simatic-ipc-batt-apollolake.c
rename to drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
diff --git a/drivers/platform/x86/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
similarity index 100%
rename from drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
rename to drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
diff --git a/drivers/platform/x86/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
similarity index 100%
rename from drivers/platform/x86/simatic-ipc-batt-f7188x.c
rename to drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
diff --git a/drivers/platform/x86/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
similarity index 100%
rename from drivers/platform/x86/simatic-ipc-batt.c
rename to drivers/platform/x86/siemens/simatic-ipc-batt.c
diff --git a/drivers/platform/x86/simatic-ipc-batt.h b/drivers/platform/x86/siemens/simatic-ipc-batt.h
similarity index 100%
rename from drivers/platform/x86/simatic-ipc-batt.h
rename to drivers/platform/x86/siemens/simatic-ipc-batt.h
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
similarity index 100%
rename from drivers/platform/x86/simatic-ipc.c
rename to drivers/platform/x86/siemens/simatic-ipc.c
-- 
2.41.0

