Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D517A2A88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjIOWnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbjIOWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A625115;
        Fri, 15 Sep 2023 15:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiZXcCqN3cUrHynLVVdk4d2u146HB9yjgplOZ9nQN/uRZk1XE8OuDQmxVMUuNh0ZrWml0i9oCC+us9+/Gtjr8nTeeimALNUGbZudh+F6EFjFDTDeAtiwPVa105bEeZJlMh7GNH6WnRXikvXp2nf0ZHi9BvSL+DPakJO5db+ChGfEFKRychV1jsZUlzUZ3BpU1bhKYqa5qKTDRD4B8HiUhP8V3SpX5F2V8XKsJcaIHOiIBq2vlfRpnUGXwlw1UYWkAsVUF4t43BN35meAPao+Uk4WYq1b6UscH4e5SDRm1ZPgeQq4cg71GMszefPQySzcbRmqtyd9w37HKaQNoSW0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnwcG3l72kLybYiBjLxO5k4/kCMEuedhA0eBwbmELfE=;
 b=IrXoit5U9GXJr5XRAnYxtFMygmx1e6eCYS85MNg0Bn+i6ERtfnMsSnagrxXVPJtDrruTpcx4FdXjGBlRYm19ZnmOCnxNqiaLgHnCSVCFrTJRScoFjASeehCWhI5iRpl1XW+yI5ZTV4D1/CUpyZH+aYGuKwIRYkwBNCAFv7qeYduFic9Y691TL+W8vFz7XFPh3YWbdWaRlZs/7zexObnL//9Pj+DPtqLbd2w/Gat99/AuYg9tkbJmaz23BspoeYouEHJkOn4Q9t7LNMiMNyzNcqhI3f8cHGf/7xnMMzK5rP3geC6WIzIOBctpGvSUqZXgsnrWOb27PAABEsXM67/JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnwcG3l72kLybYiBjLxO5k4/kCMEuedhA0eBwbmELfE=;
 b=FqRTAqVBCC053wgXz4OmZgZN0LAU+BP6hA5Gs/uEDMszYt2dbYu0maZsWsrzQCUOoC/u831MyqwM7QNTOVp8AqN1GqsdMV1D7C4/h4jjhiPWJQ2dSmYFJCKPaStndtjMd5EHXG1Ny0Q3d+1BPKTyRFusgDsI/aUcsSllG8uPtwU=
Received: from CY5P221CA0097.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::37) by
 SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Fri, 15 Sep 2023 22:42:39 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::25) by CY5P221CA0097.outlook.office365.com
 (2603:10b6:930:9::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:36 -0500
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
Subject: [PATCH v10 02/10] x86/resctrl: Simplify rftype flag definitions
Date:   Fri, 15 Sep 2023 17:42:19 -0500
Message-ID: <20230915224227.1336967-3-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9636cb-6ede-4e6c-e0cc-08dbb63d10a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lD787liTZzf7ohBgjfgCI2Vx5kCI8YTGx3LfKSi+jJlbDNqu9tRaamSvFTq6R9mPEfA7Xt0cHcZlBb8Xo4XEM+j6f5AThqeZUYorRntEG8iVCmFV0ideoigW8s0cJm0gFu0Kn2gZtTFHOFYK6AOe2eeASBIuk5tgMyLPRTOLzM4fyJ2olVHnfG0rmlZpzySWZTy5eeQwvXP/j1j+VmuQCqwpm11hvORS6OMuSJqptqACKEK0eWsjvwFxE5mUsSug35Zfm2/csUh6bc9SVA9ZoZr5+K4ID7E3vTU04fpy/BMy2/kQdb6FlJw+IANwIu1eAXAdLxZMGJHMK/7hk1gkkngtVBWnCSIwgcve25h5QJMlq6LW8vxH/digqp3Dh1+wu3sLeqrVqJo+gEA3jDaymOxaI3WqG+dL5i3FL1LIpxJNjvxSKIJJFnSuFbtLuwZBvWnzAsxmE9cOKEL2Y9dHmfcy+dyGdMjRuoJvuz7K2qv8McyiswStHy9aPy79c2TuT+iCzfRkE4IpsuMApejwvZ8vLgMQUN+X3+aCZFwQKAsL9VGMhlXdeHwmj8A99VVDz1t9JG7lHG5XQh3e0gl+Ua+4oI3wm6HgRdL44hS5A+L4o8uXwGltpe7QZ2YrLxVDDDB0uqVmxEURUpISd0FiWLEDRA/NEZ0u6ezp7s0K0W0veKVq+Ou/VxmPbaExUDXMtazEJSXkKHyTSuzRsRpmuK3JA4XFfoy+GhnDDlM2YEQ+cZgmz2z6QwfqVh92JDzX2Ww5+sjLJA2AkdV6fq9lhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(7416002)(7406005)(2906002)(47076005)(36756003)(86362001)(356005)(82740400003)(81166007)(40480700001)(8676002)(8936002)(1076003)(2616005)(70206006)(5660300002)(26005)(110136005)(7696005)(70586007)(54906003)(316002)(16526019)(4326008)(41300700001)(336012)(426003)(478600001)(83380400001)(6666004)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:39.0424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9636cb-6ede-4e6c-e0cc-08dbb63d10a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
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

