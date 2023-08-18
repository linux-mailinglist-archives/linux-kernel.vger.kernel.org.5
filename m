Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904C7780491
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357651AbjHRD2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357624AbjHRD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:28:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314A3C13;
        Thu, 17 Aug 2023 20:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt0/WGhaJ+ewtTKJLXuD3WVipRU77/KraCu+QS0ftBekyhf5FswA5ZBZlUdVEAvtxiuW97gM3Yk3dk+Yie6QqX9of2vjz0Y0qtmETt2LHkYCjDY5+97GUFMCmUI+kYZ0crODgDpQIDhbW63lE+J7zMNKOkhj+9fQVR2lDuqUn0z0v4kzPlYDC9/gvuvHSDhO1PXIQoR+fcejYEGh52s4ORPTTkmObD1tlNrvKPLmFCcviYNP39aAd3/Ikbz79NspU00CjoG1tEN6175ZgpKVxbDiXn3WtlwvxBauGk691WhjgOis60hEUVvpWAh/NHLp5Nw18g6+KvFB6D/WggLWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ok5ygsJ/rN4qVF+9CxBbKn0O/OFaPVVUpCP5Ikl4dQ=;
 b=oUOIfQz8wD0eR8o+Jp7rbjhbqRnsZ/CGdPCiZx4vqGuT7SeK8h7MxfOYZfX7i2b4X7q+Kk2NS5yRwoF2B9+++vakT8o3/DLeVVShJqr4goosf0tNbBeEqWaAFQJ7VswlLy7jfYEOAXyaCbMedNHhKnkoUqsTHcIj17QzR848H+QYS5fdMtkdZMIW/8HuQ5EBWbBTpxzR5LKi+lCjGOxun3LWTEyd8mYG2MQOHQnxVyqLQHXhbY0/sqn/3+XPci9vDEdvXD74FMfe/LukTjI/YxXIKRwT1RD0eFuqD3FzUy0lnlPpnrYKsb33snw+4N/+tAzrzZ1GIQ9XWmW7gKvWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ok5ygsJ/rN4qVF+9CxBbKn0O/OFaPVVUpCP5Ikl4dQ=;
 b=195zhj5Z4Vwn12LHShvwX/bIx/vEQXlzmpqvc92UnPS44nMgsIvy/3GhMSCjhpODx9c4oHZR2dgsJ+xyAMtNr2roTBnnweSSdRxtOO27mbZYFqiXIvrz/Z0MlGRqe42SdNkCqU/culXqq08xMdfpvsP3p/0GnpDimctc7heI/p0=
