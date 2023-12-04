Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D37803E51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjLDTZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjLDTZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:25:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418ACAC;
        Mon,  4 Dec 2023 11:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWASpv4QpB0JBj4i6m901JgCLSMt6SIfCK0ImXCKnW6NHaY9lbHCqH9wUzorJi8k5HiAa89ZuQLmGLPe6WfgCSRj9VATJxpfkuLQkJXDP5kxMxe2T1+sBDnGnr/o0Mzyrav+CtV0z/EX9D0V2xjmIPErl39TaN3zSbzztuuDZMq745e/J9FFIYinv/YXvfk8tntY1fOA7lqbHHmq9/wg5EmFrYgJSSn/0dEj1jDwxi/+s3LPX3WpzKSv1lRDorCSu0MnIas51+5LVBBSg5t8FLFuqwboRaLgEgkrMLNYLy7gUfMB45w4y/7rzJe10SD/JqvW9f+VaxwyZtMaKP7D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIIrVQD7Blcxal0v1wSCdlsgvbsn/rgELU4GEZoQM2s=;
 b=lvLJrmdogDIoPHlYcG3KHlIW1lJg+PFdw+uLoZkR75n0/Rcq8+MIfJ+Q1oNhOmEUyaixQNymiuvRX4Y6maS9iPLUPWCX2QQWST+40WlrWdBm8zDn85w7Gn58m59PLccLgznOR7HhcQWRUeTYpUt4XQxNzCNgVEMTKYHmCYhpbBtdQF+fF0QI3EZcSgH4+vTkfqVshd471GRCngEozq2HJs+/dJgoXL35LD7qMyUHLKO9YMA/ltIGB4aXsS3MZ3VIiKXRhZypug6fUGmblM74uE39fQU2d0yReF9KTt9iJ/UvOu/wfXNCy90RutIOiqWm7jQi5+KdsE780aqcSfFO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIIrVQD7Blcxal0v1wSCdlsgvbsn/rgELU4GEZoQM2s=;
 b=WEJT/iY/7sWVcpS1lR3B40kqZkXpHFheETskJxUpcvl/AJW6Rk+HXL85ZZOuizjLUK0mq52YjqD4j7lGJbgVHcCJK81FRMqUMc0VxOB/cLkuoJk2+S0Qeule7tiWnh6XFHF16GPr3qL5rHU7/XJEJhefn/C5UjrTIdZbCxCxwFw=
