Return-Path: <linux-kernel+bounces-14069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944BE82178E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043D0B213FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDE15D0;
	Tue,  2 Jan 2024 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vH0MrUMz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9515BD;
	Tue,  2 Jan 2024 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diczHLnGZrWzA3diTBvvYV4eh3sO9y5iEWHdgBwna+yemgzrAn+O2eJjg0PC5lMO055RWNYBLteSNLQyE0C+3YsG0AxKLOzJSQTZ15JaNubNqO5omUzkwd8zgnDYE/1ycQR/1LJSDQckBwPSG61MABIq3d0C0TqP2IVGW550zHCsXFyeamrvir/N/hceRqdUOqPWvXVGBvdNEQ51nC2dq4bfcAMA9KJttOlHO8nC6Pzlov/O/+UaJZoTEQmT+MdmnfxzX7RcFXhTShSJnQ2alPLsxvnO1uDk/WAZ4zh6hemD0sf9nN8GFkcq8AQ+GY9/alylAJhE6xRwi7Ntj7UPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMrsbX8uvYop4T2UQBj0PZ/j2n7JwWg8xvHJ4uCDyHU=;
 b=GwHneW+LpwMilFxsP7PeKCCnjIDcaLmnzKC7+R/cD9Yco2Fb5Qpd1XWmUxHPt2GhLFrHVwhKsGNZ/X8DPKAeiS96Ua7aqp1bxPuctXIBP4w7aloChT9yez3ALYc1KXV/39+Fc9Qa+ytTjftiK7WKLJMMvkS3vIIfD5nhQ7BcZX7PfWoczDqss4AJJ5To5KNfeeuk/CToGO606PrTwDTDSatzlUNK7KgU9BQFlIeHvpGFiFahDIaJvAXdjJPcqHQqbb9KOgJcIjtZD4hQCBJ910wN7DIj72hxx1SqttT7dcSMSMCFjF1AywFpBXpKIob6BODHjL5/Hq/NHuzpw3B+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMrsbX8uvYop4T2UQBj0PZ/j2n7JwWg8xvHJ4uCDyHU=;
 b=vH0MrUMz7x2lvw89iSV8lw1XkOh6vTfgAczF7xidCexDg/kTopGJJHq7xnyGMq75ASB/613kh2UePeyElEp4R6ZLiH3eSMNMBFq6JmfvF/aIo2oBFsWpHfCqjM0yhs6saBYMJmG9rZqLNeoWhOc0Me1hVNJPwR1VuHgajRZDPVA=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 06:01:44 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::ff) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 06:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.1 via Frontend Transport; Tue, 2 Jan 2024 06:01:43 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:01:37 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 0/3] perf/x86/amd: Miscellaneous fixes
Date: Tue, 2 Jan 2024 11:31:27 +0530
Message-ID: <cover.1704103399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 48058cc1-0778-475b-fd8e-08dc0b584bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g24GCR11SAHAXq0qOrwOKypN4wz+l6Orvjse/CKWZ36it8zaiVX1g8RDMClvl+K6j044ieGPWbaJ6C43cYA716e/nVeiXDfPP8R3Qmyd5Yqczh3jkc31sN2Q1F0XqBw1TjpYNkmx1IRjgKXVwCaBN+D2Yia0xFEjNHOzaLnD+rr87kjvk8tBVonaH0S2F8tIKgtajSIJ5ARk6g/KWrGZLApc1HdplcC3XHa8NenncT8pKOwKhDl1DFdOErN2KMIAVOsifUyw2WI0Xdqf0FupKUWSSAw2xK7SBS1780lyf4PEiSJ3wQKFz+l/3X6JbAOPrXHzZBomRVHvCqy1ZSsNDUQ8nPqolkIU9uDF8RSaEU1JPPdwz6FYE06gzoCNAj7fbO55HgE1ToFtiAPzAH+baJdYgWh9ZDBVVgOiZlfNxPOJ6j4PtZMtyq1hQrRJPeXOibfDRm9TpZw8oxCUimbXQah+YIw40YHc3OoZbK7t62LD+CcVIn4IlgUlk4YxPWkuzJzdY7l5Y64qXP+7wYJRD2Ezcq8GzbGFSC31aaFC7y+pmb5bSnzEolU2a0CNDsR+rX7YxEFkRT9KvcPENq2XbyLrrnw+97TLsMYBPzqGNULVaIDj30QEsuKyrIZSbLs6Kdu+qlCKkVL35WZ50bBJTNTpufNPv5JqarxRyK9bDcyciKOVR/Iv3F8+Hy/nQaGDBYVZupE7vlDP54kNMaoirxS+Jsm6fRI8X1cN8KcLOe1VliSCHANZ4BfM2LFFR60LIgZEDlJZFj3N6LSzRIa3qA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(16526019)(336012)(2616005)(426003)(83380400001)(26005)(86362001)(81166007)(36756003)(356005)(82740400003)(44832011)(5660300002)(4326008)(4744005)(7416002)(47076005)(7696005)(6666004)(36860700001)(70586007)(8676002)(54906003)(8936002)(316002)(70206006)(110136005)(478600001)(966005)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 06:01:43.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48058cc1-0778-475b-fd8e-08dc0b584bd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835

Contains fixes w.r.t usage of LBR Freeze, Erratum 1452 and a bug in the
CPU offline path where PMU-related registers are reset.

Previous versions can be found at:
v1: https://lore.kernel.org/all/cover.1702833179.git.sandipan.das@amd.com/

Changes in v2:
 - Make the LBR and PMC Freeze feature bit visible in /proc/cpuinfo. As
   suggested by Stephane, this will be useful to determine if it is
   feasible to perform kernel FDO on a system.

Sandipan Das (3):
  perf/x86/amd/lbr: Use freeze based on availability
  perf/x86/amd/lbr: Discard erroneous branch entries
  perf/x86/amd/core: Avoid register reset when CPU is dead

 arch/x86/events/amd/core.c         |  5 ++---
 arch/x86/events/amd/lbr.c          | 22 ++++++++++++++--------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.34.1