Received: from SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::29)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:27:30 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::f2) by SA1P222CA0108.outlook.office365.com
 (2603:10b6:806:3c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.19 via Frontend
 Transport; Fri, 18 Aug 2023 03:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 03:27:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 22:27:24 -0500
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
Subject: [V9 2/9] drivers core: add ACPI based WBRF mechanism introduced by AMD
Date:   Fri, 18 Aug 2023 11:26:12 +0800
Message-ID: <20230818032619.3341234-3-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DM4PR12MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a773dc5-3d37-4404-72f4-08db9f9b0d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4FRFlPT/93T0b3YOO6E4+PO/9llMCQxwN2eixVY8ZJg3rOGDPRDWIivaxJEAcbJjUHv7vDBTHasWHvaZlAJ2Y6OXoGBHy6tuBwj88hPVSlgyAfmTiMv4adv02IycxEMQi0qpW/dxB+Fd2ebDuF/c8WkFz43zzXRpTJTAWwErvqwsONku58ycmwnvPqxchPEt0UJwTq054+7oH+pICruXlBGeljD/jHw/n02FKnIX/NgwDklFkbB/QhC4GaH2VL2GFDLahoGbFPBqQVkRMpkSJXsQOyq8T08QxjFomulPpLDpbPoDr8Ug2W++W7l2MVo8V5LzAQvgBjjKz6ZcAEOwsk8GMUsC4fcQsrqIF4D9d4n3jaRanU7xcm7K5JwKAS/s+F+6l6R62FzCmBXB+NEyEN9kdoJwi3phIzRrwimG5m+J5W2/wRkW3rpvPkR9GYf079PcDb93SUfXE7Hf+deFk2OWp44nPuUpEMWvqs4bDri7YPF/jiS9Y4Ks+xxSPuZSKNh3l4+jcMVAP0L4Gz1FWnNkQW4De51DPWUvUtBAiHvZezI2wphgvr//oqkjSJrDNjeFJW7dcsDEaV4T7W7YTtyQ5Q53ioJB25EMbtpAcr38y3fanjUPbIUsVqhS26dL8j4zWjRgZpGJeON6tNeG0QdNiDCuW3/T/2EA7a2vpVXSb73akzHzbG5N2OYwxROgfxFt3QUDrRzHTSKfalVgn43juO07qdLFqWSts7iZedu8EXuVBU0ysrmoDkC2Uxqf25z+1Db4SQ2utEukigTj4pEBhMTkMykh9NAOha3fuQveGCN/ihvyTiQ0JrVA05CrGI2obpEydjHJEsALVUNTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40460700003)(40480700001)(83380400001)(30864003)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(336012)(16526019)(1076003)(6666004)(7696005)(44832011)(47076005)(36860700001)(426003)(2616005)(478600001)(7416002)(921005)(81166007)(82740400003)(356005)(316002)(70206006)(110136005)(70586007)(54906003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:27:29.8422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a773dc5-3d37-4404-72f4-08db9f9b0d8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD has introduced an ACPI based mechanism to support WBRF for some
platforms with AMD dGPU + WLAN. This needs support from BIOS equipped
with necessary AML implementations and dGPU firmwares.

For those systems without the ACPI mechanism and developing solutions,
user can use/fall-back the generic WBRF solution for diagnosing potential
interference issues.

And for the platform which does not equip with the necessary AMD ACPI
implementations but with CONFIG_WBRF_AMD_ACPI built as 'y', it will
fall back to generic WBRF solution if the `wbrf` is set as "on".

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
v5->v6:
  - make the code more readable and some other fixes(Andrew)
v6->v8:
  - drop CONFIG_WBRF_GENERIC(Mario)
  - add `wbrf` kernel parameter for policy control(Mario)
v8->v9:
  - correct some coding style(Simon)
---
 drivers/acpi/Makefile         |   2 +
 drivers/acpi/amd_wbrf.c       | 294 ++++++++++++++++++++++++++++++++++
 drivers/base/Kconfig          |  20 +++
 drivers/base/wbrf.c           | 135 +++++++++++++---
 include/linux/acpi_amd_wbrf.h |  25 +++
 5 files changed, 452 insertions(+), 24 deletions(-)
 create mode 100644 drivers/acpi/amd_wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3fc5a0d54f6e..9185d16e4495 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -133,3 +133,5 @@ obj-$(CONFIG_ARM64)		+= arm64/
 obj-$(CONFIG_ACPI_VIOT)		+= viot.o
 
 obj-$(CONFIG_RISCV)		+= riscv/
+
+obj-$(CONFIG_WBRF_AMD_ACPI)	+= amd_wbrf.o
diff --git a/drivers/acpi/amd_wbrf.c b/drivers/acpi/amd_wbrf.c
new file mode 100644
index 000000000000..0e46de3dfac7
--- /dev/null
+++ b/drivers/acpi/amd_wbrf.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Band Exclusion Interface (AMD ACPI Implementation)
+ * Copyright (C) 2023 Advanced Micro Devices
+ *
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
+ * Bit 0: Supported for any functions other than function 0.
+ * Bit 1: Function 1 (Add / Remove frequency) is supported.
+ * Bit 2: Function 2 (Get frequency list) is supported.
+ */
+#define WBRF_ENABLED				0x0
+#define WBRF_RECORD				0x1
+#define WBRF_RETRIEVE				0x2
+
+/* record actions */
+#define WBRF_RECORD_ADD		0x0
+#define WBRF_RECORD_REMOVE	0x1
+
+#define WBRF_REVISION		0x1
+
+/*
+ * The data structure used for WBRF_RETRIEVE is not natually aligned.
+ * And unfortunately the design has been settled down.
+ */
+struct amd_wbrf_ranges_out {
+	u32			num_of_ranges;
+	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+} __packed;
+
+static const guid_t wifi_acpi_dsm_guid =
+	GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
+		  0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
+
+static int wbrf_dsm(struct acpi_device *adev, u8 fn,
+		    union acpi_object *argv4,
+		    union acpi_object **out)
+{
+	union acpi_object *obj;
+	int rc;
+
+	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
+				WBRF_REVISION, fn, argv4);
+	if (!obj)
+		return -ENXIO;
+
+	switch (obj->type) {
+	case ACPI_TYPE_BUFFER:
+		*out = obj;
+		return 0;
+
+	case ACPI_TYPE_INTEGER:
+		rc =  obj->integer.value ? -EINVAL : 0;
+		break;
+
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	ACPI_FREE(obj);
+
+	return rc;
+}
+
+static int wbrf_record(struct acpi_device *adev, uint8_t action,
+		       struct wbrf_ranges_in *in)
+{
+	union acpi_object argv4;
+	union acpi_object *tmp;
+	u32 num_of_ranges = 0;
+	u32 num_of_elements;
+	u32 arg_idx = 0;
+	u32 loop_idx;
+	int ret;
+
+	if (!in)
+		return -EINVAL;
+
+	for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
+	     loop_idx++)
+		if (in->band_list[loop_idx].start &&
+		    in->band_list[loop_idx].end)
+			num_of_ranges++;
+
+	/*
+	 * Every range comes with two end points(start and end) and
+	 * each of them is accounted as an element. Meanwhile the range
+	 * count and action type are accounted as an element each.
+	 * So, the total element count = 2 * num_of_ranges + 1 + 1.
+	 */
+	num_of_elements = 2 * num_of_ranges + 1 + 1;
+
+	tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	argv4.package.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = num_of_elements;
+	argv4.package.elements = tmp;
+
+	tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+	tmp[arg_idx++].integer.value = num_of_ranges;
+	tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+	tmp[arg_idx++].integer.value = action;
+
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
+	ret = wbrf_dsm(adev, WBRF_RECORD, &argv4, NULL);
+
+	kfree(tmp);
+
+	return ret;
+}
+
+int acpi_amd_wbrf_add_exclusion(struct device *dev,
+				struct wbrf_ranges_in *in)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return wbrf_record(adev, WBRF_RECORD_ADD, in);
+}
+
+int acpi_amd_wbrf_remove_exclusion(struct device *dev,
+				   struct wbrf_ranges_in *in)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return wbrf_record(adev, WBRF_RECORD_REMOVE, in);
+}
+
+bool acpi_amd_wbrf_supported_system(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
+
+	return ACPI_SUCCESS(status);
+}
+
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return false;
+
+	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
+			      WBRF_REVISION,
+			      BIT(WBRF_RECORD));
+}
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
+	if (ACPI_SUCCESS(ret))
+		return (union acpi_object *)buf.pointer;
+
+	return NULL;
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
+		mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
+
+	ACPI_FREE(obj);
+
+	if ((mask & BIT(WBRF_ENABLED)) &&
+	    (mask & funcs) == funcs)
+		return true;
+
+	return false;
+}
+
+bool acpi_amd_wbrf_supported_consumer(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return false;
+
+	return check_acpi_wbrf(adev->handle,
+			       WBRF_REVISION,
+			       BIT(WBRF_RETRIEVE));
+}
+
+int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
+				      struct wbrf_ranges_out *out)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct amd_wbrf_ranges_out acpi_out = {0};
+	union acpi_object *obj;
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
+		dev_err(dev, "BIOS FUBAR, ignoring wrong sized WBRT information");
+		ACPI_FREE(obj);
+		return -EINVAL;
+	}
+	memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
+
+	out->num_of_ranges = acpi_out.num_of_ranges;
+	memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));
+
+	ACPI_FREE(obj);
+
+	return 0;
+}
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..feb6f5625728 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -242,4 +242,24 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  command line option on every system/board your kernel is expected to
 	  work on.
 
