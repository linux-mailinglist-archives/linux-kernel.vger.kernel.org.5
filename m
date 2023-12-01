Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748788000B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjLAA6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjLAA6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:58:17 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E71BCA;
        Thu, 30 Nov 2023 16:57:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1BoIGvtF/uFj7tzTU0vhQh4fyLyYy6Gef2FjVzhDHLUHjTJeBeeYvxocojHQLGNIXzwgyLKn826q8o6BW8z8xJAXLqPTp9cIKJ5C1SO41+wUHcsoD/8BTpbjCUO12qRwlz2/NGfneTnADRP8Q0bJmuciMVdGpKN1Ge56ucQbsXyiokxBQJz4jYDxHIfYTE9MwuOHfee1tRhEDbKoqGLp8+wQ1NJpcr5o5uqN1L4BSllZJjrCA2T2gjHYJsYdgRDldIpdHoJyD7KVY6NNQdfptAAbYGn347oSBO5rtZzM21HzF4H+VVxS1dDjmca+YVoAe2KNkdtxK/9yKOnrB3O0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1geK9kaDb6x1MgaVo0VEehzktdpkHZJQWPtIZJAflmM=;
 b=RZPH7aC3ih70T7b1Z9PVjzzEfVVoIGGbMvlQmEeqhrid6cMtmyjpYyG968UGbRSP0oUltc8M0YUvLncyXlmkJvaI6AAE6e+EQmY4XLw446BVZ2YLDxnLSIrBWHcPb8oGDZABsRt3oqq5eFahmE92vIVrhl5vN6JmNldiEOYQO1jmfMi8C9tJ9zZk9xdOJ2xLhHQCKQ+ahqu90GW6D+otBu+og9vbbouPjZWWkFG4yv8YkNU3owrZVNyqi84tmthUYxsPM940UfX61ocmb4qeUciQoHKk1jUSRxKL2w1NBxbI4LcNxRGSvFgUzCnzP+Y1FxrEBh/+4ExSKhOybRl9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1geK9kaDb6x1MgaVo0VEehzktdpkHZJQWPtIZJAflmM=;
 b=EicvuN/k88zxeg2I3LNE+H86ULowWBaierGfSNipIcHRg1EONxkRPGD+eGDic0ZrxNyftQtuf5xBC97G9pUgbw1bFliwMK86bFUcDaChK9SExNnyM2bIL5JoKNscoa0Y4PzWXSJWasOmNGk0tyXUT1wXyhMgoREswiTSzwE8RfY=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:52 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::74) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:49 -0600
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
Subject: [PATCH 15/15] x86/resctrl: Update ABMC assignment on event configuration changes
Date:   Thu, 30 Nov 2023 18:57:20 -0600
Message-ID: <20231201005720.235639-16-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a08a67-e0a4-4c02-d2f8-08dbf2088b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpjN8XXetD0smoW/X5soFA+yOo9YqQFZI+jFjQsmQi/qN3X6Cz+WJ9RJRo4cItzeShwLqDUZG6j1T341wjv8mwZ5GjZgjhPssMX9Vq3wkObFyr26083E+sWrVMjwPVKtA95Ao5fJLKPFJB/C9eYGzV2N6R0UjzMhH52ChyXmh/5SgNF/mlQryj+SkxiQ7cktYETP1kxz3HiiwRq5BkE+1xWMqir3KS9ku0648P7fzHTV8fFYKd9bsGyNy5GuSQJk4WplKaGIAU0ah+sia30OxVWNBTfAo43Njjgx/5DZ5ebVgrx0Y5lioO2Mx+z+/gKKXNMZHtduQlxEysMB0v96ev5fcvj2Y9b0CR2dEY0yL+EwQiUutrR65aU3fg761U6oBXgaSnD3+W3wSj10YKzKVQBR6Af6hjBl4q98UYOwbIJP1wbfulk+gWoIMMKFoqZX3N8mYMA4XmmQ5HQiUG4SkTokSeWqe8vsbr80FABSiq9VRVeZ1u2AohTdw5HHl4EC/chpiA+UENotKS2Q68CWWAfM4EM+KxKe8YrhaRFOxn9ZZzOKzTmBJ/nFHZ39gjLq8H8NJ9QSHLltut7dz8CIcNkqjh0gUDcYAySeORrDRuQzppiZKccQs5E2+ihEbPLQDJjEY2wFTq0gsSe7b23jVnbX4FriFj/OS/So43pFselCow2iTrPxpncFI9G8H0NFgQZI/RofNsNX2HDHBly7+axVivEN6t5NX5gyiUgYfWFhvux8JsUU7rWSvZnyC7TMZJ1B1UpZmdDtJzUdG80cAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(83380400001)(26005)(1076003)(6666004)(7696005)(2616005)(47076005)(426003)(36860700001)(478600001)(44832011)(7416002)(8936002)(5660300002)(8676002)(41300700001)(336012)(2906002)(110136005)(966005)(16526019)(4326008)(316002)(15650500001)(81166007)(70206006)(70586007)(54906003)(36756003)(356005)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:51.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a08a67-e0a4-4c02-d2f8-08dbf2088b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ABMC (Assignable Bandwidth Monitoring Counters) feature is enabled,
bandwidth events can be read in following methods.

