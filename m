Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE35D78BE40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjH2GHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjH2GHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:07:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA5123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGrZ4+Iew/xlYecxmuz35OhACrH//78E8Nlp7IA1luNT6BPV3f7FhDPeJnFQ1xc11jnPMx7tvsSyuhAzGNbWs6FFCLldBsVOcNhRIYhPZZXTvtQdFnyq03ntCFPL4NanQcpW73Tt9OgzOaz5M2Ar2zHUR4dAG/kMJvVxPrNt/vnWWG9RCKfUrbYIQhUlqPaGchkmEVKRje+/k/WkpUCEzvYeyTaPXALngYYFiqzilc+KqgvS/lv4eNj6VUab4TrJv2J/oe1TECqw08Ybi4Ghm56pkyRhiSZeVcRYKx6GdNSsOBKXyiw4WeU9+irki3DZybsxNDhn4NFoRSos+Md6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW+oPbdfOFtFGb0qsIMwhXRIEAOqfAeYwznI1x+HCLg=;
 b=ED7I41z/OKSUS6G4i64eKzaU29NtH9h7HGt+vyW0eiH8I2sm3i1NBiN71SjhTfpOBRmRHGVCRECyQS0MyBdrYgQhplAFt+Uv4AOdb62FzV/wSJMmSsB9d9bDbf0UyMj2s54JYczIdj5XlRWnzGcFbKgbJGWWhLycdHDG0BPq/BRCiyfYgRIKNtYRQ1Nto515qjJNo2DekeP1b2C+Qyb75ehSPlcHKyvLMfbpEYDOCTPd7BQf8bPFlITWQVH3Omo+xK5g7FGKMOr/AvY4dPqxLRa0n/Yjir6ySUS6iYqzHwYSqWH0wLe37lO+77/S7PqcCp9t5ka6FnZmac4vuYU1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW+oPbdfOFtFGb0qsIMwhXRIEAOqfAeYwznI1x+HCLg=;
 b=lMViNaWgL3rFC8aFZWFjwxP41reGYxNsuvsDxYfx6+kNrs7gsIlAw+0o6v9E4cnJzdnW3+my2AJStt6FE7RCCYY5F73qCtO3J+47XZ9fPLXXQm4Dg+n/Rvud7qU2BtrKcKe2iNuM97UZvsPtUwMvFflRkLtc9lnglyaO7yx0fvw=
Received: from DM6PR18CA0023.namprd18.prod.outlook.com (2603:10b6:5:15b::36)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:07:16 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::60) by DM6PR18CA0023.outlook.office365.com
 (2603:10b6:5:15b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 06:07:15 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:07:06 -0500
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH V1 1/6] sched/numa: Move up the access pid reset logic
Date:   Tue, 29 Aug 2023 11:36:09 +0530
Message-ID: <aa636851c3aab82f2e5f90b0be0ba540672e8178.1693287931.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287931.git.raghavendra.kt@amd.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a883003-66ec-4275-4e56-08dba85631a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wkeYWTnqPhSp8B+7ml5vhRXVcwlXsOn1CHCSQZdWckMbkO8bTrBCb8m0A8RfhUz44lg5vPT/Wl2QiKpIliBm2beTI7coIcLZtUBJ+5YrgweSd8RS+zS73ywJ1cJRRq41AsfLIMBPA5NOUUzTsQDegFbD8d0/uTPcI/mL9y3w/e78zlRvl0U8vN+1GEF3ZUzMOThyqftuU2ebx4gnlCQ63/LbgxAB56EYGK2azmNn88jKLPwkRS5KKfbl3rrdE/Q/NXkF+JrNx06yqhfKvvMV5JdmU2oLq2PjlximI/42fMZGGrJ78QuyCd6EuIhVtoHp721EU/r/ktSnZAiL8Pj+G8Pv1p0LHH8YZ6BI8zUSyuy9FO6oNtboYAfU752fXX7grxTrgjcAZ4BC8iY7jKxa+DOQWIN7jV4+WQBsjScAQ69xR7SCAIXDdCBxu3YwI92ib4g9dUrGWNLphqGuBJmT8gFuW8PAaLfMbMwKCqjvXbiCCNo0HyzDNxUeAe5vk5QCsxf8BJCf8iXN7gX9smKRwhvInwnaFhr13rjfoWUPv3ljNhZTioayx/eMnBIsik6dn7C86JTqemEr7dCOI6gTezDfRxlq7aSEPAu2GGzDtdgDHkGF2NbfAN6WXap0W9Dvh2mZQQfFl1Xs51d0WS3ClyWmR0Kxn+4w/p5ORGK79Z8aHqxqspvZ5zxxbc7OEzE72rDaC4wmQX0oHWNiot7IqSNA4HXGl9w6+dB9nxw9c5ZwDwzl16jYciWHQvgvardK3M5tGCtWFl2cW9h1Whx0o03ARMwsFNTVYp5QPvfHJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(356005)(81166007)(82740400003)(8936002)(110136005)(70206006)(70586007)(478600001)(7696005)(54906003)(316002)(41300700001)(40460700003)(36756003)(26005)(16526019)(8676002)(5660300002)(83380400001)(2906002)(2616005)(47076005)(36860700001)(40480700001)(426003)(336012)(7416002)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:07:15.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a883003-66ec-4275-4e56-08dba85631a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

otherwise VMA's access pid clearing could get deferred for
a long time when tasks return without scanning.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/sched/fair.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..2f2e1568c1d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3068,14 +3068,7 @@ static void task_numa_work(struct callback_head *work)
 						vma->numab_state->next_scan))
 			continue;
 
-		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma))
-			continue;
-
-		/*
-		 * RESET access PIDs regularly for old VMAs. Resetting after checking
-		 * vma for recent access to avoid clearing PID info before access..
-		 */
+		/* RESET access PIDs regularly for old VMAs. */
 		if (mm->numa_scan_seq &&
 				time_after(jiffies, vma->numab_state->next_pid_reset)) {
 			vma->numab_state->next_pid_reset = vma->numab_state->next_pid_reset +
@@ -3084,6 +3077,10 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->access_pids[1] = 0;
 		}
 
+		/* Do not scan the VMA if task has not accessed */
+		if (!vma_is_accessed(vma))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

