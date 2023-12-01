Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A68000B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377033AbjLAA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjLAA6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:58:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5641BCD;
        Thu, 30 Nov 2023 16:57:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HujtYr3YHCVJAsSXRBdWLMEHbZ2kjgk2qXwjJ5F2jSCbcUWcuv1n96VpKMzh15KEANhj8AYlbfDfFs4VTmQ+Pb+REsV+0bc1O1BJ7aaRCoMPH80NgPyB98YHFKq5I+Bxe94h6mB8rkHKQWhlaFbIQeJeLZ0NBxhStcHg8KpdYWR5aZdUQAPCc/BkkzJ6Uww025k3WnOKfTQj5y3WOjTQLduul7ej4vS4wWV3xdugTOLODpnKdVVnGMIK3a9+kJlpEW0z1FTZ47fOb731Cecl5WdQAJ0/1cP+E40jS+0QLrkA0hj7uPE3r+jj3pzjB/IC6bLy43CPE7EtuloZpH4+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXqLQiptGdq0u69FqCIQ5viLyj6+zq4egR6HyqAZDsk=;
 b=JNURBV781gWtV8GnmJXQFBgvylYNCXT9ijb9vzj5w4q7QaNCsjmjmq235fjnmkkL82lsG3DkP878VrYnXvEphG3ZduuTK3VH/4BxZQP2d6/Vp9dUluJd8UXgUCRfN8uhRIZBQ+4iiGEjO7w3ik4VTrWihLDAOHkX4X5/Cf+Q850nGFqnWzInFASzchYe6/RQtD9IpHssCyyENa2fKUuDfT/5DiHCESWe98NHkYPIl/ZnwjtrB1sAOP4EQs8rZzp3ZDDDMj+F1yt3ZM9O5+wznckJf/3TL+EzpXIxIB9MXe7IzBQWEFQ3aUYNgawUzaottJURArH/OyATfWy0emtfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXqLQiptGdq0u69FqCIQ5viLyj6+zq4egR6HyqAZDsk=;
 b=FwclH2C+5Kt+1Iaq+wNt8+x8FdUJL4GN+mW9jyqxA4wdq/RWwU+Cozq4AMePqGQIiy0rZHeE7SUEgLj9gvkyh0o8p4FS8osduL13/plMBY+fVMZOz0dDxGG9nwO8VX1BNqXVuh9f9JU8YhLZvktcPn9N7Do/8+INXCE28PKzIok=
