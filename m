Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246FB806844
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377080AbjLFHab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377077AbjLFHa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:30:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A54D40;
        Tue,  5 Dec 2023 23:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrJLVSgkCd17/lYisjWAiYEpksFfGsC9vg+9oEglgL+uO4Uys34EoiP8oNMOdb40/8sHjpqSv11GRvEyqLp8Ju0+VZYSP7FTiZE/gbtKRbDtSEuHob6Xe/r6AFDFmtK1MqzK3l/GkxqZ9uwWNZ97Nj3jncaB1Crz4yFVo4ibSMR7i1QPxCPxboC3CjBmQhGGKXNjA9RF9jgGvban4fl4DcqzK+HvH7UtoXlZphO/2Xj7UkhNM47+lWQO1RdD2dCgbx+rZD7GjN/v6Wv5bLeuQKuBUDStP7boY23ygPWkBFe9itx9mcc0kBBswJ0CKKgzKuo3DYrBdhbQ2ToIJJdXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl85AFPE8/aLHYct/7xBMH1XWzlfxhgzYwHe8w3RUo4=;
 b=VYVZFVX6jCg7TLA0hUiawdXYnfB37jY20sx8PLfZatntM+TAtgqCoV/dp7mhV+pc9um/+8I2hb/2k4i7aJKEmia/6esMVTU00hpaOqZhVNpJc4gCYzhRiITEcfJLEo9mVLFapDOPGslX/tNgbIu66Rr/TgZFrBhEUZUZYkzffYh0bRorwphoprqUxIBt7lyOMd2M2SliZ92rBls+PHjiZPknp5TBsA57dAbOJaNiAvjQOd/fDGM6Agh7WjL+9SE05nlUGObA4NHCX3CuctQXcKFzNmigUSrPJIBKAaK858MD7lAQEES/73fNczxfFc3IotmhTqyIcBTMrwWv0By+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl85AFPE8/aLHYct/7xBMH1XWzlfxhgzYwHe8w3RUo4=;
 b=2esMIbtlBkbE8KvhdYWMWtUqs2ZX/PxjeAN70HsT3bSxPMjPPmCM3oEuwGhg3QdjHb7Pr68NxJQ9I8hrnswogYDud1pqUfWxKBzcPQRd0fXI8dLVCuSppQn2tFST1rFIkle3NpFjy1njtp+ivTgKIOPEW+Pu/xKZJdFpuuavPGs=
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:30:30 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::8a) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 07:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:30:30 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:30:24 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
        Evan Quan <quanliangl@hotmail.com>
