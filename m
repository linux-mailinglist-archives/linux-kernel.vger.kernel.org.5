Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B157C4586
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjJJXeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbjJJXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:33:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87799D;
        Tue, 10 Oct 2023 16:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evi3JWRlxCZdbnEolIhCsWgElZAPIQZ3y+rWgn4TXvrgNnlb1aiNjy5wEpMUCMMyD9MKT8A/MtVBCjkckFkFb0cTD6/uKj5UufRsbUVkXw5cycFcrOoHBFG9q9PVAa6Y8gCLCNPXwQySQ5TT2ko7APWU224tFHj+5rBCWSk6i9pVKolkfPJ3T8D3pMmCsHZ5ObjUdB4kndRcLCfctaX1F6sFfxeKY2FMKSHCZzNqxVHy5vfPKAlL+iMRyUOcstzsIwr80t1mSnmWXEBqwagewzg51xW8Er+jzhyEaVZfuif68CfKmctEwnuMSMd+B1sHgmbijnOOQsBGCNjLXMuaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3lo19Z3taUJl5Gy59RynpNh18VIJAYAW9337PE04pQ=;
 b=QAMU6n8q7cnDrqm1mi+y/kk0fyQIB4tugLx3E8l/4SScitCy0j+mKbwy81SiP3Hhu8BQEJ+WgOQL0XLdHioNl7baqIXMrwub3wUrsMDtBpya98N2ROCv4Q2Gr7KnvGfPu3iZYXOQNfRkwYW1lT0GPyneM2p2kLxIx1Jp6/AaWlzzXwO/mSga+d5JERe+gTkZRy2KUpCPiMdXeAvRCPFil9Gbpj0p/cq4Yg7VKBlnbdW2aW30/ZVCvGzUEBFFYTq8CgLHiFv5TWOp+oilO8h0uy83eecw4SGoTLsJ8eEVmZzcmeJFJXcL3vqKLligEpx6Tqbez0JL74MMjgRdpQS8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3lo19Z3taUJl5Gy59RynpNh18VIJAYAW9337PE04pQ=;
 b=lbjPAasyuZA2rQm8eG8S0f7bFuFReHJuptsKD3l+2I98GBqoMwGGDiXjF37mzRe+hcNPlcusPxKKuaeBGDbhXt5u6PoiPlVQ/zzCwKDt/WPpWP5csmeumK0gIWO0TeKy1ruWnLBTyMTH5sH91g4gFvp7vL6xkpy3asRVWXDi8ws=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Tue, 10 Oct 2023 23:33:47 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::cd) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:44 -0500
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
Subject: [PATCH v12 02/10] x86/resctrl: Simplify rftype flag definitions
Date:   Tue, 10 Oct 2023 18:33:27 -0500
Message-ID: <20231010233335.998475-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010233335.998475-1-babu.moger@amd.com>
References: <20231010233335.998475-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 64623571-b48b-4acb-8833-08dbc9e9596d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRojnqrX2J15LaqQeH8O/al8a+wQutDAl24N6aP4Hdp/gvOVFjwCSXMDVC3f+Z7IIQi8ovr3E8fcjG3UBJg0GvgYcp9/JaKw5k+CjXeSeHcmbYWAhO7n2WqGdxtgJBgt/XOBNLykKAVEOTraS6bmiZ+7eVZRBEQO7SlnK62LGrb3OX7Af3jLX1UIpM1s6s6kyPm3P/6DGEnY1Fb7dGztQJlJcQMGcEUuzAZDAML61ijih8osiPOsX65tX6PNca74mHSWa1GNWvXr0oOtBmZDVNN7Rh0aSWuu+cVYrMToTQHwJlBiNnN+CdNKubXurDpIV3XtCZ06BgdmOfnLblRxmPJgNZUVQF9DRVogbCAkWY641kvN1NOaesEjRSv0M/yNCbujbsVQul5lPi43rNJg7MzAgrm6pqqMwNwQryh41z4XOthXrdd/K5jNbm7gxQ2Wdt9Dpe86iPlf1fPJehLsWeHhzOv5583U0dYNkMB84FWfrOHHPjbRpyfxnr9dD9orYhHXC7S5e+shaof42SzRk2/LFftcfUnzxZRrw9kt76DUCxgbYnKWNKNVtjyoyEiylsLHkgb1M0hXRrDyThKoe8sY5Q2MQx/ybaabY0kYYK/LqQ3gRFC31iRFvqYewkGQoUPiqXdqgbS5+dMj2MM4zfTR1nPprxj40Rmm+BYdOztrrY6vhnhjy2yOZhjyJMG50ExHWBq9K+4ul0es0KFyt+RbeROb0x5gNDoSDkRkngWRpV59hGNlzC53CltwpHHCuclbIS7MzKYm6luYnhCqKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(2616005)(1076003)(26005)(426003)(81166007)(336012)(7696005)(316002)(47076005)(8676002)(6666004)(8936002)(2906002)(7416002)(478600001)(4326008)(36860700001)(7406005)(44832011)(54906003)(70586007)(70206006)(110136005)(41300700001)(86362001)(356005)(82740400003)(36756003)(40480700001)(5660300002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:46.7345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64623571-b48b-4acb-8833-08dbc9e9596d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rftype flags are bitmaps used for adding files under resctrl
filesystem. Some of these bitmaps have one extra level of indirection
which is not necessary.

Make them all direct definition to be consistent and easier to read.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v12: No changes
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac..62767774810d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -243,12 +243,9 @@ struct rdtgroup {
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
-#define RF_CTRLSHIFT			4
-#define RF_MONSHIFT			5
-#define RF_TOPSHIFT			6
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
-#define RFTYPE_MON			BIT(RF_MONSHIFT)
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
+#define RFTYPE_CTRL			BIT(4)
+#define RFTYPE_MON			BIT(5)
+#define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f0d163950969..7ddfa4b470e6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3242,7 +3242,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	files = RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
+	if (rtype == RDTCTRL_GROUP)
+		files = RFTYPE_BASE | RFTYPE_CTRL;
+	else
+		files = RFTYPE_BASE | RFTYPE_MON;
+
 	ret = rdtgroup_add_files(kn, files);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs fill error\n");
-- 
2.34.1

