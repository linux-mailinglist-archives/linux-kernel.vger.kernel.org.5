Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BEE780485
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357615AbjHRD16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357646AbjHRD1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:27:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78393C33;
        Thu, 17 Aug 2023 20:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCoXfttf8/nRPxaNw8n4TowGjH6p8BJaOLKWSIPtQvO68Xg2A7fjyh5yEBVuqkbYaBPCHArb5zVoJn2OObkxm4CalrkZADcnUXkapBaRgFOCxl1MdDWSLyRaGinvlkEq3/arbYDxXc5dLk6ZEGq1+J1TwpS5byWEwTpKYO5Kj0H3TPk11wuUpXtu5XHh6VNEAUDHJE0QDKXlX/aTRUfRPI6KlEY4z2uLf6U2VPms8s3XhyC7lp9m8PcAFluoSQ5wMX/FCp9mxDb/JtIXTgk8/ClP1w8DMr6gIhihWa64J50OnfjIA1sS+7PZjKV4WAOc96Sx/MR7pgQBJcS84VnMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1gq35CLBBZ3BO2MDtzop20Hz3VxSFCXuUvHjhGfRYM=;
 b=Y5t0+fkm0ogHZ6NUmVwWpYEVMX8RE/IP1KVemvRmxdP3E7mIz+IdurHHsITRSZCpHpqEWICdvAdRTrDNGxRgwxPB11QLY2aFGF9aExjyKqzzStwCSDiEou0RxT9blC91+8XWjy1Kjlpo6WVevydp3JJLOHnFT9wuFdOnKznfwHok4XGIEUoJ1sPudTEwOE52IaCiV6z9fhjEMhMIiPIxY5phRaaiLC8Qfyz2kvHrQByA9LFU4KGu9HLzE7JLnWo/akK5B6N49CNtoy0KNktsCo9V+UdHnY9/yoMRfMVlorVs6nw3lZVRHj3mnocN+qknedok0DVDLOAvqJUVDgjx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1gq35CLBBZ3BO2MDtzop20Hz3VxSFCXuUvHjhGfRYM=;
 b=fBw0DdXoVKvZjF2+YMSpZjkeDYh+hPDyxlpoOzJotxuPiyo7sq+3wtlvNFRjFjSzN64dWm9kxZ8sd+g6fN8e8rIqjC1uXeV5DdPQJDM08O6C2s8R7IYAm7cPZ8I3D7BzoQcBHSaqjN5FyA6K1RNxRO8G+yBm1w2nRC6WdHB1nMc=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Fri, 18 Aug 2023 03:27:25 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::5e) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 03:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 03:27:24 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 22:27:18 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>, <andrew@lunn.ch>,
        <rdunlap@infradead.org>, <quic_jjohnson@quicinc.com>,
        <horms@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Date:   Fri, 18 Aug 2023 11:26:11 +0800
Message-ID: <20230818032619.3341234-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818032619.3341234-1-evan.quan@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: c13912ee-c169-41c1-8a36-08db9f9b0a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS5lcm88j3dtaw8a/woXjSVSDDlRnSO4ze651zTfNi38qjuDwR95TfEsSTy9Yq9gbMu15xmUAEhUbMLb9ZpckJk1Akb1XEZhVdqRdSuIqEhu4TwTRYKdRRWxX93PddswE8ufasXyPyDM/0dmJ9NBzwRwQttvZInGWiWwSowU3BILPQCHiPHgFgVrbKlclYXUtT7eBgBJNe3lcVytHYhqAnNUApPGtMayQJ5G0j44u9Ygmm5tbdLkbb3oWfd8QiKVs/tRV3BFEi+uzA+yl2Yws8H2oVWvpphPCU5JzMQZgSk9DV6j8PZG8AtumvHFogupkdvQ2o1piAnWv47zCsPUflS3IDYgy8eQnNz8A7UOc16kuY5+u9SEi3kf/ri+laSt5rA1nLoqooPcoKv3L0YdWNnL+j0ldvOWIrDRoGqeqFYI6e6bGFi7UZ0xQxsWnzSd5h6Tfry13hDdyuoAfOgy+WtR60n03xrSyjBW+0onhQbqV+jSQyZXEpanGdDQH4HU5htQFj9PaExOpc7DdgEo1EpstZj4v/ihryuIQgmdg8vNcH+tdc11yfhDmFmIqKMhPtStYqfscGi23Nd2ePwvNSwiSvjikbKk14JeFw/HlOcTvmcGVA9fjtAjPAZmKjOxFqNBk5P0Jb5eEMlq1IYpkoCIOd46O7/5QE6Z9qDRQp4AGSDzZQYvG7ZqP2XOOMBhpD2dnuiLRaQRQ2Kv5LrnCYj3XzHJKpL/AOJHxqN9L8LTWDHmr+VTyk0QtznFhw2Xr955rKbNwUtI2pMiBjalM7ouoWVz2qUHXe+njiVKaBBafP6yoVF07mGKraR8olj0InKkfo7lcMvwk8hBnV+V6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(30864003)(26005)(86362001)(7416002)(336012)(40480700001)(478600001)(426003)(7696005)(6666004)(2616005)(1076003)(36756003)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(70586007)(82740400003)(356005)(54906003)(70206006)(81166007)(316002)(921005)(110136005)(4326008)(8936002)(8676002)(47076005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:27:24.6392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13912ee-c169-41c1-8a36-08db9f9b0a71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

In order for a device to support this, the expected flow for device
driver or subsystems:

Drivers/subsystems contributing frequencies:

1) During probe, check `wbrf_supported_producer` to see if WBRF supported
   for the device.
