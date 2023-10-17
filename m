Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC57CB754
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJQAXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjJQAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:23:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009E3EB;
        Mon, 16 Oct 2023 17:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHM6pGnZNBW4E/lFWUUFn+g5gudDmh5MFBLbkn9fk4cB+rz7il3Or8SuJ44ZhvTdpnFIeu4/4a/n9eYeXk8v92Q+E9pHLBsmYuqbT8ERlHba7JBd/0OXJE41P4I+yd0U5HEGpRPWrtpl8RflW32fNrlKEa4IKVZmzvEj7SEU2nbXe4M7XDwHkDSWsLgqQ0vYSWTYVMubZuqTojhbZ82A3W7T9Oo4AuyB0Fv4SuDfbKmqFUL444viUEpm5Ohjxguea/m1+X5GbQ9eH/Q5A9UrNqD7eiy4Sm4mLoqTsY+G2tXsy1nckSi9eB9PBcHwQdZ86yaGTufqreGJ+ljXWggBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF+IxrRzTEaApog8qp4T7XQxXW+R06Y7lOOfLGdASjQ=;
 b=b7wc1M/ee/uQ50KQlwdlAN1GdWnUyZyR1/XrHQB8zn58aBkRc+S8f4XhzXbS+xRJ2q4+UucB+rFilStfPqT+W66ijh4VRCbJ/q0U/CC3dm/PvhkVUjgbNE7XLNTTxyTP+ldlrCZg/3jLLT1XfTQARpsZjnhbavTebgdR15JGILd2P32pmK4hobX5e4DU7uStFYzc9MezovPbHeblE/hxgjKhYEgUw3auGBJFuS8wZ8FfVT0k8NZUMsDtuhWPRJGs9lnsE2pF9ACM9auuhs1jlpturocZRULQ+iPBQP/2CVcDrW75rIMX5ypvrvF00tSbuVIGZTeUk8wzFoJoZG93Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF+IxrRzTEaApog8qp4T7XQxXW+R06Y7lOOfLGdASjQ=;
 b=Ma7tJAXunXtevuWMwho1cg4qqmn8OKLdKJCn6TWWZtb2S4n8GQ63UpP1x7BTsI/LAw+FjRdz5PnatXSp3odUuQybJbcmULRox+sD8Ta/xa9g6C8k3Bjt+zloPHK4HKCc7Mmffua1OISwfFLWzs8qUQ+tCkcGKEwIO5qr5w0XetA=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 17 Oct
 2023 00:23:31 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::5a) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 00:23:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:17 -0500
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
Subject: [PATCH v14 2/9] x86/resctrl: Simplify rftype flag definitions
Date:   Mon, 16 Oct 2023 19:23:01 -0500
Message-ID: <20231017002308.134480-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017002308.134480-1-babu.moger@amd.com>
References: <20231017002308.134480-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: c3eb1a6c-9336-421d-4aa2-08dbcea74a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOum1AUtbIB5MU/0/SSefGhWfqvTF1tfvA9uomoAC25gccnj9MfuLTZnQ9YHSYGPt+r4VnewfII91oKzhhdyDHCfpbKROxfIWrT/py5CTReZTSZoPdHrjLQOrZSwVL4FFwiotDEepI//ftd9OmEi3YZcaHzDj7PKqjcozZm9EeFu7Crrfyt9zNZvgEQdMZTWERi2yhpPKgtUBAJ3NTVhvYGNzBFC+Yf6+5LKtHt04QTsFkZDOLNb+NectkpiXE8Imv66A7k8Y7ozvbaslMvNw9a8C6h3u9qEpqu4IgSFERIvSPwHygFIt8qg4AxPjORbatVzF1JxErToP1eyqZE0Ls6ZuS30zxd301EafZjVaWMrLMofZDXfrHcvOqvHxAPhiWDOcZKpnt6Ov5bcgvbD/gKvefyDoilFG+kMwzjU0DRbAcBnaz24w5+zJJJv7gSFdjQL3MK+JHV6OGtl2VBd4bvSQ8UTQN7PwodQUb881JAwQ6spPtzqa2yFfXssLSSyRx2S8veRFY/Ep2rH7+PaL+XTCbpUEVeedyjwspuyHwjISxgWPtkiGB9yOIzFGwTHTSMVW3I9ZHEPqyUDHwnrSrj72K6U0oVB9PgB8MmLusldqqUI5abAgs6JVud8bU3UnuL1CJlTywebssE/s2ufQw/O9LEke7plm2tolsPykiBzgfNSOPjTyUqpp7KbHrCbG3MNBa5IjKjV+jq4JKzzG0a/5MM8jurpHAT+CCmxQZaONk9W1X/WctG+OiWAxZWooARFDheOFHyBC1HCgdzEGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(40480700001)(426003)(16526019)(336012)(1076003)(2616005)(26005)(7416002)(70206006)(5660300002)(316002)(110136005)(41300700001)(356005)(47076005)(82740400003)(81166007)(54906003)(2906002)(44832011)(4326008)(8936002)(8676002)(86362001)(6666004)(36756003)(7406005)(7696005)(478600001)(36860700001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:30.7824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb1a6c-9336-421d-4aa2-08dbcea74a9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
v14: No changes

v13: No changes

v12: No changes
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c47ef2f13e8e..0ad970c5c867 100644
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
index fe239691628a..09141f1f0b96 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3260,7 +3260,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
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

