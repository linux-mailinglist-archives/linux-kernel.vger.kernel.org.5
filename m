Return-Path: <linux-kernel+bounces-17232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF4C824A37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932B31C21125
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF692C847;
	Thu,  4 Jan 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+BGjjrk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DE2C6A1;
	Thu,  4 Jan 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZJHPkttlxgK4O1ggtHp5tLNIzhIWtfqV6a3OgqE+hTU5VY6EZiyXW9jBLxPGqgscwq4OEDHhNnhM3Vt9scDL1v0zOi09/4t6xFd6Q85GQ8aVQf0qtGmogZmsAIqWtY+1vWz4hAuwQmTncNsccNqIQF6BoiV03/Xt75lnrrVtlwBIP7MTahQ0GQzxln5vds6QBU5xtk4G8Fuf0puw2OB0jrQb8tqoppVzorJetwnw+a86k9sxwIb0lv4oBCgBqJTWxKIk1b3MMvxNhmbxN7ZqWvm6PrRpwlb9waHNJ5G63536uYwWFDRq7EQUaLEhTgAV9G4HMA+hPhN5i4g3SmJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae1ceTfT/hlF1QAxyZJzYvZFbxUi27m5LFpwmBzJxHI=;
 b=VYXCKRo3dVWr6tHoamyXhM7TsVB3YUBLsMWGoTdnpKZ5bzvT+YmE6bRHw/waCMhVRUfxNk+mCub2eoYBN1yePLlbI5sbWAhuo2RUZOwu9JZP5BmfNy6doLEsRgvRI591wbIbxyOKoMFr7dvfe65gxEf8j5TZ5G1djpxkvP23ssxAUZyAHHme/i9qlmsPaAWdJFv6iZuGWM4DTXpMUTX1htRehP2FeuZPR6JIS+dNktClbK3NM6B595CmwNRtDOF7BkbdgW45IrPX0bYXTjIPmLalQUWdeI2hHDvOFtfnAoJjM3ZUAXDaiWaaO+VvBU6G4vqXKSh1YkEQa0d2grgudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae1ceTfT/hlF1QAxyZJzYvZFbxUi27m5LFpwmBzJxHI=;
 b=l+BGjjrkWWOqWG51nsvLTTykvYE8/xo2P4SqSAMTNPIolVls+E4D05pjFGXQOKP/SBbZh35ebKXnbeXmbyw70ctYUiI0OgwOpnZR9Prhjd6biX6OmiMLsB27tGhPECQrH2hFPwvGJUXJv0wvm64paBix4/U0rfIPnDVNjWI6W3c=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 21:22:31 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::ea) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 21:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 21:22:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 15:22:22 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <seanjc@google.com>, <kim.phillips@amd.com>,
	<jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<jithu.joseph@intel.com>, <kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH v3 2/2] x86/resctrl: Remove hard-coded memory bandwidth event configuration
Date: Thu, 4 Jan 2024 15:21:30 -0600
Message-ID: <20240104212130.209490-2-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dab9b8-a66b-4951-7709-08dc0d6b429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qFN5vhK2ZVbs6aLfqYlBZ6H9UkpJ6m6o0Jr19i6KVM826MVEl/lDr1SUpWAYSJboNQRNDlZO61OSI498mW49vMWpxsvdOiVWcU9ltxxn7wj7OkuBed08ypByC/pyrqMGZEHB8JbZmFJ4KFgYXyXdIDIM4ZgcBXehPVKRU7if8u1v/sZkrC6kKDqahysZID4+iMpGikw97Lw7unh2Mda7jIjoYEkM8gByL4pd/qQk5va7K5t7yYiVMckO+y6il5hv6rJhcsA565pCO7kjUvwu0FeGmfZRloq5HT0U1MkM0sjtQHiLfSkpKtnWHkebE2G+1oO6TClwuysxlM8JCw+2zNCaLyZMN7jcs80zvacyo9PcCgDgDYKu/+SGnNfO+a8EaxsSqP128Fixfo6cNLeumfhoOVvjhkTQhf15Kv6EFkQMuRe3bzyUrLI7Ep4IJoln/ecAU5hmmrvChg1TjYmjN1NWSes4Qxz+BjzJ+FaWAWhJnqWCUjx65rK3St/hf0af3pycVfBpSX4Uv2ixtNCPub4NBp2fFaHbaoi3QY4OwF/wFWxtW720B4Wu97wdL70A2bBBclpEiMJ1dEnk8iSsw0IOYHXYA1ZZ2w5j7DspECYQpa9ZBkFbjDXZJCLUO+rDsfqrafaAWJKIXNIQImUZcj0QfrXqbo4v5Qc1F6xCl61x2FdR0KG2TFgDRbqz22RHlbsS0L+jrUtJrw0ns+ImKzWfBnMxZ4OsMOmJ4SeBRp414aPWyQbIV1d+Hli0uBTf/wIXo+84bCFb/CivGKEV7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(966005)(47076005)(8676002)(478600001)(316002)(4326008)(70206006)(2616005)(83380400001)(70586007)(36860700001)(110136005)(54906003)(6666004)(7696005)(1076003)(26005)(16526019)(44832011)(7416002)(2906002)(41300700001)(5660300002)(336012)(426003)(36756003)(82740400003)(356005)(81166007)(40480700001)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 21:22:30.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dab9b8-a66b-4951-7709-08dc0d6b429c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured. The maximum supported
bandwidth bitmask can be determined by following CPUID command.

CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
Configuration] Read-only. Reset: 0000_007Fh.
Bits    Description
31:7    Reserved
 6:0    Identifies the bandwidth sources that can be tracked.

The bandwidth sources can change with the processor generations.
Remove the hard-coded value and detect using CPUID command. Also,
print the valid bitmask when the user tries to configure invalid value.

The CPUID details are documentation in the PPR listed below [1].
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
11h B1 - 55901 Rev 0.25.

Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: Changed the event_mask name to mbm_cfg_mask. Added comments about the field.
    Reverted the masking of event configuration to original code.
    Few minor comment changes.

v2: Earlier sent as a part of ABMC feature.
    https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
    But this is not related to ABMC. Sending it separate now.
    Removed the global resctrl_max_evt_bitmask. Added event_mask as part of
    the resource.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 6 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

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
index 69a1de92384a..5b5a8f0ffb2f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1617,12 +1617,14 @@ static void mon_event_config_write(void *info)
 static int mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
 
 	/* mon_config cannot be more than the supported set of events */
-	if (val > MAX_EVT_CONFIG_BITS) {
-		rdt_last_cmd_puts("Invalid event configuration\n");
+	if ((val & hw_res->mbm_cfg_mask) != val) {
+		rdt_last_cmd_printf("Invalid input: The maximum valid bitmask is 0x%02x\n",
+				    hw_res->mbm_cfg_mask);
 		return -EINVAL;
 	}
 
-- 
2.34.1


