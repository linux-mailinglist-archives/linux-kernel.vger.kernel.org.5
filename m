Return-Path: <linux-kernel+bounces-22083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C18298EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742FEB264D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FED47F68;
	Wed, 10 Jan 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g4pmwG90"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1447F47;
	Wed, 10 Jan 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPpUsjQiqGMieOGAXLdE6cLaxzQiDVh7mkdOwNr0z7mdvU2vUfRjRNDQ8UaAuSBo/zwMPreqN3W5FqUOMpMIPkpxCgIvYtYuKaMTWY/0WU+QcUZVyRgtYMifgnUcUIDmk3AcbxqMy1pqAC03wKleGs9w/XRuiH8klEuXuniZoEyAMEvcilOKhyFgYydYJ1Ag/BJw0Ik4aWBZ2OYYJFAetc8OzgcfusD5YXRJJ8W5+5J6iA9ChL/dw24oxrAPAGLQerC1kniN01Zi11sLJ4BFT3498hVtmXuCpPyWAmUQfwmguYCPJbq2PXo4iLpJWadOb+CxQtTli8l3XQF4Vcf0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET+kDAsVbWM0r5RQud/v2d7x8jOqCw38OrCzb1jkP5w=;
 b=ZojKk/dtnCUQsGj1oKp9E7xeMrp+mACkcMpGcf2saymKAvo7Mpf5dTDVGYbRbzNnKbAjlhJfsFDiRIcQHezeoDalC508NBMpsigQMITQDy0PABGShcalJ8lvquSkmWoqmGx8rQ9m6NVxmMDBvoK/3/vaLPYeJs7jAM6SsN7V7NvLjeshrJzFwOq3MDrgavajhIzyo2ZLSow/1Jos07fTHEEhF6oTS2UpBZXcQ+zFpAr5831BMUOq4yZd2svorRu3+3z4EWMSdHsOMTSCMe1Avv4XTQkS/sx4B6M45cUb8AhDe0quQgNPr6ilVTDoM1c9cSoOWRuCv4cS4eEIoPtthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET+kDAsVbWM0r5RQud/v2d7x8jOqCw38OrCzb1jkP5w=;
 b=g4pmwG900ELb/3ZglIY/qJGBs1zS2apIXPx1gSokhHbuHzVPoMemdwhb5vJbv7XqSqeQZNIH2uT2nExbR4EK4+uMPyf5cnLbYfjJW49yUgst3jCjfhzYsV9RVbR/o5MXYISIQNheECSDjbUpHiH+W8NERSvyNo7P2DlDaXjXvhE=
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:23:18 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::6a) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 11:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:23:18 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:23:12 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 6/9] apparmor: Initial prototype for optimizing ref switch
Date: Wed, 10 Jan 2024 16:48:53 +0530
Message-ID: <20240110111856.87370-6-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: c956257c-fb59-40d2-1f1e-08dc11ce8ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJdWUJsgoWK6UC+YzPNp16ME1ZmGVMpWamoItPPkYJB8NfFby2lXpDRrXj2owhv+P+9WBLDk7+mZXrXfoQ6a3JRuSMCJx9/2wGTBxAl1gA4dWbESyhQRd2x649IuiKefE8MzLURBitm7Ajafwv8yYl5drOJ7eZktwEYaBLvFWr0qoqNmmyQM1QN3DBWKcidZcQSggtAwYrN9lKFod3APBowdr3sa2ryldCKTHJNChcje8NHTYXs3a9Lm2+HVWTT1LkiAKSCpApMNoiWFHrHAIK4/uayLPJYp5hKr0d9Li97kRTpyHH/evcGELDNns6ZdQOeYwXsfdBBI13o+dJylKqNpRc/9JOcVOVyE71HNEBB3ckBE4gMt9lvKQBFsnkRco34UplsmzTjdtGU+dx/NtOTfwU3KTc9zzRp1WELDEAF1Xf9pGmCkKeiPbccLHwNiDOQuFz+5LOzIEO7xAvXTbDBJnYN2/MTJxrW+p4AogRjY+4aX6hpxy2XGKxSsDQAqp8dJDfrZ2Zldi+9Y5/JtPAR66aOyNhorK6CiFIebojlYgatu/okwfcYLy/RCi4E8DO2dD/Gh1LqXF29odCAH9+yw0MrLGymG9p4AranhBY6gAC9qR6xx1q0xVcFhNMJQr5XTxvCv+73uI1myLqZZfVI5vwN6QrV1We+i/jTLEcte+4CuB2IIxtJ8U3Qj2oO8RiGWD1jaB+zGp0TQyhN/XKB1fOHvy5f9PBKpFt74fWVixOExgxRK8AK6pudu6G/u19iqGZPKpltM/KR3y948hg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(356005)(41300700001)(70586007)(70206006)(86362001)(36756003)(81166007)(36860700001)(47076005)(82740400003)(16526019)(1076003)(336012)(26005)(2616005)(426003)(54906003)(2906002)(7416002)(478600001)(110136005)(6666004)(316002)(5660300002)(8676002)(4326008)(30864003)(8936002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:23:18.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c956257c-fb59-40d2-1f1e-08dc11ce8ba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

This patches adds a prototype for optimizing the atomic
window, during label scan by switching to an immortal
percpu ref.

Below is the sequence of operations to do this:

      1. Ensure that both immortal ref and label ref are in percpu mode.
         Reinit the immortal ref in percpu mode.

         Swap percpu and atomic counters of label refcount and immortal ref
                                  percpu-ref
                          +-------------------+
      +-------+           |  percpu-ctr-addr1 |
      | label | --------->|-------------------|    +----------------+
      +-------+           |   data            |--->| Atomic counter1|
                          +-------------------+    +----------------+
      +-------+           +-------------------+
      |ImmLbl |---------->|  percpu-ctr-addr2 |    +----------------+
      +-------+           |-------------------|--->| Atomic counter2|
                          |    data           |    +----------------+
                          +-------------------+

          label ->percpu-ctr-addr  = percpu-ctr-addr2
          ImmLbl ->percpu-ctr-addr = percpu-ctr-addr1
          label ->data->count      = Atomic counter2
          ImmLbl ->data->count     = Atomic counter1

      2. Check the counters collected in immortal label, by switch it
         to atomic mode.

      3. If the count is 0, do,
         a. Switch immortal counter to percpu again, giving it an
            initial count of 1.
         b. Swap the label and immortal counters again. The immortal
            ref now has the counter values from new percpu ref get
            and get operations on the label ref, from the point
            when we did the initial swap operation.
         c. Transfer the percpu counts in immortal ref to atomic
            counter of label percpu refcount.
         d. Kill immortal ref, for reinit on next iteration.
         e. Switch label percpu ref to atomic mode.
         f. If the counter is 1, drop the initial ref.

       4. If the count is not 0, terminate the operations and re-swap
          the counters.
          a. Switch immortal counter to percpu again, giving it an
             initial count of 1.
          b. Swap the label and immortal counters again. The immortal
             ref now has the counter values from new percpu ref get
             and get operations on the label ref, from the point
             when we did the initial swap operation.
          c. Transfer the percpu counts in immortal ref to atomic
             counter of label percpu refcount.
          d. Kill immortal ref, for reinit on next iteration.

Using this approach, we ensure that, label ref users do not switch
to atomic mode, while there are active references on the label.
However, this approach requires multiple percpu ref mode switches
and adds high overhead and complexity to the scanning code.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 include/linux/percpu-refcount.h |   2 +
 lib/percpu-refcount.c           |  93 +++++++++++++++++++++++++++++
 security/apparmor/lsm.c         | 101 ++++++++++++++++++++++++++++----
 3 files changed, 185 insertions(+), 11 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..9e30c458cc00 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -131,6 +131,8 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 void percpu_ref_resurrect(struct percpu_ref *ref);
 void percpu_ref_reinit(struct percpu_ref *ref);
 bool percpu_ref_is_zero(struct percpu_ref *ref);
+void percpu_ref_swap_percpu_sync(struct percpu_ref *ref1, struct percpu_ref *ref2);
+void percpu_ref_transfer_percpu_count(struct percpu_ref *ref1, struct percpu_ref *ref2);
 
 /**
  * percpu_ref_kill - drop the initial ref
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 668f6aa6a75d..36814446db34 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -477,3 +477,96 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_resurrect);
+
+static void percpu_ref_swap_percpu_rcu(struct rcu_head *rcu)
+{
+	struct percpu_ref_data *data = container_of(rcu,
+			struct percpu_ref_data, rcu);
+	struct percpu_ref *ref = data->ref;
+
+	data->confirm_switch(ref);
+	data->confirm_switch = NULL;
+	wake_up_all(&percpu_ref_switch_waitq);
+
+}
+
+static void __percpu_ref_swap_percpu(struct percpu_ref *ref, percpu_ref_func_t *confirm_switch)
+{
+	ref->data->confirm_switch = confirm_switch ?:
+		percpu_ref_noop_confirm_switch;
+	call_rcu_hurry(&ref->data->rcu,
+		       percpu_ref_swap_percpu_rcu);
+}
+
+/**
+ * percpuref_swap_percpu_sync - Swap percpu counter of one ref with other
+ * @ref1: First perpcu_ref to swap the counter
+ * @ref2: Second percpu_ref for counter swap
+ */
+void percpu_ref_swap_percpu_sync(struct percpu_ref *ref1, struct percpu_ref *ref2)
+{
+	unsigned long __percpu *percpu_count;
+	unsigned long flags;
+	struct percpu_ref_data *data1 = ref1->data;
+	struct percpu_ref_data *data2 = ref2->data;
+	unsigned long percpu_cnt_ptr1 = ref1->percpu_count_ptr;
+	unsigned long percpu_cnt_ptr2 = ref2->percpu_count_ptr;
+	atomic_long_t count1 = ref1->data->count;
+	atomic_long_t count2 = ref2->data->count;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	wait_event_lock_irq(percpu_ref_switch_waitq,
+			    !data1->confirm_switch && !data2->confirm_switch,
+			    percpu_ref_switch_lock);
+	if (!__ref_is_percpu(ref1, &percpu_count) ||
+	    !__ref_is_percpu(ref2, &percpu_count)) {
+		spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+		return;
+	}
+	WRITE_ONCE(ref1->percpu_count_ptr, percpu_cnt_ptr2);
+	WRITE_ONCE(ref2->percpu_count_ptr, percpu_cnt_ptr1);
+
+	__percpu_ref_swap_percpu(ref1, NULL);
+	__percpu_ref_swap_percpu(ref2, NULL);
+	ref1->data->count = count2;
+	ref2->data->count = count1;
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	wait_event(percpu_ref_switch_waitq, !ref1->data->confirm_switch &&
+					    !ref2->data->confirm_switch);
+}
+
+/**
+ * percpu_ref_transfer_percpu_count - Transfer percpu counts of one ref to other
+ * @ref1: perpcu_ref to transfer the counters to
+ * @ref2: percpu_ref to transfer the counters from
+ *
+ * The per cpu counts of ref2 are transferred to the atomic counter of ref1.
+ * The ref2 is expected to be inactive.
+ */
+void percpu_ref_transfer_percpu_count(struct percpu_ref *ref1, struct percpu_ref *ref2)
+{
+	unsigned long __percpu *percpu_count = percpu_count_ptr(ref2);
+	struct percpu_ref_data *data1 = ref1->data;
+	struct percpu_ref_data *data2 = ref2->data;
+	unsigned long count = 0;
+	unsigned long flags;
+	int cpu;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	wait_event_lock_irq(percpu_ref_switch_waitq,
+			    !data1->confirm_switch && !data2->confirm_switch,
+			    percpu_ref_switch_lock);
+
+	if (!__ref_is_percpu(ref1, &percpu_count) ||
+	    !__ref_is_percpu(ref2, &percpu_count)) {
+		spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+		return;
+	}
+
+	for_each_possible_cpu(cpu) {
+		count += *per_cpu_ptr(percpu_count, cpu);
+		*per_cpu_ptr(percpu_count, cpu) = 0;
+	}
+	atomic_long_add((long)count, &ref1->data->count);
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+}
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cf8429f5c88e..d0d4ebad1e26 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -92,6 +92,7 @@ static LLIST_HEAD(aa_label_reclaim_head);
 static struct llist_node *last_reclaim_label;
 static struct aa_label_reclaim_node aa_label_reclaim_nodes[AA_LABEL_RECLAIM_NODE_MAX];
 static DECLARE_DELAYED_WORK(aa_label_reclaim_work, aa_label_reclaim_work_fn);
+static struct percpu_ref aa_label_reclaim_ref;
 
 void aa_label_reclaim_add_label(struct aa_label *label)
 {
@@ -135,14 +136,18 @@ static void aa_put_all_reclaim_nodes(void)
 	for (i = 0; i < AA_LABEL_RECLAIM_NODE_MAX; i++)
 		aa_label_reclaim_nodes[i].inuse = false;
 }
+static void aa_release_reclaim_ref_noop(struct percpu_ref *ref)
+{
+}
 
 static void aa_label_reclaim_work_fn(struct work_struct *work)
 {
 	struct llist_node *pos, *first, *head, *prev, *next;
+	static bool reclaim_ref_dead_once;
 	struct llist_node *reclaim_node;
 	struct aa_label *label;
 	int cnt = 0;
-	bool held;
+	bool held, ref_is_zero;
 
 	first = aa_label_reclaim_head.first;
 	if (!first)
@@ -178,16 +183,72 @@ static void aa_label_reclaim_work_fn(struct work_struct *work)
 		}
 
 		label = container_of(pos, struct aa_label, reclaim_node);
-		percpu_ref_switch_to_atomic_sync(&label->count);
-		rcu_read_lock();
-		percpu_ref_put(&label->count);
-		held = percpu_ref_tryget(&label->count);
-		if (!held)
-			prev->next = pos->next;
-		rcu_read_unlock();
-		if (!held)
-			continue;
-		percpu_ref_switch_to_percpu(&label->count);
+		if (reclaim_ref_dead_once)
+			percpu_ref_reinit(&aa_label_reclaim_ref);
+
+		/*
+		 * Switch counters of label ref and reclaim ref.
+		 * Label's refcount becomes 1
+		 * Percpu refcount has the current refcount value
+		 * of the label percpu_ref.
+		 */
+		percpu_ref_swap_percpu_sync(&label->count, &aa_label_reclaim_ref);
+
+		/* Switch reclaim ref to percpu, to check for 0 */
+		percpu_ref_switch_to_atomic_sync(&aa_label_reclaim_ref);
+
+		/*
+		 * Release a count (original label percpu ref had an extra count,
+		 * from the llist addition).
+		 * When all percpu references have been released, this should
+		 * be the initial count, which gets dropped.
+		 */
+		percpu_ref_put(&aa_label_reclaim_ref);
+		/*
+		 * Release function of reclaim ref is noop; we store the result
+		 * for later processing after common code.
+		 */
+		if (percpu_ref_is_zero(&aa_label_reclaim_ref))
+			ref_is_zero = true;
+
+		/*
+		 * Restore back initial count. Switch reclaim ref to
+		 * percpu, for switching back the label percpu and
+		 * atomic counters.
+		 */
+		percpu_ref_get(&aa_label_reclaim_ref);
+		percpu_ref_switch_to_percpu(&aa_label_reclaim_ref);
+		/*
+		 * Swap the refs again. Label gets all old counts
+		 * in its atomic counter after this operation.
+		 */
+		percpu_ref_swap_percpu_sync(&label->count, &aa_label_reclaim_ref);
+
+		/*
+		 * Transfer the percpu counts, which got added, while this
+		 * switch was going on. The counters are accumulated into
+		 * the label ref's atomic counter.
+		 */
+		percpu_ref_transfer_percpu_count(&label->count, &aa_label_reclaim_ref);
+
+		/* Kill reclaim ref for reinitialization, for next iteration */
+		percpu_ref_kill(&aa_label_reclaim_ref);
+		reclaim_ref_dead_once = true;
+
+		/* If refcount of label ref was found to be 0, reclaim it now! */
+		if (ref_is_zero) {
+			percpu_ref_switch_to_atomic_sync(&label->count);
+			rcu_read_lock();
+			percpu_ref_put(&label->count);
+			held = percpu_ref_tryget(&label->count);
+			if (!held)
+				prev->next = pos->next;
+			rcu_read_unlock();
+			if (!held)
+				continue;
+			percpu_ref_switch_to_percpu(&label->count);
+		}
+
 		cnt++;
 		if (cnt == AA_MAX_LABEL_RECLAIMS) {
 			last_reclaim_label = pos;
@@ -2136,6 +2197,16 @@ static int __init set_init_ctx(void)
 	return 0;
 }
 
+static int __init clear_init_ctx(void)
+{
+	struct cred *cred = (__force struct cred *)current->real_cred;
+
+	set_cred_label(cred, NULL);
+	aa_put_label(ns_unconfined(root_ns));
+
+	return 0;
+}
+
 static void destroy_buffers(void)
 {
 	union aa_buffer *aa_buf;
@@ -2422,6 +2493,14 @@ static int __init apparmor_init(void)
 		queue_delayed_work(aa_label_reclaim_wq, &aa_label_reclaim_work,
 				   AA_LABEL_RECLAIM_INTERVAL_MS);
 
+	if (!percpu_ref_init(&aa_label_reclaim_ref, aa_release_reclaim_ref_noop,
+			     PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
+		AA_ERROR("Failed to allocate label reclaim percpu ref\n");
+		aa_free_root_ns();
+		clear_init_ctx();
+		goto buffers_out;
+	}
+
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
-- 
2.34.1


