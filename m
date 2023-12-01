Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567F8000AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376474AbjLAA5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjLAA5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F231712;
        Thu, 30 Nov 2023 16:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuMsAsrxU09TgFdwksBE4sAOvh9b7rK11imCB21owgAXo0QF4cRZs5/fitKPYALRLttUhSs2/6VGU3Btix/yix+scrwo4YNrnIcRbDwlTtNi4aEZqUOMeCeJevPNC9yDhhRiTyV5quMgprbuApAoEaEB2nSsMv1EYMdTTxS3a8wpLWCELtXULRxhLdfOvkjgrIl2RLBo19JxPi6onKBGE5+3EGh8tBib6Yihk3qelpUBFHvKR/lO6/7hBkWXoW2BV4BZefWbbMBXpprihJRClUvFlKuhAdEKWtgo6fjzBG7avBCDjINPti+6oXW0s3PvMjHhxeL2akIJZpDOQ/xZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVaOPYVaY2yXgh58mtoxrIM22l31oXSUrsqSkJ/zedw=;
 b=A0HQ67qXAySzZfa9vtTemyAOfZloJ+GxD9U4fzn4XqzmwGrFQ25F1YXkngWe1kYATjdfDO1vDTY7uyhT6SHypDrTkMwKGH1mCAF2Ouzo8QcPFdAkgGSpDnOtcjSJ8qSyZgc6QBaqM0c1LupGFCQvaY0nYrmQKLJSWpFFSX7UKT36xtNtft66u+UyzEZ8rfWX1Olg8SjFKFGETH1kelCwPb/5mPr0XvcU000ot9R6qpUwQTmQMpI3ZLJbqOzXNDjkpTlCDav41Zfx/EtZeVKGsjli3PRCM2wL8MUZIY/i+HpQCwTM6z2a6mJMKKFy/7tIOMfySjGwpINOddmBohfGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVaOPYVaY2yXgh58mtoxrIM22l31oXSUrsqSkJ/zedw=;
 b=ESgkKhQMSBSfrUrJRqmyBCPSp6eRAcuFrAaTrH/3ao++HLe6XQA+mqx3+4qUC2m1hOu57ZuO+0LDsGZ69D45eo1kK8PBwLsPrZE1rdXN6+dN7tMP8tEH/58olH8nf71vnAlOYe1qj+2wp83O+cwON/niMpSCRC2UYGGf5/G/cRE=
Received: from PH8PR21CA0021.namprd21.prod.outlook.com (2603:10b6:510:2ce::15)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:36 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::6e) by PH8PR21CA0021.outlook.office365.com
 (2603:10b6:510:2ce::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.14 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:34 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <babu.moger@amd.com>,
        <jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
        <jithu.joseph@intel.com>, <kan.liang@linux.intel.com>,
        <nikunj@amd.com>, <daniel.sneddon@linux.intel.com>,
        <pbonzini@redhat.com>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <maciej.wieczor-retman@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>, <peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH 05/15] x86/resctrl: Detect ABMC feature details
