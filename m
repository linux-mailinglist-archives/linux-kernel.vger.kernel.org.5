Return-Path: <linux-kernel+bounces-22085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F58298F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF56B285D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D66482CD;
	Wed, 10 Jan 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vqrEIsEY"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F513AC1B;
	Wed, 10 Jan 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhy+gsqAtwdW+Tx8GKcIp6Rrs8PW+m3jn97oaAYsS7676tbqrvsc80JFdiYzU6LJcDdI7lst+9UG82zoWXoeS6CY1E/zwBTO6SRVsyJu2gpuoPOkPixPHFQewwzusmfvBzoyvXewHQp5VE5CUleoBxqkMK1TrlRQQs2StoWtnGbdqYmCumnOYLPisY0Mc30STo9xU4bkvj1nfCR2gFEoZkwP/TYwlV1Qst0okfFQ0AzmbXdli5XjPv6m2qF8EruzdIgixIiRV2BDXKphx7DP88LAQVjyC6WnXj1pJz0m/SozJ3dCzb4O6jN9ad7e5KdKH5DgZvP+mb3d/lBQAwQ38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKOfcYzr6aIMXZfzvl1jxcNmRnh0a8Ahz66pFK708H0=;
 b=lryO3bryTCpOQJUBC17QF4T3t7C9YnN2nLUkXDxxUphO+BeASsXLEggNUk+C4p3V02xIGY6uG2S0qWNlKvueo5oNyCfBBtMvcC2yzOE/CrvHA5D0weDM2JaaC/JIMcVKxf2FhrAxLjkjZ3GkhVQ4nbJPIKKJOFpIWRFFtA298pibtpduQ/SA0XqRXENl4I6aQCTg4kUL0hE4F8Ci6eloZQgnMNviXLQaExG7ImBrTaZ0YwNZ6J6BzryMVERSJXKgrBeiap8Wqti/SOZyNNIKhWEV14SFLUKKpQe3UfPRgDKZV9/DRt0NdNFAvdNmL5iFa7EBocLFWpzl4334guudIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKOfcYzr6aIMXZfzvl1jxcNmRnh0a8Ahz66pFK708H0=;
 b=vqrEIsEYvDdOG+Yf+mK+7jUZU+2lMAdry0NDyF1hc0Kw8jelYGbsTEU+Rr1i4o464CMOHq6Erpf82YKx5PRWoMlFa3A+5a65Px/gJT2wAA4FRMtVjuA5DGjfwuLNl7iDwCPreDuDXaDQaKQM78Ko6a88nbm0qCXljVbOu4VogyA=
Received: from CY5PR15CA0119.namprd15.prod.outlook.com (2603:10b6:930:68::27)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:23:51 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::91) by CY5PR15CA0119.outlook.office365.com
 (2603:10b6:930:68::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 11:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:23:51 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:23:45 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 7/9] percpu-rcuref: Add basic infrastructure
Date: Wed, 10 Jan 2024 16:48:54 +0530
Message-ID: <20240110111856.87370-7-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 51909158-1f67-4bf5-791a-08dc11ce9f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2MaRpC1axWmVwgDQfK1AlMDYkNBjk4tAsF7Q4ce5F7GglhpDkJ7zWtACQeypxwUBIYdNwL+SgLJ0t+4XDu7xKddWw4cQWi0mpxPuupX7xB54rF4iH/ntBRKpHl0xdaguhOUS7zWAjQK/zOHwrI7OjkNw64DTJNGcNMeV7VCBtjQw0Ld6Q+9ErlY8TgChOzvmGisV6TQq182whuo3sGpdHATfq7t0su7mvC1vlDG6SdCgZkaMsTEzWpQ1ilt3EAzfGaTm3ADpWBHXKuXMRNLePn/6bahTxcITX09dpreyUi6gPsULFkiRo89nYimlp3VuO/MO7r/z40BdWNpkWuT2xXjS38uvfQYd3NjqaSO9Bx81CkzMJvY8TaV1u6TfcLRxAm6HHNV1/QzGGiOh7OpR+Hr0HJMzjiuxekgvPAM6amYuxJcn63Os8aH8nNlIT+8zcNS7yaDauh2G9BufTN0dLixbbtShXWjyyH6LXnpXI2qR4oIEKXxZsaZcKZFQaXyqOlrZeUC7C6IR8JCcL0EOuk6PKW06KjFIkzDF92Xl7Sw9V5dC1vvZEpzBBedGe5B/lJjjfFaIt82IgiX9fXAgVksp6fHBCHT9eTH/RJbHrCQuG+DqY1uqOWW2I1lZon/VINlRYm4QmbFWfGWmpXmSVMLlLtsWWKxp7qEH7Nyev96GZ/x6QRuIYdNk0fND1ZkQTSrJCXWU5vFNA1+KsTdF/zZGOqsaTd/JZx76UytCFa/wfbo0zeTzA5DJ4fXaIDcMth+PIX2gWSHzcaQWjhMtig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(1076003)(426003)(336012)(2616005)(478600001)(7696005)(6666004)(26005)(82740400003)(356005)(86362001)(36756003)(81166007)(2906002)(41300700001)(30864003)(47076005)(5660300002)(83380400001)(7416002)(54906003)(36860700001)(4326008)(110136005)(8936002)(316002)(70206006)(16526019)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:23:51.5933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51909158-1f67-4bf5-791a-08dc11ce9f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

