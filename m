Return-Path: <linux-kernel+bounces-22077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7F8298D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA13281A88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFCF482EA;
	Wed, 10 Jan 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ntpzGnGi"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E681481D6;
	Wed, 10 Jan 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwIEtErzN4qt1T36iJqsR1VX2fCtoyRhOpY1UTe08EeQosayY2pikpBSBT97/eq9BFnn90HkqoCrcMEn80Sp1RAZbWPKNpTwJFCWdMx/hvpChUNiqhPdalbF7DH6c26sssLReKRk7Sb0zGQScHtQoigaRGkd7kXseIrLTqOBFBAAgoA6qrDubji+xSlYTA0gjt0TSrvdrnJff6sh9qLraiikCxKoLtrro04pYmp5Ck1ebXl/FrYubXNjZgw67ssrZpnBcv7MznMq1KtvCDyVcYFTa/G9I/ZRdHT+M1o71qgS9Vx+1beY7iz2oMcBnTdOqT+gKip+e7Du0KnBADGYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqLIlC44fG9l3ORd4q9RiH8jMihPPd98yhdxmQ3nUvI=;
 b=S/nN+JTGjYftRGZ78BF0tZzJSVpviuehdvudYaQ3C7jndO2wwbVnlH5ONt3EE+azt93x0D+E7nGHL1G/KAG3aYRh5ndCt9RQ5C//f1Y4flJsf7otoT1B0J2OYMKA6//P1BcWC7bFYDbvROd1DBw04HXTHUjpsewf/JNhByGLaXd8dfMZh4DZjYL+IGQ1Bwqn9DuHUSQvsbcnd3APgBPa3H/zE8cx+vOYAUdOhm8QpGbHZeIAW+r6nib1PLdQXfA86EzEUEab2lma4Sb9mkPaU+fXGrOQoUpnYmxHBkKGJxMalN6xlV7YLq1HLl8KQuF39JKFf5yR2bPdyFc/eE+BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqLIlC44fG9l3ORd4q9RiH8jMihPPd98yhdxmQ3nUvI=;
 b=ntpzGnGi1OkwjgfyIPtUbzEovxoRuau80ENxAstht7wlbR596NjnpxUMfQ/5bJr99Z0hUBOIV4tXQU5xrLSJSpCoH3eXP7B8/HVi74a4mKmkzadSni5zceSJ7+Kk1fTGB5hOIHDxDf5I3hGsOAZ3hqZV/etpzkZ5bVGVsr8+N2I=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 11:21:28 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::b7) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 11:21:28 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:21:23 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 4/9] apparmor: Add infrastructure to reclaim percpu labels
Date: Wed, 10 Jan 2024 16:48:51 +0530
Message-ID: <20240110111856.87370-4-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3e4873-0678-4f29-4376-08dc11ce4a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUZ+ifiGX75DN6nvElocYRnHCXlefuvEHkuoQnS1SWuqfeL412Amnv+Yo++ilFEchh2MQgqwzqUwuwLTzFislrGYoNH4wvVvI2pEE/WPRKDfhfiYrqh/uAxcOhsWJFgjISPUVHW2nkHWHlqK7yLDdH7ptRv4ZuYKLoR8c9zYVZ283mQo5lsgS37LDq9+VbZYSX0cXT1MbVzQ5jE6MOAh95Xqn83zN/OIKwzpP+67jKusCiUTMJ9fDKYtXyiOiycJ68pr8UFT8GBo+10RtJr81Xsvnspj99IHsfaBDAr+e8cZNwuD5R1X1lK2HupjuDtB0BI2OaCpkBcT5bNd6OdO6c1+Ad49joAeuX2Eq30VmRBVUvJgcmBAt5KpNo5l0wxIu0exnCETIxkplCAVRXbx5ZIoy0+IT3/zroz7m8JBWxU28u/9CDJnvbQJrNYe3FGVm8edAf1fePbhGMIOcutrnUMWA6XHKEs8iOuMv45Pwjf68se6WybWxP+TkNodEIiSYUqhuCpzIbqSSqvdtGFx2+AkA3qkBLK6QQlJMocZ9qaKJp3IYmPXJs7kB6DIIC4h32K1T8ATnlV/lGXJ2BnN7T9rA41MWinKlQ3HLwDYwfPVUrZiaBQjIZYJeIi6bQy1+AmoH9qHU76moGh+6+t0NZbmQh0ubpXPrq6Xxm8ekBaN3y09X1lxpGGSENEXaIYMH5cZSCaja1C5xA5cSw3GXlYh7JE0x9uduBroZTfEfN0knLfzDH66A6bpcLevpdaPgoeGu8wEaKaaciVbsmw9Dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(478600001)(426003)(336012)(26005)(16526019)(2616005)(6666004)(7696005)(1076003)(86362001)(83380400001)(110136005)(70206006)(70586007)(36860700001)(54906003)(316002)(47076005)(82740400003)(5660300002)(36756003)(41300700001)(356005)(7416002)(81166007)(2906002)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:21:28.5934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3e4873-0678-4f29-4376-08dc11ce4a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

