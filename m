Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84347D8726
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjJZRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbjJZRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:03:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498F91;
        Thu, 26 Oct 2023 10:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGri0r0O9QUEcvMerlWZ0YKQtomqdvsorBlVANBM4q50DGsdDnokgtjrTq0G6c3iuzBV5kaWG8TVoKHaasAS5bbd9bWWWATSDRbzT/1k1lO2S6fIM/kdJFSzNwSdBgBA1BLmxAENceNNNhQ4B/Frr/05OOwV5SGO7tTjhMQAe4GH2kzjGegVYsSH8GyYckTvL4wzmnECRPHaiJgjd30WoR88yDAzrWU+AlH1CnZzbZSrx1QK2gXybHAz1gOUZDBAusOOiLiAPdzgn+teEqBIcsPz4iKV2S8hpQVhlMVHDLMFYlM3b1GrUZSmSodA19zVCOS52CYiMRjubv6CgcNm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm0xvk61lC36xzyQyVliI6spl0vKmNv0Vdnc0gQng1M=;
 b=c8f4yXJUa9FYrhKzG7Q8rQQ4PcadBruKsdOFe3PKpgtMqvw4G3lGSqI9EnKnyiVR/dM8PA1XbWIM/nscQrjtYgzevfSOUHtO72+57o2pLNpg9D+5Yv453iuIOuFLrAyu97ZMi1ZHCuYOzT4sz95UOekdfF7VQMAb8KImArcA0Zdk20eKE0DF6LsOg+xmvoNdhYLZZbxtl5ViieXoCqHHWVY0YoeXrSUHRT4AidAxsqrYRR9IlF80Gwl+vHTRIC+MpIpUM8aEjPQiDEi6eQR57Fa+opP+iDluHA62yiRR1dsCu1ivvPAyfIb3U8ynZjKWEA0XC2waSUaG71vaidjlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm0xvk61lC36xzyQyVliI6spl0vKmNv0Vdnc0gQng1M=;
 b=cfmw1tWnKoWslbVV6QMx/o6Wx1fMmHY9t6zywOh8v3nUbUzn1O+xevZV4OH8sNXr8J1pF2gmKu16oEaQD8nStvnM2nYp2AtIRPPE4fcAmVE1365pDQWMZ3xfYlMrHBcBrBGhxQmo3NR1ERIMnvZo+46OvWZQ6LwyRPi6dMtoeYk=
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 17:03:47 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::72) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 17:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 17:03:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 12:03:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] x86: Enable x2apic during resume from suspend if used previously
Date:   Thu, 26 Oct 2023 12:03:29 -0500
Message-ID: <20231026170330.4657-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026170330.4657-1-mario.limonciello@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA0PR12MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e9b4de-72d2-44f8-b405-08dbd645845d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnPFkUkNWnS/9xviZ6lyI7EySxkxsHRnn3h9B/Rty51wf/xaLBM0WGZfYFyhV5x6WeibDEDvB9KwY5LoAAOvIzVLQf56QPLfz8Jbd7Cw0g3+pEk9jZASIZw7TBc7kNaAMoiZIlRakVMQDmebOfuDRep6m6E1U1sF6qPZnS4MXqFwg31sIeZcnsaNwcfuzJIXcTllKyuMiDCTYT5SrbPL6pI1B+xTMsLLFMLD9YT7QsFBbXNihGkrsdi/7lUhv329ezLAXgFB3fZt6ZXTrP89W96WZP9QH/P3oCFHeXw3rgFmvmP3nFAr6RADPknYYir3L/YQFx10TRb4h9D+kuqCEc2SyJxEWWjmLJM6ORqxik2f0IvUoU/oV+C3tmWF2y7s91z+/S7ov5K2xSsgEluRuwb3B5ZMKEy268MKksvhbuMJ48khijCzFBmq9LNANQYJTWZi20kuQ0n9pUTBCAHMGo9NgGAgbAdOuiO0jGaIXByDnW9hrUnqJCnFwiwh+7Hfy5UFWobIdbXKahEZ4nBBAK92LG/Gtsg9eB9X7RLh6glmcD2Gq9StbH9KAyC9Ws2/rqbKxt6O0ApQQEa4xAByZrsiVJ8CB3wW2mnEROdkd6hKuJkOcLUR8nKXOQUiTOGoDMfbZdYTP+8Lt6HVEcnu2/KzCbfWNSKIleQXZZ6isW/z1hqtCuczH5rzLSwt5TOekWf80BWVP+Ck68bmuBjzadnJr63GCpktTGC6DkdgH5WoJ7cAGhHPbityfL0bYxijBRROiivtvMsdohlk/KcuDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(44832011)(36756003)(2906002)(5660300002)(110136005)(81166007)(356005)(2616005)(54906003)(82740400003)(40460700003)(70586007)(478600001)(7696005)(1076003)(426003)(40480700001)(6666004)(47076005)(83380400001)(336012)(70206006)(36860700001)(86362001)(4326008)(8676002)(7416002)(15650500001)(316002)(8936002)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:03:46.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e9b4de-72d2-44f8-b405-08dbd645845d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If x2apic was enabled during boot with parallel startup
it will be needed during resume from suspend to ram as well.

Store whether to enable into the smpboot_control global variable
and during startup re-enable it if necessary.

This fixes resume from suspend on workstation CPUs with x2apic
enabled.

It will also work on systems with one maxcpus=1 but still using
x2apic since x2apic is also re-enabled in lapic_resume().

Cc: stable@vger.kernel.org # 6.5
Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Clarify it's in workstations in commit message
 * Fix style issues in comment and curly braces
---
 arch/x86/include/asm/smp.h   |  1 +
 arch/x86/kernel/acpi/sleep.c | 13 +++++++++----
 arch/x86/kernel/head_64.S    | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

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
index 6dfecb27b846..10d8921b4bb8 100644
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
@@ -129,12 +130,16 @@ int x86_acpi_suspend_lowlevel(void)
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
+	} else {
 		smpboot_control = smp_processor_id();
+	}
 #endif
 	initial_code = (unsigned long)wakeup_long64;
 	saved_magic = 0x123456789abcdef0L;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ea6995920b7a..300901af9fa3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -237,9 +237,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * CPU number is encoded in smpboot_control.
 	 *
 	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
+	 * Bit 30	STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
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

