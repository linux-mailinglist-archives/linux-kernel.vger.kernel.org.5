Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD77E7CB8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjJQCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjJQCzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:55:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9B3E6;
        Mon, 16 Oct 2023 19:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avIqxwCXld7M9gunSl5d7nS+Z5DbpdnZVziRDBOftZX7Wf6DpfH0dM9ScF1bYJWE6CzjRaqpNyLqOmmBTnM7Gq+hfjmy+iR36vFVFJY+5yCbz4/QdoSSsN4nOJh4cFWnL9BE9pbbH6KUNn660jOqN5OMJFgknYjTzuN6Sf/5i0CTtweQtLZFVCenMfBmtHbL1Rka7AZG+/gpuoa4U67Aby32qSiXUq+o+rpeDC1lMj7qVq6yKGyQXPwS9MqxgmBUgXETeSI4qwd4E9jy7LEsfU7Oq2pGxg8zoA3DMyFsUxcNdiwddT8rCGzEnPpHNM7jpRdknrjJuNNAddlzyV/ERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7ZBZrVYECuivhSf1nbALnz88/mWVYnsgKSskhr1pkA=;
 b=QXaTVvVYI69sHhdRg868ILzajbpyf8g3JwfxBDrpBfYzNn0H9BH6ZREpXP9vFzj5jPykmOB0TXmoQn4jBc8Sbk3funbZ5rsBBC0o4pryNumh25F3AC7GRsixNy4NWwWRgKwLNZ1HnFYSjkkTt7ZleLvcxWPgwzJXVi+88Kwh1CNpzVbRircPTWnT0BJ/0k8jvRdyZOlLVB/zk2nqn+Amh0ogmxJy2HkAukBY+0PGyd/8vD6rLlONZKtYxoLQ8Emt3RS9JmLE45+p62BgxuRoqijjV7rvtvymFCa9qUb5f3P01+kxpcXpRFt7qAg+44Ql65Cml64fwFTOY0clGqM0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7ZBZrVYECuivhSf1nbALnz88/mWVYnsgKSskhr1pkA=;
 b=IVLwr4rFaFqL5mbA6hRpBoy8abWnH8ciUCFp7rcoDXpTOhc1dOrs7We1xM6ko5PZWVTNgsuUX1qAddVCXxNLYSsoyJ+eIHBa8Ly/a4SKegawD6BoQCJjpdpw93SHhVPdiOs/VaMmLH+gQYf1Uvj7sckvj2n7yG+uzre8w1RHHjA=
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 02:55:10 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::17) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 02:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 02:55:09 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 21:55:05 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>
CC:     <majun@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Ma Jun <Jun.Ma2@amd.com>, Evan Quan <quanliangl@hotmail.com>
Subject: [PATCH v12 2/9] platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature
Date:   Tue, 17 Oct 2023 10:53:51 +0800
Message-ID: <20231017025358.1773598-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017025358.1773598-1-Jun.Ma2@amd.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f122c1-9dec-4f84-89ea-08dbcebc7a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXP3rHn6xA3/DXw5EXrdDnMa3Ih40OeuAcICeZpfIeTOeK92KuYE2pqSub6mGDUOq1XU1fBuAp2Ea+N096lJIjhrl0HHXcm4POBU/vUSJ4ysuvnvCu2I6m4BOxX9vRUP5Mdg9dlN8KcS/wStsqSFq66DTLEVjAt4p3VkeEvjzyigDhgDrVpI0VrUgoplsLaaKzEBd/OIDOkLYTDdtYvQQECBkQf3z1B4rEtZnNw9vjaYctfp6Tjs+ZpW9GNmuRqcOHA+qqoMfCX1xEVpBi6sxQhidCLxs2GpNIgP6dhgT44l1mbbqv4kjo4znCPEDCVJ5o5DAdZWE/O2DnGBsKi/MQY4JQtqjBd5tFbo9VHERfLsgaew2Js9yOhgxk+Fm/u/kE2wa8XCQOB2Nq68Q6q/akRo7MRPBZu4+bjiT19HA27dkunAPY8WSAdqKelsp7BA0pY2NgrTAe+JnLrapOpqXvTNaZDySEvkn0BJvqXYSkXQC8XhZcjvDQ2/KtwvjhIO0owkR28MYR+Q5E3tP+vmEu7Ob+i1oEsFOJKx4DgW0yctadmyec8Aa3c0NTI6DyAA9k5IFkpgV0LfLjF2dR0Z58OkXJI7VYEH9k/BROJROwzeePjFTP3fOKkNCCnRi2bzO1S28KqGGh0wBoqMUzfFBH0ZICLkbfCRgRqIWrjYIRonB0wP8bVUC4zNWgYeqnvZn8kTaIxrlbWGjTyp7PPu8QiWAMG4SJrss7uItowEVKwrwR+rV2WJPdh5o3IAqk6VkREIz5oOoU5DumAXPj7cLkh6rrdr4E8RVPsu6AFPcIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(86362001)(36756003)(40480700001)(26005)(40460700003)(478600001)(2906002)(7696005)(45080400002)(5660300002)(6666004)(81166007)(41300700001)(82740400003)(356005)(921005)(70206006)(2616005)(36860700001)(1076003)(16526019)(336012)(426003)(316002)(110136005)(8676002)(70586007)(6636002)(8936002)(4326008)(54906003)(30864003)(32650700002)(7416002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:55:09.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f122c1-9dec-4f84-89ea-08dbcebc7a17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Co-Developed-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

--
v11:
 - fix typo(Simon)
v12:
 - Fix the code (Rafael)
 - Move amd_wbrf.c to drivers/platform/x86/amd/wbrf.c
 - Updated Evan's email because he's no longer at AMD.Thanks
for his work in earlier versions.
---
 drivers/platform/x86/amd/Kconfig  |  15 ++
 drivers/platform/x86/amd/Makefile |   1 +
 drivers/platform/x86/amd/wbrf.c   | 402 ++++++++++++++++++++++++++++++
 include/linux/acpi_amd_wbrf.h     | 101 ++++++++
 4 files changed, 519 insertions(+)
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index d9685aef0887..fa5a978a2d22 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -32,3 +32,18 @@ config AMD_HSMP
 
 	  If you choose to compile this driver as a module the module will be
 	  called amd_hsmp.
+
+config AMD_WBRF
+	bool "AMD Wifi RF Band mitigations (WBRF)"
+	depends on ACPI
+	default n
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
index 65732f0a3913..62b98b048b17 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_AMD_PMC)		+= amd-pmc.o
 amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
+obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
diff --git a/drivers/platform/x86/amd/wbrf.c b/drivers/platform/x86/amd/wbrf.c
new file mode 100644
index 000000000000..fb414564f576
--- /dev/null
+++ b/drivers/platform/x86/amd/wbrf.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Frequency Band Manage Interface
+ * Copyright (C) 2023 Advanced Micro Devices
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_amd_wbrf.h>
+
+#define ACPI_AMD_WBRF_METHOD	"\\WBRF"
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
+static int wbrf_record(struct acpi_device *adev, uint8_t action,
+		       struct wbrf_ranges_in_out *in)
+{
+	union acpi_object argv4;
+	union acpi_object *tmp;
+	union acpi_object *obj;
+	u32 num_of_ranges = 0;
+	u32 num_of_elements;
+	u32 arg_idx = 0;
+	u32 loop_idx;
+	int ret;
+
+	if (!in)
+		return -EINVAL;
+
+	/*
+	 * The num_of_ranges value in the "in" object supplied by
+	 * the caller is required to be equal to the number of
+	 * entries in the band_list array in there.
+	 */
+	for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
+	     loop_idx++)
+		if (in->band_list[loop_idx].start &&
+		    in->band_list[loop_idx].end)
+			num_of_ranges++;
+
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
+	for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
+	     loop_idx++) {
+		if (!in->band_list[loop_idx].start ||
+		    !in->band_list[loop_idx].end)
+			continue;
+
+		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+		tmp[arg_idx++].integer.value = in->band_list[loop_idx].start;
+		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+		tmp[arg_idx++].integer.value = in->band_list[loop_idx].end;
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
+
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
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action,
+							struct wbrf_ranges_in_out *in)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	if (!adev)
+		return -ENODEV;
+
+	ret = wbrf_record(adev, action, in);
+	if (ret)
+		return ret;
+
+	blocking_notifier_call_chain(&wbrf_chain_head,
+				     WBRF_CHANGED,
+				     NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_remove);
+
+static bool acpi_amd_wbrf_supported_system(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
+
+	return ACPI_SUCCESS(status);
+}
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
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return false;
+
+	if (!acpi_amd_wbrf_supported_system())
+		return false;
+
+
+	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
+			      WBRF_REVISION,
+			      BIT(WBRF_RECORD));
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
+
+static union acpi_object *
+acpi_evaluate_wbrf(acpi_handle handle, u64 rev, u64 func)
+{
+	acpi_status ret;
+	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object params[4];
+	struct acpi_object_list input = {
+		.count = 4,
+		.pointer = params,
+	};
+
+	params[0].type = ACPI_TYPE_INTEGER;
+	params[0].integer.value = rev;
+	params[1].type = ACPI_TYPE_INTEGER;
+	params[1].integer.value = func;
+	params[2].type = ACPI_TYPE_PACKAGE;
+	params[2].package.count = 0;
+	params[2].package.elements = NULL;
+	params[3].type = ACPI_TYPE_STRING;
+	params[3].string.length = 0;
+	params[3].string.pointer = NULL;
+
+	ret = acpi_evaluate_object(handle, "WBRF", &input, &buf);
+	if (ACPI_FAILURE(ret))
+		return NULL;
+
+	return buf.pointer;
+}
+
+static bool check_acpi_wbrf(acpi_handle handle, u64 rev, u64 funcs)
+{
+	int i;
+	u64 mask = 0;
+	union acpi_object *obj;
+
+	if (funcs == 0)
+		return false;
+
+	obj = acpi_evaluate_wbrf(handle, rev, 0);
+	if (!obj)
+		return false;
+
+	if (obj->type != ACPI_TYPE_BUFFER)
+		return false;
+
+	/*
+	 * Bit vector providing supported functions information.
+	 * Each bit marks support for one specific function of the WBRF method.
+	 */
+	for (i = 0; i < obj->buffer.length && i < 8; i++)
+		mask |= (u64)obj->buffer.pointer[i] << i * 8;
+
+	ACPI_FREE(obj);
+
+	if ((mask & BIT(WBRF_ENABLED)) && (mask & funcs) == funcs)
+		return true;
+
+	return false;
+}
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
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return false;
+
+	if (!acpi_amd_wbrf_supported_system())
+		return false;
+
+	return check_acpi_wbrf(adev->handle,
+			       WBRF_REVISION,
+			       BIT(WBRF_RETRIEVE));
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
+
+/**
+ * amd_wbrf_retrieve_freq_band - retrieve current active frequency
+ *                                     bands
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
+int amd_wbrf_retrieve_freq_band(struct device *dev,
+				      struct wbrf_ranges_in_out *out)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct amd_wbrf_ranges_out acpi_out = {0};
+	union acpi_object *obj;
+	int ret = 0;
+
+	if (!adev)
+		return -ENODEV;
+
+	obj = acpi_evaluate_wbrf(adev->handle,
+				 WBRF_REVISION,
+				 WBRF_RETRIEVE);
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
+	if (obj->buffer.length > sizeof(acpi_out) ||
+	    obj->buffer.length < 4) {
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
+
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
index 000000000000..298779807312
--- /dev/null
+++ b/include/linux/acpi_amd_wbrf.h
@@ -0,0 +1,101 @@
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
+/*
+ * The maximum number of frequency band ranges
+ */
+#define MAX_NUM_OF_WBRF_RANGES		11
+
+/* Record actions */
+#define WBRF_RECORD_ADD		0x0
+#define WBRF_RECORD_REMOVE	0x1
+
+/*
+ * A freq_band_range is defined as a wifi frequency band with start
+ * and end frequency point specified(in Hz). And a valid range should
+ * have its start and end frequency point filled with non-zero values.
+ * Meanwhile, the maximum number of wbrf ranges is limited as
+ * `MAX_NUM_OF_WBRF_RANGES`.
+ */
+
+struct freq_band_range {
+	u64		start;
+	u64		end;
+};
+
+struct wbrf_ranges_in_out {
+	u64			num_of_ranges;
+	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+};
+
+/*
+ * The notification types for the consumers are defined as below.
+ * The consumers may need to take different actions in response to
+ * different notifications.
+ * WBRF_CHANGED: there was some frequency band updates. The consumers
+ *               should retrieve the latest active frequency bands.
+ */
+enum wbrf_notifier_actions {
+	WBRF_CHANGED,
+};
+
+#if IS_ENABLED(CONFIG_AMD_WBRF)
+bool acpi_amd_wbrf_supported_producer(struct device *dev);
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action,
+							struct wbrf_ranges_in_out *in);
+bool acpi_amd_wbrf_supported_consumer(struct device *dev);
+int amd_wbrf_retrieve_freq_band(struct device *dev,
+				      struct wbrf_ranges_in_out *out);
+int amd_wbrf_register_notifier(struct notifier_block *nb);
+int amd_wbrf_unregister_notifier(struct notifier_block *nb);
+#else
+static inline
+bool acpi_amd_wbrf_supported_consumer(struct device *dev)
+{
+	return false;
+}
+static inline
+int acpi_amd_wbrf_remove_exclusion(struct device *dev,
+				   struct wbrf_ranges_in_out *in)
+{
+	return -ENODEV;
+}
+static inline
+int acpi_amd_wbrf_add_exclusion(struct device *dev,
+				struct wbrf_ranges_in_out *in)
+{
+	return -ENODEV;
+}
+static inline
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	return false;
+}
+static inline
+int amd_wbrf_retrieve_freq_band(struct device *dev,
+				      struct wbrf_ranges_in_out *out)
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

