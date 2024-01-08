Return-Path: <linux-kernel+bounces-19455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86764826D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E71B20D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9B219E2;
	Mon,  8 Jan 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="moOlMLas"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5729415;
	Mon,  8 Jan 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITFhNkFfcfk35Aw2jg2K/nT8FC2d8mTidnw2G7NAhlRR6I4buI+4WnTDR23jyjtTJNCUppJ0B9l+EfoI/bLdQeQ+cSGgeX4ytK6yahfWvSUhA7ZtHtBDna6hz31vL1tVtb8BzM/e3u+5ONdqfIIMhqDl8kw0S9RY3LU0npa524vW5Ht0OvAQRDc1FPaCNDqHjHsFkIfryRhdSuy0Xu8GiPhONpmMw1E6G6u5PQ5P3gmp2ZGxNihek8BRZM2naUGfcSuD69yb668B+6Lcxi9GnKc1hmsG8B3lHk+M0RQG+Z0VK2tssh+E35E3nJjF6y7hLlwdwoCk5ow2bpkJRsGtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E42vZcZ2BbEHi75k9DFeMkkatq2SZZjHE5MFSQWyd5g=;
 b=RCBxzn38RwPSl99UVjrDijtP64pWZnEYA+0TPO7ixJkWqBPd/muo3s3u1F2YOxK80DalxwxgnIxM0YVz9Wur98On/vjZ9poDA4xr/xF3EM/TJNov77mQSqiBBEJT5zM/qYluPTynJmB2X1elzM9/+96K12eZKJrV081rE+AWi9vkCEpw/g/yiIOG3FnCnERGRahc0+zBKpKOBz1SrRYFrtOEWr47raY8BxCoXvUskp2XexNNfYJQhpQICKLYnJ30Ay0CcZe/uMYtO9PMIJ9DTmxrqwdbLA4H9RxPSfCe0GwWldz4xhE8yB2AauhNFwigySeUbChM+lDjNR0+Xt8Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E42vZcZ2BbEHi75k9DFeMkkatq2SZZjHE5MFSQWyd5g=;
 b=moOlMLasLi/VZ+ST/9//WvckUcxZVLRHXJQ6MUCaVGRESGMpsFSVOSov8PoeevNhvs+BZPTeIxfCKXI0X4k9QWbTKEaImATxk7q9xubIVKVubVHl9BuR9A6ec21qMXp+HFnEfjeliVuGLtfq+gzWCdafqqVLJk67RCo9DCbzRp8=
Received: from PH8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:510:2d2::19)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Mon, 8 Jan 2024 11:49:11 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::4b) by PH8PR15CA0022.outlook.office365.com
 (2603:10b6:510:2d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 11:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 11:49:10 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 05:49:07 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH v2 0/3] CDAT updates and fixes
Date: Mon, 8 Jan 2024 12:48:30 +0100
Message-ID: <20240108114833.241710-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 4963e9ea-aa66-4595-4368-08dc103fd406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bHuw+X8CBxC1M8Cb+gh+YAY6g8Pk/l2SUlrRlXYbCFRgrIslqZFTHc+PccIwbmlwWq74XUVWaHDw4KxMoIMcV37POCmjAodF1VndIwyuW9YYkpXhrAVK6CivzUJEumqSWxqsQYARkL1KnOJMovd16euwpl0pExReQzA2AneSj3cY2ga/Lb/RpDNjFdJcj2mlzDVih8zmWdDs+Q2pVTToDqzcD0aUObvjr3wCB1EUWmS6lQzVLa9EAhqAmWcXKYi0yosQgKVkkjWG3bslNLzM8UWeC67tl99655hyIErLE0IlpyJi01ERUsB64gt4tEvp5rr4R/Eh3d8rwuLaxQsyrTZQ5Fx1Y+0WSCNdORIKDBb11PzSjBO5VWE74IcoIxYhfhVaw++iqym3LpZHjgoHySgg2Ikdi5cRUqSdPLlKh3C3vwJn7QSts/Sulh2eNpgGscCudkVDkpp7rl2Zyi6PRXl44/3DYB9tdLbH8JALHTqcBmaXzj0F/+4+v1k9sbkmb1UpxnKKaqRS5iuJTwSD4/aqIGMn8mq8DNrq3DRE8Zenot1o1qlfhLWVe1DmAZZ4cQeQjlbTSFtMYs5h+MgD2LIn+r+Lt9E4jCk8tnfdmeHgXO7y0rgE8Zxq76mqRNMCK1eg9OH4FQM0xophy6iXzyeG2z60YBxNmmKx2Lhs5plbBvoxyaUqbCLHmbxFh/crWsG/2qrQt16eChtE/lmU96OATErWwvikeM5lSlkbeNmxLvK167Vn2nDwcMwU1hpRrvVCxuYowKvhjz02EdM2gQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(26005)(2616005)(1076003)(426003)(336012)(6666004)(478600001)(966005)(82740400003)(36860700001)(36756003)(356005)(81166007)(2906002)(15650500001)(5660300002)(7416002)(41300700001)(47076005)(83380400001)(16526019)(110136005)(70206006)(54906003)(316002)(70586007)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:49:10.5150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4963e9ea-aa66-4595-4368-08dc103fd406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023

Some CDAT related updates and fixes. Patch #3 does not depend on the
previous patches and could be applied separately.

See [1] for v1. There is some rework going on [2] which might require
a v3 for patches #1 and #2.

References:

[1] https://patchwork.kernel.org/project/cxl/patch/ZVfJ6Fxidvw_gz7r@rric.localdomain/
[2] https://patchwork.kernel.org/project/cxl/patch/170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com/

Changelog:

v2:
 * rebased onto cxl/next (e16bf7e015d7)
 * renamed struct cdat_doe to struct cdat_doe_rsp and also local pointers
   accordingly to buf/rsp.
 * added comment that the CDAT table has space for a DOE header at the
   beginning
 * use DECLARE_FLEX_ARRAY() macro in struct cdat_doe_rsp
 * moved the rename to doe_mb variable into separate patch
 * added Reviewed-by tag
 * added patch: lib/firmware_table: Provide buffer length argument to cdat_table_parse()

Robert Richter (3):
  cxl/pci: Rename DOE mailbox handle to doe_mb
  cxl/pci: Get rid of pointer arithmetic reading CDAT table
  lib/firmware_table: Provide buffer length argument to
    cdat_table_parse()

 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +--
 drivers/cxl/core/pci.c   | 83 ++++++++++++++++++++--------------------
 drivers/cxl/cxlpci.h     | 19 +++++++++
 include/linux/fw_table.h |  4 +-
 lib/fw_table.c           | 15 +++++---
 6 files changed, 78 insertions(+), 51 deletions(-)


base-commit: e16bf7e015d75fdd805528bedaf285fcb71dad2a
-- 
2.39.2

