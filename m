Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F88000AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjLAA55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376428AbjLAA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:48 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB154171A;
        Thu, 30 Nov 2023 16:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaRQAt0pWMF4ZA9AJDw/KD+oJMIm6l24+sfEmqyGg1uCPQaQVqoVVxV17e92tVTl+eA8P2fRp5UEhyjXiHOAZumk5M9xLZFVtRkOmtA4TIlbegyawMVXjmi75K4geHIYjWd7xUOt9QInNzup42xXyWvIIww3Prc17oGBvtoA4kwqXwPLpl3VUU/L2+I4sg2vTuZZG/wdokAgmzOxjkFcxXh3Qbgzv5PQ9puSQhyYfH0HSJeTQ5oyLaOv2kUp6kwJtuhdXY8j/fUOwst/Djtqis1G7pFC3ipu2lmSQWk2eOUE/ixHJWgO/4w388DcOENcm2g+TS6eQB23ZN7hf1RObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5Xouoc8uEK48VBdV0+80NWs/fZzahXcjnvbnUl7kJ0=;
 b=Eqfo68UYUE+TMmFOVGiZF79osuBcAzEHH3jaWXosngXy+J3G7JpGrQPVPdEsMh+Y7lwa50phmhqoM/ImrThOgcWqeSzJVvv8seJEop+xgk1X1lB+hXUng9mZoVPGMcmOOqXXxnFsuTbXQ3SlDWX7NjI5MnPPh0PpXE+e5oWDkQW1YBks6U50VhwADk+ktwNP2rRCGd5Xwkjo7k8NWjm3xgIKlkwF5sQESWFBufP0BCfgp5K3f+rpJFlrzBW8+kCbez9+ovNxrdLF151+RoTblAu35RocuwfhJQ/8Jq7iC2TSjT37jRYoRqAI/5nG7ZvX5YSRpHCtp0vZBDV5taDJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5Xouoc8uEK48VBdV0+80NWs/fZzahXcjnvbnUl7kJ0=;
 b=EzaspybEEJAHgyw7lrIZg5fw6R0/PwaP8VtetWBlz9iQ3irn3Vvkcfhy42sGc4zo5CA3TfLMwiPfVQs/bDZKk+RUfXEBwE9FS2Ttc2DIpxka56UeUzZaViL4qEz3Zb72I8B8xGDg6wfDjT42Dr8l6inUZ9s82axI9c8NSfNcgus=
Received: from PH0PR07CA0081.namprd07.prod.outlook.com (2603:10b6:510:f::26)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:41 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::f0) by PH0PR07CA0081.outlook.office365.com
 (2603:10b6:510:f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:38 -0600
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
Subject: [PATCH 08/15] x86/resctrl: Introduce interface to display number of ABMC counters
Date:   Thu, 30 Nov 2023 18:57:13 -0600
Message-ID: <20231201005720.235639-9-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9749e6-cce5-40b4-b6af-08dbf20884fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2PTt5z+7+w8UDUljld7ja/LyNHU5aA5Z2dhOeFktwZQyrVf5oK9Ojp0ZFXnJLHjhkLb6qlJH6dIIeBgIUJPwiPgPiMEaR1vPWvKV70tFrfIszoz8TyilKykm+W8UKa9jqy+of4ftO3WsunkS2VPsDV0XVZ2ixFswa9U7BYsdD8bBt6GYuYZbPXk6Q7pRSQQECBM3RgwIwG4mWmlh7WrIrGPV0pZHWUBgpkfJkD0Iv7zuhiMk3Dm6jtm/tbn3F06kQMFSd8GRoYBXeV4g+wlIUSDnvRnPomSNacyGK6wv+Hlm8ZBpBKiRL0w1RJ+wv6PC+nzno48MS7fZrkM3rt9PCVcGSdvdQ8Cx4HtzFsdBrmMwnYyeSSiCJ68F/63xcMUhn9qEB2jjnNqrTTsGlfna4FfwXU0IVe3Y3nT9qDb18EwGNgRCJmClQoe65xzGHQX6d1rrW4fceMCcGitKlqV8rFtQokGEwEDMJIlw+J8SOyz9MbXPjR0flcdOGh/sSvbqImYDFhV9Go/FBcmT+Ra4EZM/olAVVjwFbgGfxeqwfgzsRUrMw6hKn1znqkHo1blQj9fiuh74UaD70KyotfPinsia8VroFMpZqMXUy1jn8jdjt9cBejZRM7W4rF8Lcmv/eLJB19HtD6gR/gPqyZdXlKzy0ZDJ4qqqe7k6oeGKuipswEG145TqVAfvMeM8DOEYshB3A/B5BorjcLEq1HI7o4CwzsGliodVi9xMDq5u/yihY3JN6qI4WEL8jUWUzeGPfkL0gVvgr1bL6AtvYUbaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(26005)(336012)(1076003)(6666004)(7696005)(2616005)(47076005)(36860700001)(83380400001)(426003)(16526019)(7416002)(5660300002)(44832011)(8936002)(4326008)(41300700001)(110136005)(2906002)(8676002)(478600001)(316002)(70206006)(70586007)(81166007)(86362001)(54906003)(36756003)(356005)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:40.7468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9749e6-cce5-40b4-b6af-08dbf20884fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABMC feature provides an option to the user to pin (or assign) the
RMID to the hardware counter and monitor the bandwidth for a longer
duration. There are only a limited number of hardware counters.

Provide the interface to display the number of ABMC counters supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 +++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 19e906f629d4..87aa8eec71b7 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -266,6 +266,10 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"abmc_counters":
+	Available when ABMC feature is enabled. The number of ABMC counters
+	available for assignment.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7f6ed903ba17..897707694cc8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -811,6 +811,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_abmc_counters_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	seq_printf(s, "%d\n", hw_res->abmc_counters);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1861,6 +1872,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "abmc_counters",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_abmc_counters_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
@@ -2419,12 +2436,22 @@ static void resctrl_abmc_disable(enum resctrl_res_level l)
 int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+	struct rftype *rft;
 
 	if (!hw_res->r_resctrl.abmc_capable)
 		return -EINVAL;
 
-	if (enable)
+	if (enable) {
+		rft = rdtgroup_get_rftype_by_name("abmc_counters");
+		if (rft)
+			rft->fflags = RFTYPE_MON_INFO;
+
 		return resctrl_abmc_enable(l);
+	}
+
+	rft = rdtgroup_get_rftype_by_name("abmc_counters");
+	if (rft)
+		rft->fflags &= ~RFTYPE_MON_INFO;
 
 	resctrl_abmc_disable(l);
 
-- 
2.34.1

