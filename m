Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D77FE919
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbjK3GX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3GXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:23:25 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C510C6;
        Wed, 29 Nov 2023 22:23:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIxFkRN44tTMBn+5vnXnzEfc4ntlAOP4/YnJhyCGkpr9UgUTFZ+go0E1tG440oGA5lJXqXWHqji3Hygx0yYLB9AkiXnSoRl5zCnzpYWe47y/rtIK9K4+KY8GYPVJxo9zPs+zVQQnCTSUTwbRW2hg3NJllPIERWYDkvaaocVRuhcv57Gdzk2p/kwjY0OW43zAAWIPLWJ4QCU6TZx9ss+kx/4IyO8kMJ28djNPW2i7lR6QVuc57mvKhC+A/DnRbOjiz8RURuSQw0GNdJAPYmBRvOIqP+phayrl1GWq1wHIsOtbhZUn+X28UtUUSuliYhmBMAWgLhDigjyQU/E/Nt8sUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neiPgAnC5Cn+Jbqgsk6HgAn+fPI9D2BIoHx5zTlDrfE=;
 b=VvPT8XzFs91EYk19onlUfUQApwKZ0oCcDBzosaIIDHL5DW44MJTmCsdHmQPZWLntHklAlV0mGmYQ9nlpNrURK3VMp9KPGQfIQkdVCCjxTO05/IJ7vqajlH78uiJNGRVqeTigA/HsTx3Fm9y2/Hci8BRWrsBnaizLrAVy/r+z5K2HOc8dLK4VvuVTziqL8O/YHU/7JXQ15ZUf7B62w7f1s0jSGbpELzOei0EQJrzTIpeZ52ToKzvpBlAZH+G4/5fFJU2OT4h7CqHzyoadcqL4N51pzLLZJMvgP1HPRY1tLVUeDfZhj9t3D+xrZLiqCfd8RFFczYcuFvYaBUF48UyuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neiPgAnC5Cn+Jbqgsk6HgAn+fPI9D2BIoHx5zTlDrfE=;
 b=MfDgRLyu8h7VAdq4RxL4iCu1ZW9TMxgc7U7hXRJ5NDt5NDVr4S85paJGPvVs7ycdwkbiIUXwhOrjlDYWmxLeKsERpiLIcf6iEXtsZ/Lbj1YqV5NfpQjKujQvDofJOmmdyh+zhMIDcA/5d2n2PGGB717qhY/8USrMlb81vuX1RHc=
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 06:23:28 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::31) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 06:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 06:23:25 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 00:23:08 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <eranian@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2] perf/x86/amd: Reject branch stack for IBS events
Date:   Thu, 30 Nov 2023 11:52:46 +0530
Message-ID: <20231130062246.290-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b841a0d-ed68-4f23-ab1b-08dbf16cdc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXrd8069iNkQ0Nd8t5svt4CEgZblByu0V6grF5BkUpZ2tlC2P0jzRDyT0Fpe8oQpwnuRnWQlJf9czr/iMswi/iksSdgn9iL1ArhCkrIl5UcHEPmK0LLFsAp0uCNXnO/wQB9ZNeKaZPA4mY8EzX4iy5nADytd3BPHaG1vV9J4KxLEmZJ9Re1xmzYWpBhsfKkciRqAFeus8eS2Gjon5mk5M7I3EfDtgPZQ7bIEsjaRjTSoubtOr/32NrhxKxBaVGT7K89XGrf9spN1ppx1ufAebWxlLEI3S6HeFyhsoQEaaZoe8Sr+4y3z4U77lZfhn3yu5p6WO9TC3dWRUfJWpDmaa9Q+9SONQV212oz44k8eyk4ntwPQ8p9QESea2o8u3sK7wMD6f8WlQTCZ117EsiZt0geBzR/Es8rlqvGumI9yB/M2Zzfdhr+jGv8WNqFxa/lkoG4Ni0tUl1aJoKwMu4OXqVvfS3OVc2ZPUmAIi7bhgn/SfiAY5iqcyWHRvF1ulOJihhY8QN6ALQtySHflMqT0WOpK/aE7+e9VLOFoMLz3XDO3zpJ1HxHYMLAa7rpgL67Jp/UwAsZy1wiKgAvczstLQnbikaLNspKI3GRYqfeGl5nk1BVqBxPWheSMdqZ3eUc88wruc6UHI3uXvjehmVlL3VpMyqe5L48uPusJUqPD9l0JZdNi4AvYjfAtqXmHIyRaZ+tLAaD30oXBEu2rpDwka1XF7igIxfChfamaMemTOes3J6c5xS9XkEKxEBknyk4klkSnK0ubMS9+NBdEI57PBOLFfVv4aD9JzGzhSbu4laODRAkZ16vZpgBEeXC5lHCN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(4326008)(6666004)(8676002)(7696005)(40460700003)(316002)(110136005)(54906003)(478600001)(966005)(2616005)(2906002)(36860700001)(81166007)(4744005)(47076005)(356005)(36756003)(41300700001)(1076003)(86362001)(44832011)(26005)(70586007)(202311291699003)(40480700001)(336012)(426003)(16526019)(83380400001)(5660300002)(82740400003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 06:23:25.7377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b841a0d-ed68-4f23-ab1b-08dbf16cdc51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The AMD IBS PMU doesn't handle branch stacks, so it should not accept
events with brstack.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1: https://lore.kernel.org/r/20230602194513.1589179-1-namhyung@kernel.org
v1->v2:
 - Rebase on top of peterz/queue/perf/core

 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 6911c5399d02..e91970b01d62 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -287,6 +287,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
-- 
2.34.1

