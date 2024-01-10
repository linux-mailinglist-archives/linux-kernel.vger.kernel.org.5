Return-Path: <linux-kernel+bounces-22087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81DC8298F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51563B2536C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A947F61;
	Wed, 10 Jan 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5azIPoKK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BC47F73;
	Wed, 10 Jan 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amWZMkyVANAxQpBUYnispvfWqX//xVpVgX6kAHPI/fyGR44G3TWSUxWXHDDJRJ+EeEJDXXQChtOnpljdSzfmcUqza2i9Wjpj/hZTbUhdpfPjStLtSCk1C52avIzZhxf797eeq3XBD+6yoDigYcnDH1ci7xuxpC4oiw91jIt5ANf/HD2F0aTNSDC7xSlhf99noirCII1UgqZkvtDHVNotNVQt/yYri+imOM9pR3drzjiEMjhXjSF4L6X2bmzLBg9OsK6MTFaj14lipK15eIh2gWKXBEtVfwwgKtlxJ1LfAi22n35a/pko99EoxGs+tqUHF2VDA1f/WIVPOqvWZIKQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UltRSwdK6JIZBcVF/T6VTIZcForwpIUmoqVOL1VNIKk=;
 b=AaQqY8Uphv2qGtXnYOmgdbbqvj4ckljHKk+ZBY+OWT6C8ZigJvtA1eBr7oJjPxYBgjW4Pbr6flAKlj5F3CYguty6vyzzOkoRzMBW5eNdQXZN8jeSRkD0k48XFQmN4sUZ6bvB6pQZMYGqKm/scLG9tpDzLV9j8om37OT7uW8ZfjUQW4Z2zBsDPvs0j3u0Ig4hDwgGxgjqgdbWqa783Iz7RrK2yG/gerdQ+yNKfUi9uYGIhVbh1ZLVdcsi8UcJUHXNi0xuIs9jLJLdEC7ThmVw88d4MkYwHwUBhmfruiKouCC2qF9gy0bRDYZ2TFoH4tKgkaEocG3z6bUkI37bZmszZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UltRSwdK6JIZBcVF/T6VTIZcForwpIUmoqVOL1VNIKk=;
 b=5azIPoKKAGdi+r+XXylfE/SohCcw9HK3uaAZLgtmLKfbp3wbCPRq+kkFRtdo4SHM2MrT28PJH323k4snygiykyyxQNloK/BKKGD9zsi9cXvAhbgbS0/xT+eTI0JftB5Dd0Cxti2MJsELDJbabIrIx9OrDzeRKgpqhWkH4teSTEo=
Received: from CYZPR11CA0001.namprd11.prod.outlook.com (2603:10b6:930:8d::28)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:24:20 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::5e) by CYZPR11CA0001.outlook.office365.com
 (2603:10b6:930:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:24:20 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:24:14 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 8/9] apparmor: Switch labels to percpu rcurefcount in unmanaged mode
