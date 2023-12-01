Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D68000A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjLAA5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjLAA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:31 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C310C2;
        Thu, 30 Nov 2023 16:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOS31RGVuAxhmMJC7nnbhmr11jAFT7ZyCYgOiGBgMtk3N0C2zdzPhOn43pWKalQOBI7/5hT7xCNTQ6ng4hT06gtUfwPgqbOLjd/OcQK7Wgws0/8oyJOPxMyxFbcXwpus9Tiz1DVifdMDTrNMkIrj8iTMoFdk0xMN+evXf7sr7lntzN5nKye730mqwpHHnE6zCkyuQV6c74s3QxdWxx4G41A15CXGOgpY3q4dJpKesVdpkapP5eMl9BcFQcoT20SH0K20G9hbQLB7s66z9NGfhCPkHlLn5mzD6og10oHI69U1t4c05CMywtx7edhOL80pWQWUqXWO2tgyRYVmC2bgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7PWZBts8+pEi6bHM7JvodCQRgsYmpljW2LWUOpdAOs=;
 b=VpOAOU/UBh9u1uJB/CYgI4iEB7plq4kEHbFvAIz7FnYpUcXeHHv0C4wtp8Y559YiD2ktFCNzLHgnG7QJu1XmAa2jDyJxKHk4Opm5XAwKpEkoFr2oYSzWCXKkhvUZBxs7aqUJ2/jfCvBuuXQRu89Ou+rE3DgSuhqRItMeV5O40xi6hq1zpyHx3objUTcVFPpcoOqDd/i1IkHuYuZ8ZvX0VjIIw6KyRAJLZKFwKEzNi6oJjU2DWNyyDyLJcbYPKGhUISfzW9UL4Vjbxd9O5r8kk1c3LVb4IjJnbFAFXkhnFcldTEPcaryR4Lg0IYG/24cGGck2cUjwu5vHAwD027fV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7PWZBts8+pEi6bHM7JvodCQRgsYmpljW2LWUOpdAOs=;
 b=i1bKG+camVcj4VDzJJdpgLutnDcpoTp1gn0nFrfXHga4mm57M1GCzI3lOIsFuj7YuXSGvdaZOVJ6y5mXKE/mjdHAo+LWo5jpPB4wFhwev0msdTtMvXGyt/heIi10ZAnhwdPhsOMF2ngyDsiPbOnFjPZCuQGgJqnWukPqsXPh0pc=
Received: from PH8PR21CA0009.namprd21.prod.outlook.com (2603:10b6:510:2ce::26)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:57:35 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::39) by PH8PR21CA0009.outlook.office365.com
 (2603:10b6:510:2ce::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:34 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:32 -0600
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
Subject: [PATCH 04/15] x86/resctrl: Add ABMC feature in the command line options
Date:   Thu, 30 Nov 2023 18:57:09 -0600
Message-ID: <20231201005720.235639-5-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a398c6c-2a5d-4729-87fa-08dbf2088149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIpflaj6Tz9TS7msFndupFZbllF4P3I+KSN/CqRXU5l/zb9MXsnL1e8yOmNR4Xs7FksX+DjWYGcSxouJdr081S/gYsQovERMEkH0L/E3JAxU8UAduAG9V7iedycZPmULV2N4kL1G+DnbZ3ooUg1y5ozLB6fSfbOQz2TrHd17f/16FM/JcykMi8Ry+icproTD7VYNzD+yUARMBKyMQ7BuSr3+QYq0v1O68nMLicX5vOKMPKaV9+aUu5/QyvEp4MIZ+4yTmWxsE/QVT64xWnKrd741SzFYoDGomjIFB7BkbrdgJ3c190IHr/oP/CIusZXZ6fXQl7TYDVCvLnVnQP6jWD4HGMEAYEgUpxfVt1cU/eSjaetiWvJ/MoKq4IQ8Ixxm+KPkQJpon38pFHk7KV/EMrknjAKT4qHdWPZf4N42/wsvR7PwBRPUVy0wbxzJzz/fRA7haFsJZVM3HrBHID3aKrmNcTOyxas0Z0lrYitlEbBuO76fIpDBDQMqwgKJVgk2G4tUkWxP3ZTm90wbL1Eu6KaLn6FzCoJMAYSwKLXgDKJQj2o5K5v2hL0e6DMY09I5MOC9mxFPZNtetB/3pkem6A5U6EHQPFFtoSPya1lxeQqxNkv6wtwUUXYZ6PS7mx80ur5qIh992dkDtX3MdV1ppQflBwhoyE65DI4H+mGVxEZqP5HnfjQofnck9roSTHskYeiWN9yc6Tp0hHxCAVTAxZBZCPAeBYQkW5F+GXhaDCQMY0VCqJyDc5Mvlj/UiZF5AL2a0wFG+wfH395PwDoPCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(316002)(86362001)(47076005)(83380400001)(356005)(81166007)(7416002)(40460700003)(16526019)(26005)(1076003)(2616005)(54906003)(70206006)(70586007)(4326008)(2906002)(5660300002)(110136005)(8936002)(8676002)(44832011)(478600001)(41300700001)(36756003)(7696005)(6666004)(82740400003)(426003)(336012)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:34.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a398c6c-2a5d-4729-87fa-08dbf2088149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..59a9e486fbbf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5475,7 +5475,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..d816ded93c22 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3fbae10b662d..a257017b4de5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -678,6 +678,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -703,6 +704,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1