1. The contents of a specific counter can be read by setting the following
fields in QM_EVTSEL: [ExtendedEvtID]=1, [EvtID]=L3CacheABMC and setting
[RMID] to the desired counter ID. Reading QM_CTR will then return the
contents of the specified counter. The E bit will be set if the counter
configuration was invalid, or if an invalid counter ID was set in the
QM_EVTSEL[RMID] field. Supporting this method requires changes in
rmid_read interface.

2. Alternatively, the contents of a counter may be read by specifying an
RMID and setting the [EvtID] to L3BWMonEvtn where n= {0,1}. If an
assignable bandwidth counter is monitoring that RMID with a BwType bitmask
that matches a QOS_EVT_CFG_n, that counter’s value will be returned when
reading QM_CTR. However, if multiple counters have the same configuration,
QM_CTR will return the value of the counter with the lowest CtrID.

Method 2 is supported in here. For the ABMC counter assignment to work,
the assignment needs to be updated to match BwType to the contents of the
MSR QOS_EVT_CFG_n. So, update the ABMC assignment when event configuration
changes.

The feature details are available in APM listed below [1].  [1] AMD64
Architecture Programmer's Manual Volume 2: System Programming Publication
(ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6eca47673344..11890b4afb9f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1768,6 +1768,38 @@ static ssize_t rdtgroup_monitor_state_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void rdtgroup_update_abmc(struct rdt_resource *r,
+				 struct rdt_domain *d, u32 evtid)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	int index, mon_state;
+
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+		mon_state = TOTAL_ASSIGN;
+	else
+		mon_state = LOCAL_ASSIGN;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return;
+	}
+
+	/*
+	 * Update the assignment for all the monitor groups if the group
+	 * is configured with ABMC assignment.
+	 */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		if (prgrp->mon.monitor_state & mon_state)
+			rdtgroup_abmc_domain(d, prgrp, evtid, index, 1);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (crgrp->mon.monitor_state & mon_state)
+				rdtgroup_abmc_domain(d, crgrp, evtid, index, 1);
+		}
+	}
+}
+
 static void mon_event_config_read(void *info)
 {
 	struct mon_config_info *mon_info = info;
@@ -1852,6 +1884,7 @@ static void mon_event_config_write(void *info)
 static int mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
@@ -1892,6 +1925,13 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	else
 		goto out;
 
+	/*
+	 * Event configuration changed for the domain, so Update
+	 * the ABMC assignment.
+	 */
+	if (hw_res->abmc_enabled)
+		rdtgroup_update_abmc(r, d, evtid);
+
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
 	 * for all RMIDs and Events will be cleared by the hardware. The
-- 
2.34.1

