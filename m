Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF2761CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjGYPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGYPDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:03:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D602D74;
        Tue, 25 Jul 2023 08:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYS54Ivw11+QO0wcqXfei7zVQ1+H8cJmQzwXtlGmLhbItUaIKzZV7jNz5QDg1ZRea/vQkKBxhVex1Y0E/AL7cUwrDo1PJlbJAgIp6wwSsFwPvS4iwe8+rTy6QnOWFX/3qJeq9LoOx8HLuag5t/jIEH2/D7ySzU0Ohiz8waCXPf519oBqZO/CFy7zGVR6Bag97JNnN4LUaWpuWHhp1FGacRrFA2uvkzKxe27Jj3x6XOlV93rBK2VJqLXGr48pLGfEJQ54DF7ZlLkuHoBMu6VXURKaoPjCqdrxQORvMKI6Cs2GisVz2rN929mtzkzT5BVRlnihokXConcRg1Q9T6To3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v63J9FKEXBYgE8Od9XVURsft5vXwac0T3q2gtWD3gQ=;
 b=nBUeOhnrzoxTRs9rQHOtyTToVUWtdf5Y3jnk+zZksogUaU93vTzFVH4CDYMEL0LXHdZIQbipoPA/wb829tpRvyaKYidZNwUz2jwdWW0Opkt6npT497QviZtqX8PEgk6Zfla37gwqin5bYwkylFTaRBHMONZ7fJw0AOn0k8QDNA32lL2V1ANHmi/fieiz985wTVcjeQbaci6jlX5xFMWB91FkCn7CnF4j+y7GABR9PRHMmcU33MIgegWaF+3iXYYHm89PH8BwAjw1Ug6csFtgyCLeRnayW/AAYRvmKLakDBMWsm17pMQMuNVhtgzRkzG6RTzH3OCzABbj0v35zixnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v63J9FKEXBYgE8Od9XVURsft5vXwac0T3q2gtWD3gQ=;
 b=1mlOyS0O9XFxUNhr5XKAHgVPaKq4BQ65xrd56/yfge/qRIz/p3kt2otRETqm3OAAp1k7dWixUWeNra9V7faLd2gwS685INawF21w1+o3nyWP3PrTxHwiuBoG4ltan9Mcs0faFGHad0pyGj+dG9+LSL0cX4J8vbMpAp0qtnP88+o=
Received: from MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 15:02:45 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4b) by MW2PR16CA0058.outlook.office365.com
 (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Tue, 25 Jul 2023 15:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 15:02:45 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 10:02:39 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RESEND][PATCH v4 2/3] perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
Date:   Tue, 25 Jul 2023 20:32:05 +0530
Message-ID: <20230725150206.184-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725150206.184-1-ravi.bangoria@amd.com>
References: <20230725150206.184-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 952d04a6-ab34-432c-6cbe-08db8d203432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqVg+80OV7LAUsZYgkQncWeaTRqJfXhDI4qYRVbR3ZE+m9zV5qNQjiiaWUs0NinfIy9NY0b/0+glvHjEoIRb2myGapbK8sr5IpL7fDyKFWO/gCeuDxKRJPwRc8VRmva40CWOm46Qe+IinTGWrdoKwv+jrAyqn6K5pRVUiDJPJ5lsyD4er8JOc/zPr9xFuK+XTD+aY2UWay+l1aOxUDcBa43nnb6szH57idrCLNNAMM8xjSXZLihBrgHZAHqGHXd2W32p7+svtGSusHZtD9HReilM2LXF+T+XIXQvPUFw2mm+/xrhZsyCplMOALxNIIsJQ8im7/VyORaOERnNxnSB2FA7VPh2E2rELIpB2vmlZ5mAfGvdqAB57mJr5ECc0dhWpeAflLmbLRyOJ80icQ3VBwEYAJyGdBXosBJ9HltvwbbSOngcnY0XDAhbPluXEp0M56DhIF5OUxcaI7uX0wNVuC+vK4Rq4ZStXYL6ZpSwdV/4BpRyQbR2kvyWN+/bJu6f292C7jEDHxCyBgvWJNKd8uyZrPX9WwAFUyBIMdgC4ew/MECJhaCFO8q7KfPgJyvBaFW3NBZ92aTQpBnA3uVk5fBUkOB+PO2eS6Rk4PE6/Ow08S11aJYd9UPJraQAMvFeG3DgVBvKq6rpeINfgDGsxI69rkkXBHUQjetmbxomnK5z2aLn/5DgxrFAWrYDWtYWJ8dYEXP46qW0yXU/sNSxMSnaQKp/BLtd4W0KIg335XyaidVs6I7wabgZXFeJvmm+UPS9x0pEZ6VvXsDvwLJJvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(54906003)(110136005)(478600001)(7696005)(6666004)(83380400001)(36860700001)(36756003)(86362001)(40460700003)(40480700001)(2906002)(4744005)(426003)(2616005)(47076005)(1076003)(16526019)(336012)(186003)(26005)(82740400003)(356005)(70206006)(81166007)(70586007)(4326008)(316002)(41300700001)(44832011)(8676002)(8936002)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:02:45.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952d04a6-ab34-432c-6cbe-08db8d203432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PERF_MEM_LVLNUM_NA wherever PERF_MEM_NA is used to set default values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2166a69e3bf2..dd92b4f5d370 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1194,7 +1194,8 @@ struct perf_sample_data {
 		    PERF_MEM_S(LVL, NA)   |\
 		    PERF_MEM_S(SNOOP, NA) |\
 		    PERF_MEM_S(LOCK, NA)  |\
-		    PERF_MEM_S(TLB, NA))
+		    PERF_MEM_S(TLB, NA)   |\
+		    PERF_MEM_S(LVLNUM, NA))
 
 static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
-- 
2.41.0