Add infrastructure for managing reclaims of percpu refs,
which use RCU grace period before reclaiming the referenced
objects.

The refcount management of percpu rcuref is same as
normal percpu refcount, with the only difference that,
instead of a explicit shutdown percpu_ref_kill() operation
by the user, the initial ref is managed by a kworker.

The ref can be initialized to start either in managed or
unmanaged mode. In managed mode, the ref is a set of percpu
counters. There is an extra reference acquired for the llist
node and provides the notion of initial ref in percpu refcount.

During normal operation, users ref get() and put() operations
increment/decrement the percpu counters. There is no check
for drop-to-zero while in percpu mode.

Periodically, the manager kworker thread scans all percpu
rcurefs. It switches ref to centralized atomic counter mode
and checks whether the object has no references left. The ref is
dropped if there are no references. Otherwise, the ref is switched
back to percpu mode again. During this ref scan, there is a
window where ref operates in atomic mode. This window spans
one RCU grace period.

There is a provision to start a percpu rcuref in unmanaged mode.
This is provided for cases, where there is a need to avoid
dependency on kworker and RCU grace period. In addition,
unmanaged mode can be used for a ref, for which the release
function initially does not wait for RCU grace period, for
example when the enclosing object initialization fails, and
there is a rollback operation in error paths. Later, when
object initialization is complete, ref can be switched to
percpu managed mode.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |   8 +
 include/linux/percpu-rcurefcount.h            | 115 ++++++
 lib/Makefile                                  |   2 +-
 lib/percpu-rcurefcount.c                      | 336 ++++++++++++++++++
 4 files changed, 460 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/percpu-rcurefcount.h
 create mode 100644 lib/percpu-rcurefcount.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e0891ac76ab3..b2536c4223c1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4576,6 +4576,14 @@
 			allocator.  This parameter is primarily	for debugging
 			and performance comparison.
 
+	percpu-rcurefcount.ref_scan_interval= [KNL]
+			Interval (in ms) between 2 scans of percpu rcu ref
+			managed refs.
+
+	percpu-rcurefcount.max_ref_scan_count= [KNL]
+			Count of the maximum number of pcpu refs scanned during
+			one scan of managed refs.
+
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/arch/x86/i386/IO-APIC.rst.
 