Date: Wed, 10 Jan 2024 16:48:55 +0530
Message-ID: <20240110111856.87370-8-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: a32288dd-8937-4f4c-9923-08dc11ceb089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OEJGFVpxwvOm8kfJFGTxC7iMq5MuzkpehckbSQHPq38OZK1w8PRsbN8kQVEDqqMURpZXZQpWSe6N0o9IJxQTzVPs6OG+FItr1zrtTd+5eMzdee6C6hqNRngQiLksKVCmlwAFWAZYGqvuYcCKOvGGBMt80He2dAXimT2FqKhs6nJVnxUov4WZtuxIZXvfMN58wMGwAzZhaa6mNTppxKtrqmMdL9ClOCmWLki+2UclAYNDXAHx78iFm94RNLd1izshAPVH9mOr6KVuverb/yS24uxjJX140I2s2fFasRAiCppxM5gVefEifuS/VPFKTbGmPOruRradRZCG7nWaEKOaOt3hQlNOUsar0KbV4pRGF9C8RrLHlT2qQxxXEVoUqQBCIDy4EZ+POjRkrQSsriMjI3L62oHDmhyLgFThKjKTBzagx/QSQbXOh1e9rLglqd5MOZJPq60BY0hpcHpgKTpxchUBnQYq07bFdopes/MN+ofVOPS2XMj2RObwvQ+g/4p9vLhCsxf06WE10ZMMfvDIIIiY+gc7smEPq6P1MHeDngVH6GQECfwnUkzC4/PCCD4PzYlNclfGXOTfCt+ZueGhj0molf8aVvuoBlE+WHn4uuCkJsEqNcYsz9TUtm5HPZRIncgZ6528NH41NYVjevd9hFosKnL5LmGrJ/IDaYgS+vxglWOBsneyHg1j7R+5qLdeQYxweUo5y2oVMIeYmD4/ii+e4ryAHi58sAim887FLfMUvhYzwgkznU3WW5PltBTVaLy4jNPVAk3Puwxcb4nC8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(83380400001)(316002)(426003)(1076003)(2616005)(336012)(26005)(16526019)(82740400003)(36860700001)(47076005)(8936002)(8676002)(5660300002)(30864003)(7416002)(2906002)(54906003)(478600001)(7696005)(4326008)(6666004)(110136005)(70206006)(70586007)(41300700001)(356005)(36756003)(81166007)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:24:20.0791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32288dd-8937-4f4c-9923-08dc11ceb089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068

Replaces label kref with percpu rcurefcount.
The percpu rcuref is initialized in unmanaged/atomic mode,
as labels do not use RCU grace period based release
for labels which do not have a namespace associated
with them yet. Subsequent patch moves the managed/percpu
mode, at points where rcu grace period based cleanup
is guaranteed.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 include/linux/percpu-refcount.h       |   2 -
 lib/percpu-refcount.c                 |  93 -----------
 security/apparmor/include/label.h     |  14 +-
 security/apparmor/include/policy.h    |  32 +---
 security/apparmor/include/policy_ns.h |  24 ---
 security/apparmor/label.c             |   8 +-
 security/apparmor/lsm.c               | 224 --------------------------
 security/apparmor/policy_ns.c         |   6 +-
 8 files changed, 15 insertions(+), 388 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 9e30c458cc00..d73a1c08c3e3 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -131,8 +131,6 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 void percpu_ref_resurrect(struct percpu_ref *ref);
 void percpu_ref_reinit(struct percpu_ref *ref);
 bool percpu_ref_is_zero(struct percpu_ref *ref);
