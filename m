Return-Path: <linux-kernel+bounces-22070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022F18298BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610311F219D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373E47A57;
	Wed, 10 Jan 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hn9UXXll"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6694776D;
	Wed, 10 Jan 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTGDN2iCbj4sizMrdRSuSepl+jM69t07ryhFh/Q7PTnw2p4Wg2jVKnwOIJYTRyZv46fRM5hqdaaysWMUMAH8dKzD3JFyILWSoNaQWXapc6dBeR0kzdL07IQvzRzPLAQsmSnbYxr3pNhHHTlgCDWeVftsvQYH7I5SaS54haBQVlWnVyDmRC80cLqHgtZ8swFm1JQYGvpaZ0YOJlJIaqcm1bTI/iAzNi1EjZvhxEt9Q6zbPT2nK+B0JhjnXQryHm1pgkSMsxPFGZ2waouN3cb5p45zS1/2iDFVij4BsCrfUc+DYNwkcb3XgzkV5X5du5GWxhnd3Ziwqb5LZuB7H0t3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8309bERNeam57LB3VLtITaMwWCCFUEfy1P+5EE0MPM=;
 b=F3lkxqKvXu5u/2CDK3z/NQgAIvGrLFzPwD8BYpEE12JqQrKTK4VLqQT9McDFWqthBmETVlfYg5Xh1r2UJSs2XmHATQBdbf40RYvFn9IQ/q0KrDaGkPX3M1wHePp2eJm+owTwo0AtPIhdAIwBgTgLAh5t2tYfs3Jc/Ymg8WC9+KrE7h58k2kjEEnhlHe3A3SfKhLN0OmILGi1HM9WZYO70tTC9XZHn17rqtYkzmIjaz/7s1XHszNC3lt08wN/lTHX8H8ktJGw/rwTznoVYdC58w9apXSCju/wmy3EEWNV8tNclfIorK/ZUlYJg7z0gvi7H175W+/ntSJKu+TviQ0q9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8309bERNeam57LB3VLtITaMwWCCFUEfy1P+5EE0MPM=;
 b=Hn9UXXll8NAzD+LtvpZiPKfw4FZblZLdQrnm6Y8it9FyqN+52FG+C4HkZVcD6de3fvl/AgJOlKLBEhhCTYkpOx4/KA7/VPozCzNm0YuKjQymKQj5dfuQ3H23iCzhnhq/kzteBe9/HiIjGPXKwJqndWtSw82EN9j9z9JjUAwH/Ao=
Received: from CH0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:76::18)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 11:19:49 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::42) by CH0PR04CA0013.outlook.office365.com
 (2603:10b6:610:76::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 11:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:19:49 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:19:44 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 2/9] apparmor: Switch labels to percpu refcount in atomic mode