Subject: [PATCH v15 2/9] platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature
Date:   Wed, 6 Dec 2023 15:29:40 +0800
Message-ID: <20231206072947.1331729-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206072947.1331729-1-Jun.Ma2@amd.com>
References: <20231206072947.1331729-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4e9451-4985-4267-5c33-08dbf62d39bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJ2onYbvQuHB3mZubYgdyrdcDhaF/tY3l0NhM88LTmWlhENtmXvFQP+XEqD7ZN5/lnUhuG27BrDys1zEDjiycLc88IbCaMNM3Njjf9n0N5bZ7olw0cq103cJHpaoTxebq5oogEyvUiKzug+TSb6ts4Bbft7OFkjsUzQ+Zq004D/QUsZ8Qa4XX3f+ddsAwDkTc/H3W89JBhVkWIOh+SCW/ysiyZHGwmHzsMKVHrmghiP48gfSm4uUob/H336TQ8ULP108HZICqkFE0DFb4G4EpXOwnKXZSrLO5/xN5Q8pnJztZuxcxCE+aQQH+YGw5jUndd5gaMdLGpaXO65JOi3yRqvGIA6R59rLJim/CjdZmobdiryHoLgm85g6wpRGXV9B9de3q/n4czMTx+ojmQedJYQaTfJlClUty8NbM6V6k4/qcf4JYsmZlqwttqx6C5YCxCOAKihC14lAK+mnrloBJ/GglStkLr5zc7x44zRnedvyFOyICHndPqMwwtgPVsJnIk35d8+1Ba+KA6/5jmROs7WbCc6L8DEqUT7npHVUrKGB54Ts9ywI6n3X3hxjvRC901TjSKec64s4++N0sFLnwddba+XXN83N36ca+7Qf6SGoS9SdduJYYY0hYMeCVupmFGPkbkCWnEtRfyc6G9iJndMVrYUa83LibZ2T20LWa3rv/URIfRmNu5kyclmHjjPwFB/6S8BM3ycpOd58kEun7lumK6P9pPgk/LtIIeFwVD2kcT4x+OcpmZOD1pa9giHFPE86+tOl1rGCEk/fOYUsuON+4VywSzusfcHGbO8vmSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(40480700001)(36860700001)(32650700002)(356005)(921008)(7416002)(41300700001)(5660300002)(30864003)(82740400003)(2906002)(83380400001)(6666004)(1076003)(426003)(336012)(16526019)(81166007)(7696005)(26005)(2616005)(40460700003)(45080400002)(110136005)(478600001)(36756003)(70206006)(70586007)(8936002)(86362001)(4326008)(316002)(8676002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:30:30.4010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4e9451-4985-4267-5c33-08dbf62d39bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to electrical and mechanical constraints in certain platform designs
there may be likely interference of relatively high-powered harmonics of
the (G-)DDR memory clocks with local radio module frequency bands used
by Wifi 6/6e/7.

To mitigate this, AMD has introduced a mechanism that devices can use to
notify active use of particular frequencies so that other devices can make
relative internal adjustments as necessary to avoid this resonance.

Co-developed-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

--
v11:
 - fix typo(Simon)
v12:
 - Fix the code logic (Rafael)
 - Move amd_wbrf.c to drivers/platform/x86/amd/wbrf.c
 - Updated Evan's email because he's no longer at AMD.Thanks
for his work in earlier versions.
v13:
 - Fix the format issue (IIpo Jarvinen)
 - Add comment for some functions
v14:
 - Use the apci_check_dsm and acpi_evaluate_dsm (Hans de Goede)
v15:
 - Drop redundant functions and fix format issue (Hans de Goede)
 - Fix the compile error
---
 drivers/platform/x86/amd/Kconfig  |  14 ++
 drivers/platform/x86/amd/Makefile |   1 +
 drivers/platform/x86/amd/wbrf.c   | 317 ++++++++++++++++++++++++++++++
 include/linux/acpi_amd_wbrf.h     |  91 +++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index 55f3a2fc6aec..54753213cc61 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -18,3 +18,17 @@ config AMD_HSMP
 
 	  If you choose to compile this driver as a module the module will be
 	  called amd_hsmp.
+
+config AMD_WBRF
+	bool "AMD Wifi RF Band mitigations (WBRF)"
+	depends on ACPI
+	help
+	  WBRF(Wifi Band RFI mitigation) mechanism allows Wifi drivers
+	  to notify the frequencies they are using so that other hardware
+	  can be reconfigured to avoid harmonic conflicts.
+
+	  AMD provides an ACPI based mechanism to support WBRF on platform with
+	  appropriate underlying support.
+
+	  This mechanism will only be activated on platforms that advertise a
+	  need for it.
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index f04932b7a7d1..dcec0a46f8af 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
 amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
+obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
diff --git a/drivers/platform/x86/amd/wbrf.c b/drivers/platform/x86/amd/wbrf.c
new file mode 100644
index 000000000000..dd197b3aebe0
--- /dev/null
+++ b/drivers/platform/x86/amd/wbrf.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Frequency Band Manage Interface
+ * Copyright (C) 2023 Advanced Micro Devices
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_amd_wbrf.h>
+
+/*
+ * Functions bit vector for WBRF method
+ *
+ * Bit 0: WBRF supported.
+ * Bit 1: Function 1 (Add / Remove frequency) is supported.
+ * Bit 2: Function 2 (Get frequency list) is supported.
+ */
+#define WBRF_ENABLED		0x0
+#define WBRF_RECORD			0x1
+#define WBRF_RETRIEVE		0x2
+
+#define WBRF_REVISION		0x1
+
+/*
+ * The data structure used for WBRF_RETRIEVE is not naturally aligned.
+ * And unfortunately the design has been settled down.
+ */
+struct amd_wbrf_ranges_out {
+	u32			num_of_ranges;
+	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+} __packed;
+
+static const guid_t wifi_acpi_dsm_guid =
+	GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
+		  0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
+
+/*
+ * Used to notify consumer (amdgpu driver currently) about
+ * the wifi frequency is change.
+ */
+static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
+
+static int wbrf_record(struct acpi_device *adev, uint8_t action, struct wbrf_ranges_in_out *in)
+{
+	union acpi_object argv4;
+	union acpi_object *tmp;
+	union acpi_object *obj;
+	u32 num_of_ranges = 0;
+	u32 num_of_elements;
+	u32 arg_idx = 0;
+	int ret;
+	u32 i;
+
+	if (!in)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
+		if (in->band_list[i].start && in->band_list[i].end)
+			num_of_ranges++;
+	}
+
+	/*
+	 * The num_of_ranges value in the "in" object supplied by
+	 * the caller is required to be equal to the number of
+	 * entries in the band_list array in there.
+	 */
+	if (num_of_ranges != in->num_of_ranges)
+		return -EINVAL;
+
+	/*
+	 * Every input frequency band comes with two end points(start/end)
+	 * and each is accounted as an element. Meanwhile the range count
+	 * and action type are accounted as an element each.
+	 * So, the total element count = 2 * num_of_ranges + 1 + 1.
+	 */
+	num_of_elements = 2 * num_of_ranges + 2;
+
+	tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	argv4.package.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = num_of_elements;
+	argv4.package.elements = tmp;
+
+	/* save the number of ranges*/
+	tmp[0].integer.type = ACPI_TYPE_INTEGER;
+	tmp[0].integer.value = num_of_ranges;
+
+	/* save the action(WBRF_RECORD_ADD/REMOVE/RETRIEVE) */
+	tmp[1].integer.type = ACPI_TYPE_INTEGER;
+	tmp[1].integer.value = action;
+
+	arg_idx = 2;
+	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
+		if (!in->band_list[i].start || !in->band_list[i].end)
+			continue;
+
+		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+		tmp[arg_idx++].integer.value = in->band_list[i].start;
+		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+		tmp[arg_idx++].integer.value = in->band_list[i].end;
+	}
+
+	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
+				WBRF_REVISION, WBRF_RECORD, &argv4);
+
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = obj->integer.value;
+	if (ret)
+		ret = -EINVAL;
+
+out:
+	ACPI_FREE(obj);
+	kfree(tmp);
+
+	return ret;
+}
+
+/**
+ * acpi_amd_wbrf_add_remove - add or remove the frequency band the device is using
+ *
+ * @dev: device pointer
+ * @action: remove or add the frequency band into bios
+ * @in: input structure containing the frequency band the device is using
+ *
+ * Broadcast to other consumers the frequency band the device starts
+ * to use. Underneath the surface the information is cached into an
+ * internal buffer first. Then a notification is sent to all those
+ * registered consumers. So then they can retrieve that buffer to
+ * know the latest active frequency bands. Consumers that haven't
+ * yet been registered can retrieve the information from the cache
+ * when they register.
+ *
+ * Return:
+ * 0 for success add/remove wifi frequency band.
+ * Returns a negative error code for failure.
+ */
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in)
+{
+	struct acpi_device *adev;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	ret = wbrf_record(adev, action, in);
+	if (ret)
+		return ret;
+
+	blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_remove);
+
+/**
+ * acpi_amd_wbrf_supported_producer - determine if the WBRF can be enabled
+ *                                    for the device as a producer
+ *
+ * @dev: device pointer
+ *
+ * Check if the platform equipped with necessary implementations to
+ * support WBRF for the device as a producer.
+ *
+ * Return:
+ * true if WBRF is supported, otherwise returns false
+ */
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return false;
+
+	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
+			      WBRF_REVISION, BIT(WBRF_RECORD));
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
+
+/**
+ * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
+ *                                    for the device as a consumer
+ *
+ * @dev: device pointer
+ *
+ * Determine if the platform equipped with necessary implementations to
+ * support WBRF for the device as a consumer.
+ *
+ * Return:
+ * true if WBRF is supported, otherwise returns false.
+ */
+bool acpi_amd_wbrf_supported_consumer(struct device *dev)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return false;
+
+	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
+			      WBRF_REVISION, BIT(WBRF_RETRIEVE));
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
+
+/**
+ * amd_wbrf_retrieve_freq_band - retrieve current active frequency bands
+ *
+ * @dev: device pointer
+ * @out: output structure containing all the active frequency bands
+ *
+ * Retrieve the current active frequency bands which were broadcasted
+ * by other producers. The consumer who calls this API should take
+ * proper actions if any of the frequency band may cause RFI with its
+ * own frequency band used.
+ *
+ * Return:
+ * 0 for getting wifi freq band successfully.
+ * Returns a negative error code for failure.
+ */
+int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
+{
+	struct amd_wbrf_ranges_out acpi_out = {0};
+	struct acpi_device *adev;
+	union acpi_object *obj;
+	union acpi_object param;
+	int ret = 0;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	param.type = ACPI_TYPE_STRING;
+	param.string.length = 0;
+	param.string.pointer = NULL;
+
+	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
+							WBRF_REVISION, WBRF_RETRIEVE, &param);
+	if (!obj)
+		return -EINVAL;
+
+	/*
+	 * The return buffer is with variable length and the format below:
+	 * number_of_entries(1 DWORD):       Number of entries
+	 * start_freq of 1st entry(1 QWORD): Start frequency of the 1st entry
+	 * end_freq of 1st entry(1 QWORD):   End frequency of the 1st entry
+	 * ...
+	 * ...
+	 * start_freq of the last entry(1 QWORD)
+	 * end_freq of the last entry(1 QWORD)
+	 *
+	 * Thus the buffer length is determined by the number of entries.
+	 * - For zero entry scenario, the buffer length will be 4 bytes.
+	 * - For one entry scenario, the buffer length will be 20 bytes.
+	 */
+	if (obj->buffer.length > sizeof(acpi_out) || obj->buffer.length < 4) {
+		dev_err(dev, "Wrong sized WBRT information");
+		ret = -EINVAL;
+		goto out;
+	}
+	memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
+
+	out->num_of_ranges = acpi_out.num_of_ranges;
+	memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));
+
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(amd_wbrf_retrieve_freq_band);
+
+/**
+ * amd_wbrf_register_notifier - register for notifications of frequency
+ *                                   band update
+ *
+ * @nb: driver notifier block
+ *
+ * The consumer should register itself via this API so that it can get
+ * notified on the frequency band updates from other producers.
+ *
+ * Return:
+ * 0 for registering a consumer driver successfully.
+ * Returns a negative error code for failure.
+ */
+int amd_wbrf_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(amd_wbrf_register_notifier);
+
+/**
+ * amd_wbrf_unregister_notifier - unregister for notifications of
+ *                                     frequency band update
+ *
+ * @nb: driver notifier block
+ *
+ * The consumer should call this API when it is longer interested with
+ * the frequency band updates from other producers. Usually, this should
+ * be performed during driver cleanup.
+ *
+ * Return:
+ * 0 for unregistering a consumer driver.
+ * Returns a negative error code for failure.
+ */
+int amd_wbrf_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(amd_wbrf_unregister_notifier);
diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
new file mode 100644
index 000000000000..898f31d536d4
--- /dev/null
+++ b/include/linux/acpi_amd_wbrf.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Wifi Band Exclusion Interface (AMD ACPI Implementation)
+ * Copyright (C) 2023 Advanced Micro Devices
+ */
+
+#ifndef _ACPI_AMD_WBRF_H
+#define _ACPI_AMD_WBRF_H
+
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+/* The maximum number of frequency band ranges */
+#define MAX_NUM_OF_WBRF_RANGES		11
+
+/* Record actions */
+#define WBRF_RECORD_ADD		0x0
+#define WBRF_RECORD_REMOVE	0x1
+
+/**
+ * struct freq_band_range - Wifi frequency band range definition
+ * @start: start frequency point (in Hz)
+ * @end: end frequency point (in Hz)
+ */
+struct freq_band_range {
+	u64		start;
+	u64		end;
+};
+
+/**
+ * struct wbrf_ranges_in_out - wbrf ranges info
+ * @num_of_ranges: total number of band ranges in this struct
+ * @band_list: array of Wifi band ranges
+ */
+struct wbrf_ranges_in_out {
+	u64			num_of_ranges;
+	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+};
+
+/**
+ * enum wbrf_notifier_actions - wbrf notifier actions index
+ * @WBRF_CHANGED: there was some frequency band updates. The consumers
+ *               should retrieve the latest active frequency bands.
+ */
+enum wbrf_notifier_actions {
+	WBRF_CHANGED,
+};
+
+#if IS_ENABLED(CONFIG_AMD_WBRF)
+bool acpi_amd_wbrf_supported_producer(struct device *dev);
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in);
+bool acpi_amd_wbrf_supported_consumer(struct device *dev);
+int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out);
+int amd_wbrf_register_notifier(struct notifier_block *nb);
+int amd_wbrf_unregister_notifier(struct notifier_block *nb);
+#else
+static inline
+bool acpi_amd_wbrf_supported_consumer(struct device *dev)
+{
+	return false;
+}
+
+static inline
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in)
+{
+	return -ENODEV;
+}
+
+static inline
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	return false;
+}
+static inline
+int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
+{
+	return -ENODEV;
+}
+static inline
+int amd_wbrf_register_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+static inline
+int amd_wbrf_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_AMD_WBRF */
+
+#endif /* _ACPI_AMD_WBRF_H */
-- 
2.34.1