-void percpu_ref_swap_percpu_sync(struct percpu_ref *ref1, struct percpu_ref *ref2);
-void percpu_ref_transfer_percpu_count(struct percpu_ref *ref1, struct percpu_ref *ref2);
 
 /**
  * percpu_ref_kill - drop the initial ref
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 36814446db34..668f6aa6a75d 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -477,96 +477,3 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_resurrect);
-
-static void percpu_ref_swap_percpu_rcu(struct rcu_head *rcu)
-{
-	struct percpu_ref_data *data = container_of(rcu,
-			struct percpu_ref_data, rcu);
-	struct percpu_ref *ref = data->ref;
-
-	data->confirm_switch(ref);
-	data->confirm_switch = NULL;
-	wake_up_all(&percpu_ref_switch_waitq);
-
-}
-
-static void __percpu_ref_swap_percpu(struct percpu_ref *ref, percpu_ref_func_t *confirm_switch)
-{
-	ref->data->confirm_switch = confirm_switch ?:
-		percpu_ref_noop_confirm_switch;
-	call_rcu_hurry(&ref->data->rcu,
-		       percpu_ref_swap_percpu_rcu);
-}
-
-/**
- * percpuref_swap_percpu_sync - Swap percpu counter of one ref with other
- * @ref1: First perpcu_ref to swap the counter
- * @ref2: Second percpu_ref for counter swap
- */
-void percpu_ref_swap_percpu_sync(struct percpu_ref *ref1, struct percpu_ref *ref2)
-{
-	unsigned long __percpu *percpu_count;
-	unsigned long flags;
-	struct percpu_ref_data *data1 = ref1->data;
-	struct percpu_ref_data *data2 = ref2->data;
-	unsigned long percpu_cnt_ptr1 = ref1->percpu_count_ptr;
-	unsigned long percpu_cnt_ptr2 = ref2->percpu_count_ptr;
-	atomic_long_t count1 = ref1->data->count;
-	atomic_long_t count2 = ref2->data->count;
-
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
-	wait_event_lock_irq(percpu_ref_switch_waitq,
-			    !data1->confirm_switch && !data2->confirm_switch,
-			    percpu_ref_switch_lock);
-	if (!__ref_is_percpu(ref1, &percpu_count) ||
-	    !__ref_is_percpu(ref2, &percpu_count)) {
-		spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
-		return;
-	}
-	WRITE_ONCE(ref1->percpu_count_ptr, percpu_cnt_ptr2);
-	WRITE_ONCE(ref2->percpu_count_ptr, percpu_cnt_ptr1);
-
-	__percpu_ref_swap_percpu(ref1, NULL);
-	__percpu_ref_swap_percpu(ref2, NULL);
-	ref1->data->count = count2;
-	ref2->data->count = count1;
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
-	wait_event(percpu_ref_switch_waitq, !ref1->data->confirm_switch &&
-					    !ref2->data->confirm_switch);
-}
-
-/**
- * percpu_ref_transfer_percpu_count - Transfer percpu counts of one ref to other
- * @ref1: perpcu_ref to transfer the counters to
- * @ref2: percpu_ref to transfer the counters from
- *
- * The per cpu counts of ref2 are transferred to the atomic counter of ref1.
- * The ref2 is expected to be inactive.
- */
-void percpu_ref_transfer_percpu_count(struct percpu_ref *ref1, struct percpu_ref *ref2)
-{
-	unsigned long __percpu *percpu_count = percpu_count_ptr(ref2);
-	struct percpu_ref_data *data1 = ref1->data;
-	struct percpu_ref_data *data2 = ref2->data;
-	unsigned long count = 0;
-	unsigned long flags;
-	int cpu;
-
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
-	wait_event_lock_irq(percpu_ref_switch_waitq,
-			    !data1->confirm_switch && !data2->confirm_switch,
-			    percpu_ref_switch_lock);
-
-	if (!__ref_is_percpu(ref1, &percpu_count) ||
-	    !__ref_is_percpu(ref2, &percpu_count)) {
-		spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
-		return;
-	}
-
-	for_each_possible_cpu(cpu) {
-		count += *per_cpu_ptr(percpu_count, cpu);
-		*per_cpu_ptr(percpu_count, cpu) = 0;
-	}
-	atomic_long_add((long)count, &ref1->data->count);
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
-}
diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 0fc4879930dd..3feb3a65a00c 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -14,6 +14,7 @@
 #include <linux/audit.h>
 #include <linux/rbtree.h>
 #include <linux/rcupdate.h>
+#include <linux/percpu-rcurefcount.h>
 
 #include "apparmor.h"
 #include "lib.h"
