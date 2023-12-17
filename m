Return-Path: <linux-kernel+bounces-2740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6954A816132
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D391D1F2644A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF48481B0;
	Sun, 17 Dec 2023 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5TiMi6JG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518047F63;
	Sun, 17 Dec 2023 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe8NpMkzH5vkj2gQBI5yadd4GeWy7deIyurA/tP+1CPwP+tmvzuP71PHzVL8S6opkZEBk2mEGv2ydAF05KPOGkiYAgz1lNFxT/Ym/NcRHYRlB0ouG8WFxgyeXss1JSNnOkCCymbDC7ueWD5Bk+5uhyVZ5EM+ZqglTzLbzL+kTDJ3KDo+mrzdRPx4uIYBI5Klm/tTN78xs28ZyodwQt/C8WY3Dt+gTxDZijfjLu14FBEvdqRFPI4/1OTuZ1afoBj/3cLj4Rq0GgBdnt91isU2+XJV84pdAaTk//VWFpXT9P86AlRapRNPDVry4nz83oFF9PJcJOskDnnHd8v2Nx9BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydyLI1JyiusH1IXsvEMKMa9VpjWP+LtHHDwty7qcHak=;
 b=QyS6H3lc0KwUl6Ib5N3vDWbrP0zmu0r8GvsAgBFVHFqf0HvkAc2PRAZC7m300nbpVpWKGyndoLoUTvSNoTiSEGgGQiNEbFTULzDdD+pWhX8LRaMfmzMcNg/m/E+KnTr0Dln+A/UZ/dVSXrK8dTNE/l/BVx1H7ME5oQwzsBMI5padPvEuLCJ8A9klidcj5NZq0vggaOrRZdeQlq49Nm7SstzFo5hqCIrqNfXCMfy8ytakB7NtfMYKNqU97AGBqD4a+tIcT5YQEVvL5X/FYi9VMTxmXP66b/5vkPh6+CTnAROBL+4cXFoGafnWYq8ga74LShETD6nvR3kVAmSAe29n1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydyLI1JyiusH1IXsvEMKMa9VpjWP+LtHHDwty7qcHak=;
 b=5TiMi6JGu7/TU3wPOPE1Lbfr4gowkyqsv5/Pcegh/RI955bOaATeFToGblnNtHvKFjBHLTWt+9ErTLro7EbkkhCKgbuod+MdY4VarxrDySCn4qjjpLLfyvP0M51OoBTU7OoPqYw9pjOFoyB0qDrvNybnyM0A5DWGGABadbW+MYk=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 17:26:35 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::d3) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Sun, 17 Dec 2023 17:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 17:26:34 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 17 Dec
 2023 11:26:29 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/3] perf/x86/amd/lbr: Discard erroneous branch entries
Date: Sun, 17 Dec 2023 22:55:44 +0530
Message-ID: <f55c3adb97456d28ee5f957cfabf5d97ce71912e.1702833179.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702833179.git.sandipan.das@amd.com>
References: <cover.1702833179.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM6PR12MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1480ca-f42b-4cab-8c5b-08dbff25518a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ksRnrKFycEuR48ujMYtpyO6kt/XWtFaljpoisjYOm4lyy3G5Zivn+vmMCgAkNevg4J4bR/GauD8R9fWT1Q+jPpW1PJMULNeljk/QqhgUXCObk7+hztZpiBOlga44pXsPR1hJWidAI6RrT2x6mHM7jgGOEZdV2VM0rgkz1WyBzk/JFD39A7lt4I/Ofs3nBxoC7jijIR7XDrk0jee0iiqMAytXwHCV5JvuENxg4Rr38Nh1JfIROhqsMx8loD9iOJoNmXpyq49Nh5s8v/QPCKsmT69xz2g+1O46hMjMxyB6CKJW77qJ09V0pr+yOc6r739amNOQzX4SvRwYBv85HFxA0gy40EeS/Uz4oLTXs5jPBJ1s0BXcR5saYnGm1Bo+CwVU3Ff7oSXVWxDtdqk6LMU2vW2nZdHpZc+ZYC8jNIH2HHAKPktYaX8MR4nBgqzmsIqSbmsjKzKsdMT1ryEyKOtkq2ApziQ+yrpDiaHbKLU2Y+bhwNjiD4yKBgNLcPO/9V9ohe50E2rtCgU1TMhFvLzZ4301GUmJW7GJ5Y2AcEIjs9I+QCYyUXQk1lkPPLRJ1YBJgZX2l5Ub8vj8e0VRxASe3tx/BEQx0RrCyBXUiYCfytUDssGZCUpKJiQvdBpQ8bw9Eob9L66v3gPZ9UqMuv1OmOgODBbGXSwqt/vLkyzaS8tCxNUsFU2ebbq1+zmw//sC78WG70vDf2WPmgqVKp6NNuDlkJeYvdCz8tqu1yJhPqWEWUo8GCjhvVXNS+D4x2NF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(83380400001)(2616005)(16526019)(426003)(336012)(26005)(36860700001)(4326008)(8676002)(8936002)(44832011)(41300700001)(5660300002)(7416002)(478600001)(966005)(6666004)(7696005)(2906002)(316002)(70206006)(54906003)(70586007)(110136005)(36756003)(81166007)(356005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 17:26:34.9495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1480ca-f42b-4cab-8c5b-08dbff25518a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941

The Revision Guide for AMD Family 19h Model 10-1Fh processors, found at
the link below, declares Erratum 1452 which states that non-branch
entries may erroneously be recorded in the Last Branch Record (LBR)
stack with the valid and spec bits set. Such entries can be recognized
by inspecting bit 61 of the corresponding LastBranchStackToIp register.
This bit is currently reserved but if found to be set, the associated
branch entry should be discarded.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305518
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/amd/lbr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 110e34c59643..43bf2dbcdb82 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
-- 
2.34.1