Nginx performance testing with Apparmor enabled (with nginx
running in unconfined profile), on kernel versions 6.1 and 6.5
show significant drop in throughput scalability, when Nginx
workers are scaled to higher number of CPUs across various
L3 cache domains.

Below is one sample data on the throughput scalability loss,
based on results on AMD Zen4 system with 96 CPUs with SMT
core count 2; so, overall, 192 CPUs:

Config      Cache Domains     apparmor=off        apparmor=on
                             scaling eff (%)      scaling eff (%)
8C16T          1                  100%             100%
16C32T         2                   95%              94%
24C48T         3                   94%              93%
48C96T         6                   92%              88%
96C192T        12                  85%              68%

There is a significant drop in scaling efficiency, when we
move to 96 CPUs/192 SMT threads.

Perf tool shows most of the contention coming from below
6.56%     nginx  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj
6.22%     nginx  [kernel.vmlinux]      [k] apparmor_file_open

The majority of the CPU cycles is found to be due to memory contention
in atomic_fetch_add and atomic_fetch_sub operations from kref_get() and
kref_put() operations on label.

A part of the contention was remove with commit 2516fde1fa00
("apparmor: Optimize retrieving current task secid"), which
is part of 6.7-rc1 release. After including this commit, the
scaling efficiency improved as shown below:

Config      Cache Domains     apparmor=on        apparmor=on (patched)
                             scaling eff (%)      scaling eff (%)
8C16T          1                  100%             100%
16C32T         2                   97%              93%
24C48T         3                   94%              92%
48C96T         6                   88%              88%
96C192T        12                  65%              79%

However, the scaling efficiency impact is still significant even
after including the commit. In addition, the performance impact
is even higher when we move to >192 CPUs. In addition, the
memory contention impact would increase whem there is a high
frequency of label update operations and labels are marked
stale more frequently.

This patch adds a mechanism to manage reclaim of apparmor labels,
when they are working in percpu mode. Using percpu refcount
for apparmor label refcount helps solve the throughput scalability
drop problem seen on nginx.

Config      Cache Domains     apparmor=on (percpuref)
                              scaling eff (%)
8C16T          1                  100%
16C32T         2                   96%
24C48T         3                   94%
48C96T         6                   93%
96C192T        12                  90%

Below is the sequence of operations, which shows the refcount
management with this approach:

1. During label initialization, the percpu ref is initialized in
   atomic mode. This is done to ensure that, for cases where the
   label hasn't gone live (->ns isn't assigned), mostly during
   initialization error paths.

2. Labels are switched to percpu mode at various points -
   when a label is added to labelset tree, when a unconfined profile
   has been assigned a namespace.

3. As part of the initial prototype, only the in tree labels
   are managed by the kworker. These labels are added to a lockless
   list. The unconfined labels invoke a percpu_ref_kill() operation
   when the namespace is destroyed.