@@ -121,11 +122,10 @@ struct label_it {
  * @ent: set of profiles for label, actual size determined by @size
  */
 struct aa_label {
-	struct percpu_ref count;
+	struct percpu_rcuref count;
 	long flags;
 	struct aa_proxy *proxy;
 	struct rb_node node;
-	struct llist_node reclaim_node;
 	struct rcu_head rcu;
 	__counted char *hname;
 	u32 secid;
@@ -374,7 +374,7 @@ int aa_label_match(struct aa_profile *profile, struct aa_ruleset *rules,
  */
 static inline struct aa_label *__aa_get_label(struct aa_label *l)
 {
-	if (l && percpu_ref_tryget(&l->count))
+	if (l && percpu_rcuref_tryget(&l->count))
 		return l;
 
 	return NULL;
@@ -383,7 +383,7 @@ static inline struct aa_label *__aa_get_label(struct aa_label *l)
 static inline struct aa_label *aa_get_label(struct aa_label *l)
 {
 	if (l)
-		percpu_ref_get(&(l->count));
+		percpu_rcuref_get(&(l->count));
 
 	return l;
 }
@@ -403,7 +403,7 @@ static inline struct aa_label *aa_get_label_rcu(struct aa_label __rcu **l)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*l);
-	} while (c && !percpu_ref_tryget(&c->count));
+	} while (c && !percpu_rcuref_tryget(&c->count));
 	rcu_read_unlock();
 
 	return c;
@@ -443,7 +443,7 @@ static inline struct aa_label *aa_get_newest_label(struct aa_label *l)
 static inline void aa_put_label(struct aa_label *l)
 {
 	if (l)
-		percpu_ref_put(&l->count);
+		percpu_rcuref_put(&l->count);
 }
 
 
@@ -466,6 +466,4 @@ static inline void aa_put_proxy(struct aa_proxy *proxy)
 
 void __aa_proxy_redirect(struct aa_label *orig, struct aa_label *new);
 
-void aa_label_reclaim_add_label(struct aa_label *label);
-
 #endif /* __AA_LABEL_H */
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 1e3b29ba6c03..5b2473a09103 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -329,7 +329,7 @@ static inline aa_state_t ANY_RULE_MEDIATES(struct list_head *head,
 static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
 {
 	if (p)
-		percpu_ref_get(&(p->label.count));
+		percpu_rcuref_get(&(p->label.count));
 
 	return p;
 }
@@ -343,7 +343,7 @@ static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
  */
 static inline struct aa_profile *aa_get_profile_not0(struct aa_profile *p)
 {
-	if (p && percpu_ref_tryget(&p->label.count))
+	if (p && percpu_rcuref_tryget(&p->label.count))
 		return p;
 
 	return NULL;
@@ -363,7 +363,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*p);
-	} while (c && !percpu_ref_tryget(&c->label.count));
+	} while (c && !percpu_rcuref_tryget(&c->label.count));
 	rcu_read_unlock();
 
 	return c;
@@ -376,31 +376,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 static inline void aa_put_profile(struct aa_profile *p)
 {
 	if (p)
-		percpu_ref_put(&p->label.count);
-}
-
-/**
- * aa_switch_ref_profile - switch percpu-ref mode for profile @p
- * @p: profile  (MAYBE NULL)
- */
-static inline void aa_switch_ref_profile(struct aa_profile *p, bool percpu)
-{
-	if (p) {
-		if (percpu)
-			percpu_ref_switch_to_percpu(&p->label.count);
-		else
-			percpu_ref_switch_to_atomic_sync(&p->label.count);
-	}
-}
-
-/**
- * aa_kill_ref_profile - percpu-ref kill for profile @p
- * @p: profile  (MAYBE NULL)
- */
-static inline void aa_kill_ref_profile(struct aa_profile *p)
-{
-	if (p)
-		percpu_ref_kill(&p->label.count);
+		percpu_rcuref_put(&p->label.count);
 }
 
 static inline int AUDIT_MODE(struct aa_profile *profile)
diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
index f3db01c5e193..d646070fd966 100644
--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -127,30 +127,6 @@ static inline void aa_put_ns(struct aa_ns *ns)
 		aa_put_profile(ns->unconfined);
 }
 
