Return-Path: <linux-kernel+bounces-19458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A9826D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5205C281A9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6121A15;
	Mon,  8 Jan 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ql2SB+TV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1712575D;
	Mon,  8 Jan 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjmPQ4OdHAkQn+C/6Z1dCdj/MfhAOX9pvylUeyMbCoLsY5uANU46yDLcGeLoKTjY5ZeEqBzwgNVbFHSvzLvicQt4eV4cRE0Yt+JC4LQC/WlVxU8zR+doHyv9EJZ/1zvsf1bwQOvySIxQKxa+CdibWA5lWgIk3YThxADm6pftWUZgANX/hTqs5ecSd1mKjrPhsyMoMkGveOKOnuAi7vx+9l7FeOe3Qb4kttoFH16gzYlF9Y8JMai7DoFfouhMGGTYxevkBP9M0q/FmV9lBsx+ehPsWPP8rj8j64aOJQSl8hxhCvuprH8Z72Cf8Lu4bgBx48NiugN5enSpHsiJDiMqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79adfbqzxe7Iw/HSPcanom0+XiQ5cw74aFMumeN2m1Y=;
 b=kSVnTXY/RLIBZeBW34sl7UGr4ABqhPJeMIgWAGwx7dim9SffnH05ThEJHXygPq4ATyZyQAq12dFEAt3CNzXggA33GSl4pLwPAU3Miw6f7zJiDEf2QSpse08cua8afzYCOzI+6qkgsvsudjzusn73GmjWFq3BxqtV7w6yNWF0P4c4k8A0CVuKCUKAHHurIMp5b5c7oDCIgCMoY0IZBCBPqSUT/GcAqqa0Xts85jEDVyj3QRkHRVGgpGAFitqZnPShqoDZXmWx0cZ3AopX2uuApH8FVeo3tUuv+TR3fp2w5nScNqaVDWpIjps09YKIwpTjN8HZG0ZH60RfUV6NUc/m0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79adfbqzxe7Iw/HSPcanom0+XiQ5cw74aFMumeN2m1Y=;
 b=ql2SB+TVTFZYzZ9hOWh1HRhbW/LVGcmGPmOBFHOWgdVRQt21/+pRXbSXofdkwUCed4FFNKeVEkhWF/ZrIkry8adOUZXgT+j0DXwvQuDXDQFjLHcRP35RQuCOYVOh5FnZ96jhxX0OOsD8/5ryjFEeZu7+jw4qKvLAp1oGzdawPNQ=
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 11:50:10 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::fa) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 11:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 11:50:09 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 05:49:18 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Len Brown
	<lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
	<linux-acpi@vger.kernel.org>
Subject: [PATCH v2 3/3] lib/firmware_table: Provide buffer length argument to cdat_table_parse()
Date: Mon, 8 Jan 2024 12:48:33 +0100
Message-ID: <20240108114833.241710-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108114833.241710-1-rrichter@amd.com>
References: <20240108114833.241710-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 26138389-7e54-476e-6f9b-08dc103ff74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ONRBZRRak85LIQFJAA4VovCD/FLT2K7so3VdYEUjHOBc1G8Bog94niROSFMN28gMG3Ja2mkugX0mDcTewDOeF/CodiiYsWfQFHY1Bazted5HNTiQFgRhg1643N0RZ0WZtwltLmGk839fUj71o75HW+wkU8vRYVd0AzY7YmbKj2syx/Vg8oTQoHFtOvlugm2hgQTHDNHYXhI7LBN+KtAtwe0BvIqvNSv3/ocjj/1ZGG1G9QnoFvjnO11SFTnYhv/NYLG7Y366Y1ymSvK7I9SdNokcj0phsAhhzEzDX59Hl/IIJoJS/R0hbB5WzpabEP1Ew/A+lDfYbt9JxXnOaCk1Qm3EjYrj6UsYVMoNRMY5QD5qH91ybOrnpffXfAhmmIHZGgpA8YvvGCF8JeQN+aucFPgS+PWwES9e+XNE1D1xIYAQNSDq1JVhc6VMsqcR7DwKjriTrPvab3uEYKUiJ8YXS2rJrJdgMImxI67ZzHW2Pd811O8rCPdufeU/qxyIBj1FMsHgB3raZVaBcwNwV7SbPUTcUnJf+vlTKz/Hp5Ma1Sh/4m8OaBBEQeTIxPX0zIN6ocZDAlRg9upSHucJt7f401bNZ1m+kdahzZ5qPSVbyWg6Kep2nCwOnjY98XE+KQh1iQcgZdHvobC2rd2CCrLauut9gzYUEGBX0/6FIIS9r8S0aDrw+MvXWZWO0uKBplQQG6E+odtoPVZhTtB+FltvtJEE+/WSzNIOJ0dvX9Y/Ul+fG4kWM7z/HTUvxYuSL8/j3A13qHrq2D3XUo3ZgFcZ4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(6666004)(478600001)(40480700001)(82740400003)(47076005)(40460700003)(81166007)(356005)(83380400001)(26005)(426003)(336012)(16526019)(2616005)(8936002)(8676002)(110136005)(7416002)(316002)(54906003)(5660300002)(2906002)(4326008)(36756003)(70206006)(70586007)(1076003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:50:09.7305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26138389-7e54-476e-6f9b-08dc103ff74f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529

The last entry in the CDAT table may not mark the end of the CDAT
table buffer specified by the length field in the CDAT header. It can
be shorter with trailing unused (zero'ed) data. The actual table
length is determined when reading all CDAT entries of the table with
DOE.

If the table is greater than expected (containing zero'ed trailing
data), the CDAT parser fails with:

 [   48.691717] Malformed DSMAS table length: (24:0)
 [   48.702084] [CDAT:0x00] Invalid zero length
 [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22

In addition, the table buffer size can be different from the size
specified in the length field. This may cause out-of-bound access then
parsing the CDAT table.

Fix that by providing an optonal buffer length argument to
acpi_parse_entries_array() that can be used by cdat_table_parse() to
propagate the buffer size down to its users.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +++---
 include/linux/fw_table.h |  4 +++-
 lib/fw_table.c           | 15 ++++++++++-----
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b07f7d091d13..b976e5fc3fbc 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 
 	count = acpi_parse_entries_array(id, table_size,
 					 (union fw_table_header *)table_header,
-					 proc, proc_num, max_entries);
+					 0, proc, proc_num, max_entries);
 
 	acpi_put_table(table_header);
 	return count;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6fe11546889f..012d8f2a7945 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 	int rc;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
-			      dsmas_xa, port->cdat.table);
+			      dsmas_xa, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		return rc;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
-			      dsmas_xa, port->cdat.table);
+			      dsmas_xa, port->cdat.table, port->cdat.length);
 	return cdat_table_parse_output(rc);
 }
 
