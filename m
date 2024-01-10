Return-Path: <linux-kernel+bounces-22073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBA8298C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EE21F26FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502847F78;
	Wed, 10 Jan 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f/U/jC6g"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2636481BC;
	Wed, 10 Jan 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0LILTzv7XtqgeCDn1TyZd79oi82tcmgd2KmXrTHbjqkOfWBPa/Uk1TpSsGyj4LPyY0EJYZJw/3VGY7kSPtHGaFtvbH38LjW0+CHm6H0NEUA5BvVvxBD48UDz3q4pbhst63iTctqdQWebf15f/QxGmQtI7XSYWqMANCLbbjqblEtuykcQNgFpNEqBPm43PspVSgAJZjXN7Z+ueqBEMZbXNd5wq0Xs+/T+0rhKVEtjRelytBfdZrd0IxRFk/D8fjnsn4K6Ugy5gujtNmj7R4B3xIv7PChDyWmZjvwL6/7f6uwFTEMaq9d7EaYOnJ8wAy6G/Sy8J113qkPhDtHj4UYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9IM31eGiOCOGoNM2OrwIrmEWhcfbN98ozVHvP1JWhI=;
 b=JVPB7QkcFsqkIIiT4KYZ8hrOW4XkRINF9e5aM6fdG0w3ZsUuDqjzDo3bI0R18lXBNlm17x6VuNYL3t4MWveMcIVIG1pIpj7wqa664xlXepudR2SLF41p96Sac+800QVPEkdQYmPD8qrXJZFYX8wJ+k6tZF/Jw0q4cIbOZUXAEH+FLSbQ5YqIAMqc6kIbIHOlOV2z7+FtGGGE7/IO7sE2qUO9ZPGAf0Ty3WnuQlQ4yzwSr9Ls490Dm7EdCO6GhU6muEnYaqHPMNi3/flspoAmXMbnDrnvG43Dnf9qU4W8EUWH+pP/oJi8fe6gi5gqC6qZrV4xYvBPeBeKlL86dvb3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9IM31eGiOCOGoNM2OrwIrmEWhcfbN98ozVHvP1JWhI=;
 b=f/U/jC6gJPz/mIK65LgzBiY9w7PSzaY/itsekSG+4CnDukzT4Qsr+vR5/3uC7LG+emy8agk6gwjcM5GrQeG33ZHqKFIbvVAnDcmaBn3TZOKV4Sz0S1cMEXEONsAdFsloX2BSNSNg4X4IlbBfOAvX8enHyp+CZh+/fc1uIhzDqaE=
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 11:20:39 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::c6) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:20:39 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:20:34 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 3/9] apparmor: Switch unconfined namespaces refcount to percpu mode
Date: Wed, 10 Jan 2024 16:48:50 +0530
Message-ID: <20240110111856.87370-3-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 705eecff-5954-47cc-51c6-08dc11ce2cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v14kXEP3V1WNM1eDrhqqxNa43JAzRPnNDsFvY9ucNplJF2PEx3/lyqrEcKRbpUCWHPIc3F0wv8yxA6OoiFMogaeaBt6wAc98E69jJXQmt4o1mhSPc6U2vn+a3Qrlo2kGqfZaBOa3gamah2P04Hb4mbLwK/6FwJRFhowv+X2Mys/U0KlyagZnoth5R9X73XqqyXU4k4JQX+q0QhifDXBo8usazeOO7p4ovRZjbZ7+rFQhsK49FJsUInpPgoZavWnOBqtlCt4h5zpNWyPyKTORFcdnOChwcHqqYMjCDNISFaxPzVeN6zcOn8QJIITdarbuX6iYg6AINVxQzLftbdMUHolvw5aEYmcXppcoofY1p59TtNqyhJs0CZoHuorUFFIGdUGli14LxryLKCsHkDxVJGJa8kjA0K0OouO6W2IaqiHRGzjF7UbyyGqGDc0FK/7syhCV99uAmHAkPuuRz9t422H6bhasYQjkFiR04jLuROtCtMKuyihBaWmQHaIoRU6Is2dFGt7xutjyrfkPpDWn1FFgaasO5trC2EjI77Dlb8L9xuNzrunGsQpyNAmWTgxGTEdusr9QDJdddooRYWzXuFbEdz+kNirsiNqiMRteGXr7OLaotxPns81aZgz8gih2jQB/5Igrf5mqGrcoemtsCR/kufohjjipNPDpRit/QWObp5k2LDUZsUfvejJnsHR0RpNDwLRnJL5v6K0fI8yc0awHIwbfVMUXCzcRK253/00Vi3DQtWBeUm2pbu5Q0i1Rcqjd6LzFpfmfDEQMcTeuMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(16526019)(426003)(1076003)(40480700001)(40460700003)(26005)(336012)(2616005)(7696005)(6666004)(478600001)(356005)(8936002)(8676002)(36756003)(110136005)(54906003)(4326008)(70206006)(70586007)(316002)(86362001)(81166007)(82740400003)(36860700001)(5660300002)(7416002)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:20:39.2124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705eecff-5954-47cc-51c6-08dc11ce2cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Switch unconfined labels to percpu mode, to avoid high
memory contention on refcount get and put operations,
when multiple cpus try to perform these operations
at the same time. Unconfined label for root and sub
namespaces are killed at the point of aa_free_root_ns().
Though labels/profiles in various namespaces could
potentially still be active after this point, aa_free_root_ns()
is not typically called when apparmor enforcement is enabled.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 security/apparmor/include/policy.h    | 24 ++++++++++++++++++++++++
 security/apparmor/include/policy_ns.h | 24 ++++++++++++++++++++++++
 security/apparmor/policy_ns.c         |  6 ++++--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 5849b6b94cea..1e3b29ba6c03 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -379,6 +379,30 @@ static inline void aa_put_profile(struct aa_profile *p)
 		percpu_ref_put(&p->label.count);
 }
 
