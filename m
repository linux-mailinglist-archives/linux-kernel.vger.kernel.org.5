Return-Path: <linux-kernel+bounces-14071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03396821792
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EC7B21506
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3567E15D0;
	Tue,  2 Jan 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gZLGT/mW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268D15BD;
	Tue,  2 Jan 2024 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAkCP7sv9fZZvAAXgnv59JXcTQ/Zo1cXqRsS6pMDbT6z6KrKq3pkY7S3O6q6yGTh1VMxhWLwCZdCpBKH8ATM7dzOSgtA01D69kz51TzBKDdQshHovrMjnCH7jnyxDCy0jwVPAXh+7IPYAoWI0MR95CP1scPs2OXBz7ba8aQE3n/+nW5lVeCiaWIQRimhmP1343PGZx6b1E9nqAZHd4ybLf8Qq1I9+wt59f0Fc50u6+J06J0Vsg448c5f+oO6tbGCvzVFx5u3jcupAZwOPAfMwSOUpJHTUJXFVqdQQDM4lZwyoWNf+kfk9rZ+qULEwM4hU2UYI7Mp/65AwKkt6uqzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQLMv0TBjQm7us/LaGvFyZIRMe1q+hi8pizCeO6Dmy8=;
 b=aYtlNX+Xn850APnpDzNhyMPQ+mP5Ggvxdatl7AUPPX9WgoAxfOCe8RR9ah/zrMf5/pru/EskhBjJYBxnYeRc9UH3+iQf1BZuyrDu9H/q9GSWjQFEDrR0oFKC5wPLl6gZ5QTIK95HjpNwk3fGPpz1MI3SONCXuJ6Z8Nxx9YtHzDKqbD/VbQEU5ZwisDveHuL/LGMgE3+XWshhkIYkyJrLQi+eOgTbwmm1XkPPyJYqAjXXHx5ikwVN/l3yXKgc8SKfAmI6EKVmQw3qhHlDZT0RtBgbJezg6YFeKPKmiozibSDyuWf60/wj6yjT8NYyxC45ZfXRfzmD9/P41p/tW11c1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQLMv0TBjQm7us/LaGvFyZIRMe1q+hi8pizCeO6Dmy8=;
 b=gZLGT/mWOrOniGHVPKJbkmgLIusjrYO4hVd+MNyetlXkRXMU2iBM2kLE8cHO5gh8nDnYqJg+Zo1Ec9OA22GcanXJ7wl1aT1u06CQHpgG/p0tqwCbNvxTpl3d+dJ/7loH2o+ggWDfC95fFbmsLhi9qXeL/lmb4LF+0H6RppoVnAk=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:03:37 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::16) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 06:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.1 via Frontend Transport; Tue, 2 Jan 2024 06:03:36 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:03:30 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 2/3] perf/x86/amd/lbr: Discard erroneous branch entries
Date: Tue, 2 Jan 2024 11:31:29 +0530
Message-ID: <030248bbb58b8657b98e38117947352de29001d8.1704103399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704103399.git.sandipan.das@amd.com>
References: <cover.1704103399.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bd0abe-6c51-4c0f-14a7-08dc0b588f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYScb3Z2XabSyNj0WlgqmY68X6EsvnnA2oaZBTLv8okCpPM0HgC6UUsgfLm4rbh3oPFZcwX7eEXYg2dOi/I3kYYfqo/KyJduKOSw77C8evgWIvCFOJNzXx02mYEKHMo07+w7cZNupD+7bdJKZIPz1eLOwU/qz6fBoPgpje2DnR7KJatlB3y77mV1Nh5wSLNKqexOT7BhLujnRTVCsvbjWWmNh8hVnuX2kO+EDC4/bb1QgoyvgE0xGmxQYhqAaAJVVf0Ejj8nw6KKnERtxa/rCZfUlHlUQqq4laWL7iyaGzTfetgwVXwpTvt+cFJP/tLo37AP2g9Mix72TfvLdQhLTycSK6JuxfmFe1QMoiEot2dionOeGzkmgqcxhfhaKWddTyVnDKNfANy2RxQFsRKnTQcA+FvrGuNpmmBpRCkCXYZIyRTvUd7273VOzkDyv48a1MXDq77EB6idOVFg4nr7u7dDuhZ/YyfROLCCFmpjFKpGSfLoCxau9vk6GDCcrpvkd3pNsFwCVgwnegomOsEBtqDkNa9BgcpzMCj41VkefLtTeM/ZSaa9IOQmuafG9Dw6ex9cuLWTzX6XsVK/RH2fDGNU19nGgVx7q8oo/l8kHRA4cgo7dyP1HXsL54p7i1o6y0tnevQyXcbA2w8Ihealfyh6H+q4ZUbp9Gq1meldnfXIC/fZ7jx+HvTEpzK6DkDILQ8cE0JXU6OGfMYcdc9WlsOrKPFB4rq4lS0WDerYule4L89KzhBaZIws6iDP8259
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(7416002)(4326008)(8676002)(8936002)(44832011)(36756003)(316002)(54906003)(86362001)(966005)(478600001)(40480700001)(40460700003)(41300700001)(7696005)(16526019)(426003)(26005)(2616005)(336012)(356005)(83380400001)(81166007)(47076005)(70206006)(70586007)(110136005)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 06:03:36.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bd0abe-6c51-4c0f-14a7-08dc0b588f71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

The Revision Guide for AMD Family 19h Model 10-1Fh processors, found at
the link below, declares Erratum 1452 which states that non-branch
entries may erroneously be recorded in the Last Branch Record (LBR)
stack with the valid and spec bits set. Such entries can be recognized
by inspecting bit 61 of the corresponding LastBranchStackToIp register.
This bit is currently reserved but if found to be set, the associated
branch entry should be discarded.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305518
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
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


