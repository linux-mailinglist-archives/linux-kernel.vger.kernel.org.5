Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3D7D3B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjJWQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjJWQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:00:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C7A10CE;
        Mon, 23 Oct 2023 09:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNImvanLO0qxGbjH8Kd33O1XjYwm3JdJlJSFAD6oSluc6SFKcWUymAOjM7yNclPRmoLMfkOk0fBHDSOB0ImxmoxgH0ei0Om/IcTtSjV7zY4kQLtYw2AfHPEMfUpKQTno3kpX7sYC/Gf1QJzqzTfpTHjwDGILsT8oR6DD6sfrnL+V+W/RFprrqd4HdOXUmxjwwLyGCp0uS6EPfEcUMSi4lGX72vBPFJwYYtYHFRahae/nPTtWbnh11x3Ddd/2/Lakr6jA9nfor6mlNIcRNwegd3Z6pzrO6tEy8TvgxoB80fMh7LXIBdg2GUdh1dDTY0thjYSph9nPTMZ+tto5ebOC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKGFI9WAFHD1NPV4Sa6NtwmLcbGvgny4Osn9ZHfBueE=;
 b=EaMMTGCIT5VWgExFGjGx+Glo4cGVcb0eKu3NnVYHEDO2mj55cra4jfOMXMIIRta8o7BHwNqtQ6BVPNbXB7g4oblIOYLr0i73H4U9x1CIA2aCKk0zLcpgcwggnwlhRBdy1/nRyb2DagSvidIQcIkxxBsYs6Ln3TlFuJ6kgX2xKxUSQT+qCEx8JqvSf30f1Fk0gK9S5xgPseE3QxHJ87zf00cTTHVt1s2WN9JEDKsXQag8XUHuYs8uYaH/HIgwFhYyJ+b9a4WoASibelwzSl6VBHI9oyQzgSotJTs8kIldK0Ccf9rHAdvWLS3TzMIp7F9IL3BebXIEHnvHKfCVGO/nDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKGFI9WAFHD1NPV4Sa6NtwmLcbGvgny4Osn9ZHfBueE=;
 b=yR+VTIEAO3328sUvaxboJ6MVj1kx0to7BvBea/Y7bED31+9JQam5cMB5UxpeekAaBxbFWwjYPKL71jrC9hNKmg9Y+1Ytyi7wpUd4TS1ELml41zhXduLKOEWNPmNwwdZ0IBUM+/p/Ya4T+o5kVBzHJQEeHz80fZdtj7EwENRtXrQ=
Received: from CYZPR20CA0003.namprd20.prod.outlook.com (2603:10b6:930:a2::23)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 16:00:39 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::29) by CYZPR20CA0003.outlook.office365.com
 (2603:10b6:930:a2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 16:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 16:00:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 11:00:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <rafael@kernel.org>, <pavel@ucw.cz>,
        <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] x86: Enable x2apic during resume from suspend if used previously
Date:   Mon, 23 Oct 2023 11:00:17 -0500
Message-ID: <20231023160018.164054-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023160018.164054-1-mario.limonciello@amd.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: e01b70fa-002b-4ec0-def6-08dbd3e133cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBLjBHI5BGOdKvZXdg8Gi5EUBXxT3H3FIKxvWkfhYraoXopTCEDrEnS3/6aLULEt6rG9zroJcugVofirMG0VS7uO71tbho6RmpxpcgQgNRr9P2d+dl/MJ/rsqV9zMUwgmLt9PI/vxnwfqeirSzfYvfKww+5Cxg94fe/O5i8Tqv92+hK6Y9kBbxJOca+PvBwhQnYbJbIZDnWfPohHvzjiT1LA/tlp/ptC/hiSfNVcgoKZyUxJvpxqgx2qzRYDVe/wsWhIQeenBHeUzt7AGsdL9wZz1WGNx72eREGszToqrxjth7dtrmgZPEPw44FTuB0oNr69vhOXNnBSnV7MPiwKWr3lOGV7o0sB/A1Yl0SgCexd8U5V7V+jHMvIH36nkjdSiJnZ92eM35P1CA45vbhh8ytBG+U5A54r8cBJJxiNhInVuZNw1qtdItSKdzBQIkPkV7PXQbeJSpA4tNOnPSUs1rPuGZcD8o7wcQTtWI92sHjuAaoczvdwTir9akluWAZxMOgcgGMRqvBpvxrJDIbbxtO2opm0RQiNnAd5xa05AS5j5l3XNAyfjF43Ff0lF5I5U/qG8EKPudDQaI2qGOZoHeDXjPQ+OP3gFgvn3UF2Lze4z8WGlCUftgNfRZbaZCuSshudbiOhaU1TZmun2FTZUNP/WfY8X1/VzwQng8sEcrzgfLhBVug9jxuyzsOkf9WDZK5ui/WV3aVbiJclQNxhtRq1H30npcdM93DSjUY+2m7odn5WkBHj2uH//mLdJQk4YN8bjklfSyyP8ZSaL+gGWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(26005)(2906002)(41300700001)(36860700001)(44832011)(40460700003)(86362001)(7416002)(36756003)(5660300002)(8676002)(8936002)(4326008)(15650500001)(2616005)(478600001)(7696005)(16526019)(1076003)(81166007)(110136005)(54906003)(356005)(70586007)(82740400003)(316002)(70206006)(83380400001)(6666004)(336012)(40480700001)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:00:39.2220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01b70fa-002b-4ec0-def6-08dbd3e133cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If x2apic was enabled during boot with parallel startup
it will be needed during resume from suspend to ram as well.