@@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 		return;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
-			      port, port->cdat.table);
+			      port, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index 95421860397a..3ff4c277296f 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -40,12 +40,14 @@ union acpi_subtable_headers {
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
 			     union fw_table_header *table_header,
+			     unsigned long max_length,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
 
 int cdat_table_parse(enum acpi_cdat_type type,
 		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
-		     struct acpi_table_cdat *table_header);
+		     struct acpi_table_cdat *table_header,
+		     unsigned long length);
 
 /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
 #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
diff --git a/lib/fw_table.c b/lib/fw_table.c
index 1e5e0b2f7012..ddb67853b7ac 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -132,6 +132,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
  *
  * @id: table id (for debugging purposes)
  * @table_size: size of the root table
+ * @max_length: maximum size of the table (ignore if 0)
  * @table_header: where does the table start?
  * @proc: array of acpi_subtable_proc struct containing entry id
  *        and associated handler with it
@@ -153,10 +154,11 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
 int __init_or_fwtbl_lib
 acpi_parse_entries_array(char *id, unsigned long table_size,
 			 union fw_table_header *table_header,
+			 unsigned long max_length,
 			 struct acpi_subtable_proc *proc,
 			 int proc_num, unsigned int max_entries)
 {
-	unsigned long table_end, subtable_len, entry_len;
+	unsigned long table_len, table_end, subtable_len, entry_len;
 	struct acpi_subtable_entry entry;
 	enum acpi_subtable_type type;
 	int count = 0;
@@ -164,8 +166,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	int i;
 
 	type = acpi_get_subtable_type(id);
-	table_end = (unsigned long)table_header +
-		    acpi_table_get_length(type, table_header);
+	table_len = acpi_table_get_length(type, table_header);
+	if (max_length && max_length < table_len)
+		table_len = max_length;
+	table_end = (unsigned long)table_header + table_len;
 
 	/* Parse all entries looking for a match. */
 
@@ -220,7 +224,8 @@ int __init_or_fwtbl_lib
 cdat_table_parse(enum acpi_cdat_type type,
 		 acpi_tbl_entry_handler_arg handler_arg,
 		 void *arg,
-		 struct acpi_table_cdat *table_header)
+		 struct acpi_table_cdat *table_header,
+		 unsigned long length)
 {
 	struct acpi_subtable_proc proc = {
 		.id		= type,
@@ -234,6 +239,6 @@ cdat_table_parse(enum acpi_cdat_type type,
 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
 					sizeof(struct acpi_table_cdat),
 					(union fw_table_header *)table_header,
-					&proc, 1, 0);
+					length, &proc, 1, 0);
 }
 EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);
-- 
2.39.2


