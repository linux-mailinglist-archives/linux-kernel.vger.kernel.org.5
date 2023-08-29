Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3178BE41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjH2GHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjH2GHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:07:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E398
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAOiNNLWGyleLNWJJDXS3p2/6HD4eocIA4UNvYWXxveSFHPgpBL/8vrZEfrJvxDqYKUCch8woOM9n9K7feMaamFaiVvL/BL7bRecxtwitWM4e7Xd0NjE3tZ2DzJI79l42JUVbnDKI/Kru3zOwFyCflmRWAN9/d5Ip8FNggSTJcWMA/3/QyABV/n4vmgw9C0j7TZ1usJ4Ep1btnJkt8aW76jp5yQxrHBWzWbqZMUjcEJlJ1QhuL88aVSzYFyngmHMcOvymNNemJFJb2k1rsC9dHv95Tsf2um1gfgxTiwRefIPd+3xMz7RiVF6elQBbaRwSeBrjpsb50D8AxzpPlpT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iOx8gTc3LVF93/VuEpUYYY6Fy2SDNkAdxbQ7DX8kM4=;
 b=GfYF3E2tmBT4ISMKsuKeAJJ/sJ657zv/M/GElu3e2Z5SSGwhRYHOJYzuzyBbAIve3k6RLGkaf5EelrfUse2dxs0T8srtIaRkJttyhTHVd6VQsCrEKE//rYMPQvMZLCksdD9Idf7i3j8R0pP8Tm4gsIJhdCdnmnQyZCkQjWT5rSUh2vFIRK0+qvZU1DFSrFLiYvT7bLLphPND2Fs/dVvS5VCud3/GQUJtTIUE/+57GYTlvUwymMcJJjxOOKZm/yi9JXSswKHVfvhPA+D8zzdUJRnVJ5qA6+HmRayI+Z84JztjOl8MnFg3tSrLHsOmXYxpHEL3hzBFuMJEr0GxIlXt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iOx8gTc3LVF93/VuEpUYYY6Fy2SDNkAdxbQ7DX8kM4=;
 b=I+hzyMqDNxeglC+xskhC0Q419Nv07Bsas0yQXEniIauKMLlm5J31N9APHICHpMMJN6AxYCedU4Zf3vKHwUsQHpHC9hAnIiClVF6MrhzYeDc7kHArPrlnDSvQoh8YvocxgGFh568LvRDY2zLEZcTuegm1QCwB0ClL1dGtEXEbM/k=
