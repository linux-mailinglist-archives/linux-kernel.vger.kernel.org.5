Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E778EAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbjHaKrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbjHaKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:47:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CAD10CF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc0Avs0fIOGc7tTLp0MVU7MiOH5r2c2TuFb3rasQoO1K6k26G2z45VPX2A1bwqWRgA7o6Ir8NngeuAmVPobeOimqdeUbWkYll997ghl86/n1zOtpDzAOTYoMn5vOHmlkSehMw6g42Feu6y2yitQiy0yb20uyP6KnJLRn1Y4GiIz6YGpsfPIXoBJsZrYf2YTutQDtLPkonMjXnpILSykPtnd7J1XkkjMLwR9zEzKsN7CdHT0uCeBSHFlJn9LNirGiVYiw15jvpw20pjt1O4rTBxjCapen/JRs8ZwqQYrzAs8gV6FC9FOWviKJiUAdlzKa0tmVUEgTw7ye1DtjKfCTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lejRveKA+0KNqoBr9I8jd1tLGSvwBsA9vgSDzISUUDM=;
 b=ZXYl+SpHbKB84YVmoiDLCyhqTBeOwUPr0W7kfQfYMkZLMFqucRzpOt8P6JIl/tfABsvZu4AKpRK4FxHNK3ghZdA9t983+5CXZe9dkf+ioBY62yB5ok3CzpIFQTnoQy7ZDiNokBR3wB1A2iCqT+avVqFAlQPgDMljePuhoBsipfrYTTUMnB7txzTeDyWEjrw2rwSB/1jXe0H28qD+s0F8iQRe7sxga47k3uUK19gyaklEOqJOQj3yy1jVRwmubKrkLJwJHzpQxFDgEqNAaZYriZsJ64jK6u8LCkP3sNjWKoKS/ngceFZ89I9ICstiyX25b6whgXuZ8iR7RNkqkWCT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=manifault.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lejRveKA+0KNqoBr9I8jd1tLGSvwBsA9vgSDzISUUDM=;
 b=OnrfvPYps9u8O3fpPabzeYDjd+2Q9YFIyTTdmoOIYeT1ssiEr1M3OYTqszcMFfIfuD3EXnVOmzOBenxaGwyPVysK/Fj5DbXX4ASBYeWYycIuCDKHK43LrDHd7affz/bTdUKv+u3I3PSXhW+5b7f+5SoUXvvlg1LlDYMR4INugK4=
Received: from SA9PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:20::26)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 10:46:03 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::4c) by SA9PR03CA0021.outlook.office365.com
 (2603:10b6:806:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 10:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 10:46:03 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 05:45:56 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <aaron.lu@intel.com>, <wuyun.abel@bytedance.com>,
        <kernel-team@meta.com>, <kprateek.nayak@amd.com>
Subject: [RFC PATCH 2/3] sched/fair: Improve integration of SHARED_RUNQ feature within newidle_balance
Date:   Thu, 31 Aug 2023 16:15:07 +0530
Message-ID: <20230831104508.7619-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831104508.7619-1-kprateek.nayak@amd.com>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fd86da-2489-4ad8-4edd-08dbaa0f78f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4o6a8ro5YRz8hQ72jOMbHylg6ZfPjLuhhS3fce8h1oTL6IzPG2xqr7pS2lOwSVvmcmxB1QUlbdRm/Xu9JbdPHafGMw/VVoOAWPWasjQpNSiuCiFYXWwraLUVf4piXdeK19UxAiypcNzyir+w2j0pHoGKzO5yY5aXRzHu8Bp7pY0bkV8W3W4i/i5zwOYpa6i7cFBXF08D32Y1B3L/KmC+4alQ/aiIgVJlH2VurIaHllCUEinhK2yGzbs449s4MPpYqWtyawZVmJbbK4sEANRnYE18aeEn1KAG6TtZ9GCgvM3NwrbrgUyNXKicdzf0RmKZi6u3Vm2s1fgMQZ58H4aqjNprwSnjf7vZcyw/8njk37VsV5z5a/D8RqADkOh2lLOtUA2+ZLia1f4q0DZWvkjk4CX864bVUUusKnO4Ti2pGE8RBaMJBIhn+lNCvNUoVUdc3IDukZP4HT9TGeWRf8AmhlzOJRAR6YnnP+U6RZikz6ILHRRZ6e18a9zYfcI9OBH/k0GAV+S21LsEUeJfz2XazetR+aSSfJ0mPyj6Dki2yWlH4Wts37+hbhk0kqS8b7rNY1PK+Vlfaf/Sj1+iEPz0ezSkdkE/bYa3+8qJQL0MLZ0EIjOR+5I30Az4kZi1ygNRGsGuzYBd2ZCxR+NtBKgrEX/96gi1Kh84bTpSRHcSp57d4vSup5QpZwwWK3XdsQe1bKyagwTuRniixm2PjBR+mtssNJ95vylgTBBYiqBkc1WLmf+jbgmA7TEOD0FOHZ2Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(356005)(8936002)(6666004)(70206006)(70586007)(478600001)(7696005)(54906003)(966005)(41300700001)(316002)(426003)(40460700003)(86362001)(36756003)(1076003)(26005)(16526019)(2616005)(83380400001)(47076005)(40480700001)(36860700001)(6916009)(2906002)(8676002)(336012)(5660300002)(7416002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:46:03.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fd86da-2489-4ad8-4edd-08dbaa0f78f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch takes the relevant optimizations from [1] in
newidle_balance(). Following is the breakdown:

- Check "rq->rd->overload" before jumping into newidle_balance, even
  with SHARED_RQ feat enabled.

- Call update_next_balance() for all the domains till MC Domain in
  when SHARED_RQ path is taken.

- Account cost from shared_runq_pick_next_task() and update
  curr_cost and sd->max_newidle_lb_cost accordingly.

- Move the initial rq_unpin_lock() logic around. Also, the caller of
  shared_runq_pick_next_task() is responsible for calling
  rq_repin_lock() if the return value is non zero. (Needs to be verified
  everything is right with LOCKDEP)

- Includes a fix to skip directly above the LLC domain when calling the
  load_balance() in newidle_balance()

All other surgery from [1] has been removed.

Link: https://lore.kernel.org/all/31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com/ [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 94 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bf844ffa79c2..446ffdad49e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -337,7 +337,6 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 		rq_unpin_lock(rq, &src_rf);
 		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
 	}
-	rq_repin_lock(rq, rf);
 
 	return ret;
 }
