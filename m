Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A030761CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGYPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGYPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:03:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DB19BA;
        Tue, 25 Jul 2023 08:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD0d6g2mmVjCKz7i+jxwMhKlQEDcngJ4SxSFaf258zKWwf6Jo0DgQqoRrDn9TRGKnCXpYKD/3I+UEzIqb6SR5ooy4lBGm6ILO99CwQeMYKxfijxxmuFLNGu7RMnvtC4RvCKJX8195EY5xPRKHvL/gkZgAW+B0KfyJ5PaPiGWPE9xTYrMDovWw1pk5qgDRfa4W8yNJdkNK2VCnDzbU0exJsZuQDkgr9hmSNQGn29EddBJA+ZC2iQJ/8Ao2sfIPIeSZ2aPVwOBuvO6PL5l5Zn7H/hdHEPZWv0vf50jkLM9wy1CFZ8gEFf7p1+zziv19b8ODazseisft/WoPw+0Fs3ptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLc0MrNmc87nvBLIXmL5fO1yHPPSLX3ElrhDRXkH7vs=;
 b=inaEIQDchKJHKpDQeFtlWJgWmKYH+brNIVlEgdwUluu9yPa8aqMsmKIlZDsUGUuh60gBslm16ZXlLJT/Fu0mq+bVG5qrMXSAGXFQaFRKCAVbgGS7hwzepnJOa2dV1ULadcOVVb31dqMYPkgFbn3bsvSd0+Wdna4DT4alPf2l/2JMRF/OByMdsSNXcYkv/pQGSXx4Y0LVO/WrZYrdmiU3QRm05mZCXdr4KcONPQGycXeSDQRmiMWbttE4fBXABhu1QDpQP1LImCdx6JApgPRVdUauCQ3pTtm4YrambXl8ooJ4135129fqmf9fNqyOvG2HbVkEshuScPGgaLd1XsOt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLc0MrNmc87nvBLIXmL5fO1yHPPSLX3ElrhDRXkH7vs=;
 b=bPR37rgtS6zRRjUtFDi69yQEkbS13/fANtps2q4UpzQZ4/NHd2lAck23GuH05afXJXF/Ae5SxUR1kmY/hIMUzHBlsdmBAcmNGHMQXC305+W8oREQd0rLN1dH5v5x4pdyWf0ASw1AUICKMcjecjW6De6Ph/PIFri9qkDKZxnk3+s=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 15:02:39 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::c0) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Tue, 25 Jul 2023 15:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 15:02:39 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 10:02:32 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RESEND][PATCH v4 1/3] perf/mem: Introduce PERF_MEM_LVLNUM_UNC
Date:   Tue, 25 Jul 2023 20:32:04 +0530
Message-ID: <20230725150206.184-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f3a009-a2f8-4c22-e492-08db8d20308b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeT9Lor0WoiUnBqBOC4HM73ucdWEHx7fFxuAIQegIpMWKPa+w7iA+hzKbAJYz7ErPEiGIr6rbIaDfvjSPjDIaXu46KWjUEXHmGG2YJbrdejWAlsyoF/6IK9WrD5VFQOzVHPYZ3uOqn5Z090OeMUu6esQZZC77uNYLwTFalT41NPSOp0aW0QQTWjdF3L/PL21DX3RWuswQfhOyMbuihzgrZtICgdK9BLcynotEPJuQjXzjfE31H5pedbPHIdc6UpZ132KxiS699dJTM/Wvk50wHAf9GY655emAe8KslGFpDPqo6SZevOhNmW7fAdY/XY47+lC8MNnJHubRtr1b8E5PGqsRvFQl08AT7wh5YOVSdfsuWz4ksei2sOvw/kSYKmBK2Vf/vujjdEeoWNOFk4w9+gYhUDT/t2t72VOqNq45IpsOueugbGjlkuqR+6SK0+e4qBLW86lqrS5UuXZ/3WaveWlIz2rmN2ken7Y3zvA9u6aDsZ+fj91TJjP7dfwKf+rMnvq7I4xPasO5JPGfX28nP8jG6vq6ki7q9zRRZTj0Bbz0hn5tq8YZA6blAOrEH4Ry3ngJCXvlQH5zaEkzADXZtDTqiG0EYuGFTFtFt16xmxOyQbtK4XObMJ/5O0TdQUiJ3SaBlq7513rvgVnV87dEZGMftNx1DI4LVLoh7VrYTLeBlXJqCNguFtBnenpDdiZ6NjUguMOH87HKO1XM3iHVo+5U2qMaV4yUOSX4+BF+XBz5ksP62pId5WjtwZOL6IoGX/GkezQtk6dEqAvNsA80g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(4744005)(2906002)(336012)(1076003)(26005)(186003)(16526019)(4326008)(81166007)(356005)(36860700001)(47076005)(2616005)(426003)(83380400001)(40480700001)(40460700003)(41300700001)(5660300002)(70586007)(44832011)(70206006)(316002)(7416002)(8676002)(36756003)(8936002)(82740400003)(86362001)(110136005)(7696005)(478600001)(54906003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:02:39.4439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f3a009-a2f8-4c22-e492-08db8d20308b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

Older API PERF_MEM_LVL_UNC can be replaced by PERF_MEM_LVLNUM_UNC.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/uapi/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 37675437b768..39c6a250dd1b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1339,7 +1339,8 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x8 available */
+/* 5-0x7 available */
+#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-- 
2.41.0