+/**
+ * aa_switch_ref_profile - switch percpu-ref mode for profile @p
+ * @p: profile  (MAYBE NULL)
+ */
+static inline void aa_switch_ref_profile(struct aa_profile *p, bool percpu)
+{
+	if (p) {
+		if (percpu)
+			percpu_ref_switch_to_percpu(&p->label.count);
+		else
+			percpu_ref_switch_to_atomic_sync(&p->label.count);
+	}
+}
+
+/**
+ * aa_kill_ref_profile - percpu-ref kill for profile @p
+ * @p: profile  (MAYBE NULL)
+ */
+static inline void aa_kill_ref_profile(struct aa_profile *p)
+{
+	if (p)
+		percpu_ref_kill(&p->label.count);
+}
+
 static inline int AUDIT_MODE(struct aa_profile *profile)
 {
 	if (aa_g_audit != AUDIT_NORMAL)
diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
index d646070fd966..f3db01c5e193 100644
--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -127,6 +127,30 @@ static inline void aa_put_ns(struct aa_ns *ns)
 		aa_put_profile(ns->unconfined);
 }
 
+/**
+ * aa_switch_ref_ns - switch percpu-ref mode for @ns
+ * @ns: namespace to switch percpu-ref mode of
+ *
+ * Switch percpu-ref mode of @ns between percpu and atomic
+ */
+static inline void aa_switch_ref_ns(struct aa_ns *ns, bool percpu)
+{
+	if (ns)
+		aa_switch_ref_profile(ns->unconfined, percpu);
+}
+
+/**
+ * aa_kill_ref_ns - do percpu-ref kill for @ns
+ * @ns: namespace to perform percpu-ref kill for
+ *
+ * Do percpu-ref kill of @ns refcount
+ */
+static inline void aa_kill_ref_ns(struct aa_ns *ns)
+{
+	if (ns)
+		aa_kill_ref_profile(ns->unconfined);
+}
+
 /**
  * __aa_findn_ns - find a namespace on a list by @name
  * @head: list to search for namespace on  (NOT NULL)
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 1f02cfe1d974..ca633cfbd936 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -124,6 +124,7 @@ static struct aa_ns *alloc_ns(const char *prefix, const char *name)
 		goto fail_unconfined;
 	/* ns and ns->unconfined share ns->unconfined refcount */
 	ns->unconfined->ns = ns;
+	aa_switch_ref_ns(ns, true);
 
 	atomic_set(&ns->uniq_null, 0);
 
@@ -336,7 +337,7 @@ void __aa_remove_ns(struct aa_ns *ns)
 	/* remove ns from namespace list */
 	list_del_rcu(&ns->base.list);
 	destroy_ns(ns);
-	aa_put_ns(ns);
+	aa_kill_ref_ns(ns);
 }
 
 /**
@@ -377,6 +378,7 @@ int __init aa_alloc_root_ns(void)
 	}
 	kernel_t = &kernel_p->label;
 	root_ns->unconfined->ns = aa_get_ns(root_ns);
+	aa_switch_ref_ns(root_ns, true);
 
 	return 0;
 }
@@ -392,5 +394,5 @@ void __init aa_free_root_ns(void)
 
 	 aa_label_free(kernel_t);
 	 destroy_ns(ns);
-	 aa_put_ns(ns);
+	 aa_kill_ref_ns(ns);
 }
-- 
2.34.1


