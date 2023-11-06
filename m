Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CD7E2E03
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjKFUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjKFUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:14:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E4DD7A;
        Mon,  6 Nov 2023 12:13:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLCOY3i2+U5/Y0v1eclX6yWn3EpvhaoM+d1eG0Cadnfm3vUxBVtCAXitpViP9lURhDNkXUKQKyCyiI+cuB8kBRw9+Tk1LSrgQ/RbTrf+eEiYj89yqJO5W0WebAJ3PgFwuRZc8iA//Y9yCuu1D4EFPPLkU/ees/yMb26ut4hnsXL52Cz8JUvWr5dv1bSy9kZu27H6PaLe3VPSIzsgZ4Bx6j+KQrCoBdQiPvIUhmb3nVpzbMHynDYYIrCP8QUhMV3N9h6HgDa6Fj6ncamR/HVrPz4LM8/bLqYkMaBkhhp4yydHnJb8tIwvSjUtKwi6IvRQ210DC8mETL0jR8fQssQIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5yFwW4bJBzc9wiGkvNlR6JmJ9T+ygeNqKtVaj1/fXw=;
 b=V0FzwGHx9z/vxSmrR0LN/NpnrQIkEnxoS8s8DGMjvUCuNTMfTgeijoQuO+ZYBDM+2IW82fV2+k729jISi41PsamEAlGQVJ3cHb7BwxzGS1en5q18Nyyh3icMMziQUXHwzY1+nEyNQhHReT3EZE437cdETYP21RHfXPNJa3vq77Vc/bm4pBTrp0iVde8S37WZzwhsrj3EuerEFjIc1JBz1DuSE1m10Jas2NgU+sYCHMOzvk66uy7tIyAc+O1HX0uJURYJBeWAelLdnFmAsl8NqthRZFjZg5MjHaHzNP3MrOtdyjPlrikNSEl1SF9kym78xv2u2aMX2YmtM2m9m8C3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5yFwW4bJBzc9wiGkvNlR6JmJ9T+ygeNqKtVaj1/fXw=;
 b=yiN30DHVtuUSF6FdSodF2y8qQMuUXq46wBXCrVD4gNZobZUXi8JqzAM3wbvl3BOjJRF5lk0MJmFNmn0hOBQTRedE9aB4a1ML83oEm9KwM+9+eqhO1pEHeP4cZBz+n0Ti81KrzqKOpLUBh6pdO7Nzk7+EDgKr28oSr8P9xIOgUAU=
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:13:52 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::df) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 20:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 20:13:52 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 6 Nov 2023 14:13:51 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
        <avadnaik@amd.com>
Subject: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST structures for Machine Check Architecture
Date:   Mon, 6 Nov 2023 14:13:40 -0600
Message-ID: <20231106201340.434878-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eef83a9-3b83-47a9-439a-08dbdf04e555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNjfxkVKBbCqQGs1gHZbBkBiS9gccIWb4R3rxJNgj3tNR49HlQDmMXJ+/Dt8SbAnKP6Ct+LsS/ITmfvzlO0qpDKl6XcTgusAbN0rhH9NTxJ4CRawZSu/RbA+FXusp5eEwobbr8KxHoOE5O6dMi+00nLfdG4mgRJ6uVdk8WKl8tsuFhgOK12xro6AcDQUr8bSRg/d8YLak6+nspuBeJDcVBiZIK5rUZWCVtSeZNPjr/hpEixnjeqJb3x9YwadYmIx9PQ05WyHUsgWGHrG0S/RnIVi7x/TlGnT2H0jwgxenn3QvO6Oy47huWJJdyQV56rhBb7P8TQTuNS7xhUDc2d0L51JwVngat7nj7BN9C3CD/nYHsBH9WQJkEgofcxkcUMEGHM6v9s3xiGjzaRll6Gbnpeq+yq1Du0+D6+ApJqp+MCHqAUbV6OVMSbuDKfabAlJc/hgqzrWPeZHlIS/SQNulsBP2gOs585baLNjhO2ljCfBnKx9VH9+qu7P86VwDULjlAjJIXLkazi+NrneWaIyUd/p1AHtQNe5psfhZenyPH7C4PmwT8zcGarP2UtpqoYvKdmIoKDt+NRwKJcuT8IV8o/8yqpMNzFWcPVnHk5uES3m9m/kwVdqObO7GFWlxi7UVwl6fcSuCcz+6Np0KkgP1/iy4Irf3EDVdoPxQrU1h9J/FvzXKK8UFTxqQcMWqwuVeY3WtRr5H1Qi+lVcobyjs9f/hrQzqydv5vV48Gbgcs0Vz6uyfZmI8hJq+5H4wXFVPk4njUMnN0QcMrw/ei4W/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(2616005)(7696005)(6666004)(478600001)(83380400001)(426003)(26005)(1076003)(16526019)(336012)(70586007)(47076005)(5660300002)(54906003)(41300700001)(316002)(6916009)(44832011)(8676002)(4326008)(8936002)(70206006)(36860700001)(36756003)(81166007)(86362001)(82740400003)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 20:13:52.2553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eef83a9-3b83-47a9-439a-08dbdf04e555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
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
---
 drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..99db7621adb7 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
 
 static struct acpi_table_hest *__read_mostly hest_tab;
 
+/*
+ * Since GHES_ASSIST is not supported, skip initialization
+ * of GHES_ASSIST structures for MCA.
+ * During HEST parsing, detected MCA error sources are cached.
+ * Flags and Source Id fields from these cached values are
+ * then referred to determine if the encountered GHES_ASSIST
+ * structure should be initialized.
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
-- 
2.34.1