-/**
- * aa_switch_ref_ns - switch percpu-ref mode for @ns
- * @ns: namespace to switch percpu-ref mode of
- *
- * Switch percpu-ref mode of @ns between percpu and atomic
- */
-static inline void aa_switch_ref_ns(struct aa_ns *ns, bool percpu)
-{
-	if (ns)
-		aa_switch_ref_profile(ns->unconfined, percpu);
-}
-
-/**
- * aa_kill_ref_ns - do percpu-ref kill for @ns
- * @ns: namespace to perform percpu-ref kill for
- *
- * Do percpu-ref kill of @ns refcount
- */
-static inline void aa_kill_ref_ns(struct aa_ns *ns)
-{
-	if (ns)
-		aa_kill_ref_profile(ns->unconfined);
-}
-
 /**
  * __aa_findn_ns - find a namespace on a list by @name
  * @head: list to search for namespace on  (NOT NULL)
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 1299262f54e1..f28dec1c3e70 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -336,7 +336,7 @@ void aa_label_destroy(struct aa_label *label)
 			rcu_assign_pointer(label->proxy->label, NULL);
 		aa_put_proxy(label->proxy);
 	}
-	percpu_ref_exit(&label->count);
+	percpu_rcuref_exit(&label->count);
 	aa_free_secid(label->secid);
 
 	label->proxy = (struct aa_proxy *) PROXY_POISON + 1;
@@ -372,7 +372,7 @@ static void label_free_rcu(struct rcu_head *head)
 
 void aa_label_percpu_ref(struct percpu_ref *ref)
 {
-	struct aa_label *label = container_of(ref, struct aa_label, count);
+	struct aa_label *label = container_of(ref, struct aa_label, count.pcpu_ref);
 	struct aa_ns *ns = labels_ns(label);
 
 	if (!ns) {
@@ -409,7 +409,7 @@ bool aa_label_init(struct aa_label *label, int size, gfp_t gfp)
 
 	label->size = size;			/* doesn't include null */
 	label->vec[size] = NULL;		/* null terminate */
