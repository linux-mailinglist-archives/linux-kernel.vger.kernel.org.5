Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBB80009D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjLAA5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjLAA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9092E10D9;
        Thu, 30 Nov 2023 16:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frzarBFro7sIuVopHkbUdnnEclxrRPIvuY4mbsQVHbmF4WwzYyO2vSiJRxhbdwRVhNMsvM2t2AHwUe6m/rWkUOqn4wbyjMElJOZKC/cioekDfcieXmmVbCPmrsMz085GPDV/+q8go32/jdYnN16IKAWYP5f/aeACsndirBYmlJJW7188dtoeXdNgC3aMA6U/71iTh5aL9w1WkzGI+SWoHK6rvZajp/v5rM9r9/zZSL3zUW60cufxHDm1ju+IIKhJSKn/1H4eggJbLk9zubdbpwcMyRbRV0eyZz8x9n6rXxghQR4wT3Ey+4Tz9CtobcGEAXIU5LXhx0Wcl5F+ukqVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la2DgueN8+QrJuE3/zzlx3+v8nRmRRBX/KEK2ifRm9I=;
 b=HG/0N19XYGvDMSkQNo70zHHWFh/Co2atSAq7NrXNCxmOgisEMQBMILDecznc0t7zLcrRlLnZwXwY+TTqfU+j71+TYK/Nb15w+ePZVbc0MtLY5hddHBOIPOHhizlYDe+yepAyEGCQZ8RIC2csbiEgwbROh6VxQql9bsFKZy/3ymOZvTp34TH/XhuP/enVOQd0tv/y9Do35ouITcUJOWVaZ96j4OEQ42OpDx4G1viAOB+EXiNrQ1ataLsMQEd04U9iz6ZMH4AXof8TOeonpyF2lxuDDzA0y5iGM+gXpiIoXds+JR3rTfJ5Vyivp8UsanjfZKDIrT873AHfOuVWEU9kFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la2DgueN8+QrJuE3/zzlx3+v8nRmRRBX/KEK2ifRm9I=;
 b=TRCNYe21M4kC+6lWIusr6YjDmsEpsJG8ompKgx+XqDwTTm3BPmmTjv4WUup9Mpe/ZunucRTnA2FX57BuNGQS+po3PaJdI0EFB0KZDnFpzwvhp82Mh3HQAxe9tgdP3CWoanmPSUrpYCDoMMzmEDq8+5q/bzluEKlHmyXKIvBL9rs=
Received: from PH8PR02CA0020.namprd02.prod.outlook.com (2603:10b6:510:2d0::9)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 00:57:33 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::89) by PH8PR02CA0020.outlook.office365.com
 (2603:10b6:510:2d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:33 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:31 -0600
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
Subject: [PATCH 03/15] x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date:   Thu, 30 Nov 2023 18:57:08 -0600
Message-ID: <20231201005720.235639-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fa0eae-ecba-4fda-8092-08dbf208806b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL9MI0jfOV/Gp7ZALM/OErKbGvCteBJ6zJVyeKw/5RQ7D4wuYgpa+2zBb5alFjP78wcesTKSOKPQ9QQy/YAh0EWuS5L/YjuaJfH1mtI6fmhiaT+sUTtOo78BlVP5l6/Wja9N91RmkyCnde+prLo48QmaBYJV1jfPheXzqfUvgdItLLtTafAamWi7QDEYfavaTJcL16LhC0JgAJj50MvFyFkB0GAP3oNxIwR1lf+thm9hTQVr+x7t0dDElmlHmihOMd+ZWkaviBfhVQFLySf8sulA7d1Sj2rgD8UtqxzLiM3h0E5FCpYishUkwUjIolECzPm0FihdMRMP0BGZAV+Fw2G2ympEv1N0HJkrBBGSDnmryg9kbcrIBzrCAJHcBfneFmu8RiaB9eASlSd6JRyZI9rYQ6dWpjBOJGEBDLNUeA34sQZJter7qtG8+3ceZMq8u/cxLheogUDdBv/y8CN/oETji/2Y5R8v/+GzdDA2pBclZ30I3A80v2lWtYR4yGmOIKIGY9JevG9chZ6SP+hwaOufhszxbGmJbEk3eWAZ7rxTCdrrzmCx7zUk74sTjztGujkK9gA0/9AhysmpHH2d7kiIiZak4esvxHzeKBRuGkRHy2KJuwbbjLxs3w+stApgCXbCPWJfqcBVkPM626vxbz2lRJTbDIbxSdbPg1Gicnw3eaKNcPB6gwQKXquEDXb6/E8yB1jFyRy9nNXWFtJ5pc4q+Rr2ID/JCyLn2Vp+7XKxPXIBGfddNHDb9f33psKT7PPqbnQisu+yv7U5iyhzeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(7416002)(44832011)(110136005)(70206006)(4326008)(70586007)(54906003)(478600001)(8936002)(316002)(41300700001)(7696005)(6666004)(966005)(5660300002)(8676002)(47076005)(2616005)(26005)(426003)(336012)(83380400001)(1076003)(16526019)(40480700001)(36860700001)(86362001)(40460700003)(81166007)(356005)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:33.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fa0eae-ecba-4fda-8092-08dbf208806b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
feature only guarantees that RMIDs currently assigned to a processor will
be tracked by hardware. The counters of any other RMIDs which are no longer
being tracked will be reset to zero. The MBM event counters return
"Unavailable" for the RMIDs that are not active.

Users can create 256 or more monitor groups. But there can be only limited
number of groups that can be give guaranteed monitoring numbers.  With ever
changing configurations there is no way to definitely know which of these
groups will be active for certain point of time. Users do not have the
option to monitor a group or set of groups for certain period of time
without worrying about RMID being reset in between.

The ABMC feature provides an option to the user to pin (or assign) the RMID
to the hardware counter and monitor the bandwidth for a longer duration.
The pinned RMID will be active until the user unpins (or unassigns) it.
There is no need to worry about counters being reset during this period.
Additionally, the user can specify a bitmask identifying the specific
bandwidth types from the given source to track with the counter.

Linux resctrl subsystem provides the interface to count maximum of two
memory bandwidth events per group, from a combination of available total
and local events. Keeping the current interface, users can assign a maximum
of 2 ABMC counters per group. User will also have the option to assign only
one counter to the group. If the system runs out of assignable counters,
kernel will display an error. Users need to unassign an already assigned
counter to make space for new assignments.

AMD hardware provides total of 32 ABMC counters when supported.

The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
Bits Description
5    ABMC (Assignable Bandwidth Monitoring Counters)

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 2 ++
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 149cc5d5c2ae..c9ff7e0b216f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
 #define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
 #define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
+#define X86_FEATURE_ABMC		(11*32+31) /* "" Assignable Bandwidth Monitoring Counters */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index e462c1d3800a..e4e71e46dfd8 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -70,6 +70,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_CQM_MBM_TOTAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_CQM_MBM_LOCAL   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a09b7a..698f2ccb9ac1 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -47,6 +47,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,		CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
-- 
2.34.1