+menu "Wifi band RF mitigation mechanism"
+
+config WBRF_AMD_ACPI
+	bool "ACPI based mechanism introduced by AMD"
+	depends on ACPI
+	help
+	  Wifi band RF mitigation mechanism allows multiple drivers from
+	  different domains to notify the frequencies in use so that hardware
+	  can be reconfigured to avoid harmonic conflicts.
+
+	  AMD has introduced an ACPI based mechanism to support WBRF for some
+	  platforms with AMD dGPU and WLAN. This needs support from BIOS equipped
+	  with necessary AML implementations and dGPU firmwares.
+
+	  Before enabling this ACPI based mechanism, it is suggested to confirm
+	  with the hardware designer/provider first whether your platform
+	  equipped with necessary BIOS and firmwares.
+
+endmenu
+
 endmenu
diff --git a/drivers/base/wbrf.c b/drivers/base/wbrf.c
index 678f245c12c6..751e252d0039 100644
--- a/drivers/base/wbrf.c
+++ b/drivers/base/wbrf.c
@@ -6,9 +6,25 @@
  */
 
 #include <linux/wbrf.h>
+#include <linux/acpi_amd_wbrf.h>
 
 static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
+
 static DEFINE_MUTEX(wbrf_mutex);
+
+static struct exclusion_range_pool {
+	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+	u64			ref_counter[MAX_NUM_OF_WBRF_RANGES];
+} wbrf_pool;
+
+enum WBRF_SUPPORT_CHECK {
+	WBRF_SUPPORT_UNCHECKED,
+	WBRF_SUPPORT_NONE,
+	WBRF_SUPPORT_GENERIC,
+	WBRF_SUPPORT_OTHERS,
+};
+static atomic_t wbrf_support_check = ATOMIC_INIT(WBRF_SUPPORT_UNCHECKED);
+
 static enum WBRF_POLICY_MODE {
 	WBRF_POLICY_FORCE_DISABLE,
 	WBRF_POLICY_AUTO,
@@ -30,11 +46,6 @@ static int __init parse_wbrf_policy_mode(char *p)
 }
 early_param("wbrf", parse_wbrf_policy_mode);
 