diff --git a/include/linux/percpu-rcurefcount.h b/include/linux/percpu-rcurefcount.h
new file mode 100644
index 000000000000..6022aee1f76e
--- /dev/null
+++ b/include/linux/percpu-rcurefcount.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Percpu refcounts with RCU protected release operation.
+ *
+ * Percpu rcuref is similar to percpu refs. However, they are specialized for
+ * use cases, where the release of  the object is protected by a RCU grace
+ * period.
+ *
+ * The initial ref is managed by the reclaim logic; so, users do not need to
+ * keep track of their initial ref. This is particularly useful, when object's
+ * has references active, beyond the release of the initial reference.
+ *
+ * The current implementation is just a wrapper around the percpu refcount
+ * implementation, to reuse the existing percpu and atomic ref switch
+ * management. Switching to a standalone implementation might be required
+ * if percpuref implementation switches to a non-rcu managed read sections.
+ */
+
+#ifndef _LINUX_PERCPU_RCUREFCOUNT_H
+#define _LINUX_PERCPU_RCUREFCOUNT_H
+
+#include <linux/percpu-refcount.h>
+
+struct percpu_rcuref;
+
+struct percpu_rcuref {
+	struct percpu_ref pcpu_ref;
+	struct llist_node node;
+};
+
+int __must_check percpu_rcuref_init(struct percpu_rcuref *rcuref,
+				 percpu_ref_func_t *release, gfp_t gfp);
+int __must_check percpu_rcuref_init_unmanaged(struct percpu_rcuref *rcuref,
+				 percpu_ref_func_t *release, gfp_t gfp);
+int percpu_rcuref_manage(struct percpu_rcuref *rcuref);
+bool percpu_rcuref_is_zero(struct percpu_rcuref *rcuref);
+void percpu_rcuref_exit(struct percpu_rcuref *rcuref);
+
+/**
+ * percpu_rcuref_get_many - increment a percpu rcuref count
+ * @rcuref: percpu_rcuref to get
+ * @nr: number of references to get
+ *
+ * Analogous to percpu_ref_get_many().
+ */
+static inline void percpu_rcuref_get_many(struct percpu_rcuref *rcuref, unsigned long nr)
+{
+	percpu_ref_get_many(&rcuref->pcpu_ref, nr);
+}
+
+/**
+ * percpu_rcuref_get - increment a percpu rcuref count
+ * @rcuref: percpu_rcuref to get
+ *
+ * Analogous to percpu_ref_get().
+ *
+ */
+static inline void percpu_rcuref_get(struct percpu_rcuref *rcuref)
+{
+	percpu_rcuref_get_many(rcuref, 1);
+}
+
+/**
+ * percpu_rcuref_tryget_many - try to increment a percpu rcuref count
+ * @rcuref: percpu_rcuref to try-get
+ * @nr: number of references to get
+ *
+ * Increment a percpu rcuref count  by @nr unless its count already reached zero.
+ * Returns %true on success; %false on failure.
+ *
+ */
+static inline bool percpu_rcuref_tryget_many(struct percpu_rcuref *rcuref,
+					  unsigned long nr)
+{
+	return percpu_ref_tryget_many(&rcuref->pcpu_ref, nr);
+}
+
+/**
+ * percpu_rcuref_tryget - try to increment a percpu rcuref count
+ * @rcuref: percpu_rcuref to try-get
+ *
+ * Increment a percpu rcurefcount unless its count already reached zero.
+ * Returns %true on success; %false on failure.
+ *
+ */
+static inline bool percpu_rcuref_tryget(struct percpu_rcuref *rcuref)
+{
+	return percpu_rcuref_tryget_many(rcuref, 1);
+}
+
+/**
+ * percpu_rcuref_put_many - decrement a percpu rcuref count
+ * @rcuref: percpu_rcuref to put
+ * @nr: number of references to put
+ *
+ * Decrement the refcount, and if 0, call the release function (which was passed
+ * to percpu_rcuref_init())
+ */
+static inline void percpu_rcuref_put_many(struct percpu_rcuref *rcuref, unsigned long nr)
+{
+	percpu_ref_put_many(&rcuref->pcpu_ref, nr);
+}
+
+/**
+ * percpu_rcuref_put - decrement a percpu rcuref count
+ * @rcuref: percpu_rcuref to put
+ *
+ * Decrement the refcount, and if 0, call the release function (which was passed
+ * to percpu_ref_init())
+ */
+static inline void percpu_rcuref_put(struct percpu_rcuref *rcuref)
+{
+	percpu_rcuref_put_many(rcuref, 1);
+}
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..11da2c586591 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -46,7 +46,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
-	 percpu-refcount.o rhashtable.o base64.o \
+	 percpu-refcount.o  percpu-rcurefcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
diff --git a/lib/percpu-rcurefcount.c b/lib/percpu-rcurefcount.c
new file mode 100644
index 000000000000..d0f2d5e88f98
--- /dev/null
+++ b/lib/percpu-rcurefcount.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/moduleparam.h>
+#include <linux/percpu-rcurefcount.h>
+
+static LLIST_HEAD(pcpu_rcuref_head);
+
+/*
+ * The refcount management of percpu rcuref is same as
+ * normal percpu refcount, with the only difference that,
+ * instead of a explicit shutdown percpu_ref_kill() operation
+ * by the user, the initial ref is managed by a kworker.
+ *
+ * The ref can be initialized to start either in managed or
+ * unmanaged mode. In managed mode, the ref is a set of percpu
+ * counters. There is an extra reference acquired for the llist
+ * node and provides the notion of initial ref in percpu refcount.
+ *
+ * During normal operation, users ref get() and put() operations
+ * increment/decrement the percpu counters. There is no check
+ * for drop-to-zero while in percpu mode.
+ *
+ * Periodically, the manager kworker thread scans all percpu
+ * rcurefs. It switches ref to centralized atomic counter mode
+ * and checks whether the object has no references left. The ref is
+ * dropped if there are no references. Otherwise, the ref is switched
+ * back to percpu mode again. During this ref scan, there is a
+ * window where ref operates in atomic mode. This window spans
+ * one RCU grace period.
+ *
+ * There is a provision to start a percpu rcuref in unmanaged mode.
+ * This is provided for cases, where there is a need to avoid
+ * dependency on kworker and RCU grace period. In addition,
+ * unmanaged mode can be used for a ref, for which the release
+ * function initially does not wait for RCU grace period, for
+ * example when the enclosing object initialization fails, and
+ * there is a rollback operation in error paths. Later, when
+ * object initialization is complete, ref can be switched to
+ * percpu managed mode.
+ */
+/**
+ * percpu_rcuref_init - initialize a percpu rcuref count
+ * @rcuref: percpu_rcuref to initialize
+ * @release: function which will be called when refcount hits 0
+ * @gfp: allocation mask to use
+ *
+ * Initializes @rcuref.  @rcuref starts out in percpu mode with a refcount of 2.
+ * The initial ref is managed by the pcpu rcuref release worker kthread.
+ * The second reference is for the user.
+ *
+ * Note that @release must not sleep - it can block release of other
+ * pcpu rcurefs.
+ */
+int percpu_rcuref_init(struct percpu_rcuref *rcuref, percpu_ref_func_t *release, gfp_t gfp)
+{
+	int ret;
+
+	ret = percpu_ref_init(&rcuref->pcpu_ref, release,
+			      PERCPU_REF_ALLOW_REINIT, gfp);
+	if (ret)
+		return ret;
+	percpu_ref_get(&rcuref->pcpu_ref);
+	llist_add(&rcuref->node, &pcpu_rcuref_head);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(percpu_rcuref_init);
+
+/**
+ * percpu_rcuref_init_unmanaged - initialize a percpu rcuref count in
+ *                                unmanaged (atomic) mode.
+ * @rcuref: percpu_rcuref to initialize
+ * @release: function which will be called when refcount hits 0
+ * @gfp: allocation mask to use
+ *
+ * Initializes @rcuref.  @rcuref starts out in unmanaged/atomic mode
+ * with a refcount of 1.
+ * The initial ref is passed to the user and ref management is
+ * auto, the last put operation releases the ref.
+ * The ref may be initialized in this mode, to avoid dependency
+ * on workqueue and RCU, for early boot code; and for cases where
+ * a ref starts as non-RCU release and switches to RCU grace period
+ * based release of the reference. The percpu_rcuref_manage() call
+ * can be used to switch this ref to managed mode, while the ref
+ * is active. This operation is non-reversible, and the ref remains
+ * in managed mode, for its lifeline, until it is released by the
+ * pcpu release kworker.
+ *
+ * Note that @release must not sleep - if the ref is switched to
+ * managed mode, it can block release of other pcpu rcurefs.
+ */
+int percpu_rcuref_init_unmanaged(struct percpu_rcuref *rcuref,
+				 percpu_ref_func_t *release, gfp_t gfp)
+{
+	int ret;
+
+	ret = percpu_ref_init(&rcuref->pcpu_ref, release, PERCPU_REF_INIT_ATOMIC, gfp);
+	if (!ret)
+		init_llist_node(&rcuref->node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(percpu_rcuref_init_unmanaged);
+
+/**
+ * percpu_rcuref_manage - Switch an unmanaged ref to percpu mode.
+ *
+ * @rcuref: percpu_rcuref to initialize
+ * @release: function which will be called when refcount hits 0
+ * @gfp: allocation mask to use
+ *
+ */
+int percpu_rcuref_manage(struct percpu_rcuref *rcuref)
+{
+	if (WARN_ONCE(!percpu_rcuref_tryget(rcuref), "Percpu rcuref is not active\n"))
+		return -1;
+	if (WARN_ONCE(llist_on_list(&rcuref->node), "Percpu rcuref already managed\n")) {
+		percpu_rcuref_put(rcuref);
+		return -2;
+	}
+	percpu_ref_switch_to_percpu(&rcuref->pcpu_ref);
+	/* Ensure ordering of percpu mode switch and node scan */
+	smp_mb();
+	llist_add(&rcuref->node, &pcpu_rcuref_head);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(percpu_rcuref_manage);
+
+/**
+ * percpu_rcuref_is_zero - test whether a percpu rcuref count reached zero
+ * @rcuref: percpu_rcuref to test
+ *
+ * Returns %true if @ref reached zero.
+ */
+bool percpu_rcuref_is_zero(struct percpu_rcuref *rcuref)
+{
+	return percpu_ref_is_zero(&rcuref->pcpu_ref);
+}
+EXPORT_SYMBOL_GPL(percpu_rcuref_is_zero);
+
+/**
+ * percpu_rcuref_exit - undo percpu_rcuref_init()
+ * @rcuref: percpu_rcuref to exit
+ *
+ * This function exits @rcuref.  The caller is responsible for ensuring that
+ * @rcuref is no longer in active use.  The usual places to invoke this
+ * function from are the @rcuref->release() callback or in init failure path
+ * where percpu_rcuref_init() succeeded but other parts of the initialization
+ * of the embedding object failed.
+ */
+void percpu_rcuref_exit(struct percpu_rcuref *rcuref)
+{
+	percpu_ref_exit(&rcuref->pcpu_ref);
+	init_llist_node(&rcuref->node);
+}
+
+#define DEFAULT_PCPU_RCUREF_SCAN_INTERVAL_MS    5000
+/* Interval duration between two ref scans. */
+static ulong ref_scan_interval = DEFAULT_PCPU_RCUREF_SCAN_INTERVAL_MS;
+module_param(ref_scan_interval, ulong, 0444);
+
+#define DEFAULT_PCPU_RCUREF_MAX_SCAN_COUNT      100
+/* Number of pcpu refs scanned in one iteration of worker execution. */
+static int max_ref_scan_count = DEFAULT_PCPU_RCUREF_MAX_SCAN_COUNT;
+module_param(max_ref_scan_count, int, 0444);
+
+static void percpu_rcuref_release_work_fn(struct work_struct *work);
+
+/*
+ * Sentinel llist nodes, for lockless list traveral and deletions by
+ * the pcpu rcuref release worker, while nodes are added from normal
+ * from percpu_rcuref_init() and percpu_rcuref_manage().
+ *
+ * Sentinel node marks the head of list traversal for the current
+ * iteration of kworker execution.
+ */
+struct pcpu_rcuref_sen_node {
+	bool inuse;
+	struct llist_node node;
+};
+
+/*
+ * We need two sentinel nodes for lockless list manipulations from release
+ * worker - first node will be used in current reclaim iteration.The second
+ * node will be used in next iteration. Next iteration marks the first node
+ * as free, for use in following iteration.
+ */
+#define PCPU_RCUREF_SEN_NODES_COUNT     2
+
+/* Track last processed percpu rcuref node */
+static struct llist_node *last_pcu_rcuref_node;
+
+static struct pcpu_rcuref_sen_node
+	pcpu_rcuref_sen_nodes[PCPU_RCUREF_SEN_NODES_COUNT];
+
+static DECLARE_DELAYED_WORK(percpu_rcuref_release_work,
+			    percpu_rcuref_release_work_fn);
+
+static bool percpu_rcuref_is_sen_node(struct llist_node *node)
+{
+	return &pcpu_rcuref_sen_nodes[0].node <= node &&
+		node <= &pcpu_rcuref_sen_nodes[PCPU_RCUREF_SEN_NODES_COUNT - 1].node;
+}
+
+static struct llist_node *percpu_rcuref_get_sen_node(void)
+{
+	int i;
+	struct pcpu_rcuref_sen_node *sn;
+
+	for (i = 0; i < PCPU_RCUREF_SEN_NODES_COUNT; i++) {
+		sn = &pcpu_rcuref_sen_nodes[i];
+		if (!sn->inuse) {
+			sn->inuse = true;
+			return &sn->node;
+		}
+	}
+
+	return NULL;
+}
+
+static void percpu_rcuref_put_sen_node(struct llist_node *node)
+{
+	struct pcpu_rcuref_sen_node *sn = container_of(node, struct pcpu_rcuref_sen_node, node);
+
+	sn->inuse = false;
+}
+
+static void percpu_rcuref_put_all_sen_nodes_except(struct llist_node *node)
+{
+	int i;
+
+	for (i = 0; i < PCPU_RCUREF_SEN_NODES_COUNT; i++) {
+		if (&pcpu_rcuref_sen_nodes[i].node == node)
+			continue;
+		pcpu_rcuref_sen_nodes[i].inuse = false;
+		init_llist_node(&pcpu_rcuref_sen_nodes[i].node);
+	}
+}
+
+static struct workqueue_struct *percpu_rcuref_wq;
+
+static void percpu_rcuref_release_work_fn(struct work_struct *work)
+{
+	struct llist_node *pos, *first, *head, *prev, *next;
+	struct percpu_rcuref *rcuref;
+	struct llist_node *sen_node;
+	int count = 0;
+	bool held;
+
+	first = READ_ONCE(pcpu_rcuref_head.first);
+	if (!first)
+		goto queue_release_work;
+
+	if (last_pcu_rcuref_node == NULL || last_pcu_rcuref_node->next == NULL) {
+retry_sentinel_get:
+		sen_node = percpu_rcuref_get_sen_node();
+		/*
+		 * All sentinel nodes are in use? This should not happen, as we
+		 * require only one sentinel for the start of list traversal and
+		 * other sentinel node is freed during the traversal.
+		 */
+		if (WARN_ONCE(!sen_node, "Percpu RCU ref sentinel nodes exhausted\n")) {
+			/* Use first node as the sentinel node */
+			head = first->next;
+			if (!head) {
+				struct llist_node *ign_node = NULL;
+				/*
+				 * We exhausted sentinel nodes. However, there aren't
+				 * enough nodes in the llist. So, we have leaked
+				 * sentinel nodes. Reclaim sentinels and retry.
+				 */
+				if (percpu_rcuref_is_sen_node(first))
+					ign_node = first;
+				percpu_rcuref_put_all_sen_nodes_except(ign_node);
+				goto retry_sentinel_get;
+			}
+			prev = first;
+		} else {
+			llist_add(sen_node, &pcpu_rcuref_head);
+			prev = sen_node;
+			head = prev->next;
+		}
+	} else {
+		prev = last_pcu_rcuref_node;
+		head = prev->next;
+	}
+
+	last_pcu_rcuref_node = NULL;
+	llist_for_each_safe(pos, next, head) {
+		/* Free sentinel node which is present in the list */
+		if (percpu_rcuref_is_sen_node(pos)) {
+			prev->next = pos->next;
+			percpu_rcuref_put_sen_node(pos);
+			continue;
+		}
+
+		rcuref = container_of(pos, struct percpu_rcuref, node);
+		percpu_ref_switch_to_atomic_sync(&rcuref->pcpu_ref);
+		/*
+		 * Drop the ref while in RCU read critical section, to
+		 * prevent obj free while we manipulating node.
+		 */
+		rcu_read_lock();
+		percpu_ref_put(&rcuref->pcpu_ref);
+		held = percpu_ref_tryget(&rcuref->pcpu_ref);
+		if (!held) {
+			prev->next = pos->next;
+			init_llist_node(pos);
+		}
+		rcu_read_unlock();
+		if (!held)
+			continue;
+		percpu_ref_switch_to_percpu(&rcuref->pcpu_ref);
+		count++;
+		if (count == max_ref_scan_count) {
+			last_pcu_rcuref_node = pos;
+			break;
+		}
+		prev = pos;
+	}
+
+queue_release_work:
+	queue_delayed_work(percpu_rcuref_wq, &percpu_rcuref_release_work,
+			   ref_scan_interval);
+}
+
+static __init int percpu_rcuref_setup(void)
+{
+	percpu_rcuref_wq = alloc_workqueue("percpu_rcuref",
+				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+	if (!percpu_rcuref_wq)
+		return -ENOMEM;
+
+	queue_delayed_work(percpu_rcuref_wq, &percpu_rcuref_release_work,
+			   ref_scan_interval);
+	return 0;
+}
+early_initcall(percpu_rcuref_setup);
-- 
2.34.1


