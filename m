Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D98000B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjLAA6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376818AbjLAA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17619AE;
        Thu, 30 Nov 2023 16:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz2Kp9vo1M9G+dGolus/FEJJmWjAX2xO2kSFL5ydHB89C8yt+7cKFa67TB6ut4aAAfcvDVuOJI3w3yHSSZMayYFN1WBHem06M2z+ubSYnPX2g/mn72vGfl1cwmN8Jn7u82Jx08XE5rEZhlFwwKzQq2mpaQwhookKVgSQpBixHI6zGlCr6XFpe48KDVrkQxA3qVVUcIxni15nGM3W3TeoAXmg69SIeYt8NwNk5WDWhTm1FEFg4zFrKVTVlcnxQmuAjmGuojce4g3hBQZQ1EjzCr07j2zsPi7BqF9ILtldczdpPcRXSMGtiOKDXgKxJ89RAsZQzUOb8aJqEGwGdXufcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CinmOS9wQj8p8QwUJDGc2MDj2/VMMXf5nxa6P8k6SlA=;
 b=Vj6wI4zEL0jydYor1PQepAEkcKXa5QfsPi5/qUL1jPdpK0C66MCVonykPQAkjOekxXJUnkvs+5MIBwLR9XFwd2LszprwzIjAP6MRlFx6Ut97uNp1z+UXET9URzSbUyz+nJnhlu543Da5LKl9nS0ztZPqfl08B3JU2zz+izgyuKq9P6tWoPz14nS22YYYoZoKodhSPStgb/3aGK/KSDXMFTDidgMgDUCIKjFrv9Xz+ijOE+H7nSOTQbeCkhTUz+LekMA8D5IWcYb/ih9Dn5xa4KLd3Xm8vmpb3XiAPE7XOGkNezB7rJ0Z6O64oyFQcnCPNyOg+KZF2/fRRz/S68cQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CinmOS9wQj8p8QwUJDGc2MDj2/VMMXf5nxa6P8k6SlA=;
 b=y0CCk7KDl35efX+r3JdtpvevV3CtjoEzm7iktCKLXrKzbfFhrJEumzTVcmG+pgFYl3TvEgYL8XvH5AC7/N5Pvxdrlmym5iBOk4y+sth7KWpmf5WO53DUsJUjjzwkXAOch6P/I9dWeNm2wt8ZjXFLbrS/O4FYjTcuc53hvXmwljk=