Received: from CYZPR12CA0018.namprd12.prod.outlook.com (2603:10b6:930:8b::10)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:25:56 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::db) by CYZPR12CA0018.outlook.office365.com
 (2603:10b6:930:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Mon, 4 Dec 2023 19:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 19:25:56 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 13:25:55 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
        <avadnaik@amd.com>
Subject: [PATCH v3] ACPI: APEI: Skip initialization of GHES_ASSIST structures for Machine Check Architecture
Date:   Mon, 4 Dec 2023 13:25:49 -0600
Message-ID: <20231204192549.1953029-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 7938f70b-bb42-48a8-71b0-08dbf4fed6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38htsoyyW5tMgKhqQ5o8btHLOKBbdPQCUtxkp/OBpCSdmd1rQuj1IFL21pri1tpZ0pGS5qPRN1486Ug0k/Z/2sdM4V2nwe37EpKWcK0HnlUnmy2whIrhTcFN6rWBCmRJbuhJjN0OALmmD7lC9+quKaMfMTCGcgJOiMEzOJi7zy175vbG/hu2CY0gvgBhiJY1QThnAeQKSrzrHCsBowweRWC0ZaclvCiOWpKJ+4+ggKrH36FNJEnZGM3Q19zkAqwahKMwuJcqfm0tPGtSwg1fI6yqZR6+GDocsFprWCcYsnoIWAg0qu3266EWPDPNidJT9B3/6Yy23z9dEHDIsAHno0LxMo1P1aOfDUEr4FQEQjFfXw3sGmlEwnX+2m/zY7gL5XyD42J0FydzFHJZbwAGbkR11eoIm7TzHftE99zWqp+Q4aczjMbxC3Ng2YFNRvNEe6iHPIy5xtIirNA+RHv7e+HFyO0//bBSMo+GF8pEpxrHB8KLFACg49YhvJtq6D7LC3KM7OVlPXAbCJbx9wzsK6TT6YDAgQ8sVOz3ZvJ52dO7qE00HGe6coQgZwmJbNaPglufODv1XFUiD+B7jF/Ctf6BWt3k6V2znIq10ubCWB2WtB11+tir7YB1qWh1iUtLzaegqO6zTvT62DO+jqHIT2k+MOcmkd/qLC6QAtq/ktx7sIJqGa7rQ/JtSEQXnPIsN3L+UdfpeHViVHdrYXzT/xxlWKh2YHE/AiQNS20L6UDhEfiR89vx0hOw19G9XI/zQoMX3CJusIhlC6SgMOgFZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(26005)(336012)(478600001)(83380400001)(16526019)(47076005)(7696005)(6666004)(81166007)(356005)(426003)(1076003)(40480700001)(82740400003)(36756003)(2616005)(316002)(6916009)(54906003)(70586007)(70206006)(36860700001)(5660300002)(4326008)(86362001)(8936002)(8676002)(2906002)(40460700003)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:25:56.6643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7938f70b-bb42-48a8-71b0-08dbf4fed6f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
a set of GHES structures is provided by the system firmware for each MCA
error source. Each of these sets consists of a GHES structure for each MCA
bank on each logical CPU, with all structures of a set sharing a common
Related Source ID, equal to the Source ID of one of the MCA error source
structures.[1] On SOCs with large core counts, this typically equates to
tens of thousands of GHES_ASSIST structures for MCA under
"/sys/bus/platform/drivers/GHES".

Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
such, the information provided through these structures is not consumed by
Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
to provide supplemental information in context of an error reported by
hardware, are setup as independent error sources by the kernel during HEST
initialization.

Additionally, if the Type field of the Notification structure, associated
with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
sets up a timer for each individual structure. The duration of the timer
is derived from the Poll Interval field of the Notification structure. On
SOCs with high core counts, this will result in tens of thousands of
timers expiring periodically causing unnecessary preemptions and wastage
of CPU cycles. The problem will particularly intensify if Poll Interval
duration is not sufficiently high.

Since GHES_ASSIST support is not present in kernel, skip initialization
of GHES_ASSIST structures for MCA to eliminate their performance impact.

[1] ACPI specification 6.5, section 18.7

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes in v2:
1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
if-else-if chain is redundant. Replace it with just if statements.
2.	Fix formatting errors.
3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Changes in v3:
1. Modify structure (mces) comment, per Tony's recommendation, to better
reflect the structure's usage.
---
 drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..20d757687e3d 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
 
 static struct acpi_table_hest *__read_mostly hest_tab;
 
+/*
+ * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
+ * structures for MCA.
+ * During HEST parsing, detected MCA error sources are cached from early
+ * table entries so that the Flags and Source Id fields from these cached
+ * values are then referred to in later table entries to determine if the
+ * encountered GHES_ASSIST structure should be initialized.
+ */
+static struct {
+	struct acpi_hest_ia_corrected *cmc;
+	struct acpi_hest_ia_machine_check *mc;
+	struct acpi_hest_ia_deferred_check *dmc;
+} mces;
+
 static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
 	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
 	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
@@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
 		len = sizeof(*cmc) + cmc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+		mces.cmc = cmc;
 	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
 		struct acpi_hest_ia_machine_check *mc;
 		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
 		len = sizeof(*mc) + mc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+		mces.mc = mc;
 	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
 		struct acpi_hest_ia_deferred_check *mc;
 		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
 		len = sizeof(*mc) + mc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+		mces.dmc = mc;
 	}
 	BUG_ON(len == -1);
 
 	return len;
 };
 
+/*
+ * GHES and GHESv2 structures share the same format, starting from
+ * Source Id and ending in Error Status Block Length (inclusive).
+ */
+static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
+{
+	struct acpi_hest_generic *ghes;
+	u16 related_source_id;
+
+	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
+	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+		return false;
+
+	ghes = (struct acpi_hest_generic *)hest_hdr;
+	related_source_id = ghes->related_source_id;
+
+	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
+	    related_source_id == mces.cmc->header.source_id)
+		return true;
+	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
+	    related_source_id == mces.mc->header.source_id)
+		return true;
+	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
+	    related_source_id == mces.dmc->header.source_id)
+		return true;
+
+	return false;
+}
+
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
 
 static int apei_hest_parse(apei_hest_func_t func, void *data)
@@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
 			return -EINVAL;
 		}
 
+		if (is_ghes_assist_struct(hest_hdr)) {
+			hest_hdr = (void *)hest_hdr + len;
+			continue;
+		}
+
 		rc = func(hest_hdr, data);
 		if (rc)
 			return rc;

base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
-- 
2.34.1