@@ -12276,50 +12275,83 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!cpu_active(this_cpu))
 		return 0;
 
-	if (sched_feat(SHARED_RUNQ)) {
-		pulled_task = shared_runq_pick_next_task(this_rq, rf);
-		if (pulled_task)
-			return pulled_task;
-	}
-
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);
 
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
-
 	rcu_read_lock();
-	sd = rcu_dereference_check_sched_domain(this_rq->sd);
-
-	/*
-	 * Skip <= LLC domains as they likely won't have any tasks if the
-	 * shared runq is empty.
-	 */
-	if (sched_feat(SHARED_RUNQ)) {
+	if (sched_feat(SHARED_RUNQ))
 		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-		if (likely(sd))
-			sd = sd->parent;
-	}
+	else
+		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	    /* Look at rq->avg_idle iff SHARED_RUNQ is disabled */
+	    (!sched_feat(SHARED_RUNQ) && sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		if (sd)
+		while (sd) {
 			update_next_balance(sd, &next_balance);
+			sd = sd->child;
+		}
+
 		rcu_read_unlock();
 
 		goto out;
 	}
+
+	if (sched_feat(SHARED_RUNQ)) {
+		struct sched_domain *tmp = sd;
+
+		t0 = sched_clock_cpu(this_cpu);
+
+		/* Do update_next_balance() for all domains within LLC */
+		while (tmp) {
+			update_next_balance(tmp, &next_balance);
+			tmp = tmp->child;
+		}
+
+		pulled_task = shared_runq_pick_next_task(this_rq, rf);
+		if (pulled_task) {
+			if (sd) {
+				curr_cost = sched_clock_cpu(this_cpu) - t0;
+				/*
+				 * Will help bail out of scans of higer domains
+				 * slightly earlier.
+				 */
+				update_newidle_cost(sd, curr_cost);
+			}
+
+			rcu_read_unlock();
+			goto out_swq;
+		}
+
+		if (sd) {
+			t1 = sched_clock_cpu(this_cpu);
+			curr_cost += t1 - t0;
+			update_newidle_cost(sd, curr_cost);
+		}
+
+		/*
+		 * Since shared_runq_pick_next_task() can take a while
+		 * check if the CPU was targetted for a wakeup in the
+		 * meantime.
+		 */
+		if (this_rq->ttwu_pending) {
+			rcu_read_unlock();
+			return 0;
+		}
+	}
 	rcu_read_unlock();
 
+	/*
+	 * This is OK, because current is on_cpu, which avoids it being picked
+	 * for load-balance and preemption/IRQs are still disabled avoiding
+	 * further scheduler activity on it and we're being very careful to
+	 * re-start the picking loop.
+	 */
+	rq_unpin_lock(this_rq, rf);
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
@@ -12335,6 +12367,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
 
+		/*
+		 * Skip <= LLC domains as they likely won't have any tasks if the
+		 * shared runq is empty.
+		 */
+		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
+			continue;
+
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
 			pulled_task = load_balance(this_cpu, this_rq,
@@ -12361,6 +12400,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_rq_lock(this_rq);
 
+out_swq:
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
-- 
2.34.1

