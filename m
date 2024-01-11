Return-Path: <linux-kernel+bounces-24093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D082B6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE332851DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785E58220;
	Thu, 11 Jan 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gn7OgW2b"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8F5812A;
	Thu, 11 Jan 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn3kscq5Bfy7WNnS87noCPV5nAH0Rb8Ch1hm0oJrKgXeVAIkZsk+vPI4rWmm+cH5QuA79ui8W3MuCTFROHo1K/yufTsfk8/1itjltM9kmw641JDaRc/sNJ3Jj1iJAai3mStpHPmtU0gJcb3S5qIPymhvgzOuysii7NzTM52Z8RKfHQoobWSFD4wXFO4d7OFWXF32a+CqcHIa6BtA2gyV7fyVPUbFsmpDrGu2yTQZyfZaIdlyzKdT+REg1lnR5lCfx31N3MMsm7HyiLjWbsikDByweQy15Wj685e2m5jx9NDTSXuNZRrJqCDx0kOKp1qSrKnCRCRWw+OOM8J5O8L0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByRK3/v2QjK+3CcfLuPKIeaDk98K01bfUu/76lkRE3k=;
 b=ktN/dFSSiKt5bcKX2SQ1HGxQma4ZdLuEdxGkLGDwa7IVVaWwSPXIaSB3NJfeE1mvT+yTSI9j3zZ3CBPN6euePF1xpkc4iAdXkObHpSkQKZXClbenngioeQhhwHctViNUVdDbYmuMKULy3WHVo3qYVqooS3J3WSd5r57Ao5GV7y3gMiZ68nga1IJLoi/UzmUGHaxZbxdS/aj8o2EoQxb7wxY/VwQoSVDbaGfEmjQDuXQnUlhhP6BG2nrZpX55TvRZ5XZIDdgesZGnuA6BPiO6SK7ymOEe6PrqPsiWLOLlG96gH9sCRBgAshfubjDx8fDyQTexRwm1gwSUJpIhVLbGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByRK3/v2QjK+3CcfLuPKIeaDk98K01bfUu/76lkRE3k=;
 b=Gn7OgW2bd+xLQoZ9yxWCIejdXVz07hnvxC0DgANvBwH4U0AJ1Lyl94+CWo2ZYwG1gFRKv/qbKx758S0Wy2oy0mppNh+gvNZUxV9ITCPX5j6Dkt+HgPp9ayEVopF6QdJPfOGZSbZV5FdI/BtfFjMKT912OgCIIuEQDoJovyG+NIk=
Received: from SA0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:130::20)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 21:36:59 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::5f) by SA0PR13CA0015.outlook.office365.com
 (2603:10b6:806:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Thu, 11 Jan 2024 21:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 21:36:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 15:36:57 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<seanjc@google.com>, <kim.phillips@amd.com>, <babu.moger@amd.com>,
	<jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<jithu.joseph@intel.com>, <kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH v4 2/2] x86/resctrl: Read supported bandwidth sources using CPUID command
