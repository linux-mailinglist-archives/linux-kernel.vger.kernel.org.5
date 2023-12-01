Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC0800097
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjLAA5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLAA52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:28 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AAA10D0;
        Thu, 30 Nov 2023 16:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC/PYRgDpUh1ATZmD1woiI0wtuOzqC+c5oM9BVUINeNkakOZgrbX+0C1llFBWaNfbshJAyg8edOgIl51+79VagNRa8ttGxJ57kKX+TrHiXHu45oXnYPc9kTy4r+UlO+2wU3+5ViKZVy9pTJh+ISH/ode79vjhhL0M7ub1z6CAx0AWdXoPiqUucUuAGpxkH2yo41nMawjE34c2cvYRVnNlaZMl6kj92OkXoZit9FbWtHbKGXFd0SiQuac9puqCU1Jib5NFVcy5GMZaAGJd2fZqcafHryn8yA0jQg0vgLnYIZGtF78WL7RYtZ2mkaNEtcncE0y5XDJISamvvru2Kb9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij5nxfaLbQrlAUaygYQ3EJ4xiQdrxJbJ26ht4rfXkVg=;
 b=l9C0hjBamyM/MfSzuaTIEYbMUkaf8FrWfQuMCuDb5qBpEedGBRIDdCuCP6BHw/F+umfBi51GDw8qmZY5sa6npyMURGGCobJYn5y1flqvPjc/P7imCgG0bJQvkQPuzDi8ujuGOAmsCQjBUR4ZKhF/Ahs9cWr183QWklZN8X1pPvY5mWYsGZ4Us08w8UzEU3MLSpaPBNqQaF0m2PERTjGljxcgz+/cbHYIeCWS+9wC3HOHzPVllFGOKRGLkWXcP9t8ovHQDvD6ZF04/UOmjffmbzg0VzY5kcNWU49hYs5JjMCqKAUh6U/v0VG9E9Jkor+PpeN6mfjPy9QPxhI+udJEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij5nxfaLbQrlAUaygYQ3EJ4xiQdrxJbJ26ht4rfXkVg=;
 b=rTDRLa0XShq4mFW4TAJF7XA4eYBRB8WLOQ/JLOjsCuVnh36g61SBYnl/ZEt3p0brNzgGM433oYh+MQWbcCJef6zy/YFATKhSLesvWf1dOPMHbce18kl/qDbLjjWtoRSpX1g0wloZ+EYhsziJ/DfccOCG0Xz965pJWQKn/88y3xU=
Received: from PH8PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:2d0::8)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:31 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::70) by PH8PR02CA0018.outlook.office365.com
 (2603:10b6:510:2d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:28 -0600
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
Subject: [PATCH 01/15] x86/resctrl: Remove hard-coded memory bandwidth limit
Date:   Thu, 30 Nov 2023 18:57:06 -0600
Message-ID: <20231201005720.235639-2-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: c427b9f2-90ed-4fb5-fa54-08dbf2087e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xq2gKkWdkxdTD4qJnM5gA1MK9qj2oqoqQuGyG75Z3U5vjRV8Egm25S+vpCd5R2LnOZRGpr+p4d5+EGI+8Y05IYtlYLMH7tAkjcQGMu90AccfMuHwLwVYm1E/5RnpTGxFAt9DvlqtneSgJ59FtxpiKoy6op/9b/kyGPK8wEFBANrX/Xk28Hk0XWiWcVx5dn5Q5EPJIF1m3YDjzBytvKVBB+bU2rc/btwrWLe5ksUPKPhd654LT3bDxrqYLV8+xFSuTa6BUgCXo4nxIlkJl7mbhp+TjmnDeDOU2B6XlKlhQrD/P2XvlmLCcmppu1ELQRp1Y9uT865VBdGATtp5TjMrHcUZQHCgNcaD3rdt1h7G5h+aa0eBJOEMqxYHdU295a5oeVcgmZWwWaXbNShFwSxQApVq0wUoYFJVVfKelbkwYGWNB3pdYgv9KPRGYWoqF7Dvgnru/G8Z72Zh6U2mYtcBOKantLZNIBmdJCJqvHH/X5xXdrwSnvqkx6UnTVw2Fge0nIiIgro4+A9BDyzFcgfbRZO2aL3rX0Bc3xCfH0/n5uU4qW0EPRy09l97h7oguA6LILJfFVvW6ZF2wxZ5gvSEoJVZd0xJzbfxN2kyF1s4lcraUFtUXM2t9OX3xfkpGMlDAQEGzBRa4kxhqxf+rE6LPq3TlcUahxfDaILF4Lyrj0EHGu+CY35up/34OT052LdjA3dsOLu9xM4CwzixYYGyAFes4Rskgbup4kh5UBe9tLn3fKYCetF7yqiBpVXe3tdi5SIIya6f1q4iF+jiWmqLdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(356005)(426003)(336012)(110136005)(81166007)(316002)(36756003)(70206006)(70586007)(4326008)(1076003)(8936002)(8676002)(40460700003)(16526019)(26005)(54906003)(2616005)(966005)(478600001)(7696005)(82740400003)(6666004)(7416002)(5660300002)(2906002)(47076005)(40480700001)(36860700001)(86362001)(44832011)(83380400001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:29.8277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c427b9f2-90ed-4fb5-fa54-08dbf2087e7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QOS Memory Bandwidth Enforcement Limit is reported by
CPUID_Fn80000020_EAX_x01.
Bits Description
31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.

Remove the hardcoded bandwidth limit value and detect using CPUID command.

The CPUID details are documentation in the PPR listed below [1].
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
11h B1 - 55901 Rev 0.25.

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..3fbae10b662d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -243,7 +243,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
-	r->default_ctrl = MAX_MBA_BW_AMD;
+	r->default_ctrl = 1 << eax.full;
 
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

