Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E47D3B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJWQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjJWQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:00:46 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1610D1;
        Mon, 23 Oct 2023 09:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw5OKym8eb1sM120uqXUybkxNlNJO50aGr7QdjDKXaXYcxZkM474PofNkKVy/zv3PUw63WissS/FAbmnRRXqjPlZV1BGuFWFwtSCI9rF8GTraHDX8D25heRSFsbwuTiUvMRAnnrv59DQKrrUmJPuR40XW24LzAgdoNmYA4G05ZMN+UbiYFu39g2sN7XgD02bQ0fg+FNASkYXJ8zoUw+Yy8Wzsy48VihPWVF8+hYWuhqm/wgcY/O2n9qXPjq4EWPMSCSSp7eyMrJllHCjLb0Klmsasr6U2AaRSXIBkEwYKJu+vFxyz00bml9yhYo0YsgJSPuWJpck5qtES1HEiO4e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKbpWSI5rdNsAcVT0gIb+6jCCMCBeYe2GrpQggqSXNY=;
 b=myoZGHjWdR8BZ4BcCjQo+Gro5ejchSJFlS5rhAXBqnPP1xk3XQ0lzDWyERlNHXLS4hJ6ElCfGLsIXnZJpEsxWLd96mRu1L6PMuJvw2dLKcsItYOQLCPxYsLAEvapXDKeWkOTwhV4Q0ShoXy3reg2emXd0S99aGOxRaquuXFMLZyBBpbuuX+ODB1LXXRxlMhzUd4jc7YbDBbVMrrw3pYx1akE4xhPfhOobdd/sI5folFtWYJrZFrmVRg/XQHXDX41ur06FDVrzLjIb8Hx9edlOlkaL8hsUhbDX+EOZIJpPHwAnZieL4AoPMlwNddvSi35BYzH/gMoPU92fB8enUqctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKbpWSI5rdNsAcVT0gIb+6jCCMCBeYe2GrpQggqSXNY=;
 b=GsnI0IQg4KaJZEqUEjmLMHvOUW7Y2tcolj/BDPf7azdFvzmGAcYJz7KGZzwTdbFcNFTHoQbPse15jXQ4N1dqGtWQX7Il5gfb3m2TxUyfQ+BfE0d8Q756DJdS+npBmW++nypZKFk6JCJ1nMTV/zs/4U+22WS+Vnd4Bv6yIvqRpVE=
Received: from CY8PR12CA0001.namprd12.prod.outlook.com (2603:10b6:930:4e::24)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 16:00:41 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::62) by CY8PR12CA0001.outlook.office365.com
 (2603:10b6:930:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 16:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 16:00:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 11:00:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <rafael@kernel.org>, <pavel@ucw.cz>,
        <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in amd_pmu_lbr_reset()
Date:   Mon, 23 Oct 2023 11:00:18 -0500
Message-ID: <20231023160018.164054-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023160018.164054-1-mario.limonciello@amd.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a31c1f0-96c5-4c2a-7682-08dbd3e134a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnDU8E0jMpXScECBwwcNfzHnALLCj5smgStDnug8REbs79EYSiTFNtUq0PXn5H4qQd+MC5yMeIeFx6ULyVJlvEr165Wt3NkqYtPzOjhYRNQeCRtCI7/+3TFG1PbUQEFaA2USxl8MRkp6ppVKB7wJtrNO1WxoV1WtlcirVLw5mLc3wsHyL0TnfWPEQeZDADpVP+Wz7x8AMKARotlhlnVBS49XCxtrik9PEtGDPZtPujzNUVClIyVTfBJeC0pfxViz5thLSkjZkkN2GvvgJ90BY0Kl28zstnqvQdCkn5tLRgdYQ960SWoajPXjGHZbAXtTA0GlN3PYN0sm5dJlvySaUksubWJtLiOIKjrMp/8A08OotW9HIffUcZSe+EmXpv3O/kekjlLIoT8LzB7BHACfIU4duRhMRnxUP/C3JyFGOGiiWP8xp8g//Z0NZVixE/m65ewjM7mgJufO6XQNjLWizBh18Mle43l604iPGMFkDuh68KYVhk2T9//xikhcmrzMljtc6pd9Vw71aaclW0dXwmZCjCULpUKzzRQkgekPe7e2OMy3dWbSCDV5NlR2lL3MUM6iP7vG+MZqOVr/9J5ZSOJyCvIHqHCPZrm46w3/PkQ/GujxnHEJp1600MFDs3XgrrFxS3zIcJ8gaYNfmuNw7JPgJF+lpgK7O9cTfoZCfysxw1AnD3ajuqJFFjD62y0Z6N0h8GfnXdZxa/SjNFYp2XbaF+amVDig/SMoX7DtadNjn2n0YvtgPdZa3xNQQjlBXN/Xa5nZk6RfG90IlkuMcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(7416002)(36860700001)(5660300002)(82740400003)(2906002)(356005)(41300700001)(16526019)(7696005)(86362001)(1076003)(336012)(83380400001)(81166007)(26005)(426003)(4326008)(8936002)(47076005)(44832011)(2616005)(36756003)(8676002)(6666004)(478600001)(316002)(70586007)(70206006)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:00:40.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31c1f0-96c5-4c2a-7682-08dbd3e134a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a BUG reported during suspend to ram testing.

```
[  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
[  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
```

Cc: stable@vger.kernel.org # 6.1+
Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/events/amd/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index eb31f850841a..5b98e8c7d8b7 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
 
 void amd_pmu_lbr_reset(void)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
 	int i;
 
 	if (!x86_pmu.lbr_nr)
@@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
+	put_cpu_ptr(&cpu_hw_events);
 	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
 }
 
-- 
2.34.1