Received: from PH8PR05CA0009.namprd05.prod.outlook.com (2603:10b6:510:2cc::26)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:57:50 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::d2) by PH8PR05CA0009.outlook.office365.com
 (2603:10b6:510:2cc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:46 -0600
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
Subject: [PATCH 13/15] x86/resctrl: Add the interface to assign a ABMC counter
Date:   Thu, 30 Nov 2023 18:57:18 -0600
Message-ID: <20231201005720.235639-14-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 26528513-e21e-41f9-fd28-08dbf2088a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgeCbIBM1oSIvrlzq04EyysY6b+PjrHdOzvJ7rtw5NeUcozVUolNO3ajKu3RqoAxxcEkHuQBQiW25Bwbb4cp9eXimTfRZI6NsXALMUTvnsHpeOXmxKKUmhh5Edtoe4EJHJPJR4KuHvkydr44sLBSkdljm7seHmTQra7UzumaKDGB/kCpoibEIIenogz1Ll8W8rJyv4VufpqMFvOaO2R8OuLkIZ+8aN4lC+EMH+/GVGWeosiSwR08i/E5673qO9VdwoFBplSPBiCKEWnSKf9eYzNwPyf4MS3UUGuSKw9k2OJQ7HiPkY/fbmNNusfiHIQvV8WUvowapMWbp5vuR0gQ3T/gk6B/DLcvmI5k1osWIP7FmyeTW3Xjt8iwDkPFkjr45pKrMEG96/Qrh5EOnA9P+BWsuWj7kQpfUUwEUibgd2NTAVVAP8G3afUPX7g1qy8z/FDHX8uu5yYoeeTxzHs9lBxiu0N0XDTYenp8IZTbscBEwWYSLD51lk9dNuycnbgvQOYOO4l7vF05C9pp6txsvBr2sZA7fLZA84p3IXUVTIMNn3iEVHN+8TVjn63MHHbhUHA7bo3gquCYlKJcgDz3zZjDw8OJ6kgf4Rj2jLGG83jaatonNl0y585XwyWl1AYtFoAdRuv0/Lcq0HW8b9zZDWLqbfgzhQJzaMfhoSjTJQq15Ogrys136n6r8S3uiw88p6dsSqpYfDPr6O1hIcnekXVdsCRxXtLTMgc4Ker+Hfe988UN8tqJYHMzOzz80s2nuyNf2Vr/aUqnmA9MjYPHfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(316002)(86362001)(47076005)(83380400001)(356005)(81166007)(7416002)(40460700003)(16526019)(26005)(1076003)(2616005)(54906003)(70206006)(70586007)(4326008)(2906002)(5660300002)(110136005)(8936002)(8676002)(44832011)(478600001)(41300700001)(36756003)(966005)(7696005)(6666004)(82740400003)(426003)(336012)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:49.6262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26528513-e21e-41f9-fd28-08dbf2088a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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

Provide the interface to pin (or assign) the counter to the group.

The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (MSR
C000_03FDh) and L3_QOS_ABMC_DSC (MSR C000_3FEh). Each logical processor
implements a separate copy of these registers. Attempts to read or write
these MSRs when ABMC is not enabled will result in a #GP(0) exception.

Individual assignable bandwidth counters are configured by writing to
L3_QOS_ABMC_CFG MSR and specifying the Counter ID, Bandwidth Source, and
Bandwidth Types. Reading L3_QOS_ABMC_DSC returns the configuration of the
counter specified by L3_QOS_ABMC_CFG [CtrID].

The feature details are available in APM listed below [1].  [1] AMD64
Architecture Programmer's Manual Volume 2: System Programming Publication
(ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 Documentation/arch/x86/resctrl.rst     |   7 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 152 ++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d3df7d467eec..65306e7d01b6 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -410,6 +410,13 @@ When monitoring is enabled all MON groups will also contain:
 		# cat /sys/fs/resctrl/monitor_state
 		total=assign;local=assign
 
+	The user needs to pin (or assign) RMID to read the MBM event in
+	ABMC mode. Each event can be assigned or unassigned separately.
+	Example::
+
+		# echo total=assign > /sys/fs/resctrl/monitor_state
+		# echo total=assign;local=assign > /sys/fs/resctrl/monitor_state
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 047aea628e2e..671ff732992c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -180,6 +180,18 @@ static void abmc_counters_init(void)
 	abmc_free_map_len = hw_res->abmc_counters;
 }
 
+static int abmc_counters_alloc(void)
+{
+	u32 counterid = ffs(abmc_free_map);
+
+	if (counterid == 0)
+		return -ENOSPC;
+	counterid--;
+	abmc_free_map &= ~(1 << counterid);
+
+	return counterid;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1583,6 +1595,143 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
+static void rdtgroup_abmc_msrwrite(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+static void rdtgroup_abmc_domain(struct rdt_domain *d,
+				 struct rdtgroup *rdtgrp,
+				 u32 evtid, int index, bool assign)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.ctr_en = assign ? 1 : 0;
+	abmc_cfg.split.ctr_id = rdtgrp->mon.abmc_ctr_id[index];
+	abmc_cfg.split.bw_src = rdtgrp->mon.rmid;
+
+	/*
+	 * Read the event configuration from the domain and pass it as
+	 * bw_type.
+	 */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
+		arch_mbm = &hw_dom->arch_mbm_total[rdtgrp->mon.rmid];
+	} else {
+		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
+		arch_mbm = &hw_dom->arch_mbm_local[rdtgrp->mon.rmid];
+	}
+
+	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_msrwrite, &abmc_cfg, 1);
+
+	/* Reset the internal counters */
+	if (arch_mbm)
+		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
+}
+
+static ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp,
+				    struct rdt_resource *r,
+				    u32 evtid, int mon_state)
+{
+	int counterid = 0, index;
+	struct rdt_domain *d;
+
+	if (rdtgrp->mon.monitor_state & mon_state) {
+		rdt_last_cmd_puts("ABMC counter is assigned already\n");
+		return 0;
+	}
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate a new counter and update domains
+	 */
+	counterid = abmc_counters_alloc();
+	if (counterid < 0) {
+		rdt_last_cmd_puts("Out of ABMC counters\n");
+		return -ENOSPC;
+	}
+
+	rdtgrp->mon.abmc_ctr_id[index] = counterid;
+
+	list_for_each_entry(d, &r->domains, list)
+		rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 1);
+
+	rdtgrp->mon.monitor_state |= mon_state;
+
+	return 0;
+}
+
+/**
+ * rdtgroup_monitor_state_write - Modify the resource group's assign
+ *
+ */
+static ssize_t rdtgroup_monitor_state_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	char *abmc_str, *event_str;
+	struct rdtgroup *rdtgrp;
+	int ret = 0, mon_state;
+	u32 evtid;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	rdt_last_cmd_clear();
+
+	while (buf && buf[0] != '\0') {
+		/* Start processing the strings for each domain */
+		abmc_str = strim(strsep(&buf, ";"));
+		event_str = strsep(&abmc_str, "=");
+
+		if (event_str && abmc_str) {
+			if (!strcmp(event_str, "total")) {
+				mon_state = TOTAL_ASSIGN;
+				evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
+			} else if (!strcmp(event_str, "local")) {
+				mon_state = LOCAL_ASSIGN;
+				evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
+			} else {
+				rdt_last_cmd_puts("Invalid ABMC event\n");
+				ret = -EINVAL;
+				break;
+			}
+
+			if (!strcmp(abmc_str, "assign")) {
+				ret = rdtgroup_assign_abmc(rdtgrp, r, evtid, mon_state);
+				if (ret) {
+					rdt_last_cmd_puts("ABMC assign failed\n");
+					break;
+				}
+			} else {
+				rdt_last_cmd_puts("Invalid ABMC event\n");
+				ret = -EINVAL;
+				break;
+			}
+		} else {
+			rdt_last_cmd_puts("Invalid ABMC input\n");
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
 static void mon_event_config_read(void *info)
 {
 	struct mon_config_info *mon_info = info;
@@ -1944,9 +2093,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "monitor_state",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_monitor_state_show,
+		.write		= rdtgroup_monitor_state_write,
 	},
 	{
 		.name		= "tasks",
-- 
2.34.1

