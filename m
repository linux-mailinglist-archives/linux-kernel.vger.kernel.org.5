Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A9797F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjIGXvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjIGXvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:51:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB151BCB;
        Thu,  7 Sep 2023 16:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMgW81X3NFQI9Vj7QzYebzysmSveO1+jTyKnqfGBv0YZ7iTW0nOE7xwArJ7NhiEFrcnI/ICKM+3VoboR7NIPLc92hXdEpwnyEx7ef7xLpkBChR/zXsd1HfjpKDDMTZxsJXDWNrQ/7lRvnwu1LpJIZGRXSEKzwAnLuvkrUhPv4V5mZKlxB6sSNYAJZaExMYMtreBLaPPRgGqZMRWdGVughIbh/iBPzf/lAusi7EGGBU/OJrp6JZEXVJTm6kHFjI3vgZLUuJ6g0xkzqCVl6ROND4Pt0wYO9g/GzKmjlyskw2TRTRwjSNI+kNRxUKCBLZfIryixqdyvgLeuN1tTdD2JfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnwcG3l72kLybYiBjLxO5k4/kCMEuedhA0eBwbmELfE=;
 b=QxQd42VWHBO1tsysAd5goZNNH53W25DEJVqU7QD3bRz0IF4/kXzlozl8go2TKMZxmDS8wfQ/EaskFdu4vzygwVTEUNQHBDKD1pFsK0qtvaoO9c+711A31hXHeNMWp8J3vGMnqgyleCNfrTCRQ2IIR2vlH505kxJq+94yMhBD6TdtfAr65k8hXLeUTQV8idjDTvH7kRpxoPm1WfQYPUxNxtkYnJNrUlVkAiFnJf8pVb0UNQWjNTYNNVoOoD5vGBFB0Dcxcwm57/apfUakaE6LJ5bb/HpdXRCsQ5uP9jIevjULhBNmwBARrHJ3eyKdM3oy+IjEun3M3AzpFjGc+551pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnwcG3l72kLybYiBjLxO5k4/kCMEuedhA0eBwbmELfE=;
 b=osLXWcdvzBarYUgRQoARrhN5xoxcmxXYoUzS54F+bB81qa+rDETF1PnJ50wKc8IYv+lBsKpDZVNPvipaXRLixL02+zEZcuPiwim2aVdbfbmoZ47mB6vjM2hMiKpC9wr79QErmSwW+wWk9qgqedRI7lhb0G9f7OSbgE9Uwh0Ezck=
Received: from CY5PR19CA0034.namprd19.prod.outlook.com (2603:10b6:930:1a::13)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 23:51:40 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::6e) by CY5PR19CA0034.outlook.office365.com
 (2603:10b6:930:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:37 -0500
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
Subject: [PATCH v9 2/9] x86/resctrl: Simplify rftype flag definitions
Date:   Thu, 7 Sep 2023 18:51:21 -0500
Message-ID: <20230907235128.19120-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907235128.19120-1-babu.moger@amd.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: f2620c61-4d18-4c19-5a12-08dbaffd6158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rfab8MZGPqYfb3nvW373nlOseLdNa2TSC1MvCsKPGNXAQmUFQIVGJcklmpZ95sLRcOfby0ptl+7uyl3PjYnIMkegB4qlwf6OgrBdpNtq7DPRsEefTzmblj36dUeQW8pQ2/28fSM7BdLD9jpxccJnhmhFO2+C7VazGHXuhYnb5TvZvG8WsnRPWgrkhQMxfyL7M4yFdW6DtdcLuw0CVO+ECqUtNChtKs0kWaTd1AeLEzcq+IYY5uUblRJOqI7YZv5B4d84rFZGWCWilhhJzhK1KzN3QZWzPztcpCCsgRxG0QSlIhBRVxIFypleDZlF2a3iP2tZ15nipOChPJfkYS+YZuK7KRrXGuaqeO3Xr0rcfJIw/p937F7C9u0Mzr+H4AfwMKaIoTn1V5dOQQkjfROzdBsDc93K1JfeZifTQbtzDKqlrwk9tIyrJ/jj6RUcvPHHgAMkg2qQ7aA4DmIvwkPkY/MmhvIr4L8ZvoWl7BViA5pR+We61i9O4yDCWb/KrsscUZIKe1MnXjvnxyf+PniJcAh9oWRCnQ3a3WncGqiov4xXH+ef/VciSBnGP0OGZ/3XHcDm2Xu3F7Dc6oT5eEmqY8+mDSwGQF9b8MsNm0cOa+Q9AU0/o98jDVF5jSwppgLJB/Bo5xqFZNhE3GC4WXGGaWiHi+mLHuxiGJTUV7onIKjWj1me74z0h+Wx8/thCQ8WuK92Bs+bISwucgv1J6TZCG2F/iAYHLXi38ffX5Fvh19USdPEuxScXvPNSDfiAHqb8Vrn3bqIcjkJvufR9BxY+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(81166007)(356005)(6666004)(7696005)(86362001)(36756003)(36860700001)(40480700001)(82740400003)(47076005)(1076003)(2616005)(26005)(426003)(16526019)(336012)(83380400001)(478600001)(41300700001)(110136005)(70586007)(70206006)(8936002)(8676002)(40460700003)(4326008)(5660300002)(2906002)(7416002)(7406005)(44832011)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:39.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2620c61-4d18-4c19-5a12-08dbaffd6158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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