2) If adding frequencies, then call `wbrf_add_exclusion` with the
   start and end ranges of the frequencies.
3) If removing frequencies, then call `wbrf_remove_exclusion` with
   start and end ranges of the frequencies.

Drivers/subsystems responding to frequencies:

1) During probe, check `wbrf_supported_consumer` to see if WBRF is supported
   for the device.
2) Call the `wbrf_register_notifier` to register for notifications of
   frequency changes from other devices.
3) Call the `wbrf_retrieve_exclusions` to retrieve the current exclusions
   range on receiving a notification and response correspondingly.

Meanwhile a kernel parameter `wbrf` with default setting as "auto" is
introduced to specify what the policy is.
  - With `wbrf=on`, the WBRF features will be enabled forcely.
  - With `wbrf=off`, the WBRF features will be disabled forcely.
  - With `wbrf=auto`, it will be up to the system to do proper checks
    to determine the WBRF features should be enabled or not.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v4->v5:
  - promote this to be a more generic solution with input argument taking
    `struct device` and provide better scalability to support non-ACPI
    scenarios(Andrew)
  - update the APIs naming and some other minor fixes(Rafael)
v6->v7:
  - revised the `struct wbrf_ranges_out` to be naturally aligned(Andrew)
  - revised some code comments(Andrew)
v8->v9:
  - update the document to be more readable(Randy)
---
 .../admin-guide/kernel-parameters.txt         |   8 +
 drivers/base/Makefile                         |   1 +
 drivers/base/wbrf.c                           | 280 ++++++++++++++++++
 include/linux/wbrf.h                          |  47 +++
 4 files changed, 336 insertions(+)
 create mode 100644 drivers/base/wbrf.c
 create mode 100644 include/linux/wbrf.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..5566fefeffdf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7152,3 +7152,11 @@
 				xmon commands.
 			off	xmon is disabled.
 
