Return-Path: <linux-kernel+bounces-24092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3C82B6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31041F24C42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB465813D;
	Thu, 11 Jan 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJTHKdv/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010975812A;
	Thu, 11 Jan 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcNHeXyWsCeuK8QU1ynNgYqRNJDELOULotpgcEtBnMfm64zn5qHwc+lR8By0jATnkHMkPkH4O4iWH46IkDY9ZMiM8kg57B0zN6A1hB89UuYnmI9IDfPEHaxRFGuIFS3J8I3Ai3h1KPBa59JTFKWeJPEkEAdGQU8vAgr6TPh/BBRKoM/LFy7UW15S5qRKz9NB57YHPrc5Oq0iZ/lgn4ZEH7MJSjMFzDvkGIRzcK0jAL5b3GB7kvD3rGlRMiit4TSEXjAcINM0LZyhSANOld+sIOLdlUtXM/CYgyfZo5Po9nZ20FcSJGrkn43PGPPKkmh7J+cOjStMWxJKnoanumolQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUGBdvFRJoKNunvDpVhX3b2OSKK0vcwR0PcHsj2STP0=;
 b=DTYGX+ok8UVi+tKholdq+BgjaxR/u3z8GDRe6rpXZH0fE1aEADdhV0QvATfpSefYJ1BsbWTZMoMs3AvzL8uzVzE+eatpM8REQ+pbjQJDBnngJ0csRM2gihMWpk+8npwqSxksGUw22TgpUbvXfX6BXZdPE1ygeA063cjzEdPM/VLOKfpr5wcPNkW1+fZElgNtpSoADBqRRfObHutsezsi/c8Jve5Xf3lzy8AR8VloagdaxUDZMF0jg2gk5IBiBpEzjzydxsjKVN+qJ/PEmI3ubGQ07Z2wj9Wi6FuCuYBFRhMgyl/JP88Ja0JMPEPJvUxBsCnQvETOuLlGclpk/TdPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUGBdvFRJoKNunvDpVhX3b2OSKK0vcwR0PcHsj2STP0=;
 b=DJTHKdv/n9EJEwgGdSbtiGmQ6+vMaiEmlL9PPe0pof1RYj0mBxI5evor4yCUZTilc4ovHtr2uFjZ+b1IqRCSbinOpnn3SD3RMLB8D+a9V23ptGipuV73Xr3bfq3BB/nnympQwuaa5cwFfVZOXrwvS4+FN17H0/RaRlEBLvxxau0=
Received: from SN7PR04CA0209.namprd04.prod.outlook.com (2603:10b6:806:126::34)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 21:36:51 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::ba) by SN7PR04CA0209.outlook.office365.com
 (2603:10b6:806:126::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Thu, 11 Jan 2024 21:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 21:36:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 15:36:49 -0600
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
Subject: [PATCH v4 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
Date: Thu, 11 Jan 2024 15:36:42 -0600
Message-ID: <17c7637800df96101aace53b2013eea6d67c97b4.1705009003.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 050e7f43-421e-4550-47d6-08dc12ed6c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O4TpIy3XpkH7G7AUSxiRiiCxL2jEVxrZKm+ViBvZWPXvVvrS0O6FtZNZlYxqDlKEd4sJFhCvMG+u3drHp6gA3TdQClCicsXxfc27aPCRatsOdcs6hDY0gIEsbz/JSmjI4mNr2BDLAzJ/KkvaOJZytvt1bcxwxbmqv/OV/S2huMbHRXa/XKlP6s4xpNDcK9hPa/CUnArwPN1SuZx/b6awySEJKCudGv12q/mmd44JXtpMmXi1C/+gS5T13Ws0KJVM3npaTsoZ7+yLQQ5+HFZCyP10YPGHU+j/LwmnDgWMZMzfLQ0MHpsFSGqehq43HI/jo/G6Pf2mn/AugyKONKeBmLL3lDG+D7bP1QFLFqYfdFP7L/pyZ9awiz8nfww7SPuhU10hcbEgfUBGk1qO6hJKx+18L+lzz4wg8MTU7v3VfXe+KRt/xaHP/E69s9FgWVwnYhW5Tc3ktJK6TRSykCLd6oV5BHKYfL4qgJ1ytZFrfoAb2A8oh73yIpy8sKKB4knY8eUYgGCwS0ck+aMZmD/LatMPcR6DZDYpDb4lG5T7R+GqDwGngOQFJtfoGMkpnB7BQ78bQwKKS25zZpTjuVsiupkWcsOZrw2He1hsXL8cF2lhQPB0udx4+39OtnSQ9XVFFQK02w1nr8Yvlw6vzQ1+bpKa1ZyoBzgp8vo0v6vCugE40sMr4eUxaXSQbD0SuG+3Azb9sPgV9/GAx9F6xNzcIeORBjzKxH8cdc+H67wRwGiKafXOYQTblbeQfcCt9AjqLder1+zMORLu39vJAU0B4QrDkR/M1jB5Aeuyxv1UmQE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(16526019)(336012)(426003)(26005)(2616005)(82740400003)(36860700001)(47076005)(4326008)(44832011)(8676002)(5660300002)(7416002)(7696005)(966005)(110136005)(2906002)(6666004)(8936002)(478600001)(54906003)(316002)(70206006)(41300700001)(356005)(36756003)(81166007)(70586007)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 21:36:50.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050e7f43-421e-4550-47d6-08dc12ed6c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

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