Received: from PH8PR05CA0008.namprd05.prod.outlook.com (2603:10b6:510:2cc::19)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:57:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::6d) by PH8PR05CA0008.outlook.office365.com
 (2603:10b6:510:2cc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:48 -0600
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
Subject: [PATCH 14/15] x86/resctrl: Add interface unassign a ABMC counter
Date:   Thu, 30 Nov 2023 18:57:19 -0600
Message-ID: <20231201005720.235639-15-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 54753559-3f1f-478b-6e24-08dbf2088abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YOkHGvZ+7nKV1WeXVOc+rnBYE+miy6RJ2Ve9MfyAioLcqXSK5TMWolBtZ0iSKArnAtCT5wevFBSbVSDmuZ+uKmFSSO4sN1NGzSJDowGd/qR6hMlhT6umC7vaGSKbW+wT+Db1NgjeymoKAKH5AALyelr/EH1MR9yIIlfepKy/f8Lbo7iJixf/34lX3UeiztuRl1f1KCoGrLcvY71u4vVCEj+zeGz09y3VgdWXtqKrq0CZe25fbMcQTEiJJ7liePVvyVx4DBynG7pQpcER4unV4t8vBmGBAHvHAf9W3pWOt/sn/AIgxHtHqDLBZTA5pAJbjpKvJukLyK1DN3OddipQEYf37PfjXcNnCVhJimB7QlGxS4CGkXJqKTCUHNHxX+Ch7bvtzhSJSHl0UL6M5K8+pm3DvGSf1rC/XvpaiP1b26A4ZdeUziJGEefXGGjBSachqoXRDjlBl6jbeUY5K1jFRV6UOJoQpUNA/oq39K5vSiZC8XaLbw8TpM1H1xtNEqvIFWpzgk/NbqQCbYwoOFhkI7NYkjU407fm9AJIwXilPbGuOaERkyIBxjwNJObdXQ5Xz1NDJVhwVQqHOFGC9A5ttnLhbHtmxJo5608NBbQtylFXdyl7r3VTEap7UHvMYfGAua22+EiE6JPq6NwnPnqjHtooa3aA/DADOj0bWILWYr9egOh6EOXkCYPCHhgM+sRYNDDFWubvEcQdUwHKBDFDDCJK3xH4Q0kpwn23f7BYJoZtpue4LUuFmBINeo9KBTCjNfNQULXzkoiDKjyS7gsMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(478600001)(2616005)(1076003)(336012)(26005)(6666004)(47076005)(7696005)(36860700001)(81166007)(356005)(82740400003)(36756003)(70206006)(5660300002)(54906003)(16526019)(44832011)(41300700001)(70586007)(426003)(7416002)(2906002)(4326008)(316002)(8676002)(110136005)(86362001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:50.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54753559-3f1f-478b-6e24-08dbf2088abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the support of ABMC (Assignable Bandwidth Monitoring Counters)
feature, the user has the option to pin (or assign) or unpin (or unassign)
the RMID to hardware counter and monitor the bandwidth for the longer
duration.

Provide the interface to unpin (or unassign) the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     | 11 ++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 36 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 65306e7d01b6..b42b59a7ba3c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -417,6 +417,17 @@ When monitoring is enabled all MON groups will also contain:
 		# echo total=assign > /sys/fs/resctrl/monitor_state
 		# echo total=assign;local=assign > /sys/fs/resctrl/monitor_state
 
+	The user needs to unpin (or unassign) counter to release it.
+	Example::
+
+		# echo total=unassign > /sys/fs/resctrl/monitor_state
+		# cat /sys/fs/resctrl/monitor_state
+		total=unassign;local=assign
+
+		# echo total=unassign;local=unassign > /sys/fs/resctrl/monitor_state
+		# cat /sys/fs/resctrl/monitor_state
+		total=unassign;local=unassign
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 671ff732992c..6eca47673344 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -192,6 +192,11 @@ static int abmc_counters_alloc(void)
 	return counterid;
 }
 
+void abmc_counters_free(int counterid)
+{
+	abmc_free_map |= 1 << counterid;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1671,6 +1676,31 @@ static ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp,
 	return 0;
 }
 
+static ssize_t rdtgroup_unassign_abmc(struct rdtgroup *rdtgrp,
+				      struct rdt_resource *r,
+				      u32 evtid, int mon_state)
+{
+	struct rdt_domain *d;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	if (rdtgrp->mon.monitor_state & mon_state) {
+		list_for_each_entry(d, &r->domains, list)
+			rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 0);
+
+		abmc_counters_free(rdtgrp->mon.abmc_ctr_id[index]);
+	}
+
+	rdtgrp->mon.monitor_state &= ~mon_state;
+
+	return 0;
+}
+
 /**
  * rdtgroup_monitor_state_write - Modify the resource group's assign
  *
@@ -1716,6 +1746,12 @@ static ssize_t rdtgroup_monitor_state_write(struct kernfs_open_file *of,
 					rdt_last_cmd_puts("ABMC assign failed\n");
 					break;
 				}
+			} else if (!strcmp(abmc_str, "unassign")) {
+				ret = rdtgroup_unassign_abmc(rdtgrp, r, evtid, mon_state);
+				if (ret) {
+					rdt_last_cmd_puts("ABMC unassign failed\n");
+					break;
+				}
 			} else {
 				rdt_last_cmd_puts("Invalid ABMC event\n");
 				ret = -EINVAL;
-- 
2.34.1