Date: Thu, 11 Jan 2024 15:36:43 -0600
Message-ID: <ba1305bf2a29ce2667d01cf997718126a7ea607b.1705009003.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 30870af5-722d-4b5b-61d1-08dc12ed70fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5tEdkuYJi3jE9LUQBXfjy0wPfxKuasQBnXVcDJ2eKvpCxKQVdOlw9Gu+U2q1IlhL1OuQz840Edf5PARookrROvFsqRYbfhXFQRCHb9YM0jZBi074at9qnjgAIIE5srG1tdg51ii84gacUbAdMZk8h+AqwUXrDayBfPpoU4miz0ezy+KOxTqQl4q2azNIhiROuv6UPzPApk6Vu2xfhdPfx/fRQ+RcPKqiPS0PRYCBqJsS6hoN8aVaUqRg3Bq70kyMUQPt7biPx5U2sHUBYkYLOLrB6WYc6yrfFMpO4M80Gog8QlIL3O/w8n/p5AgNCwjtVHEXgVLBzZywK+OitSNyrsNe/SVr1x+1Pr/6xbuqBPDD6Y6tC2hRYr/wqJdd2AhSYf2Zjrq7FFybVc84gvYeZHnj6u/Yaje4Cqbhia/cws0nZA/jU4N6Gv6gGh8MHlXMBc2OHFMNdQgHi8te5jpKflKnRBFEYcvWYZM3RnJf6F0W+6cAqlADkpgU6XlhxqCCrgIPQnBWCy1kA4HBwJOWDNIMkT0c0TgEePM88Cuah8utxGJIMeLnRGRh6T16O8M1tA6Gcw1LnNGmsCZaH+V67g0oHpVeU46TGu7h1SIoL3Who6I0G57YXMtYSQWfr3E7uLS055Y+OsHcz8RgOmTg4LBnU/ApgxAG/+mfGGKKYZ1R+F1Bv72i1D/Glzxh3QJ+b6PT04Ln9L+7B+/LCZJf3oyTS48+7KDRNmdbCvmLas+4kP90n2RAlYR9EaG5K5De9FfAOCHpJ38orxBqNQfRVK8VoJgN2NsrKDHMHgS6S8M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(70206006)(70586007)(36756003)(356005)(86362001)(81166007)(41300700001)(36860700001)(47076005)(2906002)(7416002)(82740400003)(26005)(16526019)(426003)(5660300002)(336012)(2616005)(7696005)(966005)(110136005)(478600001)(316002)(6666004)(8676002)(4326008)(8936002)(44832011)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 21:36:59.1345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30870af5-722d-4b5b-61d1-08dc12ed70fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured. The maximum supported
bandwidth bitmask can be determined by following CPUID command.

CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
Configuration] Read-only. Reset: 0000_007Fh.
Bits    Description
31:7    Reserved
 6:0    Identifies the bandwidth sources that can be tracked.

The bandwidth sources can change with the processor generations.
Read the supported bandwidth sources using the CPUID command.

While at it, move the mask checking to mon_config_write() before
iterating over all the domains. Also, print the valid bitmask when
the user tries to configure invalid event configuration value.

The CPUID details are documented in the PPR listed below [1].
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
11h B1 - 55901 Rev 0.25.

Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v4: Minor text changes and re-order of commit tags.
    Moved the mask check to mon_config_write() before iterating over all the
    domains.

v3: Changed the event_mask name to mbm_cfg_mask. Added comments about the field.
    Reverted the masking of event configuration to original code.
    Few minor comment changes.

v2: Earlier sent as a part of ABMC feature.
    https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
    But this is not related to ABMC. Sending it separate now.
    Removed the global resctrl_max_evt_bitmask. Added event_mask as part of
    the resource.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d2979748fae4..e3dc35a00a19 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -394,6 +394,8 @@ struct rdt_parse_data {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
+ *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -408,6 +410,7 @@ struct rdt_hw_resource {
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..acca577e2b06 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		return ret;
 
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* Detect list of bandwidth sources that can be tracked */
+		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
+		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
 			mbm_config_rftype_init("mbm_total_bytes_config");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..8e9c96d0ee84 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1620,12 +1620,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
 
-	/* mon_config cannot be more than the supported set of events */
-	if (val > MAX_EVT_CONFIG_BITS) {
-		rdt_last_cmd_puts("Invalid event configuration\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
@@ -1663,6 +1657,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
@@ -1686,6 +1681,13 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 		return -EINVAL;
 	}
 
+	/* mon_config cannot be more than the supported set of events */
+	if ((val & hw_res->mbm_cfg_mask) != val) {
+		rdt_last_cmd_printf("Invalid event configuration: The maximum valid "
+				    "bitmask is 0x%02x\n", hw_res->mbm_cfg_mask);
+		return -EINVAL;
+	}
+
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
-- 
2.34.1


