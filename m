Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBC80BCCE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjLJTt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjLJTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:49:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103FF3;
        Sun, 10 Dec 2023 11:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEqDv4GSHINaPQWqpVN/Xr8u7bpgK9br5O0Wv5UKh44QqvP63VnSgyz0X5+ke00zN+L1uawZ/RBAnC/CaVHpUS5152uowJ2avlkiKrAH8XFYOqT0kWPqLAACM6DyM2qXZDGSeAgtORIxVcRBWGqMTcsfzFYYcmSJLA5OgaVh57g9CozpIWDYMBJtVaFTO9i8XWI52KVnyubMa5jkPtzSNj1n11T6F8Pv4ExzlXg3Z2B05nLYHupwofwK/xL7dvHOz7Kr3KO5YwtSEPW78ikkWiZglx1DV05vGO22sB0E9PXJndjoHDYx5hA3vWz+wWouefUQ7vkhY1y+4zeDHqTlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdahxbEZeybAVzRTRwEpUBXKwDFYniTJXWfYj35kfAY=;
 b=bqHp1tfJUXtvtfNKW51b2WhyoRIbddWvC1cUZxT6dSF5Oci4J4OfqZUQROyAXrXm0ewS6Evko0xOMoI4Awpq1bbpcftd2B27FPlf3RlJIWxUJt903+QM5/ITrnAfyhC6BrpdVxWoVXiibEORqogWCB8kWQHedE6uALB0kk4Tl0U4We4rMF3WupfPQ4yJsoR5P/Llfhi3PQKVzTW9OJGJjjargjfkEFMB5RSBPwtK+sAeUwkRuN6bLOMZA430nj/eqiqMS1xCKGjvFjBecNX6TNVJYYtLBnXQ55Dld94gBo3Z32LCR99ZJNKWdQqA69vmol+VPaSJzYo7L+ET/uPZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdahxbEZeybAVzRTRwEpUBXKwDFYniTJXWfYj35kfAY=;
 b=UH4jAN60fVudU1VNRizO4cN0Dhfwr0MzJUcJlnHu56rWYAaZ6Ge7WQLMELsoQhH3rAynRciFQeH1GPBUd0oWP4+lVms5nLHmFe67c+uc6ZSVOJ1d0JRFTyMBi4T/2oUZtWtMa415ZmdHZNrgybigF9VhhEZT6K5m6TtqKs5WG6s=