Store whether to enable into the smpboot_control global variable
and during startup re-enable it if necessary.

Cc: stable@vger.kernel.org # 6.5+
Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/smp.h   |  1 +
 arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
 arch/x86/kernel/head_64.S    | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index c31c633419fe..86584ffaebc3 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
 #endif /* !__ASSEMBLY__ */
 
 /* Control bits for startup_64 */
+#define STARTUP_ENABLE_X2APIC	0x40000000
 #define STARTUP_READ_APICID	0x80000000
 
 /* Top 8 bits are reserved for control */
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 6dfecb27b846..29734a1299f6 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -11,6 +11,7 @@
 #include <linux/dmi.h>
 #include <linux/cpumask.h>
 #include <linux/pgtable.h>
+#include <asm/apic.h>
 #include <asm/segment.h>
 #include <asm/desc.h>
 #include <asm/cacheflush.h>
@@ -129,11 +130,14 @@ int x86_acpi_suspend_lowlevel(void)
 	 */
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
 	/*
-	 * Ensure the CPU knows which one it is when it comes back, if
-	 * it isn't in parallel mode and expected to work that out for
-	 * itself.
+	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
+	 * one it is when it comes back, if it isn't in parallel mode and
+	 * expected to work that out for itself.
 	 */
-	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
+	if (smpboot_control & STARTUP_PARALLEL_MASK) {
+		if (x2apic_enabled())
+			smpboot_control |= STARTUP_ENABLE_X2APIC;
+	} else
 		smpboot_control = smp_processor_id();
 #endif
 	initial_code = (unsigned long)wakeup_long64;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ea6995920b7a..fcfa79105928 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -236,10 +236,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * used to look up the CPU number.  For booting a single CPU, the
 	 * CPU number is encoded in smpboot_control.
 	 *
+	 * Bit 30	STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
 	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
 	 * Bit 0-23	CPU# if STARTUP_xx flags are not set
 	 */
 	movl	smpboot_control(%rip), %ecx
+
+	testl	$STARTUP_ENABLE_X2APIC, %ecx
+	jnz	.Lenable_x2apic
+
 	testl	$STARTUP_READ_APICID, %ecx
 	jnz	.Lread_apicid
 	/*
@@ -249,6 +254,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	andl	$(~STARTUP_PARALLEL_MASK), %ecx
 	jmp	.Lsetup_cpu
 
+.Lenable_x2apic:
+	/* Enable X2APIC if disabled */
+	mov	$MSR_IA32_APICBASE, %ecx
+	rdmsr
+	testl	$X2APIC_ENABLE, %eax
+	jnz	.Lread_apicid_msr
+	orl	$X2APIC_ENABLE, %eax
+	wrmsr
+	jmp	.Lread_apicid_msr
+
 .Lread_apicid:
 	/* Check whether X2APIC mode is already enabled */
 	mov	$MSR_IA32_APICBASE, %ecx
-- 
2.34.1

