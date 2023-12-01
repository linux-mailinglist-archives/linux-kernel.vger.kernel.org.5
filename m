Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D578000A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346794AbjLAA5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjLAA5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBFE10FF;
        Thu, 30 Nov 2023 16:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8Fz4042oHoyibva7Dc1wcb9/YVyhsHSuNPtV/fIqjCQmW2tryOqkD6M66bBry0Qc7sQ+QOm6cE8lr7A7dUYEl/e8NX5KdBQIRso/oHyP64NT5fVfFqjS0JiJuD1VtmQ3FxtIOKPJf0adEES/DW6LVvK5xcImCX5c77HctS36IFDjlxiKf4374kD8UN8ZsTT40wM/P4S6INmkXwQGX8BKsi6ikFC+8YUVdubdXYnbQXfvnOe32rPzC7u4lMrokVVnTflYKz3XtygRlI9XV2UBSycwkeh7RIVEWfOACyh8ODM0vyjYBgzcGus1ke5dOij6N+HiWiIRPD8y2J52WhmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBON67A3z7Ros4SA9R0qKnCh9j2iIJtwPMkiW8zqhOg=;
 b=AmRRdpIQLVCb45UavrZ0B8834cWDiXaSZ2A8964MHfv39VN3NMtDBhxUOYGCFxbjfljFbf/n3blte5QBSB3Onpe12PMBx1agvYtfmbZqjYxSlAvN3RdAI1+YYDzWYSnTxIJk0/KPF/LpxDkaAVO390/U1+4aujYT0jwx0lTXp2DpafJUipprFC6XC5C2eb4uvAdfa1y+/yrTokUkXWdnodcjqTlAXdHvul+KwRjQd8azvy2+9eiVbF5TDEWD5YAyKBuO8CfMdC9KXw0PxebfyeLSV96XkX0aXDWKpAO6Toycr5HIfUOQeIUZa9Lq98C9292795Xx040c5RP0nOf2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBON67A3z7Ros4SA9R0qKnCh9j2iIJtwPMkiW8zqhOg=;
 b=4pWOPvbZcd3QxKb1kS5m/lZhhKqLW71QJHm4uGZEx7cB1zTWSYR7Zd1o+uZty8l9wiIBkXoiAd3i0yvq2tCD93ki+N3LH31BoALjHORbZwMjOSChZkxc70OVI3P9Bhn7fInkthi5nz6feuO3xjWopUGlKAcnZ8dDhToTfD42NG8=
Received: from PH8PR05CA0006.namprd05.prod.outlook.com (2603:10b6:510:2cc::6)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 00:57:38 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::c2) by PH8PR05CA0006.outlook.office365.com
 (2603:10b6:510:2cc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:35 -0600
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
Subject: [PATCH 06/15] x86/resctrl: Add the mount option for ABMC feature
Date:   Thu, 30 Nov 2023 18:57:11 -0600
Message-ID: <20231201005720.235639-7-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: f61f6692-5dbf-493a-756e-08dbf208832d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7FHmutnU8fBj/XLs5xAn9uwUjsIykstMtHEsJw7K8exSpNJR02JzST6YzXvCNC/5mTinBsF1LGLv25VNhghfQ8QGn61L1amN8kk3vZQPnKleb8q3znBXygNLDOHYcXJn39IbeMtnmaK50gUK2l6HOi4cyFYHJpQ9xfyv734NclQ5O0h7pkWvvrCnl8+KSOmSSwiYb/PkNuNqy9T8QyKl/e0GOTXppylxTEPlrdC2LpYVxvgHCFUOcjdIl9D8u6JI+1FK4+wnwS8yi9w4ROSCmrJ3haqwZAbZ2TMvqySR/30N9DOrHqF2gjrt6sATr9wwfZOljXFTTp0UlHKp0fa+H9lCp+48pzkNZ5Rjra2GWzCSq6R29jqYcqWQ+pNWM/JWy1imRhuRZbxmO1/LGVWUXPpHgJxzs3RGikSAm+x0d6t7Gnlp5ejaCwovkwg/oF09VwomRBe0ReKDfq1CeW7MB9l6gi9kzcqEfC3IeIC5DxobkCqnk1pUOQ+hl+WjOS4doFFWQNatzviAXdTkU9b5MLX+nI+NgfbtL3t+5nlMFmV9e0cZl4Mx1zGk4iQJ74NJQY8d+/QC5IW6UdW8uiyK9y7N1OA05dsY3jVmrWsLHbXrHZmH/HhJz8Ll4FSSKvccZXx1fJ4Kf2wjdA0LBmIHiki1D9fMvFky7qVZRvVg73O/ae4MZq51/khfn3mwdJt15PXo5dAjeyAZMlLD2r5fiADenQmo6jVFMRA8XStTOzafBdtnNZIbUjhJxKkIrfvVxjpBZrOTWUxeUG04AuoVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(36756003)(426003)(82740400003)(336012)(40480700001)(36860700001)(81166007)(47076005)(40460700003)(83380400001)(356005)(316002)(4326008)(2906002)(44832011)(86362001)(41300700001)(5660300002)(8676002)(8936002)(110136005)(7416002)(70586007)(7696005)(478600001)(6666004)(70206006)(26005)(16526019)(54906003)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:37.6886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61f6692-5dbf-493a-756e-08dbf208832d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mount option for ABMC (Assignable Bandwidth Monitoring Counters)
feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     | 2 ++
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 1293cb6cba98..19e906f629d4 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -50,6 +50,8 @@ mount options are:
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
+"abmc":
+	Enable ABMC (Assignable Bandwidth Monitoring Counters) feature.
 
 L2 and L3 CDP are controlled separately.
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0b22be85a444..b8f3a0b1ca41 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -56,6 +56,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
 	bool				enable_debug;
+	bool				enable_abmc;
 };
 
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index feeb57ee7888..a4328e12a8f6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2687,6 +2687,7 @@ enum rdt_param {
 	Opt_cdpl2,
 	Opt_mba_mbps,
 	Opt_debug,
+	Opt_abmc,
 	nr__rdt_params
 };
 
@@ -2695,6 +2696,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
 	fsparam_flag("debug",		Opt_debug),
+	fsparam_flag("abmc",		Opt_abmc),
 	{}
 };
 
@@ -2723,6 +2725,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_debug:
 		ctx->enable_debug = true;
 		return 0;
+	case Opt_abmc:
+		ctx->enable_abmc = true;
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.34.1