-	if (percpu_ref_init(&label->count, aa_label_percpu_ref, PERCPU_REF_INIT_ATOMIC, gfp)) {
+	if (percpu_rcuref_init_unmanaged(&label->count, aa_label_percpu_ref, gfp)) {
 		aa_free_secid(label->secid);
 		return false;
 	}
@@ -710,8 +710,6 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 	rb_link_node(&label->node, parent, new);
 	rb_insert_color(&label->node, &ls->root);
 	label->flags |= FLAG_IN_TREE;
-	percpu_ref_switch_to_percpu(&label->count);
-	aa_label_reclaim_add_label(label);
 
 	return aa_get_label(label);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d0d4ebad1e26..e490a7000408 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -64,204 +64,6 @@ static LIST_HEAD(aa_global_buffers);
 static DEFINE_SPINLOCK(aa_buffers_lock);
 static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
 
-static struct workqueue_struct *aa_label_reclaim_wq;
-static void aa_label_reclaim_work_fn(struct work_struct *work);
-
-/*
- * Dummy llist nodes, for lockless list traveral and deletions by
- * the reclaim worker, while nodes are added from normal label
- * insertion paths.
- */
-struct aa_label_reclaim_node {
-	bool inuse;
-	struct llist_node node;
-};
-
-/*
- * We need two dummy head nodes for lockless list manipulations from reclaim
- * worker - first dummy node will be used in current reclaim iteration;
- * the second one will be used in next iteration. Next iteration marks
- * the first dummy node as free, for use in following iteration.
- */
-#define AA_LABEL_RECLAIM_NODE_MAX     2
-
-#define AA_MAX_LABEL_RECLAIMS	100
-#define AA_LABEL_RECLAIM_INTERVAL_MS	5000
-
-static LLIST_HEAD(aa_label_reclaim_head);
-static struct llist_node *last_reclaim_label;
-static struct aa_label_reclaim_node aa_label_reclaim_nodes[AA_LABEL_RECLAIM_NODE_MAX];
-static DECLARE_DELAYED_WORK(aa_label_reclaim_work, aa_label_reclaim_work_fn);
-static struct percpu_ref aa_label_reclaim_ref;
-
-void aa_label_reclaim_add_label(struct aa_label *label)
-{
-	percpu_ref_get(&label->count);
-	llist_add(&label->reclaim_node, &aa_label_reclaim_head);
-}
-
-static bool aa_label_is_reclaim_node(struct llist_node *node)
-{
-	return &aa_label_reclaim_nodes[0].node <= node &&
-		node <= &aa_label_reclaim_nodes[AA_LABEL_RECLAIM_NODE_MAX - 1].node;
-}
-
-static struct llist_node *aa_label_get_reclaim_node(void)
-{
-	int i;
-	struct aa_label_reclaim_node *rn;
-
-	for (i = 0; i < AA_LABEL_RECLAIM_NODE_MAX; i++) {
-		rn = &aa_label_reclaim_nodes[i];
-		if (!rn->inuse) {
-			rn->inuse = true;
-			return &rn->node;
-		}
-	}
-
-	return NULL;
-}
-
-static void aa_label_put_reclaim_node(struct llist_node *node)
-{
-	struct aa_label_reclaim_node *rn = container_of(node, struct aa_label_reclaim_node, node);
-
-	rn->inuse = false;
-}
-
-static void aa_put_all_reclaim_nodes(void)
-{
-	int i;
-
-	for (i = 0; i < AA_LABEL_RECLAIM_NODE_MAX; i++)
-		aa_label_reclaim_nodes[i].inuse = false;
-}
-static void aa_release_reclaim_ref_noop(struct percpu_ref *ref)
-{
-}
-
-static void aa_label_reclaim_work_fn(struct work_struct *work)
-{
-	struct llist_node *pos, *first, *head, *prev, *next;
-	static bool reclaim_ref_dead_once;
-	struct llist_node *reclaim_node;
-	struct aa_label *label;
-	int cnt = 0;
-	bool held, ref_is_zero;
-
-	first = aa_label_reclaim_head.first;
-	if (!first)
-		goto queue_reclaim_work;
-
-	if (last_reclaim_label == NULL || last_reclaim_label->next == NULL) {
-		reclaim_node = aa_label_get_reclaim_node();
-		WARN_ONCE(!reclaim_node, "Reclaim heads exhausted\n");
-		if (unlikely(!reclaim_node)) {
-			head = first->next;
-			if (!head) {
-				aa_put_all_reclaim_nodes();
-				goto queue_reclaim_work;
-			}
-			prev = first;
-		} else {
-			llist_add(reclaim_node, &aa_label_reclaim_head);
-			prev = reclaim_node;
-			head = prev->next;
-		}
-	} else {
-		prev = last_reclaim_label;
-		head = prev->next;
-	}
-
-	last_reclaim_label = NULL;
-	llist_for_each_safe(pos, next, head) {
-		/* Free reclaim node, which is present in the list */
-		if (aa_label_is_reclaim_node(pos)) {
-			prev->next = pos->next;
-			aa_label_put_reclaim_node(pos);
-			continue;
-		}
-
-		label = container_of(pos, struct aa_label, reclaim_node);
-		if (reclaim_ref_dead_once)
-			percpu_ref_reinit(&aa_label_reclaim_ref);
-
-		/*
-		 * Switch counters of label ref and reclaim ref.
-		 * Label's refcount becomes 1
-		 * Percpu refcount has the current refcount value
-		 * of the label percpu_ref.
-		 */
-		percpu_ref_swap_percpu_sync(&label->count, &aa_label_reclaim_ref);
-
-		/* Switch reclaim ref to percpu, to check for 0 */
-		percpu_ref_switch_to_atomic_sync(&aa_label_reclaim_ref);
-
-		/*
-		 * Release a count (original label percpu ref had an extra count,
-		 * from the llist addition).
-		 * When all percpu references have been released, this should
-		 * be the initial count, which gets dropped.
-		 */
-		percpu_ref_put(&aa_label_reclaim_ref);
-		/*
-		 * Release function of reclaim ref is noop; we store the result
-		 * for later processing after common code.
-		 */
-		if (percpu_ref_is_zero(&aa_label_reclaim_ref))
-			ref_is_zero = true;
-
-		/*
-		 * Restore back initial count. Switch reclaim ref to
-		 * percpu, for switching back the label percpu and
-		 * atomic counters.
-		 */
-		percpu_ref_get(&aa_label_reclaim_ref);
-		percpu_ref_switch_to_percpu(&aa_label_reclaim_ref);
-		/*
-		 * Swap the refs again. Label gets all old counts
-		 * in its atomic counter after this operation.
-		 */
-		percpu_ref_swap_percpu_sync(&label->count, &aa_label_reclaim_ref);
-
-		/*
-		 * Transfer the percpu counts, which got added, while this
-		 * switch was going on. The counters are accumulated into
-		 * the label ref's atomic counter.
-		 */
-		percpu_ref_transfer_percpu_count(&label->count, &aa_label_reclaim_ref);
-
-		/* Kill reclaim ref for reinitialization, for next iteration */
-		percpu_ref_kill(&aa_label_reclaim_ref);
-		reclaim_ref_dead_once = true;
-
-		/* If refcount of label ref was found to be 0, reclaim it now! */
-		if (ref_is_zero) {
-			percpu_ref_switch_to_atomic_sync(&label->count);
-			rcu_read_lock();
-			percpu_ref_put(&label->count);
-			held = percpu_ref_tryget(&label->count);
-			if (!held)
-				prev->next = pos->next;
-			rcu_read_unlock();
-			if (!held)
-				continue;
-			percpu_ref_switch_to_percpu(&label->count);
-		}
-
-		cnt++;
-		if (cnt == AA_MAX_LABEL_RECLAIMS) {
-			last_reclaim_label = pos;
-			break;
-		}
-		prev = pos;
-	}
-
-queue_reclaim_work:
-	queue_delayed_work(aa_label_reclaim_wq, &aa_label_reclaim_work,
-			msecs_to_jiffies(AA_LABEL_RECLAIM_INTERVAL_MS));
-}
-
 /*
  * LSM hook functions
  */
@@ -2197,16 +1999,6 @@ static int __init set_init_ctx(void)
 	return 0;
 }
 