Received: from CY5PR15CA0240.namprd15.prod.outlook.com (2603:10b6:930:66::12)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 19:49:46 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::e4) by CY5PR15CA0240.outlook.office365.com
 (2603:10b6:930:66::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 19:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 19:49:45 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 13:49:44 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>,
        <william.roche@oracle.com>, <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Date:   Sun, 10 Dec 2023 13:49:30 -0600
Message-ID: <20231210194932.43992-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210194932.43992-1-yazen.ghannam@amd.com>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 330a81ef-66df-4e1a-aef5-08dbf9b9294d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yje5bTQHe4ZkPIi3X0a5RwZlZZHei0tYBg0QI3J9dwjhGYonj2WiXHaFdpuBNSXzY7Xi0EAYBwKj/SX8Y2J/auKAM+8wR9BestYwSN0nqGB5RDrrnk4m6qSuXYwCzE96nGiYYjUMLRSXjgfMK+M1kYbY+dOVnmSdJoay22Bw1/36MR+jPTN/m3zDMZJmlYDFM3K1ncVrYLyMppzN7/4PgxaZY9zvXpVIOvxei2p3Nzk6569NiCJKfc4eBJSRhEZsl+74NbW6gIwQWUAexKywa+k+2y0X6/mLlGaEuPtouIGa4HyrT8OFXnfwP7liYnAh58UpY4KvCafVrX/NesdtGE6x9DoHBQ0Ke2pQMfHzb4uvUyDB5COm0y2sQJx2ZK6eAA396+jeUAQZjyOXM/zhGaRIgdQAr0iOHwGnFfCZPPha4XKX6NTgVuAm9s7pZlWSXdtTtkoIe1Arumb2C7/1RjjVuF29l8OFh4i3yVFVLmVNY7n5xelHNFKEGSVREPC2CeqmO2qyeh4FXW5/uhP+CvFP0UQSXersc83TI2vyGVotmTXUUB4Ss9VwvRr55nLhB7n/CaWG1YNUKybZRKBNwcitIfsrP3Qwx8YwP+Z6+oUtdtohIxSeRAM9VwybPiV2WY5dU4N3MIlrWOUuCyV3EVzq/MQ8B2hdsBf2en53qPztM73qZm3dGE2erVQK8Hd2AsC4vN5nnFPGcETOutC4UnYBndWj+LxwBjke10qcvlWWn9oU3sOfaNlNO3P7OIGXHqdweJF6yxoxXGXNwRn+x0vaERxvWbklD51nvsm//SOjWsiokMxDRdNsuQA1+JjYIaZA8cKtj4WN2q0mfunP9UYmZ2KAth2dWnwmqXLMthBJnGAPggZTB0v0DfkjI1Xj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(26005)(16526019)(2616005)(336012)(426003)(7696005)(6666004)(36860700001)(83380400001)(47076005)(5660300002)(44832011)(30864003)(41300700001)(2906002)(4326008)(19627235002)(478600001)(966005)(8676002)(8936002)(70206006)(70586007)(316002)(6916009)(54906003)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001)(36900700001)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 19:49:45.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330a81ef-66df-4e1a-aef5-08dbf9b9294d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Zen-based systems report memory errors through Machine Check banks
representing Unified Memory Controllers (UMCs). The address value
reported for DRAM ECC errors is a "normalized address" that is relative
to the UMC. This normalized address must be converted to a system
physical address to be usable by the OS.

Support for this address translation was introduced to the MCA subsystem
with Zen1 systems. The code was later moved to the AMD64 EDAC module,
since this was the only user of the code at the time.

However, there are uses for this translation outside of EDAC. The system
physical address can be used in MCA for preemptive page offlining as done
in some MCA notifier functions. Also, this translation is needed as the
basis of similar functionality needed for some CXL configurations on AMD
systems.

Introduce a common address translation library that can be used for
multiple subsystems including MCA, EDAC, and CXL.

Include support for UMC normalized to system physical address
translation for current CPU systems.

The Data Fabric Indirect register access offsets and one of the register
fields were changed. Default to the current offsets and register field
definition. And fallback to the older values if running on a "legacy"
system.

Provide a built-in "stub" to facilitate loading and unloading of the
library module without affecting other modules or built-in code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20231005173526.42831-2-yazen.ghannam@amd.com

v2->v3:
* Remove "future work" list from commit message.
* Add "X86_64" Kconfig dependency.
* Remove code comment and update commit message for "legacy" DF indirect
  access changes.
* Move amd_atl.h to x86/asm.
* Remove "TODO" comments and code.
* Remove placeholder helper functions.
* Rework module dependencies using kref and function pointers.
* Remove extra line breaks in switch statements.
* Rework warnings.
* Various code formatting adjustments.

v1->v2:
* Move to drivers/ras.
* Provide inline helper to do "config reachable" check.

 MAINTAINERS                       |   7 +
 arch/x86/include/asm/amd_atl.h    |  18 +
 drivers/ras/Kconfig               |   1 +
 drivers/ras/Makefile              |   2 +
 drivers/ras/amd/atl/Kconfig       |  41 ++
 drivers/ras/amd/atl/Makefile      |  20 +
 drivers/ras/amd/atl/access.c      | 106 +++++
 drivers/ras/amd/atl/core.c        | 217 ++++++++++
 drivers/ras/amd/atl/dehash.c      | 446 ++++++++++++++++++++
 drivers/ras/amd/atl/denormalize.c | 616 ++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    | 312 ++++++++++++++
 drivers/ras/amd/atl/map.c         | 659 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/reg_fields.h  | 603 +++++++++++++++++++++++++++
 drivers/ras/amd/atl/stub.c        |  78 ++++
 drivers/ras/amd/atl/stub.h        |  34 ++
 drivers/ras/amd/atl/system.c      | 283 +++++++++++++
 drivers/ras/amd/atl/umc.c         |  45 ++
 17 files changed, 3488 insertions(+)
 create mode 100644 arch/x86/include/asm/amd_atl.h
 create mode 100644 drivers/ras/amd/atl/Kconfig
 create mode 100644 drivers/ras/amd/atl/Makefile
 create mode 100644 drivers/ras/amd/atl/access.c
 create mode 100644 drivers/ras/amd/atl/core.c
 create mode 100644 drivers/ras/amd/atl/dehash.c
 create mode 100644 drivers/ras/amd/atl/denormalize.c
 create mode 100644 drivers/ras/amd/atl/internal.h
 create mode 100644 drivers/ras/amd/atl/map.c
 create mode 100644 drivers/ras/amd/atl/reg_fields.h
 create mode 100644 drivers/ras/amd/atl/stub.c
 create mode 100644 drivers/ras/amd/atl/stub.h
 create mode 100644 drivers/ras/amd/atl/system.c
 create mode 100644 drivers/ras/amd/atl/umc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ceb4263ec140..b9b060917680 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -881,6 +881,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
 
+AMD ADDRESS TRANSLATION LIBRARY (ATL)
+M:	Yazen Ghannam <Yazen.Ghannam@amd.com>
+L:	linux-edac@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/amd-atl.h
+F:	drivers/ras/amd/atl/*
+
 AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
diff --git a/arch/x86/include/asm/amd_atl.h b/arch/x86/include/asm/amd_atl.h
new file mode 100644
index 000000000000..4a51db4e107a
--- /dev/null
+++ b/arch/x86/include/asm/amd_atl.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Address Translation Library
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#ifndef _AMD_ATL_H
+#define _AMD_ATL_H
+
+#include <uapi/asm/mce.h>
+
+int amd_convert_umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr);
+
+#endif /* _AMD_ATL_H */
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index c2a236f2e846..2e969f59c0ca 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -32,5 +32,6 @@ menuconfig RAS
 if RAS
 
 source "arch/x86/ras/Kconfig"
+source "drivers/ras/amd/atl/Kconfig"
 
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 6f0404f50107..3fac80f58005 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+
+obj-y			+= amd/atl/
diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
new file mode 100644
index 000000000000..fcff387faa33
--- /dev/null
+++ b/drivers/ras/amd/atl/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# AMD Address Translation Library Kconfig
+#
+# Copyright (c) 2023, Advanced Micro Devices, Inc.
+# All Rights Reserved.
+#
+# Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+
+config AMD_ATL
+	tristate "AMD Address Translation Library"
+	depends on AMD_NB
+	imply AMD_ATL_MOD
+	select AMD_ATL_STUB
+	default N
+	help
+	  This library includes support for implementation-specific
+	  address translation procedures needed for various error
+	  handling cases.
+
+	  Enable this option if using DRAM ECC on Zen-based systems
+	  and OS-based error handling.
+
+config AMD_ATL_MOD
+	tristate "AMD Address Translation Library module"
+	depends on X86_64
+	default N
+	help
+	  This option provides the module component of the AMD Address
+	  Translation Library. It will be selected automatically if
+	  building the library. Minimal dependencies are given to avoid
+	  build errors for modules using the library.
+
+config AMD_ATL_STUB
+	bool "AMD Address Translation Library stub"
+	default N
+	help
+	  This option provides minimal built-in code to support the
+	  AMD Address Translation Library module. It will be selected
+	  automatically if building the library. No dependencies are given
+	  to avoid build errors for modules using the library.
diff --git a/drivers/ras/amd/atl/Makefile b/drivers/ras/amd/atl/Makefile
new file mode 100644
index 000000000000..dc9fdbc77e91
--- /dev/null
+++ b/drivers/ras/amd/atl/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# AMD Address Translation Library Makefile
+#
+# Copyright (c) 2023, Advanced Micro Devices, Inc.
+# All Rights Reserved.
+#
+# Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+
+obj-$(CONFIG_AMD_ATL_STUB)	+= stub.o
+
+amd_atl-y			:= access.o
+amd_atl-y			+= core.o
+amd_atl-y			+= dehash.o
+amd_atl-y			+= denormalize.o
+amd_atl-y			+= map.o
+amd_atl-y			+= system.o
+amd_atl-y			+= umc.o
+
+obj-$(CONFIG_AMD_ATL_MOD)	+= amd_atl.o
diff --git a/drivers/ras/amd/atl/access.c b/drivers/ras/amd/atl/access.c
new file mode 100644
index 000000000000..1de0460f5e03
--- /dev/null
+++ b/drivers/ras/amd/atl/access.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * access.c : DF Indirect Access functions
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "internal.h"
+
+/* Protect the PCI config register pairs used for DF indirect access. */
+static DEFINE_MUTEX(df_indirect_mutex);
+
+/*
+ * Data Fabric Indirect Access uses FICAA/FICAD.
+ *
+ * Fabric Indirect Configuration Access Address (FICAA): Constructed based
+ * on the device's Instance Id and the PCI function and register offset of
+ * the desired register.
+ *
+ * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
+ * and FICAD HI registers but so far we only need the LO register.
+ *
+ * Use Instance Id 0xFF to indicate a broadcast read.
+ */
+#define DF_BROADCAST		0xFF
+
+#define DF_FICAA_INST_EN	BIT(0)
+#define DF_FICAA_REG_NUM	GENMASK(10, 1)
+#define DF_FICAA_FUNC_NUM	GENMASK(13, 11)
+#define DF_FICAA_INST_ID	GENMASK(23, 16)
+
+#define DF_FICAA_REG_NUM_LEGACY	GENMASK(10, 2)
+
+static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	u32 ficaa_addr = 0x8C, ficad_addr = 0xB8;
+	struct pci_dev *F4;
+	int err = -ENODEV;
+	u32 ficaa = 0;
+
+	if (node >= amd_nb_num())
+		goto out;
+
+	F4 = node_to_amd_nb(node)->link;
+	if (!F4)
+		goto out;
+
+	/* Enable instance-specific access. */
+	if (instance_id != DF_BROADCAST) {
+		ficaa |= FIELD_PREP(DF_FICAA_INST_EN, 1);
+		ficaa |= FIELD_PREP(DF_FICAA_INST_ID, instance_id);
+	}
+
+	/*
+	 * The two least-significant bits are masked when inputing the
+	 * register offset to FICAA.
+	 */
+	reg >>= 2;
+
+	if (df_cfg.flags.legacy_ficaa) {
+		ficaa_addr = 0x5C;
+		ficad_addr = 0x98;
+
+		ficaa |= FIELD_PREP(DF_FICAA_REG_NUM_LEGACY, reg);
+	} else {
+		ficaa |= FIELD_PREP(DF_FICAA_REG_NUM, reg);
+	}
+
+	ficaa |= FIELD_PREP(DF_FICAA_FUNC_NUM, func);
+
+	mutex_lock(&df_indirect_mutex);
+
+	err = pci_write_config_dword(F4, ficaa_addr, ficaa);
+	if (err) {
+		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
+		goto out_unlock;
+	}
+
+	err = pci_read_config_dword(F4, ficad_addr, lo);
+	if (err)
+		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
+
+	pr_debug("node=%u inst=0x%x func=0x%x reg=0x%x val=0x%x",
+		 node, instance_id, func, reg << 2, *lo);
+
+out_unlock:
+	mutex_unlock(&df_indirect_mutex);
+
+out:
+	return err;
+}
+
+int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	return __df_indirect_read(node, func, reg, instance_id, lo);
+}
+
+int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
+{
+	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
+}
diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
new file mode 100644
index 000000000000..6a6220fef81f
--- /dev/null
+++ b/drivers/ras/amd/atl/core.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * core.c : Module init and base translation functions
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include <linux/module.h>
+#include <asm/cpu_device_id.h>
+
+#include "internal.h"
+
+struct df_config df_cfg __read_mostly;
+
+static int addr_over_limit(struct addr_ctx *ctx)
+{
+	u64 dram_limit_addr;
+
+	if (df_cfg.rev >= DF4)
+		dram_limit_addr  = FIELD_GET(DF4_DRAM_LIMIT_ADDR, ctx->map.limit);
+	else
+		dram_limit_addr  = FIELD_GET(DF2_DRAM_LIMIT_ADDR, ctx->map.limit);
+
+	dram_limit_addr <<= DF_DRAM_BASE_LIMIT_LSB;
+	dram_limit_addr |= GENMASK(DF_DRAM_BASE_LIMIT_LSB - 1, 0);
+
+	/* Is calculated system address above DRAM limit address? */
+	if (ctx->ret_addr > dram_limit_addr) {
+		warn_on_assert("Calculated address (0x%016llx) > DRAM limit (0x%016llx)",
+			       ctx->ret_addr, dram_limit_addr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool legacy_hole_en(struct addr_ctx *ctx)
+{
+	u32 reg = ctx->map.base;
+
+	if (df_cfg.rev >= DF4)
+		reg = ctx->map.ctl;
+
+	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
+}
+
+static int add_legacy_hole(struct addr_ctx *ctx)
+{
+	u32 dram_hole_base;
+	u8 func = 0;
+
+	if (!legacy_hole_en(ctx))
+		return 0;
+
+	if (df_cfg.rev >= DF4)
+		func = 7;
+
+	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
+		return -EINVAL;
+
+	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
+
+	if (ctx->ret_addr >= dram_hole_base)
+		ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
+
+	return 0;
+}
+
+static u64 get_base_addr(struct addr_ctx *ctx)
+{
+	u64 base_addr;
+
+	if (df_cfg.rev >= DF4)
+		base_addr = FIELD_GET(DF4_BASE_ADDR, ctx->map.base);
+	else
+		base_addr = FIELD_GET(DF2_BASE_ADDR, ctx->map.base);
+
+	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
+}
+
+static int add_base_and_hole(struct addr_ctx *ctx)
+{
+	ctx->ret_addr += get_base_addr(ctx);
+
+	if (add_legacy_hole(ctx))
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool late_hole_remove(struct addr_ctx *ctx)
+{
+	if (df_cfg.rev == DF3p5)
+		return true;
+
+	if (df_cfg.rev == DF4)
+		return true;
+
+	if (ctx->map.intlv_mode == DF3_6CHAN)
+		return true;
+
+	return false;
+}
+
+int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
+{
+	struct addr_ctx ctx;
+
+	if (df_cfg.rev == UNKNOWN)
+		return -EINVAL;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* We start from the normalized address */
+	ctx.ret_addr = *addr;
+	ctx.inst_id = cs_inst_id;
+
+	ctx.inputs.norm_addr = *addr;
+	ctx.inputs.socket_id = socket_id;
+	ctx.inputs.die_id = die_id;
+	ctx.inputs.cs_inst_id = cs_inst_id;
+
+	if (determine_node_id(&ctx, socket_id, die_id))
+		return -EINVAL;
+
+	if (get_address_map(&ctx))
+		return -EINVAL;
+
+	if (denormalize_address(&ctx))
+		return -EINVAL;
+
+	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
+		return -EINVAL;
+
+	if (dehash_address(&ctx))
+		return -EINVAL;
+
+	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
+		return -EINVAL;
+
+	if (addr_over_limit(&ctx))
+		return -EINVAL;
+
+	*addr = ctx.ret_addr;
+	return 0;
+}
+
+static void check_for_legacy_df_access(void)
+{
+	/*
+	 * All Zen-based systems before Family 19h use the legacy
+	 * DF Indirect Access (FICAA/FICAD) offsets.
+	 */
+	if (boot_cpu_data.x86 < 0x19) {
+		df_cfg.flags.legacy_ficaa = true;
+		return;
+	}
+
+	/* All systems after Family 19h use the current offsets. */
+	if (boot_cpu_data.x86 > 0x19)
+		return;
+
+	/* Some Family 19h systems use the legacy offsets. */
+	switch (boot_cpu_data.x86_model) {
+	case 0x00 ... 0x0f:
+	case 0x20 ... 0x5f:
+	       df_cfg.flags.legacy_ficaa = true;
+	}
+}
+
+static const struct x86_cpu_id amd_atl_cpuids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SMCA, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_ZEN, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_ZEN2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_ZEN3, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_ZEN4, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(x86cpu, amd_atl_cpuids);
+
+static struct amd_atl_ops ops = {
+	.convert_umc_na_to_spa	= convert_umc_mca_addr_to_sys_addr,
+};
+
+static int __init amd_atl_init(void)
+{
+	if (!x86_match_cpu(amd_atl_cpuids))
+		return -ENODEV;
+
+	if (!amd_nb_num())
+		return -ENODEV;
+
+	check_for_legacy_df_access();
+
+	if (get_df_system_info())
+		return -ENODEV;
+
+	amd_atl_pvt.initialize(&ops);
+
+	pr_info("AMD Address Translation Library initialized");
+	return 0;
+}
+
+static void __exit amd_atl_exit(void)
+{
+	amd_atl_pvt.release();
+}
+
+module_init(amd_atl_init);
+module_exit(amd_atl_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
new file mode 100644
index 000000000000..84fe9793694e
--- /dev/null
+++ b/drivers/ras/amd/atl/dehash.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * dehash.c : Functions to account for hashing bits
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "internal.h"
+
+static inline bool assert_intlv_bit(struct addr_ctx *ctx, u8 bit1, u8 bit2)
+{
+	if (ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)
+		return false;
+
+	warn_on_assert("%s: Invalid interleave bit: %u",
+		       __func__, ctx->map.intlv_bit_pos);
+
+	return true;
+}
+
+static inline bool assert_num_intlv_dies(struct addr_ctx *ctx, u8 num_intlv_dies)
+{
+	if (ctx->map.num_intlv_dies <= num_intlv_dies)
+		return false;
+
+	warn_on_assert("%s: Invalid number of interleave dies: %u",
+		       __func__, ctx->map.num_intlv_dies);
+
+	return true;
+}
+
+static inline bool assert_num_intlv_sockets(struct addr_ctx *ctx, u8 num_intlv_sockets)
+{
+	if (ctx->map.num_intlv_sockets <= num_intlv_sockets)
+		return false;
+
+	warn_on_assert("%s: Invalid number of interleave sockets: %u",
+		       __func__, ctx->map.num_intlv_sockets);
+
+	return true;
+}
+
+static int df2_dehash_addr(struct addr_ctx *ctx)
+{
+	u8 hashed_bit, intlv_bit, intlv_bit_pos;
+
+	/* Assert that interleave bit is 8 or 9. */
+	if (assert_intlv_bit(ctx, 8, 9))
+		return -EINVAL;
+
+	/* Assert that die and socket interleaving are disabled. */
+	if (assert_num_intlv_dies(ctx, 1))
+		return -EINVAL;
+
+	if (assert_num_intlv_sockets(ctx, 1))
+		return -EINVAL;
+
+	intlv_bit_pos = ctx->map.intlv_bit_pos;
+	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(12), ctx->ret_addr);
+	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr);
+	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr);
+	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr);
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
+
+	return 0;
+}
+
+static int df3_dehash_addr(struct addr_ctx *ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
+	u8 hashed_bit, intlv_bit, intlv_bit_pos;
+
+	/* Assert that interleave bit is 8 or 9. */
+	if (assert_intlv_bit(ctx, 8, 9))
+		return -EINVAL;
+
+	/* Assert that die and socket interleaving are disabled. */
+	if (assert_num_intlv_dies(ctx, 1))
+		return -EINVAL;
+
+	if (assert_num_intlv_sockets(ctx, 1))
+		return -EINVAL;
+
+	hash_ctl_64k	= FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
+
+	intlv_bit_pos = ctx->map.intlv_bit_pos;
+	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(14), ctx->ret_addr);
+	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
+
+	/* Calculation complete for 2 channels. Continue for 4 and 8 channels. */
+	if (ctx->map.intlv_mode == DF3_COD4_2CHAN_HASH)
+		return 0;
+
+	intlv_bit = FIELD_GET(BIT_ULL(12), ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(16), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(12);
+
+	/* Calculation complete for 4 channels. Continue for 8 channels. */
+	if (ctx->map.intlv_mode == DF3_COD2_4CHAN_HASH)
+		return 0;
+
+	intlv_bit = FIELD_GET(BIT_ULL(13), ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(17), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(13);
+
+	return 0;
+}
+
+static int df3_6chan_dehash_addr(struct addr_ctx *ctx)
+{
+	u8 intlv_bit_pos = ctx->map.intlv_bit_pos;
+	u8 hashed_bit, intlv_bit, num_intlv_bits;
+	bool hash_ctl_2M, hash_ctl_1G;
+
+	if (ctx->map.intlv_mode != DF3_6CHAN) {
+		warn_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	num_intlv_bits = ilog2(ctx->map.num_intlv_chan) + 1;
+
+	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
+
+	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= atl_get_bit((intlv_bit_pos + num_intlv_bits), ctx->ret_addr);
+	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
+
+	intlv_bit_pos++;
+	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
+
+	intlv_bit_pos++;
+	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
+
+	return 0;
+}
+
+static int df4_dehash_addr(struct addr_ctx *ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
+	u8 hashed_bit, intlv_bit;
+
+	/* Assert that interleave bit is 8. */
+	if (assert_intlv_bit(ctx, 8, 8))
+		return -EINVAL;
+
+	/* Assert that die interleaving is disabled. */
+	if (assert_num_intlv_dies(ctx, 1))
+		return -EINVAL;
+
+	/* Assert that no more than 2 sockets are interleaved. */
+	if (assert_num_intlv_sockets(ctx, 2))
+		return -EINVAL;
+
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
+
+	intlv_bit = FIELD_GET(BIT_ULL(8), ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(16), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
+
+	if (ctx->map.num_intlv_sockets == 1)
+		hashed_bit ^= FIELD_GET(BIT_ULL(14), ctx->ret_addr);
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(8);
+
+	/*
+	 * Hashing is possible with socket interleaving, so check the total number
+	 * of channels in the system rather than DRAM map interleaving mode.
+	 *
+	 * Calculation complete for 2 channels. Continue for 4, 8, and 16 channels.
+	 */
+	if (ctx->map.total_intlv_chan <= 2)
+		return 0;
+
+	intlv_bit = FIELD_GET(BIT_ULL(12), ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(17), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(12);
+
+	/* Calculation complete for 4 channels. Continue for 8 and 16 channels. */
+	if (ctx->map.total_intlv_chan <= 4)
+		return 0;
+
+	intlv_bit = FIELD_GET(BIT_ULL(13), ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(13);
+
+	/* Calculation complete for 8 channels. Continue for 16 channels. */
+	if (ctx->map.total_intlv_chan <= 8)
+		return 0;
+
+	intlv_bit = FIELD_GET(BIT_ULL(14), ctx->ret_addr);
+
+	hashed_bit = intlv_bit;
+	hashed_bit ^= FIELD_GET(BIT_ULL(19), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(24), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(33), ctx->ret_addr) & hash_ctl_1G;
+
+	if (hashed_bit != intlv_bit)
+		ctx->ret_addr ^= BIT_ULL(14);
+
+	return 0;
+}
+
+static int df4p5_dehash_addr(struct addr_ctx *ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
+	u8 hashed_bit, intlv_bit;
+	u64 rehash_vector;
+
+	/* Assert that interleave bit is 8. */
+	if (assert_intlv_bit(ctx, 8, 8))
+		return -EINVAL;
+
+	/* Assert that die interleaving is disabled. */
+	if (assert_num_intlv_dies(ctx, 1))
+		return -EINVAL;
+
+	/* Assert that no more than 2 sockets are interleaved. */
+	if (assert_num_intlv_sockets(ctx, 2))
+		return -EINVAL;
+
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
+	hash_ctl_1T	= FIELD_GET(DF4_HASH_CTL_1T, ctx->map.ctl);
+
+	/*
+	 * Generate a unique address to determine which bits
+	 * need to be dehashed.
+	 *
+	 * Start with a contiguous bitmask for the total
+	 * number of channels starting at bit 8.
+	 *
+	 * Then make a gap in the proper place based on
+	 * interleave mode.
+	 */
+	rehash_vector = ctx->map.total_intlv_chan - 1;
+	rehash_vector <<= 8;
+
+	if (ctx->map.intlv_mode == DF4p5_NPS2_4CHAN_1K_HASH ||
+	    ctx->map.intlv_mode == DF4p5_NPS1_8CHAN_1K_HASH ||
+	    ctx->map.intlv_mode == DF4p5_NPS1_16CHAN_1K_HASH)
+		rehash_vector = expand_bits(10, 2, rehash_vector);
+	else
+		rehash_vector = expand_bits(9, 3, rehash_vector);
+
+	if (rehash_vector & BIT_ULL(8)) {
+		intlv_bit = FIELD_GET(BIT_ULL(8), ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+		hashed_bit ^= FIELD_GET(BIT_ULL(16), ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(40), ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(8);
+	}
+
+	if (rehash_vector & BIT_ULL(9)) {
+		intlv_bit = FIELD_GET(BIT_ULL(9), ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+		hashed_bit ^= FIELD_GET(BIT_ULL(17), ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(41), ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(9);
+	}
+
+	if (rehash_vector & BIT_ULL(12)) {
+		intlv_bit = FIELD_GET(BIT_ULL(12), ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+		hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(42), ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(12);
+	}
+
+	if (rehash_vector & BIT_ULL(13)) {
+		intlv_bit = FIELD_GET(BIT_ULL(13), ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+		hashed_bit ^= FIELD_GET(BIT_ULL(19), ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(24), ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(33), ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(43), ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(13);
+	}
+
+	if (rehash_vector & BIT_ULL(14)) {
+		intlv_bit = FIELD_GET(BIT_ULL(14), ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+		hashed_bit ^= FIELD_GET(BIT_ULL(20), ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(25), ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(34), ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(44), ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(14);
+	}
+
+	return 0;
+}
+
+int dehash_address(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	/* No hashing cases. */
+	case NONE:
+	case NOHASH_2CHAN:
+	case NOHASH_4CHAN:
+	case NOHASH_8CHAN:
+	case NOHASH_16CHAN:
+	case NOHASH_32CHAN:
+	/* Hashing bits handled earlier during CS ID calculation. */
+	case DF4_NPS4_3CHAN_HASH:
+	case DF4_NPS2_5CHAN_HASH:
+	case DF4_NPS2_6CHAN_HASH:
+	case DF4_NPS1_10CHAN_HASH:
+	case DF4_NPS1_12CHAN_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	/* No hash physical address bits, so nothing to do. */
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		return 0;
+
+	case DF2_2CHAN_HASH:
+		return df2_dehash_addr(ctx);
+
+	case DF3_COD4_2CHAN_HASH:
+	case DF3_COD2_4CHAN_HASH:
+	case DF3_COD1_8CHAN_HASH:
+		return df3_dehash_addr(ctx);
+
+	case DF3_6CHAN:
+		return df3_6chan_dehash_addr(ctx);
+
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+		return df4_dehash_addr(ctx);
+
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+	case DF4p5_NPS1_16CHAN_1K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		return df4p5_dehash_addr(ctx);
+
+	default:
+		warn_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+}
diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
new file mode 100644
index 000000000000..f84a370efe90
--- /dev/null
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * denormalize.c : Functions to account for interleaving bits
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "internal.h"
+
+/*
+ * Returns the Destination Fabric ID. This is the first (lowest)
+ * CS Fabric ID used within a DRAM Address map.
+ */
+static u16 get_dst_fabric_id(struct addr_ctx *ctx)
+{
+	switch (df_cfg.rev) {
+	case DF2:	return FIELD_GET(DF2_DST_FABRIC_ID,	ctx->map.limit);
+	case DF3:	return FIELD_GET(DF3_DST_FABRIC_ID,	ctx->map.limit);
+	case DF3p5:	return FIELD_GET(DF3p5_DST_FABRIC_ID,	ctx->map.limit);
+	case DF4:	return FIELD_GET(DF4_DST_FABRIC_ID,	ctx->map.ctl);
+	case DF4p5:	return FIELD_GET(DF4p5_DST_FABRIC_ID,	ctx->map.ctl);
+	default:
+			warn_on_bad_df_rev();
+			return 0;
+	}
+}
+
+/*
+ * Make a contiguous gap in address for N bits starting at bit P.
+ *
+ * Example:
+ * address bits:		[20:0]
+ * # of interleave bits    (n):	3
+ * starting interleave bit (p):	8
+ *
+ * expanded address bits:	[20+n : n+p][n+p-1 : p][p-1 : 0]
+ *				[23   :  11][10    : 8][7   : 0]
+ */
+static u64 make_space_for_cs_id_at_intlv_bit(struct addr_ctx *ctx)
+{
+	return expand_bits(ctx->map.intlv_bit_pos,
+			   ctx->map.total_intlv_bits,
+			   ctx->ret_addr);
+}
+
+/*
+ * Make two gaps in address for N bits.
+ * First gap is a single bit at bit P.
+ * Second gap is the remaining N-1 bits at bit 12.
+ *
+ * Example:
+ * address bits:		[20:0]
+ * # of interleave bits    (n):	3
+ * starting interleave bit (p):	8
+ *
+ * First gap
+ * expanded address bits:	[20+1 : p+1][p][p-1 : 0]
+ *				[21   :   9][8][7   : 0]
+ *
+ * Second gap uses result from first.
+ *				r = n - 1; remaining interleave bits
+ * expanded address bits:	[21+r : 12+r][12+r-1: 12][11 : 0]
+ *				[23   :   14][13    : 12][11 : 0]
+ */
+static u64 make_space_for_cs_id_split_2_1(struct addr_ctx *ctx)
+{
+	/* Make a single space at the interleave bit. */
+	u64 denorm_addr = expand_bits(ctx->map.intlv_bit_pos, 1, ctx->ret_addr);
+
+	/* Done if there's only a single interleave bit. */
+	if (ctx->map.total_intlv_bits <= 1)
+		return denorm_addr;
+
+	/* Make spaces for the remaining interleave bits starting at bit 12. */
+	return expand_bits(12, ctx->map.total_intlv_bits - 1, denorm_addr);
+}
+
+/*
+ * Take the current calculated address and shift enough bits in the middle
+ * to make a gap where the interleave bits will be inserted.
+ */
+static u64 make_space_for_cs_id(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case NOHASH_2CHAN:
+	case NOHASH_4CHAN:
+	case NOHASH_8CHAN:
+	case NOHASH_16CHAN:
+	case NOHASH_32CHAN:
+	case DF2_2CHAN_HASH:
+		return make_space_for_cs_id_at_intlv_bit(ctx);
+
+	case DF3_COD4_2CHAN_HASH:
+	case DF3_COD2_4CHAN_HASH:
+	case DF3_COD1_8CHAN_HASH:
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		return make_space_for_cs_id_split_2_1(ctx);
+	default:
+		warn_on_bad_intlv_mode(ctx);
+		return ~0ULL;
+	}
+}
+
+static u16 get_cs_id_df2(struct addr_ctx *ctx)
+{
+	u8 num_socket_intlv_bits = ilog2(ctx->map.num_intlv_sockets);
+	u8 num_die_intlv_bits = ilog2(ctx->map.num_intlv_dies);
+	u8 num_intlv_bits;
+	u16 cs_id, mask;
+
+	cs_id = ctx->cs_fabric_id - get_dst_fabric_id(ctx);
+
+	/* Channel interleave bits */
+	num_intlv_bits = order_base_2(ctx->map.num_intlv_chan);
+	mask = GENMASK(num_intlv_bits - 1, 0);
+	cs_id &= mask;
+
+	/* Die interleave bits */
+	if (num_die_intlv_bits) {
+		u16 die_bits;
+
+		mask = GENMASK(num_die_intlv_bits - 1, 0);
+		die_bits = ctx->cs_fabric_id & df_cfg.die_id_mask;
+		die_bits >>= df_cfg.die_id_shift;
+
+		cs_id |= (die_bits & mask) << num_intlv_bits;
+		num_intlv_bits += num_die_intlv_bits;
+	}
+
+	/* Socket interleave bits */
+	if (num_socket_intlv_bits) {
+		u16 socket_bits;
+
+		mask = GENMASK(num_socket_intlv_bits - 1, 0);
+		socket_bits = ctx->cs_fabric_id & df_cfg.socket_id_mask;
+		socket_bits >>= df_cfg.socket_id_shift;
+
+		cs_id |= (socket_bits & mask) << num_intlv_bits;
+	}
+
+	return cs_id;
+}
+
+static u16 get_cs_id_df4(struct addr_ctx *ctx)
+{
+	/*
+	 * Start with the original component mask and the number of interleave
+	 * bits for the channels in this map.
+	 */
+	u8 num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
+	u16 mask = df_cfg.component_id_mask;
+
+	u16 socket_bits;
+
+	/* Set the derived CS ID to the input CS Fabric ID. */
+	u16 cs_id = ctx->cs_fabric_id & mask;
+
+	/*
+	 * Subtract the "base" Destination Fabric ID.
+	 * This accounts for systems with disabled Coherent Stations.
+	 */
+	cs_id -= get_dst_fabric_id(ctx) & mask;
+
+	/*
+	 * Generate and use a new mask based on the number of bits
+	 * needed for channel interleaving in this map.
+	 */
+	mask = GENMASK(num_intlv_bits - 1, 0);
+	cs_id &= mask;
+
+	/* Done if socket interleaving is not enabled. */
+	if (ctx->map.num_intlv_sockets <= 1)
+		return cs_id;
+
+	/*
+	 * Figure out how many bits are needed for the number of
+	 * interleaved sockets. And shift the derived CS ID to account
+	 * for these.
+	 */
+	num_intlv_bits = ilog2(ctx->map.num_intlv_sockets);
+	cs_id <<= num_intlv_bits;
+
+	/* Generate a new mask for the socket interleaving bits. */
+	mask = GENMASK(num_intlv_bits - 1, 0);
+
+	/* Get the socket interleave bits from the original CS Fabric ID. */
+	socket_bits = (ctx->cs_fabric_id & df_cfg.socket_id_mask) >> df_cfg.socket_id_shift;
+
+	/* Apply the appropriate socket bits to the derived CS ID. */
+	cs_id |= socket_bits & mask;
+
+	return cs_id;
+}
+
+/*
+ * Derive the correct CS ID that represents the interleave bits
+ * used within the system physical address. This accounts for the
+ * interleave mode, number of interleaved channels/dies/sockets, and
+ * other system/mode-specific bit swizzling.
+ *
+ * Returns:	CS ID on success.
+ *		All bits set on error.
+ */
+static u16 calculate_cs_id(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case NOHASH_2CHAN:
+	case NOHASH_4CHAN:
+	case NOHASH_8CHAN:
+	case NOHASH_16CHAN:
+	case NOHASH_32CHAN:
+	case DF3_COD4_2CHAN_HASH:
+	case DF3_COD2_4CHAN_HASH:
+	case DF3_COD1_8CHAN_HASH:
+	case DF2_2CHAN_HASH:
+		return get_cs_id_df2(ctx);
+
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		return get_cs_id_df4(ctx);
+
+	/* CS ID is simply the CS Fabric ID adjusted by the Destination Fabric ID. */
+	case DF4p5_NPS2_4CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_1K_HASH:
+	case DF4p5_NPS1_16CHAN_1K_HASH:
+		return ctx->cs_fabric_id - get_dst_fabric_id(ctx);
+
+	default:
+		warn_on_bad_intlv_mode(ctx);
+		return ~0;
+	}
+}
+
+static u64 insert_cs_id_at_intlv_bit(struct addr_ctx *ctx, u64 denorm_addr, u16 cs_id)
+{
+	return denorm_addr | (cs_id << ctx->map.intlv_bit_pos);
+}
+
+static u64 insert_cs_id_split_2_1(struct addr_ctx *ctx, u64 denorm_addr, u16 cs_id)
+{
+	/* Insert cs_id[0] at the interleave bit. */
+	denorm_addr |= (cs_id & BIT(0)) << ctx->map.intlv_bit_pos;
+
+	/* Insert cs_id[2:1] at bit 12. */
+	denorm_addr |= (cs_id & GENMASK(2, 1)) << 11;
+
+	return denorm_addr;
+}
+
+static u64 insert_cs_id_split_2_2(struct addr_ctx *ctx, u64 denorm_addr, u16 cs_id)
+{
+	/* Insert cs_id[1:0] at bit 8. */
+	denorm_addr |= (cs_id & GENMASK(1, 0)) << 8;
+
+	/*
+	 * Insert cs_id[n:2] at bit 12. 'n' could be 2 or 3.
+	 * Grab both because bit 3 will be clear if unused.
+	 */
+	denorm_addr |= (cs_id & GENMASK(3, 2)) << 10;
+
+	return denorm_addr;
+}
+
+static u64 insert_cs_id(struct addr_ctx *ctx, u64 denorm_addr, u16 cs_id)
+{
+	switch (ctx->map.intlv_mode) {
+	case NOHASH_2CHAN:
+	case NOHASH_4CHAN:
+	case NOHASH_8CHAN:
+	case NOHASH_16CHAN:
+	case NOHASH_32CHAN:
+	case DF2_2CHAN_HASH:
+		return insert_cs_id_at_intlv_bit(ctx, denorm_addr, cs_id);
+
+	case DF3_COD4_2CHAN_HASH:
+	case DF3_COD2_4CHAN_HASH:
+	case DF3_COD1_8CHAN_HASH:
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		return insert_cs_id_split_2_1(ctx, denorm_addr, cs_id);
+
+	case DF4p5_NPS2_4CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_1K_HASH:
+	case DF4p5_NPS1_16CHAN_1K_HASH:
+		return insert_cs_id_split_2_2(ctx, denorm_addr, cs_id);
+
+	default:
+		warn_on_bad_intlv_mode(ctx);
+		return ~0ULL;
+	}
+}
+
+static u16 get_logical_cs_fabric_id(struct addr_ctx *ctx)
+{
+	u16 cs_component_id, log_cs_fabric_id;
+
+	/* Start with the physical CS Fabric ID. */
+	u16 phys_cs_fabric_id = ctx->cs_fabric_id;
+
+	/* Skip logical ID lookup if remapping is disabled. */
+	if (!FIELD_GET(DF4_REMAP_EN, ctx->map.ctl) &&
+	    ctx->map.intlv_mode != DF3_6CHAN)
+		return phys_cs_fabric_id;
+
+	/* Mask off the Node ID bits to get the "local" Component ID. */
+	cs_component_id = phys_cs_fabric_id & df_cfg.component_id_mask;
+
+	/*
+	 * Search the list of logical Component IDs for the one that
+	 * matches this physical Component ID.
+	 */
+	for (log_cs_fabric_id = 0; log_cs_fabric_id < MAX_CS_CHANNELS; log_cs_fabric_id++) {
+		if (ctx->map.remap_array[log_cs_fabric_id] == cs_component_id)
+			break;
+	}
+
+	if (log_cs_fabric_id == MAX_CS_CHANNELS)
+		warn_on_assert("CS remap entry not found for 0x%x", log_cs_fabric_id);
+
+	/* Get the Node ID bits from the physical and apply to the logical. */
+	return (phys_cs_fabric_id & df_cfg.node_id_mask) | log_cs_fabric_id;
+}
+
+static int denorm_addr_common(struct addr_ctx *ctx)
+{
+	u64 denorm_addr;
+	u16 cs_id;
+
+	/*
+	 * Convert the original physical CS Fabric ID to a logical value.
+	 * This is required for non-power-of-two and other interleaving modes.
+	 */
+	ctx->cs_fabric_id = get_logical_cs_fabric_id(ctx);
+
+	denorm_addr = make_space_for_cs_id(ctx);
+	cs_id = calculate_cs_id(ctx);
+	ctx->ret_addr = insert_cs_id(ctx, denorm_addr, cs_id);
+	return 0;
+}
+
+static int denorm_addr_df3_6chan(struct addr_ctx *ctx)
+{
+	u16 cs_id = ctx->cs_fabric_id & df_cfg.component_id_mask;
+	u8 total_intlv_bits = ctx->map.total_intlv_bits;
+	u8 low_bit, intlv_bit = ctx->map.intlv_bit_pos;
+	u64 msb_intlv_bits, temp_addr_a, temp_addr_b;
+	u8 np2_bits = ctx->map.np2_bits;
+
+	if (ctx->map.intlv_mode != DF3_6CHAN)
+		return -EINVAL;
+
+	/*
+	 * 'np2_bits' holds the number of bits needed to cover the
+	 * amount of memory (rounded up) in this map using 64K chunks.
+	 *
+	 * Example:
+	 * Total memory in map:			6GB
+	 * Rounded up to next power-of-2:	8GB
+	 * Number of 64K chunks:		0x20000
+	 * np2_bits = log2(# of chunks):	17
+	 *
+	 * Get the two most-significant interleave bits from the
+	 * input address based on the following:
+	 *
+	 * [15 + np2_bits - total_intlv_bits : 14 + np2_bits - total_intlv_bits]
+	 */
+	low_bit = 14 + np2_bits - total_intlv_bits;
+	msb_intlv_bits = ctx->ret_addr >> low_bit;
+	msb_intlv_bits &= 0x3;
+
+	/*
+	 * If MSB are 11b, then logical CS ID is 6 or 7.
+	 * Need to adjust based on the mod3 result.
+	 */
+	if (msb_intlv_bits == 3) {
+		u8 addr_mod, phys_addr_msb, msb_cs_id;
+
+		/* Get the remaining interleave bits from the input address. */
+		temp_addr_b = GENMASK_ULL(low_bit - 1, intlv_bit) & ctx->ret_addr;
+		temp_addr_b >>= intlv_bit;
+
+		/* Calculate the logical CS offset based on mod3. */
+		addr_mod = temp_addr_b % 3;
+
+		/* Get CS ID bits [2:1]. */
+		msb_cs_id = (cs_id >> 1) & 0x3;
+
+		/* Get the bit that starts the physical address bits. */
+		phys_addr_msb = (intlv_bit + np2_bits + 1);
+		phys_addr_msb &= BIT(0);
+		phys_addr_msb++;
+		phys_addr_msb *= 3 - addr_mod + msb_cs_id;
+		phys_addr_msb %= 3;
+
+		/* Move the physical address MSB to the correct place. */
+		temp_addr_b |= phys_addr_msb << (low_bit - total_intlv_bits - intlv_bit);
+
+		/* Generate a new CS ID as follows: cs_id = [1, 1, cs_id[0]] */
+		cs_id &= BIT(0);
+		cs_id |= GENMASK(2, 1);
+	} else {
+		temp_addr_b = GENMASK_ULL(63, intlv_bit) & ctx->ret_addr;
+		temp_addr_b >>= intlv_bit;
+	}
+
+	temp_addr_a = GENMASK_ULL(intlv_bit - 1, 0) & ctx->ret_addr;
+	temp_addr_b <<= intlv_bit + total_intlv_bits;
+
+	ctx->ret_addr = temp_addr_a | temp_addr_b;
+	ctx->ret_addr |= cs_id << intlv_bit;
+	return 0;
+}
+
+static int denorm_addr_df4_np2(struct addr_ctx *ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
+	u16 group, group_offset, log_cs_offset;
+	unsigned int mod_value, shift_value;
+	u16 mask = df_cfg.component_id_mask;
+	u64 temp_addr_a, temp_addr_b;
+	u8 hash_pa8, hashed_bit;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4_NPS4_3CHAN_HASH:
+		mod_value	= 3;
+		shift_value	= 13;
+		break;
+	case DF4_NPS2_6CHAN_HASH:
+		mod_value	= 3;
+		shift_value	= 12;
+		break;
+	case DF4_NPS1_12CHAN_HASH:
+		mod_value	= 3;
+		shift_value	= 11;
+		break;
+	case DF4_NPS2_5CHAN_HASH:
+		mod_value	= 5;
+		shift_value	= 13;
+		break;
+	case DF4_NPS1_10CHAN_HASH:
+		mod_value	= 5;
+		shift_value	= 12;
+		break;
+	default:
+		warn_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	};
+
+	if (ctx->map.num_intlv_sockets == 1) {
+		hash_pa8	= BIT_ULL(shift_value) & ctx->ret_addr;
+		temp_addr_a	= remove_bits(shift_value, shift_value, ctx->ret_addr);
+	} else {
+		hash_pa8	= (ctx->cs_fabric_id & df_cfg.socket_id_mask);
+		hash_pa8	>>= df_cfg.socket_id_shift;
+		temp_addr_a	= ctx->ret_addr;
+	}
+
+	/* Make a gap for the real bit [8]. */
+	temp_addr_a = expand_bits(8, 1, temp_addr_a);
+
+	/* Make an additional gap for bits [13:12], as appropriate.*/
+	if (ctx->map.intlv_mode == DF4_NPS2_6CHAN_HASH ||
+	    ctx->map.intlv_mode == DF4_NPS1_10CHAN_HASH) {
+		temp_addr_a = expand_bits(13, 1, temp_addr_a);
+	} else if (ctx->map.intlv_mode == DF4_NPS1_12CHAN_HASH) {
+		temp_addr_a = expand_bits(12, 2, temp_addr_a);
+	}
+
+	/* Keep bits [13:0]. */
+	temp_addr_a &= GENMASK_ULL(13, 0);
+
+	/* Get the appropriate high bits. */
+	shift_value += 1 - ilog2(ctx->map.num_intlv_sockets);
+	temp_addr_b = GENMASK_ULL(63, shift_value) & ctx->ret_addr;
+	temp_addr_b >>= shift_value;
+	temp_addr_b *= mod_value;
+
+	/*
+	 * Coherent Stations are divided into groups.
+	 *
+	 * Multiples of 3 (mod3) are divided into quadrants.
+	 * e.g. NP4_3CHAN ->	[0, 1, 2] [6, 7, 8]
+	 *			[3, 4, 5] [9, 10, 11]
+	 *
+	 * Multiples of 5 (mod5) are divided into sides.
+	 * e.g. NP2_5CHAN ->	[0, 1, 2, 3, 4] [5, 6, 7, 8, 9]
+	 */
+
+	 /*
+	  * Calculate the logical offset for the CS within its DRAM Address map.
+	  * e.g. if map includes [5, 6, 7, 8, 9] and target instance is '8', then
+	  *	 log_cs_offset = 8 - 5 = 3
+	  */
+	log_cs_offset = (ctx->cs_fabric_id & mask) - (get_dst_fabric_id(ctx) & mask);
+
+	/*
+	 * Figure out the group number.
+	 *
+	 * Following above example,
+	 * log_cs_offset = 3
+	 * mod_value = 5
+	 * group = 3 / 5 = 0
+	 */
+	group = log_cs_offset / mod_value;
+
+	/*
+	 * Figure out the offset within the group.
+	 *
+	 * Following above example,
+	 * log_cs_offset = 3
+	 * mod_value = 5
+	 * group_offset = 3 % 5 = 3
+	 */
+	group_offset = log_cs_offset % mod_value;
+
+	/* Adjust group_offset if the hashed bit [8] is set. */
+	if (hash_pa8) {
+		if (!group_offset)
+			group_offset = mod_value - 1;
+		else
+			group_offset--;
+	}
+
+	/* Add in the group offset to the high bits. */
+	temp_addr_b += group_offset;
+
+	/* Shift the high bits to the proper starting position. */
+	temp_addr_b <<= 14;
+
+	/* Combine the high and low bits together. */
+	ctx->ret_addr = temp_addr_a | temp_addr_b;
+
+	/* Account for hashing here instead of in dehash_address(). */
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
+
+	hashed_bit = !!hash_pa8;
+	hashed_bit ^= FIELD_GET(BIT_ULL(14), ctx->ret_addr);
+	hashed_bit ^= FIELD_GET(BIT_ULL(16), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
+
+	ctx->ret_addr |= hashed_bit << 8;
+
+	/* Done for 3 and 5 channel. */
+	if (ctx->map.intlv_mode == DF4_NPS4_3CHAN_HASH ||
+	    ctx->map.intlv_mode == DF4_NPS2_5CHAN_HASH)
+		return 0;
+
+	/* Select the proper 'group' bit to use for Bit 13. */
+	if (ctx->map.intlv_mode == DF4_NPS1_12CHAN_HASH)
+		hashed_bit = !!(group & BIT(1));
+	else
+		hashed_bit = group & BIT(0);
+
+	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
+
+	ctx->ret_addr |= hashed_bit << 13;
+
+	/* Done for 6 and 10 channel. */
+	if (ctx->map.intlv_mode != DF4_NPS1_12CHAN_HASH)
+		return 0;
+
+	hashed_bit = group & BIT(0);
+	hashed_bit ^= FIELD_GET(BIT_ULL(17), ctx->ret_addr) & hash_ctl_64k;
+	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
+	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
+
+	ctx->ret_addr |= hashed_bit << 12;
+	return 0;
+}
+
+int denormalize_address(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case NONE:
+		return 0;
+	case DF4_NPS4_3CHAN_HASH:
+	case DF4_NPS2_6CHAN_HASH:
+	case DF4_NPS1_12CHAN_HASH:
+	case DF4_NPS2_5CHAN_HASH:
+	case DF4_NPS1_10CHAN_HASH:
+		return denorm_addr_df4_np2(ctx);
+	case DF3_6CHAN:
+		return denorm_addr_df3_6chan(ctx);
+	default:
+		return denorm_addr_common(ctx);
+	}
+}
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
new file mode 100644
index 000000000000..08bc46f7cabf
--- /dev/null
+++ b/drivers/ras/amd/atl/internal.h
@@ -0,0 +1,312 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Address Translation Library
+ *
+ * internal.h : Helper functions and common defines
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#ifndef __AMD_ATL_INTERNAL_H__
+#define __AMD_ATL_INTERNAL_H__
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include <asm/amd_nb.h>
+
+#include "reg_fields.h"
+#include "stub.h"
+
+/* Maximum possible number of Coherent Stations within a single Data Fabric. */
+#define MAX_CS_CHANNELS			32
+
+/* PCI ID for Zen4 Server DF Function 0. */
+#define DF_FUNC0_ID_ZEN4_SERVER		0x14AD1022
+
+/* Shift needed for adjusting register values to true values. */
+#define DF_DRAM_BASE_LIMIT_LSB		28
+
+enum df_revisions {
+	UNKNOWN,
+	DF2,
+	DF3,
+	DF3p5,
+	DF4,
+	DF4p5,
+};
+
+/* These are mapped 1:1 to the hardware values. Special cases are set at > 0x20. */
+enum intlv_modes {
+	NONE				= 0x00,
+	NOHASH_2CHAN			= 0x01,
+	NOHASH_4CHAN			= 0x03,
+	NOHASH_8CHAN			= 0x05,
+	DF3_6CHAN			= 0x06,
+	NOHASH_16CHAN			= 0x07,
+	NOHASH_32CHAN			= 0x08,
+	DF3_COD4_2CHAN_HASH		= 0x0C,
+	DF3_COD2_4CHAN_HASH		= 0x0D,
+	DF3_COD1_8CHAN_HASH		= 0x0E,
+	DF4_NPS4_2CHAN_HASH		= 0x10,
+	DF4_NPS2_4CHAN_HASH		= 0x11,
+	DF4_NPS1_8CHAN_HASH		= 0x12,
+	DF4_NPS4_3CHAN_HASH		= 0x13,
+	DF4_NPS2_6CHAN_HASH		= 0x14,
+	DF4_NPS1_12CHAN_HASH		= 0x15,
+	DF4_NPS2_5CHAN_HASH		= 0x16,
+	DF4_NPS1_10CHAN_HASH		= 0x17,
+	DF2_2CHAN_HASH			= 0x21,
+	/* DF4.5 modes are all IntLvNumChan + 0x20 */
+	DF4p5_NPS1_16CHAN_1K_HASH	= 0x2C,
+	DF4p5_NPS0_24CHAN_1K_HASH	= 0x2E,
+	DF4p5_NPS4_2CHAN_1K_HASH	= 0x30,
+	DF4p5_NPS2_4CHAN_1K_HASH	= 0x31,
+	DF4p5_NPS1_8CHAN_1K_HASH	= 0x32,
+	DF4p5_NPS4_3CHAN_1K_HASH	= 0x33,
+	DF4p5_NPS2_6CHAN_1K_HASH	= 0x34,
+	DF4p5_NPS1_12CHAN_1K_HASH	= 0x35,
+	DF4p5_NPS2_5CHAN_1K_HASH	= 0x36,
+	DF4p5_NPS1_10CHAN_1K_HASH	= 0x37,
+	DF4p5_NPS4_2CHAN_2K_HASH	= 0x40,
+	DF4p5_NPS2_4CHAN_2K_HASH	= 0x41,
+	DF4p5_NPS1_8CHAN_2K_HASH	= 0x42,
+	DF4p5_NPS1_16CHAN_2K_HASH	= 0x43,
+	DF4p5_NPS4_3CHAN_2K_HASH	= 0x44,
+	DF4p5_NPS2_6CHAN_2K_HASH	= 0x45,
+	DF4p5_NPS1_12CHAN_2K_HASH	= 0x46,
+	DF4p5_NPS0_24CHAN_2K_HASH	= 0x47,
+	DF4p5_NPS2_5CHAN_2K_HASH	= 0x48,
+	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
+};
+
+struct df_flags {
+	__u8	legacy_ficaa		: 1,
+		socket_id_shift_quirk	: 1,
+		__reserved_0		: 6;
+};
+
+struct df_config {
+	enum df_revisions rev;
+
+	/*
+	 * These masks operate on the 16-bit CS IDs,
+	 * e.g. Instance, Fabric, Destination, etc.
+	 */
+	u16 component_id_mask;
+	u16 die_id_mask;
+	u16 node_id_mask;
+	u16 socket_id_mask;
+
+	/*
+	 * Least-significant bit of Node ID portion of the
+	 * system-wide CS Fabric ID.
+	 */
+	u8 node_id_shift;
+
+	/*
+	 * Least-significant bit of Die portion of the Node ID.
+	 * Adjusted to include the Node ID shift in order to apply
+	 * to the CS Fabric ID.
+	 */
+	u8 die_id_shift;
+
+	/*
+	 * Least-significant bit of Socket portion of the Node ID.
+	 * Adjusted to include the Node ID shift in order to apply
+	 * to the CS Fabric ID.
+	 */
+	u8 socket_id_shift;
+
+	/* Number of DRAM Address maps visible in a CS. */
+	u8 num_cs_maps;
+
+	/* Global flags to handle special cases. */
+	struct df_flags flags;
+};
+
+extern struct df_config df_cfg;
+
+struct dram_addr_map {
+	/*
+	 * Each DRAM Address Map can operate independently
+	 * in different interleaving modes.
+	 */
+	enum intlv_modes intlv_mode;
+
+	/* System-wide number for this address map. */
+	u8 num;
+
+	/* Raw register values */
+	u32 base;
+	u32 limit;
+	u32 ctl;
+	u32 intlv;
+
+	/*
+	 * Logical to Physical CS Remapping array
+	 *
+	 * Index: Logical CS Instance ID
+	 * Value: Physical CS Instance ID
+	 *
+	 * phys_cs_inst_id = remap_array[log_cs_inst_id]
+	 */
+	u8 remap_array[MAX_CS_CHANNELS];
+
+	/*
+	 * Number of bits covering DRAM Address map 0
+	 * when interleaving is non-power-of-2.
+	 *
+	 * Used only for DF3_6CHAN.
+	 */
+	u8 np2_bits;
+
+	/* Position of the 'interleave bit'. */
+	u8 intlv_bit_pos;
+	/* Number of channels interleaved in this map. */
+	u8 num_intlv_chan;
+	/* Number of dies interleaved in this map. */
+	u8 num_intlv_dies;
+	/* Number of sockets interleaved in this map. */
+	u8 num_intlv_sockets;
+	/*
+	 * Total number of channels interleaved accounting
+	 * for die and socket interleaving.
+	 */
+	u8 total_intlv_chan;
+	/* Total bits needed to cover 'total_intlv_chan'. */
+	u8 total_intlv_bits;
+};
+
+/* Original input values cached for debug printing. */
+struct addr_ctx_inputs {
+	u64 norm_addr;
+	u8 socket_id;
+	u8 die_id;
+	u8 cs_inst_id;
+};
+
+struct addr_ctx {
+	u64 ret_addr;
+
+	struct addr_ctx_inputs inputs;
+	struct dram_addr_map map;
+
+	/* AMD Node ID calculated from Socket and Die IDs. */
+	u8 node_id;
+
+	/*
+	 * CS Instance ID
+	 * Local ID used within a 'node'.
+	 */
+	u16 inst_id;
+
+	/*
+	 * CS Fabric ID
+	 * System-wide ID that includes 'node' bits.
+	 */
+	u16 cs_fabric_id;
+};
+
+int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo);
+int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo);
+
+int get_df_system_info(void);
+int determine_node_id(struct addr_ctx *ctx, u8 socket_num, u8 die_num);
+
+int get_address_map(struct addr_ctx *ctx);
+
+int denormalize_address(struct addr_ctx *ctx);
+int dehash_address(struct addr_ctx *ctx);
+
+int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr);
+int convert_umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr);
+
+/*
+ * Helper to use test_bit() without needing to do
+ * a cast to "unsigned long *" everywhere.
+ *
+ * Use this for dynamic checks, i.e. when FIELD_GET()
+ * won't work.
+ */
+static inline bool atl_get_bit(u8 bit_num, u64 data)
+{
+	return test_bit(bit_num, (unsigned long *)&data);
+}
+
+/*
+ * Make a gap in 'data' that is 'num_bits' long starting at 'bit_num.
+ * e.g. data		= 11111111'b
+ *	bit_num		= 3
+ *	num_bits	= 2
+ *	result		= 1111100111'b
+ */
+static inline u64 expand_bits(u8 bit_num, u8 num_bits, u64 data)
+{
+	u64 temp1, temp2;
+
+	/*
+	 * Return the original data if the "space" needed is '0'.
+	 * This helps avoid the need to check for '0' at each
+	 * caller.
+	 */
+	if (!num_bits)
+		return data;
+
+	if (!bit_num)
+		return data << num_bits;
+
+	temp1 = data & GENMASK_ULL(bit_num - 1, 0);
+
+	temp2 = data & GENMASK_ULL(63, bit_num);
+	temp2 <<= num_bits;
+
+	return temp1 | temp2;
+}
+
+/*
+ * Remove bits in 'data' between low_bit and high_bit inclusive.
+ * e.g. data		= XXXYYZZZ'b
+ *	low_bit		= 3
+ *	high_bit	= 4
+ *	result		= XXXZZZ'b
+ */
+static inline u64 remove_bits(u8 low_bit, u8 high_bit, u64 data)
+{
+	u64 temp1, temp2;
+
+	if (high_bit >= 64 || low_bit >= 64 || low_bit > high_bit) {
+		pr_warn("%s: Invalid inputs: low_bit=%u high_bit=%u",
+			__func__, low_bit, high_bit);
+		return 0;
+	}
+
+	if (!low_bit)
+		return data >> (high_bit++);
+
+	temp1 = GENMASK_ULL(low_bit - 1, 0) & data;
+	temp2 = GENMASK_ULL(63, high_bit + 1) & data;
+	temp2 >>= high_bit - low_bit + 1;
+
+	return temp1 | temp2;
+}
+
+#define warn_on_assert(fmt, arg...) \
+	pr_warn("amd_atl: socket_id=%u die_id=%u cs_inst_id=%u norm_addr=0x%016llx: " fmt,\
+		ctx->inputs.socket_id, ctx->inputs.die_id,\
+		ctx->inputs.cs_inst_id, ctx->inputs.norm_addr, ##arg)
+
+static inline void warn_on_bad_df_rev(void)
+{
+	pr_warn("amd_atl:%s: Unrecognized DF rev: %u", __func__, df_cfg.rev);
+}
+
+static inline void warn_on_bad_intlv_mode(struct addr_ctx *ctx)
+{
+	warn_on_assert("Unrecognized interleave mode: %u", ctx->map.intlv_mode);
+}
+
+#endif /* __AMD_ATL_INTERNAL_H__ */
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
new file mode 100644
index 000000000000..1de723178cb5
--- /dev/null
+++ b/drivers/ras/amd/atl/map.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * map.c : Functions to read and decode DRAM address maps
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "internal.h"
+
+static int df2_get_intlv_mode(struct addr_ctx *ctx)
+{
+	ctx->map.intlv_mode = FIELD_GET(DF2_INTLV_NUM_CHAN, ctx->map.base);
+
+	if (ctx->map.intlv_mode == 8)
+		ctx->map.intlv_mode = DF2_2CHAN_HASH;
+
+	if (ctx->map.intlv_mode != NONE &&
+	    ctx->map.intlv_mode != NOHASH_2CHAN &&
+	    ctx->map.intlv_mode != DF2_2CHAN_HASH) {
+		warn_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int df3_get_intlv_mode(struct addr_ctx *ctx)
+{
+	ctx->map.intlv_mode = FIELD_GET(DF3_INTLV_NUM_CHAN, ctx->map.base);
+	return 0;
+}
+
+static int df3p5_get_intlv_mode(struct addr_ctx *ctx)
+{
+	ctx->map.intlv_mode = FIELD_GET(DF3p5_INTLV_NUM_CHAN, ctx->map.base);
+
+	if (ctx->map.intlv_mode == DF3_6CHAN) {
+		warn_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int df4_get_intlv_mode(struct addr_ctx *ctx)
+{
+	ctx->map.intlv_mode = FIELD_GET(DF4_INTLV_NUM_CHAN, ctx->map.intlv);
+
+	if (ctx->map.intlv_mode == DF3_COD4_2CHAN_HASH ||
+	    ctx->map.intlv_mode == DF3_COD2_4CHAN_HASH ||
+	    ctx->map.intlv_mode == DF3_COD1_8CHAN_HASH ||
+	    ctx->map.intlv_mode == DF3_6CHAN) {
+		warn_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int df4p5_get_intlv_mode(struct addr_ctx *ctx)
+{
+	ctx->map.intlv_mode = FIELD_GET(DF4p5_INTLV_NUM_CHAN, ctx->map.intlv);
+
+	if (ctx->map.intlv_mode <= NOHASH_32CHAN)
+		return 0;
+
+	/*
+	 * Modes matching the ranges above are returned as-is.
+	 *
+	 * All other modes are "fixed up" by adding 20h to make a unique value.
+	 */
+	ctx->map.intlv_mode += 0x20;
+
+	return 0;
+}
+
+/*
+ * Some, but not all, cases have asserts.
+ * So use return values to indicate failure where needed.
+ */
+static int get_intlv_mode(struct addr_ctx *ctx)
+{
+	switch (df_cfg.rev) {
+	case DF2:	return df2_get_intlv_mode(ctx);
+	case DF3:	return df3_get_intlv_mode(ctx);
+	case DF3p5:	return df3p5_get_intlv_mode(ctx);
+	case DF4:	return df4_get_intlv_mode(ctx);
+	case DF4p5:	return df4p5_get_intlv_mode(ctx);
+	default:
+			warn_on_bad_df_rev();
+			return -EINVAL;
+	}
+}
+
+static u64 get_hi_addr_offset(u32 reg_dram_offset)
+{
+	u8 shift = DF_DRAM_BASE_LIMIT_LSB;
+	u64 hi_addr_offset = 0;
+
+	switch (df_cfg.rev) {
+	case DF2:
+		hi_addr_offset = FIELD_GET(DF2_HI_ADDR_OFFSET, reg_dram_offset);
+		break;
+	case DF3:
+	case DF3p5:
+		hi_addr_offset = FIELD_GET(DF3_HI_ADDR_OFFSET, reg_dram_offset);
+		break;
+	case DF4:
+	case DF4p5:
+		hi_addr_offset = FIELD_GET(DF4_HI_ADDR_OFFSET, reg_dram_offset);
+		break;
+	default:
+		warn_on_bad_df_rev();
+	}
+
+	return hi_addr_offset << shift;
+}
+
+static int get_dram_offset(struct addr_ctx *ctx, bool *enabled, u64 *norm_offset)
+{
+	u32 reg_dram_offset;
+	u8 map_num;
+
+	/* Should not be called for map 0. */
+	if (!ctx->map.num) {
+		warn_on_assert("Trying to find DRAM offset for map 0");
+		return -EINVAL;
+	}
+
+	/*
+	 * DramOffset registers don't exist for map 0, so the base register
+	 * actually refers to map 1.
+	 * Adjust the map_num for the register offsets.
+	 */
+	map_num = ctx->map.num - 1;
+
+	if (df_cfg.rev >= DF4) {
+		/* Read D18F7x140 (DramOffset) */
+		if (df_indirect_read_instance(ctx->node_id, 7, 0x140 + (4 * map_num),
+					      ctx->inst_id, &reg_dram_offset))
+			return -EINVAL;
+
+	} else {
+		/* Read D18F0x1B4 (DramOffset) */
+		if (df_indirect_read_instance(ctx->node_id, 0, 0x1B4 + (4 * map_num),
+					      ctx->inst_id, &reg_dram_offset))
+			return -EINVAL;
+	}
+
+	if (!FIELD_GET(DF_HI_ADDR_OFFSET_EN, reg_dram_offset))
+		return 0;
+
+	*enabled = true;
+	*norm_offset = get_hi_addr_offset(reg_dram_offset);
+
+	return 0;
+}
+
+static int df3_6ch_get_dram_addr_map(struct addr_ctx *ctx)
+{
+	u16 dst_fabric_id = FIELD_GET(DF3_DST_FABRIC_ID, ctx->map.limit);
+	u8 i, j, shift = 4, mask = 0xF;
+	u32 reg, offset = 0x60;
+	u16 dst_node_id;
+
+	/* Get Socket 1 register. */
+	if (dst_fabric_id & df_cfg.socket_id_mask)
+		offset = 0x68;
+
+	/* Read D18F0x06{0,8} (DF::Skt0CsTargetRemap0)/(DF::Skt0CsTargetRemap1) */
+	if (df_indirect_read_broadcast(ctx->node_id, 0, offset, &reg))
+		return -EINVAL;
+
+	/* Save 8 remap entries. */
+	for (i = 0, j = 0; i < 8; i++, j++)
+		ctx->map.remap_array[i] = (reg >> (j * shift)) & mask;
+
+	dst_node_id = dst_fabric_id & df_cfg.node_id_mask;
+	dst_node_id >>= df_cfg.node_id_shift;
+
+	/* Read D18F2x090 (DF::Np2ChannelConfig) */
+	if (df_indirect_read_broadcast(dst_node_id, 2, 0x90, &reg))
+		return -EINVAL;
+
+	ctx->map.np2_bits = FIELD_GET(DF_LOG2_ADDR_64K_SPACE0, reg);
+	return 0;
+}
+
+static int df2_get_dram_addr_map(struct addr_ctx *ctx)
+{
+	/* Read D18F0x110 (DramBaseAddress). */
+	if (df_indirect_read_instance(ctx->node_id, 0, 0x110 + (8 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.base))
+		return -EINVAL;
+
+	/* Read D18F0x114 (DramLimitAddress). */
+	if (df_indirect_read_instance(ctx->node_id, 0, 0x114 + (8 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.limit))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int df3_get_dram_addr_map(struct addr_ctx *ctx)
+{
+	if (df2_get_dram_addr_map(ctx))
+		return -EINVAL;
+
+	/* Read D18F0x3F8 (DfGlobalCtl). */
+	if (df_indirect_read_instance(ctx->node_id, 0, 0x3F8,
+				      ctx->inst_id, &ctx->map.ctl))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int df4_get_dram_addr_map(struct addr_ctx *ctx)
+{
+	u8 remap_sel, i, j, shift = 4, mask = 0xF;
+	u32 remap_reg;
+
+	/* Read D18F7xE00 (DramBaseAddress). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0xE00 + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.base))
+		return -EINVAL;
+
+	/* Read D18F7xE04 (DramLimitAddress). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0xE04 + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.limit))
+		return -EINVAL;
+
+	/* Read D18F7xE08 (DramAddressCtl). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0xE08 + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.ctl))
+		return -EINVAL;
+
+	/* Read D18F7xE0C (DramAddressIntlv). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0xE0C + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.intlv))
+		return -EINVAL;
+
+	/* Check if Remap Enable bit is valid. */
+	if (!FIELD_GET(DF4_REMAP_EN, ctx->map.ctl))
+		return 0;
+
+	/* Fill with bogus values, because '0' is a valid value. */
+	memset(&ctx->map.remap_array, 0xFF, sizeof(ctx->map.remap_array));
+
+	/* Get Remap registers. */
+	remap_sel = FIELD_GET(DF4_REMAP_SEL, ctx->map.ctl);
+
+	/* Read D18F7x180 (CsTargetRemap0A). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x180 + (8 * remap_sel),
+				      ctx->inst_id, &remap_reg))
+		return -EINVAL;
+
+	/* Save first 8 remap entries. */
+	for (i = 0, j = 0; i < 8; i++, j++)
+		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
+
+	/* Read D18F7x184 (CsTargetRemap0B). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x184 + (8 * remap_sel),
+				      ctx->inst_id, &remap_reg))
+		return -EINVAL;
+
+	/* Save next 8 remap entries. */
+	for (i = 8, j = 0; i < 16; i++, j++)
+		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
+
+	return 0;
+}
+
+static int df4p5_get_dram_addr_map(struct addr_ctx *ctx)
+{
+	u8 remap_sel, i, j, shift = 5, mask = 0x1F;
+	u32 remap_reg;
+
+	/* Read D18F7x200 (DramBaseAddress). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x200 + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.base))
+		return -EINVAL;
+
+	/* Read D18F7x204 (DramLimitAddress). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x204 + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.limit))
+		return -EINVAL;
+
+	/* Read D18F7x208 (DramAddressCtl). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x208 + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.ctl))
+		return -EINVAL;
+
+	/* Read D18F7x20C (DramAddressIntlv). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x20C + (16 * ctx->map.num),
+				      ctx->inst_id, &ctx->map.intlv))
+		return -EINVAL;
+
+	/* Check if Remap Enable bit is valid. */
+	if (!FIELD_GET(DF4_REMAP_EN, ctx->map.ctl))
+		return 0;
+
+	/* Fill with bogus values, because '0' is a valid value. */
+	memset(&ctx->map.remap_array, 0xFF, sizeof(ctx->map.remap_array));
+
+	/* Get Remap registers. */
+	remap_sel = FIELD_GET(DF4_REMAP_SEL, ctx->map.ctl);
+
+	/* Read D18F7x180 (CsTargetRemap0A). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x180 + (24 * remap_sel),
+				      ctx->inst_id, &remap_reg))
+		return -EINVAL;
+
+	/* Save first 6 remap entries. */
+	for (i = 0, j = 0; i < 6; i++, j++)
+		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
+
+	/* Read D18F7x184 (CsTargetRemap0B). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x184 + (24 * remap_sel),
+				      ctx->inst_id, &remap_reg))
+		return -EINVAL;
+
+	/* Save next 6 remap entries. */
+	for (i = 6, j = 0; i < 12; i++, j++)
+		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
+
+	/* Read D18F7x188 (CsTargetRemap0C). */
+	if (df_indirect_read_instance(ctx->node_id, 7, 0x188 + (24 * remap_sel),
+				      ctx->inst_id, &remap_reg))
+		return -EINVAL;
+
+	/* Save next 6 remap entries. */
+	for (i = 12, j = 0; i < 18; i++, j++)
+		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
+
+	return 0;
+}
+
+static int get_dram_addr_map(struct addr_ctx *ctx)
+{
+	switch (df_cfg.rev) {
+	case DF2:	return df2_get_dram_addr_map(ctx);
+	case DF3:
+	case DF3p5:	return df3_get_dram_addr_map(ctx);
+	case DF4:	return df4_get_dram_addr_map(ctx);
+	case DF4p5:	return df4p5_get_dram_addr_map(ctx);
+	default:
+			warn_on_bad_df_rev();
+			return -EINVAL;
+	}
+}
+
+static int lookup_cs_fabric_id(struct addr_ctx *ctx)
+{
+	u32 reg;
+
+	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
+	if (df_indirect_read_instance(ctx->node_id, 0, 0x50, ctx->inst_id, &reg))
+		return -EINVAL;
+
+	if (df_cfg.rev < DF4p5)
+		ctx->cs_fabric_id = FIELD_GET(DF2_CS_FABRIC_ID, reg);
+	else
+		ctx->cs_fabric_id = FIELD_GET(DF4p5_CS_FABRIC_ID, reg);
+
+	return 0;
+}
+
+static int get_cs_fabric_id(struct addr_ctx *ctx)
+{
+	return lookup_cs_fabric_id(ctx);
+}
+
+static int find_normalized_offset(struct addr_ctx *ctx, u64 *norm_offset)
+{
+	u64 last_offset = 0;
+	bool enabled;
+
+	for (ctx->map.num = 1; ctx->map.num < df_cfg.num_cs_maps; ctx->map.num++) {
+		enabled = false;
+
+		if (get_dram_offset(ctx, &enabled, norm_offset))
+			return -EINVAL;
+
+		/* Continue search if this map's offset is not enabled. */
+		if (!enabled)
+			continue;
+
+		/* Enabled offsets should never be 0. */
+		if (*norm_offset == 0) {
+			warn_on_assert("Enabled map %u offset is 0", ctx->map.num);
+			return -EINVAL;
+		}
+
+		/* Offsets should always increase from one map to the next. */
+		if (*norm_offset <= last_offset) {
+			warn_on_assert("Map %u offset (0x%016llx) <= previous (0x%016llx)",
+				       ctx->map.num, *norm_offset, last_offset);
+			return -EINVAL;
+		}
+
+		/* Match if this map's offset is less than the current calculated address. */
+		if (ctx->ret_addr >= *norm_offset)
+			break;
+
+		last_offset = *norm_offset;
+	}
+
+	/*
+	 * Finished search without finding a match.
+	 * Reset to map 0 and no offset.
+	 */
+	if (ctx->map.num >= df_cfg.num_cs_maps) {
+		ctx->map.num = 0;
+		*norm_offset = 0;
+	}
+
+	return 0;
+}
+
+static bool valid_map(struct addr_ctx *ctx)
+{
+	if (df_cfg.rev >= DF4)
+		return FIELD_GET(DF_ADDR_RANGE_VAL, ctx->map.ctl);
+
+	return FIELD_GET(DF_ADDR_RANGE_VAL, ctx->map.base);
+}
+
+static int get_address_map_common(struct addr_ctx *ctx)
+{
+	u64 norm_offset = 0;
+
+	if (get_cs_fabric_id(ctx))
+		return -EINVAL;
+
+	if (find_normalized_offset(ctx, &norm_offset))
+		return -EINVAL;
+
+	if (get_dram_addr_map(ctx))
+		return -EINVAL;
+
+	if (!valid_map(ctx))
+		return -EINVAL;
+
+	ctx->ret_addr -= norm_offset;
+
+	return 0;
+}
+
+static u8 get_num_intlv_chan(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case NONE:
+		return 1;
+	case NOHASH_2CHAN:
+	case DF2_2CHAN_HASH:
+	case DF3_COD4_2CHAN_HASH:
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+		return 2;
+	case DF4_NPS4_3CHAN_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+		return 3;
+	case NOHASH_4CHAN:
+	case DF3_COD2_4CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4p5_NPS2_4CHAN_1K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+		return 4;
+	case DF4_NPS2_5CHAN_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		return 5;
+	case DF3_6CHAN:
+	case DF4_NPS2_6CHAN_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+		return 6;
+	case NOHASH_8CHAN:
+	case DF3_COD1_8CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+	case DF4p5_NPS1_8CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+		return 8;
+	case DF4_NPS1_10CHAN_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		return 10;
+	case DF4_NPS1_12CHAN_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		return 12;
+	case NOHASH_16CHAN:
+	case DF4p5_NPS1_16CHAN_1K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		return 16;
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		return 24;
+	case NOHASH_32CHAN:
+		return 32;
+	default:
+		warn_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+}
+
+static void calculate_intlv_bits(struct addr_ctx *ctx)
+{
+	ctx->map.num_intlv_chan = get_num_intlv_chan(ctx);
+
+	ctx->map.total_intlv_chan = ctx->map.num_intlv_chan;
+	ctx->map.total_intlv_chan *= ctx->map.num_intlv_dies;
+	ctx->map.total_intlv_chan *= ctx->map.num_intlv_sockets;
+
+	/*
+	 * Get the number of bits needed to cover this many channels.
+	 * order_base_2() rounds up automatically.
+	 */
+	ctx->map.total_intlv_bits = order_base_2(ctx->map.total_intlv_chan);
+}
+
+static u8 get_intlv_bit_pos(struct addr_ctx *ctx)
+{
+	u8 addr_sel = 0;
+
+	switch (df_cfg.rev) {
+	case DF2:
+		addr_sel = FIELD_GET(DF2_INTLV_ADDR_SEL, ctx->map.base);
+		break;
+	case DF3:
+	case DF3p5:
+		addr_sel = FIELD_GET(DF3_INTLV_ADDR_SEL, ctx->map.base);
+		break;
+	case DF4:
+	case DF4p5:
+		addr_sel = FIELD_GET(DF4_INTLV_ADDR_SEL, ctx->map.intlv);
+		break;
+	default:
+		warn_on_bad_df_rev();
+		break;
+	}
+
+	/* Add '8' to get the 'interleave bit position'. */
+	return addr_sel + 8;
+}
+
+static u8 get_num_intlv_dies(struct addr_ctx *ctx)
+{
+	u8 dies = 0;
+
+	switch (df_cfg.rev) {
+	case DF2:
+		dies = FIELD_GET(DF2_INTLV_NUM_DIES, ctx->map.limit);
+		break;
+	case DF3:
+		dies = FIELD_GET(DF3_INTLV_NUM_DIES, ctx->map.base);
+		break;
+	case DF3p5:
+		dies = FIELD_GET(DF3p5_INTLV_NUM_DIES, ctx->map.base);
+		break;
+	case DF4:
+	case DF4p5:
+		dies = FIELD_GET(DF4_INTLV_NUM_DIES, ctx->map.intlv);
+		break;
+	default:
+		warn_on_bad_df_rev();
+		break;
+	}
+
+	/* Register value is log2, e.g. 0 -> 1 die, 1 -> 2 dies, etc. */
+	return 1 << dies;
+}
+
+static u8 get_num_intlv_sockets(struct addr_ctx *ctx)
+{
+	u8 sockets = 0;
+
+	switch (df_cfg.rev) {
+	case DF2:
+		sockets = FIELD_GET(DF2_INTLV_NUM_SOCKETS, ctx->map.limit);
+		break;
+	case DF3:
+	case DF3p5:
+		sockets = FIELD_GET(DF2_INTLV_NUM_SOCKETS, ctx->map.base);
+		break;
+	case DF4:
+	case DF4p5:
+		sockets = FIELD_GET(DF4_INTLV_NUM_SOCKETS, ctx->map.intlv);
+		break;
+	default:
+		warn_on_bad_df_rev();
+		break;
+	}
+
+	/* Register value is log2, e.g. 0 -> 1 sockets, 1 -> 2 sockets, etc. */
+	return 1 << sockets;
+}
+
+static int get_global_map_data(struct addr_ctx *ctx)
+{
+	if (get_intlv_mode(ctx))
+		return -EINVAL;
+
+	if (ctx->map.intlv_mode == DF3_6CHAN &&
+	    df3_6ch_get_dram_addr_map(ctx))
+		return -EINVAL;
+
+	ctx->map.intlv_bit_pos		= get_intlv_bit_pos(ctx);
+	ctx->map.num_intlv_dies		= get_num_intlv_dies(ctx);
+	ctx->map.num_intlv_sockets	= get_num_intlv_sockets(ctx);
+	calculate_intlv_bits(ctx);
+
+	return 0;
+}
+
+static void dump_address_map(struct dram_addr_map *map)
+{
+	u8 i;
+
+	pr_debug("intlv_mode=0x%x",		map->intlv_mode);
+	pr_debug("num=0x%x",			map->num);
+	pr_debug("base=0x%x",			map->base);
+	pr_debug("limit=0x%x",			map->limit);
+	pr_debug("ctl=0x%x",			map->ctl);
+	pr_debug("intlv=0x%x",			map->intlv);
+
+	for (i = 0; i < MAX_CS_CHANNELS; i++)
+		pr_debug("remap_array[%u]=0x%x", i, map->remap_array[i]);
+
+	pr_debug("intlv_bit_pos=%u",		map->intlv_bit_pos);
+	pr_debug("num_intlv_chan=%u",		map->num_intlv_chan);
+	pr_debug("num_intlv_dies=%u",		map->num_intlv_dies);
+	pr_debug("num_intlv_sockets=%u",	map->num_intlv_sockets);
+	pr_debug("total_intlv_chan=%u",		map->total_intlv_chan);
+	pr_debug("total_intlv_bits=%u",		map->total_intlv_bits);
+}
+
+int get_address_map(struct addr_ctx *ctx)
+{
+	int ret = 0;
+
+	ret = get_address_map_common(ctx);
+	if (ret)
+		return ret;
+
+	if (get_global_map_data(ctx))
+		return -EINVAL;
+
+	dump_address_map(&ctx->map);
+
+	return ret;
+}
diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
new file mode 100644
index 000000000000..d48470e12498
--- /dev/null
+++ b/drivers/ras/amd/atl/reg_fields.h
@@ -0,0 +1,603 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Address Translation Library
+ *
+ * reg_fields.h : Register field definitions
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+/*
+ * Notes on naming:
+ * 1) Use "DF_" prefix for fields that are the same for all revisions.
+ * 2) Use "DFx_" prefix for fields that differ between revisions.
+ *	a) "x" is the first major revision where the new field appears.
+ *	b) E.g., if DF2 and DF3 have the same field, then call it DF2.
+ *	c) E.g., if DF3p5 and DF4 have the same field, then call it DF4.
+ */
+
+/*
+ * Coherent Station Fabric ID
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x50 [Fabric Block Instance Information 3]
+ *	DF2	BlockFabricId	[19:8]
+ *	DF3	BlockFabricId	[19:8]
+ *	DF3p5	BlockFabricId	[19:8]
+ *	DF4	BlockFabricId	[19:8]
+ *	DF4p5	BlockFabricId	[15:8]
+ */
+#define DF2_CS_FABRIC_ID	GENMASK(19, 8)
+#define DF4p5_CS_FABRIC_ID	GENMASK(15, 8)
+
+/*
+ * Component ID Mask
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *
+ *	D18F1x208 [System Fabric ID Mask 0]
+ *	DF3	ComponentIdMask	[9:0]
+ *
+ *	D18F1x150 [System Fabric ID Mask 0]
+ *	DF3p5	ComponentIdMask	[15:0]
+ *
+ *	D18F4x1B0 [System Fabric ID Mask 0]
+ *	DF4	ComponentIdMask	[15:0]
+ *	DF4p5	ComponentIdMask	[15:0]
+ */
+#define DF3_COMPONENT_ID_MASK	GENMASK(9, 0)
+#define DF4_COMPONENT_ID_MASK	GENMASK(15, 0)
+
+/*
+ * Destination Fabric ID
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x114 [DRAM Limit Address]
+ *	DF2	DstFabricID	[7:0]
+ *	DF3	DstFabricID	[9:0]
+ *	DF3	DstFabricID	[11:0]
+ *
+ *	D18F7xE08 [DRAM Address Control]
+ *	DF4	DstFabricID	[27:16]
+ *
+ *	D18F7x208 [DRAM Address Control]
+ *	DF4p5	DstFabricID	[23:16]
+ */
+#define DF2_DST_FABRIC_ID	GENMASK(7, 0)
+#define DF3_DST_FABRIC_ID	GENMASK(9, 0)
+#define DF3p5_DST_FABRIC_ID	GENMASK(11, 0)
+#define DF4_DST_FABRIC_ID	GENMASK(27, 16)
+#define DF4p5_DST_FABRIC_ID	GENMASK(23, 16)
+
+/*
+ * Die ID Mask
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F1x208 [System Fabric ID Mask]
+ *	DF2	DieIdMask	[15:8]
+ *
+ *	D18F1x20C [System Fabric ID Mask 1]
+ *	DF3	DieIdMask	[18:16]
+ *
+ *	D18F1x158 [System Fabric ID Mask 2]
+ *	DF3p5	DieIdMask	[15:0]
+ *
+ *	D18F4x1B8 [System Fabric ID Mask 2]
+ *	DF4	DieIdMask	[15:0]
+ *	DF4p5	DieIdMask	[15:0]
+ */
+#define DF2_DIE_ID_MASK		GENMASK(15, 8)
+#define DF3_DIE_ID_MASK		GENMASK(18, 16)
+#define DF4_DIE_ID_MASK		GENMASK(15, 0)
+
+/*
+ * Die ID Shift
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F1x208 [System Fabric ID Mask]
+ *	DF2	DieIdShift	[27:24]
+ *
+ *	DF3	N/A
+ *	DF3p5	N/A
+ *	DF4	N/A
+ *	DF4p5	N/A
+ */
+#define DF2_DIE_ID_SHIFT	GENMASK(27, 24)
+
+/*
+ * DRAM Address Range Valid
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF2	AddrRngVal	[0]
+ *	DF3	AddrRngVal	[0]
+ *	DF3p5	AddrRngVal	[0]
+ *
+ *	D18F7xE08 [DRAM Address Control]
+ *	DF4	AddrRngVal	[0]
+ *
+ *	D18F7x208 [DRAM Address Control]
+ *	DF4p5	AddrRngVal	[0]
+ */
+#define DF_ADDR_RANGE_VAL	BIT(0)
+
+/*
+ * DRAM Base Address
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF2	DramBaseAddr	[31:12]
+ *	DF3	DramBaseAddr	[31:12]
+ *	DF3p5	DramBaseAddr	[31:12]
+ *
+ *	D18F7xE00 [DRAM Base Address]
+ *	DF4	DramBaseAddr	[27:0]
+ *
+ *	D18F7x200 [DRAM Base Address]
+ *	DF4p5	DramBaseAddr	[27:0]
+ */
+#define DF2_BASE_ADDR		GENMASK(31, 12)
+#define DF4_BASE_ADDR		GENMASK(27, 0)
+
+/*
+ * DRAM Hole Base
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x104 [DRAM Hole Control]
+ *	DF2	DramHoleBase	[31:24]
+ *	DF3	DramHoleBase	[31:24]
+ *	DF3p5	DramHoleBase	[31:24]
+ *
+ *	D18F7x104 [DRAM Hole Control]
+ *	DF4	DramHoleBase	[31:24]
+ *	DF4p5	DramHoleBase	[31:24]
+ */
+#define DF_DRAM_HOLE_BASE_MASK	GENMASK(31, 24)
+
+/*
+ * DRAM Limit Address
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x114 [DRAM Limit Address]
+ *	DF2	DramLimitAddr	[31:12]
+ *	DF3	DramLimitAddr	[31:12]
+ *	DF3p5	DramLimitAddr	[31:12]
+ *
+ *	D18F7xE04 [DRAM Limit Address]
+ *	DF4	DramLimitAddr	[27:0]
+ *
+ *	D18F7x204 [DRAM Limit Address]
+ *	DF4p5	DramLimitAddr	[27:0]
+ */
+#define DF2_DRAM_LIMIT_ADDR	GENMASK(31, 12)
+#define DF4_DRAM_LIMIT_ADDR	GENMASK(27, 0)
+
+/*
+ * Hash Interleave Controls
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *
+ *	D18F0x3F8 [DF Global Control]
+ *	DF3	GlbHashIntlvCtl64K	[20]
+ *		GlbHashIntlvCtl2M	[21]
+ *		GlbHashIntlvCtl1G	[22]
+ *
+ *	DF3p5	GlbHashIntlvCtl64K	[20]
+ *		GlbHashIntlvCtl2M	[21]
+ *		GlbHashIntlvCtl1G	[22]
+ *
+ *	D18F7xE08 [DRAM Address Control]
+ *	DF4	HashIntlvCtl64K		[8]
+ *		HashIntlvCtl2M		[9]
+ *		HashIntlvCtl1G		[10]
+ *
+ *	D18F7x208 [DRAM Address Control]
+ *	DF4p5	HashIntlvCtl4K		[7]
+ *		HashIntlvCtl64K		[8]
+ *		HashIntlvCtl2M		[9]
+ *		HashIntlvCtl1G		[10]
+ *		HashIntlvCtl1T		[15]
+ */
+#define DF3_HASH_CTL_64K		BIT(20)
+#define DF3_HASH_CTL_2M			BIT(21)
+#define DF3_HASH_CTL_1G			BIT(22)
+#define DF4_HASH_CTL_4K			BIT(7)
+#define DF4_HASH_CTL_64K		BIT(8)
+#define DF4_HASH_CTL_2M			BIT(9)
+#define DF4_HASH_CTL_1G			BIT(10)
+#define DF4_HASH_CTL_1T			BIT(15)
+
+/*
+ * High Address Offset
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x1B4 [DRAM Offset]
+ *	DF2	HiAddrOffset	[31:20]
+ *	DF3	HiAddrOffset	[31:12]
+ *	DF3p5	HiAddrOffset	[31:12]
+ *
+ *	D18F7x140 [DRAM Offset]
+ *	DF4	HiAddrOffset	[24:1]
+ *	DF4p5	HiAddrOffset	[24:1]
+ */
+#define DF2_HI_ADDR_OFFSET	GENMASK(31, 20)
+#define DF3_HI_ADDR_OFFSET	GENMASK(31, 12)
+#define DF4_HI_ADDR_OFFSET	GENMASK(24, 1)
+
+/*
+ * High Address Offset Enable
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x1B4 [DRAM Offset]
+ *	DF2	HiAddrOffsetEn	[0]
+ *	DF3	HiAddrOffsetEn	[0]
+ *	DF3p5	HiAddrOffsetEn	[0]
+ *
+ *	D18F7x140 [DRAM Offset]
+ *	DF4	HiAddrOffsetEn	[0]
+ *	DF4p5	HiAddrOffsetEn	[0]
+ */
+#define DF_HI_ADDR_OFFSET_EN	BIT(0)
+
+/*
+ * Interleave Address Select
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF2	IntLvAddrSel	[10:8]
+ *	DF3	IntLvAddrSel	[11:9]
+ *	DF3p5	IntLvAddrSel	[11:9]
+ *
+ *	D18F7xE0C [DRAM Address Interleave]
+ *	DF4	IntLvAddrSel	[2:0]
+ *
+ *	D18F7x20C [DRAM Address Interleave]
+ *	DF4p5	IntLvAddrSel	[2:0]
+ */
+#define DF2_INTLV_ADDR_SEL	GENMASK(10, 8)
+#define DF3_INTLV_ADDR_SEL	GENMASK(11, 9)
+#define DF4_INTLV_ADDR_SEL	GENMASK(2, 0)
+
+/*
+ * Interleave Number of Channels
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF2	IntLvNumChan	[7:4]
+ *	DF3	IntLvNumChan	[5:2]
+ *	DF3p5	IntLvNumChan	[6:2]
+ *
+ *	D18F7xE0C [DRAM Address Interleave]
+ *	DF4	IntLvNumChan	[8:4]
+ *
+ *	D18F7x20C [DRAM Address Interleave]
+ *	DF4p5	IntLvNumChan	[9:4]
+ */
+#define DF2_INTLV_NUM_CHAN	GENMASK(7, 4)
+#define DF3_INTLV_NUM_CHAN	GENMASK(5, 2)
+#define DF3p5_INTLV_NUM_CHAN	GENMASK(6, 2)
+#define DF4_INTLV_NUM_CHAN	GENMASK(8, 4)
+#define DF4p5_INTLV_NUM_CHAN	GENMASK(9, 4)
+
+/*
+ * Interleave Number of Dies
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x114 [DRAM Limit Address]
+ *	DF2	IntLvNumDies	[11:10]
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF3	IntLvNumDies	[7:6]
+ *	DF3p5	IntLvNumDies	[7]
+ *
+ *	D18F7xE0C [DRAM Address Interleave]
+ *	DF4	IntLvNumDies	[13:12]
+ *
+ *	D18F7x20C [DRAM Address Interleave]
+ *	DF4p5	IntLvNumDies	[13:12]
+ */
+#define DF2_INTLV_NUM_DIES	GENMASK(11, 10)
+#define DF3_INTLV_NUM_DIES	GENMASK(7, 6)
+#define DF3p5_INTLV_NUM_DIES	BIT(7)
+#define DF4_INTLV_NUM_DIES	GENMASK(13, 12)
+
+/*
+ * Interleave Number of Sockets
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x114 [DRAM Limit Address]
+ *	DF2	IntLvNumSockets	[8]
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF3	IntLvNumSockets	[8]
+ *	DF3p5	IntLvNumSockets	[8]
+ *
+ *	D18F7xE0C [DRAM Address Interleave]
+ *	DF4	IntLvNumSockets	[18]
+ *
+ *	D18F7x20C [DRAM Address Interleave]
+ *	DF4p5	IntLvNumSockets	[18]
+ */
+#define DF2_INTLV_NUM_SOCKETS	BIT(8)
+#define DF4_INTLV_NUM_SOCKETS	BIT(18)
+
+/*
+ * Legacy MMIO Hole Enable
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x110 [DRAM Base Address]
+ *	DF2	LgcyMmioHoleEn	[1]
+ *	DF3	LgcyMmioHoleEn	[1]
+ *	DF3p5	LgcyMmioHoleEn	[1]
+ *
+ *	D18F7xE08 [DRAM Address Control]
+ *	DF4	LgcyMmioHoleEn	[1]
+ *
+ *	D18F7x208 [DRAM Address Control]
+ *	DF4p5	LgcyMmioHoleEn	[1]
+ */
+#define DF_LEGACY_MMIO_HOLE_EN	BIT(1)
+
+/*
+ * Log2 Address 64K Space 0
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname		Bits
+ *
+ *	DF2	N/A
+ *
+ *	D18F2x90 [Non-power-of-2 channel Configuration Register for CS DRAM Address Maps]
+ *	DF3	Log2Addr64KSpace0	[5:0]
+ *
+ *	DF3p5	N/A
+ *	DF4	N/A
+ *	DF4p5	N/A
+ */
+#define DF_LOG2_ADDR_64K_SPACE0		GENMASK(5, 0)
+
+/*
+ * Major Revision
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *	DF3	N/A
+ *	DF3p5	N/A
+ *
+ *	D18F0x040 [Fabric Block Instance Count]
+ *	DF4	MajorRevision	[27:24]
+ *	DF4p5	MajorRevision	[27:24]
+ */
+#define DF_MAJOR_REVISION	GENMASK(27, 24)
+
+/*
+ * Minor Revision
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *	DF3	N/A
+ *	DF3p5	N/A
+ *
+ *	D18F0x040 [Fabric Block Instance Count]
+ *	DF4	MinorRevision	[23:16]
+ *	DF4p5	MinorRevision	[23:16]
+ */
+#define DF_MINOR_REVISION	GENMASK(23, 16)
+
+/*
+ * Node ID Mask
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *
+ *	D18F1x208 [System Fabric ID Mask 0]
+ *	DF3	NodeIdMask	[25:16]
+ *
+ *	D18F1x150 [System Fabric ID Mask 0]
+ *	DF3p5	NodeIdMask	[31:16]
+ *
+ *	D18F4x1B0 [System Fabric ID Mask 0]
+ *	DF4	NodeIdMask	[31:16]
+ *	DF4p5	NodeIdMask	[31:16]
+ */
+#define DF3_NODE_ID_MASK	GENMASK(25, 16)
+#define DF4_NODE_ID_MASK	GENMASK(31, 16)
+
+/*
+ * Node ID Shift
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *
+ *	D18F1x20C [System Fabric ID Mask 1]
+ *	DF3	NodeIdShift	[3:0]
+ *
+ *	D18F1x154 [System Fabric ID Mask 1]
+ *	DF3p5	NodeIdShift	[3:0]
+ *
+ *	D18F4x1B4 [System Fabric ID Mask 1]
+ *	DF4	NodeIdShift	[3:0]
+ *	DF4p5	NodeIdShift	[3:0]
+ */
+#define DF3_NODE_ID_SHIFT	GENMASK(3, 0)
+
+/*
+ * Remap Enable
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *	DF3	N/A
+ *	DF3p5	N/A
+ *
+ *	D18F7xE08 [DRAM Address Control]
+ *	DF4	RemapEn		[4]
+ *
+ *	D18F7x208 [DRAM Address Control]
+ *	DF4p5	RemapEn		[4]
+ */
+#define DF4_REMAP_EN		BIT(4)
+
+/*
+ * Remap Select
+ *
+ * Access type: Instance
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	DF2	N/A
+ *	DF3	N/A
+ *	DF3p5	N/A
+ *
+ *	D18F7xE08 [DRAM Address Control]
+ *	DF4	RemapSel	[7:5]
+ *
+ *	D18F7x208 [DRAM Address Control]
+ *	DF4p5	RemapSel	[6:5]
+ */
+#define DF4_REMAP_SEL		GENMASK(7, 5)
+#define DF4p5_REMAP_SEL		GENMASK(6, 5)
+
+/*
+ * Socket ID Mask
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ * D18F1x208 [System Fabric ID Mask]
+ *	DF2	SocketIdMask	[23:16]
+ *
+ * D18F1x20C [System Fabric ID Mask 1]
+ *	DF3	SocketIdMask	[26:24]
+ *
+ * D18F1x158 [System Fabric ID Mask 2]
+ *	DF3p5	SocketIdMask	[31:16]
+ *
+ * D18F4x1B8 [System Fabric ID Mask 2]
+ *	DF4	SocketIdMask	[31:16]
+ *	DF4p5	SocketIdMask	[31:16]
+ */
+#define DF2_SOCKET_ID_MASK	GENMASK(23, 16)
+#define DF3_SOCKET_ID_MASK	GENMASK(26, 24)
+#define DF4_SOCKET_ID_MASK	GENMASK(31, 16)
+
+/*
+ * Socket ID Shift
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *		Rev	Fieldname	Bits
+ *
+ * D18F1x208 [System Fabric ID Mask]
+ *	DF2	SocketIdShift	[31:28]
+ *
+ * D18F1x20C [System Fabric ID Mask 1]
+ *	DF3	SocketIdShift	[9:8]
+ *
+ * D18F1x158 [System Fabric ID Mask 2]
+ *	DF3p5	SocketIdShift	[11:8]
+ *
+ * D18F4x1B4 [System Fabric ID Mask 1]
+ *	DF4	SocketIdShift	[11:8]
+ *	DF4p5	SocketIdShift	[11:8]
+ */
+#define DF2_SOCKET_ID_SHIFT	GENMASK(31, 28)
+#define DF3_SOCKET_ID_SHIFT	GENMASK(9, 8)
+#define DF4_SOCKET_ID_SHIFT	GENMASK(11, 8)
diff --git a/drivers/ras/amd/atl/stub.c b/drivers/ras/amd/atl/stub.c
new file mode 100644
index 000000000000..7f8b793ff56a
--- /dev/null
+++ b/drivers/ras/amd/atl/stub.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * stub.c : Minimal support code to be built-in.
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "stub.h"
+
+static DEFINE_MUTEX(amd_atl_ops_lock);
+
+static int default_convert_umc_na_to_spa(struct mce *m, u64 *sys_addr) { return -EINVAL; }
+
+static struct amd_atl_ops default_ops = {
+	.convert_umc_na_to_spa	= default_convert_umc_na_to_spa,
+};
+
+/*
+ * Kref goes to 0 when ATL module is unloaded.
+ * Switch back to default function pointers in this case.
+ */
+static void release_amd_atl_ops(struct kref *refcount)
+{
+	amd_atl_pvt.ops = &default_ops;
+}
+
+static void initialize_ops(struct amd_atl_ops *ops)
+{
+	mutex_lock(&amd_atl_ops_lock);
+	amd_atl_pvt.ops = ops;
+	kref_init(&amd_atl_pvt.refcount);
+	mutex_unlock(&amd_atl_ops_lock);
+}
+
+static void release_ops(void)
+{
+	mutex_lock(&amd_atl_ops_lock);
+	kref_put(&amd_atl_pvt.refcount, release_amd_atl_ops);
+	mutex_unlock(&amd_atl_ops_lock);
+}
+
+/* This private structure is exported solely for use by the AMD ATL module. */
+struct amd_atl_pvt amd_atl_pvt = {
+	.initialize	= initialize_ops,
+	.release	= release_ops,
+	.ops		= &default_ops,
+};
+EXPORT_SYMBOL_GPL(amd_atl_pvt);
+
+int amd_convert_umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
+{
+	int ret = -EINVAL;
+
+	mutex_lock(&amd_atl_ops_lock);
+
+	/* Kref only gets initialized when ATL module successfully loads. */
+	if (!kref_get_unless_zero(&amd_atl_pvt.refcount)) {
+		pr_warn("AMD Address Translation Library not enabled");
+		goto unlock;
+	}
+
+	mutex_unlock(&amd_atl_ops_lock);
+
+	ret = amd_atl_pvt.ops->convert_umc_na_to_spa(m, sys_addr);
+
+	mutex_lock(&amd_atl_ops_lock);
+	kref_put(&amd_atl_pvt.refcount, release_amd_atl_ops);
+
+unlock:
+	mutex_unlock(&amd_atl_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
diff --git a/drivers/ras/amd/atl/stub.h b/drivers/ras/amd/atl/stub.h
new file mode 100644
index 000000000000..ad07c46534e7
--- /dev/null
+++ b/drivers/ras/amd/atl/stub.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Address Translation Library
+ *
+ * stub.h : Common structs and defines used by library stub and module
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#ifndef __AMD_ATL_STUB_H__
+#define __AMD_ATL_STUB_H__
+
+#include <linux/kref.h>
+#include <linux/mutex.h>
+
+#include <asm/amd_atl.h>
+
+struct amd_atl_ops {
+	int (*convert_umc_na_to_spa)(struct mce *m, u64 *sys_addr);
+};
+
+struct amd_atl_pvt {
+	struct kref refcount;
+	void (*initialize)(struct amd_atl_ops *ops);
+	void (*release)(void);
+	struct amd_atl_ops *ops;
+};
+
+extern struct amd_atl_pvt amd_atl_pvt;
+
+#endif /* __AMD_ATL_STUB_H__ */
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
new file mode 100644
index 000000000000..63dd320d0758
--- /dev/null
+++ b/drivers/ras/amd/atl/system.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * system.c : Functions to read and save system-wide data
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "internal.h"
+
+int determine_node_id(struct addr_ctx *ctx, u8 socket_id, u8 die_id)
+{
+	u16 socket_id_bits, die_id_bits;
+
+	if (socket_id > 0 && df_cfg.socket_id_mask == 0) {
+		warn_on_assert("Invalid socket inputs: socket_id=%u socket_id_mask=0x%x",
+			       socket_id, df_cfg.socket_id_mask);
+		return -EINVAL;
+	}
+
+	/* Do each step independently to avoid shift out-of-bounds issues. */
+	socket_id_bits =	socket_id;
+	socket_id_bits <<=	df_cfg.socket_id_shift;
+	socket_id_bits &=	df_cfg.socket_id_mask;
+
+	if (die_id > 0 && df_cfg.die_id_mask == 0) {
+		warn_on_assert("Invalid die inputs: die_id=%u die_id_mask=0x%x",
+			       die_id, df_cfg.die_id_mask);
+		return -EINVAL;
+	}
+
+	/* Do each step independently to avoid shift out-of-bounds issues. */
+	die_id_bits =		die_id;
+	die_id_bits <<=		df_cfg.die_id_shift;
+	die_id_bits &=		df_cfg.die_id_mask;
+
+	ctx->node_id = (socket_id_bits | die_id_bits) >> df_cfg.node_id_shift;
+	return 0;
+}
+
+static void df2_get_masks_shifts(u32 mask0)
+{
+	df_cfg.socket_id_shift		= FIELD_GET(DF2_SOCKET_ID_SHIFT, mask0);
+	df_cfg.socket_id_mask		= FIELD_GET(DF2_SOCKET_ID_MASK, mask0);
+	df_cfg.die_id_shift		= FIELD_GET(DF2_DIE_ID_SHIFT, mask0);
+	df_cfg.die_id_mask		= FIELD_GET(DF2_DIE_ID_MASK, mask0);
+	df_cfg.node_id_shift		= df_cfg.die_id_shift;
+	df_cfg.node_id_mask		= df_cfg.socket_id_mask | df_cfg.die_id_mask;
+	df_cfg.component_id_mask	= ~df_cfg.node_id_mask;
+}
+
+static void df3_get_masks_shifts(u32 mask0, u32 mask1)
+{
+	df_cfg.component_id_mask	= FIELD_GET(DF3_COMPONENT_ID_MASK, mask0);
+	df_cfg.node_id_mask		= FIELD_GET(DF3_NODE_ID_MASK, mask0);
+
+	df_cfg.node_id_shift		= FIELD_GET(DF3_NODE_ID_SHIFT, mask1);
+	df_cfg.socket_id_shift		= FIELD_GET(DF3_SOCKET_ID_SHIFT, mask1);
+	df_cfg.socket_id_mask		= FIELD_GET(DF3_SOCKET_ID_MASK, mask1);
+	df_cfg.die_id_mask		= FIELD_GET(DF3_DIE_ID_MASK, mask1);
+}
+
+static void df3p5_get_masks_shifts(u32 mask0, u32 mask1, u32 mask2)
+{
+	df_cfg.component_id_mask	= FIELD_GET(DF4_COMPONENT_ID_MASK, mask0);
+	df_cfg.node_id_mask		= FIELD_GET(DF4_NODE_ID_MASK, mask0);
+
+	df_cfg.node_id_shift		= FIELD_GET(DF3_NODE_ID_SHIFT, mask1);
+	df_cfg.socket_id_shift		= FIELD_GET(DF4_SOCKET_ID_SHIFT, mask1);
+
+	df_cfg.socket_id_mask		= FIELD_GET(DF4_SOCKET_ID_MASK, mask2);
+	df_cfg.die_id_mask		= FIELD_GET(DF4_DIE_ID_MASK, mask2);
+}
+
+static void df4_get_masks_shifts(u32 mask0, u32 mask1, u32 mask2)
+{
+	df3p5_get_masks_shifts(mask0, mask1, mask2);
+
+	if (!(df_cfg.flags.socket_id_shift_quirk && df_cfg.socket_id_shift == 1))
+		return;
+
+	df_cfg.socket_id_shift	= 0;
+	df_cfg.socket_id_mask	= 1;
+	df_cfg.die_id_shift	= 0;
+	df_cfg.die_id_mask	= 0;
+	df_cfg.node_id_shift	= 8;
+	df_cfg.node_id_mask	= 0x100;
+}
+
+static int df4_get_fabric_id_mask_registers(void)
+{
+	u32 mask0, mask1, mask2;
+
+	/* Read D18F4x1B0 (SystemFabricIdMask0) */
+	if (df_indirect_read_broadcast(0, 4, 0x1B0, &mask0))
+		return -EINVAL;
+
+	/* Read D18F4x1B4 (SystemFabricIdMask1) */
+	if (df_indirect_read_broadcast(0, 4, 0x1B4, &mask1))
+		return -EINVAL;
+
+	/* Read D18F4x1B8 (SystemFabricIdMask2) */
+	if (df_indirect_read_broadcast(0, 4, 0x1B8, &mask2))
+		return -EINVAL;
+
+	df4_get_masks_shifts(mask0, mask1, mask2);
+	return 0;
+}
+
+static int df4_determine_df_rev(u32 reg)
+{
+	df_cfg.rev = FIELD_GET(DF_MINOR_REVISION, reg) < 5 ? DF4 : DF4p5;
+
+	/* Check for special cases or quirks based on Device/Vendor IDs.*/
+
+	/* Read D18F0x000 (DeviceVendorId0) */
+	if (df_indirect_read_broadcast(0, 0, 0, &reg))
+		return -EINVAL;
+
+	if (reg == DF_FUNC0_ID_ZEN4_SERVER)
+		df_cfg.flags.socket_id_shift_quirk = 1;
+
+	return df4_get_fabric_id_mask_registers();
+}
+
+static int determine_df_rev_legacy(void)
+{
+	u32 fabric_id_mask0, fabric_id_mask1, fabric_id_mask2;
+
+	/*
+	 * Check for DF3.5.
+	 *
+	 * Component ID Mask must be non-zero. Register D18F1x150 is
+	 * reserved pre-DF3.5, so value will be Read-as-Zero.
+	 */
+
+	/* Read D18F1x150 (SystemFabricIdMask0). */
+	if (df_indirect_read_broadcast(0, 1, 0x150, &fabric_id_mask0))
+		return -EINVAL;
+
+	if (FIELD_GET(DF4_COMPONENT_ID_MASK, fabric_id_mask0)) {
+		df_cfg.rev = DF3p5;
+
+		/* Read D18F1x154 (SystemFabricIdMask1) */
+		if (df_indirect_read_broadcast(0, 1, 0x154, &fabric_id_mask1))
+			return -EINVAL;
+
+		/* Read D18F1x158 (SystemFabricIdMask2) */
+		if (df_indirect_read_broadcast(0, 1, 0x158, &fabric_id_mask2))
+			return -EINVAL;
+
+		df3p5_get_masks_shifts(fabric_id_mask0, fabric_id_mask1, fabric_id_mask2);
+		return 0;
+	}
+
+	/*
+	 * Check for DF3.
+	 *
+	 * Component ID Mask must be non-zero. Field is Read-as-Zero on DF2.
+	 */
+
+	/* Read D18F1x208 (SystemFabricIdMask). */
+	if (df_indirect_read_broadcast(0, 1, 0x208, &fabric_id_mask0))
+		return -EINVAL;
+
+	if (FIELD_GET(DF3_COMPONENT_ID_MASK, fabric_id_mask0)) {
+		df_cfg.rev = DF3;
+
+		/* Read D18F1x20C (SystemFabricIdMask1) */
+		if (df_indirect_read_broadcast(0, 1, 0x20C, &fabric_id_mask1))
+			return -EINVAL;
+
+		df3_get_masks_shifts(fabric_id_mask0, fabric_id_mask1);
+		return 0;
+	}
+
+	/* Default to DF2. */
+	df_cfg.rev = DF2;
+	df2_get_masks_shifts(fabric_id_mask0);
+	return 0;
+}
+
+static int determine_df_rev(void)
+{
+	u32 reg;
+	u8 rev;
+
+	if (df_cfg.rev != UNKNOWN)
+		return 0;
+
+	/* Read D18F0x40 (FabricBlockInstanceCount). */
+	if (df_indirect_read_broadcast(0, 0, 0x40, &reg))
+		return -EINVAL;
+
+	/*
+	 * Revision fields added for DF4 and later.
+	 *
+	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
+	 */
+	rev = FIELD_GET(DF_MAJOR_REVISION, reg);
+	if (!rev)
+		return determine_df_rev_legacy();
+
+	/*
+	 * Fail out for major revisions other than '4'.
+	 *
+	 * Explicit support should be added for newer systems to avoid issues.
+	 */
+	if (rev == 4)
+		return df4_determine_df_rev(reg);
+
+	return -EINVAL;
+}
+
+static void get_num_maps(void)
+{
+	switch (df_cfg.rev) {
+	case DF2:
+	case DF3:
+	case DF3p5:
+		df_cfg.num_cs_maps	= 2;
+		break;
+	case DF4:
+		df_cfg.num_cs_maps	= 4;
+		break;
+	case DF4p5:
+		df_cfg.num_cs_maps	= 4;
+		break;
+	default:
+		warn_on_bad_df_rev();
+	}
+}
+
+static void apply_node_id_shift(void)
+{
+	if (df_cfg.rev == DF2)
+		return;
+
+	df_cfg.die_id_shift		= df_cfg.node_id_shift;
+	df_cfg.die_id_mask		<<= df_cfg.node_id_shift;
+	df_cfg.socket_id_mask		<<= df_cfg.node_id_shift;
+	df_cfg.socket_id_shift		+= df_cfg.node_id_shift;
+}
+
+static void dump_df_cfg(void)
+{
+	pr_debug("rev=0x%x",				df_cfg.rev);
+
+	pr_debug("component_id_mask=0x%x",		df_cfg.component_id_mask);
+	pr_debug("die_id_mask=0x%x",			df_cfg.die_id_mask);
+	pr_debug("node_id_mask=0x%x",			df_cfg.node_id_mask);
+	pr_debug("socket_id_mask=0x%x",			df_cfg.socket_id_mask);
+
+	pr_debug("die_id_shift=0x%x",			df_cfg.die_id_shift);
+	pr_debug("node_id_shift=0x%x",			df_cfg.node_id_shift);
+	pr_debug("socket_id_shift=0x%x",		df_cfg.socket_id_shift);
+
+	pr_debug("num_cs_maps=%u",			df_cfg.num_cs_maps);
+
+	pr_debug("flags.legacy_ficaa=%u",		df_cfg.flags.legacy_ficaa);
+	pr_debug("flags.socket_id_shift_quirk=%u",	df_cfg.flags.socket_id_shift_quirk);
+}
+
+int get_df_system_info(void)
+{
+	if (determine_df_rev()) {
+		pr_warn("amd_atl: Failed to determine DF Revision");
+		df_cfg.rev = UNKNOWN;
+		return -EINVAL;
+	}
+
+	apply_node_id_shift();
+
+	get_num_maps();
+
+	dump_df_cfg();
+
+	return 0;
+}
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
new file mode 100644
index 000000000000..af2ed33414bc
--- /dev/null
+++ b/drivers/ras/amd/atl/umc.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * umc.c : Unified Memory Controller (UMC) topology helpers
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include "internal.h"
+
+static u8 get_die_id(struct mce *m)
+{
+	/*
+	 * For CPUs, this is the AMD Node ID modulo the number
+	 * of AMD Nodes per socket.
+	 */
+	return topology_die_id(m->extcpu) % amd_get_nodes_per_socket();
+}
+
+#define UMC_CHANNEL_NUM	GENMASK(31, 20)
+static u8 get_cs_inst_id(struct mce *m)
+{
+	return FIELD_GET(UMC_CHANNEL_NUM, m->ipid);
+}
+
+int convert_umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
+{
+	u8 cs_inst_id = get_cs_inst_id(m);
+	u8 socket_id = m->socketid;
+	u8 die_id = get_die_id(m);
+	u64 addr = m->addr;
+
+	pr_debug("socket_id=0x%x die_id=0x%x cs_inst_id=0x%x addr=0x%016llx",
+		 socket_id, die_id, cs_inst_id, addr);
+
+	if (norm_to_sys_addr(socket_id, die_id, cs_inst_id, &addr))
+		return -EINVAL;
+
+	*sys_addr = addr;
+	return 0;
+}
-- 
2.34.1