Received: from SA0PR11CA0157.namprd11.prod.outlook.com (2603:10b6:806:1bb::12)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:07:37 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::44) by SA0PR11CA0157.outlook.office365.com
 (2603:10b6:806:1bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:07:36 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:07:31 -0500
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
Subject: [RFC PATCH V1 4/6] sched/numa: Increase tasks' access history
Date:   Tue, 29 Aug 2023 11:36:12 +0530
Message-ID: <cf200aaf594caae68350219fa1f781d64136fa2c.1693287931.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d40630d-9702-4a44-e3fd-08dba8563e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o26tZ2K2wPyu5XQPs6GIN712exnTqXPHVdz8k+Q06SMahzFmB38S4lZNlOizRryoD2cMWd69QxOJJPzWKMCcVTSLJxAukEc4qs4N9jTGNic50eBPeYxl17R9zphhQZF5iXy50ipzqm078ZTKq83i1Ua/bP244smTXuBH7s3039wUDMvj4+0pp9BUad9s3ZyR4mFnkuOflPk+VQLSFwOi6rEZN/pyymZM56cSyzR6tIVmVZpod97x0QYPPhN3eCZtSM+sbtOZngtdlkDAlKVlaMPofeZNhRkhxMefjdj/u+GwBtLe38BtSCZCdPjHoFz0LoeXQBUp4CYEN1kDbGmshbnlJxUbapPPX+lKvizATeB+fGkSaUUkDlon1b8+/WxD9XykqWZTrfX3FBS1ZC5TYxBT6jnUxsUkKUesyAPn/6R8zAwoIIfC5CqlPsDTeCUKkX/N5IiJF+Ya7RTLjuPC191svbBvmU/h6KfYpIvLSLnRRNKn1a6nDaX2d1pZBJu4F+MYaHO80qVEOHQ8DvKKa9nUM92HPvRmxv0dq51rnrDvQnfiMcGEaEh1NU9f7qwMrUCI3nz1ZoQgLOidy8X0SlKJPBkhVKphFwoY87AU8TgHtF/s5HhqkQdQpkSK2b53tzFQamzJTMInIOPGDupM8J7HEuTWTxMx/SvcfmYYIgLiojiW+66HqN/67mNihShNFE3i1h+v2Ub1iULYP3luQ6pmX+vY/vsiPVCuDUSZyqZotwkabvv11SyHvU272tfVw44TVFQ2R1a0ZxGxMoS7R+R0x2nz0q8aANFiWaoy1CI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(54906003)(110136005)(36756003)(316002)(70206006)(70586007)(5660300002)(2906002)(7416002)(336012)(40460700003)(41300700001)(36860700001)(7696005)(2616005)(426003)(16526019)(26005)(40480700001)(81166007)(82740400003)(356005)(478600001)(83380400001)(6666004)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:07:36.9532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d40630d-9702-4a44-e3fd-08dba8563e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

from two to four.

This prepares for optimizations based on tasks' VMA access history.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       | 12 ++++++++----
 include/linux/mm_types.h |  4 +++-
 kernel/sched/fair.c      | 29 ++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..7794dc91c50f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1689,10 +1689,14 @@ static inline int xchg_page_access_time(struct page *page, int time)
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 	unsigned int pid_bit;
-
-	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
-	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids[1])) {
-		__set_bit(pid_bit, &vma->numab_state->access_pids[1]);
+	unsigned long *pids, pid_idx;
+
+	if (vma->numab_state) {
+		pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
+		pid_idx = READ_ONCE(vma->numab_state->access_pid_idx);
+		pids = vma->numab_state->access_pids + pid_idx;
+		if (!test_bit(pid_bit, pids))
+			__set_bit(pid_bit, pids);
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 647d9fc5da8d..676afa9e497c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -475,10 +475,12 @@ struct vma_lock {
 	struct rw_semaphore lock;
 };
 
+#define NR_ACCESS_PID_HIST	4
 struct vma_numab_state {
 	unsigned long next_scan;
 	unsigned long next_pid_reset;
-	unsigned long access_pids[2];
+	unsigned long access_pids[NR_ACCESS_PID_HIST];
+	unsigned long access_pid_idx;
 	unsigned long vma_scan_select;
 };
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e26e847a8e26..3ae2a1a3ef5c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2958,12 +2958,26 @@ static bool task_disjoint_vma_select(struct vm_area_struct *vma)
 	return true;
 }
 
+static inline bool vma_test_access_pid_history(struct vm_area_struct *vma)
+{
+	unsigned int i, pid_bit;
+	unsigned long pids = 0;
+
+	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
+
+	for (i = 0; i < NR_ACCESS_PID_HIST; i++)
+		pids  |= vma->numab_state->access_pids[i];
+
+	return test_bit(pid_bit, &pids);
+}
+
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
-	unsigned long pids;
+	/* Check if the current task had historically accessed VMA. */
+	if (vma_test_access_pid_history(vma))
+		return true;
 
-	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
-	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
+	return false;
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
@@ -2983,6 +2997,7 @@ static void task_numa_work(struct callback_head *work)
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
 	struct vma_iterator vmi;
+	unsigned long pid_idx;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -3097,8 +3112,12 @@ static void task_numa_work(struct callback_head *work)
 				time_after(jiffies, vma->numab_state->next_pid_reset)) {
 			vma->numab_state->next_pid_reset = vma->numab_state->next_pid_reset +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-			vma->numab_state->access_pids[0] = READ_ONCE(vma->numab_state->access_pids[1]);
-			vma->numab_state->access_pids[1] = 0;
+
+			pid_idx = vma->numab_state->access_pid_idx;
+			pid_idx = (pid_idx + 1) % NR_ACCESS_PID_HIST;
+
+			vma->numab_state->access_pid_idx = pid_idx;
+			vma->numab_state->access_pids[pid_idx] = 0;
 		}
 
 		/*
-- 
2.34.1