-static struct exclusion_range_pool {
-	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
-	u64			ref_counter[MAX_NUM_OF_WBRF_RANGES];
-} wbrf_pool;
-
 static int _wbrf_add_exclusion_ranges(struct wbrf_ranges_in *in)
 {
 	int i, j;
@@ -121,20 +132,45 @@ static int _wbrf_retrieve_exclusion_ranges(struct wbrf_ranges_out *out)
  *
  * WBRF is used to mitigate devices that cause harmonic interference.
  * This function will determine if the platform is able to support the
- * WBRF features.
+ * WBRF features. For example, for AMD ACPI implementation it should say
+ * true only when the necessary AML code/logic supporting wbrf feature
+ * available.
  */
-static bool wbrf_supported_system(void)
+static enum WBRF_SUPPORT_CHECK wbrf_supported_system(void)
 {
+	enum WBRF_SUPPORT_CHECK support_check;
+
+	support_check = atomic_read(&wbrf_support_check);
+	if (support_check != WBRF_SUPPORT_UNCHECKED)
+		return support_check;
+
+	support_check = WBRF_SUPPORT_NONE;
+
 	switch (wbrf_policy) {
 	case WBRF_POLICY_FORCE_ENABLE:
-		return true;
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		if (acpi_amd_wbrf_supported_system()) {
+			support_check = WBRF_SUPPORT_OTHERS;
+			break;
+		}
+		pr_warn_once("Force WBRF w/o acpi_amd_wbrf support\n");
+		pr_warn_once("Fall back to generic version\n");
+#endif
+		support_check = WBRF_SUPPORT_GENERIC;
+		break;
 	case WBRF_POLICY_FORCE_DISABLE:
-		return false;
+		break;
 	case WBRF_POLICY_AUTO:
-		return false;
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		if (acpi_amd_wbrf_supported_system())
+			support_check = WBRF_SUPPORT_OTHERS;
+#endif
+		break;
 	}
 
-	return false;
+	atomic_set(&wbrf_support_check, support_check);
+
+	return support_check;
 }
 
 /**
@@ -144,13 +180,22 @@ static bool wbrf_supported_system(void)
  *
  * WBRF is used to mitigate devices that cause harmonic interference.
  * This function will determine if this device should report such frequencies.
+ * For example, for AMD ACPI implementation it should say true only when the
+ * necessary AML code/logic supporting wbrf feature available for this device.
  */
 bool wbrf_supported_producer(struct device *dev)
 {
-	if (!wbrf_supported_system())
+	switch (wbrf_supported_system()) {
+	case WBRF_SUPPORT_GENERIC:
+		return true;
+	case WBRF_SUPPORT_OTHERS:
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		return acpi_amd_wbrf_supported_producer(dev);
+#endif
+		fallthrough;
+	default:
 		return false;
-
-	return true;
+	}
 }
 EXPORT_SYMBOL_GPL(wbrf_supported_producer);
 
@@ -166,11 +211,22 @@ EXPORT_SYMBOL_GPL(wbrf_supported_producer);
 int wbrf_add_exclusion(struct device *dev,
 		       struct wbrf_ranges_in *in)
 {
-	int r;
+	int r = -ENODEV;
 
 	mutex_lock(&wbrf_mutex);
 
-	r = _wbrf_add_exclusion_ranges(in);
+	switch (wbrf_supported_system()) {
+	case WBRF_SUPPORT_OTHERS:
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		r = acpi_amd_wbrf_add_exclusion(dev, in);
+#endif
+		break;
+	case WBRF_SUPPORT_GENERIC:
+		r = _wbrf_add_exclusion_ranges(in);
+		break;
+	default:
+		break;
+	}
 
 	mutex_unlock(&wbrf_mutex);
 	if (r)
@@ -194,11 +250,22 @@ EXPORT_SYMBOL_GPL(wbrf_add_exclusion);
 int wbrf_remove_exclusion(struct device *dev,
 			  struct wbrf_ranges_in *in)
 {
-	int r;
+	int r = -ENODEV;
 
 	mutex_lock(&wbrf_mutex);
 
-	r = _wbrf_remove_exclusion_ranges(in);
+	switch (wbrf_supported_system()) {
+	case WBRF_SUPPORT_OTHERS:
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		r  = acpi_amd_wbrf_remove_exclusion(dev, in);
+#endif
+		break;
+	case WBRF_SUPPORT_GENERIC:
+		r = _wbrf_remove_exclusion_ranges(in);
+		break;
+	default:
+		break;
+	}
 
 	mutex_unlock(&wbrf_mutex);
 	if (r)
@@ -217,14 +284,23 @@ EXPORT_SYMBOL_GPL(wbrf_remove_exclusion);
  *
  * WBRF is used to mitigate devices that cause harmonic interference.
  * This function will determine if this device should react to reports from
- * other devices for such frequencies.
+ * other devices for such frequencies. For example, for AMD ACPI implementation
+ * it should say true only when the necessary AML code/logic supporting wbrf
+ * feature available for this device.
  */
 bool wbrf_supported_consumer(struct device *dev)
 {
-	if (!wbrf_supported_system())
+	switch (wbrf_supported_system()) {
+	case WBRF_SUPPORT_GENERIC:
+		return true;
+	case WBRF_SUPPORT_OTHERS:
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		return acpi_amd_wbrf_supported_consumer(dev);
+#endif
+		fallthrough;
+	default:
 		return false;
-
-	return true;
+	}
 }
 EXPORT_SYMBOL_GPL(wbrf_supported_consumer);
 
@@ -267,11 +343,22 @@ EXPORT_SYMBOL_GPL(wbrf_unregister_notifier);
 int wbrf_retrieve_exclusions(struct device *dev,
 			     struct wbrf_ranges_out *out)
 {
-	int r;
+	int r = -ENODEV;
 
 	mutex_lock(&wbrf_mutex);
 
-	r = _wbrf_retrieve_exclusion_ranges(out);
+	switch (wbrf_supported_system()) {
+	case WBRF_SUPPORT_OTHERS:
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+		r = acpi_amd_wbrf_retrieve_exclusions(dev, out);
+#endif
+		break;
+	case WBRF_SUPPORT_GENERIC:
+		r = _wbrf_retrieve_exclusion_ranges(out);
+		break;
+	default:
+		break;
+	}
 
 	mutex_unlock(&wbrf_mutex);
 
diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
new file mode 100644
index 000000000000..40c59e9f626d
--- /dev/null
+++ b/include/linux/acpi_amd_wbrf.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Band Exclusion Interface (AMD ACPI Implementation)
+ * Copyright (C) 2023 Advanced Micro Devices
+ *
+ */
+
+#ifndef _ACPI_AMD_WBRF_H
+#define _ACPI_AMD_WBRF_H
+
+#include <linux/wbrf.h>
+
+#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
+bool acpi_amd_wbrf_supported_system(void);
+bool acpi_amd_wbrf_supported_consumer(struct device *dev);
+bool acpi_amd_wbrf_supported_producer(struct device *dev);
+int acpi_amd_wbrf_remove_exclusion(struct device *dev,
+				   struct wbrf_ranges_in *in);
+int acpi_amd_wbrf_add_exclusion(struct device *dev,
+				struct wbrf_ranges_in *in);
+int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
+				      struct wbrf_ranges_out *out);
+#endif
+
+#endif /* _ACPI_AMD_WBRF_H */
-- 
2.34.1

