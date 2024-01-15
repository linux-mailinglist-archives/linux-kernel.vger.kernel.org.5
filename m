Return-Path: <linux-kernel+bounces-26524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B498182E2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3140AB2218F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982641B802;
	Mon, 15 Jan 2024 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zFHUSuiF"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FE1B7E0;
	Mon, 15 Jan 2024 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykzc9y8xw/f3u3Sud4JwYfQY1krkx8J6uP/vndKT9uZ9JFrev37mtC0wby5EumfVAC9EcPbCa5sOKyhRaStnnjyzgXU6gfNNJ/kTQjVc2PbluUt4Bn55tgWq1muqBVnqLYs6wjtMpMl5Of+OuRN3B+wEzB24rQavsfjNFw8biumhzOWIU8hD8zwwYf+ecsKofmLfheTvimfdfaQJOpfwPgJp7f8gbhkNTivaHmGKlsAemdSLzxiOgAiIs1GECgl3p/iFmHlw7sz2QyRY6QY+ogbgbx50Rm0cMe2EhXUs5doemmi+6yjjMCKSYUsIRRzCm8N+fibZFtHKEPC5m+7cXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gev5sQ1aLWAuQpiBQ8AY6LcTNAzx/mZ5pZ6jLyaBLzc=;
 b=d/jDbM+KTXgFYrCvG4HcNbN2btcfgn98wNNAzhe8d78V6PVc9denTekQfElsoGs9rhkSGuUzcAdQzn07/1i81m7JZpqYyz5groRGekSbcOpHMrMDV+PlmprFb6Z/SwHWqgDbtPoqiz+7ncF4gZc2Uy8Z5/SQC1NGkPxRFfVuuBhLBujuCtWtNjFqoqURz6kex4BxfPmpO25kou2BNIf+3laHMeufjz9DWXeUTLMwPjgOIqbK5pLzIGWXrJX8EY8tp/47l08vil8uzasOZYVuhvgyTWltjsLAouSAYTxczNBrSpsSCXkz5jXKrYxu3arAqotSQcYNleAkGdhSB6A/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gev5sQ1aLWAuQpiBQ8AY6LcTNAzx/mZ5pZ6jLyaBLzc=;
 b=zFHUSuiFogtgHn9d5VkFdNST+Bv21vljGSv0R1Exb0rwFu3tpwhliEy7/YWJ3qXJgVmL8SrojtfYPSicfK8q2DjhJua5GX21uT7gVq4fFs7iyvjR4Roh0UtNDd4Bb7WT5Mwyc31ppZ+3VVeWJKShfVU3nO7IBNTN1dyRdIuGbtU=
Received: from SN4PR0501CA0062.namprd05.prod.outlook.com
 (2603:10b6:803:41::39) by DS0PR12MB6488.namprd12.prod.outlook.com
 (2603:10b6:8:c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 22:52:53 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:803:41:cafe::a0) by SN4PR0501CA0062.outlook.office365.com
 (2603:10b6:803:41::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15 via Frontend
 Transport; Mon, 15 Jan 2024 22:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:52:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:52:50 -0600
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
Subject: [PATCH v5 2/2] x86/resctrl: Read supported bandwidth sources using CPUID command
Date: Mon, 15 Jan 2024 16:52:28 -0600
Message-ID: <669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 14630462-b43c-4552-33f0-08dc161cb43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8UQwFcJhj+I/F8RoHzd1NHXRx/MmbE+3niGKQXUyhZ0dIbFCYBzuAqF+1VCzv4ua9t44gC9mbNanN0/C+tBorSujM7H//zrwFdrlVtWeJWdb3sgIplw6jxrPA0t1PMaIj7SgmVQXSXTxpKl3FxNHQD0W0yn7TyF9NMa5Lc/bBcwtxFoEjkPquuLvB8bu6VDnzRiaSCZ3d/6RnFzpkFBfqVqtghQFfWJPtf6NOAV+klc3xcdUJ8vvGj7rGxmT3o1YsQz5vYepX42+w34DAESRNbhqgA8Wjd5pPLU7TnFAzLB5Sas7uFI1juNT1ix0AhBVM4l7RxalEv93EF/YOhgW+FESAuzHm5wUc7IBSm5bkXeV+o4Ldpcuw1FR+UKjnlx4GGelBvsCeq3zg8Cq8VyPckOYaGTyrE0wh1ye+k8w5wBRw/3VmyYmTQF3ew+pKhG1KwBuiU5h7F8/FaWBuflg+5ex9VPJ3dOpDy0QelhpMi5f8HinkqMhPomxPR/vB3i18wk7EyrK8tPMaQPpssurWbzbjKlzRfpCxiWKT4/XrklM1e/JVuAX1wkkrWpPtxAM+0438+Ki64XElcIK2rXM1aWow8C6N81y/idqsBHZS1HkVNfCaIrG8YtQ7aJbtG5b5ryoKvbdgmGJgQ23r/bsMnVcUpO+GLzCHE6F8EI7EqDZHymabk2nrxqjNKrYsQ5APEVIcKOo3zaHji4PDJNDRDgXWiQPLAJar3LqQo7+fWELdKWbRJnDsgzNnTcRHjY9jnw1We1kGKqkOokIfMpxgW2xEoPrvBXTBFp/e3ZQzKU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(26005)(7696005)(82740400003)(6666004)(16526019)(478600001)(426003)(336012)(36860700001)(966005)(47076005)(83380400001)(5660300002)(44832011)(2906002)(7416002)(41300700001)(4326008)(110136005)(70586007)(8936002)(316002)(54906003)(70206006)(8676002)(356005)(86362001)(36756003)(81166007)(2616005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:52:51.8013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14630462-b43c-4552-33f0-08dc161cb43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488

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
v5: Revised the text in mon_config_write when user tries invalid config.
    Few other comment update.

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
index 69a1de92384a..2b69e560b05f 100644
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
 
+	/* Value from user cannot be more than the supported set of events */
+	if ((val & hw_res->mbm_cfg_mask) != val) {
+		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
+				    hw_res->mbm_cfg_mask);
+		return -EINVAL;
+	}
+
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
-- 
2.34.1