Date:   Thu, 30 Nov 2023 18:57:10 -0600
Message-ID: <20231201005720.235639-6-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e43324-1f87-48d1-5582-08dbf208823a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjjdN4VkFaGuDEweVxYu2KOsxdJLw7W/vmQ24teLEY1X4Fm57WOaAidQD+O2mpnbtKa2bWKo1AtVucRDFQjemQZ5ENSGS1DKMh2QBd+vGmfVEgx62H/eAdL0vaExk2oPD1DL0znD9TV3IuFC9gktMY/I5/ty+947LZnUSkV94OC7xIW5NxwZJtMe1du686Z/BzltgZW/0ZGpj+ErqX+iPXOgDASx1QCI9SE/vs2aILbYwFmwWZB/6aNDijQl3Nza81MRuRhr/HoFqD7YazBCxivsNve/jEiQTvjmEg4S8ADcKwgdSvoRp5g6mH/tbk2c+HWlKAO+MeRtANEmh0SkAoYTatnAbU/NVqWaEgC0BOBYaX240BCwXp8FlqzftDbRp1KkEqoIHE22JbIK2legEkftLSq1vX1mNIoXXrtAn57JibAgiMmngi03K1HTz4rIHt7wujATqF2rpv3IzpSEetDRdBQ+2jTVuFf1BNb4yAmJK53xsTz23n4gMBertHWh7CoHf01LVNjZWebscO1inm8jq+Tmzt8isBGmCBOpHeQTvhk7B7FiPnK5jYK3BzJq6NQag5HzSCW6VNOdEcBW2gnCAricXJ5txCodC5cpV98fb8VYBxZ6Xc94XLjavzCvt2l6BH3vuUPVg9/4Ufzpj2WpWWlOGi3+zD7OSA8z08P7ej988C88kNdR4Vy3hiug+qFbinarfwqPFjw0z4XO2L8NI1kCuqGuTYK7rgQUVD89bGFzTUKvBukDzOMfjZMipfbQVeOoqQ4PgQL9Ejnkeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(356005)(81166007)(40460700003)(36860700001)(82740400003)(47076005)(316002)(41300700001)(83380400001)(2616005)(110136005)(54906003)(7696005)(70206006)(6666004)(966005)(478600001)(336012)(36756003)(426003)(1076003)(7416002)(5660300002)(2906002)(70586007)(8676002)(8936002)(26005)(16526019)(44832011)(86362001)(4326008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:36.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e43324-1f87-48d1-5582-08dbf208823a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

Detect the feature details and update
/sys/fs/resctrl/info/L3_MON/mon_features.

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 Documentation/arch/x86/resctrl.rst     |  7 +++++++
 arch/x86/kernel/cpu/resctrl/core.c     | 17 +++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  3 +++
 include/linux/resctrl.h                |  2 ++
 5 files changed, 31 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d816ded93c22..1293cb6cba98 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -197,6 +197,13 @@ with the following files:
 			mbm_local_bytes
 			mbm_local_bytes_config
 
+		If the system supports Assignable Bandwidth Monitoring
+		Counters (ABMC), the output will have additional text.
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			abmc_capable
+
 "mbm_total_bytes_config", "mbm_local_bytes_config":
 	Read/write files containing the configuration for the mbm_total_bytes
 	and mbm_local_bytes events, respectively, when the Bandwidth
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a257017b4de5..278698a74c49 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -303,6 +303,17 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+static void rdt_get_abmc_cfg(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	u32 eax, ebx, ecx, edx;
+
+	r->abmc_capable = true;
+	/* Query CPUID_Fn80000020_EBX_x05 for number of ABMC counters */
+	cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+	hw_res->abmc_counters = (ebx & 0xFFFF) + 1;
+}
+
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
@@ -815,6 +826,12 @@ static __init bool get_rdt_alloc_resources(void)
 	if (get_slow_mem_config())
 		ret = true;
 
+	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		rdt_get_abmc_cfg(r);
+		ret = true;
+	}
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 524d8bec1439..0b22be85a444 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -388,6 +388,7 @@ struct rdt_parse_data {
  *			resctrl_arch_get_num_closid() to avoid confusion
  *			with struct resctrl_schema's property of the same name,
  *			which has been corrected for features like CDP.
+ * @abmc_countes:	Maximum number of ABMC counters supported
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -401,6 +402,7 @@ struct rdt_parse_data {
 struct rdt_hw_resource {
 	struct rdt_resource	r_resctrl;
 	u32			num_closid;
+	u32			abmc_counters;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6c22718dbaa2..feeb57ee7888 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1077,6 +1077,9 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 			seq_printf(seq, "%s_config\n", mevt->name);
 	}
 
+	if (r->abmc_capable)
+		seq_printf(seq, "abmc_capable\n");
+
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..656af479a19b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -162,6 +162,7 @@ struct resctrl_schema;
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
+ * @abmc_capable:	Does system capable of supporting ABMC feature?
  */
 struct rdt_resource {
 	int			rid;
@@ -182,6 +183,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
+	bool			abmc_capable;
 };
 
 /**
-- 
2.34.1

