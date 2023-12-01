Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD88000B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjLAA60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376669AbjLAA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:55 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418910FD;
        Thu, 30 Nov 2023 16:57:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUBv4E9/84ACcP2Mi0fdM74dIhCOD2gHCf3hcdv0v2GfjCjSx7nkAvh+4BogtQEqxHf9AwcYjoYylIvjx7ArtemTejeELl1pmKioc1m0P/BNypumX4P75dsc3v5Kvsu0iEXsW4q2lx/GbEW9Xwj/SsTA9jUaMjcGZVYyubUsgpXv/8RgwxNZoxeeN6tSi2zamP2i4Mn5IhOXIAWDARunyYbLPs2ZKQgrtpz4UEMhYlnkepdmdxbNBkkWDwWjikBdJMhEmcjr9SGYeXqNiHtK/csF9jYsF/M7GgOZ8dGtshzZjd/rbqMbxtOOwxIVzCOxHoVRTU6ijqvLmRgW8Dsk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piEPgAKjrySING7Fbtem/KYTsQm62KOjO+TVQc2aTPs=;
 b=Sivn8TYlNYskYbwf9BzCpPJ6+wnzA9zYcnY4PnZfALoTwwL4T0Yt3I2zfKupHekiyDaD0v+uBE2ZPClwh8f1mVLOwRd8ILhXmLde6uNYAfRTZt7m0+ApD16y9tMztgdXyceHM53Um46D18Z7/ttgT7QLsQlK8J/iM+/EuVSh40EDFRtfYNBcGvoS7G+ut+sqamwNSqB08sTGh50+9DJGSUqVwHsG6mDQ8NLtt8si1nVDDavponipzUE8S6gd8yNH+DDJdopSaE0OtUf/+SBjEc3+e33UTdWpdgSng77e8AHJ/SMXKBB5LHcC1EeeVZUhiOgHlvDKHDci5H4Zfg43xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piEPgAKjrySING7Fbtem/KYTsQm62KOjO+TVQc2aTPs=;
 b=TroZ6xjnkDk75sNqLkUmaX+ITJfwv0T0yG9dj5oGqNKmca5HXvWimIQMxjkBdTG7lGWc9jqYBX5080x9T157LJ6kOYG+0vTN0nVd2UxKvJkwcu9wiE5HcxfOrLsiAHwh3sQFoqyCOlpOXzgot9ih228zHztlweoZpZoWq9JYtLA=
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:45 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::23) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:42 -0600
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
Subject: [PATCH 10/15] x86/resctrl: Initialize ABMC counters bitmap
Date:   Thu, 30 Nov 2023 18:57:15 -0600
Message-ID: <20231201005720.235639-11-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0c02a4-1594-44d9-1ec0-08dbf20886d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UavEWFiWEDUFi6IWp5nvohx5ggflfljacyyOKZzYJf4/KAmBxIwQT1KtVRi95KEgUWLolDqDa7lDGUIJszukATWHhtDInZLvQTeZKSfqgnXAZSvJy5T+ZLRRXlwy7iUNjahvvtScSkJt8TXjP5EGpz4o32mEzpNDUCOTZk8i0qPRPLERp2h2Zk28RyUMVx2pbeMITnI9kXJnTYobK3Yl0RePlQRMoHcqIMRCn0T/bgFrjEYRnQTxjeS9hnVmlJ43Yve3eu3o3TCeNRPDzsVbzS630hZRV+ZPQYRV2My9oQ6U0ypA9lyuKhw3WIVVJodT0kPNAPdeNOe/7vnEh0MCo/pckh58PM/kxyQx7WLLMyaWwZNeStsKZJmyOGiuhTFHih48L5FDuNcpGRcM5UC8Wh0W1ouMwIPKwyVwaXyVeeM/zicL/zdDejgHoX5FLtAeBuXXmsSclX8OSJvcsQBMRtRZgiW4kIIX5XSPWOCJ3Tg7iYKypC3F0NcJB0AdJU1Ux02u12vcnIJTES3YM4nanySXkmXqQX9OK3LVyagaK7bYlFC44o3dB+Lw6PX2DGIIypKoZ6vAhKGpeQPVfP5XgiE3wnmQFDEuVUJBw5+ovRHQ60vbi8UvBDeR94W7rzdlukw0f597km6y6D6gwTIHuIp3u+Z6oLSCvDq91Vy6K1oI3nYiXh28jIkIZm+LrnVQY4qOGMZT7VYK5pRh13fUW4wvWviFPiStBanX1fowKZsvOR/rkDxPMpP/GYD4f80+vy243i2FmWrHhvczem/iQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(26005)(40480700001)(40460700003)(36860700001)(81166007)(356005)(82740400003)(47076005)(7416002)(2906002)(5660300002)(336012)(6666004)(83380400001)(426003)(16526019)(1076003)(2616005)(7696005)(70206006)(86362001)(41300700001)(70586007)(478600001)(36756003)(4326008)(54906003)(8676002)(110136005)(44832011)(8936002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:43.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0c02a4-1594-44d9-1ec0-08dbf20886d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Hardware provides 32 ABMC(Bandwidth Monitoring Event Configuration)
counters when supported. These hardware counters are used to assign
(or pin) the RMID to the group.

Introduce the bitmap abmc_free_map to allocate and free counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index edb679b22b7b..f72d6d8c12df 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -164,6 +164,22 @@ static bool closid_allocated(unsigned int closid)
 	return (closid_free_map & (1 << closid)) == 0;
 }
 
+static u64 abmc_free_map;
+static u32 abmc_free_map_len;
+
+static void abmc_counters_init(void)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
+
+	if (hw_res->abmc_counters > 64) {
+		hw_res->abmc_counters = 64;
+		WARN(1, "Cannot support more than 64 abmc counters\n");
+	}
+
+	abmc_free_map = BIT_MASK(hw_res->abmc_counters) - 1;
+	abmc_free_map_len = hw_res->abmc_counters;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -2715,6 +2731,7 @@ static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	unsigned long flags = RFTYPE_CTRL_BASE;
+	struct rdt_hw_resource *hw_res;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2745,6 +2762,12 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
+	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	hw_res = resctrl_to_arch_res(r);
+
+	if (r->abmc_capable && hw_res->abmc_enabled)
+		abmc_counters_init();
+
 	if (rdt_mon_capable)
 		flags |= RFTYPE_MON;
 
@@ -2789,7 +2812,6 @@ static int rdt_get_tree(struct fs_context *fc)
 		static_branch_enable_cpuslocked(&rdt_enable_key);
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
-- 
2.34.1

