Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC427599E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGSPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjGSPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:35:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E619A1;
        Wed, 19 Jul 2023 08:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVB2Xh7fUZtC0SXpN5iDjjN8oRrArVk2ZfXCWDXTjDvP+SPAdHGwfnL6/hJElQvig7/YPBz481pSiPosp6EuwQZEN4DsTOKjbbC2CLE6iYvGGEPd4DvNN9ZMb3DjJYOgcvMQ/gfQaJvnZGvbhrLV5zN3GNraKoMjYBH5TRg3TPjIPC0mTi/u5sCB6xVnZO1PnjgwyPDbLBMD7aiH7VM8hPjJaHowEhwTCmrJiFvpuKY0ZgBSEBJAllpuQda7LV4PeM7EbXo0fYmEKGyGJfOYq6EbSzwj3TP8w+P4oN3MZCNgEkWhzwNgVtI3R3YmCrbr5wgHdEtd4B2oLtvb+XtP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqik8iP8FzEi/5kPGZ6HsYqSscAUByBvOaO9lCdnDR4=;
 b=FeSJjZrTYufdtvA0+HLXEJvd5XBL6PmKciR+LuVFmt6NNqd0iQg5sbT14nIv7GZD2jby/qUmZPar3zGOW9PlU1iyl9+DGOtW0zblZMjjZoBtX3MWQiTDsTzS3sTn5fxyNY2QVFmQSS9llsm44YNFqNpHbzbhy639BamT9WgfiEOl0Uh8poJMOMdtCA7Kwe2jfBvP2qw28Q0tj1vN+p1ET4yicKaTd+57Nffq6oXLnhQagEpOQ6HcF/KRWQMivGHjOvPC37iiGIZcMp4qT+6fpQEFt1UoRClUW2X19JqiYzILc9c0y2/bWqVlEP5uJCkWLIOrLkqpnAsswcoXSA43fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqik8iP8FzEi/5kPGZ6HsYqSscAUByBvOaO9lCdnDR4=;
 b=ZwsGPK7Johotb7m0DQKLc/9f029V6Yv25t+efu4NFhSxSg07n4eV2UvRBEGs4artWGkxgMkXOVUvhkl90ReHxlce42DQiAqe3RxAjFgY7Akg9jxVbO5JiHQh4AhGry92iNK89TIQxVafTMJiRf6sHmhdBqT9/kXt+qNx+zPcaZtizciKz5WuDPY3rENvjoyBUQvORE0QlB6q2ImizOAbByIINj1HJN6JmMk2X+Jn1tbI/wgBfkhG9h1j+YLF0p3FB+aCZSMYSFOU520MYFT8q/HvfeiIDiElgfvCCD74rG6veJK3E8noD9Nc8P1MY6hs1+lgBvu03wwgpS9/O5gnmg==
Received: from FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:ad::15)
 by DB8PR10MB3562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 15:35:42 +0000
Received: from VE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:ad:cafe::73) by FR0P281CA0206.outlook.office365.com
 (2603:10a6:d10:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 15:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT061.mail.protection.outlook.com (10.152.3.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24 via Frontend Transport; Wed, 19 Jul 2023 15:35:42 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Jul 2023 17:35:41 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.175) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Jul 2023 17:35:41 +0200
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
Subject: [PATCH v2 3/3] platform/x86: Move all simatic ipc drivers to the subdirectory siemens
Date:   Wed, 19 Jul 2023 17:35:18 +0200
Message-ID: <20230719153518.13073-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719153518.13073-1-henning.schild@siemens.com>
References: <20230719153518.13073-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.175]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT061:EE_|DB8PR10MB3562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7390170d-dd6b-418e-1294-08db886dcfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GK/8X9AMVefWEfZWnr62tvvz/lW5azShCsSR2GbwWZ9gFyMppVPdEvf/4YMc6w2PQNj9zKjuXxSihpG7WqWskYZMS3Lc8NAQl8QaUImmN7oCx46217zIzpMYCeB6IsCSntxG96gaHbSPWlMb0MCpJWeTK5rcTvyDRDl8lLXc63MXGMpthK92zsMKDBFS9QllqxY2CRdJZtmXhZxK31IwYcy9oI1URhIz+530xqluqkNjRQQvHltCXl+uvHb5crTeLfr73OjNs3uLClldqkfodYU/7OKUJJjB2yrZmHZYBke/+nx3voVUslL0HixP06ekaolsvk/2p6YkjcGjySGuGfsl0lvba4yOegn7lrJIkGc9JeDVjFC9ULClymVZKtrQi/IJIPcwlOYL+/2U1O9aX90844j0PScBP5wZKlxSwrf0RAOEwD2KLibArKMWffHIJVRuwhznEVfpOehP79bAFEKSp4BTkE3ofkYfYyzH0gkLvaENplgSGg5aiL7q69utEa/KmBWcJR2pGI6rmrP3zU/pNNOJhtyV2LL5dhhebbJPBqDqJqOBKlo+vsdbtUsFl92XGGiKMvP1zmTdn7IWCOGRfnGnF4ixdE8GnmqqtgmNFXWqaUJYJDGxzbTK9xJ4/bx7HZgYd01B8ViWm6AHWYPS5B6KDRwbeJ/8arqrix4czAefoMoBOTbTKCrcz8pFtIPe5yOPnoGxri1yMNGsbBGmY9EFJ9A7xTisD+x21/vgc5xBSzbBGMQ2llQMfwylIZYHbAKFDbUgfdxNvUcLsfnlPUZGlPQXlVr0e2o0bu4=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(5660300002)(44832011)(4326008)(7416002)(70206006)(70586007)(41300700001)(8676002)(40460700003)(8936002)(316002)(86362001)(36756003)(2906002)(40480700001)(6666004)(478600001)(82740400003)(186003)(336012)(16526019)(107886003)(1076003)(26005)(2616005)(956004)(110136005)(54906003)(36860700001)(356005)(81166007)(82960400001)(83380400001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:35:42.0020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7390170d-dd6b-418e-1294-08db886dcfb3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3562
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

With more files around move everything to a subdirectory. Users will
only see the several options once they enable the main one.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/Kconfig                  | 59 +----------------
 drivers/platform/x86/Makefile                 |  6 +-
 drivers/platform/x86/siemens/Kconfig          | 63 +++++++++++++++++++
 drivers/platform/x86/siemens/Makefile         | 11 ++++
 .../simatic-ipc-batt-apollolake.c             |  0
 .../simatic-ipc-batt-elkhartlake.c            |  0
 .../{ => siemens}/simatic-ipc-batt-f7188x.c   |  0
 .../x86/{ => siemens}/simatic-ipc-batt.c      |  0
 .../x86/{ => siemens}/simatic-ipc-batt.h      |  0
 .../platform/x86/{ => siemens}/simatic-ipc.c  |  0
 10 files changed, 76 insertions(+), 63 deletions(-)
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
index 522da0d1584d..d4a6c18d0dde 100644
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
+obj-y					+= siemens/
 
 # Winmate
 obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
diff --git a/drivers/platform/x86/siemens/Kconfig b/drivers/platform/x86/siemens/Kconfig
new file mode 100644
index 000000000000..8e78dc609a38
--- /dev/null
+++ b/drivers/platform/x86/siemens/Kconfig
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Siemens X86 Platform Specific Drivers
+#
+
+config SIEMENS_SIMATIC_IPC
+	tristate "Siemens Simatic IPC Class driver"
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