Date: Wed, 10 Jan 2024 16:48:49 +0530
Message-ID: <20240110111856.87370-2-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 794a58a3-4a24-41ee-8390-08dc11ce0f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IWtZN/YHGxn+AuwULhv+BpkuyIQKKyednFrMGE1JkRvjJK4d0C08hG44YVxCWkhTRphOBhzCkj2vjMVaE4mYyirucAPw+UoHWXoe+/KBRCFxyGu13RLmDPFYjBPC/nQLJxJvtRkDO4IzwnNkFEj4RbiP067IJkWz6PheizTJ0FsT87jGrxbRm9uARVJpgpQIHE5yHAaCiSyAdBkj8GJNOcyBBegFdTC73rStM+Ji1EIPm+UMAbudRFQa2MMphmDfZvZcxrhajv0D7DwKmx7+fjnrp0w+zsaFHaGjHDs6vO0ip7TRX+iifbqTIWmKt3VJU/16mJ8XpMoU67gKXjJqtT1Kj4ymN1NbQqPLz+f9Er270v1PGom+jhFXluSzOCRDnUCSGiZTBzUaXJG2ESYSgvTF2eTtHb6vEx9M6TreHlj1k/BRComp2fjjcRdLylSyR5W2/VWTlKFhwSh5DgyMPVo8GQkvue7QCn1hhxIaYtiskuggNWX1nkGtQ3ZFPRiwECzE7ANkTe/m4QYbU8yyHbfrfHASnhcn77AuKtUra0iUaGp0V9xZcyzqzWRNa8Z+/wjSGMhL6V8c0sPtEwCrxeDNdI9D82aCb/hMu128DtPzkJXeTsVvZsJlV+BPucIAZpOIT5/y8vmMOHkasHk8ZmaWaGkad1eHJY2D9LyzIRpJJ55kcj1XaFZIMVb42VQbPN5lfha7X/FwsX/kr1BG1NpHm4Td7l948vBvOi3HIFvjKcRYoarKK+w6nKwWlw5qnNs/ERQFNWFPnjrVJfjVNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(41300700001)(70586007)(356005)(36756003)(81166007)(86362001)(70206006)(82740400003)(36860700001)(47076005)(16526019)(426003)(336012)(1076003)(26005)(2616005)(4326008)(2906002)(110136005)(316002)(478600001)(7696005)(54906003)(8936002)(5660300002)(7416002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:19:49.6856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794a58a3-4a24-41ee-8390-08dc11ce0f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

In preparation of using percpu refcount for labels,
this patch replaces label kref with percpu refcount.
The percpu ref is initialized to atomic mode, as
using percpu mode, requires tracking ref kill points.
As the atomic counter is in a different cacheline now,
rearrange some of the fields - flags, proxy; to
optimize some of the fast paths for unconfined labels.

In addition to the requirement to cleanup the percpu
ref using percpu_ref_exit() in label destruction path,
other potential impact from this patch could be:

- Increase in memory requirement (for per cpu counters)
  for each label.

- Displacement of aa_label struct members to different
  cacheline, as percpu ref takes 2 pointers space.

- Moving of the atomic counter outside of the cacheline
  of the aa_label struct.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 security/apparmor/include/label.h  | 16 ++++++++--------
 security/apparmor/include/policy.h |  8 ++++----
 security/apparmor/label.c          | 11 ++++++++---
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 2a72e6b17d68..4b29a4679c74 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -121,12 +121,12 @@ struct label_it {
  * @ent: set of profiles for label, actual size determined by @size
  */
 struct aa_label {
-	struct kref count;
+	struct percpu_ref count;
+	long flags;
+	struct aa_proxy *proxy;
 	struct rb_node node;
 	struct rcu_head rcu;
-	struct aa_proxy *proxy;
 	__counted char *hname;
-	long flags;
 	u32 secid;
 	int size;
 	struct aa_profile *vec[];
@@ -276,7 +276,7 @@ void __aa_labelset_update_subtree(struct aa_ns *ns);
 
 void aa_label_destroy(struct aa_label *label);
 void aa_label_free(struct aa_label *label);
-void aa_label_kref(struct kref *kref);
+void aa_label_percpu_ref(struct percpu_ref *ref);
 bool aa_label_init(struct aa_label *label, int size, gfp_t gfp);
 struct aa_label *aa_label_alloc(int size, struct aa_proxy *proxy, gfp_t gfp);
 
@@ -373,7 +373,7 @@ int aa_label_match(struct aa_profile *profile, struct aa_ruleset *rules,
  */
 static inline struct aa_label *__aa_get_label(struct aa_label *l)
 {
-	if (l && kref_get_unless_zero(&l->count))
+	if (l && percpu_ref_tryget(&l->count))
 		return l;
 
 	return NULL;
@@ -382,7 +382,7 @@ static inline struct aa_label *__aa_get_label(struct aa_label *l)
 static inline struct aa_label *aa_get_label(struct aa_label *l)
 {
 	if (l)
-		kref_get(&(l->count));
+		percpu_ref_get(&(l->count));
 
 	return l;
 }
@@ -402,7 +402,7 @@ static inline struct aa_label *aa_get_label_rcu(struct aa_label __rcu **l)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*l);
-	} while (c && !kref_get_unless_zero(&c->count));
+	} while (c && !percpu_ref_tryget(&c->count));
 	rcu_read_unlock();
 
 	return c;
@@ -442,7 +442,7 @@ static inline struct aa_label *aa_get_newest_label(struct aa_label *l)
 static inline void aa_put_label(struct aa_label *l)
 {
 	if (l)
-		kref_put(&l->count, aa_label_kref);
+		percpu_ref_put(&l->count);
 }
 
 
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 75088cc310b6..5849b6b94cea 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -329,7 +329,7 @@ static inline aa_state_t ANY_RULE_MEDIATES(struct list_head *head,
 static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
 {
 	if (p)
-		kref_get(&(p->label.count));
+		percpu_ref_get(&(p->label.count));
 
 	return p;
 }
@@ -343,7 +343,7 @@ static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
  */
 static inline struct aa_profile *aa_get_profile_not0(struct aa_profile *p)
 {
-	if (p && kref_get_unless_zero(&p->label.count))
+	if (p && percpu_ref_tryget(&p->label.count))
 		return p;
 
 	return NULL;
@@ -363,7 +363,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*p);
-	} while (c && !kref_get_unless_zero(&c->label.count));
+	} while (c && !percpu_ref_tryget(&c->label.count));
 	rcu_read_unlock();
 
 	return c;
@@ -376,7 +376,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 static inline void aa_put_profile(struct aa_profile *p)
 {
 	if (p)
-		kref_put(&p->label.count, aa_label_kref);
+		percpu_ref_put(&p->label.count);
 }
 
 static inline int AUDIT_MODE(struct aa_profile *profile)
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index c71e4615dd46..aa9e6eac3ecc 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -336,6 +336,7 @@ void aa_label_destroy(struct aa_label *label)
 			rcu_assign_pointer(label->proxy->label, NULL);
 		aa_put_proxy(label->proxy);
 	}
+	percpu_ref_exit(&label->count);
 	aa_free_secid(label->secid);
 
 	label->proxy = (struct aa_proxy *) PROXY_POISON + 1;
@@ -369,9 +370,9 @@ static void label_free_rcu(struct rcu_head *head)
 	label_free_switch(label);
 }
 
-void aa_label_kref(struct kref *kref)
+void aa_label_percpu_ref(struct percpu_ref *ref)
 {
-	struct aa_label *label = container_of(kref, struct aa_label, count);
+	struct aa_label *label = container_of(ref, struct aa_label, count);
 	struct aa_ns *ns = labels_ns(label);
 
 	if (!ns) {
@@ -408,7 +409,11 @@ bool aa_label_init(struct aa_label *label, int size, gfp_t gfp)
 
 	label->size = size;			/* doesn't include null */
 	label->vec[size] = NULL;		/* null terminate */
-	kref_init(&label->count);
+	if (percpu_ref_init(&label->count, aa_label_percpu_ref, PERCPU_REF_INIT_ATOMIC, gfp)) {
+		aa_free_secid(label->secid);
+		return false;
+	}
+
 	RB_CLEAR_NODE(&label->node);
 
 	return true;
-- 
2.34.1


