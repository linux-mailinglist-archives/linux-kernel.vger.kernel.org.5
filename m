Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3C7A2A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjIOWnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjIOWm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAD72701;
        Fri, 15 Sep 2023 15:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBsfVad4M8iY9bNIsC3ubNwiFd5tqV9Y0xkt+8ZPnAghJEvRYjbW0NPFhE56s9ucDmBdpc3h3aXm0kJWYlC5ZU5Ql0P9fqd8WTI0jkwzdnG5Dv/LZvli2TWMELCsiI/2KP+GeRgEduBePRjpiKtu00/JOhOa54peDV96oq4H6M2Z81ZIKlPidoSRcd6bMm7cjgiDK0k3pJ0W0nrNVLfYc5ukwlqDqUX/6iHb8Bown/ZDq/OWpDof8J4ztohSMme6xbytFhhAXdUQZ79X3i6KnSAF7394E+pcTc7caYDr4ZAjFoMcAmCb1Qy1ibGN/UYY50vsar5z0ujU2MWevkUR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoFHthP8jJEaLGBvg2GU+s6+SJMGwMzDX40DDYN1UUM=;
 b=n/m9zWbRS4mzhJ0Lh6kfzRa8LsfLAGEXHxYhI72yp1lQNYDdITS536ZiHy1NT3TWc7hv+ld9CW6gdvFvNSVOdUJPf5XpUvtSOpjz4ToP8mgpT0aoost7owXgIkAViWGJvnMmvkOXR2o2PR7PUTj2j9oyNn6YNqjwdx+aQ4xp8sCVufxpmo5ocUJvhl/F2AYwUbej6Y2RFSPMahUDKTIefdUUIkGwSRU9rNg0rsogdb69pWxWvGKiucSnMmnzeXDYk18im/70TQFvID7N+CMqwR2HWQ2L/CT1F50UaGM5u59Ntt7w42XLW6cl0GOg0JfPBMtDPnGNVFp4dJ4D9wJ1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoFHthP8jJEaLGBvg2GU+s6+SJMGwMzDX40DDYN1UUM=;
 b=p+4ALhY8EiJWL1GdX1B14fAWakvKxbocOU5kQvsVHv0b+HQgGmqtnlc6EzFXIZx5u0GQrTWT3frv8rTakIKltMkmWR/aV8iXn7UvBm6PTCHsrmpv1V5owx+CG24AvGxnZnBWllOcKEing26XUQLja7ERsdkdWlDYzeUoSYP+2ys=
Received: from CYXPR03CA0053.namprd03.prod.outlook.com (2603:10b6:930:d1::21)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 15 Sep
 2023 22:42:50 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::35) by CYXPR03CA0053.outlook.office365.com
 (2603:10b6:930:d1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:48 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v10 09/10] x86/resctrl: Add support for the files for MON groups only
Date:   Fri, 15 Sep 2023 17:42:26 -0500
Message-ID: <20230915224227.1336967-10-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915224227.1336967-1-babu.moger@amd.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c676ae5-18bd-4606-50b5-08dbb63d174b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmsOQvDuX2y1HMNX80kZUQ1fw/TP7wgPQxPhW+vcpCzRpT4hFOfdVLtK0wLgQPVHVRQ6GiR79pVZzOI8Uvpcxb/pevpOBdOO/AFCC2W0MD9y8Or2lVNLXnP3xP4ycrYyaEQxpLRrjFb7AGPDMNXeewS2ehQ9prRdxJeFY0r2XpCQGOeTuSbWL38t/8YC/V2ed4hTy66dTwXfhcTtxpgSFYncLqmRzFQLgGu8d/cYdQf/He8039LhXC1OFIyvmFDoEWMFLcFoduc4UABlOI+xU2DtKuqj18sGdFLmlwPm+olQpuuH6rxWq2IdIv3jl3SP+Rz9PzObC6teVuseAKDLNpyZuOLNLQJM/G593MzesLJ7ANeCGH3oviUBhpT0Pr2yX7saOmDIoEH2qyiu0k1SQ5pEcFDG46IFyv3MAZ8YdEjkXwSIJjXcZQ4X4gZ5AKbobzJWzl2rXjxoZc3xiORGMCsoH/MtEl8RL7YKs6azdjSHXlDvUwcoGFzkpYC+zxp6BX4UY8f9vA2iPRbde3FVYdBp6hklnmuGjaU3MJD7OP3EGIS+ZxQiBCgJtG5qo/0d5v9FNWt4l5igiyAKPghCg1ujUlMIqGkTwSgnWpWhZ+ui3yD6L7U71xyU9b7BLy+PCPGvWVPdCOynqLZz7C37Z/U5QvdPbnbQArcMn9qM7Obel2lblfanvA+q7qJ35bcT876QCUYdbdN+cIKf4TeCVqaNX+Yk6nh5E6QHEY524aIKzoy5Ju6MLQVXtKZSK168Nb08IU5fTq5C1Aix4wLkuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(81166007)(36756003)(86362001)(6666004)(54906003)(70206006)(40480700001)(110136005)(5660300002)(8936002)(44832011)(316002)(426003)(41300700001)(7696005)(70586007)(26005)(1076003)(8676002)(4326008)(336012)(83380400001)(2616005)(47076005)(82740400003)(356005)(16526019)(7406005)(478600001)(40460700003)(7416002)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:50.2035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c676ae5-18bd-4606-50b5-08dbb63d174b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 types resctrl root files.
1. RFTYPE_BASE : Files common for both MON and CTRL groups
2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups
3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups

Files only for the MON groups are not supported now. Add the
support to create these files.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 953b082cec8a..55d1b90f460e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2533,6 +2533,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
+	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2563,7 +2564,10 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (rdt_mon_capable)
+		flags |= RFTYPE_MON;
+
+	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
 		goto out_schemata_free;
 
@@ -3253,8 +3257,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
 	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files = 0;
 	struct kernfs_node *kn;
-	uint files = 0;
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
@@ -3306,10 +3310,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	if (rtype == RDTCTRL_GROUP)
+	if (rtype == RDTCTRL_GROUP) {
 		files = RFTYPE_BASE | RFTYPE_CTRL;
-	else
+		if (rdt_mon_capable)
+			files |= RFTYPE_MON;
+	} else {
 		files = RFTYPE_BASE | RFTYPE_MON;
+	}
 
 	ret = rdtgroup_add_files(kn, files);
 	if (ret) {
-- 
2.34.1

