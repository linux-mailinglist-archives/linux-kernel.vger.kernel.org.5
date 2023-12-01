Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C228000B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjLAA6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjLAA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C8199D;
        Thu, 30 Nov 2023 16:57:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdLqKVM9lgYbl4OV7M8UC1iDlGqN7ZZkWFY56M3T53viMeXq5txpAkZ5l9lVa08SRJUAbZhMvopnMP8WUAWJNit0Pxiu9I7I8wQZ1LRUuN7rbEeuiDRM3931zWDYqrUD7goyfBjyOnE//MYdJVDSBw9jaACuBNitL4XLcqQPaJdGoay1hsxNHqi9SlYJ174Ak6TeQZFGo97L94v3zvV1hN4x2nkvQbLZH2BQO+i/bqn5fRwfC79RqlUgLDwUjXWaAVSmVqPs81EL6+kCVVLS5mCxsbACbRPF0qRnP6sLtUkftErzQLjlE0hxb1PbA4a4Uuj+pu04VohHSZC42vP7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6VmD/ResjfrFnzsAuNBUKNm8poKIvLnEvkzo/Qn5kA=;
 b=iQMVPpCkUZGhnu9bED1Yyg9i8DJlEsQc2V8IpBwv7nlWvPrs/3CRkcjxXGWiyTp5PjU8Fj1YBCovHenjAizNnLo9ZSWWpxqOOcq8dZvoylOFCnYkdtCI4Kea7LwcgyT44CzeslD0oPAVEjtQbjG6EMAd3KTAP9XYqxgcRpoO2yQuMAvfH6cEA53TEFOexfgnrycBY0MhaSMZss/HcYGBNRi/6wvitZ/Tgm56XsOnnNGrOp3rDEygqczGe15OUaJbYpTT2daP1L+HpbsprzVgo2HRVPPQZWH3+2aq4HxhaJBefbFTv9Q0DwPRGL6AVgvRcq65RA+jShrNKl0OGBZsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6VmD/ResjfrFnzsAuNBUKNm8poKIvLnEvkzo/Qn5kA=;
 b=KA7TdWgY78DQKAzcnR5ljBVQ400hwD4YbupQdrC9bGK/y42dqiPiyWyL5I1t+YEQShjY8WbLCEfBX79+0mxylJUNDj2C6kjTYSZOX9I1nYjSrtM8cQtuvZ7aC3+LF0bL/fGAZQj2ocaHY2N2sLTB5/LvDASrg9DAgn6pQexVVGc=
Received: from PH8PR05CA0004.namprd05.prod.outlook.com (2603:10b6:510:2cc::23)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:48 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::78) by PH8PR05CA0004.outlook.office365.com
 (2603:10b6:510:2cc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.14 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:45 -0600
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
Subject: [PATCH 12/15] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
Date:   Thu, 30 Nov 2023 18:57:17 -0600
Message-ID: <20231201005720.235639-13-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5040c0-431a-440f-6d24-08dbf2088917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E60e9F3t/1Mazm7oojtHerE1qn4ZEAUiiydTRfqC6c0FJIEjQ3s0xtypG2dG6YpeLDD4r3hUrjWQydR5jWzFW/55Yw3/jQxEgA58d8EAaBATXTL7b7jdvDt3sHP8oX63v5QOBDH0u7ezBKk38bTJ/sjERvENH1KpnICzblE1092CmydTRauZvabQ0/F9sWKnqD6KDxyRvjG/RBwAEJu8QASQ0LB+1UOm3OWy0KzZF4lKlELhctJA2KFgA0Xzh2+FxWJQ/X0ORldQNP02b7704wo/hJ5UNXqd0Qfe6vpH0giPA4L9ONQ/zvX7wStFNXRSlBWu8LBwjbVTtFdJ13QX1WSt3P0DKQo2tLO6mBoUgaT29DBOQiIG3pMmh2f2tvEDmkkcTo3TtM4nrSsxH5IeQw4Da0W41wDSElJ24cZ+PJR+IS3Z8Paq6TZb/QMiVPS7STjkEzVRDr30kb6QftIzoYKbp8NoxTQLT77A3Wcrkodalhgfejs/NNl3UNuz8e9JTvweiHUXCjK9ZF8dIPYqT+Qq+ej+OD0ZlqFkIXkRejwOKaeq6C7DD3qHx2jlNF0WZuFrU0VmQPCRrKlIdV1PTGLWSGftxsS1a9D4nyYOy0LNC60gXCPWvc8pYl/0pRQKzgWNSZK0yLwvkvSbLJr2XkQdT1RutJrgia1fJ0hXBLy9IhiungilJSzOcWH07EHv9fX1PwBq1sawGlXk/8DCDG6dAWSi0pDpTzxnFlU/O3DBchrOU2ICZJTlMCejy9ndcVnbbV8bGcRnKhM3Nkoc6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(70206006)(54906003)(70586007)(81166007)(356005)(82740400003)(36756003)(36860700001)(86362001)(426003)(47076005)(83380400001)(1076003)(336012)(26005)(2616005)(6666004)(7696005)(478600001)(110136005)(2906002)(16526019)(316002)(4326008)(8676002)(41300700001)(44832011)(7416002)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:47.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5040c0-431a-440f-6d24-08dbf2088917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured. The event configuration
is domain specific. ABMC (Assignable Bandwidth Monitoring Counters)
feature needs the event configuration information to assign the hardware
counters.

Save the event configuration information in the rdt_hw_domain, so it can
be used for ABMC assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 4 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 278698a74c49..5ac9991e81bc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -556,6 +556,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	arch_domain_mbm_evt_config(hw_dom);
+
 	list_add_tail(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ca4b551dc808..bc1756a596f0 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -346,6 +346,8 @@ struct rdt_hw_domain {
 	u32				*ctrl_val;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	u32				mbm_total_cfg;
+	u32                             mbm_local_cfg;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -605,5 +607,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c611b16ba259..34d3b0c7f2c6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -854,3 +854,14 @@ void __init intel_rdt_mbm_apply_quirk(void)
 	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
 	mbm_cf = mbm_cf_table[cf_index].cf;
 }
+
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
+{
+	if (mbm_total_event.configurable)
+		hw_dom->mbm_total_cfg = resctrl_max_evt_bitmask;
+
+	if (mbm_local_event.configurable)
+		hw_dom->mbm_local_cfg = READS_TO_LOCAL_MEM |
+					NON_TEMP_WRITE_TO_LOCAL_MEM |
+					READS_TO_LOCAL_S_MEM;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f72d6d8c12df..047aea628e2e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1667,6 +1667,7 @@ static void mon_event_config_write(void *info)
 static int mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
 
@@ -1696,6 +1697,16 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
 			      &mon_info, 1);
 
+	/*
+	 * Update event config value in the domain when user changes it.
+	 */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+		hw_dom->mbm_total_cfg = val;
+	else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID)
+		hw_dom->mbm_local_cfg = val;
+	else
+		goto out;
+
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
 	 * for all RMIDs and Events will be cleared by the hardware. The
-- 
2.34.1

