Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06ED7B7590
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjJCXzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJCXy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:54:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FAAC;
        Tue,  3 Oct 2023 16:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae4/IAvRIdCfq9fFdxfWcFHvTPI/bNVBgYqbuR/1j7auiq4C1t8/LFdvAUYZP52ofx/0AzT/iJXyRyJAVyRYhSL6EVxzmJC/WRlg0oIEw8dEbsiTi3N4tk0U9ia9F5rc4B+g9ki8TNDPT7EJrGqW5P5vAHztvfsQiYreNzbPNkOm0mRTwwY8NwqGnNBLHSKF8osbuiPgtrnd9EM3bolYylhIu5ewjrtYwVv9xGk/pRmet7ZKoM+EtxDM+9rkvnWRaBjT5eWadfZqIv8FZnqRx/2EEyfV0H5ahqLJRjpYVpRgsHLBKsndTFyttp9gvY9rVesvqGDfTffrI67r64xnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvx6wpstpXyvbg9fQ0PRt/s04VUxwIAdPEUkvwSPzCY=;
 b=FKlgeESG+Nq4M5e8hyAasrZ55J8coEOhRi/1Q0njG6SmUZiGh+ZtGohgSqk4BQRhx7lVFgrrjhb3FyYlxKGNg+ALA+c69DX6ZXZX4ukhwuUcP48cRzp3b2dZcQj1BPurdDuelHmXjPsyHh7myS6lnIs+mZAfa1Q9yBGxfp88V99SiN4kYsj6uHYMWBZxi1O/p1Ph36NcdebukPGaVbedxJ6Sgax6wirEOEdC2qPDvPYSupcHS0Kv7yakW38tyxm0rdzQ0XCh3YqkZzsdw3ECZ8AC6FBxBMFi5Vj5E1TMV0Ps1WDLjrfEItHQ8xPwdaR8xnpJ4xiPEmE3OOhRFgDmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvx6wpstpXyvbg9fQ0PRt/s04VUxwIAdPEUkvwSPzCY=;
 b=YIw0ovYC3+4WLhfnd0u9MWPlqJroFQ2WczQZnOnC/GyzUTzN+x4Gb/aYzd8xxzcPAdIyg7U5oY+PWzoxVr6woXtct1DgWzHrDXmwfi0Y6lb6v7uJg4+KwuyvIAgA7ulqVI0q1VqoUoyzIqoW8HeUzc2RYA1hDbyHLF7RMXDGqRg=
Received: from MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 23:54:49 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::39) by MW4PR03CA0218.outlook.office365.com
 (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.14 via Frontend Transport; Tue, 3 Oct 2023 23:54:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:46 -0500
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
Subject: [PATCH v11 02/10] x86/resctrl: Simplify rftype flag definitions
Date:   Tue, 3 Oct 2023 18:54:22 -0500
Message-ID: <20231003235430.1231238-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003235430.1231238-1-babu.moger@amd.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c30a18-f901-4ad9-0095-08dbc46c211a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX5fzwbZvRWRFsCDMW78QISe9yuhV6AgJYmoLbLQrvZ/O0NetNxJfsJyqL20XVQbCdAo/QWZGNS0ujACInnX0Vr9VGJfkuI1CCWwS1pYkmb1ZTVrpWlSKhOLnor1A5fCvWeRtI5xzBCumBzhBziATghiFT89dgnhWTZBJ/5ijlz0JxjC234Du6n7zNSoOf5q3AzxL+jXB8TEVGji1VGyemF5phx7fIgF6abWTus+BXUqN8uHdlIiAd/X49aL1ATyUDj8xzM6v/qrC+KBO1vyRDN5F0LTexQN4gd1rY7f6oGSETE60zTdfJa6y7HYUW07yTWZEcXqMNKYnmDlAa+7p2PDj6G8/6ynI3uXynrYvWQcDY46gR/VLU8v5uk8CPDYn3O3MrT0N4DzQ5SV2ktYNZDM6ChOrAZ8w+9O9WSBIkmONaGD+6N3Ix3yihLz/T75an2NLJa/cgvz9p7Zw0OnZZnq6eIErqAGuowbBR8Y0CpNPqARhwy/ckdyrRi2ed2RqaSHbt77SUptFr/9hAPkk7u+jcP17gXsqD73X1f77vdXTv+1mb/j7oAfYR6F74XskrIrYGRAy10nU3aRv2mLzBqtAYxLglNT/38KqFEhTWmPJC/ETYoKX5dXqJnP9uwmfjarA8JTpDAXcIIjLkHX8xT6TC22zbzX7O+CW1z52UQ/X/q79mb6poehw1wPhFy81/A0U4zBp4burAvl2/iE/ScseILAbS9kz5i2c/Tx8cjeo2gaCJj/FxxIesAYo9/8cZbXEbC622GI5etq86xaTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(110136005)(6666004)(7696005)(83380400001)(36860700001)(478600001)(1076003)(2616005)(336012)(426003)(16526019)(8676002)(40480700001)(316002)(41300700001)(2906002)(7416002)(70586007)(44832011)(54906003)(70206006)(5660300002)(8936002)(36756003)(4326008)(47076005)(86362001)(81166007)(356005)(7406005)(82740400003)(26005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:49.2357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c30a18-f901-4ad9-0095-08dbc46c211a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