-static int __init clear_init_ctx(void)
-{
-	struct cred *cred = (__force struct cred *)current->real_cred;
-
-	set_cred_label(cred, NULL);
-	aa_put_label(ns_unconfined(root_ns));
-
-	return 0;
-}
-
 static void destroy_buffers(void)
 {
 	union aa_buffer *aa_buf;
@@ -2485,22 +2277,6 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-
-	aa_label_reclaim_wq = alloc_workqueue("aa_label_reclaim",
-				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
-	WARN_ON(!aa_label_reclaim_wq);
-	if (aa_label_reclaim_wq)
-		queue_delayed_work(aa_label_reclaim_wq, &aa_label_reclaim_work,
-				   AA_LABEL_RECLAIM_INTERVAL_MS);
-
-	if (!percpu_ref_init(&aa_label_reclaim_ref, aa_release_reclaim_ref_noop,
-			     PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
-		AA_ERROR("Failed to allocate label reclaim percpu ref\n");
-		aa_free_root_ns();
-		clear_init_ctx();
-		goto buffers_out;
-	}
-
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index ca633cfbd936..1f02cfe1d974 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -124,7 +124,6 @@ static struct aa_ns *alloc_ns(const char *prefix, const char *name)
 		goto fail_unconfined;
 	/* ns and ns->unconfined share ns->unconfined refcount */
 	ns->unconfined->ns = ns;
-	aa_switch_ref_ns(ns, true);
 
 	atomic_set(&ns->uniq_null, 0);
 
@@ -337,7 +336,7 @@ void __aa_remove_ns(struct aa_ns *ns)
 	/* remove ns from namespace list */
 	list_del_rcu(&ns->base.list);
 	destroy_ns(ns);
-	aa_kill_ref_ns(ns);
+	aa_put_ns(ns);
 }
 
 /**
@@ -378,7 +377,6 @@ int __init aa_alloc_root_ns(void)
 	}
 	kernel_t = &kernel_p->label;
 	root_ns->unconfined->ns = aa_get_ns(root_ns);
-	aa_switch_ref_ns(root_ns, true);
 
 	return 0;
 }
@@ -394,5 +392,5 @@ void __init aa_free_root_ns(void)
 
 	 aa_label_free(kernel_t);
 	 destroy_ns(ns);
-	 aa_kill_ref_ns(ns);
+	 aa_put_ns(ns);
 }
-- 
2.34.1