+	wbrf=		[KNL]
+			Format: { on | auto (default) | off }
+			Controls if WBRF features should be forced on or off.
+			on	Force enable the WBRF features.
+			auto	Up to the system to do proper checks to
+				determine the WBRF features should be enabled
+				or not.
+			off	Force disable the WBRF features.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 3079bfe53d04..7b3cef898c19 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 obj-$(CONFIG_ACPI) += physical_location.o
+obj-y			+= wbrf.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/wbrf.c b/drivers/base/wbrf.c
new file mode 100644
index 000000000000..678f245c12c6
--- /dev/null
+++ b/drivers/base/wbrf.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Band Exclusion Interface
+ * Copyright (C) 2023 Advanced Micro Devices
+ *
+ */
+
+#include <linux/wbrf.h>
+
+static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
+static DEFINE_MUTEX(wbrf_mutex);
+static enum WBRF_POLICY_MODE {
+	WBRF_POLICY_FORCE_DISABLE,
+	WBRF_POLICY_AUTO,
+	WBRF_POLICY_FORCE_ENABLE,
+} wbrf_policy = WBRF_POLICY_AUTO;
+
+static int __init parse_wbrf_policy_mode(char *p)
+{
+	if (!strncmp(p, "auto", 4))
+		wbrf_policy = WBRF_POLICY_AUTO;
+	else if (!strncmp(p, "on", 2))
+		wbrf_policy = WBRF_POLICY_FORCE_ENABLE;
+	else if (!strncmp(p, "off", 3))
+		wbrf_policy = WBRF_POLICY_FORCE_DISABLE;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("wbrf", parse_wbrf_policy_mode);
+
+static struct exclusion_range_pool {
+	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+	u64			ref_counter[MAX_NUM_OF_WBRF_RANGES];
+} wbrf_pool;
+
+static int _wbrf_add_exclusion_ranges(struct wbrf_ranges_in *in)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
+		if (!in->band_list[i].start &&
+		    !in->band_list[i].end)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(wbrf_pool.band_list); j++) {
+			if (wbrf_pool.band_list[j].start == in->band_list[i].start &&
+			    wbrf_pool.band_list[j].end == in->band_list[i].end) {
+				wbrf_pool.ref_counter[j]++;
+				break;
+			}
+		}
+		if (j < ARRAY_SIZE(wbrf_pool.band_list))
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(wbrf_pool.band_list); j++) {
+			if (!wbrf_pool.band_list[j].start &&
+			    !wbrf_pool.band_list[j].end) {
+				wbrf_pool.band_list[j].start = in->band_list[i].start;
+				wbrf_pool.band_list[j].end = in->band_list[i].end;
+				wbrf_pool.ref_counter[j] = 1;
+				break;
+			}
+		}
+		if (j >= ARRAY_SIZE(wbrf_pool.band_list))
+			return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static int _wbrf_remove_exclusion_ranges(struct wbrf_ranges_in *in)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
+		if (!in->band_list[i].start &&
+		    !in->band_list[i].end)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(wbrf_pool.band_list); j++) {
+			if (wbrf_pool.band_list[j].start == in->band_list[i].start &&
+			    wbrf_pool.band_list[j].end == in->band_list[i].end) {
+				wbrf_pool.ref_counter[j]--;
+				if (!wbrf_pool.ref_counter[j]) {
+					wbrf_pool.band_list[j].start = 0;
+					wbrf_pool.band_list[j].end = 0;
+				}
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int _wbrf_retrieve_exclusion_ranges(struct wbrf_ranges_out *out)
+{
+	int out_idx = 0;
+	int i;
+
+	memset(out, 0, sizeof(*out));
+
+	for (i = 0; i < ARRAY_SIZE(wbrf_pool.band_list); i++) {
+		if (!wbrf_pool.band_list[i].start &&
+		    !wbrf_pool.band_list[i].end)
+			continue;
+
+		out->band_list[out_idx].start = wbrf_pool.band_list[i].start;
+		out->band_list[out_idx++].end = wbrf_pool.band_list[i].end;
+	}
+
+	out->num_of_ranges = out_idx;
+
+	return 0;
+}
+
+/**
+ * wbrf_supported_system - Determine if the system supports WBRF features
+ *
+ * WBRF is used to mitigate devices that cause harmonic interference.
+ * This function will determine if the platform is able to support the
+ * WBRF features.
+ */
+static bool wbrf_supported_system(void)
+{
+	switch (wbrf_policy) {
+	case WBRF_POLICY_FORCE_ENABLE:
+		return true;
+	case WBRF_POLICY_FORCE_DISABLE:
+		return false;
+	case WBRF_POLICY_AUTO:
+		return false;
+	}
+
+	return false;
+}
+
+/**
+ * wbrf_supported_producer - Determine if the device should report frequencies
+ *
+ * @dev: device pointer
+ *
+ * WBRF is used to mitigate devices that cause harmonic interference.
+ * This function will determine if this device should report such frequencies.
+ */
+bool wbrf_supported_producer(struct device *dev)
+{
+	if (!wbrf_supported_system())
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(wbrf_supported_producer);
+
+/**
+ * wbrf_add_exclusion - Add frequency ranges to the exclusion list
+ *
+ * @dev: device pointer
+ * @in: input structure containing the frequency ranges to be added
+ *
+ * Add frequencies into the exclusion list for supported consumers
+ * to react to.
+ */
+int wbrf_add_exclusion(struct device *dev,
+		       struct wbrf_ranges_in *in)
+{
+	int r;
+
+	mutex_lock(&wbrf_mutex);
+
+	r = _wbrf_add_exclusion_ranges(in);
+
+	mutex_unlock(&wbrf_mutex);
+	if (r)
+		return r;
+
+	blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wbrf_add_exclusion);
+
+/**
+ * wbrf_remove_exclusion - Remove frequency ranges from the exclusion list
+ *
+ * @dev: device pointer
+ * @in: input structure containing the frequency ranges to be removed
+ *
+ * Remove frequencies from the exclusion list for supported consumers
+ * to react to.
+ */
+int wbrf_remove_exclusion(struct device *dev,
+			  struct wbrf_ranges_in *in)
+{
+	int r;
+
+	mutex_lock(&wbrf_mutex);
+
+	r = _wbrf_remove_exclusion_ranges(in);
+
+	mutex_unlock(&wbrf_mutex);
+	if (r)
+		return r;
+
+	blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wbrf_remove_exclusion);
+
+/**
+ * wbrf_supported_consumer - Determine if the device should react to frequencies
+ *
+ * @dev: device pointer
+ *
+ * WBRF is used to mitigate devices that cause harmonic interference.
+ * This function will determine if this device should react to reports from
+ * other devices for such frequencies.
+ */
+bool wbrf_supported_consumer(struct device *dev)
+{
+	if (!wbrf_supported_system())
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(wbrf_supported_consumer);
+
+/**
+ * wbrf_register_notifier - Register for notifications of frequency changes
+ *
+ * @nb: driver notifier block
+ *
+ * WBRF is used to mitigate devices that cause harmonic interference.
+ * This function will allow consumers to register for frequency notifications.
+ */
+int wbrf_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(wbrf_register_notifier);
+
+/**
+ * wbrf_unregister_notifier - Unregister for notifications of frequency changes
+ *
+ * @nb: driver notifier block
+ *
+ * WBRF is used to mitigate devices that cause harmonic interference.
+ * This function will allow consumers to unregister for frequency notifications.
+ */
+int wbrf_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(wbrf_unregister_notifier);
+
+/**
+ * wbrf_retrieve_exclusions - Retrieve the exclusion list
+ *
+ * @dev: device pointer
+ * @out: output structure containing the frequency ranges to be excluded
+ *
+ * Retrieve the current exclusion list
+ */
+int wbrf_retrieve_exclusions(struct device *dev,
+			     struct wbrf_ranges_out *out)
+{
+	int r;
+
+	mutex_lock(&wbrf_mutex);
+
+	r = _wbrf_retrieve_exclusion_ranges(out);
+
+	mutex_unlock(&wbrf_mutex);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(wbrf_retrieve_exclusions);
diff --git a/include/linux/wbrf.h b/include/linux/wbrf.h
new file mode 100644
index 000000000000..476a28fec27a
--- /dev/null
+++ b/include/linux/wbrf.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Wifi Band Exclusion Interface
+ * Copyright (C) 2023 Advanced Micro Devices
+ */
+
+#ifndef _LINUX_WBRF_H
+#define _LINUX_WBRF_H
+
+#include <linux/device.h>
+
+/* Maximum number of wbrf ranges */
+#define MAX_NUM_OF_WBRF_RANGES		11
+
+struct exclusion_range {
+	/* start and end point of the frequency range in Hz */
+	u64		start;
+	u64		end;
+};
+
+struct wbrf_ranges_in {
+	/* valid entry: `start` and `end` filled with non-zero values */
+	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+};
+
+struct wbrf_ranges_out {
+	u64			num_of_ranges;
+	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+};
+
+enum wbrf_notifier_actions {
+	WBRF_CHANGED,
+};
+
+bool wbrf_supported_producer(struct device *dev);
+int wbrf_add_exclusion(struct device *adev,
+		       struct wbrf_ranges_in *in);
+int wbrf_remove_exclusion(struct device *dev,
+			  struct wbrf_ranges_in *in);
+int wbrf_retrieve_exclusions(struct device *dev,
+			     struct wbrf_ranges_out *out);
+bool wbrf_supported_consumer(struct device *dev);
+
+int wbrf_register_notifier(struct notifier_block *nb);
+int wbrf_unregister_notifier(struct notifier_block *nb);
+
+#endif /* _LINUX_WBRF_H */
-- 
2.34.1