4. The kworker does a periodic scan of all the labels in the
   llist. It does below sequence of operations:

   a. Enqueue a dummy node to mark the start of scan. This dummy
      node is used as start point of scan and ensures that we
      there is no additional synchronization required with new
      label node additions to the llist. Any new labels will
      be processed in next run of the kworker.

                     SCAN START PTR
                           |
                           v
      +----------+     +------+    +------+    +------+
      |          |     |      |    |      |    |      |
      |   head   ------> dummy|--->|label |--->| label|--->NULL
      |          |     | node |    |      |    |      |
      +----------+     +------+    +------+    +------+

	   New label addition:

                              SCAN START PTR
                                   |
                                   v
      +----------+  +------+  +------+    +------+    +------+
      |          |  |      |  |      |    |      |    |      |
      |   head   |--> label|--> dummy|--->|label |--->| label|--->NULL
      |          |  |      |  | node |    |      |    |      |
      +----------+  +------+  +------+    +------+    +------+

    b. Traverse through the llist, starting from dummy->next.
       If the node is a dummy node, mark it free.
       If the node is a label node, do,

	    i) Switch the label ref to atomic mode. The ref switch wait
               for the existing percpu_ref_get() and percpu_ref_put()
               operations to complete, by waiting for a RCU grace period.

               Once the switch is complete, from this point onwards, any
               percpu_ref_get(), percpu_ref_put() operations use
               atomic operations.

           ii) Drop the initial reference, which was taken while adding
               the label node to the llist.

          iii) Use a percpu_ref_tryget() increment operation on the
               ref, to see if we dropped the last ref count. if we
               dropped the last count, we remove the node from the llist.

               All of these operations are done inside a RCU critical
               section, to avoid race with the release operations,
               which can potentially trigger, as soon as we drop
               the initial ref count.

         iv)  If we didn't drop the last ref, switch back the counter
              to percpu mode.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 security/apparmor/include/label.h |   3 +
 security/apparmor/lsm.c           | 145 ++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 4b29a4679c74..0fc4879930dd 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -125,6 +125,7 @@ struct aa_label {
 	long flags;
 	struct aa_proxy *proxy;
 	struct rb_node node;
+	struct llist_node reclaim_node;
 	struct rcu_head rcu;
 	__counted char *hname;
 	u32 secid;
@@ -465,4 +466,6 @@ static inline void aa_put_proxy(struct aa_proxy *proxy)
 
 void __aa_proxy_redirect(struct aa_label *orig, struct aa_label *new);
 
+void aa_label_reclaim_add_label(struct aa_label *label);
+
 #endif /* __AA_LABEL_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e490a7000408..cf8429f5c88e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -64,6 +64,143 @@ static LIST_HEAD(aa_global_buffers);
 static DEFINE_SPINLOCK(aa_buffers_lock);
 static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
 
+static struct workqueue_struct *aa_label_reclaim_wq;
+static void aa_label_reclaim_work_fn(struct work_struct *work);
+
+/*
+ * Dummy llist nodes, for lockless list traveral and deletions by
+ * the reclaim worker, while nodes are added from normal label
+ * insertion paths.
+ */
+struct aa_label_reclaim_node {
+	bool inuse;
+	struct llist_node node;
+};
+
+/*
+ * We need two dummy head nodes for lockless list manipulations from reclaim
+ * worker - first dummy node will be used in current reclaim iteration;
+ * the second one will be used in next iteration. Next iteration marks
+ * the first dummy node as free, for use in following iteration.
+ */
+#define AA_LABEL_RECLAIM_NODE_MAX     2
+
+#define AA_MAX_LABEL_RECLAIMS	100
+#define AA_LABEL_RECLAIM_INTERVAL_MS	5000
+
+static LLIST_HEAD(aa_label_reclaim_head);
+static struct llist_node *last_reclaim_label;
+static struct aa_label_reclaim_node aa_label_reclaim_nodes[AA_LABEL_RECLAIM_NODE_MAX];
+static DECLARE_DELAYED_WORK(aa_label_reclaim_work, aa_label_reclaim_work_fn);
+
+void aa_label_reclaim_add_label(struct aa_label *label)
+{
+	percpu_ref_get(&label->count);
+	llist_add(&label->reclaim_node, &aa_label_reclaim_head);
+}
+
+static bool aa_label_is_reclaim_node(struct llist_node *node)
+{
+	return &aa_label_reclaim_nodes[0].node <= node &&
+		node <= &aa_label_reclaim_nodes[AA_LABEL_RECLAIM_NODE_MAX - 1].node;
+}
+
+static struct llist_node *aa_label_get_reclaim_node(void)
+{
+	int i;
+	struct aa_label_reclaim_node *rn;
+
+	for (i = 0; i < AA_LABEL_RECLAIM_NODE_MAX; i++) {
+		rn = &aa_label_reclaim_nodes[i];
+		if (!rn->inuse) {
+			rn->inuse = true;
+			return &rn->node;
+		}
+	}
+
+	return NULL;
+}
+
+static void aa_label_put_reclaim_node(struct llist_node *node)
+{
+	struct aa_label_reclaim_node *rn = container_of(node, struct aa_label_reclaim_node, node);
+
+	rn->inuse = false;
+}
+
+static void aa_put_all_reclaim_nodes(void)
+{
+	int i;
+
+	for (i = 0; i < AA_LABEL_RECLAIM_NODE_MAX; i++)
+		aa_label_reclaim_nodes[i].inuse = false;
+}
+
+static void aa_label_reclaim_work_fn(struct work_struct *work)
+{
+	struct llist_node *pos, *first, *head, *prev, *next;
+	struct llist_node *reclaim_node;
+	struct aa_label *label;
+	int cnt = 0;
+	bool held;
+
+	first = aa_label_reclaim_head.first;
+	if (!first)
+		goto queue_reclaim_work;
+
+	if (last_reclaim_label == NULL || last_reclaim_label->next == NULL) {
+		reclaim_node = aa_label_get_reclaim_node();
+		WARN_ONCE(!reclaim_node, "Reclaim heads exhausted\n");
+		if (unlikely(!reclaim_node)) {
+			head = first->next;
+			if (!head) {
+				aa_put_all_reclaim_nodes();
+				goto queue_reclaim_work;
+			}
+			prev = first;
+		} else {
+			llist_add(reclaim_node, &aa_label_reclaim_head);
+			prev = reclaim_node;
+			head = prev->next;
+		}
+	} else {
+		prev = last_reclaim_label;
+		head = prev->next;
+	}
+
+	last_reclaim_label = NULL;
+	llist_for_each_safe(pos, next, head) {
+		/* Free reclaim node, which is present in the list */
+		if (aa_label_is_reclaim_node(pos)) {
+			prev->next = pos->next;
+			aa_label_put_reclaim_node(pos);
+			continue;
+		}
+
+		label = container_of(pos, struct aa_label, reclaim_node);
+		percpu_ref_switch_to_atomic_sync(&label->count);
+		rcu_read_lock();
+		percpu_ref_put(&label->count);
+		held = percpu_ref_tryget(&label->count);
+		if (!held)
+			prev->next = pos->next;
+		rcu_read_unlock();
+		if (!held)
+			continue;
+		percpu_ref_switch_to_percpu(&label->count);
+		cnt++;
+		if (cnt == AA_MAX_LABEL_RECLAIMS) {
+			last_reclaim_label = pos;
+			break;
+		}
+		prev = pos;
+	}
+
+queue_reclaim_work:
+	queue_delayed_work(aa_label_reclaim_wq, &aa_label_reclaim_work,
+			msecs_to_jiffies(AA_LABEL_RECLAIM_INTERVAL_MS));
+}
+
 /*
  * LSM hook functions
  */
@@ -2277,6 +2414,14 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
+
+	aa_label_reclaim_wq = alloc_workqueue("aa_label_reclaim",
+				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+	WARN_ON(!aa_label_reclaim_wq);
+	if (aa_label_reclaim_wq)
+		queue_delayed_work(aa_label_reclaim_wq, &aa_label_reclaim_work,
+				   AA_LABEL_RECLAIM_INTERVAL_MS);
+
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
-- 
2.34.1


