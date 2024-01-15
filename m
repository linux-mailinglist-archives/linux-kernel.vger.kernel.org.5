Return-Path: <linux-kernel+bounces-26523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401782E2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6757AB2221A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3A1B7E8;
	Mon, 15 Jan 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wps0UqRW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322D1B7E0;
	Mon, 15 Jan 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShfTrGWhVwnV3lZgjweUsP37bF4vFc9Syr8ZnHBmWFS4fw5pWRvQPpQtnDvEru9jHnV/9dZkAmRg33gsZa+CRT/HBR06dnHR/kaClWU8EpiGgqJ+Vy6WO2Igo6U0fYfwR5Y2uARmBUYhN8769YbhREMvS05xttWqxA2RRmeKTQSpXYpjRWsyFlkFqphZwJt1HfDN9zOITluM3yYleL0ax2C6Nz9NsHIMLvrkvnkqvZxj29W9uCAFggXzypyvReQKFa/flJ9OFNvB8KB+IYlwXxkhJ06UNJt480J9X2HswQWMlfRLgZhme+9RzrMFWgDwbjw6uloArk8yQg1t1WYpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6HdITWySLMK7+lq8N18uwiSxuYrxpF+PLKl3ahDomM=;
 b=k/R3CH2NYamns/9m857+4gXz/OD44OAgPOaBCT/BqvILxJzI02036fweiEb8YaOcbLMrmCJ+wv8xKDzSxbM/kRq3O+7PKfUQv5JXEft9UL+I0mGTDSs4jMQaSkd2uK91dMFhPlnfFNzVGS3wPtV5UHV1NfXP0X2Tg7+7uGZwvgVh+WtNiGcn8mzc3YPU1qKZR7hGYgh3LRC7tvayafSzvSE7PvP0JH/JTogdA/pMH71fL6Ad6Bt3IiDCYznoR5BstpiG0m54xrvmK/nDUxUV/CRPYtjSACZoGZhDahvrpWckisN5D/8YHYqmxBSn1U17/SEekW+VqhoJbD3apREMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6HdITWySLMK7+lq8N18uwiSxuYrxpF+PLKl3ahDomM=;
 b=wps0UqRWNWizP72vZ87Z7N+Jvg2DhRePBj4+BExC1D7EM+EakBJwDtTUh9NHhbv2hrFR7kXoVyLF2SxhaP5t/Die8VIf0LTOgSvpdIxNre7OKN8riq+8ZRdvED8ge33uXBv6ymQ9lmNvlf7yM7XxG8rXSrA8/DXpVg4lAW4gIOo=
Received: from SN7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::14)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 22:52:43 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::d1) by SN7P222CA0002.outlook.office365.com
 (2603:10b6:806:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 22:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:52:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:52:41 -0600
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
Subject: [PATCH v5 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
Date: Mon, 15 Jan 2024 16:52:27 -0600
Message-ID: <c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ea1f0d-2ae4-4c0b-517c-08dc161caf57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WXItU872YqD+uybYw/igxX1O+G2DvpN71ZNWqOvOfSCGCBIOnbUBXAzjiV9DkWJl/HXUiRKgR+SiUHU1nzxpFoGzrexlmUHo04MkkGyREByGsB91q1OnYOPkSFgnt04cdpyXnS/MiHOYqkhqHH8hTPX5/kCwaZailohDTSvCzIsVWtF89gbpMpMweNCsyuS6ssefufXP5vHMzRLor2GFYoKtKpLB7XKFPMYt2qUJK/499ZpKbp+m6b7FBmnoqcFLdf7Z+Hvv2kHZ8vCXkKm4YChoyqhDD3iCx0WvBdU5ma898VDHfbPxXMOVP4jMSSJwAuMZn/XJt0yisk4I65PoHsrAmsLKToDl44IlmG5i24f4kNgZ1ePnWZbsEccYcPIa0HvRagbb35Od6kIQ9vdDlhzgWgoXUTZvBxeMxrX3c7l2J8TST17Vb/Z+nEbHmoN/AzsRNCeqT+HX/M7X2GhV7YxQdVBpkWp3PjJ3zeFy7lggXMhCJU/qOxJhw0NNCZxC8Myz7grimmM6bbdRSQcnRlnTkwS1QtWWhXWxw7Iy91MZXt4WfYBuav5CfZVNGp4Hkilk+NH7YZAVZTM8vYPL4XdzedY+9KftJHhMG0Z/nmfJE7KlnKsiRdnO0BIc8PycKFLz9NU9zYzUNvl/WvBy/P9CsPn7eUBkH/SXFrveAB/KWorknvsAl/nGE3FDSRWDDp7vsIuNrIqZoPnKRTRQE30lznfmpAzeTBKG4YZ9WDUHE5AefdoW4GkFW2Q212YBMFQQskPg+6c9VuovmdxU3RPs0ZsS+XvczUhqjzLIZvA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(426003)(336012)(356005)(6666004)(16526019)(26005)(2616005)(966005)(7696005)(478600001)(36860700001)(83380400001)(4326008)(5660300002)(2906002)(44832011)(47076005)(70586007)(110136005)(316002)(54906003)(7416002)(8936002)(70206006)(8676002)(82740400003)(81166007)(86362001)(36756003)(41300700001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:52:43.5773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ea1f0d-2ae4-4c0b-517c-08dc161caf57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

The QOS Memory Bandwidth Enforcement Limit is reported by
CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.
Bits Description
31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.

Newer processors can support higher bandwidth limit than the current
hard-coded value. Remove the hard-coded value and detect using CPUID
command. Also update the register variables eax and edx to match the
AMD CPUID definition.

The CPUID details are documented in the PPR listed below [1].
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
11h B1 - 55901 Rev 0.25.

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v5: No changes.
v4: Minor text changes and re-order of commit tags.
v3: No change. Just updated with Reviewed-by

v2: Earlier Sent as a part of ABMC feature.
    https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
    Sending it separate now. Addressed comments from Reinette about registers
    being used from Intel definition. Also updated commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 ++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..d04371e851b4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -231,9 +231,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	union cpuid_0x10_3_eax eax;
-	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx, subleaf;
+	u32 eax, ebx, ecx, edx, subleaf;
 
 	/*
 	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
@@ -241,9 +239,9 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	 */
 	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
 
-	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
-	hw_res->num_closid = edx.split.cos_max + 1;
-	r->default_ctrl = MAX_MBA_BW_AMD;
+	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
+	hw_res->num_closid = edx + 1;
+	r->default_ctrl = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..d2979748fae4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -18,7 +18,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
-- 
2.34.1


